column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
/***********************************************************
ELABORADO POR:  Juan Gabriel Catuche Giron
EMPRESA:        MVM Ingenieria de Software
FECHA:          Marzo 2023
JIRA:           OSF-994

Actualiza información de entidad ldc_locunit [LDCLOCUNI]

    
    Archivo de entrada 
    ===================
    NA            
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    
    24/03/2023 - jcatuchemvm
    Creación
    
***********************************************************/
declare
    --Constantes para el datafix
    csbCaso         constant varchar2(20)   := 'OSF994';
    csbTitulo       constant varchar2(2000) := csbCaso||': Actualización unidades por localidad - LDCLOCUNI';
    csbPIPE         constant varchar2( 1 )  := '|';
    cdtFecha        constant date           := ut_date.fdtSysdate;
    csbFormato      constant varchar2( 50 ) := 'dd/mm/yyyy hh24:mi:ss';
    cnuSegundo      constant number         := 1/86400;
    cnuLimit        constant number         := 1000;
    cnuIdErr        constant number         := 1;
    cnuHash         constant number         := 15;
    
    
    type tyrcRegistro is record 
    (
        locunit_id          ldc_locunit.locunit_id%type,
        localidad_id        varchar2(2000), --ldc_locunit.localidad_id%type,
        unioper_id          varchar2(2000), --ldc_locunit.unioper_id%type,
        unioper_id_n        varchar2(2000), --ldc_locunit.unioper_id%type,
        sbActualiza         varchar2(1),
        sbFlag              varchar2(1)
    );
    type tytbRegistro is table of tyrcRegistro index by varchar2(15);    
    tbRegistro      tytbRegistro;
    sbHash          varchar2(15);
    
    type tyTabla is table of varchar2( 2000 ) index by binary_integer;
    
    type tyrcArchivos is record
    (
        cabecera    varchar2(2000),
        nombre      varchar2(50),
        flgprint    varchar2(1),
        tblog       tyTabla
    );
    type tytbArchivos is table of tyrcArchivos index by binary_integer;
    tbArchivos      tytbArchivos;
    nuHash          number;
    
    --Cursores
    cursor cuPrincipal is 
    select locunit_id,
    (select geograp_location_id||'-'||description from ge_geogra_location where geograp_location_id = localidad_id) localidad_id,
    (select operating_unit_id||'-'||name from or_operating_unit where operating_unit_id = unioper_id) unioper_id,
    (select operating_unit_id||'-'||name from or_operating_unit where operating_unit_id = (case unioper_id when 3502 then 119 when 3504 then 120 when 3505 then 121 else unioper_id end) ) unioper_id_n
    from ldc_locunit order by unioper_id,locunit_id
    ;

    type tytbPrincipal is table of cuPrincipal%rowtype index by binary_integer;
    tbPrincipal     tytbPrincipal;
    
    
    nuerror         ge_error_log.message_id%TYPE;
    sberror         ge_error_log.description%TYPE; 
    sbcabecera      varchar2(2000);
    s_out           varchar2(2000);
    nuOuts          number;     
    nuLine          number;
    nuTotal         number;
    nuErr           number;
    nuOk            number;
    nuWrng          number;
    nuContador      number;
    raise_continuar exception;
    sbComentario    varchar2(2000);
    sbUnidad        varchar2(2000);
    sbLocalidad     varchar2(2000);
    sbActualiza     varchar2(1);
    
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
        
        nuLine      := 0;
        nuTotal     := 0;
        nuErr       := 0;    
        nuOk        := 0;  
        nuWrng      := 0;  
        nuContador  := 0;
        tbRegistro.delete;
        tbPrincipal.delete;
        tbArchivos.delete; 
        
        sbActualiza := 'N';

        --tbArchivos(1).nombrearch    := csbCaso||'_'||to_char(cdtFecha,csbformatos)||'_Log.txt';
        --tbArchivos(2).nombrearch    := csbCaso||'_'||to_char(cdtFecha,csbformatos)||'_Poblacion.txt';
        
        
        tbArchivos(1).nombre  := '--Log';
        tbArchivos(2).nombre  := '--Población';
        
        tbArchivos(1).flgprint  := 'S';
        tbArchivos(2).flgprint  := 'S';
       
        nuOuts := tbArchivos.last;
        
        sbCabecera := 'Localidad|Unidad|Mensaje|Error'; 
        tbArchivos(cnuIdErr).cabecera := sbCabecera;
        
        sbCabecera := 'Consecutivo|Localidad|Unidad_ant|Unidad_act|Actualizado';
        tbArchivos(2).cabecera := sbCabecera;
        
        dbms_output.put_line(csbTitulo);
        
        
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
    
    PROCEDURE pIniciaLog IS
    BEGIN
        for i in tbArchivos.first .. nuOuts loop
            if i >= cnuIdErr then
                pGuardaLog(tbArchivos(i),tbArchivos(i).cabecera);
            end if;
        end loop;        
    END pIniciaLog;
    
    PROCEDURE pCerrarLog IS
    BEGIN
        pGuardaLog(tbArchivos(cnuIdErr),'================================================');
        pGuardaLog(tbArchivos(cnuIdErr),'Finaliza la actualización '||csbCaso||'.' );
        pGuardaLog(tbArchivos(cnuIdErr),'Total de localidades detectadas : '||nuLine);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de localidades almacenadas : '||nuTotal);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de localidades gestionadas : '||nuOk);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de Advertencias : '||nuWrng);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de Errores : '||nuErr);
        pGuardaLog(tbArchivos(cnuIdErr),'Rango Total de Ejecución ['||to_char(cdtFecha,'dd/mm/yyyy')||']['||to_char(cdtFecha,'hh24:mi:ss')||' - '||to_char(ut_date.fdtSysdate,'hh24:mi:ss')||']');
        pGuardaLog(tbArchivos(cnuIdErr),'Tiempo Total de Ejecución ['||fnc_rs_CalculaTiempo(cdtFecha,ut_date.fdtSysdate)||']');
        
        pEsbribelog();
        
    END pCerrarLog;
    
    PROCEDURE pCerrarLogE IS
    BEGIN
        -- Indica que termin� el proceso en el archivo de salida
        pGuardaLog(tbArchivos(cnuIdErr),'================================================');
        pGuardaLog(tbArchivos(cnuIdErr),'Finaliza la actualización con Error '||csbCaso||': ' ||sqlerrm );
        pGuardaLog(tbArchivos(cnuIdErr),'Total de localidades detectadas : '||nuLine);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de localidades almacenadas : '||nuTotal);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de localidades gestionadas : '||nuOk);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de Advertencias : '||nuWrng);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de Errores : '||nuErr);
        pGuardaLog(tbArchivos(cnuIdErr),'Rango Total de Ejecución ['||to_char(cdtFecha,'dd/mm/yyyy')||']['||to_char(cdtFecha,'hh24:mi:ss')||' - '||to_char(ut_date.fdtSysdate,'hh24:mi:ss')||']');
        pGuardaLog(tbArchivos(cnuIdErr),'Tiempo Total de Ejecución ['||fnc_rs_CalculaTiempo(cdtFecha,ut_date.fdtSysdate)||']');
        
        pEsbribelog();
        
    END pCerrarLogE;
    
    PROCEDURE pGeneraciondeRastro is
        rcRegistro  tyrcRegistro;
    begin
        
        sbHash := tbRegistro.first;
        loop
            begin
                rcRegistro := tbRegistro(sbHash);
                sbLocalidad := rcRegistro.localidad_id;
                sbUnidad := rcRegistro.unioper_id;
                
                s_out := rcRegistro.locunit_id;
                s_out := s_out||'|'||rcRegistro.localidad_id;
                s_out := s_out||'|'||rcRegistro.unioper_id;
                s_out := s_out||'|'||rcRegistro.unioper_id_n;
                s_out := s_out||'|'||sbActualiza;

                pGuardaLog(tbArchivos(2),s_out);
                
                                
            exception
                when raise_continuar then
                    pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
                    nuErr := nuErr + 1;  
                when others then
                    sberror := sqlerrm;
                    --pkerrors.geterrorvar (nuerror, sberror);
                    sbComentario := 'Error 3.1|'||sbLocalidad||'|'||sbUnidad||
                    '|Error particular en impresión de información|'||sberror;
                    pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
                    nuErr := nuErr + 1;  
            end;
            
            sbHash := tbRegistro.next(sbHash);
            exit when sbHash is null;
        end loop;
        
    exception
        when others then
            sberror := sqlerrm;
            --pkerrors.geterrorvar (nuError, sberror);
            sbComentario := 'Error 3.0|'||sbLocalidad||'|'||sbUnidad||
            '|Error desconocido en impresión de información|'||sberror;
            pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
            nuErr := nuErr + 1;            
    END pGeneraciondeRastro;
    
    PROCEDURE pActualizaDatos is
    
    begin
        sbLocalidad     := null;
        sbUnidad          := null; 
        
        MERGE INTO ldc_locunit A USING
        (
            select locunit_id,unioper_id, (case unioper_id when 3502 then 119 when 3504 then 120 when 3505 then 121 else unioper_id end) unioper_new_id 
            from ldc_locunit
        ) B
        ON (A.locunit_id = B.locunit_id)
        WHEN MATCHED THEN
        UPDATE SET 
            A.unioper_id = B.unioper_new_id
        ;
              
        nuOk := sql%rowcount;  
        
        if nuOk > 0 then
            sbActualiza := 'S';
            pkGeneralServices.CommitTransaction;
        end if;
        
    exception 
        when raise_continuar then
            rollback;
            raise;
        when EX.CONTROLLED_ERROR then
            pkerrors.geterrorvar( nuerror, sberror );
            sbComentario := 'Error 2.2|'||sbLocalidad||'|'||sbUnidad||
            '|Error Controlado|'||nuerror||'-'||sberror;
            rollback;
            raise raise_continuar;
        when others then
            Errors.Seterror;
            pkerrors.geterrorvar( nuerror, sberror );
            sbComentario := 'Error 2.3|'||sbLocalidad||'|'||sbUnidad||
            '|Error No Controlado|'||nuerror||'-'||sberror;
            rollback; 
            raise raise_continuar;
    END pActualizaDatos; 
    
    PROCEDURE pAnalizaDatos is
        rcRegistro  tyrcRegistro;
    BEGIN
        sbLocalidad     := null;
        sbUnidad          := null; 

        sbHash := tbRegistro.first;
        if sbHash is null then
            sbComentario := 'Error 1.1|'||sbLocalidad||'|'||sbUnidad||
            '|Sin Localidades para actualizar|NA';
            raise raise_continuar;
        end if;

        pActualizaDatos();
            
        pGeneraciondeRastro(); 
        
    
    exception
        when raise_continuar then
            pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
            nuErr := nuErr + 1;  
    end pAnalizaDatos;
    
    PROCEDURE pLecturaDatos IS
    begin
        sbLocalidad     := null;
        sbUnidad          := null; 

        --nuPivote := 1;
        open cuPrincipal;
        loop
            tbPrincipal.delete;
            fetch cuPrincipal bulk collect into tbPrincipal limit cnuLimit;
            exit when tbPrincipal.count = 0; 

            for i in 1..tbPrincipal.count loop 
                begin
                    nuLine := nuLine+ 1;
                    sbLocalidad := tbPrincipal(i).localidad_id;
                    sbUnidad := tbPrincipal(i).unioper_id;
                                          
                    sbHash := lpad(tbPrincipal(i).locunit_id,cnuHash,'0');
                    
                    if not tbRegistro.exists(sbHash) then
    
                        tbRegistro(sbHash).locunit_id     := tbPrincipal(i).locunit_id;
                        tbRegistro(sbHash).localidad_id   := sbLocalidad;
                        tbRegistro(sbHash).unioper_id     := sbUnidad;
                        tbRegistro(sbHash).unioper_id_n   := tbPrincipal(i).unioper_id_n;
                        tbRegistro(sbHash).sbActualiza  := 'N';
                        tbRegistro(sbHash).sbFlag       := 'N';
                        
                         nuTotal := nuTotal + 1;

                    else
                        sbComentario := 'Error 0.1|'||sbLocalidad||'|'||sbUnidad||
                        '|Consecutivo unidad por localidad ya existe|NA';
                        raise raise_continuar;
                        
                    end if; 

                exception
                    when raise_continuar then
                        pGuardaLog(tbArchivos(cnuIdErr),sbComentario); 
                        nuErr := nuErr + 1;
                        tbRegistro(sbHash).sbFlag := 'S';
                    when others then
                        sberror := sqlerrm;
                        --pkerrors.geterrorvar (nuerror, sberror);
                        sbComentario := 'Error 0.0|'||sbLocalidad||'|'||sbUnidad||
                        '|Error desconocido en generación de datos de poblacion|'||sberror;
                        pGuardaLog(tbArchivos(cnuIdErr),sbComentario); 
                        nuErr := nuErr + 1;
                        tbRegistro(sbHash).sbFlag := 'S';
                end;
            end loop; 

            --nuPivote := tbLecManual(tbLecManual.last).sesunuse;
            exit when tbPrincipal.count < cnuLimit; 
        end loop;
        close cuPrincipal;
        
        
        sbHash := tbRegistro.first;
        if sbHash is not null then
            loop
                if tbRegistro(sbHash).sbFlag = 'S' then
                    tbRegistro.delete(sbHash);
                    nuTotal := nuTotal - 1;
                end if;
                sbHash := tbRegistro.next(sbHash);
                exit when sbHash is null;
            end loop;
        end if;

    exception
        when others then
            nuErr := nuErr + 1;
            raise;
    END pLecturaDatos;

begin
    pInicializar(); 
    pIniciaLog(); 
    pLecturaDatos(); 
    pAnalizaDatos(); 
    pCerrarLog(); 
    
exception
    when others then
        pCerrarLogE();
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/