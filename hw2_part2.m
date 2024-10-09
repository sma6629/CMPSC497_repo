% read the bw image
bw = imread("C:/Users/mansi/OneDrive/Desktop/CMPSC 497/shapes2.bmp");

% invert bw
bw = ~bw;
figure, imshow(bw)
title("original image")

% image dimensions
fprintf("Image dimensions %s\n", sprintf("%d ", size(bw)))

% create structuring element
se = strel("square", 30);

% combine objects
close_bw = imclose(bw, se);
figure, imshow(close_bw)
title("closed objects")