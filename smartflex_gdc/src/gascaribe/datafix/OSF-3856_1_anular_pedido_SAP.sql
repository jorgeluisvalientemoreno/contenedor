column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN

  update OPEN.LDCI_TRANSOMA a
     set a.trsmcont = 4769, a.trsmesta = 4
   where a.trsmcodi = 251399;

  COMMIT;
  dbms_output.put_line('Se anula pedido 251399. Ok.');

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    dbms_output.put_line('No se pudo anular pedido 251399, ' ||
                         sqlerrm);
END;
/

BEGIN

  update OPEN.LDC_RESULT_PROCESS_PEDIDOVENTA a
     set a.comment_ = 'Realiza cambio de estado de 5 a 4 con el caso OSF-3856'
   where a.request_material_id = 251399
     and a.estado_anterior = 5
     and a.estado_nuevo = 4
     and trunc(a.register_date) = trunc(sysdate);

  COMMIT;
  dbms_output.put_line('Se actualiza comentatio del cambio de estado de 5 a 4 del pedido 251399. Ok.');

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    dbms_output.put_line('No se actualiza comentario del cambio de estado de 5 a 4 del pedido 251399, ' ||
                         sqlerrm);
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/