SELECT *
FROM OPEN.TA_PERFUSUA 
INNER JOIN  OPEN.SA_USER ON  USER_ID = PEUSUSUA ;

insert into open.ta_perfusua
select sq_ta_perfusua_peuscons.nextval,
       21,
       (select s.user_id from open.sa_user s where mask='DIASAL')
from dual;

insert into open.ta_perfusua
select sq_ta_perfusua_peuscons.nextval,
       22,
       (select s.user_id from open.sa_user s where mask='DIASAL')
from dual;

--4626 es el rol para la pestaña de procesos de tgta 
--4631 para tgta parametrización 
