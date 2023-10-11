/// @description 여기에 설명 삽입
// 이 에디터에 코드를 작성할 수 있습니다

if (browser_width != width or browser_height != height)
{
	if(os_type == os_windows)
	{
	    width = browser_width; width = round(width);
	    height = browser_height; height = round(height);
	
		var _aspect = (base_width / base_height);
	
		if ((width / _aspect) > height)
		{
			window_set_size((height *_aspect), height);
		}
		else
		{
			window_set_size(width, (width / _aspect));
		}
	
		if (center)
		{
			window_center();
		}
		surface_resize(application_surface, max(window_get_width()*2, base_width), max(window_get_height()*2, base_height));
	}
	else
	{
	    width = browser_width; width = round(width);
	    height = browser_height; height = round(height);
	
		window_set_size(width, height);
	
		camera_set_view_size(view_camera[0],1080,1080*(height/width));
	
		if (center)
		{
			window_center();
		}
		surface_resize(application_surface, width, height);
	}
}