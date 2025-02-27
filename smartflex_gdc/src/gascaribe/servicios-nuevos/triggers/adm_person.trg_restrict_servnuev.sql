CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_RESTRICT_SERVNUEV
BEFORE INSERT OR UPDATE ON OR_ORDER
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;
  USR_INNOVACION VARCHAR2(10) := 'INNOVACION';
  NUNUMERIC_VALUE  NUMBER(16);
  NUPACKAGE_ID     NUMBER(15);
  NUPACKAGE_CAMUNDA NUMBER(15);
  NUPACKAGE_TYPE_ID NUMBER(15);
  NUCOMERCIAL_PLAN NUMBER(15);
  ACCION_ VARCHAR(1);
  NUPRODUCT        NUMBER(15);
  COUNT_COMMERCIAL_PLA NUMBER(15);
 BEGIN

   /*
   Validamos que el trigger se encuentre activo
   1=ACTIVO | 0=INACTIVO
   */

   SELECT NUMERIC_VALUE
   INTO NUNUMERIC_VALUE
   FROM OPEN.LD_PARAMETER
   WHERE PARAMETER_ID = 'TRG_RESTRICT_SERVNUEV';

   IF (NUNUMERIC_VALUE <> 1) THEN
      ROLLBACK;
      RETURN;
   END IF;

   /*
     Excluimos los tipos de ordenes que no son de servicios nuevos
     12149 - CONSTRUCCION DE INSTALACION INTERNA RESIDENCIAL
     12150 - CARGO POR CONEXION RESIDENCIAL
     12162 - INSPECCION Y/O CERTIFICACION INSTALACIONES
     10273 - VERIFICAR/REALIZAR ACOMETIDA X CONTRATISTA
     11144 - CORRECCION DOCUMENTOS Y/O FALLA TECNICA
   */
   IF :OLD.TASK_TYPE_ID NOT IN (12149,12150,12162,11144,10273) THEN
     ROLLBACK;
     RETURN;
   END IF;

   /* Si la orden no esta sufriendo cambio en los campos que interesan, continua */
   IF UPDATING AND :OLD.TASK_TYPE_ID = :NEW.TASK_TYPE_ID AND :OLD.ORDER_STATUS_ID = :NEW.ORDER_STATUS_ID AND :OLD.CAUSAL_ID = :NEW.CAUSAL_ID AND :OLD.CAUSAL_ID IS NOT NULL AND :NEW.CAUSAL_ID IS NOT NULL THEN
     ROLLBACK;
     RETURN;
   END IF;
   IF UPDATING AND :OLD.TASK_TYPE_ID = :NEW.TASK_TYPE_ID AND :OLD.ORDER_STATUS_ID = :NEW.ORDER_STATUS_ID AND :OLD.CAUSAL_ID IS NULL AND :NEW.CAUSAL_ID IS NULL THEN
     ROLLBACK;
     RETURN;
   END IF;

   /* Se permite la anulacion de cualquier tipo de OT */
   IF :NEW.ORDER_STATUS_ID = 12 THEN
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

   /* Se permite modificacion si contrato no es plan comercial 4,36 o 41, o si el tipo de solicitud no es 271 Venta de gas por formulario */
   IF NUCOMERCIAL_PLAN IS NULL OR NUPACKAGE_TYPE_ID IS NULL THEN
     ROLLBACK;
     RETURN;
   ELSIF NUCOMERCIAL_PLAN NOT IN (4,36,41) OR NUPACKAGE_TYPE_ID <> 271 THEN
     ROLLBACK;
     RETURN;
   END IF;


   SELECT COUNT(1)
   INTO COUNT_COMMERCIAL_PLA
   FROM DUAL
   WHERE NUCOMERCIAL_PLAN IN
   (SELECT TO_NUMBER(COLUMN_VALUE)
    FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS((
      SELECT STRING_VALUE
      FROM OPEN.LD_PARAMETER_INNOVA
      WHERE PARAMETER_ID = 'COD_COMMERCIAL_PLAN'
      AND ACTIVE = 'Y'),
      ','))
   );


   /* Se valida que el Plan Comercial se encuentre configurado entre los parámetros de LD_PARAMETER_INNOVA COD_COMMERCIAL_PLAN */
   IF COUNT_COMMERCIAL_PLA IS NULL OR COUNT_COMMERCIAL_PLA < 1 THEN
   	 ROLLBACK;
     RETURN;
   END IF;

   /* Se permiten solicitudes no gestionadas desde Camunda */
   BEGIN
     SELECT PACKAGE_ID
     INTO NUPACKAGE_CAMUNDA
     FROM OPEN.LDCI_PACKAGE_CAMUNDA_LOG
     WHERE PACKAGE_ID = NUPACKAGE_ID;

     EXCEPTION
     WHEN NO_DATA_FOUND THEN
       ROLLBACK;
       RETURN;
   END;

   /* Se permite la creacion de la OT de Interna */
   IF :NEW.TASK_TYPE_ID = 12149 AND :NEW.ORDER_STATUS_ID = 0 AND INSERTING THEN
     ROLLBACK;
     RETURN;
   END IF;

   /* Se permite la asignacion de la OT de Interna */
   IF :OLD.TASK_TYPE_ID = 12149 AND :OLD.ORDER_STATUS_ID = 0 AND :NEW.ORDER_STATUS_ID = 5 THEN
     ROLLBACK;
     RETURN;
   END IF;

   /* Se permite la legalizacion de OT de Interna unicamente con causal de exito */
   IF :OLD.TASK_TYPE_ID = 12149 AND :OLD.ORDER_STATUS_ID = 7 AND :NEW.ORDER_STATUS_ID = 8 AND :NEW.CAUSAL_ID = 9944 THEN
     ROLLBACK;
     RETURN;
   END IF;

   /* Se permite el desbloqueo de la OT de Interna para plan comercial 4*/
   IF :OLD.TASK_TYPE_ID = 12149 AND :OLD.ORDER_STATUS_ID = 11 AND :NEW.ORDER_STATUS_ID = 0 AND NUCOMERCIAL_PLAN = 4  THEN
     ROLLBACK;
     RETURN;
   END IF;

   /* Se permite la creacion de OT de Acometida para plan comercial 36*/
   IF :OLD.TASK_TYPE_ID = 10273 AND (:NEW.ORDER_STATUS_ID = 0 OR :NEW.ORDER_STATUS_ID = 11) AND NUCOMERCIAL_PLAN = 36 THEN
     ROLLBACK;
     RETURN;
   END IF;

   /* Se permite el desbloqueo de la OT de Acometida para plan comercial 36*/
   IF :OLD.TASK_TYPE_ID = 10273 AND :OLD.ORDER_STATUS_ID = 11 AND :NEW.ORDER_STATUS_ID = 0 AND NUCOMERCIAL_PLAN = 36  THEN
     ROLLBACK;
     RETURN;
   END IF;

   /* Se permite la asignacion de la OT de Acometida para plan comercial 36 y 41*/
   IF :OLD.TASK_TYPE_ID = 10273 AND :OLD.ORDER_STATUS_ID = 0 AND :NEW.ORDER_STATUS_ID = 5 AND NUCOMERCIAL_PLAN <> 4  THEN
     ROLLBACK;
     RETURN;
   END IF;

   /* Se permite la legalizacion de OT de Acometida con causal de exito o PREDIO CUENTA CON ACOMETIDA */
   IF :OLD.TASK_TYPE_ID = 10273 AND :OLD.ORDER_STATUS_ID = 7 AND :NEW.ORDER_STATUS_ID = 8 AND :NEW.CAUSAL_ID IN (9944, 3675) THEN
     ROLLBACK;
     RETURN;
   END IF;

   /* Se permite la legalizacion de OT de Puesta en Servicio unicamente con causal de exito */
   IF :OLD.TASK_TYPE_ID = 12150 AND :OLD.ORDER_STATUS_ID = 7 AND :NEW.ORDER_STATUS_ID = 8 AND :NEW.CAUSAL_ID = 9944 THEN
     ROLLBACK;
     RETURN;
   END IF;

   /* Se permite la ejecucion de OT de Certificacion. */
   IF :OLD.TASK_TYPE_ID = 12162 AND :OLD.ORDER_STATUS_ID = 5 AND :NEW.ORDER_STATUS_ID = 7 THEN
     ROLLBACK;
     RETURN;
   END IF;

   /* Se permite la legalizacion de OT de Certificacion unicamente con causal de exito, falla documental o tecnica */
   IF :OLD.TASK_TYPE_ID = 12162 AND :OLD.ORDER_STATUS_ID = 7 AND :NEW.ORDER_STATUS_ID = 8 AND :NEW.CAUSAL_ID IN (9944, 3671, 3672) THEN
     ROLLBACK;
     RETURN;
   END IF;

   /* Se permite la legalizacion de OT de Correccion de Interna */
   IF :OLD.TASK_TYPE_ID = 11144 AND :OLD.ORDER_STATUS_ID = 7 AND :NEW.ORDER_STATUS_ID = 8 AND :NEW.CAUSAL_ID IN (9944, 1) THEN
     ROLLBACK;
     RETURN;
   END IF;

   /* Restringimos el usuario de BD para que unicamente el usuario de INNOVACION pueda realizar esta accion */
   IF USER = USR_INNOVACION THEN
     ROLLBACK;
     RETURN;
   END IF;

   /* Se permite realizar AIOSA y/o MIOSA */
   IF ut_session.getmodule IN ('LDCAIOSA', 'LDCMIOSA','AIOSA', 'MIOSA') THEN
      ROLLBACK;
      RETURN;
   END IF;

   IF INSERTING THEN
     ACCION_ := 'I';
   ELSIF UPDATING THEN
     ACCION_ := 'U';
   END IF;

   insert into OPEN.LDCI_SERVNUEV_LOG_OR_ORDER ( ORDER_ID, ACCION, TASK_TYPE_ID_OLD, TASK_TYPE_ID_NEW, ORDER_STATUS_ID_OLD, ORDER_STATUS_ID_NEW, CAUSAL_ID_OLD, CAUSAL_ID_NEW, SYSDATE_, USERMASK, USER_)
   values ( :NEW.ORDER_ID, ACCION_, :OLD.TASK_TYPE_ID, :NEW.TASK_TYPE_ID, :OLD.ORDER_STATUS_ID, :NEW.ORDER_STATUS_ID, :OLD.CAUSAL_ID, :NEW.CAUSAL_ID, SYSDATE, AU_BOSystem.getSystemUserMask, USER);
   commit;

   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
   'Esta accion no esta permitida en Smartflex. Este cambio debe ser realizado desde el flujo de Camunda por el usuario INNOVACION' );
   raise ex.CONTROLLED_ERROR;

 END;
/
