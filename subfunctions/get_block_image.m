function [block_image, block_locations] = get_block_image(roi_image, gsd)
%get_block_image recalculate image averaging over 
%   Detailed explanation goes here
[rows, cols] = size(roi_image);
block_locations = zeros(rows,1);
block_image = ones(rows, cols) * NaN;
step = 100;
location = 1;
complete = 0;
while complete == 0
%     step = f_of_gsd(location, location+step);
    if location + step < rows
        block_locations(location) = location;
        block_image(location,:) = mean(roi_image(location:location+step,:),1);
    else
        block_locations(location) = location;
        block_image(location,:) = mean(roi_image(location:end,:),1);
        complete = 1;
    end
    location = location + step;
end
block_locations = block_locations(block_locations > 0);
block_image = block_image(~isnan(block_image));
block_image = reshape(block_image, [], cols);
end

