CREATE OR REPLACE PACKAGE      adm_person.LD_BOCouponPrinting
IS
    /***************************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Package	    : CC_BOQuotationPrinting
    Descripcion	: Proceso de impresion de cotizaciones.

    Autor	    : Sandra Milena Quintero Polanco.
    Fecha	    : 19-07-2011

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN        Modificacion
    -----------  -------------------    -------------------------------------
	28/11/2024	 JSOTO					 OSF-3636 Se borra el procedimiento ProcessLDICU ya que el PB LDICU usará otros objetos
    21/06/2024   PAcosta                 OSF-2847: Cambio de esquema ADM_PERSON 
    23-06-2021   Horbath                 CA684: Se Crea PrintCouponNet
    30-07-2013   lgranada.SAO213197      Se modifica el metodo <GetQuotationData>
    ***************************************************************************/

    --------------------------------------------
    -- Constantes GLOBALES Y PUBLICAS DEL PAQUETE
    --------------------------------------------

    --------------------------------------------
    -- Funciones y Procedimientos PUBLICAS DEL PAQUETE
    --------------------------------------------
    FUNCTION fsbVersion
    RETURN varchar2;


    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  PrintCouponNet
    Descripcion :  Imprime el cupon
    ***************************************************************/
    PROCEDURE PrintCouponNet
    (
        inuCupon    IN      cupon.cuponume%TYPE
    );





END LD_BOCouponPrinting;
/
CREATE OR REPLACE PACKAGE BODY      adm_person.LD_BOCouponPrinting
IS
    /***************************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Package	    : CC_BOQuotationPrinting
    Descripcion	: Proceso de impresion de cotizaciones.

    Autor	    : Sandra Milena Quintero Polanco.
    Fecha	    : 19-07-2011

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.SAONNNNN        Modificacion
    -----------  -------------------    -------------------------------------
    23-06-2021   Horbath                CA684: Se Crea PrintCouponNet
    30-07-2013  lgranada.SAO213197      Se modifica el metodo <GetQuotationData>
    ***************************************************************************/

    --------------------------------------------
    -- Constantes VERSION DEL PAQUETE
    --------------------------------------------
    csbVERSION             constant varchar2(10) := 'CA684';


    --------------------------------------------
    -- Funciones y Procedimientos PRIVADAS DEL PAQUETE
    --------------------------------------------

    FUNCTION fsbVersion
    RETURN varchar2
    IS
    BEGIN
        return csbVERSION;
    END fsbVersion;

    PROCEDURE Printdata
    (
        inuCouponId      in  cc_quotation.quotation_id%type,
        inuConfexme      in  ed_confexme.coemcodi%type
    )
    IS
        rcConfexme      pktbled_confexme.cuEd_Confexme%rowtype; --DAED_ConfExme.styED_confexme;
        clClobData      clob;   -- Data de la cotizacion
        nuFormatId      ed_formato.formcodi%type;
    BEGIN
        UT_Trace.Trace('Inicio: LD_BOCouponPrinting.Printdata', 2);

        -- Obtiene el registro del tipo de formato de extraccion y mezcla
        pkBCED_Confexme.ObtieneRegistro
        (
            inuConfexme,
            rcConfexme
        );

        -- Instancia la entidad base
        pkBODataExtractor.InstanceBaseEntity
        (
            inuCouponId,
            'CUPON',
            pkConstante.verdadero
        );

        --Obtiene el codigo del formato
        nuFormatId := pkbced_formato.fnugetformcodibyiden(rcConfexme.coempada);

        UT_Trace.Trace('Codigo del formato: '||nuFormatId, 4);
        UT_Trace.Trace('Nombre de la plantilla: ' || rcConfexme.coempadi, 4);

        --  Ejecuta proceso de extraccion de datos para formato digital
        pkBODataExtractor.ExecuteRules( nuFormatId, clClobData );

        -- Instancia el numero del cupon a imprimir
        pkBOED_DocumentMem.Set_PrintDocId(inuCouponId);

        -- Almancena en memoria el archivo para el proceso de extraccion y mezcla
        pkboed_documentmem.Set_PrintDoc( clClobData );

        -- Almancena en memoria la plantilla para extraccion y mezcla
        pkboed_documentmem.SetTemplate( rcConfexme.coempadi );

        ut_trace.trace('Salida:'||to_char(clClobData),4);

        UT_Trace.Trace( 'Fin: LD_BOCouponPrinting.Printdata', 2 );
    EXCEPTION
       when ex.CONTROLLED_ERROR OR login_denied OR pkConstante.exERROR_LEVEL2 then
           raise;
       when others then
           errors.setError;
           raise ex.CONTROLLED_ERROR;
    END Printdata;


    PROCEDURE PrintCoupon
    (
        inuCupoNume     in  cupon.cuponume%type,
        inuConfexme     in  cuencobr.cucocodi%type
    )
    IS
        ----------------------------------------------------------------------------
        ----------------------------------------------------------------------------
        -- Variables:
        rcCupon     cupon%rowtype;
    BEGIN
    --{
        ut_trace.trace('Inicio LD_BOCouponPrinting.PrintCoupon ',7);


        ut_trace.Trace('inuConfexme ' || to_char(inuConfexme),8);
        ut_trace.Trace('inuCupoNume ' || to_char(inuCupoNume),8);

        -- Verifica que el cupon exista.
        pktblCupon.acckey(inuCupoNume);

        --Procesar el cupon
        PrintData
        (
            inuCupoNume,
            inuConfexme
        );

        --  Proceso .NET de impresion de duplicado
        GE_BOIOpenExecutable.PrintPreviewerRule();

        ut_trace.trace('Fin LD_BOCouponPrinting.PrintCoupon ',7);

    EXCEPTION
        when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 then
            raise;
        when OTHERS then
            errors.setError;
            raise ex.CONTROLLED_ERROR;
    --}
    END PrintCoupon;


    /**************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :  PrintCouponNet
    Descripcion :  Imprime el cupon

    Autor       :  Horbath
    Fecha       :  23-06-2021
    Parametros  :

    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    23-06-2021   Horbath             CA684: Creacion
    ***************************************************************/
    PROCEDURE PrintCouponNet
    (
        inuCupon    IN      cupon.cuponume%TYPE
    )
    IS

        nuConfexme ld_parameter.numeric_value%type;

    BEGIN
        ut_trace.Trace('Inicio: LD_BOCouponPrinting.PrintCouponNet - inuCupon: '||inuCupon, 8);

        nuConfexme := dald_parameter.fnuGetNumeric_Value('EXTRACT_COUPON');
        PrintCoupon(inuCupon, nuConfexme);

        COMMIT;

        ut_trace.Trace('Fin: LD_BOCouponPrinting.PrintCouponNet', 8);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise;

        when OTHERS then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END PrintCouponNet;

END LD_BOCouponPrinting;
/
PROMPT Otorgando permisos de ejecucion a LD_BOCOUPONPRINTING
BEGIN
    pkg_utilidades.praplicarpermisos('LD_BOCOUPONPRINTING', 'ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre LD_BOCOUPONPRINTING para reportes
GRANT EXECUTE ON adm_person.LD_BOCOUPONPRINTING TO rexereportes;
/