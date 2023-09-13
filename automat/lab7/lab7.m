clear all;
clc;
Ts = 16.4;
K = 0.08;
Tr = 1;
Toc = 3;
Ti = 200;
Kc = 1.04;
ddMax = 3;
deltaMax = 30;
phiZad = 90;
fConst = 0;
Kaw = 2.604;

T = 1;
Cpd = tf(Kc*[Ts+1 1], [1 1]);

close all;
figure(1);
subplot(2,1,1);
set(gca, 'FontSize', 16);
subplot(2,1,2);
set(gca, 'FontSize', 16);

aT = [2 3 5];
col = 'bgr';
for i=1:length(aT)
    T = aT(i);
    Dpd = c2d(Cpd, T, 'tustin');
    [nD, dD] = tfdata(Dpd);
    nD = cell2mat(nD);
    dD = cell2mat(dD);
    sim('lab7')
    subplot(2,1,1);
    plot(phi(:,1),phi(:,3),col(i));
    hold on;
    subplot(2,1,2);
    plot(delta(:,1),delta(:,3),col(i));
    hold on;
end

subplot(2,1,1);
plot(phi(:,1),phi(:,2),'k--');
hold off;
legend('T=2', 'T=3', 'T=5', 'Contin. Sys');
h = get(gca, 'Children');
for i=1:4
    set(h(i),'LineWidth',1.5);
end;

subplot(2,1,2);
plot(delta(:,1),delta(:,2),'k--');
hold off;
legend('T=2', 'T=3', 'T=5', 'Contin. Sys');
h = get(gca, 'Children');
for i=1:4
    set(h(i),'LineWidth',1.5);
end;
    
    
    
    