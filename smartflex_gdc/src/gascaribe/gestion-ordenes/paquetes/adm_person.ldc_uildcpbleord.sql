CREATE OR REPLACE PACKAGE adm_person.LDC_UILDCPBLEORD
IS

/**************************************************************************
    Autor       :
    Fecha       : 10/04/2020
    Ticket      : 241
    Descripción: Paquete para gestion de la forma LDCPBLEORD

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    26/06/2024   PAcosta     OSF-2878: Cambio de esquema ADM_PERSON  
***************************************************************************/

    /**************************************************************************
        Fecha       : 10/04/2020
        Ticket      : 241
        Descripción: Retorna la version actual del objeto
    ***************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2;

    /**************************************************************************
        Fecha       : 10/04/2020
        Ticket      : 241
        Descripción: Proceso para registrar la insolvencia
    ***************************************************************************/
    PROCEDURE PROCESS;


END LDC_UILDCPBLEORD;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_UILDCPBLEORD
IS
/**************************************************************************
    Autor       :
    Fecha       : 10/04/2020
    Ticket      : 241
    Descripción: Paquete para gestion de la forma LDCPBLEORD

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
***************************************************************************/

    csbVERSION  CONSTANT    VARCHAR2(20) := 'CA241';

    /**************************************************************************
        Autor       :
        Fecha       : 10/04/2020
        Ticket      : 241
        Descripción: Retorna la version actual del objeto

        Parámetros Entrada

        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2
    IS
    BEGIN
       RETURN csbVERSION;
    END fsbVersion;

    /**************************************************************************
        Autor       :
        Fecha       : 10/04/2020
        Ticket      : 241
        Descripción: Proceso para registrar la insolvencia

        Parámetros Entrada

        Valor de salida


        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PROCEDURE PROCESS
    IS
        sbMes               GE_BOINSTANCECONTROL.STYSBVALUE;
        sbAno               GE_BOINSTANCECONTROL.STYSBVALUE;
        sbOperUnit          GE_BOINSTANCECONTROL.STYSBVALUE;
        dtFechaIinicio      DATE;
        sbErrMsg            VARCHAR2(2000);


    BEGIN
        ut_trace.trace('Inicia LDC_UILDCPBLEORD.PROCESS',10);
        -- Se obtienen los datos de la instancia
        sbMes := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE('OR_ORDER', 'ORDER_ID');
        sbAno := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE('OR_ORDER', 'CAUSAL_ID');
        sbOperUnit := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE('OR_ORDER', 'OPERATING_UNIT_ID');

        dtFechaIinicio := TO_DATE('01/'||sbMes||'/'||sbAno,'DD/MM/YYYY');

        IF dtFechaIinicio > ut_date.fdtsysdate THEN
            sbErrMsg := 'El mes y año seleccionado no puede ser mayor a la fecha actual. Favor validar';
            Errors.seterror(2741,sbErrMsg);
            raise ex.CONTROLLED_ERROR;
        END IF;

        ut_trace.trace('Fin lDC_BOLDGIC.PROCESS',10);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            RAISE ex.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END PROCESS;


END LDC_UILDCPBLEORD;
/
PROMPT Otorgando permisos de ejecucion a LDC_UILDCPBLEORD
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_UILDCPBLEORD', 'ADM_PERSON');
END;
/