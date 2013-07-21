function [offsets,matchTable] = RandomSearch(patchTable,offsets,matchTable,searchHalfWin,numItRS)

    for i = 1:size(patchTable,1)
        imin = max(1,i-searchHalfWin);
        imax = min(size(patchTable,1),i+searchHalfWin);
        for j = 1:size(patchTable,2)
            jmin = max(1,j-searchHalfWin);
            jmax = min(size(patchTable,2),j+searchHalfWin);

            for nIt = 1:numItRS
                ii = floor(rand*(imax-imin+1)) + imin;
                jj = floor(rand*(jmax-jmin+1)) + jmin;
                % Don't allow self-matching
                while(ii == i && jj == j)
                    ii = floor(rand*(imax-imin+1)) + imin;
                    jj = floor(rand*(jmax-jmin+1)) + jmin;
                end
                d2 = norm(squeeze(patchTable(i,j,:) - patchTable(ii,jj,:)))^2;

                if(d2 < matchTable(i,j,2))
                    km = matchTable(i,j,1);
                    offsets(i,j,km,1:2) = [ii-i;jj-j];
                    offsets(i,j,km,3) = d2;
                    [maxVal,maxInd] = max(offsets(i,j,:,3));
                    matchTable(i,j,1:2) = [maxInd;maxVal];
                end
                if(d2 < matchTable(ii,jj,2)) 
                    km = matchTable(ii,jj,1);
                    offsets(ii,jj,km,1:2) = [i-ii;j-jj];
                    offsets(ii,jj,km,3) = d2;
                    [maxVal,maxInd] = max(offsets(ii,jj,:,3));
                    matchTable(ii,jj,1:2) = [maxInd;maxVal];
                end
            end
        end
    end

end