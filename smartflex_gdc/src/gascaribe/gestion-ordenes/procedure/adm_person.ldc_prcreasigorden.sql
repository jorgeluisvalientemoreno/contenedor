CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_PRCREASIGORDEN (nuProducto   PR_PRODUCT.PRODUCT_ID%TYPE,
												 nuActividad  GE_ACTIVITY.ACTIVITY_ID%TYPE,
												 nuOperaUnit  OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE)
IS

      /*******************************************************************************
     Metodo:       LDC_PRCREASIGORDEN
     Descripcion:  Procedimiento que se encarga de crear y asignar una orden a un producto
				   validando que este producto sea de tipo (7014 - gas), que este suspendido y
				   que tenga una edad de deuda no mayor a 90 dias
     Autor:        Olsoftware/Miguel Ballesteros
     Fecha:        24/01/2020

     Entrada           Descripcion
     nuProducto:      Codigo del producto

     Historia de Modificaciones
     FECHA        AUTOR                       DESCRIPCION
    *******************************************************************************/
    nuCaso 		   		varchar2(30):='0000159';
	nuValidaProduct		pr_product.product_id%type;
	nuEstadoProduct		pr_product.product_status_id%type;
	nuTypeProduct		pr_product.product_type_id%type;
	nuValDiasMora      	number := 0;
	nuContrato     		number(15);--Contrato del producto
	nuSuscriptor   		number(15);--Cliente asciado al producto
	nuDireccion    		number(15);--Direccion donde se creara la orden
	sbComentario   		varchar(2000):= OPEN.DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_PRCOMENTCASO159',NULL);--Comentario de la actividad de la orden a crear
	nuSectorO      		Number(15);--Sector operativo
	nuErrorCode    		number(18);--Codigo de error
	sbErrorMessage 		Varchar2(2000);--Mensaje del error
    sbOrden        		Varchar2(100);--Orden generada
	nuOrdenge      		number;--Orden generada
	XmlDatos       		clob;--Datos para generar orden
	XmlOrden       		clob;--Datos orden creada
	nuSecuencia    		number;--Numero de la secuencia
    nuTaskTypeId   		number := 0;
    nuValAct       		varchar2(10);
	sbmensaje	   		varchar2(10000);
	nuValOrderPro		number;

	-- cursor que valida que la edad de mora sea menor a 90 dias para el producto
	CURSOR GETINFOPRODUCT IS
         select 1
			from open.ldc_cartdiaria c,
				 open.pr_product pr
			where  pr.product_id  = nuProducto
			and    c.producto = pr.product_id
			and    c.edad_mora <= dald_parameter.fnugetnumeric_value('LDC_PRDIASEDADMORA', NULL)
			and    pr.product_type_id IN (select To_Number(column_value)
										from table(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('LDC_PRTIPOPRODUCTO', NULL), ',')))
			and    pr.PRODUCT_STATUS_ID = dald_parameter.fnugetnumeric_value('ID_PRODUCT_STATUS_SUSP', NULL);

	-- cursor que se encarga de obtener la orden del XML generado al crear la orden
	Cursor cuGetOrder(xmlOrden clob) is
		select dbms_xmlgen.convert(xmltype(xmlOrden).extract('/ORDERS/ORDER/ORDER_ID/text()' ).getstringval(), 1)as "ORDEN_ID" from dual;

    -- cursor que busca el tipo de trabajo de la actividad
    Cursor cuValidActividad is
        select oti.task_type_id
            from open.ge_items g,
                 open.or_task_types_items oti,
                 or_task_type ot
            where oti.items_id = g.items_id
            and  ot.task_type_id = oti.task_type_id
            and  ot.Task_Type_Classif = 0
            and g.items_id = nuActividad
            and item_classif_id = 2;

    -- cursor que busca si el tipo de trabajo de la actividad esta dentro de los parametros configurados
    Cursor CuValidaTT (nuTask_Type  or_task_type.task_type_id%type)is
        SELECT 'X' FROM DUAL
        WHERE nuTask_Type IN (SELECT to_number(COLUMN_VALUE)
                             FROM TABLE(ldc_boutilities.splitstrings(OPEN.DALD_PARAMETER.fsbGetValue_Chain('LDC_PRTIPOTRANAJOUSADO',NULL),',')));

	-- cursor para validar si el producto tiene una orden ya asignada de ese mismo TT
	Cursor cuValOrdeProduct(nuTaskType		or_task_type.task_type_id%type)is
		select count(1)
			from open.or_order oo,
				 open.or_order_activity oa
			where oa.order_id = oo.order_id
			and   oa.product_id = nuProducto
			and   oo.task_type_id = nuTaskType
			and   oo.order_status_id = 5;


BEGIN

   IF fblAplicaEntregaxCaso(nuCaso)THEN

	   ut_trace.trace('Inicia LDC_PRCREASIGORDEN', 10);

	    nuValidaProduct := open.dapr_product.fnugetproduct_id(nuProducto , null);

		if(nuValidaProduct is null)then
			XLOGPNO_EHG('El producto no existe');
		else

			nuEstadoProduct := open.dapr_product.fnugetproduct_status_id(nuProducto , null);

			if(nuEstadoProduct is null or nuEstadoProduct != 2)then
				XLOGPNO_EHG('El estado del producto no existe o es diferente al estado suspendido (2)');
			else

				nuTypeProduct := open.dapr_product.fnugetproduct_type_id(nuProducto , null);

				if(nuTypeProduct is null or nuTypeProduct != 7014)then
					XLOGPNO_EHG('El tipo de producto no existe o es diferente al tipo de producto de gas (7014)');
				else

					if (GETINFOPRODUCT%isopen) then
					   Close GETINFOPRODUCT;
					end if;

					OPEN GETINFOPRODUCT;
					FETCH GETINFOPRODUCT INTO nuValDiasMora;
					CLOSE GETINFOPRODUCT;

					if nuValDiasMora > 0 then

						-- se obtiene el cliente asociado al producto
						nuSuscriptor := PR_BCPRODUCT.FNUGETSUBSCRIBERID(nuProducto);

						if nuSuscriptor is null then
							XLOGPNO_EHG('El producto no tiene un cliente asociado');
						else
							-- se obtiene el contrato del producto
							nuContrato := PR_BOPRODUCT.GETSUBSCRIPTIONID(nuProducto);
							if(nuContrato is null)then
								XLOGPNO_EHG('El producto no tiene un contrato');
							else

								-- se obtiene la direccion del producto
								nuDireccion := PR_BOPRODUCT.FNUADDRESSIDBYPROD (nuProducto);
								if(nuDireccion is null)then
									XLOGPNO_EHG('El producto no tiene una direccion');
								else

									-- se obtiene el sector operativo del producto
									nuSectorO := OR_BOFW_PROCESS.FNUGETSECTORBYADDRESS(nuDireccion);
									if(nuSectorO is null)then
										XLOGPNO_EHG('La direccion del producto no tiene un sector operativo');
									else

										-- se valida la actividad
										if (cuValidActividad%isopen) then
											Close cuValidActividad;
										end if;

										-- se inicia el cursor que se encarga de obtener el tipo de trabajo de la actividad ingresada
										OPEN cuValidActividad;
										FETCH cuValidActividad INTO nuTaskTypeId;
										CLOSE cuValidActividad;

										if(nuTaskTypeId = 0)then
											XLOGPNO_EHG('No se encontro tipo de trabajo para la acitividad');
										else

											-- se valida el tipo de trabajo
											if (CuValidaTT%isopen) then
												Close CuValidaTT;
											end if;

											-- se valida que el tipo de trabajo de la actividad este dentro del parametro LDC_PRTIPOTRANAJOUSADO para verificar que se creee la orden con ese TT
											OPEN CuValidaTT(nuTaskTypeId);
											FETCH CuValidaTT INTO nuValAct;
											CLOSE CuValidaTT;

											if(nuValAct != 'X')then
												XLOGPNO_EHG('No se encontro el tipo de trabajo en el parametro LDC_PRTIPOTRANAJOUSADO');
											else

												-- se valida que para ese producto no exista una orden en estado asignada y con el mismo tipo de trabajo
												if(cuValOrdeProduct%isopen)then
													close cuValOrdeProduct;
												end if;

												open cuValOrdeProduct(nuTaskTypeId);
												fetch cuValOrdeProduct into nuValOrderPro;
												close cuValOrdeProduct;

												-- si el valor es igual a 0 quiere decir que no encontro una orden con esas especificaciones para ese producto
												if(nuValOrderPro = 0)then

													-- se crea xml para enviar la informacion necesaria para la creacion de la orden
													XmlDatos :='<?xml version="1.0" encoding="utf-8" ?>
																<order>
																 <data>
																   <subscriber_id>'||nususcriptor||'</subscriber_id>
																   <SUBSCRIPTION_ID>'||nucontrato||'</SUBSCRIPTION_ID>
																   <PRODUCT_ID>'||nuproducto||'</PRODUCT_ID>
																   <ADDRESS_ID>'||nuDireccion||'</ADDRESS_ID>
																 </data>
																 <activities>
																   <activity>
																	 <ACTIVITY_ID>'||nuactividad||'</ACTIVITY_ID>
																	 <oper_sector_id>'||nusectoro||'</oper_sector_id>
																	 <COMMENT>'||sbcomentario||'</COMMENT>
																	 <sequence>1</sequence>
																   </activity>
																 </activities>
																</order>';

													-- se llama al proceso que se encarga de crear la orden
													OS_GENERATEAUTORDER (XmlDatos, XmlOrden, nuErrorCode, sbErrorMessage);

													if(nuErrorCode != 0)then
														GE_BOERRORS.SETERRORCODEARGUMENT(nuErrorCode,sbErrorMessage);
														XLOGPNO_EHG('Error al crear la orden -- ['||nuErrorCode||' - '||sbErrorMessage||' ]');
													else

														--Se obtiene el numero de la orden creada
														if (cuGetOrder%isopen) then
														   Close cuGetOrder;
														end if;

														open cuGetOrder(XmlOrden);
														fetch cuGetOrder into sbOrden ;
														close cuGetOrder;

														if(sbOrden = 0)then
															XLOGPNO_EHG('No se creo la orden error en el XmlDatos del procedimiento LDC_PRCREASIGORDEN');
														else

															-- se creo la orden de forma correcta
															nuOrdenge := to_number(sbOrden) ;

															XLOGPNO_EHG('SE CREO LA ORDEN DE FORMA CORRECTA: -- '||nuOrdenge);

															--Se asigna la orden de trabajo
															OS_ASSIGN_ORDER (nuOrdenge, nuOperaUnit, SYSDATE, SYSDATE, nuErrorCode, sbErrorMessage);

															if(nuErrorCode != 0)then
																XLOGPNO_EHG('Error al asignar la orden -- ['||nuErrorCode||' - '||sbErrorMessage||' ]');
															else

																XLOGPNO_EHG('SE CREO Y SE ASIGNO LA ORDEN DE FORMA CORRECTA ');
																COMMIT;

															end if;

														end if;

													end if;

												else
													XLOGPNO_EHG('El producto ya cuenta con una orden creada y asignada, no se puede crear una orden hasta que se legalice esta');
												end if;

											end if;

										end if;

									end if;

								end if;

							end if;

						end if;

					else
						XLOGPNO_EHG('El producto no cuenta con una edad de mora menor o igual a 90 dias');
					end if;

				end if;

			end if;

		end if;

		ut_trace.trace('Finaliza LDC_PRCREASIGORDEN', 10);

    END IF;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRCREASIGORDEN', 'ADM_PERSON');
END;
/
