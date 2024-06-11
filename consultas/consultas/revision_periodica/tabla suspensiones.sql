select flag_noti_susp, count(1)
from open.ldc_usuarios_susp_y_noti
group by flag_noti_susp
;
select notif_suspe, count(1)
from open.usuarios_no_aplica_suspe_notif
group by notif_suspe;

select *
from open.ldc_osf_estaproc
where proceso = 'JOB_SUSPENSION_XNO_CERT_GDC'
and fecha_inicial_ejec>='07/04/2018';

SELECT * FROM DBA_SCHEDULER_RUNNING_JOBS where job_name='SUSP_Y_NOTIFICACION';


