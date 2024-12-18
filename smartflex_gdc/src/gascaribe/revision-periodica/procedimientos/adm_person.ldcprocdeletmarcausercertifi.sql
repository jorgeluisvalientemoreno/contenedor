create or replace PROCEDURE adm_person.ldcprocdeletmarcausercertifi AS
    /**************************************************************************
    Propiedad Intelectual de Gases del caribe S.A E.S.P

    Funcion     : ldcprocdeletmarcausercertifi
    Descripcion : CASO 200-1743 Procedimiento que elimina las marcas cuando el usuario(Producto) esta certificado
    Autor       : Josh Brito
    Fecha       : 13-03-2018

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    13/03/2018          jbrito             CASO 200-1743 Creacion
    24/04/2024          Adrianavg          OSF-2597: Se migra del esquema OPEN al esquema ADM_PERSON
**************************************************************************/

    nuErrorCode         NUMBER;
    sbErrorMessage      VARCHAR2(4000);
    nuPackageId         mo_packages.package_id%type;
    nuMotiveId          mo_motive.motive_id%type;
    sbrequestxml1       VARCHAR2(32767);
    nuOrderId           or_order.order_id%type;
    nuOrderActivityId   or_order_activity.ORDER_ACTIVITY_ID%type;
    sbComment           VARCHAR2(2000);
    nuProductId         NUMBER;
    nuCertificadoExite  NUMBER DEFAULT 0;
    numes               NUMBER(2);
    nuContratoId        NUMBER;
    nuTaskTypeId        NUMBER;
    nuCausalOrder       NUMBER;
    ex_error            EXCEPTION;
    nupakageid          mo_packages.package_id%TYPE;
    nucliente           ge_subscriber.subscriber_id%TYPE;
    numediorecepcion    mo_packages.reception_type_id%TYPE;
    sbdireccionparseada ab_address.address_parsed%TYPE;
    nudireccion         ab_address.address_id%TYPE;
    nulocalidad         ab_address.geograp_location_id%TYPE;
    nucategoria         mo_motive.category_id%TYPE;
    nusubcategori       mo_motive.subcategory_id%TYPE;
    sw                  NUMBER(2) DEFAULT 0;
    nuparano            NUMBER(4);
    nuparmes               NUMBER(2);
    nutsess             NUMBER;
    sbparuser           VARCHAR2(30);
    sbmensa             VARCHAR2(10000);
    numarca             ld_parameter.parameter_id%TYPE;
    numarcaantes        ldc_marca_producto.suspension_type_id%TYPE;
    nucantotleg         NUMBER(8);
    dtplazominrev       ldc_plazos_cert.plazo_min_revision%TYPE;
    sbsolicitudes       VARCHAR2(1000);

BEGIN
     -- Consultamos datos para inicializar el proceso
    SELECT to_number(to_char(SYSDATE,'YYYY'))
         ,to_number(to_char(SYSDATE,'MM'))
         ,userenv('SESSIONID')
         ,USER INTO nuparano,nuparmes,nutsess,sbparuser
     FROM dual;
    -- Inicializamos el proceso
    ldc_proinsertaestaprog(nuparano,nuparmes,'ldcprocdeletmarcausercertifi','En ejecucion',nutsess,sbparuser);

    nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;
    ut_trace.trace('ldcprocdeletmarcausercertifi-nuOrderId -->'||nuOrderId, 10);

    nuOrderActivityId := ldc_bcfinanceot.fnuGetActivityId(nuOrderId);
    ut_trace.trace('ldcprocdeletmarcausercertifi-nuOrderActivityId -->'||nuOrderActivityId, 10);

    nuProductId := daor_order_activity.fnugetproduct_id(nuOrderActivityId);
    ut_trace.trace('ldcprocdeletmarcausercertifi-nuProductId -->'||nuProductId, 10);

    numes := open.DALD_PARAMETER.fnuGetNumeric_Value('LDC_PARNUMMESESVAL');
    ut_trace.trace('ldcprocdeletmarcausercertifi-numes -->'||numes, 10);

    BEGIN
        -- se valida si el usuario o producto cuyo certificado mas reciente tenga una fecha etimada de finalizacion valida
        SELECT count(1) INTO nuCertificadoExite
           FROM( SELECT *
                  FROM open.pr_certificate
                  WHERE PRODUCT_ID = nuProductId
                  AND ESTIMATED_END_DATE >= ADD_MONTHS(SYSDATE, numes)
                  ORDER BY REGISTER_DATE DESC )
           WHERE ROWNUM = 1;
     EXCEPTION
      WHEN no_data_found THEN
       nuCertificadoExite := 0;
    END;

    --se elimina la marca del producto si el usuario esta certificado
    IF nuCertificadoExite > 0 THEN
        numarcaantes := ldc_fncretornamarcaprod(nuProductId);
        DELETE FROM open.ldc_marca_producto WHERE ID_PRODUCTO = nuProductId;
         ldc_prmarcaproductolog(nuProductId,numarcaantes, null , 'Legalizacion OT :'||nuOrderId);
         ut_trace.trace('Fin LDC_PRBORRAMARCA', 10);
    END IF;

EXCEPTION
 WHEN ex.controlled_error THEN
  RAISE;
 WHEN OTHERS THEN
  sbmensa := 'Proceso termino con Errores. '||SQLERRM;
  ldc_proactualizaestaprog(nutsess,sbmensa,'ldcprocdeletmarcausercertifi','Ok');
  errors.seterror;
  RAISE ex.controlled_error;
END LDCPROCDELETMARCAUSERCERTIFI;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre procedimiento LDCPROCDELETMARCAUSERCERTIFI
BEGIN
    pkg_utilidades.prAplicarPermisos('LDCPROCDELETMARCAUSERCERTIFI', 'ADM_PERSON'); 
END;
/