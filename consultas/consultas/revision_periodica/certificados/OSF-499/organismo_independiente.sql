select * 
from open.ldc_organismos  o
where o.operating_unit_id is not null
and o.contratista_id is null;