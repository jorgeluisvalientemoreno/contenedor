select sesususc "Contrato",
       suscnupr "Proceso",
       cargnuse"Producto",
       cargcuco "Cuenta de cobro",
       cargconc "Concepto",
       cargcaca "Causal",
       cargpefa "Periodo fact",
       cargvalo"Valor del cargo",
       cargdoso "Documento soporte"
from cargos 
left join servsusc se on se.sesunuse = cargnuse 
left join suscripc s  on s.susccodi= se.sesususc
left join ge_subscriber ge  on s.suscclie = ge.subscriber_id
left join ab_address a on a.address_id = s.susciddi
where cargcuco =-1 
and suscnupr = 2
and cargcaca in (15,51)
and cargpefa = (select pefacodi from perifact pf where pf.pefames = 02 and pf.pefaano=2023 and pf.pefacicl=se.sesucicl)
group by sesususc , suscnupr, cargnuse , cargcuco , cargconc , cargcaca, cargpefa, cargvalo , cargdoso 