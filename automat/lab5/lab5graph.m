function lab5graph(phi, delta)
figure(1);
subplot(2, 1, 1);
plot(phi(:,1), phi(:,2), 'b');
title('Transfer proccess when change kurs');
xlabel('Time, sec');
ylabel('\phi, grad');
legend('Lin sys', ...
       'Nonlin sys');
set(gca,'FontSize',16);
h = get(gca, 'Children');
set(h(1),'LineWidth',1.5);

subplot(2, 1, 2);
plot(delta(:,1), delta(:,2), 'b');
xlabel('Time, sec');
ylabel('\delta, grad');
legend('Lin sys', ...
       'Nonlin sys');
set(gca,'FontSize',16);
h = get(gca, 'Children');
set(h(1),'LineWidth',1.5);
