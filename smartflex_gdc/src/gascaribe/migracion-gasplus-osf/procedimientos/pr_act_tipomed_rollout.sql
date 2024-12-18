CREATE OR REPLACE procedure PR_ACT_TIPOMED_ROLLOUT (nuInicio number, nuFinal number, nuBD number) AS
/*******************************************************************
 PROGRAMA    	:	PR_ACT_TIPOMED_ROLLOUT
 FECHA		:	20/08/2014
 AUTOR		:	OLSoftware
 DESCRIPCION	:	Actualiza la informacion del tipo de medidor en GE_ITEMS_SERIADO
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
   
	   CURSOR cuGeitems is
		SELECT A.ITEMS_ID ITEMOSF, 
		       A.NUMERO_SERVICIO, 
		       B.ITEMS_ID ITEMHOMO, 
		       B.PRODUCTO+nuComplementoPR PRODUCTO 
		  FROM GE_ITEMS_SERIADO A, LDC_MIG_TIPOITEM B
		 WHERE A.ITEMS_ID = 4001229
		   AND A.NUMERO_SERVICIO = B.PRODUCTO+nuComplementoPR
		   AND B.BASEDATO = nuBD; --988389  Filas
	       	   
	-- DECLARACION DE TIPOS.
	--
	TYPE tipo_cu_datos IS TABLE OF cuGeitems%ROWTYPE;
     
        -- DECLARACION DE TABLAS TIPOS.
	--
        tbl_datos      tipo_cu_datos := tipo_cu_datos ();

	     nuLogError NUMBER;
	     nuErrores number := 0;
     
Begin
   vprograma := 'PR_ACT_TIPOMED_ROLLOUT';
   vfecha_ini := SYSDATE;
      
   -- Inserta registro de inicio en el log
   PKLOG_MIGRACION.prInsLogMigra (504,504,1,'PR_ACT_TIPOMED_ROLLOUT',0,0,'Inicia Proceso','INICIO',nuLogError);
   
   UPDATE MIGR_RANGO_PROCESOS set RAPRFEIN = SYSDATE, RAPRTERM = 'P' where RAPRCODI = 504 AND RAPRBASE = nuBD;
   COMMIT;
   
   PKG_CONSTANTES.COMPLEMENTO(nuBD,nuComplementoPR,nuComplementoSU,nuComplementoFA,nuComplementoCU,nuComplementoDI);
   
   -- Cargar datos

   OPEN cuGeitems;

   LOOP
      --
	    -- Borrar tablas 	tbl_datos.
      --
      tbl_datos.delete;

	  FETCH cuGeitems
	  BULK COLLECT INTO tbl_datos
	  LIMIT 10000;

	  FOR nuindice IN 1 .. tbl_datos.COUNT
		LOOP
			BEGIN
				vcontLec := vcontLec +1;
				  
					BEGIN
						UPDATE GE_ITEMS_SERIADO 
						SET ITEMS_ID = tbl_datos(NUINDICE).ITEMHOMO
						WHERE NUMERO_SERVICIO = tbl_datos(NUINDICE).PRODUCTO;

						COMMIT;
							EXCEPTION
								WHEN OTHERS THEN
								NUERRORES := NUERRORES + 1;
								PKLOG_MIGRACION.prInsLogMigra (504,504,2,'PR_ACT_TIPOMED_ROLLOUT',0,0,'Producto : '||tbl_datos(NUINDICE).PRODUCTO||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
							END;
		
						vcontIns := vcontIns +1;
						COMMIT;
	     
					END;
	
		END LOOP;
	  
      EXIT WHEN cuGeitems%NOTFOUND;

   END LOOP;

    -- Cierra CURSOR.
   IF (cuGeitems%ISOPEN)
   THEN
      --{
      CLOSE cuGeitems;
   --}
   END IF;
   
   -- Termina Log
  PKLOG_MIGRACION.prInsLogMigra (504,504,3,'PR_ACT_TIPOMED_ROLLOUT',vcontIns,nuErrores,'TERMINO PROCESO #regs: '||vcontIns,'FIN',nuLogError);

  UPDATE MIGR_RANGO_PROCESOS  set RAPRFEFI = SYSDATE, RAPRTERM = 'T' where RAPRCODI = 504 AND RAPRBASE = nuBD;
   COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      PKLOG_MIGRACION.prInsLogMigra (504,504,2,'PR_ACT_TIPOMED_ROLLOUT',0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);
      
END PR_ACT_TIPOMED_ROLLOUT; 
/
