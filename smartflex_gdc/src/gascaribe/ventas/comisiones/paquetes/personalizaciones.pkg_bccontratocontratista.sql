CREATE OR REPLACE PACKAGE personalizaciones.pkg_BcContratoContratista IS
  /*******************************************************************************
      Fuente=Propiedad Intelectual de Gases del Caribe
      pkg_BcContratoContratista
      Autor            : Jorge Valiente  
      Fecha            : 24/06/2024  
      Caso             : OSF-2742
      Descripcion      : Paquete para realizar consultas relacionadas al contrato de un contratista  
  
      Modificaciones   : 
      Autor       Fecha       Caso    Descripcion
  *******************************************************************************/

  -- Retorna Categoria del producto
  FUNCTION fsbContratoVigentexTipTra(InuTipoTrabajo number,
                                     inuContratista number) RETURN varchar2;

END pkg_BcContratoContratista;
/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_BcContratoContratista IS

  -- Constantes para el control de la traza
  csbSP_NAME CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';
  cnuNVLTRC  CONSTANT NUMBER(2) := pkg_traza.cnuNivelTrzDef;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbContratoVigentexTipTra
    Descripcion     : Retorna S o N el contrato del contratista esta abierto y vigente
    Autor           : Jorge Valiente
    Fecha           : 14/06/2024
    
    Parametros de Entrada
    Nombre          Descripcion
    -----------------------------------------------
    inuTipoTrabajo  Codigo del tipo de trabajo
    inuContratista  Codigo del contratista
                                     
    Parametros de Salida  
    Nombre         Descripcion
    -----------------------------------------------
    
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
  ***************************************************************************/
  FUNCTION fsbContratoVigentexTipTra(inuTipoTrabajo number,
                                     inuContratista number) RETURN varchar2 IS
  
    -- Nombre de ste mEtodo
    csbMetodo VARCHAR2(70) := csbSP_NAME || 'fsbContratoVigentexTipTra';
    nuError   NUMBER; -- se almacena codigo de error
    sbError   VARCHAR2(2000); -- se almacena descripcion del error 
  
    cursor cuContratoVigentexTipTra is
      SELECT distinct id_contrato
        FROM ge_contrato c, ct_tasktype_contype ctt
       WHERE ctt.contract_type_id = c.id_tipo_contrato
         and c.id_contratista = inuContratista
         and c.fecha_final > sysdate
         AND ctt.flag_type = 'T'
         AND c.status in ('AB')
         AND ctt.task_type_id = inuTipoTrabajo
         AND not exists (select null
                from ct_tasktype_contype ct2
               where ct2.contract_id = c.id_contrato
                 and ct2.flag_type = 'C')
      UNION ALL
      SELECT distinct id_contrato
        FROM ge_contrato c, ct_tasktype_contype ctt
       WHERE ctt.contract_id = c.id_contrato
         and c.id_contratista = inuContratista
         and c.fecha_final > sysdate
         AND ctt.flag_type = 'C'
         AND c.status in ('AB')
         AND ctt.task_type_id = inuTipoTrabajo;
  
    sbContratoVigente varchar2(1) := 'N';
  
    nuContratoVigentexTipTra number;
  
  BEGIN
  
    pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbINICIO);
  
    pkg_traza.trace('Tipo de trabajo: ' || InuTipoTrabajo, cnuNVLTRC);
    pkg_traza.trace('Contratista: ' || inuContratista, cnuNVLTRC);
  
    open cuContratoVigentexTipTra;
    fetch cuContratoVigentexTipTra
      into nuContratoVigentexTipTra;
    if cuContratoVigentexTipTra%found then
      sbContratoVigente := 'S';
    end if;
    close cuContratoVigentexTipTra;
  
    pkg_traza.trace('Contrato Vigente: ' || sbContratoVigente, cnuNVLTRC);
  
    pkg_traza.trace(csbMetodo, cnuNVLTRC, pkg_traza.csbFIN);
  
    return sbContratoVigente;
  
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error: ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      return sbContratoVigente;
    
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error: ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      return sbContratoVigente;
    
  END fsbContratoVigentexTipTra;

END pkg_BcContratoContratista;
/
begin
  pkg_utilidades.prAplicarPermisos('PKG_BCCONTRATOCONTRATISTA',
                                   'PERSONALIZACIONES');
end;
/
