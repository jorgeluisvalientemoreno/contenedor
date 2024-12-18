CREATE OR REPLACE FUNCTION "ADM_PERSON"."LD_FA_FSB_PARAGENE" (parametro in ld_fa_paragene.pagedesc%type) return varchar2 is
  valor ld_fa_paragene.pagevate%type;
  Gsberrmsg    Ge_Error_Log.Description%Type;
begin
  Pkerrors.Push('ld_fa_fsb_paragene');
  BEGIN
    select x.pagevate INTO valor
    from Ld_Fa_Paragene x
    where x.pagedesc = parametro;
    exception
      when others then
           Pkerrors.Notifyerror(Pkerrors.Fsblastobject, Sqlerrm, Gsberrmsg);
           Pkerrors.Pop;
           Raise_Application_Error(Pkconstante.Nuerror_Level2, Gsberrmsg);
    END;
  return(valor);
end ld_fa_fsb_paragene;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LD_FA_FSB_PARAGENE', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LD_FA_FSB_PARAGENE TO REXEREPORTES;
/
