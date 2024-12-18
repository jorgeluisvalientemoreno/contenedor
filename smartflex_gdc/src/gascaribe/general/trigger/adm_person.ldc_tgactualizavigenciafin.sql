CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TGACTUALIZAVIGENCIAFIN BEFORE UPDATE ON LDC_PROCESACONTRATOS
FOR EACH ROW
 /*****************************************************************
    Propiedad intelectual de OLSoftware (c).

    Unidad         : LDC_TGACTUALIZAVIGENCIAFIN
    Descripcion    : actualiza fechas de vigencia
    Autor          : Josh Brito - OLSoftware

    Historia de Modificaciones

    Fecha             Autor             Modificacion
    =========       =========           ====================
    26/04/2020      JBRITO              Creacion.CASO 229
    18/10/2024      jpinedc             OSF-3383: Se migra a ADM_PERSON
    ******************************************************************/
declare
   -- PRAGMA AUTONOMOUS_TRANSACTION;
    nuAnos  number := DALD_PARAMETER.FNUGETNUMERIC_VALUE('PR_ANIOSVIGENCIA',NULL);

BEGIN

  IF UPDATING ('FECHA_INI_VIGENCIA') then
  :NEW.FECHA_FIN_VIGENCIA := add_months(to_date(:NEW.FECHA_INI_VIGENCIA), 12 * nuAnos);
  END IF;

    EXCEPTION
           WHEN EX.CONTROLLED_ERROR THEN
             raise;
           WHEN OTHERS THEN
             ERRORS.SETERROR;
           RAISE EX.CONTROLLED_ERROR;

END LDC_TGACTUALIZAVIGENCIAFIN;
/
