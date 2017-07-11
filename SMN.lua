-------------------------------------------------------------------------------------------------------------------
-- Global settings
-------------------------------------------------------------------------------------------------------------------
 
-- You'll need the Shortcuts addon to handle the auto-targetting of the custom pact commands.
-- I really recommend if you use this, it's on a full keyboard it uses a lot of keybinds.  
-- If you are imaginative there is enough keybinds using window and app key to go around though.  
-- A supported macro keyboard also helps.  I use a Strix Tactic Pro that a windower developer kindly made work with Windower.

 
display_hud = false -- can toggle with app/menu key + 0
display_icon = true -- disable on slower machines
display_states = false -- can toggle with app/menu key + 8
--app/menu key + 9 will force the hud to refresh in case of any bugs/to trouble shoot bugs
base_icon_dir = 'C:/Program Files (x86)/Windower4/addons/Gearswap/data/icons/' --had to use absolute pathing, set this to the icon directory
hud_x_pos = 1450 --important to update these if you have a smaller screen
hud_y_pos = 630
hud_draggable = false -- really recommend leaving it false for now, after the icons were introduced it gets kind of buggy.
hud_font_size = 12
hud_icon_width = 32 --the size of icons from plugins folder, if you change the icons in icon folder you gave above, set the width height here
hud_icon_height = 32 --the size of icons from plugins folder, if you change the icons in icon folder you gave above, set the width height here
hud_transparency = 220 -- a value of 0 (invisible) to 255 (no transparency at all)
debug_gs1 = false --outputs info if you're trying to debug sets
--Whether to let organizer see these sets or not, or to leave them at home, cramped inventory means I don't need to always have all these
usemephitas = false --will equip mephitas +1 ring if you are near full mana, can be useful to do just before conduit etc
use_melee = true
use_enfeeb = true
use_player_mab = true
use_resistant = false
use_icon = false
conduit_lock = true
custom_includes = false
--shattersoul_set = true
--use_bliss = true
--use_cataclysm = true
exp_rings = false
load_debugging = false
useall_bp_reduction_gear = false --if doing salvage useful to use all the bp reduction gear you can

cureIV = false --Macros use cure3 or cure4
if player.sub_job == 'WHM' or player.sub_job == 'RDM' then
	cureIV = true
end


-------------------------------------------------------------------------------------------------------------------
-- Key bindings, and toggles/switches using mote's libraries.  Feel free to change key bindings
-- ! = alt, ^ = ctrl, @ = windows key, # = menu key/app key, 
-- putting % after any of these disables the keybind if you are typing in a chat window
-------------------------------------------------------------------------------------------------------------------
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Perp', 'Melee')
    state.CastingMode:options('Normal', 'Resistant','PDT')
    --state.IdleMode:options('Normal', 'PDT')
    state.damagetaken = M{['description']="Damage Taken",'None','MDT'}
    --state.damagetaken = M{['description']="Damage Taken",'None','DT', 'PDT', 'MDT'} --can use this line instead and cycle more damage resistance types
    state.petdamagetaken = M{['description']="Pet Damage Taken",'None','DT'}
    state.cpmode = M(false, 'CP Mode')
    state.movement = M(false, 'Movement Mode')
    state.tplock = M(false, 'Staff Lock')
    state.kclub = M(false, 'Kraken Club')
    state.impactmode = M(false, 'Impact Debuff Mode')
    state.favor = M{['description'] = 'Favor Mode'}
    state.favor:options('mpsaver','allout')
    state.burstmode = M{['description'] = 'Burst Mode'}
    state.burstmode:options('Normal','Burst')
    state.pullmode = M(false, 'Pull Mode')
    state.magiceva = M(false, 'Magic Evasion Mode')
    state.idlehealer = M(false, 'Idle Healer')
    state.bpmagicacc = M(false, 'BP Accuracy Mode')

    select_default_macro_book()

    send_command('bind #0 gs c toggle_hud')
    send_command('bind #9 gs c force_hud_refresh')
    send_command('bind #8 gs c toggle_states')
 
    send_command('alias stp_m8 gs c nukemode')
    --send_command('alias stp_m9 gs c supportmode')
    --send_command('alias stp_m10 gs c switch_dualbox_binds')

    send_command('bind !q gs c siphon')
    send_command('bind f11 gs c cycle damagetaken')
    send_command('bind !f11 gs c cycle petdamagetaken')
    send_command('bind ^f11 gs c toggle pullmode')
    send_command('bind @f11 gs c toggle magiceva')
    send_command('bind f10 gs c toggle movement')
    send_command('bind ^f10 gs c cycle favor')
    send_command('bind !f10 gs c cycle impactmode')
    send_command('bind !f9 gs c cycle burstmode')
    send_command('bind ^f9 gs c cycle bpmagicacc')
    --send_command('bind ^[ gs c cpmode')
    send_command('bind ^[ gs c toggle cpmode')
    send_command('bind ![ gs c toggle tplock')
    send_command('bind ![ gs c toggle tplock')
    send_command('bind !insert gs c toggle kclub')
    send_command('bind ^] gs c buffrotation')
 
    send_command('alias c input /targetnpc;wait 1;input /item "Rubicund Cell" <t>;wait 1;input /item "Cobalt Cell" <t>;wait 1;input /item "Phase Displacer" <t>;wait 1;input /item "Phase Displacer" <t>;wait 1;input /item "Phase Displacer" <t>;wait 1;input /item "Phase Displacer" <t>;wait 1;input /item "Phase Displacer" <t>;')
    --send_command('alias stp_m10 input /pet "Mewing Lullaby" <t>;wait 1;input /p Mewing <t>;wait 11;input /p Mili Mew :3 ')

    setup_hud() -- HUD for summoner, don't modify this line --
	set_lockstyle()
end

function set_lockstyle()
	send_command('wait 2; input /lockstyleset 02')
end
 
-------------------------------------------------------------------------------------------------------------------
-- Sets, modify these :D
-------------------------------------------------------------------------------------------------------------------
 
use_dualbox = false
-- Define sets and vars used by this job file.
function init_gear_sets()
	require('SMN-sets.lua')
end

include('SMN-lib.lua') -- Leave this line to include all the library functionality --
