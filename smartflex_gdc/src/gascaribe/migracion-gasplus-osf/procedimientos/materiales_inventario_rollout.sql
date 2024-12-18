CREATE OR REPLACE PROCEDURE MATERIALES_INVENTARIO_ROLLOUT (nuInicio number, nuFinal number, nuBD number) AS 
/*******************************************************************
 PROGRAMA    	:	MATERIALES_INVENTARIO_ROLLOUT
 FECHA		:	25/11/2014
 AUTOR		:	OLSoftware
 DESCRIPCION	:	Migra la informacion de los materiales de tipo inventario a LDC_ACT_OUIB
 HISTORIA DE MODIFICACIONES
 AUTOR	   FECHA	       DESCRIPCION
 *******************************************************************/ 

   vcontIns       NUMBER := 0;
   
   -- DECLARACION DE CURSORES. TABLA QUE SE QUIERE BORRAR.
   
   CURSOR cu_datos IS
      SELECT A.*, B.CUADHOMO 
       FROM LDC_TEMP_EXITEBOD_SGE A, LDC_MIG_CUADCONT B
      WHERE A.EIXBBCUA = B.CUADCODI
        AND A.BASEDATO = B.BASEDATO
        AND A.BASEDATO = nuBD
        AND A.EIXBTIPO = 'I';
    
  
   CURSOR CUBODE  (coItem number, coCuad number) IS 
     SELECT COUNT(*)
       FROM LDC_INV_OUIB
      WHERE OPERATING_UNIT_ID = coCuad
        AND ITEMS_ID = coItem;
             
   -- DECLARACION DE TIPOS.

   TYPE tipo_cu_datos IS TABLE OF cu_datos%ROWTYPE;

   -- DECLARACION DE TABLAS TIPOS.

   tbl_datos      tipo_cu_datos := tipo_cu_datos ();
   
   nuLogError NUMBER;
   nuTotalRegs number := 0;
   nuErrores number := 0;
   nuItem number;
   nuCupo number;
   nuCantidad number := 0;
   
BEGIN

   -- Inserta registro de inicio en el log
   PKLOG_MIGRACION.prInsLogMigra (1004,1004,1,'MIGRA_INVENTARIO',0,0,'Inicia Proceso','INICIO',nuLogError);
   
   UPDATE MIGR_RANGO_PROCESOS SET RAPRFEIN = SYSDATE, RAPRTERM = 'P' WHERE RAPRCODI = 1004 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
   COMMIT;

   -- SI APLICA, CREAR TABLA DE DATOS QUE NO SE BORRAN
   -- Abre CURSOR.
   OPEN cu_datos;

   LOOP

      -- Borrar tablas PL.

      tbl_datos.delete;

      -- Cargar registros.

      FETCH cu_datos
      BULK COLLECT INTO tbl_datos
      LIMIT 1000;

      FOR nuindice IN 1 .. tbl_datos.COUNT
      LOOP
         Begin

	    
            nuItem := FNUGETITEMOSF_ROLLOUT(TBL_DATOS(NUINDICE).EIXBITEM,TBL_DATOS(NUINDICE).BASEDATO);

	    nuCupo := 0;
            
            IF nuItem <> 0 then
            
            open CUBODE(nuItem, TBL_DATOS(NUINDICE).CUADHOMO);
            fetch CUBODE into nuCantidad;
            close CUBODE;
                
                -- Si ya eixiste la relacion entre el Item y la UO, se actualiza el saldo, el costo y el cupo
                IF (nuCantidad >=1) then
                --IF (DAOR_OPE_UNI_ITEM_BALA.FBLEXIST(nuItem, TBL_DATOS(NUINDICE).CUADHOMO)) THEN

                    ------------------------
                    BEGIN
                        SELECT QUOTA
                        INTO nuCupo
                        FROM LDC_INV_OUIB
                        WHERE OPERATING_UNIT_ID = TBL_DATOS(NUINDICE).CUADHOMO
                        AND  ITEMS_ID = nuItem;
                        EXCEPTION
                            WHEN OTHERS THEN
                                nuCupo := 0;
                        END;
                    ------------------------
                    -- Se valida para obtener el mayor cupo
                    IF TBL_DATOS(NUINDICE).EIXBCUPO > nuCupo THEN
                       nuCupo := TBL_DATOS(NUINDICE).EIXBCUPO;
                    END IF;

                    UPDATE LDC_INV_OUIB
                        SET BALANCE = BALANCE + TBL_DATOS(NUINDICE).EIXBDISU, --EIXBEXIS,
                            TOTAL_COSTS = TOTAL_COSTS + TBL_DATOS(NUINDICE).EIXBVLOR,
                            QUOTA = nuCupo,
                            OCCACIONAL_QUOTA = TBL_DATOS(NUINDICE).EIXBCUOC
                        WHERE OPERATING_UNIT_ID = TBL_DATOS(NUINDICE).CUADHOMO
                        AND  ITEMS_ID = nuItem;
                
                -- Si NO eixiste la relacion entre el Item y la UO, se inserta el saldo, el costo y el cupo        
                ELSE
		
                        INSERT INTO LDC_INV_OUIB (ITEMS_ID,OPERATING_UNIT_ID,QUOTA,BALANCE,TOTAL_COSTS,OCCACIONAL_QUOTA,TRANSIT_IN,TRANSIT_OUT)
                        VALUES (nuItem,TBL_DATOS(NUINDICE).CUADHOMO,0,0,0,0,0,0);
			
			
			        ------------------------
		                    BEGIN
		                        SELECT QUOTA
		                        INTO nuCupo
		                        FROM LDC_INV_OUIB
		                        WHERE OPERATING_UNIT_ID = TBL_DATOS(NUINDICE).CUADHOMO
		                        AND  ITEMS_ID = nuItem;
		                        EXCEPTION
		                            WHEN OTHERS THEN
		                                nuCupo := 0;
		                    END;
              ------------------------
		                    -- Se valida para obtener el mayor cupo
		                    IF TBL_DATOS(NUINDICE).EIXBCUPO > nuCupo THEN
		                       nuCupo := TBL_DATOS(NUINDICE).EIXBCUPO;
		                    END IF;
		    
		    
                         
			UPDATE LDC_INV_OUIB
			SET BALANCE = BALANCE + TBL_DATOS(NUINDICE).EIXBDISU,
                            TOTAL_COSTS = TOTAL_COSTS + TBL_DATOS(NUINDICE).EIXBVLOR,
                            QUOTA = nuCupo,
                            OCCACIONAL_QUOTA = TBL_DATOS(NUINDICE).EIXBCUOC
			WHERE OPERATING_UNIT_ID = TBL_DATOS(NUINDICE).CUADHOMO
			AND ITEMS_ID = nuItem;
               
                END IF;

                COMMIT;
                 vcontIns := vcontIns + 1;   
             END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               PKLOG_MIGRACION.PRINSLOGMIGRA (1004,1004,2,'MIGRA_INVENTARIO: '||NUITEM,0,0,'Bodega: '||TBL_DATOS ( NUINDICE).CUADHOMO||' Code Error: '||SQLERRM,TO_CHAR(SQLCODE),NULOGERROR);
	  END;
         
      END LOOP;

      EXIT WHEN cu_datos%NOTFOUND;

      COMMIT;
   END LOOP;

   -- Cierra CURSOR.
   IF (cu_datos%ISOPEN) THEN
      CLOSE cu_datos;
   END IF; 

    -- Termina Log
   PKLOG_MIGRACION.prInsLogMigra (1004,1004,3,'MIGRA_INVENTARIO',nuTotalRegs,nuErrores,'TERMINO PROCESO #regs: '||vcontIns,'FIN',nuLogError);
   
   UPDATE MIGR_RANGO_PROCESOS SET RAPRFEFI = SYSDATE, RAPRTERM = 'T' where RAPRCODI = 1004 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
   COMMIT;

EXCEPTION
   WHEN OTHERS
   THEN
  
     PKLOG_MIGRACION.prInsLogMigra (1004,1004,2,'MIGRA_INVENTARIO '||vcontIns,0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);
     
END MATERIALES_INVENTARIO_ROLLOUT; 
/
