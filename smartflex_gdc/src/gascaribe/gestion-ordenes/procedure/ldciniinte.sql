create or replace PROCEDURE ldciniinte(
inuProgramacion in ge_process_schedule.process_schedule_id%type) IS
/******************************************************************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2018-09-27
  Descripcion : Procedimiento para inicializar los intentos en cero para un tipo de trabajo pasado por parametro
               y cuyas ordenes no esten asignadas.

  Parametros Entrada

  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION

*******************************************************************************************************************************/
CURSOR cudatos(nucutasktype NUMBER) IS
 SELECT t.order_id
   FROM or_order t,ldc_order o
  WHERE t.task_type_id = nucutasktype
    AND (o.asignado IS NULL OR o.asignado <> 'S')
    AND t.order_id     = o.order_id;
nuparano     NUMBER(4);
nuparmes     NUMBER(2);
nutsess      NUMBER;
sbparuser    VARCHAR2(30);
sbParametros ge_process_schedule.parameters_%TYPE;
nuHilos      NUMBER := 1;
nuLogProceso ge_log_process.log_process_id%TYPE;
sbmensa      VARCHAR2(4000);
nuvatipotrab or_task_type.task_type_id%TYPE;
nuconta      NUMBER(10);
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
 ldc_proinsertaestaprog(nuparano,nuparmes,'LDCINIINTE','En ejecucion',nutsess,sbparuser);
 ge_boschedule.AddLogToScheduleProcess(inuprogramacion,nuhilos,nulogproceso);
 -- Se obtiene parametros
 sbParametros := dage_process_schedule.fsbGetParameters_(inuProgramacion);
 nuvatipotrab := to_number(ut_string.getparametervalue(sbParametros,'TASK_TYPE_ID','|','='));
 nuconta := 0;
 FOR i IN cudatos(nuvatipotrab) LOOP
 -- Actualizacion de los intentos
  UPDATE ldc_order x
     SET x.asignacion = 0
   WHERE x.order_id = i.order_id;
   COMMIT;
   nuconta := nuconta + 1;
 END LOOP;
  sbmensa := 'Proceso termin? Ok. Se procesar?n : '||to_char(nuconta)||' registros.';
  ldc_proactualizaestaprog(nutsess,sbmensa,'LDCINIINTE','Termino Ok.');
  ge_boschedule.changelogProcessStatus(nuLogProceso,'F');
EXCEPTION
 WHEN OTHERS THEN
 ROLLBACK;
  sbmensa := -1||' Error en LDCINIINTE'|| ' : ' || sqlerrm;
  ldc_proactualizaestaprog(nutsess,sbmensa,'LDCINIINTE','Termino con error.');
  ge_boschedule.changelogProcessStatus(nuLogProceso,'F');
END;
/
													 