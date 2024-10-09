% Read and display
image = imread("C:/Users/mansi/OneDrive/Desktop/CMPSC 497/desk_objects.JPG");
figure, imshow(image);
title("Desk Objects")

% image dimensions
dimensions = size(image);
fprintf("Dimension of rgb image is %d X %d X %d \n", dimensions(1), dimensions(2), dimensions(3));

% displaying pixel regions
imtool(image);

% displaying the red plane
red_plane = image(:, :, 1);
figure, imshow(red_plane)
title("red plane")

% displaying the green plane
green_plane = image(:, :, 2);
figure, imshow(green_plane)
title("green plane")

% displaying the blue plane
blue_plane = image(:, :, 3);
figure, imshow(blue_plane)
title("blue plane")

% convert to grayscale
gray_image = rgb2gray(image);
figure, imshow(gray_image)
title("gray image")

% dimensions of gray image
gray_dimension = size(gray_image);
fprintf("Dimensions of gray image %d X %d \n", gray_dimension(1), gray_dimension(2))

% minimum pixel value of gray image
minimum = min(min(gray_image));
fprintf("Minimum pixel value of gray image is %d \n", minimum)

% maximum pixel value of gray image
maximum = max(max(gray_image));
fprintf("Maximum value of gray image is %d \n", maximum)

% average pixel value of gray image
average = mean(mean(gray_image));
fprintf("Average value of gray image is %d \n", average)

% histogram plot for gray image
figure, imhist(gray_image)
title("Distribution of intensities")
xlabel("Intensities")
ylabel("Frequency")

% display the top half of the image
top_half = gray_image(1:dimensions(1)/2, :);
figure, imshow(top_half)
title("Top half of image")

% display the right half of the image
right_half = gray_image(:, dimension(2)/2:dimension(2));
imshow(right_half)
title("Right half of the image")

% convert gray image to binary
binary_image = imbinarize(gray_image);
imshow(binary_image)
title("Binary Image")

% resizing the image by 50%
resized = imresize(image, 0.5);
imshow(resized)
title("resized by 50%")

    % reducing image to 200 x 200 pixels
    reduced = imresize(image, [200, 200]);
    imshow(reduced)
    title("reduced to 200 x 200 pixels")