CREATE OR REPLACE PACKAGE ADM_PERSON.LD_BCQUOTATRANSFER IS
    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         :    LD_BCQUOTATRANSFER
    Descripcion    :    Paquete que contiene la lógica de negocio del proceso
                        traslado de cupo.
    Autor          :    Jorge Alejandro Carmona Duque
    Fecha          :    10/09/2013

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    --------        ----------          --------------
    06-12-2013      hjgomez.SAO226367   Se crea <<fnuTotalTransferedBySusc>>
    12-11-2013      sgomez.SAO222244    Se modifica método <UpdQuotaTrnsfrStatus>
                                        para actualización de estado de solicitud
                                        y fecha de rechazo.

    06-11-2013      sgomez.SAO222244    Se adiciona método <UpdQuotaTrnsfrStatus>
                                        para actualización de estado de aprobación.

    02/10/2013      LDiuza.SAO218144       Se modifica el metodo <GetConsSalebyOrder>
    12/09/2013      mmeusburgger.SAO212252 Se agrega el metodo
                                            - <<GetConsSalebyOrder>>
    10/09/2013      JCarmona.SAO211751     Creación.
    ******************************************************************/

    ----------------------------------------------------------------------------

    --------------------------------------------
    -- Tipos y Estructuras de Datos
    --------------------------------------------
    /*****************************************************************
    Unidad   :      tyrcOrderData
    Descripcion	:   Información de la Orden.

    Historia de Modificaciones
    Fecha	    IDEntrega
    =========== ================================================================
    12-09-2010  hvera.SAO211751     Creación
    ******************************************************************/
    type tyrcOrderData is record
    (
        nuOrderId              OR_order_activity.order_id%type      -- Código de la orden
    );

    type tytbOrderData is table of tyrcOrderData INDEX BY binary_integer;

    /***************************************************************************
    Propiedad intelectual de Open International Systems (c).

    Procedure   :   fsbVersion
    Descripcion :   Obtiene la versión del paquete.

    Autor       :   Jorge Alejandro Carmona Duque
    Fecha       :   10-09-2013
    Parametros  :

    Historia de Modificaciones
    Fecha	    IDEntrega               Descripcion
    ==========  ======================= ========================================
    10-09-2013  JCarmona.SAO211751      Creación.
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2;

    /***************************************************************************
    Propiedad intelectual de Open International Systems (c).

    Procedure   :   fnuCountOrderAct
    Descripcion :   Retorna la cantidad de órdenes pendientes de aprobación para
                    la solicitud y la actividad dadas.

    Autor       :   Jorge Alejandro Carmona Duque
    Fecha       :   10-09-2013
    Parametros  :
        nuPackOrActId:      Identificador de la Solicitud.
        nuActivityId:       Actividad de

    Historia de Modificaciones
    Fecha	    IDEntrega               Descripcion
    ==========  ======================= ========================================
    10-09-2013  JCarmona.SAO211751      Creación.
    ***************************************************************************/
    FUNCTION fnuCountOrderAct
    (
        inuPackOrActId  in  OR_order_activity.package_id%type,
        inuActivityId   in  OR_order_activity.activity_id%type
    )
    RETURN number;

    /***************************************************************************
    Propiedad intelectual de Open International Systems (c).

    Procedure   :   GetConsSalebyOrder
    Descripcion :   Retorna el Consecutivo de una venta
    Autor       :   Mahicol meusburgger
    Fecha       :   12-09-2013
    Parametros  :
        inuPackageId:    Identificador del la financiacion no bancaria
        onuConsSale:     Consecutivo de la venta

    Historia de Modificaciones
    Fecha	    IDEntrega               Descripcion
    ==========  ======================= ========================================
    12-09-2013  mmeusburgger.SAO212252     Creación.
    ***************************************************************************/
    PROCEDURE GetConsSalebyOrder
    (
        inuPackageId    in  mo_packages.package_id%type,
        osbConsSale     out ld_non_ba_fi_requ.digital_prom_note_cons%type
    );

    /***************************************************************************
    Propiedad intelectual de Open International Systems (c).

    Procedure   :   ftbDataOrderAct
    Descripcion :   Retorna la tabla de órdenes pendientes de aprobación para
                    la solicitud y la actividad dadas.

    Autor       :   hvera
    Fecha       :   12-09-2013
    Parametros  :
        nuPackOrActId:      Identificador de la Solicitud.
        nuActivityId:       Actividad de

    Historia de Modificaciones
    Fecha	    IDEntrega               Descripcion
    ==========  ======================= ========================================
    12-09-2013  hvera.SAO211751      Creación.
    ***************************************************************************/
    FUNCTION ftbDataOrderAct
    (
        inuPackOrActId  in  OR_order_activity.package_id%type,
        inuActivityId   in  OR_order_activity.activity_id%type
    )
    RETURN tytbOrderData;

    FUNCTION fsbGetConsecutive
    (
        inuManualCons   in ld_non_ba_fi_requ.manual_prom_note_cons%type,
        inuDigitalCons  in ld_non_ba_fi_requ.digital_prom_note_cons%type
    )
    RETURN varchar2;

    FUNCTION ftbDataOrderLeg
    (
        inuPackOrActId  in  OR_order_activity.package_id%type,
        inuActivityId   in  OR_order_activity.activity_id%type
    )
    RETURN tytbOrderData;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  UpdQuotaTrnsfrStatus
    Descripcion :  Actualiza estado aprobación en transferencia de cuota.

    Autor       :  Santiago Gómez Rico
    Fecha       :  06-11-2013
    Parametros  :  inuPackageId     Solicitud de venta.
                   inuAppStatus     Estado de aprobación al cual actualizar.
                   inuPackStatus    Estado de la solicitud.
                   idtRejctnDate    Fecha de rechazo.

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    12-11-2013   sgomez.SAO222244   Se modifica método para actualización de
                                    estado de solicitud y fecha de rechazo.

    06-11-2013   sgomez.SAO222244   Creación.
    ***************************************************************/
    PROCEDURE UpdQuotaTrnsfrStatus
    (
        inuPackageId    in  ld_quota_transfer.package_id%type,
        inuAppStatus    in  ld_quota_transfer.approved%type,
        inuPackStatus   in  ld_quota_transfer.status%type,
        idtRejctnDate   in  ld_quota_transfer.reject_date%type
    );

    /**************************************************************
    Unidad      :  fnuTotalTransferedBySusc
    Descripcion :  Obtiene el total de los traslados de cupo exitosos de un contrato.
    ***************************************************************/
    FUNCTION fnuTotalTransferedBySusc
    (
        inuSuscriptionId  in  suscripc.susccodi%type
    )
    RETURN number;
END LD_BCQUOTATRANSFER;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LD_BCQUOTATRANSFER IS

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         :    LD_BCQUOTATRANSFER
    Descripcion    :    Paquete que contiene la lógica de negocio del proceso
                        traslado de cupo.
    Autor          :    Jorge Alejandro Carmona Duque
    Fecha          :    10/09/2013

    Historia de Modificaciones
    Fecha           Autor               Modificacion
    --------        ----------          --------------
    06-12-2013      hjgomez.SAO226367   Se crea <<fnuTotalTransferedBySusc>>
    12-11-2013      sgomez.SAO222244    Se modifica método <UpdQuotaTrnsfrStatus>
                                        para actualización de estado de solicitud
                                        y fecha de rechazo.

    06-11-2013      sgomez.SAO222244    Se adiciona método <UpdQuotaTrnsfrStatus>
                                        para actualización de estado de aprobación.

    10/09/2013      JCarmona.SAO211751  Creación.
    ******************************************************************/

    -- Declaración de variables y tipos globales privados del paquete
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO226367';

    ----------------------------------------------------------------------------
	-- Definicion de metodos privados del paquete
    ----------------------------------------------------------------------------

    ----------------------------------------------------------------------------
    FUNCTION fsbVersion  return varchar2 IS
    BEGIN
        return csbVersion;
    END;

    ----------------------------------------------------------------------------

    FUNCTION fnuCountOrderAct
    (
        inuPackOrActId  in  OR_order_activity.package_id%type,
        inuActivityId   in  OR_order_activity.activity_id%type
    )
    RETURN number
    IS

        /* Retorna la cantidad de órdenes registradas */
        CURSOR cuCountOrderAct
        (
            nuPackOrActId OR_order_activity.package_id%type,
            nuActivityId OR_order_activity.action_id%type
        )
        IS
            SELECT count(*)
            FROM OR_order_activity o
            WHERE o.package_id = nuPackOrActId
            AND o.activity_id = nuActivityId
            AND o.status = 'R';

        nuCountOrderAct number;

    BEGIN

        UT_Trace.Trace('Inicio LD_BCQUOTATRANSFER.fnuCountOrderAct['||inuPackOrActId||']['||inuActivityId||']',2);

        --Obtiene los datos a retornar.
        open cuCountOrderAct(inuPackOrActId,inuActivityId);
            fetch cuCountOrderAct INTO nuCountOrderAct;
        close cuCountOrderAct;

        ut_trace.Trace('Cantidad de órdenes por aprobar: '||nuCountOrderAct,1);
        UT_Trace.Trace('FIN LD_BCQUOTATRANSFER.fnuCountOrderAct',2);
        return nuCountOrderAct;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            if cuCountOrderAct%isopen then
                close cuCountOrderAct;
            END if;
            raise ex.CONTROLLED_ERROR;
        when others then
            if cuCountOrderAct%isopen then
                close cuCountOrderAct;
            END if;
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fnuCountOrderAct;

    FUNCTION fsbGetConsecutive
    (
        inuManualCons   in ld_non_ba_fi_requ.manual_prom_note_cons%type,
        inuDigitalCons  in ld_non_ba_fi_requ.digital_prom_note_cons%type
    )
    RETURN varchar2
    IS
        sbConsecutive   varchar2(4000);
    BEGIN

        UT_Trace.Trace('Inicio LD_BCQUOTATRANSFER.fsbGetConsecutive  inuManualCons['||inuManualCons||'] inuDigitalCons['||inuDigitalCons||']',2);

        if(inuManualCons IS not null) then
            sbConsecutive := inuManualCons||' - '||'Impreso';
        else
            sbConsecutive := inuDigitalCons||' - '||'Digital';
        END if;

        ut_trace.Trace('sbConsecutive: '||sbConsecutive,1);
        UT_Trace.Trace('FIN LD_BCQUOTATRANSFER.fsbGetConsecutive',2);
        return sbConsecutive;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fsbGetConsecutive;

    /***************************************************************************
    Propiedad intelectual de Open International Systems (c).

    Procedure   :   GetConsSalebyOrder
    Descripcion :   Retorna el Consecutivo de una venta
    Autor       :   Mahicol meusburgger
    Fecha       :   12-09-2013
    Parametros  :
        inuOrderId:      Identificador de la Orden
        onuConsSale:     Consecutivo de la venta

    Historia de Modificaciones
    Fecha	    IDEntrega               Descripcion
    ==========  ======================= ========================================
    02-10-2013  LDiuza.SAO2018144          Se modifica el CURSOR  para que busque
                                           el consecutivo solo teniendo en cuenta el
                                           numero de la solicitud como condicion de
                                           filtro.
                                           Se Modifica el llamado <fsbGetConsecutive>
                                           para enviar correctamente los consecutivos.
    12-09-2013  mmeusburgger.SAO212252     Creación.
    ***************************************************************************/
    PROCEDURE GetConsSalebyOrder
    (
        inuPackageId    in  mo_packages.package_id%type,
        osbConsSale     out ld_non_ba_fi_requ.digital_prom_note_cons%type
    )
    IS
        CURSOR cuConsSale(inuPackageId IN mo_packages.package_id%type) IS
            SELECT LD_BCQUOTATRANSFER.fsbGetConsecutive(ld_non_ba_fi_requ.manual_prom_note_cons, ld_non_ba_fi_requ.digital_prom_note_cons)
            FROM or_order_activity, ld_non_ba_fi_requ
            WHERE ld_non_ba_fi_requ.non_ba_fi_requ_id = inuPackageId;

    BEGIN
        ut_trace.trace('[INICIO]LD_BCQUOTATRANSFER.GetConsSalebyOrder',1);

         open cuConsSale(inuPackageId);
         fetch cuConsSale INTO osbConsSale;
         close cuConsSale;

        ut_trace.trace('[FINAL]LD_BCQUOTATRANSFER.GetConsSalebyOrder',1);

        EXCEPTION
            when ex.CONTROLLED_ERROR then
                if cuConsSale%isopen then
                close cuConsSale;
            END if;
                raise ex.CONTROLLED_ERROR;
            when others then
            if cuConsSale%isopen then
                close cuConsSale;
            END if;
                Errors.setError;
                raise ex.CONTROLLED_ERROR;
    END GetConsSalebyOrder;

    FUNCTION ftbDataOrderAct
    (
        inuPackOrActId  in  OR_order_activity.package_id%type,
        inuActivityId   in  OR_order_activity.activity_id%type
    )
    RETURN tytbOrderData
    IS

        /* Retorna la cantidad de órdenes registradas */
        CURSOR cuCountOrderAct
        (
            nuPackOrActId OR_order_activity.package_id%type,
            nuActivityId OR_order_activity.action_id%type
        )
        IS
            SELECT o.order_id
            FROM OR_order_activity o
            WHERE o.package_id = nuPackOrActId
            AND o.activity_id = nuActivityId
            AND o.status = 'R';

        tbOrder tytbOrderData;

    BEGIN

        UT_Trace.Trace('Inicio LD_BCQUOTATRANSFER.ftbDataOrderAct['||inuPackOrActId||']['||inuActivityId||']',2);

        --Obtiene los datos a retornar.
        open cuCountOrderAct(inuPackOrActId,inuActivityId);
            fetch cuCountOrderAct bulk collect into tbOrder;
        close cuCountOrderAct;

        ut_trace.Trace('Cantidad de órdenes por aprobar: '||tbOrder.count,1);
        UT_Trace.Trace('FIN LD_BCQUOTATRANSFER.ftbDataOrderAct',2);
        return tbOrder;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            if cuCountOrderAct%isopen then
                close cuCountOrderAct;
            END if;
            raise ex.CONTROLLED_ERROR;
        when others then
            if cuCountOrderAct%isopen then
                close cuCountOrderAct;
            END if;
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END ftbDataOrderAct;

    FUNCTION ftbDataOrderLeg
    (
        inuPackOrActId  in  OR_order_activity.package_id%type,
        inuActivityId   in  OR_order_activity.activity_id%type
    )
    RETURN tytbOrderData
    IS

        /* Retorna la cantidad de órdenes registradas */
        CURSOR cuCountOrderAct
        (
            nuPackOrActId OR_order_activity.package_id%type,
            nuActivityId OR_order_activity.action_id%type
        )
        IS
            SELECT o.order_id
            FROM OR_order_activity o
            WHERE o.package_id = nuPackOrActId
            AND o.activity_id = nuActivityId;

        tbOrder tytbOrderData;

    BEGIN

        UT_Trace.Trace('Inicio LD_BCQUOTATRANSFER.ftbDataOrderLeg['||inuPackOrActId||']['||inuActivityId||']',2);

        --Obtiene los datos a retornar.
        open cuCountOrderAct(inuPackOrActId,inuActivityId);
            fetch cuCountOrderAct bulk collect into tbOrder;
        close cuCountOrderAct;

        ut_trace.Trace('Cantidad de órdenes por aprobar: '||tbOrder.count,1);
        UT_Trace.Trace('FIN LD_BCQUOTATRANSFER.ftbDataOrderLeg',2);
        return tbOrder;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            if cuCountOrderAct%isopen then
                close cuCountOrderAct;
            END if;
            raise ex.CONTROLLED_ERROR;
        when others then
            if cuCountOrderAct%isopen then
                close cuCountOrderAct;
            END if;
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END ftbDataOrderLeg;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  UpdQuotaTrnsfrStatus
    Descripcion :  Actualiza estado aprobación en transferencia de cuota.

    Autor       :  Santiago Gómez Rico
    Fecha       :  06-11-2013
    Parametros  :  inuPackageId     Solicitud de venta.
                   inuAppStatus     Estado de aprobación al cual actualizar.
                   inuPackStatus    Estado de la solicitud.
                   idtRejctnDate    Fecha de rechazo.

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    12-11-2013   sgomez.SAO222244   Se modifica método para actualización de
                                    estado de solicitud y fecha de rechazo.

    06-11-2013   sgomez.SAO222244    Creación.
    ***************************************************************/
    PROCEDURE UpdQuotaTrnsfrStatus
    (
        inuPackageId    in  ld_quota_transfer.package_id%type,
        inuAppStatus    in  ld_quota_transfer.approved%type,
        inuPackStatus   in  ld_quota_transfer.status%type,
        idtRejctnDate   in  ld_quota_transfer.reject_date%type
    )
    IS
    BEGIN

        UT_Trace.Trace('Inicio LD_BCQUOTATRANSFER.UpdQuotaTrnsfrStatus ['||inuPackageId||']', 1);

        UPDATE  --+ index_rs_asc(ld_quota_transfer IX_LD_QUOTA_TRANSFER_04)
                ld_quota_transfer
        SET     ld_quota_transfer.approved    = inuAppStatus,
                ld_quota_transfer.status      = inuPackStatus,
                ld_quota_transfer.reject_date = idtRejctnDate
        WHERE   ld_quota_transfer.package_id  = inuPackageId;

        ut_trace.trace('Inicio LD_BCQUOTATRANSFER.UpdQuotaTrnsfrStatus ['||inuPackageId||']', 1);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when OTHERS then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END UpdQuotaTrnsfrStatus;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  fnuTotalTransferedBySusc
    Descripcion :  Obtiene el total de los traslados de cupo exitosos de un contrato.

    Autor       :  Joiman Gomez
    Fecha       :  06-12-2013
    Parametros  :  inuSuscriptionId     Contrato


    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    06-12-2013   hjgomez.SAO226367   Creación.
    ***************************************************************/
    FUNCTION fnuTotalTransferedBySusc
    (
        inuSuscriptionId  in  suscripc.susccodi%type
    )
    RETURN number
    IS

        /* Retorna la cantidad de órdenes registradas */
        CURSOR cuApprovedQuota
        IS
            SELECT  sum(trasnfer_value)
            FROM    ld_quota_transfer
            WHERE   origin_subscrip_id= inuSuscriptionId
            AND approved='Y';

        nuTotalQuote number;

    BEGIN

        UT_Trace.Trace('Inicio LD_BCQUOTATRANSFER.fnuTotalTransferedBySusc['||inuSuscriptionId||']',2);

        --Obtiene los datos a retornar.
        open cuApprovedQuota;
            fetch cuApprovedQuota INTO nuTotalQuote;
        close cuApprovedQuota;

        UT_Trace.Trace('FIN LD_BCQUOTATRANSFER.fnuTotalTransferedBySusc. Cupo: '||nuTotalQuote,2);
        return nuTotalQuote;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            if cuApprovedQuota%isopen then
                close cuApprovedQuota;
            END if;
            raise ex.CONTROLLED_ERROR;
        when others then
            if cuApprovedQuota%isopen then
                close cuApprovedQuota;
            END if;
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fnuTotalTransferedBySusc;

END LD_BCQUOTATRANSFER;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('LD_BCQUOTATRANSFER', 'ADM_PERSON'); 
END;
/
