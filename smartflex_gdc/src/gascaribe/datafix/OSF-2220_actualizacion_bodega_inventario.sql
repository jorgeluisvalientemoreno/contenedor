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
                  (SELECT COUNT(1) FROM OPEN.GE_ITEMS_SERIADO i WHERE i.ITEMS_ID = a.items_id AND i.OPERATING_UNIT_ID = a.operating_unit_id AND i.ID_ITEMS_ESTADO_INV in (1,12,16)) total_real
         FROM     OR_OPE_UNI_ITEM_BALA a, ge_items b
         WHERE   b.items_id = a.ITEMS_ID
         AND     b.items_id like '4%'
      )
      where balance - total_real != 0;
BEGIN

   execute immediate 'alter trigger TRG_OR_UNI_ITEM_BALA_MOV disable';

   FOR rcSaldoBodega IN cuPoblación LOOP
      dbms_output.put_line('Unidad Operativa: '||rcSaldoBodega.operating_unit_id);
      dbms_output.put_line('Item: '||rcSaldoBodega.items_id);
      dbms_output.put_line('Total Bodega: '||rcSaldoBodega.balance);
      dbms_output.put_line('Total Real: '||rcSaldoBodega.total_real);

      BEGIN
         update or_ope_uni_item_bala a
         set balance=rcSaldoBodega.total_real
         where a.operating_unit_id=rcSaldoBodega.operating_unit_id
         and a.items_id=rcSaldoBodega.items_id;

         COMMIT;

      EXCEPTION
      WHEN OTHERS THEN
         rollback;
      END;


      dbms_output.put_line('Bodega Actualizada correctamente: '||rcSaldoBodega.operating_unit_id);
   END LOOP; 

    COMMIT;

    execute immediate 'alter trigger TRG_OR_UNI_ITEM_BALA_MOV enable';
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/