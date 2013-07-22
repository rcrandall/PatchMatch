function propagate_even(patchTable,offsets,matchTable)

    vecLength = size(patchTable,4)*size(patchTable,5)
    kmatch = size(offsets,3)
    flipped = [1; size(patchTable,3):-1:2]

    for i = size(patchTable,1):-1:2
        for j = size(patchTable,2):-1:2
            for k = kmatch:-1:1
                ii = i + offsets[i,j,k,1]
                jj = j + offsets[i,j,k,2]
                kk = offsets[i,j,k,3]

                # Try to propagate match up
                if(ii - 1 >= 1)
                    d2 = sum(abs2(patchTable[i-1,j,kk,:] - patchTable[ii-1,jj,kk,:]))/vecLength
                    if(d2 < matchTable[i-1,j,2])
                        km = matchTable[i-1,j,1]
                        offsets[i-1,j,km,:] = [ii-i; jj-j; kk; d2]
                        (maxVal,maxInd) = findmax(offsets[i-1,j,:,4])
                        matchTable[i-1,j,1:2] = [maxInd; maxVal]
                    end
                    if(d2 < matchTable[ii-1,jj,2])
                        km = matchTable[ii-1,jj,1]
                        offsets[ii-1,jj,km,:] = [i-ii; j-jj; flipped[kk]; d2]
                        (maxVal,maxInd) = findmax(offsets[ii-1,jj,:,4])
                        matchTable[ii-1,jj,1:2] = [maxInd; maxVal]
                    end
                end

                # Try to propagate match right
                if(jj-1 >= 1)

                    d2 = sum(abs2(patchTable[i,j-1,kk,:] - patchTable[ii,jj-1,kk,:]))/vecLength
                    if(d2 < matchTable[i,j-1,2])
                        km = matchTable[i,j-1,1]
                        offsets[i,j-1,km,:] = [ii-i; jj-j; kk; d2]
                        (maxVal,maxInd) = findmax(offsets[i,j-1,:,4])
                        matchTable[i,j-1,1:2] = [maxInd; maxVal]
                    end
                    if(d2 < matchTable[ii,jj-1,2])
                        km = matchTable[ii,jj-1,1]
                        offsets[ii,jj-1,km,:] = [i-ii; j-jj; flipped[kk]; d2]
                        (maxVal,maxInd) = findmax(offsets[ii,jj-1,:,4])
                        matchTable[ii,jj-1,1:2] = [maxInd; maxVal]
                    end
                end

                # Try to propagate match down and right
                if(ii-1 >= 1 && jj-1 >= 1)
                    d2 = sum(abs2(patchTable[i-1,j-1,kk,:] - patchTable[ii-1,jj-1,kk,:]))/vecLength

                    if(d2 < matchTable[i-1,j-1,2])
                        km = matchTable[i-1,j-1,1]
                        offsets[i-1,j-1,km,:] = [ii-i; jj-j; kk; d2]
                        (maxVal,maxInd) = findmax(offsets[i-1,j-1,:,4])
                        matchTable[i-1,j-1,1:2] = [maxInd; maxVal]
                    end
                    if(d2 < matchTable[ii-1,jj-1,2])
                        km = matchTable[ii-1,jj-1,1]
                        offsets[ii-1,jj-1,km,:] = [i-ii; j-jj; flipped[kk]; d2]
                        (maxVal,maxInd) = findmax(offsets[ii-1,jj-1,:,4])
                        matchTable[ii-1,jj-1,1:2] = [maxInd; maxVal]
                    end
                end
            end
        end
    end

    return offsets, matchTable
end
