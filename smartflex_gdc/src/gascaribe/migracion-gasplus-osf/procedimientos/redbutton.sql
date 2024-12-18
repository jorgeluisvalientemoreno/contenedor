CREATE OR REPLACE procedure    redbutton (inubasedato number) is
WHAT varchar2(2000);
JobNo user_jobs.job%TYPE;
dtFecha date:=sysdate;
begin

     migra.truncatetablasmigra;
     -- Limpia la tabla de ejecucion de procesos.
     migrborraindices;
     if inubasedato=1 then
       PR_HOMOLOGACIONES(1);
       PR_HOMOLOGACIONES(2);
       PR_HOMOLOGACIONES(3);
     else
        if inubasedato=4 then
             PR_HOMOLOGACIONES(4);
        else
            if inubasedato=5 then
                 PR_HOMOLOGACIONES(5);
            END if;
        END if;
     END if;
     
     migrguardatriggers;
     migrinhabilitatriggers;
     migrsecuencias;
     migra.migrstatshomo;
     update migr_rango_procesos set RAPRFEIN=null,raprfefi=null,raprterm='N';
    
    begin
     EXECUTE IMMEDIATE 
       'CREATE INDEX OPEN.IDX_MIGR_AB_WAY_BY_LOCATION010 ON OPEN.AB_WAY_BY_LOCATION
        (DESCRIPTION,GEOGRAP_LOCATION_ID)
        LOGGING
        TABLESPACE TSI_ADDRESS_BANK
        PCTFREE    5
        INITRANS   2
        MAXTRANS   255
        STORAGE    (
            INITIAL          16K
            NEXT             8K
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
        NOPARALLEL';
    
     EXECUTE IMMEDIATE 
       'CREATE INDEX OPEN.IDX_MIGR_GE_SUBSCRIBER_01 ON OPEN.GE_SUBSCRIBER
        (identification,subscriber_name,subs_last_name)
            LOGGING
        TABLESPACE TSI_GENERAL
        PCTFREE    5
        INITRANS   2
        MAXTRANS   255
        STORAGE    (
            INITIAL          16K
            NEXT             8K
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           )
        NOPARALLEL';
    exception
        when others then
        null;
    end;
 
     EXECUTE IMMEDIATE 'BEGIN DBMS_STATS.GATHER_TABLE_STATS('||chr(39)||'OPEN'||chr(39)||','||chr(39)||'CONCEPTO'||chr(39)||', ESTIMATE_PERCENT => 100, CASCADE => TRUE); END;';
    
     EXECUTE IMMEDIATE 'alter sequence OPEN.SQ_LECTELME_LEEMCONS cache 100';
     EXECUTE IMMEDIATE 'alter system flush shared_pool';
     
     delete from manzanas where manzdepa<>-1 and manzloca<>-1;
     
     EXECUTE IMMEDIATE 'TRUNCATE TABLE LDC_PLAZOS_CERT';
     EXECUTE IMMEDIATE 'TRUNCATE TABLE ldc_osf_sesucier';
        
     WHAT:='plataformak;';
     DBMS_JOB.SUBMIT(JobNo, WHAT, dtFecha);
      Commit;
end; 
/
