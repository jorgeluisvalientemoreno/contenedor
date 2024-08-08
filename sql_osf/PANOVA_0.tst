PL/SQL Developer Test script 3.0
455
-- Created on 14/03/2023 by JORGE VALIENTE 
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
        nuKeepProcess    NUMBER;
        nuOrderId        open.OR_order.order_id%TYPE;
        nuCausalId       open.ge_causal.causal_id%TYPE;
        nuTaskTypeId     open.OR_task_type.task_type_id%TYPE;
        nuContrato       open.servsusc.sesususc%TYPE;
        sbEstaFinan      open.servsusc.sesuesfn%TYPE;
        nuOperUnitId     open.OR_order.operating_unit_id%TYPE;
        nuProductId      open.servsusc.sesunuse%TYPE;
        nuAdressId       open.ab_address.address_id%TYPE;
        nuDepartment     open.ge_geogra_location.geograp_location_id%TYPE;
        nuLocality       open.ge_geogra_location.geograp_location_id%TYPE;
        nucurciclo       open.ciclo.ciclcodi%TYPE;
        nuNoveltyOrder   open.ld_parameter.numeric_value%TYPE;-- := open.dald_parameter.fnuGetNumeric_Value('COD_TIPO_RELA_NOVE');

        CURSOR cuOrdenNovedad (inuOrderId number) IS
            SELECT NVL(MAX(r.related_order_id), 0) order_id
              FROM open.or_related_order r
             WHERE r.order_id = inuOrderId
               AND r.rela_order_type_id = nuNoveltyOrder;

        CURSOR cuLoadActivity(inuOT NUMBER) IS
            SELECT MAX(order_activity_id)
              FROM open.or_order_activity
             WHERE order_id = inuOT;

        CURSOR cuLoadPANOVA(inuTT NUMBER,
                            inuCC NUMBER) IS
            SELECT *
              FROM open.LDC_NOVELTY_CONDITIONS C
             WHERE C.TASK_TYPE_ID = inuTT
               AND c.causal_id = inuCC;

        CURSOR cuLoadAccWithBalBySusc(inuSusc NUMBER) IS
            SELECT nvl(SUM(AccBal), 0) AccBal
              FROM (SELECT cuco.cuconuse
                          ,COUNT(1) AccBal
                      FROM open.servsusc ser
                          ,open.cuencobr cuco
                     WHERE ser.sesususc = inuSusc
                       AND cuco.cuconuse = ser.sesunuse
                       AND cuco.cucofeve < SYSDATE
                       AND cuco.cucosacu IS NOT NULL
                     GROUP BY cuco.cuconuse);

        CURSOR cuLoadAccWithBalByProd(inuSusc NUMBER) IS
            SELECT CUCO.CUCONUSE
                  ,COUNT(1) ACCBAL
              FROM open.SERVSUSC SER
                  ,open.CUENCOBR CUCO
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
        PROCEDURE GenerateNoveltyValue(inuOperatingUnit IN open.or_operating_unit.operating_unit_id%TYPE,
                                       inuItemsId       IN open.ge_items.items_id%TYPE,
                                       inuOrderId       IN open.OR_order.order_id%TYPE,
                                       inuValue         IN NUMBER,
                                       inuAdressId      IN open.ab_address.address_id%TYPE) IS

        BEGIN
            dbms_output.put_line('[ LDC_BORegisterNovelty.GenerateNovelty.GenerateNoveltyValue');

            --<< Arma observacion de la novedad
            nuObservType  := 8901;
            sbObservation := 'Novedad de Pago Automatica Orden [' || inuOrderId || ']';

            --<< Registra novedad
            dbms_output.put_line('OS_REGISTERNEWCHARGE(inuOperatingUnit: '||inuOperatingUnit||','||
                                                       'inuItemsId: '||inuItemsId||','||
                                                       'NULL: '||NULL||','||
                                                       'inuOrderId: '||inuOrderId||','||
                                                       'inuValue: '||inuValue||','||
                                                       'NULL: '||NULL||','||
                                                       'nuObservType: '||nuObservType||','||
                                                       'sbObservation: '||sbObservation||','||
                                                       'nuError: '||nuError||','||
                                                       'sbError: '||sbError||')');

            IF nuError != 0
            THEN
                --<< Error en la creaci?n de la novedad
                --errors.seterror(nuError, sbError);

                --<< Inicializa mensaje Log.
                sbObservation := 'Error en el API OS_RegisterNewCharge ['||
                                  nuError||'] - ['||sbError||
                                  '] al crear la novedad de la OT [' || inuOrderId || ']';

                --<< Registra log
                /*LDC_Log_Errors('PANOVA',
                                SYSDATE,
                                SYSDATE,
                               'Error [LDC_BORegisterNovelty.GenerateNovelty.GenerateNoveltyValue]',
                                sbObservation,
                                USERENV('SESSIONID'),
                                USER);*/
            ELSE
                --<< Obtiene la OT de Novedad
                OPEN cuOrdenNovedad (inuOrderId);
                FETCH cuOrdenNovedad
                    INTO nuOrderN;
                CLOSE cuOrdenNovedad;

                IF nvl(nuOrderN, 0) != 0
                THEN
                    --<< Actualiza la direcci?n de la OT de novedad
                    --"OPEN".daor_order.updexternal_address_id(nuOrderN, inuAdressId);

                    --<< Obtiene la actividad de la OT de novedad
                    OPEN cuLoadActivity(nuOrderN);
                    FETCH cuLoadActivity
                        INTO nuOrderActivityN;
                    CLOSE cuLoadActivity;

                    --<< Actualiza la direcci?n de la actividad de la novedad
                    --"OPEN".daor_order_activity.updaddress_id(nuOrderActivityN, inuAdressId);
                ELSE
                    --<< Arma mensaje de error
                    sbObservation := 'Error al actualizar la informaci?n de la OT de Novedad asociada a la OT [' ||
                                     inuOrderId || ']';

                    --<< Error en el proceso de creaci?n de la OT de novedad (No en API)
                    /*LDC_Log_Errors('PANOVA',
                                    SYSDATE,
                                    SYSDATE,
                                   'Error [LDC_BORegisterNovelty.GenerateNovelty.GenerateNoveltyValue]',
                                    sbObservation,
                                    USERENV('SESSIONID'),
                                    USER);*/

                END IF;
            END IF;
            dbms_output.put_line('] LDC_BORegisterNovelty.GenerateNovelty.GenerateNoveltyValue');
        EXCEPTION
            WHEN OTHERS THEN
                dbms_output.put_line('RAISE EX.CONTROLLED_ERROR');
        END GenerateNoveltyValue;

    BEGIN
        dbms_output.put_line('[ LDC_BORegisterNovelty.GenerateNovelty');

        begin
          select a.numeric_value into nuNoveltyOrder 
            from open.ld_parameter a 
           where a.parameter_id='COD_TIPO_RELA_NOVE';
        exception
          when others then
            null;
        end;
        dbms_output.put_line('Actividad de orden de novedad: '|| nuNoveltyOrder);        

        --<< Obtiene ID de orden en proceso de legalizacion
        nuOrderId := 143158555; --or_bolegalizeorder.fnuGetCurrentOrder;
        dbms_output.put_line('Orden legalizada: '|| nuOrderId);

        --<< Obtiene Causal de legalizaci?n
        --nuCausalId := "OPEN".daor_order.fnugetcausal_id(nuOrderId);
        begin
          select a.causal_id into nuCausalId 
            from open.or_order a 
           where a.order_id=nuOrderId;
        exception
          when others then
            null;
        end;     
        dbms_output.put_line('Causal legalizacion: '|| nuCausalId);   

        --<< Obtiene el tipo de trabajo
        --nuTaskTypeId := "OPEN".daor_order.fnugettask_type_id(nuOrderId);
        begin
          select a.task_type_id into nuTaskTypeId 
            from open.or_order a 
           where a.order_id=nuOrderId;
        exception
          when others then
            null;
        end;        
        dbms_output.put_line('Tipo Trabajo: '|| nuTaskTypeId);   

        --<< Obtiene la actividad de la OT
        OPEN cuLoadActivity(nuOrderId);
        FETCH cuLoadActivity
            INTO nuOrderActivity;
        CLOSE cuLoadActivity;
        dbms_output.put_line('Identificador orden actividad: '|| nuOrderActivity);  
        
        --<< Obtiene Producto, Estado financiero y Contrato asociado al producto GAS de la OT.
        --nuProductId := "OPEN".daor_order_activity.fnugetproduct_id(nuOrderActivity);
        begin
          select oa.product_id into nuProductId 
            from open.or_order_activity oa 
           where oa.order_activity_id=nuOrderActivity;
        exception
          when others then
            null;
        end;  
        dbms_output.put_line('Producto: '|| nuProductId);         
                 
        --sbEstaFinan := pktblservsusc.fsbgetsesuesfn(nuProductId);
        begin
          select s.sesuesfn into sbEstaFinan 
            from open.servsusc s 
           where s.sesunuse=nuProductId;
        exception
          when others then
            null;
        end;         
        dbms_output.put_line('Estado Financiero: '|| sbEstaFinan);         
         
        --nuContrato  := pktblservsusc.fnugetsesususc(nuProductId);
        begin
          select s.sesususc into nuContrato 
            from open.servsusc s 
           where s.sesunuse=nuProductId;
        exception
          when others then
            null;
        end; 
        dbms_output.put_line('Contrato: '|| nuContrato);         
        
        --<< Obtiene Direccion , localidad y departamento y ciclo
        --nuAdressId   := "OPEN".daor_order.fnugetexternal_address_id(nuOrderId);
        begin
          select a.external_address_id into nuAdressId 
            from open.or_order a 
           where a.order_id=nuOrderId;
        exception
          when others then
            null;
        end;       
        dbms_output.put_line('Codigo Direccion: '|| nuAdressId);         
           
        --nuLocality   := daab_address.fnugetgeograp_location_id(nuAdressId);
        begin
          select aa.geograp_location_id into nuLocality 
            from open.ab_address aa 
           where aa.address_id=nuAdressId;
        exception
          when others then
            null;
        end;      
        dbms_output.put_line('Codigo Localidad: '|| nuLocality);                 
            
        --nuDepartment := dage_geogra_location.fnugetgeo_loca_father_id(nuLocality);
        begin
          select g.geo_loca_father_id into nuDepartment 
            from open.ge_geogra_location g 
           where g.geograp_location_id=nuLocality;
        exception
          when others then
            null;
        end;          
        dbms_output.put_line('Codigo Departamento: '|| nuDepartment);                 
        
        --nucurciclo   := Pktblservsusc.Fnugetsesucicl(nuProductId);
        begin
          select s.sesucicl into nucurciclo 
            from open.servsusc s 
           where s.sesunuse=nuProductId;
        exception
          when others then
            null;
        end;  
        dbms_output.put_line('Ciclo: '|| nucurciclo);                 
        
        --<< Obtiene unidad de trabajo asignada
        --nuOperUnitId := "OPEN".daor_order.fnugetoperating_unit_id(nuOrderId);
        begin
          select a.operating_unit_id into nuOperUnitId 
            from open.or_order a 
           where a.order_id=nuOrderId;
        exception
          when others then
            null;
        end;     
        dbms_output.put_line('Unidad Operativa: '|| nuOperUnitId);  

        --<< No genera novedad para las unidades de trabajo del nuevo esquema de liquidaci?n
        --blKeepProcess := 1 = dald_parameter.fnuGetNumeric_Value('VARIABLE_EJECUTA_VAL_NOVE');

        begin
          select a.numeric_value into nuKeepProcess 
            from open.ld_parameter a 
           where a.parameter_id='VARIABLE_EJECUTA_VAL_NOVE';
           if 1=  nuKeepProcess then
              blKeepProcess := true;
           else
              blKeepProcess := false;
           end if;
        exception
          when others then
            blKeepProcess := false;
        end;
        dbms_output.put_line('VARIABLE_EJECUTA_VAL_NOVE: '|| nuKeepProcess);

        IF blKeepProcess
        THEN
            SELECT COUNT(1)
              INTO nuconta
              FROM open.ldc_const_unoprl ue
             WHERE ue.unidad_operativa = nuOperUnitId;
            IF nuconta >= 1
            THEN
                --<< Arma mensaje de log
                sbObservation := 'No genera novedad para las UT del nuevo esquema. LDPAR [VARIABLE_EJECUTA_VAL_NOVE])';
                dbms_output.put_line('Error: '|| sbObservation);

                /*LDC_Log_Errors('PANOVA',
                                SYSDATE,
                                SYSDATE,
                               'Error [LDC_BORegisterNovelty.GenerateNovelty]',
                                sbObservation,
                                USERENV('SESSIONID'),
                                USER);*/

                RETURN;
            END IF;
        END IF;

        --<< Recorre la configuracion realizada en PANOVA
        blKeepProcess := TRUE;
        FOR eachCondition IN cuLoadPANOVA(nuTaskTypeId, nuCausalId)
        LOOP

            IF nuTaskTypeId = eachCondition.Task_Type_Id
               AND nuCausalId = eachCondition.Causal_Id
               AND nuDepartment = nvl(eachCondition.Department_Id, nuDepartment)
               AND nuLocality = nvl(eachCondition.Locality_Id, nuLocality)
               AND nucurciclo = nvl(eachCondition.Ciclo, nucurciclo)
            THEN

                --<< Validacion de Saldo
                nuValidSald := eachCondition.Val_Balance;

                IF nuValidSald IS NULL
                THEN
                    --<< Genera novedad sin validar cartera
                    --<< Detiene evaluaci?n de registros de configuraci?n de novedad
                    blKeepProcess := FALSE;

                ELSIF nuValidSald = 1
                THEN
                    --<< Valida las cuentas con saldo vencidas del contrato (todos los tipos de producto)
                    OPEN cuLoadAccWithBalBySusc(nuContrato);
                    FETCH cuLoadAccWithBalBySusc
                        INTO nuAccWithBal;
                    CLOSE cuLoadAccWithBalBySusc;

                    --<< Se crear? la novedad SOLO SI el CONTRATO Tiene 0 cuentas de cobro con saldo vencido.
                    IF nuAccWithBal = 0
                    THEN
                        --<< Detiene evaluaci?n de registros de configuraci?n de novedad
                        blKeepProcess := FALSE;
                    END IF;

                ELSIF nuValidSald = 2
                THEN
                    IF sbEstaFinan = 'A'
                       OR sbEstaFinan = 'D'
                    THEN
                        --<< Se crear? novedad SOLO si el producto de GAS esta AL DIA o EN DEUDA
                        --<< Detiene evaluaci?n de registros de configuraci?n de novedad
                        blKeepProcess := FALSE;
                    END IF;
                ELSIF nuValidSald = 3
                THEN

                    nuFlag := 0;
                    --<< Se crear? novedad SOLO si cada producto del contrato tiene UNA sola cuenta de cobro con saldo vencido (Sincronizaci?n)
                    FOR eachProduct IN cuLoadAccWithBalByProd(nuContrato)
                    LOOP
                        IF eachProduct.Accbal != 1
                        THEN
                            nuFlag := nuFlag + 1;
                        END IF;
                    END LOOP;

                    blKeepProcess := nuFlag > 0;
                END IF;

                --<< Valida creacion de novedad
                IF NOT blKeepProcess
                THEN
                    --<< Genera novedad (OT con item de pago x gestion de contratista)
                    dbms_output.put_line('GenerateNoveltyValue(nuOperUnitId: '||nuOperUnitId||','||
                                                               'eachCondition.item_id: '||eachCondition.item_id||','||
                                                               'nuOrderId: '||nuOrderId||','||
                                                               'eachCondition.value_reference: '||eachCondition.value_reference||','||
                                                               'nuAdressId: '||nuAdressId ||')');

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
                END IF;
            else
                --<< Log de ejecuci?n
                    sbObservation := 'No se genera novedad para la OT [' || nuOrderId ||
                                     ']. Las caracter?sticas de la OT no coinciden con lo configurado en la funcionalidad PANOVA';

                    --<< Log de ejecuci?n
                    /*LDC_Log_Errors('PANOVA',
                                    SYSDATE,
                                    SYSDATE,
                                   'Error [LDC_BORegisterNovelty.GenerateNovelty.GenerateNoveltyValue]', sbObservation,
                                   USERENV('SESSIONID'), USER);*/

            END IF;
        END LOOP;

        dbms_output.put_line('] LDC_BORegisterNovelty.GenerateNovelty');


  
end;
0
0
