set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN
update open.ldc_certificados_oia c
       set c.status_certificado = 'R',
           obser_rechazo = 'Datafix solicitado caso SOSF-1191',
           fecha_apro_osf = sysdate
     where certificados_oia_id  in (3896715,3917877,3911797);
     commit;
 Exception
   When others then
     Rollback;
     dbms_output.put_line(sqlerrm);
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/