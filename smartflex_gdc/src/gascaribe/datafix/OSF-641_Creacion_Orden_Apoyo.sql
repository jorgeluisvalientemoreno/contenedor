column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
    
    nuOrdenCerrada      or_order.order_id%TYPE := 246307669;
    inuItemd_Id         or_order_items.items_id%TYPE := 100004732; -- Item a borrar
   

    inuActivity         or_order_activity.activity_id%TYPE := 4000339;
    inuParsedAddressId  ab_address.address_id%TYPE := 269;
    idtExecDate         date := sysdate;
    isbComment          OR_ORDER_COMMENT.ORDER_COMMENT%TYPE := 'OSF-641: Se crea orden de apoyo';
    inuReferenceValue   or_order.order_id%TYPE;
    ionuOrderId         or_order.order_id%TYPE;
    onuErrorCode        NUMBER;
    osbErrorMessage     VARCHAR2(4000);
    
    nuResCreaOrden      NUMBER;
    nuResBorraItem      NUMBER;
    
    
    Procedure proinicializaregistroenlog(inuorden_id       or_order.order_id%Type,
                                       inuorder_item_id  or_order_items.order_items_id%Type,
                                       inucantidad_final ldc_log_items_modif_sin_acta.cantidad_final%Type,
                                       inuitem_id        ldc_log_items_modif_sin_acta.item_id%Type,
                                       isbobservacion    ldc_log_items_modif_sin_acta.observa_modif%Type,
                                       isbaccion         Varchar2,
                                       onuconsecutivo    Out ldc_log_items_modif_sin_acta.consecutivo%Type,
                                       osberror          Out Varchar2) Is

    exerror Exception; -- Excepcion
    sbmetodo            Varchar2(4000) := 'proInicializaRegistroEnLog';
    nupackage_id        or_order_activity.package_id%Type; -- solicitud
    nuvalor_original    or_order_items.value%Type; -- valor original
    nuvalor_total_orig  or_order_items.total_price%Type; -- valor total original
    nuserial_items_id   or_order_items.serial_items_id%Type; -- serial del item
    nulegal_item_amount ldc_log_items_modif_sin_acta.legal_item_amount%Type; -- cantidad legalizada originalmente
    nupaso              Number;
    nuUnidad            or_operating_unit.operating_unit_id%TYPE;
    nuCantBodPadre      or_ope_uni_item_bala.balance%TYPE;
    nuCostBodPadre      or_ope_uni_item_bala.total_costs%TYPE;
    nuCantBodInv        or_ope_uni_item_bala.balance%TYPE;
    nuCostBodInv        or_ope_uni_item_bala.total_costs%TYPE;
    nuCantBodAct        or_ope_uni_item_bala.balance%TYPE;
    nuCostBodAct        or_ope_uni_item_bala.total_costs%TYPE;

    Begin
    dbms_output.put_line('Inicio ' || '' || '.' || sbmetodo);
    dbms_output.put_line('Completa informacion del log');
    nupaso := 10;

    dbms_output.put_line('Numero de la solicitud');
    Begin
      Select Max(ooa.package_id)
        Into nupackage_id
        From or_order_activity ooa
       Where ooa.order_id = inuorden_id;
    Exception
      When no_data_found Then
        Null;
      When too_many_rows Then
        osberror := 'Se encontraron varias solicitudes asociadas a la orden ' ||
                    inuorden_id;
      When Others Then
        osberror := 'Se presento un error no controlado al intentar obtener ' ||
                    'el codigo de la solicitud asociada a la orden ' ||
                    inuorden_id;
    End;

    nupaso := 20;

    If osberror Is Not Null Then
      Raise exerror;
    End If;

    --or_ope_uni_item_bala
    --ldc_inv_ouib
    --ldc_act_ouib

    dbms_output.put_line ( 'inuorder_item_id|' || inuorder_item_id );

    nupaso := 30;
    If isbaccion = 'MODIFICACION' Then

      dbms_output.put_line('Valores originales');
      Begin
        Select ooi.value,
               ooi.total_price,
               ooi.serial_items_id,
               ooi.legal_item_amount
          Into nuvalor_original,
               nuvalor_total_orig,
               nuserial_items_id,
               nulegal_item_amount
          From or_order_items ooi
         Where ooi.order_items_id = inuorder_item_id;

      Exception
        When no_data_found Then
          osberror := 'No se encontraron items asociados al registro ' ||
                      inuorder_item_id;
        When too_many_rows Then
          osberror := 'Se encontraron varios registros ' ||
                      inuorder_item_id;
        When Others Then
          osberror := 'No fue posible consultar la informacion asociada al registro ' ||
                      inuorder_item_id;
      End;

      dbms_output.put_line( 'osberror|' || osberror );
      
      IF osberror IS NOT NULL THEN
        RAISE exerror;
      END IF;
      
      dbms_output.put_line( 'Paso cursor valores originales' );

      IF (dage_items.fnugetitem_classif_id(inuitem_id,0) IN (GE_BOItemsConstants.CNUCLASIFICACION_HERR,
                                                             GE_BOItemsConstants.CNUCLASIFICACION_MATER_INVE,
                                                             GE_BOItemsConstants.CNUCLASIFICACION_EQUIPO))THEN
        nuUnidad := daor_order.fnugetoperating_unit_id(inuorden_id,0);

        BEGIN
         SELECT bp.balance,
                bp.total_costs
           INTO nuCantBodPadre,
                nuCostBodPadre
           FROM or_ope_uni_item_bala bp
          WHERE bp.operating_unit_id = nuUnidad
            AND bp.items_id = inuitem_id;

        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            NULL;
            /*osberror := 'No se encontro registro de bodega padre para el item '||
                        inuitem_id||' con unidad '||nuUnidad;*/
          WHEN OTHERS THEN
            osberror := 'No fue posible consultar la informacion asociada a la bodega padre del registro ' ||
                        inuorder_item_id;
        END;

        IF osberror IS NOT NULL THEN
          RAISE exerror;
        END IF;

        BEGIN
         SELECT bi.balance,
                bi.total_costs
           INTO nuCantBodInv,
                nuCostBodInv
           FROM ldc_inv_ouib bi
          WHERE bi.operating_unit_id = nuUnidad
            AND bi.items_id = inuitem_id;

        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            NULL;
            /*osberror := 'No se encontro registro de bodega inventario para el item '||
                        inuitem_id||' con unidad '||nuUnidad;*/
          WHEN OTHERS THEN
            osberror := 'No fue posible consultar la informacion asociada a la bodega inventario del registro ' ||
                        inuorder_item_id;
        END;

        IF osberror IS NOT NULL THEN
          RAISE exerror;
        END IF;

        BEGIN
         SELECT ba.balance,
                ba.total_costs
           INTO nuCantBodAct,
                nuCostBodAct
           FROM ldc_act_ouib ba
          WHERE ba.operating_unit_id = nuUnidad
            AND ba.items_id = inuitem_id;

        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            NULL;
            /*osberror := 'No se encontro registro de bodega de activos para el item '||
                        inuitem_id||' con unidad '||nuUnidad;*/
          WHEN OTHERS THEN
            osberror := 'No fue posible consultar la informacion asociada a la bodega de activos del registro ' ||
                        inuorder_item_id;
        END;

        IF osberror IS NOT NULL THEN
          RAISE exerror;
        END IF;

      END IF;

    End If;

    dbms_output.put_line('Se calcula el consecutivo');
    nupaso         := 80;
    onuconsecutivo := seq_ldc_log_items_modif_sin.nextval;

    dbms_output.put_line('Se modifica el log con los valores iniciales');
    nupaso := 90;
    Insert Into ldc_log_items_modif_sin_acta llimosa
      (orden_id,
       package_id,
       order_item_id,
       item_id,
       legal_item_amount,
       costo_original,
       precio_original,
       cantidad_final,
       observa_modif,
       consecutivo,
       serial_items_id,
       prev_ouib_balance,
       prev_ouib_total_cost,
       prev_oi_balance,
       prev_oi_total_cost,
       prev_ao_balance,
       prev_ao_total_cost)
    Values
      (inuorden_id, --orden_id,
       nupackage_id, --package_id,
       inuorder_item_id, --order_item_id,
       inuitem_id, --item_id,
       nulegal_item_amount, --legal_item_amount,
       nuvalor_original, --valor_original,
       nuvalor_total_orig, --valor_total_orig,
       inucantidad_final, --cantidad_final,
       isbobservacion, --observa_modif,
       onuconsecutivo, --consecutivo,
       nuserial_items_id, --serial_items_id,
       nuCantBodPadre,
       nuCostBodPadre,
       nuCantBodInv,
       nuCostBodInv,
       nuCantBodAct,
       nuCostBodAct);
       dbms_output.put_line('Termina ' || '' || '.' || sbmetodo);

    Exception
    When exerror Then
      osberror := osberror || '( ' || '' || '.' || sbmetodo ||
                  nupaso || ')';
    When Others Then
      osberror := '' || '.' || sbmetodo || nupaso || ' - ' ||
                  Sqlerrm;
    End proinicializaregistroenlog;
    
    
    FUNCTION fblOrdenEnActa RETURN BOOLEAN
    IS
        blOrdenEnActa   BOOLEAN := FALSE;
        
        CURSOR cuDetalleActa
        IS
        SELECT id_orden
        FROM ge_detalle_acta
        WHERE id_orden = nuOrdenCerrada;
        
        nuOrder_Id ge_detalle_acta.id_orden%TYPE;
        
    BEGIN

        OPEN cuDetalleActa;
        FETCH cuDetalleActa INTO nuOrder_Id;
        CLOSE cuDetalleActa;
        
        IF nuOrder_Id IS NOT NULL THEN
            blOrdenEnActa := TRUE;
        END IF;
        
        RETURN blOrdenEnActa;
    
    END fblOrdenEnActa;
    
    PROCEDURE pCreaOrden ( onuErr OUT NUMBER )
    IS
        nuTipoRelacion  OR_RELATED_ORDER.RELA_ORDER_TYPE_ID%TYPE := 4; -- ge_transition_type -- 4: Orden de apoyo
    BEGIN

        OS_CREATEORDERACTIVITIES
        (
            inuActivity,
            inuParsedAddressId,
            idtExecDate,
            ISBCOMMENT,
            inuReferenceValue,
            ionuOrderId,
            onuErrorCode,
            osbErrorMessage
        );

        DBMS_OUTPUT.PUT_LINE( 'ionuOrderId|' || ionuOrderId );    
        DBMS_OUTPUT.PUT_LINE( 'osbErrorMessage|' || osbErrorMessage );
        
        if onuErrorCode = pkConstante.Exito then
            -- Asociar en select * from or_related_order
            INSERT INTO or_related_order
            (
                ORDER_ID,
                RELATED_ORDER_ID,
                RELA_ORDER_TYPE_ID
            )
            VALUES
            ( 
                nuOrdenCerrada,
                ionuOrderId,
                nuTipoRelacion 
            );
            
            
            onuErr := pkConstante.Exito;
            
        else
        
            DBMS_OUTPUT.PUT_LINE ( 'Error OS_CREATEORDERACTIVITIES|' || osbErrorMessage);
            
            onuErr :=-1;
            
            ROLLBACK;        
                
        end if;
        
        EXCEPTION
            WHEN others THEN
                dbms_output.put_line( 'ERROR OTHERS pCreaOrden|' || sqlerrm );
                onuErr := -1;                   
    END pCreaOrden;

    PROCEDURE pBorraItem ( onuErr OUT NUMBER )
    IS

        isbobservacion    ldc_log_items_modif_sin_acta.observa_modif%Type := 'OSF-641:Se borra para crear orden de apoyo';
        isbaccion         Varchar2(20) := 'MODIFICACION';
        onuconsecutivo    ldc_log_items_modif_sin_acta.consecutivo%Type;
        osberror          Varchar2(4000);
    
        CURSOR cuor_order_items IS
        SELECT oi.*, oi.rowid rid
        FROM or_order_items oi
        WHERE order_id = nuOrdenCerrada
        AND ITEMS_ID <> 100009082;
        
        type tytbor_order_items IS TABLE OF cuor_order_items%ROWTYPE
        INDEX BY BINARY_INTEGER;
        
        tbor_order_items tytbor_order_items;
        
    BEGIN
        
        OPEN cuor_order_items;
        FETCH cuor_order_items BULK COLLECT INTO tbor_order_items;
        CLOSE cuor_order_items;
    
        for indtb IN 1..tbor_order_items.COUNT LOOP
        
                onuconsecutivo     := null;
                osberror           := null;     
        
            proinicializaregistroenlog
            (
                tbor_order_items(indtb).order_id       ,
                tbor_order_items(indtb).order_items_id  ,
                tbor_order_items(indtb).legal_item_amount ,
                tbor_order_items(indtb).items_id       ,
                isbobservacion    ,
                isbaccion         ,
                onuconsecutivo    ,
                osberror          
            );    

            if onuconsecutivo IS NOT NULL THEN
            
                DELETE FROM or_order_items
                WHERE rowid = tbor_order_items(indtb).rid;

            else

                    dbms_output.put_line( 'ERROR proinicializaregistroenlog|' || osberror );
                    onuErr := -1;                
                  
            end if; 
        
        END LOOP;
        
        onuErr := pkConstante.Exito;

        EXCEPTION
            WHEN others THEN
                dbms_output.put_line( 'ERROR OTHERS pBorraItem|' || sqlerrm );
                onuErr := -1;                
    
    END pBorraItem;

BEGIN

    dbms_output.put_line('Inicia Creacion Orden de apoyo ' || nuOrdenCerrada );

    -- Se valida que la orden legalizada no exista en un acta
    if NOT fblOrdenEnActa then
        
        pCreaOrden ( nuResCreaOrden );

        if nuResCreaOrden = pkConstante.Exito THEN
        
            pBorraItem ( nuResBorraItem );
            
            if nuResBorraItem = pkConstante.Exito then
            
                dbms_output.put_line( 'Termina Ok');
                commit;
                null;
            
            end if;

        end if;
        
        if not ( nuResCreaOrden = pkConstante.Exito AND nuResBorraItem = pkConstante.Exito )
        then
            ROLLBACK;
        end if; 
        
    else
    
        dbms_output.put_line( 'No se procesa porque la orden se encuentra en un acta');    

    end if;
    
    dbms_output.put_line('Finaliza Creacion Orden de apoyo ' || nuOrdenCerrada );    
    
    EXCEPTION 
    WHEN OTHERS THEN
        dbms_output.put_line('ERROR ' || sqlerrm );        
        ROLLBACK;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/