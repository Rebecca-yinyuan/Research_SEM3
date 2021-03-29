function C = update_C_test(S, I, C, C0)

for i = 1 : I(length(I))
    u4 = rand;
    C(i) = -log(u4) / (C0 * S(length(S)));
end

end