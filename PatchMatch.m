function [offsets,matchTable] = PatchMatch(patchTable,kmatch,offsets,matchTable)

    searchHalfWin = 19;

%     if(nargin < 3)
        [offsets,matchTable] = InitTableRand(patchTable,searchHalfWin,kmatch);
%     end
    sw = (size(patchTable,1)-1)/2;
    
    numIt = 10;
    for i = 1:numIt
       disp(['iteration ' int2str(i)])
       % Propagate matches down and right on odd steps, up and left on even
        if(mod(i,2)==0)
            [offsets,matchTable] = PropagateEven(patchTable((sw+1):end,:,:,:),offsets,matchTable);
        else
            [offsets,matchTable] = PropagateOdd(patchTable((sw+1):end,:,:,:),offsets,matchTable);
        end
        mean(mean(matchTable(:,:,2)))
        [offsets,matchTable] = RandomSearch(patchTable((sw+1):end,:,:,:),offsets,matchTable,searchHalfWin,1);
        mean(mean(matchTable(:,:,2)))
    end
    
end