CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_CTRL_PERS_EXT BEFORE
  INSERT OR
  UPDATE ON LDC_CTRL_PERS_EXT REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
/************************************************************************
PROPIEDAD INTELECTUAL DE PETI . 2013
TRIGGER           : LDC_TRG_CTRL_PERS_EXT
AUTOR             : EMIRO LEYVA
FECHA             : 28 de JUNIO de 2013
DESCRIPCION       : actualiza el campo IS_ACTIVE en la tabla de control de personas externas
                    donde se guarda la fecha de ingreso del vendedor a la firma contratista

Parametros de Entrada
Parametros de Salida
Historia de Modificaciones
Autor   Fecha   Descripcion
************************************************************************/
DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;

  nuCodigoError       NUMBER;
  sbMensajeError      VARCHAR2(4000);

BEGIN

    IF :old.IS_ACTIVE = 'N' THEN
       errors.seterror(2741, 'Este registro no se puede modificar ya que se encuentra en estado INACTIVO');
       RAISE ex.controlled_error;
    END IF;

    IF inserting THEN
       IF :new.fecha_retiro is null then
          :new.IS_ACTIVE := 'Y';
       else
          :new.IS_ACTIVE := 'N';
       end if;
	   if :new.FECHA_INGRESO > sysdate then
          errors.seterror(2741, 'La fecha de ingreso no puede ser mayor a la fecha actual');
          RAISE ex.controlled_error;
       END IF;
       if :new.FECHA_RETIRO > sysdate then
          errors.seterror(2741, 'La fecha de retiro no puede ser mayor a la fecha actual');
          RAISE ex.controlled_error;
       END IF;
    elsif updating  THEN
       IF (:OLD.FECHA_RETIRO <> :new.fecha_retiro) OR :new.fecha_retiro is not null then
          :new.IS_ACTIVE := 'N';
       end if;
	   if :new.FECHA_INGRESO > sysdate then
           errors.seterror(2741, 'La fecha de ingreso no puede ser mayor a la fecha actual');
           RAISE ex.controlled_error;
       END IF;
       if :new.FECHA_RETIRO > sysdate then
          errors.seterror(2741, 'La fecha de retiro no puede ser mayor a la fecha actual');
          RAISE ex.controlled_error;
       END IF;
    END IF;

EXCEPTION

    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 THEN
        pkErrors.GetErrorVar( nuCodigoError, sbMensajeError );
        RAISE;
    when others then

        pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbMensajeError );
        RAISE;
END;
/
