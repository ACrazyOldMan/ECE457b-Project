figureID = 1;
sheet = imread( dataPath( 'rotated/Bloom_Nobly_Cherry_Blossom_of_Sumizome__Border_of_Life_Piano_Version-1.png' ) );

%% preprocessing
[ M , N , C ] = size(sheet);
sheet = sum( sheet , 3 ) / C;
sheet = -( sheet - min(sheet(:)) - range(sheet(:))/2 );
sheet = fixRotation( sheet , 0.01 );
[ M , N ] = size(sheet);

%% line detection
lines = findStaffLines( sheet , 'simple' );
lines = jitterLines( sheet , lines , 3 );
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
hold on;
for i = 1 : size(lines,1)
    plot( 1 : N , lines(i,:) , 'r' );
end
hold off;
title( 'Line Removal Result' );
