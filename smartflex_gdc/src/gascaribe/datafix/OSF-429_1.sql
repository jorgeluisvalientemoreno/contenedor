set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
/
DECLARE
  nuerror NUMBER;
  sberror  VARCHAR2(4000);
 
 CURSOR cugetCuentas IS
  SELECT distinct d.DPTTCUCO cuenta , d.DPTTSESU  producto, DPTTFACT factura
  FROM OPEN.LDC_DEPRTATT d, OPEN.FACTURA
  WHERE DPTTPERI = DPTTPERI
   AND FACTPEFA = 100321
   AND DPTTFACT = FACTCODI ;
   
     
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
         AND cargsign IN ('DB',
                          'CR', -- Facturado
                          'PA', -- Pagos
                          'RD',
                          'RC',
                          'AD',
                          'AC', -- Reclamos
                          'AS',
                          'SA',
                          'ST',
                          'TS' -- Saldo favor
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
  
    -- if (v_datos.cucovato != varcucovato OR v_datos.cucovaab != varCUCOVAAB OR  v_datos.cucoimfa != varcucoimfa) then
  
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
  
    pkAccountMgr.GenPositiveBal(v_datos.CUENTA,
                                inuConcSaFa,
                                inuSalFav,
                                isbTipoProceso,
                                idtFechaCargo);
  
    ut_trace.trace('Despues GenPosBal Cuenta: ' || v_datos.CUENTA || ' - ' ||
                   pktblcuencobr.fnugetcucovato(v_datos.CUENTA, 0) ||
                   ' - ' ||
                   pktblcuencobr.fnugetcucovaab(v_datos.CUENTA, 0),
                   2);
  
    ut_trace.SetLevel(0);
  
    -- pkAccountMgr.ApplyPositiveBalServ(v_datos.PRODUCTO);
  
    -- END if;
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
  END ajustaCuenta;
  
BEGIN
  
  --reversion de transitorias
  FOR reg IN cugetCuentas LOOP
     DELETE FROM open.cargos
     WHERE cargcuco = reg.cuenta and cargcaca in (59,63)
      and cargconc in (130, 167, 11);
      
     DELETE  FROM open.RANGLIQU
    WHERE RALISESU = REG.producto
      AND RALIPEFA   = 100321
      AND RALICONC   = 31
      AND RALIUNLI   > 0
      and not exists (select 1
                      from open.cargos
                      where cargcodo = RALICODO
                        and cargnuse = RALISESU
                        AND CARGPEFA = 100321
                        and cargconc = 31);
     
     DELETE  FROM LDC_DEPRTATT  WHERE DPTTFACT = reg.factura ;
     

     ajustaCuenta(reg.cuenta);
     
     commit;
     
  END LOOP;
  
  UPDATE LDC_PEFAGEPTT SET PEGPESTA = 'N'
  WHERE PEGPPROC   = 'FGCC'
    AND PEGPPERI = 100321;
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ERRORS.SETERROR;
    ERRORS.GETERROR(nuerror, sberror);
    DBMS_OUTPUT.PUT_LINE(sberror);
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/