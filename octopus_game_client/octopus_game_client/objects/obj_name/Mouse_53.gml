/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다


if(keyboard_virtual_status() == false)
{
	if(collision_point(mouse_x,mouse_y,id,0,0))
	{
		keyboard_string = "";
		keyboard_virtual_show(kbv_type_phone_name,kbv_returnkey_default,kbv_autocapitalize_none,false);
	}
}
else
{
	if(!collision_point(mouse_x,mouse_y,id,0,0))
	{
		keyboard_virtual_hide();
	}
}
