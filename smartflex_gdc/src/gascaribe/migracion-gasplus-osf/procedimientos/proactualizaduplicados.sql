CREATE OR REPLACE procedure proActualizaDuplicados as
  cursor cuproductos is
    select otsaprod, otsaposi, otsacarg
    from ldc_mig_otservasoc
    where otsaproc = 'P'
      --and otsaprod in (47,2544,290896)
      and otsaesta = 'I'
    order by otsaprod asc, otsacarg asc;
    
  cursor cuproducto(nuproducto ldc_mig_otservasoc.otsaprod%type,
                    nuprioridad ldc_mig_otservasoc.otsacarg%type) is
    select distinct otsaprod, otsacarg
    from ldc_mig_otservasoc a
    where otsaproc = 'P'
      and otsaesta != 'XT'
      and otsaprod = nuproducto
      and otsacarg != nuprioridad      
    order by otsacarg asc;
    
   nuprod ldc_mig_otservasoc.otsaprod%type;
   nuprior ldc_mig_otservasoc.otsacarg%type;
   
   nuproc number;
   nuproduct number;
   nupriorid number;
begin
  nuProc := 0;
  for rtproductos in cuproductos loop
    nuproc:= nuproc+1;
    nuprod := rtproductos.otsaprod;
    nuprior := rtproductos.otsacarg;
    if(nuproc = 1)then
      nuproduct := rtproductos.otsaprod; 
      if(nuprod = nuproduct)then
        nupriorid := nuprior;
      end if;
    else
      if(nuprod != nuproduct)then
        nuproc := 0;
        nuproduct := nuprod; 
        nupriorid := nuprior;
      end if;
    end if;
    
    for rtproducto in cuproducto(nuprod, nuprior)loop
      update ldc_mig_otservasoc
      set otsaesta = 'XD',
          otsaerro = 'No genera tramite porque va a ser procesado en otro caso de acuerdo a la  prioridad'
      where otsaprod = rtproducto.otsaprod
        and otsacarg != nupriorid  --- nuprior 
        and otsaproc = 'P';
      commit;
    end loop; 
  end loop;
end proActualizaDuplicados;
/
