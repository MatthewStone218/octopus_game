/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다

image_index = 1;
var t_buffer = buffer_create(1, buffer_grow, 1);
buffer_seek(t_buffer, buffer_seek_start, 0);
buffer_write(t_buffer , buffer_u16, CMD.PULLING);
network_send_packet(obj_network.socket, t_buffer, buffer_tell(t_buffer));
buffer_delete(t_buffer);

audio_play_sound(snd_fishing,1,1);

fish_strength = random_range(1,4);

fish_hp_max = 300+(fish_strength*60);
fish_hp = fish_hp_max-120;

instance_create_depth(1080/2,213,-10,obj_touch_screen);