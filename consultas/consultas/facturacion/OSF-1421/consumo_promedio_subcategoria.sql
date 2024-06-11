select ldc_coprsuca.cpsccate categoria,
       ldc_coprsuca.cpscsuca subcategoria,
       ldc_coprsuca.cpscubge localidad,
       ldc_coprsuca.cpscanco ano,
       ldc_coprsuca.cpscmeco mes,
       ldc_coprsuca.cpscprod cant_prod,
       ldc_coprsuca.cpscprdi prom_diario,
       ldc_coprsuca.cpsccoto consumo_total,
       round(( cpsccoto/cpscprod) /31,3) "Consumo_prom_diario",
        round(( cpsccoto/cpscprod) ,3) "Consumo_prom_mensual"
from open.ldc_coprsuca 
where ldc_coprsuca.cpsccate = 1
and ldc_coprsuca.cpscsuca = 2
and ldc_coprsuca.cpscubge = 55
and ldc_coprsuca.cpscanco = 2023
and ldc_coprsuca.cpscmeco in (6,7,8)
order by ldc_coprsuca.cpscmeco desc
