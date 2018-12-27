% return the sum of each L1-norm of each 2-D child matrix in 3-D matrix X
% also can be used to calculate 2-D matrix since height of 2-D matrix is 1 
% also can be used to calculate 1-D matrix since width of 1-D matrix is 1
function temp = customNorm(X)
    [sizeX,sizeY,sizeZ] = size(X);
    temp = 0;
    for i = 1:sizeX
        for j = 1:sizeY
            for k = 1:sizeZ
                temp = temp + abs(X(i,j,k));
            end
        end
    end
end

