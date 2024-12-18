CREATE OR REPLACE procedure MOSUSPENSION_ROLLOUT (nuInicio number, nuFinal number, nuBD number) AS
/*******************************************************************
 PROGRAMA    	:	PR_MOSUSPENSION_ROLLOUT
 FECHA		:	26/11/2014
 AUTOR		:	OLSoftware
 DESCRIPCION	:	Inserta la inforamción de los productos suspendidos en MO_SUSPENSION
 HISTORIA DE MODIFICACIONES
 AUTOR	   FECHA	DESCRIPCION

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
   
	   CURSOR cuSuspension is
	        SELECT B.MOTIVE_ID MOTIVO, 
		       A.SUSPENSION_TYPE_ID TIPO_SUSP, 
		       A.PRODUCT_ID PRODUCTO
		  FROM PR_PROD_SUSPENSION A, MO_MOTIVE B
                 WHERE A.PRODUCT_ID = B.SERVICE_NUMBER
		   AND B.PRODUCT_MOTIVE_ID = 100005;
	       	   
	-- DECLARACION DE TIPOS.
	--
	TYPE tipo_cu_datos IS TABLE OF cuSuspension%ROWTYPE;
     
        -- DECLARACION DE TABLAS TIPOS.
	--
        tbl_datos      tipo_cu_datos := tipo_cu_datos ();

	     nuLogError NUMBER;
	     nuErrores number := 0;
     
Begin
   vprograma := 'PR_MOSUSPENSION_ROLLOUT';
   vfecha_ini := SYSDATE;
      
   -- Inserta registro de inicio en el log
   PKLOG_MIGRACION.prInsLogMigra (515,515,1,'PR_MOSUSPENSION_ROLLOUT',0,0,'Inicia Proceso','INICIO',nuLogError);
   
   UPDATE MIGR_RANGO_PROCESOS SET RAPRFEIN = SYSDATE, RAPRTERM = 'P' WHERE RAPRCODI = 515 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
   COMMIT;
   
   PKG_CONSTANTES.COMPLEMENTO(nuBD,nuComplementoPR,nuComplementoSU,nuComplementoFA,nuComplementoCU,nuComplementoDI);
   
   -- Cargar datos

   OPEN cuSuspension;

   LOOP
      --
	    -- Borrar tablas 	tbl_datos.
      --
      tbl_datos.delete;

	  FETCH cuSuspension
	  BULK COLLECT INTO tbl_datos
	  LIMIT 10000;

	  FOR nuindice IN 1 .. tbl_datos.COUNT
		LOOP
			BEGIN
			
				vcontLec := vcontLec +1;
				  
				BEGIN
					INSERT INTO MO_SUSPENSION (MOTIVE_ID, SUSPENSION_TYPE_ID, REGISTER_DATE, APLICATION_DATE, ENDING_DATE, CONNECTION_CODE)
					VALUES (TBL_DATOS(NUINDICE).MOTIVO,TBL_DATOS(NUINDICE).TIPO_SUSP,SYSDATE,SYSDATE,Null,Null);
						EXCEPTION
				                  WHEN OTHERS  THEN
				                  BEGIN
				                     verror := 'Error Paso 1: '||TBL_DATOS (NUINDICE).PRODUCTO|| ' - ' ||SQLCODE ||' -'|| SQLERRM;
				                     nuErrores := nuErrores + 1;
				                  PKLOG_MIGRACION.prInsLogMigra (515,515,2,'PR_MOSUSPENSION_ROLLOUT',0,0,'Error: '||verror,to_char(sqlcode),nuLogError);
				                END;
				END;
			        COMMIT;
              
			END;
	
		END LOOP;
	  
      EXIT WHEN cuSuspension%NOTFOUND;

   END LOOP;

    -- Cierra CURSOR.
   IF (cuSuspension%ISOPEN)
   THEN
      --{
      CLOSE cuSuspension;
   --}
   END IF;
   
   -- Termina Log
  PKLOG_MIGRACION.prInsLogMigra (515,515,3,'PR_MOSUSPENSION_ROLLOUT',vcontIns,nuErrores,'TERMINO PROCESO #regs: '||vcontIns,'FIN',nuLogError);

   UPDATE MIGR_RANGO_PROCESOS SET RAPRFEFI = SYSDATE, RAPRTERM = 'T' WHERE RAPRCODI = 515 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
   COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      PKLOG_MIGRACION.prInsLogMigra (515,515,2,'PR_MOSUSPENSION_ROLLOUT',0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);
      
END MOSUSPENSION_ROLLOUT; 
/
