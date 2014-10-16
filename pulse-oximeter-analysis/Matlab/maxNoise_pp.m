% Calibration coeffs
a = -6.681524; 
b = -19.937228; 
c = 112.283411;
DC = 5000; %DC current 5 uA == 5000 nA
m  = 0.0002; % modulation 0.02%
dS = 1; %SpO2 tolerance 3 %-units.

Ss = 70:100;
noise = zeros(length(Ss), 3);
for i = 1:length(Ss)
    % Value of R corresponding to SpO2 value
    %cR = R(Ss(i), [a b c]);
    %noise(i) = min(abs((-2*a*cR - b + sqrt((2*a*cR)^2 - 4*a*dS)) * DC * m / 2 / a / (cR + 1)), ...
    %               abs((-2*a*cR - b + sqrt((2*a*cR)^2 + 4*a*dS)) * DC * m / 2 / a / (cR + 1)));
    
    %sq1 = sqrt(b^2 - 4*a*(c - Ss(i)));
    %sq2 = sqrt(b^2 - 4*a*(c - Ss(i) + dS));
    %sq3 = sqrt(b^2 - 4*a*(c - Ss(i) - dS)); % tolerance both ways
    %noise(i, 1) = abs(DC*m / (2*a - b - sq1) * (sq1 - sq2));
    %noise(i, 2) = abs(DC*m / (2*a - b - sq1) * (sq1 - sq3));
    %noise(i, 3) = min(noise(i,1), noise(i,2));
    
    R = (-b - sqrt(b^2 - 4*a*(c - Ss(i))))/2/a;
    dR = (sqrt(b^2 - 4*a*(c-Ss(i))) - sqrt(b^2 - 4*a*(c-Ss(i)+dS)))/2/a;
    noise(i,3) = DC * m * dR /sqrt(1+R^2);
    %noise(i,3) = DC * m * (sqrt(b^2 - 4*a*(c-Ss(i))) - sqrt(b^2 - 4*a*(c-Ss(i)-dS))) / sqrt(4*a^2 - 4*a*(c-Ss(i)) + 2*b^2 + 2*b*sqrt(b^2-4*a*(c-Ss(i))));
end

figure;
subplot(121);
plot(Ss, noise(:,3), 'k-');
xlabel('SpO2 reading (%)');
ylabel('Noise current (nA_{pp})');
title('Maximum system input-referred noise');
%legend('Tolerance up', 'Tolerance down');

subplot(122);
plot(Ss, 20.*log10(DC ./ (noise(:,3)./6.6)), 'k-'); % 6.6-sigma noise
xlabel('SpO2 reading (%)');
ylabel('SNR (dB)');
title('Minimum system signal-to-noise ratio');
%legend('Tolerance up', 'Tolerance down');

figure;
plot(Ss, log2(DC ./ noise(:,3)));
xlabel('SpO2 reading (%)');
ylabel('Noise Free Bits');
