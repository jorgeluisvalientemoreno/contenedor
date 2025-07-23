CREATE OR REPLACE PACKAGE PERSONALIZACIONES.PKG_BCACOTESDO
IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : PKG_BCACOTESDO
    Descripción     : Paquete de servicios de cosulta para PB ACODESCO

    Autor           : Jhon Jairo Soto
    Fecha           : 07-11-2024

    Parámetros de Entrada
    
    Parámetros de Salida
    
    ModIFicaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripción
    
  ***************************************************************************/

    --------------------------------------------
    -- Funciónes y Procedimientos
    --------------------------------------------

    FUNCTION fsbVersion
    RETURN VARCHAR2;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frcConsultaDinamica
    Descripción     : Función para consultar las órdenes por estado de documentos.

    Autor           : Jhon Jairo Soto
    Fecha           : 07-11-2024

    Parámetros de Entrada
		inuUnidadOperativa      Id de la orden
		isbEstadoDocum          Estado de los documentos
    idtFechaInicial         Fecha Inicial
    idtFechaFinal           Fecha Final
    inuTipoTrabajo          Tipo de trabajo
    
    Parámetros de Salida
    
    ModIFicaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripción
    
  ***************************************************************************/
    FUNCTION frcConsultaDinamica (
                                    inuUnidadOperativa IN NUMBER,
                                    isbEstadoDocum     IN VARCHAR2,
                                    idtFechaInicial    IN DATE,
                                    idtFechaFinal      IN DATE,
                                    inuTipoTrabajo     IN NUMBER
                                  )
    RETURN constants_per.tyRefCursor;                            
  
END PKG_BCACOTESDO;
/

CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.PKG_BCACOTESDO 
IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : PKG_BCACOTESDO
    Descripción     : Paquete de servicios de consulta PB ACOTESDO

    Autor           : Jhon Jairo Soto
    Fecha           : 07-11-2024

    Parámetros de Entrada
    
    Parámetros de Salida
    
    ModIFicaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripción
    
  ***************************************************************************/

    --------------------------------------------
    -- Constantes 
    --------------------------------------------
    csbVERSION          CONSTANT VARCHAR2(10) := 'OSF-3576';
    csbSP_NAME          CONSTANT VARCHAR2(100):= $$PLSQL_UNIT||'.';
    cnuNVLTRC           CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
	  csbInicio   		    CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;
    cnuGeneric_Error 	  CONSTANT NUMBER       := 2741;
    


  FUNCTION fsbVersion RETURN VARCHAR2
  IS
  BEGIN
    RETURN csbVERSION;
  END fsbVersion;


  FUNCTION frcConsultaDinamica (
                                  inuUnidadOperativa  IN NUMBER,
                                  isbEstadoDocum      IN VARCHAR2,
                                  idtFechaInicial     IN DATE,
                                  idtFechaFinal       IN DATE,
                                  inuTipoTrabajo      IN NUMBER
                                )
  RETURN constants_per.tyRefCursor IS
  /*****************************************************************
  Propiedad intelectual de GDO (c).

  Unidad         : frcConsultaDinamica
  Descripción    : Función para consultar las ordenes por estado de documentos.
  Autor          : Jhon Jairo Soto
  Fecha          : 07/11/2024
  
  Parámetros de entrada
	inuUnidadOperativa 	:  Unidad Operativa
	isbEstadoDocum 			: Estado del documento
	idtFechaInicial 	  : Fecha de ejecución Inicial
	idtFechaFinal 	    : Fecha de legalizacion
	inuTipoTrabajo 		  : Tipo de trabajo

  Fecha             Autor                ModIFicacion
  =========       =========             ====================

  ******************************************************************/
    --Variables Usadas Durante el Proceso
    csbMT_NAME      		  VARCHAR2(70) := csbSP_NAME || 'frcConsultaDinamica';
    cnuNull_Attribute 	  CONSTANT number := 2126;
    rfCursor              constants_per.tyRefCursor;
    sbQuery               VARCHAR2(32767);
    nuError		 		        NUMBER;  
    sbError	 			        VARCHAR2(2000);
  
  BEGIN
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);

    pkg_traza.trace('inuUnidadOperativa: '  || inuUnidadOperativa);
    pkg_traza.trace('isbEstadoDocum: '      || isbEstadoDocum);
    pkg_traza.trace('idtFechaInicial: '     || idtFechaInicial);
    pkg_traza.trace('idtFechaFinal: '       || idtFechaFinal);
    pkg_traza.trace('inuTipoTrabajo: '      || inuTipoTrabajo);

  
    sbQuery := 
            'WITH info_documentos AS(
            SELECT  DISTINCT  or_order.order_id,
                              or_order.task_type_id,
                              or_order.operating_unit_id,
                              ldc_docuorder.legalization_date,
                              ldc_docuorder.reception_date,
                              TRUNC(SYSDATE) - TRUNC(ldc_docuorder.legalization_date) No_DIAS_LEGALIZACION,
                              TRUNC(SYSDATE) - TRUNC(ldc_docuorder.reception_date)    No_DIAS_RECEPCION,
                              NVL(or_order_activity.address_id, or_order.external_address_id) address_id,
                              ldc_titrdocu.cant_docu
              FROM ldc_docuorder
              INNER JOIN or_order ON or_order.order_id = ldc_docuorder.order_id 
                                AND or_order.operating_unit_id = DECODE(CNUUNIDAD,-1, or_order.operating_unit_id,CNUUNIDAD)
                                AND or_order.task_type_id = DECODE(CNUTIPOTRAB,-1,or_order.task_type_id, CNUTIPOTRAB)
              INNER JOIN ldc_titrdocu ON ldc_titrdocu.task_type_id = or_order.task_type_id
              INNER JOIN or_order_activity ON or_order_activity.order_id = or_order.order_id
              WHERE ldc_docuorder.status_docu = ''CSBESTADO''
                CSBFECHAINI
                CSBFECHAFIN
            )
            SELECT info_documentos.order_id NO_ORDEN,
                    (SELECT ge_geogra_location.geo_loca_father_id || '' - '' || de.description FROM ge_geogra_location de where de.geograp_location_id = ge_geogra_location.geo_loca_father_id)DEPARTAMENTO,
                    ge_geogra_location.geograp_location_id|| '' - '' ||ge_geogra_location.description LOCALIDAD,
                    (SELECT or_operating_unit.contractor_id || '' - '' || ge_contratista.nombre_contratista FROM ge_contratista where ge_contratista.id_contratista = or_operating_unit.contractor_id) CONTRATISTA,
                    or_operating_unit.operating_unit_id || '' - '' ||or_operating_unit.name UNIDAD_OPERATIVA,
                    (SELECT info_documentos.task_type_id || '' - '' || or_task_type.description FROM or_task_type where or_task_type.task_type_id = info_documentos.task_type_id) TIPO_TRABAJO,
                    info_documentos.cant_docu CANT_DOCUMENTOS,
                    info_documentos.legalization_date LEGALIZACION_DATE,
                    info_documentos.No_DIAS_LEGALIZACION,
                    info_documentos.reception_date RECEPTION_DATE,
                    info_documentos.No_DIAS_RECEPCION
            FROM info_documentos
            INNER JOIN ab_address ON ab_address.address_id =  info_documentos.address_id 
            INNER JOIN ge_geogra_location ON ge_geogra_location.geograp_location_id = ab_address.geograp_location_id
            INNER JOIN or_operating_unit ON or_operating_unit.operating_unit_id = info_documentos.operating_unit_id
            ORDER BY CSBORDER';
 
    sbQuery := REPLACE(sbQuery,'CNUUNIDAD',inuUnidadOperativa);
    sbQuery := REPLACE(sbQuery,'CSBESTADO',isbEstadoDocum);


    --Tipo de Trabajo
    IF (inuTipoTrabajo is not null) then
      sbQuery := REPLACE(sbQuery,'CNUTIPOTRAB',  inuTipoTrabajo);
    ELSE
      sbQuery := REPLACE(sbQuery,'CNUTIPOTRAB',  -1);
    END IF;  
 
 
    IF (isbEstadoDocum = 'CO') THEN

      sbQuery := REPLACE(sbQuery,'CSBORDER',  'info_documentos.legalization_date');

      IF (idtFechaInicial is not null) THEN
        sbQuery := REPLACE(sbQuery,'CSBFECHAINI',' AND TRUNC(ldc_docuorder.legalization_date) >=to_date(''' || idtFechaInicial || ''')');
      ELSE
        sbQuery := REPLACE(sbQuery,'CSBFECHAINI','');
      END IF;

      IF (idtFechaFinal is not null) THEN
        sbQuery := REPLACE(sbQuery,'CSBFECHAFIN',' AND TRUNC(ldc_docuorder.legalization_date) <=to_date(''' || idtFechaFinal || ''')');
      ELSE
        sbQuery := REPLACE(sbQuery,'CSBFECHAFIN','');
      END IF;

    ELSIF (isbEstadoDocum = 'EP') THEN

      sbQuery := REPLACE(sbQuery,'CSBORDER',  'info_documentos.reception_date');

      IF (idtFechaInicial is not null) THEN
        sbQuery := REPLACE(sbQuery,'CSBFECHAINI',' AND TRUNC(ldc_docuorder.reception_date) >=to_date(''' || idtFechaInicial || ''')');
      ELSE
        sbQuery := REPLACE(sbQuery,'CSBFECHAINI','');
      END IF;

      IF (idtFechaFinal is not null) THEN
        sbQuery := REPLACE(sbQuery,'CSBFECHAFIN',' AND TRUNC(ldc_docuorder.reception_date) <=to_date(''' || idtFechaFinal || ''')');
      ELSE
        sbQuery := REPLACE(sbQuery,'CSBFECHAFIN','');
      END IF;

    END IF;

    pkg_traza.trace('sbQuery: ' || sbQuery);

    --Ejecutamos el Select haciENDo uso de un cursor
    OPEN rfCursor FOR sbQuery;

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    -- Retornamos el Cursor
    RETURN rfCursor;

  EXCEPTION
      WHEN pkg_Error.CONTROLLED_ERROR THEN
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        RAISE pkg_Error.CONTROLLED_ERROR;
    WHEN no_data_found THEN
        pkg_traza.trace('sbError: Dato no encontrado' );
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      IF rfCursor%isopen then
      CLOSE rfCursor;
      END IF;
        RAISE pkg_Error.CONTROLLED_ERROR;
      WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RAISE pkg_Error.CONTROLLED_ERROR;

  END frcConsultaDinamica;


END PKG_BCACOTESDO;
/

BEGIN
  pkg_utilidades.prAplicarPermisos(upper('PKG_BCACOTESDO'),'PERSONALIZACIONES'); 
END;
/

