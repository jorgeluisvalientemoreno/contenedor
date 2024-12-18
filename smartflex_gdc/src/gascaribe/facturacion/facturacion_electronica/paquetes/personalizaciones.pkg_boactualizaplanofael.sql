create or replace PACKAGE personalizaciones.pkg_boactualizaplanofael  IS
  FUNCTION fsbVersion RETURN VARCHAR2 ;
  PROCEDURE prActualizaPlanoFael( icblRequest IN CLOB,
                                  inuCodLote  IN lote_fact_electronica.codigo_lote%type,
                                  onuError    OUT  NUMBER,
                                  osbError    OUT VARCHAR2);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizaPlanoFael
    Descripcion     : proceso para actualizar plano de facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 03-09-2024

    Parametros de Entrada
      icblRequest       Facturas a actualizar formato (<DATOS><DOCUMENTOS><TIPO_DOCU></TIPO_DOCU><DOCUMENTO></DOCUMENTO></DOCUMENTOS></DATOS>)
      inuCodLote       codigo de lote
    Parametros de Salida
      onuError        codigo del error
      osbError        mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        03-09-2024  OSF-3238    Creacion
  ***************************************************************************/
END pkg_boactualizaplanofael ;
/
create or replace PACKAGE BODY  personalizaciones.pkg_boactualizaplanofael  IS
  csbSP_NAME              CONSTANT VARCHAR2(32) := $$PLSQL_UNIT;
  csbNivelTraza           CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
  
   -- Identificador del ultimo caso que hizo cambios
   csbVersion     CONSTANT VARCHAR2(15) := 'OSF-3238';

   FUNCTION fsbVersion RETURN VARCHAR2 IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 03-09-2024

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      03-09-2024   OSF-3238    Creacion
  ***************************************************************************/
  BEGIN
    RETURN csbVersion;
  END fsbVersion;
  
  PROCEDURE prActualizaPlanoFael( icblRequest IN CLOB,
                                  inuCodLote  IN lote_fact_electronica.codigo_lote%type,
                                  onuError    OUT  NUMBER,
                                  osbError    OUT VARCHAR2) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizaPlanoFael
    Descripcion     : proceso para actualizar plano de facturacion electronica

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 03-09-2024

    Parametros de Entrada
      icblRequest       Facturas a actualizar formato (<DATOS><DOCUMENTOS><TIPO_DOCU></TIPO_DOCU><DOCUMENTO></DOCUMENTO></DOCUMENTOS></DATOS>)
      inuCodLote       codigo de lote
    Parametros de Salida
      onuError        codigo del error
      osbError        mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        03-09-2024  OSF-3238    Creacion
  ***************************************************************************/
   csbMT_NAME      VARCHAR2(150) := csbSP_NAME || '.prActualizaPlanoFael';
   
   sbError     VARCHAR2(4000);
   nuIdReporte NUMBER;
   dtFechaDocu  DATE;
   dtFechaInicPeri DATE := TO_DATE('01/'||TO_CHAR(SYSDATE, 'MM/YYYY')||' 00:00:00', 'DD/MM/YYYY HH24:MI:SS');
   dtFechaFinPeri DATE :=  TO_DATE(to_char(LAST_DAY(SYSDATE), 'DD/MM/YYYY')||' 23:59:59', 'DD/MM/YYYY HH24:MI:SS');
   
   CURSOR cuGetDatos IS
   SELECT datos.TIPO_DOCU, 
          datos.DOCUMENTO
    FROM XMLTABLE('/DATOS/DOCUMENTOS' passing XMLTYPE(icblRequest) COLUMNS                    
                TIPO_DOCU VARCHAR2(30) PATH 'TIPO_DOCU',
                DOCUMENTO VARCHAR2(30) PATH 'DOCUMENTO') datos; 

    CURSOR cuGetFechaFactura(inuFactura NUMBER) IS
    SELECT factfege
    FROM factura
    WHERE factcodi = inuFactura;

    CURSOR cuGetFechaNota(inuNota NUMBER) IS
    SELECT notafecr
    FROM notas
    WHERE notanume = inuNota;
    
  BEGIN 
     pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbINICIO);
     pkg_error.prinicializaerror(onuError, osbError);
      
     pkg_traza.trace(' inuCodLote => ' || inuCodLote, pkg_traza.cnuNivelTrzDef);
     pkg_traza.trace(' dtFechaInicPeri => ' || dtFechaInicPeri, pkg_traza.cnuNivelTrzDef);  
     pkg_traza.trace(' dtFechaFinPeri => ' || dtFechaFinPeri, pkg_traza.cnuNivelTrzDef); 
     pkg_traza.trace(' onuError => ' || onuError, pkg_traza.cnuNivelTrzDef);
     pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
     
     FOR reg IN cuGetDatos LOOP
         pkg_error.prinicializaerror(onuError, osbError); 
         
         IF nuIdReporte IS NULL THEN
             nuIdReporte := pkg_reportes_inco.fnuCrearCabeReporte ( 'JOBFAELGE', 'Job de facturacion electronica recurrente');
             pkg_traza.trace(' nuIdReporte => ' || nuIdReporte, pkg_traza.cnuNivelTrzDef);  
         END IF;           
         dtFechaDocu := NULL;
         IF  reg.Tipo_Docu IN (pkg_bcfactuelectronicagen.cnuTipoDocuFactRecu, pkg_bcfactuelectronicagen.cnuTipoDocuVentas) THEN
            IF cuGetFechaFactura%ISOPEN THEN CLOSE cuGetFechaFactura; END IF;           
        
            OPEN cuGetFechaFactura(reg.Documento);
            FETCH cuGetFechaFactura INTO dtFechaDocu;
            CLOSE cuGetFechaFactura;
            pkg_traza.trace(' Documento => ' || reg.Documento, pkg_traza.cnuNivelTrzDef);  
            pkg_traza.trace(' dtFechaDocu => ' || dtFechaDocu, pkg_traza.cnuNivelTrzDef);  
            IF TRUNC(dtFechaDocu) <> TRUNC(SYSDATE)  THEN
               IF dtFechaDocu BETWEEN dtFechaInicPeri AND dtFechaFinPeri THEN
                   pkg_factura.practualizafechagen(reg.Documento, SYSDATE);
               ELSE
                  sbError := substr(sbError ||'Documento: '||reg.Documento||' Error: Fecha de factura no se encuentra dentro del periodo contable actual.'||CHR(13),1,3999); 
                  CONTINUE;
               END IF;                           
            END IF;        
        ELSE
             IF cuGetFechaNota%ISOPEN THEN CLOSE cuGetFechaNota; END IF;
             OPEN cuGetFechaNota(reg.Documento);
             FETCH cuGetFechaNota INTO dtFechaDocu;
             CLOSE cuGetFechaNota;
             pkg_traza.trace(' Documento => ' || reg.Documento, pkg_traza.cnuNivelTrzDef);  
             pkg_traza.trace(' dtFechaDocu => ' || dtFechaDocu, pkg_traza.cnuNivelTrzDef);
             IF TRUNC(dtFechaDocu) <> TRUNC(SYSDATE) THEN
               IF dtFechaDocu BETWEEN dtFechaInicPeri AND dtFechaFinPeri THEN
                   pkg_notas.practualizafechagen(reg.Documento, SYSDATE);  
               ELSE
                  sbError := substr(sbError ||'Documento: '||reg.Documento||' Error: Fecha de nota no se encuentra dentro del periodo contable actual.'||CHR(13),1,3999); 
                   CONTINUE;
               END IF;                                
             END IF;
        END IF;
           
        pkg_bofactuelectronicagen.prGenerarEstrFactElec( reg.Documento,
                                                         inuCodLote,
                                                         'A',
                                                         reg.Tipo_Docu,
                                                         nuIdReporte,
                                                         onuError,
                                                         osbError );
        IF onuError = 0 THEN
           pkg_factura_elect_general.prActualizarFactElecGen(inuCodLote,reg.Tipo_Docu,reg.Documento, 2  );
           COMMIT;
        ELSE
           ROLLBACK;
           sbError := substr(sbError ||'Documento: '||reg.Documento||' Error: '||osbError||CHR(13),1,3999);
        END IF;
     END LOOP;
     --se valida si hubo error en el proceso
     IF sbError IS NOT NULL THEN
        osbError := sbError;
        onuError := -1;
     END IF;
     pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbFIN);
  EXCEPTION
      WHEN pkg_Error.Controlled_Error  THEN
            pkg_error.getError(onuError,osbError);
            pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(onuError,osbError);
            pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbFIN_ERR); 
  END prActualizaPlanoFael;
END pkg_boactualizaplanofael ;
/
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_BOACTUALIZAPLANOFAEL','PERSONALIZACIONES');
END;
/
