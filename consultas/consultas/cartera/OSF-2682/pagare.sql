select difesusc , difenuse,pagacofi, pagavtdi, paganucu, pagavcpa, pagapoin, pagafech, pagainte, pagacodi, paganufi ,d.difecofi,initial_payment  ,sum (difesape) "Suma de diferidos" , sum (difevacu) "Suma valor cuotas"
from pagare p
inner join diferido d on p.pagacofi = d.difecofi 
inner join cc_financing_request cc on cc.financing_id=  p.pagacofi
where pagafech >='01/04/2024'
group by  difesusc , difenuse,pagacofi, pagavtdi, paganucu, pagavcpa, pagapoin, 
pagafech, pagainte, pagacodi, paganufi,difecofi,warranty_document ,value_to_finance ,initial_payment 
order by difesusc ,pagafech desc 