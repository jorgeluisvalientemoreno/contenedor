column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
Begin
      DBMS_SCHEDULER.CREATE_JOB(job_name        => 'JOB_CONTABILIZA_ACTAS_FNB',
                                job_type        => 'PLSQL_BLOCK',
                                job_action      => 'DECLARE
                                                        onuCodError         NUMBER;
                                                        osbMensError        VARCHAR2(4000);
                                                        dtFechaIni          DATE;
                                                        dtFechaFin          DATE;
                                                        PROCEDURE pDebugOn IS
                                                        BEGIN
                                                            Errors.Initialize;
                                                            ut_trace.Init;
                                                            ut_trace.SetOutPut(ut_trace.CNUTRACE_DBMS_OUTPUT);
                                                            ut_trace.SetLevel(99);
                                                            pkGeneralServices.SETTRACEDATAON;
                                                        END pDebugOn;
                                                        PROCEDURE pDebugOff IS
                                                        BEGIN
                                                            ut_trace.SetLevel(0);
                                                            Pkerrors.traceoFF;
                                                            pkGeneralServices.SETTRACEDATAOFF;
                                                        END pDebugOff;
                                                    BEGIN
                                                        --pDebugOn;
                                                        dtFechaIni := ''03/01/2025''; -- fecha de cierre
                                                        dtFechaFin := ''03/01/2025''; -- fecha de contabilizacion
                                                        personalizaciones.pkg_ContabilizaActasAut.prProcesaActasFNB_Sap
                                                        (
                                                            dtFechaIni,
                                                            dtFechaFin
                                                        );
                                                        --pDebugOff;
                                                    EXCEPTION
                                                        WHEN OTHERS THEN
                                                            Errors.setError;
                                                            pkerrors.geterrorvar(onuCodError, osbMensError);
                                                            osbMensError := osbMensError ||'', SQLERRM: ''|| SQLERRM;
                                                    END;',
                                start_date      => Systimestamp,
                                enabled         => TRUE,
                                comments        => 'JOB DE CONTABILIZACION DE ACTAS DE FNB');
    End;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/