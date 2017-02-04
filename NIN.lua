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
    state.Buff.Migawari = buffactive.migawari or false
    state.Buff.Doom = buffactive.doom or false
    state.Buff.Yonin = buffactive.Yonin or false
    state.Buff.Innin = buffactive.Innin or false
    state.Buff.Futae = buffactive.Futae or false

    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'Evasion')

    gear.MovementFeet = {name="Danzo Sune-ate"}
    gear.DayFeet = "Danzo Sune-ate"
    gear.NightFeet = "Ninja Kyahan"
    
    select_movement_feet()
    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Mijin Gakure'] = {legs=""}
    sets.precast.JA['Futae'] = {legs=""}
    sets.precast.JA['Sange'] = {legs=""}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Set for acc on steps, since Yonin drops acc a fair bit
    sets.precast.Step = {
        }

    sets.precast.Flourish1 = {waist="Chaac Belt"}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
		head="Herculean Helm"
	}
	
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {"Iga Kyahan +2"})

    -- Snapshot for ranged
    sets.precast.RA = {}
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS,
        {})

    sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS,
        {})

    sets.precast.WS['Blade: Shun'] = 
	{waist="Flame Belt"
	}


    sets.precast.WS['Aeolian Edge'] = {
	}

    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
		head="Herculean Helm"
	}
        
    sets.midcast.Utsusemi = 
	{hands="Rawhide Gloves",
	feet="Iga Kyahan +2"}

    sets.midcast.ElementalNinjutsu = {
	}

    sets.midcast.ElementalNinjutsu.Resistant = set_combine(sets.midcast.Ninjutsu, {})

    sets.midcast.NinjutsuDebuff = {
	}

    sets.midcast.NinjutsuBuff = {}

    sets.midcast.RA = {
	}
    -- Hachiya Hakama/Thurandaut Tights +1

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Resting sets
    sets.resting = {}
    
    -- Idle sets
    sets.idle = {
	feet=gear.MovementFeet}

    sets.idle.Town = {
	feet=gear.MovementFeet}
    
    sets.idle.Weak = {
	feet=gear.MovementFeet}
    
    -- Defense sets
    sets.defense.Evasion = {
	}

    sets.defense.PDT = {
	}

    sets.defense.MDT = {}


    sets.Kiting = {feet=gear.MovementFeet}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {   
    range="Bestas Bane",
    head="Rao Kabuto", 
    body="Rawhide Vest",
    hands="Rawhide Gloves",
    legs="Herculean Trousers",
    feet="Rawhide Boots",
    neck="Lissome Necklace",
    waist="Kentarch Belt +1",
    left_ear="Assuage Earring",
    right_ear="Dominance Earring",
    left_ring="Apate Ring",
    right_ring="Enlivened Ring",
    back="Yokaze Mantle"}

    sets.engaged.Acc = {   
    range="Bestas Bane",
    head="Rao Kabuto", 
    body="Rawhide Vest",
    hands="Rawhide Gloves",
    legs="Herculean Trousers",
    feet="Rawhide Boots",
    neck="Lissome Necklace",
    waist="Kentarch Belt +1",
    left_ear="Assuage Earring",
    right_ear="Dominance Earring",
    left_ring="Apate Ring",
    right_ring="Enlivened Ring",
    back="Yokaze Mantle"}
 
 sets.engaged.Evasion = {   
    range="Bestas Bane",
    head="Rao Kabuto", 
    body="Rawhide Vest",
    hands="Rawhide Gloves",
    legs="Herculean Trousers",
    feet="Rawhide Boots",
    neck="Lissome Necklace",
    waist="Kentarch Belt +1",
    left_ear="Assuage Earring",
    right_ear="Dominance Earring",
    left_ring="Apate Ring",
    right_ring="Enlivened Ring",
    back="Yokaze Mantle"}
 
 sets.engaged.Acc.Evasion = {   
    range="Bestas Bane",
    head="Rao Kabuto", 
    body="Rawhide Vest",
    hands="Rawhide Gloves",
    legs="Herculean Trousers",
    feet="Rawhide Boots",
    neck="Lissome Necklace",
    waist="Kentarch Belt +1",
    left_ear="Assuage Earring",
    right_ear="Dominance Earring",
    left_ring="Apate Ring",
    right_ring="Enlivened Ring",
    back="Yokaze Mantle"}
	
    sets.engaged.PDT = {   
    range="Bestas Bane",
    head="Rao Kabuto", 
    body="Rawhide Vest",
    hands="Rawhide Gloves",
    legs="Herculean Trousers",
    feet="Rawhide Boots",
    neck="Lissome Necklace",
    waist="Kentarch Belt +1",
    left_ear="Assuage Earring",
    right_ear="Dominance Earring",
    left_ring="Apate Ring",
    right_ring="Enlivened Ring",
    back="Yokaze Mantle"}
	
    sets.engaged.Acc.PDT = {   
    range="Bestas Bane",
    head="Rao Kabuto", 
    body="Rawhide Vest",
    hands="Rawhide Gloves",
    legs="Herculean Trousers",
    feet="Rawhide Boots",
    neck="Lissome Necklace",
    waist="Kentarch Belt +1",
    left_ear="Assuage Earring",
    right_ear="Dominance Earring",
    left_ring="Apate Ring",
    right_ring="Enlivened Ring",
    back="Yokaze Mantle"}

    -- Custom melee group: High Haste (~20% DW)
    sets.engaged.HighHaste = {   
    range="Bestas Bane",
    head="Rao Kabuto", 
    body="Rawhide Vest",
    hands="Rawhide Gloves",
    legs="Herculean Trousers",
    feet="Rawhide Boots",
    neck="Lissome Necklace",
    waist="Kentarch Belt +1",
    left_ear="Assuage Earring",
    right_ear="Dominance Earring",
    left_ring="Apate Ring",
    right_ring="Enlivened Ring",
    back="Yokaze Mantle"}
	
    sets.engaged.Acc.HighHaste = {   
    range="Bestas Bane",
    head="Rao Kabuto", 
    body="Rawhide Vest",
    hands="Rawhide Gloves",
    legs="Herculean Trousers",
    feet="Rawhide Boots",
    neck="Lissome Necklace",
    waist="Kentarch Belt +1",
    left_ear="Assuage Earring",
    right_ear="Dominance Earring",
    left_ring="Apate Ring",
    right_ring="Enlivened Ring",
    back="Yokaze Mantle"}
	
    sets.engaged.Evasion.HighHaste = {   
    range="Bestas Bane",
    head="Rao Kabuto", 
    body="Rawhide Vest",
    hands="Rawhide Gloves",
    legs="Herculean Trousers",
    feet="Rawhide Boots",
    neck="Lissome Necklace",
    waist="Kentarch Belt +1",
    left_ear="Assuage Earring",
    right_ear="Dominance Earring",
    left_ring="Apate Ring",
    right_ring="Enlivened Ring",
    back="Yokaze Mantle"}

    sets.engaged.Acc.Evasion.HighHaste = {   
    range="Bestas Bane",
    head="Rao Kabuto", 
    body="Rawhide Vest",
    hands="Rawhide Gloves",
    legs="Herculean Trousers",
    feet="Rawhide Boots",
    neck="Lissome Necklace",
    waist="Kentarch Belt +1",
    left_ear="Assuage Earring",
    right_ear="Dominance Earring",
    left_ring="Apate Ring",
    right_ring="Enlivened Ring",
    back="Yokaze Mantle"}
 
 sets.engaged.PDT.HighHaste = {   
    range="Bestas Bane",
    head="Rao Kabuto", 
    body="Rawhide Vest",
    hands="Rawhide Gloves",
    legs="Herculean Trousers",
    feet="Rawhide Boots",
    neck="Lissome Necklace",
    waist="Kentarch Belt +1",
    left_ear="Assuage Earring",
    right_ear="Dominance Earring",
    left_ring="Apate Ring",
    right_ring="Enlivened Ring",
    back="Yokaze Mantle"}
	
    sets.engaged.Acc.PDT.HighHaste = {   
    range="Bestas Bane",
    head="Rao Kabuto", 
    body="Rawhide Vest",
    hands="Rawhide Gloves",
    legs="Herculean Trousers",
    feet="Rawhide Boots",
    neck="Lissome Necklace",
    waist="Kentarch Belt +1",
    left_ear="Assuage Earring",
    right_ear="Dominance Earring",
    left_ring="Apate Ring",
    right_ring="Enlivened Ring",
    back="Yokaze Mantle"}

    -- Custom melee group: Embrava Haste (7% DW)
    sets.engaged.EmbravaHaste = {   
    range="Bestas Bane",
    head="Rao Kabuto", 
    body="Rawhide Vest",
    hands="Rawhide Gloves",
    legs="Herculean Trousers",
    feet="Rawhide Boots",
    neck="Lissome Necklace",
    waist="Kentarch Belt +1",
    left_ear="Assuage Earring",
    right_ear="Dominance Earring",
    left_ring="Apate Ring",
    right_ring="Enlivened Ring",
    back="Yokaze Mantle"}
	
    sets.engaged.Acc.EmbravaHaste = {   
    range="Bestas Bane",
    head="Rao Kabuto", 
    body="Rawhide Vest",
    hands="Rawhide Gloves",
    legs="Herculean Trousers",
    feet="Rawhide Boots",
    neck="Lissome Necklace",
    waist="Kentarch Belt +1",
    left_ear="Assuage Earring",
    right_ear="Dominance Earring",
    left_ring="Apate Ring",
    right_ring="Enlivened Ring",
    back="Yokaze Mantle"}
	
    sets.engaged.Evasion.EmbravaHaste = {   
    range="Bestas Bane",
    head="Rao Kabuto", 
    body="Rawhide Vest",
    hands="Rawhide Gloves",
    legs="Herculean Trousers",
    feet="Rawhide Boots",
    neck="Lissome Necklace",
    waist="Kentarch Belt +1",
    left_ear="Assuage Earring",
    right_ear="Dominance Earring",
    left_ring="Apate Ring",
    right_ring="Enlivened Ring",
    back="Yokaze Mantle"}
	
    sets.engaged.Acc.Evasion.EmbravaHaste = {   
    range="Bestas Bane",
    head="Rao Kabuto", 
    body="Rawhide Vest",
    hands="Rawhide Gloves",
    legs="Herculean Trousers",
    feet="Rawhide Boots",
    neck="Lissome Necklace",
    waist="Kentarch Belt +1",
    left_ear="Assuage Earring",
    right_ear="Dominance Earring",
    left_ring="Apate Ring",
    right_ring="Enlivened Ring",
    back="Yokaze Mantle"}
	
    sets.engaged.PDT.EmbravaHaste = {   
    range="Bestas Bane",
    head="Rao Kabuto", 
    body="Rawhide Vest",
    hands="Rawhide Gloves",
    legs="Herculean Trousers",
    feet="Rawhide Boots",
    neck="Lissome Necklace",
    waist="Kentarch Belt +1",
    left_ear="Assuage Earring",
    right_ear="Dominance Earring",
    left_ring="Apate Ring",
    right_ring="Enlivened Ring",
    back="Yokaze Mantle"}
	
    sets.engaged.Acc.PDT.EmbravaHaste = {   
    range="Bestas Bane",
    head="Rao Kabuto", 
    body="Rawhide Vest",
    hands="Rawhide Gloves",
    legs="Herculean Trousers",
    feet="Rawhide Boots",
    neck="Lissome Necklace",
    waist="Kentarch Belt +1",
    left_ear="Assuage Earring",
    right_ear="Dominance Earring",
    left_ring="Apate Ring",
    right_ring="Enlivened Ring",
    back="Yokaze Mantle"}

    -- Custom melee group: Max Haste (0% DW)
    sets.engaged.MaxHaste = {   
    range="Bestas Bane",
    head="Rao Kabuto", 
    body="Rawhide Vest",
    hands="Rawhide Gloves",
    legs="Herculean Trousers",
    feet="Rawhide Boots",
    neck="Lissome Necklace",
    waist="Kentarch Belt +1",
    left_ear="Assuage Earring",
    right_ear="Dominance Earring",
    left_ring="Apate Ring",
    right_ring="Enlivened Ring",
    back="Yokaze Mantle"}
	
    sets.engaged.Acc.MaxHaste = {   
    range="Bestas Bane",
    head="Rao Kabuto", 
    body="Rawhide Vest",
    hands="Rawhide Gloves",
    legs="Herculean Trousers",
    feet="Rawhide Boots",
    neck="Lissome Necklace",
    waist="Kentarch Belt +1",
    left_ear="Assuage Earring",
    right_ear="Dominance Earring",
    left_ring="Apate Ring",
    right_ring="Enlivened Ring",
    back="Yokaze Mantle"}
	
    sets.engaged.Evasion.MaxHaste = {   
    range="Bestas Bane",
    head="Rao Kabuto", 
    body="Rawhide Vest",
    hands="Rawhide Gloves",
    legs="Herculean Trousers",
    feet="Rawhide Boots",
    neck="Lissome Necklace",
    waist="Kentarch Belt +1",
    left_ear="Assuage Earring",
    right_ear="Dominance Earring",
    left_ring="Apate Ring",
    right_ring="Enlivened Ring",
    back="Yokaze Mantle"}
	
    sets.engaged.Acc.Evasion.MaxHaste = {   
    range="Bestas Bane",
    head="Rao Kabuto", 
    body="Rawhide Vest",
    hands="Rawhide Gloves",
    legs="Herculean Trousers",
    feet="Rawhide Boots",
    neck="Lissome Necklace",
    waist="Kentarch Belt +1",
    left_ear="Assuage Earring",
    right_ear="Dominance Earring",
    left_ring="Apate Ring",
    right_ring="Enlivened Ring",
    back="Yokaze Mantle"}
	
    sets.engaged.PDT.MaxHaste = {   
    range="Bestas Bane",
    head="Rao Kabuto", 
    body="Rawhide Vest",
    hands="Rawhide Gloves",
    legs="Herculean Trousers",
    feet="Rawhide Boots",
    neck="Lissome Necklace",
    waist="Kentarch Belt +1",
    left_ear="Assuage Earring",
    right_ear="Dominance Earring",
    left_ring="Apate Ring",
    right_ring="Enlivened Ring",
    back="Yokaze Mantle"}
	
    sets.engaged.Acc.PDT.MaxHaste = {   
    range="Bestas Bane",
    head="Rao Kabuto", 
    body="Rawhide Vest",
    hands="Rawhide Gloves",
    legs="Herculean Trousers",
    feet="Rawhide Boots",
    neck="Lissome Necklace",
    waist="Kentarch Belt +1",
    left_ear="Assuage Earring",
    right_ear="Dominance Earring",
    left_ring="Apate Ring",
    right_ring="Enlivened Ring",
    back="Yokaze Mantle"}


    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Migawari = {}
    sets.buff.Doom = {}
    sets.buff.Yonin = {}
    sets.buff.Innin = {}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.Buff.Doom then
        equip(sets.buff.Doom)
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted and spell.english == "Migawari: Ichi" then
        state.Buff.Migawari = true
    end
	if world.time >= 1020 or world.time <= 420 then
         equip({ear2="Lugra earring"})
    end
	

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste','march','embrava','haste samba'}:contains(buff:lower()) then
        determine_haste_group()
        handle_equipping_gear(player.status)
    elseif state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end
end

function job_status_change(new_status, old_status)
    if new_status == 'Idle' then
        select_movement_feet()
    end
	
	if world.time >= 1020 or world.time <= 420 then
         equip({ear2="Lugra earring"})
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Get custom spell maps
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == "Ninjutsu" then
        if not default_spell_map then
            if spell.target.type == 'SELF' then
                return 'NinjutsuBuff'
            else
                return 'NinjutsuDebuff'
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Buff.Migawari then
        idleSet = set_combine(idleSet, sets.buff.Migawari)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    return idleSet
end


-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Migawari then
        meleeSet = set_combine(meleeSet, sets.buff.Migawari)
    end
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    return meleeSet
end

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
    select_movement_feet()
    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()
    -- We have three groups of DW in gear: Hachiya body/legs, Iga head + Patentia Sash, and DW earrings
    
    -- Standard gear set reaches near capped delay with just Haste (77%-78%, depending on HQs)

    -- For high haste, we want to be able to drop one of the 10% groups.
    -- Basic gear hits capped delay (roughly) with:
    -- 1 March + Haste
    -- 2 March
    -- Haste + Haste Samba
    -- 1 March + Haste Samba
    -- Embrava
    
    -- High haste buffs:
    -- 2x Marches + Haste Samba == 19% DW in gear
    -- 1x March + Haste + Haste Samba == 22% DW in gear
    -- Embrava + Haste or 1x March == 7% DW in gear
    
    -- For max haste (capped magic haste + 25% gear haste), we can drop all DW gear.
    -- Max haste buffs:
    -- Embrava + Haste+March or 2x March
    -- 2x Marches + Haste
    
    -- So we want four tiers:
    -- Normal DW
    -- 20% DW -- High Haste
    -- 7% DW (earrings) - Embrava Haste (specialized situation with embrava and haste, but no marches)
    -- 0 DW - Max Haste
    
    classes.CustomMeleeGroups:clear()
    
    if buffactive.embrava and (buffactive.march == 2 or (buffactive.march and buffactive.haste)) then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.march == 2 and buffactive.haste then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.embrava and (buffactive.haste or buffactive.march) then
        classes.CustomMeleeGroups:append('EmbravaHaste')
    elseif buffactive.march == 1 and buffactive.haste and buffactive['haste samba'] then
        classes.CustomMeleeGroups:append('HighHaste')
    elseif buffactive.march == 2 then
        classes.CustomMeleeGroups:append('HighHaste')
    end
end


function select_movement_feet()
    if world.time >= 17*60 or world.time < 7*60 then
        gear.MovementFeet.name = gear.NightFeet
    else
        gear.MovementFeet.name = gear.DayFeet
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 7)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 7)
    else
        set_macro_page(1, 7)
    end
end
