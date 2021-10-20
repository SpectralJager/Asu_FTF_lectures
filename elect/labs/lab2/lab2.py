import numpy as np
import matplotlib.pyplot as plt

table = np.ndarray((11,6))
E = 1.3
Rext = 4.19
Rl = np.linspace(0,4*Rext,11)

i = 0
for Rli in Rl:
	I = 1.3/(Rext+Rli)
	Pl = (I**2)*Rli
	Psrc = (I**2)*(Rli+Rext)
	temp = np.array([
		Rli,
		I,
		Pl,
		Psrc,
		Pl/Psrc,
		I*Rli
	])
	table[i] = temp
	i += 1

print(Rl)
print(table)

plt.subplot(211)
plt.plot(Rl, table[:,4],label='x')
plt.subplot(212)
plt.plot(Rl, table[:,2])
plt.show()