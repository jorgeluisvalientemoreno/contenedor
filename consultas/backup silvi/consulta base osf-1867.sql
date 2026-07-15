select sesususc , sesunuse , sesuserv , sesucicl ,m.package_id,  m.package_type_id  , m.motive_status_id
from servsusc s
left join mo_motive mo on mo.subscription_id= sesususc
left join mo_packages m on mo.package_id = m.package_id  
where sesuserv = 6121 and m.package_type_id = 323 /*and sesucicl = 1999*/
 and exists (select null from cuencobr br where cuconuse= sesunuse and cucosacu>0 ) and  m.motive_status_id = 14 ;
 
 select br.cucocodi , br.cuconuse , f.factsusc ,f.factcodi ,f.factpefa , cucosacu 
from cuencobr br
left join factura f on cucofact = factcodi 
where factsusc  in (66519935)
and cucosacu >0 ;
