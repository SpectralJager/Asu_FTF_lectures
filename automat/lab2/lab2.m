Ts = 16.4;
K = 0.08;
TR = 1;
Toc = 3;

P = tf(K, [Ts 1 0]);
R0 = tf(1,[TR 0]);
R = feedback(R0, 1);
G = P*R;

H = tf(1, [Toc 1]);
L = G*H;
Tv = 1;

Cpd = 1 +tf([Ts 0], [Tv 1]);

W = C*G/(1+C*G*H);
W=minreal(W);

Wu = minreal(C/(1+C*G*H));
