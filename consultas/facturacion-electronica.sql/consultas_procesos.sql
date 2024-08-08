--principal
select *
from OPEN.estaproc
where proceso like '%MASIVO%';

--hijos
select *
from OPEN.estaproc
where proceso like '%JOBFAEL%';


---JOBFAELNT - Notas
---JOBFAEL - Facturacion recurrente
---JOBFAELVE - ventas

--PRCREARPROCMASIVONOTA  - Principal Notas
--PRCREARPROCMASIVOVENTA  - Principal ventas
--PRCREARPROCMASIVO -  Principal Factura recurrente (editado) 

--hijo - padre
--las notas generan dos hijos por proceso
--las ventas igual
--la recurrente 4 hijos
--igual eso es parametrizable





