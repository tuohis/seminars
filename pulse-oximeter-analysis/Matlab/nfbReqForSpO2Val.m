function ret = nfbReqForSpO2Val(SpO2, dSpO2, m_ir, algorithm)
    % Calibration coeffs
    a = -6.681524; 
    b = -19.937228; 
    c = 112.283411;
    % How much of the noise's energy is on the primary frequency component
    beta = 1; % experimental value
    %m_ir = 0.0002; 
    %dSpO2 = 1.5;
    %dR = sqrt(dSpO2 / abs(a));
    arrSize = size(SpO2);
    ret = zeros(arrSize);
    for i = 1:arrSize(1)
        for j = 1:arrSize(2)
            %ret(i,j) = log2(abs((2*a + b + sqrt(b^2 - 4*a*(c - SpO2(i,j)))) / (6.6*m_ir*(-b-sqrt(b^2 - 4*a*dSpO2)))));
            %ret(i,j) = log2((2*a + b + sqrt(b^2 - 4*a*(c - SpO2(i,j)))) / (13.2 * m_ir * sqrt(abs(a * dSpO2))));
            %ret(i,j) = log2((-b - sqrt(b^2 - 4*a*(c - SpO2(i,j)))) / (13.2 * m_ir * sqrt(abs(a * dSpO2))));
            %IR channel error depends on R, red channel error not
            currR = max([1 R(SpO2(i,j), [a b c])]);
            currdR = dR(SpO2(i,j), dSpO2, [a b c]);
            
            if strcmp(algorithm, 'fft')
                ret(i,j) = log2( sqrt(currR^2 + 1) * beta / sqrt(2 * currR * currdR) / 6.6 / m_ir);
            else
                ret(i,j) = log2( currR / 6.6 / m_ir / currdR );
            end
        end
    end
end