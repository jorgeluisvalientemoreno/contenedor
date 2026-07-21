--Configuracion tipos de ofertados
select a.*, rowid from OPEN.LDC_TIPOS_OFERTADOS a order by a.codigo_tipo;

--UNIDADES OPERATIVAS QUE APLICAN PARA NUEVO ESQUEMA DE LIQUIDACION
select a.*, rowid from OPEN.LDC_CONST_UNOPRL a;

select gc.id_contrato CONTRATO,
       gc.ID_CONTRATISTA || ' - ' || gcc.descripcion CONTRATISTA,
       lcu.UNIDAD_OPERATIVA || ' - ' || oou.NAME UNIDAD_OPERATIVA,
       lto.procedimiento_ejecutar Proceso_Ofertado,
       gc.fecha_inicial,
       gc.fecha_final,
       DECODE(gc.status,
              'AB',
              gc.status || ' - Abierto',
              'CE',
              gc.status || ' - Cerrado',
              'AN',
              gc.status || ' - Anulado',
              'SU',
              gc.status || ' - Suspendido',
              'RG',
              gc.status || ' - Registrado',
              gc.status || ' - No Aplica') Estado
  from OPEN.LDC_CONST_UNOPRL lcu
 inner join open.LDC_TIPOS_OFERTADOS lto
    on lto.codigo_tipo = lcu.tipo_ofertado
 inner join open.or_operating_unit oou
    on oou.operating_unit_id = lcu.unidad_operativa
 inner join open.ge_contratista gcc
    on gcc.id_contratista = oou.CONTRACTOR_ID
 inner join open.ge_contrato gc
    on gc.ID_CONTRATISTA = oou.CONTRACTOR_ID
   and sysdate between gc.fecha_inicial and gc.fecha_final
--and gc.status = 'AB'
 where 1 = 1
--and lcu.unidad_operativa = 1888
--and lcu.contrato = 8721
 order by gc.id_contratista, gc.id_contrato, gc.fecha_inicial desc;
