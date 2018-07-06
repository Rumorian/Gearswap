-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Hasso = buffactive.Hasso or false
    state.Buff.Seigan = buffactive.Seigan or false
    state.Buff.Sekkanoki = buffactive.Sekkanoki or false
    state.Buff.Sengikori = buffactive.Sengikori or false
    state.Buff['Meikyo Shisui'] = buffactive['Meikyo Shisui'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')

    update_combat_form()
    

	state.WeaponLock = M(false, 'Weapon Lock')    
	select_default_macro_book()
	set_lockstyle()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()

end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Meditate = {
	head="Wakido Kabuto +1", 
	hands="Sakonji Kote +1",
	back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}},
	}
    sets.precast.JA['Warding Circle'] = {}
	sets.precast.JA['Hasso'] = {hands="Wakido Kote +1"}
    sets.precast.JA['Blade Bash'] = {}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
	
	sets.precast.RA = {
		head="Ryuo Somen",
		body="Ryuo Domaru",
		hands="Ryuo Tekko",
		neck="Marked Gorget",
		waist="Yemaya Belt",
		lring="Hajduk Ring",
		rring="Ilabrat Ring",
		lear="Infused Earring",
		rear="Suppanomimi",
		legs="Kendatsuba Hakama",
		feet="Thereoid Greaves"
    }
	
	sets.precast.FC = {
		hands="Leyline Gloves", --8
		lring="Prolix Ring", --2
		rring="Rahab Ring", --2
		lear="Loquacious Earring", --2
		neck="Baetyl Pendant" --4
	}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Amar Cluster",
		head="Valorous Mask",
		body="Ryuo Domaru",
		hands={ name="Valorous Mitts", augments={'Accuracy+23 Attack+23','Weapon skill damage +4%','Attack+5',}},
		legs="Hizamaru Hizayoroi +2",
		feet="Valorous Greaves",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Cessance Earring",
		right_ear="Ishvara Earring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
		left_ring="Skukuyu Ring",
		right_ring="Karieyh Ring +1"
	}

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	
	--Fudo: 80% STR
    sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Fudo'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Fudo'].Mod = set_combine(sets.precast.WS['Tachi: Fudo'], {})

	--Shoha: STR
    sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {
		neck="Lacono Necklace +1",
		waist="Dynamic Belt +1"})
		
    sets.precast.WS['Tachi: Shoha'].Acc = set_combine(sets.precast.WS.Acc, {
		neck="Lacono Necklace +1",
		waist="Dynamic Belt +1"})

    sets.precast.WS['Tachi: Shoha'].Mod = set_combine(sets.precast.WS['Tachi: Shoha'], {
		neck="Lacono Necklace +1",
		waist="Dynamic Belt +1"})

	--Rana: 50% STR
    sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Rana'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Rana'].Mod = set_combine(sets.precast.WS['Tachi: Rana'], {})

	--Kasha: 75% STR
    sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS, {})

	--Gekko: 75% STR
    sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {})

	--Yukikaze: 75% STR
    sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, {})

	--Ageha: 60% CHR, 40% STR
    sets.precast.WS['Tachi: Ageha'] = set_combine(sets.precast.WS, {})

	--Jinpu: 30% STR
    sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS, {
		ammo="Pemphredo Tathlum",
		neck="Fotia Gorget", 
		waist="Fotia Belt",
		body="Founder's Breastplate",
		hands="Leyline Gloves",
		lear="Friomisi Earring"
	})

	sets.precast.WS['Arching Arrow'] = sets.precast.RA

    -- Midcast Sets
    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.RA = sets.precast.RA
	
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
     
    sets.idle.Field = {
		ammo="Staunch Tathlum",
		head="Valorous Mask",
		neck="Loricate Torque",
		lear="Infused Earring",
		rear="Hearty Earring",
		body="Hizamaru Haramaki +1",
		hands="Sakonji Kote +1",
		lring="Karieyh Ring +1",
		rring="Defending Ring",
		waist="Flume Belt",
		feet="Ryuo Sune-Ate +1",
		}

   sets.idle.Town = set_combine(sets.idle.Field, {
		feet="Danzo Sune-Ate"
   })
   
   
    sets.idle.Weak = sets.idle.Field
    
    -- Defense sets
    sets.defense.PDT = {
	}

    sets.defense.Reraise = {
	}

    sets.defense.MDT = {}

    sets.Kiting = {feet="Danzo Sune-ate"}

    sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    -- Delay 450 GK, 25 Save TP => 65 Store TP for a 5-hit (25 Store TP in gear)
    sets.engaged = {
		ammo="Ginsen",
		head="Flamma Zucchetto +2",
		body="Kasuga Domaru +1",
		hands={ name="Valorous Mitts", augments={'Accuracy+24 Attack+24','Crit. hit damage +2%','DEX+11','Accuracy+11','Attack+3',}},
		legs="Kendatsuba Hakama",
		feet="Ryuo Sune-Ate +1",
		neck="Moonlight Nodowa",
		waist="Ioskeha Belt",
		left_ear="Brutal Earring",
		right_ear="Cessance Earring",
		left_ring="Petrov Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}},
		right_ring="Ilabrat Ring"

	}
 
 sets.engaged.Acc = {
		ammo="Amar Cluster",
		head="Flamma Zucchetto +2",
		body="Flamma Korazin +2",
		hands={ name="Valorous Mitts", augments={'Accuracy+24 Attack+24','Crit. hit damage +2%','DEX+11','Accuracy+11','Attack+3',}},
		legs="Kendatsuba Hakama",
		feet="Ryuo Sune-Ate +1",
		neck="Moonlight Nodowa",
		waist="Ioskeha Belt",
		left_ear="Mache Earring",
		right_ear="Cessance Earring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}},
		left_ring="Petrov Ring",
		right_ring="Ilabrat Ring"

	}
 
 sets.engaged.PDT = {
		ammo="Ginsen",
		head="Flamma Zucchetto +2",
		body="Flamma Korazin +2",
		hands={ name="Valorous Mitts", augments={'Accuracy+24 Attack+24','Crit. hit damage +2%','DEX+11','Accuracy+11','Attack+3',}},
		legs="Kendatsuba Hakama",
		feet="Ryuo Sune-Ate +1",
		neck="Moonlight Nodowa",
		waist="Ioskeha Belt",
		left_ear="Brutal Earring",
		right_ear="Cessance Earring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}},
		left_ring="Petrov Ring",
		right_ring="Ilabrat Ring"

 }
 
    sets.engaged.Acc.PDT = {
		ammo="Ginsen",
		head="Flamma Zucchetto +2",
		body="Flamma Korazin +2",
		hands={ name="Valorous Mitts", augments={'Accuracy+24 Attack+24','Crit. hit damage +2%','DEX+11','Accuracy+11','Attack+3',}},
		legs="Kendatsuba Hakama",
		feet="Ryuo Sune-Ate +1",
		neck="Moonlight Nodowa",
		waist="Ioskeha Belt",
		left_ear="Brutal Earring",
		right_ear="Cessance Earring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}},
		left_ring="Petrov Ring",
		right_ring="Ilabrat Ring"

		}

	sets.engaged.Reraise = {
		ammo="Ginsen",
		head="Flamma Zucchetto +2",
		body="Flamma Korazin +2",
		hands={ name="Valorous Mitts", augments={'Accuracy+24 Attack+24','Crit. hit damage +2%','DEX+11','Accuracy+11','Attack+3',}},
		legs="Kendatsuba Hakama",
		feet="Ryuo Sune-Ate +1",
		neck="Moonlight Nodowa",
		waist="Ioskeha Belt",
		left_ear="Brutal Earring",
		right_ear="Cessance Earring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}},
		left_ring="Petrov Ring",
		right_ring="Ilabrat Ring"

	}
 
 sets.engaged.Acc.Reraise = {
		ammo="Ginsen",
		head="Flamma Zucchetto +2",
		body="Flamma Korazin +2",
		hands={ name="Valorous Mitts", augments={'Accuracy+24 Attack+24','Crit. hit damage +2%','DEX+11','Accuracy+11','Attack+3',}},
		legs="Kendatsuba Hakama",
		feet="Ryuo Sune-Ate +1",
		neck="Moonlight Nodowa",
		waist="Ioskeha Belt",
		left_ear="Brutal Earring",
		right_ear="Cessance Earring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}},
		left_ring="Petrov Ring",
		right_ring="Ilabrat Ring"

 }
        
    -- Melee sets for in Adoulin, which has an extra 10 Save TP for weaponskills.
    -- Delay 450 GK, 35 Save TP => 89 Store TP for a 4-hit (49 Store TP in gear), 2 Store TP for a 5-hit

	sets.engaged.Adoulin = sets.engaged

	sets.engaged.Adoulin.Acc = sets.engaged.Acc

	sets.engaged.Adoulin.PDT = sets.engaged.PDT

	sets.engaged.Adoulin.Acc.PDT = sets.engaged.Acc.PDT

	sets.engaged.Adoulin.Reraise = sets.engaged.Reraise 
 
	sets.engaged.Adoulin.Acc.Reraise = sets.engaged.Acc.Reraise


	sets.buff.Sekkanoki = {}
	sets.buff.Sengikori = {}
	sets.buff['Meikyo Shisui'] = {}
	sets.buff.Doom = {ring1="Saida Ring", waist="Gishdubar Sash"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        -- Change any GK weaponskills to polearm weaponskill if we're using a polearm.
        if player.equipment.main=='Quint Spear' or player.equipment.main=='Quint Spear' then
            if spell.english:startswith("Tachi:") then
                send_command('@input /ws "Penta Thrust" '..spell.target.raw)
                eventArgs.cancel = true
            end
        end
    end
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type:lower() == 'weaponskill' then
        if state.Buff.Sekkanoki then
            equip(sets.buff.Sekkanoki)
        end
        if state.Buff.Sengikori then
            equip(sets.buff.Sengikori)
        end
        if state.Buff['Meikyo Shisui'] then
            equip(sets.buff['Meikyo Shisui'])
        end
    end
end


-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Effectively lock these items in place.
    if state.HybridMode.value == 'Reraise' or
        (state.DefenseMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'Reraise') then
        equip(sets.Reraise)
    end
end

function job_buff_change(buff,gain)


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

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('ranged','ammo')
    else
        enable('ranged','ammo')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    if areas.Adoulin:contains(world.area) and buffactive.ionis then
        state.CombatForm:set('Adoulin')
    else
        state.CombatForm:reset()
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 14)
    elseif player.sub_job == 'DNC' then
        set_macro_page(1, 14)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 14)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 14)
    else
        set_macro_page(1, 14)
    end
end

function set_lockstyle()
	send_command('wait 2; input /lockstyleset 54')
end
