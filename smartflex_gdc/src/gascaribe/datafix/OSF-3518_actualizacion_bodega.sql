column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
    CURSOR cuBalanceItem 
    (
        inuItemId   IN OR_OPE_UNI_ITEM_BALA.ITEMS_ID%TYPE,
        inuBodega   IN OR_OPE_UNI_ITEM_BALA.OPERATING_UNIT_ID%TYPE
    )
    IS
    SELECT  *
    FROM    OR_OPE_UNI_ITEM_BALA
    WHERE   ITEMS_ID = inuItemId
    AND     OPERATING_UNIT_ID = inuBodega;


    CURSOR cuDesblance 
    IS
	SELECT *
    FROM or_uni_item_Bala_mov m
    WHERE operating_unit_id=3503
    AND items_id in ( 10002017)
    AND movement_type='I'
    AND item_moveme_caus_id = 28
    AND not exists(select null from open.or_uni_item_bala_mov m2 where m2.id_items_seriado=m.id_items_seriado and m2.operating_unit_id=m.operating_unit_id and m2.movement_type='D' and m2.items_id=m.items_id
    AND  m2.move_date>m.move_date);
    
    CURSOR cuMovimiento
    (
        inuBodega   IN OR_OPE_UNI_ITEM_BALA.OPERATING_UNIT_ID%TYPE,
        inuItemId    IN or_uni_item_Bala_mov.items_id%TYPE
    )
    IS
    SELECT m.*, m.rowid
    FROM or_uni_item_Bala_mov m
    WHERE operating_unit_id= inuBodega 
    AND item_moveme_caus_id=-1
    AND items_id =  inuItemId
    AND  trunc(move_date) = trunc(sysdate)
    AND id_items_seriado is null;
  

    rcBalance OR_OPE_UNI_ITEM_BALA%ROWTYPE;
    rcBalanceNulo OR_OPE_UNI_ITEM_BALA%ROWTYPE;

    rcMovimiento cuMovimiento%ROWTYPE;
    rcMovimientoNulo cuMovimiento%ROWTYPE;
BEGIN

    dbms_output.put_line('Inicio OSF-3518 ');
    

    FOR reg IN  cuDesblance LOOP
    
        dbms_output.put_line('reg.id_items_seriado: ' ||reg.id_items_seriado );
        dbms_output.put_line('reg.ITEMS_ID: ' ||reg.ITEMS_ID );
        dbms_output.put_line('reg.OPERATING_UNIT_ID: ' ||reg.OPERATING_UNIT_ID );

        
        rcMovimiento := rcMovimientoNulo;
        rcBalance := rcBalanceNulo;
        
        OPEN cuBalanceItem(reg.ITEMS_ID,reg.OPERATING_UNIT_ID);
        FETCH cuBalanceItem INTO rcBalance;
        CLOSE cuBalanceItem;
        
        dbms_output.put_line('rcBalance.BALANCE: ' ||rcBalance.BALANCE );
        dbms_output.put_line('rcBalance.total_costs: ' ||rcBalance.total_costs );
        
        
        UPDATE OR_OPE_UNI_ITEM_BALA
        SET     BALANCE =  rcBalance.BALANCE - 1
        WHERE ITEMS_ID = reg.ITEMS_ID
        AND OPERATING_UNIT_ID = reg.OPERATING_UNIT_ID;

        
        OPEN cuMovimiento(reg.OPERATING_UNIT_ID, reg.ITEMS_ID );
        FETCH cuMovimiento INTO rcMovimiento;
        CLOSE cuMovimiento;

        UPDATE or_uni_item_Bala_mov
        SET COMMENTS =  'Actualización por caso OSF-3518',
            id_items_seriado = reg.id_items_seriado
        WHERE rowid = rcMovimiento.rowid;
    END LOOP;
    COMMIT;
    
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/