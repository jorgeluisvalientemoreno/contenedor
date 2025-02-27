CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_RESTRICT_CXC_CERTIFICADO
BEFORE UPDATE ON OR_ORDER
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
DECLARE
  /*
  Se requiere colocar un control  a la orden de CXC
  de planes comerciales (4,36,34,8) que incluyan
  certificacion que  verifique que debe existir un
  certificado aprobado de resultado 1 o 4 de un OIA
  interno (contratista)  para poder legalizar la orden de CXC
  */
  PRAGMA AUTONOMOUS_TRANSACTION;
  USR_INNOVACION VARCHAR2(10) := 'INNOVACION';
  FLAG  NUMBER(1);
  NUPACKAGE_ID     NUMBER(15);
  NUPACKAGE_TYPE_ID NUMBER(15);
  NUCOMERCIAL_PLAN NUMBER(15);
  ACCION_ VARCHAR(1);
  NUPRODUCT        NUMBER(15);
  COUNT_COMMENT    NUMBER := 0;
  COUNT_COMMERCIAL_PLA NUMBER(15);
  COUNT_CERTIFICATE NUMBER(15);
  COUNT_CAMUNDA NUMBER(15);
BEGIN
   /*
   Validamos que el trigger se encuentre activo
   1=ACTIVO | 0=INACTIVO
   */
  SELECT COUNT(1) INTO FLAG
  FROM OPEN.LD_PARAMETER_INNOVA
  WHERE PARAMETER_ID = 'TRG_RESTRICT_CXC_CERTIFICADO'
  AND ACTIVE = 'Y' ;

  IF FLAG <> 1 THEN
    RETURN;
  END IF;

  /*
    Excluimos los tipos de ordenes que no son de 12150 - CARGO POR CONEXION RESIDENCIAL
  */
  IF :OLD.TASK_TYPE_ID NOT IN (12150) THEN
    ROLLBACK;
    RETURN;
  END IF;

  /* Si la orden no esta sufriendo cambio en los campos que interesan, continua */
  IF NOT( :OLD.ORDER_STATUS_ID IN (5,7) AND :NEW.ORDER_STATUS_ID = 8 ) THEN
    ROLLBACK;
    RETURN;
  END IF;

  BEGIN
    SELECT ooa.PACKAGE_ID, ooa.PRODUCT_ID, mp.PACKAGE_TYPE_ID
    INTO NUPACKAGE_ID, NUPRODUCT, NUPACKAGE_TYPE_ID
    FROM OPEN.OR_ORDER_ACTIVITY ooa
    INNER JOIN OPEN.MO_PACKAGES mp ON ooa.PACKAGE_ID = mp.PACKAGE_ID AND mp.PACKAGE_TYPE_ID = 271
    WHERE ooa.ORDER_ID = :NEW.ORDER_ID
      AND ROWNUM = 1;
  EXCEPTION
    WHEN no_data_found THEN
      ROLLBACK;
      RETURN;
  END;

  SELECT COMMERCIAL_PLAN_ID
  INTO NUCOMERCIAL_PLAN
  FROM OPEN.PR_PRODUCT
  WHERE PRODUCT_ID = NUPRODUCT;

  /* Se permite modificacion si contrato no es plan comercial 4,8,36,34, o si el tipo de solicitud no es 271 Venta de gas por formulario */
  IF NUCOMERCIAL_PLAN IS NULL OR NUPACKAGE_TYPE_ID IS NULL THEN
    ROLLBACK;
    RETURN;
  ELSIF NOT ( NUCOMERCIAL_PLAN IN (4,8,36,34) ) THEN --AND NUPACKAGE_TYPE_ID = 271
    ROLLBACK;
    RETURN;
  END IF;

  SELECT COUNT(1)
  INTO COUNT_CAMUNDA
  FROM OPEN.LDCI_PACKAGE_CAMUNDA_LOG lpcl
  WHERE lpcl.PACKAGE_ID = NUPACKAGE_ID;

  SELECT COUNT(1)
  INTO COUNT_COMMENT
  FROM OPEN.OR_ORDER_COMMENT OC
  WHERE OC.ORDER_COMMENT
  LIKE 'INV_BLOQUEA_CXC:%'
  AND OC.ORDER_ID = :NEW.ORDER_ID;

  IF NUCOMERCIAL_PLAN IN (4,36) AND COUNT_CAMUNDA > 0 AND COUNT_COMMENT < 1 THEN
    ROLLBACK;
    RETURN;
  END IF;

  SELECT COUNT(1)
  INTO COUNT_CERTIFICATE
  FROM OPEN.LDC_CERTIFICADOS_OIA lco
  WHERE lco.ID_PRODUCTO = NUPRODUCT
  AND lco.RESULTADO_INSPECCION IN (1,4);

  /*Se valida que el certificado este aprobado por el OIA*/
  IF COUNT_CERTIFICATE > 0 THEN
    ROLLBACK;
    RETURN;
  END IF;

  /* Restringimos el usuario de BD para que unicamente el usuario de INNOVACION pueda realizar esta accion */
  IF USER = USR_INNOVACION THEN
    ROLLBACK;
    RETURN;
  END IF;

  ACCION_ := 'C';

  insert into OPEN.LDCI_SERVNUEV_LOG_OR_ORDER ( ORDER_ID, ACCION, TASK_TYPE_ID_OLD, TASK_TYPE_ID_NEW, ORDER_STATUS_ID_OLD, ORDER_STATUS_ID_NEW, CAUSAL_ID_OLD, CAUSAL_ID_NEW, SYSDATE_, USERMASK, USER_)
  values ( :NEW.ORDER_ID, ACCION_, :OLD.TASK_TYPE_ID, :NEW.TASK_TYPE_ID, :OLD.ORDER_STATUS_ID, :NEW.ORDER_STATUS_ID, :OLD.CAUSAL_ID, :NEW.CAUSAL_ID, SYSDATE, AU_BOSystem.getSystemUserMask, USER);
  commit;

  ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
  'Esta accion no esta permitida en Smartflex. El certificado deber ser aprobado para poder legalizar esta orden.' );
  raise ex.CONTROLLED_ERROR;
END;
/
