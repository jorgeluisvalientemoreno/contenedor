CREATE OR REPLACE TRIGGER adm_person.TRG_AIU_SUBSCRIBER_SMS
AFTER INSERT OR UPDATE ON OPEN.GE_SUBSCRIBER
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
/*****************************************************************
    Propiedad intelectual de GDC.
    Unidad         : TRG_AIU_SUBSCRIBER_SMS
    Caso           : INT-114
    Descripcion    : Trigger para enviar Notificacion SMS y Whatsapp a los celulares registrados
    Autor          : Jose Donado
    Fecha          : 22/07/2022

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    17/10/2024      lubin.pineda		OSF-3450: Se migra a ADM_PERSON  	
  ******************************************************************/

DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;
  USR_INNOVACION    VARCHAR2(10) := 'INNOVACION';
  nuIsActiveSMS     NUMBER(1);
  nuIsActiveWA      NUMBER(1);
  sbAccion          VARCHAR(1);
  sbMsgAccion       VARCHAR(20);
  sbUsuarioOSF      VARCHAR2(50);
  sbCategorias      OPEN.LD_PARAMETER.VALUE_CHAIN%TYPE;
  sbTipoServ        OPEN.LD_PARAMETER.VALUE_CHAIN%TYPE;
  nuIsValid         OPEN.GE_SUBSCRIBER.SUBSCRIBER_ID%TYPE;
  sbMsg             CLOB;
  sbParametros      CLOB;

  sbIdDirecciones   CLOB := '';
  sbDirecciones     CLOB := ' para las siguientes direcciones: ';
  nuContDir         NUMBER(10) := 0;

  onuErrorCode      NUMBER(10);
  osbErrorMessage   VARCHAR2(4000);
  clRespuesta       CLOB;

  CURSOR cuValidaCliente(idCliente OPEN.GE_SUBSCRIBER.SUBSCRIBER_ID%TYPE,
                         sbCateg OPEN.LD_PARAMETER.VALUE_CHAIN%TYPE,
                         sbServicios OPEN.LD_PARAMETER.VALUE_CHAIN%TYPE) IS
  SELECT S.SUSCCODI, SE.SESUNUSE, S.SUSCIDDI
  FROM OPEN.SUSCRIPC S

  INNER JOIN OPEN.SERVSUSC SE
  ON(SE.SESUSUSC = S.SUSCCODI)

  WHERE S.SUSCCLIE = idCliente
        AND SE.SESUSERV IN(SELECT regexp_substr(sbServicios,'[^,]+', 1, LEVEL)
                           FROM dual
                           CONNECT BY regexp_substr(sbServicios, '[^,]+', 1, LEVEL) IS NOT NULL)
        AND SE.SESUCATE IN(SELECT regexp_substr(sbCateg,'[^,]+', 1, LEVEL)
                           FROM dual
                           CONNECT BY regexp_substr(sbCateg, '[^,]+', 1, LEVEL) IS NOT NULL)
        AND ROWNUM <= 5;

  CURSOR cuDirecciones(sbDirs CLOB) IS
  SELECT A.ADDRESS_ID, A.ADDRESS
  FROM OPEN.AB_ADDRESS A
  WHERE A.ADDRESS_ID IN(SELECT regexp_substr(TO_CHAR(sbDirs),'[^,]+', 1, LEVEL)
                        FROM dual
                        CONNECT BY regexp_substr(TO_CHAR(sbDirs), '[^,]+', 1, LEVEL) IS NOT NULL);

  rgValidaCliente  cuValidaCliente%ROWTYPE;
  rgDirecciones    cuDirecciones%ROWTYPE;

 BEGIN
   /*
   Condiciones para la activación del Trigger
    1. El cliente debe tener un contrato asociado Brilla o Gas, ya que ha firmado contrato de condiciones uniformes
    2. Cliente sin contrato asociado no debe ser notificado
    3. Solo se notificara a clientes con contrato de categoria residencial
    4. Se enviara un unico mensaje de texto por cliente, independientemente de los contratos que tenga asociados
   */

   sbUsuarioOSF := USER;

   nuIsActiveSMS   := OPEN.DALD_PARAMETER.fnuGetNumeric_Value('TRG_SUBSCRIBER_SMS', NULL);
   nuIsActiveWA    := OPEN.DALD_PARAMETER.fnuGetNumeric_Value('TRG_SUBSCRIBER_WA', NULL);
   sbCategorias    := OPEN.DALD_PARAMETER.fsbGetValue_Chain('TRG_SUBSCRIBER_SMS_CATEG', NULL);
   sbTipoServ      := OPEN.DALD_PARAMETER.fsbGetValue_Chain('TRG_SUBSCRIBER_SMS_SERV', NULL);
   sbMsg           := OPEN.DALD_PARAMETER.fsbGetValue_Chain('TRG_SUBSCRIBER_SMS_MSG', NULL);

   --Valida parametro de trigger activo
   IF (nvl(nuIsActiveSMS,0) <> 1) AND (nvl(nuIsActiveWA,0) <> 1) THEN
      ROLLBACK;
      RETURN;
   END IF;

   --Valida parametro de categorias
   IF sbCategorias IS NULL THEN
      ROLLBACK;
      RETURN;
   END IF;

   --Valida parametro de servicios
   IF sbTipoServ IS NULL THEN
      ROLLBACK;
      RETURN;
   END IF;

   --Valida que el cliente cumpla con las condiciones establecidas
   FOR rgValidaCliente IN cuValidaCliente(:NEW.subscriber_id, sbCategorias, sbTipoServ)
     LOOP
       sbIdDirecciones := sbIdDirecciones || rgValidaCliente.SUSCIDDI || ',';
       nuContDir := nuContDir + 1;
   END LOOP;

   IF nuContDir = 0 THEN
      ROLLBACK;
      RETURN;
   END IF;

   IF nuContDir <= 2 THEN

     FOR rgDirecciones IN cuDirecciones(sbIdDirecciones)
       LOOP
         sbDirecciones := sbDirecciones || REGEXP_REPLACE(rgDirecciones.ADDRESS,'^(.*)(.{5})$','\1*****') || ', ';
     END LOOP;

   ELSE
     sbDirecciones := ', ';
   END IF;


   IF INSERTING THEN
     sbAccion := 'I';
     sbMsgAccion := 'insercion';
   ELSIF UPDATING THEN
     sbAccion := 'U';
     sbMsgAccion := 'actualizacion';
   END IF;

   --Valida que se este ingresando informacion de numero celular para poder invocar la logica de envio de mensajes
   IF (:NEW.PHONE IS NULL) THEN
     ROLLBACK;
     RETURN;
   END IF;

   IF (LENGTH(TRIM(:NEW.PHONE)) < 10) THEN
     ROLLBACK;
     RETURN;
   END IF;

   IF (sbAccion = 'U' And :NEW.PHONE = :OLD.PHONE) THEN
     ROLLBACK;
     RETURN;
   END IF;

   sbMsg := REPLACE(sbMsg,'{{1}}',:NEW.SUBSCRIBER_NAME || ' ' || :NEW.SUBS_LAST_NAME);--Reemplaza el nombre en la plantilla
   sbMsg := REPLACE(sbMsg,'{{2}}', sbDirecciones);--Reemplaza la dirección la plantilla

   --Envio de SMS a lista de celulares asociados al cliente
   IF (nvl(nuIsActiveSMS,0) = 1) THEN
     "OPEN".LDCI_PKCRMSMS.PROENVIASMS(:NEW.subscriber_id,:NEW.PHONE,sbMsg,clRespuesta,onuErrorCode,osbErrorMessage);
   END IF;

   --Envio de Whatsapp a lista de celulares asociados al cliente
   IF (nvl(nuIsActiveWA,0) = 1) THEN
     sbParametros := :NEW.SUBSCRIBER_NAME || ' ' || :NEW.SUBS_LAST_NAME;
     sbParametros := REGEXP_REPLACE(sbParametros,'[|]','');--Quita el caracter | de la cadena, ya que sera usado como separador de parametros

     sbDirecciones := REGEXP_REPLACE(sbDirecciones,'[|]','');--Quita el caracter | de la cadena, ya que sera usado como separador de parametros

     sbParametros := sbParametros || '|' || sbDirecciones;

     "OPEN".LDCI_PKCRMSMS.PROENVIAWHATSAPP(:NEW.subscriber_id,:NEW.PHONE,sbParametros,clRespuesta,onuErrorCode,osbErrorMessage);
   END IF;

EXCEPTION
    WHEN OTHERS THEN
        Errors.setError;
        RAISE ex.CONTROLLED_ERROR;
 END;
/
