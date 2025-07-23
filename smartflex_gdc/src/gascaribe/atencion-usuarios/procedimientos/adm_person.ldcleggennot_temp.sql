CREATE OR REPLACE PROCEDURE adm_person.LDCLEGGENNOT_TEMP IS
  /*****************************************************************
  UNIDAD       : LDCLEGGENNOT_TEMP
  DESCRIPCION  : 
  
  AUTOR          : 
  FECHA          : 
  
  HISTORIA DE MODIFICACIONES
  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================  
  26/04/2024      PACOSTA             OSF-2598: Se crea el objeto en el esquema adm_person
  15/04/2025      Jorge Valiente      OSF-4256: Se establece ROLLBACK con error al generar orden.
  ******************************************************************/

  sbError      VARCHAR2(4000);
  nuTotalRegis NUMBER;
  csbMetodo   CONSTANT VARCHAR2(50) := $$PLSQL_UNIT;
  csbPrograma CONSTANT VARCHAR2(100) := 'LEGGENNOT' || '_' ||
                                        to_char(SYSDATE, 'DDMMYYHHMISS');
  nuTipoComentario NUMBER := pkg_parametros.fnugetvalornumerico('TIPO_COMENTARIO_GENERAL');

  nuNivelTrzDef NUMBER := pkg_traza.fnuNivelTrzDef;

  sbdataorder    VARCHAR2(32767);
  inuorderact_id NUMBER;

  nuCODIGO_PAIS             NUMBER := pkg_bcld_parameter.fnuobtienevalornumerico('CODIGO_PAIS');
  nuPARAM_DIAS_HABILES_NOTI NUMBER := pkg_bcld_parameter.fnuobtienevalornumerico('PARAM_DIAS_HABILES_NOTI');
  nuPARAM_CAUSA_LEGA_FALLA  NUMBER := pkg_bcld_parameter.fnuobtienevalornumerico('PARAM_CAUSA_LEGA_FALLA');
  nuPARAM_PERSO_LEGA_NOTI   NUMBER := pkg_bcld_parameter.fnuobtienevalornumerico('PARAM_PERSO_LEGA_NOTI');

  -- Cursor ordenes de notificacion personal
  CURSOR cuordenesnotper IS
    SELECT orden_nro, dias_habiles, direccion, cliente, paquete, motive
      FROM (SELECT ot.order_id orden_nro,
                   ot.created_date fecha_creacion,
                   (SELECT COUNT(1)
                      FROM ge_calendar t
                     WHERE t.day_type_id = 1
                       AND t.country_id = nuCODIGO_PAIS
                       AND date_ BETWEEN trunc(ot.created_date) AND
                           trunc(SYSDATE)) dias_habiles,
                   cl.address_id direccion,
                   cl.subscriber_id cliente,
                   oa.package_id paquete,
                   oa.motive_id motive
              FROM or_order ot, or_order_activity oa, ge_subscriber cl
             WHERE ot.task_type_id = 10004
               AND oa.task_type_id = 10004
               AND ot.order_status_id IN (0, 5)
               AND ot.order_id = oa.order_id
               AND oa.subscriber_id = cl.subscriber_id)
     WHERE dias_habiles > nuPARAM_DIAS_HABILES_NOTI;

  nuerror       NUMBER(2);
  sbmensa       VARCHAR2(4000);
  error         NUMBER;

  nuHilos        NUMBER := 1;
  nuLogProceso   ge_log_process.log_process_id%TYPE;
  sbParametros   ge_process_schedule.parameters_%TYPE;
  nuordentrabajo or_order.order_id%TYPE;
  ionuorderid    or_order.order_id%TYPE;
  nupack         mo_packages.package_id%TYPE;
  nuconta        NUMBER(6);
  nuotenco       NUMBER(15) DEFAULT 0;
  nuotenge       NUMBER(15) DEFAULT 0;
  nuparamorden   or_order.order_id%TYPE;
  sbmensamen     VARCHAR2(4000);

  sbComentario VARCHAR2(4000);

  nuCabeceraReporte        NUMBER;
  nuDetalleCabeceraReporte NUMBER := 0;

  CURSOR cuCuentaOrdenes(inuCliente   IN or_order.subscriber_id%TYPE,
                         inuSolicitud IN or_order_activity.package_id%TYPE) IS
    SELECT COUNT(1)
      FROM or_order otq, or_order_activity oaq
     WHERE otq.subscriber_id = inuCliente
       AND otq.order_status_id <> 8
       AND otq.task_type_id = 10005
       AND oaq.package_id = inuSolicitud
       AND otq.order_id = oaq.order_id;

BEGIN

  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzApi, pkg_traza.csbINICIO);

  pkg_estaproc.prInsertaEstaproc(csbPrograma, NULL);

  nuotenco     := 0;
  nuotenge     := 0;
  nuparamorden := nvl(nuparamorden, -1);

  IF (cuordenesnotper%ISOPEN) THEN
    CLOSE cuordenesnotper;
  END IF;

  nuCabeceraReporte := pkg_reportes_inco.fnucrearcabereporte('LEGGENNOT',
                                                             'SERVICIO LDCLEGGENNOT_TEMP PARA LEGALIZACION DE TT 10004 Y GENERACION DE TT 10005');
  pkg_traza.trace('Codigo Cabecera: ' || nuCabeceraReporte, nuNivelTrzDef);

  FOR i IN cuordenesnotper LOOP
  
    BEGIN
    
      nuordentrabajo := i.orden_nro;
      nuotenco       := nuotenco + 1;
      error          := 0;
      sbmensa        := NULL;
      nupack         := i.paquete;
      sbdataorder    := NULL;
    
      pkg_traza.trace('nuordentrabajo: [' || nuordentrabajo || ']');
    
      pkg_traza.trace('nuTipoComentario: [' || nuTipoComentario || ']');
    
      pkg_cadena_legalizacion.prSetDatosBasicos(nuordentrabajo,
                                                nuPARAM_CAUSA_LEGA_FALLA,
                                                nuPARAM_PERSO_LEGA_NOTI,
                                                nuTipoComentario,
                                                'PROCESO [ldcleggennot_TEMP]. Se legaliza automaticamente la ot : ' ||
                                                to_char(nuordentrabajo));
    
      pkg_cadena_legalizacion.prAgregaActividadOrden;
    
      sbdataorder := pkg_cadena_legalizacion.fsbCadenaLegalizacion;
    
      pkg_traza.trace('Cadena Legalizacion: ' || sbdataorder,
                      nuNivelTrzDef);
    
      api_legalizeorders(sbdataorder,
                         SYSDATE,
                         SYSDATE,
                         SYSDATE,
                         error,
                         sbmensa);
    
      ionuorderid    := NULL;
      inuorderact_id := NULL;
    
      IF (nvl(error, 0) = 0) THEN
      
        IF (cuCuentaOrdenes%ISOPEN) THEN
          CLOSE cuCuentaOrdenes;
        END IF;
      
        OPEN cuCuentaOrdenes(i.cliente, i.paquete);
        FETCH cuCuentaOrdenes
          INTO nuconta;
        CLOSE cuCuentaOrdenes;
      
        IF nuconta = 0 THEN
        
          error        := NULL;
          sbmensa      := NULL;
          sbComentario := 'PROCESO [ldcleggennot_TEMP]. Se legaliza ot : ' ||
                          to_char(nuordentrabajo) ||
                          ' se genera ot de Envio notif. x aviso.';
        
          api_createorder(200004, --inuItemsid
                          i.paquete, --inuPackageid
                          i.motive, --inuMotiveid
                          NULL, --inuComponentid
                          NULL, --inuInstanceid
                          i.direccion, --inuAddressid
                          NULL, --inuElementid
                          i.cliente, --inuSubscriberid
                          NULL, --inuSubscriptionid
                          NULL, --inuProductid
                          NULL, --inuOperunitid
                          sysdate, --idtExecestimdate
                          NULL, --inuProcessid
                          sbComentario, --isbComment
                          FALSE, --iblProcessorder
                          NULL, --inuPriorityid
                          NULL, --inuOrdertemplateid
                          NULL, --isbCompensate
                          NULL, --inuConsecutive
                          NULL, --inuRouteid
                          NULL, --inuRouteConsecutive
                          NULL, --inuLegalizetrytimes
                          NULL, --isbTagname
                          TRUE, --iblIsacttoGroup
                          NULL, --inuRefvalue
                          NULL, --inuActionid
                          ionuorderid, --ionuOrderid
                          inuorderact_id, --ionuOrderactivityid
                          error, --onuErrorCode
                          sbmensa --osbErrorMessage
                          );
        
          IF nvl(error, 0) = 0 THEN
            nuotenge := nuotenge + 1;
            pkg_traza.trace('Orden generada: ' || ionuorderid,
                            nuNivelTrzDef);
          ELSE
            ROLLBACK;
            pkg_traza.trace('Error: ' || sbmensa, nuNivelTrzDef);
            nuDetalleCabeceraReporte := nuDetalleCabeceraReporte + 1;
            pkg_reportes_inco.prcreardetallerepo(nuCabeceraReporte,
                                                 nuordentrabajo,
                                                 sbmensa,
                                                 'Error creando la orden hija',
                                                 nuDetalleCabeceraReporte);
          END IF;
        
        END IF;
      
      ELSE
        ROLLBACK;
        pkg_traza.trace('Error: ' || sbmensa, nuNivelTrzDef);
        nuDetalleCabeceraReporte := nuDetalleCabeceraReporte + 1;
        pkg_reportes_inco.prcreardetallerepo(nuCabeceraReporte,
                                             nuordentrabajo,
                                             sbmensa,
                                             'Error legalizando la orden padre',
                                             nuDetalleCabeceraReporte);
      END IF;
    
      COMMIT;
      pkg_estaproc.prActualizaAvance(csbPrograma,
                                     'Procesando: ' || nuotenco,
                                     nuotenco,
                                     nuTotalRegis);
    
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        pkg_Error.getError(nuerror, sberror);
        nuDetalleCabeceraReporte := nuDetalleCabeceraReporte + 1;
        pkg_reportes_inco.prcreardetallerepo(nuCabeceraReporte,
                                             nuordentrabajo,
                                             sberror,
                                             'Error al ejecutar COMMIT desde el ciclo FOR.',
                                             nuDetalleCabeceraReporte);
      
    END;
  
  END LOOP;

  sbmensamen := 'PROCESO [ldcleggennot_TEMP] termino con [' || nuotenge ||
                '] orden(es) generada(s)';
  pkg_traza.trace(sbmensamen, nuNivelTrzDef);
  pkg_estaproc.practualizaestaproc(csbPrograma, 'OK', sbmensamen);

  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzApi, pkg_traza.csbFIN);

EXCEPTION
  WHEN pkg_Error.Controlled_Error THEN
    ROLLBACK;
    pkg_Error.getError(nuerror, sberror);
    pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERC);
    pkg_estaproc.practualizaestaproc(csbPrograma,
                                     'Error',
                                     nuerror || '-' || sberror);
  WHEN OTHERS THEN
    ROLLBACK;
    pkg_error.seterror;
    pkg_error.geterror(nuerror, sberror);
    pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERC);
    error   := -1;
    sbmensa := to_char(error) ||
               ' Error en ldcleggennot_TEMP..lineas error ' ||
               to_char(nuerror) || ' orden de trabajo : ' ||
               to_char(nuordentrabajo) || ' ' || SQLERRM;
    pkg_estaproc.practualizaestaproc(csbPrograma, 'Error', sbmensa);
  
END LDCLEGGENNOT_TEMP;
/
BEGIN
    pkg_utilidades.praplicarpermisos('LDCLEGGENNOT_TEMP', 'ADM_PERSON');
END;
/