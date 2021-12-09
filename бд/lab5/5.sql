# 1
select concat(FName,MName,"_",BirthDay,"_",LName) from studdb.stud where BirthDay between '1983/01/01' and '1992/12/31';
# 2
select upper(LName), upper(monthname(BirthDay)) from studdb.stud where fk_Gruppa_ID in (302,375,386);
# 3
select Stud_ID, LName from studdb.stud order by LName; 
# 4
select * from studdb.prepod order by FName, LName, MName;
# 5
select count(*), min(BirthDay), max(BirthDay) from studdb.stud;
# 6
select fk_Gruppa_ID, count(fk_Gruppa_ID) from studdb.stud group by fk_Gruppa_ID;
# 7
select fk_Gruppa_ID, count(fk_Gruppa_ID) as count_of_stud  from studdb.stud group by fk_Gruppa_ID having count(fk_Gruppa_ID) < 20;