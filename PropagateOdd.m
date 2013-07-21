function [offsets,matchTable] = PropagateOdd(patchTable,offsets,matchTable)

    kmatch = size(offsets,3);

    for i = 1:(size(patchTable,1)-1)
        for j = (size(patchTable,2)-1)
            for k = 1:kmatch
                ii = i + offsets(i,j,k,1);
                jj = j + offsets(i,j,k,2);
                
                % Try to propagate match down
                if(ii + 1 <= size(patchTable,1))
                    d2 = norm(squeeze(patchTable(i+1,j,:) - patchTable(ii+1,jj,:)))^2;                   
                    if(d2 < matchTable(i+1,j,2))
                        km = matchTable(i+1,j,1);
                        offsets(i+1,j,km,1:2) = [ii-i;jj-j];
                        offsets(i+1,j,km,3) = d2;
                        [maxVal,maxInd] = max(offsets(i+1,j,:,3));
                        matchTable(i+1,j,1:2) = [maxInd;maxVal];
                        
                        if(matchTable(i+1,j,2)~=max(offsets(i+1,j,:,3)))
                            disp('oh noes')
                        end
                    end
                    if(d2 < matchTable(ii+1,jj,2))
                        km = matchTable(ii+1,jj,1);
                        offsets(ii+1,jj,km,1:2) = [i-ii,j-jj];
                        offsets(ii+1,jj,km,3) = d2;
                        [maxVal,maxInd] = max(offsets(ii+1,jj,:,3));
                        matchTable(ii+1,jj,1:2) = [maxInd;maxVal];
                    end
                end

                % Try to propagate match right
                if(jj+1 <= size(patchTable,2))
                    d2 = norm(squeeze(patchTable(i,j+1,:) - patchTable(ii,jj+1,:)))^2;
                    if(d2 < matchTable(i,j+1,2))
                        km = matchTable(i,j+1,1);
                        offsets(i,j+1,km,1:2) = [ii-i;jj-j];
                        offsets(i,j+1,km,3) = d2;
                        [maxVal,maxInd] = max(offsets(i,j+1,:,3));
                        matchTable(i,j+1,1:2) = [maxInd;maxVal];
                    end
                    if(d2 < matchTable(ii,jj+1,2))
                        km = matchTable(ii,jj+1,1);
                        offsets(ii,jj+1,km,1:2) = [i-ii;j-jj];
                        offsets(ii,jj+1,km,3) = d2;
                        [maxVal,maxInd] = max(offsets(ii,jj+1,:,3));
                        matchTable(ii,jj+1,1:2) = [maxInd;maxVal];
                    end
                end

                % Try to propagate match down and right
                if(ii+1 <= size(patchTable,1) && ...
                   jj+1 <= size(patchTable,2))
                    d2 = norm(squeeze(patchTable(i+1,j+1,:) - patchTable(ii+1,jj+1,:)))^2;

                    if(d2 < matchTable(i+1,j+1,2))
                        km = matchTable(i+1,j+1,1);
                        offsets(i+1,j+1,km,1:2) = [ii-i;jj-j];
                        offsets(i+1,j+1,km,3) = d2;
                        [maxVal,maxInd] = max(offsets(i+1,j+1,:,3));
                        matchTable(i+1,j+1,1:2) = [maxInd;maxVal];
                    end
                    if(d2 < matchTable(ii+1,jj+1,2))
                        km = matchTable(ii+1,jj+1,1);
                        offsets(ii+1,jj+1,km,1:2) = [i-ii;j-jj];
                        offsets(ii+1,jj+1,km,3) = d2;
                        [maxVal,maxInd] = max(offsets(ii+1,jj+1,:,3));
                        matchTable(ii+1,jj+1,1:2) = [maxInd;maxVal];
                    end
                end
            end
        end
    end

end