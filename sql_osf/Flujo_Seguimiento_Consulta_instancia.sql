SELECT /*+ leading( instancias_flujo )
index( d PK_WF_INSTANCE_STATUS )
index( e PK_GE_ENTITY )
index( g PK_GE_ACTION_MODULE )
index( h PK_GR_CONFIG_EXPRESSION )
use_nl( instancias_flujo d )
use_nl( instancias_flujo e )
use_nl( instancias_flujo f )
use_nl( g h )
*/
 level "Nivel",
 instancias_flujo.unit_id,
 lpad(' ', decode(level, 1, 0, level - 1) * 8, ' ') ||
 instancias_flujo.instance_id || '-' || CASE
   WHEN instancias_flujo.instance_id = instancias_flujo.plan_id THEN
    instancias_flujo.unit_type_description || ' [' ||
    instancias_flujo.pack_type_tag || ']'
   ELSE
    instancias_flujo.instance_description
 END "Instancia",
 d.instance_status_id || '-' || d.description "Estado",
 '[' || to_char(instancias_flujo.initial_date, 'DD-MM-YYYY HH24:MI:SS') || ']' "Fecha Inicial",
 '[' || to_char(instancias_flujo.final_date, 'DD-MM-YYYY HH24:MI:SS') || ']' "Fecha Final",
 e.name_ || ' [' || instancias_flujo.external_id || ']' "Código Externo",
 g.action_id || '-' || g.description "Acción",
 h.config_expression_id || '-' || h.object_name || ' [' || h.expression || ']' "Regla Acción",
 WIA.ATTRIBUTE_ID || '-' || ga.display_name Atibuto,
 WIA.VALUE "Valor Atributo"
  FROM (SELECT /*+ leading( a )
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
         c.final_date
          FROM open.wf_data_external a,
               open.wf_unit_type     b,
               open.wf_instance      c,
               open.wf_unit          f
         WHERE a.package_id = 236398848 --,222913554) --998937
           AND b.unit_type_id = a.unit_type_id -- 31657381
           AND c.plan_id = a.plan_id
           AND f.unit_id(+) = c.unit_id) instancias_flujo
  left join open.wf_instance_status d
    on d.instance_status_id = instancias_flujo.status_id
  left join open.ge_entity e
    on e.entity_id = instancias_flujo.entity_id
  left join open.ge_action_module g
    on g.action_id = instancias_flujo.action_id
  left join open.gr_config_expression h
    on h.config_expression_id = g.config_expression_id
  left join open.WF_INSTANCE_ATTRIB WIA
    on WIA.INSTANCE_ID = instancias_flujo.instance_id
  left join OPEN.GE_ATTRIBUTES GA
    on GA.ATTRIBUTE_ID = WIA.ATTRIBUTE_ID
   and 'S' = &ConsultarAtributos
--and GA.ATTRIBUTE_ID(+) = WIA.ATTRIBUTE_ID
--and d.instance_status_id = 4
---and instancias_flujo.unit_id = 836
 START WITH instancias_flujo.instance_id = instancias_flujo.plan_id
CONNECT BY PRIOR instancias_flujo.instance_id = instancias_flujo.parent_id;
