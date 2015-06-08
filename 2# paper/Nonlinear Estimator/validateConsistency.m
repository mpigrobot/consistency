% Demonstrate consistency of nonlinear estimator.Tune the values of noise
% scalar to get different results.
clear all; close all; clc;
% path(path,genpath('../'));
tunenoises;
width = 1.5;
%% plot the normalized innovation square
s = 1 : step;
[normY, meanY, chiUp, chiLow] ...
    = chiSquareTest(innov, SigmaInnov, 'movingAverage');
[normY1, meanY1, chiUp1, chiLow1] ...
    = chiSquareTest(innov1, SigmaInnov1, 'movingAverage');
[normY2, meanY2, chiUp2, chiLow2] ...
    = chiSquareTest(innov2, SigmaInnov2, 'movingAverage');
[normY3, meanY3, chiUp3, chiLow3] ...
    = chiSquareTest(innov3, SigmaInnov3, 'movingAverage');
[normY4, meanY4, chiUp4, chiLow4] ...
    = chiSquareTest(innov4, SigmaInnov4, 'movingAverage');
%% plot figure of NIS(normalized innovations square) use different process/observation noise levels
figure('Name', '非线性过程噪声','color','w');
% figure('Name', '非线性观测噪声','color','w');
hold on; box on; 
subplot(2,2,[1,3])
h = plot(s, meanY, 'g--', s, meanY1, 'c-.',s, meanY2, 'r:',s, meanY3, 'y--',...
    s, meanY4, 'm-.', s, chiUp, 'b-', s, chiLow, 'b-');
set(h, 'linewidth', width);
legend('0.3*trueNoise','0.5*trueNoise','trueNoise','10*trueNoise',...
    '50*trueNoise','95%置信区间');
% legend('0.6*trueNoise','0.8*trueNoise','trueNoise','2*trueNoise',...
%     '10*trueNoise','95%置信区间');
xlim([min(s), max(s)]);
xlabel('时间(s)');
ylabel('正则化新息平方的均值(m^2)');
%% plot figure of normalized autocorrelation function in the respect of under-estimate process/observation noise level
[x_row,y_row] = size(innov);
% change the storage form of innov to use function "auto.m" 
for j = 1:y_row
    start = 1+(j-1) * x_row;
    final = j * x_row;
    x(start:final) = innov(:,j);
end
ss = 1 : step;
sss = 0 : 0.5 : step;
Rxx = auto(x);
chiUpxx = 2/sqrt(step);
chiLowxx = -2/sqrt(step);
hold on
subplot(2,2,2)
hh = plot(ss, Rxx, '--g',sss, chiUpxx, 'b-', sss, chiLowxx, 'b-');
set(hh, 'linewidth', 1.3);
legend('0.3*trueNoise','95%置信区间');
% legend('0.6*trueNoise','95%置信区间');
xlim([min(ss), max(ss)]);
xlabel('时间(s)');
ylabel('归一化自相关函数');
%% plot figure of normalized autocorrelation function in the respect of over-estimate process/observation noise level
[x_row4,y_row4] = size(innov4);
% change the storage form of innov to use function "auto.m" 
for j = 1:y_row4
    start4 = 1+(j-1) * x_row4;
    final4 = j * x_row4;
    x4(start4:final4) = innov4(:,j);
end
s4 = 1 : step;
s5 = 1 : 0.5 : step;
Rxx4 = auto(x4);
chiUpxx1 = 2/sqrt(step);
chiLowxx1 = -2/sqrt(step);
hold on
subplot(2,2,4)
hhh = plot(s4, Rxx4, 'm-.',s5, chiUpxx1, 'b-', s5, chiLowxx1, 'b-');
set(hhh, 'linewidth', 1.3);
legend('50*trueNoise','95%置信区间');
% legend('10*trueNoise','95%置信区间');
xlim([min(ss), max(ss)]);
xlabel('时间(s)');
ylabel('归一化自相关函数');
%% plot figure of NIS(normalized innovations square) use exactly matched process and observation noise levels
figure('Name', '非线性真实噪声一致性检测','color','w');
hold on; box on; 
subplot(2,1,1)
h = plot(s, normY2, 'g--', s, meanY2, 'r-.',...
         s, chiUp2, 'b-', s, chiLow2, 'b-');
set(h, 'linewidth', width);
legend('正则化新息平方','正则化新息平方的均值', '95%置信区间');
xlim([min(s), max(s)]);
xlabel('时间(s)');
ylabel('正则化新息平方(m^2)');
%% plot figure of normalized autocorrelation function use exactly matched process and observation noise levels
[x_row2,y_row2] = size(innov2);
for j = 1:y_row2
    start = 1+(j-1) * x_row2;
    final = j * x_row2;
    x2(start:final) = innov2(:,j);
end
ss = 1 : step;
sss = 1 : 0.2 : step;
Rxx2 = auto(x2);
chiUpxx2 = 2/sqrt(step);
chiLowxx2 = -2/sqrt(step);
hold on;
subplot(2,1,2)
hh = plot(ss, Rxx2, 'm-.',sss, chiUpxx2, 'b-', sss, chiLowxx2, 'b-');
set(hh, 'linewidth', 1.5);
legend('trueNoise','95%置信区间');
xlim([min(ss), max(ss)]);
xlabel('时间(s)');
ylabel('归一化自相关函数');

