select g.* , a.name_
from ge_person g
inner join ge_organizat_area a on g.organizat_area_id= a.organizat_area_id
where person_id IN ( 48136 ,48066);

select * from ge_person  where name_ like '%VALENTINA%' and e_mail like '%gasguajira%'
