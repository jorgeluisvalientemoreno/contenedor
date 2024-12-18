create or replace function adm_person.fnu_ldc_gettipoconc (inuconc cargos.cargconc%type) return varchar2 is

/***************************************************************************
  Funcion: fnu_ldc_gettipoconc

  Descripcion:    Obtiene el tipo de concepto
                  Capital
                  Interes
                  Mora
                  Otros

  Autor: F.Castro
  Fecha: Junio 6 de 2018

  Parametros
  inuconc      codigo de concepto


  Historia de Modificaciones

  Fecha          Autor           Modificacion
  ===========    ==========      =============================================
  02/01/2024	cgonzalez		OSF-2095: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/

sbRefi varchar2(1);
sbInte varchar2(1);
sbTipo varchar2(20);
nuInte number;
sbdesc concepto.concdesc%type;

cursor cuConcCapi is
 select nvl(conccoin,-1), concdesc
   from concepto
  where conccodi=inuconc;

cursor cuConcRefi is
 select 'x'
   from concepto
  where CONCCORE=inuconc
    and conccodi != inuconc;
  
cursor cuConcInte is  
 select 'x'
   from concepto
  where CONCCOIN=inuconc
    and conccodi != inuconc;

begin
 open cuConcCapi;
 fetch cuConcCapi into nuInte, sbdesc;
 close cuConcCapi;
 
 if nuinte != -1 or inuconc = 196 then
    sbTipo := 'Capital';
 else
   open cuConcInte;
   fetch cuConcInte into sbInte;
   close cuConcInte;
   if sbInte is not null OR sbdesc like ('%REFI INT FIN%')then
     sbTipo := 'Interes';
   else 
     if upper(sbdesc) like '%MORA%' then
       sbTipo := 'Mora';
     else
       sbTipo := 'Otros';
     end if;
   end if;
 end if;
 
 return sbTipo;

exception when others then
  null;
end fnu_ldc_gettipoconc;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FNU_LDC_GETTIPOCONC', 'ADM_PERSON');
END;
/