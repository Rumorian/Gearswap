-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	send_command('wait 2;input /lockstyleset 10')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    -- List of pet weaponskills to check for
    petWeaponskills = S{"Slapstick", "Knockout", "Magic Mortar",
        "Chimera Ripper", "String Clipper",  "Cannibal Blade", "Bone Crusher", "String Shredder",
        "Arcuballista", "Daze", "Armor Piercer", "Armor Shatterer"}
    
    -- Map automaton heads to combat roles
    petModes = {
        ['Harlequin Head'] = 'Melee',
        ['Sharpshot Head'] = 'Ranged',
        ['Valoredge Head'] = 'Tank',
        ['Stormwaker Head'] = 'Magic',
        ['Soulsoother Head'] = 'Heal',
        ['Spiritreaver Head'] = 'Nuke'
        }

    -- Subset of modes that use magic
    magicPetModes = S{'Nuke','Heal','Magic'}
    
    -- Var to track the current pet mode.
    state.PetMode = M{['description']='Pet Mode', 'None', 'Melee', 'Ranged', 'Tank', 'Magic', 'Heal', 'Nuke'}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Fodder')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc', 'Fodder')
    state.PhysicalDefenseMode:options('PDT', 'Evasion')

    -- Default maneuvers 1, 2, 3 and 4 for each pet mode.
    defaultManeuvers = {
        ['Melee'] = {'Fire Maneuver', 'Thunder Maneuver', 'Wind Maneuver', 'Light Maneuver'},
        ['Ranged'] = {'Wind Maneuver', 'Fire Maneuver', 'Thunder Maneuver', 'Light Maneuver'},
        ['Tank'] = {'Earth Maneuver', 'Dark Maneuver', 'Light Maneuver', 'Wind Maneuver'},
        ['Magic'] = {'Ice Maneuver', 'Light Maneuver', 'Dark Maneuver', 'Earth Maneuver'},
        ['Heal'] = {'Light Maneuver', 'Dark Maneuver', 'Water Maneuver', 'Earth Maneuver'},
        ['Nuke'] = {'Ice Maneuver', 'Dark Maneuver', 'Light Maneuver', 'Earth Maneuver'}
    }

    update_pet_mode()
    select_default_macro_book()
end


-- Define sets used by this job file.
function init_gear_sets()
    
    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {
	head="Herculean Helm", --7
	body="Vrikodara Jupon", --5
	neck="Baetyl Pendant", --4
	lear="Loquacious Earring",  --2
	lring="Prolix Ring", --2
	rring="Rahab Ring", --2
	legs="Gyve Trousers"} --4
	--26 total

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

    
    -- Precast sets to enhance JAs
    sets.precast.JA['Tactical Switch'] = {feet="Karagoz Scarpe"}

	sets.precast.JA['Role Reversal'] = {feet="Pitre Babouches"}

	sets.precast.JA['Overdrive'] = {Body="Pitre Tobe"}

    sets.precast.JA['Activate'] = {head="Pitre Taj"}

	sets.precast.JA['Repair'] = {
		feet="Foire Babouches +1",
		lear="Pratik Earring"}

    sets.precast.JA.Maneuver = {
		body="Karagoz Farsetto",
		back="Visucius's Mantle",
		lear="Burana Earring"}



    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Sukeroku Hachimaki",
		feet="Rawhide Boots"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Rao Kabuto",
		body="Ryuo Domaru",
		ring1="Rufescent Ring",
		ring2="Ifrit Ring",
        hands={ name="Rao Kote", augments={'STR+10','DEX+10','Attack+15',}},
		legs="Rao Haidate",
		feet="Ryuo Sune-Ate"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

		-- 32% STR 32% VIT
     sets.precast.WS['Stringing Pummel'] = set_combine(sets.precast.WS, {
		head="Rao Kabuto",
		neck="Flame Gorget",
		body="Ryuo Domaru",
		ring1="Shukuyu Ring",
		ring2="Ifrit Ring",
		waist="Windbuffet Belt +1",
		hands="Ryuo Tekko",
		legs="Rao Haidate",
		feet="Ryuo Sune-Ate"})
		
		-- 80% STR
	   sets.precast.WS['Victory Smite'] = set_combine(sets.precast.WS, {
		head="Rao Kabuto",
		body="Ryuo Domaru",
		neck="Breeze Gorget",
		lear="Steelflash Earring",
		rear="Bladeborn Earring",
		hands="Ryuo Tekko",
		lring="Shukuyu Ring",
		rring="Ifrit Ring",
		waist="Latria Sash",
		legs="Rao Haidate",
		feet="Ryuo Sune-Ate"
		})
    
		-- DEX
     sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {
		feet={ name="Herculean Boots", augments={'Accuracy+24 Attack+24','Crit.hit rate+1','DEX+4','Attack+7',}},
		hands="Ryuo Tekko",
		ring2="Ramuh Ring",
		legs="Samnuha Tights"})

    
    -- Midcast Sets

	sets.midcast.Cure = {
		head="Sukeroku Hachimaki",
		body="Vrikodara Jupon",
		neck="Incanter's Torque", 
		ear1="Mendicant's Earring",
		hands="Rawhide Gloves", 
		ring1="Stikini Ring",
		ring2="Sirona's Ring",
        back="Solemnity Cape", 
		waist="Gishdubar Sash", 
		legs="Gyve Trousers"
				}
	
    sets.midcast.FastRecast = {
	head="Herculean Helm", --7
	body="Vrikodara Jupon", --5
	neck="Baetyl Pendant", --4
	lear="Loquacious Earring",  --2
	lring="Prolix Ring", --2
	rring="Rahab Ring", --2
	legs="Gyve Trousers"} --4
	--26 total
        

    -- Midcast sets for pet actions
    sets.midcast.Pet.Cure = {}

    sets.midcast.Pet['Elemental Magic'] = {feet="Pitre Babouches"}

    sets.midcast.Pet.WeaponSkill = {}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {head="Pitre Taj +1",	
	body="Hizamaru Haramaki +1",
	hands={ name="Rao Kote", augments={'STR+10','DEX+10','Attack+15',}},
    legs="Rao Haidate",
	neck="Bathy Choker +1", 
	lear="Burana Earring",
	rear="Infused Earring",
	ring1="Paguroidea Ring",
	feet="Rao Sune-Ate",
	waist="Isa Belt"}
    

    -- Idle sets

    sets.idle = {head="Pitre Taj +1",
	body="Hizamaru Haramaki +1",
	hands={ name="Rao Kote", augments={'STR+10','DEX+10','Attack+15',}},
    legs="Rao Haidate",
	neck="Bathy Choker +1", 
	lear="Burana Earring",
	rear="Infused Earring",
	ring1="Paguroidea Ring",
	feet="Hermes' Sandals",
	waist="Isa Belt"}

    sets.idle.Town = set_combine(sets.idle, {body="Councilor's Garb"})

    -- Set for idle while pet is out (eg: pet regen gear)
    sets.idle.Pet = sets.idle

    -- Idle sets to wear while pet is engaged
    sets.idle.Pet.Engaged = {
    body="Rao Togi",
	head={ name="Herculean Helm", augments={'Pet: Accuracy+29 Pet: Rng. Acc.+29','Pet: "Dbl.Atk."+3 Pet: Crit.hit rate +3','Pet: INT+7',}},
	neck="Twilight Torque",
	lear="Domesticator's Earring",
	rear="Handler's Earring +1",
	feet="Rao Sune-Ate",
	rring="Thurandaut Ring",
	legs={ name="Herculean Trousers", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Pet: Phys. dmg. taken -3%','Pet: VIT+11','Pet: Attack+15 Pet: Rng.Atk.+15','Pet: "Mag.Atk.Bns."+4',}},
	waist="Isa Belt",
	hands={ name="Rao Kote", augments={'Pet: HP+100','Pet: Accuracy+15','Pet: Damage taken -3%',}},
	lring="Paguroidea Ring"}

    sets.idle.Pet.Engaged.Ranged = set_combine(sets.idle.Pet.Engaged, {
	body="Rao Togi",
	lear="Burana Earring",
	head={ name="Herculean Helm", augments={'Pet: Accuracy+29 Pet: Rng. Acc.+29','Pet: "Dbl.Atk."+3 Pet: Crit.hit rate +3','Pet: INT+7',}},
	rear="Handler's Earring +1",
	neck="Twilight Torque",
	lring="Overbearing Ring",
	rring="Thurandaut Ring",
	legs={ name="Herculean Trousers", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Pet: Phys. dmg. taken -3%','Pet: VIT+11','Pet: Attack+15 Pet: Rng.Atk.+15','Pet: "Mag.Atk.Bns."+4',}},
	feet="Rao Sune-Ate",
	hands={ name="Rao Kote", augments={'Pet: HP+100','Pet: Accuracy+15','Pet: Damage taken -3%',}},
	waist="Isa Belt"})

    sets.idle.Pet.Engaged.Nuke = set_combine(sets.idle.Pet.Engaged, {    
	body="Pantin Tobe +2",
	neck="Twilight Torque",
	lear="Burana Earring",
	rear="Handler's Earring +1",
	lring="Overbearing Ring",
	rring="Thurandaut Ring",
	waist="Isa Belt",
	feet="Rao Sune-Ate",
	hands={ name="Rao Kote", augments={'Pet: HP+100','Pet: Accuracy+15','Pet: Damage taken -3%',}},
	legs="Karagoz Pantaloni"})

    sets.idle.Pet.Engaged.Magic = set_combine(sets.idle.Pet.Engaged, {
    body="Pantin Tobe +2",
	lear="Burana Earring",
	rear="Handler's Earring +1",
	neck="Twilight Torque",
	lring="Overbearing Ring",
	rring="Thurandaut Ring",
	waist="Isa Belt",
	feet="Rao Sune-Ate",
	hands={ name="Rao Kote", augments={'Pet: HP+100','Pet: Accuracy+15','Pet: Damage taken -3%',}},
	legs="Karagoz Pantaloni"})


    -- Defense sets

    sets.defense.Evasion = {
        head="Rao Kabuto",
		neck="Sanctity Necklace",
		ear1="Cessance Earring",
		ear2="Brutal Earring",
        hands="Herculean Gloves",
		ring1="Epona's Ring",
		ring2="Rajas Ring",
        waist="Windbuffet Belt +1",
		legs="Herculean Trousers",
		feet="Herculean Boots"}

    sets.defense.PDT = {
        head="Rao Kabuto",
		neck="Sanctity Necklace",
		ear1="Cessance Earring",
		ear2="Brutal Earring",
        hands="Herculean Gloves",
		ring1="Epona's Ring",
		ring2="Rajas Ring",
        waist="Windbuffet Belt +1",
		legs="Herculean Trousers",
		feet="Herculean Boots"}

    sets.defense.MDT = {
        head="Rao Kabuto",
		neck="Sanctity Necklace",
		ear1="Cessance Earring",
		ear2="Brutal Earring",
        hands="Herculean Gloves",
		ring1="Epona's Ring",
		ring2="Rajas Ring",
        waist="Windbuffet Belt +1",
		legs="Herculean Trousers",
		feet="Herculean Boots"}

    sets.Kiting = {feet="Hermes' Sandals"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        head={ name="Herculean Helm", augments={'Accuracy+19 Attack+19','"Triple Atk."+3','Accuracy+15','Attack+4',}},
		neck="Lissome Necklace",
		ear1="Cessance Earring",
		ear2="Mache Earring",
        body="Ryuo Domaru",
		hands="Herculean Gloves",
		ring1="Epona's Ring",
		ring2="Rajas Ring",
        legs={ name="Herculean Trousers", augments={'Accuracy+24 Attack+24','"Triple Atk."+3','STR+5','Accuracy+11','Attack+1',}},
		feet={ name="Herculean Boots", augments={'Accuracy+19 Attack+19','"Triple Atk."+4','CHR+5','Accuracy+15',}},
		waist="Windbuffet Belt +1"}

		sets.engaged.Acc = {
        head={ name="Herculean Helm", augments={'Accuracy+19 Attack+19','"Triple Atk."+3','Accuracy+15','Attack+4',}},
		neck="Lissome Necklace",
		ear1="Cessance Earring",
		ear2="Mache Earring",
        body="Ryuo Domaru",
		hands="Herculean Gloves",
		ring1="Epona's Ring",
		ring2="Rajas Ring",
        legs={ name="Herculean Trousers", augments={'Accuracy+24 Attack+24','"Triple Atk."+3','STR+5','Accuracy+11','Attack+1',}},
		feet={ name="Herculean Boots", augments={'Accuracy+19 Attack+19','"Triple Atk."+4','CHR+5','Accuracy+15',}},
		waist="Windbuffet Belt +1"}

		sets.engaged.DT = {
        head="Rao Kabuto",
		neck="Lissome Necklace",
		ear1="Cessance Earring",
		ear2="Brutal Earring",
        body="Ryuo Domaru",
		hands="Herculean Gloves",
		ring1="Epona's Ring",
		ring2="Rajas Ring",
        legs={ name="Herculean Trousers", augments={'Accuracy+24 Attack+24','"Triple Atk."+3','STR+5','Accuracy+11','Attack+1',}},
		feet={ name="Herculean Boots", augments={'Accuracy+19 Attack+19','"Triple Atk."+4','CHR+5','Accuracy+15',}},
		waist="Windbuffet Belt +1"}

		sets.engaged.Acc.DT = {
        head="Rao Kabuto",
		neck="Lissome Necklace",
		ear1="Cessance Earring",
		ear2="Brutal Earring",
        body="Ryuo Domaru",
		hands="Herculean Gloves",
		ring1="Epona's Ring",
		ring2="Rajas Ring",
        legs={ name="Herculean Trousers", augments={'Accuracy+24 Attack+24','"Triple Atk."+3','STR+5','Accuracy+11','Attack+1',}},
		feet={ name="Herculean Boots", augments={'Accuracy+19 Attack+19','"Triple Atk."+4','CHR+5','Accuracy+15',}},
		waist="Windbuffet Belt +1"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when pet is about to perform an action
function job_pet_midcast(spell, action, spellMap, eventArgs)
    if petWeaponskills:contains(spell.english) then
        classes.CustomClass = "Weaponskill"
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == 'Wind Maneuver' then
        handle_equipping_gear(player.status)
    end
end

-- Called when a player gains or loses a pet.
-- pet == pet gained or lost
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(pet, gain)
    update_pet_mode()
end

-- Called when the pet's status changes.
function job_pet_status_change(newStatus, oldStatus)
    if newStatus == 'Engaged' then
        display_pet_status()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_pet_mode()
end


-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_pet_status()
end


-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'maneuver' then
        if pet.isvalid then
            local man = defaultManeuvers[state.PetMode.value]
            if man and tonumber(cmdParams[2]) then
                man = man[tonumber(cmdParams[2])]
            end

            if man then
                send_command('input /pet "'..man..'" <me>')
            end
        else
            add_to_chat(123,'No valid pet.')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Get the pet mode value based on the equipped head of the automaton.
-- Returns nil if pet is not valid.
function get_pet_mode()
    if pet.isvalid then
        return petModes[pet.head] or 'None'
    else
        return 'None'
    end
end

-- Update state.PetMode, as well as functions that use it for set determination.
function update_pet_mode()
    state.PetMode:set(get_pet_mode())
    update_custom_groups()
end

-- Update custom groups based on the current pet.
function update_custom_groups()
    classes.CustomIdleGroups:clear()
    if pet.isvalid then
        classes.CustomIdleGroups:append(state.PetMode.value)
    end
end

-- Display current pet status.
function display_pet_status()
    if pet.isvalid then
       local petInfoString = pet.name..' ['..pet.head..']: '..tostring(pet.status)..'  TP='..tostring(pet.tp)..'  HP%='..tostring(pet.hpp)
       
       if magicPetModes:contains(state.PetMode.value) then
           petInfoString = petInfoString..'  MP%='..tostring(pet.mpp)
        end
        
 --       add_to_chat(122,petInfoString)
    end
end



-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 1)
    elseif player.sub_job == 'NIN' then
        set_macro_page(2, 1)
    elseif player.sub_job == 'THF' then
        set_macro_page(2, 1)
    else
        set_macro_page(2, 1)
    end
end
