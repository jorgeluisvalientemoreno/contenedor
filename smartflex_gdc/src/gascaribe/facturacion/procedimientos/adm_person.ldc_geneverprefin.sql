CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_GENEVERPREFIN AS
    /**************************************************************************
    Propiedad Intelectual de HORBATH TECHNOLOGIES

    Funcion     :  LDC_GENEVERPREFIN
    Descripcion :  Procedimiento que crea la orden de VERIFICACIÃ¿N DE PRESIÃ¿N FINAL
                    si al legalizar una orden con causal clase 1-Exito y si el producto correspondiente
                    a la orden del tipo de trabajo antes mencionado, pertenecen a las categorÃ­as
                    [3-INDUSTRIAL Â¿ REGULADO] con todas las subcategorÃ­as o a la categorÃ­a [2-COMERCIAL]
                    con subcategorÃ­a [2-COMERCIAL CON FACTOR FIJO].
                    O si el producto  pertenece a la categorÃ­a  y subcategorÃ­a pametrizados
                    en la orden se validara si se estÃ¡n legalizando los Ã­tems pametrizados
    Autor       : Josh Brito
    Fecha       : 20-06-2017

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    20-06-2017          Josh Brito         CreaciÃ³n
    08/10/2018          Dsaltarin          200-2216 Se modifica para eliminar el commit y validar si la orden
                                           se genero o no para relacionarla
	  03/09/2019		    dsaltarin          GLPI-97 se modifica para tomar la direccion de la orden y no del cliente.
	  20/04/2020		    Horbath         Se modifica el procedimiento para optimizar las validaciones de creacion de la orde de verificacion de precio
											y agregar la validacion de los tipos de trabajo configurado en el parmetro TIPOS_TRABAJOS_PRESION y los items en el pametro ITEMS_PRESION. Caso 318
    **************************************************************************/

    nuOrderId           OR_ORDER.ORDER_ID%type;
    nuCausalId          or_order.causal_id%type;
    nuClassCausalId     GE_CAUSAL.CLASS_CAUSAL_ID%type;
    nuOrderActivityId   OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%type;
    nuProductId         PR_PRODUCT.PRODUCT_ID%type;
    nuCategoryId        CATEGORI.CATECODI%type;
    nuSubcategory       SUBCATEG.SUCACODI%TYPE;
    suDireccion         GE_SUBSCRIBER.ADDRESS_ID%type;
    varCategSubcateg    varchar2(50);
    varCategAllSubcateg varchar2(50);
    varCategDif         varchar2(50);
    varCategDifSubcateg varchar2(50);
    nuCantItemId        number;
	nuContrato   		OR_ORDER_ACTIVITY.SUBSCRIPTION_ID%type;-- caso:318

    nuparano       NUMBER(4);
    nuparmes       NUMBER(2);
    nutsess        NUMBER;
    sbparuser      VARCHAR2(30);
    osbErrorMessage       VARCHAR2(4000);
    onuErrorCode          NUMBER;
    ionuorderid or_order.order_id%TYPE;
    sbmensamen     VARCHAR2(4000);
	nuCreaOrd        number;-- caso:318
	nuValtt        number;-- caso:318
	nuValitem        number;-- caso:318

    cursor cuItems (coditems varchar2) is
    select count(1)
    from OR_ORDER_ITEMS
    where ORDER_ACTIVITY_ID = nuOrderActivityId
    and items_id in (SELECT to_char(column_value) AS item
    FROM TABLE(open.ldc_boutilities.splitstrings(coditems,',')))
    and LEGAL_ITEM_AMOUNT > 0;

	  --98
	  nuActividadGenerar open.ld_parameter.numeric_value%type:= DALD_PARAMETER.fnuGetNumeric_Value('LDC_PARVERPREFIN');
	  sbValidaOtPresion	 open.ld_parameter.value_chain%type:= DALD_PARAMETER.fsbGetValue_chain('VALIDA_EXISTE_OTPRESION');
	  nuExiste 			 number;
	  cursor cuValidaOtPresion(nuProducto open.pr_product.product_id%type) is
	  select count(1)
	    from open.or_order o
		inner join open.or_order_activity a on a.order_id=o.order_id and a.activity_id=nuActividadGenerar
		inner join open.or_order_status s on s.order_status_id=o.order_status_id and s.is_final_status='N'
		where a.product_id=nuProducto;


	--inicio caso:318
	cursor cuValtt (NUORDER NUMBER) is
	select 1 from or_order where order_id=NUORDER
	and task_type_id in (SELECT to_number(COLUMN_VALUE)
                     FROM TABLE(ldc_boutilities.splitstrings(OPEN.DALD_PARAMETER.fsbGetValue_Chain('TIPOS_TRABAJOS_PRESION',NULL),',')));

	cursor cuVaitem (NUORDER NUMBER) is
	select count(*) from or_order_items where order_id=NUORDER
	and items_id in (SELECT to_number(COLUMN_VALUE)
                     FROM TABLE(ldc_boutilities.splitstrings(OPEN.DALD_PARAMETER.fsbGetValue_Chain('ITEMS_PRESION',NULL),',')));


	--fin 	caso:318

BEGIN

    nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;
    ut_trace.trace('LDC_GENEVERPREFIN-nuOrderId -->'||nuOrderId, 10);

    nuCausalId := daor_order.fnugetcausal_id(nuOrderId);
    ut_trace.trace('LDC_GENEVERPREFIN-nuCausalId -->'||nuCausalId, 10);

    nuClassCausalId := dage_causal.fnugetclass_causal_id(nuCausalId);
    ut_trace.trace('LDC_GENEVERPREFIN-nuClassCausalId -->'||nuClassCausalId, 10);

    nuOrderActivityId := ldc_bcfinanceot.fnuGetActivityId(nuOrderId);
    ut_trace.trace('LDC_GENEVERPREFIN-nuOrderActivityId -->'||nuOrderActivityId, 10);

    nuProductId := daor_order_activity.fnugetproduct_id(nuOrderActivityId);
    ut_trace.trace('LDC_GENEVERPREFIN-nuProductId -->'||nuProductId, 10);

    nuCategoryId  := pktblservsusc.fnugetcategory(nuProductId);
    ut_trace.trace('LDC_GENEVERPREFIN-nuCategoryId -->'||nuCategoryId, 10);

    nuSubcategory := pktblservsusc.fnugetsubcategory(nuProductId);
    ut_trace.trace('LDC_GENEVERPREFIN-nuSubcategory -->'||nuSubcategory, 10);

	nuContrato := daor_order_activity.fnugetsubscription_id(nuOrderActivityId);--caso:318
    ut_trace.trace('LDC_GENEVERPREFIN-nuContrato -->'||nuContrato, 10);--caso:318

    varCategSubcateg := to_char(nuCategoryId||'|'||nuSubcategory);
    varCategAllSubcateg := to_char(nuCategoryId||'|-1');
    varCategDif := to_char(nuCategoryId||'!');
    varCategDifSubcateg := to_char(nuCategoryId||'!'||nuSubcategory);



    SELECT to_number(to_char(SYSDATE,'YYYY'))
       ,to_number(to_char(SYSDATE,'MM'))
       ,userenv('SESSIONID')
       ,USER INTO nuparano,nuparmes,nutsess,sbparuser
    FROM dual;
    ut_trace.trace('LDC_GENEVERPREFIN - En ejecucion -->'||nuSubcategory, 10);

    /*se valida si la cusal es de clase exito*/
    if nuClassCausalId = 1 then

		if sbValidaOtPresion ='S' then
			open cuValidaOtPresion(nuProductId);
			fetch cuValidaOtPresion into nuExiste;
			close cuValidaOtPresion;

			if nuExiste > 0 then
				ut_trace.trace('El producto '||nuProductId||' tiene ordenes de actividad '||nuActividadGenerar||' en proceso.', 10);
				return;
			end if;
		end if;

        SELECT oa.address_id into suDireccion
        FROM or_order_activity oa--, ge_subscriber cl
        WHERE oa.ORDER_ACTIVITY_ID = nuOrderActivityId
        --AND oa.subscriber_id   = cl.subscriber_id
		;

		--inicio caso:318
		if fblaplicaentregaxcaso('0000318') then

			OPEN cuValtt(nuOrderId);
			FETCH cuValtt INTO nuValtt;
			CLOSE cuValtt;

			OPEN cuVaitem(nuOrderId);
			FETCH cuVaitem INTO nuValitem;
			CLOSE cuVaitem;

		else

			nuValtt:=0;
			nuValitem:=0;

		end if;

		--fin caso:318

        onuErrorCode   := NULL;
        osbErrorMessage := NULL;
        ionuorderid := NULL;

        if nuValtt = 1 and nuValitem >= 1 then -- caso:318

			nuCreaOrd := 1;-- caso:318

		else

			/*se valida si la categoria y subcategoria del producto se encuantra en el parametro LDC_PPRODCATECONSUBCATE*/
			if instr(DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_PPRODCATECONSUBCATE'), varCategSubcateg) > 0
			or instr(DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_PPRODCATECONSUBCATE'), varCategAllSubcateg) > 0 THEN

				nuCreaOrd := 1;-- caso:318

			else
				/*1. se valida si las categoria y subcategoria del producto se encuentra en el parametro LDC_PPRODCATESINSUBCATE
				2. si exiten uno a mas items legalizados de los cuales contiene el parametro LDC_PCUMPLEITEMLEGA este procedera a legalizar la Orden*/
				--200-2216 if instr(DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_PPRODCATESINSUBCATE'), varCategSubcateg) > 0
				if instr(DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_PPRODCATESINSUBCATE'), varCategDif) > 0 THEN

					if instr(DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_PPRODCATESINSUBCATE'), varCategDifSubcateg) > 0 then
						sbmensamen := 'La Categorias y subcategoria de del producto:['||nuProductId||'] correspondiente a la orden:['||nuOrderId||'], no estan parametrizadas';
						ut_trace.trace('LDC_GENEVERPREFIN-->'||sbmensamen, 10);
					else
						open cuItems(DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_PCUMPLEITEMLEGA'));
							fetch cuItems into nuCantItemId;
							IF cuItems%NOTFOUND THEN
								raise ex.CONTROLLED_ERROR;
							END IF;
						close cuItems;

						if nuCantItemId > 0 then

							nuCreaOrd := 1;-- caso:318


						end if;--nuCantItemId > 0
					end if;-- instr(DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_PPRODCATESINSUBCATE'), varCategDifSubcateg) > 0

				end if;--instr(DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_PPRODCATESINSUBCATE'), varCategDifSubcateg) > 0
			end if; --instr(DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_PPRODCATECONSUBCATE'), varCategSubcateg) > 0

		end if;--nuValtt = 1 and nuValitem=1


		--inicio caso:318
		if nuCreaOrd = 1 then

			os_createorderactivities(
				  to_number(DALD_PARAMETER.fnuGetNumeric_Value('LDC_PARVERPREFIN'))
				  ,suDireccion
				  ,SYSDATE
				  ,'PROCESO [LDC_GENEVERPREFIN]. Se legaliza ot : '||to_char(nuOrderId)||' se genera ot con actividad '||DALD_PARAMETER.fnuGetNumeric_Value('LDC_PARVERPREFIN')
				  ,0
				  ,ionuorderid
				  ,onuErrorCode
				  ,osbErrorMessage
			);
			---------------------------------------------------------

			--ACTUALIZA DATOS DE OR_ORDER_ACTIVITY
			IF nvl(onuErrorCode,0) = 0 THEN
			   IF NVL(ionuorderid, 0)!=0 THEN --200-2216
				  UPDATE or_order_activity oat
				  SET oat.PRODUCT_ID = nuProductId,
					  oat.SUBSCRIPTION_ID = nuContrato -- caso:318
				  WHERE oat.order_id = ionuorderid;
				  --commit; 200-2216

				  sbmensamen := 'ORDEN GENERADA --> ' || ionuorderid;
				  UT_TRACE.TRACE(sbmensamen, 10);
				  --200-2216
				  OS_RELATED_ORDER(nuOrderId,
									ionuorderid,
									onuErrorCode,
									osbErrorMessage);

				  IF onuErrorCode <> 0 THEN
						sbmensamen := 'Error al relacionar la orden [' ||
									   ionuorderid || '] a la orden original [' ||
									   nuOrderId || '] ' || onuErrorCode || ' - ' ||
									   osbErrorMessage;
						ut_trace.trace(sbmensamen, 10);
						ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
												 sbmensamen);
						raise ex.CONTROLLED_ERROR;

				  END IF;
			   END IF;
			ELSE
				sbmensamen := 'Error al generar la orden de verificaci'||CHR(243)||'n de presi'||CHR(243)||'n' ||
									 onuErrorCode || ' - ' ||
							   osbErrorMessage;
				ut_trace.trace(sbmensamen, 10);
				ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
										 sbmensamen);
				raise ex.CONTROLLED_ERROR;

				--200-2216
			END IF;

			---------------------------------------------------------

		end if;--nuCreaOrd=1
		--fin caso:318




        --INICIO RELACIONAR ORDEN ORIGEN CON LA ORDEN ADICIONAL

        --FIN RELACIONAR ORDEN ORIGEN CON LA ORDEN ADICIONAL


        ut_trace.trace('FINALIZA - LDC_GENEVERPREFIN', 10);

    end if;



EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;

END LDC_GENEVERPREFIN;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_GENEVERPREFIN', 'ADM_PERSON');
END;
/

