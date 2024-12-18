CREATE OR REPLACE TRIGGER ADM_PERSON.TRGAULD_VALIDITY_POLICY_TYPE
AFTER UPDATE ON Ld_Validity_Policy_Type

/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger       : trgAuLd_Validity_Policy_Type

Descripcion   : Valida que la Vigencia por Tipo de Poliza a actualizar no se
                sobreponga con otros registros del mismo Tipo de Poliza.
                Se hace a nivel de tabla como segunda fase para evitar el error
                de Oracle de seleccion de Tablas Mutantes.

Autor         : Juan Carlos Castro Prado
Fecha         : 18-Ago-2013

Historia de Modificaciones
Fecha        IDEntrega          Modificacion

18-Ago-2013  jcastroSAO214426   Creacion.
**************************************************************/

DECLARE
    cnuGeneric_Error CONSTANT NUMBER := 2741; -- Error generico

    nuConsecut   ld_validity_policy_type.validity_policy_type_id%TYPE;
    nuTipoPoliza ld_validity_policy_type.policy_type_id%TYPE;
    dtInicial    ld_validity_policy_type.initial_date%TYPE;
    dtFinal      ld_validity_policy_type.final_date%TYPE;
    sbDummy      VARCHAR2 (300);

    -- Selecciona los registros a validar que estan registrados en la tabla Temporal
    CURSOR cuTablaTempo IS
    SELECT validity_policy_type_id, policy_type_id, initial_date, final_date
    FROM   Ld_Vali_Poli_Type_Temp
    FOR UPDATE;

    -- Selecciona los registros de la tabla persistente
    CURSOR cuVigeTipoPoli
    (
        nuConsecut   ld_validity_policy_type.validity_policy_type_id%TYPE,
        nuTipoPoliza ld_validity_policy_type.policy_type_id%TYPE,
        dtInicial    ld_validity_policy_type.initial_date%TYPE,
        dtFinal      ld_validity_policy_type.final_date%TYPE
    ) IS
    SELECT 'Consecutivo ' || to_char (VALIDITY_POLICY_TYPE_ID) ||
           ' Tipo de Poliza ' || to_char (POLICY_TYPE_ID) ||
           ' con Vigencia del ' || initial_date || ' al ' || final_date
    FROM   Ld_Validity_Policy_Type
    WHERE  policy_type_id = nuTipoPoliza
    AND    validity_policy_type_id != nuConsecut
    AND    (( dtInicial >= initial_date AND dtInicial <= final_date) OR
            ( dtFinal >= initial_date AND dtFinal <= final_date)     OR
            ( dtInicial >= initial_date AND dtFinal <= final_date)   OR
            ( dtInicial <= initial_date AND dtFinal >= final_date));

BEGIN
--{
    -- Abre el cursor de los registros a validar de la tabla Temporal
    open cuTablaTempo;

    -- Recorre los registros a validar que estan registrados en la tabla Temporal

    LOOP
    --{
        -- Obtiene el registro temporal
        fetch cuTablaTempo into  nuConsecut, nuTipoPoliza, dtInicial, dtFinal;

        -- Valida si hay mas registros para procesar
        exit when cuTablaTempo%notfound;

        -- Abre el cursor de los registros grabados en la tabla persistente
        open cuVigeTipoPoli (nuConsecut, nuTipoPoliza, dtInicial, dtFinal);

        -- Obtiene el registro grabado en la tabla persistente
    	fetch cuVigeTipoPoli into sbDummy;

        -- Valida si ya existe un registro que se solape en las Fechas de Vigencia

    	if (cuVigeTipoPoli%FOUND) then
    	--{
    	    close cuVigeTipoPoli;

    	    -- Elimina el registro de la tabla Temporal
    	    delete Ld_Vali_Poli_Type_Temp where current of cuTablaTempo;

    	    close cuTablaTempo;

    	    -- Configura y asigna el mensaje de error
            Gi_BoErrors.SetErrorCodeArgument
            (
                cnuGeneric_Error,
                'Rango de fechas invalido sobrepuesto a la Vigencia del Tipo de Poliza: ' || sbDummy
            );

            RAISE ex.controlled_error;
    	--}
    	end if;

    	close cuVigeTipoPoli;

    	-- Elimina el registro de la tabla Temporal
    	delete Ld_Vali_Poli_Type_Temp where current of cuTablaTempo;
    --}
    END LOOP;

    close cuTablaTempo;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;

    when OTHERS then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
--}
END TRGAULD_VALIDITY_POLICY_TYPE;
/
