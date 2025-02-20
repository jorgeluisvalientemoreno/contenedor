--clientes_estacionales
select ce.contrato,
       ce.producto,
       ce.fecha_registro,
       ce.fecha_inicial_vigencia,
       ce.fecha_final_vigencia,
       sysdate,
       ce.activo,
       ce.fecha_inactivacion
from clientes_estacionales  ce
inner join servsusc  s  on s.sesunuse = ce.producto
where ce.producto = 14519327
