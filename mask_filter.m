function [output_img]=mask_filter(img, filter_func)
    img=double(img);
    output_img = zeros(size(img), 'double');
    
    [wid, ht] = size(img);
    
    mask_size=3;    %must be odd
    for i=1:wid
        for j=1:ht
           pixels_under_mask = [];
           for k=-(mask_size-1)/2:(mask_size-1)/2
               for l=-(mask_size-1)/2:(mask_size-1)/2
                   x = i+k;
                   y = j+l;
                   if(x >= 1 && x <= wid && y >= 1 && y <= ht )
                       pixels_under_mask(end+1) = img(x,y);
                   end
               end
           end
           output_img(i,j) = filter_func(pixels_under_mask);
        end
    end
	output_img = uint8(output_img);
end
