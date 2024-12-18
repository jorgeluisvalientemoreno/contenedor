CREATE OR REPLACE PACKAGE ADM_PERSON.PKG_BOEXENCION AS

  /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : PKG_BOEXENCION
      Descripcion     : PAQUETE PARA EL CONTROL Y MANEJO DE EXECION
      Autor           : Jorge Valiente
      Fecha           : 06-03-2024
  
      Modificaciones  :
      =========================================================
      Autor       Fecha       Caso    Descripcion
  ***************************************************************************/

  --servicio que permite crear o ampliar la promocion de exencion de contribucion a un determinado porducto.
  PROCEDURE prcAmpliacionExencion(NUPRODUCT_ID   NUMBER,
                                  NUPROMOTION_ID NUMBER,
                                  DTFECHA        DATE,
                                  NUPACKAGE_ID   NUMBER,
                                  NUACCION       NUMBER);

END PKG_BOEXENCION;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.PKG_BOEXENCION AS

  -- Constantes para el control de la traza
  csbSP_NAME CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';
  -- Identificador del ultimo caso que hizo cambios
  csbVersion VARCHAR2(15) := 'OSF-2414';

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona DATA de usuarios
    Autor           : Jorge Valiente
    Fecha           : 06-03-2024
  
    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/
  FUNCTION fsbVersion RETURN VARCHAR2 IS
  BEGIN
    RETURN csbVersion;
  END fsbVersion;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcAmpliacionExencion
    Descripcion     : servicio que permite crear o ampliar la promocion de exencion de contribucion a un determinado porducto.
    Autor           : Jorge Valiente
    Fecha           : 06-03-2024

    Parametros      Tipo      Descripcion
    ============    =====      ===================
    NUPRODUCT_ID    Entrada    Codigo de Producto
    NUPROMOTION_ID  Entrada    Codigo de promosion
    DTFECHA         Entrada    Fecha
    NUPACKAGE_ID    Entrada    Codigo de solicitud
    NUACCION        Entrada    Codigo Accion
    
    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/
  PROCEDURE prcAmpliacionExencion(NUPRODUCT_ID   NUMBER,
                                  NUPROMOTION_ID NUMBER,
                                  DTFECHA        DATE,
                                  NUPACKAGE_ID   NUMBER,
                                  NUACCION       NUMBER) IS
  
    INUPACKAGETYPEID ps_package_type.package_type_id%type := PKG_BCSOLICITUDES.FNUGETTIPOSOLICITUD(NUPACKAGE_ID);
    
    INUATTRIBUTEID   number := 5001392; --atributo  del paquete para promosion
    --cursor para validar la exitencia de utlima promocion vigente para un producto
    cursor cupromocionvigente is
      select pp1.*
        from pr_promotion pp1
       where pp1.product_id = NUPRODUCT_ID
         and pp1.final_date =
             (select max(pp.final_date)
                from pr_promotion pp
               where pp.product_id = NUPRODUCT_ID);
  
    tempcupromocionvigente cupromocionvigente%rowtype;
  
    --cursor para obtener al ultima promocion para un producto creada por los servicio de OPEN
    cursor cuultimapromocion is
      select pp1.*
        from pr_promotion pp1
       where pp1.product_id = NUPRODUCT_ID
         and pp1.final_date =
             (select max(pp.final_date)
                from pr_promotion pp
               where pp.product_id = NUPRODUCT_ID);
  
    tempcuultimapromocion cuultimapromocion%rowtype;
  
    --cursor meses configurado en la promocion
    cursor cuCC_PROMOTION is
      select *
        from CC_PROMOTION CP
       WHERE CP.PROMOTION_ID =
             PS_BOPACKTYPEPARAM.FSBGETPACKTYPEPARAM(INUPACKAGETYPEID,
                                                    INUATTRIBUTEID);
  
    tempcuCC_PROMOTION cuCC_PROMOTION%rowtype;
  
    csbMetodo   VARCHAR2(70) := csbSP_NAME || 'prcAmpliacionExencion';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error 
  
  begin
  
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    pkg_traza.trace('Producto: ' || NUPRODUCT_ID, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Promocion: ' || NUPROMOTION_ID,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Fecha: ' || DTFECHA, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Solicitud: ' || NUPACKAGE_ID,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Accion: ' || NUACCION, pkg_traza.cnuNivelTrzDef);
  
    --valida si el prodcuto ya tiene promocion vigente
    open cupromocionvigente;
    fetch cupromocionvigente
      into tempcupromocionvigente;
    close cupromocionvigente;
    --valida si el prodcuto ya tiene promocion vigente
  
    if tempcupromocionvigente.final_date is not null and
       tempcupromocionvigente.cancellation_date is null and
       trunc(sysdate) <= trunc(tempcupromocionvigente.final_date) then
    
      pkg_traza.trace('Actualiza promocion ' ||
                      tempcupromocionvigente.promotion_id,
                      pkg_traza.cnuNivelTrzDef);
    
      --datos de la promocion
      open cuCC_PROMOTION;
      fetch cuCC_PROMOTION
        into tempcuCC_PROMOTION;
      close cuCC_PROMOTION;
    
      update pr_promotion pp
         set pp.final_date = ADD_MONTHS(tempcupromocionvigente.final_date,
                                        tempcuCC_PROMOTION.Amount_Periods)
       where pp.promotion_id = tempcupromocionvigente.promotion_id;
    
    else
    
      pkg_traza.trace('Crea promocion', pkg_traza.cnuNivelTrzDef);
    
      --crear la promocion
      CC_BOASSIGNPROMOTION.ASSIGNPROMOTION(NUPRODUCT_ID,
                                           NUPROMOTION_ID,
                                           DTFECHA,
                                           NULL);
    
      MO_BOMOTIVEACTIONUTIL.EXECTRANSTATUSFORREQU(NUPACKAGE_ID, NUACCION);
      --fin creacion promocion
    
      --/*actualizar fecha de la promocion creada por el servicio CC_BOASSIGNPROMOTION.ASSIGNPROMOTION
      --datos de la promocion
      open cuCC_PROMOTION;
      fetch cuCC_PROMOTION
        into tempcuCC_PROMOTION;
      close cuCC_PROMOTION;
    
      --utlima promocion registrada
      open cuultimapromocion;
      fetch cuultimapromocion
        into tempcuultimapromocion;
      close cuultimapromocion;
    
      --actualizar ultima promocion generada
      update pr_promotion pp
         set pp.initial_date = DTFECHA,
             pp.final_date   = ADD_MONTHS(DTFECHA,
                                          tempcuCC_PROMOTION.Amount_Periods)
       where pp.promotion_id = tempcuultimapromocion.promotion_id;
      --fin actualizar fecha promocion de exencion*/
    
    end if;
  
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
    
      raise pkg_error.CONTROLLED_ERROR;
    
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error: ' || sbMensError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
    
      raise pkg_error.CONTROLLED_ERROR;
    
  END prcAmpliacionExencion;

END PKG_BOEXENCION;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_BOEXENCION', 'ADM_PERSON');
END;
/
