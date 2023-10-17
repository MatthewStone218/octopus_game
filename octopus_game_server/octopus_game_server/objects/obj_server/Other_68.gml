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
			array_push(player_list,[n_socket]);
			array_push(score_arr,[n_socket,0]);
			
			if(global.game_playing)
			{
				var t_buffer = buffer_create(1, buffer_grow, 1);
				buffer_seek(t_buffer, buffer_seek_start, 0);
				buffer_write(t_buffer , buffer_u16, CMD.GAME_START);
				network_send_packet(n_socket, t_buffer, buffer_tell(t_buffer));
				buffer_delete(t_buffer);
			}
			
			log_d("network_type_connect");
		break;
		
		case network_type_non_blocking_connect:
			array_push(player_list,[n_socket]);
			array_push(score_arr,[n_socket,0]);

			if(global.game_playing)
			{
				var t_buffer = buffer_create(1, buffer_grow, 1);
				buffer_seek(t_buffer, buffer_seek_start, 0);
				buffer_write(t_buffer , buffer_u16, CMD.GAME_START);
				network_send_packet(n_socket, t_buffer, buffer_tell(t_buffer));
				buffer_delete(t_buffer);
			}

			log_d("network_type_non_blocking_connect");
		break;
		
		case network_type_disconnect:
		
			var _ind = -1;
			for(var i = 0; i < array_length(player_list); i++)
			{
				if(player_list[i][0] == n_socket){_ind = i;}
			}
			
			if(_ind >= 0)
			{
				array_delete(player_list,_ind,1);
				log_d("network_type_disconnect: {_ind}");
			}
		break;
	}

	send_player_list()
}
else if(server_socket_admin == n_id)
{
	var n_socket = ds_map_find_value(async_load, "socket");
	
	switch(n_type)
	{
		case network_type_connect:
			admin_socket = n_socket;
			var t_buffer = buffer_create(1, buffer_grow, 1);
			buffer_seek(t_buffer, buffer_seek_start, 0);
			buffer_write(t_buffer , buffer_u16, CMD.PLAYER_LIST);
			buffer_write(t_buffer , buffer_string, player_list);
			network_send_packet(admin_socket, t_buffer, buffer_tell(t_buffer));
			buffer_delete(t_buffer);
			log_d("network_type_connect: admin connected");
		break;
		
		case network_type_non_blocking_connect:
			admin_socket = n_socket;
			var t_buffer = buffer_create(1, buffer_grow, 1);
			buffer_seek(t_buffer, buffer_seek_start, 0);
			buffer_write(t_buffer , buffer_u16, CMD.PLAYER_LIST);
			buffer_write(t_buffer , buffer_string, player_list);
			network_send_packet(admin_socket, t_buffer, buffer_tell(t_buffer));
			buffer_delete(t_buffer);
			log_d("network_type_connect: admin connected");
		break;
	}
}
else if(server_socket_screen == n_id)
{
	var n_socket = ds_map_find_value(async_load, "socket");
	
	switch(n_type)
	{
		case network_type_connect:
			screen_socket = n_socket;
			send_player_list();
			send_score_arr();
			log_d("network_type_connect: screen connected");
		break;
		
		case network_type_non_blocking_connect:
			screen_socket = n_socket;
			send_player_list();
			send_score_arr();
			log_d("network_type_connect: screen connected");
		break;
	}
}
else if(n_type == network_type_data)
{
	var n_socket = n_id;
	
	var t_buffer = ds_map_find_value(async_load, "buffer"); 
	var cmd = buffer_read(t_buffer, buffer_u16 );
	switch(cmd)
	{
		case CMD.PLAYER_NAME:
			var _ind = -1;
			for(var i = 0; i < array_length(player_list); i++)
			{
				if(player_list[i][0] == n_socket)
				{
					_ind = i;
					break;
				}
			}
			
			if(_ind != -1)
			{
				player_list[_ind][1] = buffer_read(t_buffer,buffer_string);
				log_d($"player_name: {player_list[_ind][1]}");
			}
			
			if(global.game_playing)
			{
				var t_buffer = buffer_create(1, buffer_grow, 1);
				buffer_seek(t_buffer, buffer_seek_start, 0);
				buffer_write(t_buffer , buffer_u16, CMD.GAME_START);
				network_send_packet(n_socket, t_buffer, buffer_tell(t_buffer));
				buffer_delete(t_buffer);
			}
			
			send_player_list();
		break;
		
		case CMD.PLAYER_KICK:
			var _sock_kick = buffer_read(t_buffer,buffer_u16);
			var t_buffer = buffer_create(1, buffer_grow, 1);
			buffer_seek(t_buffer, buffer_seek_start, 0);
			buffer_write(t_buffer , buffer_u16, CMD.PLAYER_KICK);
			network_send_packet(_sock_kick, t_buffer, buffer_tell(t_buffer));
			network_destroy(_sock_kick);
			buffer_delete(t_buffer);
			
			var _ind = -1;
			for(var i = 0; i < array_length(player_list); i++)
			{
				if(player_list[i][0] == _sock_kick){_ind = i;}
			}
			if(_ind >= 0)
			{
				array_delete(player_list,_ind,1);
			}
			send_player_list()
			
			log_d($"kicked {_sock_kick}");
		break;		
		
		case CMD.GAME_END:
		
			global.game_playing = false;
			
			for(var i = 0; i < array_length(player_list); i++)
			{
				var t_buffer = buffer_create(1, buffer_grow, 1);
				buffer_seek(t_buffer, buffer_seek_start, 0);
				buffer_write(t_buffer , buffer_u16, CMD.GAME_END);
				network_send_packet(player_list[i][0], t_buffer, buffer_tell(t_buffer));
				network_destroy(player_list[i][0]);
				buffer_delete(t_buffer);
			}
			player_list = [];
			send_player_list();
			log_d($"game end. kicked all");
		break;
		
		case CMD.GAME_START:
		
			global.game_playing = true;
			time_now = buffer_read(t_buffer,buffer_u16)*1000000;
			
			for(var i = 0; i < array_length(player_list); i++)
			{
				var t_buffer = buffer_create(1, buffer_grow, 1);
				buffer_seek(t_buffer, buffer_seek_start, 0);
				buffer_write(t_buffer , buffer_u16, CMD.GAME_START);
				network_send_packet(player_list[i][0], t_buffer, buffer_tell(t_buffer));
				buffer_delete(t_buffer);
			}
			log_d($"game_started");
		break;
		
		case CMD.PULLING:
			var t_buffer = buffer_create(1, buffer_grow, 1);
			buffer_seek(t_buffer, buffer_seek_start, 0);
			buffer_write(t_buffer , buffer_u16, CMD.PULLING);
			buffer_write(t_buffer , buffer_u16, n_socket);
			network_send_packet(screen_socket, t_buffer, buffer_tell(t_buffer));
			buffer_delete(t_buffer);
		break;
		
		case CMD.FISHING_FAILED:
			var t_buffer = buffer_create(1, buffer_grow, 1);
			buffer_seek(t_buffer, buffer_seek_start, 0);
			buffer_write(t_buffer , buffer_u16, CMD.FISHING_FAILED);
			buffer_write(t_buffer , buffer_u16, n_socket);
			network_send_packet(screen_socket, t_buffer, buffer_tell(t_buffer));
			buffer_delete(t_buffer);
		break;
		
		case CMD.CAUGHT_FISH:
		
			if(global.game_playing)
			{
				var _fish = buffer_read(t_buffer, buffer_u16 );
				for(var i = 0; i < array_length(score_arr); i++)
				{
					if(score_arr[i][0] == n_socket)
					{
						score_arr[i][1] = _fish;
						break;
					}
				}
		
				var t_buffer = buffer_create(1, buffer_grow, 1);
				buffer_seek(t_buffer, buffer_seek_start, 0);
				buffer_write(t_buffer , buffer_u16, CMD.CAUGHT_FISH);
				buffer_write(t_buffer , buffer_u16, n_socket);
				buffer_write(t_buffer , buffer_u16, _fish);
				network_send_packet(screen_socket, t_buffer, buffer_tell(t_buffer));
				buffer_delete(t_buffer);
			}
		break;
		
		case CMD.SCOREBOARD:
			var t_buffer = buffer_create(1, buffer_grow, 1);
			buffer_seek(t_buffer, buffer_seek_start, 0);
			buffer_write(t_buffer , buffer_u16, CMD.SCOREBOARD);
			network_send_packet(screen_socket, t_buffer, buffer_tell(t_buffer));
			buffer_delete(t_buffer);
		break;
	}
}