CREATE OR REPLACE TRIGGER ADM_PERSON.TRGBIURLD_POLICY_BY_CRED_QUOT
  BEFORE INSERT OR UPDATE ON LD_POLICY_BY_CRED_QUOT
  REFERENCING OLD AS OLD NEW AS NEW
  FOR EACH ROW

  /************************************************************************
  Propiedad intelectual de Open International Systems. (c).

  Trigger      : trgbiurLD_POLICY_BY_CRED_QUOT
  Descripcion  : Trigger para validacion de fecha inicial y fecha final.
  Autor        : Alex Valencia Ayola
  Fecha        : 28/Feb/2013

   Historia de Modificaciones
    Fecha             Autor                     Modificacion
    =========         =========                 ====================
   08/08/2013     Erika A. Montenegro Gaviria   Se modifica para que el trigger
                                                se ejecute sobre toda la entidad
                                                LD_POLICY_BY_CRED_QUOT.Se borra
                                                validación que ya se tenía en
                                                cuenta con la primera.Se adiciona
                                                validaciones para cuando se inserte
                                                o modifique.
  **************************************************************************/
DECLARE
  cnuGeneric_Error CONSTANT NUMBER := 2741; /*constante de error*/
BEGIN


    IF (trunc(:new.initial_date) > trunc(:new.final_date)) THEN
      GI_BOERRORS.SETERRORCODEARGUMENT(cnuGeneric_Error,
                                       'La Fecha de Inicio debe ser menor a la fecha final');

    END IF;

    if INSERTING then
    IF (trunc(:new.initial_date) < trunc(Sysdate) OR trunc(:new.final_date) < trunc(Sysdate)) THEN
      GI_BOERRORS.SETERRORCODEARGUMENT(cnuGeneric_Error,
                                       'La Fecha de Inicio y Fecha Final no deben ser menor a la fecha del sistema');
    END IF;

    END if;

    if UPDATING then
     if (trunc(:new.initial_date) <> trunc(:old.initial_date) AND trunc(:new.initial_date) <trunc(sysdate)) then

       GI_BOERRORS.SETERRORCODEARGUMENT(cnuGeneric_Error,
                                       'La Fecha de Inicio no debe ser menor a la actual');
     END if;
    END if;




EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    RAISE ex.CONTROLLED_ERROR;
  WHEN OTHERS THEN
    Errors.setError;
    RAISE ex.CONTROLLED_ERROR;
END TRGBIURLD_POLICY_BY_CRED_QUOT;

/
