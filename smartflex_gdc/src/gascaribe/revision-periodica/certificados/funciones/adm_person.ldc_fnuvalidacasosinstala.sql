CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNUVALIDACASOSINSTALA" (nuSolicitud or_order_activity.package_id%type)
return number
is

 /*****************************************
  Metodo      : LDC_fnuValidaCasosInstala
  Descripcion : Valida los casos de instalacion requeridos para la generacion del reporte
                para los entes certificadores.
                Los casos estan dados por el comportamiento de las ordenes de una solicitud:
                Caso1. Las ordenes de instalacion todas en estado 7
                Caso2. Si esta 1 o las 2 incumplidas no sale en el reporte
                Caso3. La orden de certificacion de la solicitud debe estar asignada

  Autor: Luz Andrea Angel M./OLSoftware
  Fecha: Julio 04/2013
  ******************************************/

  --cantidad de ordenes de cargo x conexion de una solicitud
  cursor cucantotcargo(nusolic or_order_activity.package_id%type) is
    select count(*)
    from or_order_activity a
    where a.task_type_id in (12150, 12152)
      and a.package_id = nusolic;

  --cantidad de ordenes de instalacion de una solicitud
  cursor cucantotinstala(nusolic or_order_activity.package_id%type) is
    select count(*)
    from or_order_activity a
    where a.task_type_id in (12151, 12149)
      and a.package_id = nusolic;

  --ordenes en estado 7
  cursor cuCaso1(nuSolic or_order_activity.package_id%type) is
    select count(*)
    from or_order b, OR_ORDER_ACTIVITY c
    where b.order_id = c.order_id
      and b.task_type_id in (12150, 12152, 12151, 12149)
      and B.order_status_id = 7
      AND c.PACKAGE_ID = nuSolic;

  --orden de certificacion asociada a la solicitud debe estar asignada
  cursor cucertifica(nuSolic or_order_activity.package_id%type) is
    SELECT count(*)
    from or_order b, OR_ORDER_ACTIVITY c
    where b.order_id = c.order_id
      and b.task_type_id =  12162
      and b.order_status_id = 5
      AND c.PACKAGE_ID = nuSolic;

  nucantcargo   number;
  nucantinstala number;
  nucantotnueva number;
  nucantcertif  number;
  nucantest7    number;
  nuretorno     number := 0;

begin
  Open cucantotcargo(nuSolicitud);
    fetch cucantotcargo
    into nucantCargo;
  close cucantotcargo;

  Open cucantotinstala(nuSolicitud);
    fetch cucantotinstala
    into nucantinstala;
  close cucantotinstala;

  nucantotnueva := nucantCargo + nucantinstala;

  if(nucantotnueva > 0) then

    --Caso1. cantidad de ordenes en estado 7 igual a cantidad de ordenes de nuevas
    Open cuCaso1(nuSolicitud);
    fetch cuCaso1
      into nucantest7;
    close cucaso1;

    if(nucantotnueva = nucantest7) then
      nuretorno := 1;
    end if;

    Open cucertifica(nuSolicitud);
    fetch cucertifica
      into nucantcertif;
    close cucertifica;

    if(nucantcertif = 1) then
      nuretorno := 2;
    end if;
  end if;

  return nuretorno;
end LDC_fnuValidaCasosInstala;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNUVALIDACASOSINSTALA', 'ADM_PERSON');
END;
/