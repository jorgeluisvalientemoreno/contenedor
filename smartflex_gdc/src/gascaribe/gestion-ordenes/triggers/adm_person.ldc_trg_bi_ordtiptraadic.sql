CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_BI_ORDTIPTRAADIC

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_TRG_BI_ORDTIPTRAADIC
    Descripcion    : Este trigger fue generado adicionar el usuario que realiza el registro de los
                     tipos de trabajos a la orden origen de la forma LDCTA
    Autor          : Jorge Valiente
    Fecha          : 19/08/2014

    Historia de Modificaciones
      Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/

  BEFORE INSERT ON LDC_ORDTIPTRAADI
  REFERENCING OLD AS OLD NEW AS NEW
  FOR EACH ROW

DECLARE

  onuerrorcode    number;
  osberrormessage varchar2(4000);

BEGIN

  UT_TRACE.TRACE('INICIO LDC_TRG_BI_ORDTIPTRAADIC', 10);

  :NEW.USER_ID := sa_bouser.fnugetuserid();

  UT_TRACE.TRACE('FIN LDC_TRG_BI_ORDTIPTRAADIC', 10);

EXCEPTION
  WHEN OTHERS THEN
    NULL;

END LDC_TRG_BI_ORDTIPTRAADIC;
/
