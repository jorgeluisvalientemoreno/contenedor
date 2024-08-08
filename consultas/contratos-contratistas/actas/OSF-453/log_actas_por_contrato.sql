select *
from ct_process_log la
where la.contract_id = 6881
and   la.log_date >= '14/09/2022'
order by la.log_date desc
