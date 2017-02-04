-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
 
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
 
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	send_command('wait 2;input /lockstyleset 11')
end
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Rag', 'RagAcc', 'RagHighAcc', 'Apoc', 'ApocAcc', 'ApocHighAcc', 'NoStpTrait', 'DW')
    state.HybridMode:options ('Reraise')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
     
    select_default_macro_book()
 
     
 
end
 
    -- Define sets and vars used by this job file.
    function init_gear_sets()
            --------------------------------------
            -- Start defining the sets
            --------------------------------------
            -- Precast Sets
 
            -- Precast sets to enhance JAs
            sets.precast.JA['Diabolic Eye'] = {}
            sets.precast.JA['Arcane Circle'] = {}
            sets.precast.JA['Nether Void'] = {}
            sets.precast.JA['Souleater'] = {}
            sets.precast.JA['Weapon Bash'] = {}
            sets.precast.JA['Last Resort'] = {back="Ankou's Mantle"}
            sets.precast.JA['Dark Seal'] = {}
            sets.precast.JA['Blood Weapon'] = {}
 
             
           -- Waltz set (chr and vit)
    sets.precast.Waltz = {}        
            
            -- Fast cast sets for spells
                      
            -- Precast Sets
    sets.precast.FC = {
		head="Carmine Mask",  --12
		neck="Baetyl Pendant",  --4
		lear="Loquacious Earring", --2
		hands="Leyline Gloves", --7
		lring="Rahab Ring",  --2
		rring="Prolix Ring",  --2
		feet="Carmine Greaves" --7
		}
                    
            -- Specific spells
    sets.midcast.Utsusemi = {}

	sets.midcast['Elemental Magic'] = {
		ammo="Ghastly Tathlum +1",
		head="Carmine Mask",
		neck="Baetyl Pendant",
		lear="Friomisi Earring",
		rear="Hecate's Earring",
		body="Founder's Breastplate",
		hands="Leyline Gloves",
		lring="Stikini Ring",
		rring="Resonance Ring",
		legs="Flamma Dirs +1",
		feet="Founder's Greaves"
		}
      
    sets.midcast.DarkMagic = {
		head="Carmine Mask",
		neck="Incanter's Torque",
		lear="Choleric Earring",
		body="Flamma Korazin +1",
		hands="Flamma Manopolas +1",
		lring="Evanescence Ring",
		rring="Etana Ring",
		back="Niht Mantle",
		legs="Flamma Dirs +1",
		feet="Flamma Gambieras +1"}
             
    sets.midcast.Endark = sets.midcast.Endark
             
    sets.midcast['Endark II'] = sets.midcast.Endark
            
    sets.midcast['Dread Spikes'] = {} --based on max HP
             
             
    sets.midcast['Enfeebling Magic'] = {}
            
    sets.midcast.Stun = {
		head="Carmine Mask",
		neck="Incanter's Torque",
		lear="Choleric Earring",
		body="Flamma Korazin +1",
		hands="Flamma Manopolas +1",
		lring="Evanescence Ring",
		rring="Etana Ring",
		back="Niht Mantle",
		legs="Flamma Dirs +1",
		feet="Flamma Gambieras +1"}
             
    sets.midcast.Absorb = {
		head="Carmine Mask",
		neck="Incanter's Torque",
		lear="Choleric Earring",
		body="Flamma Korazin +1",
		hands="Flamma Manopolas +1",
		lring="Evanescence Ring",
		rring="Etana Ring",
		back="Ankou's Mantle",
		legs="Flamma Dirs +1",
		feet="Flamma Gambieras +1"}
                    
    sets.midcast.Drain = {
		head="Carmine Mask",
		neck="Incanter's Torque",
		lear="Choleric Earring",
		body="Flamma Korazin +1",
		hands="Flamma Manopolas +1",
		lring="Evanescence Ring",
		rring="Etana Ring",
		back="Niht Mantle",
		legs="Flamma Dirs +1",
		feet="Flamma Gambieras +1"}
                    
    sets.midcast['Aspir'] = {
		head="Carmine Mask",
		neck="Incanter's Torque",
		lear="Choleric Earring",
		body="Flamma Korazin +1",
		hands="Flamma Manopolas +1",
		lring="Evanescence Ring",
		rring="Etana Ring",
		back="Niht Mantle",
		legs="Flamma Dirs +1",
		feet="Flamma Gambieras +1"}
                 
    sets.midcast['Aspir II'] = {
		head="Carmine Mask",
		neck="Incanter's Torque",
		lear="Choleric Earring",
		body="Flamma Korazin +1",
		hands="Flamma Manopolas +1",
		lring="Evanescence Ring",
		rring="Etana Ring",
		back="Niht Mantle",
		legs="Flamma Dirs +1",
		feet="Flamma Gambieras +1"}
             
 
    sets.midcast['Drain II'] = {
		head="Carmine Mask",
		neck="Incanter's Torque",
		lear="Choleric Earring",
		body="Flamma Korazin +1",
		hands="Flamma Manopolas +1",
		lring="Evanescence Ring",
		rring="Etana Ring",
		back="Niht Mantle",
		legs="Flamma Dirs +1",
		feet="Flamma Gambieras +1"}
             
    sets.midcast['Drain III'] = {
		head="Carmine Mask",
		neck="Incanter's Torque",
		lear="Choleric Earring",
		body="Flamma Korazin +1",
		hands="Flamma Manopolas +1",
		lring="Evanescence Ring",
		rring="Etana Ring",
		back="Niht Mantle",
		legs="Flamma Dirs +1",
		feet="Flamma Gambieras +1"}
 
                                            
            -- Weaponskill sets
            -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Amar Cluster",
		head={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Crit.hit rate+2','Accuracy+9','Attack+10',}},
		body="Flamma Korazin +1",
		hands={ name="Despair Fin. Gaunt.", augments={'STR+12','VIT+7','Haste+2%',}},
		legs="Flamma Dirs +1",
		feet="Flam. Gambieras +1",
		neck="Sanctity Necklace",
		waist="Fotia Belt",
		left_ear="Cessance Earring",
		right_ear="Mache Earring",
		left_ring="Ifrit Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+1',}},
		right_ring="Shukuyu Ring"}
 
 
            -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

	-- Catastrophe: 40% STR, 40% INT	
	sets.precast.WS['Catastrophe'] = {}

	-- Sanguine Blade: STR 30%, MND 50%, MAB > INT
    sets.precast.WS['Sanguine Blade'] = {}

	-- Torcleaver: 80% VIT, use elemental gorget/belt
    sets.precast.WS['Torcleaver'] = {
		head="Valorous Mask",
		neck="Snow Gorget",
		lear="Steelflash Earring",
		rear="Bladeborn Earring",
		body="Flamma Korazin +1",
		hands="Sulevia's Gauntlets +1",
		lring="Shukuyu Ring",
		rring="Rufescent Ring",
		back="Ankou's Mantle",
		waist="Fotia Belt",
		legs="Flamma Dirs +1",
		feet="Sulevia's Leggings +1"}

	-- Scourge: 40% STR, 40% VIT
    sets.precast.WS['Scourge'] = {}

	-- Savage Blade: 50% MND, 50% STR
    sets.precast.WS['Savage Blade'] = {
		ammo="Amar Cluster",
		head={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Crit.hit rate+2','Accuracy+9','Attack+10',}},
		body="Flamma Korazin +1",
		hands={ name="Despair Fin. Gaunt.", augments={'STR+12','VIT+7','Haste+2%',}},
		legs="Flamma Dirs +1",
		feet="Flam. Gambieras +1",
		neck="Sanctity Necklace",
		waist="Fotia Belt",
		left_ear="Cessance Earring",
		right_ear="Mache Earring",
		left_ring="Ifrit Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+1',}},
		right_ring="Shukuyu Ring"}

	-- Requiescat: MND, elemental gorget and belt (Soil, Shadow)
    sets.precast.WS['Requiescat'] = {}
    
	-- Cross Reaper: 60% STR, 60% MND
    sets.precast.WS['Cross Reaper'] = {
		ammo="Amar Cluster",
		head={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Crit.hit rate+2','Accuracy+9','Attack+10',}},
		body="Flamma Korazin +1",
		hands={ name="Despair Fin. Gaunt.", augments={'STR+12','VIT+7','Haste+2%',}},
		legs="Flamma Dirs +1",
		feet="Flam. Gambieras +1",
		neck="Sanctity Necklace",
		waist="Fotia Belt",
		left_ear="Cessance Earring",
		right_ear="Mache Earring",
		left_ring="Ifrit Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+1',}},
		right_ring="Shukuyu Ring"}
        
	-- Quietus: 60% STR, 60% MND
    sets.precast.WS['Quietus'] = {
		ammo="Amar Cluster",
		head="Valorous Mask",
		body="Flamma Korazin +1",
		hands={ name="Despair Fin. Gaunt.", augments={'STR+12','VIT+7','Haste+2%',}},
		legs="Flamma Dirs +1",
		feet="Sulev. Leggings +1",
		neck="Snow Gorget",
		waist="Fotia Belt",
		left_ear="Bladeborn Earring",
		right_ear="Steelflash Earring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+1',}},
		left_ring="Rufescent Ring",
		right_ring="Shukuyu Ring"}
                     
    -- Entropy: INT, Elemental gorget and belt (Aqua, Shadow)              
    sets.precast.WS['Entropy'] = {}
 
	-- Insurgency: 20% STR, 20% INT
    sets.precast.WS['Insurgency'] = {}
 
    -- Resolution: STR, Elemental gorget and belt (Breeze, Thunder)        
    sets.precast.WS['Resolution'] = {
		ammo="Amar Cluster",
	head={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Crit.hit rate+2','Accuracy+9','Attack+10',}},
		body="Flamma Korazin +1",
		hands={ name="Despair Fin. Gaunt.", augments={'STR+12','VIT+7','Haste+2%',}},
		legs="Flamma Dirs +1",
		feet="Flam. Gambieras +1",
		neck="Breeze Gorget",
		waist="Fotia Belt",
		left_ear="Cessance Earring",
		right_ear="Mache Earring",
		left_ring="Ifrit Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+1',}},
		right_ring="Shukuyu Ring"}

	-- Guillotine: 30% STR, 50% MND
    sets.precast.WS['Guillotine'] = {
		ammo="Amar Cluster",
		head={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Crit.hit rate+2','Accuracy+9','Attack+10',}},
		body="Flamma Korazin +1",
		hands={ name="Despair Fin. Gaunt.", augments={'STR+12','VIT+7','Haste+2%',}},
		legs="Flamma Dirs +1",
		feet="Flam. Gambieras +1",
		neck="Sanctity Necklace",
		waist="Fotia Belt",
		left_ear="Cessance Earring",
		right_ear="Mache Earring",
		left_ring="Ifrit Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+1',}},
		right_ring="Shukuyu Ring"}
                     
                                
            -- Sets to return to when not performing an action.
            
            -- Resting sets
    sets.resting = {
		head="Befouled Crown",
		neck="Sanctity Necklace",
		lear="Infused Earring",
		lring="Paguroidea Ring",
		legs="Carmine Cuisses +1"}
            
      
            -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {
		body="Lugra Cloak",
		neck="Baetyl Pendant",
		lear="Infused Earring",
		lring="Paguroidea Ring",
		rring="Defending Ring",
		legs="Carmine Cuisses +1"}
 
            -- Defense sets
    sets.defense.PDT = {}
      
    sets.defense.Reraise = {}
      
    sets.defense.MDT = {}
      
      
      
            -- Engaged sets
             
    sets.engaged = {
		ammo="Ginsen",
		head={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Crit.hit rate+2','Accuracy+9','Attack+10',}},
		body={ name="Found. Breastplate", augments={'Accuracy+15','Mag. Acc.+15','Attack+15','"Mag.Atk.Bns."+15',}},
		hands="Valorous Mitts",
		legs={ name="Odyssean Cuisses", augments={'Accuracy+25 Attack+25','"Dbl.Atk."+2','Accuracy+11',}},
		feet="Flam. Gambieras +1",
		neck="Lissome Necklace",
		waist="Windbuffet Belt +1",
		left_ear="Cessance Earring",
		right_ear="Brutal Earring",
		left_ring="Petrov Ring",
		back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+1',}},
		right_ring="Rajas Ring"}
             
             
    sets.engaged.DW = {}
     
     
    end
     
function precast(spell,abil)
    --equips favorite weapon if disarmed
    if player.equipment.main == "empty" or player.equipment.sub == "empty" then
        equip({main="Montante",
        sub="Flanged Grip"})
    end
	
	if buffactive.sleep and player.hp > 100 and player.status == "Engaged" then 
                equip({head="Frenzy Sallet"})
        end
end
 
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' then
        if spell.element == world.day_element or spell.element == world.weather_element then
            equip(sets.midcast['Elemental Magic'], {waist="Hachirin-No-Obi"})
        end
    end
end
------------------------------------------------------------------------------
function job_post_midcast(spell, action, spellMap, eventArgs)
    if (skillchain_elements[spell.skillchain_a]:contains(world.day_element) or skillchain_elements[spell.skillchain_b]:contains(world.day_element) or skillchain_elements[spell.skillchain_c]:contains(world.day_element))
        then equip({head="Gavialis Helm"})
    end
end 
 
 
function job_post_midcast(spell, action, spellMap, eventArgs)
    if S{"Drain","Drain II","Drain III"}:contains(spell.english) and (spell.element==world.day_element or spell.element==world.weather_element) then
        equip({waist="Hachirin-no-obi"})
    end
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
    end
    if buff:lower()=='sleep' then
        if gain and player.hp > 120 and player.status == "Engaged" then -- Equip Berserker's Torque When You Are Asleep
            equip({neck="Berserker's Torque"})
        elseif not gain then -- Take Berserker's off
            handle_equipping_gear(player.status)
        end
    end
end
 
function customize_melee_set(meleeSet)
    if state.Buff.Sleep and player.hp > 120 and player.status == "Engaged" then -- Equip Berserker's Torque When You Are Asleep
        meleeSet = set_combine(meleeSet,{neck="Berserker's Torque"})
    end
    return meleeSet
end
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 16)
end
