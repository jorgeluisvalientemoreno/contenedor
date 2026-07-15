--ciclo_facturacion_por_empresa_y_producto 
select s.sesunuse, s.sesucicl, mc.empresa
from servsusc s
 inner join ciclo_facturacion  mc  on mc.ciclo = s.sesucicl
where s.sesunuse = 1032229


/*UPDATE ciclo_facturacion
   SET empresa = 'GDGU'
 WHERE ciclo = 4102;*/
