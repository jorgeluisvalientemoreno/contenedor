select *
  from pr_prod_suspension p
 where p.suspension_type_id = 2
   and p.active = 'Y'
   and p.register_date > sysdate - 200;

select *
  from pr_prod_suspension p
 where p.suspension_type_id <> 2
   and p.active = 'Y'
   and p.register_date > sysdate - 200;

select *
  from suspcone
 WHERE SUSPCONE.SUCONUSE = &inuProductId
 order by SUSPCONE.SUCOFEOR desc;

select * from SERVSUSC WHERE SESUNUSE = &inuProductId;

select *
  from PR_PROD_SUSPENSION
 WHERE PRODUCT_ID = &inuProductId
   AND ACTIVE = 'Y';

select * from PR_PRODUCT WHERE PRODUCT_ID = &inuProductId;

select * from PR_COMPONENT WHERE PRODUCT_ID = &inuProductId;

select * from COMPSESU where cmsssesu = &inuProductId;

select *
  from PR_COMP_SUSPENSION
 WHERE COMP_SUSPENSION_ID in (SELECT COMP_SUSPENSION_ID
                                FROM PR_COMPONENT C, PR_COMP_SUSPENSION CS
                               WHERE PRODUCT_ID = &inuProductId
                                 AND C.COMPONENT_ID = CS.COMPONENT_ID
                                 AND ACTIVE = 'Y');
