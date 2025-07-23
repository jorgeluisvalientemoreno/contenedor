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
      icblRequest       Facturas a actualizar formato (<DATOS><DOCUMENTOS><TIPO_DOCU></TIPO_DOCU><DOCUMENTO></DOCUMENTO><COD_ERRORES></COD_ERRORES></DOCUMENTOS></DATOS>)
      inuCodLote       codigo de lote
    Parametros de Salida
      onuError        codigo del error
      osbError        mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        07-03-2025  OSF-4045    se agrega lectura del campo COD_ERRORES del XML con el fin de validar 
                                        notas no referenciadas
    LJLB        03-09-2024  OSF-3238    Creacion
  ***************************************************************************/
END pkg_boactualizaplanofael ;
/
create or replace PACKAGE BODY  personalizaciones.pkg_boactualizaplanofael  IS
  csbSP_NAME              CONSTANT VARCHAR2(32) := $$PLSQL_UNIT;
  csbNivelTraza           CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;

   -- Identificador del ultimo caso que hizo cambios
   csbVersion     CONSTANT VARCHAR2(15) := 'OSF-4045';

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
      icblRequest       Facturas a actualizar formato (<DATOS><DOCUMENTOS><TIPO_DOCU></TIPO_DOCU><DOCUMENTO></DOCUMENTO><COD_ERRORES></COD_ERRORES></DOCUMENTOS></DATOS>)
      inuCodLote       codigo de lote
    Parametros de Salida
      onuError        codigo del error
      osbError        mensaje de error
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
	JSOTO		02-04-2025	OSF-4104	se agrega variable sbCodEmpresa 
    LJLB        07-03-2025  OSF-4045    se agrega lectura del campo COD_ERRORES del XML con el fin de validar 
                                        notas no referenciadas
    LJLB        03-09-2024  OSF-3238    Creacion
  ***************************************************************************/
   csbMT_NAME      VARCHAR2(150) := csbSP_NAME || '.prActualizaPlanoFael';

   sbError     VARCHAR2(4000);
   nuIdReporte NUMBER;
   dtFechaDocu  DATE;
   dtFechaInicPeri DATE := TO_DATE('01/'||TO_CHAR(SYSDATE, 'MM/YYYY')||' 00:00:00', 'DD/MM/YYYY HH24:MI:SS');
   dtFechaFinPeri DATE :=  TO_DATE(to_char(LAST_DAY(SYSDATE), 'DD/MM/YYYY')||' 23:59:59', 'DD/MM/YYYY HH24:MI:SS');
   
   sbCodErrorNotaNoRef  VARCHAR2(4000) :=  pkg_parametros.fsbGetValorCadena('CODIGO_RECHAZO_NOTASFAEL');
   sbNotaNrefe VARCHAR2(1) := 'N';
   sbCodEmpresa	VARCHAR2(10);
   

   CURSOR cuGetDatos IS
   SELECT datos.TIPO_DOCU,
          datos.DOCUMENTO,
          datos.COD_ERRORES
    FROM XMLTABLE('/DATOS/DOCUMENTOS' passing XMLTYPE(icblRequest) COLUMNS
                TIPO_DOCU VARCHAR2(30) PATH 'TIPO_DOCU',
                DOCUMENTO VARCHAR2(30) PATH 'DOCUMENTO',
                COD_ERRORES VARCHAR2(4000) PATH 'COD_ERRORES') datos;

    CURSOR cuGetFechaFactura(inuFactura NUMBER) IS
    SELECT factfege
    FROM factura
    WHERE factcodi = inuFactura;

    CURSOR cuGetFechaNota(inuNota NUMBER) IS
    SELECT notafecr
    FROM notas
    WHERE notanume = inuNota;
    
    CURSOR cuValidaCodRechazo(isbCodRechazo VARCHAR2) IS
    SELECT 'S'
    FROM (
            SELECT regexp_substr(isbCodRechazo,  '[^|]+',   1, LEVEL) AS cod_rechazo
            FROM dual
            CONNECT BY regexp_substr(isbCodRechazo, '[^|]+', 1, LEVEL) IS NOT NULL) a,
         (
            SELECT regexp_substr(sbCodErrorNotaNoRef,  '[^|]+',   1, LEVEL) AS cod_rechazo_para
            FROM dual
            CONNECT BY regexp_substr(sbCodErrorNotaNoRef, '[^|]+', 1, LEVEL) IS NOT NULL) b
    WHERE upper(a.cod_rechazo) = b.cod_rechazo_para;
    
    PROCEDURE prcCierraCursor IS
       csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.prActualizaPlanoFael';
    BEGIN
      pkg_traza.trace(csbMT_NAME1, csbNivelTraza, pkg_traza.csbINICIO);
      IF cuGetFechaFactura%ISOPEN THEN CLOSE cuGetFechaFactura; END IF;
      IF cuGetFechaNota%ISOPEN THEN CLOSE cuGetFechaNota; END IF;
      IF cuValidaCodRechazo%ISOPEN THEN CLOSE cuValidaCodRechazo; END IF;
      pkg_traza.trace(csbMT_NAME1, csbNivelTraza, pkg_traza.csbFIN);
    END prcCierraCursor;

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
         sbNotaNrefe := 'N';
         prcCierraCursor;
         IF nuIdReporte IS NULL THEN
             nuIdReporte := pkg_reportes_inco.fnuCrearCabeReporte ( 'JOBFAELGE', 'Job de facturacion electronica recurrente');
             pkg_traza.trace(' nuIdReporte => ' || nuIdReporte, pkg_traza.cnuNivelTrzDef);
         END IF;
         dtFechaDocu := NULL;
         IF  reg.Tipo_Docu IN (pkg_bcfactuelectronicagen.cnuTipoDocuFactRecu, pkg_bcfactuelectronicagen.cnuTipoDocuVentas) THEN
            
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
             --se valida codigo de rechazo enviados
            OPEN cuValidaCodRechazo(reg.cod_errores);
            FETCH cuValidaCodRechazo INTO sbNotaNrefe;
            IF cuValidaCodRechazo%NOTFOUND THEN
                sbNotaNrefe := 'N';
            END IF;
            CLOSE cuValidaCodRechazo;
            pkg_traza.trace(' sbNotaNrefe => ' || sbNotaNrefe, pkg_traza.cnuNivelTrzDef);  
        END IF;
		
		sbCodEmpresa := pkg_lote_fact_electronica.fsbObtCodEmpresa(inuCodLote);
        
        pkg_bofactuelectronicagen.prGenerarEstrFactElec( reg.Documento,
                                                         inuCodLote,
                                                         'A',
                                                         reg.Tipo_Docu,
                                                         nuIdReporte,
														 sbCodEmpresa,
                                                         sbNotaNrefe,
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
            prcCierraCursor;
            pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_error.getError(onuError,osbError);
            prcCierraCursor;
            pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace(csbMT_NAME, csbNivelTraza, pkg_traza.csbFIN_ERR);
  END prActualizaPlanoFael;
END pkg_boactualizaplanofael ;  
/
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_BOACTUALIZAPLANOFAEL','PERSONALIZACIONES');
END;
/