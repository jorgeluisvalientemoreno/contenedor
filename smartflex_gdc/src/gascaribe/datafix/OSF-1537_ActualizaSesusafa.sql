column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

/***********************************************************
ELABORADO POR:  Juan Gabriel Catuche Giron
EMPRESA:        MVM Ingenieria de Software
FECHA:          Junio 2023
JIRA:           OSF-1537

Actualiza saldo a favor producto desincronizado

    
    Archivo de entrada 
    ===================
    NA
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    05/09/2023 - jcatuchemvm  
    Creación
        
***********************************************************/
declare
    cursor cudata is
    select sesunuse,sesusafa,count(safacons) cantidadSAFA,sum(safavalo) TotaSAFA,sum(saldfavo_cargos) TotalSAFACargos, sum(aplicasafa) TotalAplicado2,
    sum(saldfavo_cargos)+sum(aplicasafa) SaldoCalculado
    from 
    (
        select sesunuse,sesusafa,safasesu,safacons,safaorig,safadocu,safafecr,safaprog,proccons,safavalo,
        (
            select sum(cargvalo)
            from cargos
            where cargnuse = sesunuse
            and cargsign = 'SA'
            and cargconc = 123
            and cargprog = proccons
            and cargfecr = safafecr
        ) saldfavo_cargos,
        (
            select sum(mosfvalo) 
            from movisafa
            where mosfsafa = safacons
            and mosffecr > safafecr
            and mosfvalo = 
            (
                select -1*sum(cargvalo)
                from cargos
                where cargnuse = mosfsesu
                and cargcuco = mosfcuco
                and cargsign = 'AS'
            )
        ) AplicaSAFA
        from servsusc,saldfavo,procesos
        where sesususc = 48130429
        --and sesunuse = 50289711
        and safasesu = sesunuse
        and proccodi = safaprog
    )
    group by sesunuse,sesusafa
    ;
    nucount     number;
    sbactualiza varchar2(1);
begin
    dbms_output.put_line('OSF-1537 Actualización saldo a favor producto');
    dbms_output.put_line('Producto|Sesusafa_ant|Sesusafa_act|Actualizado');
    
    for rc in cudata loop
        
        update servsusc
        set sesusafa = rc.saldocalculado
        where sesunuse = rc.sesunuse;
        
        nucount := sql%rowcount;
        if nucount > 0 then
            sbactualiza  := 'S';
        else
            sbactualiza  := 'N';
        end if;
        
        commit; 
        
        dbms_output.put_line
        (
            rc.sesunuse||'|'||
            rc.sesusafa||'|'||
            rc.saldocalculado||'|'||
            sbactualiza
        );
        
    end loop;
end;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/