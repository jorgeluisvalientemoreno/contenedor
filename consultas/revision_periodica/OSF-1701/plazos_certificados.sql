--plazos_certificados
select c.plazos_cert_id,
       c.id_contrato,
       c.id_producto,
       c.plazo_min_revision,
       c.plazo_min_suspension,
       c.plazo_maximo,
       open.ldc_getedadrp(c.id_producto)  edad_rp,
       m.merptino  tipo_not,
       c.is_notif,
       c.vaciointerno
from ldc_plazos_cert  c
left join open.ldc_confimensrp m  on m.merpedin = open.ldc_getedadrp(c.id_producto)
where c.id_producto in (51877218)


/*select *
from ldc_plazos_cert  c
where c.id_producto = 1002398
for update*/
