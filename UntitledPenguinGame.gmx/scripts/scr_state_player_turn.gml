if (instance_position(mouse_x, mouse_y,obj_test_BabyPenguin) && mouse_check_button_pressed(mb_left))
{
    var player;
    player = instance_nearest(mouse_x,mouse_y, obj_test_BabyPenguin);
    
    global.selected = player;
    
}

if (global.selected != noone && mouse_check_button_pressed(mb_right))
{
    with (global.selected)
    {
        scr_navigation(x,y,round(mouse_x/32)*32,round(mouse_y/32)*32);
    }
}
