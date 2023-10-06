/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다

var n_id = ds_map_find_value(async_load, "id");
var n_type = ds_map_find_value(async_load, "type");

if(server_socket_game == n_id)
{
	var n_socket = ds_map_find_value(async_load, "socket");
	
	switch(n_type)
	{
		case network_type_connect:
			array_push(player_list,n_socket);
			log_d("network_type_connect");
		break;
		
		case network_type_non_blocking_connect:
			array_push(player_list,n_socket);
			log_d("network_type_non_blocking_connect");
		break;
		
		case network_type_disconnect:
			var _ind = array_get_index(player_list,n_socket);
			if(_ind >= 0)
			{
				array_delete(player_list,_ind,1);
				log_d("network_type_disconnect");
			}
		break;
	}

	var t_buffer = buffer_create(1, buffer_grow, 1);
	buffer_seek(t_buffer, buffer_seek_start, 0);
	buffer_write(t_buffer , buffer_u16, CMD.PLAYER_LIST);
	buffer_write(t_buffer , buffer_string, player_list);
	network_send_packet(server_socket_admin, t_buffer, buffer_tell(t_buffer));
}
else if(server_socket_admin == n_id)
{
	
}
else if(n_type == network_type_data)
{
	var t_buffer = ds_map_find_value(async_load, "buffer"); 
	log_d(buffer_read(t_buffer, buffer_f32 ));
}