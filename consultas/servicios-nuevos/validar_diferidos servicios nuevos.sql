select  *
from open.cc_grace_period;
select fi.package_id,
       difesusc,
       difenuse, 
       (select m.comment_ from open.mo_comment m where m.package_id=fi.package_id and comment_ like '%PLAN_PILOTO_2_VISITAS_V2%'),
       c.end_date,
       (select p.product_status_id from open.pr_product p where p.product_id=difenuse) estado
from open.cc_grace_peri_defe c
inner join open.diferido de on de.difecodi=c.deferred_id --and difesusc=67346996
inner join open.concepto co on co.conccodi=de.difeconc 
inner join open.cc_sales_financ_cond fi on fi.finan_id=de.difecofi
where c.grace_period_id=47
;

/*select *
from open.diferido
where difesusc=67346996;
select *
from open.cc_sales_financ_cond 
where package_id=193272492
select *
from open.mo_packages
where package_id=193272492*/


select *
from open.plandife d
where d.pldipegr =47;

