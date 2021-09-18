function output_img = Harmonic_mean_filter(img)
    output_img = mask_filter(img, @harmmean);
end