--validar_contratistas_duplicados
select mc.contratista, count (*)
from multiempresa.contratista  mc
group by mc.contratista 
having count (*) > 1;
