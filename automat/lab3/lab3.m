Ts = 16.4;
Tv = 1;
K = 0.08;
Kc = 1.04;
Tr = 1;
Toc = 3;
Ti = 200;

Rs = tf([1],[Tr 1]);
Fs = tf([K],[Ts 1 0]);
Hs = tf([1],[Toc 1]);
Cspd = Kc*(1 + tf([Ts 0],[Tv 1]));
Cspid = Cspd + tf([1],[Ti 0]);
Ww1 = Fs/(1+Rs*Cspd*Hs*Fs);
Ww2 = Fs/(1+Rs*Cspid*Hs*Fs);

% phi0 = phi;
%delta0 = delta;

figure(1);
subplot(2, 1, 1);
plot(phi0(:,1), phi0(:,2),...
    phi(:,1), phi(:,2));
title('????');
xlabel('Time, sec');
ylabel('\phi, grad');
legend('??-?????????', ...
'???-?????????');


subplot(2, 1, 2);
plot(delta0(:,1), delta0(:,2),...
    delta(:,1), delta(:,2));
title('???? ???????? ????');
xlabel('Time, sec');
ylabel('\delta, grad');
legend('??-?????????', ...
'???-?????????');

