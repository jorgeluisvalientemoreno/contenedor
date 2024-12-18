set serveroutput on size unlimited
set linesize 1000
set timing on
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

COLUMN instancia new_val instancia format a20;
COLUMN fecha_ejec new_val fecha_ejec format a20;
COLUMN esquema new_val esquema format a20;
COLUMN ejecutado_por new_val ejecutado_por format a20;
COLUMN usuario_so new_val usuario_so format a35;
COLUMN fecha_fin new_val fecha_fin format a25
DEFINE CASO=OSF2487

SELECT SYS_CONTEXT('USERENV', 'DB_NAME') instancia,
   TO_CHAR(SYSDATE, 'yyyymmdd_hh24miss') fecha_ejec,
   SYS_CONTEXT('USERENV','CURRENT_SCHEMA') esquema,
   USER ejecutado_por,
   SYS_CONTEXT('USERENV', 'OS_USER') usuario_so
FROM DUAL;

PROMPT
PROMPT =========================================
PROMPT  ****   Información de Ejecución    ****
PROMPT =========================================
PROMPT Instancia        : &instancia
PROMPT Fecha ejecución  : &fecha_ejec
PROMPT Usuario DB       : &ejecutado_por
PROMPT Usuario O.S      : &usuario_so
PROMPT Esquema          : &esquema
PROMPT CASO             : &CASO
PROMPT =========================================
PROMPT
declare
    nuerror ge_error_log.message_id%TYPE;
    sberror ge_error_log.description%TYPE; 
    INUSUBSCRIPTION number;
    INUBILLINGPERIOD number;
    ISBGENERACLOB varchar2(1);
    SBCOUPONTYPE varchar2(2);
    CLCLOBDATA clob;
    
begin
    ut_trace.Init;
    ut_trace.SetOutPut(ut_trace.CNUTRACE_OUTPUT_FILE);
    ut_trace.SetLevel(99);
    execute immediate 'alter session set sql_trace true';
	execute immediate 'alter session set timed_statistics=true';
    ut_trace.Trace('INICIO',10);
    
    nuerror := pkConstante.EXITO;
    INUSUBSCRIPTION := 17116566;
    --INUBILLINGPERIOD := 106729; --BZ
    --INUBILLINGPERIOD := 107547; --QH
    INUBILLINGPERIOD := 111018;  --PL
    ISBGENERACLOB := 'S';
    SBCOUPONTYPE := 'FA';
    
    pkerrors.setapplication('FIDF');
    
    PKBOPRINTINGPROCESS.PROCESSBYCONTRACT
    (
        INUSUBSCRIPTION,
        INUBILLINGPERIOD,
        ISBGENERACLOB,
        CLCLOBDATA,
        SBCOUPONTYPE,
        'S' --PKCONSTANTE.SI
    );
    
    --pkg_epm_utilidades.EvaluarError(nuerror);
    
    dbms_output.put_line('Finalizo sin error');
    dbms_output.put_line('Mensaje '||sberror);
    execute immediate 'alter session set sql_trace false';
    
    rollback;

exception
    when others then
        rollback;
        pkerrors.geterrorvar(nuerror,sberror);
        dbms_output.put_line('Error Exception '||sberror);
        execute immediate 'alter session set sql_trace false';
end;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;

PROMPT **** FIN EJECUCIÓN ****
PROMPT CASO             : &CASO
PROMPT Fecha fin        : &fecha_fin
PROMPT =========================================

set timing off
set serveroutput off
quit
/
