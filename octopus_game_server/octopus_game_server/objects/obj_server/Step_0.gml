/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다
if(global.game_playing)
{
	var time_prev = time_now;
	time_now -= delta_time;
	
	if(time_now <= 0)
	{
		time_now = 0;
		global.game_playing = false;
		
		var t_buffer = buffer_create(1, buffer_grow, 1);
		buffer_seek(t_buffer, buffer_seek_start, 0);
		buffer_write(t_buffer , buffer_u16, CMD.TIMES_UP);
		network_send_packet(screen_socket, t_buffer, buffer_tell(t_buffer));
		buffer_delete(t_buffer);
		
		for(var i = 0; i < array_length(player_list); i++)
		{
			var t_buffer = buffer_create(1, buffer_grow, 1);
			buffer_seek(t_buffer, buffer_seek_start, 0);
			buffer_write(t_buffer , buffer_u16, CMD.TIMES_UP);
			network_send_packet(player_list[i][0], t_buffer, buffer_tell(t_buffer));
			buffer_delete(t_buffer);
		}
	}
	
	if(time_now div 1000000 != time_prev div 1000000)
	{
		var t_buffer = buffer_create(1, buffer_grow, 1);
		buffer_seek(t_buffer, buffer_seek_start, 0);
		buffer_write(t_buffer , buffer_u16, CMD.TIME);
		buffer_write(t_buffer , buffer_u16, time_now div 1000000);
		network_send_packet(screen_socket, t_buffer, buffer_tell(t_buffer));
		network_send_packet(admin_socket, t_buffer, buffer_tell(t_buffer));
		buffer_delete(t_buffer);
	}
}