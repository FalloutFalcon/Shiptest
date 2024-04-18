/mob/living/simple_animal/hostile/asteroid/wolf
	name = "white wolf"
	desc = "A beast that survives by feasting on weaker opponents, they're much stronger with numbers. Watch out for the lunge!"
	icon = 'icons/mob/icemoon/icemoon_monsters.dmi'
	icon_state = "whitewolf"
	icon_living = "whitewolf"
	icon_dead = "whitewolf_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	mouse_opacity = MOUSE_OPACITY_ICON
	friendly_verb_continuous = "howls at"
	friendly_verb_simple = "howl at"
	speak_emote = list("howls")
	speed = 25
	move_to_delay = 25
	ranged = 1
	ranged_cooldown_time = 90
	maxHealth = 100
	health = 100
	obj_damage = 15
	melee_damage_lower = 7
	melee_damage_upper = 7
	rapid_melee = 2 // every second attack
	dodging = TRUE
	dodge_prob = 50
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/weapons/bite.ogg'
	vision_range = 7
	aggro_vision_range = 7
	move_force = MOVE_FORCE_WEAK
	move_resist = MOVE_FORCE_WEAK
	pull_force = MOVE_FORCE_WEAK
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 2, /obj/item/stack/sheet/sinew/wolf = 2, /obj/item/stack/sheet/bone = 2, /obj/item/crusher_trophy/wolf_ear = 0.5)
	loot = list()
	crusher_loot = /obj/item/crusher_trophy/wolf_ear
	stat_attack = HARD_CRIT
	knockdown_time = 1 SECONDS
	robust_searching = TRUE
	footstep_type = FOOTSTEP_MOB_CLAW
	var/charging = FALSE
	var/revving_charge = FALSE
	var/charge_range = 10
	/// Message for when the wolf decides to start running away
	var/retreat_message_said = FALSE

/mob/living/simple_animal/hostile/asteroid/wolf/proc/charge(atom/chargeat = target, delay = 10, chargepast = 2)
	if(!chargeat)
		return
	var/chargeturf = get_turf(chargeat)
	if(!chargeturf)
		return
	var/dir = get_dir(src, chargeturf)
	var/turf/T = get_ranged_target_turf(chargeturf, dir, chargepast)
	if(!T)
		return
	charging = TRUE
	revving_charge = TRUE
	walk(src, 0)
	setDir(dir)
	var/obj/effect/temp_visual/decoy/D = new /obj/effect/temp_visual/decoy(loc,src)
	animate(D, alpha = 0, color = "#5a5858", transform = matrix()*2, time = 3)
	SLEEP_CHECK_DEATH(delay)
	revving_charge = FALSE
	var/movespeed = 0.7
	walk_towards(src, T, movespeed)
	SLEEP_CHECK_DEATH(get_dist(src, T) * movespeed)
	walk(src, 0) // cancel the movement
	charging = FALSE

/mob/living/simple_animal/hostile/asteroid/wolf/OpenFire()
	var/tturf = get_turf(target)
	var/dist = get_dist(src, target)
	if(!isturf(tturf) || !isliving(target))
		return
	else if(dist <= charge_range)		//Screen range check, so you can't get charged offscreen
		charge()

/mob/living/simple_animal/hostile/asteroid/wolf/Bump(atom/A)
	. = ..()
	if(charging && isclosedturf(A))				// We slammed into a wall while charging
		wall_slam(A)

/mob/living/simple_animal/hostile/asteroid/wolf/proc/wall_slam(atom/A)
	charging = FALSE
	walk(src, 0)		// Cancel the movement
	if(ismineralturf(A))
		var/turf/closed/mineral/M = A
		if(M.mineralAmt < 7)
			M.mineralAmt++

/mob/living/simple_animal/hostile/asteroid/wolf/Move(atom/newloc)
	if(newloc && newloc.z == z && (islava(newloc) || ischasm(newloc)))
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/asteroid/wolf/adjustHealth(amount, updating_health = TRUE, forced = FALSE)
	. = ..()
	if(stat == DEAD || health > maxHealth*0.1)
		retreat_distance = initial(retreat_distance)
		return
	if(!retreat_message_said && target)
		visible_message("<span class='danger'>The [name] tries to flee from [target]!</span>")
		retreat_message_said = TRUE
	retreat_distance = 30

/mob/living/simple_animal/hostile/asteroid/wolf/gib()
	move_force = MOVE_FORCE_DEFAULT
	move_resist = MOVE_RESIST_DEFAULT
	pull_force = PULL_FORCE_DEFAULT
	if(prob(15))
		new /obj/item/crusher_trophy/wolf_ear(loc)
		visible_message("<span class='warning'>You notice a damaged ear that might be salvagable.</span>")
	..()

/obj/item/crusher_trophy/wolf_ear
	name = "wolf ear"
	desc = "The battered remains of a wolf's ear. You could attach it to a crusher, or use the fur to craft a trophy."
	icon = 'icons/obj/lavaland/elite_trophies.dmi'
	icon_state = "torn_ear"
	denied_type = /obj/item/crusher_trophy/wolf_ear

/obj/item/crusher_trophy/wolf_ear/effect_desc()
	return "waveform collapse to give the user a slight speed boost"

/obj/item/crusher_trophy/wolf_ear/on_mark_detonation(mob/living/target, mob/living/user)
	user.apply_status_effect(/datum/status_effect/speed_boost, 3 SECONDS)

//alpha wolf- smaller chance to spawn, practically a miniboss. Has the ability to do a short, untelegraphed lunge with a stun. Be careful!
/mob/living/simple_animal/hostile/asteroid/wolf/alpha
	name = "alpha wolf"
	desc = "An old wolf with matted, dirty fur and a missing eye, trophies of many won battles and successful hunts. Seems like they're the leader of the pack around here. Watch out for the lunge!"
	icon = 'icons/mob/icemoon/icemoon_monsters.dmi'
	icon_state = "alphawolf"
	icon_living = "alphawolf"
	icon_dead = "alphawolf_dead"
	speed = 15
	move_to_delay = 15
	vision_range = 4
	aggro_vision_range = 12
	maxHealth = 100
	health = 100
	melee_damage_lower = 10
	melee_damage_upper = 10
	dodging = TRUE
	dodge_prob = 75
	charger = TRUE
	charge_distance = 7
	knockdown_time = 1 SECONDS
	charge_frequency = 20 SECONDS
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 2, /obj/item/stack/sheet/sinew/wolf = 4, /obj/item/stack/sheet/sinew/wolf = 4, /obj/item/stack/sheet/bone = 5)
	loot = list()
	crusher_loot = /obj/item/crusher_trophy/fang

/mob/living/simple_animal/hostile/asteroid/wolf/alpha/gib()
	move_force = MOVE_FORCE_DEFAULT
	move_resist = MOVE_RESIST_DEFAULT
	pull_force = PULL_FORCE_DEFAULT
	if(prob(75))
		new /obj/item/crusher_trophy/fang(loc)
		visible_message("<span class='warning'>You find an intact fang that looks salvagable.</span>")
	..()

/obj/item/crusher_trophy/fang
	name = "battle-stained fang"
	desc = "A wolf fang, displaying the wear and tear associated with a long and colorful life. Could be attached to a kinetic crusher or used to make a trophy."
	icon = 'icons/obj/lavaland/elite_trophies.dmi'
	icon_state = "fang"
	denied_type = /obj/item/crusher_trophy/fang
	var/bleed_stacks_per_hit = 5

/obj/item/crusher_trophy/fang/effect_desc()
	return "waveform collapse to build up a small stack of bleeding, causing a burst of damage if applied repeatedly."

/obj/item/crusher_trophy/fang/on_mark_detonation(mob/living/M, mob/living/user)
	if(istype(M) && (M.mob_biotypes & MOB_ORGANIC))
		var/datum/status_effect/stacking/saw_bleed/bloodletting/B = M.has_status_effect(/datum/status_effect/stacking/saw_bleed/bloodletting)
		if(!B)
			M.apply_status_effect(/datum/status_effect/stacking/saw_bleed/bloodletting, bleed_stacks_per_hit)
		else
			B.add_stacks(bleed_stacks_per_hit)

/mob/living/simple_animal/hostile/asteroid/wolf/random/Initialize()
	. = ..()
	if(prob(15))
		new /mob/living/simple_animal/hostile/asteroid/wolf/alpha(loc)
		return INITIALIZE_HINT_QDEL
