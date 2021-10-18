import numpy as np

R = np.array([8.,1.,3.,5.,8.,1.])
R_con = np.array([8.864, 0.864, 6.333, 3.333, 10, 9])
U = np.zeros(6)
I_mod = np.array([1.692,1.461,230.9*(10**-3),153.9*(10**-3),76.96*(10**-3),76.96*(10**-3)])
I_re = np.array([1.692,1.462,0.231,0.1538,0.0769,0.0769])

I_re[0] = 15/R_con[0]
U[1] = R_con[1]*I_re[1]
I_re[1] = U[1]/R[1]
I_re[2] = U[1]/R_con[3]
U[3] = R_con[3]*I_re[2]
I_re[3] = U[3]/R[3]
I_re[4] = U[3]/R_con[4]
I_re[5] = I_re[4]

print(I_re)
print(U)
