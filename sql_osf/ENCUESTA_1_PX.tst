PL/SQL Developer Test script 3.0
329
-- Created on 13/07/2022 by JORGE VALIENTE 
declare

  inuOrderId    open.or_order.order_id%TYPE := 129971199;
  NUITEMS_ID    open.GE_ITEMS.ITEMS_ID%TYPE := 100008225;
  SBOBSERVACION open.LDC_RESPUESTA_GRUPO.OBSERVACION%TYPE := null;

    --Cursor que obtiene el producto, el contrato del producto y
    --el tipo de trabajo de acuerdo a la orden instanciada
    CURSOR cuProducto(nuorden NUMBER) IS
      SELECT PRODUCT_ID, SUBSCRIPTION_ID, TASK_TYPE_ID
        FROM open.OR_ORDER_ACTIVITY
       WHERE ORDER_ID = nuorden
         AND ROWNUM = 1;

    nuErrorCode       NUMBER;
    sbErrorMessage    VARCHAR2(4000);
    nuPackageId       open.mo_packages.package_id%TYPE;
    nuMotiveId        open.mo_motive.motive_id%TYPE;
    sbRequestIdExtern VARCHAR2(2000);
    sbRequestXML1     VARCHAR2(32767);
    nuorden           NUMBER;
    dtFecha           DATE := SYSDATE;
    nuPersonId        open.ge_person.person_id%TYPE;
    nuPtoAtncn        NUMBER;
    sbComment         VARCHAR2(2000) := 'TRAMITE GENERADO DESDE ENCUESTA';
    nuProductId       NUMBER;
    nuContratoId      NUMBER;
    nuTaskTypeId      NUMBER;
    nuComentarioLeg open.or_order_comment.order_comment%TYPE;
    nuAddressId       NUMBER;
    nuActividad       NUMBER;
    nuIdentification  NUMBER;
    nuContactId       NUMBER;
    sbOrdersId        VARCHAR2(4000);
    nuCOD_SERV_GAS    NUMBER;
    sbClasificacion   VARCHAR2(2000);

    --variables para datos de la entidad de instancia
    Ionuentity BINARY_INTEGER;
    Osbexist   VARCHAR2(4000);
    ---------------------------------------------------

    nuSublineid    open.ld_subline.subline_id%TYPE;
    nuPackageIdFNB open.mo_packages.package_id%TYPE;

    --NC 1562 cursor y variables
    sbnumber_id VARCHAR2(20) := '999999991';
    --open.DALD_PARAMETER.fsbGetValue_Chain('COD_USER_SOLICITUDES_INTERNAS',NULL);
    -------------------------

    --CASO 200-796
    sberrrorexcepcion varchar2(4000);

  BEGIN

    --ut_trace.trace('Inicio LDC_BOVENTASFNB.PRTRAMITE100101', 10);
    dbms_output.put_line('Inicio LDC_BOVENTASFNB.PRTRAMITE100101');

    -- Se consulta el usuario configurado en el parametro COD_USER_SOLICITUDES_INTERNAS
    nuIdentification := '999999991';--DALD_PARAMETER.fsbGetValue_Chain('COD_USER_SOLICITUDES_INTERNAS',NULL);

    -- Se valida si el parametro viene null
    IF (nuIdentification IS NULL) THEN
      sberrrorexcepcion := 'Servicio LDC_BOVENTASFNB.PRTRAMITE100101 - No existe configurado el parametro COD_USER_SOLICITUDES_INTERNAS';
      dbms_output.put_line('No existe configurado usuario en el parametro COD_USER_SOLICITUDES_INTERNAS');
      --RAISE EX.CONTROLLED_ERROR;
    END IF;

    --OBTIENE CODIGO DEL SERVICIO DE GAS
    nuCOD_SERV_GAS := 7014;
    --dald_parameter.fnuGetNumeric_Value('COD_SERV_GAS',NULL);
    IF nuCOD_SERV_GAS IS NULL THEN
      sberrrorexcepcion := 'Servicio LDC_BOVENTASFNB.PRTRAMITE100101 - El parametro COD_SERV_GAS no tiene codigo de servicio de GAS';
      dbms_output.put_line('El parametro COD_SERV_GAS no tiene codigo de servicio de GAS.');
      --RAISE ex.CONTROLLED_ERROR;
    END IF;

    /*
    --OBTIENE CODIGO DE LA ACTIVIDAD SE GENERA CON EL TRAMITE XML
    nuActividad := dald_parameter.fnuGetNumeric_Value('COD_ACTIVIDAD_ENCUESTA',
                                                      NULL);
    if nuActividad is null then
      ut_trace.trace('El parametro COD_ACTIVIDAD_ENCUESTA no tiene codigo de actividad configurado.',
                     10);
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       'El parametro COD_ACTIVIDAD_ENCUESTA no tiene codigo de actividad configurado.');
      raise ex.CONTROLLED_ERROR;
    end if;
    */

    nuActividad := NUITEMS_ID;

    --obtener datos de la ORDEN INGRESADA
    nuorden := inuOrderId;

    --Obtener person id
    BEGIN

      SELECT PERSON_ID
        INTO nuPersonId
        FROM OPEN.GE_PERSON
       WHERE IDENT_TYPE_ID = 110
         AND NUMBER_ID = sbnumber_id;

    EXCEPTION
      WHEN OTHERS THEN
        nuPersonId := 0;
    END;

    ---obtiene el area organizacional
    BEGIN

      SELECT ORGANIZAT_AREA_ID
        INTO nuPtoAtncn
        FROM open.CC_ORGA_AREA_SELLER
       WHERE PERSON_ID = nuPersonId
         AND IS_CURRENT = 'Y';
    EXCEPTION
      WHEN OTHERS THEN
        nuPtoAtncn := 0;
    END;

    --Comentario en el codigo de la solicitud padre prveiniente
    --de la orden de ENTREGA DE ARTICULOS - FNB
    sbComment := sbComment || ' ORIGINADO POR LA OT [ ' || nuorden || ' ]';

    OPEN cuProducto(nuorden);
    FETCH cuProducto
      INTO nuProductId, nuContratoId, nuTaskTypeId;
    IF cuProducto%NOTFOUND THEN
      sberrrorexcepcion := 'Servicio LDC_BOVENTASFNB.PRTRAMITE100101 - El cursor cuProducto no arrojo datos con el # de orden' ||
                           nuorden;
      dbms_output.put_line('El cursor cuProducto no arrojo datos con el # de orden' ||
                                       nuorden);
      --RAISE ex.CONTROLLED_ERROR;
    END IF;
    CLOSE cuProducto;

    --nuAddressId := dapr_product.fnugetaddress_id(nuProductId);
    begin
      select address_id into nuAddressId from open.pr_product where product_id = nuProductId;
    end;
    --dbms_output.put_line('Ejecucion LDC_BOVENTASFNB.PRTRAMITE100101 nuAddressId => '||nuAddressId);
    BEGIN

      SELECT gs.subscriber_id
        INTO nuContactId
        FROM open.ge_subscriber gs
       WHERE gs.identification = to_char(nuIdentification)
         AND rownum = 1;

    EXCEPTION
      WHEN OTHERS THEN
        nuContactId := 0;
    END;
    --dbms_output.put_line('Ejecucion LDC_BOVENTASFNB.PRTRAMITE100101 nuContactId => '||nuContactId);
    dbms_output.put_line('******************************************************');
    dbms_output.put_line('Datos obtenidos de las consultas de la orden ' ||
                   nuorden);
    dbms_output.put_line('Area organizacionla --> ' || nuPtoAtncn);
    dbms_output.put_line('Paquete --> ' || nuPackageIdFNB);
    dbms_output.put_line('Contrato --> ' || nuContratoId);
    dbms_output.put_line('Tipo de trabajo --> ' || nuTaskTypeId);
    dbms_output.put_line('Identificacion --> ' || nuIdentification);
    dbms_output.put_line('Producto --> ' || nuProductId);
    dbms_output.put_line('Direccion --> ' || nuAddressId);
    dbms_output.put_line('Contacto --> ' || nuContactId);
    dbms_output.put_line('Actividad --> ' || nuActividad);
    dbms_output.put_line('******************************************************');

    /*
        sbRequestXML1 := '<P_LBC_VENTA_DE_SERVICIOS_DE_INGENIERIA_100101 ID_TIPOPAQUETE="100101">
                    <CUSTOMER/>
                    <CONTRACT/>
                    <PRODUCT>' || nuProductId ||
                         '</PRODUCT>
                    <FECHA_DE_SOLICITUD>' || dtFecha ||
                         '</FECHA_DE_SOLICITUD>
                    <ID>' || nuPersonId ||
                         '</ID>
                    <POS_OPER_UNIT_ID>' || nuPtoAtncn ||
                         '</POS_OPER_UNIT_ID>
                    <RECEPTION_TYPE_ID>10</RECEPTION_TYPE_ID>
                    <CONTACT_ID>' || nuContactId ||
                         '</CONTACT_ID>
                    <ADDRESS_ID/>
                    <COMMENT_>' || sbComment ||
                         '</COMMENT_>
                    <CONTRATO>' || nuContactId ||
                         '</CONTRATO>
                  <M_SOLICITUD_DE_TRABAJOS_PARA_UN_CLIENTE_100113>
                    <ITEM_ID>' || nuActividad ||
                         '</ITEM_ID>
                    <DIRECCION_DE_EJECUCION_DE_TRABAJOS>' ||
                         nuAddressId ||
                         '</DIRECCION_DE_EJECUCION_DE_TRABAJOS>
                    <C_GENERICO_22>
                    <C_GENERICO_10319/>
                    </C_GENERICO_22>
                    </M_SOLICITUD_DE_TRABAJOS_PARA_UN_CLIENTE_100113>
                    </P_LBC_VENTA_DE_SERVICIOS_DE_INGENIERIA_100101>';
    */

    BEGIN
        SELECT order_comment INTO nuComentarioLeg
        FROM open.or_order_comment oc
        WHERE oc.order_id = inuOrderId AND legalize_comment = 'Y';
        sbComment := sbComment ||': '|| nuComentarioLeg;
    EXCEPTION
      WHEN OTHERS THEN
        nuComentarioLeg := null;
    END;

    sbRequestXML1 := '<P_LBC_VENTA_DE_SERVICIOS_DE_INGENIERIA_100101 ID_TIPOPAQUETE="100101">
                <CUSTOMER/>
                <CONTRACT/>
                <PRODUCT>' || nuProductId ||
                     '</PRODUCT>
                <FECHA_DE_SOLICITUD>' || dtFecha ||
                     '</FECHA_DE_SOLICITUD>
                <ID>' || nuPersonId ||
                     '</ID>
                <POS_OPER_UNIT_ID>' || nuPtoAtncn ||
                     '</POS_OPER_UNIT_ID>
                <RECEPTION_TYPE_ID>10</RECEPTION_TYPE_ID>
                <CONTACT_ID>' || nuContactId ||
                     '</CONTACT_ID>
                <ADDRESS_ID/>
                <COMMENT_>' || sbComment ||
                     '</COMMENT_>
                <CONTRATO>' || nuContactId ||
                     '</CONTRATO>
              <M_SOLICITUD_DE_TRABAJOS_PARA_UN_CLIENTE_100113>
                <ITEM_ID>' || nuActividad ||
                     '</ITEM_ID>
                <DIRECCION_DE_EJECUCION_DE_TRABAJOS>' ||
                     nuAddressId ||
                     '</DIRECCION_DE_EJECUCION_DE_TRABAJOS>
                <C_GENERICO_22>
                <C_GENERICO_10319/>
                </C_GENERICO_22>
                </M_SOLICITUD_DE_TRABAJOS_PARA_UN_CLIENTE_100113>
                </P_LBC_VENTA_DE_SERVICIOS_DE_INGENIERIA_100101>';

    dbms_output.put_line(sbRequestXML1);

    --*/

    /*
    errors.Initialize;
    ut_trace.Init;
    ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
    ut_trace.SetLevel(90);
    ut_trace.Trace('INICIO');
    */
    --  dbms_output.put_line('Fecha Inicial 1: ' || sysdate);
    -- dbms_output.put_line('sesion: ' || ut_session.getsessionid);
    /*
    OS_RegisterRequestWithXML(sbRequestXML1,
                              nuPackageId,
                              nuMotiveId,
                              nuErrorCode,
                              sbErrorMessage);
    --*/
    --  dbms_output.put_line('Fecha final 1 : ' || sysdate);
    dbms_output.put_line('Paquete : ' || nuPackageId);
    dbms_output.put_line('Motivo : ' || nuMotiveId);
    dbms_output.put_line('SALIDA onuErrorCode: ' || nuErrorCode);
    dbms_output.put_line('SALIDA osbErrorMess: ' || sbErrorMessage);

    dbms_output.put_line('XML--> ' || sbRequestXML1);

    --ut_trace.trace('nuErrorCode --> ' || nuErrorCode, 10);
    --ut_trace.trace('nuErrorCode --> ' || sbErrorMessage, 10);

    /*IF nuErrorCode <> 0 THEN
      sberrrorexcepcion := 'Servicio LDC_BOVENTASFNB.PRTRAMITE100101 - Error al crear el tramite [' ||
                           nuErrorCode || ' - [' || sbErrorMessage ||
                           ']'; -- XML[' || sbRequestXML1 || ']';
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       sbErrorMessage ||
                                       ' Codigo Error --> ' || nuErrorCode);
      RAISE ex.CONTROLLED_ERROR;
    END IF;*/

    ---Cambio 6581
    /*--actualizacion de la observacion de la orden generada por la solicitud.
    UPDATE OPEN.OR_ORDER_ACTIVITY OOA
       SET ooa.comment_ = nvl(SBOBSERVACION, sbComment)
     WHERE OOA.Package_Id = nuPackageId
       AND ooa.activity_id = nuActividad;*/
    ---fin Cambio 6581

    sberrrorexcepcion := 'Servicio LDC_BOVENTASFNB.PRTRAMITE100101 - Error al actualizar datos en la tabal OR_ORDER_ACTIVITY]';

    --ut_trace.trace('Fin LDC_BOVENTASFNB.LDC_PrEntregaArticulos', 10);
    dbms_output.put_line('Fin LDC_BOVENTASFNB.PRTRAMITE100101');

  /*EXCEPTION

    WHEN ex.CONTROLLED_ERROR THEN
      LDC_PRLOGENCUESTA(NUORDEN, null, null, null, sberrrorexcepcion);
      -- Rollback;
      Errors.setError;
      Errors.getError(nuErrorCode, sbErrorMessage);
      dbms_output.put_line('ERROR ex.CONTROLLED_ERROR ');
      dbms_output.put_line('error onuErrorCode: ' || nuErrorCode);
      dbms_output.put_line('error osbErrorMess: ' || sbErrorMessage ||
                           ' - ' || SQLERRM);
      --RAISE;

    WHEN OTHERS THEN
      --LDC_PRLOGENCUESTA(NUORDEN, null, null, null, sberrrorexcepcion);
      -- Rollback;
      Errors.setError;
      Errors.getError(nuErrorCode, sbErrorMessage);
      dbms_output.put_line('ERROR OTHERS ');
      dbms_output.put_line('error onuErrorCode: ' || nuErrorCode);
      dbms_output.put_line('error osbErrorMess: ' || sbErrorMessage ||
                           ' - ' || SQLERRM);
      LDC_PRLOGENCUESTA(NUORDEN,
                        null,
                        null,
                        null,
                        nuErrorCode || ' - ' || sbErrorMessage);
      --RAISE;*/

end;
0
0
