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
JIRA:           OSF-968

Corrige solicitudes de ajustes facturación por valor erradas, en donde existe tanto la 
nota y los cargos definitivos, como los pendientes de aprobación.
Se eliminan los cargos y notas pendientes, se atiende la solicitud y se notifica el flujo,
[fa_apromofa, fa_notaapro, fa_cargapro]

    
    Archivo de entrada 
    ===================
    NA            
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    
    16/03/2023 - jcatuchemvm
    Creación
    
***********************************************************/
declare
    --Constantes para el datafix
    csbCaso         constant varchar2(20)   := 'OSF968';
    cnuPackage_id   constant MO_WF_PACK_INTERFAC.package_id%TYPE := 174559837;
    csbTitulo       constant varchar2(2000) := csbCaso||': Corrección solicitudes 289-Aprobacion de Ajustes de Facturación';
    csbPIPE         constant varchar2( 1 )  := '|';
    cdtFecha        constant date           := ut_date.fdtSysdate;
    csbFormato      constant varchar2( 50 ) := 'dd/mm/yyyy hh24:mi:ss';
    cnuSegundo      constant number         := 1/86400;
    cnuLimit        constant number         := 1000;
    cnuIdErr        constant number         := 1;
    cnuHash         constant number         := 15;
    
    --Tipos de Registro
    type tyrcNotas is record 
    (
        noapnume            fa_notaapro.noapnume%type,
        noapsusc            fa_notaapro.noapsusc%type,
        noapdoso            fa_notaapro.noapdoso%type,
        noapfact            fa_notaapro.noapfact%type,
        caapvalo            fa_cargapro.caapvalo%type,
        notanume            notas.notanume%type,
        notasusc            notas.notasusc%type,
        notadoso            notas.notadoso%type,
        notafact            notas.notafact%type,
        cargvalo            cargos.cargvalo%type
    );
    type tytbNotas is table of tyrcNotas index by binary_integer;
    
    type tyrcRegistro is record 
    (
        apmocons            fa_apromofa.apmocons%type,
        apmosoli            fa_apromofa.apmosoli%type,
        apmofere            fa_apromofa.apmofere%type,
        apmousre            fa_apromofa.apmousre%type,
        apmovalo            fa_apromofa.apmovalo%type,
        caapvalo_t          fa_apromofa.apmovalo%type,
        cargvalo_t          fa_apromofa.apmovalo%type,
        apmoesaf            fa_apromofa.apmoesaf%type,
        status              mo_packages.motive_status_id%type,
        attention_date      mo_packages.attention_date%type,
        apmoesaf_n          fa_apromofa.apmoesaf%type,
        status_n            mo_packages.motive_status_id%type,
        attention_date_n    mo_packages.attention_date%type,
        cantlect            number,
        tbNotas             tytbNotas,
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
    select a.*,
    sum(cargvalo) over (partition by apmocons) cargvalo_total,
    sum(caapvalo) over (partition by apmocons) caapvalo_total,
    (select count(*) from fa_lectelma where leeaapmo = apmocons) cant_lecturas,
    rank() over (partition by a.apmocons order by apmosoli) marca_  from
    (
        select apmocons,apmosoli,apmousre,apmofere,apmovalo,apmoesaf,motive_status_id,attention_date,noapapmo,noapnume,noapsusc,noapdoso,noapfact,notanume,notasusc,notadoso,notafact,
        nvl((select sum(decode(caapsign,'CR',-caapvalo,caapvalo)) from fa_cargapro where caapnoap = noapnume),0) caapvalo,
        nvl((select sum(decode(cargsign,'CR',-cargvalo,cargvalo)) from cargos where cargdoso = notadoso),0) cargvalo
        from notas, fa_notaapro,FA_Apromofa ,mo_packages p
        where notanume = noapnume
        and apmocons = noapapmo
        and apmocons = notaapmo
        and apmosoli = package_id
        and motive_status_id = 13
        and package_id = cnuPackage_id
    ) a
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
    nuNots          number;
    nuSols          number;
    nuErr           number;
    nuOk            number;
    nuWrng          number;
    nuContador      number;
    raise_continuar exception;
    sbComentario    varchar2(2000);
    nuSolicitud     number;
    nuNota          number;
    
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
        nuNots      := 0;
        nuSols      := 0;
        nuErr       := 0;    
        nuOk        := 0;  
        nuWrng      := 0;  
        nuContador  := 0;
        tbRegistro.delete;
        tbPrincipal.delete;
        tbArchivos.delete; 

        --tbArchivos(1).nombrearch    := csbCaso||'_'||to_char(cdtFecha,csbformatos)||'_Log.txt';
        --tbArchivos(2).nombrearch    := csbCaso||'_'||to_char(cdtFecha,csbformatos)||'_Poblacion.txt';
        
        
        tbArchivos(1).nombre  := '--Log';
        tbArchivos(2).nombre  := '--Población';
        
        tbArchivos(1).flgprint  := 'S';
        tbArchivos(2).flgprint  := 'S';
       
        nuOuts := tbArchivos.last;
        
        sbCabecera := 'Solicitud|Nota|Mensaje|Error'; 
        tbArchivos(cnuIdErr).cabecera := sbCabecera;
        
        sbCabecera := 'Apmosoli|Apmocons|Apmofere|Apmousre|Apmovalo|Noapnume|Noapsusc|Noapdoso|Noapfact|Caapvalo|Cargvalo|Apmoesaf_ant|Apmoesaf_act|Motive_status_ant|Motive_status_act|Attention_date_ant|Attention_date_act|Actualizado';
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
        pGuardaLog(tbArchivos(cnuIdErr),'Total de solicitudes detectadas : '||nuLine);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de solicitudes almacenadas : '||nuTotal);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de notas almacenadas : '||nuNots);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de solicitudes gestionadas : '||nuOk);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de Advertencias : '||nuWrng);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de Errores : '||nuErr);
        pGuardaLog(tbArchivos(cnuIdErr),'Rango Total de Ejecución ['||to_char(cdtFecha,'dd/mm/yyyy')||']['||to_char(cdtFecha,'hh24:mi:ss')||' - '||to_char(sysdate,'hh24:mi:ss')||']');
        pGuardaLog(tbArchivos(cnuIdErr),'Tiempo Total de Ejecución ['||fnc_rs_CalculaTiempo(cdtFecha,sysdate)||']');
        
        pEsbribelog();
        
    END pCerrarLog;
    
    PROCEDURE pCerrarLogE IS
    BEGIN
        -- Indica que termin� el proceso en el archivo de salida
        pGuardaLog(tbArchivos(cnuIdErr),'================================================');
        pGuardaLog(tbArchivos(cnuIdErr),'Finaliza la actualización con Error '||csbCaso||': ' ||sqlerrm );
        pGuardaLog(tbArchivos(cnuIdErr),'Total de solicitudes detectadas : '||nuLine);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de solicitudes almacenadas : '||nuTotal);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de notas almacenadas : '||nuNots);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de solicitudes gestionadas : '||nuOk);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de Advertencias : '||nuWrng);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de Errores : '||nuErr);
        pGuardaLog(tbArchivos(cnuIdErr),'Rango Total de Ejecución ['||to_char(cdtFecha,'dd/mm/yyyy')||']['||to_char(cdtFecha,'hh24:mi:ss')||' - '||to_char(sysdate,'hh24:mi:ss')||']');
        pGuardaLog(tbArchivos(cnuIdErr),'Tiempo Total de Ejecución ['||fnc_rs_CalculaTiempo(cdtFecha,sysdate)||']');
        
        pEsbribelog();
        
    END pCerrarLogE;
    
    PROCEDURE pGeneraciondeRastro(ircRegistro in out tyrcRegistro) is
    begin
        
        nuNota          := null; 
            
        for nuHash in ircRegistro.tbNotas.first .. ircRegistro.tbNotas.last loop
            
            nuNota := ircRegistro.tbNotas(nuHash).noapnume;
            
            s_out := ircRegistro.apmosoli;
            s_out := s_out||'|'||ircRegistro.apmocons;
            s_out := s_out||'|'||to_char(ircRegistro.apmofere,csbFormato);
            s_out := s_out||'|'||ircRegistro.apmousre;
            s_out := s_out||'|'||ircRegistro.apmovalo;
            s_out := s_out||'|'||ircRegistro.tbNotas(nuHash).noapnume;
            s_out := s_out||'|'||ircRegistro.tbNotas(nuHash).noapsusc;
            s_out := s_out||'|'||ircRegistro.tbNotas(nuHash).noapdoso;
            s_out := s_out||'|'||ircRegistro.tbNotas(nuHash).noapfact;
            s_out := s_out||'|'||ircRegistro.tbNotas(nuHash).caapvalo;
            s_out := s_out||'|'||ircRegistro.tbNotas(nuHash).cargvalo;
            s_out := s_out||'|'||ircRegistro.apmoesaf;
            s_out := s_out||'|'||ircRegistro.apmoesaf_n;
            s_out := s_out||'|'||ircRegistro.status;
            s_out := s_out||'|'||ircRegistro.status_n;
            s_out := s_out||'|'||to_char(ircRegistro.attention_date,csbFormato);
            s_out := s_out||'|'||to_char(ircRegistro.attention_date_n,csbFormato);
            s_out := s_out||'|'||ircRegistro.sbActualiza;

            pGuardaLog(tbArchivos(2),s_out);
            
        end loop;
        
    exception
        when others then
            sberror := sqlerrm;
            --pkerrors.geterrorvar (nuError, sberror);
            sbComentario := 'Error 3.0|'||nuSolicitud||'|'||nuNota||
            '|Error en impresión de información|'||sberror;
            pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
            nuErr := nuErr + 1;            
    END pGeneraciondeRastro;
    
    PROCEDURE pActualizaDatos(ircRegistro in out tyrcRegistro) is
    
        cursor cusoli (inupack in mo_packages.package_id%type) is
        select apmosoli,apmoesaf,motive_status_id,attention_date
        from fa_apromofa, mo_packages
        where apmosoli = package_id
        and apmosoli = inupack;
        
        rcsoli      cusoli%rowtype;
        
        cursor cuPackInter (inupack in mo_packages.package_id%type) is
        select m.*,m.rowid  
        from Mo_Wf_Pack_Interfac m
        where package_id = inupack
        and status_activity_id = 4;
        
        rcPackInter     Damo_Wf_Pack_Interfac.Stymo_Wf_Pack_Interfac;  
        sbMask          Sa_User.Mask%TYPE;
        
    begin
        sbMask := null;
        nuNota := null;
        --Para solicitudes con varias notas, se procesa solo la solicitud
        if ircRegistro.sbActualiza = 'N' then
            --Inicializa variables de error
            mo_boutilities.initializeoutput(nuerror,sberror);
            rcPackInter := null;
            
            open cuPackInter (nuSolicitud);
            fetch cuPackInter into rcPackInter;
            close cuPackInter;
            
            if rcPackInter.package_id is null then
                sbComentario := 'Error 2.1|'||nuSolicitud||'|'||nuNota||
                '|La solicitud se encuentra en un estado diferente a pendiente de reenvío|NA';
                raise raise_continuar;
            end if;
            
            --Borrado de cargos pendientes
            FA_BCCARGAPRO.DELCHARGESTOAPPROVE(ircRegistro.apmocons);
            --Borrado de notas pendientes.
            FA_BCNOTAAPRO.DELNOTESTOAPPROVE(ircRegistro.apmocons);
            
            --Obtiene el usuario para la atencion
            sbMask := Fa_Bcuibilladjconsread.Fsbapproveduserorder(nuSolicitud);
            if sbMask is null then
                sbMask := ircRegistro.apmousre;
            end if;
            --Actualiza el estado de la solicitud pendiente 
            Fa_Bcapromofa.Updstate(ircRegistro.apmocons,sbMask,cdtFecha,Fa_Bcapromofa.Csbstat_Approved);
            --Asigna causal de salida para WF
            rcPackInter.causal_id_output  := Mo_Bocausal.Fnugetsuccess;
            --Envia la respuesta a WF
            Wf_Boanswer_Receptor.Answerreceptor(rcPackInter.Activity_Id,rcPackInter.Causal_Id_Output);
            DBMS_LOCK.SLEEP(10);
            --Actualiza la actividad de reenvio manual
            rcPackInter.Executor_Log_Id := null; 
            rcPackInter.Status_Activity_Id := Mo_Bostatusparameter.Fnugetsta_Activ_Finish;
            rcPackInter.Attendance_Date := cdtFecha;
            --Actualiza el record
            Damo_Wf_Pack_Interfac.Updrecord(rcPackInter);
            
            pkGeneralServices.CommitTransaction;
            
            rcsoli := null;
            open cusoli(nuSolicitud);
            fetch cusoli into rcsoli;
            close cusoli;
            
            ircRegistro.attention_date_n := rcsoli.attention_date;
            ircRegistro.apmoesaf_n := rcsoli.apmoesaf;
            ircRegistro.status_n := rcsoli.motive_status_id;
            ircRegistro.sbActualiza := 'S';
            
            nuOk := nuOk + 1;
            
        end if;
        
        
        
    exception 
        when raise_continuar then
            rollback;
            raise;
        when EX.CONTROLLED_ERROR then
            pkerrors.geterrorvar( nuerror, sberror );
            sbComentario := 'Error 2.2|'||nuSolicitud||'|'||nuNota||
            '|Error Controlado|'||nuerror||'-'||sberror;
            rollback;
            raise raise_continuar;
        when others then
            Errors.Seterror;
            pkerrors.geterrorvar( nuerror, sberror );
            sbComentario := 'Error 2.3|'||nuSolicitud||'|'||nuNota||
            '|Error No Controlado|'||nuerror||'-'||sberror;
            rollback; 
            raise raise_continuar;
    END pActualizaDatos; 
    
    PROCEDURE pAnalizaDatos is
        rcRegistro  tyrcRegistro;
    BEGIN
        nuSolicitud     := null;
        nuNota          := null; 

        sbHash := tbRegistro.first;
        if sbHash is null then
            sbComentario := 'Error 1.1|'||nuSolicitud||'|'||nuNota||
            '|Sin solicitudes pendientes para análisis|NA';
            raise raise_continuar;
        end if;

        loop
            begin
                rcRegistro := tbRegistro(sbHash);
                nuSolicitud := rcRegistro.apmosoli;
                -- Evalua estado solicitud fa_apromofa
                if rcRegistro.apmoesaf != 'P' then
                    sbComentario := 'Error 1.2|'||nuSolicitud||'|'||nuNota||
                    '|El estado de la solicitud no es pendiente ['||rcRegistro.apmoesaf||']|NA';
                    raise raise_continuar;
                end if;
                
                --Evalua los totales de la solicitud, cargos y cargos temporales
                if (rcRegistro.apmovalo != rcRegistro.caapvalo_t) or (rcRegistro.apmovalo != rcRegistro.cargvalo_t) then
                    sbComentario := 'Error 1.3|'||nuSolicitud||'|'||nuNota||
                    '|El total de la solicitud difiere del total de los cargos o los cargos pendientes ['||rcRegistro.apmovalo||']['||rcRegistro.cargvalo_t||'-'||rcRegistro.caapvalo_t||']|NA';
                    raise raise_continuar;
                end if;
                
                --Evalua que la solicitud sea de ajustes a valor
                if rcRegistro.cantlect > 0 then
                    sbComentario := 'Error 1.4|'||nuSolicitud||'|'||nuNota||
                    '|La solicitud de ajuste es de lecturas y consumos, no aplica para gestión ajustes por valor ['||rcRegistro.cantlect||']|NA';
                    raise raise_continuar;
                end if;
                
                nuHash := rcRegistro.tbNotas.first;
                if nuHash is null then
                    sbComentario := 'Error 1.5|'||nuSolicitud||'|'||nuNota||
                    '|La solicitud no tiene registros de notas|NA';
                    raise raise_continuar;
                end if;
                
                for i in rcRegistro.tbNotas.first .. rcRegistro.tbNotas.last loop
                    nuHash := i;
                    nuNota := rcRegistro.tbNotas(nuHash).noapnume;
                    --Evalua que exsista la nota y la nota pendiente
                    if rcRegistro.tbNotas(nuHash).notanume != nuNota then
                        sbComentario := 'Error 1.6|'||nuSolicitud||'|'||nuNota||
                        '|El número de la nota pendiente y la nota registrada difieren ['||nuNota||'-'||rcRegistro.tbNotas(nuHash).notanume||']|NA';
                        raise raise_continuar;
                    end if;
                    
                    --Evalua correspondencia del contrato
                    if rcRegistro.tbNotas(nuHash).notasusc != rcRegistro.tbNotas(nuHash).noapsusc then
                        sbComentario := 'Error 1.7|'||nuSolicitud||'|'||nuNota||
                        '|El contrato de la nota pendiente y la registrada difieren ['||rcRegistro.tbNotas(nuHash).noapsusc||'-'||rcRegistro.tbNotas(nuHash).notasusc||']|NA';
                        raise raise_continuar;
                    end if;
                    
                    --Evalua correspondencia del documento de soporte
                    if rcRegistro.tbNotas(nuHash).notadoso != rcRegistro.tbNotas(nuHash).noapdoso then
                        sbComentario := 'Error 1.8|'||nuSolicitud||'|'||nuNota||
                        '|El documento de soporte de la nota pendiente y la registrada difieren  ['||rcRegistro.tbNotas(nuHash).noapdoso||'-'||rcRegistro.tbNotas(nuHash).notadoso||']|NA';
                        raise raise_continuar;
                    end if;
                    
                    --Evalua correspondencia de la factura
                    if rcRegistro.tbNotas(nuHash).notafact != rcRegistro.tbNotas(nuHash).noapfact then
                        sbComentario := 'Error 1.9|'||nuSolicitud||'|'||nuNota||
                        '|La factura de la nota pendiente y la registrada difieren  ['||rcRegistro.tbNotas(nuHash).noapfact||'-'||rcRegistro.tbNotas(nuHash).notafact||']|NA';
                        raise raise_continuar;
                    end if;
                end loop;
                
                pActualizaDatos(tbRegistro(sbHash));
                                
            exception
                when raise_continuar then
                    pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
                    nuErr := nuErr + 1;  
                when others then
                    sberror := sqlerrm;
                    --pkerrors.geterrorvar (nuerror, sberror);
                    sbComentario := 'Error 1.0|'||nuSolicitud||'|'||nuNota||
                    '|Error desconocido en analisis de registros|'||sberror;
                    pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
                    nuErr := nuErr + 1;  
            end;
            
            pGeneraciondeRastro(tbRegistro(sbHash)); 
            
            sbHash := tbRegistro.next(sbHash);
            exit when sbHash is null;
        end loop;
        
        
    
    exception
        when raise_continuar then
            pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
            nuErr := nuErr + 1;  
    end pAnalizaDatos;
    
    PROCEDURE pLecturaDatos IS
    begin
        nuSolicitud     := null;
        nuNota          := null; 

        --nuPivote := 1;
        open cuPrincipal;
        loop
            tbPrincipal.delete;
            fetch cuPrincipal bulk collect into tbPrincipal limit cnuLimit;
            exit when tbPrincipal.count = 0; 

            for i in 1..tbPrincipal.count loop 
                begin
                    nuLine := nuLine+ 1;
                    nuSolicitud := tbPrincipal(i).apmosoli;
                    nuNota := tbPrincipal(i).noapnume;
                                          
                    sbHash := lpad(nuSolicitud,cnuHash,'0');
                    
                    if not tbRegistro.exists(sbHash) then
    
                        tbRegistro(sbHash).apmocons     := tbPrincipal(i).apmocons;
                        tbRegistro(sbHash).apmosoli     := nuSolicitud;
                        tbRegistro(sbHash).apmofere     := tbPrincipal(i).apmofere;
                        tbRegistro(sbHash).apmousre     := tbPrincipal(i).apmousre;
                        tbRegistro(sbHash).apmovalo     := tbPrincipal(i).apmovalo;
                        tbRegistro(sbHash).caapvalo_t   := tbPrincipal(i).caapvalo_total;
                        tbRegistro(sbHash).cargvalo_t   := tbPrincipal(i).cargvalo_total;
                        tbRegistro(sbHash).apmoesaf     := tbPrincipal(i).apmoesaf;
                        tbRegistro(sbHash).status       := tbPrincipal(i).motive_status_id;
                        tbRegistro(sbHash).attention_date   := tbPrincipal(i).attention_date;
                        tbRegistro(sbHash).cantlect     := tbPrincipal(i).cant_lecturas;
                        tbRegistro(sbHash).sbActualiza  := 'N';
                        tbRegistro(sbHash).sbFlag       := 'N';
                        
                        nuHash := 1;
                        tbRegistro(sbHash).tbNotas(nuHash).noapnume := nuNota;
                        tbRegistro(sbHash).tbNotas(nuHash).noapsusc := tbPrincipal(i).noapsusc;
                        tbRegistro(sbHash).tbNotas(nuHash).noapdoso := tbPrincipal(i).noapdoso;
                        tbRegistro(sbHash).tbNotas(nuHash).noapfact := tbPrincipal(i).noapfact;
                        tbRegistro(sbHash).tbNotas(nuHash).caapvalo := tbPrincipal(i).caapvalo;
                        tbRegistro(sbHash).tbNotas(nuHash).notanume := tbPrincipal(i).notanume;
                        tbRegistro(sbHash).tbNotas(nuHash).notasusc := tbPrincipal(i).notasusc;
                        tbRegistro(sbHash).tbNotas(nuHash).notadoso := tbPrincipal(i).notadoso;
                        tbRegistro(sbHash).tbNotas(nuHash).notafact := tbPrincipal(i).notafact;
                        tbRegistro(sbHash).tbNotas(nuHash).cargvalo := tbPrincipal(i).cargvalo;
                        
                        nuNots := nuNots + 1;
                        nuTotal := nuTotal + 1;

                    else
                        nuHash := tbRegistro(sbHash).tbNotas.last + 1;
                        tbRegistro(sbHash).tbNotas(nuHash).noapnume := nuNota;
                        tbRegistro(sbHash).tbNotas(nuHash).noapsusc := tbPrincipal(i).noapsusc;
                        tbRegistro(sbHash).tbNotas(nuHash).noapdoso := tbPrincipal(i).noapdoso;
                        tbRegistro(sbHash).tbNotas(nuHash).noapfact := tbPrincipal(i).noapfact;
                        tbRegistro(sbHash).tbNotas(nuHash).caapvalo := tbPrincipal(i).caapvalo;
                        tbRegistro(sbHash).tbNotas(nuHash).notanume := tbPrincipal(i).notanume;
                        tbRegistro(sbHash).tbNotas(nuHash).notasusc := tbPrincipal(i).notasusc;
                        tbRegistro(sbHash).tbNotas(nuHash).notadoso := tbPrincipal(i).notadoso;
                        tbRegistro(sbHash).tbNotas(nuHash).notafact := tbPrincipal(i).notafact;
                        tbRegistro(sbHash).tbNotas(nuHash).cargvalo := tbPrincipal(i).cargvalo;
                        
                        nuNots := nuNots + 1;
                        
                    end if; 

                exception
                    when others then
                        sberror := sqlerrm;
                        --pkerrors.geterrorvar (nuerror, sberror);
                        sbComentario := 'Error 0.0|'||nuSolicitud||'|'||nuNota||
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