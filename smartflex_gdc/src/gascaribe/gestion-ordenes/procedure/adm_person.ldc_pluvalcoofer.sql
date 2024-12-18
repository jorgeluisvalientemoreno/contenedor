CREATE OR REPLACE PROCEDURE adm_person.ldc_pluvalcoofer 
IS
    /**************************************************************************
    Autor       : Esantiago / Horbath
    Fecha       : 22-10-2019
    Ticket      : 51
    Descripcion : Plugin que  permite .
    
    Valor de salida
    
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    16/04/2024   PAcosta     OSF-2532: Se crea el objeto en el esquema adm_person
                             Se elimina la relación esquema open (.open) aobjetos  
    10/02/2021	 MABG		 Caso 645: Se agrega trunc en los campos tipos fecha relacionados con la
                             tabla ge_list_unitary_cost para que no se tenga en cuenta la hora
    ***************************************************************************/
    nuorden                 or_order.order_id%TYPE;
	nuorder_id              or_order.order_id%TYPE;
    osberrormessage         ge_error_log.DESCRIPTION%TYPE;
	onuerrorcode          	ge_error_log.error_log_id%TYPE;
    nuunitop              	or_operating_unit.operating_unit_id%TYPE;
	nulistco			  	ge_list_unitary_cost.list_unitary_cost_id%TYPE;
	nucausalid				ge_causal.causal_id%TYPE;
	nucausalclassid			ge_causal.class_causal_id%TYPE;
    sbdatos VARCHAR2(1);
	nuvalit NUMBER;
	nucausallegalizacion NUMBER;
    nutipocomentario NUMBER;
    sbcomentario VARCHAR(200);

	CURSOR cuvalof(nuorden NUMBER) IS
			SELECT o.operating_unit_id
			FROM ldc_const_unoprl uof, 
                 or_order o
			WHERE uof.unidad_operativa = o.operating_unit_id
			AND o.order_id=nuorden;

	CURSOR cuvallist(nuorden NUMBER) IS
			SELECT L.list_unitary_cost_id
			FROM ldc_const_unoprl uo,
                 or_order o,
                 ge_list_unitary_cost L
			WHERE uo.unidad_operativa=o.operating_unit_id
			AND L.operating_unit_id=o.operating_unit_id
			AND o.order_id= nuorden
			AND L.validity_final_date >= TRUNC(o.execution_final_date) --- cambio caso 645
			AND L.validity_start_date <= TRUNC(o.execution_final_date); --- cambio caso 645

	CURSOR cuoritems(nuorden NUMBER) IS
			SELECT I.items_id 
            FROM  ge_items I , 
                  or_order_items o
			WHERE o.items_id=I.items_id
			AND item_classif_id NOT IN (SELECT nvl((COLUMN_VALUE), 0)
										FROM TABLE(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('PARITEMNOPER',NULL),',')))
			AND NOT EXISTS  (SELECT * FROM ldc_homoitmaitac WHERE item_actividad=o.items_id)
			AND o.order_id= nuorden;

	CURSOR cuvalitems(item NUMBER,lista NUMBER) IS
			SELECT 1
            FROM ge_unit_cost_ite_lis
			WHERE   list_unitary_cost_id=lista --220
			AND  items_id= item; --100000694

BEGIN
    -- con estas funciones se obtienen los datos de la orden que se intentan legalizar --
    ut_trace.TRACE('Inicio PLUGIN LDC_PLUVALCOOFER',10);
    nuorden := or_bolegalizeorder.fnugetcurrentorder;--82101712;--140880614; --or_bolegalizeorder.fnuGetCurrentOrder; -- se obtiene el id de la orden que se intenta legalizar
	nucausalid := to_number(ldc_boutilities.fsbgetvalorcampotabla ('or_order','order_id','causal_id',nuorden));
	--Obtener clase de causal
	nucausalclassid := dage_causal.fnugetclass_causal_id(nucausalid);

	IF fblaplicaentregaxcaso('0000051') THEN
		IF nucausalclassid = 1 THEN
			OPEN cuvalof(nuorden);
			FETCH cuvalof INTO nuunitop;


			dbms_output.put_line('nuUnitop '||nuunitop);

			IF cuvalof%found THEN
				 nulistco:=NULL;
				 OPEN cuvallist(nuorden);
				 FETCH cuvallist INTO nulistco;
				 CLOSE cuvallist;

				 dbms_output.put_line('nuListco '||nulistco);
				 IF nulistco IS NULL THEN
					osberrormessage := 'No se encontró lista de costos vigente para la unidad '
										||nuunitop;
					dbms_output.put_line('error 001: '||osberrormessage);
					ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,osberrormessage);
					RAISE ex.controlled_error;
				 END IF;

				 FOR it IN cuoritems(nuorden) LOOP
					dbms_output.put_line('item '||it.items_id);
					OPEN cuvalitems(it.items_id,nulistco);
					FETCH cuvalitems INTO nuvalit;
					IF cuvalitems%notfound THEN
						dbms_output.put_line('error 002');
						osberrormessage := 'No se encontró un precio para el  ítem '||it.items_id||
						' en la lista de costos de la unidad de trabajo '||nuunitop;
						dbms_output.put_line('error 002: '||osberrormessage);
						ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,osberrormessage);
						RAISE ex.controlled_error;
					END IF;
					CLOSE cuvalitems;

				 END LOOP;

			END IF;
			CLOSE cuvalof;
			dbms_output.put_line('correcto');
		END IF;
	END IF;
    ut_trace.TRACE('fin PLUGIN LDC_PLUVALCOOFER',10);
EXCEPTION
    WHEN ex.controlled_error THEN
       RAISE ex.controlled_error;
    WHEN OTHERS THEN
        ERRORS.seterror;
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,osberrormessage);
        RAISE ex.controlled_error;
END ldc_pluvalcoofer;
/
PROMPT Otorgando permisos de ejecucion a LDC_PLUVALCOOFER
BEGIN
  pkg_utilidades.praplicarpermisos('LDC_PLUVALCOOFER','ADM_PERSON');
END;
/