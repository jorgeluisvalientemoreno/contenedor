create or replace PROCEDURE personalizaciones.oal_ActivarProdCastigado(   inuOrden            IN NUMBER,
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
      Programa        : oal_ActivarProdCastigado
      Descripcion     : Servicio PRE para activar de forma temporal un producto castigado

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
    csbMT_NAME      VARCHAR2(150) := 'OAL_ACTIVARPRODCASTIGADO';
    csbNivelTraza   CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    csbEstaFinCast  CONSTANT VARCHAR2(1)    := 'C';

    nuProducto      NUMBER;
    nuError         NUMBER;
    sbError         VARCHAR2(4000);
    regProducto     pkg_bcproducto.sbtServSusc;

    regTmpGenerica  tmp_generica%rowtype;

  BEGIN
	 pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbINICIO);
     pkg_traza.trace(' inuOrden => ' 				|| inuOrden 			|| CHR(10) ||
                     ' inuCausal  => '				|| inuCausal 			|| CHR(10) ||
                     ' inuPersona  => '				|| inuPersona 			|| CHR(10) ||
                     ' idtFechIniEje  => '			|| idtFechIniEje 		|| CHR(10) ||
                     ' idtFechaFinEje => '			|| idtFechaFinEje 		|| CHR(10) ||
                     ' isbDatosAdic  => '			|| isbDatosAdic 		|| CHR(10) ||
                     ' isbActividades  => '			|| isbActividades 		|| CHR(10) ||
                     ' isbItemsElementos  => '		|| isbItemsElementos 	|| CHR(10) ||
                     ' isbLecturaElementos  => '	|| isbLecturaElementos 	|| CHR(10) ||
                     ' isbComentariosOrden  => '	|| isbComentariosOrden, csbNivelTraza);
     IF  pkg_bcordenes.fnuObtieneClaseCausal(inuCausal) = pkg_gestionordenes.cnucausalexito THEN
         nuProducto := pkg_bcordenes.fnuObtieneProducto(inuOrden);
         pkg_traza.trace(' nuProducto => '|| nuProducto, csbNivelTraza);
         regProducto := pkg_bcproducto.frcObtProducto(nuProducto);
         pkg_traza.trace(' regProducto.sesuesfn => '|| regProducto.sesuesfn, csbNivelTraza);
         --se valida que el producto este castigado
         IF regProducto.sesuesfn = csbEstaFinCast THEN

            regTmpGenerica.nudato_01 := inuOrden;
            regTmpGenerica.nudato_02 := nuProducto;
            regTmpGenerica.nudato_03 := regProducto.sesuesco;
            regTmpGenerica.fechasys  := sysdate;

            pkg_tmp_generica.prInsertar(regTmpGenerica);

            pkg_producto.prActualizaSoloEstadoCorte(nuProducto, pkg_gestion_producto.cnuestado_conexion_servsusc);

         END IF;

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
END oal_ActivarProdCastigado;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('OAL_ACTIVARPRODCASTIGADO', 'PERSONALIZACIONES');
END;
/
