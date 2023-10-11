/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다
if(mouse_check_button_pressed(mb_left))
{
	for(var i = 0 ; i < array_length(obj_network.player_list); i++)
	{
		if(point_in_rectangle(mouse_x,mouse_y,x-sprite_get_xoffset(spr_fire),y+(i*30)-sprite_get_yoffset(spr_fire),x-sprite_get_xoffset(spr_fire)+sprite_get_width(spr_fire),y+(i*30)-sprite_get_yoffset(spr_fire)+sprite_get_height(spr_fire)))
		{
			var t_buffer = buffer_create(1, buffer_grow, 1);
			buffer_seek(t_buffer, buffer_seek_start, 0);
			buffer_write(t_buffer , buffer_u16, CMD.PLAYER_KICK);
			buffer_write(t_buffer , buffer_u16, obj_network.player_list[i][0]);
			network_send_packet(obj_network.socket, t_buffer, buffer_tell(t_buffer));
			buffer_delete(t_buffer);
			//show_message($"kicked  {obj_network.player_list[i][0]}")
		}
	}
}