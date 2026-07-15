--validar_contratos_duplicados
select ce.contrato, count (*)
from multiempresa.contrato  ce
group by ce.contrato 
having count (*) > 1;
