-------------------------------------------------------------------------------------------------------------------
-- (Original: Motenten / Modified: Arislan)
-------------------------------------------------------------------------------------------------------------------

--[[	Custom Features:
		
		Magic Burst			Toggle Magic Burst Mode  [Alt-`]
		Haste Detection		Detects current magic haste level and equips corresponding engaged set to
							optimize delay reduction (automatic)
		Haste Mode			Toggles between Haste II and Haste I recieved, used by Haste Detection [WinKey-H]
		Capacity Pts. Mode	Capacity Points Mode Toggle [WinKey-C]
		Reive Detection		Automatically equips Reive bonus gear
		Auto. Lockstyle		Automatically locks specified equipset on file load
		
		Commands:
		gs c toggle MagicBurst
		gs c toggle CP
		gs c cycle HasteMode
--]]

--------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
	mote_include_version = 2
--	AutoRemedy = 'ON' -- Set to ON if you want to auto use remedies if silenced or Paralyzed, otherwise set to OFF --
	-- Load and initialize the include file.
	include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
	state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
	state.Buff.Convergence = buffactive.Convergence or false
	state.Buff.Diffusion = buffactive.Diffusion or false
	state.Buff.Efflux = buffactive.Efflux or false
	
	state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false
	blue_magic_maps = {}
	


	-- Mappings for gear sets to use for various blue magic spells.
	-- While Str isn't listed for each, it's generally assumed as being at least
	-- moderately signficant, even for spells with other mods.

	-- Physical spells with no particular (or known) stat mods
	blue_magic_maps.Physical = S{'Bilgestorm'}

	-- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
	blue_magic_maps.PhysicalAcc = S{'Heavy Strike'}

	-- Physical spells with Str stat mod
	blue_magic_maps.PhysicalStr = S{'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
		'Empty Thrash','Quadrastrike','Saurian Slide','Sinker Drill','Spinal Cleave','Sweeping Gouge',
		'Uppercut','Vertical Cleave'}

	-- Physical spells with Dex stat mod
	blue_magic_maps.PhysicalDex = S{'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone',
		'Disseverment','Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
		'Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault','Vanity Dive'}

	-- Physical spells with Vit stat mod
	blue_magic_maps.PhysicalVit = S{'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
		'Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash'}

	-- Physical spells with Agi stat mod
	blue_magic_maps.PhysicalAgi = S{'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
		'Pinecone Bomb','Spiral Spin','Wild Oats'}

	-- Physical spells with Int stat mod
	blue_magic_maps.PhysicalInt = S{'Mandibular Bite','Queasyshroom'}

	-- Physical spells with Mnd stat mod
	blue_magic_maps.PhysicalMnd = S{'Ram Charge','Screwdriver','Tourbillion'}

	-- Physical spells with Chr stat mod
	blue_magic_maps.PhysicalChr = S{'Bludgeon'}

	-- Physical spells with HP stat mod
	blue_magic_maps.PhysicalHP = S{'Final Sting'}

	-- Magical spells with the typical Int mod
	blue_magic_maps.Magical = S{'Anvil Lightning','Blastbomb','Blazing Bound','Bomb Toss','Cursed Sphere',
		'Droning Whirlwind','Embalming Earth','Entomb','Firespit','Foul Waters','Ice Break','Leafstorm',
		'Maelstrom','Molting Plumage','Nectarous Deluge','Regurgitation','Rending Deluge','Scouring Spate',
		'Silent Storm','Spectral Floe','Subduction','Tem. Upheaval','Water Bomb'}
	
	blue_magic_maps.MagicalDark = S{'Dark Orb','Death Ray','Eyes On Me','Evryone. Grudge','Palling Salvo',
		'Tenebral Crush'}
		
	blue_magic_maps.MagicalLight = S{'Blinding Fulgor','Diffusion Ray','Radiant Breath','Rail Cannon',
		'Retinal Glare'}

	-- Magical spells with a primary Mnd mod
	blue_magic_maps.MagicalMnd = S{'Acrid Stream','Magic Hammer','Mind Blast'}

	-- Magical spells with a primary Chr mod
	blue_magic_maps.MagicalChr = S{'Mysterious Light'}

	-- Magical spells with a Vit stat mod (on top of Int)
	blue_magic_maps.MagicalVit = S{'Thermal Pulse'}

	-- Magical spells with a Dex stat mod (on top of Int)
	blue_magic_maps.MagicalDex = S{'Charged Whisker','Gates of Hades'}

	-- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
	-- Add Int for damage where available, though.
	blue_magic_maps.MagicAccuracy = S{'1000 Needles','Absolute Terror','Actinic Burst','Atra. Libations',
		'Auroral Drape','Awful Eye', 'Blank Gaze','Blistering Roar','Blood Saber','Chaotic Eye',
		'Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest','Dream Flower',
		'Enervation','Feather Tickle','Filamented Hold','Frightful Roar','Geist Wall','Hecatomb Wave',
		'Infrasonics','Jettatura','Light of Penance','Lowing','Mind Blast','Mortal Ray','MP Drainkiss',
		'Osmosis','Reaving Wind','Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast',
		'Stinking Gas','Sub-zero Smash','Venom Shell','Voracious Trunk','Yawn'}

	-- Breath-based spells
	blue_magic_maps.Breath = S{'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath','Hecatomb Wave',
		'Magnetite Cloud','Poison Breath','Self-Destruct','Thunder Breath','Vapor Spray','Wind Breath'}

	-- Stun spells
	blue_magic_maps.Stun = S{'Blitzstrahl','Frypan','Head Butt','Sudden Lunge','Tail slap','Temporal Shift',
		'Thunderbolt','Whirl of Rage'}
	
	-- Healing spells
	blue_magic_maps.Healing = S{'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral',
		'White Wind','Wild Carrot'}

	-- Buffs that depend on blue magic skill
	blue_magic_maps.SkillBasedBuff = S{'Barrier Tusk','Diamondhide','Magic Barrier','Metallic Body',
		'Plasma Charge','Pyric Bulwark','Reactor Cool','Occultation'}

	-- Other general buffs
	blue_magic_maps.Buff = S{'Amplification','Animating Wail','Battery Charge','Carcharian Verve','Cocoon',
		'Erratic Flutter','Exuviation','Fantod','Feather Barrier','Harden Shell','Memento Mori',
		'Nat. Meditation','Orcish Counterstance','Refueling','Regeneration','Saline Coat','Triumphant Roar',
		'Warm-Up','Winds of Promyvion','Zephyr Mantle'}
		
	blue_magic_maps.Refresh = S{'Battery Charge'}

	-- Spells that require Unbridled Learning to cast.
	unbridled_spells = S{'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve','Cesspool',
		'Crashing Thunder','Cruel Joke','Droning Whirlwind','Gates of Hades','Harden Shell','Mighty Guard',
		'Polar Roar','Pyric Bulwark','Tearing Gust','Thunderbolt','Tourbillion','Uproot'}

		
	state.HasteMode = M{['description']='Haste Mode', 'Haste II', 'Haste I'}
	state.CP = M(false, "Capacity Points Mode")

	determine_haste_group()
end



-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('STP', 'Normal', 'LowAcc', 'MidAcc', 'HighAcc')
	state.HybridMode:options('Normal')
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Normal', 'Acc')
	state.CastingMode:options('Normal', 'Resistant')
	state.PhysicalDefenseMode:options('PDT', 'MDT')
	state.IdleMode:options('Normal', 'DT', 'Learning')

	state.MagicBurst = M(false, 'Magic Burst')
	state.CP = M(false, "Capacity Points Mode")
	state.Logger = M(false, "Logger Addon")

	select_default_macro_book()
	set_lockstyle()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()

end

-- Define sets and vars used by this job file.
function init_gear_sets()

	-- Enmity set
	sets.Enmity = {
		}

	------------------------------------------------------------------------------------------------
	---------------------------------------- Precast Sets ------------------------------------------
	------------------------------------------------------------------------------------------------

	-- Precast sets to enhance JAs

	sets.buff['Burst Affinity'] = {feet="Hashishin Basmak +1"}
	sets.buff['Diffusion'] = {feet="Luhlaza Charuqs"}
	sets.buff['Efflux'] = {legs="Hashishin Tayt +1"}

--	sets.precast.JA['Azure Lore'] = {hands="Luhlaza Bazubands"}
	sets.precast.JA['Chain Affinity'] = {feet="Hashishin Kavuk"}
	--sets.precast.JA['Convergence'] = {head="Luh. Keffiyeh +1"}
	--sets.precast.JA['Enchainment'] = {body="Luhlaza Jubbah +1"}

	sets.precast.Waltz = {
		}

	sets.precast.FC = {
        ammo="Impatiens",
		head="Carmine Mask +1", --14
		neck="Baetyl Pendant",  --4
        body="Dread Jupon", --7
        hands="Leyline Gloves",  --8
        lring="Prolix Ring",  --2
		rring="Kishar Ring",  --5
        waist="Witful Belt",  --3
		back={ name="Rosmerta's Cape", augments={'"Fast Cast"+10',}},  --10
        legs="Psycloth Lappas", --7
		feet="Carmine Greaves", --7
		lear="Loquacious Earring",  --2
		rear="Lempo Earring"  --Conserve MP
        } --69 + Colada = 71%, Tanmogayi = 3-6%

	sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Hashishin Mintan +1"})

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {waist="Siegel Sash"})

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
		})

	
	------------------------------------------------------------------------------------------------
	------------------------------------- Weapon Skill Sets ----------------------------------------
	------------------------------------------------------------------------------------------------

	sets.precast.WS = {
	    ammo="Mantoptera Eye",
		head={ name="Herculean Helm", augments={'Accuracy+19 Attack+19','"Triple Atk."+3','Accuracy+15','Attack+4',}},
        neck="Sanctity Necklace",
        lear="Cessance Earring",
        rear="Mache Earring",
        body="Adhemar Jacket",
        hands="Despair Finger Gauntlets",
        rring="Rufescent Ring",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10',}},
		legs={ name="Herculean Trousers", augments={'Accuracy+24 Attack+24','"Triple Atk."+3','STR+5','Accuracy+11','Attack+1',}},
        waist="Windbuffet Belt +1",
		feet={ name="Rawhide Boots", augments={'STR+10','Attack+15','"Store TP"+5',}},
        lring="Ifrit Ring"}

	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		})

   sets.precast.WS['Chant du Cygne'] = {
		ammo="Jukukik Feather",
		head="Adhemar Bonnet",
		neck="Fotia Gorget",
		lear="Steelflash Earring",
		rear="Bladeborn Earring",
		body="Herculean Vest",
		hands="Adhemar Wristbands",
		rring="Epona's Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10',}},
		waist="Fotia Belt",
		feet={ name="Herculean Boots", augments={'Accuracy+22 Attack+22','Crit. hit damage +3%','DEX+3','Attack+9',}},
		legs={ name="Herculean Trousers", augments={'Accuracy+17','Crit. hit damage +4%','DEX+7','Attack+13',}},
		lring="Ilabrat Ring"}

	sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS['Chant du Cygne'], {
		})

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
        head="Adhemar Bonnet",
		legs="Jhakri Slops +2",
        waist="Dynamic Belt +1"})

	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {
		})

	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
        head="Carmine Mask +1",
		neck="Fotia Gorget",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +1",
        lring="Epona's Ring",
        waist="Fotia Belt",
		feet="Jhakri Pigaches +1",
        legs="Carmine Cuisses +1"})  --MND

	sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS['Requiescat'], {
		})  --MND

	sets.precast.WS['Expiacion'] = set_combine(sets.precast.WS['Savage Blade'], {
		})

	sets.precast.WS['Expiacion'].Acc = set_combine(sets.precast.WS['Expiacion'], {
		})

	sets.precast.WS['Sanguine Blade'] = {
        ammo="Mantoptera Eye",
        head="Jhakri Coronal +1",
        neck="Sanctity Necklace",
        lear="Friomisi Earring",
        rear="Hecate's Earring",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +1",
        lring="Vertigo Ring",
        rring="Locus Ring",
        back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
        waist="Latria Sash",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +1"}

	sets.precast.WS['True Strike']= set_combine(sets.precast.WS['Savage Blade'], {})

	sets.precast.WS['True Strike'].Acc = sets.precast.WS['Savage Blade'].Acc

	sets.precast.WS['Judgment'] = sets.precast.WS['True Strike']

	sets.precast.WS['Judgment'].Acc = sets.precast.WS['True Strike'].Acc

	sets.precast.WS['Black Halo'] = sets.precast.WS['True Strike']

	sets.precast.WS['Black Halo'].Acc = sets.precast.WS['True Strike'].Acc

	sets.precast.WS['Realmrazer'] = sets.precast.WS['Requiescat']

	sets.precast.WS['Realmrazer'].Acc = sets.precast.WS['Requiescat'].Acc
	
	sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS['Sanguine Blade'], {

		})

	------------------------------------------------------------------------------------------------
	---------------------------------------- Midcast Sets ------------------------------------------
	------------------------------------------------------------------------------------------------

	sets.midcast.FastRecast = sets.precast.FC

	sets.midcast.SpellInterrupt = {
        ammo="Impatiens",
		head="Carmine Mask +1", --14
		neck="Baetyl Pendant",  --4
        body="Dread Jupon", --7
        hands="Leyline Gloves",  --8
        lring="Prolix Ring",  --2
		rring="Rahab Ring",  --2
        waist="Witful Belt",  --3
		back={ name="Rosmerta's Cape", augments={'"Fast Cast"+10',}},  --10
        legs="Psycloth Lappas", --7
		feet="Carmine Greaves", --7
		lear="Loquacious Earring",  --2
		rear="Lempo Earring"  --Conserve MP
        } --66
		
	sets.midcast['Blue Magic'] = {
		ammo="Mavi Tathlum",
        head="Carmine Mask +1",
        neck="Baetyl Pendant",
		lear="Loquacious Earring",
		rear="Lempo Earring", --Conserve MP
        body="Assimilator's Jubbah +1",
        hands="Rawhide Gloves",
        lring="Kishar Ring",
		rring="Stikini Ring",
		back="Cornflower Cape",
		waist="Witful Belt",
        legs="Hashishin Tayt +1",
		feet="Carmine Greaves"}
		--553 Blue Magic Skill

	sets.midcast['Blue Magic'].Physical = {
		ammo="Mavi Tathlum",
        head="Carmine Mask +1",
        neck="Incanter's Torque",
        body="Jhakri Robe +2",
        hands="Rawhide Gloves",
        lring="Etana Ring",
		rring="Stikini Ring",
		back="Cornflower Cape",
		waist="Rumination Sash",
        legs="Hashishin Tayt +1",
		feet="Hashishin Basmak +1"}

	sets.midcast['Blue Magic'].PhysicalAcc = set_combine(sets.midcast['Blue Magic'].Physical, {
		})

	sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical, {
		rring="Shukuyu Ring"})

	sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical, {
        ammo="Jukukik Feather",
		body="Adhemar Jacket",
		head="Adhemar Bonnet",
		hands="Adhemar Wristbands",
		lear="Mache Earring",
		rear="Lempo Earring",
		lring="Ramuh Ring",
		rring="Ilabrat Ring",
		legs={ name="Herculean Trousers", augments={'Accuracy+17','Crit. hit damage +4%','DEX+7','Attack+13',}},
		feet={ name="Herculean Boots", augments={'Accuracy+22 Attack+22','Crit. hit damage +3%','DEX+3','Attack+9',}},
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10',}},
		waist="Latria Sash"})

	sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical, {
        hands="Despair Finger Gauntlets",
		head="Assimilator's Keffiyeh +2",
		legs="Gyve Trousers",
		waist="Latria Sash",
		body="Dread Jupon",
		feet="Carmine Greaves"})

	sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical, {
        head="Assimilator's Keffiyeh +2",
		feet={ name="Herculean Boots", augments={'Accuracy+19 Attack+19','"Triple Atk."+4','CHR+5','Accuracy+15',}},
		hands="Despair Finger Gauntlets",
		lring="Ilabrat Ring"})

	sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical, {
        hands="Amalric Gages",
		ammo="Ghastly Tathlum +1",
		head="Assimilator's Keffiyeh +2",
		waist="Latria Sash",
		body="Hashishin Mintan +1",
		lring="Stikini Ring",
		rring="Vertigo Ring",
		legs="Amalric Slops",
		back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
		feet="Hashishin Basmak +1"})

	sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical, {
        head="Assimilator's Keffiyeh +2",
		body="Hashishin Mintan +1",
        lring="Rufescent Ring",
		rring="Stikini Ring",
        legs="Carmine Cuisses +1"})
	
	sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical, {
	    head="Telchine Cap",
		rear="Handler's Earring +1",
		body="Hashishin Mintan +1",
		hands="Despair Finger Gauntlets",
		legs="Gyve Trousers"})

	sets.midcast['Blue Magic'].Magical = {
        ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +1",
        neck="Baetyl Pendant",
        lear="Friomisi Earring",
        rear="Choleric Earring",
        body="Jhakri Robe +2",
        hands="Amalric Gages",
        lring="Stikini Ring",
        rring="Kishar Ring",
        back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
        waist="Dynamic Belt +1",
        legs="Jhakri Slops +2",
        feet="Hashishin Basmak +1"}

	sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical, {
		neck="Erra Pendant"
		})

	sets.midcast['Blue Magic'].MagicalDark = set_combine(sets.midcast['Blue Magic'].Magical, {
		head="Pixie Hairpin +1",
		neck="Erra Pendant"})

	sets.midcast['Blue Magic'].MagicalLight = set_combine(sets.midcast['Blue Magic'].Magical, {
		neck="Erra Pendant"})

	sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical, {
		neck="Erra Pendant"})

	sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical, {
		neck="Erra Pendant",
		lring="Ilabrat Ring"})

	sets.midcast['Blue Magic'].MagicalVit = sets.midcast['Blue Magic'].Magical
	sets.midcast['Blue Magic'].MagicalChr = sets.midcast['Blue Magic'].Magical

	sets.midcast['Blue Magic'].MagicAccuracy = {
		ammo="Pemphredo Tathlum",
		head="Carmine Mask +1",
        neck="Erra Pendant",
        body="Jhakri Robe +2",
        hands="Rawhide Gloves",
        lring="Etana Ring",
		rring="Stikini Ring",
		back="Cornflower Cape",
		waist="Rumination Sash",
        legs="Psycloth Lappas",
		feet="Jhakri Pigaches +1"}

	sets.midcast['Blue Magic'].Breath = set_combine(sets.midcast['Blue Magic'].Magical, {
	    ammo="Mavi Tathlum",
		neck="Erra Pendant"
        })

	sets.midcast['Blue Magic'].Stun = sets.midcast['Blue Magic'].MagicAccuracy

	sets.midcast['Blue Magic'].Healing = {
        head="Carmine Mask +1",
		neck="Incanter's Torque",
		lear="Mendicant's Earring",  --5%
        body="Vrikodara Jupon",  --10%
		hands="Telchine Gloves", --10%
        lring="Sirona's Ring",
        rring="Stikini Ring",
        back="Solemnity Cape",  --7%
        waist="Latria Sash",
		feet="Medium's Sabots",  --9%
        legs="Carmine Cuisses +1"}
		--Total 41%

	sets.midcast['Blue Magic'].HealingSelf = set_combine(sets.midcast['Blue Magic'].Healing, {
        waist="Gishdubar Sash"})

	--Spells that don't need blue magic skill, use fast cast set for these	
	sets.midcast['Blue Magic'].Buff = {
	    ammo="Impatiens",
		head="Carmine Mask +1", --14
		neck="Baetyl Pendant",  --4
        body="Dread Jupon", --7
        hands="Leyline Gloves",  --8
        lring="Prolix Ring",  --2
		rring="Rahab Ring",  --2
        waist="Witful Belt",  --3
		back={ name="Rosmerta's Cape", augments={'"Fast Cast"+10',}},  --10
        legs="Psycloth Lappas", --7
		feet="Carmine Greaves", --7
		lear="Loquacious Earring",  --2
		rear="Lempo Earring"  --Conserve MP
        } --66

	sets.midcast['Blue Magic'].SkillBasedBuff = sets.midcast['Blue Magic']
	--553 Blue Magic Skill
	
	sets.midcast['Blue Magic']['Occultation'] = sets.midcast['Blue Magic']


	sets.midcast['Blue Magic']['Carcharian Verve'] = set_combine(sets.midcast['Blue Magic'].Buff, {
		})

	sets.midcast['Blue Magic']['Battery Charge'] = set_combine(sets.midcast['Blue Magic'].Buff, {
		waist="Gishdubar Sash",
		back="Grapevine Cape"})
		
	sets.midcast['Enhancing Magic'] = {
		head="Carmine Mask +1",
		neck="Incanter's Torque",
		body="Telchine Chasuble",
		hands="Leyline Gloves",
		lring="Kishar Ring",
		rring="Stikini Ring",
		back="Fi Follet Cape",
		waist="Latria Sash",
		legs="Carmine Cuisses +1",
		feet="Telchine Pigaches"
		}

	sets.midcast.EnhancingDuration = set_combine(sets.midcast['Enhancing Magic'], {
		})

	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {waist="Gishdubar Sash",back="Grapevine Cape"})

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {})

	sets.midcast.Protect = {}

	sets.midcast.Protectra = sets.midcast.Protect

	sets.midcast.Shell = sets.midcast.Protect

	sets.midcast.Shellra = sets.midcast.Protect

	sets.midcast.Utsusemi = sets.midcast.SpellInterrupt


	------------------------------------------------------------------------------------------------
	----------------------------------------- Idle Sets --------------------------------------------
	------------------------------------------------------------------------------------------------

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

	sets.idle = {
		ammo="Amar Cluster",
        head="Rawhide Mask",
		body="Jhakri Robe +2",
		neck="Twilight Torque",
        hands="Herculean Gloves",
        lring="Ilabrat Ring",
		rring="Defending Ring",
		waist="Fucho-No-Obi",
		feet="Herculean Boots",
		legs="Carmine Cuisses +1",
		lear="Hearty Earring",
		rear="Eabani Earring",
		back="Solemnity Cape"}

	sets.idle.DT = set_combine(sets.idle, {
		})

	sets.idle.Town = set_combine(sets.idle, {
		})

	sets.idle.Weak = sets.idle.DT

	sets.idle.Learning = set_combine(sets.idle, sets.Learning)
	
	-- Resting sets
	sets.resting = sets.idle

	------------------------------------------------------------------------------------------------
	---------------------------------------- Defense Sets ------------------------------------------
	------------------------------------------------------------------------------------------------

	sets.defense.PDT = sets.idle.DT

	sets.defense.MDT = sets.idle.DT

	------------------------------------------------------------------------------------------------
	---------------------------------------- Engaged Sets ------------------------------------------
	------------------------------------------------------------------------------------------------

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- * DW6: +37%
	-- * DW5: +35%
	-- * DW4: +30%
	-- * DW3: +25% (NIN Subjob)
	-- * DW2: +15% (DNC Subjob)
	-- * DW1: +10%
	
	-- No Magic Haste (74% DW to cap)
	sets.engaged = {
	    ammo="Ginsen",
        head={ name="Herculean Helm", augments={'Accuracy+19 Attack+19','"Triple Atk."+3','Accuracy+15','Attack+4',}},
        neck="Lissome Necklace",
        lear="Suppanomimi",
        rear="Cessance Earring",
        body="Adhemar Jacket",
        lring="Epona's Ring",
        waist="Windbuffet Belt +1",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10',}},
		legs={ name="Herculean Trousers", augments={'Accuracy+24 Attack+24','"Triple Atk."+3','STR+5','Accuracy+11','Attack+1',}},
		feet={ name="Herculean Boots", augments={'Accuracy+19 Attack+19','"Triple Atk."+4','CHR+5','Accuracy+15',}},
        hands="Adhemar Wristbands",
		rring="Ilabrat Ring"}
		
	sets.engaged.LowAcc = set_combine(sets.engaged, {
		})

	sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
		})

	sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
        ammo="Mantoptera Eye",
        head={ name="Herculean Helm", augments={'Accuracy+19 Attack+19','"Triple Atk."+3','Accuracy+15','Attack+4',}},
        neck="Lissome Necklace",
        lear="Cessance Earring",
        rear="Mache Earring",
        body="Herculean Vest",
        hands="Herculean Gloves",
        rring="Etana Ring",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10',}},
        waist="Dynamic Belt +1",
		legs="Carmine Cuisses +1",
		feet={ name="Herculean Boots", augments={'Accuracy+19 Attack+19','"Triple Atk."+4','CHR+5','Accuracy+15',}},
        lring="Portus Annulet"})

	sets.engaged.STP = set_combine(sets.engaged, {
		})

	-- 15% Magic Haste (67% DW to cap)
	sets.engaged.LowHaste = {
	    ammo="Ginsen",
        head={ name="Herculean Helm", augments={'Accuracy+19 Attack+19','"Triple Atk."+3','Accuracy+15','Attack+4',}},
        neck="Lissome Necklace",
        lear="Suppanomimi",
        rear="Cessance Earring",
        body="Adhemar Jacket",
        lring="Epona's Ring",
        waist="Windbuffet Belt +1",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10',}},
		legs={ name="Herculean Trousers", augments={'Accuracy+24 Attack+24','"Triple Atk."+3','STR+5','Accuracy+11','Attack+1',}},
		feet={ name="Herculean Boots", augments={'Accuracy+19 Attack+19','"Triple Atk."+4','CHR+5','Accuracy+15',}},
        hands="Adhemar Wristbands",
		rring="Petrov Ring"}

	sets.engaged.LowHaste.LowAcc = set_combine(sets.engaged.LowHaste, {
		})

	sets.engaged.LowHaste.MidAcc = set_combine(sets.engaged.LowHaste.LowAcc, {
		})

	sets.engaged.LowHaste.HighAcc = set_combine(sets.engaged.LowHaste.MidAcc, {
        ammo="Mantoptera Eye",
        rear="Mache Earring",
        body="Herculean Vest",
        hands="Herculean Gloves",
        rring="Etana Ring",
        waist="Dynamic Belt +1",
		legs="Carmine Cuisses +1",
        lring="Portus Annulet"})

	sets.engaged.LowHaste.STP = set_combine(sets.engaged.LowHaste, {
		})

	-- 30% Magic Haste (56% DW to cap)
	sets.engaged.MidHaste = {
	    ammo="Ginsen",
        head={ name="Herculean Helm", augments={'Accuracy+19 Attack+19','"Triple Atk."+3','Accuracy+15','Attack+4',}},
        neck="Lissome Necklace",
        lear="Suppanomimi",
        rear="Cessance Earring",
        body="Adhemar Jacket",
        lring="Epona's Ring",
        waist="Windbuffet Belt +1",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10',}},
		legs={ name="Herculean Trousers", augments={'Accuracy+24 Attack+24','"Triple Atk."+3','STR+5','Accuracy+11','Attack+1',}},
		feet={ name="Herculean Boots", augments={'Accuracy+19 Attack+19','"Triple Atk."+4','CHR+5','Accuracy+15',}},
        hands="Adhemar Wristbands",
		rring="Petrov Ring"}

	sets.engaged.MidHaste.LowAcc = set_combine(sets.engaged.MidHaste, {
		})

	sets.engaged.MidHaste.MidAcc = set_combine(sets.engaged.MidHaste.LowAcc, {
		})

	sets.engaged.MidHaste.HighAcc = set_combine(sets.engaged.MidHaste.MidAcc, {
        ammo="Mantoptera Eye",
        rear="Mache Earring",
        body="Herculean Vest",
        hands="Herculean Gloves",
        rring="Etana Ring",
        waist="Dynamic Belt +1",
		legs="Carmine Cuisses +1",
        lring="Portus Annulet"})

	sets.engaged.MidHaste.STP = set_combine(sets.engaged.MidHaste, {
		})
		
	-- 35% Magic Haste (51% DW to cap)
	sets.engaged.HighHaste = {
	    ammo="Ginsen",
        head={ name="Herculean Helm", augments={'Accuracy+19 Attack+19','"Triple Atk."+3','Accuracy+15','Attack+4',}},
        neck="Lissome Necklace",
        lear="Suppanomimi",
        rear="Cessance Earring",
        body="Adhemar Jacket",
        lring="Epona's Ring",
        waist="Windbuffet Belt +1",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10',}},
		legs={ name="Herculean Trousers", augments={'Accuracy+24 Attack+24','"Triple Atk."+3','STR+5','Accuracy+11','Attack+1',}},
		feet={ name="Herculean Boots", augments={'Accuracy+19 Attack+19','"Triple Atk."+4','CHR+5','Accuracy+15',}},
        hands="Adhemar Wristbands",
		rring="Petrov Ring"}

	sets.engaged.HighHaste.LowAcc = set_combine(sets.engaged.HighHaste, {
		})

	sets.engaged.HighHaste.MidAcc = set_combine(sets.engaged.HighHaste.LowAcc, {
		})

	sets.engaged.HighHaste.HighAcc = set_combine(sets.engaged.HighHaste.MidAcc, {
        ammo="Mantoptera Eye",
        rear="Mache Earring",
        body="Herculean Vest",
        hands="Herculean Gloves",
        rring="Etana Ring",
        waist="Dynamic Belt +1",
		legs="Carmine Cuisses +1",
        lring="Portus Annulet"})

	sets.engaged.HighHaste.STP = set_combine(sets.engaged.HighHaste, {
		})

	-- 47% Magic Haste (36% DW to cap)
	sets.engaged.MaxHaste = {
        ammo="Mantoptera Eye",
        head={ name="Herculean Helm", augments={'Accuracy+19 Attack+19','"Triple Atk."+3','Accuracy+15','Attack+4',}},
        neck="Lissome Necklace",
        lear="Cessance Earring",
        rear="Mache Earring",
        body="Herculean Vest",
        hands="Herculean Gloves",
        rring="Etana Ring",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10',}},
        waist="Dynamic Belt +1",
		legs="Carmine Cuisses +1",
		feet={ name="Herculean Boots", augments={'Accuracy+19 Attack+19','"Triple Atk."+4','CHR+5','Accuracy+15',}},
        lring="Portus Annulet"}

	sets.engaged.MaxHaste.LowAcc = set_combine(sets.engaged.MaxHaste, {
		})

	sets.engaged.MaxHaste.MidAcc = set_combine(sets.engaged.MaxHaste.LowAcc, {
		})

	sets.engaged.MaxHaste.HighAcc = set_combine(sets.engaged.MaxHaste.MidAcc, {
        ammo="Mantoptera Eye",
        rear="Mache Earring",
        body="Herculean Vest",
        hands="Herculean Gloves",
        rring="Etana Ring",
        waist="Dynamic Belt +1",
		legs="Carmine Cuisses +1",
        lring="Portus Annulet"})

	sets.engaged.MaxHaste.STP = set_combine(sets.engaged.MaxHaste, {
		})

	------------------------------------------------------------------------------------------------
	---------------------------------------- Special Sets ------------------------------------------
	------------------------------------------------------------------------------------------------

	sets.magic_burst = {
        ammo="Ghastly Tathlum +1",
		head="Jhakri Coronal +1",
        neck="Baetyl Pendant",
        lear="Friomisi Earring",
        rear="Choleric Earring",
        body="Jhakri Robe +2",
        hands="Amalric Gages",
        lring="Stikini Ring",
        rring="Locus Ring",
        back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
        waist="Latria Sash",
        legs="Amalric Slops",
        feet="Jhakri Pigaches +1"}
		

	sets.Kiting = {legs="Carmine Cuisses +1"}
	
	sets.Learning = {
        ammo="Mavi Tathlum",
        hands="Mavi Bazubands",
        back="Cornflower Cape"
        }
	
	sets.latent_refresh = {waist="Fucho-no-obi"}

	sets.buff.Doom = {waist="Gishdubar Sash"}

	sets.CP = {}
	sets.Reive = {}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.


function pretarget(spell,action) 
 if buffactive['Silence'] or buffactive['Paralysis'] then
            if spell.action_type == 'Magic' or spell.type == 'JobAbility' then  
                cancel_spell()
                send_command('input /item "Remedy" <me>')
            end            
        end
    end
	

function job_precast(spell, action, spellMap, eventArgs)
	if unbridled_spells:contains(spell.english) and not state.Buff['Unbridled Learning'] then
		eventArgs.cancel = true
		windower.send_command('@input /ja "Unbridled Learning" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	-- Add enhancement gear for Chain Affinity, etc.
	if spell.skill == 'Blue Magic' then
		for buff,active in pairs(state.Buff) do
			if active and sets.buff[buff] then
				equip(sets.buff[buff])
			end
		end
		if spellMap == 'Healing' and spell.target.type == 'SELF' then
			equip(sets.midcast['Blue Magic'].HealingSelf)
		end
	end

	if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) then
		equip(sets.midcast.EnhancingDuration)
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)
	-- If we gain or lose any haste buffs, adjust which gear set we target.
	if S{'haste', 'march', 'mighty guard', 'embrava', 'haste samba', 'geo-haste', 'indi-haste'}:contains(buff:lower()) then
		determine_haste_group()
		if not midaction() then
			handle_equipping_gear(player.status)
		end
	end

	if buffactive['Reive Mark'] then
		equip(sets.Reive)
		disable('neck')
	else
		enable('neck')
	end

	if buff == "doom" then
		if gain then		   
			equip(sets.buff.Doom)
			send_command('@input /echo Doomed.')
			disable('ring1','ring2','waist')
		else
			enable('ring1','ring2','waist')
			handle_equipping_gear(player.status)
		end
	end

end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
	if spell.skill == 'Blue Magic' then
		for category,spell_list in pairs(blue_magic_maps) do
			if spell_list:contains(spell.english) then
				return category
			end
		end
	end
end

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

    -- Auto Remedy --
--function pretarget(spell,action)
 --       if buffactive['Silence'] or buffactive['Paralysis'] then
 --           if spell.action_type == 'Magic' or spell.type == 'JobAbility' then  
 --               cancel_spell()
 --               send_command('input /item "Remedy" <me>')
 --           end            
--        end
--	end
	
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	if player.mpp < 51 then
		idleSet = set_combine(idleSet, sets.latent_refresh)
	end
	if state.CP.current == 'on' then
		equip(sets.CP)
		disable('back')
	else
		enable('back')
	end
	if state.IdleMode.value == 'Learning' then
		equip(sets.Learning)
		disable('hands')
	else
		enable('hands')
	end
	
	return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
	determine_haste_group()
	update_active_abilities()
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
	local msg = '[ Melee'
	
	if state.CombatForm.has_value then
		msg = msg .. ' (' .. state.CombatForm.value .. ')'
	end
	
	msg = msg .. ': '
	
	msg = msg .. state.OffenseMode.value
	if state.HybridMode.value ~= 'Normal' then
		msg = msg .. '/' .. state.HybridMode.value
	end
	msg = msg .. ' ][ WS: ' .. state.WeaponskillMode.value .. ' ]'
	
	if state.DefenseMode.value ~= 'None' then
		msg = msg .. '[ Defense: ' .. state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ' ]'
	end

	if state.IdleMode.value ~= 'None' then
		msg = msg .. '[ Idle: ' .. state.IdleMode.value .. ' ]'
	end

	msg = msg .. '[ ' .. state.HasteMode.value .. ' ]'
	
	if state.Kiting.value then
		msg = msg .. '[ Kiting Mode: ON ]'
	end

	add_to_chat(060, msg)

	eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()

	-- Gearswap can't detect the difference between Haste I and Haste II
	-- so use winkey-H to manually set Haste spell level.

	-- Haste (buffactive[33]) - 15%
	-- Haste II (buffactive[33]) - 30%
	-- Haste Samba - 5%/10%
	-- Victory March +0/+3/+4/+5	9.4%/14%/15.6%/17.1%
	-- Advancing March +0/+3/+4/+5  6.3%/10.9%/12.5%/14% 
	-- Embrava - 30%
	-- Mighty Guard (buffactive[604]) - 15%
	-- Geo-Haste (buffactive[580]) - 40%

	classes.CustomMeleeGroups:clear()

	if state.HasteMode.value == 'Haste II' then
		if(((buffactive[33] or buffactive[580] or buffactive.embrava) and (buffactive.march or buffactive[604])) or
			(buffactive[33] and (buffactive[580] or buffactive.embrava)) or
			(buffactive.march == 2 and buffactive[604])) then
			--add_to_chat(215, '---------- <<<< | Magic Haste Level: 43% | >>>> ----------')
			classes.CustomMeleeGroups:append('MaxHaste')
		elseif ((buffactive[33] or buffactive.march == 2 or buffactive[580]) and buffactive['haste samba']) then
			--add_to_chat(004, '---------- <<<< | Magic Haste Level: 35% | >>>> ----------')
			classes.CustomMeleeGroups:append('HighHaste')
		elseif ((buffactive[580] or buffactive[33] or buffactive.march == 2) or
			(buffactive.march == 1 and buffactive[604])) then
			--add_to_chat(008, '---------- <<<< | Magic Haste Level: 30% | >>>> ----------')
			classes.CustomMeleeGroups:append('MidHaste')
		elseif (buffactive.march == 1 or buffactive[604]) then
			--add_to_chat(007, '---------- <<<< | Magic Haste Level: 15% | >>>> ----------')
			classes.CustomMeleeGroups:append('LowHaste')
		end
	else
		if (buffactive[580] and ( buffactive.march or buffactive[33] or buffactive.embrava or buffactive[604]) ) or
			(buffactive.embrava and (buffactive.march or buffactive[33] or buffactive[604])) or
			(buffactive.march == 2 and (buffactive[33] or buffactive[604])) or
			(buffactive[33] and buffactive[604] and buffactive.march ) then
			--add_to_chat(215, '---------- <<<< | Magic Haste Level: 43% | >>>> ----------')
			classes.CustomMeleeGroups:append('MaxHaste')
		elseif ((buffactive[604] or buffactive[33]) and buffactive['haste samba'] and buffactive.march == 1) or
			(buffactive.march == 2 and buffactive['haste samba']) or
			(buffactive[580] and buffactive['haste samba'] ) then
			--add_to_chat(004, '---------- <<<< | Magic Haste Level: 35% | >>>> ----------')
			classes.CustomMeleeGroups:append('HighHaste')
		elseif (buffactive.march == 2 ) or
			((buffactive[33] or buffactive[604]) and buffactive.march == 1 ) or  -- MG or haste + 1 march
			(buffactive[580] ) or  -- geo haste
			(buffactive[33] and buffactive[604]) then
			--add_to_chat(008, '---------- <<<< | Magic Haste Level: 30% | >>>> ----------')
			classes.CustomMeleeGroups:append('MidHaste')
		elseif buffactive[33] or buffactive[604] or buffactive.march == 1 then
			--add_to_chat(007, '---------- <<<< | Magic Haste Level: 15% | >>>> ----------')
			classes.CustomMeleeGroups:append('LowHaste')
		end
	end
end

function update_active_abilities()
	state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
	state.Buff['Efflux'] = buffactive['Efflux'] or false
	state.Buff['Diffusion'] = buffactive['Diffusion'] or false
end

-- State buff checks that will equip buff gear and mark the event as handled.
function apply_ability_bonuses(spell, action, spellMap)
	if state.Buff['Burst Affinity'] and (spellMap == 'Magical' or spellMap == 'MagicalLight' or spellMap == 'MagicalDark' or spellMap == 'Breath') then
		if state.MagicBurst.value then
			equip(sets.magic_burst)
		end
		equip(sets.buff['Burst Affinity'])
	end
	if state.Buff.Efflux and spellMap == 'Physical' then
		equip(sets.buff['Efflux'])
	end
	if state.Buff.Diffusion and (spellMap == 'Buffs' or spellMap == 'BlueSkill') then
		equip(sets.buff['Diffusion'])
	end

	if state.Buff['Burst Affinity'] then equip (sets.buff['Burst Affinity']) end
	if state.Buff['Efflux'] then equip (sets.buff['Efflux']) end
	if state.Buff['Diffusion'] then equip (sets.buff['Diffusion']) end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(2, 4)
	elseif player.sub_job == 'RDM' then
		set_macro_page(2, 4)
	else
		set_macro_page(2, 4)
	end
end

function set_lockstyle()
	send_command('wait 2; input /lockstyleset 18')
end
