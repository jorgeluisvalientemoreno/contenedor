CREATE OR REPLACE procedure ADM_PERSON.LDC_PRVPMUPDATEFECHA is
  /*******************************************************************************
  Propiedad intelectual Horbath.

  Autor         :DVALIENTE (horbath)
  Fecha         :07-12-2020
  DESCRIPCION   :Permite actualizar la última verificación y Fecha de la Próxima verificación de la nueva entidad LDC_VPM con relación al producto de la orden legalizada.
  CASO          :132

  Fecha                IDEntrega           Modificacion
  ============    ================    ============================================
  24/04/2024       PACOSTA           OSF-2596: Se retita el llamado al esquema OPEN (open.)                                   
                                           Se crea el objeto en el esquema adm_person
  *******************************************************************************/
  
  nu_order  or_order.order_id%type;
  causal    or_order.causal_id%type;
  producto  ldc_vpm.product_id%type;
  serial    ldc_vpm.emsscoem%type;
  fecha     date;
  sbmensaje VARCHAR2(2000);
  eerror    EXCEPTION;
begin
  if fblaplicaentregaxcaso('0000132') then
    /*Logica: Al instanciar la orden legalizada se obtendrá la causal con la que se legalizo la orden. De la causal obtenida definirá la clasificación de la causal. Si la clasificación es de 1 - ÿ�XITO: Se obtendrá el producto de la orden (OR_ORDER_ACTIVITY.PRODUCT_ID), Se obtendrá la fecha final de ejecución (OR_ORDER.EXECUTION_FINAL_DATE), Se realizará el llamado del proceso LDC_PRVPMDATA se le pasaran los datos anteriormente mencionados.*/
    nu_order := or_bolegalizeorder.fnuGetCurrentOrder;
    --valido la causal de la orden
    causal := to_number(LDC_BOUTILITIES.fsbGetValorCampoTabla('or_order',
                                                              'order_id',
                                                              'causal_id',
                                                              nu_order));
    if dage_causal.fnugetclass_causal_id(causal, null) = 1 then
      --obtengo el id del producto
      select product_id
        into producto
        from or_order_activity oa
       where oa.order_id = nu_order;
      IF producto is null THEN
        sbmensaje := 'No existe un producto asociado a la Orden';
        RAISE eerror;
      END IF;
      --obtengo el serial del producto
      select e1.emsscoem
        into serial
        from elmesesu e1
       where e1.emsssesu = producto
         and e1.emssfere = (select max(e.emssfere)
                              from elmesesu e
                             where e.emsssesu = producto);
      --obtengo la fecha del producto
      select execution_final_date
        into fecha
        from or_order
       where order_id = nu_order;
      --llamo al servicio LDC_PRVPMDATA con los datos hallados
      LDC_PRVPMDATA(producto, serial, fecha);
    end if;
  end if;
EXCEPTION
  WHEN eerror THEN
    ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                     sbmensaje);
    ut_trace.trace('LDC_PRVPMUPDATEFECHA ' || sbmensaje || ' ' || SQLERRM,
                   11);
    raise ex.CONTROLLED_ERROR;
  when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
  WHEN OTHERS THEN
    Errors.setError;
    raise ex.CONTROLLED_ERROR;
end LDC_PRVPMUPDATEFECHA;
/
PROMPT Otorgando permisos de ejecucion a LDC_PRVPMUPDATEFECHA
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PRVPMUPDATEFECHA', 'ADM_PERSON');
END;
/