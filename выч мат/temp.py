import numpy as np
import matplotlib.pyplot as plt

#Начальная функция
f = lambda x: 1/10 * (np.log(x)/2)**np.sin(x)

# определяем границы и точки, в которые будем приближать наш полином
a , b , p = 0,20,100
x = np.linspace(a,b,p)

n = int(input('Введите степень апраксимации : '))

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
def polinom(x): 
    # Yi = solve * Xi где Xi = x^i
    tiles = np.tile(x, (n, 1))
    tiles[0] = np.ones(x.size)
    for index in range(1, n):
        tiles[index] = tiles[index]**index
    return solve.dot(tiles)

# рисуем график функции и ее приблеженного полинома
plt.plot(x, f(x))
plt.plot(x, polinom(x))
plt.show()

# вывод коэффицентов
print(solve)