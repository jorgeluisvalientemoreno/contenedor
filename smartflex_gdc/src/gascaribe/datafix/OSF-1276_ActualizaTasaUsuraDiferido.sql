column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

/***********************************************************
ELABORADO POR:  Juan Gabriel Catuche Giron
EMPRESA:        MVM Ingenieria de Software
FECHA:          Junio 2023
JIRA:           OSF-1276

Actualiza tasa de usura de diferidos activos que actualmente estan con la tasa 19 o 26 a la tasa 2-Tasa Usura

    
    Archivo de entrada 
    ===================
    NA
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    02/06/2023 - jcatuchemvm  
    Creación
        
***********************************************************/
declare
    --Constantes para el datafix
    csbCaso         constant varchar2(20)   := 'OSF1276';
    csbTitulo       constant varchar2(2000) := csbCaso||': Actualiza Tasa de interes 19/26 a diferidos con alivios';
    cnuTasainte     constant number         := 2;
    csbOutPut       constant varchar2( 1 )  := 'S';
    csbEscritura    constant varchar2( 1 )  := 'w';
    csbLectura      constant varchar2( 1 )  := 'r';
    csbPIPE         constant varchar2( 1 )  := '|';
    cdtFecha        constant date           := ut_date.fdtSysdate;
    csbFormato      constant varchar2( 50 ) := 'dd/mm/yyyy';
    csbformatos     constant varchar2( 50 ) := 'yyyymmddhh24mi';
    cnuSegundo      constant number         := 1/86400;
    cnuLimit        constant number         := 1000;
    cnuIdErr        constant number         := 1;
    cnuHash         constant number         := 15;
    
    type tyrcRegistro is record 
    (
        difecodi            diferido.difecodi%type,
        difenuse            diferido.difenuse%type,
        difesusc            diferido.difesusc%type,
        sesucicl            servsusc.sesucicl%type,
        difeinte            diferido.difeinte%type,
        difesape            diferido.difesape%type,
        cuotasP             diferido.difenucu%type,
        difefein            diferido.difefein%type, 
        difetain            diferido.difetain%type,
        difetain_act        diferido.difetain%type,
        sbActualiza         varchar2(1),
        sbFlag              varchar2(1)
    );
    type tytbRegistro is table of tyrcRegistro index by varchar2(15);    
    tbRegistro      tytbRegistro;
    sbHash          varchar2(15);
    nuHash          binary_integer;
    
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
    tbArchivos      tytbArchivos;
    
    
    --Cursores
    cursor cuPrincipal is 
    select /*+ index ( d IX_DIFERIDO11 ) */
    rowid row_id,difecodi,difenuse,difesusc,difesape,difeinte,difetain,trunc(difefein) difefein,difenucu-difecupa cuotasP
    from diferido d
    where 1 = 1
    and difetain in (19,26)
    and difesape > 0
    and difeinte != 0
    --and difenuse = 1135133
    ;
    

    type tytbPrincipal is table of cuPrincipal%rowtype index by binary_integer;
    tbPrincipal     tytbPrincipal;
    
    
    tbCampos        tyTabla;
    sbRuta          parametr.pamechar%type;
    nuerror         ge_error_log.message_id%TYPE;
    sberror         ge_error_log.description%TYPE; 
    sbline          varchar2(2000);
    sbcabecera      varchar2(2000);
    s_out           varchar2(2000);
    nuOuts          number;     
    nuLine          number;
    nuTotal         number;
    nuOk            number;
    nuErr           number;
    nuWrng          number;
    nuContador      number;
    raise_continuar exception;
    sbComentario    varchar2(2000);
    nudife          diferido.difecodi%type;
    nutasa          diferido.difetain%type;
    sbActualiza     varchar2(1);
    nuRowcount      number;
    
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
    
    PROCEDURE ParseString
    (
        ivaCadena  IN      VARCHAR2,
        ivaToken   IN      VARCHAR2,
        otbSalida  OUT     tyTabla 
    ) 
    IS
        nuIniBusqueda     NUMBER          := 1;
        nuFinBusqueda     NUMBER          := 1;
        sbArgumento       VARCHAR2( 2000 );
        nuIndArgumentos   NUMBER          := 1;
        nuLongitudArg     NUMBER;
    BEGIN
        -- Recorre la lista de argumentos y los guarda en un tabla pl-sql
        WHILE( ivaCadena IS NOT NULL ) LOOP
        
            -- Busca el separador en la cadena y almacena su posicion
            nuFinBusqueda := INSTR( ivaCadena, ivaToken, nuIniBusqueda );

            -- Si no exite el pipe, debe haber un argumento
            IF ( nuFinBusqueda = 0 ) THEN
                -- Obtiene el argumento
                sbArgumento := SUBSTR( ivaCadena, nuIniBusqueda );

                -- Si existe el argumento lo almacena en la tabla de argumentos
                IF ( sbArgumento IS NOT NULL ) THEN
                    otbSalida( nuIndArgumentos ) := sbArgumento;
                END IF;

                -- Termina el ciclo
                EXIT;
            END IF;

            -- Obtiene el argumento hasta el separador
            nuLongitudArg := nuFinBusqueda - nuIniBusqueda;
            
            -- Obtiene argumento
            sbArgumento := SUBSTR( ivaCadena, nuIniBusqueda, nuLongitudArg );
            
            -- Lo adiciona a la tabla de argumentos, quitando espacios y ENTER a los lados
            otbSalida( nuIndArgumentos ) := TRIM( REPLACE( sbArgumento, CHR( 13 ), '' ));
            
            -- Inicializa la posicion inicial con la posicion del caracterer
            -- despues del pipe
            nuIniBusqueda := nuFinBusqueda + 1;
            
            -- Incrementa el indice de la tabla de argumentos
            nuIndArgumentos := nuIndArgumentos + 1;
            
        END LOOP;
        
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END ParseString;
    
    FUNCTION fGetNextLine
    (
        iflFileHandle IN UTL_FILE.FILE_TYPE,
        osbLine     OUT VARCHAR2
    ) return boolean 
    is
        blEndFile boolean := false;
    begin
        osbLine  := null;
        utl_file.get_line ( iflFileHandle, osbLine );
        return blEndFile;  
    exception
        when no_data_found then
            osbLine  := null;
            blEndFile:= true;
            return blEndFile; 
    end fGetNextLine;  
    
    PROCEDURE pInicializar IS
    BEGIN
        
        BEGIN
            --EXECUTE IMMEDIATE
            --'alter session set nls_date_format = "dd/mm/yyyy hh24:mi:ss"';
            
            EXECUTE IMMEDIATE 
            'alter session set nls_numeric_characters = ",."';
            
        END;

        IF csbOutPut = 'S' THEN
            dbms_output.enable;
            dbms_output.enable (buffer_size => null);
            dbms_output.put_line(csbTitulo);
        END IF;
        
        pkerrors.setapplication(csbCaso);
        --sbRuta := ldc_bcconsgenerales.fsbValorColumna('open.parametr','pamechar','pamecodi','RUTA_TRAZA');
        
        nuLine      := 0;
        nuTotal     := 0;
        nuOk        := 0;
        nuErr       := 0;    
        nuWrng      := 0;  
        nuContador  := 0;
        tbRegistro.delete;
        tbPrincipal.delete;
        tbArchivos.delete; 
        
        sbActualiza := 'N';

        tbArchivos(0).nombre  := csbCaso||'_IN.txt';
        tbArchivos(1).nombre  := csbCaso||'_'||to_char(cdtFecha,csbformatos)||'_Log';
        tbArchivos(2).nombre  := csbCaso||'_'||to_char(cdtFecha,csbformatos)||'_Poblacion';
        
        /*tbArchivos(0).tipoarch  := csbLectura;
        tbArchivos(1).tipoarch  := csbEscritura;
        tbArchivos(2).tipoarch  := csbEscritura;
        */
        tbArchivos(0).flgprint  := 'S';
        tbArchivos(1).flgprint  := 'S';
        tbArchivos(2).flgprint  := 'S';
        
        nuOuts := tbArchivos.last;
        
        sbCabecera := 'TipoError|Diferido|Tasa|Mensaje|Error'; 
        tbArchivos(cnuIdErr).cabecera := sbCabecera;
        
        sbCabecera := 'Diferido|Producto|Contrato|Ciclo|Interes|Saldo|CuotasPendientes|FechaReg|Tasa_ant|Tasa_act|Actualizado';
        tbArchivos(2).cabecera := sbCabecera;
        
               
        
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
            sbComentario := 'Error escritura dbms_output - '||sqlerrm;
            raise raise_continuar;  
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
        when utl_file.invalid_operation then
            sbComentario := 'Error -1|'||nuDife||'|'||nuTasa||
            '|Error en operacion "'||ircArchivos.tipoarch||
            '" para el archivo "'||ircArchivos.nombre||'" en la ruta "'||sbRuta||'"|'||sqlerrm;
            raise raise_continuar;
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
            --ircArchivos.tblog(nuidxlog) := sbMensaje; 
            pEscritura(ircArchivos,sbMensaje);
        End If;
                
    exception
        when raise_continuar  then
            raise;
        when others then
            sbComentario := 'Error almacenamiento de log'||sqlerrm;
            raise raise_continuar;  
    END pGuardaLog;
    
    
    
    Procedure pEsbribelog IS
    Begin        
        for i in reverse 1..nuOuts loop
            if tbArchivos(i).flgprint = 'S' then
                if tbArchivos(i).tblog.first is not null then
                    If csbOutPut = 'S' THEN 
                        pCustomOutput(tbArchivos(i).nombre);
                    END IF;
                    for j in tbArchivos(i).tblog.first..tbArchivos(i).tblog.last loop
                        pEscritura(tbArchivos(i),tbArchivos(i).tblog(j));
                    end loop;
                end if;
            end if;           
        end loop;
    exception
        when raise_continuar then
            raise;
        when others then
            dbms_output.put_line(sbComentario); 
            null;
    END pEsbribelog;
    
    Procedure pOpen(inuOut in number) IS
    Begin
        if csbOutPut != 'S' then
            tbArchivos(inuOut).flFile := utl_file.fopen(sbRuta, tbArchivos(inuOut).nombre, tbArchivos(inuOut).tipoarch);
        end if;
    exception
        when utl_file.invalid_operation then
            sbComentario := 'Error gestionando archivo ['||sbRuta||'/'||tbArchivos(inuOut).nombre||']['||tbArchivos(inuOut).tipoarch||']|'||sqlerrm;
            raise raise_continuar;    
    End pOpen;
    
    PROCEDURE pIniciaLog IS
    BEGIN
        for i in tbArchivos.first .. nuOuts loop
            pOpen(i);
            if i >= cnuIdErr then
                pGuardaLog(tbArchivos(i),tbArchivos(i).cabecera);
            end if;
        end loop;  
    exception
        when raise_continuar then
            raise;
        when others then
            dbms_output.put_line(sqlerrm);
            return;
    END pIniciaLog;
    
    PROCEDURE pCerrarLog IS
    BEGIN
        pGuardaLog(tbArchivos(cnuIdErr),'================================================');
        pGuardaLog(tbArchivos(cnuIdErr),'Finaliza la actualización '||csbCaso||'.' );
        pGuardaLog(tbArchivos(cnuIdErr),'Total de diferidos detectados : '||nuLine);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de diferidos almacenados : '||nuTotal);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de diferidos actualizados : '||nuOk);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de Advertencias : '||nuWrng);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de Errores : '||nuErr);
        pGuardaLog(tbArchivos(cnuIdErr),'Rango Total de Ejecución ['||to_char(cdtFecha,'dd/mm/yyyy')||']['||to_char(cdtFecha,'hh24:mi:ss')||' - '||to_char(ut_date.fdtSysdate,'hh24:mi:ss')||']');
        pGuardaLog(tbArchivos(cnuIdErr),'Tiempo Total de Ejecución ['||fnc_rs_CalculaTiempo(cdtFecha,ut_date.fdtSysdate)||']');
        
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
        -- Indica que terminó el proceso en el archivo de salida
        pGuardaLog(tbArchivos(cnuIdErr),'================================================');
        pGuardaLog(tbArchivos(cnuIdErr),'Finaliza la actualización con Error '||csbCaso||': ' ||sqlerrm );
        pGuardaLog(tbArchivos(cnuIdErr),'Total de diferidos detectados : '||nuLine);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de diferidos almacenados : '||nuTotal);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de diferidos actualizados : '||nuOk);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de Advertencias : '||nuWrng);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de Errores : '||nuErr);
        pGuardaLog(tbArchivos(cnuIdErr),'Rango Total de Ejecución ['||to_char(cdtFecha,'dd/mm/yyyy')||']['||to_char(cdtFecha,'hh24:mi:ss')||' - '||to_char(ut_date.fdtSysdate,'hh24:mi:ss')||']');
        pGuardaLog(tbArchivos(cnuIdErr),'Tiempo Total de Ejecución ['||fnc_rs_CalculaTiempo(cdtFecha,ut_date.fdtSysdate)||']');
        
        pEsbribelog();
        
        if csbOutPut != 'S' then
            for i in 0 .. nuOuts loop
                if ( utl_file.is_open( tbArchivos(i).flFile ) ) then
                    utl_file.fclose( tbArchivos(i).flFile );
                end if;
            end loop;
        end if;
    exception
        when others then
            dbms_output.put_line(sbComentario); 
    END pCerrarLogE;
    
    PROCEDURE pGeneraciondeRastro(ircRegistro in out nocopy tyrcRegistro) is
        
    begin
        
        sberror :=  'NA';
        s_out := nuDife;
        s_out := s_out||'|'||ircRegistro.difenuse;
        s_out := s_out||'|'||ircRegistro.difesusc;
        s_out := s_out||'|'||ircRegistro.sesucicl;
        s_out := s_out||'|'||ircRegistro.difeinte;
        s_out := s_out||'|'||ircRegistro.difesape;
        s_out := s_out||'|'||ircRegistro.cuotasP;
        s_out := s_out||'|'||to_char(ircRegistro.difefein,csbFormato);
        s_out := s_out||'|'||nuTasa;
        s_out := s_out||'|'||ircRegistro.difetain_act;
        s_out := s_out||'|'||ircRegistro.sbActualiza;
        
        pGuardaLog(tbArchivos(2),s_out);
        
        
                        
    exception
        when raise_continuar then
            pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
            nuErr := nuErr + 1;  
        when others then
            Pkg_Error.getError (nuerror, sberror);
            sbComentario := 'Error 3.0|'||nuDife||'|'||nuTasa||
            '|Error desconocido en impresión de información|'||sberror;
            pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
            nuErr := nuErr + 1;  
    end pGeneraciondeRastro;
    
    PROCEDURE pActualizaDatos(ircRegistro in out nocopy tyrcRegistro) is
    
    begin
        --Actualiza diferido
        sberror :=  'NA';
        pktbldiferido.upddifetain(nuDife,ircRegistro.difetain_act);
        ircRegistro.sbActualiza := 'S';
        nuOk := nuOk + 1;
        pkGeneralServices.CommitTransaction;
        
    exception 
        when raise_continuar then
            rollback;
            raise;
        when EX.CONTROLLED_ERROR then
            Pkg_Error.getError( nuerror, sberror );
            sbComentario := 'Error 2.1|'||nuDife||'|'||nuTasa||
            '|Error Controlado|'||nuerror||'-'||sberror;
            rollback;
            raise raise_continuar;
        when others then
            Pkg_Error.Seterror;
            Pkg_Error.getError( nuerror, sberror );
            sbComentario := 'Error 2.2|'||nuDife||'|'||nuTasa||
            '|Error No Controlado|'||nuerror||'-'||sberror;
            rollback; 
            raise raise_continuar;
    END pActualizaDatos; 
    
    PROCEDURE pAnalizaDatos is
        rcRegistro  tyrcRegistro;
        
        cursor cuValida (inusesu in diferido.difenuse%type) is
        select /*+ index ( a pk_servsusc) */
        a.sesunuse,sesucicl,
        (select suscnupr from suscripc where susccodi = sesususc) suscnupr,
        (select count(*) from cargos b where b.cargnuse = a.sesunuse and cargcuco = -1 and cargprog = 5) cargfact
        from servsusc a
        where sesunuse = inusesu
        ;
        
        rcValida    cuValida%rowtype;
        
        
    BEGIN
        nuDife     := null;
        nuTasa       := null; 

        sbHash := tbRegistro.first;
        if sbHash is null then
            sbComentario := 'Error 1.1|'||nuDife||'|'||nuTasa||
            '|Sin diferidos para analizar|NA';
            raise raise_continuar;
        end if;
        
        loop
            begin
                rcRegistro := null;
                rcRegistro := tbRegistro(sbHash);
                nuDife := rcRegistro.difecodi;
                nuTasa := rcRegistro.difetain;
                                
                --Valida cargos
                rcValida := null;
                sberror :=  'NA';
                open cuValida(rcRegistro.difenuse);
                fetch cuValida into rcValida;
                close cuValida;
                
                if rcValida.suscnupr > 0 then
                    sbComentario := 'Error 1.1|'||nuDife||'|'||nuTasa||
                    '|El Contrato se esta facturando ['||rcRegistro.difesusc||']['||rcValida.cargfact||']|'||sberror;
                    raise raise_continuar;
                end if;
                    
                rcRegistro.sesucicl := rcValida.sesucicl;
                tbRegistro(sbHash) := rcRegistro;
                
                pActualizaDatos(tbRegistro(sbHash));
                pGeneraciondeRastro(tbRegistro(sbHash));
                                
            exception
                when raise_continuar then
                    pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
                    nuErr := nuErr + 1;  
                    tbRegistro.delete(sbHash);
                when others then
                    Pkg_Error.getError (nuerror, sberror);
                    sbComentario := 'Error 1.0|'||nuDife||'|'||nuTasa||
                    '|Error desconocido en analisis de diferidos|'||sberror;
                    pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
                    nuErr := nuErr + 1;  
                    tbRegistro.delete(sbHash);
            end;
            
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
        nuDife     := null;
        nuTasa     := null; 

        if csbOutPut = 'S' or tbArchivos(0).flgprint = 'N' then
            --nuPivote := 1;
            open cuPrincipal;
            loop
                tbPrincipal.delete;
                fetch cuPrincipal bulk collect into tbPrincipal limit cnuLimit;
                exit when tbPrincipal.count = 0; 

                for i in 1..tbPrincipal.count loop 
                    begin
                        nuLine := nuLine+ 1;
                        nuDife := tbPrincipal(i).difecodi;
                        nuTasa := tbPrincipal(i).difetain;
                                              
                        sbHash := lpad(nuDife,cnuHash,'0');
                        
                        if not tbRegistro.exists(sbHash) then
        
                            tbRegistro(sbHash).difecodi     := nuDife;
                            tbRegistro(sbHash).difetain     := nuTasa;
                            tbRegistro(sbHash).difenuse     := tbPrincipal(i).difenuse;
                            tbRegistro(sbHash).difesusc     := tbPrincipal(i).difesusc;
                            tbRegistro(sbHash).difeinte     := tbPrincipal(i).difeinte;
                            tbRegistro(sbHash).difesape     := tbPrincipal(i).difesape;
                            tbRegistro(sbHash).cuotasP      := tbPrincipal(i).cuotasP;
                            tbRegistro(sbHash).difefein     := tbPrincipal(i).difefein;
                            tbRegistro(sbHash).difetain_act := cnuTasainte;
                            tbRegistro(sbHash).sbActualiza  := 'N';
                            tbRegistro(sbHash).sbFlag       := 'N';
                            
                             nuTotal := nuTotal + 1;

                        else
                            sbComentario := 'Error 0.2|'||nuDife||'|'||nuTasa||
                            '|Diferido ya cargado|NA';
                            raise raise_continuar;                            
                        end if; 

                    exception
                        when raise_continuar then
                            pGuardaLog(tbArchivos(cnuIdErr),sbComentario); 
                            nuErr := nuErr + 1;
                            tbRegistro(sbHash).sbFlag := 'S';
                        when others then
                            Pkg_Error.getError (nuerror, sberror);
                            sbComentario := 'Error 0.0|'||nuDife||'|'||nuTasa||
                            '|Error desconocido en almacenamiento de poblacion|'||sberror;
                            pGuardaLog(tbArchivos(cnuIdErr),sbComentario); 
                            nuErr := nuErr + 1;
                            tbRegistro(sbHash).sbFlag := 'S';
                    end;
                end loop; 

                --nuPivote := tbLecManual(tbLecManual.last).sesunuse;
                exit when tbPrincipal.count < cnuLimit; 
            end loop;
            close cuPrincipal;
        else
            loop
                begin
                
                    sbLine := null;
                    if fgetnextline (tbArchivos(0).flFile, sbLine) then 
                        exit; 
                    end if;
                    
                    tbCampos.delete;
                    parsestring(sbLine, csbPIPE, tbCampos);
                    
                    if tbCampos.exists(1) and tbCampos.exists(2)  then
                        
                        nuDife := to_number(tbCampos(1));
                        nuTasa := tbCampos(2);
                        nuLine := nuLine + 1;
                        
                        sbHash := lpad(nuDife,cnuHash,'0');
                        
                        if not tbRegistro.exists(sbHash) then
                        
                            tbRegistro(sbHash).difecodi     := nuDife;
                            tbRegistro(sbHash).difetain     := nuTasa;
                            tbRegistro(sbHash).sbActualiza  := 'N';
                            tbRegistro(sbHash).sbFlag       := 'N';
                            
                            nuTotal := nuTotal + 1;                           
                        else
                            sbComentario := 'Error 0.2|'||nuDife||'|'||nuTasa||
                            '|Diferido ya cargado|NA';                            
                            raise raise_continuar;
                        end if;
                    else
                        sbComentario := 'Error 0.3|'||nuDife||'|'||nuTasa||
                        '|Los datos de entrada no pueden ser nulos ['||sbline||']|NA';
                        raise raise_continuar;    
                    end if;
                exception
                    when raise_continuar then
                        pGuardaLog(tbArchivos(cnuIdErr),sbComentario); 
                        nuErr := nuErr + 1;
                        tbRegistro(sbHash).sbFlag := 'S';
                    when others then
                        Pkg_Error.getError(nuerror, sberror);
                        sbComentario := 'Error 0.0|'||nuDife||'|'||nuTasa||
                        '|Error desconocido en lectura  de archivo de entrada ['||sbLine||']|'||sberror;
                        pGuardaLog(tbArchivos(cnuIdErr),sbComentario); 
                        nuErr := nuErr + 1;
                end;
            end loop;
        end if;
        
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
    when raise_continuar then 
        dbms_output.put_line(sbComentario); 
    when others then
        pCerrarLogE();
end;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/