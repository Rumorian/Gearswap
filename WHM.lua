----- Credit: Krystela of Asura | Last Update: 27 november 2016 ---->
---- .:: This was entirely created by me, it's not based off anyone's file ::. ---->
---- Always visit http://pastebin.com/u/KrystelaRose to look for possible updates ---->
---- .:: Please leave credit where it's due ::. ---->
---- .:: If you have any problem contact me via ffxiah: http://www.ffxiah.com/player/Asura/Krystela ::. ---->
 
function user_unload()
--    send_command('unbind ^f1')
--    send_command('unbind ^f2')
 --   send_command('unbind ^f8') 
 --   send_command('unbind ^f9')
 --   send_command('unbind ^f10')
 --   send_command('unbind ^f11')
 --   send_command('unbind ^f12')
end
function get_sets()

	send_command('wait 2;input /lockstyleset 15')
-- Binds for modes
--    send_command('bind ^f8 gs c C8')
--    send_command('bind ^f9 gs c C9')
--    send_command('bind ^f10 gs c C10') 
--    send_command('bind ^f11 gs c C11')
--    send_command('bind ^f12 gs c C12') 
-- Bind for accession/Divine Seal --
--    send_command('bind ^f1 input /ja accession <me>') -- Shortcut for accession (ctrl + F1) --
--    send_command('bind ^f2 input /ja "divine Seal" <me>') -- Shortcut for Divine Seal (ctrl + F2) --

-- Auto Functions --
    AutoRemedy = 'ON' -- Set to ON if you want to auto use remedies if silenced or Paralyzed, otherwise set to OFF --
    AutoDivineCaress = 'ON' -- Set to ON if you want to auto use Divine Caress for silena/Paralyna, otherwise set to OFF --
    AutoMiseryEsuna = 'ON' -- Set to ON if you want to auto use Misery for esuna if you were on Solace, otherwise set to OFF --
    AutoSolaceSacrifice = 'ON'  -- Set to ON if you want to auto use Solace for Sacrifice if you were on Misery, otherwise set to OFF --

	-- Modes --
    Enmity = 'OFF' -- Press ctrl + F8 if you want to cast Cures in Enmity Set  --
    Defense = 'OFF' -- Press CTRL + F9 for Idle being set as Defense full time instead of refresh --
    WeaponLock = 'OFF' -- Press ctrl + F10 for Weapon Lock--
    Capacity = 'OFF' -- Press Ctrl + F11 to have Capacity cape locked on while Idle, Change the cape at line 39 --
    Encumbrance = 'OFF' -- Press ctrl + F12 to be in a CCT/CP gear set for Perfidien/Plouton --

	-- Gears --
    gear = {}
    gear.Capacity_Cape = {name="Aptitude Mantle +1"} -- The cape you use for capacity --

	-- Set macro book/set --
    send_command('input /macro book 11;wait .1;input /macro set 2') -- set macro book/set here --   

	-- Area mapping -- 
    Town = S{"Ru'Lude Gardens","Upper Jeuno","Lower Jeuno","Port Jeuno","Port Windurst","Windurst Waters","Windurst Woods","Windurst Walls","Heavens Tower",
             "Port San d'Oria","Northern San d'Oria","Southern San d'Oria","Port Bastok","Bastok Markets","Bastok Mines","Metalworks","Aht Urhgan Whitegate",
             "Tavnazian Safehold","Nashmau","Selbina","Mhaura","Norg","Eastern Adoulin","Western Adoulin","Kazham","Heavens Tower"}      

			 ---- Precast ----
    sets.precast ={}
	
	
    -- Base Set -- 
    sets.precast.FC = {
		main="Bolelabunga",
		ammo="Impatiens",
		head="Vanya Hood",  --10
		neck="Baetyl Pendant", --4
		rear="Loquacious Earring", --2
		body="Inyanga Jubbah +1",  --13
		hands="Fanatic Gloves", --7
		lring="Prolix Ring", --2
		rring="Kishar Ring", --4
		waist="Witful Belt", --3
		legs="Ayanmo Cosciales +1", --5
		feet={ name="Chironic Slippers", augments={'"Fast Cast"+6','Attack+15',}}, --6
		back="Alaunus's Cape", --10
		sub="Culminus"
		} 
	--Total 66

    -- Healing Magic --    
    sets.precast.CCT = set_combine(sets.precast.FC, { -- Precast for Cures --
		main="Queller Rod",  --7
		sub="Sors Shield",
		lear="Mendicant's Earring",  --5
		hands="Kaykaus Cuffs", --5, Spell Interruption -10
		legs="Ebers Pantaloons +1", --13
		feet="Vanya Clogs"}) --15
		-- -45 Casting Time
		
    sets.precast.Lyna = set_combine(sets.precast.FC, { -- Precast for status removal spells like paralyna --
	}) 
		
 
 -- Enhancing --
    sets.precast.Enhancing = set_combine(sets.precast.FC, {waist="Siegel Sash"}) -- -8 Casting Time
 
	sets.precast['Stoneskin'] = set_combine(sets.precast.FC, {
		head="Umuthi Hat", -- -15
		Waist="Siegel Sash"  -- -8
		})  
		-- -23 Casting Time
	

    -- Elemental --
    sets.precast.Elemental = set_combine(sets.precast.FC, {})

    sets.precast['Impact'] = set_combine(sets.precast.FC, { -- Make sure to leave the head empty --
        head=empty,
        body="Twilight Cloak"})
		

		-- Job Abilities --
		sets.JA = {}
		sets.JA['Benediction'] = {}
		sets.JA['Devotion'] = {}   
		sets.JA['Afflatus Solace'] = {back="Alaunus's Cape"}
	
    -- WS sets --
    sets.WS = {
		head="Ayanmo Zucchetto +1",
		lear="Cessance Earring",
		rear="Mache Earring",
		lring="Rufescent Ring",
		neck="Fotia Gorget",
		body="Ayanmo Corazza",
		hands="Ayanmo Manopolas +1",
		back={ name="Alaunus's Cape", augments={'DEX+9','Accuracy+15 Attack+15','"Store TP"+3',}},
		waist="Fotia Belt",
		legs="Ayanmo Cosciales +1",
		feet="Ayanmo Gambieras +1"
	}
 
    sets.WS['Hexa Strike'] = set_combine(sets.precast.WS, {})
	
    sets.WS['Dagan'] = set_combine(sets.precast.WS, {})    
	
    sets.WS['Mystic Boon'] = set_combine(sets.precast.WS, {})
	
    sets.WS['Judgment'] = set_combine(sets.precast.WS, {})
	
    sets.WS['Realmrazer'] = set_combine(sets.precast.WS, {
		head="Ayanmo Zucchetto +1",
		lear="Cessance Earring",
		rear="Mache Earring",
		lring="Rufescent Ring",
		neck="Fotia Gorget",
		body="Ayanmo Corazza",
		hands="Ayanmo Manopolas +1",
		back={ name="Alaunus's Cape", augments={'DEX+9','Accuracy+15 Attack+15','"Store TP"+3',}},
		waist="Fotia Belt",
		legs="Ayanmo Cosciales +1",
		feet="Ayanmo Gambieras +1"})
	--MND
	
	
---- Midcast ----  
    sets.midcast = {}
	
    -- Base Set --
    sets.midcast.Recast = sets.precast.FC
		
    -- Healing Magic --
    sets.midcast.Cure = {
		main="Queller Rod", --Cure 10, CureII 2, HM 15, Enmity -10
		head="Kaykaus Mitra", --Cure 10, HM +15
		neck="Incanter's Torque", --HM 10
		lear="Glorious Earring", --CureII 2, Enmity -5
		rear="Domesticator's Earring", --Enmity -5
		body="Kaykaus Bliaut", --CureII 3
		hands="Kaykaus Cuffs", --Cure 10, Enmity -10
		lring="Sirona's Ring", --HM 10, MND 3
		rring="Stikini Ring", --HM 5, MND 5
		back="Solemnity Cape", --Cure 7, CMP 5
		waist="Rumination Sash", --Spell Interruption 10
		legs="Ebers Pantaloons +1", --6% Cure amount to MP
		feet="Vanya Clogs", --Cure 10
		sub="Sors Shield" --Cure 3, Enmity -5
	}  
	--Cure 50
	--CureII 7
	--HM 55, total HM 520
	--Enmity -35
		
		
		
    sets.midcast.Cure.Enmity = set_combine(sets.midcast.Cure, {}) -- When enmity is ON --  
    sets.midcast.Cure.Conserve = set_combine(sets.midcast.Cure, {}) -- When under 75% MP --
    sets.midcast.Cure.Weather = set_combine(sets.midcast.Cure, {}) -- When storm/light weather/day --
    sets.midcast.Cure.WeaponLock = set_combine(sets.midcast.Cure, {}) -- When the weapon is locked --    
		
    sets.midcast.Curaga = {
		main="Queller Rod", --Cure 10, CureII 2, HM 15
		head="Kaykaus Mitra", --Cure 10, HM +15
		neck="Mizukage-No-Kubikazari", --MND 4
		lear="Glorious Earring", --CureII 2, Enmity -5
		rear="Domesticator's Earring", --Enmity -5
		body="Kaykaus Bliaut", --CureII 3
		hands="Kaykaus Cuffs", --Cure 10, Spell Interruption 10
		lring="Sirona's Ring", --HM 10, MND 3
		rring="Stikini Ring", --HM 5, MND 5
		back="Solemnity Cape", --Cure 7, CMP 5
		waist="Rumination Sash", --MND 4
		legs="Ebers Pantaloons +1", --6% Cure amount to MP
		feet="Vanya Clogs", --Cure 10
		sub="Sors Shield" --Cure 3, Enmity -5
	}
	--MND > Skill
 
    sets.midcast.Curaga.Enmity = set_combine(sets.midcast.Curaga, {}) -- When enmity is on --
    sets.midcast.Curaga.Conserve = set_combine(sets.midcast.Curaga, {}) -- when under 75% MP --
    sets.midcast.Curaga.Weather = set_combine(sets.midcast.Curaga, { -- when storm/light weather/day --
 })
    sets.midcast.Curaga.WeaponLock = set_combine(sets.midcast.Curaga, {}) -- when weapon is locked --  
	
    sets.midcast.Lyna = set_combine(sets.midcast.Recast, { -- Normal -na spells --
		legs="Ebers Pantaloons +1"
 }) 
		
    sets.midcast['Cursna'] = set_combine(sets.midcast.Recast, { -- Specific Doom removal gears --
		head="Kaykaus Mitra",
		neck="Incanter's Torque",
		body="Eirene's Manteel",
		lring="Stikini Ring",
		rring="Sirona's Ring",
		hands="Fanatic Gloves",  --Cursna +15
		feet="Vanya Clogs",  -- Cursna +5
		waist="Gishdubar Sash", --Cursna +10
		right_ring="Ephedra Ring",  --Cursna +10
		back={ name="Alaunus's Cape", augments={'MND+11','Mag. Acc+11 /Mag. Dmg.+11','Mag. Acc.+2','"Fast Cast"+10',}}, --Cursna +25
		legs="Gyve Trousers",
		}) 
	--Cursna +65
	--Healing Magic 532
		
    sets.midcast.DC = set_combine(sets.midcast.Recast, { -- for when Divine Caress is on --
		}) 
	
	
    -- Enhancing Magic --  
    sets.midcast.Duration = set_combine(sets.midcast.Recast, { -- for Haste/Refresh/Storms --
		head="Telchine Cap",
		body="Telchine Chasuble",
		back={ name="Alaunus's Cape", augments={'MND+11','Mag. Acc+11 /Mag. Dmg.+11','Mag. Acc.+2','"Fast Cast"+10',}},
		feet="Telchine Pigaches"
}) 

    sets.midcast.Refresh = set_combine(sets.midcast.Recast, { -- for Haste/Refresh/Storms --
		head="Telchine Cap",
		body="Telchine Chasuble",
		feet="Telchine Pigaches",
		back="Grapevine Cape",
		waist="Gishdubar Sash"
}) 	
		
    sets.midcast['Stoneskin'] = set_combine(sets.midcast.Duration, {
		waist="Siegel Sash",
		legs="Haven Hose",
		neck="Nodens Gorget"}) 
	
    sets.midcast['Aquaveil'] = set_combine(sets.midcast.Duration, {})    
	
    sets.midcast.Regen = set_combine(sets.midcast.Recast, { -- Regen potency/Duration gears --
		main="Bolelabunga",
		head="Inyanga Tiara +1",
		legs={ name="Telchine Braconi", augments={'Attack+5','"Fast Cast"+3','"Regen" potency+1',}},
		back={ name="Alaunus's Cape", augments={'MND+11','Mag. Acc+11 /Mag. Dmg.+11','Mag. Acc.+2','"Fast Cast"+10',}},
		body="Telchine Chasuble",
		feet="Telchine Pigaches",
		sub="Culminus"
 })   

    sets.midcast.Enhancing = set_combine(sets.midcast.Recast, { 
		head="Befouled Crown",
		neck="Incanter's Torque",
		body="Telchine Chasuble",
		lring="Stikini Ring",
		back="Fi Follet Cape",
		legs="Vanya Slops",
		
		}) 	
 
    sets.midcast.Barspell = set_combine(sets.midcast.Enhancing, { -- For barspells/Boost, 500 skills and element + gears --
		})
 
    sets.midcast.Buffs = set_combine(sets.midcast.Duration, { -- For protectra/Shellra --      
 })
 
    sets.midcast['Auspice'] = set_combine(sets.midcast.Duration, {})  
	
    -- Divine Magic --
    sets.midcast['Repose'] = {
}

    sets.midcast.Banish = set_combine(sets.midcast.Recast, {
		main="Divinity",
		feet="Medium's Sabots", -- For banish effect --
		sub="Culminus"
})

    sets.midcast.Holy = {
		main="Divinity",
		sub="Culminus",
		ammo="Hydrocera",
		head="Inyanga Tiara +1",
		neck="Incanter's Torque",
		lear="Friomisi Earring",
		rear="Hecate's Earring",
		body="Witching Robe",
		hands="Fanatic Gloves",
		lring="Stikini Ring",
		rring="Sangoma Ring",
		back={ name="Alaunus's Cape", augments={'MND+11','Mag. Acc+11 /Mag. Dmg.+11','Mag. Acc.+2','"Fast Cast"+10',}},
		waist="Refoccilation Stone",
		legs="Gyve Trousers",
		feet="Medium's Sabots"
		} -- for dmg purposes --  
	
    sets.midcast['Flash'] = set_combine(sets.midcast.Recast, {
		head="Invanga Tiara +1",
		neck="Incanter's Torque",
		body="Vanya Robe",
		hands="Fanatic Gloves",
		lring="Stikini Ring",
		back={ name="Alaunus's Cape", augments={'MND+11','Mag. Acc+11 /Mag. Dmg.+11','Mag. Acc.+2','"Fast Cast"+10',}},
		feet="Medium's Sabots"})  

	
    -- Enfeebling Magic --
    sets.midcast.Enfeebling = { -- Full skill set for frazzle/distract/Poison --
		main="Grioavolr",
		ammo="Hydrocera",
		head="Befouled Crown",
		neck="Incanter's Torque",
		lear="Lempo Earring",
		rear="Gwati Earring",
		body="Vanya Robe",
		hands="Lurid Mitts",
		lring="Kishar Ring",
		rring="Stikini Ring",
		back={ name="Alaunus's Cape", augments={'MND+11','Mag. Acc+11 /Mag. Dmg.+11','Mag. Acc.+2','"Fast Cast"+10',}},
		waist="Rumination Sash",
		legs="Vanya Slops",
		feet="Medium's Sabots",
		sub="Enki Strap"
 } 
 
    sets.midcast.Enfeebling.Macc = set_combine(sets.midcast.Enfeebling, {}) -- For Silence/Dispel/Sleep/Break/Gravity that arent affect by full enfeeb set or effect + gears --
    sets.midcast.Enfeebling.MND = set_combine(sets.midcast.Enfeebling, {}) -- For Paralyze/Slow/Addle who's potency/macc is enhanced by MND --
    sets.midcast.Enfeebling.INT = set_combine(sets.midcast.Enfeebling, {ammo="Pemphredo Tathlum"}) -- For Blind/Bind who's Macc is enhanced by INT --

    -- Dark Magic --
    sets.midcast.Dark = set_combine(sets.midcast.Recast, {
		main="Rubicundity",
		head="Pixie Hairpin +1",
		neck="Erra Pendant",
		lear="Lempo Earring",
		rear="Gwati Earring",
		lring="Evanescence Ring",
		back={ name="Alaunus's Cape", augments={'MND+11','Mag. Acc+11 /Mag. Dmg.+11','Mag. Acc.+2','"Fast Cast"+10',}},
		waist="Fucho-No-Obi",
		sub="Culminus"
		}) -- Apir/Drain --

    sets.midcast['Stun'] = set_combine(sets.midcast.Recast, {
		main="Rubicundity",
		head="Inyanga Tiara +1",
		neck="Erra Pendant",
		lear="Lempo Earring",
		rear="Gwati Earring",
		back={ name="Alaunus's Cape", augments={'MND+11','Mag. Acc+11 /Mag. Dmg.+11','Mag. Acc.+2','"Fast Cast"+10',}},
		lring="Evanescence Ring",
		sub="Culminus"
		})

    -- Elemental --
    sets.midcast.Elemental = {
		head="Inyanga Tiara +1",
		neck="Sanctity Necklace",
		ammo="Pemphredo Tathlum",
		lear="Hecate's Earring",
		rear="Friomisi Earring",
		body="Count's Garb",
		hands="Fanatic Gloves",
		lring="Stikini Ring",
		rring="Resonance Ring",
		back={ name="Alaunus's Cape", augments={'MND+11','Mag. Acc+11 /Mag. Dmg.+11','Mag. Acc.+2','"Fast Cast"+10',}},
		wait="Tengu-No-Obi",
		legs="Gyve Trousers",
		feet="Medium's Sabots"
}

    sets.midcast['Impact'] = set_combine(sets.midcast.Elemental, {  -- Make sure to leave the head empty --
        head=empty,
        body="Twilight Cloak"})     
		
---- Aftercast ----
    sets.aftercast = {}
	
    -- Idle -- 
    sets.aftercast.Idle = { -- Your movement speed goes here, mix of PDT/Refresh --
		main="Bolelabunga",
		ammo="Staunch Tathlum",
		head="Inyanga Tiara +1",
		neck="Twilight Torque",
		lear="Hearty Earring",
		rear="Eabani Earring",
		body="Inyanga Jubbah +1",
		hands="Inyanga Dastanas +1",
		lring="Shukuyu Ring",
		rring="Defending Ring",
		back="Solemnity Cape",
		waist="Slipor Sash",
		legs="Assiduity Pants +1",
		feet="Inyanga Crackows +1",
		sub="Genmei Shield"
		}   

    sets.aftercast.Refresh = set_combine(sets.aftercast.Idle, { -- Refresh gears goes here --
		main="Bolelabunga",
		ammo="Homiliary",
		head="Befouled Crown",
		neck="Twilight Torque",
		lear="Hearty Earring",
		rear="Eabani Earring",
		body="Witching Robe",
		lring="Shukuyu Ring",
		rring="Defending Ring",
		back="Solemnity Cape",
		waist="Slipor Sash",
		legs="Assiduity Pants +1",
		feet="Medium's Sabots",
		sub="Genmei Shield"
		})      

    sets.aftercast.Defense = set_combine(sets.aftercast.Idle, { -- For when you want you idle as full time PDT --
})    

    sets.aftercast.Encumbrance = { -- For T4/T5 Vagary. It will lock you in this set --
}

    sets.aftercast.Town = set_combine(sets.aftercast.Idle, { -- For town --
		body="Councilor's Garb"})     

    sets.Resting = set_combine(sets.aftercast.Refresh, {})
	
---- Melee ----
    sets.engaged = {
    head="Ayanmo Zucchetto +1", --6
    body="Ayanmo Corazza", --4
    hands="Ayanmo Manopolas +1", --4
    legs="Ayanmo Cosciales +1", --9
    feet="Ayanmo Gambieras +1", --3
    neck="Lissome Necklace",
    waist="Windbuffet Belt +1",
    left_ear="Steelflash Earring",
    right_ear="Bladeborn Earring",
    left_ring="Petrov Ring",
	back={ name="Alaunus's Cape", augments={'DEX+9','Accuracy+15 Attack+15','"Store TP"+3',}},
    right_ring="Ilabrat Ring"
	}
	--Haste 26%
	
    sets.engaged.DualWield = { -- for dnc/nin sub --
    head="Ayanmo Zucchetto +1", --6
    body="Ayanmo Corazza", --4
    hands="Ayanmo Manopolas +1", --4
    legs="Ayanmo Cosciales +1", --9
    feet="Ayanmo Gambieras +1", --3
    neck="Lissome Necklace",
    waist="Windbuffet Belt +1",
    left_ear="Steelflash Earring",
    right_ear="Bladeborn Earring",
    left_ring="Petrov Ring",
	back={ name="Alaunus's Cape", augments={'DEX+9','Accuracy+15 Attack+15','"Store TP"+3',}},
    right_ring="Ilabrat Ring"

	}

end 

---- .::Pretarget Functions::. ---->
function pretarget(spell,action)
    -- Auto Divine Caress --
    if AutoDivineCaress == 'ON' then       
        if spell.english == 'Silena' or spell.english == 'Paralyna' then
            if windower.ffxi.get_ability_recasts()[32] < 1 and not buffactive['Amnesia'] then  
                cancel_spell()
                send_command('input /ja "Divine Caress" <me>;wait 1.7;input /ma "'..spell.english..'" '..spell.target.name)
            end
        end
    end    
    -- Auto Misery-Esuna --
    if AutoMiseryEsuna == 'ON' then    
        if spell.english == 'Esuna' and buffactive['Afflatus Solace'] and windower.ffxi.get_ability_recasts()[30] < 1  and not buffactive['Amnesia'] then  
            cancel_spell()
            send_command('input /ja "Afflatus Misery" <me>;wait 1.7;input /ma esuna <me>')
        end
    end    
    -- Auto Solace-Sacrifice --
    if AutoSolaceSacrifice == 'ON' then    
        if spell.english == 'Sacrifice' and buffactive['Afflatus Misery'] and windower.ffxi.get_ability_recasts()[29] < 1 and not buffactive['Amnesia'] then   
            cancel_spell()
            send_command('input /ja "Afflatus Solace" <me>;wait 1.7;input /ma "'..spell.english..'" '..spell.target.name)      
        end
    end
    -- Auto Remedy --
        if buffactive['Silence'] or buffactive['Paralysis'] then
            if spell.action_type == 'Magic' or spell.type == 'JobAbility' then  
                cancel_spell()
                send_command('input /item "Remedy" <me>')
            end            
        end
    end

---- .::Precast Functions::. ---->
function precast(spell)
    if spell.action_type == 'Magic' then
        -- Healing Magic --
        if string.find(spell.english, 'Cure') or string.find(spell.english, 'Cura') then
            equip(sets.precast.CCT)
        elseif spell.english == 'Poisona' or spell.english == 'Paralyna' or spell.english == 'Blindna' or spell.english == 'Silena' or spell.english == 'Viruna' or spell.english == 'Cursna' or spell.english == 'Stona' then
            equip(sets.precast.Lyna)
        -- Enhancing Magic --
        elseif spell.skill == 'Enhancing Magic' then
            equip(sets.precast.Enhancing)
        -- Elemental Magic --  
        elseif spell.skill == 'Elemental Magic' then
            if spell.english == 'Impact' then
                equip(sets.midcast[spell.english])
            else           
                equip(sets.precast.Elemental)  
            end            
        -- Everything that have a specific name set -- 
        elseif sets.precast[spell.english] then
            equip(sets.precast[spell.english])             
        -- Everything else that doesn't have a specific set for it --          
        else
            equip(sets.precast.FC)     
        end        
    -- Job Abilities --
    elseif spell.type == 'JobAbility' then
        equip(sets.JA[spell.english])
    -- Weaponskills --
    elseif spell.type == 'WeaponSkill' then
        if sets.WS[spell.english] then 
            equip(sets.WS[spell.english])
        else
            equip(sets.WS)
        end
    end    
end
---- .::Midcast Functions::. ---->
function midcast(spell)
    if spell.action_type == 'Magic' then
        -- Healing Magic --
        if string.find(spell.english,'Cure') then
            if player.mpp <51 then
                equip(sets.midcast.Cure.Conserve)
            elseif Enmity == 'ON' then 
                equip(sets.midcast.Cure.Enmity)                    
            elseif spell.element == world.weather_element or spell.element == world.day_element then
                equip(sets.midcast.Cure.Weather)       
            elseif WeaponLock == 'ON' then 
                equip(sets.midcast.Cure.WeaponLock)
            else
                equip(sets.midcast.Cure)           
            end
        elseif string.find(spell.english,'Cura') then          
            if player.mpp <51 then
                equip(sets.midcast.Curaga.Conserve)
            elseif Enmity == 'ON' then 
                equip(sets.midcast.Curaga.Enmity)      
            elseif spell.element == world.weather_element or spell.element == world.day_element then
                equip(sets.midcast.Curaga.Weather)
            elseif WeaponLock == 'ON' then     
                equip(sets.midcast.Curaga.WeaponLock)
            else               
                equip(sets.midcast.Curaga)             
            end    
        elseif spell.english == 'Poisona' or spell.english == 'Paralyna' or spell.english == 'Blindna' or spell.english == 'Silena' or spell.english == 'Viruna' or spell.english == 'Erase' or spell.english == 'Stona' then      
            if buffactive['Divine Caress'] then
                equip(sets.midcast.DC)
            else   
                equip(sets.midcast.Lyna)               
            end        
        -- Enhancing Magic --  
        elseif string.find(spell.english,'Regen') then
            equip(sets.midcast.Regen)
        elseif string.find(spell.english,'storm') or string.find(spell.english,'Haste') or string.find(spell.english,'Refresh') or string.find(spell.english,'Reraise') or string.find(spell.english,'Flurry') then
            equip(sets.midcast.Duration)               
        elseif string.find(spell.english, 'Bar') or string.find(spell.english,'Boost')then
            equip(sets.midcast.Barspell)
        elseif string.find(spell.english,'Protectra') or string.find(spell.english,'Shell') then
            equip(sets.midcast.Buffs)                  
        -- Divine Magic --
        elseif string.find(spell.english, 'Banish') then
            equip(sets.midcast.Banish)
        elseif string.find(spell.english, 'Holy') then
            equip(sets.midcast.Holy)       
        -- Enfeebling Magic --         
        elseif string.find(spell.english, 'Frazzle') or string.find(spell.english, 'Distract') or string.find(spell.english, 'Poison') then            
            equip(sets.midcast.Enfeebling)         
        elseif string.find(spell.english, 'Dispel') or string.find(spell.english, 'Silence') or string.find(spell.english, 'Sleep') or string.find(spell.english, 'Break') or string.find(spell.english, 'Gravity')  then
            equip(sets.midcast.Enfeebling.Macc)
        elseif string.find(spell.english, 'Paralyze') or string.find(spell.english, 'Slow') or string.find(spell.english, 'Addle') then
            equip(sets.midcast.Enfeebling.MND)         
        elseif string.find(spell.english, 'Blind') or spell.english == 'Bind' then
            equip(sets.midcast.Enfeebling.INT)
        -- Dark Magic --               
        elseif string.find(spell.english, 'Aspir') or string.find(spell.english, 'Drain') then
            equip(sets.midcast.Dark)
    -- Elemental Magic --
        elseif spell.skill == 'Elemental Magic' then   
            if spell.english == 'Impact' then
                equip(sets.midcast[spell.english])
            else   
                equip(sets.midcast.Elemental)
            end
        -- Everything that have a specific name set -- 
        elseif sets.midcast[spell.english] then
            equip(sets.midcast[spell.english])
        -- Everything else that doesn't have a specific set for it --                  
        else
            equip(sets.midcast.Recast)     
        end
    end        
end    
---- .::Aftercast Sets::. ---->
function aftercast(spell,action)
    status_change(player.status)
end
---- .::Status Changes Functions::. ---->
function status_change(new,tab,old)
    -- Idle --
    if new == 'Idle' then
        if Defense == 'ON' then
            equip(sets.aftercast.Defense)
        elseif Town:contains(world.zone) then  
            equip(sets.aftercast.Town)
        elseif player.mpp <75 then
            equip(sets.aftercast.Refresh)
        else
            equip(sets.aftercast.Idle)
        end
    -- Resting --  
    elseif new == 'Resting' then
        equip(sets.Resting)
    -- Engaged --      
    elseif new == 'Engaged' then
        if player.sub_job == 'DNC' or player.sub_job == 'NIN' then
            equip(sets.engaged.DualWield)  
        else   
            equip(sets.engaged)
        end
    end    
end
--- ..::Self Commands functions::.. --->
function self_command(command)
    status_change(player.status)   
    -- Enmity --
    if command == 'C8' then
        if Enmity == 'ON' then
            Enmity = 'OFF'         
            add_to_chat(123,'Enmity Set: [OFF]')
        else
            Enmity = 'ON'      
            add_to_chat(158,'Enmity Set: [ON]')
        end
    -- Defense --  
    elseif command == 'C9' then
        if Defense == 'ON' then
            Defense = 'OFF'            
            add_to_chat(123,'Defense Idle Set: [OFF]')
        else
            Defense = 'ON' 
            equip(sets.aftercast.Defense)          
            add_to_chat(158,'Defense Idle Set: [ON]')
        end
    -- Weapon Lock --      
    elseif command == 'C10' then
        if WeaponLock == 'ON' then
            WeaponLock = 'OFF'
            enable('main', 'sub' ,'range' ,'ammo')             
            add_to_chat(123,'Weapon Lock Set: [OFF]')
        else
            WeaponLock = 'ON'
            disable('main', 'sub' ,'range' ,'ammo')        
            add_to_chat(158,'Weapon Lock Set: [ON]')
        end
    -- Capacity --     
    elseif command == 'C11' then
        if Capacity == 'ON' then
            Capacity = 'OFF'
            enable('back')             
            add_to_chat(123,'Capacity Cape Set: [OFF]')
        else
            Capacity = 'ON'
            equip({back=gear.Capacity_Cape})
            disable('back')
            add_to_chat(158,'Capacity Cape Set: [ON]')
        end
    -- Encumbrance --      
    elseif command == 'C12' then
        if Encumbrance == 'ON' then
            Encumbrance = 'OFF'
            enable('main','sub','range','ammo','head','neck','ear1','ear2','body','hands','ring1','ring2','back','waist','legs','feet')            
            add_to_chat(123,'Encumbrance Set: [OFF]')
        else
            Encumbrance = 'ON'
            equip(sets.aftercast.Encumbrance)
            disable('main','sub','range','ammo','head','neck','ear1','ear2','body','hands','ring1','ring2','back','waist','legs','feet')   
            add_to_chat(158,'Encumbrance Set: [ON]')
        end
    end
end            
-- Automatically changes Idle gears if you zone in or out of town --
windower.register_event('zone change', function()
    status_change(player.status)
    if Town:contains(world.zone) then  
        equip(sets.aftercast.Town)
    else
        equip(sets.aftercast.Idle)     
    end
end)
