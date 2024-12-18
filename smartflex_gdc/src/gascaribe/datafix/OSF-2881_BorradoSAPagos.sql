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
DEFINE CASO=OSF-2881

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
FECHA:          Junio 2024 
JIRA:           OSF-2881

Descripción: Borrado de cargos PA. SA, saldfavo y movisafas por error en pagos dobles.


    
    Archivo de entrada 
    ===================
    NA
    
    Archivo de Salida 
    ===================
    OSF2524Saldos_DDMMYYYY_HH24MI_Poblacion.txt
    OSF2524Saldos_DDMMYYYY_HH24MI_Log.txt
    
    --Modificaciones    
    24/06/2024 - jcatuchemvm
    Creación
    
***********************************************************/
DECLARE
    csbCaso             constant varchar2(20)   := 'OSF2881';
    csbTitulo           constant varchar2(2000) := csbCaso||': Borrado de cargos PA, SA, saldfavo y movisafas por pagos dobles';
    csbFormato          constant varchar2(25)   := 'DD/MM/YYYY HH24:MI:SS';
    csbFormatoL         constant varchar2(25)   := 'DDMMYYYY_HH24MI';
    csbOutPut           constant varchar2(1)    := 'N';
    csbEscritura        constant varchar2( 1 )  := 'w';
    csbLectura          constant varchar2( 1 )  := 'r';
    cnuSegundo          constant number         := 1/86400;
    cnuLimit            constant number         := 1000;
    cnuIdErr            constant number         := 1;
    cdtFecha            constant date           := sysdate;
    
    
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
    tbArchivos          tytbArchivos;
    sbRuta              parametr.pamechar%type;   
    nuHash              number;
    nuOuts              number;     
    sbError             varchar2(2000);
    nuError             number;
    sbCabecera          varchar2(2000);
    sbComentario        varchar2(2000);
    nuErr               number;
    nuok                number;
    nuwrng              number;
    nucargos            number;
    nusafa              number;
    numovi              number;
    nucgsa              number;
    nucont              number;
    nucont1             number;
    nuRowcount          number;
    raise_continuar     exception;
    s_out               varchar2(2000);
    gnuconcSA           cargos.cargconc%type;
    
    cursor cudata is
    select safacons,safasesu,safaorig,safadocu,safafecr,safaprog,safausua,safavalo,
    (select sum(mosfvalo) from movisafa where mosfsafa = safacons) mosfvalo,c.cargcodo,c.rowid row_idsa,c.cargfecr cargfecrsa,
    b.rowid row_idpa,b.cargfecr cargfecrpa
    from saldfavo,cargos c,cargos b
    where safacons in
    (
    2332244,2332036,2332158,2332029,2332068,2332035,2331972,2332027,
    2332028,2332135,2332126,2332177,2332120,2332069,2332086,2332219,
    2332248,2332155,2332212,2332202,2332246,2332216,2332242,2332010,
    2331999,2332178,2331982,2332173,2332130,2332007,2332187,2332084,
    2331996,2332031,2332037,2332217,2332156,2331973,2332137,2332123,
    2332172,2332132,2332140,2332218,2332095,2332008,2332179,2332099,
    2332125,2332133,2332249,2332228,2332115,2332176,2332229,2332149,
    2332074,2332032,2332079,2332224,2331981
    )
    and c.cargnuse = safasesu
    and safadocu = c.cargcuco
    and c.cargsign = 'SA'
    and c.cargconc = 123
    and safafecr between c.cargfecr-1/86400 and c.cargfecr+1/86400 
    and c.cargvalo = safavalo
    and safavalo = 0
    and c.cargcodo in (select cuponume from temp_cupones) 
    and c.cargcuco = b.cargcuco
    and c.cargnuse = b.cargnuse
    and b.cargconc = 145
    and b.cargsign = 'PA'
    and b.cargvalo = safavalo
    ;
    
    nucupon number;
    
    cursor cudata2 is
    select * from cuencobr
    where cucocodi in 
    (
        3061900118,
3061900121,
3063253046,
3063085977,
3063253046,
3060374080,
3063125404,
3063475026,
3063125404,
3062213183,
3063131239,
3063085980,
3063444440,
3063444440,
3062526428,
3063466691,
3063466691,
3063122721,
3063433289,
3063085977,
3063433289,
3063122721,
3062157660
    );
    
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
            
            if rcsaldos.saldo < 0 then
                if rcsaldos.cargsign = 'PA' then
                
                    rccargo := null;
                    rccargo.cargcuco := rcsaldos.cargcuco;
                    rccargo.cargnuse := rcsaldos.cargnuse;
                    rccargo.cargpefa := rcsaldos.cargpefa;
                    rccargo.cargconc := gnuconcSA;
                    rccargo.cargcaca := rcsaldos.cargcaca;
                    rccargo.cargsign := Pkbillconst.Saldofavor;
                    rccargo.cargvalo := abs(rcsaldos.saldo);
                    rccargo.cargdoso := rcsaldos.cargdoso;
                    rccargo.cargtipr := Pkbillconst.Post_Facturacion;
                    rccargo.cargfecr := rcsaldos.cargfecr;
                    rccargo.cargcodo := rcsaldos.cargcodo;
                    rccargo.cargprog := rcsaldos.cargprog;
                    rccargo.cargunid := 0;
                    rccargo.cargusua := rcsaldos.cargusua;
                    
                    Pktblcargos.Insrecord (rccargo);
                    
                    Pkupdaccoreceiv.Updaccorec
                    (
                        Pkbillconst.Cnusuma_Cargo,
                        rcsaldos.cargcuco,
                        rcsaldos.sesususc,
                        rcsaldos.cargnuse,
                        gnuconcSA,
                        Pkbillconst.Saldofavor,
                        abs(rcsaldos.saldo),
                        Pkbillconst.Cnuupdate_Db
                    );
                    
                    rcsaldfavo := null;
                    nusafacons := PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL('sq_saldfavo_safacons');
                    
                    rcsaldfavo.safacons := nusafacons;
                    rcsaldfavo.safasesu := rcsaldos.cargnuse;
                    rcsaldfavo.safaorig := rcsaldos.cargsign;
                    rcsaldfavo.safadocu := rcsaldos.cargcuco;
                    rcsaldfavo.safafech := trunc(rcsaldos.cargfecr);
                    rcsaldfavo.safasesu := rcsaldos.cargnuse;
                    rcsaldfavo.safavalo := abs(rcsaldos.saldo);
                    rcsaldfavo.safafecr := rcsaldos.cargfecr;
                    rcsaldfavo.safausua := rcsaldos.mask;
                    rcsaldfavo.safaprog := rcsaldos.proccodi;
                    rcsaldfavo.safaterm := PKGENERALSERVICES.FSBGETTERMINAL;
                    
                    Pktblsaldfavo.Insrecord (rcsaldfavo);
                    
                    rcmovisafa := null;
                    numosfcons := PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL('sq_movisafa_mosfcons');
                    
                    rcmovisafa.mosfcons := numosfcons;
                    rcmovisafa.mosfsesu := rcsaldfavo.safasesu;
                    rcmovisafa.mosfsafa := nusafacons;
                    rcmovisafa.mosfdoso := null;
                    rcmovisafa.mosffech := rcsaldfavo.safafech;
                    rcmovisafa.mosfvalo := rcsaldfavo.safavalo;
                    rcmovisafa.mosfcuco := rcsaldfavo.safadocu;
                    rcmovisafa.mosfnota := null;
                    rcmovisafa.mosfdeta := rcsaldfavo.safaorig;
                    rcmovisafa.mosffecr := rcsaldfavo.safafecr;
                    rcmovisafa.mosfusua := rcsaldfavo.safausua;
                    rcmovisafa.mosfprog := rcsaldfavo.safaprog;
                    rcmovisafa.mosfterm := rcsaldfavo.safaterm;
                    
                    Pktblmovisafa.Insrecord (rcmovisafa);
                    
                else
                    --método normal
                    if rcsaldos.cargsign = 'CR' then
                        pkAccountMgr.GenPositiveBal(rcsaldos.cargcuco,rcsaldos.cargconc,rcsaldos.saldo);
                    else
                        pkAccountMgr.GenPositiveBal(rcsaldos.cargcuco,null,0);
                    end if;
                end if;
                
            end if;
        end if;

    EXCEPTION
        when pkg_error.CONTROLLED_ERROR then
          raise pkg_error.CONTROLLED_ERROR;
        when others then
          pkg_error.setError;
          raise pkg_error.CONTROLLED_ERROR;
    END ajustaCuenta;
    
    procedure actualizaSafas(inucuenta in cuencobr.cucocodi%type) is 
        cursor cusesusafa (inucuco in number) is
        select cucocodi,cuconuse,
        (select sum(mosfvalo) from movisafa,saldfavo where safasesu = cuconuse and mosfsafa = safacons ) sesusafa
        from cuencobr
        where cucocodi = inucuco
        ;
        
        rcsesusafa      cusesusafa%rowtype;

        cursor cususcsafa (inusesu in number) is
        select susccodi,
        (
            select sum(mosfvalo) from movisafa,saldfavo,servsusc where sesususc = susccodi and safasesu = sesunuse and mosfsafa = safacons
        ) suscsafa 
        from suscripc
        where susccodi = (select sesususc from servsusc where sesunuse = inusesu)
        ;
        
        rcsuscsafa      cususcsafa%rowtype;
        
    begin
    
        rcsesusafa := null;
        open cusesusafa(inucuenta);
        fetch cusesusafa into rcsesusafa;
        close cusesusafa;
        
        if rcsesusafa.cucocodi is not null  then
            update servsusc
            set sesusafa = nvl(rcsesusafa.sesusafa,0)
            where  sesunuse = rcsesusafa.cuconuse;
            
            rcsuscsafa := null;
            open cususcsafa(rcsesusafa.cuconuse);
            fetch cususcsafa into rcsuscsafa;
            close cususcsafa;
            
            update suscripc
            set suscsafa = nvl(rcsuscsafa.suscsafa,0)
            where susccodi = rcsuscsafa.susccodi;
            
        end if;
        
    end actualizaSafas;
    
    
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
        sbRuta := '/smartfiles/tmp';
        
        if gnuconcSA is null then
            Pkbillingparammgr.Getposbalancecnc (gnuconcSA);
        end if;
        
        nucont      := 0;
        nucont1     := 0;
        nuok        := 0;
        nuerr       := 0;
        nucargos    := 0;
        nusafa := 0;
        numovi := 0;
        nucgsa := 0;
        
        tbArchivos.delete; 
        
        tbArchivos(0).nombre  := csbCaso||'_In.txt';
        tbArchivos(1).nombre  := csbCaso||'_'||to_char(cdtFecha,csbFormatoL)||'_Log.txt';
        tbArchivos(2).nombre  := csbCaso||'_'||to_char(cdtFecha,csbFormatoL)||'_Poblacion.txt';
        tbArchivos(3).nombre  := csbCaso||'_'||to_char(cdtFecha,csbFormatoL)||'_Cuentas.txt';
        
        tbArchivos(0).flgprint  := 'N';
        tbArchivos(1).flgprint  := 'S';
        tbArchivos(2).flgprint  := 'S';
        tbArchivos(3).flgprint  := 'S';
        
        tbArchivos(0).tipoarch :=  csbLectura;
        tbArchivos(1).tipoarch :=  csbEscritura;
        tbArchivos(2).tipoarch :=  csbEscritura;
        tbArchivos(3).tipoarch :=  csbEscritura;

        
        nuOuts := tbArchivos.last;
        
        sbCabecera := 'TipoError|Cupon|Mensaje|Error'; 
        tbArchivos(cnuIdErr).cabecera := sbCabecera;
        
        sbCabecera := 'Cupon|Safasesu|Safaprog|Safadocu|Safafecr|Safausua|Safavalo|Mosfvalo|rowidsa|cargfecrsa|rowidpa|cargfecrpa|gestion';
        tbArchivos(2).cabecera := sbCabecera;
        
        sbCabecera := 'Cucocodi|Cuconuse|cucovato|cucovato_n|cucovaab|cucovaab_n|cucosacu|cucosacu_act|gestión';
        tbArchivos(3).cabecera := sbCabecera;
        
        dbms_output.put_line(csbTitulo);
        dbms_output.put_line('================================================');
        
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
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de cargos PA borrados: '||nucargos);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de cargos SA borrados: '||nucgsa);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de Saldfavos borrados: '||nusafa);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de Movisafas borrados: '||numovi);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de cuentas ajustadas: '||nuok);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de errores: '||nuerr);  
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
        pGuardaLog(tbArchivos(cnuIdErr),'================================================');
        pGuardaLog(tbArchivos(cnuIdErr),'Finaliza gestión con Error ' ||csbCaso||': '||sqlerrm );
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de cargos PA borrados: '||nucargos);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de cargos SA borrados: '||nucgsa);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de Saldfavos borrados: '||nusafa);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de Movisafas borrados: '||numovi);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de cuentas ajustadas: '||nuok);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de errores: '||nuerr);  
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
    
    PROCEDURE pGestionCaso  IS
    
        cursor cusacu (inucuco in number) is
        select nvl(cucosacu,0) cucosacu,cucovato,cucovaab from cuencobr
        where cucocodi = inucuco;
        
        rcsacu      cusacu%rowtype;
        
    BEGIN    
        
        for rd in cudata loop
            begin 
                nucupon := rd.cargcodo;
                
                if rd.row_idsa is not null and rd.row_idpa is not null then
                
                    delete movisafa
                    where mosfsafa= rd.safacons;
                    
                    nuRowcount := sql%rowcount;
                    
                    if nuRowcount = 1 then 
                        numovi := numovi + 1;
                    end if;
                    
                    delete saldfavo 
                    where safacons = rd.safacons;
                        
                    nuRowcount := sql%rowcount;
                    
                    if nuRowcount = 1 then 
                        nusafa := nusafa + 1;
                    end if;
                        
                    delete cargos c
                    where c.rowid = rd.row_idpa
                    and cargnuse = rd.safasesu
                    and cargcuco = rd.safadocu
                    and cargcodo = nucupon
                    and cargsign = 'PA'
                    and  cargvalo = 0;
                    
                    nuRowcount := sql%rowcount;
                    
                    if nuRowcount = 1 then
                        nucargos := nucargos +1;
                    end if;
                                
                    delete cargos c 
                    where c.rowid = rd.row_idsa 
                    and cargnuse = rd.safasesu
                    and  cargcuco = rd.safadocu
                    and cargcodo = nucupon
                    and cargsign = 'SA'
                    and cargvalo = 0;
                
                    nuRowcount := sql%rowcount;
                
                    if nuRowcount = 1 then
                        nucgsa := nucgsa + 1;
                    end if;
                            
                           
                    ajustaCuenta(rd.safadocu);
                    actualizaSafas(rd.safadocu);
                    
                    nuok :=  nuok + 1;
                    
                    
                    commit;
                    
                    s_out := nucupon;
                    s_out := s_out||'|'||rd.safasesu;
                    s_out := s_out||'|'||rd.safaprog;
                    s_out := s_out||'|'||rd.safadocu;
                    s_out := s_out||'|'||rd.safafecr;
                    s_out := s_out||'|'||rd.safausua;
                    s_out := s_out||'|'||rd.safavalo;
                    s_out := s_out||'|'||rd.safavalo;
                    s_out := s_out||'|'||rd.row_idsa;
                    s_out := s_out||'|'||rd.cargfecrsa;
                    s_out := s_out||'|'||rd.row_idpa;
                    s_out := s_out||'|'||rd.cargfecrpa;
                    s_out := s_out||'|'||'Borrado';
                    
                    pGuardaLog(tbArchivos(2),s_out);
                end if;
                           
              
            exception
                when raise_continuar then
                    rollback;
                    pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
                    nuerr := nuerr + 1; 
                when others then
                    pkg_error.geterror(nuerror,sberror);
                    sbComentario := 'Error 1.1|'||nuCupon||'|Error en borrado de cargos en la cuenta '||rd.safadocu||' para el cargo pago o sa|'||sberror;
                    rollback;
                    pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
                    nuerr := nuerr + 1; 
            end;
            
            
        end loop;
        
        for rd in cudata2 loop
            begin
                nuCupon := rd.cucocodi;
                ajustaCuenta(rd.cucocodi);
                actualizaSafas(rd.cucocodi);
                
                rcsacu := null;
                open cusacu(rd.cucocodi);
                fetch cusacu into rcsacu;
                close cusacu;
                
                s_out := rd.cucocodi;
                s_out := s_out||'|'||rd.cuconuse;
                s_out := s_out||'|'||rd.cucovato;
                s_out := s_out||'|'||rcsacu.cucovato;
                s_out := s_out||'|'||rd.cucovaab;
                s_out := s_out||'|'||rcsacu.cucovaab;
                s_out := s_out||'|'||nvl(rd.cucosacu,0);
                s_out := s_out||'|'||rcsacu.cucosacu;
                s_out := s_out||'|'||'ajustado';
                
                nuok :=  nuok + 1;
                
                commit;
                
                pGuardaLog(tbArchivos(3),s_out);
                
            exception
                when raise_continuar then
                    rollback;
                    pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
                    nuerr := nuerr + 1; 
                when others then
                    pkg_error.geterror(nuerror,sberror);
                    sbComentario := 'Error 1.2|'||nuCupon||'|Error en ajuste de cuenta|'||sberror;
                    rollback;
                    pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
                    nuerr := nuerr + 1; 
            end;
            
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
