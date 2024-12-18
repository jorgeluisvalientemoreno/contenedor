CREATE OR REPLACE package adm_person.ldc_bcchangequotavalue is

  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  20/06/2024   Adrianavg   OSF-2848: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_BcChangeQuotaValue
    Descripcion    : Paquete que contiene los procedimientos para cambiar el valor
                     de la cuota mensual de un diferido cuando se actualiza el valor de la
                     tasa de interes.
    Autor          : Sayra Ocoro
    Fecha          : 19/06/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/
  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : prRecalculateQuotaValue
    Descripcion    :  Procedimiento donde se implementa la lógica para obtener los servicios suscritos
					           que tienen saldo diferido y modificar  el valor de la cuota de los diferidos.
    Autor          : Sayra Ocoro
    Fecha          : 19/06/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/
procedure prRecalculateQuotaValue;

end LDC_BcChangeQuotaValue;
/
CREATE OR REPLACE package body adm_person.LDC_BcChangeQuotaValue is

/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_BcChangeQuotaValue
    Descripcion    : Paquete que contiene los procedimientos para cambiar el valor
                     de la cuota mensual de un diferido cuando se actualiza el valor de la
                     tasa de interes.
    Autor          : Sayra Ocoro
    Fecha          : 19/06/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/
  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : prRecalculateQuotaValue
    Descripcion    :  Procedimiento donde se implementa la lógica para cambiar
					            el valor de la cuota de los diferidos.
    Autor          : Sayra Ocoro
    Fecha          : 19/06/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/
procedure prRecalculateQuotaValue
  is

sbFECHA_PROCESO ge_boInstanceControl.stysbValue;

BEGIN
    sbFECHA_PROCESO := ge_boInstanceControl.fsbGetFieldValue ('GE_LOG_ERR_INSPECC', 'FECHA_PROCESO');

    ------------------------------------------------
    -- User code
    ------------------------------------------------

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise;

    when OTHERS then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
end prRecalculateQuotaValue;

end LDC_BcChangeQuotaValue;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_BCCHANGEQUOTAVALUE
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_BCCHANGEQUOTAVALUE', 'ADM_PERSON'); 
END;
/
PROMPT
PROMPT OTORGA PERMISOS a REXEREPORTES sobre LDC_BCCHANGEQUOTAVALUE
GRANT EXECUTE ON ADM_PERSON.LDC_BCCHANGEQUOTAVALUE TO REXEREPORTES;
/