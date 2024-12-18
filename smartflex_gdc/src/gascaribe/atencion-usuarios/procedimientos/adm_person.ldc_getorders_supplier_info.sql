CREATE OR REPLACE procedure ADM_PERSON.LDC_GETORDERS_SUPPLIER_INFO (inuPackageId  in mo_packages.package_id%type,
                                                                    ocuOrderInfo    out constants.tyrefcursor) is
  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : LDC_GETORDERS_SUPPLIER_INFO
  Descripcion    : Obtiene las ÿrdenes dada la solicitud. Utilizado en CNCRM

  Autor          : KCienfuegos.RNP2923
  Fecha          : 29/12/2014

  Parametros                   Descripcion
  ============             ===================
  inuPackageId:              Id del Paquete

  Historia de Modificaciones
  Fecha            Autor                 Modificacion
  =========        =========             ====================
  29/12/2014       KCienfuegos.RNP2923    Creación.
  ******************************************************************/

    sbQuery         varchar2(32000);
    sbSelect        varchar2(6000);
    sbFrom          varchar2(3200);
    sbWhere         varchar2(3200);
    nuOperatingUnit   or_operating_unit.operating_unit_id%type;
    nuOperUnitPack    or_operating_unit.operating_unit_id%type;
    nuOperClassif	    or_oper_unit_classif.oper_unit_classif_id%type;
    nuClassSuppl      or_oper_unit_classif.oper_unit_classif_id%type;
    nuClassContract   or_operating_unit.oper_unit_classif_id%type;
    nuContractor      or_operating_unit.contractor_id%type;
    nuContractorPack  or_operating_unit.contractor_id%type;
    nuClassUTPack     or_oper_unit_classif.oper_unit_classif_id%type;

    --Obtiene la unidad operativa del usuario conectado
    CURSOR cuGetunitBySeller
    IS  SELECT organizat_area_id
        FROM cc_orga_area_seller
        WHERE person_id = GE_BOPersonal.fnuGetPersonId
        AND IS_current = 'Y'
        AND rownum = 1;

BEGIN
    nuClassSuppl := DALD_PARAMETER.fnuGetNumeric_Value('SUPPLIER_FNB');
    nuClassContract := DALD_PARAMETER.fnuGetNumeric_Value('CONTRACTOR_SALES_FNB');

    ut_trace.trace('Inicio LDC_GETORDERS_SUPPLIER_INFO', 10);

    --Obtiene la unidad operativa conectada
    open cuGetunitBySeller;
    fetch cuGetunitBySeller INTO nuOperatingUnit;
    close cuGetunitBySeller;

    ut_trace.trace('LD_BOQueryFNB.LD_BOQueryFNB -->Obtiene la unidad operativa conectada: '||nuOperatingUnit, 10);

    if damo_packages.fblexist(inuPackageId) then
      --Obtiene la unidad operativa de la solicitud
      nuOperUnitPack := damo_packages.fnugetoperating_unit_id(inuPackageId);

      ut_trace.trace('LD_BOQueryFNB.LD_BOQueryFNB -->Obtiene la unidad operativa de la solicitud: '||nuOperUnitPack, 10);

      if nuOperUnitPack is not null then
        --Obtiene la clasificación de la UT que registró la venta
        nuClassUTPack := daor_operating_unit.fnugetoper_unit_classif_id(nuOperUnitPack);

        ut_trace.trace('LD_BOQueryFNB.LD_BOQueryFNB -->Obtiene la clasificación de la UT que registró la venta: '||nuClassUTPack, 10);

        --Obtiene el contratista de la unidad operativa que registró la venta
        nuContractorPack := daor_operating_unit.fnugetcontractor_id(nuOperUnitPack);
      end if;

      if nuOperatingUnit is not null then
        --Obtiene la clasificación de la UT del usuario conectado
        nuOperClassif := daor_operating_unit.fnugetoper_unit_classif_id(nuOperatingUnit);

        --Obtiene el contratista de la unidad operativa del usuario conectado
        nuContractor    :=  daor_operating_unit.fnugetcontractor_id(nuOperatingUnit);
      end if;

    end if;

    if nvl(nuOperClassif,-1) = nuClassContract then

      sbSelect := 'SELECT distinct o.order_id,'||  chr(10) ||
                   'o.task_type_id || '' - '' || daor_task_type.fsbgetdescription(o.task_type_id) "TASK_TYPE",'||  chr(10) ||
                   '(select op.operating_unit_id || '' - ''|| op.name from or_operating_unit op where op.operating_unit_id=oa.operating_unit_id) "OPER_UNIT",'||  chr(10) ||
                   '(select ge_causal.causal_id || '' - '' || ge_causal.description FROM ge_causal WHERE ge_causal.causal_id = o.causal_id) "CAUSAL",'||  chr(10) ||
                   'o.order_status_id ||'' - ''|| daor_order_status.fsbgetdescription(o.order_status_id) "ORDER_STATUS",'||  chr(10) ||
                   '(select or_operating_sector.operating_sector_id || '' - '' || or_operating_sector.description FROM or_operating_sector WHERE o.operating_sector_id = or_operating_sector.operating_sector_id) "OPERATING_SECTOR",'||  chr(10) ||
                   'o.created_date "CREATION_DATE",'||  chr(10) ||
                   'o.assigned_date "ASSIGNED_DATE",'||  chr(10) ||
                   'o.legalization_date "LEGALIZATION_DATE",'||  chr(10) ||
                   'o.numerator_id||'' - ''||o.sequence "NUMERATOR_ID",'||  chr(10) ||
                   '(select or_oper_unit_status.oper_unit_status_id ||'' - ''||or_oper_unit_status.description from or_operating_unit, or_oper_unit_status where or_oper_unit_status.oper_unit_status_id=or_operating_unit.oper_unit_status_id and or_operating_unit.operating_unit_id=oa.operating_unit_id) "OPER_UNIT_STATUS",'||  chr(10) ||
                   'o.assigned_with ||'' - ''||decode (o.assigned_with,''S'',GE_BOI18N.FSBGETTRASLATION(''ASSIGNED_WITH_S''),''C'', GE_BOI18N.FSBGETTRASLATION(''ASSIGNED_WITH_C''), ''N'',GE_BOI18N.FSBGETTRASLATION(''ASSIGNED_WITH_N''),''R'',GE_BOI18N.FSBGETTRASLATION(''ASSIGNED_WITH_R''),null) "ASSIGNED_WITH",'||  chr(10) ||
                   'o.exec_estimate_date "EXEC_ESTIMATE_DATE",'||  chr(10) ||
                   'o.max_date_to_legalize "MAX_DATE_TO_LEGALIZE",'||  chr(10) ||
                   'o.exec_initial_date "EXEC_INITIAL_DATE",'||  chr(10) ||
                   'o.execution_final_date "EXECUTION_FINAL_DATE",'||  chr(10) ||
                   '(select or_order_person.person_id || ''-'' || ge_person.name_
                      from ge_person, or_order_person
                     where ge_person.person_id = or_order_person.person_id
                       and or_order_person.operating_unit_id = o.operating_unit_id
                       and or_order_person.order_id = o.order_id) "PERSONAL",'||  chr(10) ||
                       'o.order_value "ORDER_VALUE",'||  chr(10) ||
                   'o.real_task_type_id || '' - '' || daor_task_type.fsbgetdescription(o.real_task_type_id) "REAL_TASK_TYPE",'||  chr(10) ||
                   'o.route_id "ROUTE",'||  chr(10) ||
                   '(select  o.route_id || '' - '' || OR_route.Name FROM OR_route WHERE OR_route.route_id = o.route_id) "ROUTE_NAME",'||  chr(10) ||
                   'o.consecutive "ROUTE_CONSECUTIVE",'||  chr(10) ||
         'decode(o.external_address_id,null,null,daab_address.fsbgetaddress_parsed(o.external_address_id)) "ADDRESS",'||  chr(10) ||
         'decode(o.external_address_id,null,null,ab_bobasicdataservices.fsbGetDescNeighborthoodByAddr(o.external_address_id)) "NEIGHBORTHOOD",'||  chr(10) ||
         'decode(o.external_address_id,null,null,ab_bobasicdataservices.fsbGetDescGeograLocatiByAddr(o.external_address_id)) "GEOGRA_LOCATION",'||  chr(10) ||
         's.identification "SUBSCRIBER_ID",'||  chr(10) ||
         'dage_subscriber.fsbgetsubscriber_name(o.subscriber_id) "FIRST_NAME",'||  chr(10) ||
         'dage_subscriber.fsbgetsubs_last_name(o.subscriber_id) "LAST_NAME",'||  chr(10) ||
         'decode(s.subscriber_type_id,null,null, dage_subscriber_type.fsbgetdescription(s.subscriber_type_id)) "SUBSCRIBER_TYPE",'||  chr(10) ||
         'or_bobasicdataservices.fsbObtTelefonoClient(o.order_id) "PHONE",'||  chr(10) ||
         'or_bobasicdataservices.fnuEsfuerzoOrden(o.order_id) "ESFUERZO_ORDEN",'||  chr(10) ||
         'or_bcordercomment.fsbLastCommentByOrder(o.order_id) "COMMENT",'||  chr(10) ||
         'or_bcordercomment.fsbLastCommentTypeByOrder(o.order_id) "COMMENTTYPE",'||  chr(10) ||
         'oa.package_id "PARENT_ID"';

      sbFrom := 'FROM or_order_activity oa, or_order o, ge_subscriber s';

      sbWhere := 'WHERE s.subscriber_id(+)= o.subscriber_id'||  chr(10) ||
                 'and o.order_id = oa.order_id'||  chr(10) ||
                 'and oa.package_id = :inuPackageId'||  chr(10) ||
                 'and LDC_SHOW_PAYMENT_ORDERS(o.order_id)=1';


      if nuContractor <> nuContractorPack then
        sbWhere := sbWhere ||  chr(10) || 'and 1=2';
      end if;

      sbQuery := sbSelect ||  chr(10) ||
                 sbFrom ||  chr(10) ||
                 sbWhere;

    elsif nvl(nuOperClassif,-1) = nuClassSuppl then
       sbSelect := 'SELECT distinct o.order_id,'||  chr(10) ||
                     'o.task_type_id || '' - '' || daor_task_type.fsbgetdescription(o.task_type_id) "TASK_TYPE",'||  chr(10) ||
                     '(select op.operating_unit_id || '' - ''|| op.name FROM or_operating_unit op WHERE op.operating_unit_id=o.operating_unit_id) "OPER_UNIT",'||  chr(10) ||
                     '(select ge_causal.causal_id || '' - '' || ge_causal.description FROM ge_causal WHERE ge_causal.causal_id = o.causal_id) "CAUSAL",'||  chr(10) ||
                     'o.order_status_id ||'' - ''|| daor_order_status.fsbgetdescription(o.order_status_id) "ORDER_STATUS",'||  chr(10) ||
                     '(select or_operating_sector.operating_sector_id || '' - '' || or_operating_sector.description FROM or_operating_sector WHERE o.operating_sector_id = or_operating_sector.operating_sector_id) "OPERATING_SECTOR",'||  chr(10) ||
                     'o.created_date "CREATION_DATE",'||  chr(10) ||
                     'o.assigned_date "ASSIGNED_DATE",'||  chr(10) ||
                     'o.legalization_date "LEGALIZATION_DATE",'||  chr(10) ||
                     'o.numerator_id||'' - ''||o.sequence "NUMERATOR_ID",'||  chr(10) ||
                     '(select or_oper_unit_status.oper_unit_status_id ||'' - ''||or_oper_unit_status.description from or_operating_unit, or_oper_unit_status where or_oper_unit_status.oper_unit_status_id=or_operating_unit.oper_unit_status_id and or_operating_unit.operating_unit_id=oa.operating_unit_id) "OPER_UNIT_STATUS",'||  chr(10) ||
                     'o.assigned_with ||'' - ''||decode (o.assigned_with,''S'',GE_BOI18N.FSBGETTRASLATION(''ASSIGNED_WITH_S''),''C'', GE_BOI18N.FSBGETTRASLATION(''ASSIGNED_WITH_C''), ''N'',GE_BOI18N.FSBGETTRASLATION(''ASSIGNED_WITH_N''),''R'',GE_BOI18N.FSBGETTRASLATION(''ASSIGNED_WITH_R''),null) "ASSIGNED_WITH",'||  chr(10) ||
                     'o.exec_estimate_date "EXEC_ESTIMATE_DATE",'||  chr(10) ||
                     'o.max_date_to_legalize "MAX_DATE_TO_LEGALIZE",'||  chr(10) ||
                     'o.exec_initial_date "EXEC_INITIAL_DATE",'||  chr(10) ||
                     'o.execution_final_date "EXECUTION_FINAL_DATE",'||  chr(10) ||
                     '(select or_order_person.person_id || ''-'' || ge_person.name_
                        from ge_person, or_order_person
                       where ge_person.person_id = or_order_person.person_id
                         and or_order_person.operating_unit_id = o.operating_unit_id
                         and or_order_person.order_id = o.order_id) "PERSONAL",'||  chr(10) ||
                         'o.order_value "ORDER_VALUE",'||  chr(10) ||
                     'o.real_task_type_id || '' - '' || daor_task_type.fsbgetdescription(o.real_task_type_id) "REAL_TASK_TYPE",'||  chr(10) ||
                     'o.route_id "ROUTE",'||  chr(10) ||
                     '(select  o.route_id || '' - '' || OR_route.Name FROM OR_route WHERE OR_route.route_id = o.route_id) "ROUTE_NAME",'||  chr(10) ||
                     'o.consecutive "ROUTE_CONSECUTIVE",'||  chr(10) ||
           'decode(o.external_address_id,null,null,daab_address.fsbgetaddress_parsed(o.external_address_id)) "ADDRESS",'||  chr(10) ||
           'decode(o.external_address_id,null,null,ab_bobasicdataservices.fsbGetDescNeighborthoodByAddr(o.external_address_id)) "NEIGHBORTHOOD",'||  chr(10) ||
           'decode(o.external_address_id,null,null,ab_bobasicdataservices.fsbGetDescGeograLocatiByAddr(o.external_address_id)) "GEOGRA_LOCATION",'||  chr(10) ||
           's.identification "SUBSCRIBER_ID",'||  chr(10) ||
           'dage_subscriber.fsbgetsubscriber_name(o.subscriber_id) "FIRST_NAME",'||  chr(10) ||
           'dage_subscriber.fsbgetsubs_last_name(o.subscriber_id) "LAST_NAME",'||  chr(10) ||
           'decode(s.subscriber_type_id,null,null, dage_subscriber_type.fsbgetdescription(s.subscriber_type_id)) "SUBSCRIBER_TYPE",'||  chr(10) ||
           'or_bobasicdataservices.fsbObtTelefonoClient(o.order_id) "PHONE",'||  chr(10) ||
           'or_bobasicdataservices.fnuEsfuerzoOrden(o.order_id) "ESFUERZO_ORDEN",'||  chr(10) ||
           'or_bcordercomment.fsbLastCommentByOrder(o.order_id) "COMMENT",'||  chr(10) ||
           'or_bcordercomment.fsbLastCommentTypeByOrder(o.order_id) "COMMENTTYPE",'||  chr(10) ||
           'oa.package_id "PARENT_ID"';

        sbFrom := 'FROM or_order_activity oa, or_order o, ge_subscriber s';

        sbWhere := 'WHERE s.subscriber_id(+)= o.subscriber_id'||  chr(10) ||
                   'and o.order_id = oa.order_id'||  chr(10) ||
                   'and oa.package_id = :inuPackageId'||  chr(10) ||
                   'and LDC_SHOW_PAYMENT_ORDERS(o.order_id)=1';

        if nuContractor <> nuContractorPack then
          sbWhere := sbWhere ||  chr(10) || 'and 1=2';
        end if;

        if nuClassUTPack not in (nuClassSuppl, nuClassContract) then
          sbWhere := sbWhere ||  chr(10) || 'and 1=2';
        end if;

        sbQuery := sbSelect ||  chr(10) ||
                   sbFrom ||  chr(10) ||
                   sbWhere;

    else
      sbSelect := 'SELECT distinct o.order_id,'||  chr(10) ||
                   'o.task_type_id || '' - '' || daor_task_type.fsbgetdescription(o.task_type_id) "TASK_TYPE",'||  chr(10) ||
                   '(select op.operating_unit_id || '' - ''|| op.name from or_operating_unit op where op.operating_unit_id=o.operating_unit_id) "OPER_UNIT",'||  chr(10) ||
                   '(select ge_causal.causal_id || '' - '' || ge_causal.description FROM ge_causal WHERE ge_causal.causal_id = o.causal_id) "CAUSAL",'||  chr(10) ||
                   'o.order_status_id ||'' - ''|| daor_order_status.fsbgetdescription(o.order_status_id) "ORDER_STATUS",'||  chr(10) ||
                   '(select or_operating_sector.operating_sector_id || '' - '' || or_operating_sector.description FROM or_operating_sector WHERE o.operating_sector_id = or_operating_sector.operating_sector_id) "OPERATING_SECTOR",'||  chr(10) ||
                   'o.created_date "CREATION_DATE",'||  chr(10) ||
                   'o.assigned_date "ASSIGNED_DATE",'||  chr(10) ||
                   'o.legalization_date "LEGALIZATION_DATE",'||  chr(10) ||
                   'o.numerator_id||'' - ''||o.sequence "NUMERATOR_ID",'||  chr(10) ||
                   '(select or_oper_unit_status.oper_unit_status_id ||'' - ''||or_oper_unit_status.description from or_operating_unit, or_oper_unit_status where or_oper_unit_status.oper_unit_status_id=or_operating_unit.oper_unit_status_id and or_operating_unit.operating_unit_id=oa.operating_unit_id) "OPER_UNIT_STATUS",'||  chr(10) ||
                   'o.assigned_with ||'' - ''||decode (o.assigned_with,''S'',GE_BOI18N.FSBGETTRASLATION(''ASSIGNED_WITH_S''),''C'', GE_BOI18N.FSBGETTRASLATION(''ASSIGNED_WITH_C''), ''N'',GE_BOI18N.FSBGETTRASLATION(''ASSIGNED_WITH_N''),''R'',GE_BOI18N.FSBGETTRASLATION(''ASSIGNED_WITH_R''),null) "ASSIGNED_WITH",'||  chr(10) ||
                   'o.exec_estimate_date "EXEC_ESTIMATE_DATE",'||  chr(10) ||
                   'o.max_date_to_legalize "MAX_DATE_TO_LEGALIZE",'||  chr(10) ||
                   'o.exec_initial_date "EXEC_INITIAL_DATE",'||  chr(10) ||
                   'o.execution_final_date "EXECUTION_FINAL_DATE",'||  chr(10) ||
                   '(select or_order_person.person_id || ''-'' || ge_person.name_
                      from ge_person, or_order_person
                     where ge_person.person_id = or_order_person.person_id
                       and or_order_person.operating_unit_id = o.operating_unit_id
                       and or_order_person.order_id = o.order_id) "PERSONAL",'||  chr(10) ||
                       'o.order_value "ORDER_VALUE",'||  chr(10) ||
                   'o.real_task_type_id || '' - '' || daor_task_type.fsbgetdescription(o.real_task_type_id) "REAL_TASK_TYPE",'||  chr(10) ||
                   'o.route_id "ROUTE",'||  chr(10) ||
                   '(select  o.route_id || '' - '' || OR_route.Name FROM OR_route WHERE OR_route.route_id = o.route_id) "ROUTE_NAME",'||  chr(10) ||
                   'o.consecutive "ROUTE_CONSECUTIVE",'||  chr(10) ||
         'decode(o.external_address_id,null,null,daab_address.fsbgetaddress_parsed(o.external_address_id)) "ADDRESS",'||  chr(10) ||
         'decode(o.external_address_id,null,null,ab_bobasicdataservices.fsbGetDescNeighborthoodByAddr(o.external_address_id)) "NEIGHBORTHOOD",'||  chr(10) ||
         'decode(o.external_address_id,null,null,ab_bobasicdataservices.fsbGetDescGeograLocatiByAddr(o.external_address_id)) "GEOGRA_LOCATION",'||  chr(10) ||
         's.identification "SUBSCRIBER_ID",'||  chr(10) ||
         'dage_subscriber.fsbgetsubscriber_name(o.subscriber_id) "FIRST_NAME",'||  chr(10) ||
         'dage_subscriber.fsbgetsubs_last_name(o.subscriber_id) "LAST_NAME",'||  chr(10) ||
         'decode(s.subscriber_type_id,null,null, dage_subscriber_type.fsbgetdescription(s.subscriber_type_id)) "SUBSCRIBER_TYPE",'||  chr(10) ||
         'or_bobasicdataservices.fsbObtTelefonoClient(o.order_id) "PHONE",'||  chr(10) ||
         'or_bobasicdataservices.fnuEsfuerzoOrden(o.order_id) "ESFUERZO_ORDEN",'||  chr(10) ||
         'or_bcordercomment.fsbLastCommentByOrder(o.order_id) "COMMENT",'||  chr(10) ||
         'or_bcordercomment.fsbLastCommentTypeByOrder(o.order_id) "COMMENTTYPE",'||  chr(10) ||
         'oa.package_id "PARENT_ID"';

      sbFrom := 'FROM or_order_activity oa, or_order o, ge_subscriber s';

      sbWhere := 'WHERE s.subscriber_id(+)= o.subscriber_id'||  chr(10) ||
                 'and o.order_id = oa.order_id'||  chr(10) ||
                 'and oa.package_id = :inuPackageId'||  chr(10) ||
                 'order by o.order_id';

      sbQuery := sbSelect ||  chr(10) ||
                 sbFrom ||  chr(10) ||
                 sbWhere;
    end if;

    OPEN ocuOrderInfo FOR sbQuery USING inuPackageId;

end LDC_GETORDERS_SUPPLIER_INFO;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_GETORDERS_SUPPLIER_INFO', 'ADM_PERSON');
END;
/

