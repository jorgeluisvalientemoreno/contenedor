CREATE OR REPLACE PACKAGE LDC_BOINSOLVENCYECON 
/***************************************************************************
  Propiedad intelectual de Gases del Caribe.

  Package     : LDC_BOINSOLVENCYECON
  Descripcion : Paquete para modificacion de flujo de insolvencia.

  Autor     : Horbath.
  Fecha     : 23-01-2022

  Historia de Modificaciones

  23-01-2022    Horbath.CA877           Modificacion
  -----------   -------------------      -------------------------------------
  jpinedc       15/08/2023              OSF-1418: * AdjustSuscrip: Se actualiza 
                                        tambien el ciclo de consumo
  ***************************************************************************/
IS

    gsbFlagValidate         VARCHAR2(1) := 'N';

    FUNCTION fsbVersion
    RETURN varchar2;

    PROCEDURE AdjustSuscrip
    (
        inuMotive       IN          mo_motive.motive_id%type
    );

END LDC_BOINSOLVENCYECON;
/

CREATE OR REPLACE PACKAGE BODY LDC_BOINSOLVENCYECON 
/***************************************************************************
  Propiedad intelectual de Gases del Caribe.

  Package     : LDC_BOINSOLVENCYECON
  Descripcion : Paquete para modificacion de flujo de insolvencia.

  Autor     : Horbath.
  Fecha     : 23-01-2022

  Historia de Modificaciones

  23-01-2022    Horbath.CA877        Modificacion
  -----------  -------------------    -------------------------------------

  ***************************************************************************/
IS

    csbVERSION          CONSTANT VARCHAR2(10) := 'CA877';
    /*****************************************************************
      Propiedad intelectual de Gases de occidente

      Function  :    fsbVersion
      Descripcion :  Version del Objeto

      Autor    :  Horbath
      Fecha    :  23-01-2022

      Historia de modificaciones
      Autor    Fecha       Descripcion
      *****************************************************************/
    FUNCTION fsbVersion
    RETURN varchar2
    IS
    BEGIN
        RETURN csbVERSION;
    END fsbVersion;
    /*****************************************************************
      Propiedad intelectual de Gases de occidente

      Function  :    AdjustSuscrip
      Descripcion :  Actualiza informacion productos espejo en insolvencia

      Parametros  :          Descripcion
      inuMotive              Codigo del motivo

      Autor    :  Horbath
      Fecha    :  23-01-2022

      Historia de modificaciones
      Autor    Fecha       Descripcion
      jpinedc  15/08/2023  OSF-1418: Se actualiza tambien el ciclo de 
                           consumo
      *****************************************************************/
    PROCEDURE AdjustSuscrip
    (
        inuMotive       IN          mo_motive.motive_id%type
    )
    IS
        nuSubscription      suscripc.susccodi%type;
        nuClient            ge_subscriber.subscriber_id%type;
        nuSubscripMirror    suscripc.susccodi%type;
        nuCycle             ciclo.ciclcodi%type;
        nuVarCons           NUMBER := 3;

        CURSOR cuGetCycleProduct
        IS
            SELECT  sesucicl
            FROM    servsusc
            WHERE   sesususc = nuSubscription;

        CURSOR cuGetSubscrMirror
        IS
            SELECT  susccodi
            FROM    suscripc
            WHERE   suscclie = nuClient
            AND     SUSCTISU = GC_BOCONSTANTS.FNUGETSUCRIPTYPEINSOLV;
    BEGIN

        ut_trace.trace('Inicio LDC_BOINSOLVENCYECON.AdjustSuscrip', 10);

        nuSubscription := damo_motive.fnugetsubscription_id(inuMotive, NULL);

        IF nuSubscription IS NOT NULL THEN

            nuClient := pktblsuscripc.fnugetsuscclie(nuSubscription);

            OPEN cuGetSubscrMirror;
            FETCH cuGetSubscrMirror INTO nuSubscripMirror;
            CLOSE cuGetSubscrMirror;

            IF nuSubscripMirror IS NOT NULL THEN

                OPEN cuGetCycleProduct;
                FETCH cuGetCycleProduct INTO nuCycle;
                CLOSE cuGetCycleProduct;

                gsbFlagValidate := 'Y';

                UPDATE servsusc
                SET SESUCICL = nuCycle,
                    SESUCICO = nuCycle,
                    SESUMECV = nuVarCons
                WHERE sesususc = nuSubscripMirror;

                pktblsuscripc.updsusccicl(nuSubscripMirror, nuCycle);

                gsbFlagValidate := 'N';

            END IF;

        END IF;
        ut_trace.trace('Fin LDC_BOINSOLVENCYECON.AdjustSuscrip', 10);

    EXCEPTION
        when pkg_Error.CONTROLLED_ERROR then
          raise;
        when others then
          pkg_error.setError;
          raise pkg_Error.CONTROLLED_ERROR;
    END AdjustSuscrip;


END LDC_BOINSOLVENCYECON;
/

PROMPT Otorgando permisos de ejecucion para LDC_BOINSOLVENCYECON
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_BOINSOLVENCYECON','OPEN');
END;
/
