import numpy as np
#-----------------------------
print('Метод Гаусса для решения системы линейных алгебраических уравнений \nВыполнил: Осипенко Данил Владимирович, студент 595 группы.\n')
#-----------------------------
n = 3
A = np.array([
    [2,4,1],
    [5,2,1],
    [2,3,4],],dtype='float32')
b = np.array([
    36,
    47,
    37],dtype='float32')
print('Решение СЛАУ в матричной форме Ax=b')
print(f'Матрица А:\n {A}')
print(f'Матрица b: {b}')
#-----------------------------
for j in range(n-1):
    row_index = j
    for i in range(j,n):
        if A[row_index,j] < A[i,j]:
            row_index =  i
    A[[j,row_index]] = A[[row_index,j]]
    b[[j,row_index]] = b[[row_index,j]]
    temp = A[:,j]
    b[j:] = b[j:]/temp[j:]
    for i in range(j,n):
        A[i] /= temp[i]
    for i in range(j+1,n):
        A[i] -= A[j]
        b[i] -= b[j]
    #print(A,b)
b[-1] /= A[-1,-1]
A[-1,-1] /= A[-1,-1]
#-----------------------------
x = np.zeros(n)
for i in range(n-1,-1,-1):
    temp = b[i]
    for j in range(n-1,i,-1):
        temp = temp - A[i,j]*x[j]
    x[i] = round(temp,3)
print(f'Результат для x: {x}')
#-----------------------------