DECLARE

  cursor cuListadoOrden is
  --DATA Orden
    select oo.order_id Orden
      from open.or_order oo
     where trunc(oo.created_date) >= '01/06/2024' --trunc(sysdate) 
       and oo.order_status_id in (8)
       and oo.defined_contract_id in (9683, 9321, 9781, 9861, 9322, 9541)
     order by oo.created_date desc;

  rfcuListadoOrden cuListadoOrden%rowtype;

  --cursor para DATA de orden 
  cursor cuDataOrden(inuOrden number) is
    select o.order_id ORDEN, o.order_status_id estado
      from open.or_order o
     where o.order_id = inuOrden;

  rfcuDataOrden cuDataOrden%rowtype;

  SBCOMMENT     VARCHAR2(4000) := 'SE ANULA ORDEN';
  nuCommentType number := 1277;
  nuErrorCode   number;
  sbErrorMesse  varchar2(4000);

BEGIN

  --Recorrer Lsitado de ordenes
  for rfcuListadoOrden in cuListadoOrden loop
  
    --Recorrer DATA de orden 
    for rfcuDataOrden in cuDataOrden(rfcuListadoOrden.Orden) loop
      if rfcuDataOrden.estado <> 0 then
        BEGIN
          -- Anulamos la OT
          or_boanullorder.anullorderwithoutval(rfcuDataOrden.ORDEN,
                                               SYSDATE);
        
          --/*-- Adicionamos comentario a la OT
          OS_ADDORDERCOMMENT(rfcuDataOrden.ORDEN,
                             nuCommentType,
                             SBCOMMENT,
                             nuErrorCode,
                             sbErrorMesse);
          --*/
        
          If nuErrorCode = 0 then
            commit;
            dbms_output.put_line('Orden ' || rfcuDataOrden.ORDEN ||
                                 ' anulada Ok.' || sbErrorMesse);
          Else
            rollback;
            dbms_output.put_line('Error en Orden ' || rfcuDataOrden.ORDEN ||
                                 ' Error : ' || sbErrorMesse);
          End if;
          --
        EXCEPTION
          WHEN OTHERS THEN
            ROLLBACK;
            dbms_output.put_line('Error en Orden ' || rfcuDataOrden.ORDEN ||
                                 ' Error : ' || SQLERRM);
        END;
        --  
      else
        dbms_output.put_line('La Orden ' || rfcuDataOrden.ORDEN ||
                             ' no se anula debido a que su estado no es 0 sino ' ||
                             rfcuDataOrden.estado);
      end if;
    end loop;
  end loop;

END;
