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
DEFINE CASO=OSF-3035

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
FECHA:          Julio 2024 
JIRA:           OSF-3035

Descripción

    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    30/07/2024 - jcatuchemvm
    Creación
    
***********************************************************/
DECLARE
    csbCaso             constant varchar2(20)   := 'OSF3035';
    csbTitulo           constant varchar2(2000) := csbCaso||': Ajuste movidifes errados por error en insolvencia';
    csbFormato          constant varchar2(25)   := 'DD/MM/YYYY HH24:MI:SS';
    csbFormatoL         constant varchar2(25)   := 'DDMMYYYY_HH24MI';
    cnuSegundo          constant number         := 1/86400;
    cnuLimit            constant number         := 1000;
    cnuIdErr            constant number         := 1;
    cdtFecha            constant date           := sysdate;
    csbOutPut           constant varchar2(1)    := 'S';
    csbRepoinco         constant varchar2(1)    := 'N'; --N no, S si, A ambos 
    csbEscritura        constant varchar2( 1 )  := 'w';
    csbLectura          constant varchar2( 1 )  := 'r';
    cnucausal           constant number         := 48;
    csbprograma         constant varchar2(25)   := '290';
    
    type tyTabla is table of varchar2( 2000 ) index by binary_integer;
    type tyrcArchivos is record
    (
        cabecera    varchar2(2000),
        nombre      varchar2(50),
        tipoarch    varchar2(1),
        flgprint    varchar2(1),
        flFile      utl_file.file_type,
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
    nuIdReporte         number;
    nuConsecutivo       number;
    nuErr               number;
    nuok                number;
    numov               number;
    nutmov              number;
    nuwrng              number;
    nucont              number;
    nucont1             number;
    nuRowcount          number;
    raise_continuar     exception;
    sbRuta              parametr.pamechar%type;   
    s_out               varchar2(2000);
    s_out2              varchar2(2000);
    s_outm              varchar2(2000);
    nudiferido          number;
    
    
    cursor cudata is
    with data_ as
    (
        select difecodi,difenuse,difesusc,difeconc,difesign,difevatd,difevacu,difenucu,difecupa,difefein,difecoin,difepldi,difesape,difefumo,
        (select min(modifech) from movidife where modidife = difecodi and modidoso = 'INSV-'||difecodi) modifech_min,
        (select max(modifech) from movidife where modidife = difecodi and modidoso = 'INSV-'||difecodi) modifech_max 
        from diferido
        where difecodi in 
        (
            90993232,
            90993233,
            100308583,
            100308584,
            101969545,
            101969546
        )
    )
    select difecodi,difenuse,difesusc,difeconc,difesign,difevatd,difevacu,difenucu,difecupa,difefein,difefumo,difecoin,difepldi,modifech_min,modifech_max,difesape,
    (select sum(case modisign when 'CR' then -modivacu else modivacu end) from movidife where modidife = difecodi) modisape,
    (select sum(case modisign when 'CR' then -modivacu else modivacu end) from movidife where modidife = difecodi and modifech <= modifech_min) saldoIns,
    (select sum(case modisign when 'CR' then -modivacu else modivacu end) from movidife where modidife = difecodi and modifech > modifech_min) saldoErr
    from data_ d
    --where d.modifech_min = d.modifech_max
    order by difenuse,difecodi;
    
    
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
    
    function fnuGetReporte(isbNombreApli IN VARCHAR2, isbObservacion IN VARCHAR2)
    return number
    IS
      PRAGMA AUTONOMOUS_TRANSACTION;
        rcRecord Reportes%rowtype;
    BEGIN
        -- Fill record
        rcRecord.REPOAPLI := isbNombreApli;
        rcRecord.REPOFECH := cdtFecha;
        rcRecord.REPOUSER := Pkg_Session.Getuser;
        rcRecord.REPODESC := isbObservacion;
        rcRecord.REPOSTEJ := null;
        rcRecord.REPONUME :=  seq.getnext('SQ_REPORTES');

        -- Insert record
        pktblReportes.insRecord(rcRecord);
        COMMIT;
        return rcRecord.Reponume;
    END;
    
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
        sbRuta := '/smartfiles/tmp';
        
        nucont      := 0;
        nucont1     := 0;
        nuok        := 0;
        nuerr       := 0;
        nutmov      := 0;
        
        tbArchivos.delete; 

        
        tbArchivos(1).nombre  := csbCaso||'_'||to_char(cdtFecha,csbFormatoL)||'_Log.txt';
        tbArchivos(2).nombre  := csbCaso||'_'||to_char(cdtFecha,csbFormatoL)||'_Poblacion.txt';
        tbArchivos(3).nombre  := csbCaso||'_'||to_char(cdtFecha,csbFormatoL)||'_Movidifes.txt';
        
        tbArchivos(1).flgprint  := 'S';
        tbArchivos(2).flgprint  := 'S';
        tbArchivos(3).flgprint  := 'S';
        
        tbArchivos(1).tipoarch :=  csbEscritura;
        tbArchivos(2).tipoarch :=  csbEscritura;
        tbArchivos(3).tipoarch :=  csbEscritura;
       
        nuOuts := tbArchivos.last;
        
        sbCabecera := 'TipoError|Diferido|Mensaje|Error'; 
        tbArchivos(cnuIdErr).cabecera := sbCabecera;
        
        sbCabecera := 'Diferido|Producto|Contrato|Concepto|Valor|Cuotas|Fecha|CobrosError|CuotasPag_ant|CuotasPag_act|FechaUltima_ant|FechaUltima_act|Saldo_ant|Saldo_act|Gestión';
        tbArchivos(2).cabecera := sbCabecera;
        
        sbCabecera := 'Diferido|Producto|Fecha|Cuota|Signo|Valor|Prog|Doso|Codo|Gestión';
        tbArchivos(3).cabecera := sbCabecera;
        
        dbms_output.put_line(csbTitulo);
        dbms_output.put_line('================================================');
        
        if csbRepoinco in ('S','A') then
            nuIdReporte := fnuGetReporte(csbCaso,csbTitulo);
            nuConsecutivo := 0;
        end if;
        
        
    END pInicializar;
    
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
    
    Procedure pEscritura (ircArchivos  in out tyrcArchivos, sbMensaje  in varchar2) IS
    Begin 
        If csbOutPut = 'S' THEN 
            pCustomOutput(sbMensaje); 
        Else
            Utl_file.put_line(ircArchivos.flFile,sbMensaje,TRUE);
            Utl_file.fflush(ircArchivos.flFile);
        End if;
    exception
        when others then
        sbComentario := 'Error escritura archivo - '||sqlerrm;
        raise;  
    END pEscritura;
    
    Procedure pGuardaLog (ircArchivos  in out tyrcArchivos, sbMensaje  in varchar2) IS
        nuidxlog    binary_integer;
    Begin 
        
        if ircArchivos.tblog.last is null then
            nuidxlog := 1;
        else
            nuidxlog := ircArchivos.tblog.last + 1;
        end if;
                
               
        If csbOutPut = 'S' THEN 
            if ircArchivos.flgprint = 'S' then                
                ircArchivos.tblog(nuidxlog) := sbMensaje;                
            end if;
        Else
            pEscritura(ircArchivos,sbMensaje);
        End if;
        
        
    exception
        when others then
            sbComentario := 'Error almacenamiento de log';
            raise raise_continuar;  
    END pGuardaLog;
    
    Procedure pOpen(inuOut in number) IS
    Begin
        if csbOutPut != 'S' then
            tbArchivos(inuOut).flFile := utl_file.fopen(sbRuta, tbArchivos(inuOut).nombre, tbArchivos(inuOut).tipoarch);
        end if;
    exception
        when others then
            raise;    
    End pOpen;
    
    PROCEDURE pIniciaLog IS
    BEGIN
        for i in tbArchivos.first .. nuOuts loop
            begin   
                pOpen(i);                    
                if i >= cnuIdErr then
                    pGuardaLog(tbArchivos(i),tbArchivos(i).cabecera);
                end if;
            exception
                when utl_file.invalid_operation then
                    if utl_file.is_open( tbArchivos(cnuIdErr).flFile ) then
                        sbComentario := 'Error -1||Error en operacion "'||tbArchivos(i).tipoarch||
                        '" para el archivo "'||tbArchivos(i).nombre||'" en la ruta "'||sbRuta||'"|'||sqlerrm;
                        pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
                        raise;
                    else
                        dbms_output.put_line('Error -1||Error no controlado en apertura de archivo '||tbArchivos(i).nombre||' ['||tbArchivos(i).tipoarch||']|'||sqlerrm);  
                        raise;
                    end if;
            end;                   
        end loop;        
    END pIniciaLog;
    
    PROCEDURE prReporte(ircArchivos  in out tyrcArchivos)
    IS
       PRAGMA AUTONOMOUS_TRANSACTION;
        -- Variables
        rcRepoinco repoinco%rowtype;
    BEGIN
        nuConsecutivo := nuConsecutivo +1;
        rcRepoinco.reinrepo := nuIdReporte;
        rcRepoinco.reincodi := nuConsecutivo;
        rcRepoinco.reinobse := ircArchivos.nombre;
        -- Insert record
        pktblRepoinco.insrecord(rcRepoinco);        
        
        for j in ircArchivos.tblog.first..ircArchivos.tblog.last loop
            nuConsecutivo := nuConsecutivo +1;
            rcRepoinco.reincodi := nuConsecutivo;
            rcRepoinco.reinobse := ircArchivos.tblog(j);
            
            pktblRepoinco.insrecord(rcRepoinco);        
            commit;
        end loop;

        
    EXCEPTION
       WHEN OTHERS THEN
            dbms_output.put_line('Error -2||Error en escritura de log repoinco '||nuIdReporte||'|'||sqlerrm);
    END;
    
    
    Procedure pEsbribelog IS
    Begin        
        for i in reverse 1..nuOuts loop
            if tbArchivos(i).flgprint = 'S' then
                if tbArchivos(i).tblog.first is not null then
                    if csbRepoinco in ('N','A') then
                        pCustomOutput(tbArchivos(i).nombre);
                        for j in tbArchivos(i).tblog.first..tbArchivos(i).tblog.last loop
                            pCustomOutput(tbArchivos(i).tblog(j));
                        end loop;
                    end if;
                    if csbRepoinco in ('S','A') then
                        prReporte(tbArchivos(i));
                    end if;
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
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de diferidos actualizados: '||nuok);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de movimientos insertados: '||nutmov);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de errores: '||nuerr);  
        pGuardaLog(tbArchivos(cnuIdErr),'Rango Total de Ejecución ['||to_char(cdtFecha,'dd/mm/yyyy')||']['||to_char(cdtFecha,'hh24:mi:ss')||' - '||to_char(sysdate,'hh24:mi:ss')||']');
        pGuardaLog(tbArchivos(cnuIdErr),'Tiempo Total de Ejecución ['||fnc_rs_CalculaTiempo(cdtFecha,sysdate)||']');
        
        pEsbribelog();
        
        if csbOutPut != 'S' then
            for i in 0 .. nuOuts loop
                if ( utl_file.is_open( tbArchivos(i).flFile ) ) then
                    utl_file.fclose( tbArchivos(i).flFile );
                end if;
            end loop;
        end if;
        
    END pCerrarLog;
    
    PROCEDURE pCerrarLogE IS
    BEGIN
        pGuardaLog(tbArchivos(cnuIdErr),'================================================');
        pGuardaLog(tbArchivos(cnuIdErr),'Finaliza gestión con Error ' ||csbCaso||': '||sqlerrm );
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de diferidos actualizados: '||nuok);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de movimientos insertados: '||nutmov);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de errores: '||nuerr);  
        pGuardaLog(tbArchivos(cnuIdErr),'Rango Total de Ejecución ['||to_char(cdtFecha,'dd/mm/yyyy')||']['||to_char(cdtFecha,'hh24:mi:ss')||' - '||to_char(sysdate,'hh24:mi:ss')||']');
        pGuardaLog(tbArchivos(cnuIdErr),'Tiempo Total de Ejecución ['||fnc_rs_CalculaTiempo(cdtFecha,sysdate)||']');
        
        pEsbribelog();
        
        if csbOutPut != 'S' then
            for i in 0 .. nuOuts loop
                if ( utl_file.is_open( tbArchivos(i).flFile ) ) then
                    utl_file.fclose( tbArchivos(i).flFile );
                end if;
            end loop;
        end if;
        
    END pCerrarLogE;
    
    PROCEDURE pGestionCaso  IS
        cursor cumovis (inudife in diferido.difecodi%type, inufech in diferido.difefein%type) is
        select modidife,modinuse,modisusc,modifech,modicuap,modisign,modivacu,modidoso,modicaca,modiusua,moditerm,modiprog,modidiin,modipoin,modivain,modicodo 
        from movidife
        where modidife = inudife
        and modifech > inufech
        order by modifech,modicuap;
        
        nusaldo     number;
    BEGIN    
        
        for rd in cudata loop
            begin 
                nudiferido := rd.difecodi;
                s_out2 := null;
                numov := 0;
                
                if rd.difesape = 0 then
                    sbComentario := 'Error 1.1|'||nudiferido||'|El ajuste solo aplica para diferidos con saldo'||'|NA';
                    raise raise_continuar;
                elsif rd.modifech_min != rd.modifech_max then
                    sbComentario := 'Error 1.2|'||nudiferido||'|El diferido tiene registros de más de una insolvencia'||'|NA';
                    raise raise_continuar;
                elsif rd.saldoins != 0 then 
                    sbComentario := 'Error 1.3|'||nudiferido||'|El diferido no fue ajustado en su totalidad por la insolvencia'||'|NA';
                    raise raise_continuar;
                end if;
                
                s_out := nudiferido;
                s_out := s_out||'|'||rd.difenuse;
                s_out := s_out||'|'||rd.difesusc;
                s_out := s_out||'|'||rd.difeconc;
                s_out := s_out||'|'||rd.difevatd;
                s_out := s_out||'|'||rd.difenucu;
                s_out := s_out||'|'||rd.difefein;
                s_out := s_out||'|'||rd.modisape;
                s_out := s_out||'|'||rd.difecupa;
                
                for rm in cumovis(nudiferido,rd.modifech_min) loop
                    if rm.modisign != 'CR' then 
                        sbComentario := 'Error 1.4|'||nudiferido||'|El movimiento a ajustar no es CR ['||rm.modicuap||']'||'|NA';
                        raise raise_continuar;
                    end if;
                    
                    insert into movidife (modidife,modisusc,modisign,modifech,modifeca,modivacu,modidoso,modicaca,modiusua,moditerm,modiprog,modinuse,modipoin,modivain,modicuap,modidiin,modicodo)
                    values
                    (
                        nudiferido,
                        rm.modisusc,
                        case rm.modisign when 'DB' then 'CR' else 'DB' end,
                        cdtFecha,
                        cdtFecha,
                        rm.modivacu,
                        'INSV-'||nudiferido,
                        cnucausal,
                        PKG_SESSION.GETUSER,
                        PKG_SESSION.FSBGETTERMINAL,
                        csbprograma,
                        rm.modinuse,
                        rm.modipoin,
                        rm.modivain,
                        rm.modicuap,
                        rm.modidiin,
                        rm.modicodo
                    );
                    
                    nuRowcount := sql%rowcount;
                
                    if nuRowcount != 1 then
                        sbComentario := 'Error 1.5|'||nudiferido||'|Registro de movimientos de diferidos diferentes a los esperados ['||nuRowcount||']'||'|NA';
                        raise raise_continuar;
                    end if;
                    
                    s_outm := nudiferido;
                    s_outm := s_outm||'|'||rm.modinuse;
                    s_outm := s_outm||'|'||cdtFecha;
                    s_outm := s_outm||'|'||rm.modicuap;
                    s_outm := s_outm||'|'||case rm.modisign when 'DB' then 'CR' else 'DB' end;
                    s_outm := s_outm||'|'||rm.modivacu;
                    s_outm := s_outm||'|'||csbprograma;
                    s_outm := s_outm||'|'||'INSV-'||nudiferido;
                    s_outm := s_outm||'|'||rm.modicodo;
                    s_outm := s_outm||'|Registrado';
                    
                    pGuardaLog(tbArchivos(3),s_outm);
                    
                    numov := numov + 1;
                    
                end loop;
                
                nusaldo := 0;
                select sum(case modisign when 'CR' then -modivacu else modivacu end) into nusaldo from movidife where modidife = nudiferido;
                
                if nusaldo != 0  then
                    sbComentario := 'Error 1.6|'||nudiferido||'|El saldo despuúes del registro de movimientos es diferente de cero ['||nusaldo||']'||'|NA';
                    raise raise_continuar;
                end if;
                
                update diferido
                set difecupa = rd.difenucu,difefumo = cdtFecha, difesape = nusaldo
                where difecodi = nudiferido;
            
                nuRowcount := sql%rowcount;
                
                if nuRowcount != 1 then
                    sbComentario := 'Error 1.7|'||nudiferido||'|Actualización del diferido diferente al esperado ['||nuRowcount||']'||'|NA';
                    raise raise_continuar;
                end if;
                
                s_out2 := rd.difenucu;
                s_out2 := s_out2||'|'||rd.difefumo;
                s_out2 := s_out2||'|'||cdtFecha;
                s_out2 := s_out2||'|'||rd.difesape;
                s_out2 := s_out2||'|'||nusaldo;
                s_out2 := s_out2||'|Actualizado';
                
                pGuardaLog(tbArchivos(2),s_out||'|'||s_out2);
                
                commit;
                
                nuok := nuok + 1;
                nutmov := nutmov + numov;
                           
              
            exception
                when raise_continuar then
                    rollback;       
                    pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
                    nuerr := nuerr + 1; 
                    if s_out2 is null then
                        s_out2 := 'NA';
                        s_out2 := s_out2||'|'||rd.difefumo;
                        s_out2 := s_out2||'|'||'NA';
                        s_out2 := s_out2||'|'||rd.difesape;
                        s_out2 := s_out2||'|'||'NA';
                        s_out2 := s_out2||'|No Actualizado';
                        
                        pGuardaLog(tbArchivos(2),s_out||'|'||s_out2);
                    end if;
                when others then
                    pkg_error.seterror;
                    pkg_error.geterror(nuerror,sberror);
                    sbComentario := 'Error 1.4|'||nudiferido||'|Error desconocido en gestión del diferido|'||sberror;
                    rollback;
                    pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
                    nuerr := nuerr + 1; 
                    if s_out2 is null then
                        s_out2 := 'NA';
                        s_out2 := s_out2||'|'||rd.difefumo;
                        s_out2 := s_out2||'|'||'NA';
                        s_out2 := s_out2||'|'||rd.difesape;
                        s_out2 := s_out2||'|'||'NA';
                        s_out2 := s_out2||'|No Actualizado';
                        
                        pGuardaLog(tbArchivos(2),s_out||'|'||s_out2);
                    end if;
            end;
            
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
