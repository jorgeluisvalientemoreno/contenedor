CREATE OR REPLACE PACKAGE ADM_PERSON.LDC_BCNOTIFICACIONESCRITICA AS

    /**************************************************************************
    Propiedad Intelectual de PETI

    Procedimiento   :  fsbGetNextConsPerRang
    Descripcion     :  Obtiene un rango de días, entre los cuales tentativamente se
                        realizará la lectura el siguiente mes.

    Parametros      : ENTRADA: Indetificador del producto
    Autor           :  Sergio Mejia (Optima Consulting)
    Fecha           :  11-11-2013

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    11-11-2013          sergiom             Creacion.

    **************************************************************************/
    FUNCTION fsbGetNextConsPerRang
    (
        inuServSusc CM_NOTICRIT.NOCRSESU%type
    )
    RETURN varchar2;

    /**************************************************************************
    Propiedad Intelectual de PETI

    Procedimiento   :  fnuGetOrdenRevision
    Descripcion     :  Obtiene la orden de revision por desviacion de consumo mas reciente.
    Parametros      : ENTRADA: Indetificador del producto
    Autor           :  Sergio Mejia (Optima Consulting)
    Fecha           :  11-11-2013

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    11-11-2013          sergiom             Creacion.

    **************************************************************************/
    FUNCTION fnuGetOrdenRevision
    (
        inuServSusc CM_NOTICRIT.NOCRSESU%type
    )
    RETURN OR_order.order_id%type;

    FUNCTION FSBVERSION
    RETURN VARCHAR2;

END LDC_BCNOTIFICACIONESCRITICA;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDC_BCNOTIFICACIONESCRITICA AS

    --------------------------------------------
    -- Constantes VERSION DEL PAQUETE
    --------------------------------------------
    CSBVERSION                  CONSTANT VARCHAR2(10) := 'NC_1557_1';

    --------------------------------------------
    -- Funciones y Procedimientos PRIVADAS DEL PAQUETE
    --------------------------------------------
    FUNCTION FSBVERSION
    RETURN VARCHAR2 IS
    BEGIN
        return CSBVERSION;
    END;

    /**************************************************************************
    Propiedad Intelectual de PETI

    Procedimiento   :  fnuGetNextConsPerRang
    Descripcion     :  Obtiene un rango de días, entre los cuales tentativamente se
                        realizará la lectura el siguiente mes.

    Parametros      : ENTRADA: Indetificador del producto
    Autor           :  Sergio Mejia (Optima Consulting)
    Fecha           :  11-11-2013

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    11-11-2013          sergiom             Creacion.

    **************************************************************************/
    FUNCTION fsbGetNextConsPerRang
    (
        inuServSusc CM_NOTICRIT.NOCRSESU%type
    )
    RETURN varchar2
    IS
            sbRango varchar2(100);
    BEGIN
        BEGIN
                SELECT (to_number(to_char(s.pecsfecf,'dd'))-1)||' - '||(to_number(to_char(s.pecsfecf,'dd'))+1) RANGO
                INTO sbRango
                FROM pericose a, pericose s
                where a.pecscons = pkbcpericose.fnugetcurrconsperiodbyprod(inuServSusc)
                AND  s.pecsfecf > a.pecsfecf
                AND a.pecscico = s.pecscico
                AND rownum = 1
                ORDER BY s.pecsfecf asc;
        EXCEPTION
            when no_data_found then
            sbRango := null;
        END;
        return sbRango;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fsbGetNextConsPerRang;

    /**************************************************************************
    Propiedad Intelectual de PETI

    Procedimiento   :  fnuGetOrdenRevision
    Descripcion     :  Obtiene la orden de revision por desviacion de consumo mas reciente.
    Parametros      : ENTRADA: Indetificador del producto
    Autor           :  Sergio Mejia (Optima Consulting)
    Fecha           :  11-11-2013

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    11-11-2013          sergiom             Creacion.
    **************************************************************************/
    FUNCTION fnuGetOrdenRevision
    (
        inuServSusc CM_NOTICRIT.NOCRSESU%type
    )
    RETURN OR_order.order_id%type
    IS
        nuOrderId OR_order.order_id%type;
    BEGIN
        BEGIN
            SELECT O.order_id
            INTO nuOrderId
            FROM OR_order O, or_order_activity A
            WHERE O.task_type_id = 12620
            AND O.order_id = A.order_id
            AND O.ORDER_status_id = 8
            AND A.product_id = inuServSusc
            AND rownum = 1
            ORDER BY  execution_final_date desc;
        EXCEPTION
        when no_data_found then
            nuOrderId := null;
        END;
        return nuOrderId;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fnuGetOrdenRevision;

END  LDC_BCNOTIFICACIONESCRITICA;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_BCNOTIFICACIONESCRITICA', 'ADM_PERSON');
END;
/