CREATE OR REPLACE PROCEDURE "FIXCLIENTES" (NUMINICIO NUMBER, NUMFINAL NUMBER, PBD NUMBER) is
procedure PR_AGRUPA_DIFECOFI is
cursor cuNuse is
select distinct difenuse
from diferido;
cursor cuDiferido (nuNuse in diferido.difenuse%type) is
select distinct difenuse, difepldi, difemeca, difetain,
       difeusua, difeprog, trunc(difefein,'HH') difefein
from diferido
where difenuse = nuNuse;
nudifecofi number;
nuLogError NUMBER;
begin
  -- Actualiza el programa de diferido de re financiacion
  update diferido
  set difeprog = 'GCNED'
  where difeprog = 'FFDC';
  commit;
  PKLOG_MIGRACION.prInsLogMigra (279,279,1,'PR_AGRUPA_DIFECOFI',0,0,'Inicia Proceso','INICIO',nuLogError);
  for rtNuse in cuNuse loop
      for rtDife in cuDiferido (rtNuse.difenuse) loop
          nudifecofi := sq_deferred_difecofi.nextval; 
          update diferido
          set difecofi = nudifecofi
          where difenuse = rtDife.difenuse
          and   difepldi = rtDife.difepldi 
          and   difemeca = rtDife.difemeca 
          and   difetain = rtDife.difetain
          and   difeusua = rtDife.difeusua
          and   difeprog = rtDife.difeprog
          and   trunc(difefein,'HH') = rtDife.difefein;
          commit;
      end loop;
   end loop;
   PKLOG_MIGRACION.prInsLogMigra (279,279,3,'PR_AGRUPA_DIFECOFI',0,0,'Termina Proceso','FIN',nuLogError);
end PR_AGRUPA_DIFECOFI;
PROCEDURE diferidofinancing (INI NUMBER, FIN NUMBER)
AS
    numopackage number;
    nudifesape number;
    cursor cudiferido
    is
    select difecofi,
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
	PKLOG_MIGRACION.prInsLogMigra (280,280,3,'DIFERIDOFINANCING',0,0,'Termina Proceso','FIN',nuLogError);
END diferidofinancing;
PROCEDURE      PR_FEULLICO AS 
  /*******************************************************************
 PROGRAMA    	: FEULLICO
 FECHA		    :	27/05/2014
 AUTOR		    :	VICTOR HUGO MUNIVE ROCA
 DESCRIPCION	:	Migra la informacion de del ultimo Cargos por suscriptor
                a FEULLICO
 HISTORIA DE MODIFICACIONES
 AUTOR	   FECHA	DESCRIPCION
 *******************************************************************/
    vfecha_ini          DATE;
   vfecha_fin          DATE;
   VPROGRAMA           VARCHAR2 (100);
   verror              VARCHAR2 (4000);
   vcont               NUMBER;
   vcontLec               NUMBER := 0;
   vcontIns               NUMBER := 0;
   sbDocumento           VARCHAR2(100) := null;
   cursor cuCargos
       iS
   SELECT a.CARGCONC  FELICONC,
          a.CARGNUSE  FELISESU,
          MAX(a.CARGFECR)  FELIFEUL
     FROM CARGOS a
	gROUP BY CARGCONC, CARGNUSE;
	 -- DECLARACION DE TIPOS.
     
    cursor cusesunuse(inubasedato number)
    is
    select * from 
    ldc_temp_servsusc_sge
    where sesuesfi=1
    and basedato=inubasedato;
   --
   TYPE tipo_cu_datos IS TABLE OF cuCargos%ROWTYPE;
   -- DECLARACION DE TABLAS TIPOS.
   --
   tbl_datos      tipo_cu_datos := tipo_cu_datos ();
   nuLogError NUMBER;
   nuTotalRegs number := 0;
   nuErrores number := 0;
   
   nuComplementoPR number;
   nuComplementoSU number;
   nuComplementoFA number;
   nuComplementoCU number;
   nuComplementoDI number;
  
   nunuse  number;
   dtfecha date;
   
BEGIN
    -- Inserta registro de inicio en el log
    PKLOG_MIGRACION.prInsLogMigra (238,238,1,'PR_FEULLICO',0,0,'Inicia Proceso','INICIO',nuLogError);
    pkg_constantes.COMPLEMENTO(pbd,
                             nuComplementoPR,
                             nuComplementoSU,
                             nuComplementoFA,
                             nuComplementoCU,
                             nuComplementoDI);

   OPEN cuCargos;
   LOOP
      --
      -- Borrar tablas 	tbl_datos.
      --
      tbl_datos.delete;
      FETCH cuCargos
      BULK COLLECT INTO tbl_datos
      LIMIT 1000;
      FOR nuindice IN 1 .. tbl_datos.COUNT
      LOOP
         BEGIN
            -->>
            -- Se valida que el concepto sea de recargo por mora
            -->>
            IF (tbl_datos (nuindice).FELICONC <> 220 AND
                tbl_datos (nuindice).FELICONC <> 154 AND
                tbl_datos (nuindice).FELICONC <> 156 ) THEN
              
                -->>
                -- Se inserta el concepto diferente a recargo por mora
                -->>
                vcontLec := vcontLec +1;
                sbDocumento := tbl_datos (nuindice).FELICONC||' - '||tbl_datos (nuindice).FELISESU;
                INSERT /*+ APPEND*/ INTO FEULLICO VALUES tbl_datos ( nuindice);
                COMMIT;
                nuTotalRegs := nuTotalRegs +1;
            
            ELSE 
              
                vcontLec := vcontLec +10;
                
                sbDocumento := tbl_datos (nuindice).FELICONC||' - '||tbl_datos (nuindice).FELISESU;
                
                nunuse  := tbl_datos (nuindice).FELISESU;
                dtfecha := tbl_datos (nuindice).FELIFEUL;
                
                -->>
                -- Se insertan los conceptos relacionados para recargo por mora
                -->>
                
                INSERT INTO FEULLICO (FELICONC, FELISESU, FELIFEUL) VALUES (154, nunuse, dtfecha);
                
                INSERT INTO FEULLICO (FELICONC, FELISESU, FELIFEUL) VALUES (156, nunuse, dtfecha);

                INSERT INTO FEULLICO (FELICONC, FELISESU, FELIFEUL) VALUES (157, nunuse, dtfecha);
 
                INSERT INTO FEULLICO (FELICONC, FELISESU, FELIFEUL) VALUES (220, nunuse, dtfecha);

                INSERT INTO FEULLICO (FELICONC, FELISESU, FELIFEUL) VALUES (284, nunuse, dtfecha);

                INSERT INTO FEULLICO (FELICONC, FELISESU, FELIFEUL) VALUES (285, nunuse, dtfecha);
               
                INSERT INTO FEULLICO (FELICONC, FELISESU, FELIFEUL) VALUES (286, nunuse, dtfecha);
                
                INSERT INTO FEULLICO (FELICONC, FELISESU, FELIFEUL) VALUES (759, nunuse, dtfecha);

                INSERT INTO FEULLICO (FELICONC, FELISESU, FELIFEUL) VALUES (760, nunuse, dtfecha);

                INSERT INTO FEULLICO (FELICONC, FELISESU, FELIFEUL) VALUES (761, nunuse, dtfecha);
             
                       
                COMMIT;
                
                nuTotalRegs := nuTotalRegs +10;
              
            
            END IF; 
            
            
         EXCEPTION
            WHEN OTHERS THEN
                 BEGIN
		      verror := 'Error en La nota : '||sbdocumento|| ' - ' || SQLERRM;
                      nuErrores := nuErrores + 1;
                      PKLOG_MIGRACION.prInsLogMigra ( 238,238,2,'PR_FEULLICO',0,0,'Error: '||verror,to_char(sqlcode),nuLogError);       
                 END;
        END;
      END LOOP;
      COMMIT;
      EXIT WHEN cuCargos%NOTFOUND;
   END LOOP;
    -- Cierra CURSOR.
   IF (cuCargos%ISOPEN) THEN
      --{
      CLOSE cuCargos;
      --}
   END IF;
   
   if pbd in (5) then
        for r in cusesunuse(5)
        loop
   
        update feullico set felifeul=sysdate where felisesu=r.sesunuse+nuComplementoPR;
        commit;
        end loop;
        
   end if;
   
   if pbd in (1) then
        for r in cusesunuse(1)
        loop
   
        update feullico set felifeul=sysdate where felisesu=r.sesunuse+nuComplementoPR;
        commit;
        end loop;
        
        for r in cusesunuse(2)
        loop
   
        update feullico set felifeul=sysdate where felisesu=r.sesunuse+nuComplementoPR;
        commit;
        end loop;
        
        for r in cusesunuse(3)
        loop
   
        update feullico set felifeul=sysdate where felisesu=r.sesunuse+nuComplementoPR;
        commit;
        end loop;
        
   end if;
   
   
   -- Termina Log
   PKLOG_MIGRACION.prInsLogMigra ( 238,238,3,'PR_FEULLICO',nuTotalRegs,nuErrores,'TERMINO PROCESO #regs: '||nuTotalRegs,'FIN',nuLogError);
EXCEPTION
   WHEN OTHERS
   THEN
      PKLOG_MIGRACION.prInsLogMigra ( 238,238,2,'PR_FEULLICO',0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);
END PR_FEULLICO;
begin
     UPDATE migr_rango_procesos set raprfein=sysdate,raprterm='P' where raprcodi=1999 and raprbase=pbd and raprrain=NUMINICIO and raprrafi=NUMFINAL;  
     COMMIT;
     pkErrors.setapplication('MIGRA');
     pkGeneralServices.setTerminal('UNKNOWN');
     pkBOPositiveBalanceProcesses.InitPositiveBalance;
     PR_AGRUPA_DIFECOFI;
     diferidofinancing(1,10000000000); 
     PR_FEULLICO;
     UPDATE migr_rango_procesos set raprfeFi=sysdate,raprterm='T' where raprcodi=1999 and raprbase=pbd and raprrain=NUMINICIO and raprrafi=NUMFINAL;  
     COMMIT;
end; 
/
