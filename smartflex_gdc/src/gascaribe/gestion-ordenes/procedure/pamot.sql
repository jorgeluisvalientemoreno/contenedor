CREATE OR REPLACE PROCEDURE PAMOT
(
    inuProgramacion  in ge_process_schedule.process_schedule_id%type
)
AS

/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : PAMOT
    Descripcion    :
    Autor          : Sayra Ocoro
    Fecha          : 20/08/2013
    ============  ===================
    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    10-09-2014        agordillo
    27-11-2019        F.Castro          Cambio 253 Se modifica cursor principal para que el cruce se realice tanto si la actividad
                                        tiene el contrato como si no lo tiene sino que tiene el producto  
    10-05-2023        jcatuchemvm       OSF-1074: Se ajustan los querys sbQuery1 y sbQuery2 para optimización.
                                        Se cambia el uso de la funcion LDC_BOUTILITIES.SPLITSTRINGS por un expresión regular 
                                        para separar la cadena "sbStatus" con los estados en la busqueda de las órdenes
                                        Se corrige error de conversión cuando se intenta recorrer la tabla l_tab añadiendo
                                        validación de tamaño para cuando el cursor de las órdenes no retorna resultados
                                        Se ajusta asunto del correo para indicar la BD desde donde se genera la notificación.
	24/07/2023		  jerazomvm			CASO OSF-1261:
										1. Se reemplaza el llamado del API os_legalizeorders
										   por el API api_legalizeorders.	
										2. Se reemplaza el manejo de errores ex y errors por Pkg_error.
    18/06/2023        jpinedc           OSF-2605: * Se usa pkg_Correo
                                        * Ajustes por estándares
  ******************************************************************/
    type t_object_id_tab is table of or_order.order_id%type;

    cnuNULL_ATTRIBUTE           constant number := 2126;
    sbMESSAGE                   ge_boInstanceControl.stysbValue;
    sbCAUSAL_ID                 ge_boInstanceControl.stysbValue;
    sbDESCRIPTION               ge_boInstanceControl.stysbValue;
    sbOPERATING_UNIT_ID         ge_boInstanceControl.stysbValue;
    sbPERSON_ID                 ge_boInstanceControl.stysbValue;
    sbE_MAIL                    ge_boInstanceControl.stysbValue;
    sbTASK_TYPE_ID              ge_boInstanceControl.stysbValue;
    sbCICLCODI                  ge_boInstanceControl.stysbValue;
    sbCREATED_DATE              ge_boInstanceControl.stysbValue;
    sbASSIGNED_DATE             ge_boInstanceControl.stysbValue;
    sbORDER_ID                  ge_boInstanceControl.stysbValue;
    sbALLOW_UPDATE              ge_boInstanceControl.stysbValue;

    idtExeInitialDate           date := sysdate;
    idtExeFinalDate             date := sysdate;
    idtChangeDate               date := sysdate;
    nuOrderActivityId           or_order_activity.order_activity_id%type;
    ISBDATAORDER                varchar2(2000);
    nuCant                      number;
    sbQuery                     varchar2(2000);
    sbQuery1                    varchar2(2000);
    sbQuery2                    varchar2(2000);
    isbTaskTypeIds              ld_parameter.value_chain%type;
    nuBeforeState               servsusc.sesuesco%type;
    nuProductId                 servsusc.sesunuse%type;
    sbParametros                GE_PROCESS_SCHEDULE.PARAMETERS_%type;
    l_tab                       t_object_id_tab;
    sbStatus                    varchar2(20);
    sbSeparador                 ld_parameter.value_chain%type := pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SEPARADOR_PAMOT');
    rfCursor                    Constants_Per.tyRefCursor;
    inuIdOrder                  or_order.order_id%type;
    onuErrorCode                NUMBER;
    osbErrorMessage             VARCHAR2(2000);
    sbSubject                   VARCHAR2(3000);
    sbMessage0                  VARCHAR2(3000);
    nuCount                     number := 0;
    sbEnvioCorreo               varchar2(10);
    nuUnidadAsignada            or_order.operating_unit_id%type;
    blPersonAsig                boolean;
    nuPersonLegaliza            number;
    sbObservacion               varchar2(2000);

    ---Cursor para obtener el estado de corte anterior asociado al producto
    cursor cuBeforeStatus (inuProductId servsusc.sesunuse%type) is
    select HCECECAN
    from hicaesco
    where hcecnuse = inuProductId
    and hcecfech = (select max (hcecfech) from hicaesco where  hcecnuse = inuProductId);


    nuErrorCode     NUMBER;
    sbErrorMesse    VARCHAR2(4000);
    cnuCommentType  CONSTANT NUMBER := 1277;
    sbOrderComme    VARCHAR2(200) := 'Anulada desde PAMOT';

  BEGIN
      pkg_Traza.Trace('INICIO PAMOT', 10);
      
      sbParametros 			:= dage_process_schedule.fsbgetparameters_(inuProgramacion);
      sbMESSAGE 			:= ut_string.getparametervalue  (sbParametros,'MESSAGE','|','=');
      sbTASK_TYPE_ID 		:= ut_string.getparametervalue(sbParametros,'TASK_TYPE_ID','|','=');
      sbCICLCODI 			:= ut_string.getparametervalue(sbParametros,'CICLCODI','|','=');
      sbCREATED_DATE 		:= ut_string.getparametervalue(sbParametros, 'CREATED_DATE','|','=');
      sbASSIGNED_DATE 		:= ut_string.getparametervalue(sbParametros, 'ASSIGNED_DATE','|','=');
      sbORDER_ID 			:= ut_string.getparametervalue(sbParametros, 'ORDER_COMMENT','|','=');
      sbCAUSAL_ID 			:= ut_string.getparametervalue(sbParametros, 'CAUSAL_ID','|','=');
      sbOPERATING_UNIT_ID 	:= ut_string.getparametervalue(sbParametros,'OPERATING_UNIT_ID','|','=');
      sbPERSON_ID 			:= ut_string.getparametervalue(sbParametros,'PERSON_ID','|','=');
      sbE_MAIL 				:= ut_string.getparametervalue(sbParametros,'E_MAIL','|','=');
      sbALLOW_UPDATE 		:= ut_string.getparametervalue(sbParametros,'ALLOW_UPDATE','|','=');

    if sbMESSAGE = 'ANULAR' then
       sbStatus := '0,5';
    else
       pkg_Traza.Trace('sbMESSAGE => '||sbMESSAGE,11);
       pkg_Traza.Trace('sbOPERATING_UNIT_ID => '||sbOPERATING_UNIT_ID,11);
       --Validar que la Unidad Operativa no sea nula
       if (sbOPERATING_UNIT_ID is null) then
          Pkg_error.SetErrorMessage(cnuNULL_ATTRIBUTE, 'Unidad de Trabajo');
       end if;
       --Validar que la Persona de laUnidad Operativa no sea nula
       if (sbPERSON_ID is null) then
          Pkg_error.SetErrorMessage(cnuNULL_ATTRIBUTE, 'Personal de la U. Trabajo');
       end if;
       -- Para legalizar las ordenes deben estan en estado 5 Asignadas
       sbStatus := '5';
    end if;

    -- Consulta las Ordenes
                
    sbQuery1 := 'with estado(status) as
                (
                    SELECT to_number(regexp_substr('''||sbStatus||''',''[^,]+'',1,LEVEL)) 
                    FROM dual
                    CONNECT BY regexp_substr('''||sbStatus||''', ''[^,]+'', 1, LEVEL) IS NOT NULL
                ) select distinct or_order.order_id
                from or_order, or_order_activity, servsusc
                where or_order_activity.subscription_id = servsusc.sesususc
                and order_status_id in (select status from estado)
                and or_order_activity.order_id = or_order.order_id and or_order.task_type_id = to_number('''||sbTASK_TYPE_ID||''')';
    
    sbQuery2 := 'select distinct or_order.order_id
                from or_order, or_order_activity, servsusc
                where or_order_activity.product_id = servsusc.sesunuse
                and order_status_id in (select status from estado)
                and or_order_activity.order_id = or_order.order_id and or_order.task_type_id = to_number('''||sbTASK_TYPE_ID||''')';

    pkg_Traza.Trace('Ejecucion proceso PAMOT sbQuery Inicial => '||sbQuery, 11);

    if (sbCICLCODI is not null) then
        sbQuery1 := sbQuery1||' and servsusc.SESUCICL = to_number('''||sbCICLCODI||''')';
        sbQuery2 := sbQuery2||' and servsusc.SESUCICL = to_number('''||sbCICLCODI||''')';
    end if;

    if (sbCREATED_DATE is not null) then
        sbQuery1 := sbQuery1||' and or_order.created_date <= to_date('''||sbCREATED_DATE||''', LDC_BOCONSGENERALES.FSBGETFORMATOFECHA)';
        sbQuery2 := sbQuery2||' and or_order.created_date <= to_date('''||sbCREATED_DATE||''', LDC_BOCONSGENERALES.FSBGETFORMATOFECHA)';
    end if;

    if (sbASSIGNED_DATE is not null) then
       sbQuery1 := sbQuery1||' and nvl(or_order.ASSIGNED_DATE,sysdate) <= to_date('''||sbASSIGNED_DATE||''', LDC_BOCONSGENERALES.FSBGETFORMATOFECHA)';
       sbQuery2 := sbQuery2||' and nvl(or_order.ASSIGNED_DATE,sysdate) <= to_date('''||sbASSIGNED_DATE||''', LDC_BOCONSGENERALES.FSBGETFORMATOFECHA)';
    end if;

    if (sbORDER_ID is not null) then
       sbQuery1 := sbQuery1||' and or_order.order_id IN (SELECT TO_NUMBER(COLUMN_VALUE) FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS('''||sbORDER_ID||''','''||sbSeparador||''')))';
       sbQuery2 := sbQuery2||' and or_order.order_id IN (SELECT TO_NUMBER(COLUMN_VALUE) FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS('''||sbORDER_ID||''','''||sbSeparador||''')))';
    end if;
    
    -- se unifican los 2 querys (Cambio 253)
    sbQuery := sbQuery1 || chr(13) || 'UNION' || chr(13) || sbQuery2;

    --Definir cantidad
    if pkg_BCOrdenes.fnuObtieneClaseCausal(to_number(sbCAUSAL_ID)) = 1 then
         nuCant := 1;
    else
       if pkg_BCOrdenes.fnuObtieneClaseCausal(to_number(sbCAUSAL_ID)) = 2 then
         nuCant := 0;
       end if;
    end if;

    -- Si seleccionaron enviar correo y el correo no es nulo envia correo
    IF (sbALLOW_UPDATE='Y' and sbE_MAIL is not null) THEN
        sbEnvioCorreo := 'Y';
    ELSE
        sbEnvioCorreo := 'N';
    END IF;

    OPEN rfCursor FOR sbQuery;
    FETCH rfCursor BULK COLLECT INTO l_tab;

    IF l_tab.count > 0 THEN
        FOR i IN l_tab.first..l_tab.last  LOOP

            inuIdOrder := to_number(l_tab(i));

            IF sbMESSAGE = 'ANULAR' THEN

                --Anular OT
                API_ANULLORDER(inuIdOrder, cnuCommentType, sbOrderComme, nuErrorCode, sbErrorMesse );
    
                IF nuErrorCode = pkConstante.Exito THEN
                
                    -- Actualiza la causal escogida
                    pkg_OR_Order.prc_ActualizaCausalOrden(inuIdOrder,to_number(sbCAUSAL_ID), nuErrorCode, sbErrorMesse);
                            
                    --Aranda 2842: validar si los tipos de trabajo corresponden a Suspension o Reconexion
                    --1. Validar tipo de trabajo
                    isbTaskTypeIds := pkg_BCLD_Parameter.fsbObtieneValorCadena('IDS_TT_SUSP_RECX');

                    IF instr(isbTaskTypeIds,sbTASK_TYPE_ID) > 0 THEN
                        pkg_Error.setapplication('PAMOT');

                        --Aranda 3330:
                        --1. Obtener identificador del producto
                        nuProductId := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla ('or_order_activity','order_id','product_id',inuIdOrder));
                        pkg_Traza.Trace('Ejecucion proceso PAMOT nuProductId => '||nuProductId,10);
                        --2. Actualizar suspcone.sucofeat y suspcone.SUCOTIPO
                        UPDATE suspcone SET sucofeat =  sysdate, SUCOTIPO = 'A'
                        WHERE SUCONUSE = nuProductId AND sucofeat IS NULL;
                        --3. Actualizar el estado de corte del producto servsusc.sesuesco
                        IF nuProductId <> -1 THEN
                              nuBeforeState := NULL;
                              OPEN cuBeforeStatus (nuProductId);
                              FETCH cuBeforeStatus INTO nuBeforeState;
                              CLOSE cuBeforeStatus;
                              --nuBeforeState := to_number(ldc_boutilities.fsbGetValorCampoTabla('suspcone','SUCONUOR','SUCOCOEC',inuIdOrder));
                              pkg_Traza.Trace('Ejecucion proceso PAMOT nuBeforeState => '||nuBeforeState,10);
                              IF  nuBeforeState IS NOT NULL THEN
                                 UPDATE servsusc SET sesuesco = nuBeforeState WHERE sesunuse = nuProductId;
                                 pkg_Traza.Trace('Update Finalizado',10);
                                 NULL;
                              END IF;
                         END IF;

                    END IF;

                    INSERT INTO ldc_log_pamot(order_id, OBSERVACION) VALUES (inuIdOrder,'Anulando Orden');
                    COMMIT;
                    nuCount := nuCount + 1;
                
                ELSE
                
                    ROLLBACK;

                    INSERT INTO ldc_log_pamot(order_id, OBSERVACION) VALUES (inuIdOrder,'ERROR Anulando Orden:' || sbErrorMesse);
                    COMMIT;

                END IF;

            ELSE
                --Si es Legalizar Ots
                nuOrderActivityId := ldc_bcfinanceot.fnuGetActivityId(inuIdOrder);
                nuUnidadAsignada  := pkg_BCOrdenes.fnuObtieneUnidadOperativa(inuIdOrder);

                IF nuOrderActivityId IS NULL OR nuOrderActivityId = -1 THEN
                    Pkg_error.SetErrorMessage ( isbMsgErrr => 'No se genero un registro de orden por actividad para la orden: '||inuIdOrder);
                END IF;

                -- Valida si la persona ingresada se encuentra en or_oper_unit_persons para poder legalizar la orden
                blPersonAsig := daor_oper_unit_persons.fblexist(nuUnidadAsignada, to_number(sbPERSON_ID));
                IF (blPersonAsig=TRUE) THEN
                    nuPersonLegaliza := to_number(sbPERSON_ID);
                ELSIF (blPersonAsig=FALSE) THEN
                -- Si la persona que se selecciono en el proceso no estaba asignada a la UO se toma la persona responsable de la UO
                   nuPersonLegaliza := pkg_BCUnidadOperativa.fnuGetPersonaACargo(nuUnidadAsignada);
                   sbObservacion := 'La persona['||sbPERSON_ID||']no esta asignado a la Unidad de trabajo['||nuUnidadAsignada||']'||
                                    'se selecciona la persona['||nuPersonLegaliza||']responsable de la UO';
                   nuPersonLegaliza := nvl(nuPersonLegaliza,sbPERSON_ID);
                END IF;

                ISBDATAORDER:=      inuIdOrder||'|'||to_number(sbCAUSAL_ID)||'|'||nuPersonLegaliza||'||'||
                                    nuOrderActivityId||'>'||nuCant||';READING>>>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|||1277;'||
                                    sbDESCRIPTION;

                pkg_Traza.Trace('Ejecución proceso PAMOT ISBDATAORDER => '||ISBDATAORDER,11);

                pkg_Traza.Trace('Ingresa api_legalizeorders isbDataOrder: ' 	|| ISBDATAORDER 	 || chr(10) ||
														  'idtInitDate: ' 	|| idtExeInitialDate || chr(10) ||
														  'idtFinalDate: ' 	|| idtExeFinalDate 	 || chr(10) ||
														  'idtChangeDate: ' || idtChangeDate,11);
				
				api_legalizeorders(ISBDATAORDER, 
								   idtExeInitialDate, 
								   idtExeFinalDate, 
								   idtChangeDate, 
								   onuErrorCode, 
								   osbErrorMessage
								   );
								   
				pkg_Traza.Trace('Sale api_legalizeorders onuErrorCode: ' 	|| onuErrorCode	|| chr(10) ||
													   'osbErrorMessage: ' 	|| osbErrorMessage,11);

                IF (onuErrorCode <> 0) THEN
                    ROLLBACK;
                    -- Luego inserta el error
                    INSERT INTO ldc_log_pamot(order_id,OBSERVACION) VALUES (inuIdOrder, 'Fallo en LEGALIZAR '||onuErrorCode||' - '||osbErrorMessage||' datos de la orden '||ISBDATAORDER);
                    COMMIT;
                ELSE
                     nuCount := nuCount + 1;
                     INSERT INTO ldc_log_pamot(order_id,OBSERVACION) VALUES (inuIdOrder, 'Exito en LEGALIZAR '||sbObservacion);
                     COMMIT;
                END IF;
            END IF;

        END LOOP;
    END IF;

    -- Si proceso ordenes envia notificacion.
    IF (nuCount > 0 AND sbEnvioCorreo='Y') THEN
        ldc_bcrevokeots.prSendNotification(sbMESSAGE,sbE_MAIL);
    ELSE
        sbSubject    := 'PROCESO DE ANULACION/LEGALIZACION MASIVA DE ORDENES' || sysdate;
        sbMessage0   := 'El proceso termino, no se procesaron registros';
        
        pkg_Correo.prcEnviaCorreo
        (
            isbDestinatarios    => sbE_MAIL,
            isbAsunto           => sbSubject,
            isbMensaje          => sbMessage0
        );
        
    END IF;

    pkg_Traza.Trace('FIN PAMOT', 10);

    EXCEPTION
    when OTHERS then
        sbSubject    := 'ERROR EN EL PROCESO DE ANULACION/LEGALIZACION MASIVA DE ORDENES' || sysdate;
        sbMessage0   := 'Durante la ejecucion del proceso se presento un error no controlado ['|| SQLCODE||' - '||  SQLERRM||'].
                         La cantidad de registros procesados fue '||nuCount||'. Por favor contacte al Administrador.'||sbQuery;
        pkg_Correo.prcEnviaCorreo
        (
            isbDestinatarios    => sbE_MAIL,
            isbAsunto           => sbSubject,
            isbMensaje          => sbMessage0
        );
        
END PAMOT;
/
