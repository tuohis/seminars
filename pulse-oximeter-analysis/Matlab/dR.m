function ret = dR(SpO2, dSpO2, params)
    a = params(1);
    b = params(2);
    c = params(3);
    % Errors in both directions, return the greatest
    ret1 = abs((sqrt(b^2 - 4*a*(c - SpO2)) - sqrt(b^2 - 4*a*(c - SpO2 - dSpO2))) / 2 / a);
    ret2 = abs((sqrt(b^2 - 4*a*(c - SpO2)) - sqrt(b^2 - 4*a*(c - SpO2 + dSpO2))) / 2 / a);
    ret = max([ret1 ret2]);
end