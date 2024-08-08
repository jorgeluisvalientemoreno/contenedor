declare

    nuorden     or_order.order_id%type;
    nucausal    or_order.causal_id%type;
    nupersonid      number;
    nuactividadot   or_order_activity.order_activity_id%TYPE;
    sbcomentario    varchar2(4000);
    nulecturafinal  number;
    nuActividad     number;
    nuFlag          number;
    
    nurowcount  number;
    
    nuerror     number;
    sberror     varchar2(4000);
    
    sbcadenalegalizacionot   VARCHAR2 (4000);
    dtult_fecha_lect         ldc_cm_lectesp.felectura%TYPE;
    dtfecha_exe_ini          ldc_cm_lectesp.felectura%TYPE;
    
    
begin 
    
        
        ut_trace.Init;
        ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
        ut_trace.SetLevel(99);
        PKGENERALSERVICES.SETTRACEDATAON;
        
        dtfecha_exe_ini := to_date('02/05/2024 10:52:42','dd/mm/yyyy hh24:mi:ss')-1/86400; --fecha inicial ejecucion
        dtult_fecha_lect := to_date('02/05/2024 10:52:42','dd/mm/yyyy hh24:mi:ss');--fecha final ejecucion
        
        nuorden := 323599275;
        nucausal := 9688;
        nupersonid := pkg_bopersonal.fnugetpersonaid; --16504
        nuactividadot := 316484041; --order_activity_id 
        nulecturafinal := 211; --lectura a ingresar 
        nuActividad := 102008; 
        nuFlag := 0;
        sbcomentario :=  '1277;Legalización prueba';
        
        sbcadenalegalizacionot := nuorden
                    || '|'
                    || nucausal
                    || '|'
                    || nupersonid
                    || '|'
                    || ''
                    || '|'
                    || nuactividadot
                    || '>1;READING>'
                    || nulecturafinal
                    || '>>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|'
                    || nuActividad
                    || '>'
                    || nuFlag
                    || '>Y>||'
                    || sbcomentario;
        
        
        api_legalizeOrders
        (
            sbcadenalegalizacionot,
            dtfecha_exe_ini,
            dtult_fecha_lect,
            null, --dtult_fecha_lect,
            nuerror,
            sberror
        );
        
        if nuerror = 0 then
            dbms_output.put_line('Finalizo sin error');
        else
            dbms_output.put_line(concat('Mensaje ',sberror));
        end if;
        
   
end;