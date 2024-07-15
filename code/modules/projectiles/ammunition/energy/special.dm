/obj/item/ammo_casing/energy/ion
	projectile_type = /obj/projectile/ion
	select_name = "ion"
	fire_sound = 'sound/weapons/ionrifle.ogg'

/obj/item/ammo_casing/energy/ion/cheap
	rounds_per_shot = 833

/obj/item/ammo_casing/energy/flora/revolution
	projectile_type = /obj/projectile/energy/florarevolution
	select_name = "revolution"
	rounds_per_shot = 250

/obj/item/ammo_casing/energy/ion/hos
	projectile_type = /obj/projectile/ion/weak
	rounds_per_shot = 2000

/obj/item/ammo_casing/energy/declone
	projectile_type = /obj/projectile/energy/declone
	select_name = "declone"
	fire_sound = 'sound/weapons/pulse3.ogg'

/obj/item/ammo_casing/energy/declone/weak
	projectile_type = /obj/projectile/energy/declone/weak

/obj/item/ammo_casing/energy/flora
	fire_sound = 'sound/effects/stealthoff.ogg'
	harmful = FALSE

/obj/item/ammo_casing/energy/flora/yield
	projectile_type = /obj/projectile/energy/florayield
	select_name = "yield"

/obj/item/ammo_casing/energy/flora/mut
	projectile_type = /obj/projectile/energy/floramut
	select_name = "mutation"

/obj/item/ammo_casing/energy/temp
	projectile_type = /obj/projectile/temp
	select_name = "freeze"
	rounds_per_shot = 2500
	fire_sound = 'sound/weapons/pulse3.ogg'

/obj/item/ammo_casing/energy/temp/hot
	projectile_type = /obj/projectile/temp/hot
	select_name = "bake"

/obj/item/ammo_casing/energy/meteor
	projectile_type = /obj/projectile/meteor
	select_name = "goddamn meteor"
	rounds_per_shot = 100

/obj/item/ammo_casing/energy/net
	projectile_type = /obj/projectile/energy/net
	select_name = "netting"
	pellets = 6
	variance = 40
	harmful = FALSE

/obj/item/ammo_casing/energy/trap
	projectile_type = /obj/projectile/energy/trap
	select_name = "snare"
	harmful = FALSE

/obj/item/ammo_casing/energy/instakill
	projectile_type = /obj/projectile/beam/instakill
	rounds_per_shot = 0
	select_name = "DESTROY"

/obj/item/ammo_casing/energy/instakill/blue
	projectile_type = /obj/projectile/beam/instakill/blue

/obj/item/ammo_casing/energy/instakill/red
	projectile_type = /obj/projectile/beam/instakill/red

/obj/item/ammo_casing/energy/tesla_cannon
	fire_sound = 'sound/magic/lightningshock.ogg'
	rounds_per_shot = 300
	select_name = "shock"
	projectile_type = /obj/projectile/energy/tesla_cannon
	delay = 1

/obj/item/ammo_casing/energy/shrink
	projectile_type = /obj/projectile/beam/shrink
	select_name = "shrink ray"
	rounds_per_shot = 2000

/obj/item/ammo_casing/energy/buster
	projectile_type = /obj/projectile/energy/buster
	select_name = "T4L1 buster replica"
	rounds_per_shot = 100 //should have a lot of energy
	fire_sound = 'sound/effects/empulse.ogg'
	delay = 3 SECONDS
