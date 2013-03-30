function drawBox( box , colour )
    x1 = box(2,1);
    x2 = box(2,2);
    y1 = box(1,1);
    y2 = box(1,2);
    hold on;
    plot( [x1,x2] , [y1,y1] , 'color' , colour );
    plot( [x1,x2] , [y2,y2] , 'color' , colour );
    plot( [x1,x1] , [y1,y2] , 'color' , colour );
    plot( [x2,x2] , [y1,y2] , 'color' , colour );
    hold off;
end
