CREATE OR REPLACE PROCEDURE      diferidofinancing (INI NUMBER, FIN NUMBER, pbd number)
AS
    numopackage number;
    nudifesape number;
    cursor cudiferido
    is
    select /*+ PARALLEL */ difecofi,
           difeprog,
           max (difesusc) difesusc,
           max (difemeca) difemeca,
           max (difetain) difetain,
           max (difenucu) difenucu,
           max (difevacu) difevacu,
           max (difeinte) difeinte,
           max (difefunc) difefunc,
           max (difefein) difefein,
           max (difeterm) difeterm,
           max (suscclie) suscclie,
           max (difenuse) difenuse
    from diferido, suscripc
    where  difesusc = susccodi AND SUSCCODI>=INI AND SUSCCODI<FIN
    group by difecofi,difeprog;
    x varchar2(2000);
	nuLogError NUMBER;
BEGIN
    
    UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='P', RAPRFEIN=sysdate WHERE raprbase=pbd AND raprrain=INI AND raprrafi=FIN AND raprcodi=280;
    commit;
   PKLOG_MIGRACION.prInsLogMigra (280,280,1,'DIFERIDOFINANCING',0,0,'Inicia Proceso','INICIO',nuLogError);
   for r in cudiferido loop
	begin
        -- Obtiene la secuencia de MO_PACKAGE
        numopackage:=SEQ_MO_PACKAGES.nextval;

        select sum(difesape)
        into nudifesape
        from diferido
        where difecofi = r.difecofi
        group by difecofi;

        insert into cc_financing_request
        values (numopackage,numopackage,r.difecofi,'F', -1,r.difemeca,r.difetain,r.difefein,
                0,100,0,r.difenucu,r.difevacu,'N',nudifesape, '-','N','N',null,-1,sysdate,
                r.difeinte,'Y',null,r.difesusc,null,null,r.difefunc,r.difefein,r.difeterm,r.difeprog,'N');
        commit;

        INSERT INTO MO_PACKAGES
        (PACKAGE_ID, REQUEST_DATE, MESSAG_DELIVERY_DATE, USER_ID, TERMINAL_ID, CLIENT_PRIVACY_FLAG,
        NUMBER_OF_PROD, PACKAGE_TYPE_ID, MOTIVE_STATUS_ID, SUBSCRIBER_ID, INTERFACE_HISTORY_ID,
        SUBSCRIPTION_PEND_ID, PERSON_ID, ATTENTION_DATE, COMM_EXCEPTION, DISTRIBUT_ADMIN_ID,
        RECEPTION_TYPE_ID, CUST_CARE_REQUES_NUM, SALES_PLAN_ID, TAG_NAME, INCLUDED_ID, COMPANY_ID,
        ORGANIZAT_AREA_ID, ZONE_ADMIN_ID, SALE_CHANNEL_ID, PRIORITY_ID, OPERATING_UNIT_ID,
        POS_OPER_UNIT_ID, PROJECT_ID, ANS_ID, EXPECT_ATTEN_DATE, ANSWER_MODE_ID, REFER_MODE_ID,
        DOCUMENT_TYPE_ID, DOCUMENT_KEY, COMMENT_, CONTACT_ID, ADDRESS_ID, INSISTENTLY_COUNTER, ORDER_ID,
        MANAGEMENT_AREA_ID, RECURRENT_BILLING, LIQUIDATION_METHOD)
        VALUES (numopackage,sysdate,sysdate,'MIGRA','MIGRACION','N',Null,279,14,r.suscclie,Null,Null,Null,
        sysdate,'N',Null,10,numopackage,Null,'P_FINANCING_DEBT',Null,99,Null,Null,Null,Null,Null,Null,Null,
        Null,Null,Null,Null,Null,Null,Null,Null,Null,Null,Null,Null,Null,Null);
        commit;

        INSERT INTO MO_MOTIVE(MOTIVE_ID, PRIVACY_FLAG, CLIENT_PRIVACY_FLAG, PROVISIONAL_FLAG, IS_MULT_PRODUCT_FLAG, AUTHORIZ_LETTER_FLAG,
                  PARTIAL_FLAG, PROV_INITIAL_DATE, PROV_FINAL_DATE, INITIAL_PROCESS_DATE, PRIORITY, MOTIV_RECORDING_DATE, ESTIMATED_INST_DATE,
                  ASSIGN_DATE, ATTENTION_DATE, ANNUL_DATE, STATUS_CHANGE_DATE, STUDY_NUM_TRANSFEREN, CUSTOM_DECISION_FLAG, EXECUTION_MAX_DATE,
                  STANDARD_TIME, SERVICE_NUMBER, PRODUCT_MOTIVE_ID, DISTRIBUT_ADMIN_ID, DISTRICT_ID, BUILDING_ID, ANNUL_CAUSAL_ID, PRODUCT_ID,
                  MOTIVE_TYPE_ID, PRODUCT_TYPE_ID, MOTIVE_STATUS_ID, SUBSCRIPTION_ID, PACKAGE_ID, UNDOASSIGN_CAUSAL_ID, GEOGRAP_LOCATION_ID,
                  CREDIT_LIMIT, CREDIT_LIMIT_COVERED, CUST_CARE_REQUES_NUM, VALUE_TO_DEBIT, TAG_NAME, ORGANIZAT_AREA_ID, COMMERCIAL_PLAN_ID,
                  PERMANENCE, COMPANY_ID, INCLUDED_FEATURES_ID, RECEPTION_TYPE_ID, CAUSAL_ID, ASSIGNED_PERSON_ID, ANSWER_ID, CATEGORY_ID,
                  SUBCATEGORY_ID, IS_IMMEDIATE_ATTENT, ELEMENT_POSITION)
          VALUES (SEQ_MO_MOTIVE.NEXTVAL,'N','N','N','N','N','N',Null,Null,Null,100,SYSDATE,Null,Null,Null,Null,Null,Null,'N',SYSDATE,0,r.difenuse,51,
                  Null,Null,Null,Null,r.difenuse,94,7053,11,r.difesusc,numopackage,Null,Null,Null,Null,numopackage,
                  Null,'M_FINANCING_DEBT',Null,NULL,Null,99,Null,Null,Null,Null,Null,NULL,NULL,'Y',Null);
         commit;

		EXCEPTION
            WHEN OTHERS THEN
                    PKLOG_MIGRACION.prInsLogMigra (280,280,2,'DIFERIDOFINANCING',0,0,'Error Suscriptor '||r.difesusc||' - '||SQLERRM,to_char(sqlcode),nuLogError);
		end;
	end loop;
    
    UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='T', RAPRFEFI=sysdate WHERE raprbase=pbd AND raprrain=INI AND raprrafi=FIN AND raprcodi=280;
    commit;
	PKLOG_MIGRACION.prInsLogMigra (280,280,3,'DIFERIDOFINANCING',0,0,'Termina Proceso','FIN',nuLogError);

END diferidofinancing; 
/
