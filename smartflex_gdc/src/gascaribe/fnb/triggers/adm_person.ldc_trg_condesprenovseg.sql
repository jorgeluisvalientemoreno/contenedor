CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_CONDESPRENOVSEG
/**************************************************************************

  UNIDAD      :  LDC_TRG_CONDESPRENOVSEG
  Descripcion :  Trigger que hace el insert del usuario en la tabla LDC_CONDESPRENOVSEG
  Fecha       :  03-11-2020
  AUTOR       :  Miguel Ballesteros

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================

  **************************************************************************/
BEFORE INSERT OR UPDATE ON LDC_CONDESPRENOVSEG
FOR EACH ROW
BEGIN
     ut_trace.trace('INICIA  TRIGGER LDC_TRG_CONDESPRENOVSEG ',1);

	 -- se establece el valor del usuario conectado en la tabla
	 :NEW.IDENT_USER := open.ge_bopersonal.fnuGetPersonId;

     if(:NEW.FECHA_REG is null)then
        :NEW.FECHA_REG := SYSDATE;
     end if;

     ut_trace.trace('INICIA  TRIGGER LDC_TRG_CONDESPRENOVSEG ',1);

    EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END;
/
