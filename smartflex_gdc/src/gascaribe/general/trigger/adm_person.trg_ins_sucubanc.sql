CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_INS_SUCUBANC
BEFORE INSERT ON sucubanc
FOR EACH ROW
DECLARE
    -- Sucursal cero
    cnusubacodi     sucubanc.subabanc%type := 0;       -- sa_user

    -- Mensaje de error
    OSBERRORMESSAGE GE_ERROR_LOG.DESCRIPTION%TYPE;

    -- Codigo de error
    ONUERRORCODE    GE_ERROR_LOG.ERROR_LOG_ID%TYPE;

BEGIN
--{
    ut_trace.trace('INICIO TRG_INS_SUCUBANC',1);
    pkErrors.Push ( 'TRG_INS_SUCUBANC' );

    -- Validacion para sucursal cero

    if ( to_number(:new.subacodi) = 0) then

    errors.seterror(2741, '[ENTIDAD DE RECAUDO:'||:NEW.SUBABANC ||'] No se permite la creación de sucursales con código ['||:new.subacodi||']');
    RAISE ex.controlled_error;
    end if;

    ut_trace.trace('FIN TRG_INS_SUCUBANC',1);

    pkErrors.Pop;

EXCEPTION
    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
	pkErrors.GetErrorVar( onuErrorCode, osbErrorMessage );
	pkErrors.Pop;
	raise_application_error ( pkConstante.nuERROR_LEVEL2, osbErrorMessage );

    when others then
	pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, osbErrorMessage);
	pkErrors.Pop;
	raise_application_error( pkConstante.nuERROR_LEVEL2, osbErrorMessage );
END TRG_INS_SUCUBANC;
/
