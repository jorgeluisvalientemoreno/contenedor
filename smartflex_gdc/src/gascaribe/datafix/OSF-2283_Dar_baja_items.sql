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
    sbComentario        ge_items_documento.comentario%TYPE := 'Baja de item por caso OSF-2283';
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
    dbms_output.put_line('Inicia Baja de item');

    EXECUTE IMMEDIATE 'alter trigger TRG_VAL_MOV_BODEGA disable';
    EXECUTE IMMEDIATE 'alter trigger TRG_AUROR_OPE_UNI_ITEM_BALA disable';
    
    FOR rcItems IN cuItems LOOP 
        nuUnidadOperativa := rcItems.operating_unit_id;
        rcUnidadBalance := rcUnidadBalanceNulo;

        rcitemsseriado  := rcitemsseriadoNULO ;
        rcMovimiento := rcMovimientoNulo;

        nucosto := NULL;
    

        dbms_output.put_line('Procesando Item ['||rcItems.items_id||']');
        dbms_output.put_line('Unidad Operativa ['||rcItems.operating_unit_id||']');
        --Crea el documento de ajuste
        nuItemDocumento := GE_BOITEMSSEQUENCE.NEXTGE_ITEMS_DOCUMENTO;
        INSERT INTO ge_items_documento
        (
          id_items_documento,
          document_type_id,
          operating_unit_id,
          destino_oper_uni_id,
          fecha,
          documento_externo,
          estado,
          comentario,
          user_id,
          terminal_id,
          causal_id,
          package_id
        )
        VALUES
        (
            nuItemDocumento,
            nuTipoDocumento,
            nuUnidadOperativa,
            nuUnidadOperativa,
            dtFecha,
            null,
            'C',
            sbComentario,
            SA_BOUSER.FNUGETUSERID_NULL(UT_SESSION.GETUSER),
            UT_SESSION.GETTERMINAL,
            nuCausal,
            null
        );

        IF (rcItems.seriado = 'N') THEN
            nuEstadoInventario := NVL (DAGE_ITEMS.FNUGETINIT_INV_STATUS_ID(rcItems.items_id), GE_BOITEMSCONSTANTS.CNUSTATUS_DISPONIBLE);
            dbms_output.put_line('No es un items seriado, estado inventario['||nuEstadoInventario||']');
        END IF;

        IF (rcItems.seriado = 'S') THEN

            OPEN cuItemsSeriado(rcItems.id_items_seriado);
            FETCH cuItemsSeriado INTO rcitemsseriado;
            CLOSE  cuItemsSeriado;

            dbms_output.put_line('Es un items seriado, serie ['||rcItems.id_items_seriado||']');
            UPDATE  ge_items_seriado
            SET     id_items_estado_inv = nuEstadoInventario,
                    operating_unit_id   = null,
                    fecha_baja = sysdate
            WHERE  id_items_seriado = rcItems.id_items_seriado;
            dbms_output.put_line('Actualiza Unidad Operativa del item a NULL: ['|| rcItems.id_items_seriado ||']');

            nucosto := NVL(NVL(nucosto,rcitemsseriado.costo),0);
        ELSE 
            nucosto := nucostoFijo;
        END IF;

        OPEN cuUnidadBalance (rcItems.operating_unit_id, rcItems.items_id);
        FETCH cuUnidadBalance INTO rcUnidadBalance;
        CLOSE  cuUnidadBalance;

        IF  nucosto IS NULL THEN
          IF rcUnidadBalance.balance = 0 THEN
            
            nucosto := rcUnidadBalance.total_costs * nucantidad;
            dbms_output.put_line('Balance 0 nucosto = ['||nucosto||']');
          ELSE
            nucosto := rcUnidadBalance.total_costs * nucantidad / rcUnidadBalance.balance;
            dbms_output.put_line('Balance diferente 0 nucosto = ['||nucosto||']');
          END IF;
        END IF;

        dbms_output.put_line('nucosto = ['||nucosto||']');

        UPDATE OR_OPE_UNI_ITEM_BALA
        SET BALANCE = BALANCE -nucantidad, TOTAL_COSTS = TOTAL_COSTS - nucosto
        WHERE OPERATING_UNIT_ID = rcUnidadBalance.operating_unit_id
        AND  ITEMS_ID = rcUnidadBalance.items_id;

        update ldc_inv_ouib b
        set   b.balance = b.balance - nucantidad,
              b.total_costs = b.total_costs - nucosto
        where b.operating_unit_id = rcUnidadBalance.operating_unit_id
        and b.items_id = rcUnidadBalance.items_id;

        OPEN cuMovimiento (rcItems.operating_unit_id, rcItems.items_id);
        FETCH cuMovimiento INTO rcMovimiento;
        CLOSE cuMovimiento;

        UPDATE or_uni_item_Bala_mov
        SET COMMENTS =  'Creado por caso OSF-2283',
            id_items_seriado = rcItems.id_items_seriado,
            id_items_documento = nuItemDocumento,
            item_moveme_caus_id = nuCausaMovimient
        WHERE uni_item_bala_mov_id = rcMovimiento.uni_item_bala_mov_id;


    END LOOP;

    EXECUTE IMMEDIATE 'alter trigger TRG_VAL_MOV_BODEGA enable';
    EXECUTE IMMEDIATE 'alter trigger TRG_AUROR_OPE_UNI_ITEM_BALA enable';
    
    COMMIT;
exception
    when others then
        sberror := sqlerrm;
        nuerror := sqlcode;
        
        dbms_output.put_line('=====================================================');
        dbms_output.put_line('Fin Baja de item '||nuerror||'-'||sberror||']');
        EXECUTE IMMEDIATE 'alter trigger TRG_VAL_MOV_BODEGA enable';
        rollback;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/