CREATE OR REPLACE TRIGGER ADM_PERSON.TRGBIURLD_VALIDITY_POLICY_TYPE
BEFORE INSERT OR UPDATE OF POLICY_VALUE, SHARE_VALUE, COVERAGE_MONTH, INITIAL_DATE, FINAL_DATE
ON Ld_Validity_Policy_Type
REFERENCING OLD AS old NEW AS new
FOR EACH ROW

/*******************************************************************************
 Propiedad intelectual de Open International Systems. (c).

 Trigger       : trgBiurLd_Validity_Policy_Type

 Descripcion   : Trigger que calcula el Valor de la Cuota de la Poliza.
                 Adicionalmente garantiza que la Fecha Inicial de Vigencia no
                 tenga Horas y que la Fecha Final de Vigencia tenga la maxima
                 Hora del dia.
                 Tambien valida que en el Valor del Tipo de Poliza, Valor de
                 la Cuota y Meses de Cobertura no se permita registrar valores
                 negativos.

 Autor         : Juan Carlos Castro Prado
 Fecha         : 13-Ago-2013

 Historia de Modificaciones
 Fecha        IDEntrega             Modificacion
 16-Dic-2013  jrobayo.SAO227672     Se modifica para garantizar que las fechas ingresadas
                                    en la forma LDCTL sean las almacenadas en el registro
                                    de vigencia por tipo de poliza.
 31-Ago-2013  jcarrillo.sao216037   Se valida que no se pueda modificar la fecha
                                    final de la vigencia menor a la del sistema
                                    si tiene polizas asociadas
 13-Ago-2013  jcastroSAO214426   Creacion.
*******************************************************************************/
DECLARE
    cnuGeneric_Error CONSTANT NUMBER := 2741; -- Error generico
    tbPolicys        dald_policy.tytbLD_POLICY;
BEGIN
--{
    -- Garantiza que la Fecha Inicial de Vigencia no tenga Horas
    :new.INITIAL_DATE := to_date(:new.INITIAL_DATE);

    -- Garantiza que la Fecha Final de Vigencia tenga la maxima Hora del dia
    :new.FINAL_DATE := to_date (:new.FINAL_DATE);

    -- Valida que el numero de Meses de Cobertura de la Poliza sea mayor a Cero

    IF (:new.COVERAGE_MONTH <= 0) THEN
    --{
        GI_BOERRORS.SETERRORCODEARGUMENT (cnuGeneric_Error,
                                         'Los Meses de Cobertura deben ser mayores a Cero.');
        RAISE ex.controlled_error;
    --}
    END IF;

    -- Valida que el Valor Total de la Poliza no sea menor a Cero

    IF (:new.POLICY_VALUE < 0) THEN
    --{
        GI_BOERRORS.SETERRORCODEARGUMENT (cnuGeneric_Error,
                                         'El Valor para el Tipo de Poliza no puede ser menor a Cero.');
        RAISE ex.controlled_error;
    --}
    END IF;

    -- Valida que el Valor de la Cuota digitado no sea menor a Cero

    IF (:new.SHARE_VALUE < 0) THEN
    --{
        GI_BOERRORS.SETERRORCODEARGUMENT (cnuGeneric_Error,
                                         'El Valor de la Cuota no puede ser menor a Cero.');
        RAISE ex.controlled_error;
    --}
    END IF;

    -- Valida que el Valor de la Cuota digitado corresponda con el valor calculado

    IF (round (:new.SHARE_VALUE) != round (trunc (:new.POLICY_VALUE / :new.COVERAGE_MONTH, 2))) THEN
    --{
        GI_BOERRORS.SETERRORCODEARGUMENT (cnuGeneric_Error,
                                         'El Valor digitado de la Cuota ($ ' || :new.SHARE_VALUE || ') no es correcto, ' ||
                                         'ya que no corresponde al valor calculado que es de $ ' ||
                                         trunc (:new.POLICY_VALUE / :new.COVERAGE_MONTH, 2));
        RAISE ex.controlled_error;
    --}
    END IF;

    -- Si se esta actualizando se valida que la nueva fecha final no sea menor a la
    -- del sistema, siempre y cuando esta se haya modificado
    if( updating
        AND :NEW.FINAL_DATE != :OLD.FINAL_DATE
        AND :NEW.FINAL_DATE < sysdate )
    then
        -- Consulta las polizas para la vigencia
        ld_bcsecuremanagement.GetPolicysByVality
        (
            :NEW.validity_policy_type_id,
            tbPolicys
        );

        -- Si existen polizas se levanta error indicando que la fecha final no puede
        -- ser menor a la del sistema
        if(tbPolicys.count > 0)
        then
            GI_BOERRORS.SETERRORCODEARGUMENT
            (
                cnuGeneric_Error,
                'La fecha final de la vigencia ['||:NEW.validity_policy_type_id||'] no puede ser menor a la fecha del sistema. ' ||
                'Existen polizas asociadas a la vigencia.'
            );
            RAISE ex.controlled_error;
        end if;
    end if;

    if(updating)
    then
        if ((:NEW.INITIAL_DATE != :OLD.INITIAL_DATE) OR
            (:NEW.POLICY_VALUE != :OLD.POLICY_VALUE) OR
            (:NEW.COVERAGE_MONTH != :OLD.COVERAGE_MONTH) OR
            (:NEW.SHARE_VALUE != :OLD.SHARE_VALUE) OR
            (:NEW.COMMISSION_PERC != :OLD.COMMISSION_PERC))
        then

            -- Consulta las polizas para la vigencia
            ld_bcsecuremanagement.GetPolicysByVality
            (
                :NEW.validity_policy_type_id,
                tbPolicys
            );

            if(tbPolicys.count > 0)
            then
                GI_BOERRORS.SETERRORCODEARGUMENT
                (
                    cnuGeneric_Error,
                    'No se pueden modificar los datos de la vigencia ['||:NEW.validity_policy_type_id||']. ' ||
                    'Existen polizas asociadas a la vigencia.'
                );
                RAISE ex.controlled_error;
            END IF;
        end if;
    end if;

    -- Calcula y asigna el Valor de la Cuota
    :new.SHARE_VALUE := trunc (:new.POLICY_VALUE / :new.COVERAGE_MONTH, 2);

EXCEPTION
  when ex.CONTROLLED_ERROR then
    raise ex.CONTROLLED_ERROR;

  when others then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;
--}
END TRGBIURLD_VALIDITY_POLICY_TYPE;
/
