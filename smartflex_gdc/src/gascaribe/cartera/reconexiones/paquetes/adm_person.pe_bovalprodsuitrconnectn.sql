create or replace PACKAGE adm_person.PE_BOValProdSuitRconnectn AS
/*
    Propiedad intelectual de Open International Systems. (c).

    Paquete	    :   PE_BOValProdSuitRconnectn
    Descripción :   Objeto de negocio para consultar la información del producto.

    Autor	    :   Luz Trujillo García
    Fecha   	:   04-11-2014

    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    10/07/2024              PAcosta         OSF-2893: Cambio de esquema ADM_PERSON  
    
    
    04-11-2014  LTrujilloSAO288775
    Creación.
*/

    ----------------------------------------------------------------------------
    -- Métodos
    ----------------------------------------------------------------------------

    /* Obtiene versión actual del paquete */
    FUNCTION fsbVersion
        return varchar2;

    /* Consulta la información de un cliente dado el código de producto */
    PROCEDURE ValInfo
    (
        inuProductId    in  pr_product.product_id%type,
        osbFlag         out varchar2,
        onuErrorCode    out ge_error_log.error_log_id%type,
        osbErrorMsg     out ge_error_log.description%type
    );

END PE_BOValProdSuitRconnectn;
/
create or replace PACKAGE BODY adm_person.PE_BOValProdSuitRconnectn AS
/*
    Propiedad intelectual de Open International Systems (c).

    Paquete     :   PE_BOValProdSuitRconnectn
    Descripción :   Variables, procedimientos y funciones del paquete
                    PE_BOValProdSuitRconnectn.

    Autor	    :   Luz Trujillo García
    Fecha   	:   04-11-2014

    Historia de Modificaciones
    Fecha	    IDEntrega

    04-11-2014  LTrujilloSAO288775
    Creación.

*/
    ----------------------------------------------------------------------------
    -- Constantes
    ----------------------------------------------------------------------------

    /* Versión paquete */
    csbVersion              constant varchar2(250) := 'SAO288775';

    ----------------------------------------------------------------------------
    -- Variables
    ----------------------------------------------------------------------------

    /* Flag de carga de parámetros */
    gboLoadedParams        boolean := FALSE;
    /* Valor del Parámetro Estado de corte "Suspensión Parcial" */
    gnuCutOffStatusPartial estacort.escocodi%type;
    /* Valor del Parámetro Estado de corte "Suspensión Total" */
    gnuCutOffStatusTotal   estacort.escocodi%type;
    /* Valor del Parámetro Estado de corte "Orden de Suspensión Parcial" */
    gnuCutOrderSuspension  estacort.escocodi%type;
    /*Valor del Parámetro Estado de corte "Orden de Conexión"*/
    gnuCutOrderConnection  estacort.escocodi%type;

    ----------------------------------------------------------------------------
    -- Métodos
    ----------------------------------------------------------------------------

    /*
        Propiedad intelectual de Open International Systems. (c).

        Función 	:   fsbVersion
        Descripcion	:   Obtiene SAO que identifica versión asociada a última
                        entrega del paquete.

        Retorno     :
            csbVersion      Versión de paquete.

        Autor	    :   Luz Trujillo García
        Fecha   	:   04-11-2014

        Historia de Modificaciones
        Fecha	    IDEntrega
        04-11-2014  LTrujilloSAO288775
        Creación.
    */

    FUNCTION fsbVersion
        return varchar2
    IS
    BEGIN

    	UT_Trace.Trace('PE_BSValProdSuitRconnectn.fsbVersion INICIO', 2);
    	UT_Trace.Trace('PE_BSValProdSuitRconnectn.fsbVersion FIN', 2);

        return csbVersion;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when OTHERS then
            Errors.SetError;
            raise ex.CONTROLLED_ERROR;
    END fsbVersion;

    /*
        Propiedad intelectual de Open International Systems. (c).

        Procedimiento   : GetParameters
        Descripción     : Obtiene parámetros requeridos por el proceso.

        Autor           : Santiago Gómez Rico
        Fecha           : 16-06-2014 14:42:36

        Historia de Modificaciones
        Fecha       IDEntrega

        16-06-2014  sgomez.SAO246353
        Creación.
    */

    PROCEDURE GetParameters
    IS

        ------------------------------------------------------------------------
        -- Constantes
        ------------------------------------------------------------------------

        /* Parámetro Estado de corte "Suspensión Parcial" */
        csbCUTOFF_ST_PARTIAL            constant parametr.pamecodi%type := 'ESCO_SUSP_PARC';

        /* Parámetro Estado de corte "Suspensión Total" */
        csbCUTOFF_ST_TOTAL              constant parametr.pamecodi%type := 'ESCO_SUSP_TOTAL';

        /* Parámetro Estado de Corte "Orden de suspensión Parcial" */
        csbCUTOFF_ORDEN_SUSP_PARCIAL    constant parametr.pamecodi%type := 'CON_ORDEN_DESCONEXION';

         /*Parámetro Estado de corte "Con orden de Conexión " */
        cnuCON_ORDEN_DE_CONEXION constant parametr.pamecodi%type := 'CON_ORDEN_DE_CONEXION';

    BEGIN

        UT_Trace.Trace('PE_BOValProdSuitRconnectn.GetParameters INICIO', 2);

        /* Evalúa si parámetros fueron cargados anteriormente */
        if(gboLoadedParams) then
            UT_Trace.Trace('PE_BOValProdSuitRconnectn.GetParameters FIN', 2);
            return;
        end if;

        /* Activa caché de parámetros */
        pkGrlParamExtendedMgr.SetCacheOn;

        /* Obtiene Estado de corte "Suspensión Parcial" */
        gnuCutOffStatusPartial:=pkGeneralParametersMgr.fnuGetNumberValue(csbCUTOFF_ST_PARTIAL);
        UT_Trace.Trace('[gnuCutOffStatusPartial]='||to_char(gnuCutOffStatusPartial), 2);

        /* Obtiene Estado de corte "Suspensión Total" */
        gnuCutOffStatusTotal:=pkGeneralParametersMgr.fnuGetNumberValue(csbCUTOFF_ST_TOTAL);
        UT_Trace.Trace('[gnuCutOffStatusTotal]='||to_char(gnuCutOffStatusTotal), 2);

        /* Obtiene Estado de corte "Orden de Suspensión Parcial" */
        gnuCutOrderSuspension := pkGeneralParametersMgr.fnuGetNumberValue(csbCUTOFF_ORDEN_SUSP_PARCIAL);
        UT_Trace.Trace('[gnuCutOrderSuspension]='||to_char(gnuCutOffStatusTotal), 2);

        /*Obtiene el valor parametro "Con órden de Conexión"*/
        gnuCutOrderConnection := pkGeneralParametersMgr.fnuGetNumberValue(cnuCON_ORDEN_DE_CONEXION);
        UT_Trace.Trace('[gnuCutOrderConnection]='||to_char(gnuCutOrderConnection), 2);

        /* Parámetros ya cargados */
        gboLoadedParams := TRUE;

        UT_Trace.Trace('PE_BOValProdSuitRconnectn.GetParameters FIN', 2);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            /* Parámetros NO cargados */
            gboLoadedParams := FALSE;
            raise;
        when OTHERS then
            /* Parámetros NO cargados */
            gboLoadedParams := FALSE;
            Errors.SetError;
            raise ex.CONTROLLED_ERROR;
    END GetParameters;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------

    /*
    Propiedad intelectual de Open International Systems. (c).

    Procedimiento :   ValInfo
    Descripción   :   Valida si el producto es apto para reconexión
    --------------------------------------------------------------------
    Parámetros    :
    inuProductId       Identificador del producto
    --------------------------------------------------------------------
    Retorno      :
    osbFlag      : 'S'->Producto Válido para reconexión
                  'N'->Producto No válido para reconexión

    onuErrorCode    : 0 - Terminó con éxito.
                  <> 0 - Código de error.

    osbErrorMsg     : '-'- Terminó con éxito.
                  <> '-' - Mensaje de error.

    --------------------------------------------------------------------
    Autor	    :  Luz Trujillo García
    Fecha   	:  04-11-2014
    --------------------------------------------------------------------
    Historia de Modificaciones
    Fecha	    IDEntrega
    04-11-2014  LTrujilloSAO288775
    Creación.
    */

    PROCEDURE ValInfo
    (
        inuProductId    in  pr_product.product_id%type,
        osbFlag         out varchar2,
        onuErrorCode    out ge_error_log.error_log_id%type,
        osbErrorMsg     out ge_error_log.description%type
    )
    IS

        ------------------------------------------------------------------------
        -- Registros
        ------------------------------------------------------------------------
        /* Producto */
        --rcProduct           DAPR_Product.styPR_product;
        rcServsusc          servsusc%rowtype;

        /* Contrato */
        rcSuscripc          suscripc%rowtype;

        /*Información de configuración de estado de corte*/
        rcSuspStatConf  confesco%rowtype;

        /*Parámetro para indicar si se validan criterios adicionales de reconex*/
        sbValCritReconex    varchar2(10);

        /* Indica si cumple con el criterio adicional de reconex. */
        sbCritReconex       varchar2(10);

        ------------------------------------------------------------------------
        -- Variables
        ------------------------------------------------------------------------
         /*Valor cartera castigada*/
        nuValCarCast        number;
        /*Tiene Orden de Reconex Pdt */
        osbHasRecPayOrd     VARCHAR(4);
        ------------------------------------------------------------------------

        -----------------------------------------------------------------------
        -- Métodos anidados
        ------------------------------------------------------------------------
        ------------------------------------------------------------------------
        PROCEDURE GetWithdrawCriteria
        (
            orcWithdrawCriteria out nocopy confcose%rowtype
        )
        IS
            nuCustType    ge_subscriber.subscriber_type_id%type;
        BEGIN
        --{
            -- Obtiene Tipo de Cliente del Producto
            nuCustType := DAGE_Subscriber.fnuGetSubscriber_type_id(
                                                            rcSuscripc.suscclie );

            -- Obtiene el registro de configuracion de corte del servicio
            pkSuspConnService.GetStatusConfData
            (
                nuCustType,
                rcServsusc.sesuplfa,
                rcServsusc.sesuserv,
                rcServsusc.sesunuse,
                orcWithdrawCriteria,
                TRUE
            );

        EXCEPTION
            when LOGIN_DENIED then
                null;
        END GetWithdrawCriteria;
        ------------------------------------------------------------------------
        FUNCTION fblIsBalanceServiceOk
        RETURN boolean
        IS
            -- Porcentaje de deuda cancelada para reconexión
            --nuPorcDeud          number(13,2) := 0;
            -- Porcentaje de deuda cancelado para el producto
            --nuPorcPago          number(13,2) := 0;
            -- Nro. cuentas saldo del Servicio suscrito
            nuCuenSaldServ      confcose.cocsncdx%type;
            -- Max. Nro. cuentas saldo
            nuCuenSald          confcose.cocsncdx%type;
            rcWithdrawCriteria  confcose%rowtype;
        BEGIN
        --{
            UT_Trace.Trace( 'Inicio: [PE_BOValProdSuitRconnectn.ChgStSusPayment.fblIsBalanceServiceOk]', 8 );
            UT_Trace.Trace( 'Analizando Producto: '||rcServsusc.sesunuse, 8 );

            IF (CC_BOFinancing.gboIsAdjust) THEN
                UT_Trace.Trace( 'Se está ajustando por saldo de cuenta < cnuAJUSTE, retorna True', 8 );
                return TRUE;
            END IF;

            --  Obtiene los criterios para corte del tipo de producto
            GetWithdrawCriteria( rcWithdrawCriteria );  --out

            -- Si no existe configuracion del estado de corte para el servicio
            if ( rcWithdrawCriteria.cocsserv IS null ) then

                UT_Trace.Trace( 'No existe configuracion del estado de corte para el servicio', 8 );
                return FALSE;

            END if;

            -- Asigna el porcentaje de deuda para re-conexion
            --nuPorcDeud := rcWithdrawCriteria.cocspdcx;

            -- Asigna el minimo numero de cuentas con saldo para re-conexion
            if ( rcWithdrawCriteria.cocsnccx = rcWithdrawCriteria.cocsncdx ) then
            --{
                nuCuenSald := rcWithdrawCriteria.cocsnccx - 1;
            --}
            else
            --{
                nuCuenSald := rcWithdrawCriteria.cocsnccx;
            --}
            end if;

            -- Asigna el numero de periodos con al menos una cuenta con saldo del servicio suscrito
            nuCuenSaldServ := pkBOExpiredAccounts.fnuPeriodsWithExpAccounts(
                                                            rcServsusc.sesunuse );

            -- Calcula el porcentaje de la deuda cancelado
            /*
            nuPorcPago := ( ( inuPreviusCucoSacu - inuCurrentCucoSacu ) * 100 )
                          / inuPreviusCucoSacu;
            */
            -- Evalua si el porcentaje de deuda cancelado es menor
            -- al requerido y si el numero de cuentas del servicio es mayor
            -- al minimo configurado para re-conexion entonces no lo reconecta
            if ( nuCuenSaldServ > nuCuenSald ) then
            --{
                UT_Trace.Trace( 'Número de períodos vencidos del producto es mayor al número de períodos para reconexión, no genera orden', 9 );
                return FALSE;
            --}
            end if;

            UT_Trace.Trace( 'Fin: [PE_BOValProdSuitRconnectn.ChgStSusPayment.fblIsBalanceServiceOk]', 8 );
            return TRUE;

        EXCEPTION
            when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
                UT_Trace.Trace( 'Error: [PE_BOValProdSuitRconnectn.ChgStSusPayment.fblIsBalanceServiceOk]', 8 );
                raise;
            when OTHERS then
                Errors.SetError;
                UT_Trace.Trace( 'Error no controlado: [PE_BOValProdSuitRconnectn.ChgStSusPayment.fblIsBalanceServiceOk]', 8 );
                raise ex.CONTROLLED_ERROR;
        END fblIsBalanceServiceOk;
     --
    BEGIN

        UT_Trace.Trace('PE_BOValProdSuitRconnectn.ValInfo INICIO',2);

        UT_Trace.Trace('[inuProductId]='||to_char(inuProductId), 2);

        /*Inicializando Flags*/
        nuValCarCast :=0;
        osbFlag      :='N';

        /* Obtiene parámetros */
        GetParameters;

        /* Obtiene producto */
        --rcProduct := DAPR_Product.frcGetRecord(inuProductId);
        rcServsusc := pktblServsusc.frcGetRecord(inuProductId);
        UT_Trace.Trace('[rcServsusc.sesuesco]='||to_char(rcServsusc.sesuesco), 2);

        -- Obtiene record de la suscripcion procesada
        rcSuscripc := pktblsuscripc.frcGetRecord(rcServsusc.sesususc);

        /*Obtiene el valor de la cartera castigada*/
        nuValCarCast:= GC_BCCastigoCartera.fnuObtCarCastPorServS(rcServsusc.sesunuse);
        UT_Trace.Trace('[nuValCarCast]='||nuValCarCast, 2);

        /*Valida si el producto tiene orden de reconexión pendiente por atender */
        MO_BOGENERICVALID.VALPRDHASRECONPAYORD(rcServsusc.sesunuse,osbHasRecPayOrd);
        UT_Trace.Trace('[El producto tiene orden de reconexión pendiente?]='||osbHasRecPayOrd, 2);

        /*Valida si el producto tiene suspensión parcial o total */
        if ((rcServsusc.sesuesco in (gnuCutOffStatusPartial,gnuCutOffStatusTotal,gnuCutOrderSuspension)
           or rcServsusc.sesuserv in (7055, 7056)) AND nuValCarCast=0 AND osbHasRecPayOrd=ge_boConstants.csbNO) then
            UT_Trace.Trace('[El producto tiene suspensión parcial o total]', 4);

            /*Valida que no tenga inclusiones*/
            if not (pkIncludeSuspConnMgr.fblHasIncludePending(rcServsusc.sesunuse)) then
                /*Obtiene el registro de la configuracion del estado de corte*/
                rcSuspStatConf := pkSuspConnServiceMgr.frcGetConfesco(rcServsusc.sesuserv,gnuCutOrderConnection);
                UT_Trace.Trace('[El producto no tiene inclusiones. La Configuración del Estado de Corte es: '||rcSuspStatConf.COECCODI||']', 6);

                /* Valida si existe configuracion de corte y si el producto  cumple con los días mínimos en el estado de corte actual*/
                if rcSuspStatConf.COECCODI IS not null then
                    --if (pkSuspConnServiceMgr.fblValSuspensionDays(rcServsusc.sesunuse,rcSuspStatConf.coecdico,rcServsusc.sesufeco))then
                        --UT_Trace.Trace('[Cumple con los días mínimos en el estado de corte actual]', 8);

                        /*Valida si el porcentaje de deuda cancelado es mayor o igual al porcentaje mínimo configurado
                        para conexión o el número de cuentas vencidas con saldo es menor o igual que el mínimo número configurado para conexión. --PE_BOValProdSuitRconnectn.ChgStSusPayment.fblIsBalanceServiceOk*/
                        if fblIsBalanceServiceOk then
                            UT_Trace.Trace('[El Producto Cumple con todas la validaciones generales]', 8);

                            /* Identifica si se deben validar criterios adicionales de reconex. */
                            sbValCritReconex := dald_parameter.fsbGetValue_Chain('LDC_VAL_CRITERIOS_RECONEX');

                            if (sbValCritReconex = 'Y') then
                                -- Valida criterios adicionales de reconexión
                                sbCritReconex := fsbValCritAdicReconex(rcServsusc.sesunuse);

                                if (sbCritReconex = 'Y') then
                                    UT_Trace.Trace('[El Producto Cumple  con los criterios adicionales de reconexión]', 8);
                                    osbFlag:='S';
                                END if;
                            else
                                osbFlag:='S';
                            END if;
                        end if;
                end if;
            end if;
        end if;
    UT_Trace.Trace('PE_BOValProdSuitRconnectn.GetInfo FIN', 2);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;
        when OTHERS then
            Errors.SetError;
            raise ex.CONTROLLED_ERROR;
    END ValInfo;

END PE_BOValProdSuitRconnectn;
/
PROMPT Otorgando permisos de ejecucion a PE_BOVALPRODSUITRCONNECTN
BEGIN
    pkg_utilidades.praplicarpermisos('PE_BOVALPRODSUITRCONNECTN', 'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecucion sobre PE_BOVALPRODSUITRCONNECTN para reportes
GRANT EXECUTE ON adm_person.PE_BOVALPRODSUITRCONNECTN TO rexereportes;
/