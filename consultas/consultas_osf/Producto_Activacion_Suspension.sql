--alter session set current_schema = OPEN;
select * from open.pr_product pp where pp.product_id in (select a.sesunuse from open.servsusc a where a.sesususc=67063938); -- product_id = 51014567;   
--select * from open.or_order_activity ooa where ooa.subscription_id in (67063938); -- pp.order_id= 315470848;
select * from open.pr_prod_suspension where product_id in (select a.sesunuse from open.servsusc a where a.sesususc=67063938);  
select * from open.hicaespr where hcetnuse in (select a.sesunuse from open.servsusc a where a.sesususc=67063938);  
select * from open.mo_packages p,open.mo_motive m where m.product_id in (select a.sesunuse from open.servsusc a where a.sesususc=67063938)  and p.package_id = m.package_id;
 
