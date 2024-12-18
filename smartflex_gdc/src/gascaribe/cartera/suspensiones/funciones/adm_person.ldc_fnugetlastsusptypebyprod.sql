CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNUGETLASTSUSPTYPEBYPROD" 
(
    inuProductId in NUMBER
)
RETURN varchar
/*****************************************************************
Propiedad intelectual de Open International Systems (c).

Unidad         : LDC_fnuGetLastSuspTypeByProd
Descripci�n    : Funci�n que devuelve el �ltimo tipo de suspensi�n de un producto
Autor          : Carlos Alberto Ram�rez
Fecha          : 08/07/2014

Parametros         Descripcion
============	===================


Historia de Modificaciones

DD-MM-YYYY    <Autor>.SAONNNNN        Modificaci�n
-----------  -------------------    -------------------------------------
08/07/2014  arqs.carlosr
Creaci�n

******************************************************************/
IS

    -- Variable para mensajes de Error
    sbErrMsg    ge_error_log.description%type;

    CURSOR cuLastSuspType
    IS
        SELECT  *
        FROM    (
                SELECT  decode(a.suspension_type_id,null,null,dage_suspension_type.fsbgetdescription(a.suspension_type_id))
                FROM    pr_prod_suspension a
                WHERE   a.product_id = inuProductId
                ORDER   BY prod_suspension_id desc
                )
        WHERE   rownum = 1;

     sbSuspType varchar(500);

BEGIN
--{

    pkErrors.Push ('LDC_fnuGetLastSuspTypeByProd');

    open    cuLastSuspType;
    fetch   cuLastSuspType INTO sbSuspType;
    close   cuLastSuspType;


    -- Proceso
    pkErrors.Pop;
    return sbSuspType;

EXCEPTION
    when LOGIN_DENIED then
        pkErrors.Pop;
        raise LOGIN_DENIED;

    when pkConstante.exERROR_LEVEL2 then
        -- Error Oracle nivel dos
        pkErrors.Pop;
        raise pkConstante.exERROR_LEVEL2;

    when OTHERS then
        pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, sbErrMsg);
        pkErrors.Pop;
        raise_application_error(pkConstante.nuERROR_LEVEL2,sbErrMsg);
--}
END LDC_fnuGetLastSuspTypeByProd;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNUGETLASTSUSPTYPEBYPROD', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON LDC_FNUGETLASTSUSPTYPEBYPROD TO REPORTES;
/