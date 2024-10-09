% read the binary image
bw = imread("C:/users/mansi/OneDrive/Desktop/CMPSC 497/shapes.bmp");

% invert bw
bw = ~bw;
figure, imshow(bw)
title("original image")

% image dimensions
fprintf("Image dimensions %s\n", sprintf("%d ", size(bw)))

% create structuring element
se = strel("square", 30);

% separate objects
open_bw = imopen(bw, se);
figure, imshow(open_bw)
title("separated objects")