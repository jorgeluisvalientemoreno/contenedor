CREATE OR REPLACE PACKAGE pkg_truncate_tablas_open IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : pkg_truncate_tablas_open
    Descripcion     : Paquete para crear utilidades truncar tablas
    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 16-07-2024

    Parametros de Entrada     
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor             Fecha       Caso    	    Descripcion
    felipe.valencia   30/04/2024  OSF-2645      Creación 
    jpinedc           14/08/2024  OSF-3126      Se crean
                                                * prcldc_log_pamot
                                                * prcldc_usercartaspolit
                                                * prcldc_notas_masivas
                                                * prcldc_cargosfact_castigo_tmp
  ***************************************************************************/

  PROCEDURE prcldc_cartdiara_tmp;

  PROCEDURE prcldc_cartdiara_tmp2;

  PROCEDURE prcldc_cartdiara_tmp3;

  PROCEDURE prcldc_cartdiara_tmp4;

  PROCEDURE prcldc_cartdiara_tmp5;

  PROCEDURE prcldc_cartdiara_tmp6;

  PROCEDURE prcldc_cartdiara_tmp7;

  PROCEDURE prcldc_cartdiara_tmp8;

  PROCEDURE prcldc_cartdiara_tmp9;

  PROCEDURE prcldc_cartdiara_tmp10;

  PROCEDURE prcldc_cartdiara_tmp11;

  PROCEDURE prcldc_cartdiara_tmp12;

  PROCEDURE prcldc_concepto_diaria;
  
  PROCEDURE prcldc_log_pamot;
  
  PROCEDURE prcldc_usercartaspolit;
  
  PROCEDURE prcldc_notas_masivas;

  PROCEDURE prcldc_cargosfact_castigo_tmp; 

  PROCEDURE prcldc_snapshotcreg_tmp;

  PROCEDURE prcLdc_FormTemp;
  
  PROCEDURE prcLdc_Datos_Certificado_met;
  

END pkg_truncate_tablas_open;
/

CREATE OR REPLACE PACKAGE BODY pkg_truncate_tablas_open IS

    -- Identificador del ultimo caso que hizo cambios
    csbVersion     VARCHAR2(15) := 'OSF-3693';
    -- Constantes para el control de la traza
    csbSP_NAME     CONSTANT VARCHAR2(35):= $$PLSQL_UNIT;
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion 
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Felipe Valencia Hurtado
    Fecha           : 16/07/2024
    Modificaciones  :
    Autor               Fecha       Caso     Descripcion
    felipe.valencia     16/07/2024  OSF-263 Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;

    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : prcldc_cartdiara_tmp
      Descripcion     : Paquete para crear utilidades truncar tablas
      Autor           : Luis Felipe Valencia Hurtado
      Fecha           : 16-07-2024

      Parametros de Entrada
      Parametros de Salida

      Modificaciones  :
      =========================================================
      Autor       Fecha       Caso    Descripcion
    ***************************************************************************/
    PROCEDURE prcldc_cartdiara_tmp
    IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : prcldc_cartdiara_tmp
      Descripcion     : Proceso para truncar tabla LDC_CARTDIARIA_TMP
      Autor           : Luis Felipe Valencia Hurtado
      Fecha           : 16-07-2024

      Parametros de Entrada     
        isbTabla       nombre de la tabla
      Parametros de Salida

      Modificaciones  :
      =========================================================
      Autor       Fecha       Caso    Descripcion
    ***************************************************************************/
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'prcldc_cartdiara_tmp';
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        EXECUTE IMMEDIATE 'TRUNCATE TABLE LDC_CARTDIARIA_TMP';

        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;   
    END prcldc_cartdiara_tmp;

    PROCEDURE prcldc_cartdiara_tmp2
    IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : prcldc_cartdiara_tmp2
      Descripcion     : Proceso para truncar tabla LDC_CARTDIARIA_TMP2
      Autor           : Luis Felipe Valencia Hurtado
      Fecha           : 16-07-2024

      Parametros de Entrada     
        isbTabla       nombre de la tabla
      Parametros de Salida

      Modificaciones  :
      =========================================================
      Autor       Fecha       Caso    Descripcion
    ***************************************************************************/
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'prcldc_cartdiara_tmp2';
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        
        EXECUTE IMMEDIATE 'TRUNCATE TABLE LDC_CARTDIARIA_TMP2';
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;   
    END prcldc_cartdiara_tmp2;

    PROCEDURE prcldc_cartdiara_tmp3
    IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : prcldc_cartdiara_tmp3
      Descripcion     : Proceso para truncar tabla LDC_CARTDIARIA_TMP3
      Autor           : Luis Felipe Valencia Hurtado
      Fecha           : 16-07-2024

      Parametros de Entrada     
        isbTabla       nombre de la tabla
      Parametros de Salida

      Modificaciones  :
      =========================================================
      Autor       Fecha       Caso    Descripcion
    ***************************************************************************/
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'prcldc_cartdiara_tmp3';
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        EXECUTE IMMEDIATE 'TRUNCATE TABLE LDC_CARTDIARIA_TMP3';
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;   
    END prcldc_cartdiara_tmp3;

    PROCEDURE prcldc_cartdiara_tmp4
    IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : prcldc_cartdiara_tmp3
      Descripcion     : Proceso para truncar tabla prcldc_cartdiara_tmp4
      Autor           : Luis Felipe Valencia Hurtado
      Fecha           : 16-07-2024

      Parametros de Entrada     
        isbTabla       nombre de la tabla
      Parametros de Salida

      Modificaciones  :
      =========================================================
      Autor       Fecha       Caso    Descripcion
    ***************************************************************************/
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'prcldc_cartdiara_tmp4';
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        EXECUTE IMMEDIATE 'TRUNCATE TABLE LDC_CARTDIARIA_TMP4';
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;   
    END prcldc_cartdiara_tmp4;


    PROCEDURE prcldc_cartdiara_tmp5
    IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : prcldc_cartdiara_tmp5
      Descripcion     : Proceso para truncar tabla prcldc_cartdiara_tmp5
      Autor           : Luis Felipe Valencia Hurtado
      Fecha           : 16-07-2024

      Parametros de Entrada     
        isbTabla       nombre de la tabla
      Parametros de Salida

      Modificaciones  :
      =========================================================
      Autor       Fecha       Caso    Descripcion
    ***************************************************************************/
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'prcldc_cartdiara_tmp5';
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        EXECUTE IMMEDIATE 'TRUNCATE TABLE LDC_CARTDIARIA_TMP5';
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;   
    END prcldc_cartdiara_tmp5;

    PROCEDURE prcldc_cartdiara_tmp6
    IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : prcldc_cartdiara_tmp6
      Descripcion     : Proceso para truncar tabla prcldc_cartdiara_tmp6
      Autor           : Luis Felipe Valencia Hurtado
      Fecha           : 16-07-2024

      Parametros de Entrada     
        isbTabla       nombre de la tabla
      Parametros de Salida

      Modificaciones  :
      =========================================================
      Autor       Fecha       Caso    Descripcion
    ***************************************************************************/
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'prcldc_cartdiara_tmp6';
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        EXECUTE IMMEDIATE 'TRUNCATE TABLE LDC_CARTDIARIA_TMP6';
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;   
    END prcldc_cartdiara_tmp6;

    PROCEDURE prcldc_cartdiara_tmp7
    IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : prcldc_cartdiara_tmp7
      Descripcion     : Proceso para truncar tabla prcldc_cartdiara_tmp7
      Autor           : Luis Felipe Valencia Hurtado
      Fecha           : 16-07-2024

      Parametros de Entrada     
        isbTabla       nombre de la tabla
      Parametros de Salida

      Modificaciones  :
      =========================================================
      Autor       Fecha       Caso    Descripcion
    ***************************************************************************/
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'prcldc_cartdiara_tmp7';
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        EXECUTE IMMEDIATE 'TRUNCATE TABLE LDC_CARTDIARIA_TMP7';
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;   
    END prcldc_cartdiara_tmp7;


    PROCEDURE prcldc_cartdiara_tmp8
    IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : prcldc_cartdiara_tmp8
      Descripcion     : Proceso para truncar tabla prcldc_cartdiara_tmp8
      Autor           : Luis Felipe Valencia Hurtado
      Fecha           : 16-07-2024

      Parametros de Entrada     
        isbTabla       nombre de la tabla
      Parametros de Salida

      Modificaciones  :
      =========================================================
      Autor       Fecha       Caso    Descripcion
    ***************************************************************************/
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'prcldc_cartdiara_tmp8';
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        EXECUTE IMMEDIATE 'TRUNCATE TABLE LDC_CARTDIARIA_TMP8';
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;   
    END prcldc_cartdiara_tmp8;

    PROCEDURE prcldc_cartdiara_tmp9
    IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : prcldc_cartdiara_tmp9
      Descripcion     : Proceso para truncar tabla LDC_CARTDIARIA_TMP9
      Autor           : Luis Felipe Valencia Hurtado
      Fecha           : 16-07-2024

      Parametros de Entrada     
        isbTabla       nombre de la tabla
      Parametros de Salida

      Modificaciones  :
      =========================================================
      Autor       Fecha       Caso    Descripcion
    ***************************************************************************/
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'prcldc_cartdiara_tmp9';
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        EXECUTE IMMEDIATE 'TRUNCATE TABLE LDC_CARTDIARIA_TMP9';
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;   
    END prcldc_cartdiara_tmp9;

    PROCEDURE prcldc_cartdiara_tmp10
    IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : prcldc_cartdiara_tmp10
      Descripcion     : Proceso para truncar tabla LDC_CARTDIARIA_TMP10
      Autor           : Luis Felipe Valencia Hurtado
      Fecha           : 16-07-2024

      Parametros de Entrada     
        isbTabla       nombre de la tabla
      Parametros de Salida

      Modificaciones  :
      =========================================================
      Autor       Fecha       Caso    Descripcion
    ***************************************************************************/
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'prcldc_cartdiara_tmp10';
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        EXECUTE IMMEDIATE 'TRUNCATE TABLE LDC_CARTDIARIA_TMP10';
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;   
    END prcldc_cartdiara_tmp10;

    PROCEDURE prcldc_cartdiara_tmp11
    IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : prcldc_cartdiara_tmp11
      Descripcion     : Proceso para truncar tabla LDC_CARTDIARIA_TMP11
      Autor           : Luis Felipe Valencia Hurtado
      Fecha           : 16-07-2024

      Parametros de Entrada     
        isbTabla       nombre de la tabla
      Parametros de Salida

      Modificaciones  :
      =========================================================
      Autor       Fecha       Caso    Descripcion
    ***************************************************************************/
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'prcldc_cartdiara_tmp11';
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        EXECUTE IMMEDIATE 'TRUNCATE TABLE LDC_CARTDIARIA_TMP11';
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;   
    END prcldc_cartdiara_tmp11;

    PROCEDURE prcldc_cartdiara_tmp12
    IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : prcldc_cartdiara_tmp12
      Descripcion     : Proceso para truncar tabla LDC_CARTDIARIA_TMP12
      Autor           : Luis Felipe Valencia Hurtado
      Fecha           : 16-07-2024

      Parametros de Entrada     
        isbTabla       nombre de la tabla
      Parametros de Salida

      Modificaciones  :
      =========================================================
      Autor       Fecha       Caso    Descripcion
    ***************************************************************************/
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'prcldc_cartdiara_tmp12';
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        EXECUTE IMMEDIATE 'TRUNCATE TABLE LDC_CARTDIARIA_TMP12';
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;   
    END prcldc_cartdiara_tmp12;


    PROCEDURE prcldc_concepto_diaria
    IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : prcldc_cartdiara_tmp12
      Descripcion     : Proceso para truncar tabla LDC_CARTDIARIA_TMP12
      Autor           : Luis Felipe Valencia Hurtado
      Fecha           : 16-07-2024

      Parametros de Entrada     
        isbTabla       nombre de la tabla
      Parametros de Salida

      Modificaciones  :
      =========================================================
      Autor       Fecha       Caso    Descripcion
    ***************************************************************************/
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'prcldc_concepto_diaria';
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        EXECUTE IMMEDIATE 'TRUNCATE TABLE LDC_CONCEPTO_DIARIA';
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;   
    END prcldc_concepto_diaria;

    PROCEDURE prcldc_log_pamot
    IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : prcldc_log_pamot
      Descripcion     : Proceso para truncar tabla LDC_LOG_PAMOT
      Autor           : Lubin Pineda
      Fecha           : 14-08-2024

      Parametros de Entrada     
        isbTabla       nombre de la tabla
      Parametros de Salida

      Modificaciones  :
      =========================================================
      Autor         Fecha       Caso        Descripcion
      jpinedc       14/08/2024  OSF-3126    Creación
    ***************************************************************************/
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'prcldc_log_pamot';
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        EXECUTE IMMEDIATE 'TRUNCATE TABLE LDC_LOG_PAMOT';
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;   
    END prcldc_log_pamot;
    
    PROCEDURE prcldc_usercartaspolit
    IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : prcldc_usercartaspolit
      Descripcion     : Proceso para truncar tabla LDC_USERCARTASPOLIT
      Autor           : Lubin Pineda
      Fecha           : 14-08-2024

      Parametros de Entrada     
        isbTabla       nombre de la tabla
      Parametros de Salida

      Modificaciones  :
      =========================================================
      Autor         Fecha       Caso        Descripcion
      jpinedc       14/08/2024  OSF-3126    Creación
    ***************************************************************************/
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'prcldc_usercartaspolit';
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        EXECUTE IMMEDIATE 'TRUNCATE TABLE LDC_USERCARTASPOLIT';
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;   
    END prcldc_usercartaspolit;
    
    PROCEDURE prcldc_notas_masivas
    IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : prcldc_notas_masivas
      Descripcion     : Proceso para truncar tabla LDC_NOTAS_MASIVAS
      Autor           : Lubin Pineda
      Fecha           : 14-08-2024

      Parametros de Entrada     
        isbTabla       nombre de la tabla
      Parametros de Salida

      Modificaciones  :
      =========================================================
      Autor         Fecha       Caso        Descripcion
      jpinedc       14/08/2024  OSF-3126    Creación
    ***************************************************************************/
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'prcldc_notas_masivas';
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        EXECUTE IMMEDIATE 'TRUNCATE TABLE LDC_NOTAS_MASIVAS';
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;   
    END prcldc_notas_masivas;


    PROCEDURE prcldc_cargosfact_castigo_tmp
    IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : prcldc_cargosfact_castigo_tmp
      Descripcion     : Proceso para truncar tabla LDC_CARGOSFACT_CASTIGO_TMP
      Autor           : Lubin Pineda
      Fecha           : 14-08-2024

      Parametros de Entrada     
        isbTabla       nombre de la tabla
      Parametros de Salida

      Modificaciones  :
      =========================================================
      Autor         Fecha       Caso        Descripcion
      jpinedc       14/08/2024  OSF-3126    Creación
    ***************************************************************************/
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'prcldc_cargosfact_castigo_tmp';
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        EXECUTE IMMEDIATE 'TRUNCATE TABLE LDC_CARGOSFACT_CASTIGO_TMP';
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;   
    END prcldc_cargosfact_castigo_tmp;    

    PROCEDURE prcldc_snapshotcreg_tmp
    IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : prcldc_snapshotcreg_tmp
      Descripcion     : Proceso para truncar tabla ldc_snapshotcreg_tmp
      Autor           : Jhon Soto
      Fecha           : 27-09-2024

      Parametros de Entrada     
        isbTabla       nombre de la tabla
      Parametros de Salida

      Modificaciones  :
      =========================================================
      Autor         Fecha       Caso        Descripcion
      jsoto         27/09/2024  OSF-3388    Creación
    ***************************************************************************/
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'prcldc_snapshotcreg_tmp';
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        EXECUTE IMMEDIATE 'TRUNCATE TABLE LDC_SNAPSHOTCREG_TMP';
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;   
    END prcldc_snapshotcreg_tmp;


    PROCEDURE prcLdc_Formtemp
    IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : prcLdc_Formtemp
      Descripcion     : Proceso para truncar tabla Ldc_FormTemp
      Autor           : Jhon Soto
      Fecha           : 26-12-2024

      Parametros de Entrada     
        isbTabla       nombre de la tabla
      Parametros de Salida

      Modificaciones  :
      =========================================================
      Autor         Fecha       Caso        Descripcion
      jsoto         26/12/2024  OSF-3911    Creación
    ***************************************************************************/
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'prcLdc_Formtemp';
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        EXECUTE IMMEDIATE 'TRUNCATE TABLE LDC_FORMTEMP';
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;   
    END prcLdc_Formtemp;

    PROCEDURE prcLdc_Datos_Certificado_met
    IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : prcLdc_Datos_Certificado_met
      Descripcion     : Proceso para truncar tabla LDC_DATOS_CERTIFICADO_MET
      Autor           : Jhon Soto
      Fecha           : 31-01-2025

      Parametros de Entrada     
        isbTabla       nombre de la tabla
      Parametros de Salida

      Modificaciones  :
      =========================================================
      Autor         Fecha       Caso        Descripcion
      jsoto         31/01/2025  OSF-3911    Creación
    ***************************************************************************/
        sbError             VARCHAR2(4000);
        nuError             NUMBER;   
        csbMetodo  CONSTANT VARCHAR2(100) := csbSP_NAME||'prcLdc_Datos_Certificado_met';
    BEGIN
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        EXECUTE IMMEDIATE 'TRUNCATE TABLE LDC_DATOS_CERTIFICADO_MET';
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_Error.Controlled_Error;   
    END prcLdc_Datos_Certificado_met;

END pkg_truncate_tablas_open;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_TRUNCATE_TABLAS_OPEN', 'OPEN');
END;
/

