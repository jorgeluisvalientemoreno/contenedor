create or replace function adm_person.fnuGetPerGracDife (inudifecodi in diferido.difecodi%type,
                                              isbDato number,
                                              idtfecha date) return varchar2 is
/***************************************************************************
  Funcion: fnuGetPerGracDife

  Descripcion:    funcion para obterner la fecha final del periodo de gracia de un diferido si el parametro isbDato es 1 
					o si el diferido esta en periodo de gracia en la fecha recibida como parametro si isbDato es 2

  Historia de Modificaciones

  Fecha          Autor           Modificacion
  ===========    ==========      =============================================
  02/01/2024	cgonzalez		OSF-2095: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
--              
dtfechafinal date := null;
sbSalida varchar2(100) := null;
cursor cuPeriGracia is
select d.end_date
  from cc_grace_peri_defe d
 where d.deferred_id = inudifecodi;
begin
  open cuPeriGracia;
  fetch cuPeriGracia into dtfechafinal;
  if cuPeriGracia%notfound then
    dtfechafinal := null;
  end if;
  close cuPeriGracia;

  if dtfechafinal is null then
    sbSalida := null;
  elsif isbDato = 1 then -- fecha final
    sbSalida := to_char(dtfechafinal,'dd/mm/yyyy');
  elsif isbDato = 2 then -- si esta en gracia a la fecha recibida como parametro
    if dtfechafinal > idtfecha then
      sbSalida := 'S';
    else
      sbSalida := 'N';
    end if;
  else
    sbSalida := 'Parametro Entrada No Valido';
  end if;
  return(sbSalida);
exception when others then
  return 'Error en Funcion';
end;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FNUGETPERGRACDIFE', 'ADM_PERSON');
END;
/