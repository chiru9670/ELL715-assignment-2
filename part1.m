clear variables
close all

img = rgb2gray(imread('E:\Documents\DIP\lenna.png'));

%% Add noise
SNR_vals = [0 10 20 30 60]; % in dB
sigma_i = std2(img);    %std dev of img

for snr=SNR_vals
   sigma_n = sigma_i/(10^(snr/20));
   gnoisy = uint8(imnoise(img,'gaussian',0,sigma_n^2));  % adding zero-mean gaussian noise of variance sigma_n^2
   imwrite(gnoisy, sprintf("gaussian_noise_snr%d.png", snr));
   
   % assuming noise density = 10^-(snr/20)
   d = 10^(-snr/20);
   spnoisy = uint8(imnoise(img,'salt & pepper', d));
   imwrite(spnoisy, sprintf("sp_noise_snr%d.png", snr));
   
   % applying filters
   for size=[5,7,9]
      filter = ones(size)/size^2;
      gfiltered = uint8(conv2(gnoisy, filter));
      spfiltered = uint8(conv2(spnoisy, filter));
      imwrite(gfiltered, sprintf("filtered_gaussian_noise_snr%d_filter_size%d.png", snr, size));
      imwrite(spfiltered, sprintf("filtered_sp_noise_snr%d_filter_size%d.png", snr, size));
   end
   
   gnoisy_edge = edge(gnoisy, 'Canny');
   imwrite(gnoisy_edge, sprintf("edges_by_canny_gaussian_noise_snr%d.png", snr));
   
   harmonic_filtered_g = Harmonic_mean_filter(gnoisy);
   harmonic_edge_g = edge(harmonic_filtered_g, 'Canny');
   imwrite(harmonic_edge_g, sprintf("edges_by_canny_after_harmonic_gaussian_noise_snr%d.png", snr));
   
   median_filtered_g = medfilt2(gnoisy);
   median_edge_g = edge(median_filtered_g, 'Canny');
   imwrite(median_edge_g, sprintf("edges_by_canny_after_median_gaussian_noise_snr%d.png", snr));
   
   spnoisy_edge = edge(spnoisy, 'Canny');
   imwrite(spnoisy_edge, sprintf("edges_by_canny_sp_noise_snr%d.png", snr));
   
   harmonic_filtered_sp = Harmonic_mean_filter(spnoisy);
   harmonic_edge_sp = edge(harmonic_filtered_sp, 'Canny');
   imwrite(harmonic_edge_sp, sprintf("edges_by_canny_after_harmonic_sp_noise_snr%d.png", snr));
   
   median_filtered_sp = medfilt2(spnoisy);
   median_edge_sp = edge(median_filtered_sp, 'Canny');
   imwrite(median_edge_sp, sprintf("edges_by_canny_after_median_sp_noise_snr%d.png", snr));
end

