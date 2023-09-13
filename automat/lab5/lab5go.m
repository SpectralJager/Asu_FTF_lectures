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
phiZad = 30;
fConst = 0;

Ts0 = Ts;
aTs = linspace(1,110,110);
aSi = []; 
aTpp = [];
for Ts = aTs
    sim('lab5')
    
    y = phi(:,2);
    t = phi(:,1);
    yInf = y(end);
    diff = (y-yInf) / abs(yInf);
    si = max(diff) * 100;
    i = find(abs(diff) > 0.02);
    Tpp = t(max(i) + 1);
    %[si,Tpp] = overshoot(phi(:,1),phi(:,2));
    
    aSi = [aSi si];
    aTpp = [aTpp Tpp];
end;


figure(1);
subplot(2, 1, 1);
plot(aTs(:), aSi(:), 'b');
title('Transfer proccess when change kurs');
xlabel('Ts, sec');
ylabel('\delta, percent');
set(gca,'FontSize',16);
h = get(gca, 'Children');
set(h(1),'LineWidth',1.5);

subplot(2, 1, 2);
plot(aTs(:), aTpp(:), 'b');
xlabel('Ts, sec');
ylabel('Tpp, sec');
set(gca,'FontSize',16);
h = get(gca, 'Children');
set(h(1),'LineWidth',1.5);

