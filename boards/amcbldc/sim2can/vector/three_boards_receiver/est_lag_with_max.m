function [D] = est_lag_with_max(s1,s2)

[m1 ,i1] = max(s1);
[m2 ,i2] = max(s2);

D = i1 - i2;
end

