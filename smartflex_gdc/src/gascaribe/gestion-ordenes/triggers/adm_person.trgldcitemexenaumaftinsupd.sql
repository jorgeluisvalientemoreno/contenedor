CREATE OR REPLACE TRIGGER ADM_PERSON.TRGLDCITEMEXENAUMAFTINSUPD BEFORE INSERT OR UPDATE ON LDC_ITEMEXENAUM FOR EACH ROW
/**************************************************************************
  Autor       : Horbath
  Fecha       : 2019-04-03
  Ticket      : 200-2433
  Descripcion : Trigger que valida los flags



Que ningún ítem puede dejarse un Item registrado sin ningún Flag activo (no pueden estar los dos apagados).

Los campos que se validaran son
exauprec que indica si esta exento de aumento en el precio
exaucost que indica si esta exento de aumento en el costo


  Parametros Entrada

  Valor de salida

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/
DECLARE

    sbExiste VARCHAR2(1);
    sbMensError VARCHAR2(4000);
    nuErrorCode NUMBER := 2;
    nuclasifit GE_ITEM_CLASSIF.ITEM_CLASSIF_ID%type;

    errror EXCEPTION;

BEGIN
  pkerrors.Push('TRGLDCITEMEXENAUMAFTINSUPD');


   --Ticket 200-2433  horbath -- Se valida Que ningún ítem puede dejarse un Item registrado sin ningún Flag activo (no pueden estar los dos apagados).
   IF nvl(:new.exauprec,'N') = 'N' and nvl(:new.exaucost,'N') = 'N' THEN
      sbMensError := 'No se puede tener no-exento el aumento de precio y al mismo tiempo no-exento el costo en el'|| ' item: '||to_char(:new.items_id)||' - '||DAGE_ITEMS.FSBGETDESCRIPTION(:new.items_id,null);
     RAISE errror;
  END IF;


  pkErrors.Pop;
EXCEPTION
    WHEN errror THEN
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
