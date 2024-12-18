CREATE OR REPLACE PROCEDURE ProcRenew
IS
    /*****************************************************************
       Propiedad intelectual de Open International Systems (c).

       Unidad         : ProcRenew
       Descripcion    : Proceso que verifica las polizas que hayan cumplido con la
                      fecha de vigencia al momento de ejecucion del proceso y no presenten una
                       solicitud de no renovacion.

       Autor          : AAcuna
       Fecha          : 14/08/2012 SAO 147879

       Parametros         Descripcion
       ============  ===================

       Historia de Modificaciones
       Fecha            Autor          Modificacion
       ==========  =================== =======================
       20/02/2017  KBaquero             ESTE ES UN COMENTARIO DE EFIGAS
       23/09/2015   Agordillo.SAO334174 Se cambia el proceso que envia el correo electronico por LDC_MANAGEMENTEMAILFNB.PROENVIARCHIVOCC
                                         Se adjunta el archivo sbFile el cual corresponde al documento .CSV con el resultado del proceso
       31/08/2015  mgarcia.SAO334174   Se modifica proceso para que genere un
                                       archivo de log de errores en formato csv.
       29-12-2014  Llozada [ARA 5843]  Se obtiene el POLICY_ID de la poliza para traer la venta
       15-12-2014  Llozada [NC 4230]   Se modifica el metodo para que haga commit cada 50 registros y para que guarde
                                       en el Log los errores del procesos y las polizas creadas con exito
       26-09-2014  llarrarte.RQ1719    Se elimina validacion de diferidos con saldo
                                       para permitir que la renovacion se ejecute al
                                       termino de la vigencia y no dejar al usuario
                                       sin cobertura hasta el pago de la ultima cuota
                                       antes de la renovacion
                                       Se adiciona numero del colectivo en el XML
       16-09-2014  llarrarte.RQ1178    Se modificar primero el estado de la poliza anterior
                                       para  permitir el registro de la venta de la nueva poliza,
                                       esto debido a que al renovar utilizando la venta
                                       el sistema va a validar la cantidad de polizas activas para la cedula.
                                       Se impacta por adicion de los campos policy_number.
       08/08/2014  AEcheverry.4152     Se elimina la generacion de cargos ya que estos
                                       se registraran en el flujo en la actividad que
                                       genera los diferidos.

       18/07/2014  KCienfuegos.RNP550  Se valida si el tipo de poliza tiene categoria y subcategoria configurada
       01/07/2014  AEcheverry.4031     se valida que el producto no se encuentre en un estdo de retiro voluntario
       27-06-2014  aesguerra.4029    Se incluye validacion para identificar si un producto posee deuda diferida
       01/04/2014  AEcheverrySAO236799 Se modifica para realizar un bloqueo con semaforos
                                       y asi evitar ejecutar al tiempo el proceso
                                       de renovacion de polizas
       28/02/2014  hjgomez.SAO234504   Se modifica para que no genere el saldo a favor y
                                       lo genere luego de crear los diferidos
       21/12/2013  jrobayo.SAO228441   Se modifica para enviar el valor correpondiente a la
                                       poliza para su vigencia actual.
       17/12/2013  JCarmona.SAO227834  Se modifica para enviar en el campo reception_type_id el
                                       medio de recepcion obtenido del parametro COD_REC_TYPE.
       27/11/2013  JCarmona.SAO224868  Se modifica para que genere una solicitud de venta de seguros
                                       para crear la nueva poliza y el registro en ld_secure_sale.
       17/10/2013  JCarmona.SAO220105  Se modifica el procedimiento que obtiene el
                                       numero del diferido <Ld_BcSecureManagement.GetDefferedByPol>,
                                       por lo tanto se modifica el llamado a este metodo para
                                       enviarle el id del producto y no de la poliza.
       06/09/2013  jrobayo.SAO216575   1-  Se modifica para validar si existen solicitudes
                                           de cancelacion de polizas en estado registrado
       03/09/2013  jcarrillo.SAO212983 1 - Se modifica para almacenar el campo que indica
                                           si una poliza es exequial
       03/09/2013  jcarrillo.SAO214425 1 - Se modifica para atender la solicitud de
                                           financiacion
       27-08-2013  jcastro.SAO214426   1 - Se impacta por modificar la entidad
                                           <ld_policy> y creacion de la entidad
                                           <ld_validity_policy_type>
       27-08-2013  jcarrillo.SAO214426 Se modifica por borrado de la constante
                                       <LD_BOConstans.CnuStateOrder>
	   16/11/2023  jsoto (OSF-1802)		Ajustes:
											-Ajustes cambio en llamado a algunos de los objetos de producto por personalizados
											-Ajuste  cambio en manejo de trazas y errores por personalizados (pkg_error y pkg_traza).
											-Ajuste llamado a pkg_xml_sol_seguros para armar los xml de las solicitudes
											-Ajuste llamado a api_registerRequestByXml
											-Ajuste llamado a api_createorder para crear ordenes y actividades
											-Se suprimen llamado a "AplicaEntrega" que no se encuentren activos
        07/03/2024  jpinedc OSF-2377    Se cambia el manejo de archivos a
                                        pkg_gestionArchivos
        27/06/2024  jpinedc OSF-2606    Se usa pkg_Correo
       ******************************************************************/       
    cnuZERO       CONSTANT NUMBER := ld_boconstans.cnuCero_Value;
    cnuONE        CONSTANT NUMBER := LD_BOConstans.cnuonenumber;

    rfCursorPolicy         constants_per.tyRefCursor;
    nuNextPolicy           NUMBER;
    nuStateRenew           ld_parameter.numeric_value%TYPE;
    nuGeo                  ge_geogra_location.geograp_location_id%TYPE;
    nuadd                  ab_address.address%TYPE;

    nuOrderPay             ld_parameter.numeric_value%TYPE;

    nuOrderCharge          ld_parameter.numeric_value%TYPE;
    nuorderid              or_order.order_id%TYPE;
    nuorderactivityid      or_order_activity.order_activity_id%TYPE;

    rfPolicy               LD_BOConstans.rfPolicy%TYPE;
    nuPolicy               ld_policy.policy_id%TYPE;
    nuValue                NUMBER;
    rcPolicyType           dald_policy_type.styLD_policy_type;

    rcValidityPolicyType   dald_validity_policy_type.styLD_validity_policy_type; -- JCASTRO

    nuSolicNoRen           NUMBER;
    nuPackage              mo_packages.package_id%TYPE;
    nuerror                NUMBER;
    sbmessage              VARCHAR2 (2000);

    /*Variables de archivo de log*/

    sbLog                  VARCHAR2 (500);                   -- Log de errores
    sbLineLog              VARCHAR2 (1000);
    sbFileManagement       pkg_gestionArchivos.styArchivo;
    sbTimeProc             VARCHAR2 (500);
    sbPath                 VARCHAR2 (500);

    nuSuscripc             suscripc.susccodi%TYPE;
    onuSusc                suscripc.susccodi%TYPE;
    nuServsusc             servsusc.sesunuse%TYPE;

    frfOperating           constants_per.tyrefcursor;
    recOrope               or_operating_unit%ROWTYPE;

    nuUnitOper             mo_packages.pos_oper_unit_id%TYPE;
    dtEndpolicy            ld_validity_policy_type.final_date%TYPE;
    dtIniPolicy            ld_validity_policy_type.initial_date%TYPE;
    nugesubs               ge_subscriber.subscriber_id%TYPE;
    nurecptype             ld_parameter.numeric_value%TYPE;
    nuplandif              ld_parameter.numeric_value%TYPE;
    sbState                ld_parameter.value_chain%TYPE;
    nuCategory             ab_segments.category_%TYPE;
    nuSubcategory          ab_segments.subcategory_%TYPE;
    rcSecureSale           dald_secure_sale.styLD_secure_sale;
    nuContactId            suscripc.suscclie%TYPE;
    sbXML                  constants_per.tipo_xml_sol%TYPE;
    nuPackageId            mo_packages.package_id%TYPE;
    nuMotiveId             mo_motive.motive_id%TYPE;
    nuErrorCode            NUMBER;
    sbErrorMessage         VARCHAR2 (4000);
    nuValiPolTyp           NUMBER;

    nuordervalue           NUMBER;
    -- bloqueo del proceso
    nuRequestResult        NUMBER;
    sbLockHandle           VARCHAR2 (2000);
    blHasDefBalance        BOOLEAN;
    blHasCateg             BOOLEAN;
    blSamePolType          BOOLEAN;
    nuNewPolicyTyp         ld_policy_type.policy_type_id%TYPE;
    nuCategory_            subcateg.sucacate%TYPE;
    nuSubcategory_         subcateg.sucacodi%TYPE;
    nuSubscriber           ge_subscriber.subscriber_id%TYPE;
    nuProductLine          ld_policy_type.product_line_id%TYPE;
    nuContratista          ld_policy_type.contratista_id%TYPE;
    nuChangePolTyp         NUMBER;
    sbCanBySin             ld_parameter.value_chain%TYPE;
    sbCanCausal            ld_parameter.value_chain%TYPE;
    sbRequestXML           constants_per.tipo_xml_sol%TYPE;
    nuCurrentBalance       NUMBER;
    dtPayLastAccount       DATE;

    nuMonth                NUMBER;
    nuMaxQuotRenew         NUMBER;
    nuLastPolicyId         ld_policy.policy_id%TYPE;
    nuCollectiveNumber     NUMBER;
    ------------
    sbFile                 VARCHAR2 (500);
    sbLineFile             VARCHAR2 (1000);
    sbFileManagementf      pkg_gestionArchivos.styArchivo;
    vnuexito               NUMBER := 0;
    vnunoexito             NUMBER := 0;
    sbAsunto               VARCHAR2 (2000);
    sbMensaje             VARCHAR2 (2000);
    sbDestinatarios            ld_parameter.value_chain%TYPE; --Direccion de email que recibe
	
	csbMT_NAME  			VARCHAR2(70) :=  'PROCRENEW';
	
	sbInstanciaBD			VARCHAR2(30);

    --11-12-2014 Llozada [NC 4230]
    TYPE tyPoliza IS RECORD
    (
        sbLinea    VARCHAR2 (4000)
    );

    TYPE tbtyPoliza IS TABLE OF tyPoliza
        INDEX BY BINARY_INTEGER;

    tbPoliza               tbtyPoliza;

    nuContador             NUMBER := 1;
    nuIndex                NUMBER;

    nuPolicy_ID            ld_policy.policy_id%TYPE;
    nuCantCommit           NUMBER;
	
	sbdataorder       	   VARCHAR2 (2000);
	

    /*29-12-2014 Llozada [ARA 5843]: Se obtiene el POLICY_ID de la poliza para traer la venta*/
    CURSOR cuPolicy (inuProductId IN servsusc.sesunuse%TYPE)
    IS
        SELECT policy_id
          FROM (  SELECT *
                    FROM ld_policy
                   WHERE     product_id = inuProductId
                         AND state_policy =
                             pkg_BCLD_Parameter.fsbObtieneValorCadena (
                                 LD_BOConstans.cnuCodStateRenew)
                ORDER BY dtcreate_policy DESC)
         WHERE ROWNUM = 1;
		 
	
	CURSOR cuColectivo(nuPoliza ld_policy.policy_id%TYPE)IS
		SELECT collective_number
		  FROM ld_policy
		 WHERE policy_id = nuPoliza;
		 
	CURSOR cuSolicitud(nuPoliza ld_renewall_securp.policy_id%TYPE)IS
		SELECT OR_ORDER_ACTIVITY.PACKAGE_ID
		  FROM ld_renewall_securp,
			   or_order,
			   OR_ORDER_ACTIVITY,
			   ge_causal
		 WHERE     ld_renewall_securp.policy_id = nuPoliza
			   AND OR_ORDER_ACTIVITY.package_id = ld_renewall_securp.package_id
			   AND OR_ORDER_ACTIVITY.order_id = or_order.order_id
			   AND or_order.order_status_id = 8
			   AND or_order.causal_id = ge_causal.causal_id
			   AND ge_causal.class_causal_id = 2
			   AND ROWNUM = 1;

		 

    PROCEDURE release_lock
    IS
    BEGIN
        IF (sbLockHandle IS NOT NULL)
        THEN
            nuRequestResult := DBMS_LOCK.release (lockhandle => sbLockHandle);
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
			pkg_error.geterror(nuErrorCode,sbErrorMessage);
		    pkg_traza.trace('Error inesperado' || sbErrorMessage, pkg_traza.cnuNivelTrzDef);
    END;
BEGIN

	pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);

    sbPath := pkg_BCLD_Parameter.fsbObtieneValorCadena (LD_BOConstans.csbRutLogs);

    IF (    DALD_PARAMETER.fblExist (LD_BOConstans.csbCodStatePolicy)
        AND DALD_PARAMETER.fblExist (LD_BOConstans.cnuCodStateRenew)
        AND dald_parameter.fblexist (LD_BOConstans.CsbActivityPay)
        AND dald_parameter.fblexist (LD_BOConstans.CsbActivityCharge)
        AND dald_parameter.fblexist ('FINANCING_PLAN_ID')
        AND dald_parameter.fblexist ('COD_REC_TYPE')
        AND dald_parameter.fblexist ('FNB_CANT_COMMIT_PROC_RENEW'))
    THEN
        --bloqueo del proceso
        DECLARE
            sbLockName   VARCHAR2 (100) := 'RENEW_POLICY_PROCESS_';
        BEGIN
            -- Genera un manejador de bloqueo para el contrato.
            EXECUTE IMMEDIATE 'DECLARE PRAGMA AUTONOMOUS_TRANSACTION; BEGIN dbms_lock.allocate_unique(:sbLockName,:sbLockHandle); END;'
                USING sbLockName, OUT sbLockHandle;

            nuRequestResult :=
                DBMS_LOCK.request (lockhandle          => sbLockHandle,
                                   timeout             => 0,
                                   release_on_commit   => FALSE);
        EXCEPTION
            WHEN OTHERS
            THEN
                pkg_traza.Trace (
                    'WARNING: No Bloqueo proceso [' || sbLockName || ']',
                    pkg_traza.cnuNivelTrzDef);
        END;

        -- ya se encuentra proceso ejecutando (bloqueado)
        IF (nuRequestResult IN (1, 2))
        THEN
            pkg_error.setErrorMessage(
                isbMsgErrr => 
                'Ya se encuentra un proceso de renovacion en ejecucion');
        END IF;

        nuOrderPay :=
            TO_NUMBER (
                pkg_BCLD_Parameter.fsbObtieneValorCadena (
                    LD_BOConstans.CsbActivityPay));
        nuOrderCharge :=
            TO_NUMBER (
                pkg_BCLD_Parameter.fsbObtieneValorCadena (
                    LD_BOConstans.CsbActivityCharge));
        nurecptype := pkg_BCLD_Parameter.fnuObtieneValorNumerico ('COD_REC_TYPE');
        nuplandif := pkg_BCLD_Parameter.fnuObtieneValorNumerico ('FINANCING_PLAN_ID');
        sbState :=
            pkg_BCLD_Parameter.fsbObtieneValorCadena (LD_BOConstans.csbCodStatePolicy);
        nuStateRenew :=
            pkg_BCLD_Parameter.fsbObtieneValorCadena (LD_BOConstans.cnuCodStateRenew);
        nuCantCommit :=
            pkg_BCLD_Parameter.fnuObtieneValorNumerico ('FNB_CANT_COMMIT_PROC_RENEW');

        sbTimeProc := TO_CHAR (SYSDATE, 'yyyymmdd_hh24miss');

        /* Arma nombre del archivo LOG */
        sbLog := 'RE_' || sbTimeProc || '.LOG';
        /* Arma nombre del archivo CSV */
        sbFile := 'RE_' || sbTimeProc || '.CSV';                -- SAO[334174]

        /* Crea archivo Log */
        sbFileManagement := pkg_gestionArchivos.ftAbrirArchivo_SMF (sbPath, sbLog, 'w');
        /* Crea archivo Csv */
        sbFileManagementf := pkg_gestionArchivos.ftAbrirArchivo_SMF (sbPath, sbFile, 'w'); -- SAO[334174]

        sbLineLog :=
               ' INICIO PROCESO DE RENOVACION '
            || TO_CHAR (SYSDATE, 'DD/MM/YYYY HH24:MI:SS');

       pkg_gestionArchivos.prcEscribirLinea_SMF (sbFileManagement, sbLineLog);

        sbLinefile :=
            'CONTRATO;PRODUCTO;POLIZA;COLECTIVO;VALOR;CAMPO;MENSAJE';
       pkg_gestionArchivos.prcEscribirLinea_SMF (sbFileManagementf, sbLinefile);

        IF nuStateRenew IS NOT NULL
        THEN
            nuMonth := TO_CHAR (ADD_MONTHS (SYSDATE, 1), 'MM');

            nuMaxQuotRenew :=
                pkg_BCLD_Parameter.fnuObtieneValorNumerico (ld_boconstans.csbMaxQuotRenew);

            ld_bcsecuremanagement.getPolByCollecAndProdLine (nuMonth,
                                                             NULL,
                                                             rfCursorPolicy);

            LOOP
                FETCH rfCursorPolicy BULK COLLECT INTO rfPolicy LIMIT 10;

                nuNextPolicy := rfPolicy.FIRST;

                WHILE (nuNextPolicy IS NOT NULL)
                LOOP
                    SAVEPOINT TEMPPOLICY;

                    BEGIN
                        sbLinefile := NULL;
                        sbLineLog := NULL;

                        IF (ld_bcsecuremanagement.fnuGetPendQuotas (
                                rfPolicy (nuNextPolicy).product_id) >
                            nuMaxQuotRenew)
                        THEN
                            -- SAO[334174]
                            sbLinefile :=
                                   rfPolicy (nuNextPolicy).suscription_id
                                || ';'
                                || rfPolicy (nuNextPolicy).product_id
                                || ';'
                                || rfPolicy (nuNextPolicy).policy_number
                                || ';'
                                || DAld_policy.fnuGetCOLLECTIVE_NUMBER (
                                       rfPolicy (nuNextPolicy).policy_id)
                                || ';'
                                || ld_bcsecuremanagement.fnuGetPendQuotas (
                                       rfPolicy (nuNextPolicy).product_id)
                                || ';'
                                || 'CUOTAS PENDIENTES'
                                || ';'
                                || 'La poliza no cumple con la cantidad maxima de cuotas pendientes para ser renovada';
                           pkg_gestionArchivos.prcEscribirLinea_SMF (sbFileManagementf,
                                                   sbLinefile);

                            sbLineLog :=
                                   '[Contrato:'
                                || rfPolicy (nuNextPolicy).suscription_id
                                || '- Producto:'
                                || rfPolicy (nuNextPolicy).product_id
                                || '- Poliza:'
                                || rfPolicy (nuNextPolicy).policy_number
                                || '- Colectivo:'
                                || DAld_policy.fnuGetCOLLECTIVE_NUMBER (
                                       rfPolicy (nuNextPolicy).policy_id)
                                || '- Cuotas pendientes: '
                                || ld_bcsecuremanagement.fnuGetPendQuotas (
                                       rfPolicy (nuNextPolicy).product_id)
                                || '] No cumple con la cantidad maxima de cuotas pendientes para ser renovada';

                            vnunoexito := vnunoexito + 1;

                            pkg_error.setErrorMessage(
                                isbMsgErrr => 
                                sbLineLog);
                        END IF;

                        IF (LD_BCSecureManagement.fblHasPendSales (
                                rfPolicy (nuNextPolicy).product_id))
                        THEN
                            -- SAO[334174]
                            sbLinefile :=
                                   rfPolicy (nuNextPolicy).suscription_id
                                || ';'
                                || rfPolicy (nuNextPolicy).product_id
                                || ';'
                                || rfPolicy (nuNextPolicy).policy_number
                                || ';'
                                || DAld_policy.fnuGetCOLLECTIVE_NUMBER (
                                       rfPolicy (nuNextPolicy).policy_id)
                                || ';'
                                || rfPolicy (nuNextPolicy).product_id
                                || ';'
                                || 'PRODUCTO'
                                || ';'
                                || 'El producto tiene solicitudes de ventas de seguros sin atender';
                           pkg_gestionArchivos.prcEscribirLinea_SMF (sbFileManagementf,
                                                   sbLinefile);

                            sbLineLog :=
                                   '[Contrato:'
                                || rfPolicy (nuNextPolicy).suscription_id
                                || '- Producto:'
                                || rfPolicy (nuNextPolicy).product_id
                                || '- Poliza:'
                                || rfPolicy (nuNextPolicy).policy_number
                                || '- Colectivo:'
                                || DAld_policy.fnuGetCOLLECTIVE_NUMBER (
                                       rfPolicy (nuNextPolicy).policy_id)
                                || '- Producto: '
                                || rfPolicy (nuNextPolicy).product_id
                                || '] El producto tiene solicitudes de ventas de seguros sin atender';

                            vnunoexito := vnunoexito + 1;

                            pkg_error.setErrorMessage(
                                isbMsgErrr => 
                                sbLineLog);
                        END IF;

                        nuChangePolTyp := cnuZERO;

                        blHasCateg :=
                            LD_BCSecureManagement.fblPolicyTypeHasCateg (
                                rfPolicy (nuNextPolicy).policy_type_id);

                        IF blHasCateg
                        THEN
                            nuSubscriber :=
                                pkg_bccontrato.fnuidcliente (
                                    rfPolicy (nuNextPolicy).suscription_id);
                            nuCategory_ :=
                                daab_premise.fnugetcategory_ (
                                    pkg_bcdirecciones.fnuGetPredio (
                                        pkg_bccliente.fnudireccion (
                                            nuSubscriber)));
                            nuSubcategory_ :=
                                daab_premise.fnugetsubcategory_ (
                                    pkg_bcdirecciones.fnuGetPredio (
                                        pkg_bccliente.fnudireccion (
                                            nuSubscriber)));
                            blSamePolType :=
                                LD_BCSecureManagement.fblSamePolicyType (
                                    rfPolicy (nuNextPolicy).policy_type_id,
                                    nuCategory_,
                                    nuSubcategory_);

                            IF NOT blSamePolType
                            THEN
                                nuProductLine :=
                                    dald_policy_type.fnuGetPRODUCT_LINE_ID (
                                        rfPolicy (nuNextPolicy).policy_type_id);
                                nuContratista :=
                                    dald_policy_type.fnuGetCONTRATISTA_ID (
                                        rfPolicy (nuNextPolicy).policy_type_id);
                                LD_BCSecureManagement.GetNewPolicyType (
                                    nuProductLine,
                                    nuContratista,
                                    nuCategory_,
                                    nuSubcategory_,
                                    nuNewPolicyTyp);

                                IF nuNewPolicyTyp IS NULL
                                THEN
                                    -- SAO[334174]
                                    sbLinefile :=
                                           rfPolicy (nuNextPolicy).suscription_id
                                        || ';'
                                        || rfPolicy (nuNextPolicy).product_id
                                        || ';'
                                        || rfPolicy (nuNextPolicy).policy_number
                                        || ';'
                                        || DAld_policy.fnuGetCOLLECTIVE_NUMBER (
                                               rfPolicy (nuNextPolicy).policy_id)
                                        || ';'
                                        || rfPolicy (nuNextPolicy).policy_type_id
                                        || ';'
                                        || 'TIPO POLIZA'
                                        || ';'
                                        || 'No existe un tipo de poliza que cubra la categoria ['
                                        || nuCategory_
                                        || '] o la subcategoria ['
                                        || nuSubcategory_
                                        || ']';
                                   pkg_gestionArchivos.prcEscribirLinea_SMF (sbFileManagementf,
                                                           sbLinefile);

                                    sbLineLog :=
                                           '[Contrato:'
                                        || rfPolicy (nuNextPolicy).suscription_id
                                        || '- Producto:'
                                        || rfPolicy (nuNextPolicy).product_id
                                        || '- Poliza:'
                                        || rfPolicy (nuNextPolicy).policy_number
                                        || '- Colectivo:'
                                        || DAld_policy.fnuGetCOLLECTIVE_NUMBER (
                                               rfPolicy (nuNextPolicy).policy_id)
                                        || '- Tipo poliza: '
                                        || rfPolicy (nuNextPolicy).policy_type_id
                                        || '] No existe un tipo de poliza que cubra la categoria ['
                                        || nuCategory_
                                        || '] o la subcategoria ['
                                        || nuSubcategory_
                                        || ']';

                                    vnunoexito := vnunoexito + 1;

                                    pkg_error.setErrorMessage(
                                        isbMsgErrr => 
                                        sbLineLog);
                                ELSE
                                    rfPolicy (nuNextPolicy).policy_type_id :=
                                        nuNewPolicyTyp;
                                    nuChangePolTyp := cnuONE;
                                END IF;
                            END IF;
                        END IF;

                        dald_policy_type.getRecord (
                            rfPolicy (nuNextPolicy).policy_type_id,
                            rcPolicyType);

                        ld_bcsecuremanagement.GetValidityPolicyType (
                            rcPolicyType.policy_type_id,
                            ldc_boconsgenerales.fdtgetsysdate,
                            nuValiPolTyp);

                        -- Se obtiene el record de la Vigencia por Tipo de Poliza   -- JCASTRO
                        IF (nuValiPolTyp IS NOT NULL)
                        THEN
                            dald_validity_policy_type.getRecord (
                                nuValiPolTyp,
                                rcValidityPolicyType);
                        ELSE
                            -- SAO[334174]
                            sbLinefile :=
                                   rfPolicy (nuNextPolicy).suscription_id
                                || ';'
                                || rfPolicy (nuNextPolicy).product_id
                                || ';'
                                || rfPolicy (nuNextPolicy).policy_number
                                || ';'
                                || DAld_policy.fnuGetCOLLECTIVE_NUMBER (
                                       rfPolicy (nuNextPolicy).policy_id)
                                || ';'
                                || rfPolicy (nuNextPolicy).policy_type_id
                                || ';'
                                || 'TIPO POLIZA'
                                || ';'
                                || 'El tipo de poliza no se encuentra vigente para el numero de poliza';
                           pkg_gestionArchivos.prcEscribirLinea_SMF (sbFileManagementf,
                                                   sbLinefile);

                            sbLineLog :=
                                   '[Contrato:'
                                || rfPolicy (nuNextPolicy).suscription_id
                                || '- Producto:'
                                || rfPolicy (nuNextPolicy).product_id
                                || '- Poliza:'
                                || rfPolicy (nuNextPolicy).policy_number
                                || '- Colectivo:'
                                || DAld_policy.fnuGetCOLLECTIVE_NUMBER (
                                       rfPolicy (nuNextPolicy).policy_id)
                                || '- Tipo poliza: '
                                || rfPolicy (nuNextPolicy).policy_type_id
                                || '] El tipo de poliza no se encuentra vigente para el numero de poliza';

                            vnunoexito := vnunoexito + 1;

                            pkg_error.setErrorMessage(
                                isbMsgErrr => 
                                sbLineLog);
                        END IF;

                        --- se valida que el producto no se encuentre en un estdo de retiro voluntario
                        IF (pkg_bcproducto.fnuestadocorte (
                                rfPolicy (nuNextPolicy).product_id) IN
                                (94, 95))
                        THEN
                            -- SAO[334174]
                            sbLinefile :=
                                   rfPolicy (nuNextPolicy).suscription_id
                                || ';'
                                || rfPolicy (nuNextPolicy).product_id
                                || ';'
                                || rfPolicy (nuNextPolicy).policy_number
                                || ';'
                                || DAld_policy.fnuGetCOLLECTIVE_NUMBER (
                                       rfPolicy (nuNextPolicy).policy_id)
                                || ';'
                                || pkg_bcproducto.fnuestadocorte (
                                       rfPolicy (nuNextPolicy).product_id)
                                || ';'
                                || 'ESTADO CORTE'
                                || ';'
                                || 'El producto se encuentra en proceso de retiro voluntario';
                           pkg_gestionArchivos.prcEscribirLinea_SMF (sbFileManagementf,
                                                   sbLinefile);

                            sbLineLog :=
                                   '[Contrato:'
                                || rfPolicy (nuNextPolicy).suscription_id
                                || '- Producto:'
                                || rfPolicy (nuNextPolicy).product_id
                                || '- Poliza:'
                                || rfPolicy (nuNextPolicy).policy_number
                                || '- Colectivo:'
                                || DAld_policy.fnuGetCOLLECTIVE_NUMBER (
                                       rfPolicy (nuNextPolicy).policy_id)
                                || '- Estado Corte: '
                                || pkg_bcproducto.fnuestadocorte (
                                       rfPolicy (nuNextPolicy).product_id)
                                || '] El producto se encuentra en proceso de retiro voluntario';

                            vnunoexito := vnunoexito + 1;

                            pkg_error.setErrorMessage(
                                isbMsgErrr => 
                                sbLineLog);
                        END IF;

                        ld_bcsecuremanagement.GetPolicyType (
                            rfPolicy (nuNextPolicy).policy_type_id,
                            nuValue);

                        dtIniPolicy :=
                            dald_policy.fdtGetDT_EN_POLICY (
                                rfPolicy (nuNextPolicy).policy_id);

                        IF (dtIniPolicy IS NULL)
                        THEN
                            dtIniPolicy := TRUNC (SYSDATE);
                        ELSE
                            dtIniPolicy := TRUNC (dtIniPolicy + 1);
                        END IF;

                        dtEndPolicy :=
                            Ld_BcSecureManagement.fdtfechendtypoli (
                                rcValidityPolicyType.coverage_month,
                                dtIniPolicy);                       -- JCASTRO

                        ld_bcsecuremanagement.GetSuscPol (
                            rfPolicy (nuNextPolicy).policy_id,
                            onuSusc);

                        -- se valida si se tiene un producto de gas activo
                        BEGIN                                   -- SAO[334174]
                            ld_bosecuremanagement.ProcValidateProductparam (
                                onuSusc);
                        EXCEPTION
                            WHEN OTHERS
                            THEN
                                sbLinefile :=
                                       rfPolicy (nuNextPolicy).suscription_id
                                    || ';'
                                    || rfPolicy (nuNextPolicy).product_id
                                    || ';'
                                    || rfPolicy (nuNextPolicy).policy_number
                                    || ';'
                                    || DAld_policy.fnuGetCOLLECTIVE_NUMBER (
                                           rfPolicy (nuNextPolicy).policy_id)
                                    || ';'
                                    || rfPolicy (nuNextPolicy).suscription_id
                                    || ';'
                                    || 'CONTRATO'
                                    || ';'
                                    || 'El producto de gas no cumple con los estados del parametro [COD_STATE_PROD_SECURE]';
                               pkg_gestionArchivos.prcEscribirLinea_SMF (sbFileManagementf,
                                                       sbLinefile);

                                sbLineLog :=
                                       '[Contrato:'
                                    || rfPolicy (nuNextPolicy).suscription_id
                                    || '- Producto:'
                                    || rfPolicy (nuNextPolicy).product_id
                                    || '- Poliza:'
                                    || rfPolicy (nuNextPolicy).policy_number
                                    || '- Colectivo:'
                                    || DAld_policy.fnuGetCOLLECTIVE_NUMBER (
                                           rfPolicy (nuNextPolicy).policy_id)
                                    || '- Contrato: '
                                    || rfPolicy (nuNextPolicy).suscription_id
                                    || '] El producto de gas no cumple con los estados del parametro [COD_STATE_PROD_SECURE]';

                                vnunoexito := vnunoexito + 1;
                                pkg_error.setErrorMessage(
                                    isbMsgErrr => 
                                    sbLineLog);
                        END;

                        nuSolicNoRen :=
                            Ld_BcSecureManagement.GetSolicNoRenewall (
                                rfPolicy (nuNextPolicy).policy_id);

                        IF (nuSolicNoRen = 0)
                        THEN
                            IF (nuValue = 1)
                            THEN
                                /* Se obtiene la Categoria y Subcategoria dado el producto */
								nuCategory:= pkg_bcproducto.fnuCategoria(rfPolicy (nuNextPolicy).product_id);
								nuSubcategory := pkg_bcproducto.fnuSubCategoria(rfPolicy (nuNextPolicy).product_id);
                                /* Se obtine el suscriptor del contrato */
                                nuContactId :=
                                    pkg_bccontrato.fnuidcliente (
                                        rfPolicy (nuNextPolicy).suscription_id);

                                /* Actualizar poliza anterior */
                                dald_policy.updComments (
                                    rfPolicy (nuNextPolicy).policy_id,
                                    'Esta poliza fue renovada');

                                dald_policy.updState_Policy (
                                    rfPolicy (nuNextPolicy).policy_id,
                                    nuStateRenew);

                                nuPolicy :=
                                    ld_bcsecuremanagement.fnuGetRenewPolicyByProduct (
                                        rfPolicy (nuNextPolicy).product_id);

                                /*29-12-2014 Llozada [ARA 5843]: Se obtiene el POLICY_ID de la poliza para traer la venta*/
                                OPEN cuPolicy (
                                    rfPolicy (nuNextPolicy).product_id);

                                FETCH cuPolicy INTO nuPolicy_ID;

                                CLOSE cuPolicy;

                                /* Se obtiene la fecha de nacimiento de la venta de seguros */
                                rcSecureSale :=
                                    Ld_BcSecureManagement.fnuGetSecureSale (
                                        nuPolicy_ID);

                                /* Se crea la poliza nueva a traves del tramite de Venta de Seguros por XML */

                                sbXML := pkg_xml_sol_seguros.getSolicitudVentaSeguros(
																					  rfPolicy (nuNextPolicy).suscription_id,
																					  nurecptype,
																					  'Poliza creada por proceso de renovacion de seguros',
																					  ldc_boconsgenerales.fdtgetsysdate,
																					  NULL,
																					  nuContactId,
																					  pkg_BCLD_Parameter.fnuObtieneValorNumerico ('FINANCING_PLAN_ID'),
																					  NULL,
																					  nuCategory,
																					  nuSubcategory,
																					  'N',
																					  rfPolicy (nuNextPolicy).contratist_code,
																					  rcSecureSale.identification_id,
																					  rfPolicy (nuNextPolicy).product_line_id,
																					  rcSecureSale.born_date,
																					  rcPolicyType.policy_type_id,
																					  nuPolicy,
																					  rcValidityPolicyType.policy_value,
																					  NULL,
																					  NULL,
																					  rfPolicy (nuNextPolicy).product_id
																					  );

                                api_registerrequestbyxml (sbXML,
                                                           nuPackageId,
                                                           nuMotiveId,
                                                           nuErrorCode,
                                                           sbErrorMessage);

                                -- SAO[334174]
                                IF (nuPackageId IS NOT NULL)
                                THEN
                                    COMMIT;
                                ELSE
                                    sbLinefile :=
                                           rfPolicy (nuNextPolicy).suscription_id
                                        || ';'
                                        || rfPolicy (nuNextPolicy).product_id
                                        || ';'
                                        || rfPolicy (nuNextPolicy).policy_number
                                        || ';'
                                        || DAld_policy.fnuGetCOLLECTIVE_NUMBER (
                                               rfPolicy (nuNextPolicy).policy_id)
                                        || ';'
                                        || nuPolicy
                                        || ';'
                                        || 'POLIZA'
                                        || ';'
                                        || 'Error creando solicitud de venta de seguros para poliza, Error('
                                        || nuErrorCode
                                        || ') : '
                                        || sbErrorMessage;
                                   pkg_gestionArchivos.prcEscribirLinea_SMF (sbFileManagementf,
                                                           sbLinefile);

                                    sbLineLog :=
                                           '[Contrato:'
                                        || rfPolicy (nuNextPolicy).suscription_id
                                        || '- Producto:'
                                        || rfPolicy (nuNextPolicy).product_id
                                        || '- Poliza:'
                                        || rfPolicy (nuNextPolicy).policy_number
                                        || '- Colectivo:'
                                        || DAld_policy.fnuGetCOLLECTIVE_NUMBER (
                                               rfPolicy (nuNextPolicy).policy_id)
                                        || '- Poliza: '
                                        || nuPolicy
                                        || '] Error creando solicitud de venta de seguros para poliza, Error('
                                        || nuErrorCode
                                        || ') : '
                                        || sbErrorMessage;

                                    vnunoexito := vnunoexito + 1;

									pkg_error.setErrorMessage(nuErrorCode,sbErrorMessage); 
									RAISE pkg_error.controlled_error;

                                END IF;


                                nuLastPolicyId :=
                                    ld_bcsecuremanagement.fnuGetIdByPolicyNumber (
                                        nuPolicy);

                                -- se actualiza la nueva poliza con las fechas correspondientes segun la poliza anterior
                                IF (dald_policy.fblExist (nuLastPolicyId))
                                THEN
                                    dald_policy.updDT_IN_POLICY (
                                        nuLastPolicyId,
                                        dtIniPolicy);
                                    dald_policy.updDT_EN_POLICY (
                                        nuLastPolicyId,
                                        dtEndPolicy);
                                END IF;

								IF cuColectivo%ISOPEN THEN
									CLOSE cuColectivo;
								END IF;
								
								OPEN cuColectivo(rfPolicy (nuNextPolicy).policy_id);
								FETCH cuColectivo INTO nuCollectiveNumber;
								IF cuColectivo%NOTFOUND then
									CLOSE cuColectivo;
									RAISE pkg_error.controlled_error;
								END IF;
								CLOSE cuColectivo;


                                UPDATE ld_policy
                                   SET collective_number = nuCollectiveNumber
                                 WHERE policy_id = nuLastPolicyId;


                                /*Se obtiene la unidad operativa del tipo de poliza, esta unidad operativa se usara para la
                                asignacion de ordenes*/

                                frfOperating :=
                                    ld_bcsecuremanagement.frfGetOperating (
                                        rcPolicyType.policy_type_id);

                                FETCH frfOperating INTO recOrope;

                                nuUnitOper := recOrope.operating_unit_id;

                                CLOSE frfOperating;

                                nuSuscripc :=
                                    rfPolicy (nuNextPolicy).suscription_id;
                                nuServsusc :=
                                    rfPolicy (nuNextPolicy).product_id;
                                Ld_BoSecureManagement.GetAddressBySusc (
                                    nuSuscripc,
                                    nuadd,
                                    nuGeo);

                                /*Se obtiene la informacion del cliente a raiz del suscriptor*/
                                nugesubs :=
                                    pkg_bccontrato.fnuidcliente (nuSuscripc);

                                -- Crea orden de facturacion
                                nuorderid := NULL;
                                nuorderactivityid := NULL;
								
								api_createorder(
												nuOrderPay,
												nuPackageId,
												nuMotiveId,
												NULL,
												NULL,
												nuadd,                 
												NULL,
												nugesubs, 
												nuSuscripc, 
												nuServsusc,
												NULL,
												NULL,
												NULL,
												'Orden de pago para la aseguradora',
												FALSE,
												NULL,
												NULL,
												NULL,
												NULL,
												NULL,
												NULL,
												0,
												NULL,
												TRUE,
												NULL,
												NULL,
												nuorderid,
												nuorderactivityid,
												nuErrorCode,
												sbErrorMessage
												);

                                api_assign_order (nuOrderId,
												  nuUnitOper,
												  nuErrorCode,   
												  sbErrorMessage);

                                IF nuUnitOper IS NULL
                                THEN
                                    -- SAO[334174]
                                    sbLinefile :=
                                           rfPolicy (nuNextPolicy).suscription_id
                                        || ';'
                                        || rfPolicy (nuNextPolicy).product_id
                                        || ';'
                                        || rfPolicy (nuNextPolicy).policy_number
                                        || ';'
                                        || DAld_policy.fnuGetCOLLECTIVE_NUMBER (
                                               rfPolicy (nuNextPolicy).policy_id)
                                        || ';'
                                        || nuPolicy
                                        || ';'
                                        || 'POLIZA'
                                        || ';'
                                        || 'no se pudo asignar la orden de pago ['
                                        || nuorderid
                                        || '] a la aseguradora';
                                   pkg_gestionArchivos.prcEscribirLinea_SMF (sbFileManagementf,
                                                           sbLinefile);

                                    sbLineLog :=
                                           '[Contrato:'
                                        || rfPolicy (nuNextPolicy).suscription_id
                                        || '- Producto:'
                                        || rfPolicy (nuNextPolicy).product_id
                                        || '- Poliza:'
                                        || rfPolicy (nuNextPolicy).policy_number
                                        || '- Colectivo:'
                                        || DAld_policy.fnuGetCOLLECTIVE_NUMBER (
                                               rfPolicy (nuNextPolicy).policy_id)
                                        || '- Poliza: '
                                        || nuPolicy
                                        || '] No se pudo asignar la orden de pago ['
                                        || nuorderid
                                        || '] a la aseguradora';

                                    vnunoexito := vnunoexito + 1;

                                    pkg_error.setErrorMessage(
                                        isbMsgErrr => 
                                        sbLineLog);
                                END IF;

                                /* Se legaliza la orden de pago con causal de exito*/
									
									sbdataorder := NULL;
									sbdataorder :=
										   nuOrderId
										|| '|'
										|| pkg_gestionordenes.cnucausalexito
										|| '|'
										|| LD_BOUtilFlow.fnuGetPersonToLegal(nuUnitOper)
										|| '||'
										|| nuorderactivityid
										|| '>'
										|| 1
										|| ';;;;|||1277;Legalizacion de la orden de cobro';

									api_legalizeorders (sbdataorder,
														SYSDATE,
														SYSDATE,
														SYSDATE,
														nuError,
														sbMessage
														);
									
									
									

                                IF (nuError <> 0)
                                THEN
                                    -- SAO[334174]
                                    sbLinefile :=
                                           rfPolicy (nuNextPolicy).suscription_id
                                        || ';'
                                        || rfPolicy (nuNextPolicy).product_id
                                        || ';'
                                        || rfPolicy (nuNextPolicy).policy_number
                                        || ';'
                                        || DAld_policy.fnuGetCOLLECTIVE_NUMBER (
                                               rfPolicy (nuNextPolicy).policy_id)
                                        || ';'
                                        || nuOrderId
                                        || ';'
                                        || 'ORDEN PAGO'
                                        || ';'
                                        || 'Error al tratar de legalizar la orden de pago con causal ['
                                        || pkg_gestionordenes.cnucausalexito
                                        || ']';
                                   pkg_gestionArchivos.prcEscribirLinea_SMF (sbFileManagementf,
                                                           sbLinefile);

                                    sbLineLog :=
                                           '[Contrato:'
                                        || rfPolicy (nuNextPolicy).suscription_id
                                        || '- Producto:'
                                        || rfPolicy (nuNextPolicy).product_id
                                        || '- Poliza:'
                                        || rfPolicy (nuNextPolicy).policy_number
                                        || '- Colectivo:'
                                        || DAld_policy.fnuGetCOLLECTIVE_NUMBER (
                                               rfPolicy (nuNextPolicy).policy_id)
                                        || '- Orden Pago: '
                                        || nuOrderId
                                        || '] Error al tratar de legalizar la orden de pago con causal ['
                                        || pkg_gestionordenes.cnucausalexito
                                        || ']';

                                    vnunoexito := vnunoexito + 1;

										pkg_error.setErrorMessage(nuError,sbMessage);
										RAISE pkg_error.controlled_error;

                                END IF;

                                -- actualizar valor de liquidacion de la actividad
                                nuordervalue := NULL;

                                    LD_BOSECUREMANAGEMENT.GETLIQUIDATIONSECUREVALUE (
                                        nuOrderId,
                                        nuordervalue);

                                daor_order_items.updvalue (
                                    daor_order_activity.fnugetorder_item_id (
                                        nuorderactivityid),
                                    nuordervalue);
                                daor_order.updorder_value (
                                    daor_order_activity.fnugetorder_id (
                                        nuorderactivityid),
                                    nuordervalue);

                                -- Crea orden de comision
                                nuorderid := NULL;
                                nuorderactivityid := NULL;

								api_createorder(
												nuOrderCharge,
												nuPackageId,
												nuMotiveId,
												NULL,
												NULL,
												nuadd, 
												NULL,
												nugesubs, 
												nuSuscripc, 
												nuServsusc, 
												NULL,
												NULL,
												NULL,
												'Orden de cobro a la aseguradora',
												NULL,
												NULL,
												NULL,
												NULL,
												NULL,
												NULL,
												NULL,
												NULL,
												NULL,
												NULL,
												NULL,
												NULL,
												nuorderid,
												nuorderactivityid,
												nuErrorCode,
												sbErrorMessage);

                                api_assign_order (nuOrderId,
												  nuUnitOper,
												  nuErrorCode,   
												  sbErrorMessage);

                                IF nuUnitOper IS NULL
                                THEN
                                    -- SAO[334174]
                                    sbLinefile :=
                                           rfPolicy (nuNextPolicy).suscription_id
                                        || ';'
                                        || rfPolicy (nuNextPolicy).product_id
                                        || ';'
                                        || rfPolicy (nuNextPolicy).policy_number
                                        || ';'
                                        || DAld_policy.fnuGetCOLLECTIVE_NUMBER (
                                               rfPolicy (nuNextPolicy).policy_id)
                                        || ';'
                                        || nuPolicy
                                        || ';'
                                        || 'POLIZA'
                                        || ';'
                                        || 'no se pudo asignar la orden de comision ['
                                        || nuorderid
                                        || '] a la aseguradora';
                                   pkg_gestionArchivos.prcEscribirLinea_SMF (sbFileManagementf,
                                                           sbLinefile);

                                    sbLineLog :=
                                           '[Contrato:'
                                        || rfPolicy (nuNextPolicy).suscription_id
                                        || '- Producto:'
                                        || rfPolicy (nuNextPolicy).product_id
                                        || '- Poliza:'
                                        || rfPolicy (nuNextPolicy).policy_number
                                        || '- Colectivo:'
                                        || DAld_policy.fnuGetCOLLECTIVE_NUMBER (
                                               rfPolicy (nuNextPolicy).policy_id)
                                        || '- Poliza: '
                                        || nuPolicy
                                        || '] No se pudo asignar la orden de comision ['
                                        || nuorderid
                                        || '] a la aseguradora';

                                    vnunoexito := vnunoexito + 1;

                                    pkg_error.setErrorMessage(
                                        isbMsgErrr => 
                                        sbLineLog);
                                ELSE
                                    /* Se legaliza la orden de pago con causal de exito*/
										
									sbdataorder := NULL;
									sbdataorder :=
										   nuOrderId
										|| '|'
										|| pkg_gestionordenes.cnucausalexito
										|| '|'
										|| LD_BOUtilFlow.fnuGetPersonToLegal(nuUnitOper)
										|| '||'
										|| nuorderactivityid
										|| '>'
										|| 1
										|| ';;;;|||1277;Legalizacion de la orden de cobro';

									api_legalizeorders (sbdataorder,
														SYSDATE,
														SYSDATE,
														SYSDATE,
														nuError,
														sbMessage
														);
	

                                    IF (nuError <> 0)
                                    THEN
                                        -- SAO[334174]
                                        sbLinefile :=
                                               rfPolicy (nuNextPolicy).suscription_id
                                            || ';'
                                            || rfPolicy (nuNextPolicy).product_id
                                            || ';'
                                            || rfPolicy (nuNextPolicy).policy_number
                                            || ';'
                                            || DAld_policy.fnuGetCOLLECTIVE_NUMBER (
                                                   rfPolicy (nuNextPolicy).policy_id)
                                            || ';'
                                            || nuOrderId
                                            || ';'
                                            || 'ORDEN COMISION'
                                            || ';'
                                            || 'Error al tratar de legalizar la orden de comision con causal ['
                                            || pkg_gestionordenes.cnucausalexito
                                            || ']';
                                       pkg_gestionArchivos.prcEscribirLinea_SMF (
                                            sbFileManagementf,
                                            sbLinefile);

                                        sbLineLog :=
                                               '[Contrato:'
                                            || rfPolicy (nuNextPolicy).suscription_id
                                            || '- Producto:'
                                            || rfPolicy (nuNextPolicy).product_id
                                            || '- Poliza:'
                                            || rfPolicy (nuNextPolicy).policy_number
                                            || '- Colectivo:'
                                            || DAld_policy.fnuGetCOLLECTIVE_NUMBER (
                                                   rfPolicy (nuNextPolicy).policy_id)
                                            || '- Orden Comision: '
                                            || nuPolicy
                                            || '] Error al tratar de legalizar la orden de comision con causal ['
                                            || pkg_gestionordenes.cnucausalexito
                                            || ']';

                                        vnunoexito := vnunoexito + 1;

										pkg_error.setErrorMessage(nuError,sbMessage);
										RAISE pkg_error.controlled_error;
										
                                    END IF;

                                    -- se actualiza valor de la liquidacion
                                    nuordervalue := NULL;


                                        LD_BOSECUREMANAGEMENT.GETLIQUIDATIONSECUREVALUE (
                                            nuOrderId,
                                            nuordervalue);

                                    daor_order_items.updvalue (
                                        daor_order_activity.fnugetorder_item_id (
                                            nuorderactivityid),
                                        nuordervalue);
                                    daor_order.updorder_value (
                                        daor_order_activity.fnugetorder_id (
                                            nuorderactivityid),
                                        nuordervalue);
                                END IF;
                            ELSE
                                -- SAO[334174]
                                sbLinefile :=
                                       rfPolicy (nuNextPolicy).suscription_id
                                    || ';'
                                    || rfPolicy (nuNextPolicy).product_id
                                    || ';'
                                    || rfPolicy (nuNextPolicy).policy_number
                                    || ';'
                                    || DAld_policy.fnuGetCOLLECTIVE_NUMBER (
                                           rfPolicy (nuNextPolicy).policy_id)
                                    || ';'
                                    || rfPolicy (nuNextPolicy).policy_type_id
                                    || ';'
                                    || 'TIPO POLIZA'
                                    || ';'
                                    || 'El tipo de poliza no se encuentra vigente para el numero de poliza';
                               pkg_gestionArchivos.prcEscribirLinea_SMF (sbFileManagementf,
                                                       sbLinefile);

                                sbLineLog :=
                                       '[Contrato:'
                                    || rfPolicy (nuNextPolicy).suscription_id
                                    || '- Producto:'
                                    || rfPolicy (nuNextPolicy).product_id
                                    || '- Poliza:'
                                    || rfPolicy (nuNextPolicy).policy_number
                                    || '- Colectivo:'
                                    || DAld_policy.fnuGetCOLLECTIVE_NUMBER (
                                           rfPolicy (nuNextPolicy).policy_id)
                                    || '- Tipo Poliza: '
                                    || nuPolicy
                                    || '] El tipo de poliza no se encuentra vigente para el numero de poliza';

                                vnunoexito := vnunoexito + 1;

                                pkg_error.setErrorMessage(
                                    isbMsgErrr => 
                                    sbLineLog);
                            END IF;
                        ELSE
                            -- SAO[334174]
							
							IF cuSolicitud%ISOPEN THEN
								CLOSE cuSolicitud;
							END IF;
							
							OPEN cuSolicitud(rfPolicy (nuNextPolicy).policy_id);
							FETCH cuSolicitud INTO nuPackage;
							IF cuSolicitud%NOTFOUND then
								CLOSE cuSolicitud;
								RAISE pkg_error.controlled_error;
							END IF;
							CLOSE cuSolicitud;
							

                            sbLinefile :=
                                   rfPolicy (nuNextPolicy).suscription_id
                                || ';'
                                || rfPolicy (nuNextPolicy).product_id
                                || ';'
                                || rfPolicy (nuNextPolicy).policy_number
                                || ';'
                                || DAld_policy.fnuGetCOLLECTIVE_NUMBER (
                                       rfPolicy (nuNextPolicy).policy_id)
                                || ';'
                                || nuPackage
                                || ';'
                                || 'SOLICITUD'
                                || ';'
                                || 'La poliza tiene registrada una solicitud de no renovacion';
                           pkg_gestionArchivos.prcEscribirLinea_SMF (sbFileManagementf,
                                                   sbLinefile);

                            sbLineLog :=
                                   '[Contrato:'
                                || rfPolicy (nuNextPolicy).suscription_id
                                || '- Producto:'
                                || rfPolicy (nuNextPolicy).product_id
                                || '- Poliza:'
                                || rfPolicy (nuNextPolicy).policy_number
                                || '- Colectivo:'
                                || DAld_policy.fnuGetCOLLECTIVE_NUMBER (
                                       rfPolicy (nuNextPolicy).policy_id)
                                || '- Solicitud: '
                                || nuPackage
                                || '] La poliza tiene registrada una solicitud de no renovacion';

                            /* Si la poliza tiene registrada una solicitud de no renovacion y su vigencia ya se encuentra vencida,
                               se registra una cancelacion */

                            /*obtiene saldo pendiente de las cuentas de cobro*/
                            OPEN ld_bcsecuremanagement.cuPendBalance (
                                rfPolicy (nuNextPolicy).product_id);

                            FETCH ld_bcsecuremanagement.cuPendBalance
                                INTO nuCurrentBalance;

                            /*valida si la poliza tiene diferidos con saldo pendiente*/
                            blHasDefBalance :=
                                LD_BCSecureManagement.fblHasDefDebt (
                                    rfPolicy (nuNextPolicy).product_id);

                            IF NOT blHasDefBalance AND nuCurrentBalance = 0
                            THEN
                                sbCanBySin :=
                                    pkg_BCLD_Parameter.fsbObtieneValorCadena (
                                        LD_BOConstans.csbCanBySin);
                                sbCanCausal :=
                                    pkg_BCLD_Parameter.fsbObtieneValorCadena (
                                        ld_boconstans.csbCausCancBySubs);

                                sbRequestXML := pkg_xml_sol_seguros.getSolicitudCancelaSeguros(
																								pkg_bopersonal.fnugetpersonaid(),
																								nurecptype,
																								'CANCELADA POR SOLICITUD DE NO RENOVACION',
																								TRUNC (SYSDATE),
																								NULL,
																								nuContactId,
																								rfPolicy (nuNextPolicy).suscription_id,
																								rfPolicy (nuNextPolicy).policy_id,
																								NULL,
																								sbCanCausal,
																								'OBSERVACIONES_DE_LA_POLIZA>CANCELADA POR SOLICITUD DE NO RENOVACION',
																								sbCanBySin
																								);
								

                                api_registerrequestbyxml (sbRequestXML,
                                                           nuPackageId,
                                                           nuMotiveId,
                                                           nuErrorCode,
                                                           sbErrorMessage);
                            ELSE
                                IF nuCurrentBalance > 0
                                THEN
                                    OPEN ld_bcsecuremanagement.cuLastPayAccountDate (
                                        rfPolicy (nuNextPolicy).product_id);

                                    FETCH ld_bcsecuremanagement.cuLastPayAccountDate
                                        INTO dtPayLastAccount;

                                    CLOSE ld_bcsecuremanagement.cuLastPayAccountDate;

                                    IF ((SYSDATE - dtPayLastAccount) / 30 >
                                        ld_boconstans.cnuCodPerDefeated)
                                    THEN
                                        sbCanBySin :=
                                            pkg_BCLD_Parameter.fsbObtieneValorCadena (
                                                LD_BOConstans.csbCanBySin);
                                        sbCanCausal :=
                                            pkg_BCLD_Parameter.fsbObtieneValorCadena (
                                                ld_boconstans.csbCausCancBySubs);

                                        sbRequestXML := pkg_xml_sol_seguros.getSolicitudCancelaSeguros(
																										pkg_bopersonal.fnugetpersonaid(),
																										nurecptype,
																										'CANCELADA POR SOLICITUD DE NO RENOVACION',
																										TRUNC (SYSDATE),
																										NULL,
																										nuContactId,
																										rfPolicy (nuNextPolicy).suscription_id,
																										rfPolicy (nuNextPolicy).policy_id,
																										NULL,
																										sbCanCausal,
																										'CANCELADA POR SOLICITUD DE NO RENOVACION',
																										sbCanBySin
																										);
																								


                                        api_registerrequestbyxml (
																	sbRequestXML,
																	nuPackageId,
																	nuMotiveId,
																	nuErrorCode,
																	sbErrorMessage
																  );
                                    END IF;
                                END IF;
                            END IF;
                        END IF;


                       pkg_gestionArchivos.prcEscribirLinea_SMF (sbFileManagement, sbLineLog);

                        nuContador := nuContador + 1;

                        IF nuChangePolTyp = cnuZERO
                        THEN
                            -- SAO[334174]
                            sbLinefile :=
                                   rfPolicy (nuNextPolicy).suscription_id
                                || ';'
                                || rfPolicy (nuNextPolicy).product_id
                                || ';'
                                || rfPolicy (nuNextPolicy).policy_number
                                || ';'
                                || DAld_policy.fnuGetCOLLECTIVE_NUMBER (
                                       rfPolicy (nuNextPolicy).policy_id)
                                || ';'
                                || nuPolicy
                                || ';'
                                || 'POLIZA RENOVADA'
                                || ';'
                                || 'Nueva poliza creada para el asegurado ['
                                || rfPolicy (nuNextPolicy).name_insured
                                || ']. El proceso ha terminado con exito.';
                           pkg_gestionArchivos.prcEscribirLinea_SMF (sbFileManagementf,
                                                   sbLinefile);

                            sbLineLog :=
                                   '[Contrato:'
                                || rfPolicy (nuNextPolicy).suscription_id
                                || '- Producto:'
                                || rfPolicy (nuNextPolicy).product_id
                                || '- Poliza:'
                                || rfPolicy (nuNextPolicy).policy_number
                                || '- Colectivo:'
                                || DAld_policy.fnuGetCOLLECTIVE_NUMBER (
                                       rfPolicy (nuNextPolicy).policy_id)
                                || '- Poliza Renovada: '
                                || nuPolicy
                                || '] Nueva poliza creada para el asegurado ['
                                || rfPolicy (nuNextPolicy).name_insured
                                || ']. El proceso ha terminado con exito.';

                            tbPoliza (nuContador).sbLinea := sbLineLog;
                            vnuexito := vnuexito + 1;
                        ELSE
                            -- SAO[334174]
                            sbLinefile :=
                                   rfPolicy (nuNextPolicy).suscription_id
                                || ';'
                                || rfPolicy (nuNextPolicy).product_id
                                || ';'
                                || rfPolicy (nuNextPolicy).policy_number
                                || ';'
                                || DAld_policy.fnuGetCOLLECTIVE_NUMBER (
                                       rfPolicy (nuNextPolicy).policy_id)
                                || ';'
                                || nuPolicy
                                || ';'
                                || 'POLIZA RENOVADA'
                                || ';'
                                || 'La poliza creada con diferente tipo de poliza por cambio de categoria. El proceso ha terminado con exito.';
                           pkg_gestionArchivos.prcEscribirLinea_SMF (sbFileManagementf,
                                                   sbLinefile);

                            sbLineLog :=
                                   '[Contrato:'
                                || rfPolicy (nuNextPolicy).suscription_id
                                || '- Producto:'
                                || rfPolicy (nuNextPolicy).product_id
                                || '- Poliza:'
                                || rfPolicy (nuNextPolicy).policy_number
                                || '- Colectivo:'
                                || DAld_policy.fnuGetCOLLECTIVE_NUMBER (
                                       rfPolicy (nuNextPolicy).policy_id)
                                || '- Poliza Renovada: '
                                || nuPolicy
                                || '] La poliza creada con diferente tipo de poliza por cambio de categoria. El proceso ha terminado con exito.';

                            tbPoliza (nuContador).sbLinea := sbLineLog;
                            vnuexito := vnuexito + 1;
                        END IF;

                        IF MOD (nuContador, nuCantCommit) = 0
                        THEN
                            IF tbPoliza.COUNT > 0
                            THEN
                                nuIndex := tbPoliza.FIRST;
                                COMMIT;

                                LOOP
                                   pkg_gestionArchivos.prcEscribirLinea_SMF (
                                        sbFileManagement,
                                        tbPoliza (nuIndex).sbLinea);
                                    EXIT WHEN nuIndex = tbPoliza.LAST ();
                                    nuIndex := tbPoliza.NEXT (nuIndex);
                                END LOOP;
                            END IF;

                            tbPoliza.delete;
                        END IF;
                    EXCEPTION
                        WHEN pkg_error.controlled_error
                        THEN
                            pkg_error.geterror (nuError, sbMessage);

                            IF sbLineLog IS NULL
                            THEN
                                sbLineLog :=
                                       '     Error ... procesando la poliza '
                                    || nuPolicy
                                    || ', Ruta: '
                                    || sbPath
                                    || ' '
                                    || sbLog
                                    || ' '
                                    || sbmessage;
                            END IF;

                           pkg_gestionArchivos.prcEscribirLinea_SMF (sbFileManagement,
                                                   sbLineLog);
                            ROLLBACK TO TEMPPOLICY;
                        WHEN OTHERS
                        THEN
                            pkg_error.setError;
                            pkg_error.geterror (nuError, sbMessage);

                            IF sbLineLog IS NULL
                            THEN
                                sbLineLog :=
                                       '     Error ... procesando la poliza '
                                    || nuPolicy
                                    || ', Ruta: '
                                    || sbPath
                                    || ' '
                                    || sbLog
                                    || ' '
                                    || sbmessage;
                            END IF;

                           pkg_gestionArchivos.prcEscribirLinea_SMF (sbFileManagement,
                                                   sbLineLog);
                            ROLLBACK TO TEMPPOLICY;
                    END;



                    nuNextPolicy := rfPolicy.NEXT (nuNextPolicy);
                    COMMIT;
                END LOOP;

                EXIT WHEN rfCursorPolicy%NOTFOUND;
            END LOOP;

            CLOSE rfCursorPolicy;
        ELSE
            sbLineLog :=
                   '     Error ... Los parametros que se utilizan se encuentran en blanco'
                || sbPath;
           pkg_gestionArchivos.prcEscribirLinea_SMF (sbFileManagement, sbLineLog);
        END IF;
    END IF;

    -- SAO[334174]
    sbLinefile := 'Polizas Procesadas' || ';' || (vnuexito + vnunoexito);
   pkg_gestionArchivos.prcEscribirLinea_SMF (sbFileManagementf, sbLinefile);
    sbLinefile := 'Polizas Renovadas' || ';' || vnuexito;
   pkg_gestionArchivos.prcEscribirLinea_SMF (sbFileManagementf, sbLinefile);
    sbLinefile := 'Polizas No Renovadas' || ';' || vnunoexito;
   pkg_gestionArchivos.prcEscribirLinea_SMF (sbFileManagementf, sbLinefile);

   pkg_gestionArchivos.prcCerrarArchivo_SMF (sbFileManagement, NULL, NULL);
   pkg_gestionArchivos.prcCerrarArchivo_SMF (sbFileManagementf, NULL, NULL);                    -- SAO[334174]

    COMMIT;
    release_lock;

        --identifica parametro de correo de recibe notificacion de renovacion de seguro
        sbDestinatarios :=
            pkg_BCLD_Parameter.fsbObtieneValorCadena ('EMAIL_RENO_RENSEGU');

        -- Inicia Agordillo SAO.334174
        sbAsunto :=
               'Finalizacion de proceso de RENOVACION, mes '
            || nuMonth
            || '-'
            || UPPER (nuMonth);
			
			sbInstanciaBD := ldc_boconsgenerales.fsbgetdatabasedesc();

			if (length(sbInstanciaBD) > 0) then
			  sbInstanciaBD := 'BD '||sbInstanciaBD||': ';
			end if;
			sbAsunto := sbInstanciaBD ||sbAsunto;

        sbMensaje :=
               'Notificacion de finalizacion de proceso de RENOVACION (o CANCELACION) para la linea, mes '
            || nuMonth
            || '-'
            || UPPER (nuMonth)
            || '.'
            || '<br><br>'
            || ' Cantidad de polizas Renovadas (o canceladas) con exito: '
            || vnuexito
            || '<br><br>'
            || 'Cantidad de polizas No Renovadas (o No Canceladas): '
            || vnunoexito
            || '<br><br>'
            || 'Para mayor detalle, dirijase al log generado en la ruta '
            || sbPath;

        BEGIN

            pkg_Correo.prcEnviaCorreo
            (
                isbDestinatarios    => sbDestinatarios,
                isbAsunto           => sbAsunto,
                isbMensaje          => sbMensaje,
                isbArchivos         => sbPath || '/' || sbFile
            );        
        
        EXCEPTION
            WHEN pkg_error.controlled_error
            THEN
                pkg_error.setError;
            WHEN OTHERS
            THEN
                pkg_error.setError;
        END;
		
    -- Fin Agordillo SAO.334174
	
	pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
	
	
EXCEPTION
    WHEN pkg_error.controlled_error
    THEN
        ROLLBACK;
		pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
        release_lock;
        RAISE pkg_error.controlled_error;
    WHEN OTHERS
    THEN
        ROLLBACK;
		pkg_traza.trace(csbMT_NAME,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
        release_lock;
        pkg_error.setError;
        RAISE pkg_error.controlled_error;
END ProcRenew;
/
