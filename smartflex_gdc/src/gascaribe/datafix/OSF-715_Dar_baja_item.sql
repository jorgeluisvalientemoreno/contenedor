column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
/***********************************************************
ELABORADO POR:  Juan Gabriel Catuche Girón
EMPRESA:        MVM Ingeniería de Software
FECHA:          Noviembre 2022
JIRA:           OSF-715

Adaptación script SOSF-662_DarBajaMedidor.sql para dara de baja items seriado

    
    Archivo de entrada 
    ===================
    NA            
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    
    25/11/2022 - jcatuchemvm
    Creación
    
***********************************************************/
declare
    --Constantes para el datafix
    cnuitemseriado  constant ge_items_seriado.id_items_seriado%type     := 2322055;
    cnuoperunit     constant or_operating_unit.operating_unit_id%type   := 3020;
    cnucantidad     constant number := 1;
    
    --Cursor para extracción de data
    cursor cudata is 
    select ib.items_id,ib.operating_unit_id,ib.quota,ibg.quota quota_g,
    iz.id_items_seriado,iz.serie,iz.costo,iz.OPERATING_UNIT_ID operating_unit_seriado_ant,null operating_unit_seriado_act,iz.ID_ITEMS_ESTADO_INV id_items_estado_inv_ant,8 id_items_estado_inv_act,
    ib.BALANCE balance_ant,ibg.balance balance_g_ant,
    case when (ib.balance-1)< 0 then 0 else (ib.balance-1) end balance_act,
    case when (ibg.balance-1)<0 then 0 else (ibg.balance-1) end balance_g_act,
    ib.TOTAL_COSTS total_costs_ant,ibg.total_costs total_costs_g_ant,
    case when (ib.TOTAL_COSTS-iz.costo) < 0 then 0 else (ib.TOTAL_COSTS-iz.costo) end total_costs_act,
    case when (ibg.total_costs-iz.costo)<0 then 0 else (ibg.total_costs-iz.costo) end total_costs_g_act, 
    'OSF-715' comment_
    from or_ope_uni_item_bala ib, ge_items_seriado iz,ldc_inv_ouib ibg
    where ib.operating_unit_id = cnuoperunit
    and ib.items_id = iz.items_id
    and iz.id_items_seriado = cnuitemseriado
    and ibg.items_id = ib.items_id
    and ibg.operating_unit_id = ib.operating_unit_id
    ;
    
    cursor cuitembalmax(inuoperating_unit in or_uni_item_bala_mov.OPERATING_UNIT_ID%type, inuitems in or_uni_item_bala_mov.items_id%type) is
    select max(uni_item_bala_mov_id) 
    from or_uni_item_bala_mov im 
    where im.OPERATING_UNIT_ID = inuoperating_unit 
    and im.items_id = inuitems;
    
    nuni_item_bala_mov_id   or_uni_item_bala_mov.uni_item_bala_mov_id%type;
    
    nuRowcount  number;
    s_out       varchar2(2000);
    dtfecha     date;
    nuok        number;
    nuerr       number;
    sberror     varchar2(2000);
    nuerror     number;
    sbcabecera  varchar2(2000);
    sbActualiza varchar2(20);
    
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
    dtfecha := sysdate;
    nuok := 0;
    nuerr := 0;
    
    sbcabecera := 'IDItemSeriado|Serie|ItemId|OperatingUnit|Quota|QuotaG|Costo|OperatingUnit_ant|OperatingUnid_act|EstadoInv_ant|EstadoInv_act|Balance_ant|BalanceG_ant|Balance_act|BalanceG_act|';
    sbcabecera := sbcabecera||'TotalCost_ant|TotalCostG_ant|TotalCost_act|TotalCostG_act|Comment_act|Actualizado';
    dbms_output.put_line('OSF-715: Baja de equipo seriado');
    dbms_output.put_line('=======================================================');
    dbms_output.put_line(sbcabecera);
    
    for rcdata in cudata loop
    
        begin
            sbActualiza := 'N';
            
            if rcdata.id_items_estado_inv_act != rcdata.id_items_estado_inv_ant then
            
                update ge_items_seriado s
                set s.id_items_estado_inv = rcdata.id_items_estado_inv_act,
                s.operating_unit_id = rcdata.operating_unit_seriado_act
                where s.serie = rcdata.serie
                and s.id_items_seriado = rcdata.id_items_seriado;
                
                nuRowcount := sql%rowcount;
                
                if nuRowcount = 1 then
                    update or_ope_uni_item_bala b
                    set b.balance = rcdata.balance_act,
                    b.total_costs = rcdata.total_costs_act
                    where b.items_id = rcdata.items_id
                    and b.operating_unit_id = rcdata.operating_unit_id;
                    
                    nuRowcount := sql%rowcount;
                
                    if nuRowcount = 1 then
                        
                        update ldc_inv_ouib b
                        set b.balance = rcdata.balance_g_act,
                        b.total_costs = rcdata.total_costs_g_act
                        where b.operating_unit_id = rcdata.operating_unit_id
                        and b.items_id = rcdata.items_id;
                        
                        nuRowcount := sql%rowcount;
                        
                        if nuRowcount = 1 then
                            commit;
                            
                            DBMS_LOCK.SLEEP(5);
                            
                            open cuitembalmax(rcdata.operating_unit_id,rcdata.items_id);
                            fetch cuitembalmax into nuni_item_bala_mov_id;
                            close cuitembalmax;

                            update open.or_uni_item_bala_mov m
                            set m.comments = substr(m.comments||rcdata.comment_,1,2000),
                            m.id_items_seriado = rcdata.id_items_seriado
                            where m.uni_item_bala_mov_id = nuni_item_bala_mov_id;
                            
                            nuRowcount := sql%rowcount;
                            
                            if nuRowcount = 1 then
                                sbActualiza := 'S';
                                nuok := nuok + 1;
                                commit;
                            end if;
                        end if;
                    end if;
                end if;
            else
                sbActualiza := 'Ya actualizado';
            end if;
            s_out := rcdata.id_items_seriado;
            s_out := s_out||'|'||rcdata.serie;
            s_out := s_out||'|'||rcdata.items_id;
            s_out := s_out||'|'||rcdata.operating_unit_id;
            s_out := s_out||'|'||rcdata.quota;
            s_out := s_out||'|'||rcdata.quota_g;
            s_out := s_out||'|'||rcdata.costo;
            s_out := s_out||'|'||rcdata.operating_unit_seriado_ant;
            s_out := s_out||'|'||rcdata.operating_unit_seriado_act;
            s_out := s_out||'|'||rcdata.id_items_estado_inv_ant;
            s_out := s_out||'|'||rcdata.id_items_estado_inv_act;
            s_out := s_out||'|'||rcdata.balance_ant;
            s_out := s_out||'|'||rcdata.balance_g_ant;
            s_out := s_out||'|'||rcdata.balance_act;
            s_out := s_out||'|'||rcdata.balance_g_act;
            s_out := s_out||'|'||rcdata.total_costs_ant;
            s_out := s_out||'|'||rcdata.total_costs_g_ant;
            s_out := s_out||'|'||rcdata.total_costs_act;
            s_out := s_out||'|'||rcdata.total_costs_g_act;
            s_out := s_out||'|'||rcdata.comment_;
            s_out := s_out||'|'||sbActualiza;
            
            dbms_output.put_line(s_out);
            
            if sbActualiza = 'N' then
                rollback;
            end if;
            
        exception 
            when others then
                nuerr := nuerr + 1;
                
                s_out := rcdata.id_items_seriado;
                s_out := s_out||'|'||rcdata.serie;
                s_out := s_out||'|'||rcdata.items_id;
                s_out := s_out||'|'||rcdata.operating_unit_id;
                s_out := s_out||'|'||rcdata.quota;
                s_out := s_out||'|'||rcdata.quota_g;
                s_out := s_out||'|'||rcdata.costo;
                s_out := s_out||'|'||rcdata.operating_unit_seriado_ant;
                s_out := s_out||'|'||rcdata.operating_unit_seriado_act;
                s_out := s_out||'|'||rcdata.id_items_estado_inv_ant;
                s_out := s_out||'|'||rcdata.id_items_estado_inv_act;
                s_out := s_out||'|'||rcdata.balance_ant;
                s_out := s_out||'|'||rcdata.balance_g_ant;
                s_out := s_out||'|'||rcdata.balance_act;
                s_out := s_out||'|'||rcdata.balance_g_act;
                s_out := s_out||'|'||rcdata.total_costs_ant;
                s_out := s_out||'|'||rcdata.total_costs_g_ant;
                s_out := s_out||'|'||rcdata.total_costs_act;
                s_out := s_out||'|'||rcdata.total_costs_g_act;
                s_out := s_out||'|'||rcdata.comment_;
                s_out := s_out||'|'||sbActualiza||'-'||sqlerrm;
                
                dbms_output.put_line(s_out);
                
                rollback;
        end;

	end loop;
    
    dbms_output.put_line('=====================================================');
    dbms_output.put_line('Fin Baja de equipo seriado');
    dbms_output.put_line('Cantidad Registros Actualizados: '||nuok);
    dbms_output.put_line('Cantidad Registros con Error: '||nuerr);
    dbms_output.put_line('Tiempo Total: '||fnc_rs_CalculaTiempo(dtfecha,sysdate));
    
exception
    when others then
        sberror := sqlerrm;
        nuerror := sqlcode;
        
        dbms_output.put_line('=====================================================');
        dbms_output.put_line('Fin Baja de equipo seriado ['||nuerror||'-'||sberror||']');
        dbms_output.put_line('Cantidad Registros Borrados: '||nuok);
        dbms_output.put_line('Cantidad Registros con Error: '||nuerr);
        dbms_output.put_line('Tiempo Total: '||fnc_rs_CalculaTiempo(dtfecha,sysdate));
  
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/