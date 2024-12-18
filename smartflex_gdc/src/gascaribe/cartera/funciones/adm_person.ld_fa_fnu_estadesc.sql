CREATE OR REPLACE FUNCTION "ADM_PERSON"."LD_FA_FNU_ESTADESC" (parametro in ld_fa_estadesc.esdedesc%type) return number is
  valor ld_fa_estadesc.esdecodi%type;
  Gsberrmsg    Ge_Error_Log.Description%Type;
begin
  Pkerrors.Push('ld_fa_fnu_estadesc');
  BEGIN
    select x.esdecodi INTO valor
    from Ld_Fa_Estadesc x
    where x.esdedesc = parametro;
    exception
      when others then
           Pkerrors.Notifyerror(Pkerrors.Fsblastobject, 'El estado no existe o no está configurado, Consulte al Administrador del sistema.', Gsberrmsg);
           Pkerrors.Pop;
           Raise_Application_Error(Pkconstante.Nuerror_Level2, Gsberrmsg);
    END;
  return(valor);
end ld_fa_fnu_estadesc;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LD_FA_FNU_ESTADESC', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LD_FA_FNU_ESTADESC TO REXEREPORTES;
/