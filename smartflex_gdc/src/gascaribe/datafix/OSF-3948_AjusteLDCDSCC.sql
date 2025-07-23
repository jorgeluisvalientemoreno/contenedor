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
DEFINE CASO=OSF-3948

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
FECHA:          Febrero 2025 
JIRA:           OSF-3948

Descripción

    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    21/02/2025 - jcatuche
    Creación
    
***********************************************************/
DECLARE
    csbCaso             constant varchar2(20)   := 'OSF3948';
    csbTitulo           constant varchar2(2000) := csbCaso||': Corrección errores LDCDSCC';
    csbFormato          constant varchar2(25)   := 'DD/MM/YYYY HH24:MI:SS';
    cdtFecha            constant date           := sysdate;
    
    
    cursor cumovi is
    select * from movisafa
    where mosfsafa = 2438691
    and mosfcons = 7655714
    and mosfvalo = -196280
    order by mosfcons;
    
    rcmovi  cumovi%rowtype;
    
    cursor cucargos is
    select c.rowid row_id,c.* from cargos c
    where cargcuco in ( 3073159987,3074994853)
    and cargsign = 'AS'
    order by cargcuco;
    
    nusaldoAs   number;
    
    
    sberror             varchar2(2000);
    nuerror             number;
    raise_continuar     exception;
    s_out               varchar2(2000);
    sbcabecera          varchar2(2000);
    sbcomentario        varchar2(2000);
    nucontador          number;
    nurowcount          number;
    nuok                number;
    nucr                number;
    nubr                number;
    nuerr               number;
    
    rcmovisafa          movisafa%rowtype;
    numosfcons          movisafa.mosfcons%type;
    
    
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
        SELECT  cucocodi, cuconuse,
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
        FROM cuencobr,cargos, concepto
        WHERE cucocodi = inuCucocodi
        AND cargcuco(+) = cucocodi
        AND cargconc = conccodi(+)
        AND cargsign(+) IN 
        (
            'DB', 'CR',             -- Facturado
            'PA',                   -- Pagos
            'RD', 'RC', 'AD', 'AC', -- Reclamos
            'AS', 'SA', 'ST', 'TS'  -- Saldo favor
        )
        GROUP BY cucocodi, cuconuse;

        rcData      cuData%rowtype;
        rcCuenta    cuencobr%ROWTYPE;
        sbSign      cargos.cargsign%type;
        nuValo      cargos.cargvalo%type;
        
        cursor cusaldos is
        select cargconc,cargsign,cargvalo,cargdoso,cargcodo,cargfecr,cargcaca,cargnuse,cargcuco,cargpefa,
        (select sesususc from servsusc where sesunuse = cargnuse) sesususc,
        sum(CASE WHEN cargsign IN ('CR', 'PA', 'AS', 'AD', 'RC', 'TS') THEN (NVL(cargvalo, 0))*-1 ELSE (NVL(cargvalo, 0)) END) over (partition by cargcuco) saldo,
        cargusua,(select mask from sa_user where user_id = cargusua) mask,
        cargprog,(select proccodi from procesos where proccons = cargprog) proccodi
        from cargos
        where cargcuco = inuCuenta
        order by cargfecr desc,case cargsign when'PA' then 1 when 'CR' then 2 else 3 end;
        
        rcsaldos        cusaldos%rowtype;
        rccargo         cargos%rowtype;
        rcsaldfavo      saldfavo%rowtype;
        rcmovisafa      movisafa%rowtype;
        nusafacons      saldfavo.safacons%type;
        numosfcons      movisafa.mosfcons%type;
        gnuconcSA       concepto.conccodi%type;
        

    BEGIN

        pkerrors.setapplication(CC_BOConstants.csbCUSTOMERCARE);

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

            rcsaldos := null;
            open cusaldos;
            fetch cusaldos into rcsaldos;
            close cusaldos;
    
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
    nuok        := 0;
    nucr        := 0;
    nuerr       := 0;
    nubr        := 0;
    
    sbcabecera := 'Producto|Mosfcons|Mosfvalo_ant|Mosfvalo_act|Mosfcuco_ant|Mosfcuco_act|Cargcuco|Cargfecr_ant|Cargfecr_act|Error';
    dbms_output.put_line(csbTitulo);
    dbms_output.put_line('================================================');
    dbms_output.put_line(sbcabecera);
    
    begin
    
        if cumovi%isopen then close cumovi; end if;
        
        rcmovi := null;
        open cumovi;
        fetch cumovi into rcmovi;
        close cumovi;
        
        if rcmovi.mosfcons is not null then
            ---196280
            nusaldoAs := 0;
            for rc in cucargos loop
                
                if nusaldoAS = 0 then
                    nusaldoAS := rc.cargvalo;
                    
                    --actualiza valor de registro y cuenta destino en movisafa
                    s_out := rcmovi.mosfsesu;
                    s_out := s_out||'|'||rcmovi.mosfcons;
                    s_out := s_out||'|'||rcmovi.mosfvalo;
                    s_out := s_out||'|'||-1*rc.cargvalo;
                    s_out := s_out||'|'||rcmovi.mosfcuco;
                    s_out := s_out||'|'||rc.cargcuco;
                    
                    update movisafa
                    set mosfvalo = -1*rc.cargvalo,
                    mosfcuco = rc.cargcuco
                    where mosfcons = rcmovi.mosfcons;
                    
                    nuRowcount := sql%rowcount;
                    
                    if nuRowcount != 1 then
                        sbcomentario := 'Actualización de primer movimiento de saldo a favor diferente al esperado ['||nuRowcount||']';
                        s_out := s_out||'|||';
                        raise raise_continuar;
                    end if;
                    
                    nuok := nuok + 1;
                    
                    --actualiza fecha de cargo
                    s_out := s_out||'|'||rc.cargcuco;
                    s_out := s_out||'|'||rc.cargfecr;
                    s_out := s_out||'|'||rcmovi.mosffecr;
                    
                    update cargos
                    set cargfecr = rcmovi.mosffecr
                    where rowid = rc.row_id
                    and cargcuco = rc.cargcuco
                    and cargnuse = rc.cargnuse;
                    
                    nuRowcount := sql%rowcount;
                    
                    if nuRowcount != 1 then
                        sbcomentario := 'Actualización de primer cargo AS diferente al esperado ['||nuRowcount||']';
                        raise raise_continuar;
                    end if;
                    
                    nucr := nucr + 1;
                    
                    s_out := s_out||'|'||'Actualiza Movisafa y cargos';
                    dbms_output.put_line(s_out);
                    
                else
                    nusaldoAS := nusaldoAS + rc.cargvalo;
                    
                    --inserta registro movisafa 
                    rcmovisafa := null;
                    numosfcons := PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL('sq_movisafa_mosfcons');
                    
                    s_out := rcmovi.mosfsesu;
                    s_out := s_out||'|'||numosfcons;
                    s_out := s_out||'|'||null;
                    s_out := s_out||'|'||-1*rc.cargvalo;
                    s_out := s_out||'|'||null;
                    s_out := s_out||'|'||rc.cargcuco;
                    
                    rcmovisafa.mosfcons := numosfcons;
                    rcmovisafa.mosfsesu := rcmovi.mosfsesu;
                    rcmovisafa.mosfsafa := rcmovi.mosfsafa;
                    rcmovisafa.mosfdoso := numosfcons;
                    rcmovisafa.mosffech := rcmovi.mosffech;
                    rcmovisafa.mosfvalo := -1*rc.cargvalo;
                    rcmovisafa.mosfcuco := rc.cargcuco;
                    rcmovisafa.mosfnota := null;
                    rcmovisafa.mosfdeta := 'AS';
                    rcmovisafa.mosffecr := rcmovi.mosffecr;
                    rcmovisafa.mosfusua := rcmovi.mosfusua;
                    rcmovisafa.mosfprog := rcmovi.mosfprog;
                    rcmovisafa.mosfterm := rcmovi.mosfterm;
                    
                    Pktblmovisafa.Insrecord (rcmovisafa);
                    
                    nuok := nuok + 1;
                    
                    --actualiza fecha de cargo
                    s_out := s_out||'|'||rc.cargcuco;
                    s_out := s_out||'|'||rc.cargfecr;
                    s_out := s_out||'|'||rcmovi.mosffecr;
                    
                    update cargos
                    set cargfecr = rcmovi.mosffecr
                    where rowid = rc.row_id
                    and cargcuco = rc.cargcuco
                    and cargnuse = rc.cargnuse;
                    
                    nuRowcount := sql%rowcount;
                    
                    if nuRowcount != 1 then
                        sbcomentario := 'Actualización de segundo cargo AS diferente al esperado ['||nuRowcount||']';
                        raise raise_continuar;
                    end if;
                    
                    nucr := nucr + 1;
                    
                    s_out := s_out||'|'||'Inserta Movisafa y actualiza cargos';
                    dbms_output.put_line(s_out);
                    
                end if;
                
            end loop;
            
            if nusaldoAS != abs(rcmovi.mosfvalo) then 
                sbcomentario := 'El saldo a favor acumulado no corresonde al valor a modificar';
                
                s_out := rcmovi.mosfsesu;
                s_out := s_out||'||||||||';
                
                raise raise_continuar;
            end if;
            
            s_out := rcmovi.mosfsesu;
            s_out := s_out||'|||||3075094069|||';
                
            --borra cargo AS en tercera cuenta 
            delete cargos
            where cargcuco = 3075094069
            and cargnuse = 5058063
            and cargvalo = 196280
            and cargsign = 'AS'
            ;
            
            nuRowcount := sql%rowcount;
            
            if nuRowcount != 1 then
                sbcomentario := 'Borrado de tercer cargo AS diferente al esperado ['||nuRowcount||']';
                raise raise_continuar;
            end if;
            
            --ajusta tercera cuenta
            ajustaCuenta(3075094069);
            
            nubr := nubr + 1;
            
            s_out := s_out||'|Borrado cargo AS y ajuste cuenta';
            dbms_output.put_line(s_out);
            
        else 
            sbcomentario := 'Sin datos para gestión o ya gestionado';
            s_out := s_out||'||||||||';
            raise raise_continuar;
        end if;
        
        commit;
    
    exception
        when raise_continuar then
            rollback;
            nuerr := nuerr + 1;
            s_out := s_out||'|'||sbcomentario;
            dbms_output.put_line(s_out);
        when others then
            rollback;
            nuerr := nuerr + 1;
            pkg_error.seterror;
            pkg_error.geterror(nuerror,sberror);
            sbcomentario := 'Error en gestión de cargos AS. Error '||sberror;
            s_out := s_out||'||||'||sbcomentario;
            dbms_output.put_line(s_out);
    end;
           
        
    dbms_output.put_line('================================================');
    dbms_output.put_line('Fin gestión caso '||csbCaso);
    dbms_output.put_line('Cantidad de movimientos gestionados: '||nuok);
    dbms_output.put_line('Cantidad de cargos ajustados: '||nucr);
    dbms_output.put_line('Cantidad de cargos borrados: '||nubr);
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
