CREATE OR REPLACE PROCEDURE   PR_CERTIFICACION_ROLLOUT (nuInicio number, nuFinal number, nuBD number)  AS
/*******************************************************************
 PROGRAMA    	:	PR_CERTIFICACION_ROLLOUT
 FECHA		:	20/06/2014
 AUTOR		:	OLSoftware
 DESCRIPCION	:	Migra la informacion de ordenes de Certificacion de PRP cerradas
 HISTORIA DE MODIFICACIONES
      AUTOR	   FECHA	DESCRIPCION
Jennifer Giraldo 19/09/2014  Se modifica programa ya que RP modifico las homologaciones
 *******************************************************************/ 
 
   vcontLec       	NUMBER := 0;
   verror              	VARCHAR2 (2000);
   SBDOCUMENTO         	VARCHAR2(30) := NULL;
   SQPACKAGE      	NUMBER := NULL;
   NUORDER_ID     	NUMBER := NULL;
   NUDIRECCION    	NUMBER := NULL;
   NUORACTI       	NUMBER := NULL;
   VFECHA         	DATE;
   NUORDEN        	VARCHAR2(2000) := null;
   nuComplementoPR   	number;
   nuComplementoSU   	number;
   nuComplementoFA   	number;
   nuComplementoCU   	number;
   nuComplementoDI  	number;
   
   -- DECLARACION DE CURSORES. TABLA QUE SE QUIERE BORRAR.

   CURSOR cu_datos IS
    select  /*+ parallel */
	A.SUSCCODI SUSCCODISFMA,
	A.SUSCIDDI,
	A.SUSCCLIE,
	C.GEOGRAP_LOCATION_ID LOCAHOMO,
	B.SESUNUSE+nuComplementoPR PRODUCTO,
	B.SESUSUSC+nuComplementoSU SUBSCRIPTION_ID,
	B.*
    from SUSCRIPC A , LDC_TEMP_SERVSUSC_SGE B, AB_ADDRESS C
   where A.SUSCCODI - nuComplementoSU = B.SESUSUSC
     and B.SESUSUSC >= nuInicio
     and B.SESUSUSC < nuFinal
     and B.BASEDATO = nuBD     
     and A.SUSCIDDI = C.ADDRESS_ID
     and ((nuBD = 5 AND B.SESUSERV IN (1,6)) OR (nuBD <> 5 AND B.SESUSERV = 1))
     --and B.SESUSERV  = 1
     and B.SESUCAES = 'N'
     and B.SESUNUSE IN (6139035,6138265);
     
   CURSOR CUHISTOPRP(nuSusc3 number) IS
	SELECT /*+ parallel */
	        A.ORTRNUME  NUME_ORDEN,
	        A.ORTRFEEL  REPROGRAM_LAST_DATE,
	        A.ORTRFEEL  CREATED_DATE,
	        A.ORTRFEEJ  EXECUTION_FINAL_DATE,
	        A.ORTRFEPE  EXEC_ESTIMATE_DATE,
	        A.ORTRFELE  LEGALIZATION_DATE,
	        A.ORTRFEAS  ASSIGNED_DATE,
	        A.ORTRTITR  TRABGASP,
	        D.TRABHOMO  TRABHOMO,
	        D.ACTIHOMO  ACTIVIDAD,
	        A.BASEDATO  BASEDATO,
	        E.TIPOSOLI SOLICITUD,
		    E.CAUSLEGA CAUSAL_ID,
	        F.TAG_NAME TAG_NAME,
	        SUBSTR ((A.ORTRSUSC||' '||A.ORTROBSE),1,500)||' '||SUBSTR((A.ORTROBS2),1,1500) OBSERVACION,
	        'DATOS_ORDEN_GASPLUS : ['||A.ORTRDENU||'-'||A.ORTRLONU||'-'||A.ORTRNUME||' ORTRTITR:'||H.PARATRGP||' ORTRCUAD:'||A.ORTRCUAD||']'  DATOSORDEN
	FROM MIGRA.LDC_TEMP_ORDEPRP_SGE A, LDC_MIG_TIPOTRAB D, MIGRA.LDC_MIG_TIPOSOLI E, PS_PACKAGE_TYPE F, LDC_MIG_PARATIPO H
	WHERE A.BASEDATO = nuBD
	AND A.ORTRTITR = H.PARATITA
	AND H.PARACODI = 'CERTIFICACIONES_RP'
	AND A.ORTRTITR = D.ORTRTITR
	AND A.BASEDATO = D.BASEDATO
	AND A.ORTRTITR = E.TIPOTRAB
	AND A.BASEDATO = E.BASEDATO
	AND F.PACKAGE_TYPE_ID = E.TIPOSOLI
	AND A.ORTRSUSC = nuSusc3 - nuComplementoSU; --317203  Filas
      
    cursor cursorDatoMigrado(nuSusc2 number) is
    select count(*) from PR_CERTIFICATE a,pr_product b
        where a.product_id =b.product_id 
        and b.PRODUCT_TYPE_ID= 7014
        and b.product_id  =nuSusc2;
  
   rgHistoprp cuHistoprp%rowtype;   
         
    nuBarrio number(15) := 0;
   --
   -- DECLARACION DE TIPOS.
   --
   TYPE tipo_cu_datos IS TABLE OF cu_datos%ROWTYPE;

   --
   -- DECLARACION DE TABLAS TIPOS.
   --
   tbl_datos      tipo_cu_datos := tipo_cu_datos ();
   
   nuLogError NUMBER;
   nuTotalRegs number := 0;
   nuErrores number := 0;
   nuCantidadMigrado number := 0;
  -- sbExiste varchar2(2);
   nuMotiveId NUMBER;
   dtFechaCertificacion DATE;
   nuTaskType number;
   nuActividad number;
   sbOrden1 varchar2(2000);
   sbOrden2 varchar2(2000);
   sw       number;
   
BEGIN

  -- Inserta registro de inicio en el log
  PKLOG_MIGRACION.prInsLogMigra (232,232,1,'PR_CERTIFICACION',0,0,'Inicia Proceso','INICIO',nuLogError);
  
  UPDATE MIGRA.MIGR_RANGO_PROCESOS SET RAPRFEIN = SYSDATE, RAPRTERM = 'P' where RAPRCODI = 232 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
   COMMIT;

  PKG_CONSTANTES.COMPLEMENTO(nuBD,nuComplementoPR,nuComplementoSU,nuComplementoFA,nuComplementoCU,nuComplementoDI);

   -- Abre CURSOR.
   OPEN cu_datos;
   LOOP
      --
      -- Borrar tablas PL.
      --
      tbl_datos.delete;

      -- Cargar registros.
      --
      FETCH cu_datos
      BULK COLLECT INTO tbl_datos
      LIMIT 1000;

      FOR nuindice IN 1 .. tbl_datos.COUNT
      LOOP
		BEGIN
		 
			-- Validacion migro dato anteriormente
			nuCantidadMigrado :=0;
			VCONTLEC := VCONTLEC + 1;
				    
			open cursorDatoMigrado(TBL_DATOS(nuindice).PRODUCTO);
			fetch cursorDatoMigrado into nuCantidadMigrado;
			close cursorDatoMigrado;
			
			dtFechaCertificacion := null;
            		
			if(nuCantidadMigrado = 0) then
      
      sw := 0;
      
			OPEN CUHISTOPRP(TBL_DATOS(NUINDICE).susccodiSfma);
			FETCH CUHISTOPRP INTO rgHistoprp;
			
      IF CUHISTOPRP%FOUND THEN
            sw := 1;
          END IF;
	  
          CLOSE cuhistoprp;
	  
          IF sw = 1 then
			
					SQPACKAGE := SEQ_MO_PACKAGES.NEXTVAL;
					NUORDER_ID := SEQ_OR_ORDER.NEXTVAL;
					nuOracti :=  SEQ_OR_ORDER_ACTIVITY.nextval;
					NUdIRECCION :=TBL_DATOS(NUINDICE).SUSCIDDI;
					nuMotiveId := SEQ_MO_MOTIVE.NEXTVAL;
					SBDOCUMENTO := TBL_DATOS(NUINDICE).SUBSCRIPTION_ID||'-'||rgHistoprp.NUME_ORDEN;
					
		           
					dtFechaCertificacion := NVL(TBL_DATOS(NUINDICE).SESUFERE,TBL_DATOS(NUINDICE).SESUFEIN);
				
				        nuTaskType := rgHistoprp.TRABHOMO;
				        nuActividad := rgHistoprp.ACTIVIDAD;--FNUACTIVIDADOSF_ROLLOUT(rgServsusc.sesucate,rgHistoprp.TRABGASP,rgHistoprp.TRABHOMO,rgHistoprp.BASEDATO);
				          
				        sbOrden1 := rgHistoprp.OBSERVACION;
				        sbOrden2 := rgHistoprp.DATOSORDEN;
				
				BEGIN
					INSERT /*+ APPEND */ INTO OR_ORDER (ORDER_ID, PRIOR_ORDER_ID, NUMERATOR_ID, SEQUENCE, PRIORITY, EXTERNAL_ADDRESS_ID,
									CREATED_DATE, EXEC_INITIAL_DATE, EXECUTION_FINAL_DATE, EXEC_ESTIMATE_DATE, ARRANGED_HOUR,
									LEGALIZATION_DATE, REPROGRAM_LAST_DATE, ASSIGNED_DATE, ASSIGNED_WITH, MAX_DATE_TO_LEGALIZE, 
									ORDER_VALUE, PRINTING_TIME_NUMBER, LEGALIZE_TRY_TIMES, OPERATING_UNIT_ID, ORDER_STATUS_ID, 
									TASK_TYPE_ID, OPERATING_SECTOR_ID, CAUSAL_ID, ADMINIST_DISTRIB_ID, ORDER_CLASSIF_ID, 
									GEOGRAP_LOCATION_ID, IS_COUNTERMAND, REAL_TASK_TYPE_ID, SAVED_DATA_VALUES, FOR_AUTOMATIC_LEGA,
									ORDER_COST_AVERAGE, ORDER_COST_BY_LIST, OPERATIVE_AIU_VALUE, ADMIN_AIU_VALUE, CHARGE_STATUS,
									PREV_ORDER_STATUS_ID, PROGRAMING_CLASS_ID, PREVIOUS_WORK, APPOINTMENT_CONFIRM, X, Y,
									STAGE_ID, LEGAL_IN_PROJECT, OFFERED, ASSO_UNIT_ID, SUBSCRIBER_ID, ADM_PENDING, SHAPE,
									ROUTE_ID, CONSECUTIVE, DEFINED_CONTRACT_ID, IS_PENDING_LIQ)
							   VALUES (NUORDER_ID, NULL, NULL, NULL, 99, NUDIRECCION, dtFechaCertificacion, NULL, dtFechaCertificacion, 
								  dtFechaCertificacion, NULL, dtFechaCertificacion, dtFechaCertificacion,  dtFechaCertificacion,
								  NULL, NULL, NULL, NULL, NULL, 1, 8, nuTaskType, NULL, rgHistoprp.CAUSAL_ID, NULL, NULL, 
								  TBL_DATOS(NUINDICE).LOCAHOMO,'N', nuTaskType, NULL, NULL, 0, 0, 0, 0, 1, NULL, NULL, NULL, NULL,NULL,
								  NULL, NULL, NULL, NULL, NULL,TBL_DATOS(NUINDICE).suscclie, NULL, NULL, NULL, NULL, NULL, NULL);
					COMMIT;
						EXCEPTION
						  WHEN OTHERS  THEN
						  BEGIN
							 verror := 'Error en la certificacion Paso 1: '||sbdocumento||' -'||'[ nuSusc:'||TBL_DATOS(NUINDICE).SESUSUSC||', BaseDato:'||tbl_datos(NUINDICE).BASEDATO||']'||SQLERRM;
							 nuErrores := nuErrores + 1;
							PKLOG_MIGRACION.prInsLogMigra (232,232,2,'PR_CERTIFICACION_ROLLOUT',0,0,'Error1: suscriptor ::'||TBL_DATOS(NUINDICE).SESUSUSC||':: '||sqlerrm,to_char(sqlcode),nuLogError);
						END;
				END;

				BEGIN
				        INSERT /*+ APPEND */ INTO MO_PACKAGES (PACKAGE_ID, REQUEST_DATE, MESSAG_DELIVERY_DATE, USER_ID, TERMINAL_ID, CLIENT_PRIVACY_FLAG, PACKAGE_TYPE_ID, 
								          MOTIVE_STATUS_ID, SUBSCRIBER_ID, ATTENTION_DATE, COMM_EXCEPTION, CUST_CARE_REQUES_NUM, COMPANY_ID, ORDER_ID, 
								          TAG_NAME, LIQUIDATION_METHOD,RECEPTION_TYPE_ID)
								  VALUES(SQPACKAGE, dtFechaCertificacion, dtFechaCertificacion, 'MIGRA', 'MIGRACION','N', rgHistoprp.SOLICITUD, 14, TBL_DATOS(NUINDICE).suscclie,
							                dtFechaCertificacion,'N', SQPACKAGE, 99, NUORDER_ID,rgHistoprp.TAG_NAME, 2,10);
					COMMIT;          
						EXCEPTION
						  WHEN OTHERS  THEN
						  BEGIN
							 verror := 'Error en la certificacion Paso 2: '||sbdocumento||' -'||'[ nuSusc:'||TBL_DATOS(NUINDICE).SESUSUSC||', BaseDato:'||tbl_datos(NUINDICE).BASEDATO||']'||SQLERRM;
							 nuErrores := nuErrores + 1;
							PKLOG_MIGRACION.prInsLogMigra (232,232,2,'PR_CERTIFICACION_ROLLOUT',0,0,'Error2: suscriptor ::'||TBL_DATOS(NUINDICE).SESUSUSC||':: '||sqlerrm,to_char(sqlcode),nuLogError);
						END;
				END;
	      
	      
				BEGIN
					INSERT INTO MO_MOTIVE (MOTIVE_ID, PRIVACY_FLAG, CLIENT_PRIVACY_FLAG, PROVISIONAL_FLAG, IS_MULT_PRODUCT_FLAG, AUTHORIZ_LETTER_FLAG,
								PARTIAL_FLAG, PROV_INITIAL_DATE, PROV_FINAL_DATE, INITIAL_PROCESS_DATE, PRIORITY, MOTIV_RECORDING_DATE, ESTIMATED_INST_DATE,
								ASSIGN_DATE, ATTENTION_DATE, ANNUL_DATE, STATUS_CHANGE_DATE, STUDY_NUM_TRANSFEREN, CUSTOM_DECISION_FLAG, EXECUTION_MAX_DATE,
								STANDARD_TIME, SERVICE_NUMBER, PRODUCT_MOTIVE_ID, DISTRIBUT_ADMIN_ID, DISTRICT_ID, BUILDING_ID, ANNUL_CAUSAL_ID, PRODUCT_ID,
								MOTIVE_TYPE_ID, PRODUCT_TYPE_ID, MOTIVE_STATUS_ID, SUBSCRIPTION_ID, PACKAGE_ID, UNDOASSIGN_CAUSAL_ID, GEOGRAP_LOCATION_ID,
								CREDIT_LIMIT, CREDIT_LIMIT_COVERED, CUST_CARE_REQUES_NUM, VALUE_TO_DEBIT, TAG_NAME, ORGANIZAT_AREA_ID, COMMERCIAL_PLAN_ID,
								PERMANENCE, COMPANY_ID, INCLUDED_FEATURES_ID, RECEPTION_TYPE_ID, CAUSAL_ID, ASSIGNED_PERSON_ID, ANSWER_ID, CATEGORY_ID,
								SUBCATEGORY_ID, IS_IMMEDIATE_ATTENT, ELEMENT_POSITION)
							VALUES (nuMotiveId,'N','N','N','N','N','N',Null,Null,Null,100,SYSDATE,Null,Null,Null,Null,Null,Null,'N',SYSDATE,0,TBL_DATOS(NUINDICE).PRODUCTO,24,
							Null,Null,Null,Null,TBL_DATOS(NUINDICE).PRODUCTO,13,7014,11,TBL_DATOS(NUINDICE).SUBSCRIPTION_ID,SQPACKAGE,Null,Null,Null,Null,SQPACKAGE,
							Null,'M_REVISION_PERIODICA_24',Null,4,Null,99,Null,Null,Null,Null,Null,null,null,'Y',Null);
					COMMIT;    
						EXCEPTION
						  WHEN OTHERS  THEN
						  BEGIN
							 verror := 'Error en la certificacion Paso 3: '||sbdocumento||' -'||'[ nuSusc:'||TBL_DATOS(NUINDICE).SESUSUSC||', BaseDato:'||tbl_datos(NUINDICE).BASEDATO||']'||SQLERRM;
							 nuErrores := nuErrores + 1;
						PKLOG_MIGRACION.prInsLogMigra (232,232,2,'PR_CERTIFICACION_ROLLOUT',0,0,'Error3: suscriptor ::'||TBL_DATOS(NUINDICE).SESUSUSC||':: '||sqlerrm,to_char(sqlcode),nuLogError);
						END;
				END; 
	      
				BEGIN
					INSERT /*+ APPEND */ INTO OR_ORDER_ACTIVITY (ORDER_ACTIVITY_ID, ORDER_ITEM_ID, ORDER_ID, STATUS, TASK_TYPE_ID, PACKAGE_ID,
										MOTIVE_ID, COMPONENT_ID, INSTANCE_ID, ADDRESS_ID, ELEMENT_ID, SUBSCRIBER_ID, SUBSCRIPTION_ID, PRODUCT_ID,
										OPERATING_SECTOR_ID, EXEC_ESTIMATE_DATE, OPERATING_UNIT_ID, COMMENT_, PROCESS_ID, ACTIVITY_ID, ORIGIN_ACTIVITY_ID,
										ACTIVITY_GROUP_ID, SEQUENCE_, REGISTER_DATE, FINAL_DATE, VALUE1, VALUE2, VALUE3, VALUE4, COMPENSATED,
										ORDER_TEMPLATE_ID, CONSECUTIVE, SERIAL_ITEMS_ID, LEGALIZE_TRY_TIMES, WF_TAG_NAME, VALUE_REFERENCE)
						                        VALUES (NUORACTI, NULL, NUORDER_ID, 'F', nuTaskType, SQPACKAGE, NULL, NULL, NULL, NUDIRECCION, NULL, TBL_DATOS(NUINDICE).SUSCCLIE,
						                        TBL_DATOS(NUINDICE).SUBSCRIPTION_ID, TBL_DATOS(NUINDICE).PRODUCTO, NULL, NULL, NULL, NULL, NULL, nuActividad,-- NULL,
						                        NULL, NULL, NULL, dtFechaCertificacion, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
					COMMIT;
						EXCEPTION
						  WHEN OTHERS  THEN
						  BEGIN
							 verror := 'Error en la certificacion Paso 4: '||sbdocumento||' -'||'[ nuSusc:'||TBL_DATOS(NUINDICE).SESUSUSC||', BaseDato:'||tbl_datos(NUINDICE).BASEDATO||']'||SQLERRM;
							 nuErrores := nuErrores + 1;
						PKLOG_MIGRACION.prInsLogMigra (232,232,2,'PR_CERTIFICACION_ROLLOUT',0,0,'Error4: suscriptor ::'||TBL_DATOS(NUINDICE).SESUSUSC||':: '||sqlerrm,to_char(sqlcode),nuLogError);
						END;
				END;
						
				BEGIN
						
				NUORDEN := sbOrden1;
												
					INSERT /*+ APPEND */ INTO OR_ORDER_COMMENT (ORDER_COMMENT_ID, ORDER_COMMENT, ORDER_ID, COMMENT_TYPE_ID,
									         REGISTER_DATE, LEGALIZE_COMMENT, PERSON_ID)
									VALUES (SEQ_OR_ORDER_COMMENT.NEXTVAL, NUORDEN, NUORDER_ID, 1277, NULL, 'Y', NULL);
					COMMIT;
						EXCEPTION
				                  WHEN OTHERS  THEN
				                  BEGIN
				                     verror := 'Error en la certificacion Paso 5: '||sbdocumento||' -'||'[ nuSusc:'||TBL_DATOS(NUINDICE).SESUSUSC||', BaseDato:'||tbl_datos(NUINDICE).BASEDATO||']'||SQLERRM;
							 nuErrores := nuErrores + 1;
							PKLOG_MIGRACION.prInsLogMigra (232,232,2,'PR_CERTIFICACION_ROLLOUT',0,0,'Error5: suscriptor ::'||TBL_DATOS(NUINDICE).SESUSUSC||':: '||sqlerrm,to_char(sqlcode),nuLogError);
						END;
				END; 
						
				BEGIN
						
				NUORDEN := sbOrden2;
												
					INSERT /*+ APPEND */ INTO OR_ORDER_COMMENT (ORDER_COMMENT_ID, ORDER_COMMENT, ORDER_ID, COMMENT_TYPE_ID,
										REGISTER_DATE, LEGALIZE_COMMENT, PERSON_ID)
									VALUES (SEQ_OR_ORDER_COMMENT.NEXTVAL, NUORDEN, NUORDER_ID, 1277, NULL, 'Y', NULL);
					COMMIT;
						EXCEPTION
				                  WHEN OTHERS  THEN
				                  BEGIN
				                     verror := 'Error en la certificacion Paso 6: '||sbdocumento||' -'||'[ nuSusc:'||TBL_DATOS(NUINDICE).SESUSUSC||', BaseDato:'||tbl_datos(NUINDICE).BASEDATO||']'||SQLERRM;
							nuErrores := nuErrores + 1;
							PKLOG_MIGRACION.prInsLogMigra (232,232,2,'PR_CERTIFICACION_ROLLOUT',0,0,'Error6: suscriptor ::'||TBL_DATOS(NUINDICE).SESUSUSC||':: '||sqlerrm,to_char(sqlcode),nuLogError);
						END;
				END; 	      
						
				BEGIN
	     
					INSERT INTO OR_EXTERN_SYSTEMS_ID (ORDER_ID, EXTERN_SYSTEM_ID, EXTE_SYST_TYPE_ID, FATHE_EXTER_SYSTE_ID, FAT_EXT_SYS_TYP_ID,
									EXTERN_ENTITY_ID, FATHER_EXT_ENTITY_ID, EXT_SYS_TYP_ENT_ID, FAT_EX_SYS_TY_ENT_ID, MOTIVE_CREATION_DATE,
									IM_ASSIG_PROCESS_ID, SERVICE_NUMBER, PRODUCT_ID, DAMAGE_ID, SUBSCRIPTION_ID, SUBSCRIBER_ID, SUBSCRIBER_NAME,
									PACKAGE_ID, PACKAGE_TYPE_ID, RUSECONS, CORSCOPR, ADDRESS_ID)
							VALUES (NUORDER_ID, NULL, NULL, NULL,NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, TBL_DATOS(NUINDICE).PRODUCTO, 
							        NULL, TBL_DATOS(NUINDICE).PRODUCTO, TBL_DATOS(NUINDICE).SUSCCLIE, NULL, SQPACKAGE, NULL, NULL, NULL,NUdIRECCION);
					COMMIT;
						EXCEPTION
						  WHEN OTHERS  THEN
						  BEGIN
							 verror := 'Error en la certificacion Paso 7: '||sbdocumento||' -'||'[ nuSusc:'||TBL_DATOS(NUINDICE).SESUSUSC||', BaseDato:'||tbl_datos(NUINDICE).BASEDATO||']'||SQLERRM;
							 nuErrores := nuErrores + 1;
						PKLOG_MIGRACION.prInsLogMigra (232,232,2,'PR_CERTIFICACION_ROLLOUT',0,0,'Error7: suscriptor ::'||TBL_DATOS(NUINDICE).SESUSUSC||':: '||sqlerrm,to_char(sqlcode),nuLogError);
						END;
				END;
	    
				BEGIN		
				
					IF ADD_MONTHS(dtFechaCertificacion,60) > SYSDATE THEN
					vfecha := null;
					ELSE
					VFECHA := ADD_MONTHS(dtFechaCertificacion,60);
					END IF; 
					   
					INSERT INTO PR_CERTIFICATE (CERTIFICATE_ID, PRODUCT_ID, PACKAGE_ID, ORDER_ACT_CERTIF_ID, ORDER_ACT_CANCEL_ID, REGISTER_DATE,
								REVIEW_DATE, ESTIMATED_END_DATE, END_DATE, ORDER_ACT_REVIEW_ID)
							VALUES (SEQ_PR_CERTIFICATE_156806.NEXTVAL,TBL_DATOS(NUINDICE).PRODUCTO, SQPACKAGE,NUORACTI, NULL, 
								dtFechaCertificacion, dtFechaCertificacion, ADD_MONTHS(dtFechaCertificacion,60), VFECHA,NUORACTI);          
					COMMIT;
						EXCEPTION
						WHEN OTHERS  THEN
						BEGIN
						    verror := 'Error en la certificacion Paso 8: '||sbdocumento||' -'||'[ nuSusc:'||TBL_DATOS(NUINDICE).SESUSUSC||', BaseDato:'||tbl_datos(NUINDICE).BASEDATO||']'||SQLERRM;
						    nuErrores := nuErrores + 1;
						    PKLOG_MIGRACION.prInsLogMigra (232,232,2,'PR_CERTIFICACION_ROLLOUT',0,0,'Error8: suscriptor ::'||TBL_DATOS(NUINDICE).SESUSUSC||':: '||sqlerrm,to_char(sqlcode),nuLogError);
						END;
				END;
				
			END IF;
    
    END IF;
			
			nuTotalRegs := nuTotalRegs + 1;     
			 EXCEPTION
				WHEN OTHERS
				THEN
        
		          -- Cierra CURSOR CUHISTOPRP.
		           IF (CUHISTOPRP%ISOPEN)
		           THEN
		              CLOSE CUHISTOPRP;
		           END IF;
           
				   nuErrores := nuErrores + 1;
				   PKLOG_MIGRACION.prInsLogMigra (232,232,2,'PR_CERTIFICACION_ROLLOUT',0,0,'Error9: suscriptor ::'||TBL_DATOS(NUINDICE).SESUSUSC||'::'||sqlerrm,to_char(sqlcode),nuLogError);
		END;
    
	END LOOP;
          
	COMMIT;          
 
      EXIT WHEN cu_datos%NOTFOUND;

   END LOOP;
   -- Cierra CURSOR.
   IF (cu_datos%ISOPEN)
   THEN
      CLOSE cu_datos;
   END IF;
		
 -- Termina Log
   PKLOG_MIGRACION.prInsLogMigra (232,232,3,'PR_CERTIFICACION_ROLLOUT',nuTotalRegs,nuErrores,'TERMINO PROCESO #regs: '||nuTotalRegs,'FIN',nuLogError);

   UPDATE MIGRA.MIGR_RANGO_PROCESOS SET RAPRFEFI = SYSDATE, RAPRTERM = 'T' where RAPRCODI = 232 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
   COMMIT;
   
EXCEPTION
   WHEN OTHERS
   THEN
    -- Cierra CURSOR.
   IF (cu_datos%ISOPEN)
   THEN
      CLOSE cu_datos;
   END IF;
   
      PKLOG_MIGRACION.prInsLogMigra (232,232,2,'PR_CERTIFICACION_ROLLOUT',0,0,'Error10: '||sqlerrm,to_char(sqlcode),nuLogError); 

END PR_CERTIFICACION_ROLLOUT;
/
