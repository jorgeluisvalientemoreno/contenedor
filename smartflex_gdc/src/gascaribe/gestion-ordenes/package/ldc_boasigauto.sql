CREATE OR REPLACE PACKAGE LDC_BOASIGAUTO IS

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE PETI (C).

  UNIDAD : OPEN.LDC_BOASIGAUTO
     DESCRIPCION    : PAQUETE QUE CONTIENE TODOS LOS PROCESO DE
                      ASIGNACION AUTOMATICA.
     AUTOR          : JORGE VALIENTE
     FECHA          : 12/11/2013

     HISTORIA DE MODIFICACIONES
     FECHA             AUTOR             MODIFICACION
     =========         =========         ====================
     17-11-2020         Horbath          CA272: Se modifica PRASIGNACION
   ******************************************************************/

  ---Inicio Variables
  BLBSS_FACT_LJLB_2001377 boolean := FALSE;
  BLOSS_RP_OOP_200304_1   boolean := FALSE;
  SBLOG_ASIGNACION_CONTROL VARCHAR2(1) := NVL(OPEN.DALD_PARAMETER.fsbGetValue_Chain('LOG_ASIGNACION_CONTROL', NULL), 'N');
  SBCOD_TIPO_SOL_ASIG      ld_parameter.value_chain%type;

  BLBSS_FACT_LJLB_0000158 boolean := FALSE;
  sbBLBSS_FACT_LJLB_0000158 varchar2(1) := 'N';

  ---Fin Variables

  -- Inicio tabla tipo trabajo / tipo servicio
  TYPE rcTipoTrab IS RECORD(
    tipotrab number,
    tipoprod NUMBER);

  TYPE tbTipoTrab IS TABLE OF rcTipoTrab INDEX BY binary_integer;
  tTipoTrab tbTipoTrab;
  nuIndTT binary_integer;


  /*****************************************************************
  PROPIEDAD INTELECTUAL DE PETI (C).

  UNIDAD         : PRINTENTOSASIGNACION
  DESCRIPCION    : PROCESO QUE PERMITIRA REGISTRAR LOS
                   INTENTOS DE ASIGNACION DE UNIDAD OPERTAIVA
                   A UNA ORDEN.
  AUTOR          : JORGE VALIENTE
  FECHA          : 06/03/2014

  PARAMETROS              DESCRIPCION
  ============         ===================
  NUPACKAGE_ID         CODIGO DE LA SOLICITUD
  NUORDER_ID           CODIGO DEL AORDEN

  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PRINTENTOSASIGNACION(NUPACKAGE_ID MO_PACKAGES.PACKAGE_ID%TYPE,
                                 NUORDER_ID   OR_ORDER.ORDER_ID%TYPE);

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE PETI (C).

  UNIDAD         : PRREGSITROASIGAUTO
  DESCRIPCION    : PROCESO QUE PERMITIRA REGISTRAR LAS
                   INCONSITENCIAS GENERADAS POR LA
                   ASIGNACION AUTOMATICA.
  AUTOR          : JORGE VALIENTE
  FECHA          : 14/11/2013

  PARAMETROS              DESCRIPCION
  ============         ===================
  NUPACKAGE_ID         CODIGO DE LA SOLICITUD
  NUORDER_ID           CODIGO DEL AORDEN
  SBINCONSISTENCIA     MOTIVO POR EL CUAL NO SE REALIZO
                       LA ASIGNACION AUTOMATICA

  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PRREGSITROASIGAUTO(NUPACKAGE_ID     MO_PACKAGES.PACKAGE_ID%TYPE,
                               NUORDER_ID       OR_ORDER.ORDER_ID%TYPE,
                               SBINCONSISTENCIA VARCHAR2);

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE PETI (C).

  UNIDAD         : PRREGSITROASIGAUTOLOG
  DESCRIPCION    : PROCESO QUE PERMITIRA REGISTRAR LAS
                   INCONSITENCIAS GENERADAS POR LA
                   ASIGNACION AUTOMATICA.
                   CONTROLANDO EL REGSITRO MEDIANTE UN PARAMETRO
  AUTOR          : JORGE VALIENTE
  FECHA          : 14/11/2013

  PARAMETROS              DESCRIPCION
  ============         ===================
  NUPACKAGE_ID         CODIGO DE LA SOLICITUD
  NUORDER_ID           CODIGO DEL AORDEN
  SBINCONSISTENCIA     MOTIVO POR EL CUAL NO SE REALIZO
                       LA ASIGNACION AUTOMATICA

  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PRREGSITROASIGAUTOLOG(NUPACKAGE_ID     MO_PACKAGES.PACKAGE_ID%TYPE,
                                  NUORDER_ID       OR_ORDER.ORDER_ID%TYPE,
                                  SBINCONSISTENCIA VARCHAR2);




  /*****************************************************************
  PROPIEDAD INTELECTUAL DE PETI (C).

  UNIDAD         : FSBPUNTOATENCION
  DESCRIPCION    : PROCESO QUE PERMITE ASIGNAR A LA ORDENE
                   LA UNIDAD OPERATIVA DEFINIDA EN EL PUNTO DE
                   DE LA SOLICITUD CREADA EN SMARTFLEX.

  AUTOR          : JORGE VALIENTE
  FECHA          : 10/12/2013

  PARAMETROS              DESCRIPCION
  ============         ===================
  ISBIN               VALORES EN UNA CADENA

  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FSBPUNTOATENCION(SBIN IN VARCHAR2) RETURN NUMBER;




  /*****************************************************************
  PROPIEDAD INTELECTUAL DE PETI (C).

  UNIDAD         : PRASIGNACION
  DESCRIPCION    : PROCESO QUE PERMITIRA ASIGNAR A LA ORDEN
                   LA UNIDAD OPERATIVA DEFINIDA EN POR UOBYSOL.
                   ESTE SERVICIO FUE CREADO POR LA ANULACION DE LA
                   LOGICA DE ASIGNACION AUTOMATICA YA QUE LOS PROCESOS
                   DE MANEJO DE ORDENES DE OPEN EN SMARTFLEX
                   NO PERMITE TENER TRIGGERS QUE PERMITAN REALIZAR
                   DE FORMA AUTOAMTICA EL PROCESO DE ASIGNACIO.
  AUTOR          : JORGE VALIENTE
  FECHA          : 06/03/2014

  PARAMETROS              DESCRIPCION
  ============         ===================
  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE PRASIGNACION(inuOrden or_order.order_id%TYPE DEFAULT NULL);

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE PETI (C).

  UNIDAD         : FSBMULTIFAMILIAR
  DESCRIPCION    : PROCESO QUE OBTIENE LAS UNIDADES OPERATIVAS
                   PARA ATENDER LA ORDEN DE VISITA PARA PREDIOS MULTIFAMILIARES

  AUTOR          : LLOZADA
  FECHA          : 17/06/2014

  PARAMETROS              DESCRIPCION
  ============         ===================
   ISBIN               VALORES EN UNA CADENA

  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  17/06/2014      llozada             Creaci?n.
  ******************************************************************/
  FUNCTION FSBMULTIFAMILIAR(SBIN IN VARCHAR2) RETURN VARCHAR2;



  /*****************************************************************
  PROPIEDAD INTELECTUAL DE PETI (C).

  UNIDAD         : FSBASIGOTACTSECTOR
  DESCRIPCION    : El servicio actualiza el sector operativo de la orden
                   solo si este es el sector operativo 1 y lo actualiza
                   con el sector operativo de la direcci?n que tenga el
                   cliente siempre y cuando este tenga direcci?n de lo
                   contrario no asignara la ot, ni actualiza el sector
                   en la ot.  NOTA: El cursor que busca la unidad de
                   trabajo lo hace para unidades de trabajo de tipo
                   Capacidad Horaria, si las unidades de trabajo son por
                   Horario hay que modificar un poco el cursor para obtener
                   la ut que va asignar

  AUTOR          : Lizeth Sanchez
  FECHA          : 18/12/2014

  PARAMETROS              DESCRIPCION
  ============         ===================
  ISBIN               VALORES EN UNA CADENA

  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  ******************************************************************/

  FUNCTION FSBASIGOTACTSECTOR(SBIN IN VARCHAR2) RETURN NUMBER;
  

    /*****************************************************************
    UNIDAD         : PROINIT
    DESCRIPCION    : PROCESO QUE INICIALIZA VARIBALES.
    AUTOR          : JORGE VALIENTE
    FECHA          : 06/03/2014

    PARAMETROS              DESCRIPCION
    ============         ===================
    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    ******************************************************************/
    PROCEDURE PROINIT;

    /*****************************************************************
    UNIDAD         : PRMANTENIMIENTOLDCORDER
    DESCRIPCION    : PROCESO PARA ELIMINAR REGISTROS DE ORDENES YA ASIGNADAS
                     EN EL PROCESO DE ASIGNACION AUTOMATICA.
    AUTOR          : JORGE VALIENTE
    FECHA          : 06/03/2014

    PARAMETROS              DESCRIPCION
    ============         ===================
    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    ******************************************************************/

    /*****************************************************************
    UNIDAD         : FNUGETCATE
    DESCRIPCION    : PROCESO QUE BUSCA LA CATEGORIA
    AUTOR          : HB
    FECHA          : 12/09/2019

    PARAMETROS              DESCRIPCION
    ============         ===================
    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    ******************************************************************/
    FUNCTION FNUGETCATE (inucont servsusc.sesususc%type,
                           inuprod servsusc.sesunuse%type,
                           inutitr or_order.task_type_id%type,
                           inuAdress pr_product.address_id%type) return number;

    PROCEDURE PRMANTENIMIENTOLDCORDER;

    /*****************************************************************
    UNIDAD         : PRMANTENIMIENTOLOG
    DESCRIPCION    : PROCESO PARA ELIMINAR TODOS LOS REGISTROS LOG GENERADOS
                     EN EL ENTIDAD LDC_ORDSINASIGAUT ESTO CON EL FIN QUE LA
                     TAREA PROGRAMADA QUE SEA UTILIZADA PARA EJECUTAR ESTE SERVICIO
                     SEA PROGRAMADA CADA FIN DE SEMANA O CADA 15 DIAS PARA
                     DEJAR LA ENTIDAD DESDE 0 PARA REGISTRA NUEVOS LOG EN UN
                     DETERMINADO PERIODO DE TIEMPO
    AUTOR          : JORGE VALIENTE
    FECHA          : 06/03/2014

    PARAMETROS              DESCRIPCION
    ============         ===================
    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    ******************************************************************/
    PROCEDURE PRMANTENIMIENTOLOG;
    ----Fin CASO 200-2067
    PROCEDURE ASIGNACION(inuOrden   in or_order.order_id%TYPE,
                      inuUnidad  in open.or_operating_unit.operating_unit_id%type,
                      onuError   out number,
                      osbMensaje out varchar2);
        /*****************************************************************
    UNIDAD         : ASIGNACION
    DESCRIPCION    : PROCESO PARA ASIGNAR ORDENES
    AUTOR          : DSALTARIN
    FECHA          : 09/12/2020

    PARAMETROS              DESCRIPCION
    ============         ===================
    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    ******************************************************************/
    PROCEDURE ACTUALIZA_SECTOR(inuOrden   in or_order.order_id%TYPE,
                               inuSector  in or_order.operating_sector_id%TYPE);
    /*****************************************************************
    UNIDAD         : ACTUALIZA_SECTOR
    DESCRIPCION    : PROCESO PARA ACTUALIZAR SECTOR DE UNA ORDEN
    AUTOR          : DSALTARIN
    FECHA          : 09/12/2020

    PARAMETROS              DESCRIPCION
    ============         ===================
    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    ******************************************************************/

     PROCEDURE ACTUALIZA_MENSAJE(inuOrden   in or_order.order_id%TYPE,
                                 inuPackage in mo_packages.package_id%TYPE,
                                 sbMensaje  in varchar2);
    /*****************************************************************
    UNIDAD         : ACTUALIZA_MENSAJE
    DESCRIPCION    : PROCESO PARA ACTUALIZAR MENSAJE DE ERROR
    AUTOR          : DSALTARIN
    FECHA          : 09/12/2020

    PARAMETROS              DESCRIPCION
    ============         ===================
    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    ******************************************************************/
END LDC_BOASIGAUTO;
/
CREATE OR REPLACE PACKAGE BODY LDC_BOASIGAUTO IS

    /*****************************************************************
    PROPIEDAD INTELECTUAL DE PETI (C).

    UNIDAD : OPEN.LDC_BOASIGAUTO
       DESCRIPCION    : PAQUETE QUE CONTIENE TODOS LOS PROCESO DE
                        ASIGNACION AUTOMATICA.
       AUTOR          : JORGE VALIENTE
       FECHA          : 12/11/2013

       HISTORIA DE MODIFICACIONES
       FECHA             AUTOR             MODIFICACION
       =========         =========         ====================
       17-11-2020         Horbath          CA272: Se modifica PRASIGNACION
     ******************************************************************/


    -- Version del paquete
    csbVersion              CONSTANT VARCHAR2(15) := 'OSF-4137';
    -- Para el control de traza:
    csbSP_NAME              CONSTANT VARCHAR2(32) := $$PLSQL_UNIT;
    csbNivelTraza           CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;     

    /*****************************************************************
    PROPIEDAD INTELECTUAL DE PETI (C).

    UNIDAD         : PRINTENTOSASIGNACION
    DESCRIPCION    : PROCESO QUE PERMITIRA REGISTRAR LOS
                     INTENTOS DE ASIGNACION DE UNIDAD OPERTAIVA
                     A UNA ORDEN.
    AUTOR          : JORGE VALIENTE
    FECHA          : 06/03/2014

    PARAMETROS              DESCRIPCION
    ============         ===================
    NUPACKAGE_ID         CODIGO DE LA SOLICITUD
    NUORDER_ID           CODIGO DEL AORDEN

    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    ******************************************************************/
    PROCEDURE PRINTENTOSASIGNACION(NUPACKAGE_ID MO_PACKAGES.PACKAGE_ID%TYPE,
                                   NUORDER_ID   OR_ORDER.ORDER_ID%TYPE) IS

        ONUERRORCODE    NUMBER;
        OSBERRORMESSAGE VARCHAR2(4000);
        --TICKET 2001377 LJLB -- se consulta si el registro esta para bloqueo
        CURSOR  cubloqueo IS
        SELECT 'X'
        FROM  LDC_ORDER
        WHERE NVL(PACKAGE_ID, 0) = NVL(NUPACKAGE_ID, 0)
        AND    ORDER_ID = NUORDER_ID
        AND  (NVL(ASIGNACION, 0) + 1) > dald_parameter.fnuGetNumeric_Value('CANTIDAD_INTENTOS_ASIGNACION');

        sbDato VARCHAR2(1); --TICKET 2001377 LJLB -- se almacena valor del cursor anterior
    BEGIN

         --TICKET 200-1377 LJLB -- se consulta si aplica la entrega en la gasera
        IF BLBSS_FACT_LJLB_2001377 THEN
        --IF fblaplicaentrega('BSS_FACT_LJLB_2001377_1') THEN
          OPEN cubloqueo;
          FETCH cubloqueo INTO sbDato;
          CLOSE cubloqueo;

        END IF;

        IF sbDato IS NOT NULL THEN
            UPDATE LDC_ORDER
            SET    ASIGNACION = NVL(ASIGNACION, 0) + 1, ORDEFEBL = SYSDATE
            WHERE  NVL(PACKAGE_ID, 0) = NVL(NUPACKAGE_ID, 0)
            AND    ORDER_ID = NUORDER_ID;
         ELSE
            UPDATE LDC_ORDER
            SET    ASIGNACION = NVL(ASIGNACION, 0) + 1
            WHERE  NVL(PACKAGE_ID, 0) = NVL(NUPACKAGE_ID, 0)
            AND    ORDER_ID = NUORDER_ID;

         END IF;
    EXCEPTION

        WHEN OTHERS THEN
            ONUERRORCODE    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            OSBERRORMESSAGE := 'INCONVENIENTES AL ASIGNAR LA UNIDAD OPERTAIVA DE SOLICUTD INMEDIATA A LAS ORDENES GENERADAS POR DEFECTO DE REPARACION PERIODICA' ||
                               PKERRORS.FSBGETERRORMESSAGE;
    END PRINTENTOSASIGNACION;

    PROCEDURE PRRESEINTEOR IS
      /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 04-07-2017
      Ticket      : 200-1377
      Descripcion : Proceso para resetear valores de intentos

      Parametros Entrada

      Valor de salida


      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    --TICKET 2001377 LJLB -- se consulta ordenes
    CURSOR cuOrdenes IS
    SELECT lo.ORDER_ID orden,
            lo.package_id paquete
    FROM   LDC_ORDER LO, or_order o
    WHERE LO.ASIGNADO = 'N'
     AND o.order_id = lo.order_id
     AND o.ORDER_STATUS_ID IN (0,1)
     AND nvl(asignacion, 0) >  dald_parameter.fnuGetNumeric_Value('CANTIDAD_INTENTOS_ASIGNACION')
     AND ROUND( (SYSDATE - ORDEFEBL ) * 1440, 0) > dald_parameter.fnuGetNumeric_Value('LDC_TIEMPO_RESTINTE');
     --TICKET 2001377 LJLB -- registro de ordenes
     TYPE regDatos IS RECORD ( nuOrden LDC_ORDER.ORDER_ID%TYPE,
                               nuSolicitud LDC_ORDER.package_id%TYPE);

     TYPE tbOrdenes IS TABLE OF regDatos INDEX BY PLS_INTEGER; --TICKET 2001377 LJLB -- tabla de ordenes
     vtbOrdenes tbOrdenes;

     inLimit NUMBER := 100; --TICKET 2001377 LJLB -- cantidad de registros a proesar

    BEGIN
       --TICKET 2001377 LJLB -- se procesan los registros bloqueados
       OPEN cuOrdenes;
       LOOP
        FETCH cuOrdenes BULK COLLECT INTO vtbOrdenes LIMIT inLimit;
         FOR idx IN 1..vtbOrdenes.COUNT LOOP
           UPDATE LDC_ORDER
                 SET asignacion = 0, ORDEFEBL = NULL
            WHERE order_id = vtbOrdenes(idx).nuOrden AND
                NVL(package_id, 0) = NVL(vtbOrdenes(idx).nuSolicitud, 0);
         END LOOP;
        EXIT WHEN cuOrdenes%NOTFOUND;
       END LOOP;
        commit;
    EXCEPTION
     WHEN OTHERS THEN
       rollback;
       DBMS_OUTPUT.PUT_LINE('ERROR NO CONTROLADO '||SQLERRM);
    END PRRESEINTEOR;

    PROCEDURE proRegistraLogAsig( nuOrden       IN or_order.order_id%TYPE,
                                  nuSolicitud   IN mo_packages.package_id%TYPE,
                                  sbError       IN VARCHAR2) IS
    /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 04-07-2017
      Ticket      : 200-1377
      Descripcion : Proceso para insertar log en la tabla LDC_ORDER

      Parametros Entrada

      nuOrden numero de orden.
      nuSolicitud  numero de solicitud.
      sbError  error a actualizar

      Valor de salida


      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
      sbErrorInt VARCHAR2(4000);

      CURSOR cuOrdenes is
      select 'X'
      FROM or_order
      where order_id = nuOrden and order_status_id = 5;

      sbDato varchar2(1);

    BEGIN

     open cuOrdenes;
     fetch cuOrdenes into sbDato;
     close cuOrdenes;

     IF sbError IS NOT NULL and sbDato is null THEN
       UPDATE LDC_ORDER SET ORDEOBSE = sbError, ORDEFERE = SYSDATE
       WHERE ORDER_ID = nuOrden AND NVL(PACKAGE_ID,0) = NVL(nuSolicitud,0);
     ELSE
       UPDATE LDC_ORDER SET ORDEOBSE = sbError, ORDEFERE = NULL
       WHERE ORDER_ID = nuOrden AND NVL(PACKAGE_ID,0) = NVL(nuSolicitud,0);
     END IF;

    EXCEPTION
      WHEN OTHERS THEN
           sbErrorInt :=  'Error no Controlado en proRegistraLogAsig '||sqlerrm;
           UPDATE LDC_ORDER SET ORDEOBSE = sbErrorInt, ORDEFERE = SYSDATE
           WHERE ORDER_ID = nuOrden AND PACKAGE_ID = nuSolicitud;
    END proRegistraLogAsig;

    /*****************************************************************
    PROPIEDAD INTELECTUAL DE PETI (C).

    UNIDAD         : PRREGSITROASIGAUTO
    DESCRIPCION    : PROCESO QUE PERMITIRA REGISTRAR LAS
                     INCONSITENCIAS GENERADAS POR LA
                     ASIGNACION AUTOMATICA.
    AUTOR          : JORGE VALIENTE
    FECHA          : 14/11/2013

    PARAMETROS              DESCRIPCION
    ============         ===================
    NUPACKAGE_ID         CODIGO DE LA SOLICITUD
    NUORDER_ID           CODIGO DEL AORDEN
    SBINCONSISTENCIA     MOTIVO POR EL CUAL NO SE REALIZO
                         LA ASIGNACION AUTOMATICA

    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    ******************************************************************/
    PROCEDURE PRREGSITROASIGAUTO(NUPACKAGE_ID     MO_PACKAGES.PACKAGE_ID%TYPE,
                                 NUORDER_ID       OR_ORDER.ORDER_ID%TYPE,
                                 SBINCONSISTENCIA VARCHAR2) IS

        ONUERRORCODE    NUMBER;
        OSBERRORMESSAGE VARCHAR2(4000);

    BEGIN

        INSERT INTO LDC_ORDSINASIGAUT
            (PACKAGE_ID,
             ORDER_ID,
             CREATED_DATE,
             INCONSISTENCIA)
        VALUES
            (NUPACKAGE_ID,
             NUORDER_ID,
             SYSDATE,
             SBINCONSISTENCIA);

        --COMMIT;

    EXCEPTION

        WHEN OTHERS THEN
            ONUERRORCODE    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            OSBERRORMESSAGE := 'INCONVENIENTES AL ASIGNAR LA UNIDAD OPERTAIVA DE SOLICUTD INMEDIATA A LAS ORDENES GENERADAS POR DEFECTO DE REPARACION PERIODICA' ||
                               PKERRORS.FSBGETERRORMESSAGE;
    END PRREGSITROASIGAUTO;

    /*****************************************************************
    PROPIEDAD INTELECTUAL DE PETI (C).

    UNIDAD         : PRREGSITROASIGAUTOLOG
    DESCRIPCION    : PROCESO QUE PERMITIRA REGISTRAR LAS
                     INCONSITENCIAS GENERADAS POR LA
                     ASIGNACION AUTOMATICA.
                     CONTROLANDO EL REGSITRO MEDIANTE UN PARAMETRO
    AUTOR          : JORGE VALIENTE
    FECHA          : 14/11/2013

    PARAMETROS              DESCRIPCION
    ============         ===================
    NUPACKAGE_ID         CODIGO DE LA SOLICITUD
    NUORDER_ID           CODIGO DEL AORDEN
    SBINCONSISTENCIA     MOTIVO POR EL CUAL NO SE REALIZO
                         LA ASIGNACION AUTOMATICA

    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    ******************************************************************/
    PROCEDURE PRREGSITROASIGAUTOLOG(NUPACKAGE_ID     MO_PACKAGES.PACKAGE_ID%TYPE,
                                    NUORDER_ID       OR_ORDER.ORDER_ID%TYPE,
                                    SBINCONSISTENCIA VARCHAR2) IS

        ONUERRORCODE    NUMBER;
        OSBERRORMESSAGE VARCHAR2(4000);

    BEGIN

        IF SBLOG_ASIGNACION_CONTROL = 'S' THEN
        --IF NVL(OPEN.DALD_PARAMETER.fsbGetValue_Chain('LOG_ASIGNACION_CONTROL', NULL), 'N') = 'S' THEN

            INSERT INTO LDC_ORDSINASIGAUT
                (PACKAGE_ID,
                 ORDER_ID,
                 CREATED_DATE,
                 INCONSISTENCIA)
            VALUES
                (NUPACKAGE_ID,
                 NUORDER_ID,
                 SYSDATE,
                 SBINCONSISTENCIA);

            COMMIT;

        END IF;

    EXCEPTION

        WHEN OTHERS THEN
            ONUERRORCODE    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            OSBERRORMESSAGE := 'INCONVENIENTES AL ASIGNAR LA UNIDAD OPERTAIVA DE SOLICUTD INMEDIATA A LAS ORDENES GENERADAS POR DEFECTO DE REPARACION PERIODICA' ||
                               PKERRORS.FSBGETERRORMESSAGE;
    END PRREGSITROASIGAUTOLOG;

    /*****************************************************************
    PROPIEDAD INTELECTUAL DE PETI (C).

    UNIDAD         : FSBPUNTOATENCION
    DESCRIPCION    : PROCESO QUE PERMITE ASIGNAR A LA ORDENE
                     LA UNIDAD OPERATIVA DEFINIDA EN EL PUNTO DE
                     DE LA SOLICITUD CREADA EN SMARTFLEX.

    AUTOR          : JORGE VALIENTE
    FECHA          : 10/12/2013

    PARAMETROS              DESCRIPCION
    ============         ===================
    ISBIN               VALORES EN UNA CADENA

    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    ******************************************************************/
    FUNCTION FSBPUNTOATENCION(SBIN IN VARCHAR2) RETURN NUMBER IS
        --PRAGMA AUTONOMOUS_TRANSACTION;
        --LA CADENA SBIN INGRESA CON LOSISGUIENTES DATOS
        --Y EN EL SIGUIENTE ORDEN
        --CODIGO DE LA ORDEN
        --CODIGO DE LA SOLICITUD
        --CODIGO DE LA ACTIVIDAD
        --CODIGO DEL CONTRATO
        csbMetodo       CONSTANT VARCHAR2(100)              := csbSP_NAME ||  '.FSBPUNTOATENCION';
        nuOrden         or_order.order_id%TYPE              := NULL;
        nuSolicitud     mo_packages.package_id%TYPE         := NULL;
        nuActividad     or_order_activity.activity_id%TYPE  := NULL;
        nuContrato      suscripc.susccodi%TYPE              := NULL;

        rcParametros    pkg_boasignacionuobysol.TYTRCPARAMETROS;
        
        
        --CON ESTA ORDEN SE SABE EN EL CICLO QUE DATO VA
        --EN SECUENCIA PARA SABER CUAL DE LOS DATOS UTILIZAR
        ----------------------------------------------------

        onuCodigoError      NUMBER;
        osbMensajeError     VARCHAR2(4000);

        nuUnidadOperativa   or_order.operating_unit_id%TYPE;


        --CUROSR PARA OBTENER EL PUNTO DE ATENCION
        --DE LA SOLICITUD.
        CURSOR CUUNIDADOPERATIVA(NUPACKAGE_ID MO_PACKAGES.PACKAGE_ID%TYPE) IS
            SELECT TARGET_VALUE
            FROM   GE_EQUIVALENC_VALUES,
                   MO_PACKAGES MP
            WHERE  MP.PACKAGE_ID = NUPACKAGE_ID
            AND    MP.SALE_CHANNEL_ID = TO_NUMBER(ORIGIN_VALUE)
            AND    EQUIVALENCE_SET_ID = 7;

        TEMPCUUNIDADOPERATIVA CUUNIDADOPERATIVA%ROWTYPE;
        

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);


        rcParametros        := pkg_boasignacionuobysol.frcObtParametros(SBIN);

        nuOrden             := rcParametros.nuOrdenId;
        pkg_Traza.trace('nuOrden: ' ||nuOrden,csbNivelTraza);

        nuSolicitud         := rcParametros.nuSolicitudId;
        pkg_Traza.trace('nuSolicitud: ' ||nuSolicitud,csbNivelTraza);

        nuActividad         := rcParametros.nuActividadId;
        pkg_Traza.trace('nuActividad: ' ||nuActividad,csbNivelTraza);

        nuContrato          := rcParametros.nuContratoId;
        pkg_Traza.trace('nuContrato: ' ||nuContrato,csbNivelTraza);

        nuUnidadOperativa   := -1;
        

        OPEN CUUNIDADOPERATIVA(nuSolicitud);
        FETCH CUUNIDADOPERATIVA
            INTO TEMPCUUNIDADOPERATIVA;
        IF CUUNIDADOPERATIVA%FOUND THEN
            nuUnidadOperativa := TO_NUMBER(TEMPCUUNIDADOPERATIVA.TARGET_VALUE);
            pkg_Traza.trace('nuUnidadOperativa: ' ||nuUnidadOperativa,csbNivelTraza);
            BEGIN

                api_assign_order(nuOrden,
                                nuUnidadOperativa,
                                onuCodigoError,
                                osbMensajeError);
                
                pkg_Traza.trace('onuCodigoError: '  ||onuCodigoError,csbNivelTraza);
                pkg_Traza.trace('osbMensajeError: ' ||osbMensajeError,csbNivelTraza);

                IF onuCodigoError = 0 THEN
                    pkg_orden_uobysol.prcEliminarOrden(nuOrden);
                ELSE
                    LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(nuSolicitud,
                                                         nuOrden,
                                                         'LA UNIDAD OPERATIVA NO FUE ASIGNADA A LA UNIDAD OPERATIVA [' ||
                                                         nuUnidadOperativa ||
                                                         '] - MENSAJE DE ERROR PROVENIENTE DE os_assign_order --> ' ||
                                                         osbMensajeError);
                    

                END IF;

            EXCEPTION
                WHEN OTHERS THEN
                    osbMensajeError := 'INCONSISTENCIA TRIGGER TRGAFTERASIGAUTO [' ||
                                       DBMS_UTILITY.FORMAT_ERROR_STACK || '] - [' ||
                                       DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

                    LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(nuSolicitud,
                                                         nuOrden,
                                                         'INCONVENIENTES AL INSERTAR LA ORDEN EN TEMPORAL OR_ORDER_1 CON LA UNIDAD DE TRABAJO [' ||
                                                         nuUnidadOperativa || '] - MENSAJE [' ||
                                                         osbMensajeError || ']');
            END;
            --*/
        ELSE
            nuUnidadOperativa := -1;
            pkg_Traza.trace('nuUnidadOperativa: ' ||nuUnidadOperativa,csbNivelTraza);
            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(nuSolicitud,
                                                 nuOrden,
                                                 'NO EXISTE UNIDAD OPERATIVA CONFIGURADA EN EL GRUPO DE EQUIVALENCIA PARA EL PUNTO A TENCION DE LA SOLICITUD [LDC_BOASIGAUTO.FSBPUNTOATENCION - CUUNIDADOPERATIVA].');

        END IF;
        CLOSE CUUNIDADOPERATIVA;

       pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN(nuUnidadOperativa);

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            --ROLLBACK;
            onuCodigoError    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            osbMensajeError := 'INCONVENIENTES AL ASIGNAR LA UNIDAD OPERTAIVA DE SOLICUTD INMEDIATA A LAS ORDENES GENERADAS POR DEFECTO DE REPARACION PERIODICA' ||
                               PKERRORS.FSBGETERRORMESSAGE;
            osbMensajeError := osbMensajeError || ' - [' || DBMS_UTILITY.FORMAT_ERROR_STACK ||
                               ' - [' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RETURN(-1);

        WHEN OTHERS THEN
            --ROLLBACK;
            onuCodigoError    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            osbMensajeError := 'INCONVENIENTES AL ASIGNAR LA UNIDAD OPERTAIVA DE SOLICUTD INMEDIATA A LAS ORDENES GENERADAS POR DEFECTO DE REPARACION PERIODICA' ||
                               PKERRORS.FSBGETERRORMESSAGE;
            osbMensajeError := osbMensajeError || ' - [' || DBMS_UTILITY.FORMAT_ERROR_STACK ||
                               ' - [' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';
            
            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(nuSolicitud,
                                                 nuOrden,
                                                 osbMensajeError);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RETURN(-1);

    END FSBPUNTOATENCION;

    /*****************************************************************
    PROPIEDAD INTELECTUAL DE PETI (C).

    UNIDAD         : PRASIGNACION
    DESCRIPCION    : PROCESO QUE PERMITIRA ASIGNAR A LA ORDEN
                     LA UNIDAD OPERATIVA DEFINIDA EN POR UOBYSOL.
                     ESTE SERVICIO FUE CREADO POR LA ANULACION DE LA
                     LOGICA DE ASIGNACION AUTOMATICA YA QUE LOS PROCESOS
                     DE MANEJO DE ORDENES DE OPEN EN SMARTFLEX
                     NO PERMITE TENER TRIGGERS QUE PERMITAN REALIZAR
                     DE FORMA AUTOAMTICA EL PROCESO DE ASIGNACIO.
    AUTOR          : JORGE VALIENTE
    FECHA          : 06/03/2014

    PARAMETROS              DESCRIPCION
    ============         ===================
    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    17/06/2014      LLOZADA             Se adiciona la validaci?n para los predios
                                        multifamiliares. RQ 143
    02/07/2014      LLOZADA             Se debe dejar NUll la variable SBUNIDADOPERATIVA para que
                                        para que realice la configuraci?n b?sica de UOBYSOL
    17-08-2016      Sandra Muñoz        CA200-398. Se modifica agreg?ndole un par?metro para la orden
                                        de trabajo que se desea asignar autom?ticamente, este
                                        par?metro se debe definir por defecto en null para que no
                                        afecte las funcionalidades ya existentes.
                                        Al cursor CULDC_ORDER se le agrega la validaci?n que filtre
                                        por n?mero de orden si este par?metro viene lleno
    19/06/2019      Jorge Valiente      CASO 200-2067: Modificacion de logica para el llamado del servicio
                                                       PRINTENTOSASIGNACION colocando para que marque el intento de
                                                       asignacion por llamado de configuracion y no por intento de
                                                       asignacion por unidad operativa. el resto de servicios PRINTENTOSASIGNACION
                                                       que fueron comentariados para que regitren intentos.
                                                       Se relaciono el servicio PROINIT para inicializar ciertas variables
                                                       y realizar el llamado por al inicio de este proceso para realizar el cargue
                                                       de variable globales
    19/06/2019      Jorge Valiente      CASO 200-2067: 1) Modificacion de logica para el llamado del servicio
                                                       PRINTENTOSASIGNACION colocando para que marque el intento de
                                                       asignacion por llamado de configuracion y no por intento de
                                                       asignacion por unidad operativa. el resto de servicios PRINTENTOSASIGNACION
                                                       que fueron comentariados para que regitren intentos.
                                                       2) Se relaciono el servicio PROINIT para inicializar ciertas variables
                                                       y realizar el llamado por al inicio de este proceso para realizar el cargue
                                                       de variable globales
                                                       3) El llamado del servicio PRREGSITROASIGAUTOLOG sera colocado en comentario
                                                       para establecer solo algunos en momento puntuales mencionadso por el
                                                       Ing. Hector Morales y Diana Slatarin.
                                                       4) Se modificaron los cursores CULDC_ORDER y CUUOBYSOL
                                                          El cursor CULDC_ORDER se le adiciono el campo para
                                                          obtener el sertor operativo donde esta asignada
                                                          El cursor CUUOBYSOL se adiciono el campo para obtener
                                                          la zona a la que esta configurada
    12/09/2019      Horbath       CASO 158:      Se  modifica para que halle la categoria del contrato y tipo de producto segun
                                                 los tipos de trabajo configurados en el parametro TIPOTRAB_TIPOPROD_BUSC_CATE.
												 Se agrega validacion si el parametro EJECUTA_PROCESO_POST esta en S, ejecuta proceso post
												 de lo contrario ejecuta proceso pre como lo hace actualmente
	17-11-2020     Horbath        CASO 272:    Se adicionan bloques de excepciones dentro de los loops


	17/02/2021	   dsaltarin	   caso 678: Se valida que el estado no sea 20-Planeado para marcar la orden como asignada.

    ******************************************************************/
     PROCEDURE PRASIGNACION(inuOrden or_order.order_id%TYPE DEFAULT NULL) IS
        csbMetodo       CONSTANT VARCHAR2(100) := csbSP_NAME ||  '.PRASIGNACION';

        nuEstadoAsignado ld_parameter.numeric_value%TYPE;

        --CURSOR PARA OBTENER TODAS LAS ORDENES QUE NO HAN SIDO
        --ASIGNADAS A UAN UNIDAD OPERATIVA EN LDC_ORDER
        CURSOR CULDC_ORDER(inuCantidadIntentos NUMBER) IS
            SELECT order_id,
                   package_id,
                   asignacion,
                   asignado,
                   (select oo.Operating_Sector_Id
                      from or_order oo
                     where oo.order_id = LO.ORDER_ID
                     and rownum = 1) SECTOR_OPERATIVO_ORDEN
            FROM   LDC_ORDER LO
            WHERE  LO.ASIGNADO = 'N'
            AND    nvl(asignacion, 0) < inuCantidadIntentos
                  -- CA200-398. Se agrega esta secci?n para poder reasignar individualmente una orden
            AND    inuOrden IS NULL
            --and lo.order_id = 32903042 --caso 200-2067

            UNION ALL
            SELECT order_id,
                   NULL package_id,
                   NULL asignacion,
                   CASE order_status_id
                       WHEN nuEstadoAsignado THEN
                        'S'
                       ELSE
                        'N'
                   END asignado,
                   or_order.Operating_Sector_Id SECTOR_OPERATIVO_ORDEN
            FROM   or_order
            WHERE  order_id = inuOrden;

        TEMPCULDC_ORDER CULDC_ORDER%ROWTYPE;

        --LLOZADA: variable para cargar el tipo de trabajo
        nuTipoTrabajo or_order.task_type_id%TYPE;
        nuPackType    ps_package_type.package_type_id%TYPE;

        --CURSOR PARA VALIDAR LAS UNIDADES OPERTAIVAS CONFIGURADAS PARA
        --LA ACTIVIDAD DE LA ORDEN GENERADA POR LA SOLICITUD CONFIGURADA EN LA
        --FORMA DE UOBYSOL
        CURSOR CUUOBYSOL(NUORDER_ID   OR_ORDER_ACTIVITY.ORDER_ID%TYPE,
                         NUPACKAGE_ID OR_ORDER_ACTIVITY.PACKAGE_ID%TYPE) IS
        --/*
            SELECT LPTOU.OPERATING_UNIT_ID,
                   LPTOU.PROCESOPRE,
                   LPTOU.PROCESOPOST,
                   LPTOU.CATECODI,
                   LPTOU.ITEMS_ID,
                   OOA.PRODUCT_ID,
                   OOA.ADDRESS_ID,
                   OOA.ACTIVITY_ID,
                   OOA.SUBSCRIPTION_ID,
                   (SELECT NVL(OOU.OPERATING_ZONE_ID, 0)
                      FROM OR_OPERATING_UNIT OOU
                     WHERE OOU.OPERATING_UNIT_ID = LPTOU.OPERATING_UNIT_ID) ZONA_UNIDAD_OPERATIVA,

                  decode(sbBLBSS_FACT_LJLB_0000158,'S',
                         FNUGETCATE(ooa.subscription_id, ooa.product_id, ooa.task_type_id, ooa.address_id),
                   (SELECT PP.CATEGORY_ID
                      FROM   PR_PRODUCT PP
                      WHERE  PP.PRODUCT_ID = DECODE(OOA.PRODUCT_ID,
                                                    NULL,
                                                    (SELECT PP.PRODUCT_ID
                                                     FROM   PR_PRODUCT PP
                                                     WHERE  PP.ADDRESS_ID = OOA.ADDRESS_ID
                                                     AND    ROWNUM = 1),
                                                    OOA.PRODUCT_ID)
                      AND    PP.PRODUCT_TYPE_ID IN
                             (SELECT TO_NUMBER(column_value)
                               FROM   TABLE(ldc_boutilities.splitstrings(SBCOD_TIPO_SOL_ASIG,
                                                                         ',')))
                      AND    ROWNUM = 1)) CATEGORY_ID


            FROM   LDC_PACKAGE_TYPE_OPER_UNIT LPTOU,
                   LDC_PACKAGE_TYPE_ASSIGN    LPTA,
                   OR_ORDER_ACTIVITY          OOA
            WHERE  OOA.ORDER_ID = NUORDER_ID
            AND    NVL(OOA.PACKAGE_ID, 0) = NVL(NUPACKAGE_ID, 0)
            AND    LPTOU.ITEMS_ID = OOA.ACTIVITY_ID
            AND    LPTA.PACKAGE_TYPE_ASSIGN_ID = LPTOU.PACKAGE_TYPE_ASSIGN_ID
            AND    LPTA.PACKAGE_TYPE_ID =
                   DECODE(DAMO_PACKAGES.FNUGETPACKAGE_TYPE_ID(OOA.PACKAGE_ID, NULL),
                           NULL,
                           -1,
                           DAMO_PACKAGES.FNUGETPACKAGE_TYPE_ID(OOA.PACKAGE_ID, NULL))
            AND    LPTOU.OPERATING_UNIT_ID NOT IN
                   (SELECT LC.OPERATING_UNIT_ID FROM LDC_CARUNIOPE LC WHERE LC.ACTIVO = 'N')
            ORDER  BY dbms_random.value
            ;
        --*/

        TEMPCUUOBYSOL CUUOBYSOL%ROWTYPE;

 

        --CURSOR PARA VALIDAR LA ZONA DE LA UNIDAD OPERTAIVA
        --QUE SERA ASIGNADA DESDE UOBYSOL Y QUE ESTA ZONA MANEJE
        --EL SECOTR OPERATIVO QEU SERA ASIGNADO A LA ORDEN.
        CURSOR CUGE_SECTOROPE_ZONA(INUOPERATING_SECTOR_ID OR_ORDER.OPERATING_SECTOR_ID%TYPE,
                                   INUOPERATING_ZONE_ID   OR_OPERATING_UNIT.OPERATING_ZONE_ID%TYPE) IS
            SELECT GSZ.*
            FROM   GE_SECTOROPE_ZONA GSZ
            WHERE  GSZ.ID_SECTOR_OPERATIVO = INUOPERATING_SECTOR_ID
                  --DAOR_ORDER.FNUGETOPERATING_SECTOR_ID(:NEW.ORDER_ID)
            AND    GSZ.ID_ZONA_OPERATIVA = INUOPERATING_ZONE_ID;
        --DAOR_OPERATING_UNIT.FNUGETOPERATING_ZONE_ID(NUOPERATING_UNIT_ID);

        TEMPCUGE_SECTOROPE_ZONA CUGE_SECTOROPE_ZONA%ROWTYPE;

        --NC 2493
        --CURSOR PARA IDENTIFICAR EL TIPO DE PRODUCTO
        --Y SI ES GENERICO
        CURSOR CUTIPOPRODUCTO(NUPRODUCT_ID OR_ORDER_ACTIVITY.PRODUCT_ID%TYPE) IS
            SELECT NVL(p.product_type_id, 0) TIPO_PRODUCTO
            FROM   pr_product p
            WHERE  p.product_id = NUPRODUCT_ID
            AND    p.product_type_id = dald_parameter.fnuGetNumeric_Value('COD_PRO_GEN', NULL);

        RTCUTIPOPRODUCTO CUTIPOPRODUCTO%ROWTYPE;

        --CURSOR PARA OBTENER LA CATEGROIA DE LA DIRECCION DE LA ORDEN
        --SI EL PRODUCTO ES GENERICO
        CURSOR CUSEGMENTOCATEGORIA(NUADDRESS_ID OR_ORDER_ACTIVITY.ADDRESS_ID%TYPE) IS
            SELECT NVL(S.CATEGORY_, 0) CATEGORIA,
                   S.SUBCATEGORY_ SUBCATEGORIA
            FROM   ab_address  aa,
                   AB_SEGMENTS S
            WHERE  aa.address_id = NUADDRESS_ID
            AND    AA.SEGMENT_ID = S.SEGMENTS_ID;

        RTCUSEGMENTOCATEGORIA CUSEGMENTOCATEGORIA%ROWTYPE;
        ---Fin NC 2493 desarrollo
        --TICKET 2001377 LJLB -- se consulta sector operatvo de ladireccion del producto
        CURSOR cuSectorOperativo(NUADDRESS_ID OR_ORDER_ACTIVITY.ADDRESS_ID%TYPE) IS
        SELECT OPERATING_SECTOR_ID
        FROM ab_address  aa,
             AB_SEGMENTS S
        WHERE aa.address_id = NUADDRESS_ID
          AND AA.SEGMENT_ID = S.SEGMENTS_ID ;

       sbFlag               VARCHAR2(1) := 'N'; --TICKET 2001377 LJLB -- se almacena flag para activar desarrollo
       nuSectorOperativo    AB_SEGMENTS.OPERATING_SECTOR_ID%TYPE;  --TICKET 2001377 LJLB -- se almacena sector operativo
       sbError              VARCHAR2(4000); --TICKET 2001377 LJLB -- se almacena error del porceso de asigancion
       nuContrato           GE_CONTRATO.ID_CONTRATO%TYPE; --TICKET 2001377 LJLB --  se almacena contrato

        --CURSOR IDENTIFICAR LAS UNIDADES OPERATIVAS
        --DESACTIVADAS EN LDC_CARUNIOPE
        CURSOR CULDC_CARUNIOPE(INUOPERATING_SECTOR_ID OR_ORDER.OPERATING_SECTOR_ID%TYPE) IS
            SELECT *
            FROM   LDC_CARUNIOPE
            WHERE  OPERATING_UNIT_ID = INUOPERATING_SECTOR_ID
            AND    ACTIVO = 'N';

        --LLOZADA:
        --Con este cursor se valida que exista una configuraci?n
        --para el tipo de solicitud en la forma CAMU
        CURSOR cuConfMulti(inuPackageType ps_package_type.package_type_id%TYPE) IS
            SELECT tipo_trabajo
            FROM   LDC_CONF_ASIGN_MULTI_01
            WHERE  solicitud = inuPackageType
            AND    asign_multi = 'S';

        RTCULDC_CARUNIOPE CULDC_CARUNIOPE%ROWTYPE;

        --MANEJO DE VARIABLES
        SBDATAIN              VARCHAR2(4000);
        ONUERRORCODE          NUMBER;
        OSBERRORMESSAGE       VARCHAR2(4000);
        SBUNIDADOPERATIVA     VARCHAR2(4000);
        SBEXECSERVICIO        VARCHAR2(4000);
        NUOPERATING_SECTOR_ID OR_ORDER.OPERATING_SECTOR_ID%TYPE;
        NUOPERATING_ZONE_ID   OR_OPERATING_UNIT.OPERATING_ZONE_ID%TYPE;
        NUCONTROLCICLOUOBYSOL NUMBER;
        NUSOLICITUD           MO_PACKAGES.PACKAGE_ID%TYPE := NULL;
        NUORDEN               OR_ORDER.ORDER_ID%TYPE := NULL;
        nuCantidadIntentos    ldc_order.asignacion%TYPE := dald_parameter.fnuGetNumeric_Value('CANTIDAD_INTENTOS_ASIGNACION');

        v_salto VARCHAR2(10) :=CHR(10)||CHR(13); --SALTO DE CARRO
        ---FIN MANEJO DE VARIABLES


        SBUOBYSOL VARCHAR2(4000);
		--00000158
		sbPost ld_parameter.value_chain%type:=nvl(dald_parameter.fsbGetValue_Chain('EJECUTA_PROCESO_POST',null),'N');
        sbCaso272 varchar2(1);

        --678
        sbCaso678     varchar2(1);
        nuestadoOt    or_order.order_status_id%type;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        PROINIT;

        --TICKET 200-1377 LJLB -- se consulta si aplica la entrega en la gasera
        IF BLBSS_FACT_LJLB_2001377 THEN
        --IF fblaplicaentrega('BSS_FACT_LJLB_2001377_1') THEN
           sbFlag := 'S';

           PRRESEINTEOR; --TICKET 200-1377 LJLB -- se setean los intentos de las ordenes que cumplan con el parametro
        END IF;
        -- CA200-398. Buscar el estado "Asignado" del sistema
        nuEstadoAsignado := dald_parameter.fnuGetNumeric_Value('COD_ESTADO_ASIGNADA_OT');
        
        if fblaplicaentregaxcaso('0000678') then
          sbCaso678 := 'S';
        else
          sbCaso678 := 'N';
        end if;


        --CICLO PARA RECORRER LAS ORDENES AUN NO ASIGNADAS
        FOR TEMPCULDC_ORDER IN CULDC_ORDER(nuCantidadIntentos) LOOP
            sbError := null;

            BEGIN   -- CASO 272: Se agrega bloque de control

                NUSOLICITUD := TEMPCULDC_ORDER.PACKAGE_ID;
                NUORDEN     := TEMPCULDC_ORDER.ORDER_ID;

                nuestadoOt := DAOR_ORDER.FNUGETORDER_STATUS_ID(TEMPCULDC_ORDER.ORDER_ID, NULL);
                IF NVL(nuestadoOt, 0) >= 5  AND
                 ((NVL(nuestadoOt, 0) !=20 and sbCaso678='S') OR sbCaso678 ='N') THEN

                    pkg_orden_uobysol.prcEliminarOrden(TEMPCULDC_ORDER.ORDER_ID);
                    commit;

                    proRegistraLogAsig( TEMPCULDC_ORDER.ORDER_ID,
                                          TEMPCULDC_ORDER.PACKAGE_ID,
                                          null);

                ELSE
                    if nvl(nuestadoOt,0) = 20 and sbCaso678 ='S' then
                       GOTO siguiente;
                    end if;
                    --CICLO PARA RECORRER LAS UNIDADES OPERATIVAS DE UOBYSOL
                    NUCONTROLCICLOUOBYSOL := 0;
                    FOR TEMPCUUOBYSOL IN CUUOBYSOL(TEMPCULDC_ORDER.ORDER_ID, TEMPCULDC_ORDER.PACKAGE_ID) LOOP

                       BEGIN   -- CASO 272: Se agrega bloque de control
                           --TICKET 2001377 LJLB -- se actualiza el sector opertaivo a la orden

                           IF sbFlag = 'S' THEN
                              if cuSectorOperativo%isopen then
                                close cuSectorOperativo;
                              end if;
                              OPEN cuSectorOperativo(TEMPCUUOBYSOL.ADDRESS_ID);
                              FETCH cuSectorOperativo INTO nuSectorOperativo;
                              IF cuSectorOperativo%NOTFOUND OR nuSectorOperativo IS NULL THEN

                                 sbError := sbError||v_salto||' orden ['||TEMPCULDC_ORDER.ORDER_ID||'], solicitud ['||TEMPCULDC_ORDER.PACKAGE_ID||']: el producto ['||TEMPCUUOBYSOL.PRODUCT_ID ||']  no tiene sector operativo definido';
                                 --TICKET 2001377 LJLB -- se registra log en la tabla LDC_ORDER
                                 proRegistraLogAsig( TEMPCULDC_ORDER.ORDER_ID,
                                                      TEMPCULDC_ORDER.PACKAGE_ID,
                                                      sbError);
                              END IF;
                              CLOSE cuSectorOperativo;
                              --TICKET 2001377 LJLB -- se actualiza sector operativo de la orden
                              
                              ACTUALIZA_SECTOR(TEMPCULDC_ORDER.ORDER_ID, nuSectorOperativo);
                              

                           END IF;

                           IF NUCONTROLCICLOUOBYSOL = 0 THEN

                              SBUOBYSOL := 'DATOS CURSOR CUUOBYSOL[ Unidad Opertaiva: ' || TEMPCUUOBYSOL.OPERATING_UNIT_ID
                                                             || ' - Proceso PRE: ' || TEMPCUUOBYSOL.PROCESOPRE
                                                             || ' - Proceso PRO: ' || TEMPCUUOBYSOL.PROCESOPOST
                                                             || ' - Categoria UOBYSOL: ' || TEMPCUUOBYSOL.CATECODI
                                                             || ' - Actividad UOBYSOL: ' || TEMPCUUOBYSOL.ITEMS_ID
                                                             || ' - Producto Orden: ' || TEMPCUUOBYSOL.PRODUCT_ID
                                                             || ' - Direccion Orden: ' || TEMPCUUOBYSOL.ADDRESS_ID
                                                             || ' - Actividad Orden: ' || TEMPCUUOBYSOL.ACTIVITY_ID
                                                             || ' - Contrato Orden: ' || TEMPCUUOBYSOL.SUBSCRIPTION_ID
                                                             || ' - Zona Unidad Operativa: ' || TEMPCUUOBYSOL.ZONA_UNIDAD_OPERATIVA
                                                             || ' - Categoria Produto Orden: ' || TEMPCUUOBYSOL.CATEGORY_ID || ']';

                               LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                   TEMPCULDC_ORDER.ORDER_ID,
                                                                   SBUOBYSOL);

                           END IF;

                           NUCONTROLCICLOUOBYSOL := 1;

                            if CULDC_CARUNIOPE%isopen then
                                close CULDC_CARUNIOPE;
                            end if;
                            OPEN CULDC_CARUNIOPE(TEMPCUUOBYSOL.OPERATING_UNIT_ID);
                            FETCH CULDC_CARUNIOPE
                                INTO RTCULDC_CARUNIOPE;
                            IF CULDC_CARUNIOPE%NOTFOUND THEN


                                --DATOS ENVIADOS A LOS PROCESOS PRE PARA
                                --VALIDAR DATOS DEFINIDOS EN LOS PROCESOS DE
                                --VALIDACION DE CADA UNO
                                SBDATAIN := NVL(TEMPCULDC_ORDER.ORDER_ID, -1) || '|' ||
                                            NVL(TEMPCULDC_ORDER.PACKAGE_ID, -1) || '|' ||
                                            NVL(TEMPCUUOBYSOL.ACTIVITY_ID, -1) || '|' ||
                                            NVL(TEMPCUUOBYSOL.SUBSCRIPTION_ID, -1) || '|' || 'PRASIGNACION' || '|' ||
                                            TEMPCUUOBYSOL.CATEGORY_ID;
                                            --TEMPCUCATEGORIA.CATEGORY_ID;


                                SBUNIDADOPERATIVA := NULL;

                                --LLOZADA: Se obtiene el tipo de solicitud
                                nuPackType := damo_packages.fnugetpackage_type_id(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                                  NULL);



                                IF nuPackType IS NOT NULL THEN


                                    --LLOZADA: Se abre el cursor para obtener el tipo de trabajo configurado
                                    if cuConfMulti%isopen then
                                        close cuConfMulti;
                                    end if;
                                    OPEN cuConfMulti(nuPackType);
                                    FETCH cuConfMulti
                                        INTO nuTipoTrabajo;
                                    CLOSE cuConfMulti;



                                    --LLOZADA: Si trae datos es porque existe una configuraci?n
                                    --para multifamiliares
                                    IF nuTipoTrabajo IS NOT NULL THEN
                                        SBDATAIN := SBDATAIN || '|' || nuTipoTrabajo;

                                        SBEXECSERVICIO := 'BEGIN :NUUNIDADOPERATIVA:=' ||
                                                          'LDC_BOASIGAUTO.FSBMULTIFAMILIAR' ||
                                                          '(:SBDATAIN); END;';



                                        EXECUTE IMMEDIATE SBEXECSERVICIO
                                            USING IN OUT SBUNIDADOPERATIVA, IN SBDATAIN;


                                    END IF;
                                END IF;


                                IF SBUNIDADOPERATIVA = '-1' THEN
                                    SBUNIDADOPERATIVA := NULL;
                                END IF;


                                --SBUNIDADOPERATIVA := NULL;
                                IF TEMPCUUOBYSOL.PROCESOPRE IS NOT NULL AND SBUNIDADOPERATIVA IS NULL THEN

                                    SBEXECSERVICIO := 'BEGIN :NUUNIDADOPERATIVA:=' ||
                                                      TEMPCUUOBYSOL.PROCESOPRE || '(:SBDATAIN); END;';

                                    --/*
                                    LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                         TEMPCULDC_ORDER.ORDER_ID,
                                                                         'SERVICIO PRE A EJECUTAR[' ||
                                                                         SBEXECSERVICIO ||
                                                                         '] CON DATOS DE ENTRADA[' ||
                                                                         SBDATAIN || ']');
                                    --*/

                                    EXECUTE IMMEDIATE SBEXECSERVICIO
                                        USING IN OUT SBUNIDADOPERATIVA, IN SBDATAIN;



                                    COMMIT;


                                END IF;
                                ---FIN CODIGO SERVICIO PRE



                                ---PROCESO CONFIGURACION UOBYSOL
                                IF SBUNIDADOPERATIVA IS NULL THEN



                                    --CONSULTA PARA OBTENER EL SECTOR OPERATIVO DE LA ORDEN
                                    BEGIN

                                        NUOPERATING_SECTOR_ID := TEMPCULDC_ORDER.SECTOR_OPERATIVO_ORDEN;
                                    END;


                                    --CONSULTA PARA OBTENER LA ZONA DE LA ORDEN

                                    BEGIN

                                        NUOPERATING_ZONE_ID := TEMPCUUOBYSOL.ZONA_UNIDAD_OPERATIVA;
                                    END;




                                    --CURSOR PARA VALIDAR SI EL SECTOR OPERATIVO ESTA
                                    --CONFIGURADO DENTRO DE LA ZONA;
                                    if CUGE_SECTOROPE_ZONA%isopen then
                                        close CUGE_SECTOROPE_ZONA;
                                    end if;
                                    OPEN CUGE_SECTOROPE_ZONA(NUOPERATING_SECTOR_ID, NUOPERATING_ZONE_ID);
                                    FETCH CUGE_SECTOROPE_ZONA
                                        INTO TEMPCUGE_SECTOROPE_ZONA;
                                    IF CUGE_SECTOROPE_ZONA%FOUND THEN


                                        --OBTIENE LA CATEGORIA DEL PRODUCTO

                                        --NC 2493
                                        if CUTIPOPRODUCTO%isopen then
                                           close CUTIPOPRODUCTO;
                                        end if;
                                        OPEN CUTIPOPRODUCTO(TEMPCUUOBYSOL.PRODUCT_ID);
                                        FETCH CUTIPOPRODUCTO
                                            INTO RTCUTIPOPRODUCTO;
                                        IF CUTIPOPRODUCTO%FOUND THEN



                                            if CUSEGMENTOCATEGORIA%isopen then
                                               close CUSEGMENTOCATEGORIA;
                                            end if;
                                            OPEN CUSEGMENTOCATEGORIA(TEMPCUUOBYSOL.ADDRESS_ID);
                                            FETCH CUSEGMENTOCATEGORIA
                                                INTO RTCUSEGMENTOCATEGORIA;
                                            
                                            pkg_Traza.trace('RTCUSEGMENTOCATEGORIA.CATEGORIA: '       ||RTCUSEGMENTOCATEGORIA.CATEGORIA,csbNivelTraza);
                                            CLOSE CUSEGMENTOCATEGORIA;


                                        END IF;
                                        CLOSE CUTIPOPRODUCTO;
                                        --FIN NC 2493


                                        --CASO 200-2067 comentariado
                                        --IF CUCATEGORIA%FOUND OR TEMPCUUOBYSOL.CATECODI = -1 OR
                                        IF TEMPCUUOBYSOL.CATEGORY_ID IS NOT NULL OR TEMPCUUOBYSOL.CATECODI = -1 OR
                                          --NC 2493
                                           RTCUSEGMENTOCATEGORIA.CATEGORIA = TEMPCUUOBYSOL.CATECODI THEN
                                            --FIN NC 2493

                                            --VALIDA LA CATEGORIA DEL PRODUTO CONFIGURADA
                                            --CON LA CONFIGURADA EN UOBYSOL



                                            --CASO 200-2067 comentarioado para utiliza el valor obtenido del cursor CUUOBYSOL
                                            --IF TEMPCUCATEGORIA.CATEGORY_ID = TEMPCUUOBYSOL.CATECODI OR
                                            IF TEMPCUUOBYSOL.CATEGORY_ID = TEMPCUUOBYSOL.CATECODI OR
                                               TEMPCUUOBYSOL.CATECODI = -1 OR
                                              --NC 2493
                                               RTCUSEGMENTOCATEGORIA.CATEGORIA = TEMPCUUOBYSOL.CATECODI THEN
                                                --FIN NC 2493

                                                BEGIN
                                                    --/*
                                                    IF sbFlag = 'S' THEN
                                                       --TICKET 2001377 LJLB -- se consulta contratos vigentes
                                                        SELECT COUNT(1) INTO  nuContrato
                                                        FROM ge_contrato C, 
                                                             ge_contratista g
                                                        WHERE C.ID_CONTRATISTA = G.ID_CONTRATISTA AND
                                                              C.status = ct_boconstants.fsbGetOpenStatus AND
                                                             C.ID_CONTRATISTA IN (SELECT contractor_id
                                                                                  FROM or_operating_unit ou
                                                                                  WHERE ou.operating_unit_id = TEMPCUUOBYSOL.OPERATING_UNIT_ID) AND
                                                            (SYSDATE BETWEEN C.FECHA_INICIAL AND C.FECHA_FINAL)
                                                            ;
                                                    ELSE
                                                      nuContrato := 1;
                                                    END IF;
                                                    --TICKET 2001377 LJLB -- se valida que exista contrato igente de la unidad qye se va asignar
                                                    IF nuContrato > 0 THEN

                                                       
                                                        ASIGNACION(TEMPCULDC_ORDER.Order_Id,
                                                                TEMPCUUOBYSOL.OPERATING_UNIT_ID,--
                                                                onuerrorcode,
                                                                osberrormessage);
                                                       

                                                        IF onuerrorcode = 0 THEN

                                                            --
                                                              GOTO siguiente;
                                                            --EXIT;
                                                        ELSE


                                                            IF sbFlag = 'S' THEN
                                                              --TICKET 2001377 LJLB -- se registra log en la tabla LDC_ORDER
                                                               sbError := substr(sbError||v_salto|| 'ORDEN ['||TEMPCULDC_ORDER.Order_Id||'] UNIDAD OPERATIVA [' ||TEMPCUUOBYSOL.OPERATING_UNIT_ID || '] CODIGO_ERROR [' ||            onuerrorcode || '] DESCRIPCION [' ||   osberrormessage || ']', 1, 3999);

                                                              proRegistraLogAsig( TEMPCULDC_ORDER.ORDER_ID,
                                                                                  TEMPCULDC_ORDER.PACKAGE_ID,
                                                                                  sbError);
                                                            END IF;
                                                            
                                                        END IF;
                                                      ELSE

                                                         IF sbFlag = 'S' THEN
                                                          --TICKET 2001377 LJLB -- se registra log en la tabla LDC_ORDER
                                                           sbError := substr(sbError||v_salto|| 'ORDEN ['||TEMPCULDC_ORDER.Order_Id||'] UNIDAD OPERATIVA [' ||  TEMPCUUOBYSOL.OPERATING_UNIT_ID || '] no tiene contrato vigente.', 1, 3999);

                                                           proRegistraLogAsig( TEMPCULDC_ORDER.ORDER_ID,
                                                                                TEMPCULDC_ORDER.PACKAGE_ID,
                                                                                sbError);
                                                        END IF;
                                                      END IF;

                                                EXCEPTION
                                                    WHEN OTHERS THEN
                                                        SBDATAIN := 'INCONSISTENCIA TRIGGER TRGAFTERASIGAUTO [' ||
                                                                    DBMS_UTILITY.FORMAT_ERROR_STACK ||
                                                                    '] - [' ||
                                                                    DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';


                                                         IF sbFlag = 'S' THEN
                                                              --TICKET 2001377 LJLB -- se registra log en la tabla LDC_ORDER
                                                              sbError := substr(sbError||v_salto||'ORDEN ['||TEMPCULDC_ORDER.Order_Id||'] UNIDAD OPERATIVA [' || TEMPCUUOBYSOL.OPERATING_UNIT_ID ||  '] ERROR [' ||  SQLERRM|| ']', 1, 3999);

                                                              proRegistraLogAsig( TEMPCULDC_ORDER.ORDER_ID,
                                                                                  TEMPCULDC_ORDER.PACKAGE_ID,
                                                                                  sbError);
                                                        END IF;



                                                END;

                                            ELSE

                                                  IF sbFlag = 'S' THEN
                                                     --TICKET 2001377 LJLB -- se registra log en la tabla LDC_ORDER
                                                     --sbError := substr(sbError||v_salto||'ORDEN ['||TEMPCULDC_ORDER.Order_Id||'] UNIDAD OPERATIVA [' || TEMPCUUOBYSOL.OPERATING_UNIT_ID || '] LA CATEGORIA [' || TEMPCUUOBYSOL.CATECODI || '] CONFIGURADA (UOBYSOL) NO ES IGUAL A LA CATERORIA [' || TEMPCUCATEGORIA.CATEGORY_ID ||'] DEL CONTRATO ' ||  TEMPCUUOBYSOL.SUBSCRIPTION_ID, 1, 3999);
                                                     sbError := substr(sbError||v_salto||'ORDEN ['||TEMPCULDC_ORDER.Order_Id||'] UNIDAD OPERATIVA [' || TEMPCUUOBYSOL.OPERATING_UNIT_ID || '] LA CATEGORIA [' || TEMPCUUOBYSOL.CATECODI || '] CONFIGURADA (UOBYSOL) NO ES IGUAL A LA CATERORIA [' || TEMPCUUOBYSOL.CATEGORY_ID ||'] DEL CONTRATO ' ||  TEMPCUUOBYSOL.SUBSCRIPTION_ID, 1, 3999);

                                                    proRegistraLogAsig( TEMPCULDC_ORDER.ORDER_ID,
                                                                      TEMPCULDC_ORDER.PACKAGE_ID,
                                                                      sbError);
                                                  END IF;

                                            END IF; --FIN VALIDACION DE CATEGORIA
                                        ELSE

                                            IF sbFlag = 'S' THEN
                                                --TICKET 2001377 LJLB -- se registra log en la tabla LDC_ORDER
                                                sbError := substr(sbError||v_salto|| 'ORDEN ['||TEMPCULDC_ORDER.Order_Id||'] UNIDAD OPERATIVA [' || TEMPCUUOBYSOL.OPERATING_UNIT_ID ||'] ERROR EN EL IDENTIFICACION DE CATEGORIA DEL PRODUCTO [' || TEMPCUUOBYSOL.PRODUCT_ID ||'] ASOCIADO AL CONTRATO [' ||TEMPCUUOBYSOL.SUBSCRIPTION_ID || '] - CATEGORIA PRODUCTO [' || RTCUSEGMENTOCATEGORIA.CATEGORIA ||
                                                                                   '] -  CATEGORIA UOBYSOL [' || TEMPCUUOBYSOL.CATECODI || ']', 1, 3999);

                                                proRegistraLogAsig( TEMPCULDC_ORDER.ORDER_ID,
                                                                  TEMPCULDC_ORDER.PACKAGE_ID,
                                                                  sbError);

                                            else

                                                sbError := substr(sbError||v_salto|| 'ORDEN ['||TEMPCULDC_ORDER.Order_Id||'] UNIDAD OPERATIVA [' || TEMPCUUOBYSOL.OPERATING_UNIT_ID ||'] ERROR EN EL IDENTIFICACION DE CATEGORIA DEL PRODUCTO [' || TEMPCUUOBYSOL.PRODUCT_ID ||'] ASOCIADO AL CONTRATO [' ||TEMPCUUOBYSOL.SUBSCRIPTION_ID || '] - CATEGORIA UOBYSOL [' || TEMPCUUOBYSOL.CATECODI || ']', 1, 3999);
                                                
                                                ACTUALIZA_MENSAJE(TEMPCULDC_ORDER.ORDER_ID,TEMPCULDC_ORDER.PACKAGE_ID, sbError);
                                                



                                            END IF;


                                        END IF;

                                    ELSE


                                        IF sbFlag = 'S' THEN
                                           --TICKET 2001377 LJLB -- se registra log en la tabla LDC_ORDER
                                           sbError := substr(sbError||v_salto|| 'LA ORDEN [' ||TEMPCULDC_ORDER.ORDER_ID ||'] Y LA UNIDAD OPERATIVA [' || TEMPCUUOBYSOL.OPERATING_UNIT_ID ||'] NO ESTAN EN LA MISMA ZONA OPERATIVA. SECTOR ORDEN['||nuSectorOperativo||']  ZONA OPERATIVA  DE LA UNIDAD OPERATIVA ['||NUOPERATING_ZONE_ID||']', 1, 3999);

                                          proRegistraLogAsig( TEMPCULDC_ORDER.ORDER_ID,
                                                            TEMPCULDC_ORDER.PACKAGE_ID,
                                                            sbError);

                                        ELSE
                                           sbError := substr(sbError||v_salto|| 'LA ORDEN [' ||TEMPCULDC_ORDER.ORDER_ID ||'] Y LA UNIDAD OPERATIVA [' || TEMPCUUOBYSOL.OPERATING_UNIT_ID ||'] NO ESTAN EN LA MISMA ZONA OPERATIVA. SECTOR ORDEN['||NUOPERATING_SECTOR_ID||']  ZONA OPERATIVA  DE LA UNIDAD OPERATIVA ['||NUOPERATING_ZONE_ID||']', 1, 3999);
                                           ACTUALIZA_MENSAJE(TEMPCULDC_ORDER.ORDER_ID,TEMPCULDC_ORDER.PACKAGE_ID, sbError);

                                        END IF;

                                    END IF; --FIN VALIDACION SECTOR OPERATIVO
                                    CLOSE CUGE_SECTOROPE_ZONA;
                                END IF; --VALIDACION SBUNIDADOPERATIVA IS NULL
                                --FIN PROCESO CONFIGURACION UOBYSOL

                                --PROCESO POST
                                IF TEMPCUUOBYSOL.PROCESOPOST IS NOT NULL THEN
                                  if sbPost ='S' then
                                    SBEXECSERVICIO := 'BEGIN :NUUNIDADOPERATIVA:=' ||
                                              TEMPCUUOBYSOL.PROCESOPOST || '(:SBDATAIN); END;';
                                  else
                                    SBEXECSERVICIO := 'BEGIN :NUUNIDADOPERATIVA:=' ||
                                              TEMPCUUOBYSOL.PROCESOPRE || '(:SBDATAIN); END;';
                                  end if;
                                  EXECUTE IMMEDIATE SBEXECSERVICIO
                                      USING IN OUT SBUNIDADOPERATIVA, IN SBDATAIN;
                                    COMMIT;
                                END IF;
                                --FIN PROCESO POST
                            ELSE

                                NULL;

                            END IF; --VALIDACION DE UNIDADES OPERATIVAS ACTIVAS
                            CLOSE CULDC_CARUNIOPE;
                        EXCEPTION
                            WHEN OTHERS THEN
                                Errors.setError;
                                pkg_Traza.trace('SQLERRM: '       ||SQLERRM,csbNivelTraza);
                        END;
                    END LOOP; -- Fin loop CUUOBYSOL

                    IF NUCONTROLCICLOUOBYSOL = 0 THEN

                         IF sbFlag = 'S' THEN
                           --TICKET 2001377 LJLB -- se registra log en la tabla LDC_ORDER
                          sbError := substr(sbError||v_salto|| 'ORDEN ['||TEMPCULDC_ORDER.Order_Id||']  LA ORDEN NO TIENE CONFIGURACION ADECUADA EN LA FORMA UOBYSOL', 1, 3999);

                          proRegistraLogAsig( TEMPCULDC_ORDER.ORDER_ID,
                                             TEMPCULDC_ORDER.PACKAGE_ID,
                                            sbError);
                        END IF;

                        -- CA272 Horbath: Se actualiza la siguiente informacion
                        
					     rollback;
                         UPDATE LDC_ORDER
                            SET ASIGNACION = nuCantidadIntentos + 1,
                                ORDEOBSE = 'La orden no tiene en estos momentos una configuraci�n en UOBYSOL v�lida.'
                         WHERE ORDER_ID = nuOrden AND NVL(PACKAGE_ID,0) = NVL(NUSOLICITUD,0);
						             commit;
                        

                    ELSE
                        --CASO 200-2067
                        --Se crea el ELSE para controlar si existe confgiuracion debe marcar el intento de asignacion
                        
                           ROLLBACK;
                        
                        PRINTENTOSASIGNACION(TEMPCULDC_ORDER.PACKAGE_ID, TEMPCULDC_ORDER.Order_Id);
                        
                           COMMIT;
                        

                    END IF;

                    <<siguiente>>
                        NULL;
                    ---FIN CODIGO DE ASIGNACION
                END IF;

            EXCEPTION
                WHEN OTHERS THEN
                    Errors.setError;
                    pkg_Traza.trace('SQLERRM: '       ||SQLERRM,csbNivelTraza);
            END;
            --FIN VALIDACION DE ACTUALIZA EL CAMPO ASIGNADO DE LAS ORDENES EN LDC_ORDER.
        END LOOP; -- Fin loop CULDC_ORDER


        COMMIT;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    EXCEPTION

        WHEN OTHERS THEN

            OSBERRORMESSAGE := '[' || DBMS_UTILITY.FORMAT_ERROR_STACK || '] - ' ||
                               DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(NULL,
                                                 NULL,
                                                 'ERROR OTHERS PRASIGNACION --> ' ||
                                                 OSBERRORMESSAGE);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            COMMIT;

    END PRASIGNACION;

    /*****************************************************************
    PROPIEDAD INTELECTUAL DE PETI (C).

    UNIDAD         : FSBMULTIFAMILIAR
    DESCRIPCION    : PROCESO QUE OBTIENE LAS UNIDADES OPERATIVAS
                     PARA ATENDER LA ORDEN DE VISITA PARA PREDIOS MULTIFAMILIARES

    AUTOR          : LLOZADA
    FECHA          : 17/06/2014

    PARAMETROS              DESCRIPCION
    ============         ===================
     ISBIN               VALORES EN UNA CADENA

    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    17/06/2014      llozada             Creaci?n.
    ******************************************************************/
    FUNCTION FSBMULTIFAMILIAR(SBIN IN VARCHAR2) RETURN VARCHAR2 IS

        --LA CADENA SBIN INGRESA CON LOSISGUIENTES DATOS
        --Y EN EL SIGUIENTE ORDEN
        --CODIGO DE LA ORDEN
        --CODIGO DE LA SOLICITUD
        --CODIGO DE LA ACTIVIDAD
        --CODIGO DEL CONTRATO

        SBORDER_ID      VARCHAR2(4000) := NULL;
        SBPACKAGE_ID    VARCHAR2(4000) := NULL;
        SBACTIVITY_ID   VARCHAR2(4000) := NULL;
        SUBSCRIPTION_ID VARCHAR2(4000) := NULL;
        PRASIGNACION    VARCHAR2(4000) := NULL;
        CATEGORY_ID     VARCHAR2(4000) := NULL;
        TIPOTRABAJO     VARCHAR2(4000) := NULL;

        --CON ESTA ORDEN SE SABE EN EL CICLO QUE DATO VA
        --EN SECUENCIA PARA SABER CUAL DE LOS DATOS UTILIZAR
        ----------------------------------------------------

        --SEPARA LOS DATOS OBTENIDOS DE LA CADENA DE ENTRADA
        --CON EL SEPARADOR |
        CURSOR CUDATA IS
            SELECT COLUMN_VALUE FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(SBIN, '|'));
        ---FIN CURSOR DATA

        ONUERRORCODE    NUMBER;
        OSBERRORMESSAGE VARCHAR2(4000);

        NUOPERATING_UNIT_ID OR_ORDER.OPERATING_UNIT_ID%TYPE;

        nuOrderId   or_order.order_id%TYPE;
        nuPriority  or_order.priority%TYPE;
        fnullX      or_order.x%TYPE;
        fnullY      or_order.y%TYPE;
        nuDuration  NUMBER;
        nuZone      or_operating_zone.operating_zone_id%TYPE;
        nuPackageId mo_packages.package_id%TYPE;
        sbZona      ldc_info_predio.is_zona%TYPE;
        nuMulti     ldc_info_predio.multivivienda%TYPE;

        --Obtiene el C?digo multifamiliar
        CURSOR cuMultifamiliar(inuOrderId IN OR_order.order_id%TYPE) IS
            SELECT d.is_zona,
                   d.multivivienda
            FROM   or_order_activity a,
                   pr_product        b,
                   ab_address        c,
                   ldc_info_predio   d
            WHERE  a.order_id = inuOrderId
            AND    a.product_id = b.product_id
            AND    b.address_id = c.address_id
            AND    c.estate_number = d.premise_id;
        --*/

        CURSOR cuUnidadOperativa(inuMultivivienda ldc_info_predio.multivivienda%TYPE,
                                 inuTipoTrabajo   or_task_type.task_type_id%TYPE) IS
            SELECT e.operating_unit_id,
                   e.task_type_id,
                   created_date,
                   e.ORDER_STATUS_ID
            FROM   ldc_info_predio   a,
                   ab_address        b,
                   pr_product        c,
                   or_order_activity d,
                   or_order          e
            WHERE  multivivienda = inuMultivivienda
            AND    a.premise_id = b.estate_number
            AND    b.address_id = c.address_id
            AND    c.product_id = d.product_id
            AND    d.order_id = e.order_id
            AND    e.task_type_id = inuTipoTrabajo
            AND    e.ORDER_STATUS_ID <> 0
            ORDER  BY created_date DESC;

    BEGIN

        UT_TRACE.TRACE('INICIO LDC_BOASIGAUTO.FSBMULTIFAMILIAR', 10);

        FOR TEMPCUDATA IN CUDATA LOOP

            UT_TRACE.TRACE(TEMPCUDATA.COLUMN_VALUE, 10);

            IF SBORDER_ID IS NULL THEN
                SBORDER_ID      := TEMPCUDATA.COLUMN_VALUE;
                OSBERRORMESSAGE := OSBERRORMESSAGE || ' - ' || SBORDER_ID;
            ELSIF SBPACKAGE_ID IS NULL THEN
                SBPACKAGE_ID    := TEMPCUDATA.COLUMN_VALUE;
                OSBERRORMESSAGE := OSBERRORMESSAGE || ' - ' || SBPACKAGE_ID;
            ELSIF SBACTIVITY_ID IS NULL THEN
                SBACTIVITY_ID   := TEMPCUDATA.COLUMN_VALUE;
                OSBERRORMESSAGE := OSBERRORMESSAGE || ' - ' || SBACTIVITY_ID;
            ELSIF SUBSCRIPTION_ID IS NULL THEN
                SUBSCRIPTION_ID := TEMPCUDATA.COLUMN_VALUE;
                OSBERRORMESSAGE := OSBERRORMESSAGE || ' - ' || SUBSCRIPTION_ID;
            ELSIF PRASIGNACION IS NULL THEN
                PRASIGNACION    := TEMPCUDATA.COLUMN_VALUE;
                OSBERRORMESSAGE := OSBERRORMESSAGE || ' - ' || SUBSCRIPTION_ID;
            ELSIF CATEGORY_ID IS NULL THEN
                CATEGORY_ID     := TEMPCUDATA.COLUMN_VALUE;
                OSBERRORMESSAGE := OSBERRORMESSAGE || ' - ' || SUBSCRIPTION_ID;
            ELSIF TIPOTRABAJO IS NULL THEN
                TIPOTRABAJO     := TEMPCUDATA.COLUMN_VALUE;
                OSBERRORMESSAGE := OSBERRORMESSAGE || ' - ' || SUBSCRIPTION_ID;
            END IF;

        END LOOP;

        UPDATE OR_ORDER_ACTIVITY
        SET    ORDER_ID = TO_NUMBER(SBORDER_ID)
        WHERE  PACKAGE_ID = TO_NUMBER(SBPACKAGE_ID)
        AND    ACTIVITY_ID = TO_NUMBER(SBACTIVITY_ID);

        NUOPERATING_UNIT_ID := -1;

        OPEN cuMultifamiliar(TO_NUMBER(SBORDER_ID));
        FETCH cuMultifamiliar
            INTO sbZona,
                 nuMulti;
        CLOSE cuMultifamiliar;

        IF nuMulti IS NOT NULL THEN

            FOR tempcuOperatingUnits IN cuUnidadOperativa(TO_NUMBER(nuMulti),
                                                          TO_NUMBER(TIPOTRABAJO)) LOOP

                IF tempcuOperatingUnits.operating_unit_id IS NOT NULL THEN

                    NUOPERATING_UNIT_ID := tempcuOperatingUnits.operating_unit_id;

                    os_assign_order(TO_NUMBER(SBORDER_ID),
                                    NUOPERATING_UNIT_ID,
                                    SYSDATE,
                                    SYSDATE,
                                    onuerrorcode,
                                    osberrormessage);

                    IF onuerrorcode = 0 THEN
                        /*
                        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                             TO_NUMBER(SBORDER_ID),
                                                             'LA ORDEN FUE ASIGNADA A LA UNIDAD OPERATIVA [' ||
                                                             NUOPERATING_UNIT_ID || ']');
                        */
                        --PRINTENTOSASIGNACION(TO_NUMBER(SBPACKAGE_ID), TO_NUMBER(SBORDER_ID));

                        UPDATE LDC_ORDER
                        SET    ASIGNADO = 'S'
                        WHERE  NVL(PACKAGE_ID, 0) = NVL(TO_NUMBER(SBPACKAGE_ID), 0)
                        AND    ORDER_ID = TO_NUMBER(SBORDER_ID);

                    ELSE
                        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                             TO_NUMBER(SBORDER_ID),
                                                             'LA UNIDAD OPERATIVA NO FUE ASIGNADA A LA UNIDAD OPERATIVA [' ||
                                                             NUOPERATING_UNIT_ID ||
                                                             '] - MENSAJE DE ERROR PROVENIENTE DE os_assign_order --> ' ||
                                                             osberrormessage);
                        --PRINTENTOSASIGNACION(TO_NUMBER(SBPACKAGE_ID), TO_NUMBER(SBORDER_ID));
                    END IF;

                    RETURN(NUOPERATING_UNIT_ID);
                END IF;
            END LOOP;

            UT_TRACE.TRACE('FIN LDC_BOASIGAUTO.FSBMULTIFAMILIAR', 10);

        END IF;

        RETURN - 1;

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            --ROLLBACK;
            ONUERRORCODE    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            OSBERRORMESSAGE := PKERRORS.FSBGETERRORMESSAGE || ' - STACK [' ||
                               DBMS_UTILITY.FORMAT_ERROR_STACK || '] - BACKTRACE [' ||
                               DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                 TO_NUMBER(SBORDER_ID),
                                                 'LDC_BOASIGAUTO.FSBPUNTOFIJO - CODIGO [' ||
                                                 ONUERRORCODE || '] DESCRIPCION [' ||
                                                 OSBERRORMESSAGE || ']');

            --DBMS_UTILITY.FORMAT_ERROR_STACK || ' - ' ||
            --DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
            RETURN(-1);

        WHEN OTHERS THEN
            --ROLLBACK;
            ONUERRORCODE    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            OSBERRORMESSAGE := PKERRORS.FSBGETERRORMESSAGE || ' - STACK [' ||
                               DBMS_UTILITY.FORMAT_ERROR_STACK || '] - BACKTRACE [' ||
                               DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                 TO_NUMBER(SBORDER_ID),
                                                 'LDC_BOASIGAUTO.FSBPUNTOFIJO - CODIGO [' ||
                                                 ONUERRORCODE || '] DESCRIPCION [' ||
                                                 OSBERRORMESSAGE || ']');

            --DBMS_UTILITY.FORMAT_ERROR_STACK ||PKERRORS.FSBGETERRORMESSAGE;--'INCONVENIENTES AL CONSULTAR EL CODIGO [' || ISBID || '] ' ||
            --DBMS_UTILITY.FORMAT_ERROR_STACK || ' - ' ||
            --DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
            RETURN(-1);

    END FSBMULTIFAMILIAR;


    /*****************************************************************
    PROPIEDAD INTELECTUAL DE PETI (C).

    UNIDAD         : FSBASIGOTACTSECTOR
    DESCRIPCION    : El servicio actualiza el sector operativo de la orden
                     solo si este es el sector operativo 1 y lo actualiza
                     con el sector operativo de la direcci?n que tenga el
                     cliente siempre y cuando este tenga direcci?n de lo
                     contrario no asignara la ot, ni actualiza el sector
                     en la ot.  NOTA: El cursor que busca la unidad de
                     trabajo lo hace para unidades de trabajo de tipo
                     Capacidad Horaria, si las unidades de trabajo son por
                     Horario hay que modificar un poco el cursor para obtener
                     la ut que va asignar

    AUTOR          : Lizeth Sanchez
    FECHA          : 18/12/2014

    PARAMETROS              DESCRIPCION
    ============         ===================
    ISBIN               VALORES EN UNA CADENA

    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    ******************************************************************/

    FUNCTION FSBASIGOTACTSECTOR(SBIN IN VARCHAR2) RETURN NUMBER IS

        csbMetodo       CONSTANT VARCHAR2(100) := csbSP_NAME ||  '.FSBASIGOTACTSECTOR';
        nuOrden         or_order.order_id%TYPE              := NULL;
        nuSolicitud     mo_packages.package_id%TYPE         := NULL;
        nuActividad     or_order_activity.activity_id%TYPE  := NULL;
        nuContrato      suscripc.susccodi%TYPE              := NULL;
		rcParametros    pkg_boasignacionuobysol.TYTRCPARAMETROS;

        --CON ESTA ORDEN SE SABE EN EL CICLO QUE DATO VA
        --EN SECUENCIA PARA SABER CUAL DE LOS DATOS UTILIZAR
        ----------------------------------------------------


        ONUERRORCODE        NUMBER;
        OSBERRORMESSAGE     VARCHAR2(4000);

        nuOperating_unit_id or_order.operating_unit_id%TYPE;
        nuOrder_activity_id or_order_activity.order_activity_id%TYPE;
        rcOrder             daor_order.styOR_order;



        --CURSOR PARA OBTENER EL SECTOR DE LA DIRECCION ASOCIADA AL CLIENTE SOBRE EL CUAL SE REALIZA LA SOLICITUD.

        CURSOR cuObtSector(inuPackage_id MO_PACKAGES.PACKAGE_ID%TYPE) IS
            SELECT AB_SEGMENTS.operating_sector_id
            FROM   MO_PACKAGES,
                   GE_SUBSCRIBER,
                   AB_ADDRESS,
                   AB_SEGMENTS
            WHERE  MO_PACKAGES.PACKAGE_ID = inuPackage_id
            AND    MO_PACKAGES.SUBSCRIBER_ID = GE_SUBSCRIBER.SUBSCRIBER_ID
            AND    GE_SUBSCRIBER.ADDRESS_ID = AB_ADDRESS.ADDRESS_ID
            AND    AB_ADDRESS.segment_id = AB_SEGMENTS.segments_id;

        --CURSOR PARA OBTENER LA UT

        CURSOR cuObtUnidOper(inuSector   OR_ORDER.operating_sector_id%TYPE,
                             inuActivity or_order_activity.activity_id%TYPE) IS
            SELECT /*+ index(GE_SECTOROPE_ZONA IDX_GE_SECTOROPE_ZONA_02 )
                                                                                                                                                        index(OR_ZONA_BASE_ADM IDX_OR_ZONA_BASE_ADM_02 )
                                                                                                                                                        index(OR_OPERATING_UNIT IDX_OR_OPERATING_UNIT_04 )
                                                                                                                                                        index(OR_OPER_UNIT_STATUS PK_OR_OPER_UNIT_STATUS ) */
            DISTINCT operating_unit_id
            FROM   ge_sectorope_zona,
                   or_zona_base_adm,
                   or_operating_unit,
                   or_oper_unit_status,
                   OR_ACTIVIDADES_ROL,
                   OR_ROL_UNIDAD_TRAB
            WHERE  or_oper_unit_status.oper_unit_status_id = or_operating_unit.oper_unit_status_id
            AND    or_operating_unit.admin_base_id = or_zona_base_adm.id_base_administra
            AND    or_operating_unit.operating_zone_id = or_zona_base_adm.operating_zone_id
            AND    or_operating_unit.valid_for_assign = 'Y'
            AND    or_zona_base_adm.operating_zone_id = ge_sectorope_zona.id_zona_operativa
            AND    ge_sectorope_zona.id_sector_operativo = inuSector
            AND    or_oper_unit_status.valid_for_assign = 'Y'
            AND    or_operating_unit.assign_type NOT IN ('S', 'R')
            AND    OR_ROL_UNIDAD_TRAB.ID_UNIDAD_OPERATIVA = or_operating_unit.operating_unit_id
            AND    OR_ROL_UNIDAD_TRAB.ID_ROL = OR_ACTIVIDADES_ROL.ID_ROL
            AND    OR_ACTIVIDADES_ROL.ID_ACTIVIDAD = inuActivity
            AND    NOT EXISTS
             (SELECT /*+ index(OR_EXCEP_ACT_UNITRAB UX_OR_EXCEP_ACT_UNITRAB_03)*/
                     'X'
                    FROM   OR_EXCEP_ACT_UNITRAB
                    WHERE  OR_EXCEP_ACT_UNITRAB.ID_UNIDAD_OPERATIVA =
                           or_operating_unit.operating_unit_id
                    AND    OR_EXCEP_ACT_UNITRAB.ID_ACTIVIDAD = OR_ACTIVIDADES_ROL.ID_ACTIVIDAD)
            AND    rownum = 1;

        TEMPCUUNIDADOPERATIVA cuObtUnidOper%ROWTYPE;
        TEMPCUOBTSECTOR       cuObtSector%ROWTYPE;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

	    rcParametros        := pkg_boasignacionuobysol.frcObtParametros(SBIN);

        nuOrden             := rcParametros.nuOrdenId;
        pkg_Traza.trace('nuOrden: ' ||nuOrden,csbNivelTraza);

        nuSolicitud         := rcParametros.nuSolicitudId;
        pkg_Traza.trace('nuSolicitud: ' ||nuSolicitud,csbNivelTraza);

        nuActividad         := rcParametros.nuActividadId;
        pkg_Traza.trace('nuActividad: ' ||nuActividad,csbNivelTraza);

        nuContrato          := rcParametros.nuContratoId;
        pkg_Traza.trace('nuContrato: ' ||nuContrato,csbNivelTraza);

        nuOperating_unit_id := -1;


        OPEN cuObtSector(nuSolicitud);
        FETCH cuObtSector
            INTO TEMPCUOBTSECTOR;

        IF cuObtSector%FOUND THEN

            rcOrder := daor_order.frcGetRecord(nuOrden);
            pkg_Traza.trace('rcOrder.operating_sector_Id: ' ||rcOrder.operating_sector_Id,csbNivelTraza);

            IF rcOrder.operating_sector_Id = 1 THEN

                SELECT order_activity_id
                INTO   nuOrder_activity_id
                FROM   or_order_activity
                WHERE  order_id = rcOrder.order_id;

                BEGIN
                    daor_order.updoperating_sector_id(rcOrder.order_id,
                                                      TEMPCUOBTSECTOR.OPERATING_SECTOR_ID,
                                                      0);

                    daor_order_activity.updoperating_sector_id(nuOrder_activity_id,
                                                               TEMPCUOBTSECTOR.OPERATING_SECTOR_ID,
                                                               0);

                    COMMIT;
                    pkg_Traza.trace('Se actualizó sector operativo.',csbNivelTraza);

                    rcOrder.operating_sector_Id := TEMPCUOBTSECTOR.OPERATING_SECTOR_ID;
                EXCEPTION
                    WHEN pkg_error.CONTROLLED_ERROR THEN
                        RAISE pkg_error.CONTROLLED_ERROR;
                    WHEN OTHERS THEN
                        pkg_error.setError;
                        RAISE pkg_error.CONTROLLED_ERROR;
                END;
            END IF;

            --    close   cuObtSector;

            OPEN cuObtUnidOper(TEMPCUOBTSECTOR.OPERATING_SECTOR_ID, nuActividad);
            FETCH cuObtUnidOper
                INTO TEMPCUUNIDADOPERATIVA;

            IF cuObtUnidOper%FOUND THEN

                nuOperating_unit_id := TO_NUMBER(TEMPCUUNIDADOPERATIVA.OPERATING_UNIT_ID);

                pkg_Traza.trace('nuOperating_unit_id: ' ||nuOperating_unit_id,csbNivelTraza);


                BEGIN
                    api_assign_order(nuOrden,
                                    nuOperating_unit_id,
                                    onuerrorcode,
                                    osberrormessage);

                    pkg_Traza.trace('onuerrorcode: ' ||onuerrorcode,csbNivelTraza);
                    pkg_Traza.trace('osberrormessage: ' ||osberrormessage,csbNivelTraza);

                    IF onuerrorcode = 0 THEN
                        
                        pkg_orden_uobysol.prcEliminarOrden(nuOrden);

                    ELSE
                        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(nuSolicitud,
                                                             nuOrden,
                                                             'LA ORDEN NO FUE ASIGNADA A LA UNIDAD OPERATIVA [' ||
                                                             nuOperating_unit_id ||
                                                             '] - MENSAJE DE ERROR PROVENIENTE DE os_assign_order --> ' ||
                                                             osberrormessage);
                        
                    END IF;

                EXCEPTION
                    WHEN OTHERS THEN
                        osberrormessage := 'INCONSISTENCIA TRIGGER TRGAFTERASIGAUTO [' ||
                                           DBMS_UTILITY.FORMAT_ERROR_STACK || '] - [' ||
                                           DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

                        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(nuSolicitud,
                                                             nuOrden,
                                                             'INCONVENIENTES AL INSERTAR LA ORDEN EN TEMPORAL OR_ORDER_1 CON LA UNIDAD DE TRABAJO [' ||
                                                             nuOperating_unit_id || '] - MENSAJE [' ||
                                                             osberrormessage || ']');
                END;
                --*/
            ELSE
                nuOperating_unit_id := -1;

                LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(nuSolicitud,
                                                     nuOrden,
                                                     'No se encontro Unidad Operativa para asignar la orden [LDC_BOASIGAUTO.FSBASIGOTACTSECTOR - cuObtUnidOper].');

            END IF;

            CLOSE cuObtUnidOper;

        ELSE
            nuOperating_unit_id := -1;

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(nuSolicitud,
                                                 nuOrden,
                                                 'No se encontro S.O. en la dir del cliente o el cliente no tiene direccion[LDC_BOASIGAUTO.FSBASIGOTACTSECTOR - CUUNIDADOPERATIVA].');

        END IF;
        CLOSE cuObtSector;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

        RETURN(nuOperating_unit_id);

    EXCEPTION

        WHEN pkg_error.CONTROLLED_ERROR THEN
            --ROLLBACK;
            ONUERRORCODE    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            OSBERRORMESSAGE := 'Inconvenientes en la asignacion de la Unidad Operativa, actualizando el Sector Operativo' ||
                               PKERRORS.FSBGETERRORMESSAGE;
            OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [' || DBMS_UTILITY.FORMAT_ERROR_STACK ||
                               ' - [' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(nuSolicitud,
                                                 nuOrden,
                                                 OSBERRORMESSAGE);

            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            RETURN(-1);

        WHEN OTHERS THEN
            --ROLLBACK;
            pkg_error.setError;
            ONUERRORCODE    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            OSBERRORMESSAGE := 'Inconvenientes en la asignacion de la Unidad Operativa, actualizando el Sector Operativo' ||
                               PKERRORS.FSBGETERRORMESSAGE;
            OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [' || DBMS_UTILITY.FORMAT_ERROR_STACK ||
                               ' - [' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(nuSolicitud,
                                                 nuOrden,
                                                 OSBERRORMESSAGE);

            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            RETURN(-1);

    END FSBASIGOTACTSECTOR;

    --fin nuevos servicio NC4413

    /*****************************************************************
    UNIDAD         : PROINIT
    DESCRIPCION    : PROCESO QUE INICIALIZA VARIBALES.
    AUTOR          : JORGE VALIENTE
    FECHA          : 06/03/2014

    PARAMETROS              DESCRIPCION
    ============         ===================
    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    ******************************************************************/
    PROCEDURE PROINIT IS

    cursor cuTTEsp is
     select to_number(REGEXP_SUBSTR( column_value, '[^|]+', 1, 1 )) ttrab,
     to_number(REGEXP_SUBSTR( column_value, '[^|]+', 1, 2 )) tprod
                              from
                              (select * from (
                              select * from table(open.ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('TIPOTRAB_TIPOPROD_BUSC_CATE',
                                                                            NULL),
                                           ';'))
                                           )
               where column_value is not null);

    BEGIN

      BLBSS_FACT_LJLB_2001377 := fblaplicaentrega('BSS_FACT_LJLB_2001377_1');
      BLOSS_RP_OOP_200304_1   := fblaplicaentrega('OSS_RP_OOP_200304_1');
      SBLOG_ASIGNACION_CONTROL := NVL(OPEN.DALD_PARAMETER.fsbGetValue_Chain('LOG_ASIGNACION_CONTROL', NULL), 'N');
      SBCOD_TIPO_SOL_ASIG := DALD_PARAMETER.fsbGetValue_Chain('COD_TIPO_SOL_ASIG',NULL);

      BLBSS_FACT_LJLB_0000158 := fblaplicaentregaxcaso('0000158');
      if BLBSS_FACT_LJLB_0000158 then
        sbBLBSS_FACT_LJLB_0000158 := 'S';
      else
         sbBLBSS_FACT_LJLB_0000158 := 'N';
      end if;

      tTipoTrab.delete;
      If BLBSS_FACT_LJLB_0000158 then
        for rg in cuTTEsp loop
          if rg.ttrab is not null and rg.tprod is not null then
            nuIndTT := rg.ttrab;
            if not tTipoTrab.exists(nuIndTT) then
              tTipoTrab(nuIndTT).tipotrab := rg.ttrab;
              tTipoTrab(nuIndTT).tipoprod := rg.tprod;
            end if;
          end if;
        end loop;
      end if;

    END PROINIT;

    /*****************************************************************
    UNIDAD         : FNUGETCATE
    DESCRIPCION    : PROCESO QUE BUSCA LA CATEGORIA
    AUTOR          : HB
    FECHA          : 12/09/2019

    PARAMETROS              DESCRIPCION
    ============         ===================
    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    ******************************************************************/
    FUNCTION FNUGETCATE (inucont servsusc.sesususc%type,
                           inuprod servsusc.sesunuse%type,
                           inutitr or_order.task_type_id%type,
                           inuAdress pr_product.address_id%type) return number IS

    onucate servsusc.sesucate%TYPE;

    cursor cuCate is
     SELECT PP.CATEGORY_ID
                      FROM   PR_PRODUCT PP
                      WHERE  PP.PRODUCT_ID = DECODE(inuprod,
                                                    NULL,
                                                    (SELECT PP.PRODUCT_ID
                                                     FROM   PR_PRODUCT PP
                                                     WHERE  PP.ADDRESS_ID = inuAdress
                                                     AND    ROWNUM = 1),
                                                     inuprod)
                      AND    PP.PRODUCT_TYPE_ID IN
                             (SELECT TO_NUMBER(column_value)
                               FROM   TABLE(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('COD_TIPO_SOL_ASIG',NULL),
                                                                         ',')))
                       AND    ROWNUM = 1;
    BEGIN

     if tTipoTrab.exists(inutitr)  then
      BEGIN
       SELECT PP.Category_Id
         INTO ONUCATE
         FROM PR_PRODUCT PP
        WHERE PP.SUBSCRIPTION_ID = INUCONT
          AND PP.PRODUCT_TYPE_ID = tTipoTrab(inutitr).tipoprod;
       EXCEPTION WHEN OTHERS THEN
         open cuCate;
         fetch cuCate into ONUCATE;
         if cuCate%notfound then
           ONUCATE := -1;
         end if;
         close cuCate;
       END;
     else
      open cuCate;
         fetch cuCate into ONUCATE;
         if cuCate%notfound then
           ONUCATE := -1;
         end if;
         close cuCate;
     end if;

     return (onucate);

   EXCEPTION WHEN OTHERS THEN
       return (-1);
   END FNUGETCATE;
    --/*
    /*****************************************************************
    UNIDAD         : PRMANTENIMIENTOLDCORDER
    DESCRIPCION    : PROCESO PARA ELIMINAR REGISTROS DE ORDENES YA ASIGNADAS
                     EN EL PROCESO DE ASIGNACION AUTOMATICA.
    AUTOR          : JORGE VALIENTE
    FECHA          : 06/03/2014

    PARAMETROS              DESCRIPCION
    ============         ===================
    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    ******************************************************************/
    PROCEDURE PRMANTENIMIENTOLDCORDER IS

      --CURSOR PARA OBTENER LA CANTIDAD DE ORDENES LEGALIZADAS
      CURSOR CULDCORDER IS
        SELECT COUNT(L.ORDER_ID) CANTIDAD
          FROM LDC_ORDER L
         WHERE L.ASIGNADO = 'S';

      RFCULDCORDER CULDCORDER %ROWTYPE;

      --VARIABLE PARA ESTABLECER LA CANTIDA DE REGISTROS A ELIMINAR POR BLOQUE
      NUCANTIDADREGISTROS NUMBER := 300000;
      --VARIABLE PARA ESTABLECER EL CONTADOR TOTAL DE REGISTROS A ELIMINMAR
      NUCANTIDADTOTAL     NUMBER := 0;

      --CURSOR PARA OBTENER LA CANTIDAD DE ORDENES A ELIMNAR DESDE UN PARAMETRO
      CURSOR CUPARAMETRONUMERICO(ISBPARAMETRO VARCHAR2) IS
        select t.numeric_value VALOR_NUMERICO
          from LD_PARAMETER t
         WHERE T.PARAMETER_ID = ISBPARAMETRO;

      NUVALORNUMERICO NUMBER;

    begin
      --DBMS_OUTPUT.put_line('INICIO[' || SYSDATE || ']');

      OPEN CUPARAMETRONUMERICO('CANTIDAD_OT_ASIGNADAS_UOBYSOL');
      FETCH CUPARAMETRONUMERICO
        INTO NUVALORNUMERICO;
      IF CUPARAMETRONUMERICO%FOUND THEN
        IF NUVALORNUMERICO IS NOT NULL THEN
          NUCANTIDADREGISTROS := NUVALORNUMERICO;
        END IF;
      END IF;
      CLOSE CUPARAMETRONUMERICO;

      OPEN CULDCORDER;
      FETCH CULDCORDER
        INTO RFCULDCORDER;
      IF CULDCORDER %FOUND THEN
        IF NVL(RFCULDCORDER.CANTIDAD, 0) > 0 THEN
          NUCANTIDADTOTAL := RFCULDCORDER.CANTIDAD; --500001; --

          --CICLO PARA ELIMINAR ORDENES ASIGNADAS POR EL PROCESO
          --UOBYSOL CON UNA CANTIDAD DETERMINADA PARA
          --PODER UTILIZAR LA SENTENCIA DELETE Y NO BLOQUEAR LA ENTIDAD
          WHILE NUCANTIDADTOTAL > NUCANTIDADREGISTROS LOOP

            --DBMS_OUTPUT.put_line('NUCANTIDADTOTAL[' || NUCANTIDADTOTAL || ']');
            --DBMS_OUTPUT.put_line('ANTES NUCANTIDADTOTAL[' || NUCANTIDADTOTAL || ']');

            --/*
            DELETE FROM LDC_ORDER L
             WHERE L.ASIGNADO = 'S'
               AND ROWNUM <= NUCANTIDADREGISTROS;

            COMMIT;
            --*/

            NUCANTIDADTOTAL := NUCANTIDADTOTAL - NUCANTIDADREGISTROS;

          --DBMS_OUTPUT.put_line('DESPUES NUCANTIDADTOTAL[' || NUCANTIDADTOTAL || ']');

          END LOOP;

          --ELIMINAR LAS ORDENES CON EL SALDO PENDIENTE EN EL PROCESO WHILE
          IF NUCANTIDADTOTAL > 0 THEN
            --/*
            DELETE FROM LDC_ORDER L
             WHERE L.ASIGNADO = 'S'
               AND ROWNUM <= NUCANTIDADTOTAL;

            COMMIT;
            --*/
          END IF;

        END IF;
      END IF;
      CLOSE CULDCORDER;

      --DBMS_OUTPUT.put_line('FIN[' || SYSDATE || ']');
    END PRMANTENIMIENTOLDCORDER;
    --*/

    /*****************************************************************
    UNIDAD         : PRMANTENIMIENTOLOG
    DESCRIPCION    : PROCESO PARA ELIMINAR TODOS LOS REGISTROS LOG GENERADOS
                     EN EL ENTIDAD LDC_ORDSINASIGAUT ESTO CON EL FIN QUE LA
                     TAREA PROGRAMADA QUE SEA UTILIZADA PARA EJECUTAR ESTE SERVICIO
                     SEA PROGRAMADA CADA FIN DE SEMANA O CADA 15 DIAS PARA
                     DEJAR LA ENTIDAD DESDE 0 PARA REGISTRA NUEVOS LOG EN UN
                     DETERMINADO PERIODO DE TIEMPO
    AUTOR          : JORGE VALIENTE
    FECHA          : 06/03/2014

    PARAMETROS              DESCRIPCION
    ============         ===================
    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    ******************************************************************/
    PROCEDURE PRMANTENIMIENTOLOG IS

    SBEXECSERVICIO VARCHAR2(4000);

    BEGIN
      --DBMS_OUTPUT.put_line('INICIO[' || SYSDATE || ']');

      --SBEXECSERVICIO := 'BEGIN TRUNCATE TABLE LDC_ORDSINASIGAUT; END;';
      SBEXECSERVICIO := 'TRUNCATE TABLE LDC_ORDSINASIGAUT';

      EXECUTE IMMEDIATE SBEXECSERVICIO;

      --DBMS_OUTPUT.put_line('FIN[' || SYSDATE || ']');
    END PRMANTENIMIENTOLOG;
    --*/

    ----Fin CASO 200-2067
    PROCEDURE ASIGNACION(inuOrden   in or_order.order_id%TYPE,
                          inuUnidad  in open.or_operating_unit.operating_unit_id%type,
                          onuError   out number,
                          osbMensaje out varchar2) is
    /*****************************************************************
    UNIDAD         : ASIGNACION
    DESCRIPCION    : PROCESO PARA ASIGNAR ORDENES
    AUTOR          : DSALTARIN
    FECHA          : 09/12/2020

    PARAMETROS              DESCRIPCION
    ============         ===================
    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    ******************************************************************/
     PRAGMA AUTONOMOUS_TRANSACTION;
     begin
       api_assign_order(inuOrden,
                       inuUnidad,--
                       onuError,
                       osbMensaje);
       IF onuError = 0 THEN
          pkg_orden_uobysol.prcEliminarOrden(inuOrden);
          COMMIT;
       ELSE
          rollback;
        END IF;

     End;
    PROCEDURE ACTUALIZA_SECTOR(inuOrden   in or_order.order_id%TYPE,
                               inuSector  in or_order.operating_sector_id%TYPE) is
    /*****************************************************************
    UNIDAD         : ACTUALIZA_SECTOR
    DESCRIPCION    : PROCESO PARA ACTUALIZAR SECTOR DE UNA ORDEN
    AUTOR          : DSALTARIN
    FECHA          : 09/12/2020

    PARAMETROS              DESCRIPCION
    ============         ===================
    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    ******************************************************************/
     PRAGMA AUTONOMOUS_TRANSACTION;
     begin
       UPDATE or_order SET OPERATING_SECTOR_ID = inuSector WHERE order_id = inuOrden;
			 commit;

     End;
     PROCEDURE ACTUALIZA_MENSAJE(inuOrden   in or_order.order_id%TYPE,
                                 inuPackage in mo_packages.package_id%TYPE,
                                 sbMensaje  in varchar2) is
    /*****************************************************************
    UNIDAD         : ACTUALIZA_MENSAJE
    DESCRIPCION    : PROCESO PARA ACTUALIZAR MENSAJE DE ERROR
    AUTOR          : DSALTARIN
    FECHA          : 09/12/2020

    PARAMETROS              DESCRIPCION
    ============         ===================
    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    ******************************************************************/
     PRAGMA AUTONOMOUS_TRANSACTION;
     begin
       UPDATE LDC_ORDER
        SET    LDC_ORDER.ORDEOBSE =  sbMensaje
        WHERE  ORDER_ID = inuOrden
        AND NVL(PACKAGE_ID, 0) = NVL(inuPackage, 0);
			 commit;

     End;


END LDC_BOASIGAUTO;
/
