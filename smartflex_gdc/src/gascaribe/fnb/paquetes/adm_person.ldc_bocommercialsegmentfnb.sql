CREATE OR REPLACE package ADM_PERSON.LDC_BOCOMMERCIALSEGMENTFNB is
    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LD_BCCOMMERCIALSEGMENTFNB
    Descripcion    : Paquete con la logica de negocio para manejar el proceso
                     de segmentación comercial de Brilla.
    Autor          : KCienfuegos
    Fecha          : 22/09/2014

    Historia de Modificaciones
    Fecha         Autor               Modificacion
    -------------------------------------------------
    22-09-2014    KCienfuegos.RNP198  Creación
    ******************************************************************/

    blFlagRollOver   boolean := false;
    blFlagFuture     boolean := false;

    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : proCommercialSegment
    Descripcion    : Valida la segmentación comercial del contrato.

    Autor          : KCienfuegos.RNP198
    Fecha          : 23/09/2014

    Parametros                   Descripcion
    ============             ===================
    inuSuscription:              Id del contrato

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    23/09/2014       KCienfuegos.RNP198    Creación.
    16/07/2015       heiberb               Cambio 7805 Se adicionan variables para los nuevos segmentos
                                           cnuSegmentNuevaR,cnuSegmentFutuM,cnuSegmentFutuL,cnuSegmentNormD,cnuSegmentRollD
    ******************************************************************/
    procedure proCommercialSegment(inuSuscription in suscripc.susccodi%type);

end LDC_BOCOMMERCIALSEGMENTFNB;
/
CREATE OR REPLACE package body ADM_PERSON.LDC_BOCOMMERCIALSEGMENTFNB is
  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : LDC_BOCOMMERCIALSEGMENTFNB
  Descripcion    : Paquete con la logica de negocio para manejar el proceso
                   de segmentación comercial de Brilla.
  Autor          : KCienfuegos
  Fecha          : 22/09/2014

  Historia de Modificaciones
  Fecha         Autor               Modificacion
  -------------------------------------------------
  22-09-2014    KCienfuegos.RNP198  Creación.
  ******************************************************************/

    -- Private constant declarations
    cnucero             constant NUMBER := LD_BOCONSTANS.cnuCero;
    cnuSegmentNorm      constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('SEGMENT_NORMAL');
    cnuSegmentIndec     constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('SEGMENT_INDECISO');
    cnuSegmentNueva     constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('SEGMENT_NUEVO');
    cnuSegmentGas       constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('SEGMENT_GASODOMESTICO');
    cnuSegmentFutu      constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('SEGMENT_FUTURO');
    cnuSegmentRoll      constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('SEGMENT_ROLLOVER');
    cnuSegmentNoQuot    constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('SEGMENT_SINCUPO');

    --creacion del nuevo parametro para el nuevo regular
    cnuSegmentNuevaR    constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('SEGMENT_NUEVORE');
    --creacion del nuevo parametro para el FUTURO lejano y mediano
    cnuSegmentFutuM     constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('SEGMENT_FUTUROM');
    cnuSegmentFutuL     constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('SEGMENT_FUTUROL');
    cnuSegmentNormD     constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('SEGMENT_NORMALD');
    cnuSegmentRollD     constant ld_parameter.numeric_value%type := dald_parameter.fnuGetNumeric_Value('SEGMENT_ROLLOVERD');
    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : proCommercialSegment
    Descripcion    : Valida la segmentación comercial del contrato.

    Autor          : KCienfuegos.RNP198
    Fecha          : 23/09/2014

    Parametros                   Descripcion
    ============             ===================
    inuSuscription:              Id del contrato

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    23/09/2014       KCienfuegos.RNP198    Creación.
    ******************************************************************/
    procedure proCommercialSegment(inuSuscription in suscripc.susccodi%type) is
      --PRAGMA AUTONOMOUS_TRANSACTION;
      sbSegment                      ldc_condit_commerc_segm.acronym%type;
      rcSegmentSusc                  daldc_segment_susc.styLDC_SEGMENT_SUSC;
      nuSegmentId                    ldc_condit_commerc_segm.cond_commer_segm_id%type;

      cursor cu_ldc_condit_comm_segm is
        select *
          from ldc_condit_commerc_segm sc
         where sc.active = 'Y'
           order by sc.order_exe, sc.cond_commer_segm_id;

    begin

       ut_trace.trace('Inicia ldc_bocommercialsegmentfnb.proCommercialSegment',1);
       Dbms_Output.Put_Line('momento Inicia '||sysdate);
       ut_trace.trace('Contrato '||inuSuscription,1);

       ldc_bccommercialsegmentfnb.nuAssignedQuotaSusc := ldc_bccommercialsegmentfnb.fnuGetAssigQuota(inuSuscription);

        /*Se obtienen las condiciones de segmentación activas*/
       for i in cu_ldc_condit_comm_segm loop
        Dbms_Output.Put_Line('momento '||i.cond_commer_segm_id||' tiempo '||sysdate);
          /*Proceso de segmentación clientes Normales*/
          if i.cond_commer_segm_id = cnuSegmentNorm then
            sbSegment := ldc_bccommercialsegmentfnb.fsbNormalSusc(inuSuscription);

          /*Proceso de segmentación clientes Indecisos*/
          elsif i.cond_commer_segm_id = cnuSegmentIndec then
            sbSegment := ldc_bccommercialsegmentfnb.fsbIrresoluteSusc(inuSuscription, i.time);

          /*Proceso de segmentación clientes Nuevos*/
          elsif i.cond_commer_segm_id = cnuSegmentNueva then
            sbSegment := ldc_bccommercialsegmentfnb.fsbNewFNBSusc(inuSuscription, i.time);

          /*Proceso de segmentación clientes Gasodoméstico*/
          elsif i.cond_commer_segm_id = cnuSegmentGas then
            sbSegment := ldc_bccommercialsegmentfnb.fsbGasapplSusc(inuSuscription, i.parameter);

          /*Proceso de segmentación clientes Rollover*/
          elsif i.cond_commer_segm_id = cnuSegmentRoll then
            sbSegment := ldc_bccommercialsegmentfnb.fsbRolloverSusc(inuSuscription, to_number(i.parameter));

          /*Proceso de segmentación clientes Futuros*/
          elsif i.cond_commer_segm_id = cnuSegmentFutu then
            sbSegment := ldc_bccommercialsegmentfnb.fsbFuturSusc(inuSuscription,i.time);

          /*Proceso de segmentación clientes Sin Cupo*/
          elsif i.cond_commer_segm_id = cnuSegmentNoQuot then
            sbSegment := ldc_bccommercialsegmentfnb.fsbNoQuotaSusc(inuSuscription);

          -->>
          --Cambio 7805 16/07/2015 heiberb Se adicionan variables para los nuevos segmentos cnuSegmentNuevaR,cnuSegmentFutuM,cnuSegmentFutuL,cnuSegmentNormD,cnuSegmentRollD
          -->>

          /*Proceso de segmentación clientes Nuevos Regulares*/
          elsif i.cond_commer_segm_id = cnuSegmentNuevaR then
            sbSegment := ldc_bccommercialsegmentfnb.fsbNewFNBSuscRe(inuSuscription, i.time);

          /*Proceso de segmentación clientes Futuros Medianos*/
          elsif i.cond_commer_segm_id = cnuSegmentFutuM then
            sbSegment := ldc_bccommercialsegmentfnb.fsbFuturSuscM(inuSuscription,i.time);

          /*Proceso de segmentación clientes Futuros Lejanos*/
          elsif i.cond_commer_segm_id = cnuSegmentFutuL then
            sbSegment := ldc_bccommercialsegmentfnb.fsbFuturSuscL(inuSuscription,i.time);

          /*Proceso de segmentación clientes normales D*/
          elsif i.cond_commer_segm_id = cnuSegmentNormD then
            sbSegment := ldc_bccommercialsegmentfnb.fsbNormalSusc(inuSuscription);

          /*Proceso de segmentación clientes RollOver D*/
          elsif i.cond_commer_segm_id = cnuSegmentRollD then
            sbSegment := ldc_bccommercialsegmentfnb.fsbRolloverSusc(inuSuscription, to_number(i.parameter));
          end if;

          /*Si ya se determinó una segmentación, se sale del ciclo*/
          if sbSegment is not null then
            if to_number(sbSegment) <> i.cond_commer_segm_id then
              nuSegmentId := to_number(sbSegment);
            else
              nuSegmentId := i.cond_commer_segm_id;
            end if;

            exit;
          end if;

       end loop;

       /*Obtiene el registro de segmentación actual*/
       rcSegmentSusc := ldc_bccommercialsegmentfnb.frcGetSegmentSuscRec(inuSuscription);

       if rcSegmentSusc.subscription_id is null then
         /*Se crea el registro de segmentación para el contrato*/
         ut_trace.trace('Se crea el registro de segmentación para el contrato '||inuSuscription,1);
         rcSegmentSusc.segment_susc_id := PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL('SEQ_LDC_SEGMENT_SUSC');
         rcSegmentSusc.subscription_id := inuSuscription;
         rcSegmentSusc.segment_id      := nuSegmentId;
         rcSegmentSusc.register_date   := ut_date.fdtsysdate;
         daldc_segment_susc.insRecord(rcSegmentSusc);

       else
         ut_trace.trace('Se actualiza la segmentación para el contrato '||inuSuscription,1);
         /*Se actualiza la segmentación*/
         rcSegmentSusc.segment_id := nuSegmentId;
         rcSegmentSusc.register_date := ut_date.fdtsysdate;
         daldc_segment_susc.updRecord(rcSegmentSusc);

       end if;

       Ldc_bccommercialsegmentfnb.nuAssignedQuotaSusc := cnucero;
       blFlagRollOver := false;
       blFlagFuture := false;
       Dbms_Output.Put_Line('el valor del segmento es '||nuSegmentId);
       Dbms_Output.Put_Line('momento '||sysdate);
       ut_trace.trace('Fin ldc_bocommercialsegmentfnb.proCommercialSegment',1);

    exception
      when ex.CONTROLLED_ERROR then
          raise ex.CONTROLLED_ERROR;
      when others then
          Errors.setError;
          raise ex.CONTROLLED_ERROR;
    end;

end LDC_BOCOMMERCIALSEGMENTFNB;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_BOCOMMERCIALSEGMENTFNB', 'ADM_PERSON');
END;
/
