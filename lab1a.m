% access rgb image
image = imread("C:/Users/mansi/OneDrive/Desktop/CMPSC 497/round_objects.JPG");
imshow(image)
title("RGB image")

% create grayscale image
gray = rgb2gray(image);
threshold = graythresh(gray);
figure, imshow(gray)
title("Grayscale image")

% create binary image
bw = im2bw(gray, threshold);
figure, imshow(bw)
title("binary image")

% remove all objects containing fewer than 100 pixels
bw1 = bwareaopen(bw, 100);
figure, imshow(bw1)
title("bw1")

se = strel('disk', 15); % structuring element; "paintbrush"
bw2 = imclose(bw1, se); % we will cover later in course
figure, imshow (bw2);
title("bw2")

% fill any holes, so that regionprops can be used to estimate
% the area enclosed by each of the boundaries
bw3 = imfill(bw2, 'holes');
figure, imshow (bw3)
title("bw3")

% get pixels for boundaries of each object
[B,L] = bwboundaries(bw3, 'noholes');

% Display the label matrix and draw each boundary
imshow(label2rgb(L, @jet, [.5 .5 .5]))
title("label matrix with boundary")

% Display number of objects
fprintf("Total Number of objects is: %d \n", length(B))

hold on % allow graphics to be added to same plot
for k = 1 : length(B) % length(B) is number of objects
    boundary = B{k}; % B is “cell” data type (set)
    plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
end

stats = regionprops(L, 'Area', 'Centroid'); % find area(in pixels) and centroid (x, y) for each object in label matrix

threshold = 0.80; % arbitrary value (change as needed)

count = 0;

% loop over the boundaries (each object has a boundary)
for k = 1:length(B)
    % obtain (X,Y) boundary coordinates corresponding to label 'k'
    boundary = B{k};

    % compute a simple estimate of the object's perimeter
    delta_sq = diff(boundary).^2; % find 2-col. array of (x2-x1)^2 and (y2-y1)^2
    perimeter = sum(sqrt(sum(delta_sq,2))); % sum (row) and take sqrt to find dist.
    % then sum all distances to find perim.
    
    %Note: perimeter = 2*pi*r; so.. r = perimeter/(2*pi); area = pi * r^2
    area1 = perimeter ^2/(4*pi);

    % obtain the area calculation corresponding to label 'k'
    area2 = stats(k).Area; % so, we calculated the area 2 different ways

    % compute the roundness metric (compare 2 methods)
    metric = area2 / area1; % circular objects have metric close to 1

    % display the results
    metric_string = sprintf('%2.2f',metric);

    % mark objects above the threshold with a small black circle in center of object
    if metric > threshold
        centroid = stats(k).Centroid;
        plot(centroid(1),centroid(2),'ko');
        count = count + 1;
    end
    
    text(boundary(1,2)-35,boundary(1,1)+13,metric_string,'Color','black',...
    'FontSize',14,'FontWeight','bold');
end

% print the number of round objects
fprintf("the number of round objects is %d \n", count)