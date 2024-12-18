CREATE OR REPLACE trigger ADM_PERSON.TRG_BEF_UPD_LD_SEND_AUTHORIZE
  before update on ld_send_authorized
  for each row
/*******************************************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: TRG_BEF_UPD_LD_SEND_AUTHORIZE
        Descripción:        Se ejecuta antes de actualizar en LD_SEND_AUTHORIZED

        Autor    : Sandra Muñoz
        Fecha    : 14-10-2016

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------------------------
        14-10-2016   Sandra Muñoz           Creación
        *******************************************************************************************/
BEGIN
    DECLARE
        csbBSS_CAR_SMS_200792 VARCHAR2(30) := 'BSS_CAR_SMS_200792_1'; -- Entrega aplicada
        sbError               ge_error_log.description%TYPE; -- Error
    BEGIN
        UT_TRACE.TRACE('INICIO TRG_BEF_UPD_LD_SEND_AUTHORIZE', 1);
        UT_TRACE.TRACE(SYS_CONTEXT('USERENV', 'MODULE'), 1);
        IF NOT fblaplicaentrega(csbBSS_CAR_SMS_200792) AND
           SYS_CONTEXT('USERENV', 'MODULE') IN ('CRCAC', 'FWCMD') THEN
            UT_TRACE.TRACE('Entrega ' || csbBSS_CAR_SMS_200792 || ' NO aplicada', 1);
            IF :OLD.TIPO_RESPONSABLE <> :new.TIPO_RESPONSABLE THEN
                sbError := 'Para poder actualizar el tipo de responsable debe tener aplicada la entrega ' ||
                           csbBSS_CAR_SMS_200792;
                RAISE ex.Controlled_Error;
            END IF;
        ELSE
            UT_TRACE.TRACE('Entrega ' || csbBSS_CAR_SMS_200792 || ' aplicada', 1);
        END IF;
       :NEW.MODIF_DATE := SYSDATE;
       :NEW.MODIF_USER_ID := USER;

        UT_TRACE.TRACE('FIN TRG_BEF_UPD_LD_SEND_AUTHORIZE', 1);
    EXCEPTION
        WHEN ex.Controlled_Error THEN
            errors.seterror(Ld_Boconstans.cnuGeneric_Error, sbError);
            RAISE;
        WHEN OTHERS THEN
            sbError := 'TERMINÿ CON ERROR NO CONTROLADO  TRG_BEF_UPD_LD_SEND_AUTHORIZE' || SQLERRM;
            ut_trace.trace(sbError);
            dbms_output.put_line(sbError);
            errors.seterror(Ld_Boconstans.cnuGeneric_Error, sbError);
    END;
END TRG_BEF_UPD_LD_SEND_AUTHORIZE;
/
