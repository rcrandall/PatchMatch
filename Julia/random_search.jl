function random_search(patchTable,offsets,matchTable,searchHalfWin,numItRS)

    kmin = 1
    kmax = size(patchTable,3)
    vecLength = size(patchTable,4)*size(patchTable,5)
    flipped = [1; kmax:-1:2]

    for i = 1:size(patchTable,1)
        imin = max(1,i-searchHalfWin)
        imax = min(size(patchTable,1),i+searchHalfWin)
        for j = 1:size(patchTable,2)
            jmin = max(1,j-searchHalfWin)
            jmax = min(size(patchTable,2),j+searchHalfWin)

            for nIt = 1:numItRS
                ii = floor(rand*(imax-imin+1)) + imin
                jj = floor(rand*(jmax-jmin+1)) + jmin
                # Don't allow self-matching
                while(ii == i && jj == j)
                    ii = floor(rand*(imax-imin+1)) + imin
                    jj = floor(rand*(jmax-jmin+1)) + jmin
                end
                kk = floor(rand*(kmax-kmin+1)) + kmin
                d2 = sum(abs2(patchTable[i,j,1,:] - patchTable[ii,jj,kk,:]))/vecLength

                if(d2 < matchTable[i,j,2])
                    km = matchTable[i,j,1]
                    offsets[i,j,km,:] = [ii-i; jj-j; kk; d2]
                    (maxVal,maxInd) = findmax(offsets[i,j,:,4])
                    matchTable[i,j,1:2] = [maxInd; maxVal]
                end
                if(d2 < matchTable[ii,jj,2])
                    km = matchTable[ii,jj,1]
                    offsets[ii,jj,km,:] = [i-ii; j-jj; flipped[kk]; d2]
                    (maxVal,maxInd) = findmax(offsets[ii,jj,:,4])
                    matchTable[ii,jj,1:2] = [maxInd; maxVal]
                end
            end
        end
    end

    return offsets, matchTable
end
