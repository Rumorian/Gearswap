-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('organizer-lib')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Sentinel = buffactive.sentinel or false
    state.Buff.Cover = buffactive.cover or false
    state.Buff.Doom = buffactive.Doom or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'PDT', 'MDT')
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'HP', 'Reraise', 'Charm')
    state.MagicalDefenseMode:options('MDT', 'HP', 'Reraise', 'Charm')
	state.IdleMode:options('Normal', 'DT', 'MDT')
    
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'MP', 'Knockback', 'MP_Knockback'}
    state.EquipShield = M(false, 'Equip Shield w/Defense')

    update_defense_mode()
    
--    send_command('bind ^f11 gs c cycle MagicalDefenseMode')
--    send_command('bind !f11 gs c cycle ExtraDefenseMode')
 --   send_command('bind @f10 gs c toggle EquipShield')
--    send_command('bind @f11 gs c toggle EquipShield')

    select_default_macro_book()
	set_lockstyle()
end

function user_unload()
 --   send_command('unbind ^f11')
 --   send_command('unbind !f11')
 --   send_command('unbind @f10')
 --   send_command('unbind @f11')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------
	
    sets.precast.Enmity = {
		head="Souveran Schaller",  --7
		neck="Unmoving Collar", --9
		waist="Creed Baudrier", --5
		lear="Friomisi Earring",  --2
		body="Souveran Cuirass",  --17
		hands="Macabre Gauntlets +1", --7
		lring="Petrov Ring",  --4
		rring="Apeile Ring +1", --5-9
		back="Rudianos's Mantle", --7
		legs="Souveran Diechlings", --7
		feet="Eschite Greaves" --15
	}
	--88-92
	--Brilliance = 14
	--Total = 102-106
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = set_combine(sets.precast.Enmity, {legs="Caballarius Breeches"})
    sets.precast.JA['Holy Circle'] = set_combine(sets.precast.Enmity, {})
    sets.precast.JA['Shield Bash'] = set_combine(sets.precast.Enmity, {hands="Caballarius Gauntlets"})
    sets.precast.JA['Sentinel'] = set_combine(sets.precast.Enmity, {feet="Caballarius Leggings"})
    sets.precast.JA['Rampart'] = set_combine(sets.precast.Enmity, {})
    sets.precast.JA['Fealty'] = set_combine(sets.precast.Enmity, {body="Caballarius Surcoat"})
    sets.precast.JA['Divine Emblem'] = set_combine(sets.precast.Enmity, {})
    sets.precast.JA['Cover'] = set_combine(sets.precast.Enmity, {})

    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {
		head="Carmine Mask +1",
		lear="Static Earring",
		body="Odyssean Chestplate",
		hands="Caballarius Gauntlets",
		rear="Static Earring",
		lear="Nourishing Earring",
		lring="Vertigo Ring",
		rring="Rufescent Ring",
		waist="Latria Sash",
		legs="Carmine Cuisses +1",
		feet="Carmine Greaves"
	}
    
	sets.precast.JA['Provoke'] = sets.precast.Enmity
	sets.precast.JA['Palisade'] = sets.precast.Enmity

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Step = {}
    sets.precast.Flourish1 = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
		ammo="Impatiens",
		head="Carmine Mask +1", --14
		neck="Baetyl Pendant",  --4
		lear="Loquacious Earring", --2
		body="Odyssean Chestplate",  --10
		hands="Leyline Gloves",  --8
		lring="Prolix Ring",  --2
		rring="Kishar Ring",  --4
		legs="Odyssean Cuisses", --6
		feet="Carmine Greaves"  --7
	}
	--57
	
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {rear="Nourishing Earring"}) --3%

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}

    sets.precast.WS.Acc = {}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

	--Requiescat: Modifier MND, use elemental gorgets (fotia, shadow, soil)
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
	})

    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {
	})

	--Modifier 80% DEX. Use Elemental Gorget/Belt as fTP gets transferred across all hits. Use crit rate/damage gear where possible.
    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
		head="Sulevia's Mask +1",
		neck="Lissome Necklace",
		lear="Mache Earring",
		rring="Cessance Earring",
		body="Souveran Cuirass",
		hands="Sulevia's Gauntlets +1",
		lring="Ramuh Ring",
		rring="Petrov Ring",
		waist="Windbuffet Belt +1",
		legs="Carmine Cuisses +1",
		feet="Thereoid Greaves"})
 
	sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS['Chant du Cygne'], {
	})

	--Sanguine Blade: Modifier 50% MND, 30% STR
    sets.precast.WS['Sanguine Blade'] = {
	}
    
	--Damage based on Enmity
    sets.precast.WS['Atonement'] = {
	}
	
	--Modifier 50% MND, 50% STR
    sets.precast.WS['Savage Blade'] = {
		head="Sulevia's Mask +1",
		neck="Fotia Gorget",
		lear="Mache Earring",
		rring="Cessance Earring",
		body="Souveran Cuirass",
		hands="Sulevia's Gauntlets +1",
		lring="Rufescent Ring",
		rring="Shukuyu Ring",
		waist="Fotia Belt",
		legs="Sulevia's Cuisses +1",
		feet="Sulevia's Leggings +1"	
	}
    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
		ammo="Impatiens",
		head="Carmine Mask +1",
		neck="Baetyl Pendant",
		lear="Loquacious Earring",
		body="Odyssean Chestplate",
		hands="Leyline Gloves",
		lring="Prolix Ring",
		rring="Kishar Ring",
		waist="Dynamic Belt +1",
		legs="Odyssean Cuisses", 
		feet="Carmine Greaves"
}
        
    sets.midcast.Enmity = {
		ammo="Impatiens",
		head="Souveran Schaller",  --7
		neck="Unmoving Collar", --9
		waist="Creed Baudrier", --5
		lear="Friomisi Earring",  --2
		body="Souveran Cuirass",  --17
		hands="Macabre Gauntlets +1", --7
		lring="Petrov Ring",  --4
		rring="Apeile Ring +1", --5-9
		back="Rudianos's Mantle", --7
		legs="Souveran Diechlings", --7
		feet="Eschite Greaves" --15
	}
	--88-92
	--Brilliance = 14
	--Total = 102-106
	
    sets.midcast.Flash = set_combine(sets.midcast.Enmity, {
	rear="Loquacious Earring"
	})
    
    sets.midcast.Stun = sets.midcast.Flash
	
    sets.midcast['Stinking Gas'] = sets.midcast.Enmity
    sets.midcast['Geist Wall'] = sets.midcast.Enmity
    sets.midcast['Jettatura'] = sets.midcast.Enmity
    sets.midcast['Soporific'] = sets.midcast.Enmity
    sets.midcast['Blank Gaze'] = sets.midcast.Enmity
    sets.midcast['Sounds Blast'] = sets.midcast.Enmity
    sets.midcast['Sheep Song'] = sets.midcast.Enmity
    sets.midcast['Chaotic Eye'] = sets.midcast.Enmity
    
    sets.midcast.Cure = {
		ammo="Impatiens",
		head="Souveran Schaller", --10% received
		neck="Incanter's Torque", --10 Healing Magic skill
		lear="Mendicant's Earring", --5% potency
		rear="Nourishing Earring", --5-6% potency
		body="Souveran Cuirass", --10% potency, 10% received
		hands="Macabre Gauntlets +1", --11% potency
		lring="Sirona's Ring", --10 Healing Magic skill
		rring="Apeile Ring +1", --5-9 Enmity
		waist="Rumination Sash", --MND +4, Spell Interruption -10%
		legs="Souveran Diechlings", --17% received
		feet="Eschite Greaves" --Spell Interruption -15%
	}
	--Cure potency 31-32 (caps at 50%)
	--Cure potency received 37% (caps at 30%)

    sets.midcast['Enhancing Magic'] = {
		head="Carmine Mask +1", --Enhancing Magic 11
		neck="Incanter's Torque", --Enhancing Magic 10
		lring="Stikini Ring", --Enhancing Magic 5
		waist="Rumination Sash", --Spell Interruption
		legs="Carmine Cuisses +1", --Enhancing Magic 18
	}
	--Enhancing Magic 394
	
	sets.midcast['Enlight'] = {
		ammo="Impatiens", --Spell Interruption -10
		head="Jumalik Helm",
		neck="Incanter's Torque",
		lear="Mendicant's Earring",
		rear="Lempo Earring",
		hands="Eschite Gauntlets", --Spell Interruption -15
		lring="Stikini Ring",
		waist="Rumination Sash",  --Spell Interruption -10
		feet="Eschite Greaves" --Spell Interruption -15
	}
	--Divine Magic Skill 503
	
    
	sets.midcast['Enlight II'] = sets.midcast['Enlight'] 
	
	sets.midcast['Holy'] = {
		ammo="Pemphredo Tathlum",
		head="Jumalik Helm",
		neck="Sanctity Necklace",
		lear="Friomisi Earring",
		rear="Hecate's Earring",
		body="Chozoron Coselete",
		hands="Leyline Gloves",
		lring="Kishar Ring",
		rring="Stikini Ring",
		waist="Rumination Sash",
		legs="Odyssean Cuisses", 
		feet="Eschite Greaves" --Enmity
	}
	
	sets.midcast['Holy II'] = sets.midcast['Holy'] 
		
	sets.midcast['Banish'] = sets.midcast['Holy']
	
	sets.midcast['Banish II'] = sets.midcast['Holy']
	
    sets.midcast.Protect = {lear="Brachyura Earring"}
    sets.midcast.Shell = {lear="Brachyura Earring"}
    
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    sets.Reraise = {head="Twilight Helm", body="Twilight Mail"}
    
    sets.resting = {
		
	}
    

    -- Idle sets
    sets.idle = {
		ammo="Homiliary",
		head="Sulevia's Mask +1",  --5 DT
		neck="Bathy Choker +1", 
		lear="Infused Earring",
		rear="Hearty Earring",
		body="Chozoron Coselete",  --8 DT
		hands="Souveran Handschuhs", --3 PDT, 4 MDT
		lring="Paguroidea Ring", --DEF 20, Regen
		rring="Defending Ring", --10 DT
		back="Rudianos's Mantle", --4 DT
		waist="Flume Belt",  --4 PDT
		legs="Carmine Cuisses +1", 
		feet="Sulevia's Leggings +1" --3 DT
	}
	--Brilliance + Priwen = 12 DT
	--30 DT
	--7 PDT

	sets.idle.DT = {
		sub="Ochain",
		ammo="Staunch Tathlum",
		head="Sulevia's Mask +1",  --5 DT
		neck="Bathy Choker +1", --Regen +3, Eva 5-15
		lear="Eabani Earring",
		rear="Hearty Earring",
		body="Chozoron Coselete",  --9 DT
		hands="Souveran Handschuhs", --3 PDT, 4 MDT
		lring="Paguroidea Ring", --DEF 20, Regen +2
		rring="Defending Ring", --10 DT
		back="Rudianos's Mantle", --4 DT
		waist="Flume Belt",  --4 PDT
		legs="Souveran Diechlings", --3 DT
		feet="Sulevia's Leggings +1" --3 DT
		}

	--Brilliance + Priwen = 12 DT
		--Total: 49 DT
	
	sets.idle.MDT = {
		ammo="Staunch Tathlum",
		head="Sulevia's Mask +1", --5 DT
		neck="Twilight Torque", --5 DT
		lear="Eabani Earring",
		rear="Hearty Earring",
		body="Souveran Cuirass", --9 DT
		hands="Souveran Handschuhs", --4 MDT, 3 PDT
		lring="Portus Annulet",
		rring="Defending Ring", --10 DT
		waist="Flume Belt",
		legs="Sulevia's Cuisses +1", --6 DT
		feet="Sulevia's Leggings +1" --3 DT	
	}
		
    sets.idle.Town = {
		main="Brilliance",
		sub="Aegis",
		legs="Carmine Cuisses +1",
		body="Councilor's Garb"
	}
    
    sets.idle.Weak = sets.idle
    
    sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)
    
    sets.Kiting = {
	legs="Carmine Cuisses +1"}

    sets.latent_refresh = {
	waist="Fucho-no-obi"}
	
	sets.latent_regen = {lring="Apeile Ring +1"}


    --------------------------------------
    -- Defense sets
    --------------------------------------
    
    -- Extra defense sets.  Apply these on top of melee or defense sets.
    sets.Knockback = {}
    sets.MP = {}
    sets.MP_Knockback = {}
    
    -- If EquipShield toggle is on (Win+F10 or Win+F11), equip the weapon/shield combos here
    -- when activating or changing defense mode:
    sets.PhysicalShield = {sub="Ochain"} -- Ochain
    sets.MagicalShield = {sub="Aegis"} -- Aegis

    -- Basic defense sets.
        
    sets.defense.PDT = {
		ammo="Staunch Tathlum",
		head="Sulevia's Mask +1",  --5 DT
		neck="Twilight Torque", --5 DT
		lear="Infused Earring",
		rear="Hearty Earring",
		body="Souveran Cuirass",  --9 DT
		hands="Souveran Handschuhs", --3 PDT, 4 MDT
		lring="Paguroidea Ring", --DEF 20, Regen
		rring="Defending Ring", --10 DT
		back="Rudianos's Mantle", --4 DT
		waist="",
		legs="Souveran Diechlings", --3 DT
		feet="Sulevia's Leggings +1" --3 DT
	}
	--Brilliance + Priwen = 12 DT
	--51% DT
	--3% PDT
	--4% MDT
 
 sets.defense.HP = {
 }

		sets.defense.Reraise = {
		}

		sets.defense.Charm = {
}

    -- To cap MDT with Shell IV (52/256), need 76/256 in gear.
    -- Shellra V can provide 75/256, which would need another 53/256 in gear.

    sets.defense.MDT = {
	}


    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    sets.engaged = {
		ammo="Amar Cluster",
		head="Souveran Schaller",  --7%
		neck="Lissome Necklace",
		lear="Bladeborn Earring",
		rear="Steelflash Earring",
		body="Souveran Cuirass",  --3%
		hands="Souveran Handschuhs", --4%
		lring="Petrov Ring",
		rring="Defending Ring",
		back="Rudianos's Mantle",
		waist="Dynamic Belt +1",  --6%
		legs="Souveran Diechlings",  --5%
		feet="Sulevia's Leggings +1"  --1%
	}
	--26% Haste

    sets.engaged.Acc = set_combine(sets.engaged, {
		head="Carmine Mask +1",
		lear="Mache Earring",
		rear="Cessance Earring",
		body="Sulevia's Platemail +1",
		hands="Sulevia's Gauntlets +1",
		lring="Portus Annulet",
		legs="Sulevia's Cuisses +1"
	})

    sets.engaged.DW = set_combine(sets.engaged, {
		ammo="Amar Cluster",
		head="Souveran Schaller",  --7%
		neck="Lissome Necklace",
		body="Souveran Cuirass",  --3%
		hands="Souveran Handschuhs", --4%
		lring="Petrov Ring",
		rring="Defending Ring",
		back="Rudianos's Mantle",
		waist="Dynamic Belt +1",  --6%
		legs="Souveran Diechlings",  --5%
		feet="Sulevia's Leggings +1"  --1%
	})

    sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {
		head="Carmine Mask +1",
		lear="Mache Earring",
		rear="Cessance Earring",
		body="Sulevia's Platemail +1",
		hands="Sulevia's Gauntlets +1",
		lring="Portus Annulet",
		legs="Sulevia's Cuisses +1"
	})

    sets.engaged.PDT = set_combine(sets.engaged, {
		ammo="Staunch Tathlum",
		head="Souveran Schaller",
		neck="Twilight Torque",
		lear="Eabani Earring",
		rear="Hearty Earring",
		lring="Vertigo Ring",
		legs="Sulevia's Cuisses +1",
	})
	
	sets.engaged.MDT = {
		ammo="Staunch Tathlum",
		head="Sulevia's Mask +1", --5 DT
		neck="Twilight Torque", --5 DT
		lear="Eabani Earring",
		rear="Hearty Earring",
		body="Souveran Cuirass", --9 DT
		hands="Souveran Handschuhs", --4 MDT, 3 PDT
		lring="Portus Annulet",
		rring="Defending Ring", --10 DT
		waist="Flume Belt", --4 PDT
		legs="Sulevia's Cuisses +1", --6 DT
		feet="Sulevia's Leggings +1" --3 DT
	}
	
	--Brilliance 3 DT
	--Total 44
	
	--PDT 48
	--MDT (94)
		

    sets.engaged.Acc.PDT = set_combine(sets.engaged.PDT, {
	})

   sets.engaged.DW.MDT = set_combine(sets.engaged.MDT, {
	})
	
   sets.engaged.Acc.MDT = set_combine(sets.engaged.MDT, {
	})
	
    sets.engaged.Reraise = set_combine(sets.engaged, sets.Reraise)

    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc, sets.Reraise)


    sets.engaged.DW.PDT = set_combine(sets.engaged.PDT, {
	})

    sets.engaged.DW.Acc.PDT = set_combine(sets.engaged.PDT, {
	})

    sets.engaged.DW.Reraise = set_combine(sets.engaged.DW, sets.Reraise)

    sets.engaged.DW.Acc.Reraise = set_combine(sets.engaged.DW.Acc, sets.Reraise)


    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Doom = {
		lring="Ephedra Ring",
		waist="Gishdubar Sash"
		}
	
    sets.buff.Cover = {}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_midcast(spell, action, spellMap, eventArgs)
    -- If DefenseMode is active, apply that gear over midcast
    -- choices.  Precast is allowed through for fast cast on
    -- spells, but we want to return to def gear before there's
    -- time for anything to hit us.
    -- Exclude Job Abilities from this restriction, as we probably want
    -- the enhanced effect of whatever item of gear applies to them,
    -- and only one item should be swapped out.
    if state.DefenseMode.value ~= 'None' and spell.type ~= 'JobAbility' then
        handle_equipping_gear(player.status)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.ExtraDefenseMode.current)
    if state.EquipShield.value == true then
        classes.CustomDefenseGroups:append(state.DefenseMode.current .. 'Shield')
    end

    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.ExtraDefenseMode.current)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_defense_mode()
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
	if player.hpp < 70 then
        idleSet = set_combine(idleSet, sets.latent_regen)
    end

    return idleSet
end

-- Modify the default melee set after it was constructed.
function job_buff_change(buff,gain)
	-- If we gain or lose any haste buffs, adjust which gear set we target.
--	if buffactive['Reive Mark'] then
--		if gain then		   
--			equip(sets.Reive)
--			disable('neck')
--		else
--			enable('neck')
--		end
--	end

	if buff == "doom" then
		if gain then		   
			equip(sets.buff.Doom)
			send_command('@input /p Doomed.')
			disable('ring1','ring2','waist')
		else
			enable('ring1','ring2','waist')
			handle_equipping_gear(player.status)
		end
	end




end

function customize_defense_set(defenseSet)
    if state.ExtraDefenseMode.value ~= 'None' then
        defenseSet = set_combine(defenseSet, sets[state.ExtraDefenseMode.value])
    end
    
    if state.EquipShield.value == true then
        defenseSet = set_combine(defenseSet, sets[state.DefenseMode.current .. 'Shield'])
    end
    
    if state.Buff.Doom then
        defenseSet = set_combine(defenseSet, sets.buff.Doom)
    end
    
    return defenseSet
end


function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end

    if state.ExtraDefenseMode.value ~= 'None' then
        msg = msg .. ', Extra: ' .. state.ExtraDefenseMode.value
    end
    
    if state.EquipShield.value == true then
        msg = msg .. ', Force Equip Shield'
    end
    
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_defense_mode()
    if player.equipment.main == 'Kheshig Blade' and not classes.CustomDefenseGroups:contains('Kheshig Blade') then
        classes.CustomDefenseGroups:append('Kheshig Blade')
    end
    
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.sub and not player.equipment.sub:contains('Shield') and
           player.equipment.sub ~= 'Aegis' and player.equipment.sub ~= 'Ochain' then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    end
end

function set_lockstyle()
	send_command('wait 2; input /lockstyleset 11')
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 13)
    elseif player.sub_job == 'NIN' then
        set_macro_page(2, 13)
    elseif player.sub_job == 'RDM' then
        set_macro_page(2, 13)
    else
        set_macro_page(2, 13)
    end
end
