-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-- Original LUA by Fenrir.Motenten; edited by Odin.Speedyjim
-------------------------------------------------------------------------------------------------------------------

--[[
        Custom commands:64

        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.
		In-game macro: /console gs c scholar xxx

                                        Light Arts              Dark Arts

        gs c scholar light              Light Arts/Addendum
        gs c scholar dark                                       Dark Arts/Addendum
        gs c scholar cost               Penury                  Parsimony
        gs c scholar speed              Celerity                Alacrity
        gs c scholar aoe                Accession               Manifestation
        gs c scholar power              Rapture                 Ebullience
        gs c scholar duration           Perpetuance
        gs c scholar accuracy           Altruism                Focalization
        gs c scholar enmity             Tranquility             Equanimity
        gs c scholar skillchain                                 Immanence
        gs c scholar addendum           Addendum: White         Addendum: Black
--]]



-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('organizer-lib')
	send_command('wait 2;input /lockstyleset 13')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    info.addendumNukes = S{"Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
        "Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}

    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
    update_active_strategems()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

    state.MagicBurst = M(false, 'Magic Burst')
	
    info.low_nukes = S{"Stone", "Water", "Aero", "Fire", "Blizzard", "Thunder", 
	                   "Stone II", "Water II", "Aero II", "Fire II", "Blizzard II", "Thunder II",
					   "Stone III", "Water III", "Aero III", "Fire III", "Blizzard III", "Thunder III",
					   "Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
	                   "Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}
    info.mid_nukes = S{}
    info.high_nukes = S{}

    send_command('bind ` input /ma Stun <t>; wait 0.5; input /p Casting STUN → «¶«<t>«¶«.')
	send_command('bind ^` gs c toggle MagicBurst')
	send_command('bind !` input /ja "Sublimation" <me>')
	send_command('bind ^- gs c scholar light')
	send_command('bind ^= gs c scholar dark')
	send_command('bind @- gs c scholar cost')
	send_command('bind @= gs c scholar power')
	send_command('bind delete gs c scholar speed')
	send_command('bind Home gs c scholar duration')
	send_command('bind End gs c scholar aoe')

    select_default_macro_book()
end

function user_unload()
	send_command('unbind `')
    send_command('unbind ^`')
    send_command('unbind ^-')
    send_command('unbind ^=')
    send_command('unbind !`')
    send_command('unbind !-')
    send_command('unbind !=')
    send_command('unbind @`')
    send_command('unbind @-')
    send_command('unbind @=')
	send_command('unbind delete')
	send_command('unbind end')
	send_command('unbind home')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Precast Sets
	-- Precast sets to enhance JAs

	sets.precast.JA['Tabula Rasa'] = {legs="Pedagogy Pants"}
	sets.precast.JA['Dark Arts'] = {"Academic's Gown +1"}
	sets.precast.JA['Light Arts'] = {"Academic's Pants +1"}
	
	organizer_items = {agown="Academic's Gown +1"}


	-- Fast cast sets for spells
    -- FC  +65 - RDM +15
	sets.precast.FC = {
		main="Akademos",
		sub="Clerisy Strap", --2
		head="Vanya Hood", -- 10
		body="Eirene's Manteel", -- 10
		hands="Gendewitha Gages",  -- 7
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}}, -- 7
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+2','"Fast Cast"+5','MND+2','"Mag.Atk.Bns."+10',}},  -- 10
		neck="Baetyl Pendant",  -- 4
		back={ name="Lugh's Cape", augments={'"Fast Cast"+6',}}, --6
		waist="Witful Belt", --3
		lear="Loquacious Earring",  -- 2
		left_ring="Rahab Ring",  --2
		right_ring="Prolix Ring"}  --2

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {feet="Vanya Clogs",hands="Kaykaus Cuffs"})
	sets.precast.FC.Curaga = sets.precast.FC.Cure
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {ear1="Barkarole Earring"})
	sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], {})
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC, {head="Umuthi Hat",waist="Siegel Sash"})
	
	-- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		head="Jhakri Coronal +1",
		neck="Sanctity Necklace",
		lear="Steelflash Earring",
		rear="Bladeborn Earring",
		body="Jhakri Robe +1",
		hands="Jhakri Cuffs +1",
		lring="Rufescent Ring",
		rring="Ifrit Ring",
		back="Kayapa Cape",
		waist="Windbuffet Belt +1",
		legs="Jhakri Slops +1",
		feet="Jhakri Pigaches"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	
	-- Total MP: 1797 (Outside Escha), ???? (Inside Escha)
    sets.precast.WS['Myrkr'] = {
		ammo="Ghastly Tathlum +1",
		head="Kaukaus Mitra",
		neck="Sanctity Necklace",
		lear="Mendicant's Earring",
		rear="Loquacious Earring",
		body="Kaukaus Bliaut",
		hands="Kaykaus Cuffs",
		lring="Sangoma Ring",
		rring="Etana Ring",
		back="Twilight Cape",
		waist="Fucho-no-obi",
		legs="Amalric Slops",
		feet="Arbatel Loafers +1"}

	sets.precast.WS['Retribution'] = {
		head="Jhakri Coronal +1",
		neck="Sanctity Necklace",
		lear="Steelflash Earring",
		rear="Bladeborn Earring",
		body="Jhakri Robe +1",
		hands="Jhakri Cuffs +1",
		lring="Rufescent Ring",
		rring="Ifrit Ring",
		back="Kayapa Cape",
		waist="Windbuffet Belt +1",
		legs="Jhakri Slops +1",
		feet="Jhakri Pigaches"}
	
	-- Midcast Sets

	sets.midcast.FastRecast = {    
		main="Akademos",
		sub="Clerisy Strap", --2
		ammo="Impatiens",
		head="Vanya Hood", -- 10
		body="Eirene's Manteel", -- 10
		hands="Gendewitha Gages",  -- 7
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}}, -- 7
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+2','"Fast Cast"+5','MND+2','"Mag.Atk.Bns."+10',}},  -- 10
		neck="Baetyl Pendant",  -- 4
		waist="Witful Belt", --3
		lear="Loquacious Earring",  -- 2
		left_ring="Rahab Ring",  --2
		back={ name="Lugh's Cape", augments={'"Fast Cast"+6',}}, --6
		right_ring="Prolix Ring"}  --2

	-- Cure Sets
	
	sets.midcast.Cure = {		
		main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
		sub="Clerisy Strap",
		ammo="Impatiens",
		head="Kaykaus Mitra", --10
		body="Kaykaus Bliaut", -- 3 II
		hands="Kaykaus Cuffs", --10
		legs="Gyve Trousers", --10
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}}, --10
		neck="Incanter's Torque",
		waist="Rumination Sash", --Spell interruption -10%
		right_ear="Mendi. Earring", --5
		left_ring="Stikini Ring",
		right_ring="Sirona's Ring",
		back="Solemnity Cape"} --7
		--Total 52 + 3
    

	sets.midcast.CureWithLightWeather = set_combine(sets.midcast.Cure, {})

	sets.midcast.Curaga = sets.midcast.Cure

	sets.midcast.Regen = {
		main="Bolelabunga",
		sub="Culminus",
		ammo="Impatiens",
		waist="Rumination Sash", --Spell interruption -10%
		head="Arbatel Bonnet +1",
		body={ name="Telchine Chas.", augments={'Fast Cast+3','Enh. Mag. eff. dur. +8',}},
		legs={ name="Telchine Braconi", augments={'Attack+5','"Fast Cast"+3','"Regen" potency +1',}},
		feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +7',}},
		neck="Sanctity Necklace",
		right_ring="Stikini Ring",
		back="Bookworm's Cape"}
	
	-- Enhancing Magic Sets
	
	sets.midcast['Enhancing Magic'] = {
		main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
		ammo="Savant's Treatise",
		head="Telchine Cap",
		body={ name="Telchine Chas.", augments={'Fast Cast+3','Enh. Mag. eff. dur. +8',}},
		legs="Amalric Slops",
		feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +7',}},
		neck="Incanter's Torque",
		waist="Latria Sash",
		left_ring="Vertigo Ring",
		right_ring="Stikini Ring",
		back="Fi Follet Cape"}

	sets.midcast.Cursna = {
		main="Akademos",
		sub="Clerisy Strap", --2
		ammo="Impatiens",
		head="Vanya Hood", -- 10
		body="Eirene's Manteel", -- 10
		hands="Gendewitha Gages",  -- 7
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}}, -- 7
		feet="Vanya Clogs",  -- Cursna +5
		neck="Baetyl Pendant",  -- 4
		waist="Gishdubar Sash", --Cursna +10
		lear="Loquacious Earring",  -- 2
		left_ring="Rahab Ring",  --2
		back={ name="Lugh's Cape", augments={'"Fast Cast"+6',}}, --6
		right_ring="Prolix Ring"}  --2
		-- Cursna +15, FC 39
		
	
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash",legs="Haven Hose",neck="Nodens Gorget"})
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {waist="Gishdubar Sash",back="Grapevine Cape"})
	sets.midcast.Erase = sets.midcast.FastRecast
	sets.midcast.Klimaform = sets.midcast.FastRecast

	-- Custom spell classes
	sets.midcast.MndEnfeebles = {		
		main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
		sub="Clerisy Strap",
		ammo="Savant's Treatise",
		head="Befouled Crown",
		body={ name="Vanya Robe", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},
		hands="Lurid Mitts",
		legs="Psycloth Lappas",
		feet="Medium's Sabots",
		neck="Incanter's Torque",
		waist="Rumination Sash",
		left_ear="Barkaro. Earring",
		right_ear="Lempo Earring",
		left_ring="Vertigo Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
		right_ring="Stikini Ring"}

	sets.midcast.IntEnfeebles = sets.midcast.MndEnfeebles
	sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles
	sets.midcast.Kaustra = set_combine(sets.midcast['Elemental Magic'], {})

	sets.midcast['Dark Magic'] = {
		main="Rubicundity",
		sub="Culminus",
		ammo="Kalboron Stone",
		head="Jhakri Coronal +1",
		body="Psycloth Vest",
		hands="Jhakri Cuffs +1",
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+10%','CHR+8','Mag. Acc.+7','"Mag.Atk.Bns."+1',}},
		feet="Jhakri Pigaches +1",
		neck="Incanter's Torque",
		waist="Refoccilation Stone",
		right_ear="Barkaro. Earring",
		left_ring="Stikini Ring",
		right_ring="Evanescence Ring",
		back="Bookworm's Cape"}

	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		main="Rubicundity",
		sub="Culminus",
		ammo="Kalboron Stone",
		head="Jhakri Coronal +1",
		body="Psycloth Vest",
		hands="Jhakri Cuffs +1",
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+10%','CHR+8','Mag. Acc.+7','"Mag.Atk.Bns."+1',}},
		body="Jhakri Robe +1",
		neck="Incanter's Torque",
		waist="Refoccilation Stone",
		right_ear="Barkaro. Earring",
		left_ring="Stikini Ring",
		right_ring="Evanescence Ring",
		back="Bookworm's Cape"})

	sets.midcast.Aspir = sets.midcast.Drain

	sets.midcast.Stun = {
		main="Rubicundity",
		sub="Culminus",
		ammo="Impatiens",
		head="Merlinic Hood",
		body="Psycloth Vest",
		hands="Jhakri Cuffs +1",
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+10%','CHR+8','Mag. Acc.+7','"Mag.Atk.Bns."+1',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic burst mdg.+9%','INT+14',}},
		neck="Incanter's Torque",
		waist="Tengu-No-Obi",
		right_ear="Barkaro. Earring",
		left_ring="Stikini Ring",
		right_ring="Evanescence Ring",
		back="Bookworm's Cape"}

	sets.midcast.Stun.Resistant = set_combine(sets.midcast.Stun, {})


	-- Elemental Magic sets are default for handling all-tier nukes.
	 sets.midcast['Elemental Magic'] = {
		main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
		sub="Clerisy Strap",
		ammo="Ghastly Tathlum +1",
		head="Merlinic Hood",
		neck="Baetyl Pendant",
		ear1="Barkarole Earring",
		ear2="Choleric Earring", --Crit rate +10 +crit damage
		body="Count's Garb", --Crit rate +15  +10% crit damage
		hands="Amalric Gages",
		ring2="Resonance Ring",  --Crit rate +5%
		waist="Maniacus Sash", --Crit rate +10
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+10%','CHR+8','Mag. Acc.+7','"Mag.Atk.Bns."+1',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic burst mdg.+9%','INT+14',}},
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
		ring1="Locus Ring"}  --Crit rate +5%
		--Crit rate +45

	sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {})

	-- Custom refinements for certain nuke tiers (No longer used as of Jan/2016).
	sets.midcast['Elemental Magic'].HighTierNuke = sets.midcast['Elemental Magic']
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = sets.midcast['Elemental Magic'].Resistant
	
	sets.midcast.Helix = {
		main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
		sub="Clerisy Strap",
		ammo="Ghastly Tathlum +1",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Magic burst mdg.+10%','INT+4','"Mag.Atk.Bns."+10',}},
		body={ name="Witching Robe", augments={'MP+50','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Refresh"+1',}},
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+10%','CHR+8','Mag. Acc.+7','"Mag.Atk.Bns."+1',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic burst mdg.+9%','INT+14',}},
		neck="Baetyl Pendant",
		waist="Tengu-no-Obi",
		left_ear="Barkaro. Earring",
		right_ear="Choleric Earring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
		left_ring="Mujin Band",
		right_ring="Locus Ring"}
	-- Helix has low dINT modifier and benefits highly from magic damage
	
	
	
	sets.midcast.DarkHelix = set_combine(sets.midcast.Helix, {})
	sets.midcast.LightHelix = set_combine(sets.midcast.Helix, {})

	sets.midcast.Impact = {
		main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
		sub="Clerisy Strap",
		head="Merlinic Hood",
		neck="Mizukage-no-Kubikazari",
		ear1="Barkarole Earring",
		ear2="Friomisi Earring",
		body="Seidr Cotehardie",
		hands="Amalric Gages",
		ring2="Resonance Ring",
		waist="Refoccilation Stone",
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+10%','CHR+8','Mag. Acc.+7','"Mag.Atk.Bns."+1',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic burst mdg.+9%','INT+14',}},
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
		ring1="Stikini Ring"}


	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {
		main="Akademos",		
		sub="Clerisy Strap",
		ammo="Homiliary",
		head="Befouled Crown",
		body="Councilor's Garb",
		hands="Merlinic Dastanas",
		neck="Bathy Choker +1",
		lear="Hearty Earring",
		rear="Infused Earring",
		waist="Fucho-No-Obi",
		ring1="Paguroidea Ring",
		ring2="Defending Ring",
		legs="Assiduity Pants +1",
		feet="Herald's Gaiters"}


	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

	sets.idle.Town = {
		main="Akademos",		
		sub="Clerisy Strap",
		ammo="Homiliary",
		head="Befouled Crown",
		body="Councilor's Garb",
		hands="Merlinic Dastanas",
		neck="Bathy Choker +1",
		lear="Hearty Earring",
		rear="Infused Earring",
		waist="Fucho-No-Obi",
		ring1="Paguroidea Ring",
		ring2="Defending Ring",
		legs="Assiduity Pants +1",
		feet="Herald's Gaiters"}

	sets.idle.Field = {
		main="Akademos",		
		sub="Clerisy Strap",
		ammo="Homiliary",
		head="Befouled Crown",
		body="Witching Robe",
		hands="Merlinic Dastanas",
		neck="Bathy Choker +1",
		lear="Hearty Earring",
		rear="Infused Earring",
		waist="Fucho-No-Obi",
		ring1="Paguroidea Ring",
		ring2="Defending Ring",
		legs="Assiduity Pants +1",
		feet="Herald's Gaiters"}
		
	sets.idle.PDT = {
		main="Akademos",		
		sub="Clerisy Strap",
		ammo="Homiliary",
		body="Councilor's Garb",
		hands="Merlinic Dastanas",
		neck="Bathy Choker +1",
		lear="Hearty Earring",
		rear="Infused Earring",
		waist="Fucho-No-Obi",
		ring1="Paguroidea Ring",
		ring2="Defending Ring",
		legs="Assiduity Pants +1",
		feet="Herald's Gaiters"}

	sets.idle.Weak = sets.idle.Field
	
	-- Defense sets

	sets.defense.PDT = {
		main="Akademos",
		sub="Clerisy Strap",
		head="Befouled Crown",
		body="Witching Robe",
		hands="Serpentes Cuffs",
		neck="Twilight Torque",
		rear="Eabani Earring",
		waist="Fucho-No-Obi",
		ring1="Paguroidea Ring",
		ring2="Defending Ring",
		legs="Assiduity Pants +1",
		feet="Serpentes Sabots"}

	sets.defense.MDT = {
		main="Akademos",
		sub="Clerisy Strap",
		head="Befouled Crown",
		body="Witching Robe",
		hands="Serpentes Cuffs",
		neck="Twilight Torque",
		rear="Eabani Earring",
		waist="Fucho-No-Obi",
		ring1="Paguroidea Ring",
		ring2="Defending Ring",
		legs="Assiduity Pants +1",
		feet="Serpentes Sabots"}

	sets.Kiting = {feet="Herald's Gaiters"}
	sets.latent_refresh = {waist="Fucho-no-obi"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	sets.engaged = {
	    main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
		ammo="Amar Cluster",
		sub="Flanged Grip",
		head="Jhakri Coronal +1", --3
		neck="Sanctity Necklace",
		ear1="Cessance Earring",
		ear2="Mache Earring",
		body="Jhakri Robe +1",  --1
		hands="Jhakri Cuffs +1",  
		ring1="Portus Annulet",
		ring2="Rajas Ring",
		waist="Windbuffet Belt +1",  --6
		legs="Jhakri Slops +1",  --2
		feet="Jhakri Pigaches +1",
		back="Kayapa Cape"}  --12% Haste total


	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	sets.buff['Ebullience'] = {head="Arbatel Bonnet +1"}
	sets.buff['Rapture'] = {head="Arbatel Bonnet +1"}
	sets.buff['Perpetuance'] = {hands="Arbatel Bracers +1"}
	sets.buff['Immanence'] = {hands="Arbatel Bracers +1"}
	sets.buff['Penury'] = {legs="Arbatel Pants"}
	sets.buff['Parsimony'] = {legs="Arbatel Pants"}
	sets.buff['Celerity'] = {feet="Pedagogy Loafers"}
	sets.buff['Alacrity'] = {feet="Pedagogy Loafers"}
	sets.buff['Stormsurge'] = {feet="Pedagogy Loafers"}
	sets.buff['Klimaform'] = {feet="Arbatel Loafers +1"}

	sets.buff.FullSublimation = {
		main="Siriti",
		sub="Genmei Shield",
		head="Academic's Mortarboard +1",
		ear1="Savant's Earring",
		body="Pedagogy Gown +1",
		neck="Bathy Choker +1",
		ring2="Paguroidea Ring"}

	sets.buff.PDTSublimation = {
		main="Siriti",
		sub="Genmei Shield",
		head="Academic's Mortarboard +1",
		ear1="Savant's Earring",
		body="Pedagogy Gown +1",
		neck="Bathy Choker +1",
		ring2="Paguroidea Ring"}
	
	sets.magic_burst = {
		main="Akademos", --10
		sub="Clerisy Strap",
		head="Merlinic Hood", --10
		ear1="Barkarole Earring",
		ear2="Choleric Earring",
		body="Jhakri Robe +1",
		hands="Amalric Gages", --5 II
        ring1="Mujin Band", --5 II
		ring2="Locus Ring", --5
		waist="Refoccilation Stone",
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+10%','CHR+8','Mag. Acc.+7','"Mag.Atk.Bns."+1',}}, --10
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic burst mdg.+9%','INT+14',}},  --9
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
		neck="Baetyl Pendant"}
	-- 44 +10

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------


function job_precast(spell, action, spellMap, eventArgs)	
    refine_various_spells(spell, action, spellMap, eventArgs)
    if (spell.type:endswith('Magic') or spell.type == "Ninjutsu") then
	   if buffactive.Silence then
		cancel_spell()
		send_command('input /item "Echo Drops" <me>')
       end
    end	
	
	if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end
	
end	
	
-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
    end
	if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value then
        equip(sets.magic_burst)
        end
	end
	if spell.skill == 'Elemental Magic' and spell.element == world.day_element or spell.element == world.weather_element then
        equip ({waist="Hachirin-no-Obi"})
    end
end

function job_aftercast(spell)
    if spell.english == 'Sleep' or spell.english == 'Sleepga' then
		send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 60 down spells/00220.png')
	elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
		send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 90 down spells/00220.png')
	elseif spell.english == 'Break' or spell.english == 'Breakga' then
		send_command('@wait 20;input /echo ------- '..spell.english..' is wearing off in 10 seconds -------')
	end
end	

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == "Sublimation: Activated" then
        handle_equipping_gear(player.status)
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub')
        else
            enable('main','sub')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
            if world.weather_element == 'Light' then
                return 'CureWithLightWeather'
            end
        elseif spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Elemental Magic' then
            if info.low_nukes:contains(spell.english) then
                return 'LowTierNuke'
            elseif info.mid_nukes:contains(spell.english) then
                return 'MidTierNuke'
            elseif info.high_nukes:contains(spell.english) then
                return 'HighTierNuke'
            end
        end
    end
end

function customize_idle_set(idleSet)
    if state.Buff['Sublimation: Activated'] then
        if state.IdleMode.value == 'Normal' then
            idleSet = set_combine(idleSet, sets.buff.FullSublimation)
        elseif state.IdleMode.value == 'PDT' then
            idleSet = set_combine(idleSet, sets.buff.PDTSublimation)
        end
    end

    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not (buffactive['light arts']      or buffactive['dark arts'] or
                       buffactive['addendum: white'] or buffactive['addendum: black']) then
        if state.IdleMode.value == 'Stun' then
            send_command('@input /ja "Dark Arts" <me>')
        else
            send_command('@input /ja "Light Arts" <me>')
        end
    end

    update_active_strategems()
    update_sublimation()
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Reset the state vars tracking strategems.
function update_active_strategems()
    state.Buff['Ebullience'] = buffactive['Ebullience'] or false
    state.Buff['Rapture'] = buffactive['Rapture'] or false
    state.Buff['Perpetuance'] = buffactive['Perpetuance'] or false
    state.Buff['Immanence'] = buffactive['Immanence'] or false
    state.Buff['Penury'] = buffactive['Penury'] or false
    state.Buff['Parsimony'] = buffactive['Parsimony'] or false
    state.Buff['Celerity'] = buffactive['Celerity'] or false
    state.Buff['Alacrity'] = buffactive['Alacrity'] or false
    state.Buff['Klimaform'] = buffactive['Klimaform'] or false
end

function update_sublimation()
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

-- Equip sets appropriate to the active buffs, relative to the spell being cast.
function apply_grimoire_bonuses(spell, action, spellMap)
    if state.Buff.Perpetuance and spell.type =='WhiteMagic' and spell.skill == 'Enhancing Magic' then
        equip(sets.buff['Perpetuance'])
    end
    if state.Buff.Rapture and (spellMap == 'Cure' or spellMap == 'Curaga') then
        equip(sets.buff['Rapture'])
    end
    if spell.skill == 'Elemental Magic' then --or spellMap ~= 'ElementalEnfeeble'
        if state.Buff.Ebullience and spell.english ~= 'Impact' then
            equip(sets.buff['Ebullience'])
        end
        if state.Buff.Immanence then
            equip(sets.buff['Immanence'])
        end
        if state.Buff.Klimaform and spell.skill == "Elemental Magic" and spell.element == world.weather_element then
            equip(sets.buff['Klimaform'])
        end
    end

    if state.Buff.Penury then equip(sets.buff['Penury']) end
    if state.Buff.Parsimony then equip(sets.buff['Parsimony']) end
    if state.Buff.Celerity then equip(sets.buff['Celerity']) end
    if state.Buff.Alacrity then equip(sets.buff['Alacrity']) end
end


function display_current_caster_state()
	local msg = ''

	if state.OffenseMode.value ~= 'None' then
		msg = msg .. 'Melee'

		if state.CombatForm.has_value then
			msg = msg .. ' (' .. state.CombatForm.value .. ')'
		end
        
		msg = msg .. ', '
	end

	msg = msg .. 'Idle ['..state.IdleMode.value..'], Casting ['..state.CastingMode.value..']'

	add_to_chat(122, msg)
	local currentStrats = get_current_strategem_count()
	local arts
	if buffactive['Light Arts'] or buffactive['Addendum: White'] then
		arts = 'Light Arts'
	elseif buffactive['Dark Arts'] or buffactive['Addendum: Black'] then
		arts = 'Dark Arts'
	else
		arts = 'No Arts Activated'
	end
	add_to_chat(122, 'Current Available Strategems: ['..currentStrats..'], '..arts..'')
end

-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
    -- cmdParams[1] == 'scholar'
    -- cmdParams[2] == strategem to use
	if not cmdParams[2] then
		add_to_chat(123,'Error: No strategem command given.')
		return
	end

	local currentStrats = get_current_strategem_count()
	local newStratCount = currentStrats - 1
	local strategem = cmdParams[2]:lower()
	
	if currentStrats > 0 and strategem ~= 'light' and strategem ~= 'dark' then
		add_to_chat(122, '***Current Charges Available: ['..newStratCount..']***')
	elseif currentStrats == 0 then
		add_to_chat(122, '***Out of strategems! Canceling...***')
		return
	end

	if strategem == 'light' then
		if buffactive['light arts'] then
			send_command('input /ja "Addendum: White" <me>')
			add_to_chat(122, '***Current Charges Available: ['..newStratCount..']***')
		elseif buffactive['addendum: white'] then
			add_to_chat(122,'Error: Addendum: White is already active.')
		elseif buffactive['dark arts']  or buffactive['addendum: black'] then
			send_command('input /ja "Light Arts" <me>')
			add_to_chat(122, '***Changing Arts! Current Charges Available: ['..currentStrats..']***')
		else
			send_command('input /ja "Light Arts" <me>')
		end
	elseif strategem == 'dark' then
		if buffactive['dark arts'] then
			send_command('input /ja "Addendum: Black" <me>')
			add_to_chat(122, '***Current Charges Available: ['..newStratCount..']***')
        elseif buffactive['addendum: black'] then
			add_to_chat(122,'Error: Addendum: Black is already active.')
		elseif buffactive['light arts'] or buffactive['addendum: white'] then
			send_command('input /ja "Dark Arts" <me>')
			add_to_chat(122, '***Changing Arts! Current Charges Available: ['..currentStrats..']***')
		else
			send_command('input /ja "Dark Arts" <me>')
		end
	elseif buffactive['light arts'] or buffactive['addendum: white'] then
		if strategem == 'cost' then
			send_command('@input /ja Penury <me>')
		elseif strategem == 'speed' then
			send_command('@input /ja Celerity <me>')
		elseif strategem == 'aoe' then
			send_command('@input /ja Accession <me>')
		elseif strategem == 'power' then
			send_command('@input /ja Rapture <me>')
		elseif strategem == 'duration' then
			send_command('@input /ja Perpetuance <me>')
		elseif strategem == 'accuracy' then
			send_command('@input /ja Altruism <me>')
		elseif strategem == 'enmity' then
			send_command('@input /ja Tranquility <me>')
		elseif strategem == 'skillchain' then
			add_to_chat(122,'Error: Light Arts does not have a skillchain strategem.')
		elseif strategem == 'addendum' then
			send_command('@input /ja "Addendum: White" <me>')
		else
			add_to_chat(123,'')
		end
	elseif buffactive['dark arts']  or buffactive['addendum: black'] then
		if strategem == 'cost' then
			send_command('@input /ja Parsimony <me>')
		elseif strategem == 'speed' then
			send_command('@input /ja Alacrity <me>')
		elseif strategem == 'aoe' then
			send_command('@input /ja Manifestation <me>')
		elseif strategem == 'power' then
			send_command('@input /ja Ebullience <me>')
		elseif strategem == 'duration' then
			add_to_chat(122,'Error: Dark Arts does not have a duration strategem.')
		elseif strategem == 'accuracy' then
			send_command('@input /ja Focalization <me>')
		elseif strategem == 'enmity' then
			send_command('@input /ja Equanimity <me>')
		elseif strategem == 'skillchain' then
			send_command('@input /ja Immanence <me>')
		elseif strategem == 'addendum' then
			send_command('@input /ja "Addendum: Black" <me>')
		else
			add_to_chat(123,'')
		end
	else
		add_to_chat(123,'No arts has been activated yet.')
	end
end

function get_current_strategem_count()
	local allRecasts = windower.ffxi.get_ability_recasts()
	local stratsRecast = allRecasts[231]

	local maxStrategems = math.floor(player.main_job_level + 10) / 20

	local fullRechargeTime = 5*33

	local currentCharges = math.floor(maxStrategems - maxStrategems * stratsRecast / fullRechargeTime)
	
	return currentCharges
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    if player.sub_job == 'RDM' then
        set_macro_page(1, 20)
    elseif player.sub_job == 'BLM' then
        set_macro_page(1, 20)	
    elseif player.sub_job == 'WHM' then
        set_macro_page(2, 20)
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
