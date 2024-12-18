CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_OS_REASSINGORDER
(
	inuorder           in OR_ORDER.ORDER_ID%TYPE,
	inuOperatunit      in OR_ORDER.OPERATING_UNIT_ID%TYPE,
	idtexecdate        in OR_ORDER.ARRANGED_HOUR%TYPE,
	onuerrorcode       out number,
	osbErrorMessage    out varchar2
)
IS
/**********************************************************************
    Propiedad intelectual de PETI
    Nombre          LDC_OS_REASSINGORDER

    Descripci�n     API que permite reasignar una orden de trabajo, haciendo uso
                    del servicio de Smartflex OR_BOPROCESSORDER.PROCESSREASSINGORDER

    Parametros	       Descripcion
    Entrada:
		inuorder        id de la orden
		inuOperatunit   Id de la Unidad de trabajo al cual se le reasignara la orden
		idtexecdate     Nueva Fecha de ejecucion de la orden
    Salida:
        onuErrorCode:     Codigo de error.
        osbErrorMessage   Mensaje de error.

    Historia de Modificaciones
    Fecha             Autor             Modificaci�n
  ============     ==========      =====================================================
  02/10/2014        oparra          TEAM 1714. Creaci�n procedure
  18/04/2016        FCastro         CA-300-3634 Se valida que la orden no este cerrada
                                    para poder continuar con la reasignacion
  14/05/2024        Paola Acosta    OSF-2674: Cambio de esquema ADM_PERSON  
                                    Retiro marcacion esquema .open objetos de lógica                                     
****************************************************************************************/
cursor cuOrden is
 select order_status_id
   from or_order
  where order_id = inuorder;

nuEstado  or_order.order_status_id%type;

BEGIN

    if (inuorder is null) then
        onuerrorcode    := -1;
        osbErrorMessage := 'No se ingreso el n�mero de la orden';
        return;
    end if;

    if (inuOperatunit is null) then
        onuerrorcode    := -1;
        osbErrorMessage := 'No se ingreso el c�digo de la Unidad Opertativa';
        return;
    end if;

    open cuOrden;
    fetch cuOrden into nuEstado;
    if cuOrden%notfound then
       close cuOrden;
       onuerrorcode    := -1;
       osbErrorMessage := 'No Existe la orden';
       return;
    end if;
    close cuOrden;

    if nuEstado = 8 then
      onuerrorcode    := -1;
      osbErrorMessage := 'Orden en estado 8, no se puede reasignar';
      return;
    end if;


    /*if (idtexecdate is null) then
        onuerrorcode    := -1;
        osbErrorMessage := 'No se ingreso la Nueva fecha de ejecucui�n acordada con el usuario';
        return;
    end if; */

    -- llamar al servicio 'BS' que utiliza el procedimiento de SMF.
    LDC_BOMANAGEADDRESS.ReassingOrder(inuorder, inuOperatunit, idtexecdate, onuerrorcode, osbErrorMessage);
    --


    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);

END LDC_OS_REASSINGORDER;
/
PROMPT Otorgando permisos de ejecucion a LDC_OS_REASSINGORDER
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_OS_REASSINGORDER', 'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecucion sobre LDC_OS_REASSINGORDER para reportes
GRANT EXECUTE ON adm_person.LDC_OS_REASSINGORDER TO rexereportes;
/