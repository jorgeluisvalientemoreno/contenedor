CREATE OR REPLACE TRIGGER ADM_PERSON.trgafterInsCuenCobr
AFTER INSERT ON cuencobr
FOR EACH ROW
DECLARE


			    -- Mensaje de error
    OSBERRORMESSAGE GE_ERROR_LOG.DESCRIPTION%TYPE;

			    -- Codigo de error
    ONUERRORCODE    GE_ERROR_LOG.ERROR_LOG_ID%TYPE;
    nuidregistro    ldc_usuarios_actualiza_cl.idregistro%TYPE;

BEGIN
--{

    pkErrors.Push ( 'trgafterInsCuenCobr' );

    -- Validacion para saldo Cuenta de Cobro

    if (:new.cucosacu >= 1) THEN
      nuidregistro := seq_ldc_usuarios_actualiza_cl.nextval;
      INSERT INTO ldc_usuarios_actualiza_cl(producto,ctacob,idregistro) VALUES(:new.cuconuse,'S',nuidregistro);
    end if;

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

--}
END;
/
