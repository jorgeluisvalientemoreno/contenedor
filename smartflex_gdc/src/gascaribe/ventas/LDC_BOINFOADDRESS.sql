CREATE OR REPLACE PACKAGE LDC_BOINFOADDRESS IS
/********************************************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         :    LDC_BOInfoAddress
    Descripcion    :    Paquete que contiene la l??gica de negocio encargado de
                        realizar las validaciones de las direcciones.

    Autor          :    Jorge Alejandro Carmona Duque
    Fecha          :    23/05/2014

    Historia de Modificaciones
    Fecha           Autor                   Modificacion
    --------        ----------              --------------
    23/05/2014      JCarmona.CAMBIO3574     Creaci??n.
    11/12/2014      jcramirez TS RQ3029     Modificaci??n del m??todo
                                            "valInfoPremise" para el
                                            requerimiento de predios anillados.
    17/05/2022  John Jimenez OSF-300    Se modifica para que el sistema no valide
                                       en las ventas de gas por formulario, si el
                                       predio esta anillo siempre y cuando el plan
                                       comercial, esta configurado en el parametro :
                                       PARAM_PLCOM_VGF_VALANILL_INST.
	20/02/2023		cgonzalez				OSF-905: Se modifica servicio VALINFOPREMISE
********************************************************************************************/

    --------------------------------------------
    -- Tipos y Estructuras de Datos
    --------------------------------------------

/********************************************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         :    valInfoPremise
    Descripcion    :    Valida los requisitos necesarios que debe cumplir una
                        direcci??n para que la solicitud de venta se pueda
                        registrar.
                        En un ??nico mensaje de error se muestran
                        todos los requisitos que se incumplan.

    Autor          :    Jorge Alejandro Carmona Duque
    Fecha          :    23/05/2014

    Parametros              Descripcion
    ============         ===================
    inuAddressId         Identificador de la direcci??n

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    23/05/2014      JCarmona.3574       Creaci??n.
    11/12/2014      jcramirez TS RQ3029     Modificaci??n para no tener en cuenta
                                            la validaci??n del  predio a los tr?!mites
                                            "Venta de Gas por Formulario"
                                            y "Formulario IFRS".
   17/05/2022  John Jimenez OSF-300    Se modifica para que el sistema no valide
                                       en las ventas de gas por formulario, si el
                                       predio esta anillo siempre y cuando el plan
                                       comercial, esta configurado en el parametro :
                                       PARAM_PLCOM_VGF_VALANILL_INST.
	20/02/2023		cgonzalez			OSF-905: Se modifica servicio para validar si el predio
										esta reportado por fraude PNO
********************************************************************************************/
    PROCEDURE valInfoPremise
    (
        inuAddressId in ab_address.address_id%type
    );

END LDC_BOInfoAddress;
/
CREATE OR REPLACE PACKAGE BODY LDC_BOINFOADDRESS IS

/*********************************************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         :    LDC_BOInfoAddress
    Descripcion    :    Paquete que contiene la l??gica de negocio encargado de
                        realizar las validaciones de las direcciones.

    Autor          :    Jorge Alejandro Carmona Duque
    Fecha          :    23/05/2014

    Historia de Modificaciones
    Fecha           Autor                   Modificacion
    --------        ----------              --------------
    23/05/2014      JCarmona.CAMBIO3574     Creaci??n.
    06/10/2014      Oparra.Team 718         Modificaci??n para que se valide el nivel
                                            de riesgo del predio respecto a la factibilidad
                                            de venta configurada.
    11/12/2014      jcramirez TS RQ3029     Modificaci??n del m??todo
                                            "valInfoPremise" para el
                                            requerimiento de predios anillados.
    17/05/2022  John Jimenez OSF-300    Se modifica para que el sistema no valide
                                       en las ventas de gas por formulario, si el
                                       predio esta anillo siempre y cuando el plan
                                       comercial, esta configurado en el parametro :
                                       PARAM_PLCOM_VGF_VALANILL_INST.
	20/02/2023		cgonzalez				OSF-905: Se modifica servicio VALINFOPREMISE
***********************************************************************************************/

    -- Declaraci??n de variables y tipos globales privados del paquete
    csbVersion                  CONSTANT    VARCHAR2(20)    :=  'OSF-905';    --Versi??n del paquete

    csbSessionModule            CONSTANT    VARCHAR2(20)    :=  'COVCM';     --Forma de modificacion de Ventas Moviles

    cnuPackTypeVentaFormu       constant ps_package_type.package_type_id%type   := 271;     --Tr?!mite Venta de Gas por Formulario
    cnuPackTypeVentaFormuXML    constant ps_package_type.package_type_id%type   := 100233;  --Tr?!mite Venta de Gas por Formulario IFRS
    cnuPackTypeVentaGasCotiza   constant ps_package_type.package_type_id%type   := 100229;  --Tr?!mite Venta de Gas Cotizada
    cnuPackTypeSoliciInterna    constant ps_package_type.package_type_id%type   := 329;     --Tr?!mite Solicitud de Interna
    cnuPackTypeVentaConstruct   constant ps_package_type.package_type_id%type   := 323;     --Tr?!mite Venta constructoras

    ----------------------------------------------------------------------------
    --Jcramirez: TSRQ3019
    cnuPackTypeFormularioIFRS   CONSTANT ps_package_type.package_type_id%TYPE   :=  100249; --Tr?!mite Formulario IFRS
    cnuPackTypeInternaIFRS      CONSTANT ps_package_type.package_type_id%TYPE   :=  100259; --Tr?!mite Interna IFRS
    cnuPackTypeCotizadaIFRS     CONSTANT ps_package_type.package_type_id%TYPE   :=  100272; --Tr?!mite Cotizada IFRS
    ----------------------------------------------------------------------------

    ----------------------------------------------------------------------------
    -- Definicion de metodos privados del paquete
    ----------------------------------------------------------------------------

    ----------------------------------------------------------------------------
    FUNCTION fsbVersion  return varchar2 IS
    BEGIN
        return csbVersion;
    END;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         :    valInfoPremise
    Descripcion    :    Valida los requisitos necesarios que debe cumplir una
                        direcci??n para que la solicitud de venta se pueda
                        registrar.
                        En un ??nico mensaje de error se muestran
                        todos los requisitos que se incumplan.

    Autor          :    Jorge Alejandro Carmona Duque
    Fecha          :    23/05/2014

    Parametros              Descripcion
    ============         ===================
    inuAddressId         Identificador de la direcci??n

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    23/05/2014      JCarmona.3574       Creaci??n.
    06/10/2014      Oparra.Team 718     Modificaci??n para que se valide el nivel
                                        de riesgo del predio respecto a la
                                        factibilidad de venta configurada.
    11/12/2014      jcramirez TS RQ3029 Modificaci??n para no tener en cuenta
                                        la validaci??n del  predio a los tr?!mites
                                        "Venta de Gas por Formulario"
                                        y "Formulario IFRS".
   17/05/2022  John Jimenez OSF-300    Se modifica para que el sistema no valide
                                       en las ventas de gas por formulario, si el
                                       predio esta anillo siempre y cuando el plan
                                       comercial, esta configurado en el parametro :
                                       PARAM_PLCOM_VGF_VALANILL_INST.
	20/02/2023		cgonzalez			OSF-905: Se modifica servicio para validar si el predio
										esta reportado por fraude PNO
 ***********************************************************************************/
    PROCEDURE valInfoPremise
    (
        inuAddressId in ab_address.address_id%type
    )
    IS
        -- Variables Locales
        osbRing             ab_info_premise.is_ring%type;
        onuLevelRisk        ab_info_premise.level_risk%type;
        osbDescRisk         ab_info_premise.description_risk%type;
        nuSegmentId         ab_segments.segments_id%type;
        nuCiclFact          ab_segments.ciclcodi%type;
        nuOperatingSector   ab_segments.operating_sector_id%type;
        sbInfoPremise       varchar2(1);
        nuProductId         pr_product.product_id%type;
        sbErrorsMessages    varchar2(4000);
        nuFlagError         number;
        onuPackTypeInter    mo_packages.package_id%type;
        onuPackTypeFormu    mo_packages.package_id%type;
        onuPackTypeCotiza   mo_packages.package_id%type;
        onuPackTypeFormIFRS mo_packages.package_id%type;
        onuPackTypeInteIFRS mo_packages.package_id%type;
        onuPackTypeCotiIFRS mo_packages.package_id%type;
        sbVerified          ab_address.verified%type;
        sbCurrentInstance   varchar2(4000);
        sbFatherInstance    varchar2(4000);
        nuPackageTypeId     mo_packages.package_type_id%type;
       -- sbExist             boolean;
        sbFlagVendible      varchar2(1);    -- Team 718
        sbIsRing            ab_info_premise.is_ring%type;
        nuSolicitudRed      mo_packages.package_id%type;
        nuCotiza            mo_packages.package_id%type;
        nuPackageiD    NUMBER;
		    sbvacomment_       mo_packages.comment_%TYPE;
        nuconta            NUMBER := 0;
        nmcontares         NUMBER(4);
        nmcontavaldat      NUMBER;
        sbvalanill         VARCHAR2(1) DEFAULT 'S';
        sbvalpartipsol     ld_parameter.value_chain%TYPE;
        sbvalpardatava     ld_parameter.value_chain%TYPE;
		
		CURSOR cuValidaPNO(inuAddressId IN ab_address.address_id%TYPE) IS
			SELECT 	COUNT(1)
			FROM 	ab_address, ldc_info_predio
			WHERE	address_id = inuAddressId
			AND		estate_number = premise_id
			AND		pno = 1;
		
		nuValidaPNO 	NUMBER;
BEGIN
        UT_Trace.Trace( 'Begin LDC_BOInfoAddress.valInfoPremise['||inuAddressId||']', 1);

        nuFlagError := 0;

        sbErrorsMessages := CHR(10)||'La dirección no cumple con los siguientes requisitos:'||CHR(10)||CHR(10);

        if ut_session.getmodule <> csbSessionModule then
            -- Se obtiene la instancia actual
            GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbCurrentInstance);

            if GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK(sbCurrentInstance, null, 'MO_PACKAGES', 'PACKAGE_TYPE_ID', nuPackageTypeId) then
                -- Se obtiene el tipo de solicitud de la instancia
                GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbCurrentInstance, null, 'MO_PACKAGES', 'PACKAGE_TYPE_ID', nuPackageTypeId);				         
			-- Se obtiene el comentario o la observación de la solicitud
/*OSF-300 JJJM*/GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbCurrentInstance, null, 'MO_PACKAGES', 'COMMENT_', sbvacomment_);

                IF  sbCurrentInstance LIKE '%_100354%' THEN
                    nuconta :=1;
                END IF;

               IF nuPackageTypeId = cnuPackTypeVentaGasCotiza THEN
                GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbCurrentInstance, null, 'MO_PACKAGES_ASSO', 'PACKAGE_ID_ASSO', nuCotiza);
               END IF;
            else

                -- Se obtiene el tipo de solicitud de la instancia padre
                GE_BOINSTANCECONTROL.GETFATHERINSTANCE(sbCurrentInstance, sbFatherInstance);
                GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbFatherInstance, null, 'MO_PACKAGES', 'PACKAGE_TYPE_ID', nuPackageTypeId);				
                -- Se obtiene el plan comercial
/*OSF-300 JJJM*/GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbFatherInstance, null, 'MO_PACKAGES', 'COMMENT_', sbvacomment_);
                 IF  sbFatherInstance LIKE '%_100354%' THEN
                      nuconta :=1;
                 END IF;
               IF nuPackageTypeId = cnuPackTypeVentaGasCotiza THEN
                GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbCurrentInstance, null, 'MO_PACKAGES_ASSO', 'PACKAGE_ID_ASSO', nuCotiza);
               END IF;

            end if;
        end if;
        sbvacomment_ := upper(TRIM(sbvacomment_));
        --Si el predio no tiene anillo y el campo [Numero de Orden Solicitud de Red] de la cotizaci????????????????n en la tabla LDC_COTIZACION_COMERCIAL no est???????????????? diligenciado. No se permitir???????????????? registrar la venta
        -- Se valida el tipo de solicitud
        --Ya que para todos los tr?!mites no se realizar?!n las mismas validaciones.
        --Para los tr?!mites 271-Venta de Gas por Formulario,
        -- 100233-Venta de Gas por Formulario XML
        -- 100229-Venta de Gas Cotizada
        -- 100249-Formulario IFRS (Jcramirez - TS RQ 3029)
        -- 100272-Cotizada IFRS (Jcramirez - TS RQ 3029)
        -- Se realizar?!n todas las validaciones.
        if nuPackageTypeId in (cnuPackTypeVentaFormu, cnuPackTypeVentaFormuXML, cnuPackTypeVentaGasCotiza, cnuPackTypeFormularioIFRS, cnuPackTypeCotizadaIFRS)
                                OR ut_session.getmodule = csbSessionModule then
            --SE OBTIENE EL PRODUCTO
            nuProductId := PR_BOProduct.fnugetprodbyaddrprodtype(inuAddressId, ld_boconstans.cnuGasService);
            -- Se obtiene el segmento de la direcci??n
            nuSegmentId := daab_address.fnugetsegment_id(inuAddressId, 0);

            -- Se obtiene el ciclo de facturaci??n del segmento
            nuCiclFact := daab_segments.fnugetciclcodi(nuSegmentId, 0);
            IF fblaplicaentregaxcaso('200-2000') and  cnuPackTypeVentaGasCotiza = nuPackageTypeId THEN
                BEGIN
                    SELECT IP.IS_RING INTO sbIsRing
                    FROM AB_INFO_PREMISE IP, AB_PREMISE P
                     WHERE IP.PREMISE_ID = P.PREMISE_ID
                    -- AND SEGMENTS_ID = nuSegmentId
                     and P.PREMISE_ID = Daab_Address.Fnugetestate_Number(inuAddressId, null)
                     ;
                 EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                  sbIsRing := 'N';
                END;

                BEGIN
                   IF nuCotiza IS NOT NULL THEN
                      SELECT PACKAGE_ID INTO nuSolicitudRed
                      FROM LDC_COTIZACION_COMERCIAL
                      WHERE SOL_COTIZACION = nuCotiza;
                   ELSE
                      nuSolicitudRed := NULL;
                   END IF;
                 EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                  nuSolicitudRed := NULL;
                  WHEN OTHERS THEN
                  nuSolicitudRed := NULL;
                END;

                IF sbIsRing = 'N' AND NVL(nuSolicitudRed,0) = 0 THEN
                  sbErrorsMessages := '* El predio debe tener anillo o Solicitud de red';
                  ge_boerrors.seterrorcodeargument(2741, sbErrorsMessages);
                END IF;
               END IF;

            if nuCiclFact IS null then
                nuFlagError := 1;
                sbErrorsMessages := sbErrorsMessages||'* El segmento de la dirección ingresada no tiene un ciclo de facturación asociado.'||CHR(10);
            end if;

            -- Se obtiene el sector operativo del segmento
            nuOperatingSector := daab_segments.fnugetoperating_sector_id(nuSegmentId, 0);

            if nuOperatingSector IS null then
                nuFlagError := 1;
                sbErrorsMessages := sbErrorsMessages||'* El segmento de la dirección ingresada no tiene un sector operativo asociado.'||CHR(10);
            end if;

            -- Se valida si la direcci??n tiene datos adicionales
               sbInfoPremise := AB_BOPremise.fsbexistsinfopremise(inuAddressId);

           if sbInfoPremise = ge_boconstants.getyes then
                -- Se obtienen los datos adicionales de la direcci??n de un predio
                AB_BOPremise.getinfopremisebyaddress(inuAddressId, osbRing, onuLevelRisk, osbDescRisk);

                -- Se valida el nivel de riesgo     -- TS 718
                if onuLevelRisk IS not null OR osbDescRisk IS not null then

                    begin
                        select es_vendible
                        into sbFlagVendible
                        from open.ldc_level_risk
                        where (nivel_riesgo = onuLevelRisk or descripcion_riesgo = osbDescRisk);

                    exception
                        when no_data_found then
                            nuFlagError := 1;
                            sbErrorsMessages := sbErrorsMessages||'* El nivel de riesgo del predio no esta configurado'||CHR(10);
                    end;

                    if sbFlagVendible = ge_boconstants.getno then
                        nuFlagError := 1;
                        sbErrorsMessages := sbErrorsMessages||'* El predio ingresado posee un nivel '||onuLevelRisk||'-'||osbDescRisk||' y no es factible para la venta'||CHR(10);
                    end if;
                /*else
                    nuFlagError := 1;
                    sbErrorsMessages := sbErrorsMessages||'* El predio ingresado no tiene configurado Nivel de Riesgo'||CHR(10); */
                end if;
               
                -- INICIO OSF-300 JJJM
                sbvalanill := 'S';
                IF fblaplicaentregaxcaso('OSF-300') THEN
                 -- Tipos de solicitud a los cuales no se les quiere validar predio anillado
                 sbvalpartipsol := TRIM(dald_parameter.fsbGetValue_Chain('PARAM_TIPOSOLI_NO_VAL_ANILLO',NULL));
                 IF sbvalpartipsol IS NULL THEN
                    sbErrorsMessages := '* Se debe configurar parámetro : PARAM_TIPOSOLI_NO_VAL_ANILLO
                                           con los respectivos valores de los tipos de solicitud que no
                                           validarán instalación de anillo en el predio.
                                           favor validar parámetro en ldpar';
                    ge_boerrors.seterrorcodeargument(2741, sbErrorsMessages);
                 END IF;
                 -- Dato con el que no se validara predio anillado
                 sbvalpardatava := upper(TRIM(dald_parameter.fsbGetValue_Chain('PARAM_DATO_NO_VALID_ANILLO',NULL)));
                 IF sbvalpardatava IS NULL THEN
                    sbErrorsMessages := '* Se debe configurar parámetro : PARAM_DATO_NO_VALID_ANILLO
                                           con el dato con el que se validará instalación de anillo en el predio.
                                           favor validar parámetro en ldpar';
                    ge_boerrors.seterrorcodeargument(2741, sbErrorsMessages);
                 END IF;                 
                 -- Consultamos si el tipo de solicitud, esta configurada en el paremtro : PARAM_TIPOSOLI_NO_VAL_ANILLO 
                 SELECT COUNT(1) INTO nmcontares
                   FROM(
                        SELECT to_number(column_value) tipo_solicitud
                          FROM TABLE(ldc_boutilities.splitstrings(sbvalpartipsol,','))
                       )
                  WHERE tipo_solicitud = nuPackageTypeId;
                 -- Validamos si el tipo de solicitud esta configurado en el parametro : PARAM_TIPOSOLI_NO_VAL_ANILLO 
                 IF nmcontares >= 1 THEN
                  -- Consultamos si el dato del comentario contiene el del parametro : PARAM_DATO_NO_VALID_ANILLO
                  SELECT instr(sbvacomment_,sbvalpardatava) INTO nmcontavaldat
                    FROM dual;
                  -- Validamos si el dato del comentario es igual al dato del parametro : PARAM_DATO_NO_VALID_ANILLO     
                  IF nmcontavaldat >= 1 THEN
                   sbvalanill := 'N';
                  ELSE
                   sbvalanill := 'S';
                  END IF;
                 END IF;
                END IF;
                -- INICIO OSF-300 JJJM

                -- TS RQ3029: Si el tr?!mite es Formulario  IFRS
                -- (100249-Formulario IFRS) no debe tener en cuenta la validaciones
                -- Porque se hara con actividad "Validar Gasificacion" en los flujos.
                IF fblaplicaentregaxcaso('200-2000') THEN
                 IF nuPackageTypeId NOT IN (cnuPackTypeFormularioIFRS,cnuPackTypeVentaGasCotiza)  THEN
                  -- Se valida que el predio est?! anillado
                  IF (osbRing IS NULL OR osbRing = ge_boconstants.getno) and nuconta = 0 AND /*OSF-300 JJJM*/sbvalanill = 'S' THEN
                     nuFlagError := 1;
                     sbErrorsMessages := sbErrorsMessages||'* El predio ingresado no est?! anillado.'||CHR(10);
                  END IF;
                 END IF;
                ELSE
                 IF nuPackageTypeId NOT IN (cnuPackTypeFormularioIFRS) THEN
                  -- Se valida que el predio est?! anillado
                  IF (osbRing IS NULL OR osbRing = ge_boconstants.getno) AND nuconta = 0 AND /*OSF-300 JJJM*/ sbvalanill = 'S' THEN
                        nuFlagError := 1;
                        sbErrorsMessages := sbErrorsMessages||'* El predio ingresado no está anillado.'||CHR(10);
                  END IF;
                 END IF;
                END IF; -- FIN DEL IF blAplicaEntrega

               end if;

            -- Se valida si en la direcci??n existen productos de GAS activos

            -- Se valida si en la direcci??n existen productos de GAS activos
            nuProductId := PR_BOProduct.fnugetprodbyaddrprodtype(inuAddressId, ld_boconstans.cnuGasService);

            if nuProductId IS not null then
                -- Si el producto no es nulo entonces existen productos de GAS activos
                nuFlagError := 1;
                sbErrorsMessages := sbErrorsMessages||'* Ya existe un producto de GAS instalado en la dirección.'||CHR(10);
            end if;

            -- Se obtiene las solicitudes pendientes por tipo de solicitud y direcci??n
            mo_bopackages.getactpkgbytypnprdadr('P_SOLICITUD_DE_INTERNA_329', inuAddressId, onuPackTypeInter);
            mo_bopackages.getactpkgbytypnprdadr('P_VENTA_DE_GAS_POR_FORMULARIO_271', inuAddressId, onuPackTypeFormu);
            mo_bopackages.getactpkgbytypnprdadr('P_LBC_VENTA_COTIZADA_100229', inuAddressId, onuPackTypeCotiza);

            --------------------------------------------------------------------
            --Jcramirez: TSRQ3019
            mo_bopackages.getactpkgbytypnprdadr('P_FORMULARIO_IFRS_100249',inuAddressId,onuPackTypeFormIFRS);
            mo_bopackages.getactpkgbytypnprdadr('P_INTERNA_IFRS_100259',inuAddressId,onuPackTypeInteIFRS);
            mo_bopackages.getactpkgbytypnprdadr('P_COTIZADA_IFRS_100272',inuAddressId,onuPackTypeCotiIFRS);
            --------------------------------------------------------------------

            -- Se valida que no existan solicitudes de este tipo pendientes
            if onuPackTypeInter IS not null OR onuPackTypeFormu IS not null OR onuPackTypeCotiza IS not null
               OR onuPackTypeFormIFRS IS NOT NULL OR onuPackTypeInteIFRS IS NOT NULL OR onuPackTypeCotiIFRS IS NOT NULL then
                nuFlagError := 1;
                sbErrorsMessages := sbErrorsMessages||'* Existen solicitudes de pendientes en la dirección.'||CHR(10);
            end if;

            -- Se valida que la direcci??n de ingresada est?! validada en el sistema GIS
            sbVerified := daab_address.fsbgetverified(inuAddressId, 0);

            if sbVerified = ge_boconstants.getno then
                nuFlagError := 1;
                sbErrorsMessages := sbErrorsMessages||'* La dirección del predio no está validada en el GIS.'||CHR(10);
            end if;
			
			--INICIO OSF-905			
			OPEN cuValidaPNO(inuAddressId);
			FETCH cuValidaPNO INTO nuValidaPNO;
			CLOSE cuValidaPNO;
			
			IF (nuValidaPNO > 0) THEN
				nuFlagError := 1;
				sbErrorsMessages := sbErrorsMessages||'* El predio ingresado está marcado por PNO.'||CHR(10);
			END IF;			
			--FIN OSF-905

            -- Se levanta un mensaje de error con todos los requisitos incumplidos por la direcci??n
            if nuFlagError = 1 then
                ge_boerrors.seterrorcodeargument(2741, sbErrorsMessages);
            end if;

        end if; -- FIN DEL IF sbInfoPremise

        -- Para el tr?!mite 329-Solicitud de interna,
        -- 100259-Interna IFRS (Jcramirez - TS RQ 3029)
        -- Se validar?!:
        -- * Que el segmento de la direcci??n tenga ciclo de facturaci??n asociado.
        -- * Que el segmento de la direcci??n del predio tenga un sector operativo asociado.
        -- * Que la direcci??n ingresada exista y est?! verificada en el sistema GIS.
        -- * Que en la direcci??n ingresada no exista un producto de gas instalado.
        -- * Que en la direcci??n no existan solicitudes pendientes de solicitud de interna,
        --   venta de gas por formulario o venta cotizada.
          if nuPackageTypeId in (cnuPackTypeSoliciInterna, cnuPackTypeInternaIFRS) then

            -- Se obtiene el segmento de la direcci??n
            nuSegmentId := daab_address.fnugetsegment_id(inuAddressId, 0);

            -- Se obtiene el ciclo de facturaci??n del segmento
            nuCiclFact := daab_segments.fnugetciclcodi(nuSegmentId, 0);

            if nuCiclFact IS null then
                nuFlagError := 1;
                sbErrorsMessages := sbErrorsMessages||'* El segmento de la dirección ingresada no tiene un ciclo de facturación asociado.'||CHR(10);
            end if;

            -- Se obtiene el sector operativo del segmento
            nuOperatingSector := daab_segments.fnugetoperating_sector_id(nuSegmentId, 0);

            if nuOperatingSector IS null then
                nuFlagError := 1;
                sbErrorsMessages := sbErrorsMessages||'* El segmento de la dirección ingresada no tiene un sector operativo asociado.'||CHR(10);
            end if;

            -- Se valida si en la direcci??n existen productos de GAS activos
            nuProductId := PR_BOProduct.fnugetprodbyaddrprodtype(inuAddressId, ld_boconstans.cnuGasService);

            if nuProductId IS not null then
                -- Si el producto no es nulo entonces existen productos de GAS activos
                nuFlagError := 1;
                sbErrorsMessages := sbErrorsMessages||'* Ya existe un producto de GAS instalado en la dirección.'||CHR(10);
            end if;

            -- Se obtiene las solicitudes pendientes por tipo de solicitud y direcci??n
            mo_bopackages.getactpkgbytypnprdadr('P_SOLICITUD_DE_INTERNA_329', inuAddressId, onuPackTypeInter);
            mo_bopackages.getactpkgbytypnprdadr('P_VENTA_DE_GAS_POR_FORMULARIO_271', inuAddressId, onuPackTypeFormu);
            mo_bopackages.getactpkgbytypnprdadr('P_LBC_VENTA_COTIZADA_100229', inuAddressId, onuPackTypeCotiza);

            --------------------------------------------------------------------
            --Jcramirez: TSRQ3019
            mo_bopackages.getactpkgbytypnprdadr('P_FORMULARIO_IFRS_100249',inuAddressId,onuPackTypeFormIFRS);
            mo_bopackages.getactpkgbytypnprdadr('P_INTERNA_IFRS_100259',inuAddressId,onuPackTypeInteIFRS);
            mo_bopackages.getactpkgbytypnprdadr('P_COTIZADA_IFRS_100272',inuAddressId,onuPackTypeCotiIFRS);
            --------------------------------------------------------------------

            -- Se valida que no existan solicitudes de este tipo pendientes
            if onuPackTypeInter IS not null OR onuPackTypeFormu IS not null OR onuPackTypeCotiza IS not null
               OR onuPackTypeFormIFRS IS NOT NULL OR onuPackTypeInteIFRS IS NOT NULL OR onuPackTypeCotiIFRS IS NOT NULL then
                nuFlagError := 1;
                sbErrorsMessages := sbErrorsMessages||'* Existen solicitudes de pendientes en la dirección.'||CHR(10);
            end if;

            -- Se valida que la direcci??n de ingresada est?! validada en el sistema GIS
            sbVerified := daab_address.fsbgetverified(inuAddressId, 0);

            if sbVerified = ge_boconstants.getno then
                nuFlagError := 1;
                sbErrorsMessages := sbErrorsMessages||'* La dirección del predio no está validada en el GIS.'||CHR(10);
            end if;

            -- Se levanta un mensaje de error con todos los requisitos incumplidos por la direcci??n
            if nuFlagError = 1 then
                ge_boerrors.seterrorcodeargument(2741, sbErrorsMessages);
            end if;

        end if; -- FIN DEL IF nuPackageTypeId

        -- Para el tr?!mite 323-Venta a constructoras, se validar?!:
        -- * Que el segmento de la direcci??n tenga ciclo de facturaci??n asociado.
        -- * Que el segmento de la direcci??n del predio tenga un sector operativo asociado.
        -- * Que la direcci??n ingresada exista y est?! verificada en el sistema GIS.
        if nuPackageTypeId in (cnuPackTypeVentaConstruct) then

            -- Se obtiene el segmento de la direcci??n
            nuSegmentId := daab_address.fnugetsegment_id(inuAddressId, 0);

            -- Se obtiene el ciclo de facturaci??n del segmento
            nuCiclFact := daab_segments.fnugetciclcodi(nuSegmentId, 0);

            if nuCiclFact IS null then
                nuFlagError := 1;
                sbErrorsMessages := sbErrorsMessages||'* El segmento de la dirección ingresada no tiene un ciclo de facturación asociado.'||CHR(10);
            end if;

            -- Se obtiene el sector operativo del segmento
            nuOperatingSector := daab_segments.fnugetoperating_sector_id(nuSegmentId, 0);

            if nuOperatingSector IS null then
                nuFlagError := 1;
                sbErrorsMessages := sbErrorsMessages||'* El segmento de la dirección ingresada no tiene un sector operativo asociado.'||CHR(10);
            end if;

            -- Se valida que la direcci??n de ingresada est?! validada en el sistema GIS
            sbVerified := daab_address.fsbgetverified(inuAddressId, 0);

            if sbVerified = ge_boconstants.getno then
                nuFlagError := 1;
                sbErrorsMessages := sbErrorsMessages||'* La dirección del predio no está validada en el GIS.'||CHR(10);
            end if;

            -- Se levanta un mensaje de error con todos los requisitos incumplidos por la direcci??n
            if nuFlagError = 1 then
                ge_boerrors.seterrorcodeargument(2741, sbErrorsMessages);
            end if;

        end if; -- FIN DEL IF nuPackageTypeId

        UT_Trace.Trace( 'End LDC_BOInfoAddress.valInfoPremise', 1);

    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN others THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END valInfoPremise;

END LDC_BOInfoAddress;
/
