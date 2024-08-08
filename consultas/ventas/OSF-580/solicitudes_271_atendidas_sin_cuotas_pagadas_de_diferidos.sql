select *
from open.mo_packages s 
left join open.mo_motive m on m.package_id = s.package_id
left join open.diferido on difesusc = subscription_id
left join open.servsusc  s on sesunuse = m.product_id
left join open.cc_sales_financ_cond f on f.package_id = s.package_id
where  s.package_type_id = 271
and (select count(distinct(d.difecofi))
                          from open.diferido d
                          where  d.difesusc = subscription_id
                          and d.difecupa > 0) =0
and sesusafa >0
and s.motive_status_id = 14
and rownum <= 20
and exists ( select *
            from open.diferido 
            where difecofi = finan_id and difesape > 0 );
