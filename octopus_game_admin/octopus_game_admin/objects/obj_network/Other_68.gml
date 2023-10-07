/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다

var n_id = ds_map_find_value(async_load, "id");
var n_type = ds_map_find_value(async_load, "type");

if(socket == n_id)
{
	switch(n_type)
	{
		case network_type_non_blocking_connect:
			if(ds_map_find_value(async_load, "succeeded"))
			{
				show_message("서버 연결 성공!");
			}
			else
			{
				show_message("서버 연결 실패");
			}
		break;
		
		case network_type_data:
			var t_buffer = ds_map_find_value(async_load, "buffer");
			var cmd_type = buffer_read(t_buffer,buffer_u16);
			
			switch(cmd_type)
			{
				case CMD.PLAYER_LIST:
					var arr = buffer_read(t_buffer,buffer_string);
					player_list = json_parse(arr);
				break;
			}
		break;
	}
}