CREATE OR REPLACE PACKAGE      adm_person.IC_BOCOMPLETSERVICEINT AS
/*
    Propiedad intelectual de Open International Systems. (c).

    Package	    :   IC_BOCompletServiceInt

    Descripcion	:   Objeto de negocio para la Interfaz de servicios cumplidos

    Autor       :   Alejandro Rendón Gómez
    Fecha       :   12-07-2012 11:23:41

    Historia de Modificaciones
    Fecha	   IDEntrega

    15/07/2024          PAcosta            OSF-2885: Cambio de esquema ADM_PERSON  
    
    18-03-2014  arendon.SAO235707
    Se modifica para adicionar el reporte de los Hechos Económicos
    correspondientes a Notas de Facturación.
    Se modifican los métodos:
        - Process
        - ValExecuteFGHE
    Se adiciona el método <fnuIsGivBackCheckCause>

    17-07-2013  hlopez.SAO212472
    Se adiciona el atributo Clasificacion Contable del Contrato
    - Se modifica el método <Process> y <ValExecuteFGHE>

    17-07-2013  hlopez.SAO212472
    Se adiciona el atributo Clase Contable del Contrato
    - Se modifica el método <Process>

    09-10-2012  hlopez.SAO193548
    Se modifica el método <Process>

    13-09-2012  arendon.SAO190941
    Se adiciona el método <ValExecuteFGHE>.

    12-07-2012  arendon.SAO185253
    Creación
*/
    -------------------
    -- Constantes
    -------------------
    -- Operacion = Generación
    cnuGENERATION   constant number(1) := 1;

    -- Operación = Reversión
    cnuROLLBACK     constant number(1) := 2;
    -------------------
    -- Métodos
    -------------------

    -- Obtiene versión actual de paquete
    FUNCTION fsbVersion
        return varchar2;

    PROCEDURE ValInputData
    (
        idtInitDate     in  date,
        idtFinalDate    in  date,
        inuOperation    in  number,
        inuDelayDays    in  number
    );

    PROCEDURE ValFrequency
    (
        idtInitDate     in  date,
        idtFinalDate    in  date,
        inuDelayDays    in  number,
        isbFrequency    in  varchar2
    );

    PROCEDURE ValidateConcurrence
    (
        idtInitDate     in  date,
        idtFinalDate    in  date,
        inuDelayDays    in  number,
        isbRollProcess  in  varchar2 default null
    );

    PROCEDURE InitConcurrenceCtrl
    (
        idtInitDate     in  date,
        idtFinalDate    in  date,
        isbSentence     in  varchar2
    );

    PROCEDURE Process
    (
        idtInitialDate  in  date,
        idtFinalDate    in  date,
        inuThreads      in  number,
        inuThread       in  number,
        isbProcStatus   in  estaprog.esprprog%type
    );

    PROCEDURE GetProcessDates
    (
        idtInitialDate  in  date,
        idtFinalDate    in  date,
        inuDelayDays    in  number,
        odtInitialDate  out date,
        odtFinalDate    out date
    );

    PROCEDURE ValExecuteFGHE
    (
        idtInitialDate  in  date,
        idtFinalDate    in  date
    );

    FUNCTION fnuIsGivBackCheckCause
    (
        inuChargeCause  in  causcarg.cacacodi%type
    )
        RETURN number;

END IC_BOCompletServiceInt;
/
CREATE OR REPLACE PACKAGE BODY      adm_person.IC_BOCOMPLETSERVICEINT AS
/*
    Propiedad intelectual de Open International Systems (c).

    Paquete     :   IC_BOCompletServiceInt
    Descripción :   Variables, procedimientos y funciones del paquete
                    IC_BOCompletServiceInt.

    Autor       :   Alejandro Rendón Gómez
    Fecha       :   12-07-2012 11:24:00

    Historia de Modificaciones
    Fecha       IDEntrega

    04-06-2014  aesguerra.3762
    Se modifica <<IC_BOCompletServiceInt.Process.ChargesDistribution>>

    20-05-2014  aesguerra.3605
    Se modifica <<Process>>

    24-04-2014  aesguerra.3487
    Se modifica <<Process>>

    18-03-2014  arendon.SAO235707
    Se modifica para adicionar el reporte de los Hechos Económicos
    correspondientes a Notas de Facturación.
    Se modifican los métodos:
        - Process
        - ValExecuteFGHE
    Se adiciona el método <fnuIsGivBackCheckCause>

    23-07-2013  hlopez.SAO212970
    Se modifica la forma de obtener el atributo Clasificacion COntable del
    Contrato
    - Se modifica el método <Process>

    17-07-2013  hlopez.SAO212472
    Se adiciona el atributo Clasificacion Contable del Contrato
    - Se modifica el método <Process> y <ValExecuteFGHE>

    05-04-2013  arendon.SAO205719
    Se adiciona la selección del atributo Ýtem para los movimientos de ÿrdenes
    incluidas en una acta.

    12-10-2012  arendon.SAO193932
    Se modifica el método <Process>

    10-10-2012  arendon.SAO193603
    Se modifica el método <Process>

    09-10-2012  hlopez.SAO193548
    Se modifica el método <Process>

    13-09-2012  arendon.SAO190941
    Se adiciona el método <ValExecuteFGHE>.

    12-07-2012  arendon.SAO185253
    Creación.
*/

    -------------------
    -- Constantes
    -------------------

    /* Versión de paquete */
    csbVERSION          constant varchar2(250) := '3762';

    /* Mnemónico del proceso de reversión de Servicios Cumplidos */
    csbROLLBACK_PROCESS constant varchar2(10) := 'ICBRSC';

    /* Cadenas para reemplazar en los mensajes de error */
    csbINGRESO constant varchar2(100) := 'Ingresó';
    csbNO_INGRESO constant varchar2(100) := 'No ingresó';
    csbDEBE constant varchar2(100) := 'debe';
    csbNO_DEBE constant varchar2(100) := 'no debe';
    csbDIAS_RETRASO constant varchar2(100) := 'Días Retraso';
    csbFECHA_INICIAL constant varchar2(100) := 'Fecha Inicial';
    csbFECHA_FINAL constant varchar2(100) := 'Fecha Final';

    /* Formato de fecha */
    cnuFORMAT   constant varchar2(10) := 'DD-MM-YYYY';

    /* Límite de selección de datos */
    cnuLIMIT            constant number := 100;

    /* Tipo de documento Facturación */
    cnuDOC_TYPE_BILL    constant number := 71;

    /* Tipo de documento Actas */
    cnuDOC_TYPE_CERTF   constant number := 77;

    /* Tipo de documento Notas */
    cnuDOC_TYPE_NOTES   constant number := 73;

    -------------------
    -- Variables
    -------------------
    sbErrMsg            ge_message.description%type;

    -- Indicador de carga de parámetros
    boLoaded            boolean;

    -- Tabla con los tipos de trabajo INSTALACIÿN
    tbInstallTaskType   UT_String.TyTb_String;

    --Parámetro de tipos de trabajo instalación y red interna
    sbInstTaskType ge_parameter.value%type;

    --Tipo de paquete Venta constructora
    cnuConstructorPackTypeId constant ps_package_type.package_type_id%type := 323;

    -- Indicador de carga de conceptos
    boConceptLoaded     boolean;

    -- Usuario ejecutor
    sbUserName          varchar2(2000);

    -- Terminal
    sbTerminal          varchar2(2000);

    -- Nivel de ubicación geográfica 1
    nuNivelUbge1    ge_geogra_loca_type.geog_loca_area_type%type;
    -- Nivel de ubicación geográfica 2
    nuNivelUbge2    ge_geogra_loca_type.geog_loca_area_type%type;
    -- Nivel de ubicación geográfica 3
    nuNivelUbge3    ge_geogra_loca_type.geog_loca_area_type%type;
    -- Nivel de ubicación geográfica 4
    nuNivelUbge4    ge_geogra_loca_type.geog_loca_area_type%type;
    -- Nivel de ubicación geográfica 5
    nuNivelUbge5    ge_geogra_loca_type.geog_loca_area_type%type;

    -- Identificador de ubicación 1 (LOCALIDAD (S) - BARRIO (N))
    sbLOCBAR1       VARCHAR2(1);
    -- Identificador de ubicación 2 (LOCALIDAD (S) - BARRIO (N))
    sbLOCBAR2       VARCHAR2(1);
    -- Identificador de ubicación 3 (LOCALIDAD (S) - BARRIO (N))
    sbLOCBAR3       VARCHAR2(1);
    -- Identificador de ubicación 4 (LOCALIDAD (S) - BARRIO (N))
    sbLOCBAR4       VARCHAR2(1);
    -- Identificador de ubicación 5 (LOCALIDAD (S) - BARRIO (N))
    sbLOCBAR5       VARCHAR2(1);

    -------------------
    -- Colecciones
    -------------------
    -- Tabla para el caché de los conceptos
    type tytbConcepto is table of pkBCConcepto.tyConcepto index BY binary_integer;
    tbConcepto      tytbConcepto;

    sbObject    openfltr.opftobje%type := 'SERVICIOSCUMPLIDOS';
    sbTerm      openfltr.opftterm%type := userenv('TERMINAL');
    sbUser      openfltr.opftuser%type := USER;

    -------------------
    -- Métodos
    -------------------
    /*
        Propiedad intelectual de Open International Systems. (c).

        Función   :   fsbVersion
        Descripcion  :   Obtiene SAO que identifica versión asociada a última
                        entrega de paquete.

        Retorno     :
            csbVersion      Versión de paquete.

        Autor      :   Alejandro Rendón Gómez
        Fecha      :   12-07-2012 10:40:08

        Historia de Modificaciones
        Fecha      IDEntrega

        12-07-2012  arendon.SAO185253
        Creación.
    */

    FUNCTION fsbVersion
        return varchar2
    IS
    BEGIN

        return IC_BOCompletServiceInt.csbVERSION;

    EXCEPTION
        when LOGIN_DENIED then
            pkErrors.pop;
            raise LOGIN_DENIED;

        when pkConstante.exERROR_LEVEL2 then
            -- Error Oracle nivel dos
            pkErrors.pop;
            raise pkConstante.exERROR_LEVEL2;

        when OTHERS then
            pkErrors.NotifyError
            (
                pkErrors.fsbLastObject,
                sqlerrm,
                IC_BOCompletServiceInt.sbErrMsg
            );
            pkErrors.pop;
            raise_application_error
            (
                pkConstante.nuERROR_LEVEL2,
                IC_BOCompletServiceInt.sbErrMsg
            );
    END fsbVersion;

    /*
        Propiedad intelectual de Open Systems (c).
        Procedure       :   GetParameters
        Descripción     :   Obtiene los parámetros generales del sistema

        Autor       :   Alejandro Rendón Gómez
        Fecha       :   19-07-2012 08:46:18

        Historia de Modificaciones
        Fecha       IDEntrega

        19-07-2012  arendon.SAO185253
        Creación.
    */
    PROCEDURE GetParameters
    IS
        -------------------
        -- Constantes
        -------------------
        -- Parámetro Tipos De Trabajo de Instalación
        csbTIPO_TRABAJO constant varchar2(100) := 'IC_INSTALL_TASK_TYPE';

        -- Caracter separador
        csbPIPE         constant char(1) := '|';

        csbComma        constant char(1) := ',';

        -------------------
        -- Variables
        -------------------
        sbInstallTaskType   ge_parameter.description%type;

    BEGIN
        pkErrors.Push('IC_BOCompletServiceInt.GetParameters');

        -- Evalua si ya se han cargado los parametros y termina el método
        if ( IC_BOCompletServiceInt.boLoaded ) then
            pkErrors.Pop;
            return;
        end if;

        -- Obtiene el valor del parametro
        sbInstallTaskType := GE_BOParameter.fsbValorAlfanumerico
                                (
                                    csbTIPO_TRABAJO
                                );

        sbInstTaskType := replace(sbInstallTaskType,csbPIPE,csbComma);

        -- Parsea el parámetro y obtiene los tipos configurados
        UT_String.ExtString
        (
            sbInstallTaskType,
            csbPIPE,
            IC_BOCompletServiceInt.tbInstallTaskType
        );

        -- Obtiene usuario ejecutor y terminal
        IC_BOCompletServiceInt.sbTerminal := pkGeneralServices.fsbGetTerminal;
        IC_BOCompletServiceInt.sbUserName := pkGeneralServices.fsbGetUserName;

        -- Obtiene los niveles de ubicación geográficas.
        GE_BOGeogra_Location.GetUbges
        (
            IC_BOCompletServiceInt.nuNivelUbge1,
            IC_BOCompletServiceInt.nuNivelUbge2,
            IC_BOCompletServiceInt.nuNivelUbge3,
            IC_BOCompletServiceInt.nuNivelUbge4,
            IC_BOCompletServiceInt.nuNivelUbge5,
            IC_BOCompletServiceInt.sbLOCBAR1,
            IC_BOCompletServiceInt.sbLOCBAR2,
            IC_BOCompletServiceInt.sbLOCBAR3,
            IC_BOCompletServiceInt.sbLOCBAR4,
            IC_BOCompletServiceInt.sbLOCBAR5
        );


        -- Actualiza el indicador de carga de parámetros
        IC_BOCompletServiceInt.boLoaded := TRUE;

        pkErrors.Pop;
    EXCEPTION
        when LOGIN_DENIED then
            pkErrors.pop;
            raise LOGIN_DENIED;

        when pkConstante.exERROR_LEVEL2 then
            -- Error Oracle nivel dos
            pkErrors.pop;
            raise pkConstante.exERROR_LEVEL2;

        when OTHERS then
            pkErrors.NotifyError
            (
                pkErrors.fsbLastObject,
                sqlerrm,
                IC_BOCompletServiceInt.sbErrMsg
            );
            pkErrors.pop;
            raise_application_error
            (
                pkConstante.nuERROR_LEVEL2,
                IC_BOCompletServiceInt.sbErrMsg
            );
    END GetParameters;


    -- TRAZA PARA SEGUIMIENTO
    procedure TraceInsertion
    (
        isbString varchar2,
        inuProductId number
    )
    IS
        PRAGMA AUTONOMOUS_TRANSACTION;

        nuConsecu number;

        cnuMax    constant number := 2000;
        nuPosIni  number ;

        PROCEDURE InsTraza (isbPedazo varchar2) IS
        BEGIN
            -- Obtiene el siguiente consecutivo desde la secuencia.
            execute immediate 'SELECT SQ_OPENFLTR_OPFTCONS.nextval FROM dual ' INTO  nuConsecu;
            --INSERT INTO openfltr (opftcons, opftobje, opftterm, opftuser, opftfech, opftdesc)
            --VALUES (nuConsecu, sbObject||inuProductId, sbTerm, sbUser, sysdate, isbPedazo);
            --commit;
        EXCEPTION
            when others then
                null; -- par que no falle el proceso que lo ejecuta
        END;

    BEGIN

        nuPosIni := 1;

        while (true) loop
            -- Si la longitud de la cadena de entrada desde la posicion inicial
            -- hasta el final es mayor a cnuMax
            if length(substr(isbString,nuPosIni,length(isbString)))>cnuMax then
                -- Imprime inuLong caracteres a partir de la posicion inicial
                InsTraza (substr(isbString,nuPosIni,cnuMax));
                -- Incrementa la posicion inicial en inuLong caracteres para
                -- la prox iteracion
                nuPosIni:=nuPosIni+cnuMax;
            else
                -- La cadena desde la posicion inicial hasta el final tiene
                -- menos de 2000 caracteres.
                InsTraza (substr(isbString,nuPosIni,length(isbString)));
                return;
            END if;
        END loop;
    END TraceInsertion;


    /*
        Propiedad intelectual de Open Systems (c).
        Procedure       :   ValInputData
        Descripción     :   Valida los parámetros de entrada

        Parámetros
        Entrada         :       Descripción
            idtInitDate             Fecha inicial
            idtFinalDate            Fecha final
            inuOperation            Operación (1-Generación, 2-Reversión)
            inuDelayDays            Días de retraso

        Autor       :   Alejandro Rendón Gómez
        Fecha       :   12-07-2012 11:32:15

        Historia de Modificaciones
        Fecha       IDEntrega

        12-07-2012  arendon.SAO185253
        Creación.
    */
    PROCEDURE ValInputData
    (
        idtInitDate     in  date,
        idtFinalDate    in  date,
        inuOperation    in  number,
        inuDelayDays    in  number
    )
    IS
    BEGIN
        pkErrors.Push('IC_BOCompletServiceInt.ValInputData');

        -----------------------------------------
        -- Valida que se ingresen las dos fechas
        -- o que no se ingrese ninguna
        -----------------------------------------
        -- Se valida si fecha inicial es NULL
        if ( idtInitDate IS null AND idtFinalDate IS not null ) then
            pkErrors.SetErrorCode
            (
                pkConstante.csbDIVISION,
                pkConstante.csbMOD_INT,
                5487
            );

            pkErrors.ChangeMessage
            (
                '%1',
                IC_BOCompletServiceInt.csbFECHA_INICIAL
            );

            raise LOGIN_DENIED;
        end if;

        -- Se valida si fecha final es NULL
        if ( idtInitDate IS not null AND idtFinalDate IS null ) then
            pkErrors.SetErrorCode
            (
                pkConstante.csbDIVISION,
                pkConstante.csbMOD_INT,
                5487
            );

            pkErrors.ChangeMessage
            (
                '%1',
                IC_BOCompletServiceInt.csbFECHA_FINAL
            );

            raise LOGIN_DENIED;
        end if;

        -- Se valida que la fecha inicial no sea mayor que la fecha final.
        pkGeneralServices.ValDateRange
        (
            idtInitDate,
            idtFinalDate
        );

        -- Se valida operacion es generacion
        if( inuOperation = IC_BOCompletServiceInt.cnuGENERATION )then
            -- Si fechaIni es NULL y fechaFin es NULL
            if ( idtInitDate IS null AND idtFinalDate IS null ) then
                -- Se valida que dias de restraso es nulo.
                if (inuDelayDays IS null) then

                    pkErrors.SetErrorCode
                    (
                        pkConstante.csbDIVISION,
                        pkConstante.csbMOD_INT,
                        5488
                    );

                    pkErrors.ChangeMessage
                    (
                        '%1',
                        IC_BOCompletServiceInt.csbNO_INGRESO
                    );

                    pkErrors.ChangeMessage
                    (
                        '%2',
                        IC_BOCompletServiceInt.csbDEBE
                    );

                    raise LOGIN_DENIED;
                end if;

                -- Se valida que dias de retraso sea mayor o igual a cero.
                if ( inuDelayDays < 0 ) then
                    pkErrors.SetErrorCode
                    (
                        pkConstante.csbDIVISION,
                        pkConstante.csbMOD_INT,
                        13623
                    );

                    pkErrors.ChangeMessage
                    (
                        '%s1',
                        IC_BOCompletServiceInt.csbDIAS_RETRASO
                    );

                    raise LOGIN_DENIED;
                end if;
            end if;

            -- Si fechaIni no es NULL y fechaFin no es NULL
            if ( idtInitDate IS not null AND idtFinalDate IS not null ) then

                -- Se valida que dias de retraso no es nulo.
                if ( inuDelayDays IS not null ) then
                    pkErrors.SetErrorCode
                    (
                        pkConstante.csbDIVISION,
                        pkConstante.csbMOD_INT,
                        5488
                    );

                    pkErrors.ChangeMessage
                    (
                        '%1',
                        IC_BOCompletServiceInt.csbINGRESO
                    );

                    pkErrors.ChangeMessage
                    (
                        '%2',
                        IC_BOCompletServiceInt.csbNO_DEBE
                    );

                    raise LOGIN_DENIED;
                end if;
            end if;
        end if;

        -- Se valida operacion es reversion
        if( inuOperation = IC_BOCompletServiceInt.cnuROLLBACK )then

            -- Se valida si fecha final es NULL
            if ( idtInitDate IS null AND idtFinalDate IS null ) then
                pkErrors.SetErrorCode
                (
                    pkConstante.csbDIVISION,
                    pkConstante.csbMOD_INT,
                    13622
                );

                raise LOGIN_DENIED;
            end if;

            -- Se valida que dias de retraso no es nulo.
            if ( inuDelayDays IS not null ) then
                pkErrors.SetErrorCode
                (
                    pkConstante.csbDIVISION,
                    pkConstante.csbMOD_INT,
                    5488
                );

                pkErrors.ChangeMessage
                (
                    '%1',
                    IC_BOCompletServiceInt.csbINGRESO
                );

                pkErrors.ChangeMessage
                (
                    '%2',
                    IC_BOCompletServiceInt.csbNO_DEBE
                );

                raise LOGIN_DENIED;
            end if;
        end if;

        pkErrors.Pop;
    EXCEPTION
        when LOGIN_DENIED then
            pkErrors.pop;
            raise LOGIN_DENIED;

        when pkConstante.exERROR_LEVEL2 then
            -- Error Oracle nivel dos
            pkErrors.pop;
            raise pkConstante.exERROR_LEVEL2;

        when OTHERS then
            pkErrors.NotifyError
            (
                pkErrors.fsbLastObject,
                sqlerrm,
                IC_BOCompletServiceInt.sbErrMsg
            );
            pkErrors.pop;
            raise_application_error
            (
                pkConstante.nuERROR_LEVEL2,
                IC_BOCompletServiceInt.sbErrMsg
            );
    END ValInputData;

    /*
        Propiedad intelectual de Open Systems (c).
        Procedure       :   ValFrequency
        Descripción     :   Valida la frecuencia de ejecución

        Parámetros
        Entrada         :       Descripción
            idtInitDate             Fecha inicial
            idtFinalDate            Fecha final
            inuDelayDays            Días de retraso
            isbFrequency            Frecuencia

        Autor       :   Alejandro Rendón Gómez
        Fecha       :   17-07-2012 15:51:13

        Historia de Modificaciones
        Fecha       IDEntrega

        13-09-2012  arendon.SAO190941
        Se adiciona validación para no permitir que la frecuencia sea diferente
        a UNA VEZ o DIARIO.

        17-07-2012  arendon.SAO185253
        Creación.
    */
    PROCEDURE ValFrequency
    (
        idtInitDate     in  date,
        idtFinalDate    in  date,
        inuDelayDays    in  number,
        isbFrequency    in  varchar2
    )
    IS
    BEGIN
        pkErrors.Push('IC_BOCompletServiceInt.ValFrequency');

        -- si fecuencia diferente a Diaria o Solo una vez
        if (isbFrequency not IN (GE_BOSchedule.csbSoloUnaVez,GE_BOSchedule.csbDiario)) then
            pkErrors.SetErrorCode
            (
                pkconstante.csbDIVISION,
                pkconstante.csbMOD_INT,
                13641
            );
            raise LOGIN_DENIED;
        end if;

        -- Si frecuencia diaria
        if ( isbFrequency = GE_BOSchedule.csbDiario ) then

            --Si fechaini NO NULL y fechafin NO NULL
            if ( idtInitDate is not null AND idtFinalDate is not null ) then
                pkErrors.SetErrorCode
                (
                    pkconstante.csbDIVISION,
                    pkconstante.csbMOD_INT,
                    13661
                );
                raise LOGIN_DENIED;
            end if;

            -- Si diasretraso es NULL
            if ( inuDelayDays is null ) then
                pkErrors.SetErrorCode
                (
                    pkconstante.csbDIVISION,
                    pkconstante.csbMOD_INT,
                    5488
                );
                pkErrors.ChangeMessage
                (
                    '%1',
                    IC_BOCompletServiceInt.csbNO_INGRESO
                );
                pkErrors.ChangeMessage
                (
                    '%2',
                    IC_BOCompletServiceInt.csbDEBE
                );
                raise LOGIN_DENIED;
            end if;

            -- Si diasretraso menor a cero
            if ( inuDelayDays < 0 ) then
                pkErrors.SetErrorCode
                (
                    pkconstante.csbDIVISION,
                    pkconstante.csbMOD_INT,
                    13623
                );
                pkErrors.ChangeMessage
                (
                    '%s1',
                    IC_BOCompletServiceInt.csbDIAS_RETRASO
                );
                raise LOGIN_DENIED;
            end if;

        end if;

        -- si frecuencia Solo una vez
        if ( isbFrequency = GE_BOSchedule.csbSoloUnaVez ) then

            -- Si fechaini NULL y fechafin NULL
            if ( idtInitDate is null AND idtFinalDate is null ) then
                pkErrors.SetErrorCode
                (
                    pkconstante.csbDIVISION,
                    pkconstante.csbMOD_INT,
                    13622
                );
                raise LOGIN_DENIED;
            end if;

            -- Si diasretraso mayor debe ser nulo
            if ( inuDelayDays IS not null ) then
                pkErrors.SetErrorCode
                (
                    pkconstante.csbDIVISION,
                    pkconstante.csbMOD_INT,
                    5488
                );
                pkErrors.ChangeMessage
                (
                    '%1',
                    IC_BOCompletServiceInt.csbINGRESO
                );
                pkErrors.ChangeMessage
                (
                    '%2',
                    IC_BOCompletServiceInt.csbNO_DEBE
                );
                raise LOGIN_DENIED;
            end if;
        end if;

        pkErrors.Pop;
    EXCEPTION
        when LOGIN_DENIED then
            pkErrors.pop;
            raise LOGIN_DENIED;

        when pkConstante.exERROR_LEVEL2 then
            -- Error Oracle nivel dos
            pkErrors.pop;
            raise pkConstante.exERROR_LEVEL2;

        when OTHERS then
            pkErrors.NotifyError
            (
                pkErrors.fsbLastObject,
                sqlerrm,
                IC_BOCompletServiceInt.sbErrMsg
            );
            pkErrors.pop;
            raise_application_error
            (
                pkConstante.nuERROR_LEVEL2,
                IC_BOCompletServiceInt.sbErrMsg
            );
    END ValFrequency;

    /*
        Propiedad intelectual de Open Systems (c).
        Procedure       :   ValidateConcurrence
        Descripción     :   Valida concurrencia de procesos

        Parámetros
        Entrada         :       Descripción
            idtInitDate             Fecha Inicial
            idtFinalDate            Fecha Final
            inuDelayDays            Días de retraso
            isbRollProcess          Proceso de reversión

        Autor       :   Alejandro Rendón Gómez
        Fecha       :   19-07-2012 18:33:14

        Historia de Modificaciones
        Fecha       IDEntrega

        19-07-2012  arendon.SAO185253
        Creación.
    */
    PROCEDURE ValidateConcurrence
    (
        idtInitDate     in  date,
        idtFinalDate    in  date,
        inuDelayDays    in  number,
        isbRollProcess  in  varchar2 default null
    )
    IS
        -------------------
        -- Variables
        -------------------
        -- Fecha inicial
        dtInitDate      date;

        -- Fecha final
        dtFinalDate     date;

        -- Proceso de reversión
        sbRollBackProcess   varchar2(10);

    BEGIN
        pkErrors.Push('IC_BOCompletServiceInt.ValidateConcurrence');

        -- Si hay días de retraso, cálcula las fechas de proceso a partir de estos
        if ( inuDelayDays IS not null ) then
            dtInitDate := trunc( sysdate ) - inuDelayDays;
            dtFinalDate := dtInitDate;
        else
            dtInitDate := idtInitDate;
            dtFinalDate := idtFinalDate;
        end if;

        -- Verifica si se envia proceso de reversión, tomando por defecto
        -- Reversion de Interfaz de Servicios Cumplidos
        if ( isbRollProcess IS null ) then
            sbRollBackProcess := IC_BOCompletServiceInt.csbROLLBACK_PROCESS;
        else
            sbRollBackProcess := isbRollProcess;
        end if;

        loop
            -- Condición de salida del ciclo
            exit when dtInitDate > dtFinalDate;

            -- Valida la concurrencia
            pkBOProcessConcurrenceCtrl.ValidateConcurrence
            (
                to_char( dtInitDate, IC_BOCompletServiceInt.cnuFORMAT),
                sbRollBackProcess
            );

            -- Incrementa la fecha
            dtInitDate := dtInitDate + 1;
        end loop;

        pkErrors.Pop;
    EXCEPTION
        when LOGIN_DENIED then
            pkErrors.pop;
            raise LOGIN_DENIED;

        when pkConstante.exERROR_LEVEL2 then
            -- Error Oracle nivel dos
            pkErrors.pop;
            raise pkConstante.exERROR_LEVEL2;

        when OTHERS then
            pkErrors.NotifyError
            (
                pkErrors.fsbLastObject,
                sqlerrm,
                IC_BOCompletServiceInt.sbErrMsg
            );
            pkErrors.pop;
            raise_application_error
            (
                pkConstante.nuERROR_LEVEL2,
                IC_BOCompletServiceInt.sbErrMsg
            );
    END ValidateConcurrence;

    /*
        Propiedad intelectual de Open Systems (c).
        Procedure       :   InitConcurrenceControl
        Descripción     :   Inicializa el control de concurrencia para el
                            proceso Interfaz de Servicios Cumplidos

        Parámetros
        Entrada         :       Descripción
            idtInitDate             Fecha Inicial
            idtFinalDate            Fecha Final
            isbSentence             Sentencia

        Autor       :   Alejandro Rendón Gómez
        Fecha       :   19-07-2012 15:41:48

        Historia de Modificaciones
        Fecha       IDEntrega

        19-07-2012  arendon.SAO185253
        Creación.
    */
    PROCEDURE InitConcurrenceCtrl
    (
        idtInitDate     in  date,
        idtFinalDate    in  date,
        isbSentence     in  varchar2
    )
    IS
        -------------------
        -- Variables
        -------------------
        -- Fecha actual de iteración
        dtCurrDate      date;

    BEGIN
        pkErrors.Push('IC_BOCompletServiceInt.InitConcurrenceCtrl');

        -- Asigna la fecha inicial
        dtCurrDate := idtInitDate;

        loop
            -- Termina el ciclo cuando se iteren todas las fechas
            exit when dtCurrDate > idtFinalDate;

            pkBOProcessConcurrenceCtrl.GenControlProcessAT
            (
                to_char( dtCurrDate, IC_BOCompletServiceInt.cnuFORMAT ),
                isbSentence
            );

            -- Incrementa la fecha en un día
            dtCurrDate := dtCurrDate + 1;

        end loop;

        pkErrors.Pop;
    EXCEPTION
        when LOGIN_DENIED then
            pkErrors.pop;
            raise LOGIN_DENIED;

        when pkConstante.exERROR_LEVEL2 then
            -- Error Oracle nivel dos
            pkErrors.pop;
            raise pkConstante.exERROR_LEVEL2;

        when OTHERS then
            pkErrors.NotifyError
            (
                pkErrors.fsbLastObject,
                sqlerrm,
                IC_BOCompletServiceInt.sbErrMsg
            );
            pkErrors.pop;
            raise_application_error
            (
                pkConstante.nuERROR_LEVEL2,
                IC_BOCompletServiceInt.sbErrMsg
            );
    END InitConcurrenceCtrl;

    /*
        Propiedad intelectual de Open Systems (c).
        Procedure       :   FinalizeConcurrenceCtrl
        Descripción     :   Finaliza control de concurrencia

        Parámetros
        Entrada         :       Descripción
            idtDate                 Fecha de proceso

        Autor       :   Alejandro Rendón Gómez
        Fecha       :   19-07-2012 17:04:58

        Historia de Modificaciones
        Fecha       IDEntrega

        19-07-2012  arendonSAO
        Creación.
    */
    PROCEDURE FinalizeConcurrenceCtrl
    (
        idtDate in  date
    )
    IS
    BEGIN
        pkErrors.Push('IC_BOCompletServiceInt.FinalizeConcurrenceCtrl');

        -- Finaliza el control de concurrencia
        pkBOProcessConcurrenceCtrl.FinConcurrenceControl
        (
            to_char( idtDate, IC_BOCompletServiceInt.cnuFORMAT )
        );

        pkErrors.Pop;
    EXCEPTION
        when LOGIN_DENIED then
            pkErrors.pop;
            raise LOGIN_DENIED;

        when pkConstante.exERROR_LEVEL2 then
            -- Error Oracle nivel dos
            pkErrors.pop;
            raise pkConstante.exERROR_LEVEL2;

        when OTHERS then
            pkErrors.NotifyError
            (
                pkErrors.fsbLastObject,
                sqlerrm,
                IC_BOCompletServiceInt.sbErrMsg
            );
            pkErrors.pop;
            raise_application_error
            (
                pkConstante.nuERROR_LEVEL2,
                IC_BOCompletServiceInt.sbErrMsg
            );
    END FinalizeConcurrenceCtrl;

    /*
        Propiedad intelectual de Open Systems (c).
        Procedure       :   GetProcessDates
        Descripción     :   Calcula las fechas de procesamiento dependiendo si
                            hay o no días de retraso

        Parámetros
        Entrada         :       Descripción
            idtInitialDate          Fecha inicial
            idtFinalDate            Fecha final
            inuDelayDays            Días de retraso

        Salida          :       Descripción
            odtInitialDate          Fecha inicial definitiva
            odtFinalDate            Fecha final definitiva

        Autor       :   Alejandro Rendón Gómez
        Fecha       :   23-07-2012 14:36:12

        Historia de Modificaciones
        Fecha       IDEntrega

        23-07-2012  arendon.SAO185253
        Creación.
    */
    PROCEDURE GetProcessDates
    (
        idtInitialDate  in  date,
        idtFinalDate    in  date,
        inuDelayDays    in  number,
        odtInitialDate  out date,
        odtFinalDate    out date
    )
    IS
    BEGIN
        pkErrors.Push('IC_BOCompletServiceInt.GetProcessDates');

        ------------------------------------------
        -- Inicializa las fechas de procesamiento
        ------------------------------------------
        -- Si hay días de retraso, las fechas de proceso se calculan a partir
        -- de la fecha actual restando los días de retraso, en caso contrario
        -- se usan las fechas ingresadas por parámetro.
        if ( inuDelayDays IS not null ) then
            odtInitialDate := trunc( sysdate ) - inuDelayDays;
            odtFinalDate := to_date
                            (
                                to_char( odtInitialDate, 'ddmmyyyy') || ' 23:59:59',
                                'ddmmyyyy hh24:mi:ss'
                            );
        else
            odtInitialDate := idtInitialDate;
            odtFinalDate := to_date
                            (
                                to_char(idtFinalDate,'ddmmyyyy') || ' 23:59:59',
                                'ddmmyyyy hh24:mi:ss'
                            );
        end if;

        pkErrors.Pop;
    EXCEPTION
        when LOGIN_DENIED then
            pkErrors.pop;
            raise LOGIN_DENIED;

        when pkConstante.exERROR_LEVEL2 then
            -- Error Oracle nivel dos
            pkErrors.pop;
            raise pkConstante.exERROR_LEVEL2;

        when OTHERS then
            pkErrors.NotifyError
            (
                pkErrors.fsbLastObject,
                sqlerrm,
                sbErrMsg
            );
            pkErrors.pop;
            raise_application_error
            (
                pkConstante.nuERROR_LEVEL2,
                sbErrMsg
            );
    END GetProcessDates;

    /*
        Propiedad intelectual de Open Systems (c).
        Procedure       : LoadConcepts
        Descripcion     : Obtiene los conceptos existentes en el sistema de tipo
                          diferente a IMPUESTO.

        Autor    :  Alejandro Rendón Gómez
        Fecha    :  24-07-2012 17:04:35

        Historia de Modificaciones
        Fecha       IDEntrega

        24-07-2012  arendon.SAO185253
        Creación.
    */
    PROCEDURE LoadConcepts
    IS
        -------------------
        -- VARIABLES
        -------------------
        -- Cursor de conceptos
        rfConcepts  constants.tyRefCursor;

        -- Tabla PL de concepto para obtener los datos del CURSOR
        tbConcTmp   tytbConcepto;

        -- Indice para recorrer la tabla de conceptos
        nuIdx       number;

    BEGIN
        pkErrors.Push('IC_BOCompletServiceInt.LoadConcepts');

        -- Obtiene todos los conceptos cuyo tipo de concepto de liquidación
        -- es diferente a impuesto.
        rfConcepts := pkBCConcepto.frfGetSalesConcepts;

        loop
            -- Obtiene los datos
            fetch   rfConcepts
            bulk    collect
            into    tbConcTmp
            limit   IC_BOCompletServiceInt.cnuLIMIT;

            -- Termina la iteración cuando no obtenga mas datos
            exit when tbConcTmp.first is null;

            -- Obtiene la primera posición de la tabla
            nuIdx := tbConcTmp.first;

            loop
                -- Condición de salida
                exit when nuIdx IS null;

                -- Llena la tabla final indexando por el código del concepto
                IC_BOCompletServiceInt.tbConcepto( tbConcTmp( nuIdx ).conccodi ).conccodi :=
                                                    tbConcTmp( nuIdx ).conccodi;
                IC_BOCompletServiceInt.tbConcepto( tbConcTmp( nuIdx ).conccodi ).concdesc :=
                                                    tbConcTmp( nuIdx ).concdesc;
                IC_BOCompletServiceInt.tbConcepto( tbConcTmp( nuIdx ).conccodi ).conccoco :=
                                                    tbConcTmp( nuIdx ).conccoco;
                IC_BOCompletServiceInt.tbConcepto( tbConcTmp( nuIdx ).conccodi ).concorli :=
                                                    tbConcTmp( nuIdx ).concorli;
                IC_BOCompletServiceInt.tbConcepto( tbConcTmp( nuIdx ).conccodi ).concpoiv :=
                                                    tbConcTmp( nuIdx ).concpoiv;
                IC_BOCompletServiceInt.tbConcepto( tbConcTmp( nuIdx ).conccodi ).concorim :=
                                                    tbConcTmp( nuIdx ).concorim;
                IC_BOCompletServiceInt.tbConcepto( tbConcTmp( nuIdx ).conccodi ).concorge :=
                                                    tbConcTmp( nuIdx ).concorge;
                IC_BOCompletServiceInt.tbConcepto( tbConcTmp( nuIdx ).conccodi ).concdife :=
                                                    tbConcTmp( nuIdx ).concdife;
                IC_BOCompletServiceInt.tbConcepto( tbConcTmp( nuIdx ).conccodi ).conccore :=
                                                    tbConcTmp( nuIdx ).conccore;
                IC_BOCompletServiceInt.tbConcepto( tbConcTmp( nuIdx ).conccodi ).conccoin :=
                                                    tbConcTmp( nuIdx ).conccoin;
                IC_BOCompletServiceInt.tbConcepto( tbConcTmp( nuIdx ).conccodi ).concflde :=
                                                    tbConcTmp( nuIdx ).concflde;
                IC_BOCompletServiceInt.tbConcepto( tbConcTmp( nuIdx ).conccodi ).concunme :=
                                                    tbConcTmp( nuIdx ).concunme;
                IC_BOCompletServiceInt.tbConcepto( tbConcTmp( nuIdx ).conccodi ).concdefa :=
                                                    tbConcTmp( nuIdx ).concdefa;
                IC_BOCompletServiceInt.tbConcepto( tbConcTmp( nuIdx ).conccodi ).concflim :=
                                                    tbConcTmp( nuIdx ).concflim;
                IC_BOCompletServiceInt.tbConcepto( tbConcTmp( nuIdx ).conccodi ).concsigl :=
                                                    tbConcTmp( nuIdx ).concsigl;
                IC_BOCompletServiceInt.tbConcepto( tbConcTmp( nuIdx ).conccodi ).conctico :=
                                                    tbConcTmp( nuIdx ).conctico;
                IC_BOCompletServiceInt.tbConcepto( tbConcTmp( nuIdx ).conccodi ).concnive :=
                                                    tbConcTmp( nuIdx ).concnive;
                IC_BOCompletServiceInt.tbConcepto( tbConcTmp( nuIdx ).conccodi ).concclco :=
                                                    tbConcTmp( nuIdx ).concclco;
                IC_BOCompletServiceInt.tbConcepto( tbConcTmp( nuIdx ).conccodi ).concticc :=
                                                    tbConcTmp( nuIdx ).concticc;
                IC_BOCompletServiceInt.tbConcepto( tbConcTmp( nuIdx ).conccodi ).concticl :=
                                                    tbConcTmp( nuIdx ).concticl;
                IC_BOCompletServiceInt.tbConcepto( tbConcTmp( nuIdx ).conccodi ).concappr :=
                                                    tbConcTmp( nuIdx ).concappr;
                IC_BOCompletServiceInt.tbConcepto( tbConcTmp( nuIdx ).conccodi ).rowid :=
                                                    tbConcTmp( nuIdx ).rowid;

                -- Actualiza el índice con la siguiente posición de la tabla
                nuIdx := tbConcTmp.next( nuIdx );

            end loop;

        end loop;
        -- Cierra el cursor
        close rfConcepts;

        IC_BOCompletServiceInt.boConceptLoaded := TRUE;

        pkErrors.Pop;
    EXCEPTION
        when LOGIN_DENIED then
            pkErrors.pop;
            raise LOGIN_DENIED;

        when pkConstante.exERROR_LEVEL2 then
            -- Error Oracle nivel dos
            pkErrors.pop;
            raise pkConstante.exERROR_LEVEL2;

        when OTHERS then
            pkErrors.NotifyError
            (
                pkErrors.fsbLastObject,
                sqlerrm,
                IC_BOCompletServiceInt.sbErrMsg
            );
            pkErrors.pop;
            raise_application_error
            (
                pkConstante.nuERROR_LEVEL2,
                IC_BOCompletServiceInt.sbErrMsg
            );
    END LoadConcepts;

    /*
        Propiedad intelectual de Open Systems (c).
        Procedure       :   Process
        Descripción     :   Genera los movimientos de Servicios Cumplidos

        Parámetros
        Entrada         :       Descripción
            idtInitialDate          Fecha inicial
            idtFinalDate            Fecha final
            inuDelayDays            Días de retraso
            inuThreads              Número total de hilos
            inuThread               Hilo actual
            isbProcStatus           Identificador de seguimiento del estado del
                                    proceso

        Salida          :       Descripción

        Autor       :   Alejandro Rendón Gómez
        Fecha       :   18-07-2012 09:21:37

        Historia de Modificaciones
        Fecha       IDEntrega

        24-04-2014  aesguerra.3487
        Se adiciona validación para determinar si la solicitud fue procesada por una orden previa.

        18-03-2014  arendon.SAO235707
        Se modifica para adicionar el reporte de los Hechos Económicos
        correspondientes a Notas de Facturación.
        Se modifican los método anidados:
            - ChargesDistribution
            - GetDocNumbers
            - ProcessCharges
            - CreateBillMovs
        Se adiciona el método anidado ProcessNotes

        23-07-2013  hlopez.SAO212970
        Se modifica la forma de obtener el atributo Clasificacion COntable del
        Contrato
        - Se modifica el método <ProcessItemsWithoutCertf>

        17-07-2013  hlopez.SAO212472
        Se adiciona el atributo Clasificacion Contable del Contrato
        - Se modifica los métodos internos <ClearMemory>, <FillTable>,
          <ProcessOrderWithCertf>, <ProcessOrderWithoutCertf> y <ProcessOrders>
        - Se adiciona el método <ProcessItemsWithoutCertf> para contabilizar los
          items de materiales que no salen en actas.

        05-04-2013  arendon.SAO205719
        Se adiciona el atributo MOVIITEM a los hechos económicos de Servicios
        Cumplidos.

        12-10-2012  arendon.SAO193932
        Se modifica el método anidado <ChargesDistribution>

        10-10-2012  arendon.SAO193603
        Se modifican los métodos anidados
            - ProcessOrders
            - ChargesDistribution
            - ProcessOrderWithCertf
            - ProcessOrderWithoutCertf

        09-10-2012  hlopez.SAO193548
        Se modifican los métodos <ClearMemory> y <FillTable>

        18-07-2012  arendon.SAO185253
        Creación.
    */
    PROCEDURE Process
    (
        idtInitialDate  in  date,
        idtFinalDate    in  date,
        inuThreads      in  number,
        inuThread       in  number,
        isbProcStatus   in  estaprog.esprprog%type
    )
    IS

        --<<
        --
        -- Edmundo Lara
        -- 04/03/2015
        -- Consulta de la tabla sistemas para conocer el nit de la LDC, Si este es igual al
        -- del parametro, se ejetuca un metodo diferente PERO SOLO PARA GDCA.
        -- El valor de este parametro VAL_NIT_SERV_CUMP_GDCA en la tabla LDCI_CARASEWE, debe
        -- tener el nit de GDCA, para que solo se ejecute el proceso de cumplidos para ellos
        -- que es diferente.
        --
        -->>

        Cursor cusistemas is
          select sistnitc
            from sistema;

        /* Nit de la LDC de la tabla Sistema */
        csbNitLdc     sistema.sistnitc%type;
        --
        csbNitGdca    ldci_carasewe.casevalo%type;

        -->>

        -------------------
        -- Tipos
        -------------------
        type tytbHicaesco IS table of hicaesco.hcecnuse%type index BY binary_integer;

        -------------------
        -- Variables
        -------------------
        /* Fecha actual de procesamiento */
        dtCurrentDate   date;

        /* Número del documento de Facturación */
        nuBillDocNumber     ic_docugene.dogenudo%type;

        /* Número del documento de Actas */
        nuCertfDocNumber    ic_docugene.dogenudo%type;

        /* Número del documento de Notas */
        nuNoteDocNumber     ic_docugene.dogenudo%type;

        /* Código de la solicitud */
        nuPackageId     or_order_activity.package_id%type;

        /* Tabla de órdenes */
        tbProducts        tytbHicaesco;

        /* Registro del producto actual */
        rcSesunuse     servsusc%rowtype;

        --<<
        -- Dcardona
        -- 12-12-2014
        -- Variable para el plan comercial de las ventas abiertas migradas
        -->>
        inuCommercial_plan       mo_motive.commercial_plan_id%TYPE;

        -------------------
        -- Constantes
        -------------------
        /* Tipo de movimiento Facturación por concepto */
        cnuMOVE_TYPE_BILL   constant number := 1;

        /* Tipo de movimiento Actas de liquidación */
        cnuMOVE_TYPE_CERTF  constant number := 63;

        /* Tipo de movimiento Notas por concepto */
        cnuMOVE_TYPE_NOTES  constant number := 16;

        /* Tipo de hecho económico Servicios Cumplidos */
        csbTIHE_COMPL_SERV  constant varchar2(2) := 'SC';

        -------------------
        -- Colecciones
        -------------------
        type tyrcCargos IS record
        (
            cargpeco    cargos.cargpeco%type,
            cargvalo    cargos.cargvalo%type,
            concticl    concepto.concticl%type,
            concticc    concepto.concticc%type
        );

        type tytbCargos is table of tyrcCargos
            index by varchar2(100);

        -- Tabla de movimientos contables
        tbMov   pktblIc_movimien.tytbIc_Movimien;

        type tytbProcessFlag IS table of date index BY binary_integer;

        tbProcessFlag tytbProcessFlag;

        -------------------
        -- Métodos
        -------------------
        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       :   Initialize
            Descripción     :   Inicializa las variables de procesamiento

            Autor       :   Alejandro Rendón Gómez
            Fecha       :   19-07-2012 08:43:02

            Historia de Modificaciones
            Fecha       IDEntrega

            19-07-2012  arendon.SAO185253
            Creación.
        */
        PROCEDURE Initialize
        IS
        BEGIN
            pkErrors.Push('IC_BOCompletServiceInt.Process.Initialize');

            -- Obtiene los parámetros generales del sistema
            GetParameters;

            pkErrors.Pop;
        EXCEPTION
            when LOGIN_DENIED then
                pkErrors.pop;
                raise LOGIN_DENIED;

            when pkConstante.exERROR_LEVEL2 then
                -- Error Oracle nivel dos
                pkErrors.pop;
                raise pkConstante.exERROR_LEVEL2;

            when OTHERS then
                pkErrors.NotifyError
                (
                    pkErrors.fsbLastObject,
                    sqlerrm,
                    IC_BOCompletServiceInt.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt.sbErrMsg
                );
        END Initialize;


        /**********************************************************************
          Propiedad intelectual de OPEN International Systems
          Nombre              SetProcessDate

          Autor        Andrés Felipe Esguerra Restrepo

          Fecha               24-abr-2014

          Descripción         A partir del ID de una solicitud obtiene si ésta debe procesarse y
                              la fecha en que debe hacerse

          ***Parametros***
          Nombre        Descripción
          inuPackId           ID de la solicitud
        ***********************************************************************/
        PROCEDURE SetProcessDate(inuPackId in mo_packages.package_id%type) IS

        blHasOpenOrders boolean;

        csbTIPO_TRABAJO constant varchar2(100) := 'IC_INSTALL_TASK_TYPE';

        sbInstallTaskType   ge_parameter.description%type;

        BEGIN

            pkErrors.Push('IC_BOCompletServiceInt.Process.SetProcessDate');

            sbInstallTaskType := GE_BOParameter.fsbValorAlfanumerico(csbTIPO_TRABAJO);

            sbInstallTaskType := replace(sbInstallTaskType,'|',',');

      blHasOpenOrders := IC_BCCompletServiceInt.fblHasOpenOrders(inuPackId,sbInstallTaskType);

      if blHasOpenOrders then
          tbProcessFlag(inuPackId) := null;
      else
          tbProcessFlag(inuPackId) := IC_BCCompletServiceInt.fdtGetLastLegDate(inuPackId,sbInstallTaskType);
      END if;

            pkErrors.Pop;

        EXCEPTION
            when LOGIN_DENIED then
                pkErrors.pop;
                raise LOGIN_DENIED;

            when pkConstante.exERROR_LEVEL2 then
                -- Error Oracle nivel dos
                pkErrors.pop;
                raise pkConstante.exERROR_LEVEL2;

            when OTHERS then
                pkErrors.NotifyError
                (
                    pkErrors.fsbLastObject,
                    sqlerrm,
                    IC_BOCompletServiceInt.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt.sbErrMsg
                );
        END SetProcessDate;

        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       :   ClearMemory
            Descripción     :   Limpia la información en memoria

            Autor       :   Alejandro Rendón Gómez
            Fecha       :   26-07-2012 16:19:07

            Historia de Modificaciones
            Fecha       IDEntrega

            17-07-2013  hlopez.SAO212472
            Se adiciona el atributo Clasificacion Contable del Contrato

            05-04-2013  arendon.SAO205719
            Se adiciona el reinicio para el atributo MOVIITEM.

            09-10-2012  hlopez.SAO193548
            Se adiciona el campo MOVIBACO

            26-07-2012  arendon.SAO185253
            Creación.
        */
        PROCEDURE ClearMemory
        IS
        BEGIN
            pkErrors.Push('IC_BOCompletServiceInt.Process.ClearMemory');

            -- Reinicia la tabla antes de obtener los datos
            tbProducts.delete;

            -- Se limpia la entidad temporal de cargos
            pkTmpChargesMgr.TrunTmpCharge;

            -- Se incializa los documentos contables
            nuBillDocNumber := null;
            nuCertfDocNumber := null;
            nuNoteDocNumber := null;

            -- Se inicializa la tabla de movimientos
            tbMov.movitido.delete;
        tbMov.movinudo.delete;
        tbMov.movitimo.delete;
        tbMov.movifeco.delete;
        tbMov.movisign.delete;
        tbMov.movivalo.delete;
        tbMov.movicicl.delete;
        tbMov.movidepa.delete;
        tbMov.moviloca.delete;
        tbMov.moviserv.delete;
        tbMov.moviempr.delete;
        tbMov.movicate.delete;
        tbMov.movisuca.delete;
        tbMov.moviconc.delete;
        tbMov.movicaca.delete;
        tbMov.movibanc.delete;
        tbMov.movisuba.delete;
        tbMov.movitdsr.delete;
        tbMov.movititb.delete;
        tbMov.movibatr.delete;
        tbMov.movicuba.delete;
        tbMov.movinutr.delete;
        tbMov.movifetr.delete;
        tbMov.movisusc.delete;
        tbMov.moviceco.delete;
        tbMov.moviterc.delete;
        tbMov.moviusua.delete;
        tbMov.moviterm.delete;
        tbMov.movifopa.delete;
        tbMov.movicldp.delete;
        tbMov.movitoim.delete;
        tbMov.moviimp1.delete;
        tbMov.moviimp2.delete;
        tbMov.moviimp3.delete;
        tbMov.movisipr.delete;
        tbMov.movisire.delete;
        tbMov.movidiad.delete;
        tbMov.movicomu.delete;
        tbMov.movitidi.delete;
        tbMov.movifeap.delete;
        tbMov.movifeve.delete;
        tbMov.movivatr.delete;
        tbMov.movivtir.delete;
        tbMov.movivir1.delete;
        tbMov.movivir2.delete;
        tbMov.movivir3.delete;
        tbMov.movinips.delete;
        tbMov.movitica.delete;
        tbMov.moviubg1.delete;
        tbMov.moviubg2.delete;
        tbMov.moviubg3.delete;
        tbMov.moviubg4.delete;
        tbMov.moviubg5.delete;
        tbMov.moviancb.delete;
        tbMov.movimecb.delete;
        tbMov.movisivr.delete;
        tbMov.movisifa.delete;
        tbMov.movisici.delete;
        tbMov.movinaca.delete;
        tbMov.moviplca.delete;
        tbMov.moviproy.delete;
        tbMov.moviclit.delete;
        tbMov.moviunid.delete;
        tbMov.moviinpr.delete;
        tbMov.movivaor.delete;
        tbMov.movipeco.delete;
        tbMov.movitihe.delete;
        tbMov.movidipr.delete;
        tbMov.moviunor.delete;
        tbMov.movicons.delete;
        tbMov.movivaba.delete;
        tbMov.movicupo.delete;
        tbMov.movinica.delete;
        tbMov.movinibr.delete;
        tbMov.movinibt.delete;
        tbMov.movitibr.delete;
        tbMov.movitiuo.delete;
        tbMov.movititr.delete;
        tbMov.movicale.delete;
        tbMov.movinufa.delete;
        tbMov.movibaco.delete;
        tbMov.moviitem.delete;
        tbMov.moviclcc.delete;

            pkErrors.Pop;
        EXCEPTION
            when LOGIN_DENIED then
                pkErrors.pop;
                raise LOGIN_DENIED;

            when pkConstante.exERROR_LEVEL2 then
                -- Error Oracle nivel dos
                pkErrors.pop;
                raise pkConstante.exERROR_LEVEL2;

            when OTHERS then
                pkErrors.NotifyError
                (
                    pkErrors.fsbLastObject,
                    sqlerrm,
                    IC_BOCompletServiceInt.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt.sbErrMsg
                );
        END ClearMemory;

        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       :   InsertSetOfRecords
            Descripción     :   Crea los registros en la entidad IC_MOVIMIEN

            Autor       :   Alejandro Rendón Gómez
            Fecha       :   24-07-2012 17:24:41

            Historia de Modificaciones
            Fecha       IDEntrega

            24-07-2012  arendon.SAO185253
            Creación.
        */
        PROCEDURE InsertSetOfRecords
        IS
        BEGIN

            pkErrors.Push('IC_BOCompletServiceInt.Process.InsertSetOfRecords');

            if (tbMov.movicons.first is null) then
                pkErrors.pop;
                return;
            end if;

            pktblIc_movimien.InsRecords( tbMov );

            pkErrors.pop;

        EXCEPTION
            when LOGIN_DENIED then
                pkErrors.pop;
                raise LOGIN_DENIED;

            when pkConstante.exERROR_LEVEL2 then
                -- Error Oracle nivel dos
                pkErrors.pop;
                raise pkConstante.exERROR_LEVEL2;

            when OTHERS then
                pkErrors.NotifyError
                (
                    pkErrors.fsbLastObject,
                    sqlerrm,
                    IC_BOCompletServiceInt.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt.sbErrMsg
                );
        END InsertSetOfRecords;

        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       : FillTable
            Descripcion     : Arma el registro de movimientos en la tabla PL

            Parametros      :        Descripcion
                ircMovimien             Record con la información del
                                        movimiento a generar

            Autor    :  Alejandro Rendón Gómez
            Fecha    :  24-07-2012 16:53:04

            Historia de Modificaciones
            Fecha       IDEntrega

            17-07-2013  hlopez.SAO212472
            Se adiciona el atributo Clasificacion Contable del Contrato

            05-04-2013  arendon.SAO205719
            Se adiciona la asignación del atributo MOVIITEM.

            09-10-2012  hlopez.SAO193548
            Se adiciona el campo MOVIBACO

            24-07-2012  arendon.SAO185253
            Creación.
        */
        PROCEDURE FillTable
        (
            ircMovimien in ic_movimien%rowtype
        )
        IS
            -------------------
            -- Variables
            -------------------
            -- Indice para el llenado de la tabla de movimientos
            sbInd       varchar2(2000);

        BEGIN
            pkErrors.Push('IC_BOCompletServiceInt.Process.FillTable');

            -- Solamente procesa cuando se tiene valor diferente a cero.
            if (ircMovimien.movivalo <> pkBillConst.CERO OR
                ircMovimien.movivatr <> pkBillConst.CERO ) then

                -- Inicializa el siguiente indice a usar.
                sbInd := nvl(tbMov.movicons.last, 0) + 1;

                tbMov.movicons(sbInd) := pkGeneralServices.fnuGetNextSequenceVal('SQ_IC_MOVIMIEN_175553');
                tbMov.moviusua(sbInd) := IC_BOCompletServiceInt.sbUserName;
                tbMov.moviterm(sbInd) := IC_BOCompletServiceInt.sbTerminal;

                tbMov.movidiad(sbInd) := -1;
                tbMov.movicomu(sbInd) := -1;

                -- Aplica politica de redondeo
                tbMov.movivalo(sbInd) := pkBOAccountingInterface.fnuRound
                                            ( ircMovimien.movivalo );
                tbMov.movivaba(sbInd) := pkBOAccountingInterface.fnuRound
                                            ( ircMovimien.movivaba );
                tbMov.movivatr(sbInd) := pkBOAccountingInterface.fnuRound
                                            ( ircMovimien.movivatr );

                -- Valores de impuesto en 0
                tbMov.movitoim(sbInd) := 0;
                tbMov.movivtir(sbInd) := 0;

                tbMov.movitido(sbInd) := ircMovimien.movitido;
            tbMov.movinudo(sbInd) := ircMovimien.movinudo;
            tbMov.movitimo(sbInd) := ircMovimien.movitimo;
            tbMov.movifeco(sbInd) := ircMovimien.movifeco;
            tbMov.movitihe(sbInd) := ircMovimien.movitihe;
            tbMov.movisign(sbInd) := ircMovimien.movisign;
            tbMov.movicicl(sbInd) := ircMovimien.movicicl;
            tbMov.movidepa(sbInd) := ircMovimien.movidepa;
            tbMov.moviloca(sbInd) := ircMovimien.moviloca;
            tbMov.moviserv(sbInd) := ircMovimien.moviserv;
            tbMov.moviempr(sbInd) := ircMovimien.moviempr;
            tbMov.movicate(sbInd) := ircMovimien.movicate;
            tbMov.movisuca(sbInd) := ircMovimien.movisuca;
            tbMov.moviconc(sbInd) := ircMovimien.moviconc;
            tbMov.movicaca(sbInd) := ircMovimien.movicaca;
            tbMov.movibanc(sbInd) := ircMovimien.movibanc;
            tbMov.movisuba(sbInd) := ircMovimien.movisuba;
            tbMov.movitdsr(sbInd) := ircMovimien.movitdsr;
            tbMov.movititb(sbInd) := ircMovimien.movititb;
            tbMov.movibatr(sbInd) := ircMovimien.movibatr;
            tbMov.movicuba(sbInd) := ircMovimien.movicuba;
            tbMov.movinutr(sbInd) := ircMovimien.movinutr;
            tbMov.movifetr(sbInd) := ircMovimien.movifetr;
            tbMov.movisusc(sbInd) := ircMovimien.movisusc;
            tbMov.moviceco(sbInd) := ircMovimien.moviceco;
            tbMov.moviterc(sbInd) := ircMovimien.moviterc;
            tbMov.movifopa(sbInd) := ircMovimien.movifopa;
            tbMov.movicldp(sbInd) := ircMovimien.movicldp;
            tbMov.moviimp1(sbInd) := ircMovimien.moviimp1;
            tbMov.moviimp2(sbInd) := ircMovimien.moviimp2;
            tbMov.moviimp3(sbInd) := ircMovimien.moviimp3;
            tbMov.movisipr(sbInd) := ircMovimien.movisipr;
            tbMov.movisire(sbInd) := ircMovimien.movisire;
            tbMov.movitidi(sbInd) := ircMovimien.movitidi;
            tbMov.movifeap(sbInd) := ircMovimien.movifeap;
            tbMov.movifeve(sbInd) := ircMovimien.movifeve;
            tbMov.movivir1(sbInd) := ircMovimien.movivir1;
            tbMov.movivir2(sbInd) := ircMovimien.movivir2;
            tbMov.movivir3(sbInd) := ircMovimien.movivir3;
            tbMov.movinips(sbInd) := ircMovimien.movinips;
            tbMov.movitica(sbInd) := ircMovimien.movitica;
            tbMov.moviubg1(sbInd) := ircMovimien.moviubg1;
            tbMov.moviubg2(sbInd) := ircMovimien.moviubg2;
            tbMov.moviubg3(sbInd) := ircMovimien.moviubg3;
            tbMov.moviubg4(sbInd) := ircMovimien.moviubg4;
            tbMov.moviubg5(sbInd) := ircMovimien.moviubg5;
            tbMov.moviancb(sbInd) := ircMovimien.moviancb;
            tbMov.movimecb(sbInd) := ircMovimien.movimecb;
            tbMov.movisivr(sbInd) := ircMovimien.movisivr;
            tbMov.movisifa(sbInd) := ircMovimien.movisifa;
            tbMov.movisici(sbInd) := ircMovimien.movisici;
            tbMov.movinaca(sbInd) := ircMovimien.movinaca;
            tbMov.moviplca(sbInd) := ircMovimien.moviplca;
            tbMov.moviproy(sbInd) := ircMovimien.moviproy;
            tbMov.moviclit(sbInd) := ircMovimien.moviclit;
            tbMov.moviunid(sbInd) := ircMovimien.moviunid;
            tbMov.moviinpr(sbInd) := ircMovimien.moviinpr;
            tbMov.movivaor(sbInd) := ircMovimien.movivaor;
            tbMov.movipeco(sbInd) := ircMovimien.movipeco;
               tbMov.movidipr(sbInd) := ircMovimien.movidipr;
            tbMov.moviunor(sbInd) := ircMovimien.moviunor;
            tbMov.movicupo(sbInd) := ircMovimien.movicupo;
            tbMov.movinica(sbInd) := ircMovimien.movinica;
            tbMov.movinibr(sbInd) := ircMovimien.movinibr;
            tbMov.movinibt(sbInd) := ircMovimien.movinibt;
            tbMov.movitibr(sbInd) := ircMovimien.movitibr;
            tbMov.movitiuo(sbInd) := ircMovimien.movitiuo;
            tbMov.movititr(sbInd) := ircMovimien.movititr;
            tbMov.movicale(sbInd) := ircMovimien.movicale;
            tbMov.movinufa(sbInd) := ircMovimien.movinufa;
                tbMov.movibaco(sbInd) := ircMovimien.movibaco;
                tbMov.moviitem(sbInd) := ircMovimien.moviitem;
                tbMov.moviclcc(sbInd) := ircMovimien.moviclcc;

            end if;

            pkErrors.Pop;

        EXCEPTION
            when LOGIN_DENIED then
                pkErrors.pop;
                raise LOGIN_DENIED;

            when pkConstante.exERROR_LEVEL2 then
                -- Error Oracle nivel dos
                pkErrors.pop;
                raise pkConstante.exERROR_LEVEL2;

            when OTHERS then
                pkErrors.NotifyError
                (
                    pkErrors.fsbLastObject,
                    sqlerrm,
                    IC_BOCompletServiceInt.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt.sbErrMsg
                );
        END FillTable;

        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       :   SelectInstallOrders
            Descripción     :   Selección de las ordenes cuyo tipo de trabajo
                                corresponde a INSTALACIÿN DEL SERVICIO

            Parámetros
            Entrada         :       Descripción
                idtDate                 Fecha de legalización de la órden
                inuThread               Hilo actual
                inuThreads              Total de hilos

            Salida          :       Descripción
                otbOrdersPack               Tabla con las órdenes seleccionadas

            Autor       :   Alejandro Rendón Gómez
            Fecha       :   19-07-2012 15:50:57

            Historia de Modificaciones
            Fecha       IDEntrega

            24-04-2014  aesguerra.3487
            Se modifica sentencia para que ignore las ventas a constructoras, y para que todas las
      órdenes de una solicitud sean tomadas por el mismo hilo. Esto con el fin de evitar que
      se procede dos veces una solicitud.

            19-07-2012  arendon.SAO185253
            Creación.
        */
        PROCEDURE SelectInstallOrders
        (
            idtDate     in  date,
            inuThread   in  number,
            inuThreads  in  number,
            otbProducts   out tytbHicaesco
        )
        IS
            -------------------
            -- Variables
            -------------------
            -- Sentencia de selección de órdenes
            sbSentence  varchar2(2000);

            -- Ýndice para recorrer la tabla con los tipos de trabajo
            nuIdxTT     number;

            -- CURSOR de selección de órdenes
            rfOrders    constants.tyRefCursor;

            -- Fechas temporales
            sbTmpDate1  varchar2(100);
            sbTmpDate2  varchar2(100);

            -------------------
            -- Constantes
            -------------------
            -- Estado de orden CERRADO
            cnuSTATUS_CLOSED constant number := or_boconstants.cnuORDER_STAT_CLOSED;

        BEGIN
            pkErrors.Push('IC_BOCompletServiceInt.Process.SelectInstallOrders');

            -- Fecha 1
            sbTmpDate1 := trunc(idtDate);

            -- Fecha 2
            sbTmpDate2 := trunc(idtDate+1);

            -- Arma la sentencia dinámicamente, seleccionando la primera solicitud
            -- que se encuentre.
            sbSentence :=  'SELECT  hcecnuse '
              ||'  FROM hicaesco '
              ||'  WHERE hcececan = 96 '
              ||'  AND hcececac   = 1 '
              ||'  AND hcecserv   = 7014 '
              ||'  AND hcecfech  >= :date1 '
              ||' AND hcecfech  <  :date2 '
              ||'  AND mod(hcecnuse, :nuThreads) + 1 = :nuThread';

            -- Abre el cursor, obtiene los datos y lo cierra
            open rfOrders for sbSentence using sbTmpDate1, sbTmpDate2,inuThreads,inuThread;
              fetch rfOrders bulk collect INTO otbProducts;
            close rfOrders;

            pkErrors.Pop;
        EXCEPTION
            when LOGIN_DENIED then
                pkErrors.pop;
                raise LOGIN_DENIED;

            when pkConstante.exERROR_LEVEL2 then
                -- Error Oracle nivel dos
                pkErrors.pop;
                raise pkConstante.exERROR_LEVEL2;

            when OTHERS then
                pkErrors.NotifyError
                (
                    pkErrors.fsbLastObject,
                    sqlerrm,
                    IC_BOCompletServiceInt.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt.sbErrMsg
                );
        END SelectInstallOrders;

        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       :   GetDocNumbers
            Descripción     :   Obtiene los documentos contables del día

            Parámetros
            Entrada         :       Descripción
                idtDate                 Fecha

            Salida          :       Descripción
                onuBillDoc              Documento de facturación
                onuCertfDoc             Documento de actas

            Autor       :   Alejandro Rendón Gómez
            Fecha       :   23-07-2012 16:53:13

            Historia de Modificaciones
            Fecha       IDEntrega

            18-03-2014  arendon.SAO235707
            Se adiciona la obtención de documento para Notas

            23-07-2012  arendon.SAO185253
            Creación.
        */
        PROCEDURE GetDocNumbers
        (
            dtDate      in  date,
            onuBillDoc  out ic_docugene.dogenudo%type,
            onuCertfDoc out ic_docugene.dogenudo%type,
            onuNoteDoc  out ic_docugene.dogenudo%type
        )
        IS
        BEGIN
            pkErrors.Push('IC_BOCompletServiceInt.Process.GetDocNumbers');

            /* Obtener Número Documento de Facturación */
            onuBillDoc:= pkBCIc_Docugene.fnuGetNumeDocByTido
                            (
                                cnuDOC_TYPE_BILL,
                                dtDate
                            );

            /* Obtener Número Documento de Actas */
            /*onuCertfDoc:= pkBCIc_Docugene.fnuGetNumeDocByTido
                            (
                                cnuDOC_TYPE_CERTF,
                                dtDate
                            );*/

            /* Obtener Número Documento de Notas */
            onuNoteDoc:= pkBCIc_Docugene.fnuGetNumeDocByTido
                            (
                                cnuDOC_TYPE_NOTES,
                                dtDate
                            );

            pkErrors.Pop;
        EXCEPTION
            when LOGIN_DENIED then
                pkErrors.pop;
                raise LOGIN_DENIED;

            when pkConstante.exERROR_LEVEL2 then
                -- Error Oracle nivel dos
                pkErrors.pop;
                raise pkConstante.exERROR_LEVEL2;

            when OTHERS then
                pkErrors.NotifyError
                (
                    pkErrors.fsbLastObject,
                    sqlerrm,
                    IC_BOCompletServiceInt.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt.sbErrMsg
                );
        END GetDocNumbers;

        /*
            Propiedad intelectual de Open International Systems. (c).

            Procedimiento :   GetAdditionalData
            Descripción    :   Obtiene información adicional.

            Autor      :   Alejandro Rendón Gómez
            Fecha      :   24-07-2012 16:14:41

            Historia de Modificaciones
            Fecha      IDEntrega

            24-07-2012  arendon.SAO185253
            Creación.
        */
        PROCEDURE GetAdditionalData
        (
            inuService    in    servempr.seemserv%type,
            onuBussUnit   out   servempr.seemempr%type
        )
        IS
            rcServempr servempr%rowtype;
        BEGIN

            pkErrors.Push
            (
                'IC_BOCompletServiceInt.Process.GetAdditionalData'
            );

            -- Obtiene empresa asociada al servicio suscrito
            rcServempr := pktblServempr.frcGetRecord (inuService);
            onuBussUnit := rcServempr.seemempr;

            pkErrors.Pop;

        EXCEPTION
            when OTHERS then
                pkErrors.Pop;
                onuBussUnit := NULL;
        END GetAdditionalData;

        /*
            Propiedad intelectual de Open International Systems. (c).

            Procedure  :   fsbSignMov
            Descripcion  :   Obtiene el signo para un valor

            Parametros  :  Descripcion
                inuValor        Valor del cargo

            Retorno     :
                C -> Crédito
                D -> Débito

            Autor     :    Alejandro Rendón Gómez
            Fecha     :    27-07-2012 17:29:23

            Historia de Modificaciones
            Fecha  ID Entrega
            Modificación

            27-07-2012  arendon.SAO185253
            Creación
        */
        FUNCTION fsbSignMov
        (
            inuValor in number
        )
        RETURN varchar2
        IS
            -- Signo
            sbSignCont  ic_movimien.movisign%type;
        BEGIN

            -- Se validan créditos
            if ( inuValor < 0 ) then
               sbSignCont := 'C';
            else
               sbSignCont := 'D';
            end if;

            return sbSignCont;

        END fsbSignMov;

        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       : GetDistributionData
            Descripcion     : Verifica si el concepto recibido se debe distribuir en
                              uno o dos movimientos, dependiendo si corresponde a
                              impuesto o no.

            Parametros      :        Descripcion
                inucargconc             Concepto a evaluar
                inuCargpeco             Periodo de consumo

            Retorno         :
                odtPecsfein             Fecha inicial del periodo de consumo
                odtPecsfefi             Fecha final del periodo de consumo
                oblDistrCargos          TRUE: Si el concepto aplica para la distribución
                                        FALSE: Si el concepto no aplica para la distribución

            Autor    :  Alejandro Rendón Gómez
            Fecha    :  24-07-2012 17:00:10

            Historia de Modificaciones
            Fecha       IDEntrega

            24-07-2012  arendon.SAO185253
            Creación.
        */
        PROCEDURE GetDistributionData
        (
            inucargconc     in  tmp_cargproc.cargconc%type,
            inuCargpeco     in  cargos.cargpeco%type,
            odtPecsfein     out date,
            odtPecsfefi     out date,
            oblDistrCargos  out boolean
        )
        IS
            -- Registro de periodo de consumo
            rcPericose  pericose%rowtype;

        BEGIN
            pkErrors.Push('IC_BOCompletServiceInt.Process.GetDistributionData');

            -- Inicializa las variables
            oblDistrCargos := FALSE;

            -- Si no tiene periodo de consumo, el cargo no se distribuye
            if ( inuCargpeco IS null ) then
                pkErrors.Pop;
                return;
            end if;

            -- Si no se han cargado los conceptos a memoria, se obtienen
            if ( not IC_BOCompletServiceInt.boConceptLoaded ) then
                -- Carga de conceptos
                LoadConcepts;
            end if;


             -- Si el concepto existe en la tabla en memoria, se distribuye
            if ( IC_BOCompletServiceInt.tbConcepto.exists( inuCargconc ) ) then

                -- Retorna verdadero en el flag de distribución del cargo
                oblDistrCargos := TRUE;
                -- Retorna  el periodo de consumo del concepto
                rcPericose := pktblPericose.frcGetRecord(inuCargpeco);

                -- Evalua el tipo de cobro para usar la vigencia correspondiente
                if (IC_BOCompletServiceInt.tbConcepto( inuCargconc ).concticc = pkConstante.csbABONO) then
                    odtPecsfein := rcPericose.pecsfeai;
                    odtPecsfefi := rcPericose.pecsfeaf;
                else
                    odtPecsfein := rcPericose.pecsfeci;
                    odtPecsfefi := rcPericose.pecsfecf;
                end if;
            else
                oblDistrCargos := FALSE;
            END if;

            pkErrors.Pop;

        EXCEPTION
            when LOGIN_DENIED then
                pkErrors.pop;
                raise LOGIN_DENIED;

            when pkConstante.exERROR_LEVEL2 then
                -- Error Oracle nivel dos
                pkErrors.pop;
                raise pkConstante.exERROR_LEVEL2;

            when OTHERS then
                pkErrors.NotifyError
                (
                    pkErrors.fsbLastObject,
                    sqlerrm,
                    IC_BOCompletServiceInt.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt.sbErrMsg
                );
        END GetDistributionData;

        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       : CalculateDistrValue
            Descripcion     : Proporciona el valor del cargo en los dos meses
                              del periodo de consumo.

            Parametros      :        Descripcion
                idtPecsfein             Fecha inicial Periodo de consumo
                idtPecsfefi             Fecha final Periodo de consumo
                inuVlrTotal             Valor del cargo a distribuir
                onuVlrMes1              Valor proporcional correpondiente al mes 1
                onuVlrMes2              Valor proporcional correpondiente al mes 2

            Retorno         :

            Autor    :  Alejandro Rendón Gómez
            Fecha    :  24-07-2012 17:09:05

            Historia de Modificaciones
            Fecha       IDEntrega

            24-07-2012  arendon.SAO185253
            Creación.
        */
        PROCEDURE CalculateDistrValue
        (
            idtPecsfein in  date,
            idtPecsfefi in  date,
            inuVlrTotal in  cargos.cargvalo%type,
            onuVlrMes1  out number,
            onuVlrMes2  out number
        )
        IS
            dtUltimoDiaMes   date;
            nuTotalDias     number;
            nuDiasMes1      number;
        BEGIN
            pkErrors.Push('IC_BOCompletServiceInt.Process.CalculateDistrValue');

            -- Ultimo dia del mes de la fecha inicial
            dtUltimoDiaMes := last_day(trunc(idtPecsfein));

            -- Numero de dia del periodo de consumo
            nuTotalDias := trunc(idtPecsfefi) - trunc(idtPecsfein) + 1;

            -- Dias del periodo en mes 1
            nuDiasMes1 := dtUltimoDiaMes - trunc(idtPecsfein) + 1;

            -- Se evalúa si el producto fué instalado despúes de inicio período pero ANTES de fin de mes 1
            if
            (
                trunc( rcSesunuse.sesufein ) > trunc( idtPecsfein )
                AND
                trunc( rcSesunuse.sesufein ) <= trunc( dtUltimoDiaMes )
            )
            then

                -- Se ajusta número días período consumo
                nuTotalDias := nuTotalDias - ( trunc( rcSesunuse.sesufein ) - trunc( idtPecsfein ) );

                -- Se ajusta número días mes 1
                nuDiasMes1 := trunc( dtUltimoDiaMes ) - trunc( rcSesunuse.sesufein ) + 1;

            -- Se evalúa si el producto fué instalado DESPUES de inicio período pero DESPUES de mes 1
            elsif
            (
                trunc( rcSesunuse.sesufein ) > trunc( idtPecsfein )
                AND
                trunc( rcSesunuse.sesufein ) > trunc( dtUltimoDiaMes )
            )
            then

                -- Se ajusta número días mes 1
                nuDiasMes1 := 0;

            end if;

            -- Se evalúa si el producto fué retirado ANTES de fin de mes 1
            if( trunc( rcSesunuse.sesufere ) <= trunc( dtUltimoDiaMes ) ) then

                -- Se ajusta número días período consumo
                nuTotalDias := nuTotalDias - ( trunc( idtPecsfefi ) - trunc( rcSesunuse.sesufere ) );

                -- Se ajusta número días mes 1
                nuDiasMes1 := nuTotalDias;

            -- Se evalúa si el producto fué retirado DESPUES de mes 1 pero ANTES de fin de período
            elsif
            (
                trunc( rcSesunuse.sesufere ) > trunc( dtUltimoDiaMes )
                AND
                trunc( rcSesunuse.sesufere ) < trunc( idtPecsfefi )
            )
            then

                -- Se ajusta número días período consumo
                nuTotalDias := nuTotalDias - ( trunc( idtPecsfefi ) - trunc( rcSesunuse.sesufere ) );

            end if;

            -- Valor proporcional para el mes 1
            onuVlrMes1 := inuVlrTotal * nuDiasMes1 / nuTotalDias;

            -- Aplica politica de redondeo
            onuVlrMes1 := pkBOAccountingInterface.fnuRound( onuVlrMes1 );

            -- El valor restante se asigna el mes 2
            onuVlrMes2 := inuVlrTotal - onuVlrMes1;

            -- Aplica politica de redondeo
            onuVlrMes2 := pkBOAccountingInterface.fnuRound( onuVlrMes2 );

            pkErrors.Pop;
        EXCEPTION
            when LOGIN_DENIED then
                pkErrors.pop;
                raise LOGIN_DENIED;

            when pkConstante.exERROR_LEVEL2 then
                -- Error Oracle nivel dos
                pkErrors.pop;
                raise pkConstante.exERROR_LEVEL2;

            when OTHERS then
                pkErrors.NotifyError
                (
                    pkErrors.fsbLastObject,
                    sqlerrm,
                    IC_BOCompletServiceInt.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt.sbErrMsg
                );
        END CalculateDistrValue;

        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       :   GetNitByConcept
            Descripción     :   Obtiene el Nit del tercero por concepto

            Parámetros
            Entrada         :       Descripción
                inuService              Tipo de producto
                inuConcept              Concepto

            Salida          :       Descripción
                osbNit                  Nit del tercero

            Autor       :   Alejandro Rendón Gómez
            Fecha       :   27-07-2012 15:09:42

            Historia de Modificaciones
            Fecha       IDEntrega

            27-07-2012  arendon.SAO185253
            Creación.
        */
        PROCEDURE GetNitbyConcept
        (
            inuService    in    servempr.seemserv%type,
            inuConcept    in    concepto.conccodi%type,
            osbNit       out    ic_movimien.movinips%type
        )
        IS
            -- Registro de servicio pktblservicio
            rcServicio      servicio%rowtype;
        BEGIN
            pkErrors.Push('IC_BOCompletServiceInt.Process.GetNitbyConcept');

            osbNit := NULL;

            if (pktblServicio.fblExist(inuService)) then

                -- Obtiene registro de tipo de producto
                rcServicio := pktblServicio.frcGetRecord(inuService);

                -- Si el concepto y el servicio es de un tercero se obtiene nit del tercero
                if pktblConcterc.fblExist(rcServicio.servteco,inuConcept) then

                    if(pktblTerccobr.fblExist(rcServicio.servteco))then
                        -- Nit del tercero
                        osbNit := pktblTerccobr.frcGetRecord(rcServicio.servteco).teconit;
                    END if;

                else  -- Obtiene nit de la empersa del usuario que ejecuta el poceso.

                    -- Nit de la empreas
                    osbNit := pktblSistema.frcGetRecord(Sa_bosystem.fnuGetUserCompanyId).sistnitc;

                END if;

            END if;

            pkErrors.Pop;
        EXCEPTION
            when others then
                osbNit := NULL;
        END GetNitbyConcept;


        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       :   ChargesDistribution
            Descripcion     :   Evalua los cargos cuyo concepto no sea de impuesto
                                para distribuir su valor en los meses que abarcan el
                                periodo de consumo y crear uno o dos movimientos con
                                el mes y año correspondiente

            Parametros      :       Descripcion
                idtDate                 Fecha de contabilización
                inuDocNumber            Número del documento contable
                inuCycle                Ciclo de facturación
                inuBussUnit             Unidad de negocio
                inuServ                 Tipo de producto
                inuCateg                Categoría
                inuSubcat               Subcategoría
                inuConcept              Concepto
                inuCausCarg             Causa del cargo
                isbExpCenter            Centro de costos
                isbNit                  Identificación del cliente
                inuValue                Valor
                inuBaseValue            Valor base de impuesto
                inuUnits                Unidades
                inuCucosist             Empresa prestadora del servicio
                inuSuscsist             Empresa propietaria factura
                isbTipoDir              Tipo de dirección
                inuUbiGeogr1            Ubicación geográfica 1
                inuUbiGeogr2            Ubicación geográfica 2
                inuCargpeco             Periodo de consumo
                idtmovifeve             Fecha de vencimiento
                inumovivatr             Valor total producto retirado
                inuServsusc             Producto
                inuTipodoco             Tipo de documento

            Autor    :  Alejandro Rendón Gómez
            Fecha    :  24-07-2012 16:47:22

            Historia de Modificaciones
            Fecha       IDEntrega

            04-06-2014  aesguerra.3762
            Se corrige para calcular bien la localidad

            18-03-2014  arendon.SAO235707
            Se adiciona el reporte de los movimientos de notas.

            12-10-2012  arendon.SAO193932
            Se corrigen el Tipo de Documento y el Tipo de Movimiento.

            10-10-2012  arendon.SAO193603
            Se modifica para inicializar los atributos "Signo" y "Signo del valor
            retirado". Se calculo el valor como valor absoluto.

            24-07-2012  arendon.SAO185253
            Creación.
        */
        PROCEDURE ChargesDistribution
        (
            idtDate         in  date,
            inuDocNumbBill  in  ic_docugene.dogenudo%type,
            inuDocNumbNotes in  ic_docugene.dogenudo%type,
            inuCycle        in  tmp_cargproc.cargcicl%type,
            inuBussUnit     in  tmp_cargproc.cargserv%type,
            inuServ         in  tmp_cargproc.cargserv%type,
            inuCateg        in  tmp_cargproc.cargcate%type,
            inuSubcat       in  tmp_cargproc.cargsuca%type,
            inuConcept      in  tmp_cargproc.cargconc%type,
            inuCausCarg     in  tmp_cargproc.cargcaca%type,
            isbExpCenter    in  tmp_cargproc.cargusua%type,
            isbNit          in  tmp_cargproc.cargterm%type,
            inuValue        in  number,
            inuBaseValue    in  number,
            inuUnits        in  number,
            inuCucosist     in  cuencobr.cucosist%type,
            inuSuscsist     in  suscripc.suscsist%type,
            isbTipoDir      in  varchar2,
            inuUbiGeogr1    in  ic_movimien.moviubg1%type,
            inuUbiGeogr2    in  ic_movimien.moviubg2%type,
            inuCargpeco     in  cargos.cargpeco%type,
            idtmovifeve     in  ic_movimien.movifeve%type,
            inumovivatr     in  ic_movimien.movivatr%type,
            inuServsusc     in  servsusc.sesunuse%type,
            inuTipodoco     in  ic_tipodoco.tidccodi%type,
            ivaMoviTiHe     IN  ic_movimien.movitihe%TYPE DEFAULT NULL
        )

        IS
            -------------------------------------------
            -- Variables:
            -------------------------------------------

            -- Fecha inicial periodo de consumo
            dtPecsfein      date;
            -- Fecha final periodo de consumo
            dtPecsfefi      date;

            -- Flag que indica si hay que distribuir el cargo
            blDistrCargos   boolean;

            -- Valor correspondiente al mes 1
            nuValue1        number;
            nuBaseValue1    number;
            numovivatr1     number;
            -- Valor correspondiente al mes 2
            nuValue2        number;
            nuBaseValue2    number;
            numovivatr2     number;

            -- Registro de movimientos
            rcMovimiento    ic_movimien%rowtype;

            -- Centro de costos
            sbExpCenter     ic_movimien.moviceco%type;

            -- Identificación del cliente
            sbNit           ic_movimien.moviterc%type;

            -- Nit de tercero
            sbNitTerc       ic_movimien.movinips%type;

            --<<
            -- Dcardona
            -- 12-12-2014
            -- Tipo de Hecho Economico
            -->>
            vaMoviTiHe      ic_movimien.movitihe%TYPE;

        BEGIN

            pkErrors.Push('IC_BOCompletServiceInt.Process.ChargesDistribution');

            --<<
            -- Dcardona
            -- 12-12-2014
            -- Se verifica el tipo de Hecho económico
            -->>
            IF (ivaMoviTiHe IS NOT NULL) THEN

               vaMoviTiHe := ivaMoviTiHe;

            --<<
            -- De lo contrario
            -->>
            ELSE

               --<<
               -- El tipo de Hecho es Servicio Cumplido
               -->>
               vaMoviTiHe := csbTIHE_COMPL_SERV;

            END IF;

            if (isbExpCenter = '-') then
                sbExpCenter := NULL;
            end if;

            if (isbNit = '-') then
                sbNit := NULL;
            end if;

            GetNitbyConcept
            (
                inuServ,
                inuConcept,
                sbNitTerc
            );

            -- Se inicializa el record para el manejo de la información del movimiento
            rcMovimiento.movifeco := trunc( idtDate );
            rcMovimiento.movitihe := vaMoviTiHe;
            rcMovimiento.moviinpr := pkConstante.NO;

            rcMovimiento.movicicl := inuCycle;
            rcMovimiento.moviempr := inuBussUnit;
            rcMovimiento.moviserv := inuServ;
            rcMovimiento.movicate := inuCateg;
            rcMovimiento.movisuca := inuSubcat;
            rcMovimiento.moviconc := inuConcept;
            rcMovimiento.movicaca := inuCausCarg;
            rcMovimiento.moviceco := sbExpCenter;
            rcMovimiento.moviterc := sbNit;
            rcMovimiento.movisipr := inuCucosist;
            rcMovimiento.movisifa := inuSuscsist;
            rcMovimiento.movisici := pktblCiclo.fnuGetCiclsist( inuCycle, pkConstante.CACHE );
            rcMovimiento.movitidi := isbTipoDir;
            rcMovimiento.movifeve := idtMovifeve;
            rcMovimiento.movinips := sbNitTerc;
            rcMovimiento.moviancb := null;
            rcMovimiento.movimecb := null;
            rcMovimiento.movivalo := abs( inuValue );
            rcMovimiento.movivaba := abs( inuBaseValue );
            rcMovimiento.movivatr := abs( inuMovivatr );
            rcMovimiento.movisign := fsbSignMov( inuValue );
            rcMovimiento.movisivr := fsbSignMov( inuMovivatr );


            /* Nivel Geográfico 1 */
            if  IC_BOCompletServiceInt.sbLOCBAR1 = pkConstante.SI then
                rcMovimiento.moviubg1 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                            (
                                                inuUbiGeogr1,
                                                IC_BOCompletServiceInt.nuNivelUbge1
                                            );
            else
                rcMovimiento.moviubg1 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                            (
                                                inuUbiGeogr2,
                                                IC_BOCompletServiceInt.nuNivelUbge1
                                            );
            end if;

            /* Nivel Geográfico 2 */
            if  IC_BOCompletServiceInt.sbLOCBAR2 = pkConstante.SI then
                rcMovimiento.moviubg2 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                            (
                                                inuUbiGeogr1,
                                                IC_BOCompletServiceInt.nuNivelUbge2
                                            );
            else
                rcMovimiento.moviubg2 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                            (
                                                inuUbiGeogr2,
                                                IC_BOCompletServiceInt.nuNivelUbge2
                                            );
            end if;

            /* Nivel Geográfico 3 */
            if  IC_BOCompletServiceInt.sbLOCBAR3 = pkConstante.SI then
                rcMovimiento.moviubg3 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                            (
                                                inuUbiGeogr1,
                                                IC_BOCompletServiceInt.nuNivelUbge3
                                            );
            else
                rcMovimiento.moviubg3 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                            (
                                                inuUbiGeogr2,
                                                IC_BOCompletServiceInt.nuNivelUbge3
                                            );
            end if;

            /* Nivel Geográfico 4 */
            if  IC_BOCompletServiceInt.sbLOCBAR4 = pkConstante.SI then
                rcMovimiento.moviubg4 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                            (
                                                inuUbiGeogr1,
                                                IC_BOCompletServiceInt.nuNivelUbge4
                                            );
            else
                rcMovimiento.moviubg4 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                            (
                                                inuUbiGeogr2,
                                                IC_BOCompletServiceInt.nuNivelUbge4
                                            );
            end if;

            /* Nivel Geográfico 5 */
            if  IC_BOCompletServiceInt.sbLOCBAR5 = pkConstante.SI then
                rcMovimiento.moviubg5 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                            (
                                                inuUbiGeogr1,
                                                IC_BOCompletServiceInt.nuNivelUbge5
                                            );
            else
                rcMovimiento.moviubg5 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                            (
                                                inuUbiGeogr2,
                                                IC_BOCompletServiceInt.nuNivelUbge5
                                            );
            end if;

            /* Si el movimiento es de facturación */
            if ( inuTipodoco = cnuDOC_TYPE_BILL ) then

                /* Asigna datos del movimiento */
                rcMovimiento.movinudo := inuDocNumbBill;
                rcMovimiento.movitido := cnuDOC_TYPE_BILL;
                rcMovimiento.movitimo := cnuMOVE_TYPE_BILL;

                /* Obtiene los datos para la distribución */
                GetDistributionData(
                                    inuConcept,
                                    inuCargpeco,
                                    dtPecsfein,
                                    dtPecsfefi,
                                    blDistrCargos
                                   );


                if (blDistrCargos) then

                    /* Verifica si el producto que se está procesando ya cambió */
                    if
                    (
                        rcSesunuse.sesunuse IS null
                        OR
                        (
                            rcSesunuse.sesunuse IS not null
                            AND
                            rcSesunuse.sesunuse <> inuServsusc
                        )
                    ) then
                        /* Si ya cambió:
                           1. Asigna el nuevo registro del product */
                        rcSesunuse :=  pktblServsusc.frcGetRecord
                                        (
                                            inuServsusc
                                        );
                    end if;

                    /* Se asigna periodo de consumo a los movimientos */
                    rcMovimiento.movipeco := inuCargpeco;

                    /* Evalua los cargos y crea uno o dos movimientos dependiendo si
                       periodo de consumo ocupa uno o dos meses. */
                    if( to_number( to_char( dtPecsfein, 'YYYYMM' ) ) =
                        to_number( to_char( dtPecsfefi, 'YYYYMM' ) )) then
                        /* Llena registro de movimientos */
                        rcMovimiento.moviancb := to_number( to_char( dtPecsfein, 'YYYY' ) );
                        rcMovimiento.movimecb := to_number( to_char( dtPecsfein, 'MM' ) );

                        FillTable(rcMovimiento);

                    else
                        if (to_number( to_char( add_months(dtPecsfein, 1), 'YYYYMM' ) ) =
                            to_number( to_char( dtPecsfefi, 'YYYYMM' ) )) then

                            /* Calcula el valor proporcional del cargo para cada mes */
                            CalculateDistrValue
                            (
                                dtPecsfein,
                                dtPecsfefi,
                                inuValue,
                                nuValue1,
                                nuValue2
                            );

                            /* Calcula el valor base proporcional del cargo para cada mes */
                            CalculateDistrValue
                            (
                                dtPecsfein,
                                dtPecsfefi,
                                inuBaseValue,
                                nuBaseValue1,
                                nuBaseValue2
                            );

                            /* Si el valor retirado es igual al valor del cargo */
                            if( inuMovivatr = inuValue ) then
                                /* Si son iguales asigna los valores ya distribuidos */
                                nuMovivatr1 := nuValue1;
                                nuMovivatr2 := nuValue2;
                            else
                               if( inuMovivatr is not null ) then
                                    nuMovivatr1 := 0;
                                    nuMovivatr2 := 0;
                               end if;
                            end if;

                            /* Movimiento con el valor proporcional al primer mes */
                            rcMovimiento.movivalo := abs( nuValue1 );
                            rcMovimiento.movivaba := abs( nuBaseValue1 );
                            rcMovimiento.movivatr := abs( nuMovivatr1 );
                            rcMovimiento.movisign := fsbSignMov( nuValue1 );
                            rcMovimiento.movisivr := fsbSignMov( nuMovivatr1 );
                            rcMovimiento.moviancb := to_number( to_char( dtPecsfein, 'YYYY' ) );
                            rcMovimiento.movimecb := to_number( to_char( dtPecsfein, 'MM' ) );

                            FillTable(rcMovimiento);

                            /* Movimiento con el valor proporcional al segundo mes */
                            rcMovimiento.movivalo := abs( nuValue2 );
                            rcMovimiento.movivaba := abs( nuBaseValue2 );
                            rcMovimiento.movivatr := abs( nuMovivatr2 );
                            rcMovimiento.movisign := fsbSignMov( nuValue2 );
                            rcMovimiento.movisivr := fsbSignMov( nuMovivatr2 );
                            rcMovimiento.moviancb := to_number( to_char( dtPecsfefi, 'YYYY' ) );
                            rcMovimiento.movimecb := to_number( to_char( dtPecsfefi, 'MM' ) );

                            FillTable(rcMovimiento);

                        END if;
                    END if;

                else
                    /* Llena un solo registro de movimientos ya que el concepto del cargo
                       no aplica para distribuirlo en los meses de cobertura del periodo */
                    FillTable(rcMovimiento);

                end if;
            else
                /* Asigna datos del movimiento */
                rcMovimiento.movinudo := inuDocNumbNotes;
                rcMovimiento.movitido := cnuDOC_TYPE_NOTES;
                rcMovimiento.movitimo := cnuMOVE_TYPE_NOTES;

                /* Llena un solo registro de movimientos ya que los movimientos
                   de notas no se distribuyen */
                FillTable(rcMovimiento);

            end if;

            pkErrors.Pop;

        EXCEPTION
            when LOGIN_DENIED then
                pkErrors.pop;
                raise LOGIN_DENIED;

            when pkConstante.exERROR_LEVEL2 then
                -- Error Oracle nivel dos
                pkErrors.pop;
                raise pkConstante.exERROR_LEVEL2;

            when OTHERS then
                pkErrors.NotifyError
                (
                    pkErrors.fsbLastObject,
                    sqlerrm,
                    IC_BOCompletServiceInt.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt.sbErrMsg
                );
        END ChargesDistribution;

        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       :   ProcessOrderWithCertf
            Descripción     :   Procesa las órdenes incluidas en un acta

            Parámetros
            Entrada         :       Descripción
                inuOrderId              Código de la orden
                ircCertificate          Registro del acta
                inuDocNumber            Documento contable
                idtDate                 Fecha de contabilización

            Autor       :   Alejandro Rendón Gómez
            Fecha       :   27-07-2012 10:44:23

            Historia de Modificaciones
            Fecha       IDEntrega

            17-07-2013  hlopez.SAO212472
            Se adiciona el atributo Clasificacion Contable del Contrato

            05-04-2013  arendon.SAO205719
            Se adiciona la asignación del atributo MOVIITEM.

            10-10-2012  arendon.SAO193603
            Se procesa correctamente los atributos de ubicación geográfica

            27-07-2012  arendon.SAO185253
            Creación.
        */
        PROCEDURE ProcessOrderWithCertf
        (
            inuOrderId      in  OR_order.order_id%type,
            ircCertificate  in  ge_acta%rowtype,
            inuDocNumber    in  ic_docugene.dogenudo%type,
            idtDate         in  date
        )
        IS
            -------------------
            -- Variables
            -------------------
            -- Tabla con los movimientos de actas
            tbCertfMovs     IC_BCCompletServiceInt.tytbCertfMovs;

            -- Indice para recorrer la tabla de movimientos
            nuIdxCert       number;

            -- Registro de ic_movimien
            rcMovimien      ic_movimien%rowtype;

            -- Clasificaciones Contable del Contrato
            nuAccount_Classif_Id    ge_contrato.account_classif_id%type;

        BEGIN
            pkErrors.Push('IC_BOCompletServiceInt.Process.ProcessOrderWithCertf');

            -- Se obtienen los movimientos a generar del modelo actas de
            -- liquidación
            IC_BCCompletServiceInt.GetCertfMovs
            (
                inuOrderId,
                ircCertificate.id_acta,
                tbCertfMovs
            );

            -- Itera por cada registros encontrado para crear los movimientos
            -- respectivos.
            nuIdxCert := tbCertfMovs.first;

            loop
                -- Condición de salida
                exit when nuIdxCert IS null;

                rcMovimien.movifeco := trunc( idtDate );
                rcMovimien.movinudo := inuDocNumber;
                rcMovimien.movitido := cnuDOC_TYPE_CERTF;
                rcMovimien.movitimo := cnuMOVE_TYPE_CERTF;
                rcMovimien.movitihe := csbTIHE_COMPL_SERV;
                rcMovimien.moviproy := tbCertfMovs( nuIdxCert ).project_id;
                rcMovimien.movititr := tbCertfMovs( nuIdxCert ).task_type_id;
                rcMovimien.movitiuo := tbCertfMovs( nuIdxCert ).es_externa;
                rcMovimien.movinips := tbCertfMovs( nuIdxCert ).nit;
                rcMovimien.movicale := tbCertfMovs( nuIdxCert ).causal_id;
                rcMovimien.movinufa := ircCertificate.extern_invoice_num;
                rcMovimien.moviclit := tbCertfMovs( nuIdxCert ).item_classif_id;
                rcMovimien.movivalo := tbCertfMovs( nuIdxCert ).valor;
                rcMovimien.movisign := fsbSignMov( rcMovimien.movivalo );
                rcMovimien.moviitem := tbCertfMovs( nuIdxCert ).item;

                -- Calcula el Clasificador Contable del Contrato
                if( dage_contrato.fblExist( ircCertificate.id_contrato ) ) then

                    nuAccount_Classif_Id := dage_contrato.fnuGetAccount_Classif_Id(
                                                ircCertificate.id_contrato
                                            );
                else
                    nuAccount_Classif_Id := null;
                end if;

                rcMovimien.moviclcc := nuAccount_Classif_Id;

                -- Ubicaciones geográficas
                if ( tbCertfMovs( nuIdxCert ).geograp_location_id IS not null ) then

                    -- Nivel Geográfico 1
                    if  IC_BOCompletServiceInt.sbLOCBAR1 = pkConstante.SI then
                        rcMovimien.moviubg1 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).geograp_location_id,
                                                        IC_BOCompletServiceInt.nuNivelUbge1
                                                    );
                    else
                        rcMovimien.moviubg1 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).neighborthood_id,
                                                        IC_BOCompletServiceInt.nuNivelUbge1
                                                    );
                    end if;

                    -- Nivel Geográfico 2
                    if  IC_BOCompletServiceInt.sbLOCBAR2 = pkConstante.SI then
                        rcMovimien.moviubg2 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).geograp_location_id,
                                                        IC_BOCompletServiceInt.nuNivelUbge2
                                                    );
                    else
                        rcMovimien.moviubg2 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).neighborthood_id,
                                                        IC_BOCompletServiceInt.nuNivelUbge2
                                                    );
                    end if;

                    -- Nivel Geográfico 3
                    if  IC_BOCompletServiceInt.sbLOCBAR3 = pkConstante.SI then
                        rcMovimien.moviubg3 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).geograp_location_id,
                                                        IC_BOCompletServiceInt.nuNivelUbge3
                                                    );
                    else
                        rcMovimien.moviubg3 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).neighborthood_id,
                                                        IC_BOCompletServiceInt.nuNivelUbge3
                                                    );
                    end if;

                    -- Nivel Geográfico 4
                    if  IC_BOCompletServiceInt.sbLOCBAR4 = pkConstante.SI then
                        rcMovimien.moviubg4 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).geograp_location_id,
                                                        IC_BOCompletServiceInt.nuNivelUbge4
                                                    );
                    else
                        rcMovimien.moviubg4 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).neighborthood_id,
                                                        IC_BOCompletServiceInt.nuNivelUbge4
                                                    );
                    end if;

                    -- Nivel Geográfico 5
                    if  IC_BOCompletServiceInt.sbLOCBAR5 = pkConstante.SI then
                        rcMovimien.moviubg5 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).geograp_location_id,
                                                        IC_BOCompletServiceInt.nuNivelUbge5
                                                    );
                    else
                        rcMovimien.moviubg5 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).neighborthood_id,
                                                        IC_BOCompletServiceInt.nuNivelUbge5
                                                    );
                    end if;

                end if;

                -- Crea el movimiento
                FillTable( rcMovimien );

                -- Actualiza el índice con la siguiente posición de la tabla
                nuIdxCert := tbCertfMovs.next( nuIdxCert );

            end loop;

            pkErrors.Pop;
        EXCEPTION
            when LOGIN_DENIED then
                pkErrors.pop;
                raise LOGIN_DENIED;

            when pkConstante.exERROR_LEVEL2 then
                -- Error Oracle nivel dos
                pkErrors.pop;
                raise pkConstante.exERROR_LEVEL2;

            when OTHERS then
                pkErrors.NotifyError
                (
                    pkErrors.fsbLastObject,
                    sqlerrm,
                    IC_BOCompletServiceInt.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt.sbErrMsg
                );
        END ProcessOrderWithCertf;


        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       :   ProcessItemsWithoutCertf
            Descripción     :   Procesa los items que no salen en las actas

            Parámetros
            Entrada         :       Descripción
                inuOrderId              Código de la orden
                ircCertificate          Registro del acta
                inuDocNumber            Documento contable
                idtDate                 Fecha de contabilización

            Autor       :   Hery J Lopez R
            Fecha       :   17-07-2013 18:00:00

            Historia de Modificaciones
            Fecha       IDEntrega

            23-07-2013  hlopez.SAO212970
            Se modifica la forma de obtener el atributo Clasificacion COntable
            del Contrato

            17-07-2013  hlopez.SAO212472
            Creación.
        */
        PROCEDURE ProcessItemsWithoutCertf
        (
            inuOrderId      in  OR_order.order_id%type,
            ircCertificate  in  ge_acta%rowtype,
            inuDocNumber    in  ic_docugene.dogenudo%type,
            idtDate         in  date
        )
        IS
            -------------------
            -- Variables
            -------------------
            -- Tabla con los movimientos de actas
            tbCertfMovs     IC_BCCompletServiceInt.tytbCertfMovs;

            -- Indice para recorrer la tabla de movimientos
            nuIdxCert       number;

            -- Registro de ic_movimien
            rcMovimien      ic_movimien%rowtype;

            -- Clasificaciones Contable del Contrato
            nuAccount_Classif_Id    ge_contrato.account_classif_id%type;

        BEGIN
            pkErrors.Push('IC_BOCompletServiceInt.Process.ProcessItemsWithoutCertf');

            -- Se obtienen los movimientos a generar del modelo actas de
            -- liquidación
            IC_BCCompletServiceInt.GetItemsWithoutCertf
            (
                inuOrderId,
                ircCertificate.id_acta,
                tbCertfMovs
            );

            -- Itera por cada registros encontrado para crear los movimientos
            -- respectivos.
            nuIdxCert := tbCertfMovs.first;


            loop
                -- Condición de salida
                exit when nuIdxCert IS null;

                rcMovimien.movifeco := trunc( idtDate );
                rcMovimien.movinudo := inuDocNumber;
                rcMovimien.movitido := cnuDOC_TYPE_CERTF;
                rcMovimien.movitimo := cnuMOVE_TYPE_CERTF;
                rcMovimien.movitihe := csbTIHE_COMPL_SERV;

                rcMovimien.moviproy := tbCertfMovs( nuIdxCert ).project_id;
                rcMovimien.movititr := tbCertfMovs( nuIdxCert ).task_type_id;
                rcMovimien.movitiuo := tbCertfMovs( nuIdxCert ).es_externa;
                rcMovimien.movinips := tbCertfMovs( nuIdxCert ).nit;
                rcMovimien.movicale := tbCertfMovs( nuIdxCert ).causal_id;
                rcMovimien.movinufa := ircCertificate.extern_invoice_num;
                rcMovimien.moviclit := tbCertfMovs( nuIdxCert ).item_classif_id;
                rcMovimien.movivalo := tbCertfMovs( nuIdxCert ).valor;
                rcMovimien.movisign := fsbSignMov( rcMovimien.movivalo );
                rcMovimien.moviitem := tbCertfMovs( nuIdxCert ).item;

                -- Calcula el Clasificador Contable del Contrato
                if( dage_contrato.fblExist( ircCertificate.id_contrato ) ) then

                    nuAccount_Classif_Id := dage_contrato.fnuGetAccount_Classif_Id(
                                                ircCertificate.id_contrato
                                            );
                else
                    nuAccount_Classif_Id := null;
                end if;

                rcMovimien.moviclcc := nuAccount_Classif_Id;

                -- Ubicaciones geográficas
                if ( tbCertfMovs( nuIdxCert ).geograp_location_id IS not null ) then

                    -- Nivel Geográfico 1
                    if  IC_BOCompletServiceInt.sbLOCBAR1 = pkConstante.SI then
                        rcMovimien.moviubg1 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).geograp_location_id,
                                                        IC_BOCompletServiceInt.nuNivelUbge1
                                                    );
                    else
                        rcMovimien.moviubg1 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).neighborthood_id,
                                                        IC_BOCompletServiceInt.nuNivelUbge1
                                                    );
                    end if;

                    -- Nivel Geográfico 2
                    if  IC_BOCompletServiceInt.sbLOCBAR2 = pkConstante.SI then
                        rcMovimien.moviubg2 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).geograp_location_id,
                                                        IC_BOCompletServiceInt.nuNivelUbge2
                                                    );
                    else
                        rcMovimien.moviubg2 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).neighborthood_id,
                                                        IC_BOCompletServiceInt.nuNivelUbge2
                                                    );
                    end if;

                    -- Nivel Geográfico 3
                    if  IC_BOCompletServiceInt.sbLOCBAR3 = pkConstante.SI then
                        rcMovimien.moviubg3 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).geograp_location_id,
                                                        IC_BOCompletServiceInt.nuNivelUbge3
                                                    );
                    else
                        rcMovimien.moviubg3 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).neighborthood_id,
                                                        IC_BOCompletServiceInt.nuNivelUbge3
                                                    );
                    end if;

                    -- Nivel Geográfico 4
                    if  IC_BOCompletServiceInt.sbLOCBAR4 = pkConstante.SI then
                        rcMovimien.moviubg4 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).geograp_location_id,
                                                        IC_BOCompletServiceInt.nuNivelUbge4
                                                    );
                    else
                        rcMovimien.moviubg4 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).neighborthood_id,
                                                        IC_BOCompletServiceInt.nuNivelUbge4
                                                    );
                    end if;

                    -- Nivel Geográfico 5
                    if  IC_BOCompletServiceInt.sbLOCBAR5 = pkConstante.SI then
                        rcMovimien.moviubg5 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).geograp_location_id,
                                                        IC_BOCompletServiceInt.nuNivelUbge5
                                                    );
                    else
                        rcMovimien.moviubg5 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).neighborthood_id,
                                                        IC_BOCompletServiceInt.nuNivelUbge5
                                                    );
                    end if;

                end if;

                -- Crea el movimiento
                FillTable( rcMovimien );

                -- Actualiza el índice con la siguiente posición de la tabla
                nuIdxCert := tbCertfMovs.next( nuIdxCert );

            end loop;

            pkErrors.Pop;
        EXCEPTION
            when LOGIN_DENIED then
                pkErrors.pop;
                raise LOGIN_DENIED;

            when pkConstante.exERROR_LEVEL2 then
                -- Error Oracle nivel dos
                pkErrors.pop;
                raise pkConstante.exERROR_LEVEL2;

            when OTHERS then
                pkErrors.NotifyError
                (
                    pkErrors.fsbLastObject,
                    sqlerrm,
                    IC_BOCompletServiceInt.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt.sbErrMsg
                );
        END ProcessItemsWithoutCertf;

         /*
            Propiedad intelectual de Open Systems (c).
            Procedure       :   ProcessOrderWithoutCertf
            Descripción     :   Procesa las órdenes no incluidas en un acta

            Parámetros
            Entrada         :       Descripción
                inuOrderId              Código de la orden
                inuDocNumber            Documento contable
                idtDate                 Fecha de contabilización

            Autor       :   Alejandro Rendón Gómez
            Fecha       :   27-07-2012 10:44:23

            Historia de Modificaciones
            Fecha       IDEntrega

            17-07-2013  hlopez.SAO212472
            Se adiciona el atributo Clasificacion Contable del Contrato

            10-10-2012  arendon.SAO193603
            Se procesa correctamente los atributos de ubicación geográfica

            27-07-2012  arendon.SAO185253
            Creación.
        */
        PROCEDURE ProcessOrderWithoutCertf
        (
            inuOrderId      in  OR_order.order_id%type,
            inuDocNumber    in  ic_docugene.dogenudo%type,
            idtDate         in  date
        )
        IS
            -------------------
            -- Variables
            -------------------
            -- Tabla con los movimientos de órdenes
            tbOrdersMovs     IC_BCCompletServiceInt.tytbCertfMovs;

            -- Indice para recorrer la tabla de movimientos
            nuIdxOrder       number;

            -- Registro de ic_movimien
            rcMovimien      ic_movimien%rowtype;
        BEGIN
            pkErrors.Push('IC_BOCompletServiceInt.Process.ProcessOrderWithoutCertf');

            -- Se obtienen los movimientos a generar del modelo actas de
            -- liquidación
            IC_BCCompletServiceInt.GetOrdersMovs
            (
                inuOrderId,
                tbOrdersMovs
            );

            -- Itera por cada registros encontrado para crear los movimientos
            -- respectivos.
            nuIdxOrder := tbOrdersMovs.first;

            loop
                -- Condición de salida
                exit when nuIdxOrder IS null;

                rcMovimien.movifeco := trunc( idtDate );
                rcMovimien.movinudo := inuDocNumber;
                rcMovimien.movitido := cnuDOC_TYPE_CERTF;
                rcMovimien.movitimo := cnuMOVE_TYPE_CERTF;
                rcMovimien.movitihe := csbTIHE_COMPL_SERV;

                rcMovimien.moviproy := tbOrdersMovs( nuIdxOrder ).project_id;
                rcMovimien.movititr := tbOrdersMovs( nuIdxOrder ).task_type_id;
                rcMovimien.movitiuo := tbOrdersMovs( nuIdxOrder ).es_externa;
                rcMovimien.movinips := tbOrdersMovs( nuIdxOrder ).nit;

                rcMovimien.movicale := tbOrdersMovs( nuIdxOrder ).causal_id;
                rcMovimien.moviclit := tbOrdersMovs( nuIdxOrder ).item_classif_id;
                rcMovimien.moviclcc := tbOrdersMovs( nuIdxOrder ).account_classif_id;
                rcMovimien.movivalo := tbOrdersMovs( nuIdxOrder ).valor;

                rcMovimien.movisign := fsbSignMov( rcMovimien.movivalo );

                -- Ubicaciones geográficas
                if ( tbOrdersMovs( nuIdxOrder ).geograp_location_id IS not null ) then

                    -- Nivel Geográfico 1
                    if  IC_BOCompletServiceInt.sbLOCBAR1 = pkConstante.SI then
                        rcMovimien.moviubg1 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbOrdersMovs( nuIdxOrder ).geograp_location_id,
                                                        IC_BOCompletServiceInt.nuNivelUbge1
                                                    );
                    else
                        rcMovimien.moviubg1 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbOrdersMovs( nuIdxOrder ).neighborthood_id,
                                                        IC_BOCompletServiceInt.nuNivelUbge1
                                                    );
                    end if;

                    -- Nivel Geográfico 2
                    if  IC_BOCompletServiceInt.sbLOCBAR2 = pkConstante.SI then
                        rcMovimien.moviubg2 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbOrdersMovs( nuIdxOrder ).geograp_location_id,
                                                        IC_BOCompletServiceInt.nuNivelUbge2
                                                    );
                    else
                        rcMovimien.moviubg2 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbOrdersMovs( nuIdxOrder ).neighborthood_id,
                                                        IC_BOCompletServiceInt.nuNivelUbge2
                                                    );
                    end if;

                    -- Nivel Geográfico 3
                    if  IC_BOCompletServiceInt.sbLOCBAR3 = pkConstante.SI then
                        rcMovimien.moviubg3 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbOrdersMovs( nuIdxOrder ).geograp_location_id,
                                                        IC_BOCompletServiceInt.nuNivelUbge3
                                                    );
                    else
                        rcMovimien.moviubg3 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbOrdersMovs( nuIdxOrder ).neighborthood_id,
                                                        IC_BOCompletServiceInt.nuNivelUbge3
                                                    );
                    end if;

                    -- Nivel Geográfico 4
                    if  IC_BOCompletServiceInt.sbLOCBAR4 = pkConstante.SI then
                        rcMovimien.moviubg4 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbOrdersMovs( nuIdxOrder ).geograp_location_id,
                                                        IC_BOCompletServiceInt.nuNivelUbge4
                                                    );
                    else
                        rcMovimien.moviubg4 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbOrdersMovs( nuIdxOrder ).neighborthood_id,
                                                        IC_BOCompletServiceInt.nuNivelUbge4
                                                    );
                    end if;

                    -- Nivel Geográfico 5
                    if  IC_BOCompletServiceInt.sbLOCBAR5 = pkConstante.SI then
                        rcMovimien.moviubg5 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbOrdersMovs( nuIdxOrder ).geograp_location_id,
                                                        IC_BOCompletServiceInt.nuNivelUbge5
                                                    );
                    else
                        rcMovimien.moviubg5 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbOrdersMovs( nuIdxOrder ).neighborthood_id,
                                                        IC_BOCompletServiceInt.nuNivelUbge5
                                                    );
                    end if;

                end if;

                -- Crea el movimiento
                FillTable( rcMovimien );

                -- Actualiza el índice con la siguiente posición de la tabla
                nuIdxOrder := tbOrdersMovs.next( nuIdxOrder );

            end loop;


            pkErrors.Pop;
        EXCEPTION
            when LOGIN_DENIED then
                pkErrors.pop;
                raise LOGIN_DENIED;

            when pkConstante.exERROR_LEVEL2 then
                -- Error Oracle nivel dos
                pkErrors.pop;
                raise pkConstante.exERROR_LEVEL2;

            when OTHERS then
                pkErrors.NotifyError
                (
                    pkErrors.fsbLastObject,
                    sqlerrm,
                    IC_BOCompletServiceInt.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt.sbErrMsg
                );
        END ProcessOrderWithoutCertf;

        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       :   ProcessOrders
            Descripción     :   Procesa los movimientos de órdenes asociadas
                                a la órden de instalación

            Parámetros
            Entrada         :       Descripción
                inuOrderId              Código de la orden de instalación actual
                inuPackageId            Código de la solicitud de instalación
                inuDocNumber            Número del documento contable
                idtDate                 Fecha de contabilización

            Autor       :   Alejandro Rendón Gómez
            Fecha       :   19-07-2012 11:00:43

            Historia de Modificaciones
            Fecha       IDEntrega

            17-07-2013  hlopez.SAO212472
            Se adiciona el llamado al metodo <ProcessItemsWithoutCertf>

            10-10-2012  arendon.SAO193603
            Se corrige inicialización del índice para recorrer la tabla de
            órdenes.
            Se corrige el llamado a <ProcessOrderWithCertf> y
            <ProcessOrderWithoutCertf> para enviar el código de la orden actual
            y no la orden inicial (orden de instalación)

            19-07-2012  arendon.SAO185253
            Creación.
        */
        PROCEDURE ProcessOrders
        (
            inuOrderId      in  or_order_activity.order_id%type,
            inuPackageId    in  or_order_activity.package_id%type,
            inuDocNumber    in  ic_docugene.dogenudo%type,
            idtDate         in  date
        )
        IS
            -------------------
            -- Variables
            -------------------
            -- ÿrdenes
            tbOrdersPack    daor_order.tytbOR_order;

            -- Ýndice para recorrer la tabla
            nuIdxOrders     number;

            -- CURSOR con las órdenes seleccionadas
            rfOrders        constants.tyRefCursor;

            -- Registro de Ge_acta
            rcCertificate   ge_acta%rowtype;

        BEGIN
            pkErrors.Push('IC_BOCompletServiceInt.Process.ProcessOrders');

            -- Reinicia la tabla de órdenes
            tbOrdersPack.delete;

            -- Obtiene todas las órdenes asociadas a la solicitud
            rfOrders := OR_BCOrderActivities.frfGetOrdersByPackage( inuPackageId );

            fetch   rfOrders
            bulk    collect
            into    tbOrdersPack;

            nuIdxOrders := tbOrdersPack.first;

            loop
                -- Condición de salida
                exit when nuIdxOrders IS null;

                -- Se deben procesar las órdenes diferentes a la orden de
                -- instalación, es decir la orden actual
                if( inuOrderId <> tbOrdersPack( nuIdxOrders ).order_id ) then

                    -- Obtiene la información del acta de liquidación si existe
                    rcCertificate := IC_BCCompletServiceInt.frcCertificateByOrder
                                        (
                                            tbOrdersPack( nuIdxOrders ).order_id,
                                            CT_BOConstants.fnugetLiquidationCertiType
                                        );

                    if ( rcCertificate.id_acta is not null ) then

                        -- Procesa los movimientos partiendo del acta
                        ProcessOrderWithCertf
                        (
                            tbOrdersPack( nuIdxOrders ).order_id,
                            rcCertificate,
                            inuDocNumber,
                            idtDate
                        );

                        -- Procesa los items que no salen en las actas
                        ProcessItemsWithoutCertf
                        (
                            tbOrdersPack( nuIdxOrders ).order_id,
                            rcCertificate,
                            inuDocNumber,
                            idtDate
                        );
                    else
                        -- Procesa los movimientos partiendo de la orden
                        ProcessOrderWithoutCertf
                        (
                            tbOrdersPack( nuIdxOrders ).order_id,
                            inuDocNumber,
                            idtDate
                        );
                    end if;

                end if;

                -- Actualiza el índice con la siguiente posición de la tabla
                nuIdxOrders := tbOrdersPack.next( nuIdxOrders );

            end loop;

            pkErrors.Pop;
        EXCEPTION
            when LOGIN_DENIED then
                pkErrors.pop;
                raise LOGIN_DENIED;

            when pkConstante.exERROR_LEVEL2 then
                -- Error Oracle nivel dos
                pkErrors.pop;
                raise pkConstante.exERROR_LEVEL2;

            when OTHERS then
                pkErrors.NotifyError
                (
                    pkErrors.fsbLastObject,
                    sqlerrm,
                    IC_BOCompletServiceInt.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt.sbErrMsg
                );
        END ProcessOrders;

        /**********************************************************************
          Propiedad intelectual de OPEN International Systems
          Nombre              fblProcessTaxes

          Autor        Andrés Felipe Esguerra Restrepo

          Fecha               19-may-2014

          Descripción         Procesa el IVA para un producto creado en una venta constructora

          ***Parametros***
          Nombre        Descripción
          inuOrderId1         ID de una de las órdenes de cargo por conexión o red interna
          inuOrderId2         ID de una de las órdenes de cargo por conexión o red interna
          inuCucocodi         Cuenta de cobro a procesar
          orcTax              Registro de Cargos con información del IVA correspondiente

          ***Historia de Modificaciones***
          Fecha Modificación        Autor
          20-05-2014                      aesguerra.3605
        ***********************************************************************/
        FUNCTION fblProcessTaxes(
      inuOrderId1 in  OR_order.order_id%type,
            inuOrderId2 in  OR_order.order_id%type,
            inuCucocodi in  cuencobr.cucocodi%type,
            orcTax      out cargos%rowtype
    ) RETURN boolean IS

          tbCharges    IC_BCCompletServiceInt.tytbCharges;

          tbTaxes      IC_BCCompletServiceInt.tytbCharges;

          rcTax      cargos%rowtype;

          nuIdxTaxes      number;

          --cnuConConc    constant concepto.conccodi%type := 30;
          cnuTaxConc    constant concepto.conccodi%type := 287;

          nuAdd           number := 0;

          blPassed        boolean := FALSE;

        BEGIN

    pkErrors.Push('IC_BOCompletServiceInt.Process.fblProcessTaxes');

    /*Se carga en memoria todos los cargos por conexión de la cuenta de cobro*/
    tbCharges := IC_BCCompletServiceInt.ftbGetChargesByBillBase(cnuTaxConc,inuCucocodi);

    /*Se carga en memoria todos los cargos de IVA de la cuenta de cobro*/
    tbTaxes := IC_BCCompletServiceInt.ftbGetChargesByBilltax(cnuTaxConc,inuCucocodi);

    /*Si ambas tablas tienen datos se procede*/
    if tbCharges.count > 0 AND tbTaxes.count > 0 then

        /*Se inicializa índice para IVA*/
        nuIdxTaxes := tbTaxes.first;

        /*Para cada cargo por conexión*/
      FOR nuIdxCharges IN tbCharges.first..tbCharges.last LOOP

        /*Si no se ha procesado el cargo del producto actual y el cargo por conexión iterado
        corresponde a dicho producto, se marca el flag de que ya se encontró*/
        if (not blPassed AND tbCharges(nuIdxCharges).cargcodo in (inuOrderId1,inuOrderId2)) then

            blPassed := TRUE;

        END if;

        /*Se acumula el valor del cargo por conexión*/
        nuAdd := nuAdd + tbCharges(nuIdxCharges).cargvalo;

        /*Si el acumulado corresponde al valor base del IVA iterado*/
        if nuAdd = tbTaxes(nuIdxTaxes).cargvabl then

          /*Si ya se iteró el cargo por conexión del producto actual, se obtiene el valor
          de IVA que le corresponde*/
            if blPassed then

                rcTax := tbTaxes(nuIdxTaxes);

                /*Si el cargo por conexión iterado es solo una porción del IVA iterado, se obtiene la proporción
            que le corresponde*/
                if tbCharges(nuIdxCharges).cargvalo != rcTax.cargvabl then

                    /*El valor base a reportar es igual al valor del cargo por conexión*/
                rcTax.cargvabl := tbCharges(nuIdxCharges).cargvalo;

                /*El valor del IVA a reportar es proporcional a la relación
              entre el valor de cargo por conexión y el valor base inicial*/
                rcTax.cargvalo := tbTaxes(nuIdxTaxes).cargvalo * (rcTax.cargvabl / tbTaxes(nuIdxTaxes).cargvabl);

                fa_bopoliticaredondeo.aplicapoliticaempr(99,rcTax.cargvalo);

            END if;

            exit;

            END if;

            /*Se reinicia el acumulador de cargo por conexión*/
            nuAdd := 0;

            /*Se itera al siguiente registro de IVA*/
            nuIdxTaxes := tbTaxes.next(nuIdxTaxes);

        END if;
      END LOOP;

      if blPassed then
          orcTax := rcTax;
      END if;

    END if;

    pkErrors.Pop;

    return blPassed;

        EXCEPTION
            when LOGIN_DENIED then
                pkErrors.pop;
                raise LOGIN_DENIED;

            when pkConstante.exERROR_LEVEL2 then
                -- Error Oracle nivel dos
                pkErrors.pop;
                raise pkConstante.exERROR_LEVEL2;

            when OTHERS then
                pkErrors.NotifyError
                (
                    pkErrors.fsbLastObject,
                    sqlerrm,
                    IC_BOCompletServiceInt.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt.sbErrMsg
                );

        END fblProcessTaxes;

        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       :   ProcessBill
            Descripción     :   Procesa la información de la factura creando los
                                movimientos respectivos

            Parámetros
            Entrada         :       Descripción
                inuFactcodi             Factura
                inuFactsusc             Suscripción
                inuCiclcodi             Ciclo de facturación
                inuCiclsist             Empresa propietaria del ciclo
                inuPackageId            Solicitud de venta
                inuProductId            Producto iterado

            Autor       :   Alejandro Rendón Gómez
            Fecha       :   24-07-2012 10:03:57

            Historia de Modificaciones
            Fecha       IDEntrega

            24-05-2014  aesguerra.3605
            Se añade la lógica para soportar ventas constructoras:
        - Obtiene únicamente los cargos asociados a las órdenes de instalación de interna
            y cargo por conexión
        - Soporta varias facturas por solicitud
        - Se incluye lógica para identificar el IVA correspondiente al producto iterado
        - Se añade como parámetro la solicitud de venta y el producto

            24-07-2012  arendon.SAO185253
            Creación.
        */

        PROCEDURE ProcessBill
        (
            inuFactcodi     in  factura.factcodi%type,
            inuFactsusc     in  factura.factsusc%type,
            inuCiclcodi     in  ciclo.ciclcodi%type,
            inuPackageId   in  mo_packages.package_type_id%type,
            inuProductId    in  servsusc.sesunuse%type
        )
        IS

            -------------------
            -- Arreglos
            -------------------

            -- Cuentas de cobros
            tbCucocodi      pktblCuencobr.tyCucocodi;
            -- Centros de costo
            tbSuscceco      pktblSuscripc.tySuscceco;
            -- Identificadores de suscripción
            tbSuscnitc      DAGE_Subscriber.tytbIdentification;
            -- Categorías
            tbCucocate      pktblCuencobr.tyCucocate;
            -- Subcategorías
            tbCucosuca      pktblCuencobr.tyCucosuca;
            -- Empresas de suscripción
            tbSuscsist      pktblSuscripc.tySuscsist;
            -- Productos
            tbCuconuse      pktblCuencobr.tyCuconuse;

            -------------------
            -- Registros
            -------------------

            -- Registro del producto
            rcProducto servsusc%rowtype;

            -------------------
            -- Variables
            -------------------
            -- Producto
            nuProducto servsusc.sesunuse%type;

            nuOrderId1  OR_order.order_id%type;
            nuOrderId2  OR_order.order_id%type;

            rfOrders        constants.tyRefCursor;

            nuPackTypeId    mo_packages.package_type_id%type;

            blHasTax        boolean;
            rcTax           cargos%rowtype;

            -- Contador de movimientos
            nuMovs      number := 1;

        BEGIN
            pkErrors.Push
            (
                'IC_BOCompletServiceInt.Process.ProcessBill'
            );

            TraceInsertion('IC_BOCompletServiceInt.Process.ProcessBill['||inuFactcodi||']', inuProductId);

            tbCucocodi.delete;
            tbSuscceco.delete;
            tbSuscsist.delete;
            tbSuscnitc.delete;
            tbCucocate.delete;
            tbCucosuca.delete;
            tbCuconuse.delete;

            -- Se obtienen las cuentas de cobro
            IC_BCCompletServiceInt.GetAccounts
            (
                inuFactcodi,
                inuFactsusc,
                tbCucocodi,
                tbSuscceco,
                tbSuscsist,
                tbSuscnitc,
                tbCucocate,
                tbCucosuca,
                tbCuconuse
            );

            -- Se evalúa si se obtuvieron facturas
            if( tbCucocodi.first is null ) then
                return;
            end if;

            -- Se procesa cada cuenta de cobro
            for nuInd in tbCucocodi.first .. tbCucocodi.last loop

                -- Se recalcula la subcategoría
                tbCucosuca( nuInd ) :=  nvl
                                        (
                                            IC_BOPromoProducts.fnuGetPromSubcat
                                            (
                                                tbCucocodi( nuInd )
                                            ),
                                            tbCucosuca( nuInd )
                                        );

                -- Obtiene información del producto
                rcProducto := pktblServsusc.frcGetRecord( tbCuconuse( nuInd ) );

                -- Evalua si es un producto dependiente
                if ( rcProducto.sesusesb IS not null AND rcProducto.sesusesb <> -1 ) then
                    nuProducto := rcProducto.sesusesb;
                else
                    nuProducto := rcProducto.sesunuse;
                end if;

                nuPackTypeId := damo_packages.fnugetpackage_type_id(inuPackageId);

                TraceInsertion('IC_BOCompletServiceInt.Process.ProcessBill-Account['||tbCucocodi( nuInd )||']', inuProductId);

                if nuPackTypeId = cnuConstructorPackTypeId then

                    nuOrderId1 := null;
                    nuOrderId2 := null;

                    rfOrders := IC_BCCompletServiceInt.frfGetOrdersByProdPack(inuProductId,inuPackageId,sbInstTaskType);

                    fetch rfOrders INTO nuOrderId1;
                    fetch rfOrders INTO nuOrderId2;

                    close rfOrders;

                    IC_BCCompletServiceInt.TemprInsertConstAccCharges
                    (
                      inuCiclcodi,
                      tbCucocodi( nuInd ),
                      tbSuscceco( nuInd ),
                      tbSuscnitc( nuInd ),
                      tbCucocate( nuInd ),
                      tbCucosuca( nuInd ),
                      tbSuscsist( nuInd ),
                      cnuDOC_TYPE_BILL,
                      nuOrderId1,
                      nuOrderId2
                    );

                    blHasTax := fblProcessTaxes(nuOrderId1,nuOrderId2,tbCucocodi(nuInd),rcTax);

                    if blHasTax then

                      IC_BCCompletServiceInt.TemprInsertConstTaxCharges
                      (
                        inuCiclcodi,
                        tbCucocodi( nuInd ),
                        tbSuscceco( nuInd ),
                        tbSuscnitc( nuInd ),
                        tbCucocate( nuInd ),
                        tbCucosuca( nuInd ),
                        tbSuscsist( nuInd ),
                        cnuDOC_TYPE_BILL,
                        rcTax
                      );

                    END if;

                else
                  -- Se insertan temporalmente los cargos de la cuenta de cobro
                  IC_BCCompletServiceInt.TemprInsertAccCharges
                  (
                      inuCiclcodi,
                      tbCucocodi( nuInd ),
                      tbSuscceco( nuInd ),
                      tbSuscnitc( nuInd ),
                      tbCucocate( nuInd ),
                      tbCucosuca( nuInd ),
                      tbSuscsist( nuInd ),
                      cnuDOC_TYPE_BILL
                  );
                END if;

            end loop;

            -- Se limpia la memoria
            tbCucocodi.delete;
            tbSuscceco.delete;
            tbSuscnitc.delete;
            tbCucocate.delete;
            tbCucosuca.delete;
            tbSuscsist.delete;

            pkErrors.Pop;

        EXCEPTION
            when LOGIN_DENIED then
                pkErrors.pop;
                raise LOGIN_DENIED;

            when pkConstante.exERROR_LEVEL2 then
                -- Error Oracle nivel dos
                pkErrors.pop;
                raise pkConstante.exERROR_LEVEL2;

            when OTHERS then
                pkErrors.NotifyError
                (
                    pkErrors.fsbLastObject,
                    sqlerrm,
                    IC_BOCompletServiceInt.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt.sbErrMsg
                );
        END ProcessBill;

        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       :   ProcessNotes
            Descripción     :   Procesa la información de las notas asociadas
                                a la factura

            Parámetros
            Entrada         :       Descripción
                inuFactcodi             Factura
                inuFactsusc             Suscripción
                inuCiclcodi             Ciclo de facturación
                inuCiclsist             Empresa propietaria del ciclo

            Autor       :   Alejandro Rendón Gómez
            Fecha       :   18-03-2014 14:38:06

            Historia de Modificaciones
            Fecha       IDEntrega

            19-03-2014  aesguerra.3605
            Se modifica para que no haga nada en ventas constructoras

            18-03-2014  arendon.SAO235707
            Creación.
        */
        PROCEDURE ProcessNotes
        (
            inuFactcodi     in  factura.factcodi%type,
            inuFactsusc     in  factura.factsusc%type,
            inuCiclcodi     in  ciclo.ciclcodi%type,
            inuPackageId   in  mo_packages.package_type_id%type
        )
        IS
            -------------------
            -- Arreglos
            -------------------
            /* Notas */
            tbNotanume      pktblNotas.tyNotanume;
            /* Centros de costo */
            tbSuscceco      pktblSuscripc.tySuscceco;
            /* Identificadores de suscripción */
            tbSuscnitc      DAGE_Subscriber.tytbIdentification;
            /* Empresas de suscripción */
            tbSuscsist      pktblSuscripc.tySuscsist;

            -------------------
            -- Registros
            -------------------
            /* Registro del producto */
            rcProducto servsusc%rowtype;

            -------------------
            -- Variables
            -------------------
            /* Producto */
            nuProducto servsusc.sesunuse%type;

            /* Contador de movimientos */
            nuMovs      number := 1;

            nuPackTypeId    mo_packages.package_type_id%type;

        BEGIN

            pkErrors.Push
            (
                'IC_BOCompletServiceInt.Process.ProcessNotes'
            );

            nuPackTypeId := damo_packages.fnugetpackage_type_id(inuPackageId,0);

            if nuPackTypeId = cnuConstructorPackTypeId then
                pkErrors.Pop;
                return;
            END if;

            tbNotanume.delete;
            tbSuscceco.delete;
            tbSuscsist.delete;
            tbSuscnitc.delete;

            /* Se obtienen las Notas */
            IC_BCCompletServiceInt.GetNotes
            (
                inuFactcodi,
                inuFactsusc,
                tbNotanume,
                tbSuscceco,
                tbSuscsist,
                tbSuscnitc
            );

            -- Se evalúa si se obtuvieron facturas
            if( tbNotanume.first is null ) then
                return;
            end if;

            TraceInsertion('IC_BOCompletServiceInt.Process.ProcessNotes['||tbNotanume.count||']', inuPackageId);

            -- Se procesa cada cuenta de cobro
            for nuInd in tbNotanume.first .. tbNotanume.last loop

                -- Se insertan temporalmente los cargos de la cuenta de cobro
                IC_BCCompletServiceInt.TemprInsertNoteCharges
                (
                    inuCiclcodi,
                    tbNotanume( nuInd ),
                    tbSuscceco( nuInd ),
                    tbSuscnitc( nuInd ),
                    tbSuscsist( nuInd ),
                    cnuDOC_TYPE_NOTES
                );

                null;

            end loop;

            -- Se limpia la memoria
            tbNotanume.delete;
            tbSuscceco.delete;
            tbSuscnitc.delete;
            tbSuscsist.delete;

            pkErrors.Pop;

        EXCEPTION
            when LOGIN_DENIED then
                pkErrors.pop;
                raise LOGIN_DENIED;

            when pkConstante.exERROR_LEVEL2 then
                -- Error Oracle nivel dos
                pkErrors.pop;
                raise pkConstante.exERROR_LEVEL2;

            when OTHERS then
                pkErrors.NotifyError
                (
                    pkErrors.fsbLastObject,
                    sqlerrm,
                    IC_BOCompletServiceInt.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt.sbErrMsg
                );
        END ProcessNotes;

        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       :   ProcessCharges
            Descripción     :   Procesa los movimientos de facturación asociados
                                a la órden de instalación

            Parámetros
            Entrada         :       Descripción
                inuPackageId            Código de la solicitud de instalación

            Autor       :   Alejandro Rendón Gómez
            Fecha       :   19-07-2012 11:02:57

            Historia de Modificaciones
            Fecha       IDEntrega

            18-03-2014  arendon.SAO235707
            Se adiciona el procesamiento de las notas vinculadas a la factura.

            19-07-2012  arendon.SAO185253
            Creación.
        */
        PROCEDURE ProcessCharges
        (
            inuPackageId    in  or_order_activity.package_id%type,
            inuProductId    in  OR_order_activity.product_id%type
        )
        IS
            -------------------
            -- Colecciones
            -------------------
            -- Factura
            nuFactcodi      factura.factcodi%type;

            -- Suscripción
            nuFactsusc      factura.factsusc%type;

            -- Ciclo de facturación
            nuCiclcodi      ciclo.ciclcodi%type;

            tbBills         IC_BCCompletServiceInt.tytbBills;

        BEGIN
            pkErrors.Push('IC_BOCompletServiceInt.Process.ProcessCharges');

            TraceInsertion('IC_BOCompletServiceInt.Process.ProcessCharges['||inuPackageId||']', inuProductId);

            -- Se obtienen las facturas
            IC_BCCompletServiceInt.GetBillByPackage
            (
                inuPackageId,
                tbBills
            );

            -- Se evalúa si se obtuvo factura
            if not (tbBills.count > 0) then
                return;
            end if;

            FOR n IN tbBills.first..tbBills.last LOOP

              /* Procesa los cargos de facturación */
              ProcessBill
              (
                  tbBills(n).factcodi,
                  tbBills(n).factsusc,
                  tbBills(n).ciclcodi,
          inuPackageId,
          inuProductId
              );

              /* Procesa los cargos de Notas */
              ProcessNotes
              (
                  tbBills(n).factcodi,
                  tbBills(n).factsusc,
                  tbBills(n).ciclcodi,
                  inuPackageId
              );

            END LOOP;

            pkErrors.Pop;

        EXCEPTION
            when LOGIN_DENIED then
                pkErrors.pop;
                raise LOGIN_DENIED;

            when pkConstante.exERROR_LEVEL2 then
                -- Error Oracle nivel dos
                pkErrors.pop;
                raise pkConstante.exERROR_LEVEL2;

            when OTHERS then
                pkErrors.NotifyError
                (
                    pkErrors.fsbLastObject,
                    sqlerrm,
                    IC_BOCompletServiceInt.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt.sbErrMsg
                );
        END ProcessCharges;

        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       :   CreateBillMovs
            Descripción     :   Crea los hechos económicos de facturación

            Parámetros
            Entrada         :       Descripción
                idtDate                 Fecha de contabilización
                inuDocNumbBill          Número del documento Facturación
                inuDocNumbBill          Número del documento Notas

            Autor       :   Alejandro Rendón Gómez
            Fecha       :   26-07-2012 15:43:32

            Historia de Modificaciones
            Fecha       IDEntrega

            18-03-2014  arendon.SAO235707
            Se adiciona el reporte de los movimientos de notas

            26-07-2012  arendon.SAO185253
            Creación.
        */
        PROCEDURE CreateBillMovs
        (
            idtDate         in  date,
            inuDocNumbBill  in  number,
            inuDocNumbNotes in  number
        )
        IS
            -------------------
            -- Variables
            -------------------
            -- Cargos temporales
            tbrcCargos      IC_BCCompletServiceInt.tytbChargesMovs;

            -- Cargo temporal
            rcCargo         IC_BCCompletServiceInt.tyrcChargesMovs;

        BEGIN
            pkErrors.Push('IC_BOCompletServiceInt.Process.CreateBillMovs');

            -- Se limpia memoria
            tbrcCargos.delete;
            rcSesunuse := null;

            -- Se obtienen los cargos temporales
            IC_BCCompletServiceInt.GetTmpCharges
            (
                tbrcCargos
            );

            -- Se evalúa que hayan datos para procesar
            if( tbrcCargos.first is null ) then
                return;
            end if;

            for nuInd in tbrcCargos.first .. tbrcCargos.last loop

                -- Se obtiene el cargo
                rcCargo := tbrcCargos(nuInd);

                -- Se obtiene servicio por empresa
                GetAdditionalData
                (
                    rcCargo.cargserv,
                    rcCargo.nuBusUni
                );

                -- Se procesa cada cargo obtenido
                ChargesDistribution
                (
                    idtDate,
                    inuDocNumbBill,
                    inuDocNumbNotes,
                    rcCargo.cargcicl,
                    rcCargo.nuBusUni,
                    rcCargo.cargserv,
                    rcCargo.cargcate,
                    rcCargo.cargsuca,
                    rcCargo.cargconc,
                    rcCargo.cargcaca,
                    rcCargo.cargusua,
                    rcCargo.cargterm,
                    rcCargo.nuValue,
                    rcCargo.nuBaseValue,
                    rcCargo.nuUnits,
                    rcCargo.cucosist,
                    rcCargo.suscsist,
                    rcCargo.cargflfa,
                    rcCargo.cargpete,
                    rcCargo.cargteco,
                    rcCargo.cargpeco,
                    rcCargo.cucofeve,
                    rcCargo.nuValueRet,
                    rcCargo.cargcuco,
                    rcCargo.tipodoco,
                    rcCargo.cargfopa
                );

            end loop;

            tbrcCargos.delete;

            pkErrors.Pop;
        EXCEPTION
            when LOGIN_DENIED then
                pkErrors.pop;
                raise LOGIN_DENIED;

            when pkConstante.exERROR_LEVEL2 then
                -- Error Oracle nivel dos
                pkErrors.pop;
                raise pkConstante.exERROR_LEVEL2;

            when OTHERS then
                pkErrors.NotifyError
                (
                    pkErrors.fsbLastObject,
                    sqlerrm,
                    IC_BOCompletServiceInt.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt.sbErrMsg
                );
        END CreateBillMovs;

    BEGIN
        pkErrors.Push('IC_BOCompletServiceInt.Process');


        -- numero de hilo
        sbObject := 'SERVICIOSCUMPLIDOS'||ut_session.getsessionid||'_';

        --Establece el control de concurrencia
        --InitConcurrenceCtrl(idtInitialDate,idtFinalDate,'ICBRSC');

        --<<
        -- Edmundo Lara
        -- 04/03/2015
        -- Buscamos el nit del parametro en la tabla LDCI_CARASEWE, debe estar el de GDCA
        -- y lo compara con el de la tabla SISTEMA, si igual ejecuta un proceso diferente.
        -- Este solo aplica para Gases del Caribe
        -->>

        ldci_pkwebservutils.proCaraServWeb(
                                            'WS_COSTOS',
                                            'VAL_NIT_SERV_CUMP_GDCA',
                                            csbNitGdca,
                                            IC_BOCompletServiceInt.sbErrMsg
                                            );

        -- Buscamos el nit de la LDC

        if( cusistemas%isopen ) then
            close cusistemas;
        end if;
        --
        open cusistemas;
        fetch cusistemas
         into csbNitLdc;
        close cusistemas;
        --<<
        -- Edmundo Lara
        -- Si nit de la LDC es el del parametro, ejecuta el proceso para GDCA
        -->>

        IF csbNitLdc = csbNitGdca THEN

          IC_BOCompletServiceInt_Gdca.Process
          (
              idtInitialDate,
              idtFinalDate,
              inuThreads,
              inuThread,
              isbProcStatus
          );

        ELSE

          -- Incializa las variables del proceso
          Initialize;

          -- Inicializa la fecha de proceso con la fecha inicial
          dtCurrentDate := idtInitialDate;

          -- Itera por cada día en el rango de fechas
          loop
              exit when dtCurrentDate > idtFinalDate;

              -- Reinicia las tablas en memoria
              ClearMemory;

              -- Obtener órdenes de activación de servicio
              SelectInstallOrders
              (
                  dtCurrentDate,
                  inuThread,
                  inuThreads,
                  tbProducts
              );

              -- Obtiene los documentos contables del día.
              GetDocNumbers
              (
                  dtCurrentDate,
                  nuBillDocNumber,
                  nuCertfDocNumber,
                  nuNoteDocNumber
              );

              if tbProducts.count > 0 then


                for nuIdx in tbProducts.first..tbProducts.last loop

                  --<<
                  -- Dcardona
                  -- 11-12-2014
                  -- Se verifican los servicios cumplidos de ventas migradas
                  -->>
                  nuPackageId := IC_BCCompletServiceInt.fnuGetInstallPackByProdRO(tbProducts(nuIdx), inuCommercial_plan);

                  --<<
                  -- Dcardona
                  -- 11-12-2014
                  -- Si el producto tiene tramite de venta migrada
                  -->>
                  IF (nuPackageId <> -1) THEN

                     --<<
                     -- Se obtienen los ingresos de la venta migrada y se insertan en la
                     -- tabla de cargos temporales
                     -->>
                     IC_BCCompletServiceInt.TemprInsertMigraCharges(tbProducts(nuIdx), inuCommercial_plan);


                  --<<
                  -- Dcardona
                  -- 11-12-2014
                  -- De lo contrario si no tiene tramite de venta migrada
                  -->>
                  ELSE

                    -- Se obtiene el código de la solicitud a partir del producto.
                    nuPackageId := IC_BCCompletServiceInt.fnuGetInstallPackByProd(tbProducts(nuIdx));



            /*

            Impactar para que reciba los productos en lugar de las órdenes

            -- Procesa órdenes
                    ProcessOrders
                    (
                        tbProducts( nuIdx ),
                        nuPackageId,
                        nuCertfDocNumber,
                        dtCurrentDate
                    );
                    */

                    -- Procesa cargos
                    ProcessCharges
                    (
                        nuPackageId,
                        tbProducts(nuIdx)
                    );

                  END IF;

                end loop;

                -- Crea los registros de facturación
                CreateBillMovs
                (
                    dtCurrentDate,
                    nuBillDocNumber,
                    nuNoteDocNumber
                );

                -- Se insertan los registros en la tabla de movimientos
                InsertSetOfRecords;

              END if;

              -- Actualiza el control de concurrencia del día a procesado
              IC_BOCompletServiceInt.FinalizeConcurrenceCtrl( dtCurrentDate );

              -- Asienta la transacción por día.
              pkGeneralServices.CommitTransaction;

              -- Actualiza el día
              dtCurrentDate := dtCurrentDate + 1;

          end loop;

        END IF;

        pkErrors.Pop;
    EXCEPTION
        when LOGIN_DENIED then
            pkErrors.pop;
            raise LOGIN_DENIED;

        when pkConstante.exERROR_LEVEL2 then
            -- Error Oracle nivel dos
            pkErrors.pop;
            raise pkConstante.exERROR_LEVEL2;

        when OTHERS then
            pkErrors.NotifyError
            (
                pkErrors.fsbLastObject,
                sqlerrm,
                IC_BOCompletServiceInt.sbErrMsg
            );
            pkErrors.pop;
            raise_application_error
            (
                pkConstante.nuERROR_LEVEL2,
                IC_BOCompletServiceInt.sbErrMsg
            );
    END Process;

    /*
        Propiedad intelectual de Open Systems (c).
        Procedure       :   ValExecuteFGHE
        Descripción     :   Valida la ejecución de FGHE en las fechas de
                            procesamiento

        Parámetros
        Entrada         :       Descripción
            idtInitialDate          Fecha inicial
            idtFinalDate            Fecha final

        Autor       :   Alejandro Rendón Gómez
        Fecha       :   13-09-2012 16:57:54

        Historia de Modificaciones
        Fecha       IDEntrega

        18-03-2014  arendon.SAO235707
        Se adiciona validación de FGHE Notas.

        18-07-2013  hlopez.SAO212472
        Se corrige forma de validar FGHE
        - Se modifica el metodo <ValProcess>

        13-09-2012  arendon.SAO190941
        Creación.
    */
    PROCEDURE ValExecuteFGHE
    (
        idtInitialDate  in  date,
        idtFinalDate    in  date
    )
    IS
        -------------------
        -- Variables
        -------------------
        -- Fecha auxiliar de iteración
        dtCurrent           date;

        -------------------
        -- Métodos
        -------------------
        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       :   ValProcess
            Descripción     :   Valida que el proceso este ejecutado.

            Parámetros
            Entrada         :       Descripción
                inuDocType              Tipo de documento
                idtMovDate              Fecha de contabilización del movimiento

            Autor       :   Alejandro Rendón Gómez
            Fecha       :   13-09-2012 17:11:27

            Historia de Modificaciones
            Fecha       IDEntrega

            18-07-2013  hlopez.SAO212472
            Se corrige forma de validar FGHE

            13-09-2012  arendon.SAO190941
            Creación.
        */
        PROCEDURE ValProcess
        (
            inuDocType  in  ic_docugene.dogetido%type,
            idtMovDate  in  ic_docugene.dogefeco%type
        )
        IS
        BEGIN
            pkErrors.Push('IC_BOCompletServiceInt.ValExecuteFGHE.ValProcess');

            pkBOProcessConcurrenceCtrl.ValExecuteFGHE
            (
                inuDocType,
                idtMovDate
            );

            pkErrors.Pop;
        EXCEPTION
            when LOGIN_DENIED then
                pkErrors.pop;
                raise LOGIN_DENIED;

            when pkConstante.exERROR_LEVEL2 then
                -- Error Oracle nivel dos
                pkErrors.pop;
                raise pkConstante.exERROR_LEVEL2;

            when OTHERS then
                pkErrors.NotifyError
                (
                    pkErrors.fsbLastObject,
                    sqlerrm,
                    IC_BOCompletServiceInt.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt.sbErrMsg
                );
        END ValProcess;

    BEGIN
        pkErrors.Push('IC_BOCompletServiceInt.ValExecuteFGHE');

        -- Inicializa la fecha de iteración
        dtCurrent := idtInitialDate;

        loop

            -- Condición de salida
            exit when dtCurrent > idtFinalDate;

            /* Realiza el control de ejecución */

            -------------------
            -- FACTURACIÿN
            -------------------
            ValProcess
            (
                cnuDOC_TYPE_BILL,
                dtCurrent
            );

            -------------------
            -- ACTAS
            -------------------
            /*ValProcess
            (
                cnuDOC_TYPE_CERTF,
                dtCurrent
            );*/

            -------------------
            -- NOTAS
            -------------------
            ValProcess
            (
                cnuDOC_TYPE_NOTES,
                dtCurrent
            );

            -- Incremente la fecha de iteración
            dtCurrent := dtCurrent + 1;

        end loop;

        pkErrors.Pop;
    EXCEPTION
        when LOGIN_DENIED then
            pkErrors.pop;
            raise LOGIN_DENIED;

        when pkConstante.exERROR_LEVEL2 then
            -- Error Oracle nivel dos
            pkErrors.pop;
            raise pkConstante.exERROR_LEVEL2;

        when OTHERS then
            pkErrors.NotifyError
            (
                pkErrors.fsbLastObject,
                sqlerrm,
                IC_BOCompletServiceInt.sbErrMsg
            );
            pkErrors.pop;
            raise_application_error
            (
                pkConstante.nuERROR_LEVEL2,
                IC_BOCompletServiceInt.sbErrMsg
            );
    END ValExecuteFGHE;

    /*
        Propiedad intelectual de Open Systems (c).
        Function        :   fnuIsGivBackCheckCause
        Descripción     :   Devuelve valor numérico que indica si una causa
                            esta asociada al clasificador de cheque devuelto.

        Parámetros      :       Descripción
            inuChargeCause          Causa de cargo

        Retorno         :
            nuIs                    Valor de retorno
                                    - 1: Causa asociada al clasificador de cheque devuelto
                                    - 0: Causa NO asociada al clasificador de cheque devuelto

        Autor       :   Alejandro Rendón Gómez
        Fecha       :   18-03-2014 15:10:54

        Historia de Modificaciones
        Fecha       IDEntrega

        18-03-2014  arendon.SAO235707
        Creación.
    */
    FUNCTION fnuIsGivBackCheckCause
    (
        inuChargeCause  in  causcarg.cacacodi%type
    )
        RETURN number
    IS
        --------------------
        -- Variables
        --------------------
        /* Valor de retorno */
        nuIs    number;

    BEGIN
        pkErrors.Push('IC_BOCompletServiceInt.fnuIsGivBackCheckCause');

        /* Valida si la causa de cargo está asociada al clasificador de
           cheque devuelto */
        if (FA_BOChargeCauses.fboIsGivBackCheckCause(inuChargeCause)) then

            nuIs := 1;
        else
            nuIs := 0;
        end if;

        pkErrors.Pop;

        RETURN (nuIs);

    EXCEPTION
        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            raise;
        when ex.CONTROLLED_ERROR then
            pkErrors.Pop;
            raise;
        when OTHERS then
            pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
            pkErrors.Pop;
            raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);
    END fnuIsGivBackCheckCause;

END IC_BOCompletServiceInt;
/
PROMPT Otorgando permisos de ejecucion a IC_BOCOMPLETSERVICEINT
BEGIN
    pkg_utilidades.praplicarpermisos('IC_BOCOMPLETSERVICEINT', 'ADM_PERSON');
END;
/