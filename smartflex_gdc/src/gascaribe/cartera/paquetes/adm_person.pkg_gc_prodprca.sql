CREATE OR REPLACE PACKAGE adm_person.pkg_gc_prodprca IS
	/*******************************************************************************
		Fuente=Propiedad Intelectual de Gases del Caribe
		
		Autor       :   Jhon Eduar Erazo
		Fecha       :   24-04-2025
		Descripcion :   Paquete con la logica para la entidad gc_prodprca
		ModIFicaciones  :
		Autor       Fecha       Caso     	Descripcion
		jerazomvm	24-04-2025	OSF-4170	Creación
	*******************************************************************************/
	
	-- Obtiene la version del paquete.
    FUNCTION fsbVersion
    RETURN VARCHAR2;	
	
	-- Inserta registros	
	PROCEDURE prcInserRegistro(inuProyectoCastigo			IN gc_prodprca.prpcprca%TYPE,
							   inuPoliticaCastigo			IN gc_prodprca.prpcpoca%TYPE,
							   inuTipoCliente				IN gc_prodprca.prpcticl%TYPE,
							   isbIdentificacionCliente		IN gc_prodprca.prpcidcl%TYPE,
							   inuCliente					IN gc_prodprca.prpcclie%TYPE,
							   inuAgrupadorCuenta			IN gc_prodprca.prpcsusc%TYPE,
							   inuTipoProducto				IN gc_prodprca.prpcserv%TYPE,
							   inuProducto					IN gc_prodprca.prpcnuse%TYPE,
							   inuEstadoCorte				IN gc_prodprca.prpcesco%TYPE,
							   inuCategoria					IN gc_prodprca.prpccate%TYPE,
							   inuSubcategoria				IN gc_prodprca.prpcsuca%TYPE,
							   inuUbicacionGeografica1		IN gc_prodprca.prpcubg1%TYPE,
							   inuUbicacionGeografica2		IN gc_prodprca.prpcubg2%TYPE,
							   inuUbicacionGeografica3		IN gc_prodprca.prpcubg3%TYPE,
							   inuUbicacionGeografica4		IN gc_prodprca.prpcubg4%TYPE,
							   inuUbicacionGeografica5		IN gc_prodprca.prpcubg5%TYPE,
							   inuCicloFacturacion			IN gc_prodprca.prpccifa%TYPE,
							   inuSectorOperativo			IN gc_prodprca.prpcseop%TYPE,
							   inuCuentasSaldo				IN gc_prodprca.prpcnucu%TYPE,
							   inuFinanciacionesSaldo		IN gc_prodprca.prpcnufi%TYPE,							   
							   inuSaldoPendienteNoFinancia	IN gc_prodprca.prpcspnf%TYPE,
							   inuSaldoPendienteFinancia	IN gc_prodprca.prpcspfi%TYPE,
							   inuEdadDeuda					IN gc_prodprca.prpcedde%TYPE,
							   inuTipoCastigo				IN gc_prodprca.prpctica%TYPE,
							   inuMotivoCastigo				IN gc_prodprca.prpcmoca%TYPE,
							   isbObservacion				IN gc_prodprca.prpcobse%TYPE,
							   idtFechaExclusion			IN gc_prodprca.prpcfeex%TYPE,
							   idtFechaCastigo				IN gc_prodprca.prpcfeca%TYPE,
							   inuSaldoCastigado			IN gc_prodprca.prpcsaca%TYPE,
							   inuSaldoReactivado			IN gc_prodprca.prpcsare%TYPE,
							   isbResultadoCastigo			IN gc_prodprca.prpcreca%TYPE,
							   onuConsecutivo 				OUT gc_prodprca.prpccons%TYPE
							   );
									
END pkg_gc_prodprca;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_gc_prodprca IS

    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(35) := $$PLSQL_UNIT||'.';
	cnuNVLTRC   CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
	csbInicio   CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;
	
    -- IdentIFicador del ultimo caso que hizo cambios
    csbVersion 	VARCHAR2(15) := 'OSF-4170';

	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon.Erazo </Autor>
    <Fecha> 24-04-2025 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <ModIFicacion Autor="Jhon.Erazo" Fecha="24-04-2025" Inc="OSF-4170" Empresa="GDC"> 
               Creación
           </ModIFicacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2
    IS
    BEGIN
        return CSBVERSION;
    END fsbVersion;
	
	/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcInserRegistro
    Descripcion     : Inserta registros
    Autor           : Jhon Erazo
    Fecha           : 03-04-2025
  
    Parametros de Entrada
		inuProyectoCastigo			Proyecto castigado
		inuPoliticaCastigo			Politica castigado
		inuTipoCliente				Tipo cliente
		isbIdentificacionCliente	Identificación del cliente
		inuCliente					Cliente
		inuAgrupadorCuenta			Agrupador de cuenta
		inuTipoProducto				Tipo de producto
		inuProducto					Producto
		inuEstadoCorte				Estado de corte
		inuCategoria				Categoria
		inuSubcategoria				Subcategoria
		inuUbicacionGeografica1		Ubicación geografica 1
		inuUbicacionGeografica2		Ubicación geografica 2
		inuUbicacionGeografica3		Ubicación geografica 3
		inuUbicacionGeografica4		Ubicación geografica 4
		inuUbicacionGeografica5		Ubicación geografica 5
		inuCicloFacturacion			Ciclo Facturación
		inuSectorOperativo			Sector Operativo
		inuCuentasSaldo				Cuentas con saldo
		inuFinanciacionesSaldo		Financiaciones con saldo
		inuSaldoPendienteNoFinancia	Saldo pendiente no financiado
		inuSaldoPendienteFinancia	Saldo pendiente financiado
		inuEdadDeuda				Edad deuda
		inuTipoCastigo				Tipo castigo
		inuMotivoCastigo			Motivo castigo
		isbObservacion				Observación
		idtFechaExclusion			Fecha exclusión
		idtFechaCastigo				Fecha Castigo
		inuSaldoCastigado			Saldo Castigado
		inuSaldoReactivado			Saldo reactivado
		isbResultadoCastigo			Resultado castigo
	  
    Parametros de Salida	
		onuConsecutivo				Consecutivo
  
    ModIFicaciones  :
    =========================================================
    Autor       Fecha       	Caso    	Descripcion
	jerazomvm	03/04/2025		OSF-4170	Creación
	***************************************************************************/	
	PROCEDURE prcInserRegistro(inuProyectoCastigo			IN gc_prodprca.prpcprca%TYPE,
							   inuPoliticaCastigo			IN gc_prodprca.prpcpoca%TYPE,
							   inuTipoCliente				IN gc_prodprca.prpcticl%TYPE,
							   isbIdentificacionCliente		IN gc_prodprca.prpcidcl%TYPE,
							   inuCliente					IN gc_prodprca.prpcclie%TYPE,
							   inuAgrupadorCuenta			IN gc_prodprca.prpcsusc%TYPE,
							   inuTipoProducto				IN gc_prodprca.prpcserv%TYPE,
							   inuProducto					IN gc_prodprca.prpcnuse%TYPE,
							   inuEstadoCorte				IN gc_prodprca.prpcesco%TYPE,
							   inuCategoria					IN gc_prodprca.prpccate%TYPE,
							   inuSubcategoria				IN gc_prodprca.prpcsuca%TYPE,
							   inuUbicacionGeografica1		IN gc_prodprca.prpcubg1%TYPE,
							   inuUbicacionGeografica2		IN gc_prodprca.prpcubg2%TYPE,
							   inuUbicacionGeografica3		IN gc_prodprca.prpcubg3%TYPE,
							   inuUbicacionGeografica4		IN gc_prodprca.prpcubg4%TYPE,
							   inuUbicacionGeografica5		IN gc_prodprca.prpcubg5%TYPE,
							   inuCicloFacturacion			IN gc_prodprca.prpccifa%TYPE,
							   inuSectorOperativo			IN gc_prodprca.prpcseop%TYPE,
							   inuCuentasSaldo				IN gc_prodprca.prpcnucu%TYPE,
							   inuFinanciacionesSaldo		IN gc_prodprca.prpcnufi%TYPE,							   
							   inuSaldoPendienteNoFinancia	IN gc_prodprca.prpcspnf%TYPE,
							   inuSaldoPendienteFinancia	IN gc_prodprca.prpcspfi%TYPE,
							   inuEdadDeuda					IN gc_prodprca.prpcedde%TYPE,
							   inuTipoCastigo				IN gc_prodprca.prpctica%TYPE,
							   inuMotivoCastigo				IN gc_prodprca.prpcmoca%TYPE,
							   isbObservacion				IN gc_prodprca.prpcobse%TYPE,
							   idtFechaExclusion			IN gc_prodprca.prpcfeex%TYPE,
							   idtFechaCastigo				IN gc_prodprca.prpcfeca%TYPE,
							   inuSaldoCastigado			IN gc_prodprca.prpcsaca%TYPE,
							   inuSaldoReactivado			IN gc_prodprca.prpcsare%TYPE,
							   isbResultadoCastigo			IN gc_prodprca.prpcreca%TYPE,
							   onuConsecutivo 				OUT gc_prodprca.prpccons%TYPE
							   )
	IS
	
		csbMETODO			CONSTANT VARCHAR2(100) := csbSP_NAME ||'prcInserRegistro';
		
		nuError			NUMBER;  
		sbmensaje		VARCHAR2(1000);			
		
	BEGIN

		pkg_traza.trace(csbMETODO, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuProyectoCastigo: ' 				|| inuProyectoCastigo 			|| CHR(10) ||
						'inuPoliticaCastigo: ' 				|| inuPoliticaCastigo 			|| CHR(10) ||
						'inuTipoCliente: ' 					|| inuTipoCliente				|| CHR(10) ||
						'isbIdentificacionCliente: ' 		|| isbIdentificacionCliente 	|| CHR(10) ||
						'inuCliente: ' 						|| inuCliente					|| CHR(10) ||
						'inuAgrupadorCuenta: ' 				|| inuAgrupadorCuenta 			|| CHR(10) ||
						'inuTipoProducto: ' 				|| inuTipoProducto				|| CHR(10) ||
						'inuProducto: ' 					|| inuProducto 					|| CHR(10) ||
						'inuEstadoCorte: ' 					|| inuEstadoCorte				|| CHR(10) ||
						'inuCategoria: ' 					|| inuCategoria 				|| CHR(10) ||
						'inuSubcategoria: ' 				|| inuSubcategoria 				|| CHR(10) ||
						'inuUbicacionGeografica1: ' 		|| inuUbicacionGeografica1 		|| CHR(10) ||
						'inuUbicacionGeografica2: ' 		|| inuUbicacionGeografica2		|| CHR(10) ||
						'inuUbicacionGeografica3: ' 		|| inuUbicacionGeografica3		|| CHR(10) ||
						'inuUbicacionGeografica4: ' 		|| inuUbicacionGeografica4		|| CHR(10) ||
						'inuUbicacionGeografica5: ' 		|| inuUbicacionGeografica5 		|| CHR(10) ||
						'inuCicloFacturacion: ' 			|| inuCicloFacturacion			|| CHR(10) ||
						'inuSectorOperativo: ' 				|| inuSectorOperativo 			|| CHR(10) ||
						'inuCuentasSaldo: ' 				|| inuCuentasSaldo				|| CHR(10) ||
						'inuFinanciacionesSaldo: ' 			|| inuFinanciacionesSaldo 		|| CHR(10) ||
						'inuSaldoPendienteNoFinancia: '		|| inuSaldoPendienteNoFinancia 	|| CHR(10) ||
						'inuSaldoPendienteFinancia: ' 		|| inuSaldoPendienteFinancia 	|| CHR(10) ||
						'inuEdadDeuda: ' 					|| inuEdadDeuda					|| CHR(10) ||
						'inuTipoCastigo: ' 					|| inuTipoCastigo 				|| CHR(10) ||
						'inuMotivoCastigo: ' 				|| inuMotivoCastigo				|| CHR(10) ||
						'isbObservacion: ' 					|| isbObservacion 				|| CHR(10) ||
						'idtFechaExclusion: ' 				|| idtFechaExclusion			|| CHR(10) ||
						'idtFechaCastigo: ' 				|| idtFechaCastigo 				|| CHR(10) ||
						'inuSaldoCastigado: ' 				|| inuSaldoCastigado			|| CHR(10) ||
						'inuSaldoReactivado: ' 				|| inuSaldoReactivado 			|| CHR(10) ||
						'isbResultadoCastigo: ' 			|| isbResultadoCastigo, cnuNVLTRC);
						
		onuConsecutivo := seq_gc_prodprca_172041.NEXTVAL;
		pkg_traza.trace('onuConsecutivo: ' || onuConsecutivo, cnuNVLTRC);
		
		INSERT INTO gc_prodprca(prpccons, prpcprca, prpcpoca, prpcticl, prpcidcl, prpcclie, prpcsusc, 
								prpcserv, prpcnuse, prpcesco, prpccate, prpcsuca, prpcubg1, prpcubg2, 
								prpcubg3, prpcubg4, prpcubg5, prpccifa, prpcseop, prpcnucu, prpcnufi, 
								prpcspnf, prpcspfi, prpcedde, prpctica, prpcmoca, prpcobse, prpcfeex, 
								prpcfeca, prpcsaca, prpcsare, prpcreca
								)
		VALUES (onuConsecutivo,
				inuProyectoCastigo,
				inuPoliticaCastigo,
				inuTipoCliente,
				isbIdentificacionCliente,
				inuCliente,
				inuAgrupadorCuenta,
				inuTipoProducto,
				inuProducto,
				inuEstadoCorte,
				inuCategoria,
				inuSubcategoria,
				inuUbicacionGeografica1,
				inuUbicacionGeografica2,
				inuUbicacionGeografica3,
				inuUbicacionGeografica4,
				inuUbicacionGeografica5,
				inuCicloFacturacion,
				inuSectorOperativo,
				inuCuentasSaldo,
				inuFinanciacionesSaldo,
				inuSaldoPendienteNoFinancia, 
				inuSaldoPendienteFinancia, 
				inuEdadDeuda, 
				inuTipoCastigo, 
				inuMotivoCastigo,
				isbObservacion, 
				idtFechaExclusion, 
				idtFechaCastigo, 
				inuSaldoCastigado,  
				inuSaldoReactivado, 
				isbResultadoCastigo
				);

		pkg_traza.trace(csbMETODO, cnuNVLTRC, pkg_traza.csbFIN);

	EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
	END prcInserRegistro;

END pkg_gc_prodprca;
/
PROMPT OtorgANDo permisos de ejecución para adm_person.pkg_gc_prodprca
BEGIN
    pkg_utilidades.prAplicarPermisos(UPPER('pkg_gc_prodprca'), 'adm_person');
END;
/