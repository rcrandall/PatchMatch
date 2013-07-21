function [offsets,matchTable] = PatchMatch(patchTable,kmatch,offsets)

    searchHalfWin = 19;

    if(nargin < 3)
        [offsets,matchTable] = InitTableRand(patchTable,searchHalfWin,kmatch);
    end
    
    numIt = 10;
    for i = 1:numIt
       disp(['iteration ' int2str(i)])
        if(mod(i,2)==0)
            [offsets,matchTable] = PropagateEven(patchTable,offsets,matchTable);
        else
            [offsets,matchTable] = PropagateOdd(patchTable,offsets,matchTable);
        end
        mean(mean(matchTable(:,:,2)))
        [offsets,matchTable] = RandomSearch(patchTable,offsets,matchTable,searchHalfWin,1);
        mean(mean(matchTable(:,:,2)))
    end
    
end