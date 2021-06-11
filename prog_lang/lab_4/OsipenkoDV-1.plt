set xlabel 'x'
set ylabel 'y'

#set ranges of OX and OY
set xrange [0:30]
set yrange [0:30]

f_1(x) = 5 + x 
f_2(x) = -0.5*x+10
f_3(x) = -2*x+20
y = 0

#у меня почему-то не работают границы для функции если эта функция стоит сразу
# после plot, например: plot [0:] f_1(x),[0:20] f_2(x) ,[0:10] f_3(x)
plot 0,[0:] f_1(x),[0:20] f_2(x) ,[0:10] f_3(x)
