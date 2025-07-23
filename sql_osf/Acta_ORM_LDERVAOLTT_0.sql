/*
Orden de parametros del reprote ORM
4272
'A'
'01/01/2023'
'31/01/2023'
10450
'A'
100006929
1
*/
WITH UNIDADES AS
 (SELECT U.OPERATING_UNIT_ID
    FROM OPEN.OR_OPERATING_UNIT U
   WHERE ((U.OPERATING_UNIT_ID IN (&Unidad_Operativa) AND
         &CantUnidOper = 'A') OR (&CantUnidOper = 'T'))
     AND orm.ldc_fncbuscacontrorm(U.OPERATING_UNIT_ID) = 1),
TABLA AS
 (SELECT o.ORDER_ID,
         a.ADDRESS_ID,
         a.PRODUCT_ID,
         a.subscription_id,
         a.PACKAGE_ID,
         a.ACTIVITY_ID,
         a.TASK_TYPE_ID,
         o.OPERATING_UNIT_ID,
         o.REAL_TASK_TYPE_ID,
         o.created_Date,
         o.ASSIGNED_DATE,
         o.LEGALIZATION_DATE,
         o.execution_final_date,
         o.CAUSAL_ID,
         a.ORDER_ITEM_ID,
         a.ORDER_ACTIVITY_ID,
         (select x.difevatd
            from open.or_order z, open.or_order_activity k, open.diferido x
           where z.order_id = k.order_id
             and k.product_id = x.difenuse
             and x.difenudo = 'OR-' || z.order_id
             and z.order_id = o.ORDER_ID
             and rownum = 1) Cargo,
         ca.DESCRIPTION causal_description,
         gi.ITEMS_ID,
         gi.DESCRIPTION items_desc,
         gi.ITEM_CLASSIF_ID,
         oi.LEGAL_ITEM_AMOUNT,
         oi.VALUE,
         a.SUBSCRIBER_ID,
         CASE
           WHEN oi.OUT_ = 'N' AND o.TASK_TYPE_ID = 10336 THEN
            -1
           ELSE
            1
         END signo,
         O.DEFINED_CONTRACT_ID CONTRATO,
         NVL((SELECT N.LIQUIDATION_SIGN
               FROM OPEN.CT_ITEM_NOVELTY N
              WHERE N.ITEMS_ID = A.ACTIVITY_ID
                AND ROWNUM = 1),
             1) SIGNO_NOVEDAD,
         NVL((SELECT -1
               FROM OPEN.OR_RELATED_ORDER R
              WHERE R.RELA_ORDER_TYPE_ID = 15
                AND R.RELATED_ORDER_ID = O.ORDER_ID
                AND ROWNUM = 1),
             1) SIGNO_REVERSION,
         NVL((SELECT 'S'
               FROM OPEN.CT_ITEM_NOVELTY N
              WHERE N.ITEMS_ID = A.ACTIVITY_ID
                AND ROWNUM = 1),
             'N') ES_NOVEDAD,
         A.VALUE_REFERENCE
    FROM OPEN.OR_ORDER          o,
         OPEN.OR_ORDER_ACTIVITY a,
         OPEN.GE_CAUSAL         ca,
         OPEN.OR_ORDER_ITEMS    oi,
         OPEN.GE_ITEMS          gi
   WHERE a.ORDER_ID = o.ORDER_ID
     AND ca.CAUSAL_ID = o.CAUSAL_ID
     AND o.ORDER_ID = oi.ORDER_ID
     AND oi.ITEMS_ID = gi.ITEMS_ID
     AND O.OPERATING_UNIT_ID IN
         (SELECT UT.OPERATING_UNIT_ID FROM UNIDADES UT)
     AND o.LEGALIZATION_DATE >=
         To_Date(&Fecha_Inicial_Legalizacion, 'dd/mm/yyyy')
     AND o.LEGALIZATION_DATE <
         To_Date(&Fecha_Final_Legalizacion, 'dd/mm/yyyy') + 1
     AND o.ORDER_STATUS_ID = 8
     AND ((o.TASK_TYPE_ID IN (&Tipo_Trabajo) AND &CantTipoTrab = 'A') OR
         (&CantTipoTrab = 'T'))
     AND ca.CLASS_CAUSAL_ID = 1
        /*AND ((gi.ITEM_CLASSIF_ID = 2 AND a.ORDER_ITEM_ID = oi.ORDER_ITEMS_ID) OR (gi.ITEM_CLASSIF_ID != 2 AND
        (a.ORDER_ACTIVITY_ID = oi.ORDER_ACTIVITY_ID OR
          oi.ORDER_ACTIVITY_ID IS NULL))) */
     and a.order_activity_id =
         open.ldc_bcfinanceot.fnugetactivityid(o.order_id))
SELECT tabla.ORDER_ID,
       gl.GEO_LOCA_FATHER_ID codigo_departamento,
       (SELECT gl2.DESCRIPTION
          FROM OPEN.GE_GEOGRA_LOCATION gl2
         WHERE gl2.GEOGRAP_LOCATION_ID = gl.GEO_LOCA_FATHER_ID
           AND ROWNUM = 1) descripcion_departamento,
       gl.GEOGRAP_LOCATION_ID codigo_localidad,
       gl.DESCRIPTION descripcion_localidad,
       tabla.OPERATING_UNIT_ID codigo_unid_op,
       ou.NAME desripcion_unidad_operativa,
       CASE
         WHEN tabla.SUBSCRIBER_ID IS NOT NULL AND
              open.dapr_product.fnugetsubscription_id(NVL(pr.PRODUCT_ID, -1),
                                                      NULL) IS NOT NULL THEN
          (SELECT DISTINCT S.SUBSCRIBER_NAME || ' ' || S.SUBS_LAST_NAME
             FROM OPEN.GE_SUBSCRIBER S
            WHERE S.SUBSCRIBER_ID =
                  Decode(tabla.SUBSCRIBER_ID,
                         NULL,
                         open.pktblsuscripc.fnugetsuscclie(NVL(open.dapr_product.fnugetsubscription_id(NVL(pr.PRODUCT_ID,
                                                                                                           -1),
                                                                                                       NULL),
                                                               0),
                                                           NULL),
                         tabla.SUBSCRIBER_ID))
         ELSE
          NULL
       END nombre_cliente,
       tabla.TASK_TYPE_ID codigo_tipo_trabajo,
       (SELECT t.DESCRIPTION
          FROM OPEN.OR_TASK_TYPE t
         WHERE t.TASK_TYPE_ID = tabla.TASK_TYPE_ID
           AND ROWNUM = 1) task_type_desc,
       tabla.REAL_TASK_TYPE_ID codigo_tipo_trabajo,
       (SELECT t.DESCRIPTION
          FROM OPEN.OR_TASK_TYPE t
         WHERE t.TASK_TYPE_ID = tabla.REAL_TASK_TYPE_ID
           AND ROWNUM = 1) real_task_type_desc,
       tabla.ACTIVITY_ID codigo_actividad,
       (SELECT act.DESCRIPTION
          FROM OPEN.GE_ITEMS act
         WHERE act.ITEMS_ID = tabla.ACTIVITY_ID
           AND ROWNUM = 1) descripcion_actividad,
       tabla.created_date fecha_creacion,
       tabla.execution_final_date Fecha_Ejecucion_final,
       tabla.ASSIGNED_DATE fecha_asignacion,
       tabla.LEGALIZATION_DATE,
       (SELECT oc.USER_ID
          FROM OPEN.OR_ORDER_STAT_CHANGE oc
         WHERE oc.ORDER_ID = tabla.ORDER_ID
           AND oc.FINAL_STATUS_ID = 8
           AND ROWNUM = 1) usuario_legalizo,
       tabla.CAUSAL_ID codigo_causal,
       tabla.causal_description,
       tabla.Cargo Cargo,
       tabla.ITEMS_ID codigo_item,
       tabla.items_desc descripcion_item,
       tabla.ITEM_CLASSIF_ID Clasificacion_item,
       tabla.LEGAL_ITEM_AMOUNT * tabla.signo cantidad,
       case
         when tabla.es_novedad = 'N' THEN
          tabla.VALUE * tabla.signo
         ELSE
          TABLA.VALUE_REFERENCE * SIGNO_NOVEDAD * TABLA.SIGNO_REVERSION
       END valor,
       (SELECT oc.CERTIFICATE_ID
          FROM OPEN.CT_ORDER_CERTIFICA oc
         WHERE oc.ORDER_ID = tabla.ORDER_ID
           AND ROWNUM = 1) nro_acta,
       (SELECT A.ID_CONTRATO
          FROM OPEN.GE_ACTA A
         WHERE A.ID_ACTA IN
               (SELECT oc.CERTIFICATE_ID
                  FROM OPEN.CT_ORDER_CERTIFICA oc
                 WHERE oc.ORDER_ID = tabla.ORDER_ID)
           AND ROWNUM = 1) CONTRATO,
       ou.CONTRACTOR_ID codigo_contratista,
       (SELECT gc.NOMBRE_CONTRATISTA
          FROM OPEN.GE_CONTRATISTA gc
         WHERE gc.ID_CONTRATISTA = ou.CONTRACTOR_ID
           AND ROWNUM = 1) descripcion_contratista,
       tabla.subscription_id contrato_cliente,
       pr.PRODUCT_ID,
       pr.product_status_id || ' - ' ||
       open.daps_product_status.fsbgetdescription(pr.product_status_id,
                                                  null) ESTADO_PRODUCTO,
       pr.CATEGORY_ID,
       (SELECT cate.CATEDESC
          FROM OPEN.CATEGORI cate
         WHERE cate.CATECODI = pr.CATEGORY_ID
           AND ROWNUM = 1) category_desc,
       pr.SUBCATEGORY_ID,
       (SELECT suca.SUCADESC
          FROM OPEN.SUBCATEG suca
         WHERE suca.SUCACATE = pr.CATEGORY_ID
           AND suca.SUCACODI = pr.SUBCATEGORY_ID
           AND ROWNUM = 1) subcategory_desc,
       tabla.package_id solicitud,
       (SELECT DISTINCT ts.PACKAGE_TYPE_ID || '-' || ts.DESCRIPTION
          FROM OPEN.MO_PACKAGES sol, OPEN.PS_PACKAGE_TYPE ts
         WHERE sol.PACKAGE_ID = tabla.PACKAGE_ID
           AND ROWNUM = 1
           and ts.package_type_id = sol.package_type_id) tipo_solicitud,
       (SELECT r.ORDER_ID
          FROM OPEN.OR_RELATED_ORDER r
         WHERE r.RELATED_ORDER_ID = tabla.ORDER_ID
           AND r.RELA_ORDER_TYPE_ID = 9) "orden genero ajuste",
       open.ldc_retornacomentotlega(tabla.ORDER_ID) comentario_orden,
       tabla.SUBSCRIBER_ID,
       pr.SUBSCRIPTION_ID,
       ad.address_parsed direccion,
       (select se.geograp_location_id || '-' || se.description
          from open.ge_geogra_location se, open.ab_segments seg
         where seg.segments_id = ad.segment_id
           and se.geograp_location_id = seg.operating_sector_id
           and rownum = 1) sector_operativo,
       case
         when tabla.task_type_id in (10834, 10835, 10836, 12460) then
          (select sum(difevatd)
             from open.diferido
            where difenuse = tabla.product_id
              and difenudo = 'OR-' || tabla.order_id
              and rownum = 1)
         else
          0
       end valor_reconexion,
       CONTRATO,
       ROUND(TABLA.LEGALIZATION_dATE - TABLA.ASSIGNED_DATE, 4) TIEMPO_LEGALIZACION
  FROM tabla
  LEFT JOIN OPEN.PR_PRODUCT pr
    ON tabla.PRODUCT_ID = pr.PRODUCT_ID
  LEFT OUTER JOIN OPEN.AB_ADDRESS ad
    ON (ad.ADDRESS_ID = tabla.ADDRESS_ID)
 INNER JOIN OPEN.GE_GEOGRA_LOCATION gl
    ON (ad.GEOGRAP_LOCATION_ID = gl.GEOGRAP_LOCATION_ID),
 OPEN.OR_OPERATING_UNIT ou
 WHERE ou.OPERATING_UNIT_ID = tabla.OPERATING_UNIT_ID
   AND ((tabla.ITEMS_ID IN (&ITEMS) AND &CantidadItem = 1) OR
       (&CantidadItem = 2))
