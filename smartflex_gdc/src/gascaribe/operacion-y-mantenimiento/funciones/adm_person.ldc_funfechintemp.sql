CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FUNFECHINTEMP" (inuLoca in ge_geogra_location.geograp_location_id%type,
                                             inuAno  in perifact.pefaano%type,
                                             inuMes  in perifact.pefames%type)
  return date is
  /**************************************************************************************
  Propiedad Intelectual de Gases del caribe S.A E.S.P

  Funcion     : ldc_funfechintemp
  Descripcion : Esta funcion tiene como parametros la localidad, a?o, mes. para calcular la fecha inicial
                del periodo de consumo del primer ciclo de consumo, perteneciente al distrito de la localidad ingresada.
                esta fecha es tomada para la fecha inicial de vigencia de temperatura de la localidad

  Autor       : Ronald Colpas
  Fecha       : 22-06-2018

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  26/07/2018          Roncol             Se modifica para que consulte el codigo de ciclo configurado en la tabla LDC_CAPILOCAFACO
  ***************************************************************************************/

  nuCicl ciclo.ciclcodi%type;
  dtFech date;
  nuPefa perifact.pefacodi%type;
  nuPeco pericose.pecscons%type;

  cursor cuCicloLoca is
    select ciclo from ldc_capilocafaco where localidad = inuLoca;

  --Consultamos la fecha inicial del periodo de consumo.
  cursor cuPericose(Pecons pericose.pecscons%type) is
    select p.pecsfecf -
           dald_parameter.fnuGetNumeric_Value('DIAS_CALCULO_VIG_INI_TEMP')
      from pericose p
     where p.pecscons = Pecons;
begin

  --Consultamos el ciclo de la localidad en
  open cuCicloLoca;
  fetch cuCicloLoca
    into nuCicl;
  if cuCicloLoca%notfound then
    close cuCicloLoca;
    return(null);
  else
    close cuCicloLoca;
    if nuCicl is null then
      return(null);
    end if;
  end if;

  --Consultamos el periodo de facturacion correspondiente del cilo
  nuPefa := pkbillingperiodmgr.fnugetperiod(inuAno, inuMes, nuCicl);

  nuPeco := LDC_BOFORMATOFACTURA.fnuObtPerConsumo(nuCicl, nuPefa);

  --Consultamos la fecha inicial del periodo de consumo para el periodo de facturacion del ciclo
  open cuPericose(nuPeco);
  fetch cuPericose
    into dtFech;
  close cuPericose;

  return(dtFech);

exception
  when others then
    return(null);
end ldc_funfechintemp;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FUNFECHINTEMP', 'ADM_PERSON');
END;
/
