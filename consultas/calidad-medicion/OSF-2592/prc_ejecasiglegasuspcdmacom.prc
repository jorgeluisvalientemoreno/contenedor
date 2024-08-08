CREATE OR REPLACE PROCEDURE PERSONALIZACIONES.prc_ejecasiglegasuspcdmacom IS

  /*****************************************************************
  Unidad         : prc_ejecasiglegasuspcdmacom
  Descripcion    : Ejecuta la Asignacion y legalizacion las actividades 100009279 - CLM - SUSPENSION DESDE CDM_POR
           NO CAMBIO DE MEDIDOR EN MAL ESTADO y 100009280 - CLM - SUSPENSION DESDE ACOMETIDA_POR
           NO CAMBIO DE MEDIDOR EN MAL ESTADO

  Autor          : Jhon Erazo
  Fecha          : 31-01-2024

  Parametros            Descripcion
  ============          ===================
  inuInstancia_id     Identificador de la instancia

  Historia de Modificaciones

  DD-MM-YYYY    <Autor>           Modificacion
  -----------  ---------------  -------------------------------------
  31-01-2024   jerazomvm          OSF-2199: Creacion.
  30/04/2024   Jorge Valiente     OSF-2592: Actualizacion de loigca para control de legalizacion automatica
  ******************************************************************/

  --<<
  -- Variables del proceso
  -- Constantes para el control de la traza
  csbSP_NAME CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';
  cnuNVLTRC  CONSTANT NUMBER := pkg_traza.cnuNivelTrzDef;
  csbInicio  CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;

  nuCodError           NUMBER := 0;
  nuOrdenId            or_order.order_id%type;
  nuOrdenPadre         or_order.order_id%type;
  nuUnidadOperativa    or_order.operating_unit_id%type;
  nuCausalId           ge_causal.causal_id%type := NULL;
  nuCausalSusCDM       ld_parameter.numeric_value%TYPE := pkg_bcld_parameter.fnuobtienevalornumerico('PAR_LEGA_SUS_CDM');
  nuCausalSusACOM      ld_parameter.numeric_value%TYPE := pkg_bcld_parameter.fnuobtienevalornumerico('PAR_LEGA_SUS_ACO');
  nuPersonLega         ge_person.person_id%type;
  nuLecturaOrdenPadre  or_requ_data_value.value_1%type;
  nuOrdenesError       NUMBER := 0;
  sbErrorMessage       VARCHAR2(4000);
  sbproceso            VARCHAR2(100 BYTE) := csbSP_NAME ||
                                             TO_CHAR(SYSDATE,
                                                     'DDMMYYYYHH24MISS');
  sbLegalComment       VARCHAR2(200);
  sbCadenaLegalizacion CONSTANTS_PER.TIPO_XML_SOL%TYPE;
  sbSerialEquipo       elmesesu.emsscoem%type;
  dtFechaInicialEjec   or_order.execution_final_date%type;
  dtFechaFinalEjec     or_order.exec_initial_date%type;

  -- Cursor que obtiene las ordenes con actividad 100009279, 100009280 en estado 0 - Registrado
  CURSOR cuOrdeSuspCDMAcom IS
    SELECT mp.package_id,
           mp.comment_,
           oo.order_id,
           ooa.activity_id,
           ooa.product_id
      FROM mo_packages mp, or_order_activity ooa, or_order oo
     WHERE package_type_id = 100328
       AND mp.comment_ like upper('%Generada por orden%')
       AND ooa.package_id = mp.package_id
       AND ooa.activity_id in (100009279, 100009280)
       AND oo.order_id = ooa.order_id
       AND oo.order_status_id = 0;

  -- Cursor que obtiene datos de la orden padre
  CURSOR cuOrdenPadre(inuOrden or_order.order_id%TYPE) IS
    SELECT order_id,
           operating_unit_id,
           exec_initial_date,
           execution_final_date
      FROM or_order
     WHERE order_id = inuOrden;

  -- Cursor que obtiene la persona que legaliza la orden
  CURSOR cuPerson(inuOrden           or_order.order_id%TYPE,
                  inuUnidadOperativa or_operating_unit.operating_unit_id%type) IS
    SELECT person_id
      FROM or_order_person
     WHERE operating_unit_id = inuUnidadOperativa
       AND order_id = inuOrden;

  -- Cursor que obtiene los datos de lectura
  CURSOR cuDatoLectura(inuProductId pr_product.product_id%type) IS
    SELECT emsscoem
      FROM elmesesu
     WHERE emsssesu = inuProductId
       AND emssfere > sysdate;

  CURSOR cuLecturaOrdPadre(inuOrdenId or_order.order_id%type) IS
    SELECT value_1 FROM or_requ_data_value WHERE order_id = inuOrdenId;
  -->>

BEGIN

  pkg_traza.trace(csbSP_NAME, cnuNVLTRC, csbInicio);

  -- Inicializamos el proceso
  PKG_ESTAPROC.PRINSERTAESTAPROC(sbproceso, NULL);
  pkg_traza.trace('sbproceso: ' || sbproceso, cnuNVLTRC);

  FOR rfcuOrdeSuspCDMAcom IN cuOrdeSuspCDMAcom LOOP

    -- Reinicio valor del error
    nuCodError := 0;

    pkg_traza.trace('Solicitud ' || rfcuOrdeSuspCDMAcom.package_id ||
                    ', asociada a la orden ' ||
                    rfcuOrdeSuspCDMAcom.order_id,
                    cnuNVLTRC);

    nuOrdenId := substr(rfcuOrdeSuspCDMAcom.comment_, 21, 10);
    pkg_traza.trace('La orden que genero la solicitud ' ||
                    rfcuOrdeSuspCDMAcom.package_id || ' es ' || nuOrdenId,
                    cnuNVLTRC);

    IF (cuOrdenPadre%ISOPEN) THEN
      CLOSE cuOrdenPadre;
    END IF;

    OPEN cuOrdenPadre(nuOrdenId);
    FETCH cuOrdenPadre
      INTO nuOrdenPadre,
           nuUnidadOperativa,
           dtFechaInicialEjec,
           dtFechaFinalEjec;
    CLOSE cuOrdenPadre;

    -- Relaciona las ordenes
    API_RELATED_ORDER(nuOrdenId,
                      rfcuOrdeSuspCDMAcom.order_id,
                      nuCodError,
                      sbErrorMessage);

    pkg_traza.trace('Se relaciona la orden padre ' || nuOrdenId ||
                    ' con la orden hija ' || rfcuOrdeSuspCDMAcom.order_id,
                    cnuNVLTRC);

    --Control de registro de relacion de orden padre con orden hija
    IF nuCodError = 0 THEN

      --Asignacion de orden a unidad operativa
      api_assign_order(rfcuOrdeSuspCDMAcom.order_id,
                       nuUnidadOperativa,
                       nuCodError,
                       sbErrorMessage);

      pkg_traza.trace('Se asigna la orden ' ||
                      rfcuOrdeSuspCDMAcom.order_id ||
                      ' a la unidad operativa ' || nuUnidadOperativa,
                      cnuNVLTRC);

      --Control asignacion orden a unidad operativa
      IF nuCodError = 0 THEN

        -- Se asigna la causal de legalizacion
        IF (rfcuOrdeSuspCDMAcom.activity_id = 100009279) THEN
          nuCausalId := nuCausalSusCDM;
        ELSE
          nuCausalId := nuCausalSusACOM;
        END IF;

        pkg_traza.trace('nuCausalId: ' || nuCausalId, cnuNVLTRC);

        IF (cuPerson%ISOPEN) THEN
          CLOSE cuPerson;
        END IF;

        -- Obtiene la persona que legaliza
        nuPersonLega := PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO('COD_PERSONA_CALIDMED');

        pkg_traza.trace('nuPersonLega: ' || nuPersonLega, cnuNVLTRC);

        -- Comentario de legalizacion de la orden
        sbLegalComment := 'Legalizacion automatica por el procedimiento prc_ejecasiglegasuspcdmacom';
        pkg_traza.trace('sbLegalComment: ' || sbLegalComment, cnuNVLTRC);

        IF (cuDatoLectura%ISOPEN) THEN
          CLOSE cuDatoLectura;
        END IF;

        -- Obtiene la persona que legaliza
        OPEN cuDatoLectura(rfcuOrdeSuspCDMAcom.product_id);
        FETCH cuDatoLectura
          INTO sbSerialEquipo;
        CLOSE cuDatoLectura;

        pkg_traza.trace('sbSerialEquipo: ' || sbSerialEquipo, cnuNVLTRC);

        IF (cuLecturaOrdPadre%ISOPEN) THEN
          CLOSE cuLecturaOrdPadre;
        END IF;

        -- Obtiene la lectura de la orden padre
        OPEN cuLecturaOrdPadre(nuOrdenId);
        FETCH cuLecturaOrdPadre
          INTO nuLecturaOrdenPadre;
        CLOSE cuLecturaOrdPadre;

        pkg_traza.trace('nuLecturaOrdenPadre: ' || nuLecturaOrdenPadre,
                        cnuNVLTRC);

        -- Setea los datos basicos de legalizacion
        pkg_cadena_legalizacion.prSetDatosBasicos(rfcuOrdeSuspCDMAcom.order_id,
                                                  nuCausalId,
                                                  nuPersonLega,
                                                  1277, -- tipo de comentario
                                                  sbLegalComment);

        -- Agrega lectura
        pkg_cadena_legalizacion.prAgregaLecturaSerial(sbSerialEquipo,
                                                      1,
                                                      nuLecturaOrdenPadre,
                                                      'T',
                                                      NULL,
                                                      NULL,
                                                      NULL);
        pkg_traza.trace('Se registran las lecturas', cnuNVLTRC);

        -- Agrega actividades de la orden
        pkg_cadena_legalizacion.prAgregaActividadOrden;

        -- Obtiene la cadena de legalizacion
        sbCadenaLegalizacion := pkg_cadena_legalizacion.fsbCadenaLegalizacion;
        pkg_traza.trace('sbCadenaLegalizacion: ' || sbCadenaLegalizacion,
                        cnuNVLTRC);

        --legaliza la orden
        api_legalizeOrders(sbCadenaLegalizacion,
                           dtFechaInicialEjec,
                           dtFechaFinalEjec,
                           NULL,
                           nuCodError,
                           sbErrorMessage);

        pkg_traza.trace('Se legaliza la orden ' ||
                        rfcuOrdeSuspCDMAcom.order_id,
                        cnuNVLTRC);

        --control de legalizacion de la orden
        IF nuCodError = 0 THEN
          commit;
        ELSE
          nuOrdenesError := nuOrdenesError + 1;
          rollback;
          -- Inserto en log de errores de legalizacion de la orden
          PKG_LDC_LOGERRLEORRESU.prc_ins_ldc_logerrleorresu(rfcuOrdeSuspCDMAcom.order_id,
                                                            nuOrdenId,
                                                            sbproceso,
                                                            sbErrorMessage,
                                                            SYSDATE,
                                                            pkg_session.getUser);
        END IF;

      ELSE
        nuOrdenesError := nuOrdenesError + 1;
        rollback;
        -- Inserto en log de errores al asignar orden a unidad operativa
        PKG_LDC_LOGERRLEORRESU.prc_ins_ldc_logerrleorresu(rfcuOrdeSuspCDMAcom.order_id,
                                                          nuOrdenId,
                                                          sbproceso,
                                                          sbErrorMessage,
                                                          SYSDATE,
                                                          pkg_session.getUser);
      END IF; --Fin control asigancion orden a unidad operativa

    ELSE
      nuOrdenesError := nuOrdenesError + 1;
      rollback;
      -- Inserto en log de errores de registro de relacion de orden padre con orden hija
      PKG_LDC_LOGERRLEORRESU.prc_ins_ldc_logerrleorresu(rfcuOrdeSuspCDMAcom.order_id,
                                                        nuOrdenId,
                                                        sbproceso,
                                                        sbErrorMessage,
                                                        SYSDATE,
                                                        pkg_session.getUser);
    END IF; --Fin de regitro de relacion de orden adre y orden hija

  END LOOP;

  -- Actualiza el proceso
  IF nuOrdenesError > 0 THEN
    pkg_estaproc.practualizaestaproc(sbproceso,
                                     'OK',
                                     'El proceso termino con error y fallaron ' ||
                                     nuOrdenesError ||
                                     ' ordenes, validar en el log ldc_logerrleorresu');
  ELSE
    pkg_estaproc.practualizaestaproc(sbproceso,
                                     'OK',
                                     'El proceso termino con exito');
  END IF;

  pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN);

EXCEPTION
  WHEN pkg_Error.Controlled_Error THEN
    pkg_Error.getError(nuCodError, sbErrorMessage);
    PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbproceso, 'Error', sbErrorMessage);
    pkg_traza.trace('nuCodError: ' || nuCodError || ', ' ||
                    'sbErrorMessage: ' || sbErrorMessage,
                    cnuNVLTRC);
    pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
    RAISE PKG_ERROR.CONTROLLED_ERROR;
  WHEN others THEN
    Pkg_Error.seterror;
    pkg_error.geterror(nuCodError, sbErrorMessage);
    PKG_ESTAPROC.PRACTUALIZAESTAPROC(sbproceso, 'Error', sbErrorMessage);
    pkg_traza.trace('nuCodError: ' || nuCodError || ', ' ||
                    'sbErrorMessage: ' || sbErrorMessage,
                    cnuNVLTRC);
    pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
    RAISE PKG_ERROR.CONTROLLED_ERROR;
END prc_ejecasiglegasuspcdmacom;
/
