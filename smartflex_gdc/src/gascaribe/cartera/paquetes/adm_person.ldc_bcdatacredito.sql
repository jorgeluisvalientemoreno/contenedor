CREATE OR REPLACE PACKAGE ADM_PERSON.LDC_BCDATACREDITO
IS
  /*****************************************************************
  Package	: LDC_BCDATACREDITO
  Descripcion : Metodos, cursores y constantes usadas en el proceso de
                  generacion de reportes maestros.

  Autor	: Manuel Mejia
  Fecha	: 22-05-2017

  Historia de Modificaciones
  Fecha	    IDEntrega               Descripción
  ==========  ================================================================
  22-05-2017   Mmejia.SAS200-1112      Creación
  ******************************************************************/

    /*****************************************************************
    Procedure	: fsbGetNeighborthood
    Descripci?n	:

    Par?metros	:	Descripci?n
      isbName    VARCHAR2    Codigo Executable
    Retorno     :
        Cantidad de actividades planeadas,  0 si no tiene
    Autor	: Manuel Mejia
    Fecha	: 06-06-2017

    Historia de Modificaciones
    Fecha       Autor
    ----------  --------------------
    06-06-2017  Mmejia
    Creaci?n.
    *****************************************************************/
    FUNCTION fsbGetNeighborthood
    (
      inuAddressId IN OPEN.ab_address.address_id%TYPE
    )RETURN VARCHAR2;

    /*****************************************************************
    Procedure	: fsbGetLocation
    Descripci?n	:

    Par?metros	:	Descripci?n
      isbName    VARCHAR2    Codigo Executable
    Retorno     :
        Cantidad de actividades planeadas,  0 si no tiene
    Autor	: Manuel Mejia
    Fecha	: 06-06-2017

    Historia de Modificaciones
    Fecha       Autor
    ----------  --------------------
    06-06-2017  Mmejia
    Creaci?n.
    *****************************************************************/
    FUNCTION fsbGetLocation
    (
      inuAddressId IN  OPEN.ab_address.address_id%TYPE
    )RETURN VARCHAR2;

    /*****************************************************************
    Procedure	: fsbGetAddress
    Descripci?n	:

    Par?metros	:	Descripci?n
      isbName    VARCHAR2    Codigo Executable
    Retorno     :
        Cantidad de actividades planeadas,  0 si no tiene
    Autor	: Manuel Mejia
    Fecha	: 06-06-2017

    Historia de Modificaciones
    Fecha       Autor
    ----------  --------------------
    06-06-2017  Mmejia
    Creaci?n.
    *****************************************************************/
    FUNCTION fsbGetAddress
    (
      inuAddressId IN  OPEN.ab_address.address_id%TYPE
    )RETURN VARCHAR2;

 /*****************************************************************
  Function	: fnuGetProcessedRecords
  Descripción	: Devuelve la cantidad de registros a procesos por el proceso
                de centrales de riesgo

  Parámetros	:	Descripción
  Retorno     :

  Autor	: Manuel Mejia
  Fecha	: 22-04-2016

  Historia de Modificaciones
  Fecha       Autor
  ----------  --------------------
  24-06-2017  Mmejia
  Creación.
  *****************************************************************/
  FUNCTION fnuGetProcessedRecords
  (
  inuCicoAno       NUMBER,
  inuCicoMes       NUMBER,
  isbProductDepart VARCHAR2,
  isbProductLocal  VARCHAR2,
  isbProductCycles VARCHAR2,
  isbCategories    VARCHAR2,
  isbSubCategories VARCHAR2,
  isbDateIniDataCredito VARCHAR2
  )RETURN NUMBER;

  /*****************************************************************
  Function	: GetProdsPerSusc
  Descripción	: Devuelve los registros a procesos por el proceso
                de centrales de riesgo

  Parámetros	:	Descripción
  Retorno     :

  Autor	: Manuel Mejia
  Fecha	: 22-04-2016

  Historia de Modificaciones
  Fecha       Autor
  ----------  --------------------
  24-06-2017  Mmejia
  Creación.
  *****************************************************************/
  PROCEDURE GetProdsPerSusc
  (
  inuCicoAno       NUMBER,
  inuCicoMes       NUMBER,
  isbProductDepart VARCHAR2,
  isbProductLocal  VARCHAR2,
  isbProductCycles VARCHAR2,
  isbCategories    VARCHAR2,
  isbSubCategories VARCHAR2,
  isbDateIniDataCredito VARCHAR2,
  inuProductId     pr_product.product_id%TYPE,
  ocuCursor OUT CONSTANTS.TYREFCURSOR
  );

    --------------------------------------------
    -- Cursores
    --------------------------------------------
    CURSOR cuCierr(idtFechCierr DATE)
    IS
    SELECT *
      FROM OPEN.LDC_CIERCOME
      WHERE Trunc(cicofech) = idtFechCierr;

    /*****************************************************************
    Cursor      :  cuGetProdsPerSusc
    Descripcion	:  Devuelve todos los productos en los que se es deudor producto GAS.

    Autor       : Manuel Mejia
    Fecha       : 22-05-2017
    ******************************************************************/
    CURSOR cuGetProdsPerSusc(isbProductDepart VARCHAR2,
                             isbProductLocal  VARCHAR2,
                             isbProductCycles VARCHAR2,
                             isbCategories    VARCHAR2,
                             isbSubCategories VARCHAR2,
                             isbDateIniDataCredito VARCHAR2,
                             inuProductId     pr_product.product_id%TYPE
                             )
        IS
        SELECT /*+ INDEX(CF IDX_CC_FINANCING_REQUEST_01)*/
               DISTINCT CC.PRODUCTO PRODUCT_ID,
                        CC.CONTRATO SUBSCRIPTION_ID,
                        CC.ESTADO_FINANCIERO SESUESFN,
                        AB.Address ADDRESS,
                        AB.ADDRESS_ID,
                        (SELECT GE_GEOGRA_LOCATION.description   description
                          FROM GE_GEOGRA_LOCATION
                        WHERE AB.NEIGHBORTHOOD_ID = GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID
                        )
                        NEIGHBORTHOOD,
                        GEO1.DESCRIPTION  LOCATION,
                        (SELECT GEO2.description   description
                          FROM GE_GEOGRA_LOCATION GEO2
                        WHERE GEO1.GEO_LOCA_FATHER_ID = GEO2.GEOGRAP_LOCATION_ID
                        )
                        DEPARTAMENTO,
                        subs.IDENT_TYPE_ID,
                        subs.IDENTIFICATION,
                        subs.phone PHONE_NUMBER,
                        subs.subscriber_name||' '||subs.subs_last_name FULL_NAME,
                        'D' REPORT_TYPE,--DEUDOR D CODEDOR C
                        MP.PACKAGE_ID PACKAGE_ID,
                        CF.FINANCING_ID FINANCING_ID,
                        'GNEG' SOURCE,
                        subs.SUBSCRIBER_ID,
                        CC.EDAD,
                        Sum(DIFESAPE) SALDO_DIFE
                FROM    GE_SUBSCRIBER SUBS,
                        LDC_OSF_SESUCIER CC,
                        LDC_OSF_DIFERIDO DI,
                        MO_PACKAGES MP,
                        CC_FINANCING_REQUEST  CF,
                        SUSCRIPC SS,
                        AB_ADDRESS AB,
                        GE_GEOGRA_LOCATION GEO1
                WHERE
                CF.SUBSCRIPTION_ID = SS.SUSCCODI
                AND SS.SUSCCLIE = SUBS.SUBSCRIBER_ID
                AND     CC.TIPO_PRODUCTO = 7014
                AND     SS.SUSCCODI = CC.CONTRATO
                AND     CC.ESTADO_CORTE NOT IN (95,96,110)--validacion de estados de corte
                AND     CF.PACKAGE_ID=MP.PACKAGE_ID
                AND     DI.DIFECOFI = CF.FINANCING_ID
                AND     DI.DIFENUSE = CC.PRODUCTO
                AND     CF.RECORD_PROGRAM='GCNED'
                AND     AB.ADDRESS_ID = SUBS.ADDRESS_ID
                AND     AB.GEOGRAP_LOCATION_ID = GEO1.GEOGRAP_LOCATION_ID
                AND     CC.PRODUCTO =  138553
                AND     DI.difefein >=isbDateIniDataCredito
                AND     CC.PRODUCTO = Decode(inuProductId,-1,CC.PRODUCTO,inuProductId)
                --filtro DEPARTAMENTO
                ---GEO1.GEO_LOCA_FATHER_ID
                AND GEO1.GEO_LOCA_FATHER_ID IN (
                                        SELECT column_value
                                        FROM TABLE(LDC_BOUTILITIES.SPLITstrings(Decode(isbProductDepart, '-1', To_Char(GEO1.GEO_LOCA_FATHER_ID), isbProductDepart)  ,','))
                                        )
                --filtro LOCALIDAD
                --AB.GEOGRAP_LOCATION_ID
                AND AB.GEOGRAP_LOCATION_ID IN (
                                        SELECT column_value
                                        FROM TABLE(LDC_BOUTILITIES.SPLITstrings(Decode(isbProductLocal, '-1', To_Char(AB.GEOGRAP_LOCATION_ID), isbProductLocal)  ,','))
                                        )
                --filtro CICLO
                AND CC.CICLO IN (
                                        SELECT column_value
                                        FROM TABLE(LDC_BOUTILITIES.SPLITstrings(Decode(isbProductCycles, '-1', To_Char(CC.CICLO), isbProductCycles)  ,','))
                                        )
                --filtro CATEGORIA
                AND CC.categoria IN (
                                        SELECT column_value
                                        FROM TABLE(LDC_BOUTILITIES.SPLITstrings(Decode(isbCategories, '-1', To_Char(CC.categoria), isbCategories)  ,','))
                                        )
                --filtro SUBCATEGORIA
                AND CC.subcategoria IN (
                                        SELECT column_value
                                        FROM TABLE(LDC_BOUTILITIES.SPLITstrings(Decode(isbSubCategories, '-1', To_Char(CC.subcategoria),isbSubCategories)  ,','))
                                        )
                GROUP BY   CC.PRODUCTO ,
                        CC.CONTRATO,
                        CC.ESTADO_FINANCIERO ,
                        AB.Address ,
                        AB.ADDRESS_ID,
                        GEO1.DESCRIPTION ,
                        subs.IDENT_TYPE_ID,
                        subs.IDENTIFICATION,
                        subs.phone ,
                        subs.subscriber_name,
                        subs.subs_last_name,
                        MP.PACKAGE_ID ,
                        CF.FINANCING_ID ,
                        subs.SUBSCRIBER_ID,
                        CC.EDAD,
                        AB.NEIGHBORTHOOD_ID,
                        GEO1.GEO_LOCA_FATHER_ID;

    --------------------------------------------
    -- Métodos
    --------------------------------------------
    FUNCTION fsbVersion RETURN VARCHAR2;

    /*****************************************************************
    Function	: GetCreditDetaiBySubscriber
    Descripción	: Obtener datos de reporte centrales

    Parámetros	:	Descripción
        nuPackageId         Paquete

    Retorno     :
        rfCursor      Cursor de datos

    Autor	: Manuel Mejia
    Fecha	: 22-04-2016

    Historia de Modificaciones
    Fecha       Autor
    ----------  --------------------
    24-06-2017  Mmejia
    Creación.
    *****************************************************************/
    PROCEDURE GetCreditDetaiBySubscriber
    (
      nuSubscriberId  LD_SAMPLE_DETAI.SUBSCRIBER_ID%TYPE,
      rfCursor   OUT  CONSTANTS.TYREFCURSOR
    );

END LDC_BCDATACREDITO;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDC_BCDATACREDITO AS
    --------------------------------------------
    -- Constantes
    --------------------------------------------
    csbVersion            CONSTANT VARCHAR2(250)  := 'SAS200-1112';
    /* Mensaje */
    gnuErrorCode    ge_message.message_id%type;
    gsbMessage      ge_error_log.description%type;
    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------
    FUNCTION fsbVersion
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN csbVersion;
    END fsbVersion;

    /*****************************************************************
    Procedure	: fsbGetNeighborthood
    Descripci?n	:

    Par?metros	:	Descripci?n
      isbName    VARCHAR2    Codigo Executable
    Retorno     :
        Cantidad de actividades planeadas,  0 si no tiene
    Autor	: Manuel Mejia
    Fecha	: 06-06-2017

    Historia de Modificaciones
    Fecha       Autor
    ----------  --------------------
    06-06-2017  Mmejia
    Creaci?n.
    *****************************************************************/
    FUNCTION fsbGetNeighborthood
    (
      inuAddressId IN  OPEN.ab_address.address_id%TYPE
    )RETURN VARCHAR2
    IS
      cnuERROR_GEN  CONSTANT NUMBER := 2741;

      /* Obtiene Direccion */
      CURSOR cuAddress(
                  inuAddressId IN  OPEN.ab_address.address_id%TYPE
                  )
      IS
      SELECT GE_GEOGRA_LOCATION.description   description
        FROM AB_ADDRESS,GE_GEOGRA_LOCATION
      WHERE ADDRESS_ID = inuAddressId
      AND NEIGHBORTHOOD_ID = GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID;

      rccuAddress cuAddress%ROWTYPE;

      sbErrorMessage  VARCHAR2(2000);
      sbDescription GE_GEOGRA_LOCATION.description%TYPE;
    BEGIN
        pkErrors.push('LDC_BCDATACREDITO.fsbGetNeighborthood');
        ut_trace.trace('INICIO LDC_BCDATACREDITO.fsbGetNeighborthood',1);

        --Valida que el la solicitud tenga la ordende trabaja legalizada
        --y qie sea del Tramite VSI
        OPEN cuAddress(inuAddressId);
        FETCH cuAddress INTO rccuAddress;
        IF(cuAddress%NOTFOUND)THEN
          sbDescription :=NULL;
        ELSE
          sbDescription := rccuAddress.description;
        END IF;
        CLOSE cuAddress;

        ut_trace.trace('LDC_BCDATACREDITO.fsbGetNeighborthood sbDescription ['||sbDescription||']',1);

        ut_trace.trace('FIN LDC_BCDATACREDITO.fsbGetNeighborthood',1);
        RETURN  sbDescription;
    EXCEPTION
      WHEN ex.CONTROLLED_ERROR THEN
    	  pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, sbErrorMessage);
    	  pkErrors.pop;
    	  Raise_Application_Error(pkConstante.nuERROR_LEVEL2,sbErrorMessage);
      WHEN LOGIN_DENIED THEN
        pkErrors.pop;
    	  RAISE LOGIN_DENIED;
      WHEN pkConstante.exERROR_LEVEL2 THEN
        -- Error Oracle nivel dos
    	  pkErrors.pop;
    	  RAISE pkConstante.exERROR_LEVEL2;
      WHEN OTHERS THEN
    	  pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, gsbMessage);
    	  pkErrors.pop;
    	  Raise_Application_Error(pkConstante.nuERROR_LEVEL2,gsbMessage);
    END fsbGetNeighborthood;

    /*****************************************************************
    Procedure	: fsbGetLocation
    Descripci?n	:

    Par?metros	:	Descripci?n
      isbName    VARCHAR2    Codigo Executable
    Retorno     :
        Cantidad de actividades planeadas,  0 si no tiene
    Autor	: Manuel Mejia
    Fecha	: 06-06-2017

    Historia de Modificaciones
    Fecha       Autor
    ----------  --------------------
    06-06-2017  Mmejia
    Creaci?n.
    *****************************************************************/
    FUNCTION fsbGetLocation
    (
      inuAddressId IN  OPEN.ab_address.address_id%TYPE
    )RETURN VARCHAR2
    IS
      cnuERROR_GEN  CONSTANT NUMBER := 2741;

      /* Obtiene Direccion */
      CURSOR cuAddress(
                  inuAddressId IN  OPEN.ab_address.address_id%TYPE
                  )
      IS
      SELECT GE_GEOGRA_LOCATION.description   description
        FROM AB_ADDRESS,GE_GEOGRA_LOCATION
      WHERE ADDRESS_ID = inuAddressId
      AND AB_ADDRESS.GEOGRAP_LOCATION_ID = GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID;

      rccuAddress cuAddress%ROWTYPE;

      sbErrorMessage  VARCHAR2(2000);
      sbDescription GE_GEOGRA_LOCATION.description%TYPE;
    BEGIN
        pkErrors.push('LDC_BCDATACREDITO.fsbGetLocation');
        ut_trace.trace('INICIO LDC_BCDATACREDITO.fsbGetLocation',1);

        --Valida que el la solicitud tenga la ordende trabaja legalizada
        --y qie sea del Tramite VSI
        OPEN cuAddress(inuAddressId);
        FETCH cuAddress INTO rccuAddress;
        IF(cuAddress%NOTFOUND)THEN
          sbDescription :=NULL;
        ELSE
          sbDescription := rccuAddress.description;
        END IF;
        CLOSE cuAddress;

        ut_trace.trace('LDC_BCDATACREDITO.fsbGetLocation sbDescription ['||sbDescription||']',1);

        ut_trace.trace('FIN LDC_BCDATACREDITO.fsbGetLocation',1);
        RETURN  sbDescription;
    EXCEPTION
      WHEN ex.CONTROLLED_ERROR THEN
    	  pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, sbErrorMessage);
    	  pkErrors.pop;
    	  Raise_Application_Error(pkConstante.nuERROR_LEVEL2,sbErrorMessage);
      WHEN LOGIN_DENIED THEN
        pkErrors.pop;
    	  RAISE LOGIN_DENIED;
      WHEN pkConstante.exERROR_LEVEL2 THEN
        -- Error Oracle nivel dos
    	  pkErrors.pop;
    	  RAISE pkConstante.exERROR_LEVEL2;
      WHEN OTHERS THEN
    	  pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, gsbMessage);
    	  pkErrors.pop;
    	  Raise_Application_Error(pkConstante.nuERROR_LEVEL2,gsbMessage);
    END fsbGetLocation;


    /*****************************************************************
    Procedure	: fsbGetAddress
    Descripci?n	:

    Par?metros	:	Descripci?n
      isbName    VARCHAR2    Codigo Executable
    Retorno     :
        Cantidad de actividades planeadas,  0 si no tiene
    Autor	: Manuel Mejia
    Fecha	: 06-06-2017

    Historia de Modificaciones
    Fecha       Autor
    ----------  --------------------
    06-06-2017  Mmejia
    Creaci?n.
    *****************************************************************/
    FUNCTION fsbGetAddress
    (
      inuAddressId IN  OPEN.ab_address.address_id%TYPE
    )RETURN VARCHAR2
    IS
      cnuERROR_GEN  CONSTANT NUMBER := 2741;

      /* Obtiene Direccion */
      CURSOR cuAddress(
                  inuAddressId IN  OPEN.ab_address.address_id%TYPE
                  )
      IS
      SELECT AB_ADDRESS.Address   description
        FROM AB_ADDRESS
      WHERE ADDRESS_ID = inuAddressId;

      rccuAddress cuAddress%ROWTYPE;

      sbErrorMessage  VARCHAR2(2000);
      sbDescription GE_GEOGRA_LOCATION.description%TYPE;
    BEGIN
        pkErrors.push('LDC_BCDATACREDITO.fsbGetAddress');
        ut_trace.trace('INICIO LDC_BCDATACREDITO.fsbGetAddress',1);

        --Valida que el la solicitud tenga la ordende trabaja legalizada
        --y qie sea del Tramite VSI
        OPEN cuAddress(inuAddressId);
        FETCH cuAddress INTO rccuAddress;
        IF(cuAddress%NOTFOUND)THEN
          sbDescription :=NULL;
        ELSE
          sbDescription := rccuAddress.description;
        END IF;
        CLOSE cuAddress;

        ut_trace.trace('LDC_BCDATACREDITO.fsbGetAddress sbDescription ['||sbDescription||']',1);

        ut_trace.trace('FIN LDC_BCDATACREDITO.fsbGetAddress',1);
        RETURN  sbDescription;
    EXCEPTION
      WHEN ex.CONTROLLED_ERROR THEN
    	  pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, sbErrorMessage);
    	  pkErrors.pop;
    	  Raise_Application_Error(pkConstante.nuERROR_LEVEL2,sbErrorMessage);
      WHEN LOGIN_DENIED THEN
        pkErrors.pop;
    	  RAISE LOGIN_DENIED;
      WHEN pkConstante.exERROR_LEVEL2 THEN
        -- Error Oracle nivel dos
    	  pkErrors.pop;
    	  RAISE pkConstante.exERROR_LEVEL2;
      WHEN OTHERS THEN
    	  pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, gsbMessage);
    	  pkErrors.pop;
    	  Raise_Application_Error(pkConstante.nuERROR_LEVEL2,gsbMessage);
    END fsbGetAddress;

    /*****************************************************************
    Function	: GetCreditDetaiBySubscriber
    Descripción	: Obtener datos de reporte

    Parámetros	:	Descripción
        nuPackageId         Paquete

    Retorno     :
        rfCursor      Cursor de datos

    Autor	: Manuel Mejia
    Fecha	: 22-04-2016

    Historia de Modificaciones
    Fecha       Autor
    ----------  --------------------
    24-06-2017  Mmejia
    Creación.
    *****************************************************************/
    PROCEDURE GetCreditDetaiBySubscriber
    (
      nuSubscriberId  LD_SAMPLE_DETAI.SUBSCRIBER_ID%TYPE,
      rfCursor   OUT  CONSTANTS.TYREFCURSOR
    )
    IS

    BEGIN
      pkErrors.push('LDC_BCDATACREDITO.GetCreditDetaiBySubscriber');
      ut_trace.trace('INICIO LDC_BCDATACREDITO.GetCreditDetaiBySubscriber',1);

        /* Obtiene los reportes */
        OPEN rfCursor FOR
        SELECT  DISTINCT ACCOUNT_NUMBER "Numero Obligacion",
                SUBSCRIPTION_ID "Contrato",
                PRODUCT_ID "Producto",
                CASE
                WHEN  responsible_dc = 0 THEN
                  'Deudor'
                WHEN responsible_dc = 1 THEN
                  'Codeudor'
                END
                "Tipo reporte",
                REGISTER_DATE,
                CASE
                WHEN  SOURCE = 'GNEG' THEN
                  'Gas Negociacion'
                WHEN  SOURCE = 'GFVE' THEN
                  'Financiacion Venta'
                WHEN  SOURCE = 'GFRE' THEN
                  'Facturacion recurrente'
                ELSE
                  ''
                END
                "Fuente",
                CASE
                  WHEN IS_APPROVED = 'Y' OR  IS_APPROVED IS NULL THEN
                    'Si'
                  ELSE
                    'No'
                  END
                  "Aprobado"
        FROM   /*+ LDC_BCDATACREDITO.GetCreditDetaiBySubscriber */
                LD_SAMPLE master,
                LD_SAMPLE_DETAI detail
        WHERE
        ----AND master.type_sector =2
        master.credit_bureau_id =1--DATACREDITO
        AND master.sample_id =detail.sample_id
        AND detail.SUBSCRIBER_ID = nuSubscriberId;

      ut_trace.trace('FIN LDC_BCDATACREDITO.GetCreditDetaiBySubscriber',1);
      pkErrors.pop;
    EXCEPTION
      WHEN LOGIN_DENIED THEN
    	  pkErrors.pop;
    	  RAISE LOGIN_DENIED;
      WHEN pkConstante.exERROR_LEVEL2 THEN
    	  -- Error Oracle nivel dos
    	  pkErrors.pop;
    	  RAISE pkConstante.exERROR_LEVEL2;
      WHEN OTHERS THEN
    	  pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, gsbMessage);
    	  pkErrors.pop;
    	  raise_application_error(pkConstante.nuERROR_LEVEL2,gsbMessage);
    END GetCreditDetaiBySubscriber;

  /*****************************************************************
  Function	: fnuGetProcessedRecords
  Descripción	: Devuelve la cantidad de registros a procesos por el proceso
                de centrales de riesgo

  Parámetros	:	Descripción
  Retorno     :

  Autor	: Manuel Mejia
  Fecha	: 22-04-2016

  Historia de Modificaciones
  Fecha       Autor
  ----------  --------------------
  24-06-2017  Mmejia
  Creación.
  *****************************************************************/
  FUNCTION fnuGetProcessedRecords
  (
  inuCicoAno       NUMBER,
  inuCicoMes       NUMBER,
  isbProductDepart VARCHAR2,
  isbProductLocal  VARCHAR2,
  isbProductCycles VARCHAR2,
  isbCategories    VARCHAR2,
  isbSubCategories VARCHAR2,
  isbDateIniDataCredito VARCHAR2
  )RETURN NUMBER
  IS
    sbSql     VARCHAR2(8000);
    ocuCursor CONSTANTS.TYREFCURSOR;
    nuCont NUMBER :=0;
  BEGIN
    pkErrors.push('LDC_BCDATACREDITO.fnuGetProcessedRecords');
    ut_trace.trace('INICIO LDC_BCDATACREDITO.fnuGetProcessedRecords',1);
    ut_trace.trace('  LDC_BCDATACREDITO.fnuGetProcessedRecords isbProductDepart['||isbProductDepart||']',1);
    ut_trace.trace('  LDC_BCDATACREDITO.fnuGetProcessedRecords isbProductCycles['||isbProductCycles||']',1);

    EXECUTE IMMEDIATE  'ALTER SESSION SET NLS_DATE_FORMAT = ''DD-MM-YYYY HH24:MI:SS''';

    sbSql :=
    'SELECT Count(*)
    FROM (
    SELECT /*+ INDEX(CF IDX_CC_FINANCING_REQUEST_01)*/
    DISTINCT CC.PRODUCTO PRODUCT_ID,
            CC.CONTRATO SUBSCRIPTION_ID,
            CC.ESTADO_FINANCIERO SESUESFN,
            AB.Address ADDRESS,
            AB.ADDRESS_ID,
            (SELECT GE_GEOGRA_LOCATION.description   description
              FROM GE_GEOGRA_LOCATION
            WHERE AB.NEIGHBORTHOOD_ID = GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID
            )
            NEIGHBORTHOOD,
            GEO1.DESCRIPTION  LOCATION,
            (SELECT GEO2.description   description
              FROM GE_GEOGRA_LOCATION GEO2
            WHERE GEO1.GEO_LOCA_FATHER_ID = GEO2.GEOGRAP_LOCATION_ID
            )
            DEPARTAMENTO,
            subs.IDENT_TYPE_ID,
            subs.IDENTIFICATION,
            subs.phone PHONE_NUMBER,
            subs.subscriber_name||'' ''||subs.subs_last_name FULL_NAME,
            ''D'' REPORT_TYPE,--DEUDOR D CODEDOR C
            MP.PACKAGE_ID PACKAGE_ID,
            CF.FINANCING_ID FINANCING_ID,
            ''GNEG'' SOURCE,
            subs.SUBSCRIBER_ID,
            CC.EDAD
            FROM    GE_SUBSCRIBER SUBS,
                        LDC_OSF_SESUCIER CC,
                        LDC_OSF_DIFERIDO DI,
                        MO_PACKAGES MP,
                        CC_FINANCING_REQUEST  CF,
                        SUSCRIPC SS,
                        AB_ADDRESS AB,
                        GE_GEOGRA_LOCATION GEO1
                WHERE
                CF.SUBSCRIPTION_ID = SS.SUSCCODI
                AND SS.SUSCCLIE = SUBS.SUBSCRIBER_ID
                AND     CC.TIPO_PRODUCTO = 7014
                AND     SS.SUSCCODI = CC.CONTRATO
                AND     CC.ESTADO_CORTE NOT IN (95,96,110)--validacion de estados de corte
                AND     CF.PACKAGE_ID=MP.PACKAGE_ID
                AND     DI.DIFECOFI = CF.FINANCING_ID
                AND     DI.DIFENUSE = CC.PRODUCTO
                AND     CF.RECORD_PROGRAM=''GCNED''
                AND     AB.ADDRESS_ID = SUBS.ADDRESS_ID
                AND     AB.GEOGRAP_LOCATION_ID = GEO1.GEOGRAP_LOCATION_ID
                AND     CC.NUANO = DI.difeano
                AND     CC.NUMES = DI.difemes
                AND     CC.NUANO = :inuCicoAno
                AND     CC.NUMES = :inuCicoMes
                AND     DI.difefein >= :isbDateIniDataCredito';

    IF(isbProductDepart <> '-1')THEN
      sbSql := sbSql||' AND GEO1.GEO_LOCA_FATHER_ID IN (SELECT column_value
                              FROM TABLE(LDC_BOUTILITIES.SPLITstrings('''||isbProductDepart||''','',''))
                              )';
    END IF;

    IF(isbProductLocal <> '-1')THEN
      sbSql := sbSql||' AND AB.GEOGRAP_LOCATION_ID IN (SELECT column_value
                              FROM TABLE(LDC_BOUTILITIES.SPLITstrings('''||isbProductLocal||''','',''))
                              )';
    END IF;

   IF(isbProductCycles <> '-1')THEN
      sbSql := sbSql||' AND     ss.sesucicl IN (SELECT column_value
                              FROM TABLE(LDC_BOUTILITIES.SPLITstrings('''||isbProductCycles||''','',''))
                              )';

   END IF;

   IF(isbCategories <> '-1')THEN
   sbSql := sbSql||' AND     ss.sesucate IN (SELECT column_value
                              FROM TABLE(LDC_BOUTILITIES.SPLITstrings('''||isbCategories||''','',''))
                              )';

   END IF;

   IF(isbSubCategories <> '-1')THEN
   sbSql := sbSql||' AND     ss.sesusuca IN (SELECT column_value
                              FROM TABLE(LDC_BOUTILITIES.SPLITstrings('''||isbSubCategories||''','',''))
                              )';

   END IF;

   sbSql := sbSql||')';
   ut_trace.trace('  LDC_BCDATACREDITO.fnuGetProcessedRecords sbSql['||sbSql||']',1);
    OPEN ocuCursor FOR sbSql USING inuCicoAno,inuCicoMes,isbDateIniDataCredito;

    LOOP
      FETCH ocuCursor INTO nuCont;
        EXIT WHEN ocuCursor%NOTFOUND;
        Dbms_Output.put_line(nuCont );
    END LOOP;

    ut_trace.trace('FIN LDC_BCDATACREDITO.fnuGetProcessedRecords',1);
    RETURN nuCont;
  EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
        RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        Errors.setError;
        RAISE ex.CONTROLLED_ERROR;
  END fnuGetProcessedRecords;


  /*****************************************************************
  Function	: GetProdsPerSusc
  Descripción	: Devuelve los registros a procesos por el proceso
                de centrales de riesgo

  Parámetros	:	Descripción
  Retorno     :

  Autor	: Manuel Mejia
  Fecha	: 22-04-2016

  Historia de Modificaciones
  Fecha       Autor
  ----------  --------------------
  24-06-2017  Mmejia
  Creación.
  *****************************************************************/
  PROCEDURE GetProdsPerSusc
  (
  inuCicoAno       NUMBER,
  inuCicoMes       NUMBER,
  isbProductDepart VARCHAR2,
  isbProductLocal  VARCHAR2,
  isbProductCycles VARCHAR2,
  isbCategories    VARCHAR2,
  isbSubCategories VARCHAR2,
  isbDateIniDataCredito VARCHAR2,
  inuProductId     pr_product.product_id%TYPE,
  ocuCursor OUT CONSTANTS.TYREFCURSOR
  )
  IS

    sbSql  VARCHAR2(8000);
  BEGIN
    ut_trace.trace('INICIO LDC_BCDATACREDITO.GetProdsPerSusc', 10);
    EXECUTE IMMEDIATE  'ALTER SESSION SET NLS_DATE_FORMAT = ''DD-MM-YYYY HH24:MI:SS''';

    sbSql :=
    'SELECT /*+ INDEX(CF IDX_CC_FINANCING_REQUEST_01)*/
                        CC.PRODUCTO PRODUCT_ID,
                        CC.CONTRATO SUBSCRIPTION_ID,
                        CC.ESTADO_FINANCIERO SESUESFN,
                        AB.Address ADDRESS,
                        AB.ADDRESS_ID,
                        (SELECT GE_GEOGRA_LOCATION.description   description
                          FROM GE_GEOGRA_LOCATION
                        WHERE AB.NEIGHBORTHOOD_ID = GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID
                        )
                        NEIGHBORTHOOD,
                        GEO1.DESCRIPTION  LOCATION,
                        (SELECT GEO2.description   description
                          FROM GE_GEOGRA_LOCATION GEO2
                        WHERE GEO1.GEO_LOCA_FATHER_ID = GEO2.GEOGRAP_LOCATION_ID
                        )
                        DEPARTAMENTO,
                        subs.IDENT_TYPE_ID,
                        subs.IDENTIFICATION,
                        subs.phone PHONE_NUMBER,
                        subs.subscriber_name||'' ''||subs.subs_last_name FULL_NAME,
                        ''D'' REPORT_TYPE,--DEUDOR D CODEDOR C
                        MP.PACKAGE_ID PACKAGE_ID,
                        CF.FINANCING_ID FINANCING_ID,
                        ''GNEG'' SOURCE,
                        subs.SUBSCRIBER_ID,
                        CC.EDAD,
                        SUM(DIFESAPE)SALDO_DIFE
                FROM    GE_SUBSCRIBER SUBS,
                        LDC_OSF_SESUCIER CC,
                        LDC_OSF_DIFERIDO DI,
                        MO_PACKAGES MP,
                        CC_FINANCING_REQUEST  CF,
                        SUSCRIPC SS,
                        AB_ADDRESS AB,
                        GE_GEOGRA_LOCATION GEO1
                WHERE
                CF.SUBSCRIPTION_ID = SS.SUSCCODI
                AND SS.SUSCCLIE = SUBS.SUBSCRIBER_ID
                AND     CC.TIPO_PRODUCTO = 7014
                AND     SS.SUSCCODI = CC.CONTRATO
                AND     CC.ESTADO_CORTE NOT IN (95,96,110)--validacion de estados de corte
                AND     CF.PACKAGE_ID=MP.PACKAGE_ID
                AND     DI.DIFECOFI = CF.FINANCING_ID
                AND     DI.DIFENUSE = CC.PRODUCTO
                AND     CF.RECORD_PROGRAM=''GCNED''
                AND     AB.ADDRESS_ID = SUBS.ADDRESS_ID
                AND     AB.GEOGRAP_LOCATION_ID = GEO1.GEOGRAP_LOCATION_ID
                AND     CC.NUANO = DI.DIFEANO
                AND     CC.NUMES = DI.DIFEMES
                AND     CC.NUANO = :inuCicoAno
                AND     CC.NUMES = :inuCicoMes
                AND     DI.difefein >=:isbDateIniDataCredito';
    IF(inuProductId <> -1)THEN
      sbSql := sbSql||' AND     CC.PRODUCTO = '||inuProductId;
    END IF;

    IF(isbProductDepart <> '-1')THEN
      sbSql := sbSql||' AND GEO1.GEO_LOCA_FATHER_ID IN (SELECT column_value
                              FROM TABLE(LDC_BOUTILITIES.SPLITstrings('''||isbProductDepart||''','',''))
                              )';
    END IF;

    IF(isbProductLocal <> '-1')THEN
      sbSql := sbSql||' AND AB.GEOGRAP_LOCATION_ID IN (SELECT column_value
                              FROM TABLE(LDC_BOUTILITIES.SPLITstrings('''||isbProductLocal||''','',''))
                              )';
    END IF;

   IF(isbProductCycles <> '-1')THEN
      sbSql := sbSql||' AND     ss.sesucicl IN (SELECT column_value
                              FROM TABLE(LDC_BOUTILITIES.SPLITstrings('''||isbProductCycles||''','',''))
                              )';

   END IF;

   IF(isbCategories <> '-1')THEN
   sbSql := sbSql||' AND     ss.sesucate IN (SELECT column_value
                              FROM TABLE(LDC_BOUTILITIES.SPLITstrings('''||isbCategories||''','',''))
                              )';

   END IF;

   IF(isbSubCategories <> '-1')THEN
   sbSql := sbSql||' AND     ss.sesusuca IN (SELECT column_value
                              FROM TABLE(LDC_BOUTILITIES.SPLITstrings('''||isbSubCategories||''','',''))
                              )';

   END IF;

   sbSql := sbSql||' GROUP BY   CC.PRODUCTO ,
                        CC.CONTRATO,
                        CC.ESTADO_FINANCIERO ,
                        AB.Address ,
                        AB.ADDRESS_ID,
                        GEO1.DESCRIPTION ,
                        subs.IDENT_TYPE_ID,
                        subs.IDENTIFICATION,
                        subs.phone ,
                        subs.subscriber_name,
                        subs.subs_last_name,
                        MP.PACKAGE_ID ,
                        CF.FINANCING_ID ,
                        subs.SUBSCRIBER_ID,
                        CC.EDAD,
                        AB.NEIGHBORTHOOD_ID,
                        GEO1.GEO_LOCA_FATHER_ID';

   ut_trace.trace('  LDC_BCDATACREDITO.GetProdsPerSusc sbSql['||sbSql||']',1);
   OPEN ocuCursor FOR sbSql USING inuCicoAno,inuCicoMes,isbDateIniDataCredito;

    ut_trace.trace('FIN LDC_BCDATACREDITO.GetProdsPerSusc', 10);
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;
  END GetProdsPerSusc;

END LDC_BCDATACREDITO;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_BCDATACREDITO', 'ADM_PERSON'); 
END;
/
