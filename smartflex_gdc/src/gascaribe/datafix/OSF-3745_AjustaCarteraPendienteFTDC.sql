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
DEFINE CASO=OSF-3745

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
FECHA:          Diciembre 2024 
JIRA:           OSF-3745

Descripción

    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    12/12/2024 - jcatuchemvm
    Creación
    
***********************************************************/
DECLARE
    csbCaso             constant varchar2(20)   := 'OSF3745';
    csbTitulo           constant varchar2(2000) := csbCaso||': Ajuste cartera errada por proceso FTDC. Inserta cargos DB';
    csbFormato          constant varchar2(25)   := 'DD/MM/YYYY HH24:MI:SS';
    cdtFecha            constant date           := sysdate;
    
    
    
    cursor cuvalida is
    select count(*) from TRCASESU
    where tcsessfu = 51975525
    and tcsessde = 52944550;
    
    nuvalida            number;
    
    
    sberror             varchar2(2000);
    nuerror             number;
    raise_continuar     exception;
    sbcabecera          varchar2(2000);
    sbcomentario        varchar2(2000);
    nucontador          number;
     nuok                number;
    nuerr               number;
     
    NUCUCOCODI          CARGOS.CARGCUCO%TYPE := 3070219695;
    NUCARGVALO          CARGOS.CARGVALO%TYPE;
    NUCARGCODO          CARGOS.CARGCODO%TYPE;
    RCNOTAS             NOTAS%ROWTYPE;
    
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
    
    procedure ajustaCuenta(inucuenta in cuencobr.cucocodi%type) is 
    
        CURSOR cuData(inuCucocodi in cuencobr.cucocodi%type) IS
        SELECT  cargcuco cucocodi,cargnuse cuconuse,
        NVL
        (
            SUM(CASE cargsign WHEN 'DB' THEN cargvalo WHEN 'CR' THEN -cargvalo ELSE 0 END)
        ,0) cucovato,
        NVL
        (
            SUM(CASE WHEN cargsign IN ('PA','AS') THEN cargvalo WHEN cargsign = 'SA' THEN -cargvalo ELSE 0 END)
        ,0) cucovaab,
        NVL
        (
            SUM
            (
                CASE cargtipr
                    WHEN 'P' THEN 0
                    ELSE
                        CASE    
                            WHEN INSTR('DF-CX-',LPAD(SUBSTR(cargdoso, 1, 3), 3, ' ')) = 0 THEN  
                                CASE cargsign WHEN 'DB' THEN cargvalo WHEN 'CR' THEN -cargvalo ELSE 0 END
                            ELSE 0
                        END
                END
            )
        ,0) cucovafa,
        NVL
        (
            SUM
            (
                CASE cargtipr
                    WHEN'P' THEN 0
                    ELSE
                        CASE
                            WHEN INSTR('DF-CX-',LPAD(SUBSTR(cargdoso, 1, 3), 3, ' ')) = 0 THEN
                                CASE
                                    WHEN concticl = pkBillConst.fnuObtTipoImp THEN
                                        CASE cargsign WHEN 'DB' THEN cargvalo WHEN 'CR' THEN -cargvalo ELSE 0 END
                                    ELSE 0
                                END
                            ELSE 0
                        END
                END
            )
        ,0) cucoimfa
        FROM cargos, concepto
        WHERE cargcuco = inuCucocodi
        AND cargconc = conccodi
        AND cargsign IN 
        (
            'DB', 'CR',             -- Facturado
            'PA',                   -- Pagos
            'RD', 'RC', 'AD', 'AC', -- Reclamos
            'AS', 'SA', 'ST', 'TS'  -- Saldo favor
        )
        GROUP BY cargcuco, cargnuse;

        rcData      cuData%rowtype;
        rcCuenta    cuencobr%ROWTYPE;
        sbSign      cargos.cargsign%type;
        nuValo      cargos.cargvalo%type;

    BEGIN

        rcData := null;
        open cuData(inucuenta);
        fetch cuData into rcData;
        close cuData;

        rcCuenta := null;
        rcCuenta := pktblCuencobr.Frcgetrecord(rcData.cucocodi,0);
        
        if 
        (
            rcData.cucovato != rcCuenta.cucovato OR 
            rcData.cucovaab != rcCuenta.cucovaab OR
            rcData.cucoimfa != rcCuenta.cucoimfa
        ) then

            pkg_traza.trace('Cuenta     : ' || rcData.cucocodi, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace('=========================', pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace('Cucovato   : ' || rcData.cucovato ||'/' || rcCuenta.cucovato, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace('Cucovaab   : ' || rcData.cucovaab || '/' ||rcCuenta.cucovaab, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace('Cucovafa   : ' || rcData.cucovafa || '/' ||rcCuenta.cucovafa, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace('Cucoimfa   : ' || rcData.cucoimfa || '/' ||rcCuenta.cucoimfa, pkg_traza.cnuNivelTrzDef);
                         
            pktblCuencobr.Updcucovato(rcData.cucocodi,nvl(rcData.cucovato,0));
            pktblCuencobr.Updcucovaab(rcData.cucocodi,nvl(rcData.cucovaab,0));
            pktblCuencobr.Updcucovafa(rcData.cucocodi,nvl(rcData.cucovafa,0));
            pktblCuencobr.Updcucoimfa(rcData.cucocodi,nvl(rcData.cucoimfa,0));
            
         
            pkg_traza.trace('Después updateCuenta', pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace('Cucovato   : '||pktblcuencobr.fnugetcucovato(rcData.cucocodi, 0), pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace('Cucovaab   : '||pktblcuencobr.fnugetcucovaab(rcData.cucocodi), pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace('Cucovafa   : '||pktblcuencobr.fnugetcucovafa(rcData.cucocodi), pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace('Cucoimfa   : '||pktblcuencobr.fnugetcucoimfa(rcData.cucocodi), pkg_traza.cnuNivelTrzDef);

            pkAccountMgr.AdjustAccount
            (
                rcData.cucocodi,
                rcData.cuconuse,
                53,
                1,
                sbSign,
                nuValo
            );

            pkg_traza.trace('Después ajuste Cuenta', pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace('Cucovato   : '||pktblcuencobr.fnugetcucovato(rcData.cucocodi, 0), pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace('Cucovaab   : '||pktblcuencobr.fnugetcucovaab(rcData.cucocodi), pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace('Cucovafa   : '||pktblcuencobr.fnugetcucovafa(rcData.cucocodi), pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace('Cucoimfa   : '||pktblcuencobr.fnugetcucoimfa(rcData.cucocodi), pkg_traza.cnuNivelTrzDef);

           
        
        end if;

    EXCEPTION
        when pkg_error.CONTROLLED_ERROR then
          raise pkg_error.CONTROLLED_ERROR;
        when others then
          pkg_error.setError;
          raise pkg_error.CONTROLLED_ERROR;
    END ajustaCuenta;
    
BEGIN
    nucontador  := 0;
    nuok       := 0;
    nuerr       := 0;
    
    dbms_output.put_line(csbTitulo);
    dbms_output.put_line('================================================');
    dbms_output.put_line(sbcabecera);
    
    begin
    
    
        if cuvalida%isopen then close cuvalida; end if;
        
        open cuvalida;
        fetch cuvalida into nuvalida;
        close cuvalida;
        
        if nuvalida = 0 then
    
            pkg_error.setapplication('FTDC');
            
            dbms_output.put_line('Registro movimientos traslado');
            dbms_output.put_line('-------------------------------------------------------');
            
            INSERT INTO TRCASESU VALUES(51975525,52944550,UT_DATE.FDTSYSDATE,3070219695, 'TC-CC Sao 608262',1169503,0,0,6,47,'LILGAN','OSFVM-25',0);
            INSERT INTO TRCASESU VALUES(51975525,52944550,UT_DATE.FDTSYSDATE,3070219695, 'TC-CC Sao 608262',1169503,0,0,6,53,'LILGAN','OSFVM-25',0);
            INSERT INTO TRCASESU VALUES(51975525,52944550,UT_DATE.FDTSYSDATE,3070219695, 'TC-CC Sao 608262',1169503,0,0,6,64,'LILGAN','OSFVM-25',190513);
            INSERT INTO TRCASESU VALUES(51975525,52944550,UT_DATE.FDTSYSDATE,3070219695, 'TC-CC Sao 608262',1169503,0,0,6,74,'LILGAN','OSFVM-25',167306);
            INSERT INTO TRCASESU VALUES(51975525,52944550,UT_DATE.FDTSYSDATE,3070219695, 'TC-CC Sao 608262',1169503,0,0,6,133,'LILGAN','OSFVM-25',625509);
            INSERT INTO TRCASESU VALUES(51975525,52944550,UT_DATE.FDTSYSDATE,3070219695, 'TC-CC Sao 608262',1169503,0,0,6,135,'LILGAN','OSFVM-25',5133);
            INSERT INTO TRCASESU VALUES(51975525,52944550,UT_DATE.FDTSYSDATE,3070219695, 'TC-CC Sao 608262',1169503,0,0,6,177,'LILGAN','OSFVM-25',55346);
            INSERT INTO TRCASESU VALUES(51975525,52944550,UT_DATE.FDTSYSDATE,3070219695, 'TC-CC Sao 608262',1169503,0,0,6,220,'LILGAN','OSFVM-25',39191);
            INSERT INTO TRCASESU VALUES(51975525,52944550,UT_DATE.FDTSYSDATE,3070219695, 'TC-CC Sao 608262',1169503,0,0,6,285,'LILGAN','OSFVM-25',5120);
            INSERT INTO TRCASESU VALUES(51975525,52944550,UT_DATE.FDTSYSDATE,3070219695, 'TC-CC Sao 608262',1169503,0,0,6,295,'LILGAN','OSFVM-25',81385);
            
            dbms_output.put_line('Registro de notas');
            dbms_output.put_line('-------------------------------------------------------');
            
            FA_BOBILLINGNOTES.CREATEBILLINGNOTE (66779060,2140166187, 70,trunc(UT_DATE.FDTSYSDATE) , 'TC-CC Sao 608262','ND-','R',null,RCNOTAS);
            
            NUCARGCODO := RCNOTAS.notanume;
            
            dbms_output.put_line('Registro Cargos Cuenta '||NUCUCOCODI);
            dbms_output.put_line('-------------------------------------------------------');
            
            NUCARGVALO := 190513;
            PKCHARGEMGR.GENERATECHARGE (52944550, NUCUCOCODI, 64, 23, NUCARGVALO,  'DB', 'TC-CC3051705972',  'P', NUCARGCODO, NULL, NULL, NULL, FALSE, SYSDATE);
            dbms_output.put_line('Registro Concepto 64, valor '||NUCARGVALO);
            
            NUCARGVALO := 167306;
            PKCHARGEMGR.GENERATECHARGE (52944550, NUCUCOCODI, 74, 23, NUCARGVALO,  'DB', 'TC-CC3051705972',  'P', NUCARGCODO, NULL, NULL, NULL, FALSE, SYSDATE);
            dbms_output.put_line('Registro Concepto 74, valor '||NUCARGVALO);
            
            NUCARGVALO := 625509;
            PKCHARGEMGR.GENERATECHARGE (52944550, NUCUCOCODI, 133, 23, NUCARGVALO,  'DB', 'TC-CC3051705972',  'P', NUCARGCODO, NULL, NULL, NULL, FALSE, SYSDATE);
            dbms_output.put_line('Registro Concepto 133, valor '||NUCARGVALO);
            
            NUCARGVALO := 5133;
            PKCHARGEMGR.GENERATECHARGE (52944550, NUCUCOCODI, 135, 23, NUCARGVALO,  'DB', 'TC-CC3051705972',  'P', NUCARGCODO, NULL, NULL, NULL, FALSE, SYSDATE);
            dbms_output.put_line('Registro Concepto 135, valor '||NUCARGVALO);
            
            NUCARGVALO := 55346;
            PKCHARGEMGR.GENERATECHARGE (52944550, NUCUCOCODI, 177, 23, NUCARGVALO,  'DB', 'TC-CC3051705972',  'P', NUCARGCODO, NULL, NULL, NULL, FALSE, SYSDATE);
            dbms_output.put_line('Registro Concepto 177, valor '||NUCARGVALO);
            
            NUCARGVALO := 39191;
            PKCHARGEMGR.GENERATECHARGE (52944550, NUCUCOCODI, 220, 23, NUCARGVALO,  'DB', 'TC-CC3051705972',  'P', NUCARGCODO, NULL, NULL, NULL, FALSE, SYSDATE);
            dbms_output.put_line('Registro Concepto 220, valor '||NUCARGVALO);
            
            NUCARGVALO := 5120;
            PKCHARGEMGR.GENERATECHARGE (52944550, NUCUCOCODI, 285, 23, NUCARGVALO,  'DB', 'TC-CC3051705972',  'P', NUCARGCODO, NULL, NULL, NULL, FALSE, SYSDATE);
            dbms_output.put_line('Registro Concepto 285, valor '||NUCARGVALO);
            
            NUCARGVALO := 81385;
            PKCHARGEMGR.GENERATECHARGE (52944550, NUCUCOCODI, 295, 23, NUCARGVALO,  'DB', 'TC-CC3051705972',  'P', NUCARGCODO, NULL, NULL, NULL, FALSE, SYSDATE);
            dbms_output.put_line('Registro Concepto 295, valor '||NUCARGVALO);
            
            dbms_output.put_line('Ajusta Cuenta '||NUCUCOCODI);
            dbms_output.put_line('-------------------------------------------------------');
            
            ajustaCuenta(NUCUCOCODI);
            
            commit;
            
        else 
            dbms_output.put_line('Gestión Cartera para la cuenta '||NUCUCOCODI||' ya realizada');
        end if;
          
    exception
        when pkg_error.controlled_error or login_denied then
            rollback;
            pkg_error.geterror(nuerror,sberror);
            nuerr := nuerr + 1;
            sbcomentario := 'Error controlado en ajuste de cartera FTDC '||sberror;
            dbms_output.put_line(sbcomentario);
        when others then
            rollback;
            pkg_error.seterror;
            pkg_error.geterror(nuerror,sberror);
            nuerr := nuerr + 1;
            sbcomentario := 'Error desconocido en ajuste de cartera FTDC '||sberror;
            dbms_output.put_line(sbcomentario);
            
    end;
    dbms_output.put_line('================================================');
    dbms_output.put_line('Fin gestión caso '||csbCaso);
    dbms_output.put_line('Cantidad de errores: '||nuerr);  
    dbms_output.put_line('Rango Total de Ejecución ['||to_char(cdtFecha,'dd/mm/yyyy')||']['||to_char(cdtFecha,'hh24:mi:ss')||' - '||to_char(sysdate,'hh24:mi:ss')||']');
    dbms_output.put_line('Tiempo Total de Ejecución ['||fnc_rs_CalculaTiempo(cdtFecha,sysdate)||']');
END;
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
