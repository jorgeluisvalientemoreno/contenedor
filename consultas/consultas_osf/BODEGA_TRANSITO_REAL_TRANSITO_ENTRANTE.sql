declare
  cursor cuTransitIn is
    SELECT *
      FROM (SELECT ge_items.items_id,
                   ge_items.description description,
                   ge_items.measure_unit_id,
                   or_ope_uni_item_bala.balance,
                   sum(or_uni_item_bala_mov.amount) TRANSITO_REAL,
                   or_uni_item_bala_mov.operating_unit_id,
                   --or_uni_item_bala_mov.target_oper_unit_id,
                   or_ope_uni_item_bala.transit_in
              FROM open.or_uni_item_bala_mov,
                   open.or_ope_uni_item_bala,
                   open.ge_items_seriado,
                   open.ge_items
             WHERE or_uni_item_bala_mov.items_id = ge_items.items_id
               AND or_uni_item_bala_mov.items_id =
                   or_ope_uni_item_bala.items_id
               AND or_uni_item_bala_mov.operating_unit_id =
                   or_ope_uni_item_bala.operating_unit_id
                  -- AND  or_uni_item_bala_mov.operating_unit_id = inuOperatUniId
               AND or_uni_item_bala_mov.movement_type = 'N'
               AND or_uni_item_bala_mov.item_moveme_caus_id IN
                   (20, --  6
                    6)
               AND or_uni_item_bala_mov.support_document = ' '
               AND or_uni_item_bala_mov.id_items_seriado =
                   ge_items_seriado.id_items_seriado(+)
            
             GROUP BY ge_items.items_id,
                      ge_items.description,
                      ge_items.measure_unit_id,
                      or_ope_uni_item_bala.balance,
                      or_uni_item_bala_mov.operating_unit_id,
                      --or_uni_item_bala_mov.target_oper_unit_id,
                      or_ope_uni_item_bala.transit_in)
     WHERE TRANSITO_REAL != transit_in
       and operating_unit_id = 799;

begin
  for reg in cuTransitIn loop
    begin
      dbms_output.put_line('Item: ' || reg.items_id ||
                           ' - Transtio Real: ' || reg.TRANSITO_REAL);
      /*update or_ope_uni_item_bala
         set transit_in=reg.TRANSITO_REAL
       where items_id=reg.items_id
         and operating_unit_id=reg.operating_unit_id;
      commit;*/
    exception
      when others then
        --rollback;
        dbms_output.put_line(sqlerrm);
    end;
  end loop;
end;
/
