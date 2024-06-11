--atributos componententes

select *
from open.PS_MOTI_COMP_ATTRIBS
where prod_motive_comp_id in (10351,10352); --se trae de PS_PROD_MOTIVE_COMP
--componente del motivo de una solicitud
select *
from OPEN.PS_PROD_MOTIVE_COMP
WHERE PRODUCT_MOTIVE_ID IN (100289)--se trae de PS_PRD_MOTIV_PACKAGE

select *
from OPEN.PS_MOTI_COMPON_EVENT
where prod_motive_comp_id in (10351,10352); --se trae de PS_MOTI_COMPON_EVENT

--PRE COMPONENTES.
SELECT *
FROM open.PS_WHEN_MOTI_COMPON
WHERE MOTI_COMPON_EVENT_ID IN (10115,10116);--se trae de PS_MOTI_COMPON_EVENT

--tipo de motivo motivo por motivo de solicitud
SELECT *
FROM OPEN.PS_PRODUCT_MOTIVE
WHERE PRODUCT_MOTIVE_ID IN (100290) --se trae de PS_PRD_MOTIV_PACKAGE
;
--flujo x tipo de paquete
select p.package_type_id, p.description, p.tag_name, t.unit_type_id, t.description, t.parent_id,  p.action_regis_exec,
       m.description,m.module_id,  c.object_name, c.code,
       ca.organizat_area_id,
       open.dage_organizat_area.fsbgetname_(ca.organizat_area_id, null)
from open.ps_package_type p 
left join open.LDC_REP_AREA_TI_PA_CA ca on ca.package_type_id=p.package_type_id
left join OPEN.PS_PACKAGE_UNITTYPE WT on p.package_type_id=wt.package_type_id
left join OPEN.WF_UNIT_TYPE T on WT.UNIT_TYPE_ID=T.UNIT_TYPE_ID
left join open.ge_action_module m on m.action_id=p.action_regis_exec
left join open.gr_config_expression c on c.config_expression_id=m.config_expression_id
where p.package_type_id in (100260);

select p.package_type_id,
       p.description,
       p.tag_name,
       t.parent_id,
       t.description,
       p.action_regis_exec,
       m.description,
       c.object_name,
       c.code,
       pre.insert_before_expression pre_solicitud,
       presol.code,
       presol.object_name,
       pre.insert_after_expression post_sol,
       possol.code,
       possol.object_name,
       mot.product_motive_id,
       wh.config_expression_id,
       motivo.code,
       motivo.object_name,
       wh.executing_time
  from open.ps_package_type p
  left join open.LDC_REP_AREA_TI_PA_CA ca
    on ca.package_type_id = p.package_type_id
  left join OPEN.PS_PACKAGE_UNITTYPE WT
    on p.package_type_id = wt.package_type_id
  left join OPEN.WF_UNIT_TYPE T
    on WT.UNIT_TYPE_ID = T.UNIT_TYPE_ID
  left join open.ge_action_module m
    on m.action_id = p.action_regis_exec
  left join open.gr_config_expression c
    on c.config_expression_id = m.config_expression_id
  left join open.PS_CNF_INSTANCE pre
    on pre.package_type = p.package_type_id
  left join OPEN.PS_PRD_MOTIV_PACKAGE mot
    on mot.PACKAGE_TYPE_ID = p.package_type_id
  left join open.PS_PROD_MOTI_EVENTS even
    on even.product_motive_id = mot.product_motive_id
  left join open.PS_WHEN_MOTIVE wh
    on wh.prod_moti_events_id = even.prod_moti_events_id
  left join open.gr_config_expression presol
    on presol.config_expression_id = pre.insert_before_expression
  left join open.gr_config_expression possol
    on possol.config_expression_id = pre.insert_after_expression
  left join open.gr_config_expression motivo
    on motivo.config_expression_id = wh.config_expression_id
 where p.package_type_id in (100260);

select *
from open.sa_tab
where process_name='P_SOLICITUD_DE_CERTIFICADO_DE_PAZ_Y_SALVO_272'

---

select p.package_type_id,
       p.description,
       p.tag_name,
       t.parent_id,
       t.description,
       p.action_regis_exec,
       m.description,
       c.object_name,
       c.code,
       pre.insert_before_expression pre_solicitud,
       presol.code,
       presol.object_name,
       pre.insert_after_expression post_sol,
       possol.code,
       possol.object_name,
       mot.product_motive_id,
       wh.config_expression_id,
       motivo.code,
       motivo.object_name,
       wh.executing_time
  from open.ps_package_type p
  left join open.LDC_REP_AREA_TI_PA_CA ca
    on ca.package_type_id = p.package_type_id
  left join OPEN.PS_PACKAGE_UNITTYPE WT
    on p.package_type_id = wt.package_type_id
  left join OPEN.WF_UNIT_TYPE T
    on WT.UNIT_TYPE_ID = T.UNIT_TYPE_ID
  left join open.ge_action_module m
    on m.action_id = p.action_regis_exec
  left join open.gr_config_expression c
    on c.config_expression_id = m.config_expression_id
  left join open.PS_CNF_INSTANCE pre
    on pre.package_type = p.package_type_id
  left join OPEN.PS_PRD_MOTIV_PACKAGE mot
    on mot.PACKAGE_TYPE_ID = p.package_type_id
  left join open.PS_PROD_MOTI_EVENTS even
    on even.product_motive_id = mot.product_motive_id
  left join open.PS_WHEN_MOTIVE wh
    on wh.prod_moti_events_id = even.prod_moti_events_id
  left join open.gr_config_expression presol
    on presol.config_expression_id = pre.insert_before_expression
  left join open.gr_config_expression possol
    on possol.config_expression_id = pre.insert_after_expression
  left join open.gr_config_expression motivo
    on motivo.config_expression_id = wh.config_expression_id
 where p.package_type_id in (100040);

  
  
---acciones

                      

---unidades asociadas al flujo
select *
from open.wf_unit
where process_id=102808;

--motivo x tipo de solictud
select *
from OPEN.PS_PRD_MOTIV_PACKAGE
where PACKAGE_TYPE_ID in (100295
);
--atributos x tramite
SELECT *
FROM OPEN.PS_PACKAGE_ATTRIBS
WHERE PACKAGE_TYPE_ID=271
AND UPPER(DISPLAY_NAME)='CONTRATO'
--atributos x motivo;
select *
from open.PS_CNF_ATTRIBUTE
where product_motive=100289;--se saca de PS_PRD_MOTIV_PACKAGE

--saca el plan id para consultar flujos
select *
from open.WF_DATA_EXTERNAL
;

select m.description, c.code
from open.ps_package_type t
inner join open.ge_action_module m on m.action_id=t.action_regis_exec
inner open.gr_config_expression c on c.config_expression_id=t.
where package_type_id in (275)
----PRE MOTIVO
/*SELECT *
FROM open.GI_FRAME
where frame_id=10351
WHERE BEFORE_EXPRESSION_ID=121281062;*/

select *
from open.PS_WHEN_MOTIVE
where prod_moti_events_id=29;

select *
from open.PS_PROD_MOTI_EVENTS
where product_motive_id=100113;
---PRE SOLICITUD
SELECT *
FROM 
open.PS_CNF_INSTANCE
WHERE PACKAGE_TYPE=100294;
--
select *
from open.GI_COMPOSITION

select *
from open.gr_config_expression
where config_expression_id in (121294923);





--validaciones de tramites en attributos
SELECT /*+ leading(a) INDEX (A PK_PS_PACKAGE_TYPE_PARAM) */
           PACKAGE_TYPE_ID,  A.ATTRIBUTE_ID, B.VALID_EXPRESSION, A.CLASS, B.DEFAULT_VALUE, C.OBJECT_NAME, C.CODE, a.description, PARAMETER_ORDER
        FROM open.PS_PACK_TYPE_PARAM A, open.GE_ATTRIBUTES B, OPEN.GR_CONFIG_EXPRESSION C
        WHERE A.PACKAGE_TYPE_ID   in ( 59)
        AND /*A.VALUE != 'N'
        AND*/ A.ATTRIBUTE_ID = B.ATTRIBUTE_ID
        --AND B.ATTRIBUTE_CLASS_ID + 0 = nvl(22, B.ATTRIBUTE_CLASS_ID)
        AND B.VALID_EXPRESSION=C.CONFIG_EXPRESSION_ID
        AND B.VALID_EXPRESSION IS NOT NULL
        ORDER BY PARAMETER_ORDER;
select * 
from PS_PACK_TYPE_VALID;

GEGE_EXERULVAL_CT69E121389828
 
      
      
SELECT /*PACKAGE_ATTRIBS_ID,
               TAG_NAME,
               HEADER_TAG_XML,
               INCLUDED_XML,
               INIT_EXPRESSION_ID,
               VALID_EXPRESSION_ID,
               REQUIRED,
               GROUP_ATTRIBUTE_TYPE,
               ENTITY_ATTRIBUTE_ID,
               MIRROR_ENTI_ATTRIB,
               INSTANCE_AMOUNT,
               PROCESS_WITH_XML,
               STATEMENT_ID*/
               *
          FROM PS_PACKAGE_ATTRIBS
         WHERE PACKAGE_TYPE_ID  IN (100101)
           AND ACTIVE = 'Y'
           AND PARENT_ATTRIB_ID IS NULL
           AND MODULE IN ('M','B')
      ORDER BY PROCESS_SEQUENCE;
      
      SELECT PS_PRODUCT_MOTIVE.TAG_NAME,
               2013, --NUMOTIVEOBJECT,
               PS_PRD_MOTIV_PACKAGE.PRODUCT_MOTIVE_ID,
               null,
               PS_PRD_MOTIV_PACKAGE.MIN_MOTIVE_COMP,
               PS_PRD_MOTIV_PACKAGE.MAX_MOTIVE_COMP,
               'Y',
               PS_PRODUCT_MOTIVE.USE_UNCOMPOSITION,
               null
          FROM PS_PRD_MOTIV_PACKAGE, PS_PRODUCT_MOTIVE
         WHERE PS_PRODUCT_MOTIVE.PRODUCT_MOTIVE_ID = PS_PRD_MOTIV_PACKAGE.PRODUCT_MOTIVE_ID
           AND PS_PRD_MOTIV_PACKAGE.PACKAGE_TYPE_ID  IN  (100321,100156, 100014,100153)
           AND PS_PRD_MOTIV_PACKAGE.PRODUCT_TYPE_ID= NVL(null,PS_PRD_MOTIV_PACKAGE.PRODUCT_TYPE_ID)
      ORDER BY PS_PRD_MOTIV_PACKAGE.SEQUENCE_NUMBER;
      
      
          SELECT PRODUCT_MOTIVE_ID,
               PROD_MOTI_ATTRIB_ID,
               TAG_NAME,
               HEADER_TAG_XML,
               INCLUDED_XML,
               INIT_EXPRESSION_ID,
               VALID_EXPRESSION_ID,
               REQUIRED,
               GROUP_ATTRIBUTE_TYPE,
               ENTITY_ATTRIBUTE_ID,
               MIRROR_ENTI_ATTRIB,
               INSTANCE_AMOUNT,
               PROCESS_WITH_XML
          FROM PS_PROD_MOTI_ATTRIB
         WHERE PRODUCT_MOTIVE_ID IN (100304,100130)
           AND ACTIVE = 'Y'
           AND PARENT_ATTRIB_ID IS NULL
           AND MODULE IN ('M', 'B')
       ORDER BY PROCESS_SEQUENCE;
       
        SELECT TAG_NAME,
               2014 NUCOMPONENTOBJECT,
               PROD_MOTIVE_COMP_ID,
               ELEMENT_CATEGORY_ID,
               MIN_COMPONENTS,
               MAX_COMPONENTS,
               PROCESS_WITH_XML,
               NULL,
               PARENT_COMP
          FROM PS_PROD_MOTIVE_COMP
         WHERE PRODUCT_MOTIVE_ID = 100130
           AND ACTIVE = 'Y'
           AND PARENT_COMP IS NULL;
      

        SELECT TAG_NAME,
               2012 NUPACKAGEOBJECT,
               PACKAGE_TYPE_ID,
               NULL,
               1,
               1,
               'Y',
               NULL,
               NULL
          FROM PS_PACKAGE_TYPE
         WHERE PACKAGE_TYPE_ID = 100321;
         
     SELECT *
     FROM PS_PRODUCT_MOTIVE
     WHERE PRODUCT_MOTIVE_ID=100130
  
           
          
      
  SELECT MOTI_COMP_ATTRIBS_ID,
               TAG_NAME,
               HEADER_TAG_XML,
               INCLUDED_XML,
               INIT_EXPRESSION_ID,
               VALID_EXPRESSION_ID,
               REQUIRED,
               GROUP_ATTRIBUTE_TYPE,
               ENTITY_ATTRIBUTE_ID,
               MIRROR_ENTI_ATTRIB,
               INSTANCE_AMOUNT,
               PROCESS_WITH_XML
          FROM PS_MOTI_COMP_ATTRIBS
         WHERE PROD_MOTIVE_COMP_ID = 10346
           AND ACTIVE = 'Y'
           AND PARENT_ATTRIB_ID IS NULL
           AND MODULE IN ('M','B')
      ORDER BY PROCESS_SEQUENCE;
      
      -------------------------------------------
      
        
SELECT *
FROM OPEN.PS_PACKAGE_ATTRIBS
WHERE PACKAGE_TYPE_ID=271;

SELECT *
FROM OPEN.VWGI_CONFIG
WHERE FRAME_ID=1860;
SELECT *
FROM OPEN.GI_COMP_FRAME_ATTRIB C
WHERE C.FRAME_ID=1856;
SELECT *
FROM OPEN.GI_FRAME C
WHERE C.FRAME_ID=1856;


SELECT *
FROM OPEN.GI_FRAME C
WHERE description='FRAME-PAQUETE-1068828'


