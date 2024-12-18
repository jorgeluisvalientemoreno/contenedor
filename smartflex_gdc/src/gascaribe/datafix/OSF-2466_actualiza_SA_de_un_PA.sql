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
    from open.cargos, open.servsusc
    where cargcuco = 3056033987 
      and cargnuse = 51864483
      and cargnuse = sesunuse
      and cargcodo = 232064498
      and cargsign = 'SA'
      and cargvalo = 24;

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
            /* NVL(SUM(DECODE(cargtipr,
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
                 0) cucoimfa,*/
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
      -- Actualiza la tabla cargos
      update cargos
         set cargvalo = 10671
       where cargcuco = rg.cargcuco 
         and cargnuse = rg.cargnuse
         and cargcodo = rg.cargcodo
         and cargsign = rg.cargsign
         and cargvalo = rg.cargvalo;  
    
      -- actualiza saldfavo  
      update saldfavo  s
         set s.safavalo = 10671
       where s.safasesu = rg.cargnuse
         and s.safavalo = rg.cargvalo;

      -- actualiza movisafa
      update movisafa m
         set m.mosfvalo = 10671
       where m.mosfsesu = rg.cargnuse
         and m.mosfvalo = rg.cargvalo;

      -- actualiza sesusafa
      update servsusc
          set sesusafa = sesusafa + 10671
        where sesunuse = rg.cargnuse;

      -- actualiza suscsafa
      update suscripc
          set suscsafa = suscsafa + 10671
        where susccodi = rg.sesususc;        

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