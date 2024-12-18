CREATE OR REPLACE TRIGGER ADM_PERSON.TRGINSCERTIFICADOSOIA
  BEFORE INSERT ON ldc_certificados_oia
  FOR EACH ROW
/*****************************************************************
   Propiedad intelectual de PETI.

   Unidad         : trgCertificadosOia
   Descripcion    : Trigger que llama el método qe calcula las fechas
                    para las notificaciones de RP, según la nueva resolución.
   Autor          : llozada
   Fecha          : 09/04/2014

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
  SBANULA_ORDEN_SUSPEN_OIA LD_PARAMETER.VALUE_CHAIN%TYPE := DALD_PARAMETER.fsbGetValue_Chain('ANULA_ORDEN_SUSPEN_OIA',
                                                                                             NULL);

  -----------------------------

BEGIN

  ldc_certificate_rp(:new.id_producto, :new.id_contrato, null);

  --RNP1005
  IF NVL(SBANULA_ORDEN_SUSPEN_OIA, 'N') = 'S' THEN
    if :new.resultado_inspeccion = 1 then
      LDC_BOPERSECUCION.PRANULA_ORDEN_PERSECUCION(:new.id_producto);
    end if;
  END If;
  --FIN RNP1005

EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
    raise;
  WHEN OTHERS THEN
    ERRORS.SETERROR;
    RAISE EX.CONTROLLED_ERROR;

END trginsCertificadosOia;
/
