CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNUULOTPRODUCTO" (inuProduct pr_product.PRODUCT_ID%TYPE)
  RETURN number IS
  /*****************************************************************
  Propiedad intelectual de Gases del Caribe.
  Nombre del Servicio: LDC_FNUULOTPRODUCTO
  Descripcion: para obtener la unidad operativa de la ultima orden 10444 o 10795 relacionada al producto

    Autor    : HORBATH
	caso	 :213
    Fecha    : 3/07/2020

    Historia de Modificaciones

   DD-MM-YYYY    <Autor>.              Modificacion
   -----------  -------------------    -------------------------------------

    ******************************************************************/
  crUnitOper PKCONSTANTE.TYREFCURSOR;
  nuTipo10444 number;
  nuTipo10795 number;
  valcau number;
  RETORD OR_ORDER.OPERATING_UNIT_ID%TYPE;
  PRAGMA AUTONOMOUS_TRANSACTION;

  cursor CUMARCA (NUPRODUCTI_ID NUMBER) is
        SELECT    *
          FROM OPEN.PR_PRODUCT p
         where p.PRODUCT_TYPE_ID=7014
           AND P.PRODUCT_ID=NUPRODUCTI_ID ;

	cursor CUUOPRODUCTO(NUPRODUCTI_ID NUMBER) is
			SELECT *
			FROM  (SELECT O.ORDER_ID, O.OPERATING_UNIT_ID, O.LEGALIZATION_DATE, O.TASK_TYPE_ID, O.CAUSAL_ID
               FROM OPEN.OR_ORDER O, OPEN.OR_ORDER_ACTIVITY OA , OPEN.GE_CAUSAL C
							WHERE O.ORDER_ID = OA.ORDER_ID
							AND O.TASK_TYPE_ID IN (select to_number(column_value)
													from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('COD_ULT_OT_LEG_RP',
													NULL),     ',')))
							AND OA.PRODUCT_ID=NUPRODUCTI_ID
              AND O.ORDER_STATUS_ID=8
              AND NOT EXISTS(SELECT NULL FROM OPEN.CT_ITEM_NOVELTY N WHERE N.ITEMS_ID=OA.ACTIVITY_ID)
              AND O.CAUSAL_ID=C.CAUSAL_ID
              AND C.CLASS_CAUSAL_ID=1
							ORDER BY O.LEGALIZATION_DATE DESC )
			WHERE ROWNUM=1;

	cursor CUEXISTE(NUCAUSAL_ID NUMBER, PARAMETRO varchar2) is
			select 1--to_number (column_value) resultado
			 from table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain(PARAMETRO,NULL),','))
			 where to_number(column_value)=NUCAUSAL_ID;


	RFCUMARCA 	   CUMARCA%ROWTYPE;
	RFCUUOPRODUCTO CUUOPRODUCTO%ROWTYPE;
BEGIN




	OPEN CUMARCA(inuProduct);
	FETCH CUMARCA INTO RFCUMARCA;
	CLOSE CUMARCA;

	IF RFCUMARCA.PRODUCT_ID IS NOT NULL and open.dald_parameter.fsbGetValue_Chain('ASIGNACION_AUTOMATICA_CERT_213', null) = 'S' THEN

		OPEN CUUOPRODUCTO(RFCUMARCA.PRODUCT_ID);
		FETCH CUUOPRODUCTO INTO RFCUUOPRODUCTO ;
    IF CUUOPRODUCTO%FOUND THEN
       RETORD := RFCUUOPRODUCTO.OPERATING_UNIT_ID;
    ELSE
       RETORD := -1;
    END IF;
		CLOSE CUUOPRODUCTO;


	ELSE

		RETORD := -1;

	END IF ;

	RETURN RETORD;

EXCEPTION
    when others then
        RETURN RETORD;

END LDC_FNUULOTPRODUCTO;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNUULOTPRODUCTO', 'ADM_PERSON');
END;
/
