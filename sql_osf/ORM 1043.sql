SELECT  M.PACKAGE_ID "NÚMERO DE SOLICITUD",
        PP.SUBSCRIPTION_ID "CONTRATO",
        PP.PRODUCT_ID "NÚMERO PRODUCTO",
        PS.PACKAGE_TYPE_ID||' - '||UPPER(PS.DESCRIPTION) "TIPO DE SOLICITUD",
        DECODE(LO.GEO_LOCA_FATHER_ID,2,'CALDAS',3,'QUINDIO',4,'RISARALDA','OTRO') "DEPARTAMENTO",
        MA.GEOGRAP_LOCATION_ID "LOCALIDAD", 
        LO.DESCRIPTION "NOMBRE DE LOCALIDAD",
        (SELECT MMA.ADDRESS FROM OPEN.AB_ADDRESS MMA WHERE MMA.ADDRESS_ID = PP.ADDRESS_ID) "DIRECCIÓN DE INSTALACIÓN",
        (
        SELECT  PREMTY.DESCRIPTION
        FROM    OPEN.AB_PREMISE_TYPE PREMTY, OPEN.AB_PREMISE PREM
        WHERE   PREM.PREMISE_TYPE_ID = PREMTY.PREMISE_TYPE_ID
        AND     PREM.PREMISE_ID = ABAD.ESTATE_NUMBER
        ) "TIPO PREDIO",
        M.DOCUMENT_TYPE_ID "TIPO DE FORMULARIO",
        PP.PRODUCT_TYPE_ID ||' - '||(SELECT SERV.SERVDESC
                                     FROM OPEN.SERVICIO SERV
                                     WHERE SERV.SERVCODI = PP.PRODUCT_TYPE_ID) "TIPO PRODUCTO",
        PP.PRODUCT_STATUS_ID ||' - '||(SELECT PPS.DESCRIPTION
                                       FROM OPEN.PS_PRODUCT_STATUS PPS
                                       WHERE PPS.PRODUCT_STATUS_ID = PP.PRODUCT_STATUS_ID) "ESTADO PRODUCTO",        
        M.REQUEST_DATE "FECHA DE ELABORACIÓN VENTA",
        M.MESSAG_DELIVERY_DATE "FECHA DIGITACIÓN DE VENTA",
        M.ATTENTION_DATE "FECHA DE ATENCIÓN",
        M.MOTIVE_STATUS_ID||' - '||UPPER(MOST.DESCRIPTION) "ESTADO DE LA SOLICITUD",
        --M.MOTIVE_STATUS_ID||' - '||OPEN.DAPS_MOTIVE_STATUS.FSBGETDESCRIPTION(M.MOTIVE_STATUS_ID) "ESTADO DE LA SOLICITUD",
        M.PERSON_ID "ASESOR DE VENTA",
        PERS.NAME_ "NOMBRE DEL ASESOR DE VENTA",
        G.IDENT_TYPE_ID||'-'||DI.DESCRIPTION "TIPO DE IDENTIFICACIÓN",
        G.IDENTIFICATION "IDENTIFICACIÓN DE CLIENTE",
        G.SUBSCRIBER_NAME||' '||G.SUBS_LAST_NAME "NOMBRE DE CLIENTE",
        M.POS_OPER_UNIT_ID "UNIDAD DE TRABAJO",
        OP.NAME "NOMBRE DE UNIDAD DE TRABAJO",
        MO.COMMERCIAL_PLAN_ID "PLAN COMERCIAL",
        PC.DESCRIPTION "NOMBRE DEL PLAN COMERCIAL",
        PF.FINANCING_PLAN_ID "PLAN DE FINANCIACIÓN",
        PD.PLDIDESC  "NOMBRE PLAN DE FINANCIACIÓN",
        PF.QUOTAS_NUMBER  "NÚMERO DE CUOTAS",
        MO.MOTIVE_ID "MOTIVO ID",
        (SELECT LISTAGG(
          PR.DESCRIPTION,
          ';'
        ) WITHIN GROUP ( ORDER BY MOT.PROMOTION_ID) AS PROMOCIONES
         FROM   OPEN.MO_MOT_PROMOTION MOT, OPEN.CC_PROMOTION PR
         WHERE   MOT.MOTIVE_ID = MO.MOTIVE_ID
        AND MOT.PROMOTION_ID = PR.PROMOTION_ID
        GROUP BY MOT.MOTIVE_ID)"PROMOCIONES MO",
        NVL((SELECT SUM(CARGOS.CARGVALO)
                FROM OPEN.CARGOS
                WHERE CARGOS.CARGDOSO = 'PP-'||M.PACKAGE_ID
                  AND CARGOS.CARGSIGN = 'DB'
                  AND CARGOS.CARGTIPR = 'A'), 0) "VALOR DE LA VENTA",
        NVL((SELECT T.VALUE_TO_FINANCE
         FROM OPEN.CC_SALES_FINANC_COND T
         WHERE T.PACKAGE_ID = M.PACKAGE_ID),0) "VALOR A FINANCIAR",
        NVL((SELECT SUM(DECODE(CARGSIGN,'DB',CARGVALO,'CR',-CARGVALO))
              FROM OPEN.CARGOS
             WHERE CARGOS.CARGDOSO = 'PP-'||M.PACKAGE_ID
               AND CARGOS.CARGSIGN = 'DB'
               AND CARGOS.CARGCONC IN (19)
               AND CARGTIPR = 'A'
            ), 0) CARGO_CONEXION,
         NVL((SELECT SUM(DECODE(CARGSIGN,'DB',CARGVALO,'CR',-CARGVALO))
              FROM OPEN.CARGOS
             WHERE CARGOS.CARGDOSO = 'PP-'||M.PACKAGE_ID
               AND CARGOS.CARGSIGN = 'DB'
               AND CARGOS.CARGCONC IN (30, 289, 318, 613)
               AND CARGTIPR = 'A'
            ), 0) RED_INTERNA,
           CASE
       WHEN (M.PACKAGE_TYPE_ID IN (271,100229)) THEN
       NVL((SELECT SUM(CARGOS.CARGVALO)
           FROM  OPEN.CARGOS
           WHERE CARGOS.CARGDOSO = 'PP-'||M.PACKAGE_ID
           AND CARGOS.CARGCONC = 102
           AND CARGOS.CARGSIGN = 'CR'), 0)
        END "VALOR DE DESCUENTO",
       (SELECT 
            (SELECT  CC.CUCOFACT FROM OPEN.CUENCOBR CC WHERE CC.CUCOCODI=CA.CARGCUCO)
         FROM OPEN.CC_SALES_FINANC_COND FN, OPEN.DIFERIDO DF,OPEN.CARGOS CA WHERE FN.PACKAGE_ID=M.PACKAGE_ID AND FN.FINAN_ID=DF.DIFECOFI
         AND CA.CARGDOSO='DF-'||DF.DIFECODI AND DF.DIFECONC IN (19,30,674) AND CA.CARGPROG=5 AND ROWNUM=1) "NUMERO _FACTURA",
        
      (SELECT 
            (SELECT  TRUNC(CC.CUCOFEVE) FROM OPEN.CUENCOBR CC WHERE CC.CUCOCODI=CA.CARGCUCO)
       	 FROM OPEN.CC_SALES_FINANC_COND FN, OPEN.DIFERIDO DF,OPEN.CARGOS CA WHERE FN.PACKAGE_ID=M.PACKAGE_ID AND FN.FINAN_ID=DF.DIFECOFI
             AND CA.CARGDOSO='DF-'||DF.DIFECODI AND DF.DIFECONC IN (19,30,674) AND CA.CARGPROG=5 AND ROWNUM=1) "FECHA VENCIMIENTO CC",
      (SELECT (SELECT AA.CARGFECR
          		FROM OPEN.CARGOS AA 
				WHERE AA.CARGCUCO=CA.CARGCUCO AND AA.CARGSIGN='PA' AND ROWNUM=1) 
	   FROM OPEN.CC_SALES_FINANC_COND FN, 
	 		OPEN.DIFERIDO DF,
	 		OPEN.CARGOS CA 
	   WHERE FN.PACKAGE_ID=M.PACKAGE_ID 
	  AND FN.FINAN_ID=DF.DIFECOFI
	  AND CA.CARGDOSO='DF-'||DF.DIFECODI 
	  AND DF.DIFECONC IN (19,30,674) 
	  AND CA.CARGPROG=5 AND ROWNUM=1)  "FECHA DE PAGO",
	  (SELECT 
              (SELECT PP.PAGOVAPA
                 FROM OPEN.CARGOS AA,OPEN.PAGOS PP WHERE AA.CARGCUCO=CA.CARGCUCO AND AA.CARGSIGN='PA' AND AA.CARGCODO=PP.PAGOCUPO AND ROWNUM=1)
        FROM OPEN.CC_SALES_FINANC_COND FN, OPEN.DIFERIDO DF,OPEN.CARGOS CA WHERE FN.PACKAGE_ID=M.PACKAGE_ID AND FN.FINAN_ID=DF.DIFECOFI
                AND CA.CARGDOSO='DF-'||DF.DIFECODI AND DF.DIFECONC IN (19,30,674) AND CA.CARGPROG=5 AND ROWNUM=1) "VALOR PAGO",
      
      (SELECT CASE WHEN COUNT(*) >0 THEN
            	'SI'
           	  ELSE
           		'NO' 
      		  END
      FROM OPEN.CC_SALES_FINANC_COND FN, OPEN.DIFERIDO DF WHERE FN.PACKAGE_ID=M.PACKAGE_ID AND FN.FINAN_ID=DF.DIFECOFI) "CREO FINACIACION",
      (SELECT CASE WHEN COUNT(*) >0 THEN
            	'FACTURADA'
           	  ELSE
           		'NO FACTURADA' 
         	  END 
       FROM OPEN.CC_SALES_FINANC_COND FN, OPEN.DIFERIDO DF,OPEN.CARGOS CA
             WHERE FN.PACKAGE_ID=M.PACKAGE_ID AND FN.FINAN_ID=DF.DIFECOFI
             AND CA.CARGDOSO='DF-'||DF.DIFECODI AND DF.DIFECONC IN (19,30,674) AND CA.CARGPROG=5) "VENTA FACTURADA",
       (SELECT 
              (SELECT CASE WHEN COUNT(*) >0 THEN
                  'PAGADA'
                 ELSE
                  'NO PAGA' 
         	  END 
                 FROM OPEN.CARGOS AA WHERE AA.CARGCUCO=CA.CARGCUCO AND AA.CARGSIGN='PA')
		FROM OPEN.CC_SALES_FINANC_COND FN, OPEN.DIFERIDO DF,OPEN.CARGOS CA WHERE FN.PACKAGE_ID=M.PACKAGE_ID AND FN.FINAN_ID=DF.DIFECOFI
				AND CA.CARGDOSO='DF-'||DF.DIFECODI AND DF.DIFECONC IN (19,30,674) AND CA.CARGPROG=5 AND ROWNUM=1)  "PAGO", 
		(SELECT SUM(DIFESAPE) FROM OPEN.CC_SALES_FINANC_COND FN, OPEN.DIFERIDO DF WHERE FN.PACKAGE_ID=M.PACKAGE_ID AND FN.FINAN_ID=DF.DIFECOFI AND DF.DIFECONC IN (19,30,674)) "DEUDA DIFERIDA",  
		NVL((SELECT SUM(CC.CUCOSACU) FROM OPEN.CUENCOBR CC WHERE CC.CUCONUSE=PP.PRODUCT_ID AND CC.CUCOSACU>0),0)  AS "DEUDA CORRIENTE", 
             (
        SELECT X.NOTATINO TIPO_DE_NOTA
        FROM  (SELECT * FROM OPEN.NOTAS WHERE NOTACONS = 70 ORDER BY NOTAS.NOTAFECR  ) X
        WHERE ROWNUM = 1 AND X.NOTASUSC = PP.SUBSCRIPTION_ID
        ) "TIPO DE NOTA",
        (
        SELECT X.NOTAOBSE TIPO_DE_NOTA
        FROM  (SELECT * FROM OPEN.NOTAS WHERE NOTACONS = 70 ORDER BY NOTAS.NOTAFECR  ) X
        WHERE ROWNUM = 1 AND X.NOTASUSC = PP.SUBSCRIPTION_ID
        ) "OBSERVACIÓN DE LA NOTA",
         (
        SELECT X.NOTATINO TIPO_DE_NOTA
        FROM  (SELECT * FROM OPEN.NOTAS WHERE NOTATINO = 'C' ORDER BY NOTAS.NOTAFECR  ) X
        WHERE ROWNUM = 1 AND X.NOTASUSC = PP.SUBSCRIPTION_ID
        ) "TIPO DE NOTA C",
        (
        SELECT X.NOTAOBSE TIPO_DE_NOTA
        FROM  (SELECT * FROM OPEN.NOTAS WHERE NOTATINO = 'C' ORDER BY NOTAS.NOTAFECR  ) X
        WHERE ROWNUM = 1 AND X.NOTASUSC = PP.SUBSCRIPTION_ID
        ) "OBSERVACIÓN DE LA NOTA C",

        (
        SELECT  MIN(NOTAFECR)FECHA 
        FROM  OPEN.NOTAS
        WHERE  NOTAS.NOTASUSC = PP.SUBSCRIPTION_ID AND NOTACONS = 70
        ) "FECHA DE NOTA",
        (
        SELECT G.INITIAL_DATE
        FROM OPEN.CC_GRACE_PERI_DEFE G, OPEN.DIFERIDO D 
        WHERE D.DIFESUSC = PP.SUBSCRIPTION_ID AND G.DEFERRED_ID = D.DIFECODI AND  ROWNUM = 1
        )"FECHA INI GRACIA",
        (
        SELECT  G.END_DATE
        FROM OPEN.CC_GRACE_PERI_DEFE G, OPEN.DIFERIDO D 
        WHERE D.DIFESUSC = PP.SUBSCRIPTION_ID AND G.DEFERRED_ID = D.DIFECODI AND  ROWNUM = 1
        )"FECHA FIN GRACIA",
        (SELECT CARGFECR FROM OPEN.CARGOS CAR 
         WHERE CAR.CARGNUSE=PP.PRODUCT_ID AND CAR.CARGCONC=287 AND CARGCACA=15 
         AND CAR.CARGCUCO>(SELECT CA.CARGCUCO
                           FROM OPEN.CC_SALES_FINANC_COND FN, OPEN.DIFERIDO DF,OPEN.CARGOS CA
             			   WHERE FN.PACKAGE_ID=M.PACKAGE_ID AND FN.FINAN_ID=DF.DIFECOFI
                           AND CA.CARGDOSO='DF-'||DF.DIFECODI AND DF.DIFECONC IN (19,30,674) AND CA.CARGPROG=5 AND ROWNUM=1) 
         AND ROWNUM=1 ) "FECHA_SIG_FACTURA",
        (SELECT CC.CUCOFACT 
         FROM OPEN.CARGOS CAR, OPEN.CUENCOBR CC
         WHERE CC.CUCOCODI=CAR.CARGCUCO AND CAR.CARGNUSE=PP.PRODUCT_ID 
         AND CAR.CARGCONC=287 AND CARGCACA=15 
         AND CAR.CARGCUCO>(SELECT CA.CARGCUCO
                           FROM OPEN.CC_SALES_FINANC_COND FN, OPEN.DIFERIDO DF,OPEN.CARGOS CA
             			   WHERE FN.PACKAGE_ID=M.PACKAGE_ID AND FN.FINAN_ID=DF.DIFECOFI
             			   AND CA.CARGDOSO='DF-'||DF.DIFECODI AND DF.DIFECONC IN (19,30,674) AND CA.CARGPROG=5 AND ROWNUM=1) 
         AND ROWNUM=1 ) "SIG_FACTURA"
        
FROM    OPEN.MO_PACKAGES M, --- (ENTIDAD SOLICITUDES)
        OPEN.MO_ADDRESS MA, --- (ENTIDAD BANCO DE DIRECCIONES)
        OPEN.GE_SUBSCRIBER G,-- (ENTIDAD CLIENTE)
        OPEN.MO_MOTIVE MO,---- (ENTIDAD MOTIVO)
        OPEN.PR_PRODUCT PP,--- (ENTIDAD PRODUCTO)
        OPEN.AB_ADDRESS ABAD, --- (ENTIDAD BANCO DE DIRECCIONES)
        OPEN.PS_PACKAGE_TYPE PS, --- (ENTIDAD TIPO PAQUETES) 
        OPEN.GE_GEOGRA_LOCATION LO,
        OPEN.GE_PERSON PERS,
        OPEN.PS_MOTIVE_STATUS MOST,
        OPEN.OR_OPERATING_UNIT OP,
        OPEN.GE_IDENTIFICA_TYPE DI,
        OPEN.cc_commercial_plan PC,
        OPEN.cc_sales_financ_cond PF,
        OPEN.PLANDIFE PD     
WHERE   M.PACKAGE_ID = MO.PACKAGE_ID
AND     M.PACKAGE_ID = MA.PACKAGE_ID
AND     MOST.MOTIVE_STATUS_ID = M.MOTIVE_STATUS_ID
AND     MA.PARSER_ADDRESS_ID = ABAD.ADDRESS_ID
AND     M.SUBSCRIBER_ID = G.SUBSCRIBER_ID
AND     M.POS_OPER_UNIT_ID = OP.OPERATING_UNIT_ID
AND     G.IDENT_TYPE_ID = DI.IDENT_TYPE_ID
AND     MO.COMMERCIAL_PLAN_ID = PC.COMMERCIAL_PLAN_ID
AND     m.package_id = PF.PACKAGE_ID (+)
AND     PF.financing_plan_id = PD.PLDICODI (+)
AND     MO.PRODUCT_ID = PP.PRODUCT_ID(+)
AND     ABAD.GEOGRAP_LOCATION_ID = LO.GEOGRAP_LOCATION_ID (+)
AND     M.PACKAGE_TYPE_ID = PS.PACKAGE_TYPE_ID
AND     M.PERSON_ID = PERS.PERSON_ID
AND     MO.PRODUCT_TYPE_ID IN (7014, 3)
AND     M.PACKAGE_TYPE_ID IN (100229,271,329,100271)
AND     PF.FINANCING_PLAN_ID IN (99,286,273)
AND     MO.COMMERCIAL_PLAN_ID IN (4,5,6,7,8,9,10,11,12,13,14,15,26,27,77,79,80,81,88,89,90,91) 
AND 	M.MESSAG_DELIVERY_DATE BETWEEN TO_DATE(TO_CHAR(:FECHA_INICIAL||' 00:00:00'),'DD/MM/YYYY HH24:MI:SS')  AND TO_DATE(TO_CHAR(:FECHA_FINAL||' 23:59:59'),'DD/MM/YYYY HH24:MI:SS')
AND     MO.CATEGORY_ID IN (1,2)
--AND     M.PACKAGE_ID IN (57076456,56544151)
