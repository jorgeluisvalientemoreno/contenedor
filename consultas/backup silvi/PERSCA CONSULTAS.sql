Select p.process_schedule_id, p.executable_id, p.start_date_, p.status, p.job, p.parameters_, p.log_user
From open.ge_process_schedule p
Where p.what like '%PERSCA%'
--and   p.status in ('E','P')
and   p.parameters_ like '%COMMENT=9%'
and p.start_date_ >= '08/02/2023'
--and   p.job <> -1


--and   p.start_date_ >= to_date ('12/08/2020')
;

Select *
From open.estaprog p
Where p.esprfein >= to_date ('08/02/2023')
and   p.esprprog like '%PERSCA%';

select *
from open.LDC_SUSP_AUTORECO s
where 
sarecicl = 349

/*select *
from open.LDC_PROCESO */
