%% Segment features of given image
clear all;
set(0,'DefaultFigureWindowStyle','docked');

% configurations
TITLE = 'Feature';
MARGIN = 2;
level = 0.5; % Img 2 BW covertion line

% read image
Img = imread('ideal3','png');
ImgBW = im2bw(Img, level);
[R C] = size(Img);

% get image info
stats = regionprops(~ImgBW, 'BoundingBox');

% project segmentations
figure();
clf;hold on;
imshow(Img);

for index=1:length(stats)
    box = stats(index).BoundingBox;
    % U: Upper Left
    % L: Length
    % R: row, C: col
    UC = max(1, box(1) - MARGIN);
    UR = max(1, box(2) - MARGIN);
    LC = min(C, box(3) + MARGIN * 2);
    LR = min(R, box(4) + MARGIN * 2);
    [UC UR LC LR]
    if LC + LR > 5
        % Draw cropping boxes
        rectangle('Position', [UC UR LC LR]);
        % Crop image and save
        imwrite( imcrop(Img, [UC UR LC LR]),...
            strcat( TITLE, '_', sprintf('%03d', index),'.png' ),...
            'png');
    end
end

hold off;
