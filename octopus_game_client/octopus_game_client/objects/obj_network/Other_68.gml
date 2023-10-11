/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다

var n_id = ds_map_find_value(async_load, "id");
var n_type = ds_map_find_value(async_load, "type");

if(socket == n_id)
{
	switch(n_type)
	{
		case network_type_non_blocking_connect:
			var succeeded = ds_map_find_value(async_load, "succeeded");
			if(succeeded)
			{
				
			}
			else
			{
				show_message($"인원이 가득 찼습니다!");
			}
			connecting = false;
		break;
		
		case network_type_data:
			var t_buffer = ds_map_find_value(async_load, "buffer"); 
			var cmd = buffer_read(t_buffer, buffer_u16 );
			
			switch(cmd)
			{
				case CMD.PLAYER_KICK:
					network_destroy(socket);
					room_goto(rm_main);
					show_message("강퇴당했습니다.");
				break;
				
				case CMD.GAME_END:
					network_destroy(socket);
					room_goto(rm_main);
					show_message("게임이 종료되었습니다.");
				break;

				case CMD.GAME_START:
					room_goto(rm_game);
				break;
			}
		break;
	}
}