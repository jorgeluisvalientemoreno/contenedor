SELECT  /*+ leading( a )
            index( a IDX_WF_INSTANCE_08 )
            index( b PK_WF_INSTANCE_STATUS )
            index( c PK_GE_ENTITY )
            index( d PK_WF_UNIT )
            index( e PK_GE_ACTION_MODULE )
            index( f PK_GR_CONFIG_EXPRESSION )
            use_nl( a b )
            use_nl( a c )
            use_nl( a d )
            use_nl( d e )
            use_nl( e f )
        */
        level "Nivel",
        lpad( ' ', decode( level, 1, 0, level - 1 ) * 8, ' ' ) || a.instance_id || '-' || a.description "Instancia",
        b.instance_status_id || '-' || b.description "Estado",
        a.initial_date "Fecha Inicial",
        a.final_date "Fecha Final",
        c.name_ || ' [' || a.external_id || ']' "C�digo Externo",
        e.action_id || '-' || e.description "Acci�n",
        f.config_expression_id || '-' || f.object_name || ' [' || f.expression || ']' "Regla Acci�n"
FROM    wf_instance a,
        wf_instance_status b,
        ge_entity c,
        wf_unit d,
        ge_action_module e,
        gr_config_expression f
WHERE   b.instance_status_id = a.status_id
AND     c.entity_id(+) = a.entity_id
AND     d.unit_id(+) = a.unit_id
AND     e.action_id(+) = d.action_id
AND     f.config_expression_id(+) = e.config_expression_id
START WITH ( a.external_id = 15743157 AND a.entity_id = 17 AND a.parent_id IS NULL )
CONNECT BY PRIOR a.instance_id = a.parent_id;



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
 h.config_expression_id || '-' || h.object_name || ' [' || h.expression || ']' "Regla Acción"
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
         WHERE a.package_id = 204314786 --998937
           AND b.unit_type_id = a.unit_type_id -- 31657381
           AND c.plan_id = a.plan_id
           AND f.unit_id(+) = c.unit_id) instancias_flujo,
       open.wf_instance_status d,
       open.ge_entity e,
       open.ge_action_module g,
       open.gr_config_expression h
 WHERE d.instance_status_id = instancias_flujo.status_id
   AND e.entity_id(+) = instancias_flujo.entity_id
   AND g.action_id(+) = instancias_flujo.action_id
   AND h.config_expression_id(+) = g.config_expression_id
--and d.instance_status_id = 4
 START WITH instancias_flujo.instance_id = instancias_flujo.plan_id
CONNECT BY PRIOR instancias_flujo.instance_id = instancias_flujo.parent_id;
