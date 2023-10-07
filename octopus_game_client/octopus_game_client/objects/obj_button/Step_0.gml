/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다

if(mouse_check_button(mb_left))
{
	if(collision_point(mouse_x,mouse_y,id,0,0))
	{
		clicked = true;
	}
}
else
{
	if(clicked == true and collision_point(mouse_x,mouse_y,id,0,0))
	{
		scale = scale_max;
		click();
	}
	clicked = false;
}


if(clicked and collision_point(mouse_x,mouse_y,id,0,0))
{
	scale -= 0.08;
	if(scale < scale_min){scale = scale_min;}
}
else
{
	clicked = false;
	scale = (1-scale)/4;
}

image_xscale = _xscale*scale;
image_yscale = _yscale*scale;