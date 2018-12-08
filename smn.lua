--lua created by Pergatory: https://pastebin.com/Fa5PtueC

-- Modifications by Rumorian:

-- replaced console_echo with windower.add_to_chat(159,' to have status displayed in chatlog instead of Windower console. 

-- disabled automatic macro/lockstyle. didn't work for me. search for "Select initial macro set and set lockstyle" section 
--  and un-comment to see if it works for you.

-- line added to get_sets that sets the initial macro book/page and the lockstyle (as defined in StartLockStyle).

-- automatic macro palette switch has been moved to in-game macros looking like this:
--    /ma AvatarName <me>
--    /macro Book #
--    /macro Set #
--   Book/Set also added to Release macro so it switches back to initial set after releasing avatar
-- the only disadvantage is that it doesn't automatically switch to initial set after avatar dies, but just hit Release macro to accomplish that

-- added automatic Siphon (release avatar, call Spirit according to day/weather, siphon, release and re-call previous avatar). 
--This was copy/pasted from Verda's lua: 
-- https://www.ffxiah.com/forum/topic/47688/summoner-gearswap-yep-another-one-p/
-- had to add elements/spirits definitions to make it work (elements.list, spirits, elements.spirit_of).

-- end of modifications



-- IdleMode determines the set used after casting. You change it with "/console gs c <IdleMode>"
-- The modes are:
-- Refresh: Uses the most refresh available.
-- DT: A mix of refresh, PDT, and MDT to help when you can't avoid AOE.
-- PetDT: Sacrifice refresh to reduce avatar's damage taken. WARNING: Selenian Cap drops you below 119, use with caution!
-- DD: When melee mode is on and you're engaged, uses TP gear. Otherwise, avatar melee gear.
-- Favor: Uses Beckoner's Horn +1 and max smn skill to boost the favor effect.
-- Zendik: Favor build with the Zendik Robe added in, for Shiva's Favor in manaburn parties. (Shut up, it sounded like a good idea at the time)
 
-- Additional Bindings:
-- F9 - Toggles between a subset of IdleModes (Refresh > DT > PetDT)
-- F10 - Toggles MeleeMode (When enabled, equips Nirvana and Elan+1, then disables those 2 slots from swapping)
--       NOTE: If you don't already have the Nirvana & Elan+1 equipped, YOU WILL LOSE TP
 
-- Additional Commands:
-- /console gs c AccMode - Toggles high-accuracy sets to be used where appropriate.
-- /console gs c ImpactMode - Toggles between using normal magic BP set for Fenrir's Impact or a custom high-skill set for debuffs.
-- /console gs c ForceIlvl - I have this set up to override a few specific slots where I normally use non-ilvl pieces.
-- /console gs c LagMode - Used to help BPs land in the right gear in high-lag situations.
--                          This will swap gear at the JA's aftercast, rather than waiting for the "Pet readies command" packet.
 
function file_unload()
    send_command('unbind f9')
    send_command('unbind f10')
	send_command('lua u pettp')
end

 
function get_sets()
    send_command('bind f9 gs c ToggleIdle')
    send_command('bind f10 gs c MeleeMode')
	send_command('lua l pettp')
    -- Set your merits here. This is used in deciding between Enticer's Pants or Apogee Slacks +1.
    -- To change in-game, "/console gs c MeteorStrike3" will change Meteor Strike to 3/5 merits.
    MeteorStrike = 1
    HeavenlyStrike = 1
    WindBlade = 1
    Geocrush = 1
    Thunderstorm = 5
    GrandFall = 1
 
    StartLockStyle = '02'
    IdleMode = 'Refresh'
    AccMode = false
    ImpactDebuff = false
    MeleeMode = false
    ForceIlvl = false
    LagMode = false -- Default LagMode. If you have a lot of lag issues, change to "true"
    AutoRemedy = true
    AutoEcho = false
    Test = 0
    send_command('input /macro book 15;wait .3;input /macro set 1;wait 3;input /lockstyleset '..StartLockStyle)
    -- ===================================================================================================================
    --      Sets
    -- ===================================================================================================================
 
    -- Base Damage Taken Set - Mainly used when IdleMode is "DT"
    sets.DT_Base = {
		sub="Elan Strap",
		head="Beckoner's Horn +1",
		neck="Summoner's Collar +1",
		lear="Hearty Earring",
		rear="Eabani Earring",
		body="Apogee dalmatica +1",
		hands={ name="Merlinic Dastanas", augments={'DEX+4','AGI+8','"Refresh"+2',}},
		lring="Stikini Ring +1",
		rring="Defending Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Mag. Acc.+10','Pet: Haste+10','Pet: "Regen"+5',}},
		waist="Slipor Sash",
		feet={ name="Merlinic Crackows", augments={'INT+8','"Fast Cast"+2','"Refresh"+2','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
		legs="Assiduity Pants +1"
    }
 
    sets.precast = {}
 
    -- Fast Cast
    sets.precast.FC = {
 		main="Oranyan", --7
		head="Vanya Hood", --10
		neck="Baetyl Pendant",  --4
		lear="Loquacious Earring",  --2
		rear="Mendicant's Earring", --For cures only but since I don't have another FC earring and there's no separate CureFC set this works
		body="Baayami Robe",  --11
		hands="Telchine Gloves",  --4
		lring="Kishar Ring",  --5
		rring="Prolix Ring",  --2
		back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Pet: Magic Damage+10','"Fast Cast"+10',}},
		waist="Witful Belt",  --3
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+2','"Fast Cast"+5','MND+2','"Mag.Atk.Bns."+10',}},  --10
		legs="Psycloth Lappas"  --7
    }
	-- 65%
 
    sets.midcast = {}
 
    -- BP Timer Gear
    sets.midcast.BP = {
		main="Espiritus", --Delay II -2
		Head="Beckoner's horn +1", -- Skill +13, Favor +3
		neck="Caller's Pendant", --Skill +9
		body="Convoker's Doublet +3", -- Delay -15
		hands="Lamassu Mitts +1", --Skill +22
		lring="Stikini Ring +1", -- Skill +5
		rring="Evoker's Ring", --Skill +10
		feet="Baayami Sabots" --Skill +24
	}
	--Sancus Sachet +1 = Delay II -7
	
	--Delay -15 (max 15)
	--Delay II -9 (max 15)
	--Delay III -10 (max 10)
	--Favor - 10
	
	--Total 44, Skill +83
 
    sets.midcast.Siphon = {
		head="Telchine Cap", 
		body="Baayami Robe",
		hands={ name="Telchine Gloves", augments={'"Elemental Siphon"+30','Enh. Mag. eff. dur. +9',}},
		legs={ name="Telchine Braconi", augments={'Attack+5','"Elemental Siphon"+35','Enh. Mag. eff. dur. +10',}},
		feet="Telchine Pigaches", --Siphon +35
		neck="Incanter's Torque",
		rring="Evoker's Ring",
		back="Conveyance Cape",
		lring="Stikini Ring +1"
}
	--Siphon +155
 
    sets.midcast.SiphonZodiac = set_combine(sets.midcast.Siphon, {  })
 
    sets.midcast.Summon = set_combine(sets.DT_Base, {

    })
 
    sets.midcast.Cure = {
 		main="Oranyan",
		sub="Enki Strap",
		head="Vanya Hood",  --10%
		body="Vrikodara Jupon", --13%
		neck="Incanter's Torque",
		lear="Mendicant's Earring", --5%
		rear="Lempo Earring", --Enmity -3, Conserve MP +2
		hands="Telchine Gloves",  --10%
		lring="Stikini Ring +1",
		rring="Sirona's Ring",
		back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Pet: Magic Damage+10','"Fast Cast"+10',}},
		waist="Gishdubar Sash", --10% self
		legs="Gyve Trousers",  --10%
		feet="Vanya Clogs"  --10%
		}
		--58% (50% cap)
		--10% Self
 
    sets.midcast.Cursna = set_combine(sets.precast.FC, {
 		head="Vanya Hood", -- 10
		body="Baayami Robe", -- 11
		hands="Telchine Gloves",  -- 4
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}}, -- 7
		feet="Vanya Clogs",  -- Cursna +5
		neck="Baetyl Pendant",  -- 4
		waist="Gishdubar Sash", --Cursna +10
		lear="Loquacious Earring",  -- 2
		back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Pet: Magic Damage+10','"Fast Cast"+10',}},
		left_ring="Saida Ring",  --Self cursna +15
		right_ring="Ephedra Ring"})  --Cursna +10
		-- Cursna +25, FC 31
   
    sets.midcast.EnmityRecast = set_combine(sets.precast.FC, {

    })
 
    sets.midcast.Enfeeble = {
		main="Grioavolr",
		head="Befouled Crown",
		neck="Incanter's Torque",
		lear="Gwati Earring",
		rear="Choleric Earring",
		body="Vanya Robe",
--		hands="Lurid Mitts",
		lring="Stikini Ring +1",
		rring="Kishar Ring",
		back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Pet: Magic Damage+10','"Fast Cast"+10',}},
		waist="Rumination Sash",
		legs="Psycloth Lappas",
		feet="Medium's Sabots",
		sub="Enki Strap"
    }
 
    sets.midcast.Enhancing = {
		main="Oranyan", --Duration +10%
		head="Telchine Cap", --Duration +8%
		neck="Incanter's Torque",
		rear="Loquacious Earring",
		body={ name="Telchine Chas.", augments={'"Elemental Siphon"+25','Enh. Mag. eff. dur. +8',}}, --Duration +8%
		hands="Telchine Gloves", --Duration +9%
		lring="Stikini Ring +1",
		rring="Kishar Ring",
		back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Pet: Magic Damage+10','"Fast Cast"+10',}},
		waist="Latria Sash",
		legs={ name="Telchine Braconi", augments={'Attack+5','"Elemental Siphon"+35','Enh. Mag. eff. dur. +10',}},  --Duration +6%
		feet="Telchine Pigaches" --Duration +7%
    }
 
    sets.midcast.Stoneskin = set_combine(sets.midcast.Enhancing, {
		neck="Nodens Gorget",
		waist="Siegel Sash",
		legs="Haven Hose"
    })
 
    sets.midcast.Nuke = {
		head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','INT+5','"Mag.Atk.Bns."+14',}},
		body={ name="Witching Robe", augments={'MP+50','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Refresh"+1',}},
		hands="Amalric Gages +1", 
		legs="Gyve Trousers",
		feet={ name="Merlinic Crackows", augments={'Attack+21','Pet: VIT+14','Quadruple Attack +3','Accuracy+19 Attack+19','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
		neck="Baetyl Pendant",
		waist="Refoccilation Stone",
		left_ear="Mache Earring",
		right_ear="Friomisi Earring",
		left_ring="Resonance Ring",
		back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Pet: Magic Damage+10','"Fast Cast"+10',}},
		right_ring="Stikini Ring +1"
    }
 
    sets.midcast["Refresh"] = set_combine(sets.midcast.Enhancing, {
		waist="Gishdubar Sash",
		back="Grapevine Cape",
		head="Amalric Coif +1",
    })
 
    sets.midcast["Mana Cede"] = {  }
 
    sets.midcast["Astral Flow"] = { head="Glyphic Horn +1" }
 
    sets.midcast["Garland of Bliss"] = set_combine(sets.midcast.Nuke, {
		head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','INT+5','"Mag.Atk.Bns."+14',}},
		body={ name="Witching Robe", augments={'MP+50','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Refresh"+1',}},
		hands="Amalric Gages +1", 
		legs="Gyve Trousers",
		feet={ name="Merlinic Crackows", augments={'Attack+21','Pet: VIT+14','Quadruple Attack +3','Accuracy+19 Attack+19','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
		neck="Baetyl Pendant",
		waist="Refoccilation Stone",
		left_ear="Mache Earring",
		right_ear="Friomisi Earring",
		left_ring="Rufescent Ring",
		right_ring="Karieyh Ring +1"
    })
 
    sets.midcast["Shattersoul"] = {
		head="Telchine Cap",
		neck="Fotia Gorget",
		lear="Mache Earring",
		rear="Cessance Earring",
		body="Convoker's Doublet +3",
		hands="Amalric Gages +1",
		lring="Etana Ring",
		rring="Vertigo Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Mag. Acc.+10','Pet: Haste+10','Pet: "Regen"+5',}},
		waist="Fotia Belt",
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic burst dmg.+9%','INT+14',}},
		legs="Gyve Trousers"
    }
 
    sets.midcast["Cataclysm"] = sets.midcast.Nuke
 
    sets.pet_midcast = {}
 
    -- Main physical pact set (Volt Strike, Pred Claws, etc.)
    sets.pet_midcast.Physical_BP = {
		main="Keraunos",
		sub="Elan Strap",
		head="Helios Band",
		body="Convoker's Doublet +3",
		neck="Summoner's Collar +1",
		hands={ name="Merlinic Dastanas", augments={'Pet: Attack+30 Pet: Rng.Atk.+30','Blood Pact Dmg.+10','Pet: STR+1','Pet: Mag. Acc.+14','Pet: "Mag.Atk.Bns."+15',}},
		legs="Apogee Slacks +1",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Mag. Acc.+10','Pet: Haste+10','Pet: "Regen"+5',}},
		feet="Apogee Pumps +1",
		rring="Varar Ring",
		lring="Varar Ring",
		rear="Gelos Earring"
    }
 
    sets.pet_midcast.Physical_BP_AM3 = set_combine(sets.pet_midcast.Physical_BP, {

    })
 
    -- Physical pacts which benefit more from TP than Pet:DA (like single-hit BP)
    sets.pet_midcast.Physical_BP_TP = set_combine(sets.pet_midcast.Physical_BP, {
		ear2="Gelos Earring",
		legs="Enticer's Pants",
		feet="Apogee Pumps +1"
    })
 
    -- Used for all physical pacts when AccMode is true
    sets.pet_midcast.Physical_BP_Acc = set_combine(sets.pet_midcast.Physical_BP, {
		head="Apogee Crown +1", 
		hands={ name="Merlinic Dastanas", augments={'Pet: Accuracy+28 Pet: Rng. Acc.+28','Pet: "Dbl. Atk."+5','Pet: STR+5','Pet: Mag. Acc.+8',}},
        --feet="Convoker's Pigaches +3"
    })
 
    -- Base magic pact set
    sets.pet_midcast.Magic_BP_Base = {
 		main="Espiritus",
		sub="Elan Strap",
		head="Apogee Crown +1",
		body="Apogee dalmatica +1",
		neck="Summoner's Collar +1",
		hands={ name="Merlinic Dastanas", augments={'Pet: Attack+30 Pet: Rng.Atk.+30','Blood Pact Dmg.+10','Pet: STR+1','Pet: Mag. Acc.+14','Pet: "Mag.Atk.Bns."+15',}},
		legs="Enticer's Pants",
		feet="Apogee Pumps +1",
		back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Pet: Magic Damage+10','"Fast Cast"+10',}},
		lring="Speaker's Ring",
		rring="Evoker's Ring",
		rear="Gelos Earring"
    }
   
    -- Some magic pacts benefit more from TP than others.
    -- Note: This set will only be used on merit pacts if you have less than 4 merits.
    --       Make sure to update your merit values at the top of this Lua.
    sets.pet_midcast.Magic_BP_TP = set_combine(sets.pet_midcast.Magic_BP_Base, {
		legs="Enticer's Pants"
    })
 
    -- NoTP set used when you don't need Enticer's
    sets.pet_midcast.Magic_BP_NoTP = set_combine(sets.pet_midcast.Magic_BP_Base, {
		legs="Apogee Slacks +1",  --No MAB on these but BP+21
    })
 
    sets.pet_midcast.Magic_BP_TP_Acc = set_combine(sets.pet_midcast.Magic_BP_TP, {
		body="Convoker's Doublet +3",
		hands={ name="Merlinic Dastanas", augments={'Pet: Attack+30 Pet: Rng.Atk.+30','Blood Pact Dmg.+10','Pet: STR+1','Pet: Mag. Acc.+14','Pet: "Mag.Atk.Bns."+15',}},
    })
 
    sets.pet_midcast.Magic_BP_NoTP_Acc = set_combine(sets.pet_midcast.Magic_BP_NoTP, {
		body="Convoker's Doublet +3",
		hands={ name="Merlinic Dastanas", augments={'Pet: Attack+30 Pet: Rng.Atk.+30','Blood Pact Dmg.+10','Pet: STR+1','Pet: Mag. Acc.+14','Pet: "Mag.Atk.Bns."+15',}},
    })
 
    sets.pet_midcast.FlamingCrush = {
 		main="Espiritus",
		sub="Elan Strap",
		head="Apogee Crown +1",
		body="Convoker's Doublet +3",
		neck="Summoner's Collar",
		hands={ name="Merlinic Dastanas", augments={'Pet: Attack+30 Pet: Rng.Atk.+30','Blood Pact Dmg.+10','Pet: STR+1','Pet: Mag. Acc.+14','Pet: "Mag.Atk.Bns."+15',}},
		legs="Apogee Slacks +1",
		feet="Apogee Pumps +1",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Mag. Acc.+10','Pet: Haste+10','Pet: "Regen"+5',}},
		lring="Varar Ring",
		rring="Varar Ring",
		rear="Gelos Earring"
    }
 
    sets.pet_midcast.FlamingCrush_Acc = set_combine(sets.pet_midcast.FlamingCrush, {
        --ear2="Enmerkar Earring",
		body="Convoker's Doublet +3",
		hands={ name="Merlinic Dastanas", augments={'Pet: Accuracy+28 Pet: Rng. Acc.+28','Pet: "Dbl. Atk."+5','Pet: STR+5','Pet: Mag. Acc.+8',}},
        --feet="Convoker's Pigaches +3"
    })
 
    -- Pet: Magic Acc set - Mainly used for debuff pacts like Shock Squall
    sets.pet_midcast.MagicAcc_BP = {
		head="Beckoner's Horn +1",
		body="Beckoner's Doublet +1",
		hands="Lamassu Mitts +1",
		neck="Summoner's Collar +1",
		rring="Evoker's Ring",
		back="Conveyance Cape",
		lring="Stikini Ring +1",
		legs="Tali'ah Seraweels +2", 
		back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Pet: Magic Damage+10','"Fast Cast"+10',}},
		feet="Tali'ah Crackows +2"
    }
 
    sets.pet_midcast.Debuff_Rage = sets.pet_midcast.MagicAcc_BP
 
    -- Pure summoning magic set, mainly used for buffs like Hastega II.
    sets.pet_midcast.SummoningMagic = {
		head="Baayami Hat",  --26
		body="Baayami Robe", --32
		neck="Incanter's Torque", --10
		hands="Lamassu Mitts +1", --21
		rring="Evoker's Ring", --10
		back="Conveyance Cape", --10
		lring="Stikini Ring +1",  --8
		feet="Baayami Sabots"  --24
    }
 
    sets.pet_midcast.Buff = sets.pet_midcast.SummoningMagic
 
    -- I use Apogee gear for healing BPs because the amount healed is affected by avatar max HP.
    -- I'm probably stupid. It puts you in yellow HP after using a healing move.
    sets.pet_midcast.Buff_Healing = set_combine(sets.pet_midcast.SummoningMagic, {
		head="Apogee Crown +1",
	--	hands="Apogee Mitts +1",
		body="Apogee dalmatica +1",
		legs="Apogee Slacks +1",
		feet="Apogee Pumps +1",
		--Fill the rest with HP gear so you don't lose HP
		neck="Sanctity Necklace", --HP+35
		lear="Eabani Earring",  --HP+45
		hands="Telchine Gloves", --HP+52
		lring="Vengeful Ring", --HP+20
		rring="Etana Ring",  --HP+60
		waist="Gishdubar sash"  --Cure received +10%
    })
 
    -- This set is used for certain blood pacts when ImpactDebuff mode is ON. (/console gs c ImpactDebuff)
    -- These pacts are normally used as nukes, but they're also strong debuffs which are enhanced by smn skill.
    sets.pet_midcast.Impact = set_combine(sets.pet_midcast.SummoningMagic, {

    })
 
    sets.aftercast = {}
 
    -- Idle set with no avatar out.
    sets.aftercast.Idle = {
		sub="Elan Strap",
		head="Beckoner's Horn +1",
		neck="Sanctity Necklace",
		lear="Hearty Earring",
		rear="Eabani Earring",
		body="Apogee dalmatica +1",
		hands={ name="Merlinic Dastanas", augments={'DEX+4','AGI+8','"Refresh"+2',}},
		lring="Stikini Ring +1",
		rring="Defending Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Mag. Acc.+10','Pet: Haste+10','Pet: "Regen"+5',}},
		waist="Slipor Sash",
		feet={ name="Merlinic Crackows", augments={'INT+8','"Fast Cast"+2','"Refresh"+2','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
		legs="Assiduity Pants +1"
    }
   
    -- Idle set used when ForceIlvl is ON. Use this mode to avoid Gaiters dropping ilvl.
    sets.aftercast.Idle_Ilvl = set_combine(sets.aftercast.Idle, {

    })
   
    sets.aftercast.DT = sets.DT_Base
 
    -- Many idle sets inherit from this set.
    -- Put common items here so you don't have to repeat them over and over.
    sets.aftercast.Perp_Base = {
 		main="Gridarvor",  --Perp -5
		head="Beckoner's horn +1", --Refresh +2
		neck="Summoner's Collar +1",
		lear="Domesticator's Earring",
		rear="Evans Earring",  --Perp -2
		body="Beckoner's Doublet +1",  --Perp -6
		hands={ name="Merlinic Dastanas", augments={'DEX+4','AGI+8','"Refresh"+2',}},  --Refresh +2
		lring="Stikini Ring +1", --Refresh +1
		rring="Defending Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Mag. Acc.+10','Pet: Haste+10','Pet: "Regen"+5',}},
		waist="Isa Belt",
		feet="Baayami Sabots", --Refresh +2, Avatar Regen +3
		legs="Assiduity Pants +1", --Perp -3, Refresh 1-2 based on Unity Ranking
}
		-- Total Perp -14
		-- Refresh 8-9 based on Unity ranking
 
    -- Avatar Melee set. Equipped when IdleMode is "DD" and MeleeMode is OFF.
    sets.aftercast.Perp_DD = set_combine(sets.aftercast.Perp_Base, {
		main="Gridarvor", --Perp -5
		head="Glyphic Horn +1", --Perp -4
		neck="Summoner's Collar +1",
		lear="Domesticator's Earring",
		rear="Evans Earring",  --Perp -2
		body="Apogee dalmatica +1", --Refresh +4
		hands={ name="Merlinic Dastanas", augments={'Pet: Accuracy+28 Pet: Rng. Acc.+28','Pet: "Dbl. Atk."+5','Pet: STR+5','Pet: Mag. Acc.+8',}},
		lring="Varar Ring", 
		rring="Varar Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Mag. Acc.+10','Pet: Haste+10','Pet: "Regen"+5',}},
		waist="Klouskap Sash",
		legs="Tali'ah Seraweels +2", 
		feet="Psycloth Boots"
    })
		--Total Perp -14
 
    -- Refresh set with avatar out. Equipped when IdleMode is "Refresh".
    sets.aftercast.Perp_Refresh = set_combine(sets.aftercast.Perp_Base, {

    })
 
    sets.aftercast.Perp_RefreshSub50 = set_combine(sets.aftercast.Perp_Refresh, {
		waist="Fucho-no-obi"
    })
   
    sets.aftercast.Perp_Favor = set_combine(sets.aftercast.Perp_Refresh, {
		head="Beckoner's Horn +1",  --13
		body="Baayami Robe", --32
		neck="Incanter's Torque", --10
		hands="Lamassu Mitts +1", --21
		rring="Evoker's Ring", --10
		back="Conveyance Cape", --10
		lring="Stikini Ring +1",  --8
		feet="Baayami Sabots"  --24
    })
 
    sets.aftercast.Perp_Zendik = set_combine(sets.aftercast.Perp_Favor, {
    })
 
    -- TP set. Equipped when IdleMode is "DD" and MeleeMode is ON.
    sets.aftercast.Perp_Melee = set_combine(sets.aftercast.Perp_Refresh, {
 		main="Gridarvor", --Perp -5
		sub="Flanged Grip",
		head="Glyphic Horn +1", --Perp -4
		neck="Summoner's Collar +1",
		lear="Domesticator's Earring",
		rear="Evans Earring",  --Perp -2
		body="Apogee dalmatica +1", --Refresh +4
		hands={ name="Merlinic Dastanas", augments={'Pet: Accuracy+28 Pet: Rng. Acc.+28','Pet: "Dbl. Atk."+5','Pet: STR+5','Pet: Mag. Acc.+8',}},
		lring="Varar Ring", 
		rring="Varar Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Mag. Acc.+10','Pet: Haste+10','Pet: "Regen"+5',}},
		waist="Klouskap Sash",
		legs="Tali'ah Seraweels +2", 
		feet="Psycloth Boots"
    })
 
    -- Pet:DT build. Equipped when IdleMode is "PetDT".
    sets.aftercast.Avatar_DT = {
 
    }
 
    -- Perp down set used when ForceIlvl is ON. Use this mode to avoid Selenian Cap dropping ilvl.
    sets.aftercast.Avatar_DT_Ilvl = set_combine(sets.aftercast.Avatar_DT, {

    })
 
    -- DT build with avatar out. Equipped when IdleMode is "DT".
    sets.aftercast.Perp_DT = set_combine(sets.DT_Base, {

    })
 
    sets.aftercast.Spirit = {
		head="Beckoner's Horn +1",  --13
		body="Baayami Robe", --32
		neck="Incanter's Torque", --10
		hands="Lamassu Mitts +1", --21
		rring="Evoker's Ring", --10
		back="Conveyance Cape", --10
		lring="Stikini Ring +1",  --8
		feet="Baayami Sabots"  --24
    }
 
    -- ===================================================================================================================
    --      End of Sets
    -- ===================================================================================================================
	elements = {}

	elements.list = S{'Light','Dark','Fire','Ice','Wind','Earth','Lightning','Water'}
	spirits = S{"LightSpirit", "DarkSpirit", "FireSpirit", "EarthSpirit", "WaterSpirit", "AirSpirit", "IceSpirit", "ThunderSpirit"}
	elements.spirit_of = {['Light']="Light Spirit", ['Dark']="Dark Spirit", ['Fire']="Fire Spirit", ['Earth']="Earth Spirit",
        ['Water']="Water Spirit", ['Wind']="Air Spirit", ['Ice']="Ice Spirit", ['Lightning']="Thunder Spirit"}
 
    Buff_BPs_Healing = S{'Healing Ruby','Healing Ruby II','Whispering Wind','Spring Water'}
    Debuff_BPs = S{'Mewing Lullaby','Eerie Eye','Lunar Cry','Lunar Roar','Nightmare','Pavor Nocturnus','Ultimate Terror','Somnolence','Slowga','Tidal Roar','Diamond Storm','Sleepga','Shock Squall'}
    Debuff_Rage_BPs = S{'Moonlit Charge','Tail Whip'}
 
    Magic_BPs_NoTP = S{'Holy Mist','Nether Blast','Aerial Blast','Searing Light','Diamond Dust','Earthen Fury','Zantetsuken','Tidal Wave','Judgment Bolt','Inferno','Howling Moon','Ruinous Omen','Night Terror','Thunderspark'}
    Magic_BPs_TP = S{'Impact','Conflag Strike','Level ? Holy','Lunar Bay'}
    Merit_BPs = S{'Meteor Strike','Geocrush','Grand Fall','Wind Blade','Heavenly Strike','Thunderstorm'}
    Physical_BPs_TP = S{'Rock Buster','Mountain Buster','Crescent Fang','Spinning Dive'}
 
    AvatarList = S{'Shiva','Ramuh','Garuda','Leviathan','Diabolos','Titan','Fenrir','Ifrit','Carbuncle','Fire Spirit','Air Spirit','Ice Spirit','Thunder Spirit','Light Spirit','Dark Spirit','Earth Spirit','Water Spirit','Cait Sith','Alexander','Odin','Atomos'}
    TownIdle = S{"windurst woods","windurst waters","windurst walls","port windurst","bastok markets","bastok mines","port bastok","southern san d'oria","northern san d'oria","port san d'oria","upper jeuno","lower jeuno","port jeuno","ru'lude gardens","norg","kazham","tavnazian safehold","rabao","selbina","mhaura","aht urhgan whitegate","al zahbi","nashmau","western adoulin","eastern adoulin"}
    Salvage = S{"Bhaflau Remnants","Zhayolm Remnants","Arrapago Remnants","Silver Sea Remnants"}
 
    -- Select initial macro set and set lockstyle
    -- This section likely requires changes or removal if you aren't Pergatory
--    if pet.isvalid then
--        if pet.name=='Fenrir' then
--            send_command('input /macro book 15;wait .3;input /macro set 8;wait 3;input /lockstyleset '..StartLockStyle)
--        elseif pet.name=='Ifrit' then
--            send_command('input /macro book 15;wait .3;input /macro set 3;wait 3;input /lockstyleset '..StartLockStyle)
 --       elseif pet.name=='Titan' then
--            send_command('input /macro book 15;wait .3;input /macro set 4;wait 3;input /lockstyleset '..StartLockStyle)
 --       elseif pet.name=='Leviathan' then
 --           send_command('input /macro book 15;wait .3;input /macro set 6;wait 3;input /lockstyleset '..StartLockStyle)
 --       elseif pet.name=='Garuda' then
 --           send_command('input /macro book 15;wait .3;input /macro set 2;wait 3;input /lockstyleset '..StartLockStyle)
--        elseif pet.name=='Shiva' then
--            send_command('input /macro book 15;wait .3;input /macro set 5;wait 3;input /lockstyleset '..StartLockStyle)
--        elseif pet.name=='Ramuh' then
--            send_command('input /macro book 15;wait .3;input /macro set 7;wait 3;input /lockstyleset '..StartLockStyle)
--        elseif pet.name=='Diabolos' then
--            send_command('input /macro book 15;wait .3;input /macro set 9;wait 3;input /lockstyleset '..StartLockStyle)
--        elseif pet.name=='Cait Sith' then
--            send_command('input /macro book 15;wait .3;input /macro set 10;wait 3;input /lockstyleset '..StartLockStyle)
--        end
--    else
 --       send_command('input /macro book 15;wait .3;input /macro set 1;wait 3;input /lockstyleset '..StartLockStyle)
--    end
    -- End macro set / lockstyle section
end
 
function pet_change(pet,gain)
    idle()
end
 
function pretarget(spell,action)
    if not buffactive['Muddle'] then
        -- Auto Remedy --
        if AutoRemedy and (spell.action_type == 'Magic' or spell.type == 'JobAbility') then
            if buffactive['Paralysis'] or (buffactive['Silence'] and not AutoEcho) then
                cancel_spell()
                send_command('input /item "Remedy" <me>')
            end
        end
        -- Auto Echo Drop --
        if AutoEcho and spell.action_type == 'Magic' and buffactive['Silence'] then
            cancel_spell()
            send_command('input /item "Echo Drops" <me>')
        end
    end
end
 
function precast(spell)
    if pet_midaction() or spell.type=="Item" then
        return
    end
    -- Spell fast cast
    if spell.action_type=="Magic" then
        if spell.name=="Stoneskin" then
            equip(sets.precast.FC,{waist="Siegel Sash"})
        else
            equip(sets.precast.FC)
        end
    end
end
 
function midcast(spell)
    if pet_midaction() or spell.type=="Item" then
        return
    end
    -- BP Timer gear needs to swap here
    if (spell.type=="BloodPactWard" or spell.type=="BloodPactRage") and not buffactive["Astral Conduit"] then
        equip(sets.midcast.BP)
    -- Spell Midcast & Potency Stuff
    elseif sets.midcast[spell.english] then
        equip(sets.midcast[spell.english])
    elseif spell.name=="Elemental Siphon" then
        if pet.element=="Light" or pet.element=="Dark" then
            equip(sets.midcast.Siphon)
        else
            equip(sets.midcast.SiphonZodiac)
        end
    elseif spell.type=="SummonerPact" then
        equip(sets.midcast.Summon)
    elseif spell.type=="WhiteMagic" then
        if string.find(spell.name,"Cure") or string.find(spell.name,"Curaga") then
            equip(sets.midcast.Cure)
        elseif string.find(spell.name,"Protect") or string.find(spell.name,"Shell") then
            equip(sets.midcast.Enhancing,{ring2="Sheltered Ring"})
        elseif spell.skill=="Enfeebling Magic" then
            equip(sets.midcast.Enfeeble)
        elseif spell.skill=="Enhancing Magic" then
            equip(sets.midcast.Enhancing)
        else
            idle()
        end
    elseif spell.type=="BlackMagic" then
        if spell.skill=="Elemental Magic" then
            equip(sets.midcast.Nuke)
        end
    elseif spell.action_type=="Magic" then
        equip(sets.midcast.EnmityRecast)
    else
        idle()
    end
    -- Auto-cancel existing buffs
    if spell.name=="Stoneskin" and buffactive["Stoneskin"] then
        windower.send_command('cancel 37;')
    elseif spell.name=="Sneak" and buffactive["Sneak"] and spell.target.type=="SELF" then
        windower.send_command('cancel 71;')
    elseif spell.name=="Utsusemi: Ichi" and buffactive["Copy Image"] then
        windower.send_command('wait 1;cancel 66;')
    end
end
 
function aftercast(spell)
    if pet_midaction() or spell.type=="Item" then
        return
    end
    if string.find(spell.type,"BloodPact") and LagMode then
        equipBPGear(spell)
    elseif (not string.find(spell.type,"BloodPact") and not AvatarList:contains(spell.name)) or spell.interrupted then
        idle()
    end
end
 
function status_change(new,old)
    if new=="Idle" then
        idle()
    end
end
 
function buff_change(name,gain)
    if name=="Quickening" then
        idle()
    end
end
 
function pet_midcast(spell)
    if not LogMode then
        equipBPGear(spell)
    end
end
 
function pet_aftercast(spell)
    idle()
end
 
function equipBPGear(spell)
    if spell.name=="Perfect Defense" then
        equip(sets.pet_midcast.SummoningMagic)
    elseif spell.type=="BloodPactWard" then
        if Debuff_BPs:contains(spell.name) then
            equip(sets.pet_midcast.MagicAcc_BP)
        elseif Buff_BPs_Healing:contains(spell.name) then
            equip(sets.pet_midcast.Buff_Healing)
        else
            equip(sets.pet_midcast.Buff)
        end
    elseif spell.type=="BloodPactRage" then
        if spell.name=="Flaming Crush" then
            if AccMode then
                equip(sets.pet_midcast.FlamingCrush_Acc)
            else
                equip(sets.pet_midcast.FlamingCrush)
            end
        elseif ImpactDebuff and (spell.name=="Impact" or spell.name=="Conflag Strike") then
            equip(sets.pet_midcast.Impact)
        elseif Magic_BPs_TP:contains(spell.name) or string.find(spell.name," II") or string.find(spell.name," IV") then
            if AccMode then
                equip(sets.pet_midcast.Magic_BP_TP_Acc)
            else
                equip(sets.pet_midcast.Magic_BP_TP)
            end
        elseif Magic_BPs_NoTP:contains(spell.name) then
            if AccMode then
                equip(sets.pet_midcast.Magic_BP_NoTP_Acc)
            else
                equip(sets.pet_midcast.Magic_BP_NoTP)
            end
        elseif Merit_BPs:contains(spell.name) then
            if AccMode then
                equip(sets.pet_midcast.Magic_BP_TP_Acc)
            elseif spell.name=="Meteor Strike" and MeteorStrike>4 then
                equip(sets.pet_midcast.Magic_BP_NoTP)
            elseif spell.name=="Geocrush" and Geocrush>4 then
                equip(sets.pet_midcast.Magic_BP_NoTP)
            elseif spell.name=="Grand Fall" and GrandFall>4 then
                equip(sets.pet_midcast.Magic_BP_NoTP)
            elseif spell.name=="Wind Blade" and WindBlade>4 then
                equip(sets.pet_midcast.Magic_BP_NoTP)
            elseif spell.name=="Heavenly Strike" and HeavenlyStrike>4 then
                equip(sets.pet_midcast.Magic_BP_NoTP)
            elseif spell.name=="Thunderstorm" and Thunderstorm>4 then
                equip(sets.pet_midcast.Magic_BP_NoTP)
            else
                equip(sets.pet_midcast.Magic_BP_TP)
            end
        elseif Debuff_Rage_BPs:contains(spell.name) then
            equip(sets.pet_midcast.Debuff_Rage)
        else
            if AccMode then
                equip(sets.pet_midcast.Physical_BP_Acc)
            elseif Physical_BPs_TP:contains(spell.name) then
                equip(sets.pet_midcast.Physical_BP_TP)
            elseif buffactive["Aftermath: Lv.3"] then
                equip(sets.pet_midcast.Physical_BP_AM3)
            elseif Test>0 then
                equip(set_combine(sets.pet_midcast.Physical_BP, {body="Glyphic Doublet +3"}))
            else
                equip(sets.pet_midcast.Physical_BP)
            end
        end
    end
end
 
function self_command(command)
    IdleModeCommands = {'DD','Refresh','DT','Favor','PetDT','Zendik'}
    is_valid = false
 
    for _, v in ipairs(IdleModeCommands) do
        if command:lower()==v:lower() then
            IdleMode = v
            windower.add_to_chat(159,'"Idle Mode: ['..IdleMode..']"')
            idle()
            return
        end
    end
    if command:lower()=="accmode" then
        AccMode = AccMode==false
        is_valid = true
        windower.add_to_chat(159,'"AccMode: '..tostring(AccMode)..'"')
    elseif command:lower()=="impactmode" then
        ImpactDebuff = ImpactDebuff==false
        is_valid = true
        windower.add_to_chat(159,'"Impact Debuff: '..tostring(ImpactDebuff)..'"')
    elseif command:lower()=="forceilvl" then
        ForceIlvl = ForceIlvl==false
        is_valid = true
        windower.add_to_chat(159,'"Force iLVL: '..tostring(ForceIlvl)..'"')
    elseif command:lower()=="lagmode" then
        LagMode = LagMode==false
        is_valid = true
        windower.add_to_chat(159,'"Lag Compensation Mode: '..tostring(LagMode)..'"')
    elseif command:lower()=="meleemode" then
        if MeleeMode then
            MeleeMode = false
            enable("main","sub")
            windower.add_to_chat(159,'"Melee Mode: false"')
        else
            MeleeMode = true
            equip({main="Nirvana",sub="Elan Strap +1"})
            disable("main","sub")
            windower.add_to_chat(159,'"Melee Mode: true"')
        end
        is_valid = true
	    elseif command:lower() == 'siphon' then
        handle_siphoning()
    elseif command=="ToggleIdle" then
        is_valid = true
        if IdleMode=="Refresh" then
            IdleMode = "DT"
        elseif IdleMode=="DT" then
            IdleMode = "PetDT"
        elseif IdleMode=="PetDT" then
            IdleMode = "DD"
        else
            IdleMode = "Refresh"
        end
        windower.add_to_chat(159,'"Idle Mode: ['..IdleMode..']"')
    elseif command:lower()=="lowhp" then
        -- Use for "Cure 500 HP" objectives in Omen
        equip({head="Apogee Crown +1",body={ name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},legs="Apogee Slacks +1",feet="Apogee Pumps +1",back="Campestres's Cape"})
        return
    elseif string.sub(command:lower(),1,12)=="meteorstrike" then
        MeteorStrike = string.sub(command,13,13)
        windower.add_to_chat(159,'"Meteor Strike: '..MeteorStrike..'/5"')
        is_valid = true
    elseif string.sub(command:lower(),1,8)=="geocrush" then
        Geocrush = string.sub(command,9,9)
        windower.add_to_chat(159,'"Geocrush: '..Geocrush..'/5"')
        is_valid = true
    elseif string.sub(command:lower(),1,9)=="grandfall" then
        GrandFall = string.sub(command,10,10)
        windower.add_to_chat(159,'"Grand Fall: '..GrandFall..'/5"')
        is_valid = true
    elseif string.sub(command:lower(),1,9)=="windblade" then
        WindBlade = +string.sub(command,10,10)
        windower.add_to_chat(159,'"Wind Blade: '..WindBlade..'/5"')
        is_valid = true
    elseif string.sub(command:lower(),1,14)=="heavenlystrike" then
        HeavenlyStrike = string.sub(command,15,15)
        windower.add_to_chat(159,'"Heavenly Strike: '..HeavenlyStrike..'/5"')
        is_valid = true
    elseif string.sub(command:lower(),1,12)=="thunderstorm" then
        Thunderstorm = string.sub(command,13,13)
        windower.add_to_chat(159,'"Thunderstorm: '..Thunderstorm..'/5"')
        is_valid = true
    elseif command=="TestMode" then
        Test = Test + 1
        if Test==3 then
            Test = 0
        end
        is_valid = true
        windower.add_to_chat(159,'"Test Mode: '..tostring(Test)..'"')
    end
 
--    if not is_valid then
--        send_command('console_echo "gs c {Refresh|DT|DD|PetDT|Favor} {AccMode} {ImpactMode} {MeleeMode}"')
--    end
    idle()
end
 
function idle()
    --if TownIdle:contains(world.area:lower()) then
    --  return
    --end
    if pet.isvalid then
        if IdleMode=='DT' then
            equip(sets.aftercast.Perp_DT)
        elseif string.find(pet.name,'Spirit') then
            equip(sets.aftercast.Spirit)
        elseif IdleMode=='PetDT' then
            if ForceIlvl then
                equip(sets.aftercast.Avatar_DT_Ilvl)
            else
                equip(sets.aftercast.Avatar_DT)
            end
        elseif IdleMode=='Refresh' then
            if player.mpp < 50 then
                equip(sets.aftercast.Perp_RefreshSub50)
            else
                equip(sets.aftercast.Perp_Refresh)
            end
        elseif IdleMode=='Favor' then
            equip(sets.aftercast.Perp_Favor)
        elseif IdleMode=='Zendik' then
            equip(sets.aftercast.Perp_Zendik)
        elseif MeleeMode then
            equip(sets.aftercast.Perp_Melee)
        elseif IdleMode=='DD' then
            equip(sets.aftercast.Perp_DD)
        end
        -- Gaiters if Fleet Wind is up
        if buffactive['Quickening'] and IdleMode~='DT' and not ForceIlvl then
            equip({feet="Herald's Gaiters"})
        end
    else
        if IdleMode=='DT' then
            equip(sets.aftercast.DT)
        elseif MeleeMode and IdleMode=='DD' then
            equip(sets.aftercast.Perp_Melee)
        elseif ForceIlvl then
            equip(sets.aftercast.Idle_Ilvl)
        else
            equip(sets.aftercast.Idle)
        end
    end
 end

-- Custom uber-handling of Elemental Siphon
function handle_siphoning()
 
    local siphonElement
    local stormElementToUse
    local releasedAvatar
    local dontRelease
   
    -- If we already have a spirit out, just use that.
    if pet.isvalid and spirits:contains(pet.name) then
        siphonElement = pet.element
        dontRelease = true
        -- If current weather doesn't match the spirit, but the spirit matches the day, try to cast the storm.
        if player.sub_job == 'SCH' and pet.element == world.day_element and pet.element ~= world.weather_element then
--            if not S{'Light','Dark','Lightning'}:contains(pet.element) then
--                stormElementToUse = pet.element
--            end
	    stormElementToUse = pet.element
        end
    -- If we're subbing /sch, there are some conditions where we want to make sure specific weather is up.
    -- If current (single) weather is opposed by the current day, we want to change the weather to match
    -- the current day, if possible.
    elseif player.sub_job == 'SCH' and world.weather_element ~= 'None' then
        -- We can override single-intensity weather; leave double weather alone, since even if
        -- it's partially countered by the day, it's not worth changing.
        if get_weather_intensity() == 1 then
            -- If current weather is weak to the current day, it cancels the benefits for
            -- siphon.  Change it to the day's weather if possible (+0 to +20%), or any non-weak
            -- weather if not.
            -- If the current weather matches the current avatar's element (being used to reduce
            -- perpetuation), don't change it; just accept the penalty on Siphon.
            if world.weather_element == elements.weak_to[world.day_element] and
                (not pet.isvalid or world.weather_element ~= pet.element) then
                -- We can't cast lightning/dark/light weather, so use a neutral element
--                if S{'Light','Dark','Lightning'}:contains(world.day_element) then
--                    stormElementToUse = 'Wind'
--                else
--                    stormElementToUse = world.day_element
--                end
				stormElementToUse = world.day_element
            end
        end
    end
   
    -- If we decided to use a storm, set that as the spirit element to cast.
    if stormElementToUse then
        siphonElement = stormElementToUse
    elseif world.weather_element ~= 'None' and (get_weather_intensity() == 2 or world.weather_element ~= elements.weak_to[world.day_element]) then
        siphonElement = world.weather_element
    else
        siphonElement = world.day_element
    end

    local command = ''
    local releaseWait = 0
    local elementused = ''
   
    if pet.isvalid and AvatarList:contains(pet.name) then
        command = command..'input /pet "Release" <me>;wait 1.1;'
        releasedAvatar = pet.name
        releaseWait = 10
    end
   
    if stormElementToUse then
        command = command..'input /ma "'..elements.storm_of[stormElementToUse]..'" <me>;wait 5;'
        releaseWait = releaseWait - 4
	elementused = stormElementToUse
    end
   
    if not (pet.isvalid and spirits:contains(pet.name)) then
        command = command..'input /ma "'..elements.spirit_of[siphonElement]..'" <me>;wait 5;'
        releaseWait = releaseWait - 4
	elementused = siphonElement
    end
	if world.day_element ~= "Light" and world.day_element ~= "Dark" then
		sets.midcast.Siphon = set_combine(sets.midcast.Siphon,sets.SiphonZodiac)
	else
		sets.midcast.Siphon = set_combine(sets.midcast.Siphon,sets.SiphonLightDarkDay)
	end
   
    command = command..'input /ja "Elemental Siphon" <me>;'
    releaseWait = releaseWait - 1
    releaseWait = releaseWait + 0.1
   
    if not dontRelease then
        if releaseWait > 0 then
            command = command..'wait '..tostring(releaseWait)..';'
        else
            command = command..'wait 1.1;'
        end
       
        command = command..'input /pet "Release" <me>;'
    end
   
    if releasedAvatar then
        command = command..'wait 1.1;input /ma "'..releasedAvatar..'" <me>'
    end
   
    send_command(command)
end
