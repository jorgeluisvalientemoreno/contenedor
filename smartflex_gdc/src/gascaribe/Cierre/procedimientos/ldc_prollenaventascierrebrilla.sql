CREATE OR REPLACE PROCEDURE ldc_prollenaventascierrebrilla(nuano NUMBER,numes NUMBER,nerror OUT NUMBER,merror OUT VARCHAR2) IS
/**************************************************************
  Propiedad intelectual PETI.

  Trigger  :  ldc_prollenaventascierrebrilla

  Descripción  : ventas mensual brilla

  Autor  : John Jairo Jimenez Marimon
  Fecha  : 06-08-2013

  Historia de Modificaciones
  **************************************************************/
 CURSOR cuventasbrillames(nucano NUMBER,nucmes NUMBER) IS
   SELECT o.order_id orden
      ,t.order_activity_id actividad__id
      ,t.article_id codigo_articulo
      ,t.amount cantidad_comprada
      ,t.value valor
      ,t.iva iva
      ,(nvl(t.amount,0)*nvl(t.value,0))+nvl(t.iva,0) subtotal
      ,t.supplier_id proveedor
      ,o.operating_unit_id sucursal_proveedor
      ,(SELECT ve.id_contratista FROM or_operating_unit sv,ge_contratista ve WHERE sv.operating_unit_id = m.pos_oper_unit_id AND sv.contractor_id = ve.id_contratista) vendedor
      ,m.pos_oper_unit_id sucursal_vendedor
      ,a.package_id solicitud
      ,m.sale_channel_id canal_ventas
      ,a.subscriber_id cliente
      ,a.subscription_id contrato
      ,m.request_date
      ,t.difecodi diferido
  FROM ldc_ciercome ci
      ,mo_packages m
      ,or_order_activity a
      ,ld_item_work_order t
      ,or_order o
      ,open.ge_causal ca
 WHERE ci.cicoano = nucano
   AND ci.cicomes = nucmes
   AND o.task_type_id = dald_parameter.fnuGetNumeric_Value('CODI_TITR_EFNB')
   AND o.order_status_id = dald_parameter.fnuGetNumeric_Value('COD_ORDER_STATUS')
   AND t.state <> 'AN'
   AND ca.class_causal_id = 1
   AND nvl(o.legalization_date,to_date('01/01/1900 00:00:00','dd/mm/yyyy hh24:mi:ss')) BETWEEN ci.cicofein AND ci.cicofech
   AND m.package_id = a.package_id
   AND a.order_activity_id = t.order_activity_id
   AND t.order_id = o.order_id
   AND o.causal_id = ca.causal_id;
rgldc_ventas_brilla_mes pr_product%ROWTYPE;
nuloca     ge_geogra_location.geograp_location_id%TYPE;
nupadre    ge_geogra_location.geo_loca_father_id%TYPE;
nudepa     ge_geogra_location.geograp_location_id%TYPE;
nucontast  NUMBER(4);
nuflag     VARCHAR2(1);
nuconsta   ge_contratista.id_contratista%TYPE;
nusucsta   or_operating_unit.operating_unit_id%TYPE;
nucontareg NUMBER(15) DEFAULT 0;
nucantiregcom NUMBER(15) DEFAULT 0;
nucantiregtot NUMBER(15) DEFAULT 0;
BEGIN
nerror := 0;
merror := NULL;
nucantiregcom := 0;
nucantiregtot := 0;
nucontareg := dald_parameter.fnuGetNumeric_Value('COD_CANTIDAD_REG_GUARDAR');
 DELETE ldc_osf_ventas_brilla l WHERE l.ano = nuano AND l.mes = numes;
 FOR i IN cuventasbrillames(nuano,numes) LOOP
  BEGIN
   SELECT * INTO rgldc_ventas_brilla_mes
     FROM pr_product pr
    WHERE pr.product_type_id = dald_parameter.fnuGetNumeric_Value('COD_PRODUCT_TYPE_BRILLA')
      AND pr.subscription_id = i.contrato
      AND ROWNUM <= 1;
  EXCEPTION
   WHEN no_data_found THEN
    rgldc_ventas_brilla_mes.product_id := -1;
    rgldc_ventas_brilla_mes.category_id := -1;
    rgldc_ventas_brilla_mes.subcategory_id := -1;
  END;
  BEGIN
    SELECT lo.geograp_location_id,lo.geo_loca_father_id INTO nuloca,nupadre
      FROM ab_address di,ge_geogra_location lo
     WHERE di.address_id = rgldc_ventas_brilla_mes.address_id
       AND di.geograp_location_id = lo.geograp_location_id;
  EXCEPTION
   WHEN no_data_found THEN
     nuloca := NULL;
     nupadre := NULL;
     nudepa := NULL;
    END;
  IF nupadre IS NOT NULL THEN
   BEGIN
    SELECT de.geograp_location_id INTO nudepa
      FROM ge_geogra_location de
     WHERE de.geograp_location_id = nupadre;
   EXCEPTION
    WHEN no_data_found THEN
    nudepa := NULL;
   END;
  END IF;
   SELECT COUNT(1) INTO nucontast
     FROM ld_zon_assig_valid zv
    WHERE zv.subscription_id = i.contrato
      AND zv.operating_unit_id = i.sucursal_vendedor
      AND zv.date_of_visit =(SELECT lk.sale_date
                               FROM ld_non_ba_fi_requ lk
                              WHERE lk.non_ba_fi_requ_id = i.solicitud);
   IF nucontast = 0 THEN
    nuflag := 'N';
    nuconsta := NULL;
    nusucsta := NULL;
   ELSE
    nuflag := 'S';
    nuconsta := i.vendedor;
    nusucsta := i.sucursal_vendedor;
   END IF;
  INSERT INTO ldc_osf_ventas_brilla
    (
     ano
    ,mes
    ,cod_departamento
    ,cod_localidad
    ,proveedor
    ,sucursal_proveedor
    ,vendedor
    ,sucursal_vendedor
    ,solicitud
    ,orden
    ,article_id
    ,cliente
    ,contrato
    ,producto
    ,categoria
    ,subcategoria
    ,total_prov
    ,cantidad_comprada
    ,canal_ventas
    ,valor
    ,iva
    ,venta_stand
    ,order_activity
    ,codigo_diferido
  --  ,proveedor_stand
--    ,sucursal_stand
    )
  VALUES
    (
     nuano
    ,numes
    ,nudepa
    ,nuloca
    ,i.proveedor
    ,i.sucursal_proveedor
    ,i.vendedor
    ,i.sucursal_vendedor
    ,i.solicitud
    ,i.orden
    ,i.codigo_articulo
    ,i.cliente
    ,i.contrato
    ,rgldc_ventas_brilla_mes.product_id
    ,rgldc_ventas_brilla_mes.category_id
    ,rgldc_ventas_brilla_mes.subcategory_id
    ,i.subtotal
    ,i.cantidad_comprada
    ,i.canal_ventas
    ,i.valor
    ,i.iva
    ,nuflag
    ,i.actividad__id
    ,i.diferido
  --  ,nuconsta
--    ,nusucsta
    );
    IF nucantiregcom >= nucontareg THEN
        COMMIT;
        nucantiregtot := nucantiregtot + nucantiregcom;
        nucantiregcom := 0;
     ELSE
      nucantiregcom := nucantiregcom + 1;
     END IF;
 END LOOP;
 COMMIT;
 nucantiregtot := nucantiregtot + nucantiregcom;
 nerror := 0;
 merror := 'Proceso terminó Ok : se procesarón '||nucantiregtot||' registros.';
EXCEPTION
 WHEN OTHERS THEN
  ROLLBACK;
  nerror:=-1;
  merror:='Error en ldc_prollenaventascierrebrilla: '||sqlerrm;
END;
/
