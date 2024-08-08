SELECT /*+ leading( instancias_flujo )
          index( d PK_WF_INSTANCE_STATUS )
          index( e PK_GE_ENTITY )
          index( g PK_GE_ACTION_MODULE )
          index( h PK_GR_CONFIG_EXPRESSION )
          use_nl( instancias_flujo d )
          use_nl( instancias_flujo e )
          use_nl( instancias_flujo f )
          use_nl( g h )
          index( a IDX_WF_DATA_EXTERNAL_01 )
          index( b PK_WF_UNIT_TYPE )
          index( c IDX_WF_INSTANCE_02 )
          index( f PK_WF_UNIT )
          use_nl( a b )
          use_nl( a c )
          use_nl( c f )
          */
 a.pack_type_tag,
 b.description unit_type_description,
 c.instance_id,
 c.description instance_description,
 c.plan_id,
 c.parent_id,
 c.status_id,
 c.entity_id,
 c.unit_id,
 nvl(c.action_id, nvl(f.action_id, b.action_id)) action_id,
 c.external_id,
 c.initial_date,
 c.final_date,
 f.unit_type_id,
 WIA.*,
 ooa.order_id,
 ooa.activity_id || ' - ' || gi.description,
 ooa.task_type_id || ' - ' || ott.description
  FROM open.wf_data_external a
  left join open.wf_unit_type b
    on b.unit_type_id = a.unit_type_id
  left join open.wf_instance c
    on c.plan_id = a.plan_id
  left join open.wf_unit f
    on f.unit_id = c.unit_id
  left join open.wf_instance_status d
    on d.instance_status_id = c.status_id
  left join open.ge_entity e
    on e.entity_id = c.entity_id
  left join open.ge_action_module g
    on g.action_id = c.action_id
  left join open.gr_config_expression h
    on h.config_expression_id = g.config_expression_id
  left join open.WF_INSTANCE_ATTRIB WIA
    on WIA.INSTANCE_ID = c.instance_id
  left join open.Or_Order_Activity ooa
    on ooa.instance_id = c.instance_id
   and 'S' = &Mostrar_Orden
  left join open.ge_items gi
    on gi.items_id = ooa.activity_id
   and 'S' = &Mostrar_Orden
  left join open.or_task_type ott
    on ott.task_type_id = ooa.task_type_id
   and 'S' = &Mostrar_Orden
 WHERE a.package_id = 209811479;
