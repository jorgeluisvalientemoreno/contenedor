select *
from ge_error_log g
where g.error_log_id in (511246154, 511246153, 511246152) ;

select p.* , name_
from puemusua p 
inner join SA_USER s on USER_ID = PUUSUSUA
inner join ge_person g on g.USER_ID = p.PUUSUSUA
where puususua= 2136 
 

select * from ge_person  where name_ like '%ANGELICA%' and e_mail like '%gasguajira%';

select *
from sa_user
where user_id = 6585     
