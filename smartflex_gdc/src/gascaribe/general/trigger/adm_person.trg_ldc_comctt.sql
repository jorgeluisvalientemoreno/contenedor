CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_LDC_COMCTT BEFORE INSERT or UPDATE  ON LDC_COMCTT  FOR EACH ROW
/**************************************************************************
  Autor       : Luis Javier Lopez Barrios / Horbath
  Fecha       : 2017-02-06
  Ticket      : 200-1132
  Descripcion : Trigger que valida logica de la forma LDC_MACOMCTT


  Parametros Entrada

  Valor de salida

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/
DECLARE
   PRAGMA AUTONOMOUS_TRANSACTION;

    sbExiste VARCHAR2(1);  --Ticket 200-1132  LJLB -- Se almacena dato si existe datos
    sbMensError VARCHAR2(100); --Ticket 200-1132  LJLB -- Se almacena el mensaje de error
    nuErrorCode NUMBER := 2;  --Ticket 200-1132  LJLB -- Se almacena codigo de error

    --Ticket 200-1132  LJLB -- Se consulta si existe combinacion Tipo de Trabajo, actividad y causal
    CURSOR cuExisteCombTtAcCa IS
    SELECT 'X'
    FROM LDC_COMCTT
    WHERE CMTTTITR = :NEW.CMTTTITR AND
		  CMTTACTI = :NEW.CMTTACTI AND
		  CMTTCAIN = :NEW.CMTTCAIN  ;

	 --Ticket 200-1132  LJLB -- Se consulta si existe combinacion Tipo de Trabajo, actividad y numero de dias
    CURSOR cuExisteCombTtAcTi IS
    SELECT 'X'
    FROM LDC_COMCTT
    WHERE CMTTTITR = :NEW.CMTTTITR AND
		  CMTTACTI = :NEW.CMTTACTI AND
		  (CMTTTIED = :NEW.CMTTTIED OR (:NEW.CMTTTIED IS NOT NULL AND CMTTTIED IS NOT NULL))
      ;

    --Ticket 200-1132  LJLB -- Se consulta si la actividad esta asociada al tipo de trabajo
    CURSOR cuactividades IS
    SELECT  'X'
    FROM OR_TASK_TYPES_ITEMS
    WHERE task_type_id = :NEW.CMTTTITR AND ITEMS_ID = :NEW.CMTTACTI;

     --Ticket 200-1132  LJLB -- Se consulta si la causal esta configurada en el tipo de trabajo
    CURSOR cuCausales IS
    SELECT 'X'
    FROM or_task_type_causal
    WHERE TASK_TYPE_ID = :NEW.CMTTTITR AND
          CAUSAL_ID = :NEW.CMTTCAIN;


    erExiste EXCEPTION;  --Ticket 200-1132  LJLB -- Se almacena excepcion si existe persona

BEGIN
  pkerrors.Push('TRG_LDC_COMCTT');

 --IF INSERTING THEN
     --Ticket 200-1132  LJLB -- Se realiza consulta si existe o no combinacion Tipo de Trabajo, actividad y causal
    OPEN cuExisteCombTtAcCa;
    FETCH cuExisteCombTtAcCa INTO sbExiste;
    IF cuExisteCombTtAcCa%FOUND  AND (:NEW.CMTTTITR <> :OLD.CMTTTITR AND :NEW.CMTTACTI <> :OLD.CMTTACTI OR :NEW.CMTTCAIN <> :OLD.CMTTCAIN) THEN
      sbMensError := 'Ya Existe registro con Tipo de Trabajo ['||:NEW.CMTTTITR||'], Activividad ['||:NEW.CMTTACTI||'], Causal ['||:NEW.CMTTCAIN||']';
      RAISE erExiste;
    END IF;
    CLOSE cuExisteCombTtAcCa;

    --Ticket 200-1132  LJLB -- Se realiza consulta si existe o no combinacion Tipo de Trabajo, actividad y tiempo en dias
    OPEN cuExisteCombTtAcTi;
    FETCH cuExisteCombTtAcTi INTO sbExiste;
    IF cuExisteCombTtAcTi%FOUND AND (:NEW.CMTTTITR <> :OLD.CMTTTITR AND :NEW.CMTTACTI <> :OLD.CMTTACTI OR :NEW.CMTTTIED <> :OLD.CMTTTIED)  THEN
      sbMensError := 'Ya Existe registro con Tipo de Trabajo ['||:NEW.CMTTTITR||'], Activividad ['||:NEW.CMTTACTI||'], #Dias ['||:NEW.CMTTTIED||']';
      RAISE erExiste;
    END IF;
    CLOSE cuExisteCombTtAcTi;

    --Ticket 200-1132  LJLB -- Se realiza consulta si existe o no combinacion Tipo de Trabajo, actividad y tiempo en dias
    OPEN cuactividades;
    FETCH cuactividades INTO sbExiste;
    IF cuactividades%NOTFOUND  THEN
      sbMensError := 'La actividad: ['||:NEW.CMTTACTI||'] no esta asociada al Tipo de Trabajo ['||:NEW.CMTTTITR||']';
      RAISE erExiste;
    END IF;
    CLOSE cuactividades;

    IF :NEW.CMTTCAIN IS NOT NULL THEN
      --Ticket 200-1132  LJLB -- Se realiza consulta si existe o no combinacion Tipo de Trabajo, actividad y tiempo en dias
      OPEN cuCausales;
      FETCH cuCausales INTO sbExiste;
      IF cuCausales%NOTFOUND  THEN
        sbMensError := 'La causal: ['||:NEW.CMTTCAIN||'] no esta asociada al Tipo de Trabajo: ['||:NEW.CMTTTITR||']';
        RAISE erExiste;
      END IF;
      CLOSE cuCausales;

    END IF;


    IF NVL(:NEW.CMTTFLVV,'N') = 'S' AND (NVL(:NEW.CMTTVAFI, 0) <= 0 OR NVL(:NEW.CMTTTIED,-1) < 0) THEN
       sbMensError := 'Flag de visita Activo, debe tener un valor fijo mayor que cero y el tiempo en Dias configurado';
       RAISE erExiste;
    END IF;

    IF NVL(:NEW.CMTTFLVV,'N') = 'N' AND NVL(:NEW.CMTTVAFI, 0) > 0 THEN
      sbMensError := 'El Flag de Venta de visita esta Inactivo, Valor fijo debe estar vacio';
      RAISE erExiste;
    END IF;

    IF :NEW.CMTTTIED IS NOT NULL AND :NEW.CMTTCAIN IS NOT NULL THEN
      sbMensError := 'No se puede configurar un tipo de trabajo por causal de incumplimiento y tiempo en dias para multar';
      RAISE erExiste;
    END IF;

    IF :NEW.CMTTTIED IS NULL AND :NEW.CMTTCAIN IS NULL THEN
      sbMensError := 'Se debe configurar por lo menos multar por causal de incumplimiento o por tiempo';
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
