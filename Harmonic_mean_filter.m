function [Im]=Harmonic_mean_filter(Im)
%%%%% Harmonic mean filter for 2D image

% This function is used to Enhance and remove noise from images
% by Mohammed M. Siddeq
% 2012-2-22
%exmaple :\ H=Harmonic_mean_filter(Im,3);
% parameters :
% - "Im"   :- noisy image
% - "Mask" :- mask size 3x3 or 5x5 or 7x7..etc 
% - output is stored on same image "Im"

%Im = imread('D:\lectures\images\Big3.bmp');
Im=double(Im);

S_=size(Im);

Mask=3;
for i=1:S_(1)
    j=1;
    while(j<S_(2)-Mask)
        T(1:Mask)=Im(i,j:j+(Mask-1));
        Data=harmmean(T);
        Im(i,j+1)=Data;
        j=j+1;
    end
end
%imshow(uint8(Im));
end
