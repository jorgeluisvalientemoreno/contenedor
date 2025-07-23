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
DEFINE CASO=OSF2505

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
FECHA:          May 2025
JIRA:           OSF-4505

Descripción: Agrega producto a la tabla sesuasoc y actualiza grupo de impresión a cuenta de cobro 

    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    21/03/2024 - jcatuchemvm
    Creación
    
***********************************************************/
DECLARE
    csbCaso             constant varchar2(20)   := 'OSF4505';
    csbTitulo           constant varchar2(2000) := csbCaso||': Agrega producto a sesuasoc';
    csbFormato          constant varchar2(25)   := 'DD/MM/YYYY HH24:MI:SS';
    cdtFecha            constant date           := sysdate;
    cnuProducto         constant number         := 53066467;
    cnuContrato         constant number         := 17208323;
    
    sberror             varchar2(2000);
    nuerror             number;
    raise_continuar     exception;
    s_out               varchar2(2000);
    sbcabecera          varchar2(2000);
    sbcomentario        varchar2(2000);
    nucontador          number;
    nurowcount          number;
    nuerr               number;
    
    cursor cuData (inusesu in number) is
    select * from sesuasoc where ssassusc = cnuContrato
    and ssassesu = nvl(inusesu,ssassesu);
    rcData cuData%rowtype;
    
    cursor cuserv(inusesu in number,inususc in number) is 
    select * from servsusc
    where sesunuse = inusesu
    and sesususc = inususc;
    
    rcserv cuserv%rowtype;
    
    
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
    
    
    
BEGIN
    nucontador  := 0;
    nuerr       := 0;
    
    sbcabecera := 'Contrato|Prodcuto|Error';
    
    dbms_output.put_line(csbTitulo);
    dbms_output.put_line('================================================');
    dbms_output.put_line(sbcabecera);
    
    begin
        rcData := null;
        open cuData(cnuProducto);
        fetch cuData into rcData;
        close cuData;
        
        if rcData.ssassesu is not null then
            sbcomentario := 'Producto ya asociado al contrato '||cnuProducto||' ['||nuRowcount||']';
            raise raise_continuar;
        end  if;
        
        rcserv := null;
        open cuserv(cnuProducto,cnuContrato);
        fetch cuserv into rcserv;
        close cuserv;
        
        if rcserv.sesunuse is null then
            sbcomentario := 'Producto no pertenece al contrato '||cnuProducto||' ['||nuRowcount||']';
            raise raise_continuar;
        end if;
        
           
        insert into sesuasoc values (101,cnuContrato,cnuProducto); 
        nuRowcount := sql%rowcount;
        
        if nuRowcount != 1 then
            sbcomentario := 'No se realizó inserción del producto '||cnuProducto||' ['||nuRowcount||']';
            raise raise_continuar;
        else
            update cuencobr
            set cucogrim = 101
            where cucocodi = 3083825509
            and cuconuse = cnuProducto;
        end if;
        
        commit;
        
        nucontador  := nucontador + 1;
        sbcabecera := 'Tipo|Contrato|Prodcuto|';
        dbms_output.put_line('================================================');
        dbms_output.put_line(sbcabecera);       
        
        for rcData in cuData(null) loop
        
            s_out := rcData.ssascons;
            s_out := s_out||'|'||rcData.ssassusc;
            s_out := s_out||'|'||rcData.ssassesu;
            
            dbms_output.put_line(s_out);
            
        end loop;
    
    exception
        when raise_continuar then
            nuerr := nuerr + 1;
            rollback;
            s_out := cnuContrato;
            s_out := s_out||'|'||cnuProducto;
            s_out := s_out||'|'||sbcomentario;
            dbms_output.put_line(s_out);
            
    end;
    dbms_output.put_line('================================================');
    dbms_output.put_line('Cantidad de registros insertados: '||nucontador);
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
