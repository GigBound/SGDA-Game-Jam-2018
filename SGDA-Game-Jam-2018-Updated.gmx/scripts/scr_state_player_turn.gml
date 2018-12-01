if (instance_position(mouse_x, mouse_y,obj_test_BabyPenguin) && mouse_check_button_pressed(mb_left))
{
    var player;
    player = instance_nearest(mouse_x,mouse_y, obj_test_BabyPenguin);
    
    global.selected = player;
    
    scr_place_move_squares();
}

if (global.selected != noone && mouse_check_button_pressed(mb_right) && instance_position(mouse_x, mouse_y, obj_move_square))
{
    global.moving = true;
    with (obj_move_square) {instance_destroy();}
    with (global.selected)
    {
        scr_navigation(x,y,round(mouse_x/32)*32,round(mouse_y/32)*32);
        pixel_dist -= path_get_length(global.navigate);
    }
}

if (global.moving == true)
{
    with (global.selected)
    {
        if (path_index == -1)
        {
            cur_node_x = x;
            cur_node_y = y;
            global.moving = false;
        }
    }
}
