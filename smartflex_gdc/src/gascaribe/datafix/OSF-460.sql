declare
  cursor cuContratoConDireccion is
    select A.*
      FROM open.ge_subscriber a
     WHERE A.ADDRESS_ID IS NOT NULL
       AND (select count(1)
              from open.ab_address b
             where a.address_id = b.address_id) = 0
       and (select count(1)
              from open.suscripc c
             where c.suscclie = a.subscriber_id) > 0
     order by 1 desc;
  rfcuContratoConDireccion cuContratoConDireccion%rowtype;

  cursor cucontrato(InuSUBSCRIBER_ID number) is
    select a.susciddi codigo_direccion,
           open.daab_address.fsbgetaddress(a.susciddi) direccion
      from open.suscripc a, open.servsusc b
     where a.suscclie = InuSUBSCRIBER_ID
       and a.susccodi = b.sesususc
       and rownum = 1;
  rfcucontrato cucontrato%rowtype;

  cursor cuSinContratoConDireccion is
    select A.*
      FROM open.ge_subscriber a
     WHERE A.ADDRESS_ID IS NOT NULL
       AND (select count(1)
              from open.ab_address b
             where a.address_id = b.address_id) = 0
       and (select count(1)
              from open.suscripc c
             where c.suscclie = a.subscriber_id) = 0
     order by 1 desc;
  rfcuSinContratoConDireccion cuSinContratoConDireccion%rowtype;

begin

  --ACtualizar direccion del contrato 67283979
  begin
    update open.ge_subscriber a
       set a.address_id = 4250141,
           a.address    = 'CL 44 KR 53 - 40 APTO INT 1'
     where a.subscriber_id = 1525826;
    commit;
  exception
    when others then
      rollback;
      dbms_output.put_line('Inconsistencia actualizando la direcion[4250141 - CL 44 KR 53 - 40 APTO INT 1] en el cliente[1525826] - Error: ' || sqlerrm);
  end;

  --Actualizar direccion de clientes
  for rfcuContratoConDireccion in cuContratoConDireccion loop
    --dbms_output.put_line('Cliente: ' || rfcuContratoConDireccion.subscriber_id || ' - Codigo Direccion: ' || rfcuContratoConDireccion.address_id);
    for rfcucontrato in cucontrato(rfcuContratoConDireccion.subscriber_id) loop
      --dbms_output.put_line('Cliente: ' || rfcuContratoConDireccion.subscriber_id || ' - Codigo Direccion: ' || rfcucontrato.codigo_direccion || ' - Direccion:  ' || rfcucontrato.direccion);
      begin
        update open.ge_subscriber a
           set a.address_id = rfcucontrato.codigo_direccion,
               a.address    = rfcucontrato.direccion
         where a.subscriber_id = rfcuContratoConDireccion.subscriber_id;
        commit;
      exception
        when others then
          rollback;
          dbms_output.put_line('Inconsistencia actualizando la direcion[' ||
                               rfcucontrato.codigo_direccion || ' -  ' ||
                               rfcucontrato.direccion ||
                               '] en el cliente[' ||
                               rfcuContratoConDireccion.subscriber_id ||
                               '] - Error: ' || sqlerrm);
      end;
    end loop;
  end loop;

  for rfcuSinContratoConDireccion in cuSinContratoConDireccion loop
    --dbms_output.put_line('Cliente: ' ||rfcuSinContratoConDireccion.subscriber_id ||' - Codigo Direccion: ' ||rfcuSinContratoConDireccion.address_id);
    begin
      update open.ge_subscriber a
         set a.address_id = NULL, a.address = NULL
       where a.subscriber_id = rfcuSinContratoConDireccion.subscriber_id;
      commit;
      null;
    exception
      when others then
        rollback;
        dbms_output.put_line('Inconsistencia actualizando la direcion[' ||
                             rfcucontrato.codigo_direccion || ' -  ' ||
                             rfcucontrato.direccion || '] en el cliente[' ||
                             rfcuSinContratoConDireccion.subscriber_id ||
                             '] - Error: ' || sqlerrm);
    end;
  end loop;

end;
/