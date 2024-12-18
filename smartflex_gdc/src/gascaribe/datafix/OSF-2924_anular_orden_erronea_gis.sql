column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

  cursor cuListadoOrden is
    select 329128708 orden from dual;

  rfcuListadoOrden cuListadoOrden%rowtype;

  --cursor para DATA de orden 
  cursor cuDataOrden(inuOrden number) is
    select o.order_id ORDEN, o.order_status_id estado
      from open.or_order o
     where o.order_id = inuOrden;

  rfcuDataOrden cuDataOrden%rowtype;

  SBCOMMENT     VARCHAR2(4000) := 'SE ANULA ORDEN ERRONE DE GIS CASO OSF-2924';
  nuCommentType number := 1277;
  nuErrorCode   number;
  sbErrorMesse  varchar2(4000);

BEGIN

  --Recorrer Lsitado de ordenes
  for rfcuListadoOrden in cuListadoOrden loop
  
    --Recorrer DATA de orden 
    for rfcuDataOrden in cuDataOrden(rfcuListadoOrden.Orden) loop
      BEGIN
      
        -- Anulamos la OT
        or_boanullorder.anullorderwithoutval(rfcuDataOrden.ORDEN, SYSDATE);
      
        --/*-- Adicionamos comentario a la OT
        OS_ADDORDERCOMMENT(rfcuDataOrden.ORDEN,
                           nuCommentType,
                           SBCOMMENT,
                           nuErrorCode,
                           sbErrorMesse);
      
        If nuErrorCode = 0 then
          commit;
          dbms_output.put_line('Orden ' || rfcuDataOrden.ORDEN ||
                               ' anulada Ok.');
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
    end loop;
  end loop;

END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/