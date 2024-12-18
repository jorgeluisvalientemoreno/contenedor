CREATE OR REPLACE PACKAGE LDC_PKGESTIONCERTSV IS

  PROCEDURE PRVALIGENVSI;
  /**************************************************************************
    Autor       :  Horbath
    Fecha       : 2020-02-20
    Ticket      : 34
    Proceso     : PRVALIGENVSI
    Descripcion : Plugin que valida la configuracion de la forma LDCCOAGVSI
                con el objetivo de que se genere la visita de certificacion de sv
          correspondiente

    Parametros Entrada

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  PROCEDURE PRVALIORCERT(inuProducto IN pr_product.product_id%type,
                         inuActividad IN NUMBER);
  /**************************************************************************
    Autor       :  Horbath
    Fecha       : 2020-02-20
    Ticket      : 34
    Proceso     : PRVALIORCERT
    Descripcion : proceso que se encarga de validar que se genere la visita de certificacion
                correspondiente.

    Parametros Entrada
     inuProducto codigo del producto
   inuActividad  codigo de la actividad
    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  PROCEDURE PRFACTVISCERT;
    /**************************************************************************
    Autor       :  Horbath
    Fecha       : 2020-02-20
    Ticket      : 34
    Proceso     : PRFACTVISCERT
    Descripcion : Plugin que se encargue de generar los cobros segun lista de costo generica

    Parametros Entrada

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  PROCEDURE PRVALIORDERP(inuProducto IN pr_product.product_id%type,
                         inuActividad IN NUMBER);
   /**************************************************************************
    Autor       :  Horbath
    Fecha       : 2020-02-20
    Ticket      : 34
    Proceso     : PRVALIORDERP
    Descripcion : proceso que se encarga de validar que no existan ordenes de RP pendientes
    Parametros Entrada
     inuProducto codigo del producto
   inuActividad  codigo de la actividad
    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

end LDC_PKGESTIONCERTSV;
/
CREATE OR REPLACE PACKAGE BODY LDC_PKGESTIONCERTSV IS
 PROCEDURE PRVALIGENVSI is
  /**************************************************************************
    Autor       :  Horbath
    Fecha       : 2020-02-20
    Ticket      : 34
    Proceso     : PRVALIGENVSI
    Descripcion : Plugin que valida la configuracion de la forma LDCCOAGVSI
                con el objetivo de que se genere la visita de certificacion de sv
          correspondiente

    Parametros Entrada

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
   nuErrorCode NUMBER; --se almacena codigo del errors
   sbmensa VARCHAR2(4000);--se almacena mensaje de error
   nuClasCausal NUMBER; --se almacena clase de causal
   nuorden NUMBER; --Se almacena orden de trabajo

--se consultan datos de la orden
 CURSOR cuGetdatOrden IS
 SELECT O.TASK_TYPE_ID, O.OPERATING_UNIT_ID,  O.CAUSAL_ID, OA.ACTIVITY_ID,  s.package_id, P.CATEGORY_ID, P.SUBCATEGORY_ID, S.PACKAGE_TYPE_ID, OA.PRODUCT_ID, OA.SUBSCRIBER_ID, P.ADDRESS_ID
 From or_order o, or_order_activity oa, pr_product p, mo_packages s
 WHERE o.order_id = oa.order_id
  AND o.order_id = nuorden
  and p.product_id = oa.product_id
  and s.package_id = oa.package_id;

  regDatOrden cuGetdatOrden%ROWTYPE;

  CURSOR cuConfVSI IS
  SELECT C.COCLACTI
  FROM LDC_COTTCLAC c
  WHERE (c.COCLTISO = regDatOrden.PACKAGE_TYPE_ID or  c.COCLTISO = -1)
   AND c.COCLTITR = regDatOrden.TASK_TYPE_ID
   AND (c.COCLACPA = regDatOrden.ACTIVITY_ID or  c.COCLACPA is null )
   AND (c.COCLCAUS = regDatOrden.CAUSAL_ID or c.COCLCAUS = -1)
   AND (c.COCLCATE = regDatOrden.CATEGORY_ID or  c.COCLCATE = -1)
   AND (c.COCLSUCA = regDatOrden.SUBCATEGORY_ID or c.COCLSUCA is null);

  BEGIN
   IF FBLAPLICAENTREGAXCASO('0000034') THEN
      --Obtener el identificador de la orden  que se encuentra en la instancia
      nuorden:=   or_bolegalizeorder.fnuGetCurrentOrder;
      ut_trace.trace('Numero de la Orden:'||nuorden, 10);
      nuClasCausal := DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID(DAOR_ORDER.FNUGETCAUSAL_ID(nuorden, null),null); --se obtiene clase de causal

      IF nuClasCausal = 1 THEN
       --se carga informacion de la orden
      OPEN cuGetdatOrden;
      FETCH cuGetdatOrden INTO regDatOrden;
      IF cuGetdatOrden%NOTFOUND THEN
       sbmensa := 'No existe informacion de la orden '||to_char(nuorden);
       ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensa);
      END IF;
      CLOSE cuGetdatOrden;
      --se valida configuracion de VSI
      FOR reg IN cuConfVSI LOOP
          PRVALIORCERT(regDatOrden.PRODUCT_ID, reg.COCLACTI);
      END LOOP;
    END IF;
   END IF;
  EXCEPTION
   WHEN ex.controlled_error THEN
     errors.geterror(nuErrorCode, sbmensa);
    RAISE ex.controlled_error;
 WHEN OTHERS THEN
    errors.seterror;
    RAISE ex.controlled_error;
  END PRVALIGENVSI;
 PROCEDURE PRVALIORCERT(inuProducto IN pr_product.product_id%type,
                         inuActividad IN NUMBER) IS
  /**************************************************************************
    Autor       :  Horbath
    Fecha       : 2020-02-20
    Ticket      : 34
    Proceso     : PRVALIORCERT
    Descripcion : proceso que se encarga de validar que se genere la visita de certificacion
                correspondiente.

    Parametros Entrada
     inuProducto codigo del producto
   inuActividad  codigo de la actividad
    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR           DESCRIPCION
  16/07/2024   Jorge Valiente    OSF-2948: Se retira toda la logica del servicio para ser reemplazad por NULL. 
                                           Permtiendo no aplicar de forma directa un cambio sobre el tramite de VSI
                                           y solo afectar el servicio de la regla que realiza el llamado de este servicio.
  ***************************************************************************/
  
 BEGIN
   NULL;
 END PRVALIORCERT;

  PROCEDURE PRFACTVISCERT IS
    /**************************************************************************
    Autor       :  Horbath
    Fecha       : 2020-02-20
    Ticket      : 34
    Proceso     : PRFACTVISCERT
    Descripcion : Plugin que se encargue de generar los cobros segun lista de costo generica

    Parametros Entrada

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
   nuErrorCode NUMBER; --se almacena codigo del errors
   sbmensa VARCHAR2(4000);--se almacena mensaje de error
   nuClasCausal NUMBER; --se almacena clase de causal
   nuorden NUMBER; --Se almacena orden de trabajo
   nuTaskTypeId NUMBER; --se almacena tipo de trabajo

   nuPackageId NUMBER; --se almacena solicitud
   nuItem_id NUMBER; --se almacena codigo del items
   nuProducto NUMBER; --se almacena codigo del producto
   nuContrato NUMBER; --se almacena codigo de la subcripcion
   onuIdListaCosto    ge_unit_cost_ite_lis.list_unitary_cost_id%type;
   onuCostoItem       ge_unit_cost_ite_lis.price%type;
   onuPrecioVentaItem ge_unit_cost_ite_lis.sales_value%type;
   nuConcepto NUMBER; --se almacena concepto

   --se consultan datos de la orden
   CURSOR cugetDatoOrde IS
   SELECT oa.package_id, oa.product_id, oa.subscription_id, oa.activity_id, o.task_type_id
   FROM or_order_activity oa, or_order o
   WHERE o.order_id = oa.order_id
    AND o.order_id = nuorden;

   dtFechaFinEjec date;
   nuOperatingUnitId number;
   nuLocalidad number;
   nuContract number;
   nuContractor number;


  BEGIN
    IF FBLAPLICAENTREGAXCASO('0000034') THEN
      --Obtener el identificador de la orden  que se encuentra en la instancia
      nuorden:=   or_bolegalizeorder.fnuGetCurrentOrder;
      ut_trace.trace('Numero de la Orden:'||nuorden, 10);
      nuClasCausal := DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID(DAOR_ORDER.FNUGETCAUSAL_ID(nuorden, null),null); --se obtiene clase de causal

      IF nuClasCausal = 1 THEN

     OPEN cugetDatoOrde;
     FETCH cugetDatoOrde INTO nuPackageId, nuProducto, nuContrato, nuItem_id, nuTaskTypeId;
     IF cugetDatoOrde%NOTFOUND THEN
        CLOSE cugetDatoOrde;
       ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,'No se encontro informacion de la orden ['||nuorden||']');

     END IF;
     CLOSE cugetDatoOrde;
     ut_trace.trace('Ejecucion LDC_PKGESTIONCERTSV  => nuTaskTypeId => ' || nuTaskTypeId||', nuPackageId => ' ||nuPackageId||', nuItem_id => ' || nuItem_id, 10);

     dtFechaFinEjec  := daor_order.fdtgetexecution_final_date(nuorden);
     nuLocalidad:=LDC_BOORDENES.FNUGETIDLOCALIDAD(nuorden);
     nuOperatingUnitId := daor_order.fnugetoperating_unit_id(nuorden);
     ut_trace.trace('Ejecucion prTemporalCharges  => nuOperatingUnitId => ' ||
             nuOperatingUnitId,
             10);
     nuContract := daor_order.fnugetdefined_contract_id(nuorden);
    ut_trace.trace('Ejecucion prTemporalCharges  => nuContract => ' ||
             nuContract,
             10);
      nuContractor := daor_operating_unit.fnugetcontractor_id(nuOperatingUnitId);
     --se obtiene costo de la actividad
     GE_BCCertContratista.ObtenerCostoItemLista(nuItem_id,
                          dtFechaFinEjec,
                         nuLocalidad,
                         nuContractor,
                         nuOperatingUnitId,
                         nuContract,
                         onuIdListaCosto,
                         onuCostoItem,
                         onuPrecioVentaItem);
     ut_trace.trace('Ejecucion LDC_PKGESTIONCERTSV onuPrecioVentaItem => ' || onuPrecioVentaItem, 10);
     nuConcepto := daor_task_type.fnugetconcept(nuTaskTypeId, null);
     ut_trace.trace('Ejecucion LDC_PKGESTIONCERTSV nuConcepto => ' || nuConcepto,10);

       --Eliminar cargo
        delete from cargos
         where cargos.cargnuse = nuProducto
           and cargos.cargconc = nuConcepto
           and cargdoso = 'PP-' || nuPackageId;

     if onuPrecioVentaItem is not null and nuConcepto is not null then

      OS_CHARGETOBILL(INUSUBSCRIBERSERVICE => nuProducto,
              INUCONCEPT           => nuConcepto,
              INUUNITS             => 1,
              INUCHARGECAUSE       => 53,
              INUVALUE             => round(abs(onuPrecioVentaItem)),
              ISBSUPPORTDOCUMENT   => 'PP-' || nuPackageId,
              INUCONSPERIOD        => NULL,
              ONUERRORCODE         => nuErrorCode,
              OSBERRORMSG          => sbmensa);
      ut_trace.trace('CODIGO ERROR --> ' || nuErrorCode);
      ut_trace.trace('DESCRIPCION ERROR --> ' || sbmensa);
      ut_trace.trace('Fin de insertar cargo', 10);
      if nuErrorCode <> 0 then
        raise ex.CONTROLLED_ERROR;
      end if;
      ut_trace.trace('Ejecucion LDC_PKGESTIONCERTSV  FIN de insertar cargo DB ' ||
               nuConcepto,
               10);
     end if;
    END IF;

  END IF;

  EXCEPTION
   WHEN ex.controlled_error THEN
     errors.geterror(nuErrorCode, sbmensa);
    RAISE ex.controlled_error;
 WHEN OTHERS THEN
    errors.seterror;
    RAISE ex.controlled_error;
  END PRFACTVISCERT;


  PROCEDURE PRVALIORDERP(inuProducto IN pr_product.product_id%type,
                         inuActividad IN NUMBER) IS
   /**************************************************************************
    Autor       :  Horbath
    Fecha       : 2020-02-20
    Ticket      : 34
    Proceso     : PRVALIORDERP
    Descripcion : proceso que se encarga de validar que no existan ordenes de RP pendientes
    Parametros Entrada
     inuProducto codigo del producto
   inuActividad  codigo de la actividad
    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
   nuErrorCode NUMBER; --se almacena codigo del errors
   sbmensa VARCHAR2(4000);--se almacena mensaje de error

   sbTitrRp VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_TITRRPVA', NULL);--se almacena codigo de tipos de trabajo de RP
   sbEstadoVali VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_CODESTORDVA', NULL);--se almacena estado de orden a validar
   sbActivRefIns VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_ACTREFOINST', NULL);--se almacena estado de orden a validar
   sbActiCate   VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_ACTCECATE', NULL);--se almacena actividades de visita de certificacion x categoria

   sbDatos    VARCHAR2(1); --se almacena si existe orden pendientes
   nuExisteAct NUMBER; --se almacena si existe actividad
   nuCate NUMBER; --se almacena categoria del producto

   --valida ordenes de rp pendientes
   CURSOR cuValOrdePendRP IS
   SELECT 'X'
   FROM or_order o, or_order_activity oa
   WHERE o.order_id = oa.order_id
    AND oa.product_id = inuProducto
  AND o.task_type_id IN ( SELECT to_number(regexp_substr(sbTitrRp,'[^,]+', 1, LEVEL)) AS esta
                              FROM   dual
                             CONNECT BY regexp_substr(sbTitrRp, '[^,]+', 1, LEVEL) IS NOT NULL)
  AND o.order_status_id in ( SELECT to_number(regexp_substr(sbEstadoVali,'[^,]+', 1, LEVEL)) AS esta
                               FROM   dual
                               CONNECT BY regexp_substr(sbEstadoVali, '[^,]+', 1, LEVEL) IS NOT NULL);

  BEGIN
     IF FBLAPLICAENTREGAXCASO('0000034') THEN
      --valida si existe actividad de reforma
    SELECT COUNT(1) INTO nuExisteAct
    FROM ( SELECT to_number(regexp_substr(sbActivRefIns,'[^,]+', 1, LEVEL)) AS acti
         FROM   dual
           CONNECT BY regexp_substr(sbActivRefIns, '[^,]+', 1, LEVEL) IS NOT NULL)
    WHERE acti = inuActividad;

    IF nuExisteAct > 0 THEN
       OPEN cuValOrdePendRP;
       FETCH cuValOrdePendRP INTO sbDatos;
       IF cuValOrdePendRP%FOUND THEN
          ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,'Existen ordenes de RP('||sbTitrRp||') pendientes para el producto ['||inuProducto||']');
       END IF;
       CLOSE cuValOrdePendRP;
    END IF;

    nuCate :=  DAPR_PRODUCT.FNUGETCATEGORY_ID(inuProducto, null); --Se obtiene categoria

    IF sbActiCate IS NOT NULL THEN
      --se valida que la actividad este configurada
      IF instr(sbActiCate, inuActividad||','||nuCate) = 0 THEN
        --se valida si la actividad esta configurada para otra categoria
        IF instr(sbActiCate, inuActividad||',') > 0 THEN
          ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,'La actividad ['||inuActividad||'-'||dage_items.fsbgetdescription(inuActividad,null)||'] no esta configurada para la categoria['||nuCate||'] del producto');
        END IF;
      END IF;
    END IF;

   END IF;

  EXCEPTION
    WHEN ex.controlled_error THEN
     errors.geterror(nuErrorCode, sbmensa);
    RAISE ex.controlled_error;
   WHEN OTHERS THEN
    errors.seterror;
    RAISE ex.controlled_error;
   END PRVALIORDERP;
END LDC_PKGESTIONCERTSV;
/
GRANT EXECUTE on LDC_PKGESTIONCERTSV to SYSTEM_OBJ_PRIVS_ROLE;
/
