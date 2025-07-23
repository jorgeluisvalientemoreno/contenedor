select * 
from ciclo_facturacion 
where ciclo = 2401 ;

select * 
from contrato 
where contrato in (48172139);


update contrato 
set empresa ='GDCA'
where contrato in (48172139);
;

update ciclo_facturacion 
set empresa ='GDCA'
where ciclo = 2401 