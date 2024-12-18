CREATE OR REPLACE PROCEDURE ldc_llenacontrato(
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2013-08-22
  Descripcion : Generamos información de los contratos a cierre

  Parametros Entrada
    nuano Año
    numes Mes

  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION

***************************************************************************/
                                              nupano IN NUMBER,
                                              nupmes IN NUMBER,
                                              sbmensa OUT VARCHAR2,
                                              error  OUT NUMBER
                                             ) IS
CURSOR cu_ge_contrato IS
 SELECT id_contrato, descripcion, fecha_inicial, fecha_final, valor_aui_admin, valor_aui_util, valor_aui_imprev, tipo_moneda_liquidar, valor_total_contrato, valor_total_pagado, id_tipo_contrato, id_contratista, dias_facturar, alerta_porcen_valor, valor_anticipo, anticipo_amortizado, porcen_fondo_garant, acumul_fondo_garant, fecha_cierre, status, percent_nation_stamp, account_classif_id
   FROM ge_contrato;
nuvalor_ejecutado ldc_osf_contrato.valor_ejecutado_contrato%TYPE;
dtfein ldc_ciercome.cicofein%TYPE;
dtfefi ldc_ciercome.cicofein%TYPE;
pmen   VARCHAR2(1000);
nuok   NUMBER(6);
valor_en_acta_contrato ldc_osf_contrato.valor_en_acta%TYPE;
nucontareg NUMBER(15) DEFAULT 0;
nucantiregcom NUMBER(15) DEFAULT 0;
nucantiregtot NUMBER(15) DEFAULT 0;
BEGIN
sbmensa := NULL;
error := 0;
nucantiregcom := 0;
nucantiregtot := 0;
nucontareg := dald_parameter.fnuGetNumeric_Value('COD_CANTIDAD_REG_GUARDAR');
ldc_cier_prorecupaperiodocont(nupano,nupmes,dtfein,dtfefi,pmen,nuok);
 DELETE ldc_osf_contrato l WHERE l.nuano = nupano AND l.numes = nupmes;
  FOR i IN cu_ge_contrato LOOP
   -- Obtenemos valor en acta del contrato
   valor_en_acta_contrato := 0;
   SELECT NVL(SUM(i.value),0) INTO valor_en_acta_contrato
     FROM open.or_order o,open.or_order_items i,open.ge_acta a
    WHERE o.order_status_id = dald_parameter.fnuGetNumeric_Value('COD_ORDER_STATUS')
      AND a.estado <> 'C'
      AND o.legalization_date BETWEEN dtfein AND dtfefi
      AND o.defined_contract_id = i.id_contrato
      AND o.order_id = i.order_id
      AND o.defined_contract_id = a.id_contrato;
   -- Obtenemos el valor ejecutado del contrato
   nuvalor_ejecutado := 0;
   SELECT ROUND(NVL(SUM(oi.value),0),0) INTO nuvalor_ejecutado
     FROM or_order ot,or_order_items oi
    WHERE ot.order_status_id = dald_parameter.fnuGetNumeric_Value('COD_ORDER_STATUS')
      AND ot.legalization_date BETWEEN dtfein AND dtfefi
      AND ot.defined_contract_id = i.id_contrato
      AND ot.order_id = oi.order_id
      AND 0 = (SELECT COUNT(*)
                 FROM open.ge_detalle_acta d
                WHERE d.id_orden = ot.order_id);
   -- Insertamos registro
   INSERT INTO ldc_osf_contrato(
                                 nuano
                                ,numes
                                ,id_contrato
                                ,descripcion
                                ,fecha_inicial
                                ,fecha_final
                                ,valor_aui_admin
                                ,valor_aui_util
                                ,valor_aui_imprev
                                ,tipo_moneda_liquidar
                                ,valor_total_contrato
                                ,valor_total_pagado
                                ,id_tipo_contrato
                                ,id_contratista
                                ,dias_facturar
                                ,alerta_porcen_valor
                                ,valor_anticipo
                                ,anticipo_amortizado
                                ,porcen_fondo_garant
                                ,acumul_fondo_garant
                                ,fecha_cierre
                                ,status
                                ,percent_nation_stamp
                                ,account_classif_id
                                ,valor_ejecutado_contrato
                                ,valor_en_acta
                                )
                          VALUES(
                                  nupano
                                 ,nupmes
                                 ,i.id_contrato
                                 ,i.descripcion
                                 ,i.fecha_inicial
                                 ,i.fecha_final
                                 ,i.valor_aui_admin
                                 ,i.valor_aui_util
                                 ,i.valor_aui_imprev
                                 ,i.tipo_moneda_liquidar
                                 ,i.valor_total_contrato
                                 ,i.valor_total_pagado
                                 ,i.id_tipo_contrato
                                 ,i.id_contratista
                                 ,i.dias_facturar
                                 ,i.alerta_porcen_valor
                                 ,i.valor_anticipo
                                 ,i.anticipo_amortizado
                                 ,i.porcen_fondo_garant
                                 ,i.acumul_fondo_garant
                                 ,i.fecha_cierre
                                 ,i.status
                                 ,i.percent_nation_stamp
                                 ,i.account_classif_id
                                 ,nuvalor_ejecutado
                                 ,valor_en_acta_contrato
                                 );
    nucantiregcom := nucantiregcom + 1;
     IF nucantiregcom >= nucontareg THEN
        COMMIT;
        nucantiregtot := nucantiregtot + nucantiregcom;
        nucantiregcom := 0;
     END IF;
  END LOOP;
  COMMIT;
  nucantiregtot := nucantiregtot + nucantiregcom;
  sbmensa := 'Proceso terminó Ok : se procesarón '||nucantiregtot||' registros.';
  error := 0;
EXCEPTION
 WHEN OTHERS THEN
  ROLLBACK;
  sbmensa := 'Error en ldc_llenacontrato error code : '||TO_CHAR(SQLCODE)||' MENSAJE '||SQLERRM;
  error := -1;
END;
/
