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
DEFINE CASO=OSF2617

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
FECHA:          Abril 2024 
JIRA:           OSF-2617

Descripción

    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    19/04/2024 - jcatuchemvm
    Creación
    
***********************************************************/
DECLARE
    csbCaso             constant varchar2(20)   := 'OSF2617';
    csbTitulo           constant varchar2(2000) := csbCaso||': Ajuste cartera por pagos dobles';
    csbFormato          constant varchar2(25)   := 'DD/MM/YYYY HH24:MI:SS';
    cnuSegundo          constant number         := 1/86400;
    cnuLimit            constant number         := 1000;
    cnuIdErr            constant number         := 1;
    cdtFecha            constant date           := sysdate;
    
    type tyTabla is table of varchar2( 2000 ) index by binary_integer;
    type tyrcArchivos is record
    (
        cabecera    varchar2(2000),
        nombre      varchar2(50),
        flgprint    varchar2(1),
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
    nuErr               number;
    nuok                number;
    nuwrng              number;
    nucont              number;
    nucont1             number;
    nuRowcount          number;
    raise_continuar     exception;
    s_out               varchar2(2000);
    sbGestion           varchar2(2000);
    nusab               number;
    numvb               number;
    nusfb               number;
    nupu                number;
    nunot               number;
    
    
    cursor cudata is
    with pago as
    (
        select * from pagos
        where pagocupo in 
        (
            233317906,
            233317926,
            233317931,
            233317942,
            233317944,
            233317969
        )
    ), saldos as
    (
        select pagocupo,pagosusc,pagofegr,pagovapa,c.cargnuse,c.cargvalo,c.cargsign,c.cargcuco,c.cargconc,b.cargconc cargconcSA,
        (select cucofact from cuencobr where cucocodi =  c.cargcuco) cucofact,c.cargdoso,c.cargfecr,
        sum(c.cargvalo) over (partition by pagocupo,c.cargdoso) cargvaloT,
        b.cargsign cargsignSA,b.cargvalo cargvaloSA,b.cargdoso cargdosoSA,b.cargfecr cargfecrSA,b.cargcodo cargcodoSA,
        row_number() over (partition by pagocupo order by c.cargdoso desc) row_num,c.rowid row_id_PA,b.rowid row_id_SA,
        (select safacons from saldfavo where safasesu = b.cargnuse and safadocu = b.cargcuco and safavalo = b.cargvalo) safacons
        from cargos c, pago p,cargos b
        where c.cargcodo = pagocupo
        and c.cargsign = 'PA'
        and b.cargcuco(+) = c.cargcuco
        and b.cargnuse(+) = c.cargnuse
        and b.cargconc(+) = 123
        and b.cargsign(+) = 'SA'
        and b.cargdoso(+) = c.cargdoso
        order by pagocupo,cargdoso desc,cargcuco
    )
    select s.*,
    (select sum(mosfvalo) from movisafa where mosfsafa = safacons) mosfvalo 
    from saldos s
    ;
        
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


        end if;

    EXCEPTION
        when pkg_error.CONTROLLED_ERROR then
          raise pkg_error.CONTROLLED_ERROR;
        when others then
          pkg_error.setError;
          raise pkg_error.CONTROLLED_ERROR;
    END ajustaCuenta;
    
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
        
        nucont      := 0;
        nucont1     := 0;
        nuok        := 0;
        nuerr       := 0;
        nusab       := 0;
        numvb       := 0;
        nusfb       := 0;
        nupu        := 0;
        nunot       := 0;
        
        tbArchivos.delete; 

        
        tbArchivos(1).nombre  := '--Log';
        tbArchivos(2).nombre  := '--Población';
        tbArchivos(3).nombre  := '--Saldo a favor';
        
        tbArchivos(1).flgprint  := 'S';
        tbArchivos(2).flgprint  := 'S';
        tbArchivos(3).flgprint  := 'S';
       
        nuOuts := tbArchivos.last;
        
        sbCabecera := 'TipoError|Cupon|Mensaje|Error'; 
        tbArchivos(cnuIdErr).cabecera := sbCabecera;
        
        sbCabecera := 'Cupon|Contrato|FechaPago|ValorPago|Producto|Cuenta|Valor|Signo|Conc_Ant|Conc_Act|Fecha_Ant|Fecha_Act|Gestion';
        tbArchivos(2).cabecera := sbCabecera;
        
        sbCabecera := 'Cupon|Contrato|Producto|Cuenta|Safacons|Safavalo|Mosfvalo|Gestion';
        tbArchivos(3).cabecera := sbCabecera;
        
        dbms_output.put_line(csbTitulo);
        dbms_output.put_line('================================================');
        
        
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
    
    PROCEDURE pIniciaLog IS
    BEGIN
        for i in tbArchivos.first .. nuOuts loop
            if i >= cnuIdErr then
                pGuardaLog(tbArchivos(i),tbArchivos(i).cabecera);
            end if;
        end loop;        
    END pIniciaLog;
    
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
    
    PROCEDURE pCerrarLog IS
    BEGIN
        
        pGuardaLog(tbArchivos(cnuIdErr),'================================================');
        pGuardaLog(tbArchivos(cnuIdErr),'Finaliza gestión caso '||csbCaso);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de pagos borrados: '||nuok);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de cargos SA borrados: '||nusab);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de movimientos SA borrados: '||numvb);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de saldfavos borrados: '||nusfb);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de pagos actualizados: '||nupu);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de notas creadas: '||nunot);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de errores: '||nuerr);  
        pGuardaLog(tbArchivos(cnuIdErr),'Rango Total de Ejecución ['||to_char(cdtFecha,'dd/mm/yyyy')||']['||to_char(cdtFecha,'hh24:mi:ss')||' - '||to_char(sysdate,'hh24:mi:ss')||']');
        pGuardaLog(tbArchivos(cnuIdErr),'Tiempo Total de Ejecución ['||fnc_rs_CalculaTiempo(cdtFecha,sysdate)||']');
        
        pEsbribelog();
        
    END pCerrarLog;
    
    PROCEDURE pCerrarLogE IS
    BEGIN
        pGuardaLog(tbArchivos(cnuIdErr),'================================================');
        pGuardaLog(tbArchivos(cnuIdErr),'Finaliza gestión con Error ' ||csbCaso||': '||sqlerrm );
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de pagos borrados: '||nuok);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de cargos SA borrados: '||nusab);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de movimientos SA borrados: '||numvb);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de saldfavos borrados: '||nusfb);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de pagos actualizados: '||nupu);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de notas creadas: '||nunot);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de errores: '||nuerr);  
        pGuardaLog(tbArchivos(cnuIdErr),'Rango Total de Ejecución ['||to_char(cdtFecha,'dd/mm/yyyy')||']['||to_char(cdtFecha,'hh24:mi:ss')||' - '||to_char(sysdate,'hh24:mi:ss')||']');
        pGuardaLog(tbArchivos(cnuIdErr),'Tiempo Total de Ejecución ['||fnc_rs_CalculaTiempo(cdtFecha,sysdate)||']');
        
        pEsbribelog();
        
    END pCerrarLogE;
    
    PROCEDURE pGestionCaso  IS
        nuCupon     number;
        nuValError  number;
        s_out2      varchar2(2000);
        
        regNotas     notas%ROWTYPE;
        nuConsDocu   number;
        rcCargo      cargos%rowtype;
        nuperiodo    number;
        
        cursor cumovisafa  (inusafa in number) is
        select m.*,
        (select sesususc from servsusc where sesunuse = mosfsesu) mosfsusc,cucofact 
        from movisafa m, cuencobr
        where mosfsafa = inusafa
        and mosfvalo < 0
        and mosfdeta = 'AS'
        and cucocodi = mosfcuco;
        
        cursor cuNotasCR(inucuenta in number) is
        with base as
        (
            select cargcuco,cargnuse,cargconc,cargcaca,cargsign,cargvalo,cargdoso,cargcodo,cargprog,cargtipr,cargfecr from cargos
            where cargcuco = inucuenta
            and cargprog = 2016
            and cargcaca = 21
        )
        select cargcuco,cargsign,cargdoso,cargcodo,cargprog from base
        group by cargcuco,cargsign,cargdoso,cargcodo,cargprog;
        
        rcNotasCR   cuNotasCR%rowtype;
        
        type tytbNotasDB is table of number index by varchar2(9);
        tbNotasDB   tytbNotasDB;
        
        cursor cusaldfavo(inusesu in number) is
        select sesususc,sesunuse,
        (select sum(mosfvalo) from movisafa,saldfavo,servsusc b where b.sesususc = s.sesususc and b.sesunuse = safasesu and safacons = mosfsafa) suscsafa,
        (select sum(mosfvalo) from movisafa,saldfavo where safasesu = sesunuse and mosfsafa = safacons) sesusafa 
        from servsusc s
        where sesunuse = inusesu
        ;
        
        rcsaldfavo  cusaldfavo%rowtype;
        
        cursor cuotros is
        with pago as
        (
            select * from pagos
            where pagocupo in 
            (
                231127159,
                231367974,
                231858048,
                230954300,
                230713035,
                229746806


            )
        ), saldos as
        (
            select pagocupo,pagosusc,pagofegr,pagovapa,c.cargnuse,c.cargvalo,c.cargcuco,c.cargconc,b.cargconc cargconcSA,c.cargunid,
            (select cucofact from cuencobr where cucocodi =  c.cargcuco) cucofact,c.cargdoso,c.cargfecr,
            sum(c.cargvalo) over (partition by pagocupo,c.cargdoso) cargvaloT,
            b.cargsign,b.cargvalo cargvaloSA,b.cargdoso cargdosoSA,b.cargfecr cargfecrSA,b.cargcodo cargcodoSA,
            row_number() over (partition by pagocupo order by c.cargdoso desc) row_num,c.rowid row_id_PA,b.rowid row_id_SA,
            (select safacons from saldfavo where safasesu = b.cargnuse and safadocu = b.cargcuco and safavalo = b.cargvalo) safacons
            from cargos c, pago p,cargos b
            where c.cargcodo = pagocupo
            and c.cargsign = 'PA'
            and b.cargcuco(+) = c.cargcuco
            and b.cargnuse(+) = c.cargnuse
            and b.cargconc(+) = 123
            and b.cargsign(+) = 'SA'
            and b.cargdoso(+) = c.cargdoso
            order by pagocupo ,cargdoso desc,cargcuco
        )
        select s.*,
        (select sum(mosfvalo) from movisafa where mosfsafa = safacons) mosfvalo 
        from saldos s
        --where cargfecr != pagofegr
        ;


    BEGIN    
        
        tbNotasDB('233317906') := 150582839;
        tbNotasDB('233317926') := 150582890;
        tbNotasDB('233317931') := 150582907;
        tbNotasDB('233317942') := 150582937;
        tbNotasDB('233317944') := 150582946;
        tbNotasDB('233317969') := 150582957;
        
        
        for rc in cudata loop
            begin 
                if (rc.safacons is not null and rc.row_num = 1) or (rc.safacons is null and rc.row_num > 1) then
                    if rc.row_num = 1 and rc.cargvalo = rc.cargvalot and rc.cargvalosa = rc.mosfvalo then
                        commit;
                        --Registro cargo Pago Duplicado
                        nuCupon := rc.pagocupo;
                        nuValError := 0;
                        
                        s_out := nuCupon;
                        s_out  := s_out||'|'||rc.pagosusc;
                        s_out  := s_out||'|'||rc.pagofegr;
                        s_out  := s_out||'|'||rc.pagovapa;
                        s_out  := s_out||'|'||rc.cargnuse;
                        
                        --Borrado PA
                        delete cargos 
                        where rowid = rc.row_id_PA
                        and cargcuco  = rc.cargcuco
                        and cargnuse = rc.cargnuse
                        and cargsign = rc.cargsign
                        and cargvalo = rc.cargvalo;
                        
                        nuRowcount := sql%rowcount;
                    
                        if nuRowcount != 1 then
                            sbComentario := 'Error 1.1|'||nuCupon||'|Borrado de cargo Pago duplicado diferente al esperado ['||nuRowcount||']'||'|NA';
                            nuValError := 1;
                            rollback;
                            pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
                            nuerr := nuerr + 1; 
                            sbGestion := 'Pago NO Borrado';
                        else
                            nuok := nuok + 1;
                            sbGestion := 'Pago Borrado';
                        end if;
                        
                        
                        s_out2  := rc.cargcuco;
                        s_out2  := s_out2||'|'||rc.cargvalo;
                        s_out2  := s_out2||'|'||rc.cargsign;
                        s_out2  := s_out2||'|'||'NA';
                        s_out2  := s_out2||'|'||rc.cargconc;
                        s_out2  := s_out2||'|'||rc.cargfecr;
                        s_out2  := s_out2||'|'||'NA';
                        
                        pGuardaLog(tbArchivos(2),s_out||'|'||s_out2||'|'||sbGestion);
                        
                        if rc.cargsignSA is null then
                            begin
                                ajustaCuenta(rc.cargcuco);
                            exception
                                when others then
                                    nuValError := 1;
                                    rollback;
                                    nuok := nuok-1;
                                    pkg_error.geterror(nuerror,sberror);
                                    sbComentario := 'Error 1.3|'||nuCupon||'|Error al ajustar cuenta PA|'||sberror;
                            end;
                        else 
                            
                            if nuValError = 1 then
                                sbGestion := 'SA No Borrado';
                            else
                                --Borrado SA
                                delete cargos 
                                where rowid = rc.row_id_SA
                                and cargcuco  = rc.cargcuco
                                and cargnuse = rc.cargnuse
                                and cargsign = rc.cargsignSA
                                and cargvalo = rc.cargvaloSA;
                                
                                nuRowcount := sql%rowcount;
                            
                                if nuRowcount != 1 then
                                    sbComentario := 'Error 1.2|'||nuCupon||'|Borrado de cargo SA diferente al esperado ['||nuRowcount||']'||'|NA';
                                    nuValError := 1;
                                    rollback;
                                    pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
                                    nuerr := nuerr + 1; 
                                    sbGestion := 'SA NO Borrado';
                                    nuok := nuok-1;
                                else
                                    begin
                                        ajustaCuenta(rc.cargcuco);
                                    exception
                                        when others then
                                            nuValError := 1;
                                            rollback;
                                            nuok := nuok-1;
                                            pkg_error.geterror(nuerror,sberror);
                                            sbComentario := 'Error 1.3|'||nuCupon||'|Error al ajustar cuenta SA|'||sberror;
                                    end;
                                    
                                    nusab := nusab + 1;
                                    sbGestion := 'SA Borrado';
                                end if;
                                
                            end if;
                            
                            s_out2  := rc.cargcuco;
                            s_out2  := s_out2||'|'||rc.cargvaloSA;
                            s_out2  := s_out2||'|'||rc.cargsignSA;
                            s_out2  := s_out2||'|'||'NA';
                            s_out2  := s_out2||'|'||rc.cargconcSA;
                            s_out2  := s_out2||'|'||rc.cargfecrSA;
                            s_out2  := s_out2||'|'||'NA';
                            
                            pGuardaLog(tbArchivos(2),s_out||'|'||s_out2||'|'||sbGestion);
                            
                            if nuValError = 1 then
                                sbGestion := 'Saldfavo NO Borrado';
                            else 
                                --borrado de Saldo a favor
                                delete movisafa
                                where mosfsafa = rc.safacons
                                and mosfsesu = rc.cargnuse
                                and mosfvalo = rc.cargvalosa;
                                
                                nuRowcount := sql%rowcount;
                                
                                if nuRowcount != 1 then
                                    sbComentario := 'Error 1.4|'||nuCupon||'|Borrado de movimiento SA diferente al esperado ['||nuRowcount||']'||'|NA';
                                    nuValError := 1;
                                    rollback;
                                    pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
                                    nuerr := nuerr + 1; 
                                    sbGestion := 'Movimiento SA NO Borrado';
                                    nuok := nuok-1;
                                    nusab := nusab-1;
                                    tbArchivos(2).tblog(tbArchivos(2).tblog.last) := s_out||'|'||s_out2||'|'||'SA No Borrado';
                                    tbArchivos(2).tblog(tbArchivos(2).tblog.last-1) := substr(tbArchivos(2).tblog(tbArchivos(2).tblog.last-1),1,instr(tbArchivos(2).tblog(tbArchivos(2).tblog.last-1),'|',1,10))||'Pago No Borrado';
                                else
                                    delete saldfavo
                                    where safacons = rc.safacons
                                    and safasesu = rc.cargnuse;
                                    
                                    nuRowcount := sql%rowcount;
                                
                                    if nuRowcount != 1 then
                                        sbComentario := 'Error 1.5|'||nuCupon||'|Borrado de saldo a favor diferente al esperado ['||nuRowcount||']'||'|NA';
                                        nuValError := 1;
                                        rollback;
                                        pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
                                        nuerr := nuerr + 1; 
                                        sbGestion := 'Saldfavo NO Borrado';
                                        nuok := nuok-1;
                                        nusab := nusab-1;
                                        tbArchivos(2).tblog(tbArchivos(2).tblog.last) := s_out||'|'||s_out2||'|'||'SA No Borrado';
                                        tbArchivos(2).tblog(tbArchivos(2).tblog.last-1) := substr(tbArchivos(2).tblog(tbArchivos(2).tblog.last-1),1,instr(tbArchivos(2).tblog(tbArchivos(2).tblog.last-1),'|',1,10))||'Pago No Borrado';
                                    else
                                        -- actualiza sesusafa
                                        rcsaldfavo := null;
                                        open cusaldfavo(rc.cargnuse);
                                        fetch cusaldfavo into rcsaldfavo;
                                        close cusaldfavo;
                                        
                                        update servsusc
                                            set sesusafa = rcsaldfavo.sesusafa
                                          where sesunuse = rc.cargnuse;

                                        -- actualiza suscsafa
                                        update suscripc
                                            set suscsafa = rcsaldfavo.suscsafa
                                          where susccodi = rc.pagosusc;
                                          
                                        numvb := numvb + 1;
                                        nusfb := nusfb + 1;
                                        sbGestion := 'Saldfavo Borrado';
                                    end if;
                                end if;
                               
                            end if;
                            
                            s_out2 := nuCupon;
                            s_out2 := s_out2||'|'||rc.pagosusc;
                            s_out2 := s_out2||'|'||rc.cargnuse;
                            s_out2 := s_out2||'|'||rc.cargcuco;
                            s_out2 := s_out2||'|'||rc.safacons;
                            s_out2 := s_out2||'|'||rc.cargvalosa;
                            s_out2 := s_out2||'|'||rc.mosfvalo;
                            
                            pGuardaLog(tbArchivos(3),s_out2||'|'||sbGestion);
                            
                        end if;
                    elsif rc.row_num = 1 and rc.cargvalo = rc.cargvalot and rc.cargvalosa != rc.mosfvalo then    
                        commit;
                        begin
                            --Registro cargo Pago Duplicado
                            nuCupon := rc.pagocupo;
                            nuValError := 0;
                            
                            s_out := nuCupon;
                            s_out  := s_out||'|'||rc.pagosusc;
                            s_out  := s_out||'|'||rc.pagofegr;
                            s_out  := s_out||'|'||rc.pagovapa;
                            s_out  := s_out||'|'||rc.cargnuse;
                            
                            --Busqueda de nota 
                            nuConsDocu := null;
                            rcNotasCR := null;
                            open cuNotasCR (rc.cargcuco);
                            fetch cuNotasCR into rcNotasCR;
                            close cuNotasCR;
                            
                            nuConsDocu :=  rcNotasCR.cargcodo;
                            
                            if nuConsDocu is null then
                                sbComentario := 'Error 1.6|'||nuCupon||'|No se encuentra nota CR|NA';
                                raise raise_continuar;
                            end if;
                            
                            nunot := nunot + 1;
                            
                            --Actualización cargo PA
                            update cargos
                            set cargsign = 'CR', cargdoso = 'NC-'||nuConsDocu,cargconc = 31,cargcodo = nuConsDocu, cargcaca = 21, cargprog = 2016
                            where rowid = rc.row_id_PA
                            and cargcuco  = rc.cargcuco
                            and cargnuse = rc.cargnuse
                            and cargsign = rc.cargsign
                            and cargvalo = rc.cargvalo;
                            
                            --Actualización cargo SA
                            update cargos
                            set cargdoso = 'CTN-'||rc.cargcuco,cargcodo = rc.cargcuco, cargprog = 2016
                            where rowid = rc.row_id_SA
                            and cargcuco  = rc.cargcuco
                            and cargnuse = rc.cargnuse
                            and cargsign = rc.cargsignSA
                            and cargvalo = rc.cargvaloSA;
                            
                            --actualización saldfavo
                            update saldfavo
                            set safaorig = 'CTN', safaprog = 'GCNED'
                            where safacons = rc.safacons
                            and safasesu = rc.cargnuse;
                            
                            --actualización movisafa
                            update movisafa
                            set mosfdeta = 'CTN', mosfprog = 'GCNED'
                            where mosfsafa = rc.safacons
                            and mosfvalo = rc.cargvalosa
                            and mosfsesu = rc.cargnuse;
                            
                            ajustaCuenta(rc.cargcuco);
                            
                            sbGestion := 'Se cambia cargo PA';
                            nupu := nupu + 1;
                            
                            s_out2  := rc.cargcuco;
                            s_out2  := s_out2||'|'||rc.cargvaloSA;
                            s_out2  := s_out2||'|'||'CR';
                            s_out2  := s_out2||'|'||rc.cargconc;
                            s_out2  := s_out2||'|'||31;
                            s_out2  := s_out2||'|'||rc.cargfecr;
                            s_out2  := s_out2||'|'||'NA';
                            
                            pGuardaLog(tbArchivos(2),s_out||'|'||s_out2||'|'||sbGestion);
                            
                            for rf in cumovisafa(rc.safacons) loop
                                --Busqueda de nota DB
                                nuConsDocu := null;
                                
                                if tbNotasDB.exists(to_char(nuCupon)) then
                                    nuConsDocu := tbNotasDB(to_char(nuCupon));
                                else
                                    sbComentario := 'Error 1.7|'||nuCupon||'|No se encuentra nota DB|NA';
                                    raise raise_continuar;
                                end if;
                                
                                nunot := nunot + 1;
                                
                                nuperiodo := null;
                                nuperiodo := PKTBLFACTURA.FNUGETFACTPEFA(rf.cucofact, null);
                                
                                --creación cargo CR            
                                rcCargo.cargnuse := rf.mosfsesu;
                                rcCargo.cargcuco := rf.mosfcuco;
                                rcCargo.cargpefa := nuperiodo;
                                rcCargo.cargconc := 31; 
                                rcCargo.cargcaca := 4;   
                                rcCargo.cargsign := 'DB' ;
                                rcCargo.cargvalo := abs(rf.mosfvalo);
                                rcCargo.cargdoso := 'ND-'||nuConsDocu;
                                rcCargo.cargtipr := 'P';
                                rcCargo.cargfecr := cdtFecha; ---Fecha
                                rcCargo.cargcodo := nuConsDocu; --  DEBE SER  numero de la nota
                                rcCargo.cargunid := 0;
                                rcCargo.cargcoll := null ;
                                rcCargo.cargprog := 2016; 
                                rcCargo.cargusua := 1;
                                
                                pktblCargos.InsRecord (rcCargo);
                                
                                ajustaCuenta(rf.mosfcuco);
                                
                                sbGestion := 'Se crea nota DB';
                            
                                s_out2  := rf.mosfcuco;
                                s_out2  := s_out2||'|'||abs(rf.mosfvalo);
                                s_out2  := s_out2||'|'||'DB';
                                s_out2  := s_out2||'|'||'NA';
                                s_out2  := s_out2||'|'||31;
                                s_out2  := s_out2||'|'||'NA';
                                s_out2  := s_out2||'|'||cdtFecha;
                                
                                pGuardaLog(tbArchivos(2),s_out||'|'||s_out2||'|'||sbGestion);
                                
                            end loop;
                        exception
                            when raise_continuar then
                                rollback;
                                pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
                                nuerr := nuerr + 1; 
                            when others then
                                pkg_error.geterror(nuerror,sberror);
                                sbComentario := 'Error 1.8|'||nuCupon||'|Error en gestión cargo PA SA aplicado|'||sberror;
                                rollback;
                                pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
                                nuerr := nuerr + 1; 
                        end;
                            
                    else
                        --Actualización fecha cargos
                        if nuValError = 1 then
                            sbGestion := 'PA No Actualizado';
                        else
                            update cargos
                            set cargfecr = rc.pagofegr
                            where rowid = rc.row_id_PA
                            and cargcuco  = rc.cargcuco
                            and cargnuse = rc.cargnuse
                            and cargsign = rc.cargsign
                            and cargvalo = rc.cargvalo;
                            
                            nuRowcount := sql%rowcount;
                            
                            if nuRowcount != 1 then
                                sbComentario := 'Error 1.9|'||nuCupon||'|Actualización de cargo PA diferente al esperado ['||nuRowcount||']'||'|NA';
                                nuValError := 1;
                                rollback;
                                pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
                                nuerr := nuerr + 1; 
                                sbGestion := 'PA NO Actualizado';
                            else
                                nupu := nupu + 1;
                                sbGestion := 'PA Actualizado';
                            end if;
                        end if;
                        
                        s_out2  := rc.cargcuco;
                        s_out2  := s_out2||'|'||rc.cargvalo;
                        s_out2  := s_out2||'|'||rc.cargsign;
                        s_out2  := s_out2||'|'||rc.cargconc;
                        s_out2  := s_out2||'|'||'NA';
                        s_out2  := s_out2||'|'||rc.cargfecr;
                        s_out2  := s_out2||'|'||rc.pagofegr;
                        
                        pGuardaLog(tbArchivos(2),s_out||'|'||s_out2||'|'||sbGestion);
                        
                    end if;
                    
                    
                
                else
                    sbComentario := 'Error 1.10|'||nuCupon||'|Sin datos para gestión'||'|NA';
                    rollback;
                    pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
                    nuerr := nuerr + 1; 
                end if;    
                
            exception
                when others then
                    pkg_error.geterror(nuerror,sberror);
                    sbComentario := 'Error 1.0|'||nuCupon||'|Error en gestión de cargos duplicados|'||sberror;
                    rollback;
                    pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
                    nuerr := nuerr + 1; 
            end;
            
        end loop;
        
        commit;
        
        for rc in cuotros loop
            nuCupon := rc.pagocupo;
            if rc.pagofegr != rc.cargfecr then
                delete cargos c
                where c.rowid = rc.row_id_pa
                and c.cargnuse = rc.cargnuse
                and c.cargcuco = rc.cargcuco
                and c.cargvalo = rc.cargvalo
                and c.cargfecr = rc.cargfecr;
                
                nuRowcount := sql%rowcount;
                
                if nuRowcount != 1 then
                    sbComentario := 'Error 1.1|'||nuCupon||'|Borrado de Cargo Duplicado diferente al esperado ['||nuRowcount||']'||'|NA';
                    rollback;
                    pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
                    nuerr := nuerr + 1; 
                    sbGestion := 'PA Otros Dup NO Borrado';
                else
                    nupu := nupu + 1;
                    sbGestion := 'PA Otros Dup Borrado';
                    ajustaCuenta(rc.cargcuco);
                    nuok := nuok + 1;
                end if;
                
                
                s_out := nuCupon;
                s_out  := s_out||'|'||rc.pagosusc;
                s_out  := s_out||'|'||rc.pagofegr;
                s_out  := s_out||'|'||rc.pagovapa;
                s_out  := s_out||'|'||rc.cargnuse;
                s_out2  := rc.cargcuco;
                s_out2  := s_out2||'|'||rc.cargvalo;
                s_out2  := s_out2||'|'||rc.cargsign;
                s_out2  := s_out2||'|'||'NA';
                s_out2  := s_out2||'|'||rc.cargconc;
                s_out2  := s_out2||'|'||rc.cargfecr;
                s_out2  := s_out2||'|'||'NA';
                
                pGuardaLog(tbArchivos(2),s_out||'|'||s_out2||'|'||sbGestion);
                
                commit;
                
            end if;
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
