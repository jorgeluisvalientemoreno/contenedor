CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_RESTRICT_SERVNUEV_EVIDENCI
AFTER INSERT OR UPDATE ON OR_ORDER
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

  COUNT_COMMENT    NUMBER := 0;
  NUNUMERIC_VALUE  NUMBER(16);
  NUSUSCRIPTION_ID NUMBER(10);
  COUNT_EVIDEN_GESTI NUMBER := 0;

  BEGIN
  /*
  Trigger para restricción en la legalización de Ordenes de Interna 12149 para Paquete Completo.
  Restringe la legalización de Ordenes que no hayan sido gestionadas por el Contratista en el Portal de Evidencias.
 */
 /*
    Validamos que el trigger se encuentre activo
    1=ACTIVO | 0=INACTIVO
  */
  SELECT NUMERIC_VALUE
  INTO NUNUMERIC_VALUE
  FROM OPEN.LD_PARAMETER
  WHERE PARAMETER_ID = 'TRG_RESTRICT_SERVNUEV_EVIDENCI';

  IF (NUNUMERIC_VALUE <> 1) THEN
    RETURN;
  END IF;
  /* Excluimos Orden con comentario específico en caso de necesitarse excepciones*/
  SELECT COUNT(1)
  INTO COUNT_COMMENT
  FROM OPEN.OR_ORDER_COMMENT ooc
  WHERE ooc.ORDER_ID = :NEW.ORDER_ID
  AND ooc.ORDER_COMMENT LIKE 'RESTRICT_SERVNUEV%';

  IF COUNT_COMMENT > 0 THEN
    RETURN;
  END IF;

  /* Excluimos tipos de ordenes diferentes a interna*/
  IF :OLD.TASK_TYPE_ID <> 12149 THEN
    RETURN;
  END IF;

  /* Excluimos operaciones distintas a la legalización de la OT */
  IF (:OLD.ORDER_STATUS_ID  NOT IN (5,7) OR :NEW.ORDER_STATUS_ID <> 8) THEN
    RETURN;
  END IF;
    /*
    Excluimos la legalización de OTs con causales distintas a 9944
  */
  IF :NEW.CAUSAL_ID <> 9944 THEN
    RETURN;
  END IF;
  /*
    Se obtiene el Contrato para validación final
    Se excluyen otros tipos de solicitudes diferentes a 271 - Venta de Gas por Formulario
    y Planes comerciales distintos a 4 - Paq completo con rev previa
  */
  BEGIN
    SELECT ooa.SUBSCRIPTION_ID
    INTO NUSUSCRIPTION_ID
    FROM OPEN.OR_ORDER_ACTIVITY ooa
      INNER JOIN OPEN.MO_PACKAGES mp ON ooa.PACKAGE_ID = mp.PACKAGE_ID AND mp.PACKAGE_TYPE_ID = 271
      INNER JOIN OPEN.PR_PRODUCT pr ON pr.PRODUCT_ID = ooa.PRODUCT_ID AND pr.COMMERCIAL_PLAN_ID = 4
    WHERE ooa.ORDER_ID = :NEW.ORDER_ID
      AND ROWNUM = 1;

      EXCEPTION
    WHEN no_data_found THEN
      RETURN;
  END;
  /*
    Se valida que el Contrato correspondiente a la OT siendo procesada
    se encuentre gestionado en el Portal de Evidencias
  */
  SELECT COUNT(1)
  INTO COUNT_EVIDEN_GESTI
  FROM OPEN.LDCI_SERVNUEV_EVIDENCI_GESTION lseg
  WHERE lseg.SUBSCRIPTION_ID = NUSUSCRIPTION_ID AND STATUS >= 3;

  IF COUNT_EVIDEN_GESTI > 0 THEN
    RETURN;
  END IF;

  ge_boerrors.seterrorcodeargument(
        Ld_Boconstans.cnuGeneric_Error,
        'Esta acción no está permitida en Smartflex. La carpeta asociada a este contrato en el Portal de Evidencias aún no ha sido gestionada por el contratista');
      raise ex.CONTROLLED_ERROR;
END;
/
