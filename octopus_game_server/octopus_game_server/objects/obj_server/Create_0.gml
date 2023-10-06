/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다

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

server_socket_game = network_create_server(network_socket_ws,6510,2);

log_d($"game server socket : {server_socket_game}");

server_socket_admin = network_create_server(network_socket_ws,6511,50);

log_d($"admin server socket : {server_socket_admin}");

enum CMD
{
	PLAYER_LIST = 0
}