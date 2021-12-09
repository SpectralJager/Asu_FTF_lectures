# 1
select * from studdb.stud;
# 2
select LName, Rost from studdb.stud;
# 3
select LName, Rost from studdb.stud where Ves > 50 and Rost < 75;
# 4
select * from studdb.stud where fk_Gruppa_ID = 384;
# 5
select * from studdb.stud where fk_pol_id = 1;
# 6
select * from studdb.stud where fk_pol_id = 0 and fk_Gruppa_ID != 384;
# 7
select * from studdb.stud where FName like "А%" or LName like "%ов";
# 8
select lower(FName), lower(LName) from studdb.stud where MName like "Ал%";
# 9
select upper(substring(LName,1,5)), lower(substring(FName,1,2)), 
(case
	when fk_Gruppa_ID = 384 then length(FName)/2
	else null
end) as gruppa from studdb.stud;