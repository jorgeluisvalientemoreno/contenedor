select prejcope,prejprog,prejfech,prejespr 
from open.procejec
where prejcope in (103269 , 103234 ,103276 , 103281 , 103284)
and prejprog = 'FGCC'
order by prejfech ;