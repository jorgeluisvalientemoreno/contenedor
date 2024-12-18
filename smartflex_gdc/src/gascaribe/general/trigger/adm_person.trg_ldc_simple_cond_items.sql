CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_LDC_SIMPLE_COND_ITEMS BEFORE INSERT or UPDATE  ON LDC_SIMPLE_COND_ITEMS  FOR EACH ROW
/**************************************************************************
  Autor       : Luis Javier Lopez Barrios / Horbath
  Fecha       : 2017-09-06
  Ticket      : 200-1179
  Descripcion : Trigger que valida logica de la forma LDC_MACOMCTT


  Parametros Entrada

  Valor de salida

  HISTORIA DE MODIFICACIONES
  FECHA         AUTOR       DESCRIPCION
  18/10/2024    jpinedc     OSF-3383: Se migra a ADM_PERSON
***************************************************************************/
DECLARE

    sbExiste VARCHAR2(1);  --Ticket 200-1179  LJLB -- Se almacena dato si existe datos
    sbMensError VARCHAR2(100); --Ticket 200-1179  LJLB -- Se almacena el mensaje de error
    nuErrorCode NUMBER := 2;  --Ticket 200-1179  LJLB -- Se almacena codigo de error

     --Ticket 200-1179  LJLB -- Se consulta si la causal esta configurada en el tipo de trabajo
    CURSOR cuExiste IS
    SELECT 'X'
    FROM ct_simple_cond_items
    WHERE ITEMS_ID = :NEW.ITEMS_ID AND
          SIMPLE_CONDITION_ID = :NEW.SIMPLE_CONDITION_ID;


    erExiste EXCEPTION;  --Ticket 200-1179  LJLB -- Se almacena excepcion si existe persona
    sbdato varchar2(100);

BEGIN
  pkerrors.Push('TRG_LDC_SIMPLE_COND_ITEMS');

 IF INSERTING THEN
   --Ticket 200-1179  LJLB -- Se realiza consulta si existe registro de item y condicion simple
    OPEN cuExiste;
    FETCH cuExiste INTO sbExiste;
    IF cuExiste%FOUND  THEN
      sbMensError := 'Ya Existe registro con Items ['||:NEW.ITEMS_ID||'], para la condicion ['||:NEW.SIMPLE_CONDITION_ID||']';
      RAISE erExiste;
    END IF;
    CLOSE cuExiste;

   --Ticket 200-1179  LJLB -- Se realiza insert en laa tabla de item por condiciones simples
    INSERT INTO CT_SIMPLE_COND_ITEMS (SIMPLE_COND_ITEMS_ID, ITEMS_ID, SIMPLE_CONDITION_ID)
                               VALUES (:NEW.SIMPLE_COND_ITEMS_ID, :NEW.ITEMS_ID, :NEW.SIMPLE_CONDITION_ID );
  ELSE
     --Ticket 200-1179  LJLB -- Se bloquea accion de modificar
     IF UPDATING THEN
         Errors.SetError(nuErrorCode);
         Errors.SETMESSAGE('No se permite Modificar el Registro');
         RAISE ex.CONTROLLED_ERROR;
    END IF;
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
