CREATE OR REPLACE TRIGGER ADM_PERSON.trgbuSetPaymentDate before update ON pagos
REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW
 WHEN ( old.pagofepa != new.pagofepa ) DECLARE

    sbErrMsg            ge_error_log.description%type;
    nuErrCode           ge_error_log.error_log_id %type;

BEGIN
--{
    pkErrors.Push('trgbuSetPaymentDate');

    -- Proceso
    :new.pagofepa := trunc (:new.pagofepa);

    pkErrors.Pop;

EXCEPTION
    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
	pkErrors.GetErrorVar( nuErrCode, sbErrMsg );
	pkErrors.Pop;
	raise_application_error(pkConstante.nuERROR_LEVEL2, sbErrMsg);

    when others then
	pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
	pkErrors.Pop;
	raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );
--}
End;
/
