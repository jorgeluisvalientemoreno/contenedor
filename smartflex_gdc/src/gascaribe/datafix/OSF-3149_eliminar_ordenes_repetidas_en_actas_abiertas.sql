column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  cursor cuActa is
    select coc.certificate_id Acta_Abierta, coc.order_id Orden_Repetida
      from OPEN.CT_ORDER_CERTIFICA coc, open.ge_acta ga
     where ga.id_acta = coc.certificate_id
       and ga.estado = 'A'
       and coc.order_id in
           (select a.order_id
              from OPEN.CT_ORDER_CERTIFICA a
             where a.certificate_id = 229390
               and a.order_id = coc.order_id);

  rfActa cuActa%rowtype;

begin

  for rfActa in cuActa loop
  
    begin
      delete OPEN.CT_ORDER_CERTIFICA coc
       where coc.order_id = rfActa.Orden_Repetida
         and coc.certificate_id = rfActa.Acta_Abierta;
         
      delete OPEN.ge_detalle_acta gda
       where gda.id_orden = rfActa.Orden_Repetida
         and gda.id_acta = rfActa.Acta_Abierta;
    
      commit;
    
      dbms_output.put_line('Se elimino orden: ' || rfActa.Orden_Repetida ||
                           ' relacionada al acta abierta: ' ||
                           rfActa.Acta_Abierta);
    
    exception
      when others then
        rollback;
        dbms_output.put_line('Error al eliminar orden: ' ||
                             rfActa.Orden_Repetida ||
                             ' relacionada al acta abierta: ' ||
                             rfActa.Acta_Abierta || ' - Error: ' ||
                             sqlerrm);
    end;
  
  end loop;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/