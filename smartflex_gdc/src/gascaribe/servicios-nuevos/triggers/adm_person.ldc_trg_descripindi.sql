CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_DESCRIPINDI

/**************************************************************************
        Autor       : Elkin Álvarez / Horbath
        Fecha       : 2019-03-27
        Ticket      : 200-2418
        Descripcion : Trigger de Actualización de la fecha de modificación de la tabla LDC_DESCRIPINDI.


        HISTORIAL DE MODIFICACIONES
        FECHA        	AUTOR       	MODIFICACION


	***************************************************************************/
BEFORE INSERT OR UPDATE
   ON LDC_DESCRIPINDI
   FOR EACH ROW

BEGIN

	IF INSERTING THEN
		:NEW.CREATED_AT := SYSDATE;
		:NEW.UPDATED_AT := SYSDATE;
	ELSE
		:NEW.UPDATED_AT := SYSDATE;
	END IF;


  EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END;
/