create or replace PACKAGE adm_person.PGK_LDCAUTO1
IS
    /*****************************************************************
    Unidad         : PGK_LDCAUTO
    Descripcion    :
    Autor          : OLSOFTWARE SAS
    Fecha          : 17/009/2019

    Historia de Modificaciones
    Fecha       Autor                       Modificación
    =========   =========                   ====================
    23/07/2024  PAcosta                     OSF-2952: Cambio de esquema ADM_PERSON
    ******************************************************************/

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------
    TYPE rcLDC_DETAMED  IS record
    (
        nuCod_Contrato     ldc_detamed.cod_contrato%type
    );

    TYPE tytbLdc_detamed IS table of rcLDC_DETAMED index BY PLS_INTEGER;

	--------------------------------------------
    -- Tabla PL que contendra la informacion de las ordenes VSI generadas
    --------------------------------------------
	TYPE rcLDC_ORDERSCHILD  IS record
    (
        ORDER_HIJA			or_order.order_id%type,
	    ACTIVITY_ID			or_order_activity.order_Activity_id%type,
	    ITEM_ID				LDC_ORITEM.COD_ITEM%type,
	    CANT_ITEM			LDC_ORITEM.CANTIDAD%type
    );

    TYPE tytbLdc_OrderHijaGen IS table of rcLDC_ORDERSCHILD index BY PLS_INTEGER;

    /*******************************************************************************

    Unidad     :   LDC_PRRECHA_APRUE
    Descripcion:   Valida aprobacion o rechazo.
    *******************************************************************************/
        PROCEDURE LDC_PRRECHA_APRUE
    (
       inuOrdenId         IN   or_order.order_id%type,
       inuEstado          IN   ldc_legaoraco.Estado_Ord%type,
       isbObservacion     IN   ldc_legaoraco.obs_funcionario%type,
       inuFechaInicio     IN   or_order.EXEC_INITIAL_DATE%type,
       inuFechaFin        IN   or_order.EXECUTION_FINAL_DATE%type,
       onuError           OUT  number,
       osbErrorMessage    OUT  varchar2

    );

    /*******************************************************************************
    Unidad     :   SETUPDATELDC_LEGAORACO
    Descripcion:   Actualiza campos estado y observacion en la tabla LDC_LEGAORACO
    *******************************************************************************/
    PROCEDURE SETUPDATELDC_LEGAORACO
    (
       inuOrderId       in   or_order.order_id%type,
       inuEstado        in   ldc_legaoraco.Estado_Ord%type,
       isbObservacion   in   ldc_legaoraco.obs_funcionario%type
    );

    /*******************************************************************************
    Unidad     :   FNUGETCAUSAL
    Descripcion:   Obtiene la caulsal de legalizaicon de LDC_LEGAORACO
    *******************************************************************************/
    FUNCTION FNUGETCAUSAL
    (
       inuOrderId       in   or_order.order_id%type
    )
    return number;

    /*******************************************************************************
    Unidad     :   FNUGETUNIDAD_TRABAJO
    Descripcion:   Obtiene la unidad de trabajo de una orden
    *******************************************************************************/
    FUNCTION FNUGETUNIDAD_TRABAJO
    (
       inuOrderId       in   or_order.order_id%type
    )
    return number;

    /*******************************************************************************
    Unidad     :   GETCONTRATOS
    Descripcion:   Obtiene tabla pl de los contratos a procesar.
    *******************************************************************************/
    PROCEDURE GETCONTRATOS
    (
       inuOrdenId      in   or_order.order_id%type,
       otbLdc_Detamed  out  tytbLdc_detamed
    );

    /*******************************************************************************
    Unidad     :   CREA_VSI
    Descripcion:   Obtiene tabla pl de los contratos a procesar.
    *******************************************************************************/
    PROCEDURE CREA_VSI
    (
      inuSuscripc     in  suscripc.susccodi%type,
      isbGarantia     in  varchar2,
      onuOrden        out or_order.order_id%type,
      onuError        out number,
      sbMesageError   out varchar2
    );

    /*******************************************************************************
    Unidad     :   fnuGetAdittionalData
    Descripcion:   Obtiene los datos adicionales del tipo de trabajo de la orden
    *******************************************************************************/
        FUNCTION fnuGetAdittionalData
    (
        inuTaskType     in or_order.task_type_id%type,
        inuCausal       in Number
    )
    return varchar2;

    

END PGK_LDCAUTO1;

/

create or replace PACKAGE BODY adm_person.PGK_LDCAUTO1
    IS
    /*****************************************************************
    Unidad         : PGK_LDCAUTO
    Descripci¿n    :
    Autor          : OLSOFTWARE SAS
    Fecha          : 17/09/2019

    Historia de Modificaciones
    Fecha       Autor                       Modificaci¿n
    =========   =========                   ====================
    ******************************************************************/

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------
    /*******************************************************************************
  Metodo: fsbGetFlagByOrder
  Descripcion:  Obtiene el flag asociado a la orden

    Autor          : Horbath
    Fecha          : 16-08-2021

    Historia de Modificaciones
    Fecha       Autor                       Modificacion
    =========   =========                   ====================
    16-08-2021  Horbath                     CA676. Creacion
	24/07/2023	jerazomvm					CASO OSF-1261:
											1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
    ******************************************************************/
    Function fsbGetFlagByOrder
    (
        inuOrderId     IN      OR_order.order_id%TYPE
    )
    return varchar2
    IS
        sbValor     LDC_FLAG_GARANTIA.flag_garant%type;

        CURSOR cuDatosOrden
        IS
            SELECT NVL(flag_garant, 'N')
            FROM   LDC_FLAG_GARANTIA
            WHERE  order_id = inuOrderId;

    BEGIN
        ut_trace.trace('Inicia PKG_LDCGRIDLDCAPLAC.fsbGetFlagByOrder',15);

        OPEN cuDatosOrden;
        FETCH cuDatosOrden INTO sbValor;
        CLOSE cuDatosOrden;

        ut_trace.trace('Fin PKG_LDCGRIDLDCAPLAC.fsbGetFlagByOrder - sbValor: '||sbValor,15);
        return nvl(sbValor,'N');

    EXCEPTION
	  WHEN PKG_ERROR.CONTROLLED_ERROR THEN
		  return 'N';
	  WHEN others THEN
		  return 'N';
    END fsbGetFlagByOrder;  

    /**************************************************************
    Unidad      :  LDC_PRRECHA_APRUE
    Descripcion :  Valida aprobacion o rechazo

    Autor         : OLSOFTWARE SAS
    Fecha         : 17/06/2019

    Historia de Modificaciones
    Fecha        Autor                  Modificacion
    =========    =========              ====================
    16-08-2021   Horbath                CA676. Se modifica para que tenga en cuenta
                                        el valor de la tolerancia
	24/07/2023	 jerazomvm				CASO OSF-1261:
										1. Se reemplaza el llamado del API os_legalizeorders
										   por el API api_legalizeorders.
										2. Se reemplaza el manejo de errores ex y errors por Pkg_error.
										3. Se reemplaza el API OS_ASSIGN_ORDER por el API API_ASSIGN_ORDER
										4. Se reemplaza el API OS_RELATED_ORDER por el API api_related_order 
    ***************************************************************/
    PROCEDURE LDC_PRRECHA_APRUE
    (
       inuOrdenId         IN   or_order.order_id%type,
       inuEstado          IN   ldc_legaoraco.Estado_Ord%type,
       isbObservacion     IN   ldc_legaoraco.obs_funcionario%type,
       inuFechaInicio     IN   or_order.EXEC_INITIAL_DATE%type,
       inuFechaFin        IN   or_order.EXECUTION_FINAL_DATE%type,
       onuError           OUT  number,
       osbErrorMessage    OUT  varchar2

    )
    IS

       nuCausal              ldc_legaoraco.cod_causal%type; --Causal de legalizacion
       tbDetamed             PGK_LDCAUTO1.tytbLdc_detamed; --Variable tipo tabla que contiene contratos a procesar
       nuIndex               Pls_integer;--Index para recorrer la tabla
	   tbOrderHijas          PGK_LDCAUTO1.tytbLdc_OrderHijaGen;
       nuActividad           or_order_activity.order_Activity_id%TYPE;
       nuActividadHija       or_order_activity.order_Activity_id%TYPE;
       nuClassCausalid       ge_causal.class_causal_id%type;
       nuTipoCo              OR_ORDER_COMMENT.COMMENT_TYPE_ID%TYPE :=3;
       nuUnidad_trabajo      or_order.operating_unit_id%type;
       nuOrdenHija           or_order.order_id%type;
       sbLectuEl             varchar(100) := '';
       sbDatos               varchar2(8000);
       sbDatosAd             varchar2(4000);
       valueItem             varchar2(2000);
       sbErrorMessage        varchar2(2000);
	   Comment_contratista	 ldc_legaoraco.obs_funcionario%TYPE;
       sw                    boolean := true;
       nuSumItem			 number := 0;
       nuIndexOrhj           number := 0;
       onuErrorCode          number := 0;
       onuErrorCode1         number := 0;
       onuErrorCode2         number := 0;
       onuErrorCode3         number := 0;
       onuErrorCode4         number := 0;
       onuErrorCode5     	 number := 0;
	   nuTotal_Ordenes       number;
       nuValorPro            number;
       inuResponsable        number;
       nuTiempoEspera        number;
	   nuTotalItemPadre      number;
       nuCantItemHja         number;
	   nuValEstOrd7			 number;
	   nuValItemCoti		 number;
	   l_count               number;
	   nuExistCoti           number;
       nuValCoti             number;
       nuVal                 number;
       sbItemsEl             CLOB;
       sbNEWItems            CLOB;
	   sbAllItems            CLOB;

        --000676
	    nuTolerancia          ld_parameter.numeric_value%type:=dald_parameter.fnuGetNumeric_Value('LDC_TOLERANCIA_ITEMS_COTI',0);
	    csbENTREGA676         CONSTANT    VARCHAR2(10) := '0000676';
        sbAplica676           varchar2(1):='N';
        sbGarantia            ldc_flag_garantia.flag_garant%type;       

       -------------------------------
       ERROR_LEGA_ORDEN_PADRE      EXCEPTION;
       ERROR_CREAR_VSI             EXCEPTION;
       ERROR_RELA_ORHI_ORPA        EXCEPTION;
       ERROR_ASIGNAR_ORDEN         EXCEPTION;
       ERROR_ACTIVIDAD_ORDEN       EXCEPTION;
	   ERROR_CANTIDAD_ITEM	       EXCEPTION;
       ERROR_LEGAORDEN_HIJA        EXCEPTION;
       ERROR_VALIDA_ORDER_7    	   EXCEPTION;
       -------------------------------

       

    CURSOR CugetItemsOrder IS
        SELECT  COD_ITEM item_id, VALORTOTAL valor, CANTIDAD cantidad
            FROM    ldc_oritem
            WHERE   order_id = inuOrdenId;

    -- cursor para encontrar el tipo de causal si es de fallo devuelve 0 si es de exito devuelve 1
    CURSOR cuTipoCausal (nuCausal ge_causal.CAUSAL_ID%TYPE ) IS
        SELECT DECODE(CLASS_CAUSAL_ID, 1, 1, 2, 0) tipo
        FROM ge_causal
        WHERE CAUSAL_ID = nuCausal;

    --se obtiene actividad de la orden
    CURSOR cuGetActividad(inuOrdenId or_order.order_id%type) IS
        SELECT ORDER_ACTIVITY_ID --ACTIVITY_ID
        FROM or_order_activity
        WHERE order_id = inuOrdenId;

    -- cursor para validar si la orden que se quiere legalizar se legalizar¿ con items cotizados
    CURSOR cuValItemCotiOrden is
        select count(1)
        from LDC_ORITEM
        where order_id = inuOrdenId
        and   TYPE_ITEMS = 'C';

    -- cursor para validar si la orden se configuro en la forma de cotizaciones LDCRIAICI
    CURSOR cuValLDCRIAICI  is
        select count(1)
        from LDC_ITEMCOTIINTE_LDCRIAIC lm,
             LDC_ITEMADICINTE_LDCRIAIC l
        where lm.codigo = l.codigo
        and   lm.order_id = inuOrdenId;

    -- cursor para validar que el item sea cotizado
    CURSOR cuValItemCoti (nuItem    ge_items.items_id%type)is
        select count(1)
        from LDC_ORITEM ori
        where ori.cod_item = nuItem
        and ori.type_items = 'C';

	CURSOR cuOrdHija is
		select related_order_id Orderhija
		from or_related_order
		where order_id = inuOrdenId;

	CURSOR cuValueItemCoti (nuOrden   or_order.order_id%type,
							nuItem    ge_items.items_id%type) is
		select value valorItemCoti
		from or_order_items
		where order_id = nuOrden
		and   items_id = nuItem;

    -- cursor que obtiene el valor total del item cotizado de la orden padre
    CURSOR cuGetItemFormaCoti (nuOrder   or_order.order_id%type,
							   nuItemhj  ge_items.items_id%type)is
		select COALESCE(sum(lia.total), 0 ) ValorItemPadre
		from LDC_ITEMCOTIINTE_LDCRIAIC lic,
		   LDC_ITEMADICINTE_LDCRIAIC lia
		where  lia.CODIGO = lic.CODIGO
		and    lic.order_id = nuOrder
		and    lic.item_cotizado = nuItemhj;

----------------------------------------------------------------------------------------
-- Procedimiento Pragma para actualizar la tabla LDC_LEGAORACO
----------------------------------------------------------------------------------------
procedure proUpdLegaoraco (nuOrden     PROCEJEC.PREJCOPE%type) is
PRAGMA AUTONOMOUS_TRANSACTION;

    begin

        update LDC_LEGAORACO
        set estado_ord = 'R',
		obs_funcionario = isbObservacion
        where order_id = nuOrden;

        commit;

    exception
      when others then
         null;
    end;
----------------------------------------------------------------------------------------
-- Fin del procedimiento Pragma
----------------------------------------------------------------------------------------

BEGIN

    ut_trace.trace('Inicio Metodo PGK_LDCAUTO.LDC_PRRECHA_APRUE inuOrdenId: ' 	  || inuOrdenId 	|| chr(10) ||
															   'inuEstado: ' 	  || inuEstado 		|| chr(10) ||
															   'isbObservacion: ' || isbObservacion || chr(10) ||
															   'inuFechaInicio: ' || inuFechaInicio || chr(10) ||
															   'inuFechaFin: '	  || inuFechaFin, 10);

    onuError          := 0;
    osbErrorMessage   := '';

	-- se llama al procedimiento que se encarga de guardar La instancia de la forma que se esta ejecutando --
	pkg_error.setapplication('LDCAPLAC');

	-- se obtiene el person_id del responsable
	SELECT RESPONSABLE INTO inuResponsable FROM LDC_LEGAORACO where order_id = inuOrdenId;

    nuTiempoEspera := dald_parameter.fnugetnumeric_value('LDC_PARMTIMEWAIT',NULL);
    
    sbGarantia  := fsbGetFlagByOrder(inuOrdenId);

    IF sbGarantia IS NULL THEN
        sbGarantia := 'N';
    END IF;

    --------------------------------------------
    -- si el estado de la orden es rechazado
    --------------------------------------------
    IF inuEstado = 'R'  THEN

        BEGIN

            ut_trace.trace('Inicia Proceso de Rechazo de la orden',10);
            ut_trace.trace('Cambia el estado de la orden: '||inuOrdenId||' a asignada (5)',10);

			-- se valida que el estado de la orden sea igual a 7 para poder realizar el proceso de rechazo
			select oo.order_status_id into nuValEstOrd7 from or_order oo where oo.order_id = inuOrdenId;

			if(nuValEstOrd7 = 7)then

				--Cambia el estado de la orden haciendo un update en or_order
				update or_order set order_status_id = 5,
									causal_id = null,
									exec_initial_date = null,
									execution_final_date = null,
									legalization_date = null
								where order_id = inuOrdenId;

				-- haciendo un insert en la tabla de cambio de estado de la orden
				insert into OR_ORDER_STAT_CHANGE  (
													ACTION_ID,
													CAUSAL_ID,
													COMMENT_TYPE_ID,
													EXECUTION_DATE,
													FINAL_OPER_UNIT_ID,
													FINAL_STATUS_ID,
													INITIAL_OPER_UNIT_ID,
													INITIAL_STATUS_ID,
													ORDER_ID,
													ORDER_STAT_CHANGE_ID,
													PROGRAMING_CLASS_ID,
													RANGE_DESCRIPTION,
													STAT_CHG_DATE,
													TERMINAL,
													USER_ID
													)
											values (
													102,
													null,
													null,
													inuFechaFin,
													null,
													5,
													null,
													7,
													inuOrdenId,
													or_bosequences.fnuNextOr_Order_Stat_Change,
													null,
													null,
													sysdate,
													ut_session.getTERMINAL,
													ut_session.getUSER
													);
                commit;

				ut_trace.trace('Cambia el estado de la tabla LDC_LEGAORACO a rechazado',10);
				proUpdLegaoraco(inuOrdenId);

				commit;

			else

				--se envia error del proceso
				onuErrorCode4 := -7; -- se establece un codigo de error para que entre en el excepcion y se visualice en la forma el mensaje de error
				sbErrorMessage := 'No se puede rechazar la orden porque no se encuentra en estado ejecutada (7)';
				RAISE ERROR_VALIDA_ORDER_7;

			end if;


            EXCEPTION
              WHEN PKG_ERROR.CONTROLLED_ERROR THEN
                ROLLBACK;
                onuError        := -55;
                osbErrorMessage := 'Error Actualizando el estado de la orden!!';
              WHEN others THEN
                ROLLBACK;
                onuError        := -55;
                osbErrorMessage := 'Error Actualizando el estado de la orden!!';

        END;

    END IF;


    --------------------------------------------
    -- si el estado de la orden es aprobado
    --------------------------------------------
    IF inuEstado = 'A'  THEN

        ut_trace.trace('Se Inicia el proceso de la aprobacion de la orden',10);

        --Se obtiene la unidad de trabajo de la orden
        nuUnidad_trabajo:= PGK_LDCAUTO1.FNUGETUNIDAD_TRABAJO(inuOrdenId);
        --Se obtiene la causal de legalizaicon de la tabla LDC_LEGAORACO
        nuCausal:= PGK_LDCAUTO1.FNUGETCAUSAL(inuOrdenId);
        -- se obtienen los datos adicionales del tipo de trabajo
        sbDatosAd := fnuGetAdittionalData(daor_order.fnugettask_type_id(inuOrdenId), nuCausal);
		-- se obtiene el comentario del contratista
		select osb_contratista into Comment_contratista from ldc_legaoraco where order_id = inuOrdenId;

        --se obtiene actividad de la orden
         OPEN cuGetActividad(inuOrdenId);
         FETCH cuGetActividad INTO nuActividad;
         CLOSE cuGetActividad;

        -- se valida el tipo de causal
         OPEN cuTipoCausal(nuCausal);
         FETCH cuTipoCausal INTO nuClassCausalid;
         CLOSE cuTipoCausal;

        	ut_trace.trace('Se inicia el proceso de legalizacion de la orden padre creando ordenes hijas VSI ',10);

			-- si la causal es de exito se legaliza la orden padre con causal de exito y ademas se crean, asigna y legalizan las ordenes hijas

			--------------------------------------------
			-- PROCESO LEGALIZACION DE LA ORDEN PADRE --
			--------------------------------------------
			-- se busca si la orden que se quiere legalizar tenga items cotizados
			open cuValItemCotiOrden;
			fetch cuValItemCotiOrden into nuValCoti;
			close cuValItemCotiOrden;

			if nuValCoti > 0 then
				-- se valida que la orden padre est¿ registrada en la forma de cotizacion LDCRIAICI
				open cuValLDCRIAICI;
				fetch cuValLDCRIAICI into nuVal;
					if cuValLDCRIAICI%NOTFOUND then
						 onuErrorCode := -75;
						 sbErrorMessage := 'Error no se puede legalizar la orden, porque la orden['||inuOrdenId||'] se debe configurar en la forma LDCRIAICI ya que tiene items cotizados';
						 RAISE ERROR_LEGA_ORDEN_PADRE;
					end if;
				close cuValLDCRIAICI;

			end if;

			-- se legaliza orden padre sin items
			sbDatos :=  inuOrdenId||'|'||
						nuCausal||'|'||
						inuResponsable||'||'||
						nuActividad||'>'||
						nuClassCausalid||';;;;|||'||
						nuTipoCo||';'||  -- tipo comentario
						Comment_contratista;

			ut_trace.trace('Cadena de legalizacion Orden Padre: '|| sbDatos,10);
			
			ut_trace.trace('Ingresa api_legalizeorders isbDataOrder: '	|| sbDatos 		  || chr(10) ||
													  'idtInitDate: '	|| inuFechaInicio || chr(10) ||
													  'idtFinalDate: '	|| inuFechaFin	  || chr(10) ||
													  'idtChangeDate: '	|| sysdate, 10);

			api_legalizeorders(sbDatos, 
							   inuFechaInicio, 
							   inuFechaFin, 
							   sysdate, 
							   onuErrorCode, 
							   sbErrorMessage
							   );
							   
			ut_trace.trace('Sale api_legalizeorders onuErrorCode: '		|| onuErrorCode || chr(10) ||
												   'sbErrorMessage: '	|| sbErrorMessage, 10);

			IF (onuErrorCode <> 0) then
			   ut_trace.trace('Present¿ un error al legalizar la orden padre',10);
			   RAISE ERROR_LEGA_ORDEN_PADRE;
			END IF;

			ut_trace.trace('Se pone a esperar el programa por 15 segundos',10);
			DBMS_LOCK.Sleep(nuTiempoEspera);

			ut_trace.trace('Se legaliz¿ la orden padre correctamente',10);

			------------------------------------------------
			-- FIN PROCESO LEGALIZACION DE LA ORDEN PADRE --
			------------------------------------------------

			--------------------------------------------------
			-- INICIO PROCESO DE ORDENES HIJAS --
			--------------------------------------------------

			--Se obtienen los contratos a procesar
			PGK_LDCAUTO1.GETCONTRATOS(inuOrdenId,tbDetamed);
			--Total de contratos a procesar, se crea orden por cada contrato
			nuTotal_Ordenes := tbDetamed.count;
			--Se inicializa el index en la primera posicion de la tabla pl con los contratos
			nuIndex:= tbDetamed.first;

			--------------------------------------------
			-- se recorren los contratos de los medidores seleccionado en la forma .NET
			--------------------------------------------
			LOOP
			  exit when nuIndex is null;
				  ut_trace.trace('Se genera la solicitud VSI para cada contrato y se retorna la orden generada',10);
				  PGK_LDCAUTO1.CREA_VSI(tbDetamed(nuIndex).nuCod_Contrato , sbGarantia, nuOrdenHija, onuErrorCode1, sbErrorMessage);

				  IF (onuErrorCode1 <> 0) then
						ut_trace.trace('Error al generar la solicitud de VSI!!',10);
						RAISE ERROR_CREAR_VSI;
				  END IF;

				  ut_trace.trace('Ingresa api_related_order inuOrdenId: '	|| inuOrdenId	|| chr(10) ||
														   'nuOrdenHija: '	|| nuOrdenHija, 12);
				  
				  ut_trace.trace('Relacionar orden hija a orden padre ',10);
				  api_related_order(inuOrdenId, 
									nuOrdenHija, 
									onuErrorCode2, 
									sbErrorMessage
									);
									
				  ut_trace.trace('Finaliza api_related_order onuErrorCode2: '	|| onuErrorCode2	|| chr(10) ||
														    'sbErrorMessage: '	|| sbErrorMessage, 12);

				  IF (onuErrorCode2 <> 0) then
						ut_trace.trace('Error al relacionar la orden hija creada con el padre!! ',10);
						RAISE ERROR_RELA_ORHI_ORPA;
				  END IF;

				  ut_trace.trace('Se asigna la orden hija a la unidad de trabajo de la orden padre ',10);
				  ut_trace.trace('ingresa api_assign_order nuOrden: ' || nuOrdenHija || CHR(10) ||
														  'inuOperatingUnit: ' || nuUnidad_trabajo, 6);
				  api_assign_order(nuOrdenHija, 
								   nuUnidad_trabajo,
								   onuErrorCode3, 
								   sbErrorMessage
								   );
								   
				  ut_trace.trace('Finaliza api_assign_order nuerrorcode: ' || onuErrorCode3 || CHR(10) ||
													 'sberrormessage: ' || sberrormessage, 6);

				  IF (onuErrorCode3 <> 0) then
						ut_trace.trace('Error al asignar la orden hija a la unidad de trabajo de la orden padre!!',10);
						RAISE  ERROR_ASIGNAR_ORDEN;
				  END IF;

				  --se obtiene actividad de la orden hija
				  OPEN cuGetActividad(nuOrdenHija);
				  FETCH cuGetActividad INTO nuActividadHija;
				  CLOSE cuGetActividad;

				  IF (nuActividadHija IS NULL) then
					RAISE ERROR_ACTIVIDAD_ORDEN;
				  END IF;

				  -- se obtienen los datos adicionales
				--  sbDatosAd := fnuGetAdittionalData(daor_order.fnugettask_type_id(nuOrdenHija), nuCausal);

				  nuValorPro:=0;
				  nuCantItemHja:=0;
				  --------------------------------------------
				  -- se recorren los items de los medidores seleccionados en la forma .NET
				  --------------------------------------------
				  for item in CugetItemsOrder
					loop

						-- se calcula el valor prorrateado del Item
						nuCantItemHja := item.cantidad / nuTotal_Ordenes;

						IF(nuCantItemHja < 0 OR nuCantItemHja = 0)THEN
						   RAISE ERROR_CANTIDAD_ITEM;
						END IF;

						-- se llena la tabla PL tbOrderHijas con el valor de la orden hija y la cantidad prorrateada del item
						tbOrderHijas(nuIndexOrhj).ORDER_HIJA      := nuOrdenHija;
						tbOrderHijas(nuIndexOrhj).ACTIVITY_ID     := nuActividadHija;
						tbOrderHijas(nuIndexOrhj).ITEM_ID         := item.item_id;
						tbOrderHijas(nuIndexOrhj).CANT_ITEM       := nuCantItemHja;

						nuIndexOrhj := nuIndexOrhj + 1;

				   end loop;

			  --Se incrementa el index en la siguiente posicion

			  nuIndex := tbDetamed.next(nuIndex);

			END LOOP;

			----------------------------------------------------------------------------------
			-- SE REALIZA EL PROCESO DE LEGALIZACION DE LAS ORDENES HIJAS  --
			----------------------------------------------------------------------------------
			-- se recorre la tabla PL
			IF tbOrderHijas.COUNT  > 0 THEN

					FOR k IN tbOrderHijas.FIRST..tbOrderHijas.LAST
					LOOP
						if(sw) then

							 sbAllItems := '';
							 -- se recorre la misma tabla PL para encontrar los items
							 FOR j IN tbOrderHijas.FIRST..tbOrderHijas.LAST
							 LOOP
								 if(tbOrderHijas(k).ORDER_HIJA = tbOrderHijas(j).ORDER_HIJA)then
									sbAllItems := sbAllItems||','||tbOrderHijas(j).ITEM_ID ; --se llena una cadena auxiliar que almacena todos los items
									sbItemsEl := sbItemsEl || tbOrderHijas(j).ITEM_ID || '>' || tbOrderHijas(j).CANT_ITEM|| '>' || 'Y;';
								 end if;
							 END LOOP;

							 -- se elimina el ultimo valor que seria el ";"
							 select LPAD(sbItemsEl, LENGTH(sbItemsEl) - 1)into sbNEWItems from dual;

							 -- se resetea la variable
							 sbItemsEl := '';

							 -- se configura la cadena de datos para enviarla a la API de legalizacion
							 sbDatos    :=  tbOrderHijas(k).ORDER_HIJA||'|'||
											nuCausal||'|'||
											inuResponsable||'|'||
											sbDatosAd||'|'||
											tbOrderHijas(k).ACTIVITY_ID||'>1 ;READING>' ||
											sbLectuEl ||'>>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|'||
											sbNEWItems||'>||'||'1;'||
											Comment_contratista;

							 ut_trace.trace('Se legaliza la orden hija con item cotizado y demas ordenes asociadas !!',10);

							 ut_trace.trace('Ingresa api_legalizeorders isbDataOrder: '	 || sbDatos 	   || chr(10) ||
																       'idtInitDate: '	 || inuFechaInicio || chr(10) ||
																	   'idtFinalDate: '	 || inuFechaFin	   || chr(10) ||
																	   'idtChangeDate: ' || sysdate, 10);
							 
							 api_legalizeorders(sbDatos, 
												inuFechaInicio, 
												inuFechaFin, 
												sysdate, 
												onuErrorCode4, 
												sbErrorMessage
												);
												
							 ut_trace.trace('Sale api_legalizeorders onuErrorCode4: '	|| onuErrorCode4 || chr(10) ||
																	'sbErrorMessage: '	|| sbErrorMessage, 10);

							 IF (onuErrorCode4 <> 0) then
								  ut_trace.trace('Error al legalizar la orden hija !!',10);
								  RAISE ERROR_LEGAORDEN_HIJA;
							 END IF;

						end if;

						exit when tbOrderHijas.next(k) is null;

						if(tbOrderHijas(k).ORDER_HIJA = tbOrderHijas(k+1).ORDER_HIJA)then
							sw := false;
						else
							sw := true;
						end if;

					END LOOP;

					-------------------------------------------------------------------------------------------------------------
					-- SE VALIDA SI EXISTE ALGUN ITEM COTIZADO PARA VALIDAR EL VALOR DEL ITEM COTIZADO LEGALIZADO CON EL PADRE --
					-------------------------------------------------------------------------------------------------------------
					sbAllItems := sbAllItems||',';
					l_count := length(sbAllItems) - length(replace(sbAllItems,',',''));

					-- se recorre la cadena que tiene la informacion de todos los items
					for i in 1 .. l_count loop

						select regexp_substr(sbAllItems,'[^,]+',1,i) into valueItem from dual;

						-- Se valida si el item es cotizado
						open cuValItemCoti (valueItem);
						fetch cuValItemCoti into nuExistCoti;
						close cuValItemCoti;

						-- si el item es cotizado
						if nuExistCoti > 0 then
                            nuSumItem := 0;
							-- se consultan las ordenes hijas de la orden padre legalizada
							for j in cuOrdHija
							loop
								-- se consulta el valor legalizado del item en la orden hija
								open cuValueItemCoti(j.Orderhija, valueItem);
								fetch cuValueItemCoti into nuValItemCoti;
									if cuValueItemCoti%found then
										nuSumItem := nuSumItem + nuValItemCoti;
									end if;
								close cuValueItemCoti;

							end loop;

							-- se valida el total del item obtenido de la suma del valor de los items asociados a las ordenes hijas
							-- con el item de la orden padre configurada en la forma LDCRIAICI
							open cuGetItemFormaCoti(inuOrdenId, valueItem);
							fetch cuGetItemFormaCoti into nuTotalItemPadre;
							close cuGetItemFormaCoti;

                            -- Inicia CA676
                            -- Se obtiene el valor de la tolerancia
                            nuTolerancia := dald_parameter.fnuGetNumeric_Value('LDC_TOLERANCIA_ITEMS_COTI',0);
                            

							-- si los valores son diferentes se envia un mensaje de error revirtiendo la orden legalizada
							IF NOT (nuSumItem BETWEEN (nuTotalItemPadre - nuTolerancia) AND (nuTotalItemPadre + nuTolerancia)) THEN
								onuErrorCode4 := -25;
								sbErrorMessage := 'Error no se puede legalizar la orden, porque el valor de los items cotizados ingresados en la forma LDCAPLAC['||nuSumItem||'] no corresponden al valor de la orden padre en la forma LDCRIAICI['||nuTotalItemPadre||']';
								RAISE ERROR_LEGAORDEN_HIJA;
							end if;

						end if;

					end loop;

			ELSE
				--se envia error del proceso
				onuErrorCode4 := -45;
				sbErrorMessage := 'No se encontraron datos de las ordenes hijas creadas por la solicitud de VSI, revise el proceso';
				RAISE ERROR_LEGAORDEN_HIJA;
			END IF;

		--END IF;

		ut_trace.trace('Se actualiza el estado y la observacion de la orden en la tabla LDC_LEGAORACO',10);
		PGK_LDCAUTO1.SETUPDATELDC_LEGAORACO(inuOrdenId,inuEstado,isbObservacion);

		ut_trace.trace('Termina el proceso de legalizacion de areas comunes de forma correcta!!',10);

		commit;

    END IF; -- fin inuEstado = 'A'

    -- se vuelve a activar el plugin LDC_PRVALIDAITEMCOTIZADO
    --proUpdprocedimiento_obj('S');

    ut_trace.trace('Finaliza Metodo PGK_LDCAUTO.LDC_PRRECHA_APRUE onuError: ' 		 || onuError || chr(10) ||
																 'osbErrorMessage: ' || osbErrorMessage, 10);

    EXCEPTION
        WHEN ERROR_LEGA_ORDEN_PADRE THEN
            ROLLBACK;
            onuError          := onuErrorCode;
            osbErrorMessage   := sbErrorMessage;

        WHEN ERROR_CREAR_VSI THEN
            ROLLBACK;
            onuError          := onuErrorCode1;
            osbErrorMessage   := sbErrorMessage;

        WHEN ERROR_RELA_ORHI_ORPA THEN
            ROLLBACK;
            onuError        := onuErrorCode2;
            osbErrorMessage := sbErrorMessage;

        WHEN ERROR_ASIGNAR_ORDEN THEN
            ROLLBACK;
            onuError        := onuErrorCode3;
            osbErrorMessage := sbErrorMessage;

        WHEN ERROR_ACTIVIDAD_ORDEN THEN
            ROLLBACK;
            onuError          := -5;
            osbErrorMessage   := 'No se encontro la actividad de la orden';

		WHEN ERROR_CANTIDAD_ITEM THEN
            ROLLBACK;
            onuError          := -999;
            osbErrorMessage   := 'La cantidad del item debe ser mayor a 0';

        WHEN ERROR_LEGAORDEN_HIJA THEN
            ROLLBACK;
            onuError        := onuErrorCode4;
            osbErrorMessage := sbErrorMessage;

		WHEN ERROR_VALIDA_ORDER_7 THEN
		    ROLLBACK;
			onuError        := onuErrorCode5;
			osbErrorMessage := sbErrorMessage;

        when PKG_ERROR.CONTROLLED_ERROR then
            ROLLBACK;
            raise PKG_ERROR.CONTROLLED_ERROR;

        when others then
            ROLLBACK;
            Pkg_error.setError;
            raise PKG_ERROR.CONTROLLED_ERROR;

    END LDC_PRRECHA_APRUE;

    /**************************************************************
    Unidad      :  SETUPDATELDC_LEGAORACO
    Descripcion :  Actualiza campos estado y observacion en la tabla LDC_LEGAORACO

    Parametros  :
                   inuOrderId   --Numero de la orden
                   inuEstado    --Nuevo estado de la orden
                   isbObservacion   -- Observacion

    Autor         : OLSOFTWARE SAS
    Fecha         : 17/09/2019

    Historia de Modificaciones
    Fecha        Autor                  Modificacion
    =========    =========              ====================
	24/07/2023	 jerazomvm				CASO OSF-1261:
										1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
    ***************************************************************/
    PROCEDURE SETUPDATELDC_LEGAORACO
    (
       inuOrderId       in   or_order.order_id%type,
       inuEstado        in   ldc_legaoraco.Estado_Ord%type,
       isbObservacion   in   ldc_legaoraco.obs_funcionario%type
    )
    IS
    BEGIN
        ut_trace.trace('Inicio Metodo PGK_LDCAUTO.SETUPDATELDC_LEGAORACO',10);
        UPDATE ldc_legaoraco
            SET estado_ord = inuEstado,
                obs_funcionario = isbObservacion
            WHERE order_id = inuOrderId;
        ut_trace.trace('Inicio Metodo PGK_LDCAUTO.SETUPDATELDC_LEGAORACO',10);
    EXCEPTION
        when PKG_ERROR.CONTROLLED_ERROR then
            raise PKG_ERROR.CONTROLLED_ERROR;
        when others then
            Pkg_error.setError;
            raise PKG_ERROR.CONTROLLED_ERROR;
    END SETUPDATELDC_LEGAORACO;


    /**************************************************************
    Unidad      :  FNUGETCAUSAL
    Descripcion :  Obtiene la caulsal de legalizaicon de LDC_LEGAORACO

    Parametros  :
                   inuOrderId   --Numero de la orden


    Autor         : OLSOFTWARE SAS
    Fecha         : 17/09/2019

    Historia de Modificaciones
    Fecha        Autor                  Modificacion
    =========    =========              ====================
	24/07/2023	 jerazomvm				CASO OSF-1261:
										1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
    ***************************************************************/
    FUNCTION FNUGETCAUSAL
    (
       inuOrderId       in   or_order.order_id%type
    )
    return number
    IS
        nuCausal  number;
        CURSOR cuCursor IS
            SELECT COD_CAUSAL FROM LDC_LEGAORACO WHERE ORDER_ID  = inuOrderId;
    BEGIN
        ut_trace.trace('Inicio Metodo PGK_LDCAUTO.FNUGETCAUSAL',10);

        if(cuCursor%isopen)then
            close cuCursor;
        end if;

        open cuCursor;
        fetch cuCursor  into nuCausal;
        close cuCursor;

        return nuCausal;

        ut_trace.trace('Finalizo Metodo PGK_LDCAUTO.FNUGETCAUSAL',10);
    EXCEPTION
        when PKG_ERROR.CONTROLLED_ERROR then
            raise PKG_ERROR.CONTROLLED_ERROR;
        when others then
            Pkg_error.setError;
            raise PKG_ERROR.CONTROLLED_ERROR;
    END FNUGETCAUSAL;

     /**************************************************************
    Unidad      :  FNUGETUNIDAD_TRABAJO
    Descripcion :  Obtiene la unidad de trabajo de una orden

    Parametros  :
                   inuOrderId   --Numero de la orden


    Autor         : OLSOFTWARE SAS
    Fecha         : 17/09/2019

    Historia de Modificaciones
    Fecha        Autor                  Modificacion
    =========    =========              ====================
    ***************************************************************/
    FUNCTION FNUGETUNIDAD_TRABAJO
    (
       inuOrderId       in   or_order.order_id%type
    )
    return number
    IS
        nuUnidad_trabajo  number;
        CURSOR cuCursor IS
            SELECT operating_unit_id FROM or_order WHERE ORDER_ID  = inuOrderId;
    BEGIN
        ut_trace.trace('Inicio Metodo PGK_LDCAUTO.FNUGETUNIDAD_TRABAJO',10);

        if(cuCursor%isopen)then
            close cuCursor;
        end if;

        open cuCursor;
        fetch cuCursor  into nuUnidad_trabajo;
        close cuCursor;

        return nuUnidad_trabajo;

        ut_trace.trace('Finalizo Metodo PGK_LDCAUTO.FNUGETUNIDAD_TRABAJO',10);
    EXCEPTION
        when PKG_ERROR.CONTROLLED_ERROR then
            raise PKG_ERROR.CONTROLLED_ERROR;
        when others then
            Pkg_error.setError;
            raise PKG_ERROR.CONTROLLED_ERROR;
    END FNUGETUNIDAD_TRABAJO;



    /**************************************************************
    Unidad      :  GETCONTRATOS
    Descripcion :  Obtiene tabla pl de los contratos a procesar

    Parametros  :
                   inuOrderId   --Numero de la orden
                   otbLdc_Detamed   -- Tabla con los contratos

    Autor         : OLSOFTWARE SAS
    Fecha         : 17/09/2019

    Historia de Modificaciones
    Fecha        Autor                  Modificacion
    =========    =========              ====================
	24/07/2023	jerazomvm				CASO OSF-1261:
										1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
    ***************************************************************/
    PROCEDURE GETCONTRATOS
    (
       inuOrdenId      in   or_order.order_id%type,
       otbLdc_Detamed  out  tytbLdc_detamed
    )
    IS
        CURSOR   cuCursor   IS
            SELECT  COD_CONTRATO
            FROM    LDC_DETAMED
            WHERE   ORDER_ID = inuOrdenId;
    BEGIN
        ut_trace.trace('Inicio Metodo PGK_LDCAUTO.GETCONTRATOS',10);
        if(cuCursor%isopen)then
            close cuCursor;
        end if;

        open cuCursor;
        fetch cuCursor bulk collect into  otbLdc_Detamed;
        close cuCursor;
        ut_trace.trace('Inicio Metodo PGK_LDCAUTO.GETCONTRATOS',10);

    EXCEPTION
        when PKG_ERROR.CONTROLLED_ERROR then
            raise PKG_ERROR.CONTROLLED_ERROR;
        when others then
            Pkg_error.setError;
            raise PKG_ERROR.CONTROLLED_ERROR;
    END GETCONTRATOS;


    /**************************************************************
    Unidad      :  CREA_VSI
    Descripcion :  Crea la solicitud de VSI


    Autor         : OLSOFTWARE SAS
    Fecha         : 17/09/2019

    Historia de Modificaciones
    Fecha        Autor                  Modificacion
    =========    =========              ====================
	24/07/2023	jerazomvm				CASO OSF-1261:
										1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
										2. Se reemplaza el API OS_RegisterRequestWithXML por el API api_registerRequestByXml.
    ***************************************************************/
    PROCEDURE CREA_VSI
    (
      inuSuscripc     in  suscripc.susccodi%type,
      isbGarantia     in  varchar2,    
      onuOrden        out or_order.order_id%type,
      onuError        out number,
      sbMesageError   out varchar2
    )
    IS
        sbComentario          VARCHAR2(2000):= 'GENERADA POR LA FORMA LDCAPLAC';
        nuProductId           pr_product.product_id%type;
        nuAddressId           ab_address.address_id%type;
        nuSubscriber          ge_subscriber.subscriber_id%type;
        nuRecepcion           ge_reception_type.reception_type_id%type;
        nuUsuario             sa_user.user_id%type;
        nuItems               ge_items.items_id%type;
        nuUnidad              ge_organizat_area.organizat_area_id%type;
        sbRequestXML          VARCHAR2(30000);
        onuPackageId          mo_packages.package_id%type;
        onuMotiveId           mo_motive.motive_id%type;
        nuErrorCode           number;--ge_error_log.error_log_id%type;
        sbErrorMessage        varchar2(2000);--ge_error_log.description%type;
        exError               exception;

        cursor cuCursor is
          SELECT SE.SESUNUSE
          FROM   SUSCRIPC C,
                 SERVSUSC SE
          WHERE  C.SUSCCODI = inuSuscripc
          AND    C.SUSCCODI = SE.SESUSUSC
          AND    SE.SESUSERV = 7014;

        cursor cuUnidad is
          SELECT a.organizat_area_id
          FROM ge_organizat_area a, cc_orga_area_seller b
          WHERE a.organizat_area_id = b.organizat_area_id
          AND b.person_id = nuUsuario;

        cursor cuOrden is
          SELECT order_id
          FROM or_order_activity
          WHERE package_id = onuPackageId;



    BEGIN
        ut_trace.trace('Inicio Metodo PGK_LDCAUTO.CREA_VSI inuSuscripc: ' || inuSuscripc || CHR(10) ||
														  'isbGarantia: ' || isbGarantia, 10);
														  
        --Se abre cursor para obtener el producto
        if(cuCursor%isopen)then
            close cuCursor;
        end if;

        open cuCursor;
        fetch cuCursor  into nuProductId;
        close cuCursor;

         IF isbGarantia = 'N' THEN
            --Se obtiene la actividad definida en el aprametro LDC_ACVSI
            nuItems:= dald_parameter.fnugetnumeric_value('LDC_ACVSI', NULL);
        ELSE
            nuItems:= dald_parameter.fnuGetNumeric_Value('LDC_ACTI_NEW_WARRANTY', null);
        END IF;
        --Se obtiene el medio de recepcion definido en el parametro LDC_MEREC
        nuRecepcion:= dald_parameter.fnugetnumeric_value('LDC_MEREC', NULL);
        --Se obtiene el usuario conectado
        nuUsuario := ge_bopersonal.fnuGetPersonId;

        --Se abre el cursor para opbtener la unidad que procesara la solicitud
        if(cuUnidad%isopen)then
            close cuUnidad;
        end if;

        open cuUnidad;
        fetch cuUnidad  into nuUnidad;
        close cuUnidad;

        --Obtener direccion del producto
        nuAddressId := dapr_product.fnugetaddress_id(nuProductId,null);
        if nuAddressId is null then
             nuErrorCode:=1;
        end if;

       --Obtener suscriptor para el contrato
       nuSubscriber := pktblsuscripc.fnugetsuscclie(inuSuscripc,null);
       if nuSubscriber is null then
             nuErrorCode:=1;
       end if;


       sbRequestXML := '<?xml version="1.0" encoding="utf-8" ?>
                        <P_LBC_VENTA_DE_SERVICIOS_DE_INGENIERIA_100101 ID_TIPOPAQUETE="100101">
                        <CUSTOMER>'||nuSubscriber||'</CUSTOMER>
                        <CONTRACT>'||inuSuscripc||'</CONTRACT>
                        <PRODUCT>'||nuProductId||'</PRODUCT>
                        <FECHA_DE_SOLICITUD>'||sysdate||'</FECHA_DE_SOLICITUD>
                        <ID>'||nuUsuario||'</ID>
                        <POS_OPER_UNIT_ID>'||nuUnidad||'</POS_OPER_UNIT_ID>
                        <RECEPTION_TYPE_ID>'||nuRecepcion||'</RECEPTION_TYPE_ID>
                        <CONTACT_ID>'||nuSubscriber||'</CONTACT_ID>
                        <ADDRESS_ID>'||nuAddressId||'</ADDRESS_ID>
                        <COMMENT_>'||sbComentario||'</COMMENT_>
                        <CONTRATO>'||inuSuscripc||'</CONTRATO>
                        <M_SOLICITUD_DE_TRABAJOS_PARA_UN_CLIENTE_100113>
                        <ITEM_ID>'||nuItems||'</ITEM_ID>
                        <DIRECCION_DE_EJECUCION_DE_TRABAJOS>'||nuAddressId||'</DIRECCION_DE_EJECUCION_DE_TRABAJOS>
                        <C_GENERICO_22>
                        <C_GENERICO_10319>1</C_GENERICO_10319>
                        </C_GENERICO_22>
                        </M_SOLICITUD_DE_TRABAJOS_PARA_UN_CLIENTE_100113>
                        </P_LBC_VENTA_DE_SERVICIOS_DE_INGENIERIA_100101>';

                     DBMS_OUTPUT.PUT_LINE('**6');

          /*Ejecuta el XML creado, la solicitud se atendera con la accion del tramite creado*/
          api_registerRequestByXml(Isbrequestxml =>  sbRequestXML,
									Onupackageid  =>  onupackageid,
									Onumotiveid  =>   onumotiveid,
									Onuerrorcode =>   nuErrorCode,
									Osberrormessage => sbErrorMessage
									);

          IF (nuErrorCode <> 0) then
            onuError :=  nuErrorCode;
            sbMesageError := sbErrorMessage;

          END IF;


        if(cuOrden%isopen)then
            close cuOrden;
        end if;

        open cuOrden;
        fetch cuOrden  into onuOrden;
        close cuOrden;

        ut_trace.trace('Finaliza Metodo PGK_LDCAUTO.CREA_VSI',10);

        EXCEPTION
            when PKG_ERROR.CONTROLLED_ERROR then
                raise PKG_ERROR.CONTROLLED_ERROR;
            when others then
                Pkg_error.setError;
                raise PKG_ERROR.CONTROLLED_ERROR;
    END CREA_VSI;



    /**************************************************************
    Unidad      :  fnuGetAdittionalData
    Descripcion :  Obtiene los datos adicionales del tipo de trabajo

    Parametros  :  inuTaskType   --Numero del tipo de trabajo
                   inuCausal     --Numero del tipo de causal


    Autor         : OLSOFTWARE SAS
    Fecha         : 17/09/2019

    Historia de Modificaciones
    Fecha        Autor                  Modificacion
    =========    =========              ====================
	24/07/2023	jerazomvm				CASO OSF-1261:
										1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
    ***************************************************************/
    FUNCTION fnuGetAdittionalData
    (
        inuTaskType     in or_order.task_type_id%type,
        inuCausal       in Number
    )
    return varchar2
    IS
        -- Variables de error
        nuErrorCode NUMBER;
        sbErrorMessage VARCHAR2(4000);

        CURSOR cuGetAditDatta
        IS
            select  b.name_attribute name_attribute
        from ge_attributes b, ge_attrib_set_attrib a
       where b.attribute_id = a.attribute_id
         and a.attribute_set_id in
             (select ottd.attribute_set_id
                from or_tasktype_add_data ottd
               where ottd.task_type_id = inuTaskType
                 and ottd.active = 'Y'
                 and (ottd.use_ = decode(DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID(inuCausal,
                                                                           null),
                                         1,
                                         'C',
                                         2,
                                         'I') or ottd.use_ = 'B') --*/
              )
       order by a.attribute_set_id, a.capture_order;

        sbAdditData varchar2(4000);

    BEGIN

        for rcGetAditDatta in cuGetAditDatta loop
            sbAdditData := sbAdditData||rcGetAditDatta.name_attribute||'=;';
        end loop;

        sbAdditData := SUBSTR(sbAdditData,-(length(sbAdditData)),length(sbAdditData)-1);

        return sbAdditData;

    EXCEPTION
        when others then
            Pkg_error.getError(nuErrorCode, sbErrorMessage);
    END fnuGetAdittionalData;
    
END pgk_ldcauto1;

/
PROMPT Otorgando permisos de ejecucion a PGK_LDCAUTO1
BEGIN
    pkg_utilidades.praplicarpermisos('PGK_LDCAUTO1', 'ADM_PERSON');
END;
/