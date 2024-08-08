  select tof.codigo_tipo,
         tof.descripcion,
         u.operating_unit_id,
         u.name,
         u.contractor_id,
         open.dage_contratista.fsbgetdescripcion(u.contractor_id, null) contratista,
         u.oper_unit_status_id,
         open.daor_oper_unit_status.fsbgetdescription(u.oper_unit_status_id, null) estado
  from open.ldc_const_unoprl uo
  inner join open.or_operating_unit u on u.operating_unit_id=uo.unidad_operativa
  inner join open.ldc_tipos_ofertados tof on tof.codigo_tipo=uo.tipo_ofertado
  order by tof.codigo_tipo