for (i = 0; i < 18; i++)
{
    var i_x = 32 + 32*i;
    if (i_x >= 576)
    {
        i = 0;
        row += 32;
    }
    if (mp_grid_path(global.map_grid, global.navigate, global.selected.cur_node_x, global.selected.cur_node_y, i_x, row, 1))
    {
        if (path_get_length(global.navigate) <= global.selected.pixel_dist)
        {
            instance_create(i_x,row,obj_move_square);
        }
    }
    if (row > 320)
    {
        row = 0;
        i = 20;
    }
}
