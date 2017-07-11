--[#3 Magical Pacts ]--
--Used for Magical Blood Pacts
sets.petmab = { 
		main="Espiritus",
		head="Apogee Crown",
		body="Convoker's Doublet +2",
		neck="Adad Amulet",
		hands={ name="Merlinic Dastanas", augments={'Pet: Attack+30 Pet: Rng.Atk.+30','Blood Pact Dmg.+10','Pet: STR+1','Pet: Mag. Acc.+14','Pet: "Mag.Atk.Bns."+15',}},
		legs="Enticer's Pants",
		feet="Apogee Pumps",
		back="Campestres's Cape",
		lring="Speaker's Ring",
		rring="Evoker's Ring"

	--waist="Kobo Obi",
	--back=conveyance
}

sets.petmabacc = set_combine(sets.petmab,{ 
--	hands="Apogee Mitts +1",
})

sets.pethybridacc = set_combine(sets.petmab,{ 
--	hands="Apogee Mitts +1",
})

--[#4 Ward Pacts ]--
--Max out Summoning Magic Skill
--this will be used for many types of wards, max your summoning skill for longer ward duration and more magic acc
--wards can be empowered by empy bonus your call on to use it or not
sets.smnskill = { 
		body="Beckoner's Doublet +1",
		neck="Incanter's Torque",
		rring="Evoker's Ring",
		back="Conveyance Cape",
		lring="Stikini Ring",
		feet="Apogee Pumps"
}

--uses the smnskill set as base, if you want to override anything htat set you may do so here
sets.midcast.Pet.BloodPactWard = { 
}

sets.midcast.Pet.BloodPactWard = set_combine(sets.smnskill,sets.midcast.Pet.BloodPactWard)

sets.ward = sets.midcast.Pet.BloodPactWard

--you want to put tp bonus and + to hp here for stronger cures, smn skill won't matter this is for healing wards mostly
sets.midcast.Pet.HealingWard = {
--	hands="Apogee Mitts +1",
	body="Convoker's Doublet +2",
--	feet="Apogee Pumps +1",
	--Fill the rest with HP gear so you don't lose HP
	neck="Sanctity Necklace", --HP+35
	left_ring="Defending Ring",
	waist="Gishdubar sash",
}

sets.healingward = sets.midcast.Pet.HealingWard

sets.midcast.Pet.TPBloodPactWard = set_combine(sets.smnskill,{
	body="Beckoner's Doublet +1",
	legs="Enticer's Pants"
})

sets.midcast.Pet.DebuffBloodPactWard = { --override your smnskill set here, these are wards that target monsters, I leave it as maxing out smn skill for magic accuracy, but you could put other things here
		body="Beckoner's Doublet +1",
		neck="Incanter's Torque",
		rring="Evoker's Ring",
		back="Conveyance Cape",
		lring="Stikini Ring",
		feet="Apogee Pumps"
}

sets.midcast.Pet.DebuffBloodPactWard = set_combine(sets.smnskill,sets.midcast.Pet.DebuffBloodPactWard)

sets.debuff = sets.midcast.Pet.DebuffBloodPactWard

--[#5 Physical Pacts ]--
sets.midcast.Pet.PhysicalBloodPactRage = { --does physical damage only, like pred claws and spinning dive and volt strike
		main="Keraunos",
		head="Apogee Crown",
		body="Convoker's Doublet +2",
		hands={ name="Merlinic Dastanas", augments={'Pet: Attack+30 Pet: Rng.Atk.+30','Blood Pact Dmg.+10','Pet: STR+1','Pet: Mag. Acc.+14','Pet: "Mag.Atk.Bns."+15',}},
		legs="Enticer's Pants",
		back="Campestres's Cape",
		feet="Apogee Pumps",
		rring="Varar Ring",
		lring="Thurandaut Ring"
}
sets.physicalpact = sets.midcast.Pet.PhysicalBloodPactRage

sets.midcast.Pet.PhysicalBloodPactRageAcc = set_combine(sets.midcast.Pet.PhysicalBloodPactRage,{
--	hands="Apogee Mitts +1",
})

sets.midcast.Pet.TPPhysicalBloodPactRage = set_combine(sets.midcast.Pet.PhysicalBloodPactRage,{})

sets.midcast.Pet.TPPhysicalBloodPactRageAcc = set_combine(sets.midcast.Pet.PhysicalBloodPactRageAcc,{})

--[#6 Hybrid Pacts ]--
sets.midcast.Pet.HybridBloodPactRage = { --At this time is only your flaming crush set
		main="Espiritus",
		head="Apogee Crown",
		body="Convoker's Doublet +2",
		neck="Incanter's Torque",
		hands={ name="Merlinic Dastanas", augments={'Pet: Attack+30 Pet: Rng.Atk.+30','Blood Pact Dmg.+10','Pet: STR+1','Pet: Mag. Acc.+14','Pet: "Mag.Atk.Bns."+15',}},
		legs="Enticer's Pants",
		feet="Apogee Pumps",
		back="Campestres's Cape",
		lring="Speaker's Ring",
		rring="Varar Ring"
}
sets.hybridpact = sets.midcast.Pet.HybridBloodPactRage

sets.midcast.Pet.HybridBloodPactRageAcc = set_combine(sets.midcast.Pet.HybridBloodPactRage,{
--	hands="Apogee Mitts +1",
})

sets.midcast.Pet.MagicalBloodPactRage = sets.petmab

--This is where petmab set fills in anything you didn't specifically define
--basically petmab is the "default" set and you customize each situational set how you liked above
--this cuts down on the need to fill in the same items over and over for each set
sets.midcast.Pet.MagicalBloodPactRage = set_combine(sets.petmab,sets.midcast.Pet.MagicalBloodPactRage)
sets.midcast.Pet.MagicalBloodPactRageAcc = set_combine(sets.midcast.Pet.MagicalBloodPactRage,sets.petmabacc)
sets.midcast.Pet.TPMagicalBloodPactRage = set_combine(sets.petmab,{legs=enticers})
sets.midcast.Pet.TPMagicalBloodPactRageAcc = set_combine(sets.midcast.Pet.TPMagicalBloodPactRage,sets.petmabacc)
--sets.midcast.Pet.IfritMagicalBloodPactRage = set_combine(sets.petmab,{left_ring="Speaker's Ring",right_ring="Fervor Ring"})
sets.midcast.Pet.IfritMagicalBloodPactRage = sets.midcast.Pet.MagicalBloodPactRage
sets.midcast.Pet.IfritMagicalBloodPactRageAcc = set_combine(sets.midcast.Pet.IfritMagicalBloodPactRage,sets.petmabacc)

sets.magicalpact = sets.midcast.Pet.MagicalBloodPactRage
--Helios Notes
--MAX: crit 20% mab 150 bpdmg 35
--AT: crit 19% mab 142 bpdmg 23
--MISSING: crit 1% mab 8 bpdmg 12

--[#7 Toggled/Situational Sets ]--
sets.cpmode = {back="Aptitude Mantle +1"}


sets.latent_refresh = {waist="Fucho-no-obi"}

--for when you wanna melee for self skill chains, aftermath, procing voidwatch, or just wanna crack some skulls the old fashioned way
sets.tplock = { 
	main="Espiritus",
	sub="Elan Strap"
}

sets.kclub = {
}

sets.inwkr = {
--	neck="Arciela's Grace +1"
}

--Feet is your biggest -perp slot, especially with apogee+1 being a massive -9.  Evans earring can help counter this, I keep moonshade on my right ear.  Lucidity helps too ofc.  
--This is automatically equipped when you use fleet wind, and if you're moving between points and then engaging things a lot (such as assault) I found I could be low mana, so this mostly fixed that.
sets.movement = { 
	left_ear="Evans earring",
--	waist="Lucidity sash",
	feet="Herald's Gaiters"
}
sets.movementtown = { 
	feet="Herald's Gaiters"
}

--When you zone into mog gardens, what you wear, might have to hit f12 to force a gear update sometimes
sets.farmer = { 
feet="Herald's Gaiters"
}

--For more movement in Adoulin
sets.adoulinmovement = { 
	body="Councilor's Garb"
}

sets.crafting = {
}

--[ Items To Keep with Organizer ]--
organizer_items = {
}


--[#8 Job Abilities ]--

-- Precast sets to enhance JAs

sets.precast.JA['Astral Flow'] = {head="Glyphic Horn +1"}

sets.precast.JA['Mana Cede'] = {}

sets.precast.JA['Elemental Siphon'] = {
	body="Beckoner's Doublet +1",
	neck="Incanter's Torque",
	rring="Evoker's Ring",
	back="Conveyance Cape",
	lring="Stikini Ring",
	feet="Apogee Pumps"
}

sets.SiphonZodiac = {
--	left_ring="Zodiac Ring",--use on all but light or darks day
}
sets.SiphonLightDarkDay = {
--	left_ring="Globidonta Ring", --used on darks and lights day only
}

useall_bp_reduction_gear = true


if useall_bp_reduction_gear then 
	-- Pact delay reduction gear
	sets.precast.BloodPactWard = { 
		main="Espiritus",
		Head="Glyphic Horn +1", -- Delay -8
		body="Shomonjijoe +1", -- Delay -8
		rear="Evans Earring", -- Delay -2
--		ammo="Sancus Sachet", --Recast time II -6
		lring="Stikini Ring", -- Summoning Magic +5
		back="Conveyance Cape",  -- Delay II -3
		feet="Apogee Pumps"
	}
	--Delay -18 (max 15)
	--Delay II -9 (max 15)
	--Delay III -0 (max 10)

else
	-- Pact delay reduction gear
	sets.precast.BloodPactWard = { --with gifts this really all you need
		main="Espiritus",
		Head="Glyphic Horn +1", -- Delay -8
		body="Shomonjijoe +1", -- Delay -8
		rear="Evans Earring", -- Delay -2
--		ammo="Sancus Sachet", --Recast time II -5
		lring="Stikini Ring",  -- Summoning Magic +5
		feet="Apogee Pumps",
		back="Conveyance Cape"
}

end


-- sets.precast.BloodPactWard = set_combine(sets.smnskill,sets.precast.BloodPactWard)
sets.precast.BloodPactWard = {
		main="Espiritus",
		Head="Glyphic Horn +1", -- Delay -8
		body="Shomonjijoe +1", -- Delay -8
		rear="Evans Earring", -- Delay -2
--		ammo="Sancus Sachet", --Recast time II -6
		lring="Stikini Ring", -- Summoning Magic +5
		back="Conveyance Cape",
		feet="Apogee Pumps"
}

sets.precast.BloodPactRage = sets.precast.BloodPactWard


sets.burstmode = {}

sets.burstmode.Burst = {
--	hands=glyphicbracers,
}

--[#9 Fast Cast ]--

-- Fast cast sets for spells
sets.precast.FC = {
		head="Vanya Hood", --10
		neck="Baetyl Pendant",  --4
		lear="Loquacious Earring",  --2
		body="Eirene's Manteel",  --10
		hands="Telchine Gloves",  --4
		lring="Kishar Ring",  --5
		rring="Prolix Ring",  --2
		back="Campestres's Cape",
		waist="Witful Belt",  --3
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+2','"Fast Cast"+5','MND+2','"Mag.Atk.Bns."+10',}},  --10
		legs="Psycloth Lappas"  --7
}
-- 57%

sets.keepfc = {
}
--ammo --+2


if player.sub_job == 'RDM' then
	sets.precast.FC = set_combine(sets.precast.FC, {
	})
end
--RDM 12 quick cast, 93 fastcast

sets.precast.FC['Stoneskin'] = {
		head="Vanya Hood", --10
		neck="Baetyl Pendant",  --4
		lear="Loquacious Earring",  --2
		body="Eirene's Manteel",  --10
		hands="Telchine Gloves",  --4
		lring="Kishar Ring",  --5
		rring="Prolix Ring",  --2
		back="Campestres's Cape",
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+2','"Fast Cast"+5','MND+2','"Mag.Atk.Bns."+10',}},  --10
		legs="Psycloth Lappas",  --7
		waist="Siegel Sash" --8
}


sets.precast.Interrupt = {
}

--this is still in the works for me, I want it to work that it makes compromises between casting speed, keeping you alive, 
--spell interuption gear, and skill gear for that type of spell to reduce interuption rate
if use_resistant then
	sets.precast.FC.Resistant = { 
	}
end
--39
--    sets.precast.FC['Cure'] = set_combine(sets.precast.FC, {
--    })


--[#10 Weapon Skills ]--
-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
-- Default set for any weaponskill that isn't any more specifically defined
sets.precast.WS = {}
sets.precast.PhysicalWS = {
}

sets.precast.WS = sets.precast.PhysicalWS

sets.precast.WS['Shattersoul'] =  {
		head="Telchine Cap",
		neck="Fotia Gorget",
		lear="Mache Earring",
		rear="Cessance Earring",
		body="",
		hands="Amalric Gages",
		lring="Etana Ring",
		rring="Vertigo Ring",
		back="Campestres's Cape",
		waist="Fotia Belt",
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic burst dmg.+9%','INT+14',}},
		legs="Gyve Trousers"}

sets.precast.WS['Myrkr'] = {
		head="Pixie Hairpin +1",
		neck="Sanctity Necklace",
		lear="Mendicant's Earring",
		rear="Loquacious Earring",
		body="Beckoner's Doublet +1",
		hands="Telchine Gloves",
		lring="Sangoma Ring",
		rring="Etana Ring",
		waist="Fucho-No-Obi",
		legs="Amalric Slops",
		feet="Psycloth Boots"		
		}
		--Total MP = 2265 outside Escha

if use_player_mab then
	sets.precast.MagicalWS = {
	}
	sets.precast.WS['Flash Nova'] = set_combine(sets.precast.MagicalWS, {
	})
	sets.precast.WS['Shattersoul'] = set_combine(sets.precast.MagicalWS, {
	})
	sets.precast.WS['Rock Crusher'] = set_combine(sets.precast.MagicalWS, {
	})
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.MagicalWS, {
	})
	sets.precast.WS['Cataclysm'] = set_combine(sets.precast.MagicalWS, {
	})
	sets.precast.WS['Shining Strike'] = set_combine(sets.precast.MagicalWS, {
	})
	sets.precast.WS['Garland of Bliss'] = set_combine(sets.precast.MagicalWS, {
	})
else 
	sets.precast.WS['Garland of Bliss'] = { --left mab in moghouse, so use empty set
	}

end


--[#11 Midcast Sets ]--
sets.midcast.Cure = {
		head="Vanya Hood",  --10%
		body="Vrokodara Jupon", --13%
		neck="Incanter's Torque",
		lear="Mendicant's Earring", --5%
		rear="Static Earring",
		hands="Telchine Gloves",  --10%
		lring="Ephedra Ring",
		rring="Sirona's Ring",
		back="Campestres's Cape",
		waist="Rumination Sash",
		legs="Gyve Trousers",  --10%
		feet="Vanya Clogs"  --10%
		}
		--58%
		
--When you are SCH subjob and cast aurorastorm it will use these items for much more potent Cure 3
sets.midcast.CureAurora = {
}

sets.midcast.CureAurora = set_combine(sets.midcast.Cure,sets.midcast.CureAurora)


sets.midcast.CureSelf = set_combine(sets.midcast.Cure,{--cure recieved gear
	waist="Gishdubar Sash",
})

sets.midcast.CureSelfAurora = set_combine(sets.midcast.Cure,{
	waist="Gishdubar Sash",
})

sets.midcast.Weather = {
}

sets.midcast['Summoning Magic'] = {
		body="Beckoner's Doublet +1",
		neck="Incanter's Torque",
		rring="Evoker's Ring",
		back="Conveyance Cape",
		lring="Stikini Ring",
		feet="Apogee Pumps"}

sets.midcast.Cursna = {
		head="Vanya Hood", -- 10
		body="Eirene's Manteel", -- 10
		hands="Gendewitha Gages",  -- 7
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}}, -- 7
		feet="Vanya Clogs",  -- Cursna +5
		neck="Baetyl Pendant",  -- 4
		waist="Gishdubar Sash", --Cursna +10
		lear="Loquacious Earring",  -- 2
		back="Campestres's Cape",
		left_ring="Kishar Ring",  --4
		right_ring="Ephedra Ring"}  --Cursna +10
		-- Cursna +25, FC 37
         
sets.midcast.CursnaSelf = {
		head="Vanya Hood", -- 10
		body="Eirene's Manteel", -- 10
		hands="Gendewitha Gages",  -- 7
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}}, -- 7
		feet="Vanya Clogs",  -- Cursna +5
		neck="Baetyl Pendant",  -- 4
		waist="Gishdubar Sash", --Cursna +10
		lear="Loquacious Earring",
		back="Campestres's Cape",		-- 2
		left_ring="Kishar Ring",  --2
		right_ring="Ephedra Ring"}  --Cursna +10
		-- Cursna +25, FC 37

sets.midcast.CursnaSelf = set_combine(sets.midcast.Cursna,sets.midcast.CursnaSelf)

sets.midcast['Enhancing Magic'] = {
		head="Telchine Cap",
		neck="Icanter's Torque",
		lear="Static Earring",
		rear="Loquacious Earring",
		body="Telchine Chasuble",
		hands="Telchine Gloves",
		lring="Stikini Ring",
		rring="Kishar Ring",
		back="Campestres's Cape",
		waist="Latria Sash",
		legs="Psycloth Lappas",
		feet="Telchine Pigaches"
		
}

sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'],{
--	head="Inyanga Tiara +1"
})

sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'],{
		neck="Nodens Gorget",
		waist="Siegel Sash",
		legs="Haven Hose"
})


sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'],sets.midcast.Stoneskin)

sets.midcast.Refresh = {
}

sets.midcast.Phalanx = {
		head="Befouled Crown",
}

sets.midcast.RefreshSelf = {
		waist="Gishdubar Sash",
		back="Grapevine Cape"
}

sets.midcast.Aquaveil = {
}

sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'],sets.midcast.Refresh)

sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'],sets.midcast.Phalanx)

sets.midcast.Refresh = set_combine(sets.midcast.Refresh,sets.midcast.RefreshSelf)

if use_player_mab then
	sets.midcast['Elemental Magic'] = {
	}
else
	sets.midcast['Elemental Magic'] = {
	}
end

if use_enfeeb then --mostly useful as sch subjob for dispel, or helping proc immunobreak on rdm sub
	sets.midcast['Enfeebling Magic'] = {
		main="Grioavolr",
		head="Befouled Crown",
		neck="Incanter's Torque",
		lear="Gwati Earring",
		rear="Choleric Earring",
		body="Vanya Robe",
		hands="Lurid Mitts",
		lring="Stikini Ring",
		rring="Kishar Ring",
		back="Campestres's Cape",
		waist="Rumination Sash",
		legs="Psycloth Lappas",
		feet="Medium's Sabots",
		sub="Enki Strap"
	}

end

    sets.midcast['Dark Magic'] = {
    }

sets.midcast.interruption = {
}

--sets.midcast.interruption = set_combine(sets.petmab,sets.midcast.interruption)
-- Avatar pact sets.  All pacts are Ability type.


-- Spirits cast magic spells, which can be identified in standard ways.

--    sets.midcast.Pet.WhiteMagic = {
--    }

--    sets.midcast.Pet['Elemental Magic'] = set_combine(sets.midcast.Pet.BloodPactRage, {legs="Helios spats"})
-- 
--    sets.midcast.Pet['Elemental Magic'].Resistant = {}


--[#12 Idle/DT sets ]--

-- Resting sets
sets.resting = {
		head="Befouled Crown",
		neck="Bathy Choker +1",
		lear="Hearty Earring",
		rear="Evans Earring",
		body="Shomonjijoe +1",
		hands={ name="Merlinic Dastanas", augments={'DEX+4','AGI+8','"Refresh"+2',}},
		lring="Paguroidea Ring",
		rring="Defending Ring",
		back="Campestres's Cape",
		waist="Fucho-No-Obi",
		feet={ name="Merlinic Crackows", augments={'INT+8','"Fast Cast"+2','"Refresh"+2','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
		legs="Assiduity Pants +1"
}

sets.idlekeep = {
}

-- Idle sets
sets.idle = {
		sub="Enki Strap",
		head="Befouled Crown",
		neck="Bathy Choker +1",
		lear="Hearty Earring",
		rear="Eabani Earring",
		body="Witching Robe",
		hands={ name="Merlinic Dastanas", augments={'DEX+4','AGI+8','"Refresh"+2',}},
		lring="Shukuyu Ring",
		rring="Defending Ring",
		back="Solemnity Cape",
		waist="Slipor Sash",
		feet={ name="Merlinic Crackows", augments={'INT+8','"Fast Cast"+2','"Refresh"+2','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
		legs="Assiduity Pants +1"
		}

sets.damagetaken = {}

sets.damagetaken.None = {
}
sets.damagetaken.DT = {
}

sets.damagetaken.PDT = { --
}

sets.damagetaken.MDT = {--Shell V is around 24%
}

sets.magiceva = {
}

sets.pullmode = set_combine(sets.damagetaken.MDT,{body="Vanya Robe",feet="Hippomenes Socks +1"})

sets.pullmode2 = {
}

--sets.damagetaken.MagicEvasion = {
--}

sets.petdamagetaken = {}

sets.petdamagetaken.DT = {
}


sets.petdamagetaken.Full = {
}

sets.precast.FC.PDT = set_combine(sets.precast.FC, sets.damagetaken.PDT)

sets.idle.PDT = {--mixes refresh with pdt
}

-- perp costs:
-- spirits: 7
-- carby: 11 (5 with mitts)
-- fenrir: 13
-- others: 15
-- avatar's favor: free, if you minimized perp cost already, -4 a tick with no -perp gear.  Weird I know but it's true, test it yourself

-- Max useful -perp gear is 1 less than the perp cost (can't be reduced below 1)
-- Aim for -14 perp, and refresh in other slots.
--

sets.idle.PDT = {}

sets.idle.Spirit = set_combine(sets.midcast.Pet.BloodPactWard, {})

--[#13 Perp Sets ]--
sets.idle.Avatar = { 
		main="Gridarvor",  --Perp -5
		head="Befouled Crown", --Refresh +1
		neck="Caller's Pendant",
		lear="Domesticator's Earring",
		rear="Evans Earring",  --Perp -2
		body="Shomonjijoe +1",  --Refresh +3
		hands={ name="Merlinic Dastanas", augments={'DEX+4','AGI+8','"Refresh"+2',}},
		lring="Thurandaut Ring",
		rring="Defending Ring",
		back="Campestres's Cape",
		waist="Slipor Sash",
		feet="Apogee Pumps", --Perp -8
		legs="Assiduity Pants +1", --Perp -3
}
		-- Total Perp -16

sets.favor= {}

sets.favor.mpsaver={ -- don't sacrifice refresh gear for smn skill gear
}

sets.favor.mpsaver=sets.idle.Avatar
sets.favor.allout={ -- equip all the favor and smn skill you can while not losing MP
}
sets.idle.Spirit = set_combine(sets.midcast.Pet.BloodPactWard, {main="Nirvana",left_ear=moonshade,legs=glyphicspats})
sets.perp = sets.idle.Avatar
sets.engaged = sets.perp 
sets.engaged.Perp = sets.perp
sets.idlehealer = {
}
sets.perp.Weather = {neck="Caller's Pendant"}
sets.perp.Carbuncle = set_combine(sets.perp, {})
sets.perp['Cait Sith'] = set_combine(sets.perp, {})
sets.perp.LightSpirit = set_combine(sets.midcast.Pet.BloodPactWard, {})
sets.perp.AirSpirit = set_combine(sets.midcast.Pet.BloodPactWard, {})
sets.perp.FireSpirit = set_combine(sets.midcast.Pet.BloodPactWard, {})

--[#14 Avatar Melee/DT Sets ]--
sets.Avatar = {}

sets.Avatar.Haste = { --Warning! This set equipped whenever your pet is engaged, even if you aren't
		main="Gridarvor", --Perp -5
		head="Glyphic Horn +1", --Perp -4
		neck="Caller's Pendant",
		lear="Domesticator's Earring",
		rear="Evans Earring",  --Perp -2
		body="Shomonjijoe +1",
		hands={ name="Merlinic Dastanas", augments={'DEX+4','AGI+8','"Refresh"+2',}},
		lring="Thurandaut Ring",
		rring="Varar Ring",
		back="Campestres's Cape",
		waist="Klouskap Sash",
		legs="Assiduity Pants +1", --Perp -3
		feet="Psycloth Boots"
}
		--Total Perp -14
		
sets.Avatar.Haste.Full = { --Warning! This set equipped whenever your pet is engaged, even if you aren't
}


--[#15 Engaged Sets ]--
if use_melee then
	sets.engaged.Melee = {
	}

	sets.meleehybrid = {
	}
else
	sets.engaged.Melee = {
	}
	sets.engaged.Kclub = {
	}
end
