WITH base as
 (select distinct ps.package_type_id,
                  ps.description,
                  t.unit_type_id flujo_id,
                  t.parent_id carpeta,
                  t.display,
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
 and ps.package_type_id=&solicitud
     and exists (select null
            from open.mo_packages p
           where p.package_type_id = ps.package_type_id))
, base2 as(
SELECT base.package_type_id,
       base.description desc_tiso,
       base.flujo_id,
       base.motivo,
       base.carpeta,
       base.display,
       'PRINCIPAL' CODIGO, U.*, U.DESCRIPTION UNIDAD, U.NODE_TYPE_ID ORDEN, u.geometry geometria
FROM open.WF_UNIT U
INNER JOIN open.WF_UNIT U2 ON U.PROCESS_ID = U2.UNIT_ID 
INNER JOIN base on base.flujo_id = U2.UNIT_TYPE_ID
where ((u.unit_type_id not in (252, 283) and upper(&iniciofin)='N') or upper(&iniciofin)='S')
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
inner join open.wf_unit u2 on u2.process_id=u.unit_id and  ((u2.unit_type_id not in (252, 283) and upper(&iniciofin)='N') or upper(&iniciofin)='S')
where T.CATEGORY_ID=1),
base4 as(
select distinct base2.package_type_id,
       base2.desc_tiso,
       base2.flujo_id,
       base2.motivo,
       base2.unit_type_id,
       base2.carpeta,
       base2.display,
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
       b.carpeta,
       b.display,
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
       base4.carpeta,
       base4.display,
       'SECUNDARIO',
       base4.desc_un_2 desc1,
       base4.unit_2 codigo2,
       base4.desc_un_2 desc2,
       base4.proces_2,
       base4.desc_1 desc3,
       base4.desc_1,
       base4.node_type_id,
       base4.geometry
from base4,open.wf_unit u, open.wf_unit u2, open.PS_PACKAGE_UNITTYPE p
where u.unit_type_id = base4.padre
     and u.process_id = u2.unit_id
     and p.unit_type_id=u2.unit_type_id 
     and base4.package_type_id=p.package_type_id
     AND (base4.package_type_id in (271,100229, 100101,323) and base4.proces_2 not in (6)
   or base4.package_type_id not in (271,100229, 100101,323)
   )
union all
SELECT b.package_type_id,
       b.description desc_tiso,
       b.flujo_id,
       b.motivo,
       b.carpeta,
       b.display,
       'SUBFLUJO' codigo, 
       A.Description desc1,
       a.unit_id codigo2,
       A.Description desc_un_2,
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
INNER JOIN OPEN.WF_UNIT A ON B.UNIT_ID=A.PROCESS_ID and ((a.unit_type_id not in (252, 283) and upper(&iniciofin)='N') or upper(&iniciofin)='S')
WHERE C.MOTIVE_TYPE_ID =B.MOTIVO--IN (select codigo from tipomotivo) 
 and  (b.package_type_id in (271,100229, 100101,323) and u.unit_type_id not in (15)
   or b.package_type_id not in (271,100229, 100101,323) 
   )
 ),
ACCIONES AS(
select total.*,
       u.action_id regla,
       u.pre_expression_id pre,
       u.pos_expression_id pos,
       u.unit_type_id tipo
from total
left join open.wf_unit u on u.unit_id=total.codigo2)
,TRAMITE AS(
select package_type_id, 'ATRIB_PACKAGE: '||display_name display_name,c.object_name
from open.ps_package_attribs a
inner join open.gr_config_expression c on c.config_expression_id=a.init_expression_id
where package_type_id=&solicitud
  and (init_expression_id is not null )
union all
select package_type_id, 'ATRIB_PACKAGE: '||display_name,c.object_name
from open.ps_package_attribs a
inner join open.gr_config_expression c on c.config_expression_id=a.valid_expression_id
where package_type_id=&solicitud
  and (a.valid_expression_id is not null)
-------  
union all
select package_type_id, 'ATRIB_MOTIVE: '||display_name display_name,c.object_name
from OPEN.PS_PROD_MOTI_ATTRIB  mta
inner join open.gr_config_expression c on c.config_expression_id=mta.init_expression_id
inner join open.PS_PRD_MOTIV_PACKAGE p on p.product_motive_id=mta.product_motive_id and package_type_id=&solicitud
where init_expression_id is not null 
union all
select package_type_id, 'ATRIB_MOTIVE: '||display_name display_name,c.object_name
from OPEN.PS_PROD_MOTI_ATTRIB  mta
inner join open.gr_config_expression c on c.config_expression_id=mta.valid_expression_id
inner join open.PS_PRD_MOTIV_PACKAGE p on p.product_motive_id=mta.product_motive_id and package_type_id=&solicitud
where package_type_id=&solicitud
  and (mta.valid_expression_id is not null)  
---
union all
select pack.package_type_id, 'ATRI_COMP: '||comp.display_name display_name,object_name
from open.PS_PRD_MOTIV_PACKAGE pack --
inner join open.PS_PROD_MOTIVE_COMP motcomp  on pack.product_motive_id =motcomp.product_motive_id
inner join OPEN.PS_MOTI_COMP_ATTRIBS comp on motcomp.prod_motive_comp_id=comp.prod_motive_comp_id
inner join open.gr_config_expression c on c.config_expression_id=comp.init_expression_id
where pack.package_type_id=&solicitud 
UNION ALL
 select pack.package_type_id, 'ATRI_COMP: '||comp.display_name,object_name
from open.PS_PRD_MOTIV_PACKAGE pack --
inner join open.PS_PROD_MOTIVE_COMP motcomp  on pack.product_motive_id =motcomp.product_motive_id
inner join OPEN.PS_MOTI_COMP_ATTRIBS comp on motcomp.prod_motive_comp_id=comp.prod_motive_comp_id
inner join open.gr_config_expression c on c.config_expression_id=comp.valid_expression_id
where pack.package_type_id=&solicitud 
---
union all
select p.package_type_id, 'ACCION_SOL', c.object_name
from open.ps_package_type p 
left join open.ge_action_module m on m.action_id=p.action_regis_exec
left join open.gr_config_expression c on c.config_expression_id=m.config_expression_id
where p.package_type_id in (&solicitud)
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
 where p.package_type_id in (&solicitud)
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
 where p.package_type_id in (&solicitud)
 union all
 select package_type_id, 'PRE-MOTIVO', c.object_name
from OPEN.PS_PRD_MOTIV_PACKAGE mot, open.PS_PROD_MOTI_EVENTS e, open.PS_WHEN_MOTIVE w, open.gr_config_expression c 
where PACKAGE_TYPE_ID in (&solicitud)
 and mot.product_motive_id=e.product_motive_id
 and w.prod_moti_events_id=e.prod_moti_events_id
 and executing_time='B'
 and c.config_expression_id=w.config_expression_id
 union all
 select package_type_id, 'POS-MOTIVO', c.object_name
from OPEN.PS_PRD_MOTIV_PACKAGE mot, open.PS_PROD_MOTI_EVENTS e, open.PS_WHEN_MOTIVE w, open.gr_config_expression c 
where PACKAGE_TYPE_ID in (&solicitud)
 and mot.product_motive_id=e.product_motive_id
 and w.prod_moti_events_id=e.prod_moti_events_id
 and executing_time='A'
 and c.config_expression_id=w.config_expression_id

UNION ALL 
SELECT PACKAGE_TYPE_ID, 'PRE_COMPONENTE', C.OBJECT_NAME
FROM OPEN.PS_PROD_MOTIVE_COMP CO
INNER JOIN OPEN.PS_PRD_MOTIV_PACKAGE mot ON MOT.PRODUCT_MOTIVE_ID=CO.PRODUCT_MOTIVE_ID AND MOT.PACKAGE_TYPE_ID=&solicitud
INNER JOIN open.PS_MOTI_COMPON_EVENT CE ON CE.prod_motive_comp_id=CO.PROD_MOTIVE_COMP_ID
INNER JOIN open.PS_WHEN_MOTI_COMPON WH ON WH.MOTI_COMPON_EVENT_ID=CE.MOTI_COMPON_EVENT_ID AND WH.EXECUTING_TIME='B'
INNER JOIN OPEN.GR_CONFIG_EXPRESSION C ON C.CONFIG_EXPRESSION_ID=WH.CONFIG_EXPRESSION_ID
UNION ALL
SELECT PACKAGE_TYPE_ID, 'POST_COMPONENTE', C.OBJECT_NAME
FROM OPEN.PS_PROD_MOTIVE_COMP CO
INNER JOIN OPEN.PS_PRD_MOTIV_PACKAGE mot ON MOT.PRODUCT_MOTIVE_ID=CO.PRODUCT_MOTIVE_ID AND MOT.PACKAGE_TYPE_ID=&solicitud
INNER JOIN open.PS_MOTI_COMPON_EVENT CE ON CE.prod_motive_comp_id=CO.PROD_MOTIVE_COMP_ID
INNER JOIN open.PS_WHEN_MOTI_COMPON WH ON WH.MOTI_COMPON_EVENT_ID=CE.MOTI_COMPON_EVENT_ID AND WH.EXECUTING_TIME='AF'
INNER JOIN OPEN.GR_CONFIG_EXPRESSION C ON C.CONFIG_EXPRESSION_ID=WH.CONFIG_EXPRESSION_ID
UNION ALL
SELECT package_type_id,
       'FLUJO: '|| ACCIONES.DESC1,
       CC.OBJECT_NAME
FROM ACCIONES
INNER JOIN OPEN.GE_ACTION_MODULE M ON M.ACTION_ID=ACCIONES.REGLA
INNER JOIN OPEN.GR_CONFIG_EXPRESSION CC ON CC.CONFIG_EXPRESSION_ID=M.CONFIG_EXPRESSION_ID
UNION ALL
SELECT package_type_id,
       'FLUJO: '|| ACCIONES.DESC1 display_name,
       CC.OBJECT_NAME
FROM ACCIONES
INNER JOIN OPEN.GR_CONFIG_EXPRESSION CC ON CC.CONFIG_EXPRESSION_ID=ACCIONES.pre
UNION ALL
SELECT package_type_id,
       'FLUJO: '|| ACCIONES.DESC1 display_name,
       CC.OBJECT_NAME
FROM ACCIONES
INNER JOIN OPEN.GR_CONFIG_EXPRESSION CC ON CC.CONFIG_EXPRESSION_ID=ACCIONES.POS
UNION ALL
SELECT PACKAGE_TYPE_ID,'REGLA1-'||M.ITEMS_ID display_name,CC.OBJECT_NAME
FROM ACCIONES
INNER JOIN OPEN.OR_ACT_BY_TASK_MOD M ON M.TASK_CODE=ACCIONES.TIPO
INNER JOIN OPEN.GR_CONFIG_EXPRESSION CC ON CC.CONFIG_EXPRESSION_ID=M.CONFIG_EXPRESSION_ID
UNION ALL
select mp.package_type_id,
       'REGLA2: '||I.ITEMS_ID display_name,
       C.OBJECT_NAME
       
from OPEN.PS_PRD_MOTIV_PACKAGE mp
inner join OPEN.PS_PRODUCT_MOTIVE pm on pm.product_motive_id=mp.product_motive_id
inner join open.or_act_by_req_data r on r.motive_type_id=pm.motive_type_id and r.active!='N'
inner join open.ge_items i on i.items_id=r.item_id
inner join open.gr_config_expression c ON c.config_expression_id=r.config_expression_id
where PACKAGE_TYPE_ID in (&solicitud )
  and package_type_id  not in (100229)
union all
SELECT /*+ leading(a) INDEX (A PK_PS_PACKAGE_TYPE_PARAM) */
           PACKAGE_TYPE_ID,  'ATRIBUTO: '||A.ATTRIBUTE_ID, C.OBJECT_NAME
        FROM open.PS_PACK_TYPE_PARAM A, open.GE_ATTRIBUTES B, OPEN.GR_CONFIG_EXPRESSION C
        WHERE A.PACKAGE_TYPE_ID   in ( &solicitud)
        AND A.VALUE != 'N'
        AND A.ATTRIBUTE_ID = B.ATTRIBUTE_ID
        AND B.ATTRIBUTE_CLASS_ID + 0 = nvl(22, B.ATTRIBUTE_CLASS_ID)
        AND B.VALID_EXPRESSION=C.CONFIG_EXPRESSION_ID
        AND B.VALID_EXPRESSION IS NOT NULL)
,objetos_tramite as(
SELECT DISTINCT tramite.*,   D.REFERENCED_NAME, D.REFERENCED_TYPE
FROM TRAMITE
INNER JOIN DBA_DEPENDENCIES D ON D.OWNER='OPEN' AND D.name=TRAMITE.OBJECT_NAME AND D.REFERENCED_OWNER='OPEN' 
--WHERE EXISTS(SELECT NULL FROM open.ldc_objepers OP WHERE OP.NOMBRE=D.REFERENCED_NAME and upper(&soloPerson)='S') or upper(&soloPerson)='N'
  ---and d.referenced_name=upper('fnuGetSaleValByForm')
  )


, DEPEN AS(
SELECT  D.*
FROM DBA_DEPENDENCIES D
WHERE /*(EXISTS(SELECT NULL FROM LDC_OBJEPERS S WHERE UPPER(S.NOMBRE)=D.REFERENCED_NAME AND D.OWNER='OPEN' AND upper(&soloPerson)='S')  or upper(&soloPerson)='N')
  AND*/ NOT EXISTS(SELECT NULL FROM open.GR_CONFIG_EXPRESSION CS WHERE CS.OBJECT_NAME=D.name)
)
, total_objetos as(
select *
from objetos_tramite
--where OBJETOS_TRAMITE.REFERENCED_NAME=upper('fnuGetSaleValByForm')
/*union all 
select d.REFERENCED_NAME,d.TYPE
from DEPEN d , objetos_tramite
--where OBJETOS_TRAMITE.REFERENCED_NAME=upper('fnuGetSaleValByForm')
START WITH d.name=OBJETOS_TRAMITE.REFERENCED_NAME 
CONNECT BY NOCYCLE  PRIOR   D.REFERENCED_NAME=d.name */
)
select * --distinct display_name,  referenced_name, referenced_type
from total_objetos;
