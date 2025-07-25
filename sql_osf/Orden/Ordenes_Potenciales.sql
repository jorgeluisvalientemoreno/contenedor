SELECT NVL(SU.SUBSCRIBER_ID,
           (SELECT SC.SUBSCRIBER_ID
              FROM OPEN.GE_SUBSCRIBER SC
             WHERE SC.SUBSCRIBER_ID = OA.SUBSCRIBER_ID
               AND ROWNUM = 1)) CLIENTE,
       NVL(SU.IDENTIFICATION,
           (SELECT SC.IDENTIFICATION
              FROM OPEN.GE_SUBSCRIBER SC
             WHERE SC.SUBSCRIBER_ID = OA.SUBSCRIBER_ID
               AND ROWNUM = 1)) NIT_RUT,
       DECODE(NVL(SU.SUBSCRIBER_ID, '0'),
              '0',
              (SELECT SC.SUBSCRIBER_NAME || ' ' || SC.SUBS_LAST_NAME
                 FROM OPEN.GE_SUBSCRIBER SC
                WHERE SC.SUBSCRIBER_ID = OA.SUBSCRIBER_ID
                  AND ROWNUM = 1),
              SU.SUBSCRIBER_NAME || ' ' || SU.SUBS_LAST_NAME) NOMBRE_SUSCRIPTOR,
       DECODE(NVL(SU.SUBSCRIBER_ID, '0'),
              '0',
              (SELECT TY.SUBSCRIBER_TYPE_ID || ' - ' || TY.DESCRIPTION
                 FROM OPEN.GE_SUBSCRIBER SC, OPEN.GE_SUBSCRIBER_TYPE TY
                WHERE SC.SUBSCRIBER_ID = OA.SUBSCRIBER_ID
                  AND TY.SUBSCRIBER_TYPE_ID = SC.SUBSCRIBER_TYPE_ID
                  AND ROWNUM = 1),
              ST.SUBSCRIBER_TYPE_ID || ' - ' || ST.DESCRIPTION) TIPO_CLIENTE,
       NVL(B.ADDRESS_PARSED,
           (SELECT AB.ADDRESS_PARSED
              FROM OPEN.AB_ADDRESS AB
             WHERE AB.ADDRESS_ID = OA.ADDRESS_ID
               AND ROWNUM = 1)) DIRECCION,
       DECODE(NVL(B.ADDRESS_PARSED, '0'),
              '0',
              (SELECT BR.GEOGRAP_LOCATION_ID || ' - ' || BR.DESCRIPTION
                 FROM OPEN.AB_ADDRESS AB, OPEN.GE_GEOGRA_LOCATION BR
                WHERE AB.ADDRESS_ID = OA.ADDRESS_ID
                  AND BR.GEOGRAP_LOCATION_ID = AB.NEIGHBORTHOOD_ID
                  AND ROWNUM = 1),
              N.GEOGRAP_LOCATION_ID || ' - ' || N.DESCRIPTION) BARRIO,
       DECODE(NVL(B.ADDRESS_PARSED, '0'),
              '0',
              (SELECT LO.GEOGRAP_LOCATION_ID || ' - ' || LO.DESCRIPTION
                 FROM OPEN.AB_ADDRESS AB, OPEN.GE_GEOGRA_LOCATION LO
                WHERE AB.ADDRESS_ID = OA.ADDRESS_ID
                  AND LO.GEOGRAP_LOCATION_ID = AB.GEOGRAP_LOCATION_ID
                  AND ROWNUM = 1),
              L.GEOGRAP_LOCATION_ID || ' - ' || L.DESCRIPTION) LOCALIDAD,
       DECODE(NVL(B.ADDRESS_PARSED, '0'),
              '0',
              (SELECT FT.GEOGRAP_LOCATION_ID || ' - ' || FT.DESCRIPTION
                 FROM OPEN.AB_ADDRESS         AB,
                      OPEN.GE_GEOGRA_LOCATION LO,
                      OPEN.GE_GEOGRA_LOCATION FT
                WHERE AB.ADDRESS_ID = OA.ADDRESS_ID
                  AND LO.GEOGRAP_LOCATION_ID = AB.GEOGRAP_LOCATION_ID
                  AND FT.GEOGRAP_LOCATION_ID = LO.GEO_LOCA_FATHER_ID
                  AND ROWNUM = 1),
              D.GEOGRAP_LOCATION_ID || ' - ' || D.DESCRIPTION) DEPARTAMENTO,
       NVL(SU.PHONE,
           (SELECT SC.PHONE
              FROM OPEN.GE_SUBSCRIBER SC
             WHERE SC.SUBSCRIBER_ID = OA.SUBSCRIBER_ID
               AND ROWNUM = 1)) TELEFONO,
       NVL(SR.SUSCCODI, OA.SUBSCRIPTION_ID) CONTRATO,
       P.PACKAGE_ID SOLICITUD,
       O.ORDER_ID,
       T.TASK_TYPE_ID || ' - ' || T.DESCRIPTION TIPO_TRABAJO,
       CA.CAUSAL_ID || ' - ' || CA.DESCRIPTION CAUSAL,
       E.ORDER_STATUS_ID || ' - ' || E.DESCRIPTION ESTADO,
       OP.OPERATING_UNIT_ID || ' - ' || OP.NAME UNIDAD_TRABAJO,
       S.OPER_UNIT_STATUS_ID || ' - ' || S.DESCRIPTION ESTADO_UNIDAD_TRABAJO,
       OS.OPERATING_SECTOR_ID || ' - ' || OS.DESCRIPTION SECTOR_OPERATIVO,
       NVL(MO.PRODUCT_ID, OA.PRODUCT_ID) PRODUCTO,
       O.CREATED_DATE FECHA_CREACION,
       O.ASSIGNED_DATE FECHA_ASIGNACION,
       DECODE(O.ASSIGNED_WITH,
              'S',
              'HORARIO',
              'C',
              'CAPACIDAD HORARIA',
              'N',
              'DEMANDA',
              'R',
              'RUTA') TIPO_ASIGNACION,
       O.EXEC_ESTIMATE_DATE FECHA_ESTIMADA_EJEC,
       O.MAX_DATE_TO_LEGALIZE FECHA_MAX_LEGAL,
       O.LEGALIZATION_DATE FECHA_LEGALIZACION,
       O.EXEC_INITIAL_DATE INICIO_EJECUCION,
       O.EXECUTION_FINAL_DATE FIN_EJECUCION,
       PE.PERSON_ID || ' - ' || PE.NAME_ PERSONAL,
       OPEN.LDC_REPORTESCONSULTA.fsbObservacionOT(O.ORDER_ID) COMENTARIO,
       ap.category_ || ' - ' || c.catedesc categotia,
       ap.subcategory_ || ' - ' || suc.sucadesc Subcategoria
  FROM OPEN.OR_ORDER            O,
       OPEN.OR_TASK_TYPE        T,
       OPEN.OR_ORDER_ACTIVITY   OA,
       OPEN.MO_PACKAGES         P,
       OPEN.MO_MOTIVE           MO,
       OPEN.SUSCRIPC            SR,
       OPEN.GE_SUBSCRIBER       SU,
       OPEN.GE_SUBSCRIBER_TYPE  ST,
       OPEN.AB_ADDRESS          B,
       OPEN.GE_GEOGRA_LOCATION  L,
       OPEN.GE_GEOGRA_LOCATION  D,
       OPEN.GE_GEOGRA_LOCATION  N,
       OPEN.GE_CAUSAL           CA,
       OPEN.OR_ORDER_STATUS     E,
       OPEN.OR_OPERATING_UNIT   OP,
       OPEN.OR_OPER_UNIT_STATUS S,
       OPEN.OR_ORDER_PERSON     LP,
       OPEN.GE_PERSON           PE,
       OPEN.OR_OPERATING_SECTOR OS,
       open.AB_PREMISE          ap,
       open.categori            c,
       open.subcateg            suc
 WHERE T.TASK_TYPE_ID = O.TASK_TYPE_ID(+)
   AND OA.ORDER_ID(+) = O.ORDER_ID
   AND P.PACKAGE_ID(+) = OA.PACKAGE_ID
   AND MO.PACKAGE_ID(+) = P.PACKAGE_ID
   AND SR.SUSCCODI(+) = MO.SUBSCRIPTION_ID
   AND SU.SUBSCRIBER_ID(+) = SR.SUSCCLIE
   AND ST.SUBSCRIBER_TYPE_ID(+) = SU.SUBSCRIBER_TYPE_ID
   AND B.ADDRESS_ID(+) = o.external_address_id --SR.SUSCIDDI
   AND L.GEOGRAP_LOCATION_ID(+) = B.GEOGRAP_LOCATION_ID
   AND D.GEOGRAP_LOCATION_ID(+) = L.GEO_LOCA_FATHER_ID
   AND N.GEOGRAP_LOCATION_ID(+) = B.NEIGHBORTHOOD_ID
   AND CA.CAUSAL_ID(+) = O.CAUSAL_ID
   AND E.ORDER_STATUS_ID(+) = O.ORDER_STATUS_ID
   AND OP.OPERATING_UNIT_ID(+) = O.OPERATING_UNIT_ID
   AND S.OPER_UNIT_STATUS_ID(+) = OP.OPER_UNIT_STATUS_ID
   AND LP.ORDER_ID(+) = O.ORDER_ID
   AND PE.PERSON_ID(+) = LP.PERSON_ID
   AND OS.OPERATING_SECTOR_ID(+) = O.OPERATING_SECTOR_ID
      --AND NVL(D.GEOGRAP_LOCATION_ID,-1) = DECODE({?Departamento}, -1, NVL(D.GEOGRAP_LOCATION_ID,-1), {?Departamento})
      --AND NVL(L.GEOGRAP_LOCATION_ID,-1) = DECODE({?Localidad}, -1, NVL(L.GEOGRAP_LOCATION_ID,-1), {?Localidad})
      --AND NVL(B.NEIGHBORTHOOD_ID,0) in DECODE({?Barrio}, -1, NVL(B.NEIGHBORTHOOD_ID,0), {?Barrio})
      --AND NVL(SU.IDENTIFICATION,-1) = DECODE({?Identificacion}, -1, NVL(SU.IDENTIFICATION,-1), {?Identificacion})
   AND t.TASK_TYPE_ID in (11397) -- {?Tipotrabajo}
      --AND NVL(O.CAUSAL_ID,0) = DECODE({?Causal}, -1, NVL(O.CAUSAL_ID,0), {?Causal})
      --AND O.ORDER_STATUS_ID = DECODE({?Estado}, -1, O.ORDER_STATUS_ID, {?Estado})
   AND O.CREATED_DATE >= '01/06/2024' --TO_DATE(TO_CHAR({?FechaIni},'dd/mm/yyyy') || '00:00:00','dd/mm/yyyy hh24:mi:ss')
   AND O.CREATED_DATE <= '30/12/2024' --TO_DATE(TO_CHAR({?FechaFin},'dd/mm/yyyy') || '23:59:59','dd/mm/yyyy hh24:mi:ss')
   and b.estate_number = ap.premise_id
   and c.catecodi = ap.category_
   and (suc.sucacate = ap.category_ and suc.sucacodi = ap.subcategory_)
