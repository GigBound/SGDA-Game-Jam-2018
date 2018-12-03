if (instance_number(obj_test_lightPenguin) < 1) {global.state = states.fail_state;}
// lightPenguin is the parent for penguins

if (global.ai_selected == noone)
{
    if (global.ai_activated == false)
    {
        // uses ai_id to determine which one goes when
        ai_active = instance_number(par_enemy) - global.ai_id;
        global.ai_selected = instance_find(par_enemy, ai_active);
        
        scr_place_move_squares_ai();
        global.ai_activated = true;
    }
}

with (global.ai_selected)
{
    if (global.ai_activated == true)
    {
        nearest_target = instance_nearest(x,y,obj_test_lightPenguin);
        nearest_move = instance_nearest(nearest_target.x,nearest_target.y,obj_move_square_ai);
        nearest_attack = instance_nearest(x,y,obj_attack_square);
        
        if (moved == false)
        {
            sprite_index = run_anim;
            scr_navigation(x,y,round(nearest_move.x/32)*32, round(nearest_move.y/32)*32,pace);
        }
        if (path_index == -1) // end of path
        {
            if (moved == false) {sprite_index = idle_anim;}
            moved = true;
            if (instance_exists(obj_attack_square)) { global.enemy = instance_position(nearest_attack.x, nearest_attack.y, obj_test_lightPenguin); }
            if (global.enemy != noone) { scr_melee_attack_ai(); }
            else { attacked = true; }
            with (obj_move_square_ai) {instance_destroy();}
            cur_node_x = round(x/32)*32;
            cur_node_y = round(y/32)*32;
            mp_grid_clear_rectangle(global.map_grid,0,0,640,360);
            
            // how we get to the next enemy
            if (attacked == true && moved == true)
            {
                global.enemy = noone;
                global.ai_id += 1;
                global.ai_selected = noone;
                global.ai_activated = false;
            }
        }
    } // tutorial puts type 2 here, which is only for ranged units (we dont use them)
}

// when all enemies have moved switch turns to player
if (global.ai_id > instance_number(par_enemy))
{
    global.state = states.p_turn;
    global.ai_selected = noone;
    global.ai_id = 1;
    with (obj_test_lightPenguin)
    {
        pixel_dist = orig_pixel_dist;
    }
    with (par_enemy)
    {
        attacked = false;
        moved = false;
        acquired_targets = false;
    }
}
