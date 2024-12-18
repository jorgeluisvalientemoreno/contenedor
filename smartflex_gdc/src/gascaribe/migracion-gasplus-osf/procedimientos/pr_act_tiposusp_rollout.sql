CREATE OR REPLACE procedure PR_ACT_TIPOSUSP_ROLLOUT (nuInicio number, nuFinal number, nuBD number) AS
/*******************************************************************
 PROGRAMA    	:	PR_ACT_TIPOSUSP_ROLLOUT
 FECHA		:	08/10/2014
 AUTOR		:	OLSoftware - Jennifer Giraldo
 DESCRIPCION	:	Actualiza la informacion del tipo de suspension por cartera
 HISTORIA DE MODIFICACIONES
         AUTOR	                  FECHA	                     DESCRIPCION
OLSoftware - Jennifer Giraldo  19/11/2014  se modifica para tomar la orden maxima de suspension
 *******************************************************************/

   vfecha_ini          DATE;
   vprograma           VARCHAR2 (100);
   verror              VARCHAR2 (2000);
   vcontLec            NUMBER := 0;
   vcontIns            NUMBER := 0;
   nuComplementoPR     NUMBER;
   nuComplementoSU     NUMBER;
   nuComplementoFA     NUMBER;
   nuComplementoCU     NUMBER;
   nuComplementoDI     NUMBER;
   
   cursor cuProducts is
	SELECT A.SESUNUSE PRODUCTO
	  FROM SERVSUSC A, PR_PROD_SUSPENSION B
	 WHERE A.SESUNUSE = B.PRODUCT_ID
	   AND A.SESUSERV = 7014; -- 14030  Filas 14033  Filas

   cursor cuTiposusp (nuPROD number) is
	SELECT /*+ PARALLEL */ 
		C.ORTRSUSC,
		C.ORTRTITR,
		C.ORTRFELE,
		C.TIPOSUSP         
	  FROM LDC_TEMP_ORDETRAB_SGE C, LDC_MIG_TIPOTRAB D
	 WHERE C.BASEDATO = nuBD
	   AND C.ORTRNUSE = nuPROD - nuComplementoPR
	   AND EXISTS (SELECT 1 FROM MIGRA.LDC_MIG_PARATIPO G
	                       WHERE G.PARATITA = C.ORTRTITR
	                         AND G.PARACODI IN ('SUSPENSIONES','SUSPENSIONES_ASO'))
	   AND C.BASEDATO = D.BASEDATO
	   AND C.ORTRTITR = D.ORTRTITR
	   AND C.TIPOSUSP IS NOT NULL
	   AND C.ORTRFELE = (SELECT MAX(W.ORTRFELE)
			       FROM LDC_TEMP_ORDETRAB_SGE W
	                      WHERE EXISTS (SELECT 1 FROM MIGRA.LDC_MIG_PARATIPO X
	                                            WHERE X.PARATITA = W.ORTRTITR
	                                              AND X.PARACODI IN ('SUSPENSIONES','SUSPENSIONES_ASO'))
				AND W.ORTRNUSE = nuPROD - nuComplementoPR
				AND W.BASEDATO = nuBD
				AND W.TIPOSUSP IS NOT NULL);

	rgTiposusp   cuTiposusp%rowtype;			

	-- DECLARACION DE TIPOS.
	--
	TYPE tipo_cu_datos IS TABLE OF cuProducts%ROWTYPE;
     
        -- DECLARACION DE TABLAS TIPOS.
	--
        tbl_datos      tipo_cu_datos := tipo_cu_datos ();

	     nuLogError NUMBER;
	     nuErrores number := 0;
       sw       number;
     
Begin
   vprograma := 'PR_ACT_TIPOSUSP_ROLLOUT';
   vfecha_ini := SYSDATE;
      
   -- Inserta registro de inicio en el log
   PKLOG_MIGRACION.prInsLogMigra (511,511,1,'PR_ACT_TIPOSUSP_ROLLOUT',0,0,'Inicia Proceso','INICIO',nuLogError);
   
   UPDATE MIGR_RANGO_PROCESOS SET RAPRFEIN = SYSDATE, RAPRTERM = 'P' WHERE RAPRCODI = 511 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
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
      
      
      
		rgTiposusp:= null;
			  
		sw := 0;

			open cuTiposusp(tbl_datos(NUINDICE).PRODUCTO);
			fetch cuTiposusp into rgTiposusp;
	        
			IF cuTiposusp%FOUND THEN
			sw := 1;
			END IF;
	          
			close cuTiposusp;
	        
				IF sw = 1 then
			
				        BEGIN
						  vcontLec := vcontLec +1;
							  
							BEGIN
								UPDATE PR_PROD_SUSPENSION 
								SET SUSPENSION_TYPE_ID = rgTiposusp.TIPOSUSP
								WHERE PRODUCT_ID = tbl_datos(NUINDICE).PRODUCTO;

							COMMIT;
							EXCEPTION
								WHEN OTHERS THEN
								NUERRORES := NUERRORES + 1;
								PKLOG_MIGRACION.prInsLogMigra (511,511,2,'PR_ACT_TIPOSUSP_ROLLOUT',0,0,'Producto : '||tbl_datos(NUINDICE).PRODUCTO||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
							END;
					
					         vcontIns := vcontIns +1;
				          COMMIT;
				     
				        END;
				END IF;
	
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
  PKLOG_MIGRACION.prInsLogMigra (511,511,3,'PR_ACT_TIPOSUSP_ROLLOUT',vcontIns,nuErrores,'TERMINO PROCESO #regs: '||vcontIns,'FIN',nuLogError);

  UPDATE MIGR_RANGO_PROCESOS  set RAPRFEFI = SYSDATE, RAPRTERM = 'T' where RAPRCODI = 511 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
   COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      PKLOG_MIGRACION.prInsLogMigra (511,511,2,'PR_ACT_TIPOSUSP_ROLLOUT',0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);
      
END PR_ACT_TIPOSUSP_ROLLOUT; 
/
