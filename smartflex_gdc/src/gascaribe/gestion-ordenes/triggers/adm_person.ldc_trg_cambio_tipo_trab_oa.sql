CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_CAMBIO_TIPO_TRAB_OA
BEFORE INSERT ON Or_Order_Activity
REFERENCING
    NEW AS NEW
    OLD AS OLD
FOR EACH ROW
DECLARE
 sbesexterna or_operating_unit.es_externa%Type;
 sbFlagAsignar     VARCHAR2(2) := 'N';
 nuContratoAsignar ge_contrato.id_contrato%TYPE;
  --- Caso 200-1138
  nucostopromconf   ldc_taskactcostprom.costo_prom%TYPE;
  rgreistcontrato   ge_contrato%ROWTYPE;
  nutotalvaidarasig ge_contrato.valor_total_contrato%TYPE DEFAULT 0;
  nuvaldiferen      ge_contrato.valor_total_contrato%TYPE DEFAULT 0;
  nudefcont         or_order.defined_contract_id%TYPE;
  nuestimat         or_order.estimated_cost%TYPE;
  nuestaorden       or_order.order_status_id%TYPE;

  CURSOR cuCostoProm IS
    SELECT vb.costo_prom
      FROM ldc_taskactcostprom vb
     WHERE vb.unidad_operativa = :new.operating_unit_id
       AND vb.tipo_trab = :new.task_type_id
       AND vb.actividad = :new.activity_id;

  CURSOR cuCostoProMTodos IS
    SELECT vb.costo_prom
      FROM ldc_taskactcostprom vb
     WHERE vb.unidad_operativa IS NULL --= :new.operating_unit_id
       AND vb.tipo_trab = :new.task_type_id
       AND vb.actividad = :new.activity_id;

  sbprograma VARCHAR2(4000);
  nuvatipotrab or_task_type.task_type_id%TYPE;
BEGIN
  BEGIN
   SELECT nu_tipo_trab INTO nuvatipotrab
     FROM(
          SELECT oa.task_type_id nu_tipo_trab
            FROM or_order_activity oa
           WHERE oa.order_id          = :new.order_id
             AND oa.order_activity_id <> :new.order_activity_id
           ORDER BY oa.register_date DESC
         )
   WHERE rownum = 1;
  EXCEPTION
   WHEN no_data_found THEN
    nuvatipotrab := NULL;
  END;
  IF nuvatipotrab IS NOT NULL AND nuvatipotrab <> :new.task_type_id THEN
      IF fblaplicaentrega(ldc_pkgasignarcont.fsbversion) THEN
        sbflagasignar := dald_parameter.fsbgetvalue_chain('LDC_ASIGCONT',NULL);

      END IF;
      BEGIN
        -- Se consulta que clasificacion que tiene la UT a asignar
        SELECT es_externa INTO sbesexterna
          FROM or_operating_unit
         WHERE operating_unit_id = :new.operating_unit_id;
      EXCEPTION
        WHEN no_data_found THEN
          sbesexterna := NULL;
      END;
      -- Valida si la unidad operativa es externa, si no es externa termina(permite asignar la orden)
      IF sbesexterna = 'Y' THEN

	-- Validamos si se puede asignar la orden
	   BEGIN
		SELECT otf.order_status_id,otf.defined_contract_id, otf.estimated_cost INTO nuestaorden,nudefcont, nuestimat
		  FROM or_order otf
		 WHERE otf.order_id = :new.order_id;
	   EXCEPTION
		WHEN no_data_found THEN
		  nudefcont := -1;
	   END;

		--TICKET 200-810 LJLB -- si el flag esta activo se proceso asignar el contrato
        IF sbFlagAsignar = 'S' and LDC_PKGASIGNARCONT.fnuGetConfTicoCont( nudefcont ) > 0 THEN
          -- Consultamos el costo promedio configurado
          nucostopromconf := 0;
          BEGIN
            OPEN cuCostoProM;
            FETCH cuCostoProM INTO nucostopromconf;
            IF cuCostoProM%NOTFOUND THEN
              OPEN cuCostoProMTodos;
              FETCH cuCostoProMTodos INTO nucostopromconf;
              IF cuCostoProMTodos%NOTFOUND THEN
                errors.seterror(2741,
                                'La unidad operativa : ' ||
                                to_char(:new.operating_unit_id) ||
                                ' con el tipo de trabajo : ' ||
                                to_char(:new.task_type_id) ||
                                ' y la actividad : ' ||
                                to_char(:new.activity_id) ||
                                ' no tiene configuracion del costo promedio por la forma : LDCCOTTACCP.');
                CLOSE cuCostoProMTodos;
                CLOSE cuCostoProM;
                RAISE ex.controlled_error;
              END IF;
              CLOSE cuCostoProMTodos;
            END IF;
            CLOSE cuCostoProM;
          EXCEPTION
            WHEN no_data_found THEN
              errors.seterror(2741,
                              'La unidad operativa : ' ||
                              to_char(:new.operating_unit_id) ||
                              ' con el tipo de trabajo : ' ||
                              to_char(:new.task_type_id) ||
                              ' y la actividad : ' ||
                              to_char(:new.activity_id) ||
                              ' no tiene configuracion del costo promedio por la forma : LDCCOTTACCP.');
		       Raise ex.controlled_error;
          END;

           IF nudefcont >= 1 AND nucostopromconf > 0  THEN
				nuContratoAsignar := nudefcont;
				BEGIN
				 SELECT * INTO rgreistcontrato
				   FROM open.ge_contrato con
				  WHERE con.id_contrato = nuContratoAsignar;
				EXCEPTION
				 WHEN no_data_found THEN
				  errors.seterror(2741,'El contrato : '||to_char(nuContratoAsignar)||' no existe.');
				END;
				nuvaldiferen := (nvl(nuestimat, 0) - nvl(nucostopromconf, 0)) * -1;
				nutotalvaidarasig := nvl(nuvaldiferen, 0) +
									 nvl(rgreistcontrato.valor_asignado, 0) +
									 nvl(rgreistcontrato.valor_no_liquidado, 0) +
									 nvl(rgreistcontrato.valor_liquidado, 0) ;
				IF nvl(nutotalvaidarasig, 0) > nvl(rgreistcontrato.valor_total_contrato, 0) THEN
				  errors.seterror(2741,
								  'No es prosible cambiar el contrato a la orden : ' ||
								  to_char(:new.order_id) ||
								  ' debido a que el contrato : ' ||
								  to_char(nudefcont) || ' no tiene cupo.');
					Raise ex.controlled_error;
				ELSE
				 IF nuestaorden = 5 THEN
				  UPDATE or_order o
					 SET o.estimated_cost = nucostopromconf
				   WHERE o.order_id       = :new.order_id;
				   ldc_pkgasignarcont.procvalacumttact(nvl(nuvaldiferen, 0),
													   NULL,
													   nuContratoAsignar,
													   nuestaorden,
													   NULL);
				 END IF;
            END IF;
          END IF;
        END IF;
      END IF;
  END IF;
Exception
  When ex.controlled_error Then
    Raise;
  When Others Then
    errors.seterror;
    Raise ex.controlled_error;
END;
/
