create or replace PROCEDURE adm_person.pr_update_data_insured
IS
 /*******************************************************************************
  Histórico de Modificaciones
  Fecha                IDEntrega           Modificacion
  ============    ================    ============================================
  24/04/2024      OSF-2597            Se migra del esquema OPEN al esquema ADM_PERSON
  *******************************************************************************/
    sbName              ge_boInstanceControl.stysbValue;
    nuIdentification    ge_boInstanceControl.stysbValue;
    nuPolicy            ge_boInstanceControl.stysbValue;
    sbNameOld           LDC_LOG_UPDATE_INSURED.name_insured_old%type;
    nuIdentificationOld LDC_LOG_UPDATE_INSURED.identification_id_old%type;
    sbUser              LDC_LOG_UPDATE_INSURED.user%type;

BEGIN

    ut_trace.trace('Inicia el metodo PR_UPDATE_DATA_INSURED',10);

    sbName := ge_boInstanceControl.fsbGetFieldValue('LD_POLICY', 'NAME_INSURED');
    nuIdentification := ge_boInstanceControl.fsbGetFieldValue('LD_POLICY', 'IDENTIFICATION_ID');
    nuPolicy := ge_boInstanceControl.fsbGetFieldValue('LD_POLICY', 'POLICY_ID');

    ut_trace.trace('POLICY_ID '||nuPolicy||' NAME_INSURED '||sbName||' IDENTIFICATION_ID '||nuIdentification,10);

    if nuIdentification is null and sbName is null then
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error, 'Debe diligenciar al menos un campo');
        raise ex.controlled_error;
    end if;

    select name_insured into sbNameOld from LD_POLICY where policy_id = nuPolicy;
    select identification_id into nuIdentificationOld from LD_POLICY where policy_id = nuPolicy;

    ut_trace.trace('Actualizacion del registro en la tabla LD_POLICY',10);

    if nuIdentification = nuIdentificationOld and sbNameOld = sbName then
        return;
    end if;

    if sbName is null then
        sbName := sbNameOld;
    end if;

    if nuIdentification is null then
       nuIdentification := nuIdentificationOld;
    end if;

    update LD_POLICY
    set name_insured = sbName,
        identification_id = nuIdentification
    where policy_id = nuPolicy;

    select user into sbUser  from dual;

    ut_trace.trace('Insercion del registro en la tabla LDC_LOG_UPDATE_INSURED',10);

    insert into LDC_LOG_UPDATE_INSURED
    values(SEQ_LDC_LOG_UPDATE_INSURED.nextval,nuPolicy,nuIdentificationOld,nuIdentification,sbNameOld,sbName,ut_date.fdtsysdate,sbUser);

    commit;

    ut_trace.trace('Fin metodo PR_UPDATE_DATA_INSURED',10);

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END PR_UPDATE_DATA_INSURED;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre procedimiento PR_UPDATE_DATA_INSURED
BEGIN
    pkg_utilidades.prAplicarPermisos('PR_UPDATE_DATA_INSURED', 'ADM_PERSON'); 
END;
/