set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
/
DECLARE
  CURSOR cuGetactura IS
      WITH cargbase AS (
            SELECT cargos.cargconc, 
                   cargos.cargcuco, 
                   servsusc.sesuserv, 
                    servsusc.sesuplfa, 
                   MAX(cargos.cargpeco) cargpeco,
                   SUM(decode(cargos.cargsign, 'DB', cargos.cargvalo, -cargos.cargvalo)) valor_base       
            FROM OPEN.cuencobr, OPEN.cargos, OPEN.concepto, OPEN.servsusc
            WHERE cuencobr.cucofact in (2137626095,
                                        2137625756,
                                        2137625834,
                                        2137626131,
                                        2137626135,
                                        2137626224,
                                        2137626036,
                                        2137625651,
                                        2137625815,
                                        2137626081,
                                        2137626150,
                                        2137626020,
                                        2137625983,
                                        2137626192,
                                        2137626206,
                                        2137625832,
                                        2137626045,
                                        2137625976,
                                        2137625763,
                                        2137626139,
                                        2137626002,
                                        2137626035)
             AND cargos.cargcuco = cuencobr.cucocodi
             AND servsusc.sesunuse = cargos.cargnuse
             AND concepto.conccodi = cargos.cargconc
             AND concepto.concticl <> 4
             AND cargos.cargconc IN (30, 674)
            GROUP BY cargos.cargconc,  cargos.cargcuco, servsusc.sesuserv, servsusc.sesuplfa )
    SELECT cargpeco, 
           cargconc,
            DECODE(cargconc, 30, 287, 674, 137) conc_iva, valor_base,
            cargcuco,
           round(decode(cargconc, 674, 0.19, 30, 0.019) * valor_base,0) valor_iva,
           (SELECT ta_tariconc.tacocons
            FROM OPEN.ta_tariconc, OPEN.ta_conftaco
            WHERE ta_conftaco.cotcconc = CARGCONC
             AND ta_conftaco.cotccons = ta_tariconc.tacocotc
             AND sysdate BETWEEN ta_conftaco.cotcfein AND ta_conftaco.cotcfefi
             AND ta_conftaco.cotcvige = 'S'
             AND ta_conftaco.cotcserv = 7014
             AND ROWNUM < 2) cargtaco
    FROM cargbase;

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

          ut_trace.SetLevel(0);

         
      EXCEPTION
        when ex.CONTROLLED_ERROR then
          raise ex.CONTROLLED_ERROR;
        when others then
          Errors.setError;
          raise ex.CONTROLLED_ERROR;
      END ajustaCuenta;
BEGIN
   FOR reg IN cuGetactura LOOP
      dbms_output.put_line('ajustando cuenta  '||REG.CARGCUCO);
     DELETE FROM CARGOS WHERE CARGCUCO = REG.CARGCUCO AND CARGCONC = REG.CONC_IVA;
     
     INSERT INTO CARGOS
         SELECT CARGCUCO,
           CARGNUSE, 
           REG.CONC_IVA CARGCONC, 
           15 CARGCACA, 
           'DB' CARGSIGN,
           CARGPEFA,
           REG.valor_iva CARGVALO, 
           '-' CARGDOSO, 
           CARGCODO, 
           CARGUSUA,
           'A' CARGTIPR, 
           NULL CARGUNID, 
           CARGFECR,
           5 CARGPROG,
           CARGCOLL,
           CARGPECO,
           CARGTICO,
           REG.valor_base CARGVABL,
           REG.cargtaco CARGTACO
    FROM OPEN.CARGOS
    WHERE CARGCUCO = REG.CARGCUCO AND CARGCONC = REG.CARGCONC 
        AND ROWNUM < 2;

     ajustaCuenta(REG.CARGCUCO);
     commit;
   END LOOP;
   update factura set factfege = sysdate where factcodi in (2137626095,
                                                2137625756,
                                                2137625834,
                                                2137626131,
                                                2137626135,
                                                2137626224,
                                                2137626036,
                                                2137625651,
                                                2137625815,
                                                2137626081,
                                                2137626150,
                                                2137626020,
                                                2137625983,
                                                2137626192,
                                                2137626206,
                                                2137625832,
                                                2137626045,
                                                2137625976,
                                                2137625763,
                                                2137626139,
                                                2137626002,
                                                2137626035);
       commit;
      dbms_output.put_line('termino ');
exception
 when others then
   dbms_output.put_line('error '||sqlerrm);
END;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/