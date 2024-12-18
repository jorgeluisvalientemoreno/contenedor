DECLARE

  --cursor para Anular ordenes de contratos definidos del CASO 100-82555 de la solicitude de venta a construtora 25892909.
  cursor cuproductopenins is
    select ooa.package_id, ooa.product_id PRODUCTO, ooa.order_id ORDEN
      from open.Or_Order_Activity ooa, open.or_order o, open.ge_causal c
     where ooa.package_id in (184819085)
       and ooa.task_type_id = 12162
       and ooa.order_id = o.order_id
       and o.causal_id = c.causal_id
       and c.class_causal_id = 1;

  rfcuproductopenins cuproductopenins%rowtype;

  --Comentario de orden 
  -- Registro de Comentario de la orden
  rcOR_ORDER_COMMENT open.daor_order_comment.styor_order_comment;

  nuPersonID open.ge_person.person_id%type;
  nuInfomrGen constant open.or_order_comment.comment_type_id%type := 1277; -- INFORMACION GENERAL


  SBCOMMENT       VARCHAR2(4000) := 'SE QUITA LA ASOCIACION A LA SOLICITUD 184819085 SEGUN EL CASO OSF-512';
  nuCommentType   number:=1277;
  nuErrorCode     number;
  sbErrorMesse    varchar2(4000);
  
BEGIN

  dbms_output.put_line('*********** Codigo Tipo Comentario[' || nuInfomrGen || ']');
  dbms_output.put_line('*********** Fecha sistema[' || open.pkgeneralservices.fdtgetsystemdate || ']');
  dbms_output.put_line('*********** Person ID[' || nuPersonID || ']');
  --*/

    -- Recorre ordenes de la solicitud
    For rfcuproductopenins in cuproductopenins loop
      --/*
      dbms_output.put_line('************* ORDEN [' ||
                           rfcuproductopenins.ORDEN || ']');
      --*/    
		  Begin
		    OS_ADDORDERCOMMENT (rfcuproductopenins.ORDEN, nuCommentType, SBCOMMENT, nuErrorCode, sbErrorMesse);       
            --
        If nuErrorCode <> 0 then
          dbms_output.put_line('Error Orden ' || rfcuproductopenins.ORDEN);
          rollback;
        Else
          -- Quita la solicitud de la orden
          update open.or_order_activity a
             set a.package_id = null
           where order_id = rfcuproductopenins.ORDEN; 
          --       
          commit;
          --
        End if;
      --
      Exception
        when others then
          dbms_output.put_line('Error Orden ' || rfcuproductopenins.ORDEN);
          rollback;
      End;
      --
    End loop;
  
    dbms_output.put_line('Fin de Proceso');

END;
/
