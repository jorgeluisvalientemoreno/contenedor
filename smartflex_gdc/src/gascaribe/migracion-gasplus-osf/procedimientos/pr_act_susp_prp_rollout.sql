CREATE OR REPLACE procedure PR_ACT_SUSP_PRP_ROLLOUT (nuInicio number, nuFinal number, nuBD number) AS
/*******************************************************************
 PROGRAMA    	:	PR_ACT_SUSP_PRP_ROLLOUT
 FECHA		:	19/08/2014
 AUTOR		:	OLSoftware
 DESCRIPCION	:	Actualiza la informacion del tipo de suspension por RP
 HISTORIA DE MODIFICACIONES
         AUTOR	                  FECHA	                     DESCRIPCION
OLSoftware - Jennifer Giraldo  19/11/2014  se modifica para tomar la orden maxima de suspension

 *******************************************************************/

   vfecha_ini          DATE;
   vprograma           VARCHAR2 (100);
   verror              VARCHAR2 (2000);
   vcontLec            NUMBER := 0;
   vcontIns            NUMBER := 0;
   nuComplementoPR   number;
   nuComplementoSU   number;
   nuComplementoFA   number;
   nuComplementoCU   number;
   nuComplementoDI  number;
   
	cursor cuProducts is
	SELECT /*+ PARALLEL */
	      B.SESUSUSC CONTRATO_GASPLUS,
              B.SESUNUSE PRODUCTO_GASPLUS,
              B.BASEDATO BASEDATO,
              P.PRODUCT_ID PRODUCTO_OSF,
              C.SUSCIDDI DIRECCION,
              C.SUSCCLIE CLIENTE,
              A.SESUESCO ESTADO_CORTE,
              D.ORTRTITR,
              D.TIPOSUSP,
              D.ORTRFELE
         FROM SERVSUSC A, 
	      LDC_TEMP_SERVSUSC_SGE B, 
	      SUSCRIPC C, 
	      PR_PRODUCT P, 
	      PR_PROD_SUSPENSION S,
          MIGRA.LDC_TEMP_ORDEPRP_SGE D, 
	      LDC_MIG_TIPOTRAB E
        WHERE P.PRODUCT_ID = B.SESUNUSE+nuComplementoPR
          AND P.PRODUCT_ID = S.PRODUCT_ID
          AND A.SESUNUSE = P.PRODUCT_ID
          AND C.SUSCCODI = A.SESUSUSC
          AND P.PRODUCT_STATUS_ID = 2
          AND P.PRODUCT_TYPE_ID = 7014
          --AND S.SUSPENSION_TYPE_ID <> 2
          AND C.SUSCCODI = B.SESUSUSC+nuComplementoSU
          AND A.SESUESCO NOT IN (3,5)
          AND B.SESUSUSC >= nuInicio
		  AND B.SESUSUSC < nuFinal
		  AND B.BASEDATO = nuBD
          AND EXISTS (SELECT 1 FROM MIGRA.LDC_MIG_PARATIPO G
							  WHERE G.PARATITA = D.ORTRTITR
	                            AND G.PARACODI = 'SUSPENSIONES_RP')
          AND D.BASEDATO = E.BASEDATO
          AND D.ORTRTITR = E.ORTRTITR
          AND A.SESUSUSC = D.ORTRSUSC+nuComplementoSU
          AND A.SESUNUSE = D.ORTRNUSE+nuComplementoPR
          AND D.BASEDATO = nuBD;
	       
	   cursor cuOrdenes(nuProd number)  is
	  SELECT /*+ PARALLEL */
	         MAX(A.LEGALIZATION_DATE) FECHA_LEGA 
            FROM OR_ORDER A, OR_ORDER_ACTIVITY B
           WHERE A.ORDER_ID = B.ORDER_ID
             AND EXISTS (SELECT 1 FROM MIGRA.LDC_MIG_PARATIPO G, LDC_MIG_TIPOTRAB C
                                 WHERE G.PARACODI IN ('SUSPENSIONES','SUSPENSIONES_ASO','SUSPENSIONES_RP')
                                   AND G.PARATITA = C.ORTRTITR
                                   AND C.TRABHOMO = A.TASK_TYPE_ID)
             AND B.PRODUCT_ID = nuProd
             AND A.LEGALIZATION_DATE = (SELECT /*+ INDEX(E IDX_OR_ORDER_ACTIVITY_010) */ MAX(D.LEGALIZATION_DATE)
                                          FROM OR_ORDER D, OR_ORDER_ACTIVITY E
                                         WHERE D.ORDER_ID = E.ORDER_ID
                                           AND EXISTS (SELECT 1 FROM MIGRA.LDC_MIG_PARATIPO H, LDC_MIG_TIPOTRAB J
                                                               WHERE H.PARACODI IN ('SUSPENSIONES','SUSPENSIONES_ASO','SUSPENSIONES_RP')
                                                                 AND H.PARATITA = J.ORTRTITR
                                                                 AND J.TRABHOMO = D.TASK_TYPE_ID)
                                           AND E.PRODUCT_ID = nuProd);
          
	rgDatosOrdenes cuOrdenes%rowtype;
  
	-- DECLARACION DE TIPOS.
	--
	TYPE tipo_cu_datos IS TABLE OF cuProducts%ROWTYPE;
     
        -- DECLARACION DE TABLAS TIPOS.
	--
        tbl_datos      tipo_cu_datos := tipo_cu_datos ();

	     nuLogError NUMBER;
	     nuErrores number := 0;
     
Begin
   vprograma := 'PR_ACT_SUSP_PRP_ROLLOUT';
   vfecha_ini := SYSDATE;
      
   -- Inserta registro de inicio en el log
   PKLOG_MIGRACION.prInsLogMigra (502,502,1,'PR_ACT_SUSP_PRP_ROLLOUT',0,0,'Inicia Proceso','INICIO',nuLogError);
   
   UPDATE MIGR_RANGO_PROCESOS set RAPRFEIN = SYSDATE, RAPRTERM = 'P' where RAPRCODI = 502 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
   COMMIT;
   
   PKG_CONSTANTES.COMPLEMENTO(nuBD,nuComplementoPR,nuComplementoSU,nuComplementoFA,nuComplementoCU,nuComplementoDI);
   
   -- Cargar datos

   OPEN cuProducts;

   LOOP
      --
	    -- Borrar tablas 	tbl_datos.
      --
      tbl_datos.delete;

	  FETCH cuProducts
		BULK COLLECT INTO tbl_datos
		LIMIT 10000;

	  FOR nuindice IN 1 .. tbl_datos.COUNT
	LOOP
	        BEGIN
			vcontLec := vcontLec +1;
        
			rgDatosOrdenes := null;

				OPEN cuOrdenes(tbl_datos(NUINDICE).PRODUCTO_OSF);
				FETCH cuOrdenes into rgDatosOrdenes;
				CLOSE cuOrdenes;
				

				IF TRUNC(tbl_datos(NUINDICE).ORTRFELE) >= TRUNC(rgDatosOrdenes.FECHA_LEGA) THEN
				
					BEGIN
						UPDATE PR_PROD_SUSPENSION 
						   SET SUSPENSION_TYPE_ID = tbl_datos(NUINDICE).TIPOSUSP
						 WHERE PRODUCT_ID = tbl_datos(NUINDICE).PRODUCTO_OSF;

					COMMIT;
					
					EXCEPTION
						WHEN OTHERS THEN
						NUERRORES := NUERRORES + 1;
						PKLOG_MIGRACION.prInsLogMigra (502,502,2,'PR_ACT_SUSP_PRP_ROLLOUT',0,0,'Producto : '||tbl_datos(NUINDICE).PRODUCTO_GASPLUS||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
					END;
				
				END IF;
		
		         vcontIns := vcontIns +1;
	          COMMIT;
	     
	        END;
	
	END LOOP;
	  
	  
        EXIT WHEN cuProducts%NOTFOUND;

   END LOOP;

    -- Cierra CURSOR.
   IF (cuProducts%ISOPEN)
   THEN
      --{
      CLOSE cuProducts;
   --}
   END IF;
   
   -- Termina Log
  PKLOG_MIGRACION.prInsLogMigra (502,502,3,'PR_ACT_SUSP_PRP_ROLLOUT',vcontIns,nuErrores,'TERMINO PROCESO #regs: '||vcontIns,'FIN',nuLogError);

  UPDATE MIGR_RANGO_PROCESOS  set RAPRFEFI = SYSDATE, RAPRTERM = 'T' where RAPRCODI = 502 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
   COMMIT;

   EXCEPTION
   WHEN OTHERS THEN
      PKLOG_MIGRACION.prInsLogMigra (502,502,2,'PR_ACT_SUSP_PRP_ROLLOUT',0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);
      
END PR_ACT_SUSP_PRP_ROLLOUT;
/
