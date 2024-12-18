CREATE OR REPLACE PACKAGE adm_person.ldc_boimpfacturaconstructora IS

  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  24/06/2024   Adrianavg   OSF-2849: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
    globalsesion  NUMBER;
    GlobalFormate VARCHAR2(4);

    FUNCTION FSBVERSION RETURN VARCHAR2;

    PROCEDURE Insertbillclob
    (
        inufactcodi     IN factura.factcodi%TYPE,
        inuCurrent      IN NUMBER,
        inuTotal        IN NUMBER,
        onuErrorCode    OUT NUMBER,
        osbErrorMessage OUT VARCHAR2
    );

    FUNCTION frffacturasconstructora RETURN pkConstante.tyRefCursor;

END LDC_BOImpFacturaConstructora;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_BOIMPFACTURACONSTRUCTORA IS

    CSBVERSION CONSTANT VARCHAR2(40) := 'NC_2593_1';

    csbNOMPKG            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT||'.';--constante nombre del paquete
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;--Nivel de traza para este paquete.


    /*Funcion que devuelve la version del pkg*/
    FUNCTION FSBVERSION RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END FSBVERSION;

    /*****************************************************************
      Propiedad intelectual de PETI (c).

     Unidad         : Generatebilldata
     Descripcion    : Acumula la estructura de las facturas
                      de constructoras almacenadas en la entidad
                      ld_temp_clob_fact para una sesion de usuario
                      determinada

     Autor          : Sergio Mejia Rivera - Optima Consulting SAS
     Fecha          : 15/01/2014

     Parametros       Descripcion
     ============     ===================
     onuErrorCode     Codigo de error
     osbErrorMessage  Mensaje de error

     Historia de Modificaciones                                              factura
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     17/01/2014       smejia                Creacion
    ******************************************************************/
    PROCEDURE Generatebilldata
    (
        onuErrorCode    OUT NUMBER,
        osbErrorMessage OUT VARCHAR2
    ) IS

        CURSOR cuTemp_Clob(inusession NUMBER) IS
            SELECT l.package_id,
                   l.temp_clob_fact_id,
                   l.template_id,
                   l.docudocu,
                   l.sesion
            FROM ld_temp_clob_fact l
            WHERE l.sesion = inusession
                  AND l.package_id IS NOT NULL;

        nuParamConfexme ld_parameter.numeric_value%TYPE;
        nuPackType      mo_packages.package_type_id%TYPE;
        nuConfexme      ed_confexme.coemcodi%TYPE;
        rcExtMixConf    ed_confexme%ROWTYPE;
        nuFormatCode    ed_formato.formcodi%TYPE;
        nuFactura       cuencobr.cucofact%TYPE;
        nubilldocument  ld_parameter.parameter_id%TYPE;
        clfactclob      CLOB;
        rctempclob      Dald_Temp_Clob_Fact.styLD_temp_clob_fact;
        nuindex         NUMBER;

        csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'Generatebilldata';

    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        pkg_traza.trace('-- PASO 5.1.Inicio LDC_BOImpFacturaConstructora.Generatebilldata', pkg_traza.cnuNivelTrzDef);

        pkg_traza.trace('-- PASO 5.2LDC_BOImpFacturaConstructora.globalsesion = ' ||
                       globalsesion, pkg_traza.cnuNivelTrzDef);

        /*Obtiene el valor del parametro CONFEXME_FACTURA_CONSTRUCTORA*/ -- ld_parameter
        nuParamConfexme := dald_parameter.fnuGetNumeric_Value('CONFEXME_FACTURA_CONSTRUCTORA');

        pkg_traza.trace('-- PASO 5.3 CONFEXME = ' || nuParamConfexme, pkg_traza.cnuNivelTrzDef);

        FOR rcTemp_Clob IN cuTemp_Clob(globalsesion)
        LOOP

            pkg_traza.trace('-- PASO 5.4dentro del loop, procesando solicitud ' ||
                           rcTemp_Clob.Package_Id, pkg_traza.cnuNivelTrzDef);

            pkg_traza.trace('-- PASO 5.5solicitud = ' || rcTemp_Clob.Package_Id, pkg_traza.cnuNivelTrzDef);

            /*Obtener template*/
            IF (rcExtMixConf.coempadi IS NULL) THEN

                IF (nuParamConfexme IS NOT NULL) THEN

                    /* Asocia el confexme obtenido del parametro */ -- ed_confexme
                    nuConfexme := nuParamConfexme;
                    pkg_traza.trace('-- PASO 5.6nuConfexme = ' || nuConfexme, pkg_traza.cnuNivelTrzDef);

                    /*Obtiene nombre de plantilla*/
                    rcExtMixConf := pktblED_ConfExme.frcGetRecord(nuConfexme);

                    ld_bosubsidy.globalsbTemplate := rcExtMixConf.coempadi;
                    pkg_traza.trace('-- PASO 5.7 rcExtMixConf.coempadi = ' ||
                                   rcExtMixConf.coempadi, pkg_traza.cnuNivelTrzDef);

                    IF (rcExtMixConf.coempadi IS NULL) THEN
                        pkg_traza.trace('-- PASO 5.8 rcExtMixConf.coempadi IS null', pkg_traza.cnuNivelTrzDef);
                        onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                        osbErrorMessage := 'Error al buscar el template para realizar la mezcla a partir del identificador: ' ||
                                           nuConfexme ||
                                           ', de la tabla ED_ConfExme';
                        GOTO error;

                    END IF;

                    --  Obtiene el ID del formato a partir del identificador  ed_confexme  ed_document
                    nuFormatCode := pkBOInsertMgr.GetCodeFormato(rcExtMixConf.coempada);
                    pkg_traza.trace('-- PASO 5.9 nuFormatCode:' || nuFormatCode, pkg_traza.cnuNivelTrzDef);
                ELSE
                    pkg_traza.trace('-- PASO 5.pkg_traza.cnuNivelTrzDef error al buscar el template para realizar la mezcla', pkg_traza.cnuNivelTrzDef);
                    onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                    osbErrorMessage := 'Error al buscar el template para realizar la mezcla';
                    GOTO error;

                END IF;

            END IF;

            /*Obtener la factura asociada a la solicitud*/

            nuFactura := to_number(rcTemp_Clob.template_id); --rcTemp_Clob.temp_clob_fact_id;   ld_temp_clob_fact

            pkg_traza.trace('-- PASO 5.11 Factura recuperada ' ||
                           to_number(rcTemp_Clob.template_id), pkg_traza.cnuNivelTrzDef);

            IF nuFactura IS NOT NULL THEN

                pkg_traza.trace('-- PASO 5.11 Obtener el tipo de documento de la factura ' ||
                               nuFactura, pkg_traza.cnuNivelTrzDef);
                /*Obtener el tipo de documento de la factura*/
                nubilldocument := pktblfactura.fnuGetFACTCONS(nuFactura, NULL); -- factura

                pkg_traza.trace('-- PASO 5.12 nubilldocument = ' ||
                               nubilldocument, pkg_traza.cnuNivelTrzDef);
                pkg_traza.trace('-- PASO 5.13 nuFormatCode = ' || nuFormatCode, pkg_traza.cnuNivelTrzDef);
                pkg_traza.trace('-- PASO 5.14 nuFactura = ' || nuFactura, pkg_traza.cnuNivelTrzDef);

                IF daed_document.fblexist(nuFactura, nubilldocument) THEN
                    pkg_traza.trace('-- PASO 5.15.1.1 Entro daed_document', pkg_traza.cnuNivelTrzDef);
                    daed_document.delrecord(nuFactura, nubilldocument);
                    pkg_traza.trace('-- PASO 5.15 Elimino el registro de ED_DOCUMENT ', pkg_traza.cnuNivelTrzDef);
                END IF;

                pkg_traza.trace('-- PASO 5.15.1 nuFormatCode = ' || nuFormatCode, pkg_traza.cnuNivelTrzDef);
                --  Genera los datos de la factura
                pkBOPrintingProcess.ProcessSaleBill(nuFormatCode, nuFactura, pkConstante.SI, clfactclob); --out

                pkg_traza.trace('-- PASO 5.15.2 salio clfactclob = ' || clfactclob, pkg_traza.cnuNivelTrzDef);
                rctempclob := NULL;

                nuindex := LD_BOSequence.Fnuseqld_temp_clob_fact;
                pkg_traza.trace('-- PASO 5.16 Insertar el clob en la entidad ld_temp_clob_fact = ' ||
                               globalsesion, pkg_traza.cnuNivelTrzDef);
                /*Insertar el clob en la entidad ld_temp_clob_fact*/
                rctempclob.temp_clob_fact_id := rcTemp_Clob.temp_clob_fact_id;
                rctempclob.sesion            := globalsesion;
                rctempclob.docudocu          := clfactclob;
                rctempclob.template_id       := rcTemp_Clob.template_id; --paulaag
                rctempclob.package_id        := rcTemp_Clob.package_id; --paulaag
                /*Insertar registro en entidad ld_temp_clob_fact*/
                Dald_Temp_Clob_Fact.updRecord(rctempclob);
                pkg_traza.trace('-- PASO 5.17 Actualizo registro en Dald_Temp_Clob_Fact con data:' ||
                               'rctempclob.temp_clob_fact_id =>' ||
                               rctempclob.temp_clob_fact_id ||
                               'rctempclob.sesion =>' || rctempclob.sesion ||
                               'rctempclob.template_id=>' ||
                               rctempclob.template_id ||
                               'rctempclob.package_id=>' ||
                               rctempclob.package_id, pkg_traza.cnuNivelTrzDef);
            ELSE
                pkg_traza.trace('-- PASO 5.18 no se ha obtenido una factura desde el Proceso de Batch', pkg_traza.cnuNivelTrzDef);
                onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                osbErrorMessage := '[Error] no se ha obtenido una factura desde el Proceso de Batch';
                GOTO error;
            END IF;

            /*Fin obtener CLOB de la solicitud procesada*/
            <<error>>
            NULL;
        END LOOP;

        pkg_traza.trace('-- PASO 5.19 Fin LDC_BOImpFacturaConstructora.Generatebilldata', pkg_traza.cnuNivelTrzDef);

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN Pkg_Error.CONTROLLED_ERROR THEN
            RAISE Pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Pkg_Error.setError;
            RAISE Pkg_Error.CONTROLLED_ERROR;
    END Generatebilldata;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

     Unidad         : GeneratebilldataFacFis
     Descripcion    : Acumula la estructura de las facturas
                      de constructoras almacenadas en la entidad
                      ld_temp_clob_fact para una sesion de usuario
                      determinada. Esta es la factura fiscal

     Autor          : Manuel Mejia
     Fecha          : 08/05/2015

     Parametros       Descripcion
     ============     ===================
     onuErrorCode     Codigo de error
     osbErrorMessage  Mensaje de error

     Historia de Modificaciones                                              factura
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     08/05/2015       Mmejia                Creacion
    ******************************************************************/
    PROCEDURE GeneratebilldataFacFis
    (
        onuErrorCode    OUT NUMBER,
        osbErrorMessage OUT VARCHAR2
    ) IS

        CURSOR cuTemp_Clob(inusession NUMBER) IS
            SELECT l.package_id,
                   l.temp_clob_fact_id,
                   l.template_id,
                   l.docudocu,
                   l.sesion
            FROM ld_temp_clob_fact l
            WHERE l.sesion = inusession
                  AND l.package_id IS NOT NULL;

        nuParamConfexme ld_parameter.numeric_value%TYPE;
        nuPackType      mo_packages.package_type_id%TYPE;
        nuConfexme      ed_confexme.coemcodi%TYPE;
        rcExtMixConf    ed_confexme%ROWTYPE;
        nuFormatCode    ed_formato.formcodi%TYPE;
        nuFactura       cuencobr.cucofact%TYPE;
        nubilldocument  ld_parameter.parameter_id%TYPE;
        clfactclob      CLOB;
        rctempclob      Dald_Temp_Clob_Fact.styLD_temp_clob_fact;
        nuindex         NUMBER;

        csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'GeneratebilldataFacFis';

    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        pkg_traza.trace('-- PASO 5.1.Inicio LDC_BOImpFacturaConstructora.GeneratebilldataFacFis', pkg_traza.cnuNivelTrzDef);

        pkg_traza.trace('-- PASO 5.2LDC_BOImpFacturaConstructora.globalsesion = ' ||
                       globalsesion, pkg_traza.cnuNivelTrzDef);

        IF (GlobalFormate = 'FS') THEN
            /*Obtiene el valor del parametro CONFEXME_FACTFISC_CONSTRUCTORA*/ -- ld_parameter

            nuParamConfexme := dald_parameter.fnuGetNumeric_Value('CONFEXME_FACTFISC_CONS_OS');

        ELSE
            nuParamConfexme := dald_parameter.fnuGetNumeric_Value('CONFEXME_FACTFISC_CONSTRUCTORA');
        END IF;

        pkg_traza.trace('-- PASO 5.3 CONFEXME = ' || nuParamConfexme, pkg_traza.cnuNivelTrzDef);

        FOR rcTemp_Clob IN cuTemp_Clob(globalsesion)
        LOOP

            pkg_traza.trace('-- PASO 5.4dentro del loop, procesando solicitud ' ||
                           rcTemp_Clob.Package_Id, pkg_traza.cnuNivelTrzDef);

            pkg_traza.trace('-- PASO 5.5solicitud = ' || rcTemp_Clob.Package_Id, pkg_traza.cnuNivelTrzDef);

            /*Obtener template*/
            IF (rcExtMixConf.coempadi IS NULL) THEN

                IF (nuParamConfexme IS NOT NULL) THEN

                    /* Asocia el confexme obtenido del parametro */ -- ed_confexme
                    nuConfexme := nuParamConfexme;
                    pkg_traza.trace('-- PASO 5.6nuConfexme = ' || nuConfexme, pkg_traza.cnuNivelTrzDef);

                    /*Obtiene nombre de plantilla*/
                    rcExtMixConf := pktblED_ConfExme.frcGetRecord(nuConfexme);

                    ld_bosubsidy.globalsbTemplate := rcExtMixConf.coempadi;
                    pkg_traza.trace('-- PASO 5.7 rcExtMixConf.coempadi = ' ||
                                   rcExtMixConf.coempadi, pkg_traza.cnuNivelTrzDef);

                    IF (rcExtMixConf.coempadi IS NULL) THEN
                        pkg_traza.trace('-- PASO 5.8 rcExtMixConf.coempadi IS null', pkg_traza.cnuNivelTrzDef);
                        onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                        osbErrorMessage := 'Error al buscar el template para realizar la mezcla a partir del identificador: ' ||
                                           nuConfexme ||
                                           ', de la tabla ED_ConfExme';
                        GOTO error;

                    END IF;

                    --  Obtiene el ID del formato a partir del identificador  ed_confexme  ed_document
                    nuFormatCode := pkBOInsertMgr.GetCodeFormato(rcExtMixConf.coempada);
                    pkg_traza.trace('-- PASO 5.9 nuFormatCode:' || nuFormatCode, pkg_traza.cnuNivelTrzDef);
                ELSE
                    pkg_traza.trace('-- PASO 5.pkg_traza.cnuNivelTrzDef error al buscar el template para realizar la mezcla', pkg_traza.cnuNivelTrzDef);
                    onuErrorCode    := Ld_Boconstans.cnuGeneric_Error;
                    osbErrorMessage := 'Error al buscar el template para realizar la mezcla';
                    GOTO error;

                END IF;

            END IF;

            /*Obtener la factura asociada a la solicitud*/

            nuFactura := to_number(rcTemp_Clob.template_id); --rcTemp_Clob.temp_clob_fact_id;   ld_temp_clob_fact

            pkg_traza.trace('-- PASO 5.11 Factura recuperada ' ||
                           to_number(rcTemp_Clob.template_id), pkg_traza.cnuNivelTrzDef);

            IF nuFactura IS NOT NULL THEN

                pkg_traza.trace('-- PASO 5.11 Obtener el tipo de documento de la factura ' ||
                               nuFactura, pkg_traza.cnuNivelTrzDef);
                /*Obtener el tipo de documento de la factura*/

                nubilldocument := pktblfactura.fnuGetFACTCONS(nuFactura, NULL); -- factura

                pkg_traza.trace('-- PASO 5.12 nubilldocument = ' ||
                               nubilldocument, pkg_traza.cnuNivelTrzDef);
                pkg_traza.trace('-- PASO 5.13 nuFormatCode = ' || nuFormatCode, pkg_traza.cnuNivelTrzDef);
                pkg_traza.trace('-- PASO 5.14 nuFactura = ' || nuFactura, pkg_traza.cnuNivelTrzDef);

                IF daed_document.fblexist(nuFactura, nubilldocument) THEN
                    daed_document.delrecord(nuFactura, nubilldocument);
                    pkg_traza.trace('-- PASO 5.15 Elimino el registro de ED_DOCUMENT ', pkg_traza.cnuNivelTrzDef);
                END IF;

                pkg_traza.trace('-- PASO 5.15.1 nuFormatCode = ' || nuFormatCode, pkg_traza.cnuNivelTrzDef);
                --  Genera los datos de la factura

                BEGIN
                    pkBOPrintingProcess.ProcessSaleBill(nuFormatCode, nuFactura, pkConstante.SI, clfactclob); --out
                EXCEPTION
                        WHEN Pkg_Error.CONTROLLED_ERROR THEN
                            Pkg_Error.GetError (onuErrorCode,osbErrorMessage);
                            RAISE Pkg_Error.CONTROLLED_ERROR;
                        WHEN OTHERS THEN
                            Pkg_Error.setError;
                            onuErrorCode := SQLCODE;
                            osbErrorMessage := SQLERRM;
                            RAISE Pkg_Error.CONTROLLED_ERROR;
                END;
                pkg_traza.trace('-- PASO 5.15.1 clfactclob = ' || clfactclob, pkg_traza.cnuNivelTrzDef);
                rctempclob := NULL;

                nuindex := LD_BOSequence.Fnuseqld_temp_clob_fact;
                pkg_traza.trace('-- PASO 5.16 Insertar el clob en la entidad ld_temp_clob_fact = ' ||
                               globalsesion, pkg_traza.cnuNivelTrzDef);
                /*Insertar el clob en la entidad ld_temp_clob_fact*/
                rctempclob.temp_clob_fact_id := rcTemp_Clob.temp_clob_fact_id;
                rctempclob.sesion            := globalsesion;
                rctempclob.docudocu          := clfactclob;
                rctempclob.template_id       := rcTemp_Clob.template_id; --paulaag
                rctempclob.package_id        := rcTemp_Clob.package_id ;

                /*Insertar registro en entidad ld_temp_clob_fact*/
                Dald_Temp_Clob_Fact.updRecord(rctempclob);
                pkg_traza.trace('-- PASO 5.17 Actualizo registro en Dald_Temp_Clob_Fact con data:' ||
                               'rctempclob.temp_clob_fact_id =>' ||
                               rctempclob.temp_clob_fact_id ||
                               'rctempclob.sesion =>' || rctempclob.sesion ||
                               'rctempclob.template_id=>' ||
                               rctempclob.template_id ||
                               'rctempclob.package_id=>' ||
                               rctempclob.package_id, pkg_traza.cnuNivelTrzDef);

            ELSE
                pkg_traza.trace('-- PASO 5.18 no se ha obtenido una factura desde el Proceso de Batch', pkg_traza.cnuNivelTrzDef);
                onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                osbErrorMessage := '[Error] no se ha obtenido una factura desde el Proceso de Batch';
                GOTO error;
            END IF;

            /*Fin obtener CLOB de la solicitud procesada*/
            <<error>>
            NULL;
        END LOOP;

        pkg_traza.trace('-- PASO 5.19 Fin LDC_BOImpFacturaConstructora.GeneratebilldataFacFis', pkg_traza.cnuNivelTrzDef);

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN Pkg_Error.CONTROLLED_ERROR THEN
            Pkg_Error.GetError (onuErrorCode,osbErrorMessage);
            RAISE Pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Pkg_Error.setError;
            onuErrorCode := SQLCODE;
            osbErrorMessage := SQLERRM;
            RAISE Pkg_Error.CONTROLLED_ERROR;
    END GeneratebilldataFacFis;

    /*****************************************************************

      Propiedad intelectual de PETI (c).

     Unidad         : Insertbillclob
     Descripcion    : Se encarga de almacenar en la entidad
                      ld_temp_clob_fact los CLOB de las facturas
                      asociadas a una serie de solicitudes de
                      venta subsidiada

     Autor          : Sergio Mejia Rivera - Optima Consulting SAS
     Fecha          : 15/01/2014

     Parametros       Descripcion
     ============     ===================
     inumo_packages   Identificador de la solicitud
     inuCurrent       Registro actual
     inuTotal         Total de registros a procesar
     onuErrorCode     Codigo de error
     osbErrorMessage  Mensaje de error

     Historia de Modificaciones
     Fecha            Autor                 Modificacion
     =========        =========             ====================
     09/11/2023       felipe.valencia       OSF-1867 Se modfica consulta que obtiene la
                                            solicitud por ellor de numero invalido.
     12/05/2015       Mmejia                Se modifica para incluir el llamado al formato
                                            de factura fiscal, para esto se utiliza un
                                            valor setea desde el PB IMFC.ARA7034
     22/10/2014       paulaag               Se corrige el query de estados de cuenta
                                            para que tenga en cuenta las facturas
                                            con Financiaciones de Deuda para
                                            Constructoras.

     17/01/2014       smejia                Creacion
    ******************************************************************/
    PROCEDURE Insertbillclob
    (
        inufactcodi     IN factura.factcodi%TYPE,
        inuCurrent      IN NUMBER,
        inuTotal        IN NUMBER,
        onuErrorCode    OUT NUMBER,
        osbErrorMessage OUT VARCHAR2
    ) IS

        cnuNULL_ATTRIBUTE CONSTANT NUMBER := 2126;

        rctempclob     Dald_Temp_Clob_Fact.styLD_temp_clob_fact;
        --------------------- INICIO CAMBIO 186 --------------------------------
        nuContar       number(4);
        --------------------- FINALIZO CAMBIO 186 --------------------------------

        nuExecutableId sa_executable.executable_id%TYPE;
        nuErrorCode    NUMBER;
        sbErrorMessage VARCHAR2(4000);
        sbPEFADESC     ge_boInstanceControl.stysbValue;

		cursor cuSaldFact IS
		select 'X'
		from cuencobr
		where cucofact = inufactcodi
		AND nvl(cucosacu,0) > 0;

		sbDatos varchar2(1);

        csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'Insertbillclob';

        CURSOR cuExistenFacturas
        (
            inuFactura IN factura.factcodi%TYPE
        )
        IS
        SELECT COUNT(1)
        FROM factura fa,
                cuencobr cb,
                cargos ca
        WHERE  fa.factcodi = inuFactura
        AND    fa.factcodi = cb.cucofact
        AND    cb.cucocodi = ca.cargcuco
        AND    (ca.cargdoso LIKE 'N_-%'
        OR     ca.cargdoso NOT LIKE 'PP-%');

        CURSOR cuObtieneSolicitudVCons
        (
            inuFactura IN factura.factcodi%TYPE
        )
        IS
        SELECT  qu.package_id
        FROM    factura fa,
                mo_motive mo,
                mo_packages pa,
                cc_quotation qu
        WHERE fa.factcodi = inuFactura
        AND fa.factsusc = mo.subscription_id
        AND mo.package_id = pa.package_id
        AND pa.package_type_id =323
        AND pa.package_id = qu.package_id
        AND ROWNUM <= 1;

        CURSOR cuObtieneSolicitud
        (
            inuFactura IN factura.factcodi%TYPE
        )
        IS
        SELECT qu.package_id
        FROM factura
        inner join servsusc on sesususc=factsusc
        inner join suscripc on susccodi=sesususc
        inner join cc_quotation qu on subscriber_id=suscclie
        inner join cargos on cargnuse=sesunuse and cargdoso=  'PP-'||qu.package_id
        where factcodi = inuFactura
        and rownum <= 1;

        CURSOR cuObtieneSoliciudFs
        (
            inuFactura IN factura.factcodi%TYPE
        )
        IS
        SELECT substr(cargdoso, instr(cargdoso, '-') + 1, length(cargdoso)) package_id
        FROM    cargos   ca,
                factura  fa,
                cuencobr c,
                servsusc s
        WHERE fa.factcodi = inuFactura
                AND ca.cargcuco = c.cucocodi
                AND c.cucofact = fa.factcodi
                AND c.cuconuse = ca.cargnuse
                AND ca.cargdoso LIKE 'PP-%'
                AND s.sesunuse = ca.cargnuse
                AND
                s.sesuserv NOT IN
                (SELECT to_number(regexp_substr(dald_parameter.fsbgetvalue_chain('SERV_EXC_IMFC', NULL),
                                                   '[^,]+',
                                                   1,
                                                   LEVEL)) AS servicio
                      FROM dual
                    CONNECT BY regexp_substr(dald_parameter.fsbgetvalue_chain('SERV_EXC_IMFC', NULL), '[^,]+', 1, LEVEL) IS NOT NULL)
                AND
                fa.factprog IN
                (SELECT to_number(regexp_substr(dald_parameter.fsbgetvalue_chain('PARAPROG_IMFC', NULL),
                                                   '[^,]+',
                                                   1,
                                                   LEVEL)) AS programa
                      FROM dual
                    CONNECT BY regexp_substr(dald_parameter.fsbgetvalue_chain('PARAPROG_IMFC', NULL), '[^,]+', 1, LEVEL) IS NOT NULL)
                AND
                ca.cargcaca NOT IN
                (SELECT to_number(regexp_substr(dald_parameter.fsbgetvalue_chain('CAUS_EXC_IMFC', NULL),
                                                   '[^,]+',
                                                   1,
                                                   LEVEL)) AS causa
                      FROM dual
                    CONNECT BY regexp_substr(dald_parameter.fsbgetvalue_chain('CAUS_EXC_IMFC', NULL), '[^,]+', 1, LEVEL) IS NOT NULL)
                AND ROWNUM = 1;

    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        pkg_traza.trace('-- PASO 0.Inicio LDC_BOImpFacturaConstructora.Insertbillclob', pkg_traza.cnuNivelTrzDef);
        --ARA7043
        --Mmejia
        --Se agrega el campo que identifica el tipo de imprsion a realizar.
        --sbPEFADESC := ge_boInstanceControl.fsbGetFieldValue ('PERIFACT', 'PEFADESC');
        ge_boInstanceControl.GETGLOBALATTRIBUTE('PEFADESC', sbPEFADESC);

        ------------------------------------------------
        -- Required Attributes
        ------------------------------------------------

        IF (sbPEFADESC IS NULL) THEN
            Pkg_Error.SetErrorMessage(cnuNULL_ATTRIBUTE, 'Formato Impresion');
            RAISE Pkg_Error.CONTROLLED_ERROR;
        END IF;
        GlobalFormate := sbPEFADESC;
        pkg_traza.trace('-- PASO 0.Procesando factura ' || inufactcodi, pkg_traza.cnuNivelTrzDef);

        --INICIO CA 200-2379 LJLB
		IF sbPEFADESC = 'CU' THEN

            IF (cuSaldFact%ISOPEN) THEN
                CLOSE cuSaldFact;
            END IF;

			OPEN cuSaldFact;
			FETCH cuSaldFact INTO sbDatos;
			if cuSaldFact%notfound then
				close cuSaldFact;
				onuErrorCode    := ld_boconstans.cnuGeneric_Error;
				osbErrorMessage := 'Factura ['||inufactcodi||'] ya esta pagada, por favor validar.';
				ROLLBACK;

			   GOTO error;
			end if;
			CLOSE cuSaldFact;
        END IF;
        --FIN CA 200-2379

        BEGIN

            rctempclob := NULL;
            --------------------- INICIO CAMBIO 186 --------------------------------
            nuContar := 0;
            ---------------------FINALIZO CAMBIO 186--------------------------------

            /*Insertar el clob en la entidad ld_temp_clob_fact*/
            pkg_traza.trace('-- PASO 1.Insertar el clob en la entidad ld_temp_clob_fact', pkg_traza.cnuNivelTrzDef);
            rctempclob.temp_clob_fact_id := LD_BOSequence.Fnuseqld_temp_clob_fact;
            rctempclob.template_id       := to_char(inufactcodi);
            rctempclob.package_id        := NULL;

            /*Capturar la sesion de usuario*/
            IF globalsesion IS NULL THEN
                globalsesion := userenv('SESSIONID');
            END IF;

            pkg_traza.trace('-- PASO 2.globalsesion = ' || globalsesion, pkg_traza.cnuNivelTrzDef);
            rctempclob.sesion := globalsesion;
            IF (sbPEFADESC = 'FF' OR sbPEFADESC = 'FU') THEN
                pkg_traza.trace('/*+++++++++++++++++++++++INICIO CAMBIO 186+++++++++++++++++++++++++++/', pkg_traza.cnuNivelTrzDef);

                IF (cuExistenFacturas%ISOPEN) THEN
                    CLOSE cuExistenFacturas;
                END IF;

                OPEN cuExistenFacturas(inufactcodi);
                FETCH cuExistenFacturas INTO nuContar;
                CLOSE cuExistenFacturas;

                IF  nuContar >0 THEN
                    pkg_traza.trace('/*+++++++++++++++++++++++ENTRO A CAMBIO 186+++++++++++++++++++++++++++/', pkg_traza.cnuNivelTrzDef);

                    IF (cuObtieneSolicitudVCons%ISOPEN) THEN
                        CLOSE cuObtieneSolicitudVCons;
                    END IF;

                    OPEN cuObtieneSolicitudVCons(inufactcodi);
                    FETCH cuObtieneSolicitudVCons INTO rctempclob.package_id;

                    IF cuObtieneSolicitudVCons%NOTFOUND THEN
                        rctempclob.package_id := NULL;
                    END if;
                    CLOSE cuObtieneSolicitudVCons;
                ELSE
                    -- pagarcia [23/10/2014] Se modifica la forma de obtener el paquete
                    -- asociado a la cotizacion.
                    pkg_traza.trace('Inicia obtiene solicitud de cotización', pkg_traza.cnuNivelTrzDef);
                    IF (cuObtieneSolicitud%ISOPEN) THEN
                        CLOSE cuObtieneSolicitud;
                    END IF;

                    OPEN cuObtieneSolicitud(inufactcodi);
                    FETCH cuObtieneSolicitud INTO rctempclob.package_id;

                    pkg_traza.trace('Solicitud: '||rctempclob.package_id, pkg_traza.cnuNivelTrzDef);
                    IF cuObtieneSolicitud%NOTFOUND THEN
                        rctempclob.package_id := NULL;
                    END if;
                    CLOSE cuObtieneSolicitud;

                    pkg_traza.trace('Fin obtiene solicitud de cotización', pkg_traza.cnuNivelTrzDef);

                    pkg_traza.trace('/*+++++++++++++++++++++++CONSULTA VIEJA 186+++++++++++++++++++++++++++/', pkg_traza.cnuNivelTrzDef);
                END IF;
            ELSIF (sbPEFADESC = 'FS') THEN
                -- Se incluye nuevo condiiconal basado en el caso 200-1389
                IF (cuObtieneSoliciudFs%ISOPEN) THEN
                    CLOSE cuObtieneSoliciudFs;
                END IF;

                OPEN cuObtieneSoliciudFs(inufactcodi);
                FETCH cuObtieneSoliciudFs INTO rctempclob.package_id;

                IF cuObtieneSoliciudFs%NOTFOUND THEN
                    rctempclob.package_id := NULL;
                END if;
                CLOSE cuObtieneSoliciudFs;
            END IF;

            IF (sbPEFADESC != 'FS') THEN
                IF rctempclob.package_id IS NULL THEN

                    IF (cuObtieneSolicitud%ISOPEN) THEN
                        CLOSE cuObtieneSolicitud;
                    END IF;

                    OPEN cuObtieneSolicitud(inufactcodi);
                    FETCH cuObtieneSolicitud INTO rctempclob.package_id;

                    IF cuObtieneSolicitud%NOTFOUND THEN
                        rctempclob.package_id := NULL;
                    END if;
                    CLOSE cuObtieneSolicitud;
                END IF;
            END IF;

            /*Insertar registro en entidad ld_temp_clob_fact*/
            pkg_traza.trace('-- PASO 3.Insertar el clob en la entidad ld_temp_clob_fact [Dald_Temp_Clob_Fact] rctempclob.package_id = ' ||
                           rctempclob.package_id, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace('-- PASO 4.rctempclob.TEMP_CLOB_FACT_ID' ||
                           rctempclob.TEMP_CLOB_FACT_ID ||
                           ' rctempclob.TEMPLATE_ID' || rctempclob.TEMPLATE_ID
                           --||' rctempclob.DOCUDOCU'||rctempclob.DOCUDOCU
                           || ' rctempclob.SESION' || rctempclob.SESION ||
                           ' rctempclob.PACKAGE_ID' || rctempclob.PACKAGE_ID, pkg_traza.cnuNivelTrzDef);

            BEGIN
                -- paulaag
                Dald_Temp_Clob_Fact.insRecord(rctempclob);
            EXCEPTION
                WHEN OTHERS THEN
                    onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                    osbErrorMessage := '-Error insertando la factura [' ||
                                       inufactcodi ||
                                       '] en la entidad ld_temp_clob_fact_1';
                    ROLLBACK;
            END;
            pkg_traza.trace('-- PASO 5.Generatebilldata Inicio sbPEFADESC ' ||
                           sbPEFADESC, pkg_traza.cnuNivelTrzDef);

            --Se valida si se imprime el cupon(CU)
            IF (sbPEFADESC = 'CU') THEN
                Generatebilldata(onuErrorCode, osbErrorMessage);
            END IF;

            pkg_traza.trace('-- PASO 6.Generatebilldata Fin ERROR CODE [' ||
                           onuErrorCode || ']', pkg_traza.cnuNivelTrzDef);

            pkg_traza.trace('-- PASO 7.GeneratebilldataFacFis Inicio sbPEFADESC ' ||
                           sbPEFADESC, pkg_traza.cnuNivelTrzDef);

            --ARA.7043
            --Mmejia
            --Se agrega la generacion del formato de factura fiscal
            --Se valida si se imprime la factura fiscal(FF)
            IF (sbPEFADESC = 'FF' OR sbPEFADESC = 'FS') THEN

                GeneratebilldataFacFis(onuErrorCode, osbErrorMessage);

                pkg_traza.trace('-- PASO 7..1 onuErrorCode: ' ||onuErrorCode, pkg_traza.cnuNivelTrzDef);
                pkg_traza.trace('-- PASO 7..1 osbErrorMessage: ' ||osbErrorMessage, pkg_traza.cnuNivelTrzDef);
            END IF;

            pkg_traza.trace('-- PASO 8.Generatebilldata Fin ERROR CODE [' ||
                           onuErrorCode || ']', pkg_traza.cnuNivelTrzDef);

            IF onuErrorCode IS NOT NULL
               AND osbErrorMessage IS NOT NULL THEN
                pkg_traza.trace('[ERROR]Se genero error en  Generatebilldata [' ||
                               osbErrorMessage || ']', pkg_traza.cnuNivelTrzDef);
                Pkg_Error.SetErrorMessage(onuErrorCode, osbErrorMessage);
            END IF;

            IF inuCurrent = inuTotal THEN
                COMMIT;

                pkg_traza.trace('-- PASO 9.Componente .net ', pkg_traza.cnuNivelTrzDef);
                /*Obtener ejecutable del .net sa_executable*/
                nuExecutableId := sa_boexecutable.fnuGetExecutableIdbyName(Ld_Boconstans.csbGen_Sale_Duplicate, FALSE);

                /*Setear componente .net*/
                Ld_Bosubsidy.SetEventPrint(nuExecutableId);

                /*Realizar el llamado a la aplicacion que se encarga de generar los duplicados de factura*/
                Ld_Bosubsidy.Callapplication(Ld_Boconstans.csbGen_Sale_Duplicate);

            END IF;

        EXCEPTION
            WHEN OTHERS THEN
                onuErrorCode    := ld_boconstans.cnuGeneric_Error;
                osbErrorMessage := 'Error insertando la factura [' ||
                                   inufactcodi ||
                                   '] en la entidad ld_temp_clob_fact';
                ROLLBACK;
        END;

        <<error>>
        NULL;

        pkg_traza.trace('-- PASO 10.Fin LDC_BOImpFacturaConstructora.Insertbillclob', pkg_traza.cnuNivelTrzDef);

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN Pkg_Error.CONTROLLED_ERROR THEN
            RAISE Pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Pkg_Error.setError;
            RAISE Pkg_Error.CONTROLLED_ERROR;
    END Insertbillclob;

    FUNCTION frffacturasconstructora RETURN pkConstante.tyRefCursor IS

        rfcursor pkConstante.tyRefCursor;

        sbCicloId   ge_boInstanceControl.stysbValue;
        sbPeriodoId ge_boInstanceControl.stysbValue;
        sbPEFADESC  ge_boInstanceControl.stysbValue;

        csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'frffacturasconstructora';
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        pkg_traza.trace('Inicio LDC_BOImpFacturaConstructora.frffacturasconstructora', pkg_traza.cnuNivelTrzDef);

        /*obtener los valores ingresados en la aplicacion PB IMFC Impresion masiva de facturas de constructora*/
        sbCicloId   := ge_boInstanceControl.fsbGetFieldValue('CICLO', 'CICLCODI');
        sbPeriodoId := ge_boInstanceControl.fsbGetFieldValue('PERIFACT', 'PEFACODI');
        sbPEFADESC  := ge_boInstanceControl.fsbGetFieldValue('PERIFACT', 'PEFADESC');

        IF sbPeriodoId IS NULL THEN
            Pkg_Error.SetErrorMessage(2741, 'El campo [Periodo] es requerido');
            RAISE Pkg_Error.CONTROLLED_ERROR;
        END IF;

        --Se envia a la instanacia global el atributo  sbPEFADESC
        ge_boInstanceControl.ADDGLOBALATTRIBUTE('PEFADESC', sbPEFADESC);
        IF (sbPEFADESC = 'CU' OR sbPEFADESC = 'FF') THEN
            OPEN rfcursor FOR
            -- pagarcia [23/10/2014] Se modifica la forma de obtener el paquete
            -- asociado a la cotizacion.                                                                                                                                            AND cargnuse = sesunuse */

                SELECT DISTINCT fa.factcodi "Estado de Cuenta",
                                su.sesususc "Contrato",
                                su.sesunuse "Producto",
                                se.servcodi || '-' || se.servdesc "Tipo de Producto",
                                ad.address "Direccion del producto",
                                cl.subscriber_id "Codigo del Cliente",
                                cl.identification "Identificacion del Cliente",
                                cl.subscriber_name || ' ' || cl.subs_last_name "Nombres - Apellidos",
                                (SELECT qu.package_id
                                 FROM cc_quotation qu, cargos
                                 WHERE subscriber_id = cl.subscriber_id
                                       AND cargos.cargnuse = su.sesunuse
                                       AND cargos.cargdoso LIKE 'PP-%'
                                       AND cargdoso = 'PP-'||qu.package_id
                                       AND rownum <= 1) "Solicitud",
                                (SELECT daps_package_type.fsbgetdescription(mp.package_type_id)
                                 FROM cc_quotation qu,
                                      mo_packages  mp,
                                      cargos
                                 WHERE cargdoso = 'PP-'||qu.package_id
                                       AND cargos.cargnuse = su.sesunuse
                                       AND cargos.cargdoso LIKE 'PP-%'
                                       AND package_type_id = 323 -- Venta a Constructoras
                                       AND qu.package_id = mp.package_id
                                       AND rownum <= 1) "Tipo de Solicitud",
                                cc.cucocodi "Cuenta de Cobro",
                                '$' ||
                                to_char((SELECT SUM(cucovato)
                                         FROM cuencobr
                                         WHERE cucofact = fa.factcodi) -
                                        nvl((SELECT cargvalo
                                            FROM cargos
                                            WHERE cargcuco = cc.cucocodi
                                                  AND cargconc = 301
                                                  AND rownum = 1), 0), 'FM999,999,990.00') "Valor Cuenta de Cobro"
                FROM factura       fa,
                     suscripc      co,
                     servsusc      su,
                     servicio      se,
                     ab_address    ad,
                     pr_product    pr,
                     ge_subscriber cl,
                     perifact      pf,
                     cuencobr      cc,
                     cargos        ca
                WHERE fa.factpefa = sbPeriodoId
                      AND fa.factcodi = cc.cucofact
                      AND ca.cargcuco = cc.cucocodi
                      AND fa.factsusc = su.sesususc
                      AND co.susccodi = fa.factsusc
                      AND pf.pefacodi = fa.factpefa
                      AND su.sesuserv = se.servcodi
                      AND pr.product_id = su.sesunuse
                      AND ad.address_id = pr.address_id
                      AND cl.subscriber_id = co.suscclie;
            pkg_traza.trace('Fin LDC_BOImpFacturaConstructora.frffacturasconstructora', pkg_traza.cnuNivelTrzDef);
        ELSE
            OPEN rfcursor FOR
                SELECT DISTINCT fa.factcodi "Estado de Cuenta",
                                su.sesususc "Contrato",
                                su.sesunuse "Producto",
                                se.servcodi || '-' || se.servdesc "Tipo de Producto",
                                ad.address "Direccion del producto",
                                cl.subscriber_id "Codigo del Cliente",
                                cl.identification "Identificacion del Cliente",
                                cl.subscriber_name || ' ' || cl.subs_last_name "Nombres - Apellidos",
                                (SELECT qu.package_id
                                 FROM cc_quotation qu, cargos
                                 WHERE subscriber_id = cl.subscriber_id
                                       AND cargos.cargnuse = su.sesunuse
                                       AND cargos.cargdoso LIKE 'PP-%'
                                       AND cargdoso = 'PP-'||qu.package_id
                                       AND rownum <= 1) "Solicitud",
                                (SELECT daps_package_type.fsbgetdescription(mp.package_type_id)
                                 FROM cc_quotation qu,
                                      mo_packages  mp,
                                      cargos
                                 WHERE cargdoso = 'PP-'||qu.package_id
                                       AND cargos.cargnuse = su.sesunuse
                                       AND cargos.cargdoso LIKE 'PP-%'
                                       AND package_type_id = 323 -- Venta a Constructoras
                                       AND qu.package_id = mp.package_id
                                       AND rownum <= 1) "Tipo de Solicitud",
                                cc.cucocodi "Cuenta de Cobro",
                                '$' ||
                                to_char((SELECT SUM(cucovato)
                                         FROM cuencobr
                                         WHERE cucofact = fa.factcodi) -
                                        nvl((SELECT cargvalo
                                            FROM cargos
                                            WHERE cargcuco = cc.cucocodi
                                                  AND cargconc = 301
                                                  AND rownum = 1), 0), 'FM999,999,990.00') "Valor Cuenta de Cobro"
                FROM factura       fa,
                     suscripc      co,
                     servsusc      su,
                     servicio      se,
                     ab_address    ad,
                     pr_product    pr,
                     ge_subscriber cl,
                     perifact      pf,
                     cuencobr      cc,
                     cargos        ca
                WHERE fa.factpefa = sbPeriodoId
                      AND fa.factcodi = cc.cucofact
                      AND ca.cargcuco = cc.cucocodi
                      AND fa.factsusc = su.sesususc
                      AND co.susccodi = fa.factsusc
                      AND pf.pefacodi = fa.factpefa
                      AND
                      su.sesuserv NOT IN
                      (SELECT to_number(regexp_substr(dald_parameter.fsbgetvalue_chain('SERV_EXC_IMFC', NULL),
                                                   '[^,]+',
                                                   1,
                                                   LEVEL)) AS servicio
                      FROM dual
                    CONNECT BY regexp_substr(dald_parameter.fsbgetvalue_chain('SERV_EXC_IMFC', NULL), '[^,]+', 1, LEVEL) IS NOT NULL)
                      AND su.sesuserv = se.servcodi
                      AND pr.product_id = su.sesunuse
                      AND ad.address_id = pr.address_id
                      AND cl.subscriber_id = co.suscclie
                      AND
                      fa.factprog IN
                      (SELECT to_number(regexp_substr(dald_parameter.fsbgetvalue_chain('PARAPROG_IMFC', NULL),
                                                   '[^,]+',
                                                   1,
                                                   LEVEL)) AS servicio
                      FROM dual
                    CONNECT BY regexp_substr(dald_parameter.fsbgetvalue_chain('PARAPROG_IMFC', NULL), '[^,]+', 1, LEVEL) IS NOT NULL)
                      AND
                      ca.cargcaca NOT IN
                      (SELECT to_number(regexp_substr(dald_parameter.fsbgetvalue_chain('CAUS_EXC_IMFC', NULL),
                                                   '[^,]+',
                                                   1,
                                                   LEVEL)) AS servicio
                      FROM dual
                    CONNECT BY regexp_substr(dald_parameter.fsbgetvalue_chain('CAUS_EXC_IMFC', NULL), '[^,]+', 1, LEVEL) IS NOT NULL);
            pkg_traza.trace('Fin LDC_BOImpFacturaConstructora.frffacturasconstructora', pkg_traza.cnuNivelTrzDef);
        END IF;

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN rfcursor;

    EXCEPTION
        WHEN Pkg_Error.CONTROLLED_ERROR THEN
            RAISE Pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Pkg_Error.setError;
            RAISE Pkg_Error.CONTROLLED_ERROR;
    END frffacturasconstructora;

END LDC_BOImpFacturaConstructora;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_BOIMPFACTURACONSTRUCTORA
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_BOIMPFACTURACONSTRUCTORA', 'ADM_PERSON'); 
END;
/
PROMPT
PROMPT OTORGA PERMISOS a REXEREPORTES sobre LDC_BOIMPFACTURACONSTRUCTORA
GRANT EXECUTE ON ADM_PERSON.LDC_BOIMPFACTURACONSTRUCTORA TO REXEREPORTES;
/