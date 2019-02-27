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
		ammo="Egoist's Tathlum",
		head="Souveran Schaller +1",  --7
		neck="Moonbeam Necklace", --10
		waist="Creed Baudrier", --5, HP +40
		rear="Cryptic Earring", --4
		body="Souveran Cuirass",  --17
		hands="Souveran Handschuhs", --7
		rring="Eihwaz Ring", --5
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}}, --10
		legs="Souveran Diechlings +1", --7
		feet="Souveran Schuhs +1" 
	}
	--80
	--80
	--Brilliance = 14
	--Total = 94
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = set_combine(sets.precast.Enmity, {legs="Caballarius Breeches +1"})
    sets.precast.JA['Holy Circle'] = set_combine(sets.precast.Enmity, {})
    sets.precast.JA['Shield Bash'] = set_combine(sets.precast.Enmity, {hands="Caballarius Gauntlets +1"})
    sets.precast.JA['Sentinel'] = set_combine(sets.precast.Enmity, {feet="Caballarius Leggings +1"})
    sets.precast.JA['Rampart'] = set_combine(sets.precast.Enmity, {head="Caballarius Coronet +1"})
    sets.precast.JA['Fealty'] = set_combine(sets.precast.Enmity, {body="Caballarius Surcoat"})
    sets.precast.JA['Divine Emblem'] = set_combine(sets.precast.Enmity, {})
    sets.precast.JA['Cover'] = set_combine(sets.precast.Enmity, {})

    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {
		hands="Caballarius Gauntlets +1",
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
		ammo="Egoist's Tathlum",
		head="Carmine Mask +1", --14
		body="Reverence Surcoat +3", --10
		neck="Baetyl Pendant",  --4
		hands="Leyline Gloves",  --8
		rring="Kishar Ring",  --4
		waist="Creed Baudrier",
		legs="Odyssean Cuisses", --6
		back={ name="Rudianos's Mantle", augments={'HP+60','"Fast Cast"+10',}}, --10
	}
	--56
	
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		body="Jumalik Mail"
		}) 

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
	back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},
	ammo="Egoist's Tathlum"}

    sets.precast.WS.Acc = {}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

	--Requiescat: Modifier MND, use elemental gorgets (fotia, shadow, soil)
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
	})

    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {
	})

	--Modifier 80% DEX. Use Elemental Gorget/Belt as fTP gets transferred across all hits. Use crit rate/damage gear where possible.
    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
		neck="Fotia Gorget",
		body="Souveran Cuirass",
		hands="Souveran Handschuhs",  --Acc, Att, Enmity 7
		rring="Eihwaz Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},
		waist="Fotia Belt",
		legs="Lustratio Subligar",
		feet="Souveran Schuhs +1"})
 
	sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS['Chant du Cygne'], {
	})

	--Sanguine Blade: Modifier 50% MND, 30% STR
    sets.precast.WS['Sanguine Blade'] = {
		ammo="Amar Cluster",
		rring="Rufescent Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},
		waist="Dynamic Belt +1"
	}
    
	--Damage based on Enmity
    sets.precast.WS['Atonement'] = sets.precast.Enmity
	
	--Modifier 50% MND, 50% STR
    sets.precast.WS['Savage Blade'] = {
		neck="Sanctity Necklace", --Acc, Att, HP +35
		body="Souveran Cuirass",
		hands="Souveran Handschuhs",  --Acc, Att, Enmity 7
		rring="Eihwaz Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},
		waist="Fotia Belt",
		legs="Souveran Diechlings +1"

	}
    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
		ammo="Egoist's Tathlum",
		head="Carmine Mask +1", --14
		neck="Baetyl Pendant",  --4
		body="Reverence Surcoat +3", --10
		hands="Leyline Gloves",  --8
		rring="Eihwaz Ring",  
		waist="Creed Baudrier",
		legs="Odyssean Cuisses", --6
		back={ name="Rudianos's Mantle", augments={'HP+60','"Fast Cast"+10',}}, --10
	}
        
    sets.midcast.Enmity = {
		ammo="Egoist's Tathlum",  --HP 45
		head="Souveran Schaller +1",  --9
		neck="Moonbeam Necklace", --10
		waist="Creed Baudrier", --5, HP 40
		rear="Cryptic Earring", --4
		body="Souveran Cuirass",  --17
		hands="Souveran Handschuhs", --7
		rring="Eihwaz Ring", --5, HP 70
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}}, --10
		legs="Souveran Diechlings +1", --9
		feet="Souveran Schuhs +1"  --9
	}

		--85 Total
		--Brilliance 14
	
	
    sets.midcast.Flash = set_combine(sets.midcast.Enmity, {
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
		ammo="Impatiens", --Quick magic 2%, Spell Interruption -10%
		head="Souveran Schaller +1", --15% received, Spell Interruption -20%
		neck="Moonbeam Necklace", --Spell Interruption 10%, Enmity 10
		body="Souveran Cuirass", --10% potency, 10% received, Enmity 17
		hands="Souveran Handschuhs +1", 
		lring="Moonbeam Ring", --keep for the 100 HP so total HP doesn't go down too much
		rring="Eihwaz Ring", --5 Enmity, 70 HP
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},
		waist="Rumination Sash", --Spell Interruption -10%
		legs="Souveran Diechlings +1", --Enmity 9, 23% received
		feet="Souveran Schuhs +1" -- Enmity 9, 15% received
	}
	--Cure potency 10% (caps at 50%)
	--Cure potency received 53% (caps at 30%)
	--Spell Interruption -60%

    sets.midcast['Enhancing Magic'] = {
		neck="Moonbeam Necklace", --Spell Interruption 10
		rring="Eihwaz Ring", 
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},
		waist="Rumination Sash", --Spell Interruption
		feet="Souveran Schuhs +1" --Phalanx +5
	}
	--Enhancing Magic 394
	
	sets.midcast['Enlight'] = {
		ammo="Impatiens", --Spell Interruption -10
		neck="Moonbeam Necklace",
		body="Reverence Surcoat +3",
		rring="Eihwaz Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},
		waist="Rumination Sash",  --Spell Interruption -10
	}
	--Divine Magic Skill 503
	
    
	sets.midcast['Enlight II'] = sets.midcast['Enlight'] 
	
	sets.midcast['Holy'] = {
		ammo="Pemphredo Tathlum",
		neck="Moonbeam Necklace",
		body="Reverence Surcoat +3",
		hands="Leyline Gloves",
		rring="Eihwaz Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},
		waist="Rumination Sash"
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
		head="Jumalik Helm",  
		neck="Coatl Gorget +1", 
		lear="Infused Earring",
		rear="Hearty Earring",
		body="Jumalik Mail",
		hands="Souveran Handschuhs +1", --3 PDT, 4 MDT
		lring="Moonbeam Ring", --4 DT
		rring="Defending Ring", --10 DT
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},
		waist="Flume Belt",  --4 PDT
		legs="Carmine Cuisses +1", 
		feet="Souveran Schuhs +1" --4 DT
	}
	--Brilliance = 3 DT
	--27 DT
	--7 PDT

	sets.idle.DT = {
		ammo="Staunch Tathlum", --2 DT
		head="Souveran Schaller +1",  --5 PDT
		neck="Loricate Torque", --5 DT
		lear="Eabani Earring",
		rear="Cryptic Earring",
		body="Reverence Surcoat +3",  --11 DT
		hands="Souveran Handschuhs +1", --3 PDT, 4 MDT
		lring="Moonbeam Ring", --4 DT
		rring="Defending Ring", --10 DT
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},
		waist="Flume Belt",  --4 PDT
		legs="Souveran Diechlings +1", --3 DT
		feet="Souveran Schuhs +1" --4 DT
		}

	--Brilliance = 3 DT
		--Total: 43 DT
		--+8 DT set bonus = 51 DT
	
	sets.idle.MDT = {
		ammo="Staunch Tathlum",
		neck="Loricate Torque", --5 DT
		lear="Eabani Earring",
		rear="Hearty Earring",
		body="Reverence Surcoat +3", --11 DT
		hands="Souveran Handschuhs +1", --4 MDT, 3 PDT
		lring="Moonbeam Ring",
		rring="Defending Ring", --10 DT
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Spell interruption rate down-10%',}},
		waist="Flume Belt",
		legs="Souveran Diechlings +1", --3 DT
		feet="Souveran Schuhs +1" --3 DT	
	}
		
    
    sets.idle.Town = set_combine(sets.idle.DT, {
		body="Reverence Surcoat +3", 
		legs="Carmine Cuisses +1"
	})
	
    sets.idle.Weak = sets.idle
    
    sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)
    
    sets.Kiting = {
	legs="Carmine Cuisses +1"}

    sets.latent_refresh = {
	waist="Fucho-no-obi"}
	
	sets.latent_regen = {
	}


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
		ammo="Staunch Tathlum", --2 DT
		head="Souveran Schaller +1",  --5 DT
		neck="Loricate Torque", --5 DT
		lear="Infused Earring",
		rear="Eabani Earring",
		body="Reverence Surcoat +3",  --10 DT
		hands="Souveran Handschuhs +1", --3 PDT, 4 MDT
		lring="Moonbeam Ring", --4 DT
		rring="Defending Ring", --10 DT
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10',}}, --4 DT
		waist="Flume Belt", --2 PDT
		legs="Souveran Diechlings +1", --3 DT
		feet="Souveran Schuhs +1" --3 DT
	}
	--Brilliance = 3 DT
	--49% DT
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
		head="Flamma Zucchetto +2",  --7%
		neck="Lissome Necklace", 
		lear="Brutal Earring",
		rear="Eabani Earring",
		body="Souveran Cuirass",  --3%
		hands="Souveran Handschuhs +1", --4%
		lring="Moonbeam Ring",
		rring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10',}},
		waist="Sarissaphoroi Belt",  --3%
		legs="Sulevia's Cuisses +2",  --2%
		feet="Souveran Schuhs +1"  --1%
	}
	--23% Haste

    sets.engaged.Acc = set_combine(sets.engaged, {
		head="Carmine Mask +1",
		lear="Mache Earring",
		rear="Cessance Earring",
		legs="Sulevia's Cuisses +2"
	})

    sets.engaged.DW = set_combine(sets.engaged, {
		ammo="Amar Cluster",
		head="Souveran Schaller +1",  --7%
		neck="Lissome Necklace",
		body="Souveran Cuirass",  --3%
		hands="Souveran Handschuhs +1", --4%
		rring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10',}},
		waist="Dynamic Belt +1",  --6%
		legs="Souveran Diechlings +1"  --5%
	})

    sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {
		head="Carmine Mask +1",
		lear="Mache Earring",
		rear="Cessance Earring",
		legs="Sulevia's Cuisses +2"
	})

    sets.engaged.PDT = set_combine(sets.engaged, {
		ammo="Staunch Tathlum",
		head="Souveran Schaller +1",
		body="Reverence Surcoat +3", 
		neck="Knight's Bead Necklace +1",
		lear="Eabani Earring",
		rear="Cryptic Earring",
		legs="Souveran Diechlings +1",
		waist="Flume Belt"
	})
	
	--Brilliance = 3% DT
	--DT 38% + 8% set bonus = 46%
	--PDT 13
	--MDT 5%
	--BDT 7%
	--Reverence Surcoat +3 adds 1% DT
	
	-- With Knight's Beads at 1%:
	-- DT 30% + 8% set bonus = 38% + Brilliance 3% = 41%
	-- PDT 13%
	-- MDT 5%
	-- BDT 7%
	
	sets.engaged.MDT = set_combine(sets.engaged.PDT, {
		neck="Loricate Torque", 
		rear="Hearty Earring"
	})
	
	-- Switch in Loricate Torque to make up for missing DT. Change to Knight's Beads when 4% or higher.
		

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
		lring="Saida Ring",
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
