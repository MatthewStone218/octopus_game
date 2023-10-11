/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_black);

draw_text(x,y,$"{obj_network.time_left div 60000000} : {(obj_network.time_left div 1000000) mod 60}")