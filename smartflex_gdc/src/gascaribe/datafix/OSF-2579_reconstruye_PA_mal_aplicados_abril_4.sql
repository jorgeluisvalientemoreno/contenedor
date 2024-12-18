  Declare

  nucuco         cuencobr.cucocodi%type;
  nuErrorCode    NUMBER;
  sbErrorMessage VARCHAR2(4000);  

  cursor cuCargos is
    select *
    from open.cargos
    where ( 
            (cargcuco = 3051066096) OR
            (cargcuco = 3049367774) OR
            (cargcuco = 3051159142) OR
            --
            (cargcuco = 3056534105) -- AJustar cuenta de la generacion del SA del cupon 232964998
          )
    and cargsign = 'CR';

  -- Ajuste de cuenta
  CURSOR cuDatos(inuCucocodi in cuencobr.cucocodi%type) IS
      SELECT cargos.cargcuco CUENTA,
             CUCOVATO,
             CUCOVAAB,
             NVL(SUM(DECODE(cargsign,
                            'DB',
                            (cargvalo),
                            'CR',
                            - (cargvalo),
                            0)),
                 0) Cargcucovato,
             NVL(SUM(DECODE(cargsign,
                            'PA',
                            cargvalo,
                            'AS',
                            cargvalo,
                            'SA',
                            -cargvalo,
                            0)),
                 0) Cargcucovaab,
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
                 0) Cargcucovafa,
             NVL(SUM(DECODE(SIGN(cargvalo), -1, 1, 0)), 0) Ccucocane
        FROM OPEN.cargos, OPEN.concepto, OPEN.CUENCOBR, OPEN.FACTURA
       WHERE cargcuco = inuCucocodi
         AND CARGCUCO = CUCOCODI
         AND FACTCODI = CUCOFACT
         AND cargconc = conccodi
         AND cargsign IN ('DB', 'CR',             -- Facturado
                          'PA',                   -- Pagos
                          'RD', 'RC', 'AD', 'AC', -- Reclamos
                          'AS', 'SA', 'ST', 'TS'  -- Saldo Favor
                         )
       GROUP BY cargos.cargcuco, CUCOVATO, CUCOVAAB;

  v_datos cuDatos%rowtype;

  Begin
    
    --
    -- Comienza proceso de borrado de cupones errados y actualizacion de la fecha del registro bien aplicado en la cuenta de cobro
    --
    begin
      -- borramos pago que esta de mas en cargos
      delete cargos
       where cargcodo =  233317875
         and cargcuco =  3051066096
         and cargsign =  'PA'   
         and cargnuse =  52591325    
         and cargfecr >= '05-04-2024'
         and cargfecr <  '06-04-2024';
      -- actualizamos fecha del pago que pertenece a la negociacion
      update cargos
         set cargfecr = cargfecr + 1
       where cargcodo = 233317875
         and cargsign = 'PA'
         and cargnuse = 1081907
         and cargfecr >= '04-04-2024'
         and cargfecr <  '05-04-2024';
      --
      Commit;
      --       
    exception
      When others then
         Errors.setError;
         Errors.getError(nuErrorCode, sbErrorMessage);
         dbms_output.put_line('Error en cupon 233317875');
    end;
    --
    begin
      -- borramos pago que esta de mas en cargos  
      delete cargos
       where cargcodo =  233317909
         and cargcuco in (3049367774, 3051159142)
         and cargnuse =  50772237
         and cargsign =  'PA'       
         and cargfecr >= '05-04-2024'
         and cargfecr <  '06-04-2024';
      -- actualizamos fecha del pago que pertenece a la negociacion
      update cargos
         set cargfecr = cargfecr + 1
       where cargcodo = 233317909
         and cargsign = 'PA'
         and cargnuse = 50094242
         and cargfecr >= '04-04-2024'
         and cargfecr <  '05-04-2024';
      --
      Commit;
      --       
    exception
      When others then
         Errors.setError;
         Errors.getError(nuErrorCode, sbErrorMessage);
         dbms_output.put_line('Error en cupon 233317909');
    end;
    -- Fin proceso de actualizacion y borrado de cupones
    --
    
    -- Proceso para actualizar cuentas de cobro
    For Rg in Cucargos loop

      nucuco := rg.cargcuco;

      Begin
        -- Balanceamos cuenta
        --
        open cuDatos(rg.cargcuco);
        fetch cuDatos
          into v_datos;
        close cuDatos;
        --
        if (v_datos.cucovato != v_datos.cargcucovato OR v_datos.cucovaab != v_datos.cargCUCOVAAB) then

            ut_trace.SetOutPut(ut_trace.cnuTRACE_OUTPUT_DB);
            ut_trace.SetLevel(2);

            ut_trace.trace('SDFGHKL cucocodi: ' || v_datos.CUENTA, 1);

            ut_trace.trace('Cuenta: ' || rg.cargcuco || ' cucovato ' ||
                           v_datos.cucovato || '/' || v_datos.cargcucovato ||
                           ' - Cucovaab ' || v_datos.cucovaab || '/' ||
                           v_datos.cargCUCOVAAB,
                           2);
            -- Catualizamos la cuenta de cobro.               
            PKTBLCUENCOBR.Updcucovaab(rg.CARGCUCO,v_datos.cargCUCOVAAB);
            PKTBLCUENCOBR.Updcucovato(rg.CARGCUCO,v_datos.cargcucovato);
            --
        end if;
        --
        commit;
        --
      Exception when others then
        rollback;
        dbms_output.put_line('Error en Cuenta de Cobro : ' || nucuco || '  ' || sqlerrm);    
      End;
      --
    
    End loop;

    dbms_output.put_line('Proceso Termino Ok');

  Exception when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);

end;
/