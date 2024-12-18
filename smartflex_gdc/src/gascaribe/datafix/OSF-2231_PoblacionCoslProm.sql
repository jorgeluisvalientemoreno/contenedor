/***********************************************************
ELABORADO POR:  Juan Gabriel Catuche Giron
EMPRESA:        MVM Ingenieria de Software
FECHA:          Enero 2024 
JIRA:           OSF-2231

Pobla tabla COSLPROM con la información de casos promediados desde la puesta en producción del caso OSF-2190

    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    29/01/2024 - jcatuchemvm
    Creación
    
***********************************************************/
DECLARE
    cnuFechaRelease     CONSTANT DATE := TO_DATE('24/01/2024 21:27','DD/MM/YYYY HH24:MI');
    csbFormato          CONSTANT VARCHAR2(25) := 'DD/MM/YYYY HH24:MI:SS';
    
    cursor cudata is
    with consumos as
    (
        select /*+ index ( c IX_CONSSESU04 ) */ * from conssesu c
        where cossfere > cnuFechaRelease
        and cosscavc in (2001,2002,2003,2004,2013,2014,2015)
        and cossmecc = 3
        and cosscoca >  0
        and cosspecs in 
        (
            select pecscons from pericose 
            where pecsfecf > to_date('20012024','ddmmyyyy')
            
        )
        --and cosssesu = 1022528
    ),
    lecturas as
    (
        select unique c.cosssesu,c.cosspefa,c.cosspecs,c.cosscoca,c.cossfufa,c.cosscavc,c.cossfere,c.cossmecc,
        l.leemoble,l.leemobsb,l.leemobsc,l.leemleto,l.leemfele,l.leemcons,l.leemclec,
        --first_value(h.hlemcons) over (partition by h.hlemelme,c.cossfere order by h.hlemfele desc) hlemcons,
        first_value(nvl(h.hlemoble,0)) over (partition by h.hlemelme,c.cossfere order by h.hlemfele desc) hlemoble,
        first_value(h.hlemfele) over (partition by h.hlemelme,c.cossfere order by h.hlemfele desc) hlemfele
        from consumos c, lectelme l,hileelme h
        where l.leemsesu = c.cosssesu
        and l.leempefa = c.cosspefa
        and l.leempecs = c.cosspecs
        and h.hlemelme = l.leemcons
        and h.hlemfele < c.cossfere
        and c.cosscavc in (2001,2002,2003,2004) 
        union all 
        select unique c.cosssesu,c.cosspefa,c.cosspecs,c.cosscoca,c.cossfufa,c.cosscavc,c.cossfere,c.cossmecc,
        l.leemoble,l.leemobsb,l.leemobsc,l.leemleto,l.leemfele,l.leemcons,l.leemclec,
        leemoble,
        leemfele
        from consumos c, lectelme l
        where l.leemsesu = c.cosssesu
        and l.leempefa = c.cosspefa
        and l.leempecs = c.cosspecs
        and l.leemfele < c.cossfere
        and c.cosscavc in (2013,2014,2015)
        union all 
        select unique c.cosssesu,c.cosspefa,c.cosspecs,c.cosscoca,c.cossfufa,c.cosscavc,c.cossfere,c.cossmecc,
        l.leemoble,l.leemobsb,l.leemobsc,l.leemleto,l.leemfele,l.leemcons,l.leemclec,
        leemobsb,
        leemfele
        from consumos c, lectelme l
        where l.leemsesu = c.cosssesu
        and l.leempefa = c.cosspefa
        and l.leempecs = c.cosspecs
        and l.leemfele < c.cossfere
        and c.cosscavc in (2013,2014,2015)
        union all 
        select unique c.cosssesu,c.cosspefa,c.cosspecs,c.cosscoca,c.cossfufa,c.cosscavc,c.cossfere,c.cossmecc,
        l.leemoble,l.leemobsb,l.leemobsc,l.leemleto,l.leemfele,l.leemcons,l.leemclec,
        leemobsc,
        leemfele
        from consumos c, lectelme l
        where l.leemsesu = c.cosssesu
        and l.leempefa = c.cosspefa
        and l.leempecs = c.cosspecs
        and l.leemfele < c.cossfere
        and c.cosscavc in (2013,2014,2015)
    )
    select l.*,valor_cadena,sesucate,sesususc,sesuserv
    from lecturas l,parametros,servsusc
    where codigo = 'OBS_CONSUMO_PROMEDIO'
    and
    (
        case 
        when l.cosscavc in (2001,2002,2014) and (l.hlemoble = 9) then 1
        when l.cosscavc in (2003,2004,2013,2015) and (NVL(INSTR(','||valor_cadena||',',','||l.hlemoble||','),0) > 0) then 1
        else 0
        end
    ) = 1
    and sesunuse = cosssesu
    and sesucate  =  1
    ;
    
    rcCoslprom          PKG_coslprom.styCOSLPROM;
    nucontador          number;
    nuexiste            number;
    nuerr               number;
    sberror             varchar2(2000);
    nuerror             number;
    
BEGIN
    nucontador := 0;
    nuexiste   := 0;
    nuerr      := 0;
    dbms_output.put_line('Inserción de consumos en la tabla COSLPROM');
    dbms_output.put_line('Rango de inserción ['||to_char(cnuFechaRelease,csbFormato)||'-'||to_char(sysdate,csbFormato)||']');
    dbms_output.put_line('================================================');
    
    for rcdata in cudata loop
        begin
            --valida existencia del registro
            if PKG_coslprom.fblExiste(rcdata.sesususc,rcdata.cosssesu,rcdata.cossfere,0) then
                nuexiste := nuexiste + 1;
            else
                rcCoslprom := null;
                rcCoslprom.contrato     := rcdata.sesususc;
                rcCoslprom.producto     := rcdata.cosssesu;
                rcCoslprom.periodo      := rcdata.cosspefa;
                rcCoslprom.pericons     := rcdata.cosspecs;
                rcCoslprom.regla        := rcdata.cosscavc;
                rcCoslprom.observacion  := rcdata.hlemoble;
                rcCoslprom.fecha        := rcdata.cossfere;
                PKG_coslprom.InsertaRegistro(rcCoslprom);
                nucontador := nucontador + 1;
                commit;
            end if;
        exception
            when others then
                nuerr := nuerr + 1;
                pkg_error.geterror(nuerror,sberror);
                dbms_output.put_line('Error en inserción registro COSLPROM Contrato: '||rcdata.sesususc||', producto: '||rcdata.cosssesu||', periodo: '||rcdata.cosspefa||', fecha: '||to_char(rcdata.cossfere,csbFormato));
        end;
    end loop;
    
    dbms_output.put_line('================================================');
    dbms_output.put_line('Fin de inserción tabla COSLPROM');
    dbms_output.put_line('Cantidad de registos insertados: '||nucontador);
    dbms_output.put_line('Cantidad de registos existentes: '||nuexiste);
    dbms_output.put_line('Cantidad de errores: '||nuerr);
    
END;
/
