CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_GETVALUERP" (inuorder_id or_order.order_id%type, assigned_date OR_order.assigned_date%type)
return number
IS
   /*****************************************************************
   Propiedad intelectual de PETI.

   Unidad         : LDC_UPORDERRP
   Descripcion    : OBJETO QUE DEVUELVE EL VALOR DE LA LISTA DE COSTOS DE LA ACTIVIDAD
                    PRINCIPAL PARA LA ORDEN DADA
   Autor          : llozada
   Fecha          : 13/12/2013

   Parametros              Descripcion
   ============         ===================
   inuorder_id    :     Orden que se legaliza

   Historia de Modificaciones
   Fecha             Autor             Modificacion
   =========       =========           ====================

   ******************************************************************/
   nuorderid              or_order.order_id%TYPE;
   onuIdListaCosto       ge_unit_cost_ite_lis.list_unitary_cost_id%type;
   onuvalue              ge_unit_cost_ite_lis.price%type;
   onuPrecioVentaItem    ge_unit_cost_ite_lis.sales_value%type;
   nuAddressId           OR_ORDER_ACTIVITY.Address_Id%type;
   inuGeoLocationId      ab_address.geograp_location_id%type;
   nuItem                number;

   CURSOR cuActivity(inuOrder_id or_order_activity.order_id%type)
   IS
        SELECT activity_id, address_id
        FROM or_order_activity
        WHERE  order_id = inuOrder_id
            AND register_date = (
                SELECT min (or_order_activity.register_date)
                FROM or_order_activity
                WHERE order_id = inuOrder_id);
BEGIN

    -- orden que se legaliza
   nuorderid :=inuorder_id;

   open cuActivity(nuorderid);
   fetch cuActivity INTO nuItem, nuAddressId;
   close cuActivity;

   if nuItem is null  then
        ge_boerrors.setErrorcodeargument(PKG_ERROR.CNUGENERIC_MESSAGE,
                   'No se encuentra la Actividad asociada a la Orden');
   end if;

    SELECT geograp_location_id
    into   inuGeoLocationId
    FROM   ab_address
    WHERE  ADDRESS_ID = nuAddressId;

    GE_BCCertContratista.ObtenerCostoItemLista
                (
                    nuItem,             --IN  ge_unit_cost_ite_lis.items_id%type,
                    assigned_date, --daor_order.fdtgetassigned_date(nuorderid,null),--(inuorderid,null),   --IN  or_order.assigned_date%type,
                    inuGeoLocationId   ,   --IN  ge_list_unitary_cost.geograp_location_id%type,
                    NULL    ,    --IN  ge_list_unitary_cost.contractor_id%type,
                    NULL    ,     --IN  ge_list_unitary_cost.operating_unit_id%type,
                    NULL,           --IN  ge_list_unitary_cost.contract_id%type,
                    onuIdListaCosto,       --OUT ge_unit_cost_ite_lis.list_unitary_cost_id%type,
                    onuvalue,--onuCostoItem    ,      --OUT ge_unit_cost_ite_lis.price%type,
                    onuPrecioVentaItem    --OUT ge_unit_cost_ite_lis.sales_value%type
                );

    return onuPrecioVentaItem;

EXCEPTION
    when pkg_error.controlled_error then
        pkg_error.setError;
         RAISE pkg_error.controlled_error;
   WHEN OTHERS
   THEN
      pkg_error.setError;
      RAISE pkg_error.controlled_error;
END LDC_GETVALUERP;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_GETVALUERP', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_GETVALUERP TO REXEREPORTES;
/