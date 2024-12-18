column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  CURSOR cuBodagaTransito IS
    select *
      from (SELECT b.operating_unit_id,
                   b.items_id,
                   t.description,
                   nvl(transito_real, 0) transito_real,
                   nvl(b.transit_out, 0) transit_out
              FROM open.or_ope_uni_item_bala b
              left join (SELECT ge_items.items_id,
                               ge_items.description description,
                               ge_items.measure_unit_id,
                               sum(nvl(or_uni_item_bala_mov.amount, 0)) TRANSITO_REAL,
                               or_uni_item_bala_mov.target_oper_unit_id
                          FROM open.or_uni_item_bala_mov,
                               open.ge_items_seriado,
                               open.ge_items
                         WHERE or_uni_item_bala_mov.items_id =
                               ge_items.items_id
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
                                  or_uni_item_bala_mov.target_oper_unit_id) t
                on t.target_oper_unit_id = b.operating_unit_id
               and t.items_id = b.items_id)
     where transit_out != TRANSITO_REAL;

begin

  ---Recalcular transito entrade de bodega

  FOR rcBodegaTransito IN cuBodagaTransito LOOP
    BEGIN
      UPDATE or_ope_uni_item_bala
         SET transit_out = rcBodegaTransito.transito_real
       WHERE operating_unit_id = rcBodegaTransito.operating_unit_id
         AND items_id = rcBodegaTransito.items_id;
      COMMIT;
      dbms_output.put_line('Se actualiza bodega de la unidad operativa [' ||
                           rcBodegaTransito.operating_unit_id ||
                           '] con el Item [' || rcBodegaTransito.items_id ||
                           '] con transito el trasito de salida real [' ||
                           rcBodegaTransito.transito_real ||
                           '] reemplazando el transito de salida existente [' ||
                           rcBodegaTransito.transit_out || ']');
    
    exception
      when others then
        rollback;
        dbms_output.put_line('Error: ' || sqlerrm);
    END;
  END LOOP;

END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/
