select cpsccons "Consecutivo",
  Case when cpsccate = 1 then 'Residencial'
       when cpsccate = 2 then 'Comercial' end as "Categoria",
       cpscsuca "Subcategoria",
       cpscubge "localidad",
       cpscanco "Ano",
       cpscmeco "Mes",
       cpscprod "Cant_productos",
      round(( cpsccoto/cpscprod) /30,3) "Consumo_prom_diario",
      (cpsccoto/cpscprod)  "Consumo_prom_men",
       cpsccoto "Consumo_total"
from open.ldc_coprsuca
where cpscanco = 2024
and cpscubge in (201)
and cpscmeco in (7)
and cpsccate= 1
and cpscsuca = 2

/*update ldc_coprsuca set cpscprod= 396 where cpscanco = 2023
and cpscubge in (122)
and cpscmeco in (6)
and cpsccate= 1
and cpscsuca = 1*/

delete from ldc_coprsuca where cpscubge in (201)


CREATE TABLE ldc_coprsuca_sil AS
SELECT * FROM ldc_coprsuca_sil
where cpscanco = 2024
and cpscubge in (201)
and cpscmeco in (7,8)
and cpsccate= 1
and cpscsuca = 2;
