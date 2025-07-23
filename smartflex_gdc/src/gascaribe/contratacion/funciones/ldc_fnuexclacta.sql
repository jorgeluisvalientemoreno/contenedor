CREATE OR REPLACE FUNCTION ldc_fnuexclacta(inOrderId OR_ORDER.ORDER_ID%TYPE)
  RETURN NUMBER IS
  /**************************************************************************************
  Propiedad Intelectual de SINCECOMP (C).

  Funcion     : ldc_fnuexclacta
  Descripcion : Funcion que retorna:
                (1) --> Se debe excluir el acta
                (0) --> No se debe hacer nada
  Autor       : Sebastian Tapias
  Fecha       : 31-07-2017

  Historia de Modificaciones

    Fecha               Autor                Modificacion
  =========           =========          ====================
  18/01/2021		  Olsoftware		 Caso 615. Se agrega una validacion para saber si la orden que se procesara
										 es una orden de novedad o no, si llega a ser de novedad no se realizar¿¿
										 ningun proceso
  ***************************************************************************************/
  sbExcluActa        NUMBER := 0; -- Variable de Retorno
  sbTaskType         OR_ORDER.TASK_TYPE_ID%TYPE := null;
  sbExistTaskType    NUMBER := 0;
  sbFlagBlock        LDC_TITRDOCU.BLOCK_PAGO%TYPE := null;
  sbFlagActi         LDC_TITRDOCU.BLOCK_PAGO%TYPE := 'Y';
  sbEstaOrder        LDC_DOCUORDER.STATUS_DOCU%TYPE := null;
  sbEstaCO           LDC_DOCUORDER.STATUS_DOCU%TYPE := 'CO';
  sbOrderFather      OR_RELATED_ORDER.RELATED_ORDER_ID%TYPE;
  sbExistOrderFather NUMBER := 0;

  /*-------- variable caso 615 ---------*/
  nuCaso 		   	 varchar2(30):='0000615';
  sw                 boolean := false;
  /*-------------------------------------*/

BEGIN
  ut_trace.trace('ldc_fnuexclacta: Inicia funcion', 1);
  BEGIN

	-- caso 615 --
	-- si aplica el caso y la orden es una orden de novedad
	IF (fblAplicaEntregaxCaso(nuCaso) and Ct_Bonovelty.fsbisnoveltyorder(inOrderId) = 'Y')THEN
		sw := true;
	END IF;


	ut_trace.trace('ldc_fnuexclacta: Valida que la orden no sea de novedad', 1);
	IF sw THEN
		-- si la orden es de novedad la funcion ldc_fnuexclacta retornara 0
		sbExcluActa := 0;

	ELSE

		 ut_trace.trace('ldc_fnuexclacta: Valida Tipo de trabajo Orden', 1);
		--validamos tipo de trabajo de la orden
		SELECT oo.task_type_id
		  INTO sbTaskType
		  FROM or_order oo
		 WHERE oo.order_id = inOrderId;
		--si el tipo de trabajo no es nulo procedemos
		IF (sbTaskType is not null) THEN
		  ut_trace.trace('ldc_fnuexclacta: Valida Tipo de trabajo en la tabla ldc_titrdocu', 1);
		  --validamos si el tipo de trabajo existe en la tabla (ldc_titrdocu)
		  SELECT COUNT(1)
			INTO sbExistTaskType
			FROM ldc_titrdocu lt
		   WHERE lt.task_type_id = sbTaskType;
		  --si existe procedemos
		  IF (sbExistTaskType = 1) THEN
			ut_trace.trace('ldc_fnuexclacta: Consulta / Valida Flag de Bloqueo', 1);
			--se valida el Flag de Bloqueo en la tabla (ldc_titrdocu)
			SELECT ltt.block_pago
			  INTO sbFlagBlock
			  FROM ldc_titrdocu ltt
			 WHERE ltt.task_type_id = sbTaskType;
			--Validamos que el flag este activo Y
			IF (sbFlagBlock = sbFlagActi) THEN
			  ut_trace.trace('ldc_fnuexclacta: Consulta estado de la orden', 1);
			  --Buscamos el estado de la orden en la tabla (ldc_docuorder)
			  BEGIN
				SELECT ldd.status_docu
				  INTO sbEstaOrder
				  FROM ldc_docuorder ldd
				 WHERE ldd.order_id = inOrderId;
			  EXCEPTION
				WHEN NO_DATA_FOUND THEN
				  sbExcluActa := 0;
				  sbEstaOrder := null;
			  END;
			  --Si el estado de la orden es CO (En poder de contratista)
			  IF (sbEstaOrder = sbEstaCO) THEN
				ut_trace.trace('ldc_fnuexclacta: Se excluye Acta', 1);
				--Se excluye el acta por un dia.
				sbExcluActa := 1;
			  ELSE
				--No se hace nada.
				sbExcluActa := 0;
			  END IF;
			  -- Si el Flag de Bloqueo esta inactivo N
			ELSE
			  --No se hace nada
			  sbExcluActa := 0;
			END IF;
			-- Si el tipo de trabajo no existe (0) realizamos la siguiente validacion.
		  ELSE
			ut_trace.trace('ldc_fnuexclacta: Consulta Orden Padre', 1);
			BEGIN
			  --Consultamos si la orden tiene una orden relacionada (padre)
			  SELECT COUNT(1)
				INTO sbExistOrderFather
				FROM or_related_order oro
			   WHERE oro.related_order_id = inOrderId;
			  --Si la tiene procedemos a validar
			  IF (sbExistOrderFather = 1) THEN
				ut_trace.trace('ldc_fnuexclacta: Si existe orden padre', 1);
				--Obtenemos la orden padre
				SELECT oro.order_id
				  INTO sbOrderFather
				  FROM or_related_order oro
				 WHERE oro.related_order_id = inOrderId;
				BEGIN
				  ut_trace.trace('ldc_fnuexclacta: Valida Tipo de trabajo de la orden padre', 1);
				  --Validamos el tipo de trabajo de la orden padre
				  SELECT oo.task_type_id
					INTO sbTaskType
					FROM or_order oo
				   WHERE oo.order_id = sbOrderFather;
				  -- Si el tipo de trabajo no es nulo continuamos.
				  IF (sbTaskType is not null) THEN
					-- Validamos si el tipo de trabajo de la orden padre existe en la tabla (ldc_titrdocu)
					SELECT COUNT(1)
					  INTO sbExistTaskType
					  FROM ldc_titrdocu lt
					 WHERE lt.task_type_id = sbTaskType;
					-- Si existe continuamos
					IF (sbExistTaskType = 1) THEN
					  ut_trace.trace('ldc_fnuexclacta: Valida Flag de bloqueo', 1);
					  -- Validamo el Flag de bloqueo
					  SELECT ltt.block_pago
						INTO sbFlagBlock
						FROM ldc_titrdocu ltt
					   WHERE ltt.task_type_id = sbTaskType;
					  -- Si el Flag esta activo Y procedemos
					  IF (sbFlagBlock = sbFlagActi) THEN
						ut_trace.trace('ldc_fnuexclacta: Consulta estado de orden padre', 1);
						-- Obtenemos el estado de la orden padre.
						BEGIN
						  SELECT ldd.status_docu
							INTO sbEstaOrder
							FROM ldc_docuorder ldd
						   WHERE ldd.order_id = sbOrderFather;
						EXCEPTION
						  WHEN NO_DATA_FOUND THEN
							sbExcluActa := 0;
							sbEstaOrder := null;
						END;
						-- Validamos si el estado de la orden padre es CO (En poder de contratista)
						IF (sbEstaOrder = sbEstaCO) THEN
						  ut_trace.trace('ldc_fnuexclacta: Se excluye Acta', 1);
						  --Si existe excluimos el acta.
						  sbExcluActa := 1;
						ELSE
						  --No hace nada.
						  sbExcluActa := 0;
						END IF;
						-- Si el flag es inactivo N
					  ELSE
						--No se hace nada
						sbExcluActa := 0;
					  END IF;
					  -- Si el tipo de trabajo no existe
					ELSE
					  ut_trace.trace('ldc_fnuexclacta: Tipo de trabajo de la orden padre no aplica', 1);
					  --No hace nada
					  sbExcluActa := 0;
					END IF;
				  END IF;
				EXCEPTION
				  WHEN NO_DATA_FOUND THEN
					sbExcluActa := 0;
				END;
				-- Si no existe orden padre
			  ELSE
				ut_trace.trace('ldc_fnuexclacta: No existe orden padre', 1);
				-- No hace nada
				sbExcluActa := 0;
			  END IF;
			EXCEPTION
			  WHEN NO_DATA_FOUND THEN
				sbExcluActa := 0;
				 ut_trace.trace('ldc_fnuexclacta: No existe orden padre', 1);
			END;
		  END IF;
		END IF;


	END IF;  -- fin IF sw THEN



  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      sbExcluActa := 0;
  END;
   ut_trace.trace('ldc_fnuexclacta: Se retorna variable', 1);
   ut_trace.trace('ldc_fnuexclacta:  sbExcluActa['||sbExcluActa||']', 1);
  RETURN sbExcluActa; -- Retornamos la variable.
EXCEPTION
  WHEN OTHERS THEN
    /* En caso de un error inesperado mandaremos tambien 0*/
    RETURN 0;
END ldc_fnuexclacta;
/
GRANT EXECUTE on LDC_FNUEXCLACTA to SYSTEM_OBJ_PRIVS_ROLE;
GRANT DEBUG on LDC_FNUEXCLACTA to SYSTEM_OBJ_PRIVS_ROLE;
GRANT EXECUTE on LDC_FNUEXCLACTA to REPORTES;
GRANT DEBUG on LDC_FNUEXCLACTA to REPORTES;
/
