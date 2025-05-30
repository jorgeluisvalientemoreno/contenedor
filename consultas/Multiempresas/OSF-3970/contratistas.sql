select c.id_contratista,
       c.nombre_contratista,
       c.descripcion,
       c.correo_electronico,
       c.telefono,
       c.nombre_contacto,
       c.id_empresa,
       c.id_suscriptor,
       c.id_tipoautorizacion,
       c.id_tipocontribuyente,
       c.status,
       c.common_reg,
       c.iva_tax,
       c.withholding_tax,
       c.position_type_id,
       c.subscriber_id,
       s.subscriber_type_id,
       s.identification
from ge_contratista  c
inner join ge_subscriber  s  on s.subscriber_id = c.subscriber_id
where c.id_contratista = 6092
