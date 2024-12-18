CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_LD_FINAN_PLAN_FNB
  BEFORE INSERT OR UPDATE ON LD_FINAN_PLAN_FNB
  FOR EACH ROW

DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;
    cnunull_attribute CONSTANT NUMBER := 2741;

 CURSOR cuPLanes(inupldicodi plandife.pldicodi%TYPE) IS
   SELECT Count(*)
     FROM plandife
     WHERE pldicodi = inupldicodi
       AND pldimccd IN (SELECT TO_NUMBER(COLUMN_VALUE) valor
                                FROM TABLE
                                (LDC_BOUTILITIES.SPLITSTRINGS((select trim(replace(value_chain, '|', ',')) from ld_parameter where parameter_id = 'FNB_PLANFINAN_MCF'),',') )
                             );

 nuValor NUMBER;

BEGIN

OPEN cuPLanes (:new.financing_plan_id);
FETCH cuPLanes INTO nuValor;
CLOSE cuPLanes;

      IF (nuValor = 0 AND :new.plan_finan = ('F')) THEN

        errors.seterror(cnunull_attribute, 'El Plan no corresponde a Cuota Fija');
        RAISE ex.controlled_error;


      end if;

      IF (nuValor > 0 AND :new.plan_finan = ('V')) THEN

        errors.seterror(cnunull_attribute, 'El Plan no corresponde a Cuota Variable');
        RAISE ex.controlled_error;


      end if;






EXCEPTION
  when ex.CONTROLLED_ERROR then raise ex.CONTROLLED_ERROR;
  when others then Errors.setError; raise ex.CONTROLLED_ERROR;
END LD_FINAN_PLAN_FNB;
/
