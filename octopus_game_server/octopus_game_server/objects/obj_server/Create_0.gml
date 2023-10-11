/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다

global.game_playing = false;

time_max = 180*1000000;
time_now = time_max;

log = [];

function log_d(text)
{
	array_insert(log,0,text);
	if(array_length(log) > 150)
	{
		array_delete(log,150,1);
	}
}

player_list = [];
admin_socket = -1;
screen_socket = -1;

server_socket_game = network_create_server(network_socket_ws,6510,2);

log_d($"game server socket : {server_socket_game}");

server_socket_admin = network_create_server(network_socket_ws,6511,50);

log_d($"admin server socket : {server_socket_admin}");

server_socket_screen = network_create_server(network_socket_ws,6512,50);

log_d($"screen server socket : {server_socket_screen}");

function send_player_list()
{
	var t_buffer = buffer_create(1, buffer_grow, 1);
	buffer_seek(t_buffer, buffer_seek_start, 0);
	buffer_write(t_buffer , buffer_u16, CMD.PLAYER_LIST);
	buffer_write(t_buffer , buffer_string, json_stringify(player_list));
	network_send_packet(admin_socket, t_buffer, buffer_tell(t_buffer));
	buffer_delete(t_buffer);
	
	var t_buffer = buffer_create(1, buffer_grow, 1);
	buffer_seek(t_buffer, buffer_seek_start, 0);
	buffer_write(t_buffer , buffer_u16, CMD.PLAYER_LIST);
	buffer_write(t_buffer , buffer_string, json_stringify(player_list));
	network_send_packet(admin_socket, t_buffer, buffer_tell(t_buffer));
	buffer_delete(t_buffer);
}

enum CMD
{
	PLAYER_LIST = 0,
	PLAYER_NAME = 1,
	PLAYER_KICK = 2,
	GAME_START = 3,
	GAME_END = 4,
	TIMES_UP = 5,
	TIME = 6
}