BEGIN
  Dbms_Scheduler.Create_Job(Job_Name        => 'LDC_JOB_INTERACCION_SIN_FLUJO',
                            Job_Type        => 'PLSQL_BLOCK',
                            Job_Action      => 'Begin LDC_prJobInteraccionSinFlujo; End;',
                            Start_Date      => Systimestamp,
                            Repeat_Interval => 'freq=minutely; interval=10',
                            End_Date        => Null,
                            Comments        => 'Proceso para atender interaccion con todas sus solicitudes atendidas',
                            Enabled         => True,
                            Auto_Drop       => False);
exception
  when others then
    dbms_output.put_line('Error Controlado: ' || SQLERRM);
END;
/
