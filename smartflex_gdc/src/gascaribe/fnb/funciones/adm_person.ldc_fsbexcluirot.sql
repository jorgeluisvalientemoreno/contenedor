CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FSBEXCLUIROT" (nuorder_id     in or_order.order_id%type,
                                            idafechainicio in date,
                                            idafechafin    in date)
/*****************************************
  Metodo: LDC_FSBEXCLUIROT
  Descripcion: Indica si se debe excluir la orden que se encuentra en la instancia, si cumple con:
               1.si se trata de entrega o devolucion de articulos no debe tener asociada OT de comision
               2.Para el resto de trabajos deberia tener OT de comision
               3.validar que la OT de Revision de Documentos esta 5-asignada, causal diferente a documentos en regla
               4.valida si la revision de documento se encuentra legalizada con una causal de exito y su fecha de legalizacion
               no se encuentra dentro de la fecha (inicio y final) que se esta liquidando
               5.valida si fue legaliza con una causal de fallo

  Parametros: nuorder_id: numero de orden de la instancia
              idafechainicio: fecha inicial de la liquidacion
              idafechafin: fecha final de la liquidacion

  Autor: Harold Altamiranda
  Fecha: 22-04-2015

  Fecha           IDEntrega           Modificacion
  ============    ================    ============================================
  14/06/2016      Jorge Valiente      CASO  200-486: Se toma el codigo fiuente del servicio LDC_BOORDENES.FSBEXCLUIROTXVALIDDOCPERIODO
                                                     y se crea el servicio LDC_FSBEXCLUIROT
  28-01-2018      STapias.REQ 2001634 Se agrega exclusion para tipo de trabajo
                                        [cobro de comision por publicidad] solo aplica EFG
   ******************************************/
 return varchar is
  cursor cuordeninstancia(nuorden or_order.order_id%type) is
    select task_type_id, operating_unit_id
      from or_order
     where order_id = nuorden;

  cursor cuordencomision(nusolicitud mo_packages.package_id%type,
                         nucobrocomi or_task_type.task_type_id%type,
                         nupagocomi  or_task_type.task_type_id%type) is
    select a.order_id
      from or_order_activity a, or_order b
     where a.order_id = b.order_id
       and a.package_id = nusolicitud
       and a.task_type_id in (nuCobroComi, nupagocomi);

  cursor cuordendocumentos(nusolicitud  mo_packages.package_id%type,
                           nuttrevision or_task_type.task_type_id%type) is
    select a.order_id, b.order_status_id, b.causal_id
      from or_order_activity a, or_order b
     where a.order_id = b.order_id
       and a.package_id = nusolicitud
       and a.task_type_id in (nuttrevision);

  cursor cucausalfallo(nuordenRev      or_order.order_id%type,
                       nuorderstatusid number,
                       nutipocausal    number) is
    SELECT count(1) valor
      FROM or_order o, GE_CAUSAL gc
     WHERE o.order_id = nuordenRev
       AND o.causal_id = gc.causal_id
       AND o.order_status_id = nuorderstatusid
       AND gc.causal_type_id = nutipocausal;

  cursor cufechalegcausalexito(nuordenRev      or_order.order_id%type,
                               nufechainicial  date,
                               nufechafinal    date,
                               nuorderstatusid number,
                               nutipocausal    number) is
    SELECT count(1) valor
      FROM or_order o, GE_CAUSAL gc
     WHERE o.order_id = nuordenRev
       AND o.causal_id = gc.causal_id
       AND o.order_status_id = nuorderstatusid
       AND nufechainicial <= o.legalization_date
       AND nufechafinal >= o.legalization_date
       AND gc.causal_type_id <> nutipocausal;

  nuttentregart           number;
  nuttdevart              number;
  nuttcobrocomipag        number;
  nuttpagocomi            number;
  nucausadocregla         number;
  sbsolvta                varchar2(400);
  sbExcluir               varchar2(1) := 'N';
  nutipotrabajo           or_order.task_type_id%type;
  nuttValidDoc            or_order.task_type_id%type;
  nusolicitud             mo_packages.package_id%type;
  nusolicitudvta          mo_packages.package_id%type;
  nuordencomi             or_order.order_id%type;
  nuordenrev              or_order.order_id%type;
  nuestado                or_order.order_status_id%type;
  nucausal                or_order.causal_id%type;
  nuttpagoartprov         number;
  nuttcobrocomiprov       number;
  nuttcobroprovartdev     number;
  nuttpagoprovcomicobrada number;
  nupuntovta              mo_packages.pos_oper_unit_id%type;
  nuunidadoper            or_order.operating_unit_id%type;
  --variables utilizadas para la validacion de la causal de fallo
  nucausalfallo             number := 0;
  nufechalegalizacion       number := 0;
  nutipocausalfallofnb      number;
  sbflagfechaliqcausalfallo varchar(1);
  nuestadoordencerrada      number;
  nucausalexito             number;
  ----------------------
  -- REQ.2001634 -->
  -- Variables
  ----------------------
  nuttcobrocomipubli number;
  csbEntrega2001634 CONSTANT VARCHAR2(100) := 'FNB_BRI_STN_2001634_3';
  ----------------------
  -- REQ.2001634 <--
  ----------------------

begin
  ut_trace.trace('Inicio LDC_FSBEXCLUIROT', 10);
  ut_trace.trace('idafechainicio-->' || idafechainicio, 10);
  ut_trace.trace('idafechafin-->' || idafechafin, 10);

  nuttentregart     := dald_parameter.fnugetnumeric_value('COD_ENTREGA_ART_FNB_TIPO_TRAB',
                                                          null);
  nuttdevart        := dald_parameter.fnugetnumeric_value('COD_ANULA_FNB_TIPO_TRAB',
                                                          null);
  nuttcobrocomipag  := dald_parameter.fnugetnumeric_value('COD_COBRO_CONTRA_COMI_PAG_FNB',
                                                          null); --10138
  nuttpagocomi      := dald_parameter.fnugetnumeric_value('COD_PAGO_COMI_CONT_TT_FNB',
                                                          null); --10136
  nucausadocregla   := dald_parameter.fnugetnumeric_value('REVIEW_CAUSAL',
                                                          null);
  nuttvaliddoc      := dald_parameter.fnugetnumeric_value('COD_REVISA_DOC_FNB_TIPO_TRAB',
                                                          null); --10130
  nuttpagoartprov   := dald_parameter.fnugetnumeric_value('COD_PAGO_ARTIC_PROVEED_TT_FNB',
                                                          null); --10144
  nuttcobrocomiprov := dald_parameter.fnugetnumeric_value('COD_COBRO_COMI_PROVEED_TT_FNB',
                                                          null); --10137
  ---------------------------
  -- STapias.REQ 2001634 -->
  ---------------------------

  nuttcobrocomipubli := dald_parameter.fnugetnumeric_value('COD_COBRO_COMI_PUBLICD_TT_FNB',

                                                           null); --10682

  ---------------------------
  -- STapias.REQ 2001634 <--
  ---------------------------
  nuttcobroprovartdev     := dald_parameter.fnugetnumeric_value('COD_COBRO_PROV_ARTI_DEV_TT_FNB',
                                                                null); --10140
  nuttpagoprovcomicobrada := dald_parameter.fnugetnumeric_value('COD_PAGO_PROV_COMI_COBRADA_FNB',
                                                                null); --10139

  nutipocausalfallofnb      := dald_parameter.fnugetnumeric_value('TIPO_CAUSAL_FALLO_FNB',
                                                                  null);
  sbflagfechaliqcausalfallo := dald_parameter.fsbgetvalue_chain('FLAG_REXCLUSION_FLEGACFALLOFNB',
                                                                null);
  nuestadoordencerrada      := dald_parameter.fnugetnumeric_value('NUM_ORDER_STATE',
                                                                  null); --8
  nucausalexito             := dald_parameter.fnugetnumeric_value('LDC_CAUSAL_EXITO',
                                                                  null); --1

  ut_trace.trace('orden instancia-->' || nuorder_id, 10);
  open cuordeninstancia(nuorder_id);
  fetch cuordeninstancia
    into nutipotrabajo, nuunidadoper;
  close cuordeninstancia;

  ut_trace.trace('nutipotrabajo-->' || nutipotrabajo, 10);
  --valida que haya encontrado tipo de trabajo
  if (nutipotrabajo is not null and nutipotrabajo > 0) then

    --obtiene la solicitud de la orden
    nusolicitud := pkg_bcordenes.fnuObtieneSolicitud(nuorder_id);

    ut_trace.trace('nusolicitud-->' || nusolicitud, 10);

    --si el tipo de trabajo corresponde a una anulacion la solicitud asociada a la orden es la de anulacion
    --por lo que debera obtener la solucitud de venta
    if (nutipotrabajo = nuttcobroprovartdev or
       nutipotrabajo = nuttcobrocomipag OR
       nutipotrabajo = nuttpagoprovcomicobrada) then
      sbsolvta := ldc_boutilities.fsbgetvalorcampotabla('MO_PACKAGES_ASSO',
                                                        'PACKAGE_ID',
                                                        'PACKAGE_ID_ASSO',
                                                        nusolicitud);
      ut_trace.trace('sbsolvta-->' || sbsolvta, 10);
      nusolicitudVta := UT_CONVERT.FNUCHARTONUMBER(sbSolVta);
    else
      nusolicitudvta := nusolicitud;
    end if;
    ut_trace.trace('nusolicitudvta-->' || nusolicitudvta, 10);

    --obtener la orden de revision de documentos
    open cuordendocumentos(nusolicitudvta, nuttvaliddoc);
    fetch cuordendocumentos
      into nuordenRev, nuEstado, nuCausal;
    close cuordendocumentos;
    ut_trace.trace('otdocumentos-nuordenRev-->' || nuordenRev, 10);
    ut_trace.trace('otdocumentos-nuEstado-->' || nuEstado, 10);
    ut_trace.trace('otdocumentos-nuCausal-->' || nuCausal, 10);

    --validar si la orden fue legaliza con causal de fallo
    if sbflagfechaliqcausalfallo = 'S' AND nuEstado <> 0 AND nuEstado <> 5 then

      open cucausalfallo(nuordenRev,
                         nuestadoordencerrada,
                         nutipocausalfallofnb);
      fetch cucausalfallo
        into nucausalfallo;
      close cucausalfallo;

      if nucausalfallo = 0 then

        open cufechalegcausalexito(nuordenRev,
                                   idafechainicio,
                                   idafechafin,
                                   nuestadoordencerrada,
                                   nutipocausalfallofnb);
        fetch cufechalegcausalexito
          into nufechalegalizacion;
        close cufechalegcausalexito;

        if nufechalegalizacion = 1 then
          nucausalfallo := 0;
        end if;
      end if;

    end if;

    --Valida Contratista PAP
    IF (nutipotrabajo = nuttcobrocomipag OR nutipotrabajo = nuttpagocomi) THEN
      --se agrega la condicion de causal de fallo
      if (nuestado = 0 OR nuestado = 5 OR
         (sbflagfechaliqcausalfallo = 'S' and nucausalfallo = 1) OR
         (sbflagfechaliqcausalfallo = 'S' and nucausalfallo = 0 and
         nufechalegalizacion = 0)) then
        sbexcluir := 'S';
      end if;
    ELSE
      --obtiene el punto de venta asociado a la solicitud
      nuPuntoVta := to_number(ldc_boutilities.fsbgetvalorcampotabla('MO_PACKAGES',
                                                                    'PACKAGE_ID',
                                                                    'POS_OPER_UNIT_ID',
                                                                    nusolicitudvta));
      --Valida Proveedor Punto Fijo
      if (nuunidadoper = nupuntovta) then
        --se agrega la condicion de causal de fallo
        if (nuestado = 0 OR nuestado = 5 OR
           (sbflagfechaliqcausalfallo = 'S' and nucausalfallo = 1) OR
           (sbflagfechaliqcausalfallo = 'S' and nucausalfallo = 0 and
           nufechalegalizacion = 0)) then
          ---------------------------
          -- STapias.REQ 2001634 -->
          -- Si aplica para EFG, excluimos tambien  cuando el tipo de trabajo
          -- sea cobro de comision por publicidad
          ---------------------------
          IF open.fblAplicaEntrega(csbEntrega2001634) THEN
            if nutipotrabajo in (nuttpagoartprov,
                                 nuttcobrocomiprov,
                                 nuttcobrocomipubli, -- REQ.2001634
                                 nuttcobroprovartdev,
                                 nuttpagoprovcomicobrada) then
              sbexcluir := 'S';
            end if;
          ELSE
            if nutipotrabajo in (nuttpagoartprov,
                                 nuttcobrocomiprov,
                                 nuttcobroprovartdev,
                                 nuttpagoprovcomicobrada) then
              sbexcluir := 'S';
            end if;
          END IF;
          ---------------------------
          -- STapias.REQ 2001634 <--
          ---------------------------
        end if;
      end if;
    END IF;
  end if;
  ut_trace.trace('sbExcluir-->' || sbExcluir, 10);
  ut_trace.trace('Fin LDC_FSBEXCLUIROT', 10);
  return sbExcluir;

EXCEPTION
  when others then

    RETURN null;

end LDC_FSBEXCLUIROT;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FSBEXCLUIROT', 'ADM_PERSON');
END;
/
