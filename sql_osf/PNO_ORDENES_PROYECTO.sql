select distinct OR_ORDER.ORDER_ID ORDER_ID,
                OR_ORDER.numerator_id || chr(32) || chr(45) || chr(32) ||
                OR_ORDER.sequence numerator,
                (select or_task_type.task_type_id || chr(32) || chr(45) ||
                        chr(32) || or_task_type.description
                   FROM or_task_type
                  WHERE or_task_type.task_type_id = OR_order.task_type_id) TASK_TYPE,
                (select OR_order_status.order_status_id || chr(32) ||
                        chr(45) || chr(32) || OR_order_status.description
                   FROM OR_order_status
                  WHERE OR_order_status.order_status_id =
                        OR_order.order_status_id) ORDER_STATUS,
                (select or_operating_sector.operating_sector_id || chr(32) ||
                        chr(45) || chr(32) ||
                        or_operating_sector.description
                   FROM or_operating_sector
                  WHERE OR_order.operating_sector_id =
                        or_operating_sector.operating_sector_id) OPERATING_SECTOR,
                or_bobasicdataservices.fnuGetProductId(or_order.order_id) PRODUCT_ID,
                (select or_operating_unit.operating_unit_id || chr(32) ||
                        chr(45) || chr(32) || or_operating_unit.name
                   FROM or_operating_unit
                  WHERE or_operating_unit.operating_unit_id =
                        OR_order.operating_unit_id) OPERATING_UNIT,
                (select or_oper_unit_status.oper_unit_status_id || chr(32) ||
                        chr(45) || chr(32) ||
                        or_oper_unit_status.description
                   FROM or_operating_unit, or_oper_unit_status
                  WHERE or_operating_unit.oper_unit_status_id =
                        or_oper_unit_status.oper_unit_status_id
                    AND or_operating_unit.operating_unit_id =
                        OR_order.operating_unit_id) OPERATING_UNIT_STATUS,
                OR_ORDER.CREATED_DATE CREATED_DATE,
                OR_ORDER.ASSIGNED_DATE ASSIGNED_DATE,
                OR_ORDER.ASSIGNED_WITH || chr(32) || chr(45) || chr(32) ||
                decode(OR_ORDER.ASSIGNED_WITH,
                       'S',
                       'Horario',
                       'C',
                       'Capacidad Horaria',
                       'N',
                       'Demanda',
                       'R',
                       'Ruta',
                       null) ASSIGNED_WITH,
                OR_ORDER.EXEC_ESTIMATE_DATE EXEC_ESTIMATE_DATE,
                OR_ORDER.MAX_DATE_TO_LEGALIZE MAX_DATE_TO_LEGALIZE,
                OR_ORDER.REPROGRAM_LAST_DATE REPROGRAM_LAST_DATE,
                OR_ORDER.LEGALIZATION_DATE LEGALIZATION_DATE,
                OR_ORDER.EXEC_INITIAL_DATE EXEC_INITIAL_DATE,
                OR_ORDER.EXECUTION_FINAL_DATE EXECUTION_FINAL_DATE,
                (select ge_causal.causal_id || chr(32) || chr(45) || chr(32) ||
                        ge_causal.description
                   FROM ge_causal
                  WHERE ge_causal.causal_id = OR_order.causal_id) CAUSAL,
                (select OR_ORDER_PERSON.person_id || chr(32) || chr(45) ||
                        chr(32) || ge_person.name_
                   FROM ge_person, OR_ORDER_PERSON
                  WHERE ge_person.person_id = OR_ORDER_PERSON.person_id
                    AND OR_ORDER_PERSON.operating_unit_id =
                        OR_order.operating_unit_id
                    AND OR_ORDER_PERSON.order_id = OR_order.order_id) PERSON,
                OR_ORDER.ORDER_VALUE ORDER_VALUE,
                nvl(OR_ORDER.PRINTING_TIME_NUMBER, 0) PRINTING_TIME_NUMBER,
                nvl(OR_ORDER.LEGALIZE_TRY_TIMES, 0) LEGALIZE_TRY_TIMES,
                decode(OR_ORDER.IS_COUNTERMAND, 'Y', 'Si', 'No') S_COUNTERMAND,
                (select or_task_type.task_type_id || chr(32) || chr(45) ||
                        chr(32) || or_task_type.description
                   FROM or_task_type
                  WHERE or_task_type.task_type_id =
                        or_order.real_task_type_id) REAL_TASK_TYPE,
                OR_ORDER.PRIORITY PRIORITY,
                OR_BOBasicDataServices.fsbGetProgClassDesc(or_order.order_id) PROGCLASDESC,
                OR_ORDER.ARRANGED_HOUR ARRANGED_HOUR,
                OR_ORDER.APPOINTMENT_CONFIRM APPOINTMENT_CONFIRM,
                or_order.consecutive CORSCOPR,
                or_order.route_id RUSERUTA,
                (select OR_route.route_id || chr(32) || chr(45) || chr(32) ||
                        OR_route.Name
                   FROM OR_route
                  WHERE OR_route.route_id = or_order.route_id) ROUTE_NAME,
                AB_ADDRESS.address_parsed ADDRESS_PARSED,
                decode(or_order.external_address_id,
                       null,
                       null,
                       ab_bobasicdataservices.fsbGetDescNeighborthoodByAddr(or_order.external_address_id)) NEIGHBORTHOOD,
                decode(or_order.external_address_id,
                       null,
                       null,
                       ab_bobasicdataservices.fsbGetDescGeograLocatiByAddr(or_order.external_address_id)) GEOGRAP_LOCATION,
                ge_subscriber.identification SUBSCRIBER_ID,
                ge_subscriber.subscriber_name SUBSC_NAME,
                ge_subscriber.subs_last_name SUBSC_LAST_NAME,
                decode(ge_subscriber.subscriber_type_id,
                       null,
                       null,
                       ge_subscriber.subscriber_type_id || chr(32) ||
                       chr(45) || chr(32) ||
                       dage_subscriber_type.fsbgetdescription(ge_subscriber.subscriber_type_id)) CLIENT_TYPE,
                or_bobasicdataservices.fsbObtTelefonoClient(or_order.order_id) CLIENT_PHONE,
                or_bobasicdataservices.fnuObtUltimoScoring(or_order.order_id) SCORING,
                or_bobasicdataservices.fnuEsfuerzoOrden(or_order.order_id) DURATION,
                or_bcordercomment.fsbLastCommentByOrder(or_order.order_id) ORDER_COMMENT,
                or_bcordercomment.fsbLastCommentTypeByOrder(or_order.order_id) COMMENT_TYPE,
                or_order.asso_unit_id || chr(32) || chr(45) || chr(32) ||
                daor_operating_unit.fsbGetName(or_order.asso_unit_id, 0) ASSO_UNIT,
                or_order.offered OFFERED,
                PM_BOServices.fsbGetProjectNameByStage(or_order.stage_id) PROJECT_NAME,
                or_order.stage_id || chr(32) || chr(45) || chr(32) ||
                dapm_stage.fsbGetStage_name(or_order.stage_id, 0) STAGE_NAME,
                OR_ORDER.ORDER_STATUS_ID ORDER_STATUS_ID
  FROM open.OR_ORDER,
       open.GE_SUBSCRIBER,
       open.AB_ADDRESS,
       open.fm_possible_ntl,
       open.mo_packages,
       open.or_order_activity
/*+ Ubicaci�n : OR_boSearchDataServices.GetOrdersByNTL */
 WHERE AB_ADDRESS.address_id(+) = OR_ORDER.external_address_id
   AND GE_SUBSCRIBER.subscriber_id(+) = OR_ORDER.subscriber_id
   AND fm_possible_ntl.package_id = mo_packages.package_id(+)
   AND or_order.order_id = or_order_activity.order_id
   AND (fm_possible_ntl.order_id = or_order.order_id OR
        or_order_activity.package_id = mo_packages.package_id)
   AND fm_possible_ntl.possible_ntl_id = 505319;

select distinct OR_ORDER.ORDER_ID ORDER_ID,
                OR_ORDER.numerator_id || chr(32) || chr(45) || chr(32) ||
                OR_ORDER.sequence numerator,
                (select or_task_type.task_type_id || chr(32) || chr(45) ||
                        chr(32) || or_task_type.description
                   FROM or_task_type
                  WHERE or_task_type.task_type_id = OR_order.task_type_id) TASK_TYPE,
                (select OR_order_status.order_status_id || chr(32) ||
                        chr(45) || chr(32) || OR_order_status.description
                   FROM OR_order_status
                  WHERE OR_order_status.order_status_id =
                        OR_order.order_status_id) ORDER_STATUS,
                
                (select or_operating_sector.operating_sector_id || chr(32) ||
                        chr(45) || chr(32) ||
                        or_operating_sector.description
                   FROM or_operating_sector
                  WHERE OR_order.operating_sector_id =
                        or_operating_sector.operating_sector_id) OPERATING_SECTOR,
                or_bobasicdataservices.fnuGetProductId(or_order.order_id) PRODUCT_ID,
                (select or_operating_unit.operating_unit_id || chr(32) ||
                        chr(45) || chr(32) || or_operating_unit.name
                   FROM or_operating_unit
                  WHERE or_operating_unit.operating_unit_id =
                        OR_order.operating_unit_id) OPERATING_UNIT,
                (select or_oper_unit_status.oper_unit_status_id || chr(32) ||
                        chr(45) || chr(32) ||
                        or_oper_unit_status.description
                   FROM or_operating_unit, or_oper_unit_status
                  WHERE or_operating_unit.oper_unit_status_id =
                        or_oper_unit_status.oper_unit_status_id
                    AND or_operating_unit.operating_unit_id =
                        OR_order.operating_unit_id) OPERATING_UNIT_STATUS,
                OR_ORDER.CREATED_DATE CREATED_DATE,
                OR_ORDER.ASSIGNED_DATE ASSIGNED_DATE,
                OR_ORDER.ASSIGNED_WITH || chr(32) || chr(45) || chr(32) ||
                decode(OR_ORDER.ASSIGNED_WITH,
                       'S',
                       'Horario',
                       'C',
                       'Capacidad Horaria',
                       'N',
                       'Demanda',
                       'R',
                       'Ruta',
                       null) ASSIGNED_WITH,
                OR_ORDER.EXEC_ESTIMATE_DATE EXEC_ESTIMATE_DATE,
                OR_ORDER.MAX_DATE_TO_LEGALIZE MAX_DATE_TO_LEGALIZE,
                OR_ORDER.REPROGRAM_LAST_DATE REPROGRAM_LAST_DATE,
                OR_ORDER.LEGALIZATION_DATE LEGALIZATION_DATE,
                OR_ORDER.EXEC_INITIAL_DATE EXEC_INITIAL_DATE,
                OR_ORDER.EXECUTION_FINAL_DATE EXECUTION_FINAL_DATE,
                (select ge_causal.causal_id || chr(32) || chr(45) || chr(32) ||
                        ge_causal.description
                   FROM ge_causal
                  WHERE ge_causal.causal_id = OR_order.causal_id) CAUSAL,
                (select OR_ORDER_PERSON.person_id || chr(32) || chr(45) ||
                        chr(32) || ge_person.name_
                   FROM ge_person, OR_ORDER_PERSON
                  WHERE ge_person.person_id = OR_ORDER_PERSON.person_id
                    AND OR_ORDER_PERSON.operating_unit_id =
                        OR_order.operating_unit_id
                    AND OR_ORDER_PERSON.order_id = OR_order.order_id) PERSON,
                OR_ORDER.ORDER_VALUE ORDER_VALUE,
                nvl(OR_ORDER.PRINTING_TIME_NUMBER, 0) PRINTING_TIME_NUMBER,
                nvl(OR_ORDER.LEGALIZE_TRY_TIMES, 0) LEGALIZE_TRY_TIMES,
                decode(OR_ORDER.IS_COUNTERMAND, 'Y', 'Si', 'No') IS_COUNTERMAND,
                (select or_task_type.task_type_id || chr(32) || chr(45) ||
                        chr(32) || or_task_type.description
                   FROM or_task_type
                  WHERE or_task_type.task_type_id =
                        or_order.real_task_type_id) REAL_TASK_TYPE,
                
                OR_ORDER.PRIORITY PRIORITY,
                OR_BOBasicDataServices.fsbGetProgClassDesc(or_order.order_id) PROGCLASDESC,
                OR_ORDER.ARRANGED_HOUR ARRANGED_HOUR,
                OR_ORDER.APPOINTMENT_CONFIRM APPOINTMENT_CONFIRM,
                
                or_order.consecutive CORSCOPR,
                or_order.route_id RUSERUTA,
                (select OR_route.route_id || chr(32) || chr(45) || chr(32) ||
                        OR_route.Name
                   FROM OR_route
                  WHERE OR_route.route_id = or_order.route_id) ROUTE_NAME,
                AB_ADDRESS.address_parsed ADDRESS_PARSED,
                decode(or_order.external_address_id,
                       null,
                       null,
                       ab_bobasicdataservices.fsbGetDescNeighborthoodByAddr(or_order.external_address_id)) NEIGHBORTHOOD,
                decode(or_order.external_address_id,
                       null,
                       null,
                       ab_bobasicdataservices.fsbGetDescGeograLocatiByAddr(or_order.external_address_id)) GEOGRAP_LOCATION,
                ge_subscriber.identification SUBSCRIBER_ID,
                
                ge_subscriber.subscriber_name SUBSC_NAME,
                ge_subscriber.subs_last_name SUBSC_LAST_NAME,
                decode(ge_subscriber.subscriber_type_id,
                       null,
                       null,
                       ge_subscriber.subscriber_type_id || chr(32) ||
                       chr(45) || chr(32) ||
                       dage_subscriber_type.fsbgetdescription(ge_subscriber.subscriber_type_id)) CLIENT_TYPE,
                or_bobasicdataservices.fsbObtTelefonoClient(or_order.order_id) CLIENT_PHONE,
                
                or_bobasicdataservices.fnuObtUltimoScoring(or_order.order_id) SCORING,
                or_bobasicdataservices.fnuEsfuerzoOrden(or_order.order_id) DURATION,
                or_bcordercomment.fsbLastCommentByOrder(or_order.order_id) ORDER_COMMENT,
                or_bcordercomment.fsbLastCommentTypeByOrder(or_order.order_id) COMMENT_TYPE,
                or_order.asso_unit_id || chr(32) || chr(45) || chr(32) ||
                daor_operating_unit.fsbGetName(or_order.asso_unit_id, 0) ASSO_UNIT,
                or_order.offered OFFERED,
                PM_BOServices.fsbGetProjectNameByStage(or_order.stage_id) PROJECT_NAME,
                or_order.stage_id || chr(32) || chr(45) || chr(32) ||
                dapm_stage.fsbGetStage_name(or_order.stage_id, 0) STAGE_NAME,
                OR_ORDER.ORDER_STATUS_ID ORDER_STATUS_ID
  FROM OR_ORDER,
       GE_SUBSCRIBER,
       AB_ADDRESS,
       fm_possible_ntl,
       mo_packages,
       or_order_activity
/*+ Ubicaci�n : OR_boSearchDataServices.GetOrdersByNTL */
 WHERE AB_ADDRESS.address_id(+) = OR_ORDER.external_address_id
   AND GE_SUBSCRIBER.subscriber_id(+) = OR_ORDER.subscriber_id
   AND fm_possible_ntl.package_id = mo_packages.package_id(+)
   AND or_order.order_id = or_order_activity.order_id
   AND (fm_possible_ntl.order_id = or_order.order_id OR
        
        or_order_activity.package_id = mo_packages.package_id)
   AND fm_possible_ntl.possible_ntl_id = 505319;