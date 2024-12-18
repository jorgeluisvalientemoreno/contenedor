/***********************************************************
ELABORADO POR:  Juan Gabriel Catuche Giron
EMPRESA:        MVM Ingenieria de Software
FECHA:          Octubre 2024 
JIRA:           OSF-3478

Descripción

    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    16/10/2024 - jcatuchemvm
    Creación
    
***********************************************************/
DECLARE
    csbCaso             constant varchar2(20)   := 'OSF3396';
    csbTitulo           constant varchar2(2000) := csbCaso||': Borrado registros descuentos cartera simulados y backup';
    csbFormato          constant varchar2(25)   := 'DD/MM/YYYY HH24:MI:SS';
    cdtFecha            constant date           := sysdate;
    cdtFechaBorr        constant date           := to_date('11/09/2024 02:00:04','dd/mm/yyyy hh24:mi:ss');
    
    sbsentencia         varchar2(2000);
    sberror             varchar2(2000);
    nuerror             number;
    raise_continuar     exception;
    s_out               varchar2(2000);
    sbcabecera          varchar2(2000);
    nucontador          number;
    nurowcount          number;
    nuok                number;
    nuerr               number;
    
    cursor cuvalida is
    SELECT count(*)
    FROM DBA_TABLES
    WHERE TABLE_NAME = 'LDC_DESCAPLI_BKP';
    
    nuconta             number;
    
   
   
    
    
    FUNCTION fnc_rs_CalculaTiempo
    (
        idtFechaIni IN DATE,
        idtFechaFin IN DATE
    )
    RETURN VARCHAR2
    IS
        nuTiempo NUMBER;
        nuHoras NUMBER;
        nuMinutos NUMBER;
        sbRetorno VARCHAR2( 100 );
    BEGIN
        -- Convierte los dias en segundos
        nuTiempo := ( idtFechaFin - idtFechaIni ) * 86400;
        -- Obtiene las horas
        nuHoras := TRUNC( nuTiempo / 3600 );
        -- Publica las horas
        sbRetorno := TO_CHAR( nuHoras ) ||'h ';
        -- Resta las horas para obtener los minutos
        nuTiempo := nuTiempo - ( nuHoras * 3600 );
        -- Obtiene los minutos
        nuMinutos := TRUNC( nuTiempo / 60 );
        -- Publica los minutos
        sbRetorno := sbRetorno ||TO_CHAR( nuMinutos ) ||'m ';
        -- Resta los minutos y obtiene los segundos redondeados a dos decimales
        nuTiempo := TRUNC( nuTiempo - ( nuMinutos * 60 ), 2 );
        -- Publica los segundos
        sbRetorno := sbRetorno ||TO_CHAR( nuTiempo ) ||'s';
        -- Retorna el tiempo
        RETURN( sbRetorno );
    EXCEPTION
        WHEN OTHERS THEN
            -- No se eleva excepcion, pues no es parte fundamental del proceso
            RETURN NULL;
    END fnc_rs_CalculaTiempo;
    
    
    
BEGIN
    nucontador  := 0;
    nuok       := 0;
    nuerr       := 0;
    
    sbcabecera := 'CantidadBorrado|CantidadBackup|Error';
    dbms_output.put_line(csbTitulo);
    dbms_output.put_line('================================================');
    dbms_output.put_line(sbcabecera);
    
    begin
        nuRowcount := 0;
        
        if cuvalida%isopen then
            close cuvalida;
        end if;
        
        open cuvalida;
        fetch cuvalida into nuconta;
        close cuvalida;
        
        if nuconta = 0 then
            --creación tabla backup ref Eliana 
            sbsentencia := 'create table ldc_descapli_bkp as ( select * from ldc_descapli where diferido is not null and fecha > to_date('''||cdtFechaBorr||''',''dd/mm/yyyy HH24:mi:ss'') and diferido != -1 and valor_descuento > 0 )';
        else
            sbsentencia := 'insert into ldc_descapli_bkp select * from ldc_descapli where diferido is not null and fecha > to_date('''||cdtFechaBorr||''',''dd/mm/yyyy HH24:mi:ss'') and diferido != -1 and valor_descuento > 0';
        end if;
        execute immediate sbsentencia;
        
    
        delete ldc_descapli 
        where diferido is not null
        and fecha > cdtFechaBorr
        and diferido != -1
        and valor_descuento > 0;
    
        nuRowcount := sql%rowcount;
        
        commit;
        
        sbsentencia := 'select count(*)  from ldc_descapli_bkp';
        execute immediate sbsentencia into nuconta; 
    
        s_out := nuRowcount||'|'||nuconta||'|Ok';
        dbms_output.put_line(s_out);
        nuok := nuok + nuRowcount;
    
        
        --aplica permisos tabla backup
        pkg_utilidades.prAplicarPermisos('LDC_DESCAPLI_BKP','OPEN'); 
        --crea sinonimos tabla backup
        pkg_utilidades.prCrearSinonimos('LDC_DESCAPLI_BKP','OPEN');
    
    exception
        when others then
            rollback;
            nuerr := nuerr + 1;
            s_out := 0||'|'||sqlerrm;
            dbms_output.put_line(s_out);
            
    end;
    dbms_output.put_line('================================================');
    dbms_output.put_line('Fin gestión caso '||csbCaso);
    dbms_output.put_line('Cantidad de registros borrados: '||nuok);
    dbms_output.put_line('Cantidad de registros guardados: '||nuconta);
    dbms_output.put_line('Cantidad de errores: '||nuerr);  
    dbms_output.put_line('Rango Total de Ejecución ['||to_char(cdtFecha,'dd/mm/yyyy')||']['||to_char(cdtFecha,'hh24:mi:ss')||' - '||to_char(sysdate,'hh24:mi:ss')||']');
    dbms_output.put_line('Tiempo Total de Ejecución ['||fnc_rs_CalculaTiempo(cdtFecha,sysdate)||']');
END;
/