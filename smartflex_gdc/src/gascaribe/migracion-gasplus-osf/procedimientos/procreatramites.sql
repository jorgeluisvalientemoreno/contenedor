CREATE OR REPLACE PROCEDURE        "PROCREATRAMITES" (inutotalhilos number,inuhilo number) is
  cursor cuproductos is
    select rowid nuregistro, otsadepa depa, otsaloca loca, otsanuot numeot, otsaprod producto,
           otsauoho unidadt, OTSAESTA estaproc, otsaesot estado, otsaposi caso, otsafere fecregistro
    from ldc_mig_otservasoc
    where otsaproc = 'P'
      and otsatitr in (1511,1260,1154,1277)
      and otsaesot in (1,2,10)
      --AND otsaprod = 363473
      AND mod(otsaprod,inutotalhilos)+1 = inuhilo
      and otsaesta = 'I'
      and otsaposi in (31,41,51,61)
   order by otsaorde asc;

  nuproducto      pr_product.product_id%type;
  nucaso          number;
  riregistro      rowid;
  sbErrMsg        varchar2(2000);
  nuorden         number;
  dtfechaReg      date;
begin

--  ut_trace.init;
--  ut_trace.setlevel(99);
--  ut_trace.setoutput(ut_trace.fntrace_output_db);
    if ( inuhilo = 1) then
      --pkgeneralservices.settracedataon('DB','RP');
      pkgeneralservices.tracedata('INICIO');
      pkgeneralservices.settracedataoff;
    END if;


  update ps_package_type
  set liquidation_method = 4
  where package_type_id in (265, 266);
  commit;

  --recorrer orden de reparacion por RP en estado 2
  ut_trace.trace('PAU - iniciando  proceso', 10);
  for rtproductos in cuproductos loop
    --1.crear tramite y orden RP
    begin
      nuproducto := rtproductos.producto;
      riregistro := rtproductos.nuregistro;
      nucaso := rtproductos.caso;
      dtfechaReg := rtproductos.fecregistro;
      ut_trace.trace('Inicia - nuproducto'|| nuproducto, 10);
      or_boreview.periodicreviewregister(nuproducto,dtfechaReg);
      ut_trace.trace('Termina - nuproducto'|| nuproducto, 10);
      --actualiza la tabla traza de migracion
      update ldc_mig_otservasoc
      set otsaesta = 'T'     --tramite
      where otsaprod = nuproducto
        and otsaproc = 'P'
        and otsaposi = nucaso;
      commit;
    exception
      when others then
        ut_trace.trace('Error - nuproducto'|| nuproducto, 10);
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
        --actualiza la tabla traza de migracion
        update ldc_mig_otservasoc
        set otsaesta = 'XT',
            otsaerro = 'error en el tramite'||sbErrMsg--error tramite
        where otsaprod = nuproducto
          and otsaproc = 'P'
          and otsaposi = nucaso;
        commit;
    end;
  end loop;

  --pkgeneralservices.settracedataon('DB','RP');
  pkgeneralservices.tracedata('Fin: '||sysdate);
  pkgeneralservices.settracedataoff;
END;
/
