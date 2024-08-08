PL/SQL Developer Test script 3.0
481
-- Created on 24/08/2023 by JORGE VALIENTE 
declare

  nuOrderActivity  NUMBER;
  nuAccWithBal     NUMBER;
  nuFlag           NUMBER;
  nuValidSald      NUMBER;
  nuconta          NUMBER;
  nuError          NUMBER;
  nuObservType     NUMBER;
  nuOrderN         NUMBER;
  nuOrderActivityN NUMBER;
  sbError          VARCHAR2(4000);
  sbObservation    VARCHAR2(4000);
  blKeepProcess    BOOLEAN;
  nuOrderId        OR_order.order_id%TYPE;
  nuCausalId       ge_causal.causal_id%TYPE;
  nuTaskTypeId     OR_task_type.task_type_id%TYPE;
  nuContrato       servsusc.sesususc%TYPE;
  sbEstaFinan      servsusc.sesuesfn%TYPE;
  nuOperUnitId     OR_order.operating_unit_id%TYPE;
  nuProductId      servsusc.sesunuse%TYPE;
  nuAdressId       ab_address.address_id%TYPE;
  nuDepartment     ge_geogra_location.geograp_location_id%TYPE;
  nuLocality       ge_geogra_location.geograp_location_id%TYPE;
  nucurciclo       ciclo.ciclcodi%TYPE;
  nuNoveltyOrder   ld_parameter.numeric_value%TYPE := dald_parameter.fnuGetNumeric_Value('COD_TIPO_RELA_NOVE');

  CURSOR cuOrdenNovedad(inuOrderId number) IS
    SELECT NVL(MAX(r.related_order_id), 0) order_id
      FROM or_related_order r
     WHERE r.order_id = inuOrderId
       AND r.rela_order_type_id = nuNoveltyOrder;

  CURSOR cuLoadActivity(inuOT NUMBER) IS
    SELECT MAX(order_activity_id)
      FROM or_order_activity
     WHERE order_id = inuOT;

  CURSOR cuLoadPANOVA(inuTT NUMBER, inuCC NUMBER) IS
    SELECT *
      FROM LDC_NOVELTY_CONDITIONS C
     WHERE C.TASK_TYPE_ID = inuTT
       AND c.causal_id = inuCC
     ORDER BY val_balance;

  CURSOR cuLoadAccWithBalBySusc(inuSusc NUMBER) IS
    SELECT nvl(SUM(AccBal), 0) AccBal
      FROM (SELECT cuco.cuconuse, COUNT(1) AccBal
              FROM servsusc ser, cuencobr cuco
             WHERE ser.sesususc = inuSusc
               AND cuco.cuconuse = ser.sesunuse
               AND cuco.cucofeve < SYSDATE
               AND cuco.cucosacu IS NOT NULL
             GROUP BY cuco.cuconuse);

  CURSOR cuLoadAccWithBalByProd(inuSusc NUMBER) IS
    SELECT CUCO.CUCONUSE, COUNT(1) ACCBAL
      FROM SERVSUSC SER, CUENCOBR CUCO
     WHERE SER.SESUSUSC = inuSusc
       AND CUCO.CUCONUSE = SER.SESUNUSE
       AND CUCO.CUCOFEVE < SYSDATE
       AND CUCO.CUCOSACU IS NOT NULL
     GROUP BY CUCO.CUCONUSE;

  /*=======================================================================
      Unidad         : GenerateNoveltyValue
      Descripcion    : Genera Novedad de Pago a Contratista
      Fecha          : 10.05.2022
  
      Historia de Modificaciones
  
      Fecha       Autor                   Modificaci?n
      ==========  ======================  ====================
      10.05.2022  jgomez@horbath.OSF-197  Ajustes al proceso de acuerdo con
                                          la nueva l?gica de negocio.
  =======================================================================*/
  PROCEDURE GenerateNoveltyValue(inuOperatingUnit IN or_operating_unit.operating_unit_id%TYPE,
                                 inuItemsId       IN ge_items.items_id%TYPE,
                                 inuOrderId       IN OR_order.order_id%TYPE,
                                 inuValue         IN NUMBER,
                                 inuAdressId      IN ab_address.address_id%TYPE) IS
  
  BEGIN
    ut_trace.trace(isbmessage => '[ LDC_BORegisterNovelty.GenerateNovelty.GenerateNoveltyValue',
                   inulevel   => 3);
  
    --<< Arma observacion de la novedad
    nuObservType  := 8901;
    sbObservation := 'Novedad de Pago Automatica Orden [' || inuOrderId || ']';
  
    --<< Registra novedad
    OS_REGISTERNEWCHARGE(inuOperatingUnit,
                         inuItemsId,
                         NULL,
                         inuOrderId,
                         inuValue,
                         NULL,
                         nuObservType,
                         sbObservation,
                         nuError,
                         sbError);
  
    IF nuError != 0 THEN
      --<< Error en la creaci?n de la novedad
      errors.seterror(nuError, sbError);
    
      --<< Inicializa mensaje Log.
      sbObservation := 'Error en el API OS_RegisterNewCharge [' || nuError ||
                       '] - [' || sbError ||
                       '] al crear la novedad de la OT [' || inuOrderId || ']';
    
      --<< Registra log
      LDC_Log_Errors('PANOVA',
                     SYSDATE,
                     SYSDATE,
                     'Error [LDC_BORegisterNovelty.GenerateNovelty.GenerateNoveltyValue]',
                     sbObservation,
                     USERENV('SESSIONID'),
                     USER);
    ELSE
      --<< Obtiene la OT de Novedad
      OPEN cuOrdenNovedad(inuOrderId);
      FETCH cuOrdenNovedad
        INTO nuOrderN;
      CLOSE cuOrdenNovedad;
    
      IF nvl(nuOrderN, 0) != 0 THEN
        --<< Actualiza la direcci?n de la OT de novedad
        daor_order.updexternal_address_id(nuOrderN, inuAdressId);
      
        --<< Obtiene la actividad de la OT de novedad
        OPEN cuLoadActivity(nuOrderN);
        FETCH cuLoadActivity
          INTO nuOrderActivityN;
        CLOSE cuLoadActivity;
      
        --<< Actualiza la direcci?n de la actividad de la novedad
        daor_order_activity.updaddress_id(nuOrderActivityN, inuAdressId);
      ELSE
        --<< Arma mensaje de error
        sbObservation := 'Error al actualizar la informaci?n de la OT de Novedad asociada a la OT [' ||
                         inuOrderId || ']';
      
        --<< Error en el proceso de creaci?n de la OT de novedad (No en API)
        LDC_Log_Errors('PANOVA',
                       SYSDATE,
                       SYSDATE,
                       'Error [LDC_BORegisterNovelty.GenerateNovelty.GenerateNoveltyValue]',
                       sbObservation,
                       USERENV('SESSIONID'),
                       USER);
      
      END IF;
    END IF;
    ut_trace.trace(isbmessage => '] LDC_BORegisterNovelty.GenerateNovelty.GenerateNoveltyValue',
                   inulevel   => 3);
  EXCEPTION
    WHEN OTHERS THEN
      RAISE EX.CONTROLLED_ERROR;
  END GenerateNoveltyValue;

  --OSF-1110------------------------------------------
  /*=======================================================================
      Unidad         : GetAccWithBalByProd
      Descripcion    : Obtener las cuentas de cobro con saldo pendientes antes del pago o negociacion y
                       validarlas con las cuentas de cobros con saldo pendiente despues del pago o negociacion
      Fecha          : 29/05/2023
  
      Historia de Modificaciones
  
      Fecha       Autor                   Modificaci?n
      ==========  ======================  ====================
  =======================================================================*/
  FUNCTION GetAccWithBalByProd(inuContraro IN open.servsusc.sesususc%TYPE)
    return boolean is
  
    -- Variable declarations
    l_INUPRODUCTID            NUMBER;
    l_IDTDATE                 DATE;
    l_ONUCURRENTACCOUNTTOTAL  NUMBER;
    l_ONUDEFERREDACCOUNTTOTAL NUMBER;
    l_ONUCREDITBALANCE        NUMBER;
    l_ONUCLAIMVALUE           NUMBER;
    l_ONUDEFCLAIMVALUE        NUMBER;
    l_OTBBALANCEACCOUNTS      FA_BOACCOUNTSTATUSTODATE.TYTBBALANCEACCOUNTS;
    l_OTBDEFERREDBALANCE      FA_BOACCOUNTSTATUSTODATE.TYTBDEFERREDBALANCE;
  
    sbIndexAcc varchar2(20);
    sbIndexDif varchar2(20);
  
    cursor cuservicios(inuContrato number) is
      select a.* from open.servsusc a where a.sesususc = inuContrato;
  
    rfcuservicios cuservicios%rowtype;
  
    nuCuentaCobro            open.cuencobr.cucocodi%type;
    nuCuenCobrCantidadPreLEg number;
    nuCuenCobrCantidadPosLEg number;
  
    oblKeepProcess boolean;
  
    --Cursor para establecer las cuentas de cobro con saldo pendiente que maneja
    --el producto en el momento del pago
    CURSOR cuGetAccWithBalByProd(inuSusc NUMBER, InuServicio Number) IS
      SELECT COUNT(cuco.cucocodi) ACCBAL
        FROM SERVSUSC SER, CUENCOBR CUCO
       WHERE SER.SESUSUSC = inuSusc
         and ser.sesunuse = InuServicio
         AND CUCO.CUCONUSE = SER.SESUNUSE
         AND CUCO.CUCOFEVE < SYSDATE
         AND CUCO.CUCOSACU IS NOT NULL;
  
  BEGIN
  
    /*ut_trace.Init;
    ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
    ut_trace.SetLevel(99);*/
  
    oblKeepProcess := FALSE;
    l_IDTDATE      := trunc(sysdate); --to_date('25/05/2023','DD/MM/YYYY');
    for rfcuservicios in cuservicios(inuContraro) loop
    
      -- Variable initializations
      l_INUPRODUCTID := rfcuservicios.sesunuse;
    
      -- Call
      FA_BOACCOUNTSTATUSTODATE.PRODUCTBALANCEACCOUNTSTODATE(INUPRODUCTID            => l_INUPRODUCTID,
                                                            IDTDATE                 => l_IDTDATE,
                                                            ONUCURRENTACCOUNTTOTAL  => l_ONUCURRENTACCOUNTTOTAL,
                                                            ONUDEFERREDACCOUNTTOTAL => l_ONUDEFERREDACCOUNTTOTAL,
                                                            ONUCREDITBALANCE        => l_ONUCREDITBALANCE,
                                                            ONUCLAIMVALUE           => l_ONUCLAIMVALUE,
                                                            ONUDEFCLAIMVALUE        => l_ONUDEFCLAIMVALUE,
                                                            OTBBALANCEACCOUNTS      => l_OTBBALANCEACCOUNTS,
                                                            OTBDEFERREDBALANCE      => l_OTBDEFERREDBALANCE);
    
      sbIndexAcc               := l_OTBBALANCEACCOUNTS.first;
      nuCuentaCobro            := 0;
      nuCuenCobrCantidadPreLEg := 0;
      if sbIndexAcc is not null then
        --Identificar cuentas de cobro con saldo pendiente antes de la legalizacion
        ut_trace.trace('Producto: ' || rfcuservicios.sesunuse || ' ', 3);
        ut_trace.trace('*****Recorrido de cuenta de cobro con saldo antes de la legalizacion',
                       3);
        loop
          if nuCuentaCobro <> l_OTBBALANCEACCOUNTS(sbIndexAcc).cucocodi then
            ut_trace.trace('**********Cuenta: ' || l_OTBBALANCEACCOUNTS(sbIndexAcc)
                           .cucocodi || ' ',
                           3);
            nuCuentaCobro            := l_OTBBALANCEACCOUNTS(sbIndexAcc)
                                        .cucocodi;
            nuCuenCobrCantidadPreLEg := nuCuenCobrCantidadPreLEg + 1;
          end if;
        
          sbIndexAcc := l_OTBBALANCEACCOUNTS.next(sbIndexAcc);
          exit when sbIndexAcc is null;
        end loop;
        ut_trace.trace('***************Cuentas de cobros pedientes prelegalizacion[' ||
                       nuCuenCobrCantidadPreLEg || ']',
                       3);
      
        if cuGetAccWithBalByProd%ISOPEN then
          close cuGetAccWithBalByProd;
        end if;
        open cuGetAccWithBalByProd(nuContrato, rfcuservicios.sesunuse);
        fetch cuGetAccWithBalByProd
          into nuCuenCobrCantidadPosLEg;
        close cuGetAccWithBalByProd;
        ut_trace.trace('***************Cuentas de cobros pedientes poslegalizacion[' ||
                       nuCuenCobrCantidadPosLEg || ']',
                       3);
      
        if nuCuenCobrCantidadPreLEg <= 1 or nuCuenCobrCantidadPosLEg <> 1 then
          return(TRUE);
        end if;
      
      else
        ut_trace.trace('***************Sin registros de cuentas', 3);
      end if;
      ut_trace.trace('-----------------------------------------------------',
                     3);
    end loop;
    return(FALSE);
  end GetAccWithBalByProd;
  -------------------------------------------------------

BEGIN

  ut_trace.Init;
  ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
  ut_trace.SetLevel(99);

  ut_trace.trace('[ LDC_BORegisterNovelty.GenerateNovelty', 1);

  --<< Obtiene ID de orden en proceso de legalizacion
  nuOrderId := 144862568; --or_bolegalizeorder.fnuGetCurrentOrder;

  --<< Obtiene Causal de legalizaci?n
  nuCausalId := or_boorder.fnugetordercausal(nuOrderId);

  --<< Obtiene el tipo de trabajo
  nuTaskTypeId := daor_order.fnugettask_type_id(nuOrderId);

  --<< Obtiene la actividad de la OT
  OPEN cuLoadActivity(nuOrderId);
  FETCH cuLoadActivity
    INTO nuOrderActivity;
  CLOSE cuLoadActivity;

  --<< Obtiene Producto, Estado financiero y Contrato asociado al producto GAS de la OT.
  nuProductId := daor_order_activity.fnugetproduct_id(nuOrderActivity);
  sbEstaFinan := pktblservsusc.fsbgetsesuesfn(nuProductId);
  nuContrato  := pktblservsusc.fnugetsesususc(nuProductId);
  ut_trace.trace('Contrato[' || nuContrato || ']', 1);

  --<< Obtiene Direccion , localidad y departamento y ciclo
  nuAdressId   := daor_order.fnugetexternal_address_id(nuOrderId);
  nuLocality   := daab_address.fnugetgeograp_location_id(nuAdressId);
  nuDepartment := dage_geogra_location.fnugetgeo_loca_father_id(nuLocality);
  nucurciclo   := Pktblservsusc.Fnugetsesucicl(nuProductId);

  --<< Obtiene unidad de trabajo asignada
  nuOperUnitId := daor_order.fnugetoperating_unit_id(nuOrderId);

  --<< No genera novedad para las unidades de trabajo del nuevo esquema de liquidaci?n
  blKeepProcess := 1 =
                   dald_parameter.fnuGetNumeric_Value('VARIABLE_EJECUTA_VAL_NOVE');

  IF blKeepProcess THEN
    SELECT COUNT(1)
      INTO nuconta
      FROM ldc_const_unoprl ue
     WHERE ue.unidad_operativa = nuOperUnitId;
    IF nuconta >= 1 THEN
      --<< Arma mensaje de log
      sbObservation := 'No genera novedad para las UT del nuevo esquema. LDPAR [VARIABLE_EJECUTA_VAL_NOVE])';
    
      /*LDC_Log_Errors('PANOVA',
      SYSDATE,
      SYSDATE,
      'Error [LDC_BORegisterNovelty.GenerateNovelty]',
      sbObservation,
      USERENV('SESSIONID'),
      USER);*/
      ut_trace.trace(sbObservation, 1);
    
      RETURN;
    END IF;
  END IF;

  --<< Recorre la configuracion realizada en PANOVA
  blKeepProcess := TRUE;
  FOR eachCondition IN cuLoadPANOVA(nuTaskTypeId, nuCausalId) LOOP
  
    IF nuTaskTypeId = eachCondition.Task_Type_Id AND
       nuCausalId = eachCondition.Causal_Id AND
       nuDepartment = nvl(eachCondition.Department_Id, nuDepartment) AND
       nuLocality = nvl(eachCondition.Locality_Id, nuLocality) AND
       nucurciclo = nvl(eachCondition.Ciclo, nucurciclo) THEN
    
      --<< Validacion de Saldo
      nuValidSald := eachCondition.Val_Balance;
    
      IF nuValidSald IS NULL THEN
        --<< Genera novedad sin validar cartera
        --<< Detiene evaluaci?n de registros de configuraci?n de novedad
        blKeepProcess := FALSE;
      
      ELSIF nuValidSald = 1 THEN
        --<< Valida las cuentas con saldo vencidas del contrato (todos los tipos de producto)
        OPEN cuLoadAccWithBalBySusc(nuContrato);
        FETCH cuLoadAccWithBalBySusc
          INTO nuAccWithBal;
        CLOSE cuLoadAccWithBalBySusc;
      
        --<< Se crear? la novedad SOLO SI el CONTRATO Tiene 0 cuentas de cobro con saldo vencido.
        IF nuAccWithBal = 0 THEN
          --<< Detiene evaluaci?n de registros de configuraci?n de novedad
          blKeepProcess := FALSE;
        END IF;
        IF blKeepProcess THEN
          ut_trace.trace('nuValidSald[' || nuValidSald ||
                         '] := blKeepProcess [TRUE]',
                         1);
        else
          ut_trace.trace('nuValidSald[' || nuValidSald ||
                         '] := blKeepProcess [false]',
                         1);
        end if;
      ELSIF nuValidSald = 2 THEN
        IF sbEstaFinan = 'A' OR sbEstaFinan = 'D' THEN
          --<< Se crear? novedad SOLO si el producto de GAS esta AL DIA o EN DEUDA
          --<< Detiene evaluaci?n de registros de configuraci?n de novedad
          blKeepProcess := FALSE;
        END IF;
        IF blKeepProcess THEN
          ut_trace.trace('nuValidSald[' || nuValidSald ||
                         '] := blKeepProcess [TRUE]',
                         1);
        else
          ut_trace.trace('nuValidSald[' || nuValidSald ||
                         '] := blKeepProcess [false]',
                         1);
        end if;
      ELSIF nuValidSald = 3 THEN
      
        --Inicio OSF-1110
        --Servicio GetAccWithBalByProd para establecer si realiza sincronizacion en las cuentas de cobro con saldo
        --pendiente de los servicios asociados al contrato.
        nuFlag := 0;
        --Valida cada producto del contrato y confirma si tiene UNA sola cuenta de cobro con saldo vencido para Sincronizacion
        FOR eachProduct IN cuLoadAccWithBalByProd(nuContrato) LOOP
          IF eachProduct.Accbal > 1 THEN
            nuFlag := nuFlag + 1;
          END IF;
        END LOOP;
        if nuFlag = 0 then
          blKeepProcess := FALSE; --OSF-1360
        end if;
        --Fin OSF-1110
        IF blKeepProcess THEN
          ut_trace.trace('nuValidSald[' || nuValidSald ||
                         '] := blKeepProcess [TRUE]',
                         1);
        else
          ut_trace.trace('nuValidSald[' || nuValidSald ||
                         '] := blKeepProcess [FALSE]',
                         1);
        end if;
      END IF;
    
      --<< Valida creacion de novedad      
      IF NOT blKeepProcess THEN
        --<< Genera novedad (OT con item de pago x gestion de contratista)
        GenerateNoveltyValue(nuOperUnitId,
                             eachCondition.item_id,
                             nuOrderId,
                             eachCondition.value_reference,
                             nuAdressId);
      
        --<< Finaliza validaci?n de configuraci?n
        EXIT;
      ELSE
        --<< Log de ejecuci?n
        sbObservation := 'No se genera novedad para la OT [' || nuOrderId ||
                         ']. Ninguna de las configuraciones realizadas en PANOVA retorna ?XITO al proceso';
      
        --<< Log de ejecuci?n
        /*LDC_Log_Errors('PANOVA',
        SYSDATE,
        SYSDATE,
        'Error [LDC_BORegisterNovelty.GenerateNovelty.GenerateNoveltyValue]',
        sbObservation,
        USERENV('SESSIONID'),
        USER);*/
        ut_trace.trace(sbObservation, 5);
      
      END IF;
    else
      --<< Log de ejecuci?n
      sbObservation := 'No se genera novedad para la OT [' || nuOrderId ||
                       ']. Las caracter?sticas de la OT no coinciden con lo configurado en la funcionalidad PANOVA';
    
      --<< Log de ejecuci?n
      /*LDC_Log_Errors('PANOVA',
      SYSDATE,
      SYSDATE,
      'Error [LDC_BORegisterNovelty.GenerateNovelty.GenerateNoveltyValue]',
      sbObservation,
      USERENV('SESSIONID'),
      USER);*/
    
      ut_trace.trace(sbObservation, 5);
    
    END IF;
  END LOOP;
  rollback;
  ut_trace.trace('] LDC_BORegisterNovelty.GenerateNovelty', 1);

end;
0
0
