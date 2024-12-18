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
DEFINE CASO=OSF-2873

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
JIRA:           OSF-2873

Descripción: Actualización de cargo doble asociado a pagos. Error integraciones.


    
    Archivo de entrada 
    ===================
    NA
    
    Archivo de Salida 
    ===================
    OSF2524Saldos_DDMMYYYY_HH24MI_Poblacion.txt
    OSF2524Saldos_DDMMYYYY_HH24MI_Log.txt
    
    --Modificaciones    
    08/04/2024 - jcatuchemvm
    Creación
    
***********************************************************/
DECLARE
    csbCaso             constant varchar2(20)   := 'OSF2873';
    csbTitulo           constant varchar2(2000) := csbCaso||': Actualización de cargos dobles';
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
    nucargos            number;
    nusafa              number;
    numovi              number;
    nucgsa              number;
    nucont              number;
    nucont1             number;
    nuRowcount          number;
    raise_continuar     exception;
    s_out               varchar2(2000);
    flFile              utl_file.file_type;
    
    cursor cudata is
    with base as 
    (
        select pagocupo,pagofepa,pagofegr,pagovapa,c.cargcuco,c.cargnuse,c.cargconc,c.cargsign,c.cargvalo,c.cargdoso,c.cargcodo,c.cargfecr,
        b.cargfecr cargfecrb,b.rowid row_idb
        from pagos,cargos c,cargos b
        where pagocupo in (select cuponume from temp_cupones) --= 235986666
        and pagocupo = c.cargcodo
        and c.cargsign = 'PA'
        and c.cargconc = 145
        and c.cargfecr between pagofegr-1/86400 and pagofegr+1/86400
        and b.cargnuse = c.cargnuse
        and b.cargcuco = c.cargcuco
        and b.cargconc = c.cargconc
        and b.cargsign = c.cargsign
        and b.cargvalo = c.cargvalo
        and b.cargdoso = c.cargdoso
        and b.cargcodo = c.cargcodo 
        and b.rowid != c.rowid
        --and c.cargcodo = 236209817
    )
    select b.*,
    (
        select rowid from cargos a
        where a.cargnuse = b.cargnuse
        and a.cargcuco = b.cargcuco
        and a.cargconc = 123
        and a.cargsign = 'SA'
        and a.cargfecr between b.cargfecrb-1/86400 and b.cargfecrb+1/86400
        
    ) row_idas,
    (
        select safacons from saldfavo
        where safasesu = b.cargnuse
        and safadocu = b.cargcuco
        and safaorig = 'PA'
        and safafecr between b.cargfecrb-1/86400 and b.cargfecrb+1/86400
        and 
        (
            select sum(mosfvalo)
            from movisafa
            where mosfsafa = safacons
        ) = safavalo
    ) safacons
    from base b;
    
    nucupon number;
    
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
        nucargos    := 0;
        nusafa := 0;
        numovi := 0;
        nucgsa := 0;
        
        tbArchivos.delete; 

        
        tbArchivos(1).nombre  := '--Log';
        tbArchivos(2).nombre  := '--Población';
        
        tbArchivos(1).flgprint  := 'S';
        tbArchivos(2).flgprint  := 'S';
       
        nuOuts := tbArchivos.last;
        
        sbCabecera := 'TipoError|Cupon|Mensaje|Error'; 
        tbArchivos(cnuIdErr).cabecera := sbCabecera;
        
        sbCabecera := 'Cupon|PagoFepa|PagoFegr|Pagovapa|Cargcuco|Cargnuse|Cargconc|Cargsign|Cargvalo|Cargdoso|Cargcodo|Cargfecr|CargfecrB|RowIdB|RowIdSA|Safacons|Gestión';
        tbArchivos(2).cabecera := sbCabecera;
        
        dbms_output.put_line(csbTitulo);
        dbms_output.put_line('================================================');
        
        flFile := utl_file.fopen('/smartfiles/tmp', 'OSF-2873_Log.txt', 'w');
        
        
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
                        if i = 2 then
                            Utl_file.put_line(flFile,tbArchivos(i).tblog(j),TRUE);
                        else
                            pCustomOutput(tbArchivos(i).tblog(j));
                        end if;
                    end loop;
                end if;
            end if;           
        end loop;
        
        utl_file.fclose( flFile );
    exception
        when others then
        dbms_output.put_line(sbComentario); 
    END pEsbribelog;
    
    PROCEDURE pCerrarLog IS
    BEGIN
        
        pGuardaLog(tbArchivos(cnuIdErr),'================================================');
        pGuardaLog(tbArchivos(cnuIdErr),'Finaliza gestión caso '||csbCaso);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de cargos PA actualizados: '||nucargos);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de cargos SA actualizados: '||nucgsa);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de Saldfavos actualizados: '||nusafa);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de Movisafas actualizados: '||numovi);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de errores: '||nuerr);  
        pGuardaLog(tbArchivos(cnuIdErr),'Rango Total de Ejecución ['||to_char(cdtFecha,'dd/mm/yyyy')||']['||to_char(cdtFecha,'hh24:mi:ss')||' - '||to_char(sysdate,'hh24:mi:ss')||']');
        pGuardaLog(tbArchivos(cnuIdErr),'Tiempo Total de Ejecución ['||fnc_rs_CalculaTiempo(cdtFecha,sysdate)||']');
        
        pEsbribelog();
        
    END pCerrarLog;
    
    PROCEDURE pCerrarLogE IS
    BEGIN
        pGuardaLog(tbArchivos(cnuIdErr),'================================================');
        pGuardaLog(tbArchivos(cnuIdErr),'Finaliza gestión con Error ' ||csbCaso||': '||sqlerrm );
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de cargos PA actualizados: '||nucargos);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de cargos SA actualizados: '||nucgsa);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de Saldfavos actualizados: '||nusafa);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de Movisafas actualizados: '||numovi);
        pGuardaLog(tbArchivos(cnuIdErr),'Cantidad de errores: '||nuerr);  
        pGuardaLog(tbArchivos(cnuIdErr),'Rango Total de Ejecución ['||to_char(cdtFecha,'dd/mm/yyyy')||']['||to_char(cdtFecha,'hh24:mi:ss')||' - '||to_char(sysdate,'hh24:mi:ss')||']');
        pGuardaLog(tbArchivos(cnuIdErr),'Tiempo Total de Ejecución ['||fnc_rs_CalculaTiempo(cdtFecha,sysdate)||']');
        
        pEsbribelog();
        
    END pCerrarLogE;
    
    PROCEDURE pGestionCaso  IS
        
    BEGIN    
        
        for rd in cudata loop
            begin 
                nucupon := rd.pagocupo;
                
                if rd.row_idb is not null then
                
                    if rd.row_idas is null or (rd.row_idas is not null and rd.safacons is not null) then
                
                        update cargos c
                        set c.cargvalo = 0, cargvabl = c.cargvalo
                        where c.rowid = rd.row_idb
                        and cargnuse = rd.cargnuse
                        and cargcuco = rd.cargcuco
                        and cargcodo = nucupon;
                        
                        nuRowcount := sql%rowcount;
                        
                        if nuRowcount != 1 then
                            sbComentario := 'Error 1.1|'||nuCupon||'|Actualización de cargos diferentes a los esperados ['||nuRowcount||']'||'|NA';
                            raise raise_continuar;
                        end if;
                        
                        nucargos := nucargos + 1;
                        
                        if rd.row_idas is not null then
                        
                            update movisafa
                            set mosfvalo = 0
                            where mosfsafa= rd.safacons;
                            
                            nuRowcount := sql%rowcount;
                            
                            if nuRowcount = 1 then 
                            
                                update saldfavo 
                                set safavalo = 0
                                where safacons = rd.safacons;
                                
                                nuRowcount := sql%rowcount;
                            
                                if nuRowcount = 1 then 
                                
                                    update cargos c 
                                    set c.cargvalo = 0, c.cargvabl = c.cargvalo
                                    where c.rowid = rd.row_idas 
                                    and cargnuse = rd.cargnuse
                                    and  cargcuco = rd.cargcuco
                                    and cargsign = 'SA';
                                    
                                    nuRowcount := sql%rowcount;
                                    
                                    if nuRowcount != 1 then
                                        sbComentario := 'Error 1.1|'||nuCupon||'|Actualización de cargos SA diferentes a los esperados ['||nuRowcount||']'||'|NA';
                                        raise raise_continuar;
                                    end if;
                                    
                                    nusafa := nusafa + 1;
                                    numovi := numovi + 1;
                                    nucgsa := nucgsa + 1;
                                    
                                    ajustaCuenta(rd.cargcuco);
                                else 
                                    sbComentario := 'Error 1.1|'||nuCupon||'|Actualización de saldfavos diferentes a los esperados ['||nuRowcount||']'||'|NA';
                                    raise raise_continuar;
                                end if;
                            else 
                                sbComentario := 'Error 1.1|'||nuCupon||'|Actualización de movisafas diferentes a los esperados ['||nuRowcount||']'||'|NA';
                                raise raise_continuar;
                            end if;
                                
                        end if; 
                    end if;
                    
                    commit;
                    
                    s_out := nucupon;
                    s_out := s_out||'|'||rd.pagofepa;
                    s_out := s_out||'|'||rd.pagofegr;
                    s_out := s_out||'|'||rd.pagovapa;
                    s_out := s_out||'|'||rd.cargcuco;
                    s_out := s_out||'|'||rd.cargnuse;
                    s_out := s_out||'|'||rd.cargconc;
                    s_out := s_out||'|'||rd.cargsign;
                    s_out := s_out||'|'||rd.cargvalo;
                    s_out := s_out||'|'||rd.cargdoso;
                    s_out := s_out||'|'||rd.cargcodo;
                    s_out := s_out||'|'||rd.cargfecr;
                    s_out := s_out||'|'||rd.cargfecr;
                    s_out := s_out||'|'||rd.row_idb;
                    s_out := s_out||'|'||rd.row_idas;
                    s_out := s_out||'|'||rd.safacons;
                    s_out := s_out||'|'||'Actualizado';
                    
                  
                    
                    pGuardaLog(tbArchivos(2),s_out);
                end if;
                           
              
            exception
                when raise_continuar then
                    rollback;
                    pGuardaLog(tbArchivos(cnuIdErr),sbComentario);
                    nuerr := nuerr + 1; 
                when others then
                    pkg_error.geterror(nuerror,sberror);
                    sbComentario := 'Error 1.4|'||nuCupon||'|Error en actualización de cargos en la cuenta '||rd.cargcuco||' para el cargo '||rd.cargconc||'|'||sberror;
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
