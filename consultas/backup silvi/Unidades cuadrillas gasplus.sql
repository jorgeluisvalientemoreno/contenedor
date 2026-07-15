
select *
from ge_contratista
where id_contratista in ( 6172,6173) ;

select *
from ge_contrato g
where  id_tipo_contrato=581
and id_contrato= 12862;

select operating_unit_id , contractor_id 
from or_operating_unit
where contractor_id in ( 6172,6173)  
;

select *
from homologacion.homouniop u
where u.uniophomo in (4937, 4977) ;

select *
from gasgg.cuadcont c
where c.cuadcodi  in (406,2704); 

select *
from ge_contrato g
where  id_contrato in (150223 ,  150221) ;


select *
from gasgg.cuadcont c
where c.cuadcodi  in (406,2704);

select *
 from gasgg.contrato  cc
  where cc.contcuad in (406,2704);
  
select *
 from gasgg.clascont  cc
  where cc.clcocodi in (19,18)
