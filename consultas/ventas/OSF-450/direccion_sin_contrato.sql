--Identificar direccion que no est� asociado a ning�n contrato
select a.address_id, 
       a.address, 
       a.geograp_location_id,
       a.estate_number ,
       ab.premise_type_id,
       a.is_urban , 
       ab.category_ , 
       ab.subcategory_
from open.ab_address a
inner join open.ab_premise  ab on a.estate_number  = ab.premise_id 
where (select count(1) from suscripc b where b.susciddi = a.address_id) = 0
and a.address not in ('KR MTTO CL MTTO - 0', 'RECAUDO PAGO NACIONAL', 'KR GENERICA CL GENERICA - 0')
and ab.premise_type_id is not null 
and a.geograp_location_id = 55

