CREATE OR REPLACE PACKAGE ldc_oop_pruebas IS

		-- Author  : LUDYCOM BD
		-- Created : 25/05/2016 05:02:10 p.m.
		-- Purpose : Pruebas unitarias casos

		/*
    UNIDAD         : fsbASignaRP

    FECHA            AUTOR                    MODIFICACION
    =========      ========================   ==========================================
    12/02/2015     oparra.Aranda 5753         1.Creacion
    24/05/2016     Oscar Ospino P. (ludycom)  2.(GDC CA200-304)
                                              Se agrega una validaci?n para que las ordenes con
                                              tipos de trabajos 10446 que se encuentren en una
                                              solicitud con tipo de trabajo 100101 y provenga de
                                              una orden con tipo de trabajo 10723, se asigne a la
                                              misma unidad operativa de la ?ltima orden legalizada
                                              con tipo de trabajo 10444 y que se encuentra en una
                                              solicitud con tipo de trabajo 100237
    */
		FUNCTION fsbasignarp(sbin IN VARCHAR2) RETURN VARCHAR2;

		PROCEDURE ca200304;
END ldc_oop_pruebas;
/
CREATE OR REPLACE PACKAGE BODY ldc_oop_pruebas IS

		PROCEDURE ca200304 IS
				nuproducto     NUMBER;
				nuorder        NUMBER;
				nupackageid    NUMBER;
				nuactivityid   NUMBER;
				nutasktype     NUMBER;
				nutasktypedesc VARCHAR2(400);
				sbin           VARCHAR2(400);
				sbuo           VARCHAR2(400);
		BEGIN

				dbms_output.put_line('Pruebas Ludycom CASO 200-304 | BDD: BZ');
				dbms_output.put_line('');

				SELECT oa.product_id, oa.order_id, oa.task_type_id
				INTO   nuproducto, nuorder, nutasktype
				FROM   open.or_order_activity oa, open.or_order o
				WHERE  oa.order_id = o.order_id
				AND    oa.order_id = 12556466;

				dbms_output.put_line('Simulacion tramite 100101-Venta de serv. de ingenier?a.');
				dbms_output.put_line('');
				dbms_output.put_line('Producto: ' || nuproducto);

				SELECT tt.task_type_id || '-' || tt.description
				INTO   nutasktypedesc
				FROM   open.or_task_type tt
				WHERE  tt.task_type_id = nutasktype;

				dbms_output.put_line('Orden: ' || nuorder || ' | TT: ' || nutasktypedesc);
				dbms_output.put_line('');

				SELECT oa.order_id, oa.package_id, oa.order_activity_id, oa.subscription_id
				INTO   nuorder, nupackageid, nuactivityid, nuproducto
				FROM   open.or_order_activity oa
				WHERE  oa.order_id = 12556466;

				dbms_output.put_line('Se arma Parametro de entrada de la funcion');
				dbms_output.put_line('');
				dbms_output.put_line('nuorder ' || ' | nupackageid ' || ' | nuactivityid ' ||
														 ' | nuproducto ');

				sbin := nuorder || '|' || nupackageid || '|' || nuactivityid || '|' || nuproducto;
				dbms_output.put_line(sbin);
				dbms_output.put_line('');
				dbms_output.put_line('<<< Ejecutando funcion LDC_BOASIGAUTO.FSBASIGNARP >>>');
				sbuo := fsbasignarp(sbin);
		END ca200304;

		FUNCTION fsbasignarp(sbin IN VARCHAR2) RETURN VARCHAR2 IS

				--LA CADENA SBIN INGRESA CON LOSISGUIENTES DATOS
				--Y EN EL SIGUIENTE ORDEN
				--CODIGO DE LA ORDEN
				--CODIGO DE LA SOLICITUD
				--CODIGO DE LA ACTIVIDAD
				--CODIGO DEL CONTRATO

				sborder_id      VARCHAR2(4000) := NULL;
				sbpackage_id    VARCHAR2(4000) := NULL;
				sbactivity_id   VARCHAR2(4000) := NULL;
				subscription_id VARCHAR2(4000) := NULL;

				--CON ESTA ORDEN SE SABE EN EL CICLO QUE DATO VA
				--EN SECUENCIA PARA SABER CUAL DE LOS DATOS UTILIZAR
				----------------------------------------------------
				nutasktype      NUMBER;
				onuerrorcode    NUMBER;
				osberrormessage VARCHAR2(4000);

				--SEPARA LOS DATOS OBTENIDOS DE LA CADENA DE ENTRADA
				--CON EL SEPARADOR |
				CURSOR cudata IS
						SELECT column_value
						FROM   TABLE(ldc_boutilities.splitstrings(sbin, '|'));
				---FIN CURSOR DATA

				--CURSOR PARA OBTENER EL VALOR DE LA UNIDAD OPERTAIVA
				--DE LA ORDEN ASOCIADA A LA SOLICUTUD 100237 TT 10444

				CURSOR cuor_order_tt10444(inupackage_id mo_packages.package_id%TYPE) IS
				--modifica select para que devuelva todos los campos para mostrar la UO de la ultima orden 10444
				--procesada en solicitud 100237
						SELECT * --operating_unit_id
						FROM   (SELECT DISTINCT p.package_id        package_id,
																		o.operating_unit_id operating_unit_id,
																		o.order_id,
																		o.task_type_id
										FROM   open.mo_packages       p,
													 open.mo_motive         m,
													 open.or_order_activity oa,
													 open.or_order          o
										WHERE  m.package_id = p.package_id
										AND    oa.package_id = p.package_id
										AND    oa.order_id = o.order_id
										AND    p.package_type_id = 100237 -- Solic. visita identificacion certificado
										AND    o.task_type_id = 10444
										AND    o.order_status_id IN (5, 8) -- ASIGNADA O LEGALIZADA
													--AND OA.ACTIVITY_ID = 4295653       -- Act. Visita de identificacion de resultado
										AND    p.request_date <= damo_packages.fdtgetrequest_date(inupackage_id)
										AND    m.product_id = (SELECT DISTINCT m.product_id
																					 FROM   open.mo_packages p, open.mo_motive m
																					 WHERE  p.package_id = m.package_id
																					 AND    p.package_id = inupackage_id
																					 AND    rownum = 1)
										ORDER  BY p.package_id DESC) tb
						WHERE  rownum = 1;

				/*****************************************************************
        PROPIEDAD INTELECTUAL DE GASES DEL CARIBE (C).
        FECHA          AUTOR                      MODIFICACION
        24/05/2016     Oscar Ospino P. (ludycom)  1.(GDC CA200-304) Se agrega validacion para ordenes 10446
        */

				sbentrega VARCHAR2(100) := 'OSS_RP_OOP_200304_1';

				CURSOR cuotpadre(nuorderid or_order.order_id%TYPE) IS --Cargar el tipo de Orden Padre asociada
						SELECT oa.order_id ordenpadre, oa.task_type_id tipootpadre
						FROM   open.or_order_activity oa
						WHERE  oa.order_activity_id IN (SELECT DISTINCT oa.origin_activity_id
																						FROM   open.or_order_activity oa, open.or_order o
																						WHERE  oa.order_id = o.order_id
																						AND    oa.order_id = nuorderid);
				CURSOR cutiposol(nupackage_id open.mo_packages.package_id%TYPE) IS --Tipo de solicitud de la Orden
						SELECT mp.package_type_id tiposolicitud
						FROM   open.mo_packages mp
						WHERE  mp.package_id = nupackage_id;

				rccuotpadre cuotpadre%ROWTYPE;
				rccutiposol cutiposol%ROWTYPE;
				/*****************************************************************/

				tempcuor_order cuor_order_tt10444%ROWTYPE;

				nuoperating_unit_id or_order.operating_unit_id%TYPE;
				/* SBOPERATING_UNIT_ID VARCHAR2(4000);*/

				/* RCORDERTOASSIGN     Daor_Order.STYOR_ORDER;
        RCORDERTOASSIGNNULL Daor_Order.STYOR_ORDER;*/

				sbdatain    VARCHAR2(4000);
				sbtrigger   VARCHAR2(4000);
				sbcategoria VARCHAR2(4000);

		BEGIN

				ut_trace.trace('INICIO LDC_BOASIGAUTO.fsbAsignaRP', 10);

				--OBTENER DATOS DE LA CADENA OBTENIDA DEL SERVICIO DE ASIGNACION
				FOR tempcudata IN cudata
				LOOP

						ut_trace.trace(tempcudata.column_value, 10);

						IF sborder_id IS NULL THEN
								sborder_id      := tempcudata.column_value;
								osberrormessage := osberrormessage || ' - ' || sborder_id;
						ELSIF sbpackage_id IS NULL THEN
								sbpackage_id    := tempcudata.column_value;
								osberrormessage := osberrormessage || ' - ' || sbpackage_id;
						ELSIF sbactivity_id IS NULL THEN
								sbactivity_id   := tempcudata.column_value;
								osberrormessage := osberrormessage || ' - ' || sbactivity_id;
						ELSIF subscription_id IS NULL THEN
								subscription_id := tempcudata.column_value;
								osberrormessage := osberrormessage || ' - ' || subscription_id;
						ELSIF sbtrigger IS NULL THEN
								sbtrigger       := tempcudata.column_value;
								osberrormessage := osberrormessage || ' - ' || sbtrigger;
						ELSIF sbcategoria IS NULL THEN
								sbcategoria     := tempcudata.column_value;
								osberrormessage := osberrormessage || ' - ' || sbcategoria;
						END IF;

				END LOOP;

				-- Obtiene el TT de la orden
				IF sborder_id IS NOT NULL THEN
						nutasktype := daor_order.fnugettask_type_id(to_number(sborder_id));
				END IF;

				-- Se obtienen la UT segun el TT

				-- Si el TT de la orden 12161

				/*****************************************************************
        PROPIEDAD INTELECTUAL DE GASES DEL CARIBE (C).
        FECHA          AUTOR                      MODIFICACION
        24/05/2016     Oscar Ospino P. (ludycom)  1.(GDC CA200-304) Se agrega validacion para ordenes 10446
        */

				IF (nutasktype = 10446) THEN
						-- 10446-Visita Validaci?n de certificaci?n trabajos

						--OSS_RP_OOP_200304_1
						dbms_output.put_line('');
						dbms_output.put_line('Validacion tipo de Orden 10446 Correcta' || chr(13));

						ut_trace.trace('LDC_BOASIGAUTO.fsbAsignaRP | Inicio Validacion TT10446', 10);

						dbms_output.put_line('Validando si la entrega ' || sbentrega ||
																 ' aplica para la empresa actual...');

						--Validando si la entrega aplica para la empresa actual
						IF fblaplicaentrega('OSS_RP_OOP_200304_1') = TRUE THEN
								dbms_output.put_line('Entrega ' || sbentrega || ' si aplica' || chr(13));

								--obtengo el tipo de solicitud de la Orden actual
								OPEN cutiposol(to_number(sbpackage_id));
								FETCH cutiposol
										INTO rccutiposol;
								CLOSE cutiposol;

								dbms_output.put_line('Se obtiene el tipo de solicitud de la Orden ' || sborder_id );
								dbms_output.put_line(' Tipo Solicitud '|| rccutiposol.tiposolicitud || chr(13));

								--obtengo el TT de la Orden Padre
								OPEN cuotpadre(to_number(sborder_id));
								FETCH cuotpadre
										INTO rccuotpadre;
								CLOSE cuotpadre;

								dbms_output.put_line('Se obtiene el TT de la Orden Padre: ');
								dbms_output.put_line('OT Padre:' || rccuotpadre.ordenpadre || ' TT:' ||
																		 rccuotpadre.tipootpadre || chr(13));

								--Si la OT Padre es de tipo 10723, se asigna la UO de la ultima OT legalizada con TT 10444 en una solicitud 100237
								IF rccutiposol.tiposolicitud = 100101 AND rccuotpadre.tipootpadre = 10723 THEN

										dbms_output.put_line('Validacion correcta | tipo OT Padre 10723 ' ||
																				 chr(13));

										dbms_output.put_line('Se obtiene la ultima OT legalizada con TT 10444 en una solicitud 100237');

										-- Se carga la UO en TEMPCUOR_ORDER.OPERATING_UNIT_ID para que luego
										-- se asigne a NUOPERATING_UNIT_ID
										OPEN cuor_order_tt10444(to_number(sbpackage_id));
										FETCH cuor_order_tt10444
												INTO tempcuor_order;
										CLOSE cuor_order_tt10444;

										dbms_output.put_line('OT: ' || tempcuor_order.order_id || ' TT: ' ||
																				 tempcuor_order.task_type_id || ' Unidad Operativa: ' ||
																				 tempcuor_order.operating_unit_id   || chr(13)); -- || cuor_order_tt10444.
                else
                  dbms_output.put_line('El tipo de solicitud ' || sborder_id  ||' o el TT de la OT Padre ' ||  rccuotpadre.ordenpadre ||' no es valido para esta prueba.');

								END IF;
						END IF;
						ut_trace.trace('LDC_BOASIGAUTO.fsbAsignaRP | Fin Validacion TT10446', 10);

						/* Fin 1.(GDC CA200-304)******************************************/
				END IF;

				IF tempcuor_order.operating_unit_id IS NOT NULL THEN
						nuoperating_unit_id := tempcuor_order.operating_unit_id;
						-- inicio Asignar orden
						BEGIN

								dbms_output.put_line('Ejecutando proceso de asignacion | OS_ASSIGN_ORDER...');

								dbms_output.put_line('Asignando Unidad Operativa ' || nuoperating_unit_id ||
																		 ' a la Orden ' || sborder_id|| chr(13));
								os_assign_order(to_number(sborder_id)
															 ,nuoperating_unit_id
															 ,SYSDATE
															 ,SYSDATE
															 ,onuerrorcode
															 ,osberrormessage);

								IF onuerrorcode = 0 THEN
										/*ldc_boasigauto.prregsitroasigautolog(to_number(sbpackage_id)
																												,to_number(sborder_id)
																												,'LA ORDEN FUE ASIGNADA A LA UNIDAD OPERATIVA [' ||
																												 nuoperating_unit_id || ']');

										ldc_boasigauto.printentosasignacion(to_number(sbpackage_id)
																											 ,to_number(sborder_id));*/

										dbms_output.put_line('Registrando intentos de legalizacion...' || chr(13));

									/*	UPDATE ldc_order
										SET    asignado = 'S'
										WHERE  nvl(package_id, 0) = nvl(to_number(sbpackage_id), 0)
										AND    order_id = to_number(sborder_id);*/
										dbms_output.put_line('Registrando Orden en LDC_ORDER...' ||
																				 chr(13));

							/*	ELSE
										dbms_output.put_line(osberrormessage);
										ldc_boasigauto.prregsitroasigautolog(to_number(sbpackage_id)
																												,to_number(sborder_id)
																												,osberrormessage);
										ldc_boasigauto.printentosasignacion(to_number(sbpackage_id)
																											 ,to_number(sborder_id));*/

								END IF;
                --Fin Pruebas CA200-304
												dbms_output.put_line('Fin Pruebas Ludycom CASO 200-304');
						EXCEPTION
								WHEN OTHERS THEN
										sbdatain := 'INCONSISTENCIA EN SERVICIO FSBREVISIONPERIODICA [' ||
																dbms_utility.format_error_stack || '] - [' ||
																dbms_utility.format_error_backtrace || ']';
										dbms_output.put_line('EL SERVICIO os_assign_order NO PUDO ASIGNAR LA UNIDAD OPERATIVA A LA ORDEN [' ||
																				 sbdatain || ']');
						END;
						-- Fin Asignar orden

				ELSE
						-- sino obtuvo la UT
						dbms_output.put_line('NUOPERATING_UNIT_ID := ' || '-1');
				END IF;

				ut_trace.trace('FIN LDC_BOASIGAUTO.fsbAsignaRP', 10);

				RETURN(nuoperating_unit_id);

		END fsbasignarp;

END ldc_oop_pruebas;
/
GRANT EXECUTE on LDC_OOP_PRUEBAS to SYSTEM_OBJ_PRIVS_ROLE;
/
