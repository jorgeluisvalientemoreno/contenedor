select * 
from pr_prod_suspension pr 
where pr.product_id= 16002754;

--select * from ldc_marca_producto l where l.id_producto = 16002754; 
--select * from pr_comp_suspension  ps  , PR_COMPONENT  c where  c.COMPONENT_ID = ps.COMPONENT_ID and c.service_number= 16002754;

UPDATE PR_PRODUCT SET product_status_id = 1  WHERE PRODUCT_ID = 16002754
select sesususc, sesunuse ,sesucate,sesuesco,sesuesfn from servsusc where sesunuse= 1186962
 UPDATE pr_comp_suspension SET ACTIVE ='N' WHERE COMPONENT_ID  = 2910311
 UPDATE pr_comp_suspension SET inactive_date ='12/02/2021'  WHERE COMPONENT_ID  = 2910311
update pr_prod_suspension pr set suspension_type_id=105 where pr.product_id= 50664712 and prod_suspension_id = 2913731 
update pr_prod_suspension pr set inactive_date ='12/02/2021'  where pr.product_id= 16002754 and suspension_type_id = 101 and prod_suspension_id = 1724386 
update pr_prod_suspension pr set active='N' where pr.product_id= 16002754 and prod_suspension_id = 1724386 
