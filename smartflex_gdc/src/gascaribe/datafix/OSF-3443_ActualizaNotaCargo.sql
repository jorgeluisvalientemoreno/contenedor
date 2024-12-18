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
DEFINE CASO=OSF-3443

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
FECHA:          Octubre 2024 
JIRA:           OSF-3443

Descripción

    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    21/10/2024 - jcatuchemvm
    Creación
    
***********************************************************/
DECLARE
    csbCaso             constant varchar2(20)   := 'OSF3443';
    csbTitulo           constant varchar2(2000) := csbCaso||': Ajuste factura nota y cargtipr';
    csbFormato          constant varchar2(25)   := 'DD/MM/YYYY HH24:MI:SS';
    cdtFecha            constant date           := sysdate;
    cnuNota          constant number         :=  154858429;
    
    cursor cudata is
    select notanume,notasusc,notafact,notafecr,
    (select max(cucofact) from cargos,cuencobr where cargcodo = notanume and cargsign in ('DB','CR') and cargcuco = cucocodi) cargfact 
    from notas
    where notanume = cnuNota;
    
    rcdata  cudata%rowtype;
    
    cursor cucargos is
    select c.rowid row_id,cargnuse,cargcuco,cargconc,cargdoso,cargcodo,cargsign,cargvalo,cargvabl,cargfecr,cargtipr,'P' cargtipr_n from cargos c
    where c.cargcuco in 
    (
        select cargcuco 
        from cargos b
        where b.cargcodo = cnuNota
        and b.cargsign in ('DB','CR')
    )
    and cargconc in (739,1026);
    
    
    sberror             varchar2(2000);
    nuerror             number;
    raise_continuar     exception;
    s_out               varchar2(2000);
    sbcabecera          varchar2(2000);
    sbcomentario        varchar2(2000);
    nucontador          number;
    nurowcount          number;
    nuok                number;
    nuerr               number;
    nucrg               number;
    
    
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
    nuok       := 0;
    nuerr       := 0;
    nucrg   :=  0;
    
    sbcabecera := 'Nota|Contrato|Fecha|Factura_ant|Factura_act|Error';
    dbms_output.put_line(csbTitulo);
    dbms_output.put_line('================================================');
    dbms_output.put_line(sbcabecera);
    
    if cudata%isopen then
        close cudata;
    end if;
    
    
    begin
    
        open cudata;
        fetch cudata into rcdata;
        close cudata;
        
        s_out := rcdata.notanume;
        s_out := s_out||'|'||rcdata.notasusc;
        s_out := s_out||'|'||rcdata.notafecr;
        s_out := s_out||'|'||rcdata.notafact;
        s_out := s_out||'|'||rcdata.cargfact;
        
        if rcdata.notanume is null then
            sbcomentario := 'Sin datos de notas para actualizar';
            raise raise_continuar;
        elsif rcdata.notafact = rcdata.cargfact then   
            sbcomentario := 'La factura de la nota ya esta actualizada ['||rcdata.notafact||']';
            raise raise_continuar;
        end if;
        
        update notas
        set notafact = rcdata.cargfact
        where notanume = rcdata.notanume;
        
        nuRowcount := sql%rowcount;
                
        if nuRowcount != 1 then
            sbcomentario := 'Actualización de factura a nota diferente a la esperada ['||nuRowcount||']';
            raise raise_continuar;
        end if;
        
        s_out := s_out||'|'||'Ok';
        dbms_output.put_line(s_out);
        nuok := nuok + 1;
        
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
            pkg_error.geterror(nuerror,sberror);
            sbcomentario := 'Error en ajuste de nota '||cnuNota||'. Error '||sberror;
            s_out := s_out||'|'||sbcomentario;
            dbms_output.put_line(s_out);
    end;
    
    sbcabecera := 'Cuenta|Producto|Concepto|Signo|Valor|Fecha|Tipo_ant|Tipo_act|IdDocumento_ant|IdDocumento_act|Documento_ant|Documento_act|Error';
    dbms_output.put_line('================================================');
    dbms_output.put_line(sbcabecera);
           
    for rc in cucargos loop
        begin 
            nucontador := nucontador + 1;
            
            s_out := rc.cargcuco;
            s_out := s_out||'|'||rc.cargnuse;
            s_out := s_out||'|'||rc.cargconc;
            s_out := s_out||'|'||rc.cargsign;
            s_out := s_out||'|'||rc.cargvalo;
            s_out := s_out||'|'||rc.cargfecr;
            s_out := s_out||'|'||rc.cargtipr;
        
            if rc.cargtipr = rc.cargtipr_n then
                sbcomentario := 'Cargo ya actualizado';
                raise raise_continuar;
            end if;
            
            update cargos c
            set cargtipr = rc.cargtipr_n,cargcodo = cnuNota,cargdoso = case when rc.cargdoso = '-' then 'ND-'||cnuNota else cargdoso end
            where c.rowid = rc.row_id
            and cargnuse = rc.cargnuse
            and cargcuco = rc.cargcuco
            and cargconc = rc.cargconc;
            
            nuRowcount := sql%rowcount;
            
            if nuRowcount != 1 then
                sbcomentario := 'Actualización de tipo de cargo diferente a lo esperado ['||nuRowcount||']';
                raise raise_continuar;
            end if;
            
            s_out := s_out||'|'||rc.cargtipr_n;
            s_out := s_out||'|'||rc.cargcodo;
            s_out := s_out||'|'||cnuNota;
            s_out := s_out||'|'||rc.cargdoso;
            s_out := s_out||'|'||'ND-'||cnuNota;
            s_out := s_out||'|'||'Ok';
            dbms_output.put_line(s_out);
            nucrg := nucrg + 1;
            
            commit;
            
          
        exception
            when raise_continuar then
                rollback;
                nuerr := nuerr + 1;
                s_out := s_out||'|'||rc.cargtipr;
                s_out := s_out||'|'||rc.cargcodo;
                s_out := s_out||'|'||rc.cargcodo;
                s_out := s_out||'|'||rc.cargdoso;
                s_out := s_out||'|'||rc.cargdoso;
                s_out := s_out||'|'||sbcomentario;
                dbms_output.put_line(s_out);
            when others then
                rollback;
                nuerr := nuerr + 1;
                s_out := s_out||'|'||rc.cargtipr;
                s_out := s_out||'|'||rc.cargcodo;
                s_out := s_out||'|'||rc.cargcodo;
                s_out := s_out||'|'||rc.cargdoso;
                s_out := s_out||'|'||rc.cargdoso;
                pkg_error.seterror;
                pkg_error.geterror(nuerror,sberror);
                sbcomentario := 'Error en ajuste de tipo de cargo de la nota '||cnuNota||' para el cargo '||rc.cargconc||'. Error '||sberror;
                s_out := s_out||'|'||sbcomentario;
                dbms_output.put_line(s_out);
        end;
        
  
    end loop;
        
        
    if nucontador = 0 then
        sbcomentario := 'Sin datos de cargos para actualizar';
        nuerr := nuerr + 1;
        s_out  := '|||||||||||';
        s_out := s_out||'|'||sbcomentario;
        dbms_output.put_line(s_out);
    end if;

    
    dbms_output.put_line('================================================');
    dbms_output.put_line('Fin gestión caso '||csbCaso);
    dbms_output.put_line('Cantidad de notas actualizadas: '||nuok);
    dbms_output.put_line('Cantidad de cargos actualizados: '||nucrg);
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
