column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
DECLARE

    --cursor para Anular ordenes de trabajo
    cursor cuOrdenesAnular is
      select o.order_id ORDEN 
        from open.or_order o
       where o.order_id in (284372834,284372870,284372875);

    
    -- Cursor para validar que la OT no este en acta
    cursor cuacta(nuorden number) is
      select d.id_acta
        from open.ge_detalle_acta d
       where d.id_orden = nuorden
         and rownum = 1;

    rfcuOrdenesAnular cuOrdenesAnular%rowtype;

    --Comentario de orden 
    -- Registro de Comentario de la orden
    rcOR_ORDER_COMMENT open.daor_order_comment.styor_order_comment;

    nuPersonID open.ge_person.person_id%type;
    nuInfomrGen constant open.or_order_comment.comment_type_id%type := 1277; -- INFORMACION GENERAL

    SBCOMMENT       VARCHAR2(4000) := 'SE ANULA ORDEN SEGUN CASO OSF-1106';
    nuCommentType   number:=1277;
    nuErrorCode     number;
    sbErrorMesse    varchar2(4000);
    nuacta          number;
    
  BEGIN

    --Recorrer ordenes de trabjo
    for rfcuOrdenesAnular in cuOrdenesAnular loop
      -- Validamos que no este en acta
      if cuacta%isopen then
        close cuacta;
      end if;
      --
      open cuacta(rfcuOrdenesAnular.ORDEN);
      fetch cuacta into nuacta;
      close cuacta;
      --
      If nuacta is not null then
        dbms_output.put_line('Orden esta en acta ' || rfcuOrdenesAnular.ORDEN || ' Acta : ' || nuacta);
      Else
        BEGIN
          -- Anulamos la OT
          or_boanullorder.anullorderwithoutval(rfcuOrdenesAnular.ORDEN,SYSDATE);
          -- Borramos de la tabla de comisiones si allí esta 
          delete open.ldc_pkg_or_item o 
           where o.order_id = rfcuOrdenesAnular.ORDEN;
          -- Adicionamos comentario a la OT
          OS_ADDORDERCOMMENT (rfcuOrdenesAnular.ORDEN, nuCommentType, SBCOMMENT, nuErrorCode, sbErrorMesse);       
          --
          If nuErrorCode = 0 then
             commit;
          Else
             rollback;
             dbms_output.put_line('Error en Orden ' || rfcuOrdenesAnular.ORDEN || ' Error : ' || sbErrorMesse);
          End if;           
          --
        EXCEPTION
          WHEN OTHERS THEN
            ROLLBACK;
            dbms_output.put_line('Error en Orden ' || rfcuOrdenesAnular.ORDEN || ' Error : ' || SQLERRM);
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