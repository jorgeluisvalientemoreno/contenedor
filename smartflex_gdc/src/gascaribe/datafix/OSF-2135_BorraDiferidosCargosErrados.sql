column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set linesize 1000
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
/***********************************************************
ELABORADO POR:  Juan Gabriel Catuche Giron
EMPRESA:        MVM Ingenieria de Software
FECHA:          Diciembre 2023
JIRA:           OSF-2135

Elimina diferidos, movimientos y cargos de diferidos creados por error en el DataFix OSF-1976 

    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    28/12/2023 - jcatuchemvm
    Creación
    
***********************************************************/
declare

    cdtfecha    constant date           := sysdate;
    csbformato  constant varchar2(25)   := 'dd/mm/yyyy hh24:mi:ss';
    csbCaso     constant varchar2(10)   := 'OSF-2135';
    sbtest      constant varchar2(1)    := 'N';
    
    type tyrc is record
    (
        factcodi number,
        factprog number,
        cucocodi number,
        cuconuse number
    );
    
    rcrec   tyrc;
    type tytb is table of tyrc index by varchar2(10);
    sbhash  varchar2(10);
    nuhash  number := 10;
    tbtabla tytb;
    
    cursor cudata is
    with factu as 
    (
        select substr(log,instr(log,'|',1,17)+1,(instr(log,'|',1,18)-instr(log,'|',1,17))-1) factura
        from OSF1976LOG
        where 1 = 1
        and proceso in ('OSF1976_1','OSF1976_2','OSF1976_3','OSF1976_4')
        and fecha = to_date('26/12/2023 17:11:00','dd/mm/yyyy  hh24:mi:ss')
        and substr(log,instr(log,'|',1,32)+1) = 'Realizado'
        --and consecutivo in (49805,77237)
    )
    select factcodi,factprog,cucocodi,cuconuse from factura, factu,cuencobr
    where factcodi = factu.factura
    and cucofact = factcodi
    and factprog != 701  
    
    ;
    
    cursor diferidos (inucuco in number) is
    select cargconc,difeconc,cargvalo,cargsign,cargdoso,difepldi,difeprog,difesape,difevatd,difenucu,difecupa,difefein,difecodi,cargfecr,cargpefa,
    (select pefacicl from perifact where pefacodi = cargpefa) pefacicl,
    (select suscclie from suscripc,servsusc where sesunuse = cargnuse and sesususc  = susccodi) idcliente,
    cargos.rowid row_id,diferido.rowid row_iddif
    from cargos,diferido
    where cargcuco = inucuco
    and cargprog = 700
    and cargusua = 1
    and cargdoso like 'FD-%'
    and cargfecr between to_date('26122023 171106','ddmmyyyy hh24miss') and to_date('27122023 121817','ddmmyyyy hh24miss')
    and difecodi = substr(cargdoso,4)
    and difenudo like 'RF%'
    and difepldi = 57
    and difeprog = 'FINAN'
    and difefunc = 1
    and cargusua  = 1
    and cargprog = 700
    order by cargfecr desc;
    
    raise_continuar exception;
    sbcomentario    varchar2(2000);
    s_out           varchar2(2000);
    nucont          number;
    nucont2         number;
    nucont3         number;
    nuerr           number;
    nuRowCount      number;
    sbcabecera      varchar2(2000);
    nusecuencia     number;
    nuerror         number;
    sberror         varchar2(2000);
    
    --Ajusta Cuenta Isabel Becerra 
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
    when pkg_error.CONTROLLED_ERROR then
      raise pkg_error.CONTROLLED_ERROR;
    when others then
      pkg_error.setError;
      raise pkg_error.CONTROLLED_ERROR;
    END ajustaCuenta;
    
    procedure procescribe(isbmensaje in varchar)
    is
        PRAGMA AUTONOMOUS_TRANSACTION;
    begin
        
        if sbtest = 'S' then
            dbms_output.put_line(isbmensaje);
        else
            nusecuencia := nusecuencia + 1;
            insert into OSF1976LOG
            values(csbCaso,to_char(cdtfecha,'dd/mm/yyyy hh24:mi'),nusecuencia,isbmensaje);
            commit;
        end if;
        
    exception
        when others then
            dbms_output.put_line('Error en escritura de linea. '||sqlerrm);
    end procescribe;
    
begin
    nucont  := 0;
    nucont2 := 0;
    nucont3 := 0;
    nuerr   := 0;
    nusecuencia := 0;
    
    sbcabecera := 'Factura|Factprog|Cuenta|Producto|Cargconc|difeconc|Cargvalo|difevatd|difesape|Cargdoso|Difecodi|Difecupa|Difenucu|Difefein|cargfecr|carpefa|Ciclo|Cliente|rowidC|rowidD|Comentario|Error';
    procescribe(sbcabecera);
    
    for rc in cudata loop
        sbhash := lpad(rc.cucocodi,nuhash,'0');
        if not tbtabla.exists(sbhash) then
            tbtabla(sbhash).factcodi := rc.factcodi;
            tbtabla(sbhash).factprog := rc.factprog;
            tbtabla(sbhash).cucocodi := rc.cucocodi;
            tbtabla(sbhash).cuconuse := rc.cuconuse;
            nucont := nucont + 1;            
        end if;
    end loop;
    
    sbhash := tbtabla.first;
    if sbhash is null then
        sbcomentario := 'No existen cuentas para procesar';
        raise raise_continuar;
    end if;
    
    loop
        
        rcrec := tbtabla(sbhash);
    
        for rf in diferidos(rcrec.cucocodi) loop
            
            if rf.difecupa > 0 or rf.difesape = 0 then
                sbcomentario := 'Diferido errado ya fue pagado';
            else
                --Borra movimiento, diferidos y cargo
                begin
                    delete movidife
                    where modidife = rf.difecodi;
                    
                    delete diferido d
                    where d.rowid = rf.row_iddif
                    and d.difecodi = rf.difecodi;
                    
                    nuRowcount := sql%rowcount;
                    if nuRowcount > 0 then
                        nucont2 := nucont2 + 1;
                    end if;
                    
                    delete cargos c
                    where c.rowid = rf.row_id
                    and cargdoso = 'FD-'||rf.difecodi
                    ;
                    
                    nuRowcount := sql%rowcount;
                    if nuRowcount > 0 then
                        nucont3 := nucont3 + 1;
                        commit;
                        sbcomentario := 'Gestionado|ok';
                        
                        --Ajusta cuenta 
                        ajustaCuenta(rcrec.cucocodi);
                        commit;
                    else
                        sbcomentario := 'No fue posible ajustar el diferido|Err';
                        nuerr := nuerr + 1;
                        rollback;
                    end if;
                    
                exception
                    when pkg_error.CONTROLLED_ERROR then
                        nuerr := nuerr + 1;
                        pkg_error.geterror(nuerror,sberror);
                        sbcomentario := 'Error controlado en gestión del diferido|'||sberror;
                        rollback;
                        
                    when others then
                        nuerr := nuerr + 1;
                        pkg_error.seterror;
                        pkg_error.geterror(nuerror,sberror);
                        sbcomentario := 'Error desconocido en gestión del diferido|'||sberror;
                        rollback;
                end;
                
            end if;
            
            
            s_out := rcrec.factcodi;
            s_out := s_out||'|'||rcrec.factprog;
            s_out := s_out||'|'||rcrec.cucocodi;
            s_out := s_out||'|'||rcrec.cuconuse;
            s_out := s_out||'|'||rf.cargconc;
            s_out := s_out||'|'||rf.difeconc;
            s_out := s_out||'|'||rf.cargvalo;
            s_out := s_out||'|'||rf.difevatd;
            s_out := s_out||'|'||rf.difesape;
            s_out := s_out||'|'||rf.cargdoso;
            s_out := s_out||'|'||rf.difecodi;
            s_out := s_out||'|'||rf.difecupa;
            s_out := s_out||'|'||rf.difenucu;
            s_out := s_out||'|'||to_char(rf.difefein,csbformato);
            s_out := s_out||'|'||to_char(rf.cargfecr,csbformato);
            s_out := s_out||'|'||rf.cargpefa;
            s_out := s_out||'|'||rf.pefacicl;
            s_out := s_out||'|'||rf.idcliente;
            s_out := s_out||'|'||rf.row_id;
            s_out := s_out||'|'||rf.row_iddif;
            s_out := s_out||'|'||sbcomentario;
            
            procescribe(s_out);
            
        end loop;
        
        sbhash := tbtabla.next(sbhash);
        if sbhash is null then exit; end if;
        
    end loop;
    
    procescribe('==================');
    procescribe('Cantidad de cuentas afectadas: '||nucont);
    procescribe('Cantidad de diferidos eliminadas: '||nucont2);
    procescribe('Cantidad de cargos eliminados: '||nucont3);
    procescribe('Cantidad de errores encontrados: '||nuerr);
    
exception
    when raise_continuar then
        procescribe(sbcomentario);
        rollback;
end;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/

