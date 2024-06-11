
select package_type_id, display_name,c.object_name
from ps_package_attribs a
inner join open.gr_config_expression c on c.config_expression_id=a.init_expression_id
where package_type_id=100232
  and (init_expression_id is not null )
union all
select package_type_id, display_name,c.object_name
from ps_package_attribs a
inner join open.gr_config_expression c on c.config_expression_id=a.valid_expression_id
where package_type_id=100232
  and (a.valid_expression_id is not null)
union all
select p.package_type_id, 'ACCION_SOL', c.object_name
from open.ps_package_type p 
left join open.ge_action_module m on m.action_id=p.action_regis_exec
left join open.gr_config_expression c on c.config_expression_id=m.config_expression_id
where p.package_type_id in (100232)
union all
select p.package_type_id,
       'PRE-TRAMITE',
       presol.object_name
  from open.ps_package_type p
  left join open.PS_CNF_INSTANCE pre
    on pre.package_type = p.package_type_id
  left join open.gr_config_expression presol
    on presol.config_expression_id = pre.insert_before_expression
  left join open.gr_config_expression possol
    on possol.config_expression_id = pre.insert_after_expression
 where p.package_type_id in (100232)
 union all
 select p.package_type_id,
       'POS-TRAMITE',
       possol.object_name
  from open.ps_package_type p
  left join open.PS_CNF_INSTANCE pre
    on pre.package_type = p.package_type_id
  left join open.gr_config_expression presol
    on presol.config_expression_id = pre.insert_before_expression
  left join open.gr_config_expression possol
    on possol.config_expression_id = pre.insert_after_expression
 where p.package_type_id in (100232)
 union all
 select package_type_id, 'PRE-MOTIVO', c.object_name
from OPEN.PS_PRD_MOTIV_PACKAGE mot, PS_PROD_MOTI_EVENTS e, PS_WHEN_MOTIVE w, open.gr_config_expression c 
where PACKAGE_TYPE_ID in (100101)
 and mot.product_motive_id=e.product_motive_id
 and w.prod_moti_events_id=e.prod_moti_events_id
 and executing_time='B'
 and c.config_expression_id=w.config_expression_id
 union all
 select package_type_id, 'POS-MOTIVO', c.object_name
from OPEN.PS_PRD_MOTIV_PACKAGE mot, PS_PROD_MOTI_EVENTS e, PS_WHEN_MOTIVE w, open.gr_config_expression c 
where PACKAGE_TYPE_ID in (100101)
 and mot.product_motive_id=e.product_motive_id
 and w.prod_moti_events_id=e.prod_moti_events_id
 and executing_time='A'
 and c.config_expression_id=w.config_expression_id

UNION ALL 
SELECT PACKAGE_TYPE_ID, 'PRE_COMPONENETE', C.OBJECT_NAME
FROM OPEN.PS_PROD_MOTIVE_COMP CO
INNER JOIN OPEN.PS_PRD_MOTIV_PACKAGE mot ON MOT.PRODUCT_MOTIVE_ID=CO.PRODUCT_MOTIVE_ID AND MOT.PACKAGE_TYPE_ID=100101
INNER JOIN PS_MOTI_COMPON_EVENT CE ON CE.prod_motive_comp_id=CO.PROD_MOTIVE_COMP_ID
INNER JOIN open.PS_WHEN_MOTI_COMPON WH ON WH.MOTI_COMPON_EVENT_ID=CE.MOTI_COMPON_EVENT_ID AND WH.EXECUTING_TIME='B'
INNER JOIN OPEN.GR_CONFIG_EXPRESSION C ON C.CONFIG_EXPRESSION_ID=WH.CONFIG_EXPRESSION_ID
UNION ALL
SELECT PACKAGE_TYPE_ID, 'PRE_COMPONENETE', C.OBJECT_NAME
FROM OPEN.PS_PROD_MOTIVE_COMP CO
INNER JOIN OPEN.PS_PRD_MOTIV_PACKAGE mot ON MOT.PRODUCT_MOTIVE_ID=CO.PRODUCT_MOTIVE_ID AND MOT.PACKAGE_TYPE_ID=100101
INNER JOIN PS_MOTI_COMPON_EVENT CE ON CE.prod_motive_comp_id=CO.PROD_MOTIVE_COMP_ID
INNER JOIN open.PS_WHEN_MOTI_COMPON WH ON WH.MOTI_COMPON_EVENT_ID=CE.MOTI_COMPON_EVENT_ID AND WH.EXECUTING_TIME='AF'
INNER JOIN OPEN.GR_CONFIG_EXPRESSION C ON C.CONFIG_EXPRESSION_ID=WH.CONFIG_EXPRESSION_ID

