select a.*, rowid from OPEN.PR_PROD_SUSPENSION a where a.product_id=1087616;
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
