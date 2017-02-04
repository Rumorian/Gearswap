-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	
	send_command('wait 2;input /lockstyleset 06')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant', 'Proc')
    state.IdleMode:options('Normal', 'PDT')
    
    state.MagicBurst = M(false, 'Magic Burst')

    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
        'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
        'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
        'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}

    gear.macc_hagondes = {name="Hagondes Cuffs", augments={'Phys. dmg. taken -3%','Mag. Acc.+29'}}
    
    -- Additional local binds
    send_command('bind ^` input /ma Stun <t>')
    send_command('bind @` gs c activate MagicBurst')

    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind @`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    ---- Precast Sets ----
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {feet="Wicce Sabots"}

    sets.precast.JA.Manafont = {body="Sorcerer's Coat +2"}
    
    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}


    -- Fast cast sets for spells

    sets.precast.FC = {
		main={ name="Lathi", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
        sub="Clerisy Strap", --2
		head="Vanya Hood", --10
		neck="Baetyl Pendant", --4
        body="Eirene's Manteel", --10
		hands="Telchine Gloves", --4
		ring2="Rahab Ring", --2
		ring1="Prolix Ring", --2
		legs="Psycloth Lappas", --7
		lear="Loquacious Earring",  -- 2
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+2','"Fast Cast"+5','MND+2','"Mag.Atk.Bns."+10',}}, --10
		waist="Witful Belt"} --3
		-- 56 total

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

--    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {neck="Stoicheion Medal"})

--    sets.precast.FC.Cure = set_combine(sets.precast.FC, {body="Heka's Kalasiris", back="Pahtli Cape"})

--    sets.precast.FC.Curaga = sets.precast.FC.Cure

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Vidohunir'] = {}
    
	sets.precast.WS['Shattersoul'] = {
		main={ name="Lathi", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},		main={ name="Lathi", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
        sub="Clerisy Strap",
		head="Jhakri Coronal +1",
		neck="Lissome Necklace",
		body="Jhakri Robe +1",
		hands="Jhakri Cuffs +1",
		lring="Etana Ring",
		rring="Vertigo Ring",
		back="Kayapa Cape",
		waist="Latria Sash",
		legs="Jhakri Slops +1",
		feet="Jhakri Pigaches +1"}
    
    ---- Midcast Sets ----

    sets.midcast.FastRecast = {
		main={ name="Lathi", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
		sub="Clerisy Strap", --2
		head="Vanya Hood", --10
		neck="Baetyl Pendant", --4
        body="Eirene's Manteel", --10
		hands="Telchine Gloves", --4
		ring2="Rahab Ring", --2
		ring1="Prolix Ring", --2
		legs="Psycloth Lappas", --7
		lear="Loquacious Earring",  -- 2
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+2','"Fast Cast"+5','MND+2','"Mag.Atk.Bns."+10',}}, --10
		waist="Witful Belt"} --3
		-- 56 total

    sets.midcast.Cure = {
		main={ name="Lathi", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
        sub="Clerisy Strap",
		head="Vanya Hood",  --10
		neck="Incanter's Torque",
		ear1="Mendicant's Earring",  --5
		ear2="Static Earring",
        body="Vanya Robe",
		hands="Telchine Gloves",  --10
		ring1="Stikini Ring",
		ring2="Sirona's Ring",
        back="Solemnity Cape",  --7
		waist="Latria Sash",
		legs="Gyve Trousers", --10
		feet="Vanya Clogs"}  --10
		-- 52 total

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast['Enhancing Magic'] = {
		main={ name="Lathi", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
        sub="Clerisy Strap",
	head="Telchine Cap",
	neck="Incanter's Torque",
	body="Telchine Chas.",
	hands="Telchine Gloves",
	back="Fi Follet Cape",
	legs={ name="Telchine Braconi", augments={'Attack+5','"Fast Cast"+3','"Regen" potency+1',}},
	feet="Vanya Clogs"}
    
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})
	
	sets.midcast.Regen = {
		waist="Rumination Sash", --Spell interruption -10%
		body={ name="Telchine Chas.", augments={'Fast Cast+3','Enh. Mag. eff. dur. +8',}},
		legs={ name="Telchine Braconi", augments={'Attack+5','"Fast Cast"+3','"Regen" potency +1',}},
		feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +7',}},
		neck="Sanctity Necklace"}

    sets.midcast['Enfeebling Magic'] = {
		main={ name="Lathi", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
        sub="Clerisy Strap",
		ammo="Kalboron Stone",
		head="Befouled Crown",
		neck="Incanter's Torque",
		lear="Barkarole Earring",
		rear="Lempo Earring",
		body="Vanya Robe",
		hands="Lurid Mitts",
		ring1="Vertigo Ring",
		ring2="Stikini Ring",
        back="Taranus's Cape",
		legs="Psycloth Lappas",
		feet="Medium's Sabots",
		waist="Rumination Sash"}
        
    sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']

    sets.midcast['Dark Magic'] = {
		main="Rubicundity",
        sub="Culminus",
		head="Merlinic Hood",
		neck="Incanter's Torque",
		neck="Incanter's Torque",
		ear1="Barkarole Earring",
		ear2="Lempo Earring",
        body="Psycloth Vest",
		hands="Jhakri Cuffs +1",
		ring1="Evanescence Ring",
		ring2="Stikini Ring",
        back="Bane Cape",
		waist="Tengu-No-Obi",
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+10%','CHR+8','Mag. Acc.+7','"Mag.Atk.Bns."+1',}},
		feet="Wicce Sabots"}

    sets.midcast.Drain = {
		main="Rubicundity",
        sub="Culminus",
		head="Merlinic Hood",
		neck="Incanter's Torque",
		ear1="Barkarole Earring",
		ear2="Lempo Earring",
        body="Psycloth Vest",
		hands="Jhakri Cuffs +1",
		ring1="Evanescence Ring",
		ring2="Stikini Ring",
        back="Bane Cape",
		waist="Fucho-No-Obi",
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+10%','CHR+8','Mag. Acc.+7','"Mag.Atk.Bns."+1',}},
		feet="Wicce Sabots"}
    
    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = {
		main="Rubicundity",
        sub="Culminus",
		head="Merlinic Hood",
		neck="Incanter's Torque",
		neck="Incanter's Torque",
		ear1="Barkarole Earring",
		ear2="Lempo Earring",
        body="Psycloth Vest",
		hands="Jhakri Cuffs +1",
		ring1="Evanescence Ring",
		ring2="Stikini Ring",
        back="Bane Cape",
		waist="Tengu-No-Obi",
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+10%','CHR+8','Mag. Acc.+7','"Mag.Atk.Bns."+1',}},
		feet="Wicce Sabots"
		}

    sets.midcast.BardSong = {}


    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {
		main={ name="Lathi", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
        sub="Clerisy Strap",
		ammo="Ghastly Tathlum +1",
        head="Merlinic Hood",
		neck="Mizukage-No-Kubikazari",
		lear="Choleric Earring",
		rear="Barkarole Earring",
		body="Jhakri Robe +1",
		hands="Amalric Gages",
		lring="Resonance Ring",
		rring="Stikini Ring",
		waist="Tengu-No-Obi",
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+10%','CHR+8','Mag. Acc.+7','"Mag.Atk.Bns."+1',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic burst mdg.+9%','INT+14',}},
		back="Taranus's Cape"}

 --   sets.midcast['Elemental Magic'].Resistant = {main="Lehbrailg +2",sub="Zuuxowu Grip",ammo="Dosis Tathlum",
--        head="Hagondes Hat",neck="Eddy Necklace",ear1="Hecate's Earring",ear2="Friomisi Earring",
--        body="Hagondes Coat",hands=gear.macc_hagondes,ring1="Icesoul Ring",ring2="Acumen Ring",
--        back="Toro Cape",waist=gear.ElementalObi,legs="Hagondes Pants",feet="Bokwus Boots"}

--    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {sub="Wizzan Grip"})
--    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'], {sub="Wizzan Grip"})


 --   -- Minimal damage gear for procs.
 --   sets.midcast['Elemental Magic'].Proc = {main="Earth Staff", sub="Mephitis Grip",ammo="Impatiens",
 --       head="Nahtirah Hat",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
 --       body="Manasa Chasuble",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
 --       back="Swith Cape +1",waist="Witful Belt",legs="Nares Trews",feet="Chelona Boots +1"}


    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {
		main={ name="Lathi", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
        sub="Clerisy Strap",
		hands="Serpentes Cuffs",
		ring2="Paguroidea Ring",
		feet="Serpentes Sabots"}
    

    -- Idle sets
    
    -- Normal refresh idle set
    sets.idle = {
		main={ name="Lathi", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
        sub="Clerisy Strap",
		head="Befouled Crown",
		neck="Bathy Choker +1",
		legs="Assiduity Pants +1",
		body="Witching Robe",
        hands="Merlinic Dastanas",
        lring="Paguroidea Ring",
		rring="Defending Ring",
		waist="Fucho-No-Obi",
		feet="Herald's Gaiters",
		lear="Hearty Earring",
		rear="Infused Earring"}

    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
 --   sets.idle.PDT = {main="Earth Staff", sub="Zuuxowu Grip",ammo="Impatiens",
 --       head="Nahtirah Hat",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
 --       body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2=gear.DarkRing.physical,
 --       back="Umbra Cape",waist="Hierarch Belt",legs="Hagondes Pants",feet="Herald's Gaiters"}

    -- Idle mode scopes:
    -- Idle mode when weak.
 --   sets.idle.Weak = {main="Bolelabunga",sub="Genbu's Shield",ammo="Impatiens",
 --       head="Hagondes Hat",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
 --       body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Paguroidea Ring",
 --       back="Umbra Cape",waist="Hierarch Belt",legs="Nares Trews",feet="Hagondes Sabots"}
    
    -- Town gear.
    sets.idle.Town = {
		main={ name="Lathi", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
        sub="Clerisy Strap",
		body="Councilor's Garb",
		feet="Herald's Gaiters"}
        
    -- Defense sets

--    sets.defense.PDT = {main="Earth Staff",sub="Zuuxowu Grip",
 --       head="Nahtirah Hat",neck="Twilight Torque",
 --       body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2=gear.DarkRing.physical,
 --       back="Umbra Cape",waist="Hierarch Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

 --   sets.defense.MDT = {ammo="Demonry Stone",
 --       head="Nahtirah Hat",neck="Twilight Torque",
 --       body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Shadow Ring",
 --       back="Tuilha Cape",waist="Hierarch Belt",legs="Bokwus Slops",feet="Hagondes Sabots"}

 --   sets.Kiting = {feet="Herald's Gaiters"}

 --   sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    
 --   sets.buff['Mana Wall'] = {feet="Goetia Sabots +2"}

	sets.magic_burst = {
		main={ name="Lathi", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
        sub="Clerisy Strap",
		head="Merlinic Hood", --10
		neck="Mizukage-no-Kubikazari", --10
	    ear1="Barkarole Earring",
		ear2="Friomisi Earring",
		body="Jhakri Robe +1",
		hands="Amalric Gages", --5 II
        ring1="Mujin Band", --5 II
		ring2="Resonance Ring", 
		waist="Refoccilation Stone",
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+10%','CHR+8','Mag. Acc.+7','"Mag.Atk.Bns."+1',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic burst mdg.+9%','INT+14',}}, --9
		back="Taranus's Cape"} --5
		-- 44 + 10
		
    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
   sets.engaged = {
		main={ name="Lathi", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
        sub="Clerisy Strap",
		head="Jhakri Coronal +1",
        ammo="Amar Cluster",
		neck="Sanctity Necklace",
		ear1="Cessance Earring",
		ear2="Mache Earring",
        body="Jhakri Robe +1",
		hands="Merlinic Dastanas",
		ring1="Portus Annulet",
		ring2="Rajas Ring",
        waist="Windbuffet Belt +1",
		back="Kayapa Cape",
		legs="Jhakri Slops +1",
		feet="Jhakri Pigaches +1"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spellMap == 'Cure' or spellMap == 'Curaga' then
        gear.default.obi_waist = "Gishdubara Sash"
    elseif spell.skill == 'Elemental Magic' then
        gear.default.obi_waist = "Refoccilation Stone"
        if state.CastingMode.value == 'Proc' then
            classes.CustomClass = 'Proc'
        end
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)

end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.magic_burst)
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    -- Lock feet after using Mana Wall.
    if not spell.interrupted then
        if spell.english == 'Mana Wall' then
            enable('feet')
            equip(sets.buff['Mana Wall'])
            disable('feet')
        elseif spell.skill == 'Elemental Magic' then
            state.MagicBurst:reset()
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Unlock feet when Mana Wall buff is lost.
    if buff == "Mana Wall" and not gain then
        enable('feet')
        handle_equipping_gear(player.status)
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
        --[[ No real need to differentiate with current gear.
        if lowTierNukes:contains(spell.english) then
            return 'LowTierNuke'
        else
            return 'HighTierNuke'
        end
        --]]
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 8)
end

--Refine Nuke Spells
function refine_various_spells(spell, action, spellMap, eventArgs)
	aspirs = S{'Aspir','Aspir II','Aspir III'}
	sleeps = S{'Sleep II','Sleep'}
	sleepgas = S{'Sleepga II','Sleepga'}
	nukes = S{'Fire', 'Blizzard', 'Aero', 'Stone', 'Thunder', 'Water',
	'Fire II', 'Blizzard II', 'Aero II', 'Stone II', 'Thunder II', 'Water II',
	'Fire III', 'Blizzard III', 'Aero III', 'Stone III', 'Thunder III', 'Water III',
	'Fire IV', 'Blizzard IV', 'Aero IV', 'Stone IV', 'Thunder IV', 'Water IV',
	'Fire V', 'Blizzard V', 'Aero V', 'Stone V', 'Thunder V', 'Water V',
	'Fire VI', 'Blizzard VI', 'Aero VI', 'Stone VI', 'Thunder VI', 'Water VI',
	'Firaga', 'Blizzaga', 'Aeroga', 'Stonega', 'Thundaga', 'Waterga',
	'Firaga II', 'Blizzaga II', 'Aeroga II', 'Stonega II', 'Thundaga II', 'Waterga II',
	'Firaga III', 'Blizzaga III', 'Aeroga III', 'Stonega III', 'Thundaga III', 'Waterga III',	
	'Firaja', 'Blizzaja', 'Aeroja', 'Stoneja', 'Thundaja', 'Waterja',
	}
	cures = S{'Cure IV','Cure III','Cure II',}
	
	if spell.skill == 'Healing Magic' then
		if not cures:contains(spell.english) then
			return
		end
		
		local newSpell = spell.english
		local spell_recasts = windower.ffxi.get_spell_recasts()
		local cancelling = 'All '..spell.english..' spells are on cooldown. Cancelling spell casting.'
		
		if spell_recasts[spell.recast_id] > 0 then
			if cures:contains(spell.english) then
				if spell.english == 'Cure' then
					add_to_chat(122,cancelling)
					eventArgs.cancel = true
				return
				elseif spell.english == 'Cure IV' then
					newSpell = 'Cure III'
				elseif spell.english == 'Cure III' then
					newSpell = 'Cure II'
				end
			end
		end
		
		if newSpell ~= spell.english then
			send_command('@input /ma "'..newSpell..'" '..tostring(spell.target.raw))
			eventArgs.cancel = true
			return
		end
	elseif spell.skill == 'Dark Magic' then
		if not aspirs:contains(spell.english) then
			return
		end
		
		local newSpell = spell.english
		local spell_recasts = windower.ffxi.get_spell_recasts()
		local cancelling = 'All '..spell.english..' spells are on cooldown. Cancelling spell casting.'

		if spell_recasts[spell.recast_id] > 0 then
			if aspirs:contains(spell.english) then
				if spell.english == 'Aspir' then
					add_to_chat(122,cancelling)
					eventArgs.cancel = true
				return
				elseif spell.english == 'Aspir II' then
					newSpell = 'Aspir'
				elseif spell.english == 'Aspir III' then
					newSpell = 'Aspir II'
				end
			end
		end
		
		if newSpell ~= spell.english then
			send_command('@input /ma "'..newSpell..'" '..tostring(spell.target.raw))
			eventArgs.cancel = true
			return
		end
	elseif spell.skill == 'Elemental Magic' then
		if not sleepgas:contains(spell.english) and not sleeps:contains(spell.english) and not nukes:contains(spell.english) then
			return
		end

		local newSpell = spell.english
		local spell_recasts = windower.ffxi.get_spell_recasts()
		local cancelling = 'All '..spell.english..' spells are on cooldown. Cancelling spell casting.'

		if spell_recasts[spell.recast_id] > 0 then
			if sleeps:contains(spell.english) then
				if spell.english == 'Sleep' then
					add_to_chat(122,cancelling)
					eventArgs.cancel = true
				return
				elseif spell.english == 'Sleep II' then
					newSpell = 'Sleep'
				end
			elseif sleepgas:contains(spell.english) then
				if spell.english == 'Sleepga' then
					add_to_chat(122,cancelling)
					eventArgs.cancel = true
					return
				elseif spell.english == 'Sleepga II' then
					newSpell = 'Sleepga'
				end
			elseif nukes:contains(spell.english) then	
				if spell.english == 'Fire' then
					eventArgs.cancel = true
					return
				elseif spell.english == 'Fire VI' then
					newSpell = 'Fire V'
				elseif spell.english == 'Fire V' then
					newSpell = 'Fire IV'
				elseif spell.english == 'Fire IV' then
					newSpell = 'Fire III'
				elseif spell.english == 'Fire III' then
					newSpell = 'Fire II'					
				elseif spell.english == 'Fire II' then
					newSpell = 'Fire'
				elseif spell.english == 'Firaja' then
					newSpell = 'Firaga III'
				elseif spell.english == 'Firaga III' then
					newSpell = 'Firaga II'					
				elseif spell.english == 'Firaga II' then
					newSpell = 'Firaga'
				end 
				if spell.english == 'Blizzard' then
					eventArgs.cancel = true
					return
				elseif spell.english == 'Blizzard VI' then
					newSpell = 'Blizzard V'
				elseif spell.english == 'Blizzard V' then
					newSpell = 'Blizzard IV'
				elseif spell.english == 'Blizzard IV' then
					newSpell = 'Blizzard III'	
				elseif spell.english == 'Blizzard III' then
					newSpell = 'Blizzard II'						
				elseif spell.english == 'Blizzard II' then
					newSpell = 'Blizzard'
				elseif spell.english == 'Blizzaja' then
					newSpell = 'Blizzaga III'
				elseif spell.english == 'Blizzaga III' then
					newSpell = 'Blizzaga II'
				elseif spell.english == 'Blizzaga II' then
					newSpell = 'Blizzaga'	
				end 
				if spell.english == 'Aero' then
					eventArgs.cancel = true
					return
				elseif spell.english == 'Aero VI' then
					newSpell = 'Aero V'
				elseif spell.english == 'Aero V' then
					newSpell = 'Aero IV'
				elseif spell.english == 'Aero IV' then
					newSpell = 'Aero III'
				elseif spell.english == 'Aero III' then
					newSpell = 'Aero II'						
				elseif spell.english == 'Aero II' then
					newSpell = 'Aero'
				elseif spell.english == 'Aeroja' then
					newSpell = 'Aeroga III'
				elseif spell.english == 'Aeroga III' then
					newSpell = 'Aeroga II'	
				elseif spell.english == 'Aeroga II' then
					newSpell = 'Aeroga'	
				end 
				if spell.english == 'Stone' then
					eventArgs.cancel = true
					return
				elseif spell.english == 'Stone VI' then
					newSpell = 'Stone V'
				elseif spell.english == 'Stone V' then
					newSpell = 'Stone IV'
				elseif spell.english == 'Stone IV' then
					newSpell = 'Stone III'
				elseif spell.english == 'Stone III' then
					newSpell = 'Stone II'						
				elseif spell.english == 'Stone II' then
					newSpell = 'Stone'
				elseif spell.english == 'Stoneja' then
					newSpell = 'Stonega III'
				elseif spell.english == 'Stonega III' then
					newSpell = 'Stonega II'
				elseif spell.english == 'Stonega II' then
					newSpell = 'Stonega'	
				end 
				if spell.english == 'Thunder' then
					eventArgs.cancel = true
					return
				elseif spell.english == 'Thunder VI' then
					newSpell = 'Thunder V'
				elseif spell.english == 'Thunder V' then
					newSpell = 'Thunder IV'
				elseif spell.english == 'Thunder IV' then
					newSpell = 'Thunder III'
				elseif spell.english == 'Thunder III' then
					newSpell = 'Thunder II'					
				elseif spell.english == 'Thunder II' then
					newSpell = 'Thunder'
				elseif spell.english == 'Thundaja' then
					newSpell = 'Thundaga III'
				elseif spell.english == 'Thundaga III' then
					newSpell = 'Thundaga II'
				elseif spell.english == 'Thundaga II' then
					newSpell = 'Thundaga'	
				end 
				if spell.english == 'Water' then
					eventArgs.cancel = true
					return
				elseif spell.english == 'Water VI' then
					newSpell = 'Water V'
				elseif spell.english == 'Water V' then
					newSpell = 'Water IV'
				elseif spell.english == 'Water IV' then
					newSpell = 'Water III'
				elseif spell.english == 'Water III' then
					newSpell = 'Water II'						
				elseif spell.english == 'Water II' then
					newSpell = 'Water'
				elseif spell.english == 'Waterja' then
					newSpell = 'Waterga III'
				elseif spell.english == 'Waterga III' then
					newSpell = 'Waterga II'	
				elseif spell.english == 'Waterga II' then
					newSpell = 'Waterga'	
				end 
			end
		end

		if newSpell ~= spell.english then
			send_command('@input /ma "'..newSpell..'" '..tostring(spell.target.raw))
			eventArgs.cancel = true
			return
		end
	end
end

function job_precast(spell, action, spellMap, eventArgs)
    refine_various_spells(spell, action, spellMap, eventArgs)
end
