CREATE OR REPLACE package LDC_BOCERTIFICADO_ESTDEUDA is
    /*****************************************************************
    Propiedad intelectual de Gascaribe-Efigas

    Unidad         : LDC_BOCERTIFICADO_ESTDEUDA
    Descripcion    : Paquete que contiene la lógica de negocio para la impresión del certificado
                     del estado de deuda por producto.
    Autor          : KCienfuegos
    Fecha          : 12-01-2017
    Caso           : CA200-955

    Historia de Modificaciones
    Fecha         Autor                         Modificacion
    ===============================================================
    26-07-2024    jcatuche                      OSF-2996: Se ajusta el método
                                                    [fnuObtDeudDifxConcepto]
                                                    [proImprimeCertificado]
                                                    [proInicializaVar]
                                                    [proObtieneDeudaDiferida]
                                                A nivel general se cambian los llamados fnugetproduct_type_id por pkg_bcproducto.fnutipoproducto,
                                                dald_parameter.fnugetnumeric_value por pkg_bcld_parameter.fnuobtienevalornumerico y
                                                dald_parameter.fsbgetvalue_chain por pkg_bcld_parameter.fsbobtienevalorcadena
    14-06-2024    jcatuche                      OSF-2830: Se ajusta el método
                                                    [proObtieneDeudaCorriente]
    31-05-2024    felipe.valencia               OSF-2762: Se modifica procedimiento proObtieneDeudaCorriente
                                                y se realizan modificación técnicas al paquete.
    19-09-2019    Eceron.Caso58                 Se crea: fnuGetProdBySubs
                                                         csbProductsType
                                                Se modifica: proInicializaVar
                                                             proObtieneDeudaCorriente

    12-01-2017    KCienfuegos.CA200-955         Creación
    ******************************************************************/

    /*****************************************************************
    Propiedad intelectual de Gascaribe-Efigas.

    Unidad         : fnuObtieneMotivo
    Descripcion    : Función para obtener el id del motivo principal
    Autor          : KCienfuegos
    Fecha          : 12-01-2017
    Caso           : CA200-955

    Parámetros           Descripción
    ============         ===================

    Historia de Modificaciones
    Fecha         Autor                         Modificacion
    ===============================================================
    12-01-2017    KCienfuegos.CA200-955         Creacion.
    ******************************************************************/
    FUNCTION fnuObtieneMotivo
    RETURN mo_motive.motive_id%TYPE;

    /*****************************************************************
    Propiedad intelectual de Gascaribe-Efigas.

    Unidad         : proImprimeCertificado
    Descripcion    : Metodo para imprimir el certificado de estado de deuda por producto
    Autor          : KCienfuegos
    Fecha          : 12-01-2017
    Caso           : CA200-955

    Parámetros           Descripción
    ============         ===================
    inuSolicitud         Solicitud
    onuCodigoError       Codigo de Error
    osbMensajeError      Mensaje de Error

    Historia de Modificaciones
    Fecha         Autor                         Modificacion
    ===============================================================
    12-01-2017    KCienfuegos.CA200-955         Creacion.
    ******************************************************************/
    PROCEDURE proImprimeCertificado(inuSolicitud         IN     mo_packages.package_id%TYPE,
                                    onuCodigoError       OUT    NUMBER,
                                    osbMensajeError      OUT    VARCHAR2);

    /*****************************************************************
    Propiedad intelectual de Gascaribe-Efigas.

    Unidad         : proImprimeCertificado
    Descripcion    : Metodo para imprimir el certificado de estado de deuda por producto
    Autor          : KCienfuegos
    Fecha          : 12-01-2017
    Caso           : CA200-955

    Parámetros           Descripción
    ============         ===================
    inuSolicitud         Solicitud
    onuCodigoError       Codigo de Error
    osbMensajeError      Mensaje de Error

    Historia de Modificaciones
    Fecha         Autor                         Modificacion
    ===============================================================
    12-01-2017    KCienfuegos.CA200-955         Creacion.
    ******************************************************************/
    PROCEDURE proImprimeCertificadoAFecha(inuSolicitud         IN     mo_packages.package_id%TYPE,
                                          onuCodigoError       OUT    NUMBER,
                                          osbMensajeError      OUT    VARCHAR2);

    /*****************************************************************
    Propiedad intelectual de Gascaribe-Efigas.

    Unidad         : proObtieneDeudaDiferida
    Descripcion    : Metodo para obtener la deuda diferida
    Autor          : KCienfuegos
    Fecha          : 12-01-2017
    Caso           : CA200-955

    Parámetros           Descripción
    ============         ===================
    orfcursor            cursor referenciado con los datos de la deuda diferida

    Historia de Modificaciones
    Fecha         Autor                         Modificacion
    ===============================================================
    12-01-2017    KCienfuegos.CA200-955         Creacion.
    ******************************************************************/
    PROCEDURE proObtieneDeudaDiferida(orfcursor OUT constants_per.tyrefcursor);

    /*****************************************************************
    Propiedad intelectual de Gascaribe-Efigas.

    Unidad         : proObtieneDeudaCorriente
    Descripcion    : Metodo para obtener la deuda corriente
    Autor          : KCienfuegos
    Fecha          : 12-01-2017
    Caso           : CA200-955

    Parámetros           Descripción
    ============         ===================
    orfcursor            cursor referenciado con los datos de la deuda corriente

    Historia de Modificaciones
    Fecha         Autor                         Modificacion
    ===============================================================
    12-01-2017    KCienfuegos.CA200-955         Creacion.
    ******************************************************************/
    PROCEDURE proObtieneDeudaCorriente(orfcursor OUT constants_per.tyrefcursor);

    /*****************************************************************
    Propiedad intelectual de Gascaribe-Efigas.

    Unidad         : fnuGetProdBySubs
    Descripcion    : Obtiene el identificador del primer producto asociado al contrato
    ******************************************************************/
    FUNCTION fnuGetProdBySubs
    (
        inuSubscriberId     IN      pr_product.subscription_id%TYPE
    )
    RETURN pr_product.product_id%TYPE;

end LDC_BOCERTIFICADO_ESTDEUDA;
/
CREATE OR REPLACE package body LDC_BOCERTIFICADO_ESTDEUDA is

  --Constantes
   csbPaquete                 VARCHAR2(60) := 'ldc_bocertificado_estdeuda';
   cnuErrorGenerico           CONSTANT ge_error_log.error_log_id%TYPE :=  2741;
   cnuConfexme                CONSTANT ed_confexme.coemcodi%TYPE := pkg_bcld_parameter.fnuobtienevalornumerico('CONFEXME_EST_DEU_PROD');
   csbProductsType            CONSTANT ld_parameter.value_chain%TYPE := pkg_bcld_parameter.fsbobtienevalorcadena('LD_PROD_TYPE_ESTADO_CUENTA');
   csbEjecutableImpresion     CONSTANT NUMBER := 8189;
   gnuSolicitud               mo_packages.package_id%TYPE;
   gnuMotivo                  mo_motive.motive_id%TYPE;
   gtbProductos               pr_tytbproduct;

	-- Constantes para el control de la traza
	csbSP_NAME     CONSTANT VARCHAR2(100):= $$PLSQL_UNIT||'.';
	
	-- Identificador del ultimo caso que hizo cambios
	csbVersion     CONSTANT VARCHAR2(15) := 'OSF-2762';

   TYPE tyrcCarteraxConcepto IS RECORD
	(
		conccodi   concepto.conccodi%TYPE,
        concdesc   concepto.Concdesc%TYPE,
        saldran0   NUMBER(16,3),
        saldran1   NUMBER(16,3),
        saldran2   NUMBER(16,3),
        saldran3   NUMBER(16,3),
        saldran4   NUMBER(16,3),
        saldran5   NUMBER(16,3),
        saldran6   NUMBER(16,3)
	);

  TYPE tytbCarteraCorriente IS TABLE OF tyrcCarteraxConcepto INDEX BY PLS_INTEGER;

  TYPE tyrcCartCorrConcepto IS RECORD
	(
	product_id   pr_product.product_id%type,
	tipo_producto   servicio.servcodi%TYPE,
    conccodi        concepto.conccodi%TYPE,
    concdesc        concepto.Concdesc%TYPE,
    deuda_fecha     NUMBER(16,3),
    deuda_30        NUMBER(16,3),
    deuda_60        NUMBER(16,3),
    deuda_90        NUMBER(16,3),
    deuda_mas90     NUMBER(16,3),
    sald_deud_corr  NUMBER(16,3),
    sald_deud_dif   NUMBER(16,3)
	);

  TYPE tytbCartCorrConcepto IS TABLE OF tyrcCartCorrConcepto INDEX BY VARCHAR2(40);

  TYPE tyrcDiferidoConcepto IS RECORD
	(
		conccodi        concepto.conccodi%TYPE,
    tipo_producto   servicio.servcodi%TYPE,
    sald_diferido   NUMBER(16,3),
    product_id      pr_product.product_id%TYPE
  );

  TYPE tytbDiferidoConcepto IS TABLE OF tyrcDiferidoConcepto INDEX BY PLS_INTEGER;

	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
	Programa        : fsbVersion
	Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor       	: Luis Felipe Valencia Hurtado
    Fecha       	: 31-05-2024

    Modificaciones  :
    Autor       		    Fecha       Caso     	Descripcion
    felipe.valencia   	31-05-2024  OSF-22762 	Creacion
	***************************************************************************/
	FUNCTION fsbVersion 
	RETURN VARCHAR2 
	IS
	BEGIN
		RETURN csbVersion;
	END fsbVersion;
	

  PROCEDURE trc
  (
    isbMessage      IN      or_order_comment.order_comment%TYPE
  )
  IS
    PRAGMA AUTONOMOUS_TRANSACTION;
		csbMT_NAME      	VARCHAR2(100) := csbSP_NAME || 'trc';
		nuError    		NUMBER;
		sbError    		VARCHAR2(32767);
  BEGIN
    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

    INSERT INTO OR_ORDER_COMMENT
    (ORDER_COMMENT_ID, ORDER_COMMENT, ORDER_ID, COMMENT_TYPE_ID, REGISTER_DATE, LEGALIZE_COMMENT, PERSON_ID)
    VALUES (seq_or_order_comment.nextval,ut_session.fsbgetidsession||'-'||isbMessage,10561906,-1,SYSDATE,'N',Null);

    COMMIT;

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
      WHEN pkg_Error.Controlled_Error  THEN
          pkg_Error.getError(nuError, sbError);
          pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
          pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
          RAISE pkg_Error.Controlled_Error;
      WHEN OTHERS THEN
          pkg_Error.setError;
          pkg_Error.getError(nuError, sbError);
          pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
          pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
          RAISE pkg_Error.Controlled_Error;    
  END trc;



    /*****************************************************************
    Propiedad intelectual de Gascaribe-Efigas.

    Unidad         : fnuObtDeudDifxConcepto
    Descripcion    : Función para obtener de un producto la deuda diferida por concepto a la fecha
    Autor          : KCienfuegos
    Fecha          : 12-01-2017
    Caso           : CA200-955

    Parámetros           Descripción
    ============         ===================

    Historia de Modificaciones
    Fecha         Autor                         Modificacion
    ===============================================================
    26/07/2024    jcatuche                      OSF-2996: Se ajusta validación de saldo teniendo en cuenta los movimientos con signos contrarios
                                                por la insolvencia y los movimientos modicuap 0 por errores de migración
    22-07-2020    Horbath.CA58                  Se adiciona validación para que calcule el saldo del diferido,
                                                siempre y cuando el tipo de producto esté configurado en el parámetro
                                                LD_PROD_TYPE_ESTADO_CUENTA
    12-01-2017    KCienfuegos.CA200-955         Creacion.
    ******************************************************************/
    FUNCTION fnuObtDeudDifxConcepto(inuProducto   IN    pr_product.product_id%TYPE,
                                    inuConcepto   IN    concepto.conccodi%TYPE,
                                    idtFecha      IN    DATE)
    RETURN NUMBER
    IS
        csbMT_NAME                   VARCHAR2(500) := 'fnuObtDeudDifxConcepto';		
        nuError    		NUMBER;
        sbError    		VARCHAR2(32767);
        nuSaldDeuda     NUMBER:=0;
        nuProductType   pr_product.product_type_id%TYPE;
        
        cursor cusaldoDeuda is
        SELECT NVL(SUM(difevatd-valor_fact),0)
        FROM
        (
            SELECT 
            (
                SELECT nvl(SUM(case modisign when 'DB' then -MODIVACU else MODIVACU end), 0)
                FROM movidife
                WHERE modifech <= idtFecha
                AND modidife = difecodi
                AND modinuse = inuProducto
                AND 
                (
                    modicuap > 0 OR 
                    (
                        modicuap = 0 AND modisign != difesign
                    )
                )
            ) valor_fact,
            difevatd
            FROM diferido
            WHERE difenuse = inuProducto
            AND difeconc = inuConcepto
            AND difefein <= idtFecha
        );
        
    BEGIN
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        nuProductType := pkg_bcproducto.fnutipoproducto(inuProducto);

        -- Si el producto no se encuentra configurado en el parámetro, retorna 0
        IF INSTR(','||csbProductsType||',', ','||nuProductType||',') = 0 THEN
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
            RETURN 0;
        END IF;

        BEGIN
        
            if cusaldoDeuda%isopen then
                close cusaldoDeuda;
            end if;
            
            nuSaldDeuda := null;
            open cusaldoDeuda;
            fetch cusaldoDeuda into nuSaldDeuda;
            close cusaldoDeuda;
       
        EXCEPTION
            WHEN OTHERS THEN
                RETURN 0;
        END;

      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

      RETURN nvl(nuSaldDeuda,0);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;    
    END fnuObtDeudDifxConcepto;

    /*****************************************************************
    Propiedad intelectual de Gascaribe-Efigas.

    Unidad         : fnuObtieneMotivo
    Descripcion    : Función para obtener el id del motivo principal
    Autor          : KCienfuegos
    Fecha          : 12-01-2017
    Caso           : CA200-955

    Parámetros           Descripción
    ============         ===================

    Historia de Modificaciones
    Fecha         Autor                         Modificacion
    ===============================================================
    12-01-2017    KCienfuegos.CA200-955         Creacion.
    ******************************************************************/
    FUNCTION fnuObtieneMotivo
    RETURN mo_motive.motive_id%TYPE
    IS
        csbMT_NAME    VARCHAR2(100) := csbSP_NAME || 'fnuObtieneMotivo';
        nuError    		NUMBER;
        sbError    		VARCHAR2(32767);
    BEGIN
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
      RETURN gnuMotivo;
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;    
   END fnuObtieneMotivo;

    /*****************************************************************
    Propiedad intelectual de Gascaribe-Efigas.

    Unidad         : proInicializaVar
    Descripcion    : Metodo para inicializar variables
    Autor          : KCienfuegos
    Fecha          : 12-01-2017
    Caso           : CA200-955

    Parámetros           Descripción
    ============         ===================
    onuCodigoError       Codigo de Error
    osbMensajeError      Mensaje de Error

    Historia de Modificaciones
    Fecha         Autor                         Modificacion
    ===============================================================
    26-07-2024    jcatuche                      OSF-2996:Se cambia inicializador de variables de error
    19-09-2019    Eceron.Caso58                 Se modifica para que tenga en cuenta todos
                                                los productos del contrato que sean del tipo
                                                asociado al parametro LD_PROD_TYPE_ESTADO_CUENTA
    12-01-2017    KCienfuegos.CA200-955         Creacion.
    ******************************************************************/
    PROCEDURE proInicializaVar(onuCodigoError       OUT    NUMBER,
                               osbMensajeError      OUT    VARCHAR2)
    IS
        csbMT_NAME    VARCHAR2(100) := csbSP_NAME || 'proInicializaVar';
        
    BEGIN
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        pkg_error.prInicializaError(onuCodigoError,osbMensajeError);
      
        SELECT 
        CAST
            (
                MULTISET 
                (
                    select  /*+ index (mo_motive IDX_MO_MOTIVE_02)
                            index (pr_product IDX_PR_PRODUCT_010)*/
                    pr_product.product_id
                    from    pr_product, mo_motive
                    where   mo_motive.subscription_id = pr_product.subscription_id
                    and     mo_motive.package_id = gnuSolicitud
                    and     pr_product.product_type_id IN 
                    (
                        (
                            SELECT column_value
                            FROM TABLE(ldc_boutilities.SPLITstrings(csbProductsType, ','))
                        )
                    )
                ) as pr_tytbproduct
            )
        INTO gtbProductos
        FROM DUAL;
        
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(onuCodigoError, osbMensajeError);
            pkg_traza.trace('sbError: ' || osbMensajeError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(onuCodigoError, osbMensajeError);
            pkg_traza.trace('sbError: ' || osbMensajeError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;    
   END proInicializaVar;

    /*****************************************************************
    Propiedad intelectual de Gascaribe-Efigas.

    Unidad         : proImprimeCertificado
    Descripcion    : Metodo para imprimir el certificado de estado de deuda por producto
    Autor          : KCienfuegos
    Fecha          : 12-01-2017
    Caso           : CA200-955

    Parámetros           Descripción
    ============         ===================
    inuSolicitud         Solicitud
    onuCodigoError       Codigo de Error
    osbMensajeError      Mensaje de Error

    Historia de Modificaciones
    Fecha         Autor                         Modificacion
    ===============================================================
    12-01-2017    KCienfuegos.CA200-955         Creacion.
    26-07-2024    jcatuche                      OSF-2996: Se elimina aplica entrega para req CRM_SAC_KCM_200955_3. Aplica actualmente
    ******************************************************************/
    PROCEDURE proImprimeCertificado(inuSolicitud         IN     mo_packages.package_id%TYPE,
                                    onuCodigoError       OUT    NUMBER,
                                    osbMensajeError      OUT    VARCHAR2)
    IS
        csbMT_NAME      	VARCHAR2(100) := csbSP_NAME || 'proImprimeCertificado';
    BEGIN

        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        gnuSolicitud := inuSolicitud;
        proInicializaVar(onuCodigoError, osbMensajeError);

        proImprimeCertificadoAFecha(inuSolicitud, onuCodigoError, osbMensajeError);
        

        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(onuCodigoError, osbMensajeError);
            pkg_traza.trace('sbError: ' || osbMensajeError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(onuCodigoError, osbMensajeError);
            pkg_traza.trace('sbError: ' || osbMensajeError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;    
    END proImprimeCertificado;

    /*****************************************************************
    Propiedad intelectual de Gascaribe-Efigas.

    Unidad         : proImprimeCertificado
    Descripcion    : Metodo para imprimir el certificado de estado de deuda por producto
    Autor          : KCienfuegos
    Fecha          : 12-01-2017
    Caso           : CA200-955

    Parámetros           Descripción
    ============         ===================
    inuSolicitud         Solicitud
    onuCodigoError       Codigo de Error
    osbMensajeError      Mensaje de Error

    Historia de Modificaciones
    Fecha         Autor                         Modificacion
    ===============================================================
    12-01-2017    KCienfuegos.CA200-955         Creacion.
    ******************************************************************/
    PROCEDURE proImprimeCertificadoAFecha(inuSolicitud         IN     mo_packages.package_id%TYPE,
                                          onuCodigoError       OUT    NUMBER,
                                          osbMensajeError      OUT    VARCHAR2)
    IS
        csbMT_NAME      	VARCHAR2(100) := csbSP_NAME || 'proImprimeCertificadoAFecha';

       rcConfexme                  pktbled_confexme.cued_confexme%rowtype;
       clData                      CLOB;
       nuFormato                   ed_formato.formcodi%type;
    BEGIN

      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

      gnuMotivo := mo_bopackages.fnugetinitialmotive(inuSolicitud);

      pkbced_confexme.obtieneregistro(cnuConfexme, rcConfexme);

      pkbodataextractor.instancebaseentity(inuSolicitud, 'LDC_FECH_ESTAD_DEU_PROD', pkconstante.verdadero);

      nuFormato := pkbced_formato.fnugetformcodibyiden(rcconfexme.coempada);

      pkbodataextractor.executerules(nuFormato, clData);

      pkboed_documentmem.setfileintemp(TRUE);

      pkboed_documentmem.setexecutefile(TRUE);

      id_bogeneralprinting.setisdatafromfile(FALSE);

      pkboed_documentmem.settemplate(rcconfexme.coempadi);

      pkboed_documentmem.set_printdocid(inuSolicitud);

      pkboed_documentmem.set_printdoc(clData);

      pkboed_documentmem.setbasicdataexme(NULL, 'EstadoDeuda-'||inuSolicitud);

      ge_boiopenexecutable.setonevent(csbEjecutableImpresion, 'POST_REGISTER');

      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(onuCodigoError, osbMensajeError);
            pkg_traza.trace('sbError: ' || osbMensajeError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(onuCodigoError, osbMensajeError);
            pkg_traza.trace('sbError: ' || osbMensajeError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;     
    END proImprimeCertificadoAFecha;

    /*****************************************************************
    Propiedad intelectual de Gascaribe-Efigas.

    Unidad         : proObtieneDeudaDiferida
    Descripcion    : Metodo para obtener la deuda diferida
    Autor          : KCienfuegos
    Fecha          : 12-01-2017
    Caso           : CA200-955

    Parámetros           Descripción
    ============         ===================
    orfcursor            cursor referenciado con los datos de la deuda diferida

    Historia de Modificaciones
    Fecha         Autor                         Modificacion
    ===============================================================
    26-07-2024    jcatuche                      OSF-2996: Se ajusta validación de saldo teniendo en cuenta los movimientos con signos contrarios
                                                por la insolvencia y los movimientos modicuap 0 por errores de migración
	21-03-2020	  eceron.58_8					Se realiza ajuste en la consulta para que ordene por criterios diferentes
    12-01-2017    KCienfuegos.CA200-955         Creacion.
    ******************************************************************/
    PROCEDURE proObtieneDeudaDiferida(orfcursor OUT constants_per.tyrefcursor)
      IS

      sbProceso             VARCHAR2(500) := 'proObtieneDeudaDiferida';
      csbMT_NAME      	VARCHAR2(100) := csbSP_NAME || 'proObtieneDeudaDiferida';
      dtFechaDeuda          DATE;
      nuError    		NUMBER;
      sbError    		VARCHAR2(32767);
    BEGIN

      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

      dtFechaDeuda := api_obtenervalorinstancia('LDC_FECH_ESTAD_DEU_PROD', 'FECHA_DEUDA');

      pkg_traza.trace('dtFechaDeuda ' || dtFechaDeuda, pkg_traza.cnuNivelTrzDef);

		/*********************************
		Codigo: Inicio ajuste del caso 58_8
		Autor: eceron
		Fecha: 21/03/2020
		Descripcion: Se realiza el ajuste a la consulta para que ordene por criterios diferentes
		**********************************/
        OPEN orfcursor FOR
          SELECT DIFERIDO,
                 PRODUCTO,
                 TIPO_PRODUCTO,
                 CONCEPTO,
                 DESC_CONCEPTO,
                 NUM_FINAN,
                 to_char(FECHA_ING,'DD/MM/YYYY')FECHA_ING,
                 CUOT_PACT,
                 CUOT_CANC,
                 (cuot_pact - cuot_canc) CUOT_PEND,
                 valor_ini,
                 (valor_ini - valor_fact) SALD_PEND

            FROM (SELECT /*+ leading (products)
                                     index (a IX_DIFE_NUSE)
                                     use_nl(products a b c d)
                                  */
                   a.difecodi diferido,
                   a.difenuse producto,
                   c.servdesc tipo_producto,
                   a.difeconc concepto,
                   d.concdesc desc_concepto,
                   a.difecofi num_finan,
                   a.difefein fecha_ing,
                   a.difenucu cuot_pact,
                   (SELECT nvl(max(modicuap), 0)
                      FROM movidife
                     WHERE modifech <= dtFechaDeuda
                       AND modisign <> difesign
                       AND modidife = difecodi
                       AND modisign = 'CR') cuot_canc,
                   a.difevatd valor_ini,
                   (
                    SELECT nvl(SUM(case modisign when 'DB' then -MODIVACU else MODIVACU end), 0)
                    FROM movidife
                    WHERE modifech <= dtFechaDeuda
                    AND modidife = difecodi
                    AND (modicuap > 0 OR (modicuap = 0 AND modisign != difesign))
                   ) valor_fact
                    FROM
                         diferido a,
                         servsusc b,
                         servicio c,
                         concepto d,
                         TABLE(CAST(gtbProductos AS pr_tytbproduct)) products
                   WHERE products.product_id = a.difenuse
                     AND a.difetire = 'D'
                     AND a.difenuse = b.sesunuse
                     AND b.sesuserv = c.servcodi
                     AND a.difeconc = d.conccodi
                     AND a.difefein <= dtFechaDeuda)
                     WHERE (valor_ini - valor_fact)>0
                  ORDER BY NUM_FINAN asc, FECHA_ING asc;
					/*Fin ajuste 58_8*/
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;     
    END;

    /*****************************************************************
    Propiedad intelectual de Gascaribe-Efigas.

    Unidad         : proObtieneDeudaCorriente
    Descripcion    : Metodo para obtener la deuda corriente
    Autor          : KCienfuegos
    Fecha          : 12-01-2017
    Caso           : CA200-955

    Parámetros           Descripción
    ============         ===================
    orfcursor            cursor referenciado con los datos de la deuda corriente

    Historia de Modificaciones
    Fecha         Autor                         Modificacion
    ===============================================================
    14-06-2024    jcatuche                      OSF-2830: Se realiza ajuste al cursor cuSaldDiferido para obtener la información
                                                correcta en casos de movimientos de diferidos mal migrados [dos movimientos modicuap 0]
    31-05-2024    felipe.valencia               OSF-2762: Se realiza modificación del cursor para
                                                totalizar CR y DB
    19-09-2019    Eceron.Caso58                 Se modifica el cursor cuSaldDiferido para adicionar
                                                el id del producto
                                                Se adiciona el id del producto en la tabla tytbObCartCorrConcepto
    12-01-2017    KCienfuegos.CA200-955         Creacion.
    ******************************************************************/
    PROCEDURE proObtieneDeudaCorriente(orfcursor OUT constants_per.tyrefcursor)
      IS

      csbMT_NAME      	VARCHAR2(100) := csbSP_NAME || 'proObtieneDeudaCorriente';
      nuError    		NUMBER;
      sbError    		VARCHAR2(32767);
      sbIndex                           VARCHAR2(40);
      dtFechaDeuda                      DATE;
      nuProducto                        pr_product.product_id%TYPE;
      nuTipoProducto                    servicio.servcodi%TYPE;
      tbProductos                       dapr_product.tytbproduct_id;
      ocrResumenCartera                 constants_per.tyrefcursor;
      ocrDetalleCartera                 constants_per.tyrefcursor;
      onuTotalCartCorriente             NUMBER;
      onuTotalCartDiferida              NUMBER;
      onuSaldoAFavor                    NUMBER;
      onuValorEnReclamo                 NUMBER;
      onuValorDifReclamo                NUMBER;
      tbCarteraCorriente                tytbCarteraCorriente;
      tbCarteraCorrienteDest            tytbCartCorrConcepto;
      tbobCarteraCorriente              tytbObCartCorrConcepto;
      obCarteraCorriente                tyobCartCorrConcepto;
      tbSaldDiferido                    tytbDiferidoConcepto;
      nuIndex                           PLS_INTEGER := 0;

      CURSOR cuSaldDiferido(inuProductId    in  diferido.difenuse%TYPE)
      IS
        SELECT
              difeconc,
              tipo_producto,
              SUM(valor_ini - valor_fact) sald_pend,
              MAX(DIFENUSE) product_id
          FROM (SELECT /*+ leading (products)
                                   index (a IX_DIFE_NUSE)
                                   use_nl(products a b c d)
                                */
                 a.difeconc,
                 b.sesuserv tipo_producto,
                 a.difevatd valor_ini,
                 a.DIFENUSE,
                 (SELECT abs(nvl(SUM(case modisign when 'CR' then -MODIVACU else modivacu end), 0))
                    FROM movidife
                   WHERE modifech <= dtFechaDeuda
                     AND (modicuap > 0 OR (modicuap = 0 AND modisign != difesign))
                     AND modidife = difecodi
                  ) valor_fact
                  FROM /*+ CC_BOCertAccountDetail.GetDifeBalaDetail  */
                       diferido a,
                       servsusc b,
                       concepto d,
                       TABLE(CAST(gtbProductos AS pr_tytbproduct)) products
                 WHERE products.product_id = a.difenuse
                   AND a.difenuse = inuProductId
                   AND a.difetire = 'D'
                   AND a.difenuse = b.sesunuse
                   AND a.difeconc = d.conccodi
                   AND a.difefein <= dtFechaDeuda)
                GROUP BY tipo_producto, difeconc;

        CURSOR cuProducts
        IS
            select  /*+ index (mo_motive IDX_MO_MOTIVE_02)
                        index (pr_product IDX_PR_PRODUCT_010)*/
                    pr_product.product_id
            from    pr_product, mo_motive
            where   mo_motive.subscription_id = pr_product.subscription_id
            and     mo_motive.package_id = gnuSolicitud;


    BEGIN

      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

      trc('INICIO ' || csbPaquete || '.' || csbMT_NAME);
      dtFechaDeuda := api_obtenervalorinstancia('LDC_FECH_ESTAD_DEU_PROD', 'FECHA_DEUDA');

      IF (cuProducts%ISOPEN) THEN
          CLOSE cuProducts;
      END IF;

      OPEN cuProducts;
      FETCH cuProducts BULK COLLECT INTO tbProductos;
      CLOSE cuProducts;

      IF tbProductos.count > 0 THEN
          FOR i in tbProductos.FIRST .. tbProductos.LAST LOOP

            nuProducto := tbProductos(i);
            nuTipoProducto := pkg_bcproducto.fnutipoproducto(nuProducto);

            fa_boaccountstatustodate.productaccountstatustodate(inuproductid => nuProducto,
                                                                idtdate => dtFechaDeuda,
                                                                onucurrentaccounttotal => onuTotalCartCorriente,
                                                                onudeferredaccounttotal => onuTotalCartDiferida,
                                                                onucreditbalance => onuSaldoAFavor,
                                                                onuclaimvalue => onuValorEnReclamo,
                                                                onudefclaimvalue => onuValorDifReclamo,
                                                                orfresumeaccountdetail => ocrResumenCartera,
                                                                orfaccountdetail => ocrDetalleCartera);

            FETCH ocrDetalleCartera BULK COLLECT INTO tbCarteraCorriente;

            IF (tbCarteraCorriente.count>0) THEN

               FOR indx IN tbCarteraCorriente.FIRST .. tbCarteraCorriente.LAST LOOP
                 --sbIndex := nuTipoProducto||'_'||tbCarteraCorriente(indx).conccodi;
				 sbIndex := nuProducto||'_'||nuTipoProducto||'_'||tbCarteraCorriente(indx).conccodi;
                 tbCarteraCorrienteDest(sbIndex).product_id := nuProducto;
                 tbCarteraCorrienteDest(sbIndex).tipo_producto := nuTipoProducto;
                 tbCarteraCorrienteDest(sbIndex).conccodi :=  tbCarteraCorriente(indx).conccodi;
                 tbCarteraCorrienteDest(sbIndex).concdesc :=  tbCarteraCorriente(indx).concdesc;
                 tbCarteraCorrienteDest(sbIndex).deuda_fecha :=  nvl(tbCarteraCorriente(indx).saldran0,0);
                 tbCarteraCorrienteDest(sbIndex).deuda_30 :=  nvl(tbCarteraCorriente(indx).saldran1,0);
                 tbCarteraCorrienteDest(sbIndex).deuda_60 :=  nvl(tbCarteraCorriente(indx).saldran2,0);
                 tbCarteraCorrienteDest(sbIndex).deuda_90 :=  nvl(tbCarteraCorriente(indx).saldran3,0);
                 tbCarteraCorrienteDest(sbIndex).deuda_mas90 :=  nvl(tbCarteraCorriente(indx).saldran4,0)+
                                                                 nvl(tbCarteraCorriente(indx).saldran5,0)+
                                                                 nvl(tbCarteraCorriente(indx).saldran6,0);

                 --Se calcula saldo total de deuda en corriente  por concepto
                 tbCarteraCorrienteDest(sbIndex).sald_deud_corr := tbCarteraCorrienteDest(sbIndex).deuda_fecha +
                                                                   tbCarteraCorrienteDest(sbIndex).deuda_30+
                                                                   tbCarteraCorrienteDest(sbIndex).deuda_60+
                                                                   tbCarteraCorrienteDest(sbIndex).deuda_90+
                                                                   tbCarteraCorrienteDest(sbIndex).deuda_mas90;

                 --Se obtiene total en deuda diferida por concepto
                 tbCarteraCorrienteDest(sbIndex).sald_deud_dif := fnuObtDeudDifxConcepto(nuProducto,
                                                                                         tbCarteraCorriente(indx).conccodi,
                                                                                         dtFechaDeuda);
                 nuIndex := nuIndex + 1;
               END LOOP;
            END IF;
          END LOOP;
      END IF;

      IF tbProductos.count > 0 THEN
          FOR i in tbProductos.FIRST .. tbProductos.LAST LOOP

              IF (cuSaldDiferido%ISOPEN) THEN
                CLOSE cuSaldDiferido;
              END IF;

              OPEN cuSaldDiferido(tbProductos(i));
              FETCH cuSaldDiferido
                BULK COLLECT INTO tbSaldDiferido;
              CLOSE cuSaldDiferido;

              IF(tbSaldDiferido.count >0)THEN
                 FOR dif IN tbSaldDiferido.FIRST .. tbSaldDiferido.LAST LOOP
                   --sbIndex :=tbSaldDiferido(dif).tipo_producto||'_'||tbSaldDiferido(dif).conccodi;
				   sbIndex :=tbSaldDiferido(dif).product_id||'_'||tbSaldDiferido(dif).tipo_producto||'_'||tbSaldDiferido(dif).conccodi;

                   IF(tbCarteraCorrienteDest.exists(sbIndex))THEN
                     continue;
                   ELSE
                     tbCarteraCorrienteDest(sbIndex).product_id := tbSaldDiferido(dif).product_id;
                     tbCarteraCorrienteDest(sbIndex).tipo_producto := tbSaldDiferido(dif).tipo_producto;
                     tbCarteraCorrienteDest(sbIndex).conccodi :=  tbSaldDiferido(dif).conccodi;
                     tbCarteraCorrienteDest(sbIndex).concdesc :=  pktblconcepto.fsbgetconcdesc(tbSaldDiferido(dif).conccodi);
                     tbCarteraCorrienteDest(sbIndex).deuda_fecha := 0;
                     tbCarteraCorrienteDest(sbIndex).deuda_30 := 0;
                     tbCarteraCorrienteDest(sbIndex).deuda_60 := 0;
                     tbCarteraCorrienteDest(sbIndex).deuda_90 := 0;
                     tbCarteraCorrienteDest(sbIndex).deuda_mas90 := 0;
                     tbCarteraCorrienteDest(sbIndex).sald_deud_corr := 0;
                     tbCarteraCorrienteDest(sbIndex).sald_deud_dif := nvl(tbSaldDiferido(dif).sald_diferido,0);
                   END IF;
                 END LOOP;

              END IF;
        END LOOP;
      END IF;

      IF(tbCarteraCorrienteDest.count >0)THEN
        IF(tbobCarteraCorriente IS NULL)THEN
          tbobCarteraCorriente := tytbObCartCorrConcepto();
        ELSE
          tbobCarteraCorriente.delete;
        END IF;
         sbIndex := tbCarteraCorrienteDest.first;

         LOOP
           EXIT WHEN sbIndex IS NULL;
           obCarteraCorriente := tyobCartCorrConcepto(tbCarteraCorrienteDest(sbIndex).product_id,
                                                      tbCarteraCorrienteDest(sbIndex).tipo_producto,
                                                      tbCarteraCorrienteDest(sbIndex).conccodi,
                                                      tbCarteraCorrienteDest(sbIndex).concdesc,
                                                      tbCarteraCorrienteDest(sbIndex).deuda_fecha,
                                                      tbCarteraCorrienteDest(sbIndex).deuda_30,
                                                      tbCarteraCorrienteDest(sbIndex).deuda_60,
                                                      tbCarteraCorrienteDest(sbIndex).deuda_90,
                                                      tbCarteraCorrienteDest(sbIndex).deuda_mas90,
                                                      tbCarteraCorrienteDest(sbIndex).sald_deud_corr,
                                                      tbCarteraCorrienteDest(sbIndex).sald_deud_dif);
          tbobCarteraCorriente.extend;
          tbobCarteraCorriente(tbobCarteraCorriente.last) := obCarteraCorriente;
          sbIndex := tbCarteraCorrienteDest.next(sbIndex);
         END LOOP;
      END IF;

      OPEN orfcursor FOR
        SELECT product_id producto,
               TIPO_PRODUCTO,
               pktblservicio.fsbgetdescription(tipo_producto) TIPO_PROD_DESC,
               CONCCODI,
               CONCDESC,
               DEUDA_FECHA,
               DEUDA_30,
               DEUDA_60,
               DEUDA_90,
               DEUDA_MAS90,
               SALD_DEUD_CORR,
               SALD_DEUD_DIF,
               (nvl(sald_deud_corr,0) + nvl(sald_deud_dif,0)) SALD_DEUD_TOT
         FROM TABLE(CAST(tbobCarteraCorriente AS tytbObCartCorrConcepto)) cartera
         WHERE (DEUDA_FECHA <> 0 OR
         DEUDA_30 <> 0 OR
         DEUDA_60 <> 0 OR
         DEUDA_90 <> 0 OR
         SALD_DEUD_CORR <> 0 OR
         SALD_DEUD_DIF <> 0)
         ORDER by tipo_producto, conccodi;

      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error; 
    END proObtieneDeudaCorriente;

    /*****************************************************************
    Propiedad intelectual de Gascaribe-Efigas.

    Unidad         : fnuGetProdBySubs
    Descripcion    : Obtiene el identificador del primer producto asociado al contrato
    Autor          : Eduardo Ceron
    Fecha          : 19-09-2019
    Caso           : 58

    Parámetros           Descripción
    ============         ===================
        inuSubscriberId  Identificador del contrato

    Historia de Modificaciones
    Fecha         Autor                         Modificacion
    ===============================================================
    19-09-2019    Eceron.Caso58                 Creacion.
    ******************************************************************/
    FUNCTION fnuGetProdBySubs
    (
        inuSubscriberId     IN      pr_product.subscription_id%TYPE
    )
    RETURN pr_product.product_id%TYPE
    IS
        csbMT_NAME      	VARCHAR2(100) := csbSP_NAME || 'fnuGetProdBySubs';
        nuError    		NUMBER;
        sbError    		VARCHAR2(32767);
        nuProductId     pr_product.product_id%TYPE;

        CURSOR cuProduct
        IS
            SELECT  pr_product.product_id
            FROM    pr_product
            WHERE   pr_product.subscription_id = inuSubscriberId;

    BEGIN
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('Inicia '||csbPaquete||'.'||csbMT_NAME||' - inuSubscriberId: '||inuSubscriberId, pkg_traza.cnuNivelTrzDef);

        IF cuProduct%ISOPEN THEN
           CLOSE cuProduct;
        END IF;

        OPEN cuProduct;
        FETCH cuProduct INTO nuProductId;
        CLOSE cuProduct;

        pkg_traza.trace('Fin '||csbPaquete||'.'||csbMT_NAME||' - nuProductId: '||nuProductId, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        RETURN nuProductId;

    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;     
    END fnuGetProdBySubs;

END LDC_BOCERTIFICADO_ESTDEUDA;
/
BEGIN
	pkg_utilidades.prAplicarPermisos(upper('LDC_BOCERTIFICADO_ESTDEUDA'), 'OPEN');
END;
/