n2 = 1.2;
n1 = 1.08;
n0 = 0.096;
d1 = 2.3727;
d2 = 2.2264;
d0 = 0.9091;

n = [n2 n1 n0];
d = [1 d2 d1 d0];

f = tf(n,d);

z = zero(f);
p = pole(f);
k = dcgain(f);
b = bandwidth(f);
f_ss = ss(f);
f_ss.d = 1;
k1 = dcgain(f_ss);
f_zp = zpk(f);

[wc,ksi,p] = damp(f);

w = logspace(-1, 2 ,100);
r = freqresp(f,w);
r = r(:);
[u, t] = gensig('square', 4);

