DECLARE
    nuNote          NUMBER (10);
    onuCodError     NUMBER;
    osbMensError    VARCHAR2(4000);

  CURSOR c_escenario1 IS 
        select ca.cargcuco , ca.cargvalo, ca.cargfecr
        from cargos  ca, SERVSUSC ss, CAUSCARG cc, concepto co, ic_clascont icc, procesos pr, cuencobr cbr
        where    ca.cargnuse = ss.sesunuse
        and ca.cargcaca = cc.cacacodi
        and ca.cargconc = co.conccodi
        and co.concclco = icc.clcocodi
        and ca.cargprog = pr.proccons
        and ca.cargcuco = cbr.cucocodi
        and ca.cargfecr BETWEEN to_date(to_char('01/07/2023' || ' 00:00:00') , 'dd-mm-yyyy hh24:mi:ss')
                        AND to_date(to_char('31/07/2023' || ' 23:59:59') , 'dd-mm-yyyy hh24:mi:ss') 
        and ca.cargprog = 20
        and ca.cargcodo = 0
        and ca.cargsign = 'SA'
        order by ca.cargfecr desc
        ;

v_cargcodo number;

BEGIN
  DBMS_OUTPUT.PUT_LINE ('Inicia OSF-1385 para Julio 2023 Diferencias SA Notas');

  BEGIN                                                          -- bloque 1
  DBMS_OUTPUT.PUT_LINE ('Inicia Escenario 1..............');
  -- Para cada registo
  FOR v_escenario1 IN c_escenario1
    LOOP
      --selecciona el cargcodo del cargo CR
      select cargcodo INTO v_cargcodo from cargos where cargsign = 'CR' and  (cargvalo = (v_escenario1.cargvalo*2) or 
      cargvalo = v_escenario1.cargvalo or TRUNC(cargfecr) = TRUNC(v_escenario1.cargfecr) ) and cargcuco = v_escenario1.cargcuco and cargprog = 20 AND ROWNUM=1;
      dbms_output.put_line('Cargcuco: ' || v_escenario1.cargcuco || '-'  ||'cargcodo: ' || v_cargcodo || '-'  || 'ca.cargfecr:' || v_escenario1.cargfecr);

      --modifica el cargo del SA
      update cargos 
      set cargcodo  = v_cargcodo
      where cargsign = 'SA' and cargfecr = v_escenario1.cargfecr and cargcuco = v_escenario1.cargcuco and cargcodo = 0 
      and cargprog = 20 and cargdoso = 'CTN-'||v_escenario1.cargcuco and cargusua= 5607;
    --  commit;
   
      --dbms_output.put_line('Luego update ' );
      END LOOP;
     DBMS_OUTPUT.PUT_LINE ('..............Finaliza Escenario 1');
    EXCEPTION
        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
        pkerrors.geterrorvar(onuCodError, osbMensError);
        dbms_output.put_line('ERROR CONTR' || osbMensError);
        when others then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, osbMensError);
        pkerrors.geterrorvar(onuCodError, osbMensError);
        dbms_output.put_line('ERROR NCONT|' || osbMensError );
        DBMS_OUTPUT.PUT_LINE ('Termina OSF-1274 escenario 1');
    END;
END;
/