function [block_dist, block_locations] = block_distribution(full_dist)
%block_distribution recalculate the grain size distribution in blocks
%   block size is a function of local grain size.

full_dist = full_dist';
[rows, cols] = size(full_dist);
location = 1;
step = 100;
block_dist = ones(rows, cols) * NaN;
block_locations = zeros(rows, 1);
complete = 0;

while complete == 0
    
%    step = f_of_local_grain_size(full_dist, location, location+step);
    block_locations(location) = location;
    
    if location + step < rows
        
        block_dist(location,:) = mean(full_dist(location:location+step,:),1);
        
    else
        block_dist(location,:) = mean(full_dist(location:end,:),1);
        complete = 1;
        
    end
    
    location = location + step;
    
end

block_locations = block_locations(block_locations > 0)';
block_dist = block_dist(~isnan(block_dist));
block_dist = reshape(block_dist, [], cols)';

end

