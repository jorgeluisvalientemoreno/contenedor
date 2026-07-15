select *
from  personalizaciones.anexos_factura_spool
where periodo_facturacion= -1 and contrato =67689635--  for update 
;

insert into personalizaciones.anexos_factura_spool
select factsusc as contrato,
-1 as periodo_facturacion,
'CO' as tipo_anexo,
'PRUEBA DE ANEXOS'||' '|| factcodi as anexo,
sysdate as fecha_registro
from factura
where factcodi in (2147620704,2147620706)



select * from factura
where factcodi in (2147620704,2147620706) 
