column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
execute immediate 'alter trigger TRG_VALIDABODEGA  disable';

------------------------------------------------------------------
update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=120292
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='0'
 where m.id_items_documento=120292
   and m.movement_type='N'
   and m.id_items_seriado=1814;
   
------------------------------------------------------------------   
update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=153993
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='0'
 where m.id_items_documento=153993
   and m.movement_type='N'
   and m.id_items_seriado=1686;
   
------------------------------------------------------------------   
update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=202650
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='0'
 where m.id_items_documento=202650
   and m.movement_type='N'
   and m.id_items_seriado=791; 
   
------------------------------------------------------------------
update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=203171
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='0'
 where m.id_items_documento=203171
   and m.movement_type='N'
   and m.id_items_seriado in (289, 290, 291, 305); 
------------------------------------------------------------------

update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=204814
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='0'
 where m.id_items_documento=204814
   and m.movement_type='N'
   and m.id_items_seriado =2043402; 
------------------------------------------------------------------

update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=241518
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='0'
 where m.id_items_documento=241518
   and m.movement_type='N'
   and m.id_items_seriado =1703; 
------------------------------------------------------------------

update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=243981
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='0'
 where m.id_items_documento=243981
   and m.movement_type='N'
   and m.id_items_seriado =752; 
------------------------------------------------------------------
update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=252302
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='0'
 where m.id_items_documento=252302
   and m.movement_type='N'
   and m.id_items_seriado =1979865; 
------------------------------------------------------------------
update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=287479
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='0'
 where m.id_items_documento=287479
   and m.movement_type='N'
   and m.id_items_seriado =1993709; 
------------------------------------------------------------------
update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=293487
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='0'
 where m.id_items_documento=293487
   and m.movement_type='N'
   and m.id_items_seriado =1988848; 
------------------------------------------------------------------
update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=315007
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='0'
 where m.id_items_documento=315007
   and m.movement_type='N'
   and m.id_items_seriado =793; 
------------------------------------------------------------------

update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=408905
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='0'
 where m.id_items_documento=408905
   and m.movement_type='N'
   and m.id_items_seriado =2031901; 
------------------------------------------------------------------
update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=414141
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='0'
 where m.id_items_documento=414141
   and m.movement_type='N'
   and m.id_items_seriado in (2129015,2129016,2129021,2130153,2130159,2130163,2130170,2130179,
                              2130177,2067135,2067146,2133909,2145225,2120265,2145236); 
------------------------------------------------------------------
update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=415742
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='0'
 where m.id_items_documento=415742
   and m.movement_type='N'
   and m.id_items_seriado =2043399; 
------------------------------------------------------------------
update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=415742
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='0'
 where m.id_items_documento=415742
   and m.movement_type='N'
   and m.id_items_seriado =2043399;
------------------------------------------------------------------
update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=443851
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='0'
 where m.id_items_documento=443851
   and m.movement_type='N'
   and m.id_items_seriado =1920;
------------------------------------------------------------------
update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=450832
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='452506'
 where m.id_items_documento=450832
   and m.movement_type='N'
   and m.id_items_seriado =2009970;
------------------------------------------------------------------
update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=452479
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='452525'
 where m.id_items_documento=452479
   and m.movement_type='N'
   and m.id_items_seriado =2112670;
------------------------------------------------------------------
update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=469707
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='469922'
 where m.id_items_documento=469707
   and m.movement_type='N'
   and m.id_items_seriado in (1920, 2070205);
   
update or_uni_item_bala_mov m
   set m.support_document ='0'
 where m.id_items_documento=469707
   and m.movement_type='N'
   and m.id_items_seriado in (2043402, 2074284,1978473);
   
update or_uni_item_bala_mov m
   set m.support_document ='469925'
 where m.id_items_documento=469707
   and m.movement_type='N'
   and m.id_items_seriado in (2063276);      
------------------------------------------------------------------
update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=469708
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='469925'
 where m.id_items_documento=469708
   and m.movement_type='N'
   and m.id_items_seriado =2140578;
------------------------------------------------------------------
update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=470593
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='0'
 where m.id_items_documento=470593
   and m.movement_type='N'
   and m.id_items_seriado =2062694;
------------------------------------------------------------------
update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=470664
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='0'
 where m.id_items_documento=470664
   and m.movement_type='N'
   and m.id_items_seriado =2171360;
------------------------------------------------------------------ 
update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=522045
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='522165'
 where m.id_items_documento=522045
   and m.movement_type='N'
   and m.id_items_seriado =2011995;
------------------------------------------------------------------
update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=522182
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='522196'
 where m.id_items_documento=522182
   and m.movement_type='N'
   and m.id_items_seriado =1950;
------------------------------------------------------------------
update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=610992
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='611034'
 where m.id_items_documento=610992
   and m.movement_type='N'
   and m.id_items_seriado =2177475;
------------------------------------------------------------------
update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=620337
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='621117'
 where m.id_items_documento=620337
   and m.movement_type='N'
   and m.id_items_seriado in (1988825,1988829,2147789);
------------------------------------------------------------------
update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=681588
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='681674'
 where m.id_items_documento=681588
   and m.movement_type='N'
   and m.id_items_seriado =1988834;
------------------------------------------------------------------
update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=706518
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='0'
 where m.id_items_documento=706518
   and m.movement_type='N'
   and m.id_items_seriado =2246751;
------------------------------------------------------------------
update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=1042973
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='1189736'
 where m.id_items_documento=1042973
   and m.movement_type='N'
   and m.id_items_seriado =1987304;
------------------------------------------------------------------
update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=1107794
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='1108290'
 where m.id_items_documento=1107794
   and m.movement_type='N'
   and m.id_items_seriado =1993703;
------------------------------------------------------------------  

update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=1130997
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='1131298'
 where m.id_items_documento=1130997
   and m.movement_type='N'
   and m.id_items_seriado =2163703;
------------------------------------------------------------------

update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=1150798
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='1153767'
 where m.id_items_documento=1150798
   and m.movement_type='N'
   and m.id_items_seriado =1988835;
------------------------------------------------------------------

update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=1157189
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='0'
 where m.id_items_documento=1157189
   and m.movement_type='N'
   and m.id_items_seriado in (1260,2455);
------------------------------------------------------------------
update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=1173588
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='1173783'
 where m.id_items_documento=1173588
   and m.movement_type='N'
   and m.id_items_seriado =2257; 
------------------------------------------------------------------

update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=1179044
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='1179118'
 where m.id_items_documento=1179044
   and m.movement_type='N'
   and m.id_items_seriado in (2252101, 2252102); 
------------------------------------------------------------------

update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=1186513
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='0'
 where m.id_items_documento=1186513
   and m.movement_type='N'
   and m.id_items_seriado =2074533;
------------------------------------------------------------------

update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=1188966
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='0'
 where m.id_items_documento=1188966
   and m.movement_type='N'
   and m.id_items_seriado in (2273597, 2435816, 2273601);
------------------------------------------------------------------
update open.ge_items_documento d
   set d.estado='C',
       d.comentario='SE CAMBIA ESTADO DE A C POR CASO SOSF-570'
where d.id_items_documento=1194660
  and d.estado='A';
update or_uni_item_bala_mov m
   set m.support_document ='0'
 where m.id_items_documento=1194660
   and m.movement_type='N'
   and m.id_items_seriado in (2233004);
------------------------------------------------------------------
------------------------------------------------------------------
------------------------------------------------------------------
------------------------------------------------------------------
------------------------------------------------------------------
------------------------------------------------------------------
------------------------------------------------------------------
------------------------------------------------------------------
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