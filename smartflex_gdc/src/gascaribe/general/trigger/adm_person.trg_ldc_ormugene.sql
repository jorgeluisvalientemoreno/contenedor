CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_LDC_ORMUGENE  BEFORE INSERT OR  UPDATE  ON LDC_ORMUGENE  FOR EACH ROW
/**************************************************************************
  Autor       : Luis Javier Lopez Barrios / Horbath
  Fecha       : 2017-02-06
  Ticket      : 200-1132
  Descripcion : Trigger que valida logica de la forma LDC_MAORMUGENE.


  Parametros Entrada

  Valor de salida

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR        DESCRIPCION
  18/10/2023   jpinedc      OSF-3383: Se migra a ADM_PERSON
***************************************************************************/
DECLARE

    sbExiste VARCHAR2(1);  --Ticket 200-1132  LJLB -- Se almacena dato si existe datos
    sbMensError VARCHAR2(100); --Ticket 200-1132  LJLB -- Se almacena el mensaje de error
    nuErrorCode NUMBER := 2;  --Ticket 200-1132  LJLB -- Se almacena codigo de error


    erExiste EXCEPTION;  --Ticket 200-1132  LJLB -- Se almacena excepcion si existe persona

BEGIN
  pkerrors.Push('TRG_LDC_ORMUGENE');


   --Ticket 200-1132  LJLB -- Se valida que el registro no este aprobado
   IF :OLD.ORMGPROC = 'S' THEN
      sbMensError := 'Registro ya se encuentra Aprobado, no se puede hacer Cambio';
      RAISE erExiste;
  END IF;

  --Ticket 200-1132  LJLB -- Se valida que el valor  sea mayor que cero
  IF NVL(:NEW.ORMGVAMU,0) <= 0 THEN
    sbMensError := 'Valor no puede ser menor o igual a cero';
    RAISE erExiste;
  END IF;

  pkErrors.Pop;
EXCEPTION
  WHEN erExiste THEN
       Errors.SetError(nuErrorCode);
       Errors.SETMESSAGE(sbMensError);
       RAISE ex.CONTROLLED_ERROR;
    WHEN ex.CONTROLLED_ERROR THEN
        raise;
    WHEN OTHERS THEN
        Errors.setError;
        sbMensError := sqlerrm;
        Errors.SETMESSAGE(substr(sbMensError,1,40));
        raise ex.CONTROLLED_ERROR;
END;
/
