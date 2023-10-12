/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다
socket = network_create_socket(network_socket_ws);
var _success = network_connect_async(socket,"127.0.0.1",6512);
if(_success < 0){show_message("연결에 실패했습니다! 잠시 뒤에 다시 시도해주세요.")}

player_list = [];

time_left = 300;

enum CMD
{
	PLAYER_LIST = 0,
	PLAYER_NAME = 1,
	PLAYER_KICK = 2,
	GAME_START = 3,
	GAME_END = 4,
	TIMES_UP = 5,
	TIME = 6,
	PULLING = 7,
	FISHING_FAILED = 8,
	CAUGHT_FISH = 9
}