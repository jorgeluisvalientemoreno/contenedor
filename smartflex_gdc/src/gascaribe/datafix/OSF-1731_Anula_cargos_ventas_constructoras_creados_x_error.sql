column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  DECLARE
    nuNote          NUMBER (10);
    onuCodError     NUMBER;
    osbMensError    VARCHAR2(4000);

    CURSOR cuCargos IS
      SELECT cargcuco, cargnuse, cargconc, cargsign, sum(cargvalo) cargvalo, sum(cargvabl) cargvabl, sesususc
      FROM OPEN.CARGOS c, open.servsusc s
      WHERE c.CARGCUCO IN (3044032927, 3045839670, -- Contrato 66537924
                          3044034500, 3045841092)  -- Contrato 67402210
      AND c.cargnuse = sesunuse
      AND c.CARGFECR >= '01-08-2023'
      group  by cargcuco, cargnuse, cargconc, cargsign, sesususc
      ORDER BY c.cargnuse, c.CARGCUCO DESC;

  BEGIN
    -- Para cada registo
    FOR reg IN cuCargos LOOP
      --  Crea la nota CREDITO
      pkErrors.SetApplication('CUSTOMER');
      pkBillingNoteMgr.CreateBillingNote (reg.cargnuse,
                                          reg.cargcuco,
                                          GE_BOConstants.fnuGetDocTypeCreNote,
                                          SYSDATE,
                                          'NOTA PARA ANULAR CARGO DE VENTA CONSTRUCTORA - OSF-1731',
                                          pkBillConst.csbTOKEN_NOTA_CREDITO,
                                          nuNote);

      -- se actualizan el cargcodo para que haga referencia a la nota
      FA_BOBillingNotes.Detailregister
      (
        nuNote,
        reg.cargnuse,
        reg.sesususc,
        reg.cargcuco,
        reg.cargconc,
        1,
        reg.cargvalo,
        reg.cargvabl,
        'NC-' || nuNote,
        'CR',
        'Y',
        NULL,
        'N',
        FALSE
      );
      dbms_output.put_line('Cargcuco: ' || reg.cargcuco || '-'  ||'cargcodo: ' || nuNote ||' - cargconc: '||reg.cargconc ||' - cargcaca:'||1);

      -- generamos saldo a favor si aplica
      --pkAccountMgr.GenPositiveBal(reg.cargcuco, reg.cargconc);
      dbms_output.put_line('SA - Cargcuco: ' || reg.cargcuco || '-'  ||'cargcodo: ' || nuNote ||' - cargconc: '||reg.cargconc ||' - cargcaca:'||1);
    END LOOP;
    --
    COMMIT;
    --
    DBMS_OUTPUT.PUT_LINE('Proceso termina ok - cargos facturados');
  EXCEPTION
    WHEN others THEN
    ROLLBACK;
    ERRORS.SETERROR();
    RAISE EX.CONTROLLED_ERROR;
  END;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/