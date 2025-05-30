--CONFIGURACION LIQUIDACION DE CONTRATISTAS POR TARIFAS POR RANGO
SELECT lcl.*, rowid
  FROM open.ldc_const_liqtarran lcl
 WHERE lcl.unidad_operativa in
       (select oou.operating_unit_id
          from open.or_operating_unit oou
         where oou.contractor_id in
               (select gc.id_contratista
                  from open.ge_contrato gc
                 where gc.id_contrato in (10841, 10842)))
--and lcl.novedad_generar is not null
 and lcl.fecha_ini_vigen >= '01/06/2024'
   and lcl.fecha_fin_vige < '01/01/2025'
 order by lcl.iden_reg desc
