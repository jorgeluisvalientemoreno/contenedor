CREATE OR REPLACE PROCEDURE PR_SUSPASOCIADOS_ROLLOUT (nuInicio number, nuFinal number, nuBD number) AS 
/*******************************************************************
 PROGRAMA     :	PR_SUSPASOCIADOS_ROLLOUT
 FECHA	      :	08/11/2014
 AUTOR        :	OLSoftware Jennifer Giraldo
 DESCRIPCION  :	Migra la informacion de ordenes de suspension de servicios asociados cerradas
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
	nuComplementoPR     number;
	nuComplementoSU     number;
	nuComplementoFA     number;
	nuComplementoCU     number;
	nuComplementoDI     number;

     CURSOR cuSuspinst IS
	SELECT /*+ PARALLEL */ 
		E.DEPAHOMO	DEPARTAMENTO,
		E.COLOHOMO	LOCALIDAD,
		A.ORTRNUME	NUME_ORDEN,
		C.SESUSUSC	CONTRATO,
		C.SESUNUSE	PRODUCTO,
		A.ORTRFEEL	FECHA_ELAB,
		A.ORTRFEEL 	CREATED_DATE,
		A.ORTRFEEJ 	EXECUTION_FINAL_DATE,
		A.ORTRFEPE 	EXEC_ESTIMATE_DATE,
		a.ORTRFELE 	LEGALIZATION_DATE,
		A.ORTRFEAS 	ASSIGNED_DATE,
		F.ORTRTITR  	TIPOGASP,
		F.TRABHOMO 	TIPOTRAB,
		F.ACTIHOMO	ACTIVIDAD,
		B.SUSCIDDI 	DIRECCION,
		B.SUSCCLIE 	CLIENTE,
		SUBSTR ((A.ORTROBSE||' '||A.ORTROBS2),1,2000) OBSERVACION,
		G.CAUSLEGA  	CAUSAL_ID,
		G.TIPOSOLI  	SOLICITUD,
		'DATOS_ORDEN_GASPLUS : ['||A.ORTRDENU||'-'||A.ORTRLONU||'-'||A.ORTRNUME||' ORTRTITR:'||H.PARATRGP||' ORTRCUAD:'||A.ORTRCUAD||']'  DATOSORDEN
	FROM MIGRA.LDC_TEMP_ORDETRAB_SGE A, OPEN.SUSCRIPC B, OPEN.SERVSUSC C, MIGRA.LDC_MIG_TIPOTRAB F, MIGRA.LDC_MIG_LOCALIDAD E, LDC_MIG_TIPOSOLI G, LDC_MIG_PARATIPO H
	WHERE A.BASEDATO = nuBD
	  AND A.ORTRSUSC >= nuInicio
    AND A.ORTRSUSC <  nuFinal
	  AND A.ORTRSUSC+nuComplementoSU = (B.SUSCCODI)
	  AND A.ORTRNUSE+nuComplementoPR = (C.SESUNUSE)
	  AND A.ORTRTITR = H.PARATITA
	  AND H.PARACODI = 'SUSPENSIONES_ASO'
	  AND A.BASEDATO = F.BASEDATO
	  AND A.ORTRTITR = F.ORTRTITR
	  AND A.ORTRDENU = E.CODIDEPA
	  AND A.ORTRLONU = E.CODILOCA
	  AND A.ORTRTITR = G.TIPOTRAB
	  AND A.BASEDATO = G.BASEDATO;
   --
     TYPE tipo_cu_datos IS TABLE OF cuSuspinst%ROWTYPE;

   -- DECLARACION DE TABLAS TIPOS.
   --
     tbl_datos      tipo_cu_datos := tipo_cu_datos ();

     CURSOR CUCLIENTE(NUSUSC NUMBER) IS
        SELECT SUSCCLIE 
        FROM SUSCRIPC 
        WHERE SUSCCODI =NUSUSC;
  
    CURSOR CUSUSPENSION_TYPE(INUPRODUCT_ID  MO_MOTIVE.PRODUCT_ID%TYPE) IS
       SELECT SUSPENSION_TYPE_ID
       FROM PR_PROD_SUSPENSION
       WHERE PRODUCT_ID=INUPRODUCT_ID
       ORDER BY 1 DESC;

	numInicio number;
	nuLogError NUMBER;
	nuTotalRegs number := 0;
	nuErrores number := 0;
	sbOrden1 varchar2(2000);
	sbOrden2 varchar2(2000);
	sbLealizeComment varchar2(1):= 'N';
	NUORDEN varchar2(2000);
	nuCliente number;
	nuOrderItem number;
	nupackage_id number;
	numotive_id number;
        nususpension_type_id    pr_prod_suspension.suspension_type_id%TYPE;
  
BEGIN

   -- Inserta registro de inicio en el log
   PKLOG_MIGRACION.prInsLogMigra (193,193,1,'PR_SUSPASOCIADOS_ROLLOUT',0,0,'Inicia Proceso','INICIO',nuLogError);
   
   UPDATE MIGR_RANGO_PROCESOS SET RAPRFEIN = SYSDATE, RAPRTERM = 'P' where RAPRCODI = 193 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
   COMMIT;
   
   pkg_constantes.COMPLEMENTO(nuBD,nuComplementoPR,nuComplementoSU,nuComplementoFA,nuComplementoCU,nuComplementoDI);
   
   -- Cargar datos
   OPEN cuSuspinst;

   LOOP
      --
	    -- Borrar tablas 	tbl_datos.
      --
      tbl_datos.delete;

	  FETCH cuSuspinst
          BULK COLLECT INTO tbl_datos
          LIMIT 1000;

	  FOR nuindice IN 1 .. tbl_datos.COUNT
	  LOOP
    
	    BEGIN
            vcontLec := vcontLec +1;

             NUDIRECCION := TBL_DATOS (NUINDICE).DIRECCION;
             SBDOCUMENTO := TBL_DATOS (NUINDICE).DEPARTAMENTO||'-'||TBL_DATOS (NUINDICE).LOCALIDAD||'-'||TBL_DATOS (NUINDICE).NUME_ORDEN;

             NUORDER_ID := SEQ_OR_ORDER.NEXTVAL;
             nuOracti := SEQ_OR_ORDER_ACTIVITY.nextval;
             nuOrderItem := SEQ_OR_ORDER_ITEMS.nextval;
             nupackage_id := seq_mo_packages.NEXTVAL;
	           numotive_id := seq_mo_motive.NEXTVAL;
			 
             sbOrden1 := TBL_DATOS (NUINDICE).OBSERVACION;
             sbOrden2 := TBL_DATOS (NUINDICE).DATOSORDEN;
	     
            --- Inserta en la tabla de OR_ORDER

                BEGIN
                OPEN  cuCliente(TBL_DATOS(NUINDICE).CONTRATO);
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
						 TBL_DATOS(NUINDICE).EXEC_ESTIMATE_DATE, NULL, TBL_DATOS(NUINDICE).LEGALIZATION_DATE, TBL_DATOS(NUINDICE).FECHA_ELAB, TBL_DATOS(NUINDICE).ASSIGNED_DATE,
						 NULL, NULL, NULL, NULL, NULL, 1, 8, TBL_DATOS(NUINDICE).TIPOTRAB, NULL, 9537, NULL, NULL, tbl_datos ( nuindice).LOCALIDAD, 'N', 
						 TBL_DATOS(NUINDICE).TIPOTRAB, NULL, NULL, 0, 0, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
						 nuCliente, NULL, NULL, NULL, NULL, NULL, NULL);
                COMMIT;

	                EXCEPTION
	                  WHEN OTHERS  THEN
	                  BEGIN
	                     verror := 'Error en la Suspension Paso 1: '||sbdocumento ||' -'|| SQLERRM;
	                     nuErrores := nuErrores + 1;
	                   PKLOG_MIGRACION.prInsLogMigra (193,193,2,'PR_SUSPASOCIADOS_ROLLOUT',0,0,'Error: '||verror,to_char(sqlcode),nuLogError);
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
	                    PKLOG_MIGRACION.prInsLogMigra (193,193,2,'PR_SUSPASOCIADOS_ROLLOUT insertando comentario',0,0,'Error: '||verror,to_char(sqlcode),nuLogError);
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
	                    PKLOG_MIGRACION.prInsLogMigra (193,193,2,'PR_SUSPASOCIADOS_ROLLOUT insertando comentario',0,0,'Error: '||verror,to_char(sqlcode),nuLogError);
	                END;
		END; 
		
		-- Se crea la solicitud de Susp.
		BEGIN
		INSERT INTO MO_PACKAGES (PACKAGE_ID, REQUEST_DATE, MESSAG_DELIVERY_DATE, USER_ID, TERMINAL_ID, CLIENT_PRIVACY_FLAG, NUMBER_OF_PROD, 
		PACKAGE_TYPE_ID, MOTIVE_STATUS_ID, SUBSCRIBER_ID, INTERFACE_HISTORY_ID, SUBSCRIPTION_PEND_ID, PERSON_ID, ATTENTION_DATE, COMM_EXCEPTION, 
		DISTRIBUT_ADMIN_ID, RECEPTION_TYPE_ID, CUST_CARE_REQUES_NUM, SALES_PLAN_ID, TAG_NAME, INCLUDED_ID, COMPANY_ID, ORGANIZAT_AREA_ID, 
		ZONE_ADMIN_ID, SALE_CHANNEL_ID, PRIORITY_ID, OPERATING_UNIT_ID, POS_OPER_UNIT_ID, PROJECT_ID, ANS_ID, EXPECT_ATTEN_DATE, ANSWER_MODE_ID, 
		REFER_MODE_ID, DOCUMENT_TYPE_ID, DOCUMENT_KEY, COMMENT_, CONTACT_ID, ADDRESS_ID, INSISTENTLY_COUNTER, ORDER_ID, MANAGEMENT_AREA_ID, 
		RECURRENT_BILLING, LIQUIDATION_METHOD, INIT_REGISTER_DATE)
		VALUES (nupackage_id,sysdate,sysdate,'-1','-','N',Null,TBL_DATOS(NUINDICE).SOLICITUD,14,Null,Null,Null,Null,Null,'N',Null,Null,'0',Null,
		'P_LBC_SUSPENSION_ADMINISTRATIVA_100013', Null,99,Null,Null,Null,Null,Null,Null,Null,Null,Null,Null,Null,Null,Null,Null,Null,Null,Null,Null,
		Null,Null,Null,Null);

			EXCEPTION
	                  WHEN OTHERS  THEN
	                  BEGIN
	                     verror := 'Error en la Suspension Paso 6: '||sbdocumento ||' -'|| SQLERRM;
	                     nuErrores := nuErrores + 1;
	                   PKLOG_MIGRACION.prInsLogMigra (193,193,2,'PR_SUSPASOCIADOS_ROLLOUT',0,0,'Error: '||verror,to_char(sqlcode),nuLogError);
	                END;
		
		END;
		
		 -- Se crea el motivo de la solicitud para el producto
		BEGIN
		INSERT INTO MO_MOTIVE (MOTIVE_ID, PRIVACY_FLAG, CLIENT_PRIVACY_FLAG, PROVISIONAL_FLAG, IS_MULT_PRODUCT_FLAG,
                AUTHORIZ_LETTER_FLAG, PARTIAL_FLAG, PROV_INITIAL_DATE, PROV_FINAL_DATE, INITIAL_PROCESS_DATE,
                PRIORITY, MOTIV_RECORDING_DATE, ESTIMATED_INST_DATE, ASSIGN_DATE, ATTENTION_DATE,
                ANNUL_DATE, STATUS_CHANGE_DATE, STUDY_NUM_TRANSFEREN, CUSTOM_DECISION_FLAG, EXECUTION_MAX_DATE,
                STANDARD_TIME, SERVICE_NUMBER, PRODUCT_MOTIVE_ID, DISTRIBUT_ADMIN_ID, DISTRICT_ID,
                BUILDING_ID, ANNUL_CAUSAL_ID, PRODUCT_ID, MOTIVE_TYPE_ID, PRODUCT_TYPE_ID,
                MOTIVE_STATUS_ID, SUBSCRIPTION_ID, PACKAGE_ID, UNDOASSIGN_CAUSAL_ID, GEOGRAP_LOCATION_ID,
                CREDIT_LIMIT, CREDIT_LIMIT_COVERED, CUST_CARE_REQUES_NUM, VALUE_TO_DEBIT, TAG_NAME,
                ORGANIZAT_AREA_ID, COMMERCIAL_PLAN_ID, PERMANENCE, COMPANY_ID, INCLUDED_FEATURES_ID,
                RECEPTION_TYPE_ID, CAUSAL_ID, ASSIGNED_PERSON_ID, ANSWER_ID, CATEGORY_ID,
                SUBCATEGORY_ID, IS_IMMEDIATE_ATTENT, ELEMENT_POSITION)
		VALUES (numotive_id,'N','N','N','N','N','N',Null,Null,sysdate,100,sysdate,Null,Null,sysdate,Null,sysdate,Null,'N',Null,
                Null,TBL_DATOS(NUINDICE).PRODUCTO,100005,-1,Null,Null,Null,TBL_DATOS(NUINDICE).PRODUCTO,7,7014,11,TBL_DATOS(NUINDICE).CONTRATO,
                nupackage_id,Null,null,Null,Null,nupackage_id,Null,'M_GENER_SUSPEVOL',Null,Null,0,Null,Null,Null,TBL_DATOS(NUINDICE).CAUSAL_ID,
                Null,Null,1,4,'Y',Null);
		
			EXCEPTION
	                  WHEN OTHERS  THEN
	                  BEGIN
	                     verror := 'Error en la Suspension Paso 7: '||sbdocumento ||' -'|| SQLERRM;
	                     nuErrores := nuErrores + 1;
	                   PKLOG_MIGRACION.prInsLogMigra (193,193,2,'PR_SUSPASOCIADOS_ROLLOUT',0,0,'Error: '||verror,to_char(sqlcode),nuLogError);
	                END;
		END;
			  
                BEGIN
                  
                --- Inserta en la tabla OR_ORDER_ACTIVITY
                INSERT /*+ APPEND */ INTO OR_ORDER_ACTIVITY(ORDER_ACTIVITY_ID, ORDER_ITEM_ID, ORDER_ID, STATUS, TASK_TYPE_ID, PACKAGE_ID,MOTIVE_ID, COMPONENT_ID,INSTANCE_ID, ADDRESS_ID,
							ELEMENT_ID, SUBSCRIBER_ID, SUBSCRIPTION_ID, PRODUCT_ID, OPERATING_SECTOR_ID, EXEC_ESTIMATE_DATE, OPERATING_UNIT_ID, COMMENT_, PROCESS_ID, ACTIVITY_ID, 
							ORIGIN_ACTIVITY_ID, ACTIVITY_GROUP_ID, SEQUENCE_, REGISTER_DATE, FINAL_DATE, VALUE1, VALUE2, VALUE3, VALUE4, COMPENSATED, ORDER_TEMPLATE_ID, 
							CONSECUTIVE, SERIAL_ITEMS_ID, LEGALIZE_TRY_TIMES, WF_TAG_NAME, VALUE_REFERENCE)
						VALUES (nuOracti, NULL, NUORDER_ID, 'F', TBL_DATOS(NUINDICE).TIPOTRAB, nupackage_id, NULL, NULL, NULL, NUDIRECCION, NULL, TBL_DATOS(NUINDICE).CLIENTE, 
						        TBL_DATOS(NUINDICE).CONTRATO, TBL_DATOS(NUINDICE).PRODUCTO, NULL, NULL, NULL, NULL, NULL, TBL_DATOS(NUINDICE).ACTIVIDAD, NULL, NULL,NULL, 
							TBL_DATOS(NUINDICE).CREATED_DATE, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

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
					  VALUES (NUORDER_ID, NULL, NULL, NULL,NULL,NULL,NULL,NULL, NULL,NULL,NULL,TBL_DATOS(NUINDICE).CONTRATO,
						  TBL_DATOS(NUINDICE).CONTRATO,NULL, TBL_DATOS(NUINDICE).CONTRATO, nuCliente, NULL, NULL, NULL, NULL, 
						  NULL, NUDIRECCION);
                COMMIT;

			EXCEPTION
	                  WHEN OTHERS  THEN
	                  BEGIN
	                     verror := 'Error en la Suspension Paso 4: '||sbdocumento|| ' - ' ||SQLCODE ||' -'|| SQLERRM;
	                     nuErrores := nuErrores + 1;
	                    PKLOG_MIGRACION.prInsLogMigra (193,193,2,'PR_SUSPASOCIADOS_ROLLOUT',0,0,'Error: '||verror,to_char(sqlcode),nuLogError);
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
	                 PKLOG_MIGRACION.prInsLogMigra (193,193,2,'PR_SUSPASOCIADOS_ROLLOUT',0,0,'Error: '||verror,to_char(sqlcode),nuLogError);
	                END;
		END;

        COMMIT;
            vcontIns := vcontIns +1;

		EXCEPTION
			WHEN OTHERS  THEN
			BEGIN
			verror := 'Error en la Suspension paso 6: '||sbdocumento|| ' - ' ||SQLCODE ||' -'|| SQLERRM;

			nuErrores := nuErrores + 1;
			PKLOG_MIGRACION.prInsLogMigra (193,193,2,'PR_SUSPASOCIADOS_ROLLOUT',0,0,'Error: '||verror,to_char(sqlcode),nuLogError);
		END;
        END;
      END LOOP;

      EXIT WHEN cuSuspinst%NOTFOUND;

   END LOOP;

    -- Cierra CURSOR.
   IF (cuSuspinst%ISOPEN)
   THEN
      --{
      CLOSE cuSuspinst;
   --}
   END IF;

  -- Termina Log
  PKLOG_MIGRACION.prInsLogMigra (193,193,3,'PR_SUSPASOCIADOS_ROLLOUT',vcontIns,nuErrores,'TERMINO PROCESO #regs: '||vcontIns,'FIN',nuLogError);
  
  UPDATE MIGR_RANGO_PROCESOS SET RAPRFEFI = SYSDATE, RAPRTERM = 'T' where RAPRCODI = 193 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
  COMMIT;

EXCEPTION
   WHEN OTHERS THEN
    PKLOG_MIGRACION.prInsLogMigra (193,193,2,'PR_SUSPASOCIADOS_ROLLOUT',0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);

END PR_SUSPASOCIADOS_ROLLOUT; 
/
