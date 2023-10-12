/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다

image_yscale += (1-image_yscale)/8;
if(image_index == 0)
{
	x = xstart;
	y = ystart;
}
else if(image_index == 1)
{
	x = xstart+random_range(-3,3);
	y = ystart+random_range(-2,2);
}