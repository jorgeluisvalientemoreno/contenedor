CREATE OR REPLACE PACKAGE adm_person.LD_BCApprove_Sales_Order
IS
    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : LD_BCApprove_Sales_Order
    Descripcion    : Paquete de primer nivel para la entidad
                     <LD_Approve_Sales_Order>.
    Autor          : Santiago Gómez Rico
    Fecha          : 06-11-2013

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    20/06/2024        PAcosta           OSF-2845: Cambio de esquema ADM_PERSON 
    06-11-2013        sgomez.SAO222244  Creación.
    ******************************************************************/

    FUNCTION FSBVERSION
    RETURN VARCHAR2;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  UpdSaleOrderStatus
    Descripcion :  Actualiza estado aprobación en orden de venta.

    Autor       :  Santiago Gómez Rico
    Fecha       :  06-11-2013
    Parametros  :  inuPackageId     Solicitud de venta.
                   inuAppStatus     Estado de aprobación al cual actualizar.

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    06-11-2013   sgomez.SAO222244    Creación.
    ***************************************************************/
    PROCEDURE UpdSaleOrderStatus
    (
        inuPackageId    in  ld_approve_sales_order.package_id%type,
        inuAppStatus    in  ld_approve_sales_order.approved%type
    );

END LD_BCApprove_Sales_Order;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LD_BCApprove_Sales_Order
IS
    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Package	: LD_BCApprove_Sales_Order
    Descripción	: Paquete de primer nivel para la entidad
                  <LD_Approve_Sales_Order>.

    Autor	: Santiago Gómez Rico
    Fecha	: 06-11-2013

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    06-11-2013        sgomez.SAO222244  Creación.
    ******************************************************************/

    --------------------------------------------
    -- Constantes VERSION DEL PAQUETE
    --------------------------------------------
    csbVERSION                  CONSTANT VARCHAR2(10) := 'SAO222244';

    --------------------------------------------
    -- Funciones y Procedimientos PRIVADAS DEL PAQUETE
    --------------------------------------------

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  FSBVERSION
    Descripcion :  Obtiene versión del paquete.

    Autor       :  Santiago Gómez Rico
    Fecha       :  06-11-2013

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    06-11-2013   sgomez.SAO222244   Creación.
    ***************************************************************/
    FUNCTION FSBVERSION
    RETURN VARCHAR2 IS
    BEGIN
        return CSBVERSION;
    END FSBVERSION;

    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  UpdSaleOrderStatus
    Descripcion :  Actualiza estado aprobación en orden de venta.

    Autor       :  Santiago Gómez Rico
    Fecha       :  06-11-2013
    Parametros  :  inuPackageId     Solicitud de venta.
                   inuAppStatus     Estado de aprobación al cual actualizar.

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    06-11-2013   sgomez.SAO222244    Creación.
    ***************************************************************/
    PROCEDURE UpdSaleOrderStatus
    (
        inuPackageId    in  ld_approve_sales_order.package_id%type,
        inuAppStatus    in  ld_approve_sales_order.approved%type
    )
    IS
    BEGIN

        UT_Trace.Trace('Inicio LD_BCApprove_Sales_Order.UpdSaleOrderStatus ['||inuPackageId||']', 1);

        UPDATE  --+ index_rs_asc(ld_approve_sales_order UX_LD_APPR_SALES_ORDER_02)
                ld_approve_sales_order
        SET     ld_approve_sales_order.approved   = inuAppStatus
        WHERE   ld_approve_sales_order.package_id = inuPackageId;

        ut_trace.trace('Inicio LD_BCApprove_Sales_Order.UpdSaleOrderStatus ['||inuPackageId||']', 1);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when OTHERS then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END UpdSaleOrderStatus;

END LD_BCApprove_Sales_Order;
/
PROMPT Otorgando permisos de ejecucion a LD_BCAPPROVE_SALES_ORDER
BEGIN
    pkg_utilidades.praplicarpermisos('LD_BCAPPROVE_SALES_ORDER', 'ADM_PERSON');
END;
/