declare
  cursor correos is
    select
      suscdeco correo,
      suscefce flag,
      susccodi contrato,
      susccicl ciclo
    from open.suscripc@osfpl s
    where susccicl = 5105
      and suscdeco is not null;

begin
  for reg in correos loop

    update suscripc
    set suscefce = reg.flag,
        suscdeco = reg.correo
    where susccicl = reg.ciclo
      and susccodi = reg.contrato;
  end loop;
 commit ;
end;
