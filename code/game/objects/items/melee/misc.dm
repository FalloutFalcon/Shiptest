/obj/item/melee
	item_flags = NEEDS_PERMIT
	icon = 'icons/obj/weapon/misc.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'

/obj/item/melee/proc/check_martial_counter(mob/living/carbon/human/target, mob/living/carbon/human/user)
	if(target.check_block())
		target.visible_message("<span class='danger'>[target.name] blocks [src] and twists [user]'s arm behind [user.p_their()] back!</span>",
					"<span class='userdanger'>You block the attack!</span>")
		user.Stun(40)
		return TRUE

/obj/item/melee/chainofcommand
	name = "chain of command"
	desc = "A tool used by great men to placate the frothing masses."
	icon_state = "chain"
	item_state = "chain"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	force = 10
	throwforce = 7
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("flogged", "whipped", "lashed", "disciplined")
	hitsound = 'sound/weapons/chainhit.ogg'
	custom_materials = list(/datum/material/iron = 1000)

/obj/item/melee/synthetic_arm_blade
	name = "synthetic arm blade"
	desc = "A grotesque blade that on closer inspection seems to be made out of synthetic flesh, it still feels like it would hurt very badly as a weapon."
	icon = 'icons/obj/changeling_items.dmi'
	icon_state = "arm_blade"
	item_state = "arm_blade"
	lefthand_file = 'icons/mob/inhands/antag/changeling_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/changeling_righthand.dmi'
	w_class = WEIGHT_CLASS_HUGE
	force = 20
	throwforce = 10
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	sharpness = IS_SHARP

/obj/item/melee/synthetic_arm_blade/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 60, 80) //very imprecise



/obj/item/melee/curator_whip
	name = "curator's whip"
	desc = "Somewhat eccentric and outdated, it still stings like hell to be hit by."
	icon_state = "whip"
	item_state = "chain"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	force = 15
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("flogged", "whipped", "lashed", "disciplined")
	hitsound = 'sound/weapons/whip.ogg'

/obj/item/melee/curator_whip/afterattack(target, mob/user, proximity_flag)
	. = ..()
	if(ishuman(target) && proximity_flag)
		var/mob/living/carbon/human/H = target
		H.drop_all_held_items()
		H.visible_message("<span class='danger'>[user] disarms [H]!</span>", "<span class='userdanger'>[user] disarmed you!</span>")

/obj/item/melee/cleric_mace
	name = "cleric mace"
	desc = "The grandson of the club, yet the grandfather of the baseball bat. Most notably used by holy orders in days past."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "mace_greyscale"
	item_state = "mace_greyscale"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	material_flags = MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS //Material type changes the prefix as well as the color.
	custom_materials = list(/datum/material/iron = 12000)  //Defaults to an Iron Mace.
	slot_flags = ITEM_SLOT_BELT
	force = 14
	w_class = WEIGHT_CLASS_BULKY
	throwforce = 8
	armour_penetration = 50
	attack_verb = list("smacked", "struck", "cracked", "beaten")
	var/overlay_state = "mace_handle"
	var/mutable_appearance/overlay

/obj/item/melee/cleric_mace/Initialize()
	. = ..()
	overlay = mutable_appearance(icon, overlay_state)
	overlay.appearance_flags = RESET_COLOR
	add_overlay(overlay)

/obj/item/kitchen/knife/letter_opener
	name = "letter opener"
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "letter_opener"
	desc = "A military combat utility survival knife."
	embedding = list("pain_mult" = 4, "embed_chance" = 65, "fall_chance" = 10, "ignore_throwspeed_threshold" = TRUE)
	force = 15
	throwforce = 15
	unique_reskin = list("Traditional" = "letter_opener",
						"Boxcutter" = "letter_opener_b",
						"Corporate" = "letter_opener_a"
						)
/obj/item/melee/weebstick
	name = "Weeb Stick"
	desc = "Glorious nippon steel, folded 1000 times."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "weeb_blade"
	item_state = "weeb_blade"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	pickup_sound =  'sound/items/handling/knife2_pickup.ogg'
	drop_sound = 'sound/items/handling/metal_drop.ogg'
	flags_1 = CONDUCT_1
	obj_flags = UNIQUE_RENAME
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	sharpness = IS_SHARP_ACCURATE
	force = 25
	throw_speed = 4
	throw_range = 5
	throwforce = 12
	block_chance = 20
	armour_penetration = 50
	hitsound = 'sound/weapons/anime_slash.ogg'
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "diced", "cut")

/obj/item/melee/weebstick/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 25, 90, 5) //Not made for scalping victims, but will work nonetheless

/obj/item/melee/weebstick/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if(attack_type == PROJECTILE_ATTACK)
		final_block_chance = block_chance / 2 //Pretty good...
	return ..()

/obj/item/melee/weebstick/on_exit_storage(datum/component/storage/concrete/S)
	var/obj/item/storage/belt/weebstick/B = S.real_location()
	if(istype(B))
		playsound(B, 'sound/items/unsheath.ogg', 25, TRUE)

/obj/item/melee/weebstick/on_enter_storage(datum/component/storage/concrete/S)
	var/obj/item/storage/belt/weebstick/B = S.real_location()
	if(istype(B))
		playsound(B, 'sound/items/sheath.ogg', 25, TRUE)

/obj/item/storage/belt/weebstick
	name = "nanoforged blade sheath"
	desc = "It yearns to bath in the blood of your enemies... but you hold it back!"
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "weeb_sheath"
	item_state = "sheath"
	w_class = WEIGHT_CLASS_BULKY
	force = 3
	var/primed = FALSE //Prerequisite to anime bullshit
	// ##The anime bullshit## - Mostly stolen from action/innate/dash
	var/dash_sound = 'sound/weapons/unsheathed_blade.ogg'
	var/beam_effect = "blood_beam"
	var/phasein = /obj/effect/temp_visual/dir_setting/cult/phase
	var/phaseout = /obj/effect/temp_visual/dir_setting/cult/phase

/obj/item/storage/belt/weebstick/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 1
	STR.use_sound = null
	STR.max_w_class = WEIGHT_CLASS_BULKY
	STR.set_holdable(list(
		/obj/item/melee/weebstick
		))

/obj/item/storage/belt/weebstick/examine(mob/user)
	. = ..()
	if(length(contents))
		. += "<span class='notice'>Use [src] in-hand to prime for an opening strike."
		. += "<span class='info'>Alt-click it to quickly draw the blade.</span>"

/obj/item/storage/belt/weebstick/AltClick(mob/user)
	if(!iscarbon(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)) || primed)
		return
	if(length(contents))
		var/obj/item/I = contents[1]
		playsound(user, dash_sound, 25, TRUE)
		user.visible_message("<span class='notice'>[user] swiftly draws \the [I].</span>", "<span class='notice'>You draw \the [I].</span>")
		user.put_in_hands(I)
		update_appearance()
	else
		to_chat(user, "<span class='warning'>[src] is empty!</span>")

/obj/item/storage/belt/weebstick/attack_self(mob/user)
	if(!iscarbon(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	if(length(contents))
		var/datum/component/storage/CP = GetComponent(/datum/component/storage)
		if(primed)
			CP.locked = FALSE
			playsound(user, 'sound/items/sheath.ogg', 25, TRUE)
			to_chat(user, "<span class='notice'>You return your stance.</span>")
			primed = FALSE
			update_appearance()
		else
			CP.locked = TRUE //Prevents normal removal of the blade while primed
			playsound(user, 'sound/items/unsheath.ogg', 25, TRUE)
			user.visible_message("<span class='warning'>[user] grips the blade within [src] and primes to attack.</span>", "<span class='warning'>You take an opening stance...</span>", "<span class='warning'>You hear a weapon being drawn...</span>")
			primed = TRUE
			update_appearance()
	else
		to_chat(user, "<span class='warning'>[src] is empty!</span>")

/obj/item/storage/belt/weebstick/afterattack(atom/A, mob/living/user, proximity_flag, params)
	. = ..()
	if(primed && length(contents))
		if(!(A in view(user.client.view, user)))
			return
		var/obj/item/I = contents[1]
		if(!user.put_in_inactive_hand(I))
			to_chat(user, "<span class='warning'>You need a free hand!</span>")
			return
		var/datum/component/storage/CP = GetComponent(/datum/component/storage)
		CP.locked = FALSE
		primed = FALSE
		update_appearance()
		primed_attack(A, user)
		if(CanReach(A, I))
			I.melee_attack_chain(user, A, params)
		user.swap_hand()

/obj/item/storage/belt/weebstick/proc/primed_attack(atom/target, mob/living/user)
	var/turf/end = get_turf(user)
	var/turf/start = get_turf(user)
	var/obj/spot1 = new phaseout(start, user.dir)
	var/halt = FALSE
	// Stolen dash code
	for(var/T in getline(start, get_turf(target)))
		var/turf/tile = T
		for(var/mob/living/victim in tile)
			if(victim != user)
				playsound(victim, 'sound/weapons/anime_slash.ogg', 10, TRUE)
				victim.take_bodypart_damage(15)
		// Unlike actual ninjas, we stop noclip-dashing here.
		if(isclosedturf(T))
			halt = TRUE
		for(var/obj/O in tile)
			// We ignore mobs as we are cutting through them
			if(!O.CanPass(user, tile))
				halt = TRUE
		if(halt)
			break
		else
			end = T
	user.forceMove(end) // YEET
	playsound(start, dash_sound, 35, TRUE)
	var/obj/spot2 = new phasein(end, user.dir)
	spot1.Beam(spot2, beam_effect, time=20)
	user.visible_message("<span class='warning'>In a flash of red, [user] draws [user.p_their()] blade!</span>", "<span class='notice'>You dash forward while drawing your weapon!</span>", "<span class='warning'>You hear a blade slice through the air at impossible speeds!</span>")

/obj/item/storage/belt/weebstick/update_icon_state()
	icon_state = "weeb_sheath"
	item_state = "sheath"
	if(contents.len)
		if(primed)
			icon_state += "-primed"
		else
			icon_state += "-blade"
		item_state += "-sabre"
	return ..()

/obj/item/storage/belt/weebstick/PopulateContents()
	//Time to generate names now that we have the sword
	var/n_title = pick(GLOB.ninja_titles)
	var/n_name = pick(GLOB.ninja_names)
	var/obj/item/melee/weebstick/sword = new /obj/item/melee/weebstick(src)
	sword.name = "[n_title] blade of clan [n_name]"
	name = "[n_title] scabbard of clan [n_name]"
	update_appearance()

/obj/item/melee/baseball_bat
	name = "baseball bat"
	desc = "There ain't a skull in the league that can withstand a swatter."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "baseball_bat"
	item_state = "baseball_bat"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	force = 12
	throwforce = 12
	attack_verb = list("beat", "smacked")
	custom_materials = list(/datum/material/wood = MINERAL_MATERIAL_AMOUNT * 3.5)
	w_class = WEIGHT_CLASS_HUGE
	var/homerun_ready = 0
	var/homerun_able = 0

/obj/item/melee/baseball_bat/homerun
	name = "home run bat"
	desc = "This thing looks dangerous... Dangerously good at baseball, that is."
	homerun_able = 1

/obj/item/melee/baseball_bat/attack_self(mob/user)
	if(!homerun_able)
		..()
		return
	if(homerun_ready)
		to_chat(user, "<span class='warning'>You're already ready to do a home run!</span>")
		..()
		return
	to_chat(user, "<span class='warning'>You begin gathering strength...</span>")
	playsound(get_turf(src), 'sound/magic/lightning_chargeup.ogg', 65, TRUE)
	if(do_after(user, 90, target = src))
		to_chat(user, "<span class='userdanger'>You gather power! Time for a home run!</span>")
		homerun_ready = 1
	..()

/obj/item/melee/baseball_bat/attack(mob/living/target, mob/living/user)
	. = ..()
	var/atom/throw_target = get_edge_target_turf(target, user.dir)
	if(homerun_ready)
		user.visible_message("<span class='userdanger'>It's a home run!</span>")
		target.throw_at(throw_target, rand(8,10), 14, user)
		SSexplosions.medturf += throw_target
		playsound(get_turf(src), 'sound/weapons/homerun.ogg', 100, TRUE)
		homerun_ready = 0
		return
	else if(!target.anchored)
		target.throw_at(throw_target, rand(1,2), 2, user, gentle = TRUE)

/obj/item/melee/baseball_bat/ablative
	name = "metal baseball bat"
	desc = "This bat is made of highly reflective, highly armored material."
	icon_state = "baseball_bat_metal"
	item_state = "baseball_bat_metal"
	force = 12
	throwforce = 15

/obj/item/melee/baseball_bat/bone
	name = "bone club"
	desc = "A long and hard shaft of rock solid bone." // I am the master of comedy
	icon_state = "baseball_bat_bone"
	item_state = "baseball_bat_bone"

/obj/item/melee/baseball_bat/ablative/IsReflect()//some day this will reflect thrown items instead of lasers
	var/picksound = rand(1,2)
	var/turf = get_turf(src)
	if(picksound == 1)
		playsound(turf, 'sound/weapons/effects/batreflect1.ogg', 50, TRUE)
	if(picksound == 2)
		playsound(turf, 'sound/weapons/effects/batreflect2.ogg', 50, TRUE)
	return 1

/obj/item/melee/flyswatter
	name = "flyswatter"
	desc = "Useful for killing insects of all sizes."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "flyswatter"
	item_state = "flyswatter"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	force = 1
	throwforce = 1
	attack_verb = list("swatted", "smacked")
	hitsound = 'sound/effects/snap.ogg'
	w_class = WEIGHT_CLASS_SMALL
	//Things in this list will be instantly splatted.  Flyman weakness is handled in the flyman species weakness proc.
	var/list/strong_against

/obj/item/melee/flyswatter/Initialize()
	. = ..()
	strong_against = typecacheof(list(
					/mob/living/simple_animal/hostile/poison/bees/,
					/mob/living/simple_animal/butterfly,
					/mob/living/simple_animal/hostile/cockroach,
					/obj/item/queen_bee
	))

/obj/item/melee/flyswatter/afterattack(atom/target, mob/user, proximity_flag)
	. = ..()
	if(proximity_flag)
		if(is_type_in_typecache(target, strong_against))
			new /obj/effect/decal/cleanable/insectguts(target.drop_location())
			to_chat(user, "<span class='warning'>You easily splat the [target].</span>")
			if(istype(target, /mob/living/))
				var/mob/living/bug = target
				bug.death(1)
			else
				qdel(target)
