DECLARE
  nuCliente_id         ge_subscriber.subscriber_id%TYPE;
  nuTipoIdentificacion ge_subscriber.ident_type_id%TYPE;
  sbIdentificacion     ge_subscriber.identification%TYPE;
  nuTipoClinte         ge_subscriber.subscriber_type_id%TYPE;
  nudireccion          ge_subscriber.address%TYPE;
  nuTelefono           ge_subscriber.phone%TYPE;
  sbNombreCliente      ge_subscriber.subscriber_name%TYPE;
  sbApellidoCiente     ge_subscriber.subs_last_name%TYPE;
  sbCorreo             ge_subscriber.e_mail%TYPE;
  sbSexo               ge_subs_general_data.gender%TYPE;
  nuCodigoError        ge_error_log.error_log_id%TYPE;
  sbMensajeError       ge_error_log.description%TYPE;

  nuCicloFactura   NUMBER;
  sbTipoDirecCobro VARCHAR2(2);
  nuDireccionCobro NUMBER;
  nuSuscripcion    NUMBER;
  nuTipoProducto   NUMBER;

  nuCategoria      NUMBER;
  nuSubcategoria   NUMBER;
  nuProductoMotivo NUMBER;
  nuPlanComercial  NUMBER;
  rcDireccion      pkg_bcdirecciones.styDirecciones;
  nuComponente     NUMBER;
  nuProductoCreado NUMBER;
BEGIN
  dbms_output.put_line('Inicia OSF-6164!');

  nuTipoIdentificacion := 1;
  sbIdentificacion     := '44001';
  nuTipoClinte         := 1;
  nudireccion          := 5886044;
  nuTelefono           := 7777777;
  sbNombreCliente      := 'CLIENTE DUMMY GASES DE LA GUAJIRA';
  sbApellidoCiente     := 'NO MODIFICAR';
  sbSexo               := 'F';
  sbCorreo             := 'notiene@correo.com';

  api_customerregister(nuCliente_id,
                       nuTipoIdentificacion,
                       sbIdentificacion,
                       NULL,
                       nuTipoClinte,
                       nudireccion,
                       nuTelefono,
                       sbNombreCliente,
                       sbApellidoCiente,
                       sbCorreo,
                       NULL,
                       NULL,
                       NULL,
                       NULL,
                       NULL,
                       NULL,
                       NULL,
                       NULL,
                       sbSexo,
                       NULL,
                       nuCodigoError,
                       sbMensajeError);

  IF (NVL(nuCodigoError, 0) <> 0) THEN
    dbms_output.put_line('Error al crear el cliente: ' || nuCodigoError || '-' ||
                         sbMensajeError);
    ROLLBACK;
  ELSE
    dbms_output.put_line('Cliente creado : ' || nuCliente_id);
  
    -- Inserta protección de datos
    INSERT INTO ldc_proteccion_datos
      (id_cliente,
       cod_estado_ley,
       estado,
       fecha_creacion,
       usuario_creacion)
    VALUES
      (nuCliente_id, 1, 'S', SYSDATE, USER);
  
    nuCicloFactura   := 9999;
    sbTipoDirecCobro := 'VT';
    nuDireccionCobro := 5886044;
  
    -- Crear el contrato api_subscriptionregister
    api_subscriptionregister(nuCliente_id,
                             nuCicloFactura,
                             sbTipoDirecCobro,
                             nuDireccionCobro,
                             nuSuscripcion,
                             nuCodigoError,
                             sbMensajeError);
  
    IF (NVL(nuCodigoError, 0) <> 0) THEN
      dbms_output.put_line('Error al crear el contrato: ' || nuCodigoError || '-' ||
                           sbMensajeError);
      ROLLBACK;
    ELSE
      dbms_output.put_line('Contrato creado : ' || nuSuscripcion);
    
      -- Registra producto de cobro de servicios
      nuTipoProducto  := 3;
      nuPlanComercial := 1;
      nuDireccion     := 5886044;
      nuCategoria     := -1;
      nuSubcategoria  := -1;
    
      rcDireccion := pkg_bcdirecciones.frcgetrecord(nuDireccion);
    
      nuProductoMotivo := pkg_bogestionestructura_prod.fnuObtieneMotivoporNombreTag('M_INSTALACION_DE_COBRO_DE_SERVICIOS_121');
      dbms_output.put_line('nuProductoMotivo: ' || nuProductoMotivo);
    
      pkg_bsgestion_producto.prcRegistraProductoyComponente(nuSuscripcion,
                                                            nuTipoProducto,
                                                            nuPlanComercial,
                                                            ldc_boConsGenerales.fdtGetSysDate,
                                                            nuDireccion,
                                                            nuCategoria,
                                                            nuSubcategoria,
                                                            pkg_session.fnugetempresadeusuario,
                                                            pkg_bopersonal.fnuGetPersonaId,
                                                            pkg_bopersonal.fnuGetPuntoAtencionId(pkg_bopersonal.fnuGetPersonaId),
                                                            nuProductoCreado,
                                                            pkg_gestion_producto.CNUESTADO_ACTIVO_PRODUCTO,
                                                            NULL, -- estado de corte
                                                            NULL,
                                                            NULL,
                                                            NULL,
                                                            NULL,
                                                            --Componente
                                                            null, /* inuClassServiceId */
                                                            NULL, /* isbServiceNumber */
                                                            NULL, /* idtServiceDate */
                                                            NULL, /* idtMediationDate */
                                                            NULL, /* inuQuantity */
                                                            NULL, /* inuUnchargedTime */
                                                            NULL, /* isbDirectionality */
                                                            NULL, /* inuDistributAdminId */
                                                            NULL, /* inuMeter */
                                                            NULL, /* inuBuildingId */
                                                            NULL, /* inuAssignRouteId */
                                                            NULL, /* isbDistrictId */
                                                            NULL, /* isbincluded */
                                                            rcDireccion.geograp_location_id, /* inugeograp_location_id */
                                                            rcDireccion.neighborthood_id, /* inuneighborthood_id */
                                                            rcDireccion.address, /* isbaddress */
                                                            NULL, /* inuProductOrigin */
                                                            NULL, /* inuIncluded_Features_Id */
                                                            NULL, /* isbIsMain */
                                                            nuComponente, /* onuComponentId */
                                                            FALSE, /* iblRegAddress */
                                                            FALSE, /* iblElemmedi */
                                                            FALSE, /* iblSpecialPhone */
                                                            NULL, /* inuCompProdProvisionId */
                                                            pkg_gestion_producto.CNUESTADO_ACTIVO_COMPONENTE, /* inuComponentStatusId */
                                                            FALSE, /* iblValidate */
                                                            nuProductoMotivo, /*inuMotivoProducto*/
                                                            nuCodigoError,
                                                            sbMensajeError);
    
      dbms_output.put_line('nuProductoCreado tipo 3 : ' ||
                           nuProductoCreado || CHR(10) || 'nuComponente: ' ||
                           nuComponente || CHR(10) || 'nuCodigoError: ' ||
                           nuCodigoError || CHR(10) || 'sbMensajeError: ' ||
                           sbMensajeError);
    
      -- Se inserta el contrato a la empresa
      INSERT into Contrato values (nuSuscripcion, 'GDGU');
    
      COMMIT;
    
    END IF;
  END IF;

  dbms_output.put_line('Fin OSF-6164!');
EXCEPTION
  when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
END;
/
