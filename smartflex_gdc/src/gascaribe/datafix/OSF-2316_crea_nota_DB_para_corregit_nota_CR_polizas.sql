column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  Declare

  nucuco   cuencobr.cucocodi%type;

  cursor cuCargos is
  select *
  from open.cargos
  where (
          (cargcuco = 3053550559 and cargnuse = 52318173) OR
          (cargcuco = 3053550539 and cargnuse = 52320485) OR
          (cargcuco = 3053550326 and cargnuse = 52320519) OR
          (cargcuco = 3053550588 and cargnuse = 52320789) OR
          (cargcuco = 3053550391 and cargnuse = 52320932) OR
          (cargcuco = 3053550345 and cargnuse = 52321011) OR
          (cargcuco = 3053550502 and cargnuse = 52321152) OR
          (cargcuco = 3053550703 and cargnuse = 52321189) OR
          (cargcuco = 3053550381 and cargnuse = 52539788) OR
          (cargcuco = 3053550789 and cargnuse = 52539852) OR
          (cargcuco = 3053550731 and cargnuse = 52539861) OR
          (cargcuco = 3053550582 and cargnuse = 52543955) OR
          (cargcuco = 3053550729 and cargnuse = 52546917) OR
          (cargcuco = 3053550674 and cargnuse = 52546985) OR
          (cargcuco = 3053550666 and cargnuse = 52546998) OR
          (cargcuco = 3053550350 and cargnuse = 52547098) OR
          (cargcuco = 3053550436 and cargnuse = 52551338) OR
          (cargcuco = 3053550357 and cargnuse = 52551371) OR
          (cargcuco = 3053550505 and cargnuse = 52551382) OR
          (cargcuco = 3053550371 and cargnuse = 52551437)
        )
  and cargsign = 'CR';

  -- Ajuste de cuenta
  CURSOR cuDatos(inuCucocodi in cuencobr.cucocodi%type) IS
      SELECT cargos.cargcuco CUENTA,
             CUCOVATO,
             CUCOVAAB,
             --cargos.cargnuse PRODUCTO,
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
       WHERE cargcuco = inuCucocodi -- 3053550559
         --AND cargnuse = 52318173
         AND CARGCUCO = CUCOCODI
         --AND CARGNUSE = CUCONUSE
         AND FACTCODI = CUCOFACT
         AND cargconc = conccodi
         AND cargsign IN ('DB', 'CR', -- Facturado
              'PA', -- Pagos
              'RD', 'RC', 'AD', 'AC', -- Reclamos
              'AS', 'SA', 'ST', 'TS' -- Saldo favor
             )
       GROUP BY cargos.cargcuco, /*cargos.cargnuse,*/ CUCOVATO, CUCOVAAB;

  v_datos cuDatos%rowtype;

  Begin

  For rg in cuCargos loop
    
    nucuco := rg.cargcuco;
    
    Begin
      -- inserta en cargos
      insert into cargos (cargcuco,     cargnuse,     cargconc,     cargcaca,     cargsign,     cargpefa,     cargvalo,     cargdoso,
                          cargcodo,     cargusua,     cargtipr,     cargunid,     cargfecr,     cargprog,     cargcoll,     cargpeco,
                          cargtico,     cargvabl,     cargtaco)
                  values (rg.cargcuco,  rg.cargnuse,  rg.cargconc,  rg.cargcaca,  'DB',         rg.cargpefa,  rg.cargvalo,  rg.cargdoso,
                          rg.cargcodo,  rg.cargusua,  rg.cargtipr,  rg.cargunid,  sysdate,      rg.cargprog,  rg.cargcoll,  rg.cargpeco,
                          rg.cargtico,  rg.cargvabl,  rg.cargtaco);

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

          ut_trace.trace('SDFGHKL Seguros cucocodi: ' || v_datos.CUENTA, 1);

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
  End;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/