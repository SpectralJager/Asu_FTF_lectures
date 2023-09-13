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
Kaw = 2.604;

sim('lab6')

y = phi(:,4);
t = phi(:,1);
yInf = y(end);
diff = (y-yInf) / abs(yInf);
si = max(diff) * 100;
i = find(abs(diff) > 0.02);
Tpp = t(max(i) + 1);

figure(1);
subplot(2, 1, 1);
plot(phi(:,1), phi(:,2), 'b');
hold on;
plot(phi(:,1), phi(:,3), 'g');
hold on;
plot(phi(:,1), phi(:,4), 'r');
hold off;
title('Turn on 90 grad');
xlabel('Time, sec');
ylabel('\phi, grad');
legend('Lin sys', ...
       'Nonlin sys',...
       'Compens sys');
set(gca,'FontSize',16);
h = get(gca, 'Children');
set(h(1),'LineWidth',1.5);
set(h(2),'LineWidth',1.5);
set(h(3),'LineWidth',1.5);

subplot(2, 1, 2);
plot(delta(:,1), delta(:,2), 'b');
hold on;
plot(delta(:,1), delta(:,3), 'g');
hold on;
plot(delta(:,1), delta(:,4), 'r');
hold off;
xlabel('Time, sec');
ylabel('\delta, grad');
legend('Lin sys', ...
       'Nonlin sys',...
       'Compens sys');
set(gca,'FontSize',16);
h = get(gca, 'Children');
set(h(1),'LineWidth',1.5);
set(h(2),'LineWidth',1.5);
set(h(3),'LineWidth',1.5);
