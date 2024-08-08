select A.PREJCOPE, count(1)
  from procejec a
 where a.prejprog in ('FCRI', 'FGCA', 'FGFC', 'FGCC', 'FGDP', 'FCPE')
   and a.PREJESPR = 'T'
   and a.prejfech >= sysdate - 146 having count(1) = 6
 group by A.PREJCOPE
 order by 1
--A.PREJCOPE IN (99413)
