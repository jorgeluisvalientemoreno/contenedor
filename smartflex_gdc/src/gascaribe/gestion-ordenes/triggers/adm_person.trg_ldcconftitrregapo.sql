CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_LDCCONFTITRREGAPO BEFORE INSERT OR UPDATE OR DELETE ON LDC_CONFTITRREGAPO FOR EACH ROW
/**************************************************************************
  Autor       : Horbath
  Fecha       : 2019-19-04
  Ticket      : 200-2391
  Descripcion : Trigger


  Parametros Entrada

  Valor de salida

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/
DECLARE

    sbExiste VARCHAR2(1);
    sbMensError VARCHAR2(100);
    nuErrorCode NUMBER := 2;
    errror EXCEPTION;
    OPER     LDC_CONFTITRREGAPO_log.OPERACION%TYPE;

BEGIN
  pkerrors.Push('TRG_LDCCONFTITRREGAPO');

  IF INSERTING THEN
     OPER:='I';
     :NEW.FECHmod:=SYSDATE;
     :NEW.USUARIO:=USER;
  END IF;
  IF UPDATING THEN
     OPER:='U';
     :NEW.FECHmod:=SYSDATE;
     :NEW.USUARIO:=USER;
  END IF;
  IF DELETING THEN
     OPER:='D';
	  INSERT INTO LDC_CONFTITRREGAPO_LOG (tipotror,
									 activor  ,
									 causleg  ,
									 tipotrde ,
									 activde  ,
									 usuario  ,
									 fechmod  ,
									 OPERACION)
							VALUES  (:OLD.tipotror,
									 :OLD.activor  ,
									 :OLD.causleg  ,
									 :OLD.tipotrde ,
									 :OLD.activde  ,
									 USER  ,
									 SYSDATE  ,
									 OPER);

   ELSE
	  INSERT INTO LDC_CONFTITRREGAPO_LOG (tipotror,
										 activor  ,
										 causleg  ,
										 tipotrde ,
										 activde  ,
										 usuario  ,
										 fechmod  ,
										 OPERACION)
								VALUES  (:NEW.tipotror,
										 :NEW.activor  ,
										 :NEW.causleg  ,
										 :NEW.tipotrde ,
										 :NEW.activde  ,
										 USER  ,
										 SYSDATE  ,
										 OPER);

   END IF;

  pkErrors.Pop;
EXCEPTION
    WHEN OTHERS THEN
        Errors.setError;
        sbMensError := sqlerrm;
        Errors.SETMESSAGE(substr(sbMensError,1,40));
        raise ex.CONTROLLED_ERROR;
END;
/
