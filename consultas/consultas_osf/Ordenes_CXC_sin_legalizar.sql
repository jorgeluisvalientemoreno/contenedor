SELECT rownum,
       to_char(a.order_id) ORDEN,
       to_char(oa.subscription_id) CONTRATO,
       to_char(oa.product_id) PRODUCTO,
       a.order_status_id || ' - ' || OOS.DESCRIPTION ESTADO_ORDEN,
       to_char(OL.EXEC_FINAL_DATE) AS FECHA_EJECUCION_FINAL,
       to_char(trunc(sysdate - OL.EXEC_FINAL_DATE)) AS DIAS_SIN_LEGALIZAR,
       dp.category_id || ' - ' || C.CATEDESC AS CATEGORIA,
       dp.subcategory_id || ' - ' || SC.SUCADESC As SUBCATEGORIA,
       a.operating_unit_id || ' - ' || DUO.Name as UNIDAD_OPERATIVA,
       DUO.Contractor_Id || ' - ' || GCON.NOMBRE_CONTRATISTA CONTRATISTA
  FROM open.or_order A
 INNER JOIN open.or_order_activity oa
    ON oa.order_id = a.order_id
 INNER JOIN open.pr_product DP
    ON DP.PRODUCT_ID = oa.product_id
 INNER JOIN open.or_operating_unit DUO
    ON DUO.OPERATING_UNIT_ID = A.Operating_Unit_Id
 INNER JOIN open.OR_ORDER_STATUS OOS
    ON OOS.ORDER_STATUS_ID = A.ORDER_STATUS_ID
------------------------------------------------------------------------------   
 INNER JOIN open.ldc_otlegalizar ol
    ON ol.order_id = a.order_id
 INNER JOIN OPEN.CATEGORI C
    ON C.CATECODI = dp.category_id
 INNER JOIN OPEN.subcateg SC
    ON SC.SUCACATE = dp.category_id
   AND SC.SUCACODI = dp.subcategory_id
 INNER JOIN OPEN.GE_CAUSAL GC
    ON GC.CAUSAL_ID = OL.CAUSAL_ID
   AND GC.class_causal_id = 1
 INNER JOIN OPEN.ge_contratista GCON
    ON GCON.ID_CONTRATISTA = DUO.Contractor_Id
-----------------------------------------------------------------------------------------------------
 WHERE a.task_type_id IN
       (SELECT to_number(regexp_substr(&SBTT_CXC_SIN_LEG, '[^,]+', 1, LEVEL)) AS task_type
          FROM dual
        CONNECT BY regexp_substr(&SBTT_CXC_SIN_LEG, '[^,]+', 1, LEVEL) IS NOT NULL)
   AND a.order_status_id in (7, 5)
  AND trunc(sysdate - OL.EXEC_FINAL_DATE) >= &NUDIAS_SIN_LEG_CXC
 order by 1
