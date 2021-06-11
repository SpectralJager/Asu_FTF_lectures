import matplotlib.pyplot as plt
import numpy as np

def main():
    X = [i for i in range(30)]#OX, x>= 0
    
    print()
    f_1 = lambda x: 5#f(x) = 5
    y_1 = [f_1(x) for x in X]#solutions for f(x) = 5



    
    plt.plot(X,y_1)#plot f(X)
    plt.plot([0,20],[10,0])#plot line (0,10),(20,0)
    plt.plot([0,10],[20,0])#plot line (0,20),(10,0)

    plt.show()

if __name__ == '__main__':
    main()