--esta es la tabla donde queda el registro del proceso de RESURECA que se esta ejecutando;

SELECT * FROM open.procrere WHERE prresist = 99 AND procrere.prrresta = 'I' AND TRUNC(prrrfepa) BETWEEN TRUNC(TO_dATE('26/08/2025','DD/MM/YYYY')) AND TRUNC(TO_dATE('26/08/2025','DD/MM/YYYY'));

--esa tabla esta en blanco, solo deja el registro cuando se procesa, luego desaparece..
--esa fua la consulta que solicitaron se ejecutara para validar..

  DELETE FROM procrere
    WHERE prresist = 99
    AND   procrere.prrresta = 'I'
    AND   TRUNC(prrrfepa) BETWEEN TRUNC(TO_dATE('26/08/2025','DD/MM/YYYY')) AND TRUNC(TO_dATE('26/08/2025','DD/MM/YYYY'));

--    Lo hilos del proceso terminaron, pero el proceso principal no termino, quedo en 0% y procesando
--esto se mira en estraprog where esprprog like '%FGRR%' EL PROCESO QUE NO TIENE EL HILO AL FINAL ES EL PRINCIPAL
--mire que la programación diaria realizada por la consola financiera de este procedo queda OPEN.GE_PROCESS_SCHEDULE

-- Consulta de la programacin realizada por GEMPS de la ejecucion del resumen de recaudo
select object_id, s.process_schedule_id, s.executable_id, s.parameters_, s.frequency, s.status, s.job, s.log_user, s.start_date_, j.LAST_DATE, j.NEXT_DATE, ob.name_, ob.description
 from  OPEN.GE_PROCESS_SCHEDULE s
LEFT JOIN OPEN.GE_PROC_SCHE_DETAIL o on o.process_schedule_id = s.process_schedule_id
left join open.ge_object ob on s.parameters_ like 'OBJECT_ID='||Ob.OBJECT_ID
inner join dba_jobs j on j.job=s.job
WHERE object_id IN (
                    120661, -- Ajuste Resureca Diario
                    49622   -- FRRO- Generación de Resúmenes de Recaudo
                   )
order by s.start_date_ asc;
