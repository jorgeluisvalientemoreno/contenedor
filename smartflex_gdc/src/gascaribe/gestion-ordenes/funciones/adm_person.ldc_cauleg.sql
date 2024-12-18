CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_CAULEG" (inupackage in number,
                                      isbvalob   varchar2) return varchar2 is

  /*------------------------------------------------------------------------------
    Propiedad intelectual de PETI (c).
    Unidad         : ldc_CauLeg
    Descripcion    : Funcion para obtener Causal de Legalizaci?n (de aquella orden principal que da por atendida la solicitud),
                     y Comentario de Orden (comentario ingresado al legalizar la orden que da por atendida la solicitud).
                     caso 200-1021
    Autor          : samuel pacheco
    Fecha          : 22-ene-2017
    Metodos              Descripcion
    ============         ===================

    Fecha             Autor             Modificacion
    ===========      =========         ====================
  ------------------------------------------------------------------------------*/

  cursor cusolicitud is

    SELECT (select order_comment
              from open.or_order_comment
             where order_id = OT
               and legalize_comment = 'Y'
               AND rownum = 1) COMENTARIO_LEG,
           decode(OT,
                  null,
                  null,
                  dage_causal.fsbgetdescription(daor_order.fnugetcausal_id(OT))) CAUSAL_LEG
      FROM (SELECT d.order_id OT
              FROM or_order_activity d, or_order o, mo_packages m
             WHERE d.instance_id IS NOT NULL
               AND d.package_id = inupackage
               and d.order_id = o.order_id
               and d.package_id = m.package_id
               and m.motive_status_id =
                   open.Dald_parameter.fnuGetNumeric_Value('FNB_ESTADOSOL_ANULACION')
               and o.order_status_id =
                   open.Dald_parameter.fnuGetNumeric_Value('COD_ORDER_STATUS')
               AND rownum = 1
             order by LEGALIZATION_DATE desc);

  rfcusolicitud cusolicitud%rowtype;

  sbcomen  varchar2(4000) := 'NO EXISTE';
  sbcausle varchar2(4000) := 'NO EXISTE';

begin

  open cusolicitud;
  fetch cusolicitud
    into rfcusolicitud;
  if cusolicitud%found then
    if isbvalob = 'L' then
      sbcausle := NVL(rfcusolicitud.causal_leg, 'NO EXISTE');
      return sbcausle;
    elsif isbvalob = 'C' then
      sbcomen := NVL(rfcusolicitud.comentario_leg, 'NO EXISTE');
      return sbcomen;
    end if;
  end if;
  close cusolicitud;

  return sbcomen;

exception
  when others then
    return null;
end ldc_CauLeg;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_CAULEG', 'ADM_PERSON');
END;
/