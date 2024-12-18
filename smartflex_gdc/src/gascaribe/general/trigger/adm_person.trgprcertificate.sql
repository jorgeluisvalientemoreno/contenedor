CREATE OR REPLACE TRIGGER ADM_PERSON.trgPrcertificate
  BEFORE INSERT ON pr_certificate
  FOR EACH ROW
/*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : trgPrcertificate
  Descripcion    : Trigger que llama el metodo qe calcula las fechas
                   para las notificaciones de RP, segun la nueva resolucion.
  Autor          : llozada
  Fecha          : 10/04/2014

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  29/10/2014      Jorge Valiente      RNP1005: Adicionar metodo que permite anular orden
                                               de suspencion al prodcuto al que se le
                                               genero cerificacion.
  ******************************************************************/
DECLARE
  nuErrCode number;
  sbErrMsg  VARCHAR2(2000);

  ---VARIABLES RNP1005
  SBANULA_ORDEN_SUSPEN_CERT LD_PARAMETER.VALUE_CHAIN%TYPE := DALD_PARAMETER.fsbGetValue_Chain('ANULA_ORDEN_SUSPEN_CERT',
                                                                                              NULL);

  -----------------------------

BEGIN

  ldc_certificate_rp(:new.product_id, null, :new.REVIEW_DATE);

  --RNP1005
  IF NVL(SBANULA_ORDEN_SUSPEN_CERT, 'N') = 'S' THEN
    LDC_BOPERSECUCION.PRANULA_ORDEN_PERSECUCION(:new.product_id);
  END IF;
  --FIN RNP1005

EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    raise;
  WHEN OTHERS THEN
    ERRORS.SETERROR;
    RAISE EX.CONTROLLED_ERROR;

END trgPrcertificate;
/
