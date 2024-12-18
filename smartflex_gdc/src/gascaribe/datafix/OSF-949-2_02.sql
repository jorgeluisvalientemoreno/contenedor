DECLARE
    nuNote          NUMBER (10);
    onuCodError     NUMBER;
    osbMensError    VARCHAR2(4000);

  CURSOR c_escenario1 IS 
        select ca.cargcuco , ca.cargvalo, ca.cargfecr
        from cargos  ca, open.SERVSUSC ss, CAUSCARG cc, concepto co, ic_clascont icc, procesos pr, cuencobr cbr
        where    ca.cargnuse = ss.sesunuse
        and ca.cargcaca = cc.cacacodi
        and ca.cargconc = co.conccodi
        and co.concclco = icc.clcocodi
        and ca.cargprog = pr.proccons
        and ca.cargcuco = cbr.cucocodi
        and ca.cargfecr BETWEEN to_date(to_char('01/05/2023' || ' 00:00:00') , 'dd-mm-yyyy hh24:mi:ss')
                        AND to_date(to_char('31/05/2023' || ' 23:59:59') , 'dd-mm-yyyy hh24:mi:ss') 
        and ca.cargprog = 20
        and ca.cargcodo = 0
        and ca.cargsign = 'SA'
        order by ca.cargfecr desc
        ;


  CURSOR c_escenario2 IS 
        select ca.cargcuco, ca.cargfecr
        from cargos ca, notas no , open.SERVSUSC ss, CAUSCARG cc, concepto co, ic_clascont icc, procesos pr, cuencobr cbr
        where    ca.cargnuse = ss.sesunuse
        and ca.cargcaca = cc.cacacodi
        and ca.cargconc = co.conccodi
        and co.concclco = icc.clcocodi
        and ca.cargprog = pr.proccons
        and ca.cargcodo = no.notanume
        and ca.cargcuco = cbr.cucocodi
        and ca.cargfecr BETWEEN to_date(to_char('01/05/2023' || ' 00:00:00') , 'dd-mm-yyyy hh24:mi:ss')
                       AND to_date(to_char('31/05/2023' || ' 23:59:59') , 'dd-mm-yyyy hh24:mi:ss')
        and ca.cargprog = 701
        and ca.cargsign = 'SA'
        and ca.cargprog <> no.notaprog
        order by cargcuco asc
        ;


v_cargcodo number;

BEGIN
  DBMS_OUTPUT.PUT_LINE ('Inicia OSF-949: para Mayo 2023 Diferencias SA Notas');

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
      commit;
   
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
        DBMS_OUTPUT.PUT_LINE ('Termina OSF-949 escenario 1');
    END;


BEGIN                                                          -- bloque 2
   DBMS_OUTPUT.PUT_LINE ('Inicia Escenario 2..............');     
  -- Para cada registo
  FOR v_escenario2 IN c_escenario2
    LOOP
      dbms_output.put_line('Cargcuco: ' || v_escenario2.cargcuco  || '-'  || 'ca.cargfecr:' || v_escenario2.cargfecr);
      -- Update a cargcodo
      UPDATE cargos
         SET cargprog = 700
      WHERE cargcuco = v_escenario2.cargcuco AND cargprog = 701 AND cargcaca = 53 and cargsign = 'SA' and cargusua= 5922 and cargdoso = 'CTN-'||cargcuco
        and   cargfecr = v_escenario2.cargfecr;
      commit;
    
    END LOOP;

     DBMS_OUTPUT.PUT_LINE ('..............Finaliza Escenario 2');
     
    EXCEPTION
        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
        pkerrors.geterrorvar(onuCodError, osbMensError);
        dbms_output.put_line('ERROR CONTR' || osbMensError);
        when others then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, osbMensError);
        pkerrors.geterrorvar(onuCodError, osbMensError);
        dbms_output.put_line('ERROR NCONT|' || osbMensError );
        DBMS_OUTPUT.PUT_LINE ('Termina OSF-949  escenario 2');
    END;

END;
/

SELECT TO_CHAR (SYSDATE, 'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin FROM DUAL;

SET SERVEROUTPUT OFF
QUIT
/