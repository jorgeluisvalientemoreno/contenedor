CREATE OR REPLACE PROCEDURE LDC_LEGALIZAORDEN10002
AS
/***********************************************************************************************************************************
    Autor       : 
    Fecha       : 
    Ticket      : 
    Descripcion : 
    
    
    HISTORIAL DE MODIFICACIONES
    =========       =========     =========         ====================
      Fecha          Ticket         Autor               Modificacion
    =========       =========     =========         ====================
	11/08/2023		OSF-1389	 jerazomvm			Caso OSF-1389:
													1. Se cambia el llamado del API OS_ASSIGN_ORDER, por el API api_assign_order
													2. Se reemplaza el API os_legalizeorders por el API api_legalizeOrders
    **************************************************************************************************************************************/
    CURSOR cuOrdenes
    IS
    SELECT a.ORDER_id,a.causal_id, a.operating_unit_id
    FROM OR_order a,or_order_activity b
    WHERE a.task_type_id 	= dald_parameter.fnuGetNumeric_Value('LDC_TT_RESTRATIFICA')
    AND a.order_status_id 	= 0
    AND damo_packages.fnugetpackage_type_id(b.package_id) = dald_parameter.fnuGetNumeric_Value('LDC_TIPO_SOL_RESTRATIFICA')
    AND  a.order_id 		= b.order_id;

   type tyrcOrdenes IS record (order_id OR_order.order_id%type,
                               causal_id OR_order.causal_id%type,
                               operating_unit_id OR_order.operating_unit_id%type);

   type tytbOrdenes IS table of tyrcOrdenes index BY binary_integer;

   tbOrdenes    tytbOrdenes;

    CURSOR cuPerson (nuOperating_unit_person or_oper_unit_persons.operating_unit_id%type)
    IS
        SELECT or_oper_unit_persons.person_id
        FROM or_oper_unit_persons
        WHERE operating_unit_id = nuOperating_unit_person
        AND rownum < 2;


   sbDESCRIPTION varchar2(100) := 'Se Legaliza mediante proceso masivo JOB-RESTRATIFICACION. '||sysdate;

   sbPERSON_ID varchar2(100);
   ISBDATAORDER varchar2(2000);

   idtExeInitialDate date := sysdate;
   idtExeFinalDate date := sysdate;
   idtChangeDate date := sysdate;
   onuErrorCode NUMBER;
   osbErrorMessage VARCHAR2(4000);

   SBINCONSISTENCIA  VARCHAR2(4000);

BEGIN

	ut_trace.trace('Inicia LDC_LEGALIZAORDEN10002', 2);

    open cuOrdenes;
    fetch cuOrdenes bulk collect INTO tbOrdenes;
    close cuOrdenes;

    ut_trace.trace('PASO 1. RESTRATIFICACION tbOrdenes.count:['||tbOrdenes.count||']',2);

    if tbOrdenes.first > 0 then

        for i in tbOrdenes.first .. tbOrdenes.last
        loop
            open cuPerson(dald_parameter.fnuGetNumeric_Value('LDC_UT_ASIGNAR'));
            fetch cuPerson INTO sbPERSON_ID;
            close cuPerson;

            ut_trace.trace('PASO 1.1 RESTRATIFICACION tbOrdenes(i).order_id:['||tbOrdenes(i).order_id||']',2);

            ut_trace.trace('Ingresa api_assign_order inuOrder: ' 		 || tbOrdenes(i).order_id || chr(10) ||
												    'inuOperatingUnit: ' || dald_parameter.fnuGetNumeric_Value('LDC_UT_ASIGNAR'), 6);
			
			api_assign_order(tbOrdenes(i).order_id,
							dald_parameter.fnuGetNumeric_Value('LDC_UT_ASIGNAR'),
							onuErrorCode, 
							osbErrorMessage
							);
							
			ut_trace.trace('Sale api_assign_order onuErrorCode: ' 	 || onuErrorCode || chr(10) ||
												 'osbErrorMessage: ' || osbErrorMessage, 6);

            ut_trace.trace('PASO 2. RESTRATIFICACION unidad a Asignar:['||dald_parameter.fnuGetNumeric_Value('LDC_UT_ASIGNAR')||']',2);
            ut_trace.trace('PASO 2. RESTRATIFICACION Asignacion:['||osbErrorMessage||']',2);

            if onuErrorCode <> 0 then
                SBINCONSISTENCIA := '[LLOZADA - ASIGNACION - PROCESO DE RESTRATIFICACION] -
                                    ERROR EN ASIGNACION POR EL PAQUETE: LDC_LEGALIZAORDEN10002. ';
                ldc_boasigauto.PRREGSITROASIGAUTO((tbOrdenes(i).order_id * -1),
                               tbOrdenes(i).order_id,
                               SBINCONSISTENCIA||osbErrorMessage);
            END if;

            onuErrorCode := 0;
            osbErrorMessage := null;

            ut_trace.trace('PASO 3. RESTRATIFICACION sbPERSON_ID:['||sbPERSON_ID||']',2);

            ISBDATAORDER:=  tbOrdenes(i).order_id||'|'||dald_parameter.fnuGetNumeric_Value('LDC_CAUSAL_RESTRATIFICACION') /*Causal para Legalizar Orden*/
                            ||'|'||
                            to_number(sbPERSON_ID)||'||'||ldc_bcfinanceot.fnuGetActivityId(tbOrdenes(i).order_id)||'>'||
                            0/*FALLO*/||';READING>>>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|||1277;'||sbDESCRIPTION;

            ut_trace.trace('PASO 4. RESTRATIFICACION ISBDATAORDER:['||ISBDATAORDER||']',2);

            ut_trace.trace('Ingresa api_legalizeOrders isbDataOrder: ' 	|| ISBDATAORDER || chr(10) ||
													  'idtInitDate: ' 	|| idtExeInitialDate 		|| chr(10) ||
													  'idtFinalDate: ' 	|| idtExeFinalDate 		|| chr(10) ||
													  'idtChangeDate: '	|| idtChangeDate, 6);
			
			api_legalizeOrders(ISBDATAORDER,
                              idtExeInitialDate,
                              idtExeFinalDate,
                              idtChangeDate,
                              onuErrorCode,
                              osbErrorMessage);
							  
			ut_trace.trace('Sale api_legalizeOrders onuErrorCode: ' 	|| onuErrorCode || chr(10) ||
												  'osbErrorMessage: ' 	|| osbErrorMessage, 6);

            if onuErrorCode <> 0 then
                SBINCONSISTENCIA := '[LLOZADA - LEGALIZACION - PROCESO DE RESTRATIFICACION] -
                                    ERROR EN LEGALIZACION POR EL PAQUETE: LDC_LEGALIZAORDEN10002. ';
                ldc_boasigauto.PRREGSITROASIGAUTO((tbOrdenes(i).order_id * -1),
                               tbOrdenes(i).order_id,
                              SBINCONSISTENCIA||osbErrorMessage);
            END if;
            
            ut_trace.trace('RESTRATIFICACION onuErrorCode:['||onuErrorCode||']',2);
            ut_trace.trace('PASO 5. RESTRATIFICACION LEgalizacion:['||osbErrorMessage||']',2);
        END loop;

    END if;
	
	ut_trace.trace('Finaliza LDC_LEGALIZAORDEN10002', 2);

END LDC_LEGALIZAORDEN10002;
/