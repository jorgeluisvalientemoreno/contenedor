CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNUGETTASKTYPEBYSUBS" 
(
    inuSubsidyId ld_subsidy.subsidy_id%type
)
RETURN OR_task_type.task_type_id%type
/*****************************************************************
Propiedad intelectual de GDO (c).

Unidad         : ldc_fnuGetTaskTypeBySubs
Descripción    : Retorna el tipo de trabajo dependiendo de la equivalencia de
                 Tipos de Trabajo por Subsidio
Autor          : Carlos Alberto Ramírez Herrera
Fecha          : 12-09-2013

Parametros         Descripcion
============	===================
  inuSubsidyId  Id del subsidio


Historia de Modificaciones

DD-MM-YYYY    <Autor>.SAONNNNN        Modificación
-----------  -------------------    -------------------------------------
22-02-202    felipe.valencia        OSF-2370: Se agrega permiso a usario REPORTES

12-09-2013   carlosr
Creación


******************************************************************/
IS
    nuErrorCode NUMBER;
    sbErrorMessage VARCHAR2(4000);

    nuEquivalGroup  ge_equivalence_set.equivalence_set_id%type;
    sbParameter     ld_parameter.parameter_id%type := 'LDC_TASKTYPE_SUBS_EQUI';


BEGIN                         -- ge_module

    pkErrors.push('ldc_fnuGetTaskTypeBySubs');

    nuEquivalGroup := dald_parameter.fnuGetNumeric_Value(sbParameter);

    if(nuEquivalGroup = -1) then
        pkErrors.pop;
        return null;
    end if;

    pkErrors.pop;
    return GE_BOEQUIVALENCVALUES.fsbgettargetvalue(nuEquivalGroup,inuSubsidyId);

EXCEPTION
    when ex.CONTROLLED_ERROR then
        pkErrors.pop;
        return null;
    when others then
        Errors.setError;
        pkErrors.pop;
        return null;
END ldc_fnuGetTaskTypeBySubs;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNUGETTASKTYPEBYSUBS', 'ADM_PERSON');
END;
/
PROMPT OTORGA PERMISOS a REPORTES sobre funcion LDC_FNUGETTASKTYPEBYSUBS
GRANT EXECUTE ON ADM_PERSON.LDC_FNUGETTASKTYPEBYSUBS TO REPORTES;
/