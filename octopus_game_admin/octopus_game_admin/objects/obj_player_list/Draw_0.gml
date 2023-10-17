/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다

draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_font(ft_normal);
for(var i = 0 ; i < array_length(obj_network.player_list); i++)
{
	draw_sprite(spr_fire,0,x,y+(i*30));
	
	var _str;
	if(array_length(obj_network.player_list[i]) >= 2)
	{
		_str = $"{obj_network.player_list[i][0]}   {obj_network.player_list[i][1]}";
	}
	else
	{
		_str = $"{obj_network.player_list[i][0]}";
	}
	
	draw_text(x+40,y+(i*30),_str);
}