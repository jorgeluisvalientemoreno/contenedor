declare

  inuasig_subsidy_id VARCHAR2(4000) := '223374-S';
   onuErrorCode NUMBER;
  osbErrorMessage    VARCHAR2(4000);

  ---parametros para valores quemados
  CURSOR cuAsigSubsidy IS
    SELECT *
      FROM open.ld_asig_subsidy
     WHERE asig_subsidy_id =
           to_number('223374');--(LD_BOSUBSIDY.FsbGetString(1, inuasig_subsidy_id, '-'));

  ---parametros para valores quemados
  CURSOR cuSalesWithoutsubsidy IS
    SELECT *
      FROM open.Ld_sales_withoutsubsidy
     WHERE Sales_Withoutsubsidy_Id =
           to_number('223374');--(LD_BOSUBSIDY.FsbGetString(1, inuasig_subsidy_id, '-'));

  CURSOR cuOrder(nuorder_id open.or_order.order_id%TYPE) IS
    SELECT * FROM open.or_order WHERE order_id = nuorder_id;

  CURSOR cuOrderActivity(nuorder_id   open.or_order.order_id%TYPE,
                         nuactivityid open.or_order_activity.activity_id%TYPE) IS
    SELECT DISTINCT order_activity_id, comment_
      FROM open.or_order_activity
     WHERE order_id = nuorder_id
       AND activity_id = nuactivityid;

  CURSOR lengthorder_activity IS
    SELECT a.DATA_LENGTH
      FROM all_tab_columns a
     WHERE a.TABLE_NAME = 'OR_ORDER_ACTIVITY'
       AND a.COLUMN_NAME = 'COMMENT_';

  nuCAUSAL_ID         number; --ge_boInstanceControl.stysbValue;
  sbComment           varchar2(4000);--ge_boInstanceControl.stysbValue;
  nuOrdenTrab         number;--or_order.order_id%type;
  AsigSubsidy         cuAsigSubsidy%ROWTYPE;
  SalesWithoutsubsidy cuSalesWithoutsubsidy%ROWTYPE;
  OrderAsig           cuOrder%ROWTYPE;
  OrderActivity       cuOrderActivity%ROWTYPE;
  nuParameter         open.ld_parameter.numeric_value%TYPE;
  --sbParameter         ld_parameter.value_chain%type;

  nuError NUMBER;
  sbError VARCHAR2(4000);

  TYPE rsRelatedOrder IS RECORD(
    Order_Id number,
    related_order_id number,
    rela_order_type_id number);

  TYPE rcRelatedOrder IS TABLE OF rsRelatedOrder INDEX BY BINARY_INTEGER;  

                              
  --rcRelatedOrder daor_related_order.styOR_related_order;

  nuItems              open.ge_items.items_id%TYPE;
  nuMotive             open.mo_motive.motive_id%TYPE;
  nuAddress            open.mo_packages.address_id%TYPE;
  nuSubscriberId       open.mo_packages.Subscriber_Id%TYPE;
  nuSubscriptionPendId open.mo_packages.Subscription_Pend_Id%TYPE;
  --rcMotive             damo_motive.styMO_motive;
  nuOrderId            open.or_order.order_id%TYPE;
  nuOrderActivityId    open.or_order_activity.order_activity_id%TYPE;

  nuOperatingUnitId open.or_order.operating_unit_id%TYPE;
  nuContractorID    open.or_operating_unit.contractor_id%TYPE;
  nuOrderId_Out     open.or_order.order_id%TYPE;
  sbtypesale        open.ld_asig_subsidy.type_subsidy%TYPE;
  nulengthcomment   NUMBER;
  --
  sbSuccessCausal open.ld_parameter.value_chain%TYPE;
  sbFailedCausal  open.ld_parameter.value_chain%TYPE;
  --
  nuasigsub   open.ld_asig_subsidy.asig_subsidy_id%TYPE;
  --rcubication dald_ubication.styld_ubication;

  erProceso EXCEPTION;

  PROCEDURE LegAllactivities(inuOrderId        IN NUMBER,
                             inuCausalId       IN NUMBER,
                             inuPersonId       IN NUMBER,
                             idtExeInitialDate IN DATE,
                             idtExeFinalDate   IN DATE,
                             isbComment        IN VARCHAR2,
                             idtChangeDate     IN open.OR_order_stat_change.stat_chg_date%TYPE,
                             onuErrorCode      OUT open.ge_error_log.error_log_id%TYPE,
                             osbErrorMessage   OUT open.ge_error_log.description%TYPE) IS
  
    nuOrderCommentId open.OR_order_comment.order_comment_id%TYPE;
    nuOperUnitId     open. or_order.operating_unit_id%TYPE;
  
  BEGIN
    onuErrorCode    := 0;
    osbErrorMessage := NULL;
    IF (isbComment IS NOT NULL) THEN
      dbms_output.put_line('
      OR_BOOrderComment.InsertOrUpdateComment(inuOrderId,
                                              1,
                                              isbComment,
                                              ''Y'',
                                              nuOrderCommentId)');
    
    END IF;
    --nuOperUnitId := daor_order.fnugetoperating_unit_id(inuOrderId, null);
    select oo.operating_unit_id into nuOperUnitId from open.or_order oo where oo.order_id = inuOrderId;
    dbms_output.put_line('
    ldc_closeOrder('||inuOrderId||', --> orden a legalizar
                   '||inuCausalId||', --> Causal de la orden padre
                   '||inuPersonId||', --> tecnico de la orden padre
                   '||nuOperUnitId||' --> Unidad de trabajo de la orden padre
                   )');
  
  /*EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
      onuErrorCode := -1;
      RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      Errors.setError;
      onuErrorCode    := -1;
      osbErrorMessage := 'termina con error controlado ' || SQLERRM;
      RAISE ex.CONTROLLED_ERROR;*/
  END LegAllactivities;

BEGIN

  dbms_output.put_line('Inicio LDC_PROCCONTDOCUVENT');
  --nuCAUSAL_ID := DALD_PARAMETER.fnuGetNumeric_Value('LDC_CAUSLEGSUB', null);
  select l.numeric_value into nuCAUSAL_ID from open.ld_parameter l where l.parameter_id='LDC_CAUSLEGSUB'; 
  --sbComment   := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_OBSELEGSUB', null);
  select l.value_chain into sbComment from open.ld_parameter l where l.parameter_id='LDC_OBSELEGSUB'; 
  /*Validar que se haya ingresado la causal*/
  IF nuCAUSAL_ID IS NULL THEN
    onuErrorCode    := 2741;--ld_boconstans.cnuGeneric_Error;
    osbErrorMessage := 'La causal de legalizacion no puede ser nula';
    RAISE erProceso;
  
  END IF;

  /*Validar que el parametro de causales de exito este configurado*/
  /*IF ld_boconstans.csbCAU_COM_DOC_SUB IS NULL THEN
    onuErrorCode    := ld_boconstans.cnuGeneric_Error;
    osbErrorMessage := 'El parametro CAU_COM_DOC_SUB no esta diligenciado';
    RAISE erProceso;
  END IF;*/

  /*Validar que el parametro de causales de exito este configurado*/
  /*IF ld_boconstans.csbCAU_NON_COM_DOC_SUB IS NULL THEN
  
    onuErrorCode    := ld_boconstans.cnuGeneric_Error;
    osbErrorMessage := 'El parametro CAU_NON_COM_DOC_SUB no esta diligenciado';
  
    RAISE erProceso;
  END IF;*/

  /*Obtener la longitud del campo comentario de la tabla or_order_activity*/
  BEGIN
    FOR rglengthorder_activity IN lengthorder_activity LOOP
      nulengthcomment := rglengthorder_activity.data_length;
    END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
      nulengthcomment := 2000;
  END;

  IF (length(sbComment) + length('Legalizada por la aplicacion LDCDE []')) >
     nulengthcomment THEN
    onuErrorCode    := 2741;--ld_boconstans.cnuGeneric_Error;
    osbErrorMessage := 'La longitud del comentario de las ordenes a generar es muy extenso';
    RAISE erProceso;
  END IF;

  /*IF ld_boconstans.csbapackagedocok IS NULL OR
     nvl(ld_boconstans.csbapackagedocok, 'X') <> 'S' THEN
  
    onuErrorCode    := ld_boconstans.cnuGeneric_Error;
    osbErrorMessage := 'La constante csbapackagedocok del paquete Ld_Boconstans no se encuentra debidamente diligenciada';
    RAISE erProceso;
  END IF;*/

  /*IF Ld_boconstans.cnupenalize_activity IS NULL THEN
  
    onuErrorCode    := ld_boconstans.cnuGeneric_Error;
    osbErrorMessage := 'El parametro PENALIZE_ACTIVITY no se ha diligenciado';
  
    RAISE erProceso;
  END IF;*/
  /*IF ld_boconstans.cnuTransitionSub IS NULL THEN
    onuErrorCode    := ld_boconstans.cnuGeneric_Error;
    osbErrorMessage := 'El parametro TRANSITION_SUBSIDY no se ha diligenciado';
  
    RAISE erProceso;
  END IF;*/
  /*IF Ld_boconstans.cnudocactivity IS NULL THEN
  
    onuErrorCode    := ld_boconstans.cnuGeneric_Error;
    osbErrorMessage := 'El parametro NORMAL_SALE_DOC_ACTIVITY no se ha diligenciado';
  
    RAISE erProceso;
  END IF;*/

  /*Obtener el valor de los parametros de causales de exito y fallo*/
  --sbSuccessCausal := ld_boconstans.csbCAU_COM_DOC_SUB;
  select l.value_chain into sbSuccessCausal from open.ld_parameter l where l.parameter_id='CAU_COM_DOC_SUB'; 
  
  --sbFailedCausal  := ld_boconstans.csbCAU_NON_COM_DOC_SUB;
  select l.value_chain into sbSuccessCausal from open.ld_parameter l where l.parameter_id='CAU_NON_COM_DOC_SUB'; 

  /*Validar que la causal que se ingreso es de exito o de fallo*/
  IF REGEXP_INSTR(sbSuccessCausal, '(\W|^)' || nuCAUSAL_ID || '(\W|$)') =
     /*LD_BOCONSTANS.CNUCERO_VALUE*/0 AND
     REGEXP_INSTR(sbFailedCausal, '(\W|^)' || nuCAUSAL_ID || '(\W|$)') =
     /*ld_boconstans.cnuCero_Value*/0 THEN
    onuErrorCode    := 2741;--ld_boconstans.cnuGeneric_Error;
    osbErrorMessage := 'La causal de legalizacion ' || nuCAUSAL_ID ||
                       ' no se encuentra configurada ni como causal de exito ni de fallo';
  
    RAISE erProceso;
  END IF;

  IF nuCAUSAL_ID IS NOT NULL THEN
    ---Causal de Cumplimiento de Documentacion
    IF REGEXP_INSTR(sbSuccessCausal, '(\W|^)' || nuCAUSAL_ID || '(\W|$)') >
       /*ld_boconstans.cnuCero_Value*/0 THEN
      dbms_output.put_line('CAUSAL DE EXITO: ' || nuCAUSAL_ID);
      ---Cursor para subsidio asignados
      OPEN cuAsigSubsidy;
      FETCH cuAsigSubsidy
        INTO AsigSubsidy;
      ---parametros para valores quemados
      IF cuAsigSubsidy%FOUND AND
         /*LD_BOSUBSIDY.FsbGetString(2, inuasig_subsidy_id, '-')*/'S' = 'S' THEN
        dbms_output.put_line('IF cuAsigSubsidy%FOUND AND');
        --nuParameter := dald_parameter.fnuGetNumeric_Value(ld_boconstans.csbCodOrderStatus,NULL);
        select l.value_chain into nuParameter from open.ld_parameter l where l.parameter_id='COD_ORDER_STATUS';         
        
        nuOrdenTrab := AsigSubsidy.Order_Id;
      
        IF nuParameter IS NOT NULL THEN
          dbms_output.put_line('IF nuParameter IS NOT NULL THEN');
          OPEN cuOrder(AsigSubsidy.Order_Id);
          dbms_output.put_line('OPEN cuOrder(' || AsigSubsidy.Order_Id || ');');
          
          FETCH cuOrder
            INTO OrderAsig;
          IF cuOrder%FOUND THEN
            dbms_output.put_line(' IF cuOrder%FOUND THEN');
            IF OrderAsig.Order_Status_Id = nuParameter THEN
            
              dbms_output.put_line(' IF ' || OrderAsig.Order_Status_Id || ' = ' ||nuParameter || ' THEN ');
            
              IF OrderAsig.Causal_Id <> nuCAUSAL_ID THEN
                onuErrorCode    := 2741;--Ld_Boconstans.cnuGeneric_Error;
                osbErrorMessage := 'La orden [' || OrderAsig.Order_Id ||
                                   '] fue legalizada con Causal Diferente';
              
              ELSE
                /*Obtener el tipo de asignacion de subsidio*/
              
                dbms_output.put_line(' sbtypesale := dald_asig_subsidy.fsbGetType_Subsidy(LD_BOSUBSIDY.FsbGetString(1,');
              
                --sbtypesale := dald_asig_subsidy.fsbGetType_Subsidy(LD_BOSUBSIDY.FsbGetString(1,inuasig_subsidy_id,'-'),NULL);
                select Type_Subsidy into sbtypesale from OPEN.LD_ASIG_SUBSIDY a where a.asig_subsidy_id = 223374;
              
                IF sbtypesale = /*ld_boconstans.csbretroactivesale*/'R' THEN
                
                  dbms_output.put_line('LD_BOSUBSIDY.ApplyRetrosubsidy(LD_BOSUBSIDY.FsbGetString(1, ' ||inuasig_subsidy_id ||',  -), onuErrorCode,osbErrorMessage);');
                
                  dbms_output.put_line('LD_BOSUBSIDY.ApplyRetrosubsidy(LD_BOSUBSIDY.FsbGetString(1,
                                                                           inuasig_subsidy_id,
                                                                           ''-''),
                                                 onuErrorCode,
                                                 osbErrorMessage)');
                END IF;
              
                IF onuErrorCode IS NOT NULL AND osbErrorMessage IS NOT NULL THEN
                
                  RAISE erProceso;
                END IF;
              
                dbms_output.put_line('dald_asig_subsidy.updDelivery_Doc(' ||AsigSubsidy.Asig_Subsidy_Id || ',' ||/*ld_boconstans.csbapackagedocok*/'S' || ');');
              
                dbms_output.put_line('dald_asig_subsidy.updDelivery_Doc(AsigSubsidy.Asig_Subsidy_Id,
                                                  ld_boconstans.csbapackagedocok)');
              
              END IF;
            ELSE
              dbms_output.put_line('antes de IF OrderAsig.Order_Status_Id <> nuParameter THEN');
              dbms_output.put_line('OrderAsig.Order_Status_Id ' ||OrderAsig.Order_Status_Id || ' - ' ||' nuParameter ' || nuParameter);
            
              IF OrderAsig.Order_Status_Id <> nuParameter THEN
                --dbms_output.put_line(' LegAllactivities(' || OrderAsig.Order_Id || ',' ||nuCAUSAL_ID || ',' ||ld_boutilflow.fnuGetPersonToLegal(daor_order.fnugetoperating_unit_id(OrderAsig.Order_Id)) || ',' ||SYSDATE || ',' ||SYSDATE || ',Legalizacion por proceso Automatico,NULL, --new parameter add for opennuError,sbError);');
              
                dbms_output.put_line('LegAllactivities(OrderAsig.Order_Id,
                                 nuCAUSAL_ID,
                                 ld_boutilflow.fnuGetPersonToLegal(daor_order.fnugetoperating_unit_id(OrderAsig.Order_Id)),
                                 SYSDATE,
                                 SYSDATE,
                                 ''Legalizacion por proceso Automatico'',
                                 NULL, --new parameter add for open
                                 nuError,
                                 sbError)');
              
                IF nuError = /*ld_boconstans.cnuCero_Value*/0 THEN
                  /*Obtener el tipo de asignacion de subsidio*/
                  --sbtypesale := dald_asig_subsidy.fsbGetType_Subsidy(LD_BOSUBSIDY.FsbGetString(1,inuasig_subsidy_id,'-'),NULL);
                  select Type_Subsidy into sbtypesale from OPEN.LD_ASIG_SUBSIDY a where a.asig_subsidy_id = 223374;                  
                
                  /*Generar movimientos: bajar deuda diferida, generar nota y
                  cargo credito para un subsidio retroactivo*/
                  IF sbtypesale = /*ld_boconstans.csbretroactivesale*/'R' THEN
                    dbms_output.put_line('LD_BOSUBSIDY.ApplyRetrosubsidy(LD_BOSUBSIDY.FsbGetString(1,
                                                                             inuasig_subsidy_id,
                                                                             ''-''),
                                                   onuErrorCode,
                                                   osbErrorMessage)');
                  END IF;
                
                  /*IF onuErrorCode IS NOT NULL AND
                     osbErrorMessage IS NOT NULL THEN
                    ge_boerrors.seterrorcodeargument(onuErrorCode,osbErrorMessage);
                  
                  END IF;*/
                
                  --dald_asig_subsidy.updDelivery_Doc(AsigSubsidy.Asig_Subsidy_Id,ld_boconstans.csbapackagedocok);
                
                ELSE
                  onuErrorCode    := nuError;
                  osbErrorMessage := sbError;
                
                END IF;
              END IF;
            END IF;
          ELSE
            onuErrorCode    := 2741;--Ld_Boconstans.cnuGeneric_Error;
            osbErrorMessage := 'Inconvenientes con la orden [' ||
                               AsigSubsidy.Order_Id || ']';
          
          END IF;
          CLOSE cuOrder;
        ELSE
          onuErrorCode    := 2741;--Ld_Boconstans.cnuGeneric_Error;
          osbErrorMessage := 'Error. El parametro de estado de legalizacion de la orden no esta diligenciado [COD_ORDER_STATUS]';
        
        END IF;
      ELSE
        -----/*
        OPEN cuSalesWithoutsubsidy;
        FETCH cuSalesWithoutsubsidy
          INTO SalesWithoutsubsidy;
        ---parametros para valores quemados
        IF cuSalesWithoutsubsidy%FOUND AND
           /*LD_BOSUBSIDY.FsbGetString(2, inuasig_subsidy_id, '-')*/'S' = 'V' THEN
          --nuParameter := dald_parameter.fnuGetNumeric_Value(ld_boconstans.csbCodOrderStatus,NULL);
          nuOrdenTrab := SalesWithoutsubsidy.Order_Id;
        ELSE
                      null;
        
          --close cuSalesWithoutsubsidy;
        END IF;
      
        dbms_output.put_line('antes de CLOSE cuSalesWithoutsubsidy;');
      
        CLOSE cuSalesWithoutsubsidy;
      
        dbms_output.put_line('despues de CLOSE cuSalesWithoutsubsidy;');
        ------*/
      END IF;
    
      dbms_output.put_line('antes de CLOSE cuAsigSubsidy');
    
      CLOSE cuAsigSubsidy;
    
    ELSE
    
      ---Causal de incumplimiento de entrega de documentacion
      IF REGEXP_INSTR(sbFailedCausal, '(\W|^)' || nuCAUSAL_ID || '(\W|$)') >
         /*ld_boconstans.cnuCero_Value*/0 THEN
        dbms_output.put_line('CAUSAL DE FALLO: ' || nuCAUSAL_ID);
        ---Ventas Subsidiadas
        OPEN cuAsigSubsidy;
        FETCH cuAsigSubsidy
          INTO AsigSubsidy;
        ---parametros para valores quemados
        IF cuAsigSubsidy%FOUND AND
           /*LD_BOSUBSIDY.FsbGetString(2, inuasig_subsidy_id, '-')*/'S' = 'S' THEN
          --asignacion retroactiva
          IF AsigSubsidy.Type_Subsidy = 'R' THEN
            --nuParameter := dald_parameter.fnuGetNumeric_Value(ld_boconstans.csbCodOrderStatus,NULL);
            select l.value_chain into nuParameter from open.ld_parameter l where l.parameter_id='COD_ORDER_STATUS';         
            
            nuOrdenTrab := AsigSubsidy.Order_Id;
          
            IF nuParameter IS NOT NULL THEN
              OPEN cuOrder(AsigSubsidy.Order_Id);
              FETCH cuOrder
                INTO OrderAsig;
              dbms_output.put_line('La orden: ' || AsigSubsidy.Order_Id ||'  Se encuentra en estado: ' ||OrderAsig.Order_Status_Id ||' | nuParameter:' || nuParameter);
              IF cuOrder%FOUND THEN
                IF OrderAsig.Order_Status_Id = nuParameter THEN
                  IF OrderAsig.Causal_Id <> nuCAUSAL_ID THEN
                    onuErrorCode    := 2741;
                    osbErrorMessage := 'La orden [' || OrderAsig.Order_Id ||
                                       '] fue legalizada con Causal Diferente a Causal de Fallo';
                  
                  ELSE
                    IF OrderAsig.Causal_Id = nuCAUSAL_ID THEN
                      onuErrorCode    := 2741;--Ld_Boconstans.cnuGeneric_Error;
                      osbErrorMessage := 'La orden [' || OrderAsig.Order_Id ||
                                         '] ya fue legalizada con Causal Fallo';
                    
                    END IF;
                  END IF;
                ELSE
                  IF OrderAsig.Order_Status_Id <> nuParameter THEN
                    dbms_output.put_line('LegAllactivities(OrderAsig.Order_Id,
                                     nuCAUSAL_ID,
                                     ld_boutilflow.fnuGetPersonToLegal(daor_order.fnugetoperating_unit_id(OrderAsig.Order_Id)),
                                     SYSDATE,
                                     SYSDATE,
                                     ''Legalizacion por proceso Automatico'',
                                     NULL, --new parameter add for open
                                     nuError,
                                     sbError)');
                    IF nuError <> /*ld_boconstans.cnuCero_Value*/0 THEN
                      onuErrorCode    := nuError;
                      osbErrorMessage := sbError;
                    
                    ELSE
                    
                      /*Obtener el codigo de asignacion del subsidio*/
                      nuasigsub := 223374;--LD_BOSUBSIDY.FsbGetString(1,inuasig_subsidy_id,'-');
                    
                      /*Validad que el codigo exista*/
                      /*IF NOT dald_asig_subsidy.fblExist(nuasigsub) THEN
                        onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                        osbErrorMessage := 'El codigo de asignacion de subsidio ' ||
                                           nuasigsub || ' no existe';
                      
                      END IF;*/
                      --dbms_output.put_line('ACTUALIZA EL ESTADO A: ' ||ld_boconstans.cnuSubreverstate);
                      /*Se actualiza el estado del subsidio a reversado*/
                      --dald_asig_subsidy.updState_Subsidy(nuasigsub,ld_boconstans.cnuSubreverstate);
                    
                      /*Obtener datos de la poblacion*/
                      --DALD_ubication.getRecord(dald_asig_subsidy.fnuGetUbication_Id(nuasigsub,NULL),rcubication);
                    
                      /*Reversar el valor del subsidio de la poblacion y del subsidio*/
                      --LD_BOSUBSIDY.Procbalancesub(dald_asig_subsidy.fnuGetSubsidy_Id(nuasigsub,NULL),rcubication,dald_asig_subsidy.fnuGetSubsidy_Value(nuasigsub,NULL),ld_boconstans.cnutwonumber);
                    
                    END IF;
                  END IF;
                END IF;
              ELSE
                onuErrorCode    := 2741;--Ld_Boconstans.cnuGeneric_Error;
                osbErrorMessage := 'Inconvenientes con la orden [' ||
                                   AsigSubsidy.Order_Id || ']';
              
                --close cuOrder;
              END IF;
              CLOSE cuOrder;
            ELSE
              onuErrorCode    := 2741;--Ld_Boconstans.cnuGeneric_Error;
              osbErrorMessage := 'Error. El parametro de estado de legalizacion de la orden no esta diligenciado [COD_ORDER_STATUS]';
            
            END IF;
          ELSE
            --Legalizacion como incumplida de una venta subsidida realizada por el formulario de venta
            null;
          END IF;
        ELSE
          null;
          ------*/
        END IF;
        CLOSE cuAsigSubsidy;
        -------*/
      ELSE
        onuErrorCode    := 2741;--Ld_Boconstans.cnuGeneric_Error;
        osbErrorMessage := 'Causal de legalizacion invalida';
      
      END IF;
    END IF;
  ELSE
    onuErrorCode    := 2741;--Ld_Boconstans.cnuGeneric_Error;
    osbErrorMessage := 'Causal de legalizacion invalida';
  
  END IF;

  IF onuErrorCode IS NULL AND osbErrorMessage IS NULL THEN
    COMMIT;
  ELSE
    RAISE erProceso;
  END IF;
  dbms_output.put_line('Fin LDC_PROCCONTDOCUVENT');

end;
/
