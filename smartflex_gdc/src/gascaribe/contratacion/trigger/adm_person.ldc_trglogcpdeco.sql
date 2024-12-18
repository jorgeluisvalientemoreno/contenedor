CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGLOGCPDECO
BEFORE DELETE OR INSERT OR UPDATE ON LDC_COPRDECO
FOR EACH ROW
 /*****************************************************************
  Propiedad intelectual de Gases del caribe.

  Unidad         : LDC_TRGLOGCPDECO
  Descripcion    : trigger para llenar log
  Autor          : Luis Javier Lopez
  Tichet         : 874
  Fecha          : 20/10/2021

  Parametros         Descripcion
  ============   ===================

  Historia de Modificaciones
  Fecha            Autor       Modificacion
  =========      =========  ====================
  ******************************************************************/
DECLARE
  sbOperacion VARCHAR2(1);
BEGIN
  IF INSERTING OR UPDATING THEN
    :new.CODCFERE := sysdate;
    :new.CODCUSUA := user;
  END IF;

  IF INSERTING THEN
     sbOperacion := 'I';
       INSERT INTO LDC_LOGCOPRDECO  (
          CODCCOAC, CODCCOAN, CODCPRAC, CODCPRAN, CODCOPER, CODCFERE, CODCUSUA
        )
        VALUES
        (
          :NEW.CODCCONC, NULL, :NEW.CODCPRIOR, NULL, sbOperacion, SYSDATE, USER
        );
  ELSIF UPDATING THEN
    sbOperacion := 'U';
     INSERT INTO LDC_LOGCOPRDECO  (
          CODCCOAC, CODCCOAN, CODCPRAC, CODCPRAN, CODCOPER, CODCFERE, CODCUSUA
        )
        VALUES
        (
          :NEW.CODCCONC, :OLD.CODCCONC, :NEW.CODCPRIOR, :OLD.CODCPRIOR, sbOperacion, SYSDATE, USER
        );
  ELSE
    sbOperacion := 'D';
    INSERT INTO LDC_LOGCOPRDECO  (
          CODCCOAC, CODCCOAN, CODCPRAC, CODCPRAN, CODCOPER, CODCFERE, CODCUSUA
        )
        VALUES
        (
          :OLD.CODCCONC, :NEW.CODCCONC, :OLD.CODCPRIOR, :NEW.CODCPRIOR, sbOperacion, SYSDATE, USER
        );
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    ERRORS.SETERROR;
    raise ex.CONTROLLED_ERROR;
END;
/
