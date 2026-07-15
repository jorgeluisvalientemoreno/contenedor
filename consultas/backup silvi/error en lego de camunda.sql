select * from ldci_package_camunda_log where package_id in (186560812)
--FOR UPDATE;


S.package_id = 186560693

--52401028, 52401031 ,52401034,52401037


select *
from mo_packages s 
left join mo_motive m on m.package_id = s.package_id
left join diferido on difesusc = subscription_id
left join  servsusc  s on sesunuse = m.product_id
where  s.package_type_id = 271
and (select distinct (difecodi) from diferido where difesusc =subscription_id and   difecupa > 0 ) = 0
and sesusafa >0
and s.motive_status_id = 14
and rownum <= 2;


