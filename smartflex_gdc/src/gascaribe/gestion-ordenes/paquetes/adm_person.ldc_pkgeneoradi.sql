CREATE OR REPLACE PACKAGE adm_person.LDC_PKGENEORADI IS
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : 
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    25/06/2024              PAcosta         OSF-2878: Cambio de esquema ADM_PERSON                              
    ****************************************************************/  

 nuOrden              OR_ORDER.ORDER_ID%TYPE; --se almacena orden padre
 nuTipoRelacion       NUMBER; --se almacena el tipo de relacion

 PROCEDURE  PROGENRELACTIAPOYO;
 /**************************************************************************
    Autor       : Elin Alvarez / Horbath
    Fecha       : 2019-11-05
    Ticket      : 200-2391
    Proceso     : PROGENRELACTIAPOYO
    Descripcion : proceso para generar orden de apoyo porceso LDCORADI

    Parametros Entrada

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/

  PROCEDURE  progenActividad
    (
        inuOrdeActiviId     IN  OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        inuActividadApoyo   IN  GE_ITEMS.ITEMS_ID%TYPE,
        inuUnidadOperativa  IN  OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE,
        isbComentarios      IN  OR_ORDER_ACTIVITY.COMMENT_%TYPE,
        ionuOrdenId         IN OUT OR_ORDER.ORDER_ID%TYPE
    );
   /**************************************************************************
      Autor       : Elkin Alvarez
      Fecha       : 2019-11-05
      Ticket      : 200-2391
      Proceso     : progenActividad
      Descripcion : proceso para generar actividad de apoyo

      Parametros Entrada
        inuOrdeActiviId      id de la orden actividad
        inuActividadApoyo    actividad de apoyo
        inuUnidadOperativa   unidad de trabajo
        isbComentarios       comentario de la orden
        ionuOrdenId         codigo de la orden

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/
END LDC_PKGENEORADI;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_PKGENEORADI IS


 PROCEDURE  progenActividad
    (
        inuOrdeActiviId     IN  OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        inuActividadApoyo   IN  GE_ITEMS.ITEMS_ID%TYPE,
        inuUnidadOperativa  IN  OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE,
        isbComentarios      IN  OR_ORDER_ACTIVITY.COMMENT_%TYPE,
        ionuOrdenId         IN OUT OR_ORDER.ORDER_ID%TYPE
    )
    IS
   /**************************************************************************
      Autor       : Elkin Alvarez
      Fecha       : 2019-11-05
      Ticket      : 200-2391
      Proceso     : progenActividad
      Descripcion : proceso para generar actividad de apoyo

      Parametros Entrada
        inuOrdeActiviId      id de la orden actividad
        inuActividadApoyo    actividad de apoyo
        inuUnidadOperativa   unidad de trabajo
        isbComentarios       comentario de la orden
        ionuOrdenId         codigo de la orden

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/
    regOrdenes                 DAOR_ORDER.STYOR_ORDER;
    regOrdenActividadOrigen     DAOR_ORDER_ACTIVITY.STYOR_ORDER_ACTIVITY;
    regOrdenActividadNueva      DAOR_ORDER_ACTIVITY.STYOR_ORDER_ACTIVITY;
    regRelacionOrden     DAOR_RELATED_ORDER.STYOR_RELATED_ORDER; --se almacena registro de relacion

    blaAsignaOrden                BOOLEAN;

    nuProceso         OR_ORDER_ACTIVITY.PROCESS_ID%TYPE:= NULL;
    nuOrdenActivityid  OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE;
    nuOrdenItemId       OR_ORDER_ACTIVITY.ORDER_ITEM_ID%TYPE;

  BEGIN

    UT_TRACE.TRACE('inicio LDC_PKGENEORADI.progenActividad',10);

    regOrdenActividadOrigen := DAOR_ORDER_ACTIVITY.FRCGETRCDATA(inuOrdeActiviId);

    blaAsignaOrden := ionuOrdenId IS NULL;
    --se crea actividad de apoyo
    OR_BOORDERACTIVITIES.CREATEACTIVITY
    (
        inuActividadApoyo,
        regOrdenActividadOrigen.PACKAGE_ID,
        regOrdenActividadOrigen.MOTIVE_ID,
        regOrdenActividadOrigen.COMPONENT_ID,
        regOrdenActividadOrigen.INSTANCE_ID,
        regOrdenActividadOrigen.ADDRESS_ID,
        regOrdenActividadOrigen.ELEMENT_ID,
        regOrdenActividadOrigen.SUBSCRIBER_ID,
        regOrdenActividadOrigen.SUBSCRIPTION_ID,
        regOrdenActividadOrigen.PRODUCT_ID,
        NULL,
        inuUnidadOperativa,
        NULL,
        nuProceso,
        isbComentarios,
        FALSE,
        NULL,
        ionuOrdenId,
        nuOrdenActivityid
    );

    --se crea relacion en or_related_order
    regRelacionOrden.ORDER_ID := nuOrden;
    regRelacionOrden.RELATED_ORDER_ID := ionuOrdenId;


    IF (nuTipoRelacion = 1 ) THEN
        regRelacionOrden.RELA_ORDER_TYPE_ID := OR_BOSUPPORTORDER.FNUGETSUPPORTORDERTYPE;
    ELSE
       regRelacionOrden.RELA_ORDER_TYPE_ID := OR_BOFWORDERRELATED.FNUGETRELATEDORDERTYPE;
    END IF;
    DAOR_RELATED_ORDER.INSRECORD(regRelacionOrden);

    --se crea relacion en or_order_activity
    regOrdenActividadNueva := DAOR_ORDER_ACTIVITY.FRCGETRCDATA(nuOrdenActivityid);

    regOrdenActividadNueva.SEQUENCE_            := regOrdenActividadOrigen.SEQUENCE_;
    regOrdenActividadNueva.ORIGIN_ACTIVITY_ID   := regOrdenActividadOrigen.ORDER_ACTIVITY_ID;
    regOrdenActividadNueva.ACTIVITY_GROUP_ID    := regOrdenActividadOrigen.ACTIVITY_GROUP_ID;

    DAOR_ORDER_ACTIVITY.UPDRECORD(regOrdenActividadNueva);


    IF OR_BOORDERACTIVITIES.SBUPDATEORDER != GE_BOCONSTANTS.CSBNO THEN
         IF(regOrdenActividadOrigen.ORDER_ID != ionuOrdenId AND inuUnidadOperativa IS NOT NULL) THEN
            IF(DAOR_ORDER.FNUGETORDER_STATUS_ID(ionuOrdenId) = OR_BOCONSTANTS.CNUORDER_STAT_REGISTERED AND blaAsignaOrden) THEN
               UT_TRACE.TRACE('inicio OR_BOProcessOrder.ProcessOrder orden '||ionuOrdenId||' unidad '||inuUnidadOperativa,10);
               OR_BOPROCESSORDER.PROCESSORDER(
                    ionuOrdenId,
                    NULL,
                    inuUnidadOperativa
               );
            END IF;
        ELSE
            UT_TRACE.TRACE('Asigna Numerador y secuencia',10);
            regOrdenes := DAOR_ORDER.FRCGETRECORD(ionuOrdenId);
            OR_BOORDERNUMERATOR.SETORDERNUMBER(regOrdenes);
            DAOR_ORDER.UPDRECORD(regOrdenes);
        END IF;
    END IF;

    UT_TRACE.TRACE('Fin  LDC_PKGENEORADI.progenActividad',10);
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
        RAISE;

    WHEN OTHERS THEN
        ERRORS.SETERROR;
        RAISE EX.CONTROLLED_ERROR;
  END progenActividad;
 PROCEDURE  PROGENRELACTIAPOYO IS
 /**************************************************************************
    Autor       : Elkin Alvarez
    Fecha       : 2019-11-05
    Ticket      : 200-2391
    Proceso     : PROGENRELACTIAPOYO
    Descripcion : proceso para generar orden de apoyo porceso LDCORADI

    Parametros Entrada

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/
    cnuErrorCrearOrden CONSTANT GE_ERROR_LOG.ERROR_LOG_ID%TYPE := 1964 ;


    sbComentario         VARCHAR2(4000); --se almacena comentario
    nuOrdeActividadid    OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE; --codigo de id de orden activity

    regOrden             DAOR_ORDER.STYOR_ORDER; --se almacenaregistro de orden
    nuNuevaOrden         OR_ORDER.ORDER_ID%TYPE; --se almacena codigo de la nueva orden

    nuItems              OR_ORDER_ITEMS.ITEMS_ID%TYPE; --se almacena codigo de la actividad
    nuUnidadOperativa    OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE;-- se almacena codigo de la unidad operativa

    tbActividades        OR_BCORDERACTIVITIES.TYTBORDERACTIVITIES; --se almacena tabla de items
    nuIndex              NUMBER; --se almacena codigo de index
    regItems             DAGE_ITEMS.STYGE_ITEMS; -- se alamcena tabla de actividades


 BEGIN
    --se consultan datos de entrada
    nuTipoRelacion           := TO_NUMBER(GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ('OR_ORDER_ACTIVITY', 'OPERATING_UNIT_ID'));
    nuOrdeActividadid       := TO_NUMBER(GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ('OR_ORDER_ACTIVITY', 'ACTIVITY_ID'));
    nuUnidadOperativa         := TO_NUMBER(GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ('OR_OPERATING_UNIT', 'NAME'));
    nuItems               := TO_NUMBER(GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ('GE_ITEMS', 'ITEMS_ID'));
    sbComentario              := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ('OR_ORDER_ACTIVITY', 'COMMENT_');

    --se obtiene orden padre
    GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE,NULL,'OR_ORDER', 'ORDER_ID', nuOrden);
    OR_BCORDERACTIVITIES.GETACTIVITIESBYORDER(nuOrden,tbActividades); --se obtiene las actividad de la orden
    --se recorren las activiidades de la orden padre
    nuIndex := tbActividades.FIRST;
     LOOP
          EXIT WHEN nuIndex IS NULL;
            IF tbActividades(nuIndex).NUPROCESSID = OR_BOCONSTANTS.CNUPROCESS_DAMAGES THEN
              regItems := DAGE_ITEMS.FRCGETRECORD(tbActividades(nuIndex).NUACTIVITYID);
              IF regItems.USE_ IN (OR_BOCONSTANTS.CSBDIAGNOSTICUSE,OR_BOCONSTANTS.CSBCLIENT_MAINTENA_USE) THEN
                  GE_BOERRORS.SETERRORCODE(cnuErrorCrearOrden);
              END IF;
          END IF;
          nuIndex := tbActividades.NEXT(nuIndex);
      END LOOP;

       regOrden := DAOR_ORDER.FRCGETRECORD(nuOrden);
      IF NOT OR_BOPROCESSORDER.FBLISORDERALTERABLEBYRELATED(regOrden) THEN
          GE_BOERRORS.SETERRORCODE(OR_BOCONSTANTS.CNUERR_122462);
      END IF;

      OR_BCORDERPROCESS.LOCKORDER(nuOrden);

      progenActividad
      (
          nuOrdeActividadid,
          nuItems,
          nuUnidadOperativa,
          sbComentario,
          nuNuevaOrden
      );

       COMMIT;

  EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
          ROLLBACK;
          RAISE;

      WHEN OTHERS THEN
          ROLLBACK;
          ERRORS.SETERROR;
          RAISE EX.CONTROLLED_ERROR;
 END PROGENRELACTIAPOYO;


END LDC_PKGENEORADI;
/
PROMPT Otorgando permisos de ejecucion a LDC_PKGENEORADI
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PKGENEORADI', 'ADM_PERSON');
END;
/
