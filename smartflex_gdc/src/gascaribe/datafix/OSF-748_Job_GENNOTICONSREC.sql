column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
/***********************************************************
ELABORADO POR:  Juan Gabriel Catuche Girón
EMPRESA:        MVM Ingeniería de Software
FECHA:          Diciembre 2022
JIRA:           OSF-748

Programa Job LDC_GENNOTICONSREC para notificación de consumos recuperados altos x dia 

    
    Archivo de entrada 
    ===================
    NA            
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    
    27/12/2022 - jcatuchemvm
    Creación
    
***********************************************************/
declare
    nuerror ge_error_log.message_id%TYPE;
    sberror ge_error_log.description%TYPE; 
begin
    ut_trace.Init;
    ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
    ut_trace.SetLevel(99);
    ut_trace.Trace('INICIO');
    
    nuerror := pkConstante.EXITO;
    
    LDC_BONOTYCONSREC.pJob;
    
    dbms_output.put_line('Finalizo sin error LDC_BONOTYCONSREC.pJob');
   
exception
    when others then
        pkerrors.geterrorvar(nuerror,sberror);
        dbms_output.put_line('Error Exception '||sberror);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/