with executable as (
select tabla_ante.executable_id, count(1) cantidad
FROM OPEN.AU_AUDIT_POLICY_LOG AU, xmltable('AU_LOG' passing xml_log
                                                   columns executable_id number path '//ACTUAL_VALUES//MODIFICACIONES//EXECUTABLE_ID') tabla_ante
where au.AUDIT_LOG_ID=217
  and au.current_table_name = 'SA_EXECUTABLE'
  and au.current_date > sysdate - 90
  group by tabla_ante.executable_id
)
select p.executable_id, p.cantidad, e.description
from executable p
left join open.sa_executable e on p.executable_id=e.executable_id
