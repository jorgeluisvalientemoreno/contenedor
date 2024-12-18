create or replace function adm_person.fnuGetCantConsMetCalc (inusesu servsusc.sesunuse%type,
                                                  inupefa perifact.pefacodi%type,
                                                  inumecc conssesu.cossmecc%type) return number is
/*****************************************************************
      Propiedad intelectual de GDC

      Unidad         : fnuGetCantConsMetCalc
      Descripcion    : Funcion que devuelve el numero de veces que se facturo un producto
                       por un metodo de calculo dado
      Autor          : F.Castro
      Fecha          : 14/01/2018

      Metodos

      Nombre         :
      Parametros         Descripcion
      ============  ===================


      Historia de Modificaciones
      Fecha             Autor             Modificacion
      =========         =========         ====================
     
    ******************************************************************/                                                  
                                                  
nucant number;
cursor cuConssesu is
 select count(1) from (SELECT  /*+ leading(DataSource) use_nl(Parameters_) */
                                         rank() over ( partition BY cosspecs, cosstcon, cosssesu ORDER BY cossfere desc, decode(cossmecc, 2, -1, 4, -1, 1) desc, cossrowid desc) Marca_,
                                         cossmecc,
                                         cosspefa
                                    FROM   (SELECT  /*+ qb_name(DataSource)
                                                    leading(conssesu) index(conssesu IX_CONSSESU03)
                                                    use_nl_with_index(mecacons pk_mecacons)
                                                    use_nl_with_index(pericose pk_pericose) */
                                                    conssesu.*,
                                                    conssesu.rowid cossrowid
                                              FROM    conssesu
                                             WHERE  COSSSESU=inusesu
                                               AND     COSSPEFA<inupefa))
                                   WHERE marca_ = 1
                                    AND cossmecc = inumecc;
begin
  open cuConssesu;
  fetch cuConssesu into nucant;
  if cuConssesu%notfound then
    nucant := 0;
  end if;
  close cuConssesu;
  return nvl(nucant,0);
exception when others then
  return 0;
end;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FNUGETCANTCONSMETCALC', 'ADM_PERSON');
END;
/