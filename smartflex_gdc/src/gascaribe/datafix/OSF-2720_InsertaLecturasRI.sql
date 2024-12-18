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
DEFINE CASO=OSF-2720

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
JIRA:           OSF-2720

Descripción

    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    20/05/2024 - jcatuchemvm
    Creación
    
***********************************************************/
DECLARE
    csbCaso             constant varchar2(20)   := 'OSF2720';
    csbTitulo           constant varchar2(2000) := csbCaso||': Inserta lecturas de Retiro e Instalación por error desinversión medidor';
    csbFormato          constant varchar2(25)   := 'DD/MM/YYYY HH24:MI:SS';
    cnuSegundo          constant number         := 1/86400;
    cnuLimit            constant number         := 1000;
    cnuIdErr            constant number         := 1;
    cdtFecha            constant date           := sysdate;
    
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
    
    cursor cudata is
    with base as
    (
        select sesususc,sesunuse,sesuserv,sesuesco,sesucate,sesusuca,sesucicl,sesucico,pefacodi,pefames,pefaano,pefafimo,pefaffmo,
        emsselme,emsscoem,emssfein,emssfere,
        (select cmssidco from compsesu where cmsssesu = sesunuse and cmsstcom = 7039 and cmssclse = 3102 and cmssescm = 5 and rownum = 1 ) cmssidco,
        row_number() over (partition by sesunuse order by emssfere desc) row_num,
        nvl((select 'S' from lectelme where leemsesu = sesunuse and ((leemclec = 'R' and leempefa = 110431) or (leemclec = 'I' and leempefa = 110799))),'N') flag
        from servsusc,elmesesu,perifact
        where sesususc in ( 48253445,48252457)
        and emsssesu = sesunuse 
        and pefacicl =  sesucicl
        and pefaactu =  'S'
        order by sesunuse,emssfein
    )
    select * from base 
    where row_num = 1
    ;
    
    cursor culectura (inucons1 in number, inucons2 in number) is 
    select leemsesu,LEEMELME,(select elmecodi from elemmedi where elmeidem = leemelme) leemcodi,pefaano,pefames,pefacicl,LEEMPEFA,LEEMOBLE,LEEMFELE,LEEMLETO,LEEMFELA,LEEMLEAN,LEEMDOCU,LEEMCMSS,LEEMCONS,LEEMPECS,LEEMPETL,LEEMCLEC,LEEMOBSB,LEEMOBSC,leemtcon
    from lectelme,perifact
    where leempefa = pefacodi
    and leemcons in (inucons1,inucons2);



    
    function fnuGetLeemcons(inuleemcons in number,inuorden in number default 0) return number is
    
        cursor culect is
        select * from lectelme where leemcons > inuleemcons
        order by leemcons;
        
        cursor culectR is
        select * from lectelme where leemcons < inuleemcons
        order by leemcons desc;
        
        nucons  number;
        s_out   varchar2(2000);
    begin
        nucons := inuleemcons;
         
        if inuorden = 0 then
            for rc in culect loop
                if rc.leemcons != nucons +1 then
                   --dbms_output.put_line('Consecutivo'||nucons +1); 
                   return nucons+1;
                end if;
                nucons := rc.leemcons;
            end loop;
        else 
            for rc in culectR loop
                if rc.leemcons != nucons -1 then
                   --dbms_output.put_line('Consecutivo'||nucons +1); 
                   return nucons-1;
                end if;
                nucons := rc.leemcons;
            end loop;
        end if;
    end;

    
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
        nuerr       := 0;
        
        tbArchivos.delete; 

        
        tbArchivos(1).nombre  := '--Log';
        tbArchivos(2).nombre  := '--Población';
        
        tbArchivos(1).flgprint  := 'S';
        tbArchivos(2).flgprint  := 'S';
       
        nuOuts := tbArchivos.last;
        
        sbCabecera := 'TipoError|Medidor|Mensaje|Error'; 
        tbArchivos(cnuIdErr).cabecera := sbCabecera;
        
        sbCabecera := 'Producto|IdElemento|Elemento|Periodo|Año|Mes|Ciclo|leemfele|leemleto|leemfela|leemlean|leemdocu|leemcmss|leemcons|leempecs|leemclec';
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
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de lecturas insertadas: '||nuok);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de errores: '||nuerr);  
        pGuardaLog(tbArchivos(cnuIdErr),'Rango Total de Ejecución ['||to_char(cdtFecha,'dd/mm/yyyy')||']['||to_char(cdtFecha,'hh24:mi:ss')||' - '||to_char(sysdate,'hh24:mi:ss')||']');
        pGuardaLog(tbArchivos(cnuIdErr),'Tiempo Total de Ejecución ['||fnc_rs_CalculaTiempo(cdtFecha,sysdate)||']');
        
        pEsbribelog();
        
    END pCerrarLog;
    
    PROCEDURE pCerrarLogE IS
    BEGIN
        pGuardaLog(tbArchivos(cnuIdErr),'================================================');
        pGuardaLog(tbArchivos(cnuIdErr),'Finaliza gestión con Error ' ||csbCaso||': '||sqlerrm );
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de lecturas insertadas: '||nuok);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de errores: '||nuerr);  
        pGuardaLog(tbArchivos(cnuIdErr),'Rango Total de Ejecución ['||to_char(cdtFecha,'dd/mm/yyyy')||']['||to_char(cdtFecha,'hh24:mi:ss')||' - '||to_char(sysdate,'hh24:mi:ss')||']');
        pGuardaLog(tbArchivos(cnuIdErr),'Tiempo Total de Ejecución ['||fnc_rs_CalculaTiempo(cdtFecha,sysdate)||']');
        
        pEsbribelog();
        
    END pCerrarLogE;
    
    PROCEDURE pGestionCaso  IS
        nuconsret   number;
        nuconsins   number;
    BEGIN    
        
        for rd in cudata loop
            begin 
                if rd.flag = 'S' then 
                    sbComentario := 'Error 1.2|'||rd.emsscoem||'|Lectura ya insertada|NA';
                    raise raise_continuar;
                elsif ((rd.sesunuse = 50771273 and rd.emsscoem = 'K-2912425-14') or (rd.sesunuse = 50764601 and rd.emsscoem = 'K-2975386-15')) then
                
                    if rd.sesunuse = 50771273 then
                    
                        --Inserción Retiro
                        nuconsret := fnuGetLeemcons(139819872,1);
                        insert into lectelme(leemcons,leemsesu,leemelme,leemtcon,leempefa,leempecs,leemleto,leemfele,leemfela,leemlean,leemdocu,leemclec,leempetl,leemcmss)
                        values
                        (nuconsret,rd.sesunuse,2011109,1,110431,110370,554,to_date('09/02/2024 13:02:55',csbFormato),to_date('20/01/2024 06:21:07',csbFormato),554,null,'R',20344,rd.cmssidco); 
                        
                        nuRowcount := sql%rowcount;
                    
                        if nuRowcount != 1 then
                            sbComentario := 'Error 1.3|'||rd.emsscoem||'|Inserción de lectura de retiro diferente a la esperada ['||nuRowcount||']'||'|NA';
                            raise raise_continuar;
                        end if;
                        
                        --Actualización lectura anterior siguiente lectura de facturación después del cambio
                        update lectelme
                        set leemlean = 554
                        where leemcons = 139990300
                        and leemsesu = rd.sesunuse;
                        
                        nuok := nuok + 1;
                    elsif rd.sesunuse = 50764601 then 
                        
                        --Inserción Instalación
                        nuconsins := fnuGetLeemcons(139819871);
                        insert into lectelme(leemcons,leemsesu,leemelme,leemtcon,leempefa,leempecs,leemleto,leemfele,leemfela,leemlean,leemdocu,leemclec,leempetl,leemcmss)
                        values
                        (nuconsins,rd.sesunuse,2011109,1,110799,110738,2920,to_date('09/02/2024 13:02:57',csbFormato),to_date('09/02/2024 13:02:56',csbFormato),554,null,'I',20344,rd.cmssidco); 
                        
                        nuRowcount := sql%rowcount;
                    
                        if nuRowcount != 1 then
                            sbComentario := 'Error 1.4|'||rd.emsscoem||'|Inserción de lectura de instalación diferente a la esperada ['||nuRowcount||']'||'|NA';
                            raise raise_continuar;
                        end if;
                        
                        --Actualización fecha lectura anterior siguiente lectura de facturación después del cambio
                        update lectelme
                        set leemfela = to_date('09/02/2024 13:02:57',csbFormato),
                        leemlean = 2920
                        where leemcons = 140785425
                        and leemsesu = rd.sesunuse;
                        
                        nuok := nuok + 1;
                        
                    end if;
                else
                    sbComentario := 'Error 1.5|'||rd.emsscoem||'|Medidor sin gestión de desinversión para el producto '||rd.sesunuse||'|NA';
                    raise raise_continuar;
                end if;
                
            exception
                when raise_continuar then
                    raise raise_continuar;
                when others then
                    pkg_error.geterror(nuerror,sberror);
                    sbComentario := 'Error 1.1|'||rd.emsscoem||'|Error inserción de lecturas|'||sberror;
                    raise raise_continuar;
            end;
            
        end loop;
        
        commit;
        
        --Lecturas 
        for rc in culectura(nuconsret,nuconsins) loop
            s_out := rc.leemsesu;
            s_out := s_out||'|'||rc.leemelme;
            s_out := s_out||'|'||rc.leemcodi;
            s_out := s_out||'|'||rc.leempefa;
            s_out := s_out||'|'||rc.pefaano;
            s_out := s_out||'|'||rc.pefames;
            s_out := s_out||'|'||rc.pefacicl;
            s_out := s_out||'|'||to_char(rc.leemfele,csbformato);
            s_out := s_out||'|'||rc.leemleto;
            s_out := s_out||'|'||to_char(rc.leemfela,csbformato);
            s_out := s_out||'|'||rc.leemlean;
            s_out := s_out||'|'||rc.leemdocu;
            s_out := s_out||'|'||rc.leemcmss;
            s_out := s_out||'|'||rc.leemcons;
            s_out := s_out||'|'||rc.leempecs;
            s_out := s_out||'|'||rc.leemclec;
            
            pGuardaLog(tbArchivos(2),s_out);
            
        end loop;
        
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
