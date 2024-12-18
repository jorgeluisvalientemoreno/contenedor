set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX OSF-1681');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

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
        (cargcuco = 3046200382 and cargcodo = 224201690) 
      OR
        (cargcuco = 3046200382 and cargcodo = 224247655)
      OR
        (cargcuco = 3046235320 and cargcodo = 224270816)
        )
  and cargsign='PA';

Begin

	dbms_output.put_line('Inicia aplicación del caso OSF-1681');

	for rg in cuPagos loop
		-- inserta en cargos
		insert into cargos (cargcuco,     cargnuse,     cargconc,     cargcaca,     cargsign,     cargpefa,     cargvalo,     cargdoso,
							cargcodo,     cargusua,     cargtipr,     cargunid,     cargfecr,     cargprog,     cargcoll,     cargpeco,
							cargtico,     cargvabl,     cargtaco)
					values (rg.cargcuco,  rg.cargnuse,  123,          rg.cargcaca,  'SA',  rg.cargpefa,  rg.cargvalo,  rg.cargdoso,
							rg.cargcodo,  rg.cargusua,  rg.cargtipr,      0,        rg.cargfecr,  rg.cargprog,  rg.cargcoll,  rg.cargpeco,
							rg.cargtico,  rg.cargvabl,  rg.cargtaco);
							
		dbms_output.put_line('Insertando información en cargos: ' || rg.cargcuco || ' con el concepto 123');


		-- actualiza cucovato
		/* select sum(decode(cargsign,'CR',-cargvalo,cargvalo))
		  into nusaldo
		  from cargos
		  where cargcuco=rg.cargcuco
		  and cargsign in ('DB','CR');*/

		begin
			select pagosusc, 
				   pagofepa, 
				   pagofegr,
				   pagousua,
				   pagoterm,
				   pagoprog
			into nususc, 
				 dtfepa, 
				 dtfereg, 
				 sbusua, 
				 sbterm, 
				 sbprog
			from pagos p
			where  pagocupo = rg.cargcodo;
			
		exception when others then
			nususc  := null; 
			dtfepa  := null; 
			dtfereg := null; 
			sbusua  := null; 
			sbterm  := null; 
			sbprog  := null;
		end;
		
		-- inserta en saldfavo
		nuseq1 := SQ_SALDFAVO_SAFACONS.NEXTVAL;
		insert into saldfavo (safacons,    safasesu,    safaorig,   safadocu,    safafech,
							  safafecr,    safausua,    safaterm,   safaprog,    safavalo)
					  values (nuseq1,      rg.cargnuse, 'PA',       rg.cargcuco, dtfepa,
							  dtfereg,     sbusua,      sbterm,     sbprog,      rg.cargvalo);
							  
		dbms_output.put_line('Insertando el saldo a favor: ' || nuseq1);

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
							  
		dbms_output.put_line('Insertando el movimiento del saldo a favor: ' || nuseq2);

		-- actualiza sesusafa
		update servsusc
		set sesusafa = sesusafa + nvl(rg.cargvalo, 0)
		where sesunuse = rg.cargnuse;
		
		dbms_output.put_line('Actualizando el saldo a favor del servicio suscrito: ' || rg.cargnuse);

		-- actualiza suscsafa
		update suscripc
		set suscsafa = suscsafa + nvl(rg.cargvalo, 0)
		where susccodi = nususc;
		
		dbms_output.put_line('Actualizando el saldo a favor del contrato: ' || nususc);
		
		commit;

	end loop;

	dbms_output.put_line('Termino Ok');

exception when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
end;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/