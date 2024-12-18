CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_LDC_ITEM_UO_LR
BEFORE INSERT OR UPDATE ON  LDC_ITEM_UO_LR
FOR EACH ROW
DECLARE
  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Trigger     : LDC_TRG_LDC_ITEM_UO_LR
  Descripcion : Trigger para controlar el ingreso de items en la forma LDCCUAI.
                Consiste en validar si el tipo de trabajo del item a configurar corresponde
                al tipo de trabajo de la actividad que se esta registrando.
  Autor       : Sebastian Tapias || 200-1261
  Fecha       : 13-07-2017

  Historia de Modificaciones

    Fecha               Autor                Modificacion
  =========           =========          ====================
  26/11/2019		DSALTARIN			244-Se modifica para que permita realizar la validación cuando la actividad no sea nula o -1
  ***************************************************************************************/
  /*Variable para almacenar fecha actual*/
  x         number;
BEGIN
  /*Validamos si el tipo de trabajo del item es igual a tipo de trabajo que tiene registrado la actividad*/

	if fblaplicaentregaxcaso('0000244') then
		if :new.actividad is not null and :new.actividad!=-1 and :new.item != -1 then
			x := 0;
			SELECT COUNT(1)
				INTO x
			FROM OR_TASK_TYPES_ITEMS OTTI
			WHERE OTTI.ITEMS_ID = :new.actividad
				AND OTTI.TASK_TYPE_ID in
				(SELECT OTT.TASK_TYPE_ID
				FROM OR_TASK_TYPES_ITEMS OTT
				WHERE OTT.ITEMS_ID = :new.item);
			/*En caso de no tener ningun registro mandaremos error*/
			if x = 0 then
				dbms_output.put_line('El Item'||:new.item||'NO se encuentra asociado con el tipo de trabajo de la actividad');
				errors.seterror(-1,
				'El Item'||:new.item||'NO se encuentra asociado con el tipo de trabajo de la actividad');
				RAISE ex.controlled_error;
			end if;
		end if;
	end if;
EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    RAISE;
  WHEN others THEN
    RAISE;
END;
/
