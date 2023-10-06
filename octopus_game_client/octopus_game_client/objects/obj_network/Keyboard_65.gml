/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다

var t_buffer = buffer_create(1, buffer_grow, 1);
buffer_seek(t_buffer, buffer_seek_start, 0);
buffer_write(t_buffer , buffer_f32,random(10));
network_send_packet(socket, t_buffer, buffer_tell(t_buffer));