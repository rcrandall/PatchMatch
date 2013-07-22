
function [offsets,maxTable] = InitTableRand(patchTable,searchHalfWin,kmatch)

    vecLength = size(patchTable,4)*size(patchTable,5);
    offsets = zeros(size(patchTable,1),size(patchTable,2),kmatch,4);
    if(nargout == 2)
       maxTable = 1e6*ones(size(patchTable,1),size(patchTable,2),2); 
    end
    
    % Randomly initialize matches
    for i = 1:size(patchTable,1)
        % Constrain offsets using search window size and boundaries
        imin = max(1,i-searchHalfWin);
        imax = min(size(patchTable,1),i+searchHalfWin);
        for j = 1:size(patchTable,2)
            jmin = max(1,j-searchHalfWin);
            jmax = min(size(patchTable,2),j+searchHalfWin);
            
            % Warning - uniqueness not guaranteed at this point for knn!
            % Fix this!
            for k = 1:kmatch
                % Don't self-match
                while(offsets(i,j,k,1) == 0 && offsets(i,j,k,2) == 0)
                      offsets(i,j,k,1:3) = [floor(rand*(imax - imin + 1)) + imin - i;...
                                            floor(rand*(jmax - jmin + 1)) + jmin - j;...
                                            1];
                end
                offsets(i,j,k,4) = sum(sum((patchTable(i,j,1,:,:) - ...
                                            patchTable(i + offsets(i,j,k,1),j + offsets(i,j,k,2),1,:,:)).^2))/vecLength;
            end
            
            [maxVal,maxInd] = max(offsets(i,j,:,4));
            maxTable(i,j,:) = [maxInd; maxVal];
        end
    end

end