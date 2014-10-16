function ret = nfbReqForModPercent(SpO2, dSpO2, m_ir, algorithm)
    % Calibration coeffs
    a = -6.681524; 
    b = -19.937228; 
    c = 112.283411;
    % How much of the noise's energy is on the primary frequency component
    beta = 0.5; % 1/8; experimental value
    currR = max([1 R(SpO2, [a b c])]);
    currdR = dR(SpO2, dSpO2, [a b c]);
    
    arrSize = size(m_ir);
    ret = zeros(arrSize);
    for i = 1:arrSize(1)
        for j = 1:arrSize(2)
            %ret(i,j) = log2(abs((2*a + b + sqrt(b^2 - 4*a*(c - SpO2(i,j)))) / (6.6*m_ir*(-b-sqrt(b^2 - 4*a*dSpO2)))));
            %ret(i,j) = log2((2*a + b + sqrt(b^2 - 4*a*(c - SpO2(i,j)))) / (13.2 * m_ir * sqrt(abs(a * dSpO2))));
            %ret(i,j) = log2((-b - sqrt(b^2 - 4*a*(c - SpO2(i,j)))) / (13.2 * m_ir * sqrt(abs(a * dSpO2))));
            %IR channel error depends on R, red channel error not
            
            if strcmp(algorithm, 'fft')
                %ret(i,j) = log2( sqrt(currR^2 + 1) * beta / sqrt(2 * currR * currdR) / 6.6 / m_ir(i,j));
                ret(i,j) = log2(sqrt(2*(currR + 1/currR)) / 6.6 / m_ir(i,j) / sqrt(currdR)) + log2(beta);
            else
                ret(i,j) = log2( currR / 6.6 / m_ir(i,j) / currdR );
            end
        end
    end
end