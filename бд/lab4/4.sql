# 1
select LName, FName, BirthDay from studdb.stud where dayofweek(BirthDay) = 2 and dayofmonth(BirthDay) = 1 and fk_pol_id = 0;
# 2
select LName, BirthDay from studdb.stud 
where 
	(MName like "А%" or MName like "ж")
    and dayofmonth(BirthDay) in (5,8,9) 
    and fk_pol_id = 1;
# 3
select concat(LName," ", FName," ", MName) as "ФИО", Stud_ID as "№ зачетки", BirthDay as "Дата рождения" from studdb.stud
where 
	timestampdiff(year,curdate(), BirthDay) < 34
    and dayofmonth(BirthDay) in (9,10,11) ;
# 4
select * from studdb.stud
where
	BirthDay between '1989/07/10' and '1989/07/31';