/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다
/*
if(live_call()){return live_result;}
//show_message(player_list)

for(var i = 0; i < instance_number(obj_player); i++)
{
	var _obj = instance_find(obj_player,i);
	var _check = false;
	//show_message($"{_obj.my_socket}")
	for(var ii = 0; ii < array_length(player_list); ii++)
	{
		if(player_list[i][0] == _obj.my_socket)
		{
			_check = true;
			//show_message($"{player_list[i][0]}")
			if(array_length(player_list[i]) >= 2)
			{
				//show_message($"{player_list[i][0]}  {player_list[i][1]}")
				_obj.name_ = player_list[i][1];
			}
		}
	}
}