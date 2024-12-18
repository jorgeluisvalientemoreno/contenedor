column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
/***********************************************************
ELABORADO POR:  Juan Gabriel Catuche Giron
EMPRESA:        MVM Ingenieria de Software
FECHA:          Abril 2023
JIRA:           OSF-1014

Anula solicitues, órdenes y  plan WF de siniestros Brilla
Adecuación script de anulación proporcionado por Edmundo Lara

    
    Archivo de entrada 
    ===================
    NA            
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    
    05/04/2023 - jcatuchemvm
    Creación
    
***********************************************************/
declare
    --Constantes para el datafix
    csbCaso         constant varchar2(20)   := 'OSF-1014';
    cnuPackage_id1  constant MO_WF_PACK_INTERFAC.package_id%TYPE := 198325657;
    cnuPackage_id2  constant MO_WF_PACK_INTERFAC.package_id%TYPE := 198336980;
    csbTitulo       constant varchar2(2000) := csbCaso||': Anula solicitudes 100299-Registro de siniestros Brilla';
    csbcomment      constant varchar2(4000) := 'SE ANULA POR CASO '||csbCaso;
    cnuCommentType  constant number := 83;
    csbPIPE         constant varchar2( 1 )  := '|';
    cdtFecha        constant date           := ut_date.fdtSysdate;
    csbFormato      constant varchar2( 50 ) := 'dd/mm/yyyy hh24:mi:ss';
    cnuSegundo      constant number         := 1/86400;
    cnuLimit        constant number         := 1000;
    cnuIdErr        constant number         := 1;
    cnuHash         constant number         := 15;
    
    
    --Tipos de Registro
    
    
    type tyrcRegistro is record 
    (
        solicitud           mo_packages.package_id%type,
        tiposol             varchar2(2000),
        contrato            suscripc.susccodi%type,
        cliente             suscripc.suscclie%type,
        producto            servsusc.sesunuse%type,
        tipoprod            servsusc.sesuserv%type,
        cant_ordenes        number,
        estado_ant          varchar2(2000),
        estado_act          varchar2(2000),
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
    select /*+ index (m idx_mo_motive_03) use_nl (m p) index (p pk_mo_packages) */
    p.package_id Solicitud,p.package_type_id||'-'||pt.description TipoSolicitud,
    p.motive_status_id||'-'||pe.description EstadoSolicitud,
    (
        select m.subscription_id
        from mo_motive m 
        where m.package_id = p.package_id
        and rownum = 1
    ) Contrato,p.subscriber_id Cliente,
    (
        select m.product_id
        from mo_motive m 
        where m.package_id = p.package_id
        and rownum = 1
    ) Producto,
    (
        select product_type_id 
        from mo_motive m, servsusc 
        where m.package_id = p.package_id
        and m.product_id = sesunuse
        and rownum = 1
    ) TipoProducto,
    (
        select count(*) 
        from or_order_activity a
        where a.package_id = p.package_id
        and a.status = 'R'
    ) cant_ordenes
    from mo_packages p, ps_package_type pt,ps_motive_status pe
    where p.package_id in (cnuPackage_id1,cnuPackage_id2)
    and p.package_type_id = pt.package_type_id
    and p.motive_status_id = pe.motive_status_id
    and p.package_type_id = 100299
    and p.motive_status_id = 13
    order by p.package_id asc;

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
    nuPlanId        wf_instance.instance_id%type;
    
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
        
        sbCabecera := 'Solicitud|Mensaje|Error'; 
        tbArchivos(cnuIdErr).cabecera := sbCabecera;
        
        sbCabecera := 'Solicitud|TipoSol|Contrato|Cliente|Producto|TipoProd|Cant_Ordenes|Estado_ant|Estado_act|Actualizado';
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
        pGuardaLog(tbArchivos(cnuIdErr),'Total de solicitudes gestionadas : '||nuOk);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de Advertencias : '||nuWrng);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de Errores : '||nuErr);
        pGuardaLog(tbArchivos(cnuIdErr),'Rango Total de Ejecución ['||to_char(cdtFecha,'dd/mm/yyyy')||']['||to_char(cdtFecha,'hh24:mi:ss')||' - '||to_char(ut_date.fdtSysdate,'hh24:mi:ss')||']');
        pGuardaLog(tbArchivos(cnuIdErr),'Tiempo Total de Ejecución ['||fnc_rs_CalculaTiempo(cdtFecha,ut_date.fdtSysdate)||']');
        
        pEsbribelog();
        
    END pCerrarLog;
    
    PROCEDURE pCerrarLogE IS
    BEGIN
        -- Indica que terminó el proceso en el archivo de salida
        pGuardaLog(tbArchivos(cnuIdErr),'================================================');
        pGuardaLog(tbArchivos(cnuIdErr),'Finaliza la actualización con Error '||csbCaso||': ' ||sqlerrm );
        pGuardaLog(tbArchivos(cnuIdErr),'Total de solicitudes detectadas : '||nuLine);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de solicitudes almacenadas : '||nuTotal);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de solicitudes gestionadas : '||nuOk);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de Advertencias : '||nuWrng);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de Errores : '||nuErr);
        pGuardaLog(tbArchivos(cnuIdErr),'Rango Total de Ejecución ['||to_char(cdtFecha,'dd/mm/yyyy')||']['||to_char(cdtFecha,'hh24:mi:ss')||' - '||to_char(ut_date.fdtSysdate,'hh24:mi:ss')||']');
        pGuardaLog(tbArchivos(cnuIdErr),'Tiempo Total de Ejecución ['||fnc_rs_CalculaTiempo(cdtFecha,ut_date.fdtSysdate)||']');
        
        pEsbribelog();
        
    END pCerrarLogE;
    
    PROCEDURE pGeneraciondeRastro(ircRegistro in out tyrcRegistro) is
    begin
        s_out := nuSolicitud;
        s_out := s_out||'|'||ircRegistro.tiposol;
        s_out := s_out||'|'||ircRegistro.contrato;
        s_out := s_out||'|'||ircRegistro.cliente;
        s_out := s_out||'|'||ircRegistro.producto;
        s_out := s_out||'|'||ircRegistro.tipoprod;
        s_out := s_out||'|'||ircRegistro.cant_ordenes;
        s_out := s_out||'|'||ircRegistro.estado_ant;
        s_out := s_out||'|'||ircRegistro.estado_act;
        s_out := s_out||'|'||ircRegistro.sbActualiza;

        pGuardaLog(tbArchivos(2),s_out);
        
    exception
        when others then
            sberror := sqlerrm;
            --pkerrors.geterrorvar (nuError, sberror);
            sbComentario := 'Error 3.0|'||nuSolicitud||
            '|Error en impresión de información|'||sberror;
            pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
            nuErr := nuErr + 1;            
    END pGeneraciondeRastro;
    
    PROCEDURE pActualizaDatos(ircRegistro in out tyrcRegistro) is
    
        cursor cusoli (inupack in mo_packages.package_id%type) is
        select p.motive_status_id||'-'||pe.description EstadoSolicitud
        from mo_packages p, ps_motive_status pe
        where p.package_id = inupack
        and p.motive_status_id = pe.motive_status_id
        ;       
        
        rcsoli      cusoli%ROWTYPE;
        
        cursor cuOrdenes(nusol number) is
        select o.order_id, order_status_id, o.operating_unit_id
        from open.or_order o, open.or_order_activity A
        where a.order_id = o.order_id  
        and a.package_id = nusol
        and a.status! = 'F';
        
    begin
        --Inicializa variables de error
        mo_boutilities.initializeoutput(nuerror,sberror);
        
        -- Se obtiene el plan de wf
        Begin        
            nuPlanId := wf_boinstance.fnugetplanid(nuSolicitud, 17);
        Exception
            When Others Then
                sbComentario := 'Wrng 2.1|'||nuSolicitud||
                '|Solicitud no tiene plan asociado|'||sqlcode||'-'||sqlerrm;
                nuWrng := nuWrng +1;
        End;
        ut_trace.trace('Plan WF Siniestros Brilla: '||nuPlanId,10);
        --Anula el Plan WF
        if nuPlanId IS not null then
            begin
                mo_boannulment.annulwfplan(nuPlanId);
            EXCEPTION
            when others then
                pkerrors.geterrorvar(nuerror,sberror);
                sbComentario := 'Error 2.1|'||nuSolicitud||
                '|Error No Controlado en mo_boannulment.annulwfplan ['||nuPlanId||']|'||nuerror||'-'||sberror;
                RAISE raise_continuar;
            END;
        end if;
        
        --Anula la solicitud        
        MO_BOANNULMENT.PACKAGEINTTRANSITION(nuSolicitud,GE_BOPARAMETER.FNUGET('ANNUL_CAUSAL'));
        
        IF ircRegistro.cant_ordenes > 0 THEN
            --Se anulan las ordenes
            --or_boanullorder.anullactivities(nuSolicitud, null, null);
            -- Se anulan las ordenes
            FOR reg in cuOrdenes(nuSolicitud) LOOP

                BEGIN
                    ldc_cancel_order(
                               reg.order_id,
                               3446,
                               csbcomment,
                               cnuCommentType,
                               nuerror,
                               sberror
                               );

                EXCEPTION
                    WHEN OTHERS THEN
                        sbComentario := 'Error 2.1|'||nuSolicitud||
                        '|Error ldc_cancel_order|'||to_char(nuerror)||' - '||sberror;
                    RAISE raise_continuar;
                END;
            END LOOP;
        END IF;
        
        pkGeneralServices.CommitTransaction;
        
       
        rcsoli := null;
        open cusoli(nuSolicitud);
        fetch cusoli into rcsoli;
        close cusoli;
        
        IF ircRegistro.estado_ant != rcsoli.estadosolicitud then
            ircRegistro.estado_act := rcsoli.estadosolicitud;
            ircRegistro.sbActualiza := 'S';        
            nuOk := nuOk + 1;
        else
            ircRegistro.estado_act := ircRegistro.estado_ant;
        end if;
        
    exception 
        when raise_continuar then
            rollback;
            raise;
        when EX.CONTROLLED_ERROR then
            pkerrors.geterrorvar( nuerror, sberror );
            sbComentario := 'Error 2.2|'||nuSolicitud||
            '|Error Controlado|'||nuerror||'-'||sberror;
            rollback;
            raise raise_continuar;
        when others then
            Errors.Seterror;
            pkerrors.geterrorvar( nuerror, sberror );
            sbComentario := 'Error 2.3|'||nuSolicitud||
            '|Error No Controlado|'||nuerror||'-'||sberror;
            rollback; 
            raise raise_continuar;
    END pActualizaDatos; 
    
    PROCEDURE pAnalizaDatos is
       
    BEGIN
        nuSolicitud     := null;
        
        sbHash := tbRegistro.first;
        if sbHash is null then
            sbComentario := 'Error 1.1|'||nuSolicitud||
            '|Sin solicitudes de Siniestros pendientes para anular|NA';
            raise raise_continuar;
        end if;

        loop
            begin
                nuSolicitud := tbRegistro(sbHash).solicitud;
                pActualizaDatos(tbRegistro(sbHash));
                                
            exception
                when raise_continuar then
                    pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
                    nuErr := nuErr + 1;  
                when others then
                    sberror := sqlerrm;
                    --pkerrors.geterrorvar (nuerror, sberror);
                    sbComentario := 'Error 1.0|'||nuSolicitud||
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
        
        --nuPivote := 1; mo_packages
        open cuPrincipal;
        loop
            tbPrincipal.delete;
            fetch cuPrincipal bulk collect into tbPrincipal limit cnuLimit;
            exit when tbPrincipal.count = 0; 

            for i in 1..tbPrincipal.count loop 
                begin
                    nuLine := nuLine+ 1;
                    nuSolicitud := tbPrincipal(i).solicitud;
                                          
                    sbHash := lpad(nuSolicitud,cnuHash,'0');
                    
                    if not tbRegistro.exists(sbHash) then
    
                        tbRegistro(sbHash).solicitud    := nuSolicitud;
                        tbRegistro(sbHash).tiposol      := tbPrincipal(i).tiposolicitud;
                        tbRegistro(sbHash).contrato     := tbPrincipal(i).contrato;
                        tbRegistro(sbHash).cliente      := tbPrincipal(i).cliente;
                        tbRegistro(sbHash).producto     := tbPrincipal(i).producto;
                        tbRegistro(sbHash).tipoprod     := tbPrincipal(i).tipoproducto;
                        tbRegistro(sbHash).cant_ordenes := tbPrincipal(i).cant_ordenes;
                        tbRegistro(sbHash).estado_ant   := tbPrincipal(i).estadosolicitud;
                        tbRegistro(sbHash).sbActualiza  := 'N';
                        tbRegistro(sbHash).sbFlag       := 'N';
                        
                        nuTotal := nuTotal + 1;

                    else
                        tbRegistro(sbHash).sbFlag       := 'S';
                        
                    end if; 

                exception
                    when others then
                        sberror := sqlerrm;
                        --pkerrors.geterrorvar (nuerror, sberror);
                        sbComentario := 'Error 0.0|'||nuSolicitud||
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