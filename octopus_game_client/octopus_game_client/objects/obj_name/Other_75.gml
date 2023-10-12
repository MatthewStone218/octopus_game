/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다

var _type = ds_map_find_value(async_load, "event_type");

if(_type == "virtual keyboard status")
{
	global.name = keyboard_string;
}