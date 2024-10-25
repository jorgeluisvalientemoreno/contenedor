--cobro_medio_de_recepción_duplicado
select t.reception_type_id, 
       mr.description,
       t.value
from ldc_tipvaldup t
inner join ge_reception_type  mr  on  mr.reception_type_id = t.reception_type_id
