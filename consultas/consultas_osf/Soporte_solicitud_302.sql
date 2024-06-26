select s.sesunuse,
       s.sesususc,
       s.sesuserv,
       s.sesufein,
       s.sesufere,
       s.sesucate,
       s.sesusuca,
       s.sesuesco || ' - ' ||
       (select e.escodesc from open.estacort e where e.escocodi = s.sesuesco)
  from open.servsusc s
 where s.sesususc = 67193756
   and s.sesuserv = 7014;
select * from open.suscripc s where s.susccodi = 67193756;
select *
  from open.suscripc s
 where s.suscclie = (select s1.suscclie
                       from open.suscripc s1
                      where s1.susccodi = 67193756);

select *
  from open.ab_address a
 where a.address_id in (217173, 4253125, 4253107);

select * from open.ge_subscriber a where a.subscriber_id = 1535344;
select *
  from open.ps_package_type p
 where upper(p.description) like '%INSOL%';
select *
  from open.mo_packages mp
 where mp.subscriber_id = 1535344
   and mp.package_type_id = 302;
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
 e.name_ || ' [' || instancias_flujo.external_id || ']' "C�digo Externo",
 g.action_id || '-' || g.description "Acci�n",
 h.config_expression_id || '-' || h.object_name || ' [' || h.expression || ']' "Regla Acci�n"
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
         WHERE a.package_id = 180423604 --998937
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
 START WITH instancias_flujo.instance_id = instancias_flujo.plan_id
CONNECT BY PRIOR instancias_flujo.instance_id = instancias_flujo.parent_id;
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
 e.name_ || ' [' || instancias_flujo.external_id || ']' "C�digo Externo",
 g.action_id || '-' || g.description "Acci�n",
 h.config_expression_id || '-' || h.object_name || ' [' || h.expression || ']' "Regla Acci�n"
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
         WHERE a.package_id = 180333494 --998937
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
 START WITH instancias_flujo.instance_id = instancias_flujo.plan_id
CONNECT BY PRIOR instancias_flujo.instance_id = instancias_flujo.parent_id;
SELECT *
  FROM open.MO_DATA_INSOLVENCY
 WHERE MOTIVE_ID in (70413664, 70483657);
select * from open.ps_pack_type_param j where j.package_type_id = 302;
SELECT /*+ index( insolvSusc IX_SUSCRIPC017 ) */
 INSOLVSUSC.*
  FROM /*+ GC_BCInsolvency.frcSubscriptInsolv */ (SELECT /*+ index( suscripc PK_SUSCRIPC ) */
        SUSCCLIE
         FROM open.SUSCRIPC
        WHERE SUSCCODI = 1504229 --1507635
       ) MAINSUSC,
       open.SUSCRIPC INSOLVSUSC
 WHERE INSOLVSUSC.SUSCTISU = 42
   AND INSOLVSUSC.SUSCCECO = '-'
   AND INSOLVSUSC.SUSCCLIE = MAINSUSC.SUSCCLIE
   AND ROWNUM = 1
union all
SELECT /*+ index( insolvSusc IX_SUSCRIPC017 ) */
 INSOLVSUSC.*
  FROM /*+ GC_BCInsolvency.frcSubscriptInsolv */
       (SELECT /*+ index( suscripc PK_SUSCRIPC ) */
         SUSCCLIE
          FROM open.SUSCRIPC
         WHERE SUSCCODI = 1507635) MAINSUSC,
       open.SUSCRIPC INSOLVSUSC
 WHERE INSOLVSUSC.SUSCTISU = 42
   AND INSOLVSUSC.SUSCCECO = '-'
   AND INSOLVSUSC.SUSCCLIE = MAINSUSC.SUSCCLIE
   AND ROWNUM = 1;
