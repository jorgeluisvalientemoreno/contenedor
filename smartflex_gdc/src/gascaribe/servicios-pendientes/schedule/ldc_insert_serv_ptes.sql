begin
  sys.dbms_scheduler.create_job(job_name            => 'OPEN.LDC_INSERT_SERV_PTES',
                                job_type            => 'PLSQL_BLOCK',
                                job_action          => 'DECLARE
                                                        BEGIN
                                                        --
                                                        LDC_INSERT_SERV_PENDIENTES; 
                                                        --
                                                        END;',
                                start_date          => sysdate + 03/24/59,
                                end_date            => to_date(null),
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => true,
                                auto_drop           => false,
                                comments            => 'Insert de saldos iniciales de Servicios Pendientes a 30/06/2022');
end;
/
