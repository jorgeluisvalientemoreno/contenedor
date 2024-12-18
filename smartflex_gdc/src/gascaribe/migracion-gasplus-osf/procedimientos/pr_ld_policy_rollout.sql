CREATE OR REPLACE PROCEDURE   PR_LD_POLICY_ROLLOUT (nuInicio number, nuFinal number, nuBD number) AS
/*******************************************************************
 PROGRAMA    	:	PR_LD_POLICY_ROLLOUT
 FECHA		:	04/07/2014
 AUTOR		:	OLSoftware
 DESCRIPCION	:	Migra la informacion de polizas
 HISTORIA DE MODIFICACIONES
 AUTOR	   FECHA	DESCRIPCION

 *******************************************************************/
   NUERRORCODE       NUMBER;
   sbErrorMessage    VARCHAR2 (4000);
   verror            VARCHAR2 (4000);
   nuREg             NUMBER := 0;
   vcontLec          NUMBER := 0;
   vcontIns          NUMBER := 0;
   nuSuscriptor      NUMBER := 0;
   NUCODIGO          NUMBER := 0;
   sbNombre          Ge_Subscriber.SUBSCRIBER_NAME%type;
   sbApellido1       Ge_Subscriber.SUBS_LAST_NAME%type;
   sbApellido2       GE_SUBSCRIBER.SUBS_SECOND_LAST_NAME%TYPE;
   NUPOLIZA          NUMBER := 0;
   nuAtencion        NUMBER := 0;
   nuComplementoPR   NUMBER;
   nuComplementoSU   NUMBER;
   nuComplementoFA   NUMBER;
   nuComplementoCU   NUMBER;
   nuComplementoDI   NUMBER;
   nusubs_id         NUMBER := 0;

   cursor cuDatos
       is
   SELECT CASE
            WHEN A.BASEDATO IN (1,4,5) THEN A.POSUCODI 
            WHEN A.BASEDATO = 2 THEN A.POSUCODI + 5000000 
            WHEN A.BASEDATO = 3 THEN A.POSUCODI + 6000000
          END  POLICY_ID,
	  A.POSUNUMB POLICY_NUMBER,
          A.POSUESPO STATE_POLICY,
          NULL LAUNCH_POLICY,
          A.POSUCOAS CONTRATIST_CODE,
          A.POSULIPR PRODUCT_LINE_ID,
          A.POSUFEDI DT_IN_POLICY,
          A.POSUFEFI DT_EN_POLICY,
          A.POSUVAPO VALUE_POLICY,
          A.POSUVAPM PREM_POLICY,
          A.POSUNOMB NOMBRE,
          A.POSUAPEL APELLIDO,
          A.POSUSUSC+nuComplementoSU SUSCRIPTION_ID,
          A.POSUNUSE+nuComplementoPR PRODUCT_ID,
          A.POSUNICE IDENTIFICATION_ID,
          A.POSUPEFA PERIOD_POLICY,
          A.POSUANO YEAR_POLICY,
          A.POSUMES MONTH_POLICY,
          E.DIFECODI DEFERRED_POLICY_ID,
          A.POSUFECR DTCREATE_POLICY,
          A.POSUNUCU SHARE_POLICY,
          NULL DTRET_POLICY,
          NULL VALUEACR_POLICY,
          A.POSUREIN REPORT_POLICY,
          A.POSUFERI DT_REPORT_POLICY,
          NVL(A.POSUFERE,to_date('1995/01/01','yyyy/mm/dd')) DT_INSURED_POLICY,
          NULL PER_REPORT_POLICY,
          C.TIPOHOMO POLICY_TYPE_ID,
          NULL ID_REPORT_POLICY, --se modifica por solicitud de Julia de GDCA
          NULL CANCEL_CAUSAL_ID,
          NULL FEES_TO_RETURN,
          CASE
            WHEN A.BASEDATO IN (1,2,3) THEN 'POLIZA MIGRADA, POLIPOAS: ['||A.POSUPOAS||']' 
            WHEN A.BASEDATO = 4 THEN 'POLIZA MIGRADA, POLIPOAS: ['||A.POSUPOAS||'] '
            WHEN A.BASEDATO = 5 THEN DECODE (A.POSULIPR,62,'POLIZA MIGRADA, POLICEDU: ['||A.POSUNICE||']',63,'POLIZA MIGRADA, POLICOAS: ['||A.POSUCODI||']')
          END  COMMENTS,
          A.POSUEXQU POLICY_EXQ,
          NULL NUMBER_ACTA,
          B.COLOHOMO GEOGRAP_LOCATION_ID,
          F.VALIDITY_POLICY_TYPE_ID VALIDITY_POLICY_TYPE_ID,
	  A.POSUCOLE COLLECTIVE_NUMBER
       FROM MIGRA.LDC_TEMP_POLISUSC_SGE A, LDC_MIG_LOCALIDAD B, LDC_MIG_TIPOPOLI C, LDC_TEMP_SERVSUSC_SGE D, DIFERIDO E, LD_VALIDITY_POLICY_TYPE F
      WHERE A.POSUDEPA = B.CODIDEPA
        AND A.POSULOCA = B.CODILOCA
        AND A.POSUSUSC >= nuInicio
        AND A.POSUSUSC <  nuFinal
        AND A.BASEDATO = nuBD
        AND A.POSUPRLI = C.TIPOCODI
        AND A.POSUASEG = C.TIPOCUAD --LA HOMOLOGACION SE HACE POR POSUPRLI Y LA ASEGURADORA
        AND A.BASEDATO = C.BASEDATO
        AND A.POSUNUSE = D.SESUNUSE
	AND A.BASEDATO = D.BASEDATO
        AND A.POSUNUSE+nuComplementoPR = E.DIFENUSE 
        AND A.POSUDIFE+nucomplementoDI = E.DIFECODI
        AND F.POLICY_TYPE_ID = C.TIPOHOMO;

      CURSOR CUGESUBS (nuSusc number) IS
      SELECT  *
        FROM GE_SUBSCRIBER
       WHERE SUBSCRIBER_ID = nuSusc;

   --RGPOLIZA  CUPOLIZA%ROWTYPE;
   rgCliente  CUGESUBS%rowtype;

   -- DECLARACION DE TIPOS.
   TYPE tipo_cu_datos IS TABLE OF cuDatos%ROWTYPE;

   -- DECLARACION DE TABLAS TIPOS.
   tbl_datos      tipo_cu_datos := tipo_cu_datos ();

  nuLogError NUMBER;
  nuTotalRegs number := 0;
  nuErrores number := 0;
  nuSubscriberId ge_subscriber.subscriber_id%type;
  sbCCIdentificacion ge_subscriber.identification%type;
  nuCCIdent     NUMBER(15,0);
  nuExistePolicy    number;
  
   FUNCTION existe_cliente(p_identification VARCHAR2,p_sbNombre varchar2,p_sbApellido1 varchar2,p_sbApellido2 varchar2)
   return number is
    CURSOR cucliente IS
    SELECT subscriber_id
    FROM ge_subscriber
    WHERE identification = p_identification
    AND subscriber_name = p_sbNombre
    AND subs_last_name = p_sbApellido1
    AND subs_second_last_name = p_sbApellido2;
    CURSOR cucliente_1 IS
    SELECT subscriber_id
    FROM ge_subscriber
    WHERE identification = p_identification
    AND subscriber_name = p_sbNombre
    AND subs_last_name = p_sbApellido1;
    CURSOR cucliente_2 IS
    SELECT subscriber_id
    FROM ge_subscriber
    WHERE identification = p_identification
    AND subscriber_name = p_sbNombre;
    nusubscriber_id number;
   BEGIN
    if cucliente%isopen then
        close cucliente;
    END if;
    if cucliente_1%isopen then
        close cucliente_1;
    END if;
    nusubscriber_id := null;
    if ( p_sbNombre IS not null AND p_sbApellido1 IS not null AND p_sbApellido2 IS not null ) then
        open cucliente;
        fetch cucliente INTO nusubscriber_id;
        close cucliente;
    elsif ( p_sbNombre IS not null AND p_sbApellido1 IS not null AND p_sbApellido2 IS null ) then
        open cucliente_1;
        fetch cucliente_1 INTO nusubscriber_id;
        close cucliente_1;
    elsif ( p_sbNombre IS not null AND p_sbApellido1 IS null AND p_sbApellido2 IS null ) then
        open cucliente_2;
        fetch cucliente_2 INTO nusubscriber_id;
        close cucliente_2;
    END if;
    if   nusubscriber_id IS null then
        nusubscriber_id := 0;
    END if;
    return nusubscriber_id;
   END;
   ----------------------------------------------

BEGIN

  -- Inserta registro de inicio en el log
  PKLOG_MIGRACION.prInsLogMigra (235,235,1,'PR_LD_POLICY',0,0,'Inicia Proceso','INICIO',nuLogError);
  
   UPDATE migr_rango_procesos SET RAPRFEIN = SYSDATE, RAPRTERM = 'P' WHERE RAPRCODI = 235 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
   COMMIT;
   
   pkg_constantes.COMPLEMENTO(nuBD,nuComplementoPR,nuComplementoSU,nuComplementoFA,nuComplementoCU,nuComplementoDI);

   vcontIns := 1;
   vcontLec := 0;
   
   OPEN cuDatos;

   LOOP
      --
	    -- Borrar tablas 	tbl_datos.
      --
      tbl_datos.delete;

	  FETCH cuDatos
      BULK COLLECT INTO tbl_datos
      LIMIT 1000;

	  FOR nuindice IN 1 .. tbl_datos.COUNT
      LOOP

	nuReg := 1;
	NUSUSCRIPTOR := TBL_DATOS(NUINDICE).SUSCRIPTION_ID;
	nuPoliza := TBL_DATOS(NUINDICE).POLICY_ID;
        nuSubscriberId := 0;

     ----------------------
      BEGIN
          SELECT subscriber_id
          INTO nuSubscriberId
          FROM ge_subscriber, suscripc
          WHERE subscriber_id = suscclie(+)
          AND identification = to_char(tbl_datos(nuindice).IDENTIFICATION_ID)
          AND SUSCCODI = tbl_datos(nuindice).SUSCRIPTION_ID;
      EXCEPTION
        when others then
             BEGIN
             /*SELECT subscriber_id
	              INTO nuSubscriberId
	              FROM ge_subscriber
	              WHERE identification = to_char(tbl_datos(nuindice).IDENTIFICATION_ID)
	              AND  replace (subscriber_name || ' ' || subs_last_name,' ','') = replace(tbl_datos(nuindice).NAME_INSURED,' ','');*/
              
              SELECT subscriber_id
                INTO nuSubscriberId 
                FROM ge_subscriber
               WHERE subscriber_name = tbl_datos(nuindice).NOMBRE
                 AND subs_last_name = tbl_datos(nuindice).APELLIDO
                 AND identification = to_char(tbl_datos(nuindice).IDENTIFICATION_ID);
              
         --   dbms_output.put_line (tbl_datos(nuindice).NAME_INSURED);
           EXCEPTION
           when others then
           nuSubscriberId:= 0;
             END;
       --when others then
      -- nuSubscriberId:= 0;
      END;
    ----------------------
     BEGIN
        SELECT identification INTO sbCCIdentificacion FROM ge_subscriber WHERE subscriber_id = nuSubscriberId;
        EXCEPTION
        when others then
             sbCCIdentificacion := 0;
        END;
     -----------------------

     OPEN CUGESUBS(nuSubscriberId);
     FETCH CUGESUBS INTO RGCLIENTE;
     CLOSE CUGESUBS;

     IF sbCCIdentificacion like '%-%' then
        continue;
     END IF;

	IF RGCLIENTE.IDENTIFICATION IS NULL THEN

		sbNombre := NULL;
	        sbApellido1 := NULL;
	        sbApellido2:= NULL;
          
		nuSubscriberId := 0;

	        nuSubscriberId := existe_cliente(TBL_DATOS(NUINDICE).IDENTIFICATION_ID,TBL_DATOS(NUINDICE).NOMBRE,TBL_DATOS(NUINDICE).APELLIDO, NULL);

		IF nuSubscriberId = 0 THEN

			      NUCODIGO := SEQ_GE_SUBSCRIBER.NEXTVAL;
              
    			    GSI_MIG_REGISTRACLIENTE (NUCODIGO,
						1,                -- Tipo de Id ge_identifica_type
						TBL_DATOS(NUINDICE).IDENTIFICATION_ID,                    -- Identificaciÿ¿ÿ¿ÿ¿ÿ¿n
						NULL,                                 -- Parent_id
						1,         -- Subscriber Type   ge_subscriber_type
						RGCLIENTE.ADDRESS,                      -- Direcciÿ¿ÿ¿ÿ¿ÿ¿n cadena
						RGCLIENTE.PHONE,                              -- Telefono
						tbl_datos(nuindice).NOMBRE,                     -- Nombre del cliente
						tbl_datos(nuindice).APELLIDO,                             -- Apellido 1
						sbApellido2,                                -- Apellido 2
						NULL, --tbl_datos (nuindice).PERSFENA,               -- Fecha de Nacimiento
						NULL,  --- Fecha de la ultima Actualizacion
						NULL, --tbl_datos (nuindice).PERSMAIL,          -- Email
						NULL, -- 'www.prueba/api.net',                       -- URL
						NULL,         --'3319999', -- ID del contacto 3090
						NULL,    -- Actividad economica ge_economic_activity
						1, -- ID del segmento de mercado cc_marketing_segment
						1,                    -- Satus ID   ge_subs_status
						'Y',                     -- Esta activo, SI=Y NO=N
						RGCLIENTE.ADDRESS_ID, -- ID de la dir parseada SELECT address_id, address FROM ab_address
						1,            -- Tipo de contribuyente fa_tipocont
						'N',                                  -- DATA_SEND
						tbl_datos (nuindice).DT_IN_POLICY,                   -- Fecha de vinculaciÿ¿ÿ¿ÿ¿ÿ¿n
						NULL,
						NULL,
						'N',
						NUERRORCODE,
						sbErrorMessage);

             ----------------------
             BEGIN
                SELECT identification INTO sbCCIdentificacion FROM ge_subscriber WHERE subscriber_id = NUCODIGO;
                EXCEPTION
                when others then
                     sbCCIdentificacion := 0;
               END;
             -----------------------
             nuSubscriberId := NUCODIGO;

	     nuCCIdent := sbCCIdentificacion;

          ELSE
            nuCCIdent := sbCCIdentificacion;
          END if;

     ELSE
         nuCCIdent := sbCCIdentificacion;

     END IF;

        BEGIN
	        vcontLec := vcontLec + 1;

            INSERT INTO LD_POLICY(POLICY_ID,POLICY_NUMBER,STATE_POLICY,LAUNCH_POLICY,CONTRATIST_CODE,PRODUCT_LINE_ID,DT_IN_POLICY,DT_EN_POLICY,VALUE_POLICY,PREM_POLICY,NAME_INSURED,SUSCRIPTION_ID,
                                      PRODUCT_ID,IDENTIFICATION_ID,PERIOD_POLICY,YEAR_POLICY,MONTH_POLICY,DEFERRED_POLICY_ID,DTCREATE_POLICY,SHARE_POLICY,DTRET_POLICY,VALUEACR_POLICY,
                                      REPORT_POLICY,DT_REPORT_POLICY,DT_INSURED_POLICY,PER_REPORT_POLICY,POLICY_TYPE_ID,ID_REPORT_POLICY,CANCEL_CAUSAL_ID,FEES_TO_RETURN,COMMENTS,POLICY_EXQ,
                                      NUMBER_ACTA,GEOGRAP_LOCATION_ID,VALIDITY_POLICY_TYPE_ID,COLLECTIVE_NUMBER)
                               VALUES(TBL_DATOS(NUINDICE).POLICY_ID,TBL_DATOS(NUINDICE).POLICY_NUMBER,TBL_DATOS(NUINDICE).STATE_POLICY,TBL_DATOS(NUINDICE).LAUNCH_POLICY,TBL_DATOS(NUINDICE).CONTRATIST_CODE,
				      TBL_DATOS(NUINDICE).PRODUCT_LINE_ID,TBL_DATOS(NUINDICE).DT_IN_POLICY,TBL_DATOS(NUINDICE).DT_EN_POLICY,TBL_DATOS(NUINDICE).VALUE_POLICY,TBL_DATOS(NUINDICE).PREM_POLICY,
				      TBL_DATOS(NUINDICE).NOMBRE ||' '|| TBL_DATOS(NUINDICE).APELLIDO,TBL_DATOS(NUINDICE).SUSCRIPTION_ID,TBL_DATOS(NUINDICE).PRODUCT_ID,NUCCIDENT,TBL_DATOS(NUINDICE).PERIOD_POLICY,
				      TBL_DATOS(NUINDICE).YEAR_POLICY,TBL_DATOS(NUINDICE).MONTH_POLICY,TBL_DATOS(NUINDICE).DEFERRED_POLICY_ID,TBL_DATOS(NUINDICE).DTCREATE_POLICY,TBL_DATOS(NUINDICE).SHARE_POLICY,
				      TBL_DATOS(NUINDICE).DTRET_POLICY,TBL_DATOS(NUINDICE).VALUEACR_POLICY,TBL_DATOS(NUINDICE).REPORT_POLICY,TBL_DATOS(NUINDICE).DT_REPORT_POLICY,TBL_DATOS(NUINDICE). DT_INSURED_POLICY,
				      TBL_DATOS(NUINDICE).PER_REPORT_POLICY,TBL_DATOS(NUINDICE).POLICY_TYPE_ID,TBL_DATOS(NUINDICE).ID_REPORT_POLICY,TBL_DATOS(NUINDICE).CANCEL_CAUSAL_ID,TBL_DATOS(NUINDICE).FEES_TO_RETURN,
				      TBL_DATOS(NUINDICE).COMMENTS,TBL_DATOS(NUINDICE).POLICY_EXQ,TBL_DATOS(NUINDICE).NUMBER_ACTA,TBL_DATOS(NUINDICE).GEOGRAP_LOCATION_ID,TBL_DATOS(NUINDICE).VALIDITY_POLICY_TYPE_ID,
				      TBL_DATOS(NUINDICE).COLLECTIVE_NUMBER);

             NUATENCION := SEQ_MO_PACKAGES.NEXTVAL;

		INSERT INTO MO_PACKAGES (PACKAGE_ID, REQUEST_DATE, MESSAG_DELIVERY_DATE, USER_ID, TERMINAL_ID, CLIENT_PRIVACY_FLAG, NUMBER_OF_PROD,
					 PACKAGE_TYPE_ID, MOTIVE_STATUS_ID, SUBSCRIBER_ID, INTERFACE_HISTORY_ID, SUBSCRIPTION_PEND_ID, PERSON_ID,
				         ATTENTION_DATE, COMM_EXCEPTION, DISTRIBUT_ADMIN_ID, RECEPTION_TYPE_ID, CUST_CARE_REQUES_NUM, SALES_PLAN_ID,
                                         TAG_NAME, INCLUDED_ID, COMPANY_ID,  ORGANIZAT_AREA_ID, ZONE_ADMIN_ID, SALE_CHANNEL_ID, PRIORITY_ID, OPERATING_UNIT_ID,
                                         POS_OPER_UNIT_ID, PROJECT_ID, ANS_ID, EXPECT_ATTEN_DATE, ANSWER_MODE_ID, REFER_MODE_ID, DOCUMENT_TYPE_ID, DOCUMENT_KEY,
                                         COMMENT_, CONTACT_ID, ADDRESS_ID, INSISTENTLY_COUNTER, ORDER_ID, MANAGEMENT_AREA_ID, RECURRENT_BILLING, LIQUIDATION_METHOD)
                                  VALUES(NUATENCION, TBL_DATOS (NUINDICE).DT_IN_POLICY, TBL_DATOS (NUINDICE).DT_IN_POLICY, 'OPEN', 'DCC15','N', NULL, 100236,
                                         14, nuSubscriberId, NULL, TBL_DATOS (NUINDICE).SUSCRIPTION_ID,1,NULL, 'N',NULL, 10,NUATENCION, NULL, 'P_TRAMITE_DE_VENTA_100236', 
				         NULL,99,NULL, NULL,-1,NULL, NULL,1,NULL, 8100, TBL_DATOS (NUINDICE).DT_IN_POLICY,NULL, NULL, NULL,NULL,TBL_DATOS (NUINDICE).COMMENTS,
				         nuSubscriberId,NULL,NULL, NULL, NULL, NULL,NULL );

		INSERT INTO MO_MOTIVE(MOTIVE_ID, PRIVACY_FLAG, CLIENT_PRIVACY_FLAG, PROVISIONAL_FLAG, IS_MULT_PRODUCT_FLAG, AUTHORIZ_LETTER_FLAG,
				      PARTIAL_FLAG, PROV_INITIAL_DATE, PROV_FINAL_DATE, INITIAL_PROCESS_DATE, PRIORITY, MOTIV_RECORDING_DATE, ESTIMATED_INST_DATE,
                                      ASSIGN_DATE, ATTENTION_DATE, ANNUL_DATE, STATUS_CHANGE_DATE, STUDY_NUM_TRANSFEREN, CUSTOM_DECISION_FLAG, EXECUTION_MAX_DATE,
                                      STANDARD_TIME, SERVICE_NUMBER, PRODUCT_MOTIVE_ID, DISTRIBUT_ADMIN_ID, DISTRICT_ID, BUILDING_ID, ANNUL_CAUSAL_ID, PRODUCT_ID,
                                      MOTIVE_TYPE_ID, PRODUCT_TYPE_ID, MOTIVE_STATUS_ID, SUBSCRIPTION_ID, PACKAGE_ID, UNDOASSIGN_CAUSAL_ID, GEOGRAP_LOCATION_ID,
                                      CREDIT_LIMIT, CREDIT_LIMIT_COVERED, CUST_CARE_REQUES_NUM, VALUE_TO_DEBIT, TAG_NAME, ORGANIZAT_AREA_ID, COMMERCIAL_PLAN_ID,
                                      PERMANENCE, COMPANY_ID, INCLUDED_FEATURES_ID, RECEPTION_TYPE_ID, CAUSAL_ID, ASSIGNED_PERSON_ID, ANSWER_ID, CATEGORY_ID,
                                      SUBCATEGORY_ID, IS_IMMEDIATE_ATTENT, ELEMENT_POSITION)
                              VALUES (SEQ_MO_MOTIVE.NEXTVAL,'N','N','N','N','N','N',Null,Null,Null,100,SYSDATE,Null,Null,Null,Null,Null,Null,'N',SYSDATE,0,
			              TBL_DATOS(NUINDICE).PRODUCT_ID,100251,Null,Null,Null,Null,TBL_DATOS(NUINDICE).PRODUCT_ID,8,7053,11,TBL_DATOS(NUINDICE).SUSCRIPTION_ID,
				      NUATENCION,Null,Null,Null,Null,NUATENCION,Null,'M_INSTALACION_DEBRILLA_SEGUROS_100251',Null,-1,Null,99,Null,Null,Null,Null,Null,-1,-1,'Y',Null);

                INSERT INTO LD_SECURE_SALE (SECURE_SALE_ID, ID_CONTRATISTA, PRODUCT_LINE_ID, BORN_DATE, POLICY_TYPE_ID, POLICY_NUMBER,
                                            POLICY_VALUE, IDENTIFICATION_ID, CAUSAL_ID)
                                    VALUES (NUATENCION, TBL_DATOS (NUINDICE).CONTRATIST_CODE, TBL_DATOS (NUINDICE).PRODUCT_LINE_ID,
                                            TBL_DATOS (NUINDICE).DT_INSURED_POLICY, TBL_DATOS (NUINDICE).POLICY_TYPE_ID, TBL_DATOS(NUINDICE).POLICY_ID,
                                            TBL_DATOS (NUINDICE).VALUE_POLICY,nuSubscriberId,null);

				  nuTotalRegs := nuTotalRegs + 1;

			EXCEPTION
		            WHEN OTHERS
					THEN
					      BEGIN
			verror := 'Error en la Poliza : '||NUSUSCRIPTOR||' - '||nuSubscriberId||' - '||tbl_datos (nuindice).IDENTIFICATION_ID ||' - ' || SQLERRM;
			nuErrores := nuErrores + 1;
			PKLOG_MIGRACION.prInsLogMigra ( 235,235,2,'PR_LD_POLICY',0,0,'Error: '||verror,to_char(sqlcode),nuLogError);

					      END;
		    END;

		END LOOP;

     COMMIT;

		 EXIT WHEN cuDatos%NOTFOUND;


   END LOOP;

    -- Cierra CURSOR.
   IF (cuDatos%ISOPEN)
   THEN

      CLOSE cuDatos;

   END IF;

  -- Termina Log
  PKLOG_MIGRACION.prInsLogMigra ( 235,235,3,'PR_LD_POLICY',nuTotalRegs,nuErrores,'TERMINO PROCESO #regs: '||nuTotalRegs,'FIN',nuLogError);
  
   UPDATE migr_rango_procesos SET RAPRFEFI = SYSDATE, RAPRTERM = 'T' WHERE RAPRCODI = 235 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
   COMMIT;

EXCEPTION
   WHEN OTHERS
   THEN
     
      PKLOG_MIGRACION.prInsLogMigra ( 235,235,2,'PR_LD_POLICY',0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);

END PR_LD_POLICY_ROLLOUT; 
/
