SELECT COUNT(1)
FROM OPEN.LDC_OTREV_REPA;

SELECT product_id
FROM OPEN.LDC_OTREV;

select R.*, (r.finaliza-R.INICIA)*60*24
from open.ldc_rangogenint R
select *
from ge_process_schedule
where start_date_>='07/04/2018'
and process_schedule_id>=222457
