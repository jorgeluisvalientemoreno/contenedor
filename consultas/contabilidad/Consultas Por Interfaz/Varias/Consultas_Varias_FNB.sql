SELECT * FROM open.mo_packages_asso WHERE PACKAGE_id = 42423661;
SELECT * FROM open.or_order_activity at where at.subscription_id = 1108852 and at.task_type_id = 10140;
select * from open.or_order i where i.order_id in (39251614);
select * from open.or_order_items i where i.order_id in (39251614);
SELECT * FROM open.ld_return_item i WHERE i.package_id = 39251614;
SELECT * FROM open.ld_return_item_detail id where id.return_item_id = 14614;
SELECT * FROM open.diferido d where d.difesusc = 1095262;
-- Relacion Anulacion con Venta FNB
SELECT * FROM open.or_order_activity at where at.package_id = 69475481;
select * from open.or_order o where o.order_id in (45978037,45978051,46076951,46076957);
select * from open.cargos c, open.concepto o where cargnuse = 50220354 and cargcaca in (1,3) and cargconc = conccodi and concclco =2;
SELECT * FROM open.mo_packages_asso WHERE PACKAGE_id = 42423661;
SELECT * FROM open.ld_return_item i WHERE i.package_sale = 39225814;
SELECT * FROM open.ld_return_item_detail id where id.return_item_id = 15419;
SELECT * from OPEN.ld_non_ban_fi_item i WHERE NON_BA_FI_REQU_ID = 39225814;
--
SELECT * from OPEN.ld_non_ban_fi_item i WHERE NON_BA_FI_REQU_ID = 39074329;
select * from open.ld_item_work_order a, open.ld_article al, open.concepto o
 where a.order_id in (42778639) and a.article_id = al.article_id and al.concept_id = o.conccodi;
