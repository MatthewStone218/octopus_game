/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다
if(live_call()){return live_result;}

if(image_alpha != 0)
{
	draw_self();
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(c_black);
	draw_set_font(ft_name);
		
	var _x = 960;
	var _y = 385;
		
	var _arr1 = [];
	with(obj_player)
	{
		if(name_ != "default")
		{
			array_push(_arr1,id);
		}
	}
	
	var _arr2 = [];
	var _high = 0;
	var _high_index = -1;
		
	for(var i = 0; i < 10; i++)
	{
		_high = 0;
		_high_index = -1;
		for(var ii = 0; ii < array_length(_arr1); ii++)
		{
			if(_arr1[ii].fish_score >= _high)
			{
				_high = _arr1[ii].fish_score;
				_high_index = ii;
			}
		}
		
		if(_high_index != -1)
		{
			_arr2[i] = $"{i+1}등  {_arr1[_high_index].name_}  {_arr1[_high_index].fish_score} 점";
			array_delete(_arr1,_high_index,1);
		}
	}
	
	//_arr2 = ["1","2","3","4","5","6","7","8","9","10"];
		
	for(var i = 0; i < array_length(_arr2); i++)
	{
		draw_text_transformed(_x,_y+(i*61),_arr2[i],2,2,0);
	}
}