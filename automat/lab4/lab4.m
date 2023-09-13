Ts = 16.4;
K = 0.08;
Tr = 1;
Toc = 3;
Ti = 200;
Kc = 1.04;




figure(1);
subplot(2, 1, 1);
plot(phi(:,1), phi(:,2), 'b');
hold on;
plot(phi(:,1), phi(:,3), 'g');
hold off;
title('Turn on 90 grad');
xlabel('Time, sec');
ylabel('\phi, grad');
legend('Lin sys', ...
       'Nonlin sys');
set(gca,'FontSize',16);
h = get(gca, 'Children');
set(h(1),'LineWidth',1.5);
set(h(2),'LineWidth',1.5);

subplot(2, 1, 2);
plot(delta(:,1), delta(:,2), 'b');
hold on;
plot(delta(:,1), delta(:,3), 'g');
hold off;
xlabel('Time, sec');
ylabel('\delta, grad');
legend('Lin sys', ...
       'Nonlin sys');
set(gca,'FontSize',16);
h = get(gca, 'Children');
set(h(1),'LineWidth',1.5);
set(h(2),'LineWidth',1.5);



