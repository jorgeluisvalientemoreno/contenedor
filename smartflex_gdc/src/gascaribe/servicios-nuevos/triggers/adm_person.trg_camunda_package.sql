CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_CAMUNDA_PACKAGE
AFTER INSERT OR UPDATE ON OR_ORDER
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
DECLARE
  FLAG             NUMBER := 0;
  NUPACKAGE_ID     NUMBER(15);
  NUCOMMERCIALPLAN NUMBER;
  CREATED_BY VARCHAR(100);
BEGIN
   /*
   Validamos que el trigger se encuentre activo
   1=ACTIVO | 0=INACTIVO
   */
  SELECT COUNT(1) INTO FLAG
  FROM LD_PARAMETER_INNOVA
  WHERE PARAMETER_ID = 'TRG_CAMUNDA_PACKAGE'
  AND ACTIVE = 'Y';

  IF (FLAG <> 1) THEN
    RETURN;
  END IF;

  /*
    Excluimos los tipos de ordenes que no son de servicios nuevos
    12149 - CONSTRUCCION DE INSTALACION INTERNA RESIDENCIAL
    10273 - VERIFICAR/REALIZAR ACOMETIDA X CONTRATISTA
    10500 - VISITA DE ACEPTACION DE CERTIFICACION DE INSTALACIONES
  */
  IF :NEW.TASK_TYPE_ID NOT IN ( 12149, 10273, 10500 ) THEN
    RETURN;
  END IF;

  /* Si la orden no esta sufriendo cambio en los campos que interesan, continua */
  IF UPDATING AND :OLD.TASK_TYPE_ID = :NEW.TASK_TYPE_ID AND :OLD.ORDER_STATUS_ID = :NEW.ORDER_STATUS_ID AND :OLD.OPERATING_UNIT_ID = :NEW.OPERATING_UNIT_ID THEN
    RETURN;
  END IF;

  IF :NEW.ORDER_STATUS_ID <> 5 AND :NEW.TASK_TYPE_ID IN ( 12149, 10273 ) THEN
    RETURN;
  END IF;

  IF :NEW.ORDER_STATUS_ID = 8 AND :NEW.TASK_TYPE_ID = 10500 THEN
    RETURN;
  END IF;

  /* Se extrae informacion de la solicitud y producto */
  BEGIN
    SELECT ooa.PACKAGE_ID, pr.COMMERCIAL_PLAN_ID INTO NUPACKAGE_ID, NUCOMMERCIALPLAN
    FROM OPEN.OR_ORDER_ACTIVITY ooa
    INNER JOIN OPEN.MO_PACKAGES mp ON ooa.PACKAGE_ID = mp.PACKAGE_ID AND mp.PACKAGE_TYPE_ID = 271
    INNER JOIN OPEN.PR_PRODUCT pr ON pr.PRODUCT_ID = ooa.PRODUCT_ID
    WHERE ooa.ORDER_ID = :NEW.ORDER_ID
      AND NOT EXISTS ( SELECT 1 FROM OPEN.LDCI_PACKAGE_CAMUNDA_LOG C WHERE C.PACKAGE_ID = ooa.PACKAGE_ID )
      AND pr.COMMERCIAL_PLAN_ID IN ( 4, 36, 41 )
      AND ROWNUM = 1;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN;
  END;

  /* Casos en que un contrato cambia de plan comercial */
  IF ( NOT(
        ( :NEW.TASK_TYPE_ID = 10500 AND NUCOMMERCIALPLAN = 41 )
    OR ( :NEW.TASK_TYPE_ID = 10273 AND NUCOMMERCIALPLAN = 36 )
    OR ( :NEW.TASK_TYPE_ID = 12149 AND NUCOMMERCIALPLAN = 4 ) ) ) THEN
    RETURN;
  END IF;

  LDCBI_LOG( 'PACKAGE_CAMUNDA', NUPACKAGE_ID, NULL, NULL, NULL );

  /* se inserta la solicitud en la tabla de restriccion */
  BEGIN
    INSERT INTO OPEN.LDCI_PACKAGE_CAMUNDA_LOG ( PACKAGE_ID, CREATED_DATE ) VALUES ( NUPACKAGE_ID, SYSDATE ) ;
  EXCEPTION
  WHEN OTHERS THEN
    RETURN;
  END;
END;
/