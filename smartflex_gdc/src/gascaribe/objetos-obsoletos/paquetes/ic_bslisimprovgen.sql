CREATE OR REPLACE PACKAGE IC_BSLisimProvGen AS
    /*
        Propiedad intelectual de Open International Systems. (c).

        Package : IC_BSLisimProvGen

        Descripcion : Generacion de Provision de Cartera por el metodo LISIM

        Autor : Claudia Liliana Rodriguez
        Fecha : 23-03-2012

        Historia de Modificaciones
        Fecha    IDEntrega

        22-11-2013  arendon.SAO224405
        Se modifica el metodo <ProcessLisimProvGen>

        06-09-2012  gduque.SAO190449
        Se modifica <ProcessLisimProvGen> para adicionar el parametro Proceso Programado.

        23-03-2012 crodriguezSAO180613
        Creacion.
    */
    -----------------------
    -- Constantes Packages
    -----------------------

    -----------------------
    -- Variables Packages
    -----------------------
    -----------------------
    -- Elementos Packages
    -----------------------

    -- Obtiene la Version actual del Paquete
    FUNCTION fsbVersion RETURN VARCHAR2;

    -- Ejecuta las validaciones del proceso e inicia la ejecucion de la
    -- provision de cartera usando el metodo LISIM
    PROCEDURE ProcessLisimProvGen
    (
        idtProcessDate  IN DATE,
        inuThreadNumber IN NUMBER,
        inuThread       IN NUMBER,
        inuProcProg     IN ge_process_schedule.process_schedule_id%TYPE,
        isbEstaprog     IN estaprog.esprprog%TYPE

    );

    PROCEDURE GenerateMovs
    (
        onuErrorCode    OUT ge_error_log.error_log_id%TYPE,
        osbErrorMessage OUT ge_error_log.description%TYPE
    );

END IC_BSLisimProvGen;
/
CREATE OR REPLACE PACKAGE BODY IC_BSLisimProvGen AS
    /*
     Propiedad intelectual de Open International Systems. (c).

     Package : IC_BSLisimProvGen

     Descripcion :  Generacion de Provision de Cartera por el metodo LISIM

     Autor : Claudia Liliana Rodriguez
     Fecha : 23-03-2012

     Historia de Modificaciones
     Fecha    IDEntrega

     14-12-2013  arendon.SAO227508
     Se modifica el metodo <ProcessLisimProvGen>.

     22-11-2013  arendon.SAO224405
     Se modifica el metodo <ProcessLisimProvGen>

     01-10-2012  gduque.SAO183760
     Se modifica el metoddo <ProcessLisimProvGen>.

     12-09-2012  gduque.SAO190015
     Se modifica el metoddo <ProcessLisimProvGen>

     06-09-2012  gduque.SAO190449
     Se modifica <ProcessLisimProvGen> para adicionar el parametro Proceso Programado.

     16-08-2012  gduqueSAO188626
     Se modifica el metodo <ProcessLisimProvGen> para que tenga en cuenta la
     concurrencia de procesos.

     13-08-2012  gduqueSAO188355
     Se modifica el metodo <ProcessLisimProvGen>.

     23-03-2012 crodriguezSAO180613
     Creacion.
    */

    ------------------
    -- Variables
    ------------------
    sbErrMsg VARCHAR2(2000); -- Mensajes de error

    -- Esta constante se debe modificar cada vez que se entregue el
    -- paquete con un SAO
    csbVersion CONSTANT VARCHAR2(250) := 'SAO227508';
    -- Obtiene informacion del proceso
    sbEstaprog estaprog.esprprog%TYPE;

    /*
        Propiedad intelectual de Open International Systems. (c).

        Funcion     :  fsbVersion
        Descripcion :  Obtiene el SAO que identifica la version asociada a la
                       ultima entrega del paquete

        Parametros  :       Descripcion
        Retorno :
          csbVersion        Version del Paquete

        Autor     :  Claudia Liliana Rodriguez
        Fecha       :  23-03-2012

        Historia de Modificaciones
        Fecha       ID Entrega

        23-03-2012 crodriguezSAO180613
        Creacion.
    */
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        pkErrors.Push('IC_BSLisimProvGen.fsbVersion');

        pkErrors.Pop;
        -- Retorna el SAO con que se realizo la ultima entrega
        RETURN(csbVersion);
    END fsbVersion;

    /*
        Propiedad intelectual de Open International Systems. (c).

        Procedure : ProcessLisimProvGen

        Descripcion : Generacion y Reversion de provision de Cartera

        Parametros  : Descripcion
            idtProcessDate    Fecha de procesamiento
            inuThreadNumber   Numero de Hilos
            inuThread         Hilo
            isbEstaprog       Estado de proceso
        Retorno     :

        Autor : Claudia Liliana Rodriguez
        Fecha : 23-03-2012

        Historia de Modificaciones
        Fecha    IDEntrega

        14-12-2013  arendon.SAO227508
        Se modifica el metodo anidado ValBasicData.

        22-11-2013  arendon.SAO224405
        Se elimina el parametro isbFrecuencia y se adiciona el parametro
        idtProcessDate.

        01-10-2012  gduque.SAO183760
        Se modifica el nombre del metodo <Proceso> por <Process>.

        12-09-2012  gduque.SAO190015
        Se modifica los metodos <Proceso> e <Initialize>.

        06-09-2012  gduque.SAO190449
        Se modifica <ValInputData> para adicionar Proceso Programado en estaprog

        16-08-2012  gduqueSAO188626
        Se modifica el metodo <Initialize>.

        13-08-2012  gduqueSAO188355
        Se modifica el metodo <ValBasicData>.

        23-03-2012    crodriguezSAO180613
        Creacion.
    */
    PROCEDURE ProcessLisimProvGen
    (
        idtProcessDate  IN DATE,
        inuThreadNumber IN NUMBER,
        inuThread       IN NUMBER,
        inuProcProg     IN ge_process_schedule.process_schedule_id%TYPE,
        isbEstaprog     IN estaprog.esprprog%TYPE
    ) IS
        -- Codigo Error
        nuErrorCode ge_error_log.error_log_id%TYPE;

        -- Mensaje Error
        sbErrorMessage ge_error_log.description%TYPE;

        /*
            Propiedad intelectual de Open International Systems. (c).

            Procedure : Initialize

            Descripcion : Inicializar variables

            Parametros  : Descripcion

            Retorno     :

            Autor : Claudia Liliana Rodriguez
            Fecha : 23-03-2012

            Historia de Modificaciones
            Fecha    IDEntrega

            22-11-2013  arendon.SAO224405
            Se elimina la obtencion de las fechas del proceso ya que la fecha
            de proceso se recibe por parametro.

            12-09-2012  gduque.SAO190015
            Se invoca los metodos <GetProcessDates> y <fdtFinishDate> para obtener
            las fechas de Proceso.

            16-08-2012  gduqueSAO188626
            Se adiciona aplicacion con el hilo asignado

            23-03-2012    crodriguezSAO180613
            Creacion.
        */
        PROCEDURE Initialize IS
        BEGIN

            pkErrors.Push('IC_BSLisimProvGen.ProcessLisimProvGen.Initialize');

            -- Inicializa variables
            pkErrors.Initialize;

            -- Inicializa las variables de error globales
            nuErrorCode    := pkConstante.EXITO;
            sbErrorMessage := pkConstante.NULLSB;

            sbEstaprog := isbEstaprog;

            pkgeneralservices.TraceData('dtfecha: ' || idtProcessDate);
            pkgeneralservices.TraceData('sbEstaprog: ' || sbEstaprog);

            -- Se asigna la aplicacion
            pkErrors.SetApplication('PLISIM-' || inuThread);

            pkErrors.Pop;

        EXCEPTION
            WHEN LOGIN_DENIED
                 OR ex.CONTROLLED_ERROR THEN
                pkErrors.pop;
                RAISE LOGIN_DENIED;
            WHEN pkConstante.exERROR_LEVEL2 THEN
                pkErrors.pop;

                RAISE pkConstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BSLisimProvGen.sbErrMsg);

                pkErrors.pop;
                raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BSLisimProvGen.sbErrMsg);
        END Initialize;

        /*
            Propiedad intelectual de Open International Systems. (c).

            Procedure : ClearMemory
                          Clean Memory
            Descripcion : Limpiar memoria

            Parametros  : Descripcion

            Autor : Claudia Liliana Rodriguez
            Fecha : 23-03-2012

            Historia de Modificaciones
            Fecha    IDEntrega

            23-03-2012    crodriguezSAO180613
            Creacion.
        */
        PROCEDURE ClearMemory IS
        BEGIN

            pkErrors.Push('IC_BSLisimProvGen.ProcessLisimProvGen.ClearMemory');

            -- Limpia toda la memoria cache

            -- Provision de Cartera
            pktblIc_cartprov.ClearMemory;

            -- Cartera
            pktblic_cartcoco.ClearMemory;

            -- Configuracion de variables LISIM
            pktblic_confpuvl.ClearMemory;

            -- Detalle de LISIM
            pktblic_detlisim.ClearMemory;

            pkErrors.Pop;

        EXCEPTION
            WHEN LOGIN_DENIED
                 OR ex.CONTROLLED_ERROR THEN
                pkErrors.pop;
                RAISE LOGIN_DENIED;
            WHEN pkConstante.exERROR_LEVEL2 THEN
                pkErrors.pop;

                RAISE pkConstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BSLisimProvGen.sbErrMsg);

                pkErrors.pop;
                raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BSLisimProvGen.sbErrMsg);

        END ClearMemory;

        /*
            Propiedad intelectual de Open International Systems. (c).

            Procedimiento   :   ValInputData
            Descripcion     :   Valida los datos de entrada del proceso

            Autor     :  Claudia Liliana Rodriguez
            Fecha       :  23-03-2012

            Historia de Modificaciones
            Fecha       ID Entrega
            Modificacion

            06-09-2012  gduque.SAO190449
            Se adiciona Proceso Programado en estaprog

            23-03-2012  crodriguezSAO180613
            Creacion.
        */
        PROCEDURE ValInputData IS
        BEGIN

            pkErrors.Push('IC_BSLisimProvGen.ProcessLisimProvGen.ValInputData');

            -- Valida que exista un registro con el correspondiente key,
            -- si no existe lo crea en la tabla ESTAPROG
            pkStatusExeProgramMgr.ValidateRecordAT(sbEstaprog);

            -- Actualizar Proceso Programado
            pkStatusExeProgramMgr.UpExeProgProgProc(sbEstaprog, inuProcProg);

            pkErrors.Pop;

        EXCEPTION
            WHEN LOGIN_DENIED
                 OR ex.CONTROLLED_ERROR THEN
                pkErrors.pop;
                RAISE LOGIN_DENIED;
            WHEN pkConstante.exERROR_LEVEL2 THEN
                pkErrors.pop;

                RAISE pkConstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BSLisimProvGen.sbErrMsg);

                pkErrors.pop;
                raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BSLisimProvGen.sbErrMsg);
        END ValInputData;

        /*
            Propiedad intelectual de Open International Systems. (c).

            Procedimiento   :   ValBasicData
            Descripcion     :   Valida los datos basicos para el proceso

            Autor     :  Claudia Liliana Rodriguez
            Fecha       :  23-03-2012

            Historia de Modificaciones
            Fecha       ID Entrega
            Modificacion

            14-12-2013  arendon.SAO227508
            Se modifica para crear el registro de control de proceso para
            el ultimo dia del mes.

            13-08-2012  gduqueSAO188355
            Se realiza truncate a la tabla ic_moviprov

            23-03-2012  crodriguezSAO180613
            Creacion.
        */
        PROCEDURE ValBasicData IS
        BEGIN
            pkErrors.Push('IC_BSLisimProvGen.ProcessLisimProvGen.ValBasicData');

            pkBOProcessConcurrenceCtrl.GenControlProcessAT(to_char(last_day(idtProcessDate), 'DD-MM-YYYY'), 'IC_BSLisimProvGen.ProcessLisimProvGen');

            pkErrors.Pop;

        EXCEPTION
            WHEN LOGIN_DENIED
                 OR ex.CONTROLLED_ERROR THEN
                pkErrors.pop;
                RAISE LOGIN_DENIED;
            WHEN pkConstante.exERROR_LEVEL2 THEN
                pkErrors.pop;

                RAISE pkConstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BSLisimProvGen.sbErrMsg);

                pkErrors.pop;
                raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BSLisimProvGen.sbErrMsg);
        END ValBasicData;

        /*
        Propiedad intelectual de Open International Systems. (c).

        Procedimiento   :   Process
        Descripcion     :   Procesar provision de cartera LISIM

        Autor     :  Claudia Liliana Rodriguez
        Fecha       :  23-03-2012

        Historia de Modificaciones
        Fecha       ID Entrega
        Modificacion

        22-11-2013  arendon.SAO224405
        Se envia la fecha de procesamiento al metodo
        <IC_BOLisimprovGen.ProcessLisimGen>

        01-10-2012  gduque.SAO183760
        Se invoca al metodo <GetProcessInitData>.

        12-09-2012  gduque.SAO190015
        Se elimina el parametro dtfecha del metodo <ProcessLisimGen>

        23-03-2012  crodriguezSAO180613
        Creacion.
        */
        PROCEDURE Process IS

            -- Total Registros a Procesar
            nuTotalRegistros NUMBER := 0;

            -- Primer registro a usar
            nuPrimerRegistro ic_cartcoco.cacccons%TYPE;

            -- Tipos de Producto a Excluir
            sbTyPrEx VARCHAR2(30);

        BEGIN
            pkErrors.Push('IC_BSLisimProvGen.ProcessLisimProvGen.Process');

            -- Obtiene tipos de producto a excluir
            sbTyPrEx := ic_boprodtypexcprov.fnuGetProdTypExc;
            pkgeneralservices.TraceData('sbTyPrEx ' || sbTyPrEx);
            pkgeneralservices.TraceData('dtFechaInfo ' || idtProcessDate);
            pkgeneralservices.TraceData('inuThreadNumber ' || inuThreadNumber);
            pkgeneralservices.TraceData('inuThread ' || inuThread);
            -- Obtiene la cantidad de registros a procesar
            IC_BCLisimProvGen.GetProcessInitData(idtProcessDate, sbTyPrEx, inuThreadNumber, inuThread, nuTotalRegistros, nuPrimerRegistro);

            pkgeneralservices.TraceData('nuPrimerRegistro ' ||
                                        nuPrimerRegistro);
            -- Inicializa el estado del proceso en ESTAPROG
            pkStatusExeProgramMgr.UpStatusExeProgramAT(isbEstaprog, 'Inicio Generacion de Provision de Cartera LISIM', nuTotalRegistros, 0);

            -- Ejecucion del Proceso
            IC_BOLisimprovGen.ProcessLisimGen(sbEstaprog, idtProcessDate, sbTyPrEx, nuPrimerRegistro, inuThreadNumber, inuThread);

            -- Termina Control de concurrencia de procesos
            pkBOProcessConcurrenceCtrl.FinConcurrenceControl(to_char(last_day(idtProcessDate), 'DD-MM-YYYY'));

            -- Finaliza el estado del proceso
            pkStatusExeProgramMgr.ProcessFinishOKAT(sbEstaprog);

            pkErrors.Pop;

        EXCEPTION
            WHEN LOGIN_DENIED
                 OR ex.CONTROLLED_ERROR THEN
                pkErrors.pop;
                RAISE LOGIN_DENIED;
            WHEN pkConstante.exERROR_LEVEL2 THEN
                pkErrors.pop;

                RAISE pkConstante.exERROR_LEVEL2;
            WHEN OTHERS THEN
                pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BSLisimProvGen.sbErrMsg);

                pkErrors.pop;
                raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BSLisimProvGen.sbErrMsg);
        END Process;

    BEGIN

        pkErrors.Push('IC_BSLisimProvGen.ProcessLisimProvGen');

        -- Inicializar variables para proceso
        Initialize;

        -- Valida los datos de entrada
        ValInputData;

        -- Valida los datos necesarios para el proceso
        ValBasicData;

        -- Limpiar memoria cache
        ClearMemory;

        -- Procesar
        Process;

        pkErrors.Pop;
    EXCEPTION
        WHEN LOGIN_DENIED
             OR ex.CONTROLLED_ERROR THEN
            pkErrors.pop;
            -- Se realiza el registro en ESTAPROG
            pkErrors.GetErrorVar(nuErrorCode, sbErrorMessage);
            pkStatusExeProgramMgr.ProcessFinishNOKAT(isbEstaprog, sbErrorMessage);
            RAISE LOGIN_DENIED;
        WHEN pkConstante.exERROR_LEVEL2 THEN
            pkErrors.pop;
            -- Se realiza el registro en ESTAPROG
            pkErrors.GetErrorVar(nuErrorCode, sbErrorMessage);
            pkStatusExeProgramMgr.ProcessFinishNOKAT(isbEstaprog, sbErrorMessage);
            RAISE pkConstante.exERROR_LEVEL2;
        WHEN OTHERS THEN
            pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BSLisimProvGen.sbErrMsg);

            pkErrors.pop;
            -- Se realiza el registro en ESTAPROG
            pkErrors.GetErrorVar(nuErrorCode, sbErrorMessage);
            pkStatusExeProgramMgr.ProcessFinishNOKAT(isbEstaprog, sbErrorMessage);
            raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BSLisimProvGen.sbErrMsg);
    END ProcessLisimProvGen;

    /*
        Propiedad intelectual de Open International Systems. (c).

        Procedure : GenerateMovs
        Descripcion : Generacion de movimientos provisionados

        Parametros  : Descripcion

        Retorno     :

        Autor : Claudia Liliana Rodriguez Garcia
        Fecha : 17-04-2012

        Historia de Modificaciones
        Fecha    IDEntrega

        17-04-2012    crodriguezSAO180613
        Creacion.
    */
    PROCEDURE GenerateMovs
    (
        onuErrorCode    OUT ge_error_log.error_log_id%TYPE,
        osbErrorMessage OUT ge_error_log.description%TYPE
    ) IS

        -- Estado Proceso
        sbEstaprog estaprog.esprprog%TYPE;
        /*
            Propiedad intelectual de Open International Systems. (c).

            Procedure : Initialize

            Descripcion : Inicializar variables

            Parametros  : Descripcion

            Retorno     :

            Autor :Claudia Liliana Rodriguez
            Fecha : 17-04-2012

            Historia de Modificaciones
            Fecha    IDEntrega

            17-04-2012    crodriguezSAO180613
            Creacion.
        */
        PROCEDURE Initialize IS
        BEGIN
            pkErrors.Push('IC_BSLisimProvGen.GenerateMovs.Initialize');

            -- Inicializa variables
            pkErrors.Initialize;

            -- Inicializa las variables de error globales
            onuErrorCode    := pkConstante.EXITO;
            osbErrorMessage := pkConstante.NULLSB;

            -- Obtener Id estado
            sbEstaprog := pkStatusExeProgramMgr.fsbGetProgramID('PLISIM');

            -- Valida que exista un registro con el correspondiente key,
            -- si no existe lo crea en la tabla ESTAPROG
            pkStatusExeProgramMgr.ValidateRecordAT(sbEstaprog);

            pkErrors.Pop;

        EXCEPTION
            WHEN LOGIN_DENIED
                 OR pkConstante.exERROR_LEVEL2 THEN
                pkErrors.Pop;
                RAISE LOGIN_DENIED;

            WHEN OTHERS THEN
                pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BSLisimProvGen.sbErrMsg);

                pkErrors.pop;
                raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BSLisimProvGen.sbErrMsg);

        END Initialize;

    BEGIN

        pkErrors.Push('IC_BSLisimProvGen.GenerateMovs');

        Initialize;

        -- Actualiza el estado del proceso
        pkStatusExeProgramMgr.UpStatusExeProgramAT(sbEstaprog, 'Generando Movimientos de Provision de Cartera...', 1, 0);

        -- Generar Movimientos
        IC_BOLisimProvGen.GenerateMovs;

        pkStatusExeProgramMgr.UpStatusExeProgramAT(sbEstaprog, 'Procesando...', 1, 1);

        pkStatusExeProgramMgr.ProcessFinishOKAT(sbEstaprog);

        pkErrors.Pop;
    EXCEPTION
        WHEN LOGIN_DENIED
             OR ex.CONTROLLED_ERROR THEN
            pkErrors.pop;
            -- Se realiza el registro en ESTAPROG
            pkErrors.GetErrorVar(onuErrorCode, osbErrorMessage);
            pkStatusExeProgramMgr.ProcessFinishNOKAT(sbEstaprog, osbErrorMessage);
            RAISE LOGIN_DENIED;
        WHEN pkConstante.exERROR_LEVEL2 THEN
            pkErrors.pop;
            -- Se realiza el registro en ESTAPROG
            pkErrors.GetErrorVar(onuErrorCode, osbErrorMessage);
            pkStatusExeProgramMgr.ProcessFinishNOKAT(sbEstaprog, osbErrorMessage);
            RAISE pkConstante.exERROR_LEVEL2;
        WHEN OTHERS THEN
            pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, IC_BSLisimProvGen.sbErrMsg);

            pkErrors.pop;
            -- Se realiza el registro en ESTAPROG
            pkErrors.GetErrorVar(onuErrorCode, osbErrorMessage);
            pkStatusExeProgramMgr.ProcessFinishNOKAT(sbEstaprog, osbErrorMessage);
            raise_application_error(pkConstante.nuERROR_LEVEL2, IC_BSLisimProvGen.sbErrMsg);
    END GenerateMovs;

END IC_BSLisimProvGen;
/
GRANT EXECUTE on IC_BSLISIMPROVGEN to SYSTEM_OBJ_PRIVS_ROLE;
GRANT EXECUTE on IC_BSLISIMPROVGEN to REXEOPEN;
GRANT EXECUTE on IC_BSLISIMPROVGEN to RSELSYS;
/
