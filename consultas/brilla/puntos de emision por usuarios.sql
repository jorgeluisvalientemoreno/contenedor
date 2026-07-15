select p.* , name_
from puemusua p 
inner join SA_USER s on USER_ID = PUUSUSUA
inner join ge_person g on g.USER_ID = p.PUUSUSUA
where puususua= 2136 ;
 
insert into puemusua
select (select g.USER_ID from ge_person g  where name_ like '%LIYIS%' and e_mail like '%gasguajira%') as puususua,
puuspuem,
puusterm,
SQ_PUEMUSUA_146313.NEXTVAL
from puemusua p
where puususua= 6585