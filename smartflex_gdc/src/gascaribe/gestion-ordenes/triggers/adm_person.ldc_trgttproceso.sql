CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGTTPROCESO
BEFORE INSERT OR UPDATE
ON LDC_TT_PROCESO
 REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
DECLARE
 /**************************************************************************
		Autor       : Horbath
		Fecha       : 27-06-2021
		Ticket      : 700
		Proceso     : LDC_TRGTTPROCESO
		Descripcion : Trigger para valir el tipo de trabajo y causal.

		HISTORIA DE MODIFICACIONES
		FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/
 nuProductId NUMBER;
 nuValcausal number;

 sbmensa varchar2(4000);
 sbPrograOSF varchar(200);
 /*
 CAUSAL_ID
OT_PROCESO_ID
TASK_TYPE_ID
 */

 cursor cuValcausal is
        select 1
		from or_task_type_causal
		where task_type_id=:new.TASK_TYPE_ID
		and causal_id=:new.CAUSAL_ID ;


BEGIN
	UT_TRACE.TRACE('INICIA LDC_TRGTTPROCESO', 10);


	ut_trace.TRACE('LDC_TRGTTPROCESO nuValcausal: '||nuValcausal,10);

	IF FBLAPLICAENTREGAXCASO('0000700') and :new.CAUSAL_ID IS not NULL THEN
		OPEN cuValcausal;
		FETCH cuValcausal
		INTO nuValcausal;
		CLOSE cuValcausal;

		if nuValcausal is null then
			-- Si el producto no es nulo entonces existen productos de GAS activos
			ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'La causal no está asociada al tipo de trabajo' );
			  raise ex.CONTROLLED_ERROR;
		end if; --NULL;

	END IF;

UT_TRACE.TRACE('FIN LDC_TRGTTPROCESO', 10);

EXCEPTION
  When ex.controlled_error Then
   Raise ex.controlled_error;
  WHEN OTHERS THEN

      sbmensa := sbmensa ||SQLERRM;
      ERRORS.SETERROR;
      Raise ex.controlled_error;
END LDC_TRGTTPROCESO;
/
