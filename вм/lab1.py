import numpy as np
import matplotlib.pyplot as plt

#--------------------------
print('Аппроксимация функции в базисе алгебраических многочленов по методу МНК \nВыполнил: Осипенко Данил Владимирович, студент 595 группы.\n')

#--------------------------
f = lambda x: 1/(1+np.exp(-1*x))
p = lambda x,a,k: sum([a[i]*(x**i) for i in range(k)])
F = lambda x,y,a,k,n: sum([(y[i] - p(x[i],a,k))**2 for i in range(n)])
#--------------------------
num = 15
max_ord = 5
l,r = -15,15
X = np.linspace(l,r,num)
Y = f(X)

#--------------------------
plt.xlim(l,r)
plt.ylim(-1,2)
plt.plot(X,Y,'o',label='f(x)')

#--------------------------
print('Результаты вычислений:')
for k in range(1,max_ord+1,):
    matrx = np.ndarray((num,k))
    for i in range(num):
        for j in range(k):
            matrx[i,j] = X[i]**j
    a = np.dot(np.matmul(np.linalg.inv(np.matmul(matrx.T,matrx)),matrx.T),Y)
    print(f'\tпогрешность для степени {k} = {F(X,Y,a,k,num)}')
    plt.plot(X,p(X,a,k),label=f'ord {k}')

#--------------------------
plt.legend(bbox_to_anchor=(0.5, 1), loc='upper left', borderaxespad=0.)
plt.show()