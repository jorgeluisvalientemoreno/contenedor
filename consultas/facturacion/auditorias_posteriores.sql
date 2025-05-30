El job ejecuta este procedimiento LDC_PRGAPYCAR.
Con este query se puede consultar su programación:
select *
from SYS.DBA_SCHEDULER_JOBS
where UPPER(COMMENTS) LIKE '%POST%';


insert into LDC_VALIDGENAUDPREVIAS(cod_pefacodi, fecha_audprevia, PROCESO) VALUES (nuPeriodo , SYSDATE, 'AUDPOST');



select *
from LDC_VALIDGENAUDPREVIAS

--este es el identificador que toma BI para procesar la posteriores
select distinct ciclo, max(idenjob) from open.ldc_cargaupo a where a.ciclo in (5002,5005,5008,5009,5015,5020,5078,5081,8714,8770,8798,8804,8805,8814) and a.anio=2025 and a.mes=2 group by ciclo

---el job es este
select * from DBA_SCHEDULER_JOBS
 where upper(job_action) like upper('%LDC_PRGAPYCAR%')
  order by JOB_NAME;

-- se presentan errores cuando hay periodos que no estan en E si es asi se deben poner en T
SELECT *
FROM OPEN.PROCEJEC
WHERE prejcope IN (115964,115965,115966,115967,115968,120442,115969,115970,116079,116080,116081,116082,116083,116084)
 AND PREJPROG ='FGCA';

