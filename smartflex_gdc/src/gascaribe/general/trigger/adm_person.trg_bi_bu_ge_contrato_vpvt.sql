CREATE OR REPLACE TRIGGER ADM_PERSON.TRG_BI_BU_GE_CONTRATO_VPVT
 BEFORE INSERT OR UPDATE ON GE_CONTRATO
  REFERENCING   OLD   AS   OLD   NEW   AS   NEW
 FOR EACH ROW
/*****************************************************************************
    Propiedad intelectual Gases del caribe.

    Trigger  :  TRG_BI_BU_GE_CONTRATO_VPVT

    Descripcion  : Valida que el valor pagado no exceda el valor total del contrato

    Autor  : Nivis Luz Carrasquilla Zuñiga
    Fecha  : 22-02-2016

    Historia de Modificaciones

    Fecha       Autor           Cambio
    ----------  ------------    ---------------------------
    21/10/2024  jpinedc         OSF-3450: Se migra a ADM_PERSON
  *******************************************************************************/
DECLARE
BEGIN

  ut_trace.trace('INICIO TRG_BI_BU_GE_CONTRATO_VPVT', 1);
  pkErrors.Push('TRG_BI_BU_GE_CONTRATO_VPVT');

   IF  INSERTING  THEN
       if :NEW.VALOR_TOTAL_CONTRATO < TO_NUMBER(:NEW.VALOR_TOTAL_PAGADO)  THEN
          RAISE_APPLICATION_ERROR(-20996, 'Valor Total a Pagar excede el Valor Total del Contrato que fue aprobado. No se registraran los cambios!!!');
          raise ex.CONTROLLED_ERROR;
       END IF;
   end if;
   IF  UPDATING  THEN
       if :NEW.VALOR_TOTAL_CONTRATO < TO_NUMBER(:NEW.VALOR_TOTAL_PAGADO)  THEN
          RAISE_APPLICATION_ERROR(-20996, 'Valor Total a Pagar excede el Valor Total del Contrato que fue aprobado. No se registraran los cambios!!!');
          raise ex.CONTROLLED_ERROR;
       END IF;
   end if;

  ut_trace.trace('FIN TRG_BI_BU_GE_CONTRATO_VPVT', 1);
  pkErrors.Pop;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise;
  when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;

END TRG_BI_BU_GE_CONTRATO_VPVT;
/
