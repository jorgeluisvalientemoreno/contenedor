CREATE OR REPLACE PROCEDURE ADM_PERSON.ldc_suspporrpusuvenc IS
  /********************************************************************************************************
   Autor       : John Jairo Jimenez Marimon
   Fecha       : 2021-12-18
   caso        : CA-873
   Descripcion : CA-873 - Procedimientos que valida si el usuario fue suspendido por revision periodica
  
   HISTORIA DE MODIFICACIONES
   FECHA        AUTOR         DESCRIPCION
   24/11/2023   jsoto         Ajustes ((OSF-1862)):
          -Ajustes cambio en llamado a algunos de los objetos de producto por personalizados
          -Ajuste  cambio en manejo de trazas y errores por personalizados (pkg_error y pkg_traza).
          -Ajuste llamado a pkg_xml_sol_rev_periodica para armar los xml de las solicitudes
          -Ajuste llamado a api_registerRequestByXml
  
   15/04/2024   Jorg Valiente OSF-2577: Se realiza inicializacion de variabel nmvaprod 
                                        con el servicio pkg_bcordenes.fnuObtieneProducto
   19-04-2024	Adrianavg	  OSF-2569: Se migra del esquema OPEN al esquema ADM_PERSON  
  ***********************************************************************************************************/
  nuorden          or_order.order_id%TYPE;
  nmvaprod         pr_product.product_id%TYPE;
  nmvaconta        NUMBER(6);
  nuCausalOrder    or_order.causal_id%TYPE;
  sbvamenerr       VARCHAR2(10000);
  sbrequestxml1    constants_per.tipo_xml_sol%TYPE;
  numediorecepcion mo_packages.reception_type_id%TYPE;
  nucliente        ge_subscriber.subscriber_id%TYPE;
  nudireccion      ab_address.address_id%TYPE;
  sbComment        VARCHAR2(2000);
  dtfechasusp      DATE := SYSDATE + 1 / 1440;
  nutiposusp       ge_suspension_type.suspension_type_id%TYPE;
  nutipoCausal     NUMBER;
  nuCausal         NUMBER;
  nupackageid      mo_packages.package_id%TYPE;
  numotiveid       mo_motive.motive_id%TYPE;
  nmtipotrab       or_order.task_type_id%TYPE;
  nmunitoper       or_order.operating_unit_id%TYPE;
  nuerrorcode      NUMBER;
  sberrormessage   VARCHAR2(5000);
  csbMetodo        CONSTANT VARCHAR2(100) := 'LDC_SUSPPORRPUSUVENC';
  sbActividadesSus CONSTANT VARCHAR2(100) := pkg_bcldc_pararepe.fsbObtieneValorCadena('ACTIVSUSPRPUSUVENC');

  --Cursor que obtiene el producto, el contrato del producto y el tipo de trabajo de acuerdo a la orden instanciada
  CURSOR cuproducto(nucuorden NUMBER) IS
    SELECT product_id,
           a.subscriber_id,
           o.external_address_id,
           o.task_type_id,
           o.operating_unit_id
      FROM or_order_activity a, or_order o
     WHERE a.order_id = nucuorden
       AND a.order_id = o.order_id
       AND ROWNUM = 1;

  --
  CURSOR cuprodsuspen(nmcuprod pr_product.product_id%TYPE)
  
  IS
    SELECT COUNT(1)
      FROM pr_prod_suspension l, pr_product p, or_order_activity a
     WHERE l.product_id = nmcuprod
       AND l.active = 'Y'
       AND l.suspension_type_id IN (101, 102, 103, 104)
       AND p.product_status_id = 2
       AND a.activity_id IN
           (SELECT to_number(regexp_substr(sbActividadesSus,
                                           '[^,]+',
                                           1,
                                           LEVEL)) AS actividad
              FROM dual
            CONNECT BY regexp_substr(sbActividadesSus, '[^,]+', 1, LEVEL) IS NOT NULL)
       AND p.suspen_ord_act_id = a.order_activity_id
       AND l.product_id = p.product_id;

BEGIN

  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

  --Obtener el identificador de la orden  que se encuentra en la instancia
  nuorden := pkg_bcordenes.fnuobtenerotinstancialegal;
  -- Obtenemos la causal
  nuCausalOrder := pkg_bcordenes.fnuobtienecausal(nuorden);
  nmvaprod      := pkg_bcordenes.fnuObtieneProducto(nuorden);
  -- Obtenemos el medio de recepcion
  numediorecepcion := pkg_bcldc_pararepe.fnuObtieneValorNumerico('SAXMLRECEPTIONTYPE');

  -- Validamos que este configurado el medio de recepcion
  IF numediorecepcion IS NULL THEN
    sbvamenerr := 'No hay configuración del medio de recepción en el parámetro : SAXMLRECEPTIONTYPE. Favor validar en la forma LDPAR';
    pkg_error.setErrorMessage(pkg_error.cnugeneric_message, sbvamenerr);
  END IF;

  -- Obtenemos la marca del producto
  nutiposusp := ldc_fncretornamarcaprod(nmvaprod);
  nutiposusp := NVL(nutiposusp, 101);
  -- Obtenemos el tipo de causal
  nutipoCausal := pkg_bcldc_pararepe.fnuObtieneValorNumerico('SAXMLTIPOCAUSAL');

  -- Validamos que este configurado el tipo de causal
  IF nutipoCausal IS NULL THEN
    sbvamenerr := 'No hay configuración del tipo de causal en el parámetro : SAXMLTIPOCAUSAL. Favor validar en la forma LDPAR';
    pkg_error.setErrorMessage(pkg_error.cnugeneric_message, sbvamenerr);
  END IF;

  -- Obtenemos la causal
  nuCausal := pkg_bcldc_pararepe.fnuObtieneValorNumerico('SAXMLCAUSAL');

  -- Validamos que este configurado la causal
  IF nuCausal IS NULL THEN
    sbvamenerr := 'No hay configuración de la causal en el parámetro : SAXMLCAUSAL. Favor validar en la forma LDPAR';
    pkg_error.setErrorMessage(pkg_error.cnugeneric_message, sbvamenerr);
  END IF;

  -- Seteamos los valores
  FOR i IN cuproducto(nuorden) LOOP
    nmvaprod    := i.product_id;
    nucliente   := i.subscriber_id;
    nudireccion := i.external_address_id;
    sbComment   := 'Orden legalizada :' || nuorden || ' con causal : ' ||
                   nuCausalOrder;
    nmtipotrab  := i.task_type_id;
    nmunitoper  := i.operating_unit_id;
  END LOOP;

  -- Validamos si existe producto en la orden que se esta legalizando
  IF nmvaprod IS NOT NULL THEN
    OPEN cuprodsuspen(nmvaprod);
  
    FETCH cuprodsuspen
      INTO nmvaconta;
  
    CLOSE cuprodsuspen;
  
    -- Validamos i cumple con la condicion para generar la solicitud
    IF nmvaconta = 0 THEN
      sbvamenerr := 'No se puede legalizar con la causal debido a que el producto no tiene la última actividad de suspensión correcta.';
      pkg_error.setErrorMessage(pkg_error.cnugeneric_message, sbvamenerr);
    ELSE
      -- Cambiamos estado de producto a activo
      ldc_cambio_estado_prod(nmvaprod);
      -- Generamos tramite de suspension administrativa por XML
      sbrequestxml1 := pkg_xml_soli_rev_periodica.getSuspensionAdministrativa(numediorecepcion,
                                                                              nucliente,
                                                                              nudireccion,
                                                                              sbComment,
                                                                              nmvaprod,
                                                                              dtfechasusp,
                                                                              nutiposusp,
                                                                              nutipoCausal,
                                                                              nuCausal);
      -- Se crea la solicitud y la orden de trabajo
      api_registerRequestByXml(sbrequestxml1,
                               nupackageid,
                               numotiveid,
                               nuerrorcode,
                               sberrormessage);
      -- Validamos si se creo la solicitud correctamente
      IF nupackageid IS NULL THEN
        sbvamenerr := 'Proceso termino con errores : ' ||
                      'Error al generar la solicitud de suspension administrativa prp. Codigo error : ' ||
                      TO_CHAR(nuerrorcode) || ' Mensaje de error : ' ||
                      sberrormessage;
        pkg_error.setErrorMessage(pkg_error.cnugeneric_message, sbvamenerr);
      ELSE
        -- Insertamos registro
        pkg_ldc_ordentramiterp.prcInsertaRegistro(nuorden,
                                                  nmtipotrab,
                                                  nuCausalOrder,
                                                  nupackageid,
                                                  nmunitoper);
      
        -- Guardamos comentario de la orden de trabajo
        api_addordercomment(nuorden,
                            -1,
                            sbComment,
                            nuerrorcode,
                            sberrormessage);
      END IF;
    END IF;
  ELSE
    sbvamenerr := 'La orden : ' || nuorden ||
                  ' no tiene producto asociado.';
    pkg_error.setErrorMessage(pkg_error.cnugeneric_message, sbvamenerr);
  END IF;

  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
  WHEN pkg_error.controlled_error THEN
    pkg_error.getError(nuerrorcode, sberrormessage);
    pkg_traza.trace(csbMetodo || ' ' || sberrormessage);
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERC);
    RAISE;
  WHEN OTHERS THEN
    pkg_error.setError;
    pkg_error.getError(nuerrorcode, sberrormessage);
    sbvamenerr := 'Error en : ldc_suspporrpusuvenc al legalizar la orden : ' ||
                  nuorden || ' ' || nuerrorcode || ' - ' || sberrormessage;
    pkg_traza.trace(csbMetodo || ' ' || sbvamenerr);
    pkg_traza.trace(csbMetodo,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERR);
    RAISE pkg_error.controlled_error;
END ldc_suspporrpusuvenc;
/
GRANT EXECUTE ON LDC_SUSPPORRPUSUVENC TO SYSTEM_OBJ_PRIVS_ROLE;
/
PROMPT OTORGA PERMISOS ESQUEMA SOBRE PROCEDIMIENTO LDC_SUSPPORRPUSUVENC
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_SUSPPORRPUSUVENC', 'ADM_PERSON'); 
END;
/
