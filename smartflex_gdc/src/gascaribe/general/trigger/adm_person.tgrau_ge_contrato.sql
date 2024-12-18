CREATE OR REPLACE TRIGGER ADM_PERSON.TGRAU_GE_CONTRATO 
AFTER UPDATE OF STATUS ON GE_CONTRATO
REFERENCING OLD AS OLD  NEW AS NEW
FOR EACH ROW
/**************************************************************************

      Autor       : Eduardo Cerón / Horbath
      Fecha       : 18/10/2018
      Ticket      : 200-2006
      Descripcion : Valida que el contrato tenga condiciones de pago

      Parametros Entrada

      Valor de salida


      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION

***************************************************************************/
DECLARE

    nuContractId    ge_contrato.id_contrato%type;
    sbStatusNew     ge_contrato.status%type;
    sbStatusOld     ge_contrato.status%type;
    nuExist         number;
    sbErrorMsg      VARCHAR2(4000);

    cursor cuPanByContract(inuContId    IN  ge_contrato.id_contrato%type)
    is
        select  count(1) Cantidad
        from    LDC_CONT_PLAN_COND
        where   LDC_CONT_PLAN_COND.contract_id = inuContId
        and     LDC_CONT_PLAN_COND.PLAN_NAME IS NOT NULL;

BEGIN

    ut_trace.trace('Inicia TGRAU_GE_CONTRATO', 10);

    nuContractId := :NEW.ID_CONTRATO;
    sbStatusNew  := :NEW.STATUS;
    sbStatusOld  := :OLD.STATUS;

    ut_trace.trace('TGRAU_GE_CONTRATO nuContractId '||nuContractId||' sbStatusNew '||sbStatusNew||' sbStatusOld '||sbStatusOld,10);

    -- Se valida si el contrato pasa de estado RG - Registrado a AB - Abierto
    IF sbStatusOld = 'RG' AND sbStatusNew = 'AB' THEN
        -- Se valida si el contrato tiene configurado el plan de condiciones

        open cuPanByContract(nuContractId);
        fetch cuPanByContract into nuExist;
        close cuPanByContract;

        ut_trace.trace('TGRAU_GE_CONTRATO nuExist '||nuExist, 10);

        IF nuExist = 0 THEN
            sbErrorMsg := 'El contrato ['||nuContractId||'] no tiene configurado una plan de condiciones de pago.';
            Errors.SETMESSAGE(sbErrorMsg);
            RAISE ex.CONTROLLED_ERROR;
        END IF;

    END IF;

    ut_trace.trace('Fin TGRAU_GE_CONTRATO', 10);

EXCEPTION
   WHEN EX.CONTROLLED_ERROR THEN
          RAISE EX.CONTROLLED_ERROR;

    WHEN others THEN
        Errors.setError;
        sbErrorMsg := sqlerrm;
        Errors.SETMESSAGE(sbErrorMsg);
        RAISE EX.CONTROLLED_ERROR;

END;
/
