% Calibration coeffs
a = -6.681524; 
b = -19.937228; 
c = 112.283411;
DC = 5000; %DC current 5 uA == 5000 nA
m  = 0.0002; % modulation 0.02%
dS = 1; %SpO2 tolerance 3 %-units.
alpha = 0.3; % How much of the pleth energy is on the fundamental frequency
beta  = 1/64; % How much of the noise is on the same FFT band as the fundamental frequency
%beta = 1;

Ss = 70:100;
noise = zeros(size(Ss));
for i = 1:length(Ss)
    % Value of R corresponding to SpO2 value
    %cR = R(Ss(i), [a b c]);
    %noise(i) = min(abs((-2*a*cR - b + sqrt((2*a*cR)^2 - 4*a*dS)) * DC * m / 2 / a / (cR + 1)), ...
    %               abs((-2*a*cR - b + sqrt((2*a*cR)^2 + 4*a*dS)) * DC * m / 2 / a / (cR + 1)));
    
    R = (-b - sqrt(b^2 - 4*a*(c - Ss(i))))/2/a;
    dR = (sqrt(b^2 - 4*a*(c-Ss(i))) - sqrt(b^2 - 4*a*(c-Ss(i)+dS)))/2/a;
    %noise(i) = DC * m * sqrt(2 * alpha * dR / beta / (1/R + R));
    %noise(i) = DC * m * sqrt(alpha / beta) * sqrt( ((R + dR)^2 - R^2) / (1 + (R + dR)^2) );
    noise(i) = dR * DC * m * sqrt(alpha / beta) / sqrt(1 + R^2);
end

figure;
subplot(121);
plot(Ss, noise, 'k-');
xlabel('SpO2 reading (%)');
ylabel('Noise current (nA_{rms})');
title('Maximum system input-referred noise');
%legend('Tolerance up', 'Tolerance down');

subplot(122);
plot(Ss, 20.*log10(DC ./ noise), 'k-');
xlabel('SpO2 reading (%)');
ylabel('SNR (dB)');
title('Minimum system signal-to-noise ratio');
%legend('Tolerance up', 'Tolerance down');

figure;
plot(Ss, log2(DC ./ noise));
xlabel('SpO2 reading (%)');
ylabel('Noise Free Bits');
