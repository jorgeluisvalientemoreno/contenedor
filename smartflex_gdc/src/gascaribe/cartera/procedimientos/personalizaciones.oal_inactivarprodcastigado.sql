create or replace PROCEDURE personalizaciones.oal_InactivarProdCastigado( inuOrden            IN NUMBER,
                                                                          inuCausal           IN NUMBER,
                                                                          inuPersona          IN NUMBER,
                                                                          idtFechIniEje       IN DATE,
                                                                          idtFechaFinEje      IN DATE,
                                                                          isbDatosAdic        IN VARCHAR2,
                                                                          isbActividades      IN VARCHAR2,
                                                                          isbItemsElementos   IN VARCHAR2,
                                                                          isbLecturaElementos IN VARCHAR2,
                                                                          isbComentariosOrden IN VARCHAR2) IS
	/***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : oal_InactivarProdCastigado
      Descripcion     : Servicio  para inactivar un producto castigado

      Autor           : Luis Javier Lopez Barrios
      Fecha           : 01-04-2025

      Parametros de Entrada
        inuOrden              numero de orden
        inuCausal             causal de legalizacion
        inuPersona            persona que legaliza
        idtFechIniEje         fecha de inicio de ejecucion
        idtFechaFinEje        fecha fin de ejecucion
        isbDatosAdic          datos adicionales
        isbActividades        actividad principal y de apoyo
        isbItemsElementos     items a legalizar
        isbLecturaElementos   lecturas
        isbComentariosOrden   comentario de la orden
      Parametros de Salida


      Modificaciones  :
      =========================================================
      Autor       	Fecha       Caso    	Descripcion
	  LJLB          01/04/2025  OSF-4142    Creacion
	***************************************************************************/
    csbMT_NAME      VARCHAR2(150) := 'OAL_INACTIVARPRODCASTIGADO';
    csbNivelTraza   CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    nuError         NUMBER;
    sbError         VARCHAR2(4000);
    regTmpGenerica  tmp_generica%rowtype;
    refCursor       Constants_Per.tyrefcursor;

  BEGIN
	 pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbINICIO);
     pkg_traza.trace(' inuOrden => ' 				|| inuOrden 			|| CHR(10) ||
                     'inuCausal  => '				|| inuCausal 			|| CHR(10) ||
                     'inuPersona  => '				|| inuPersona 			|| CHR(10) ||
                     'idtFechIniEje  => '			|| idtFechIniEje 		|| CHR(10) ||
                     'idtFechaFinEje => '			|| idtFechaFinEje 		|| CHR(10) ||
                     'isbDatosAdic  => '			|| isbDatosAdic 		|| CHR(10) ||
                     'isbActividades  => '			|| isbActividades 		|| CHR(10) ||
                     'isbItemsElementos  => '		|| isbItemsElementos 	|| CHR(10) ||
                     'isbLecturaElementos  => '	|| isbLecturaElementos 	|| CHR(10) ||
                     'isbComentariosOrden  => '	|| isbComentariosOrden, csbNivelTraza);
     IF  pkg_bcordenes.fnuObtieneClaseCausal(InuCausal) = pkg_gestionordenes.cnucausalexito THEN

         refCursor := pkg_tmp_generica.fcuConsultar();

         LOOP
           FETCH refCursor INTO regTmpGenerica;
             EXIT WHEN refCursor%NOTFOUND;
                --se valida que la orden sea la que se esta legalizando
                IF regTmpGenerica.nudato_01 = inuOrden THEN
                  pkg_producto.prActualizaSoloEstadoCorte(regTmpGenerica.nudato_02, regTmpGenerica.nudato_03);
                  pkg_producto.prActualizaMetodoAnVarCon(regTmpGenerica.nudato_02, pkg_gestion_producto.cnuMetAnalisisConPrSinMedi);
                  EXIT;
                END IF;           
         END LOOP;
         CLOSE refCursor;
     END IF;

	 pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_Error.Controlled_Error  THEN
        pkg_error.getError(nuError, sbError);      
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbFIN_ERC);
        RAISE  pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_error.getError(nuError, sbError);       
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbFIN_ERR);
        RAISE  pkg_Error.Controlled_Error;
END oal_InactivarProdCastigado;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('OAL_INACTIVARPRODCASTIGADO', 'PERSONALIZACIONES');
END;
/
