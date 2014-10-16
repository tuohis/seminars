function ret = R(SpO2, params)
    a = params(1);
    b = params(2);
    c = params(3);
    ret = (-b - sqrt(b^2 - 4*a*(c- SpO2))) / 2 / a;
end