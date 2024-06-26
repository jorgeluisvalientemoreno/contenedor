declare

  CURSOR cuBodagaTransito IS
    SELECT *
      FROM (SELECT bala.*,
                   NVL((SELECT sum(a.amount) transito_real
                         FROM open.or_uni_item_bala_mov a
                        WHERE a.operating_unit_id = bala.operating_unit_id
                          AND a.items_id = bala.items_id
                          AND a.movement_type = 'N'
                          AND a.item_moveme_caus_id IN (20, 6)
                          AND a.support_document = ' '),
                       0) transito_real
              FROM open.or_ope_uni_item_bala bala)
     WHERE transito_real != transit_in
       AND operating_unit_id = 799;
begin

  dbms_output.put_line('Inicio Validar transito entrada contra transito real Bodega 799');
  ---Recalcular transito entrade de bodega

  FOR rcBodegaTransito IN cuBodagaTransito LOOP
    dbms_output.put_line('Item ' || rcBodegaTransito.items_id);
    dbms_output.put_line('Bodega ' || rcBodegaTransito.operating_unit_id);
    dbms_output.put_line('Transito Real ' ||
                         rcBodegaTransito.transito_real);
    /*UPDATE or_ope_uni_item_bala
       SET transit_in = rcBodegaTransito.transito_real
     WHERE operating_unit_id = rcBodegaTransito.operating_unit_id
       AND items_id = rcBodegaTransito.items_id;
    COMMIT;*/
  
    dbms_output.put_line('--------------------------------------------');
  
  END LOOP;
  dbms_output.put_line('Fin Validar transito entrada contra transito real Bodega 799');
exception
  when others then
    rollback;
    dbms_output.put_line(sqlerrm);
END;
/
