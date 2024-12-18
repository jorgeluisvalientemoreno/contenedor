CREATE OR REPLACE TRIGGER ADM_PERSON.TRGAURLD_VALIDITY_POLICY_TYPE
AFTER UPDATE ON Ld_Validity_Policy_Type
REFERENCING old AS old new AS new FOR EACH ROW
 WHEN (old.VALIDITY_POLICY_TYPE_ID != new.VALIDITY_POLICY_TYPE_ID OR
      old.POLICY_TYPE_ID          != new.POLICY_TYPE_ID          OR
      old.INITIAL_DATE            != new.INITIAL_DATE            OR
      old.FINAL_DATE              != new.FINAL_DATE) DECLARE
    cnuGeneric_Error CONSTANT NUMBER := 2741; -- Error generico

BEGIN
--{
    -- Inserta el registro de Ld_Validity_Policy_Type que esta siendo modificado
    -- en la tabla Temporal para el posterior control de solapamiento de Fechas

    insert into Ld_Vali_Poli_Type_Temp
    (VALIDITY_POLICY_TYPE_ID, POLICY_TYPE_ID, INITIAL_DATE, FINAL_DATE)
    values
    (:new.VALIDITY_POLICY_TYPE_ID, :new.POLICY_TYPE_ID, :new.INITIAL_DATE, :new.FINAL_DATE);

EXCEPTION
    when OTHERS then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
--}
END TRGAURLD_VALIDITY_POLICY_TYPE;
/
