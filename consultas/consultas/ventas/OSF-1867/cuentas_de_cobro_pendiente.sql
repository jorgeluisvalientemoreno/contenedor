 select br.cucocodi , br.cuconuse , f.factsusc ,f.factcodi ,f.factpefa , cucosacu 
from cuencobr br
left join factura f on cucofact = factcodi 
where factsusc  in (66519935)
and cucosacu >0 ;
