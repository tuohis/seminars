function ret = dSpO2(SpO2, NFB)
    a = -6.681524; 
    b = -19.937228; 
    c = 112.283411; 
    m_ir = 0.0002; % 0.02% modulation
    M = 2^(-NFB) / 6.6 / m_ir;
    arrSize = size(SpO2);
    ret = zeros(arrSize);
    for i = 1:arrSize(1)
        for j = 1:arrSize(2)
            ret(i,j) = sqrt(b^2 - 4*a*(c - SpO2(i,j))) * ( M^2 * (1-b/2/a) + M*b/2/a ) + M^2*(b^2/a/2 + b/2/a + b + a - c + SpO2(i,j)) + M*b;
        end
    end
end