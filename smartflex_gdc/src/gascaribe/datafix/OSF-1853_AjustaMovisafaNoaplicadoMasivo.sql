column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
/***********************************************************
ELABORADO POR:  Juan Gabriel Catuche Giron
EMPRESA:        MVM Ingenieria de Software
FECHA:          Octubre 2023
JIRA:           OSF-1853

Ajusta movimientos de saldo a favor que no se aplicaron
    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    OSF1853_AjustaMovisafaNoAplicadoMasivo_yyyymmdd_hh24mi.txt
    
    --Modificaciones    
    
    03/11/2023 - jcatuchemvm
    Creación
    
***********************************************************/
declare

    cdtfecha    constant date := sysdate;
    
    cursor cudata is
    select /*+ index ( s IX_SALDFAVO05 ) */ sesunuse,safacons,safaorig,safadocu,safafecr,safausua,safaterm,safaprog,safavalo,
    (select sum(mosfvalo) from movisafa where mosfsafa = safacons) mosfvalopendiente,
    (
        select count(*) from cargos
        where cargnuse = safasesu
        and cargcuco = safadocu
        and cargsign = 'AS'
        and cargfecr < safafecr --to_date('22/09/2023 08:45:06','dd/mm/yyyy hh24:mi:ss')
    ) cantidadAS,
    (
        select count(*) from cargos
        where cargnuse = safasesu
        and cargcuco = safadocu
        and cargsign = 'AS'
        and cargfecr < safafecr --to_date('22/09/2023 08:45:06','dd/mm/yyyy hh24:mi:ss')
        and exists
        (
            select 'x' from movisafa
            where mosfsesu = cargnuse
            and mosfcuco = cargcuco
            and mosfdeta = 'AS'
            and mosfnota = cargcodo
            and exists
            (
                select 'x' from saldfavo 
                where safacons = mosfsafa
                and safausua = 'JOBOSFDM'
                and safaprog = 'FINAN'
                and safafecr > to_Date('04092023','ddmmyyyy')
                and exists
                (
                    select 'x' from cargos
                    where cargcuco = safadocu
                    and cargnuse = safasesu
                    and cargsign = 'SA'
                    and cargvalo = 0
                )
            )
        )
    ) cantidadASErrado,
    nvl((
        select sum(cargvalo) from cargos
        where cargnuse = safasesu
        and cargcuco = safadocu
        and cargsign = 'AS'
        and cargfecr < safafecr --to_date('22/09/2023 08:45:06','dd/mm/yyyy hh24:mi:ss')
        and exists
        (
            select 'x' from movisafa
            where mosfsesu = cargnuse
            and mosfcuco = cargcuco
            and mosfdeta = 'AS'
            and mosfnota = cargcodo
            and exists
            (
                select 'x' from saldfavo 
                where safacons = mosfsafa
                and safausua = 'JOBOSFDM'
                and safaprog = 'FINAN'
                and safafecr > to_Date('04092023','ddmmyyyy')
                and exists
                (
                    select 'x' from cargos
                    where cargcuco = safadocu
                    and cargnuse = safasesu
                    and cargsign = 'SA'
                    and cargvalo = 0
                )
            )
        )
    ),0) TotalASErrado,
    (select sesususc from servsusc where sesunuse = t.sesunuse) sesususc
    from tempsusc t, saldfavo s
    where s.safasesu = t.sesunuse
    --and safasesu = 1082456
    and s.safafecr > to_Date('04092023','ddmmyyyy') --fecha inicio error 
    and s.safafecr < to_Date('12102023','ddmmyyyy') --fecha ultima gestión
    and s.safaorig = 'PA'
    ;
    
    cursor cuvalida (inucons in number,inusesu in number) is
    select 
    (
        select /*+ index ( s IX_MOVISAFA01 ) */ count(*) from movisafa s
        where mosfsafa = inucons
        and mosfsesu = inusesu
        and mosfdeta != 'PA'
        and mosfvalo < 0
    ) cantidadMovs,
    (
        select /*+ index ( c IX_CARG_NUSE_CUCO_CONC ) */ count(*) from cargos c
        where (cargcuco,cargnuse) in
        (
            select /*+ index ( s IX_MOVISAFA01 ) */ mosfcuco,mosfsesu
            from movisafa s
            where mosfsafa = inucons
            and mosfsesu = inusesu
            and mosfdeta != 'PA'
            and mosfvalo < 0
        )
        and cargsign = 'AS'
        and cargvalo = 0
    ) cantidadAscero
    from dual;
    
    rcvalida    cuvalida%rowtype;
    
    cursor cucargos (inucons in number) is
    select * from  cargos,movisafa
    where cargcuco = mosfcuco
    and cargnuse = mosfsesu
    and mosfsafa = inucons
    and mosfdeta != 'PA'
    and cargsign = 'AS'
    and mosfvalo < 0
    order by mosfcons,cargfecr;
    
    
    cursor cuvalida2 (inusafa in number,inusesu in number, inususc in number) is
    select a.*,
    (
        select sum(mosfvalo) from movisafa
        where mosfsafa in
        (
            select safacons 
            from saldfavo,servsusc 
            where safasesu = sesunuse 
            and sesususc = inususc
        ) 
    ) suscsafa,
    (
        select sum(mosfvalo) from movisafa
        where mosfsafa in
        (
            select safacons 
            from saldfavo 
            where safasesu = inusesu
        )
    ) sesusafa
    from
    (
        select mosfsafa,mosfsesu,abs(sum(mosfvalo)) mosfvalo,
        (select safavalo from saldfavo where safacons = mosfsafa) safavalo
        from movisafa m
        where mosfsafa = inusafa
        group by m.mosfsafa,mosfsesu
    ) a;
    
    rcvalida2     cuvalida2%rowtype;
    rcvalida2_act cuvalida2%rowtype;
    

    
    nucontador   number;
    nusafa       number;
    nuproducto   number;
    nuvalo       number;
    nusaldo      number;
    sbActualiza  varchar2(200);
    nucontador2  number;
    nuerr        number;
    nuajuste     number;
    
    flout        utl_file.file_type;
    sbRuta       parametr.pamechar%type;
    sblinea      varchar2(2000);
    sout         varchar2(2000);
    nuRowCount   number;
    regNotas     notas%ROWTYPE;
    nuConsDocu   number;
    rcCargo      cargos%rowtype;
    nuperiodo    number;
    
    s_out       varchar2(2000);
    s_out2      varchar2(2000);
    sbformato   varchar2(25);
    
    
    procedure procescribe(isbmensaje in varchar)
    is
    begin
        dbms_output.put_line(isbmensaje);
        Utl_file.put_line(flout,isbmensaje,TRUE);
    exception
        when others then
            dbms_output.put_line('Error en escritura de linea. '||sqlerrm);
    end procescribe;
    

    
begin
    nucontador := 0;
    nuerr := 0;
    nuajuste := 0;
    nusaldo := 0;
    sbformato := 'dd/mm/yyyy hh24:mi:ss';
    sbRuta := '/smartfiles/tmp'; 
    flout := utl_file.fopen(sbRuta, 'OSF1853_AjustaMovisafaNoAplicadoMasivo_'||to_char(cdtfecha,'yyyymmdd_hh24mi')||'.txt', 'w');
    
    
    dbms_output.enable;
    dbms_output.enable (buffer_size => null);
    
    sblinea := 'Actualiza Movisafa no aplicados. Cargvalo en cero';
    procescribe(sblinea);
    sblinea := 'sesunuse|safacons|safaorig|safadocu|safafecr|safausua|safaterm|safaprog|safavalo|mosfvalopendiente|cantidadmovs|cantidadascero|';
    sblinea := sblinea||'CantidadAS|CantidadASErrado|TotalASErrado|';
    sblinea := sblinea||'Mosfcons|mosffecr|mosfdeta|mosfnota|mosfprog|Cuenta|concepto|signo|valor|unidad|documento|Cargcodo|fechacargo|programa|causal|';
    sblinea := sblinea||'mosfvalo_ant|mosfvalo_act|sesusafa_ant|sesusafa_act|suscsafa_ant|suscsafa_act|actualiza';
    procescribe(sblinea);
    
    for rc in cudata loop
        nusafa := rc.safacons;
        nuproducto := rc.sesunuse;
        
        rcvalida := null;
        open cuvalida(nusafa,nuproducto);
        fetch cuvalida into rcvalida;
        close cuvalida;
        
        s_out := nuproducto;
        s_out := s_out||'|'||nusafa;
        s_out := s_out||'|'||rc.safaorig;
        s_out := s_out||'|'||rc.safadocu;
        s_out := s_out||'|'||to_date(rc.safafecr,sbformato);
        s_out := s_out||'|'||rc.safausua;
        s_out := s_out||'|'||rc.safaterm;
        s_out := s_out||'|'||rc.safaprog;
        s_out := s_out||'|'||rc.safavalo;
        s_out := s_out||'|'||rc.mosfvalopendiente;
        
        
        if rcvalida.cantidadascero > 0 and rc.TotalASErrado < rc.safavalo then
        
            rcvalida2 := null;
            open cuvalida2 (nusafa,nuproducto,rc.sesususc);
            fetch cuvalida2 into rcvalida2;
            close cuvalida2;
            
            s_out := s_out||'|'||rcvalida.cantidadmovs;
            s_out := s_out||'|'||rcvalida.cantidadascero;
            s_out := s_out||'|'||rc.CantidadAS;
            s_out := s_out||'|'||rc.CantidadASErrado;
            s_out := s_out||'|'||rc.TotalASErrado;
            
            nucontador2 := 0;
            
            for rccargos in cucargos(rc.safacons) loop
            
            
                s_out2 := rccargos.mosfcons;
                s_out2 := s_out2||'|'||to_char(rccargos.mosffecr,sbformato);
                s_out2 := s_out2||'|'||rccargos.mosfdeta;
                s_out2 := s_out2||'|'||rccargos.mosfnota;
                s_out2 := s_out2||'|'||rccargos.mosfprog;
                s_out2 := s_out2||'|'||rccargos.cargcuco;
                s_out2 := s_out2||'|'||rccargos.cargconc;
                s_out2 := s_out2||'|'||rccargos.cargsign;
                s_out2 := s_out2||'|'||rccargos.cargvalo;
                s_out2 := s_out2||'|'||rccargos.cargunid;
                s_out2 := s_out2||'|'||rccargos.cargdoso;
                s_out2 := s_out2||'|'||rccargos.cargcodo;
                s_out2 := s_out2||'|'||to_char(rccargos.cargfecr,sbformato);
                s_out2 := s_out2||'|'||rccargos.cargprog;
                s_out2 := s_out2||'|'||rccargos.cargcaca;
                s_out2 := s_out2||'|'||rccargos.mosfvalo;
            
                if rccargos.cargvalo = 0 then
                
                    nuvalo := 0;
                    nusaldo := nusaldo + rccargos.mosfvalo;
                    
                    update movisafa
                    set mosfvalo = nuvalo
                    where mosfcons = rccargos.mosfcons
                    ;
                    
                    nuRowcount := sql%rowcount;
                    if nuRowcount > 0 then
                        nucontador := nucontador + 1;
                        nucontador2 := nucontador2 + 1;
                        sbactualiza := 'S';
                    else 
                        sbactualiza := 'No se pudo actualizar el movimiento';
                    end if;
                    
                    if sbactualiza != 'S' then
                        exit;
                    end if;
                else
                    sbactualiza := 'No actualizado, cargvalo no actualizado';
                    nuvalo := rccargos.mosfvalo;
                    
                end if;
                
                s_out2 := s_out2||'|'||nuvalo;
                s_out2 := s_out2||'|'||rcvalida2.sesusafa;
                s_out2 := s_out2||'|'||rcvalida2.sesusafa;
                s_out2 := s_out2||'|'||rcvalida2.suscsafa;
                s_out2 := s_out2||'|'||rcvalida2.suscsafa;
                
                procescribe(s_out||'|'||s_out2||'|'||sbactualiza);
                
            end loop;
            
            --actualiza saldo a favor producto contrato
            
            s_out2 := '||||||||||||||||';
            
            rcvalida2_act := null;
            open cuvalida2 (nusafa,nuproducto,rc.sesususc);
            fetch cuvalida2 into rcvalida2_act;
            close cuvalida2;
            
            if sbactualiza != 'S' and nucontador2 = 0 then
                rollback;
                 rcvalida2_act := rcvalida2;
                goto continuar;
            end if;
            
            if rcvalida2_act.mosfsafa is null then 
                sbactualiza := 'No actualizado, movimiento no encontrado';
            else 
                update servsusc
                set sesusafa =  rcvalida2_act.sesusafa
                where sesunuse = rcvalida2_act.mosfsesu;
                
                update suscripc
                set suscsafa = rcvalida2_act.suscsafa
                where susccodi = rc.sesususc;
                
                nuRowcount := sql%rowcount;
                if nuRowcount > 0 then
                    nuajuste := nuajuste + 1;
                    sbactualiza := 'S';
                    commit;
                else 
                    sbactualiza := 'No se pudo actualizar el saldo a favor';
                    rollback;
                end if;
            end if;
            
            <<continuar>>
            s_out2 := s_out2||'|'||rcvalida2.sesusafa;
            s_out2 := s_out2||'|'||rcvalida2_act.sesusafa;
            s_out2 := s_out2||'|'||rcvalida2.suscsafa;
            s_out2 := s_out2||'|'||rcvalida2_act.suscsafa;
            procescribe(s_out||'|'||s_out2||'|'||sbactualiza);
    
        end if;
    
    end loop;
    
    procescribe('===================================');
    procescribe('Total de Movimientos actualizados '||nucontador);
    procescribe('Total de Saldos a favor ajustados '||nuajuste);
    procescribe('Total de Saldo a favor restaurado '||abs(nusaldo));
    procescribe('Total de Errores '||nuerr);
    procescribe('Rango de Ejcución ['||to_char(cdtfecha,'hh24:mi:ss')||'-'||to_char(sysdate,'hh24:mi:ss')||']');
    if utl_file.is_open( flout ) then
        utl_file.fclose( flout );
    end if;
end;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/