declare
  nuErrorCode number;
  sbMessage   varchar2(4000);
begin

  OS_CHARGETOBILL(52725704,
                  985,
                  null,
                  53,
                  125300,
                  'PP-12313',
                  null,
                  nuErrorCode,
                  sbMessage);

  dbms_output.put_line(nuErrorCode);
  dbms_output.put_line(sbMessage);

  /*
  select 
   cargos.*
    from cargos
    left join servsusc
      on cargnuse = sesunuse
    left join concepto
      on cargconc = conccodi
    left join ic_clascont
      on concclco = clcocodi
    left join estacort
      on escocodi = sesuesco
    left join pr_product pr
      on cargnuse = product_id
    left join ps_product_status ps
      on ps.product_status_id = pr.product_status_id
   where sesunuse in (52725704)
        --and cargcaca in (1,4,15,60) and cargconc in (31)  and cargpeco >= 104431 
     and cargfecr > sysdate - 1
   ORDER BY cargfecr DESC;
   --*/

end;
