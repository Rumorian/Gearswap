-------------------------------------------------------------------------------------------------------------------
-- (Original: Motenten / Modified: Arislan / Modified: Rumorian (Spell Degradation, Sleep Timers))
-------------------------------------------------------------------------------------------------------------------

--[[	Custom Features:
		
		Capacity Pts. Mode	Capacity Points Mode Toggle [WinKey-C]
		Auto. Lockstyle		Automatically locks desired equipset on file load
--]]

-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
	mote_include_version = 2
	AutoRemedy = 'ON' -- Set to ON if you want to auto use remedies if silenced or Paralyzed, otherwise set to OFF --
	-- Load and initialize the include file.
	include('Mote-Include.lua')
	send_command('lua l distanceplus')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()

	state.CP = M(false, "Capacity Points Mode")
	state.Buff.Saboteur = buffactive.saboteur or false

end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal', 'Acc')
	state.CastingMode:options('Normal', 'Seidr', 'Resistant')
	state.IdleMode:options('Normal', 'DT')

	state.WeaponLock = M(false, 'Weapon Lock')	
	state.MagicBurst = M(false, 'Magic Burst')
	
	select_default_macro_book()
	set_lockstyle()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()

end
function file_unload(file_name)
 
  send_command('lua u distanceplus')
end
-- Define sets and vars used by this job file.
function init_gear_sets()
	
	------------------------------------------------------------------------------------------------
	---------------------------------------- Precast Sets ------------------------------------------
	------------------------------------------------------------------------------------------------
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Chainspell'] = {}
	
	
    -- Fast cast sets for spells
    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
    -- RDM job trait = 30%
    sets.precast.FC = {
		head="Carmine Mask +1",  -- 14%
		neck="Baetyl Pendant", -- 4%
		body="Shango Robe",  -- 8%
		hands="Leyline Gloves",  -- 7%
		waist="Witful Belt",  -- 3%
		legs="Psycloth Lappas",  -- 7%
		feet="Merlinic Crackows",  -- 5%
		lring="Prolix Ring"  -- 2%
		}
		-- Total: 50%, Colada = 4%

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {legs="Siegel Sash"})

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		ear1="Mendi. Earring", --5
		})

	sets.precast.FC.Curaga = sets.precast.FC.Cure

	sets.precast.FC['Healing Magic'] = sets.precast.FC.Cure

	sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {})

	sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], {
--		head=empty,
--		body="Twilight Cloak"
		})

	sets.precast.Storm = set_combine(sets.precast.FC, {}) -- stop quick cast

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
		})


	------------------------------------------------------------------------------------------------
	------------------------------------- Weapon Skill Sets ----------------------------------------
	------------------------------------------------------------------------------------------------

	sets.precast.WS = {
		ammo="Amar Cluster",
		head="Jhakri Coronal +2",
		neck="Lissome Necklace",
		lear="Steelflash Earring",
		rear="Bladeborn Earring",
		body="Jhakri Robe +2",
		hands="Atrophy Gloves +3",
		lring="Shukuyu Ring",
		rring="Karieyh Ring +1",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},
		waist="Dynamic Belt +1",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2"
	}
	-- STR set

	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
		ammo="Yetshila",
		head="Jhakri Coronal +2",
		neck="Fotia Gorget",
		lear="Sherida Earring",
		rear="Mache Earring",
		body="Jhakri Robe +2",
		hands="Atrophy Gloves +3",
		rring="Ilabrat Ring",
		lring="Begrudging Ring",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},
		waist="Fotia Belt",
		feet="Jhakri Pigaches +2",
		legs="Carmine Cuisses +1"})

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		head="Vitiation Chapeau +2",
		neck="Lacono Necklace +1",
		lear="Sherida Earring",
		rear="Ishvara Earring"
		})
	
	--Requiescat: Modifier MND, use elemental gorgets (fotia, shadow, soil)
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {

		})
	--Sanguine Blade: Modifier 50% MND, 30% STR
	sets.precast.WS['Sanguine Blade'] = {

		}

	------------------------------------------------------------------------------------------------
	---------------------------------------- Midcast Sets ------------------------------------------
	------------------------------------------------------------------------------------------------
	

	
	sets.midcast.FastRecast = sets.precast.FC

	sets.midcast.SpellInterrupt = {
		ammo="Impatiens", --10
		body="Psycloth Vest", --15
		hands="Amalric Gages +1", --10
		legs="Carmine Cuisses +1", --20
		ring1="Evanescence Ring", --5
		waist="Rumination Sash", --10
		neck="Baetyl Pendant", --FC
		lear="Loquacious Earring",
		feet={ name="Merlinic Crackows", augments={'INT+8','"Fast Cast"+2','"Refresh"+2','Mag. Acc.+2 "Mag.Atk.Bns."+2',}}, --FC
		ring2="Kishar Ring" --FC
		}
		--Total 70

	sets.midcast.Cure = {
		head="Vanya Hood", --10
		body="Vanya Robe", 
		hands="Telchine Gloves", --10
		legs="Atrophy Tights +1", --10, healing magic 13
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}}, --10
		neck="Incanter's Torque",
		waist="Rumination Sash", --Spell interruption -10%
		rear="Mendi. Earring", --5
		lring="Stikini Ring +1",
		rring="Sirona's Ring",
		back="Solemnity Cape"} --7
		--Total 52 

--	sets.midcast.CureWeather = set_combine(sets.midcast.Cure, {
--		})

	sets.midcast.CureSelf = set_combine(sets.midcast.Cure, {
		waist="Gishdubar Sash", -- 10% self
		neck="Phalaina Locket" --4% self
		})

	sets.midcast.Curaga = sets.midcast.Cure

	sets.midcast.StatusRemoval = {
		head="Carmine Mask +1",  -- 12%
		neck="Baetyl Pendant", -- 4%
		body="Shango Robe",  -- 8%
		hands="Leyline Gloves",  -- 7%
		waist="Witful Belt",  -- 3%
		legs="Psycloth Lappas",  -- 7%
		feet="Merlinic Crackows",  -- 5%
		lring="Prolix Ring"  -- 2%
		}
		-- Total FC: 48%

		
	sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {
		feet="Vanya Clogs", --Cursna +5
		waist="Gishdubar Sash", --Cursna +10 self only
		lring="Ephedra Ring", --Cursna +10
		rring="Saida Ring" --Cursna +15 self only
		})
		-- Total FC: 40%

	sets.midcast['Enhancing Magic'] = {
		main="Oranyan",
		head="Telchine Cap",
		neck="Incanter's Torque",
		lear="Loquacious Earring",
		body="Telchine Chasuble",
		hands="Atrophy Gloves +3",  
		lring="Vertigo Ring",
		rring="Stikini Ring +1",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
		waist="Latria Sash",
		legs="Carmine Cuisses +1",
		feet="Lethargy houseaux +1",
		sub="Enki Strap"
	}
	
	sets.midcast.EnhancingDuration = {
		main="Oranyan",
		head="Telchine Cap", 
		neck="Duelist's Torque +1",
		lear="Loquacious Earring",
		body={ name="Telchine Chas.", augments={'"Elemental Siphon"+25','Enh. Mag. eff. dur. +8',}},
		hands="Atrophy Gloves +3",  
		lring="Vertigo Ring",
		rring="Rufescent Ring",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
		waist="Latria Sash",
		legs={ name="Telchine Braconi", augments={'Attack+5','"Elemental Siphon"+35','Enh. Mag. eff. dur. +10',}},
		feet="Lethargy houseaux +1", -- +30%
		sub="Enki Strap"
	}

	sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
	
		})


	sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
		head="Amalric Coif +1", --Refresh +2
		waist="Gishdubar Sash", --Duration +20
		body="Atrophy Tabard +3", --Refresh +2
		back="Grapevine Cape", --Duration +30
		legs="Lethargy fuseau +1" --Refresh +2
		})  

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		waist="Siegel Sash",
		neck="Nodens Gorget",
		legs="Haven Hose"})

--	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
--		})

	sets.midcast.Storm = sets.midcast.EnhancingDuration

	sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {
		})

	sets.midcast.Protectra = sets.midcast.Protect
	sets.midcast.Shell = sets.midcast.Protect
	sets.midcast.Shellra = sets.midcast.Shell

 	-- Custom spell classes
	sets.midcast.MndEnfeebles = {
		main="Grioavolr", --Macc +44, Skill +15
		ammo="Pemphredo Tathlum",  --Macc +8
		head="Vitiation Chapeau +2",  --Skill +24, Macc +27
		neck="Duelist's Torque +1", --Macc +25
		lear="Gwati Earring",  --Macc +8
		rear="Lempo Earring",  --Macc +5
		body="Atrophy Tabard +3",  --Skill +21, Macc +55
		hands="Lethargy Gantherots +1",  --Macc +24, Skill +19
		lring="Kishar Ring",  --Macc +5, Duration +10%
		rring="Stikini Ring +1",  --Macc +11, Skill +8
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}}, --Effect +10, Macc +30
		waist="Rumination Sash",  --Macc +3, Skill +7
		legs="Psycloth Lappas",  --Macc +35, Skill +18
		feet="Medium's Sabots",  --Macc +25, Skill +15
		sub="Mephitis Grip",  --Macc +5, Skill +5
	}
	--Skill 608, Macc +310
	
   sets.midcast.MndEnfeeblesAcc = set_combine(sets.midcast.MndEnfeebles, {
	
	})
	
	sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
	
		})
		
		
    sets.midcast.IntEnfeeblesAcc = set_combine(sets.midcast.IntEnfeebles, {

	})


	sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']


	sets.midcast['Dia III'] = set_combine(sets.midcast.MndEnfeebles, {})

	sets.midcast['Slow II'] = set_combine(sets.midcast.MndEnfeebles, {})

	sets.midcast['Dark Magic'] = {
		main="Rubicundity",
		ammo="Pemphredo Tathlum",
		head="Carmine Mask +1",
		neck="Erra Pendant",
		lear="Gwati Earring",
		rear="Lempo Earring",
		body="Psycloth Vest",
		hands="Leyline Gloves",
		lring="Evanescence Ring",
		rring="Stikini Ring +1",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
		waist="Tengu-No-Obi",
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+10%','CHR+8','Mag. Acc.+7','"Mag.Atk.Bns."+1',}},
		feet="Jhakri Pigaches +2",
		sub="Culminus"
	}

	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		head="Pixie Hairpin +1",
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic burst dmg.+9%','INT+14',}},
		waist="Fucho-No-Obi",
		rring="Archon Ring"
		})
	
	sets.midcast.Aspir = sets.midcast.Drain

	sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
		})

	sets.midcast['Elemental Magic'] = {
		main="Grioavolr",
		ammo="Pemphredo Tathlum",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','INT+5','"Mag.Atk.Bns."+14',}},
		neck="Mizukage-no-Kubikazari",
		lear="Friomisi Earring",
		rear="Choleric Earring",
		body="Jhakri Robe +2",
		hands="Amalric Gages +1",
		lring="Stikini Ring +1",
		rring="Resonance Ring",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic burst dmg.+9%','INT+14',}},
		legs="Jhakri Slops +2",
		waist="Tengu-No-Obi",
		sub="Enki Strap"}

	sets.midcast['Elemental Magic'].Seidr = set_combine(sets.midcast['Elemental Magic'], {
		body="Seidr Cotehardie"
		})

	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'], {
		body="Jhakri Robe +2"

		})
		
	sets.midcast.IntEnfeebles.Resistant = sets.midcast.MndEnfeebles.Resistant
		
	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
		})
	
	sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

	-- Initializes trusts at iLvl 119
	sets.midcast.Trust = sets.precast.FC
	
	sets.midcast.Helix = {
		main="Grioavolr",
		ammo="Pemphredo Tathlum",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Magic burst dmg.+10%','INT+4','"Mag.Atk.Bns."+10',}},
		body="Witching Robe",
		hands="Amalric Gages +1",
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+10%','CHR+8','Mag. Acc.+7','"Mag.Atk.Bns."+1',}},
		feet="Jhakri Pigaches +2",
		neck="Mizukage-No-Kubikazari",
		waist="Tengu-no-Obi",
		left_ear="Gwati Earring",
		right_ear="Choleric Earring",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
		left_ring="Mujin Band",
		right_ring="Vertigo Ring",
		sub="Enki Strap"}
	-- Helix has low dINT modifier and benefits highly from magic damage
		
	-- Job-specific buff sets
	sets.buff.ComposureOther = {
		head="Lethargy Chappel +1",
		neck="Incanter's Torque",
		lear="Loquacious Earring",
		body="Lethargy Sayon +1",
		hands="Atrophy Gloves +3",
		lring="Vertigo Ring",
		rring="Rufescent Ring",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
		waist="Latria Sash",
		legs="Lethargy Fuseau +1",
		feet="Lethargy Houseaux +1"
		}
		
	sets.buff.Saboteur = {hands="Lethargy Gantherots +1"}
	
	
	sets.magic_burst = {
		main="Grioavolr",
		ammo="Pemphredo Tathlum",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Magic burst dmg.+10%','INT+4','"Mag.Atk.Bns."+10',}}, --10
		ear1="Barkarole Earring",
		ear2="Choleric Earring",
		body="Ea Houppelande", --8, 8 II
		hands="Amalric Gages +1", --5 II
        ring1="Mujin Band", --5 II
		ring2="Resonance Ring", 
		waist="Tengu-No-Obi",
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+10%','CHR+8','Mag. Acc.+7','"Mag.Atk.Bns."+1',}}, --10
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic burst dmg.+9%','INT+14',}},  --9
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
		neck="Mizukage-no-Kubikazari",
		sub="Enki Strap"} --10
	-- 47 +18

	
	------------------------------------------------------------------------------------------------
	----------------------------------------- Idle Sets --------------------------------------------
	------------------------------------------------------------------------------------------------
	
	sets.idle = {
		main="Grioavolr",
		sub="Enki Strap",
		ammo="Homiliary",
		head="Vitiation Chapeau +2",
		neck="Loricate Torque",
		lear="Eabani Earring",
		rear="Hearty Earring",
		body="Atrophy Tabard +3", -- 1 less refresh but higher meva/mdb than Jhakri Robe +2
		hands={ name="Merlinic Dastanas", augments={'DEX+4','AGI+8','"Refresh"+2',}},
		lring="Stikini Ring +1",
		rring="Defending Ring",
		waist="Slipor Sash",
		back="Solemnity Cape",
		feet={ name="Merlinic Crackows", augments={'INT+8','"Fast Cast"+2','"Refresh"+2','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
		legs="Carmine Cuisses +1"
	}
	
	sets.idle.DT = set_combine(sets.idle, {
		ammo="Staunch Tathlum"
		})

	sets.idle.Town = set_combine(sets.idle, {
		main="Grioavolr",
		sub="Enki Strap",
		neck="Duelist's Torque +1"
		})

	sets.idle.Weak = sets.idle.DT

	sets.resting = set_combine(sets.idle, {
		waist="Austerity Belt"
		})
	
	------------------------------------------------------------------------------------------------
	---------------------------------------- Defense Sets ------------------------------------------
	------------------------------------------------------------------------------------------------
	
	sets.defense.PDT = sets.idle.DT
	sets.defense.MDT = sets.idle.DT
	sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.latent_refresh = {waist="Fucho-no-obi"}


	------------------------------------------------------------------------------------------------
	---------------------------------------- Engaged Sets ------------------------------------------
	------------------------------------------------------------------------------------------------
	
	sets.engaged = {
		ammo="Ginsen",
		head="Carmine Mask +1", -- Haste 8%
		neck="Lissome Necklace",
		lear="Sherida Earring",
		rear="Cessance Earring",
		body="Jhakri Robe +2", -- Haste 1%
		hands="Atrophy Gloves +3", -- Haste 4%
		lring="Ilabrat Ring",
		rring="Petrov Ring",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},
		waist="Dynamic Belt +1",  --Haste 6%
		legs="Carmine Cuisses +1",  -- Haste 6%
		feet={ name="Merlinic Crackows", augments={'Attack+21','Pet: VIT+14','Quadruple Attack +3','Accuracy+19 Attack+19','Mag. Acc.+14 "Mag.Atk.Bns."+14',}}, --Haste 3%
	}
	-- Haste 28%

	sets.buff.Doom = {
		ring1="Saida Ring", 
		ring2="Ephedra Ring", 
		waist="Gishdubar Sash"}

	sets.Obi = {}
	sets.CP = {}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function pretarget(spell,action)
        if spell.action_type == 'Magic' or spell.type == 'JobAbility' and buffactive.silence or buffactive.paralysis then -- Auto Use Echo Drops If You Are Silenced --
                cancel_spell()
                send_command('input /item "Remedy" <me>')
        elseif spell.type == "WeaponSkill" and spell.target.distance > target_distance and player.status == 'Engaged' then -- Cancel WS If You Are Out Of Range --
                cancel_spell()
                add_to_chat(123, spell.name..' Canceled: [Out of Range]')
                return
        end
end

--function pretarget(spell,action) 
-- if buffactive['Silence'] or buffactive['Paralysis'] then
--            if spell.action_type == 'Magic' or spell.type == 'JobAbility' then  
 --               cancel_spell()
 --               send_command('input /item "Remedy" <me>')
 --           end            
--        end
 --   end
	

function job_precast(spell, action, spellMap, eventArgs)

	if type(windower.ffxi.get_player().autorun) == 'table' and spell.action_type == 'Magic' then 
		windower.add_to_chat(122,'Currently auto-running - stopping to cast spell')
		windower.ffxi.run(false)
		windower.ffxi.follow()  -- disabling Follow - turning back autorun automatically turns back on follow.
		autorun = 1
		cast_delay(.4) -- manipulate based on lag.
		return
	end

end


-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.skill == 'Enfeebling Magic' and state.Buff.Saboteur then
		equip(sets.buff.Saboteur)
	elseif spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) then
		equip(sets.midcast.EnhancingDuration)
	elseif spell.skill == 'Enhancing Magic' and spell.target.type == 'PLAYER' then
		if buffactive.composure then
			equip(sets.buff.ComposureOther)
		end
	elseif spellMap == 'Cure' and spell.target.type == 'SELF' then
		equip(sets.midcast.CureSelf)
	elseif spell.skill == 'Elemental Magic' then
		if state.MagicBurst.value and spell.english ~= 'Death' then
			equip(sets.magic_burst)
			if spell.english == "Impact" then
				equip(sets.midcast.Impact)
			end
		end
		if (spell.element == world.day_element or spell.element == world.weather_element) then
			equip(sets.Obi)
		end
	end
end

function job_aftercast(spell, action, spellMap, eventArgs)

	if autorun == 1 then 
		windower.ffxi.run()
		autorun = 0
	end

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------



function job_aftercast(spell)
    if spell.english == 'Sleep' or spell.english == 'Sleepga' then
		send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 60 down spells/00220.png')
	elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
		send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 90 down spells/00220.png')
	elseif spell.english == 'Break' or spell.english == 'Breakga' then
		send_command('@wait 20;input /echo ------- '..spell.english..' is wearing off in 10 seconds -------')
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
		disable('main','sub')
	else
		enable('main','sub')
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------



-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
	if cmdParams[1]:lower() == 'scholar' then
		handle_strategems(cmdParams)
		eventArgs.handled = true
	elseif cmdParams[1]:lower() == 'nuke' then
		handle_nuking(cmdParams)
		eventArgs.handled = true
	end
end

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
	if spell.action_type == 'Magic' then
		if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
			if (world.weather_element == 'Light' or world.day_element == 'Light') then
				return 'CureWeather'
			end
		elseif spell.skill == 'Enfeebling Magic' then
			if spell.type == 'WhiteMagic' then
				return 'MndEnfeebles'
			else
				return 'IntEnfeebles'
			end
		end
	end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	if player.mpp < 51 then
		idleSet = set_combine(idleSet, sets.latent_refresh)
 	elseif state.CP.current == 'on' then
		equip(sets.CP)
		disable('back')
	else
		enable('back')
	end
	
	return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
	display_current_caster_state()
	eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------


-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
	-- cmdParams[1] == 'scholar'
	-- cmdParams[2] == strategem to use

	if not cmdParams[2] then
		add_to_chat(123,'Error: No strategem command given.')
		return
	end
	local strategem = cmdParams[2]:lower()

	if strategem == 'light' then
		if buffactive['light arts'] then
			send_command('input /ja "Addendum: White" <me>')
		elseif buffactive['addendum: white'] then
			add_to_chat(122,'Error: Addendum: White is already active.')
		else
			send_command('input /ja "Light Arts" <me>')
		end
	elseif strategem == 'dark' then
		if buffactive['dark arts'] then
			send_command('input /ja "Addendum: Black" <me>')
		elseif buffactive['addendum: black'] then
			add_to_chat(122,'Error: Addendum: Black is already active.')
		else
			send_command('input /ja "Dark Arts" <me>')
		end
	elseif buffactive['light arts'] or buffactive['addendum: white'] then
		if strategem == 'cost' then
			send_command('input /ja Penury <me>')
		elseif strategem == 'speed' then
			send_command('input /ja Celerity <me>')
		elseif strategem == 'aoe' then
			send_command('input /ja Accession <me>')
		elseif strategem == 'addendum' then
			send_command('input /ja "Addendum: White" <me>')
		else
			add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
		end
	elseif buffactive['dark arts']  or buffactive['addendum: black'] then
		if strategem == 'cost' then
			send_command('input /ja Parsimony <me>')
		elseif strategem == 'speed' then
			send_command('input /ja Alacrity <me>')
		elseif strategem == 'aoe' then
			send_command('input /ja Manifestation <me>')
		elseif strategem == 'addendum' then
			send_command('input /ja "Addendum: Black" <me>')
		else
			add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
		end
	else
		add_to_chat(123,'No arts has been activated yet.')
	end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    if player.sub_job == 'SCH' then
        set_macro_page(4, 3)
    elseif player.sub_job == 'BLM' then
        set_macro_page(6, 3)	
    elseif player.sub_job == 'WHM' then
        set_macro_page(8, 3)
    elseif player.sub_job == 'NIN' then
        set_macro_page(2, 3)
	else
        set_macro_page(2, 3)
	end	
end

function set_lockstyle()
	send_command('wait 2; input /lockstyleset 03')
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
