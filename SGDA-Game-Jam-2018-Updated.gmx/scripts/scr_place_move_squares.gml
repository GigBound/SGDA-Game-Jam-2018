mp_grid_clear_rectangle(global.map_grid,0,0,640,360);
with (obj_test_lightPenguin)
{
    if (self.id != global.selected.id) {mp_grid_add_rectangle(global.map_grid,x,y,x,y);}
}
with (par_enemy)
{
    mp_grid_add_rectangle(global.map_grid,x,y,x,y);
}

for (i = 0; i < 18; i++;)
{
    var i_x;
    i_x = 32 + 32*i;
    
    if (mp_grid_path(global.map_grid, global.navigate, global.selected.cur_node_x, global.selected.cur_node_y, i_x, row, 0))
    {
        if (path_get_length(global.navigate) <= global.selected.pixel_dist)
        {
            instance_create(i_x,row,obj_move_square);
        }
        else
        {
            mp_grid_add_rectangle(global.map_grid, i_x, row, i_x, row);
        }
    }
    else {mp_grid_add_rectangle(global.map_grid, i_x, row, i_x, row);}
    
    if (i_x >= 576)
    {
        i = -1;
        row += 32;
    }
    
    if (row > 320)
    {
        row = row_default_value;
        i = 20;
    }
}
