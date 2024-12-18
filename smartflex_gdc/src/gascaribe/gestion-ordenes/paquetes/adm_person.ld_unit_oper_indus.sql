CREATE OR REPLACE PACKAGE ADM_PERSON.LD_UNIT_OPER_INDUS
/**************************************************************************
    Autor       :
    Fecha       : 09/04/2020
    Ticket      : 241
    Descripcion: Paquete para gestion de la forma LDCPBLEORD

    HISTORIA DE MODIFICACIONES
    FECHA           AUTOR       DESCRIPCION
    18/06/2024      PAcosta     OSF-2845: Cambio de esquema ADM_PERSON  
***************************************************************************/
AS
/**************************************************************************
        Fecha       : 09/04/2020
        Ticket      : 241
        Descripcion: Proceso para procesar los datos de la unidad operativa
***************************************************************************/

PROCEDURE LDCPBLEORD(inuYear IN NUMBER,
                     inuMonth IN NUMBER,
                     inuOperatingUnit IN or_operating_unit.operating_unit_id%type);
                     
PROCEDURE PR_EXECUTE_BY_OPER(inuYear IN NUMBER,
                             inuMonth IN NUMBER,
                             inuOperatingUnit IN or_operating_unit.operating_unit_id%type);                     


END LD_UNIT_OPER_INDUS;
/

CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LD_UNIT_OPER_INDUS
/**************************************************************************
    Autor       :
    Fecha       : 09/04/2020
    Ticket      : 241
    Descripcion: Paquete para gestion de la forma LDCPBLEORD

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
	18/06/2024   PAcosta     OSF-2845: Cambio de esquema ADM_PERSON  
    04/08/2023	 jerazomvm	 Caso OSF-1522:
							 Se ajusta el valor de la constante CNUITEMS_ID, por el parámetro
    07/04/2021   FCastro     Se quita filtro de actividad en los cursores cuGetOrderGrouped de los 
                             procedimientos PR_EXECUTE_BY_OPER y PR_EXECUTE_ALL_OPE (cambio 641)						 
***************************************************************************/

AS

CNUITEMS_ID 		CONSTANT VARCHAR2(4000) 	             := pkg_parametros.fsbGetValorCadena('COD_ITEMS_LECTURA_INDUS');
CsbProcessProg 		CONSTANT VARCHAR2(20) 					 := 'PBLEORD'||'_'||to_char(SYSDATE, 'DDMMYYHHMISS');
CsbParamUnitOper	CONSTANT VARCHAR2(50) 					 := dald_parameter.fsbGetValue_Chain('LDCUNOPERUSUINDUS',0);
nuActiLecInd 		CONSTANT LD_PARAMETER.NUMERIC_VALUE%TYPE := DALD_PARAMETER.fnuGetNumeric_Value('COD_ACTIVIDAD_LECTURA_INDUS'); 
/**************************************************************************
        Fecha       : 09/04/2020
        Ticket      : 241
        Descripcion: Funcion que obtiene el numero de registros a procesar
***************************************************************************/

FUNCTION FN_GET_NUMBER_REGISTER(inuYear 	     IN NUMBER,
                                inuMonth 		 IN NUMBER,
                                inuOperatingUnit IN or_operating_unit.operating_unit_id%type)
RETURN NUMBER

IS

    nuCount NUMBER;

BEGIN

	ut_trace.trace('Inicio LD_UNIT_OPER_INDUS.FN_GET_NUMBER_REGISTER inuYear: '  		 || inuYear  || chr(10) ||
																	'inuMonth: ' 		 || inuMonth || chr(10) ||
																	'inuOperatingUnit: ' || inuOperatingUnit, 2);

    IF inuOperatingUnit = -1 THEN

        SELECT COUNT(1)
        INTO nuCount
        FROM or_order oo,
        or_order_activity ooa,
        or_order_items ooi,
        ab_address aa
        where oo.order_id = ooa.order_id
        and oo.order_id = ooi.order_id
        and oo.EXTERNAL_ADDRESS_ID = aa.ADDRESS_ID
        and EXTRACT(YEAR FROM oo.legalization_date) = inuYear
        and EXTRACT(MONTH FROM oo.legalization_date) = inuMonth
        and oo.task_type_id = 12617
        AND oo.operating_unit_id IN (select TO_NUMBER(regexp_substr(CsbParamUnitOper,'[^,]+', 1, level)) as valores
                                     from dual
                                     connect by regexp_substr(CsbParamUnitOper, '[^,]+', 1, level) is not null)
        AND oo.order_status_id = 8
        and oo.IS_PENDING_LIQ = 'Y'
        and oo.saved_data_values is null;

    END IF;

    IF inuOperatingUnit <> -1 THEN

        SELECT COUNT(1)
        INTO nuCount
        FROM or_order oo,
        or_order_activity ooa,
        or_order_items ooi,
        ab_address aa
        where oo.order_id = ooa.order_id
        and oo.order_id = ooi.order_id
        and oo.EXTERNAL_ADDRESS_ID = aa.ADDRESS_ID
        and EXTRACT(YEAR FROM oo.legalization_date) = inuYear
        and EXTRACT(MONTH FROM oo.legalization_date) = inuMonth
        and oo.task_type_id = 12617
        AND oo.operating_unit_id IN (inuOperatingUnit)
        AND oo.order_status_id = 8
        and oo.IS_PENDING_LIQ = 'Y'
        and oo.saved_data_values is null;

    END IF;
	
	ut_trace.trace('Fin LD_UNIT_OPER_INDUS.FN_GET_NUMBER_REGISTER nuCount: ' || nuCount, 2);

    RETURN nuCount;

EXCEPTION
        WHEN Pkg_error.CONTROLLED_ERROR THEN
            RAISE Pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Pkg_error.setError;
            RAISE Pkg_error.CONTROLLED_ERROR;
END FN_GET_NUMBER_REGISTER;
/**************************************************************************
      Ticket      : 241
      Descripcion: Proceso que se ejecuta cuando se seleccionan todas las
      unidades operativas
		
	  Autor          : 
	  Fecha          : 09/04/2020

	  Parametros            Descripcion
	  ============        	===================
	  inuYear				Año
	  inuMonth				Mes

	  Historia de Modificaciones

	  DD-MM-YYYY    <Autor>               Modificacion
	  -----------  -------------------    -------------------------------------
	  4/08/2023    jerazomvm        	  Caso OSF-1522:
										  1. Se agrega la separación de cadena para la constante CNUITEMS_ID.
										  2. Se ajusta el cursor cuGetOrdersAllOper, donde se filtrara por los(el) 
											 item(s) del parámetro COD_ITEMS_LECTURA_INDUS
										  3. Se reemplaza la actualización de la constante CNUITEMS_ID por
											 el valor cuGetOrderGrouped.items_id	
***************************************************************************/

PROCEDURE PR_EXECUTE_ALL_OPER(inuYear IN NUMBER,
                              inuMonth IN NUMBER)

IS

cursor cuGetOrdersAllOper(inuYear  IN NUMBER,
                          inuMonth IN NUMBER) is
    SELECT ooa.activity_id,
		TRUNC(oo.legalization_date) fecha_legalizacion,
		oo.operating_unit_id,
		oo.DEFINED_CONTRACT_ID,
		aa.GEOGRAP_LOCATION_ID,
		oo.order_id,
		ooi.value,
		ooi.LEGAL_ITEM_AMOUNT
    FROM or_order oo,
		or_order_activity ooa,
		or_order_items ooi,
		ab_address aa
    where oo.order_id 							 = ooa.order_id
    and oo.order_id 							 = ooi.order_id
    and oo.EXTERNAL_ADDRESS_ID 					 = aa.ADDRESS_ID
    and EXTRACT(YEAR FROM oo.legalization_date)  = inuYear
    and EXTRACT(MONTH FROM oo.legalization_date) = inuMonth
    and oo.task_type_id 						 = 12617
    AND oo.operating_unit_id 					 IN (select TO_NUMBER(regexp_substr(CsbParamUnitOper,'[^,]+', 1, level)) as valores
													 from dual
													 connect by regexp_substr(CsbParamUnitOper, '[^,]+', 1, level) is not null)
    AND oo.order_status_id 						 = 8 
    and ooi.items_id 							 in (SELECT to_number(regexp_substr(CNUITEMS_ID,
																	  '[^,]+',
																	  1,
																	  LEVEL)) AS COD_ITEMS_LECTURA_INDUS
													 FROM dual
													 CONNECT BY regexp_substr(CNUITEMS_ID, '[^,]+', 1, LEVEL) IS NOT NULL)
    and nvl(oo.IS_PENDING_LIQ,'N') 				 = 'N'
    and oo.saved_data_values 					 is null;

cursor cuGetOrderGrouped(inuActivityId 		IN NUMBER,
                         idtFechaLegal 		IN DATE,
                         inOperatingUnitId  IN NUMBER,
                         inContractId 		IN NUMBER,
                         inLocalitationId 	IN NUMBER) is

    SELECT ooa.activity_id,
		   TRUNC(oo.legalization_date),
		   oo.operating_unit_id,
		   oo.DEFINED_CONTRACT_ID,
		   aa.GEOGRAP_LOCATION_ID,
		   oo.order_id,
		   ooi.order_items_id,
		   ooi.items_id
    FROM or_order oo,
		 or_order_activity ooa,
		 or_order_items ooi,
		 ab_address aa
    where oo.order_id 				= ooa.order_id
    and oo.order_id 				= ooi.order_id
    and oo.EXTERNAL_ADDRESS_ID 		= aa.ADDRESS_ID
    and TRUNC(oo.legalization_date) = idtFechaLegal
    AND oo.operating_unit_id 		= inOperatingUnitId
    AND oo.DEFINED_CONTRACT_ID 		= inContractId
    AND aa.GEOGRAP_LOCATION_ID		= inLocalitationId
    and oo.task_type_id 			= 12617
    AND oo.order_status_id 			= 8
    and oo.IS_PENDING_LIQ 			= 'Y'
    AND oo.saved_data_values 		= 'ORDER_GROUPED';
    
cursor cuOrdAgrupadoras is    
SELECT ooa.activity_id,
       TRUNC(oo.legalization_date),
       oo.operating_unit_id,
       oo.DEFINED_CONTRACT_ID,
       aa.GEOGRAP_LOCATION_ID,
       oo.order_id orden,
       ooi.order_items_id
  FROM or_order          oo,
       or_order_activity ooa,
       or_order_items    ooi,
       ab_address        aa
 where oo.order_id 								= ooa.order_id
   and oo.order_id 								= ooi.order_id
   and oo.EXTERNAL_ADDRESS_ID 					= aa.ADDRESS_ID
   and EXTRACT(YEAR FROM oo.legalization_date) 	= inuYear
   and EXTRACT(MONTH FROM oo.legalization_date) = inuMonth
   AND ooa.activity_id 							= nuActiLecInd
   AND oo.operating_unit_id 					in (select TO_NUMBER(regexp_substr(CsbParamUnitOper,'[^,]+', 1, level)) as valores
													 from dual
													 connect by regexp_substr(CsbParamUnitOper, '[^,]+', 1, level) is not null)
   and oo.task_type_id 							= 12617
   AND oo.order_status_id 						= 8
   and oo.IS_PENDING_LIQ 						= 'Y'
   AND oo.saved_data_values 					= 'ORDER_GROUPED';

	rwGetOrderNotGroup 	cuGetOrdersAllOper%rowtype;
	rwGetOrderGroup 	cuGetOrderGrouped%rowtype;
	nuOrdersNoUpdate 	NUMBER;
	sbMessage 			VARCHAR2(100);
	nuCountRegister 	NUMBER;
	nuRegisterProcess 	NUMBER;
	nuCountOrderNoGroup NUMBER;
	nuOrderSucess 		NUMBER;

BEGIN

	ut_trace.trace('Inicio LD_UNIT_OPER_INDUS.PR_EXECUTE_ALL_OPER inuYear: '  || inuYear || chr(10) ||
																 'inuMonth: ' || inuMonth, 2);
	
    nuRegisterProcess := FN_GET_NUMBER_REGISTER(inuYear, inuMonth, -1);

    nuOrdersNoUpdate 	:= 0;
    nuCountRegister 	:= 0;
    nuCountOrderNoGroup := 0;
    nuOrderSucess 		:= 0;
    
    -- Inicializa las cantidades y valores de las ordenes agrupadoras 
    for rg in cuOrdAgrupadoras loop
		ut_trace.trace('Actualizando VALUE y LEGAL_ITEM_AMOUNT de la orden agrupada: '  || rg.orden || ' en 0', 2);
      UPDATE OR_ORDER_ITEMS
         SET VALUE = 0,
            LEGAL_ITEM_AMOUNT = 0
    	WHERE ORDER_ID = rg.orden;
    end loop;
    commit;
    -- Fin Inicializa las cantidades y valores de las ordenes agrupadoras 
	
	ut_trace.trace('El valor del párametro COD_ITEMS_LECTURA_INDUS es: '  || CNUITEMS_ID, 2);

    OPEN cuGetOrdersAllOper(inuYear, inuMonth);
    LOOP
    FETCH cuGetOrdersAllOper INTO rwGetOrderNotGroup;
    EXIT WHEN cuGetOrdersAllOper%NOTFOUND;

        nuCountRegister := nuCountRegister + 1;

        rwGetOrderGroup.order_id := NULL;
        rwGetOrderGroup.order_items_id := NULL;

        ut_trace.trace('rwGetOrderNotGroup.activity_id: '  			|| rwGetOrderNotGroup.activity_id 			|| chr(10) ||
					   'rwGetOrderNotGroup.fecha_legalizacion: ' 	|| rwGetOrderNotGroup.fecha_legalizacion 	|| chr(10) ||
					   'rwGetOrderNotGroup.operating_unit_id: ' 	|| rwGetOrderNotGroup.operating_unit_id 	|| chr(10) ||
					   'rwGetOrderNotGroup.DEFINED_CONTRACT_ID: ' 	|| rwGetOrderNotGroup.DEFINED_CONTRACT_ID 	|| chr(10) ||
					   'rwGetOrderNotGroup.GEOGRAP_LOCATION_ID: ' 	|| rwGetOrderNotGroup.GEOGRAP_LOCATION_ID, 4);
		
		OPEN cuGetOrderGrouped(rwGetOrderNotGroup.activity_id,
        					   rwGetOrderNotGroup.fecha_legalizacion,
        					   rwGetOrderNotGroup.operating_unit_id,
        					   rwGetOrderNotGroup.DEFINED_CONTRACT_ID,
        					   rwGetOrderNotGroup.GEOGRAP_LOCATION_ID);
        FETCH cuGetOrderGrouped INTO rwGetOrderGroup;
        CLOSE cuGetOrderGrouped;

        IF rwGetOrderGroup.order_id IS NOT NULL THEN
		
			ut_trace.trace('Actualizando VALUE, LEGAL_ITEM_AMOUNT e ITEMS_ID con el ORDER_ITEMS_ID: ' || rwGetOrderGroup.order_items_id, 6);

            BEGIN
        		UPDATE OR_ORDER_ITEMS
        		SET VALUE 				= VALUE + rwGetOrderNotGroup.value,
					LEGAL_ITEM_AMOUNT 	= LEGAL_ITEM_AMOUNT + rwGetOrderNotGroup.LEGAL_ITEM_AMOUNT,
					ITEMS_ID 			= rwGetOrderGroup.items_id
        		WHERE ORDER_ITEMS_ID = rwGetOrderGroup.order_items_id;
            
        		UPDATE OR_ORDER
        		SET IS_PENDING_LIQ = NULL
        		WHERE ORDER_ID = rwGetOrderNotGroup.order_id;

        		nuOrderSucess := nuOrderSucess + 1;
        	EXCEPTION
                WHEN OTHERS THEN
            		nuOrdersNoUpdate := nuOrdersNoUpdate + 1;
        	END;

        ELSE

            nuCountOrderNoGroup := nuCountOrderNoGroup + 1;

        END IF;

        IF mod(nuCountRegister, 100) = 0 THEN

            COMMIT;

        	pkstatusexeprogrammgr.upstatusexeprogramat
        	(
        		CsbProcessProg,
        		'Procesando: '||nuCountRegister,
        		nuRegisterProcess,
        		nuCountRegister
        	);

        END IF;

        IF nuCountRegister = nuRegisterProcess THEN

        	pkstatusexeprogrammgr.upstatusexeprogramat
        	(
        		CsbProcessProg,
        		'Procesando: '||nuCountRegister,
        		nuRegisterProcess,
        		nuCountRegister
        	);

        END IF;

    END LOOP;
    CLOSE cuGetOrdersAllOper;

    COMMIT;
    
    pkstatusexeprogrammgr.upstatusexeprogramat
    (
        CsbProcessProg,
        'Proceso termino. Ordenes procesadas con exito: '||nuOrderSucess||'. Ordenes que no pudieron actualizarse: '||nuOrdersNoUpdate||'. Ordenes sin ordenes agrupadas: '||nuCountOrderNoGroup,
        nuRegisterProcess,
        nuCountRegister
    );

    ut_trace.trace('Fin LD_UNIT_OPER_INDUS.PR_EXECUTE_ALL_OPER', 2);

EXCEPTION
        WHEN Pkg_error.CONTROLLED_ERROR THEN
            RAISE Pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Pkg_error.setError;
            RAISE Pkg_error.CONTROLLED_ERROR;
END PR_EXECUTE_ALL_OPER;
/**************************************************************************
      Ticket      : 241
      Descripcion: Proceso que se ejecuta cuando para una de las
      unidades operativas
		
	  Autor          : 
	  Fecha          : 09/04/2020

	  Parametros            Descripcion
	  ============        	===================
	  inuYear				Año
	  inuMonth				Mes
	  inuOperatingUnit		Identificador de la unidad operativa

	  Historia de Modificaciones

	  DD-MM-YYYY    <Autor>               Modificacion
	  -----------  -------------------    -------------------------------------
	  4/08/2023    jerazomvm        	  Caso OSF-1522:
										  1. Se agrega la separación de cadena para la constante CNUITEMS_ID.
										  2. Se ajusta el cursor cuGetOrdersByOper, donde se filtrara por los(el) 
											 item(s) del parámetro COD_ITEMS_LECTURA_INDUS
										  3. Se reemplaza la actualización de la constante CNUITEMS_ID por 
											 el valor cuGetOrderGrouped.items_id										 
***************************************************************************/
PROCEDURE PR_EXECUTE_BY_OPER(inuYear IN NUMBER,
                             inuMonth IN NUMBER,
                             inuOperatingUnit IN or_operating_unit.operating_unit_id%type)

IS

cursor cuGetOrdersByOper(inuYear IN NUMBER,
                         inuMonth IN NUMBER,
                         inuOperatingUnit IN or_operating_unit.operating_unit_id%type) is
    SELECT ooa.activity_id,
		   TRUNC(oo.legalization_date) fecha_legalizacion,
		   oo.operating_unit_id,
		   oo.DEFINED_CONTRACT_ID,
		   aa.GEOGRAP_LOCATION_ID,
		   oo.order_id,
		   ooi.value,
		   ooi.LEGAL_ITEM_AMOUNT
    FROM or_order oo,
		 or_order_activity ooa,
		 or_order_items ooi,
		 ab_address aa
    where oo.order_id = ooa.order_id
    and oo.order_id = ooi.order_id
    and oo.EXTERNAL_ADDRESS_ID = aa.ADDRESS_ID
    and EXTRACT(YEAR FROM oo.legalization_date) = inuYear
    and EXTRACT(MONTH FROM oo.legalization_date) = inuMonth
    and oo.task_type_id = 12617
    AND oo.operating_unit_id IN (inuOperatingUnit)
    AND oo.order_status_id = 8
    and ooi.items_id in (SELECT to_number(regexp_substr(CNUITEMS_ID,
						    			  '[^,]+',
										  1,
										  LEVEL)) AS COD_ITEMS_LECTURA_INDUS
						 FROM dual
						 CONNECT BY regexp_substr(CNUITEMS_ID, '[^,]+', 1, LEVEL) IS NOT NULL)
    and nvl(oo.IS_PENDING_LIQ,'N') = 'N'
    and oo.saved_data_values is null;

cursor cuGetOrderGrouped(inuActivityId IN NUMBER,
                         idtFechaLegal IN DATE,
                         inOperatingUnitId IN NUMBER,
                         inContractId IN NUMBER,
                         inLocalitationId IN NUMBER) is

    SELECT ooa.activity_id,
		TRUNC(oo.legalization_date),
		oo.operating_unit_id,
		oo.DEFINED_CONTRACT_ID,
		aa.GEOGRAP_LOCATION_ID,
		oo.order_id,
		ooi.order_items_id,
		ooi.items_id
    FROM or_order oo,
		or_order_activity ooa,
		or_order_items ooi,
		ab_address aa
    where oo.order_id = ooa.order_id
    and oo.order_id = ooi.order_id
    and oo.EXTERNAL_ADDRESS_ID = aa.ADDRESS_ID
    and TRUNC(oo.legalization_date) = idtFechaLegal
  --  AND ooa.activity_id = inuActivityId    (Se comentaria por cambio 641)
    AND oo.operating_unit_id = inOperatingUnitId
    AND oo.DEFINED_CONTRACT_ID = inContractId
    AND aa.GEOGRAP_LOCATION_ID = inLocalitationId
    and oo.task_type_id = 12617
    AND oo.order_status_id = 8
    and oo.IS_PENDING_LIQ = 'Y'
    AND oo.saved_data_values = 'ORDER_GROUPED';
    
cursor cuOrdAgrupadoras is    
SELECT ooa.activity_id,
       TRUNC(oo.legalization_date),
       oo.operating_unit_id,
       oo.DEFINED_CONTRACT_ID,
       aa.GEOGRAP_LOCATION_ID,
       oo.order_id orden,
       ooi.order_items_id
  FROM or_order          oo,
       or_order_activity ooa,
       or_order_items    ooi,
       ab_address        aa
 where oo.order_id = ooa.order_id
   and oo.order_id = ooi.order_id
   and oo.EXTERNAL_ADDRESS_ID = aa.ADDRESS_ID
   and EXTRACT(YEAR FROM oo.legalization_date) = inuYear
   and EXTRACT(MONTH FROM oo.legalization_date) = inuMonth
   AND ooa.activity_id = nuActiLecInd
   AND oo.operating_unit_id = inuOperatingUnit
   and oo.task_type_id = 12617
   AND oo.order_status_id = 8
   and oo.IS_PENDING_LIQ = 'Y'
   AND oo.saved_data_values = 'ORDER_GROUPED';    

	rwGetOrderNotGroup 	cuGetOrdersByOper%rowtype;
	rwGetOrderGroup 	cuGetOrderGrouped%rowtype;
	nuOrdersNoUpdate 	NUMBER;
	sbMessage 			VARCHAR2(100);
	nuCountRegister 	NUMBER;
	nuRegisterProcess 	NUMBER;
	nuCountProcessed 	NUMBER := 0;
	nuCountOrderNoGroup	NUMBER;
	nuOrderSucess 		NUMBER;

BEGIN

	ut_trace.trace('Inicio LD_UNIT_OPER_INDUS.PR_EXECUTE_BY_OPER inuYear: '  			|| inuYear 	|| chr(10) ||
																 'inuMonth: ' 			|| inuMonth || chr(10) ||
																 'inuOperatingUnit: ' 	|| inuOperatingUnit, 2);

    nuOrdersNoUpdate 	:= 0;
    nuCountRegister 	:= 0;
    nuRegisterProcess 	:= FN_GET_NUMBER_REGISTER(inuYear, inuMonth, inuOperatingUnit);
    nuCountOrderNoGroup := 0;
    nuOrderSucess 		:= 0;
    
    -- Inicializa las cantidades y valores de las ordenes agrupadoras 
    for rg in cuOrdAgrupadoras loop
		ut_trace.trace('Actualizando VALUE y LEGAL_ITEM_AMOUNT de la orden agrupada: '  || rg.orden || ' en 0', 4);
      UPDATE OR_ORDER_ITEMS
         SET VALUE = 0,
         	 LEGAL_ITEM_AMOUNT = 0
    	WHERE ORDER_ID = rg.orden;
    end loop;
    commit;
    -- Fin Inicializa las cantidades y valores de las ordenes agrupadoras 
	
	ut_trace.trace('El valor del párametro COD_ITEMS_LECTURA_INDUS es: '  || CNUITEMS_ID, 2);

    OPEN cuGetOrdersByOper(inuYear, inuMonth, inuOperatingUnit);
    LOOP
    FETCH cuGetOrdersByOper INTO rwGetOrderNotGroup;
    EXIT WHEN cuGetOrdersByOper%NOTFOUND;

        nuCountRegister := nuCountRegister + 1;
        nuCountProcessed := nuCountProcessed + 1;

        rwGetOrderGroup.order_id := NULL;
        rwGetOrderGroup.order_items_id := NULL;
		
		ut_trace.trace('rwGetOrderNotGroup.activity_id: '  			|| rwGetOrderNotGroup.activity_id 			|| chr(10) ||
					   'rwGetOrderNotGroup.fecha_legalizacion: ' 	|| rwGetOrderNotGroup.fecha_legalizacion 	|| chr(10) ||
					   'rwGetOrderNotGroup.operating_unit_id: ' 	|| rwGetOrderNotGroup.operating_unit_id 	|| chr(10) ||
					   'rwGetOrderNotGroup.DEFINED_CONTRACT_ID: ' 	|| rwGetOrderNotGroup.DEFINED_CONTRACT_ID 	|| chr(10) ||
					   'rwGetOrderNotGroup.GEOGRAP_LOCATION_ID: ' 	|| rwGetOrderNotGroup.GEOGRAP_LOCATION_ID, 6);

        OPEN cuGetOrderGrouped(rwGetOrderNotGroup.activity_id,
        					   rwGetOrderNotGroup.fecha_legalizacion,
        					   rwGetOrderNotGroup.operating_unit_id,
        					   rwGetOrderNotGroup.DEFINED_CONTRACT_ID,
        					   rwGetOrderNotGroup.GEOGRAP_LOCATION_ID);
        FETCH cuGetOrderGrouped INTO rwGetOrderGroup;
        CLOSE cuGetOrderGrouped;

        IF rwGetOrderGroup.order_id IS NOT NULL THEN
		
			ut_trace.trace('Actualizando VALUE, LEGAL_ITEM_AMOUNT e ITEMS_ID con el ORDER_ITEMS_ID: ' || rwGetOrderGroup.order_items_id, 6);

            BEGIN
        		UPDATE OR_ORDER_ITEMS
        		SET VALUE 				= VALUE + rwGetOrderNotGroup.value,
					LEGAL_ITEM_AMOUNT 	= LEGAL_ITEM_AMOUNT + rwGetOrderNotGroup.LEGAL_ITEM_AMOUNT,
					ITEMS_ID 			= rwGetOrderGroup.items_id				
        		WHERE ORDER_ITEMS_ID = rwGetOrderGroup.order_items_id;

        		UPDATE OR_ORDER
        		SET IS_PENDING_LIQ = NULL
        		WHERE ORDER_ID = rwGetOrderNotGroup.order_id;

        		nuOrderSucess := nuOrderSucess + 1;
        	EXCEPTION
                WHEN OTHERS THEN
            		nuOrdersNoUpdate := nuOrdersNoUpdate + 1;
        	END;

        ELSE
            nuCountOrderNoGroup := nuCountOrderNoGroup + 1;
        END IF;

        IF mod(nuCountRegister, 100) = 0 THEN

        	pkstatusexeprogrammgr.upstatusexeprogramat
        	(
        		CsbProcessProg,
        		'Procesando: '||nuCountProcessed/*nuCountRegister*/,
        		nuRegisterProcess,
        		nuCountProcessed -- nuCountRegister
        	);

        	COMMIT;

        END IF;

        IF nuCountRegister = nuRegisterProcess THEN

        	pkstatusexeprogrammgr.upstatusexeprogramat
        	(
        		CsbProcessProg,
        		'Procesando: '||nuCountProcessed/*nuCountRegister*/,
        		nuRegisterProcess,
        		nuCountProcessed/*nuCountRegister*/
        	);

        END IF;

    END LOOP;
    CLOSE cuGetOrdersByOper;

    COMMIT;
    
    pkstatusexeprogrammgr.upstatusexeprogramat
    (
        CsbProcessProg,
        'Proceso termino. Ordenes procesadas con exito: '||nuOrderSucess||'. Ordenes que no pudieron actualizarse: '||nuOrdersNoUpdate||'. Ordenes sin ordenes agrupadas: '||nuCountOrderNoGroup,
        nuRegisterProcess,
        nuCountProcessed -- nuCountRegister
    );

    ut_trace.trace('Fin LD_UNIT_OPER_INDUS.PR_EXECUTE_BY_OPER', 2);


EXCEPTION
        WHEN Pkg_error.CONTROLLED_ERROR THEN
            RAISE Pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Pkg_error.setError;
            RAISE Pkg_error.CONTROLLED_ERROR;
END PR_EXECUTE_BY_OPER;

/**************************************************************************
        Fecha       : 09/04/2020
        Ticket      : 241
        Descripcion: Proceso para procesar los datos de la unidad operativa
***************************************************************************/
PROCEDURE LDCPBLEORD(inuYear IN NUMBER,
                     inuMonth IN NUMBER,
                     inuOperatingUnit IN or_operating_unit.operating_unit_id%type)
AS

BEGIN
    ut_trace.trace('Inicio proceso LD_UNIT_OPER_INDUS.LDCPBLEORD inuYear: ' 		 || inuYear 	|| chr(10) ||
																'inuMonth: ' 		 || inuMonth 	|| chr(10) ||
																'inuOperatingUnit: ' || inuOperatingUnit,10);

    pkStatusExeProgramMgr.AddRecordIdSession
    (
        CsbProcessProg,
        0,
        0,
        null,
        null,
        'Procesando...'
    );

    ut_trace.trace('Validacion cuando se eligen todas las unidades operativas',10);

    IF inuOperatingUnit = -1 THEN

        PR_EXECUTE_ALL_OPER(inuYear, inuMonth);

    END IF;

    ut_trace.trace('Validacion cuando se elige una sola unidad operativa',10);

    IF inuOperatingUnit <> -1 THEN

       PR_EXECUTE_BY_OPER(inuYear, inuMonth, inuOperatingUnit);

    END IF;

    ut_trace.trace('Fin proceso LD_UNIT_OPER_INDUS.LDCPBLEORD',10);

EXCEPTION
        WHEN Pkg_error.CONTROLLED_ERROR THEN
            RAISE Pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Pkg_error.setError;
            RAISE Pkg_error.CONTROLLED_ERROR;
END LDCPBLEORD;


END LD_UNIT_OPER_INDUS;
/
Prompt Otorgando permisos sobre LDC_PKBO_AUTOFACT
BEGIN
    pkg_utilidades.prAplicarPermisos( 'LD_UNIT_OPER_INDUS', 'ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre LD_UNIT_OPER_INDUS para REXEINNOVA
GRANT EXECUTE ON adm_person.LD_UNIT_OPER_INDUS TO REXEINNOVA;
