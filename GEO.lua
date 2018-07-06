-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
	mote_include_version = 2
	AutoRemedy = 'ON' -- Set to ON if you want to auto use remedies if silenced or Paralyzed, otherwise set to OFF --
	-- Load and initialize the include file.
	include('Mote-Include.lua')
	send_command('wait 2;input /lockstyleset 04')
	send_command('lua l mobcompass')
	send_command('lua l pettp')
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
	state.CastingMode:options('Normal', 'Seidr', 'Resistant', 'MagicBurst')
	state.IdleMode:options('Normal', 'PDT', 'MDT', 'Refresh')


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

function file_unload(file_name)
 
  send_command('lua u mobcompass')
  send_command('lua u pettp')
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
		body="Geomancy Tunic +3",
		back="Nantosuelta's Cape",
	}
	
	sets.precast.JA['Curative Recantation'] = {hands="Bagua Mitaines +1"}
	
	sets.precast.JA['Primeval Zeal'] = {head="Bagua Galero +1"}
	
	sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals +1"}
  
	-- Fast cast sets for spells
	sets.precast.FC = {
	--	/RDM --15
  		main="Solstice", --5
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
		ring2="Kishar Ring"  --5
		} -- 73 without /RDM

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
		waist="Siegel Sash"
				})		
		
	sets.precast.FC.Curaga = sets.precast.FC.Cure

	sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], {
		})
	 
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Jhakri Coronal +2",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +1",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2"}

  -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
  -- Realmrazer = MND
	sets.precast.WS['Realmrazer'] = {
		head="Jhakri Coronal +2",
		neck="Fotia Gorget",
		ear1="Friomisi Earring",
		ear2="Mache Earring",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +1",
		ring1="Rufescent Ring",
		waist="Fotia Belt",
		legs="Vanya Slops",
		feet="Jhakri Pigaches +2"}

	-- Exudation 50% MND 50% INT
	sets.precast.WS['Exudation'] = {
		head="Jhakri Coronal +2",
		neck="Sanctity Necklace",
		ear1="Cessance Earring",
		ear2="Mache Earring",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +1",
		ring1="Rufescent Ring",
		waist="Latria Sash",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2"}
	 
	-- Flash Nova 50% STR 50% MND 
 sets.precast.WS['Flash Nova'] = {
		head="Jhakri Coronal +2",
		neck="Mizukage-No-Kubikazari",
		ear1="Friomisi Earring",
		ear2="Mache Earring",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +1",
		ring1="Rufescent Ring",
		ring2="Karieyh Ring +1",
		waist="Latria Sash",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2"}

	 -- 30% STR 30% INT
	sets.precast.WS['Cataclysm'] = {
		head="Jhakri Coronal +2",
		neck="Mizukage-No-Kubikazari",
		ear1="Barkarole Earring",
		ear2="Mache Earring",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +1",
		ring1="Rufescent Ring",
		ring2="Ifrit Ring",
		waist="Latria Sash",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2"}
	
	------------------------------------------------------------------------
	----------------------------- Midcast Sets -----------------------------
	------------------------------------------------------------------------
	
	-- Base fast recast for spells  --73
	sets.midcast.FastRecast = {
  		main="Solstice", --5
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
		ring2="Kishar Ring",  --5
		} 
	
   sets.midcast.Geomancy = {
		main="Idris",
		head="Azimuth Hood +1",
		neck="Incanter's Torque",
		body="Azimuth Coat +1",
		hands="Azimuth Gloves +1",
		lear="Mendicant's Earring",
		rear="Lempo Earring",
		back="Solemnity Cape",
		waist="Austerity Belt",
		legs="Azimuth Tights +1",
		lring="Kishar Ring",
		rring="Stikini Ring +1",
		legs="Azimuth Tights +1",
		feet="Azimuth Gaiters +1"
		}
	
	sets.midcast.Geomancy.Indi = {
		main="Idris",
		head="Azimuth Hood +1",
		body="Azimuth Coat +1",
		neck="Incanter's Torque",
		lear="Mendicant's Earring",
		waist="Austerity Belt",
	    hands="Azimuth Gloves +1",
		back="Nantosuelta's Cape",
		legs="Bagua Pants +1",
		lring="Kishar Ring",
		rring="Stikini Ring +1",
		feet="Azimuth Gaiters +1"
		}

	sets.midcast.Cure = {
		main="Nibiru Cudgel",  --10
		head="Vanya Hood", --10
		neck="Incanter's Torque", 
		ear1="Mendicant's Earring", --5, Conserve MP +2
		ear2="Domesticator's Earring", --Enmity -5
        body="Psycloth Vest", --Enmity -7
		hands="Telchine Gloves", --10
		ring1="Stikini Ring +1",
		ring2="Sirona's Ring",
        back="Solemnity Cape", --7
		waist="Gishdubar Sash", --10 self
		legs="Vanya Slops",
		feet="Vanya Clogs" --10
		}
		
		--52 Potency, 10 self

	sets.midcast.Curaga = set_combine(sets.midcast.Cure, {

		})

	sets.midcast.Cursna = {
		waist="Gishdubar Sash", --Cursna potency +10% (self)
		feet="Vanya Clogs", --Cursna +5
		lring="Ephedra Ring", --Cursna potency +10%
  		main="Solstice", --5
		sub="Culminus",
		neck="Baetyl Pendant", --4
		head="Vanya Hood", --10
		lear="Loquacious Earring",  -- 2
		body="Eirene's Manteel",  --10
		hands="Telchine Gloves",  --4
		back="Lifestream Cape",  --7
		legs="Geomancy Pants +1",  --11
		ring2="Kishar Ring"  --5
		}
		--58% FC

		--GEO has no enhancing magic skill
	sets.midcast['Enhancing Magic'] = {
		head="Telchine Cap",  --Duration +5
		neck="Incanter's Torque",
		body={ name="Telchine Chas.", augments={'"Fast Cast"+3','Enh. Mag. eff. dur. +8',}}, --Duration +8, skill +12
		hands="Telchine Gloves", --Duration +9
		waist="Latria Sash",
		feet="Telchine Pigaches", --Duration +7
		ring1="Vertigo Ring",
		ring2="Stikini Ring +1",
		legs="Vanya Slops",
		lear="Static Earring"
		}
		
	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {
		legs={ name="Telchine Braconi", augments={'Attack+5','"Fast Cast"+3','"Regen" potency+1',}},
		main="Bolelabunga", --Regen potency +10%
		})
		--Telchine Chasuble = Regen duration +12, enhancing duration +8
	
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {
		head="Amalric Coif +1",
		waist="Gishdubar Sash",
		back="Grapevine Cape"
		})
			
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		waist="Siegel Sash", --Stoneskin +20
		legs="Haven Hose", --Stoneskin +20
		neck="Nodens Gorget" --Stoneskin +30
		}) 

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
		})

	sets.midcast.Protectra = {
		}

	sets.midcast.Shellra = sets.midcast.Protectra

	sets.midcast.MndEnfeebles = {
		main="Idris", --Macc 40
		head="Befouled Crown", --Enfeebling 16, Macc 20
		neck="Incanter's Torque", --Enfeebling 10
		body="Geomancy Tunic +3", --Macc 50 + set bonus
		lear="Barkarole Earring", --Macc 8
		rear="Gwati Earring", --Macc 8
		hands="Azimuth Gloves +1", --Enfeebling 18, Macc 27
		ring1="Stikini Ring +1", --Enfeebling 5, Macc 8
		ring2="Kishar Ring", --Macc 5, Duration 10%
		waist="Rumination Sash", --Enfeebling 7, Macc 3
		back="Lifestream Cape", --Enfeebling 10
		legs="Psycloth Lappas", --Enfeebling 18, Macc 35
		feet="Geomancy Sandals +3", --Macc 46
		sub="Culmnus"
		} -- MND/Magic accuracy
		
		--Dunna: Macc 10
		--Total: 84 Enfeebling, 220 Macc
	
	sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
		back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+10%','CHR+8','Mag. Acc.+7','"Mag.Atk.Bns."+1',}}
		}) -- INT/Magic accuracy

	sets.midcast['Dark Magic'] = {
		main="Rubicundity",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Magic burst dmg.+10%','INT+4','"Mag.Atk.Bns."+10',}},
		body="Geomancy Tunic +3",
		hands="Jhakri Cuffs +1",
		neck="Erra Pendant",
		ammo="Azimuth Gloves +1",
		legs="Azimuth Tights +1",
		back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
		feet="Geomancy Sandals +3",
		lear="Barkarole Earring",
		rear="Gwati Earring",
		ring1="Stikini Ring +1",
		ring2="Evanescence Ring",
		waist="Tengu-no-Obi",
		sub="Culminus"
		}
	
	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		ring1="Archon Ring",
		head="Pixie Hairpin +1",
		waist="Fucho-No-Obi",
		})
	
	sets.midcast.Aspir = sets.midcast.Drain

	sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
		})

	-- Elemental Magic sets
	
	sets.midcast['Elemental Magic'] = {
		main="Idris",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','INT+5','"Mag.Atk.Bns."+14',}},
		neck="Mizukage-no-Kubikazari",
	    ear1="Barkarole Earring",
		ear2="Choleric Earring",
		body="Count's Garb",
		ring1="Stikini Ring +1",
		ring2="Resonance Ring",
		back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
		waist="Tengu-No-Obi",
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic burst dmg.+9%','INT+14',}},
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+10%','CHR+8','Mag. Acc.+7','"Mag.Atk.Bns."+1',}},
		hands="Amalric Gages +1",
		sub="Culminus"}

	sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
		body="Jhakri Robe +2"
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
		
	sets.midcast['Elemental Magic'].MagicBurst = {
		main="Idris",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Magic burst dmg.+10%','INT+4','"Mag.Atk.Bns."+10',}}, --10
		neck="Mizukage-no-Kubikazari", --10
	    ear1="Barkarole Earring",
		ear2="Choleric Earring",
		hands="Amalric Gages +1", --6 II
        ring1="Mujin Band", --5 II
		ring2="Stikini Ring +1", 
		back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
		waist="Refoccilation Stone",
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+10%','CHR+8','Mag. Acc.+7','"Mag.Atk.Bns."+1',}}, --10
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic burst dmg.+9%','INT+14',}}, --9
		body="Ea Houppelande", --8, 8 II
		sub="Culminus"}   
		--47 + 19 total

	------------------------------------------------------------------------------------------------
	------------------------------------------ Idle Sets -------------------------------------------
	------------------------------------------------------------------------------------------------

	sets.idle = {
		main="Bolelabunga",
		head="Befouled Crown",
		body="Geomancy Tunic +3",
		hands={ name="Merlinic Dastanas", augments={'DEX+4','AGI+8','"Refresh"+2',}},
		neck="Loricate Torque",
		lear="Hearty Earring",
		rear="Eabani Earring",
		back={ name="Nantosuelta's Cape", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: "Regen"+5',}},
		waist="Slipor Sash",
		ring1="Stikini Ring +1",
		ring2="Defending Ring",
		legs="Assiduity Pants +1",
		feet="Geomancy Sandals +3",
		sub="Genmei Shield"
		}
		
	sets.idle.Refresh = set_combine(sets.idle, {
		feet={ name="Merlinic Crackows", augments={'INT+8','"Fast Cast"+2','"Refresh"+2','Mag. Acc.+2 "Mag.Atk.Bns."+2',}}
	})
	
	sets.resting = set_combine(sets.idle, {

	})

	sets.idle.PDT = set_combine(sets.idle, {

		})

	sets.idle.MDT = set_combine(sets.idle, {

		})

	sets.idle.Weak = sets.idle.PDT

	-- .Pet sets are for when Luopan is present. Max -dt is 87.5%. 
	sets.idle.Pet = { 
		-- dt/regen --
		main="Idris", --pet dt 25
		head="Azimuth Hood +1",  -- pet regen 3
		neck="Loricate Torque",
		lear="Hearty Earring",
		rear="Eabani Earring",
		body={ name="Telchine Chas.", augments={'Mag. Evasion+16','Pet: "Regen"+3','Pet: Damage taken -3%',}}, -- pet dt 3, regen 3
		hands={ name="Merlinic Dastanas", augments={'DEX+4','AGI+8','"Refresh"+2',}},
		lring="Vengeful Ring", 
		rring="Defending Ring",
		waist="Slipor Sash", 
		back={ name="Nantosuelta's Cape", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: "Regen"+5',}}, -- pet regen 15
		legs={ name="Telchine Braconi", augments={'Mag. Evasion+18','Pet: "Regen"+3','Pet: Damage taken -4%',}}, -- pet dt 4, regen 3
		feet="Bagua Sandals +1",  -- pet regen 3
		sub="Genmei Shield"
		}
		--Dunna: pet dt 5
		--Pet innate dt -50, 37.5% needed to cap
		-- Total: dt -37, regen 27

		

	sets.idle.Town = set_combine(sets.idle, {
		main="Idris",
		body="Geomancy Tunic +3",
		feet="Geomancy Sandals +3",
		sub="Culminus"
		})
		
	-- Defense sets

	sets.defense.PDT = {
		main="Idris",
		sub="Genmei Shield",
		head="Befouled Crown",
		body="Geomancy Tunic +3",
		hands="Bagua Mitaines +1",
		neck="Loricate Torque",
		rear="Infused Earring",
		waist="Fucho-No-Obi",
		ring1="Vengeful Ring",
		ring2="Defending Ring",
		legs="Assiduity Pants +1",
		feet="Geomancy Sandals +3"
		}

	sets.defense.MDT = {
		main="Idris",
		head="Befouled Crown",
		body="Geomancy Tunic +3",
		back={ name="Nantosuelta's Cape", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: "Regen"+5',}},
		hands="Bagua Mitaines +1",
		neck="Loricate Torque",
		rear="Infused Earring",
		waist="Fucho-No-Obi",
		ring1="Shukuyu Ring",
		ring2="Defending Ring",
		legs="Assiduity Pants +1",
		feet="Geomancy Sandals +3",
		sub="Genmei Shield"
		}

	sets.Kiting = {
		feet="Geomancy Sandals +3"
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
		main="Idris",
		head="Jhakri Coronal +2", --3
		neck="Sanctity Necklace",
		ear1="Cessance Earring",
		ear2="Mache Earring",
		body="Jhakri Robe +2",  --1
		hands="Jhakri Cuffs +1",  --0
		ring1="Etana Ring",
		ring2="Petrov Ring",
		waist="Windbuffet Belt +1",  
		back={ name="Nantosuelta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Haste+10',}},  --10
		feet={ name="Merlinic Crackows", augments={'Attack+21','Pet: VIT+14','Quadruple Attack +3','Accuracy+19 Attack+19','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},  --3
		legs="Jhakri Slops +2",  --2
		sub="Genmei Shield"
		}
		--19 Total

	--------------------------------------
	-- Custom buff sets
	--------------------------------------

	sets.magic_burst = {
		main="Idris",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Magic burst dmg.+10%','INT+4','"Mag.Atk.Bns."+10',}}, --10
		neck="Mizukage-no-Kubikazari", --10
	    ear1="Barkarole Earring",
		ear2="Choleric Earring",
		hands="Amalric Gages +1", --5 II
        ring1="Mujin Band", --5 II
		ring2="Resonance Ring", 
		back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
		waist="Refoccilation Stone",
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+10%','CHR+8','Mag. Acc.+7','"Mag.Atk.Bns."+1',}}, --10
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic burst dmg.+9%','INT+14',}}, --9
		body="Ea Houppelande", --8, 8 II
		sub="Culminus"}   
		--47 + 18 total

	sets.buff.Doom = {
		ring1="Saida Ring", 
		ring2="Defending Ring", 
		waist="Gishdubar Sash"}
		
end



-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

    -- Auto Remedy --

function pretarget(spell,action) 
 if buffactive['Silence'] or buffactive['Paralysis'] then
            if spell.action_type == 'Magic' or spell.type == 'JobAbility' then  
                cancel_spell()
                send_command('input /item "Remedy" <me>')
            end            
        end
    end
	

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

function buff_change(name,gain)

	if name == "silence" and gain =="True" then
		send_command('@input /item "Remedy" <me>')
	end

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    if player.sub_job == 'SCH' then
        set_macro_page(1, 9)
    elseif player.sub_job == 'BLM' then
        set_macro_page(1, 9)	
    elseif player.sub_job == 'WHM' then
        set_macro_page(1, 9)
    elseif player.sub_job == 'RDM' then
        set_macro_page(1, 9)
    elseif player.sub_job == 'NIN' then
        set_macro_page(2, 9)
    elseif player.sub_job == 'WAR' then
        set_macro_page(2, 9)
	end	
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
	'Firaja', 'Blizzaja', 'Aeroja', 'Stoneja', 'Thundaja', 'Waterja', 'Stonera', 'Stonera II', 'Stonera III',
	'Thundara', 'Thundara II', 'Thundara III', 'Watera', 'Watera II', 'Watera III', 'Fira', 'Fira II', 'Fira III',
	'Blizzara', 'Blizzara II', 'Blizzara III', 'Aera', 'Aera II', 'Aera III'
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
				elseif spell.english == 'Firaga' then
					newSpell = 'Firaga III'
				elseif spell.english == 'Firaga III' then
					newSpell = 'Firaga II'					
				elseif spell.english == 'Firaga II' then
					newSpell = 'Firaga'
				elseif spell.english == 'Fira' then
					newSpell = 'Fira III'
				elseif spell.english == 'Fira III' then
					newSpell = 'Fira II'					
				elseif spell.english == 'Fira II' then
					newSpell = 'Fira'					
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
				elseif spell.english == 'Blizzaga' then
					newSpell = 'Blizzaga III'
				elseif spell.english == 'Blizzaga III' then
					newSpell = 'Blizzaga II'
				elseif spell.english == 'Blizzaga II' then
					newSpell = 'Blizzaga'	
				elseif spell.english == 'Blizzara' then
					newSpell = 'Blizzara III'
				elseif spell.english == 'Blizzara III' then
					newSpell = 'Blizzara II'
				elseif spell.english == 'Blizzara II' then
					newSpell = 'Blizzara'						
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
				elseif spell.english == 'Aeroga' then
					newSpell = 'Aeroga III'
				elseif spell.english == 'Aeroga III' then
					newSpell = 'Aeroga II'	
				elseif spell.english == 'Aeroga II' then
					newSpell = 'Aeroga'	
				elseif spell.english == 'Aera' then
					newSpell = 'Aera III'
				elseif spell.english == 'Aera III' then
					newSpell = 'Aera II'	
				elseif spell.english == 'Aera II' then
					newSpell = 'Aera'	
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
				elseif spell.english == 'Stonega' then
					newSpell = 'Stonega III'
				elseif spell.english == 'Stonega III' then
					newSpell = 'Stonega II'
				elseif spell.english == 'Stonega II' then
					newSpell = 'Stonega'	
				elseif spell.english == 'Stonera' then
					newSpell = 'Stonera III'
				elseif spell.english == 'Stonera III' then
					newSpell = 'Stonera II'
				elseif spell.english == 'Stonera II' then
					newSpell = 'Stonera'	
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
				elseif spell.english == 'Thundara' then
					newSpell = 'Thundara III'
				elseif spell.english == 'Thundara III' then
					newSpell = 'Thundara II'
				elseif spell.english == 'Thundara II' then
					newSpell = 'Thundara'			
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
				elseif spell.english == 'Watera' then
					newSpell = 'Watera III'
				elseif spell.english == 'Watera III' then
					newSpell = 'Waterg II'	
				elseif spell.english == 'Watera II' then
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
