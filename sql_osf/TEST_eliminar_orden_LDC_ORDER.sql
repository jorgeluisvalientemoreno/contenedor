declare

  cursor cuOrdenes is
    select lo.order_id, lo.package_id, oo.created_date
      from ldc_order lo
     inner join open.or_order oo
        on oo.order_id = lo.order_id
       and oo.order_status_id in (5, 8)
    --and oo.created_date >= sysdate - 500    
     where lo.asignado = 'N'
       and rownum <= 2000;

  /*    select *
        from ldc_order lo
       where lo.asignado = 'N'
         and (select count(1)
                from open.or_order oo
               where oo.order_id = lo.order_id
                 and oo.order_status_id in (5, 8)) = 1
         and rownum <= 1000;
  */
  rfcuORdenes cuOrdenes%rowtype;

  cursor cuCantidadOrdenes is
    select count(1) -- lo.order_id, lo.package_id
      from ldc_order lo
     inner join open.or_order oo
        on oo.order_id = lo.order_id
       and oo.order_status_id in (5, 8)
    --and oo.created_date >= sysdate - 500    
     where lo.asignado = 'N';

  nuCantidadOrdenes number;

  cursor cuOrdenesInsertar is
    select lo.*
      from ldc_order lo
     inner join open.or_order oo
        on oo.order_id = lo.order_id
       and oo.order_status_id = 0
     where lo.asignado = 'N'
       and (select count(1)
              from ldc_order_temp lot
             where lot.order_id = lo.order_id) = 0
       and rownum <= 5000;

  rfcuOrdenesInsertar cuOrdenesInsertar%rowtype;

begin

  /*open cuCantidadOrdenes;
  fetch cuCantidadOrdenes
    into nuCantidadOrdenes;
  close cuCantidadOrdenes;
  
  dbms_output.put_line('Canidad Incial: ' || nuCantidadOrdenes);*/

  /*for rfcuORdenes in cuOrdenes loop
  
    begin
      pkg_ldc_order.prcEliminarOrden(rfcuORdenes.order_id,
                                     rfcuORdenes.PACKAGE_ID);
      commit;
      dbms_output.put_line('Orden ' || rfcuORdenes.order_id ||
                           ' - Solicitud: ' || rfcuORdenes.PACKAGE_ID ||
                           ' eliminada ok');
    exception
      when others then
        rollback;
        dbms_output.put_line('No se elimino orden ' ||
                             rfcuORdenes.order_id || ' ok');
    end;
  
  end loop;*/

  for rfcuOrdenesInsertar in cuOrdenesInsertar loop
  
    begin
      Insert into ldc_order_temp
        (order_id,
         package_id,
         asignacion,
         asignado,
         ordeobse,
         ordefere,
         ordefebl,
         ordebloq)
      values
        (rfcuOrdenesInsertar.order_id,
         rfcuOrdenesInsertar.package_id,
         rfcuOrdenesInsertar.asignacion,
         rfcuOrdenesInsertar.asignado,
         rfcuOrdenesInsertar.ordeobse,
         rfcuOrdenesInsertar.ordefere,
         rfcuOrdenesInsertar.ordefebl,
         rfcuOrdenesInsertar.ordebloq);
      commit;
      /*dbms_output.put_line('Insetar Orden ' ||
                           rfcuOrdenesInsertar.order_id ||
                           ' - Solicitud: ' ||
                           rfcuOrdenesInsertar.PACKAGE_ID ||
                           ' eliminada ok');*/
    exception
      when others then
        rollback;
        /*dbms_output.put_line('No se elimino orden ' ||
                             rfcuOrdenesInsertar.order_id || ' ok');*/
    end;
  
  end loop;

end;
