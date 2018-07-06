-------------------------------------------------------------------------------------------------------------------
-- (Original: Motenten / Modified: Arislan)
-------------------------------------------------------------------------------------------------------------------
 
--[[    Custom Features:
         
        Magic Burst         Toggle Magic Burst Mode  [Alt-`]
        Death Mode          Casting and Idle modes that maximize MP pool throughout precast/midcast/idle swaps
        Capacity Pts. Mode  Capacity Points Mode Toggle [WinKey-C]
        Auto. Lockstyle     Automatically locks desired equipset on file load
--]]
 
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
 
    state.CP = M(false, "Capacity Points Mode")
 
end
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Spaekona', 'Resistant')
    state.IdleMode:options('Normal', 'DT')
 
    state.WeaponLock = M(false, 'Weapon Lock')  
    state.MagicBurst = M(false, 'Magic Burst')
    state.DeathMode = M(false, 'Death Mode')
    state.CP = M(false, "Capacity Points Mode")
 
    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder'}
     
    -- Additional local binds
--    send_command('bind ^` input /ma Stun <t>;')--input /p <wstar> <ldangle> <circle1> Stun <rarr> <t> <rdangle> <wstar> <call14>') 
--    send_command('bind !` gs c toggle MagicBurst')
--    send_command('bind !w input /ma "Aspir III" <t>')
--    send_command('bind !p input /ma "Shock Spikes" <me>')
--    send_command('bind ^, input /ma Sneak <stpc>')
--    send_command('bind ^. input /ma Invisible <stpc>')
--    send_command('bind @d gs c toggle DeathMode')
--    send_command('bind @c gs c toggle CP')
--    send_command('bind @w gs c toggle WeaponLock')
 
    select_default_macro_book()
    set_lockstyle()
end
 
-- Called when this job file is unloaded (eg: job change)
function user_unload()
--    send_command('unbind ^`')
--    send_command('unbind !`')
--    send_command('unbind !w')
--    send_command('unbind !p')
--    send_command('unbind ^,')
--    send_command('unbind !.')
--    send_command('unbind @d')
--    send_command('unbind @c')
--    send_command('unbind @w')
end
 
 
-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
     
    ---- Precast Sets ----
     
    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {
        feet="Wicce Sabots",
         }
 
    sets.precast.JA.Manafont = {body="Arch. Coat"}
 
    -- Fast cast sets for spells
    sets.precast.FC = {
    --  /RDM --15 /SCH --10
		main="Oranyan", --7
        sub="Enki Strap", 
		head="Vanya Hood", --10
		neck="Baetyl Pendant", --4
        body="Eirene's Manteel", --10
		hands="Telchine Gloves", --4
		ring2="Kishar Ring", --5
		ring1="Prolix Ring", --2
		legs="Psycloth Lappas", --7
		lear="Loquacious Earring",  -- 2
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+2','"Fast Cast"+5','MND+2','"Mag.Atk.Bns."+10',}}, --10
		waist="Witful Belt"} --3
		-- 64 total
 
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        waist="Siegel Sash",
        })
 
--    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})
 
--    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
--        waist="Channeler's Stone", --2
--        })
 
 --   sets.precast.FC.Cure = set_combine(sets.precast.FC, {
 --       })
 
    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.Impact = {head=empty, body="Twilight Cloak"}
    sets.precast.Storm = set_combine(sets.precast.FC, {ring2="Levia. Ring +1", waist="Channeler's Stone"}) -- stop quick cast
     
    sets.precast.FC.DeathMode = {
        }
 
    sets.precast.FC.Impact.DeathMode = {head=empty, body="Twilight Cloak"}
 
    -- Weaponskill sets
     
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        }
 
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
 
    sets.precast.WS['Vidohunir'] = {
        } -- INT
 
    sets.precast.WS['Myrkr'] = {
        } -- Max MP
		
	sets.precast.WS['Shattersoul'] = {
		main={ name="Lathi", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},		main={ name="Lathi", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
        sub="Enki Strap",
		head="Jhakri Coronal +2",
		neck="Lissome Necklace",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +1",
		lring="Etana Ring",
		rring="Vertigo Ring",
		waist="Latria Sash",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2"}
 
     
    ---- Midcast Sets ----
 
    sets.midcast.FastRecast = {
 		main={ name="Lathi", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
		sub="Enki Strap", --2
		head="Vanya Hood", --10
		neck="Baetyl Pendant", --4
		body="Eirene's Manteel", --10
		hands="Telchine Gloves", --4
		ring2="Kishar Ring", --4
		ring1="Prolix Ring", --2
		legs="Psycloth Lappas", --7
		lear="Loquacious Earring",  -- 2
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+2','"Fast Cast"+5','MND+2','"Mag.Atk.Bns."+10',}}, --10
		waist="Witful Belt"} --3
		-- 58 total
 
    sets.midcast.Cure = {
		main={ name="Lathi", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
        sub="Enki Strap",
		head="Vanya Hood",  --10
		neck="Incanter's Torque",
		ear1="Mendicant's Earring",  --5
		ear2="Static Earring",
        body="Vanya Robe",
		hands="Telchine Gloves",  --10
		ring1="Stikini Ring +1",
		ring2="Sirona's Ring",
        back="Solemnity Cape",  --7
		waist="Latria Sash",
		legs="Gyve Trousers", --10
		feet="Vanya Clogs"}  --10
		-- 52 total
 
    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
        })
 
    sets.midcast.Cursna = set_combine(sets.midcast.Cure, {
        head="Vanya Hood",
        feet="Vanya Clogs",
        })
 
    sets.midcast['Enhancing Magic'] = {
		main="Oranyan",
        sub="Enki Strap",
		head="Telchine Cap",
		neck="Incanter's Torque",
		body="Telchine Chas.",
		hands="Telchine Gloves",
		legs={ name="Telchine Braconi", augments={'Attack+5','"Fast Cast"+3','"Regen" potency+1',}},
		feet="Vanya Clogs"}
 
    sets.midcast.EnhancingDuration = {
		main="Oranyan",
        sub="Enki Strap",
		head="Telchine Cap",
		neck="Incanter's Torque",
		body="Telchine Chas.",
		hands="Telchine Gloves", --Duration +9
		legs={ name="Telchine Braconi", augments={'Attack+5','"Fast Cast"+3','"Regen" potency+1',}},
		feet="Vanya Clogs"}
 
    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {
		waist="Rumination Sash", --Spell interruption -10%
		body={ name="Telchine Chas.", augments={'Fast Cast+3','Enh. Mag. eff. dur. +8',}},
		legs={ name="Telchine Braconi", augments={'Attack+5','"Fast Cast"+3','"Regen" potency +1',}},
		feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +7',}},
		})
     
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {
		head="Amalric Coif +1",
        waist="Gishdubar Sash",
        back="Grapevine Cape"
        })
     
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
 		waist="Siegel Sash",
		neck="Nodens Gorget",
		legs="Haven Hose"})
 
    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
        })
 
    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {
        })
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Protect
 
    sets.midcast.MndEnfeebles = {
		main="Grioavolr",
		ammo="Pemphredo Tathlum",
		head="Befouled Crown",
		neck="Incanter's Torque",
		lear="Barkarole Earring",
		rear="Lempo Earring",
		body="Vanya Robe",
		hands="Jhakri Cuffs +1",
		ring1="Kishar Ring",
		ring2="Stikini Ring +1",
		back="Taranus's Cape",
		legs="Psycloth Lappas",
		feet="Medium's Sabots",
		waist="Rumination Sash",
		sub="Enki Strap"}
 
    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
		main="Grioavolr",
		ammo="Pemphredo Tathlum",
		head="Befouled Crown",
		neck="Incanter's Torque",
		lear="Barkarole Earring",
		rear="Lempo Earring",
		body="Vanya Robe",
		hands="Jhakri Cuffs +1",
		ring1="Kishar Ring",
		ring2="Stikini Ring +1",
		back="Taranus's Cape",
		legs="Psycloth Lappas",
		feet="Medium's Sabots",
		waist="Rumination Sash",
		sub="Enki Strap"})
         
    sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles
 
    sets.midcast['Dark Magic'] = {
		main="Rubicundity",
		ammo="Pemphredo Tathlum",
        sub="Culminus",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Magic burst dmg.+10%','INT+4','"Mag.Atk.Bns."+10',}},
		neck="Erra Pendant",
		neck="Incanter's Torque",
		ear1="Barkarole Earring",
		ear2="Gwati Earring",
        body="Psycloth Vest",
		hands="Jhakri Cuffs +1",
		ring1="Evanescence Ring",
		ring2="Stikini Ring +1",
        back="Taranus's Cape",
		waist="Tengu-No-Obi",
		legs="Merlinic Shalwar", 
		feet="Wicce Sabots"}
 
    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		ring2="Archon Ring",
		head="Pixie Hairpin +1",
		waist="Fucho-No-Obi"
		})
 
    sets.midcast.Aspir = sets.midcast.Drain
 
    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
        })
 
    sets.midcast.Death = {
        }
 
    -- Elemental Magic sets
     
    sets.midcast['Elemental Magic'] = {
 		main={ name="Lathi", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
        sub="Enki Strap",
		ammo="Pemphredo Tathlum",
        head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','INT+5','"Mag.Atk.Bns."+14',}},
		neck="Mizukage-No-Kubikazari",
		lear="Choleric Earring",
		rear="Barkarole Earring",
		body="Spaekona's Coat +1",
		hands="Amalric Gages +1",
		lring="Resonance Ring",
		rring="Stikini Ring +1",
		waist="Tengu-No-Obi",
		legs="Merlinic Shalwar",
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic burst dmg.+9%','INT+14',}},		
		back="Taranus's Cape"}
 
    sets.midcast['Elemental Magic'].DeathMode = set_combine(sets.midcast['Elemental Magic'], {
 
        })
 
    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
        })
             
    sets.midcast['Elemental Magic'].Spaekona = set_combine(sets.midcast['Elemental Magic'], {
        body="Spae. Coat +1",
         })
 
    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
        })
 
    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC
     
    sets.resting = {
        }
 
    -- Idle sets
     
    sets.idle = {
		main={ name="Lathi", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
        sub="Enki Strap",
		ammo="Staunch Tathlum",
		head="Befouled Crown",
		neck="Loricate Torque",
		legs="Assiduity Pants +1",
		body="Jhakri Robe +2",
		hands={ name="Merlinic Dastanas", augments={'DEX+4','AGI+8','"Refresh"+2',}},
		lring="Stikini Ring +1",
		rring="Defending Ring",
		waist="Slipor Sash",
		feet={ name="Merlinic Crackows", augments={'INT+8','"Fast Cast"+2','"Refresh"+2','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
		lear="Hearty Earring",
		rear="Eabani Earring",
		back="Solemnity Cape"}
 
    sets.idle.DT = set_combine(sets.idle, {
        })
 
    sets.idle.ManaWall = {
        }
 
    sets.idle.DeathMode = {
         }
 
    sets.idle.Town = set_combine(sets.idle, {
		main={ name="Lathi", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
        sub="Enki Strap",
		body="Councilor's Garb",
		feet="Herald's Gaiters"})
 
    sets.idle.Weak = sets.idle.DT
         
    -- Defense sets
 
    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT
 
    sets.Kiting = {feet="Herald's Gaiters"}
    sets.latent_refresh = {waist="Fucho-no-obi"}
    sets.latent_dt = {}
 
    sets.magic_burst = { 
		main={ name="Lathi", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
        sub="Enki Strap",
		ammo="Pemphredo Tathlum",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Magic burst dmg.+10%','INT+4','"Mag.Atk.Bns."+10',}}, --10
		neck="Mizukage-No-Kubikazari", --10
	    ear1="Barkarole Earring",
		ear2="Friomisi Earring",
		body="Spaekona's Coat +1", 
		hands="Amalric Gages +1", --5 II
		ring1="Mujin Band", --5 II
		ring2="Resonance Ring", 
		waist="Tengu-No-Obi",
		legs="Merlinic Shalwar", --10
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic burst dmg.+9%','INT+14',}}, --9
		back="Taranus's Cape"} --5
		-- 44 + 18
 
    sets.magic_burst.Resistant = { 
		main={ name="Lathi", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
        sub="Enki Strap",
		ammo="Pemphredo Tathlum",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Magic burst dmg.+10%','INT+4','"Mag.Atk.Bns."+10',}}, --10
		neck="Mizukage-No-Kubikazari", --10
	    ear1="Barkarole Earring",
		ear2="Friomisi Earring",
		body="Spaekona's Coat +1", 
		hands="Amalric Gages +1", --5 II
		ring1="Mujin Band", --5 II
		ring2="Resonance Ring", 
		waist="Tengu-No-Obi",
		legs="Merlinic Shalwar", --10
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic burst dmg.+9%','INT+14',}}, --9
		back="Taranus's Cape"} --5
		-- 44 + 18
 
    -- Engaged sets
 
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
     
    -- Normal melee group
 
    sets.engaged = {
		main={ name="Lathi", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
        sub="Enki Strap",
		head="Jhakri Coronal +2",
        ammo="Amar Cluster",
		neck="Lissome Necklace",
		ear1="Cessance Earring",
		ear2="Mache Earring",
        body="Jhakri Robe +2",
		hands="Jhakri Cuffs +1",
		ring1="Etana Ring",
		ring2="Petrov Ring",
        waist="Windbuffet Belt +1",
		feet={ name="Merlinic Crackows", augments={'Attack+21','Pet: VIT+14','Quadruple Attack +3','Accuracy+19 Attack+19','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
		legs="Jhakri Slops +2",
		back="Taranus's Cape"
		}
 
    sets.buff.Doom = {ring1="Saida Ring", waist="Gishdubar Sash"}
 
    sets.DarkAffinity = {head="Pixie Hairpin +1"}
    sets.Obi = {}
    sets.CP = {back="Mecisto. Mantle +1"}
 
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' and state.DeathMode.value then
        eventArgs.handled = true
        equip(sets.precast.FC.DeathMode)
        if spell.english == "Impact" then
            equip(sets.precast.FC.Impact.DeathMode)
        end
    end
     
    if buffactive['Mana Wall'] then
        equip(sets.precast.JA['Mana Wall'])
    end
end
 
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' and state.DeathMode.value then
        eventArgs.handled = true
        if spell.skill == 'Elemental Magic' then
            equip(sets.midcast['Elemental Magic'].DeathMode)
        else
            equip(sets.midcast.Death)
        end
    end
 
    if buffactive['Mana Wall'] then
        equip(sets.precast.JA['Mana Wall'])
    end
end
 
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) and not state.DeathMode.value then
        equip(sets.midcast.EnhancingDuration)
    end
    if spell.skill == 'Elemental Magic' and spell.english == "Comet" then
        equip(sets.DarkAffinity)        
    end
    if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value and spell.english ~= 'Death' then
            if state.CastingMode.value == "Resistant" then
                equip(sets.magic_burst.Resistant)
            else
                equip(sets.magic_burst)
            end
            if spell.english == "Impact" then
                equip(sets.midcast.Impact)
            end
        end
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
    end
    if buffactive['Mana Wall'] then
        equip(sets.precast.JA['Mana Wall'])
    end
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Unlock armor when Mana Wall buff is lost.
    if buff== "Mana Wall" then
        if gain then
            --send_command('gs enable all')
            equip(sets.precast.JA['Mana Wall'])
            --send_command('gs disable all')
        else
            --send_command('gs enable all')
            handle_equipping_gear(player.status)
        end
    end
 
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
 
-- latent DT set auto equip on HP% change
    windower.register_event('hpp change', function(new, old)
        if new<=25 then
            equip(sets.latent_dt)
        end
    end)
 
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
 
-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end
 
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.DeathMode.value then
        idleSet = sets.idle.DeathMode
    end
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if player.hpp <= 25 then
        idleSet = set_combine(idleSet, sets.latent_dt)
    end
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end
    if buffactive['Mana Wall'] then
        idleSet = set_combine(idleSet, sets.precast.JA['Mana Wall'])
    end
     
    return idleSet
end
 
-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if buffactive['Mana Wall'] then
        meleeSet = set_combine(meleeSet, sets.precast.JA['Mana Wall'])
    end
 
    return meleeSet
end
 
function customize_defense_set(defenseSet)
    if buffactive['Mana Wall'] then
        defenseSet = set_combine(defenseSet, sets.precast.JA['Mana Wall'])
    end
 
    return defenseSet
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
 
function set_lockstyle()
    send_command('wait 2; input /lockstyleset 06')
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
