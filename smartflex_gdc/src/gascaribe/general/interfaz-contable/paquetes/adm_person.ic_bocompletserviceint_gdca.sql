CREATE OR REPLACE PACKAGE adm_person.ic_bocompletserviceint_gdca AS
/*
    Propiedad intelectual de Open International Systems. (c).

    Package	    :   IC_BOCompletServiceInt_GdCa

    Descripcion	:   Objeto de negocio para la Interfaz de servicios cumplidos

    Autor       :   Alejandro Rendon Gomez
    Fecha       :   12-07-2012 11:23:41

    Historia de Modificaciones
    Fecha	   IDEntrega
    
    17-06-2025  jpinedc     OSF-4555:   * Se modifica TemprInsertConstAccCharges 
                                        * Se modifica TemprInsertMigraCharges
                                        * Se modifica GetNitbyConcept
    18-06-2024  Adrianavg   OSF-2798: Se migra del esquema OPEN al esquema ADM_PERSON
    
    18-03-2014  arendon.SAO235707
    Se modifica para adicionar el reporte de los Hechos Economicos
    correspondientes a Notas de Facturacion.
    Se modifican los metodos:
        - Process
        - ValExecuteFGHE
    Se adiciona el metodo <fnuIsGivBackCheckCause>

    17-07-2013  hlopez.SAO212472
    Se adiciona el atributo Clasificacion Contable del Contrato
    - Se modifica el metodo <Process> y <ValExecuteFGHE>

    17-07-2013  hlopez.SAO212472
    Se adiciona el atributo Clase Contable del Contrato
    - Se modifica el metodo <Process>

    09-10-2012  hlopez.SAO193548
    Se modifica el metodo <Process>

    13-09-2012  arendon.SAO190941
    Se adiciona el metodo <ValExecuteFGHE>.

    12-07-2012  arendon.SAO185253
    Creacion
*/
    -------------------
    -- Constantes
    -------------------
    -- Operacion = Generacion
    cnuGENERATION   constant number(1) := 1;

    -- Operacion = Reversion
    cnuROLLBACK     constant number(1) := 2;

    -------------------
    -- Colecciones
    -------------------
    -- Registro para movimientos de facturacion (cargos)
    type tyrcChargesMovs is record
    (
        cargserv    tmp_cargproc.cargserv%type,
        nuBusUni    tmp_cargproc.cargserv%type,
        cargcicl    tmp_cargproc.cargcicl%type,
        cargcate    tmp_cargproc.cargcate%type,
        cargsuca    tmp_cargproc.cargsuca%type,
        cargconc    tmp_cargproc.cargconc%type,
        cargcaca    tmp_cargproc.cargcaca%type,
        cargdepa    tmp_cargproc.cargdepa%type,
        cargloca    tmp_cargproc.cargloca%type,
        cargflfa    tmp_cargproc.cargtipr%type,
        cargpete    tmp_cargproc.cargpete%type,
        cargteco    tmp_cargproc.cargteco%type,
        cargpeco    tmp_cargproc.cargunid%type,
        cargcuco    tmp_cargproc.cargcuco%type,
        cucosist    cuencobr.cucosist%type,
        suscsist    suscripc.suscsist%type,
        cucofeve    tmp_cargproc.cargfech%type,
        cargusua    tmp_cargproc.cargusua%type,
        cargterm    tmp_cargproc.cargterm%type,
        nuValue     number,
        nuBaseValue number,
        nuValueRet  number,
        nuUnits     number,
        tipodoco    number,
        cargfopa    tmp_cargproc.cargfopa%TYPE DEFAULT NULL
    );

    -- Tabla para movimientos de facturacion (cargos)
    type tytbChargesMovs is table of tyrcChargesMovs index by binary_integer;

    -------------------
    -- Metodos
    -------------------

    -- Obtiene version actual de paquete
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

    PROCEDURE GetTmpCharges
    (
        otbrcCargos out IC_BOCompletServiceInt_Gdca.tytbChargesMovs
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

    PROCEDURE TemprInsertConstAccCharges
    (
       idtfechafin     in  Date,
       inuThreads      in  number,
       inuThread       in  number
    );


    PROCEDURE TemprInsertMigraCharges
    (
        idtfechafin  IN Date,
       inuThreads    in  number,
       inuThread     in  number
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

END IC_BOCompletServiceInt_Gdca;
/

CREATE OR REPLACE PACKAGE BODY adm_person.IC_BOCompletServiceInt_Gdca AS
--ProcessBill_Gdca
/*
    Propiedad intelectual de Open International Systems (c).

    Paquete     :   IC_BOCompletServiceInt_Gdca
    Descripcion :   Variables, procedimientos y funciones del paquete
                    IC_BOCompletServiceInt_Gdca

    Autor       :   Alejandro Rendon Gomez
    Fecha       :   12-07-2012 11:24:00

    Historia de Modificaciones
    Fecha       IDEntrega

    17-07-2020  CA-448
    Se modifica la manera de reportar ingreso de servicios cumplidos, se reportara ingreso por orden
    de trabajo legalizada, ya sea de Interna, CxC y Certificacion Previa, este nueov proceso empieza
    a funcionar con las ordenes legalizadas con fecha mayor o igual al '01-07-2020'.

    18-05-2021  CA-730     HT
    Se Valida el proceso de generar el servicio cumplido por orden de trabajo legalizada de acuerdo al
    ultimo cambio que se presento en la certifiacion previa, se corrige el proceso para que el proceso
    se ejecute por hilos.

*/

    -------------------
    -- Constantes
    -------------------

    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
        
    /* Version de paquete */
    csbVERSION          constant varchar2(250) := 'OSF-4555';

    /* Mnemonico del proceso de reversion de Servicios Cumplidos */
    csbROLLBACK_PROCESS constant varchar2(10) := 'ICBRSC';

    /* Cadenas para reemplazar en los mensajes de error */
    csbINGRESO constant varchar2(100) := 'Ingreso';
    csbNO_INGRESO constant varchar2(100) := 'No ingreso';
    csbDEBE constant varchar2(100) := 'debe';
    csbNO_DEBE constant varchar2(100) := 'no debe';
    csbDIAS_RETRASO constant varchar2(100) := 'Dias Retraso';
    csbFECHA_INICIAL constant varchar2(100) := 'Fecha Inicial';
    csbFECHA_FINAL constant varchar2(100) := 'Fecha Final';

    /* Formato de fecha */
    cnuFORMAT   constant varchar2(10) := 'DD-MM-YYYY';

    /* Limite de seleccion de datos */
    cnuLIMIT            constant number := 100;

    /* Tipo de documento Facturacion */
    cnuDOC_TYPE_BILL    constant number := 71;

    /* Tipo de documento Actas */
    cnuDOC_TYPE_CERTF   constant number := 77;

    /* Tipo de documento Notas */
    cnuDOC_TYPE_NOTES   constant number := 73;

    -------------------
    -- Variables
    -------------------

    sbErrMsg            ge_message.description%type;
    mserrored           varchar2(300);
    -- Indicador de carga de parametros
    boLoaded            boolean;

    -- Tabla con los tipos de trabajo INSTALACION
    tbInstallTaskType   UT_String.TyTb_String;

    --Parametro de tipos de trabajo instalacion y red interna
    sbInstTaskType ge_parameter.value%type;

    --Tipo de paquete Venta constructora
    cnuConstructorPackTypeId constant ps_package_type.package_type_id%type := 323;

    --Tipo de paquete Venta Migracion
    cnuMigrationPackTypeId constant ps_package_type.package_type_id%type := 100271;

    -- Indicador de carga de conceptos
    boConceptLoaded     boolean;

    -->
    -- E. Lara F.
    -- 24-01-2015
    -- Indicador proceso de Interna Constructoras o Servicios Cumplidos
    -- True  = Interna Constructoras
    -- False = Servicios Cumplidos
    boInternalLoaded    boolean;
    -- Fechas de Proceso
    vdtInicial          date;
    vdtFinal            date;
    --
    -->

    --Concepto Cargo x Conexion
    nuCharXConexConceptoId  constant number(4) := 19;

    --Concepto Cargo x Conexion
    nuCertifIntallPrevioId  constant number(4) := 674;

    --Concepto de la interna
    sbConceptoInternalId    constant number(4) := 30;

    --Tipo de Trabajo de Cargo x Conexion
    sbCharXConexChargessId  constant number(5) := 12150;

    -->
    -- Usuario ejecutor
    sbUserName          varchar2(2000);

    -- Terminal
    sbTerminal          varchar2(2000);

    -- Nivel de ubicacion geografica 1
    nuNivelUbge1    ge_geogra_loca_type.geog_loca_area_type%type;
    -- Nivel de ubicacion geografica 2
    nuNivelUbge2    ge_geogra_loca_type.geog_loca_area_type%type;
    -- Nivel de ubicacion geografica 3
    nuNivelUbge3    ge_geogra_loca_type.geog_loca_area_type%type;
    -- Nivel de ubicacion geografica 4
    nuNivelUbge4    ge_geogra_loca_type.geog_loca_area_type%type;
    -- Nivel de ubicacion geografica 5
    nuNivelUbge5    ge_geogra_loca_type.geog_loca_area_type%type;

    -- Identificador de ubicacion 1 (LOCALIDAD (S) - BARRIO (N))
    sbLOCBAR1       VARCHAR2(1);
    -- Identificador de ubicacion 2 (LOCALIDAD (S) - BARRIO (N))
    sbLOCBAR2       VARCHAR2(1);
    -- Identificador de ubicacion 3 (LOCALIDAD (S) - BARRIO (N))
    sbLOCBAR3       VARCHAR2(1);
    -- Identificador de ubicacion 4 (LOCALIDAD (S) - BARRIO (N))
    sbLOCBAR4       VARCHAR2(1);
    -- Identificador de ubicacion 5 (LOCALIDAD (S) - BARRIO (N))
    sbLOCBAR5       VARCHAR2(1);

    -------------------
    -- Colecciones
    -------------------

    -- Tabla para el cache de los conceptos
    type tytbConcepto is table of pkBCConcepto.tyConcepto index BY binary_integer;
    tbConcepto      tytbConcepto;

    sbObject    openfltr.opftobje%type := 'SERVICIOSCUMPLIDOS';
    sbTerm      openfltr.opftterm%type := userenv('TERMINAL');
    sbUser      openfltr.opftuser%type := USER;

    -------------------
    -- Metodos
    -------------------
    /*
        Propiedad intelectual de Open International Systems. (c).

        Funcion 	:   fsbVersion
        Descripcion	:   Obtiene SAO que identifica version asociada a ultima
                        entrega de paquete.

        Retorno     :
            csbVersion      Version de paquete.

        Autor	    :   Alejandro Rendon Gomez
        Fecha	    :   12-07-2012 10:40:08

        Historia de Modificaciones
        Fecha	    IDEntrega

        12-07-2012  arendon.SAO185253
        Creacion.
    */

    FUNCTION fsbVersion
        return varchar2
    IS
    BEGIN

        return IC_BOCompletServiceInt_Gdca.csbVERSION;

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
                IC_BOCompletServiceInt_Gdca.sbErrMsg
            );
            pkErrors.pop;
            raise_application_error
            (
                pkConstante.nuERROR_LEVEL2,
                IC_BOCompletServiceInt_Gdca.sbErrMsg
            );
    END fsbVersion;

    /*
        Propiedad intelectual de Open Systems (c).
        Procedure       :   GetParameters
        Descripcion     :   Obtiene los parametros generales del sistema

        Autor       :   Alejandro Rendon Gomez
        Fecha       :   19-07-2012 08:46:18

        Historia de Modificaciones
        Fecha       IDEntrega

        19-07-2012  arendon.SAO185253
        Creacion.
    */
    PROCEDURE GetParameters
    IS
        -------------------
        -- Constantes
        -------------------
        -- Parametro Tipos De Trabajo de Instalacion
        csbTIPO_TRABAJO constant varchar2(100) := 'IC_INSTALL_TASK_TYPE';

        -- Caracter separador
        csbPIPE         constant char(1) := '|';

        csbComma        constant char(1) := ',';

        -------------------
        -- Variables
        -------------------
        sbInstallTaskType   ge_parameter.description%type;

    BEGIN
        pkErrors.Push('IC_BOCompletServiceInt_Gdca.GetParameters');

        -- Evalua si ya se han cargado los parametros y termina el metodo
        if ( IC_BOCompletServiceInt_Gdca.boLoaded ) then
            pkErrors.Pop;
            return;
        end if;

        -- Obtiene el valor del parametro
        sbInstallTaskType := GE_BOParameter.fsbValorAlfanumerico
                                (
                                    csbTIPO_TRABAJO
                                );

        sbInstTaskType := replace(sbInstallTaskType,csbPIPE,csbComma);

        -- Parsea el parametro y obtiene los tipos configurados
        UT_String.ExtString
        (
            sbInstallTaskType,
            csbPIPE,
            IC_BOCompletServiceInt_Gdca.tbInstallTaskType
        );

        -- Obtiene usuario ejecutor y terminal
        IC_BOCompletServiceInt_Gdca.sbTerminal := pkGeneralServices.fsbGetTerminal;
        IC_BOCompletServiceInt_Gdca.sbUserName := pkGeneralServices.fsbGetUserName;

        -- Obtiene los niveles de ubicacion geograficas.
        GE_BOGeogra_Location.GetUbges
        (
            IC_BOCompletServiceInt_Gdca.nuNivelUbge1,
            IC_BOCompletServiceInt_Gdca.nuNivelUbge2,
            IC_BOCompletServiceInt_Gdca.nuNivelUbge3,
            IC_BOCompletServiceInt_Gdca.nuNivelUbge4,
            IC_BOCompletServiceInt_Gdca.nuNivelUbge5,
            IC_BOCompletServiceInt_Gdca.sbLOCBAR1,
            IC_BOCompletServiceInt_Gdca.sbLOCBAR2,
            IC_BOCompletServiceInt_Gdca.sbLOCBAR3,
            IC_BOCompletServiceInt_Gdca.sbLOCBAR4,
            IC_BOCompletServiceInt_Gdca.sbLOCBAR5
        );


        -- Actualiza el indicador de carga de parametros
        IC_BOCompletServiceInt_Gdca.boLoaded := TRUE;

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
                IC_BOCompletServiceInt_Gdca.sbErrMsg
            );
            pkErrors.pop;
            raise_application_error
            (
                pkConstante.nuERROR_LEVEL2,
                IC_BOCompletServiceInt_Gdca.sbErrMsg
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
            --INSERT INTO openfltr (opftcons,opftobje,opftterm,opftuser,opftfech,opftdesc)
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
        Descripcion     :   Valida los parametros de entrada

        Parametros
        Entrada         :       Descripcion
            idtInitDate             Fecha inicial
            idtFinalDate            Fecha final
            inuOperation            Operacion (1-Generacion, 2-Reversion)
            inuDelayDays            Dias de retraso

        Autor       :   Alejandro Rendon Gomez
        Fecha       :   12-07-2012 11:32:15

        Historia de Modificaciones
        Fecha       IDEntrega

        12-07-2012  arendon.SAO185253
        Creacion.
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
        pkErrors.Push('IC_BOCompletServiceInt_Gdca.ValInputData');

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
                IC_BOCompletServiceInt_Gdca.csbFECHA_INICIAL
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
                IC_BOCompletServiceInt_Gdca.csbFECHA_FINAL
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
        if( inuOperation = IC_BOCompletServiceInt_Gdca.cnuGENERATION )then
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
                        IC_BOCompletServiceInt_Gdca.csbNO_INGRESO
                    );

                    pkErrors.ChangeMessage
                    (
                        '%2',
                        IC_BOCompletServiceInt_Gdca.csbDEBE
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
                        IC_BOCompletServiceInt_Gdca.csbDIAS_RETRASO
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
                        IC_BOCompletServiceInt_Gdca.csbINGRESO
                    );

                    pkErrors.ChangeMessage
                    (
                        '%2',
                        IC_BOCompletServiceInt_Gdca.csbNO_DEBE
                    );

                    raise LOGIN_DENIED;
                end if;
            end if;
        end if;

        -- Se valida operacion es reversion
        if( inuOperation = IC_BOCompletServiceInt_Gdca.cnuROLLBACK )then

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
                    IC_BOCompletServiceInt_Gdca.csbINGRESO
                );

                pkErrors.ChangeMessage
                (
                    '%2',
                    IC_BOCompletServiceInt_Gdca.csbNO_DEBE
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
                IC_BOCompletServiceInt_Gdca.sbErrMsg
            );
            pkErrors.pop;
            raise_application_error
            (
                pkConstante.nuERROR_LEVEL2,
                IC_BOCompletServiceInt_Gdca.sbErrMsg
            );
    END ValInputData;

    /*
        Propiedad intelectual de Open Systems (c).
        Procedure       :   ValFrequency
        Descripcion     :   Valida la frecuencia de ejecucion

        Parametros
        Entrada         :       Descripcion
            idtInitDate             Fecha inicial
            idtFinalDate            Fecha final
            inuDelayDays            Dias de retraso
            isbFrequency            Frecuencia

        Autor       :   Alejandro Rendon Gomez
        Fecha       :   17-07-2012 15:51:13

        Historia de Modificaciones
        Fecha       IDEntrega

        13-09-2012  arendon.SAO190941
        Se adiciona validacion para no permitir que la frecuencia sea diferente
        a UNA VEZ o DIARIO.

        17-07-2012  arendon.SAO185253
        Creacion.
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
        pkErrors.Push('IC_BOCompletServiceInt_Gdca.ValFrequency');

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
                    IC_BOCompletServiceInt_Gdca.csbNO_INGRESO
                );
                pkErrors.ChangeMessage
                (
                    '%2',
                    IC_BOCompletServiceInt_Gdca.csbDEBE
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
                    IC_BOCompletServiceInt_Gdca.csbDIAS_RETRASO
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
                    IC_BOCompletServiceInt_Gdca.csbINGRESO
                );
                pkErrors.ChangeMessage
                (
                    '%2',
                    IC_BOCompletServiceInt_Gdca.csbNO_DEBE
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
                IC_BOCompletServiceInt_Gdca.sbErrMsg
            );
            pkErrors.pop;
            raise_application_error
            (
                pkConstante.nuERROR_LEVEL2,
                IC_BOCompletServiceInt_Gdca.sbErrMsg
            );
    END ValFrequency;

    /*
        Propiedad intelectual de Open Systems (c).
        Procedure       :   ValidateConcurrence
        Descripcion     :   Valida concurrencia de procesos

        Parametros
        Entrada         :       Descripcion
            idtInitDate             Fecha Inicial
            idtFinalDate            Fecha Final
            inuDelayDays            Dias de retraso
            isbRollProcess          Proceso de reversion

        Autor       :   Alejandro Rendon Gomez
        Fecha       :   19-07-2012 18:33:14

        Historia de Modificaciones
        Fecha       IDEntrega

        19-07-2012  arendon.SAO185253
        Creacion.
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

        -- Proceso de reversion
        sbRollBackProcess   varchar2(10);

    BEGIN
        pkErrors.Push('IC_BOCompletServiceInt_Gdca.ValidateConcurrence');

        -- Si hay dias de retraso, calcula las fechas de proceso a partir de estos
        if ( inuDelayDays IS not null ) then
            dtInitDate := trunc( sysdate ) - inuDelayDays;
            dtFinalDate := dtInitDate;
        else
            dtInitDate := idtInitDate;
            dtFinalDate := idtFinalDate;
        end if;

        -- Verifica si se envia proceso de reversion, tomando por defecto
        -- Reversion de Interfaz de Servicios Cumplidos
        if ( isbRollProcess IS null ) then
            sbRollBackProcess := IC_BOCompletServiceInt_Gdca.csbROLLBACK_PROCESS;
        else
            sbRollBackProcess := isbRollProcess;
        end if;

        loop
            -- Condicion de salida del ciclo
            exit when dtInitDate > dtFinalDate;

            -- Valida la concurrencia
            pkBOProcessConcurrenceCtrl.ValidateConcurrence
            (
                to_char( dtInitDate, IC_BOCompletServiceInt_Gdca.cnuFORMAT),
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
                IC_BOCompletServiceInt_Gdca.sbErrMsg
            );
            pkErrors.pop;
            raise_application_error
            (
                pkConstante.nuERROR_LEVEL2,
                IC_BOCompletServiceInt_Gdca.sbErrMsg
            );
    END ValidateConcurrence;

    /*
        Propiedad intelectual de Open Systems (c).
        Procedure       :   InitConcurrenceControl
        Descripcion     :   Inicializa el control de concurrencia para el
                            proceso Interfaz de Servicios Cumplidos

        Parametros
        Entrada         :       Descripcion
            idtInitDate             Fecha Inicial
            idtFinalDate            Fecha Final
            isbSentence             Sentencia

        Autor       :   Alejandro Rendon Gomez
        Fecha       :   19-07-2012 15:41:48

        Historia de Modificaciones
        Fecha       IDEntrega

        19-07-2012  arendon.SAO185253
        Creacion.
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
        -- Fecha actual de iteracion
        dtCurrDate      date;

    BEGIN
        pkErrors.Push('IC_BOCompletServiceInt_Gdca.InitConcurrenceCtrl');

        -- Asigna la fecha inicial
        dtCurrDate := idtInitDate;

        loop
            -- Termina el ciclo cuando se iteren todas las fechas
            exit when dtCurrDate > idtFinalDate;

            pkBOProcessConcurrenceCtrl.GenControlProcessAT
            (
                to_char( dtCurrDate, IC_BOCompletServiceInt_Gdca.cnuFORMAT ),
                isbSentence
            );

            -- Incrementa la fecha en un dia
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
                IC_BOCompletServiceInt_Gdca.sbErrMsg
            );
            pkErrors.pop;
            raise_application_error
            (
                pkConstante.nuERROR_LEVEL2,
                IC_BOCompletServiceInt_Gdca.sbErrMsg
            );
    END InitConcurrenceCtrl;

    /*
        Propiedad intelectual de Open Systems (c).
        Procedure       :   FinalizeConcurrenceCtrl
        Descripcion     :   Finaliza control de concurrencia

        Parametros
        Entrada         :       Descripcion
            idtDate                 Fecha de proceso

        Autor       :   Alejandro Rendon Gomez
        Fecha       :   19-07-2012 17:04:58

        Historia de Modificaciones
        Fecha       IDEntrega

        19-07-2012  arendonSAO
        Creacion.
    */
    PROCEDURE FinalizeConcurrenceCtrl
    (
        idtDate in  date
    )
    IS
    BEGIN
        pkErrors.Push('IC_BOCompletServiceInt_Gdca.FinalizeConcurrenceCtrl');

        -- Finaliza el control de concurrencia
        pkBOProcessConcurrenceCtrl.FinConcurrenceControl
        (
            to_char( idtDate, IC_BOCompletServiceInt_Gdca.cnuFORMAT )
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
                IC_BOCompletServiceInt_Gdca.sbErrMsg
            );
            pkErrors.pop;
            raise_application_error
            (
                pkConstante.nuERROR_LEVEL2,
                IC_BOCompletServiceInt_Gdca.sbErrMsg
            );
    END FinalizeConcurrenceCtrl;

    /*
        Propiedad intelectual de Open Systems (c).
        Procedure       :   GetProcessDates
        Descripcion     :   Calcula las fechas de procesamiento dependiendo si
                            hay o no dias de retraso

        Parametros
        Entrada         :       Descripcion
            idtInitialDate          Fecha inicial
            idtFinalDate            Fecha final
            inuDelayDays            Dias de retraso

        Salida          :       Descripcion
            odtInitialDate          Fecha inicial definitiva
            odtFinalDate            Fecha final definitiva

        Autor       :   Alejandro Rendon Gomez
        Fecha       :   23-07-2012 14:36:12

        Historia de Modificaciones
        Fecha       IDEntrega

        23-07-2012  arendon.SAO185253
        Creacion.
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
        pkErrors.Push('IC_BOCompletServiceInt_Gdca.GetProcessDates');

        ------------------------------------------
        -- Inicializa las fechas de procesamiento
        ------------------------------------------
        -- Si hay dias de retraso, las fechas de proceso se calculan a partir
        -- de la fecha actual restando los dias de retraso, en caso contrario
        -- se usan las fechas ingresadas por parametro.
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
        Procedure       :   GetTmpCharges
        Descripcion     :   Obtiene cargos para provision de cargos basicos.

        Parametros
        Salida          :       Descripcion
            otbrcCargos             Datos obtenidos

        Autor       :   Alejandro Rendon Gomez
        Fecha       :   24-07-2012 15:57:24

        Historia de Modificaciones
        Fecha       IDEntrega

        11-04-2014  aesguerra.3338
        Se modifica la sentencia para fijar valor cero a la columna nuValueRet

        18-03-2014  arendon.SAO235707
        Se adiciona agrupamiento por el Tipo de documento (tmp_cargproc.cargmes)

        24-07-2012  arendon.SAO185253
        Creacion.
    */
    PROCEDURE GetTmpCharges
    (
        otbrcCargos out IC_BOCompletServiceInt_Gdca.tytbChargesMovs
    )
    IS

        ------------------------------------------------------------------------
        -- Cursores
        ------------------------------------------------------------------------

        -- Obtiene cargos
        CURSOR cuCargos
        IS
            SELECT      --+ parallel (tmp_cargproc, 6)
                        cargserv,
                        cargserv,
                        cargcicl,
                        cargcate,
                        cargsuca,
                        cargconc,
                        cargcaca,
                        cargdepa,
                        cargloca,
                        cargflfa,
                        cargpete,
                        cargteco,
                        cargunid,
                        cargcuco,
                        99,   --pktblCuencobr.fnuGetCompany(cargcuco),
                        cargzoco,
                        NULL, --pktblCuencobr.fdtGetExpirationDate(cargcuco) cucofeve,
                        cargusua,
                        cargterm,
                        sum( decode( cargsign, 'DB', cargvalo, 'CR', -1 * cargvalo, 0 ) ) nuValue,
                        sum( decode( cargsign, 'DB', cargimp1, 'CR', -1 * cargimp1, 0 ) ) nuBaseValue,
                        0, -- nuValueRet,
                        0, --sum( nvl(cargunid, 0 ) ) nuUnits,
                        1, --cargmes,
                        cargfopa
            FROM        tmp_cargproc
                        /*+IC_BCCompletServiceInt.GetTmpCharges*/
            GROUP BY    cargserv,
                        cargserv,
                        cargcicl,
                        cargcate,
                        cargsuca,
                        cargconc,
                        cargcaca,
                        --<< CA-730
                        cargdepa,
                        cargloca,
                        -->>
                        cargflfa,
                        cargpete,
                        cargteco,
                        cargunid,
                        cargcuco,
                        pktblcuencobr.fnuGetCompany( cargcuco ),
                        cargzoco,
                        pktblcuencobr.fdtGetExpirationDate( cargcuco ),
                        cargusua,
                        cargterm,
                        cargmes,
                        cargfopa
            HAVING      sum( decode( cargsign, 'DB', cargvalo, 'CR', -1 * cargvalo, 0 ) ) <> 0;

    BEGIN

        pkErrors.Push
        (
            'IC_BCCompletServiceInt_Gdca.GetTmpCharges'
        );

        if( cuCargos%isopen ) then
            close cuCargos;
        end if;

        open    cuCargos;

        -- Se obtienen los cargos
        fetch           cuCargos
        bulk collect
        into            otbrcCargos;

        close cuCargos;

        pkErrors.Pop;

    EXCEPTION
        when LOGIN_DENIED then
            pkErrors.Pop;
            if( cuCargos%isopen ) then
                close cuCargos;
            end if;
            raise LOGIN_DENIED;
        when pkConstante.exERROR_LEVEL2 then
            pkErrors.Pop;
            if( cuCargos%isopen ) then
                close cuCargos;
            end if;
            raise pkConstante.exERROR_LEVEL2;
        when OTHERS then
            mserrored := 'Error = ' || sqlerrm;
            pkErrors.NotifyError
            (
                pkErrors.fsbLastObject   ,
                sqlerrm                  ,
                IC_BOCompletServiceInt_Gdca.SBERRMSG
            );
            pkErrors.Pop;
            if( cuCargos%isopen ) then
                close cuCargos;
            end if;
            raise_application_error
            (
                pkConstante.nuERROR_LEVEL2,
                IC_BOCompletServiceInt_Gdca.SBERRMSG
            );
    END GetTmpCharges;


    /*
        Propiedad intelectual de Open Systems (c).
        Procedure       :   Process
        Descripcion     :   Genera los movimientos del Ingreso correspondiente a las Internas
                            legalizadas y los servicios cumplidos en el periodo contable procesado.

        Parametros
        Entrada         :       Descripcion
            idtInitialDate          Fecha inicial
            idtFinalDate            Fecha final
            inuDelayDays            Dias de retraso
            inuThreads              Numero total de hilos
            inuThread               Hilo actual
            isbProcStatus           Identificador de seguimiento del estado del
                                    proceso

        Salida          :       Descripcion

        Autor       :   Alejandro Rendon Gomez
        Fecha       :   18-07-2012 09:21:37

        Historia de Modificaciones
        Fecha       IDEntrega

        24-04-2014  aesguerra.3487
        Se adiciona validacion para determinar si la solicitud fue procesada por una orden previa.

        18-03-2014  arendon.SAO235707
        Se modifica para adicionar el reporte de los Hechos Economicos
        correspondientes a Notas de Facturacion.
        Se modifican los metodo anidados:
            - ChargesDistribution
            - GetDocNumbers
            - ProcessCharges
            - CreateBillMovs
        Se adiciona el metodo anidado ProcessNotes

        23-07-2013  hlopez.SAO212970
        Se modifica la forma de obtener el atributo Clasificacion COntable del
        Contrato
        - Se modifica el metodo <ProcessItemsWithoutCertf>

        17-07-2013  hlopez.SAO212472
        Se adiciona el atributo Clasificacion Contable del Contrato
        - Se modifica los metodos internos <ClearMemory>, <FillTable>,
          <ProcessOrderWithCertf>, <ProcessOrderWithoutCertf> y <ProcessOrders>
        - Se adiciona el metodo <ProcessItemsWithoutCertf> para contabilizar los
          items de materiales que no salen en actas.

        05-04-2013  arendon.SAO205719
        Se adiciona el atributo MOVIITEM a los hechos economicos de Servicios
        Cumplidos.

        12-10-2012  arendon.SAO193932
        Se modifica el metodo anidado <ChargesDistribution>

        10-10-2012  arendon.SAO193603
        Se modifican los metodos anidados
            - ProcessOrders
            - ChargesDistribution
            - ProcessOrderWithCertf
            - ProcessOrderWithoutCertf

        09-10-2012  hlopez.SAO193548
        Se modifican los metodos <ClearMemory> y <FillTable>

        18-07-2012  arendon.SAO185253
        Creacion.
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


        -------------------
        -- Tipos
        -------------------
        -- Servicios Cumplidos.
        type tytbHicaesco IS table of OR_order_activity.product_id%type index BY binary_integer;

        -->
        -- E. Lara F.
        -- 24-01-2015
        -- Internas Legalizadas.
        type typroducts is record
        (
          package_id         OR_order_activity.package_id%type,
          product_id         OR_order_activity.product_id%type,
          related_order_id   OR_related_order.related_order_id%type,
          package_type_id    MO_packages.package_type_id%type
        );

        type tytpproducts IS table of typroducts index BY binary_integer;
        tbnusepack tytpproducts;

        -------------------
        -- Variables
        -------------------
        /* Fecha actual de procesamiento */
        dtCurrentDate   date;

        /* Numero del documento de Facturacion */
        nuBillDocNumber     ic_docugene.dogenudo%type;

        /* Numero del documento de Actas */
        nuCertfDocNumber    ic_docugene.dogenudo%type;

        /* Numero del documento de Notas */
        nuNoteDocNumber     ic_docugene.dogenudo%type;

        /* Codigo de la solicitud */
        nuPackageId     or_order_activity.package_id%type;

        /* Tabla de ordenes */
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
        /* Tipo de movimiento Facturacion por concepto */
        cnuMOVE_TYPE_BILL   constant number := 1;

        /* Tipo de movimiento Actas de liquidacion */
        cnuMOVE_TYPE_CERTF  constant number := 63;

        /* Tipo de movimiento Notas por concepto */
        cnuMOVE_TYPE_NOTES  constant number := 16;

        /* Tipo de hecho economico Servicios Cumplidos */
        csbTIHE_COMPL_SERV  constant varchar2(2) := 'SC'; -- Servicio cumplido OSF
        csbTIHE_SERV_MIGRA  constant varchar2(2) := 'MC'; -- Servicio Cumplido Migrado

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
        -- Metodos
        -------------------
        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       :   Initialize
            Descripcion     :   Inicializa las variables de procesamiento

            Autor       :   Alejandro Rendon Gomez
            Fecha       :   19-07-2012 08:43:02

            Historia de Modificaciones
            Fecha       IDEntrega

            19-07-2012  arendon.SAO185253
            Creacion.
        */
        PROCEDURE Initialize
        IS
        BEGIN
            pkErrors.Push('IC_BOCompletServiceInt_Gdca.Process.Initialize');

            -- Obtiene los parametros generales del sistema
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
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
        END Initialize;


        /**********************************************************************
        	Propiedad intelectual de OPEN International Systems
        	Nombre              SetProcessDate

        	Autor				Andres Felipe Esguerra Restrepo

        	Fecha               24-abr-2014

        	Descripcion         A partir del ID de una solicitud obtiene si esta debe procesarse y
        	                    la fecha en que debe hacerse

        	***Parametros***
        	Nombre				Descripcion
        	inuPackId           ID de la solicitud
        ***********************************************************************/
        PROCEDURE SetProcessDate(inuPackId in mo_packages.package_id%type) IS

        blHasOpenOrders boolean;

        csbTIPO_TRABAJO constant varchar2(100) := 'IC_INSTALL_TASK_TYPE';

        sbInstallTaskType   ge_parameter.description%type;

        BEGIN

            pkErrors.Push('IC_BOCompletServiceInt_Gdca.Process.SetProcessDate');

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
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
        END SetProcessDate;

    /*
        Propiedad intelectual de Open Systems (c).
        Procedure       : LoadConcepts
        Descripcion     : Obtiene los conceptos existentes en el sistema de tipo
                          diferente a IMPUESTO.

        Autor    :  Alejandro Rendon Gomez
        Fecha    :  24-07-2012 17:04:35

        Historia de Modificaciones
        Fecha       IDEntrega

        24-07-2012  arendon.SAO185253
        Creacion.
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

        -- Obtiene todos los conceptos cuyo tipo de concepto de liquidacion
        -- es diferente a impuesto.
        rfConcepts := pkBCConcepto.frfGetSalesConcepts;

        loop
            -- Obtiene los datos
            fetch   rfConcepts
            bulk    collect
            into    tbConcTmp
            limit   IC_BOCompletServiceInt_Gdca.cnuLIMIT;

            -- Termina la iteracion cuando no obtenga mas datos
            exit when tbConcTmp.first is null;

            -- Obtiene la primera posicion de la tabla
            nuIdx := tbConcTmp.first;

            loop
                -- Condicion de salida
                exit when nuIdx IS null;

                -- Llena la tabla final indexando por el codigo del concepto
                IC_BOCompletServiceInt_Gdca.tbConcepto( tbConcTmp( nuIdx ).conccodi ).conccodi :=
                                                    tbConcTmp( nuIdx ).conccodi;
                IC_BOCompletServiceInt_Gdca.tbConcepto( tbConcTmp( nuIdx ).conccodi ).concdesc :=
                                                    tbConcTmp( nuIdx ).concdesc;
                IC_BOCompletServiceInt_Gdca.tbConcepto( tbConcTmp( nuIdx ).conccodi ).conccoco :=
                                                    tbConcTmp( nuIdx ).conccoco;
                IC_BOCompletServiceInt_Gdca.tbConcepto( tbConcTmp( nuIdx ).conccodi ).concorli :=
                                                    tbConcTmp( nuIdx ).concorli;
                IC_BOCompletServiceInt_Gdca.tbConcepto( tbConcTmp( nuIdx ).conccodi ).concpoiv :=
                                                    tbConcTmp( nuIdx ).concpoiv;
                IC_BOCompletServiceInt_Gdca.tbConcepto( tbConcTmp( nuIdx ).conccodi ).concorim :=
                                                    tbConcTmp( nuIdx ).concorim;
                IC_BOCompletServiceInt_Gdca.tbConcepto( tbConcTmp( nuIdx ).conccodi ).concorge :=
                                                    tbConcTmp( nuIdx ).concorge;
                IC_BOCompletServiceInt_Gdca.tbConcepto( tbConcTmp( nuIdx ).conccodi ).concdife :=
                                                    tbConcTmp( nuIdx ).concdife;
                IC_BOCompletServiceInt_Gdca.tbConcepto( tbConcTmp( nuIdx ).conccodi ).conccore :=
                                                    tbConcTmp( nuIdx ).conccore;
                IC_BOCompletServiceInt_Gdca.tbConcepto( tbConcTmp( nuIdx ).conccodi ).conccoin :=
                                                    tbConcTmp( nuIdx ).conccoin;
                IC_BOCompletServiceInt_Gdca.tbConcepto( tbConcTmp( nuIdx ).conccodi ).concflde :=
                                                    tbConcTmp( nuIdx ).concflde;
                IC_BOCompletServiceInt_Gdca.tbConcepto( tbConcTmp( nuIdx ).conccodi ).concunme :=
                                                    tbConcTmp( nuIdx ).concunme;
                IC_BOCompletServiceInt_Gdca.tbConcepto( tbConcTmp( nuIdx ).conccodi ).concdefa :=
                                                    tbConcTmp( nuIdx ).concdefa;
                IC_BOCompletServiceInt_Gdca.tbConcepto( tbConcTmp( nuIdx ).conccodi ).concflim :=
                                                    tbConcTmp( nuIdx ).concflim;
                IC_BOCompletServiceInt_Gdca.tbConcepto( tbConcTmp( nuIdx ).conccodi ).concsigl :=
                                                    tbConcTmp( nuIdx ).concsigl;
                IC_BOCompletServiceInt_Gdca.tbConcepto( tbConcTmp( nuIdx ).conccodi ).conctico :=
                                                    tbConcTmp( nuIdx ).conctico;
                IC_BOCompletServiceInt_Gdca.tbConcepto( tbConcTmp( nuIdx ).conccodi ).concnive :=
                                                    tbConcTmp( nuIdx ).concnive;
                IC_BOCompletServiceInt_Gdca.tbConcepto( tbConcTmp( nuIdx ).conccodi ).concclco :=
                                                    tbConcTmp( nuIdx ).concclco;
                IC_BOCompletServiceInt_Gdca.tbConcepto( tbConcTmp( nuIdx ).conccodi ).concticc :=
                                                    tbConcTmp( nuIdx ).concticc;
                IC_BOCompletServiceInt_Gdca.tbConcepto( tbConcTmp( nuIdx ).conccodi ).concticl :=
                                                    tbConcTmp( nuIdx ).concticl;
                IC_BOCompletServiceInt_Gdca.tbConcepto( tbConcTmp( nuIdx ).conccodi ).concappr :=
                                                    tbConcTmp( nuIdx ).concappr;
                IC_BOCompletServiceInt_Gdca.tbConcepto( tbConcTmp( nuIdx ).conccodi ).rowid :=
                                                    tbConcTmp( nuIdx ).rowid;

                -- Actualiza el indice con la siguiente posicion de la tabla
                nuIdx := tbConcTmp.next( nuIdx );

            end loop;

        end loop;
        -- Cierra el cursor
        close rfConcepts;

        IC_BOCompletServiceInt_Gdca.boConceptLoaded := TRUE;

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
                IC_BOCompletServiceInt_Gdca.sbErrMsg
            );
            pkErrors.pop;
            raise_application_error
            (
                pkConstante.nuERROR_LEVEL2,
                IC_BOCompletServiceInt_Gdca.sbErrMsg
            );
    END LoadConcepts;


        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       :   ClearMemory
            Descripcion     :   Limpia la informacion en memoria

            Autor       :   Alejandro Rendon Gomez
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
            Creacion.
        */
        PROCEDURE ClearMemory
        IS
        BEGIN
            pkErrors.Push('IC_BOCompletServiceInt_Gdca.Process.ClearMemory');

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
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
        END ClearMemory;

        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       :   InsertSetOfRecords
            Descripcion     :   Crea los registros en la entidad IC_MOVIMIEN

            Autor       :   Alejandro Rendon Gomez
            Fecha       :   24-07-2012 17:24:41

            Historia de Modificaciones
            Fecha       IDEntrega

            24-07-2012  arendon.SAO185253
            Creacion.
        */
        PROCEDURE InsertSetOfRecords
        IS

        vsberrorED varchar2(4000);

        BEGIN

            pkErrors.Push('IC_BOCompletServiceInt_Gdca.Process.InsertSetOfRecords');

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
              vsberrorED := sqlerrm;
                pkErrors.NotifyError
                (
                    pkErrors.fsbLastObject,
                    sqlerrm,
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
        END InsertSetOfRecords;

        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       : FillTable
            Descripcion     : Arma el registro de movimientos en la tabla PL

            Parametros      :        Descripcion
                ircMovimien             Record con la informacion del
                                        movimiento a generar

            Autor    :  Alejandro Rendon Gomez
            Fecha    :  24-07-2012 16:53:04

            Historia de Modificaciones
            Fecha       IDEntrega

            17-07-2013  hlopez.SAO212472
            Se adiciona el atributo Clasificacion Contable del Contrato

            05-04-2013  arendon.SAO205719
            Se adiciona la asignacion del atributo MOVIITEM.

            09-10-2012  hlopez.SAO193548
            Se adiciona el campo MOVIBACO

            24-07-2012  arendon.SAO185253
            Creacion.
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
            pkErrors.Push('IC_BOCompletServiceInt_Gdca.Process.FillTable');

            -- Solamente procesa cuando se tiene valor diferente a cero.
            if (ircMovimien.movivalo <> pkBillConst.CERO OR
                ircMovimien.movivatr <> pkBillConst.CERO ) then

                -- Inicializa el siguiente indice a usar.
                sbInd := nvl(tbMov.movicons.last, 0) + 1;

                tbMov.movicons(sbInd) := pkGeneralServices.fnuGetNextSequenceVal('SQ_IC_MOVIMIEN_175553');
                tbMov.moviusua(sbInd) := IC_BOCompletServiceInt_Gdca.sbUserName;
                tbMov.moviterm(sbInd) := IC_BOCompletServiceInt_Gdca.sbTerminal;

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
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
        END FillTable;

        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       :   SelectInstallOrders
            Descripcion     :   Seleccion de las ordenes cuyo tipo de trabajo
                                corresponde a INSTALACION DEL SERVICIO

            Parametros
            Entrada         :       Descripcion
                idtDate                 Fecha de legalizacion de la orden
                inuThread               Hilo actual
                inuThreads              Total de hilos

            Salida          :       Descripcion
                otbOrdersPack               Tabla con las ordenes seleccionadas

            Autor       :   Alejandro Rendon Gomez
            Fecha       :   19-07-2012 15:50:57

            Historia de Modificaciones
            Fecha       IDEntrega


            24-04-2014  aesguerra.3487
            Se modifica sentencia para que ignore las ventas a constructoras, y para que todas las
			ordenes de una solicitud sean tomadas por el mismo hilo. Esto con el fin de evitar que
			se procede dos veces una solicitud.

            19-07-2012  arendon.SAO185253
            Creacion.
        */
        PROCEDURE SelectInstallOrders
        (
            idtDate     in  date,
            inuThread   in  number,
            inuThreads  in  number,
            otbProducts out tytbHicaesco
        )
        IS
            -------------------
            -- Variables
            -------------------
            -- Sentencia de seleccion de ordenes
            sbSentence  varchar2(2000);

            -- Indice para recorrer la tabla con los tipos de trabajo
            nuIdxTT     number;

            -- CURSOR de seleccion de ordenes
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
            pkErrors.Push('IC_BOCompletServiceInt_Gdca.Process.SelectInstallOrders');

            -- Fecha 1
            sbTmpDate1 := trunc(idtDate);

            -- Fecha 2
            sbTmpDate2 := trunc(idtDate+1);

            -- Arma la sentencia dinamicamente, seleccionando la primera solicitud
            -- que se encuentre.
            --<

            sbSentence :=	'SELECT Distinct hcecnuse '
							||'	FROM hicaesco '
							||'	WHERE hcececan = 96 '
							||'	AND hcececac   = 1 '
							||'	AND hcecserv   = 7014 '
							||'	AND hcecfech  >= :date1 '
							||' AND hcecfech  <  :date2 ';
            --  ||' AND hcecnuse = 17229545 ';
						--	||'	AND mod(hcecnuse, :nuThreads) + 1 = :nuThread'
            --  ||'	AND dapr_product.fnugetproduct_status_id (hcecnuse) = 1 ';

            -- Abre el cursor, obtiene los datos y lo cierra
            open rfOrders for sbSentence using sbTmpDate1, sbTmpDate2;
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
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
        END SelectInstallOrders;

        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       :   SelectInternalOrders
            Descripcion     :   Seleccion de las ORDENES DE APOYO que esten relacionadas con las
                                ordenes de INSTALACION DE LA INTERNA de las constructoras.

            Parametros
            Entrada         :       Descripcion
                idtDate                 Fecha de legalizacion de la orden
                inuThread               Hilo actual
                inuThreads              Total de hilos

            Salida          :       Descripcion
                otbOrdersPack               Tabla con las ordenes seleccionadas

            Autor       :   Edmundo E. Lara F.
            Fecha       :   04-12-2014

            Historia de Modificaciones
            Fecha       IDEntrega


        */
        PROCEDURE SelectInternalOrders
        (
            idtDate        in   date,
            inuThread      in   number,
            inuThreads     in   number,
            otbnusepack    out  tytpproducts
        )
        IS
            -------------------
            -- Variables
            -------------------
            -- Sentencia de seleccion de ordenes
            sbSentence  varchar2(2000);

            -- Indice para recorrer la tabla con los tipos de trabajo
            nuIdxTT     number;

            -- CURSOR de seleccion de ordenes
            rfOrders    constants.tyRefCursor;

            -- Fechas temporales
            sbTmpDate1  varchar2(100);
            sbTmpDate2  varchar2(100);
            sbTmpDate3  varchar2(100);
            sbTmpDate4  varchar2(100);

            VSBERRORED VARCHAR2(3000);
            -------------------
            -- Constantes
            -------------------
            -- Estado de orden CERRADO
            cnuSTATUS_CLOSED constant number := or_boconstants.cnuORDER_STAT_CLOSED;

        BEGIN
            pkErrors.Push('IC_BOCompletServiceInt.Process.SelectInternalOrders');

            -- Fecha 1
            sbTmpDate1 := trunc(idtDate);
            sbTmpDate3 := vdtInicial;
            sbTmpDate4 := vdtInicial;

            -- Fecha 2
            sbTmpDate2 := trunc(idtDate+1);

            -- Arma la sentencia dinamicamente, seleccionando la primera solicitud
            -- que se encuentre.

            sbSentence :=  'SELECT DISTINCT OR_order_activity.package_id,'  -- Solicitud
              ||'                  OR_order_activity.product_id,'           -- Producto, NUSE
              ||'                  OR_related_order.related_order_id,'      -- Ot de Apoyo
              ||'                  mo_packages.package_type_id'             -- Tipo Solicitud
              ||'  FROM open.OR_related_order, open.OR_order_activity, open.or_order, open.mo_packages'
              ||' WHERE OR_related_order.rela_order_type_id in (4, 13)' -- Tipo de Orden, de Apoyo o Relacionada
              ||'   AND OR_related_order.related_order_id = OR_order_activity.order_id'
              ||'   AND OR_order_activity.Status = ''F'''
              ||'   AND OR_order_activity.package_id = mo_packages.package_id'
              -- 10622 = Legalizacion Parcial de Interna Constructora Residencial
              -- 10624 = Legalizacion Parcial de Interna Constructora Comercial
              ||'   AND OR_order.task_type_id in (10622, 10624)'
              -- 323    = Constructoras, 100271 = Ventas Migradas
              ||'   AND mo_packages.package_type_id in (323, 100271)'
              ||'   AND OR_order.order_id = OR_related_order.related_order_id'
              ||'   AND OR_order.legalization_date >= :date1'
              ||'   AND OR_order.legalization_date <  :date2'
              ||'   AND OR_order.CAUSAL_ID IN (select c.causal_id from open.ge_causal c where c.class_causal_id = 1)'
              ||'   AND OR_order_activity.product_id not in (select act.product_id'
              ||'                                   from open.or_order_activity act, open.or_order oo'
              ||'                                  where act.product_id = OR_order_activity.product_id'
              ||'                                    and act.order_id = oo.order_id'
              ||'                                    and oo.task_type_id in (10622, 10624)'
              ||'                                    and oo.legalization_date < :date3)'
              ||'   AND OR_order_activity.product_id not in (SELECT distinct hcecnuse'
              ||'                                   FROM open.hicaesco h'
              ||'                                  WHERE hcececan = 96'
              ||'                                    AND hcececac = 1'
              ||'                                    AND hcecserv = 7014'
              ||'                                    AND hcecfech < :date4)';

              -- Prueba
              --||'   AND OR_order_activity.product_id =  50886560';
              --
            -- Abre el cursor, obtiene los datos y lo cierra
            open rfOrders for sbSentence using sbTmpDate1, sbTmpDate2, sbTmpDate3, sbTmpDate4;
              fetch rfOrders bulk collect INTO otbnusepack;
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
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
                pkErrors.pop;
                VSBERRORED := SQLERRM;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
        END SelectInternalOrders;

        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       :   GetDocNumbers
            Descripcion     :   Obtiene los documentos contables del dia

            Parametros
            Entrada         :       Descripcion
                idtDate                 Fecha

            Salida          :       Descripcion
                onuBillDoc              Documento de facturacion
                onuCertfDoc             Documento de actas

            Autor       :   Alejandro Rendon Gomez
            Fecha       :   23-07-2012 16:53:13

            Historia de Modificaciones
            Fecha       IDEntrega

            18-03-2014  arendon.SAO235707
            Se adiciona la obtencion de documento para Notas

            23-07-2012  arendon.SAO185253
            Creacion.
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
            pkErrors.Push('IC_BOCompletServiceInt_Gdca.Process.GetDocNumbers');

            /* Obtener Numero Documento de Facturacion */
            onuBillDoc:= pkBCIc_Docugene.fnuGetNumeDocByTido
                            (
                                cnuDOC_TYPE_BILL,
                                dtDate
                            );


            /* Obtener Numero Documento de Notas */
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
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
        END GetDocNumbers;

        /*
            Propiedad intelectual de Open International Systems. (c).

            Procedimiento :   GetAdditionalData
            Descripcion	  :   Obtiene informacion adicional.

            Autor	    :   Alejandro Rendon Gomez
            Fecha	    :   24-07-2012 16:14:41

            Historia de Modificaciones
            Fecha	    IDEntrega

            24-07-2012  arendon.SAO185253
            Creacion.
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
                'IC_BOCompletServiceInt_Gdca.Process.GetAdditionalData'
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

            Procedure	  :   fsbSignMov
            Descripcion	:   Obtiene el signo para un valor

            Parametros	:	Descripcion
                inuValor        Valor del cargo

            Retorno     :
                C -> Credito
                D -> Debito

            Autor	   :    Alejandro Rendon Gomez
            Fecha	   :    27-07-2012 17:29:23

            Historia de Modificaciones
            Fecha	ID Entrega
            Modificacion

            27-07-2012  arendon.SAO185253
            Creacion
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

            -- Se validan creditos
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
                oblDistrCargos          TRUE: Si el concepto aplica para la distribucion
                                        FALSE: Si el concepto no aplica para la distribucion

            Autor    :  Alejandro Rendon Gomez
            Fecha    :  24-07-2012 17:00:10

            Historia de Modificaciones
            Fecha       IDEntrega

            24-07-2012  arendon.SAO185253
            Creacion.
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
            pkErrors.Push('IC_BOCompletServiceInt_Gdca.Process.GetDistributionData');

            -- Inicializa las variables
            oblDistrCargos := FALSE;

            -- Si no tiene periodo de consumo, el cargo no se distribuye
            if ( inuCargpeco IS null ) then
                pkErrors.Pop;
                return;
            end if;

            -- Si no se han cargado los conceptos a memoria, se obtienen
            if ( not IC_BOCompletServiceInt_Gdca.boConceptLoaded ) then
                -- Carga de conceptos
                LoadConcepts;
            end if;


             -- Si el concepto existe en la tabla en memoria, se distribuye
            if ( IC_BOCompletServiceInt_Gdca.tbConcepto.exists( inuCargconc ) ) then

                -- Retorna verdadero en el flag de distribucion del cargo
                oblDistrCargos := TRUE;
                -- Retorna  el periodo de consumo del concepto
                rcPericose := pktblPericose.frcGetRecord(inuCargpeco);

                -- Evalua el tipo de cobro para usar la vigencia correspondiente
                if (IC_BOCompletServiceInt_Gdca.tbConcepto( inuCargconc ).concticc = pkConstante.csbABONO) then
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
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
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

            Autor    :  Alejandro Rendon Gomez
            Fecha    :  24-07-2012 17:09:05

            Historia de Modificaciones
            Fecha       IDEntrega

            24-07-2012  arendon.SAO185253
            Creacion.
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
            pkErrors.Push('IC_BOCompletServiceInt_Gdca.Process.CalculateDistrValue');

            -- Ultimo dia del mes de la fecha inicial
            dtUltimoDiaMes := last_day(trunc(idtPecsfein));

            -- Numero de dia del periodo de consumo
            nuTotalDias := trunc(idtPecsfefi) - trunc(idtPecsfein) + 1;

            -- Dias del periodo en mes 1
            nuDiasMes1 := dtUltimoDiaMes - trunc(idtPecsfein) + 1;

            -- Se evalua si el producto fue instalado despues de inicio periodo pero ANTES de fin de mes 1
            if
            (
                trunc( rcSesunuse.sesufein ) > trunc( idtPecsfein )
                AND
                trunc( rcSesunuse.sesufein ) <= trunc( dtUltimoDiaMes )
            )
            then

                -- Se ajusta numero dias periodo consumo
                nuTotalDias := nuTotalDias - ( trunc( rcSesunuse.sesufein ) - trunc( idtPecsfein ) );

                -- Se ajusta numero dias mes 1
                nuDiasMes1 := trunc( dtUltimoDiaMes ) - trunc( rcSesunuse.sesufein ) + 1;

            -- Se evalua si el producto fue instalado DESPUES de inicio periodo pero DESPUES de mes 1
            elsif
            (
                trunc( rcSesunuse.sesufein ) > trunc( idtPecsfein )
                AND
                trunc( rcSesunuse.sesufein ) > trunc( dtUltimoDiaMes )
            )
            then

                -- Se ajusta numero dias mes 1
                nuDiasMes1 := 0;

            end if;

            -- Se evalua si el producto fue retirado ANTES de fin de mes 1
            if( trunc( rcSesunuse.sesufere ) <= trunc( dtUltimoDiaMes ) ) then

                -- Se ajusta numero dias periodo consumo
                nuTotalDias := nuTotalDias - ( trunc( idtPecsfefi ) - trunc( rcSesunuse.sesufere ) );

                -- Se ajusta numero dias mes 1
                nuDiasMes1 := nuTotalDias;

            -- Se evalua si el producto fue retirado DESPUES de mes 1 pero ANTES de fin de periodo
            elsif
            (
                trunc( rcSesunuse.sesufere ) > trunc( dtUltimoDiaMes )
                AND
                trunc( rcSesunuse.sesufere ) < trunc( idtPecsfefi )
            )
            then

                -- Se ajusta numero dias periodo consumo
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
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
        END CalculateDistrValue;

        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       :   GetNitByConcept
            Descripcion     :   Obtiene el Nit del tercero por concepto

            Parametros
            Entrada         :       Descripcion
                inuService              Tipo de producto
                inuConcept              Concepto

            Salida          :       Descripcion
                osbNit                  Nit del tercero

            Autor       :   Alejandro Rendon Gomez
            Fecha       :   27-07-2012 15:09:42

            Historia de Modificaciones
            Fecha       Autor       Caso        Descripcion
            27-07-2012  arendon     SAO185253   Creacion.
            03-07-2025  jpinedc     OSF-4555    Se agrega inuDepartamento para
                                                obtener el nit de la empresa
        */
        PROCEDURE GetNitbyConcept
        (
            inuService      in      servempr.seemserv%type,
            inuConcept      in      concepto.conccodi%type,
            inuDepartamento in      ge_geogra_location.geograp_location_id%type,
            osbNit          out     ic_movimien.movinips%type
        )
        IS
            -- Registro de servicio pktblservicio
            rcServicio      servicio%rowtype;
        BEGIN
            pkErrors.Push('IC_BOCompletServiceInt_Gdca.Process.GetNitbyConcept');

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

                else

                    -- Nit de la empreas
                    osbNit :=  pkg_Empresa.fsbObtNitEmpresa( pkg_Empresa.fsbObtEmpresaDepartamento( inuDepartamento ) );

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
                                el mes y a?o correspondiente

            Parametros      :       Descripcion
                idtDate                 Fecha de contabilizacion
                inuDocNumber            Numero del documento contable
                inuCycle                Ciclo de facturacion
                inuBussUnit             Unidad de negocio
                inuServ                 Tipo de producto
                inuCateg                Categoria
                inuSubcat               Subcategoria
                inuConcept              Concepto
                inuCausCarg             Causa del cargo
                isbExpCenter            Centro de costos
                isbNit                  Identificacion del cliente
                inuValue                Valor
                inuBaseValue            Valor base de impuesto
                inuUnits                Unidades
                inuCucosist             Empresa prestadora del servicio
                inuSuscsist             Empresa propietaria factura
                isbTipoDir              Tipo de direccion
                inuUbiGeogr1            Ubicacion geografica 1
                inuUbiGeogr2            Ubicacion geografica 2
                inuCargpeco             Periodo de consumo
                idtmovifeve             Fecha de vencimiento
                inumovivatr             Valor total producto retirado
                inuServsusc             Producto
                inuTipodoco             Tipo de documento

            Autor    :  Alejandro Rendon Gomez
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
            Creacion.
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
            inuDepartam     in  tmp_cargproc.cargdepa%type,
            inulocalidad    in  tmp_cargproc.cargloca%type,
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

            -- Identificacion del cliente
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

            pkErrors.Push('IC_BOCompletServiceInt_Gdca.Process.ChargesDistribution');

            --<<
            -- Dcardona
            -- 12-12-2014
            -- Se verifica el tipo de Hecho economico
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
                inuDepartam,
                sbNitTerc
            );

            -- Se inicializa el record para el manejo de la informacion del movimiento
            rcMovimiento.movifeco := trunc( idtDate );
            rcMovimiento.movitihe := vaMoviTiHe; --csbTIHE_COMPL_SERV;
            rcMovimiento.moviinpr := pkConstante.NO;

            rcMovimiento.movicicl := inuCycle;
            rcMovimiento.moviempr := inuBussUnit;
            rcMovimiento.moviserv := inuServ;
            rcMovimiento.movicate := inuCateg;
            rcMovimiento.movisuca := inuSubcat;
            rcMovimiento.moviconc := inuConcept;
            rcMovimiento.movicaca := inuCausCarg;
            rcMovimiento.moviubg2 := inuDepartam;
            rcMovimiento.moviubg3 := inulocalidad;
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


            /* Nivel Geografico 1 */
            if  IC_BOCompletServiceInt_Gdca.sbLOCBAR1 = pkConstante.SI then
                rcMovimiento.moviubg1 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                            (
                                                inuUbiGeogr1,
                                                IC_BOCompletServiceInt_Gdca.nuNivelUbge1
                                            );
            else
                rcMovimiento.moviubg1 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                            (
                                                inuUbiGeogr2,
                                                IC_BOCompletServiceInt_Gdca.nuNivelUbge1
                                            );
            end if;

            /* Nivel Geografico 2 */
/*
-- CA-730
            if  IC_BOCompletServiceInt_Gdca.sbLOCBAR2 = pkConstante.SI then
                rcMovimiento.moviubg2 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                            (
                                                inuUbiGeogr1,
                                                IC_BOCompletServiceInt_Gdca.nuNivelUbge2
                                            );
            else
                rcMovimiento.moviubg2 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                            (
                                                inuUbiGeogr2,
                                                IC_BOCompletServiceInt_Gdca.nuNivelUbge2
                                            );
            end if;
*/
            /* Nivel Geografico 3 */
/*
-- CA-730
            if  IC_BOCompletServiceInt_Gdca.sbLOCBAR3 = pkConstante.SI then
                rcMovimiento.moviubg3 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                            (
                                                inuUbiGeogr1,
                                                IC_BOCompletServiceInt_Gdca.nuNivelUbge3
                                            );
            else
                rcMovimiento.moviubg3 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                            (
                                                inuUbiGeogr2,
                                                IC_BOCompletServiceInt_Gdca.nuNivelUbge3
                                            );
            end if;
*/
            /* Nivel Geografico 4 */
            if  IC_BOCompletServiceInt_Gdca.sbLOCBAR4 = pkConstante.SI then
                rcMovimiento.moviubg4 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                            (
                                                inuUbiGeogr1,
                                                IC_BOCompletServiceInt_Gdca.nuNivelUbge4
                                            );
            else
                rcMovimiento.moviubg4 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                            (
                                                inuUbiGeogr2,
                                                IC_BOCompletServiceInt_Gdca.nuNivelUbge4
                                            );
            end if;

            /* Nivel Geografico 5 */
            if  IC_BOCompletServiceInt_Gdca.sbLOCBAR5 = pkConstante.SI then
                rcMovimiento.moviubg5 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                            (
                                                inuUbiGeogr1,
                                                IC_BOCompletServiceInt_Gdca.nuNivelUbge5
                                            );
            else
                rcMovimiento.moviubg5 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                            (
                                                inuUbiGeogr2,
                                                IC_BOCompletServiceInt_Gdca.nuNivelUbge5
                                            );
            end if;

            /* Si el movimiento es de facturacion */
            if ( inuTipodoco = cnuDOC_TYPE_BILL ) then

                /* Asigna datos del movimiento */
                rcMovimiento.movinudo := inuDocNumbBill;
                rcMovimiento.movitido := cnuDOC_TYPE_BILL;
                rcMovimiento.movitimo := cnuMOVE_TYPE_BILL;

                /* Obtiene los datos para la distribucion */
                GetDistributionData(
                                    inuConcept,
                                    inuCargpeco,
                                    dtPecsfein,
                                    dtPecsfefi,
                                    blDistrCargos
                                   );


                if (blDistrCargos) then

                    /* Verifica si el producto que se esta procesando ya cambio */
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
                        /* Si ya cambio:
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
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
        END ChargesDistribution;

        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       :   ProcessOrderWithCertf
            Descripcion     :   Procesa las ordenes incluidas en un acta

            Parametros
            Entrada         :       Descripcion
                inuOrderId              Codigo de la orden
                ircCertificate          Registro del acta
                inuDocNumber            Documento contable
                idtDate                 Fecha de contabilizacion

            Autor       :   Alejandro Rendon Gomez
            Fecha       :   27-07-2012 10:44:23

            Historia de Modificaciones
            Fecha       IDEntrega

            17-07-2013  hlopez.SAO212472
            Se adiciona el atributo Clasificacion Contable del Contrato

            05-04-2013  arendon.SAO205719
            Se adiciona la asignacion del atributo MOVIITEM.

            10-10-2012  arendon.SAO193603
            Se procesa correctamente los atributos de ubicacion geografica

            27-07-2012  arendon.SAO185253
            Creacion.
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
            pkErrors.Push('IC_BOCompletServiceInt_Gdca.Process.ProcessOrderWithCertf');

            -- Se obtienen los movimientos a generar del modelo actas de
            -- liquidacion
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
                -- Condicion de salida
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

                -- Ubicaciones geograficas
                if ( tbCertfMovs( nuIdxCert ).geograp_location_id IS not null ) then

                    -- Nivel Geografico 1
                    if  IC_BOCompletServiceInt_Gdca.sbLOCBAR1 = pkConstante.SI then
                        rcMovimien.moviubg1 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).geograp_location_id,
                                                        IC_BOCompletServiceInt_Gdca.nuNivelUbge1
                                                    );
                    else
                        rcMovimien.moviubg1 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).neighborthood_id,
                                                        IC_BOCompletServiceInt_Gdca.nuNivelUbge1
                                                    );
                    end if;

                    -- Nivel Geografico 2
                    if  IC_BOCompletServiceInt_Gdca.sbLOCBAR2 = pkConstante.SI then
                        rcMovimien.moviubg2 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).geograp_location_id,
                                                        IC_BOCompletServiceInt_Gdca.nuNivelUbge2
                                                    );
                    else
                        rcMovimien.moviubg2 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).neighborthood_id,
                                                        IC_BOCompletServiceInt_Gdca.nuNivelUbge2
                                                    );
                    end if;

                    -- Nivel Geografico 3
                    if  IC_BOCompletServiceInt_Gdca.sbLOCBAR3 = pkConstante.SI then
                        rcMovimien.moviubg3 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).geograp_location_id,
                                                        IC_BOCompletServiceInt_Gdca.nuNivelUbge3
                                                    );
                    else
                        rcMovimien.moviubg3 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).neighborthood_id,
                                                        IC_BOCompletServiceInt_Gdca.nuNivelUbge3
                                                    );
                    end if;

                    -- Nivel Geografico 4
                    if  IC_BOCompletServiceInt_Gdca.sbLOCBAR4 = pkConstante.SI then
                        rcMovimien.moviubg4 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).geograp_location_id,
                                                        IC_BOCompletServiceInt_Gdca.nuNivelUbge4
                                                    );
                    else
                        rcMovimien.moviubg4 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).neighborthood_id,
                                                        IC_BOCompletServiceInt_Gdca.nuNivelUbge4
                                                    );
                    end if;

                    -- Nivel Geografico 5
                    if  IC_BOCompletServiceInt_Gdca.sbLOCBAR5 = pkConstante.SI then
                        rcMovimien.moviubg5 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).geograp_location_id,
                                                        IC_BOCompletServiceInt_Gdca.nuNivelUbge5
                                                    );
                    else
                        rcMovimien.moviubg5 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).neighborthood_id,
                                                        IC_BOCompletServiceInt_Gdca.nuNivelUbge5
                                                    );
                    end if;

                end if;

                -- Crea el movimiento
                FillTable( rcMovimien );

                -- Actualiza el indice con la siguiente posicion de la tabla
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
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
        END ProcessOrderWithCertf;


        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       :   ProcessItemsWithoutCertf
            Descripcion     :   Procesa los items que no salen en las actas

            Parametros
            Entrada         :       Descripcion
                inuOrderId              Codigo de la orden
                ircCertificate          Registro del acta
                inuDocNumber            Documento contable
                idtDate                 Fecha de contabilizacion

            Autor       :   Hery J Lopez R
            Fecha       :   17-07-2013 18:00:00

            Historia de Modificaciones
            Fecha       IDEntrega

            23-07-2013  hlopez.SAO212970
            Se modifica la forma de obtener el atributo Clasificacion COntable
            del Contrato

            17-07-2013  hlopez.SAO212472
            Creacion.
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
            pkErrors.Push('IC_BOCompletServiceInt_Gdca.Process.ProcessItemsWithoutCertf');

            -- Se obtienen los movimientos a generar del modelo actas de
            -- liquidacion
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
                -- Condicion de salida
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

                -- Ubicaciones geograficas
                if ( tbCertfMovs( nuIdxCert ).geograp_location_id IS not null ) then

                    -- Nivel Geografico 1
                    if  IC_BOCompletServiceInt_Gdca.sbLOCBAR1 = pkConstante.SI then
                        rcMovimien.moviubg1 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).geograp_location_id,
                                                        IC_BOCompletServiceInt_Gdca.nuNivelUbge1
                                                    );
                    else
                        rcMovimien.moviubg1 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).neighborthood_id,
                                                        IC_BOCompletServiceInt_Gdca.nuNivelUbge1
                                                    );
                    end if;

                    -- Nivel Geografico 2
                    if  IC_BOCompletServiceInt_Gdca.sbLOCBAR2 = pkConstante.SI then
                        rcMovimien.moviubg2 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).geograp_location_id,
                                                        IC_BOCompletServiceInt_Gdca.nuNivelUbge2
                                                    );
                    else
                        rcMovimien.moviubg2 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).neighborthood_id,
                                                        IC_BOCompletServiceInt_Gdca.nuNivelUbge2
                                                    );
                    end if;

                    -- Nivel Geografico 3
                    if  IC_BOCompletServiceInt_Gdca.sbLOCBAR3 = pkConstante.SI then
                        rcMovimien.moviubg3 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).geograp_location_id,
                                                        IC_BOCompletServiceInt_Gdca.nuNivelUbge3
                                                    );
                    else
                        rcMovimien.moviubg3 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).neighborthood_id,
                                                        IC_BOCompletServiceInt_Gdca.nuNivelUbge3
                                                    );
                    end if;

                    -- Nivel Geografico 4
                    if  IC_BOCompletServiceInt_Gdca.sbLOCBAR4 = pkConstante.SI then
                        rcMovimien.moviubg4 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).geograp_location_id,
                                                        IC_BOCompletServiceInt_Gdca.nuNivelUbge4
                                                    );
                    else
                        rcMovimien.moviubg4 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).neighborthood_id,
                                                        IC_BOCompletServiceInt_Gdca.nuNivelUbge4
                                                    );
                    end if;

                    -- Nivel Geografico 5
                    if  IC_BOCompletServiceInt_Gdca.sbLOCBAR5 = pkConstante.SI then
                        rcMovimien.moviubg5 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).geograp_location_id,
                                                        IC_BOCompletServiceInt_Gdca.nuNivelUbge5
                                                    );
                    else
                        rcMovimien.moviubg5 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbCertfMovs( nuIdxCert ).neighborthood_id,
                                                        IC_BOCompletServiceInt_Gdca.nuNivelUbge5
                                                    );
                    end if;

                end if;

                -- Crea el movimiento
                FillTable( rcMovimien );

                -- Actualiza el indice con la siguiente posicion de la tabla
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
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
        END ProcessItemsWithoutCertf;

         /*
            Propiedad intelectual de Open Systems (c).
            Procedure       :   ProcessOrderWithoutCertf
            Descripcion     :   Procesa las ordenes no incluidas en un acta

            Parametros
            Entrada         :       Descripcion
                inuOrderId              Codigo de la orden
                inuDocNumber            Documento contable
                idtDate                 Fecha de contabilizacion

            Autor       :   Alejandro Rendon Gomez
            Fecha       :   27-07-2012 10:44:23

            Historia de Modificaciones
            Fecha       IDEntrega

            17-07-2013  hlopez.SAO212472
            Se adiciona el atributo Clasificacion Contable del Contrato

            10-10-2012  arendon.SAO193603
            Se procesa correctamente los atributos de ubicacion geografica

            27-07-2012  arendon.SAO185253
            Creacion.
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
            -- Tabla con los movimientos de ordenes
            tbOrdersMovs     IC_BCCompletServiceInt.tytbCertfMovs;

            -- Indice para recorrer la tabla de movimientos
            nuIdxOrder       number;

            -- Registro de ic_movimien
            rcMovimien      ic_movimien%rowtype;
        BEGIN
            pkErrors.Push('IC_BOCompletServiceInt_Gdca.Process.ProcessOrderWithoutCertf');

            -- Se obtienen los movimientos a generar del modelo actas de
            -- liquidacion
            IC_BCCompletServiceInt.GetOrdersMovs
            (
                inuOrderId,
                tbOrdersMovs
            );

            -- Itera por cada registros encontrado para crear los movimientos
            -- respectivos.
            nuIdxOrder := tbOrdersMovs.first;

            loop
                -- Condicion de salida
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

                -- Ubicaciones geograficas
                if ( tbOrdersMovs( nuIdxOrder ).geograp_location_id IS not null ) then

                    -- Nivel Geografico 1
                    if  IC_BOCompletServiceInt_Gdca.sbLOCBAR1 = pkConstante.SI then
                        rcMovimien.moviubg1 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbOrdersMovs( nuIdxOrder ).geograp_location_id,
                                                        IC_BOCompletServiceInt_Gdca.nuNivelUbge1
                                                    );
                    else
                        rcMovimien.moviubg1 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbOrdersMovs( nuIdxOrder ).neighborthood_id,
                                                        IC_BOCompletServiceInt_Gdca.nuNivelUbge1
                                                    );
                    end if;

                    -- Nivel Geografico 2
                    if  IC_BOCompletServiceInt_Gdca.sbLOCBAR2 = pkConstante.SI then
                        rcMovimien.moviubg2 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbOrdersMovs( nuIdxOrder ).geograp_location_id,
                                                        IC_BOCompletServiceInt_Gdca.nuNivelUbge2
                                                    );
                    else
                        rcMovimien.moviubg2 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbOrdersMovs( nuIdxOrder ).neighborthood_id,
                                                        IC_BOCompletServiceInt_Gdca.nuNivelUbge2
                                                    );
                    end if;

                    -- Nivel Geografico 3
                    if  IC_BOCompletServiceInt_Gdca.sbLOCBAR3 = pkConstante.SI then
                        rcMovimien.moviubg3 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbOrdersMovs( nuIdxOrder ).geograp_location_id,
                                                        IC_BOCompletServiceInt_Gdca.nuNivelUbge3
                                                    );
                    else
                        rcMovimien.moviubg3 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbOrdersMovs( nuIdxOrder ).neighborthood_id,
                                                        IC_BOCompletServiceInt_Gdca.nuNivelUbge3
                                                    );
                    end if;

                    -- Nivel Geografico 4
                    if  IC_BOCompletServiceInt_Gdca.sbLOCBAR4 = pkConstante.SI then
                        rcMovimien.moviubg4 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbOrdersMovs( nuIdxOrder ).geograp_location_id,
                                                        IC_BOCompletServiceInt_Gdca.nuNivelUbge4
                                                    );
                    else
                        rcMovimien.moviubg4 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbOrdersMovs( nuIdxOrder ).neighborthood_id,
                                                        IC_BOCompletServiceInt_Gdca.nuNivelUbge4
                                                    );
                    end if;

                    -- Nivel Geografico 5
                    if  IC_BOCompletServiceInt_Gdca.sbLOCBAR5 = pkConstante.SI then
                        rcMovimien.moviubg5 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbOrdersMovs( nuIdxOrder ).geograp_location_id,
                                                        IC_BOCompletServiceInt_Gdca.nuNivelUbge5
                                                    );
                    else
                        rcMovimien.moviubg5 := GE_BCGeogra_Location.fnuGetFirstUpperLevel
                                                    (
                                                        tbOrdersMovs( nuIdxOrder ).neighborthood_id,
                                                        IC_BOCompletServiceInt_Gdca.nuNivelUbge5
                                                    );
                    end if;

                end if;

                -- Crea el movimiento
                FillTable( rcMovimien );

                -- Actualiza el indice con la siguiente posicion de la tabla
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
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
        END ProcessOrderWithoutCertf;

        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       :   ProcessOrders
            Descripcion     :   Procesa los movimientos de ordenes asociadas
                                a la orden de instalacion

            Parametros
            Entrada         :       Descripcion
                inuOrderId              Codigo de la orden de instalacion actual
                inuPackageId            Codigo de la solicitud de instalacion
                inuDocNumber            Numero del documento contable
                idtDate                 Fecha de contabilizacion

            Autor       :   Alejandro Rendon Gomez
            Fecha       :   19-07-2012 11:00:43

            Historia de Modificaciones
            Fecha       IDEntrega

            17-07-2013  hlopez.SAO212472
            Se adiciona el llamado al metodo <ProcessItemsWithoutCertf>

            10-10-2012  arendon.SAO193603
            Se corrige inicializacion del indice para recorrer la tabla de
            ordenes.
            Se corrige el llamado a <ProcessOrderWithCertf> y
            <ProcessOrderWithoutCertf> para enviar el codigo de la orden actual
            y no la orden inicial (orden de instalacion)

            19-07-2012  arendon.SAO185253
            Creacion.
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
            -- Ordenes
            tbOrdersPack    daor_order.tytbOR_order;

            -- Indice para recorrer la tabla
            nuIdxOrders     number;

            -- CURSOR con las ordenes seleccionadas
            rfOrders        constants.tyRefCursor;

            -- Registro de Ge_acta
            rcCertificate   ge_acta%rowtype;

        BEGIN
            pkErrors.Push('IC_BOCompletServiceInt_Gdca.Process.ProcessOrders');

            -- Reinicia la tabla de ordenes
            tbOrdersPack.delete;

            -- Obtiene todas las ordenes asociadas a la solicitud
            rfOrders := OR_BCOrderActivities.frfGetOrdersByPackage( inuPackageId );

            fetch   rfOrders
            bulk    collect
            into    tbOrdersPack;

            nuIdxOrders := tbOrdersPack.first;

            loop
                -- Condicion de salida
                exit when nuIdxOrders IS null;

                -- Se deben procesar las ordenes diferentes a la orden de
                -- instalacion, es decir la orden actual
                if( inuOrderId <> tbOrdersPack( nuIdxOrders ).order_id ) then

                    -- Obtiene la informacion del acta de liquidacion si existe
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

                -- Actualiza el indice con la siguiente posicion de la tabla
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
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
        END ProcessOrders;

        /**********************************************************************
        	Propiedad intelectual de OPEN International Systems
        	Nombre              fblProcessTaxes

        	Autor				Andres Felipe Esguerra Restrepo

        	Fecha               19-may-2014

        	Descripcion         Procesa el IVA para un producto creado en una venta constructora

        	***Parametros***
        	Nombre				Descripcion
        	inuOrderId1         ID de una de las ordenes de cargo por conexion o red interna
        	inuOrderId2         ID de una de las ordenes de cargo por conexion o red interna
        	inuCucocodi         Cuenta de cobro a procesar
        	orcTax              Registro de Cargos con informacion del IVA correspondiente

        	***Historia de Modificaciones***
        	Fecha Modificacion				Autor
        	20-05-2014                      aesguerra.3605
        ***********************************************************************/
        FUNCTION fblProcessTaxes(
			inuOrderId1 in	OR_order.order_id%type,
            inuOrderId2 in	OR_order.order_id%type,
            inuCucocodi in	cuencobr.cucocodi%type,
            orcTax      out cargos%rowtype
		) RETURN boolean IS

	        tbCharges		IC_BCCompletServiceInt.tytbCharges;

	        tbTaxes			IC_BCCompletServiceInt.tytbCharges;

	        rcTax			cargos%rowtype;

	        nuIdxTaxes      number;

	        --cnuConConc		constant concepto.conccodi%type := 30;
	        cnuTaxConc		constant concepto.conccodi%type := 287;

	        nuAdd           number := 0;

	        blPassed        boolean := FALSE;

        BEGIN

		pkErrors.Push('IC_BOCompletServiceInt_Gdca.Process.fblProcessTaxes');

		/*Se carga en memoria todos los cargos por conexion de la cuenta de cobro*/
		tbCharges := IC_BCCompletServiceInt.ftbGetChargesByBillBase(cnuTaxConc,inuCucocodi);

		/*Se carga en memoria todos los cargos de IVA de la cuenta de cobro*/
		tbTaxes := IC_BCCompletServiceInt.ftbGetChargesByBilltax(cnuTaxConc,inuCucocodi);

		/*Si ambas tablas tienen datos se procede*/
		if tbCharges.count > 0 AND tbTaxes.count > 0 then

		    /*Se inicializa indice para IVA*/
		    nuIdxTaxes := tbTaxes.first;

		    /*Para cada cargo por conexion*/
			FOR nuIdxCharges IN tbCharges.first..tbCharges.last LOOP

				/*Si no se ha procesado el cargo del producto actual y el cargo por conexion iterado
				corresponde a dicho producto, se marca el flag de que ya se encontro*/
				if (not blPassed AND tbCharges(nuIdxCharges).cargcodo in (inuOrderId1,inuOrderId2)) then

				    blPassed := TRUE;

				END if;

				/*Se acumula el valor del cargo por conexion*/
				nuAdd := nuAdd + tbCharges(nuIdxCharges).cargvalo;

				/*Si el acumulado corresponde al valor base del IVA iterado*/
				if nuAdd = tbTaxes(nuIdxTaxes).cargvabl then

					/*Si ya se itero el cargo por conexion del producto actual, se obtiene el valor
					de IVA que le corresponde*/
				    if blPassed then

				        rcTax := tbTaxes(nuIdxTaxes);

				        /*Si el cargo por conexion iterado es solo una porcion del IVA iterado, se obtiene la proporcion
						que le corresponde*/
				        if tbCharges(nuIdxCharges).cargvalo != rcTax.cargvabl then

				            /*El valor base a reportar es igual al valor del cargo por conexion*/
						    rcTax.cargvabl := tbCharges(nuIdxCharges).cargvalo;

						    /*El valor del IVA a reportar es proporcional a la relacion
							entre el valor de cargo por conexion y el valor base inicial*/
						    rcTax.cargvalo := tbTaxes(nuIdxTaxes).cargvalo * (rcTax.cargvabl / tbTaxes(nuIdxTaxes).cargvabl);

						    fa_bopoliticaredondeo.aplicapoliticaempr(99,rcTax.cargvalo);

						END if;

						exit;

				    END if;

				    /*Se reinicia el acumulador de cargo por conexion*/
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
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );

        END fblProcessTaxes;


        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       :   ProcessBill_Gdca
            Descripcion     :   Procesa la informacion de la factura creando los
                                movimientos respectivos

            Parametros
            Entrada         :       Descripcion
                inuFactcodi             Factura
                inuFactsusc             Suscripcion
                inuCiclcodi             Ciclo de facturacion
                inuCiclsist             Empresa propietaria del ciclo
                inuPackageId            Solicitud de venta
                inuProductId            Producto iterado

            Autor       :   Edmundo Lara
            Fecha       :   15-12-2016

            Historia de Modificaciones
            Fecha       IDEntrega

            24-05-2014  aesguerra.3605
            Se a?ade la logica para soportar ventas constructoras:
				- Obtiene unicamente los cargos asociados a las ordenes de instalacion de interna
				    y cargo por conexion
				- Soporta varias facturas por solicitud
				- Se incluye logica para identificar el IVA correspondiente al producto iterado
				- Se a?ade como parametro la solicitud de venta y el producto

            24-07-2012  arendon.SAO185253
            Creacion.
        */

        PROCEDURE ProcessBill_Gdca
        (
            inuPackageId    in  mo_packages.package_type_id%type,
            inurelatedorder in  OR_related_order.related_order_id%type,
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
            -- Identificadores de suscripcion
            tbSuscnitc      DAGE_Subscriber.tytbIdentification;
            -- Categorias
            tbCucocate      pktblCuencobr.tyCucocate;
            -- Subcategorias
            tbCucosuca      pktblCuencobr.tyCucosuca;
            -- Empresas de suscripcion
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

            nuOrderId1	OR_order.order_id%type;
            nuOrderId2	OR_order.order_id%type;

            rfOrders        constants.tyRefCursor;

            nuPackTypeId    mo_packages.package_type_id%type;

            blHasTax        boolean;
            rcTax           cargos%rowtype;

            -- Contador de movimientos
            nuMovs          number := 1;

        BEGIN
            pkErrors.Push
            (
                'IC_BOCompletServiceInt_Gdca.Process.ProcessBill_Gdca'
            );

            TraceInsertion('IC_BOCompletServiceInt.Process.ProcessBill_Gdca', inuProductId);

            tbCucocodi.delete;
            tbSuscceco.delete;
            tbSuscsist.delete;
            tbSuscnitc.delete;
            tbCucocate.delete;
            tbCucosuca.delete;
            tbCuconuse.delete;

            nuPackTypeId := damo_packages.fnugetpackage_type_id(inuPackageId);

            if nuPackTypeId = cnuConstructorPackTypeId then

               --<
               -- Edmundo E. Lara F.
               -- Si son ordenes de apoyo de la interna de constructoras, se hace
               -- 24/01/2015
               -->

                IC_BOCompletServiceInt_Gdca.TemprInsertConstAccCharges
                (
                    vdtFinal,
                    inuThreads,
                    inuThread
                );

            END if;

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
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
        END ProcessBill_Gdca;



        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       :   ProcessNotes
            Descripcion     :   Procesa la informacion de las notas asociadas
                                a la factura

            Parametros
            Entrada         :       Descripcion
                inuFactcodi             Factura
                inuFactsusc             Suscripcion
                inuCiclcodi             Ciclo de facturacion
                inuCiclsist             Empresa propietaria del ciclo

            Autor       :   Alejandro Rendon Gomez
            Fecha       :   18-03-2014 14:38:06

            Historia de Modificaciones
            Fecha       IDEntrega

            19-03-2014  aesguerra.3605
            Se modifica para que no haga nada en ventas constructoras

            18-03-2014  arendon.SAO235707
            Creacion.
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
            /* Identificadores de suscripcion */
            tbSuscnitc      DAGE_Subscriber.tytbIdentification;
            /* Empresas de suscripcion */
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
                'IC_BOCompletServiceInt_Gdca.Process.ProcessNotes'
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

            -- Se evalua si se obtuvieron facturas
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
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
        END ProcessNotes;

        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       :   ProcessCharges
            Descripcion     :   Procesa los movimientos de facturacion asociados
                                a la orden de instalacion

            Parametros
            Entrada         :       Descripcion
                inuPackageId            Codigo de la solicitud de instalacion

            Autor       :   Alejandro Rendon Gomez
            Fecha       :   19-07-2012 11:02:57

            Historia de Modificaciones
            Fecha       IDEntrega

            18-03-2014  arendon.SAO235707
            Se adiciona el procesamiento de las notas vinculadas a la factura.

            19-07-2012  arendon.SAO185253
            Creacion.
        */
        PROCEDURE ProcessCharges
        (
            inuPackageId    in  OR_order_activity.package_id%type,
            inurelatedorder in  OR_related_order.related_order_id%type,
            inuProductId    in  OR_order_activity.product_id%type
        )
        IS
            -------------------
            -- Colecciones
            -------------------
            -- Factura
            nuFactcodi      factura.factcodi%type;

            -- Suscripcion
            nuFactsusc      factura.factsusc%type;

            -- Ciclo de facturacion
            nuCiclcodi      ciclo.ciclcodi%type;

            tbBills         IC_BCCompletServiceInt.tytbBills;

        BEGIN

            pkErrors.Push('IC_BOCompletServiceInt_Gdca.Process.ProcessCharges');

            TraceInsertion('IC_BOCompletServiceInt_Gdca.Process.ProcessCharges['||inuPackageId||']', inuProductId);

            -- Se obtienen las facturas
            IC_BCCompletServiceInt.GetBillByPackage
            (
                inuPackageId,
                tbBills
            );

            -- Se evalua si se obtuvo factura
            if not (tbBills.count > 0) then
                return;
            end if;

            FOR n IN tbBills.first..tbBills.last LOOP

            	/* Procesa los cargos de facturacion */
	            ProcessBill_GDCA
	            (
                  inuPackageId,
                  inurelatedorder,
                  inuProductId
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
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
        END ProcessCharges;

        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       :   CreateBillMovs
            Descripcion     :   Crea los hechos economicos de facturacion

            Parametros
            Entrada         :       Descripcion
                idtDate                 Fecha de contabilizacion
                inuDocNumbBill          Numero del documento Facturacion
                inuDocNumbBill          Numero del documento Notas

            Autor       :   Alejandro Rendon Gomez
            Fecha       :   26-07-2012 15:43:32

            Historia de Modificaciones
            Fecha       IDEntrega

            18-03-2014  arendon.SAO235707
            Se adiciona el reporte de los movimientos de notas

            26-07-2012  arendon.SAO185253
            Creacion.
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
            tbrcCargos      IC_BOCompletServiceInt_Gdca.tytbChargesMovs;

            -- Cargo temporal
            rcCargo         IC_BOCompletServiceInt_Gdca.tyrcChargesMovs;

        BEGIN
            pkErrors.Push('IC_BOCompletServiceInt_Gdca.Process.CreateBillMovs');

            -- Se limpia memoria
            tbrcCargos.delete;
            rcSesunuse := null;

            -- Se obtienen los cargos temporales
            IC_BOCompletServiceInt_Gdca.GetTmpCharges
            (
                tbrcCargos
            );

            -- Se evalua que hayan datos para procesar
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
                    rcCargo.cargdepa,
                    rcCargo.cargloca,
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
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
   END CreateBillMovs;

        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       :   Process_ServCump
            Descripcion     :   Procesa el cargo por conexion de los servicios cumplidos
                                en el mes.

            Parametros


            Autor       :   Edmundo Lara
            Fecha       :   12-12-2014

            Historia de Modificaciones
            Fecha       ID_Entrega
            24/09/2019  CA-000149
                        Se cambia la logica de los servicios cumplidos para reportar por orden
                        legalizada.

        */

    PROCEDURE Process_ServCump
    IS

    vsbctrl varchar2(1);

    begin
            -- Reinicia las tablas en memoria
            ClearMemory;

            -- Obtiene los documentos contables del dia.
            GetDocNumbers
            (
                dtCurrentDate,
                nuBillDocNumber,
                nuCertfDocNumber,
                nuNoteDocNumber
            );

            -- Obtiene el servicio cumplido migrado
            TemprInsertMigraCharges
            (
                dtCurrentDate,
                inuThreads,
                inuThread
            );

            -- Obtiene el servicio cumplido constructoras
            TemprInsertConstAccCharges
            (
                dtCurrentDate,
                inuThreads,
                inuThread
            );

            --
            --if sql%rowcount > 0 then
	            -- Crea los registros de facturacion
	            CreateBillMovs
	            (
	                dtCurrentDate,
	                nuBillDocNumber,
	                nuNoteDocNumber
	            );

	            -- Se insertan los registros en la tabla de movimientos
	            InsertSetOfRecords;

            --END if;

            -- Actualiza el control de concurrencia del dia a procesado
            IC_BOCompletServiceInt_Gdca.FinalizeConcurrenceCtrl( dtCurrentDate );

            -- Asienta la transaccion por dia.
            pkGeneralServices.CommitTransaction;


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
                IC_BOCompletServiceInt_Gdca.sbErrMsg
            );
            pkErrors.pop;
            raise_application_error
            (
                pkConstante.nuERROR_LEVEL2,
                IC_BOCompletServiceInt_Gdca.sbErrMsg
            );
    END Process_ServCump;

    --<<
    -- Proceso principal PROCESS
    -->>

    BEGIN
        pkErrors.Push('IC_BOCompletServiceInt_Gdca.Process');

        -- Incializa las variables del proceso
        Initialize;
        -- Inicializa la fecha de proceso con la fecha inicial
        dtCurrentDate := idtInitialDate;
        -- Fijamos la fecha inicial y final
        vdtInicial    := idtInitialDate;
        vdtFinal      := idtFinalDate;

        dtCurrentDate := idtInitialDate;
        --
        IC_BOCompletServiceInt_Gdca.boInternalLoaded := FALSE;

        -- Itera por cada dia en el rango de fechas
        loop
            exit when dtCurrentDate > idtFinalDate;
            -- Procesamos Servicios Cumplidos en el mes..
            Process_ServCump;
            -- Actualiza el dia
            dtCurrentDate := dtCurrentDate + 1;
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
                IC_BOCompletServiceInt_Gdca.sbErrMsg
            );
            pkErrors.pop;
            raise_application_error
            (
                pkConstante.nuERROR_LEVEL2,
                IC_BOCompletServiceInt_Gdca.sbErrMsg
            );
    END Process;

    /*
        Propiedad intelectual de Open Systems (c).
        Procedure       :   TemprInsertConstAccCharges
        Descripcion     :   Inserta en entidad temporal los cargos asociados a la
                            cuenta de cobro de la venta constructora..

        Parametros
        Entrada         :       Descripcion
            inuCiclcodi             Ciclo de facturacion
            inuCucocodi             Cuenta de cobro
            inuSuscceco             Centro de costos
            isbIdentification       Identificacion del cliente
            inuCucocate             Categoria
            inuCucosuca             Subcategoria
            inuSuscsist             Empresa propietaria factura
            inuDocType              Tipo de Documento Contable

        Autor       :   Alejandro Rendon Gomez
        Fecha       :   24-07-2012 15:53:32

        Historia de Modificaciones
        Fecha        IDEntrega
        17-07-2020  CA-448
        Se modifica la manera de reportar ingreso de servicios cumplidos, se reportara ingreso por orden
        de trabajo legalizada, ya sea de Interna, CxC y Certificacion Previa, este nueov proceso empieza
        a funcionar con las ordenes legalizadas con fecha mayor o igual al '01-07-2020'.

        18-05-2021  CA-730     HT
        Se Valida el proceso de generar el servicio cumplido por orden de trabajo legalizada de acuerdo al
        ultimo cambio que se presento en la certifiacion previa, se corrige el proceso para que el proceso
        se ejecute por hilos.
        
        17-06-2025  OSF-4555    jpinedc
        Se modifica cuDatos para obtener el departamento y la localidad de la
        direccion de instalación del producto        

    */
    PROCEDURE TemprInsertConstAccCharges
    (
         idtfechafin     iN  Date,
         inuThreads      in  number,
         inuThread       in  number
    )
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'TemprInsertConstAccCharges';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
        
        Vsbttinter        ldci_carasewe.casevalo%type;
        Vsbttcxc          ldci_carasewe.casevalo%type;
        Vsbttcertp        ldci_carasewe.casevalo%type;
        Vsbttotapoy       ldci_carasewe.casevalo%type;
        Vsbfecotapo       ldci_carasewe.casevalo%type;
        Vsbfeciniot       ldci_carasewe.casevalo%type;

        Cursor CuDatos IS
            select A.PRODUCT_ID, 7014,
                   sesucate, sesusuca, ca.cargconc, 53, 'DB',
                   (ca.cargvalo/ca.cargunid) val1, (ca.cargvalo/ca.cargunid) val2,
                   cargdoso, o2.legalization_date, 'ICBISC', ca.cargpefa,
                   71 ,
                   'TRM', 'N',
                   ca.cargpeco,
                   ca.cargcoll,
                   GC.GEO_LOCA_FATHER_ID,   -- DPTO
                   ab.geograp_location_id,  -- LOCA
                   sc.sesususc susccodi,
                   ca.cargunid, 'SC'
              from open.or_order o2
             inner join open.ge_causal c ON c.causal_id = o2.causal_id and c.class_causal_id = 1
             inner join open.or_order_activity a ON a.order_id = o2.order_id
             inner join open.or_task_type tt ON tt.task_type_id = o2.task_type_id
             inner join open.mo_packages m ON m.package_id = a.package_id and m.package_type_id = 323
             inner join open.cargos ca ON cargdoso = 'PP-'||a.package_id and cargconc = tt.concept and cargcaca = 53
             inner join open.concepto ON conccodi = cargconc and concclco in (4,19,400)
             inner join open.servsusc sc ON sc.sesunuse = a.product_id
             inner join open.pr_product pr ON pr.product_id = a.product_id
             inner join open.ab_address ab ON ab.address_id = pr.address_id
             inner join open.ge_geogra_location gc ON GC.GEOGRAP_LOCATION_ID = ab.geograp_location_id
             where trunc(o2.legalization_date) >= idtfechafin
               and trunc(o2.legalization_date) <  idtfechafin + 1
               and o2.order_status_id = 8
               and (
                    (o2.task_type_id IN (SELECT (COLUMN_VALUE)
                                           FROM TABLE (open.LDC_BOUTILITIES.SPLITSTRINGS((Vsbttinter),',') )) and
                     concclco in (19) and -- Interna
                     a.product_id not in (select act.product_id
                                            from open.or_order_activity act, open.or_order oo
                                           where act.product_id = a.product_id
                                             and oo.task_type_id in (SELECT (COLUMN_VALUE)
                                                                       FROM TABLE (open.LDC_BOUTILITIES.SPLITSTRINGS((Vsbttotapoy),',') ))
                                             and act.order_id = oo.order_id
                                             and oo.legalization_date < to_date(Vsbfecotapo)
                                         )
                    )
                  OR
                    (
                      o2.task_type_id IN (SELECT (COLUMN_VALUE)
                                            FROM TABLE (open.LDC_BOUTILITIES.SPLITSTRINGS((Vsbttcxc),',') )) and
                      concclCo = 4 -- cxc
                    )
                  OR
                    (
                      o2.task_type_id IN (SELECT (COLUMN_VALUE)
                                              FROM TABLE (open.LDC_BOUTILITIES.SPLITSTRINGS((Vsbttcertp),',')) ) and
                      concclco = 400 AND -- Cert Previa
                      o2.causal_id = 9944
                    )
                   )
               AND o2.order_id not in (select oo.related_order_id
                                         from open.OR_related_order oo
                                        where oo.related_order_id = o2.order_id
                                          and oo.rela_order_type_id in (13,14)
                                      )
               AND a.product_id NOT IN (SELECT hcecnuse
                                          FROM open.hicaesco h
                                         WHERE hcecfech < to_date(Vsbfeciniot)
                                           AND hcecnuse = a.product_id
                                           AND hcececan = 96
                                           AND hcececac = 1
                                           AND hcecserv = 7014)
               AND MOD(a.product_id, inuThreads) + 1 = inuThread;

        osbErrorMessage   VARCHAR2(2000);

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
        ldci_pkwebservutils.proCaraServWeb('WS_COSTOS', 'FECHA_FIN_ORDEN_DE_APOYO', Vsbfecotapo, osbErrorMessage);
        ldci_pkwebservutils.proCaraServWeb('WS_COSTOS', 'FECHA_INICIO_INGRESO_X_ORDEN', Vsbfeciniot, osbErrorMessage);
        ldci_pkwebservutils.proCaraServWeb('WS_COSTOS', 'TIPOS_DE_TRABAJOS_C_X_C', Vsbttcxc, osbErrorMessage);
        ldci_pkwebservutils.proCaraServWeb('WS_COSTOS', 'TIPOS_DE_TRABAJOS_INTERNA', Vsbttinter, osbErrorMessage);
        ldci_pkwebservutils.proCaraServWeb('WS_COSTOS', 'TIPO_DE_TRABAJO_CERTIF_PREVIA', Vsbttcertp, osbErrorMessage);
        ldci_pkwebservutils.proCaraServWeb('WS_COSTOS', 'TIPOS_DE_TRABAJOS_OT_APOYO', Vsbttotapoy, osbErrorMessage);

        For reg In Cudatos Loop

            INSERT
            INTO    tmp_cargproc
            (
                cargnuse, cargcicl, cargfact, cargcuco, cargserv,
                cargcate, cargsuca, cargconc, cargcaca, cargsign,
                cargvalo, cargimp1,  cargiva, cargunme, cargcodo,
                cargdoso, cargfecr, cargfeco, cargprog, cargpefa,
                cargano,  cargmes,  cargsoci, cargfech, cargusua,
                cargterm, cargflfa, cargpete, cargteco, cargpeco,
                cargcoll, cargdepa, cargloca, cargzoco, cargsusc,
                cargunid, cargfopa
            )
            Values
            (
                reg.PRODUCT_ID, -1, 0, -1, 7014,
                reg.sesucate, reg.sesusuca, reg.cargconc, 53, 'DB',
                reg.val1, reg.val2, 0, 0, 0,
                reg.cargdoso, reg.legalization_date, reg.legalization_date, 'ICBISC', reg.cargpefa,
                0, 71 , 0, reg.legalization_date, 'ICBISC',
                'TRM', 'N',
                0, 0, reg.cargpeco,
                reg.cargcoll,
                reg.geo_loca_father_id,
                reg.geograp_location_id,
                0,
                reg.susccodi,
                reg.cargunid,
                'SC');

        End loop;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END TemprInsertConstAccCharges;


    PROCEDURE TemprInsertMigraCharges(idtfechafin  IN Date,
                                      inuThreads   in  number,
                                      inuThread    in  number
                                      )
    /**********************************************************************
    	Propiedad intelectual de

      NOMBRE        TemprInsertMigraCharges
      AUTOR				  Diego Andres Cardona Garcia
    	FECHA         11-Dic-2014

    	DESCRIPCION   Obtiene la informacion de ingresos de ventas abiertas migradas
                    y los inserta en la tabla de cargos temporales para la generacion
                    de Hechos Economicos

    	PARAMETROS
    	-------------
      Nombre				Descripcion
    	inuProductId		Producto de Gas

    	HISTORIA DE MODIFICACIONES
    	Autor       Fecha       Modificacion
        ----------- ----------  ---------------------------------------------
        Dcardona    23/05/2014  Aranda: 6038
                                Se ajusta para que no se inserten algunos datos vacios (NULL)
                                y para obtener el plan comercial de constructoras de un parametro

        HT          18-05-2021  CA-730
                                Se Valida el proceso de generar el servicio cumplido por orden de trabajo
                                legalizada de acuerdo al ultimo cambio que se presento en la certifiacion
                                previa, se corrige el proceso para que el proceso se ejecute por hilos.
        jpinedc     17-06-2025  OSF-4555: Se modifica cuDatos para obtener el departamento y 
                                la localidad de la direccion de instalación del producto
    ***********************************************************************/
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'TemprInsertMigraCharges';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
        
        -- Variables
        vaPlanCial   VARCHAR2(1000);
        vaError      VARCHAR2(3000);
        nuPlanCial   mo_motive.commercial_plan_id%TYPE;
        vnucatego    servsusc.sesucate%type;
        vnucatere    constant servsusc.sesucate%type := 1; -- Residencial

        Vsbttinter        ldci_carasewe.casevalo%type;
        Vsbttcxc          ldci_carasewe.casevalo%type;
        Vsbttcertp        ldci_carasewe.casevalo%type;
        Vsbttotapoy       ldci_carasewe.casevalo%type;
        Vsbfecotapo       ldci_carasewe.casevalo%type;
        Vsbfeciniot       ldci_carasewe.casevalo%type;

        -- Consulta Servicio Cumplido Migrado
        Cursor CuDatos IS
          select A.PRODUCT_ID, 7014,
                 sesucate, sesusuca, invmconc, 53, 'DB',
                 invmvain,
                 idtfechafin, 'ICBISC',
                 71,
                 'TRM', 'N',
                 gc.geo_loca_father_id,   -- DPTO
                 ab.geograp_location_id,  -- LOCA
                 sc.sesususc susccodi,
                 'MC'
             from open.or_order o2
             inner join open.ge_causal c ON c.causal_id = o2.causal_id and c.class_causal_id = 1
             inner join open.or_order_activity a ON a.order_id = o2.order_id
             inner join open.mo_packages m on m.package_id = a.package_id and m.package_type_id = 100271 -- 323
             inner join open.Ldci_Ingrevemi mi ON mi.invmsesu = a.product_id
             inner join open.concepto o ON conccodi = mi.invmconc
             inner join open.servsusc sc ON sc.sesunuse = a.product_id
             inner join open.pr_product pr ON pr.product_id = a.product_id
             inner join open.ab_address ab ON ab.address_id = pr.product_id
             inner join open.ge_geogra_location gc ON GC.GEOGRAP_LOCATION_ID = ab.geograp_location_id
             where trunc(o2.legalization_date) >= idtfechafin
               and trunc(o2.legalization_date) <  idtfechafin + 1
               and o2.order_status_id = 8
               and (
                      (
                       o2.task_type_id IN (SELECT (COLUMN_VALUE)
                                             FROM TABLE (open.LDC_BOUTILITIES.SPLITSTRINGS((Vsbttinter),',') )) and
                       concclco in (19) and -- Interna
                       a.product_id not in (select act.product_id
                                               from open.or_order_activity act, open.or_order oo
                                              where act.product_id = a.product_id
                                                and oo.task_type_id in (SELECT (COLUMN_VALUE)
                                                                          FROM TABLE (open.LDC_BOUTILITIES.SPLITSTRINGS((Vsbttotapoy),',') ))
                                                and act.order_id = oo.order_id
                                                and oo.legalization_date < to_date(Vsbfecotapo)
                                            )
                      )
                  OR
                    (
                     o2.task_type_id IN (SELECT (COLUMN_VALUE)
                                           FROM TABLE (open.LDC_BOUTILITIES.SPLITSTRINGS((Vsbttcxc),',') )) and
                     concclCo = 4 -- cxc
                    )
                  OR
                    (
                     o2.task_type_id IN (SELECT (COLUMN_VALUE)
                                           FROM TABLE (open.LDC_BOUTILITIES.SPLITSTRINGS((Vsbttcertp),',')) ) and
                     concclco = 400 AND-- Cert Previa
                     o2.causal_id = 9944
                    )
                   )
               AND o2.order_id not in (select oo.related_order_id
                                         from open.OR_related_order oo
                                        where oo.related_order_id = o2.order_id
                                          and oo.rela_order_type_id in (13,14)
                                      )
               AND a.product_id NOT IN (SELECT hcecnuse
                                          FROM open.hicaesco h
                                         WHERE hcecfech < to_date(Vsbfeciniot)
                                           AND hcecnuse = a.product_id
                                           AND hcececan = 96
                                           AND hcececac = 1
                                           AND hcecserv = 7014)
               AND MOD(a.product_id, inuThreads) + 1 = inuThread;


        osbErrorMessage   VARCHAR2(2000);

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
        
        -- Se obtiene el plan comercial de constructoras
        ldci_pkwebservutils.proCaraServWeb('WS_COSTOS', 'PLAN_CCIAL_CONST', vaPlanCial, IC_BOCompletServiceInt_Gdca.sbErrMsg);

        ldci_pkwebservutils.proCaraServWeb('WS_COSTOS', 'FECHA_FIN_ORDEN_DE_APOYO', Vsbfecotapo, osbErrorMessage);
        ldci_pkwebservutils.proCaraServWeb('WS_COSTOS', 'FECHA_INICIO_INGRESO_X_ORDEN', Vsbfeciniot, osbErrorMessage);
        ldci_pkwebservutils.proCaraServWeb('WS_COSTOS', 'TIPOS_DE_TRABAJOS_C_X_C', Vsbttcxc, osbErrorMessage);
        ldci_pkwebservutils.proCaraServWeb('WS_COSTOS', 'TIPOS_DE_TRABAJOS_INTERNA', Vsbttinter, osbErrorMessage);
        ldci_pkwebservutils.proCaraServWeb('WS_COSTOS', 'TIPO_DE_TRABAJO_CERTIF_PREVIA', Vsbttcertp, osbErrorMessage);
        ldci_pkwebservutils.proCaraServWeb('WS_COSTOS', 'TIPOS_DE_TRABAJOS_OT_APOYO', Vsbttotapoy, osbErrorMessage);

        -- Se convierte a numerico el valor del parametro
        nuPlanCial := to_number(vaPlanCial);

        -- llevamos todo el ingreso
        FOr reg in CUDatos Loop

           INSERT
           INTO    open.tmp_cargproc
           (
              cargnuse, cargcicl, cargfact, cargcuco, cargserv,
              cargcate, cargsuca, cargconc, cargcaca, cargsign,
              cargvalo, cargimp1,  cargiva, cargunme, cargcodo,
              cargdoso, cargfecr, cargfeco, cargprog, cargpefa,
              cargano, cargmes, cargsoci, cargfech, cargusua,
              cargterm, cargflfa, cargpete, cargteco, cargpeco,
              cargcoll, cargdepa, cargloca, cargzoco, cargsusc,
              cargunid, cargfopa
           )
           VALUES
           (
            -- Consulta Servicio Cumplido Migrado
                   reg.PRODUCT_ID, -1, 0, -1, 7014,
                   reg.sesucate, reg.sesusuca, reg.invmconc, 53, 'DB',
                   reg.invmvain, reg.invmvain, 0, 0, 0,
                   0, idtfechafin, idtfechafin, 'ICBISC', 0,
                   0, 71, 0, idtfechafin, 'ICBISC',
                   'TRM', 'N',
                   0, 0, 0, 0,
                   reg.geo_loca_father_id,
                   reg.geograp_location_id,
                   0,
                   reg.susccodi,
                   0,
                   'MC'
           );

        End Loop;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    END TemprInsertMigraCharges;

    /*
        Propiedad intelectual de Open Systems (c).
        Procedure       :   ValExecuteFGHE
        Descripcion     :   Valida la ejecucion de FGHE en las fechas de
                            procesamiento

        Parametros
        Entrada         :       Descripcion
            idtInitialDate          Fecha inicial
            idtFinalDate            Fecha final

        Autor       :   Alejandro Rendon Gomez
        Fecha       :   13-09-2012 16:57:54

        Historia de Modificaciones
        Fecha       IDEntrega

        18-03-2014  arendon.SAO235707
        Se adiciona validacion de FGHE Notas.

        18-07-2013  hlopez.SAO212472
        Se corrige forma de validar FGHE
        - Se modifica el metodo <ValProcess>

        13-09-2012  arendon.SAO190941
        Creacion.
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
        -- Fecha auxiliar de iteracion
        dtCurrent           date;

        -------------------
        -- Metodos
        -------------------
        /*
            Propiedad intelectual de Open Systems (c).
            Procedure       :   ValProcess
            Descripcion     :   Valida que el proceso este ejecutado.

            Parametros
            Entrada         :       Descripcion
                inuDocType              Tipo de documento
                idtMovDate              Fecha de contabilizacion del movimiento

            Autor       :   Alejandro Rendon Gomez
            Fecha       :   13-09-2012 17:11:27

            Historia de Modificaciones
            Fecha       IDEntrega

            18-07-2013  hlopez.SAO212472
            Se corrige forma de validar FGHE

            13-09-2012  arendon.SAO190941
            Creacion.
        */
        PROCEDURE ValProcess
        (
            inuDocType  in  ic_docugene.dogetido%type,
            idtMovDate  in  ic_docugene.dogefeco%type
        )
        IS
        BEGIN
            pkErrors.Push('IC_BOCompletServiceInt_Gdca.ValExecuteFGHE.ValProcess');

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
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
                pkErrors.pop;
                raise_application_error
                (
                    pkConstante.nuERROR_LEVEL2,
                    IC_BOCompletServiceInt_Gdca.sbErrMsg
                );
        END ValProcess;

    BEGIN
        pkErrors.Push('IC_BOCompletServiceInt_Gdca.ValExecuteFGHE');

        -- Inicializa la fecha de iteracion
        dtCurrent := idtInitialDate;

        loop

            -- Condicion de salida
            exit when dtCurrent > idtFinalDate;

            /* Realiza el control de ejecucion */

            -------------------
            -- FACTURACION
            -------------------
            ValProcess
            (
                cnuDOC_TYPE_BILL,
                dtCurrent
            );


            -------------------
            -- NOTAS
            -------------------
            ValProcess
            (
                cnuDOC_TYPE_NOTES,
                dtCurrent
            );

            -- Incremente la fecha de iteracion
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
                IC_BOCompletServiceInt_Gdca.sbErrMsg
            );
            pkErrors.pop;
            raise_application_error
            (
                pkConstante.nuERROR_LEVEL2,
                IC_BOCompletServiceInt_Gdca.sbErrMsg
            );
    END ValExecuteFGHE;

    /*
        Propiedad intelectual de Open Systems (c).
        Function        :   fnuIsGivBackCheckCause
        Descripcion     :   Devuelve valor numerico que indica si una causa
                            esta asociada al clasificador de cheque devuelto.

        Parametros      :       Descripcion
            inuChargeCause          Causa de cargo

        Retorno         :
            nuIs                    Valor de retorno
                                    - 1: Causa asociada al clasificador de cheque devuelto
                                    - 0: Causa NO asociada al clasificador de cheque devuelto

        Autor       :   Alejandro Rendon Gomez
        Fecha       :   18-03-2014 15:10:54

        Historia de Modificaciones
        Fecha       IDEntrega

        18-03-2014  arendon.SAO235707
        Creacion.
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
        pkErrors.Push('IC_BOCompletServiceInt_Gdca.fnuIsGivBackCheckCause');

        /* Valida si la causa de cargo esta asociada al clasificador de
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

END IC_BOCompletServiceInt_Gdca;
/

PROMPT OTORGA PERMISOS ESQUEMA sobre IC_BOCOMPLETSERVICEINT_GDCA
BEGIN
    pkg_utilidades.prAplicarPermisos('IC_BOCOMPLETSERVICEINT_GDCA', 'ADM_PERSON'); 
END;
/

