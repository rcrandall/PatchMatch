
require("patch_match")

P = randn(100,100,1,8,8)

@time (offsets,matchTable) = patch_match(P,7)
