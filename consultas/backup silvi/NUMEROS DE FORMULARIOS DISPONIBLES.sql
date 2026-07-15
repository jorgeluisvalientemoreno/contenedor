select *
from (select a.*
      from open.fa_histcodi a
      where a.hicdunop is not null
      and a.hicdcore is null
      and a.hicdfebl is null
      and upper(a.hicdobse) = upper('ASIGNAR')) a1
where not exists ( select null 
                from open.fa_histcodi  h2
                where h2.hicdnume = a1.hicdnume
                and HICDESTA = 'P')  ; 
 
select *
from (select a.*
      from open.fa_histcodi a
      where a.hicdunop is not null
      and a.hicdcore is null
      and a.hicdfebl is null
      and upper(a.hicdobse) = upper('ASIGNAR')) a1
where not exists ( select null 
                from OPEN.MO_PACKAGES h2
                where h2.document_key = a1.hicdnume
                and h2.PACKAGE_TYPE_ID IN (100229,271) 
                and h2.document_type_id = 1)  ; 
                
