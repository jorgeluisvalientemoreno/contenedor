-- validar error de job
select *
from ldc_osf_estaproc p
Where p.fecha_inicial_ejec >='12/07/2023 16:40:00'
and proceso like '%CARTERA%'
order by p.fecha_inicial_ejec desc

SELECT *
FROM ge_process_schedule
WHERE start_date_  > '20/12/2022'
order by start_date_ desc 
FOR UPDATE 


SELECT *
FROM MOVIDIFE 
WHERE modisusc =48259287
AND MODIFECH > '02/12/2022' 
ORDER BY MODIFECH DESC 

select *
from estaprog
where esprfein > '12/07/2023' 
order by esprfein desc 

select *
from ldc_pefageptt
where  pegpcicl in (1015)
and pegpperi in (102388)
order by pegpfere desc


SELECT *
from open.LDC_ACTIVI_BY_PACK_TYPE
where package_type_id=100306
and activity_ID = 100006927
/*for update*/
and actividades_rev_per like '%100006928%'
 and actividades_rev_per like '%100006927%'




select ANO, MES, PROCESO, ESTADO, FECHA_INICIAL_EJEC, FECHA_FINAL_EJEC, round((FECHA_FINAL_EJEC - FECHA_INICIAL_EJEC)*24*60,2)  tiempo
from open.ldc_osf_estaproc
where/* proceso = 'LDC_BOSUSPENSIONS.PROCESSNOBILL'
and  */ FECHA_INICIAL_EJEC >= '21/07/2022 08:00:00'  
order by FECHA_INICIAL_EJEC desc)
order by fecha_inicial_ejec desc;
