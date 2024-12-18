CREATE OR REPLACE TRIGGER ADM_PERSON.TRGBUR_LD_FA_PARAGENE
BEFORE UPDATE Of pagevanu,pagevate,pagecodi    ON ld_fa_paragene
FOR EACH ROW

/*  Propiedad intelectual de Ludycom S.A.
    Trigger  : trgbur_ld_fA_paragene
    Descripcion  :   Valida que el usuario en la entidad de ld_fa_paragene solo ingrese un solo valor para el parametro (Numerico/cadena)
    Autor  : Jery Ann silvera de La Rans
    Fecha  : 01/06/2013

    Historia de Modificaciones
    Fecha     IDEntrega
*/
DECLARE

    sbErrMsg        ge_error_log.description%type;
    nuErrCode        number;
BEGIN
--{
    pkErrors.PUSH ('trgbur_ld_fA_paragene');

    LE_BOLiqPropiasVal.Val_ValorParametro(:new.pagevanu,:new.pagevate,:new.pagecodi);

    pkErrors.pop;

EXCEPTION

    when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then

        pkErrors.Pop;
      raise;

    when others then
      pkErrors.NotifyError( pkErrors.fsbLastObject, sqlerrm, sbErrMsg );
      pkErrors.Pop;
      raise_application_error( pkConstante.nuERROR_LEVEL2, sbErrMsg );

--}
END TRGBUR_LD_FA_PARAGENE;
--/
/
