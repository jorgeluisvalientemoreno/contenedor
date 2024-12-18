-- Created on 5/07/2023
declare

  -- Solicitud de venta 323
  Cursor cusolicitudes is
   select cargcuco, cargnuse, cargconc, cargcaca, cargsign, cargvalo, cargpefa, substr(cargdoso,4) solicitud, cargcodo, cargfecr, rowid
     from open.cargos
    where cargcuco = -1
      and cargcodo in (242821482,242821481,242822663,242821483,242821478,242821480,242821477,289988712,289988711,289988713,289988715,242821476,242821484,289988714,284585379,284585304,284585380,284585298,
             284585321,284585720,284585390,284585377,286657295,284585733,284585735,284585719,284585391,284585326,284585717,284585346,284585389,284585739,284585741,273281506,246228615,273281412,273281493,
             286657275,286657286,284585394,286657277,273281498,273281426,273281423,273281482,273281503,273281496,273281420,273281410,286657276,286657294,284585465,286657284,284585701,284585388,280661567,
             280661974,273281488,273281416,286657283,273281414,284585302,284585444,273281415,280661716,290658498)
      and cargfecr >= '05-07-2023';
  -- Producto generico
  Cursor cuproducto(nusoli mo_packages.package_id%type) is
   select  m.product_id, s.susccicl
     from open.mo_motive m, open.suscripc s
    where m.package_id = nusoli
      and m.product_type_id = 6121
      and m.subscription_id = s.susccodi;
  -- Periodo de facturacion activo
  Cursor cuperifact(vnucicl perifact.pefacicl%type) is
   select p.pefacodi from open.perifact p
    where p.pefacicl = vnucicl
      and p.pefaactu = 'S';
  -- Variables para identificar el error si lo hay
  vnusoli  mo_packages.package_id%type;
  vnuconc  concepto.conccodi%type;
  vnuorde  or_order.order_id%type;
  vnuvalo  cargos.cargvalo%type;
  --
  vnunuse  servsusc.sesunuse%type;
  vnuciclo perifact.pefacicl%type;
  vnupefa  perifact.pefacodi%type;
  --
begin
  -- Test statements here
  for reg in cusolicitudes loop
    --
    vnusoli  := reg.solicitud;
    vnuconc  := reg.cargconc;
    vnuvalo  := reg.cargvalo;
    vnuorde  := reg.cargcodo;
    -- Buscamos producto generico y ciclo de este
    open cuproducto(reg.solicitud);
    fetch cuproducto into vnunuse, vnuciclo;
    close cuproducto;
    -- Periodo de facturacion activo
    open cuperifact(vnuciclo);
    fetch cuperifact into vnupefa;
    close cuperifact;
    -- Actualizamos cargos
    update cargos c
       set cargnuse = vnunuse,
           cargpefa = vnupefa
     where cargcuco = -1
       and cargnuse = reg.cargnuse
       and cargconc = reg.cargconc
       and cargsign = reg.cargsign
       and cargcaca = reg.cargcaca
       and cargpefa = reg.cargpefa
       and cargfecr = reg.cargfecr;
    --
  end loop;
  --
  commit;
  --
  dbms_output.put_line('Proceso termina ok');
Exception
  when others then
      ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error procesando solicitud : ' || vnusoli || '  orden : ' || vnuorde ||'   ' ||'  concepto : ' || vnuconc ||'   ' || ' valor ' || vnuvalo || SQLERRM);
End;
/