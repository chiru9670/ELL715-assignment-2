function output_img = median_filter(img)
    output_img = mask_filter(img, @median);  
end

