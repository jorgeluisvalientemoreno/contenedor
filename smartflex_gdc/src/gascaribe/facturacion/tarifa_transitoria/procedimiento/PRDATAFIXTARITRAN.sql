create or replace PROCEDURE PRDATAFIXTARITRAN IS
  nuparano       NUMBER;
  nuparmes       NUMBER;
  nutsess        NUMBER;
  sbparuser      VARCHAR2(400);
  nuerror        NUMBER;
  SBERROR        VARCHAR2(4000);
 nujob NUMBER;
 sbWhat  VARCHAR2(4000);
BEGIN
    SELECT to_number(TO_CHAR(SYSDATE,'YYYY')) ,
      to_number(TO_CHAR(SYSDATE,'MM')) ,
      userenv('SESSIONID') ,
      USER
    INTO nuparano,
      nuparmes,
      nutsess,
      sbparuser
    FROM dual;
 
  ldc_proinsertaestaprog(nuparano,nuparmes,'PRDATAFIXTARITRAN','En ejecucion',nutsess,sbparuser);
  
  DBMS_SCHEDULER.disable('GEN_NOTAS_USU_TARIFA_TRANSIT');
   
  FOR reg IN 1..10 LOOP
       sbWhat := 'BEGIN' || chr(10) || '   SetSystemEnviroment;' ||
                  chr(10) || '   prdatafix635_h'||reg||';' ||
                  chr(10) || 'EXCEPTION '||
                  chr(10) || '  WHEN OTHERS THEN '||
                  chr(10) || ' ERRORS.SETERROR;'||
                  chr(10) || 'END;';
        dbms_job.submit(nujob, sbWhat, sysdate + 1 / 3600); -- se programa la ejecucion (los jobs se eliminan automatiamente apenas terminan)
        commit;
        DBMS_OUTPUT.PUT_LINE('JOB '||REG||' '||nujob);
  END LOOP;
   ldc_proactualizaestaprog(nutsess,SBERROR,'PRDATAFIXTARITRAN','OK');
EXCEPTION
 WHEN OTHERS THEN
     ERRORS.SETERROR;
   ERRORS.GETERROR( nuerror, sbError);
   ldc_proactualizaestaprog(nutsess,sbError,'PRDATAFIXTARITRAN','error');
END PRDATAFIXTARITRAN;
/