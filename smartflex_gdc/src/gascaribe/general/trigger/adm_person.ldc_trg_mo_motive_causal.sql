CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_MO_MOTIVE_CAUSAL
BEFORE INSERT ON mo_motive
FOR EACH ROW
/**************************************************************************
    Propiedad Intelectual de PETI
    trigger     :   LDC_TRG_MO_MOTIVE_CAUSAL
    Descripcion :   Trigger que valida la existencia de una causal para los tipos de solicitud
                    configurados.
    Autor       :   Sergio Mejia - Opitma Consulting
    Fecha       :   18-12-2013

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    18-12-2013          smejia              Creacion.
    22-12-2013          smejia              Se agrega la verificacion del ejecutable para que solo valide
                                            si el trámite se está registrando desde el CNCRM.
**************************************************************************/
DECLARE

    -- Nombre del parámetro donde se configuran los tipos de solicitudes
    csbTIPOS_SOLICITUDES        ld_parameter.value_chain%type := 'LDC_TIP_SOLIC_VALIDA_CAUSAL';


    nuValidNumber               Number;
    sbTiposSolicitudes          varchar2(4000);

    nombre_instancia     varchar2(4000);

    CURSOR cuPackage(inuPackageId  mo_packages.package_id%type, isbVar varchar2) IS
    SELECT 1
    from mo_packages, (SELECT to_number(column_value) column_value
             from table (ldc_boutilities.SPLITstrings(isbVar,'|')))
    WHERE PACKAGE_type_id = column_value
    AND PACKAGE_id = inuPackageId;

BEGIN

    UT_Trace.Trace('Inicia LDC_TRG_MO_MOTIVE_CAUSAL ',8);

    nombre_instancia := ut_session.getmodule;

    UT_Trace.Trace(' Instancia = '||nombre_instancia,8);

    IF nombre_instancia = 'CNCRM' then

        -- Obtiene el string con los tipos de solitud condiguradas
        sbTiposSolicitudes := dald_parameter.fsbGetValue_Chain(csbTIPOS_SOLICITUDES);

        /* Valida si la solicitud es de uno de los tipos configurados en el parametro
            LDC_TIP_SOLIC_VALIDA_CAUSAL, si es así, se obtiene el número 1, de los contrario
            se obtiene null*/
        OPEN  cuPackage(:new.package_id, sbTiposSolicitudes);
        fetch cuPackage INTO nuValidNumber;
        close cuPackage;

        IF nuValidNumber = 1 then
            if :new.causal_id IS null then
                errors.seterror(2741, '[SOLICITUD:'||:new.package_id ||'] La solicitud no puede tener una causal nula');
                RAISE ex.controlled_error;
            END if;
        END if;

    END if;


    UT_Trace.Trace('Finaliza LDC_TRG_MO_MOTIVE_CAUSAL ',8);

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END LDC_TRG_MO_MOTIVE_CAUSAL;
/
