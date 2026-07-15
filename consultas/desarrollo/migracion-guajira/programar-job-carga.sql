SET SERVEROUTPUT ON
DECLARE
		sbTable 	VARCHAR2(200) := '';
		sbProgram	VARCHAR2(50) := 'PRDLOAD_' || sbTable;
		nuHilo		NUMBER;
		nuCantHilo	NUMBER;
		nuProcAct	NUMBER;
		SW			NUMBER;
		CURSOR cuGetConfig
		IS
		select cpmhilo 
		from migragg.conf_proc_migra
        where CPMENTI = sbProgram;
BEGIN

    FOR reg in cuGetConfig
    LOOP
        nuCantHilo := reg.cpmhilo;
        nuHilo := 1;
        migragg.pkgadminmigragdg.PRREMOVEINDEX(sbProgram);
        DBMS_OUTPUT.PUT_LINE('sbProgram: '||sbProgram);
        DBMS_OUTPUT.PUT_LINE('nuCantHilo: '||nuCantHilo);
        DBMS_OUTPUT.PUT_LINE('nuHilo: '||nuHilo);
        WHILE nuHilo <= nuCantHilo LOOP
            MIGRAGG.PKGPROC_MIGR_MGR.PRINSLOGPROC(
            ISBLPMPROG => sbProgram,
            INULPMHILO => nuHilo,
            ISBLPMOBSE => 'Inicia Proceso Carga '||sbProgram||' '||TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS'),
            INULPMREAP => 0,
            INULPMREPR => 0,
            INULPMREER => 0
            );	
            DBMS_OUTPUT.PUT_LINE('BEGIN MIGRAGG.'||sbProgram||'(' || nuCantHilo ||','||nuHilo|| '); END;');
            DBMS_SCHEDULER.CREATE_JOB (
               job_name        => SUBSTR(sbProgram,9)||'_' || TO_CHAR(nuHilo),
               job_type        => 'PLSQL_BLOCK',
               job_action      => 'BEGIN MIGRAGG.'||sbProgram||'(' || nuCantHilo ||','||nuHilo|| '); END;',
               start_date      => SYSDATE,
               enabled         => TRUE
            );
            nuHilo := nuHilo + 1;
            DBMS_OUTPUT.PUT_LINE('JOB CREADO');
        END LOOP;
        COMMIT;
        migragg.pkgadminmigragdg.PRCREATEINDEX(sbProgram);
    END LOOP;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error PKGADMINMIGRAGDG.RUNPROCESS: '||sqlerrm);
END ;