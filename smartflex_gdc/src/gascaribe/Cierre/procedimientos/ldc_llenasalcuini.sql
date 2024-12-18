CREATE OR REPLACE PROCEDURE ldc_llenasalcuini(
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2014-01-08
  Descripcion : Llena saldos cuotas iniciales

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
CURSOR cucuotasini(fein DATE,fefi DATE) is
SELECT so.package_id solicitud
      ,so.motive_status_id estado_solicitud
      ,'CUOTA INICIAL SOLICITUD' cuota_inicial_PROVIENE
      ,ci.initial_payment cuota_inicial
      ,di.geograp_location_id localidad
  FROM mo_gas_sale_data ci
      ,mo_packages so
      ,mo_motive mo
      ,pr_product po
      ,ab_address di
 WHERE initial_payment > 0
   AND ci.init_pay_received = 'Y'
   AND so.request_date BETWEEN fein AND fefi
   AND ci.package_id = so.package_id
   AND so.package_id = mo.package_id
   AND mo.product_id = po.product_id
   AND po.address_id = di.address_id
UNION
SELECT c.package_id
      ,so.motive_status_id
      ,'COTIZADA'
      ,c.initial_payment
      ,di.geograp_location_id localidad
  FROM cc_quotation c
      ,mo_packages so
      ,mo_motive mo
      ,pr_product po
      ,ab_address di
 WHERE c.initial_payment > 0
   AND c.status <> 'N'
   AND so.request_date BETWEEN fein AND fefi
   AND c.package_id = so.package_id
   AND so.package_id = mo.package_id
   AND mo.product_id = po.product_id
   AND po.address_id = di.address_id;
dtfein DATE;
dtfefi DATE;
nucontareg NUMBER(15) DEFAULT 0;
nucantiregcom NUMBER(15) DEFAULT 0;
nucantiregtot NUMBER(15) DEFAULT 0;
BEGIN
sbmensa := NULL;
error := 0;
nucantiregcom := 0;
nucantiregtot := 0;
nucontareg := dald_parameter.fnuGetNumeric_Value('COD_CANTIDAD_REG_GUARDAR');
 ldc_cier_prorecupaperiodocont(nupano,nupmes,dtfein,dtfefi,sbmensa,error);
 DELETE ldc_osf_salcuini s WHERE s.ano = nupano AND s.mes = nupmes;
 FOR i IN cucuotasini(dtfein,dtfefi) LOOP
  INSERT INTO ldc_osf_salcuini
                             (
                              ano
                             ,mes
                             ,solicitud
                             ,estado_solicitud
                             ,cuota_inicial_proviene
                             ,cuota_inicial
                             ,localidad
                             )
                       VALUES
                            (
                             nupano
                             ,nupmes
                             ,i.solicitud
                             ,i.estado_solicitud
                             ,i.cuota_inicial_proviene
                             ,i.cuota_inicial
                             ,i.localidad
                             );
     nucantiregcom := nucantiregcom + 1;
     IF nucantiregcom >= nucontareg THEN
        COMMIT;
        nucantiregtot := nucantiregtot + nucantiregcom;
        nucantiregcom := 0;
     END IF;
  END LOOP;
  nucantiregtot := nucantiregtot + nucantiregcom;
  COMMIT;
  sbmensa := 'Proceso terminó Ok : se procesarón '||nucantiregtot||' registros.';
  error := 0;
END;
/
