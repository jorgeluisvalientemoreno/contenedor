column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
execute immediate 'alter trigger TRG_VALIDABODEGA  disable';
execute immediate 'alter trigger LDCTRGBUDI_OR_UIBM  disable';
------------------------------------------------------------------

update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=119880
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='0'
 where m.id_items_documento=119880
   and m.movement_type='N'
   and m.id_items_seriado=1813;
   
   
------------------------------------------------------------------   

update ge_items_seriado
   set id_items_estado_inv=3,
       operating_unit_id=799
  where id_items_seriado in (2044, 1978471,1978471,2043,321,
                            293,2010526, 1997729,1997726, 2043410,
                            646,1701);
   
   
------------------------------------------------------------------   

update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=292699
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='0'
 where m.id_items_documento=292699
   and m.movement_type='N'
   and m.id_items_seriado in (2069, 2056);



------------------------------------------------------------------   

update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=334112
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='335281'
 where m.id_items_documento=334112
   and m.movement_type='N'
   and m.id_items_seriado in (2031912);
   
------------------------------------------------------------------   

update ge_items_seriado
   set id_items_estado_inv=3,
       operating_unit_id=799
  where id_items_seriado in (2044, 1978471,1978471,2043,321,
                            293,2010526, 1997729,1997726, 2043410,
                            646,1701);
   
   
------------------------------------------------------------------   

update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=334142
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='0'
 where m.id_items_documento=334142
   and m.movement_type='N'
   and m.id_items_seriado in (1978468);

   
   

commit;
execute immediate 'alter trigger TRG_VALIDABODEGA  enable';  
execute immediate 'alter trigger LDCTRGBUDI_OR_UIBM  enable';
exception
  when others then rollback;
  execute immediate 'alter trigger TRG_VALIDABODEGA  enable'; 
  execute immediate 'alter trigger LDCTRGBUDI_OR_UIBM  enable';
  dbms_output.put_line(sqlerrm);
       
end;
/
  

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/