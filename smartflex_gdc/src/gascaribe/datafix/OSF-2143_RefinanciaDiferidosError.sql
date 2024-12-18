column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set linesize 1000
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
/***********************************************************
ELABORADO POR:  Juan Gabriel Catuche Giron
EMPRESA:        MVM Ingenieria de Software
FECHA:          Noviembre 2023
JIRA:           OSF-2143

Refinancia diferidos con error en pago de cuotas
Trbaja con tablas físicas, hilos mediante Jobs 

    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    OSF1976_RefinanciaDiferidosError_yyyymmdd_hh24mi.txt
    
    --Modificaciones    
    29/11/2023 - jcatuchemvm
    Creación
    
***********************************************************/
declare
    gsbChainJobs    VARCHAR2(30) := 'CADENA_JOBS_OSF1976';
    gsbProgram      VARCHAR2(2000) := 'OSF2143';
    gnu_TOTAL_HILOS NUMBER := 1;
    
    sbCreaTabla         VARCHAR2(4000);
    sbCreaTabla2        VARCHAR2(4000);
    sbPueblaTabla       VARCHAR2(4000);
    sbCreProcedimiento  VARCHAR2(20000);
    sbBorraObjetos      VARCHAR2(4000);
    nuError             NUMBER;
    sbError             VARCHAR2(4000);
    
    CURSOR cuUSER_SCHEDULER_JOBS
    (
        isbJOB_NAME IN USER_SCHEDULER_JOBS.JOB_NAME%TYPE
    )
    IS
        SELECT  *
        FROM    USER_SCHEDULER_JOBS
        WHERE   JOB_NAME = isbJOB_NAME;
        
    rcUSER_SCHEDULER_JOBS       cuUSER_SCHEDULER_JOBS%ROWTYPE;  
    
begin
    --Inicializa sbCreaTabla, creación tabla
    sbCreaTabla := 
    '
    Declare 
        nuconta number;    
    BEGIN
        SELECT COUNT(1) INTO nuconta
        FROM DBA_TABLES
        WHERE TABLE_NAME = ''OSF1976TB'';

        IF nuconta = 0 THEN  
            EXECUTE IMMEDIATE ''CREATE TABLE OPEN.OSF1976TB
            (  
                DIFECODI    NUMBER(15),
                CONSTRAINT PK_OSF1976TB PRIMARY KEY (DIFECODI)
            )'';
                                                                
        END IF;

        EXECUTE IMMEDIATE ''grant select, insert, delete, update on OPEN.OSF1976TB to SYSTEM_OBJ_PRIVS_ROLE'';
        EXECUTE IMMEDIATE ''grant select on OPEN.OSF1976TB to RSELOPEN'';
        EXECUTE IMMEDIATE ''grant select on OPEN.OSF1976TB to reportes'';  
        EXECUTE IMMEDIATE ''grant select on OPEN.OSF1976TB to USELOPEN'';
    exception   
        when others then
            null;
    end;
    ';
    
    --Inicializa sbCreaTabla2, creación tabla de log
    sbCreaTabla2 := 
    '
    Declare 
        nuconta number;    
    BEGIN
        SELECT COUNT(1) INTO nuconta
        FROM DBA_TABLES
        WHERE TABLE_NAME = ''OSF1976LOG'';

        IF nuconta = 0 THEN  
            EXECUTE IMMEDIATE ''CREATE TABLE OPEN.OSF1976LOG
            (  
                PROCESO     VARCHAR2(20),
                FECHA       DATE,
                CONSECUTIVO NUMBER(8),
                LOG         VARCHAR2(2000)
            )'';
            
                                                                
        END IF;
        
        EXECUTE IMMEDIATE ''CREATE INDEX OPEN.IX_OSF1976LOG_PROCESO ON OPEN.OSF1976LOG(PROCESO)'';
        EXECUTE IMMEDIATE ''CREATE INDEX OPEN.IX_OSF1976LOG_FECHA ON OPEN.OSF1976LOG(FECHA)'';

        EXECUTE IMMEDIATE ''grant select, insert, delete, update on OPEN.OSF1976LOG to SYSTEM_OBJ_PRIVS_ROLE'';
        EXECUTE IMMEDIATE ''grant select on OPEN.OSF1976LOG to RSELOPEN'';
        EXECUTE IMMEDIATE ''grant select on OPEN.OSF1976LOG to USELOPEN'';
    exception   
        when others then
            null;    
    end;
    ';
    
    --Inicializa sbPueblaTabla, Población de tabla creada
    sbPueblaTabla := 
    '
    declare
        cnuLimit    constant number         := 1000;
        
        cursor cudata is
        select Difecodi
        from diferido d
        where 1 = 1
        and difesape > 0 
        and difecupa > difenucu 
        and difemeca = 8
        --order by difeconc
        ;
        
        type tytbData is table of cudata%rowtype index by binary_integer;
        tbData      tytbData;
        tbDataTmp   tytbData;
        nuHash      binary_integer;
    begin
        
        EXECUTE IMMEDIATE ''TRUNCATE TABLE OPEN.OSF1976TB'';
        
        open cuData;
        loop
            tbDataTmp.delete;
            fetch cuData bulk collect into tbDataTmp limit cnuLimit;
            exit when tbDataTmp.count = 0; 
            
            for i in 1..tbDataTmp.count loop 
                
                if tbData.first is null then
                    nuHash := 1;
                else
                    nuHash := tbData.last + 1;
                end if;
                
                tbData(nuHash).difecodi := tbDataTmp(i).difecodi;
            
            end loop;
            
            exit when tbDataTmp.count < cnuLimit; 
            
        end loop;
        close cuData;       
        
        forall nuHash in tbData.first..tbData.last  
            insert into OPEN.OSF1976TB
            values
            (
                tbData(nuHash).difecodi
            );
        
        commit;
    END;
    ';
    
    --Inicializa sbCreProcedimiento, crea procedimiento para proceso por hilos
    sbCreProcedimiento := 
    '
    CREATE OR REPLACE PROCEDURE open.OSF1976(inuHilo in number) IS
        cdtfecha    constant date           := sysdate;
        csbformato  constant varchar2(25)   := ''dd/mm/yyyy hh24:mi:ss''; 
        csbCaso     constant varchar2(10)   := ''OSF-2143'';
        csbTitulo   constant varchar2(200)  := csbCaso||'': Refinancia diferidos con error'';
        csbArchivo  constant varchar2(200)  := replace(csbCaso,''-'','''')||''_RefinanciaDiferidosError_''||inuHilo||''_''||to_char(cdtfecha,''yyyymmdd_hh24mi'')||''.txt'';
            
        cursor cutbl is
        select * from OPEN.OSF1976TB
        --where mod(difecodi,4) = inuHilo-1
        --and rownum < 251
        ;
        
        
        cursor cuData(inudife in number) is
        select Difecodi,Difenuse,Difesusc,Difeconc,Difevatd,Difecupa,Difenucu,Difevacu,Difesape,Difesign,
        Difeprog,Difefein,Difecoin,Difespre,Difetain,Difemeca,Difepldi,Difecofi,Difeinte
        from diferido d
        where d.difecodi = inudife;
        
        rcData      cudata%rowtype;
      
        cursor cuvalida (inusesu in number) is
        select 
        (select suscnupr from suscripc,servsusc where susccodi = sesususc and sesunuse = inusesu) suscnupr,
        (select count(*) from cargos where cargnuse = inusesu and cargcuco = -1 and cargprog = 5) cargfact
        from dual
        ;
        
        rcvalida    cuvalida%rowtype;
        
        cursor cuvalidacta (inudife in number) is
        select /*+ index (d pk_diferido) user_nl ( d c )
        index ( c IX_CARGOS010 ) */
        (select cucofact from cuencobr where cucocodi = cargcuco) cucofact,
        (select count(*) from cargos a where a.cargcuco = c.cargcuco and a.cargsign != ''AS'') cargcant,c.*
        from diferido d, cargos c
        where difecodi = inudife
        and cargnuse = difenuse
        and cargdoso = ''DF-''||difecodi
        and cargfecr > sysdate-60/86400
        and cargprog = 701
        and cargconc = difeconc
        ;
        
        rcvalidacta  cuvalidacta%rowtype;
        
        cursor cudife (inucofi in number) is
        SELECT  *
        FROM    DIFERIDO
        WHERE   DIFECOFI = inucofi
        AND     ROWNUM <= 1;
        
        rcdife cudife%rowtype;
        
        nucontador   number;
        nucontador2  number;
        sbActualiza  varchar2(200);
        sbComentario varchar2(2000);
        
        nuok         number;
        nuerr        number;
        nuctaneg     number;
        nuctacer     number;
        nuctapeq     number;
        nuctacvd     number;
        
        flout        utl_file.file_type;
        sbRuta       parametr.pamechar%type;
        sblinea      varchar2(2000);
        
        
        s_out       varchar2(2000);
        s_out2      varchar2(2000);
        sbescenario varchar2(1000);
        
        
        sberror     varchar2(2000);
        nuerror     number;
        raise_continuar     exception;
        nuNumProdsFinanc    number;
        nuAcumCuota         number;
        nuSaldo             number;
        nuTotalAcumCapital  number;
        nuTotalAcumCuotExtr number;
        nuTotalAcumInteres  number;
        sbRequiereVisado    varchar2(1);
        nuDifeCofi          number;
        
        
        
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
            sbRetorno := TO_CHAR( nuHoras ) ||''h '';
            -- Resta las horas para obtener los minutos
            nuTiempo := nuTiempo - ( nuHoras * 3600 );
            -- Obtiene los minutos
            nuMinutos := TRUNC( nuTiempo / 60 );
            -- Publica los minutos
            sbRetorno := sbRetorno ||TO_CHAR( nuMinutos ) ||''m '';
            -- Resta los minutos y obtiene los segundos redondeados a dos decimales
            nuTiempo := TRUNC( nuTiempo - ( nuMinutos * 60 ), 2 );
            -- Publica los segundos
            sbRetorno := sbRetorno ||TO_CHAR( nuTiempo ) ||''s'';
            -- Retorna el tiempo
            RETURN( sbRetorno );
        EXCEPTION
            WHEN OTHERS THEN
                -- No se eleva excepcion, pues no es parte fundamental del proceso
                RETURN NULL;
        END fnc_rs_CalculaTiempo;
        
        procedure procescribe(isbmensaje in varchar)
        is
            PRAGMA AUTONOMOUS_TRANSACTION;
        begin
            --dbms_output.put_line(isbmensaje);
            nucontador2 := nucontador2 + 1;
            --Utl_file.put_line(flout,isbmensaje,TRUE);
            
            insert into OSF1976LOG
            values(''OSF2143_''||inuHilo,to_char(cdtfecha,''dd/mm/yyyy hh24:mi''),nucontador2,isbmensaje);
            commit;
            
        exception
            when others then
                dbms_output.put_line(''Error en escritura de linea. ''||sqlerrm);
        end procescribe;
        
        
       
        
    begin
        nuok := 0;
        nuerr := 0;
        nuctaneg := 0;
        nuctacer := 0;
        nuctapeq := 0;
        nuctacvd := 0;
        nucontador2 := 0;
        
        sbRuta := ''/smartfiles/tmp''; 
        --flout := utl_file.fopen(sbRuta,csbArchivo,''w'');
        
        
        dbms_output.enable;
        dbms_output.enable (buffer_size => null);
        
        --procescribe(csbTitulo);
        sblinea := ''Difecodi|Difenuse|Difesusc|Difeconc|Difevatd|Difecupa|Difenucu|Difevacu|Difesape|Difesign|'';
        Sblinea := Sblinea||''Difeprog|Difefein|Difecoin|Difeespre|Difetain|Difemeca|Difepldi|'';
        Sblinea := Sblinea||''Factura|Cuenta|DifecodiN|DifecofiN|DifesapeN|DifeprogN|DifenudoN|DifevatdN|DifecupaN|DifenucuN|DifevacuN|DifepldiN|DifemecaN|'';
        Sblinea := Sblinea||''Actualiza|Escenario|Comentario|Error'';
        procescribe(sblinea);
        nucontador := 0;
        
        for rctb in cutbl loop    
            begin
                s_out2 := null;
                sbcomentario := null;
                sbActualiza := ''N'';
                nucontador := nucontador + 1;
                
                rcData := null;
                open cuData (rctb.difecodi);
                fetch cuData into rcData;
                close cuData;
                
                if rcData.difecodi is null  then
                    sbActualiza := ''N'';
                    sbescenario := ''NA'';
                    sbComentario := ''No existe el diferido|''||rctb.difecodi;
                    s_out := ''||||||||||||||||'';
                    nuerr := nuerr + 1;
                    raise raise_continuar;
                end if;
                
                s_out := rcData.difecodi;
                s_out := s_out||''|''||rcData.difenuse;
                s_out := s_out||''|''||rcData.difesusc;
                s_out := s_out||''|''||rcData.difeconc;
                s_out := s_out||''|''||rcData.difevatd;
                s_out := s_out||''|''||rcData.difecupa;
                s_out := s_out||''|''||rcData.difenucu;
                s_out := s_out||''|''||rcData.difevacu;
                s_out := s_out||''|''||rcData.difesape;
                s_out := s_out||''|''||rcData.difesign;
                s_out := s_out||''|''||rcData.difeprog;
                s_out := s_out||''|''||to_char(rcData.difefein,csbformato);
                s_out := s_out||''|''||rcData.difecoin;
                s_out := s_out||''|''||rcData.difespre;
                s_out := s_out||''|''||rcData.difetain;
                s_out := s_out||''|''||rcData.difemeca;
                s_out := s_out||''|''||rcData.difepldi;
                
                if rcData.difesape <= 0 then
                    sbActualiza := ''N'';
                    sbescenario := ''NA'';
                    sbComentario := ''El diferido ya no tiene saldo pendiente|''||rcData.difesape;
                    nuerr := nuerr + 1;
                    raise raise_continuar;
                elsif rcData.difecupa <= rcData.difenucu then
                    sbActualiza := ''N'';
                    sbescenario := ''NA'';
                    sbComentario := ''El diferido ya no tiene las cuotas facturadas mayores a las pactadas|''||rcData.difecupa||''-''||rcData.difenucu;
                    nuerr := nuerr + 1;
                    raise raise_continuar;
                elsif rcData.difemeca != 8 then
                    sbActualiza := ''N'';
                    sbescenario := ''NA'';
                    sbComentario := ''El diferido tiene un método diferentes al esperado|''||rcData.difemeca;
                    nuerr := nuerr + 1;
                    raise raise_continuar;
                end if;
                
                --validación de facturación
                rcvalida := null;
                open cuvalida (rcData.difenuse);
                fetch cuvalida into rcvalida;
                close cuvalida;

                if rcvalida.cargfact > 0 or rcvalida.suscnupr > 0 then
                    sbActualiza := ''N'';
                    sbescenario := ''NA'';
                    sbComentario := ''El producto se está facturando o tiene cargos a la -1|''||rcValida.suscnupr||''-''||rcValida.cargfact;
                    nuerr := nuerr + 1;
                    raise raise_continuar;
                elsif rcData.difeprog = ''ANDM'' then
                    sbescenario := ''Planes Covid'';
                    nuctacvd := nuctacvd + 1;
                else
                    if rcData.difevacu < 0 then
                        sbescenario := ''Valor Cuota Negativa'';
                        nuctaneg := nuctaneg + 1;
                    elsif rcData.difevacu = 0 then
                        if rcData.difesape < 10000 then
                            sbescenario := ''Valor Cuota cero'';
                            nuctacer := nuctacer + 1;
                        else
                            sbActualiza := ''N'';
                            sbescenario := ''Valor Cuota cero'';
                            sbComentario := ''Revisión por Cartera'';
                            nuerr := nuerr + 1;
                            raise raise_continuar;
                        end if;
                    elsif rcData.difevacu > 0 then
                        sbescenario := ''Valor total pequeño'';
                        nuctapeq := nuctapeq + 1;
                    else
                        sbActualiza := ''N'';
                        sbescenario := ''Escenario no considerado'';
                        sbComentario := ''NA'';
                        nuerr := nuerr + 1;
                        raise raise_continuar;
                    end if;
                end if;
                
                --Asigna Programa
                --pkg_error.setApplication(rcData.difeprog);
                pkg_error.setApplication(''FINAN'');
                
                --Inicializa variables
                Cc_Bodeftocurtransfer.Globalinitialize;
                Cc_Bodeftocurtransfer.Adddefertocollect(rcData.difecodi);
                
                --Se realiza traslado
                Cc_Bodeftocurtransfer.Transferdebt
                ( 
                    isbprograma     => ''FTDU'',
                    onuerrorcode    => nuError,
                    osberrormessage => sbError
                );
                        
                if nuError != constants_per.oK then
                    sbActualiza := ''N'';
                    sbComentario := ''Error en traslado de diferido a corriente|''||sbError;
                    nuerr := nuerr + 1;
                    raise raise_continuar;
                end if;
                
                --valida cuenta creada 
                rcvalidacta := null;
                open cuvalidacta (rcData.difecodi);
                fetch cuvalidacta into rcvalidacta;
                close cuvalidacta;
                
                s_out2 := rcvalidacta.cucofact;
                s_out2 := s_out2||''|''||rcvalidacta.cargcuco;
                
                if rcvalidacta.cargcuco is null then
                    sbActualiza := ''N'';
                    sbComentario := ''No se encontró cuenta del traslado'';
                    nuerr := nuerr + 1;
                    raise raise_continuar;
                elsif rcvalidacta.cargvalo != rcData.difesape then
                    sbActualiza := ''N'';
                    sbComentario := ''El valor del traslado difiere del saldo pendiente del diferido|''||rcvalidacta.cargcuco||''-''||rcvalidacta.cargvalo;
                    nuerr := nuerr + 1;
                    raise raise_continuar;
                elsif rcvalidacta.cargcant != 1 then
                    sbActualiza := ''N'';
                    sbComentario := ''La cuenta del traslado tiene más de un cargo|''||rcvalidacta.cargcuco||''-''||rcvalidacta.cargcant;
                    nuerr := nuerr + 1;
                    raise raise_continuar;
                end if;
                
                --Genera financiación.  
                --Se realiza validacion sobre el saldo pendiente de la factura              
                if( pkBCAccountStatus.fnuGetBalance( rcvalidacta.cucofact ) = pkBillConst.CERO )then
                    sbActualiza := ''S'';
                    sbComentario := ''El saldo de la factura creada es cero'';
                    nuok := nuok + 1;
                    commit;
                    raise raise_continuar;
                end if;
                
                -- Se asigna el consecutivo de financiacion
                pkDeferredMgr.nuGetNextFincCode( nuDifeCofi );
                
                --Se instancian en la tabla temporal de saldos por concepto, los conceptos de la factura
                CC_BOFinancing.SetAccountStatus( rcvalidacta.cucofact, GE_BOConstants.csbYES, pkConstante.NO, pkConstante.NO );
                --Se actualiza la tabla temporal para que sean procesados solo los conceptos financiables
                CC_BCFinancing.SelectAllowedProducts( pkConstante.SI, nuNumProdsFinanc );
                -- Se ejecuta el proceso de financiación
                CC_BOFinancing.ExecDebtFinanc
                (
                    57, --rcData.difepldi,
                    rcData.difemeca,
                    sysdate,
                    rcData.difeinte,
                    rcData.difespre,
                    1,
                    ''RF''||rcData.difecodi,
                    pkBillConst.CIENPORCIEN,
                    pkBillConst.CERO,
                    PKCONSTANTE.SI,
                    ''FINAN'', --rcData.difeprog,
                    pkConstante.NO,
                    pkConstante.NO, 
                    nuDifeCofi,
                    nuAcumCuota,
                    nuSaldo,
                    nuTotalAcumCapital,
                    nuTotalAcumCuotExtr,
                    nuTotalAcumInteres,
                    sbRequiereVisado
                );
                
                -- Se guarda la informacion de la financiacion en la base de datos
                CC_BOFinancing.CommitFinanc;

                -- Se verifica si se generaron diferidos asociados a la financiacion
                if ( not CC_BCFinancing.fboExistDeferred( nuDifeCofi ) ) then
                    sbActualiza := ''N'';
                    sbComentario := ''No se creo diferido para la financiación|''||nuDifeCofi;
                    nuerr := nuerr + 1;
                    raise raise_continuar;
                else
                    
                    commit;
                    
                    nuok := nuok + 1;
                    
                    rcdife := null;
                    open cudife(nuDifeCofi);
                    fetch cudife into rcdife;
                    close cudife;
                    
                    sbActualiza := ''S'';
                    sbComentario := ''Realizado'';
                    
                    s_out2 := rcvalidacta.cucofact;
                    s_out2 := s_out2||''|''||rcvalidacta.cargcuco;
                    s_out2 := s_out2||''|''||rcdife.difecodi;
                    s_out2 := s_out2||''|''||nuDifecofi;
                    s_out2 := s_out2||''|''||rcdife.difesape;
                    s_out2 := s_out2||''|''||rcdife.difeprog;
                    s_out2 := s_out2||''|''||rcdife.difenudo;
                    s_out2 := s_out2||''|''||rcdife.difevatd;
                    s_out2 := s_out2||''|''||rcdife.difecupa;
                    s_out2 := s_out2||''|''||rcdife.difenucu;
                    s_out2 := s_out2||''|''||rcdife.difevacu;
                    s_out2 := s_out2||''|''||rcdife.difepldi;
                    s_out2 := s_out2||''|''||rcdife.difemeca;
                    
                    
                end if;
                
                procescribe(s_out||''|''||s_out2||''|''||sbActualiza||''|''||sbescenario||''|''||sbComentario);
                
            exception
                when raise_continuar then
                    rollback;
                    if s_out2 is null then
                        s_out2 := ''||||||||||||'';
                    else
                        s_out2 := s_out2||''|||||||||||'';
                    end if;
                    procescribe(s_out||''|''||s_out2||''|''||sbActualiza||''|''||sbescenario||''|''||sbComentario);
                when login_denied or pkg_error.CONTROLLED_ERROR then
                    pkg_error.getError(nuError,sbError);
                    rollback;
                    if s_out2 is null then
                        s_out2 := ''||||||||||||'';
                    else
                        s_out2 := s_out2||''|||||||||||'';
                    end if;
                    nuerr := nuerr + 1;
                    procescribe(s_out||''|''||s_out2||''|''||sbActualiza||''|''||sbescenario||''|''||''Error Controlado|''||sbError||''-''||sbComentario);
                when others then
                    rollback;
                    if s_out2 is null then
                        s_out2 := ''||||||||||||'';
                    else
                        s_out2 := s_out2||''|||||||||||'';
                    end if;
                    nuerr := nuerr + 1;
                    procescribe(s_out||''|''||s_out2||''|''||sbActualiza||''|''||sbescenario||''|''||''Error No Controlado|''||sqlerrm||''-''||sbComentario);
            end;
        end loop;
        procescribe(''=========Fin Hilo de Ejecución ''||inuHilo||''========'');
        procescribe(''Total de Diferidos encontrados ''||nucontador);
        procescribe(''Total de Diferidos Cuota negativa ''||nuctaneg);
        procescribe(''Total de Diferidos Cuota cero ''||nuctacer);
        procescribe(''Total de Diferidos Cuota pequeña ''||nuctapeq);
        procescribe(''Total de Diferidos Cuota Covid ''||nuctacvd);
        procescribe(''Total de Diferidos ajustados ''||nuok);
        procescribe(''Total de Errores ''||nuerr);
        procescribe(''Rango Total de Ejecución [''||to_char(cdtFecha,''dd/mm/yyyy'')||''][''||to_char(cdtFecha,''hh24:mi:ss'')||'' - ''||to_char(sysdate,''hh24:mi:ss'')||'']'');
        procescribe(''Tiempo Total de Ejecución [''||fnc_rs_CalculaTiempo(cdtFecha,sysdate)||'']'');
        
       
        if utl_file.is_open( flout ) then
            utl_file.fclose( flout );
        end if;
    END;
    ';
    
    --Inicializa sbBorraObjetos, Borra tabla, procedimiento y cadena de Jobs OSF1976
    sbBorraObjetos := 
    '
    declare
        CURSOR cuValida
        IS
        SELECT  count(*) cantidad
        FROM    USER_SCHEDULER_JOBS
        WHERE   JOB_NAME like ''OSF1976%''
        AND     STATE = ''SUCCEEDED''; 
        
        nuCantidad  number; 
        
        dtfecha date := sysdate+3600/86400;
    begin
        nuCantidad := 0;
        open cuValida;
        fetch cuValida into nuCantidad;
        close cuValida;
        
        if nuCantidad = 1 then
            --EXECUTE IMMEDIATE ''DROP TABLE OPEN.OSF1976TB''; 
            EXECUTE IMMEDIATE ''DROP PROCEDURE OPEN.OSF1976'';
            dbms_scheduler.drop_job(''OSF1976_1'',TRUE);
            --dbms_scheduler.drop_job(''OSF1976_2'',TRUE);
            --dbms_scheduler.drop_job(''OSF1976_3'',TRUE);
            --dbms_scheduler.drop_job(''OSF1976_4'',TRUE);
            dbms_scheduler.set_attribute
            (
                name                => ''JOBFINALIZA'',
                attribute           => ''END_DATE'',
                value               => dtfecha
            );
            dbms_scheduler.enable(''JOBFINALIZA'');
        end if;

    end;
    ';
    
    dbms_output.put_line('Crea Tabla Open.OSF1976TB');
    EXECUTE IMMEDIATE sbCreaTabla;
    
    dbms_output.put_line('Crea Tabla Open.OSF1976LOG');
    EXECUTE IMMEDIATE sbCreaTabla2;
    
    dbms_output.put_line('Puebla Tabla Open.OSF1976TB');
    EXECUTE IMMEDIATE sbPueblaTabla;
    
    dbms_output.put_line('Crea procedimiento Open.OSF1976');
    EXECUTE IMMEDIATE sbCreProcedimiento;
    
    dbms_output.put_line('Otorga permisos para procedimiento Open.OSF1976');
    EXECUTE IMMEDIATE 'grant execute on OPEN.OSF1976 to SYSTEM_OBJ_PRIVS_ROLE';
    
    dbms_output.put_line('Programación de Jobs');
    --Gestión de Jobs
    FOR nuHilo IN  1..gnu_TOTAL_HILOS LOOP
        --Crea Job
        begin
            rcUSER_SCHEDULER_JOBS := NULL;
            open cuUSER_SCHEDULER_JOBS('OSF1976_'||nuHilo);
            fetch cuUSER_SCHEDULER_JOBS into rcUSER_SCHEDULER_JOBS;
            close cuUSER_SCHEDULER_JOBS;
            
            IF rcUSER_SCHEDULER_JOBS.job_name is not null then
                IF rcUSER_SCHEDULER_JOBS.state = 'RUNNING' THEN
                    dbms_scheduler.stop_job('OSF1976_'||nuHilo,TRUE);
                END IF;
                dbms_scheduler.drop_job('OSF1976_'||nuHilo,TRUE);
            END IF;
            
            dbms_scheduler.create_job
            (
                job_name            => 'OSF1976_'||nuHilo,
                job_type            => 'STORED_PROCEDURE',
                job_action          => 'OSF1976',
                number_of_arguments => 1,
                start_date          => null,
                repeat_interval     => null,
                end_date            => null,
                enabled             => FALSE,
                auto_drop           => FALSE,
                comments            => 'JOB para ejecución DataFix Refinancia Diferidos Error Hilo '||nuHilo
            );
            
            --Asigna valor a argumento
            dbms_scheduler.set_job_argument_value
            (
                job_name            => 'OSF1976_'||nuHilo,
                argument_position   => 1,
                argument_value      => nuHilo
            );
            
            dbms_scheduler.enable('OSF1976_'||nuHilo);
            dbms_output.put_line('Job programado: OSF1976_'||nuHilo);
            commit;
            
        exception
            when others then
                dbms_output.put_line('Error en la creación del Hilo '||nuHilo||'. Error: '||sqlerrm);
        end;
        
    END LOOP;
    
    dbms_output.put_line('Programación de Job centinela');
    --Creación Job Guardian
    begin
        rcUSER_SCHEDULER_JOBS := NULL;
        open cuUSER_SCHEDULER_JOBS('JOBFINALIZA');
        fetch cuUSER_SCHEDULER_JOBS into rcUSER_SCHEDULER_JOBS;
        close cuUSER_SCHEDULER_JOBS;
        
        IF rcUSER_SCHEDULER_JOBS.job_name is not null then
            IF rcUSER_SCHEDULER_JOBS.state = 'RUNNING' THEN
                dbms_scheduler.stop_job('JOBFINALIZA',TRUE);
            END IF;
            dbms_scheduler.drop_job('JOBFINALIZA',TRUE);
        END IF;
        
        dbms_scheduler.create_job
        (
            job_name            => 'JOBFINALIZA',
            job_type            => 'PLSQL_BLOCK',
            job_action          => sbBorraObjetos,
            number_of_arguments => 0,
            start_date          => SYSDATE,
            repeat_interval     => 'freq=HOURLY',
            --repeat_interval     => 'freq=MINUTELY;interval=1',
            --repeat_interval     => 'freq=secondly;bysecond=10',
            end_date            => SYSDATE+1,
            enabled             => FALSE,
            auto_drop           => TRUE,
            comments            => 'JOB para finalización de ejecucion DataFix OSF2143'
        );
        
        dbms_scheduler.enable('JOBFINALIZA');
        dbms_output.put_line('Job programado: JOBFINALIZA');
        commit;
        
        
    exception
        when others then
            dbms_output.put_line('Error en la creación del finalización OSF2143. Error: '||sqlerrm);
    end;
    
exception
    WHEN pkg_Error.Controlled_Error  THEN
        pkg_error.getError(nuError,sbError);
        dbms_output.put_line('Error controlado sbError => ' || sbError);
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_error.getError(nuError,sbError);
        dbms_output.put_line('Error no controlado sbError => ' || sbError);
end;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/

