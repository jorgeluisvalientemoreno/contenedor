CREATE OR REPLACE PROCEDURE GOPCVNEL (
    inuProgramacion   IN ge_process_schedule.process_schedule_id%TYPE)
AS

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : GOPCVNEL 
    Descripcion     : Procedimiento Asociado al PB GOPCVNEL
    Autor           : 
    Fecha           :  
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     16-04-2024  OSF-2580    Envio de correo por medio de pkg_Correo
                                        Ajustes últimos estándares
    jpinedc     05-08-2024  OSF-2973    Se modifica para ejecución por medio de
										Cadena de Jobs
    ***************************************************************************/
    
    numerror            NUMBER;
    sbmessage           VARCHAR2 (2000);

    sbParametros        GE_PROCESS_SCHEDULE.PARAMETERS_%TYPE;
    nuHilos             NUMBER := 1;
    nuLogProceso        GE_LOG_PROCESS.LOG_PROCESS_ID%TYPE;

    sbProcessProg       estaprog.esprprog%TYPE;

    dtfecha             DATE;

    nuTotalThreads      NUMBER;

    CURSOR cuCantExcep IS
        SELECT COUNT (1)
          FROM LDC_VENT_EXC_COMISION
         WHERE status_ = 'E';

    nuCantIni           NUMBER;

BEGIN

    pkg_Traza.Trace ('GOPCVNEL: INICIA GOPCVNEL', 1);
    
    -- se adiciona al log de procesos
    ge_boschedule.AddLogToScheduleProcess (inuProgramacion,
                                           nuHilos,
                                           nuLogProceso);

    OPEN cuCantExcep;
    FETCH cuCantExcep INTO nuCantIni;
    CLOSE cuCantExcep;

    sbProcessProg := 'GOPCVNEL_' || sqesprprog.NEXTVAL;

    -- se obtiene parametros
    pkg_Traza.Trace ('GOPCVNEL: se obtiene parametros', 1);
    sbParametros := dage_process_schedule.fsbGetParameters_ (inuProgramacion);

    pkg_Traza.Trace ('GOPCVNEL: se separan parametros', 1);

    dtfecha :=
        TO_DATE (ut_string.getparametervalue (sbParametros,
                                              'NEXT_ATTEMP_DATE',
                                              '|',
                                              '='));

    nuTotalThreads :=
        NVL (
            pkg_BCLD_Parameter.fnuObtieneValorNumerico ('LDC_NUM_HILOS_GOPCVNEL'),
            1);

    LDC_BCSALESCOMMISSION_NEL.pProcCadJobsGOPCVNEL 
    ( 
        isbProcessProg  =>  sbProcessProg, 
        inuTotalThreads =>  nuTotalThreads,
        idtfecha        =>  dtfecha, 
        inuProgramacion =>  inuProgramacion,
        inuCantIni      =>  nuCantIni  
    );      
    
    ge_boschedule.changelogProcessStatus (nuLogProceso, 'F');

    pkg_Traza.Trace ('GOPCVNEL: FIN ', 1);
    pkg_Traza.Trace ('GOPCVNEL: Fin GOPCVNEL', 1);
    
EXCEPTION
    WHEN pkg_Error.CONTROLLED_ERROR
    THEN
        pkg_Error.getError (numerror, sbmessage);
        pkg_Traza.Trace (numerror || ' - ' || sbmessage);
        RAISE pkg_Error.CONTROLLED_ERROR;
    WHEN OTHERS
    THEN
        pkg_Error.setError;
        pkg_Error.getError (numerror, sbmessage);
        pkg_Traza.Trace (numerror || ' - ' || sbmessage);        
        RAISE pkg_Error.CONTROLLED_ERROR;
END GOPCVNEL;
/