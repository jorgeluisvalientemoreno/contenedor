CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNUVALIDACASOSREPARA" (nuSolicitud or_order_activity.package_id%type)
return number
is

 /*****************************************
  Metodo      : fnuValidaCasosRepara
  Descripcion : Valida los casos de reparacion requeridos para la generacion del reporte
                para los entes certificadores.
                Los casos estan dados por el comportamiento de las ordenes de una solicitud:
                Caso1. Las ordenes de reparacion todas en estado 7
                Caso2. Del total de ordenes de reparacion unas en estado 7 y otras incumplidas
                Caso3. Del total de ordenes de reparacion unas cn causal 9584-Trabajos realizados por terceros y
                       el resto en estado 7 y otras incumplidas

  Autor: Luz Andrea Angel M./OLSoftware
  Fecha: Junio 05/2013

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
  11/09/2013        luzaa             NC 666: se ajustan consultas incluyendo el tipo de paquete
  03/10/2013        luzaa             NC973: Ajuste a los count de las sentencias para mejorar rendimiento
  09/10/2013        luzaa             NC1103: Se ajusta logica, ya que si encuentra al menos una OT con causal trabajo realizado por terceros,
                                      la solicitud asociada debe salir en el reporte RTCR
  21/10/2013        luzaa             NC973: Ajuste a las consultas para mejorar el rendimiento.
  28/11/2013        luzaa             NC1898: se ajusta para que los tipos de paquete se manejen en un parametro y no fijos, ya que se incluyeron
                                      los de Cambio de uso y Reconexion Admin.
  ******************************************/
  --cantidad de ordenes de reparacion de una solicitud
  cursor cucantotrepara(nusolic or_order_activity.package_id%type) is
    select count(1)
    from or_order_activity a, mo_packages mp, ps_package_type ppt, or_order b
    where a.order_id = b.order_id
      and a.package_id = mp.package_id
      and mp.package_type_id = ppt.package_type_id
      and a.package_id = nusolic
      and ldc_boutilities.fsbbuscatoken(dald_parameter.fsbgetvalue_chain('COD_SOLICITUD_SERV_INGENIERIA'),mp.package_type_id,',') = 'S'
      and b.task_type_id in (select id_trabcert
                             from ldc_trab_cert
                             where ldc_boutilities.fsbbuscatoken(dald_parameter.fsbgetvalue_chain('TRAB_NO_GENERA_CERT_ASOCIADOS'),id_trabcert,',') = 'N')
      and b.order_status_id <> 12
      and (b.causal_id  is null or (b.order_status_id = 7 and b.causal_id > 0));

  --ordenes de reparacion en estado 7
  cursor cucaso1(nusolic or_order_activity.package_id%type) is
    select count(1)
    from or_order b, or_order_activity c, mo_packages mp, ps_package_type ppt
    where  c.ORDER_ID = b.ORDER_ID
      and c.package_id = mp.package_id
      and mp.package_type_id = ppt.package_type_id
      and mp.package_id = nusolic
      and ldc_boutilities.fsbbuscatoken(dald_parameter.fsbgetvalue_chain('COD_SOLICITUD_SERV_INGENIERIA'),mp.package_type_id,',') = 'S'
      and b.task_type_id in (select id_trabcert
                             from ldc_trab_cert
                             where ldc_boutilities.fsbbuscatoken(dald_parameter.fsbgetvalue_chain('TRAB_NO_GENERA_CERT_ASOCIADOS'),id_trabcert,',') = 'N')
      and B.order_status_id = 7;

  --ordenes realizadas por terceros
  cursor cucaso3(nusolic or_order_activity.package_id%type) is
    select count(1)
    from or_order b, or_order_activity c, mo_packages mp, ps_package_type ppt
    where c.ORDER_ID = b.ORDER_ID
      and c.package_id = mp.package_id
      and mp.package_type_id = ppt.package_type_id
      and mp.package_id = nusolic
      and ldc_boutilities.fsbbuscatoken(dald_parameter.fsbgetvalue_chain('COD_SOLICITUD_SERV_INGENIERIA'),mp.package_type_id,',') = 'S'
      and b.task_type_id in (select id_trabcert
                             from ldc_trab_cert
                             where ldc_boutilities.fsbbuscatoken(dald_parameter.fsbgetvalue_chain('TRAB_NO_GENERA_CERT_ASOCIADOS'),id_trabcert,',') = 'N')
      and b.causal_id = dald_parameter.fnugetnumeric_value('CAUSA_TRABAJOS_POR_TERCEROS', null)--9584
      AND b.ORDER_STATUS_ID = 8;

  nucantterceros number;
  nucantrepara  number;
  nucantest7    number;
  nucantIncum   number;
  nutotal       number;
  nuretorno     number := 0;

begin
 Open cuCantOTRepara(nuSolicitud);
  fetch cuCantOTRepara
    into nucantRepara;
  close cucantotrepara;

  if(nucantRepara > 0) then

    --Caso1. cantidad de ordenes en estado 7 igual a cantidad de ordenes de reparacion
    Open cuCaso1(nuSolicitud);
    fetch cuCaso1
      into nucantest7;
    close cucaso1;

    if(nucantrepara = nucantest7) then
      nuretorno := 1;
    --Caso2. al menos una orden en estado 7 y las otras incumplidas
    elsif(nucantest7 < nucantrepara) then

      --Caso3. al menos una orden con causal 9584
      Open cuCaso3(nuSolicitud);
      fetch cuCaso3
        into nucantterceros;
      close cucaso3;

      if(nucantterceros>0) then
        nuretorno := 3;

      end if;
    end if;
  end if;

  return nuretorno;
end LDC_fnuValidaCasosRepara;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNUVALIDACASOSREPARA', 'ADM_PERSON');
END;
/