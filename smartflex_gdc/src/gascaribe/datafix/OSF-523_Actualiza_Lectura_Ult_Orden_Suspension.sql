declare

  nuerrorcode    NUMBER; --se almacena codigo de error
  sberrormessage VARCHAR2(4000); --se almacena mensaje de error

  --cursor para obtener prodcutos suspendios por orden de suspension con causal de exito 
  cursor cuporductossuspendidos is
    select b.producto, b.UltActSuspension, l.leemfele Fecha_Lectura
      from (select a.product_id        producto,
                   a.suspen_ord_act_id UltActSuspension
              from open.pr_product a
             inner join open.Or_Order_Activity ooa
                on ooa.order_activity_id = a.suspen_ord_act_id
             inner join open.or_order oo
                on oo.order_id = ooa.order_id
               and dage_causal.fnugetclass_causal_id(oo.causal_id, null) = 1
               and oo.task_type_id in (10061,
                                       10064,
                                       10169,
                                       10546,
                                       10547,
                                       10881,
                                       10882,
                                       10884,
                                       10917,
                                       10918,
                                       12521,
                                       12523,
                                       12524,
                                       12526,
                                       12528)
             where a.product_type_id = 7014
               and a.product_status_id = 2) b
     inner join lectelme l
        on l.leemsesu = b.producto
       AND l.LEEMDOCU = b.UltActSuspension
       and l.leemleto is null;

  rfcuporductossuspendidos cuporductossuspendidos%rowtype;

  --Obtener lectura anterior a la suspension legalizada
  cursor cuLectAntSuspension(InuProdcuto number, IdtFechaLecturaSusp date) is
    SELECT lectelme.leemleto Lectura_Tomada_Factura,
           lectelme.leemlean Lectura_Anterior_Factura,
           lectelme.leemfele Fecha_Lectura_Factura
      FROM lectelme
     WHERE leemsesu = InuProdcuto
       and lectelme.leemfele < IdtFechaLecturaSusp
       and lectelme.leemclec = 'F'
       and lectelme.leemleto is not null
     order by lectelme.leemfele desc;

  rfcuLectAntSuspension cuLectAntSuspension%rowtype;

  Put_line_cantidad number := 0;

begin

  dbms_output.put_line('Inicio: ' || sysdate);
  --Recorrer los prodcutos suspendidos 
  for rfcuporductossuspendidos in cuporductossuspendidos loop
  
    --dbms_output.put_line('Producto: ' || rfcuporductossuspendidos.producto || ' -  Ultima actividad de suspension: ' || rfcuporductossuspendidos.UltActSuspension);
    --Obtener la lecutar de la ultima actividad de suspension 
    open cuLectAntSuspension(rfcuporductossuspendidos.producto,
                             rfcuporductossuspendidos.Fecha_Lectura);
    fetch cuLectAntSuspension
      into rfcuLectAntSuspension;
    if cuLectAntSuspension%found then
      /*
      dbms_output.put_line('Producto: ' ||
                           rfcuporductossuspendidos.producto ||
                           ' con Ultima actividad de suspension: ' ||
                           rfcuporductossuspendidos.UltActSuspension ||
                           ' actualiza con la Lectura Facturada: ' ||
                           rfcuLectAntSuspension.Lectura_Tomada_Factura ||
                           ' con Fecha de Factura: ' ||
                           rfcuLectAntSuspension.Fecha_Lectura_Factura);
      --*/
    
      begin
      
        update lectelme l1
           set l1.leemleto = rfcuLectAntSuspension.Lectura_Tomada_Factura,
               l1.leemlean = rfcuLectAntSuspension.Lectura_Tomada_Factura
         WHERE l1.leemsesu = rfcuporductossuspendidos.producto
           AND l1.LEEMDOCU = rfcuporductossuspendidos.UltActSuspension;
      
        commit;
        --rollback;
      
      exception
        WHEN ex.controlled_error THEN
          errors.geterror(nuerrorcode, sberrormessage);
          RAISE ex.controlled_error;
        WHEN OTHERS THEN
          rollback;
          errors.seterror;
          errors.geterror(nuerrorcode, sberrormessage);
          dbms_output.put_line('Error: ' || nuerrorcode || ' -  ' ||
                               sberrormessage);
          RAISE ex.controlled_error;
      end;
    end if;
    close cuLectAntSuspension;
  
  end loop;
  dbms_output.put_line('Procedo de actualización de lectura de la última suspensión. Ok');
  dbms_output.put_line('Fin: ' || sysdate);
end;
/