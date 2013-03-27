function MSE = calcMSE( set1 , set2 )
    S = ( set1 - set2 ) .^ 2;
    MSE = mean(S(:));
end
