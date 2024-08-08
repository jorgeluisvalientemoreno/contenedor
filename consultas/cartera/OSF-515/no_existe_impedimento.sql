select  s.sesususc,
        s.sesuesco, 
        s.sesuesfn
from open.servsusc s
where s.sesuesco in (3)
and s.sesuesfn <> 'C'
and not exists (select null from open.cc_restriction cc where  cc.subscription_id = s.sesususc) 