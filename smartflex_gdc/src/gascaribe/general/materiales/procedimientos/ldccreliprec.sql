CREATE OR REPLACE PROCEDURE LDCCRELIPREC(
/********************************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2018-07-12
    Descripcion : Generamos listas de precio a partir de la informaci?n interfaz SAP

    Parametros Entrada

    Valor de salida


   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR   DESCRIPCION
**********************************************************************************************/
inuProgramacion IN ge_process_schedule.process_schedule_id%type) IS
nuparano           NUMBER(4);
nuparmes           NUMBER(2);
nutsess            NUMBER;
sbparuser          VARCHAR2(30);
sbParametros       ge_process_schedule.parameters_%TYPE;
nuHilos            NUMBER := 1;
nuLogProceso       ge_log_process.log_process_id%TYPE;
sbmensa            VARCHAR2(4000);
nucodlistaprecios  ldci_intelistpr.codigo%TYPE;
numensasal         NUMBER;
sbemensajesal      VARCHAR2(4000);
BEGIN
 -- Obtenemos datos para realizar ejecucion
 SELECT to_number(to_char(SYSDATE,'YYYY'))
       ,to_number(to_char(SYSDATE,'MM'))
       ,userenv('SESSIONID')
       ,USER
   INTO nuparano
       ,nuparmes
       ,nutsess
       ,sbparuser
   FROM dual;
 -- Se inicia log del programa
 ldc_proinsertaestaprog(nuparano,nuparmes,'LDCCRELIPREC','En ejecucion',nutsess,sbparuser);
 ge_boschedule.AddLogToScheduleProcess(inuprogramacion,nuhilos,nulogproceso);
 -- Se obtiene parametros
 sbParametros      := dage_process_schedule.fsbGetParameters_(inuProgramacion);
 nucodlistaprecios := to_number(ut_string.getparametervalue(sbParametros,'COPPCOPL','|','='));
 ldci_pkinterfazlistprecsap.ldci_proccrealistaprecinterfaz(nucodlistaprecios,numensasal,sbemensajesal);
 IF numensasal = 0 THEN
  sbmensa := 'Proceso terminó Ok. Se procesarón .';
  COMMIT;
 ELSE
  sbmensa := 'Proceso terminó con errores. '||sbemensajesal;
  COMMIT;
 END IF;
 -- Se finaliza proceso
 ldc_proactualizaestaprog(nutsess,sbmensa,'LDCCRELIPREC','Termino Ok.');
 ge_boschedule.changelogProcessStatus(nuLogProceso,'F');
EXCEPTION
 WHEN OTHERS THEN
 ROLLBACK;
  sbmensa := -1||' Error en el proceso LDCCRELIPREC..lineas error '|| ' : ' || sqlerrm;
  ldc_proactualizaestaprog(nutsess,sbmensa,'LDCCRELIPREC','Termino con error.');
  ge_boschedule.changelogProcessStatus(nuLogProceso,'F');
END;
/
GRANT EXECUTE on LDCCRELIPREC to SYSTEM_OBJ_PRIVS_ROLE;
/
