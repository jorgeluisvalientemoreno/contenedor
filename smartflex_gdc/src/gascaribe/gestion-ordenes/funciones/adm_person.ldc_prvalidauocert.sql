CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_PRVALIDAUOCERT" (SBIN IN VARCHAR2) RETURN VARCHAR2 IS
/**************************************************************************
  Autor       : ESANTIAGO
  Fecha       : 2019-11-19
  caso        : 46
  Descripcion : procedimieto 'pre' de UOBYSOL,para Asiganar unidad operativa segun
				la configuracion de la tabla 'LDC_UNIOPECERT'

  Parametros Entrada
    nuano A?o
    numes Mes

  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION

***************************************************************************/

        SBORDER_ID      VARCHAR2(4000) := NULL;
        SBPACKAGE_ID    VARCHAR2(4000) := NULL;
        SBACTIVITY_ID   VARCHAR2(4000) := NULL;
        SUBSCRIPTION_ID VARCHAR2(4000) := NULL;
        NUORDER_DES     OR_ORDER.ORDER_ID%TYPE;
        VALORDER        NUMBER         := 0;
        --CON ESTA ORDEN SE SABE EN EL CICLO QUE DATO VA
        --EN SECUENCIA PARA SABER CUAL DE LOS DATOS UTILIZAR
        ----------------------------------------------------

        --SEPARA LOS DATOS OBTENIDOS DE LA CADENA DE ENTRADA
        --CON EL SEPARADOR |
        CURSOR CUDATA IS
            SELECT COLUMN_VALUE
			FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(SBIN, '|'));
        ---FIN CURSOR DATA

        ONUERRORCODE    NUMBER;
        OSBERRORMESSAGE VARCHAR2(4000);

        NUOPERATING_UNIT_ID OR_ORDER.OPERATING_UNIT_ID%TYPE;

        RCORDERTOASSIGN     DAOR_ORDER.STYOR_ORDER;
        RCORDERTOASSIGNNULL DAOR_ORDER.STYOR_ORDER;



        --CUROSR PARA OBTENER LA UNIDAD OPERATIVA CONVEINETE
        --PARA ESA ORDEN DE PUNTO FIJO
		CURSOR CUUNIDADOPERATIVA(NUTTOR    OR_ORDER.ORDER_ID%TYPE,
                                 NUTTDES   OR_ORDER.ORDER_ID%TYPE) IS
            select  UO_DESTINO  OPERATING_UNIT_ID
			from LDC_UNIOPECERT
			where TT_ORIGEN= DAOR_ORDER.FnugetTASK_TYPE_ID(NUTTOR)
			and TT_DESTINO= DAOR_ORDER.FnugetTASK_TYPE_ID(NUTTDES)
            and UO_ORIGEN=DAOR_ORDER.FNUGETOPERATING_UNIT_ID(NUTTOR);


	    CURSOR CUORCXC(NUPACKAGE_ID MO_PACKAGES.PACKAGE_ID%TYPE,
                                 NUORDER_ID   OR_ORDER.ORDER_ID%TYPE) IS
            SELECT O.ORDER_ID,
                   O.OPERATING_UNIT_ID,
                   OA1.ORDER_ACTIVITY_ID,
                   o.TASK_TYPE_ID
            FROM   OPEN.OR_ORDER          O,
                   OPEN.OR_ORDER_ACTIVITY OA1,
                   OPEN.MO_PACKAGES       P,
                   OPEN.MO_MOTIVE         M
		    WHERE  O.ORDER_ID = OA1.ORDER_ID
            AND    OA1.PACKAGE_ID = NUPACKAGE_ID--10642921
            AND    OA1.PACKAGE_ID = P.PACKAGE_ID
            AND    P.PACKAGE_ID = M.PACKAGE_ID
			AND    OA1.ADDRESS_ID = (select a.ADDRESS_ID from or_order_activity a where a.ORDER_ID= NUORDER_ID )
			AND    O.ORDER_STATUS_ID = 5
            AND    O.TASK_TYPE_ID IN
                   (SELECT TO_NUMBER(column_value)
                     FROM   TABLE(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('LDC_TT_CXC',NULL),',')));


        TEMPCUUNIDADOPERATIVA CUUNIDADOPERATIVA%ROWTYPE;


        CURSOR CUEXISTE(NUDATO      NUMBER,
                        SBPARAMETRO LD_PARAMETER.VALUE_CHAIN%TYPE) IS
            SELECT COUNT(1) cantidad
            FROM   DUAL
            WHERE  NUDATO IN
                   (SELECT to_number(column_value)
                    FROM   TABLE(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain(SBPARAMETRO,NULL),',')));

        nucantidad NUMBER;
        NUCAUSAL   NUMBER;





    BEGIN
		IF  fblaplicaentregaxcaso('0000046') THEN

			UT_TRACE.TRACE('INICIO LDC_PRVALIDAUOCERT', 10);

			FOR TEMPCUDATA IN CUDATA LOOP

				UT_TRACE.TRACE(TEMPCUDATA.COLUMN_VALUE, 10);

				IF SBORDER_ID IS NULL THEN
					SBORDER_ID      := TEMPCUDATA.COLUMN_VALUE;
					OSBERRORMESSAGE := '[ORDEN - ' || SBORDER_ID || ']';
				ELSIF SBPACKAGE_ID IS NULL THEN
					SBPACKAGE_ID    := TEMPCUDATA.COLUMN_VALUE;
					OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [SOLICITUD - ' || SBPACKAGE_ID || ']';
				ELSIF SBACTIVITY_ID IS NULL THEN
					SBACTIVITY_ID   := TEMPCUDATA.COLUMN_VALUE;
					OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [ACTIVIDAD - ' || SBACTIVITY_ID || ']';
				ELSIF SUBSCRIPTION_ID IS NULL THEN
					SUBSCRIPTION_ID := TEMPCUDATA.COLUMN_VALUE;
					OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [CONTRATO - ' || SUBSCRIPTION_ID || ']';
				END IF;

			END LOOP;
			NUORDER_DES:=TO_NUMBER(SBORDER_ID);

			OPEN CUEXISTE(daor_order.fnugetTASK_TYPE_ID(NUORDER_DES),'LDC_TT_CERT');
			FETCH CUEXISTE INTO VALORDER;
			CLOSE CUEXISTE;

		   IF(VALORDER = 1)THEN

				NUOPERATING_UNIT_ID := NULL;

				FOR regOrdenes in CUORCXC(TO_NUMBER(SBPACKAGE_ID), TO_NUMBER(SBORDER_ID))
				LOOP


					OPEN CUUNIDADOPERATIVA(regOrdenes.ORDER_ID,
										   TO_NUMBER(SBORDER_ID));
					FETCH CUUNIDADOPERATIVA
					INTO TEMPCUUNIDADOPERATIVA;


					IF CUUNIDADOPERATIVA%FOUND THEN
							NUOPERATING_UNIT_ID := TEMPCUUNIDADOPERATIVA.OPERATING_UNIT_ID;


						IF NVL(NUOPERATING_UNIT_ID, -1) <> -1 THEN


							BEGIN

								api_assign_order(NUORDER_DES,
												NUOPERATING_UNIT_ID,
												onuerrorcode,
												osberrormessage);

								IF onuerrorcode = 0 THEN

									UPDATE LDC_ORDER
									SET    ASIGNADO = 'S'
									WHERE  NVL(PACKAGE_ID, 0) = NVL(TO_NUMBER(SBPACKAGE_ID), 0)
									AND    ORDER_ID = regOrdenes.ORDER_ID;


								ELSE
									LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
																		 NUORDER_DES,
																		 'LA UNIDAD OPERATIVA NO FUE ASIGNADA A LA UNIDAD OPERATIVA [' ||
																		 NUOPERATING_UNIT_ID ||
																		 '] - MENSAJE DE ERROR PROVENIENTE DE api_assign_order --> ' ||
																		 osberrormessage);


								END IF;

							EXCEPTION
								WHEN OTHERS THEN
									osberrormessage := 'INCONSISTENCIA  [' ||
													   DBMS_UTILITY.FORMAT_ERROR_STACK || '] - [' ||
													   DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';


							END;

						END IF; --VALIDAR UNIDAD OPERATIVA DIFERENTE A -1
					ELSE
						--NUOPERATING_UNIT_ID := NULL;
						NUOPERATING_UNIT_ID := -1;


					END IF;
					CLOSE CUUNIDADOPERATIVA;


				END LOOP;

		    END IF;

		END IF;

        UT_TRACE.TRACE('FIN LDC_PRVALIDAUOCERT', 10);

        RETURN(NUOPERATING_UNIT_ID);

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            --ROLLBACK;
            ONUERRORCODE    := PKG_ERROR.CNUGENERIC_MESSAGE;
            OSBERRORMESSAGE := 'INCONVENIENTES AL ASIGNAR LA UNIDAD OPERTAIVA ' ||
                               PKERRORS.FSBGETERRORMESSAGE;
            OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [' || DBMS_UTILITY.FORMAT_ERROR_STACK ||
                               ' - [' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                 NUORDER_DES,
                                                 OSBERRORMESSAGE);

            RETURN(-1);

        WHEN OTHERS THEN
            --ROLLBACK;
            ONUERRORCODE    := PKG_ERROR.CNUGENERIC_MESSAGE;
            OSBERRORMESSAGE := 'INCONVENIENTES AL ASIGNAR LA UNIDAD OPERTAIVA ' ||
                               PKERRORS.FSBGETERRORMESSAGE;
            OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [' || DBMS_UTILITY.FORMAT_ERROR_STACK ||
                               ' - [' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                 NUORDER_DES,
                                                 OSBERRORMESSAGE);

            RETURN(-1);

END LDC_PRVALIDAUOCERT;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRVALIDAUOCERT', 'ADM_PERSON');
END;
/
