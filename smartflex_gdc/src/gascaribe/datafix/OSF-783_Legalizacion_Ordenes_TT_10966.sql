column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

    CURSOR cuOrdXLeg IS
    SELECT
    oa.comment_,
    oa.order_activity_id, 
    oa.order_id,
    oa.task_type_id,
    ( SELECT description FROM or_task_type tt WHERE tt.task_type_id = oa.task_type_id ) desc_task_type,
    oa.activity_id,
    ( SELECT description FROM ge_items it WHERE it.items_id = oa.activity_id ) desc_actividad,
    oa.product_id,
    od.created_date,
    od.legalization_date
    from or_order_activity oa,
    or_order od
    where
        oa.task_type_id = 10966
    AND oa.comment_ like 'PRODUCTO YA ESTA SUSPENDIDO[%'
    AND od.order_id = oa.order_id
    AND od.order_status_id = 0
    AND oD.legalization_date IS NULL
    AND oa.activity_id in
    (
        select numeric_value from LD_PARAMETER
        where parameter_id in ( 'ACTI_YA_SUSP_CM','ACTI_YA_SUSP_AC')
    )
    order by oa.register_date desc;
    
    TYPE tytbOrdXLeg IS TABLE OF cuOrdXLeg%ROWTYPE
    INDEX BY BINARY_INTEGER;
    
    tbOrdXLeg tytbOrdXLeg;
        
    CURSOR cuOrdenTT_12155( inProducto NUMBER, idtFechCrea DATE ) IS
    SELECT oa.*
    FROM or_order_activity oa,
    or_order od
    WHERE oa.product_id = inProducto
    AND oa.task_type_id+0 = 12155
    AND od.order_id = oa.order_id
    AND od.order_status_id+0 = 8
    AND od.legalization_date+0 = idtFechCrea;
    
    TYPE tytbOrdenTT_12155 IS TABLE OF cuOrdenTT_12155%ROWTYPE INDEX BY BINARY_INTEGER;
    
    tbOrdenTT_12155 tytbOrdenTT_12155;
    
    PROCEDURE pLegalizaOrdSuspProdSusp (
        inuOrden             or_order_activity.order_id%TYPE,
        inuUnidadOperativa   or_order_activity.operating_unit_id%TYPE)
    IS
    
        dtFecha             DATE := SYSDATE;

        nuError             NUMBER;
        sbMessage           VARCHAR2(4000);
        
        rcOrder             Daor_Order.styOr_Order;
        
        nuCausal_Usr_Susp   ge_causal.causal_id%TYPE := 3311;
        
        onuCodError         NUMBER;
        osbMensError        VARCHAR2(4000);
               
    BEGIN
        dbms_output.put_line ('Inicia pLegalizaOrdSuspProdSusp');

        dbms_output.put_line ('inuOrden|' || inuOrden );
        
        rcOrder := Daor_Order.Frcgetrecord(inuOrden);

        OR_boProcessOrder.updBasicData(rcOrder,
                                     rcOrder.operating_sector_id,
                                     null);

        dbms_output.put_line ('Order_Status_id1|' || rcOrder.Order_Status_Id );
                                               
        os_assign_order
        (
            inuOrden,
            inuUnidadOperativa,
            SYSDATE + 1 / 24 / 60,
            TRUNC (SYSDATE),
            nuError,
            sbMessage
        );

        IF nuError <> pkConstante.Exito THEN
            ROLLBACK;
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                             'Error asignando['|| sbMessage || ']Unidad['  ||
                                             inuUnidadOperativa || ']Orden[' ||
                                             inuOrden || ']');
        END IF;        
        
        rcOrder := Daor_Order.Frcgetrecord(inuOrden);
        
        dbms_output.put_line ('Order_Status_id2|' || rcOrder.Order_Status_Id );

        if inuUnidadOperativa is null then
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                             'La unidad operativa no permite asignar' ||
                                             inuUnidadOperativa || ' ' ||
                                             inuOrden);
        end if;

        os_legalizeorderallactivities(inuOrden,
                                    nuCausal_Usr_Susp,
                                    LD_BOUtilFlow.fnuGetPersonToLegal(inuUnidadOperativa),
                                    dtFecha,
                                    dtFecha,
                                    'Legalizacion de la orden',
                                    null,
                                    nuError,
                                    sbMessage);

        if (nuError = 0) then
            COMMIT;
            dbms_output.put_line ('OK LEGALIZACION|' );
        else
            ROLLBACK;
            dbms_output.put_line ('ERROR LEGALIZACION|' || sbMessage);
        end if;
        
        dbms_output.put_line ('Termina pLegalizaOrdSuspProdSusp' );
        
        EXCEPTION
            WHEN ex.controlled_error THEN
                pkerrors.geterrorvar(onuCodError, osbMensError);           
                dbms_output.put_line ('ERROR pLegalizaOrdSuspProdSusp|' || osbMensError);
                ROLLBACK;
            WHEN OTHERS THEN
                dbms_output.put_line ('ERROR pLegalizaOrdSuspProdSusp|' || sqlerrm);
                ROLLBACK;
    END pLegalizaOrdSuspProdSusp;    
             
BEGIN

    OPEN cuOrdXLeg;
    FETCH cuOrdXLeg BULK COLLECT INTO tbOrdXLeg;
    CLOSE cuOrdXLeg;
    
    IF tbOrdXLeg.COUNT > 0 THEN
    
        FOR indtb1 IN 1..tbOrdXLeg.COUNT LOOP

            dbms_output.put_line( 'Inicia Legalizacion Orden|' || tbOrdXLeg(indtb1).order_id || '|Producto|' || tbOrdXLeg(indtb1).product_id || '|FechaCreac|' || tbOrdXLeg(indtb1).created_date);
        
            tbOrdenTT_12155.DELETE;
            
            OPEN cuOrdenTT_12155( tbOrdXLeg(indtb1).product_id , tbOrdXLeg(indtb1).created_date);
            FETCH cuOrdenTT_12155 BULK COLLECT INTO tbOrdenTT_12155;
            CLOSE cuOrdenTT_12155;
                        
            dbms_output.put_line( 'tbOrdenTT_12155.count|' || tbOrdenTT_12155.count );

            IF tbOrdenTT_12155.COUNT > 0 THEN
            
                UPDATE or_order_activity SET package_id = tbOrdenTT_12155(1).package_id,
                motive_id = tbOrdenTT_12155(1).motive_id
                WHERE order_activity_id = tbOrdXLeg(indtb1).order_activity_id;
                
                pLegalizaOrdSuspProdSusp( tbOrdXLeg(indtb1).order_id, tbOrdenTT_12155(1).operating_unit_id );

            ELSE
                dbms_output.put_line( 'No se encontró orden con TT_12155' );            
            END IF;

        END LOOP;
    
    END IF;

END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/