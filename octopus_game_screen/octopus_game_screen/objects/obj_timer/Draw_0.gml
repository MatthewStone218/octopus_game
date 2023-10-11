/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다
draw_self();
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_black);
draw_set_font(ft_timer);

var _sec = obj_network.time_left mod 60;
if(_sec < 10){_sec = "0"+string(_sec);}else{_sec = string(_sec);}
draw_text(x,y,$"{obj_network.time_left div 60} : {_sec}");