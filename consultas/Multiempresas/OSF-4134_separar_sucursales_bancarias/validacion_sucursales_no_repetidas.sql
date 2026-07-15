select banco, sucursal, count(*) as cantidad
from sucursal_bancaria
group by banco, sucursal
having count(*) > 1;


select banco, sucursal, count(distinct empresa) as empresas_distintas
from sucursal_bancaria
group by banco, sucursal
having count(distinct empresa) > 1;