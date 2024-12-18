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

  nusaldo   cuencobr.cucosacu%type;
  nususc    pagos.pagosusc%type;
  dtfepa    date; 
  dtfereg   date;
  sbusua    movisafa.mosfusua%type;
  sbterm    movisafa.mosfterm%type;
  sbprog    movisafa.mosfprog%type;

  cursor cuPagos is
  select *
  from open.cargos
  where (
        (cargcuco = 3042487249 and cargcodo = 222478914) 
        )
  and cargsign='PA';

  Begin
    
  for rg in cuPagos loop
    -- inserta en cargos
    insert into cargos (cargcuco,     cargnuse,     cargconc,     cargcaca,     cargsign,     cargpefa,     cargvalo,     cargdoso,
                        cargcodo,     cargusua,     cargtipr,     cargunid,     cargfecr,     cargprog,     cargcoll,     cargpeco,
                        cargtico,     cargvabl,     cargtaco)
                values (rg.cargcuco,  rg.cargnuse,  123,          rg.cargcaca,  'SA',  rg.cargpefa,  rg.cargvalo,  rg.cargdoso,
                        rg.cargcodo,  rg.cargusua,  rg.cargtipr,      0,        rg.cargfecr,  rg.cargprog,  rg.cargcoll,  rg.cargpeco,
                        rg.cargtico,  rg.cargvabl,  rg.cargtaco);


    -- actualiza cucovato
    /* select sum(decode(cargsign,'CR',-cargvalo,cargvalo))
      into nusaldo
      from cargos
      where cargcuco=rg.cargcuco
      and cargsign in ('DB','CR');*/

      
    -- inserta en saldfavo
    nuseq1 := SQ_SALDFAVO_SAFACONS.NEXTVAL;

    begin
    select pagosusc, pagofepa, pagofegr,pagousua,pagoterm,pagoprog
      into nususc, dtfepa, dtfereg, sbusua, sbterm, sbprog
      from pagos p
    where  pagocupo=rg.cargcodo;
    exception when others then
      nususc := null; dtfepa:= null; dtfereg:= null; sbusua:=null; sbterm:=null; sbprog:=null;
    end;

    insert into saldfavo (safacons,    safasesu,    safaorig,   safadocu,    safafech,
                          safafecr,    safausua,    safaterm,   safaprog,    safavalo)
                  values (nuseq1,      rg.cargnuse, 'PA',       rg.cargcuco, dtfepa,
                          dtfereg,     sbusua,      sbterm,     sbprog,      rg.cargvalo);

    -- inserta en movisafa
    nuseq2 := SQ_MOVISAFA_MOSFCONS.NEXTVAL;
    insert into movisafa (mosfcons,   mosfsafa,    mosfvalo,    mosfdoso,
                          mosffech,   mosffecr,    mosfusua,    mosfterm,
                          mosfprog,   mosfsesu,    mosfcuco,    mosfnota,
                          mosfdeta)
                  values (nuseq2,     nuseq1,      rg.cargvalo, null,
                          dtfepa,     dtfereg,     sbusua,      sbterm,
                          sbprog,     rg.cargnuse, rg.cargcuco, null,
                          'PA');

    -- actualiza sesusafa
    update servsusc
        set sesusafa = sesusafa + nvl(rg.cargvalo,0)
      where sesunuse = rg.cargnuse;

    -- actualiza suscsafa
    update suscripc
        set suscsafa = suscsafa + nvl(rg.cargvalo,0)
      where susccodi = nususc;

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