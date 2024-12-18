CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_UPD_AFTER_DIFERIDO
AFTER UPDATE ON diferido
FOR EACH ROW
/**
    Propiedad intelectual de Open International Systems. (c).

    Trigger	: TRG_INS_AFTER_DIFERIDO
    Descripcion	: Despues de insertar el diferido, marca al usuario
                  para actualizar el saldo diferido
                  en la tabla ldc_cartdiaria

    Parametros	:	Descripcion

    Retorno     :

    Autor	: John Jairo Jimenez Marim?n
    Fecha	: xx-xx-xxxx

    Historia de Modificaciones
    Fecha	   IDEntrega
**/
DECLARE
osbErrorMessage ge_error_log.description%TYPE;
-- Codigo de error
onuErrorCode    ge_error_log.error_log_id%TYPE;
nuidregistro    ldc_usuarios_actualiza_cl.idregistro%TYPE;
BEGIN
 IF :old.difesape <> :new.difesape THEN
   nuidregistro := seq_ldc_usuarios_actualiza_cl.nextval;
   INSERT INTO ldc_usuarios_actualiza_cl(producto,diferido,idregistro) VALUES(:new.difenuse,'S',nuidregistro);
 END IF;
EXCEPTION
 WHEN LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 THEN
  pkErrors.GetErrorVar( onuErrorCode, osbErrorMessage );
  pkErrors.Pop;
  raise_application_error ( pkConstante.nuERROR_LEVEL2, osbErrorMessage );
 WHEN OTHERS THEN
  pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
  pkErrors.Pop;
  raise_application_error( pkConstante.nuERROR_LEVEL2, osbErrorMessage );
END TRG_INS_DIFERIDO;
/
