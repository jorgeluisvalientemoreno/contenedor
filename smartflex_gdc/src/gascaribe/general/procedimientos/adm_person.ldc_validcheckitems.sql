create or replace PROCEDURE ADM_PERSON.LDC_VALIDCHECKITEMS
IS
    /*******************************************************************************
   Metodo:       LDC_VALIDCHECKITEMS
   Descripcion:  Procedimiento usado como regla de validacion para verificar que los campos
     estan llenos en el PB y para validar que por lo menos se haya seleccionado
     un check y que los dos no estan seleccionados al tiempo

   Autor:        Olsoftware/Miguel Ballesteros
   Fecha:        23/07/2020


   Historia de Modificaciones
   FECHA          AUTOR                       DESCRIPCION
   10/04/2024     jpinedc                     OSF-2379: Se reemplaza utl_file por
                                              pkg_gestionArchivos y se implementan
                                              últimos estadares de programación
   15/04/2024     jpinedc                     OSF-2379: Ajustes validación técnica
   24/04/2024     Adrianavg                   OSF-2597: Se migra del esquema OPEN al esquema ADM_PERSON
  *******************************************************************************/

    csbMetodo        CONSTANT VARCHAR2(70) :=  'LDC_VALIDCHECKITEMS';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    nuError         NUMBER;
    sbError         VARCHAR2(4000);

    sbDirectory_id    ge_boInstanceControl.stysbValue;
    sbNombreArchivo   ge_boInstanceControl.stysbValue;
    chkActividad      ge_boInstanceControl.stysbValue;
    chkItems          ge_boInstanceControl.stysbValue;
    sbmensa           VARCHAR2 (10000);
    sbRutaArchivo     VARCHAR2 (1000);
    blArchivoExiste   BOOLEAN;
    l_file_len        NUMBER;
    l_blocksize       BINARY_INTEGER;
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

    sbDirectory_id :=
        ge_boInstanceControl.fsbGetFieldValue ('GE_DIRECTORY',
                                               'DIRECTORY_ID');
    sbNombreArchivo :=
        ge_boInstanceControl.fsbGetFieldValue ('OR_ORDER_COMMENT',
                                               'ORDER_COMMENT');
    chkActividad :=
        ge_boInstanceControl.fsbGetFieldValue ('OR_ORDER_COMMENT',
                                               'LEGALIZE_COMMENT');
    chkItems :=
        ge_boInstanceControl.fsbGetFieldValue ('GE_VARIABLE', 'COMPARABLE');

    ------------------------------------------------
    -- Required Attributes
    ------------------------------------------------
    IF (sbDirectory_id IS NULL)
    THEN
        sbmensa := 'Debe ingresar el directorio';
        pkg_error.setErrorMessage( isbMsgErrr => sbmensa);
    ELSE
        sbRutaArchivo := pkg_BCDirectorios.fsbGetRuta (sbDirectory_id);
    END IF;

    IF (sbNombreArchivo IS NULL)
    THEN
        sbmensa := 'Debe ingresar el nombre del archivo';
        pkg_error.setErrorMessage( isbMsgErrr => sbmensa);
    END IF;

    IF (   chkActividad IS NULL AND chkItems IS NULL
        OR chkActividad = 'N' AND chkItems = 'N'
        OR chkActividad = 'N' AND chkItems IS NULL
        OR chkActividad IS NULL AND chkItems = 'N')
    THEN
        sbmensa := 'Debe seleccionar el tipo de item a crear [Actividad - Item]';
        pkg_error.setErrorMessage( isbMsgErrr => sbmensa);
    END IF;

    IF (chkActividad = 'Y' AND chkItems = 'Y')
    THEN
        sbmensa := 'Debe seleccionar solo un tipo de item a crear';
        pkg_error.setErrorMessage( isbMsgErrr => sbmensa);
    END IF;

    -- se valida si el archivo existe en el servidor --
    pkg_gestionArchivos.prcAtributosArchivo_SMF (
        isbDirectorio      => sbRutaArchivo,
        isbArchivo         => sbNombreArchivo,
        oblExisteArchivo   => blArchivoExiste,
        onuTamanoArchivo   => l_file_len,
        onuTamanoBloque    => l_blocksize);


    IF (blArchivoExiste = FALSE)
    THEN
        sbmensa := 'No se encontro ningun archivo con ese nombre en el servidor!!!';
        pkg_error.setErrorMessage( isbMsgErrr => sbmensa);
    END IF;
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

EXCEPTION
    WHEN pkg_Error.CONTROLLED_ERROR
    THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
        pkg_Error.getError(nuError,sbError);
        pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
        RAISE pkg_Error.CONTROLLED_ERROR;
    WHEN OTHERS
    THEN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
        pkg_Error.setError;
        pkg_Error.getError(nuError,sbError);
        pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
        RAISE pkg_Error.CONTROLLED_ERROR;
END LDC_VALIDCHECKITEMS; 
/
PROMPT OTORGA PERMISOS ESQUEMA sobre funcion LDC_VALIDCHECKITEMS
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_VALIDCHECKITEMS', 'ADM_PERSON'); 
END;
/