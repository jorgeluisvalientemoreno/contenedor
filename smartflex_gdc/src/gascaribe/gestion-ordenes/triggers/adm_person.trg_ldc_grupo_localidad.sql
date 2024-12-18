CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_LDC_GRUPO_LOCALIDAD BEFORE INSERT or UPDATE  ON LDC_GRUPO_LOCALIDAD  FOR EACH ROW
/**************************************************************************
  Autor       : Josh Brito / Horbath
  Fecha       : 2017-04-04
  Ticket      : 200-1090
  Descripcion : Trigger que valida logica de la forma LDC_MACOMCTT


  Parametros Entrada

  Valor de salida

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/
DECLARE
   PRAGMA AUTONOMOUS_TRANSACTION;

    sbExiste VARCHAR2(1);  --Ticket 200-1090  JGBA -- Se almacena dato si existe datos
    sbMensError VARCHAR2(100); --Ticket 200-1090  JGBA -- Se almacena el mensaje de error
    nuErrorCode NUMBER := 2;  --Ticket 200-1090  JGBA -- Se almacena codigo de error

    --Ticket 200-1090  JGBA -- Se consulta si existe combinacion grupo, localidad y sector operativo
    CURSOR cuExisteCombGrupLocaSetOp IS
    SELECT 'X'
    FROM LDC_GRUPO_LOCALIDAD
    WHERE GRUPCODI = :NEW.GRUPCODI AND
		  GRLOIDLO = :NEW.GRLOIDLO AND
		  GRLOSEOP = :NEW.GRLOSEOP  ;


    erExiste EXCEPTION;  --Ticket 200-1090  JGBA -- Se almacena excepcion si existe persona

BEGIN
  pkerrors.Push('TRG_LDC_GRUPO_LOCALIDAD');

 --IF INSERTING THEN
     --Ticket 200-1090  JGBA -- Se realiza consulta si existe o no combinacion Grupo, Localidad y sector operativo
    OPEN cuExisteCombGrupLocaSetOp;
    FETCH cuExisteCombGrupLocaSetOp INTO sbExiste;
    IF cuExisteCombGrupLocaSetOp%FOUND  AND (:NEW.GRUPCODI <> :OLD.GRUPCODI AND :NEW.GRLOIDLO <> :OLD.GRLOIDLO OR :NEW.GRLOSEOP <> :OLD.GRLOSEOP) THEN
      sbMensError := 'Ya Existe registro del Grupo ['||:NEW.GRUPCODI||'], Localidad ['||:NEW.GRLOIDLO||'], Sector Operativo ['||:NEW.GRLOSEOP||']';
      RAISE erExiste;
    END IF;
    CLOSE cuExisteCombGrupLocaSetOp;

    IF :NEW.GRLOIDLO = -1 AND NVL(:NEW.GRLOSEOP,-1) <> -1 THEN
       sbMensError := 'Cuando Localidad es igual a -1 el sector operativo debe ser igual a -1';
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
        Errors.SETMESSAGE(sbMensError);
        raise ex.CONTROLLED_ERROR;
END;
/
