column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
Declare

  nuseq1 All_Sequences.LAST_NUMBER%type;
  nuseq2 All_Sequences.LAST_NUMBER%type;

  -- Para buscar el AS que se aplico de mas
  cursor cuCargos is
  select c.*, sesususc
  from open.cargos c, open.servsusc
  where (
        (cargcuco = 3060352794 and cargcodo = 8709144871) 
        )
  and cargsign = 'AS'
  and cargnuse = sesunuse;
  
  -- para cuadrar valores de cuenta de cobro
  Cursor CuDatos Is
  SELECT  *
  FROM    (
            SELECT  CARGCUCO,
                    CUCOVATO,
                    CUCOVAAB,
                    NVL(CUCOSACU,0) CUCOSACU,
                    NVL(SUM(DECODE( CARGSIGN,
                                    'DB', CARGVALO,
                                    'CR',-CARGVALO
                               )),0) VATO,
                    NVL(SUM(DECODE(CARGSIGN,
                                   'PA', CARGVALO,
                                   'AS', CARGVALO,
                                   'NS', CARGVALO,
                                   'SA',-CARGVALO,
                                   'AP',-CARGVALO
                               )),0) VAAB
            FROM    open.CARGOS, open.CUENCOBR, open.FACTURA
            WHERE   CARGCUCO = CUCOCODI
                    AND FACTCODI = CUCOFACT
                    AND CUCOCODI = 3060352794
                    AND cargsign IN ('DB', 'CR',   -- Facturado
                                     'PA',         -- Pagos
                                     'RD', 'RC', 'AD', 'AC', -- Reclamos
                                     'AS', 'SA', 'ST', 'TS'  -- Saldo favor
                                    )                        
            GROUP BY CARGCUCO, CUCOVATO, CUCOVAAB, CUCOSACU
          );  
  
  v_datos cuDatos%rowtype;

  Begin

  for rg in cuCargos loop
    -- Inserta en cargos
    insert into cargos (cargcuco,     cargnuse,     cargconc,       cargcaca,     cargsign,     cargpefa,     cargvalo,     cargdoso,
                        cargcodo,     cargusua,     cargtipr,       cargunid,     cargfecr,     cargprog,     cargcoll,     cargpeco,
                        cargtico,     cargvabl,     cargtaco)
                values (rg.cargcuco,  rg.cargnuse,  123,            rg.cargcaca,  'SA',         rg.cargpefa,  4449552,      'CTN-3060352794',
                        129154909,    rg.cargusua,  rg.cargtipr,    0,            sysdate,      rg.cargprog,  rg.cargcoll,  rg.cargpeco,
                        rg.cargtico,  NULL,         rg.cargtaco);


    -- SALDO A FAVOR
    -- Inserta en saldfavo
    nuseq1 := SQ_SALDFAVO_SAFACONS.NEXTVAL;
    insert into saldfavo (safacons,    safasesu,    safaorig,       safadocu,       safafech,
                          safafecr,    safausua,    safaterm,       safaprog,       safavalo)
                  values (nuseq1,      rg.cargnuse, 'AS',           rg.cargcuco,    sysdate,
                          sysdate,     'OPEN',      'NO TERMINAL',  'FMPC',         4449552);

    -- Inserta en movisafa
    nuseq2 := SQ_MOVISAFA_MOSFCONS.NEXTVAL;
    insert into movisafa (mosfcons,     mosfsafa,     mosfvalo,     mosfdoso,
                          mosffech,     mosffecr,     mosfusua,     mosfterm,
                          mosfprog,     mosfsesu,     mosfcuco,     mosfnota,
                          mosfdeta)
                  values (nuseq2,       nuseq1,       4449552,      null,
                          sysdate,      sysdate,      'OPEN',      'NO TERMINAL',
                          'FMPC',       rg.cargnuse,  rg.cargcuco,  null,
                          'CORR_CTA');

    -- Actualiza sesusafa
    update servsusc
       set sesusafa = sesusafa + 4449552
     where sesunuse = rg.cargnuse;

    -- Actualiza suscsafa
    update suscripc
       set suscsafa = suscsafa + 4449552
     where susccodi = rg.sesususc;
      
    -- Ajustamos los valores de la cuenta de cobro
    open cuDatos;
    fetch cuDatos
      into v_datos;
    close cuDatos;    

    if (v_datos.cucovato != v_datos.VATO OR v_datos.cucovaab != v_datos.VAAB) THEN
      PKTBLCUENCOBR.UPDCUCOVATO(v_datos.CARGCUCO, v_datos.VATO);
      PKTBLCUENCOBR.UPDCUCOVAAB(v_datos.CARGCUCO, v_datos.VAAB);
	    PKTBLCUENCOBR.UPDCUCOVAFA(v_datos.CARGCUCO, v_datos.VATO);
    end if;
    
  end loop;

  commit;
  
  dbms_output.put_line('Termino Ok');

  exception when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
  end;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/