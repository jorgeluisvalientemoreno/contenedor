select *
  from OPEN.LDC_CANT_ASIG_OFER_CART t
 where t.unidad_operatva_cart = 3654
--and t.nuano = 2024
--and t.numes in ( /*1,2,3,4,5,6,7,8,*/ 9)
--   and t.nro_acta = -1
;
SELECT *
  FROM open.ldc_const_liqtarran bv
 WHERE bv.unidad_operativa = 3654
--AND bv.zona_ofertados = -1
--AND trunc(SYSDATE) BETWEEN trunc(bv.fecha_ini_vigen) AND trunc(bv.fecha_fin_vige);
;
