--CONFIGURACION LIQUIDACION DE CONTRATISTAS POR TARIFAS POR RANGO
SELECT lcl.iden_reg Secuencia,
       lcl.unidad_operativa,
       lcl.actividad_orden,
       lcl.cantidad_inicial,
       lcl.cantidad_final,
       lcl.valor_liquidar,
       lcl.novedad_generar,
       lcl.fecha_ini_vigen,
       lcl.fecha_fin_vige,
       lcl.items,
       lcl.zona_ofertados
  FROM open.ldc_const_liqtarran lcl
-- WHERE 
 --lcl.unidad_operativa = 3654
 --lcl.novedad_generar is not null
 
