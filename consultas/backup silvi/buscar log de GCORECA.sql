select *
from logpno_ehg l;

select *
from LDC_LOGPROC
order by loprfege desc;

select *
from  LDC_TMP_FPORDERSDATA;

/*select  *
from or_operating_unit
where operating_unit_id = 3072
for update*/
  

select *
from ldc_metas_cont_gestcobr
where ano =2022
and mes = 07
order by fecha_registro desc;

select * 
from ldc_osf_estaproc
where ano = 2022
and mes = 07
order by fecha_inicial_ejec desc ;

select * from
GC_COLL_MGMT_PRO_DET
where order_id in (246618607,246618609,246618610,246618611);
  
select *
FROM OPEN.ldc_metas_cont_gestcobr 
WHERE ano = 2022
AND mes = 7 ;

/*
  select *
  from LDC_OSF_SESUCIER 
  where  nuano = 2022
  and producto in (50280597)
\*  and order_id in (246609802,246609582,246609585,246609563,246609578,246609567,246609564,246609577,
  246609575,246609573,246609571,246609568,246609576,246609565,246609566,246609569)*\
    order by numes desc
 \* and numes = 04*\
 */
 
 select *
from ldc_osf_estaproc
where ano = 2022
and mes = 7
and proceso = 'LDC_PKG_CALC_GEST_CARTERA.ldc_legaordergestcart'
order by fecha_final_ejec desc;

select *
from LDC_TEMP_CIERRECARTERA_HILOS;

select *
from logpno_ehg l;

select *
from LDC_LOGPROC
order by loprfege desc;



PROCREASIGORECA_HILOS
