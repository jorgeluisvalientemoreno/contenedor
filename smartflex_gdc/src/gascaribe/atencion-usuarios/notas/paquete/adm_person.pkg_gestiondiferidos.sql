CREATE OR REPLACE PACKAGE adm_person.pkg_gestiondiferidos IS
/***************************************************************************
<Package Fuente="Propiedad Intelectual de Gases del Caribe">
<Unidad> adm_person.pkg_gestiondiferidos </Unidad>
<Autor>  Lubin Pineda </Autor>
<Fecha> 15-11-2023 </Fecha>
<Descripcion>
    Paquete con los objetos del negocio para manejo de diferidos
</Descripcion>
<Historial>
    <Modificacion Autor="jcatuche" Fecha="09-05-2024" Inc="OSF-2467">
        Se ajusta pSimfinanciarconceptosfactura
    </Modificacion>
	<Modificacion Autor="jpinedc" Fecha="15-11-2023" Inc="OSF-1887">
        Creación
    </Modificacion>    
</Historial>
</Package>
***************************************************************************/

    -- Retona la última WO que hizo cambios en el paquete
    FUNCTION fsbVersion RETURN VARCHAR2;

    -- Simula proyeccion de cuotas para validar las digitadas en MANOT
    PROCEDURE pSimProyCuotas
    (
        inuProducto     NUMBER,
        inuPlanId       NUMBER,
        inuNroCuotas    NUMBER,
        inuConcepto     NUMBER,
        inuValor        NUMBER
    );
    
END pkg_gestiondiferidos;
/

CREATE OR REPLACE PACKAGE BODY adm_person.pkg_gestiondiferidos IS

    -- Identificador de la última WO que hizo cambios en el paquete
    csbVersion                 VARCHAR2(15) := 'OSF-2467';

    -- Constantes para el control de la traza
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza   CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    nuerror         number;
    sberror         varchar2(2000);
    
                                                   
    /***************************************************************************
    <Procedure Fuente="Propiedad Intelectual de Gases del Caribe">
    <Unidad> fsbVersion </Unidad>
    <Descripcion>
        Retona la última WO que hizo cambios en el paquete 
    </Descripcion>
    <Autor> Lubin Pineda - MVM </Autor>
    <Fecha> 15-11-2023 </Fecha>
    <Historial>
    <Modificacion Autor="jpinedc" Fecha="15-11-2023" Inc="OSF-1887">
        Creación
    </Modificacion>
    </Historial>
    </Procedure>
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
        
    /***************************************************************************
    <Procedure Fuente="Propiedad Intelectual de Gases del Caribe">
    <Unidad> pSimFactConcepto </Unidad>
    <Descripcion>
        Inserta  factura, cuenta y concepto para simulación de financiación
    </Descripcion>
    <Autor> Lubin Pineda - MVM </Autor>
    <Fecha> 15-11-2023 </Fecha>
    <Parametros>
        <param nombre="inuProducto" tipo="NUMBER" Direccion="IN" >Identificador del producto</param>
        <param nombre="inuConcepto" tipo="NUMBER" Direccion="IN">Identificador del concepto</param>
        <param nombre="inuValor" tipo="NUMBER" Direccion="IN">Valor a financiar</param>
    </Parametros>
    <Historial>
    <Modificacion Autor="jpinedc" Fecha="15-11-2023" Inc="OSF-1887">
        Creación
    </Modificacion>
    </Historial>
    </Procedure>
    ***************************************************************************/    
    PROCEDURE pSimFactConcepto
    (
        inuProducto     NUMBER,
        inuConcepto     NUMBER,
        inuValor        NUMBER
    )    
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pSimFactConcepto';
        
        nuFactura           NUMBER  :=  -2;
        nuCuCoCodi          NUMBER  :=  -2;    
        nuPeriFact          factura.factpefa%TYPE;
        nuValAutPag         factura.factvaap%TYPE;
        dtFechGene          factura.factfege%TYPE;
        sbTerminal          factura.factterm%TYPE;
        nuUsuario           factura.factusua%TYPE;
        nuFactProg          factura.factprog%TYPE;  
        
        nuCuCoVaTo          NUMBER;   
        nuCuCoVaFa          NUMBER;
        nuCuCoImFa          NUMBER; 
        
        rcServsusc          servsusc%ROWTYPE;
        rcPeFaActu          perifact%ROWTYPE;    
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
               
        rcServsusc          := pktblServSusc.frcGetRecord( inuProducto );
        
        pkBCPerifact.GETCURRPERIODBYCYCLE( rcServsusc.SeSuCicl, rcPeFaActu );
        
        nuPeriFact          := rcPeFaActu.PeFaCodi;
        nuValAutPag         := 0;
        dtFechGene          := rcPeFaActu.pefafimo + 15;
        sbTerminal          := PKG_SESSION.FSBGETTERMINAL;
        nuUsuario           := PKG_SESSION.GETUSERID;
        nuFactProg          := 700; -- FINAN          

        --Inserta factura dummy
        pkg_factura.prInsertaFactura
        (
            nuFactura,
            rcServsusc.sesususc,
            nuPeriFact,
            nuValAutPag,
            dtFechGene,
            sbTerminal,
            nuUsuario,
            nuFactProg
        );

        nuCuCoVaTo          := inuValor;  
        nuCuCoVaFa          := inuValor;
        nuCuCoImFa          := 0; 
              
        --Inserta cuenta dummy  
        pkg_cuencobr.prInsertaCuenta
        (
            nuCuCoCodi          ,
            rcServsusc.SeSuPlFa ,
            rcServsusc.SeSuCate ,
            rcServsusc.SeSuSuCa ,
            0                   ,
            0                   ,
            nuCuCoVaTo          ,
            inuProducto         ,    
            nuFactura           ,
            dtFechGene + 30     ,
            nuCuCoVaFa          ,
            nuCuCoImFa          
        );
            
        --Inserta cargo para simulación
        pkg_cargos.prInsertaCargo
        (
            nuCuCoCodi  ,
            inuProducto ,
            'DB'        ,
            inuConcepto ,
            inuValor    ,
            inuValor    ,            
            rcPeFaActu.PeFaCodi,
            dtFechGene - 5,
            nuFactProg  ,
            15          ,
            '-'         ,
            -2          ,
            nuUsuario   ,
            'A'  
        );

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);        
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);     
            RAISE pkg_error.Controlled_Error;                
    END pSimFactConcepto;
    
    /***************************************************************************
    <Procedure Fuente="Propiedad Intelectual de Gases del Caribe">
    <Unidad> pSimfinanciarconceptosfactura </Unidad>
    <Descripcion>
        Simula financiación
    </Descripcion>
    <Autor> Lubin Pineda - MVM </Autor>
    <Fecha> 15-11-2023 </Fecha>
    <Parametros>
        <param nombre="inuNumProdsFinanc" tipo="NUMBER" Direccion="IN" >Numero de productos a financiar</param>
        <param nombre="inuFactura" tipo="NUMBER" Direccion="IN">Codigo de Factura a Financiar</param>
        <param nombre="inuPlanId" tipo="NUMBER" Direccion="IN">Codigo del Plan</param>
        <param nombre="inuMetodo" tipo="NUMBER" Direccion="IN">Metodo de calculo de la cuota</param>
        <param nombre="inuDifeNucu" tipo="NUMBER" Direccion="IN">Numero de cuotas</param>
        <param nombre="isbDocuSopo" tipo="VARCHAR2" Direccion="IN">Documento soporte</param>
        <param nombre="isbDifeProg" tipo="VARCHAR2" Direccion="IN">Programa que ejecuta la financiacion</param>
        <param nombre="onuAcumCuota" tipo="NUMBER" Direccion="OUT">Acumulado Cuota</param>
        <param nombre="onuSaldo" tipo="NUMBER" Direccion="OUT">Saldo</param>
        <param nombre="onuTotalAcumCapital" tipo="NUMBER" Direccion="OUT">Total Capital</param>
        <param nombre="onuTotalAcumCuotExtr" tipo="NUMBER" Direccion="OUT">Total Acumulado Extra</param>
        <param nombre="onuTotalAcumInteres" tipo="NUMBER" Direccion="OUT">Total Acumulado Interes</param>
        <param nombre="osbRequiereVisado" tipo="VARCHAR2" Direccion="OUT">Requiere Visado</param>
        <param nombre="onuDifeCofi" tipo="NUMBER" Direccion="OUT">Código Financiación</param>
    </Parametros>
    <Historial>
    <Modificacion Autor="jcatuche" Fecha="09-05-2024" Inc="OSF-2467">
        Se adiciona llamado a borrado de registros en memoria para factura y cuentas,
        permite la ejecución consecutiva en la misma sesión para la misma factura -2 con diferentes condiciones a financiar
    </Modificacion>
    <Modificacion Autor="jpinedc" Fecha="15-11-2023" Inc="OSF-1887">
        Creación
    </Modificacion>
    </Historial>
    </Procedure>
    ***************************************************************************/    
    PROCEDURE pSimfinanciarconceptosfactura
    (
        inuNumProdsFinanc       IN    number,                 --Numero de productos a financiar
        inuFactura              IN    factura.factcodi%TYPE,  --Codigo de Factura a Financiar
        -- Plan de Acuerdo de Pago
        inuPlanId               IN    plandife.pldicodi%TYPE, --Codigo del Plan
        inuMetodo               IN    plandife.pldimccd%TYPE, --Metodo de calculo de la cuota
        inuDifeNucu             IN    plandife.pldicuma%TYPE, --Numero de cuotas
        isbDocuSopo             IN    diferido.difenudo%TYPE, --Documento soporte
        isbDifeProg             IN    diferido.difeprog%TYPE, --Programa que ejecuta la financiacion
        -- Variables de salida del proceso de financiacion
        onuAcumCuota            OUT   number,
        onuSaldo                OUT   number,
        onuTotalAcumCapital     OUT   number,
        onuTotalAcumCuotExtr    OUT   number,
        onuTotalAcumInteres     OUT   number,
        osbRequiereVisado       OUT   varchar2,
        onuDifeCofi             OUT   number
    )
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pSimfinanciarconceptosfactura';
            
        nuNumProdsFinanc            number := inuNumProdsFinanc;
		nuInteRate		            diferido.difeinte%TYPE;	-- Porcentaje de interes del diferido
        nuQuotaMethod	            diferido.difemeca%TYPE;	-- Metodo de calculo de la cuota del diferido
        nuTaincodi	                plandife.plditain%TYPE;	-- Codigo Tasa Interes
        boSpread                    boolean;
        sbErrMsg                    varchar2(10000);

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        pkg_traza.trace('nuNumProdsFinanc|'|| nuNumProdsFinanc, csbNivelTraza);
        pkg_traza.trace('inuFactura|'|| inuFactura, csbNivelTraza);
        
        --Limpia información de factura y cuenta en cache 
        pktblFactura.clearmemory;
        pktblcuencobr.clearmemory;
        
        /* Se realiza validacion sobre el saldo pendiente de la factura */
        if( pkBCAccountStatus.fnuGetBalance( inuFactura ) = pkBillConst.CERO )then
            pkg_traza.trace('pkBCAccountStatus.fnuGetBalance( inuFactura ) = pkBillConst.CERO', csbNivelTraza);
            return;
        end if;

        -- Se asigna el consecutivo de financiacion
        onuDifeCofi  := -2;

        -- Se instancian en la tabla temporal de saldos por concepto, los
        -- conceptos de la factura
        CC_BOFinancing.SetAccountStatus( inuFactura, CONSTANTS_PER.CSBYES, CONSTANTS_PER.CSBNO, CONSTANTS_PER.CSBNO );

        pkg_traza.trace('Pasó SetAccountStatus', csbNivelTraza);

        -- Se actualiza la tabla temporal para que sean procesados solo los conceptos
        -- financiables
        CC_BCFinancing.SelectAllowedProducts( CONSTANTS_PER.CSBSI, nuNumProdsFinanc );
        
        pkg_traza.trace('Pasó SelectAllowedProducts', csbNivelTraza);        

        -- Se instancian en la tabla temporal de saldos por concepto, los
        -- descuentos de financiacion respectivos
        CC_BCFinancing.SetDiscount( inuPlanId );

        pkg_traza.trace('Pasó SetDiscount', csbNivelTraza);
        
        -- Obtiene tasa de interes
        pkDeferredPlanMgr.ValPlanConfig (inuPlanId,
                                         LDC_BOCONSGENERALES.FDTGETSYSDATE,
                                         nuQuotaMethod,
                                         nuTaincodi,
                                         nuInteRate,
                                         boSpread
                                         );

        pkg_traza.trace('Pasó ValPlanConfig', csbNivelTraza);
        
        -- Se ejecuta el proceso de financiacion
        CC_BOFinancing.ExecDebtFinanc
        (
            inuPlanId,
            inuMetodo,
            LDC_BOCONSGENERALES.FDTGETSYSDATE,
            nuInteRate,
            pkBillConst.CERO,
            inuDifeNucu,
            isbDocuSopo,
            pkBillConst.CIENPORCIEN,
            pkBillConst.CERO,
            CONSTANTS_PER.CSBNO,
            isbDifeProg,
            CONSTANTS_PER.CSBSI, 
            CONSTANTS_PER.CSBNO,
            onuDifeCofi,
            onuAcumCuota,
            onuSaldo,
            onuTotalAcumCapital,
            onuTotalAcumCuotExtr,
            onuTotalAcumInteres,
            osbRequiereVisado
        );
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    
    EXCEPTION
        when pkg_error.CONTROLLED_ERROR then
    	    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);        
            RAISE pkg_error.Controlled_Error;
        when OTHERS then
    	    pkg_error.seterror;
    	    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
    	    raise pkg_error.CONTROLLED_ERROR;
    END pSimfinanciarconceptosfactura;    
    
    /***************************************************************************
    <Procedure Fuente="Propiedad Intelectual de Gases del Caribe">
    <Unidad> pSimProyCuotas </Unidad>
    <Descripcion>
        Simulación de diferido al producto para el concepto, las cuotas, plan y valor a financiar
    </Descripcion>
    <Autor> Lubin Pineda - MVM </Autor>
    <Fecha> 15-11-2023 </Fecha>
    <Parametros>
        <param nombre="inuProducto" tipo="NUMBER" Direccion="IN" >Identificador del producto</param>
        <param nombre="inuPlanId" tipo="NUMBER" Direccion="IN">Identificador del Plan de financiación</param>
        <param nombre="inuNroCuotas" tipo="NUMBER" Direccion="IN">Número de cuotas a diferirr</param>
        <param nombre="inuConcepto" tipo="NUMBER" Direccion="IN">Identificador del concepto</param>
        <param nombre="inuValor" tipo="NUMBER" Direccion="IN">Valor a financiar</param>
    </Parametros>
    <Historial>
    <Modificacion Autor="jpinedc" Fecha="15-11-2023" Inc="OSF-1887">
        Creación
    </Modificacion>
    </Historial>
    </Procedure>
    ***************************************************************************/            
    PROCEDURE pSimProyCuotas
    (
        inuProducto     NUMBER,
        inuPlanId       NUMBER,
        inuNroCuotas    NUMBER,
        inuConcepto     NUMBER,
        inuValor        NUMBER
    )
    IS    
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'pSimProyCuotas';    
        
        nuFactura           NUMBER  :=  -2;
        
        nuMetodoCalculo     NUMBER;
        
        sbDifeProg          diferido.difeprog%TYPE;
        nuNroCuotas         NUMBER;
        nuSaldo             NUMBER;
        nuTotalAcumCapital  NUMBER;
        nuTotalAcumCuotExtr NUMBER;
        nuTotalAcumInteres  NUMBER;
        sbRequiereVisado    VARCHAR2(1);
        nuDifeCofi          NUMBER;
        
        CURSOR cuConcepto
        IS
        SELECT concdife
        FROM concepto
        WHERE conccodi = inuConcepto;
        
        rcConcepto  cuConcepto%ROWTYPE;
        
        blSP_SimProyCuotas  BOOLEAN := FALSE;
        
        PROCEDURE pRollBackSP_SimProyCuotas
        IS
        BEGIN
        
            IF blsp_SimProyCuotas THEN
                ROLLBACK TO sp_SimProyCuotas;
                blsp_SimProyCuotas := FALSE;
            END IF;                
        
        END pRollBackSP_SimProyCuotas;
               
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        pkg_traza.trace('inuProducto    <= '||inuProducto, csbNivelTraza);
        pkg_traza.trace('inuPlanId      <= '||inuPlanId, csbNivelTraza);
        pkg_traza.trace('inuNroCuotas   <= '||inuNroCuotas, csbNivelTraza);
        pkg_traza.trace('inuConcepto    <= '||inuConcepto, csbNivelTraza);
        pkg_traza.trace('inuValor       <= '||inuValor, csbNivelTraza);  
           
        OPEN cuConcepto;
        FETCH cuConcepto INTO rcConcepto;
        CLOSE cuConcepto;

        IF rcConcepto.ConcDife = 'S' THEN
            
            SAVEPOINT sp_SimProyCuotas;
            
            blsp_SimProyCuotas := TRUE;
            
            pSimFactConcepto
            (
                inuProducto ,
                inuConcepto ,
                inuValor
            );
                
            nuMetodoCalculo     := pktblplandife.fnugetpldimccd(inuPlanId);
            sbDifeProg          := 'FINAN';        

            pSimfinanciarconceptosfactura
            (
                inunumprodsfinanc    => inuProducto, --
                inufactura           => nuFactura, --
                inuplanid            => inuPlanId, --
                inumetodo            => nuMetodoCalculo, --
                inudifenucu          => inuNroCuotas, --
                isbdocusopo          => '-', --
                isbdifeprog          => sbDifeProg, --
                onuacumcuota         => nuNroCuotas, --
                onusaldo             => nuSaldo, --
                onutotalacumcapital  => nuTotalAcumCapital, --
                onutotalacumcuotextr => nuTotalAcumCuotExtr, --
                onutotalacuminteres  => nuTotalAcumInteres, --
                osbrequierevisado    => sbRequiereVisado, --
                onudifecofi          => nudifecofi
            );
            
            pRollBackSP_SimProyCuotas;
            
        ELSE
            NULL;
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
                
        EXCEPTION
            WHEN pkg_Error.Controlled_Error THEN
                pRollBackSP_SimProyCuotas;
                pkg_Error.getError(nuerror,sberror);
                pkg_traza.trace('sbError: '||sbError,csbNivelTraza); 
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
                RAISE pkg_Error.Controlled_Error;   
            WHEN Others THEN
                pRollBackSP_SimProyCuotas;
                pkg_Error.setError; 
                pkg_Error.getError(nuerror,sberror);
                pkg_traza.trace('sbError: '||sbError,csbNivelTraza); 
                pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR); 
                RAISE pkg_Error.Controlled_Error; 
    END pSimProyCuotas;
                                                             
END pkg_gestiondiferidos;
/
Prompt Otorgando permisos sobre pkg_gestiondiferidos
BEGIN
    pkg_utilidades.prAplicarPermisos( 'pkg_gestiondiferidos', 'ADM_PERSON');
END;
/