if (sprite_index != melee_anim)
{
    if (global.enemy.x > x-5) {image_xscale = 1;}
    sprite_index = melee_anim;
    image_index = 0;
}

if (image_index >= image_number -1)
{
    sprite_index = idle_anim;
    global.damage_dealt = attack;
    global.enemy.HP -= global.damage_dealt;
    instance_create(global.enemy.x,global.enemy.y,obj_damage_dealt);
    if (global.enemy.HP <= 0)
    {
        global.enemy.sprite_index = global.enemy.death_anim;
        global.enemy.image_index = 0;
    }
    // dont need death animation for enemies; cant be attacked
    
    image_xscale = -1;
    with(obj_attack_square){instance_destroy();}
    global.enemy = noone;
    attacked = true;
    if (instance_number(obj_test_lightPenguin) < 1){global.state = states.fail_state;}
}
