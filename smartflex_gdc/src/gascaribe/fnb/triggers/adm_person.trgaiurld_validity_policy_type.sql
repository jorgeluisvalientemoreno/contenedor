CREATE OR REPLACE TRIGGER ADM_PERSON.TRGAIURLD_VALIDITY_POLICY_TYPE
AFTER INSERT OR UPDATE OF INITIAL_DATE, FINAL_DATE, POLICY_VALUE, SHARE_VALUE, COMMISSION_PERC, COVERAGE_MONTH
ON Ld_Validity_Policy_Type
REFERENCING OLD AS old NEW AS new
FOR EACH ROW

/*******************************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger       :  trgAiurLd_Validity_Policy_Type

Descripcion   : Trigger que valida que en el Valor del Tipo de Poliza, Valor de
                la Cuota, Porcentaje de Comision y Meses de Cobertura no se permita
                registrar valores negativos.
                Ademas valida que la Fecha Final no sea mayor a la Inicial y que
                ninguna de las dos sea menor a la Fecha Actual.
                En el caso de un evento de Actualizacion, valida si la Vigencia
                ya tiene Polizas asociadas para controlar cuales campos se pueden
                modificar y en que forma. En este caso la Fecha Final no puede ser
                menor a la máxima Fecha Inicial de Cobertura de las Polizas asociadas.
                En el caso de un evento de Insercion, se encarga de registrar en
                la tabla Temporal para poder posteriormente realizar la validacion
                de que no haya solapamiento o sobre-posicionamiento de Fechas de
                los registros por Tipo de Poliza.

Autor         : Juan Carlos Castro Prado
Fecha         : 13-Ago-2013

Historia de Modificaciones
    Fecha        IDEntrega          Modificacion
 16-Dic-2013  jrobayo.SAO227672     Se modifica para garantizar que las fechas ingresadas
                                    en la forma LDCTL sean las almacenadas en el registro
                                    de vigencia por tipo de póliza.
13-Ago-2013  jcastroSAO214426   Creacion.
*******************************************************************************/

DECLARE
    cnuGeneric_Error  CONSTANT NUMBER := 2741; -- Error generico
    dtMaxRegPoliza    ld_policy.dtCreate_Policy%TYPE; -- Fecha Inicial de Cobertura maxima
    blExisPolizasAsoc BOOLEAN; -- Existen Polizas asociadas a la Vigencia ?

    -- Cursor para obtener la maxima Fecha Inicial de Cobertura de las Polizas
    -- asociadas a la Vigencia por Tipo de Poliza
    CURSOR cuPolizasAsoc IS
    SELECT dt_in_policy
    FROM   ld_policy
    WHERE  policy_type_id = :old.policy_type_id
    AND    validity_policy_type_id = :old.validity_policy_type_id
    ORDER BY dt_in_policy desc;

BEGIN
--{
    -- Evento de Actualizacion en la tabla

    IF UPDATING THEN
    --{
        -- Obtiene la maxima Fecha Inicial de Cobertura de las Polizas asociadas
        -- a la Vigencia por Tipo de Poliza

        IF (cuPolizasAsoc%ISOPEN) THEN
        --{
            CLOSE cuPolizasAsoc;
        --}
        END IF;

        -- Se asume que existen Polizas asociadas a la Vigencia
        blExisPolizasAsoc := TRUE;

        OPEN  cuPolizasAsoc;
        FETCH cuPolizasAsoc INTO dtMaxRegPoliza;

        IF (cuPolizasAsoc%NOTFOUND) THEN
        --{
            dtMaxRegPoliza := sysdate;
            blExisPolizasAsoc := FALSE;
        --}
        END IF;

        CLOSE cuPolizasAsoc;

        -- Valida si existen Polizas asociadas a la Vigencia por Tipo de Poliza

        IF ( blExisPolizasAsoc ) THEN
        --{
            -- Valida que no se modifique la Fecha Inicial de Vigencia

            IF (:old.INITIAL_DATE != :new.INITIAL_DATE) THEN
            --{
                Gi_BoErrors.SetErrorCodeArgument
                (
                    cnuGeneric_Error,
                    'La Fecha Inicial de Vigencia no puede ser modificada porque ya hay Pólizas asociadas.'
                );
                RAISE ex.controlled_error;
            --}
            END IF;

            -- Valida que la nueva Fecha Final de Vigencia no sea menor a la maxima
            -- Fecha Inicial de Cobertura de las Polizas asociadas al Tipo de Poliza

            IF (:new.FINAL_DATE < dtMaxRegPoliza) THEN
            --{
                Gi_BoErrors.SetErrorCodeArgument
                (
                    cnuGeneric_Error,
                    'La nueva Fecha Final de Vigencia no puede ser menor a la máxima Fecha de Creación ' ||
                    'de las Pólizas asociadas a la Vigencia que es: ' || dtMaxRegPoliza || '.'
                );
                RAISE ex.controlled_error;
            --}
            END IF;

            -- Valida que no se modifique el Valor Total de la Poliza

            IF (:old.POLICY_VALUE != :new.POLICY_VALUE) THEN
            --{
                Gi_BoErrors.SetErrorCodeArgument
                (
                    cnuGeneric_Error,
                    'El Valor Total de la Póliza no puede ser modificado porque ya hay Pólizas asociadas.'
                );
                RAISE ex.controlled_error;
            --}
            END IF;

            -- Valida que no se modifique el Valor de Cuota de la Poliza

            IF (:old.SHARE_VALUE != :new.SHARE_VALUE) THEN
            --{
                Gi_BoErrors.SetErrorCodeArgument
                (
                    cnuGeneric_Error,
                    'El Valor de Cuota de la Póliza no puede ser modificado porque ya hay Pólizas asociadas.'
                );
                RAISE ex.controlled_error;
            --}
            END IF;

            -- Valida que no se modifique el Porcentaje de Comision

            IF (:old.COMMISSION_PERC != :new.COMMISSION_PERC) THEN
            --{
                Gi_BoErrors.SetErrorCodeArgument
                (
                    cnuGeneric_Error,
                    'El Porcentaje de Comisión no puede ser modificado porque ya hay Pólizas asociadas.'
                );
                RAISE ex.controlled_error;
            --}
            END IF;

            -- Valida que no se modifique los Meses de Cobertura de la Poliza

            IF (:old.COVERAGE_MONTH != :new.COVERAGE_MONTH) THEN
            --{
                Gi_BoErrors.SetErrorCodeArgument
                (
                    cnuGeneric_Error,
                    'El número de Meses de Cobertura de la Póliza no puede ser modificado porque ya hay Pólizas asociadas.'
                );
                RAISE ex.controlled_error;
            --}
            END IF;
        --}
        END IF;   -- Fin existen Polizas asociadas

        -- Valida si se modificó la Fecha Inicial

        IF (:old.INITIAL_DATE != :new.INITIAL_DATE) THEN
        --{
            -- Si se modificó valida que no sea menor a la fecha actual

            IF (:new.INITIAL_DATE < sysdate) THEN
            --{
                Gi_BoErrors.SetErrorCodeArgument
                (
                    cnuGeneric_Error,
                    'La Fecha Inicial de Vigencia no puede ser menor a la Fecha Actual del sistema.'
                );
                RAISE ex.controlled_error;
            --}
            END IF;
        --}
        END IF;

        -- Valida si se modificó la Fecha Final

        IF (:old.FINAL_DATE != :new.FINAL_DATE) THEN
        --{
            -- Si se modificó valida que no sea menor a la fecha actual

            IF (:new.FINAL_DATE < sysdate) THEN
            --{
                Gi_BoErrors.SetErrorCodeArgument
                (
                    cnuGeneric_Error,
                    'La Fecha Final de Vigencia no puede ser menor a la Fecha Actual del sistema.'
                );
                RAISE ex.controlled_error;
            --}
            END IF;
        --}
        END IF;
    --}
    END IF;   -- Fin Evento de Actualizacion

    -- Evento de Insercion en la tabla

    IF INSERTING THEN
    --{
        -- Valida que la Fecha Inicial no sea menor a la fecha actual

        IF (:new.INITIAL_DATE < sysdate) THEN
        --{
            Gi_BoErrors.SetErrorCodeArgument
            (
                cnuGeneric_Error,
                'La Fecha Inicial de Vigencia no puede ser menor) a la Fecha Actual del sistema.'
            );
            RAISE ex.controlled_error;
        --}
        END IF;

        -- Valida que la Fecha Final no sea menor a la fecha actual

        IF (:new.FINAL_DATE < sysdate) THEN
        --{
            Gi_BoErrors.SetErrorCodeArgument
            (
                cnuGeneric_Error,
                'La Fecha Final de Vigencia no puede ser menor a la Fecha Actual del sistema.'
            );
            RAISE ex.controlled_error;
        --}
        END IF;
    --}
    END IF;   -- Fin Evento de Insercion

    -- Valida que la Fecha Inicial sea menor a la Fecha Final de Vigencia

    IF (:new.INITIAL_DATE >= :new.FINAL_DATE) THEN
    --{
        Gi_BoErrors.SetErrorCodeArgument
        (
            cnuGeneric_Error,
            'La Fecha Inicial de Vigencia debe ser menor a la Fecha Final de Vigencia.'
        );
        RAISE ex.controlled_error;
    --}
    END IF;

    -- Valida que el Valor Total de la Poliza no sea menor a Cero

    IF (:new.POLICY_VALUE < 0) THEN
    --{
        Gi_BoErrors.SetErrorCodeArgument
        (
            cnuGeneric_Error,
            'El Valor para el Tipo de Poliza no puede ser menor a Cero.'
        );
        RAISE ex.controlled_error;
    --}
    END IF;

    -- Valida que el Valor de la Cuota de la Poliza no sea menor a Cero

    IF (:new.SHARE_VALUE < 0) THEN
    --{
        Gi_BoErrors.SetErrorCodeArgument
        (
            cnuGeneric_Error,
            'El Valor de la Cuota no puede ser menor a Cero.'
        );
        RAISE ex.controlled_error;
    --}
    END IF;

    -- Valida que el Porcentaje de Comision este entre 0% y 100%

    IF (:new.COMMISSION_PERC < 0 OR :new.COMMISSION_PERC > 100) THEN
    --{
        Gi_BoErrors.SetErrorCodeArgument
        (
            cnuGeneric_Error,
            'El Porcentaje de Comision debe estar en el rango entre el 0% y el 100%.'
        );
        RAISE ex.controlled_error;
    --}
    END IF;

    -- Valida que los Meses de Cobertura sean mayores a Cero

    IF (:new.COVERAGE_MONTH <= 0) THEN
    --{
        Gi_BoErrors.SetErrorCodeArgument
        (
            cnuGeneric_Error,
            'Los Meses de Cobertura deben ser mayores a Cero.'
        );
        RAISE ex.controlled_error;
    --}
    END IF;

    -- Evento de Insercion en la tabla

    IF INSERTING THEN
    --{
        -- Inserta el registro de Ld_Validity_Policy_Type que esta siendo registrado
        -- en la tabla Temporal para el posterior control de solapamiento de Fechas

        insert into Ld_Vali_Poli_Type_Temp
        (VALIDITY_POLICY_TYPE_ID, POLICY_TYPE_ID, INITIAL_DATE, FINAL_DATE)
        values
        (:new.VALIDITY_POLICY_TYPE_ID, :new.POLICY_TYPE_ID, :new.INITIAL_DATE, :new.FINAL_DATE);
    --}
    END IF;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;

    when OTHERS then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
--}
END TRGAIURLD_VALIDITY_POLICY_TYPE;
/
