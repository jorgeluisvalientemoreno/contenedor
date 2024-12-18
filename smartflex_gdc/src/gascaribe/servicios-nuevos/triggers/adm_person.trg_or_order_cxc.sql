CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_OR_ORDER_CXC
AFTER UPDATE ON OR_ORDER
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;
  NUPACKAGE_ID          NUMBER(15);
  NUCOMERCIAL_PLAN      NUMBER(15);
  NUPRODUCT             NUMBER(15);
  NUORDER_ID            NUMBER(15);
  NUCONTRATO            NUMBER(15);
  COUNT_ORDER           NUMBER(15);
  NUERR                 NUMBER := 0;
  COUNT_COMMENT         NUMBER := 0;
  COUNT_LEG_COMMENT     NUMBER := 0;
  COUNT_CAMUNDA_PACKAGE NUMBER := 0;
  COUNT_MANAGED_CERTI   NUMBER := 0;

  PROCEDURE PRVALIDAORDENES(SOLICITUD    NUMBER,
                            TIPO_TRABAJO NUMBER,
                            CAUSALES     VARCHAR2,
                            NUERRROR     OUT NUMBER) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN

    SELECT ORDER_ID
      INTO NUORDER_ID
      FROM OPEN.OR_ORDER
     WHERE ORDER_ID IN (SELECT ORDER_ID
                          FROM OPEN.OR_ORDER_ACTIVITY
                         WHERE PACKAGE_ID = SOLICITUD
                           AND TASK_TYPE_ID = TIPO_TRABAJO)
       AND ORDER_STATUS_ID = 8
       AND CAUSAL_ID IN
           (SELECT TO_NUMBER(COLUMN_VALUE)
              FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(CAUSALES, ',')))
       AND ROWNUM = 1;

    NUERRROR := 0;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      NUERRROR := -1;
  END;

  PROCEDURE PRVALIDACERTIFICACION(ORDEN_CXC NUMBER, NUERRROR OUT NUMBER) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN

    SELECT COUNT(1) X
      INTO COUNT_ORDER
      FROM OPEN.OR_ORDER OO
     INNER JOIN OPEN.OR_ORDER_ACTIVITY OA
        ON OA.ORDER_ID = OO.ORDER_ID
     WHERE OA.PRODUCT_ID IN (SELECT PRODUCT_ID
                               FROM OPEN.OR_ORDER_ACTIVITY
                              WHERE ORDER_ID = ORDEN_CXC)
       AND OO.ORDER_STATUS_ID + 0 = 8
       AND ((OO.TASK_TYPE_ID + 0 = 12162 AND OO.CAUSAL_ID + 0 = 9944) OR
           (OO.TASK_TYPE_ID + 0 = 10500 AND OO.CAUSAL_ID + 0 = 3333));

    IF COUNT_ORDER <= 0 THEN
      NUERRROR := -1;
      RETURN;
    END IF;

    NUERRROR := 0;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      NUERRROR := -1;
  END;

BEGIN

  IF :OLD.TASK_TYPE_ID <> 12150 THEN
    RETURN;
  END IF;

  IF :NEW.ORDER_STATUS_ID = 11 OR :OLD.ORDER_STATUS_ID <> 11 OR
     :NEW.ORDER_STATUS_ID = 12 THEN
    RETURN;
  END IF;

  SELECT COUNT(1)
    INTO COUNT_COMMENT
    FROM OR_ORDER_COMMENT OC
   WHERE OC.ORDER_COMMENT LIKE 'INV_EXCLUSION_CXC:%'
     AND OC.ORDER_ID = :NEW.ORDER_ID;

  IF COUNT_COMMENT > 0 THEN
    RETURN;
  END IF;

  SELECT PACKAGE_ID, PRODUCT_ID, SUBSCRIPTION_ID
    INTO NUPACKAGE_ID, NUPRODUCT, NUCONTRATO
    FROM OPEN.OR_ORDER_ACTIVITY
   WHERE ORDER_ID = :NEW.ORDER_ID
     AND ROWNUM = 1;

  SELECT COMMERCIAL_PLAN_ID
    INTO NUCOMERCIAL_PLAN
    FROM OPEN.PR_PRODUCT
   WHERE PRODUCT_ID = NUPRODUCT;

  SELECT COUNT(1)
    INTO COUNT_MANAGED_CERTI
    FROM OPEN.OR_ORDER OO
    INNER JOIN OPEN.OR_ORDER_ACTIVITY OA
    ON OA.ORDER_ID = OO.ORDER_ID
  WHERE OA.SUBSCRIPTION_ID = NUCONTRATO
      AND OO.ORDER_STATUS_ID + 0 IN (7,8)
      AND OO.TASK_TYPE_ID + 0 IN (12162, 10500)
      AND OO.CAUSAL_ID + 0 IN (9944, 3333);

  SELECT COUNT(1)
    INTO COUNT_CAMUNDA_PACKAGE
    FROM OPEN.LDCI_PACKAGE_CAMUNDA_LOG
   WHERE PACKAGE_ID = NUPACKAGE_ID;

  SELECT COUNT(1)
    INTO COUNT_LEG_COMMENT
    FROM "OPEN".MO_COMMENT mc
  WHERE mc.PACKAGE_ID = NUPACKAGE_ID
    AND mc.COMMENT_TYPE_ID = 2
    AND mc.COMMENT_ LIKE '%PLAN_PILOTO_2_VISITAS_V2%';


  /*Se permite el desbloqueo y asignación de OTs 12150 si la OT 12162 está ejecutada o legalizada con caisal de éxito
   en los planes comerciales 34,42,43,48,54 */
  IF NUCOMERCIAL_PLAN IN (34,42,43,48,54) THEN
    IF COUNT_MANAGED_CERTI <= 0 THEN
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                      'No se encontró una orden de certificación ejecutada o cerrada con éxito.');
      raise ex.CONTROLLED_ERROR;
    END IF;
    RETURN;
  END IF;

  /*Se permite el desbloqueo y asignación de OTs 12150 sin ot de certificacion legalizada con éxito
    para cualquier contrato de camunda*/
  IF COUNT_CAMUNDA_PACKAGE = 0 THEN
    PRVALIDACERTIFICACION(:NEW.ORDER_ID, NUERR);
    IF NUERR = -1 THEN
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                      'No se encontro una orden de certificacion cerrada con exito.');
      raise ex.CONTROLLED_ERROR;
    END IF;
  END IF;

  IF NUCOMERCIAL_PLAN = 36 OR NUCOMERCIAL_PLAN = 41 THEN
  	/*Se permite el desbloqueo y asignación de OTs 12150 sin acometida legalizada con éxito
    únicamente para contratos de Plan Comercial 41*/
    IF NUCOMERCIAL_PLAN = 41 AND COUNT_CAMUNDA_PACKAGE > 0
      AND (:NEW.ORDER_STATUS_ID = 0 OR :NEW.ORDER_STATUS_ID = 5) THEN
      RETURN;
    END IF;

    --en caso de que sea parte del plan piloto de dos visitas se permite es desbloqueo del cxc para el plan 36
    IF COUNT_LEG_COMMENT = 0 THEN
      PRVALIDAORDENES(NUPACKAGE_ID, 10273, '9944, 3675', NUERR);
      IF NUERR = -1 THEN
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                        'La orden de tipo 10273 asociada a la solicitud ' ||
                                        NUPACKAGE_ID ||
                                        ' no esta legalizada con alguna de las causales permitidas (9944, 3675)');
        raise ex.CONTROLLED_ERROR;
      END IF;
    END IF;
  END IF;

  IF NUCOMERCIAL_PLAN = 4 THEN
  	/*Se permite el desbloqueo y asignación de OTs 12150 sin interna legalizada con éxito
    para contratos de Plan Comercial 4*/
    IF NUCOMERCIAL_PLAN = 4 AND COUNT_CAMUNDA_PACKAGE > 0
      AND :NEW.ORDER_STATUS_ID IN (0,5,7) THEN
      RETURN;
    END IF;
    PRVALIDAORDENES(NUPACKAGE_ID, 12149, '9944', NUERR);
    IF NUERR = -1 THEN
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       'La orden de tipo 12149 asociada a la solicitud ' ||
                                       NUPACKAGE_ID ||
                                       ' no esta legalizada con alguna de las causales permitidas (9944)');
      raise ex.CONTROLLED_ERROR;
    END IF;
  END IF;

EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    RAISE;
  WHEN OTHERS THEN
    ERRORS.SETERROR();
    RAISE EX.CONTROLLED_ERROR;
END;
/
