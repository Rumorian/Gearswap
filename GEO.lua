-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
	mote_include_version = 2
	
	-- Load and initialize the include file.
	include('Mote-Include.lua')
	send_command('wait 2;input /lockstyleset 05')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	indi_timer = ''
	indi_duration = 285
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('None', 'Normal')
	state.CastingMode:options('Normal', 'Seidr', 'Resistant')
	state.IdleMode:options('Normal', 'PDT', 'MDT')

	state.MagicBurst = M(false, 'Magic Burst')
	state.MPCoat = M(false, 'MP Coat')
	

	-- Additional local binds
	send_command('bind ^` input /ja "Full Circle" <me>')
	send_command('bind !` gs c toggle MagicBurst')
	send_command('bind ^, input /ma Sneak <stpc>')
	send_command('bind ^. input /ma Invisible <stpc>')
	
	select_default_macro_book()
end

function user_unload()
	send_command('unbind ^`')
	send_command('unbind !`')
	send_command('unbind ^,')
	send_command('unbind !.')
end


-- Define sets and vars used by this job file.
function init_gear_sets()

	------------------------------------------------------------------------------------------------
	----------------------------------------- Precast Sets -----------------------------------------
	------------------------------------------------------------------------------------------------
	
	-- Precast sets to enhance JAs
	sets.precast.JA.Bolster = {
		body="Bagua Tunic"
	}
	sets.precast.JA['Life Cycle'] = {
		body="Geo. Tunic +1",
		back="Nantosuelta's Cape",
	}
	
	sets.precast.JA['Curative Recantation'] = {hands="Bagua Mitaines +1"}
	
	sets.precast.JA['Primeval Zeal'] = {head="Bagua Galero +1"}
	
	sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals +1"}
  
	-- Fast cast sets for spells
	
	sets.precast.FC = {
	--	/RDM --15
  		main="Solstice", --5
		sub="Culminus",
		neck="Baetyl Pendant", --4
		head="Vanya Hood", --10
		waist="Witful Belt", --3
		lear="Loquacious Earring",  -- 2
		body="Eirene's Manteel",  --10
		hands="Telchine Gloves",  --4
		back="Lifestream Cape",  --7
		legs="Geomancy Pants +1",  --11
		ring1="Prolix ring",  --2
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+2','"Fast Cast"+5','MND+2','"Mag.Atk.Bns."+10',}}, --10
		ring2="Rahab Ring"   --2
		} -- 70 without /RDM

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
		waist="Siegel Sash"})

	sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
		hands="Bagua Mitaines +1",
		lear="Barkarole Earring"
				})

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		feet="Vanya Clogs", --15
		lear="Mendicant's Earring" --5
				})

	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC, {
		head="Umuthi Hat"
				})		
		
	sets.precast.FC.Curaga = sets.precast.FC.Cure

	sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], {
		})
	 
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
   sets.precast.WS = {head="Sukeroku Hachi.",feet="Battlecast Gaiters"}

  -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
  -- Realmrazer = MND
  sets.precast.WS['Realmrazer'] = {
     head="Jhakri Coronal +1",
	 neck="Flame Gorget",
	 ear1="Friomisi Earring",
	 ear2="Brutal Earring",
     body="Jhakri Robe +1",
	 hands="Helios Gloves",
	 ring1="Rufescent Ring",
     waist="Fotia Belt",
	 legs="Vanya Slops",
	 feet="Jharki Pigaches +1"}

	-- Exudation 50% MND 50% INT
sets.precast.WS['Exudation'] = {
     head="Jhakri Coronal +1",
	 neck="Sanctity Necklace",
	 ear1="Friomisi Earring",
	 ear2="Brutal Earring",
     body="Jhakri Robe +1",
	 hands="Jhakri Cuffs +1",
	 ring1="Rufescent Ring",
     waist="Latria Sash",
	 legs="Vanya Slops",
	 feet="Jhakri Pigaches +1"}
	 
	-- Flash Nova 50% STR 50% MND 
 sets.precast.WS['Flash Nova'] = {
     head="Jhakri Coronal +1",
	 neck="Mizukage-No-Kubikazari",
	 ear1="Friomisi Earring",
	 ear2="Brutal Earring",
     body="Jhakri Robe +1",
	 hands="Jhakri Cuffs +1",
	 ring1="Rufescent Ring",
	 ring2="Ifrit Ring",
     waist="Latria Sash",
	 legs="Jhakri Slops +1",
	 feet="Jharki Pigaches +1"}

	
	------------------------------------------------------------------------
	----------------------------- Midcast Sets -----------------------------
	------------------------------------------------------------------------
	
	-- Base fast recast for spells  --70
	sets.midcast.FastRecast = {
  		main="Solstice", --5
		sub="Culminus",
		neck="Baetyl Pendant", --4
		head="Vanya Hood", --10
		waist="Witful Belt", --3
		lear="Loquacious Earring",  -- 2
		body="Eirene's Manteel",  --10
		hands="Telchine Gloves",  --4
		back="Lifestream Cape",  --7
		legs="Geomancy Pants +1",  --11
		ring1="Prolix ring",  --2
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+2','"Fast Cast"+5','MND+2','"Mag.Atk.Bns."+10',}}, --10
		ring2="Rahab Ring"  --2
		} 
	
   sets.midcast.Geomancy = {
		main="Rubicundity",
		sub="Culminus",
		head="Azimuth Hood +1",
		neck="Incanter's Torque",
		body="Azimuth Coat +1",
		hands="Azimuth Gloves +1",
		lear="Mendicant's Earring",
		rear="Lempo Earring",
		back="Solemnity Cape",
		waist="Austerity Belt",
		legs="Bagua Pants +1",
		rring="Stikini Ring",
		legs="Azimuth Tights +1",
		feet="Azimuth Gaiters +1"
		}
	
	sets.midcast.Geomancy.Indi = {
		main="Solstice",
		sub="Culminus",
		head="Azimuth Hood +1",
		body="Azimuth Coat +1",
		neck="Incanter's Torque",
		lear="Mendicant's Earring",
		waist="Austerity Belt",
	    hands="Azimuth Gloves +1",
		back="Nantosuelta's Cape",
		legs="Bagua Pants +1",
		rring="Stikini Ring",
		feet="Azimuth Gaiters +1"
		}

	sets.midcast.Cure = {
		main="Divinity",  --15
		sub="Culminus",
		head="Vanya Hood", --10
		neck="Incanter's Torque", 
		ear1="Mendicant's Earring",
        body="Vanya Robe",
		hands="Telchine Gloves", --10
		ring1="Stikini Ring",
		ring2="Sirona's Ring",
        back="Solemnity Cape", --7
		waist="Gishdubar Sash", --10 self
		legs="Vanya Slops",
		feet="Vanya Clogs" --10
		}

	sets.midcast.Curaga = set_combine(sets.midcast.Cure, {

		})

	sets.midcast.Cursna = set_combine(sets.midcast.Cure, {
		waist="Gishdubar Sash",
		feet="Vanya Clogs"
		})

	sets.midcast['Enhancing Magic'] = {
		head="Telchine Cap",  --Duration +5
		neck="Incanter's Torque",
		body="Telchine Chasuble",
		waist="Latria Sash",
		feet="Telchine Pigaches", --Duration +7
		ring1="Vertigo Ring",
		ring2="Stikini Ring",
		back="Fi Follet Cape"
		}
		
	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {
	body="Telchine Chasuble",
	legs={ name="Telchine Braconi", augments={'Attack+5','"Fast Cast"+3','"Regen" potency+1',}},
	main="Bolelabunga"
		})
	
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {
		waist="Gishdubar Sash",
		back="Grapevine Cape"
		})
			
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		waist="Siegel Sash",legs="Haven Hose",neck="Nodens Gorget"})

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
		})

	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {
		})

	sets.midcast.Shellra = sets.midcast.Protectra

	sets.midcast.MndEnfeebles = {
		main="Divinity",
		sub="Culminus",
		head="Befouled Crown",
		neck="Incanter's Torque",
        body="Vanya Robe",
		lear="Barkarole Earring",
		rear="Static Earring",
		hands="Azimuth Gloves +1",
		ring1="Stikini Ring",
		ring2="Vertigo Ring",
        waist="Rumination Sash",
		back="Lifestream Cape",
		legs="Psycloth Lappas",
		feet="Bagua Sandals +1"
		} -- MND/Magic accuracy
	
	sets.midcast.IntEnfeebles = {
		main="Rubicundity",
		sub="Culminus",
		head="Befouled Crown",
		neck="Incanter's Torque",
		lear="Barkarole Earring",
        body="Vanya Robe",
		hands="Azimuth Gloves +1",
		ring1="Stikini Ring",
		ring2="Vertigo Ring",
        waist="Rumination Sash",
		back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+10%','CHR+8','Mag. Acc.+7','"Mag.Atk.Bns."+1',}},
		feet="Bagua Sandals +1"
		} -- INT/Magic accuracy

	sets.midcast['Dark Magic'] = {
		main="Rubicundity",
		sub="Culminus",
		head="Merlinic Hood",
		body="Psycloth Vest",
		hands="Jhakri Cuffs +1",
		neck="Incanter's Torque",
		ammo="Azimuth Gloves +1",
        legs="Azimuth Tights +1",
		back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic burst mdg.+9%','INT+14',}},
		legs="Azimuth Tights +1",
		ring1="Stikini Ring",
		ring2="Evanescence Ring",
		waist="Tengu-no-Obi",
		neck="Incanter's Torque"
		}
	
	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		main="Rubicundity",
		sub="Culminus",
		head="Bagua Galero +1",
		body="Psycloth Vest",
		hands="Helios Gloves",
		neck="Incanter's Torque",
		back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
		waist="Fucho-No-Obi",
		legs="Azimuth Tights +1",
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic burst mdg.+9%','INT+14',}},
		lear="Mendicant's Earring",
		ring1="Evanescence Ring",
		ring2="Stikini Ring",
		neck="Incanter's Torque"
		})
	
	sets.midcast.Aspir = sets.midcast.Drain

	sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
		})

	-- Elemental Magic sets
	
	sets.midcast['Elemental Magic'] = {
		main="Solstice",
		sub="Culminus",
		head="Merlinic Hood",
		neck="Mizukage-no-Kubikazari",
	    ear1="Barkarole Earring",
		ear2="Choleric Earring",
		body="Seidr Cotehardie",
		ring1="Stikini Ring",
		ring2="Resonance Ring",
		back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
		waist="Refoccilation Stone",
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic burst mdg.+9%','INT+14',}},
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+10%','CHR+8','Mag. Acc.+7','"Mag.Atk.Bns."+1',}},
		hands="Amalric Gages"}

	sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {

		})

	sets.midcast.GeoElem = set_combine(sets.midcast['Elemental Magic'], {
 
		})

	sets.midcast['Elemental Magic'].Seidr = set_combine(sets.midcast['Elemental Magic'], {
	body="Seidr Cotehardie"
		})

	sets.midcast.GeoElem.Seidr = set_combine(sets.midcast['Elemental Magic'].Seidr, {
	body="Seidr Cotehardie"
		})

	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
		head=empty,

		})

	------------------------------------------------------------------------------------------------
	------------------------------------------ Idle Sets -------------------------------------------
	------------------------------------------------------------------------------------------------

	sets.idle = {
		main="Bolelabunga",
		sub="Genmei Shield",
		head="Befouled Crown",
		body="Witching Robe",
		hands="Merlinic Dastanas",
		neck="Twilight Torque",
		lear="Hearty Earring",
		rear="Infused Earring",
		back={ name="Nantosuelta's Cape", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Pet: "Regen"+10',}},
		waist="Fucho-No-Obi",
		ring1="Paguroidea Ring",
		ring2="Defending Ring",
		legs="Assiduity Pants +1",
		feet="Geomancy Sandals +1"
		}
	
	sets.resting = set_combine(sets.idle, {

	})

	sets.idle.PDT = set_combine(sets.idle, {

		})

	sets.idle.MDT = set_combine(sets.idle, {

		})

	sets.idle.Weak = sets.idle.PDT

	-- .Pet sets are for when Luopan is present.
	sets.idle.Pet = { 
		-- dt/regen --
		main="Solstice", --pet dt 4
		sub="Genmei Shield",
		head="Azimuth Hood +1",  -- pet regen 3
		neck="Twilight Torque",
		lear="Hearty Earring",
		rear="Eabani Earring",
		body="Helios Jacket", -- pet regen 2
		lring="Thurandaut Ring", -- pet dt 3
		rring="Defending Ring",
		waist="Isa Belt", -- pet dt 3
		back={ name="Nantosuelta's Cape", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Pet: "Regen"+10',}}, -- pet regen 10
		legs={ name="Telchine Braconi", augments={'Accuracy+15 Attack+15','Pet: "Regen"+3','Pet: Damage taken -4%',}}, -- pet dt 4, regen 3
		feet="Bagua Sandals +1",  -- pet regen 3
		hands="Geomancy Mitaines +1" -- pet dt 11
		}
		--Dunna: pet dt 5
		
		-- Total: dt -30, regen 21



	sets.idle.Town = set_combine(sets.idle, {
	body="Councilor's Garb",
	feet="Geomancy Sandals"
		})
		
	-- Defense sets

	sets.defense.PDT = {
		main="Solstice",
		sub="Genmei Shield",
		head="Befouled Crown",
		body="Witching Robe",
		hands="Bagua Mitaines +1",
		neck="Twilight Torque",
		rear="Infused Earring",
		waist="Fucho-No-Obi",
		ring1="Paguroidea Ring",
		ring2="Defending Ring",
		legs="Assiduity Pants +1",
		feet="Geomancy Sandals +1"
		}

	sets.defense.MDT = {
		head="Befouled Crown",
		body="Witching Robe",
		back={ name="Nantosuelta's Cape", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Pet: "Regen"+10',}},
		hands="Bagua Mitaines +1",
		neck="Twilight Torque",
		rear="Infused Earring",
		waist="Fucho-No-Obi",
		ring1="Paguroidea Ring",
		ring2="Defending Ring",
		legs="Assiduity Pants +1",
		feet="Geomancy Sandals +1"
		}

	sets.Kiting = {
		feet="Geomancy Sandals +1"
		}


	
	--------------------------------------
	-- Engaged sets
	--------------------------------------

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group  --Haste
	sets.engaged = {		
		main="Divinity",
		sub="Genmei Shield",
		head="Jhakri Coronal +1", --3
        neck="Sanctity Necklace",
		ear1="Cessance Earring",
		ear2="Mache Earring",
        body="Jhakri Robe +1",  --1
		hands="Merlinic Dastanas",  --3
		ring1="Portus Annulet",
		ring2="Rajas Ring",
        waist="Windbuffet Belt +1",  
		back={ name="Nantosuelta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Haste+10',}},  --10
		legs="Jhakri Slops +1",  --2
		feet="Jhakri Pigaches +1"  --19 total
		}


	--------------------------------------
	-- Custom buff sets
	--------------------------------------

	sets.magic_burst = {
		main="Solstice",
		sub="Culminus",
		head="Merlinic Hood", --10
		neck="Mizukage-no-Kubikazari", --10
	    ear1="Barkarole Earring",
		ear2="Choleric Earring",
		hands="Amalric Gages", --5 II
        ring1="Mujin Band", --5 II
		ring2="Locus Ring", --5
		back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
		waist="Refoccilation Stone",
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+10%','CHR+8','Mag. Acc.+7','"Mag.Atk.Bns."+1',}}, --10
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic burst mdg.+9%','INT+14',}}, --9
		body="Jhakri Robe +1"}  
		--44 + 10 total
		
end



-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
		equip(sets.magic_burst)
	end
end

function job_aftercast(spell, action, spellMap, eventArgs)
	if not spell.interrupted then
		if spell.english:startswith('Indi') then
			if not classes.CustomIdleGroups:contains('Indi') then
				classes.CustomIdleGroups:append('Indi')
			end
           send_command('@timers d "'..indi_timer..'"')
            indi_timer = spell.english
            send_command('@timers c "'..indi_timer..'" '..indi_duration..' down spells/00136.png')
        elseif spell.english == 'Sleep' or spell.english == 'Sleepga' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 60 down spells/00220.png')
        elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 90 down spells/00220.png')
		elseif spell.skill == 'Elemental Magic' then
 --		   state.MagicBurst:reset()
		end
	elseif not player.indi then
		classes.CustomIdleGroups:clear()
	end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if player.indi and not classes.CustomIdleGroups:contains('Indi')then
		classes.CustomIdleGroups:append('Indi')
		handle_equipping_gear(player.status)
	elseif classes.CustomIdleGroups:contains('Indi') and not player.indi then
		classes.CustomIdleGroups:clear()
		handle_equipping_gear(player.status)
	end
end

function job_state_change(stateField, newValue, oldValue)
	if stateField == 'Offense Mode' then
		if newValue == 'None' then
			enable('main','sub','range')
		else
			disable('main','sub','range')
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_get_spell_map(spell, default_spell_map)
	if spell.action_type == 'Magic' then
		if spell.skill == 'Enfeebling Magic' then
			if spell.type == 'WhiteMagic' then
				return 'MndEnfeebles'
			else
				return 'IntEnfeebles'
			end
		elseif spell.skill == 'Geomancy' then
			if spell.english:startswith('Indi') then
				return 'Indi'
			end
		elseif spell.skill == 'Elemental Magic' then
			if spellMap == 'GeoElem' then
				return 'GeoElem'
			end
		end
	end
end

function customize_idle_set(idleSet)
	if player.mpp < 51 then
		idleSet = set_combine(idleSet, sets.latent_refresh)
	end
	return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
	classes.CustomIdleGroups:clear()
	if player.indi then
		classes.CustomIdleGroups:append('Indi')
	end
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
	display_current_caster_state()
	eventArgs.handled = true
end

function job_self_command(cmdParams, eventArgs)
	if cmdParams[1]:lower() == 'nuke' then
		handle_nuking(cmdParams)
		eventArgs.handled = true
	end
end

---- .::Pretarget Functions::. ---->

function pretarget(spell,action)
    -- Auto-Echo drop :D --
    if spell.action_type == 'Magic' and buffactive['Silence'] then
        cancel_spell()
        send_command('input /item "Echo Drops" <me>')
    -- Auto Blaze of Glory for lazies :p -- 
    elseif string.find(spell.english, 'Geo-') then
        if not (buffactive['Bolster'] or  buffactive['Amnesia'] or  buffactive['Blaze of Glory'] or pet.isvalid) then
            cancel_spell()
            send_command('input /ja "Blaze of Glory" <me>;wait 2;input /ma "'..spell.english..'" '..spell.target.name)
        end
    end
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 9)
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
