CREATE OR REPLACE TRIGGER ADM_PERSON.LDCTRGBI_COPRAUAC01
    BEFORE INSERT OR UPDATE ON LDC_COPRAUAC
    FOR EACH ROW
DECLARE
    nuGEN_ERROR  NUMBER := 2741;
    sbGEN_MESS   VARCHAR2(200);
    sbCurrentApp VARCHAR2(10);
    sbAPP        VARCHAR2(10) := 'GENOBLIAUT';

BEGIN
    ut_trace.trace(isbmessage => '[ LDCTRGBI_COPRAUAC01', inulevel => 4);

    sbCurrentApp := errors.fsbgetapplication;
    ut_trace.trace(isbmessage => '--<< sbCurrentApp [' || sbCurrentApp || ']', inulevel => 5);

    IF nvl(sbCurrentApp, 'LD_COPRAUAC') != sbAPP
    THEN

        --<< valida fecha de corte
        IF trunc(:NEW.COPAFECO) >= trunc(:NEW.COPAFEGA)
        THEN
            sbGEN_MESS := 'El campo [Fecha de Corte] debe ser al menos un dia antes que la fecha [Fecha Generación Automática].';
            ge_boerrors.seterrorcodeargument(nuGEN_ERROR, sbGEN_MESS);
        END IF;

        --<< Valida fecha preacta
        IF :NEW.COPAFEPR IS NOT NULL
           AND (:NEW.COPAFEPR <= SYSDATE OR :NEW.COPAFEPR >= :NEW.COPAFEGA)
        THEN
            sbGEN_MESS := 'El campo [Fecha Generación Preacta] debe ser menor que la [Fecha Generación Automática] y mayor que la fecha actual.';
            ge_boerrors.seterrorcodeargument(nuGEN_ERROR, sbGEN_MESS);
        END IF;

        --<< valida fecha de generación
        IF :NEW.COPAFEGA < SYSDATE
        THEN
            sbGEN_MESS := 'El campo [Fecha Generación Automática] debe ser mayor que la fecha actual.';
            ge_boerrors.seterrorcodeargument(nuGEN_ERROR, sbGEN_MESS);
        END IF;
    END IF;

    ut_trace.trace(isbmessage => '] LDCTRGBI_COPRAUAC01', inulevel => 4);

EXCEPTION
    WHEN OTHERS THEN
        errors.seterror;
        errors.geterror(nuGEN_ERROR, sbGEN_MESS);
        ut_trace.trace(isbmessage => '] LDCTRGBI_COPRAUAC01 (err). [' || sbGEN_MESS || ']', inulevel => 4);
        RAISE ex.controlled_error;
END LDCTRGBI_COPRAUAC01;
/
