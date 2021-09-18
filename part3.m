clear variables
close all

v = VideoReader('images/bones.mp4');
frame1 = rgb2gray(readFrame(v));
frame2 = rgb2gray(readFrame(v));

diff = frame1 - frame2;

imwrite(frame1, 'frame1.png');
imwrite(frame2, 'frame2.png');
imwrite(diff, 'diff_of_frames.png');