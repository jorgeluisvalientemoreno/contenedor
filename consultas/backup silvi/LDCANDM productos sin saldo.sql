select sesususc ,sesuesco,coecfact,sesuesfn , sesunuse , sesuserv,servdesc, sesusafa , suscsafa , 
cucocodi,cucofact,factfege   , cucosacu,cucovare ,
(select count(distinct (cb2.cucocodi)) from cuencobr cb2 where sesunuse = cb2.cuconuse and cb2.cucosacu>0 ) "Num_cuentas"
,(sum(cucosacu) - sum(cucovare) - sum(cucovrap)) "saldo_pend ",
('NDMAF|'||'  '||sesunuse||'|'||' '||'833'||'|'||'  '||'4'||'|'||'       '||'3000'||'|'||'  '||'6'||'|'||' '||'90'||'|'||'              '||'AJUSTETARIFA2122|')"Archivo"
from open.servsusc 
left join open.suscripc on susccodi = sesususc 
left join open.cuencobr cb1 on cb1.cuconuse = sesunuse 
left join open.servicio on sesuserv = servcodi 
left join open.factura f4 on factcodi = cucofact 
left join open.confesco on coecserv=sesuserv and coecfact ='S' and coeccodi = sesuesco 
where  sesuserv in (7014) and sesusafa >=0   and rownum <=8 and sesususc > 11111111
and f4.factfege = (select max(f2.factfege) from factura f2 where f2.factsusc = f4.factsusc)
and not exists (select null  from cuencobr b4 where b4.cuconuse= cb1.cuconuse and b4.cucosacu>0)
group by sesususc , sesuesco ,sesunuse ,factfege,coecfact,sesuesfn, sesuserv, servdesc,cucofeve , sesusafa , suscsafa , cucocodi , cucosacu ,cucovare ,cucofact
 UNION 
 select sesususc ,sesuesco,coecfact,sesuesfn , sesunuse , sesuserv,servdesc, sesusafa , suscsafa , 
cucocodi,cucofact,factfege   , cucosacu,cucovare ,
(select count(distinct (cb2.cucocodi)) from cuencobr cb2 where sesunuse = cb2.cuconuse and cb2.cucosacu>0 ) "Num_cuentas"
,(sum(cucosacu) - sum(cucovare) - sum(cucovrap)) "saldo_pend ",
('NDMAF|'||'  '||sesunuse||'|'||' '||'833'||'|'||'  '||'4'||'|'||'       '||'5000'||'|'||'  '||'4'||'|'||' '||'90'||'|'||'              '||'AJUSTETARIFA2122|')"Archivo"
from open.servsusc 
left join open.suscripc on susccodi = sesususc 
left join open.cuencobr cb1 on cb1.cuconuse = sesunuse 
left join open.servicio on sesuserv = servcodi 
left join open.factura  f1 on factcodi = cucofact 
left join open.confesco on coecserv=sesuserv and coecfact ='S' and coeccodi = sesuesco 
where sesuserv in (7055) and sesusafa >=0   and rownum <=8
and f1.factfege = (select max(f3.factfege) from factura f3 where f3.factsusc  =f1.factsusc   )
and not exists (select null  from cuencobr b4 where b4.cuconuse= cb1.cuconuse and b4.cucosacu>0)
group by sesususc , sesuesco ,sesunuse ,factfege,coecfact,sesuesfn, sesuserv, servdesc,cucofeve , sesusafa , suscsafa , cucocodi , cucosacu ,cucovare ,cucofact
order by sesususc , factfege  desc 
