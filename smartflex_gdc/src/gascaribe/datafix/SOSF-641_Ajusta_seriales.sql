column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
  nuMovimiento number;
begin
  --el medidor se encuentra en chatarra con unidad, se le debe remover la unidad
    update ge_items_Seriado
       set operating_unit_id=null
    where id_items_seriado=1930994;

  ---el serial migro de gasplus sin exitencias en bodega, se cambiara a dado de baja

    update ge_items_Seriado   
       set operating_unit_id=null,
           id_items_estado_inv=8
      where id_items_Seriado=1941383;

    -------Cantidad de seriales no cuadra con bodegas, se descuenta cantidad 1 para el serial 
    --serie TGC-449
    update or_ope_uni_item_bala a
       set balance=balance-1
    where a.operating_unit_id=3119 
      and a.items_id=4001217;

  select max(uni_item_bala_mov_id) 
      into nuMovimiento
    from open.or_uni_item_bala_mov
    where items_id=4001217
    and operating_unit_id=3119;

   update open.or_uni_item_bala_mov
      set comments ='SOSF-641',
          id_items_seriado=2026434
     where uni_item_bala_mov_id=nuMovimiento;

-------Cantidad de seriales no cuadra con bodegas, se descuenta cantidad 1 para el serial 
--serie GC-449

  update or_ope_uni_item_bala a
       set balance=balance-1
    where a.operating_unit_id=3119 
      and a.items_id= 4295258 ;

  select max(uni_item_bala_mov_id) 
      into nuMovimiento
    from open.or_uni_item_bala_mov
    where items_id= 4295258 
    and operating_unit_id=3119;

   update open.or_uni_item_bala_mov
      set comments ='SOSF-641',
          id_items_seriado=2026433
     where uni_item_bala_mov_id=nuMovimiento;

-------Cantidad de seriales no cuadra con bodegas, se descuenta cantidad 1 para el serial 
--MA-1121
  update or_ope_uni_item_bala a
       set balance=balance-1
    where a.operating_unit_id=3119 
      and a.items_id= 4295313;

  select max(uni_item_bala_mov_id) 
      into nuMovimiento
    from open.or_uni_item_bala_mov
    where items_id= 4295313
    and operating_unit_id=3119;

   update open.or_uni_item_bala_mov
      set comments ='SOSF-641',
          id_items_seriado=1991598 
     where uni_item_bala_mov_id=nuMovimiento;

-------Cantidad de seriales no cuadra con bodegas, se descuenta cantidad 1 para el serial 
--MA-1224
  update or_ope_uni_item_bala a
       set balance=balance-1
    where a.operating_unit_id=3119 
      and a.items_id= 4295313;

  select max(uni_item_bala_mov_id) 
      into nuMovimiento
    from open.or_uni_item_bala_mov
    where items_id= 4295313
    and operating_unit_id=3119;

   update open.or_uni_item_bala_mov
      set comments ='SOSF-641',
          id_items_seriado=2011630  
     where uni_item_bala_mov_id=nuMovimiento;

-------Cantidad de seriales no cuadra con bodegas, se descuenta cantidad 2 para el serial 
--MA-1094
  update or_ope_uni_item_bala a
       set balance=balance-1
    where a.operating_unit_id=3119 
      and a.items_id= 4295313;

  select max(uni_item_bala_mov_id) 
      into nuMovimiento
    from open.or_uni_item_bala_mov
    where items_id= 4295313
    and operating_unit_id=3119;

   update open.or_uni_item_bala_mov
      set comments ='SOSF-641',
          id_items_seriado=1991559   
     where uni_item_bala_mov_id=nuMovimiento;  

 update or_ope_uni_item_bala a
       set balance=balance-1
    where a.operating_unit_id=3119 
      and a.items_id= 4295313;

  select max(uni_item_bala_mov_id) 
      into nuMovimiento
    from open.or_uni_item_bala_mov
    where items_id= 4295313
    and operating_unit_id=3119;

   update open.or_uni_item_bala_mov
      set comments ='SOSF-641',
          id_items_seriado=1991559   
     where uni_item_bala_mov_id=nuMovimiento;        

-------Cantidad de seriales no cuadra con bodegas, se descuenta cantidad 1 para el serial 
--49100
  update or_ope_uni_item_bala a
       set balance=balance-1
    where a.operating_unit_id=3119 
      and a.items_id= 4294784;

  select max(uni_item_bala_mov_id) 
      into nuMovimiento
    from open.or_uni_item_bala_mov
    where items_id= 4294784
    and operating_unit_id=3119;

   update open.or_uni_item_bala_mov
      set comments ='SOSF-641',
          id_items_seriado=965    
     where uni_item_bala_mov_id=nuMovimiento;     
-------Cantidad de seriales no cuadra con bodegas, se descuenta cantidad 1 para el serial 
-- AL-51282-CO
  update or_ope_uni_item_bala a
       set balance=balance-1
    where a.operating_unit_id=3119 
      and a.items_id= 100003011;

  select max(uni_item_bala_mov_id) 
      into nuMovimiento
    from open.or_uni_item_bala_mov
    where items_id= 100003011
    and operating_unit_id=3119;

   update open.or_uni_item_bala_mov
      set comments ='SOSF-641',
          id_items_seriado=2025577     
     where uni_item_bala_mov_id=nuMovimiento;     




end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/