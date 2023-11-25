#define DECONSTRUCT_STAMINA_MINIMUM 50
#define DECONSTRUCT_STAMINA_USE 40

/obj/structure/lathe
	name = "Machine Lathe"
	desc = "You could make alot of things with this."
	icon = 'icons/obj/guncrafting.dmi'
	icon_state = "lathe"
	density = TRUE
	anchored = FALSE
	var/obj/item/work_piece = FALSE
	var/obj/item/blueprint/blueprint = FALSE
	var/steps_left = 0
	//Whether there is an active job on the table
	var/in_progress = FALSE
	//Defines what job type its currently working on
	var/mode = FALSE
	//If activily doing a do untill loop
	var/working = FALSE

/obj/structure/lathe/Initialize()
	AddComponent(/datum/component/material_container, list(/datum/material/iron, /datum/material/glass, /datum/material/silver, /datum/material/plasma, /datum/material/gold, /datum/material/diamond, /datum/material/plastic, /datum/material/uranium, /datum/material/bananium, /datum/material/titanium, /datum/material/bluespace), INFINITY, FALSE, null, null, null, TRUE)
	. = ..()


/obj/structure/lathe/examine(mob/user)
	. = ..()
	if(steps_left)
		. += "\nThere are [steps_left] steps left."

/obj/structure/lathe/AltClick(mob/user)
	if(in_progress)
		to_chat(user, "The lathe is currently in use.")
		return
	remove_part(user)

/obj/structure/lathe/attack_hand(mob/living/carbon/human/user)
	if(!mode)
		var/list/choose_options = list()
		choose_options += list("Deconstruct" = image(icon = 'icons/obj/tools.dmi', icon_state = "welder"))
		choose_options += list("Research" = image(icon = 'icons/obj/tools.dmi', icon_state = "analyzer"))
		choose_options += list("Fabricate" = image(icon = 'icons/obj/tools.dmi', icon_state = "wrench"))
		mode = show_radial_menu(user, src, choose_options, radius = 38, require_near = TRUE)
	if(mode && !working)
		if(mode == "Deconstruct")
			if(!work_piece)
				to_chat(user, "There is no item on the lathe.")
				return
			deconstruct_part(user)
		if(mode == "Research")
			if(!work_piece)
				to_chat(user, "There is no item on the lathe.")
				return
			research_part(user)
		if(mode == "Fabricate")
			if(!blueprint)
				to_chat(user, "There is no blueprint on the lathe.")
				return
			fabricate_part(user)

/obj/structure/lathe/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/blueprint))
		if(blueprint)
			to_chat(user, "You cant add another blueprint to the lathe.")
			return
		I.forceMove(src)
		blueprint = I
		return
	if(work_piece)
		to_chat(user, "You cant add another item to the lathe.")
		return
	if(istype(I, /obj/item))
		I.forceMove(src)
		work_piece = I
		work_piece.vis_flags |= VIS_INHERIT_ID
		vis_contents += work_piece

/obj/structure/lathe/proc/remove_part(mob/user)
	if(work_piece)
		vis_contents -= work_piece
		work_piece.forceMove(drop_location())
		if(Adjacent(user) && !issilicon(user))
			user.put_in_hands(work_piece)
		work_piece = FALSE
		in_progress = FALSE
		mode = FALSE

/obj/structure/lathe/proc/destroy_part(mob/user)
	if(work_piece)
		vis_contents -= work_piece
		qdel(work_piece)
		work_piece = FALSE
		in_progress = FALSE
		mode = FALSE

/////////////////
// DECONSTRUCT //
/////////////////

/obj/structure/lathe/proc/deconstruct_part(mob/living/carbon/human/user)
	if(!in_progress)
		in_progress = TRUE
		steps_left = 3
	working = TRUE
	if(do_after(user, 20, work_piece))
		if(steps_left > 1)
			steps_left--
			playsound(src,'sound/items/welder2.ogg',50,TRUE)
			to_chat(user, "You have [steps_left] steps left.")
			user.adjustStaminaLoss(DECONSTRUCT_STAMINA_USE)
			deconstruct_part(user)
		else
			scrap_item(work_piece)
	working = FALSE

/obj/structure/lathe/proc/scrap_item(mob/user)
	to_chat(user, "The [work_piece.name] is broken down into parts.")
	playsound(src,'sound/items/welder.ogg',50,TRUE)
	if(istype (work_piece, /obj/item/modgun))
		var/obj/item/new_part = new /obj/item/part/gun
		new_part.forceMove(drop_location())
	var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)
	var/material_amount = materials.get_item_material_amount(work_piece)
	if(material_amount)
		materials.insert_item(work_piece)
		materials.retrieve_all()
	destroy_part(user)

//////////////
// RESEARCH //
//////////////

/obj/structure/lathe/proc/research_part(mob/living/carbon/human/user)
	if(!in_progress)
		in_progress = TRUE
		steps_left = 3
	working = TRUE
	if(do_after(user, 20, work_piece))
		if(steps_left > 1)
			steps_left--
			playsound(src,'sound/items/welder2.ogg',50,TRUE)
			to_chat(user, "You have [steps_left] steps left.")
			user.adjustStaminaLoss(DECONSTRUCT_STAMINA_USE)
			research_part(user)
		else
			var/obj/item/blueprint/blueprint = new /obj/item/blueprint
			blueprint.desc += "\nA blueprint on [work_piece.name]."
			blueprint.design = work_piece
			blueprint.forceMove(drop_location())
			if(Adjacent(user) && !issilicon(user))
				user.put_in_hands(blueprint)
			remove_part(user)
	working = FALSE

///////////////
// FABRICATE //
///////////////

/obj/structure/lathe/proc/fabricate_part(mob/living/carbon/human/user)
	if(blueprint)
		var/obj/item/new_part = new blueprint.design(loc)
		new_part.forceMove(drop_location())
		if(Adjacent(user) && !issilicon(user))
			user.put_in_hands(new_part)


///////////
// ITEMS //
///////////

/obj/item/stack/gun_part
	name = "Gun Part"
	desc = "This could fabcricate metal parts."
	icon = 'icons/obj/guncrafting.dmi'
	icon_state = "work_piece"
	max_amount = 10

/obj/item/modgun
	name = "gun"
	desc = "A gun."
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "detective"
	item_state = "gun"
	var/caliber = 357
	var/gun_parts = list()

/obj/item/blueprint
	name = "Blueprint"
	desc = "This could be used to make a gun."
	icon = 'icons/obj/guncrafting.dmi'
	icon_state = "blueprint"
	var/design = FALSE
	var/blueprint = FALSE
