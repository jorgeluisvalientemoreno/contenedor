column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  cursor cuDATAPNO is
    select fpn.possible_ntl_id, fpn.status, fpn.product_id
      from open.fm_possible_ntl fpn
     where fpn.status in ('R', 'P')
       and fpn.product_id in (6113403,
                              51530890,
                              2057963,
                              17005946,
                              1506424,
                              17005932,
                              51606067);

  rfcuDATAPNO cuDATAPNO%rowtype;

begin

  for rfcuDATAPNO in cuDATAPNO loop
  
    begin
      update open.fm_possible_ntl fpn
         set fpn.status = 'N'
       where fpn.possible_ntl_id = rfcuDATAPNO.possible_ntl_id
         and fpn.product_id = rfcuDATAPNO.product_id;
    
      commit;
    
      dbms_output.put_line('Actualizar estado del proyecto PNO ' ||
                           rfcuDATAPNO.possible_ntl_id || ' de estado ' ||
                           rfcuDATAPNO.status ||
                           ' a un nuevo estado N del producto ' ||
                           rfcuDATAPNO.product_id);
    exception
      when others then
        rollback;
        dbms_output.put_line('Error al actualizar estado del proyecto PNO ' ||
                             rfcuDATAPNO.possible_ntl_id || ' de estado ' ||
                             rfcuDATAPNO.status ||
                             ' a un nuevo estado N del producto ' ||
                             rfcuDATAPNO.product_id);
    end;
  
  end loop;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/

