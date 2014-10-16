function ret = SpO2(R, params)
    a = params(1);
    b = params(2);
    c = params(3);
    
    ret = a*R^2 + b*R + c;
end