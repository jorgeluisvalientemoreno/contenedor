select * 
from LDC_PERIPROG  p
where peprcicl = 208
order by p.peprfefi desc;

select *
from procejec  pc
where pc.prejcope = 104772
order by pc.prejfech desc
;

select *
from estaprog  pr
where pr.esprpefa = 104772
order by pr.esprfein desc
;
