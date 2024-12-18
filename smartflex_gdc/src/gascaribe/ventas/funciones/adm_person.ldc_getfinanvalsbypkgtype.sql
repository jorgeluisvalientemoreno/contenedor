CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_GETFINANVALSBYPKGTYPE" 
(
    inuPackageId    mo_packages.package_id%type,
    inuPackageType  ps_package_type.package_type_id%type,
    inuType         number
)
RETURN number
/*****************************************************************
Propiedad intelectual de GDO (c).

Unidad         : ldc_GetFinanValsByPkgType
Descripción    : Retorna los valores de Valor Cuota, Número de Cuotas y Valor de
                 Anticipo, según el tipo y el tipo de paquete que se ingrese por
                 parámetro
Autor          : Carlos Alberto Ramírez Herrera
Fecha          : 16-09-2013

Parametros         Descripcion
============	===================
    inuPackageId    Identificador de la solicitud
    inuPackageType  Tipo de solicitud
    inuType         Tipo de campo:
                        1 - Valor Cuota
                        2 - Número de Cuotas
                        3 - Valor Anticipo


Historia de Modificaciones

DD-MM-YYYY    <Autor>.SAONNNNN        Modificación
-----------  -------------------    -------------------------------------
22-02-202    felipe.valencia        OSF-2370: Se agrega permiso a usario REPORTES

11-12-2013   carlosr
Se quita la restricción por tipo de paquete y siempre se busca en la entidad
cc_sales_financ_cond

16-09-2013   carlosr
Creación


******************************************************************/
IS
    nuErrorCode NUMBER;
    sbErrorMessage VARCHAR2(4000);

BEGIN                         -- ge_module

    pkErrors.push('ldc_GetFinanValsByPkgType');


        if(inuType = 1) then  -- Valor Cuota
            pkErrors.pop;
            return dacc_sales_financ_cond.fnugetaverage_quote_value(inuPackageId);
        end if;

        if(inuType = 2) then  -- Número de Cuotas
            pkErrors.pop;
            return dacc_sales_financ_cond.fnugetquotas_number(inuPackageId);
        end if;

        if(inuType = 3) then  -- Valor Anticipo
            pkErrors.pop;
            return dacc_sales_financ_cond.fnugetinitial_payment(inuPackageId);
        end if;

    pkErrors.pop;
    return null;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        pkErrors.pop;
        return null;
    when others then
        Errors.setError;
        pkErrors.pop;
        return null;
END ldc_GetFinanValsByPkgType;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_GETFINANVALSBYPKGTYPE', 'ADM_PERSON');
END;
/
PROMPT OTORGA PERMISOS a REPORTES sobre funcion LDC_GETFINANVALSBYPKGTYPE
GRANT EXECUTE ON ADM_PERSON.LDC_GETFINANVALSBYPKGTYPE TO REPORTES;
/
