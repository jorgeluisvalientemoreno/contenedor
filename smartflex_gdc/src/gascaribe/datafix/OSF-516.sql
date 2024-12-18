set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
    nuErrorCode NUMBER;
    sbErrorMessage VARCHAR2(4000);
   CURSOR cuCuentas IS
   SELECT *
      FROM cuencobr
     WHERE cucosacu <0
     AND cucocodi in (3021064006,3021064005) ;
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

          ut_trace.trace('Despues GenPosBal Cuenta: ' || v_datos.CUENTA ||
                         ' - ' ||
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

    FOR rc in cuCuentas LOOP
        dbms_output.put_Line('CUENTA:'||rc.cucocodi);
        ajustaCuenta(rc.cucocodi);
        COMMIT;
    END LOOP;


    dbms_output.put_line('SALIDA onuErrorCode: '||nuErrorCode);
    dbms_output.put_line('SALIDA osbErrorMess: '||sbErrorMessage);


EXCEPTION
    when ex.CONTROLLED_ERROR  then
        Errors.getError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('ERROR CONTROLLED ');
        dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);

    when OTHERS then
        Errors.setError;
        Errors.getError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('ERROR OTHERS ');
        dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
        dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);
END;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/