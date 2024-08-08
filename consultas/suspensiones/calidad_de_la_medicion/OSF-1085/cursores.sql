SELECT P.PRODUCT_ID, P.ADDRESS_ID, P.SUBSCRIPTION_ID contrato, SU.SUSCCLIE
      FROM PR_PRODUCT P
      INNER JOIN PR_PROD_SUSPENSION S ON S.PRODUCT_ID=P.PRODUCT_ID AND S.ACTIVE='Y' AND S.SUSPENSION_TYPE_ID=106
      INNER JOIN SUSCRIPC SU ON SU.SUSCCODI=P.SUBSCRIPTION_ID
      WHERE PRODUCT_STATUS_ID=2
        AND PRODUCT_TYPE_ID=pkg_parametros.fnuGetValorNumerico('SERVICIO_GAS_CLM')
        AND ldc_boprocesaordvmp.pvalidatiposuspension(p.product_id)='CM'
        AND EXISTS(SELECT NULL FROM ldc_vpm v WHERE v.product_id=p.product_id AND v.fecha_proxima_vpm<=SYSDATE)
        and p.product_id in (1046334,
1127407,
50710246,
50946065,
1041634,
50077862,
50885151,
50146533,
50190087,
1502743,
6531969,
50675370,
6088775,
1158304,
1158304,
50546035,
50546035,
1114009,
1120500,
6129465,
6555953,
50194184,
1509630,
1509630,
50002591,
50002591,
6626652
);
        --
        
        select ldc_boprocesaordvmp.pvalidatiposuspension(52352477) from dual
        --
SELECT O.ORDER_ID, O.LEGALIZATION_DATE, O.CAUSAL_ID, O.TASK_TYPE_ID
    FROM OR_ORDER O
    INNER JOIN OR_ORDER_ACTIVITY A ON A.ORDER_ID=O.ORDER_ID
    WHERE A.PRODUCT_ID = 52352477
     AND O.ORDER_STATUS_ID = 8
     AND pkg_bcordenes.fblObtenerEsNovedad(o.order_id) = 'N'
     AND O.TASK_TYPE_ID IN (SELECT TITR FROM
     (

     SELECT TO_NUMBER(SUBSTR(DatosParametro, 1, INSTR(DatosParametro, '|', 1) - 1)) titr,
       TO_NUMBER(SUBSTR(DatosParametro,
              INSTR(DatosParametro, '|', 1,1) + 1,
              INSTR(DatosParametro, '|', 1,2)  -INSTR(DatosParametro, '|', 1,1) -1)) causal,
       TO_NUMBER(SUBSTR(DatosParametro,
              INSTR(DatosParametro, '|', 1,2) + 1,
              INSTR(DatosParametro, '|', 1,3) + -INSTR(DatosParametro, '|', 1,2)-1 )) dias,
       TO_NUMBER(SUBSTR(DatosParametro,
              INSTR(DatosParametro, '|', 1,3) + 1)) actividad
  FROM (
        SELECT regexp_substr(sbUltTitr, '[^;]+', 1, LEVEL)AS DatosParametro
		FROM dual
		CONNECT BY regexp_substr(sbUltTitr, '[^;]+', 1, LEVEL) IS NOT NULL
        )

     ))
    ORDER BY O.LEGALIZATION_DATE DESC;
    
    ---
SELECT * --order_status_id --COUNT(*)
FROM or_order_activity ooa, or_order oo
WHERE ooa.product_id = 52352477
AND oo.order_id = ooa.order_id
AND oo.task_type_id IN
                     (
                       SELECT to_number(regexp_substr('11188,11189,11056,11180,11056,11181,11026,11032','[^,]+',1,LEVEL)) AS Tipo_Reco
                                        FROM dual
                                        CONNECT BY regexp_substr('11188,11189,11056,11180,11056,11181,11026,11032', '[^,]+', 1, LEVEL) IS NOT NULL
                      UNION ALL
                       SELECT to_number(regexp_substr('10444,10449,10450,10723,10795,10833,10834,10835,10836, 12457,12460,11026,11032,11056,11186,11187,11190,11188,11232,11234,11233,11189,11179,11180','[^,]+',1,LEVEL)) AS Tipo_Reco
                                        FROM dual
                                        CONNECT BY regexp_substr('10444,10449,10450,10723,10795,10833,10834,10835,10836, 12457,12460,11026,11032,11056,11186,11187,11190,11188,11232,11234,11233,11189,11179,11180', '[^,]+', 1, LEVEL) IS NOT NULL
                     )
AND oo.order_status_id IN (0, 5, 6, 7,11 ,20);
