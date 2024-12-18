CREATE OR REPLACE PROCEDURE PR_ACTPRPRODUCT_ROLLOUT1 (nuInicio number, nuFinal number, nuBD number) AS
/*******************************************************************
 PROGRAMA    	:	PR_ACTPRPRODUCT_ROLLOUT
 FECHA		:	26/08/2014
 AUTOR		:	OLSoftware
 DESCRIPCION	:	Actualiza el campo SUSPEN_ORD_ACT_ID de PR_PRODUCT	
 HISTORIA DE MODIFICACIONES
 AUTOR	   FECHA	DESCRIPCION

 *******************************************************************/ 

i number := 0;

    CURSOR cuProductos IS
        SELECT P.PRODUCT_ID PRODUCTO, 
	       P.SUBSCRIPTION_ID CONTRATO, 
	       PR.SUSPENSION_TYPE_ID
          FROM PR_PRODUCT P, PR_PROD_SUSPENSION PR
         WHERE P.PRODUCT_ID = PR.PRODUCT_ID
           AND P.PRODUCT_STATUS_ID = 2
           and p.product_id in (50044737,
4067602,
1506929,
2024821,
17046711,
2086792,
4065008,
2083557,
50097103,
2071832,
2061096,
50061457,
1132757,
17036338,
17046074,
1147461,
50012680,
17028282,
2050522,
50023959,
17037329,
1173044,
1178166,
1508909,
2076337,
1045710,
6088207,
2069240,
1143727,
2075043,
17045757,
50058789,
1117373,
17018904,
17048758,
2079233,
50108303,
50076030,
2058344,
2068360,
17010485,
17005292,
2022069,
6120005,
17032445,
17036348,
1165731,
17026128,
2050520,
2050665,
2069032,
2050192,
2067881,
12002594,
1079903,
1106759,
17038037,
17048450,
2077723,
2066934,
2092935);

    CURSOR cuOrderActivity(nuProd number) IS
     SELECT MAX(B.ORDER_ACTIVITY_ID) ACTIVIDAD 
       FROM OR_ORDER A, OR_ORDER_ACTIVITY B
      WHERE A.ORDER_ID = B.ORDER_ID
        AND EXISTS (SELECT 1 FROM MIGRA.LDC_MIG_PARATIPO G, LDC_MIG_TIPOTRAB C
                            WHERE G.PARACODI IN ('SUSPENSIONES')
                              AND G.PARATITA = C.ORTRTITR
                              AND C.TRABHOMO = A.TASK_TYPE_ID)
                              AND B.PRODUCT_ID = nuProd
                              AND A.LEGALIZATION_DATE = (SELECT MAX(D.LEGALIZATION_DATE)
                                                              FROM OR_ORDER D, OR_ORDER_ACTIVITY E
                                                             WHERE D.ORDER_ID = E.ORDER_ID
                                                               AND EXISTS (SELECT 1 FROM MIGRA.LDC_MIG_PARATIPO H, LDC_MIG_TIPOTRAB J
                                                                                   WHERE H.PARACODI IN ('SUSPENSIONES')
                                                                                     AND H.PARATITA = J.ORTRTITR
                                                                                     AND J.TRABHOMO = D.TASK_TYPE_ID)
                                                                AND E.PRODUCT_ID = nuProd);
                                                                
    rgOrderActivity   cuOrderActivity%rowtype;

  nuLogError number;

BEGIN

    PKLOG_MIGRACION.prInsLogMigra (505,505,1,'PR_ACTPRPRODUCT_ROLLOUT',0,0,'INICIA PROCESO','INICIA',nuLogError);
    
     UPDATE MIGR_RANGO_PROCESOS SET RAPRFEIN = SYSDATE, RAPRTERM = 'P' WHERE RAPRCODI = 505 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
     COMMIT;

    FOR rgProdcut IN cuProductos LOOP
    
    i := i +1; 

	--IF rgProdcut.suspension_type_id IN (2,11,101,102,103,104) THEN
        
            rgOrderActivity := null;

            OPEN cuOrderActivity(rgProdcut.PRODUCTO);
            FETCH cuOrderActivity INTO rgOrderActivity;
            CLOSE cuOrderActivity;
            
                UPDATE PR_PRODUCT
                SET SUSPEN_ORD_ACT_ID = rgOrderActivity.ACTIVIDAD
                WHERE PRODUCT_ID = rgProdcut.PRODUCTO;
                
                
                if i = 100 then
                i := 0;
                
                COMMIT;
                
                end if;

        --END IF;

    END LOOP; -- Fin for cuProductos

    PKLOG_MIGRACION.prInsLogMigra (505,505,3,'PR_ACTPRPRODUCT_ROLLOUT',0,0,'TERMINA PROCESO','FIN',nuLogError);
    
    UPDATE MIGR_RANGO_PROCESOS SET RAPRFEFI = SYSDATE, RAPRTERM = 'T' where RAPRCODI = 505 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
    COMMIT;

END PR_ACTPRPRODUCT_ROLLOUT1; 
/
