clear variables
close all

img = rgb2gray(imread('images/lenna.png'));

%% Add noise
SNR_vals = [0 10 20 30 60]; % in dB
sigma_i = std2(img);    %std dev of img

for snr=SNR_vals
   sigma_n = sigma_i/(10^(snr/20));
   gnoisy = uint8(imnoise(img,'gaussian',0,sigma_n^2));  % adding zero-mean gaussian noise of variance sigma_n^2
   imwrite(gnoisy, sprintf("gaussian_noise_snr%d.png", snr));
   % no idea how to add salt and pepper noise acheiving a given snr
   
   % applying filters
   for size=[5,7,9]
      filter = ones(size)/size^2;
      gfiltered = uint8(conv2(gnoisy, filter));
      imwrite(gfiltered, sprintf("filtered_gaussian_noise_snr%d_filter_size%d.png", snr, size));
   end
end
