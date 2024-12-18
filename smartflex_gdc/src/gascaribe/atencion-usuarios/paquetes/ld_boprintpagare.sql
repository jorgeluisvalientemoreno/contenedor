CREATE OR REPLACE PACKAGE ld_boprintpagare

IS

    /*****************************************************************

    Propiedad intelectual de Arquitecsoft SAS



    Package	: ld_boprintpagare

    Descripción	: Servicios para la impresión del pagare de pago brilla



    Autor	: Miguel M Moreno

    Fecha	: 28-11-2016



    Historia de Modificaciones



    DD-MM-YYYY  <Autor>.SAONNNNN        Modificación

    ----------- -------------------     -------------------------------------

    28-11-2013  miguelm                 Creación CDC 200-651

    ******************************************************************/



    --------------------------------------------

    -- Constantes GLOBALES Y PUBLICAS DEL PAQUETE

    --------------------------------------------

    --------------------------------------------

    -- Variables GLOBALES Y PUBLICAS DEL PAQUETE

    --------------------------------------------

    --------------------------------------------

    -- Funciones y Procedimientos PUBLICAS DEL PAQUETE

    --------------------------------------------

    FUNCTION fsbVersion

    RETURN varchar2;



    PROCEDURE InstanceInfoLDIPA;



    PROCEDURE PrintPagare(inuPagare pagare.pagacodi%type,inuFormato ed_formato.formcodi%type);



    FUNCTION fsbGetCheckDigit

    (

        inuCoupon   in  cupon.cuponume%type

    )

    return varchar2;



    PROCEDURE Procesar;



END ld_boprintpagare;
/
CREATE OR REPLACE PACKAGE BODY ld_boprintpagare

IS

        /*****************************************************************

    Propiedad intelectual de Arquitecsoft SAS



    Package	: ld_boprintpagare

    Descripción	: Servicios para la impresión del pagare de pago brilla



    Autor	: Miguel M Moreno

    Fecha	: 28-11-2016



    Historia de Modificaciones



    DD-MM-YYYY  <Autor>.SAONNNNN        Modificación

    ----------- -------------------     -------------------------------------

    28-11-2013  miguelm                 Creación CDC 200-651

    ******************************************************************/





    --------------------------------------------

    -- Constantes VERSION DEL PAQUETE

    --------------------------------------------

    csbVERSION                  constant varchar2(100) := 'SAOXXXXX';

    CNUNIVELTRAZA CONSTANT NUMBER := 1;

    CSBLDIPA_APP_NAME CONSTANT VARCHAR2( 10 ) := 'LDIPA';
    GNUNUMECUPONES CUPON.CUPONUME%TYPE := 1;
	GNUNUMEACTU    CUPON.CUPONUME%TYPE := 0;
	GNUNUMFINAL    CUPON.CUPONUME%TYPE :=0;

    --------------------------------------------

    -- Constantes PRIVADAS DEL PAQUETE

    --------------------------------------------

    --------------------------------------------

    -- Variables PRIVADAS DEL PAQUETE

    --------------------------------------------



    --------------------------------------------

    -- Funciones y Procedimientos privadas del paquete

    --------------------------------------------

    --------------------------------------------

    -- Funciones y Procedimientos públicos del paquete

    --------------------------------------------



    /**************************************************************

    Propiedad intelectual de Open International Systems (c).

    Unidad      :  fsbVersion

    Descripcion :  Devuelve la versión del paquete



    Autor       :  Luis E. Fernández

    Fecha       :  03-07-2013

    Parametros  :



    Historia de Modificaciones

    Fecha       Autor               Modificación

    =========   =========           ====================

    03-07-2013  lfernandez.SAOxxxxx Creación

    ***************************************************************/

    FUNCTION fsbVersion

    RETURN VARCHAR2 IS

    BEGIN

        return csbVERSION;

    END fsbVersion;



    /**************************************************************

    Propiedad intelectual de Open International Systems (c).

    Unidad      :  InstanceInfoLDIPA

    Descripcion :  Instancia los datos para la forma LDIPA a partir de la

                   solicitud



    Autor       :  Miguel M Moreno

    Fecha       :  28-11-2016

    Parametros  :



    Historia de Modificaciones

    Fecha       Autor               Modificación

    =========   =========           ====================

    03-07-2013  lfernandez.SAOxxxxx Creación

    ***************************************************************/

    PROCEDURE InstanceInfoLDIPA

    IS

        ------------------------------------------------------------------------

        --  Variables

        ------------------------------------------------------------------------

        sbCurrInstance  GE_BOInstanceControl.stysbValue;

        sbPackageId     GE_BOInstanceControl.stysbValue;

        nuCouponNumber  cupon.cuponume%type;

        nuCouponValue   cupon.cupovalo%type;

        nuBill          mo_motive_payment.account%type;

        dtLimitDate     mo_motive_payment.limit_date%type;

        ------------------------------------------------------------------------

        --  Cursores

        ------------------------------------------------------------------------

        CURSOR cuInfoByPack( inuPackage mo_package_payment.package_id%type )

        IS  SELECT  /*+ leading( pp )

                        index( pp IDX_MO_PACKAGE_PAYMENT )

                        index( mp IDX_MO_MOTIVE_PAYMENT_05 ) */

                    mp.coupon_id, mp.total_value, mp.account

            FROM    mo_package_payment pp, mo_motive_payment mp

            WHERE   pp.package_id = inuPackage

            AND     pp.active = GE_BOConstants.csbYES

            AND     pp.package_payment_id = pp.package_payment_id

            AND     mp.active = GE_BOConstants.csbYES

            AND     mp.account is not null

            AND     coupon_id IS not null

            ORDER BY mp.limit_date desc;

    BEGIN



        UT_Trace.Trace( 'LD_BOPrintCoupon.InstanceInfoLDIPA', 15 );



        -- Se obtiene la instancia actual

        GE_BOInstanceControl.GetCurrentInstance( sbCurrInstance );



        --  Obtiene la solicitud instanciada por el PI

        GE_BOInstanceControl.GetAttributeNewValue(

                                        GE_BOInstanceConstants.csbWORK_INSTANCE,

                                        null,

                                        'MO_PACKAGES',

                                        'PACKAGE_ID',

                                        sbPackageId );



        --  Obtiene el cupón a partir de la solicitud

        open  cuInfoByPack( to_number( sbPackageId ) );

        fetch cuInfoByPack INTO nuCouponNumber, nuCouponValue, nuBill;

        close cuInfoByPack;



        --  Si no encontró cupón

        if ( nuCouponNumber IS null ) then



            GE_BOErrors.SetErrorCodeArgument(

                            2741,

                            'La solicitud no tiene un cupón de pago asociado' );

        end if;



        -- Obtiene la fecha de vencimiento de la factura

        dtLimitDate := CC_BOBssUtil.fdtGetBillAccountExpiration( nuBill );



        --  Establece la solicitud en la forma

        GE_BOInstanceControl.SetAttributeNewValue( sbCurrInstance,

                                                   null,

                                                   'MO_PACKAGES',

                                                   'PACKAGE_ID',

                                                   sbPackageId );



        --  Establece en los campos el código del cupón, el valor y la factura

        GE_BOInstanceControl.SetAttributeNewValue( sbCurrInstance,

                                                   null,

                                                   'CUPON',

                                                   'CUPONUME',

                                                   to_char( nuCouponNumber ) );



        GE_BOInstanceControl.SetAttributeNewValue( sbCurrInstance,

                                                   null,

                                                   'CUPON',

                                                   'CUPOVALO',

                                                   to_char( nuCouponValue ) );



        GE_BOInstanceControl.SetAttributeNewValue( sbCurrInstance,

                                                   null,

                                                   'FACTURA',

                                                   'FACTCODI',

                                                   to_char( nuBill ) );



        --  Establece la fecha de vencimiento

        GE_BOInstanceControl.SetAttributeNewValue(

                                        sbCurrInstance,

                                        null,

                                        'CUPON',

                                        'CUPOFECH',

                                        to_char( dtLimitDate, 'DD-MM-YYYY' ) );



        UT_Trace.Trace( 'Fin LD_BOPrintCoupon.InstanceInfoLDIPA', 15 );



    EXCEPTION

        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then

            raise;

        when OTHERS then

            Errors.SetError;

            raise ex.CONTROLLED_ERROR;

    END InstanceInfoLDIPA;



    /**************************************************************

    Propiedad intelectual de arquitecsoft

    Unidad      :  PrintPagare

    Descripcion :  Realiza la impresión del pagare con cupón de pago



    Autor       :  Miguel M Moreno

    Fecha       :  28-11-2016

    Parametros  :



    Historia de Modificaciones

    Fecha       Autor               Modificación

    =========   =========           ====================

    28-11-2016  miguelm             Creación CDC 200-651

    ***************************************************************/

    PROCEDURE PrintPagare (inuPagare pagare.pagacodi%type,inuFormato ed_formato.formcodi%type)

    IS

        ------------------------------------------------------------------------

        --  Constantes

        ------------------------------------------------------------------------

        csbEXT_MIX_CONF constant varchar2(100) := 'COUPON_EXT_MIX_CONF';

        ------------------------------------------------------------------------

        --  Variables

        ------------------------------------------------------------------------

        clData          clob;

        rcAccount       cuencobr%rowtype;

        rcExtMixConf    ed_confexme%rowtype;

        nuFormat        ed_formato.formcodi%type;

        nuExtMixConf    ed_confexme.coemcodi%type;

        sbBill          GE_BOInstanceControl.stysbValue;

        sbPagareId      GE_BOInstanceControl.stysbValue;

        sbCouponNumber  GE_BOInstanceControl.stysbValue;



        CURSOR cuExtraccion (par1 ed_formato.formcodi%TYPE)

        IS

          SELECT COEMCODI

          FROM   ED_CONFEXME WHERE COEMPADA LIKE '<'||par1||'>';





    BEGIN



        UT_Trace.Trace( 'LD_BOPrintCoupon.PrintCoupon', 15 );



        /*

        --  Obtiene la solicitud instanciada

        sbPagareId := GE_BOInstanceControl.fsbGetFieldValue( 'PAGARE',

                                                             'PAGACODI' );



        --  Obtiene el cupón instanciado

        sbCouponNumber := GE_BOInstanceControl.fsbGetFieldValue( 'CUPON',

                                                                 'CUPONUME' );



        --  Obtiene la factura instanciada

        sbBill := GE_BOInstanceControl.fsbGetFieldValue( 'FACTURA', 'FACTCODI' );



        --  Obtiene la cuenta de cobro de la factura

        rcAccount := pkBCCuenCobr.frcFirstAccFact( to_number( sbBill ) );

      */



        --nuExtMixConf := DALD_Parameter.fnuGetNumeric_Value( csbEXT_MIX_CONF );



        --  Obtiene la información

        rcExtMixConf  :=  pkTblED_Confexme.frcGetRecord( inuFormato );



        --  Obtiene el formato

        nuFormat := pkBCED_Formato.fnuGetFormcodibyIden( rcExtMixConf.coempada );

        --nuFormat := inuFormato;



        --  Instancia el registro de ls solicitud

        --pkBODataExtractor.InstanceBaseEntity( sbPackageId, 'MO_PACKAGES', true );



        -- Instancia el registro del pagare

        pkBODataExtractor.InstanceBaseEntity( inuPagare, 'PAGARE', false );

        --  Instancia el registro del cupón

        --pkBODataExtractor.InstanceBaseEntity( sbCouponNumber, 'CUPON', false );



        --  Instancia el registro de la factura

        --pkBODataExtractor.InstanceBaseEntity( sbBill, 'FACTURA', false );



        --  Instancia el registro de la cuenta de cobro

        --pkBODataExtractor.InstanceBaseEntity( rcAccount.cucocodi, 'CUENCOBR', false );



        --  Genera la información

        pkBODataExtractor.ExecuteRules( nuFormat, clData );



        UT_Trace.Trace( '***Datos generados:***-->', 3 );

        UT_Trace.Trace( dbms_lob.substr( clData, 300, 1 ), 1 );

        UT_Trace.Trace( dbms_lob.substr( clData, 300, 301 ), 1 );

        UT_Trace.Trace( dbms_lob.substr( clData, 300, 601 ), 1 );

        UT_Trace.Trace( dbms_lob.substr( clData, 300, 901 ), 1 );

        UT_Trace.Trace( '<--***Datos generados:***', 3 );



        -- almacena en memoria para el proceso de extraccion

        --pkBOED_DocumentMem.Set_PrintDocId( to_number( sbBill ) );

        pkBOED_DocumentMem.Set_PrintDocId( inuPagare );



        -- Almancena en memoria el archivo para el proceso de extraccion y mezcla

        pkBOED_DocumentMem.Set_PrintDoc( clData );



        -- Almancena en memoria la plantilla para extraccion y mezcla

        pkBOED_DocumentMem.SetTemplate( rcExtMixConf.coempadi );



        --  Proceso .NET de impresión de duplicado

        GE_BOIOpenExecutable.PrintPreviewerRule;



        UT_Trace.Trace( 'Fin LD_BOPrintCoupon.PrintPagare', 15 );



    EXCEPTION

        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then

            raise;

        when OTHERS then

            Errors.SetError;

            raise ex.CONTROLLED_ERROR;

    END PrintPagare;



    /**************************************************************

    Propiedad intelectual de Open International Systems (c).

    Unidad      :  fsbGetCheckDigit

    Descripcion :  Devuelve el dígito de chequeo para el código del cupón



    Autor       :  Luis E. Fernández

    Fecha       :  04-07-2013

    Parametros  :



        inuCoupon   Código del cupón



    Historia de Modificaciones

    Fecha       Autor               Modificación

    =========   =========           ====================

    04-07-2013  lfernandez.SAOxxxxx Creación

    ***************************************************************/

    FUNCTION fsbGetCheckDigit

    (

        inuCoupon   in  cupon.cuponume%type

    )

    return varchar2

    IS

        ------------------------------------------------------------------------

        --  Variables

        ------------------------------------------------------------------------

        sbCheckDigit    varchar2(10);

    BEGIN



        --  Si no se envía cupón devuelve nulo para no generar error

        if ( inuCoupon IS null ) then

            return null;

        end if;



        --  Calcula el dígito de chequeo del cupón

        pkBP_PrintMgr.GetCheckDigit( inuCoupon, sbCheckDigit );



        return sbCheckDigit;



    EXCEPTION

        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then

            raise;

        when OTHERS then

            Errors.SetError;

            raise ex.CONTROLLED_ERROR;

    END fsbGetCheckDigit;

    /*******************************************************************************
    Propiedad intelectual de GDC
    Procedimiento 	: FNUGETNEGOTIATIONVALUE
    Descripcion	: Obtiene el valor de la negociacion  LDC_PKCOUPONMGR.FNUGETNEGOTIATIONVALUE

    Autor: Edison Eduardo Ceron

    Parametros:
        Entrada:
            inuPagare       Identificador del pagare

    Historial de modificaciones:
    Fecha           Autor           Modificacion
    26-02-2019      Eduardo Ceron   200-2152. Creacion
    *******************************************************************************/
    FUNCTION FNUGETNEGOTIATIONVALUE
    (
        INUDEBTNEGOTIATIONID IN GC_DEBT_NEGOTIATION.DEBT_NEGOTIATION_ID%TYPE
    )
    RETURN NUMBER
    IS
        nuSuscriptionId   number;

        cursor cuGetSuscription
        is
            SELECT  serv.sesususc
            FROM    gc_debt_negot_prod neg, servsusc serv     --gc_debt_negotiation
            WHERE   serv.sesunuse = neg.sesunuse
            AND     neg.debt_negotiation_id = INUDEBTNEGOTIATIONID;

        cursor cuGetNegotiationsValue
        is
            SELECT  sum(neg.value_to_pay)
            FROM    gc_debt_negot_prod neg, servsusc serv, gc_debt_negotiation gcneg,
                    mo_packages pkg
            WHERE   serv.sesunuse = neg.sesunuse
            AND     serv.sesususc = nuSuscriptionId
            --AND     neg.debt_negotiation_id <> INUDEBTNEGOTIATIONID
            AND     neg.debt_negotiation_id = gcneg.debt_negotiation_id
            AND     gcneg.package_id = pkg.package_id
            AND     pkg.motive_status_id not in (14,32,51); -- cerradas, analudas y canceladas

        CURSOR CUNEGOTIATIONVALUE IS
        SELECT /*+ index(gc_debt_negot_prod IDX_GC_DEBT_NEGOT_PROD01) */
                   sum(value_to_pay)
            FROM   gc_debt_negot_prod
            WHERE  debt_negotiation_id = inuDebtNegotiationId;

        NUVALUETOPAY GC_DEBT_NEGOT_PROD.VALUE_TO_PAY%TYPE;

    BEGIN

        UT_TRACE.TRACE( 'INICIO: GC_BCDebtNegoProduct.fnuGetNegotiationValue(' || INUDEBTNEGOTIATIONID || ')', 5 );
        IF ( CUNEGOTIATIONVALUE%ISOPEN ) THEN
            CLOSE CUNEGOTIATIONVALUE;
        END IF;

        open  cuGetSuscription;
        fetch cuGetSuscription into nuSuscriptionId;
        close cuGetSuscription;

        open  cuGetNegotiationsValue;
        fetch cuGetNegotiationsValue into NUVALUETOPAY;
        close cuGetNegotiationsValue;

        UT_TRACE.TRACE( 'Valor total de la negociacion: ' || NUVALUETOPAY, 6 );
        UT_TRACE.TRACE( 'FIN: GC_BCDebtNegoProduct.fnuGetNegotiationValue', 5 );
        RETURN NUVALUETOPAY;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR OR LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
         IF ( CUNEGOTIATIONVALUE%ISOPEN ) THEN
            CLOSE CUNEGOTIATIONVALUE;
         END IF;
         RAISE;
        WHEN OTHERS THEN
         IF ( CUNEGOTIATIONVALUE%ISOPEN ) THEN
            CLOSE CUNEGOTIATIONVALUE;
         END IF;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
    END FNUGETNEGOTIATIONVALUE;

    /*******************************************************************************
    Propiedad intelectual de GDC
    Procedimiento 	: GETSUBSCRIBERFROMCOUPON
    Descripcion	: Obtiene el cliente del cupon ref  LDC_PKCOUPONMGR.GETSUBSCRIBERFROMCOUPON

    Autor: Edison Eduardo Ceron

    Parametros:
        Entrada:
            inuPagare       Identificador del pagare

    Historial de modificaciones:
    Fecha           Autor           Modificacion
    26-02-2019      Eduardo Ceron   200-2152. Creacion
    *******************************************************************************/
    PROCEDURE GETSUBSCRIBERFROMCOUPON
	(
	   ISBDOCUMENT    IN    CUPON.CUPODOCU%TYPE,
	   ISBTYPE        IN    CUPON.CUPOTIPO%TYPE,
	   ONUSUBSCRIBER    OUT    SUSCRIPC.SUSCCODI%TYPE
	)
	IS
		NUSUBSCRIBER    SUSCRIPC.SUSCCODI%TYPE;
		NUDOCUMENTNUMBER    NUMBER;
		CNUSUSCRIPCION_NO_PERMITIDA    CONSTANT NUMBER := 9092;

		PROCEDURE PROCESSACCOUNTST
        IS
		BEGIN
    		ut_trace.trace('Inicio LDC_PKCOUPONMGR.ProcessAccountSt',10);

    		NUDOCUMENTNUMBER := TO_NUMBER (ISBDOCUMENT);

    		NUSUBSCRIBER := PKTBLFACTURA.FNUGETSUBSCRIBER
    				(
    					NUDOCUMENTNUMBER,
    					PKCONSTANTE.NOCACHE
    				);
            ut_trace.trace('Fin LDC_PKCOUPONMGR.ProcessAccountSt',10);
		EXCEPTION
    		WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
    		WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
		END PROCESSACCOUNTST ;

		PROCEDURE PROCESSACCOUNT IS
		BEGIN
		  ut_trace.trace('Inicia LDC_PKCOUPONMGR.ProcessAccount',10);

		  NUDOCUMENTNUMBER := TO_NUMBER (ISBDOCUMENT);

		  NUSUBSCRIBER := PKBCACCOUNTS.FNUGETSUSCRIPTION
						(
							NUDOCUMENTNUMBER
						);
            ut_trace.trace('Fin LDC_PKCOUPONMGR.ProcessAccount',10);
		EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
    		WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
		END PROCESSACCOUNT;

		PROCEDURE PROCESSFINREQ
        IS
		BEGIN
		  ut_trace.trace('Inicia LDC_PKCOUPONMGR.ProcessFinReq',10);
		  NUDOCUMENTNUMBER := TO_NUMBER (ISBDOCUMENT);
		  NUSUBSCRIBER := DACC_FINANCING_REQUEST.FNUGETSUBSCRIPTION_ID
				(
					NUDOCUMENTNUMBER
				);
            ut_trace.trace('Fin LDC_PKCOUPONMGR.ProcessFinReq',10);
		EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
    		WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
		END PROCESSFINREQ;

		PROCEDURE PROCESSDEFDEBTPAYMENT
        IS
		BEGIN
		  ut_trace.trace('Inicia LDC_PKCOUPONMGR.ProcessDefDebtPayment',10);

		  NUDOCUMENTNUMBER := TO_NUMBER (ISBDOCUMENT);

		  NUSUBSCRIBER := PKTBLSERVSUSC.FNUGETSUSCRIPTION
				(
					NUDOCUMENTNUMBER,
					PKCONSTANTE.NOCACHE
				);
            ut_trace.trace('Fin LDC_PKCOUPONMGR.ProcessDefDebtPayment',10);
		EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
    		WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
		END PROCESSDEFDEBTPAYMENT ;

		PROCEDURE PROCESSADVANCE
		IS

			NUPRODUCTO		SERVSUSC.SESUNUSE%TYPE;
			NUBILLID        FACTURA.FACTCODI%TYPE;
			NUNO_EXIST_PROD	CONSTANT NUMBER := 3010;
		BEGIN
			UT_TRACE.TRACE( 'Inicio [LDC_PKCOUPONMGR.GetSubscriberFromCoupon.ProcessAdvance]',10 );

			NUSUBSCRIBER := TO_NUMBER( ISBDOCUMENT );
			NUBILLID := PKBCFACTURA.FNUGETLASTBILLBYSUSC(NUSUBSCRIBER);

			IF (NUBILLID IS NOT NULL) THEN
				PKERRORS.POP;
				RETURN;
			END IF;

			NUPRODUCTO := RC_BCPAYMENTQUERIES.FNUGETGREATPRIORBILLABLEPROD( NUSUBSCRIBER );

			IF ( NUPRODUCTO IS NULL ) THEN
				PKERRORS.SETERRORCODE( PKCONSTANTE.CSBDIVISION, PKCONSTANTE.CSBMOD_REC, NUNO_EXIST_PROD );
				RAISE EX.CONTROLLED_ERROR;
			END IF;

			UT_TRACE.TRACE( 'Fin [LDC_PKCOUPONMGR.GetSubscriberFromCoupon.ProcessAdvance]',10 );
		EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
    		WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
		END PROCESSADVANCE;

		PROCEDURE PROCESSREQUEST
		IS
			RCMOTIVE        DAMO_MOTIVE.STYMO_MOTIVE;
		BEGIN
			UT_TRACE.TRACE( 'Inicio [LDC_PKCOUPONMGR.GetSubscriberFromCoupon.ProcessRequest]',10 );

			BEGIN
				DAMO_PACKAGES.ACCKEY( TO_NUMBER( ISBDOCUMENT ) );
			EXCEPTION
				WHEN EX.CONTROLLED_ERROR THEN
					RAISE EX.CONTROLLED_ERROR;
			END;

			RCMOTIVE    := MO_BOPACKAGES.FRCGETINITIALMOTIVE(TO_NUMBER( ISBDOCUMENT ));
			NUSUBSCRIBER := RCMOTIVE.SUBSCRIPTION_ID;

			IF ( NUSUBSCRIBER IS NULL ) THEN
				NUSUBSCRIBER := PKTBLSERVSUSC.FNUGETSUSCRIPTION( RCMOTIVE.PRODUCT_ID );
			END IF;

			UT_TRACE.TRACE( 'Fin [LDC_PKCOUPONMGR.GetSubscriberFromCoupon.ProcessRequest]',10 );
		EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
    		WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
		END PROCESSREQUEST;

		PROCEDURE PROCESSNEGOTIATION
		IS

		  NUPACKAGEID   MO_PACKAGES.PACKAGE_ID%TYPE;
		  NUMAINMOTIVEID MO_MOTIVE.MOTIVE_ID%TYPE;
		  NUSUSCRIPCID  SUSCRIPC.SUSCCODI%TYPE;

        BEGIN
			 ut_trace.trace('Inicia LDC_PKCOUPONMGR.GetSubscriberFromCoupon.ProcessNegotiation',10);

			 NUPACKAGEID := DAGC_DEBT_NEGOTIATION.FNUGETPACKAGE_ID(ISBDOCUMENT);
			 NUMAINMOTIVEID := MO_BOPACKAGES.FRCGETINITIALMOTIVE(NUPACKAGEID).MOTIVE_ID;
			 NUSUSCRIPCID := DAMO_MOTIVE.FNUGETSUBSCRIPTION_ID(NUMAINMOTIVEID);
			 NUSUBSCRIBER := NUSUSCRIPCID;

            ut_trace.trace('Fin LDC_PKCOUPONMGR.GetSubscriberFromCoupon.ProcessNegotiation',10);
		EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
    		WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
		END PROCESSNEGOTIATION;

		PROCEDURE PROCESSOSICOUPON
		IS

			RCCUPON CUPON%ROWTYPE;
			NUSUBSCRIPTIONID SUSCRIPC.SUSCCODI%TYPE;

		BEGIN
			 ut_trace.trace('Inicia LDC_PKCOUPONMGR.GetSubscriberFromCoupon.ProcessOSICoupon',10);
			 PKBCCUPON.GETCOUPONBYDOCUMENT(ISBDOCUMENT, RCCUPON, ISBTYPE);
			 NUSUBSCRIPTIONID := RCCUPON.CUPOSUSC;
			 NUSUBSCRIBER := NUSUBSCRIPTIONID;

            ut_trace.trace('Fin LDC_PKCOUPONMGR.GetSubscriberFromCoupon.ProcessOSICoupon',10);
		EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
    		WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
		END PROCESSOSICOUPON;
	BEGIN
		ut_trace.trace('Inicia LDC_PKCOUPONMGR.GetSubscriberFromCoupon',10);
		NUSUBSCRIBER := PKCONSTANTE.NULLNUM;
		IF (
			ISBTYPE = PKBILLCONST.CSBTOKEN_FACTURA OR
			ISBTYPE = PKBILLCONST.CSBTOKEN_CUENCUAG OR
			ISBTYPE = PKBILLCONST.CSBTOKEN_APLICA_FACTURA
		) THEN
			PROCESSACCOUNTST ;
		ELSIF ( ISBTYPE = PKBILLCONST.CSBTOKEN_CUENTA ) THEN
			PROCESSACCOUNT ;
		ELSIF ( ISBTYPE = PKBILLCONST.CSBTOKEN_FINANCING_PAYMENT ) THEN
			PROCESSFINREQ ;
		ELSIF ( ISBTYPE = PKBILLCONST.CSBTOKEN_ABONO_DEUDA_DIF ) THEN
			PROCESSDEFDEBTPAYMENT;
		ELSIF ( ISBTYPE = PKBILLCONST.CSBTOKEN_ANTICIPO ) THEN
			PROCESSADVANCE;
		ELSIF ( ISBTYPE = PKBILLCONST.CSBTOKEN_SOLICITUD OR ISBTYPE = PKBILLCONST.CSBTOKEN_DEPOSITO ) THEN
			PROCESSREQUEST;
		ELSIF (ISBTYPE = PKBILLCONST.CSBTOKEN_NEGOCIACION) THEN
			PROCESSNEGOTIATION;
		ELSIF (ISBTYPE IS NOT NULL AND ISBDOCUMENT IS NOT NULL) THEN
			PROCESSOSICOUPON;
		END IF;

		IF ( NUSUBSCRIBER = PKCONSTANTE.NULLNUM ) THEN
		   PKERRORS.SETERRORCODE( PKCONSTANTE.CSBDIVISION, PKCONSTANTE.CSBMOD_SAT, CNUSUSCRIPCION_NO_PERMITIDA );
		   RAISE EX.CONTROLLED_ERROR;
		END IF;

		ONUSUBSCRIBER := NUSUBSCRIBER;

        ut_trace.trace('Fin LDC_PKCOUPONMGR.GetSubscriberFromCoupon',10);
	EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
		WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
	END GETSUBSCRIBERFROMCOUPON;

	/*******************************************************************************
    Propiedad intelectual de GDC
    Procedimiento 	: FNUGETNEWCOUPONNUM
    Descripcion	: Obtiene el identificador del cupon ref  LDC_PKCOUPONMGR.FNUGETNEWCOUPONNUM

    Autor: Edison Eduardo Ceron

    Parametros:
        Entrada:
            inuPagare       Identificador del pagare

    Historial de modificaciones:
    Fecha           Autor           Modificacion
    19-03-2019      Eduardo Ceron   200-2152. Creacion
    *******************************************************************************/

	FUNCTION FNUGETNEWCOUPONNUM
    RETURN NUMBER
    IS
		NUNUMCUPON        CUPON.CUPONUME%TYPE;
		NUCURRNUMBER    CUPON.CUPONUME%TYPE;
	BEGIN
		ut_trace.trace('Inicia LDC_PKCOUPONMGR.fnuGetNewCouponNum',10);

		NUNUMCUPON:= SEQ.GETNEXT('SQ_CUPON_CUPONUME', TRUE);
        ut_trace.trace('Fin  LDC_PKCOUPONMGR.fnuGetNewCouponNum RETURN '||NUNUMCUPON,10);
		RETURN NUNUMCUPON ;
	EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
		WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
	END FNUGETNEWCOUPONNUM;

    /*******************************************************************************
    Propiedad intelectual de GDC
    Procedimiento 	: GENNEWRECORD
    Descripcion	: Procedimiento que genera cupon ref  LDC_PKCOUPONMGR.GENNEWRECORD

    Autor: Edison Eduardo Ceron

    Parametros:
        Entrada:
            inuPagare       Identificador del pagare

    Historial de modificaciones:
    Fecha           Autor           Modificacion
    26-02-2019      Eduardo Ceron   200-2152. Creacion
    *******************************************************************************/
    PROCEDURE GENNEWRECORD
	(
		ISBDOCTYPE      IN  CUPON.CUPOTIPO%TYPE,
		ISBDOCUMENT     IN  CUPON.CUPODOCU%TYPE,
		INUVALUE        IN  CUPON.CUPOVALO%TYPE,
		INUPARENTCOUP   IN  CUPON.CUPOCUPA%TYPE,
		IDTREGDATE      IN  CUPON.CUPOFECH%TYPE,
		ORCCOUPON       OUT NOCOPY CUPON%ROWTYPE,
		INUSUBSCRIPTION IN  CUPON.CUPOSUSC%TYPE DEFAULT NULL
	)
	IS
	BEGIN
		ut_trace.trace('Inicio LDC_PKCOUPONMGR.GenNewRecord',10);

		IF ( INUSUBSCRIPTION IS NOT NULL ) THEN
			ORCCOUPON.CUPOSUSC := INUSUBSCRIPTION;
		ELSE
			GETSUBSCRIBERFROMCOUPON( ISBDOCUMENT, ISBDOCTYPE, ORCCOUPON.CUPOSUSC );
		END IF;

		FA_BOPOLITICAREDONDEO.VALIDAPOLITICACONT( ORCCOUPON.CUPOSUSC, INUVALUE );

		ORCCOUPON.CUPONUME := FNUGETNEWCOUPONNUM;
		ORCCOUPON.CUPOTIPO := ISBDOCTYPE;
		ORCCOUPON.CUPODOCU := ISBDOCUMENT;
		ORCCOUPON.CUPOVALO := FNUAPPLYROUNDCOUPON(INUVALUE);
		ORCCOUPON.CUPOFECH := NVL( IDTREGDATE, PKGENERALSERVICES.FDTGETSYSTEMDATE );
		ORCCOUPON.CUPOPROG := PKERRORS.FSBGETAPPLICATION;
		ORCCOUPON.CUPOCUPA := INUPARENTCOUP;
		ORCCOUPON.CUPOFLPA := PKCONSTANTE.NO;

		PKTBLCUPON.INSRECORD( ORCCOUPON );

		IF ( ISBDOCTYPE = PKBILLCONST.CSBTOKEN_CUENCUAG ) THEN

			PKBCCUENCUAG.COPYGROUPINFOBYCOUPON
			(
				INUPARENTCOUP,
				ORCCOUPON.CUPONUME
			);

		END IF;

        ut_trace.trace('Fin LDC_PKCOUPONMGR.GenNewRecord',10);

	EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
		WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
	END GENNEWRECORD;

    /*******************************************************************************
    Propiedad intelectual de GDC
    Procedimiento 	: GENERATECOUPONSERVICE
    Descripcion	: Procedimiento que genera cupon ref  LDC_PKCOUPONMGR.GENERATENEGOTIATCOUPON

    Autor: Edison Eduardo Ceron

    Parametros:
        Entrada:
            inuPagare       Identificador del pagare

    Historial de modificaciones:
    Fecha           Autor           Modificacion
    26-02-2019      Eduardo Ceron   200-2152. Creacion
    *******************************************************************************/
    PROCEDURE GENERATECOUPONSERVICE
	(
		ISBTIPO        IN  CUPON.CUPOTIPO%TYPE,
		ISBDOCUMENTO   IN  CUPON.CUPODOCU%TYPE,
		INUVALOR       IN  CUPON.CUPOVALO%TYPE,
		INUCUPONPADRE  IN  CUPON.CUPOCUPA%TYPE,
		IDTCUPOFECH    IN  CUPON.CUPOFECH%TYPE,
		ONUCUPONCURR   OUT CUPON.CUPONUME%TYPE
	)
	IS
		RCCUPON CUPON%ROWTYPE;

	BEGIN
		ut_trace.trace('Inicia LDC_PKCOUPONMGR.GenerateCouponService', 10);

		GENNEWRECORD
		(
			ISBTIPO,
			ISBDOCUMENTO,
			INUVALOR,
			INUCUPONPADRE,
			IDTCUPOFECH,
			RCCUPON
		);

		ONUCUPONCURR := RCCUPON.CUPONUME;

        ut_trace.trace('Fin LDC_PKCOUPONMGR.GenerateCouponService', 10);

	EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
		WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
	END GENERATECOUPONSERVICE;

    /*******************************************************************************
    Propiedad intelectual de GDC
    Procedimiento 	: GENERATENEGOTIATCOUPON
    Descripcion	: Procedimiento que genera cupon ref  LDC_PKCOUPONMGR.GENERATENEGOTIATCOUPON

    Autor: Edison Eduardo Ceron

    Parametros:
        Entrada:
            inuPagare       Identificador del pagare

    Historial de modificaciones:
    Fecha           Autor           Modificacion
    26-02-2019      Eduardo Ceron   200-2152. Creacion
    *******************************************************************************/
    PROCEDURE GENERATENEGOTIATCOUPON
	(
		INUNEGOTIATIONID     IN  GC_DEBT_NEGOTIATION.DEBT_NEGOTIATION_ID%TYPE,
		ONUCOUPON           OUT CUPON.CUPONUME%TYPE,
		ONUVALUE            OUT CUPON.CUPOVALO%TYPE
	)
	IS
		NUCOUPON                 CUPON.CUPONUME%TYPE;
		NUVALUE                 CUPON.CUPOVALO%TYPE;
		SBREQUIREDPAY   GC_DEBT_NEGOTIATION.REQUIRE_PAYMENT%TYPE;
		CSBREQ_PAY CONSTANT GC_DEBT_NEGOTIATION.REQUIRE_PAYMENT%TYPE := CC_BOCONSTANTS.CSBSI;
		BOWAITPAY    BOOLEAN;
		NUPACKAGE GC_DEBT_NEGOTIATION.PACKAGE_ID%TYPE;
		CNUREQUIERED_PAY CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901474;
		CNUNO_ACTIVITY  CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901475;

		PROCEDURE UpdateProdNegotiations
        (
            INUNEGOTIATIONID    in number,
            inuCOUPON           in number
        )
        IS
            nuSuscriptionId   number;

            cursor cuGetSuscription
            is
                SELECT  serv.sesususc
                FROM    gc_debt_negot_prod neg, servsusc serv     --gc_debt_negotiation
                WHERE   serv.sesunuse = neg.sesunuse
                AND     neg.debt_negotiation_id = INUNEGOTIATIONID;

            cursor cuGetNegotiations
            is
                SELECT  neg.debt_negotiation_id
                FROM    gc_debt_negot_prod neg, servsusc serv, gc_debt_negotiation gcneg,
                        mo_packages pkg
                WHERE   serv.sesunuse = neg.sesunuse
                AND     serv.sesususc = nuSuscriptionId
                AND     neg.debt_negotiation_id <> INUNEGOTIATIONID
                AND     neg.debt_negotiation_id = gcneg.debt_negotiation_id
                AND     gcneg.package_id = pkg.package_id
                AND     pkg.motive_status_id not in (14,32,51); -- cerradas, analudas y canceladas
        BEGIN

            open  cuGetSuscription;
            fetch cuGetSuscription into nuSuscriptionId;
            close cuGetSuscription;

            for rcNegot in cuGetNegotiations loop

                DAGC_DEBT_NEGOTIATION.UPDCOUPON_ID(rcNegot.debt_negotiation_id, iNUCOUPON);

            end loop;

        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
    		WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END UpdateProdNegotiations;

	BEGIN

        ut_trace.trace('Inicia LDC_PKCOUPONMGR.GenerateNegotiatCoupon', 10);

		DAGC_DEBT_NEGOTIATION.ACCKEY(INUNEGOTIATIONID);
		SBREQUIREDPAY := DAGC_DEBT_NEGOTIATION.FSBGETREQUIRE_PAYMENT(INUNEGOTIATIONID);

		IF SBREQUIREDPAY <> CSBREQ_PAY THEN
		   ERRORS.SETERROR(CNUREQUIERED_PAY);
		   RAISE EX.CONTROLLED_ERROR;
		END IF;

		NUPACKAGE := DAGC_DEBT_NEGOTIATION.FNUGETPACKAGE_ID(INUNEGOTIATIONID);
		BOWAITPAY := MO_BOWF_PACK_INTERFAC.FBLACTIVITYEXIST
							(
							NUPACKAGE,
							FI_BOFINANDEBTPROCESS.CNUWAIT_PAYMENT,
							MO_BOSTATUSPARAMETER.FNUGETSTA_ACTIV_STANDBY
							);

		IF (NOT BOWAITPAY) THEN
		   ERRORS.SETERROR(CNUNO_ACTIVITY);
		   RAISE EX.CONTROLLED_ERROR;
		END IF;

		-- obtener valor del cupon
		NUVALUE := FNUGETNEGOTIATIONVALUE(INUNEGOTIATIONID);

		GENERATECOUPONSERVICE
		(
			PKBILLCONST.CSBTOKEN_NEGOCIACION,
			TO_CHAR(INUNEGOTIATIONID),
			NUVALUE,
			NULL,
			NULL,
			NUCOUPON
		);

		DAGC_DEBT_NEGOTIATION.UPDCOUPON_ID(INUNEGOTIATIONID, NUCOUPON);

        UpdateProdNegotiations(INUNEGOTIATIONID, NUCOUPON);

		ONUCOUPON := NUCOUPON;
		ONUVALUE := NUVALUE;

        ut_trace.trace('Fin LDC_PKCOUPONMGR.GenerateNegotiatCoupon', 10);
	EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
        WHEN others THEN
                errors.seterror;
                RAISE EX.CONTROLLED_ERROR;
	END GENERATENEGOTIATCOUPON;

    /*******************************************************************************
    Propiedad intelectual de GDC
    Procedimiento 	: ValidAndGeneraCupon
    Descripcion	: Procedimiento que valida y genera el cupon para una negociación
                de deuda.

    Autor: Edison Eduardo Ceron

    Parametros:
        Entrada:
            inuPagare       Identificador del pagare

    Historial de modificaciones:
    Fecha           Autor           Modificacion
    17-02-2019      Eduardo Ceron   200-2152. Creacion
    *******************************************************************************/
    PROCEDURE ValidAndGeneraCupon(inuPagare IN pagare.pagacodi%type)
    IS

    cursor cuNegotiation(inuPaga IN pagare.pagacodi%type)
    is
        select  gc_debt_negotiation.debt_negotiation_id negotiation_id,
                gc_debt_negotiation.coupon_id cupon_id,gc_debt_negotiation.require_payment
        from    pagare,cc_financing_request,gc_debt_negotiation
        where   pagare.pagacodi = inuPaga
        and     pagare.pagacofi = cc_financing_request.financing_id
        and     gc_debt_negotiation.package_id = cc_financing_request.package_id;

        rwNegotiation cuNegotiation%rowtype;
        nuCupon CUPON.CUPONUME%TYPE;
        NUCOUPONVALUE cupon.cupovalo%type;

    BEGIN

        ut_trace.trace('Inicia ld_boprintpagare.ValidAndGeneraCupon inuPagare '||inuPagare,10);

        OPEN cuNegotiation(inuPagare);
            FETCH cuNegotiation INTO rwNegotiation;
        CLOSE cuNegotiation;

        IF rwNegotiation.cupon_id IS NULL AND rwNegotiation.require_payment = 'Y' THEN

            GENERATENEGOTIATCOUPON
                (
                    rwNegotiation.negotiation_id,
                    nuCupon,
                    NUCOUPONVALUE
                );

            ut_trace.trace('ld_boprintpagare.ValidAndGeneraCupon Cupon generado ValidAndGeneraCupon: '||nuCupon);
        END IF;

        ut_trace.trace('Fin ld_boprintpagare.ValidAndGeneraCupon nuCupon '||nuCupon,10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
        WHEN others THEN
                errors.seterror;
                RAISE EX.CONTROLLED_ERROR;
    END ValidAndGeneraCupon;


    /*******************************************************************************
    Propiedad intelectual de GDC
    Procedimiento 	: PROCESAR
    Descripcion	: Servicio de proceso de LDIPA

    Autor:

    Parametros:
        Entrada:
            inuPagare       Identificador del pagare

    Historial de modificaciones:
    Fecha           Autor           Modificacion
    17-02-2019      Eduardo Ceron   Se adiciona el llamado al servicio ValidAndGeneraCupon
                                    para que genere el cupon cuando el pagare no tenga
    *******************************************************************************/
    PROCEDURE PROCESAR
    IS

      CNUNULL_ATTRIBUTE CONSTANT NUMBER := 2126;

      CSBDIFERIDO CONSTANT VARCHAR2( 10 ) := 'PAGARE';

      CSBFINANCIACION CONSTANT VARCHAR2( 10 ) := 'PAGACODI';

      SBPAGARE GE_BOINSTANCECONTROL.STYSBVALUE;

      SBFORMATO GE_BOINSTANCECONTROL.STYSBVALUE;

      nuPagare  pagare.pagacodi%TYPE;

      nuFormato ed_formato.formcodi%TYPE;

      PROCEDURE INICIALIZAR

       IS

       BEGIN

         UT_TRACE.TRACE( 'Inicio [ld_boprintpagare.Procesar.Inicializar]', CNUNIVELTRAZA + 1 );

         PKERRORS.SETAPPLICATION( CSBLDIPA_APP_NAME );

         SBPAGARE := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE( CSBDIFERIDO, CSBFINANCIACION );

         UT_TRACE.TRACE( 'sbPagare ' || SBPAGARE, CNUNIVELTRAZA + 1 );

         SBFORMATO := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE( 'ED_FORMATO', 'FORMCODI' );

         UT_TRACE.TRACE( 'SBFORMATO ' || SBFORMATO, CNUNIVELTRAZA + 1 );

         UT_TRACE.TRACE( 'Fin [ld_boprintpagare.Procesar.Inicializar]', CNUNIVELTRAZA + 1 );

       EXCEPTION

         WHEN EX.CONTROLLED_ERROR THEN

            UT_TRACE.TRACE( 'Error [ld_boprintpagare.Procesar.Inicializar]', CNUNIVELTRAZA + 2 );

            RAISE;

         WHEN OTHERS THEN

            UT_TRACE.TRACE( 'Error [ld_boprintpagare.Procesar.Inicializar]', CNUNIVELTRAZA + 2 );

            ERRORS.SETERROR;

            RAISE EX.CONTROLLED_ERROR;

      END INICIALIZAR;

      PROCEDURE VALIDARDATOS

       IS

       BEGIN

         UT_TRACE.TRACE( 'Inicio [ld_boprintpagare.Procesar.ValidarDatos]', CNUNIVELTRAZA + 1 );

         IF ( SBPAGARE IS NULL ) THEN

            ERRORS.SETERROR( CNUNULL_ATTRIBUTE, 'Código del Pagaré' );

            RAISE EX.CONTROLLED_ERROR;

         END IF;

         IF ( SBFORMATO IS NULL ) THEN

            ERRORS.SETERROR( CNUNULL_ATTRIBUTE, 'Formato de Impresión' );

            RAISE EX.CONTROLLED_ERROR;

         END IF;

         UT_TRACE.TRACE( 'Fin [ld_boprintpagare.Procesar.ValidarDatos]', CNUNIVELTRAZA + 1 );

       EXCEPTION

         WHEN EX.CONTROLLED_ERROR THEN

            UT_TRACE.TRACE( 'Error [ld_boprintpagare.Procesar.ValidarDatos]', CNUNIVELTRAZA + 2 );

            RAISE;

         WHEN OTHERS THEN

            UT_TRACE.TRACE( 'Error [ld_boprintpagare.Procesar.ValidarDatos]', CNUNIVELTRAZA + 2 );

            ERRORS.SETERROR;

            RAISE EX.CONTROLLED_ERROR;

      END VALIDARDATOS;

    BEGIN

      UT_TRACE.TRACE( 'Inicio [ld_boprintpagare.Procesar]', CNUNIVELTRAZA );

      INICIALIZAR;

      VALIDARDATOS;

      UT_TRACE.TRACE( 'Ejecuta [LDIPA] ', CNUNIVELTRAZA + 1 );

      nuPagare := To_Number(SBPAGARE);

      nuFormato := To_Number(SBFORMATO);

      ut_trace.trace('Validación del cupon ValidAndGeneraCupon', 10);

      ValidAndGeneraCupon(nuPagare);

      ut_trace.trace('Fin de la validación ValidAndGeneraCupon', 10);

      ld_boprintpagare.PrintPagare(nuPagare,nuFormato);

      UT_TRACE.TRACE( 'Fin [ld_boprintpagare.Procesar]', CNUNIVELTRAZA );

    EXCEPTION

      WHEN EX.CONTROLLED_ERROR THEN

         UT_TRACE.TRACE( 'Error [ld_boprintpagare.Procesar]', CNUNIVELTRAZA + 1 );

         RAISE;

      WHEN OTHERS THEN

         UT_TRACE.TRACE( 'Error [ld_boprintpagare.Procesar]', CNUNIVELTRAZA + 1 );

         ERRORS.SETERROR;

         RAISE EX.CONTROLLED_ERROR;

   END PROCESAR;



END ld_boprintpagare;
/
GRANT EXECUTE on LD_BOPRINTPAGARE to SYSTEM_OBJ_PRIVS_ROLE;
GRANT EXECUTE on LD_BOPRINTPAGARE to REXEOPEN;
GRANT EXECUTE on LD_BOPRINTPAGARE to RSELSYS;
/
