SELECT ga.id_acta acta
      ,ga.nombre nombre_acta
      ,ga.fecha_creacion fecha_creacion_acta
      ,(SELECT pe.nombre FROM open.ge_periodo_cert pe WHERE pe.id_periodo = ga.id_periodo) periodo 
      ,ga.id_contrato contrato
      ,co.descripcion descripcion_contrato
      ,co.id_tipo_contrato tipo_contrato
      ,(SELECT tc.descripcion FROM open.ge_tipo_contrato tc WHERE tc.id_tipo_contrato = co.id_tipo_contrato) descripcion_tipo_contrato
      ,ga.estado estado_acta
      ,co.id_contratista contratista
      ,(SELECT gc.nombre_contratista FROM open.ge_contratista gc WHERE gc.id_contratista = co.id_contratista) nombre_contratista
      ,(SELECT ci.identification FROM open.ge_contratista gc,open.ge_subscriber ci WHERE gc.id_contratista = co.id_contratista AND gc.subscriber_id = ci.subscriber_id) nit
      ,ga.extern_invoice_num factura
,nvl(valor_aui_admin,0)+nvl(valor_aui_util,0)+nvl(valor_aui_imprev,0) aiu
,VALOR_TOTAL neto_pagar
  FROM open.ge_acta ga
      ,open.ge_contrato co
 WHERE ga.id_acta = {?nro_acta}
   AND ga.id_contrato = co.id_contrato