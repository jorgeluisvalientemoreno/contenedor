CREATE OR REPLACE procedure PR_ACT_ESTACORT_ROLLOUT (nuInicio number, nuFinal number, nuBD number) AS
/*******************************************************************
 PROGRAMA    	:	PR_ACT_ESTACORT_ROLLOUT
 FECHA		:	15/12/2014
 AUTOR		:	OLSoftware
 DESCRIPCION	:	Actualiza la informacion del estado de corte para los productos que en gasplus tiene estado tecnico 32 y 
			como ultima activdiad de suspension un 1051
 HISTORIA DE MODIFICACIONES
         AUTOR	                  FECHA	                     DESCRIPCION

 *******************************************************************/

   vfecha_ini        DATE;
   vprograma         VARCHAR2 (100);
   verror            VARCHAR2 (2000);
   vcontLec          NUMBER := 0;
   vcontIns          NUMBER := 0;
   nuComplementoPR   NUMBER;
   nuComplementoSU   NUMBER;
   nuComplementoFA   NUMBER;
   nuComplementoCU   NUMBER;
   nuComplementoDI   NUMBER;
   
	cursor cuProducts is
	  SELECT /*+ PARALLEL */
		A.SESUNUSE+nuComplementoPR PRODUCTO_OSF,
		3 ESTADO_CORTE,
		B.ORTRTITR,
		B.TIPOSUSP,
		B.ORTRFELE 
	   FROM LDC_TEMP_SERVSUSC_SGE A, LDC_TEMP_ORDETRAB_SGE B
	  WHERE A.SESUNUSE = B.ORTRNUSE
	    AND A.SESUESTE = 32
	    AND B.ORTRTITR = 5
	    AND A.SESUSUSC >= nuInicio
	    AND A.SESUSUSC < nuFinal
	    AND A.BASEDATO = nuBD;
	
	cursor cuProducts2 is
	  SELECT /*+ PARALLEL */
		A.SESUNUSE+nuComplementoPR PRODUCTO_OSF,
		2 ESTADO_PROD,
		B.ORTRTITR,
		B.TIPOSUSP,
		B.ORTRFELE 
	   FROM LDC_TEMP_SERVSUSC_SGE A, LDC_TEMP_ORDETRAB_SGE B
	  WHERE A.SESUNUSE = B.ORTRNUSE
	    AND A.SESUESTE = 32
	    AND B.ORTRTITR = 1335
	    AND A.SESUSUSC >= nuInicio
	    AND A.SESUSUSC < nuFinal
	    AND A.BASEDATO = nuBD;
	       
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
             AND A.LEGALIZATION_DATE = (SELECT MAX(D.LEGALIZATION_DATE)
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
	TYPE tipo_cu_datos2 IS TABLE OF cuProducts2%ROWTYPE;
     
        -- DECLARACION DE TABLAS TIPOS.
	--
        tbl_datos      tipo_cu_datos := tipo_cu_datos ();
	tbl_datos2     tipo_cu_datos2 := tipo_cu_datos2 ();

	     nuLogError NUMBER;
	     nuErrores number := 0;
     
Begin
   vprograma := 'PR_ACT_ESTACORT_ROLLOUT';
   vfecha_ini := SYSDATE;
      
   -- Inserta registro de inicio en el log
   PKLOG_MIGRACION.prInsLogMigra (516,516,1,'PR_ACT_ESTACORT_ROLLOUT',0,0,'Inicia Proceso','INICIO',nuLogError);
   
   UPDATE MIGR_RANGO_PROCESOS set RAPRFEIN = SYSDATE, RAPRTERM = 'P' where RAPRCODI = 516 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
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
						UPDATE SERVSUSC 
						   SET SESUESCO = TBL_DATOS(NUINDICE).ESTADO_CORTE
						 WHERE SESUNUSE = TBL_DATOS(NUINDICE).PRODUCTO_OSF;

					COMMIT;
					
					EXCEPTION
						WHEN OTHERS THEN
						NUERRORES := NUERRORES + 1;
						PKLOG_MIGRACION.prInsLogMigra (516,516,2,'PR_ACT_ESTACORT_ROLLOUT',0,0,'Producto : '||tbl_datos(NUINDICE).PRODUCTO_OSF||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
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
   

      OPEN cuProducts2;

   LOOP
      --
	    -- Borrar tablas 	tbl_datos2.
      --
      tbl_datos2.delete;

	  FETCH cuProducts2
		BULK COLLECT INTO tbl_datos2
		LIMIT 10000;

	  FOR nuindice IN 1 .. tbl_datos2.COUNT
	LOOP
	        BEGIN
			vcontLec := vcontLec +1;
        
			rgDatosOrdenes := null;

				OPEN cuOrdenes(TBL_DATOS2(NUINDICE).PRODUCTO_OSF);
				FETCH cuOrdenes into rgDatosOrdenes;
				CLOSE cuOrdenes;
				

				IF TRUNC(TBL_DATOS2(NUINDICE).ORTRFELE) >= TRUNC(rgDatosOrdenes.FECHA_LEGA) THEN
				
					BEGIN
						UPDATE PR_PRODUCT 
						   SET PRODUCT_STATUS_ID = TBL_DATOS2(NUINDICE).ESTADO_PROD
						 WHERE PRODUCT_ID = TBL_DATOS2(NUINDICE).PRODUCTO_OSF;

					COMMIT;
					
					EXCEPTION
						WHEN OTHERS THEN
						NUERRORES := NUERRORES + 1;
						PKLOG_MIGRACION.prInsLogMigra (516,516,2,'PR_ACT_ESTACORT_ROLLOUT',0,0,'Producto : '||tbl_datos(NUINDICE).PRODUCTO_OSF||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
					END;
				
				END IF;
		
		         vcontIns := vcontIns +1;
	          COMMIT;
	     
	        END;
	
	END LOOP;
	  
	  
        EXIT WHEN cuProducts2%NOTFOUND;

   END LOOP;

    -- Cierra CURSOR.
   IF (cuProducts2%ISOPEN)
   THEN
      --{
      CLOSE cuProducts2;
   --}
   END IF;
   
   -- Termina Log
  PKLOG_MIGRACION.prInsLogMigra (516,516,3,'PR_ACT_ESTACORT_ROLLOUT',vcontIns,nuErrores,'TERMINO PROCESO #regs: '||vcontIns,'FIN',nuLogError);

  UPDATE MIGR_RANGO_PROCESOS SET RAPRFEFI = SYSDATE, RAPRTERM = 'T' where RAPRCODI = 516 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
   COMMIT;

   EXCEPTION
   WHEN OTHERS THEN
      PKLOG_MIGRACION.prInsLogMigra (516,516,2,'PR_ACT_ESTACORT_ROLLOUT',0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);
      
END PR_ACT_ESTACORT_ROLLOUT; 
/
