CREATE OR REPLACE TRIGGER ADM_PERSON.TRGBIULD_LD_CANCEL_CAUSAL
  BEFORE INSERT OR UPDATE ON LD_CANCEL_CAUSAL
  FOR EACH ROW

DECLARE
	nuCausalId CC_CAUSAL.CAUSAL_ID%TYPE;
	sbDescription CC_CAUSAL.DESCRIPTION%TYPE;

BEGIN

	ut_trace.trace('inicia TR_LD_CANCEL_CAUSAL',1);

	nuCausalId := :NEW.CANCEL_CAUSAL_ID;
	sbDescription := dacc_causal.fsbGetDescription(nuCausalId);

	ut_trace.trace('Description: '||sbDescription,1);

	:NEW.DESCRIPTION := sbDescription;

	ut_trace.trace('fin TR_LD_CANCEL_CAUSAL',1);

END TRGBIULD_LD_CANCEL_CAUSAL;
/
