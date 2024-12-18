CREATE OR REPLACE TRIGGER ADM_PERSON.TGR_LOG_INSOLVENCIA
AFTER INSERT OR UPDATE OR DELETE ON LDC_INSOLVENCIA
FOR EACH ROW
/**************************************************************************
    Autor       :
    Fecha       : 21/03/2020
    Ticket      : 80
    Descripción: Trigger para almacenar un log de la tabla LDC_INSOLVENCIA

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
***************************************************************************/
DECLARE

    sbEntrega VARCHAR2(100) := '0000080';
    rwLogInsolvencia LDC_LOG_INSOLVENCIA%rowtype;
    sbUser VARCHAR2(100);
    sbTerminal VARCHAR2(500);

BEGIN
    ut_trace.trace('Inicio TGR_LOG_INSOLVENCIA',10);

    IF fblaplicaentregaxcaso(sbEntrega) THEN

        sbUser := sys_context('userenv','CURRENT_USER');
        sbTerminal := sys_context('userenv','terminal');

        IF INSERTING THEN

            rwLogInsolvencia.ID := SEQ_LDC_LOG_INSOLVENCIA.nextval;
            rwLogInsolvencia.ID_INSOLVENCIA := :NEW.ID;
            rwLogInsolvencia.USUARIO := sbUser;
            rwLogInsolvencia.FECHA := TO_CHAR(SYSDATE);
            rwLogInsolvencia.OPERACION := 'I';
            rwLogInsolvencia.EN_INSOLVENCIA_OLD := :OLD.EN_INSOLVENCIA;
            rwLogInsolvencia.EN_INSOLVENCIA_NEW := :NEW.EN_INSOLVENCIA;
            rwLogInsolvencia.FECHA_INICIO_INSOLVENCIA_OLD := :OLD.FECHA_INICIO;
            rwLogInsolvencia.FECHA_INICIO_INSOLVENCIA_NEW := :NEW.FECHA_INICIO;
            rwLogInsolvencia.FECHA_FINAL_INSOLVENCIA_OLD := :OLD.FECHA_FIN;
            rwLogInsolvencia.FECHA_FINAL_INSOLVENCIA_NEW := :NEW.FECHA_FIN;
            rwLogInsolvencia.COMENTARIO_OLD := :OLD.COMENTARIO;
            rwLogInsolvencia.COMENTARIO_NEW := :NEW.COMENTARIO;
            rwLogInsolvencia.TERMINAL := sbTerminal;

            INSERT INTO LDC_LOG_INSOLVENCIA VALUES rwLogInsolvencia;

        END IF;

        IF UPDATING THEN

            rwLogInsolvencia.ID := SEQ_LDC_LOG_INSOLVENCIA.nextval;
            rwLogInsolvencia.ID_INSOLVENCIA := :OLD.ID;
            rwLogInsolvencia.USUARIO := sbUser;
            rwLogInsolvencia.FECHA := TO_CHAR(SYSDATE);
            rwLogInsolvencia.OPERACION := 'U';
            rwLogInsolvencia.EN_INSOLVENCIA_OLD := :OLD.EN_INSOLVENCIA;
            rwLogInsolvencia.EN_INSOLVENCIA_NEW := :NEW.EN_INSOLVENCIA;
            rwLogInsolvencia.FECHA_INICIO_INSOLVENCIA_OLD := :OLD.FECHA_INICIO;
            rwLogInsolvencia.FECHA_INICIO_INSOLVENCIA_NEW := :NEW.FECHA_INICIO;
            rwLogInsolvencia.FECHA_FINAL_INSOLVENCIA_OLD := :OLD.FECHA_FIN;
            rwLogInsolvencia.FECHA_FINAL_INSOLVENCIA_NEW := :NEW.FECHA_FIN;
            rwLogInsolvencia.COMENTARIO_OLD := :OLD.COMENTARIO;
            rwLogInsolvencia.COMENTARIO_NEW := :NEW.COMENTARIO;
            rwLogInsolvencia.TERMINAL := sbTerminal;

            INSERT INTO LDC_LOG_INSOLVENCIA VALUES rwLogInsolvencia;

        END IF;

        IF DELETING THEN

            rwLogInsolvencia.ID := SEQ_LDC_LOG_INSOLVENCIA.nextval;
            rwLogInsolvencia.ID_INSOLVENCIA := :OLD.ID;
            rwLogInsolvencia.USUARIO := sbUser;
            rwLogInsolvencia.FECHA := TO_CHAR(SYSDATE);
            rwLogInsolvencia.OPERACION := 'U';
            rwLogInsolvencia.EN_INSOLVENCIA_OLD := :OLD.EN_INSOLVENCIA;
            rwLogInsolvencia.EN_INSOLVENCIA_NEW := :NEW.EN_INSOLVENCIA;
            rwLogInsolvencia.FECHA_INICIO_INSOLVENCIA_OLD := :OLD.FECHA_INICIO;
            rwLogInsolvencia.FECHA_INICIO_INSOLVENCIA_NEW := :NEW.FECHA_INICIO;
            rwLogInsolvencia.FECHA_FINAL_INSOLVENCIA_OLD := :OLD.FECHA_FIN;
            rwLogInsolvencia.FECHA_FINAL_INSOLVENCIA_NEW := :NEW.FECHA_FIN;
            rwLogInsolvencia.COMENTARIO_OLD := :OLD.COMENTARIO;
            rwLogInsolvencia.COMENTARIO_NEW := :NEW.COMENTARIO;
            rwLogInsolvencia.TERMINAL := sbTerminal;

            INSERT INTO LDC_LOG_INSOLVENCIA VALUES rwLogInsolvencia;

        END IF;
    END IF;

	ut_trace.trace('Fin TGR_LOG_INSOLVENCIA',10);
EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
        RAISE ex.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        Errors.setError;
        RAISE ex.CONTROLLED_ERROR;

END TGR_LOG_INSOLVENCIA;
/
