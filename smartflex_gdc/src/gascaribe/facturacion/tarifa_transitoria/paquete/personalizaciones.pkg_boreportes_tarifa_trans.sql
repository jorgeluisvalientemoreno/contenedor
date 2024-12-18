CREATE OR REPLACE PACKAGE PERSONALIZACIONES.PKG_BOREPORTES_TARIFA_TRANS
IS
/**************************************************************************
    Propiedad intelectual de Gases del Caribe S.A (c).
            
    Nombre      :   PKG_BOREPORTES_TARIFA_TRANS
    Descripción :   Paquete de gestión reportes tarifa transitoria
    Autor       :   jcatuchemvm
    Fecha       :   25/10/2024
            
    Historial de Modificaciones
    ---------------------------------------------------------------------------
    Fecha         Autor         Descripcion
    =====         =======       ===============================================
    25/10/2024    jcatuche      OSF-3387: Creación del paquete 
***************************************************************************/
                
    --------------------------------------------
    -- Variables
    --------------------------------------------

    
    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------
    --Reporte de saldos y cobros de más por producto
    PROCEDURE prReporteSaldos;
    
    --Reporte liquidación tarifa transitoria por año, producto y cuenta
    PROCEDURE prReporteLiquidacion;
    
    --Borra registros de reportes
    PROCEDURE prBorraReportes;
    
    --Procesa cadena de Jobs
    PROCEDURE prProcesaCadena;
    
    --Inicia Cadena de Jobs
    PROCEDURE prIniCadena;
    
    --Finaliza Cadena de Jobs
    PROCEDURE prFinCadena;
    
    --Genra repores TT
    PROCEDURE prGenReporte(inuReporte in number);
    
    --Programa cadena de Jobs
    PROCEDURE prProgramaJob(onuError out number, osbError out varchar2, sbIntervalo in varchar2 default null);

END PKG_BOREPORTES_TARIFA_TRANS;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.PKG_BOREPORTES_TARIFA_TRANS
IS    
    -- Constantes para el control de la traza
    csbSP_NAME          CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT||'.';           -- Constante para nombre de objeto    
    csbNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;    -- Nivel de traza para este objeto. 
    csbInicio           CONSTANT VARCHAR2(4)        := pkg_traza.fsbINICIO;         -- Indica inicio de método
    csbFin              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN;            -- Indica Fin de método ok
    csbFin_Erc          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERC;        -- Indica fin de método con error controlado
    csbFin_Err          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERR;        -- Indica fin de método con error no controlado
    
    cnuLimit            CONSTANT NUMBER             := 10000;
    cnuSegundo          CONSTANT NUMBER             := 1/86400;
    csbSLDMS            CONSTANT REPORTES_TARIFA_TRANS.REPORTE%TYPE := 'SLDMS';     --Saldo de más por producto y cuenta
    csbSLDTT            CONSTANT REPORTES_TARIFA_TRANS.REPORTE%TYPE := 'SLDTT';     --Saldo tarifa transitoria por producto y cuenta
    csbSLDMA            CONSTANT REPORTES_TARIFA_TRANS.REPORTE%TYPE := 'SLDMA';     --Saldo de más agrupado
    csbSLDTA            CONSTANT REPORTES_TARIFA_TRANS.REPORTE%TYPE := 'SLDTA';     --Saldo tarifa transitoria agrupado
    csbLIQTT            CONSTANT REPORTES_TARIFA_TRANS.REPORTE%TYPE := 'LIQTT';     --Liquidación tarifa transitoria por producto, cuenta y año
    csbLIQTA            CONSTANT REPORTES_TARIFA_TRANS.REPORTE%TYPE := 'LIQTA';     --Liquidación tarifa transitoria agrupado

    -------------------------
    --  PRIVATE VARIABLES
    -------------------------
    nuError             NUMBER;
    sbError             VARCHAR2(2000);
    dtfechaRepo         DATE;
    nucantidadReg       NUMBER;
    
    type tyrcLocalidad is record
    (
        celocebe    LDCI_CENTBENELOCAL.celocebe%type,
        locacodi    ge_geogra_location.geograp_location_id%type, 
        locadesc    ge_geogra_location.description%type,
        depadesc    ge_geogra_location.description%type
    );

    type tytbLoccalidad is table of tyrcLocalidad index by varchar2(6);
    tbLocalidad  tytbLoccalidad;
    
    sbHash          varchar2(6);
    
    cursor cuProds(inusesu in number) is
    select /*+ index ( p IDX_CONCPRODMAR )*/ prttsesu dpttsesu,
    (
        select /*+ index ( s pk_pr_product ) use_nl ( s a ) 
        index ( a pk_ab_address ) use_nl ( a l) 
        index ( l pk_ge_geogra_location ) */ l.geograp_location_id 
        from pr_product s,ab_address a,ge_geogra_location l 
        where s.product_id = prttsesu 
        and a.address_id = s.address_id 
        and l.geograp_location_id = a.geograp_location_id
    ) locacodi
    from ldc_prodtatt p
    where 1 = 1
    and prttsesu > inusesu
    order by prttsesu;
    
    type tytbProds is table of cuProds%rowtype index by binary_integer;
    tbProds     tytbProds;
    nupivote    number;
    
    cursor cuTotalProds is
    select /*+ index ( p IDX_CONCPRODMAR )*/ count(*) total
    from ldc_prodtatt p
    where 1 = 1;
    
    -------------------------
    --   PRIVATE METHODS   
    -------------------------
    PROCEDURE prInicializar;
    PROCEDURE prAnalizaSaldos(inuloca in number,inusesu in number);
    PROCEDURE prReporteSalMasAgrupado;
    PROCEDURE prReporteSaldoAgrupado;
    PROCEDURE prAnalizaLiquidacion(isbano in varchar2, inuloca in number,inusesu in number);
    PROCEDURE prReporteLiqAgrupado;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prInicializar
    Descripcion     : Inicialización de variables y registros
    
    Parametros de Entrada 
    ====================     
    
    Parametros de Salida
    ====================
  
    Modificaciones  :
    Fecha           Autor               Modificación
    =========       =========           ====================
	25/10/2024      jcatuche            OSF-3387: Creación
    ***************************************************************************/
    PROCEDURE prInicializar IS
        csbMetodo   VARCHAR2(100) := csbSP_NAME|| 'prInicializar';
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        
        tbLocalidad.delete;
        dtfechaRepo := trunc(sysdate);
        
        if cuTotalProds%isopen then close cuTotalProds; end if;
        
        open cuTotalProds;
        fetch cuTotalProds into nucantidadReg;
        close cuTotalProds;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END prInicializar;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prReporteSaldos
    Descripcion     : Reporte de saldos y cobros de más por producto
    
    Parametros de Entrada 
    ====================     
    
    Parametros de Salida
    ====================
  
    Modificaciones  :
    Fecha           Autor               Modificación
    =========       =========           ====================
	25/10/2024      jcatuche            OSF-3387: Creación
    ***************************************************************************/
    PROCEDURE prReporteSaldos IS
        csbMetodo   VARCHAR2(100) := csbSP_NAME||'prReporteSaldos';
        sbproceso   VARCHAR2(100) := csbSLDTT||'_'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
        nucontador  NUMBER;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        
        --Registra proceso
        pkg_estaproc.prinsertaestaproc( sbproceso , nucantidadReg);
        nucontador := 0;
        --Recorrido de productos para análisis
        nupivote := 0;
        loop
            tbProds.delete;
            open cuProds(nupivote);
            fetch cuProds bulk collect into tbProds limit cnuLimit;
            close cuProds;
            
            exit when tbProds.count = 0; 
            
            for i in tbProds.first..tbProds.last loop
                prAnalizaSaldos
                (
                    tbProds(i).locacodi,
                    tbProds(i).dpttsesu
                ); 
            end loop;
            
            nuPivote := tbProds(tbProds.last).dpttsesu;
            nucontador := nucontador + tbProds.count;
            pkg_estaproc.prActualizaAvance( sbproceso, csbSLDMS||'-'||csbSLDTT, nucontador, nucantidadReg);
            exit when tbProds.count < cnuLimit;
        end loop;
        
        pkg_estaproc.prActualizaAvance( sbproceso, csbSLDMA, nucontador, nucantidadReg);
        --Genara información para reporte saldos de más agrupado
        prReporteSalMasAgrupado;
        
        pkg_estaproc.prActualizaAvance( sbproceso, csbSLDTA, nucontador, nucantidadReg);
        --Genara información para reporte saldos agrupado
        prReporteSaldoAgrupado;
        
        pkg_estaproc.prActualizaEstaproc( sbproceso );
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            pkg_estaproc.prActualizaEstaproc(sbproceso,'con Error',sbError);
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            pkg_estaproc.prActualizaEstaproc(sbproceso,'con Error',sbError);
    END prReporteSaldos; 
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prAnalizaSaldos
    Descripcion     : Analiza saldos y cobros de más por producto
    
    Parametros de Entrada 
    ====================     
        inuloca identificador de la localidad
        inusesu identificador del producto
    Parametros de Salida
    ====================
  
    Modificaciones  :
    Fecha           Autor               Modificación
    =========       =========           ====================
	25/10/2024      jcatuche            OSF-3387: Creación
    ***************************************************************************/
    PROCEDURE prAnalizaSaldos(inuloca in number,inusesu in number) IS
        csbMetodo   VARCHAR2(100) := csbSP_NAME||'prAnalizaSaldos';
        
        cursor cuTT is
        with base as
        (
            select dpttcont,dpttsesu,dpttcuco,pefacodi,min(dpttfere) dpttfere,sum(case dpttsign when 'DB' then -dpttvano when 'CR' then dpttvano else 0 end) dpttvano
            from ldc_deprtatt d,perifact
            where dpttsesu = inusesu
            and dpttconc = 130
            and pefacodi = dpttperi
            and dpttfere < dtfechaRepo
            group by dpttcont,dpttsesu,dpttcuco,pefacodi
            order by dpttcuco,dpttfere
        )
        select b.*,
        sum(dpttvano) over (partition by dpttsesu) dpttvanoTT,
        sum(case when dpttvano > 0 then dpttvano else 0 end) over (partition by dpttsesu) dpttvanoCR,
        sum(case when dpttvano < 0 then dpttvano else 0 end) over (partition by dpttsesu) dpttvanoDB 
        from base b;
        
        type tytbCargosTT is table of cuTT%rowtype index by binary_integer;
        tbCargosTT  tytbCargosTT;
        
        cursor cudataloca is
        select /*+ index ( l pk_ge_geogra_location ) */ l.description locadesc,
        (select  /*+ index ( b pk_ge_geogra_location ) */ description from ge_geogra_location b where b.geograp_location_id = l.geo_loca_father_id) depadesc,
        (select celocebe from ldci_centbenelocal where celoloca = l.geograp_location_id and celopais = 1) celocebe
        from ge_geogra_location l 
        where l.geograp_location_id = inuloca
        ;

        rcdataloca  cudataloca%rowtype;
        
        cursor cusol is
        select prttsesu,prttacti,prttfefi,
        (select sesususc from servsusc where sesunuse = prttsesu) sesususc,
        (select sesucate from servsusc where sesunuse = prttsesu) sesucate,
        (select sesusuca from servsusc where sesunuse = prttsesu) sesusuca
        from ldc_prodtatt
        where prttsesu = inusesu;
        
        rcsol   cusol%rowtype;
        
        rcReporte   pkg_reportes_tarifa_trans.styReporteTarifaTrans;
        
        dtfere      date;
        dtfechac    date;
        nuvalor     number;
        nuDB        number;
        nuCR        number;
        nuVanoAcum  number;
        nuVanoAcumA number;
        nuTotalCR   number;
        nuTotalDB   number;
        nucont      number;
        nucont0     number;
        nucont1     number;
        nucontx     number;
        sbReporte   varchar2(5);
        sbsubcf     varchar2(200);
        sbobs       varchar2(2000);
        
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        
        if cuTT%isopen then close cuTT; end if;
        sberror := null;
        
        tbCargosTT.delete;
        open cuTT;
        fetch cuTT bulk collect into tbCargosTT;
        close cuTT;
        
        if tbCargosTT.first is not null then
        
            sbHash := lpad(inuloca,6,'0');
            
            if not tbLocalidad.exists(sbHash) then

                if cudataloca%isopen then close cudataloca; end if;
                
                rcdataloca := null;
                open cudataloca;
                fetch cudataloca into rcdataloca;
                close cudataloca;

                tbLocalidad(sbHash).celocebe := rcdataloca.celocebe;
                tbLocalidad(sbHash).locacodi := inuloca;
                tbLocalidad(sbHash).locadesc := rcdataloca.locadesc;
                tbLocalidad(sbHash).depadesc := rcdataloca.depadesc;
            
            end if;
            
            --Inicalización de varibles
            nuVanoAcum := 0;
            nuVanoAcumA := 0;
            nucont := -1;
            nucont0 := 0;
            nucont1 := 0;
            nucontx := 0;
            nuTotalCR := 0;
            nuTotalDB := 0;
            dtfechac := null;
            sbsubcf  := '';
            
            --Genara información de saldos
            for i in tbCargosTT.first..tbCargosTT.last loop
               
                --Validación liquidación tarifa
                dtfere := tbCargosTT(i).dpttfere;
                
                if sbReporte is null then
                    if tbCargosTT(i).dpttvanoTT > 0 then
                        sbReporte := csbSLDTT;
                    elsif tbCargosTT(i).dpttvanoTT = 0 then
                        sbReporte := null; --No se contabilizan registros sin saldo
                        return;
                    else
                        sbReporte := csbSLDMS;
                    end if;
                    
                    nuvalor := tbCargosTT(i).dpttvanoTT; --Asigna el valor reciente
                    
                    nuDB := tbCargosTT(i).dpttvanoDB;
                    nuCR := tbCargosTT(i).dpttvanoCR;
                    
                end if;
                
                nuVanoAcum := nuVanoAcum + tbCargosTT(i).dpttvano;
                
                if nuVanoAcum < 0 and nucont = -1 then
                    nucont := nucont + 1;
                    dtfechac := dtfere;
                elsif nuVanoAcum >= 0 and nucont = -1 then
                    nuVanoAcumA := nuVanoAcum;
                elsif nuVanoAcum >= 0 and nucont > -1 then
                    nucontx := nucontx + 1;
                else 
                    nucont := nucont + 1;
                    
                    if tbCargosTT(i).dpttvano = 0 then
                        nucont0 := nucont0 + 1;
                    else
                        nucont1 := nucont1 + 1;
                    end if;
                        
                end if;
                
                if tbCargosTT(i).dpttvano <= 0 then
                    nuTotalDB := nuTotalDB + tbCargosTT(i).dpttvano;
                else 
                    nuTotalCR := nuTotalCR + tbCargosTT(i).dpttvano;
                end if;
            end loop;
            
            if sbReporte is null then
                return;
            end if;
        
            rcsol := null;
            open cusol;
            fetch cusol into rcsol;
            close cusol;
        
        
            if nucontx > 0 and nuVanoAcumA = 0  then
                if sbReporte = csbSLDMS then
                    sbsubcf := 'Saldo de más por notas posteriores';
                    sbobs := 'Saldo de más desde la primera cuota. Error';
                else
                    sbsubcf := 'Producto con saldo pendiente';
                    sbobs := null;
                end if;
                
            elsif nucontx > 0 and nuVanoAcumA > 0 then
                if sbReporte = csbSLDMS then
                    sbsubcf := 'Saldo de más por notas posteriores';
                    sbobs := 'Saldo crédito después de haber generado saldo de más. Error';
                else
                    sbsubcf := 'Producto con saldo pendiente';
                    sbobs := null;
                end if;
                
            elsif nucont = 0 then
                sbsubcf := 'Saldo de más por última nota';
                sbobs := 'Saldo de más por última nota';
            else
                if nucont0 = 0 and nucont1 > 0 then 
                    sbsubcf := 'Saldo de más por notas posteriores';
                    sbobs := 'Saldo de más por notas posteriores';
                elsif nucont0 > 0 and nucont1 = 0 then
                    sbsubcf := 'Saldo de más por última nota';
                    sbobs := 'Saldo de más por última nota. Notas posteriores en cero';
                    
                elsif nucont0 > 0 and nucont1 > 0 then
                    sbsubcf := 'Saldo de más por notas posteriores';
                    sbobs := 'Saldo de más por notas posteriores con valor y en cero';
                else
                    if nuVanoAcum > 0 then
                        sbsubcf := 'Producto con saldo pendiente';
                        sbobs := null;
                    elsif nuVanoAcum = 0 then
                        sbsubcf := 'Producto con saldo cero';
                        sbobs := 'Error';
                    else
                        sbsubcf := 'Escenario no considerado';
                        sbobs := 'Error';
                    end if;
                end if;
            end if;
            
            if nuDB != nuTotalDB then
                sberror := 'El total DB no coincide con el calculado ['||nuDB||']['||nuTotalDB||']';
            elsif nuCR != nuTotalCR then
                sberror := 'El total CR no coincide con el calculado ['||nuCR||']['||nuTotalCR||']';
            elsif nuvalor != nuVanoAcum then 
                sberror := 'El total acumulado no coincide el calculado ['||nuvalor||']['||nuVanoAcum||']';
            else
                sberror := null;
            end if;
                    
            rcReporte := null;
            
            --Inicializa record
            rcReporte.REPORTE           := sbReporte;
            rcReporte.CENTRO_BENEFICIO  := tbLocalidad(sbHash).celocebe;
            rcReporte.LOCALIDAD         := tbLocalidad(sbHash).locacodi;
            rcReporte.LOCADESC          := tbLocalidad(sbHash).locadesc;       
            rcReporte.DEPADESC          := tbLocalidad(sbHash).depadesc;        
            rcReporte.CONTRATO          := rcsol.sesususc;        
            rcReporte.PRODUCTO          := rcsol.prttsesu;        
            rcReporte.CATEGORIA         := rcsol.sesucate;        
            rcReporte.ESTRATO           := rcsol.sesusuca;       
            rcReporte.ACTIVO            := rcsol.prttacti;         
            rcReporte.FECHA_ULTLIQ      := dtfere;     
            rcReporte.FECHA_FINAL       := rcsol.prttfefi;     
            rcReporte.FECHA_CAMBIO      := dtfechac;     
            rcReporte.FECHA_ANO         := null;    
            rcReporte.CUENTA            := -1;       
            rcReporte.VALOR_NOTA        := nuvalor;       
            rcReporte.VALOR_CR          := nuTotalCR;      
            rcReporte.VALOR_DB          := nuTotalDB;        
            rcReporte.VALOR_L1TOTAL     := null; 
            rcReporte.VALOR_L1          := null;
            rcReporte.VALOR_L1SA        := null;     
            rcReporte.VALOR_L1ANUL      := null;     
            rcReporte.VALOR_L1DESC      := null;    
            rcReporte.VALOR_L1ING       := null;   
            rcReporte.VALOR_CARGOTOTAL  := null;
            rcReporte.VALOR_CARGO       := null;
            rcReporte.CLASIFICACION     := sbsubcf;    
            rcReporte.OBSERVACION       := sbobs;   
            rcReporte.ERROR             := sberror;
            
            --Inserta registro
            pkg_reportes_tarifa_trans.prInsRegistro(rcReporte);
            
        end if;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            raise pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            raise pkg_Error.Controlled_Error;
    END prAnalizaSaldos;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prReporteSalMasAgrupado
    Descripcion     : Reporte de saldos de más TT agrupado
    
    Parametros de Entrada 
    ====================     
    
    Parametros de Salida
    ====================
  
    Modificaciones  :
    Fecha           Autor               Modificación
    =========       =========           ====================
	25/10/2024      jcatuche            OSF-3387: Creación
    ***************************************************************************/
    PROCEDURE prReporteSalMasAgrupado IS
        csbMetodo   VARCHAR2(100) := csbSP_NAME||'prReporteSalMasAgrupado';
        
        tbAgrupa    pkg_bcreportes_tarifa_trans.tytbAgrupaSaldos;
        tbReporte   pkg_reportes_tarifa_trans.tytbreportes_tarifa_trans;
        
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        
        tbAgrupa.delete;
        pkg_bcreportes_tarifa_trans.prObtieneSaldos(csbSLDMS,tbAgrupa);
        
        if tbAgrupa.first is not null then
            for i in tbAgrupa.first..tbAgrupa.last loop
                
                --Inicializa registros
                tbReporte.REPORTE(i)          := csbSLDMA;
                tbReporte.CENTRO_BENEFICIO(i) := tbAgrupa(i).CENTRO_BENEFICIO;
                tbReporte.LOCALIDAD(i)        := tbAgrupa(i).LOCALIDAD;
                tbReporte.LOCADESC(i)         := tbAgrupa(i).LOCADESC;       
                tbReporte.DEPADESC(i)         := tbAgrupa(i).DEPADESC;        
                tbReporte.CONTRATO(i)         := null;        
                tbReporte.PRODUCTO(i)         := CASE tbAgrupa(i).CLASIFICACION WHEN 'Saldo de más por última nota' THEN -1 ELSE -2 END;        
                tbReporte.CATEGORIA(i)        := null;        
                tbReporte.ESTRATO(i)          := null;       
                tbReporte.ACTIVO(i)           := null;         
                tbReporte.FECHA_ULTLIQ(i)     := null;     
                tbReporte.FECHA_FINAL(i)      := null;    
                tbReporte.FECHA_CAMBIO(i)     := null;     
                tbReporte.FECHA_ANO(i)        := null;    
                tbReporte.CUENTA(i)           := -1;       
                tbReporte.VALOR_NOTA(i)       := tbAgrupa(i).VALOR_NOTA;       
                tbReporte.VALOR_CR(i)         := tbAgrupa(i).VALOR_CR;      
                tbReporte.VALOR_DB(i)         := tbAgrupa(i).VALOR_DB;       
                tbReporte.VALOR_L1TOTAL(i)    := null; 
                tbReporte.VALOR_L1(i)         := null;
                tbReporte.VALOR_L1SA(i)       := null; 
                tbReporte.VALOR_L1ANUL(i)     := null; 
                tbReporte.VALOR_L1DESC(i)     := null;
                tbReporte.VALOR_L1ING(i)      := null;
                tbReporte.VALOR_CARGOTOTAL(i) := null; 
                tbReporte.VALOR_CARGO(i)      := null;
                tbReporte.CLASIFICACION(i)    := tbAgrupa(i).CLASIFICACION;    
                tbReporte.OBSERVACION(i)      := null;   
                tbReporte.ERROR(i)            := null;
            
            end loop;
            
            --Inserta registros
            pkg_reportes_tarifa_trans.prInsRegistros(tbReporte);
                    
        end if;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            raise pkg_Error.Controlled_Error;            
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            raise pkg_Error.Controlled_Error;
    END prReporteSalMasAgrupado; 
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prReporteSaldoAgrupado
    Descripcion     : Reporte de saldos TT agrupado
    
    Parametros de Entrada 
    ====================     
    
    Parametros de Salida
    ====================
  
    Modificaciones  :
    Fecha           Autor               Modificación
    =========       =========           ====================
	25/10/2024      jcatuche            OSF-3387: Creación
    ***************************************************************************/
    PROCEDURE prReporteSaldoAgrupado IS
        csbMetodo   VARCHAR2(100) := csbSP_NAME||'prReporteSaldoAgrupado';
        
        tbAgrupa    pkg_bcreportes_tarifa_trans.tytbAgrupaSaldos;
        tbReporte   pkg_reportes_tarifa_trans.tytbreportes_tarifa_trans;
        
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        
        tbAgrupa.delete;
        pkg_bcreportes_tarifa_trans.prObtieneSaldos(csbSLDTT,tbAgrupa);
        
        if tbAgrupa.first is not null then
            for i in tbAgrupa.first..tbAgrupa.last loop
                
                --Inicializa registros
                tbReporte.REPORTE(i)          := csbSLDTA;
                tbReporte.CENTRO_BENEFICIO(i) := tbAgrupa(i).CENTRO_BENEFICIO;
                tbReporte.LOCALIDAD(i)        := tbAgrupa(i).LOCALIDAD;
                tbReporte.LOCADESC(i)         := tbAgrupa(i).LOCADESC;       
                tbReporte.DEPADESC(i)         := tbAgrupa(i).DEPADESC;        
                tbReporte.CONTRATO(i)         := null;        
                tbReporte.PRODUCTO(i)         := -1;        
                tbReporte.CATEGORIA(i)        := null;        
                tbReporte.ESTRATO(i)          := null;       
                tbReporte.ACTIVO(i)           := null;         
                tbReporte.FECHA_ULTLIQ(i)     := null;     
                tbReporte.FECHA_FINAL(i)      := null;    
                tbReporte.FECHA_CAMBIO(i)     := null;     
                tbReporte.FECHA_ANO(i)        := null;    
                tbReporte.CUENTA(i)           := -1;       
                tbReporte.VALOR_NOTA(i)       := tbAgrupa(i).VALOR_NOTA;       
                tbReporte.VALOR_CR(i)         := tbAgrupa(i).VALOR_CR;      
                tbReporte.VALOR_DB(i)         := tbAgrupa(i).VALOR_DB;       
                tbReporte.VALOR_L1TOTAL(i)    := null; 
                tbReporte.VALOR_L1(i)         := null;
                tbReporte.VALOR_L1SA(i)       := null; 
                tbReporte.VALOR_L1ANUL(i)     := null; 
                tbReporte.VALOR_L1DESC(i)     := null;
                tbReporte.VALOR_L1ING(i)      := null;
                tbReporte.VALOR_CARGOTOTAL(i) := null; 
                tbReporte.VALOR_CARGO(i)      := null;
                tbReporte.CLASIFICACION(i)    := tbAgrupa(i).CLASIFICACION;    
                tbReporte.OBSERVACION(i)      := null;   
                tbReporte.ERROR(i)            := null;
            
            end loop;
            
            --Inserta registros
            pkg_reportes_tarifa_trans.prInsRegistros(tbReporte);
                    
        end if;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            raise pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            raise pkg_Error.Controlled_Error;
    END prReporteSaldoAgrupado; 
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prReporteLiquidacion
    Descripcion     : Reporte de liquidación TT por producto, cuenta y año
    
    Parametros de Entrada 
    ====================     
    
    Parametros de Salida
    ====================
  
    Modificaciones  :
    Fecha           Autor               Modificación
    =========       =========           ====================
	25/10/2024      jcatuche            OSF-3387: Creación
    ***************************************************************************/
    PROCEDURE prReporteLiquidacion IS
        csbMetodo   VARCHAR2(100) := csbSP_NAME||'prReporteLiquidacion';
        sbproceso   VARCHAR2(100) := csbLIQTT||'_'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
        nucontador  NUMBER;
        sbAno       NUMBER;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        
        sbAno := to_char(dtfechaRepo-cnuSegundo,'YYYY');
        
        --Registra proceso
        pkg_estaproc.prinsertaestaproc( sbproceso , nucantidadReg);
        nucontador := 0;
        --Recorrido de productos para análisis
        nupivote := 0;
        loop
            tbProds.delete;
            open cuProds(nupivote);
            fetch cuProds bulk collect into tbProds limit cnuLimit;
            close cuProds;
            
            exit when tbProds.count = 0; 
            
            for i in tbProds.first..tbProds.last loop
                
                prAnalizaLiquidacion
                (
                    sbAno,
                    tbProds(i).locacodi,
                    tbProds(i).dpttsesu
                ); 
            end loop;
            
            nuPivote := tbProds(tbProds.last).dpttsesu;
            nucontador := nucontador + tbProds.count;
            pkg_estaproc.prActualizaAvance( sbproceso, csbLIQTT, nucontador, nucantidadReg);
            exit when tbProds.count < cnuLimit;
        end loop;
        
        pkg_estaproc.prActualizaAvance( sbproceso, csbLIQTA, nucontador, nucantidadReg);
        --Genara información para reporte liquidación agrupado
        prReporteLiqAgrupado;
        
        pkg_estaproc.prActualizaEstaproc( sbproceso );
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            pkg_estaproc.prActualizaEstaproc(sbproceso,'con Error',sbError);
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            pkg_estaproc.prActualizaEstaproc(sbproceso,'con Error',sbError);
    END prReporteLiquidacion; 
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prAnalizaLiquidacion
    Descripcion     : Analiza liquidación TT por producto, cuenta y fecha
    
    Parametros de Entrada 
    ====================     
        isbano  año para la generación del reporte
        inuloca identificador de la localidad
        inusesu identificador del producto
    Parametros de Salida
    ====================
  
    Modificaciones  :
    Fecha           Autor               Modificación
    =========       =========           ====================
	25/10/2024      jcatuche            OSF-3387: Creación
    ***************************************************************************/
    PROCEDURE prAnalizaLiquidacion(isbano in varchar2, inuloca in number,inusesu in number) IS
        csbMetodo   VARCHAR2(100) := csbSP_NAME||'prAnalizaLiquidacion';
        
        cursor cuTT is
        with base as 
        (
            select /*+ index ( d IDX_CON04DEPRTATT ) */
            dpttcont,dpttsesu,dpttcuco,dpttconc,to_char(max(dpttfere),'YYYY') fecha,
            sum(case dpttsign when 'DB' then -dpttvano when 'CR' then  dpttvano else 0 end) dpttvano
            from ldc_deprtatt d
            where 1 = 1
            and dpttsesu = inusesu
            and dpttconc = 130
            and dpttfere < dtfechaRepo
            group by dpttcont,dpttsesu,dpttcuco,dpttconc
        ), cargosTT as
        (
            select dpttcont,dpttsesu,dpttcuco,fecha,dpttvano,
            nvl((
                sum(case when cargsign in ('DB','SA') and cargcaca not in (50,51,53) and cargfecr < dtfechaRepo then -cargvalo when cargcaca not in (50,51,53) and cargfecr < dtfechaRepo then cargvalo else 0 end) 
            ),0) cargvaloT,
            nvl((
                sum(case when cargsign in ('DB','SA') and cargcaca = 59 and cargprog = 20 and cargfecr < dtfechaRepo then -cargvalo when cargcaca = 59 and cargprog = 20 and cargfecr < dtfechaRepo then cargvalo else 0 end) 
            ),0) cargvalo,
            nvl((
                sum(case when cargsign in ('DB','SA') and cargcaca not in (20,23,46,50,51,56,58,45,21,2,73,77,22,87,88,93,80,99,98,92,91,62,66) and cargfecr < dtfechaRepo then -cargvalo 
                when cargsign in ('CR') and cargcaca not in (20,23,46,50,51,56,58,45,21,2,73,77,22,87,88,93,80,99,98,92,91,62,66) and cargfecr < dtfechaRepo then cargvalo else 0 end) 
            ),0) cargvaloL1T,
            nvl((
                sum(case when cargsign in ('DB') and cargcaca not in (20,23,46,50,51,56,58,45,21,2,73,77,22,87,88,93,80,99,98,92,91,62,66) and cargcaca not in (1,3,4) and cargfecr < dtfechaRepo then -cargvalo 
                when cargsign in ('CR') and cargcaca not in (20,23,46,50,51,56,58,45,21,2,73,77,22,87,88,93,80,99,98,92,91,62,66) and cargcaca not in (1,3,4) and cargfecr < dtfechaRepo then cargvalo else 0 end) 
            ),0) cargvaloL1,
            nvl((
                sum(case when cargsign in ('SA') and cargcaca not in (20,23,46,50,51,56,58,45,21,2,73,77,22,87,88,93,80,99,98,92,91,62,66) and cargcaca not in (1,3,4) and cargfecr < dtfechaRepo then -cargvalo else 0 end) 
            ),0) cargvaloL1SA,
            nvl((
                sum(case when cargsign in ('DB','SA') and cargcaca in (1) and cargfecr < dtfechaRepo then -cargvalo 
                when cargcaca in (1) and cargfecr < dtfechaRepo then cargvalo else 0 end) 
            ),0) cargvaloL1Anul,
            nvl((
                sum(case when cargsign in ('DB','SA') and cargcaca in (3) and cargfecr < dtfechaRepo then -cargvalo 
                when cargcaca in (3) and cargfecr < dtfechaRepo then cargvalo else 0 end) 
            ),0) cargvaloL1Desc,
            nvl((
                sum(case when cargsign in ('DB','SA') and cargcaca in (4) and cargfecr < dtfechaRepo then -cargvalo 
                when cargcaca in (4) and cargfecr < dtfechaRepo then cargvalo else 0 end) 
            ),0) cargvaloL1Ing
            from base,cargos
            where cargnuse(+) = dpttsesu
            and cargcuco(+) = dpttcuco
            and cargconc(+) = dpttconc	
            and fecha = isbano	
            group by dpttcont,dpttsesu,dpttcuco,fecha,dpttvano
        )
        select c.*,
        (select sesucate from servsusc where sesunuse = dpttsesu) sesucate,
        (select sesusuca from servsusc where sesunuse = dpttsesu) sesusuca
        from cargosTT c;
        
        type tytbCargosTT is table of cuTT%rowtype index by binary_integer;
        tbCargosTT  tytbCargosTT;
        
        cursor cudataloca is
        select /*+ index ( l pk_ge_geogra_location ) */ l.description locadesc,
        (select  /*+ index ( b pk_ge_geogra_location ) */ description from ge_geogra_location b where b.geograp_location_id = l.geo_loca_father_id) depadesc,
        (select celocebe from ldci_centbenelocal where celoloca = l.geograp_location_id and celopais = 1) celocebe
        from ge_geogra_location l 
        where l.geograp_location_id = inuloca
        ;

        rcdataloca  cudataloca%rowtype;
        tbReporte   pkg_reportes_tarifa_trans.tytbreportes_tarifa_trans;
    
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        
        if cuTT%isopen then close cuTT; end if;
        
        tbCargosTT.delete;
        open cuTT;
        fetch cuTT bulk collect into tbCargosTT;
        close cuTT;
        
        if tbCargosTT.first is not null then
        
            sbHash := lpad(inuloca,6,'0');
            
            if not tbLocalidad.exists(sbHash) then

                if cudataloca%isopen then close cudataloca; end if;
                
                rcdataloca := null;
                open cudataloca;
                fetch cudataloca into rcdataloca;
                close cudataloca;

                tbLocalidad(sbHash).celocebe := rcdataloca.celocebe;
                tbLocalidad(sbHash).locacodi := inuloca;
                tbLocalidad(sbHash).locadesc := rcdataloca.locadesc;
                tbLocalidad(sbHash).depadesc := rcdataloca.depadesc;
            
            end if;
            
            --Genara información para reporte liquidación
            for i in tbCargosTT.first..tbCargosTT.last loop
                
                --Inicializa record
                tbReporte.REPORTE(i)            := csbLIQTT;
                tbReporte.CENTRO_BENEFICIO(i)   := tbLocalidad(sbHash).celocebe;
                tbReporte.LOCALIDAD(i)          := tbLocalidad(sbHash).locacodi;
                tbReporte.LOCADESC(i)           := tbLocalidad(sbHash).locadesc;       
                tbReporte.DEPADESC(i)           := tbLocalidad(sbHash).depadesc;        
                tbReporte.CONTRATO(i)           := tbCargosTT(i).dpttcont;        
                tbReporte.PRODUCTO(i)           := tbCargosTT(i).dpttsesu;        
                tbReporte.CATEGORIA(i)          := tbCargosTT(i).sesucate;        
                tbReporte.ESTRATO(i)            := tbCargosTT(i).sesusuca;       
                tbReporte.ACTIVO(i)             := null;         
                tbReporte.FECHA_ULTLIQ(i)       := null;     
                tbReporte.FECHA_FINAL(i)        := null;    
                tbReporte.FECHA_CAMBIO(i)       := null;     
                tbReporte.FECHA_ANO(i)          := to_number(isbano);    
                tbReporte.CUENTA(i)             := tbCargosTT(i).dpttcuco;       
                tbReporte.VALOR_NOTA(i)         := tbCargosTT(i).dpttvano;       
                tbReporte.VALOR_CR(i)           := null;      
                tbReporte.VALOR_DB(i)           := null;        
                tbReporte.VALOR_L1TOTAL(i)      := tbCargosTT(i).cargvaloL1T;    
                tbReporte.VALOR_L1(i)           := tbCargosTT(i).cargvaloL1;   
                tbReporte.VALOR_L1SA(i)         := tbCargosTT(i).cargvaloL1SA;       
                tbReporte.VALOR_L1ANUL(i)       := tbCargosTT(i).cargvaloL1Anul;     
                tbReporte.VALOR_L1DESC(i)       := tbCargosTT(i).cargvaloL1Desc;    
                tbReporte.VALOR_L1ING(i)        := tbCargosTT(i).cargvaloL1Ing;    
                tbReporte.VALOR_CARGOTOTAL(i)   := tbCargosTT(i).cargvaloT; 
                tbReporte.VALOR_CARGO(i)        := tbCargosTT(i).cargvalo;
                tbReporte.CLASIFICACION(i)      := null;    
                tbReporte.OBSERVACION(i)        := null;   
                tbReporte.ERROR(i)              := null;
                    
            end loop;
            
            --Inserta registros
            pkg_reportes_tarifa_trans.prInsRegistros(tbReporte);
            
        end if;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            raise pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            raise pkg_Error.Controlled_Error;
    END prAnalizaLiquidacion;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prReporteLiqAgrupado
    Descripcion     : Reporte de liquidación TT por año agrupado
    
    Parametros de Entrada 
    ====================     
    
    Parametros de Salida
    ====================
  
    Modificaciones  :
    Fecha           Autor               Modificación
    =========       =========           ====================
	25/10/2024      jcatuche            OSF-3387: Creación
    ***************************************************************************/
    PROCEDURE prReporteLiqAgrupado IS
        csbMetodo   VARCHAR2(100) := csbSP_NAME||'prReporteLiqAgrupado';
        
        tbAgrupa    pkg_bcreportes_tarifa_trans.tytbAgrupaLiquidacion;
        tbReporte   pkg_reportes_tarifa_trans.tytbreportes_tarifa_trans;
        
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        
        tbAgrupa.delete;
        pkg_bcreportes_tarifa_trans.prObtieneLiquidacion(csbLIQTT,tbAgrupa);
        
        if tbAgrupa.first is not null then
            for i in tbAgrupa.first..tbAgrupa.last loop
                
                --Inicializa registros
                tbReporte.REPORTE(i)            := csbLIQTA;
                tbReporte.CENTRO_BENEFICIO(i)   := tbAgrupa(i).CENTRO_BENEFICIO;
                tbReporte.LOCALIDAD(i)          := tbAgrupa(i).LOCALIDAD;
                tbReporte.LOCADESC(i)           := tbAgrupa(i).LOCADESC;       
                tbReporte.DEPADESC(i)           := tbAgrupa(i).DEPADESC;        
                tbReporte.CONTRATO(i)           := null;        
                tbReporte.PRODUCTO(i)           := -1;        
                tbReporte.CATEGORIA(i)          := null;        
                tbReporte.ESTRATO(i)            := null;       
                tbReporte.ACTIVO(i)             := null;         
                tbReporte.FECHA_ULTLIQ(i)       := null;     
                tbReporte.FECHA_FINAL(i)        := null;    
                tbReporte.FECHA_CAMBIO(i)       := null;     
                tbReporte.FECHA_ANO(i)          := tbAgrupa(i).FECHA_ANO;    
                tbReporte.CUENTA(i)             := -1;       
                tbReporte.VALOR_NOTA(i)         := tbAgrupa(i).VALOR_NOTA;       
                tbReporte.VALOR_CR(i)           := null;      
                tbReporte.VALOR_DB(i)           := null;        
                tbReporte.VALOR_L1TOTAL(i)      := tbAgrupa(i).VALOR_L1TOTAL;    
                tbReporte.VALOR_L1(i)           := tbAgrupa(i).VALOR_L1;   
                tbReporte.VALOR_L1SA(i)         := tbAgrupa(i).VALOR_L1SA;       
                tbReporte.VALOR_L1ANUL(i)       := tbAgrupa(i).VALOR_L1ANUL;     
                tbReporte.VALOR_L1DESC(i)       := tbAgrupa(i).VALOR_L1DESC;    
                tbReporte.VALOR_L1ING(i)        := tbAgrupa(i).VALOR_L1ING;    
                tbReporte.VALOR_CARGOTOTAL(i)   := tbAgrupa(i).VALOR_CARGOTOTAL; 
                tbReporte.VALOR_CARGO(i)        := tbAgrupa(i).VALOR_CARGO;
                tbReporte.CLASIFICACION(i)      := null;    
                tbReporte.OBSERVACION(i)        := null;   
                tbReporte.ERROR(i)              := null;
            
            end loop;
            
            --Inserta registros
            pkg_reportes_tarifa_trans.prInsRegistros(tbReporte);
            
        end if;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            raise pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            raise pkg_Error.Controlled_Error;
    END prReporteLiqAgrupado; 
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prBorraReportes
    Descripcion     : Borra registros de reportes
    
    Parametros de Entrada 
    ====================     
    
    Parametros de Salida
    ====================
  
    Modificaciones  :
    Fecha           Autor               Modificación
    =========       =========           ====================
	25/10/2024      jcatuche            OSF-3387: Creación
    ***************************************************************************/
    PROCEDURE prBorraReportes IS
        csbMetodo   VARCHAR2(100) := csbSP_NAME||'prBorraReportes';
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        
        pkg_reportes_tarifa_trans.prTruncaTabla;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END prBorraReportes; 
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prProcesaCadena
    Descripcion     : Registra, parametriza y activa cadena
    
    Parametros de Entrada 
    ====================     
    
    Parametros de Salida
    ====================
  
    Modificaciones  :
    Fecha           Autor               Modificación
    =========       =========           ====================
	25/10/2024      jcatuche            OSF-3387: Creación
    ***************************************************************************/
    PROCEDURE prProcesaCadena IS
        csbMetodo       VARCHAR2(100) := csbSP_NAME||'prProcesaCadena';
        
        sbPrograma      VARCHAR2(100):= 'REPTTRAN';
        sbChainJobsRTT  VARCHAR2(30) := 'CADENA_'||sbPrograma;
        tbProgramas     pkg_scheduler.tytbProgramas;
        blCadenaCreada  BOOLEAN := FALSE;
        
        TYPE TYRCPROGRAMA IS RECORD
        (
            PROGRAM_NAME VARCHAR2(100),
            PACKAGE VARCHAR2(100),
            API VARCHAR2(100),
            PROGRAM_TYPE VARCHAR2(50),
            STEP VARCHAR2(50),
            PROGRAM_ACTION VARCHAR2(4000)
        );

        RCPROGRAMA TYRCPROGRAMA;

        TYPE TYtbSchedChainProg IS TABLE OF TYRCPROGRAMA INDEX BY BINARY_INTEGER;

        tbSchedChainProg  TYtbSchedChainProg;
        
        PROCEDURE prCargaProgramas IS
            csbSubMet   VARCHAR2(100) := csbMetodo||'.prCargaProgramas';
        BEGIN
            pkg_traza.trace(csbSubMet, csbNivelTraza, csbInicio);
            
            tbSchedChainProg.DELETE;
            
            --Define programa inicial
            RCPROGRAMA.PROGRAM_NAME     := 'INI_'||sbPrograma;
            RCPROGRAMA.PROGRAM_TYPE     := 'STORED_PROCEDURE';
            RCPROGRAMA.STEP             := 'INI_'||sbPrograma;
            RCPROGRAMA.PROGRAM_ACTION   := csbSP_NAME||'PRINICADENA';
            
            tbSchedChainProg(tbSchedChainProg.COUNT+1)  :=  RCPROGRAMA;
            
            --Define programa REPORTE 1
            RCPROGRAMA.PROGRAM_NAME     := sbPrograma||'_1';
            RCPROGRAMA.PROGRAM_TYPE     := 'STORED_PROCEDURE';
            RCPROGRAMA.STEP             := sbPrograma||'_1';
            RCPROGRAMA.PROGRAM_ACTION   := csbSP_NAME||'PRGENREPORTE';
            
            tbSchedChainProg(tbSchedChainProg.COUNT+1)  :=  RCPROGRAMA;
            
            --Define programa REPORTE 2
            RCPROGRAMA.PROGRAM_NAME     := sbPrograma||'_2';
            RCPROGRAMA.PROGRAM_TYPE     := 'STORED_PROCEDURE';
            RCPROGRAMA.STEP             := sbPrograma||'_2';
            RCPROGRAMA.PROGRAM_ACTION   := csbSP_NAME||'PRGENREPORTE';
            
            tbSchedChainProg(tbSchedChainProg.COUNT+1)  :=  RCPROGRAMA;
            
            --Define programa final
            RCPROGRAMA.PROGRAM_NAME     := 'FIN_'||sbPrograma;
            RCPROGRAMA.PROGRAM_TYPE     := 'STORED_PROCEDURE';
            RCPROGRAMA.STEP             := 'FIN_'||sbPrograma;
            RCPROGRAMA.PROGRAM_ACTION   := csbSP_NAME||'PRFINCADENA';
            
            tbSchedChainProg(tbSchedChainProg.COUNT+1)  :=  RCPROGRAMA;
        
            pkg_traza.trace(csbSubMet, csbNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_Error.Controlled_Error  THEN
                pkg_Error.getError(nuError, sbError);
                pkg_traza.trace(csbSubMet, csbNivelTraza, csbFin_Erc);
                RAISE pkg_Error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_Error.setError;
                pkg_Error.getError(nuError, sbError);
                pkg_traza.trace(csbSubMet, csbNivelTraza, csbFin_Err);
                RAISE pkg_Error.Controlled_Error;
        END prCargaProgramas; 
        
        PROCEDURE prCreaCadena IS
            csbSubMet   VARCHAR2(100) := csbMetodo||'.prCreaCadena';
        BEGIN
            pkg_traza.trace(csbSubMet, csbNivelTraza, csbInicio);
            
            IF pkg_scheduler.FBLSCHEDCHAINEXISTS( sbChainJobsRTT ) THEN
                
                tbProgramas := pkg_scheduler.ftbProgramas( sbPrograma );
                
                IF
                (
                    NVL(tbProgramas.Count,0) <> 4                
                    OR
                    pkg_scheduler.fblUltEjecCadJobConError(  sbChainJobsRTT )
                )
                THEN

                    pkg_scheduler.pDropSchedChain( sbChainJobsRTT );

                    pkg_scheduler.create_chain( sbChainJobsRTT );
                    
                    blCadenaCreada := TRUE;

                END IF;

            ELSE
                pkg_scheduler.create_chain( sbChainJobsRTT );
                
                blCadenaCreada := TRUE;
                
            END IF;
        
            pkg_traza.trace(csbSubMet, csbNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_Error.Controlled_Error  THEN
                pkg_Error.getError(nuError, sbError);
                pkg_traza.trace(csbSubMet, csbNivelTraza, csbFin_Erc);
                RAISE pkg_Error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_Error.setError;
                pkg_Error.getError(nuError, sbError);
                pkg_traza.trace(csbSubMet, csbNivelTraza, csbFin_Err);
                RAISE pkg_Error.Controlled_Error;
        END prCreaCadena; 
        
        PROCEDURE prCreaPasos IS
            csbSubMet   VARCHAR2(100) := csbMetodo||'.prCreaPasos';
        
        BEGIN
            pkg_traza.trace(csbSubMet, csbNivelTraza, csbInicio);
            
            IF blCadenaCreada THEN
                --Crea pasos para la cadena de jobs
                FOR i IN tbSchedChainProg.FIRST..tbSchedChainProg.LAST LOOP
                    
                    pkg_scheduler.PCREASCHEDCHAINSTEP
                    (
                        sbChainJobsRTT,
                        tbSchedChainProg(i).step,
                        tbSchedChainProg(i).program_name,
                        tbSchedChainProg(i).program_type,
                        tbSchedChainProg(i).program_action,
                        case when tbSchedChainProg(i).program_action like '%PRGENREPORTE%' then 1 else 0 end,
                        FALSE,
                        sbChainJobsRTT,
                        nuError,
                        sbError
                    );
                    
                    IF nuError = 0 THEN
                        NULL;
                    ELSE
                        Pkg_Error.SetErrorMessage(  isbMsgErrr => 'pCreaSchedChainStep|' || sbError );
                    END IF;
                END LOOP;
                
            END IF;
        
            pkg_traza.trace(csbSubMet, csbNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_Error.Controlled_Error  THEN
                pkg_Error.getError(nuError, sbError);
                pkg_traza.trace(csbSubMet, csbNivelTraza, csbFin_Erc);
                RAISE pkg_Error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_Error.setError;
                pkg_Error.getError(nuError, sbError);
                pkg_traza.trace(csbSubMet, csbNivelTraza, csbFin_Err);
                RAISE pkg_Error.Controlled_Error;
        END prCreaPasos; 
        
        PROCEDURE prCreaReglas IS
            csbSubMet   VARCHAR2(100) := csbMetodo||'.prCreaReglas';
            sbCondicion VARCHAR2(4000);
            sbAccion    VARCHAR2(4000);
        BEGIN
            pkg_traza.trace(csbSubMet, csbNivelTraza, csbInicio);
            
            IF blCadenaCreada THEN
                --Crea Reglas para la cadena de Jobs
                sbCondicion := 'FALSE';
                sbAccion   := 'start INI_'||sbPrograma;

                pkg_scheduler.define_chain_rule
                (
                   sbChainJobsRTT,
                   sbCondicion,
                   sbAccion
                );

                sbCondicion := REPLACE(sbAccion,'start ','');
                sbCondicion := sbCondicion || ' succeeded';

                sbAccion    := 'start '||sbPrograma||'_1 ,'||sbPrograma||'_2';

                pkg_scheduler.define_chain_rule
                (
                   sbChainJobsRTT,
                   sbCondicion,
                   sbAccion
                );

                sbCondicion := REPLACE(sbAccion,'start ','');
                sbCondicion := REPLACE(sbCondicion,',',' succeeded and ');
                sbCondicion := sbCondicion ||' succeeded';

                sbAccion := 'start FIN_'||sbPrograma;

                pkg_scheduler.define_chain_rule
                (
                   sbChainJobsRTT,
                   sbCondicion,
                   sbAccion
                );

                sbCondicion := REPLACE(sbAccion,'start ','');
                sbCondicion := sbCondicion || ' succeeded';

                sbAccion := 'END';

                -- termina la cadena
                pkg_scheduler.define_chain_rule
                (
                   sbChainJobsRTT,
                   sbCondicion,
                   sbAccion
                );

            END IF;
        
            pkg_traza.trace(csbSubMet, csbNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_Error.Controlled_Error  THEN
                pkg_Error.getError(nuError, sbError);
                pkg_traza.trace(csbSubMet, csbNivelTraza, csbFin_Erc);
                RAISE pkg_Error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_Error.setError;
                pkg_Error.getError(nuError, sbError);
                pkg_traza.trace(csbSubMet, csbNivelTraza, csbFin_Err);
                RAISE pkg_Error.Controlled_Error;
        END prCreaReglas;
        
        PROCEDURE prDefineArgumentos IS
            csbSubMet   VARCHAR2(100) := csbMetodo||'.prDefineArgumentos';
        BEGIN
            pkg_traza.trace(csbSubMet, csbNivelTraza, csbInicio);
            
            pkg_scheduler.define_program_argument
            (
                program_name        => sbPrograma||'_1',
                argument_position   => 1,
                argument_type       => 'NUMBER',
                default_value       => 1,
                codeError           => nuError,
                messageError        => sbError
            );
            
            IF nuError = 0 THEN
                NULL;
            ELSE
                Pkg_Error.SetErrorMessage(  isbMsgErrr => 'define_program_argument|' || sbError );
            END IF;
            
            pkg_scheduler.define_program_argument
            (
                program_name        => sbPrograma||'_2',
                argument_position   => 1,
                argument_type       => 'NUMBER',
                default_value       => 2,
                codeError           => nuError,
                messageError        => sbError
            );
            
            IF nuError = 0 THEN
                NULL;
            ELSE
                Pkg_Error.SetErrorMessage(  isbMsgErrr => 'define_program_argument|' || sbError );
            END IF;
            
            pkg_traza.trace(csbSubMet, csbNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_Error.Controlled_Error  THEN
                pkg_Error.getError(nuError, sbError);
                pkg_traza.trace(csbSubMet, csbNivelTraza, csbFin_Erc);
                RAISE pkg_Error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_Error.setError;
                pkg_Error.getError(nuError, sbError);
                pkg_traza.trace(csbSubMet, csbNivelTraza, csbFin_Err);
                RAISE pkg_Error.Controlled_Error;
        END prDefineArgumentos;
        
        PROCEDURE prActivaCadenaJobs IS
            csbSubMet   VARCHAR2(100) := csbMetodo||'.prActivaCadenaJobs';
        BEGIN
            pkg_traza.trace(csbSubMet, csbNivelTraza, csbInicio);
            
            FOR i IN REVERSE  tbSchedChainProg.FIRST..tbSchedChainProg.LAST LOOP
                --Habilitando pasos    
                pkg_scheduler.enable
                (
                    tbSchedChainProg(i).program_name,
                    nuError,
                    sbError
                );
                
                IF nuError = 0 THEN
                    NULL;
                ELSE
                    Pkg_Error.SetErrorMessage(  isbMsgErrr => 'Enable step '||tbSchedChainProg(i).program_name||'|'||sbError );
                END IF;
                
            END LOOP;
            
            --Habilitando cadena
            pkg_scheduler.enable
            (
                sbChainJobsRTT,
                nuError,
                sbError
            );
            
            IF nuError = 0 THEN
                NULL;
            ELSE
                Pkg_Error.SetErrorMessage(  isbMsgErrr => 'Enable Chain '||sbChainJobsRTT||'|'||sbError );
            END IF;
        
            pkg_traza.trace(csbSubMet, csbNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_Error.Controlled_Error  THEN
                pkg_Error.getError(nuError, sbError);
                pkg_traza.trace(csbSubMet, csbNivelTraza, csbFin_Erc);
                RAISE pkg_Error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_Error.setError;
                pkg_Error.getError(nuError, sbError);
                pkg_traza.trace(csbSubMet, csbNivelTraza, csbFin_Err);
                RAISE pkg_Error.Controlled_Error;
        END prActivaCadenaJobs;
        
        PROCEDURE prEjecutaCadena IS
            csbSubMet   VARCHAR2(100) := csbMetodo||'.prEjecutaCadena';
        BEGIN
            pkg_traza.trace(csbSubMet, csbNivelTraza, csbInicio);
            
            pkg_scheduler.run_chain(sbChainJobsRTT , 'INI_'||sbPrograma, 'JOB_'||sbChainJobsRTT );
            
            pkg_traza.trace(csbSubMet, csbNivelTraza, csbFin);
        EXCEPTION
            WHEN pkg_Error.Controlled_Error  THEN
                pkg_Error.getError(nuError, sbError);
                pkg_traza.trace(csbSubMet, csbNivelTraza, csbFin_Erc);
                RAISE pkg_Error.Controlled_Error;
            WHEN OTHERS THEN
                pkg_Error.setError;
                pkg_Error.getError(nuError, sbError);
                pkg_traza.trace(csbSubMet, csbNivelTraza, csbFin_Err);
                RAISE pkg_Error.Controlled_Error;
        END prEjecutaCadena;
        
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        
        --Programa cadena de Jobs
        IF pkg_scheduler.fblSchedChainRunning( sbChainJobsRTT ) THEN
            pkg_error.SetErrorMessage(  isbMsgErrr => 'La cadena de Jobs '||sbChainJobsRTT||' se está ejecutando' );
        ELSE

             --Crea cadena de jobs para el reporte
            pkg_traza.trace('prCargaProgramas', csbNivelTraza);
            prCargaProgramas;
            
            pkg_traza.trace('prCreaCadena', csbNivelTraza);
            prCreaCadena;
            
            pkg_traza.trace('prCreaPasos', csbNivelTraza);
            prCreaPasos;
            
            pkg_traza.trace('prCreaReglas', csbNivelTraza);
            prCreaReglas;
            
            pkg_traza.trace('prDefineArgumentos', csbNivelTraza);
            prDefineArgumentos;
            
            pkg_traza.trace('prActivaCadenaJobs', csbNivelTraza);
            prActivaCadenaJobs;
            
            pkg_traza.trace('prEjecutaCadena', csbNivelTraza);
            prEjecutaCadena;

        END IF;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            raise pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            raise pkg_Error.Controlled_Error;
    END prProcesaCadena;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prIniCadena
    Descripcion     : Inicia Cadena de Jobs
    
    Parametros de Entrada 
    ====================     
    
    Parametros de Salida
    ====================
  
    Modificaciones  :
    Fecha           Autor               Modificación
    =========       =========           ====================
	25/10/2024      jcatuche            OSF-3387: Creación
    ***************************************************************************/
    PROCEDURE prIniCadena IS
        csbMetodo       VARCHAR2(100) := csbSP_NAME||'prIniCadena';
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        
        prBorraReportes;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END prIniCadena;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prFinCadena
    Descripcion     : Finaliza cadena de jobs
    
    Parametros de Entrada 
    ====================     
    
    Parametros de Salida
    ====================
  
    Modificaciones  :
    Fecha           Autor               Modificación
    =========       =========           ====================
	25/10/2024      jcatuche            OSF-3387: Creación
    ***************************************************************************/
    PROCEDURE prFinCadena IS
        csbMetodo       VARCHAR2(100) := csbSP_NAME||'prFinCadena';
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END prFinCadena;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prGenReporte
    Descripcion     : Ejecuta Reportes TT
    
    Parametros de Entrada 
    ====================     
    
    Parametros de Salida
    ====================
        inuReporte  Número del reporte
    Modificaciones  :
    Fecha           Autor               Modificación
    =========       =========           ====================
	25/10/2024      jcatuche            OSF-3387: Creación
    ***************************************************************************/
    PROCEDURE prGenReporte(inuReporte in number) IS
        csbMetodo       VARCHAR2(100) := csbSP_NAME||'prGenReporte';
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        
        if inuReporte = 1 then
            prReporteSaldos;
        else
            prReporteLiquidacion;
        end if;
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END prGenReporte;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prProgramaJob
    Descripcion     : Programa Cadena de Job Reporte
    
    Parametros de Entrada 
    ====================     
    
    Parametros de Salida
        sbIntervalo Cadena e calendario para programación de Job
    ====================
        onuError    Identificador de error
        osbError    Mensaje de error
    Modificaciones  :
    Fecha           Autor               Modificación
    =========       =========           ====================
	25/10/2024      jcatuche            OSF-3387: Creación
    ***************************************************************************/
    PROCEDURE prProgramaJob(onuError out number, osbError out varchar2, sbIntervalo in varchar2 default null) IS
        csbMetodo       VARCHAR2(100) := csbSP_NAME||'prProgramaJob';
        sbPrograma      VARCHAR2(100):= 'REPTTRAN';
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_error.prInicializaError(onuError,osbError);
        
        if pkg_scheduler.fblExistJob('JOB_'||sbPrograma,0) then
            pkg_scheduler.drop_job('JOB_'||sbPrograma,true,nuError,sbError);
            
            IF nuError = 0 THEN
                NULL;
            ELSE
                Pkg_Error.SetErrorMessage(  isbMsgErrr => 'Drop Job Control JOB_'||sbPrograma||'|'||sbError );
            END IF;
        end if;
         
        pkg_scheduler.create_job
        (
            job_name        => 'JOB_'||sbPrograma,
            job_type        => 'STORED_PROCEDURE',
            job_action      => 'PKG_BOREPORTES_TARIFA_TRANS.PRPROCESACADENA',
            repeat_interval => nvl(sbIntervalo,'freq=MONTHLY;byhour=05;byminute=0;bysecond=0;BYMONTHDAY=01,16'),
            enabled         => TRUE,
            codeError       => nuError,
            messageError    => sbError
        );
        
        IF nuError = 0 THEN
            NULL;
        ELSE
            Pkg_Error.SetErrorMessage(  isbMsgErrr => 'Create Job Control JOB_'||sbPrograma||'|'||sbError );
        END IF;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(onuError, osbError);
            pkg_traza.trace('sbError: ' || osbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(onuError, osbError);
            pkg_traza.trace('sbError: ' || osbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END prProgramaJob;

BEGIN
    prInicializar;       
END PKG_BOREPORTES_TARIFA_TRANS;
/
PROMPT Otorga Permisos de Ejecución a personalizaciones.PKG_BOREPORTES_TARIFA_TRANS
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_BOREPORTES_TARIFA_TRANS','PERSONALIZACIONES');
END;
/
