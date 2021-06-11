print('Метод Ньютона (касательных) для нахождения корня нелинейного уравнения \nВыполнил: Осипенко Данил Владимирович, студент 595 группы.\n')
f = lambda x: x**3-2*x-4
dx = 1e-3
df = lambda x: (f(x+dx) - f(x))/dx

eps = 1e-5
a, b = -20,20
x = (a+b)/2
print(f'x_0 = {x}, f(x_0) = {f(x)}, df(x_0) = {df(x)}')
x_n = x - f(x)/df(x)
i = 0
while abs(x_n - x) > eps:
    i+=1
    print(f'{i}: f(x_n) = {f(x_n)}, x_n = {x_n} ')
    x = x_n
    x_n = x - f(x)/df(x)

print(f'Результат для x_n: {x_n}')
