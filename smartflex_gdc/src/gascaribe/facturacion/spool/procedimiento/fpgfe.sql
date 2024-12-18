create or replace PROCEDURE FPGFE  IS

  /**************************************************************************

      Autor       : Luis Javier Lopez Barrios  / Horbath
      Fecha       : 2023-03-10
      Ticket      : XXX2
      Descripcion : Procedimiento que Proceso datos del PB [FPGFE ]

      Parametros Entrada


      Valor de salida
      HISTORIA DE MODIFICACIONES

      FECHA        AUTOR       DESCRIPCION

    ***************************************************************************/

    sbMensError      VARCHAR2(4000);  

    onuScheduleProcessAux NUMBER;
    nuHilos                NUMBER := 1;
    nuLogProceso           ge_log_process.log_process_id%TYPE;

    idtNextDate DATE;
    isbParameters VARCHAR2(4000);
    isbWhat VARCHAR2(4000);
    inuExecutable     Sa_executable.executable_id%type := 5049;
    isbFrecuency      Ge_process_schedule.Frequency%type := 'UV';

    sbCadenaCone  VARCHAR2(100);
    sbUsuario      VARCHAR2(100);
    sbpassword     VARCHAR2(100);
    sbInstance     VARCHAR2(100);

    sbOrden VARCHAR2(40);

    onuError  NUMBER;

    sbCadeScrip VARCHAR2(4000);
    NUMINUTOS           NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_MINENTHILOS', NULL);

   CURSOR cugetFacturas IS
   SELECT DISTINCT PERIODO factpefa--, CODIGO factcodi
     FROM facturas_tem
     ORDER BY PERIODO;

    nuConta   NUMBER := 0;
 

    nuparano NUMBER;
    nuparmes NUMBER;
    nutsess  NUMBER;
    sbparuser VARCHAR2(4000);

    PROCEDURE programar(inuPeriodo IN NUMBER) IS

    BEGIN
      --Obtine el siguiente valor para el id de Ge_process_schedule
        select max(process_schedule_id)+1 into onuScheduleProcessAux
        from Ge_process_schedule;
        ut_trace.trace('onuScheduleProcessAux ['||onuScheduleProcessAux||']', 10);
        
        idtNextDate := SYSDATE + (NUMINUTOS * (1/24/60));

        IF sbCadeScrip IS NULL THEN
          --se obtiene cadena de conexion
          GE_BODATABASECONNECTION.GETCONNECTIONSTRING(sbUsuario, sbpassword, sbInstance);
          sbCadenaCone  := sbUsuario || '/' || sbpassword || '@' || sbInstance;
          sbCadeScrip   := FA_UIProcesosFact.FSBENCRIPTACADENA(sbCadenaCone);
        END IF;

        isbParameters := '|ORDEN=r.route_id, funcion|PERIFACT='||inuPeriodo||'|CONDICION=f.factcodi IN ( SELECT CODIGO FROM facturas_tem WHERE PERIODO = '||inuPeriodo ||')|ESTAARCH=0|COPIAFIEL=S|MEDIO=GR|RUTASREPARTO=|TIPOSDOC=66|CON='||sbCadeScrip;

        isbWhat := 'BEGIN
                      SetSystemEnviroment;
                      Errors.Initialize;
                      FIDF( '||onuScheduleProcessAux||' );
                      if( DAGE_Process_Schedule.fsbGetFrequency( '||onuScheduleProcessAux||' ) in ( GE_BOSchedule.csbSoloUnaVez, GE_BOSchedule.csbSoloUnaVezDH ) ) then
                        GE_BOSchedule.InactiveSchedule( '||onuScheduleProcessAux||' );
                      end if;
                    EXCEPTION
                      when OTHERS then
                        Errors.SetError;
                        if( DAGE_Process_Schedule.fsbGetFrequency( '||onuScheduleProcessAux||' ) in ( GE_BOSchedule.csbSoloUnaVez, GE_BOSchedule.csbSoloUnaVezDH ) ) then
                          GE_BOSchedule.DropSchedule( '||onuScheduleProcessAux||' );
                        end if;
                    END;';
        ut_trace.trace('isbWhat ['||isbWhat||']', 10);
        GE_BOSchedule.PrepareSchedule(inuExecutable,isbParameters,isbWhat,onuScheduleProcessAux);

        --se crea programacion
        GE_BOSchedule.Scheduleprocess(onuScheduleProcessAux,isbFrecuency,idtNextDate);

        COMMIT;      
    END programar;
  BEGIN

    pkerrors.Push('FPGFE'); 
 -- Consultamos datos para inicializar el proceso
    SELECT to_number(TO_CHAR(SYSDATE,'YYYY')) ,
            to_number(TO_CHAR(SYSDATE,'MM')) ,
            userenv('SESSIONID') ,
            USER
          INTO nuparano,
            nuparmes,
            nutsess,
            sbparuser
    FROM dual;
   -- Inicializamos el proceso
    ldc_proinsertaestaprog(nuparano,nuparmes,'FPGFE','En ejecucion',nutsess,sbparuser);
    FOR reg IN cugetFacturas  LOOP
         programar(reg.factpefa);  
         nuConta := nuConta + 1;
    END LOOP;
    ldc_proactualizaestaprog(nutsess,sbMensError||' '||nuConta,'FPGFE','OK');
    pkErrors.Pop; 

 EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
            PKG_ERROR.GetError(onuError,sbMensError);             
            ldc_proactualizaestaprog(nutsess,sbMensError,'FPGFE','error');
            ROLLBACK;
      WHEN OTHERS THEN
          PKG_ERROR.setError;
          PKG_ERROR.GetError(onuError,sbMensError);           
          ldc_proactualizaestaprog(nutsess,sbMensError,'FPGFE','error');
          ROLLBACK;
 END FPGFE;
 /
 begin
  pkg_utilidades.prAplicarPermisos('FPGFE', 'OPEN');
end;
/