CREATE OR REPLACE TRIGGER personalizaciones.trg_au_cambia_estado_predio
AFTER UPDATE OF SESUESFN ON SERVSUSC
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
WHEN ((NEW.SESUESFN = 'C' AND  OLD.SESUESFN != 'C') OR (NEW.SESUESFN != 'C' AND  OLD.SESUESFN = 'C'))
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
  17-12-2024          felipe.valencia                OSF-3743: Se modificara para hacer la actualización
                                                     de información del predio en GIS
  29-01/2024          felipe.valencia                Se realiza actualización de condiciones de
                                                     disparo del trigger  
 *************************************************************************************************************/
    --Constantes
	csbMT_NAME          VARCHAR2(100) := $$PLSQL_UNIT;
    
    --Variables
	sbError             VARCHAR(4000);
	nuError             NUMBER;
    
    -- Producto a procesar
    nuProducto          servsusc.sesunuse%type;
    sbCastigado         VARCHAR2(2);
    csbNivelTraza           CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
BEGIN
    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);  

    nuProducto := :NEW.sesunuse;

    IF ( :NEW.sesuesfn = 'C') THEN  
        pkg_Traza.trace('Marca producto en ldc_infor_predio castigado S', csbNivelTraza );
        sbCastigado := 'S';
    ELSIF (:OLD.sesuesfn = 'C') THEN
        pkg_Traza.trace('Marca producto en ldc_infor_predio castigado N', csbNivelTraza );
        sbCastigado := 'N';
    END IF;

    pkg_boinfopredio.prcActualizaPredioCastigado(nuProducto,sbCastigado);

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
