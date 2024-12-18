CREATE OR REPLACE PACKAGE adm_person.pkg_scheduler IS
/*******************************************************************************
    Package:        pkg_scheduler
    Descripción:    Paquete con procedimientos para gestión de Jobs, Programas y Schedules
    Autor:          Juan Gabriel Catuche Girón 
    Fecha:          03/04/2023

    Historial de Modificaciones
    =============================
    FECHA           AUTOR               Descripción
    03/04/2023      jcatuchemvm         OSF-1299 : Creación el paquete 
    03/04/2023      jpinedc             OSF-1299 : Creación metodos cadena de jobs
    05/07/2023      jpinedc             OSF-1299 : Se cambia el nombre de ldc_scheduler
													a pkg_scheduler
    05/07/2023      jpinedc             OSF-1299 : Se pasa el paquete a adm_person
    26/07/2023      jpinedc             OSF-1194 : Se crea el método ftbProgramas
    13/09/2023      jpinedc             OSF-1558 : Se modifica el método run_chain
    21/11/2023      jpinedc             OSF-1938 : * Se crean cuUSER_SCHED_FAILED_CHAINS Y
												   fblUltEjecCadJobConError
                                                   * Se cambia ut_trace por pkg_Traza 
    22/02/2023      jpinedc             OSF-2513 : * Se crean : fsbAction, ftbArgumentos , 
                                                    tyRcPrograma, tytbSchedChainProg, rcRecordRuleNull
													* se usa rcRecordRuleNull en ClearMemoryRule
    01/08/2024      jpinedc             OSF-3061 : * Se crea cuUSER_SCHED_RUNNING_CHAINS_J
                                                    * Se borra cuUSER_SCHED_RUNNING_CHAINS 
                                                    * Se modifica fblSchedChainRunning para que use 
                                                    cuUSER_SCHED_RUNNING_CHAINS_J
                                                    * Se borra cuUSER_SCHED_FAILED_CHAINS
                                                    * Se crea cuUSER_SCHED_FAILED_CHAINS_J
                                                    * Se modifica fblUltEjecCadJobConError para
                                                    que use cuUSER_SCHED_FAILED_CHAINS_J
                                                    * Se modifica define_chain_step para que
                                                    valide que la longitud del nombre del paso
                                                    no sea mayor al valor del parametro 
                                                    cnuMAX_LONG_STEP_NAME
                                                    * Se modifica cuUSER_SCHEDULER_CHAIN_RULE
                                                    haciendo trim a los valores del registro
                                                    ya que en algunos casos se estan agreando
                                                    espacios al final de la accion                                                   
*******************************************************************************/
    --------------------------------------------
    --  Type and Subtypes
    --------------------------------------------

    -- Define registro de colecciones
    
    
    -- Cursor para accesar USER_SCHEDULER_PROGRAMS
    CURSOR cuUSER_SCHEDULER_PROGRAMS
    (
        isbPROGRAM_NAME IN USER_SCHEDULER_PROGRAMS.PROGRAM_NAME%TYPE
    )
    IS
        SELECT  *
        FROM    USER_SCHEDULER_PROGRAMS
        WHERE   PROGRAM_NAME = isbPROGRAM_NAME;
        
    -- Cursor para accesar USER_SCHEDULER_SCHEDULES
    CURSOR cuUSER_SCHEDULER_SCHEDULES
    (
        isbSCHEDULE_NAME IN USER_SCHEDULER_SCHEDULES.SCHEDULE_NAME%TYPE
    )
    IS
        SELECT  *
        FROM    USER_SCHEDULER_SCHEDULES
        WHERE   SCHEDULE_NAME = isbSCHEDULE_NAME;
        
    -- Cursor para accesar USER_SCHEDULER_JOBS
    CURSOR cuUSER_SCHEDULER_JOBS
    (
        isbJOB_NAME IN USER_SCHEDULER_JOBS.JOB_NAME%TYPE
    )
    IS
        SELECT  *
        FROM    USER_SCHEDULER_JOBS
        WHERE   JOB_NAME = isbJOB_NAME;

    -- Cursor para accesar USER_SCHEDULER_RUNNING_CHAINS
    CURSOR cuUSER_SCHED_RUNNING_CHAINS_J( isbJobName VARCHAR2)
    IS
        SELECT *
        FROM USER_SCHEDULER_RUNNING_CHAINS
        WHERE job_name = isbJobName
        AND state = 'RUNNING';        

    -- Cursor para accesar USER_SCHEDULER_CHAINS        
    CURSOR cuUSER_SCHED_CHAINS(isbChainName VARCHAR2)
    IS
        SELECT *
        FROM USER_SCHEDULER_CHAINS
        WHERE chain_name = isbChainName;

    -- Cursor para accesar USER_SCHEDULER_CHAIN_STEPS        
    CURSOR cuSCHED_CHAIN_STEPS(isbChainName VARCHAR2) 
    IS
        SELECT * FROM USER_SCHEDULER_CHAIN_STEPS
        WHERE chain_name = isbChainName;
        
    CURSOR cuUSER_SCHEDULER_CHAIN_STEP(isbChainName VARCHAR2, isbStepName VARCHAR2)
    IS
        SELECT * FROM USER_SCHEDULER_CHAIN_STEPS
        WHERE chain_name = isbChainName
        AND step_name =  isbStepName;
        
    CURSOR cuUSER_SCHEDULER_CHAIN_RULE(isbChainName VARCHAR2, isbCondition VARCHAR2, isbAction VARCHAR2)
    IS
        SELECT * FROM USER_SCHEDULER_CHAIN_RULES
        WHERE chain_name = upper(isbChainName)
        AND TRIM(UPPER(condition)) =  upper(isbCondition)
        AND TRIM(REPLACE(action,'"','')) = upper(isbAction);

    -- Cursor para accesar USER_SCHEDULER_PROGRAMS
    CURSOR cuProgramas
    (
        isbCadena IN USER_SCHEDULER_PROGRAMS.PROGRAM_NAME%TYPE
    )
    IS
        SELECT  *
        FROM    USER_SCHEDULER_PROGRAMS
        WHERE   PROGRAM_NAME LIKE UPPER('%' || isbCadena || '%');
        
    TYPE tytbProgramas IS TABLE OF cuProgramas%ROWTYPE INDEX BY BINARY_INTEGER;
         
    -- Cursor para accesar USER_SCHEDULER_RUNNING_CHAINS con pasos fallidos
    CURSOR cuUSER_SCHED_FAILED_CHAINS_J( isbJobName VARCHAR2)
    IS
        SELECT *
        FROM USER_SCHEDULER_RUNNING_CHAINS rc1
        WHERE rc1.job_name = isbJobName
        AND state IN ('FAILED','STOPPED','STALLED' );        
          
    -- Obtiene los argumentos de un método
    CURSOR cuArgumentos( isbPropietario VARCHAR2,isbPaquete VARCHAR2, isbPrograma VARCHAR2) IS
    SELECT ARGUMENT_NAME, DATA_TYPE, POSITION, RPAD(' ',2000,' ') VALUE
    FROM all_arguments
    WHERE NVL(PACKAGE_NAME,'-') = NVL(isbPaquete,'-')
    AND OBJECT_NAME = isbPrograma
    AND OWNER = isbPropietario
    AND DATA_TYPE IS NOT NULL
    ;

    -- Tipo de dato para los argumentos de un método
    TYPE tytbArgumentos      IS TABLE OF cuArgumentos%ROWTYPE INDEX BY VARCHAR2(100);
    
    -- Tipo record para un programa
    TYPE tyRcPrograma IS RECORD(
        PROGRAM_NAME VARCHAR2(100),
        PACKAGE VARCHAR2(100),
        API VARCHAR2(100),
        PROGRAM_TYPE VARCHAR2(50),
        BLOQUEPL VARCHAR2(4000),
        STEP VARCHAR2(50),
        PROGRAM_ACTION VARCHAR2(4000)
    );

    TYPE tytbSchedChainProg IS TABLE OF tyRcPrograma INDEX BY BINARY_INTEGER;    
            
    -- Retorna la constante con la ultimo caso que lo modificó
    FUNCTION fsbVersion RETURN VARCHAR2; 
    
    -- Limpiar la memoria Program
    PROCEDURE ClearMemoryProgram;
    
    -- Limpiar la memoria Schedule
    PROCEDURE ClearMemorySchedule;
    
    -- Limpiar la memoria Job
    PROCEDURE ClearMemoryJob;
    
    -- Valida si existe un programa 
    FUNCTION fblExistProgram(isbPROGRAM_NAME IN USER_SCHEDULER_PROGRAMS.PROGRAM_NAME%TYPE, inuCACHE IN NUMBER DEFAULT 1) RETURN BOOLEAN;
    
    -- Valida si existe un schedule 
    FUNCTION fblExistSchedule(isbSCHEDULE_NAME IN USER_SCHEDULER_SCHEDULES.SCHEDULE_NAME%TYPE, inuCACHE IN NUMBER DEFAULT 1) RETURN BOOLEAN;
    
    -- Valida si existe un Job 
    FUNCTION fblExistJob(isbJOB_NAME IN USER_SCHEDULER_JOBS.JOB_NAME%TYPE, inuCACHE IN NUMBER DEFAULT 1) RETURN BOOLEAN;
    
    -- Registra un Programa 
    PROCEDURE create_program
    (
        program_name        IN user_scheduler_programs.PROGRAM_NAME%TYPE,
        program_type        IN user_scheduler_programs.PROGRAM_TYPE%TYPE,
        program_action      IN user_scheduler_programs.PROGRAM_ACTION%TYPE,
        number_of_arguments IN user_scheduler_programs.NUMBER_OF_ARGUMENTS%TYPE DEFAULT 0,
        enabled             IN BOOLEAN DEFAULT FALSE,
        comments            IN user_scheduler_programs.COMMENTS%TYPE DEFAULT NULL,
        codeError           OUT NUMBER,
        messageError        OUT VARCHAR2 
    );
    
    -- Define argumentos para programas sin Default Value
    PROCEDURE define_program_argument
    (
        program_name        IN user_scheduler_program_args.PROGRAM_NAME%TYPE,
        argument_position   IN user_scheduler_program_args.ARGUMENT_POSITION%TYPE,
        argument_name       IN user_scheduler_program_args.ARGUMENT_NAME%TYPE DEFAULT NULL,
        argument_type       IN user_scheduler_program_args.ARGUMENT_TYPE%TYPE,
        codeError           OUT NUMBER,
        messageError        OUT VARCHAR2
    );
    
    -- Define argumentos para programas con Default Value
    PROCEDURE define_program_argument
    (
        program_name        IN  user_scheduler_program_args.PROGRAM_NAME%TYPE,
        argument_position   IN  user_scheduler_program_args.ARGUMENT_POSITION%TYPE,
        argument_name       IN  user_scheduler_program_args.ARGUMENT_NAME%TYPE DEFAULT NULL,
        argument_type       IN  user_scheduler_program_args.ARGUMENT_TYPE%TYPE,
        default_value       IN  user_scheduler_program_args.default_value%TYPE DEFAULT NULL,
        codeError           OUT  NUMBER,
        messageError        OUT  VARCHAR2
    );
    
    -- Borra programa
    PROCEDURE drop_program
    (
        program_name        IN user_scheduler_programs.PROGRAM_NAME%TYPE,
        force               IN BOOLEAN DEFAULT FALSE,
        codeError           OUT NUMBER,
        messageError        OUT VARCHAR2
    );
    
    -- Borra argumento de programa por posición o por nombre
    PROCEDURE drop_program_argument
    (
        program_name        IN user_scheduler_program_args.PROGRAM_NAME%TYPE,
        argument_position   IN user_scheduler_program_args.ARGUMENT_POSITION%TYPE,
        argument_name       IN user_scheduler_program_args.ARGUMENT_NAME%TYPE DEFAULT NULL,
        codeError           OUT NUMBER,
        messageError        OUT VARCHAR2 
    );
    
    -- Registra schedule
    PROCEDURE create_schedule
    (
        schedule_name       IN user_scheduler_schedules.SCHEDULE_NAME%TYPE,
        start_date          IN user_scheduler_schedules.START_DATE%TYPE DEFAULT NULL,
        repeat_interval     IN user_scheduler_schedules.REPEAT_INTERVAL%TYPE,
        end_date            IN user_scheduler_schedules.END_DATE%TYPE DEFAULT NULL,
        comments            IN user_scheduler_schedules.COMMENTS%TYPE DEFAULT NULL,
        codeError           OUT NUMBER,
        messageError        OUT VARCHAR2
    );
    
    -- Evalua repat interval de un schedule
    PROCEDURE evaluate_calendar_string
    (
        calendar_string     IN user_scheduler_schedules.REPEAT_INTERVAL%TYPE,
        start_date          IN user_scheduler_schedules.START_DATE%TYPE,
        return_date_after   IN user_scheduler_schedules.END_DATE%TYPE DEFAULT NULL,
        next_run_date       OUT user_scheduler_schedules.END_DATE%TYPE,
        codeError           OUT NUMBER,
        messageError        OUT VARCHAR2
    );
    
    -- Borra schedule
    PROCEDURE drop_schedule
    (
        schedule_name       IN user_scheduler_schedules.SCHEDULE_NAME%TYPE,
        force               IN BOOLEAN DEFAULT FALSE,
        codeError           OUT NUMBER,
        messageError        OUT VARCHAR2
    );
    
    -- Registra un Job 
    PROCEDURE create_job
    (
        job_name            IN user_scheduler_jobs.JOB_NAME%TYPE,
        program_name        IN user_scheduler_jobs.PROGRAM_NAME%TYPE DEFAULT NULL,
        schedule_name       IN user_scheduler_jobs.SCHEDULE_NAME%TYPE DEFAULT NULL,
        job_style           IN user_scheduler_jobs.JOB_STYLE%TYPE DEFAULT 'REGULAR',
        job_type            IN user_scheduler_jobs.JOB_TYPE%TYPE DEFAULT NULL,
        job_action          IN user_scheduler_jobs.JOB_ACTION%TYPE DEFAULT NULL,
        number_of_arguments IN user_scheduler_jobs.NUMBER_OF_ARGUMENTS%TYPE DEFAULT 0,
        start_date          IN user_scheduler_jobs.START_DATE%TYPE DEFAULT NULL,
        repeat_interval     IN user_scheduler_jobs.REPEAT_INTERVAL%TYPE DEFAULT NULL,
        end_date            IN user_scheduler_jobs.END_DATE%TYPE DEFAULT NULL,
        enabled             IN BOOLEAN DEFAULT FALSE,
        auto_drop           IN BOOLEAN DEFAULT TRUE,
        comments            IN user_scheduler_jobs.COMMENTS%TYPE DEFAULT NULL,
        codeError           OUT NUMBER,
        messageError        OUT VARCHAR2
    );
    
    -- Asigna valor a argumentos de Job
    PROCEDURE set_job_argument_value
    (
        job_name            IN user_scheduler_job_args.JOB_NAME%TYPE,
        argument_position   IN user_scheduler_job_args.ARGUMENT_POSITION%TYPE,
        argument_name       IN user_scheduler_job_args.ARGUMENT_NAME%TYPE DEFAULT NULL,
        argument_value      IN user_scheduler_job_args.VALUE%TYPE,
        codeError           OUT NUMBER,
        messageError        OUT VARCHAR2
    );
    
    -- Borra Job
    PROCEDURE drop_job
    (
        job_name            IN user_scheduler_jobs.JOB_NAME%TYPE,
        force               IN BOOLEAN DEFAULT FALSE,
        codeError           OUT NUMBER,
        messageError        OUT VARCHAR2
    );
    
    -- Gestiona Job / Programa
    PROCEDURE control
    (
        name                IN VARCHAR2,
        action              IN VARCHAR2 DEFAULT 'DISABLE',
        force               IN BOOLEAN DEFAULT FALSE,
        codeError           OUT NUMBER,
        messageError        OUT VARCHAR2
    );
    
    -- Habilita programa / job
    PROCEDURE enable
    (
        name                IN VARCHAR2,
        codeError           OUT NUMBER,
        messageError        OUT VARCHAR2
    );
    
    -- Deshabilita programa / job
    PROCEDURE disable
    (
        name                IN VARCHAR2,
        force               IN BOOLEAN DEFAULT FALSE,
        codeError           OUT NUMBER,
        messageError        OUT VARCHAR2
    );
    
    -- Inicia Job
    PROCEDURE run_job
    (
        job_name            IN user_scheduler_jobs.JOB_NAME%TYPE,
        codeError           OUT NUMBER,
        messageError        OUT VARCHAR2
    );
    
    -- Detiene Job
    PROCEDURE stop_job
    (
        job_name            IN user_scheduler_jobs.JOB_NAME%TYPE,
        force               IN BOOLEAN DEFAULT FALSE,
        codeError           OUT NUMBER,
        messageError        OUT VARCHAR2
    );
    
    -- Modifica atributos de un Programa / Job / Schedule 
    PROCEDURE set_attribute
    (
        name                IN VARCHAR2,
        attribute           IN VARCHAR2,
        value               IN VARCHAR2,
        value2              IN VARCHAR2 DEFAULT NULL,
        codeError           OUT NUMBER,
        messageError        OUT VARCHAR2
    );
    
    -- Obtiene atributos de un Programa / Job / Schedule 
    PROCEDURE get_attribute
    (
        name                IN VARCHAR2,
        attribute           IN VARCHAR2,
        value               OUT VARCHAR2,
        value2              OUT VARCHAR2,
        codeError           OUT NUMBER,
        messageError        OUT VARCHAR2
    );
    
    -- Retorna verdadero si la cadena de Jobs esta corriendo y falso en caso contrario
    FUNCTION fblSchedChainRunning( isbChainName VARCHAR2, isbJobName VARCHAR2 DEFAULT NULL) RETURN BOOLEAN;

    -- Retorna verdadero si la cadena de Jobs existe y falso en caso contrario    
    FUNCTION fblSchedChainExists( isbChainName VARCHAR2) RETURN BOOLEAN;
    
    -- Borra la cadena de Jobs isbChainName, sus pasos y programas asociados
    PROCEDURE pDropSchedChain( isbChainName VARCHAR2);
    
    -- Crea una cadena de Jobs
    PROCEDURE create_chain(isbChainName VARCHAR2);
    
    -- Crea un paso de la cadena de Job
    PROCEDURE pCreaSchedChainStep
    (
        isbChainName            IN  VARCHAR2,
        isbChainStepName    IN  VARCHAR2,
        isbprogram_name         IN  VARCHAR2,
        isbprogram_type         IN  VARCHAR2,
        isbprogram_action       IN  VARCHAR2,
        inunumber_of_arguments  IN  NUMBER,
        iblenabled              IN  BOOLEAN,
        isbcomments             IN  VARCHAR2,
        onucodeError            OUT NUMBER,
        osbmessageError         OUT VARCHAR2         
    );    
              
    -- Crea una regla de transición entre pasos de una cadena de Jobs   
    PROCEDURE define_chain_rule 
    (
       isbChainName VARCHAR2,
       isbCondition VARCHAR2,
       isbAction    VARCHAR2
    );

    -- Crea un paso de una cadena de Jobs      
    PROCEDURE define_chain_step
    (
       isbChainName     VARCHAR2,
       isbChainStepName VARCHAR2,
       isbprogram_name  VARCHAR2
    );
    
    -- Ejecuta una cadena de Jobs
    PROCEDURE run_chain(isbChainName VARCHAR2, isbIniSteps VARCHAR2, isbJobName VARCHAR2);
    
    -- Retorna una tabla pl de tipo tytbProgramas
    FUNCTION ftbProgramas( isbCadena VARCHAR2)
    RETURN tytbProgramas;        

	-- Retorna verdadero si uno de los pasos de la cadena de Job quedo en estado FAILED
    FUNCTION fblUltEjecCadJobConError( isbCadena VARCHAR2, isbJob VARCHAR2 DEFAULT NULL)
    RETURN BOOLEAN;   
    
    -- Retorna una tabla Pl con los argumentos de un programa            
    FUNCTION ftbArgumentos( isbPropietario VARCHAR2, isbPaquete VARCHAR2, isbPrograma VARCHAR2)
    RETURN tytbArgumentos;
    
    -- Calcula la cadena para la acción
    FUNCTION fsbAction ( isbPack VARCHAR2, isbApi VARCHAR2 , isbProgType VARCHAR2, isbBloquePl VARCHAR2 ) 
    RETURN VARCHAR2;    
        
END pkg_scheduler;
/

CREATE OR REPLACE PACKAGE BODY  adm_person.pkg_scheduler IS
    ------------------------------------------------------------------------------
    -- Tipos
    ------------------------------------------------------------------------------
    -------------------------
    --  PRIVATE VARIABLES
    -------------------------

    -- Record Tabla USER_SCHEDULER_PROGRAMS
    rcUSER_SCHEDULER_PROGRAMS   cuUSER_SCHEDULER_PROGRAMS%ROWTYPE;
    
    -- Record nulo de la Tabla USER_SCHEDULER_PROGRAMS
    rcRecordProgramNull         cuUSER_SCHEDULER_PROGRAMS%ROWTYPE;
    
    -- Record Tabla USER_SCHEDULER_SCHEDULES
    rcUSER_SCHEDULER_SCHEDULES  cuUSER_SCHEDULER_SCHEDULES%ROWTYPE;

    -- Record Tabla USER_SCHEDULER_CHAIN_STEPS
    rcUSER_SCHEDULER_CHAIN_STEP  cuUSER_SCHEDULER_CHAIN_STEP%ROWTYPE;
    
    -- Record nulo de la Tabla USER_SCHEDULER_SCHEDULES
    rcRecordScheduleNull        cuUSER_SCHEDULER_SCHEDULES%ROWTYPE;
    
    -- Record Tabla cuUSER_SCHEDULER_JOBS
    rcUSER_SCHEDULER_JOBS       cuUSER_SCHEDULER_JOBS%ROWTYPE;
    
    -- Record nulo de la Tabla cuUSER_SCHEDULER_JOBS
    rcRecordJobNull             cuUSER_SCHEDULER_JOBS%ROWTYPE;

    -- Record nulo de la Tabla cuUSER_SCHEDULER_CHAIN_STEPS    
    rcRecordStepNull            cuUSER_SCHEDULER_CHAIN_STEP%ROWTYPE;

    -- Record nulo de la Tabla cuUSER_SCHEDULER_CHAIN_RULE    
    rcRecordRuleNull            cuUSER_SCHEDULER_CHAIN_RULE%ROWTYPE;
    
    rcUSER_SCHEDULER_CHAIN_RULE cuUSER_SCHEDULER_CHAIN_RULE%ROWTYPE;
    
    -------------------------
    --   PRIVATE METHODS   
    -------------------------
    -- Carga Regisro de Programa
    PROCEDURE LoadRecordProgram(isbPROGRAM_NAME IN USER_SCHEDULER_PROGRAMS.PROGRAM_NAME%TYPE);
    -- Valida si existe un programa en memoria
    FUNCTION fblInMemoryProgram(isbPROGRAM_NAME IN USER_SCHEDULER_PROGRAMS.PROGRAM_NAME%TYPE) RETURN BOOLEAN;
    -- Carga Regisro de Schedule
    PROCEDURE LoadRecordSchedule(isbSCHEDULE_NAME IN USER_SCHEDULER_SCHEDULES.SCHEDULE_NAME%TYPE);
    -- Valida si existe un Schedule en memoria
    FUNCTION fblInMemorySchedule(isbSCHEDULE_NAME IN USER_SCHEDULER_SCHEDULES.SCHEDULE_NAME%TYPE) RETURN BOOLEAN;
    -- Carga Regisro de Job
    PROCEDURE LoadRecordJob(isbJOB_NAME IN USER_SCHEDULER_JOBS.JOB_NAME%TYPE);
    -- Valida si existe un job en memoria
    FUNCTION fblInMemoryJob(isbJOB_NAME IN USER_SCHEDULER_JOBS.JOB_NAME%TYPE) RETURN BOOLEAN;
        
    ------------------------------------------------------------------------------
    -- Constantes
    ------------------------------------------------------------------------------
    -- Versión del paquete
    csbVersion              CONSTANT VARCHAR2(15) := 'OSF-3061';
    
    -- Para el control de traza:
    csbSP_NAME              CONSTANT VARCHAR2(32) := $$PLSQL_UNIT||'.';
    cnuNVLTRC               CONSTANT NUMBER := 5;
    CACHE                   CONSTANT NUMBER := 1;   -- Buscar en Cache
    
    cnuMAX_LONG_STEP_NAME   CONSTANT parametros.valor_cadena%TYPE
                            := pkg_parametros.fnuGetValorNumerico('MAX_LONG_STEP_NAME');
    
    PROCEDURE Initializeoutput( onucodeError OUT NUMBER, osbmessageError OUT VARCHAR2 )
    IS
    BEGIN
        onucodeError    := 0;
        osbmessageError := NULL;
    END Initializeoutput;
    
    /*******************************************************************************
    Método:         fsbVersion
    Descripción:    Funcion que retorna la csbVersion, la cual indica el último
                    caso que modificó el paquete. Se actualiza cada que se ajusta 
                    algún Método del paquete
                    
    Autor:          Juan Gabriel Catuche Girón 
    Fecha:          03/04/2023

    Entrada         Descripción
    NA      

    Salida          Descripción
    csbVersion      Ultima version del paquete
    
    Historial de Modificaciones
    =============================
    FECHA           AUTOR               Descripción
    03/04/2023      jcatuchemvm         OSF-889: Creación
    *******************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
    PROCEDURE ClearMemoryProgram IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'ClearMemoryProgram';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        rcUSER_SCHEDULER_PROGRAMS := rcRecordProgramNull;
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
    END ClearMemoryProgram;
    
    PROCEDURE ClearMemorySchedule IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'ClearMemorySchedule';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        rcUSER_SCHEDULER_SCHEDULES := rcRecordScheduleNull;
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
    END ClearMemorySchedule;
    
    PROCEDURE ClearMemoryJob IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'ClearMemoryJob';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        rcUSER_SCHEDULER_JOBS := rcRecordJobNull;
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
    END ClearMemoryJob;

    PROCEDURE ClearMemoryStep IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'ClearMemoryStep';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        rcUSER_SCHEDULER_CHAIN_STEP := rcRecordStepNull;
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
    END ClearMemoryStep;

    PROCEDURE ClearMemoryRule IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'ClearMemoryRule';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        rcUSER_SCHEDULER_CHAIN_RULE := rcRecordRuleNull;
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
    END ClearMemoryRule;
    
    PROCEDURE LoadRecordProgram(isbPROGRAM_NAME IN USER_SCHEDULER_PROGRAMS.PROGRAM_NAME%TYPE) IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'LoadRecordProgram';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);  
          
        IF ( cuUSER_SCHEDULER_PROGRAMS%ISOPEN ) THEN
            CLOSE cuUSER_SCHEDULER_PROGRAMS;
        END IF;
        -- Accesa USER_SCHEDULER_PROGRAMS de la BD
        OPEN cuUSER_SCHEDULER_PROGRAMS(isbPROGRAM_NAME);
        FETCH cuUSER_SCHEDULER_PROGRAMS INTO rcUSER_SCHEDULER_PROGRAMS;
        IF ( cuUSER_SCHEDULER_PROGRAMS%NOTFOUND ) then
            ClearMemoryProgram;
            pkg_Traza.Trace('No se encuentra Programa en la BD [' ||isbPROGRAM_NAME||']',cnuNVLTRC);
        END IF;
        CLOSE cuUSER_SCHEDULER_PROGRAMS;
        
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
    END LoadRecordProgram;
    
    FUNCTION fblInMemoryProgram(isbPROGRAM_NAME IN USER_SCHEDULER_PROGRAMS.PROGRAM_NAME%TYPE) 
    RETURN BOOLEAN IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'fblInMemoryProgram';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        
        IF ( rcUSER_SCHEDULER_PROGRAMS.PROGRAM_NAME = isbPROGRAM_NAME ) THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC);
            RETURN( TRUE );
        END IF;
        
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
        RETURN( FALSE );
        
    END fblInMemoryProgram;
    
    FUNCTION fblExistProgram(isbPROGRAM_NAME IN USER_SCHEDULER_PROGRAMS.PROGRAM_NAME%TYPE, inuCACHE IN NUMBER DEFAULT 1) 
    RETURN BOOLEAN IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'fblExistProgram';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        
        --Valida si debe buscar primero en memoria Caché
        IF (inuCACHE = CACHE AND fblInMemoryProgram( isbPROGRAM_NAME ) ) THEN
                pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC);
                RETURN( TRUE );
        END IF;
        
        LoadRecordProgram(isbPROGRAM_NAME);
            
        -- Evalúa si se encontro el registro en la Base de datos
        IF ( rcUSER_SCHEDULER_PROGRAMS.PROGRAM_NAME IS NULL ) THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC);
            RETURN( FALSE );
        END IF;
        
        pkg_Traza.Trace('Existe Programa en la BD [' ||isbPROGRAM_NAME||']',cnuNVLTRC);
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
        RETURN( TRUE );
        
    END fblExistProgram;
    
    PROCEDURE LoadRecordSchedule(isbSCHEDULE_NAME IN USER_SCHEDULER_SCHEDULES.SCHEDULE_NAME%TYPE) IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'LoadRecordSchedule';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);  
          
        IF ( cuUSER_SCHEDULER_SCHEDULES%ISOPEN ) THEN
            CLOSE cuUSER_SCHEDULER_SCHEDULES;
        END IF;
        -- Accesa USER_SCHEDULER_PROGRAMS de la BD
        OPEN cuUSER_SCHEDULER_SCHEDULES(isbSCHEDULE_NAME);
        FETCH cuUSER_SCHEDULER_SCHEDULES INTO rcUSER_SCHEDULER_SCHEDULES;
        IF ( cuUSER_SCHEDULER_SCHEDULES%NOTFOUND ) then
            ClearMemorySchedule;
            pkg_Traza.Trace('No se encuentra Schedule en la BD [' ||isbSCHEDULE_NAME||']',cnuNVLTRC);
        END IF;
        CLOSE cuUSER_SCHEDULER_SCHEDULES;
        
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
    END LoadRecordSchedule;
    
    FUNCTION fblInMemorySchedule(isbSCHEDULE_NAME IN USER_SCHEDULER_SCHEDULES.SCHEDULE_NAME%TYPE) 
    RETURN BOOLEAN IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'fblInMemorySchedule';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        
        IF ( rcUSER_SCHEDULER_SCHEDULES.SCHEDULE_NAME = isbSCHEDULE_NAME ) THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC);
            RETURN( TRUE );
        END IF;
        
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
        RETURN( FALSE );
        
    END fblInMemorySchedule;
    
    PROCEDURE LoadRecordStep(isbChainName IN USER_SCHEDULER_CHAIN_STEPS.CHAIN_NAME%TYPE,
    isbStepName IN USER_SCHEDULER_CHAIN_STEPS.STEP_NAME%TYPE)
    IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'LoadRecordStep';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);  
          
        IF ( cuUSER_SCHEDULER_CHAIN_STEP%ISOPEN ) THEN
            CLOSE cuUSER_SCHEDULER_CHAIN_STEP;
        END IF;
        -- Accesa USER_SCHEDULER_PROGRAMS de la BD
        OPEN cuUSER_SCHEDULER_CHAIN_STEP(isbChainName,isbStepName);
        FETCH cuUSER_SCHEDULER_CHAIN_STEP INTO rcUSER_SCHEDULER_CHAIN_STEP;
        IF ( cuUSER_SCHEDULER_CHAIN_STEP%NOTFOUND ) then
            ClearMemoryStep;
            pkg_Traza.Trace('No se encuentra en la BD para la cadena [' || isbChainName || '] el paso [' ||isbStepName||']',cnuNVLTRC);
        END IF;
        CLOSE cuUSER_SCHEDULER_CHAIN_STEP;
        
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
    END LoadRecordStep;
    
    PROCEDURE LoadRecordRule(isbChainName IN USER_SCHEDULER_CHAIN_RULES.CHAIN_NAME%TYPE,
    isbCondition IN USER_SCHEDULER_CHAIN_RULES.condition%TYPE,
    isbAction IN USER_SCHEDULER_CHAIN_RULES.action%TYPE
    )
    IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'LoadRecordRule';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);  
          
        IF ( cuUSER_SCHEDULER_CHAIN_RULE%ISOPEN ) THEN
            CLOSE cuUSER_SCHEDULER_CHAIN_RULE;
        END IF;
        -- Accesa USER_SCHEDULER_PROGRAMS de la BD
        OPEN cuUSER_SCHEDULER_CHAIN_RULE(TRIM(isbChainName),TRIM(isbCondition),TRIM(isbAction));
        FETCH cuUSER_SCHEDULER_CHAIN_RULE INTO rcUSER_SCHEDULER_CHAIN_RULE;
        IF ( cuUSER_SCHEDULER_CHAIN_RULE%NOTFOUND ) then
            ClearMemoryRule;
            pkg_Traza.Trace('No se encuentra en la BD para la cadena [' || isbChainName || '] una regla con condición[' ||isbCondition||'] acción ['|| isbAction || ']',cnuNVLTRC);
        END IF;
        CLOSE cuUSER_SCHEDULER_CHAIN_RULE;
        
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
    END LoadRecordRule;    
           
    
    FUNCTION fblInMemoryStep(isbChainName IN USER_SCHEDULER_CHAIN_STEPS.CHAIN_NAME%TYPE,
    isbStepName IN USER_SCHEDULER_CHAIN_STEPS.STEP_NAME%TYPE) 
    RETURN BOOLEAN IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'fblInMemorySchedule';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        
        IF ( rcUSER_SCHEDULER_CHAIN_STEP.CHAIN_NAME = isbChainName
        AND rcUSER_SCHEDULER_CHAIN_STEP.STEP_NAME = isbStepName ) THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC);
            RETURN( TRUE );
        END IF;
        
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
        RETURN( FALSE );
        
    END fblInMemoryStep;
    
    FUNCTION fblInMemoryRule(isbChainName IN USER_SCHEDULER_CHAIN_RULES.CHAIN_NAME%TYPE,
    isbCondition IN USER_SCHEDULER_CHAIN_RULES.CONDITION%TYPE,
    isbAction IN USER_SCHEDULER_CHAIN_RULES.ACTION%TYPE
    ) 
    RETURN BOOLEAN IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'fblInMemoryRule';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        
        IF ( rcUSER_SCHEDULER_CHAIN_RULE.CHAIN_NAME = isbChainName
        AND UPPER(rcUSER_SCHEDULER_CHAIN_RULE.CONDITION) = UPPER(isbCondition)
        AND REPLACE( rcUSER_SCHEDULER_CHAIN_RULE.ACTION, '"', '') = UPPER(isbAction) ) THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC);
            RETURN( TRUE );
        END IF;
        
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
        RETURN( FALSE );
        
    END fblInMemoryRule;         
    
    FUNCTION fblExistSchedule(isbSCHEDULE_NAME IN USER_SCHEDULER_SCHEDULES.SCHEDULE_NAME%TYPE, inuCACHE IN NUMBER DEFAULT 1)
    RETURN BOOLEAN IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'fblExistSchedule';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        
        --Valida si debe buscar primero en memoria Caché
        IF (inuCACHE = CACHE AND fblInMemorySchedule( isbSCHEDULE_NAME ) ) THEN
                pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC);
                RETURN( TRUE );
        END IF;
        
        LoadRecordSchedule(isbSCHEDULE_NAME);
            
        -- Evalúa si se encontro el registro en la Base de datos
        IF ( rcUSER_SCHEDULER_SCHEDULES.SCHEDULE_NAME IS NULL ) THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC);
            RETURN( FALSE );
        END IF;
        
        pkg_Traza.Trace('Existe Schedule en la BD [' ||isbSCHEDULE_NAME||']',cnuNVLTRC);
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
        RETURN( TRUE );
        
    END fblExistSchedule;
    
    FUNCTION fblExistStep(isbChainName IN USER_SCHEDULER_CHAIN_STEPS.CHAIN_NAME%TYPE,  isbSTEP_NAME IN USER_SCHEDULER_CHAIN_STEPS.STEP_NAME%TYPE, inuCACHE IN NUMBER DEFAULT 1)
    RETURN BOOLEAN IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'fblExistStep';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        
        --Valida si debe buscar primero en memoria Caché
        IF (inuCACHE = CACHE AND fblInMemoryStep(isbChainName, isbSTEP_NAME ) ) THEN
                pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC);
                RETURN( TRUE );
        END IF;
        
        LoadRecordStep(isbChainName, isbSTEP_NAME);
            
        -- Evalúa si se encontro el registro en la Base de datos
        IF ( rcUSER_SCHEDULER_CHAIN_STEP.STEP_NAME IS NULL ) THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC);
            RETURN( FALSE );
        END IF;
        
        pkg_Traza.Trace('Existe Step en la BD [' ||isbSTEP_NAME||']',cnuNVLTRC);
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
        RETURN( TRUE );
        
    END fblExistStep;
    
    FUNCTION fblExistChainRule( isbChainName VARCHAR2, isbCondition VARCHAR2, isbAction VARCHAR2, inuCACHE IN NUMBER DEFAULT 1) 
    RETURN BOOLEAN IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'fblExistChainRule';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO); 
           
        --Valida si debe buscar primero en memoria Caché
        IF (inuCACHE = CACHE AND fblInMemoryRule(isbChainName, isbCondition, isbAction ) ) THEN
                pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC);
                RETURN( TRUE );
        END IF;
        
        LoadRecordRule(isbChainName, isbCondition, isbAction );
            
        -- Evalúa si se encontro el registro en la Base de datos
        IF ( rcUSER_SCHEDULER_CHAIN_RULE.RULE_NAME IS NULL ) THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC);
            RETURN( FALSE );
        END IF;
        
        pkg_Traza.Trace('Existe Rule en la BD condición[' ||isbCondition||']acción['|| isbAction || ']',cnuNVLTRC);
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
        RETURN( TRUE );
        
    END fblExistChainRule;       
    
    PROCEDURE LoadRecordJob(isbJOB_NAME IN USER_SCHEDULER_JOBS.JOB_NAME%TYPE) IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'LoadRecordJob';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);  
          
        IF ( cuUSER_SCHEDULER_JOBS%ISOPEN ) THEN
            CLOSE cuUSER_SCHEDULER_JOBS;
        END IF;
        -- Accesa USER_SCHEDULER_PROGRAMS de la BD
        OPEN cuUSER_SCHEDULER_JOBS(isbJOB_NAME);
        FETCH cuUSER_SCHEDULER_JOBS INTO rcUSER_SCHEDULER_JOBS;
        IF ( cuUSER_SCHEDULER_JOBS%NOTFOUND ) then
            ClearMemoryJob;
            pkg_Traza.Trace('No se encuentra Job en la BD [' ||isbJOB_NAME||']',cnuNVLTRC);
        END IF;
        CLOSE cuUSER_SCHEDULER_JOBS;
        
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
    END LoadRecordJob;
    
    FUNCTION fblInMemoryJob(isbJOB_NAME IN USER_SCHEDULER_JOBS.JOB_NAME%TYPE)
    RETURN BOOLEAN IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'fblInMemoryJob';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        
        IF ( rcUSER_SCHEDULER_JOBS.JOB_NAME = isbJOB_NAME ) THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC);
            RETURN( TRUE );
        END IF;
        
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
        RETURN( FALSE );
        
    END fblInMemoryJob;
    
    FUNCTION fblExistJob(isbJOB_NAME IN USER_SCHEDULER_JOBS.JOB_NAME%TYPE, inuCACHE IN NUMBER DEFAULT 1)
    RETURN BOOLEAN IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'fblExistJob';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        
        --Valida si debe buscar primero en memoria Caché
        IF (inuCACHE = CACHE AND fblInMemoryJob( isbJOB_NAME ) ) THEN
                pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC);
                RETURN( TRUE );
        END IF;
        
        LoadRecordJob(isbJOB_NAME);
            
        -- Evalúa si se encontro el registro en la Base de datos
        IF ( rcUSER_SCHEDULER_JOBS.JOB_NAME IS NULL ) THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC);
            RETURN( FALSE );
        END IF;
        
        pkg_Traza.Trace('Existe Job en la BD [' ||isbJOB_NAME||']',cnuNVLTRC);
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
        RETURN( TRUE );
        
    END fblExistJob;
    
    PROCEDURE create_program
    (
        program_name        IN user_scheduler_programs.PROGRAM_NAME%TYPE,
        program_type        IN user_scheduler_programs.PROGRAM_TYPE%TYPE,
        program_action      IN user_scheduler_programs.PROGRAM_ACTION%TYPE,
        number_of_arguments IN user_scheduler_programs.NUMBER_OF_ARGUMENTS%TYPE DEFAULT 0,
        enabled             IN BOOLEAN DEFAULT FALSE,
        comments            IN user_scheduler_programs.COMMENTS%TYPE DEFAULT NULL,
        codeError           OUT NUMBER,
        messageError        OUT VARCHAR2 
    ) IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'create_program';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        Initializeoutput( codeError, messageError );
        
        --Creación de programa
        dbms_scheduler.create_program
        (
            program_name        => program_name,
            program_type        => program_type,
            program_action      => program_action,
            number_of_arguments => CASE UPPER(program_type) WHEN 'PLSQL_BLOCK' THEN 0 ELSE number_of_arguments END,
            enabled             => enabled,
            comments            => comments
        );
        
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_Traza.Trace('Finaliza con Error ' ||csbSP_NAME||csbMT_NAME,cnuNVLTRC);
            pkg_Error.setError;
            pkg_Error.getError(codeError,messageError);
    END create_program;
    
    PROCEDURE define_program_argument
    (
        program_name        IN user_scheduler_program_args.PROGRAM_NAME%TYPE,
        argument_position   IN user_scheduler_program_args.ARGUMENT_POSITION%TYPE,
        argument_name       IN user_scheduler_program_args.ARGUMENT_NAME%TYPE DEFAULT NULL,
        argument_type       IN user_scheduler_program_args.ARGUMENT_TYPE%TYPE,
        codeError           OUT NUMBER,
        messageError        OUT VARCHAR2
    ) IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'define_program_argument';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        Initializeoutput( codeError, messageError );
        
        pkg_Traza.Trace('Define argumento para el programa sin valor por defecto',cnuNVLTRC);
        --Define argumentos para programas
        dbms_scheduler.define_program_argument
        (
            program_name        => program_name,
            argument_position   => argument_position,
            argument_name       => argument_name,
            argument_type       => argument_type
        );
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERR);            
            pkg_Error.setError;
            pkg_Error.getError(codeError,messageError);
    END define_program_argument;
    
    PROCEDURE define_program_argument
    (
        program_name        IN  user_scheduler_program_args.PROGRAM_NAME%TYPE,
        argument_position   IN  user_scheduler_program_args.ARGUMENT_POSITION%TYPE,
        argument_name       IN  user_scheduler_program_args.ARGUMENT_NAME%TYPE DEFAULT NULL,
        argument_type       IN  user_scheduler_program_args.ARGUMENT_TYPE%TYPE,
        default_value       IN  user_scheduler_program_args.default_value%TYPE DEFAULT NULL,
        codeError           OUT  NUMBER,
        messageError        OUT  VARCHAR2
    ) IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'define_program_argument: DV';
    BEGIN
    
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        Initializeoutput( codeError, messageError );
        
        pkg_Traza.Trace('Define argumento para el programa con valor por defecto',cnuNVLTRC);
        --Define argumentos para programas con valor por defecto
        dbms_scheduler.define_program_argument
        (
            program_name        => program_name,
            argument_position   => argument_position,
            argument_name       => argument_name,
            argument_type       => argument_type,
            default_value       => default_value
        );
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_Error.setError;
            pkg_Error.getError(codeError,messageError);
    END define_program_argument;
    
    PROCEDURE drop_program
    (
        program_name        IN user_scheduler_programs.PROGRAM_NAME%TYPE,
        force               IN BOOLEAN DEFAULT FALSE,
        codeError           OUT NUMBER,
        messageError        OUT VARCHAR2
    ) IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'drop_program';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        Initializeoutput( codeError, messageError );
        
        --Borra programa
        dbms_scheduler.drop_program
        (
            program_name        => program_name,
            force               => force
        );
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_Error.setError;
            pkg_Error.getError(codeError,messageError);
    END drop_program;
    
    PROCEDURE drop_program_argument
    (
        program_name        IN user_scheduler_program_args.PROGRAM_NAME%TYPE,
        argument_position   IN user_scheduler_program_args.ARGUMENT_POSITION%TYPE,
        argument_name       IN user_scheduler_program_args.ARGUMENT_NAME%TYPE DEFAULT NULL,
        codeError           OUT NUMBER,
        messageError        OUT VARCHAR2 
    ) IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'drop_program_argument';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        Initializeoutput( codeError, messageError );
        
        --Evalua la forma de borrado
        IF argument_name IS NULL THEN
            pkg_Traza.Trace('Drop argumento programa por posición',cnuNVLTRC);
            --Borra argumento de programa por posicion
            dbms_scheduler.drop_program_argument
            (
                program_name        => program_name,
                argument_position   => argument_position
            );
        ELSE
            pkg_Traza.Trace('Drop argumento programa por nombre',cnuNVLTRC);
            --Borra argumento de programa por nombre
            dbms_scheduler.drop_program_argument
            (
                program_name        => program_name,
                argument_name       => argument_name
            );
        END IF;
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_Error.setError;
            pkg_Error.getError(codeError,messageError);
    END drop_program_argument;
    
    PROCEDURE create_schedule
    (
        schedule_name       IN user_scheduler_schedules.SCHEDULE_NAME%TYPE,
        start_date          IN user_scheduler_schedules.START_DATE%TYPE DEFAULT NULL,
        repeat_interval     IN user_scheduler_schedules.REPEAT_INTERVAL%TYPE,
        end_date            IN user_scheduler_schedules.END_DATE%TYPE DEFAULT NULL,
        comments            IN user_scheduler_schedules.COMMENTS%TYPE DEFAULT NULL,
        codeError           OUT NUMBER,
        messageError        OUT VARCHAR2
    ) IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'create_schedule';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        Initializeoutput( codeError, messageError );
        
        --Borra programa
        dbms_scheduler.create_schedule
        (
            schedule_name       => schedule_name,
            start_date          => start_date,
            repeat_interval     => repeat_interval,
            end_date            => end_date,
            comments            => comments
        );
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_Error.setError;
            pkg_Error.getError(codeError,messageError);
    END create_schedule;
    
    PROCEDURE evaluate_calendar_string
    (
        calendar_string     IN user_scheduler_schedules.REPEAT_INTERVAL%TYPE,
        start_date          IN user_scheduler_schedules.START_DATE%TYPE,
        return_date_after   IN user_scheduler_schedules.END_DATE%TYPE DEFAULT NULL,
        next_run_date       OUT user_scheduler_schedules.END_DATE%TYPE,
        codeError           OUT NUMBER,
        messageError        OUT VARCHAR2
    ) IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'evaluate_calendar_string';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        Initializeoutput( codeError, messageError );
        
        --Borra programa
        dbms_scheduler.evaluate_calendar_string
        (
            calendar_string     => calendar_string,
            start_date          => start_date,
            return_date_after   => return_date_after,
            next_run_date       => next_run_date
        );
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_Error.setError;
            pkg_Error.getError(codeError,messageError);
    END evaluate_calendar_string;
    
    PROCEDURE drop_schedule
    (
        schedule_name       IN user_scheduler_schedules.SCHEDULE_NAME%TYPE,
        force               IN BOOLEAN DEFAULT FALSE,
        codeError           OUT NUMBER,
        messageError        OUT VARCHAR2
    ) IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'drop_schedule';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        Initializeoutput( codeError, messageError );
        
        --Borra programa
        dbms_scheduler.drop_schedule
        (
            schedule_name       => schedule_name,
            force               => force
        );
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_Error.setError;
            pkg_Error.getError(codeError,messageError);
    END drop_schedule;
    
    PROCEDURE create_job
    (
        job_name            IN user_scheduler_jobs.JOB_NAME%TYPE,
        program_name        IN user_scheduler_jobs.PROGRAM_NAME%TYPE DEFAULT NULL,
        schedule_name       IN user_scheduler_jobs.SCHEDULE_NAME%TYPE DEFAULT NULL,
        job_style           IN user_scheduler_jobs.JOB_STYLE%TYPE DEFAULT 'REGULAR',
        job_type            IN user_scheduler_jobs.JOB_TYPE%TYPE DEFAULT NULL,
        job_action          IN user_scheduler_jobs.JOB_ACTION%TYPE DEFAULT NULL,
        number_of_arguments IN user_scheduler_jobs.NUMBER_OF_ARGUMENTS%TYPE DEFAULT 0,
        start_date          IN user_scheduler_jobs.START_DATE%TYPE DEFAULT NULL,
        repeat_interval     IN user_scheduler_jobs.REPEAT_INTERVAL%TYPE DEFAULT NULL,
        end_date            IN user_scheduler_jobs.END_DATE%TYPE DEFAULT NULL,
        enabled             IN BOOLEAN DEFAULT FALSE,
        auto_drop           IN BOOLEAN DEFAULT TRUE,
        comments            IN user_scheduler_jobs.COMMENTS%TYPE DEFAULT NULL,
        codeError           OUT NUMBER,
        messageError        OUT VARCHAR2
    ) IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'create_job';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        Initializeoutput( codeError, messageError );
        
        --Evalua el tipo de creación
        IF program_name IS NULL THEN
            --Evalua el schedule
            IF schedule_name IS NULL THEN
            
                pkg_Traza.Trace('Creación Job sin programa y sin schedule',cnuNVLTRC);
                --Creación de Job sin programa y sin schedule
                dbms_scheduler.create_job
                (
                    job_name            => job_name,
                    job_type            => job_type,
                    job_action          => job_action,
                    number_of_arguments => CASE UPPER(job_type) WHEN 'PLSQL_BLOCK' THEN 0 ELSE number_of_arguments END,
                    start_date          => start_date,
                    repeat_interval     => repeat_interval,
                    end_date            => end_date,
                    enabled             => enabled,
                    auto_drop           => auto_drop,
                    comments            => comments
                );
            ELSE
                pkg_Traza.Trace('Creación Job sin programa con schedule',cnuNVLTRC);
                --Creación de Job sin programa con schedule
                dbms_scheduler.create_job
                (
                    job_name            => job_name,
                    schedule_name       => schedule_name,
                    job_type            => job_type,
                    job_action          => job_action,
                    number_of_arguments => CASE UPPER(job_type) WHEN 'PLSQL_BLOCK' THEN 0 ELSE number_of_arguments END,
                    enabled             => enabled,
                    auto_drop           => auto_drop,
                    comments            => comments
                );
            END IF;
        ELSE
            --Evalua el schedule
            IF schedule_name IS NULL THEN
                pkg_Traza.Trace('Creación Job con programa y sin schedule',cnuNVLTRC);
                --Creación de Job con programa y sin schedule
                dbms_scheduler.create_job
                (
                    job_name            => job_name,
                    program_name        => program_name,
                    start_date          => start_date,
                    repeat_interval     => repeat_interval,
                    end_date            => end_date,
                    job_style           => job_style,
                    enabled             => enabled,
                    auto_drop           => CASE UPPER(job_style) WHEN 'LIGHTWEIGHT' THEN TRUE ELSE auto_drop END,
                    comments            => comments
                );
            ELSE
                pkg_Traza.Trace('Creación Job con programa con schedule',cnuNVLTRC);
                --Creación de Job con programa con schedule
                dbms_scheduler.create_job
                (
                    job_name            => job_name,
                    program_name        => program_name,
                    schedule_name       => schedule_name,
                    job_style           => job_style,
                    enabled             => enabled,
                    auto_drop           => CASE UPPER(job_style) WHEN 'LIGHTWEIGHT' THEN TRUE ELSE auto_drop END,
                    comments            => comments
                );
            END IF;
        END IF;
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
                    
    EXCEPTION
        WHEN OTHERS THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_Error.setError;
            pkg_Error.getError(codeError,messageError);
    END create_job;
    
    PROCEDURE set_job_argument_value
    (
        job_name            IN user_scheduler_job_args.JOB_NAME%TYPE,
        argument_position   IN user_scheduler_job_args.ARGUMENT_POSITION%TYPE,
        argument_name       IN user_scheduler_job_args.ARGUMENT_NAME%TYPE DEFAULT NULL,
        argument_value      IN user_scheduler_job_args.VALUE%TYPE,
        codeError           OUT NUMBER,
        messageError        OUT VARCHAR2
    ) IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'set_job_argument_value';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        Initializeoutput( codeError, messageError );
        
        --Evalua la forma de borrado
        IF argument_name IS NULL THEN
            pkg_Traza.Trace('Asigna valor a argumento de Job por posición',cnuNVLTRC);
            --Asigna valor a argumento de Job por posición
            dbms_scheduler.set_job_argument_value
            (
                job_name            => job_name,
                argument_position   => argument_position,
                argument_value      => argument_value
            );
        ELSE
            pkg_Traza.Trace('Asigna valor a argumento de Job por nombre',cnuNVLTRC);
            --Asigna valor a argumento de Job por nombre
            dbms_scheduler.set_job_argument_value
            (
                job_name            => job_name,
                argument_name       => argument_name,
                argument_value      => argument_value
            );
        END IF;
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_Error.setError;
            pkg_Error.getError(codeError,messageError);
    END set_job_argument_value;
    
    PROCEDURE drop_job
    (
        job_name            IN user_scheduler_jobs.JOB_NAME%TYPE,
        force               IN BOOLEAN DEFAULT FALSE,
        codeError           OUT NUMBER,
        messageError        OUT VARCHAR2
    ) IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'drop_job';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        Initializeoutput( codeError, messageError );
        
        --Borra job
        dbms_scheduler.drop_job
        (
            job_name            => job_name,
            force               => force
        );
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
            pkg_Error.setError;
            pkg_Error.getError(codeError,messageError);
    END drop_job;
    
    PROCEDURE control
    (
        name                IN VARCHAR2,
        action              IN VARCHAR2 DEFAULT 'DISABLE',
        force               IN BOOLEAN DEFAULT FALSE,
        codeError           OUT NUMBER,
        messageError        OUT VARCHAR2
    ) IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'control';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        Initializeoutput( codeError, messageError );
        
        --Habilita programa / job
        IF UPPER(action) = 'ENABLE' THEN
            pkg_Traza.Trace('Habilita Job / Programa',cnuNVLTRC);
            dbms_scheduler.enable
            (
                name                => name
            );
        ELSIF UPPER(action) = 'DISABLE' THEN
            pkg_Traza.Trace('Deshabilita Job / Programa',cnuNVLTRC);
            dbms_scheduler.disable
            (
                name                => name,
                force               => force
            );
        ELSIF UPPER(action) = 'RUN_JOB' THEN
            pkg_Traza.Trace('Inicia Job',cnuNVLTRC);
            dbms_scheduler.run_job
            (
                job_name            => name
            );
        ELSIF UPPER(action) = 'STOP_JOB' THEN
            pkg_Traza.Trace('Detiene Job',cnuNVLTRC);
            dbms_scheduler.stop_job
            (
                job_name            => name,
                force               => force
            );
        ELSE
            pkg_Traza.Trace('Accion no contemplada ['||action||']',cnuNVLTRC);
        END IF;
                
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_Error.setError;
            pkg_Error.getError(codeError,messageError);
    END control;
    
    PROCEDURE enable
    (
        name                IN VARCHAR2,
        codeError           OUT NUMBER,
        messageError        OUT VARCHAR2
    ) IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'enable';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        Initializeoutput( codeError, messageError );
        
        --Habilita programa / job
        dbms_scheduler.enable
        (
            name                => name
        );
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_Error.setError;
            pkg_Error.getError(codeError,messageError);
    END enable;
    
    PROCEDURE disable
    (
        name                IN VARCHAR2,
        force               IN BOOLEAN DEFAULT FALSE,
        codeError           OUT NUMBER,
        messageError        OUT VARCHAR2
    ) IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'disable';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        Initializeoutput( codeError, messageError );
        
        --Deshabilita programa / job
        dbms_scheduler.disable
        (
            name                => name,
            force               => force
        );
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_Error.setError;
            pkg_Error.getError(codeError,messageError);
    END disable;
    
    PROCEDURE run_job
    (
        job_name            IN user_scheduler_jobs.JOB_NAME%TYPE,
        codeError           OUT NUMBER,
        messageError        OUT VARCHAR2
    ) IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'run_job';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        Initializeoutput( codeError, messageError );
        
        --Inicia job
        dbms_scheduler.run_job
        (
            job_name            => job_name
        );
        
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_Error.setError;
            pkg_Error.getError(codeError,messageError);
    END run_job;
    
    PROCEDURE stop_job
    (
        job_name            IN user_scheduler_jobs.JOB_NAME%TYPE,
        force               IN BOOLEAN DEFAULT FALSE,
        codeError           OUT NUMBER,
        messageError        OUT VARCHAR2
    ) IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'stop_job';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        Initializeoutput( codeError, messageError );
        
        --Detiene job
        dbms_scheduler.stop_job
        (
            job_name            => job_name,
            force               => force
        );
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_Error.setError;
            pkg_Error.getError(codeError,messageError);
    END stop_job;
    
    PROCEDURE set_attribute
    (
        name                IN VARCHAR2,
        attribute           IN VARCHAR2,
        value               IN VARCHAR2,
        value2              IN VARCHAR2 DEFAULT NULL,
        codeError           OUT NUMBER,
        messageError        OUT VARCHAR2
    ) IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'set_attribute';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        Initializeoutput( codeError, messageError );
        
        --Validación de valor Nulo
        IF value IS NULL THEN
            pkg_Traza.Trace('Modifica atributo a Null',cnuNVLTRC);
            dbms_scheduler.set_attribute_null
            (
                name                => name,
                attribute           => attribute
            );
        ELSE
            --Validación de argumento opcional
            IF value2 IS NULL THEN
                pkg_Traza.Trace('Modifica atributo',cnuNVLTRC);
                dbms_scheduler.set_attribute
                (
                    name                => name,
                    attribute           => attribute,
                    value               => value
                );
            ELSE
                pkg_Traza.Trace('Modifica atributo incluido segundo valor',cnuNVLTRC);
                dbms_scheduler.set_attribute
                (
                    name                => name,
                    attribute           => attribute,
                    value               => value,
                    value2              => value2
                );
            END IF;
        END IF;
        
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_Error.setError;
            pkg_Error.getError(codeError,messageError);
    END set_attribute;
    
    PROCEDURE get_attribute
    (
        name                IN VARCHAR2,
        attribute           IN VARCHAR2,
        value               OUT VARCHAR2,
        value2              OUT VARCHAR2,
        codeError           OUT NUMBER,
        messageError        OUT VARCHAR2
    ) IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'get_attribute';
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        Initializeoutput( codeError, messageError );
        
        dbms_scheduler.get_attribute
        (
            name                => name,
            attribute           => attribute,
            value               => value,
            value2              => value2
        );
        
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_Error.setError;
            pkg_Error.getError(codeError,messageError);
    END get_attribute;
    
    FUNCTION fblSchedChainRunning( isbChainName VARCHAR2, isbJobName VARCHAR2 DEFAULT NULL) RETURN BOOLEAN
    IS  

        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'fblSchedChainRunning';
        
        blChainJobRunning    BOOLEAN := FALSE;
        
        rcUSER_SCHED_RUNNING_CHAINS_J  cuUSER_SCHED_RUNNING_CHAINS_J%ROWTYPE;
        
        sbJobName           VARCHAR2(30);
                       
    BEGIN
    
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        
        IF isbJobName IS NOT NULL THEN
            sbJobName := isbJobName;
        ELSE
            sbJobName := 'JOB_' || isbChainName;        
        END IF;
        
        OPEN cuUSER_SCHED_RUNNING_CHAINS_J(sbJobName);
        FETCH cuUSER_SCHED_RUNNING_CHAINS_J INTO rcUSER_SCHED_RUNNING_CHAINS_J;
        CLOSE cuUSER_SCHED_RUNNING_CHAINS_J;
        
        blChainJobRunning := rcUSER_SCHED_RUNNING_CHAINS_J.Chain_Name IS NOT NULL;
        
        IF blChainJobRunning THEN
            pkg_Traza.Trace( 'La cadena de Jobs ' || isbChainName || ' SÍ está corriendo' , 10 );
        ELSE
            pkg_Traza.Trace( 'La cadena de Jobs ' || isbChainName || ' NO está corriendo' , 10 );        
        END IF;

        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
        RETURN blChainJobRunning;
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERR);            pkg_Traza.Trace('Finaliza con Error ' ||csbSP_NAME||csbMT_NAME,cnuNVLTRC);
            pkg_error.setError;
            RAISE pkg_error.Controlled_Error;            
    END fblSchedChainRunning;
    
    FUNCTION fblSchedChainExists( isbChainName VARCHAR2) RETURN BOOLEAN
    IS  

        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'fblSchedChainExists';
        
        blChainJobExist    BOOLEAN := FALSE;
        
        rcUSER_SCHED_CHAINS  cuUSER_SCHED_CHAINS%ROWTYPE;
                       
    BEGIN
    
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        
        OPEN cuUSER_SCHED_CHAINS(isbChainName);
        FETCH cuUSER_SCHED_CHAINS INTO rcUSER_SCHED_CHAINS;
        CLOSE cuUSER_SCHED_CHAINS;
        
        blChainJobExist := rcUSER_SCHED_CHAINS.Chain_Name IS NOT NULL;
        
        IF blChainJobExist THEN
            pkg_Traza.Trace( 'La cadena de Jobs ' || isbChainName || ' SÍ existe' , 10 );
        ELSE
            pkg_Traza.Trace( 'La cadena de Jobs ' || isbChainName || ' NO existe' , 10 );        
        END IF;

        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
        RETURN blChainJobExist;
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERR);        
            pkg_Error.setError;
            RAISE pkg_Error.CONTROLLED_ERROR;   
    END fblSchedChainExists;
    
    PROCEDURE pDropSchedChain( isbChainName VARCHAR2) IS

        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'pDropSchedChain';
                    
        TYPE tytbSCHED_CHAIN_STEPS IS TABLE OF cuSCHED_CHAIN_STEPS%ROWTYPE INDEX BY BINARY_INTEGER;
        tbSCHED_CHAIN_STEPS tytbSCHED_CHAIN_STEPS;
        
        nuError     NUMBER;
        sbError     VARCHAR2(4000);
               
    BEGIN
    
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
                   
        IF fblSchedChainRunning( isbChainName) THEN
            pkg_error.setErrorMessage( isbMsgErrr => 'No puede borrarse la cadena ' || isbChainName || ' porque está corriendo');
        ELSE
        
            OPEN    cuSCHED_CHAIN_STEPS(isbChainName) ;
            FETCH   cuSCHED_CHAIN_STEPS BULK COLLECT INTO tbSCHED_CHAIN_STEPS;
            CLOSE   cuSCHED_CHAIN_STEPS;
            
            IF tbSCHED_CHAIN_STEPS.COUNT > 0 THEN
                
                FOR IND1 IN 1..tbSCHED_CHAIN_STEPS.COUNT LOOP
                
                    DBMS_SCHEDULER.DROP_CHAIN_STEP( isbChainName, tbSCHED_CHAIN_STEPS(IND1).STEP_NAME );
                    
                    pkg_Traza.Trace('BORRADO PASO [' || isbChainName || '.' || tbSCHED_CHAIN_STEPS(IND1).STEP_NAME || ']',cnuNVLTRC);
                    
                    IF fblExistProgram( tbSCHED_CHAIN_STEPS(IND1).PROGRAM_NAME ) THEN
                
                        drop_program( tbSCHED_CHAIN_STEPS(IND1).PROGRAM_NAME, TRUE, nuError, sbError);
                        
                        pkg_Traza.Trace('SE BORRO EL PROGRAMA[' || tbSCHED_CHAIN_STEPS(IND1).PROGRAM_NAME || ']',cnuNVLTRC );

                    ELSE
                                    
                        pkg_Traza.Trace('EL PROGRAMA[' || tbSCHED_CHAIN_STEPS(IND1).PROGRAM_NAME || '] NO EXISTE',cnuNVLTRC );
                    END IF;                
                    
                    COMMIT;
                
                END LOOP; 
            
            ELSE
            
                pkg_Traza.Trace('LA CADENA [' || isbChainName || '] NO TIENE PASOS DEFINIDOS',cnuNVLTRC);
                    
            END IF; 

            IF fblSchedChainExists ( isbChainName ) THEN
            
                DBMS_SCHEDULER.DROP_CHAIN( isbChainName, TRUE);
                
                pkg_Traza.Trace('SE BORRO LA CADENA[' || isbChainName || ']',cnuNVLTRC);
                            
                COMMIT;                
                
            ELSE
            
                pkg_Traza.Trace('NO  EXISTE LA CADENA[' || isbChainName || ']',cnuNVLTRC);
                
            END IF;

        END IF;
        
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);    

    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERC);        
            RAISE pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERR);        
            pkg_Error.setError;
            RAISE pkg_Error.CONTROLLED_ERROR;           
    END pDropSchedChain;              
    
    PROCEDURE create_chain(isbChainName VARCHAR2) IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'pCreaSchedChain';    
    BEGIN

        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
                
        IF fblSchedChainExists(isbChainName) THEN
            pkg_Traza.Trace('Ya existe la cadena [' || isbChainName || ']',cnuNVLTRC);
        ELSE
            DBMS_SCHEDULER.CREATE_CHAIN(isbChainName);            
            pkg_Traza.Trace('Se creó la cadena [' || isbChainName || ']',cnuNVLTRC);
        END IF;
                
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);                
    EXCEPTION
        WHEN OTHERS THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERR);      
            pkg_Error.setError;
            RAISE pkg_Error.CONTROLLED_ERROR;         
    END create_chain;
    
    PROCEDURE define_chain_step
    (
       isbChainName     VARCHAR2,
       isbChainStepName VARCHAR2,
       isbprogram_name  VARCHAR2
    )
    IS 
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'pCreaSchedChainStep'; 
        
        nuLongChainStepName     NUMBER;   
    BEGIN

        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        
        nuLongChainStepName := LENGTH(isbChainStepName);
        
        IF  nuLongChainStepName > cnuMAX_LONG_STEP_NAME THEN
            pkg_error.setErrorMessage( isbMsgErrr => 'La longitud del paso [' ||isbChainStepName ||'] es ['|| nuLongChainStepName || ']. No puede ser mayor a ['|| cnuMAX_LONG_STEP_NAME || ']'  ); 
        END IF;
        
        DBMS_SCHEDULER.DEFINE_CHAIN_STEP
        (
           isbChainName     ,
           isbChainStepName ,
           isbprogram_name
        );
        
        pkg_Traza.Trace('PARA LA CADENA [' || isbChainName || '] SE CREO EL PASO [' || isbChainStepName || '] CON EL PROGRAMA [' || isbprogram_name ||']',(cnuNVLTRC+1));   
        
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
    END define_chain_step;       

    PROCEDURE pCreaSchedChainStep
    (
        isbChainName            IN  VARCHAR2,
        isbChainStepName    IN  VARCHAR2,
        isbprogram_name         IN  VARCHAR2,
        isbprogram_type         IN  VARCHAR2,
        isbprogram_action       IN  VARCHAR2,
        inunumber_of_arguments  IN  NUMBER,
        iblenabled              IN  BOOLEAN,
        isbcomments             IN  VARCHAR2,
        onucodeError            OUT NUMBER,
        osbmessageError         OUT VARCHAR2         
    ) IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'pCreaSchedChainStep';    
    BEGIN

        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        
        Initializeoutput( onucodeError, osbmessageError );
        
        IF fblExistProgram ( isbprogram_name ) THEN
            pkg_Traza.Trace('Ya existe el programa ' || isbprogram_name,(cnuNVLTRC+1));
        ELSE
        
            create_program
            (
                isbprogram_name         ,
                isbprogram_type         ,
                isbprogram_action       ,
                inunumber_of_arguments  ,
                false                   ,
                isbcomments             ,
                onucodeError            ,
                osbmessageError          
            );
            
            IF onucodeError = 0 THEN
                pkg_Traza.Trace('Ok create_program DISABLED|' || isbprogram_name,(cnuNVLTRC+1));
            ELSE
                pkg_Traza.Trace('ERROR create_program|' || osbmessageError,(cnuNVLTRC+1));
                personalizaciones.pkg_error.setErrorMessage( NULL, 'ERROR create_program|' || osbmessageError );
            END IF;
            
        END IF;    
        
        IF fblExistStep ( isbChainName, isbChainStepName ) THEN
            pkg_Traza.Trace('Ya existe el paso ' || isbChainStepName,(cnuNVLTRC+1));
        ELSE
                      
            define_chain_step
            (
               isbChainName     ,
               isbChainStepName ,
               isbprogram_name
            );
            
            pkg_Traza.Trace('PARA LA CADENA [' || isbChainName || '] SE CREO EL PASO [' || isbChainStepName || '] CON EL PROGRAMA [' || isbprogram_name ||']',(cnuNVLTRC+1));   
        END IF;

        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
                             
    EXCEPTION
        WHEN OTHERS THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERR);       
            pkg_Error.setError;
            RAISE pkg_Error.CONTROLLED_ERROR;      
    END pCreaSchedChainStep;
    
    PROCEDURE define_chain_rule 
    (
       isbChainName VARCHAR2,
       isbCondition VARCHAR2,
       isbAction    VARCHAR2
    )
    IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'define_chain_rule';     
    BEGIN
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);

        IF fblExistChainRule( isbChainName, isbCondition, isbAction ) THEN
            pkg_Traza.Trace('Ya existe una regla para la cadena[' || isbChainName || ']acción[' || isbAction || ']condición[' || isbCondition || ']',cnuNVLTRC);
        ELSE
            DBMS_SCHEDULER.DEFINE_CHAIN_RULE 
            (
               isbChainName,
               isbCondition,
               isbAction
            ); 
            pkg_Traza.Trace('Se creó una regla para la cadena[' || isbChainName || ']acción[' || isbAction || ']condición[' || isbCondition || ']',cnuNVLTRC);
        END IF;
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);             
    EXCEPTION
        WHEN OTHERS THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERR);        
            pkg_Error.setError;
            RAISE pkg_Error.CONTROLLED_ERROR;            
    END define_chain_rule;
    
    -- Ejecuta una cadena de Jobs
    PROCEDURE run_chain(isbChainName VARCHAR2, isbIniSteps VARCHAR2, isbJobName VARCHAR2)
    IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'run_chain';
                    
    BEGIN

        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        IF isbJobName IS NULL THEN
            pkg_error.setErrorMessage( isbMsgErrr => 'No se puede ejecutar la cadena [' || isbChainName || '] sin proporcionar nombre para el Job maestro' );  
        ELSE
            DBMS_SCHEDULER.RUN_CHAIN(isbChainName, isbIniSteps, isbJobName);        
        END IF;
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
                         
    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERC);        
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_Error.setError;
            RAISE pkg_error.Controlled_Error;                           
    END run_chain;
    
    -- Retorna una tabla pl de tipo tytbProgramas
    FUNCTION ftbProgramas( isbCadena VARCHAR2)
    RETURN tytbProgramas
    IS
 
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'ftbProgramas';
                    

        tbProgramas tytbProgramas;
      
    BEGIN

        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
        
        OPEN cuProgramas( isbCadena );
        FETCH cuProgramas BULK COLLECT INTO tbProgramas;
        CLOSE cuProgramas;
        
        pkg_Traza.Trace('tbProgramas.Count|' || tbProgramas.Count );
        
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
        
        RETURN tbProgramas;
        
    EXCEPTION
        WHEN OTHERS THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_Error.setError;
            RAISE pkg_error.Controlled_Error;                 
    END ftbProgramas;
    
	-- Retorna verdadero si uno de los pasos de la cadena de Job quedo en estado FAILED	
    FUNCTION fblUltEjecCadJobConError( isbCadena VARCHAR2, isbJob VARCHAR2 DEFAULT NULL)
    RETURN BOOLEAN
    IS
        ----------------------------------------
        -- Constantes del procedimiento:
        ----------------------------------------
        csbMT_NAME              CONSTANT VARCHAR2(30) := 'fblUltEjecCadJobConError';
            
        blUltEjecCadJobConError BOOLEAN := FALSE;
        
        rcUSER_SCHED_FAILED_CHAINS_J  cuUSER_SCHED_FAILED_CHAINS_J%ROWTYPE;
        
        sbJob                   VARCHAR2(30);
    BEGIN

        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbINICIO);
            
        if isbJob IS NOT NULL THEN
            sbJob := isbJob;
        ELSE
            sbJob := 'JOB_' || isbCadena ;
        END IF;
        OPEN cuUSER_SCHED_FAILED_CHAINS_J(sbJob) ;
        FETCH cuUSER_SCHED_FAILED_CHAINS_J INTO rcUSER_SCHED_FAILED_CHAINS_J;
        CLOSE cuUSER_SCHED_FAILED_CHAINS_J;
        
        blUltEjecCadJobConError := rcUSER_SCHED_FAILED_CHAINS_J.step_name IS NOT NULL;
        
        pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN);
            
        RETURN blUltEjecCadJobConError;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_Traza.Trace( csbSP_NAME||csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERR);
            pkg_Error.setError;
            RAISE pkg_error.Controlled_Error;     
    END fblUltEjecCadJobConError;
    
    -- Retorna una tabla Pl con los argumentos de un programa
    FUNCTION ftbArgumentos( isbPropietario VARCHAR2, isbPaquete VARCHAR2, isbPrograma VARCHAR2)
    RETURN tytbArgumentos
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME ||  'ftbArgumentos';

        tbArgumentos tytbArgumentos;

        TYPE tytbArgumentosD IS TABLE OF cuArgumentos%ROWTYPE
        INDEX BY BINARY_INTEGER;

        tbArgumentosD tytbArgumentosD;

        nuError         NUMBER;
        sbError         VARCHAR2(4000);

    BEGIN

        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);

        pkg_Traza.trace('isbPropietario|' || isbPropietario || '|isbPaquete|' ||isbPaquete || '|isbPrograma|' || isbPrograma,cnuNVLTRC);

        OPEN cuArgumentos( isbPropietario, isbPaquete, isbPrograma );
        FETCH cuArgumentos BULK COLLECT INTO tbArgumentosD;
        CLOSE cuArgumentos;

        pkg_Traza.trace('tbArgumentosD.COUNT|' ||tbArgumentosD.COUNT,cnuNVLTRC);

        IF tbArgumentosD.COUNT > 0 THEN
            FOR ind IN 1..tbArgumentosD.COUNT LOOP
                tbArgumentos( tbArgumentosD(ind).argument_name ) := tbArgumentosD(ind);
            END LOOP;
        END IF;

        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);

        RETURN tbArgumentos;
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END ftbArgumentos; 
    
    -- Calcula la cadena para la acción    
    FUNCTION fsbAction ( isbPack VARCHAR2, isbApi VARCHAR2 , isbProgType VARCHAR2, isbBloquePl VARCHAR2 ) RETURN VARCHAR2
    IS
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME ||  'fsbAction';

        sbAction    VARCHAR2(4000);

        nuError     NUMBER;
        sbError     VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);

        CASE isbProgType
            WHEN 'STORED_PROCEDURE' THEN
                sbAction := ISBPACK || '.' || ISBAPI;
            WHEN 'PLSQL_BLOCK' THEN
                sbAction := isbBloquePl;
        END CASE;

        pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);

        RETURN sbAction;

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;
    END fsbAction;                            	
        
END pkg_scheduler;
/

PROMPT Crea sinonimos privados para open.pkg_scheduler
BEGIN
  pkg_utilidades.prCrearSinonimos(upper('pkg_scheduler'),'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecución sobre pkg_scheduler
BEGIN
  pkg_utilidades.prAplicarPermisos(UPPER('pkg_scheduler'),'ADM_PERSON');
END;
/

PROMPT Otorgando CREATE JOB TO ADM_PERSON
BEGIN
    EXECUTE IMMEDIATE 'GRANT CREATE JOB TO ADM_PERSON';
END;
/

PROMPT Otorgando CREATE RULE, CREATE RULE SET, CREATE EVALUATION CONTEXT TO adm_person
BEGIN
    EXECUTE IMMEDIATE 'GRANT CREATE RULE, CREATE RULE SET, CREATE EVALUATION CONTEXT TO adm_person';
END;
/

