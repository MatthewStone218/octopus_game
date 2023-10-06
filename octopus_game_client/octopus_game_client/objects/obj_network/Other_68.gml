/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다

var n_id = ds_map_find_value(async_load, "id");
var n_type = ds_map_find_value(async_load, "type");

if(socket == n_id)
{
	switch(n_type)
	{
		case network_type_connect:
			show_message("1");
		break;
		
		case network_type_non_blocking_connect:
			show_message($"2  {ds_map_find_value(async_load, "succeeded")}");
		break;
		
		case network_type_disconnect:
			show_message("3");
		break;
		
		case network_type_data:
			show_message("4");
		break;
	}
}