/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다
if(live_call()){return live_result;}
draw_self();
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_set_font(ft_name);
draw_text_ext(x,y-35,$"{fish_score}점\n{name_}",35,1000);