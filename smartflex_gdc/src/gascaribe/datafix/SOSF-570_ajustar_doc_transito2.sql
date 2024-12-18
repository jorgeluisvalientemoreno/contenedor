column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
execute immediate 'alter trigger TRG_VALIDABODEGA  disable';

------------------------------------------------------------------

update or_uni_item_bala_mov m
   set m.support_document ='0'
 where m.id_items_documento=414141
   and m.movement_type='N'
   and m.id_items_seriado=2145228;
   
------------------------------------------------------------------   

update or_uni_item_bala_mov m
   set m.support_document ='469922'
 where m.id_items_documento=469707
   and m.movement_type='N'
   and m.id_items_seriado=2031910;
   
------------------------------------------------------------------   

commit;
execute immediate 'alter trigger TRG_VALIDABODEGA  enable';  
exception
  when others then rollback;
  execute immediate 'alter trigger TRG_VALIDABODEGA  enable'; 
  dbms_output.put_line(sqlerrm);
       
end;
/
  

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/