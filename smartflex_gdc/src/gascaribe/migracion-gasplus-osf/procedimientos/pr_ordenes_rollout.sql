CREATE OR REPLACE PROCEDURE PR_ORDENES_ROLLOUT (nuInicio number, nuFinal number, nuBD number) AS 
/*******************************************************************
 PROGRAMA    	:	PR_ORDENES_ROLLOUT
 FECHA		:	18/06/2014
 AUTOR		:	OLSoftware
 DESCRIPCION	:	Migra la informacion de ordenes de varios procesos
 HISTORIA DE MODIFICACIONES
 AUTOR	   FECHA	DESCRIPCION

 *******************************************************************/

	verror              VARCHAR2 (2000);
	vcontLec            NUMBER := 0;
	vcontIns            NUMBER := 0;
	SBDOCUMENTO         VARCHAR2(30) := NULL;
	NUORDER_ID          NUMBER := 0;
	NUDIRECCION         NUMBER := 0;
	NUORACTI            NUMBER := NULL;
	nuComplementoPR     number;
	nuComplementoSU     number;
	nuComplementoFA     number;
	nuComplementoCU     number;
	nuComplementoDI     number;

   CURSOR cuOrdenes
       is
   SELECT /*+ PARALLEL */ 
        E.COLOHOMO	GEOGRAP_LOCATION_ID,
        C.SESUSUSC	SUBSCRIPTION_ID,
        C.SESUNUSE	PRODUCT_ID,
        A.ORTRFEEL	REPROGRAM_LAST_DATE,
        A.ORTRFEEL 	CREATED_DATE,
        A.ORTRFEEJ 	EXECUTION_FINAL_DATE,
        A.ORTRFEPE 	EXEC_ESTIMATE_DATE,
        A.ORTRFELE 	LEGALIZATION_DATE,
        A.ORTRFEAS 	ASSIGNED_DATE,
        D.TRABHOMO 	TIPOTRAB,
        D.ACTIHOMO	ACTIVIDAD,
        B.SUSCIDDI 	DIRECCION,
        B.SUSCCLIE 	CLIENTE,
        SUBSTR ((A.ORTROBSE||' '||A.ORTROBS2),1,2000) OBSERVACION,
        'DATOS_ORDEN_GASPLUS : ['||A.ORTRDENU||'-'||A.ORTRLONU||'-'||A.ORTRNUME||' ORTRTITR:'||H.PARATRGP||' ORTRCUAD:'||A.ORTRCUAD||']'  DATOSORDEN
    FROM MIGRA.LDC_TEMP_ORDETRAB_SGE A, SUSCRIPC B, MIGRA.LDC_MIG_TIPOTRAB D, SERVSUSC C, LDC_MIG_LOCALIDAD E, LDC_MIG_PARATIPO H
    WHERE A.ORTRSUSC+nuComplementoSU = B.SUSCCODI
      AND A.BASEDATO = nuBD
      AND A.ORTRSUSC >= nuInicio
      AND A.ORTRSUSC <  nuFinal
      AND A.ORTRNUSE+nuComplementoPR = C.SESUNUSE
      AND A.ORTRDENU = E.CODIDEPA
      AND A.ORTRLONU = E.CODILOCA
      AND A.ORTRTITR = H.PARATITA
      AND H.PARACODI = 'ORDENES_VARIAS'
      AND A.BASEDATO = D.BASEDATO
      AND A.ORTRTITR = D.ORTRTITR
      AND A.ORTRFEGA IS NULL;
   --
     TYPE tipo_cu_datos IS TABLE OF cuOrdenes%ROWTYPE;

   -- DECLARACION DE TABLAS TIPOS.
   --
     tbl_datos      tipo_cu_datos := tipo_cu_datos ();

     numInicio number;
     nuLogError NUMBER;
     nuTotalRegs number := 0;
     nuErrores number := 0;
     nuSubscriberId number;
     sbOrden1 varchar2(2000);
     sbOrden2 varchar2(2000);
     sbLealizeComment varchar2(1):= 'N';
     NUORDEN varchar2(2000);

BEGIN

   -- Inserta registro de inicio en el log
   PKLOG_MIGRACION.prInsLogMigra (201,201,1,'PR_ORDENES_ROLLOUT',0,0,'Inicia Proceso','INICIO',nuLogError);
   
   UPDATE MIGR_RANGO_PROCESOS SET RAPRFEIN = SYSDATE, RAPRTERM = 'P' WHERE RAPRCODI = 201 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
   COMMIT;
   
   pkg_constantes.COMPLEMENTO(nuBD,nuComplementoPR,nuComplementoSU,nuComplementoFA,nuComplementoCU,nuComplementoDI);

   -- Cargar datos
   OPEN cuOrdenes;

   LOOP
      --
	    -- Borrar tablas 	tbl_datos.
      --
      tbl_datos.delete;

	  FETCH cuOrdenes
      BULK COLLECT INTO tbl_datos
      LIMIT 1000;

	  FOR nuindice IN 1 .. tbl_datos.COUNT
      LOOP
         BEGIN
            vcontLec := vcontLec +1;

             NUDIRECCION := TBL_DATOS (NUINDICE).direccion;
   
             NUORDER_ID := SEQ_OR_ORDER.NEXTVAL;
             nuOracti :=  SEQ_OR_ORDER_ACTIVITY.nextval;
	     
	     sbOrden1 := TBL_DATOS (NUINDICE).OBSERVACION;
	     sbOrden2 := TBL_DATOS (NUINDICE).DATOSORDEN;

             ---------------
             BEGIN
                SELECT suscclie INTO nuSubscriberId FROM suscripc WHERE susccodi = tbl_datos (nuindice).SUBSCRIPTION_ID;
                    EXCEPTION
                    when others then
                        nuSubscriberId := 0;
              END;
             ---------------

            --- Inserta en la tabla de OR_ORDER

             begin

                 INSERT /*+ APPEND */ INTO OR_ORDER(ORDER_ID, PRIOR_ORDER_ID, NUMERATOR_ID, SEQUENCE, PRIORITY, EXTERNAL_ADDRESS_ID,
                          CREATED_DATE, EXEC_INITIAL_DATE, EXECUTION_FINAL_DATE, EXEC_ESTIMATE_DATE, ARRANGED_HOUR, LEGALIZATION_DATE,
                          REPROGRAM_LAST_DATE, ASSIGNED_DATE, ASSIGNED_WITH, MAX_DATE_TO_LEGALIZE, ORDER_VALUE, PRINTING_TIME_NUMBER,
                          LEGALIZE_TRY_TIMES, OPERATING_UNIT_ID, ORDER_STATUS_ID, TASK_TYPE_ID, OPERATING_SECTOR_ID, CAUSAL_ID,
                          ADMINIST_DISTRIB_ID, ORDER_CLASSIF_ID, GEOGRAP_LOCATION_ID, IS_COUNTERMAND, REAL_TASK_TYPE_ID, SAVED_DATA_VALUES,
                          FOR_AUTOMATIC_LEGA, ORDER_COST_AVERAGE, ORDER_COST_BY_LIST, OPERATIVE_AIU_VALUE, ADMIN_AIU_VALUE, CHARGE_STATUS,
                          PREV_ORDER_STATUS_ID, PROGRAMING_CLASS_ID, PREVIOUS_WORK, APPOINTMENT_CONFIRM, X, Y, STAGE_ID, LEGAL_IN_PROJECT,
                          OFFERED, ASSO_UNIT_ID, SUBSCRIBER_ID, ADM_PENDING, SHAPE, ROUTE_ID, CONSECUTIVE, DEFINED_CONTRACT_ID, IS_PENDING_LIQ)
                  VALUES (NUORDER_ID, NULL, NULL, NULL, 99, NUDIRECCION, TBL_DATOS(NUINDICE).CREATED_DATE, NULL,
                          TBL_DATOS(NUINDICE).EXECUTION_FINAL_DATE,
                          TBL_DATOS(NUINDICE).EXEC_ESTIMATE_DATE, NULL, TBL_DATOS(NUINDICE).LEGALIZATION_DATE,
                          TBL_DATOS(NUINDICE).REPROGRAM_LAST_DATE,TBL_DATOS(NUINDICE).ASSIGNED_DATE,
                          NULL, NULL, NULL, NULL, NULL, 1, 8, TBL_DATOS(NUINDICE).TIPOTRAB, NULL, 1, NULL, NULL,
                          tbl_datos ( nuindice).GEOGRAP_LOCATION_ID,'N', TBL_DATOS(NUINDICE).ACTIVIDAD, NULL, NULL,
                          0, 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TBL_DATOS(NUINDICE).CLIENTE, -- ge Subscriber
                          NULL, NULL, NULL, NULL, NULL, NULL);
                          
                COMMIT;
               EXCEPTION
                  WHEN OTHERS  THEN
                  BEGIN
                     verror := 'Error Paso 1: '||sbdocumento ||' -'|| SQLERRM;
                     nuErrores := nuErrores + 1;
                     PKLOG_MIGRACION.prInsLogMigra (201,201,2,'PR_ORDENES_ROLLOUT',0,0,'Error: '||verror,to_char(sqlcode),nuLogError);
                  END;
              END;
	      
	      	begin
			
			NUORDEN := sbOrden1;
			
			if (NUORDEN is not null )  then
			sbLealizeComment := 'Y';
			end if;
									
					INSERT /*+ APPEND */ INTO OR_ORDER_COMMENT(ORDER_COMMENT_ID, ORDER_COMMENT, ORDER_ID, COMMENT_TYPE_ID,
								 REGISTER_DATE, LEGALIZE_COMMENT, PERSON_ID)
					   VALUES ( SEQ_OR_ORDER_COMMENT.NEXTVAL, NUORDEN, NUORDER_ID, -1, NULL, sbLealizeComment, NULL);
			COMMIT;
		
			EXCEPTION
	                  WHEN OTHERS  THEN
	                  BEGIN
	                     verror := 'Error Paso 2: '||sbdocumento ||' -'|| SQLERRM;
	                     nuErrores := nuErrores + 1;
	                     PKLOG_MIGRACION.prInsLogMigra ( 201,201,2,'PR_ORDENES_ROLLOUT',0,0,'Error: '||verror,to_char(sqlcode),nuLogError);
	                  END;
		end; 
			
		begin
			
			NUORDEN := sbOrden2;
			
			if (NUORDEN is not null )  then
			sbLealizeComment := 'Y';
			end if;
									
					INSERT /*+ APPEND */ INTO OR_ORDER_COMMENT(ORDER_COMMENT_ID, ORDER_COMMENT, ORDER_ID, COMMENT_TYPE_ID,
								 REGISTER_DATE, LEGALIZE_COMMENT, PERSON_ID)
					   VALUES ( SEQ_OR_ORDER_COMMENT.NEXTVAL, NUORDEN, NUORDER_ID, -1, NULL, sbLealizeComment, NULL);
			COMMIT;
		
			EXCEPTION
	                  WHEN OTHERS  THEN
	                  BEGIN
	                     verror := 'Error Paso 3: '||sbdocumento ||' -'|| SQLERRM;
	                     nuErrores := nuErrores + 1;
	                     PKLOG_MIGRACION.prInsLogMigra ( 201,201,2,'PR_ORDENES_ROLLOUT',0,0,'Error: '||verror,to_char(sqlcode),nuLogError);
	                  END;
		end; 	      

              BEGIN
                  --- Inserta en la tabla OR_ORDER_ACTIVITY
                  INSERT /*+ APPEND */ INTO OR_ORDER_ACTIVITY(ORDER_ACTIVITY_ID, ORDER_ITEM_ID, ORDER_ID, STATUS, TASK_TYPE_ID, PACKAGE_ID,
                          MOTIVE_ID, COMPONENT_ID, INSTANCE_ID, ADDRESS_ID, ELEMENT_ID, SUBSCRIBER_ID, SUBSCRIPTION_ID, PRODUCT_ID,
                          OPERATING_SECTOR_ID, EXEC_ESTIMATE_DATE, OPERATING_UNIT_ID, COMMENT_, PROCESS_ID, ACTIVITY_ID, ORIGIN_ACTIVITY_ID,
                          ACTIVITY_GROUP_ID, SEQUENCE_, REGISTER_DATE, FINAL_DATE, VALUE1, VALUE2, VALUE3, VALUE4, COMPENSATED,
                          ORDER_TEMPLATE_ID, CONSECUTIVE, SERIAL_ITEMS_ID, LEGALIZE_TRY_TIMES, WF_TAG_NAME, VALUE_REFERENCE)
                    VALUES (NUORACTI, NULL, NUORDER_ID, 'F', TBL_DATOS(NUINDICE).TIPOTRAB, NULL, NULL, NULL, NULL, NUDIRECCION,
		            NULL, TBL_DATOS(NUINDICE).CLIENTE,TBL_DATOS(NUINDICE).SUBSCRIPTION_ID, TBL_DATOS(NUINDICE).PRODUCT_ID,
                            NULL, NULL, NULL, NULL, NULL, TBL_DATOS(NUINDICE).ACTIVIDAD, NULL, NULL, NULL, TBL_DATOS(NUINDICE).CREATED_DATE, 
			    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,NULL);

                 -- INSERTA EN OR_EXTERN_SYSTEM_ID
                 INSERT INTO OR_EXTERN_SYSTEMS_ID (ORDER_ID, EXTERN_SYSTEM_ID, EXTE_SYST_TYPE_ID, FATHE_EXTER_SYSTE_ID, FAT_EXT_SYS_TYP_ID,
                              EXTERN_ENTITY_ID, FATHER_EXT_ENTITY_ID, EXT_SYS_TYP_ENT_ID, FAT_EX_SYS_TY_ENT_ID,
                              MOTIVE_CREATION_DATE, IM_ASSIG_PROCESS_ID, SERVICE_NUMBER, PRODUCT_ID, DAMAGE_ID, SUBSCRIPTION_ID,
                              SUBSCRIBER_ID, SUBSCRIBER_NAME, PACKAGE_ID, PACKAGE_TYPE_ID, RUSECONS, CORSCOPR, ADDRESS_ID)
                       VALUES (NUORDER_ID, NULL, NULL, NULL,NULL,NULL,NULL,NULL, NULL,NULL,NULL,TBL_DATOS(NUINDICE).SUBSCRIPTION_ID,
                               TBL_DATOS(NUINDICE).SUBSCRIPTION_ID,NULL, TBL_DATOS(NUINDICE).SUBSCRIPTION_ID, TBL_DATOS(NUINDICE).CLIENTE,
                               NULL, NULL, NULL, NULL, NULL, NULL);

                COMMIT;

              EXCEPTION
                  WHEN OTHERS  THEN
                  BEGIN
                     verror := 'Error Paso 4: '||sbdocumento|| ' - ' ||SQLCODE ||' -'|| SQLERRM;
                     nuErrores := nuErrores + 1;
                     PKLOG_MIGRACION.prInsLogMigra ( 201,201,2,'PR_ORDENES_ROLLOUT',0,0,'Error: '||verror,to_char(sqlcode),nuLogError);
                  END;
              END;
             
         COMMIT;
            vcontIns := vcontIns +1;

         EXCEPTION
            WHEN OTHERS  THEN
			      BEGIN
			         verror := 'Error paso 5: '||sbdocumento|| ' - ' ||SQLCODE ||' -'|| SQLERRM;

			         nuErrores := nuErrores + 1;
                     PKLOG_MIGRACION.prInsLogMigra ( 201,201,2,'PR_ORDENES_ROLLOUT',0,0,'Error: '||verror,to_char(sqlcode),nuLogError);
			      END;
        END;
      END LOOP;

      EXIT WHEN cuOrdenes%NOTFOUND;

   END LOOP;

    -- Cierra CURSOR.
   IF (cuOrdenes%ISOPEN)
   THEN
      --{
      CLOSE cuOrdenes;
   --}
   END IF;

  -- Termina Log
  PKLOG_MIGRACION.prInsLogMigra ( 201,201,3,'PR_ORDENES_ROLLOUT',vcontIns,nuErrores,'TERMINO PROCESO #regs: '||vcontIns,'FIN',nuLogError);
  
  UPDATE MIGR_RANGO_PROCESOS SET RAPRFEFI = SYSDATE, RAPRTERM = 'T' where RAPRCODI = 201 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
   COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      PKLOG_MIGRACION.prInsLogMigra ( 201,201,2,'PR_ORDENES_ROLLOUT',0,0,'Error: '||verror,to_char(sqlcode),nuLogError);

END PR_ORDENES_ROLLOUT; 
/