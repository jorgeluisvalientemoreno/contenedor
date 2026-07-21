select distinct gps.process_schedule_id Tarea_Programada,
                gps.parameters_ Parametro_Objeto,
                DECODE(gps.frequency,
                       'UV',
                       'UV - UNA VEZ',
                       'DI',
                       'DI - DIARIO',
                       'SE',
                       'SE - SEMANAL',
                       'ME',
                       'ME - MENSUAL',
                       'AN',
                       'AN - ANUAL',
                       gps.frequency) Frecuencia_Ejecucion,
                DECODE(gps.status,
                       'T',
                       'T - TENTATIVO',
                       'P',
                       'P - PROGRAMADO',
                       'E',
                       'E - EJECUTADO',
                       'C',
                       'C - CANCELADO',
                       gps.status) Estado,
                gps.job JOB,
                gps.log_user Usuario,
                gps.start_date_ Inicio_Ejecucion,
                g.name_ Servicio,
                g.description Descripcion,
                g.comment_ Comentario,
                dj.LAST_DATE Ultima_Fecha_Ejecucion,
                dj.THIS_DATE Fecha_Ejecucion,
                dj.NEXT_DATE Proxima_Fecha_Ejecucion,
                dj.TOTAL_TIME Tiempo_Total_Ejecucion,
                dj.BROKEN,
                dj.WHAT,
                sysdate Fecha_sistema
  from open.ge_process_schedule gps
 inner join open.ge_object g
    ON 1 = 1
   and upper(g.name_) like upper('%prc_ejecasiglegasuspcdmacom%')
      -- and upper(g.comment_) like upper('%licencia%')
   and gps.parameters_ like '%OBJECT_ID=' || g.object_id || '%'
 inner join dba_jobs dj
    ON dj.JOB = gps.job
 where 1 = 1
   and gps.job != -1;

SELECT * --job_name, owner, enabled 
  FROM dba_scheduler_jobs;

select * from open.ge_object g where upper(g.name_) like upper('%BOASIG%'); --prc_ejecasiglegasuspcdmacom

select *
  from open.ge_process_schedule gps,
       (select g.*
          from open.ge_object g
         where upper(g.name_) like upper('%prc_ejecasiglegasuspcdmacom%')) gobject
 where gps.parameters_ like '%OBJECT_ID=' || gobject.object_id || '%'
--and gps.job != -1
;

select *
  from open.ge_process_schedule gps,
       (select g.*
          from open.ge_object g
         where upper(g.name_) like upper('%prc_ejecasiglegasuspcdmacom%')) gobject,
       dba_jobs dj
 where gps.parameters_ like '%OBJECT_ID=' || gobject.object_id || '%'
   and dj.job = gps.job;

select *
  from open.ge_process_schedule t
 where t.process_schedule_id = 58679;

select sysdate, dj.* from dba_jobs dj where dj.JOB = 3661968;

select gps.*
  from open.ge_process_schedule gps
 order by gps.process_schedule_id desc;
