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
    
    rcBalance OR_OPE_UNI_ITEM_BALA%ROWTYPE;

    
    CURSOR cuDesblance 
    IS
	SELECT *
    FROM or_uni_item_Bala_mov m
    WHERE operating_unit_id=3551
    AND items_id in ( 10004070,10002011)
    AND movement_type='I'
    AND item_moveme_caus_id = 16
    AND not exists(select null from open.ge_items_seriado s where s.id_items_seriado=m.id_items_seriado and m.operating_unit_id=s.operating_unit_id and s.id_items_estado_inv in (1,12,16))
    AND not exists(select null from open.or_uni_item_bala_mov m2 where m2.id_items_seriado=m.id_items_seriado and m2.operating_unit_id=m.operating_unit_id and m2.movement_type='D' and m2.items_id=m.items_id
    AND  m2.move_date>m.move_date);
    
    CURSOR cuMovimiento
    IS
    SELECT *
    FROM or_uni_item_Bala_mov m
    WHERE operating_unit_id=3551
    AND item_moveme_caus_id=-1
    AND id_items_seriado is null;
  
    rcMovimiento or_uni_item_Bala_mov%ROWTYPE;
BEGIN

    FOR reg IN  cuDesblance LOOP
    
        dbms_output.put_line('reg.id_items_seriado: ' ||reg.id_items_seriado );
        dbms_output.put_line('reg.ITEMS_ID: ' ||reg.ITEMS_ID );
        dbms_output.put_line('reg.OPERATING_UNIT_ID: ' ||reg.OPERATING_UNIT_ID );
        
        rcMovimiento := NULL;
        rcBalance := NULL;
        
        OPEN cuBalanceItem(reg.ITEMS_ID,reg.OPERATING_UNIT_ID);
        FETCH cuBalanceItem INTO rcBalance;
        CLOSE cuBalanceItem;
        
        dbms_output.put_line('rcBalance.BALANCE: ' ||rcBalance.BALANCE );
        dbms_output.put_line('rcBalance.total_costs: ' ||rcBalance.total_costs );
        
        
        UPDATE OR_OPE_UNI_ITEM_BALA
        SET BALANCE =  rcBalance.BALANCE - (SELECT COUNT(1) FROM OPEN.GE_ITEMS_SERIADO i WHERE  i.id_items_seriado =reg.id_items_seriado),
            total_costs = rcBalance.total_costs  - (select value from open.or_order_items oi where  oi.serial_items_id = reg.id_items_seriado)
        WHERE ITEMS_ID = reg.ITEMS_ID
        AND OPERATING_UNIT_ID = reg.OPERATING_UNIT_ID;
        
        OPEN cuMovimiento;
        FETCH cuMovimiento INTO rcMovimiento;
        CLOSE cuMovimiento;
        
        dbms_output.put_line('rcBalance.total_costs: ' ||rcBalance.total_costs );
        
        UPDATE or_uni_item_Bala_mov
        SET COMMENTS =  'Actualización por caso OSF-1453',
            id_items_seriado = reg.id_items_seriado
        WHERE item_moveme_caus_id = rcMovimiento.item_moveme_caus_id
        AND OPERATING_UNIT_ID = rcMovimiento.OPERATING_UNIT_ID
        AND id_items_seriado is null;
    END LOOP;

    OPEN cuBalanceItem(10004070,3551);
    FETCH cuBalanceItem INTO rcBalance;
    CLOSE cuBalanceItem;
    
    UPDATE OPEN.LDC_INV_OUIB
	SET BALANCE = rcBalance.BALANCE,
        total_costs = rcBalance.total_costs
	WHERE ITEMS_ID = 10004070
	AND OPERATING_UNIT_ID = 3551;
    
        OPEN cuBalanceItem(10002011,3551);
    FETCH cuBalanceItem INTO rcBalance;
    CLOSE cuBalanceItem;
    
    UPDATE OPEN.LDC_INV_OUIB
	SET BALANCE = rcBalance.BALANCE,
        total_costs = rcBalance.total_costs
	WHERE ITEMS_ID = 10002011
	AND OPERATING_UNIT_ID = 3551;

    COMMIT;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/