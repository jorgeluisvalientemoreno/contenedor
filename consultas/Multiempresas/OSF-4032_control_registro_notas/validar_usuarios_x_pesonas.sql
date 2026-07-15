--validar_usuarios_x_pesonas
select *
from ge_person  p
where 1=1
and   p.person_id in (38963,13519) 
--and   p.number_id = '72186077'
;

/*update ge_person  p2 set p2.organizat_area_id = 64 where p2.person_id = 38963*/

select *
from sa_user  u
where u.user_id in (1, 5607, 5423, 1893)
