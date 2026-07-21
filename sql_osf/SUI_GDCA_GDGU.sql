select a1.*
  from OPEN.LDC_ATECLIREPO a1
 where 1 = 1
   and a1.empresa = 'GDCA'
   and a1.ano_reporte = 2026
   and a1.mes_reporte in (2, 3, 4)
   and 1 = 1
 order by a1.ano_reporte desc;

/*select a.*
  from OPEN.LDC_DETAREPOATECLI a
 inner join OPEN.LDC_ATECLIREPO a1
    on 1 = 1
   and a1.empresa = 'GDCA'
   and a1.ateclirepo_id = a.ateclirepo_id
   and a1.ano_reporte = 2026
   and a1.mes_reporte in (2, 3, 4)
 where 1 = 1
      -- and a.ateclirepo_id = 2982
   and 1 = 1;*/

select t.ateclirepo_id, a.empresa, a.ano_reporte, a.mes_reporte, count(1)
  from LDC_DETAREPOATECLI t, LDC_ATECLIREPO a
 where 1 = 1
   and t.ateclirepo_id = a.ateclirepo_id
   and a.ano_reporte >= 2026
   and a.mes_reporte in (2, 3, 4)
   and a.empresa = 'GDCA'
/*and a.ateclirepo_id in (select a1.ateclirepo_id
 from OPEN.LDC_ATECLIREPO a1
where a1.empresa = 'GDCA')*/
 group by t.ateclirepo_id, a.empresa, a.ano_reporte, a.mes_reporte;

select sysdate, a.*, b.*
  from dba_jobs a, open.GE_PROCESS_SCHEDULE b
 where a.job = b.job
   and b.executable_id =
       (select se.executable_id
          from open.sa_executable se
         where se.name like upper('%PANEXA%'))
      --and b.job <> -1
   and 1 = 1;

select a.*, rowid
  from ESTAPROC a
 where a.proceso like upper('PANEXA%')
   and a.fecha_inicial_ejec >= '22/06/2026'
 order by a.fecha_inicial_ejec desc;

select a.*, rowid
  from ldc_osf_estaproc a
 where a.proceso like upper('%ldcrepanexa%')
   and a.fecha_inicial_ejec >= '22/06/2026'
 order by a.fecha_inicial_ejec desc;
