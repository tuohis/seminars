% change dir
cd 'D:\Documents and Settings\100042443\My Documents\dippa\Matlab\';

% load 100Hz pleth data
a = load('pleth5.tld.mat');
a = a.compositePleth;
% use 10 seconds worth of data
b = a(1:1000, :);

N = length(b);
% visualize
figure;
plot(1:N, b(:,1), 'r-', 1:N, b(:,2), 'b-');
title('Pleth measurement');

% get the power spectrum
f1 = fft(b(:,1));
f2 = fft(b(:,2));
P1 = abs(f1/(N/2));
P1 = P1(1:floor(N/2)).^2;
P2 = abs(f2/(N/2));
P2 = P2(1:floor(N/2)).^2;

% 100 Hz
freq = (0:floor(N/2)-1)*100/N;

figure;
%bar(freq, [P1 P2]);
plot(freq, P1, 'r-', freq, P2, 'b-');
title('Power Spectrum of a 10-second Plethysmographic Signal');
legend('Red', 'IR');
xlabel('f (Hz)');
%xlim([0 10]);
%ylim([0 20*10^8]);

% Plot also the spectrum of the whole data set, showing the respiratory
% spike et al.
P3 = abs(fft(a(:,1))/length(a)*2);
P3 = P3(1:floor(length(a)/2)).^2;
P4 = abs(fft(a(:,2))/length(a)*2);
P4 = P4(1:floor(length(a)/2)).^2;
freq2 = (0:floor(length(a)/2)-1)*100/length(a);
figure;
plot(freq2, P3, 'r-', freq2, P4, 'b-');
title('Power Spectrum of a 35-second Plethysmographic Signal');
legend('Red', 'IR');
xlabel('f (Hz)');
xlim([0 10]);
ylim([0 20*10^8]);