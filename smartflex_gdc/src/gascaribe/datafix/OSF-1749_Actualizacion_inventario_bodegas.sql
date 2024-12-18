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
    rcBalanceNulo OR_OPE_UNI_ITEM_BALA%ROWTYPE;


    CURSOR cuDesblance 
    IS
    select * from (
    with base as(select o.order_id,
           o.task_type_id,
           o.operating_unit_id,
           (select c.user_id from open.or_order_stat_change c where c.order_id=o.order_id and c.final_status_id=8) usuario,
           o.legalization_date,
           i.items_id,
           i.description,
           oi.legal_item_amount,
           oi.value,
           oi.serie,
           oi.out_,
           oi.serial_items_id id_items_seriado,
          (select id_items_documento from ge_items_documento where documento_externo = to_char(o.order_id)) id_items_documento
    from open.or_order o
    inner join open.or_order_items oi on oi.order_id=o.order_id and oi.value!=0 and nvl(out_,'Y')='Y'
    inner join open.ge_items i on i.items_id=oi.items_id and i.item_classif_id in (3,8,21)
    where o.order_status_id=8
        and o.task_type_id = 10764
      and trunc(o.legalization_Date) <= '31/08/2023'
    ),
    base2 as(
    select base.order_id,
           base.task_type_id,
           base.legalization_date,
           base.items_id,
           base.description,
           base.legal_item_amount,
           nvl(round(base.value,0),0) value,
           base.serie,
           base.out_,
           base.operating_unit_id,
           base.usuario,
           mov.id_items_documento,
           nvl(round(mov.amount,0),0) amount,
           nvl(round(mov.total_value,0), 0) total_value,
           base.id_items_seriado id_items_seriado,
           base.id_items_documento base_id_items_documento
    from base
    left join (select d.id_items_documento, d.documento_externo, d.fecha, m.items_id, m.id_items_seriado, (select serie from open.ge_items_seriado s where s.id_items_seriado=m.id_items_seriado) serie, m.amount, m.total_value
                from open.ge_items_documento d
                inner join open.or_uni_item_bala_mov m  on m.id_items_documento=d.id_items_documento
                where d.document_type_id=118 ) mov on mov.documento_externo=to_char(base.order_id) and mov.items_id=base.items_id
                and nvl(mov.serie,'-')=nvl(base.serie,'-')
                and nvl(mov.id_items_seriado,-1)=nvl(base.id_items_seriado,-1)
    )
    select bs.*, nvl(round(lia.cantidad_final,0),0) cantidad_final, nvl(round(lia.costo_final,0),0) costo_final
    from    base2 bs, LDC_LOG_ITEMS_MODIF_SIN_ACTA  lia
    where   bs.order_id = lia.orden_id(+)
    and     bs.items_id = lia.item_id(+)
    and     nvl(lia.fecha_modif, '01/01/1900')=(select nvl(max(l2.fecha_modif),'01/01/1900') from open.LDC_LOG_ITEMS_MODIF_SIN_ACTA l2 where lia.orden_id =l2.orden_id (+) and lia.item_id =l2.item_id(+))
    ) tb_
    where abs(tb_.value-tb_.total_value- tb_.costo_final)!=0;

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
    
    CURSOR cuValidaMovimiento
    (
        inuBodega   IN or_uni_item_Bala_mov.OPERATING_UNIT_ID%TYPE,
        inuItems    IN or_uni_item_Bala_mov.id_items_seriado%TYPE
    )
    IS
    SELECT * 
    FROM or_uni_item_Bala_mov 
    WHERE  OPERATING_UNIT_ID = inuBodega
    and id_items_seriado =  inuItems
    and item_moveme_caus_id = -1;
    
    rcMovimientoExiste cuValidaMovimiento%ROWTYPE;
    rcMovimientoExisteNulo cuValidaMovimiento%ROWTYPE;
BEGIN

    FOR reg IN  cuDesblance LOOP

        dbms_output.put_line('reg.id_items_seriado: ' ||reg.id_items_seriado );
        dbms_output.put_line('reg.ITEMS_ID: ' ||reg.ITEMS_ID );
        dbms_output.put_line('reg.OPERATING_UNIT_ID: ' ||reg.OPERATING_UNIT_ID );
        
        rcMovimientoExiste :=  rcMovimientoExisteNulo;
        
        OPEN cuValidaMovimiento(reg.OPERATING_UNIT_ID, nvl(reg.id_items_seriado,-1));
        FETCH cuValidaMovimiento INTO rcMovimientoExiste;
        CLOSE cuValidaMovimiento;
        

        IF (rcMovimientoExiste.uni_item_bala_mov_id IS NOT NULL) THEN
        
            UPDATE or_uni_item_Bala_mov
            SET id_items_documento = reg.base_id_items_documento
            WHERE uni_item_bala_mov_id = rcMovimientoExiste.uni_item_bala_mov_id;
        
        ELSE
            dbms_output.put_line('Realiza el movimiento');
            rcMovimiento := rcMovimientoNulo;
            rcBalance := rcBalanceNulo;
    
            OPEN cuBalanceItem(reg.ITEMS_ID,reg.OPERATING_UNIT_ID);
            FETCH cuBalanceItem INTO rcBalance;
            CLOSE cuBalanceItem;
    
            
            dbms_output.put_line('rcBalance.BALANCE: ' ||rcBalance.BALANCE );
            dbms_output.put_line('rcBalance.total_costs: ' ||rcBalance.total_costs );
    
            IF (rcBalance.BALANCE >= reg.legal_item_amount and rcBalance.total_costs  >= reg.value) THEN
    
                UPDATE OR_OPE_UNI_ITEM_BALA
                SET BALANCE =  rcBalance.BALANCE - reg.legal_item_amount ,
                    total_costs = rcBalance.total_costs  - reg.value
                WHERE ITEMS_ID = reg.ITEMS_ID
                AND OPERATING_UNIT_ID = reg.OPERATING_UNIT_ID;
        
                OPEN cuMovimiento (reg.OPERATING_UNIT_ID, reg.ITEMS_ID);
                FETCH cuMovimiento INTO rcMovimiento;
                CLOSE cuMovimiento;
        
                dbms_output.put_line('rcBalance.total_costs: ' ||rcBalance.total_costs );
        
                UPDATE or_uni_item_Bala_mov
                SET COMMENTS =  'Actualización por caso OSF-1749',
                    id_items_seriado = reg.id_items_seriado,
                    id_items_documento = reg.base_id_items_documento
                WHERE item_moveme_caus_id = rcMovimiento.item_moveme_caus_id
                AND OPERATING_UNIT_ID = rcMovimiento.OPERATING_UNIT_ID
                AND items_id =  reg.ITEMS_ID
                AND  trunc(move_date) = trunc(sysdate)
                AND id_items_seriado is null;
                
                UPDATE LDC_INV_OUIB
                SET BALANCE = rcBalance.BALANCE - reg.legal_item_amount,
                    total_costs = rcBalance.total_costs  - reg.value
                WHERE ITEMS_ID = reg.ITEMS_ID
                AND OPERATING_UNIT_ID = reg.OPERATING_UNIT_ID;
            END IF;
        END IF;
    END LOOP;

    COMMIT;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/