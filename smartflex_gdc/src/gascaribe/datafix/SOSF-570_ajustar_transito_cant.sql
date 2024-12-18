column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  update ge_items_seriado
     set id_items_estado_inv=3,
         operating_unit_id=799
  where id_items_seriado=2004825;
  commit;
end;
/
declare
  cursor cuTransitIn is
  SELECT * FROM
(SELECT
    ge_items.items_id,
    ge_items.description description,
    ge_items.measure_unit_id,
    or_ope_uni_item_bala.balance,
    sum(or_uni_item_bala_mov.amount) TRANSITO_REAL,
    or_uni_item_bala_mov.operating_unit_id,
    --or_uni_item_bala_mov.target_oper_unit_id,
    or_ope_uni_item_bala.transit_in
FROM  or_uni_item_bala_mov,
        or_ope_uni_item_bala,
        ge_items_seriado,
        ge_items
 WHERE  or_uni_item_bala_mov.items_id = ge_items.items_id
   AND  or_uni_item_bala_mov.items_id = or_ope_uni_item_bala.items_id
   AND  or_uni_item_bala_mov.operating_unit_id = or_ope_uni_item_bala.operating_unit_id
   -- AND  or_uni_item_bala_mov.operating_unit_id = inuOperatUniId
   AND  or_uni_item_bala_mov.movement_type = 'N'
   AND  or_uni_item_bala_mov.item_moveme_caus_id
    IN  (   20,       --  6
            6
        )
   AND  or_uni_item_bala_mov.support_document = ' '
   AND  or_uni_item_bala_mov.id_items_seriado = ge_items_seriado.id_items_seriado (+)
   
   
   GROUP BY         ge_items.items_id,
    ge_items.description ,
    ge_items.measure_unit_id,
    or_ope_uni_item_bala.balance,
    or_uni_item_bala_mov.operating_unit_id,
    --or_uni_item_bala_mov.target_oper_unit_id,
    or_ope_uni_item_bala.transit_in
    ) WHERE TRANSITO_REAL != transit_in
      and operating_unit_id=799;
      
      
begin
  for reg in cuTransitIn loop
      begin
          update or_ope_uni_item_bala
            set transit_in=reg.TRANSITO_REAL
          where items_id=reg.items_id
            and operating_unit_id=reg.operating_unit_id;
         commit;
      exception
        when others then
          rollback;
          dbms_output.put_line(sqlerrm);
      end;
  end loop;
end;
/
  

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/