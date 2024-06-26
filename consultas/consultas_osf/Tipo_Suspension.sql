SELECT fecha_registro_actividad, actividad, gi.description, orden
  FROM (SELECT x.register_date fecha_registro_actividad,
               x.activity_id   actividad,
               x.order_id orden               
          FROM open.or_order_activity x
         WHERE x.order_id IN
               (SELECT d.order_id
                  FROM open.or_order_activity d
                 WHERE d.order_activity_id IN
                       (SELECT p.suspen_ord_act_id
                          FROM open.pr_product p
                         WHERE p.product_id = 1087616))
         ORDER BY x.register_date DESC)
         inner join open.ge_items gi on gi.items_id= actividad; 
select l.*, rowid from open.ld_parameter l where l.parameter_id in ('LDC_ACTIVIDAD_SUSPSEGU_CM','LDC_ACTIVIDAD_SUSPSEGU_ACO');   
 --WHERE ROWNUM = 1;

select a.*, rowid from OPEN.PR_PROD_SUSPENSION a where a.product_id=1087616;

SELECT /*+ INDEX (a IDX_MO_MOTIVE_08)*/
--*-- 
 * --A.MOTIVE_ID
  FROM open.MO_MOTIVE          A,
       open.PS_MOTIVE_STATUS   C,
       open.MO_COMPONENT       B,
       open.MO_SUSPENSION_COMP D
 WHERE A.PRODUCT_ID = 1087616
   AND A.TAG_NAME = 'M_GENER_RECONVOL'
   AND A.MOTIVE_STATUS_ID = C.MOTIVE_STATUS_ID
   AND C.IS_FINAL_STATUS = 'N' --GE_BOCONSTANTS.CSBNO
   AND A.MOTIVE_ID = B.MOTIVE_ID
   AND B.COMPONENT_ID = D.COMPONENT_ID
      --AND D.SUSPENSION_TYPE_ID   = 105
   AND ROWNUM = 1;

select a.*
  from open.pr_product a
 inner join open.pr_prod_suspension p
    on p.product_id = a.product_id
   and p.suspension_type_id not in (2)
   and a.product_id = 1087616
 where a.suspen_ord_act_id is not null;

SELECT * --a.suspension_type_id id, a.description description
  FROM open.ge_suspension_type a, open.ps_sustyp_by_protyp b
 WHERE b.product_type_id = 7014
      /*ge_boinstancecontrol.fsbAttributeNewValue('WORK_INSTANCE',
                                                    NULL,
                                                    'PR_PRODUCT',
                                                    'PRODUCT_TYPE_ID')
      and*/
   and a.suspension_type_id = b.suspension_type_id
--   and a.class_suspension = 'A'
/* and not exists
(SELECT 1
         FROM pr_prod_suspension
        WHERE product_id =
              ge_boinstancecontrol.fsbAttributeNewValue('WORK_INSTANCE',
                                                        NULL,
                                                        'PR_PRODUCT',
                                                        'PRODUCT_ID')
          AND suspension_type_id = a.suspension_type_id
          AND active = ge_boconstants.getYes)
  and a.suspension_type_id =
      nvl(:suspension_type_id, a.suspension_type_id)
  and UPPER(a.description) LIKE '%' || UPPER(:description) || '%'*/
