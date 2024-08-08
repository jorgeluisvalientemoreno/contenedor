CREATE OR REPLACE FUNCTION FrfOrdenTrabajo(OrdenTrabajo number)
  RETURN constants.tyRefCursor IS
  TYPE tyRefCursor IS REF CURSOR;
  rfQuery tyRefCursor;

  nuPersonID ge_person.person_id%type;

  ---Inicio CASO 200-1528
  cursor cuelmesesu is
    select emss.*
      from elmesesu emss
     where emss.emsssesu = (select ooa.product_id
                              from open.Or_Order_Activity ooa
                             where ooa.order_id = OrdenTrabajo
                               and ROWNUM = 1)
     order by emss.emssfein desc;

  rfcuelmesesu cuelmesesu%rowtype;

  cursor cumarcaproducto is
    SELECT LDC_MARCA_PRODUCTO.ID_PRODUCTO,
           LDC_MARCA_PRODUCTO.ORDER_ID,
           LDC_MARCA_PRODUCTO.CERTIFICADO,
           LDC_MARCA_PRODUCTO.FECHA_ULTIMA_ACTU,
           LDC_MARCA_PRODUCTO.INTENTOS,
           decode(LDC_MARCA_PRODUCTO.MEDIO_RECEPCION,
                  'I',
                  'I - Interna',
                  'E - Externa') MEDIO_RECEPCION,
           LDC_MARCA_PRODUCTO.REGISTER_POR_DEFECTO,
           nvl(LDC_MARCA_PRODUCTO.SUSPENSION_TYPE_ID, 101) || ' - ' ||
           dage_suspension_type.fsbgetdescription(nvl(LDC_MARCA_PRODUCTO.SUSPENSION_TYPE_ID,
                                                      101)) SUSPENSION_TYPE_ID
      FROM LDC_MARCA_PRODUCTO
     WHERE ldc_marca_producto.ID_PRODUCTO =
           (select ooa.product_id
              from open.Or_Order_Activity ooa
             where ooa.order_id = OrdenTrabajo
               and ROWNUM = 1);

  rfcumarcaproducto cumarcaproducto%rowtype;
  ---Fin CASO 200-1528

BEGIN

  ut_trace.trace('Inicio LDC_PKGESTIONORDENES.FrfOrdenTrabajo', 10);
  ut_trace.trace('Orden a consulta [' || OrdenTrabajo || ']', 10);

  nuPersonID := OPEN.GE_BOPERSONAL.FNUGETPERSONID;

  ut_trace.trace('Person ID [' || nuPersonID || ']', 10);

  ---Inicio CASO 200-1528
  open cuelmesesu;
  fetch cuelmesesu
    into rfcuelmesesu;
  close cuelmesesu;

  open cumarcaproducto;
  fetch cumarcaproducto
    into rfcumarcaproducto;
  close cumarcaproducto;
  ---Fin CASO 200-1528

  open rfQuery for
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
     ooa.activity_id actividad,
     nvl(rfcuelmesesu.emsscoem, 0) medidor,
     nvl(rfcumarcaproducto.suspension_type_id, 0) marca
      from open.or_order oo, open.Or_Order_Activity ooa, ab_address aa
     where oo.order_id = OrdenTrabajo
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
             where lol.order_id = OrdenTrabajo) = 0
       /*
       and (select count(ooup.operating_unit_id)
              from or_oper_unit_persons ooup
             where ooup.person_id = nuPersonID
               and ooup.operating_unit_id = oo.operating_unit_id) > 0
       */
       and (SELECT count(1)
              FROM DUAL
             WHERE oo.task_type_id IN
                   (select to_number(column_value)
                      from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('HIST_TIPO_TRAB_LEGO',
                                                                                               NULL),
                                                              ',')))) > 0;

  ut_trace.trace('Fin LDC_PKGESTIONORDENES.FrfOrdenTrabajo', 10);

  return(rfQuery);
EXCEPTION
  when ex.CONTROLLED_ERROR then
    raise ex.CONTROLLED_ERROR;
  when others then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;
END FrfOrdenTrabajo;
/
