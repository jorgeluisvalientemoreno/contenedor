CREATE OR REPLACE PACKAGE adm_person.pkg_suspcone IS
  /*******************************************************************************
      Propiedad Intelectual de Gases del Caribe
      
    Programa    : pkg_suspcone
    Autor       : Carlos Gonzalez - Horbath
    Fecha       : 10-01-2024
    Descripcion : Paquete con servicios CRUD sobre la entidad OPEN.SUSPCONE
      
    Modificaciones  :
    Autor           Fecha       Caso        Descripcion
    cgonzalez       10-01-2024  OSF-2178    Creacion
    jsoto           19/01/2024  OSF-2179    Replicar objeto en BD GDC
  *******************************************************************************/

  --Retona el identificador del ultimo caso que hizo cambios
  FUNCTION fsbVersion RETURN VARCHAR2;

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  
  Programa        : prc_ActFechaAtencionRowId
  Descripcion     : Actualizar la fecha de atencion de una suspension por RowID
  *******************************************************************************/
  PROCEDURE prc_ActFechaAtencionRowId(inuSuspconeRowId IN ROWID,
                                      idtFechaAtencion IN suspcone.sucofeat%type,
                                      onuCodigoError   OUT NUMBER,
                                      osbMensajeError  OUT VARCHAR2);

  --Inserta Registro en al entidad SUSPCONE
  procedure prcInsertaRegistro(irfRegistro IN suspcone%rowtype);

END pkg_suspcone;
/
CREATE OR REPLACE PACKAGE BODY adm_person.pkg_suspcone IS

  -- Constantes para el control de la traza
  csbSP_NAME CONSTANT VARCHAR2(100) := $$PLSQL_UNIT;

  -- Identificador del ultimo caso que hizo cambios
  csbVersion CONSTANT VARCHAR2(15) := 'OSF-2477';

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor         : Carlos Gonzalez - Horbath
    Fecha         : 10-01-2024
  
    Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   10-01-2024  OSF-2178 Creacion
  ***************************************************************************/
  FUNCTION fsbVersion RETURN VARCHAR2 IS
  BEGIN
    RETURN csbVersion;
  END fsbVersion;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
  Programa        : prc_ActualizaCausalOrden
    Descripcion     : Actualizar la causal de una orden
  
    Autor         :   Carlos Gonzalez - Horbath
    Fecha         :   10-01-2024
  
    Parametros de Entrada
      inuSuspconeRowId   RowID de la entidad SUSPCONE
      idtFechaAtencion   Fecha de Atencion
    Parametros de Salida
      onuCodigoError    Codigo de error
      osbMensajeError   Mensaje de error
    
  Modificaciones  :
    Autor       Fecha       Caso     Descripcion
    cgonzalez   10-01-2024  OSF-2178 Creacion
  ***************************************************************************/
  PROCEDURE prc_ActFechaAtencionRowId(inuSuspconeRowId IN ROWID,
                                      idtFechaAtencion IN suspcone.sucofeat%type,
                                      onuCodigoError   OUT NUMBER,
                                      osbMensajeError  OUT VARCHAR2) IS
    csbMT_NAME VARCHAR2(100) := csbSP_NAME || '.prc_ActFechaAtencionRowId';
  BEGIN
    pkg_traza.trace(csbMT_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
    pkg_traza.trace('inuSuspconeRowId => ' || inuSuspconeRowId,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('idtFechaAtencion => ' || idtFechaAtencion,
                    pkg_traza.cnuNivelTrzDef);
    pkg_error.prInicializaError(onuCodigoError, osbMensajeError);
  
    UPDATE suspcone
       SET sucofeat = idtFechaAtencion
     WHERE suspcone.rowid = inuSuspconeRowId;
  
    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_error.geterror(onuCodigoError, osbMensajeError);
      pkg_traza.trace(' osbMensajeError => ' || osbMensajeError,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
      pkg_error.setError;
      pkg_error.geterror(onuCodigoError, osbMensajeError);
      pkg_traza.trace(' osbMensajeError => ' || osbMensajeError,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
  END prc_ActFechaAtencionRowId;

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : prcInsertaRegistro
  Descripcion     : Inserta Registro en al entidad SUSPCONE
  Autor           : Jorge Valiente
  Fecha           : 18/03/2024 
  
  Parametros de Entrada
  irfRegistro Registro de datos a insertar
  
  Parametros de Salida
  
  Modificaciones  :
  Autor       Fecha       Caso     Descripcion
  ***************************************************************************/
  procedure prcInsertaRegistro(irfRegistro IN suspcone%rowtype) is
    -- Nombre de este metodo
    csbMetodo   VARCHAR2(70) := csbSP_NAME || '.prcInsertaRegistro';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error
  
    nuQSUSPCONENextVal number;
  
  BEGIN
  
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    nuQSUSPCONENextVal := SQSUSPCONE.nextval;
  
    INSERT INTO Suspcone
      (Sucodepa,
       Sucoloca,
       Suconuor,
       Sucosusc,
       Sucoserv,
       Suconuse,
       Sucotipo,
       Sucofeor,
       Sucofeat,
       Sucocacd,
       Sucoobse,
       Sucocoec,
       Sucoidsc,
       Cause_Failure,
       Process_Status,
       Sucocicl,
       Sucocent,
       Sucoprog,
       Sucoterm,
       Sucousua,
       Sucoorim,
       Sucoactiv_Id,
       Sucoordtype,
       Sucoacgc,
       Sucocupo)
    VALUES
      (irfRegistro.Sucodepa,
       irfRegistro.Sucoloca,
       irfRegistro.Suconuor,
       irfRegistro.Sucosusc,
       irfRegistro.Sucoserv,
       irfRegistro.Suconuse,
       irfRegistro.Sucotipo,
       irfRegistro.Sucofeor,
       irfRegistro.Sucofeat,
       irfRegistro.Sucocacd,
       irfRegistro.Sucoobse,
       irfRegistro.Sucocoec,
       nuQSUSPCONENextVal,
       irfRegistro.Cause_Failure,
       irfRegistro.Process_Status,
       irfRegistro.Sucocicl,
       irfRegistro.Sucocent,
       irfRegistro.Sucoprog,
       irfRegistro.Sucoterm,
       irfRegistro.Sucousua,
       irfRegistro.Sucoorim,
       irfRegistro.Sucoactiv_Id,
       irfRegistro.Sucoordtype,
       irfRegistro.Sucoacgc,
       irfRegistro.Sucocupo);
  
    pkg_traza.trace('Se registra DATA en SUSPCONE',
                    pkg_traza.cnuNivelTrzDef);
  
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
    
  END prcInsertaRegistro;

END pkg_suspcone;
/
BEGIN
	pkg_utilidades.prAplicarPermisos('PKG_SUSPCONE', 'ADM_PERSON');
END;
/