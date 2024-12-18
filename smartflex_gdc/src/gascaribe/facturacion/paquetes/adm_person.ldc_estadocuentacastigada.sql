CREATE OR REPLACE PACKAGE ADM_PERSON.LDC_ESTADOCUENTACASTIGADA IS
/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_ESTADOCUENTACASTIGADA
    Descripcion    : Servicios para validaciones de estado de cuenta castigada
    Autor          : Eduardo Cerón
    Fecha          : 17/12/2018

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================

  ******************************************************************/

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fnuGetIsCastig
    Descripcion    : Retorna 1 si la deuda es castigada 0 si no
  ******************************************************************/

    FUNCTION fnuGetIsCastig
    (
        inuSuscriptionId    IN  servsusc.sesususc%TYPE
    )
    RETURN NUMBER;

END LDC_ESTADOCUENTACASTIGADA;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDC_ESTADOCUENTACASTIGADA IS
/*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_ESTADOCUENTACASTIGADA
    Descripcion    : Servicios para validaciones de estado de cuenta castigada
    Autor          : Eduardo Cerón
    Fecha          : 17/12/2018

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================

  ******************************************************************/

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : fnuGetIsCastig
    Descripcion    : Retorna 1 si la deuda es castigada 0 si no
    Autor          : Eduardo Cerón
    Fecha          : 17/12/2018

    Metodos

    Nombre         :
    Parametros              Descripcion
    ============            ===================
        inuSuscriptionId    Identificador del conrato

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================

  ******************************************************************/

    FUNCTION fnuGetIsCastig
    (
        inuSuscriptionId    IN  servsusc.sesususc%TYPE
    )
    RETURN NUMBER
    IS
        nuResult      number    := 0;

    BEGIN
        ut_trace.trace('INICIA LDC_ESTADOCUENTACASTIGADA.fnuGetIsCastig ',10);

        nuResult := cc_bobsssubscriptiondata.fnupunishvalue(inuSuscriptionId);

        ut_trace.trace('FIN LDC_ESTADOCUENTACASTIGADA.fnuGetIsCastig RETURN '||nuResult,10);
        RETURN nuResult;

    EXCEPTION
        when others then
            ut_trace.trace('others LDC_ESTADOCUENTACASTIGADA.fnuGetIsCastig return 0',10);
            return 0;
    END  fnuGetIsCastig;


END LDC_ESTADOCUENTACASTIGADA;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_ESTADOCUENTACASTIGADA', 'ADM_PERSON');
END;
/