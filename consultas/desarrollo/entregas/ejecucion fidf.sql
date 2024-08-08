select *
from gv$session
where upper(PROGRAM) LIKE '%FIDF%';
;
select *
from gv$session
where username='JOHBAY';

select *
from open.estaprog
where esprfein>= trunc(sysdate)
 and esprprog like 'FIDF%'
 and esprfefi is null
;
