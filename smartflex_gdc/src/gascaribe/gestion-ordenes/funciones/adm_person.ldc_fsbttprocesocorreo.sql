CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FSBTTPROCESOCORREO" (inuOrder IN number) RETURN VARCHAR2 IS
/**************************************************************************
        Autor       : Ernesto Santiago / Horbath
        Fecha       : 2020-06-28
        Ticket      : 700
        Descripcion : funcion que envia correo dependiendo de la configuracion en la forma LDCCOTTPRO.

        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
		12/07/2021   esantiago   (Horbath)  CASO 700_2  Se modifica la sentenciade los cursores CUDATACONFCAUSAL, CUDATACONFDEPARTAMENTO, CUDATACONFITEM
									               y utiliza la validacion de aplica para la gasera al inicion de la logica.
		12/07/2022   dsaltarin   OSF-419: Se agrega unidad operativa al mensaje. Se depura el código
   ***************************************************************************/

	sbAsunto          open.ld_parameter.value_chain%type:= open.dald_parameter.fsbgetvalue_chain('ASUNTO_TT_PROCESO', NULL);
	sbMensaje         VARCHAR2(4000);
	nuCudataconfitem  NUMBER;
	sbTipoIns         VARCHAR2(4000);

	CURSOR cuDataOrden  (orden NUMBER) IS
		SELECT	oo.task_type_id,
				oo.causal_id,
				gc.description desc_causal,
				nvl(oa.address_id ,oo.external_address_id)address_id 	,
				oa.activity_id,
				gi.description des_activity,
				oa.subscription_id ,
				lo.geo_loca_father_id,oc.order_comment,
				oo.operating_unit_id,
				(SELECT u.name FROM open.or_operating_unit u WHERE u.operating_unit_id = oo.operating_unit_id) name_unidad
		FROM open.or_order oo
		INNER JOIN open.or_order_activity oa ON oo.order_id = oa.order_id
		INNER JOIN open.ge_geogra_location lo ON lo.geograp_location_id = open.daab_address.fnugetgeograp_location_id( nvl(oa.address_id ,oo.external_address_id), NULL)
		INNER JOIN open.ge_items gi ON gi.ITEMS_ID = oa.activity_id
		LEFT  JOIN open.ge_causal gc ON gc.CAUSAL_ID = oo.causal_id
		LEFT  JOIN open.or_order_comment oc ON oc.order_id= oo.order_id AND oc.legalize_comment='Y'
		WHERE oo.order_id=orden
		AND rownum=1;

	regdataorden cuDataOrden%ROWTYPE;

	CURSOR cuDataConfCausal (task_type NUMBER,
						causal    NUMBER) IS --700_2
		SELECT ot_proceso_id
		FROM open.ldc_tt_proceso
		WHERE task_type_id=task_type
		AND (causal_id=causal or causal_id is null );

	CURSOR cuDataConfDepartamento (dep NUMBER,
								Proceso NUMBER) IS --700_2
		SELECT email
		FROM open.ldc_detalle1_tt_proceso d1
		WHERE d1.ot_proceso_id=proceso
		AND  (d1.departamento=dep or d1.departamento is null ) ;


	CURSOR cuDataConfItem (Proceso NUMBER,
							orden   NUMBER) IS --700_2
		SELECT 1
		FROM (SELECT count(1) legalizadas
				FROM open.or_order_items
				WHERE order_id=orden
				AND items_id in  (SELECT d2.item_legalizado
									FROM ldc_detalle2_tt_proceso d2
									WHERE d2.ot_proceso_id=Proceso )
				AND legal_item_amount>0) le,
			 (SELECT count(1) configuradas
				FROM open.ldc_detalle2_tt_proceso d2
				WHERE d2.ot_proceso_id=Proceso) con
		WHERE legalizadas = configuradas;

BEGIN
	ut_trace.trace('INICIO LDC_FSBTTPROCESOCORREO', 10);
    
    sbTipoIns := ldc_boconsgenerales.fsbgetdatabasedesc();
	sbAsunto := sbTipoIns||': '||sbAsunto;
    
    IF cuDataOrden%ISOPEN THEN
		CLOSE cuDataOrden;
	END IF;
	OPEN cuDataOrden (inuOrder);
	FETCH cuDataOrden  INTO regdataorden;
	CLOSE cuDataOrden ;


	sbMensaje := substr('La orden '||inuOrder||' de la actividad '||regdataorden.activity_id||' - '|| regdataorden.des_activity||
				' del contrato '||regdataorden.subscription_id||' ha sido cerrada con la causal '||regdataorden.causal_id||' - '|| regDATAORDEN.desc_causal||
				', unidad '||regdataorden.operating_unit_id||' - '||regdataorden.name_unidad||
				' y observaci'||chr(243)||'n: '||regdataorden.order_comment,1,4000);

	FOR config IN cuDataConfCausal (regDATAORDEN.task_type_id ,regDATAORDEN.causal_id ) LOOP

		nuCudataconfitem:=null;

		OPEN cuDataConfItem (Config.ot_proceso_id,inuOrder  );
		FETCH cuDataConfItem 	INTO nuCudataconfitem;
		CLOSE cuDataConfItem;

		if nuCudataconfitem is not null then
			for reg in cuDataConfDepartamento(regDATAORDEN.GEO_LOCA_FATHER_ID,Config.ot_proceso_id) loop
				ldc_sendemail(reg.email, sbAsunto, sbMensaje);
			end loop;
		end if;

	END LOOP;

	Ut_Trace.TRACE('INICIO LDC_FSBTTPROCESOCORREO', 10);
	RETURN('Y');
EXCEPTION
	WHEN ex.controlled_error THEN
		RETURN('Y');
	WHEN OTHERS THEN
		errors.seterror;
		RETURN('Y');
END LDC_FSBTTPROCESOCORREO;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FSBTTPROCESOCORREO', 'ADM_PERSON');
END;
/
