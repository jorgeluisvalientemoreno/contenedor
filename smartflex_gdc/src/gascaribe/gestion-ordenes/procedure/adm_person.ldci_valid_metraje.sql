create or replace PROCEDURE ADM_PERSON.LDCI_VALID_METRAJE IS

  numerror        NUMBER;
  sbmessage       VARCHAR2(2000);
  sbErrorMessage VARCHAR2(2000);
  nuOrderId       ge_boInstanceControl.stysbValue;
  nuCausalId      ge_causal.causal_id%type;
  nuCausalClassId ge_class_causal.class_causal_id%type;
  csbEntrega2002275 CONSTANT VARCHAR2(100) := 'OSS_CNTRD_DVM_2002275_1';
  conteo_P NUMBER;
  conteo_H NUMBER;
  conteo_N NUMBER;
  conteo_M NUMBER;
  error_M  NUMBER;

BEGIN

  ut_trace.trace('INICIA LDCI_VALID_METRAJE', 15);
  --Valido la Entrega
  IF open.fblAplicaEntrega(csbEntrega2002275) THEN
    sbErrorMessage := '';
    error_M := 0;
    --Obtener orden de la instancia
    nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;
    ut_trace.trace('Ejecucion LDCI_VALID_METRAJE  => nuOrderId => ' ||
                   nuOrderId,
                   10);
    --Obtener Causal
    nuCausalId := daor_order.fnugetcausal_id(nuOrderId);
    ut_trace.trace('Ejecucion LDCI_VALID_METRAJE  => nuCausalId => ' ||
                   nuCausalId,
                   10);
    --Obtener tipo de causal
    nuCausalClassId := dage_causal.fnugetclass_causal_id(nuCausalId);
    ut_trace.trace('Ejecucion LDCI_VALID_METRAJE => nuCausalClassId=>' ||
                   nuCausalClassId,
                   10);
    --validacion de la Causal
    --Si causal de exito
    IF nuCausalClassId = 1 THEN
      --PADRE
      conteo_P := 0;
      conteo_M := 0;
      select COUNT(1)
        into conteo_P
        from LDC_ORDENES_OFERTADOS_REDES OOR
       WHERE OOR.ORDEN_PADRE = nuOrderId;
      IF conteo_P > 0 THEN
        select COUNT(1)
          into conteo_M
          from LDC_ORDENES_OFERTADOS_REDES OOR
         WHERE OOR.ORDEN_PADRE = nuOrderId
           AND OOR.ORDEN_HIJA IS NULL
           AND OOR.ORDEN_NIETA IS NULL
           AND OOR.METRO_LINEAL IS NOT NULL;
        IF conteo_M = 0 THEN
          sbErrorMessage := 'No puede legalizar la Orden, La Ordenes Padres no tiene Metrajes';
          error_M := 1;
        END IF;
      ELSE
        --HIJA
        conteo_H := 0;
        select COUNT(1)
          into conteo_H
          from LDC_ORDENES_OFERTADOS_REDES OOR
         WHERE OOR.ORDEN_HIJA = nuOrderId;
        IF conteo_H > 0 THEN
          select COUNT(1)
            into conteo_M
            from LDC_ORDENES_OFERTADOS_REDES OOR
           WHERE OOR.ORDEN_HIJA = nuOrderId
             AND OOR.ORDEN_NIETA IS NULL
             AND OOR.METRO_LINEAL IS NOT NULL;
          IF conteo_M = 0 THEN
            sbErrorMessage := 'No puede legalizar la Orden, La Ordenes Hijas no tiene Metrajes';
            error_M := 1;
          END IF;
        ELSE
          --NIETA
          conteo_N := 0;
          select COUNT(1)
            into conteo_N
            from LDC_ORDENES_OFERTADOS_REDES OOR
           WHERE OOR.ORDEN_NIETA = nuOrderId;
          IF conteo_N > 0 THEN
            select COUNT(1)
              into conteo_M
              from LDC_ORDENES_OFERTADOS_REDES OOR
             WHERE OOR.ORDEN_NIETA = nuOrderId
               AND OOR.METRO_LINEAL IS NOT NULL;
            IF conteo_M = 0 THEN
              sbErrorMessage := 'No puede legalizar la Orden, La Ordenes Nietas no tiene Metrajes';
              error_M := 1;
            END IF;
          ELSE
            sbErrorMessage := 'No puede legalizar la Orden, La Ordenes no tiene Metrajes';
            error_M := 1;
          END IF;
        END IF;
      END IF;
      IF error_M = 1 THEN
        Ut_Trace.TRACE('ERROR, INCONSISTENCIAS EN LAS ORDENES Y METRAJE',
                       1);
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,
                                         sbErrorMessage);
        RAISE ex.CONTROLLED_ERROR;
      END IF;
    END IF;
  END IF;

  ut_trace.trace('Fin LDCI_VALID_METRAJE', 15);

EXCEPTION
  WHEN ex.CONTROLLED_ERROR THEN
    errors.geterror(numerror, sbmessage);
    ut_trace.trace(numerror || ' - ' || sbmessage);
    RAISE ex.CONTROLLED_ERROR;
  WHEN OTHERS THEN
    errors.geterror(numerror, sbmessage);
    ut_trace.trace(numerror || ' - ' || sbmessage);
    Errors.setError;
    RAISE ex.CONTROLLED_ERROR;
END LDCI_VALID_METRAJE;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDCI_VALID_METRAJE', 'ADM_PERSON');
END;
/
