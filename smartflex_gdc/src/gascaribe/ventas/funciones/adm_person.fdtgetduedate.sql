CREATE OR REPLACE FUNCTION adm_person.fdtGetDueDate
/*****************************************************************
Propiedad intelectual de Gas Caribe.

Unidad         : fdtGetDueDate
Descripcion    : Obtiene la fecha según el valor del parámetro CANT_DIAS_VENC_CUPON
                 Esta fecha es utilizada en la factura de constructoras
Autor          :
Fecha          : 26/01/2017

Historia de Modificaciones
Fecha             Autor             Modificacion
=========         =========         ====================
******************************************************************/
RETURN DATE
IS
    dtReturn        date := sysdate;
    nuNumDias       ld_parameter.numeric_value%type;
BEGIN

    ut_trace.trace('Inicia fdtGetDueDate',10);
    
    nuNumDias := nvl(dald_parameter.fnuGetNumeric_Value('CANT_DIAS_VENC_CUPON',0),0);
    
    dtReturn := dtReturn + nuNumDias;

    ut_trace.trace('Fin fdtGetDueDate '||dtReturn,10);
    
    return dtReturn;
    
EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;

END fdtGetDueDate;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FDTGETDUEDATE', 'ADM_PERSON');
END;
/