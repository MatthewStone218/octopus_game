/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다

var n_id = ds_map_find_value(async_load, "id");
var n_type = ds_map_find_value(async_load, "type");

if(server_socket_game == n_id)
{
	switch(n_type)
	{
		case network_type_connect:
			log_d("network_type_connect");
		break;
		
		case network_type_non_blocking_connect:
			log_d("network_type_non_blocking_connect");
		break;
		
		case network_type_disconnect:
			log_d("network_type_disconnect");
		break;
	}
}
else if(n_type == network_type_data)
{
	var t_buffer = ds_map_find_value(async_load, "buffer"); 
	log_d(buffer_read(t_buffer, buffer_f32 ));
}