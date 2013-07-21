
function [offsets,maxTable] = InitTableRand(patchTable,searchHalfWin,kmatch)

    offsets = zeros(size(patchTable,1),size(patchTable,2),kmatch,3);
    if(nargout == 2)
       maxTable = 1e6*ones(size(patchTable,1),size(patchTable,2),2); 
    end
    
    % Randomly initialize matches
    for i = 1:size(patchTable,1)
        imin = max(1,i-searchHalfWin);
        imax = min(size(patchTable,1),i+searchHalfWin);
        for j = 1:size(patchTable,2)
            jmin = max(1,j-searchHalfWin);
            jmax = min(size(patchTable,2),j+searchHalfWin);
            
            % Warning - uniqueness not guaranteed at this point!
            for k = 1:kmatch
                % Don't self-match
                while(offsets(i,j,k,1) == 0 && offsets(i,j,k,2) == 0)
                    offsets(i,j,k,1:2) = [floor(rand*(imax - imin + 1)) + imin - i;...
                                      floor(rand*(jmax - jmin + 1)) + jmin - j];
                end
                offsets(i,j,k,3) = norm(squeeze(patchTable(i,j,:) - ...
                                      patchTable(i + offsets(i,j,k,1),j + offsets(i,j,k,2),:)))^2;
            end
            
            [maxVal,maxInd] = max(offsets(i,j,:,3));
            maxTable(i,j,:) = [maxInd; maxVal];
        end
    end

end