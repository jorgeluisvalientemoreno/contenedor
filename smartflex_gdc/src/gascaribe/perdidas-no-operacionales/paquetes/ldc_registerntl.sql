create or replace package ldc_RegisterNTL is

  /*****************************************************************
    Propiedad intelectual de Gases de Occidente.
  
    Package : ldc_RegisterNTL
    Descripcion : Objeto de Negocio de registro de posibles perdidas.
  
    Fecha : 21-05-2013
  
    Historia de Modificaciones
  
    DD-MM-YYYY    <Autor>.SAONNNNN        Modificacion
    -----------  -------------------    -------------------------------------
    21-05-2013                          Creacion de Objeto
  19-09-2019    HORBATH       Modificacion procedimiento PBRegister_ntl para permitir registrar una solicitud PNO a un producto que ya tenga una asociada activa
    16-02-2023    jose.hinestroza   [OSF-849] Se elimina el commit al final del procedimiento PBRegister_ntl
    03-04-2023    jose.hinestroza   [OSF-950] parametro nuoIdOrderFmcap tipo OUT adicionado en el procedimiento PBRegister_ntl
  ******************************************************************/

  /* Procedimiento Registro PNO  */
  procedure PBRegister_ntl(nuActivity_id        in ge_items.items_id%type,
                           nuAddress_id         in fm_possible_ntl.address_id%type,
                           nuInformer_id        in fm_possible_ntl.informer_subs_id%type,
                           nuProduct2_id        in fm_possible_ntl.product_id%type,
                           sbComment            in fm_possible_ntl.comment_%type,
                           pnoOperating_unit_id in OR_operating_unit.operating_unit_id%type,
                           nuoIdOrderFmcap      OUT fm_possible_ntl.order_id%type);

end;
/
create or replace package body ldc_RegisterNTL is

  /**************************************************************
    Propiedad intelectual de Gases de Occidente.
    Unidad      :  PBRegister_ntl
    Descripcion :  Permite registrar una posible pérdida
  
    Fecha       :  21-05-2013
  
    Historia de Modificaciones
    Fecha        Autor              Modificacion
    =========    =========          ====================
    21-05-2013                      Creación
    19-09-2019  HORBATH             Modificacion procedimiento PBRegister_ntl para permitir registrar una solicitud PNO a un producto que ya tenga una asociada activa
    16-02-2023  jose.hinestroza     [OSF-849] Se elimina el commit al final del procedimiento PBRegister_ntl
    03-04-2023  jose.hinestroza     [OSF-950] parametro nuoIdOrderFmcap tipo OUT adicionado en el procedimiento PBRegister_ntl  
    09/02/2024  Jorge Valiente      OSF-1993: Logica para permitir generar solicitudes PNO con direcciones Dummy
    21/02/2024  Jorge Valiente      OSF-2364: Logica para permitir generar solicitud PNO a un producto que tenga otros proyectos registrados pero con todas la OT 12669 legelizadas
  ***************************************************************/

  procedure PBRegister_ntl(nuActivity_id        in ge_items.items_id%type,
                           nuAddress_id         in fm_possible_ntl.address_id%type,
                           nuInformer_id        in fm_possible_ntl.informer_subs_id%type,
                           nuProduct2_id        in fm_possible_ntl.product_id%type,
                           sbComment            in fm_possible_ntl.comment_%type,
                           pnoOperating_unit_id in OR_operating_unit.operating_unit_id%type,
                           nuoIdOrderFmcap      OUT fm_possible_ntl.order_id%type) is
  
    -- Definición de Variables necesarias para el proceso
  
    nuProduct_id          fm_possible_ntl.product_id%type;
    nugeograp_location_id fm_possible_ntl.geograp_location_id%type;
    nuProduct_type_id     fm_possible_ntl.product_type_id%type;
    nuDiscovery_type_id   fm_possible_ntl.discovery_type_id%type;
    nuValue               fm_possible_ntl.value_%type;
    nuStatus              fm_possible_ntl.status%type;
    nuPerson_id           fm_possible_ntl.person_id%type := null;
    pnoId                 fm_possible_ntl.possible_ntl_id%type;
    pnoOrder              fm_possible_ntl.order_id%type;
    pnoPackage            number;
    utExterna             or_operating_unit.name%type;
  
    TYPE rsPno IS RECORD(
      nuCodigo    NUMBER,
      sbestadoAnt VARCHAR2(1));
  
    TYPE tbPno IS TABLE OF rsPno INDEX BY BINARY_INTEGER;
  
    vtbPno  tbPno;
    nuIndex NUMBER := 1;
  
    --Inicio OSF-1993
    sbPendiente fm_possible_ntl.status%type := 'P'; --Pendiente (P)
    sbProyecto  fm_possible_ntl.status%type := 'R'; --Proyecto (R)    
  
    cursor cuPNO is
      SELECT *
        FROM fm_possible_ntl
       WHERE address_id = nuAddress_id
         AND product_type_id = nuProduct_type_id
         AND status in (sbPendiente, sbProyecto);
  
    rfcuPNO cuPNO%rowtype;
  
    csbSP_NAME CONSTANT VARCHAR2(35) := $$PLSQL_UNIT;
    csbMT_NAME VARCHAR2(70) := csbSP_NAME || '.PBRegister_ntl';
    nuError    NUMBER;
    sberror    VARCHAR2(4000);
    --Fin OSF-1993
  
    --Inicio OSF-2364
    sbEstadoOrdenValidaCreacionPNO varchar2(4000) := null;
    sbTipoTrabajoValidaCreacionPNO varchar2(4000) := null;
    nuOTSinLegalizar               number := 0;
    nuEstadoTemporal               fm_possible_ntl.status%type := 'E'; --E-Excluido
    --Fin OSF-2364  
  
  begin
  
    pkg_traza.trace(csbMT_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    /* Inicialización de Variables */
    nuProduct_type_id   := 7014; -- 7014 - Tipo Producto GAS
    nuDiscovery_type_id := fm_boconstants.csbManualRegistry; -- 4 - Registro Manual
    nuStatus            := fm_boconstants.csbPendingNTLStatus; -- P - Pendiente
  
    /* En caso de NO ingresar producto, buscamos uno asociado a la dirección */
    nuProduct_id := nuProduct2_id;
    if (nuProduct_id is null) then
      nuProduct_id := pkg_bodirecciones.fnuProductoPorDireccion(nuAddress_id,
                                                                nuProduct_type_id);
    end if;
  
    pkg_traza.trace('Codigo Direccion registrada: ' || nuAddress_id,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Producto asociada a direccion: ' || nuProduct_id,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Tipo de servicio: ' || nuProduct_type_id,
                    pkg_traza.cnuNivelTrzDef);
  
    /*En caso de no encontrar producto en la direccion registrada, indica que la direccion es Dummy*/
    IF nuProduct_id is null THEN
    
      --LLENO TABLA PL Y ACTUALIZO EL REGISTRO DE LA TABLA FM_POSSIBLE_NTL STATUS=F
      for rfcuPNO in cuPNO loop
      
        pkg_traza.trace('Codigo Proyecto PNO: ' || rfcuPNO.Possible_Ntl_Id,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('Estado Proyecto PNO: ' || rfcuPNO.Status ||
                        ' actualizado a estado ' || nuEstadoTemporal,
                        pkg_traza.cnuNivelTrzDef);
      
        vtbPno(nuIndex).nuCodigo := rfcuPNO.Possible_Ntl_Id;
        vtbPno(nuIndex).sbestadoAnt := rfcuPNO.Status;
      
        pkg_fm_possible_ntl.prcActualizarEstado(rfcuPNO.Possible_Ntl_Id,
                                                nuEstadoTemporal);
      
        nuIndex := nuIndex + 1;
      
      END loop;
    
    ELSE
    
      --Inicio OSF-2364
      sbTipoTrabajoValidaCreacionPNO := pkg_parametros.fsbGetValorCadena('TIPO_TRABAJO_VALIDA_CREACION_PNO');
      if sbTipoTrabajoValidaCreacionPNO is null then
        pkg_error.seterrormessage(isbMsgErrr => 'El parametro TIPO_TRABAJO_VALIDA_CREACION_PNO no tiene valor definido.');
      end if;
      sbEstadoOrdenValidaCreacionPNO := pkg_parametros.fsbGetValorCadena('ESTADO_ORDEN_VALIDA_CREACION_PNO');
      if sbEstadoOrdenValidaCreacionPNO is null then
        pkg_error.seterrormessage(isbMsgErrr => 'El parametro ESTADO_ORDEN_VALIDA_CREACION_PNO no tiene valor definido.');
      end if;
    
      pkg_traza.trace('Estado de orden a validar en PNO: ' ||
                      sbEstadoOrdenValidaCreacionPNO,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace('Tipo de Trabajo de orden a validar en PNO: ' ||
                      sbTipoTrabajoValidaCreacionPNO,
                      pkg_traza.cnuNivelTrzDef);
      nuOTSinLegalizar := pkg_bcordenespno.fnuCantidadOTSinLegalizar(nuProduct_id,
                                                                     nuAddress_id,
                                                                     nuProduct_type_id,
                                                                     sbEstadoOrdenValidaCreacionPNO,
                                                                     sbTipoTrabajoValidaCreacionPNO);
      if nuOTSinLegalizar = 0 then
      
        --LLENO TABLA PL Y ACTUALIZO EL REGISTRO DE LA TABLA FM_POSSIBLE_NTL STATUS=F
        for rfcuPNO in cuPNO loop
        
          pkg_traza.trace('Codigo Proyecto PNO: ' ||
                          rfcuPNO.Possible_Ntl_Id,
                          pkg_traza.cnuNivelTrzDef);
          pkg_traza.trace('Estado Proyecto PNO: ' || rfcuPNO.Status ||
                          ' actualizado a estado ' || nuEstadoTemporal,
                          pkg_traza.cnuNivelTrzDef);
        
          vtbPno(nuIndex).nuCodigo := rfcuPNO.Possible_Ntl_Id;
          vtbPno(nuIndex).sbestadoAnt := rfcuPNO.Status;
        
          pkg_fm_possible_ntl.prcActualizarEstado(rfcuPNO.Possible_Ntl_Id,
                                                  nuEstadoTemporal);
        
          nuIndex := nuIndex + 1;
        
        END loop;
      else
        pkg_error.seterrormessage(isbMsgErrr => 'El producto ' ||
                                                nuProduct_id ||
                                                ' tiene alguna orden u ordenes de PNO con TT [' ||
                                                sbTipoTrabajoValidaCreacionPNO ||
                                                '] sin legalizar.');
      end if;
      --Fin OSF-2364    
    END IF;
  
    /* Ingreso del registro de PNO al repositorio. La función internamente valida que no exista 
    una PNO pendiente para el producto, dirección, ubicación geográfica y tipo de producto.*/
  
    fm_boregister.register(nuProduct_id,
                           nugeograp_location_id,
                           nuAddress_id,
                           nuProduct_type_id,
                           sbComment,
                           nuDiscovery_type_id,
                           nuValue,
                           nuInformer_id,
                           nuStatus,
                           nuActivity_id,
                           nuPerson_id,
                           pnoId,
                           pnoOrder,
                           pnoPackage);
  
    --<< OSF-950
    nuoIdOrderFmcap := pnoOrder;
    pkg_traza.trace('Orden Generada: ' || nuoIdOrderFmcap,
                    pkg_traza.cnuNivelTrzDef);
    -->>
  
    if (pnoOperating_unit_id is not null) then
    
      utExterna := pnoOperating_unit_id || '-' ||
                   PKG_BCUNIDADOPERATIVA.FSBGETNOMBRE(pnoOperating_unit_id);
    
      if (DAGE_subs_work_relat.fblexist(nuInformer_id)) then
        update GE_SUBS_WORK_RELAT
           set previous_company = utExterna
         where subscriber_id = nuInformer_id;
      else
        INSERT INTO GE_SUBS_WORK_RELAT
        VALUES
          (nuInformer_id,
           Null,
           Null,
           Null,
           null,
           Null,
           Null,
           Null,
           NULL,
           utExterna,
           Null,
           Null,
           Null,
           Null,
           Null,
           Null);
      end if;
    
    end if;
  
    --RECORRRO LA TABLA PL Y RESTAURO LOS VALOR INCIALES DE LA TABLA FM_POSSIBLE_NTL
    pkg_traza.trace('Cantidad de registros en memoria PLSQL: ' ||
                    vtbPno.count,
                    pkg_traza.cnuNivelTrzDef);
  
    IF vtbPno.count > 0 THEN
      FOR i IN 1 .. vtbPno.count LOOP
      
        pkg_fm_possible_ntl.prcActualizarEstado(vtbPno(i).nuCodigo,
                                                vtbPno(i).sbestadoAnt);
      
        pkg_traza.trace('Codigo Proyecto PNO: ' || vtbPno(i).nuCodigo,
                        pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('Reestablecer estado anterior del Proyecto PNO: ' || vtbPno(i).sbestadoAnt,
                        pkg_traza.cnuNivelTrzDef);
      
      END LOOP;
    END IF;
  
    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuError, sberror);
      pkg_traza.trace('Error: ' || sberror, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sberror);
      pkg_traza.trace('Error: ' || sberror, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      raise pkg_error.CONTROLLED_ERROR;
  end;

end;
/
