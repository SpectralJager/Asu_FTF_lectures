#include <iostream>
#include <cmath>
#define f(x) (5*x+8*log(x)-1)
#define f2(x) (x-0.1*(5*x+8*log(x)-1))
using namespace std;
int main() {
    double x, a = 0.5, b = 1.0, eps = 0.0015;
    int count;
    for (count = 1; abs(b - a) > 2 * eps; count++) {
        x = (a + b) / 2;
        if (f(a) * f(x) < 0)
            b = x;
        else if (f(x) * f(b) < 0)
            a = x;
    }
    cout << "The method of dividing a segment in half: x = " << (a + b) / 2 << " counts = " << count << endl;
    a = 0.5; b = 1.0; eps = 0.0015; 
    double x0 = (a + b) / 2;
    for (count = 1;; count++) {
        x = f2(x0);
        if (abs(x - x0) < eps and count < 10000) break;
        x0 = x;
    }
    cout << "The method of simple iterations: x = " << x << " counts = " << count << endl;
    return 0;
}
