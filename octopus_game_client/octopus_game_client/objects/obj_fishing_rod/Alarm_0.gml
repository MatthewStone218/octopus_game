/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다

image_index = 1;
fish_strength = random_range(1,4);

fish_hp_max = 100+(fish_strength*40);
fish_hp = fish_hp_max-70;

instance_create_depth(1080/2,213,-10,obj_touch_screen);