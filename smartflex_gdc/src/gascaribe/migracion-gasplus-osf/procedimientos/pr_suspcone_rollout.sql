CREATE OR REPLACE PROCEDURE PR_SUSPCONE_ROLLOUT (nuInicio number, nuFinal number, nuBD number) AS 
/*******************************************************************
 PROGRAMA    	:	PR_SUSPCONE_ROLLOUT
 FECHA		:	17/06/2014
 AUTOR		:	OLSoftware
 DESCRIPCION	:	Migra la informacion de ordenes de suspension y corte cerradas
			de los ultimos 2 años 
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
	nuComplementoPR   number;
	nuComplementoSU   number;
	nuComplementoFA   number;
	nuComplementoCU   number;
	nuComplementoDI  number;

   CURSOR cuSuspcone
       is
     SELECT /*+ PARALLEL */ 
		E.DEPAHOMO	SUCODEPA,
		E.COLOHOMO	SUCOLOCA,
		A.ORTRNUME	SUCONUOR,
		C.SESUSUSC	SUCOSUSC,
		7014      	SUCOSERV,
		C.SESUNUSE	SUCONUSE,
		'D'             SUCOTIPO,
		A.ORTRFEEL	SUCOFEOR,
		A.ORTRFEEL 	CREATED_DATE,
		A.ORTRFEEJ 	EXECUTION_FINAL_DATE,
		A.ORTRFEPE 	EXEC_ESTIMATE_DATE,
		a.ORTRFELE 	LEGALIZATION_DATE,
		A.ORTRFEAS 	ASSIGNED_DATE,
		A.ORTRFELE	SUCOFEAT,
		NULL      	SUCOCACD,
		substr(A.ORTROBSE,1,120) SUCOOBSE,
		-1        	SUCOCOEC,
		NULL      	SUCOIDSC,
		NULL		CAUSE_FAILURE,
		NULL		PROCESS_STATUS,
		NULL          	SUCOCICL,
		-1		SUCOCENT,
		'MIGRACION'	SUCOPROG,
		'T. MIGRACION'	SUCOTERM,
		'MIGRACION'	SUCOUSUA,
		'S'		SUCOORIM,
		NULL		SUCOACTIV_ID,
		NULL		SUCOORDTYPE,
		NULL		SUCOACGC,
		NULL          	SUCOCUPO,
		F.ORTRTITR      TIPOGASP,
		F.TRABHOMO 	TIPOTRAB,
		F.ACTIHOMO	ACTIVIDAD,
		B.SUSCIDDI 	DIRECCION,
		B.SUSCCLIE 	CLIENTE,
		SUBSTR ((A.ORTROBSE||' '||A.ORTROBS2),1,2000) OBSERVACION,
		G.CAUSLEGA      CAUSAL_ID,
		'DATOS_ORDEN_GASPLUS : ['||A.ORTRDENU||'-'||A.ORTRLONU||'-'||A.ORTRNUME||' ORTRTITR:'||H.PARATRGP||' ORTRCUAD:'||A.ORTRCUAD||']'  DATOSORDEN
	FROM MIGRA.LDC_TEMP_ORDETRAB_SGE A, OPEN.SUSCRIPC B, OPEN.SERVSUSC C, MIGRA.LDC_MIG_TIPOTRAB F, MIGRA.LDC_MIG_LOCALIDAD E, LDC_MIG_TIPOSOLI G, LDC_MIG_PARATIPO H
	WHERE A.BASEDATO = nuBD
		AND A.ORTRSUSC >= nuInicio
        AND A.ORTRSUSC <  nuFinal
        --AND A.ORTRSUSC+nuComplementoSU = (B.SUSCCODI)
		--AND A.ORTRNUSE+nuComplementoPR = (C.SESUNUSE)
		AND A.ORTRSUSC+nuComplementoSU = (C.SESUSUSC)
		AND A.ORTRNUSE+nuComplementoPR = (C.SESUNUSE)
		AND (C.SESUSUSC) = (B.SUSCCODI)
		AND A.ORTRTITR = H.PARATITA
		AND H.PARACODI = 'SUSPENSIONES'
		AND A.BASEDATO = F.BASEDATO
		AND A.ORTRTITR = F.ORTRTITR
		AND A.ORTRDENU = E.CODIDEPA
		AND A.ORTRLONU = E.CODILOCA
		AND A.ORTRTITR = G.TIPOTRAB
		AND A.BASEDATO = G.BASEDATO
    AND A.ORTRNUSE = 2064710;
   --
     TYPE tipo_cu_datos IS TABLE OF cuSuspcone%ROWTYPE;

   -- DECLARACION DE TABLAS TIPOS.
   --
     tbl_datos      tipo_cu_datos := tipo_cu_datos ();

     numInicio number;
     nuLogError NUMBER;
     nuTotalRegs number := 0;
     nuErrores number := 0;
     sbOrden1 varchar2(2000);
     sbOrden2 varchar2(2000);
     sbLealizeComment varchar2(1):= 'N';
     NUORDEN varchar2(2000);

	 cursor cuCliente(nuSusc number) is
	 select suscclie from suscripc where susccodi =nuSusc;
	 
	 nuCliente number;
	 nuOrderItem number;
BEGIN

   -- Inserta registro de inicio en el log
   PKLOG_MIGRACION.prInsLogMigra (192,192,1,'PR_SUSPCONE_ROLLOUT',0,0,'Inicia Proceso','INICIO',nuLogError);
   
   UPDATE MIGR_RANGO_PROCESOS SET RAPRFEIN = SYSDATE, RAPRTERM = 'P' where RAPRCODI = 192 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
   COMMIT;
   
   pkg_constantes.COMPLEMENTO(nuBD,nuComplementoPR,nuComplementoSU,nuComplementoFA,nuComplementoCU,nuComplementoDI);
   
   -- Cargar datos
   OPEN cuSuspcone;

   LOOP
      --
	    -- Borrar tablas 	tbl_datos.
      --
      tbl_datos.delete;

	  FETCH cuSuspcone
      BULK COLLECT INTO tbl_datos
      LIMIT 1000;

	  FOR nuindice IN 1 .. tbl_datos.COUNT
	  LOOP
	    BEGIN
            vcontLec := vcontLec +1;

             NUDIRECCION := TBL_DATOS (NUINDICE).direccion;
             SBDOCUMENTO := TBL_DATOS (NUINDICE).SUCODEPA||'-'||TBL_DATOS (NUINDICE).SUCOLOCA||'-'||TBL_DATOS (NUINDICE).SUCONUOR;
             TBL_DATOS (NUINDICE).SUCONUOR := NUORDER_ID;

             NUORDER_ID := SEQ_OR_ORDER.NEXTVAL;
             nuOracti :=  SEQ_OR_ORDER_ACTIVITY.nextval;
             nuOrderItem := SEQ_OR_ORDER_ITEMS.nextval;
			 
             sbOrden1 := TBL_DATOS (NUINDICE).OBSERVACION;
             sbOrden2 := TBL_DATOS (NUINDICE).DATOSORDEN;
	     
            --- Inserta en la tabla de OR_ORDER

                BEGIN
				OPEN  cuCliente(TBL_DATOS(NUINDICE).SUCOSUSC);
				FETCH cuCliente into nuCliente;
				CLOSE cuCliente;
				
                INSERT /*+ APPEND */ INTO OR_ORDER(ORDER_ID, PRIOR_ORDER_ID, NUMERATOR_ID, SEQUENCE, PRIORITY, EXTERNAL_ADDRESS_ID, CREATED_DATE, EXEC_INITIAL_DATE, 
						 EXECUTION_FINAL_DATE, EXEC_ESTIMATE_DATE, ARRANGED_HOUR, LEGALIZATION_DATE, REPROGRAM_LAST_DATE, ASSIGNED_DATE, 
						 ASSIGNED_WITH, MAX_DATE_TO_LEGALIZE, ORDER_VALUE, PRINTING_TIME_NUMBER, LEGALIZE_TRY_TIMES, OPERATING_UNIT_ID,
						 ORDER_STATUS_ID, TASK_TYPE_ID, OPERATING_SECTOR_ID, CAUSAL_ID, ADMINIST_DISTRIB_ID, ORDER_CLASSIF_ID, GEOGRAP_LOCATION_ID,
						 IS_COUNTERMAND, REAL_TASK_TYPE_ID, SAVED_DATA_VALUES, FOR_AUTOMATIC_LEGA, ORDER_COST_AVERAGE, ORDER_COST_BY_LIST, OPERATIVE_AIU_VALUE,
						 ADMIN_AIU_VALUE, CHARGE_STATUS, PREV_ORDER_STATUS_ID, PROGRAMING_CLASS_ID, PREVIOUS_WORK, APPOINTMENT_CONFIRM, X, Y,
						 STAGE_ID, LEGAL_IN_PROJECT, OFFERED, ASSO_UNIT_ID, SUBSCRIBER_ID, ADM_PENDING, SHAPE, ROUTE_ID, CONSECUTIVE, DEFINED_CONTRACT_ID,
						 IS_PENDING_LIQ) 
				         VALUES (NUORDER_ID, NULL, NULL, NULL, 99, NUDIRECCION, TBL_DATOS(NUINDICE).CREATED_DATE, NULL, TBL_DATOS(NUINDICE).EXECUTION_FINAL_DATE,
						TBL_DATOS(NUINDICE).EXEC_ESTIMATE_DATE, NULL, TBL_DATOS(NUINDICE).LEGALIZATION_DATE, TBL_DATOS(NUINDICE).SUCOFEOR, TBL_DATOS(NUINDICE).ASSIGNED_DATE,
						NULL, NULL, NULL, NULL, NULL, 1, 8, TBL_DATOS(NUINDICE).TIPOTRAB, NULL, TBL_DATOS(NUINDICE).CAUSAL_ID, NULL, NULL, tbl_datos ( nuindice).SUCOLOCA, 'N', 
						TBL_DATOS(NUINDICE).TIPOTRAB, NULL, NULL, 0, 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
						nuCliente, NULL, NULL, NULL, NULL, NULL, NULL);
                COMMIT;

	                EXCEPTION
	                  WHEN OTHERS  THEN
	                  BEGIN
	                     verror := 'Error en la Suspension Paso 1: '||sbdocumento ||' -'|| SQLERRM;
	                     nuErrores := nuErrores + 1;
	                   PKLOG_MIGRACION.prInsLogMigra ( 192,192,2,'PR_SUSPCONE_ROLLOUT',0,0,'Error: '||verror,to_char(sqlcode),nuLogError);
	                END;
                END;
              
			-- registra observaciones o comentarios de la orden de suspencion
			
		BEGIN
			
			NUORDEN := sbOrden1;
			
			IF (NUORDEN IS NOT NULL) THEN
			sbLealizeComment := 'Y';
			END IF;
									
		INSERT /*+ APPEND */ INTO OR_ORDER_COMMENT(ORDER_COMMENT_ID, ORDER_COMMENT, ORDER_ID, COMMENT_TYPE_ID,REGISTER_DATE, LEGALIZE_COMMENT, PERSON_ID)
						VALUES ( SEQ_OR_ORDER_COMMENT.NEXTVAL, NUORDEN, NUORDER_ID, -1, NULL, sbLealizeComment, NULL);
		COMMIT;
				
			EXCEPTION
	                  WHEN OTHERS  THEN
	                  BEGIN
	                     verror := 'Error en la Suspension Paso 2: '||sbdocumento ||' -'|| SQLERRM;
	                     nuErrores := nuErrores + 1;
	                    PKLOG_MIGRACION.prInsLogMigra ( 192,192,2,'PR_SUSPCONE_ROLLOUT insertando comentario',0,0,'Error: '||verror,to_char(sqlcode),nuLogError);
	                END;
		END;
			
		BEGIN
			
			NUORDEN := sbOrden2;
			
			IF (NUORDEN IS NOT NULL)  THEN
			sbLealizeComment := 'Y';
			END IF;
									
		INSERT /*+ APPEND */ INTO OR_ORDER_COMMENT(ORDER_COMMENT_ID, ORDER_COMMENT, ORDER_ID, COMMENT_TYPE_ID,REGISTER_DATE, LEGALIZE_COMMENT, PERSON_ID)
						VALUES ( SEQ_OR_ORDER_COMMENT.NEXTVAL, NUORDEN, NUORDER_ID, -1, NULL, sbLealizeComment, NULL);
		COMMIT;
				
			EXCEPTION
	                  WHEN OTHERS  THEN
	                  BEGIN
	                     verror := 'Error en la Suspension Paso 3: '||sbdocumento ||' -'|| SQLERRM;
	                     nuErrores := nuErrores + 1;
	                    PKLOG_MIGRACION.prInsLogMigra ( 192,192,2,'PR_SUSPCONE_ROLLOUT insertando comentario',0,0,'Error: '||verror,to_char(sqlcode),nuLogError);
	                END;
		END; 
			  
                BEGIN
                  
                --- Inserta en la tabla OR_ORDER_ACTIVITY
                INSERT /*+ APPEND */ INTO OR_ORDER_ACTIVITY(ORDER_ACTIVITY_ID, ORDER_ITEM_ID, ORDER_ID, STATUS, TASK_TYPE_ID, PACKAGE_ID,MOTIVE_ID, COMPONENT_ID,INSTANCE_ID, ADDRESS_ID,
							ELEMENT_ID, SUBSCRIBER_ID, SUBSCRIPTION_ID, PRODUCT_ID, OPERATING_SECTOR_ID, EXEC_ESTIMATE_DATE, OPERATING_UNIT_ID, COMMENT_, PROCESS_ID, ACTIVITY_ID, 
							ORIGIN_ACTIVITY_ID, ACTIVITY_GROUP_ID, SEQUENCE_, REGISTER_DATE, FINAL_DATE, VALUE1, VALUE2, VALUE3, VALUE4, COMPENSATED, ORDER_TEMPLATE_ID, 
							CONSECUTIVE, SERIAL_ITEMS_ID, LEGALIZE_TRY_TIMES, WF_TAG_NAME, VALUE_REFERENCE)
						VALUES (nuOracti, NULL, NUORDER_ID, 'F', TBL_DATOS(NUINDICE).TIPOTRAB, NULL, NULL, NULL, NULL, NUDIRECCION, NULL, TBL_DATOS(NUINDICE).CLIENTE, TBL_DATOS(NUINDICE).SUCOSUSC,
							TBL_DATOS(NUINDICE).SUCONUSE, NULL, NULL, NULL, NULL, NULL, TBL_DATOS(NUINDICE).ACTIVIDAD, NULL, NULL,NULL,TBL_DATOS(NUINDICE).CREATED_DATE, NULL, NULL, NULL, NULL, NULL, NULL, 
							NULL, NULL, NULL, NULL, NULL, NULL);

                  --- Inserta en la tabla OR_ORDER_ITEMS
                INSERT INTO OR_ORDER_ITEMS (ORDER_ID, ITEMS_ID, ASSIGNED_ITEM_AMOUNT, LEGAL_ITEM_AMOUNT, VALUE, ORDER_ITEMS_ID, TOTAL_PRICE,
					    ELEMENT_CODE, ORDER_ACTIVITY_ID, ELEMENT_ID, REUSED, SERIAL_ITEMS_ID, SERIE, OUT_)
				    VALUES (NUORDER_ID, TBL_DATOS(NUINDICE).ACTIVIDAD, 1, 0, 0, nuOrderItem, 0,NULL, nuOracti, NULL, NULL, NULL, NULL, NULL);
                         
                --- Se actualiza la OR_ORDER_ACTIVITY con el ORDER_ITEM_ID de  OR_ORDER_ITEMS
                 UPDATE OR_ORDER_ACTIVITY
                    SET ORDER_ITEM_ID = nuOrderItem,
                         ACTIVITY_ID = TBL_DATOS(NUINDICE).ACTIVIDAD
                  WHERE  ORDER_ACTIVITY_ID = nuOracti;

                 -- INSERTA EN OR_EXTERN_SYSTEM_ID
                INSERT INTO OR_EXTERN_SYSTEMS_ID (ORDER_ID, EXTERN_SYSTEM_ID, EXTE_SYST_TYPE_ID, FATHE_EXTER_SYSTE_ID, FAT_EXT_SYS_TYP_ID,
						  EXTERN_ENTITY_ID, FATHER_EXT_ENTITY_ID, EXT_SYS_TYP_ENT_ID, FAT_EX_SYS_TY_ENT_ID,
						  MOTIVE_CREATION_DATE, IM_ASSIG_PROCESS_ID, SERVICE_NUMBER, PRODUCT_ID, DAMAGE_ID, SUBSCRIPTION_ID,
						  SUBSCRIBER_ID, SUBSCRIBER_NAME, PACKAGE_ID, PACKAGE_TYPE_ID, RUSECONS, CORSCOPR, ADDRESS_ID)
					  VALUES (NUORDER_ID, NULL, NULL, NULL,NULL,NULL,NULL,NULL, NULL,NULL,NULL,TBL_DATOS(NUINDICE).SUCOSUSC,
						  TBL_DATOS(NUINDICE).SUCOSUSC,NULL, TBL_DATOS(NUINDICE).SUCOSUSC, nuCliente, NULL, NULL, NULL, NULL, 
						  NULL, NUDIRECCION);
                COMMIT;

			EXCEPTION
	                  WHEN OTHERS  THEN
	                  BEGIN
	                     verror := 'Error en la Suspension Paso 4: '||sbdocumento|| ' - ' ||SQLCODE ||' -'|| SQLERRM;
	                     nuErrores := nuErrores + 1;
	                    PKLOG_MIGRACION.prInsLogMigra ( 192,192,2,'PR_SUSPCONE_ROLLOUT',0,0,'Error: '||verror,to_char(sqlcode),nuLogError);
	                END;
		END;
	      
		BEGIN
                  UPDATE OR_ORDER_ITEMS
                     SET ORDER_ITEMS_ID = nuOrderItem
                   WHERE ORDER_ID = NUORDER_ID;
                  COMMIT;
			EXCEPTION
	                  WHEN OTHERS  THEN
	                  BEGIN
	                     verror := 'Error en la Suspension Paso 5: '||sbdocumento|| ' - ' ||SQLCODE ||' -'|| SQLERRM;
	                     nuErrores := nuErrores + 1;
	                 PKLOG_MIGRACION.prInsLogMigra ( 192,192,2,'PR_SUSPCONE_ROLLOUT',0,0,'Error: '||verror,to_char(sqlcode),nuLogError);
	                END;
		END;

		BEGIN

                  IF TBL_DATOS(NUINDICE).TIPOTRAB <> 10382 THEN -- Si el tipo de trabajo es 10122 no se inserta en suspcone
		  
                      -- Se inserta en  SUSPCONE
                INSERT INTO SUSPCONE (SUCODEPA, SUCOLOCA, SUCONUOR, SUCOSUSC, SUCOSERV, SUCONUSE, SUCOTIPO,  SUCOFEOR, SUCOFEAT,
                                      SUCOCACD, SUCOOBSE, SUCOCOEC, SUCOIDSC, CAUSE_FAILURE, PROCESS_STATUS, SUCOCICL, SUCOCENT,
                                      SUCOPROG, SUCOTERM, SUCOUSUA,  SUCOORIM, SUCOACTIV_ID, SUCOORDTYPE, SUCOACGC, SUCOCUPO)
                              VALUES (TBL_DATOS ( NUINDICE).SUCODEPA, TBL_DATOS ( NUINDICE).SUCOLOCA, NUORDER_ID,
				      TBL_DATOS ( NUINDICE).SUCOSUSC, TBL_DATOS ( NUINDICE).SUCOSERV, TBL_DATOS ( NUINDICE).SUCONUSE,
                                      tbl_datos ( nuindice).SUCOTIPO, tbl_datos ( nuindice).SUCOFEOR, tbl_datos ( nuindice).SUCOFEAT,
                                      tbl_datos ( nuindice).SUCOCACD, tbl_datos ( nuindice).SUCOOBSE, tbl_datos ( nuindice).SUCOCOEC,
                                      SQSUSPCONE.NEXTVAL, TBL_DATOS ( NUINDICE).CAUSE_FAILURE, TBL_DATOS ( NUINDICE).PROCESS_STATUS,
                                      TBL_DATOS ( NUINDICE).SUCOCICL, TBL_DATOS ( NUINDICE).SUCOCENT, TBL_DATOS ( NUINDICE).SUCOPROG,
                                      TBL_DATOS ( NUINDICE).SUCOTERM, TBL_DATOS ( NUINDICE).SUCOUSUA, TBL_DATOS ( NUINDICE).SUCOORIM,
                                      TBL_DATOS ( NUINDICE).SUCOACTIV_ID, TBL_DATOS ( NUINDICE).SUCOORDTYPE, TBL_DATOS ( NUINDICE).SUCOACGC,
                                      TBL_DATOS ( NUINDICE).SUCOCUPO);
                COMMIT;
                  END IF;
			EXCEPTION
	                  WHEN OTHERS  THEN
	                  BEGIN
	                     verror := 'Error en la Suspension Paso 6: '||sbdocumento|| ' - ' ||SQLCODE ||' -'|| SQLERRM;
	                     nuErrores := nuErrores + 1;
	                  PKLOG_MIGRACION.prInsLogMigra ( 192,192,2,'PR_SUSPCONE_ROLLOUT',0,0,'Error: '||verror,to_char(sqlcode),nuLogError);
	                END;
		END;

        COMMIT;
            vcontIns := vcontIns +1;

		EXCEPTION
			WHEN OTHERS  THEN
			BEGIN
			verror := 'Error en la Suspension paso 7: '||sbdocumento|| ' - ' ||SQLCODE ||' -'|| SQLERRM;

			nuErrores := nuErrores + 1;
			PKLOG_MIGRACION.prInsLogMigra ( 192,192,2,'PR_SUSPCONE_ROLLOUT',0,0,'Error: '||verror,to_char(sqlcode),nuLogError);
		END;
        END;
      END LOOP;

      EXIT WHEN cuSuspcone%NOTFOUND;

   END LOOP;

    -- Cierra CURSOR.
   IF (cuSuspcone%ISOPEN)
   THEN
      --{
      CLOSE cuSuspcone;
   --}
   END IF;


  -- Termina Log
  PKLOG_MIGRACION.prInsLogMigra ( 192,192,3,'PR_SUSPCONE_ROLLOUT',vcontIns,nuErrores,'TERMINO PROCESO #regs: '||vcontIns,'FIN',nuLogError);
  
  UPDATE MIGR_RANGO_PROCESOS SET RAPRFEIN = SYSDATE, RAPRTERM = 'T' where RAPRCODI = 192 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
  COMMIT;

EXCEPTION
   WHEN OTHERS THEN
    PKLOG_MIGRACION.prInsLogMigra ( 192,192,2,'PR_SUSPCONE_ROLLOUT',0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);

END PR_SUSPCONE_ROLLOUT;
/