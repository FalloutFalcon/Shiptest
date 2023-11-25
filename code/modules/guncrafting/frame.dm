/obj/item/part/gun/frame
	name = "gun frame"
	desc = "a generic gun frame. consider debug"
	icon_state = "frame_olivaw"
	generic = FALSE
	var/result = /obj/item/modgun

	// Currently installed grip
	var/obj/item/part/gun/modular/grip/InstalledGrip
	// Which grips does the frame accept?
	var/list/gripvars = list(/obj/item/part/gun/modular/grip/wood, /obj/item/part/gun/modular/grip/black)

	// What are the results (in order relative to gripvars)?
	var/list/resultvars = list(/obj/item/modgun, /obj/item/modgun)

	// Currently installed mechanism
	var/obj/item/part/gun/modular/grip/InstalledMechanism
	// Which mechanism the frame accepts?
	//var/list/mechanismvar = /obj/item/part/gun/modular/mechanism

	// Currently installed barrel
	var/obj/item/part/gun/modular/barrel/InstalledBarrel
	// Which barrels does the frame accept?
	var/list/barrelvars = list(/obj/item/part/gun/modular/barrel)

	// Bonuses from forging/type or maluses from printing
	var/cheap = FALSE // Set this to true for cheap variants

/obj/item/part/gun/frame/New(loc, ...)
	. = ..()
	var/obj/item/modgun/G = new result(null)

/obj/item/part/gun/frame/New(loc)
	..()
	var/spawn_with_preinstalled_parts = FALSE

	if(spawn_with_preinstalled_parts)
		var/list/parts_list = list("mechanism", "barrel", "grip")

		pick_n_take(parts_list)
		if(prob(50))
			pick_n_take(parts_list)

		for(var/part in parts_list)
			switch(part)
				if("mechanism")
					InstalledMechanism = new mechanismvar(src)
				if("barrel")
					var/select = pick(barrelvars)
					InstalledBarrel = new select(src)
				if("grip")
					var/select = pick(gripvars)
					InstalledGrip = new select(src)
					/*
					var/variantnum = gripvars.Find(select)
					result = resultvars[variantnum]
					*/

/obj/item/part/gun/frame/proc/eject_item(obj/item/I, mob/living/user)
	if(!I || !user.IsAdvancedToolUser() || user.stat || !user.Adjacent(I))
		return FALSE
	user.put_in_hands(I)
	playsound(src.loc, 'sound/weapons/gun/pistol/mag_insert_alt.ogg', 75, 1)
	user.visible_message(
		"[user] removes [I] from [src].",
		span_notice("You remove [I] from [src].")
	)
	return TRUE

/obj/item/part/gun/frame/proc/insert_item(obj/item/I, mob/living/user)
	if(!I || !istype(user) || user.stat)
		return FALSE
	I.forceMove(src)
	playsound(src.loc, 'sound/weapons/gun/pistol/mag_release_alt.ogg', 75, 1)
	to_chat(user, span_notice("You insert [I] into [src]."))
	return TRUE

/obj/item/part/gun/frame/proc/replace_item(obj/item/I_old, obj/item/I_new, mob/living/user)
	if(!I_old || !I_new || !istype(user) || user.stat || !user.Adjacent(I_new) || !user.Adjacent(I_old))
		return FALSE
	I_new.forceMove(src)
	user.put_in_hands(I_old)
	playsound(src.loc, 'sound/weapons/gun/pistol/mag_release_alt.ogg', 75, 1)
	spawn(2)
		playsound(src.loc, 'sound/weapons/gun/pistol/mag_insert_alt.ogg', 75, 1)
	user.visible_message(
		"[user] replaces [I_old] with [I_new] in [src].",
		span_notice("You replace [I_old] with [I_new] in [src]."))
	return TRUE

/obj/item/part/gun/frame/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/part/gun/modular/grip))
		if(InstalledGrip)
			to_chat(user, span_warning("[src] already has a grip attached!"))
			return
		else
			handle_gripvar(I, user)

	if(istype(I, /obj/item/part/gun/modular/mechanism))
		if(InstalledMechanism)
			to_chat(user, span_warning("[src] already has a mechanism attached!"))
			return
		else
			handle_mechanismvar(I, user)

	if(istype(I, /obj/item/part/gun/modular/barrel))
		if(InstalledBarrel)
			to_chat(user, span_warning("[src] already has a barrel attached!"))
			return
		else
			handle_barrelvar(I, user)

	if(I.tool_behaviour == TOOL_SCREWDRIVER)
		var/list/possibles = contents.Copy()
		var/obj/item/part/gun/toremove = input("Which part would you like to remove?","Removing parts") in possibles
		if(!toremove)
			return
		if(I.use_tool(src, user, 40, volume=50))
			eject_item(toremove, user)
			if(istype(toremove, /obj/item/part/gun/modular/grip))
				InstalledGrip = null
			else if(istype(toremove, /obj/item/part/gun/modular/barrel))
				InstalledBarrel = FALSE
			else if(istype(toremove, /obj/item/part/gun/modular/mechanism))
				InstalledMechanism = FALSE

	return ..()

/obj/item/part/gun/frame/proc/handle_gripvar(obj/item/I, mob/living/user)
	if(I.type in gripvars)
		if(insert_item(I, user))
			/*
			var/variantnum = gripvars.Find(I.type)
			result = resultvars[variantnum]
			*/
			InstalledGrip = I
			to_chat(user, span_notice("You have attached the grip to \the [src]."))
			return
	else
		to_chat(user, span_warning("This grip does not fit!"))
		return

/obj/item/part/gun/frame/proc/handle_mechanismvar(obj/item/I, mob/living/user)
	if(I.type == mechanismvar)
		if(insert_item(I, user))
			InstalledMechanism = I
			to_chat(user, span_notice("You have attached the mechanism to \the [src]."))
			return
	else
		to_chat(user, span_warning("This mechanism does not fit!"))
		return

/obj/item/part/gun/frame/proc/handle_barrelvar(obj/item/I, mob/living/user)
	if(I.type in barrelvars)
		if(insert_item(I, user))
			InstalledBarrel = I
			to_chat(user, span_notice("You have attached the barrel to \the [src]."))
			return
	else
		to_chat(user, span_warning("This barrel does not fit!"))
		return

/obj/item/part/gun/frame/attack_self(mob/user)
	. = ..()
	var/turf/T = get_turf(src)
	if(!InstalledGrip)
		to_chat(user, span_warning("\the [src] does not have a grip!"))
		return
	if(!InstalledMechanism)
		to_chat(user, span_warning("\the [src] does not have a mechanism!"))
		return
	if(!InstalledBarrel)
		to_chat(user, span_warning("\the [src] does not have a barrel!"))
		return
	var/obj/item/modgun/G = new result(T)
	if(barrelvars.len > 1 && istype(G, /obj/item/modgun))
		var/obj/item/modgun/P = G
		P.caliber = InstalledBarrel.caliber
		G.gun_parts = list(src.type = 1, InstalledGrip.type = 1, InstalledMechanism.type = 1, InstalledBarrel.type = 1)
	qdel(src)
	return

/obj/item/part/gun/frame/examine(user, distance)
	. = ..()
	if(.)
		if(InstalledGrip)
			to_chat(user, span_notice("\the [src] has \a [InstalledGrip] installed."))
		else
			to_chat(user, span_notice("\the [src] does not have a grip installed."))
		if(InstalledMechanism)
			to_chat(user, span_notice("\the [src] has \a [InstalledMechanism] installed."))
		else
			to_chat(user, span_notice("\the [src] does not have a mechanism installed."))
		if(InstalledBarrel)
			to_chat(user, span_notice("\the [src] has \a [InstalledBarrel] installed."))
		else
			to_chat(user, span_notice("\the [src] does not have a barrel installed."))
