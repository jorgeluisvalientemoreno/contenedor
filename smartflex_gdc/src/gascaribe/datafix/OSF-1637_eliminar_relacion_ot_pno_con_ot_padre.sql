column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  sbCadenaFinal     varchar2(4000);
  nuEstadoOTout     number;
  Cantidad          number;
  nuOTPadrePNO      number;
  nuTipoTrabajoHijo number;
  nuExisteOTHija    number := 0;

  cursor cuDATAPNO is
    select oro.order_id, oro.related_order_id
      from open.or_related_order oro
     where oro.related_order_id in
           (select fpn.order_id
              from open.fm_possible_ntl fpn
             where fpn.status in ('R', 'P'));

  rfcuDATAPNO cuDATAPNO%rowtype;

begin

  for rfcuDATAPNO in cuDATAPNO loop
  
    begin
      delete from open.or_related_order oro
       where oro.related_order_id = rfcuDATAPNO.related_order_id;
      commit;
    
      dbms_output.put_line('Eliminar relacion de orden padre ' ||
                           rfcuDATAPNO.order_id || ' con orden hija ' ||
                           rfcuDATAPNO.related_order_id);
    exception
      when others then
        rollback;
        dbms_output.put_line('Error al eliminar relacion de orden padre ' ||
                             rfcuDATAPNO.order_id || ' con orden hija ' ||
                             rfcuDATAPNO.related_order_id);
    end;
  
  end loop;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/

