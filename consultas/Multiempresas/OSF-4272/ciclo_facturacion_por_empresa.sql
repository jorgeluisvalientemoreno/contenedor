--ciclo_facturacion_por_empresa 
select c.ciclo, c.empresa
from ciclo_facturacion c
where c.ciclo = 115;

/*UPDATE ciclo_facturacion
   SET empresa = 'GDGU'
 WHERE ciclo = 746;*/
