CREATE OR REPLACE package adm_person.ldc_bcdeletechargedupl is

  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  20/06/2024   Adrianavg   OSF-2848: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_BCDeleteChargeDupl
    Descripcion    : Paquete donde se implementa la lógica eliminar cargos con cuentas de cobro -1
                     de cargo por concepto de duplicado  PB  LDCACD

    Autor          : Jhon Jairo Soto
    Fecha          : 26/03/2015

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

  Unidad         : PrDeleteChargeDupl
  Descripcion    : Eliminar cargos con cuentas de cobro -1
                   de cargo por concepto de duplicado
  Autor          :
  Fecha          : 26/03/2015

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

Procedure PrDeleteChargedupl;

end LDC_BCDeleteChargeDupl;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_BCDeleteChargeDupl IS

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_BCDeleteCharges
    Descripcion    : Paquete donde se implementa la lógica eliminar cargos con cuentas de cobro -1
                     de cargo por concepto de duplicado  PB  LDCACD

    Autor          : Jhon Jairo Soto
    Fecha          : 26/03/2015

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

  Unidad         : PrDeleteChargeDupl
  Descripcion    : Eliminar cargos con cuentas de cobro -1
                   de cargo por concepto de duplicado
  Autor          :
  Fecha          : 26/03/2015

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

Procedure PrDeleteChargedupl is

    cnuNULL_ATTRIBUTE constant number := 2126;
    sbSesunuse ge_boInstanceControl.stysbValue;

BEGIN
   ut_trace.Trace('INICIO LDC_BCDeleteChargedupl.PrDeleteChargedupl', 10);

    sbSesunuse := ge_boInstanceControl.fsbGetFieldValue ('SERVSUSC', 'SESUNUSE');

    ------------------------------------------------
    -- Required Attributes
    ------------------------------------------------

    if (sbSesunuse is null) then
        Errors.SetError (cnuNULL_ATTRIBUTE, 'Numero de producto:');
        raise ex.CONTROLLED_ERROR;
    end if;

    ------------------------------------------------
    -- User code
    ------------------------------------------------
    delete from cargos
    where CARGNUSE = TO_NUMBER(sbSesunuse) and cargconc = 24 AND CARGPROG = 2038
    and CARGCUCO = -1;
    commit;

    ut_trace.Trace('FIN LDC_BCDeleteChargedupl.PrDeleteChargedupl', 10);
EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise;

    when OTHERS then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END PrDeleteChargedupl;

END LDC_BCDeleteChargeDupl;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_BCDELETECHARGEDUPL
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_BCDELETECHARGEDUPL', 'ADM_PERSON'); 
END;
/