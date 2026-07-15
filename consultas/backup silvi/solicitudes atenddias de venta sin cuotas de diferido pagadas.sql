select *
from mo_packages s 
left join mo_motive m on m.package_id = s.package_id
left join diferido on difesusc = subscription_id
left join  servsusc  s on sesunuse = m.product_id
where  s.package_type_id = 271
and (select count(distinct(d.difecofi))
                          from open.diferido d
                          where  d.difesusc = subscription_id
                          and d.difecupa > 0) =0
 and difesape > 0
--and sesusafa >0
and s.motive_status_id = 14
and rownum <= 20;


66571753
