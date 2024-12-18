begin
  sys.dbms_scheduler.create_job(job_name            => 'LDCI_FACELEC_EMI_ENERSOLAR',
                                job_type            => 'PLSQL_BLOCK',
                                job_action          => 'Begin "OPEN".LDCI_PKFACTELECTRONICA_EMI.PROSELFACTESOLARENVIAR; End;',
                                start_date          => to_date('13-01-2024 00:00:00', 'dd-mm-yyyy hh24:mi:ss'),
                                repeat_interval     => 'freq=hourly;',
                                end_date            => to_date(null),
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => true,
                                auto_drop           => false,
                                comments            => 'Selecciona y envia las facturas de energia solar, para el proceso de facturacion electronica');
end;
/