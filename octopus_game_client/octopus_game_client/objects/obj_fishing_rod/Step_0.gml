/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다

image_yscale += (1-image_yscale)/8;
y = camera_get_view_height(view_camera[0]);

if(image_index == 1)
{
	x = camera_get_view_width(view_camera[0])+random(10*fish_strength);
	if(mouse_check_button(mb_left))
	{
		fish_hp -= 8;
	}
	
	fish_hp += 1;
	
	if(fish_hp <= 0)
	{
		global.fish++;
		image_index = 2;
		image_yscale = 1.2;
		alarm[1] = 80;
		instance_create_depth(0,0,-1,obj_fish);
		var t_buffer = buffer_create(1, buffer_grow, 1);
		buffer_seek(t_buffer, buffer_seek_start, 0);
		buffer_write(t_buffer , buffer_u16, CMD.CAUGHT_FISH);
		buffer_write(t_buffer , buffer_u16, global.fish);
		network_send_packet(obj_network.socket, t_buffer, buffer_tell(t_buffer));
		buffer_delete(t_buffer);
	}
	else if(fish_hp >= fish_hp_max)
	{
		image_index = 2;
		image_yscale = 1.2;
		alarm[1] = 80;
		var t_buffer = buffer_create(1, buffer_grow, 1);
		buffer_seek(t_buffer, buffer_seek_start, 0);
		buffer_write(t_buffer , buffer_u16, CMD.FISHING_FAILED);
		network_send_packet(obj_network.socket, t_buffer, buffer_tell(t_buffer));
		buffer_delete(t_buffer);
	}
}