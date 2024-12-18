column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
DECLARE

    --cursor para validar la solicitud.
    cursor cuOrdenes is
      select o.order_id ORDEN 
        from open.or_order o
       where o.order_id in (311428750) ;

    
    -- Cursor para validar que la OT no este en acta
    cursor cuacta(nuorden number) is
      select d.id_acta
        from open.ge_detalle_acta d
       where d.id_orden = nuorden
         and rownum = 1;

    rfcuOrdenes cuOrdenes%rowtype;

    --Comentario de orden 
    -- Registro de Comentario de la orden
    rcOR_ORDER_COMMENT open.daor_order_comment.styor_order_comment;

    nuPersonID open.ge_person.person_id%type;
    nuInfomrGen constant open.or_order_comment.comment_type_id%type := 1277; -- INFORMACION GENERAL

    SBCOMMENT       VARCHAR2(4000) := 'SE CAMBIA La DIRECCIÓN DE LA ORDEN CASO OSF-2413';
    nuCommentType   number:=1277;
    nuErrorCode     number;
    sbErrorMesse    varchar2(4000);
    nuacta          number;
    
  BEGIN

    --Recorrer ordenes a modificar
    for rfcuOrdenes in cuOrdenes loop
      -- Validamos que no este en acta
      if cuacta%isopen then
        close cuacta;
      end if;
      --
      open cuacta(rfcuOrdenes.ORDEN);
      fetch cuacta into nuacta;
      close cuacta;
      --
      If nuacta is not null then
        dbms_output.put_line('Orden esta en acta ' || rfcuOrdenes.ORDEN || ' Acta : ' || nuacta);
      Else
        BEGIN

          UPDATE or_order SET EXTERNAL_ADDRESS_ID = 210 WHERE  order_id = rfcuOrdenes.ORDEN;  

          dbms_output.put_line('Actualiza la tabla or_order con order_id [' || rfcuOrdenes.ORDEN ||']');        
          
          UPDATE or_order_activity SET ADDRESS_ID = 210 WHERE  order_id = rfcuOrdenes.ORDEN; 

          dbms_output.put_line('Actualiza la tabla or_order_activity con order_id [' || rfcuOrdenes.ORDEN ||']');        
          
          UPDATE OR_EXTERN_SYSTEMS_ID SET ADDRESS_ID = 210 WHERE  order_id = rfcuOrdenes.ORDEN;

          dbms_output.put_line('Actualiza la tabla OR_EXTERN_SYSTEMS_ID con order_id [' || rfcuOrdenes.ORDEN ||']');        
          
          COMMIT;
          --
        EXCEPTION
          WHEN OTHERS THEN
            ROLLBACK;
            dbms_output.put_line('Error en Orden ' || rfcuOrdenes.ORDEN || ' Error : ' || SQLERRM);
        END;
      --  
      End if;
      --
    end loop;
    
    dbms_output.put_line('Fin de Proceso');

  END;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/