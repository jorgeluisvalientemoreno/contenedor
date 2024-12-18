CREATE OR REPLACE TRIGGER personalizaciones.trg_au_cambia_estado_predio
AFTER UPDATE OF SESUESFN ON SERVSUSC
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
WHEN (NEW.SESUESFN = 'C' OR  OLD.SESUESFN = 'C')
DECLARE
/************************************************************************************************************
  Autor       : Luis Felipe Valencia
  Fecha       : 18-10-2024
  Proceso     : personalizaciones.trg_au_cambia_estado_predio
  Ticket      : OSF-3488
  Descripcion : Trigger para cambiar el estado del prekdio a castigo

  Historia de Modificaciones
  Fecha               Autor                             Modificacion
  =========           =========                      ====================
  18-10-2024          felipe.valencia                Creción
 *************************************************************************************************************/
    --Constantes
	csbMT_NAME          VARCHAR2(100) := $$PLSQL_UNIT;
    
    --Variables
	sbError             VARCHAR(4000);
	nuError             NUMBER;
    
    nuInfoPredioId      ldc_info_predio.ldc_info_predio_id%TYPE;

    nuDireccion         ab_address.address_id%TYPE;

    -- Producto a procesar
    nuProducto          servsusc.sesunuse%type;
    csbNivelTraza           CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
BEGIN
    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);  

    nuProducto := :NEW.sesunuse; 

    nuDireccion := pkg_bcproducto.fnuiddireccinstalacion(nuProducto);

    pkg_Traza.trace('Direccion del producto ['||nuDireccion||']',csbNivelTraza);

    nuInfoPredioId := pkg_bcInfoPredio.fnuObtieneInfoPredio(nuDireccion);

    IF (nuInfoPredioId IS NOT NULL) THEN
        IF ( :NEW.sesuesfn = 'C') THEN  
            pkg_Traza.trace('Marca producto en ldc_infor_predio castigado S', csbNivelTraza );
            pkg_ldc_info_predio.prcActualizaCastigo(nuInfoPredioId,'S');
        ELSIF (:OLD.sesuesfn = 'C') THEN
            pkg_Traza.trace('Marca producto en ldc_infor_predio castigado N', csbNivelTraza );
            pkg_ldc_info_predio.prcActualizaCastigo(nuInfoPredioId,'N');
        END IF;
    END IF;
    
    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    
EXCEPTION
    WHEN pkg_error.controlled_error  THEN
          pkg_error.geterror(nuerror, sberror);
          pkg_traza.TRACE('sbError: ' || sberror, pkg_traza.cnuniveltrzdef);
          pkg_traza.TRACE(csbmt_name, pkg_traza.cnuniveltrzdef, pkg_traza.csbfin_erc);
          RAISE pkg_error.controlled_error;
    WHEN OTHERS THEN

          pkg_error.seterror;
          pkg_error.geterror(nuerror, sberror);
          pkg_traza.TRACE('sbError: ' || sberror, pkg_traza.cnuniveltrzdef);
          pkg_traza.TRACE(csbmt_name, pkg_traza.cnuniveltrzdef, pkg_traza.csbfin_err);
          RAISE pkg_error.controlled_error;   
END trg_au_cambia_estado_predio;
/
