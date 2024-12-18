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
JIRA:           OSF-1826

Ajusta movimientos de saldo a favor que no se aplicaron
    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    OSF1826_AjustaMovisafaNoAplicado_yyyymmdd_hh24mi.txt
    
    --Modificaciones    
    
    25/10/2023 - jcatuchemvm
    Creación
    
***********************************************************/
declare

    csbTitulo   constant varchar2(200) := 'NOTA POR CORRECCIÓN SA ERRADO OSF-1646';
    cdtfecha    constant date := sysdate;
    cursor cudata is
    select mosfsesu,mosfcons,mosfsafa,mosffecr,mosfvalo,mosfprog,mosfcuco,mosfnota,mosfdeta,
    (select sum(cargvalo) from cargos where cargnuse = mosfsesu and cargcuco = mosfcuco and cargsign = 'AS') cargvalo,
    (select sum(cargunid) from cargos where cargnuse = mosfsesu and cargcuco = mosfcuco and cargsign = 'AS') cargunid,
    (select count(cargunid) from cargos where cargnuse = mosfsesu and cargcuco = mosfcuco and cargsign = 'AS') cantidad,
    (select mosfsafa from movisafa a where a.mosfsesu = m.mosfsesu and a.mosfcuco = m.mosfcuco and a.mosfsafa != m.mosfsafa and rownum = 1) mosfsafa_dif,
    (select count(mosfsafa) from movisafa a where a.mosfsesu = m.mosfsesu and a.mosfcuco = m.mosfcuco and a.mosfsafa != m.mosfsafa) cantidad_dif
    from movisafa m
    where mosfsesu = 17110490
    and mosfsafa between 2186412 and 2186412
    and mosfvalo < 0
    order by mosfcons;
    
    cursor cuvalida (inusafa in number) is
    select a.*,
    (select suscsafa from suscripc,servsusc where susccodi = sesususc and sesunuse = mosfsesu) suscsafa,
    (select sesusafa from servsusc where sesunuse = mosfsesu) sesusafa,
    (select sesususc from servsusc where sesunuse = mosfsesu) sesususc
    from
    (
        select mosfsafa,mosfsesu,abs(sum(mosfvalo)) mosfvalo,
        (select safavalo from saldfavo where safacons = mosfsafa) safavalo
        from movisafa m
        where mosfsafa = inusafa
        group by m.mosfsafa,mosfsesu
    ) a;
    
    rcvalida     cuvalida%rowtype;
    rcvalida_act cuvalida%rowtype;
    
    cursor cuCuenta (inusesu in number) is 
    select * from 
    (
        select cucocodi,cuconuse,cucosacu,
        (select factprog from factura where factcodi = cucofact) factprog,
        cucofact,
        (select sesususc from servsusc where sesunuse = cuconuse) sesususc,
        (
            select  /*+ index ( c IX_CARG_NUSE_CUCO_CONC ) */
            first_value (cargconc) over (order by cargvalo desc) from cargos c2
            where cargcuco =  cucocodi
            and cargnuse = cuconuse
            and cargdoso not like 'DF-' and cargdoso not like 'ID-%'
            and cargprog = 5
            and cargsign = 'DB'
            and rownum = 1
        ) concepto
        from cuencobr
        where cuconuse = inusesu
        order by cucocodi desc
    ) a
    where a.factprog = 6
    ;
    
    rcCuenta       cuCuenta%rowtype;
    
    /*type tyrcMovs is record
    (
        mosfcons    movisafa.mosfcons%type,
        mosfvalo    movisafa.mosfvalo%type,
    );
    type tytbMovs is table of tyrcMovs index by binary_integer;  */
    
    
    nucontador   number;
    nusafa       number;
    nuproducto   number;
    nuvalo       number;
    sbActualiza  varchar2(2);
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
    
    
    
    
    procedure procescribe(isbmensaje in varchar)
    is
    begin
        dbms_output.put_line(isbmensaje);
        Utl_file.put_line(flout,isbmensaje,TRUE);
    exception
        when others then
            dbms_output.put_line('Error en escritura de linea. '||sqlerrm);
    end procescribe;
    
    PROCEDURE ajustaCuenta(inucuenta in cuencobr.cucocodi%type) is

    nuError NUMBER;
    sbError VARCHAR2(2000);
    nuIndex number;

    rcCargos       cargos%ROWTYPE := NULL;
    varcucovato    cuencobr.cucovato%type;
    varCUCOVAAB    cuencobr.cucovaab%type;
    varcucovafa    cuencobr.cucovafa%type;
    varcucoimfa    cuencobr.cucoimfa%type;
    inuConcSaFa    cargos.cargconc%type default NULL;
    inuSalFav      pkBCCuencobr.styCucosafa Default pkBillConst.CERO;
    isbTipoProceso cargos.cargtipr%type Default pkBillConst.POST_FACTURACION;
    idtFechaCargo  cargos.cargfecr%type Default sysdate;

    CURSOR cuDatos(inuCucocodi in cuencobr.cucocodi%type) IS
      SELECT cargos.cargcuco CUENTA,
             cargos.cargnuse PRODUCTO,
             NVL(SUM(DECODE(cargsign,
                            'DB',
                            (cargvalo),
                            'CR',
                            - (cargvalo),
                            0)),
                 0) cucovato,
             NVL(SUM(DECODE(cargsign,
                            'PA',
                            cargvalo,
                            'AS',
                            cargvalo,
                            'SA',
                            -cargvalo,
                            0)),
                 0) cucovaab,
             NVL(SUM(DECODE(cargtipr,
                            'P',
                            0,
                            DECODE(INSTR('DF-CX-',
                                         LPAD(SUBSTR(cargdoso, 1, 3), 3, ' ')),
                                   0,
                                   DECODE(cargsign,
                                          'DB',
                                          (cargvalo),
                                          'CR',
                                          - (cargvalo),
                                          0),
                                   0))),
                 0) cucovafa,
             NVL(SUM(DECODE(cargtipr,
                            'P',
                            0,
                            DECODE(INSTR('DF-CX-',
                                         LPAD(SUBSTR(cargdoso, 1, 3), 3, ' ')),
                                   0,
                                   CASE
                                     WHEN concticl = pkBillConst.fnuObtTipoImp THEN
                                      DECODE(cargsign, 'DB', cargvalo, 'CR', -cargvalo, 0)
                                     ELSE
                                      0
                                   END,
                                   0))),
                 0) cucoimfa,
             NVL(SUM(DECODE(SIGN(cargvalo), -1, 1, 0)), 0) cucocane
        FROM cargos, concepto
       WHERE cargcuco = inuCucocodi
         AND cargconc = conccodi
         AND cargsign IN ('DB', 'CR', -- Facturado
              'PA', -- Pagos
              'RD', 'RC', 'AD', 'AC', -- Reclamos
              'AS', 'SA', 'ST', 'TS' -- Saldo favor
             )
       GROUP BY cargos.cargcuco, cargos.cargnuse;

    v_datos cuDatos%rowtype;

    BEGIN

    pkerrors.setapplication(CC_BOConstants.csbCUSTOMERCARE);

    open cuDatos(inucuenta);
    fetch cuDatos
      into v_datos;
    close cuDatos;

    SELECT CUENCOBR.cucovato,
           CUENCOBR.CUCOVAAB,
           CUENCOBR.cucovafa,
           CUENCOBR.cucoimfa
      INTO varcucovato, varCUCOVAAB, varcucovafa, varcucoimfa
      FROM CUENCOBR
     WHERE CUCOCODI = v_datos.CUENTA;

    if (v_datos.cucovato != varcucovato OR v_datos.cucovaab != varCUCOVAAB OR
       v_datos.cucoimfa != varcucoimfa) then

      ut_trace.SetOutPut(ut_trace.cnuTRACE_OUTPUT_DB);
      ut_trace.SetLevel(2);

      ut_trace.trace('SDFGHKL Seguros cucocodi: ' || v_datos.CUENTA, 1);

      ut_trace.trace('Cuenta: ' || inucuenta || ' cucovato ' ||
                     v_datos.cucovato || '/' || varcucovato ||
                     ' - Cucovaab ' || v_datos.cucovaab || '/' ||
                     varCUCOVAAB,
                     2);

      UPDATE cuencobr
         SET cucovato = NVL(v_datos.cucovato, 0),
             cucovaab = NVL(v_datos.cucovaab, 0),
             cucovafa = NVL(v_datos.cucovafa, 0),
             cucoimfa = NVL(v_datos.cucoimfa, 0)
       WHERE cucocodi = v_datos.CUENTA;

      ut_trace.trace('Despues updateCuenta: ' || v_datos.CUENTA || ' - ' ||
                     pktblcuencobr.fnugetcucovato(v_datos.CUENTA, 0) ||
                     ' - ' ||
                     pktblcuencobr.fnugetcucovaab(v_datos.CUENTA, 0),
                     2);

      pkAccountMgr.AdjustAccount(v_datos.CUENTA,
                                 v_datos.PRODUCTO,
                                 47,
                                 1,
                                 rcCargos.cargsign,
                                 rcCargos.cargvalo);

      ut_trace.trace('Despues ajuste Cuenta: ' || v_datos.CUENTA || ' - ' ||
                     pktblcuencobr.fnugetcucovato(v_datos.CUENTA, 0) ||
                     ' - ' ||
                     pktblcuencobr.fnugetcucovaab(v_datos.CUENTA, 0),
                     2);


    END if;

    EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
    END ajustaCuenta;
    
begin
    nucontador := 0;
    nuerr := 0;
    nuajuste := 0;
    
    
    sbRuta := '/smartfiles/tmp'; 
    flout := utl_file.fopen(sbRuta, 'OSF1826_AjustaMovisafaNoAplicado_'||to_char(cdtfecha,'yyyymmdd_hh24mi')||'.txt', 'w');
    
    
    dbms_output.enable;
    dbms_output.enable (buffer_size => null);
    
    sblinea := 'Acualiza Movisafa a cero no apicado. Cargvalo en cero';
    procescribe(sblinea);
    sblinea := 'Producto|Mosfcons|Mosfsafa|Mosfprog|Mosfcuco|Mosfnota|Cargvalo|Mosfvalo_ant|Masfvalo_act|actualiza';
    procescribe(sblinea);
    
    
    nusafa := 2186412;
    nuproducto := 17110490;
    
    rcvalida := null;
    open cuvalida (nusafa);
    fetch cuvalida into rcvalida;
    close cuvalida;
    
    for rc in cudata loop
        
        begin
            nucontador := nucontador + 1;
            
            if rc.cargvalo = 0  then --Dado que no hay cargo, se actualiza a cero el movimiento
            
                nuvalo := 0;
            
                update movisafa
                set mosfvalo = 0
                where mosfcons = rc.mosfcons;
                
                nuRowcount := sql%rowcount;
                if nuRowcount > 0 then
                    sbactualiza := 'S';
                    commit;
                else 
                    sbactualiza := 'N';
                end if;
                
            else
            
                sbactualiza := 'N';
                nuvalo := rc.mosfvalo;
                
            end if;
                
            sout := rc.mosfsesu;
            sout := sout||'|'||rc.mosfcons;
            sout := sout||'|'||rc.mosfsafa;
            sout := sout||'|'||rc.mosfprog;
            sout := sout||'|'||rc.mosfcuco;
            sout := sout||'|'||rc.mosfnota;
            sout := sout||'|'||rc.cargvalo;
            sout := sout||'|'||rc.mosfvalo;
            sout := sout||'|'||nuvalo;
            sout := sout||'|'||sbactualiza;
            
            procescribe(sout);
                
                
        exception
            when others then
                sblinea := 'Error en actualización de movisafa|'||rc.mosfcons||'|'||sqlerrm;
                procescribe(sblinea);
                nuerr := nuerr + 1;
                rollback;
                exit;
        end;  
        
    end loop;
    
    --Creación nota 
    rcCuenta := null;
    open cuCuenta (nuproducto);
    fetch cuCuenta into rcCuenta;
    close cuCuenta; 
    
    nuConsDocu := null;
    regNotas  := null;
    rcCargo := null;
    PKBILLINGNOTEMGR.GETNEWNOTENUMBER(nuConsDocu);
    nuperiodo := PKTBLFACTURA.FNUGETFACTPEFA(rcCuenta.cucofact, null);
    
    regNotas.NOTANUME := nuConsDocu ;
    regNotas.NOTASUSC := rcCuenta.sesususc;
    regNotas.NOTAFACT := rcCuenta.cucofact;
    regNotas.NOTATINO := 'R'; 
    regNotas.NOTAFECO := trunc(sysdate);
    regNotas.NOTAFECR := sysdate; 
    regNotas.NOTAPROG := 700;
    regNotas.NOTAUSUA := 1 ;
    regNotas.NOTATERM := NVL(userenv('TERMINAL'),'DESCO');
    regNotas.NOTACONS := 70;
    regNotas.NOTANUFI := NULL;
    regNotas.NOTAPREF := NULL;
    regNotas.NOTACONF := NULL;
    regNotas.NOTAIDPR := NULL;
    regNotas.NOTACOAE := NULL;
    regNotas.NOTAFEEC := NULL;
    regNotas.NOTAOBSE := 'Nota por ajuste de Saldos a favor errados OSF-1646'; 
    regNotas.NOTADOCU := NULL ;
    regNotas.NOTADOSO := 'ND-' ||nuConsDocu;
        
    PKTBLNOTAS.INSRECORD(regNotas);
    
    
    
    --creación nota CR            
    rcCargo.cargnuse := rcCuenta.cuconuse ;
    rcCargo.cargcuco := rcCuenta.cucocodi;
    rcCargo.cargpefa := nuperiodo;
    rcCargo.cargconc := rcCuenta.concepto; --Ref Edmuno Lara
    rcCargo.cargcaca := 4;   --Ref Edmunod Lara
    rcCargo.cargsign := 'DB' ;
    rcCargo.cargvalo := 35902;
    rcCargo.cargdoso := 'ND-'||nuConsDocu;
    rcCargo.cargtipr :=  'P';
    rcCargo.cargfecr := sysdate; ---Fecha
    rcCargo.cargcodo := nuConsDocu; --  DEBE SER  numero de la nota
    rcCargo.cargunid := 0;
    rcCargo.cargcoll := null ;
    rcCargo.cargprog := 700; 
    rcCargo.cargusua := 1;
    
    pktblCargos.InsRecord (rcCargo);
    
    ajustaCuenta(rcCuenta.cucocodi);
    
    rcvalida := null;
    open cuvalida (nusafa);
    fetch cuvalida into rcvalida;
    close cuvalida;
    
    if rcvalida.mosfsafa is null then 
        sbactualiza := 'N';
    else 
        update servsusc
        set sesusafa = nvl(sesusafa,0)+rcvalida.mosfvalo
        where sesunuse = rcvalida.mosfsesu;
        
        update suscripc
        set suscsafa = nvl(suscsafa,0)+rcvalida.mosfvalo
        where susccodi = rcvalida.sesususc;
        
        commit;
        sbactualiza := 'S';
    end if;
    
    rcvalida_act := null;
    open cuvalida (nusafa);
    fetch cuvalida into rcvalida_act;
    close cuvalida;
    
   
    procescribe('===================================');    
    sblinea := 'Nota|Contrato|Producto|Cuenta|Concepto|Valor|Signo';
    procescribe(sblinea);
    
    sout := nuConsDocu;
    sout := sout||'|'||rcCuenta.sesususc;                
    sout := sout||'|'||rcCuenta.cuconuse;
    sout := sout||'|'||rcCuenta.cucocodi;
    sout := sout||'|'||rcCuenta.concepto;
    sout := sout||'|'||35902;
    sout := sout||'|'||'DB';
    
    procescribe(sout);
    
    procescribe('===================================');    
    sblinea := 'Producto|Contrato|mosfsafa|safavalo|mosfvalo_ant|mosfvalo_act|sesusafa_ant|sesusafa_act|suscsafa_ant|suscsafa_Act|actualiza';
    procescribe(sblinea);
    
    sout := rcvalida.mosfsesu;
    sout := sout||'|'||rcvalida.sesususc;                
    sout := sout||'|'||rcvalida.mosfsafa;
    sout := sout||'|'||rcvalida.safavalo;
    sout := sout||'|'||rcvalida.mosfvalo;
    sout := sout||'|'||rcvalida_act.mosfvalo;
    sout := sout||'|'||rcvalida.sesusafa;
    sout := sout||'|'||rcvalida_act.sesusafa;
    sout := sout||'|'||rcvalida.suscsafa;
    sout := sout||'|'||rcvalida_act.suscsafa;
    sout := sout||'|'||sbactualiza;
    
    procescribe(sout);
    
    
    procescribe('===================================');
    procescribe('Total de Movimientos. '||nucontador);
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