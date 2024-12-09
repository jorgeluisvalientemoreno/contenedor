--proyecto_castigo_por_producto
--validar_proyecto_castigo
Select p.prpcprca  proyecto,
       p.prpcserv  servicio,
       p.prpcnuse  producto,
       p.prpcesco  estado_corte,
       p.prpccate  categoria,
       p.prpcedde  edad_deuda,
       p.prpcfeex  fecha_exclusion,
       p.prpcfeca  fecha_castigo,
       p.prpcsaca  saldo_castigado,
       p.prpcsare  saldo_reactivado,
       p.prpcreca  resultado_castigo
from open.gc_prodprca  p
Where p.prpcnuse = 17145111
