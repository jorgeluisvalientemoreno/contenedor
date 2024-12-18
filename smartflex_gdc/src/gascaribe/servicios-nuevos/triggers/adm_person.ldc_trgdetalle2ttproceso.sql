CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGDETALLE2TTPROCESO
BEFORE INSERT OR UPDATE
ON LDC_DETALLE2_TT_PROCESO
 REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
DECLARE
 /**************************************************************************
		Autor       : Horbath
		Fecha       : 28-06-2021
		Ticket      : 700
		Proceso     : LDC_TRGDETALLE2TTPROCESO
		Descripcion : Trigger para el item.

		HISTORIA DE MODIFICACIONES
		FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/
 nuProductId NUMBER;
 nuValitem number;

 sbmensa varchar2(4000);
 sbPrograOSF varchar(200);
 /*
 ITEM_LEGALIZADO
OT_PROCESO_ID
 */

 cursor cuValitem is
        select 1
		from or_task_types_items ti, LDC_TT_PROCESO tp
		where ti.task_type_id=tp.task_type_id
		and   tp.ot_proceso_id=	:new.OT_PROCESO_ID
		and ti.items_id=:new.ITEM_LEGALIZADO;


BEGIN
	UT_TRACE.TRACE('INICIA LDC_TRGDETALLE2TTPROCESO', 10);

	ut_trace.TRACE('LDC_TRGDETALLE2TTPROCESO nuValitem: '||nuValitem,10);

	IF FBLAPLICAENTREGAXCASO('0000700') and :new.ITEM_LEGALIZADO IS not NULL THEN
		OPEN cuValitem;
		FETCH cuValitem
		INTO nuValitem;
		CLOSE cuValitem;

		if nuValitem is null then
			-- Si el producto no es nulo entonces existen productos de GAS activos
			ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'El ítem no está asociada al tipo de trabajo' );
			  raise ex.CONTROLLED_ERROR;
		end if; --NULL;

	END IF;

UT_TRACE.TRACE('FIN LDC_TRGDETALLE2TTPROCESO', 10);

EXCEPTION
  When ex.controlled_error Then
   Raise ex.controlled_error;
  WHEN OTHERS THEN

      sbmensa := sbmensa ||SQLERRM;
      ERRORS.SETERROR;
      Raise ex.controlled_error;
END LDC_TRGDETALLE2TTPROCESO;
/
