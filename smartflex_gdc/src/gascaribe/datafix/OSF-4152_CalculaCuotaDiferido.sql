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
DEFINE CASO=OSF-4152

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
FECHA:          Abril 2025 
JIRA:           OSF-4152

Descripción

    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    02/04/2025 - jcatuch
    Creación
    
***********************************************************/
DECLARE
    csbCaso             constant varchar2(20)   := 'OSF4152';
    csbTitulo           constant varchar2(2000) := csbCaso||': Calculo valor de cuota Diferidos';
    csbFormato          constant varchar2(25)   := 'DD/MM/YYYY HH24:MI:SS';
    cdtFecha            constant date           := sysdate;
    
    cursor cudata is
    select *
    from diferido
    where difecodi in
    (
        83978174,
        83577219,
        83577218,
        83577215
    )
    ;
    
    cursor cutasa (inutasa in number) is
    select * from conftain
    where cotitain = inutasa
    and sysdate between cotifein and cotifefi
    order by cotifein desc;
    
    rctasa  cutasa%rowtype;
    
    CURSOR CUPLANDIFE (NUPLDICODI   PLANDIFE.PLDICODI%TYPE,
                       NUPLDIMCCD   PLANDIFE.PLDIMCCD%TYPE)
    IS
    SELECT *
    FROM PLANDIFE PD
    WHERE PD.PLDICODI = NUPLDICODI AND PD.PLDIMCCD = NUPLDIMCCD;
    
    rcPlandife      CUPLANDIFE%ROWTYPE;
    
   
    
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
    nuMethod            diferido.DIFEMECA%TYPE;
    nuTasaInte          NUMBER;
    nuInteresPorc       CONFTAIN.COTIPORC%TYPE;
    nuFactor            diferido.DIFEFAGR%TYPE;
    nuSpread            diferido.DIFESPRE%TYPE;
    nuNominalPerc       NUMBER;
    nuQuotaValue        diferido.DIFEVACU%TYPE;
    nuRoundFactor       NUMBER;
    nuIdCompany         NUMBER := 99;
    NUCuotaCalculada    NUMBER; --valor de la cuota que se calcula con la formula actual.
    NUFactorGradiante   NUMBER; --Corresponde al factor gradiente
    NUNumeroCuotas      NUMBER; --Numero de cuotas ya facturadas del diferido
    NuevoQuotaValue     NUMBER; --Neuvo Valor despues de aplicar el factor gradiante
    nuCuotas            number;
    
    
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
    
    sbcabecera := 'Diferido|Difenucu|Difecupa|Difesape|Difevacu_ant|Difevacu_act|Error';
    dbms_output.put_line(csbTitulo);
    dbms_output.put_line('================================================');
    dbms_output.put_line(sbcabecera);
    
    begin
           
        for rc in cudata loop
            
            nuMethod := null;
            nuTasaInte := null;
            nuInteresPorc := null;
            nuFactor := null;
            nuSpread := null;
            nuNominalPerc := null;
            nuQuotaValue := null;
            nuRoundFactor := null;
            NUFactorGradiante := null;
            NUNumeroCuotas := null;
            NUCuotaCalculada := null;
            NuevoQuotaValue := null;
            
            begin 
            
                --dbms_output.put_line ('Diferido: '|| rc.difecodi);
                
                s_out := rc.difecodi;
                s_out := s_out||'|'||rc.difenucu;
                s_out := s_out||'|'||rc.difecupa;
                s_out := s_out||'|'||rc.difesape;
                s_out := s_out||'|'||rc.difevacu;
                
                nuMethod :=
                    pktbldiferido.fnugetDIFEMECA (rc.difecodi);
                    
                --dbms_output.put_line ('nuMethod: '|| nuMethod);
                 
                --Obtener el interes pactado
                nuTasaInte :=
                    pktbldiferido.fnugetDIFETAIN (rc.difecodi);
                    
                --dbms_output.put_line ('nuTasaInte: '|| nuTasaInte);
                
                --Obtener tasa de interes efectivo anual
                nuInteresPorc :=
                    pktbldiferido.fnugetdifeinte (rc.difecodi);
                    
                --dbms_output.put_line ('nuInteresPorc: '|| nuInteresPorc);
                
                --Obtener el factor gradiente
                nuFactor :=
                    pktbldiferido.fnugetdifefagr (rc.difecodi);
                
                --dbms_output.put_line ('nuFactor: '|| nuFactor);
                
                --Obtener el Spread
                nuSpread :=
                    pktbldiferido.fnugetDIFESPRE (rc.difecodi);
                    
                --dbms_output.put_line ('nuSpread: '|| nuSpread);
                    
                if rc.difesape = 0 then
                
                    s_out := s_out||'|'||rc.difevacu;
                    s_out := s_out||'|'||'Diferido sin saldo';
                    
                elsif rc.difetain = 2 then --Tasa de usura
                
                    nucontador := nucontador + 1;
                    
                    rctasa := null;
                    open cutasa (rc.difetain);
                    fetch cutasa into rctasa;
                    close cutasa;
                    
                    --dbms_output.put_line ('rctasa.cotiporc: '|| rctasa.cotiporc);
                    
                    if nuInteresPorc > rctasa.cotiporc then
                        nuInteresPorc := rctasa.cotiporc; 
                    end if;
                    
                    --Calcula el interes nominal
                    pkDeferredMgr.ValInterestSpread 
                    (
                        nuMethod, -- Metodo de Calculo
                        nuInteresPorc, -- Porcentaje de Interes (Efectivo Anual)
                        nuSpread,   -- Spread
                        nuNominalPerc -- Interes Nominal (Salida)
                    );
                    
                    --dbms_output.put_line ('nuNominalPerc: '|| nuNominalPerc);
                    
                    --dbms_output.put_line ('pktbldiferido.fnugetdifesape: '|| rc.difesape);
                    --dbms_output.put_line ('pktbldiferido.fnugetDIFENUCU: '|| rc.difenucu);
                    --dbms_output.put_line ('pktbldiferido.fnugetdifecupa: '|| rc.difecupa);
                    
                    nuCuotas := rc.difenucu - rc.difecupa;
                    
                    if nuCuotas <= 0 then
                        nuCuotas := 1;
                    end if;
                    
                    -- Obtiene el valor de la cuota
                    pkDeferredMgr.CalculatePayment 
                    (
                        rc.difesape, -- Saldo a Diferir (difesape)
                        nuCuotas, -- Numero de Cuotas  diferido
                        nuNominalPerc,                  -- Interes Nominal
                        nuMethod,                     -- Metodo de Calculo
                        nuFactor,       --nuSpread,              -- Spread
                        nuInteresPorc + nuSpread, -- Interes Efectivo mas Spread
                        nuQuotaValue         -- Valor de la Cuota (Salida)
                    );
                    
                    --dbms_output.put_line ('nuQuotaValue: '|| nuQuotaValue);
                    
                    --  Obtiene el factor de redondeo para la suscripcion
                    FA_BOPoliticaRedondeo.ObtFactorRedondeo
                    (
                        rc.difesusc,
                        nuRoundFactor,
                        nuIdCompany
                    );
                    
                    
                    rcPlandife := null;
                    OPEN CUPLANDIFE (rc.difepldi,nuMethod);
                    FETCH CUPLANDIFE INTO rcPlandife;
                    close cuplandife;
                    
                    if rcPlandife.pldicodi is not null then
                    
                        NUFactorGradiante := rcPlandife.PLDIFAGR;
                        --dbms_output.put_line ('NUFactorGradiante: '|| NUFactorGradiante);
                        
                        NUNumeroCuotas := rc.difecupa;
                                    --NUNumeroCuotas := 3;
                        --dbms_output.put_line ('NUNumeroCuotas: '|| NUNumeroCuotas);
                                   
                        NUCuotaCalculada := POWER ((1 + (NUFactorGradiante / 100)),
                                               NUNumeroCuotas);
                                               
                        --dbms_output.put_line ('NUCuotaCalculada: '|| NUCuotaCalculada);

                        NuevoQuotaValue := nuQuotaValue / NUCuotaCalculada;

                        --dbms_output.put_line ('Valor anterior ['|| nuQuotaValue|| '] - Nuevo Valor ['|| NuevoQuotaValue|| ']');

                        --  Aplica politica de redondeo al valor de la cuota
                        nuQuotaValue := ROUND (NuevoQuotaValue, nuRoundFactor);
                        --dbms_output.put_line ('nuQuotaValueRoundFactor: '|| nuQuotaValue);
                        
                        --Actualizar el valor de la cuota en el diferido
                        pktbldiferido.upddifevacu (rc.difecodi,nuQuotaValue);

                        pktbldiferido.upddifeinte (rc.difecodi,nuInteresPorc);
                        
                        commit;
                        
                        s_out := s_out||'|'||nuQuotaValue;
                        s_out := s_out||'|'||'Ok';
                        nuok := nuok + 1;
                        
                    else
                    
                        s_out := s_out||'|'||rc.difevacu;
                        s_out := s_out||'|'||'Sin información plan financiación';
                    
                    end if;

                else
                
                    s_out := s_out||'|'||rc.difevacu;
                    s_out := s_out||'|'||'No Tasa interés diferente';
                    
                end if;
                
                dbms_output.put_line(s_out);
            
            exception
                when others then
                    rollback;
                    nuerr := nuerr + 1;
                    pkg_error.seterror;
                    pkg_error.geterror(nuerror,sberror);
                    sbcomentario := 'Error en actualizacion cuota diferido. Error '||sberror;
                    s_out := s_out||'|'||sbcomentario;
                    dbms_output.put_line(s_out);
            end;
            
      
        end loop;
        
        
        if nucontador = 0 then
            sbcomentario := 'Sin datos de diferidos para gestión';
            nuerr := nuerr + 1;
            s_out  := '||||';
            s_out := s_out||'|'||sbcomentario;
            dbms_output.put_line(s_out);
        end if;
    
    exception
        when others then
            rollback;
            nuerr := nuerr + 1;
            sbcomentario := 'Error desconocido: '||sqlerrm;
            s_out  := '||||';
            s_out := s_out||'|'||sbcomentario;
            dbms_output.put_line(s_out);
            
    end;
    dbms_output.put_line('================================================');
    dbms_output.put_line('Fin gestión caso '||csbCaso);
    dbms_output.put_line('Cantidad de diferidos actualizados: '||nuok);
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
