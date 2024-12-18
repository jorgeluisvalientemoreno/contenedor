column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
    CURSOR cuBodagaTransito
    IS
    SELECT  * 
    FROM (
            SELECT  bala.*,
                    NVL((
                        SELECT  sum(a.amount) transito_real
                        FROM    or_uni_item_bala_mov a
                        WHERE  a.operating_unit_id = bala.operating_unit_id
                        AND    a.items_id = bala.items_id
                        AND  a.movement_type = 'N'
                        AND  a.item_moveme_caus_id IN  (20, 6)
                        AND  a.support_document = ' '
                    ) , 0) transito_real
            FROM    or_ope_uni_item_bala bala
    )
    WHERE transito_real != transit_in  
    AND operating_unit_id = 3343 ;
BEGIN
  dbms_output.put_line('Inicio Datafix 2631');

  FOR rcBodegaTransito IN cuBodagaTransito LOOP
      dbms_output.put_line('Item '||rcBodegaTransito.items_id);
      dbms_output.put_line('Bodega '||rcBodegaTransito.operating_unit_id);
      UPDATE  or_ope_uni_item_bala
      SET     transit_in = rcBodegaTransito.transito_real
      WHERE   operating_unit_id = rcBodegaTransito.operating_unit_id
      AND     items_id = rcBodegaTransito.items_id;

      dbms_output.put_line('Fin Actualización Bodega '||rcBodegaTransito.operating_unit_id);
  END LOOP;
  COMMIT;

  dbms_output.put_line('FIN Datafix 2631');
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/