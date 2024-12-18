DECLARE
    nuNote          NUMBER (10);
    onuCodError     NUMBER;
    osbMensError    VARCHAR2(4000);
    nuCargNuse      cargos.cargnuse%type;

  CURSOR c_escenario1 IS 
        select cargcuco,trunc(cargfecr) as cargfecr from cargos, servsusc where      
        cargnuse=sesunuse 
        and cargcaca=20 and cargsign='DB' 
        and cargusua=5673 and cargtipr='P' 
        and cargprog=20
        and trunc(cargfecr) BETWEEN to_date(to_char('01/05/2023' || ' 00:00:00') , 'dd-mm-yyyy hh24:mi:ss')
                                AND to_date(to_char('28/05/2023' || ' 23:59:59') , 'dd-mm-yyyy hh24:mi:ss')
        group by cargcuco,trunc(cargfecr);
   cursor c_nuse (nuCargcuco cargos.cargcuco%type) is
        select distinct(cargnuse) from cargos where
        cargcuco= nuCargcuco 
        and cargcaca=20 and cargsign='DB' 
        and cargusua=5673 and cargtipr='P' 
        and cargprog=20
        and trunc(cargfecr) BETWEEN to_date(to_char('01/05/2023' || ' 00:00:00') , 'dd-mm-yyyy hh24:mi:ss')
                                AND to_date(to_char('28/05/2023' || ' 23:59:59') , 'dd-mm-yyyy hh24:mi:ss') ; 
        
BEGIN
  DBMS_OUTPUT.PUT_LINE ('Inicia OSF-949 para Mayo 2023 Diferencias Notas');

  BEGIN                                                          -- bloque 1
  DBMS_OUTPUT.PUT_LINE ('Inicia Escenario..............');
  -- Para cada registo
  FOR v_escenario1 IN c_escenario1
    LOOP
    --obtiene el numero de servicio
        open c_nuse(v_escenario1.cargcuco);
        fetch c_nuse into nuCargNuse;
        close c_nuse;
    --  Crea la nota debito
        pkErrors.SetApplication('FRNF');
        pkBillingNoteMgr.CreateBillingNote (
            nuCargNuse,
            v_escenario1.cargcuco,
            GE_BOConstants.fnuGetDocTypeDebNote,
            TO_DATE (v_escenario1.cargfecr, 'dd/mm/yyyy hh24:mi:ss'),
            'NOTA GENERADA POR ERROR HECHOS ECONOMICOS MAYO 2023 - OSFF-949',
            pkBillConst.csbTOKEN_NOTA_DEBITO,
            nuNote);
        -- se actualizan el cargcodo para que haga referencia a la nota
        UPDATE cargos
           SET cargcodo = nuNote
         WHERE cargcuco=v_escenario1.cargcuco and cargcaca=20 and cargsign='DB' 
        and cargusua=5673 and cargtipr='P' 
        and cargprog=20;
        commit;
      END LOOP;
     DBMS_OUTPUT.PUT_LINE ('..............Finaliza Escenario');
    EXCEPTION
        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
        pkerrors.geterrorvar(onuCodError, osbMensError);
        dbms_output.put_line('ERROR CONTR' || osbMensError);
        when others then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, osbMensError);
        pkerrors.geterrorvar(onuCodError, osbMensError);
        dbms_output.put_line('ERROR NCONT|' || osbMensError );
        DBMS_OUTPUT.PUT_LINE ('Termina OSF-949');
    END;

END;
/