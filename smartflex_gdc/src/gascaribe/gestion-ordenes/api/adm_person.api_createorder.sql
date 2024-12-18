create or replace PROCEDURE   adm_person.api_createorder(   inuItemsid          IN 		NUMBER,
                                                            inuPackageid        IN 		NUMBER,
                                                            inuMotiveid         IN 		NUMBER,
                                                            inuComponentid      IN 		NUMBER,
                                                            inuInstanceid       IN 		NUMBER,
                                                            inuAddressid        IN 		NUMBER,
                                                            inuElementid        IN 		NUMBER,
                                                            inuSubscriberid     IN 		NUMBER,
                                                            inuSubscriptionid   IN 		NUMBER,
                                                            inuProductid        IN 		NUMBER,                                                                    
                                                            inuOperunitid       IN 		NUMBER,
                                                            idtExecestimdate    IN 		DATE,
                                                            inuProcessid        IN 		NUMBER,
                                                            isbComment          IN 		VARCHAR2,
                                                            iblProcessorder     IN 		BOOLEAN,
                                                            inuPriorityid       IN 		NUMBER DEFAULT NULL,
                                                            inuOrdertemplateid  IN 		NUMBER DEFAULT NULL,
                                                            isbCompensate       IN 		VARCHAR2 DEFAULT 'Y',
                                                            inuConsecutive      IN 		NUMBER DEFAULT NULL,
                                                            inuRouteid          IN 		NUMBER DEFAULT NULL,
                                                            inuRouteConsecutive IN 		NUMBER DEFAULT NULL,
                                                            inuLegalizetrytimes IN 		NUMBER DEFAULT 0,
                                                            isbTagname          IN 		VARCHAR2 DEFAULT NULL,
                                                            iblIsacttoGroup     IN 		BOOLEAN DEFAULT TRUE,
                                                            inuRefvalue         IN 		NUMBER DEFAULT NULL,
                                                            inuActionid         IN 		NUMBER DEFAULT NULL,
                                                            ionuOrderid         IN OUT 	NUMBER,
                                                            ionuOrderactivityid IN OUT 	NUMBER,
                                                            onuErrorCode        OUT 	NUMBER,
                                                            osbErrorMessage     OUT     VARCHAR2) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : api_createorder
    Descripcion     : api para realizar creacion de orden
    Autor           : Luis Javier Lopez Barrios
    Fecha           : 14-06-2023

    Parametros de Entrada
       inuItemsid            codigo de la actividad
	   inuPackageid          solicitud
	   inuMotiveid           motivo
	   inuComponentid        componente
	   inuInstanceid         instancia
	   inuAddressid          direccion
	   inuElementid          elemento de medicion
	   inuSubscriberid       cliente
	   inuSubscriptionid     contrato
	   inuProductid          producto
	   inuOpersectorid       sector operactivo
	   inuOperunitid         unidad operativa
	   idtExecestimdate      fecha de estimacion
	   inuProcessid          proceso
	   isbComment            comentario de la orden
	   iblProcessorder       procesar orden
	   inuPriorityid         prioridad
	   inuOrdertemplateid    template
	   isbCompensate         actividad compensa
	   inuConsecutive        consecutivo
	   inuRouteid            ruta
	   inuRouteConsecutive   consecutivo de ruta
	   inuLegalizetrytimes   numero de veces que se ha intentado legalizar la orden
	   isbTagname            tag de etapa de ejecucion
	   iblIsacttoGroup       lista de acciones por grugo?
	   inuRefvalue           valor de referencia (novedad)
	   inuActionid      	 accion
    Parametros de Entrada/Salida
	   ionuOrderid       	 codigo de la orden
	   ionuOrderactivityid   codigo de orden activity
	Parametros de Salida
	   onuErrorCode     	 codigo de error
       osbErrorMessage   	 mensaje de error
    Modificaciones  :
    =========================================================
    Autor           Fecha           Descripcion
    Paola Acosta    19-03-2024      OSF-2485 Se retira validación que evalua que cliente debe estar asociado al contrato.
                                             Se retira validación que evalua que cliente debe estar asociado al producto.
  ***************************************************************************/
      nuCliente          NUMBER;
      nuContrato         NUMBER;
      nuSolicitud        NUMBER;
      nuMotivo           NUMBER;
      sbExiste           VARCHAR2(1);
      nuOpersectorid     NUMBER;
      
      CURSOR cuExisteSolicitud IS
      SELECT 'X'
      FROM mo_packages 
      WHERE mo_packages.package_id = inuPackageid;
      
      CURSOR cuExisteCliente IS
      SELECT 'X'
      FROM ge_subscriber 
      WHERE ge_subscriber.subscriber_id = inuSubscriberid;
      
      CURSOR cuExisteActividad IS
      SELECT 'X'
      FROM ge_items 
      WHERE ge_items.items_id = inuItemsid 
       AND ge_items.item_classif_id = 2;
      
      CURSOR cuGetSectorOper IS
      SELECT ab_segments.operating_sector_id
      FROM ab_address
         LEFT JOIN ab_segments ON ab_address.segment_id = ab_segments.segments_id
      WHERE ab_address.address_id = inuAddressid;

  
      PROCEDURE proValidaInfoRequerida IS
      BEGIN
        --se validan campos obligatorios para el proceso
        IF inuItemsid IS NULL THEN
            PKG_ERROR.seterrormessage(isbMsgErrr => 'Campo Actividad es requerido');
        END IF;
         
        IF inuAddressid IS NULL THEN
            PKG_ERROR.seterrormessage(isbMsgErrr => 'Campo Direccion es requerido');
        END IF;
         
        IF isbComment IS NULL THEN
            PKG_ERROR.seterrormessage(isbMsgErrr => 'Campo Comentario es requerido');
        END IF;
      END proValidaInfoRequerida;
      
      PROCEDURE proValidaInfoContrato IS
       
       --se obtiene informacion del contrato
       CURSOR cuGetInfoContrato IS
       SELECT  suscripc.suscclie
       FROM suscripc
       WHERE suscripc.susccodi = inuSubscriptionid;
        
      BEGIN
         IF cuGetInfoContrato%ISOPEN THEN
            CLOSE cuGetInfoContrato;
         END IF;
         
         OPEN cuGetInfoContrato;
         FETCH cuGetInfoContrato INTO  nuCliente;
         IF cuGetInfoContrato%NOTFOUND THEN
            CLOSE cuGetInfoContrato;
            PKG_ERROR.seterrormessage(isbMsgErrr => 'Contrato ['||inuSubscriptionid||'] no existe');
         END IF;
         CLOSE cuGetInfoContrato;         
         
      END proValidaInfoContrato;
      
      PROCEDURE proValidaInfoProducto IS
       --se obtiene informacion del producto
       CURSOR cuGetInfoProducto IS
       SELECT  sesususc, suscclie
       FROM servsusc, suscripc
       WHERE susccodi = sesususc
        AND sesunuse = inuProductid;
        
      BEGIN
         IF cuGetInfoProducto%ISOPEN THEN
            CLOSE cuGetInfoProducto;
         END IF;
         
         OPEN cuGetInfoProducto;
         FETCH cuGetInfoProducto INTO nuContrato, nuCliente;
         IF cuGetInfoProducto%NOTFOUND THEN
            CLOSE cuGetInfoProducto;
            PKG_ERROR.seterrormessage(isbMsgErrr => 'Producto ['||inuProductid||'] no existe');
         END IF;
         CLOSE cuGetInfoProducto;
         
         IF nuContrato <>  inuSubscriptionid AND inuSubscriptionid IS NOT NULL THEN
             PKG_ERROR.seterrormessage(isbMsgErrr => ' Contrato ['||inuSubscriptionid||'] no esta asociado al Producto ['||inuProductid||']');
         END IF;
                
      END proValidaInfoProducto;
      
      PROCEDURE proValidaInfoMotiSolicitud IS
       
       CURSOR cuGetInfoSolicitud IS
       SELECT mo_motive.package_id
       FROM mo_motive
       WHERE mo_motive.motive_id = inuMotiveid;
       
      BEGIN
        IF cuGetInfoSolicitud%ISOPEN THEN
          CLOSE cuGetInfoSolicitud;
        END IF;
        
        OPEN cuGetInfoSolicitud;
        FETCH cuGetInfoSolicitud INTO nuSolicitud;
        CLOSE cuGetInfoSolicitud;
        
        IF nuSolicitud <> inuPackageid AND inuPackageid IS NOT NULL  THEN
           PKG_ERROR.seterrormessage(isbMsgErrr => ' Solicitud ['||inuPackageid||'] no esta asociado al Motivo ['||inuMotiveid||']');
        END IF;
        
      END proValidaInfoMotiSolicitud;
      
       PROCEDURE proValidaInfoCompSolicitud IS
       
       CURSOR cuGetInfoComponente IS
       SELECT mo_motive.package_id, mo_component.motive_id
       FROM mo_component
         JOIN mo_motive ON mo_motive.motive_id = mo_component.motive_id
       WHERE mo_component.component_id = inuComponentid;
       
      BEGIN
        IF cuGetInfoComponente%ISOPEN THEN
          CLOSE cuGetInfoComponente;
        END IF;
        
        OPEN cuGetInfoComponente;
        FETCH cuGetInfoComponente INTO nuSolicitud, nuMotivo;
        CLOSE cuGetInfoComponente;
        
        IF nuSolicitud <> inuPackageid AND inuPackageid IS NOT NULL  THEN
           PKG_ERROR.seterrormessage(isbMsgErrr => ' Solicitud ['||inuPackageid||'] no esta asociado al Componente ['||inuComponentid||']');
        END IF;
        
        IF nuMotivo <> inuMotiveid AND inuMotiveid IS NOT NULL  THEN
           PKG_ERROR.seterrormessage(isbMsgErrr => ' Motivo ['||inuMotiveid||'] no esta asociado al Componente ['||inuComponentid||']');
        END IF;
        
      END proValidaInfoCompSolicitud;
      
      PROCEDURE prCierreCursores IS
      
      BEGIN
         IF cuGetSectorOper%ISOPEN THEN
            CLOSE cuGetSectorOper;
         END IF;
         
         IF cuExisteActividad%ISOPEN THEN
            CLOSE cuExisteActividad;
         END IF;
         
         IF cuExisteCliente%ISOPEN THEN
           CLOSE cuExisteCliente;
         END IF;
         
         IF cuExisteSolicitud%ISOPEN THEN
          CLOSE cuExisteSolicitud;
        END IF;
         
      END prCierreCursores;
 
 BEGIN

     onuErrorCode := 0;
     prCierreCursores;
     --se realiza validaciones del  proceso 
     proValidaInfoRequerida;
     
     IF NVL(inuLegalizetrytimes, 0) < 0 THEN
         PKG_ERROR.seterrormessage(isbMsgErrr => ' Cantidad de intento de legalizaciones no puede ser menor a cero');
     END IF;
     
     OPEN cuExisteActividad;
     FETCH cuExisteActividad INTO  sbExiste;
     IF cuExisteActividad%NOTFOUND THEN
       CLOSE cuExisteActividad;
       PKG_ERROR.seterrormessage(isbMsgErrr => ' Actividad ['||inuItemsid||'] no existe');
     END IF;
     CLOSE cuExisteActividad;
     
     OPEN cuGetSectorOper;
     FETCH cuGetSectorOper INTO nuOpersectorid;
     IF cuGetSectorOper%NOTFOUND THEN
        CLOSE cuGetSectorOper;
        PKG_ERROR.seterrormessage(isbMsgErrr => ' Direccion ['||inuAddressid||'] no existe');
     END IF;
     CLOSE cuGetSectorOper;
     
     
     
     IF inuSubscriberid IS NOT NULL THEN
        OPEN cuExisteCliente;
        FETCH cuExisteCliente INTO sbExiste;
        IF cuExisteCliente%NOTFOUND THEN
           CLOSE cuExisteCliente;
           PKG_ERROR.seterrormessage(isbMsgErrr => ' Cliente ['||inuSubscriberid||'] no existe');
        END IF;
        CLOSE cuExisteCliente;
        
        nucliente := inuSubscriberid;    
     END IF;
     
     IF inuSubscriptionid IS NOT NULL THEN
       proValidaInfoContrato;
       nuContrato := inuSubscriptionid;
     END IF;
     
     IF inuProductid IS NOT NULL THEN
        proValidaInfoProducto; 
     END IF;
     
     IF inuPackageid IS NOT NULL THEN
       
       OPEN cuExisteSolicitud;
       FETCH cuExisteSolicitud INTO sbExiste;
       IF cuExisteSolicitud%NOTFOUND THEN
           CLOSE cuExisteSolicitud;
           PKG_ERROR.seterrormessage(isbMsgErrr => ' Solicitud ['||inuPackageid||'] no existe');
       END IF;
       CLOSE cuExisteSolicitud;
       
       nuSolicitud := inuPackageid;
     END IF;
     
     IF inuMotiveid IS NOT NULL THEN
        proValidaInfoMotiSolicitud;
        nuMotivo := inuMotiveid;
     END IF;
     
     IF inuComponentid IS NOT NULL THEN
        proValidaInfoCompSolicitud;
     END IF;
     
     or_boorderactivities.createactivity( 	inuitemsid      ,
                                            nuSolicitud     ,
                                            nuMotivo        ,
                                            inucomponentid  ,
                                            inuinstanceid   ,
                                            inuaddressid    ,
                                            inuelementid    ,
                                            nucliente       ,
                                            nuContrato      ,
                                            inuproductid    ,
                                            nuOpersectorid  ,
                                            inuoperunitid    ,
                                            idtexecestimdate ,
                                            inuprocessid     ,
                                            isbcomment       ,
                                            iblprocessorder  ,
                                            inupriorityid    ,
                                            ionuorderid      ,
                                            ionuorderactivityid,
                                            inuordertemplateid ,
                                            isbcompensate      ,
                                            inuconsecutive     ,
                                            inurouteid         ,
                                            inurouteconsecutive,
                                            inulegalizetrytimes,
                                            isbtagname         ,
                                            iblisacttogroup    ,
                                            inurefvalue        ,
                                            inuactionid );
EXCEPTION
  when PKG_ERROR.CONTROLLED_ERROR then
    prCierreCursores;
    pkg_Error.GETERROR(onuErrorCode, osbErrorMessage);
 WHEN OTHERS THEN
    PKG_ERROR.SETERROR;
    PKG_ERROR.GETERROR(onuErrorCode, osbErrorMessage);
    prCierreCursores;
END api_createorder;
/
begin
  pkg_utilidades.prAplicarPermisos('API_CREATEORDER', 'ADM_PERSON');
end;
/