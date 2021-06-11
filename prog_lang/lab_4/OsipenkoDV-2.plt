set xlabel 'x'
set ylabel 'y'

#set ranges of OX and OY
set xrange [0:30]
set yrange [0:30]

f_1(x) = 2*sin(x)
f_2(x) = 7+sin(x)
f_3(x) = 5+cos(x/5)
f_4(x) = 5+cos(x)
f_5(x) = tan(x)

#у меня почему-то не работают границы для функции если эта функция стоит сразу
# после plot, например: plot [0:] f_1(x),[0:20] f_2(x) ,[0:10] f_3(x)
plot f_1(x),f_2(x),f_3(x),f_4(x), f_5(x)