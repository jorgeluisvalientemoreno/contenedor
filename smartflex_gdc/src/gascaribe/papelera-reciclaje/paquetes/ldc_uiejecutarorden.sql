CREATE OR REPLACE PACKAGE LDC_UIEJECUTARORDEN is
/******************************************************************************
  Propiedad intelectual de Efigas S.A. E.S.P.

  Unidad       :   LDC_UIEJECUTARORDEN
  Descripcion  :   Objeto para manejo de loquica del PB - LDEJO

  Historia de Modificaciones (DD-MM-YYYY)
  Fecha        Autor                        Modificacion
  ==========   ===================          ====================================
  25/10/2016   lfvalencia - olsoftware      Creación
******************************************************************************/

FUNCTION fsbversion
RETURN VARCHAR2;

-- Procedimiento utilizado para realizar ejecutar la exlusión e
-- inclusión de intereses de mora
PROCEDURE ExecuteOrder;

PROCEDURE dtIniStartDate;

PROCEDURE dtIniEndDate;

END LDC_UIEJECUTARORDEN;
/
CREATE OR REPLACE PACKAGE BODY LDC_UIEJECUTARORDEN is
/******************************************************************************
  Propiedad intelectual de Efigas S.A. E.S.P.

  Unidad       :   LDC_UIEJECUTARORDEN
  Descripcion  :   Objeto para manejo de loquica del PB - LDEJO

  Historia de Modificaciones (DD-MM-YYYY)
  Fecha        Autor                        Modificacion
  ==========   ===================          ====================================
  25/10/2016   lfvalencia - olsoftware      Creación
******************************************************************************/
    csbversion  CONSTANT VARCHAR2( 250 ) := 'CA200-404';

    sbErrMsg	ge_error_log.description%type;

    FUNCTION fsbversion
    RETURN VARCHAR2
    IS
    BEGIN
        pkErrors.push( 'LDC_UIEJECUTARORDEN.fsbVersion' );
        pkErrors.pop;
        RETURN ( csbversion );
    EXCEPTION
      WHEN LOGIN_DENIED THEN
         pkErrors.pop;
         RAISE LOGIN_DENIED;
      WHEN pkConstante.exerror_level2 THEN
         pkErrors.pop;
         RAISE pkConstante.exerror_level2;
      WHEN OTHERS THEN
         pkErrors.NotifyError( pkErrors.fsbLastObject, SQLERRM, sbErrMsg );
         pkErrors.pop;
         raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    END fsbversion;


    /****************************************************************************
    Unidad      : ExecuteOrder
    Descripcion	: Cambia de estado la orden a ejecutada

    Parametros          Descripcion
    ============        ===================


    Historia de Modificaciones
    Fecha           Autor                       Modificacion
    ============    ===================         ====================
    25/10/2016      lfvalencia - Olsoftware     Creacion.
    ***************************************************************************/
    PROCEDURE ExecuteOrder
    IS
        -- Mensaje de Error
        sbErrMsg		ge_error_log.description%type;
        -- Código del Error
        nuErrCode		number;

        -- Tipo de Comentario de la orden
        sbComment_type_id   GE_BOINSTANCECONTROL.STYSBVALUE;

        -- Comentario de la Orden
        sbOrder_Comment     GE_BOINSTANCECONTROL.STYSBVALUE;

        -- Fehca Inicio de Ejecución de la orden
        sbStartDate         GE_BOINSTANCECONTROL.STYSBVALUE;
        dtStartDate         or_order.exec_initial_date%type;

        -- Fecha Fin de Ejecución de Orden
        sbEndDAte           GE_BOINSTANCECONTROL.STYSBVALUE;
        dtEndDAte           or_order.execution_final_date%type;

        -- Identificador de la orden
        sbOrder_id          GE_BOINSTANCECONTROL.STYSBVALUE;
        nuOrder_id          OR_ORDER.ORDER_ID%TYPE;

        nuIndex             GE_BOINSTANCECONTROL.STYNUINDEX;

        cNunull_Attribute CONSTANT NUMBER := 2126;
    BEGIN
        pkerrors.push( 'LDC_UIEJECUTARORDEN.ExecuteOrder' );

        -- ------------------------------------------------------------------ --
        -- Obtiene los datos ingresados por el usuario de la instancia.       --
        -- ------------------------------------------------------------------ --
        sbComment_type_id   := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE( 'OR_ORDER_COMMENT', 'COMMENT_TYPE_ID' );
        sbOrder_Comment     := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE( 'OR_ORDER_COMMENT', 'ORDER_COMMENT' );
        sbStartDate         := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE( 'OR_ORDER', 'EXEC_INITIAL_DATE' );
        sbEndDAte           := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE( 'OR_ORDER', 'EXECUTION_FINAL_DATE' );

        -- Convertir fecha de entrada en tipo date
        dtStartDate     := to_date(sbStartDate, 'DD/MM/YYYY HH24:MI:SS');
        dtEndDAte       := to_date(sbEndDAte, 'DD/MM/YYYY HH24:MI:SS');

        -- Valida si el tipo de comentario es nulo
        if ( sbComment_type_id is null ) then
            errors.seterror( cNunull_Attribute, 'Tipo' );
            raise EX.CONTROLLED_ERROR;
        end if;

        -- Valida que la fecha de inicio de ejecución no sea mayo a la fecha final
        if ( dtStartDate >  dtEndDAte ) then
            errors.seterror( -1, 'Fecha de inicio de ejecución no puede ser mayor a la fecha final.' );
            raise EX.CONTROLLED_ERROR;
        end if;

        -- Valida que la fecha fin de ejecución no sea mayor a la fecha actual
        if ( sysdate <  dtEndDAte ) then
            errors.seterror( -1, 'Fecha fin de ejecución no puede ser mayor a la fecha actual.' );
            raise EX.CONTROLLED_ERROR;
        end if;


        if (
                GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK
                (
                    GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE,
                    NULL,
                    'OR_ORDER',
                    'ORDER_ID',
                    nuIndex
                )
            )
        then
            GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE
            (
                GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE,
                NULL,
                'OR_ORDER',
                'ORDER_ID',
                sbOrder_id
            );
            nuOrder_id := ut_convert.fnuchartonumber( sbOrder_id );
        else
            errors.seterror( cNunull_Attribute, 'Código de Orden' );
            raise EX.CONTROLLED_ERROR;
        end if;

        or_BOEjecutarorden.ejecutarorden( nuOrder_id, ut_convert.fnuchartonumber( sbComment_type_id ), sbOrder_Comment );

        daor_order.updexec_initial_date(nuOrder_id,dtStartDate);

        daor_order.updexecution_final_date(nuOrder_id,dtEndDAte);

        COMMIT;
        pkerrors.pop;
    EXCEPTION
        when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
    	pkErrors.GetErrorVar( nuErrCode, sbErrMsg );
    	pkErrors.Pop;
    	raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);

        when others then
    	pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
    	pkErrors.Pop;
    	raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    END ExecuteOrder;

    /****************************************************************************
    Unidad      : dtIniStartDate
    Descripcion	: Inicializa la fecha inicio de ejecución de la orden

    Parametros          Descripcion
    ============        ===================


    Historia de Modificaciones
    Fecha           Autor                       Modificacion
    ============    ===================         ====================
    25/10/2016      lfvalencia - Olsoftware     Creacion.
    ***************************************************************************/
    PROCEDURE dtIniStartDate
    IS
        -- Identificador de la orden
        sbOrder_id          GE_BOINSTANCECONTROL.STYSBVALUE;
        nuOrder_id          OR_ORDER.ORDER_ID%TYPE;

        SBINSTANCE          GE_BOINSTANCECONTROL.STYSBNAME;

        -- fecha de asiganación de la orden
        dtAssind_date       or_order.assigned_date%type;
    BEGIN
        pkErrors.push( 'LDC_UIEJECUTARORDEN.fdtIniStartDate' );

            GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE
            (
                GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE,
                NULL,
                'OR_ORDER',
                'ORDER_ID',
                sbOrder_id
            );
            nuOrder_id := ut_convert.fnuchartonumber( sbOrder_id );

            dtAssind_date := daor_order.fdtgetassigned_date(sbOrder_id,0);

            GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(SBINSTANCE);
            GE_BOINSTANCECONTROL.ADDATTRIBUTE(SBINSTANCE, NULL, 'OR_ORDER', 'EXEC_INITIAL_DATE', dtAssind_date,TRUE);

        pkErrors.pop;
    EXCEPTION
      WHEN LOGIN_DENIED THEN
         pkErrors.pop;
         RAISE LOGIN_DENIED;
      WHEN pkConstante.exerror_level2 THEN
         pkErrors.pop;
         RAISE pkConstante.exerror_level2;
      WHEN OTHERS THEN
         pkErrors.NotifyError( pkErrors.fsbLastObject, SQLERRM, sbErrMsg );
         pkErrors.pop;
         raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    END dtIniStartDate;

    /****************************************************************************
    Unidad      : dtIniEndDate
    Descripcion	: Inicializa la fecha fin de ejecución de la orden

    Parametros          Descripcion
    ============        ===================


    Historia de Modificaciones
    Fecha           Autor                       Modificacion
    ============    ===================         ====================
    25/10/2016      lfvalencia - Olsoftware     Creacion.
    ***************************************************************************/
    PROCEDURE dtIniEndDate
    IS
        -- fecha de asiganación de la orden
        dtNow_date          or_order.assigned_date%type;

        SBINSTANCE          GE_BOINSTANCECONTROL.STYSBNAME;
    BEGIN
        pkErrors.push( 'LDC_UIEJECUTARORDEN.fdtIniEndDate' );

            dtNow_date := sysdate;

            GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(SBINSTANCE);
            GE_BOINSTANCECONTROL.ADDATTRIBUTE(SBINSTANCE, NULL, 'OR_ORDER', 'EXECUTION_FINAL_DATE', dtNow_date,TRUE);

        pkErrors.pop;
    EXCEPTION
      WHEN LOGIN_DENIED THEN
         pkErrors.pop;
         RAISE LOGIN_DENIED;
      WHEN pkConstante.exerror_level2 THEN
         pkErrors.pop;
         RAISE pkConstante.exerror_level2;
      WHEN OTHERS THEN
         pkErrors.NotifyError( pkErrors.fsbLastObject, SQLERRM, sbErrMsg );
         pkErrors.pop;
         raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
    END dtIniEndDate;

END LDC_UIEJECUTARORDEN;
/
GRANT EXECUTE on LDC_UIEJECUTARORDEN to SYSTEM_OBJ_PRIVS_ROLE;
/
