CREATE OR REPLACE PROCEDURE PR_MIGRA_MATERIALES_ROLLOUT (nuInicio number, nuFinal number, nuBD number) AS 
/*******************************************************************
 PROGRAMA    	:	PR_MIGRA_MATERIALES_ROLLOUT
 FECHA		:	15/05/2014
 AUTOR		:	OLSoftware
 DESCRIPCION	:	Migra la informacion de las Bodegas a OR_OPE_UNI_ITEM_BALA	
 HISTORIA DE MODIFICACIONES
 AUTOR	   FECHA	       DESCRIPCION
  JGG    19-09-2014  SE MODIFICA AGREGANDO NUEVO CAMPO DE CUPO OCASIONAL
 *******************************************************************/ 

   vcontIns       NUMBER := 0;
   
   -- DECLARACION DE CURSORES. TABLA QUE SE QUIERE BORRAR.
   
   CURSOR cu_datos IS
      SELECT A.*, B.CUADHOMO 
       FROM LDC_TEMP_EXITEBOD_SGE A, LDC_MIG_CUADCONT B
      WHERE A.EIXBBCUA = B.CUADCODI
        AND A.BASEDATO = B.BASEDATO
        AND A.BASEDATO = nuBD;
             
   -- DECLARACION DE TIPOS.

   TYPE tipo_cu_datos IS TABLE OF cu_datos%ROWTYPE;

   -- DECLARACION DE TABLAS TIPOS.

   tbl_datos      tipo_cu_datos := tipo_cu_datos ();
   
   nuLogError NUMBER;
   nuTotalRegs number := 0;
   nuErrores number := 0;
   nuItem number;
   nuCupo number;
   
BEGIN

   -- Inserta registro de inicio en el log
   PKLOG_MIGRACION.prInsLogMigra (1002,1002,1,'MIGRA_BODEGAS',0,0,'Inicia Proceso','INICIO',nuLogError);
   
   UPDATE MIGR_RANGO_PROCESOS SET RAPRFEIN = SYSDATE, RAPRTERM = 'P' WHERE RAPRCODI = 1002 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
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

	 /*Se debe desactivar el trigger para poder actualizar o insertar en OR_OPE_UNI_ITEM_BALA*/
        --EXECUTE IMMEDIATE 'ALTER TRIGGER OPEN.TRG_AUROR_OPE_UNI_ITEM_BALA DISABLE';
	    
            nuItem := FNUGETITEMOSF_ROLLOUT(TBL_DATOS(NUINDICE).EIXBITEM,TBL_DATOS(NUINDICE).BASEDATO);
	    
	    nuCupo := 0;
            
            IF nuItem <> 0 then
                
                -- Si ya eixiste la relacion entre el Item y la UO, se actualiza el saldo, el costo y el cupo
                IF (DAOR_ope_uni_item_bala.fblexist(nuItem, TBL_DATOS(NUINDICE).CUADHOMO)) THEN

                    ------------------------
                    BEGIN
                        SELECT quota
                        INTO nuCupo
                        FROM or_ope_uni_item_bala
                        WHERE operating_unit_id = TBL_DATOS(NUINDICE).CUADHOMO
                        AND  items_id = nuItem;
                        EXCEPTION
                            when others then
                                nuCupo := 0;
                    END;
                    ------------------------
                    -- Se valida para obtener el mayor cupo
                    IF TBL_DATOS(NUINDICE).EIXBCUPO > nuCupo THEN
                       nuCupo := TBL_DATOS(NUINDICE).EIXBCUPO;
                    END IF;

                    UPDATE or_ope_uni_item_bala
                        SET balance = balance + TBL_DATOS(NUINDICE).EIXBDISU, --EIXBEXIS,
                            TOTAL_COSTS = TOTAL_COSTS + TBL_DATOS(NUINDICE).EIXBVLOR,
                            quota = nuCupo,
                            occacional_quota = TBL_DATOS(NUINDICE).EIXBCUOC
                        WHERE operating_unit_id = TBL_DATOS(NUINDICE).CUADHOMO
                        AND  items_id = nuItem;
                ELSE
			/*INSERT INTO OR_OPE_UNI_ITEM_BALA (ITEMS_ID, OPERATING_UNIT_ID, QUOTA, BALANCE,
			TOTAL_COSTS, OCCACIONAL_QUOTA,TRANSIT_IN, TRANSIT_OUT)
			VALUES (nuItem, TBL_DATOS(NUINDICE).CUADHOMO, TBL_DATOS(NUINDICE).EIXBCUPO,
			TBL_DATOS(NUINDICE).EIXBDISU, TBL_DATOS(NUINDICE).EIXBVLOR,0,0,0); 26082014 de acuerdo a lo informado por pablo de la peña se debe realiza primero un insert con valor 0 y luego se debe realizar update con el valor de los saldos*/
                           
			INSERT INTO OR_OPE_UNI_ITEM_BALA (ITEMS_ID,OPERATING_UNIT_ID,QUOTA,BALANCE,
                                                        TOTAL_COSTS,OCCACIONAL_QUOTA,TRANSIT_IN,TRANSIT_OUT)
                        VALUES (nuItem,TBL_DATOS(NUINDICE).CUADHOMO,0,0,0,0,0,0);
			
			
			        ------------------------
		                    BEGIN
		                        SELECT quota
		                        INTO nuCupo
		                        FROM or_ope_uni_item_bala
		                        WHERE operating_unit_id = TBL_DATOS(NUINDICE).CUADHOMO
		                        AND  items_id = nuItem;
		                        EXCEPTION
		                            when others then
		                                nuCupo := 0;
		                    END;
                                ------------------------
		                    -- Se valida para obtener el mayor cupo
		                    IF TBL_DATOS(NUINDICE).EIXBCUPO > nuCupo THEN
		                       nuCupo := TBL_DATOS(NUINDICE).EIXBCUPO;
		                    END IF;
		    
		    
                         
			UPDATE OR_OPE_UNI_ITEM_BALA
			SET BALANCE = BALANCE + TBL_DATOS(NUINDICE).EIXBDISU,
                            TOTAL_COSTS = TOTAL_COSTS + TBL_DATOS(NUINDICE).EIXBVLOR,
                            QUOTA = nuCupo,
                            occacional_quota = TBL_DATOS(NUINDICE).EIXBCUOC
			WHERE OPERATING_UNIT_ID = TBL_DATOS(NUINDICE).CUADHOMO
			AND ITEMS_ID = nuItem;
               
                END IF;

                COMMIT;
                 vcontIns := vcontIns + 1;   
             END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               PKLOG_MIGRACION.PRINSLOGMIGRA ( 1002,1002,2,'MIGRA_BODEGAS: '||NUITEM,0,0,'Bodega: '||TBL_DATOS ( NUINDICE).CUADHOMO||' Code Error: '||SQLERRM,TO_CHAR(SQLCODE),NULOGERROR);
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
   PKLOG_MIGRACION.prInsLogMigra ( 1002,1002,3,'MIGRA_BODEGAS',nuTotalRegs,nuErrores,'TERMINO PROCESO #regs: '||vcontIns,'FIN',nuLogError);
   
   UPDATE MIGR_RANGO_PROCESOS SET RAPRFEFI = SYSDATE, RAPRTERM = 'T' where RAPRCODI = 1002 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
   COMMIT;

EXCEPTION
   WHEN OTHERS
   THEN
  
     PKLOG_MIGRACION.prInsLogMigra ( 1002,1002,2,'MIGRA_BODEGAS '||vcontIns,0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);
     
END PR_MIGRA_MATERIALES_ROLLOUT; 
/
