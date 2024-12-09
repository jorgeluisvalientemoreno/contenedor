-- Comparación_autoreconectados
select s.sareproc, ec.coecfact, 
(select count (s2.saresesu)
 from ldc_susp_autoreco_rp_pl s2 
 inner join servsusc ss2 on ss2.sesunuse = s2.saresesu
 inner join confesco  ec2 on ec2.coecserv = ss2.sesuserv and ss2.sesuesco = ec2.coeccodi
  where s2.sareproc = s.sareproc and ec.coecfact = ec2.coecfact) "persca_pl",
(select count (s3.saresesu)
 from ldc_susp_autoreco_qh s3 
  inner join servsusc ss3 on ss3.sesunuse = s3.saresesu
  inner join confesco  ec3 on ec3.coecserv = ss3.sesuserv and ss3.sesuesco = ec3.coeccodi
   where s3.sareproc = s.sareproc and ec.coecfact = ec3.coecfact) "persca_qh",
count (s.saresesu) "gemps_qh",
(select count (s3.saresesu)
 from ldc_susp_autoreco_qh s3 
  inner join servsusc ss3 on ss3.sesunuse = s3.saresesu
  inner join confesco  ec3 on ec3.coecserv = ss3.sesuserv and ss3.sesuesco = ec3.coeccodi
   where s3.sareproc = s.sareproc and ec.coecfact = ec3.coecfact)- count (s.saresesu)  "comparativo"
from open.ldc_susp_autoreco s
inner join servsusc ss on ss.sesunuse = s.saresesu
inner join confesco  ec on ec.coecserv = ss.sesuserv and ss.sesuesco = ec.coeccodi
where  s.sareproc = 7
group by s.sareproc, ec.coecfact


-- Comparación_persecucion
select ec.coecfact, 
(select count (p2.susp_persec_producto)
 from ldc_susp_persecucion_pl p2 
 inner join servsusc ss2 on ss2.sesunuse = p2.susp_persec_producto
 inner join confesco  ec2 on ec2.coecserv = ss2.sesuserv and ss2.sesuesco = ec2.coeccodi
  where ec.coecfact = ec2.coecfact) "persca_pl",
(select count (p3.susp_persec_producto)
 from ldc_susp_persecucion_qh p3 
  inner join servsusc ss3 on ss3.sesunuse = p3.susp_persec_producto
  inner join confesco  ec3 on ec3.coecserv = ss3.sesuserv and ss3.sesuesco = ec3.coeccodi
   where ec.coecfact = ec3.coecfact) "persca_qh",
count (p.susp_persec_producto) "gemps_qh",
count (p.susp_persec_producto) - (select count (p3.susp_persec_producto)
 from ldc_susp_persecucion_qh p3 
  inner join servsusc ss3 on ss3.sesunuse = p3.susp_persec_producto
  inner join confesco  ec3 on ec3.coecserv = ss3.sesuserv and ss3.sesuesco = ec3.coeccodi
   where ec.coecfact = ec3.coecfact)  "comparativo"
from open.ldc_susp_persecucion p
inner join servsusc ss on ss.sesunuse = p.susp_persec_producto
inner join confesco  ec on ec.coecserv = ss.sesuserv and ss.sesuesco = ec.coeccodi
group by ec.coecfact;


select *
from ldc_susp_persecucion l
where not exists ( select null 
                   from ldc_susp_persecucion q
                   where q.susp_persec_producto = l.susp_persec_producto)

