CREATE OR REPLACE PACKAGE BODY GE_BCCERTCONTRATISTA IS
   TYPE TYDATOSORDEN IS RECORD
    (
      ASSIGNED_DATE OR_ORDER.ASSIGNED_DATE%TYPE,
      OPERATING_UNIT_ID OR_ORDER.OPERATING_UNIT_ID%TYPE,
      GEOGRA_LOCATION_ID GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%TYPE
    );
   TYPE TYDATOSACTA IS RECORD
    (
      ID_BASE_ADMINISTRATIVA GE_ACTA.ID_BASE_ADMINISTRATIVA%TYPE,
      ID_CONTRATO GE_ACTA.ID_CONTRATO%TYPE
    );
   TYPE TYLISTACOSTOITEM IS RECORD
    (
      LIST_UNITARY_COST_ID GE_UNIT_COST_ITE_LIS.LIST_UNITARY_COST_ID%TYPE,
      PRICE GE_UNIT_COST_ITE_LIS.PRICE%TYPE,
      SALES_VALUE GE_UNIT_COST_ITE_LIS.SALES_VALUE%TYPE,
      VALIDITY_START_DATE GE_LIST_UNITARY_COST.VALIDITY_START_DATE%TYPE,
      VALIDITY_FINAL_DATE GE_LIST_UNITARY_COST.VALIDITY_FINAL_DATE%TYPE
    );
   TYPE TYTBDATOSORDEN IS TABLE OF TYDATOSORDEN INDEX BY VARCHAR2( 15 );
   TYPE TYTBDATOSACTA IS TABLE OF TYDATOSACTA INDEX BY VARCHAR2( 15 );
   TYPE TYTBDATOSCONTRATO IS TABLE OF GE_CONTRATO.ID_CONTRATISTA%TYPE INDEX BY VARCHAR2( 15 );
   TYPE TYTBLISTACOSTOITEM IS TABLE OF TYLISTACOSTOITEM INDEX BY PLS_INTEGER;
   TYPE TYLRECORD IS RECORD
    (
      TBTABLE TYTBLISTACOSTOITEM
    );
   TYPE TYTBLISTASCOSTOSITEM IS TABLE OF TYLRECORD INDEX BY VARCHAR2( 52 );
   CSBVERSION CONSTANT VARCHAR2( 10 ) := 'SAO234211';
   TBCACHEDATOSORDEN TYTBDATOSORDEN;
   TBCACHEDATOSACTA TYTBDATOSACTA;
   TBCACHEDATOSCONTRATO TYTBDATOSCONTRATO;
   TBCACHELISTASCOSTOSITEM TYTBLISTASCOSTOSITEM;
   TBCACHEDATOSUNIDADTRABAJO DAOR_OPERATING_UNIT.TYTBCONTRACTOR_ID;
   FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN CSBVERSION;
   END;
   PROCEDURE OBTORDENESSINACTA( OTBORDENES OUT DAOR_ORDER.TYTBOR_ORDER )
    IS
      CURSOR CUORDENESSINACTA IS
SELECT  /*+ index(OR_ORDER, IDX_OR_ORDER_3)*/OR_order.*,OR_order.rowid
        FROM    or_operating_unit,
                OR_order
        WHERE   or_operating_unit.es_externa = ge_boconstants.csbYES
        AND     OR_order.operating_unit_id = or_operating_unit.operating_unit_id
        AND     OR_order.order_status_id = or_boconstants.cnuORDER_STAT_CLOSED
        AND     not exists (SELECT ct_order_certifica.order_id
                            FROM   ct_order_certifica
                            WHERE  ct_order_certifica.order_id = OR_order.order_id);
    BEGIN
      IF CUORDENESSINACTA%ISOPEN THEN
         CLOSE CUORDENESSINACTA;
      END IF;
      OPEN CUORDENESSINACTA;
      FETCH CUORDENESSINACTA
         BULK COLLECT INTO OTBORDENES;
      CLOSE CUORDENESSINACTA;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE LIMPIARCACHEVALORITEMLISTA
    IS
    BEGIN
      TBCACHEDATOSORDEN.DELETE;
      TBCACHEDATOSUNIDADTRABAJO.DELETE;
      TBCACHELISTASCOSTOSITEM.DELETE;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END LIMPIARCACHEVALORITEMLISTA;
   PROCEDURE OBTENERDATOSORDEN( INUORDERID IN OR_ORDER.ORDER_ID%TYPE, ONUASSIGNEDDATE OUT OR_ORDER.ASSIGNED_DATE%TYPE, ONUOPERATINGUNITID OUT OR_ORDER.OPERATING_UNIT_ID%TYPE, ONUGEOGRALOCATIONID OUT GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%TYPE )
    IS
      NUEXTERNAL OR_ORDER.EXTERNAL_ADDRESS_ID%TYPE;
    BEGIN
      IF ( TBCACHEDATOSORDEN.EXISTS( INUORDERID ) ) THEN
         ONUASSIGNEDDATE := TBCACHEDATOSORDEN( INUORDERID ).ASSIGNED_DATE;
         ONUOPERATINGUNITID := TBCACHEDATOSORDEN( INUORDERID ).OPERATING_UNIT_ID;
         ONUGEOGRALOCATIONID := TBCACHEDATOSORDEN( INUORDERID ).GEOGRA_LOCATION_ID;
         RETURN;
      END IF;
      SELECT or_order.assigned_date,
               or_order.operating_unit_id,
               or_order.external_address_id
        INTO   onuAssignedDate,
               onuOperatingUnitId,
               nuExternal
        FROM   or_order
        WHERE  or_order.order_id = inuOrderId;
      ONUGEOGRALOCATIONID := GE_BOCERTCONTRATISTA.FNUGETGEOLOCATIONBYADDRESS( NUEXTERNAL );
      TBCACHEDATOSORDEN( INUORDERID ).ASSIGNED_DATE := ONUASSIGNEDDATE;
      TBCACHEDATOSORDEN( INUORDERID ).OPERATING_UNIT_ID := ONUOPERATINGUNITID;
      TBCACHEDATOSORDEN( INUORDERID ).GEOGRA_LOCATION_ID := ONUGEOGRALOCATIONID;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END OBTENERDATOSORDEN;
   PROCEDURE OBTENERDATOSACTA( INUIDACTA IN GE_ACTA.ID_ACTA%TYPE, ONUIDBASEADMIN OUT GE_ACTA.ID_BASE_ADMINISTRATIVA%TYPE, ONUIDCONTRATO OUT GE_ACTA.ID_CONTRATO%TYPE )
    IS
    BEGIN
      IF ( TBCACHEDATOSACTA.EXISTS( INUIDACTA ) ) THEN
         ONUIDBASEADMIN := TBCACHEDATOSACTA( INUIDACTA ).ID_BASE_ADMINISTRATIVA;
         ONUIDCONTRATO := TBCACHEDATOSACTA( INUIDACTA ).ID_CONTRATO;
         RETURN;
      END IF;
      SELECT ge_acta.id_base_administrativa,
               ge_acta.id_contrato
        INTO   onuIdBaseAdmin,
               onuIdContrato
        FROM   ge_acta
        WHERE  ge_acta.id_acta = inuIdActa;
      TBCACHEDATOSACTA( INUIDACTA ).ID_BASE_ADMINISTRATIVA := ONUIDBASEADMIN;
      TBCACHEDATOSACTA( INUIDACTA ).ID_CONTRATO := ONUIDCONTRATO;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END OBTENERDATOSACTA;
   PROCEDURE OBTDATOSCONTRATO( INUIDCONTRATO IN GE_CONTRATO.ID_CONTRATO%TYPE, ONUIDCONTRATISTA OUT GE_CONTRATO.ID_CONTRATISTA%TYPE )
    IS
    BEGIN
      IF ( TBCACHEDATOSCONTRATO.EXISTS( INUIDCONTRATO ) ) THEN
         ONUIDCONTRATISTA := TBCACHEDATOSCONTRATO( INUIDCONTRATO );
         RETURN;
      END IF;
      SELECT ge_contrato.id_contratista
        INTO   onuIdContratista
        FROM   ge_contrato
        WHERE  ge_contrato.id_contrato = inuIdContrato;
      TBCACHEDATOSCONTRATO( INUIDCONTRATO ) := ONUIDCONTRATISTA;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END OBTDATOSCONTRATO;
   PROCEDURE OBTENERCOSTOITEMLISTA( INUIDITEM IN GE_UNIT_COST_ITE_LIS.ITEMS_ID%TYPE, INUFECHAASSIGNACION IN OR_ORDER.ASSIGNED_DATE%TYPE, INUGEOLOCATIONID IN GE_LIST_UNITARY_COST.GEOGRAP_LOCATION_ID%TYPE, INUCONTRATISTA IN GE_LIST_UNITARY_COST.CONTRACTOR_ID%TYPE, INUUNIDADOPER IN GE_LIST_UNITARY_COST.OPERATING_UNIT_ID%TYPE, INUCONTRACT IN GE_LIST_UNITARY_COST.CONTRACT_ID%TYPE, ONUIDLISTACOSTO OUT GE_UNIT_COST_ITE_LIS.LIST_UNITARY_COST_ID%TYPE, ONUCOSTOITEM OUT GE_UNIT_COST_ITE_LIS.PRICE%TYPE, ONUPRECIOVENTAITEM OUT GE_UNIT_COST_ITE_LIS.SALES_VALUE%TYPE )
    IS
      CURSOR CUUNIDADOPERATIVA IS
SELECT /*+ index(ge_list_unitary_cost, IDX_GE_LIST_UNITARY_COST01)*/
                   ge_unit_cost_ite_lis.list_unitary_cost_id,
                   ge_unit_cost_ite_lis.price,
                   ge_unit_cost_ite_lis.sales_value,
                   ge_list_unitary_cost.validity_start_date,
                   ge_list_unitary_cost.validity_final_date
            FROM   ge_list_unitary_cost,
                   ge_unit_cost_ite_lis
            WHERE  ge_list_unitary_cost.operating_unit_id = inuUnidadOper
              AND  ge_list_unitary_cost.list_unitary_cost_id = ge_unit_cost_ite_lis.list_unitary_cost_id
              AND  trunc(inuFechaAssignacion) BETWEEN ge_list_unitary_cost.validity_start_date
                                           AND ge_list_unitary_cost.validity_final_date
              AND  ge_unit_cost_ite_lis.items_id = inuIdItem;
      CURSOR CUCONTRATISTA IS
SELECT /*+ index(ge_list_unitary_cost, IDX_GE_LIST_UNITARY_COST01)*/
                   ge_unit_cost_ite_lis.list_unitary_cost_id,
                   ge_unit_cost_ite_lis.price,
                   ge_unit_cost_ite_lis.sales_value,
                   ge_list_unitary_cost.validity_start_date,
                   ge_list_unitary_cost.validity_final_date
            FROM   ge_list_unitary_cost,
                   ge_unit_cost_ite_lis
            WHERE  ge_list_unitary_cost.contractor_id = inuContratista
              AND  ge_list_unitary_cost.list_unitary_cost_id = ge_unit_cost_ite_lis.list_unitary_cost_id
              AND  trunc(inuFechaAssignacion) BETWEEN ge_list_unitary_cost.validity_start_date
                                           AND ge_list_unitary_cost.validity_final_date
              AND  ge_unit_cost_ite_lis.items_id = inuIdItem;
      CURSOR CUCONTRACT IS
SELECT /*+ index(ge_list_unitary_cost, IDX_GE_LIST_UNITARY_COST01)*/
                   ge_unit_cost_ite_lis.list_unitary_cost_id,
                   ge_unit_cost_ite_lis.price,
                   ge_unit_cost_ite_lis.sales_value,
                   ge_list_unitary_cost.validity_start_date,
                   ge_list_unitary_cost.validity_final_date
            FROM   ge_list_unitary_cost,
                   ge_unit_cost_ite_lis
            WHERE  ge_list_unitary_cost.contract_id  = inuContract
              AND  ge_list_unitary_cost.list_unitary_cost_id = ge_unit_cost_ite_lis.list_unitary_cost_id
              AND  trunc(inuFechaAssignacion) BETWEEN ge_list_unitary_cost.validity_start_date
                                           AND ge_list_unitary_cost.validity_final_date
              AND  ge_unit_cost_ite_lis.items_id = inuIdItem;
      CURSOR CUGEOLOCATION IS
SELECT /*+ index(ge_list_unitary_cost, IDX_GE_LIST_UNITARY_COST01)*/
                   ge_unit_cost_ite_lis.list_unitary_cost_id,
                   ge_unit_cost_ite_lis.price,
                   ge_unit_cost_ite_lis.sales_value,
                   ge_list_unitary_cost.validity_start_date,
                   ge_list_unitary_cost.validity_final_date
            FROM   ge_list_unitary_cost,
                   ge_unit_cost_ite_lis
            WHERE  ge_list_unitary_cost.geograp_location_id = inuGeoLocationId
              AND  ge_list_unitary_cost.list_unitary_cost_id = ge_unit_cost_ite_lis.list_unitary_cost_id
              AND  trunc(inuFechaAssignacion) BETWEEN ge_list_unitary_cost.validity_start_date
                                           AND ge_list_unitary_cost.validity_final_date
              AND  ge_unit_cost_ite_lis.items_id = inuIdItem;
      CURSOR CUGENERICA IS
SELECT /*+ index(ge_list_unitary_cost, IDX_GE_LIST_UNITARY_COST01)*/
                   ge_unit_cost_ite_lis.list_unitary_cost_id,
                   ge_unit_cost_ite_lis.price,
                   ge_unit_cost_ite_lis.sales_value,
                   ge_list_unitary_cost.validity_start_date,
                   ge_list_unitary_cost.validity_final_date
            FROM   ge_list_unitary_cost,
                   ge_unit_cost_ite_lis
            WHERE  ge_list_unitary_cost.contract_id IS NULL
              AND  ge_list_unitary_cost.contractor_id IS NULL
              AND  ge_list_unitary_cost.operating_unit_id IS NULL
              AND  ge_list_unitary_cost.geograp_location_id IS NULL
              AND  ge_list_unitary_cost.list_unitary_cost_id = ge_unit_cost_ite_lis.list_unitary_cost_id
              AND  trunc(inuFechaAssignacion) BETWEEN ge_list_unitary_cost.validity_start_date
                                           AND ge_list_unitary_cost.validity_final_date
              AND  ge_unit_cost_ite_lis.items_id = inuIdItem;
      SBCACHE VARCHAR2( 52 );
      DTINICIAL GE_LIST_UNITARY_COST.VALIDITY_START_DATE%TYPE;
      DTFINAL GE_LIST_UNITARY_COST.VALIDITY_FINAL_DATE%TYPE;
      TBNULLCACHE TYTBLISTACOSTOITEM;
      PROCEDURE BUSCARPORVIGENCIA( IOTBCACHE IN OUT NOCOPY TYTBLISTACOSTOITEM, ONULISTA OUT GE_UNIT_COST_ITE_LIS.LIST_UNITARY_COST_ID%TYPE, ONUCOSTO OUT GE_UNIT_COST_ITE_LIS.PRICE%TYPE, ONUPRECIO OUT GE_UNIT_COST_ITE_LIS.SALES_VALUE%TYPE )
       IS
       BEGIN
         ONULISTA := NULL;
         ONUCOSTO := NULL;
         ONUPRECIO := NULL;
         IF ( IOTBCACHE IS NULL ) THEN
            RETURN;
         END IF;
         IF ( IOTBCACHE.FIRST IS NULL ) THEN
            RETURN;
         END IF;
         FOR I IN IOTBCACHE.FIRST..IOTBCACHE.LAST
          LOOP
            IF ( ( IOTBCACHE( I ).VALIDITY_START_DATE <= TRUNC( INUFECHAASSIGNACION ) ) AND ( TRUNC( INUFECHAASSIGNACION ) <= IOTBCACHE( I ).VALIDITY_FINAL_DATE ) ) THEN
               ONULISTA := IOTBCACHE( I ).LIST_UNITARY_COST_ID;
               ONUCOSTO := IOTBCACHE( I ).PRICE;
               ONUPRECIO := IOTBCACHE( I ).SALES_VALUE;
               RETURN;
            END IF;
         END LOOP;
      END BUSCARPORVIGENCIA;
      PROCEDURE AGREGARALCACHE( IOTBCACHE IN OUT NOCOPY TYTBLISTACOSTOITEM )
       IS
         NUPOSICION PLS_INTEGER;
       BEGIN
         IF ( IOTBCACHE IS NULL ) THEN
            RETURN;
         END IF;
         NUPOSICION := IOTBCACHE.LAST;
         IF ( NUPOSICION IS NULL ) THEN
            NUPOSICION := 0;
         END IF;
         NUPOSICION := NUPOSICION + 1;
         IOTBCACHE( NUPOSICION ).LIST_UNITARY_COST_ID := ONUIDLISTACOSTO;
         IOTBCACHE( NUPOSICION ).PRICE := ONUCOSTOITEM;
         IOTBCACHE( NUPOSICION ).SALES_VALUE := ONUPRECIOVENTAITEM;
         IOTBCACHE( NUPOSICION ).VALIDITY_START_DATE := DTINICIAL;
         IOTBCACHE( NUPOSICION ).VALIDITY_FINAL_DATE := DTFINAL;
      END AGREGARALCACHE;
    BEGIN
      SBCACHE := INUIDITEM || '_OPERATING_UNIT_' || INUUNIDADOPER;
      IF ( TBCACHELISTASCOSTOSITEM.EXISTS( SBCACHE ) ) THEN
         BUSCARPORVIGENCIA( TBCACHELISTASCOSTOSITEM( SBCACHE ).TBTABLE, ONUIDLISTACOSTO, ONUCOSTOITEM, ONUPRECIOVENTAITEM );
         IF ( ONUIDLISTACOSTO IS NOT NULL ) THEN
            RETURN;
         END IF;
      END IF;
      OPEN CUUNIDADOPERATIVA;
      FETCH CUUNIDADOPERATIVA
         INTO ONUIDLISTACOSTO, ONUCOSTOITEM, ONUPRECIOVENTAITEM, DTINICIAL, DTFINAL;
      CLOSE CUUNIDADOPERATIVA;
      IF ( ONUIDLISTACOSTO IS NOT NULL ) THEN
         IF ( NOT TBCACHELISTASCOSTOSITEM.EXISTS( SBCACHE ) ) THEN
            TBCACHELISTASCOSTOSITEM( SBCACHE ).TBTABLE := TBNULLCACHE;
         END IF;
         AGREGARALCACHE( TBCACHELISTASCOSTOSITEM( SBCACHE ).TBTABLE );
         RETURN;
      END IF;
      SBCACHE := INUIDITEM || '_CONTRACT_ID_' || INUCONTRACT;
      IF ( TBCACHELISTASCOSTOSITEM.EXISTS( SBCACHE ) ) THEN
         BUSCARPORVIGENCIA( TBCACHELISTASCOSTOSITEM( SBCACHE ).TBTABLE, ONUIDLISTACOSTO, ONUCOSTOITEM, ONUPRECIOVENTAITEM );
         IF ( ONUIDLISTACOSTO IS NOT NULL ) THEN
            RETURN;
         END IF;
      END IF;
      OPEN CUCONTRACT;
      FETCH CUCONTRACT
         INTO ONUIDLISTACOSTO, ONUCOSTOITEM, ONUPRECIOVENTAITEM, DTINICIAL, DTFINAL;
      CLOSE CUCONTRACT;
      IF ( ONUIDLISTACOSTO IS NOT NULL ) THEN
         IF ( NOT TBCACHELISTASCOSTOSITEM.EXISTS( SBCACHE ) ) THEN
            TBCACHELISTASCOSTOSITEM( SBCACHE ).TBTABLE := TBNULLCACHE;
         END IF;
         AGREGARALCACHE( TBCACHELISTASCOSTOSITEM( SBCACHE ).TBTABLE );
         RETURN;
      END IF;
      SBCACHE := INUIDITEM || '_CONTRACTOR_ID_' || INUCONTRATISTA;
      IF ( TBCACHELISTASCOSTOSITEM.EXISTS( SBCACHE ) ) THEN
         BUSCARPORVIGENCIA( TBCACHELISTASCOSTOSITEM( SBCACHE ).TBTABLE, ONUIDLISTACOSTO, ONUCOSTOITEM, ONUPRECIOVENTAITEM );
         IF ( ONUIDLISTACOSTO IS NOT NULL ) THEN
            RETURN;
         END IF;
      END IF;
      OPEN CUCONTRATISTA;
      FETCH CUCONTRATISTA
         INTO ONUIDLISTACOSTO, ONUCOSTOITEM, ONUPRECIOVENTAITEM, DTINICIAL, DTFINAL;
      CLOSE CUCONTRATISTA;
      IF ( ONUIDLISTACOSTO IS NOT NULL ) THEN
         IF ( NOT TBCACHELISTASCOSTOSITEM.EXISTS( SBCACHE ) ) THEN
            TBCACHELISTASCOSTOSITEM( SBCACHE ).TBTABLE := TBNULLCACHE;
         END IF;
         AGREGARALCACHE( TBCACHELISTASCOSTOSITEM( SBCACHE ).TBTABLE );
         RETURN;
      END IF;
      SBCACHE := INUIDITEM || '_GEO_LOCATION_ID_' || INUGEOLOCATIONID;
      IF ( TBCACHELISTASCOSTOSITEM.EXISTS( SBCACHE ) ) THEN
         BUSCARPORVIGENCIA( TBCACHELISTASCOSTOSITEM( SBCACHE ).TBTABLE, ONUIDLISTACOSTO, ONUCOSTOITEM, ONUPRECIOVENTAITEM );
         IF ( ONUIDLISTACOSTO IS NOT NULL ) THEN
            RETURN;
         END IF;
      END IF;
      OPEN CUGEOLOCATION;
      FETCH CUGEOLOCATION
         INTO ONUIDLISTACOSTO, ONUCOSTOITEM, ONUPRECIOVENTAITEM, DTINICIAL, DTFINAL;
      CLOSE CUGEOLOCATION;
      IF ( ONUIDLISTACOSTO IS NOT NULL ) THEN
         IF ( NOT TBCACHELISTASCOSTOSITEM.EXISTS( SBCACHE ) ) THEN
            TBCACHELISTASCOSTOSITEM( SBCACHE ).TBTABLE := TBNULLCACHE;
         END IF;
         AGREGARALCACHE( TBCACHELISTASCOSTOSITEM( SBCACHE ).TBTABLE );
         RETURN;
      END IF;
      SBCACHE := INUIDITEM || '_GENERIC_';
      IF ( TBCACHELISTASCOSTOSITEM.EXISTS( SBCACHE ) ) THEN
         BUSCARPORVIGENCIA( TBCACHELISTASCOSTOSITEM( SBCACHE ).TBTABLE, ONUIDLISTACOSTO, ONUCOSTOITEM, ONUPRECIOVENTAITEM );
         IF ( ONUIDLISTACOSTO IS NOT NULL ) THEN
            RETURN;
         END IF;
      END IF;
      OPEN CUGENERICA;
      FETCH CUGENERICA
         INTO ONUIDLISTACOSTO, ONUCOSTOITEM, ONUPRECIOVENTAITEM, DTINICIAL, DTFINAL;
      CLOSE CUGENERICA;
      IF ( ONUIDLISTACOSTO IS NOT NULL ) THEN
         IF ( NOT TBCACHELISTASCOSTOSITEM.EXISTS( SBCACHE ) ) THEN
            TBCACHELISTASCOSTOSITEM( SBCACHE ).TBTABLE := TBNULLCACHE;
         END IF;
         AGREGARALCACHE( TBCACHELISTASCOSTOSITEM( SBCACHE ).TBTABLE );
         RETURN;
      END IF;
      ONUIDLISTACOSTO := NULL;
      ONUCOSTOITEM := 0;
      ONUPRECIOVENTAITEM := 0;
      DTINICIAL := TRUNC( UT_DATE.FDTMINDATE );
      DTFINAL := TRUNC( SYSDATE + 1 );
      IF ( NOT TBCACHELISTASCOSTOSITEM.EXISTS( SBCACHE ) ) THEN
         TBCACHELISTASCOSTOSITEM( SBCACHE ).TBTABLE := TBNULLCACHE;
      END IF;
      AGREGARALCACHE( TBCACHELISTASCOSTOSITEM( SBCACHE ).TBTABLE );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         IF CUUNIDADOPERATIVA%ISOPEN THEN
            CLOSE CUUNIDADOPERATIVA;
         END IF;
         IF CUCONTRACT%ISOPEN THEN
            CLOSE CUCONTRACT;
         END IF;
         IF CUCONTRATISTA%ISOPEN THEN
            CLOSE CUCONTRATISTA;
         END IF;
         IF CUGEOLOCATION%ISOPEN THEN
            CLOSE CUGEOLOCATION;
         END IF;
         IF CUGENERICA%ISOPEN THEN
            CLOSE CUGENERICA;
         END IF;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         IF CUUNIDADOPERATIVA%ISOPEN THEN
            CLOSE CUUNIDADOPERATIVA;
         END IF;
         IF CUCONTRACT%ISOPEN THEN
            CLOSE CUCONTRACT;
         END IF;
         IF CUCONTRATISTA%ISOPEN THEN
            CLOSE CUCONTRATISTA;
         END IF;
         IF CUGEOLOCATION%ISOPEN THEN
            CLOSE CUGEOLOCATION;
         END IF;
         IF CUGENERICA%ISOPEN THEN
            CLOSE CUGENERICA;
         END IF;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END OBTENERCOSTOITEMLISTA;
   PROCEDURE OBTORDENESINSP( INUORDERID IN OR_ORDER.ORDER_ID%TYPE, IOTBORDENESINSP IN OUT NOCOPY DAOR_ORDER.TYTBORDER_ID )
    IS
      CURSOR CUORDENESINSP IS
SELECT distinct or_related_order.related_order_id
            FROM   or_related_order,
                   or_order,
                   or_order_status
            WHERE  or_related_order.order_id = inuOrderId
              AND  or_related_order.rela_order_type_id = ge_boconstants.fnuGetTipoTransInsp
              AND  or_related_order.related_order_id = or_order.order_id
              AND  or_order.order_status_id = or_order_status.order_status_id
              AND  or_order_status.is_final_status = ge_boconstants.GetNO;
    BEGIN
      IOTBORDENESINSP.DELETE;
      OPEN CUORDENESINSP;
      FETCH CUORDENESINSP
         BULK COLLECT INTO IOTBORDENESINSP;
      CLOSE CUORDENESINSP;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         IF CUORDENESINSP%ISOPEN THEN
            CLOSE CUORDENESINSP;
         END IF;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         IF CUORDENESINSP%ISOPEN THEN
            CLOSE CUORDENESINSP;
         END IF;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END OBTORDENESINSP;
   FUNCTION FNUOBTACTIVIDADITEM( INUORDERINSPID IN OR_ORDER.ORDER_ID%TYPE )
    RETURN OR_ITEMS_ORDEN_INSPE.ID_ACTIVIDAD%TYPE
    IS
      NUACTIVITYID OR_ITEMS_ORDEN_INSPE.ID_ACTIVIDAD%TYPE;
    BEGIN
      SELECT or_items_orden_inspe.id_actividad
        INTO   nuActivityId
        FROM   or_items_orden_inspe
        WHERE  or_items_orden_inspe.id_orden = inuOrderInspId
          AND  or_items_orden_inspe.id_actividad IS not null
          AND  or_items_orden_inspe.modo_insercion <> CT_BOConstants.fsbgetCertificateInsMode
          AND  rownum = 1;
      RETURN NUACTIVITYID;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RETURN NULL;
      WHEN OTHERS THEN
         RETURN NULL;
   END FNUOBTACTIVIDADITEM;
   PROCEDURE CONSULORDMODIFPORACTFEC( INUIDACTA IN GE_ACTA.ID_ACTA%TYPE, IDTFECHADESDE IN GE_ACTA.FECHA_INICIO%TYPE, IDTFECHAHASTA IN GE_ACTA.FECHA_FIN%TYPE, ORFREFCURSOR OUT CONSTANTS.TYREFCURSOR )
    IS
    BEGIN
      OPEN ORFREFCURSOR FOR WITH OrdenesModificadasEnActa AS
            (
            SELECT /*+index (AU_AUDIT_POLICY_LOG IDX_AU_AUDIT_POLICY_LOG10)*/
                   p.AUDIT_POLICY_LOG_ID AUDIT_POLICY_LOG_ID,
                   to_char(P.CURRENT_DATE, ut_date.fsbTIMESTAMP_FORMAT) FECHA_MODIFICACION,
                   to_number(extractvalue(P.XML_LOG,'/AU_LOG/PREVIOUS_VALUES/MODIFICACIONES/ADICIONALES/ORDER_ID')) ORDER_ID,
                   to_date(extractvalue(P.XML_LOG,'/AU_LOG/PREVIOUS_VALUES/MODIFICACIONES/ADICIONALES/EXECUTION_FINAL_DATE'),ut_date.fsbDATE_FORMAT) FECHA_ORDEN,
                   to_date(extractvalue(P.XML_LOG,'/AU_LOG/PREVIOUS_VALUES/MODIFICACIONES/ADICIONALES/VERIFICATION_DATE'),ut_date.fsbDATE_FORMAT) FECHA_VERIF,
                   extractvalue(P.XML_LOG,'/AU_LOG/PREVIOUS_VALUES/MODIFICACIONES/ADICIONALES/ITEM') ITEM, --Actividad cumplida
                   to_number(extractvalue(P.XML_LOG,'/AU_LOG/PREVIOUS_VALUES/MODIFICACIONES/LEGAL_ITEM_AMOUNT')) CANTIDAD_PREV, --Cantidad Previa
                   to_number(extractvalue(P.XML_LOG,'/AU_LOG/ACTUAL_VALUES/MODIFICACIONES/LEGAL_ITEM_AMOUNT')) CANTIDAD_FINAL, --Cantidad Previa
                   extractvalue(P.XML_LOG,'/AU_LOG/PREVIOUS_VALUES/MODIFICACIONES/ADICIONALES/TASK_TYPE') TASK_TYPE,
                   extractvalue(P.XML_LOG,'/AU_LOG/PREVIOUS_VALUES/MODIFICACIONES/ADICIONALES/CLIENT') CLIENT,
                   P.CURRENT_USER_ID ||' - '|| P.CURRENT_USER_MASK USUARIO
            FROM   AU_AUDIT_POLICY_LOG P
            WHERE
                   p.CURRENT_EVEN_DESC IN ('INSERT','UPDATE','DELETE')
               AND p.CURRENT_TABLE_NAME = 'OR_ORDER_ITEMS'
               AND p.CURRENT_EXEC_ID+0 = 8802
               AND p.CURRENT_EXEC_NAME in ('GECCO','CTCCO')
               AND p.external_id = inuIdActa
               AND p.current_field_name='ID_ACTA'
        )
        SELECT *
        FROM OrdenesModificadasEnActa
        WHERE OrdenesModificadasEnActa.FECHA_ORDEN BETWEEN idtFechaDesde AND idtFechaHasta;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END CONSULORDMODIFPORACTFEC;
   PROCEDURE OBTENERDATOSUNIDADTRABAJO( INUOPERATINGUNITID IN OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE, ONUCONTRACTORID OUT OR_OPERATING_UNIT.CONTRACTOR_ID%TYPE )
    IS
    BEGIN
      IF ( TBCACHEDATOSORDEN.EXISTS( INUOPERATINGUNITID ) ) THEN
         ONUCONTRACTORID := TBCACHEDATOSUNIDADTRABAJO( INUOPERATINGUNITID );
         RETURN;
      END IF;
      SELECT or_operating_unit.contractor_id
        INTO   onuContractorId
        FROM   or_operating_unit
        WHERE  or_operating_unit.operating_unit_id = inuOperatingUnitId;
      TBCACHEDATOSUNIDADTRABAJO( INUOPERATINGUNITID ) := ONUCONTRACTORID;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END OBTENERDATOSUNIDADTRABAJO;
END GE_BCCERTCONTRATISTA;
/


