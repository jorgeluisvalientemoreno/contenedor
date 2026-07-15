case when  (select count (cpsccons)
           from ldc_coprsuca co 
           where co.cpscubge = ab.geograp_location_id 
           and co.cpsccate = sesucate 
           and co.cpscsuca = sesusuca) > 0 then 'Tiene_prom_sub' 
    when ( select count (cpsccons)
          from ldc_coprsuca co 
          where co.cpscubge = ab.geograp_location_id 
          and co.cpsccate = sesucate 
          and co.cpscsuca = sesusuca ) = 0 then 'No_tiene_prom_sub' end as cons_sub,
case when (select count (hcppcons)
            from hicoprpm h1
            where h1.hcppsesu= sesunuse 
            and hcpppeco = (select LDC_PKFAAC.fnuGetPericoseAnt(pf.pefacodi) from dual ) > 0 then 'si_cpp' 
    when   (select count (hcppcons)
            from hicoprpm h1
            where h1.hcppsesu= sesunuse 
            and hcpppeco =  (select LDC_PKFAAC.fnuGetPericoseAnt(pf.pefacodi) from dual )  ) = 0 then 'No_cpp' end as cons_pp 
