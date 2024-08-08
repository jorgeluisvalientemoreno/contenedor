--numero formulario disponible
select *
from (select a.*
      from open.fa_histcodi a
      where a.hicdunop is not null
      and a.hicdcore is null
      and a.hicdfebl is null
      and upper(a.hicdobse) = upper('asignar')) a1
where a1.hicdunop = 4021 ; 
 