function [output_img]=adaptive_median_filter(img)
    img=double(img);
    output_img = zeros(size(img), 'double');
    
    [wid, ht] = size(img);
    
    s_max = min([wid, ht])/2;   % max mask size
    
    for i=1:wid
        for j=1:ht
           mask_size=3;    %must be odd
           output_pixel = 0;
           while(mask_size <= s_max)
               pixels_under_mask = [];
               % get list of all pixels under mask
               for k=-(mask_size-1)/2:(mask_size-1)/2
                   for l=-(mask_size-1)/2:(mask_size-1)/2
                       x = i+k;
                       y = j+l;
                       if(x >= 1 && x <= wid && y >= 1 && y <= ht )
                           pixels_under_mask(end+1) = img(x,y);
                       end
                   end
               end
               
               %adaptive median filter algorithm
               zmin = min(pixels_under_mask);
               zmax = max(pixels_under_mask);
               zmed = median(pixels_under_mask);
               zxy = img(i,j);
               
               %stage A
               a1 = zmed - zmin;
               a2 = zmed - zmax;
               if(a1 > 0 && a2 < 0)
                   % stage B
                   b1 = zxy - zmin;
                   b2 = zxy - zmax;
                   if(b1 > 0 && b2 < 0)
                       output_pixel = zxy;
                   else
                       output_pixel = zmed;
                   end
                   break;
               else
                   mask_size = mask_size + 2;
                   if(mask_size > s_max)    % loop will end after this
                       output_pixel = zmed;
                   end
               end
           end
           output_img(i,j) = output_pixel;
        end
    end
	output_img = uint8(output_img);
end
