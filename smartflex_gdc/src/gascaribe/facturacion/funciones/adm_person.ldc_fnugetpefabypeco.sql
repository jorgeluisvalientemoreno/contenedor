CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNUGETPEFABYPECO" 
(
    inupericose in pericose.pecscons%type
)
RETURN perifact.pefacodi%type
/*****************************************************************
Propiedad intelectual de GDO (c).

Unidad         : ldc_fnuGetPefaByPeco
Descripción    : Retorna el periodo de facturación a partir de un periodo de
                 consumo
Autor          : Carlos Alberto Ramírez Herrera
Fecha          : 19-11-2013

Parametros         Descripcion
============	===================
    inupericose   Periodo de consumo


Historia de Modificaciones

DD-MM-YYYY    <Autor>.SAONNNNN        Modificación

19-11-2013   carlosr
Creación
-----------  -------------------    -------------------------------------

******************************************************************/
IS
    nuErrorCode NUMBER;
    sbErrorMessage VARCHAR2(4000);

BEGIN                         -- ge_module

    pkErrors.push('ldc_fnuGetPefaByPeco');
    return open.pkbcperifact.fnubillperbyconsper(inupericose);

EXCEPTION
    when ex.CONTROLLED_ERROR then
        pkErrors.pop;
        return null;
    when others then
        Errors.setError;
        pkErrors.pop;
        return null;
END ldc_fnuGetPefaByPeco;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNUGETPEFABYPECO', 'ADM_PERSON');
END;
/