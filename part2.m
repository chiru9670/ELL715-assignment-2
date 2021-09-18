clear variables
close all

img = rgb2gray(imread('images/buildings.png'));

%TODO what about "Use different size operators to find the suitable size."

%% 2a. Laplacian
Lap_filter_x = [0 0 0; 1 -2 1; 0 0 0];
Lap_filter_y = Lap_filter_x.';
Lap_filter_diag = [1 1 1; 1 -8 1; 1 1 1];
Lap_filter = Lap_filter_x+Lap_filter_y;
% applying x and y laplacian seperately
edges_x = uint8(abs(conv2(img, Lap_filter_x)));
imwrite(edges_x, "lapl_x.png");

edges_y = uint8(abs(conv2(img, Lap_filter_y)));
imwrite(edges_y, "lapl_y.png");

% applying both laplacians jointly
edges_joint = uint8(abs(conv2(img, Lap_filter)));
imwrite(edges_joint, "lapl_joint.png");

% applying laplacian with diagonal terms
edges_diag = uint8(abs(conv2(img, Lap_filter_diag)));
imwrite(edges_diag, "lapl_diag.png");

%% Roberts cross gradient
rob_x = [-1 0; 0 1];
rob_y = [0 -1; 1 0];

rob_edges_x = conv2(img, rob_x);
rob_edges_y = conv2(img, rob_y);

rob_edges_joint = uint8(sqrt(rob_edges_x.^2 + rob_edges_y.^2));
imwrite(rob_edges_joint, "roberts_cross.png");

%% Sobel gradient
sob_x = [-1 -2 -1; 0 0 0; 1 2 1];
sob_y = sob_x.';

sob_edges_x = conv2(img, sob_x);
sob_edges_y = conv2(img, sob_y);

sob_edges_joint = uint8(sqrt(sob_edges_x.^2 + sob_edges_y.^2));
imwrite(sob_edges_joint, "sobels.png");

%% Highboost filtering (best filter size-9)
for size = [3, 5, 7, 9, 11, 13, 15]
    mask = 1/(size*size) * ones(size);
    smooth_img = uint8(conv2(img, mask, 'same'));

    k = uint8(255 / max(img - smooth_img, [], 'all'));

    % for better image use k = 20 or more
    high_boost_img = uint8(k*(img - smooth_img));
    imwrite(high_boost_img, sprintf("high_boost_size%d.png", size));
end
