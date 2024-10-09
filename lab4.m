cam = webcam;
for i = 1:5
    RGB = snapshot(cam);

    r = RGB(:, :,1); g = RGB(:, : ,2); b = RGB(:, :, 3); % split r,g,b planes
    red = (r > 2*g) & (r > 2*b) & (r > 30); % create a binary image (1's and 0's)
    
    % heuristic algorithm (can adjust)
    % group all red object within 5 pixels of each other as one object (may adjust)
    se = strel('disk', 5);
    red = imclose(red,se);
    
    % delete all objects smaller than 35 pixels in area (may adjust)
    red = bwareaopen(red, 35);
    
    % take the centroids of all objects and store them in S
    s = regionprops(bwlabel(red),'centroid');
    S = vertcat(s.Centroid);
    
    % plot the image and the centroids
    figure
    imshow(RGB) % show original image
    title("unsuccessful red detection")
    hold on
    plot(S(:,1), S(:,2), '+') % identify red objects with '+'
    zoom on
    
    stats = regionprops(red, 'BoundingBox', 'Centroid', 'Area');
    imshow(RGB)
    hold on

    if length(stats) == 0
        display (" no red objects")
    else
        areas = [ ]; % fill array with areas
        for object = 1:length(stats)
            areas(object) = stats(object).Area;
        end
    end
    maxArea = max(areas); % find max area
    maxIndex = find(areas == maxArea);
    bb = stats(maxIndex).BoundingBox;
    bc = stats(maxIndex).Centroid; % etc.

    rectangle('Position', bb, 'EdgeColor', 'r', 'LineWidth', 2)
    plot(bc(1), bc(2), '-m+') % mark centroid (x, y) with '+'
    a=text(bc(1)+15,bc(2), strcat('X: ', num2str(round(bc(1))), ' Y: ', num2str(round(bc(2)))));
    set(a, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'yellow');

    hold off
end