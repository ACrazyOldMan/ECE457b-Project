figureID = 1;
sheet = imread( dataPath( 'optimal/Bloom_Nobly_Cherry_Blossom_of_Sumizome__Border_of_Life_Piano_Version-1.png' ) );
[ M , N , C ] = size(sheet);
sheet = sum( sheet , 3 ) / C;

%% line detection
lines = findStaffLines( sheet , 'simple' );
figureID = newFigure( figureID );
colormap gray;
imagesc( sheet );
hold on;
for i = 1 : size(lines,1)
    plot( 1 : N , lines(i,:) , 'r' );
end
hold off;
title( 'Line Detection Result' );

%% line removal
features = removeStaffLines( sheet , lines , 'simple' );
figureID = newFigure( figureID );
colormap gray;
imagesc( features );
title( 'Line Removal Result' );
