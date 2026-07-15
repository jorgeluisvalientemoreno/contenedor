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
 
