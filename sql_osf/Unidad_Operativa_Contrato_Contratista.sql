select distinct a.operating_unit_id || ' - ' || a.name Unidad_Operativa,
                c.id_contrato || ' - ' || c.descripcion Contrato,
                b.id_contratista || ' - ' || b.nombre_contratista Contratista
  from open.or_operating_unit a, ge_contratista b, ge_contrato c
 where a.contractor_id = b.id_contratista
   and b.id_contratista = c.id_contratista
   and c.fecha_inicial > '01/01/2022'
      --and a.operating_unit_id = 2218
   and c.status = 'AB'
