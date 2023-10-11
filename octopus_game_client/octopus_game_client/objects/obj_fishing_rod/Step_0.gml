/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다

image_yscale += (1-image_yscale)/8;
y = camera_get_view_height(view_camera[0]);

if(image_index == 1)
{
	x = camera_get_view_width(view_camera[0])+random(10*fish_strength);
	if(mouse_check_button(mb_left))
	{
		fish_hp -= 6;
	}
	
	fish_hp += 2;
	
	if(fish_hp <= 0)
	{
		image_index = 2;
		image_yscale = 1.2;
		alarm[1] = 80;
		instance_create_depth(0,0,-1,obj_fish)
	}
	else if(fish_hp >= fish_hp_max)
	{
		image_index = 2;
		image_yscale = 1.2;
		alarm[1] = 80;
	}
}