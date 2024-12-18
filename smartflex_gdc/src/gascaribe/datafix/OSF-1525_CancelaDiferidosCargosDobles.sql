column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

/***********************************************************
ELABORADO POR:  Juan Gabriel Catuche Giron
EMPRESA:        MVM Ingenieria de Software
FECHA:          Septiembre 2023
JIRA:           OSF-1525

Cancela diferidos y ajusta los cargos con notas CR para cargos y diferidos dobles generados por error 

    
    Archivo de entrada 
    ===================
    OSF1525_IN.txt            
    
    Archivo de Salida 
    ===================
    OSF1525_YYYMMDDHH24MI_log.txt
    OSF1525_YYYMMDDHH24MI_Poblacion.txt
    OSF1525_YYYMMDDHH24MI_Ajuste.txt
    
    --Modificaciones    
    
    05/09/2023 - jcatuchemvm
    Creación
    
***********************************************************/
declare
    --Constantes para el datafix
    csbCaso         constant varchar2(20)   := 'OSF1525';
    csbTitulo       constant varchar2(2000) := csbCaso||': Cancela Diferidos y cuotas generadas para cargos de Brilla dobles';
    cnuCausaAjs     constant number         := 1; --ANULACION Ref Daniela Castro
    csbOutPut       constant varchar2( 1 )  := 'N';
    csbEscritura    constant varchar2( 1 )  := 'w';
    csbLectura      constant varchar2( 1 )  := 'r';
    csbPIPE         constant varchar2( 1 )  := '|';
    cdtFecha        constant date           := ut_date.fdtSysdate;
    csbFormato      constant varchar2( 50 ) := 'dd/mm/yyyy hh24:mi:ss';
    csbformatos     constant varchar2( 50 ) := 'yyyymmddhh24mi';
    cnuSegundo      constant number         := 1/86400;
    cnuLimit        constant number         := 1000;
    cnuIdErr        constant number         := 1;
    cnuHash         constant number         := 15;
    
    type tyrcCuenta is record 
    (
        cargcuco            cargos.cargcuco%type,
        cucosacu            cuencobr.cucosacu%type,
        cargnuse            cargos.cargnuse%type,
        cargsusc            servsusc.sesususc%type,
        cargconc            cargos.cargconc%type,
        cargcaca            cargos.cargcaca%type,
        cargsign            cargos.cargsign%type,
        cargvalo            cargos.cargvalo%type,
        cargdoso            cargos.cargdoso%type,
        cargcodo            cargos.cargcodo%type,
        cargunid            cargos.cargunid%type,
        cargfecr            cargos.cargfecr%type,
        notanume            notas.notanume%type,
        notafact            notas.notafact%type,
        cargconc_ajst       cargos.cargconc%type,
        cargcaca_ajst       cargos.cargcaca%type,
        cargsign_ajst       cargos.cargsign%type,
        cargvalo_ajst       cargos.cargvalo%type,
        cargdoso_ajst       cargos.cargdoso%type,
        cargcodo_ajst       cargos.cargcodo%type
        
    );
    type tytbCuenta is table of tyrcCuenta index by binary_integer;    
    
    type tyrcRegistro is record 
    (
        difecodi            diferido.difecodi%type,
        difenuse            diferido.difenuse%type,
        difefein            diferido.difefein%type,
        difeconc            diferido.difeconc%type,
        difevatd            diferido.difevatd%type,
        difesape            diferido.difesape%type,
        difenudo            diferido.difenudo%type,
        difecupa            diferido.difecupa%type,
        difenucu            diferido.difenucu%type,
        difecoin            diferido.difecoin%type,
        sesucicl            servsusc.sesucicl%type,
        cargcuco            cargos.cargcuco%type,
        cargfecr            cargos.cargfecr%type,
        cargpefa            cargos.cargpefa%type,
        cargpeco            cargos.cargpeco%type,
        cargcaca            cargos.cargcaca%type,
        cargdoso            cargos.cargdoso%type,
        cargsign            cargos.cargsign%type,
        cargcodo            cargos.cargcodo%type,
        cargvalo            cargos.cargvalo%type,
        package_id          mo_packages.package_id%type,
        package_type_id     mo_packages.package_type_id%type,
        motive_status_id    mo_packages.motive_status_id%type,
        cargdoso_2          cargos.cargdoso%type,
        cargcodo_2          cargos.cargcodo%type,
        cargdoso_sol        cargos.cargdoso%type,
        cargcodo_sol        cargos.cargcodo%type,
        cargfecr_sol        cargos.cargfecr%type,
        tbCuenta            tytbCuenta,
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
    select difecodi,difenuse
    from diferido
    where difecodi in 
    (
        103401866,103401874,103401879,103401887,
        103401891,103401898,103401884,103401899,
        103401902,103401901,103401903,103401894,
        103401904,103171838,103171840,103401888,
        103401876,103401881,103401867,103401892,
        103903633,103903637,103903638,103903635,
        103903634,103903636,103401865,103401870,
        103401926,103401923,103401919,103401912,
        103401929,103401928,103401932,103401933,
        103401930,104061640,104061639,104160810,
        104160814,104160817,103401885,104160811,
        104160823,104160822,104160819,104160813,
        104160820,104160825,104160821,104160824,
        104160826,104160827,103009680,104160808,
        104160812,104160816,104160818,103401890,
        103401900,103401896,103401897,103322323,
        103322325,103322327,102838422,102838423,
        103322324,103322326,103401862,103401864,
        103401908,103401916,103401925,103401922,
        103401863,103401861,104160815,104160809,
        103401936,103401935,103401931
    )
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
    nuErr           number;
    nuOk            number;
    nuCrgs          number;
    nuNota          number;
    nuDife          number;
    nuWrng          number;
    nuContador      number;
    raise_continuar exception;
    sbComentario    varchar2(2000);
    nuDiferido      number;
    nuSesunuse      number;
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
        sbRuta := pkGeneralParametersMgr.fsbGetStringValue('RUTA_TRAZA');
        
        nuLine      := 0;
        nuTotal     := 0;
        nuErr       := 0;    
        nuOk        := 0;
        nuCrgs      := 0;
        nuNota      := 0;
        nuDife      := 0;  
        nuWrng      := 0;  
        nuContador  := 0;
        tbRegistro.delete;
        tbPrincipal.delete;
        tbArchivos.delete; 
        
        sbActualiza := 'N';

        --tbArchivos(1).nombrearch    := csbCaso||'_'||to_char(cdtFecha,csbformatos)||'_Log.txt';
        --tbArchivos(2).nombrearch    := csbCaso||'_'||to_char(cdtFecha,csbformatos)||'_Poblacion.txt';
        
        
        tbArchivos(0).nombre  := csbCaso||'_IN.txt';
        tbArchivos(1).nombre  := csbCaso||'_'||to_char(cdtFecha,csbformatos)||'_Log.txt';
        tbArchivos(2).nombre  := csbCaso||'_'||to_char(cdtFecha,csbformatos)||'_Poblacion.txt';
        tbArchivos(3).nombre  := csbCaso||'_'||to_char(cdtFecha,csbformatos)||'_Ajuste.txt';
        
        tbArchivos(0).tipoarch  := csbLectura;
        tbArchivos(1).tipoarch  := csbEscritura;
        tbArchivos(2).tipoarch  := csbEscritura;
        tbArchivos(3).tipoarch  := csbEscritura;
        
        tbArchivos(0).flgprint  := 'N';
        tbArchivos(1).flgprint  := 'S';
        tbArchivos(2).flgprint  := 'S';
        tbArchivos(3).flgprint  := 'S';
        
        nuOuts := tbArchivos.last;
        
        sbCabecera := 'TipoError|Cuenta|DocSoporte|Mensaje|Error'; 
        tbArchivos(cnuIdErr).cabecera := sbCabecera;
        
        sbCabecera := 'Diferido|Producto|Concepto_dif|Fecha_diferido|ValoTotal|SaldoDiferido|DocumentoDiferido|CuotasGeneradas|CuotasTotales|';
        sbCabecera := sbCabecera||'Ciclo|Cuenta|PeriFact|PeriCons|Causal|Fecha|Signo|Valor|Documento|Cargcodo|Solicitud|TipoSol|EstadoSol|';
        sbCabecera := sbCabecera||'Documento_2|Cargcodo_2|Documento_Sol|Cargcodo_Sol|Cargfecr_Sol|Actualizado';
        tbArchivos(2).cabecera := sbCabecera;
        
        sbCabecera := 'Cuenta|DocSoporte|Producto|Contrato|Diferido|SaldoDiferido|CuotasGeneradas|CuentaCuota|SaldoCuenta|ConceptoDiferido|SignoDiferido|Valordiferido|DocDiferido|';
        sbCabecera := sbCabecera||'Nota|NotaFact|ConceptoAjuste|CausaAjuste|SignoAjuste|ValorAjuste|DocAjuste|CodoAjuste';
        tbArchivos(3).cabecera := sbCabecera;
        
        
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
            sbComentario := 'Error -1|'||nuDiferido||'|'||nuSesunuse||
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
        if csbOutPut != 'S' and tbArchivos(inuOut).flgprint != 'N' then
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
        pGuardaLog(tbArchivos(cnuIdErr),'Total de cuentas detectadas : '||nuLine);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de cuentas almacenadas : '||nuTotal);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de cuentas gestionadas : '||nuOk);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de diferidos cancelados : '||nuDife);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de notas creadas : '||nuNota);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de cargos creados : '||nuCrgs);
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
        -- Indica que termin� el proceso en el archivo de salida
        pGuardaLog(tbArchivos(cnuIdErr),'================================================');
        pGuardaLog(tbArchivos(cnuIdErr),'Finaliza la actualización con Error '||csbCaso||': ' ||sqlerrm );
        pGuardaLog(tbArchivos(cnuIdErr),'Total de cuentas detectadas : '||nuLine);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de cuentas almacenadas : '||nuTotal);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de cuentas gestionadas : '||nuOk);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de diferidos cancelados : '||nuDife);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de notas creadas : '||nuNota);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de cargos creados : '||nuCrgs);
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
        s_out := nuDiferido;
        s_out := s_out||'|'||ircRegistro.difenuse;
        s_out := s_out||'|'||ircRegistro.difeconc;
        s_out := s_out||'|'||to_char(ircRegistro.difefein,csbFormato);
        s_out := s_out||'|'||ircRegistro.difevatd;
        s_out := s_out||'|'||ircRegistro.difesape;
        s_out := s_out||'|'||ircRegistro.difenudo;
        s_out := s_out||'|'||ircRegistro.difecupa;
        s_out := s_out||'|'||ircRegistro.difenucu;
        s_out := s_out||'|'||ircRegistro.sesucicl;
        s_out := s_out||'|'||ircRegistro.cargcuco;
        s_out := s_out||'|'||ircRegistro.cargpefa;
        s_out := s_out||'|'||ircRegistro.cargpeco;
        s_out := s_out||'|'||ircRegistro.cargcaca;
        s_out := s_out||'|'||to_char(ircRegistro.cargfecr,csbFormato);
        s_out := s_out||'|'||ircRegistro.cargsign;
        s_out := s_out||'|'||ircRegistro.cargvalo;
        s_out := s_out||'|'||ircRegistro.cargdoso;
        s_out := s_out||'|'||ircRegistro.cargcodo;
        s_out := s_out||'|'||ircRegistro.package_id;
        s_out := s_out||'|'||ircRegistro.package_type_id;
        s_out := s_out||'|'||ircRegistro.motive_status_id;
        s_out := s_out||'|'||ircRegistro.cargdoso_2;
        s_out := s_out||'|'||ircRegistro.cargcodo_2;
        s_out := s_out||'|'||ircRegistro.cargdoso_sol;
        s_out := s_out||'|'||ircRegistro.cargcodo_sol;
        s_out := s_out||'|'||to_char(ircRegistro.cargfecr_sol,csbFormato);
        s_out := s_out||'|'||sbActualiza;
        
        pGuardaLog(tbArchivos(2),s_out);
        
        nuHash := ircRegistro.tbCuenta.first;
        
        if nuHash is null then
            sbComentario := 'Wrng 3.1|'||nuDiferido||'|'||nuSesunuse||
            '|Sin cargos de  ajuste al diferido generado ['||ircRegistro.difecodi||']|'||sberror;
            pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
            nuWrng := nuWrng + 1;
        else
            for nuHash in ircRegistro.tbCuenta.first..ircRegistro.tbCuenta.last loop
                s_out := ircRegistro.cargcuco;
                s_out := s_out||'|'||ircRegistro.cargdoso;
                s_out := s_out||'|'||nuSesunuse;
                s_out := s_out||'|'||ircRegistro.tbCuenta(nuHash).cargsusc;
                s_out := s_out||'|'||nuDiferido;
                s_out := s_out||'|'||ircRegistro.difesape;
                s_out := s_out||'|'||ircRegistro.difecupa;
                s_out := s_out||'|'||ircRegistro.tbCuenta(nuHash).cargcuco;
                s_out := s_out||'|'||ircRegistro.tbCuenta(nuHash).cucosacu;
                s_out := s_out||'|'||ircRegistro.tbCuenta(nuHash).cargconc;
                s_out := s_out||'|'||ircRegistro.tbCuenta(nuHash).cargsign;
                s_out := s_out||'|'||ircRegistro.tbCuenta(nuHash).cargvalo;
                s_out := s_out||'|'||ircRegistro.tbCuenta(nuHash).cargdoso;
                s_out := s_out||'|'||ircRegistro.tbCuenta(nuHash).notanume;
                s_out := s_out||'|'||ircRegistro.tbCuenta(nuHash).notafact;
                s_out := s_out||'|'||ircRegistro.tbCuenta(nuHash).cargconc_ajst;
                s_out := s_out||'|'||ircRegistro.tbCuenta(nuHash).cargcaca_ajst;
                s_out := s_out||'|'||ircRegistro.tbCuenta(nuHash).cargsign_ajst;
                s_out := s_out||'|'||ircRegistro.tbCuenta(nuHash).cargvalo_ajst;
                s_out := s_out||'|'||ircRegistro.tbCuenta(nuHash).cargdoso_ajst;
                s_out := s_out||'|'||ircRegistro.tbCuenta(nuHash).cargcodo_ajst;
                
                pGuardaLog(tbArchivos(3),s_out);
            end loop;
        end if;

        
        
                        
    exception
        when raise_continuar then
            pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
            nuErr := nuErr + 1;  
        when others then
            sberror := sqlerrm;
            --pkerrors.geterrorvar (nuerror, sberror);
            sbComentario := 'Error 3.0|'||nuDiferido||'|'||nuSesunuse||
            '|Error desconocido en impresión de información|'||sberror;
            pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
            nuErr := nuErr + 1;  
    end pGeneraciondeRastro;
    
    PROCEDURE pActualizaDatos(ircRegistro in out nocopy tyrcRegistro) is
    
        cursor cuCuentaCorr (inusesu in cargos.cargnuse%type, inudife in diferido.difecodi%type) is
        select /*+ index ( a IX_CARGOS010) */
        a.cargcuco,a.cargnuse,a.cargconc,a.cargcaca,a.cargsign,a.cargvalo,a.cargdoso,a.cargcodo,a.cargunid,a.cargfecr,cargprog,
        (select sesususc from servsusc where sesunuse = a.cargnuse) cargsusc,
        (select nvl(cucosacu,0) from cuencobr where cucocodi = cargcuco) cucosacu
        from cargos a
        where cargnuse = inusesu 
        and cargdoso in ('DF-'||inudife,'ID-'||inudife)
        and cargcaca = 46
        and cargprog = 700
        and cargfecr >= cdtFecha
        and cargsign = 'DB'
        order by cargcuco,cargdoso
        ;
        
        cursor cuCuentaAjs (inusesu in cargos.cargnuse%type, inucuco in cargos.cargcuco%type,isbdoso in cargos.cargdoso%type,inuconc in cargos.cargconc%type) is
        select /*+ index ( a IX_CARG_NUSE_CUCO_CONC) */
        a.cargcuco,a.cargnuse,a.cargconc,a.cargcaca,a.cargsign,a.cargvalo,a.cargdoso,a.cargcodo,a.cargunid,a.cargfecr,cargprog,
        (select sesususc from servsusc where sesunuse = a.cargnuse) cargsusc,
        (select notafact from notas where notanume = substr(cargdoso,4)) notafact
        from cargos a
        where cargnuse = inusesu
        and cargcuco = inucuco
        and cargdoso in isbdoso
        and cargconc = inuconc;
        
        rcCuentasAjs cuCuentaAjs%rowtype;
        
        nutmpcuenta  cargos.cargcuco%type;
        nuNote       notas.notanume%type;
        nuCntNota    number;
    
    begin
        -- Trae deuda a presente mes
        CC_BODefToCurTransfer.GlobalInitialize;
        CC_BODefToCurTransfer.AddDeferToCollect(ircRegistro.difecodi);
        CC_BODefToCurTransfer.TransferDebt
        (
            'FINAN',
            nuerror,
            sberror,
            false,
            ld_boconstans.cnuCero_Value,
            sysdate
        );
        
        if nuerror = 0 then
            sberror := 'NA';
            --obtiene cuenta de cancelacion diferido
            nuContador := 0;
            for rcCuenta in cuCuentaCorr(ircRegistro.difenuse,ircRegistro.difecodi) loop
                if ircRegistro.tbCuenta.first is null then
                    nuHash := 1;
                else
                    nuHash := ircRegistro.tbCuenta.last + 1;
                end if;
                
                ircRegistro.tbCuenta(nuHash).cargcuco := rcCuenta.cargcuco;
                ircRegistro.tbCuenta(nuHash).cucosacu := rcCuenta.cucosacu;
                ircRegistro.tbCuenta(nuHash).cargnuse := rcCuenta.cargnuse;
                ircRegistro.tbCuenta(nuHash).cargsusc := rcCuenta.cargsusc;
                ircRegistro.tbCuenta(nuHash).cargconc := rcCuenta.cargconc;
                ircRegistro.tbCuenta(nuHash).cargcaca := rcCuenta.cargcaca;
                ircRegistro.tbCuenta(nuHash).cargsign := rcCuenta.cargsign;
                ircRegistro.tbCuenta(nuHash).cargvalo := rcCuenta.cargvalo;
                ircRegistro.tbCuenta(nuHash).cargdoso := rcCuenta.cargdoso;
                ircRegistro.tbCuenta(nuHash).cargcodo := rcCuenta.cargcodo;
                ircRegistro.tbCuenta(nuHash).cargunid := rcCuenta.cargunid;
                ircRegistro.tbCuenta(nuHash).cargfecr := rcCuenta.cargfecr;
                
                nuContador := nuContador + 1;
            end loop;
            
            if nuContador = 0 then
                sbComentario := 'Error 2.3|'||nuDiferido||'|'||nuSesunuse||
                '|No se encontro cargo de cancelación del diferido ['||ircRegistro.difecodi||']|'||sberror;
                raise raise_continuar;
            end if;
            
            --Creación de notas
            nuContador := 0;
            nuCntNota := 0;
            for nuHash in ircRegistro.tbCuenta.first .. ircRegistro.tbCuenta.last loop
                --Control cuentas
                if nutmpcuenta is null then
                    nutmpcuenta := ircRegistro.tbCuenta(nuHash).cargcuco;
                    --  Crea la nota credito
                    nuNote := null;
                    pkBillingNoteMgr.CreateBillingNote
                    (
                        ircRegistro.difenuse,
                        nutmpcuenta,
                        GE_BOConstants.fnuGetDocTypeCreNote,
                        sysdate,
                        csbTitulo,
                        pkBillConst.csbTOKEN_NOTA_CREDITO,
                        nuNote
                    );
                    
                    nuCntNota  := nuCntNota + 1;
                    
                elsif nutmpcuenta != ircRegistro.tbCuenta(nuHash).cargcuco then
                    nutmpcuenta := ircRegistro.tbCuenta(nuHash).cargcuco;
                    --  Crea la nota credito
                    nuNote := null;
                    pkBillingNoteMgr.CreateBillingNote
                    (
                        ircRegistro.difenuse,
                        nutmpcuenta,
                        GE_BOConstants.fnuGetDocTypeCreNote,
                        sysdate,
                        csbTitulo,
                        pkBillConst.csbTOKEN_NOTA_CREDITO,
                        nuNote
                    );
                    
                    nuCntNota  := nuCntNota + 1;
                    
                end if;
                
                -- Crea detalle de la nota credito
                FA_BOBillingNotes.DetailRegister
                (
                    nuNote,
                    ircRegistro.difenuse,
                    ircRegistro.tbCuenta(nuHash).cargsusc,
                    ircRegistro.tbCuenta(nuHash).cargcuco,
                    ircRegistro.tbCuenta(nuHash).cargconc,
                    cnuCausaAjs,
                    ircRegistro.tbCuenta(nuHash).cargvalo,
                    NULL,
                    pkBillConst.csbTOKEN_NOTA_CREDITO || nuNote,
                    pkBillConst.CREDITO,
                    ld_boconstans.csbYesFlag,
                    NULL,
                    pkConstante.SI,
                    FALSE
                );
                
                rcCuentasAjs := null;
                open cuCuentaAjs(ircRegistro.difenuse,ircRegistro.tbCuenta(nuHash).cargcuco,pkBillConst.csbTOKEN_NOTA_CREDITO || nuNote,ircRegistro.tbCuenta(nuHash).cargconc);
                fetch cuCuentaAjs into rcCuentasAjs;
                close cuCuentaAjs;
                
                if rcCuentasAjs.cargcuco is not null then
                    ircRegistro.tbCuenta(nuHash).notanume       := nuNote;
                    ircRegistro.tbCuenta(nuHash).notafact       := rcCuentasAjs.notafact;
                    ircRegistro.tbCuenta(nuHash).cargconc_ajst  := rcCuentasAjs.cargconc;
                    ircRegistro.tbCuenta(nuHash).cargcaca_ajst  := rcCuentasAjs.cargcaca;
                    ircRegistro.tbCuenta(nuHash).cargsign_ajst  := rcCuentasAjs.cargsign;
                    ircRegistro.tbCuenta(nuHash).cargvalo_ajst  := rcCuentasAjs.cargvalo;
                    ircRegistro.tbCuenta(nuHash).cargdoso_ajst  := rcCuentasAjs.cargdoso;
                    ircRegistro.tbCuenta(nuHash).cargcodo_ajst  := rcCuentasAjs.cargcodo;
                
                    nuContador := nuContador + 1;
                else
                    sbComentario := 'Error 2.6|'||nuDiferido||'|'||nuSesunuse||
                    '|No se encuentra el cargo de ajuste generado ['||ircRegistro.tbCuenta(nuHash).cargconc||']|'||sberror;
                    raise raise_continuar;
                end if;
            end loop;

            if nuContador > 0 then
                nuDife := nuDife + 1;
                nuNota := nuNota + nuCntNota;
                nuCrgs := nuCrgs + nuContador;
                nuOk := nuOk + nuCntNota;
                sbActualiza := 'S';
                pkGeneralServices.CommitTransaction;
            else
                sbComentario := 'Error 2.5|'||nuDiferido||'|'||nuSesunuse||
                '|Sin cargos generados|'||sberror;
                raise raise_continuar;
            end if;
            
        else
            sbComentario := 'Error 2.4|'||nuDiferido||'|'||nuSesunuse||
            '|Error en cancelación del diferido ['||ircRegistro.difecodi||']|'||sberror;
            raise raise_continuar;
        end if;
       
        
    exception 
        when raise_continuar then
            rollback;
            raise;
        when EX.CONTROLLED_ERROR then
            pkerrors.geterrorvar( nuerror, sberror );
            sbComentario := 'Error 2.1|'||nuDiferido||'|'||nuSesunuse||
            '|Error Controlado|'||nuerror||'-'||sberror;
            rollback;
            raise raise_continuar;
        when others then
            Errors.Seterror;
            pkerrors.geterrorvar( nuerror, sberror );
            sbComentario := 'Error 2.2|'||nuDiferido||'|'||nuSesunuse||
            '|Error No Controlado|'||nuerror||'-'||sberror;
            rollback; 
            raise raise_continuar;
    END pActualizaDatos; 
    
    PROCEDURE pAnalizaDatos is
        rcRegistro  tyrcRegistro;
        
        cursor cuValida(inudife in diferido.difecodi%type) is
        select /*+ index ( df pk_diferido ) use_nl (df m )
        index ( m IX_CARGOS010 ) index ( d CARGNUSE, CARGCUCO, CARGCONC )*/ 
        df.difecodi,df.difenuse,df.difeconc,df.difevatd,df.difesape,df.difenudo,df.difefein,difecupa,difenucu,difecoin,
        m.cargcuco,m.cargfecr,m.cargpefa,m.cargpeco,m.cargcaca,m.cargdoso,m.cargsign,
        m.cargvalo cargvalo,m.cargcodo cargcodo,
        (
            select cargconc 
            from cargos b
            where m.cargconc = b.cargconc
            and m.cargnuse = b.cargnuse 
            and m.cargvalo = b.cargvalo
            and m.cargsign = b.cargsign
            and b.cargdoso like 'FD-%'
            and to_char(b.cargfecr,'YYYY') = '2023'
            and b.rowid  != m.rowid
            and rownum = 1
        ) cargconc_2,
        (
            select cargvalo 
            from cargos b
            where m.cargconc = b.cargconc
            and m.cargnuse = b.cargnuse 
            and m.cargvalo = b.cargvalo
            and m.cargsign = b.cargsign
            and b.cargdoso like 'FD-%'
            and to_char(b.cargfecr,'YYYY') = '2023'
            and b.rowid  != m.rowid
            and rownum = 1
        ) cargvalo_2,
        (
            select cargcodo 
            from cargos b
            where m.cargconc = b.cargconc
            and m.cargnuse = b.cargnuse 
            and m.cargvalo = b.cargvalo
            and m.cargsign = b.cargsign
            and b.cargdoso like 'FD-%'
            and to_char(b.cargfecr,'YYYY') = '2023'
            and b.rowid  != m.rowid
            and rownum = 1
        ) cargcodo_2,
        (
            select cargdoso 
            from cargos b
            where m.cargconc = b.cargconc
            and m.cargnuse = b.cargnuse 
            and m.cargvalo = b.cargvalo
            and m.cargsign = b.cargsign
            and b.cargdoso like 'FD-%'
            and to_char(b.cargfecr,'YYYY') = '2023'
            and b.rowid  != m.rowid
            and rownum = 1
        ) cargdoso_2,
        p.package_id,p.package_type_id,p.motive_status_id,
        d.cargconc cargconc_sol,d.cargvalo cargvalo_sol,d.cargdoso cargdoso_sol,d.cargcodo cargcodo_sol,d.cargfecr cargfecr_sol,
        (select suscnupr from suscripc where susccodi = difesusc) suscnupr,
        (select sesucicl from servsusc where sesunuse = m.cargnuse) sesucicl
        from diferido df, cargos m, mo_packages p, cargos d
        where df.difecodi = inudife
        and m.cargnuse = df.difenuse
        and m.cargdoso = 'FD-'||df.difecodi
        and m.cargconc = df.difeconc
        and p.package_id(+) = substr(d.cargdoso,4) 
        and d.cargcuco(+) = m.cargcuco
        and d.cargnuse(+) = m.cargnuse
        and d.cargconc(+) = m.cargconc
        and d.cargvalo(+) = m.cargvalo  
        and d.cargdoso(+) like 'PP-%'
        ;
        
        rcValida    cuValida%rowtype;
        
        cursor cuCuentas (inusesu in cargos.cargnuse%type, inudife in diferido.difecodi%type,inucuco in cuencobr.cucocodi%type) is
        select /*+ index ( a IX_CARG_NUSE_CUCO_CONC) */
        a.cargcuco,a.cargnuse,a.cargconc,a.cargcaca,a.cargsign,a.cargvalo,a.cargdoso,a.cargcodo,a.cargunid,a.cargfecr,
        (select sesususc from servsusc where sesunuse = a.cargnuse) cargsusc,
        (select cargdoso from cargos b where b.cargcuco = a.cargcuco and b.cargconc = a.cargconc and b.cargsign = 'CR' and b.cargfecr > a.cargfecr and b.cargfecr < cdtFecha and rownum = 1) cargdoso_ajst,
        (select cargvalo from cargos b where b.cargcuco = a.cargcuco and b.cargconc = a.cargconc and b.cargsign = 'CR' and b.cargfecr > a.cargfecr and b.cargfecr < cdtFecha and rownum = 1) cargvalo_ajst,
        (select count(*) from cargos b where b.cargnuse = a.cargnuse and cargcuco = -1 and cargprog = 5) cargfact,
        (select nvl(cucosacu,0) from cuencobr where cucocodi = cargcuco) cucosacu
        from cargos a
        where cargnuse = inusesu
        and cargdoso in ('DF-'||inudife,'ID-'||inudife)
        and cargcuco > inucuco
        order by cargcuco,cargdoso
        ;
        
        nutmpcuenta  cargos.cargcuco%type;
        
        
    BEGIN
        nuDiferido     := null;
        
        sbHash := tbRegistro.first;
        if sbHash is null then
            sbComentario := 'Error 1.1|'||nuDiferido||'|'||nuSesunuse||
            '|Sin diferidos para analizar|NA';
            raise raise_continuar;
        end if;
        
        loop
            begin
                rcRegistro := null;
                rcRegistro := tbRegistro(sbHash);
                nuDiferido := rcRegistro.difecodi;
                nuSesunuse := rcRegistro.difenuse;
                --Valida cargos
                rcValida := null;
                sberror :=  'NA';
                open cuValida(nuDiferido);
                fetch cuValida into rcValida;
                close cuValida;
                
                if rcValida.difecodi is null then 
                    sbComentario := 'Error 1.2|'||nuDiferido||'|'||nuSesunuse||
                    '|El diferido no existe en la BD|'||sberror;
                    raise raise_continuar;
                elsif rcValida.cargconc_2 is null then 
                    sbComentario := 'Error 1.3|'||nuDiferido||'|'||nuSesunuse||
                    '|La solicitud reportada no tiene un concepto adicional de financiación|'||sberror;
                    raise raise_continuar;
                elsif nvl(rcValida.difesape,0) = 0 then 
                    sbComentario := 'Error 1.4|'||nuDiferido||'|'||nuSesunuse||
                    '|El diferido del cobro duplicado no tiene saldo pendiente ['||nuDiferido||']|'||sberror;
                    raise raise_continuar;
                end if;
                
                rcRegistro.difefein         := rcValida.difefein;
                rcRegistro.difeconc         := rcValida.difeconc;
                rcRegistro.difevatd         := rcValida.difevatd;
                rcRegistro.difesape         := rcValida.difesape;
                rcRegistro.difenudo         := rcValida.difenudo;
                rcRegistro.difecupa         := rcValida.difecupa;
                rcRegistro.difenucu         := rcValida.difenucu;
                rcRegistro.difecoin         := rcValida.difecoin;
                rcRegistro.cargcuco         := rcValida.cargcuco;
                rcRegistro.sesucicl         := rcValida.sesucicl;
                rcRegistro.cargfecr         := rcValida.cargfecr;
                rcRegistro.cargpefa         := rcValida.cargpefa;
                rcRegistro.cargpeco         := rcValida.cargpeco;
                rcRegistro.cargcaca         := rcValida.cargcaca;
                rcRegistro.cargdoso         := rcValida.cargdoso;
                rcRegistro.cargcodo         := rcValida.cargcodo;
                rcRegistro.cargsign         := rcValida.cargsign;
                rcRegistro.cargvalo         := rcValida.cargvalo;
                rcRegistro.cargdoso_2       := rcValida.cargdoso_2;
                rcRegistro.cargcodo_2       := rcValida.cargcodo_2;
                rcRegistro.package_id       := rcValida.package_id;
                rcRegistro.package_type_id  := rcValida.package_type_id;
                rcRegistro.motive_status_id := rcValida.motive_status_id;
                rcRegistro.cargdoso_sol      := rcValida.cargdoso_sol;
                rcRegistro.cargcodo_sol     := rcValida.cargcodo_sol;
                rcRegistro.cargfecr_sol     := rcValida.cargfecr_sol;
                
                
                --Valida cuentas
                nutmpcuenta := null;
                nuContador := 0;
                for rcCuenta in cuCuentas (nuSesunuse,nuDiferido,rcRegistro.cargcuco) loop
                    --Control cuentas
                    if nutmpcuenta is null then
                        nutmpcuenta := rcCuenta.cargcuco;
                    elsif nutmpcuenta != rcCuenta.cargcuco then
                        
                        if (nuContador != 2) and (nvl(rcRegistro.difecoin,-1) != -1)  then
                            sbComentario := 'Error 1.5|'||nuDiferido||'|'||nuSesunuse||
                            '|En la cuenta de cobro del diferido no se generó cobro de interes ['||nutmpcuenta||']['||rcRegistro.difecoin||']|'||sberror;
                            raise raise_continuar;
                        elsif (nuContador = 2) and (nvl(rcRegistro.difecoin,-1) = -1)  then
                            sbComentario := 'Error 1.11|'||nuDiferido||'|'||nuSesunuse||
                            '|En la cuenta de cobro del diferido se generaron dos cargos, diferido sin configuracion de interes ['||nutmpcuenta||']['||rcRegistro.difecoin||']|'||sberror;
                            raise raise_continuar;
                        end if;
                        
                        nutmpcuenta := rcCuenta.cargcuco; 
                        nuContador := 0;
                                            
                    end if;
                    
                    --Validación cargos cuotas diferido
                    if rcCuenta.cargdoso like 'DF-%' and (rcRegistro.difeconc != rcCuenta.cargconc) then                        
                        sbComentario := 'Error 1.6|'||nuDiferido||'|'||nuSesunuse||
                        '|El concepto del cargo finaciación no corresponde con el del diferido ['||rcCuenta.cargconc||'-'||rcRegistro.difeconc||']|'||sberror;
                        raise raise_continuar;
                    elsif rcCuenta.cargdoso like 'ID-%' and (rcRegistro.difecoin != rcCuenta.cargconc) then                        
                        sbComentario := 'Error 1.7|'||nuDiferido||'|'||nuSesunuse||
                        '|El concepto del cargo de interes de finaciación no corresponde con el del diferido ['||rcCuenta.cargconc||'-'||rcRegistro.difecoin||']|'||sberror;
                        raise raise_continuar;
                    elsif rcCuenta.cargdoso_ajst is not null then
                        sbComentario := 'Error 1.8|'||nuDiferido||'|'||nuSesunuse||
                        '|En la cuenta del cobro del diferido se registran ajustes ['||rcCuenta.cargcuco||']['||rcCuenta.cargconc||']['||rcCuenta.cargdoso_ajst||']|'||sberror;
                        raise raise_continuar;
                    elsif rcCuenta.cargfact > 0 or rcValida.suscnupr > 0 then
                        sbComentario := 'Error 1.9|'||nuDiferido||'|'||nuSesunuse||
                        '|El producto se esta facturando o tiene cargos a la -1 ['||rcValida.suscnupr||']['||rcCuenta.cargfact||']|'||sberror;
                        raise raise_continuar;
                    end if;
                    
                    
                    --Almacenamiento de cuentas
                    if rcRegistro.tbCuenta.first is null then
                        nuHash  := 1;
                    else
                        nuHash  := rcRegistro.tbCuenta.last + 1;
                    end if;
                    
                    rcRegistro.tbCuenta(nuHash).cargcuco := rcCuenta.cargcuco;
                    rcRegistro.tbCuenta(nuHash).cucosacu := rcCuenta.cucosacu;
                    rcRegistro.tbCuenta(nuHash).cargnuse := rcCuenta.cargnuse;
                    rcRegistro.tbCuenta(nuHash).cargsusc := rcCuenta.cargsusc;
                    rcRegistro.tbCuenta(nuHash).cargconc := rcCuenta.cargconc;
                    rcRegistro.tbCuenta(nuHash).cargcaca := rcCuenta.cargcaca;
                    rcRegistro.tbCuenta(nuHash).cargsign := rcCuenta.cargsign;
                    rcRegistro.tbCuenta(nuHash).cargvalo := rcCuenta.cargvalo;
                    rcRegistro.tbCuenta(nuHash).cargdoso := rcCuenta.cargdoso;
                    rcRegistro.tbCuenta(nuHash).cargcodo := rcCuenta.cargcodo;
                    rcRegistro.tbCuenta(nuHash).cargunid := rcCuenta.cargunid;
                    rcRegistro.tbCuenta(nuHash).cargfecr := rcCuenta.cargfecr;
                    
                    nuContador := nuContador + 1;
                    
                end loop;
                
                tbRegistro(sbHash) := rcRegistro;
                
               
                pActualizaDatos(tbRegistro(sbHash));
                pGeneraciondeRastro(tbRegistro(sbHash));
                                
            exception
                when raise_continuar then
                    pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
                    nuErr := nuErr + 1;  
                    tbRegistro.delete(sbHash);
                when others then
                    sberror := sqlerrm;
                    --pkerrors.geterrorvar (nuerror, sberror);
                    sbComentario := 'Error 1.0|'||nuDiferido||'|'||nuSesunuse||
                    '|Error desconocido en analisis de cuentas|'||sberror;
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
        nuDiferido     := null;
        nuSesunuse     := null; 

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
                        nuDiferido := tbPrincipal(i).difecodi;
                        nuSesunuse := tbPrincipal(i).difenuse;
                                              
                        sbHash := lpad(nuDiferido,cnuHash,'0');
                        
                        if not tbRegistro.exists(sbHash) then
        
                            tbRegistro(sbHash).difecodi     := nuDiferido;
                            tbRegistro(sbHash).difenuse     := nuSesunuse;
                            tbRegistro(sbHash).sbActualiza  := 'N';
                            tbRegistro(sbHash).sbFlag       := 'N';
                            
                             nuTotal := nuTotal + 1;

                        else
                            sbComentario := 'Error 0.2|'||nuDiferido||'|'||nuSesunuse||
                            '|Diferido ya cargado|NA';
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
                            sbComentario := 'Error 0.0|'||nuDiferido||'|'||nuSesunuse||
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
                        
                        nuDiferido := to_number(tbCampos(1));
                        nuSesunuse := tbCampos(2);
                        nuLine := nuLine + 1;
                        
                        sbHash := lpad(nuDiferido,cnuHash,'0');
                        
                        if not tbRegistro.exists(sbHash) then
                        
                            tbRegistro(sbHash).difecodi     := nuDiferido;
                            tbRegistro(sbHash).difenuse     := nuSesunuse;
                            tbRegistro(sbHash).sbActualiza  := 'N';
                            tbRegistro(sbHash).sbFlag       := 'N';
                            
                            nuTotal := nuTotal + 1;                           
                        else
                            sbComentario := 'Error 0.2|'||nuDiferido||'|'||nuSesunuse||
                            '|Diferido ya cargado|NA';                            
                            raise raise_continuar;
                        end if;
                    else
                        sbComentario := 'Error 0.3|'||nuDiferido||'|'||nuSesunuse||
                        '|Los datos de entrada no pueden ser nulos ['||sbline||']|NA';
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
                        sbComentario := 'Error 0.0|'||nuDiferido||'|'||nuSesunuse||
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