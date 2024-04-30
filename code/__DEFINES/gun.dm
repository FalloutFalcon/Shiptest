//Gun weapon weight
/// Allows you to dual wield this gun and your offhand gun
#define WEAPON_LIGHT 1
/// Does not allow you to dual wield with this gun and your offhand gun
#define WEAPON_MEDIUM 2
/// You must wield the gun to fire this gun
#define WEAPON_HEAVY 3
//Gun trigger guards
#define TRIGGER_GUARD_ALLOW_ALL -1
#define TRIGGER_GUARD_NONE 0
#define TRIGGER_GUARD_NORMAL 1
//Gun bolt types
///Gun has a bolt, it stays closed while not cycling. The gun must be racked to have a bullet chambered when a mag is inserted.
/// Example: c20, shotguns, m90
#define BOLT_TYPE_STANDARD 1
///Gun has a bolt, it is open when ready to fire. The gun can never have a chambered bullet with no magazine, but the bolt stays ready when a mag is removed.
/// Example: Some SMGs, the L6
#define BOLT_TYPE_OPEN 2
///Gun has no moving bolt mechanism, it cannot be racked. Also dumps the entire contents when emptied instead of a magazine.
/// Example: Break action shotguns, revolvers
#define BOLT_TYPE_NO_BOLT 3
///Gun has a bolt, it locks back when empty. It can be released to chamber a round if a magazine is in.
/// Example: Pistols with a slide lock, some SMGs
#define BOLT_TYPE_LOCKING 4
//Sawn off nerfs
///accuracy penalty of sawn off guns
#define SAWN_OFF_ACC_PENALTY 25
///added recoil of sawn off guns
#define SAWN_OFF_RECOIL 1

/* Stolen from tgmc.. Will use soon
//Gun defines for gun related thing. More in the projectile folder.
//gun_features_flags
#define GUN_CAN_POINTBLANK (1<<0)
#define GUN_UNUSUAL_DESIGN (1<<1)
#define GUN_AMMO_COUNTER (1<<2)
#define GUN_WIELDED_FIRING_ONLY (1<<3)
#define GUN_ALLOW_SYNTHETIC (1<<4)
#define GUN_WIELDED_STABLE_FIRING_ONLY (1<<5)
#define GUN_IFF (1<<6)
#define GUN_DEPLOYED_FIRE_ONLY (1<<7)
#define GUN_IS_ATTACHMENT (1<<8)
#define GUN_ATTACHMENT_FIRE_ONLY (1<<9)
#define GUN_ENERGY (1<<10)
#define GUN_AMMO_COUNT_BY_PERCENTAGE (1<<11)
#define GUN_AMMO_COUNT_BY_SHOTS_REMAINING (1<<12)
#define GUN_NO_PITCH_SHIFT_NEAR_EMPTY (1<<13)
#define GUN_SHOWS_AMMO_REMAINING (1<<14) //Whether the mob sprite reflects the ammo level
#define GUN_SHOWS_LOADED (1<<15) //Whether the mob sprite as loaded or unloaded, a binary version of the above
#define GUN_SMOKE_PARTICLES (1<<16) //Whether the gun has smoke particles

#define GUN_FIREMODE_SEMIAUTO "semi-auto fire mode"
#define GUN_FIREMODE_BURSTFIRE "burst-fire mode"
#define GUN_FIREMODE_AUTOMATIC "automatic fire mode"
#define GUN_FIREMODE_AUTOBURST "auto-burst-fire mode"
*/

//Autofire component
/// Compatible firemode is in the gun. Wait until it's held in the user hands.
#define AUTOFIRE_STAT_IDLE (1<<0)
/// Gun is active and in the user hands. Wait until user does a valid click.
#define AUTOFIRE_STAT_ALERT (1<<1)
/// Gun is shooting.
#define AUTOFIRE_STAT_FIRING (1<<2)

#define COMSIG_AUTOFIRE_ONMOUSEDOWN "autofire_onmousedown"
	#define COMPONENT_AUTOFIRE_ONMOUSEDOWN_BYPASS (1<<0)
#define COMSIG_AUTOFIRE_SHOT "autofire_shot"
	#define COMPONENT_AUTOFIRE_SHOT_SUCCESS (1<<0)

#define SUPPRESSED_NONE 0
#define SUPPRESSED_QUIET 1 ///standard suppressed
#define SUPPRESSED_VERY 2 /// no message

#define DUALWIELD_PENALTY_EXTRA_MULTIPLIER 1.6

#define MANUFACTURER_NONE null
#define MANUFACTURER_SHARPLITE "the Sharplite Defense logo"
#define MANUFACTURER_SHARPLITE_NEW "the Nanotrasen-Sharplite logo"
#define MANUFACTURER_HUNTERSPRIDE "the Hunter's Pride Arms and Ammunition logo"
#define MANUFACTURER_SOLARARMORIES "the Solarbundswaffenkammer emblem"
#define MANUFACTURER_SCARBOROUGH "the Scarborough Arms logo"
#define MANUFACTURER_EOEHOMA "the Eoehoma Firearms emblem"
#define MANUFACTURER_NANOTRASEN_OLD "an outdated Nanotrasen logo"
#define MANUFACTURER_NANOTRASEN "the Nanotrasen logo"
#define MANUFACTURER_BRAZIL "a green flag with a blue circle and a yellow diamond around it"
#define MANUFACTURER_INTEQ "an orange crest with the letters 'IRMG'"
#define MANUFACTURER_MINUTEMAN "the Lanchester City Firearms Plant logo"
#define MANUFACTURER_DONKCO "the Donk! Co. logo"
#define MANUFACTURER_PGF "the Etherbor Industries emblem"
#define MANUFACTURER_IMPORT "Lanchester Import Co."

/////////////////
// ATTACHMENTS //
/////////////////
#define COMSIG_ATTACHMENT_ATTACH "attach-attach"
#define COMSIG_ATTACHMENT_DETACH "attach-detach"
#define COMSIG_ATTACHMENT_EXAMINE "attach-examine"
#define COMSIG_ATTACHMENT_EXAMINE_MORE "attach-examine-more"
#define COMSIG_ATTACHMENT_PRE_ATTACK "attach-pre-attack"
#define COMSIG_ATTACHMENT_ATTACK "attach-attacked"
#define COMSIG_ATTACHMENT_UPDATE_OVERLAY "attach-overlay"

#define COMSIG_ATTACHMENT_GET_SLOT "attach-slot-who"
#define ATTACHMENT_SLOT_MUZZLE "attach-slot-muzzle"
#define ATTACHMENT_SLOT_SCOPE "attach-slot-scope"
#define ATTACHMENT_SLOT_GRIP "attach-slot-grip"
#define ATTACHMENT_SLOT_RAIL "attach-slot-rail"

#define BIT_ATTACHMENT_SLOT_MUZZLE (1<<0)
#define BIT_ATTACHMENT_SLOT_SCOPE (1<<1)
#define BIT_ATTACHMENT_SLOT_GRIP (1<<2)
#define BIT_ATTACHMENT_SLOT_RAIL (1<<3)

DEFINE_BITFIELD(attach_slots, list(
	ATTACHMENT_SLOT_MUZZLE = BIT_ATTACHMENT_SLOT_MUZZLE,
	ATTACHMENT_SLOT_SCOPE = BIT_ATTACHMENT_SLOT_SCOPE,
	ATTACHMENT_SLOT_GRIP = BIT_ATTACHMENT_SLOT_GRIP,
	ATTACHMENT_SLOT_RAIL = BIT_ATTACHMENT_SLOT_RAIL
))

#define COMSIG_ATTACHMENT_TOGGLE "attach-toggle"

#define TRAIT_ATTACHABLE "attachable"

#define ATTACHMENT_DEFAULT_SLOT_AVAILABLE list( \
	ATTACHMENT_SLOT_MUZZLE = 1, \
	ATTACHMENT_SLOT_SCOPE = 1, \
	ATTACHMENT_SLOT_GRIP = 1, \
	ATTACHMENT_SLOT_RAIL = 1, \
)

/proc/attachment_slot_to_bflag(slot)
	switch(slot)
		if(ATTACHMENT_SLOT_MUZZLE)
			return (1<<0)
		if(ATTACHMENT_SLOT_SCOPE)
			return (1<<1)
		if(ATTACHMENT_SLOT_GRIP)
			return (1<<2)
		if(ATTACHMENT_SLOT_RAIL)
			return (1<<3)

/proc/attachment_slot_from_bflag(slot)
	switch(slot)
		if(1<<0)
			return ATTACHMENT_SLOT_MUZZLE
		if(1<<1)
			return ATTACHMENT_SLOT_SCOPE
		if(1<<2)
			return ATTACHMENT_SLOT_GRIP
		if(1<<3)
			return ATTACHMENT_SLOT_RAIL

/////////////////
// PROJECTILES //
/////////////////

//bullet_act() return values
#define BULLET_ACT_HIT "HIT" //It's a successful hit, whatever that means in the context of the thing it's hitting.
#define BULLET_ACT_BLOCK "BLOCK" //It's a blocked hit, whatever that means in the context of the thing it's hitting.
#define BULLET_ACT_FORCE_PIERCE "PIERCE"	//It pierces through the object regardless of the bullet being piercing by default.

#define NICE_SHOT_RICOCHET_BONUS 10 //if the shooter has the NICE_SHOT trait and they fire a ricocheting projectile, add this to the ricochet chance and auto aim angle

//Projectile Reflect
#define REFLECT_NORMAL (1<<0)
#define REFLECT_FAKEPROJECTILE (1<<1)

//ammo box sprite defines
///ammo box will always use provided icon state
#define AMMO_BOX_ONE_SPRITE 0
///ammo box will have a different state for each bullet; <icon_state>-<bullets left>
#define AMMO_BOX_PER_BULLET 1
///ammo box will have a different state for full and empty; <icon_state>-max_ammo and <icon_state>-0
#define AMMO_BOX_FULL_EMPTY 2

/* Stolen from tgmc.. Will use soon
//Ammo magazine defines, for magazine_flags
#define MAGAZINE_REFILLABLE (1<<0)
#define MAGAZINE_HANDFUL (1<<1)
#define MAGAZINE_WORN (1<<2)
#define MAGAZINE_REFUND_IN_CHAMBER (1<<3)

//reciever_flags. Used to determin how the gun cycles, what kind of ammo it uses, etc.
#define AMMO_RECIEVER_REQUIRES_UNIQUE_ACTION (1<<0)
	#define AMMO_RECIEVER_UNIQUE_ACTION_LOCKS (1<<1)
#define AMMO_RECIEVER_MAGAZINES (1<<2)
	#define AMMO_RECIEVER_AUTO_EJECT (1<<3)
#define AMMO_RECIEVER_HANDFULS (1<<4)
#define AMMO_RECIEVER_TOGGLES_OPEN (1<<5)
	#define AMMO_RECIEVER_TOGGLES_OPEN_EJECTS (1<<6)
#define AMMO_RECIEVER_CLOSED (1<<7)
#define AMMO_RECIEVER_ROTATES_CHAMBER (1<<8)
#define AMMO_RECIEVER_DO_NOT_EJECT_HANDFULS (1<<9)
#define AMMO_RECIEVER_DO_NOT_EMPTY_ROUNDS_AFTER_FIRE (1<<10)
#define AMMO_RECIEVER_CYCLE_ONLY_BEFORE_FIRE (1<<11) //The ammo stay in the magazine until the last moment
#define AMMO_RECIEVER_AUTO_EJECT_LOCKED (1<<12) //Not allowed to turn automatic unloading off
*/

#define MAG_SIZE_SMALL 1
#define MAG_SIZE_MEDIUM 2
#define MAG_SIZE_LARGE 3

//Projectile Reflect
#define REFLECT_NORMAL (1<<0)
#define REFLECT_FAKEPROJECTILE (1<<1)

#define MOVES_HITSCAN -1		//Not actually hitscan but close as we get without actual hitscan.
#define MUZZLE_EFFECT_PIXEL_INCREMENT 17	//How many pixels to move the muzzle flash up so your character doesn't look like they're shitting out lasers.
