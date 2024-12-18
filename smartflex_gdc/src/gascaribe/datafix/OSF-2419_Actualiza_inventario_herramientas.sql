column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

    CURSOR cuPoblacion
    IS
    SELECT u.operating_unit_id,
          u.name,
          i.items_id,
          i.description,
          i.item_classif_id,
          b.balance,
          b.quota,
          b.total_costs
    FROM or_ope_uni_item_bala b
    inner join ge_items i on i.items_id=b.items_id and i.item_classif_id=3
    inner join or_operating_unit u on u.operating_unit_id=b.operating_unit_id
    WHERE b.total_costs>0;

    rfcuPoblacion cuPoblacion%rowtype;

    CURSOR cuMovimiento
    (
        inuBodega   IN OR_OPE_UNI_ITEM_BALA.OPERATING_UNIT_ID%TYPE,
        inuItemId    IN or_uni_item_Bala_mov.items_id%TYPE
    )
    IS
    SELECT *
    FROM or_uni_item_Bala_mov m
    WHERE operating_unit_id= inuBodega 
    AND item_moveme_caus_id=-1
    AND items_id =  inuItemId
    AND  trunc(move_date) = trunc(sysdate)
    AND id_items_seriado is null
    AND id_items_documento is null;

    rcMovimiento or_uni_item_Bala_mov%ROWTYPE;
    rcMovimientoNulo or_uni_item_Bala_mov%ROWTYPE;
BEGIN

    FOR rfcuPoblacion in cuPoblacion LOOP

        dbms_output.put_line('Unidad Operativa: ' || rfcuPoblacion.operating_unit_id ||
                           'Item: '||rfcuPoblacion.items_id ||
                            ' - Costo Total: ' || rfcuPoblacion.total_costs);

        rcMovimiento := rcMovimientoNulo;

        BEGIN
          
          
          UPDATE or_ope_uni_item_bala 
          SET    total_costs = 0
          WHERE  operating_unit_id = rfcuPoblacion.operating_unit_id
          AND    items_id = rfcuPoblacion.items_id;

          dbms_output.put_line('Actualiza Bodega Unidad Operativa: ' || rfcuPoblacion.operating_unit_id );

          OPEN cuMovimiento(rfcuPoblacion.operating_unit_id,rfcuPoblacion.items_id);
          FETCH  cuMovimiento INTO rcMovimiento;
          CLOSE cuMovimiento;

          UPDATE or_uni_item_Bala_mov
          SET comments = 'Se Elimana el costo por caso OSF-2419'
          WHERE uni_item_bala_mov_id = rcMovimiento.uni_item_bala_mov_id; 

          UPDATE ldc_inv_ouib 
          SET    total_costs = 0
          WHERE  operating_unit_id = rfcuPoblacion.operating_unit_id
          AND    items_id = rfcuPoblacion.items_id;

          IF sql%rowcount=0 THEN
            insert into ldc_inv_ouib (ITEMS_ID,OPERATING_UNIT_ID,QUOTA,BALANCE,TOTAL_COSTS,OCCACIONAL_QUOTA,TRANSIT_IN,TRANSIT_OUT)
            values(rfcuPoblacion.items_id, rfcuPoblacion.operating_unit_id, rfcuPoblacion.QUOTA,rfcuPoblacion.balance, 0, 0,null,null);
          END IF;

          dbms_output.put_line('Actualiza Inventario Unidad Operativa: ' || rfcuPoblacion.operating_unit_id );

          DELETE FROM ldc_act_ouib
          WHERE  operating_unit_id = rfcuPoblacion.operating_unit_id
          AND    items_id = rfcuPoblacion.items_id;

          dbms_output.put_line('Borra Activo Unidad Operativa: ' || rfcuPoblacion.operating_unit_id );

          commit;

        
        EXCEPTION
          WHEN others THEN
            dbms_output.put_line('Error actualizando data unidad: ' ||
                                rfcuPoblacion.operating_unit_id || sqlerrm);
            rollback;
        END;
  
  END LOOP;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/