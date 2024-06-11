select *
from open.pr_promotion
where asso_promotion_id=73
and final_Date>'01/02/2022'
and final_Date<sysdate
and product_id in (50248800 ,1036627)
