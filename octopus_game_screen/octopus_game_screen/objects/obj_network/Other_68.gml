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
					for(var i = 0; i < instance_number(obj_player); i++)
					{
						var _obj = instance_find(obj_player,i);
						for(var i = 0; i < array_length(player_list); i++)
						{
							var _check = false;
							if(player_list[i][0] == _obj.my_socket)
							{
								_check = true;
							}
							
							if(_check == false)
							{
								//이미 있던 플레이어가 나간 경우
								with(_obj)
								{
									var incy = instance_create_depth(x,y,depth,obj_player_chair);
									incy.image_xscale = image_xscale;
									instance_destroy();
								}
							}
							else
							{
								if(array_length(player_list[i]) >= 2){_obj.name = player_list[i][1];}
							}
						}
					}
					
					for(var i = 0; i < array_length(player_list); i++)
					{
						var _check = false;
						with(obj_player)
						{
							if(my_socket == obj_network.player_list[i][0])
							{
								_check = true;
							}
						}
						
						if(_check == false)
						{
							//플레이어가 새로 들어온 경우
							if(instance_exists(obj_player_chair))
							{
								var _chair = instance_find(obj_player_chair,irandom(instance_number(obj_player_chair)-1));
								var incy = instance_create_depth(_chair.x,_chair.y,-_chair.y,obj_player);
								incy.image_xscale = abs(_chair.image_xscale);
								incy.my_socket = player_list[i][0];
								if(array_length(player_list[i]) >= 2){_obj.name = player_list[i][1];}
								instance_destroy(_chair);
							}
						}
					}

				break;
				
				case CMD.TIME:
					time_left = buffer_read(t_buffer,buffer_u16);
				break;
				
				case CMD.PULLING:
					var _sock = buffer_read(t_buffer, buffer_u16 );
					with(obj_player)
					{
						if(my_socket == _sock)
						{
							image_index = 1;
						}
					}
				break;
		
				case CMD.FISHING_FAILED:
					var _sock = buffer_read(t_buffer, buffer_u16 );
					with(obj_player)
					{
						if(my_socket == _sock)
						{
							image_index = 0;
						}
					}
				break;
		
				case CMD.CAUGHT_FISH:
					var _sock = buffer_read(t_buffer, buffer_u16 );
					var _fish = buffer_read(t_buffer, buffer_u16 );
					with(obj_player)
					{
						if(my_socket == _sock)
						{
							image_index = 2;
							image_yscale = 1.2;
							fish_score = _fish;
							alarm[0] = 100;
						}
					}
				break;
			}
		break;
	}
}