# Данные
|   #   |  I,A  |  E,B  | r,Ohm | R,Ohm | R1,Ohm | R2,Ohm | R3,Ohm | R4,Ohm | R5,Ohm | R6,Ohm |
| :---: | :---: | :---: | :---: | :---: | :----: | :----: | :----: | :----: | :----: | :----: |
|   9   |  0.8  |  15   |   3   |   9   |   8    |   1    |   3    |   5    |   9    |   1    |

# Taks 1

$$ 
U_1 = 6.4\text{ V}, \quad U_2 = 800\text{ mV}\\
R_1 = 8 \text{ Ohm}, \quad R_2 = 1\text{Ohm}\\
J = \frac{U_i}{R_i}=\frac{6.4}{8}=\frac{0.8}{1} = 0.8\text{ A} \\
$$

# Task 2

$$
I = \frac{E}{R+r} = \frac{15}{9+3} = 1.25\\
r = 3\text{ Ohm}, \quad R = 9\text{ Ohm}\\
U_r = 3.75 \text{ V}, \quad U_R = 11.25 \text{ V}
$$

# Task 3

$$
 R_1=8, R_2=1, R_3=3, R_4=5, R_5=9, R_6=1\\
1:I = 1.692 \text{ A},\quad I_2 = 1.461 \text{ A},\quad I_3 = 230.9\text{ mA},\quad I_4=153.9\text{ mA},\quad I_5 = 76.96\text{ mA}\\
2: I=I_2+I_3; \quad I_3 = I_4+I_5\\
1.692 - (1.461 + 0.2309) = 0; \quad 0.2309 - (0.1539 + 0.0796) = 0\\
3\text{ (МЭП)}:\\
R_{56} = R_5 + R_6 = 10, \quad R_{456} = \frac{R_4 \cdot R_{56}}{R_4 + R_{56}} = \frac{50}{15} = 3.33, \quad R_{3456} = R_3 + R_{456} = 6.333, \quad R_{23456} = \frac{R_2  R_{3456}}{R_2 + R_{3456}} = 0.864, \\ R_{123456} = R_1 + R_{23456} = 8.864\\
I_1 = \frac{E}{R_{123456}} = 1.692A, \quad U_{ad} = R_{23456} I_1 = 1.462V, \quad I_2 = \frac{U_{ad}}{R_2}=1.462A, \quad I_3 = \frac{U_{ad}}{R_{3456}} = 0.2309A,\\
U_{bc} = R_{456}I_3 = 0.769V, \quad I_4 = \frac{U_{bc}}{R_4} = 0.1538A, \quad I_5=I_6=\frac{U_{bc}}{R_{56}} = 0.0769A\\
4: \sum U_{Ri} = E
$$
