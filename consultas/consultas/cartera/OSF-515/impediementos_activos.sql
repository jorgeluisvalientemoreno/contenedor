select cc.subscription_id,
       cc.restriction_id ,
       cc.package_type_id,
       cc.restriction_type_id, 
       cc.restriction_statu_id,
       cc.comment_   
from open.cc_restriction cc
inner join open.servsusc s on cc.subscription_id = s.sesususc
where cc.restriction_statu_id in (1)
and s.sesuesco in (3)
and s.sesuesfn <> 'C'
and cc.package_type_id = 100240
