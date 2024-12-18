CREATE OR REPLACE PROCEDURE      ADM_PERSON.LDCPROVALDTADCERTOIA IS
/***********************************************************************************************************
Propiedad Intelectual de Gases del Caribe S.A E.S.P

 Funcion     : LDCPROVALDTADCERTOIA
 Descripcion : Procedimiento que valida el certificado para poder legalizar la visita o certificaci?n
 Autor       : LUIS SALAZAR
 Fecha       : 18-07-2018

 Historia de Modificaciones
   Fecha               Autor                Modificacion
 =========           =========          ====================
 24/04/2024           PACOSTA            OSF-2596: Se crea el objeto en el esquema adm_person
 04/09/2018           dsaltarin          Se modifica para usar nuevo parametro que incluya titr 10444 y 10795,
                                         ya que no estaba teniendo en cuenta el 10795, y se elimina que buscque
										 solo en el producto 200-2153
 17/07/2018           Horbath            Se realiza modificacion para el caso 200-2052                                         
************************************************************************************************************/
--Cursor que obtiene el producto, el contrato del producto y el tipo de trabajo de acuerdo a la orden instanciada
 CURSOR cuProducto(nucuorden NUMBER) is
  SELECT product_id
    FROM open.or_order_activity
   WHERE order_id = nucuorden
     AND rownum   = 1;
eexeptionerror  EXCEPTION;
nuorden         open.or_order.order_id%TYPE;
nuunitoper      open.or_order.operating_unit_id%TYPE;
sbmensa         VARCHAR2(1000);
sbcertificado   open.ldc_certificados_oia.certificado%TYPE;
nucodatributo   open.ge_attributes.attribute_id%TYPE;
sbnombreatrib   open.ge_attributes.name_attribute%TYPE;
nusw            NUMBER(1);
nuproductocert  open.pr_product.product_id%TYPE;
nuorganismoinsp open.or_operating_unit.operating_unit_id%TYPE;
nuproductid     open.pr_product.product_id%TYPE;
nuconta         NUMBER(4);
nugrupoatrib    open.ld_parameter.numeric_value%TYPE;
nuresultadoins  open.ldc_certificados_oia.resultado_inspeccion%TYPE;
nuresultadoinc  open.ldc_certificados_oia.resultado_inspeccion%TYPE;
nucausalorden   open.or_order.causal_id%TYPE;
BEGIN
 --Obtener el identificador de la orden  que se encuentra en la instancia
 nuorden := or_bolegalizeorder.fnuGetCurrentOrder;
 -- Obtenemos la causal
 nucausalorden := or_boorder.fnugetordercausal(nuorden);
 -- Obtenemos la unidad operativa
 BEGIN
  SELECT ot.operating_unit_id INTO nuunitoper
    FROM open.or_order ot
   WHERE ot.order_id = nuorden
     AND ot.operating_unit_id IS NOT NULL;
 EXCEPTION
   WHEN no_data_found THEN
    sbmensa := 'Proceso termino con errores, la orden de trabajo :'||to_char(nuorden)||' no existe o no tiene unidad operativa asignada.';
    ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
    RAISE ex.controlled_error;
 END;
 -- Obtenemos el producto asociado a la orden de trabajo
    OPEN cuproducto(nuorden);
   FETCH cuProducto INTO nuproductid;
      IF cuProducto%NOTFOUND THEN
         sbmensa := 'Proceso termino con errores : '||'El cursor cuProducto no arrojo datos con el # de orden'||to_char(nuorden);
         ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
         RAISE ex.controlled_error;
      END IF;
   CLOSE cuproducto;
 -- Obtenemos el valor del certificado del dato adicional
 nucodatributo := open.dald_parameter.fnuGetNumeric_Value('COD_DATO_ADICIONAL_VAL_CERTI',NULL);
 IF nucodatributo IS NULL THEN
   sbmensa := 'Proceso termino con errores, se debe configurar valor al parametro COD_DATO_ADICIONAL_VAL_CERTI, codigo dato adicional del certificado.';
   ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
   RAISE ex.controlled_error;
 END IF;
 sbnombreatrib := open.dald_parameter.fsbGetValue_Chain('NOMBRE_ATRI_VAL_CERTI');
 IF sbnombreatrib IS NULL THEN
   sbmensa := 'Proceso termino con errores, se debe configurar valor al parametro NOMBRE_ATRI_VAL_CERTI, nombre dato adicional del certificado.';
   ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
   RAISE ex.controlled_error;
 END IF;
 nugrupoatrib := open.dald_parameter.fnuGetNumeric_Value('COD_GRUPO_DATO_ADIC_VAL_CERTI',NULL);
 IF nugrupoatrib IS NULL THEN
   sbmensa := 'Proceso termino con errores, se debe configurar valor al parametro COD_GRUPO_DATO_ADIC_VAL_CERTI, grupo del dato adicional del certificado.';
   ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
   RAISE ex.controlled_error;
 END IF;
 sbcertificado := open.ldc_boordenes.fsbDatoAdicTmpOrden(nuorden,nucodatributo,TRIM(sbnombreatrib));
 -- Consultamos existencia del certificado
 nuproductocert  := NULL;
 nuorganismoinsp := NULL;
 nuresultadoins  := NULL;
 nusw            := 1;
 BEGIN
  SELECT id_producto,id_organismo_oia,resultado_inspeccion INTO nuproductocert,nuorganismoinsp,nuresultadoins
    FROM(
         SELECT c.id_producto,c.id_organismo_oia,c.resultado_inspeccion
          -- se agrega la tabla de configuracion de oia de certificacion
           FROM open.ldc_certificados_oia c , open.LDCCTROIACCTRL l
          WHERE TRIM(c.certificado) = TRIM(sbcertificado)
            --se agrega la validacion de oia de certificacion
            AND c.id_producto       = nuproductid
            AND c.id_organismo_oia  = l.CONTRATISTAOIA
            AND l.CONTRALEGCERT  = nuunitoper
          ORDER BY c.fecha_registro DESC
        )
   WHERE ROWNUM = 1;
 EXCEPTION
  WHEN no_data_found THEN
   nusw            := 0;
   nuproductocert  := NULL;
   nuorganismoinsp := NULL;
   nuresultadoins  := NULL;
 END;
 IF nusw = 0 THEN
  sbmensa := 'Proceso termino con errores, el codigo del certificado : '||TRIM(sbcertificado)||' no tiene asociacion con el producto : '||to_char(nuproductid)||' y no tiene asociacion con el organismo de inspeccion : '||to_char(nuunitoper)||' favor validar los datos.';
  ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
  RAISE ex.controlled_error;
 END IF;
 -- Validamos si la respuesta de inspeccion del certificado es null, debe mostrar un mensaje
 IF nuresultadoins IS NULL THEN
  sbmensa := 'Proceso termino con errores, la respuesta de inspeccion del certificado : '||TRIM(sbcertificado)||' esta vacia.';
  ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
  RAISE ex.controlled_error;
 ELSE
   -- Consultamos la respuesta de inspeccion asociada a la causal
  BEGIN
   SELECT fb.resultado_inspecccion INTO nuresultadoinc
     FROM open.ldc_conf_causal_tipres_cert fb
    WHERE fb.causal_ord            = nucausalorden
      AND fb.resultado_inspecccion = nvl(nuresultadoins,-1);
  EXCEPTION
   WHEN no_data_found THEN
    sbmensa := 'Proceso termino con errores, el tipo de respuesta de inspeccion :'||to_char(nuresultadoins)||' del certificado : '||TRIM(sbcertificado)||' no esta asociado a la causal de legalizacion : '||to_char(nucausalorden)||'. Consulte la forma : LDCCALEREIN.';
    ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
    RAISE ex.controlled_error;
  END;
 END IF;
 -- Validamos que el producto del certificado sea el mismo de la orden de trabajo
 -- anulamos validacion de oia de legalizacion
 IF nuproductocert <> nuproductid THEN
  sbmensa := 'Proceso termino con errores, el producto del certificado : '||to_char(nuproductocert)||' no es el mismo producto de la ord?n de trabajo :'||to_char(nuproductid);
  ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
  RAISE ex.controlled_error;
 END IF;
 -- Validamos que la unidad operativa del certificado sea la misma de la ord?n
/* IF nuorganismoinsp <> nuunitoper THEN
  sbmensa := 'Proceso termino con errores, la unidad operativa del certificado : '||to_char(nuorganismoinsp)||' no es la misma unidad operativ
  a de la ord?n de trabajo :'||to_char(nuunitoper);
  ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
  RAISE ex.controlled_error;
 END IF;*/
 -- Validamos que el certificado no este asociado a otra orden de trabajo con el mismo organismo de inspeccion y el mismo producto
 SELECT COUNT(1) INTO nuconta
   FROM open.or_requ_data_value k,open.or_order o,open.or_order_activity d, open.LDCCTROIACCTRL l
  WHERE k.order_id          <> nuorden
    AND k.attribute_set_id  =  nugrupoatrib
    AND k.task_type_id      IN (select nvl(to_number(column_value),
                                                     0)
                                            from table (open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('TITR_VALIDA_CERTIF_RP_LEGA',
                                                                                                                     NULL),',')))
    AND TRIM(k.value_1)     = TRIM(sbcertificado)
    AND o.operating_unit_id = CONTRALEGCERT
    and l.CONTRATISTAOIA = nuorganismoinsp
    --AND d.product_id        = nuproductid
    AND k.order_id          = o.order_id
    AND o.order_id          = d.order_id;
 IF nuconta >= 1 THEN
   sbmensa := 'Proceso termino con errores, el certificado : '||TRIM(sbcertificado)||' lo tiene asociado otra orden de trabajo con el producto : '||to_char(nuproductid)||' y el organismo de inspecci??n : '||to_char(nuunitoper);
   ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
   RAISE ex.controlled_error;
 END IF;
EXCEPTION
 WHEN ex.controlled_error THEN
  RAISE;
 WHEN OTHERS THEN
  sbmensa := 'Proceso termino con Errores. '||SQLERRM;
  ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
  errors.seterror;
  RAISE ex.controlled_error;
END;
/
PROMPT Otorgando permisos de ejecucion a LDCPROVALDTADCERTOIA
BEGIN
    pkg_utilidades.praplicarpermisos('LDCPROVALDTADCERTOIA', 'ADM_PERSON');
END;
/
