select s.sesususc contrato,
       s.sesunuse producto,
       c.cargpefa periodo,
       s.sesuesfn estado_financiero,
       s.sesuserv tipo_producto,
       sp.suscefce factura_digital,
       sp.suscdeco correo
from open.servsusc s 
inner join open.cargos c on c.cargnuse = s.sesunuse
inner join open.suscripc sp on sp.susccodi = s.sesususc
where s.sesususc in (select su.susccodi  
                     from open.suscripc su 
                     where su.suscefce = 'S' 
                     and (select count(1)
                          from open.ldc_osf_sesucier l 
                          where su.susccodi  = l.contrato
                          and l.edad_deuda > 90 ) = 0 
                     and (select count(distinct(d.difecofi))
                          from open.diferido d
                          where  d.difesusc = su.susccodi
                          and d.difeprog = 'GCNED'
                          and d.difesape > 0)  > 0 )
and s.sesuesfn <> 'C'
and s.sesuserv = 7014 
and (select count (1) from open.cargos cc where cc.cargvalo > 0 and cc.cargcaca = 15 ) > 0
and c.cargpefa= 99966
group by s.sesususc,s.sesunuse,s.sesuesfn,s.sesuserv,sp.suscefce,sp.suscdeco,c.cargpefa