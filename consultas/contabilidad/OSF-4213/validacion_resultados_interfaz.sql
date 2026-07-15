with base as (
select cod_interfazldc cod_interfazldc_old, clasecta  clasecta_old , clavcont clavcont_old, sum ( impomsoc ) sum_impomsoc_old
from ldci_detaintesap
where cod_interfazldc in  ( 57294) 
group by cod_interfazldc , clasecta,clavcont),
base_2 as (
select cod_interfazldc cod_interfazldc_new, clasecta  clasecta_new ,clavcont clavcont_new, sum ( impomsoc ) sum_impomsoc_new
from ldci_detaintesap
where cod_interfazldc in  ( 57303 ) 
group by cod_interfazldc , clasecta, clavcont)
select cod_interfazldc_old, clasecta_old, clavcont_old , sum_impomsoc_old , cod_interfazldc_new, clasecta_new ,clavcont_new, sum_impomsoc_new ,
case when sum_impomsoc_old = sum_impomsoc_new then 'COINCIDE'  end as validacion 
from base_2 
full outer join base on clasecta_old=clasecta_new and clavcont_old= clavcont_new  ;
