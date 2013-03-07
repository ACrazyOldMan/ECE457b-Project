%% Make Rotational Variants of given Image
set(0,'DefaultFigureWindowStyle','docked');

clc;

format = 'png'; % format of image
dirData = dir(strcat('*.',format));
fileList = {dirData.name}'; 

% for each images in the dir
for index = 1:1:length(fileList)
    filename = char(fileList(index));
    filename = filename(1:length(filename)-length(format)-1);
    Img = imread( filename, format );

    % Adjust Contast to high
    % imgMin = double(min(Img(:)));
    % imgMax = double(max(Img(:)));
    % Img = (Img - imgMin) / (imgMax - imgMin) * imgMax;
    % figure(2);Imshow(Img);
    
    Img = imresize( Img, 'bicubic', 'OutputSize', [64 64]);
    figure(index); imshow(Img);
    % Init dir
    % if( isdir(filename) )
    %     rmdir(filename, 's'); %delete dir and sub dir
    % end
    
    if( ~isdir(filename) )
        mkdir( filename );
    end
    
    % Generate Roated Iamge Variants
    for theta = 1:1:360
        variant_file_name = strcat( filename, '/', filename, '_', sprintf('%03d', theta ), '.', format );
        if ~exist(variant_file_name, 'file')
            Irot = imrotate(Img,theta);
            Mrot = ~imrotate(true(size(Img)),theta);
            Irot(Mrot&~imclearborder(Mrot)) = 255;
            mid_row = ceil( size( Irot, 1)/2 );
            mid_col = ceil( size( Irot, 2)/2 );
            imwrite( Irot( mid_row-31:mid_row+32, mid_col-31:mid_col+32 ), variant_file_name, format );
        end
    end
end
