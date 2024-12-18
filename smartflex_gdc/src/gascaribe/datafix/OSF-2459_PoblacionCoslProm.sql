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
DEFINE CASO=OSF-2459

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
FECHA:          Marzo 2024 
JIRA:           OSF-2459

Pobla tabla COSLPROM con la información de casos promediados desde la puesta en producción del caso OSF-2190

    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    08/03/2024 - jcatuchemvm
    Creación
    
***********************************************************/
DECLARE
    cnuFechaRelease     CONSTANT DATE := TO_DATE('24/01/2024 21:27','DD/MM/YYYY HH24:MI');
    csbFormato          CONSTANT VARCHAR2(25) := 'DD/MM/YYYY HH24:MI:SS';
    
    cursor cudata is
    with consumos as
    (
        select /*++ index ( c IX_CONSSESU04 ) */ * from conssesu c
        where cossfere between cnuFechaRelease and  to_Date('08/03/2024 09:02','DD/MM/YYYY HH24:MI')
        and cosscavc in (2001,2002,2003,2004,2013,2014,2015)
        and cossmecc = 3
        and cosscoca >  0
        and cosspecs in 
        (
            select pecscons from pericose 
            where pecsfecf > to_date('20012024','ddmmyyyy')
            
        )
        and 
        (
            cosssesu in 
            (
                1024343,1029620,1048092,1057069,1062440,1062479,1068624,1070425,
                1083523,1086623,1088822,1095619,1104977,1109324,1111748,1112196,
                1114505,1116164,1124552,1125642,1128258,1129496,1133092,1136845,
                1137730,1142775,1146272,1155407,1180198,1189581,2037567,2047254,
                2057099,2060704,2064129,2064905,3000146,5057725,5061369,6074825,
                6079031,6086805,6092457,6094504,6101785,6102180,6102987,6107552,
                6109542,6528155,6586788,6591788,7055307,10000932,10001658,10001738,
                17005836,2074300,1043198,1107498,1112978,1137497,1188346,2019107,
                3056905,3058285,6064213,6079229,6080929,6106712,6103964,6105692,
                8086879,6131886,6521472,6533240,6568369,7057497,7057892,10004710,
                13002435,14516504,16003237,6620684,14516879,17021481,17029343,17047897,
                17075082,17075666,17101433,17153578,17165614,17166346,17173128,17178262,
                17193363,17209409,17231183,19000045,19000113,25000351,27000890,50009153,
                50021466,50037806,50066633,50069351,50085155,50089177,50294520,50323370,
                50364532,50523941,50533282,50534446,50720946,50884970,51275386,51341088,
                51372129,51618601,51791489,52135856,52248338,52495571,52496349,52496495,
                52496516,52496522,52496527,52496536,52496555,52496725,17098097,50035178,
                50043694,50061874,50076649,50079556,50111639,50168588,50197134,50322742,
                50366446,50543874,50680222,50932277,51218753,51361521,51609359,52286728,
                50331835,50893284,51032474,51353026,51576353,52092165
            )
        )
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
    select pefames,l.*,valor_cadena,sesucate,sesususc,sesuserv
    from lecturas l,parametros,servsusc,perifact
    where codigo = 'OBS_CONSUMO_PROMEDIO'
    and cosspefa = pefacodi 
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
    
    cursor cudata2 is
    with consumos as
    (
        select /*+ index ( c IX_CONSSESU04 ) */ * from conssesu c
        where cossfere between cnuFechaRelease and to_Date('08/03/2024 09:02','DD/MM/YYYY HH24:MI')
        and cosscavc in (2001,2002,2003,2004)
        and cossmecc = 3
        and cosscoca >  0
        and cosspecs in 
        (
            select pecscons from pericose 
            where pecsfecf > to_date('20012024','ddmmyyyy')
            
        )
        
    ),
    lecturas as
    (
        select unique c.cosssesu,c.cosspefa,c.cosspecs,c.cosscoca,c.cossfufa,c.cosscavc,c.cossfere,c.cossmecc,
        l.leemoble,l.leemobsb,l.leemobsc,l.leemleto,l.leemfele,l.leemcons,l.leemclec,
        leemoble hlemoble
        from consumos c, lectelme l
        where l.leemsesu = c.cosssesu
        and l.leempefa = c.cosspefa
        and l.leempecs = c.cosspecs
        and l.leemfele < c.cossfere
        and c.cosscavc in (2001,2002,2003,2004)
    )
    select l.*,sesucate,sesususc,sesuserv
    from lecturas l,parametros,servsusc
    where codigo = 'OBS_CONSUMO_PROMEDIO'
    and
    (
        case 
        when l.cosscavc in (2001,2002) and (l.hlemoble = 9) then 1
        when l.cosscavc in (2003,2004) and (NVL(INSTR(','||valor_cadena||',',','||l.hlemoble||','),0) > 0) then 1
        else 0
        end
    ) = 1
    and sesunuse = cosssesu
    and sesucate  =  1
    and not exists
    (
        select 'x' from personalizaciones.coslprom 
        where contrato = sesususc
        and producto = cosssesu
        and fecha = cossfere
    )
    ;
    
    CURSOR cuCOSLPROM
    (
        inuCONTRATO IN personalizaciones.COSLPROM.CONTRATO%TYPE,
        inuPRODUCTO IN personalizaciones.COSLPROM.PRODUCTO%TYPE,
        idtFECHA    IN personalizaciones.COSLPROM.FECHA%TYPE
    )
    IS
        SELECT  *
        FROM    personalizaciones.COSLPROM
        WHERE   CONTRATO = inuCONTRATO
        AND     PRODUCTO = inuPRODUCTO
        AND     FECHA = idtFECHA;
    
    rcCoslprom          personalizaciones.COSLPROM%rowtype;
    nucontador          number;
    nuexiste            number;
    nuerr               number;
    sberror             varchar2(2000);
    nuerror             number;
    nurowcount          number;
    
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
            if (rcdata.cosssesu in (6521472,6528155,6533240,6591788,17098097,17153578,17165614,17193363,17231183,50884970,51032474) and rcdata.pefames = 3) or  
            (rcdata.cosssesu not in (6521472,6528155,6533240,6591788,17098097,17153578,17165614,17193363,17231183,50884970,51032474) and rcdata.pefames = 2) then 
                rcCoslprom := null;
                open cuCOSLPROM(rcdata.sesususc,rcdata.cosssesu,rcdata.cossfere);
                FETCH cuCOSLPROM INTO rcCOSLPROM;
                close cuCOSLPROM;
                
                if rcCOSLPROM.contrato is not null then
                    update personalizaciones.COSLPROM
                    set periodo = rcdata.cosspefa,pericons = rcdata.cosspecs,regla = rcdata.cosscavc,observacion = rcdata.hlemoble
                    where contrato = rcdata.sesususc
                    and producto = rcdata.cosssesu
                    and fecha = rcdata.cossfere;
                    
                    nuRowcount := sql%rowcount;
                    if nuRowcount = 1 then 
                        nuexiste := nuexiste + 1;
                        commit;
                    else
                        dbms_output.put_line('Para el contrato '||rcdata.sesususc||', producto '||rcdata.cosssesu||' y fecha '||rcdata.cossfere||' existe más de un registro ['||nuRowcount||']');
                        rollback;
                        nuerr := nuerr + 1;
                    end if;
                end if;
            end if;
        exception
            when others then
                nuerr := nuerr + 1;
                pkg_error.geterror(nuerror,sberror);
                dbms_output.put_line('Error en inserción registro COSLPROM Contrato: '||rcdata.sesususc||', producto: '||rcdata.cosssesu||', periodo: '||rcdata.cosspefa||', fecha: '||to_char(rcdata.cossfere,csbFormato));
        end;
    end loop;
    
    for rcdata in cudata2 loop
        begin
            --valida existencia del registro           
            rcCoslprom := null;
            open cuCOSLPROM(rcdata.sesususc,rcdata.cosssesu,rcdata.cossfere);
            FETCH cuCOSLPROM INTO rcCOSLPROM;
            close cuCOSLPROM;
            
            if rcCOSLPROM.contrato is null then
            
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
    dbms_output.put_line('Cantidad de registros actualizados: '||nuexiste);
    dbms_output.put_line('Cantidad de registros insertados: '||nucontador);
    dbms_output.put_line('Cantidad de errores: '||nuerr);
    
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
