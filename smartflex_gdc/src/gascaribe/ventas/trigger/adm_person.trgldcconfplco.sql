CREATE OR REPLACE TRIGGER ADM_PERSON.TRGLDCCONFPLCO BEFORE INSERT OR UPDATE  ON LDC_CONFPLCO FOR EACH ROW
/**************************************************************************
  Autor       : Josh Brito / Horbath
  Fecha       : 2019-01-26
  Ticket      : 200-2022
  Descripcion : Trigger para llenar la tabla de log LDC_CONFPLCOLOG cuando se realicen cambios en la tabla LDC_CONFPLCO


  Parametros Entrada

  Valor de salida

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/
DECLARE
--   PRAGMA AUTONOMOUS_TRANSACTION;

  nuRespusua NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_PARPERSONAHIJO',NULL); -- se almacena responsable usuario

BEGIN
 -- pkerrors.Push('TRGLDCCONFPLCO');
  --si el responsable de las actidades es el constructor se genera error
  IF :NEW.CONFRESPCXC <> nuRespusua  AND :NEW.CONFRESPCERT <> nuRespusua THEN
      errors.seterror(2741, 'Constructor no Puede ser Responsable de las dos Actividades');
       RAISE ex.CONTROLLED_ERROR;
  END IF;

  IF :NEW.CONFPLCC = 'S' AND (:NEW.CONFRESPCXC <> nuRespusua OR  (:NEW.CONFRESPCERT <> nuRespusua and :NEW.CONFRESPCERT is not null) ) THEN
    errors.seterror(2741, 'Si el flag de Interna Especial esta activo, las actividades no pueden estar como responsable el Constructor');
       RAISE ex.CONTROLLED_ERROR;
  END IF;

   IF :NEW.CONFNUMCUOTA <= 0 THEN
      errors.seterror(2741, 'El numero de cuota debe ser mayor a cero');
       RAISE ex.CONTROLLED_ERROR;
  END IF;

  IF Updating THEN
      INSERT INTO LDC_CONFPLCOLOG (CODCONFPLCO
                                      ,CONFRESPCXC
                                      ,CONFRESPCERT
                                      ,CONFPLANCOME
                                      ,CONFCUOTA
                                      ,CONFNUMCUOTA
                                      ,CONFPLANFINA
                                      ,CONFACTIVO
                                      ,CONFPLCC
                                      ,CONFRESPCXCAT
                                      ,CONFRESPCERTAT
                                      ,CONFPLANCOMEAT
                                      ,CONFCUOTAANT
                                      ,CONFNUMCUOTAAT
                                      ,CONFPLANFINAAT
                                      ,CONFACTIVOANT
                                       ,CONFPLCCANT
                                      ,CONFUSUARIO
                                      ,CONFFECHA
                                      ,CONFTERMINAL
                                      )
                VALUES (:OLD.CODCONFPLCO
                        ,:NEW.CONFRESPCXC
                        ,:NEW.CONFRESPCERT
                        ,:NEW.CONFPLANCOME
                        ,:NEW.CONFCUOTAINI
                        ,:NEW.CONFNUMCUOTA
                        ,:NEW.CONFPLANFINA
                        ,:NEW.CONFESTADO
                        ,:NEW.CONFPLCC
						,:OLD.CONFRESPCXC
                        ,:OLD.CONFRESPCERT
                        ,:OLD.CONFPLANCOME
                        ,:OLD.CONFCUOTAINI
                        ,:OLD.CONFNUMCUOTA
                        ,:OLD.CONFPLANFINA
                        ,:OLD.CONFESTADO
						,:OLD.CONFPLCC
                        ,UT_SESSION.GETUSER
                        ,SYSDATE
                        ,UT_SESSION.GETTERMINAL --ut_session.Getmachine*/
                );
    END IF;
 -- pkErrors.Pop;
EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
       RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        raise ex.CONTROLLED_ERROR;
END;
/
