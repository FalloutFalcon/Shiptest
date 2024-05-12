/* Filing cabinets!
 * Contains:
 *		Filing Cabinets
 *		Security Record Cabinets
 *		Medical Record Cabinets
 *		Employment Contract Cabinets
 */


/*
 * Filing Cabinets
 */
/obj/structure/filingcabinet
	name = "filing cabinet"
	desc = "A large cabinet with drawers."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "filingcabinet"
	density = TRUE
	anchored = TRUE

/obj/structure/filingcabinet/chestdrawer
	name = "chest drawer"
	icon_state = "chestdrawer"

/obj/structure/filingcabinet/chestdrawer/wheeled
	name = "rolling chest drawer"
	desc = "A small cabinet with drawers. This one has wheels!"
	anchored = FALSE

/obj/structure/filingcabinet/filingcabinet	//not changing the path to avoid unnecessary map issues, but please don't name stuff like this in the future -Pete
	icon_state = "tallcabinet"

/obj/structure/filingcabinet/wide
	icon_state = "widecabinet"

/obj/structure/filingcabinet/double
	name = "filing cabinets"
	icon_state = "doublefilingcabinet"

/obj/structure/filingcabinet/double/grey
	icon_state = "doubletallcabinet"

/obj/structure/filingcabinet/double/grey
	icon_state = "doublewidecabinet"

/obj/structure/filingcabinet/Initialize(mapload)
	. = ..()
	if(mapload)
		for(var/obj/item/I in loc)
			if(I.w_class < WEIGHT_CLASS_NORMAL) //there probably shouldn't be anything placed ontop of filing cabinets in a map that isn't meant to go in them
				I.forceMove(src)

/obj/structure/filingcabinet/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		new /obj/item/stack/sheet/metal(loc, 2)
		for(var/obj/item/I in src)
			I.forceMove(loc)
	qdel(src)

/obj/structure/filingcabinet/attackby(obj/item/P, mob/user, params)
	if(P.tool_behaviour == TOOL_WRENCH && user.a_intent != INTENT_HELP)
		to_chat(user, "<span class='notice'>You begin to [anchored ? "unwrench" : "wrench"] [src].</span>")
		if(P.use_tool(src, user, 20, volume=50))
			to_chat(user, "<span class='notice'>You successfully [anchored ? "unwrench" : "wrench"] [src].</span>")
			set_anchored(!anchored)
	else if(P.w_class < WEIGHT_CLASS_NORMAL)
		if(!user.transferItemToLoc(P, src))
			return
		to_chat(user, "<span class='notice'>You put [P] in [src].</span>")
		icon_state = "[initial(icon_state)]-open"
		sleep(5)
		icon_state = initial(icon_state)
		updateUsrDialog()
	else if(user.a_intent != INTENT_HARM)
		to_chat(user, "<span class='warning'>You can't put [P] in [src]!</span>")
	else
		return ..()


/obj/structure/filingcabinet/ui_interact(mob/user)
	. = ..()
	if(contents.len <= 0)
		to_chat(user, "<span class='notice'>[src] is empty.</span>")
		return

	var/dat = "<center><table>"
	var/i
	for(i=contents.len, i>=1, i--)
		var/obj/item/P = contents[i]
		dat += "<tr><td><a href='?src=[REF(src)];retrieve=[REF(P)]'>[P.name]</a></td></tr>"
	dat += "</table></center>"
	user << browse("<html><head><meta http-equiv='Content-Type' content='text/html; charset=UTF-8'><title>[name]</title></head><body>[dat]</body></html>", "window=filingcabinet;size=350x300")

/obj/structure/filingcabinet/attack_tk(mob/user)
	if(anchored)
		attack_self_tk(user)
	else
		..()

/obj/structure/filingcabinet/attack_self_tk(mob/user)
	if(contents.len)
		if(prob(40 + contents.len * 5))
			var/obj/item/I = pick(contents)
			I.forceMove(loc)
			if(prob(25))
				step_rand(I)
			to_chat(user, "<span class='notice'>You pull \a [I] out of [src] at random.</span>")
			return
	to_chat(user, "<span class='notice'>You find nothing in [src].</span>")

/obj/structure/filingcabinet/Topic(href, href_list)
	if(!usr.canUseTopic(src, BE_CLOSE, ismonkey(usr)))
		return
	if(href_list["retrieve"])
		usr << browse("", "window=filingcabinet") // Close the menu

		var/obj/item/P = locate(href_list["retrieve"]) in src //contents[retrieveindex]
		if(istype(P) && in_range(src, usr))
			usr.put_in_hands(P)
			updateUsrDialog()
			icon_state = "[initial(icon_state)]-open"
			addtimer(VARSET_CALLBACK(src, icon_state, initial(icon_state)), 5)

/*
 * Security Record Cabinets
 */
/obj/structure/filingcabinet/record
	var/virgin = TRUE
	var/datum/datacore/linked_datacore

/obj/structure/filingcabinet/record/Initialize(mapload)
	var/datum/overmap/ship/controlled/ship = SSshuttle.get_ship(src)
	if(ship)
		linked_datacore = ship.ship_datacore
	else
		linked_datacore = GLOB.data_core
	. = ..()

/obj/structure/filingcabinet/record/proc/populate()

/obj/structure/filingcabinet/record/attack_hand()
	populate()
	. = ..()

/obj/structure/filingcabinet/record/attack_tk()
	populate()
	..()

/obj/structure/filingcabinet/record/security
	name = "security record cabinet"

/obj/structure/filingcabinet/record/security/populate()
	..()
	if(virgin)
		for(var/datum/data/record/G in linked_datacore.general)
			var/datum/data/record/S = SSdatacore.find_record_by_name(G.fields[DATACORE_NAME], linked_datacore.security)
			if(!S)
				continue
			var/obj/item/paper/sec_record_paper = new /obj/item/paper(src)
			var/sec_record_text = "<CENTER><B>Security Record</B></CENTER><BR>"
			sec_record_text += {"Name: [G.fields[DATACORE_NAME]] ID: [G.fields[DATACORE_ID]]<BR>\n
Gender: [G.fields[DATACORE_GENDER]]<BR>\n
Age: [G.fields[DATACORE_AGE]]<BR>\n
Fingerprint: [G.fields[DATACORE_FINGERPRINT]]<BR>\n
Physical Status: [G.fields[DATACORE_PHYSICAL_HEALTH]]<BR>\n
Mental Status: [G.fields[DATACORE_MENTAL_HEALTH]]<BR><BR>\n"}
			sec_record_text += {"<CENTER><B>Security Data</B></CENTER><BR>\n
Criminal Status: [S.fields[DATACORE_CRIMINAL_STATUS]]<BR>\n<BR>\n
Crimes: [S.fields[DATACORE_CRIMES]]<BR>\n
Details: [S.fields[DATACORE_CRIME_DETAILS]]<BR>\n<BR>\n
Important Notes:<BR>\n\t[S.fields[DATACORE_NOTES]]<BR>\n<BR>\n
<CENTER><B>Comments/Log</B></CENTER><BR>"}
			var/counter = 1
			while(S.fields["com_[counter]"])
				sec_record_text += "[S.fields["com_[counter]"]]<BR>"
				counter++
			sec_record_text += "</TT>"
			sec_record_paper.add_raw_text(sec_record_text)
			sec_record_paper.name = "paper - '[G.fields[DATACORE_NAME]]'"
			sec_record_paper.update_appearance()
			virgin = FALSE	//tabbing here is correct- it's possible for people to try and use it
						//before the records have been generated, so we do this inside the loop.

/*
 * Medical Record Cabinets
 */
/obj/structure/filingcabinet/record/medical
	name = "medical record cabinet"

/obj/structure/filingcabinet/record/medical/populate()
	..()
	if(virgin)
		for(var/datum/data/record/G in linked_datacore.general)
			var/datum/data/record/M = SSdatacore.find_record_by_name(G.fields[DATACORE_NAME], linked_datacore.medical)
			if(!M)
				continue
			var/obj/item/paper/med_record_paper = new /obj/item/paper(src)
			var/med_record_text = "<CENTER><B>Medical Record</B></CENTER><BR>"
			med_record_text += {"Name: [G.fields[DATACORE_NAME]]
ID: [G.fields[DATACORE_ID]]<BR>\n
Gender: [G.fields[DATACORE_GENDER]]<BR>\n
Age: [G.fields[DATACORE_AGE]]<BR>\n
Fingerprint: [G.fields[DATACORE_FINGERPRINT]]<BR>\n
Physical Status: [G.fields[DATACORE_PHYSICAL_HEALTH]]<BR>\n
Mental Status: [G.fields[DATACORE_MENTAL_HEALTH]]<BR>"}
			med_record_text += {"<BR>\n<CENTER><B>Medical Data</B></CENTER><BR>\n
Blood Type: [M.fields[DATACORE_BLOOD_TYPE]]<BR>\n
DNA: [M.fields[DATACORE_BLOOD_DNA]]<BR>\n<BR>\n
Minor Disabilities: [M.fields[DATACORE_MINOR_DISABILITIES]]<BR>\n
Details: [M.fields[DATACORE_MINOR_DISABILITIES_DETAILS]]<BR>\n<BR>\n
Major Disabilities: [M.fields[DATACORE_DISABILITIES]]<BR>\n
Details: [M.fields[DATACORE_DISABILITIES_DETAILS]]<BR>\n<BR>\n
Allergies: [M.fields[DATACORE_ALLERGIES]]]<BR>\n
Details: [M.fields[DATACORE_ALLERGIES_DETAILS]]<BR>\n<BR>\n
Current Diseases: [M.fields[DATACORE_DISEASES]] (per disease info placed in log/comment section)<BR>\n
Details: [M.fields[DATACORE_DISEASES_DETAILS]]<BR>\n<BR>\n
Important Notes:<BR>\n\t[M.fields[DATACORE_NOTES]]<BR>\n<BR>\n
<CENTER><B>Comments/Log</B></CENTER><BR>"}
			var/counter = 1
			while(M.fields["com_[counter]"])
				med_record_text += "[M.fields["com_[counter]"]]<BR>"
				counter++
			med_record_text += "</TT>"
			med_record_paper.add_raw_text(med_record_text)
			med_record_paper.name = "paper - '[G.fields[DATACORE_NAME]]'"
			med_record_paper.update_appearance()
			virgin = FALSE	//tabbing here is correct- it's possible for people to try and use it
						//before the records have been generated, so we do this inside the loop.
/*
 * General Record Cabinets
 */

/obj/structure/filingcabinet/record/general
	name = "general record cabinet"

/obj/structure/filingcabinet/record/general/populate()
	..()
	if(virgin)
		for(var/datum/data/record/G in linked_datacore.general)
			var/obj/item/paper/gen_record_paper = new /obj/item/paper(src)
			var/gen_record_text = "<CENTER><B>General Record</B></CENTER><BR>"
			gen_record_text += {"Name: [G.fields[DATACORE_NAME]] ID: [G.fields[DATACORE_ID]]<BR>\n
Gender: [G.fields[DATACORE_GENDER]]<BR>\n
Age: [G.fields[DATACORE_AGE]]<BR>\n
Fingerprint: [G.fields[DATACORE_FINGERPRINT]]<BR>\n
Physical Status: [G.fields[DATACORE_PHYSICAL_HEALTH]]<BR>\n
Mental Status: [G.fields[DATACORE_MENTAL_HEALTH]]<BR>"}
			gen_record_text += "</TT>"
			gen_record_paper.add_raw_text(gen_record_text)
			gen_record_paper.name = "paper - '[G.fields[DATACORE_NAME]]'"
			gen_record_paper.update_appearance()
			virgin = FALSE	//tabbing here is correct- it's possible for people to try and use it
						//before the records have been generated, so we do this inside the loop.
