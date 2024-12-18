CREATE OR REPLACE FUNCTION personalizaciones.fblValidaProcesoFact(inuContrato IN NUMBER, onuError OUT NUMBER, osbError OUT VARCHAR2) 
RETURN BOOLEAN IS
/*****************************************************************
    Propiedad intelectual de Gases del Caribe

    Unidad         : fblValidaProcesoFact
    Descripcion    : Funcion encargada de validar si el contrato/productos se encuentran en proceso de facturación
    Autor          :
    Fecha          :

    Parámetros              Descripcion
    ============            ===================
    inuContrato             Número del contrato a validar
    onuError                Número de error
    osbError                Error obtenido en la validación
    
    
    Fecha           Autor               Modificación
    =========       =========           ====================
	14-06-2024      jcatuche            OSF-2685: Creación
******************************************************************/
    -- Constantes para el control de la traza
    csbMetodo           CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT;                -- Constante para nombre de función    
    csbNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;    -- Nivel de traza para esta función. 
    csbInicio           CONSTANT VARCHAR2(4)        := pkg_traza.fsbINICIO;         -- Indica inicio de método
    csbFin              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN;            -- Indica Fin de método ok
    csbFin_Erc          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERC;        -- Indica fin de método con error controlado
    csbFin_Err          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERR;        -- Indica fin de método con error no controlado
    
    --Variables generales
    sberror             VARCHAR2(4000);
    
    blvalida            BOOLEAN;
    
    cursor cuperifact (inupfciclo in number) is
    select pefacodi,pefafimo,pefaffmo from perifact 
    where pefacicl = inupfciclo
    and pefaactu = 'S'; 
    
    cursor cuValidaProc (inupefa in number) is
    select pefacodi,
    (select prejprog from procejec where prejcope = pefacodi and prejprog = 'FGCC' and rownum = 1) fgcc,
    (select prejprog from procejec where prejcope = pefacodi and prejprog = 'FCPE' and prejespr = 'T' and rownum = 1) fcpe
    from perifact
    where pefacodi = inupefa;
    
    
    cursor cuproductos (inususc in number) is
    select sesususc,sesunuse,sesuserv,sesuesco,sesucicl,sesucico
    from servsusc
    where sesususc = inususc;
    
    type typrod is table of cuproductos%rowtype index by binary_integer;
    tbprod          typrod;
    
    cursor culectura (inuProducto in number,inupefa in number) is
    select count(*) from lectelme 
    where leemsesu = inuProducto
    and leempefa = inupefa
    and leemclec = 'F'
    and leemfele is null;
    
    cursor cuConsumo (inuProducto in number,inupefa in number) is
    select count(*) from conssesu
    where cosssesu = inuProducto
    and cosspefa = inupefa
    and cossmecc = 4
    and cossflli = 'N';
    
    rcPeriodo       cuperifact%rowtype;
    rcValidaProc    cuValidaProc%rowtype;
    nuLectura       NUMBER;
    nuConsumo       NUMBER;
    nuNupr          NUMBER;
    nuCiclo         NUMBER;
    nuServ          NUMBER;
    
    PROCEDURE pCierraCursores
    IS
        -- Nombre de este método
        csbSubMT_NAME  VARCHAR2(105) := csbMetodo || '.pCierraCursores';
    BEGIN

        pkg_traza.trace(csbSubMT_NAME, csbNivelTraza, csbInicio);

        if cuperifact%isopen then 
            close cuperifact;
        end if;
        
        if cuValidaProc%isopen then 
            close cuValidaProc;
        end if;
        
        if cuproductos%isopen then 
            close cuproductos;
        end if;
                
        if culectura%isopen then 
            close culectura;
        end if;

        if cuConsumo%isopen then 
            close cuConsumo;
        end if;

        pkg_traza.trace(csbSubMT_NAME, csbNivelTraza, csbFin);

    END pCierraCursores;
    
    
BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
    pkg_traza.trace('inuContrato    <= '||inuContrato, csbNivelTraza);
    
    --Inicialización variables
    pkg_error.prInicializaError(onuError,osbError);
    blvalida := FALSE;
    
    --Cierre cursores     
    pCierraCursores;
    
    --Consulta ciclo de facturación
    nuCiclo := pkg_bccontrato.fnuCicloFacturacion(inuContrato);
    
    pkg_traza.trace('Ciclo de facturación del contrato : '||nuCiclo, csbNivelTraza);
    
    --Consulta periodo actual
    rcPeriodo := null;
    open cuperifact(nuCiclo);
    fetch cuperifact into rcPeriodo;
    close cuperifact;
    
    if rcPeriodo.pefacodi is null then
        blvalida := TRUE;
        sberror := 'No existe un periodo actual para el ciclo '||nuciclo;
        pkg_Error.setErrorMessage( isbMsgErrr => sberror);
    end if;
    
    pkg_traza.trace('Periodo de facturación actual : '||rcPeriodo.pefacodi, csbNivelTraza);
    
    --Consulta proceso facturación contrato
    nuNupr := 0;
    nuNupr := Pkg_Bccontrato.fnuCodigoProcFacturacion(inuContrato);
    
    pkg_traza.trace('Proceso facturación contrato: '||nuNupr, csbNivelTraza);
    
    rcValidaProc := null;
    open cuValidaProc(rcPeriodo.pefacodi);
    fetch cuValidaProc into rcValidaProc; 
    close cuValidaProc;
    
    pkg_traza.trace('Procesos ejecutados. Proceso1 ['||rcValidaProc.fgcc||'] - Proceso2 ['||rcValidaProc.fcpe||']', csbNivelTraza);
    
    
    if (rcValidaProc.fgcc is not null and rcValidaProc.fcpe is null) or nuNupr = 2 then
        blvalida := TRUE;
        sberror := 'El contrato '||inuContrato||' ya inicio proceso de facturación, reintente el cambio cuando se haya cerrado el periodo '||rcPeriodo.pefacodi;
        sberror := sberror||', después del '||to_char(rcPeriodo.pefaffmo,'DD/MM/YYYY');
        pkg_Error.setErrorMessage( isbMsgErrr => sberror);
    end if;
    
    --Recorrido de productos del contrato para validar 
    tbprod.delete;
    open cuproductos (inuContrato);
    fetch cuproductos bulk collect into tbprod;
    close cuproductos;
    
    for i in 1..tbprod.count loop
        
        --Consulta lectura
        nuLectura := 0;
        open culectura(tbprod(i).sesunuse,rcPeriodo.pefacodi);
        fetch culectura into nuLectura;
        close culectura;
        
        --Consulta consumos
        nuConsumo := 0;
        open cuConsumo(tbprod(i).sesunuse,rcPeriodo.pefacodi);
        fetch cuConsumo into nuConsumo;
        close cuConsumo;
        
        pkg_traza.trace('Producto contrato: '||tbprod(i).sesunuse||' tipo:'||tbprod(i).sesuserv, csbNivelTraza);
        pkg_traza.trace('Lecturas sin fecha: '||nuLectura, csbNivelTraza);
        pkg_traza.trace('Consumos sin liquidar: '||nuConsumo, csbNivelTraza);
        pkg_traza.trace('==================================', csbNivelTraza);
        
        if nuLectura != 0 then
            blvalida := TRUE;
            sberror := 'El contrato '||inuContrato||' tiene productos con lecturas pendientes de leer ['||tbprod(i).sesunuse||']';
            pkg_Error.setErrorMessage( isbMsgErrr => sberror);
        elsif nuConsumo != 0 then
            blvalida := TRUE;
            sberror := 'El contrato '||inuContrato||' tiene productos con consumos pendientes de liquidar ['||tbprod(i).sesunuse||']';
            pkg_Error.setErrorMessage( isbMsgErrr => sberror);
        end if; 
        
    end loop;
        
    pkg_traza.trace('onuError   => ' || onuError, csbNivelTraza);
    pkg_traza.trace('osbError   => ' || osbError, csbNivelTraza);
    pkg_traza.trace('return => '||case when blvalida then 'True' else 'False' end, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    return blvalida;
    
EXCEPTION
    WHEN pkg_Error.Controlled_Error  THEN
        pkg_Error.getError(onuError, osbError);
        pkg_traza.trace('onuError   => ' || onuError, csbNivelTraza);
        pkg_traza.trace('osbError   => ' || osbError, csbNivelTraza);
        pkg_traza.trace('return     => '||case when blvalida then 'True' else 'False' end, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
        return blvalida;
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(onuError, osbError);
        pkg_traza.trace('onuError   => ' || onuError, csbNivelTraza);
        pkg_traza.trace('osbError   => ' || osbError, csbNivelTraza);
        pkg_traza.trace('return     => '||case when blvalida then 'True' else 'False' end, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
        return blvalida;
END fblValidaProcesoFact;
/
begin
    pkg_utilidades.prAplicarPermisos('FBLVALIDAPROCESOFACT','PERSONALIZACIONES');
end;
/