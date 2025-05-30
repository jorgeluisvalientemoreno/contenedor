--armar_cadena_LDCANDM
select sesususc ,sesuesco,coecfact,sesuesfn , sesunuse , sesuserv,servdesc, sesusafa , suscsafa , 
cucocodi,cucofact,factfege   , cucosacu,cucovare ,
(select count(distinct (cb2.cucocodi)) from cuencobr cb2 where sesunuse = cb2.cuconuse and cb2.cucosacu>0 ) "Num_cuentas"
,(sum(cucosacu) - sum(cucovare) - sum(cucovrap)) "saldo_pend ",
('NDMAF|'||'  '||sesunuse||'|'||' '||'833'||'|'||'  '||'4'||'|'||'       '||'30000'||'|'||'  '||'6'||'|'||' '||'90'||'|'||'              '||'AJUSTETARIFA2122|')"Archivo"
from open.servsusc 
left join open.suscripc on susccodi = sesususc 
left join open.cuencobr cb1 on cb1.cuconuse = sesunuse 
left join open.servicio on sesuserv = servcodi 
left join open.factura f4 on factcodi = cucofact 
left join open.confesco on coecserv=sesuserv and coecfact ='S' and coeccodi = sesuesco 
where cucosacu >0 and sesuserv in (7014) and sesusafa >=0   and rownum <=8
and ((cucosacu) - (cucovare) - (cucovrap))  >0  and coecfact = 'S' and sesususc = 1000899
and f4.factfege = (select max(f2.factfege) from factura f2 where f2.factsusc = f4.factsusc)
group by sesususc , sesuesco ,sesunuse ,factfege,coecfact,sesuesfn, sesuserv, servdesc,cucofeve , sesusafa , suscsafa , cucocodi , cucosacu ,cucovare ,cucofact
