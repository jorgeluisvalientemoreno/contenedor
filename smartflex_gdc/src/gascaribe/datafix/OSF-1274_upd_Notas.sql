DECLARE
    nuNote          NUMBER (10);
    onuCodError     NUMBER;
    osbMensError    VARCHAR2(4000);
    nuCargNuse      cargos.cargnuse%type;

  CURSOR c_escenario1 IS 
        select 
        distinct(ca.cargcuco) as cargcuco,trunc(ca.cargfecr) as cargfecr
        from cargos  ca,  
        SERVSUSC ss, CAUSCARG cc, concepto co, ic_clascont icc, 
        procesos pr, cuencobr cbr
        where    ca.cargnuse = ss.sesunuse
        and ca.cargcaca = cc.cacacodi
        and ca.cargconc = co.conccodi
        and co.concclco = icc.clcocodi
        and ca.cargprog = pr.proccons
        and ca.cargcuco = cbr.cucocodi
        and cargfecr BETWEEN to_date(to_char('01/06/2023' || ' 00:00:00') , 'dd-mm-yyyy hh24:mi:ss')
                        AND to_date(to_char('30/06/2023' || ' 23:59:59') , 'dd-mm-yyyy hh24:mi:ss')         
        and ca.cargcaca=20 
        and ca.cargsign='DB' 
        and ca.cargtipr='P'
        and ca.cargusua=5673  
        and ca.cargprog=20
        and ca.cargdoso like 'DF-%'
        and ca.cargcodo= substr(ca.cargdoso,4);
        
   cursor c_nuse (nuCargcuco cargos.cargcuco%type) is
        select distinct(cargnuse) as cargnuse from cargos where
        cargcuco= nuCargcuco 
        and cargcaca=20 and cargsign='DB' 
        and cargtipr='P' 
        and cargprog=20
        and cargusua=5673 
        and trunc(cargfecr) BETWEEN to_date(to_char('01/06/2023' || ' 00:00:00') , 'dd-mm-yyyy hh24:mi:ss')
                                AND to_date(to_char('30/06/2023' || ' 23:59:59') , 'dd-mm-yyyy hh24:mi:ss') 
         and cargdoso like 'DF-%'
        and cargcodo= substr(cargdoso,4); 
 
   CURSOR c_escenario2 IS 
        select ss.sesuserv ,ca.rowid, ca.*
        from cargos  ca, notas no ,  
        SERVSUSC ss, CAUSCARG cc, open.concepto co, open.ic_clascont icc, 
        procesos pr, cuencobr cbr
        where ca.cargnuse = ss.sesunuse
        and ca.cargcaca = cc.cacacodi
        and ca.cargconc = co.conccodi
        and co.concclco = icc.clcocodi
        and ca.cargprog = pr.proccons
       and (ca.cargcodo = no.notanume and cbr.cucofact=no.notafact
        and ca.cargcuco!=cbr.cucocodi)
        and cargfecr BETWEEN to_date(to_char('01/06/2023' || ' 00:00:00') , 'dd-mm-yyyy hh24:mi:ss')
                        AND to_date(to_char('30/06/2023' || ' 23:59:59') , 'dd-mm-yyyy hh24:mi:ss')         
        and  ca.cargcodo in (select t.notanume from notas t where 
        trunc(t.notafeco) BETWEEN '01/06/2023' and '30/06/2023' and t. notatino <> 'L') 
        AND ca.CARGSIGN IN ('DB','CR')
        AND ca.cargtipr = 'P'
        AND ca.cargprog = no.notaprog
        and cbr.cuconuse=ss.sesunuse 
        and no.notaprog=68;       
BEGIN
  DBMS_OUTPUT.PUT_LINE ('Inicia OSF-1274 para Junio 2023 Diferencias Notas');

  BEGIN                                                          -- bloque 1
  DBMS_OUTPUT.PUT_LINE ('Inicia Escenario 1 piloto..............');
  -- Para cada registo
  FOR v_escenario1 IN c_escenario1
    LOOP
        DBMS_OUTPUT.PUT_LINE ('v_escenario1.cargcuco '|| v_escenario1.cargcuco);
        exit when c_escenario1%notfound;
     
    --obtiene el numero de servicio
        open c_nuse(v_escenario1.cargcuco);
            fetch c_nuse into nuCargNuse;
        close c_nuse;
        if (nuCargNuse is not null)
        then
        --  Crea la nota debito
            pkErrors.SetApplication('FRNF');
            pkBillingNoteMgr.CreateBillingNote (
                nuCargNuse,
                v_escenario1.cargcuco,
                GE_BOConstants.fnuGetDocTypeDebNote,
                TO_DATE (v_escenario1.cargfecr, 'dd/mm/yyyy hh24:mi:ss'),
                'NOTA GENERADA POR ERROR HECHOS ECONOMICOS JUNIO 2023 - OSFF-1274',
                pkBillConst.csbTOKEN_NOTA_DEBITO,
                nuNote);
                DBMS_OUTPUT.PUT_LINE ('crea nota '||nuNote||' y actualiza el cargo');
            -- se actualizan el cargcodo para que haga referencia a la nota
                UPDATE cargos
                   SET cargcodo = nuNote
                 WHERE cargcuco=v_escenario1.cargcuco 
                 and cargcaca=20 and cargsign='DB' 
                 and cargtipr='P' 
                 and cargprog=20
                 and cargusua=5673 
                 and trunc(cargfecr) BETWEEN to_date(to_char('01/06/2023' || ' 00:00:00') , 'dd-mm-yyyy hh24:mi:ss')
                                            AND to_date(to_char('30/06/2023' || ' 23:59:59') , 'dd-mm-yyyy hh24:mi:ss') 
                 and cargdoso like 'DF-%'
                 and cargcodo= substr(cargdoso,4)
                 and cargnuse=nuCargNuse;
            commit;
        end if;    
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
        DBMS_OUTPUT.PUT_LINE ('Termina OSF-1274');
    END;
    
    BEGIN                                                          -- bloque 1
    DBMS_OUTPUT.PUT_LINE ('Inicia Escenario 2 manot..............');
    -- Para cada registo
    FOR v_escenario2 IN c_escenario2
        LOOP
        --  Crea la nota debito
            pkErrors.SetApplication('FRNF');
            pkBillingNoteMgr.CreateBillingNote (
                v_escenario2.cargnuse,
                v_escenario2.cargcuco,
                GE_BOConstants.fnuGetDocTypeDebNote,
                TO_DATE (v_escenario2.cargfecr, 'dd/mm/yyyy hh24:mi:ss'),
                'NOTA GENERADA POR ERROR HECHOS ECONOMICOS JUNIO 2023 - OSFF-1274',
                pkBillConst.csbTOKEN_NOTA_DEBITO,
                nuNote);
            -- se actualizan el cargcodo para que haga referencia a la nota
            UPDATE cargos
               SET cargcodo = nuNote
             WHERE cargos.rowid = v_escenario2.rowid;
            dbms_output.put_line('Cargcuco: ' || v_escenario2.cargcuco || '-'  ||'cargcodo: ' || nuNote ||' - cargconc: '||v_escenario2.cargconc ||' - cargcaca:'||v_escenario2.cargcaca);    
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
            DBMS_OUTPUT.PUT_LINE ('Termina OSF-1274');
    END;

END;
/