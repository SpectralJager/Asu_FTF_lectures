import numpy as np
import matplotlib.pyplot as plt

print(f'Аппроксимация функции в базисе алгебраических многочленов по методу МНК \n Выполнил: Осипенко Данил')
#Начальная функция
f = lambda x: 1/10 * (np.log(x)/2)**np.sin(x)

# определяем границы и точки, в которые будем приближать наш полином
a , b , p = 0,20,100
x = np.linspace(a,b,p)

n = int(input('Введите степень апроксимации : '))

offset = (b-a)/n
points = np.array([offset*i for i in range(1,n+1)])

# Получим значения функции в данных точках
y = f(points)

# создаем матрицу коэф. системы линейных уровнений
A = np.zeros((n, n))
for index in range(0, n):
    A[index] = np.power(np.full(n, points[index]), np.arange(0, n, 1))


# решим систему лин. ур. и получим значения коэффицентов
solve = np.linalg.solve(A,y)

# Определим функцию алгебраического многочлена
# y_i = a_0 * x**0 + ... + a_n * x**n.
polinom = lambda x: [np.sum([solve[j] * i**j for j in range(n)]) for i in x]

# рисуем график функции и ее приблеженного полинома
plt.plot(x, f(x))
plt.plot(x, polinom(x))
plt.show()

#Проверка на верность решения
print(np.allclose(np.dot(A,solve),y))

# вывод коэффицентов
print(solve)