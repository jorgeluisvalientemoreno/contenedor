select c.nuano,
       c.numes,
       c.unidad_operatva_cart,
       u.name,
       c.actividad,
       open.dage_items.fsbgetdescription(c.actividad, null) actividad,
       c.tipo_trabajo,
       open.daor_task_type.fsbgetdescription(c.tipo_trabajo) desc_titr,
       c.zona_ofertados,
       (select zo.descripcion from open.ldc_zona_ofer_cart zo where zo.id_zona_oper=c.zona_ofertados) desc_zona,
       c.cantidad_asignada,
       c.fecha_creacion_reg,       
       c.usuario,
       c.reg_activo,
       c.nro_acta
from open.ldc_cant_asig_ofer_cart C
inner join open.or_operating_unit u on u.operating_unit_id=c.unidad_operatva_cart
left join open.ldc_const_unoprl uo on uo.unidad_operativa=c.unidad_operatva_cart
