CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_GEN_OT_APOYO_RELA
BEFORE update ON or_order_Activity
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
when (new.order_id is not null )
/*************************************************************************************************************************************************************
    Propiedad Intelectual de Gases del Caribe

    Funcion     :  ldc_trg_gen_ot_apoyo
    Descripcion :  llama al proceso que Genera la orden de apoyo
    Ticket		:	200-2180
    Autor       : Elkin Alvarez
    Fecha       : 22-11-2018

**************************************************************************************************************************************************************/

DECLARE

 eerror      EXCEPTION;
 sbmensaje   VARCHAR2(1000);
 sbactivavalidacion   VARCHAR2(10);

 nuconta NUMBER;
 nuOrdenhIJA NUMBER;

  error number;

  cursor cuGetOrdeHija IS
  SELECT h.orden
  FROM ldc_ordeapohij h
  WHERE h.SOLICITUD = :new.package_id;

BEGIN

  --se valida si la entrega aplica a la gasera
 IF Fblaplicaentregaxcaso('200-2180') THEN
   sbactivavalidacion := dald_parameter.fsbGetValue_Chain('PARAM_VALOR_APLICA',NULL);

   IF sbactivavalidacion IS NULL THEN
      sbmensaje := 'Debe definir valor para el parametro : PARAM_VALOR_APLICA en la forma LDPAR.';
      RAISE eerror;
   END IF;
   -- Validamos con parametro si la solucion aplica para la empresa
   IF TRIM(sbactivavalidacion) = 'S' THEN

         SELECT COUNT(1) INTO nuconta
      FROM(
        (SELECT to_number(column_value) valor
           FROM TABLE(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('PARAM_ACT_PARA_ORDEN_APOYO',NULL),',')))
        )
      WHERE valor = :new.activity_id;

      --si la actividad esta configurada llamo al proceso
      IF nuconta > 0 THEN
        OPEN cuGetOrdeHija;
        FETCH cuGetOrdeHija INTO nuOrdenhIJA;
        CLOSE cuGetOrdeHija;


        IF nuOrdenhIJA IS NOT NULL THEN
          insert into or_related_order
                 (order_id, related_order_id, rela_order_type_id)
            values (:NEW.ORDER_ID, nuOrdenhIJA, 4);
        END IF;
      END IF;

   END IF;
  END IF;

Exception
  when ex.CONTROLLED_ERROR then
        Errors.getError(error, sbmensaje);
    raise;
 When eerror Then
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,sbmensaje);
  when OTHERS then
      Errors.getError(error, sbmensaje);

END;
/
