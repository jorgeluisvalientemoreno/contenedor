CREATE OR REPLACE TRIGGER ADM_PERSON.TGR_BI_LDCI_TRANSOMA
BEFORE INSERT ON LDCI_TRANSOMA
/*******************************************************************************
    Propiedad intelectual de CSC

    Trigger 	: TGR_BI_LDCI_TRANSOMA

    Descripcion	: Trigger que permite asignar un valor a la clave primaria si se
                  encuentra que el registro ya existe.

    Autor	   : Eduardo Cer?n
    Fecha	   : 30/06/2019

    Historia de Modificaciones
    Fecha	ID Entrega
    Modificacion

*******************************************************************************/
FOR EACH ROW

DECLARE

    sbEntrega varchar2(100) := 'OSS_CON_EEC_200_2321_GDC_10';

    CURSOR cuExist
    (
        inuCodi     IN      LDCI_TRANSOMA.trsmcodi%TYPE
    )
    IS
        select  count(1)
        from    LDCI_TRANSOMA
        where   LDCI_TRANSOMA.trsmcodi = inuCodi;

    nuCantidad  NUMBER;

BEGIN

    ut_trace.Trace('Inicio: TGR_BI_LDCI_TRANSOMA', 10);
    IF fblaplicaentrega(sbEntrega) THEN

        OPEN cuExist(:new.TRSMCODI);
        FETCH cuExist INTO nuCantidad;
        CLOSE cuExist;
        -- Si ya existe se agrega el nuevo valor de la secuencia
        IF nuCantidad > 0 THEN
            :new.TRSMCODI := GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE('LDCI_TRANSOMA','seq_LDCI_TRANSOMA');
        END IF;
        IF nvl(:OLD.TRSMESTA,0)!=NVL(:NEW.TRSMESTA,0) THEN
           ut_trace.Trace('Estado anterior:'||:OLD.TRSMESTA, 10);
           ut_trace.Trace('Estado NUEVO:'||:new.TRSMESTA, 10);
           ut_trace.Trace('Codgio NUEVO:'||:new.TRSMCODI, 10);
           ut_trace.Trace('USER_:'||user, 10);
           ut_trace.Trace('observacion:'||NVL(:NEW.TRSMOBSE,'-'), 10);
           ut_trace.Trace('terminal:'||NVL(USERENV('TERMINAL'),'--'), 10);

           INSERT INTO LDC_RESULT_PROCESS_PEDIDOVENTA (RESULT_PROCESS_ID, REQUEST_MATERIAL_ID, ESTADO_ANTERIOR, ESTADO_NUEVO, USER_, REGISTER_DATE, COMMENT_, TERMINAL)

             VALUES(SEQ_LDC_RESULT_PROCESS.nextval, :new.TRSMCODI, nvl(:OLD.TRSMESTA,0),:NEW.TRSMESTA, user , SYSDATE, NVL(:NEW.TRSMOBSE,'-'), NVL(USERENV('TERMINAL'),'--'));
             NULL;

        END IF;
    END IF;


    ut_trace.Trace('Fin: TGR_BI_LDCI_TRANSOMA', 10);

EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
          RAISE EX.CONTROLLED_ERROR;
    WHEN others THEN
          errors.seterror;
          RAISE EX.CONTROLLED_ERROR;

END TGR_BI_LDCI_TRANSOMA;
/
