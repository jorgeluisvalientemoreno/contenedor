--validar periodo apto
SELECT * FROM PROCEJEC P WHERE  PREJPROG IN ('FGCC') and prejcope in (101975)

--buscar periodo apto
SELECT * FROM PROCEJEC P WHERE  PREJPROG IN ( 'FGCC')
and prejfech between  '16/01/2023 00:00:00' and '16/01/2023 23:59:00'
order by PREJFECH desc 


select *
from  ge_process_schedule 
order by start_date_ desc

select * from procejec  WHERE  PREJPROG IN ('FGCC') and prejcope in (101659); 101817


update procejec  set prejfech = '26/01/2023 09:00:00' where prejcope = 101817 AND PREJPROG IN ('FGCC') ;

SELECT esprfein, esprfefi
FROM ESTAPROG  
WHERE esprprog LIKE '%FGCC%'
AND esprpefa = 102811;

UPDATE ESTAPROG SET esprfefi = '22/01/2023 09:00:00' WHERE esprprog LIKE '%FGCC%' AND esprpefa = 102811; 
