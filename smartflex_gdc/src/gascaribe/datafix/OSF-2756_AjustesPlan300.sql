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
DEFINE CASO=OSF-2756

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
JIRA:           OSF-2756

Actualiza diferidos de descuentos de diferidos plan 300 y periodos de gracia

    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    28/05/2024 - jcatuchemvm
    Creación
    
***********************************************************/
declare
    --Constantes para el datafix
    csbCaso         constant varchar2(20)   := 'OSF2756';
    csbTitulo       constant varchar2(2000) := csbCaso||': Ajustes Planes 300, diferidos periodos de gracia';
    cnuCuota        constant number         := 300;
    cnuDiasP        constant number         := 9125;
    cnugprd         constant number         := 51;
    csbEscritura    constant varchar2( 1 )  := 'w';
    csbLectura      constant varchar2( 1 )  := 'r';
    csbPIPE         constant varchar2( 1 )  := '|';
    cdtFecha        constant date           := sysdate;
    csbOutPut       constant varchar2(1)    := 'N';
    csbFormato      constant varchar2(25)   := 'DD/MM/YYYY HH24:MI:SS';
    csbFormatoL     constant varchar2(25)   := 'DDMMYYYY_HH24MI';
    cnuSegundo      constant number         := 1/86400;
    cnuLimit        constant number         := 1000;
    cnuIdErr        constant number         := 1;
    cnuHash         constant number         := 15;
    
    --Tipos de Registro
    type tytbDifes is table of diferido%rowtype index by binary_integer;
    
    type tyrcRegistro is record 
    (
        package_id          mo_packages.package_id%type,
        difecofi            diferido.difecofi%type,
        difefein            diferido.difefein%type,
        plan300             diferido.difepldi%type,
        plandesc            diferido.difepldi%type,
        plandescN           diferido.difepldi%type,
        tbdifes             tytbDifes,
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
        tipoarch    varchar2(1),
        flgprint    varchar2(1),
        flFile      utl_file.file_type,
        tblog       tyTabla
    );
    type tytbArchivos is table of tyrcArchivos index by binary_integer;
    tbArchivos      tytbArchivos;
    nuHash          number;
    sbRuta          parametr.pamechar%type;   
    
    --Cursores
    cursor cuPrincipal is 
    with sol as
    (
        SELECT s.PACKAGE_ID, COPCDEST plancart, COPCORIG planorig, M.SUBSCRIPTION_ID contrato
        FROM OPEN.mo_packages s, open.GC_DEBT_NEGOTIATION F, open.LDC_CONFPLCAES, open.mo_motive m
        WHERE  M.PACKAGE_ID = S.PACKAGE_ID
         AND S.PACKAGE_TYPE_ID = 328
        AND s.motive_status_id = 14
        AND s.package_id =  F.package_id
        AND f.PAYM_AGREEM_PLAN_ID = COPCORIG
        and COPCORIG in (182,183,184,185)
        AND EXISTS 
        ( 
            SELECT 1
            FROM open.LDC_SOLIPRPLCAES
            WHERE solicitud = s.PACKAGE_ID
            AND estado = 'T'
        )
        --and s.package_id = 211954418
    ), difes as
    (
        select  difecofi,difenuse,financing_request_id,max(difefein) difefein from diferido,CC_FINANCING_REQUEST,sol
        where financing_request_id = sol.package_id 
        and difecofi = financing_id 
        and difesape > 0
        group by difecofi,difenuse,financing_request_id
    ), concdesc as
    (
        select difecofi,difefein,package_id,planorig,plancart,C.CARGNUSE sesunuse,
        sesucicl,
        sesususc,
        max(cargfecr) cargfecr,
        (select case when nvl(conccore,-1) = -1 then conccodi else conccore end from concepto where  conccodi = c.cargconc) cargconc,
        sum(cargvalo) valor
        from notas, cargos c, cuencobr, servsusc,sol,difes
        where NOTAOBSE = 'NG-'||sol.package_id 
        and cucofact = notafact
        and cargcuco = cucocodi
        and cargcodo = notanume
        AND cargnuse = sesunuse
        AND CARGCACA = 21
        and CARGCONC IN  (select CDPFconc
                     from OPEN.CODEPLFI
                     where CDPFPLDI = sol.planorig)
        AND CARGSIGN = 'CR'
        and difenuse = cargnuse
        and difes.financing_request_id = sol.package_id
        group by difecofi,difefein,package_id,planorig,plancart,C.CARGNUSE, C.CARGCONC,  sesucicl, sesususc
        
    ), difeact as
    (
        select package_id sol300,c.difecofi cofi300,c.difefein fein300 ,planorig plan300,plancart plandesc,
        case when planorig in (182,184) then 192 when planorig in (183,185) then 191 else 0 end plandescN,d.*
        from concdesc c,diferido d
        where difenuse = sesunuse
        and difeconc = cargconc
        and difevatd = valor
        and difesape > 0
        and d.difefein > c.difefein
        and d.difepldi = plancart
    )
    select d.*,
    round(difevatd * ( (((((12 * ( POWER ((difeinte+difespre)/100.00 + 1, 1/12)  - 1 ) ) * 100)/1200)-(difefagr/100)) / ( 1 - ( POWER ((( 1 + (difefagr/100) ) / ( 1 + (((12 * ( POWER ((difeinte+difespre)/100.00 + 1, 1/12)  - 1 ) ) * 100)/1200) )), cnuCuota) ) ) ) ),0) difevacun
    from difeact d
    ;
    

    type tytbPrincipal is table of cuPrincipal%rowtype index by binary_integer;
    tbPrincipal     tytbPrincipal;
    
    cursor cuGracia (inudife in number) is
    select g.*,trunc(initial_date + cnuDiasP) end_DateN 
    from cc_grace_peri_defe g
    where deferred_id = inudife
    and end_date > sysdate;
    
    rcGracia    cuGracia%rowtype;
    
    
    nuerror         ge_error_log.message_id%TYPE;
    sberror         ge_error_log.description%TYPE; 
    sbcabecera      varchar2(2000);
    s_out           varchar2(2000);
    s_out2          varchar2(2000);
    nuOuts          number;     
    nuLine          number;
    nuTotal         number;
    nudifs          number;
    nugrace         number;
    nuErr           number;
    nuOk            number;
    nuWrng          number;
    nuContador      number;
    nuRowcount      number;
    raise_continuar exception;
    sbComentario    varchar2(2000);
    nuSolicitud     number;
    nudife          number;
    
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
        
        pkg_error.setapplication(csbCaso);
        sbRuta := '/smartfiles/tmp';
        
        nuLine      := 0;
        nuTotal     := 0;
        nudifs      := 0;
        nugrace     := 0;
        nuErr       := 0;    
        nuOk        := 0;  
        nuWrng      := 0;  
        nuContador  := 0;
        tbRegistro.delete;
        tbPrincipal.delete;
        tbArchivos.delete; 

        tbArchivos(1).nombre    := csbCaso||'_'||to_char(cdtFecha,csbFormatoL)||'_Log.txt';
        tbArchivos(2).nombre    := csbCaso||'_'||to_char(cdtFecha,csbFormatoL)||'_Diferidos.txt';
        tbArchivos(3).nombre    := csbCaso||'_'||to_char(cdtFecha,csbFormatoL)||'_PeriodosGracia.txt';
        
        
        --tbArchivos(1).nombre  := '--Log';
        --tbArchivos(2).nombre  := '--Población';
        
        tbArchivos(1).flgprint  := 'N';
        tbArchivos(1).flgprint  := 'S';
        tbArchivos(2).flgprint  := 'S';
        tbArchivos(3).flgprint  := 'S';
        
        tbArchivos(0).tipoarch :=  csbLectura;
        tbArchivos(1).tipoarch :=  csbEscritura;
        tbArchivos(2).tipoarch :=  csbEscritura;
        tbArchivos(3).tipoarch :=  csbEscritura;
       
        nuOuts := tbArchivos.last;
        
        sbCabecera := 'TipoError|Solicitud|Diferido|Mensaje|Error'; 
        tbArchivos(cnuIdErr).cabecera := sbCabecera;
        
        sbCabecera := 'Solicitud|CofiPlan300|FeinPl300|Plan300|PlanDesc|Difecodi|Difecofi|Difenuse|Difesusc|Difeconc|Difesign|Difevatd|Difesape|Difecupa|Difefein|Difefumo|Difenudo|';
        sbCabecera  := sbCabecera||'Difeinte|Difespre|Difefagr|Difetain|Difemeca|Difecoin|';
        sbCabecera  := sbCabecera||'Difenucu_ant|Difenucu_act|Difevacu_ant|Difevacu_act|Difepldi_ant|Difepldi_act|Actualiza';
        tbArchivos(2).cabecera := sbCabecera;
        
        sbCabecera := 'Solicitud|CofiPlan300|FeinPl300|Plan300|PlanDesc|Difecodi|GraceId|FechaInicial|GracePeriod_ant|GracePeriod_act|FechaFinal_ant|FechaFinal_act|Actualiza';
        tbArchivos(3).cabecera := sbCabecera;
        
        dbms_output.put_line(csbTitulo);
        
        
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
    
    Procedure pOpen(inuOut in number) IS
    Begin
        if csbOutPut != 'S' then
            if inuOut = 0 and tbArchivos(inuOut).flgprint = 'S' then
                -- Archivo de Entrada
                tbArchivos(inuOut).flFile := utl_file.fopen(sbRuta, tbArchivos(inuOut).nombre, tbArchivos(inuOut).tipoarch);
            elsif inuOut != 0 then
                tbArchivos(inuOut).flFile := utl_file.fopen(sbRuta, tbArchivos(inuOut).nombre, tbArchivos(inuOut).tipoarch);
            end if;        
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
                        sbComentario := 'Error -1|||Error en operacion "'||tbArchivos(i).tipoarch||
                        '" para el archivo "'||tbArchivos(i).nombre||'" en la ruta "'||sbRuta||'"|'||sqlerrm;
                        pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
                        raise;
                    else
                        dbms_output.put_line('Error -1|||Error no controlado en apertura de archivo '||tbArchivos(i).nombre||' ['||tbArchivos(i).tipoarch||']|'||sqlerrm);  
                        raise;
                    end if;
            end;                   
        end loop;        
    END pIniciaLog;
    
    PROCEDURE pCerrarLog IS
    BEGIN
        pGuardaLog(tbArchivos(cnuIdErr),'================================================');
        pGuardaLog(tbArchivos(cnuIdErr),'Finaliza la actualización '||csbCaso||'.' );
        pGuardaLog(tbArchivos(cnuIdErr),'Total de solicitudes detectadas : '||nuTotal);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de diferidos almacenadas : '||nuLine);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de diferidos actualizados : '||nudifs);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de periodos gracia actualizados : '||nugrace);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de Advertencias : '||nuWrng);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de Errores : '||nuErr);
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
        -- Indica que terminó el proceso en el archivo de salida
        pGuardaLog(tbArchivos(cnuIdErr),'================================================');
        pGuardaLog(tbArchivos(cnuIdErr),'Finaliza la actualización con Error '||csbCaso||': ' ||sqlerrm );
        pGuardaLog(tbArchivos(cnuIdErr),'Total de solicitudes detectadas : '||nuTotal);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de diferidos almacenadas : '||nuLine);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de diferidos actualizados : '||nudifs);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de periodos gracia actualizados : '||nugrace);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de Advertencias : '||nuWrng);
        pGuardaLog(tbArchivos(cnuIdErr),'Total de Errores : '||nuErr);
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
    
    PROCEDURE pGeneraciondeRastro(ircdifes in out diferido%rowtype,inuPlan in number,inucuota in number, inuvacu in number) is
    begin
        
        s_out2 := nudife;
        s_out2 := s_out2||'|'||ircdifes.difecofi;
        s_out2 := s_out2||'|'||ircdifes.difenuse;
        s_out2 := s_out2||'|'||ircdifes.difesusc;
        s_out2 := s_out2||'|'||ircdifes.difeconc;
        s_out2 := s_out2||'|'||ircdifes.difesign;
        s_out2 := s_out2||'|'||ircdifes.difevatd;
        s_out2 := s_out2||'|'||ircdifes.difesape;
        s_out2 := s_out2||'|'||ircdifes.difecupa;
        s_out2 := s_out2||'|'||to_char(ircdifes.difefein,csbFormato);
        s_out2 := s_out2||'|'||to_char(ircdifes.difefumo,csbFormato);
        s_out2 := s_out2||'|'||ircdifes.difenudo;
        s_out2 := s_out2||'|'||ircdifes.difeinte;
        s_out2 := s_out2||'|'||ircdifes.difespre;
        s_out2 := s_out2||'|'||ircdifes.difefagr;
        s_out2 := s_out2||'|'||ircdifes.difetain;
        s_out2 := s_out2||'|'||ircdifes.difemeca;
        s_out2 := s_out2||'|'||ircdifes.difecoin;
        s_out2 := s_out2||'|'||ircdifes.difenucu;
        s_out2 := s_out2||'|'||inucuota;
        s_out2 := s_out2||'|'||ircdifes.difevacu;
        s_out2 := s_out2||'|'||inuvacu;
        s_out2 := s_out2||'|'||ircdifes.difepldi;
        s_out2 := s_out2||'|'||inuPlan;
        s_out2 := s_out2||'|'||'S';
        

        pGuardaLog(tbArchivos(2),s_out||'|'||s_out2);
            
        if rcGracia.deferred_id is not null then
            s_out2 := nudife;
            s_out2 := s_out2||'|'||rcGracia.grace_peri_defe_id;
            s_out2 := s_out2||'|'||to_char(rcGracia.initial_date,csbformato);
            s_out2 := s_out2||'|'||rcGracia.grace_period_id;
            s_out2 := s_out2||'|'||cnugprd;
            s_out2 := s_out2||'|'||to_char(rcGracia.end_date,csbformato);
            s_out2 := s_out2||'|'||to_char(rcGracia.end_dateN,csbformato);
            s_out2 := s_out2||'|'||'S';
            
            pGuardaLog(tbArchivos(3),s_out||'|'||s_out2);
            
        end if;
        
        
    exception
        when others then
            --sberror := sqlerrm;
            pkg_error.seterror;
            pkg_error.geterror (nuError, sberror);
            sbComentario := 'Error 3.0|'||nuSolicitud||'|'||nudife||
            '|Error en impresión de información|'||sberror;
            pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
            nuErr := nuErr + 1;            
    END pGeneraciondeRastro;
    
    PROCEDURE pActualizaDatos(ircdifes in out diferido%rowtype,inuPlan in number,inucuota in number, inuvacu in number) is
    begin
        
        savepoint sp_Diferido;
        
        update diferido
        set difenucu = inucuota,
        difepldi = inuPlan,
        difevacu = inuvacu
        where difecodi = ircdifes.difecodi;
        
        nuRowcount := sql%rowcount;
                
        if nuRowcount != 1 then
            sbComentario := 'Error 2.1|'||nuSolicitud||'|'||nudife||
            '|Actualización del diferido diferente al esperado ['||nuRowcount||']|NA';
            raise raise_continuar;
        else
            nudifs := nudifs + 1;
            rcGracia := null;
            open cuGracia(ircdifes.difecodi);
            fetch cuGracia into rcGracia;
            close cuGracia;
            
            if rcGracia.deferred_id is null then
                sbComentario := 'Wrng 2.1|'||nuSolicitud||'|'||nudife||
                '|Diferido no cuenta con periodo de gracia|NA';
                pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
                nuwrng := nuwrng + 1;
            elsif rcGracia.grace_period_id != 41 then
                sbComentario := 'Wrng 2.2|'||nuSolicitud||'|'||nudife||
                '|Tipo de periodo de gracia diferente al esperado ['||rcGracia.grace_period_id||']|NA';
                pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
                nuwrng := nuwrng + 1;
            elsif rcGracia.grace_period_id = cnugprd and (rcGracia.end_date - rcGracia.initial_date) > 9000 then
                sbComentario := 'Wrng 2.2|'||nuSolicitud||'|'||nudife||
                '|El periodo de gracia ya se encuentra actualizado ['||rcGracia.grace_period_id||']['||to_char(rcGracia.end_date,csbformato)||']|NA';
                pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
                nuwrng := nuwrng + 1;
            else
                
                update cc_grace_peri_defe
                set grace_period_id = cnugprd,
                end_date = rcGracia.end_dateN
                where grace_peri_defe_id = rcGracia.grace_peri_defe_id;
                
                nuRowcount := sql%rowcount;
                
                if nuRowcount != 1 then
                    sbComentario := 'Error 2.2|'||nuSolicitud||'|'||nudife||
                    '|Actualización del periodo de gracia diferente al esperado ['||nuRowcount||']|NA';
                    raise raise_continuar;
                end if;
                
                nugrace := nugrace + 1;
                
            end if;
            
            pGeneraciondeRastro(ircdifes,inuPlan,inucuota,inuvacu);
            
        end if;
        
    exception 
        when raise_continuar then
            rollback to sp_Diferido;
            nudifs := nudifs - 1;
            nugrace := nugrace - 1;
            raise;
        when others then
            pkg_error.Seterror;
            pkg_error.geterror( nuerror, sberror );
            sbComentario := 'Error 2.0|'||nuSolicitud||'|'||nudife||
            '|Error No Controlado en actualiazación|'||nuerror||'-'||sberror;
            rollback to sp_Diferido;
            nudifs := nudifs - 1;
            nugrace := nugrace - 1; 
            raise raise_continuar;
    END pActualizaDatos; 
    
    
    PROCEDURE pAnalizaDatos is
        rcRegistro  tyrcRegistro;
        
        cursor cuvalida (inudife in number) is
        select difecodi,
        (select suscnupr from suscripc where susccodi = difesusc) suscnupr,
        (select count(*) from cargos where cargnuse = difenuse and cargcuco = -1 and cargprog = 5) cargfact,difesape,difenucu,difepldi,difevacu
        from diferido
        where difecodi = inudife
        ;
        
        rcvalida    cuvalida%rowtype;
        nuDifenucu  number;
        nuDifevacu  number;
        
        exceptmp    exception;
    BEGIN
        nuSolicitud     := null;
        nudife          := null; 

        sbHash := tbRegistro.first;
        if sbHash is null then
            sbComentario := 'Error 1.1|'||nuSolicitud||'|'||nudife||
            '|Sin solicitudes para análisis|NA';
            raise raise_continuar;
        end if;

        loop
            rcRegistro := null;
            rcRegistro := tbRegistro(sbHash);
            nuSolicitud := rcRegistro.package_id;
            
            s_out := nuSolicitud;
            s_out := s_out||'|'||rcRegistro.difecofi;
            s_out := s_out||'|'||to_char(rcRegistro.difefein,csbformato);
            s_out := s_out||'|'||rcRegistro.plan300;
            s_out := s_out||'|'||rcRegistro.plandesc;
            
            begin
                -- Evalua diferidos 
                nuHash := rcRegistro.tbdifes.first;
                nudife := null;
                if nuHash is null then
                    sbComentario := 'Error 1.2|'||nuSolicitud||'|'||nudife||
                    '|Sin diferidos para analizar|NA';
                    rcRegistro.sbFlag := 'S';
                    raise raise_continuar;
                end if;
                
                for i in rcRegistro.tbdifes.first..rcRegistro.tbdifes.last loop
                    nuHash := i;
                    nudife := rcRegistro.tbdifes(nuHash).difecodi;
                    
                    begin
                        rcvalida := null;
                        open cuvalida (nudife);
                        fetch cuvalida into rcvalida;
                        close cuvalida;

                        if rcvalida.difecodi  is null then
                            sbComentario := 'Error 1.3|'||nuSolicitud||'|'||nudife||
                            '|Diferido no existe en la BD|NA';
                            raise raise_continuar;
                        elsif rcvalida.cargfact > 0 or rcvalida.suscnupr > 0 then
                            sbComentario := 'Error 1.4|'||nuSolicitud||'|'||nudife||
                            '|Producto en proceso de facturación o con cargos a la -1 ['||rcValida.suscnupr||'-'||rcValida.cargfact||'|NA';
                            raise exceptmp;
                        elsif rcvalida.difenucu in (cnuCuota,1) and rcvalida.difepldi = rcRegistro.plandescN then
                            sbComentario := 'Error 1.5|'||nuSolicitud||'|'||nudife||
                            '|Diferido ya cuenta con el plan y cuotas requeridas ['||rcvalida.difepldi||']['||rcvalida.difenucu||']|NA';
                            raise raise_continuar;
                        elsif rcvalida.difenucu not in (120,1) then
                            sbComentario := 'Error 1.6|'||nuSolicitud||'|'||nudife||
                            '|Diferido de descuento con cuotas diferentes a las esperadas ['||rcvalida.difenucu||']|NA';
                            raise raise_continuar;
                        elsif rcvalida.difepldi not in (146,144) then
                            sbComentario := 'Error 1.7|'||nuSolicitud||'|'||nudife||
                            '|Diferido de descuento con planes diferentes a los esperadas ['||rcvalida.difepldi||']|NA';
                            raise raise_continuar;
                        elsif rcvalida.difesape <= 0 then 
                            sbComentario := 'Error 1.8|'||nuSolicitud||'|'||nudife||
                            '|Diferido de descuento sin saldo ['||rcvalida.difesape||']|NA';
                            raise raise_continuar;
                        end if;
                        
                        nuDifenucu := null;
                        nuDifevacu := null;
                        
                        nuDifenucu := case when rcRegistro.tbdifes(nuHash).difenucu = 1 then 1 else cnuCuota end;
                        nuDifevacu := case when rcRegistro.tbdifes(nuHash).difenucu = 1 then rcRegistro.tbdifes(nuHash).difevatd else rcRegistro.tbdifes(nuHash).difeinac end;
                        
                        if rcvalida.difenucu != 1 and rcvalida.difevacu < nuDifevacu then 
                            sbComentario := 'Error 1.9|'||nuSolicitud||'|'||nudife||
                            '|Error en cálculo de cuota ['||rcvalida.difevacu||'/'||nuDifevacu||']|NA';
                            raise raise_continuar;
                        end if;
                        
                        pActualizaDatos(rcRegistro.tbdifes(nuHash),rcRegistro.plandescN,nuDifenucu,nuDifevacu);
                            
                    exception
                        when exceptmp then
                            raise raise_continuar;
                        when raise_continuar then
                            pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
                            nuerr := nuerr + 1;
                        when others then
                            raise;                            
                    end;
                        
                end loop;
               
            exception
                when raise_continuar then
                    pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
                    nuErr := nuErr + 1;  
                when others then
                    --sberror := sqlerrm;
                    pkg_error.seterror;
                    pkg_error.geterror (nuerror, sberror);
                    sbComentario := 'Error 1.0|'||nuSolicitud||'|'||nudife||
                    '|Error desconocido en analisis de registros|'||sberror;
                    pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
                    nuErr := nuErr + 1;
            end;
            
            commit;
            
            tbRegistro.delete(sbHash);
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
        nudife          := null; 

        open cuPrincipal;
        loop
            tbPrincipal.delete;
            fetch cuPrincipal bulk collect into tbPrincipal limit cnuLimit;
            exit when tbPrincipal.count = 0; 

            for i in 1..tbPrincipal.count loop 
                begin
                    nuLine := nuLine+ 1;
                    nuSolicitud := tbPrincipal(i).sol300;
                    nuDife := tbPrincipal(i).difecodi;
                                          
                    sbHash := lpad(nuSolicitud,cnuHash,'0');
                    
                    if not tbRegistro.exists(sbHash) then
    
                        tbRegistro(sbHash).package_id   := nuSolicitud;
                        tbRegistro(sbHash).difecofi     := tbPrincipal(i).cofi300;
                        tbRegistro(sbHash).difefein     := tbPrincipal(i).fein300;
                        tbRegistro(sbHash).plan300      := tbPrincipal(i).plan300;
                        tbRegistro(sbHash).plandesc     := tbPrincipal(i).plandesc;
                        tbRegistro(sbHash).plandescN    := tbPrincipal(i).plandescN;
                        
                        tbRegistro(sbHash).sbActualiza  := 'N';
                        tbRegistro(sbHash).sbFlag       := 'N';
                        
                        nuHash := 1;
                        tbRegistro(sbHash).tbdifes(nuHash).difecodi := nudife;
                        tbRegistro(sbHash).tbdifes(nuHash).difenuse := tbPrincipal(i).difenuse;
                        tbRegistro(sbHash).tbdifes(nuHash).difesusc := tbPrincipal(i).difesusc;
                        tbRegistro(sbHash).tbdifes(nuHash).difeconc := tbPrincipal(i).difeconc;
                        tbRegistro(sbHash).tbdifes(nuHash).difevatd := tbPrincipal(i).difevatd;
                        tbRegistro(sbHash).tbdifes(nuHash).difevacu := tbPrincipal(i).difevacu;
                        tbRegistro(sbHash).tbdifes(nuHash).difecupa := tbPrincipal(i).difecupa;
                        tbRegistro(sbHash).tbdifes(nuHash).difenucu := tbPrincipal(i).difenucu;
                        tbRegistro(sbHash).tbdifes(nuHash).difesape := tbPrincipal(i).difesape;
                        tbRegistro(sbHash).tbdifes(nuHash).difenudo := tbPrincipal(i).difenudo;
                        tbRegistro(sbHash).tbdifes(nuHash).difeinte := tbPrincipal(i).difeinte;
                        tbRegistro(sbHash).tbdifes(nuHash).difesign := tbPrincipal(i).difesign;
                        tbRegistro(sbHash).tbdifes(nuHash).difemeca := tbPrincipal(i).difemeca;
                        tbRegistro(sbHash).tbdifes(nuHash).difecoin := tbPrincipal(i).difecoin;
                        tbRegistro(sbHash).tbdifes(nuHash).difepldi := tbPrincipal(i).difepldi;
                        tbRegistro(sbHash).tbdifes(nuHash).difefein := tbPrincipal(i).difefein;
                        tbRegistro(sbHash).tbdifes(nuHash).difefumo := tbPrincipal(i).difefumo;
                        tbRegistro(sbHash).tbdifes(nuHash).difespre := tbPrincipal(i).difespre;
                        tbRegistro(sbHash).tbdifes(nuHash).difetain := tbPrincipal(i).difetain;
                        tbRegistro(sbHash).tbdifes(nuHash).difefagr := tbPrincipal(i).difefagr;
                        tbRegistro(sbHash).tbdifes(nuHash).difecofi := tbPrincipal(i).difecofi;
                        tbRegistro(sbHash).tbdifes(nuHash).difeinac := tbPrincipal(i).difevacun;
                        
                        nuTotal := nuTotal + 1;

                    else
                        nuHash := tbRegistro(sbHash).tbdifes.last + 1;
                        tbRegistro(sbHash).tbdifes(nuHash).difecodi := nudife;
                        tbRegistro(sbHash).tbdifes(nuHash).difenuse := tbPrincipal(i).difenuse;
                        tbRegistro(sbHash).tbdifes(nuHash).difesusc := tbPrincipal(i).difesusc;
                        tbRegistro(sbHash).tbdifes(nuHash).difeconc := tbPrincipal(i).difeconc;
                        tbRegistro(sbHash).tbdifes(nuHash).difevatd := tbPrincipal(i).difevatd;
                        tbRegistro(sbHash).tbdifes(nuHash).difevacu := tbPrincipal(i).difevacu;
                        tbRegistro(sbHash).tbdifes(nuHash).difecupa := tbPrincipal(i).difecupa;
                        tbRegistro(sbHash).tbdifes(nuHash).difenucu := tbPrincipal(i).difenucu;
                        tbRegistro(sbHash).tbdifes(nuHash).difesape := tbPrincipal(i).difesape;
                        tbRegistro(sbHash).tbdifes(nuHash).difenudo := tbPrincipal(i).difenudo;
                        tbRegistro(sbHash).tbdifes(nuHash).difeinte := tbPrincipal(i).difeinte;
                        tbRegistro(sbHash).tbdifes(nuHash).difesign := tbPrincipal(i).difesign;
                        tbRegistro(sbHash).tbdifes(nuHash).difemeca := tbPrincipal(i).difemeca;
                        tbRegistro(sbHash).tbdifes(nuHash).difecoin := tbPrincipal(i).difecoin;
                        tbRegistro(sbHash).tbdifes(nuHash).difepldi := tbPrincipal(i).difepldi;
                        tbRegistro(sbHash).tbdifes(nuHash).difefein := tbPrincipal(i).difefein;
                        tbRegistro(sbHash).tbdifes(nuHash).difefumo := tbPrincipal(i).difefumo;
                        tbRegistro(sbHash).tbdifes(nuHash).difespre := tbPrincipal(i).difespre;
                        tbRegistro(sbHash).tbdifes(nuHash).difetain := tbPrincipal(i).difetain;
                        tbRegistro(sbHash).tbdifes(nuHash).difefagr := tbPrincipal(i).difefagr;
                        tbRegistro(sbHash).tbdifes(nuHash).difecofi := tbPrincipal(i).difecofi;
                        tbRegistro(sbHash).tbdifes(nuHash).difeinac := tbPrincipal(i).difevacun;
                        
                        
                    end if; 

                exception
                    when others then
                        --sberror := sqlerrm;
                        pkg_error.seterror;
                        pkg_error.geterror (nuerror, sberror);
                        sbComentario := 'Error 0.0|'||nuSolicitud||'|'||nudife||
                        '|Error desconocido en generación de datos de poblacion|'||sberror;
                        pGuardaLog(tbArchivos(cnuIdErr),sbComentario); 
                        nuErr := nuErr + 1;
                        tbRegistro(sbHash).sbFlag := 'S';
                end;
            end loop; 

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

PROMPT **** FIN EJECUCIÓN ****
PROMPT CASO             : &CASO
PROMPT Fecha fin        : &fecha_fin
PROMPT =========================================

set timing off
set serveroutput off
quit
/
