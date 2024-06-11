with base as
 (select distinct ps.package_type_id,
                  ps.description,
                  t.unit_type_id flujo_id,
                  (select pm.motive_type_id codigo
                     from OPEN.PS_PRD_MOTIV_PACKAGE mp,
                          OPEN.PS_PRODUCT_MOTIVE    pm
                    where mp.PACKAGE_TYPE_ID = ps.package_type_id
                      and mp.product_motive_id = pm.product_motive_id) motivo
  
    from OPEN.PS_PACKAGE_UNITTYPE WT,
         OPEN.WF_UNIT_TYPE        T,
         open.ps_package_type     ps
   where wt.package_type_id = ps.package_type_id
     AND WT.UNIT_TYPE_ID = T.UNIT_TYPE_ID
     and ps.package_type_id=100040
     and exists (select null
            from open.mo_packages p
           where p.package_type_id = ps.package_type_id)),
base2 as(
SELECT base.package_type_id,
       base.description desc_tiso,
       base.flujo_id,
       base.motivo,
       'PRINCIPAL' CODIGO, U.*, U.DESCRIPTION UNIDAD, U.NODE_TYPE_ID ORDEN, u.geometry geometria
FROM open.WF_UNIT U
INNER JOIN open.WF_UNIT U2 ON U.PROCESS_ID = U2.UNIT_ID 
INNER JOIN base on base.flujo_id = U2.UNIT_TYPE_ID
),
base3 as(
select t.unit_type_id codigo1,
       t.description desc_1,
       t.parent_id padre_1,
       u.unit_id unit_1,
       u.description desc_un_1,
       u.unit_type_id tipo_un_1,
       u.process_id proces_1,
       u2.unit_id unit_2,
       u2.description desc_un_2,
       u2.process_id proces_2,
       u2.unit_type_id tipo_un_2,
       u2.node_type_id,
       u2.geometry
from open.wf_unit_type t
inner join open.wf_unit u on u.unit_type_id=t.unit_type_id and u.node_type_id=0
inner join open.wf_unit u2 on u2.process_id=u.unit_id
where T.CATEGORY_ID=1),
base4 as(
select distinct base2.package_type_id,
       base2.desc_tiso,
       base2.flujo_id,
       base2.motivo,
       base2.unit_type_id,
       'SECUNDARIO',
       base3.desc_un_2,
       base3.unit_2,
       base3.proces_2,
       base3.desc_1,
       base3.node_type_id,
       base3.geometry,
       to_number(replace(substr(SYS_CONNECT_BY_PATH(codigo1,'/'),1,instr(SYS_CONNECT_BY_PATH(codigo1,'/')||'/','/',2)),'/','')) padre    
from base2, base3
start with codigo1=base2.unit_type_id
 CONNECT BY PRIOR tipo_un_2 =  codigo1     
 ),
 total as(
select b.package_type_id,
       b.desc_tiso,
       b.flujo_id,
       b.motivo,
       b.codigo,
       b.description desc1, 
       b.unit_id codigo2,
       b.description desc2,
       b.process_id,
       t.description desc3,
       b.unidad,
       b.orden,
       b.geometria
from base2  b    
left join open.wf_unit_type t on t.unit_type_id=b.unit_type_id
union all
select distinct base4.package_type_id,
       base4.desc_tiso,
       base4.flujo_id,
       base4.motivo,
       'SECUNDARIO',
       base4.desc_un_2,
       base4.unit_2 codigo2,
       base4.desc_un_2,
       base4.proces_2,
       base4.desc_1,
       base4.desc_1,
       base4.node_type_id,
       base4.geometry
from base4,open.wf_unit u, open.wf_unit u2, open.PS_PACKAGE_UNITTYPE p
where u.unit_type_id = base4.padre
     and u.process_id = u2.unit_id
     and p.unit_type_id=u2.unit_type_id 
     and base4.package_type_id=p.package_type_id
union all
SELECT b.package_type_id,
       b.description desc_tiso,
       b.flujo_id,
       b.motivo,
       'SUBFLUJO', 
       A.Description,
       a.unit_id codigo2,
       A.Description,
       a.process_id,
       b.description,
       U.DESCRIPTION UNIDAD, 
       U.NODE_TYPE_ID ORDEN,
       u.geometry geometria
FROM OPEN.WF_UNIT U
INNER JOIN OPEN.WF_UNIT U2 ON U.PROCESS_ID = U2.UNIT_ID --AND U2.UNIT_TYPE_ID in (select flujo_id from flujo )
INNER JOIN BASE B ON FLUJO_ID=U2.UNIT_TYPE_ID
INNER JOIN OPEN.WF_UNIT_TYPE UT ON UT.UNIT_TYPE_ID=U.UNIT_TYPE_ID
INNER JOIN OPEN.ps_process_comptype C on c.stage_tag_name=UT.TAG_NAME
INNER JOIN OPEN.WF_UNIT B ON B.UNIT_TYPE_ID=C.UNIT_TYPE_ID
INNER JOIN OPEN.WF_UNIT A ON B.UNIT_ID=A.PROCESS_ID
WHERE C.MOTIVE_TYPE_ID =B.MOTIVO--IN (select codigo from tipomotivo) 
)
select total.*,
       u.action_id,
       action.code,
       action.object_name,
       u.pre_expression_id,
       pre.code,
       pre.object_name,
       u.pos_expression_id,
       post.code,
       post.object_name,
       att.attribute_id,
       (select ga.name_attribute from open.ge_attributes ga where ga.attribute_id=att.attribute_id) name_,
       att.statement_id,
       (select s.statement from ge_statement s where s.statement_id=att.statement_id)
from total
left join wf_unit u on u.unit_id=total.codigo2
left join wf_unit_attribute att on att.unit_id=u.unit_id and att.attribute_id not in (400)
left join ge_action_module mm on mm.action_id=u.action_id
left join gr_config_expression action on action.config_expression_id=mm.config_expression_id or (mm.action_id=100 and action.object_name='IN_PACK_DISCCT123E33002')
left join gr_config_expression pre on pre.config_expression_id=u.pre_expression_id
left join gr_config_expression post on post.config_expression_id=u.pos_expression_id



