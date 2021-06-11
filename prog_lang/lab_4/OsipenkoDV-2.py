import numpy as np
import matplotlib.pyplot as plt

def main():
    #x range
    x = [i/100 for i in range(-1000,1000)]
    
    #define functions 2.1-2.5
    f = [
        lambda x: 2*np.sin(x),
        lambda x: 7+np.sin(x),
        lambda x: 5+np.cos(x/5),
        lambda x: 5+np.cos(x),
        lambda x: np.tan(x),
    ]

    #calculeta y for every function and then draw them
    for f_i in f:
        y = []
        for x_i in x:
            temp = f_i(x_i)
            #y limits for tan
            if abs(temp) > 50.0:
                temp = 50.0
            y.append(temp)
        plt.plot(x,y)

    plt.show()




if __name__ == '__main__':
    main()