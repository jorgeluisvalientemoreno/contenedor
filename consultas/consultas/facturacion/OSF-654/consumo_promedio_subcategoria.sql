select ldc_coprsuca.cpsccate categoria,
       ldc_coprsuca.cpscsuca subcategoria,
       ldc_coprsuca.cpscubge localidad,
       ldc_coprsuca.cpscanco ano,
       ldc_coprsuca.cpscmeco mes,
       ldc_coprsuca.cpscprod cant_prod,
       ldc_coprsuca.cpscprdi prom_diario,
       ldc_coprsuca.cpsccoto consumo_total
from open.ldc_coprsuca 
where ldc_coprsuca.cpsccate = 1
and ldc_coprsuca.cpscsuca = 1
and ldc_coprsuca.cpscubge = 157
and ldc_coprsuca.cpscanco = 2022
and ldc_coprsuca.cpscmeco = 10
