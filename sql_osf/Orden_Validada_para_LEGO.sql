select /*+ index (o PK_OR_ORDER)*/
 dage_geogra_location.fnugetgeo_loca_father_id(aa.geograp_location_id) || ' ' ||
 dage_geogra_location.fsbgetdescription(dage_geogra_location.fnugetgeo_loca_father_id(aa.geograp_location_id)) departamento,
 dage_geogra_location.fnugetgeograp_location_id(aa.geograp_location_id) || ' ' ||
 dage_geogra_location.fsbgetdescription(dage_geogra_location.fnugetgeograp_location_id(aa.geograp_location_id)) localidad,
 oo.task_type_id || ' ' ||
 daor_task_type.fsbgetdescription(oo.task_type_id, null) tipotrabajo,
 oo.created_date fechacreacion,
 oo.assigned_date fechaasignacion,
 aa.address direccion,
 oo.task_type_id tipotrabajo_id,
 oo.operating_unit_id operating_unit_id,
 daor_operating_unit.fsbgetname(oo.operating_unit_id, null) operating_unit_name,
 ooa.subscription_id subscription_id,
 ooa.package_id package_id,
 ooa.product_id product_id,
 (select s.susccicl
    from suscripc s
   where s.susccodi = ooa.subscription_id
     and rownum = 1) susccicl,
 (select c.cicldesc
    from ciclo c
   where c.ciclcodi = (select s.susccicl
                         from suscripc s
                        where s.susccodi = ooa.subscription_id
                          and rownum = 1)
     and rownum = 1) cicldesc,
 aa.geograp_location_id ubicacion_geografica,
 decode(OO.ORDER_STATUS_ID,
        DALD_PARAMETER.fnuGetNumeric_Value('COD_ESTA_EJEC', NULL),
        oo.exec_initial_date) fecha_ini_ejecucion,
 decode(OO.ORDER_STATUS_ID,
        DALD_PARAMETER.fnuGetNumeric_Value('COD_ESTA_EJEC', NULL),
        oo.execution_final_date) fecha_fin_ejecucion,
 ooa.activity_id actividad
  from open.or_order oo, open.Or_Order_Activity ooa, ab_address aa
 where oo.order_id = &OrdenTrabajo
   and oo.order_id = ooa.order_id
   and ooa.status = 'R'
   and not exists
 (select 1
          from open.ct_item_novelty n
         where n.items_id = ooa.activity_id)
   and aa.address_id = decode(nvl(ooa.address_id, 0),
                              0,
                              (select s.susciddi
                                 from suscripc s
                                where s.susccodi = ooa.subscription_id),
                              ooa.address_id)
   AND OO.ORDER_STATUS_ID IN
       (DALD_PARAMETER.fnuGetNumeric_Value('ESTADO_ASIGNADO', NULL),
        DALD_PARAMETER.fnuGetNumeric_Value('COD_ESTA_EJEC', NULL))
   and (select count(nvl(lol.order_id, 0))
          from LDC_OTLEGALIZAR lol
         where lol.order_id = &OrdenTrabajo) = 0
   and (select count(ooup.operating_unit_id)
          from or_oper_unit_persons ooup
         where ooup.person_id = &nuPersonID
           and ooup.operating_unit_id = oo.operating_unit_id) > 0
   and (SELECT count(1)
          FROM DUAL
         WHERE oo.task_type_id IN
               (select to_number(column_value)
                  from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('HIST_TIPO_TRAB_LEGO',
                                                                                           NULL),
                                                          ',')))) > 0;
