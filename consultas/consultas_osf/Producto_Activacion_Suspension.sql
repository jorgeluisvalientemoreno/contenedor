--alter session set current_schema = OPEN;
select * from pr_product where product_id = 51014567;   
select * from or_order_activity where order_id= 315470848;
select * from pr_prod_suspension where product_id = 51014567;  
select * from hicaespr where hcetnuse= 51014567;
select * from mo_packages p,mo_motive m where m.product_id = 51014567 and p.package_id = m.package_id; 
