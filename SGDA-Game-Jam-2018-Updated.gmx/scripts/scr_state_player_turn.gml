// global.selected == noone &&  // here if i need to put this back in
if (instance_position(mouse_x, mouse_y,obj_test_lightPenguin) && mouse_check_button_released(mb_left))
{ // clicks on unit to move; shows squares
    if (global.moving == false)
    {
        var player;
        player = instance_nearest(mouse_x,mouse_y, obj_test_lightPenguin);
    
        global.selected = player;
        if (global.selected.moved == false) // prevents moving more than once
        {
            if (instance_exists(obj_move_square))
            {
                with (obj_move_square){instance_destroy();}
            }
            scr_place_move_squares();
        }
    }
}
// !instance_position(mouse_x, mouse_y, obj_test_lightPenguin) //here if i need to put this back in
else if (global.selected != noone && (!instance_position(mouse_x, mouse_y, obj_move_square)) && mouse_check_button_released(mb_left))
{ //user clicks out of range to cancel
    if (global.moving == false)
    {
        global.selected = noone;
        mp_grid_clear_rectangle(global.map_grid,0,0,640,360);
        with (obj_move_square) {instance_destroy();}
    }
}

// changed right click to left click for ease of play; moves selected player
else if (global.selected != noone && mouse_check_button_released(mb_left) && instance_position(mouse_x, mouse_y, obj_move_square))
{
    global.moving = true;
    mp_grid_clear_rectangle(global.map_grid,0,0,640,360);
    with (obj_move_square) {instance_destroy();}
    
    with (global.selected)
    {
        sprite_index = run_anim;
        scr_navigation(x,y,round(mouse_x/32)*32,round(mouse_y/32)*32,pace);
        pixel_dist -= path_get_length(global.navigate);
        moved = true;
    }
}

// stops animation upon reaching end of path
if (global.moving == true)
{
    with (global.selected)
    {
        if (path_index == -1)
        {
            sprite_index = idle_anim;
            cur_node_x = x;
            cur_node_y = y;
            global.moving = false;
            global.selected = noone;
            //global.enemy = instance_position(mouse_x,mouse_y, par_enemy);
            mp_grid_clear_rectangle(global.map_grid,0,0,640,360);
        }
    }
}

// Determines if everyone moved; if so, go to AI turn.
allMoved = true;
for (i = 0; i < instance_number(obj_test_lightPenguin); i++)
{
    if (instance_find(obj_test_lightPenguin,i).moved != true){
        allMoved = false;
    }
}
if (allMoved == true && global.moving == false)
{
    global.selected = noone;
    global.state = states.ai_turn;
    with (obj_test_lightPenguin)
    {
        // attacked = false; //dont think we need this
        moved = false;
    }
}
