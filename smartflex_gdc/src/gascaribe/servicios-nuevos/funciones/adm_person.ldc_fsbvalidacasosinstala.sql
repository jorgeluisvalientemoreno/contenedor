CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FSBVALIDACASOSINSTALA" (inuadressid  or_order_activity.address_id%type,
                                   inupackageid or_order_activity.package_id%type,
                                   inuReporte number)
return number
 /*****************************************
  Metodo      : ldc_fsbvalidacasosinstala
  Descripcion : De acuerdo al reporte:
                1-RTCI
                Obtiene la orden de certificacion para nuevas, teniendo en cuenta que las ordenes
                de cargo y/o instalacion se encuentren en estado 7-Ejecutadas y la de certificacion en
                estado 5-Asignada
                2-RLTI
                Obtiene la orden de certificacion legalizada, siempre que la orden de cargo y/o
                instalacion hayan sido ejecutadas

  Autor: Luz Andrea Angel M./OLSoftware
  Fecha: Septiembre 23/2013

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
  25/09/2013        luzaa             Se incluye valdiacion ya que si no hay ordenes ejecutadas NO debería mostrar OT de certificacion
  17/10/2013        luzaa             NC1237:Se impacta la logica para incluir los dos nuevos reportes que corresponden a la OT Red Matriz
  18/10/2013        luzaa             NC1119: Se modifica consulta para que en el reporte RLTI y RLTI2 traiga las ordenes en estado 7 y en estado 8
                                      con causal de certificacion. Cursores impactados: cucantotxdirxsol2 y cucantotxdirxsol4
  28/04/2015        sagomez           Se modifica el cursor cucantotxdirxsol2 para que acepte ordenes en estado 7 y 5
                                      por el parametro COD_EST_OT_RLTI Aranda 7027
                                      Se modifica el cursor cucantotinstalaeje para que acepte ordenes en estado 7 y 5
                                      por el parametro COD_EST_OT_RLTI Aranda 7027
                                      Se modifica el cursor cucantotcargoeje para que acepte ordenes en estado 7 y 5
                                      por el parametro COD_EST_OT_RLTI Aranda 7027
                                      Se modifica el cursor cucantotredmatrizeje para que acepte ordenes en estado 7 y 5
                                      por el parametro COD_EST_OT_RLTI Aranda 7027
                                      Se modifica el cursor cucantotxdirxsol4 para que acepte ordenes en estado 7 y 5
                                      por el parametro COD_EST_OT_RLTI Aranda 7027



  ******************************************/

is
  --obtiene la cantidad de ordenes asociadas a una direccion por solicitud para reporte RTCI
  cursor cucantotxdirxsol(nuadress  or_order_activity.address_id%type,
                          nupackage or_order_activity.package_id%type) is
    select count(1)
    from or_order_activity a, or_order b
    where a.order_id = b.order_id
      and b.order_status_id in (5,7)
      and a.task_type_id in(12150, 12152, 12151, 12149, 12162)
      and a.address_id = nuadress
      and a.package_id = nupackage;

--obtiene la cantidad de ordenes asociadas a una direccion por solicitud para reporte RLTI
  cursor cucantotxdirxsol2(nuadress  or_order_activity.address_id%type,
                          nupackage or_order_activity.package_id%type) is
    select  count(1)+
                    (select count(1)
                        from or_order_activity x, or_order y
                        where x.order_id = y.order_id
                          and y.order_status_id in (SELECT TO_NUMBER(COLUMN_VALUE)
                              FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS
                                        (dald_parameter.fsbGetValue_Chain('COD_EST_OT_RLTI'),',')))
                          and x.task_type_id in(12150, 12152, 12151, 12149)
                          and x.address_id = nuadress
                          and x.package_id = nupackage) Total
    from or_order_activity a, or_order b
    where a.order_id = b.order_id
      and b.order_status_id = 8
      and a.task_type_id in(12162)
      and a.address_id = nuadress
      and a.package_id = nupackage
      and ldc_boutilities.fsbbuscatoken(dald_parameter.fsbgetvalue_chain('CAUSA_CERT_INSTALACION'),to_char(b.causal_id),',') = 'S'
    group by  a.package_id;

  --obtiene la cantidad de ordenes de instalacion en estado 7
  cursor cucantotinstalaeje(nuadress  or_order_activity.address_id%type,
                            nupackage or_order_activity.package_id%type) is
    select count(1)
    from or_order_activity a, or_order b
    where a.order_id = b.order_id
      and b.order_status_id in (SELECT TO_NUMBER(COLUMN_VALUE)
                              FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS
                                        (dald_parameter.fsbGetValue_Chain('COD_EST_OT_RLTI'),',')))
      and a.task_type_id in (12151, 12149)
      and a.address_id = nuadress
      and a.package_id = nupackage;

  --obtiene la cantidad de ordenes de cargo en estado 7
  cursor cucantotcargoeje(nuadress  or_order_activity.address_id%type,
                          nupackage or_order_activity.package_id%type) is
    select count(1)
    from or_order_activity a, or_order b
    where a.order_id = b.order_id
      and b.order_status_id in (SELECT TO_NUMBER(COLUMN_VALUE)
                              FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS
                                        (dald_parameter.fsbGetValue_Chain('COD_EST_OT_RLTI'),',')))
      and a.task_type_id in (12150, 12152)
      and a.address_id = nuadress
      and a.package_id = nupackage;

  --obtiene orden de certificacion en estado 5
  cursor cuotcertif(nuadress  or_order_activity.address_id%type,
                    nupackage or_order_activity.package_id%type) is
    select a.order_id
    from or_order_activity a, or_order b
    where a.order_id = b.order_id
      and b.order_status_id = 5
      and a.task_type_id = 12162
      and a.address_id = nuadress
      and a.package_id = nupackage;

  --obtiene orden de certificacion en estado 5
  cursor cuotcertifleg(nuadress  or_order_activity.address_id%type,
                       nupackage or_order_activity.package_id%type) is
    select a.order_id
    from or_order_activity a, or_order b
    where a.order_id = b.order_id
      and b.order_status_id = 8
      and a.task_type_id = 12162
      and a.address_id = nuadress
      and a.package_id = nupackage;

  --obtiene la cantidad de ordenes de construc. de red matriz en estado 7
  cursor cucantotredmatrizeje(nuadress  or_order_activity.address_id%type,
                              nupackage or_order_activity.package_id%type) is
    select count(1)
    from or_order_activity a, or_order b
    where a.order_id = b.order_id
      and b.order_status_id in (SELECT TO_NUMBER(COLUMN_VALUE)
                              FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS
                                        (dald_parameter.fsbGetValue_Chain('COD_EST_OT_RLTI'),',')))
      and a.task_type_id = 10268
      and a.address_id = nuadress
      and a.package_id = nupackage;

  --obtiene la cantidad de ordenes asociadas a una direccion por solicitud para reporte RTCI-matriz
  cursor cucantotxdirxsol3(nuadress  or_order_activity.address_id%type,
                          nupackage or_order_activity.package_id%type) is
    select count(1)
    from or_order_activity a, or_order b
    where a.order_id = b.order_id
      and b.order_status_id in (5,7)
      and a.task_type_id in (10268,10348)
      and a.address_id = nuadress
      and a.package_id = nupackage;

  --obtiene la cantidad de ordenes asociadas a una direccion por solicitud para reporte RLTI-matriz
  cursor cucantotxdirxsol4(nuadress  or_order_activity.address_id%type,
                          nupackage or_order_activity.package_id%type) is
    select count(1)+
                  (select count(1)
                  from or_order_activity x, or_order y
                  where x.order_id = y.order_id
                    and y.order_status_id in (SELECT TO_NUMBER(COLUMN_VALUE)
                                                     FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS
                                                          (dald_parameter.fsbGetValue_Chain('COD_EST_OT_RLTI'),',')))
                    and x.task_type_id in (10268)
                    and x.address_id = nuadress
                    and x.package_id = nupackage)
    from or_order_activity a, or_order b
    where a.order_id = b.order_id
      and b.order_status_id = 8
      and a.task_type_id in (10348)
      and a.address_id = nuadress
      and a.package_id = nupackage
      and ldc_boutilities.fsbbuscatoken(dald_parameter.fsbgetvalue_chain('CAUSA_CERT_INSTALACION'),to_char(b.causal_id),',') = 'S'
    group by a.package_id;
  --obtiene orden de certificacion de matriz en estado 8
  cursor cuotcertifmatrizleg(nuadress  or_order_activity.address_id%type,
                             nupackage or_order_activity.package_id%type) is
    select a.order_id
    from or_order_activity a, or_order b
    where a.order_id = b.order_id
      and b.order_status_id = 8
      and a.task_type_id = 10348
      and a.address_id = nuadress
      and a.package_id = nupackage;

  --obtiene orden de certificacion de matriz en estado 5
  cursor cuotcertifMatriz(nuadress  or_order_activity.address_id%type,
                          nupackage or_order_activity.package_id%type) is
    select a.order_id
    from or_order_activity a, or_order b
    where a.order_id = b.order_id
      and b.order_status_id = 5
      and a.task_type_id = 10348
      and a.address_id = nuadress
      and a.package_id = nupackage;

  nucantot        number;
  nucantotinstala number;
  nucantotcargo number;
  nucantotred   number;
  nucanotejec   number;
  nuordencertif or_order.order_id%type;
begin
  --RTCI y RLTI
  if(inureporte = 1 or inureporte = 2)then
   Open cucantotinstalaeje(inuadressid, inupackageid);
      fetch cucantotinstalaeje
      into nucantotinstala;
    close cucantotinstalaeje;
    --dbms_output.put_line('nucantotinstala -->'|| nucantotinstala);
    Open cucantotcargoeje(inuadressid, inupackageid);
      fetch cucantotcargoeje
      into nucantotcargo;
    close cucantotcargoeje;
   -- dbms_output.put_line('nucantotcargo -->'|| nucantotcargo);

    nucanotejec := nucantotinstala + nucantotcargo;
   -- dbms_output.put_line('nucanotejec -->'|| nucanotejec);
 --RTCI2 y RLTI2
  elsif(inureporte = 3 or inureporte = 4)then

    Open cucantotredmatrizeje(inuadressid, inupackageid);
      fetch cucantotredmatrizeje
      into nucantotred;
    close cucantotredmatrizeje;
    --dbms_output.put_line('nucantotred -->'|| nucantotred);
    nucanotejec := nucantotred;
    --dbms_output.put_line('nucanotejec -->'|| nucanotejec);
  end if;

  --RTCI
  if(inureporte = 1)then
    Open cucantotxdirxsol(inuadressid, inupackageid);
      fetch cucantotxdirxsol
      into nuCantOT;
    close cucantotxdirxsol;
    --dbms_output.put_line('nuCantOT -->'|| nuCantOT);

    if (nuCantOT > 0 and nucantot <=3) then
      if(nucanotejec > 0)then
        if(nucanotejec = (nucantot-1))then
          Open cuotcertif(inuadressid, inupackageid);
            fetch cuotcertif
            into nuordencertif;
          close cuotcertif;
        end if;
      end if;
    end if;
  --RLTI
  elsif(inureporte = 2)then
    open cucantotxdirxsol2(inuadressid, inupackageid);
      fetch cucantotxdirxsol2
      into nucantot;
    close cucantotxdirxsol2;
    --dbms_output.put_line('nuCantOT -->'|| nuCantOT);
    if (nuCantOT > 0 and nucantot <=3) then
      if(nucanotejec > 0)then
        if(nucanotejec = (nucantot-1))then
          Open cuotcertifleg(inuadressid, inupackageid);
            fetch cuotcertifleg
            into nuordencertif;
          close cuotcertifleg;
        end if;
      end if;
    end if;
    --RTCI2-Matriz
  elsif(inureporte = 3)then
    open cucantotxdirxsol3(inuadressid, inupackageid);
      fetch cucantotxdirxsol3
      into nucantot;
    close cucantotxdirxsol3;
    --dbms_output.put_line('nuCantOT -->'|| nucantot);
    if (nuCantOT > 0 and nucantot <=2) then
      if(nucanotejec > 0)then
        if(nucanotejec = (nucantot-1))then
          Open cuotcertifmatriz(inuadressid, inupackageid);
            fetch cuotcertifmatriz
            into nuordencertif;
          close cuotcertifmatriz;
        end if;
      end if;
    end if;
  --RLTI2-Matriz
  elsif(inureporte = 4)then

    open cucantotxdirxsol4(inuadressid, inupackageid);
      fetch cucantotxdirxsol4
      into nucantot;
    close cucantotxdirxsol4;
    --dbms_output.put_line('nuCantOT -->'|| nucantot);
    if (nuCantOT > 0 and nucantot <=2) then
      if(nucanotejec > 0)then
        if(nucanotejec = (nucantot-1))then
          Open cuotcertifmatrizleg(inuadressid, inupackageid);
            fetch cuotcertifmatrizleg
            into nuordencertif;
          close cuotcertifmatrizleg;
        end if;
      end if;
    end if;
  end if;

  return nuordencertif;
end ldc_fsbvalidacasosinstala;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FSBVALIDACASOSINSTALA', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_FSBVALIDACASOSINSTALA TO REXEREPORTES;
/