CREATE OR REPLACE TRIGGER LDC_TRG_MARCALDCORDER BEFORE INSERT
ON ldc_order  FOR EACH ROW 
	/**************************************************************************
	Propiedad Intelectual de Gases del caribe S.A E.S.P

	Funcion     : LDC_TRG_MARCALDCORDER
	Descripcion : trigger que marca las ordenes de Reconexion
	Autor       : Horbath
	Ticket      : 147
	Fecha       : 19-12-2019

	Historia de Modificaciones
	Fecha               Autor                Modificacion
	=========           =========          ====================
	05/07/2020          Horbath            	CASO: 213 se modfiica si al orden que 
											active este TRIGGER es 10833 o 10723 y 
											la solicitud está registrada en el entidad 
											LDC_ASIGNA_UNIDAD_REV_PER será marcada 
											con bloqueo.
	14/12/2022			lvalencia			Se modifica el trigger para no bloquear 
											los trabajos adicionales		

	02/10/2024			dsaltarin			OSF-3404: Se cambia la logica que utiliza la función ldc_fnugetultimobloqueo,
											se elimina el llamado a dicha función y se evalua si la orden que se genera es la primera de la solicitud
											si es la primera aplica el bloqueo, sino lo es no aplica.
											Se aplican pautas
	****************************************************************************/
DECLARE
	sbdatos			VARCHAR2(1); --se almacena datos
	nuValdef 		NUMBER := 0; -- caso:213
	nuValtt 		NUMBER; -- caso:213
	nuPrimeraOtSol	or_order.order_id%TYPE;
	sbAplicaBloqueo	VARCHAR2(1);
	sbError	 		VARCHAR2(4000);
	nuError			NUMBER;
	nuOrden			or_order.order_id%TYPE;
	nuPackageId		mo_packages.package_id%TYPE;
	sbTitrDefectos	ld_parameter.value_chain%TYPE:=PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('COD_TITR_DEF');
	
	-- Constantes para el control de la traza
	csbMetodo		CONSTANT VARCHAR2(32)	:= $$PLSQL_UNIT||'.'; --Constante nombre método
	csbNivelTraza	CONSTANT NUMBER(2)		:= pkg_traza.cnuNivelTrzDef; 		
	
 
	--se obtiene direccion del producto
	CURSOR cugetValiOrdeSusp 
	IS
		SELECT 	'X'
		FROM    ldc_asigna_unidad_rev_per per
		INNER JOIN or_order o ON o.order_id = per.orden_trabajo
		WHERE 	per.SOLICITUD_GENERADA = nuPackageId
		AND 	pkg_parametros.fnuValidaSiExisteCadena('TITRPADREOTREVP',',',o.task_type_id) > 0
		AND 	pkg_parametros.fnuValidaSiExisteCadena('CAUSPADREOTREVP',',',o.causal_id) > 0 ;
										
	CURSOR cuValidaDefecto  
	IS
		SELECT 	1 
		FROM 	ldc_asigna_unidad_rev_per a 
		WHERE 	a.producto=nuPackageId;
	
	CURSOR cuValTT  
		IS
		SELECT 	1 
		FROM 	or_order O
		WHERE 	o.order_id = nuOrden
		AND 	o.task_type_id in (SELECT TO_NUMBER(REGEXP_SUBSTR(sbTitrDefectos,
                                                   '[^,]+',
                                                   1,
                                                   LEVEL)) AS TITR
									FROM DUAL
									CONNECT BY regexp_substr(sbTitrDefectos, '[^,]+', 1, LEVEL) IS NOT NULL
								   );
    
BEGIN
	pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
	
	nuPackageId := :NEW.PACKAGE_ID;
	nuOrden		:= :NEW.ORDER_ID;
	
	
	pkg_traza.trace('nuOrden ' || nuOrden, csbNivelTraza);
	pkg_traza.trace('nuPackageId: ' || nuPackageId, csbNivelTraza);
	pkg_traza.trace(':new.ordebloq: ' || :new.ordebloq, csbNivelTraza);
	

	OPEN cuValTT;
	FETCH cuValTT INTO nuValtt;
	CLOSE cuValTT;
	pkg_traza.trace('nuValtt: ' || nuValtt, csbNivelTraza);
	
 
	IF nuValtt = 1 THEN
		OPEN cuValidaDefecto;
		FETCH cuValidaDefecto INTO nuValdef;
		IF cuValidaDefecto%NOTFOUND THEN
			nuValdef := 0;
		END IF;
		CLOSE cuValidaDefecto;
	
		IF nuValdef = 1 THEN
			pkg_traza.trace('nuValdef: ' || nuValdef, csbNivelTraza);
			:new.ordebloq := 'S';
			pkg_traza.trace('new.ordebloq: ' || :new.ordebloq, csbNivelTraza);
		END IF;
	END IF;
	IF nuValdef = 0 THEN
		--Se valida si orden padre es de suspension
		OPEN cugetValiOrdeSusp;
		FETCH cugetValiOrdeSusp INTO sbdatos;
		CLOSE cugetValiOrdeSusp;

		nuPrimeraOtSol := fnuObtPrimOrdenSol(nuPackageId);
		pkg_traza.trace('nuPrimeraOtSol: ' || nuPrimeraOtSol, csbNivelTraza);
		
		IF NVL(nuPrimeraOtSol,0) = 0 THEN
			sbAplicaBloqueo := 'S';
		ELSE
			sbAplicaBloqueo := 'N';
		END IF;
		
		pkg_traza.trace('sbdatos: ' || sbdatos, csbNivelTraza);
		pkg_traza.trace('sbAplicaBloqueo: ' || sbAplicaBloqueo, csbNivelTraza);
		
		IF sbdatos IS NOT NULL AND sbAplicaBloqueo = 'S' THEN
			--se obtiene unidad operativa de la ultima suspension
			:new.ORDEBLOQ := 'S';		 
			pkg_traza.trace('new.ordebloq: ' || :new.ordebloq, csbNivelTraza);
		END IF; 
	END IF;
	pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);    
EXCEPTION 
  WHEN OTHERS THEN
		pkg_error.seterror;
		pkg_error.geterror(nuError, sbError);
   
		pkg_traza.trace('Error: '|| sbError, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);					
END LDC_TRG_MARCALDCORDER;
/

