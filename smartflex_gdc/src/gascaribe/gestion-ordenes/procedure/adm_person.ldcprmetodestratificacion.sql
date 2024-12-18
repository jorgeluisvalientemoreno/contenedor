CREATE OR REPLACE PROCEDURE adm_person.LDCPRMETODESTRATIFICACION
IS
/***********************************************************************************************************
Propiedad Intelectual de Gases del Caribe S.A E.S.P

 Objeto      : LDCPRMETODESTRATIFICACION
 Descripcion : Procedimiento
 Autor       : OLSoftware - JHinestroza
 Fecha       : 08-02-2021

 Historia de Modificaciones
   Fecha               Autor                            Modificacion
 =========           =========                          ====================
 24/04/2024          PACOSTA                            OSF-2596: Se crea el objeto en el esquema adm_person 
 22-10-2021          John Jairo Jimenez Marimon(JJJM)   Se obtiene la nueva direccion del campo
                     Horbat Tecnologies.                ADDRES_ID de la tabla : OR_EXTERN_SYSTEMS_ID.
                                                        Se cambia el api de creacion de ordenes, se
                                                        reemplaza : os_createorderactivities
                                                              por : or_boorderactivities.createactivity
 08-02-2021          OLSoftware                         Creacion                                                              
************************************************************************************************************/
  --<<
  -- Variables
  -->>
  -- Control
  cnuSECOND          CONSTANT NUMBER := 1/24/60/60;
  cnuClaseExito      CONSTANT ge_class_causal.class_causal_id%TYPE := 1;
  erPrograma         EXCEPTION;
  sbmensa            VARCHAR2(10000);
  -- Operacion
  nuOrderId           or_order.order_id%TYPE;
  nuTaskTypeId        OR_ORDER.TASK_TYPE_ID%TYPE;
  nuCausalId          ge_causal.causal_id%type;
  nuCausalClassId     ge_class_causal.class_causal_id%TYPE;
  nuPackageID         mo_packages.package_id%TYPE;
  nuAdressId_New      ab_address.address_id%TYPE;
  nuLocality_New      ge_geogra_location.geograp_location_id%TYPE;
  sbModo              LDC_TIPO_METOD_ESTRAT.Modo%TYPE;
  nuSegmentId_New     ab_address.SEGMENT_ID%TYPE;
  nuSegmentId_Current ab_address.SEGMENT_ID%TYPE;

  -- Datos Nueva Orden
  nuItem_Id    or_order_items.order_items_id%type;
  nuOrderNew   or_order.order_id%type;
  nuUnidadOper or_operating_unit.operating_unit_id%type;
  gnuErrorCode number;
  gsbMessage   varchar2(1000);
  nmsusccodi      suscripc.susccodi%TYPE;
  nmproduct_id    pr_product.product_id%TYPE;
  nmsusbcriber_id ge_subscriber.subscriber_id%TYPE;
  nuactivityNew   or_order_activity.order_activity_id%TYPE;

  -- CURSORES
 CURSOR cumetodologia(nulocalidad ge_geogra_location.geograp_location_id%TYPE) IS
  SELECT a.modo
    FROM ldc_tipo_metod_estrat a,ldc_tipo_metod_estrat_loc b
   WHERE a.codigo    = b.codigo_metodologia
     AND b.localidad = nulocalidad;

  CURSOR cudireccactu(nmpackage_id mo_packages.package_id%TYPE) IS
   SELECT f.dir_instalacion_old,f.segmento_old
     FROM ldc_solici_cam_dat_pred f
    WHERE f.package_id = nmpackage_id;

BEGIN
 IF (fblAplicaEntregaxCaso('0000616')) THEN
  --Obtener el identificador de la orden  que se encuentra en la instancia
  nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;
  --Obtener tipo de Trabajo
  nuTaskTypeId := DAOR_ORDER.FNUGETTASK_TYPE_ID(nuOrderId);
  --Obtener causal de legalizacion
  nuCausalId := to_number(ldc_boutilities.fsbgetvalorcampotabla ('OR_ORDER','ORDER_ID','CAUSAL_ID',nuorderid));
  --Obtener tipo de causal
  nuCausalClassId := dage_causal.fnugetclass_causal_id(nuCausalId);
  --Obtener la solicitud
  nuPackageID := or_bcorderactivities.fnugetpackidinfirstact(nuorderid);
  -- Obtenemos la nueva direccion
  -- Inicio JJJM
   nuAdressId_New :=to_number(ldc_boutilities.fsbgetvalorcampotabla ('OR_EXTERN_SYSTEMS_ID','ORDER_ID','ADDRESS_ID ',nuorderid));
  -- Fin JJJM
  IF(nuAdressId_New IS NOT NULL) THEN
   -- valida si el tipo de trabajo esta dentro del parametro
   IF instr(dald_parameter.fnugetnumeric_value('LDC_TT_CAMBIO_DIRECCION'),nuTaskTypeId) > 0 THEN
    --VALIDAR SI LA CAUSAL DE LEGALIZACION ES EXITOSA
    IF nuCausalClassId = cnuClaseExito THEN
     nulocality_new := to_number(ldc_boutilities.fsbgetvalorcampotabla('ab_address', 'address_id', 'geograp_location_id', nuAdressId_New));
       OPEN cumetodologia(nuLocality_New);
      FETCH cumetodologia INTO sbModo;
         IF cumetodologia%NOTFOUND THEN
            sbmensa := 'No existe configuracion de Tipo de metodologia de estratificacion por Localidad para la localidad ['||nuLocality_New||']';
            RAISE erPrograma;
         END IF;
       CLOSE cumetodologia;
     -- Obtenemos Cliente,Contrato y Producto
     -- Inicio JJJM
     BEGIN
      SELECT subscription_id,product_id,suscclie INTO nmsusccodi,nmproduct_id,nmsusbcriber_id
        FROM(
             SELECT m.subscription_id,m.product_id,s.suscclie
               FROM mo_motive m,suscripc s
              WHERE m.package_id = nuPackageID
                AND m.subscription_id IS NOT NULL
                AND m.subscription_id = s.susccodi
              ORDER BY m.motiv_recording_date DESC
            )
       WHERE rownum = 1;
     EXCEPTION
      WHEN no_data_found THEN
       nmsusccodi      := NULL;
       nmproduct_id    := NULL;
       nmsusbcriber_id := NULL;
     END;
     -- Fin JJJM
     IF sbModo = 'I' THEN
       /*********************************************************
       *   Crea Orden
       *********************************************************/
      nuItem_Id := dald_parameter.fnuGetNumeric_Value('LDC_COD_TT_VAL_ESTRAT');
      -- Crea Orden
      -- Inicio JJJM
      nuOrderNew    := NULL;
      nuactivityNew := NULL;
      or_boorderactivities.createactivity(
                                          nuItem_Id
                                         ,NULL
                                         ,NULL
                                         ,NULL
                                         ,NULL
                                         ,nuAdressId_New
                                         ,NULL
                                         ,nmsusbcriber_id
                                         ,nmsusccodi
                                         ,nmproduct_id
                                         ,NULL
                                         ,NULL
                                         ,SYSDATE + cnuSECOND
                                         ,NULL
                                         ,'ORDEN GENERADA DESDE : LDCPRMETODESTRATIFICACION'
                                         ,NULL
                                         ,NULL
                                         ,nuOrderNew
                                         ,nuactivityNew
                                         ,NULL
                                         ,NULL
                                         ,NULL
                                         ,NULL
                                         ,NULL
                                         ,NULL
                                         ,NULL
                                         ,NULL
                                         ,NULL
                                         ,NULL
                                         );
      -- Valida si hubo error
      IF (nuOrderNew IS NULL OR nuactivityNew IS NULL) THEN
          sbmensa := 'Error Creando la nueva Orden. --> '||gsbMessage;
          RAISE erPrograma;
      END IF;
      -- Fin JJJM
      gnuErrorCode := NULL;
      gsbMessage   := NULL;
      /*********************************************************
       *   Asigna Orden
       *********************************************************/
      nuUnidadOper := dald_parameter.fnuGetNumeric_Value('LDC_COD_UT');
      -- Asignar orden
      os_assign_order(
                       inuorderid         => nuOrderNew,
                       inuoperatingunitid => nuUnidadOper,
                       idtarrangedhour    => SYSDATE + 1,
                       idtchangedate      => SYSDATE,
                       onuerrorcode       => gnuErrorCode,
                       osberrormessage    => gsbMessage
                      );
      -- Valida si hubo error
      IF (gnuErrorCode <> 0) THEN
          sbmensa := gsbMessage;
          RAISE erPrograma;
      END IF;
       ------
     UPDATE ldc_solici_cam_dat_pred k
        SET k.dir_legalizada = nuAdressId_New
           ,k.ot_legaliza    = nuOrderId
      WHERE k.package_id = nuPackageID;
     END IF; --> FIN MODO = I
   IF sbModo = 'S' THEN
    -- Inicio JJJM
    FOR i IN cudireccactu(nuPackageID) LOOP
     nuSegmentId_Current := i.segmento_old;
    END LOOP;
    nuSegmentId_New := to_number(ldc_boutilities.fsbgetvalorcampotabla('ab_address', 'address_id', 'SEGMENT_ID', nuAdressId_New));
    IF (nuSegmentId_Current <> nuSegmentId_New) THEN
     /*********************************************************
      *   Crea Orden
      *********************************************************/
     nuItem_Id := dald_parameter.fnuGetNumeric_Value('LDC_COD_TT_VAL_ESTRAT');
     -- Crea Orden
     nuOrderNew    := NULL;
     nuactivityNew := NULL;
     or_boorderactivities.createactivity(
                                         nuItem_Id
                                        ,NULL
                                        ,NULL
                                        ,NULL
                                        ,NULL
                                        ,nuAdressId_New
                                        ,NULL
                                        ,nmsusbcriber_id
                                        ,nmsusccodi
                                        ,nmproduct_id
                                        ,NULL
                                        ,NULL
                                        ,SYSDATE + cnuSECOND
                                        ,NULL
                                        ,'ORDEN GENERADA DESDE : LDCPRMETODESTRATIFICACION'
                                        ,NULL
                                        ,NULL
                                        ,nuOrderNew
                                        ,nuactivityNew
                                        ,NULL
                                        ,NULL
                                        ,NULL
                                        ,NULL
                                        ,NULL
                                        ,NULL
                                        ,NULL
                                        ,NULL
                                        ,NULL
                                        ,NULL
                                        );
      -- Valida si hubo error
      IF (nuOrderNew IS NULL OR nuactivityNew IS NULL) THEN
          sbmensa := 'Error Creando la nueva Orden. --> '||gsbMessage;
          RAISE erPrograma;
      END IF;
      -- Fin JJJM
      gnuErrorCode := null;
      gsbMessage   := null;
     /*********************************************************
      *   Asigna Orden
      *********************************************************/
      nuUnidadOper := dald_parameter.fnuGetNumeric_Value('LDC_COD_UT');
      -- Asignar orden
      os_assign_order(
                      inuorderid         => nuOrderNew,
                      inuoperatingunitid => nuUnidadOper,
                      idtarrangedhour    => sysdate + 1,
                      idtchangedate      => sysdate,
                      onuerrorcode       => gnuErrorCode,
                      osberrormessage    => gsbMessage
                     );
       -- Valida si hubo error
      IF (gnuErrorCode <> 0) THEN
           sbmensa := gsbMessage;
           RAISE erPrograma;
      END IF;
     END IF;
     ------
     UPDATE ldc_solici_cam_dat_pred k
        SET k.segmento_new   = nuSegmentId_New
           ,k.dir_legalizada = nuAdressId_New
           ,k.ot_legaliza    = nuOrderId
      WHERE k.package_id = nuPackageID;
   END IF;--> FIN MODO = S

        end if; --> FIN CAUSAL = CAUSAL DE EXITO
      END IF;--> FIN VALIDACION TIPO DE TRABAJO DENTRO DEL PARAMETRO
     END IF; --> FIN VALIDACION  nuAdressId_New
 END IF;
EXCEPTION
  WHEN erPrograma THEN
    ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
    RAISE ex.CONTROLLED_ERROR;
  WHEN ex.controlled_error THEN
    RAISE;
  WHEN OTHERS THEN
    sbmensa := 'Proceso termino con Errores: '||SQLERRM;
    ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
    errors.seterror;
    RAISE ex.controlled_error;
END LDCPRMETODESTRATIFICACION;
/
PROMPT Otorgando permisos de ejecucion a LDCPRMETODESTRATIFICACION
BEGIN
    pkg_utilidades.praplicarpermisos('LDCPRMETODESTRATIFICACION', 'ADM_PERSON');
END;
/
