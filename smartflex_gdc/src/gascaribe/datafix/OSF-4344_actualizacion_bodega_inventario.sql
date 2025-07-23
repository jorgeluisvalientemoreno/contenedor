column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

      CURSOR cuPoblación
      IS
      SELECT * FROM 
      (
         SELECT   a.items_id,
                  a.operating_unit_id,
                  a.balance,
                  a.total_costs,
                  (SELECT COUNT(1) FROM GE_ITEMS_SERIADO i WHERE i.ITEMS_ID = a.items_id AND i.OPERATING_UNIT_ID = a.operating_unit_id AND i.ID_ITEMS_ESTADO_INV in (1,12,16)) total_real
         FROM     OR_OPE_UNI_ITEM_BALA a, ge_items b
         WHERE   b.items_id = a.ITEMS_ID
         AND     a.operating_unit_id = 3007
         AND     b.items_id in (10004143,10004144)
      )
      where balance - total_real != 0;

      CURSOR cuItems
      (
         inuUnidadOperativa IN GE_ITEMS_SERIADO.OPERATING_UNIT_ID%TYPE,
         inuItems           IN GE_ITEMS_SERIADO.items_id%TYPE
      )
      IS
      SELECT *
      FROM  GE_ITEMS_SERIADO i 
      WHERE i.ITEMS_ID = inuItems
      AND i.OPERATING_UNIT_ID = inuUnidadOperativa
      AND i.ID_ITEMS_ESTADO_INV in (1,12,16);

    CURSOR cuMovimiento
    (
        inuBodega   IN OR_OPE_UNI_ITEM_BALA.OPERATING_UNIT_ID%TYPE,
        inuItemId    IN or_uni_item_Bala_mov.items_id%TYPE
    )
    IS
    SELECT *
    FROM or_uni_item_Bala_mov m
    WHERE operating_unit_id= inuBodega --3551
    AND item_moveme_caus_id=-1
    AND items_id =  inuItemId
    AND  trunc(move_date) = trunc(sysdate)
    AND id_items_seriado is null;

      rcMovimiento or_uni_item_Bala_mov%ROWTYPE;
      rcMovimientoNulo or_uni_item_Bala_mov%ROWTYPE;
BEGIN
   dbms_output.put_line('Inicia OSF-4344');

   FOR rcSaldoBodega IN cuPoblación LOOP
      dbms_output.put_line('Unidad Operativa: '||rcSaldoBodega.operating_unit_id);
      dbms_output.put_line('Item: '||rcSaldoBodega.items_id);
      dbms_output.put_line('Total Bodega: '||rcSaldoBodega.balance);
      dbms_output.put_line('Total Real: '||rcSaldoBodega.total_real);

      FOR reg IN cuItems(rcSaldoBodega.operating_unit_id,rcSaldoBodega.items_id) LOOP
         rcMovimiento := rcMovimientoNulo;
         BEGIN
            UPDATE   or_ope_uni_item_bala a
            SET      a.balance= a.balance+1
            WHERE    a.operating_unit_id = reg.operating_unit_id
            AND      a.items_id = reg.items_id;

            OPEN cuMovimiento (reg.OPERATING_UNIT_ID, reg.ITEMS_ID);
            FETCH cuMovimiento INTO rcMovimiento;
            CLOSE cuMovimiento;

            UPDATE or_uni_item_Bala_mov
            SET COMMENTS =  'Actualización por caso OSF-4344',
               id_items_seriado = reg.id_items_seriado
            WHERE item_moveme_caus_id = rcMovimiento.item_moveme_caus_id
            AND OPERATING_UNIT_ID = rcMovimiento.OPERATING_UNIT_ID
            AND items_id =  reg.ITEMS_ID
            AND  trunc(move_date) = trunc(sysdate)
            AND id_items_seriado is null;

         EXCEPTION
         WHEN OTHERS THEN
            rollback;
         END;
      END LOOP;

      dbms_output.put_line('Inicia OSF-4344');

      dbms_output.put_line('Bodega Actualizada correctamente: '||rcSaldoBodega.operating_unit_id);
   END LOOP; 

   COMMIT;

END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/