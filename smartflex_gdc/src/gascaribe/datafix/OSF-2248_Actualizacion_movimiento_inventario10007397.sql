column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
    sberror     varchar2(2000);
    nuerror     number;

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
    dbms_output.put_line('=====================================================');
    dbms_output.put_line('Inicia Actualizacion de inventario');
    EXECUTE IMMEDIATE 'alter trigger TRG_VAL_MOV_BODEGA disable';

    dbms_output.put_line('Se actualiza bodega unidad 3655  e item 10007397');

    UPDATE OR_OPE_UNI_ITEM_BALA
    SET     TOTAL_COSTS = TOTAL_COSTS+72416.28
    WHERE   OPERATING_UNIT_ID = 3655
    AND     ITEMS_ID = 10007397;


 INSERT INTO OR_UNI_ITEM_BALA_MOV
    (
        UNI_ITEM_BALA_MOV_ID, 
        ITEMS_ID, 
        OPERATING_UNIT_ID, 
        ITEM_MOVEME_CAUS_ID, 
        MOVEMENT_TYPE, 
        AMOUNT, 
        COMMENTS, 
        MOVE_DATE, 
        TERMINAL, 
        USER_ID, 
        SUPPORT_DOCUMENT, 
        TOTAL_VALUE, 
        ID_ITEMS_DOCUMENTO, 
        ID_ITEMS_SERIADO
        )
    VALUES
    (
        or_bosequences.fnunextor_uni_item_bala_mov, 
        10007397, 
        3655, 
        -1, 
        'I', 
        0, 
        'Creado por caso OSF-2248', 
        sysdate, 
        'NO TERMINAL', 
        'OPEN', 
        ' ', 
        72416.28, 
        NULL,
        NULL
        );
    
    COMMIT;
    EXECUTE IMMEDIATE 'alter trigger TRG_VAL_MOV_BODEGA enable';
    dbms_output.put_line('Fin Actualizacion de inventario ');
exception
    when others then
        sberror := sqlerrm;
        nuerror := sqlcode;
        
        dbms_output.put_line('=====================================================');
        dbms_output.put_line('Fin Actualizacion de inventario '||nuerror||'-'||sberror||']');
        EXECUTE IMMEDIATE 'alter trigger TRG_VAL_MOV_BODEGA enable';
        rollback;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/