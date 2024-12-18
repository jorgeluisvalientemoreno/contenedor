declare
  nuError   number;
  sbError   varchar2(4000);
  nuCuenta  open.cargos.cargcuco%type;
  dtFechaC  open.cargos.cargfecr%type;
  nuCuenta2 open.cargos.cargcuco%type;
  
  
  cursor cuDatos is
 select p.package_id,
        pp.package_payment_id,
       mp.motive_payment_id,
       m.product_id
  from open.mo_packages p
  inner join open.mo_motive m on m.package_id = p.package_id
  inner join open.MO_PACKAGE_PAYMENT  pp on p.package_id = pp.package_id
  inner join OPEN.MO_MOTIVE_PAYMENT mp on mp.package_payment_id=pp.package_payment_id
  where p.package_id in (188763327,187707402,184479466,183307949,188475824,187145349,187827351,187125312,188733298,184602174,188737456,188961023,188657378,188961585,188961093,187805104,182766083,187826674,187535666,187941500,187803865,188116443,188104068,188163524,187808461,187882499,188028909,188007021,187939587,184905896,188999381,184292896,188031607,188093646)
    AND NOT EXISTS (SELECT 1 FROM open.cargos fc
                 WHERE fc.cargnuse = m.product_id AND fc.cargconc = 19 AND fc.cargsign = 'DB' and cargdoso = 'PP-'||p.package_id);
  
  
  cursor cuCuenta(producto number) is
  select cargcuco, cargfecr
    from open.cargos
    where cargnuse=producto
      and cargsign='CR'
      and cargconc in (19,674)
      and cargdoso like 'FD-%'
      and cargcuco!=-1;
      
    cursor cuCuenta2(producto number, paquete number) is
  select cargcuco
    from open.cargos
    where cargnuse=producto
      and cargsign='DB'
      and cargconc=19
      and cargdoso like 'PP-'||paquete
      and cargcuco!=-1;
      
  cursor cuDatosMotivo(paquete number) is
  select mp.rowid
  from open.MO_PACKAGE_PAYMENT  pp
  inner join OPEN.MO_MOTIVE_PAYMENT mp on mp.package_payment_id=pp.package_payment_id
  where pp.package_id in (paquete);      
  
  nuMotivoPago  number;
  nuPaquetpago  number; 
  sbRowid       varchar2(4000);       
begin

  for reg in cuDatos loop
    begin
      nuError:=null;
      sbError:=null;
      nuCuenta:=null;
      nuCuenta2:=null;
      dtFechaC:=null;
      nuMotivoPago:=null;
      nuPaquetpago:=null;
      sbRowid:=null;
            
      delete MO_MOTIVE_PAYMENT mp where mp.MOTIVE_PAYMENT_ID = reg.MOTIVE_PAYMENT_ID and mp.PACKAGE_PAYMENT_ID=reg.PACKAGE_PAYMENT_ID;
      delete MO_PACKAGE_PAYMENT pp where pp.PACKAGE_PAYMENT_ID =reg.PACKAGE_PAYMENT_ID;
      CC_BOREQUESTRATING.requestratingbyfgca(reg.package_id);
      CC_BOACCOUNTS.GENERATEACCOUNTBYPACK(reg.package_id);
      open cuCuenta2(reg.product_id, reg.package_id);
      fetch cuCuenta2 into nuCuenta2;
      close cuCuenta2;
      if nuCuenta2 is not null then
          update cuencobr 
             set cucovato=0,
                 cucosacu=0,
                 cucovafa=0,
                 cucoimfa=0
          where cucocodi=nuCuenta2
            and cuconuse=reg.product_id;
          dbms_output.put_line('nuCuenta2:'||nuCuenta2);
      --
          open cuCuenta(reg.product_id);
          fetch cuCuenta into nuCuenta, dtFechaC;
          close cuCuenta;
          if nuCuenta is not null then
             update cargos set cargcuco = nuCuenta, cargfecr = dtFechaC  where cargnuse=reg.product_id and cargdoso='PP-'||reg.package_id;
             
             open cuDatosMotivo(reg.package_id);
             fetch cuDatosMotivo into sbRowid;
             close cuDatosMotivo;
             dbms_output.put_line('nuMotivoPago:'||nuMotivoPago);
             dbms_output.put_line('nuCuenta:'||nuCuenta);
             dbms_output.put_line('sbRowid:'||sbRowid);
             if sbRowid is not null then
                update MO_MOTIVE_PAYMENT mp set SUPPORT_DOCUMENT=nuCuenta,mp.ACCOUNT=nuCuenta where rowid=sbRowid;
                if sql%rowcount>0 then
                  commit;
                  dbms_output.put_line(reg.package_id||'|OK');
                else
                  rollback;
                  dbms_output.put_line(reg.package_id||'|NO HIZO NADA');
                end if;
             else
                rollback;
                dbms_output.put_line(reg.package_id||'|No se encontro motive_payment');
             end if;
              
             
          else
             rollback;
             dbms_output.put_line(reg.package_id||'|NO SE ENCONTRO CUENTA');
          end if;
      else
              rollback;
             dbms_output.put_line(reg.package_id||'|NO SE ENCONTRO CUENTA2');
      end if;

      
    exception
      when ex.CONTROLLED_ERROR then
        errors.getError(nuError, sbError);
        dbms_output.put_line(reg.package_id||'|'||sbError);
        rollback;
      when others then
        errors.setError();
        errors.getError(nuError, sbError);
        rollback;
        dbms_output.put_line(reg.package_id||'|'||sbError);
    end;
  end loop;
end;
/