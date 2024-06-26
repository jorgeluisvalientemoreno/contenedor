--VALIDAR DEMONIO
SELECT * FROM gv$session where MODULE like '%demonio%';
select PERIODO_FACTURA, FECHA_MAXIMA, CANTIDAD
  from (SELECT prejcope PERIODO_FACTURA,
               max(PREJFECH) FECHA_MAXIMA,
               count(PREJPROG) CANTIDAD
          FROM PROCEJEC P
         WHERE PREJPROG IN ('FGCC', 'FGCA')
           and prejcope in (select pf.pefacodi from open.perifact pf)
         having count(PREJPROG) = 2
         group by prejcope)
 order by FECHA_MAXIMA desc;
SELECT *
  FROM PROCEJEC P
 WHERE PREJPROG IN ('FGCC', 'FGCA')
   and prejcope in (102790)
