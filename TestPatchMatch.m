

P = randn(100,100,3,8,8);

tic
[offsets,matchTable] = PatchMatch(P,7);
toc