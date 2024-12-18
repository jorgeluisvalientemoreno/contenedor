CREATE OR REPLACE procedure PR_ACTGE_ITEMS_ROLLOUT (nuInicio number, nuFinal number, nuBD number) AS
/*******************************************************************
 PROGRAMA    	:	PR_ACTGE_ITEMS_ROLLOUT
 FECHA		:	18/12/2014
 AUTOR		:	OLSoftware
 DESCRIPCION	:	Actualiza la informacion de la clasificacion y tipo item a los items de medidores
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
      SELECT ITEMS_ID FROM GE_ITEMS
			WHERE ITEMS_ID IN (10004070,10004071,10000593,10000595,10001230,10001233,10001234,
					   10001300,10001666,10001683,10002011,10002017,10002106,10003538,
					   10003862,10003883,10004144,10004145,10004146,10004149,10005187,
					   10005189,10005313,10006391);

	       	   
	-- DECLARACION DE TIPOS.
	--
	TYPE tipo_cu_datos IS TABLE OF cuGeitems%ROWTYPE;
     
        -- DECLARACION DE TABLAS TIPOS.
	--
        tbl_datos      tipo_cu_datos := tipo_cu_datos ();

	     nuLogError NUMBER;
	     nuErrores number := 0;
     
Begin
   vprograma := 'PR_ACTGE_ITEMS_ROLLOUT';
   vfecha_ini := SYSDATE;
      
   -- Inserta registro de inicio en el log
   PKLOG_MIGRACION.prInsLogMigra (517,517,1,'PR_ACTGE_ITEMS_ROLLOUT',0,0,'Inicia Proceso','INICIO',nuLogError);
   
   UPDATE MIGR_RANGO_PROCESOS SET RAPRFEIN = SYSDATE, RAPRTERM = 'P' where RAPRCODI = 517 AND RAPRBASE = nuBD;
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
						UPDATE GE_ITEMS
						SET ITEM_CLASSIF_ID = 21 , ID_ITEMS_TIPO = 20
						WHERE ITEMS_ID = tbl_datos(NUINDICE).ITEMS_ID;

						COMMIT;
							EXCEPTION
								WHEN OTHERS THEN
								NUERRORES := NUERRORES + 1;
								PKLOG_MIGRACION.prInsLogMigra (517,517,2,'PR_ACTGE_ITEMS_ROLLOUT',0,0,'Producto : '||tbl_datos(NUINDICE).ITEMS_ID||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
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
  PKLOG_MIGRACION.prInsLogMigra (517,517,3,'PR_ACTGE_ITEMS_ROLLOUT',vcontIns,nuErrores,'TERMINO PROCESO #regs: '||vcontIns,'FIN',nuLogError);

  UPDATE MIGR_RANGO_PROCESOS  set RAPRFEFI = SYSDATE, RAPRTERM = 'T' where RAPRCODI = 517 AND RAPRBASE = nuBD;
   COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      PKLOG_MIGRACION.prInsLogMigra (517,517,2,'PR_ACTGE_ITEMS_ROLLOUT',0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);
      
END PR_ACTGE_ITEMS_ROLLOUT; 
/
