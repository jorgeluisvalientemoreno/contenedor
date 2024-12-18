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
DEFINE CASO=OSF-3243

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

-- This is a new line in master / 2

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"
/***********************************************************
ELABORADO POR:  Juan Gabriel Catuche Giron
EMPRESA:        MVM Ingenieria de Software
FECHA:          Octubre YYYY 
JIRA:           OSF-XXXX

Descripción

    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    xx/xx/2024 - jcatuchemvm
    Creación
    
***********************************************************/
DECLARE
    csbCaso             constant varchar2(20)   := 'OSF3243';
    csbTitulo           constant varchar2(2000) := csbCaso||': Anulación soliicutudes de financiación obsoletas y actualzación fecha de cargos';
    csbFormato          constant varchar2(25)   := 'DD/MM/YYYY HH24:MI:SS';
    cdtFecha            constant date           := sysdate;
    cdtFechaCargo       constant date           := to_date('08/04/2024 14:01:27','dd/mm/yyyy hh24:mi:ss');
    
    cursor cudata is
    select * from mo_packages
    where package_id in (214608588,217979311,213464625,213462930)
    and motive_status_id = 13
    ;
    
    cursor cuSoliAdicional (inupackage in number,isbcust_care_reques_num in varchar2) is
    select count(1) 
    from mo_packages
    where CUST_CARE_REQUES_NUM = isbcust_care_reques_num
    and package_id <> inupackage
    and package_type_id <> 268;
    
    cursor cucargos is
    select c.rowid row_id,c.* from cargos c
    where cargcuco = 3058992880
    and cargconc = 145
    order by cargfecr;
    
    
    sberror             varchar2(2000);
    nuerror             number;
    raise_continuar     exception;
    s_out               varchar2(2000);
    sbcabecera          varchar2(2000);
    sbcomentario        varchar2(2000);
    nucontador          number;
    nurowcount          number;
    nuok                number;
    nucrg               number;
    nuerr               number;
    nuPlanId            number;
    nuPlanIdInte        number;
    nuCantSoli          number;
    
    
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
    nucrg      := 0;
    nuerr       := 0;
    
    sbcabecera := 'Solicitud|Fecha|Estado|Error';
    dbms_output.put_line(csbTitulo);
    dbms_output.put_line('================================================');
    dbms_output.put_line(sbcabecera);
    
    begin
           
        for rc in cudata loop
            nucontador := nucontador + 1;
            
            begin 
            
                s_out := rc.package_id;
                s_out := s_out||'|'||rc.request_date;
                s_out := s_out||'|'||rc.motive_status_id;
                
                --Anula solicitud
                pkgManejoSolicitudes.pAnnulRequest(rc.package_id,'Anulación caso '||csbCaso);

                -- Se obtiene el plan de wf
                nuPlanId := null;
                nuPlanId := wf_boinstance.fnugetplanid(rc.package_id, 17);
                 
                -- anula el plan de wf
                IF nuPlanId IS NOT NULL THEN
                    pkgManejoSolicitudes.prcAnulaFlujo(nuPlanId);
                END IF;
                
                pkgManejoSolicitudes.pAnnulErrorFlow(rc.package_id);
       
                --se valida si interaccion solo tiene asociada solicitud actual
                if cuSoliAdicional%isopen then 
                    close cuSoliAdicional;
                end if;
                
                open cuSoliAdicional(rc.package_id,rc.CUST_CARE_REQUES_NUM);
                fetch cuSoliAdicional into nuCantSoli;
                close cuSoliAdicional;
                
                
                IF nuCantSoli = 0 THEN
                    --se anula interaccion
                    pkgManejoSolicitudes.pAnnulRequest(rc.CUST_CARE_REQUES_NUM,'Anulación caso '||csbCaso);
                    
                    -- Se obtiene el plan de wf
                    nuPlanIdInte := null;
                    nuPlanIdInte := wf_boinstance.fnugetplanid(rc.CUST_CARE_REQUES_NUM, 17);
                    
                    -- anula el plan de wf
                    IF nuPlanIdInte IS NOT NULL THEN
                        pkgManejoSolicitudes.prcAnulaFlujo(nuPlanIdInte);
                    END IF;
             
                    pkgManejoSolicitudes.pAnnulErrorFlow(rc.CUST_CARE_REQUES_NUM);
              
                END IF;
                
                s_out := s_out||'|'||'Ok';
                dbms_output.put_line(s_out);
                nuok := nuok + 1;
                
                commit;
            
            exception
                when others then
                    rollback;
                    nuerr := nuerr + 1;
                    pkg_error.seterror;
                    pkg_error.geterror(nuerror,sberror);
                    sbcomentario := 'Error en anulación de solicutud. Error '||sberror;
                    s_out := s_out||'|'||sbcomentario;
                    dbms_output.put_line(s_out);
            end;
            
      
        end loop;
        
        
        if nucontador = 0 then
            sbcomentario := 'Sin datos de solicitudes para gestión';
            nuerr := nuerr + 1;
            s_out  := '||';
            s_out := s_out||'|'||sbcomentario;
            dbms_output.put_line(s_out);
        end if;
        
        sbcabecera := 'Cuenta|Producto|Concepto|Signo|Valor|Documento|Fecha_ant|Fecha_Act|Error';
        dbms_output.put_line('================================================');
        dbms_output.put_line(sbcabecera);
        
        for rc in cucargos loop
            begin
                s_out := rc.cargcuco;
                s_out := s_out||'|'||rc.cargnuse;
                s_out := s_out||'|'||rc.cargconc;
                s_out := s_out||'|'||rc.cargsign;
                s_out := s_out||'|'||rc.cargvalo;
                s_out := s_out||'|'||rc.cargdoso;
                s_out := s_out||'|'||rc.cargfecr;
                
                if rc.cargfecr = cdtFechaCargo then
                    sbcomentario := 'Cargo ya actualizado';
                    s_out := s_out||'|'||rc.cargfecr;
                    raise raise_continuar;
                else
                    --actualiza fecha cargo
                    update cargos c
                    set cargfecr = cdtFechaCargo
                    where c.rowid = rc.row_id
                    and cargnuse = rc.cargnuse
                    and cargcuco = rc.cargcuco
                    and cargdoso = rc.cargdoso
                    and cargconc = rc.cargconc;
                    
                    nuRowcount := sql%rowcount;
                    
                    if nuRowcount != 1 then
                        s_out := s_out||'|'||rc.cargfecr;
                        sbcomentario := 'Actualización de fecha de cargo diferente a la esperada ['||nuRowcount||']';
                        raise raise_continuar;
                    end if;
                    
                    nucrg  := nucrg + 1;
                    s_out := s_out||'|'||cdtFechaCargo;
                    dbms_output.put_line(s_out);
                    
                    commit;
                  
                end if;
            exception
                when raise_continuar then
                    rollback;
                    nuerr := nuerr + 1;
                    s_out := s_out||'|'||sbcomentario;
                    dbms_output.put_line(s_out);
                when others then
                    rollback;
                    nuerr := nuerr + 1;
                    pkg_error.seterror;
                    pkg_error.geterror(nuerror,sberror);
                    sbcomentario := 'Error en actualización de cargos. Error '||sberror;
                    s_out := s_out||'|'||sbcomentario;
                    dbms_output.put_line(s_out);
            end;
        end loop;
    
    exception
        when others then
            rollback;
            nuerr := nuerr + 1;
            sbcomentario := 'Error desconocido: '||sqlerrm;
            s_out  := '||';
            s_out := s_out||'|'||sbcomentario;
            dbms_output.put_line(s_out);
            
    end;
    dbms_output.put_line('================================================');
    dbms_output.put_line('Fin gestión caso '||csbCaso);
    dbms_output.put_line('Cantidad de solicitudes anuladas: '||nuok);
    dbms_output.put_line('Cantidad de cargos actualizados: '||nucrg);
    dbms_output.put_line('Cantidad de errores: '||nuerr);  
    dbms_output.put_line('Rango Total de Ejecución ['||to_char(cdtFecha,'dd/mm/yyyy')||']['||to_char(cdtFecha,'hh24:mi:ss')||' - '||to_char(sysdate,'hh24:mi:ss')||']');
    dbms_output.put_line('Tiempo Total de Ejecución ['||fnc_rs_CalculaTiempo(cdtFecha,sysdate)||']');
END;
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
