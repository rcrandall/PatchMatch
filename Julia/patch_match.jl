require("propagate_even")
require("propagate_odd")
require("random_search")
require("init_table_rand")

function patch_match(patchTable,kmatch)

    searchHalfWin = 19
    (offsets,matchTable) = init_table_rand(patchTable,searchHalfWin,kmatch)
println("go1")
    numIt = 10
    for i = 1:numIt
       # Propagate matches down and right on odd steps, up and left on even
       if(iseven(i))
            println("go2")
           (offsets,matchTable) = propagate_even(patchTable,offsets,matchTable)
       else
            println("go3")
           (offsets,matchTable) = propagate_odd(patchTable,offsets,matchTable)
       end
       println(mean(matchTable[:,:,2]))
       (offsets,matchTable) = random_search(patchTable,offsets,matchTable,searchHalfWin,1);
       println(mean(matchTable[:,:,2]))
    end
    return offsets, matchTable
end
