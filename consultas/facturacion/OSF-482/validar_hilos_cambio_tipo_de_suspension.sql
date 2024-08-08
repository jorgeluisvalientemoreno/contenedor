select *
  from (select ano,
               mes,
               proceso,
               estado,
               fecha_inicial_ejec,
               fecha_final_ejec,
               round((fecha_final_ejec - fecha_inicial_ejec) * 24 * 60, 2) tiempo
          from open.ldc_osf_estaproc
         where proceso = 'PRJOBRECOYSUSPRP'
           order by fecha_inicial_ejec desc)
 order by tiempo desc;
