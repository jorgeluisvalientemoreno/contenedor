--alter session set current_schema = OPEN;
select *
  from open.pr_product pp
 where pp.product_id in
       (select a.sesunuse from open.servsusc a where a.sesususc = 14209426);

select *
  from open.pr_prod_suspension
 where product_id in
       (select a.sesunuse from open.servsusc a where a.sesususc = 14209426)
 order by register_date desc;

select *
  from open.hicaespr
 where hcetnuse in
       (select a.sesunuse from open.servsusc a where a.sesususc = 14209426);

select *
  from open.mo_packages p, open.mo_motive m
 where m.product_id in
       (select a.sesunuse from open.servsusc a where a.sesususc = 14209426)
   and p.package_id = m.package_id;

select *
  from open.pr_prod_suspension pps1
 where pps1.prod_suspension_id in (select pps.prod_suspension_id
                             from open.pr_prod_suspension pps
                            where pps.suspension_type_id = 5
                              and pps.inactive_date is null
                              and pps.active = 'N')
 order by pps1.register_date desc, pps1.product_id desc;

select *
  from open.pr_prod_suspension pps1
 where pps1.prod_suspension_id in (select pps.prod_suspension_id
                             from open.pr_prod_suspension pps
                            where pps.suspension_type_id = 5
                              and pps.inactive_date is not null
                              and pps.active = 'N')
 order by pps1.product_id, pps1.register_date desc ;
