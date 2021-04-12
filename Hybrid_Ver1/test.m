function test(A)

rep = 10;
SUM = 0;

for i = 1 : rep
    Ai = A{1, i};
    SUM = SUM + sum(diff(Ai) == 0);
end

SUM

end