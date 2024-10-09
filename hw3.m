% read and display the image
image = imread("C:/Users/mansi/OneDrive/Desktop/CMPSC 497/orange.JPG");
figure, imshow(image)

% convert to grayscale
gray = rgb2gray(image);

% remove noise
gray = medfilt2(gray);

% convert to binary and invert
bw = imbinarize(gray);

% create structuring element and close gaps
se = strel("disk", 30);
bw = imclose(bw, se);

% create min and max of circle radius
Rmin = 250;
Rmax = 600;

% find center and radius of circle
[center, radius] = imfindcircles(bw, [Rmin Rmax], "Sensitivity",0.99);

% display the circle
viscircles(center, radius);

% display the center and radius
fprintf("Center: (%d, %d)\n", center(1), center(2))
fprintf("Radius: %d\n", radius)
