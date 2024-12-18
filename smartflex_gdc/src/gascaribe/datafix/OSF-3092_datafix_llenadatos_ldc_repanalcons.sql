column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set linesize 1000
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
/***********************************************************
ELABORADO POR:  jsoto
FECHA:          Agosto 2024
JIRA:           OSF-3092

Se usa de muestra del OSF-2143
    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    OSF3092_RefinanciaDiferidosError_yyyymmdd_hh24mi.txt
    
    --Modificaciones    
    29/11/2023 - jcatuchemvm
    Creación
    
***********************************************************/
declare
    gsbChainJobs    VARCHAR2(30) := 'CADENA_JOBS_OSF3092';
    gsbProgram      VARCHAR2(2000) := 'OSF3092';
    gnu_TOTAL_HILOS NUMBER := 1;
    
    sbPueblaTabla       VARCHAR2(4000);
    sbCreProcedimiento  VARCHAR2(20000);
    sbBorraObjetos      VARCHAR2(4000);
    nuError             NUMBER;
    sbError             VARCHAR2(4000);
    
    CURSOR cuUSER_SCHEDULER_JOBS
    (
        isbJOB_NAME IN USER_SCHEDULER_JOBS.JOB_NAME%TYPE
    )
    IS
        SELECT  *
        FROM    USER_SCHEDULER_JOBS
        WHERE   JOB_NAME = isbJOB_NAME;
        
    rcUSER_SCHEDULER_JOBS       cuUSER_SCHEDULER_JOBS%ROWTYPE;  
    
begin
    
    
    --Inicializa sbCreProcedimiento, crea procedimiento para proceso por hilos
    sbCreProcedimiento := 
    '
CREATE OR REPLACE PROCEDURE OPEN.OSF3092 (inuHilo in number)
IS
    csbMetodo        CONSTANT VARCHAR2(70) := ''LDC_PROCREPAVC_TEMP'';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;

    nuerror        NUMBER (3) := 0;
    nuciclo        servsusc.sesucicl%TYPE;
    sbMensaje        VARCHAR2 (4000);
    error          NUMBER;
    nuparano       NUMBER (4);
    nuparmes       NUMBER (2);
    nutsess        NUMBER;
    sbparuser      VARCHAR2 (30);
    dtfeanal       DATE := SYSDATE;
    nucantregis    NUMBER (10) DEFAULT 0;
    cant_reg       NUMBER (10) DEFAULT 0;

    -- Destinatarios
    sbDestinatarios           VARCHAR2 (4000)
        := pkg_BCLD_Parameter.fsbObtieneValorCadena (''LDC_MAIL_LDC_PROCREPAVC'');
    sbAsunto      VARCHAR2 (4000) := ''LDC_PROCREPAVC Automatico'';
    sbCiclos       VARCHAR2 (4000);

    -- cursor de periodos a procesar
    CURSOR cuPeriodos IS
        SELECT pefacicl,
               pefaano,
               pefames,
               p.*
          FROM procejec p, perifact pf
         WHERE     TRUNC (prejfech) BETWEEN ''10/07/2024'' AND ''09/08/2024''
		 AND p.prejprog = ''FGCC''
               AND p.prejespr = ''T''
               AND p.prejcope = pefacodi;


    -- Cursor de ciclos
    CURSOR cuciclos (nuciclo perifact.pefacicl%TYPE)
    IS
        SELECT COUNT (1)     AS cant_reg
          FROM servsusc
         WHERE sesuserv = 7014 AND sesucicl = nuciclo;
    
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
    
    nuerror := 1;
    nucantregis := 0;
      
    nutsess     := USERENV (''SESSIONID'');
    sbparuser   := USER;

    nuerror := 2;
    -- Se adiciona al log de procesos
    ldc_proinsertaestaprog (nuparano,
                            nuparmes,
                            ''LDC_PROCREPAVC_AUTO'',
                            ''En ejecucion'',
                            nutsess,
                            sbparuser);

    nuerror := 3;

    -- Se recorren los periodos procesados el dia anterior
    FOR i IN cuPeriodos
    LOOP
        -- se busca el numero de productos por ciclo
        OPEN cuciclos (i.pefacicl);

        FETCH cuciclos INTO cant_reg;

        IF cuciclos%NOTFOUND
        THEN
            cant_reg := -1;
        END IF;

        CLOSE cuciclos;

        IF cant_reg > 0
        THEN
            -- Borramos registros
            DELETE ldc_repanalcons p
             WHERE     nuano = i.pefaano
                   AND numes = i.pefames
                   AND p.ciclo = i.pefacicl;

            COMMIT;


            nuerror := 4;
            -- buscamos los datos para el analisis de consumo para cada producto del ciclo
            nuciclo := i.pefacicl;

            INSERT INTO ldc_repanalcons
                (SELECT /*+INDEX(servsusc IX_SERVSUSC08)*/
                        i.pefaano
                            AS nuano,
                        i.pefames
                            AS numes,
                        sesususc,
                        sesunuse,
                        sesucicl,
                        sesucate,
                        sesusuca,
                        sesufein,
                        ldc_osspkevaluametodosavc.fnuevalmetodo5 (sesunuse,
                                                                  dtfeanal)
                            metodo5,
                        ldc_osspkevaluametodosavc.fnuevalmetodo9 (sesunuse,
                                                                  dtfeanal)
                            metodo9,
                        ldc_fnuGetZeroConsPer_gdc (sesunuse,
                                                   i.pefaano,
                                                   i.pefames)
                            periodos_cero,
                        28,
                        null,
                        null
                   FROM servsusc
                  WHERE     sesucicl = i.pefacicl
                        AND sesuserv = 7014
                        AND sesunuse = sesunuse);

            COMMIT;
            nucantregis := nucantregis + cant_reg;
            sbCiclos :=
                   sbCiclos
                || i.pefacicl
                || '' (''
                || i.pefaano
                || '' - ''
                || i.pefames
                || ''),''
                || ''<br>'';
        END IF;
		
	update ldc_osf_estaproc set observacion = '' Periodo: ''||i.pefaano||i.pefames||i.pefacicl where sesion = nutsess and proceso = ''LDC_PROCREPAVC_AUTO'';
	
	commit;
		
    END LOOP;

    -- se muestra log de final del proceso
    nuerror := 5;
    sbMensaje :=
           ''Proceso termino Ok. Se procesaron :''
        || TO_CHAR (nucantregis)
        || '' registros'';
    ldc_proactualizaestaprog (nutsess,
                              sbMensaje,
                              ''LDC_PROCREPAVC_AUTO'',
                              ''Ok.'');

                    
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);                      
EXCEPTION
    WHEN OTHERS
    THEN
        ROLLBACK;
        sbMensaje :=
               TO_CHAR (error)
            || '' Error en ldc_procrepavc..lineas error ''
            || TO_CHAR (nuerror)
            || '' ''
            || SQLERRM;
        ldc_proactualizaestaprog (nutsess,
                                  sbMensaje,
                                  ''LDC_PROCREPAVC_AUTO'',
                                  ''Termino con error.'');

END OSF3092;
    ';
    
    --Inicializa sbBorraObjetos,  procedimiento y cadena de Jobs OSF3092
    sbBorraObjetos := 
    '
    declare
        CURSOR cuValida
        IS
        SELECT  count(*) cantidad
        FROM    USER_SCHEDULER_JOBS
        WHERE   JOB_NAME like ''OSF3092%''
        AND     STATE = ''SUCCEEDED''; 
        
        nuCantidad  number; 
        
        dtfecha date := sysdate+3600/86400;
    begin
        nuCantidad := 0;
        open cuValida;
        fetch cuValida into nuCantidad;
        close cuValida;
        
        if nuCantidad = 1 then
            EXECUTE IMMEDIATE ''DROP PROCEDURE OPEN.OSF3092'';
            dbms_scheduler.drop_job(''OSF3092_1'',TRUE);
            dbms_scheduler.set_attribute
            (
                name                => ''JOBFINALIZA'',
                attribute           => ''END_DATE'',
                value               => dtfecha
            );
            dbms_scheduler.enable(''JOBFINALIZA'');
        end if;

    end;
    ';
    
   
    dbms_output.put_line('Crea procedimiento Open.OSF3092');
    EXECUTE IMMEDIATE sbCreProcedimiento;
    
    dbms_output.put_line('Otorga permisos para procedimiento Open.OSF3092');
    EXECUTE IMMEDIATE 'grant execute on OPEN.OSF3092 to SYSTEM_OBJ_PRIVS_ROLE';
    
    dbms_output.put_line('Programación de Jobs');
    --Gestión de Jobs
    FOR nuHilo IN  1..gnu_TOTAL_HILOS LOOP
        --Crea Job
        begin
            rcUSER_SCHEDULER_JOBS := NULL;
            open cuUSER_SCHEDULER_JOBS('OSF3092_'||nuHilo);
            fetch cuUSER_SCHEDULER_JOBS into rcUSER_SCHEDULER_JOBS;
            close cuUSER_SCHEDULER_JOBS;
            
            IF rcUSER_SCHEDULER_JOBS.job_name is not null then
                IF rcUSER_SCHEDULER_JOBS.state = 'RUNNING' THEN
                    dbms_scheduler.stop_job('OSF3092_'||nuHilo,TRUE);
                END IF;
                dbms_scheduler.drop_job('OSF3092_'||nuHilo,TRUE);
            END IF;
            
            dbms_scheduler.create_job
            (
                job_name            => 'OSF3092_'||nuHilo,
                job_type            => 'STORED_PROCEDURE',
                job_action          => 'OSF3092',
                number_of_arguments => 1,
                start_date          => null,
                repeat_interval     => null,
                end_date            => null,
                enabled             => FALSE,
                auto_drop           => FALSE,
                comments            => 'JOB para ejecución DataFix Refinancia Diferidos Error Hilo '||nuHilo
            );
            
            --Asigna valor a argumento
            dbms_scheduler.set_job_argument_value
            (
                job_name            => 'OSF3092_'||nuHilo,
                argument_position   => 1,
                argument_value      => nuHilo
            );
            
            dbms_scheduler.enable('OSF3092_'||nuHilo);
            dbms_output.put_line('Job programado: OSF3092_'||nuHilo);
            commit;
            
        exception
            when others then
                dbms_output.put_line('Error en la creación del Hilo '||nuHilo||'. Error: '||sqlerrm);
        end;
        
    END LOOP;
    
    dbms_output.put_line('Programación de Job centinela');
    --Creación Job Guardian
    begin
        rcUSER_SCHEDULER_JOBS := NULL;
        open cuUSER_SCHEDULER_JOBS('JOBFINALIZA');
        fetch cuUSER_SCHEDULER_JOBS into rcUSER_SCHEDULER_JOBS;
        close cuUSER_SCHEDULER_JOBS;
        
        IF rcUSER_SCHEDULER_JOBS.job_name is not null then
            IF rcUSER_SCHEDULER_JOBS.state = 'RUNNING' THEN
                dbms_scheduler.stop_job('JOBFINALIZA',TRUE);
            END IF;
            dbms_scheduler.drop_job('JOBFINALIZA',TRUE);
        END IF;
        
        dbms_scheduler.create_job
        (
            job_name            => 'JOBFINALIZA',
            job_type            => 'PLSQL_BLOCK',
            job_action          => sbBorraObjetos,
            number_of_arguments => 0,
            start_date          => SYSDATE,
            repeat_interval     => 'freq=HOURLY',
            --repeat_interval     => 'freq=MINUTELY;interval=1',
            --repeat_interval     => 'freq=secondly;bysecond=10',
            end_date            => SYSDATE+1,
            enabled             => FALSE,
            auto_drop           => TRUE,
            comments            => 'JOB para finalización de ejecucion DataFix OSF3092'
        );
        
        dbms_scheduler.enable('JOBFINALIZA');
        dbms_output.put_line('Job programado: JOBFINALIZA');
        commit;
        
        
    exception
        when others then
            dbms_output.put_line('Error en la creación del finalización OSF2143. Error: '||sqlerrm);
    end;
    
exception
    WHEN pkg_Error.Controlled_Error  THEN
        pkg_error.getError(nuError,sbError);
        dbms_output.put_line('Error controlado sbError => ' || sbError);
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_error.getError(nuError,sbError);
        dbms_output.put_line('Error no controlado sbError => ' || sbError);
end;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/

