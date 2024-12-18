column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
    nuUnidadOperativa   or_operating_unit.operating_unit_id%TYPE;
    nuTipoDocumento     ge_items_documento.document_type_id%TYPE := 113;
    dtFecha             ge_items_documento.fecha%TYPE := sysdate;
    sbComentario        ge_items_documento.comentario%TYPE := 'Actualizacion de inventario por caso OSF-2283';
    nuCausal            ge_items_documento.causal_id%TYPE := 627;
    nuItemDocumento     ge_items_documento.id_items_documento%TYPE;

    sbTipoMovimiento    or_uni_item_bala_mov.movement_type%TYPE := 'D';
    nuEstadoInventario  ge_items_seriado.id_items_estado_inv%TYPE := 8;
    nuCausaMovimient    or_item_moveme_caus.item_moveme_caus_id%TYPE   := 19;
    rcitemsseriado      ge_items_seriado%ROWTYPE;
    rcitemsseriadoNULO      ge_items_seriado%ROWTYPE;

    nucosto             or_uni_item_bala_mov.total_value%TYPE;
    nucostoFijo             or_uni_item_bala_mov.total_value%TYPE := 461;
    nucantidad          NUMBER := 1;
    sberror     varchar2(2000);
    nuerror     number;


    CURSOR cuItems
    IS
    SELECT  null id_items_seriado,
            items_id,
            operating_unit_id,
            balance,
            NULL serie,
            'N' seriado
    FROM    or_ope_uni_item_bala
    WHERE   items_id =10000113
    AND     operating_unit_id =1928
    UNION
    SELECT  id_items_seriado,
            items_id,
            operating_unit_id,
            null balance,
            serie,
            'S' seriado
    FROM ge_items_seriado
    WHERE   items_id =10003810
    AND     operating_unit_id =1928
    AND     serie = 'S-3401116737-13';

    CURSOR cuItemsSeriado
    (
        idItemSeriado IN ge_items_seriado.id_items_seriado%TYPE
    )
    IS
    SELECT  *
    FROM    ge_items_seriado
    WHERE   id_items_seriado = idItemSeriado;


    CURSOR cuUnidadBalance
    (
        inuUnidadOperativa IN or_ope_uni_item_bala.operating_unit_id%TYPE,
        inuItems IN or_ope_uni_item_bala.items_id%TYPE
    )
    IS
    SELECT  *
    FROM    or_ope_uni_item_bala
    WHERE   operating_unit_id = inuUnidadOperativa
    AND     items_id = inuItems;

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

    rcUnidadBalance   cuUnidadBalance%ROWTYPE;
    rcUnidadBalanceNulo   cuUnidadBalance%ROWTYPE;
BEGIN
    dbms_output.put_line('=====================================================');
    dbms_output.put_line('Inicia Actualizacion de inventario');
    EXECUTE IMMEDIATE 'alter trigger TRG_VAL_MOV_BODEGA disable';

    dbms_output.put_line('Se inserta movimiento para el item 10003810 y unidad 1928');
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
        10003810, 
        1928, 
        19, 
        'D', 
        1, 
        'Creado por caso OSF-2283 - OSF-2248', 
         TO_DATE('6/02/2024 7:56:58 pm', 'DD/MM/YYYY HH:MI:SS AM'), 
        'NO TERMINAL', 
        'OPEN', 
        ' ', 
        1828843, 
        1372820, 
        2046359
    );

    dbms_output.put_line('Se inserta movimiento para el item 10000113 y unidad 1928');
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
        10000113, 
        1928, 
        19, 
        'D', 
        1, 
        'Creado por caso OSF-2283 - OSF-2248', 
        TO_DATE('6/02/2024 7:56:58 pm', 'DD/MM/YYYY HH:MI:SS AM'), 
        'NO TERMINAL', 
        'OPEN', 
        ' ', 
        460.69, 
        1372821,
        NULL
        );

    dbms_output.put_line('Se actualiza bodega unidad 3655  e item 10007397');

    UPDATE OR_OPE_UNI_ITEM_BALA
    SET     TOTAL_COSTS = 1776597
    WHERE   OPERATING_UNIT_ID = 3655
    AND     ITEMS_ID = 10007397;

    rcMovimiento := rcMovimientoNulo;

    OPEN cuMovimiento (3655, 10007397);
    FETCH cuMovimiento INTO rcMovimiento;
    CLOSE cuMovimiento;

    dbms_output.put_line('Se actualiza bodega unidad 3655  e item 10002007');

    UPDATE or_uni_item_Bala_mov
    SET COMMENTS =  'Creado por caso OSF-2248'
    WHERE uni_item_bala_mov_id = rcMovimiento.uni_item_bala_mov_id;


    UPDATE OR_OPE_UNI_ITEM_BALA
    SET     TOTAL_COSTS = TOTAL_COSTS - 44193.82
    WHERE   OPERATING_UNIT_ID = 3655
    AND     ITEMS_ID = 10002007 ;

    rcMovimiento := rcMovimientoNulo;

    OPEN cuMovimiento (3655, 10002007);
    FETCH cuMovimiento INTO rcMovimiento;
    CLOSE cuMovimiento;

    UPDATE or_uni_item_Bala_mov
    SET COMMENTS =  'Creado por caso OSF-2248'
    WHERE uni_item_bala_mov_id = rcMovimiento.uni_item_bala_mov_id;
    
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