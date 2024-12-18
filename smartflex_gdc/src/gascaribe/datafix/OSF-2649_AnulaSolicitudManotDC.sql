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
DEFINE CASO=OSF-2649

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
FECHA:          Mayo 2024 
JIRA:           OSF-2649

Descripción

    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    07/05/2024 - jcatuchemvm
    Creación
    
***********************************************************/
DECLARE
    csbCaso             constant varchar2(20)   := 'OSF2649';
    csbTitulo           constant varchar2(2000) := csbCaso||': Anulación solicitud Manot Debitar Concepto con Financiación';
    csbFormato          constant varchar2(25)   := 'DD/MM/YYYY HH24:MI:SS';
    cnuSegundo          constant number         := 1/86400;
    cnuLimit            constant number         := 1000;
    cnuIdErr            constant number         := 1;
    cdtFecha            constant date           := sysdate;
    cnuPackage          constant number         :=  212945050;
    
    type tyTabla is table of varchar2( 2000 ) index by binary_integer;
    type tyrcArchivos is record
    (
        cabecera    varchar2(2000),
        nombre      varchar2(50),
        flgprint    varchar2(1),
        tblog       tyTabla
    );
    type tytbArchivos is table of tyrcArchivos index by binary_integer;
    tbArchivos          tytbArchivos;
    nuHash              number;
    nuOuts              number;     
    sbError             varchar2(2000);
    nuError             number;
    sbCabecera          varchar2(2000);
    sbComentario        varchar2(2000);
    nuErr               number;
    nuok                number;
    nuwrng              number;
    nucont              number;
    nucont1             number;
    nuRowcount          number;
    raise_continuar     exception;
    s_out               varchar2(2000);
    s_out2              varchar2(2000);
    sbgestion           varchar2(200);
    nunot               number;
    nucrg               number;
    
    
    cursor cudata is
    select a.*,apmocons,apmosoli,apmousre,apmofere,apmousar,apmofear,apmoesaf,apmovalo,apmoprga,
    notanume,notatino,notadoso,cargcuco,cargconc,cargvalo,cargsign,cargdoso,c.rowid row_id
    from ldc_mantenimiento_notas_dif a, Fa_apromofa f,notas,cargos c
    where a.package_id = cnuPackage
    and apmosoli = a.package_id
    and notaapmo = apmocons
    and cargnuse = a.product_id
    and cargconc = a.concepto_id
    and cucocodi = cargcuco
    and cargdoso = a.docsoporte
    order by a.package_id;
    
    
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
    
    PROCEDURE pInicializar IS
    BEGIN
        
        BEGIN
            --EXECUTE IMMEDIATE
            --'alter session set nls_date_format = "dd/mm/yyyy hh24:mi:ss"';
            
            EXECUTE IMMEDIATE 
            'alter session set nls_numeric_characters = ",."';
            
        END;

        dbms_output.enable;
        dbms_output.enable (buffer_size => null);
        
        pkerrors.setapplication(csbCaso);
        
        nucont      := 0;
        nucont1     := 0;
        nuok        := 0;
        nunot       := 0;
        nucrg       := 0;
        nuerr       := 0;
        
        tbArchivos.delete; 

        
        tbArchivos(1).nombre  := '--Log';
        tbArchivos(2).nombre  := '--Población';
        
        tbArchivos(1).flgprint  := 'S';
        tbArchivos(2).flgprint  := 'S';
       
        nuOuts := tbArchivos.last;
        
        sbCabecera := 'TipoError|Solicitud|Mensaje|Error'; 
        tbArchivos(cnuIdErr).cabecera := sbCabecera;
        
        sbCabecera := 'Solicitud|Producto|Cuotas|Plan|Apmoesaf_ant|Apmoesaf_act|Notanume|Notatino|RowId|Cuenta|Cargdoso|Concepto|Cargsign|Cargvalo|Gestion';
        tbArchivos(2).cabecera := sbCabecera;
        
        dbms_output.put_line(csbTitulo);
        dbms_output.put_line('================================================');
        
        
    END pInicializar;
    
    Procedure pGuardaLog (ircArchivos  in out tyrcArchivos, sbMensaje  in varchar2) IS
        nuidxlog    binary_integer;
    Begin 
        
        if ircArchivos.tblog.last is null then
            nuidxlog := 1;
        else
            nuidxlog := ircArchivos.tblog.last + 1;
        end if;
                
        if ircArchivos.flgprint = 'S' then                
            ircArchivos.tblog(nuidxlog) := sbMensaje;                
        end if;
        
    exception
        when others then
            sbComentario := 'Error almacenamiento de log';
            raise raise_continuar;  
    END pGuardaLog;
    
    PROCEDURE pIniciaLog IS
    BEGIN
        for i in tbArchivos.first .. nuOuts loop
            if i >= cnuIdErr then
                pGuardaLog(tbArchivos(i),tbArchivos(i).cabecera);
            end if;
        end loop;        
    END pIniciaLog;
    
    PROCEDURE pCustomOutput(sbDatos in varchar2) is
        loop_count  number default 1;
        string_length number;    
    begin 
        string_length := length (sbDatos);
        
        while loop_count < string_length loop 
            dbms_output.put(substr (sbDatos,loop_count,255));
            --dbms_output.new_line;
            loop_count := loop_count +255;  
        end loop;
        dbms_output.new_line;
    exception
        when others then
        null;                  
    END pCustomOutput;
    
    Procedure pEsbribelog IS
    Begin        
        for i in reverse 1..nuOuts loop
            if tbArchivos(i).flgprint = 'S' then
                if tbArchivos(i).tblog.first is not null then
                    pCustomOutput(tbArchivos(i).nombre);
                    for j in tbArchivos(i).tblog.first..tbArchivos(i).tblog.last loop
                        pCustomOutput(tbArchivos(i).tblog(j));
                    end loop;
                end if;
            end if;           
        end loop;
    exception
        when others then
        dbms_output.put_line(sbComentario); 
    END pEsbribelog;
    
    PROCEDURE pCerrarLog IS
    BEGIN
        
        pGuardaLog(tbArchivos(cnuIdErr),'================================================');
        pGuardaLog(tbArchivos(cnuIdErr),'Finaliza gestión caso '||csbCaso);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de solicitudes anuladas: '||nuok);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de notas eliminadas: '||nunot);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de cargos eliminados: '||nucrg);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de errores: '||nuerr);  
        pGuardaLog(tbArchivos(cnuIdErr),'Rango Total de Ejecución ['||to_char(cdtFecha,'dd/mm/yyyy')||']['||to_char(cdtFecha,'hh24:mi:ss')||' - '||to_char(sysdate,'hh24:mi:ss')||']');
        pGuardaLog(tbArchivos(cnuIdErr),'Tiempo Total de Ejecución ['||fnc_rs_CalculaTiempo(cdtFecha,sysdate)||']');
        
        pEsbribelog();
        
    END pCerrarLog;
    
    PROCEDURE pCerrarLogE IS
    BEGIN
        pGuardaLog(tbArchivos(cnuIdErr),'================================================');
        pGuardaLog(tbArchivos(cnuIdErr),'Finaliza gestión con Error ' ||csbCaso||': '||sqlerrm );
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de notas creadas: '||nuok);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de errores: '||nuerr);  
        pGuardaLog(tbArchivos(cnuIdErr),'Rango Total de Ejecución ['||to_char(cdtFecha,'dd/mm/yyyy')||']['||to_char(cdtFecha,'hh24:mi:ss')||' - '||to_char(sysdate,'hh24:mi:ss')||']');
        pGuardaLog(tbArchivos(cnuIdErr),'Tiempo Total de Ejecución ['||fnc_rs_CalculaTiempo(cdtFecha,sysdate)||']');
        
        pEsbribelog();
        
    END pCerrarLogE;
    
    PROCEDURE pGestionCaso  IS
        nupaquete number;
        nuplan    number;
        
        cursor cuPackInter (inupack in mo_packages.package_id%type) is
        select m.*,m.rowid  
        from Mo_Wf_Pack_Interfac m
        where package_id = inupack
        and status_activity_id = 4;
        
       
    BEGIN    
        nupaquete := 0;
        for rd in cudata loop
            begin 
                nucont := nucont + 1;
                s_out := cnuPackage;
                s_out := s_out||'|'||rd.product_id;
                s_out := s_out||'|'||rd.cuotas;
                s_out := s_out||'|'||rd.plan_dife;
                
                if nupaquete != rd.package_id then
                
                    pkGeneralServices.CommitTransaction;
                    
                    MO_BOANNULMENT.PACKAGEINTTRANSITION(cnuPackage,GE_BOPARAMETER.FNUGET('ANNUL_CAUSAL'));
                    --Actualiza el estado de la solicitud  
                    Fa_Bcapromofa.Updstate(rd.apmocons,PKG_SESSION.GETUSER,cdtFecha,Fa_Bcapromofa.CSBSTAT_REJECTED);
                    
                    --Anula plan 
                    nuplan := null;
                    nuplan := wf_boinstance.fnugetplanid(cnuPackage, 17);
                    if nuplan is not null then
                        WF_BOINSTANCE.UPDANNULPLANSTATUS(nuplan);
                    end if;
                    
                    --Limpia  registro para reenvio de actividades mopwp
                    for rcPackInter in cuPackInter(cnuPackage) loop
                            
                        rcPackInter.causal_id_output  := Mo_Bocausal.Fnugetsuccess;
                        rcPackInter.Executor_Log_Id := null; 
                        rcPackInter.Status_Activity_Id := Mo_Bostatusparameter.Fnugetsta_Activ_Finish;
                        rcPackInter.Attendance_Date := cdtFecha;
                    
                        Damo_Wf_Pack_Interfac.Updrecord(rcPackInter);
                    end loop;
                    
                    s_out2 := rd.apmoesaf;
                    s_out2 := s_out2||'|'||Fa_Bcapromofa.CSBSTAT_REJECTED;
                    
                    sbgestion := 'Anulación de solicitud';
                    
                    pGuardaLog(tbArchivos(2),s_out||'|'||s_out2||'|||||||||'||sbgestion);
                    
                    nuok := nuok +1;
                    
                    delete notas
                    where notanume = rd.notanume;
                    
                    nuRowcount := sql%rowcount;
                
                    if nuRowcount != 1 then
                        sbComentario := 'Error 1.1|'||cnuPackage||'|Borrado de nota diferente a la esperada ['||nuRowcount||']'||'|NA';
                        raise raise_continuar;
                    else
                        sbgestion := 'Nota Eliminada';
                    end if;
                    
                    s_out2 := 'NA';
                    s_out2 := s_out2||'|'||Fa_Bcapromofa.CSBSTAT_REJECTED;
                    s_out2 := s_out2||'|'||rd.notanume;
                    s_out2 := s_out2||'|'||rd.notatino;
                    
                    pGuardaLog(tbArchivos(2),s_out||'|'||s_out2||'|||||||'||sbgestion);
                    
                    nunot := nunot + 1;
                    
                end if;
                
                s_out := s_out||'|NA';
                s_out := s_out||'|'||Fa_Bcapromofa.CSBSTAT_REJECTED;
                s_out := s_out||'|'||rd.notanume;
                s_out := s_out||'|'||rd.notatino;
                s_out := s_out||'|'||rd.row_id;
                s_out := s_out||'|'||rd.cargcuco;
                s_out := s_out||'|'||rd.cargdoso;
                s_out := s_out||'|'||rd.cargconc;
                s_out := s_out||'|'||rd.cargsign;
                s_out := s_out||'|'||rd.cargvalo;
                
                delete cargos c
                where c.rowid = rd.row_id
                and cargnuse = rd.product_id
                and cargcuco = rd.cucocodi
                and cargdoso = rd.cargdoso
                and cargconc = rd.cargconc
                ;
                
                nuRowcount := sql%rowcount;
                
                if nuRowcount != 1 then
                    sbComentario := 'Error 1.2|'||cnuPackage||'|Borrado de cargos diferentes a los esperados ['||nuRowcount||']'||'|NA';
                    raise raise_continuar;
                else
                    sbgestion := 'Cargo borrado';
                end if;
                
                pGuardaLog(tbArchivos(2),s_out||'|'||sbgestion);
                
                nucrg := nucrg + 1;
                           
                nupaquete := rd.package_id;
            exception
                when raise_continuar then
                    raise raise_continuar;
                when others then
                    pkg_error.geterror(nuerror,sberror);
                    sbComentario := 'Error 1.0|'||cnuPackage||'|Error en gestión de solicitud|'||sberror;
                    raise raise_continuar;
            end;
            
           
        end loop;
        
        delete from ldc_mantenimiento_notas_dif where package_id = cnuPackage;
        pkGeneralServices.CommitTransaction;
        
        if nucont = 0 then 
            sbComentario := 'Error 1.3|'||cnuPackage||'|Sin escenario para gestión'||'|NA';
            raise raise_continuar;
        end if;
        
    EXCEPTION
        when raise_continuar then
            rollback;
            pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
            nuerr := nuerr + 1; 
            
    END pGestionCaso;
    
BEGIN

    pInicializar;
    pIniciaLog;
    pGestionCaso;
    pCerrarLog(); 
    
exception
    when others then
        pCerrarLogE();
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
