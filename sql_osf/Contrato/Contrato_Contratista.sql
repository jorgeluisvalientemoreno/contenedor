select a.*,
       --a.id_contrato || ' - ' || a.descripcion Contrato,
       --gc.id_contratista || ' - ' || gc.nombre_contratista Contratista,
       --oou.operating_unit_id || ' - ' || oou.name unidad_OPerativa,
       --a.id_tipo_contrato || ' - ' || gtc.descripcion Tipo_contrato,
       GC.*
--,oou.*
  from open.ge_contrato a
 inner join open.ge_contratista gc
    on gc.id_contratista = a.id_contratista
--inner join open.or_operating_unit oou on a.id_contratista = oou.contractor_id
--and oou.operating_unit_id = 4902
 inner join OPEN.GE_TIPO_CONTRATO gtc
    on gtc.id_tipo_contrato = a.id_tipo_contrato
 where 1 = 1
   and a.status = 'AB'
   AND A.FECHA_CIERRE IS NULL
   and a.id_contrato = 10842
--AND A.FECHA_FINAL > SYSDATE
;
