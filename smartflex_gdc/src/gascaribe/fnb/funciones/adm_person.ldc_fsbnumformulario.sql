CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FSBNUMFORMULARIO" (inuProductId in pr_product.product_id%type)
return VARCHAR is
 /*****************************************
  Metodo      : LDC_FSBNUMFORMULARIO
  Descripcion : Obtiene el Número de formulario con el cual se registro la solicitud.

  Autor: Alvaro Zapata
  Fecha: Octubre 07/2013

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
  ******************************************/
  cursor cuFormulario(nuProducto pr_product.product_id%type) is

  SELECT DECODE(digital_prom_note_cons,NULL,manual_prom_note_cons,manual_prom_note_cons,NULL,digital_prom_note_cons)
  FROM ld_non_ba_fi_requ
  WHERE ld_non_ba_fi_requ.non_ba_fi_requ_id in (SELECT DISTINCT MO_MOTIVE.PACKAGE_ID
                                                FROM MO_MOTIVE, MO_PACKAGES, GE_SUBSCRIBER
                                                WHERE MO_MOTIVE.PRODUCT_ID =nuProducto
                                                AND MO_PACKAGES.package_id= MO_MOTIVE.package_id
                                                AND MO_PACKAGES.SUBSCRIBER_ID = GE_SUBSCRIBER.SUBSCRIBER_ID);

  sbRetorna varchar2(15):= NULL;

begin
  ut_trace.trace('Inicio LDC_FSBNUMFORMULARIO', 10);
  ut_trace.trace('inuProductId-->'||inuProductId, 10);

  Open cuFormulario(inuProductId);
  fetch cuFormulario
    into sbRetorna;
  close cuFormulario;

  ut_trace.trace('sbRetorna-->'||sbRetorna, 10);
  ut_trace.trace('Fin LDC_FSBNUMFORMULARIO', 10);

  return sbRetorna;

  EXCEPTION
      when others then
        RETURN -1;
end LDC_FSBNUMFORMULARIO;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FSBNUMFORMULARIO', 'ADM_PERSON');
END;
/
