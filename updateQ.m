function newQ = updateQ(Q, r)
    % this function is designed to update Q
    % bascially it just shrink each entry in Q(:,:,2:9)
    [sizeX,sizeY,sizeZ] = size(Q);
    newQ = zeros(sizeX,sizeY,sizeZ);
    newQ(:,:,1) = Q(:,:,1);
    for channel = 2:sizeZ
        for i=1:sizeX
            for j = 1:sizeY
                newQ(i,j,channel) = sign(Q(i,j,channel))*max(0, abs(Q(i,j,channel))-1/r);
            end
        end
    end
end