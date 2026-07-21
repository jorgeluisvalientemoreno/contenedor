--Configuracion tipos de ofertados
select a.*, rowid
  from OPEN.LDC_TIPOS_OFERTADOS a
 where 1 = 1
      --and a.codigo_tipo = 2
   and 1 = 1;
--UNIDADES OPERATIVAS QUE APLICAN PARA NUEVO ESQUEMA DE LIQUIDACION
select *
  from OPEN.LDC_CONST_UNOPRL t
 where 1 = 1
      --and t.unidad_operativa = 5091
      --and t.contrato = 12121
   and 1 = 1;

--CONFIGURACION LIQUIDACION DE CONTRATISTAS POR TARIFAS POR RANGO
SELECT *
  FROM open.ldc_const_liqtarran lq
 WHERE 1 = 1
      --and lq.unidad_operativa = nucuunidadoper
      -- AND lq.actividad_orden = nucuactividad
      --AND lq.items = nucuitems
      -- AND lq.zona_ofertados = nuzonaofer
   AND trunc(sysdate /*fecha fin de acta*/) BETWEEN
       trunc(lq.fecha_ini_vigen) AND trunc(lq.fecha_fin_vige)
 ORDER BY cantidad_inicial;
