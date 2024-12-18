column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
/***********************************************************
ELABORADO POR:  Juan Gabriel Catuche Giron
EMPRESA:        MVM Ingenieria de Software
FECHA:          Mayo 2023
JIRA:           OSF-1145

Actualiza actividad de suspensión en pr_producto para generación de orden de reconexión por seguridad
Tramite 100343-Reconexion por Seguridad. Por error en tiempos de atención la suspensión por pago fue
legalizada después de la suspensión por seguridad. La reconexión por seguridad requiere que la última 
suspensión fuese de seguridad
    
    Archivo de entrada 
    ===================
    NA            
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    26/05/2023 - jcatuchemvm
    Creación
    
***********************************************************/
declare
    --Constantes para el datafix
    csbCaso         constant varchar2(20)   := 'OSF-1145';
    cnuProduct      constant pr_product.product_id%TYPE := 50328544;
    cnuTaskSusSeg   constant or_task_type.task_type_id%TYPE := 11214;
    csbTitulo       constant varchar2(2000) := csbCaso||': Actualiza actividad de suspensión en pr_product';
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
        producto            servsusc.sesunuse%type,
        tipoprod            servsusc.sesuserv%type,
        motivo              mo_motive.motive_id%type,
        solicitud           mo_packages.package_id%type,
        fechasol            mo_packages.request_date%type,
        actividad           or_order_activity.order_activity_id%type,
        actividad_act       or_order_activity.order_activity_id%type,
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
    select p.product_id,p.product_type_id,p.suspen_ord_act_id,m.motive_id,m.package_id,m.TAG_NAME,m.MOTIV_RECORDING_DATE,
    (
        select unique first_value(order_activity_id) over (order by order_activity_id desc) 
        from or_order_activity t
        where t.product_id = p.product_id    
        and t.task_Type_id = cnuTaskSusSeg
        and status = 'F'
    ) order_activity_id
    from pr_product p, mo_motive m, PS_MOTIVE_STATUS s
    where p.product_id = cnuProduct
    and p.PRODUCT_ID = m.PRODUCT_ID
    and m.motive_status_id = s.motive_status_id
    and s.is_final_status = 'N'
    and m.tag_name = 'M_GENER_RECONVOL'
    and not exists
    (
        select 'x' 
        from or_order_activity a
        where a.product_id = p.product_id
        and a.package_id = m.package_id
    );

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
    nuProducto      number;
    
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

        --tbArchivos(1).nombrearch    := csbCaso||'_'||to_char(cdtFecha,csbformatos)||'_Log.txt';
        --tbArchivos(2).nombrearch    := csbCaso||'_'||to_char(cdtFecha,csbformatos)||'_Poblacion.txt';
        
        
        tbArchivos(1).nombre  := '--Log';
        tbArchivos(2).nombre  := '--Población';
        
        tbArchivos(1).flgprint  := 'S';
        tbArchivos(2).flgprint  := 'S';
       
        nuOuts := tbArchivos.last;
        
        sbCabecera := 'Solicitud|Mensaje|Error'; 
        tbArchivos(cnuIdErr).cabecera := sbCabecera;
        
        sbCabecera := 'Producto|Tipo|Motivo|Paquete|FechaCreacion|Actividad_ant|Actividad_act|Actualizado';
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
        pGuardaLog(tbArchivos(cnuIdErr),'Total de productos detectadas : '||nuLine);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de productos almacenadas : '||nuTotal);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de productos actualizados : '||nuOk);
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
        pGuardaLog(tbArchivos(cnuIdErr),'Total de productos detectadas : '||nuLine);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de productos almacenadas : '||nuTotal);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de productos actualizados : '||nuOk);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de Advertencias : '||nuWrng);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de Errores : '||nuErr);
        pGuardaLog(tbArchivos(cnuIdErr),'Rango Total de Ejecución ['||to_char(cdtFecha,'dd/mm/yyyy')||']['||to_char(cdtFecha,'hh24:mi:ss')||' - '||to_char(ut_date.fdtSysdate,'hh24:mi:ss')||']');
        pGuardaLog(tbArchivos(cnuIdErr),'Tiempo Total de Ejecución ['||fnc_rs_CalculaTiempo(cdtFecha,ut_date.fdtSysdate)||']');
        
        pEsbribelog();
        
    END pCerrarLogE;
    
    PROCEDURE pGeneraciondeRastro(ircRegistro in out tyrcRegistro) is
    begin
        s_out := nuProducto;
        s_out := s_out||'|'||ircRegistro.tipoprod;
        s_out := s_out||'|'||ircRegistro.motivo;
        s_out := s_out||'|'||ircRegistro.solicitud;
        s_out := s_out||'|'||to_char(ircRegistro.fechasol,csbFormato);        
        s_out := s_out||'|'||ircRegistro.actividad;
        s_out := s_out||'|'||ircRegistro.actividad_act;
        s_out := s_out||'|'||ircRegistro.sbActualiza;

        pGuardaLog(tbArchivos(2),s_out);
        
    exception
        when others then
            sberror := sqlerrm;
            --pkerrors.geterrorvar (nuError, sberror);
            sbComentario := 'Error 3.0|'||nuProducto||
            '|Error en impresión de información|'||sberror;
            pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
            nuErr := nuErr + 1;            
    END pGeneraciondeRastro;
    
    PROCEDURE pActualizaDatos(ircRegistro in out tyrcRegistro) is
        nuRowCount number;
    begin
        --Inicializa variables de error
        mo_boutilities.initializeoutput(nuerror,sberror);
        
        if ircRegistro.actividad_act is null then
            sbComentario := 'Error 2.1|'||nuProducto||
            '|No existe actividad previa de suspensión por seguridad|NA';
            RAISE raise_continuar;
        elsif ircRegistro.actividad = ircRegistro.actividad_act then
            sbComentario := 'Wrng 2.1|'||nuProducto||
            '|La actividad de suspensión reciente corresponde a una de suspensión de seguridad |NA';
            RAISE raise_continuar;
        end if;
        
        update pr_product
        set suspen_ord_act_id = ircRegistro.actividad_act
        where product_id = nuProducto; 
        
        nuRowCount := sql%rowcount;  
        
        if nuRowCount > 0 then
            ircRegistro.sbActualiza := 'S';
            nuOk := nuOk + 1;
            pkGeneralServices.CommitTransaction;
        end if;
        
    exception 
        when raise_continuar then
            rollback;
            raise;
        when EX.CONTROLLED_ERROR then
            pkerrors.geterrorvar( nuerror, sberror );
            sbComentario := 'Error 2.2|'||nuProducto||
            '|Error Controlado|'||nuerror||'-'||sberror;
            rollback;
            raise raise_continuar;
        when others then
            Errors.Seterror;
            pkerrors.geterrorvar( nuerror, sberror );
            sbComentario := 'Error 2.3|'||nuProducto||
            '|Error No Controlado|'||nuerror||'-'||sberror;
            rollback; 
            raise raise_continuar;
    END pActualizaDatos; 
    
    PROCEDURE pAnalizaDatos is
       
    BEGIN
        nuProducto     := null;
        
        sbHash := tbRegistro.first;
        if sbHash is null then
            sbComentario := 'Error 1.1|'||nuProducto||
            '|Sin productos para analizar|NA';
            raise raise_continuar;
        end if;

        loop
            begin
                nuProducto := tbRegistro(sbHash).producto;
                pActualizaDatos(tbRegistro(sbHash));
                                
            exception
                when raise_continuar then
                    pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
                    nuErr := nuErr + 1;  
                when others then
                    sberror := sqlerrm;
                    --pkerrors.geterrorvar (nuerror, sberror);
                    sbComentario := 'Error 1.0|'||nuProducto||
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
        nuProducto     := null;
        
        --nuPivote := 1; mo_packages
        open cuPrincipal;
        loop
            tbPrincipal.delete;
            fetch cuPrincipal bulk collect into tbPrincipal limit cnuLimit;
            exit when tbPrincipal.count = 0; 

            for i in 1..tbPrincipal.count loop 
                begin
                    nuLine := nuLine+ 1;
                    nuProducto := tbPrincipal(i).product_id;
                                          
                    sbHash := lpad(nuProducto,cnuHash,'0');
                    
                    if not tbRegistro.exists(sbHash) then
    
                        tbRegistro(sbHash).producto     := nuProducto;
                        tbRegistro(sbHash).tipoprod     := tbPrincipal(i).product_type_id;
                        tbRegistro(sbHash).motivo       := tbPrincipal(i).motive_id;
                        tbRegistro(sbHash).solicitud    := tbPrincipal(i).package_id;
                        tbRegistro(sbHash).fechasol     := tbPrincipal(i).motiv_recording_date;
                        tbRegistro(sbHash).actividad     := tbPrincipal(i).suspen_ord_act_id;
                        tbRegistro(sbHash).actividad_act := tbPrincipal(i).order_activity_id;
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
                        sbComentario := 'Error 0.0|'||nuProducto||
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