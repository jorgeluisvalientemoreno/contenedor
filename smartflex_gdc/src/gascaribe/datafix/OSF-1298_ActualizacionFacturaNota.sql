column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
/***********************************************************
ELABORADO POR:  Juan Gabriel Catuche Girón
EMPRESA:        MVM Ingeniería de Software
FECHA:          Julio 2023
JIRA:           OSF-1298

Actualización de factura en Nota

    
    Archivo de entrada 
    ===================
    NA            
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    
    05/07/2023 - jcatuchemvm
    Creación
    
***********************************************************/
declare
    --Constantes para el datafix
    csbCaso         constant varchar2(20)               := 'OSF1298';
    cnuSoli         constant mo_packages.package_id%type := 201585761;
    csbformato      constant varchar2(25)               := 'dd/mm/yyyy hh24:mi:ss';
    
    --Cursores para extracción de data
    cursor cudata is 
    select apmosoli,apmousre,apmoesaf,apmovalo,notanume,notasusc,sesunuse,notaprog,notafact,
    (
      select cucofact
      from cargos,cuencobr
      where cargnuse = sesunuse
      and cargcodo = notanume
      and cargdoso = 'N'||notatino||'-'||notadoso
      and cucocodi = cargcuco
      and rownum = 1
    ) cucofact,
    (
      select sum(decode(cargsign,'CR',-cargvalo,cargvalo))
      from cargos
      where cargnuse = sesunuse
      and cargcodo = notanume
      and cargdoso = 'N'||notatino||'-'||notadoso
    ) cargvalo
    from fa_apromofa,notas,servsusc
    where apmosoli =  201585761
    and notaapmo = apmocons
    and sesususc = notasusc;
    
    s_out       varchar2(2000);
    dtfecha     date;
    nurowcount  number;
    nuok        number;
    nuerr       number;
    sberror     varchar2(2000);
    nuerror     number;
    sbcabecera  varchar2(2000);
    sbActualiza varchar2(2000);
    
    
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
    
begin
    pkerrors.setapplication(csbCaso);
    
    dtfecha := sysdate;
    nuok := 0;
    nuerr := 0;
    
    
    sbcabecera := 'Solicitud|Usuario|Estado|Valor|NumeroNota|Contrato|Producto|Programa|Notafact_ant|Notafact_act|Actualiza';    
    dbms_output.put_line('=========================Actualización Factura a nota ==============================');
    dbms_output.put_line(sbcabecera);
    
    for rcdata in cudata loop
      if rcdata.apmovalo != rcdata.cargvalo then
        sbActualiza := 'El valor de la nota no coincide con el de los cargos ['||rcdata.apmovalo||']['||rcdata.cargvalo||']';
        nuerr := nuerr + 1;
      else
        update notas
        set notafact = rcdata.cucofact
        where notanume = rcdata.notanume;
        
        nurowcount := sql%rowcount;
        
        if nurowcount > 0 then
          sbActualiza := 'S';
          nuok := nuok + 1;
          commit;
        else
          sbActualiza := 'N';
          rollback;
        end if;        
        
        s_out := rcdata.apmosoli;
        s_out := s_out||'|'||rcdata.apmousre;
        s_out := s_out||'|'||rcdata.apmoesaf;
        s_out := s_out||'|'||rcdata.apmovalo;
        s_out := s_out||'|'||rcdata.notanume;
        s_out := s_out||'|'||rcdata.notasusc;
        s_out := s_out||'|'||rcdata.sesunuse;
        s_out := s_out||'|'||rcdata.notaprog;
        s_out := s_out||'|'||rcdata.notafact;
        s_out := s_out||'|'||rcdata.cucofact;
        s_out := s_out||'|'||sbActualiza;
        
        dbms_output.put_line(s_out);
      end if;  
    end loop;
    
    dbms_output.put_line('=====================================================');
    dbms_output.put_line('Fin DataFix '||csbCaso);
    dbms_output.put_line('Cantidad Notas Actualizadas: '||nuok);
    dbms_output.put_line('Cantidad Registros con Error: '||nuerr);
    dbms_output.put_line('Tiempo Total: '||fnc_rs_CalculaTiempo(dtfecha,sysdate));
    
exception
    when others then
      sberror := sqlerrm;
      nuerror := sqlcode;
      
      dbms_output.put_line('Cantidad Notas Actualizadas: '||nuok);
      dbms_output.put_line('Cantidad Registros con Error: '||nuerr);
      dbms_output.put_line('Tiempo Total: '||fnc_rs_CalculaTiempo(dtfecha,sysdate));
  
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/