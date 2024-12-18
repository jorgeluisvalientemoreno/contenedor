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

  UNIDAD         : GENREACIONMULTA
  DESCRIPCION    : PROCESO QUE PERMITIRA GENERAR DOCUMENTO
                   COMISION DE RECAUDO.
  AUTOR          : JORGE VALIENTE
  FECHA          : 12/11/2013

  PARAMETROS              DESCRIPCION
  ============         ===================
   ISBIN               VALORES EN UNA CADENA

  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FSBREVISIONPERIODICA(SBIN IN VARCHAR2) RETURN VARCHAR2;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE PETI (C).

  UNIDAD         : FSBPOSTNOTIFICACIONRP
  DESCRIPCION    : PROCESO QUE PERMITIRA OBTENER
                   LA UNIDAD OPERATIVA DE LA ORDEN DE REVISION PERIODICA
                   DE LA SOLICITUD DE REVISION INMEDIATA.
  AUTOR          : JORGE VALIENTE
  FECHA          : 12/11/2013

  PARAMETROS              DESCRIPCION
  ============         ===================
   ISBIN               VALORES EN UNA CADENA

  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FSBVALIDANOTIFICACION(SBIN IN VARCHAR2) RETURN VARCHAR2;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE PETI (C).

  UNIDAD         : FSBPUNTOFIJO
  DESCRIPCION    : PROCESO QUE OBTIENE LAS UNIDADES OPERATIVAS
                   CAPACITAS PARA ATENDER LA ORDEN DE VISITA DE PUNTOS
                   DIJOS, DADA LA SOLICITUD.

  AUTOR          : JORGE VALIENTE
  FECHA          : 13/11/2013

  PARAMETROS              DESCRIPCION
  ============         ===================
   ISBIN               VALORES EN UNA CADENA

  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FSBPUNTOFIJO(SBIN IN VARCHAR2) RETURN VARCHAR2;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE PETI (C).

  UNIDAD         : FSBRPREGENERADA
  DESCRIPCION    : PROCESO QUE PERMITE ASIGNAR A LA ORDENE DE
                   REVISION PERIODICA REGNERADA, A LA UNIDAD OPERATIVA
                   ASIGNADA A LA ORDEN DE NOTIFICACION DE RP.

  AUTOR          : JORGE VALIENTE
  FECHA          : 13/11/2013

  PARAMETROS              DESCRIPCION
  ============         ===================
   ISBIN               VALORES EN UNA CADENA

  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FSBRPREGENERADA(SBIN IN VARCHAR2) RETURN VARCHAR2;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE PETI (C).

  UNIDAD         : FSBCOTIZADA
  DESCRIPCION    : PROCESO QUE PERMITE ASIGNAR A LA ORDENE DE
                   COTIZACION , CON LA UNIDAD OPERATIVA
                   ASIGNADA A LA ORDEN QUE SE LEGALIZO DE COTIZACION.

  AUTOR          : JORGE VALIENTE
  FECHA          : 13/11/2013

  PARAMETROS              DESCRIPCION
  ============         ===================
  ISBIN               VALORES EN UNA CADENA

  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FSBCOTIZADA(SBIN IN VARCHAR2) RETURN VARCHAR2;

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
  FUNCTION FSBPUNTOATENCION(SBIN IN VARCHAR2) RETURN VARCHAR2;

  --NC 9999
  /*****************************************************************
  PROPIEDAD INTELECTUAL DE PETI (C).

  UNIDAD         : FSBRPTRAMITES
  DESCRIPCION    : PROCESO QUE PERMITIRA OBTENER
                   LA UNIDAD OPERATIVA DE LA SOLICITUD
                   REPACAION INMEDIATA.
  AUTOR          : JORGE VALIENTE
  FECHA          : 17/01/2014

  PARAMETROS              DESCRIPCION
  ============         ===================
   ISBIN               VALORES EN UNA CADENA

  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FSBRPTRAMITES(SBIN IN VARCHAR2) RETURN VARCHAR2;

  --ARANDA XXXX
  /*****************************************************************
  PROPIEDAD INTELECTUAL DE PETI (C).

  UNIDAD         : FSBCARRUSEL
  DESCRIPCION    : SERVICIO PARA ASIGNAR LA UNIADA OPERATIVA A
                   ORDENES CON TIPO DE CATEGORIA RESIDENCIAL.
                   REPACAION INMEDIATA.
  AUTOR          : JORGE VALIENTE
  FECHA          : 17/01/2014

  PARAMETROS              DESCRIPCION
  ============         ===================
   ISBIN               VALORES EN UNA CADENA

  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FSBCARRUSEL(SBIN IN VARCHAR2) RETURN VARCHAR2;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE PETI (C).

  UNIDAD         : FSBCARRUSELCOMERCIAL
  DESCRIPCION    : SERVICIO PARA ASIGNAR LA UNIADA OPERATIVA A
                   ORDENES CON TIPO DE CATEGORIA COMERCIAL.
  AUTOR          : JORGE VALIENTE
  FECHA          : 24/02/2014

  PARAMETROS              DESCRIPCION
  ============         ===================
   ISBIN               VALORES EN UNA CADENA

  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FSBCARRUSELCOMERCIAL(SBIN IN VARCHAR2) RETURN VARCHAR2;

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

  UNIDAD         : FSBLDCCAR
  DESCRIPCION    : SERVICIO PARA ASIGNARA UNIDAD OPERATIVA A ORDENES CONFIGURADAS EN
                   CARRUSEL GLOBAL CONFIGURADO EN LA APLICACION LDCCAR.
  AUTOR          : JORGE VALIENTE
  FECHA          : 22/07/2014

  PARAMETROS              DESCRIPCION
  ============         ===================
   ISBIN               VALORES EN UNA CADENA

  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FSBLDCCAR(SBIN IN VARCHAR2) RETURN VARCHAR2;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE PETI (C).

  UNIDAD         : FSBVISITAVALIDACION
  DESCRIPCION    : PROCESO QUE PERMITE ASIGNAR A LA ORDENE DE
                   REPARACI?N Y CERTIFICACI?N , CON LA UNIDAD OPERATIVA
                   ASIGNADA A LA ORDEN QUE SE LEGALIZO DE VISITA DE VALIDACI?N DE CERTIFICADO (10446)
                   O VISITA DE VALIDACION DE REPARACIONES (10445).

  AUTOR          : SAYRA OCORO
  FECHA          : 10/08/2014

  PARAMETROS              DESCRIPCION
  ============         ===================
  ISBIN               VALORES EN UNA CADENA

  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FSBVISITAVALIDACION(SBIN IN VARCHAR2) RETURN VARCHAR2;

  ---NC 4413
  /*****************************************************************
  PROPIEDAD INTELECTUAL DE PETI (C).

  UNIDAD         : FSBUTASIGOTANT
  DESCRIPCION    : Este servicio asigna la orden a la unidad de trabajo
                   de la orden inmediatamente anterior que se gener? en
                   la solicitud, siempre y cuando exista la configuraci?n
                   necesaria para que la ut realice el tipo de trabajo en el sector.

  AUTOR          : Lizeth Sanchez
  FECHA          : 18/12/2014

  PARAMETROS              DESCRIPCION
  ============         ===================
  ISBIN               VALORES EN UNA CADENA

  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  ******************************************************************/

  FUNCTION FSBUTASIGOTANT(SBIN IN VARCHAR2) RETURN VARCHAR2;

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

  FUNCTION FSBASIGOTACTSECTOR(SBIN IN VARCHAR2) RETURN VARCHAR2;
  ---

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE PETI (C).

  UNIDAD         : fsbASignaRP
  DESCRIPCION    : Este servicio asigna automaticamente la unidad operativa a las ordenes
                   de Revision periodica partiendo desde la asignacion de la OT 10444 del
                   tramite "100237 - Solic. visita identificacion certificado" que se genera
                   desde el OTREV

  AUTOR          : Oscar Parra - Optima
  FECHA          : 12/02/2015

  PARAMETROS              DESCRIPCION
  ============         ===================
  ISBIN               VALORES EN UNA CADENA

  FECHA            AUTOR                    MODIFICACION
  =========      ========================   ==========================================
  12/02/2015     oparra.Aranda 5753         1.Creacion
  24/05/2016     Oscar Ospino P. (ludycom)  2.(GDC CA200-304)
                                            Se agrega una validaci?n para que las ordenes con
                                            tipos de trabajos 10446 que se encuentren en una
                                            solicitud con tipo de trabajo 100101 y provenga de
                                            una orden con tipo de trabajo 10723, se asigne a la
                                            misma unidad operativa de la ?ltima orden legalizada
                                            con tipo de trabajo 10444 y que se encuentra en una
                                            solicitud con tipo de trabajo 100237
  ******************************************************************/
  FUNCTION fsbAsignaRP(SBIN IN VARCHAR2) RETURN VARCHAR2;

  -----ARANDA 144208
  /*****************************************************************
  PROPIEDAD INTELECTUAL DE PETI (C).

  UNIDAD         : FSBORDENREPARACION
  DESCRIPCION    : PROCESO QUE PERMITIRA OBTENER
                   LA UNIDAD OPERATIVA DE LA OT DE TIPO DE TRABAJO VISITA
                   IDENTIFICACION DE REPARACIONES.
  AUTOR          : JORGE VALIENTE
  FECHA          : 12/03/2015

  PARAMETROS              DESCRIPCION
  ============         ===================
   ISBIN               VALORES EN UNA CADENA

  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FSBORDENREPARACION(SBIN IN VARCHAR2) RETURN VARCHAR2;
  -----FIN ARANDA 144208

    ---Inicio CASO 200-2067
    /*****************************************************************
    PROPIEDAD INTELECTUAL DE PETI (C).

    UNIDAD         : PRASIGNACIONORIGEN
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
    17-08-2016      Sandra Mu?oz        CA200-398. Se modifica agreg?ndole un par?metro para la orden
                                        de trabajo que se desea asignar autom?ticamente, este
                                        par?metro se debe definir por defecto en null para que no
                                        afecte las funcionalidades ya existentes.
                                        Al cursor CULDC_ORDER se le agrega la validaci?n que filtre
                                        por n?mero de orden si este par?metro viene lleno
    ******************************************************************/
    PROCEDURE PRASIGNACIONORIGEN(inuOrden or_order.order_id%TYPE DEFAULT NULL);

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
                      dtFechaA   in date,
                      dtFechaC   in date,
                      nuSolici   in open.mo_packages.package_id%type,
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
    FROM   OPEN.LDC_ORDER LO, or_order o
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

    PROCEDURE proRegistraLogAsig( nuOrden IN or_order.order_id%TYPE,
                                  nuSolicitud IN mo_packages.package_id%TYPE,
                                  sbError IN VARCHAR2) IS
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

    UNIDAD         : FSBREVISIONPERIODICA
    DESCRIPCION    : PROCESO QUE PERMITIRA OBTENER
                     LA UNIDAD OPERATIVA DE LA SOLICITUD
                     REPACAION INMEDIATA.
    AUTOR          : JORGE VALIENTE
    FECHA          : 12/11/2013

    PARAMETROS              DESCRIPCION
    ============         ===================
     ISBIN               VALORES EN UNA CADENA

    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    20/Sep/2014     Jorge Valiente      NC3041: Como se manifiesta en el FANA asociadao
                                                en el TEAM 3041. se realiza la modificaicon
                                                solicitada por el consultor para cambiar
                                                la logica de validacion contenida el cursor CUOR_ORDER
                                                para el manejo de las fechas
    13/01/2015     Iv?n Cer?n           Cambio 5749: Se ajusta el cursor CUOR_ORDER
    ******************************************************************/
    FUNCTION FSBREVISIONPERIODICA(SBIN IN VARCHAR2) RETURN VARCHAR2 IS

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

        --CON ESTA ORDEN SE SABE EN EL CICLO QUE DATO VA
        --EN SECUENCIA PARA SABER CUAL DE LOS DATOS UTILIZAR
        ----------------------------------------------------

        ONUERRORCODE    NUMBER;
        OSBERRORMESSAGE VARCHAR2(4000);

        --SEPARA LOS DATOS OBTENIDOS DE LA CADENA DE ENTRADA
        --CON EL SEPARADOR |
        CURSOR CUDATA IS
            SELECT COLUMN_VALUE FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(SBIN, '|'));
        ---FIN CURSOR DATA

        --CURSOR PARA OBTENER EL VALOR DE LA UNIDAD OPERTAIVA
        --DE LA ORDEN ASOCIADA A LA SOLICUTUD DE
        --REVISION PERIODICA INMEDIATA
        /*  NC 3041
        Modificar en la l?nea
        AND P.REQUEST_DATE > DAMO_PACKAGES.FDTGETREQUEST_DATE(NUPACKAGE_ID)
        Cambiando el signo > (mayor) por < (menor)
        */
        CURSOR CUOR_ORDER(NUPACKAGE_ID MO_PACKAGES.PACKAGE_ID%TYPE) IS
            SELECT DISTINCT O.OPERATING_UNIT_ID
            FROM   OPEN.MO_PACKAGES       P,
                   OPEN.MO_MOTIVE         M,
                   OPEN.OR_ORDER_ACTIVITY OA,
                   OPEN.OR_ORDER          O,
                   OPEN.OR_TASK_TYPE      TT
            WHERE  M.PACKAGE_ID = P.PACKAGE_ID
            AND    OA.PACKAGE_ID = P.PACKAGE_ID
            AND    OA.ORDER_ID = O.ORDER_ID
            AND    TT.TASK_TYPE_ID = O.TASK_TYPE_ID
            AND    P.PACKAGE_TYPE_ID = 100101 --   SOLICITUD DE SERVICIO DE INGENIER?A
            AND    O.ORDER_STATUS_ID IN (5, 8) --   ASIGNADA O LEGALIZADA
            AND    OA.ACTIVITY_ID = 4000038 --   TRABAJOS POR REPARACI?N INMEDIATA POR RP
            AND    (p.request_date < open.damo_packages.fdtgetrequest_date(NUPACKAGE_ID) OR
                  p.request_date > open.DAMO_PACKAGES.FDTGETREQUEST_DATE(NUPACKAGE_ID))
            AND    M.PRODUCT_ID = (SELECT DISTINCT M.PRODUCT_ID
                                   FROM   OPEN.MO_PACKAGES P,
                                          OPEN.MO_MOTIVE   M
                                   WHERE  P.PACKAGE_ID = M.PACKAGE_ID
                                   AND    P.PACKAGE_ID = NUPACKAGE_ID
                                   AND    ROWNUM = 1)
            AND    ROWNUM = 1;

        TEMPCUOR_ORDER CUOR_ORDER%ROWTYPE;
        --FIN CURSOR CUDAOR_ORDER

        --CURSOR PARA IDENTIFICAR LAS ORDENES CON
        --DEFECTOS Y DETERMINAR SI SON O NO CRITICOS.
        CURSOR CUDEFECTORP(NUPACKAGE_ID MO_PACKAGES.PACKAGE_ID%TYPE,
                           NUORDER_ID   OR_ORDER.ORDER_ID%TYPE) IS
            SELECT O.ORDER_ID
            FROM   OR_ORDER O,
                   OR_ORDER_ACTIVITY OA,
                   (SELECT ITEMS_ID FROM OPEN.OR_ACT_BY_TASK_MOD WHERE TASK_CODE = 5) ITM
            WHERE  OA.ACTIVITY_ID = ITM.ITEMS_ID
            AND    O.ORDER_ID = OA.ORDER_ID
            AND    O.ORDER_STATUS_ID = 0
            AND    OA.PACKAGE_ID = NUPACKAGE_ID
            AND    O.ORDER_ID = NUORDER_ID;

        TEMPCUDEFECTORP CUDEFECTORP%ROWTYPE;

        --FIN CUDEFECTORP
        -------

        NUOPERATING_UNIT_ID OR_ORDER.OPERATING_UNIT_ID%TYPE;
        SBOPERATING_UNIT_ID VARCHAR2(4000);

        RCORDERTOASSIGN     DAOR_ORDER.STYOR_ORDER;
        RCORDERTOASSIGNNULL DAOR_ORDER.STYOR_ORDER;

        SBDATAIN VARCHAR2(4000);

        SBTRIGGER VARCHAR2(4000);

        SBCATEGORIA VARCHAR2(4000);

        NURESIDENIAL NUMBER := DALD_PARAMETER.fnuGetNumeric_Value('RESIDEN_CATEGORY', NULL);
        NUCOMERCIAL  NUMBER := DALD_PARAMETER.fnuGetNumeric_Value('COMMERCIAL_CATEGORY', NULL);
        SBCARRUSEL   VARCHAR2(4000) := NULL;

    BEGIN

        UT_TRACE.TRACE('INICIO LDC_BOASIGAUTO.FSBREVISIONPERIODICA', 10);

        /*
        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(-1, -1, 'INICIO LDC_BOASIGAUTO.FSBREVISIONPERIODICA');

        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(-1,
                                             -1,
                                             'LDC_BOASIGAUTO.FSBREVISIONPERIODICA, INGRESA A FSBVISITAVALIDACION CON EL DATO SBIN[' || SBIN || ']');
        */

        --15-08-2014 SOCORO
        SBOPERATING_UNIT_ID := FSBVISITAVALIDACION(SBIN);

        /*
        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(-1,
                                             -1,
                                             'LDC_BOASIGAUTO.FSBREVISIONPERIODICA, RESULTADO FSBVISITAVALIDACION SBOPERATING_UNIT_ID[' ||
                                             SBOPERATING_UNIT_ID || ']');
        */


        NUOPERATING_UNIT_ID := to_number(SBOPERATING_UNIT_ID);

        /*
        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(-1,
                                             -1,
                                             'LDC_BOASIGAUTO.FSBREVISIONPERIODICA, VALIDACION IF NUOPERATING_UNIT_ID[' ||
                                             NUOPERATING_UNIT_ID || '] = -1 THEN');
        */

        IF NUOPERATING_UNIT_ID = -1 THEN

            --OBTENER DATOS DE LA CADENA OBTENIDA DEL SERVICIO DE ASIGNACION
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
                ELSIF SBTRIGGER IS NULL THEN
                    SBTRIGGER       := TEMPCUDATA.COLUMN_VALUE;
                    OSBERRORMESSAGE := OSBERRORMESSAGE || ' - ' || SBTRIGGER;
                ELSIF SBCATEGORIA IS NULL THEN
                    SBCATEGORIA     := TEMPCUDATA.COLUMN_VALUE;
                    OSBERRORMESSAGE := OSBERRORMESSAGE || ' - ' || SBCATEGORIA;
                END IF;

            END LOOP;

            /*
            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                 TO_NUMBER(SBORDER_ID),
                                                 'LDC_BOASIGAUTO.FSBREVISIONPERIODICA, SBORDER_ID[' ||
                                                 SBORDER_ID || '] - SBPACKAGE_ID[' || SBPACKAGE_ID ||
                                                 '] - SBACTIVITY_ID[' || SBACTIVITY_ID ||
                                                 '] - SUBSCRIPTION_ID[' || SUBSCRIPTION_ID ||
                                                 '] - SBTRIGGER[' || SBTRIGGER ||
                                                 '] - SBCATEGORIA[' || SBCATEGORIA || ']');
            */

            NUOPERATING_UNIT_ID := NULL;

            /*
            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                 TO_NUMBER(SBORDER_ID),
                                                 'LDC_BOASIGAUTO.FSBREVISIONPERIODICA, INGRESA AL CURSOR CUDEFECTORP');
            */

            OPEN CUDEFECTORP(TO_NUMBER(SBPACKAGE_ID), TO_NUMBER(SBORDER_ID));
            FETCH CUDEFECTORP
                INTO TEMPCUDEFECTORP;
            IF CUDEFECTORP%FOUND THEN

                /*
                LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                     TO_NUMBER(SBORDER_ID),
                                                     'LDC_BOASIGAUTO.FSBREVISIONPERIODICA, PASO VALIDACION IF CUDEFECTORP%FOUND THEN - INGRESA AL CURSOR CUOR_ORDER CON EL DATO TO_NUMBER(SBPACKAGE_ID)[' ||
                                                     TO_NUMBER(SBPACKAGE_ID) || ']');
                */

                OPEN CUOR_ORDER(TO_NUMBER(SBPACKAGE_ID));
                FETCH CUOR_ORDER
                    INTO TEMPCUOR_ORDER;
                IF CUOR_ORDER%FOUND THEN
                    NUOPERATING_UNIT_ID := TEMPCUOR_ORDER.OPERATING_UNIT_ID;

                    BEGIN

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
                            --/*
                            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                                 TO_NUMBER(SBORDER_ID),
                                                                 'LA UNIDAD OPERATIVA NO FUE ASIGNADA A LA UNIDAD OPERATIVA [' ||
                                                                 NUOPERATING_UNIT_ID ||
                                                                 '] - MENSAJE DE ERROR PROVENIENTE DE os_assign_order --> ' ||
                                                                 osberrormessage);
                            --*/
                            --PRINTENTOSASIGNACION(TO_NUMBER(SBPACKAGE_ID), TO_NUMBER(SBORDER_ID));

                        END IF;

                    EXCEPTION
                        WHEN OTHERS THEN
                            SBDATAIN := 'INCONSISTENCIA EN SERVICIO FSBREVISIONPERIODICA [' ||
                                        DBMS_UTILITY.FORMAT_ERROR_STACK || '] - [' ||
                                        DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

                            --/*
                            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(NULL,
                                                                 TO_NUMBER(SBORDER_ID),
                                                                 'EL SERVICIO os_assign_order NO PUDO ASIGNAR LA UNIDAD OPERATIVA A LA ORDEN [' ||
                                                                 SBDATAIN || ']');
                            --*/
                    END;

                ELSE

                    /*
                    LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                         TO_NUMBER(SBORDER_ID),
                                                         'LDC_BOASIGAUTO.FSBREVISIONPERIODICA, INGRRESA A IF TO_NUMBER(SBCATEGORIA)[' ||
                                                         SBCATEGORIA || '] = NURESIDENIAL[' ||
                                                         NURESIDENIAL || '] THEN');
                    */

                    IF TO_NUMBER(SBCATEGORIA) = NURESIDENIAL THEN
                        /*
                        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                             TO_NUMBER(SBORDER_ID),
                                                             '1. TO_NUMBER(SBCATEGORIA) = NURESIDENIAL');
                        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                             TO_NUMBER(SBORDER_ID),
                                                             'LDC_BOASIGAUTO.FSBCARRUSEL SBIN --> ' || SBIN);
                        */
                        NUOPERATING_UNIT_ID := LDC_BOASIGAUTO.FSBCARRUSEL(SBIN);

                        SBCARRUSEL := 'CARRUSEL';

                    ELSIF TO_NUMBER(SBCATEGORIA) = NUCOMERCIAL THEN
                        /*
                        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                             TO_NUMBER(SBORDER_ID),
                                                             '2. TO_NUMBER(SBCATEGORIA) = NUCOMERCIAL');
                        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                             TO_NUMBER(SBORDER_ID),
                                                             'LDC_BOASIGAUTO.FSBCARRUSELCOMERCIAL SBIN --> ' || SBIN);
                        */
                        NUOPERATING_UNIT_ID := LDC_BOASIGAUTO.FSBCARRUSELCOMERCIAL(SBIN);

                        SBCARRUSEL := 'CARRUSEL';

                    ELSE
                        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                             TO_NUMBER(SBORDER_ID),
                                                             'LA CATEGORIA ASOCIADA A LA ORDEN ES [' ||
                                                             SBCATEGORIA ||
                                                             '] Y NO ES VALIDA PARA RESIDENCIAL Y COMERCIAL');
                    END IF;
                    NUOPERATING_UNIT_ID := -1;
                END IF;
            ELSE

                /*
                LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                     TO_NUMBER(SBORDER_ID),
                                                     'CATEGORIA PROVENIENTE DEL SERVICIO PRASIGNACION [' ||
                                                     TO_NUMBER(SBCATEGORIA) ||
                                                     '] - CATEGORIA CONFIGURADA EN PAQUETE RESIDENCIAL [' ||
                                                     NURESIDENIAL || '] COMERCIAL [' || NUCOMERCIAL || ']');
                */

                IF TO_NUMBER(SBCATEGORIA) = NURESIDENIAL THEN
                    /*
                    LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                         TO_NUMBER(SBORDER_ID),
                                                         '3. TO_NUMBER(SBCATEGORIA) = NURESIDENIAL');
                    LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                         TO_NUMBER(SBORDER_ID),
                                                         'LDC_BOASIGAUTO.FSBCARRUSEL SBIN --> ' || SBIN);
                    */
                    NUOPERATING_UNIT_ID := LDC_BOASIGAUTO.FSBCARRUSEL(SBIN);

                    SBCARRUSEL := 'CARRUSEL';

                ELSIF TO_NUMBER(SBCATEGORIA) = NUCOMERCIAL THEN
                    /*
                    LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                         TO_NUMBER(SBORDER_ID),
                                                         '4. TO_NUMBER(SBCATEGORIA) = NUCOMERCIAL');
                    LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                         TO_NUMBER(SBORDER_ID),
                                                         'LDC_BOASIGAUTO.FSBCARRUSELCOMERCIAL SBIN --> ' || SBIN);
                    */
                    NUOPERATING_UNIT_ID := LDC_BOASIGAUTO.FSBCARRUSELCOMERCIAL(SBIN);

                    SBCARRUSEL := 'CARRUSEL';

                ELSE
                    LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                         TO_NUMBER(SBORDER_ID),
                                                         'LA CATEGORIA ASOCIADA A LA ORDEN ES [' ||
                                                         SBCATEGORIA ||
                                                         '] Y NO ES VALIDA PARA RESIDENCIAL Y COMERCIAL');
                END IF;
                NUOPERATING_UNIT_ID := -1;
            END IF;
            CLOSE CUDEFECTORP;

            UT_TRACE.TRACE('FIN LDC_BOASIGAUTO.FSBREVISIONPERIODICA', 10);

            IF SBCARRUSEL = 'CARRUSEL' THEN
                RETURN(SBCARRUSEL);
            ELSE
                RETURN(NUOPERATING_UNIT_ID);
            END IF;
        ELSE
            RETURN(NUOPERATING_UNIT_ID);
        END IF; --SOCORO

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            --ROLLBACK;
            ONUERRORCODE    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            OSBERRORMESSAGE := 'INCONVENIENTES AL ASIGNAR LA UNIDAD OPERTAIVA DE SOLICUTD INMEDIATA A LAS ORDENES GENERADAS POR DEFECTO DE REPARACION PERIODICA' ||
                               PKERRORS.FSBGETERRORMESSAGE;

            OSBERRORMESSAGE := OSBERRORMESSAGE || ' - ' || DBMS_UTILITY.FORMAT_ERROR_STACK || ' - ' ||
                               DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;

            --/*
            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                 TO_NUMBER(SBORDER_ID),
                                                 OSBERRORMESSAGE);
            --*/

            --RETURN(NULL);
            RETURN(-1);

        WHEN OTHERS THEN
            --ROLLBACK;
            ONUERRORCODE    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            OSBERRORMESSAGE := 'INCONVENIENTES AL ASIGNAR LA UNIDAD OPERTAIVA DE SOLICUTD INMEDIATA A LAS ORDENES GENERADAS POR DEFECTO DE REPARACION PERIODICA' ||
                               PKERRORS.FSBGETERRORMESSAGE;
            OSBERRORMESSAGE := OSBERRORMESSAGE || ' - ' || DBMS_UTILITY.FORMAT_ERROR_STACK || ' - ' ||
                               DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;

            --/*
            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                 TO_NUMBER(SBORDER_ID),
                                                 OSBERRORMESSAGE);
            --*/

            --RETURN(NULL);
            RETURN(-1);

    END FSBREVISIONPERIODICA;

    /*****************************************************************
    PROPIEDAD INTELECTUAL DE PETI (C).

    UNIDAD         : FSBVALIDANOTIFICACION
    DESCRIPCION    : PROCESO QUE PERMITIRA OBTENER
                     LA UNIDAD OPERATIVA DE LA ORDEN DE REVISION PERIODICA
                     DE LA SOLICITUD DE REVISION INMEDIATA.
    AUTOR          : JORGE VALIENTE
    FECHA          : 12/11/2013

    PARAMETROS              DESCRIPCION
    ============         ===================
     ISBIN               VALORES EN UNA CADENA

    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    ******************************************************************/
    FUNCTION FSBVALIDANOTIFICACION(SBIN IN VARCHAR2) RETURN VARCHAR2 IS

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

        --CON ESTA ORDEN SE SABE EN EL CICLO QUE DATO VA
        --EN SECUENCIA PARA SABER CUAL DE LOS DATOS UTILIZAR
        ----------------------------------------------------

        --SEPARA LOS DATOS OBTENIDOS DE LA CADENA DE ENTRADA
        --CON EL SEPARADOR |
        CURSOR CUDATA IS
            SELECT COLUMN_VALUE FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(SBIN, '|'));
        ---FIN CURSOR DATA

        --SEPARA LOS DATOS OBTENIDOS DE LA CADENA DE ENTRADA
        --CON EL SEPARADOR |
        CURSOR CUNOTIFICACION(NUPACKAGE_ID MO_PACKAGES.PACKAGE_ID%TYPE) IS
            SELECT OOA.ORDER_ID
            FROM   OR_ORDER_ACTIVITY OOA
            WHERE  OOA.PACKAGE_ID = NUPACKAGE_ID
            AND    OOA.ACTIVITY_ID = 4000601
            AND    DAOR_ORDER.FNUGETOPERATING_UNIT_ID(OOA.ORDER_ID) = 0
            AND    ROWNUM = 1;

        TEMPCUNOTIFICACION CUNOTIFICACION%ROWTYPE;
        ---FIN CURSOR DATA

        ONUERRORCODE    NUMBER;
        OSBERRORMESSAGE VARCHAR2(4000);

        NUOPERATING_UNIT_ID OR_ORDER.OPERATING_UNIT_ID%TYPE;

        RCORDERTOASSIGN     DAOR_ORDER.STYOR_ORDER;
        RCORDERTOASSIGNNULL DAOR_ORDER.STYOR_ORDER;

    BEGIN

        UT_TRACE.TRACE('INICIO LDC_BOASIGAUTO.FSBVALIDANOTIFICACION', 10);

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
            END IF;

        END LOOP;

        OPEN CUNOTIFICACION(TO_NUMBER(SBPACKAGE_ID));
        FETCH CUNOTIFICACION
            INTO TEMPCUNOTIFICACION;
        IF CUNOTIFICACION%FOUND THEN
            NUOPERATING_UNIT_ID := DAOR_ORDER.FNUGETOPERATING_UNIT_ID(TO_NUMBER(SBORDER_ID), NULL);
            RCORDERTOASSIGN     := RCORDERTOASSIGNNULL;
            DAOR_ORDER.GETRECORD(TEMPCUNOTIFICACION.ORDER_ID, RCORDERTOASSIGN);
            --RCORDERTOASSIGNANTES:= RCORDERTOASSIGN;
            BEGIN
                OR_BOPROCESSORDER.ASSIGN(RCORDERTOASSIGN,
                                         NUOPERATING_UNIT_ID,
                                         NULL,
                                         TRUE,
                                         FALSE,
                                         NULL,
                                         NULL,
                                         FALSE,
                                         NULL,
                                         FALSE,
                                         NULL,
                                         NULL);
            EXCEPTION
                WHEN OTHERS THEN
                    NULL;
            END;
        ELSE
            NUOPERATING_UNIT_ID := NULL;
        END IF;
        CLOSE CUNOTIFICACION;

        UT_TRACE.TRACE('FIN LDC_BOASIGAUTO.FSBVALIDANOTIFICACION', 10);

        RETURN(NUOPERATING_UNIT_ID);

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            --ROLLBACK;
            ONUERRORCODE    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            OSBERRORMESSAGE := 'INCONVENIENTES AL ASIGNAR LA UNIDAD OPERTAIVA DE SOLICUTD INMEDIATA A LAS ORDENES GENERADAS POR DEFECTO DE REPARACION PERIODICA' ||
                               PKERRORS.FSBGETERRORMESSAGE;
            --DBMS_UTILITY.FORMAT_ERROR_STACK || ' - ' ||
            --DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
            RETURN(NULL);

        WHEN OTHERS THEN
            --ROLLBACK;
            ONUERRORCODE    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            OSBERRORMESSAGE := 'INCONVENIENTES AL ASIGNAR LA UNIDAD OPERTAIVA DE SOLICUTD INMEDIATA A LAS ORDENES GENERADAS POR DEFECTO DE REPARACION PERIODICA' ||
                               PKERRORS.FSBGETERRORMESSAGE;
            --DBMS_UTILITY.FORMAT_ERROR_STACK ||PKERRORS.FSBGETERRORMESSAGE;--'INCONVENIENTES AL CONSULTAR EL CODIGO [' || ISBID || '] ' ||
            --DBMS_UTILITY.FORMAT_ERROR_STACK || ' - ' ||
            --DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
            RETURN(NULL);

    END FSBVALIDANOTIFICACION;

    /*****************************************************************
    PROPIEDAD INTELECTUAL DE PETI (C).

    UNIDAD         : FSBPUNTOFIJO
    DESCRIPCION    : PROCESO QUE OBTIENE LAS UNIDADES OPERATIVAS
                     CAPACITAS PARA ATENDER LA ORDEN DE VISITA DE PUNTOS
                     DIJOS, DADA LA SOLICITUD.

    AUTOR          : JORGE VALIENTE
    FECHA          : 13/11/2013

    PARAMETROS              DESCRIPCION
    ============         ===================
     ISBIN               VALORES EN UNA CADENA

    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    09-12-2013      sergiom             NC 2107. Se modifica el proceso de obtenci?n de las unidades operativas
                                        capacitadas para atender la orden de visita, de acuerdo a las
                                        configuraciones de la linea y sublinea del producto.
    ******************************************************************/
    FUNCTION FSBPUNTOFIJO(SBIN IN VARCHAR2) RETURN VARCHAR2 IS

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

        --obtiene las unidades operativa para la solicitud
        --iotbOpUnits
        CURSOR cuOperatingUnits(inuPackage_id IN mo_packages.package_id%TYPE,
                                inuOrderId    IN OR_order.order_id%TYPE) IS
            SELECT UO.operating_unit_id Unidad_Opertiva,
                   UO.availableTime,
                   UO.assignedTime,
                   decode(AD.shape.SDO_POINT.X + X1 + AD.shape.SDO_POINT.Y + Y1,
                          NULL,
                          0,
                          sqrt(power((AD.shape.SDO_POINT.X - X1), 2) +
                               Power((AD.shape.SDO_POINT.Y - Y1), 2))) distancia
            FROM   (SELECT DISTINCT OPUN.operating_unit_id,
                                    OPUN.starting_address,
                                    nvl(OPUN.used_assign_cap, 0) assignedTime,
                                    (nvl(OPUN.assign_capacity, 0) - nvl(OPUN.used_assign_cap, 0)) availableTime,
                                    OPUN.admin_base_id,
                                    ADBA.direccion,
                                    nvl(OPUN.starting_address, ADBA.direccion) dir,
                                    ORD.X X1,
                                    ORD.Y Y1
                    FROM   open.ld_segmen_supplier  SESU,
                           open.ld_sales_visit      SAVI,
                           open.or_operating_unit   OPUN,
                           open.ld_subline          SUBL,
                           open.or_oper_unit_status UTSTA,
                           open.ge_base_administra  ADBA,
                           open.OR_ORDER_ACTIVITY   ORDA,
                           open.or_order            ORD
                    WHERE  OPUN.oper_unit_status_id = UTSTA.oper_unit_status_id
                    AND    UTSTA.valid_for_assign = 'Y'
                    AND    OPUN.contractor_id = SESU.supplier_id
                    AND    SUBL.subline_id = SAVI.item_id
                    AND    (SUBL.subline_id = SESU.subline_id OR SESU.subline_id IS NULL)
                    AND    SUBL.line_id = SESU.line_id
                    AND    OPUN.assign_type = 'C'
                    AND    ORDA.package_id = SAVI.package_id
                    AND    ORDA.order_id = ORD.order_id
                    AND    OPUN.admin_base_id = ADBA.id_base_administra
                    AND    SAVI.package_id = inuPackage_id
                    AND    ORD.order_id = inuOrderId) UO,
                   ab_address AD
            WHERE  AD.address_id = UO.dir
            ORDER  BY distancia    ASC,
                      assignedTime ASC;
        --*/

    BEGIN

        UT_TRACE.TRACE('INICIO LDC_BOASIGAUTO.FSBPUNTOFIJO', 10);

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
            END IF;

        END LOOP;

        UPDATE OR_ORDER_ACTIVITY
        SET    ORDER_ID = TO_NUMBER(SBORDER_ID)
        WHERE  PACKAGE_ID = TO_NUMBER(SBPACKAGE_ID)
        AND    ACTIVITY_ID = TO_NUMBER(SBACTIVITY_ID);

        NUOPERATING_UNIT_ID := -1;

        FOR tempcuOperatingUnits IN cuOperatingUnits(TO_NUMBER(SBPACKAGE_ID), TO_NUMBER(SBORDER_ID)) LOOP

            NUOPERATING_UNIT_ID := tempcuOperatingUnits.Unidad_Opertiva;
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
                --/*
                LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                     TO_NUMBER(SBORDER_ID),
                                                     'LA UNIDAD OPERATIVA NO FUE ASIGNADA A LA UNIDAD OPERATIVA [' ||
                                                     NUOPERATING_UNIT_ID ||
                                                     '] - MENSAJE DE ERROR PROVENIENTE DE os_assign_order --> ' ||
                                                     osberrormessage);
                --*/
                --PRINTENTOSASIGNACION(TO_NUMBER(SBPACKAGE_ID), TO_NUMBER(SBORDER_ID));
            END IF;

            dbms_output.put_line('********************************************');

            NUOPERATING_UNIT_ID := tempcuOperatingUnits.Unidad_Opertiva;

        END LOOP;

        UT_TRACE.TRACE('FIN LDC_BOASIGAUTO.FSBPUNTOFIJO', 10);

        RETURN(NUOPERATING_UNIT_ID);

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            --ROLLBACK;
            ONUERRORCODE    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            OSBERRORMESSAGE := PKERRORS.FSBGETERRORMESSAGE || ' - STACK [' ||
                               DBMS_UTILITY.FORMAT_ERROR_STACK || '] - BACKTRACE [' ||
                               DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

            --/*
            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                 TO_NUMBER(SBORDER_ID),
                                                 'LDC_BOASIGAUTO.FSBPUNTOFIJO - CODIGO [' ||
                                                 ONUERRORCODE || '] DESCRIPCION [' ||
                                                 OSBERRORMESSAGE || ']');
            --*/
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

    END FSBPUNTOFIJO;

    /*****************************************************************
    PROPIEDAD INTELECTUAL DE PETI (C).

    UNIDAD         : FSBRPREGENERADA
    DESCRIPCION    : PROCESO QUE PERMITE ASIGNAR A LA ORDENE DE
                     REVISION PERIODICA REGNERADA, A LA UNIDAD OPERATIVA
                     ASIGNADA A LA ORDEN DE NOTIFICACION DE RP.

    AUTOR          : JORGE VALIENTE
    FECHA          : 13/11/2013

    PARAMETROS              DESCRIPCION
    ============         ===================
     ISBIN               VALORES EN UNA CADENA

    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    ******************************************************************/
    FUNCTION FSBRPREGENERADA(SBIN IN VARCHAR2) RETURN VARCHAR2 IS

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

        RCORDERTOASSIGN     DAOR_ORDER.STYOR_ORDER;
        RCORDERTOASSIGNNULL DAOR_ORDER.STYOR_ORDER;

        --CUROSR PARA OBTENER LA UNIDAD OPERATIVA CONVEINETE
        --PARA ESA ORDEN DE PUNTO FIJO
        CURSOR CUUNIDADOPERATIVA(NUPACKAGE_ID MO_PACKAGES.PACKAGE_ID%TYPE,
                                 NUORDER_ID   OR_ORDER.ORDER_ID%TYPE) IS
            SELECT ORDER_ID,
                   OPERATING_UNIT_ID
            FROM   (SELECT OA.ORDER_ID,
                           (SELECT O.OPERATING_UNIT_ID
                            FROM   OPEN.OR_ORDER          ORD,
                                   OPEN.OR_ORDER_ACTIVITY ORA
                            WHERE  ORA.PACKAGE_ID = NUPACKAGE_ID
                            AND    ORA.PACKAGE_ID = OA.PACKAGE_ID
                            AND    ORD.ORDER_ID = ORA.ORDER_ID
                            AND    ORA.ACTIVITY_ID IN
                                   (4000062, 4294485, 4294475, 4294468, 4294469, 4294467) -- ACTIVIDADES DE REVISI?N PERI?DICA
                            AND    ORD.ORDER_STATUS_ID = 8 --ORDEN DE NOTIFICACI?N DE RP LEGALIZADA
                            AND    ROWNUM = 1) OPERATING_UNIT_ID
                    FROM   OPEN.OR_ORDER_ACTIVITY OA,
                           OPEN.OR_ORDER          O
                    WHERE  OA.ORDER_ID = O.ORDER_ID
                    AND    OA.ACTIVITY_ID IN (4000062, 4294485, 4294475, 4294468, 4294469, 4294467) --ACTIVIDAD DE REVISI?N PERI?DICA
                    AND    O.ORDER_STATUS_ID = 0 -- ORDEN DE RP REGISTRADA
                    AND    O.ORDER_ID = NUORDER_ID)
            WHERE  OPERATING_UNIT_ID IS NOT NULL;

        TEMPCUUNIDADOPERATIVA CUUNIDADOPERATIVA%ROWTYPE;
        --FIN CUUNIDADOPERATIVA

    BEGIN

        UT_TRACE.TRACE('INICIO LDC_BOASIGAUTO.FSBRPREGENERADA', 10);

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
            END IF;

        END LOOP;

        OPEN CUUNIDADOPERATIVA(TO_NUMBER(SBPACKAGE_ID), TO_NUMBER(SBORDER_ID));
        FETCH CUUNIDADOPERATIVA
            INTO TEMPCUUNIDADOPERATIVA;
        IF CUUNIDADOPERATIVA%FOUND THEN
            NUOPERATING_UNIT_ID := TEMPCUUNIDADOPERATIVA.OPERATING_UNIT_ID;
            RCORDERTOASSIGN     := RCORDERTOASSIGNNULL;
            DAOR_ORDER.GETRECORD(TO_NUMBER(SBORDER_ID), RCORDERTOASSIGN);
            --RCORDERTOASSIGNANTES:= RCORDERTOASSIGN;
            BEGIN
                OR_BOPROCESSORDER.ASSIGN(RCORDERTOASSIGN,
                                         NUOPERATING_UNIT_ID,
                                         NULL,
                                         TRUE,
                                         FALSE,
                                         NULL,
                                         NULL,
                                         FALSE,
                                         NULL,
                                         FALSE,
                                         NULL,
                                         NULL);
            EXCEPTION
                WHEN OTHERS THEN
                    NULL;
            END;
        ELSE
            NUOPERATING_UNIT_ID := NULL;
        END IF;
        CLOSE CUUNIDADOPERATIVA;

        UT_TRACE.TRACE('FIN LDC_BOASIGAUTO.FSBRPREGENERADA', 10);

        RETURN(NUOPERATING_UNIT_ID);

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            --ROLLBACK;
            ONUERRORCODE    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            OSBERRORMESSAGE := 'INCONVENIENTES AL ASIGNAR LA UNIDAD OPERTAIVA DE SOLICUTD INMEDIATA A LAS ORDENES GENERADAS POR DEFECTO DE REPARACION PERIODICA' ||
                               PKERRORS.FSBGETERRORMESSAGE;
            --DBMS_UTILITY.FORMAT_ERROR_STACK || ' - ' ||
            --DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
            RETURN(NULL);

        WHEN OTHERS THEN
            --ROLLBACK;
            ONUERRORCODE    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            OSBERRORMESSAGE := 'INCONVENIENTES AL ASIGNAR LA UNIDAD OPERTAIVA DE SOLICUTD INMEDIATA A LAS ORDENES GENERADAS POR DEFECTO DE REPARACION PERIODICA' ||
                               PKERRORS.FSBGETERRORMESSAGE;
            --DBMS_UTILITY.FORMAT_ERROR_STACK ||PKERRORS.FSBGETERRORMESSAGE;--'INCONVENIENTES AL CONSULTAR EL CODIGO [' || ISBID || '] ' ||
            --DBMS_UTILITY.FORMAT_ERROR_STACK || ' - ' ||
            --DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
            RETURN(NULL);

    END FSBRPREGENERADA;

    /*****************************************************************
    PROPIEDAD INTELECTUAL DE PETI (C).

    UNIDAD         : FSBCOTIZADA
    DESCRIPCION    : PROCESO QUE PERMITE ASIGNAR A LA ORDENE DE
                     COTIZACION , CON LA UNIDAD OPERATIVA
                     ASIGNADA A LA ORDEN QUE SE LEGALIZO DE COTIZACION.

    AUTOR          : JORGE VALIENTE
    FECHA          : 13/11/2013

    PARAMETROS              DESCRIPCION
    ============         ===================
    ISBIN               VALORES EN UNA CADENA

    FECHA                AUTOR             MODIFICACION
    =========          =========           ====================
    09-Marzo-2015   Jorge Valiente    Cambio 6379: Cambio que determina si la gasera
                                                   coloca en la forma CONFGLOBAL en el
                                                   parametro OSS_JLVM_CAMBIO_6379
                                                   Validar causal de legalizacion
                                                   en GasCaribe mediante un parametro
    ******************************************************************/
    FUNCTION FSBCOTIZADA(SBIN IN VARCHAR2) RETURN VARCHAR2 IS

        SBORDER_ID      VARCHAR2(4000) := NULL;
        SBPACKAGE_ID    VARCHAR2(4000) := NULL;
        SBACTIVITY_ID   VARCHAR2(4000) := NULL;
        SUBSCRIPTION_ID VARCHAR2(4000) := NULL;

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

        RCORDERTOASSIGN     DAOR_ORDER.STYOR_ORDER;
        RCORDERTOASSIGNNULL DAOR_ORDER.STYOR_ORDER;

        --CUROSR PARA OBTENER LA UNIDAD OPERATIVA CONVEINETE
        --PARA ESA ORDEN DE PUNTO FIJO
        CURSOR CUUNIDADOPERATIVA(NUPACKAGE_ID MO_PACKAGES.PACKAGE_ID%TYPE,
                                 NUORDER_ID   OR_ORDER.ORDER_ID%TYPE) IS
            SELECT O.ORDER_ID,
                   O.OPERATING_UNIT_ID,
                   OA1.ORDER_ACTIVITY_ID,
                   o.causal_id
            FROM   OPEN.OR_ORDER          O,
                   OPEN.OR_ORDER_ACTIVITY OA1,
                   OPEN.MO_PACKAGES       P,
                   OPEN.MO_MOTIVE         M
            WHERE  O.ORDER_ID = OA1.ORDER_ID
            AND    OA1.PACKAGE_ID = NUPACKAGE_ID
            AND    OA1.PACKAGE_ID = P.PACKAGE_ID
            AND    P.PACKAGE_ID = M.PACKAGE_ID
                  -- AND O.ORDER_STATUS_ID = 8 -- ORDEN CERRADA
                  --AND OA1.ACTIVITY_ID IN (4000056, 4295146, 4295148, 4295357) -- ACTIVIDAD COTIZAR TRABAJOS VARIOS, REPARACI?N INMEDIATA POR EMERGENCIA, COTIZAR TRABAJOS VARIOS POR BRILLA
            AND    OA1.ACTIVITY_ID IN
                   (SELECT TO_NUMBER(column_value)
                     FROM   TABLE(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('ACTIVIDAD_COTIZADA',
                                                                                                NULL),
                                                               ',')))
                  --AND P.MOTIVE_STATUS_ID = 13 -- SOLICITUD ABIERTA
            AND    OA1.ACTIVITY_GROUP_ID IS NULL
            AND    ROWNUM = 1;

        TEMPCUUNIDADOPERATIVA CUUNIDADOPERATIVA%ROWTYPE;
        --FIN CUUNIDADOPERATIVA

        --cambio 6379
        --variable

        CURSOR CUEXISTE(NUDATO      NUMBER,
                        SBPARAMETRO LD_PARAMETER.VALUE_CHAIN%TYPE) IS
            SELECT COUNT(1) cantidad
            FROM   DUAL
            WHERE  NUDATO IN
                   (SELECT to_number(column_value)
                    FROM   TABLE(ldc_boutilities.splitstrings(SBPARAMETRO, ',')));

        nucantidad NUMBER;
        NUCAUSAL   NUMBER;

        sbCOD_CAUSAL_COTIZA_GDC LD_PARAMETER.VALUE_CHAIN%TYPE := OPEN.DALD_PARAMETER.fsbGetValue_Chain('COD_CAUSAL_COTIZA_GDC',
                                                                                                       NULL);

        sbOSS_JLVM_CAMBIO_6379 CONSTANT VARCHAR2(100) := 'OSS_JLVM_CAMBIO_6379';

        --fin cambio 6379

    BEGIN

        UT_TRACE.TRACE('INICIO LDC_BOASIGAUTO.FSBCOTIZADA', 10);

        FOR TEMPCUDATA IN CUDATA LOOP

            UT_TRACE.TRACE(TEMPCUDATA.COLUMN_VALUE, 10);

            IF SBORDER_ID IS NULL THEN
                SBORDER_ID      := TEMPCUDATA.COLUMN_VALUE;
                OSBERRORMESSAGE := '[ORDEN - ' || SBORDER_ID || ']';
            ELSIF SBPACKAGE_ID IS NULL THEN
                SBPACKAGE_ID    := TEMPCUDATA.COLUMN_VALUE;
                OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [SOLICITUD - ' || SBPACKAGE_ID || ']';
            ELSIF SBACTIVITY_ID IS NULL THEN
                SBACTIVITY_ID   := TEMPCUDATA.COLUMN_VALUE;
                OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [ACTIVIDAD - ' || SBACTIVITY_ID || ']';
            ELSIF SUBSCRIPTION_ID IS NULL THEN
                SUBSCRIPTION_ID := TEMPCUDATA.COLUMN_VALUE;
                OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [CONTRATO - ' || SUBSCRIPTION_ID || ']';
            END IF;

        END LOOP;

        NUOPERATING_UNIT_ID := NULL;
        --NUOPERATING_UNIT_ID := -1;

        /*
        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                             TO_NUMBER(SBORDER_ID),
                                             'LDC_BOASIGAUTO.FSBCOTIZADA, ANTES DE INGRESAR AL CURSOR CUUNIDADOPERATIVA');
        */
        OPEN CUUNIDADOPERATIVA(TO_NUMBER(SBPACKAGE_ID), TO_NUMBER(SBORDER_ID));
        FETCH CUUNIDADOPERATIVA
            INTO TEMPCUUNIDADOPERATIVA;
        IF CUUNIDADOPERATIVA%FOUND THEN

            --cambio 6379
            IF LDC_CONFIGURACIONRQ.aplicaParaEfigas(sbOSS_JLVM_CAMBIO_6379) OR
               LDC_CONFIGURACIONRQ.aplicaParaSurtigas(sbOSS_JLVM_CAMBIO_6379) OR
               LDC_CONFIGURACIONRQ.aplicaParaGDC(sbOSS_JLVM_CAMBIO_6379) OR
               LDC_CONFIGURACIONRQ.aplicaParaGDO(sbOSS_JLVM_CAMBIO_6379) THEN
                OPEN CUEXISTE(TEMPCUUNIDADOPERATIVA.CAUSAL_ID, sbCOD_CAUSAL_COTIZA_GDC);
                FETCH CUEXISTE
                    INTO nucantidad;
                IF nucantidad = 1 THEN
                    NUOPERATING_UNIT_ID := TEMPCUUNIDADOPERATIVA.OPERATING_UNIT_ID;
                ELSE
                    NUOPERATING_UNIT_ID := -1;
                END IF;
                CLOSE CUEXISTE;
            ELSE
                NUOPERATING_UNIT_ID := TEMPCUUNIDADOPERATIVA.OPERATING_UNIT_ID;
            END IF;
            --fin cambio 6379

            IF NVL(NUOPERATING_UNIT_ID, -1) <> -1 THEN

                /*
                LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                     TO_NUMBER(SBORDER_ID),
                                                     'LDC_BOASIGAUTO.FSBCOTIZADA, UNIDAD OPERATIVA ENCONTRADA [' ||
                                                     NUOPERATING_UNIT_ID || ']');
                */

                BEGIN

                    /*
                    LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                         TO_NUMBER(SBORDER_ID),
                                                         'LDC_BOASIGAUTO.FSBCOTIZADA, ANTES DE UTILIZAR EL SERVICIO os_assign_order');
                    */

                    os_assign_order(TO_NUMBER(SBORDER_ID),
                                    NUOPERATING_UNIT_ID,
                                    SYSDATE,
                                    SYSDATE,
                                    onuerrorcode,
                                    osberrormessage);

                    /*
                    LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                         TO_NUMBER(SBORDER_ID),
                                                         'LDC_BOASIGAUTO.FSBCOTIZADA, DESPUES DE UTILIZAR EL SERVICIO os_assign_order ERROR CODIGO[' ||
                                                         onuerrorcode || '] MENSAJE[' ||
                                                         osberrormessage || ']');
                    */

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

                EXCEPTION
                    WHEN OTHERS THEN
                        osberrormessage := 'INCONSISTENCIA TRIGGER TRGAFTERASIGAUTO [' ||
                                           DBMS_UTILITY.FORMAT_ERROR_STACK || '] - [' ||
                                           DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

                        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                             TO_NUMBER(SBORDER_ID),
                                                             'EL SERVICIO os_assign_order NO PUDO ASIGNAR LA UNIDAD OPERATIVA A LA ORDEN [' ||
                                                             osberrormessage ||
                                                             '] Unidad de trabajo [' ||
                                                             NUOPERATING_UNIT_ID || ']');
                END;
                --*/

            END IF; --VALIDAR UNIDAD OPERATIVA DIFERENTE A -1
        ELSE
            NUOPERATING_UNIT_ID := NULL;
            --NUOPERATING_UNIT_ID := -1;
            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                 TO_NUMBER(SBORDER_ID),
                                                 'LDC_BOASIGAUTO.FSBCOTIZADA, NO EXISTE REGISTRO EN EL CURSOR CUUNIDADOPERATIVA');

        END IF;
        CLOSE CUUNIDADOPERATIVA;

        UT_TRACE.TRACE('FIN LDC_BOASIGAUTO.FSBCOTIZADA', 10);

        --cambio 6379
        IF LDC_CONFIGURACIONRQ.aplicaParaEfigas(sbOSS_JLVM_CAMBIO_6379) OR
           LDC_CONFIGURACIONRQ.aplicaParaSurtigas(sbOSS_JLVM_CAMBIO_6379) OR
           LDC_CONFIGURACIONRQ.aplicaParaGDC(sbOSS_JLVM_CAMBIO_6379) OR
           LDC_CONFIGURACIONRQ.aplicaParaGDO(sbOSS_JLVM_CAMBIO_6379) THEN
            NUOPERATING_UNIT_ID := -1;
        END IF;
        --fin cambio 6379

        RETURN(NUOPERATING_UNIT_ID);

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            --ROLLBACK;
            ONUERRORCODE    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            OSBERRORMESSAGE := 'INCONVENIENTES AL ASIGNAR LA UNIDAD OPERTAIVA DE SOLICUTD INMEDIATA A LAS ORDENES GENERADAS POR DEFECTO DE REPARACION PERIODICA' ||
                               PKERRORS.FSBGETERRORMESSAGE;
            OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [' || DBMS_UTILITY.FORMAT_ERROR_STACK ||
                               ' - [' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                 TO_NUMBER(SBORDER_ID),
                                                 OSBERRORMESSAGE);

            COMMIT;

            RETURN(-1);

        WHEN OTHERS THEN
            --ROLLBACK;
            ONUERRORCODE    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            OSBERRORMESSAGE := 'INCONVENIENTES AL ASIGNAR LA UNIDAD OPERTAIVA DE SOLICUTD INMEDIATA A LAS ORDENES GENERADAS POR DEFECTO DE REPARACION PERIODICA' ||
                               PKERRORS.FSBGETERRORMESSAGE;
            OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [' || DBMS_UTILITY.FORMAT_ERROR_STACK ||
                               ' - [' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                 TO_NUMBER(SBORDER_ID),
                                                 OSBERRORMESSAGE);

            COMMIT;

            RETURN(-1);

    END FSBCOTIZADA;

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
    FUNCTION FSBPUNTOATENCION(SBIN IN VARCHAR2) RETURN VARCHAR2 IS
        --PRAGMA AUTONOMOUS_TRANSACTION;
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

        RCORDERTOASSIGN     DAOR_ORDER.STYOR_ORDER;
        RCORDERTOASSIGNNULL DAOR_ORDER.STYOR_ORDER;

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
        --FIN CUUNIDADOPERATIVA

    BEGIN

        UT_TRACE.TRACE('INICIO LDC_BOASIGAUTO.FSBPUNTOATENCION', 10);

        FOR TEMPCUDATA IN CUDATA LOOP

            UT_TRACE.TRACE(TEMPCUDATA.COLUMN_VALUE, 10);

            IF SBORDER_ID IS NULL THEN
                SBORDER_ID      := TEMPCUDATA.COLUMN_VALUE;
                OSBERRORMESSAGE := '[ORDEN - ' || SBORDER_ID || ']';
            ELSIF SBPACKAGE_ID IS NULL THEN
                SBPACKAGE_ID    := TEMPCUDATA.COLUMN_VALUE;
                OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [SOLICITUD - ' || SBPACKAGE_ID || ']';
            ELSIF SBACTIVITY_ID IS NULL THEN
                SBACTIVITY_ID   := TEMPCUDATA.COLUMN_VALUE;
                OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [ACTIVIDAD - ' || SBACTIVITY_ID || ']';
            ELSIF SUBSCRIPTION_ID IS NULL THEN
                SUBSCRIPTION_ID := TEMPCUDATA.COLUMN_VALUE;
                OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [CONTRATO - ' || SUBSCRIPTION_ID || ']';
            END IF;

        END LOOP;

        NUOPERATING_UNIT_ID := -1;

        /*
        LDC_BOASIGAUTO.PRREGSITROASIGAUTO(TO_NUMBER(SBPACKAGE_ID),
                                          TO_NUMBER(SBORDER_ID),
                                          OSBERRORMESSAGE);

        --*/

        OPEN CUUNIDADOPERATIVA(TO_NUMBER(SBPACKAGE_ID));
        FETCH CUUNIDADOPERATIVA
            INTO TEMPCUUNIDADOPERATIVA;
        IF CUUNIDADOPERATIVA%FOUND THEN
            NUOPERATING_UNIT_ID := TO_NUMBER(TEMPCUUNIDADOPERATIVA.TARGET_VALUE);
            BEGIN

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

            EXCEPTION
                WHEN OTHERS THEN
                    osberrormessage := 'INCONSISTENCIA TRIGGER TRGAFTERASIGAUTO [' ||
                                       DBMS_UTILITY.FORMAT_ERROR_STACK || '] - [' ||
                                       DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

                    LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                         TO_NUMBER(SBORDER_ID),
                                                         'INCONVENIENTES AL INSERTAR LA ORDEN EN TEMPORAL OR_ORDER_1 CON LA UNIDAD DE TRABAJO [' ||
                                                         NUOPERATING_UNIT_ID || '] - MENSAJE [' ||
                                                         osberrormessage || ']');
            END;
            --*/
        ELSE
            NUOPERATING_UNIT_ID := -1;

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                 TO_NUMBER(SBORDER_ID),
                                                 'NO EXISTE UNIDAD OPERATIVA CONFIGURADA EN EL GRUPO DE EQUIVALENCIA PARA EL PUNTO A TENCION DE LA SOLICITUD [LDC_BOASIGAUTO.FSBPUNTOATENCION - CUUNIDADOPERATIVA].');

        END IF;
        CLOSE CUUNIDADOPERATIVA;

        UT_TRACE.TRACE('FIN LDC_BOASIGAUTO.FSBPUNTOATENCION', 10);

        RETURN(NUOPERATING_UNIT_ID);

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            --ROLLBACK;
            ONUERRORCODE    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            OSBERRORMESSAGE := 'INCONVENIENTES AL ASIGNAR LA UNIDAD OPERTAIVA DE SOLICUTD INMEDIATA A LAS ORDENES GENERADAS POR DEFECTO DE REPARACION PERIODICA' ||
                               PKERRORS.FSBGETERRORMESSAGE;
            OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [' || DBMS_UTILITY.FORMAT_ERROR_STACK ||
                               ' - [' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

            /*
            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                 TO_NUMBER(SBORDER_ID),
                                                 OSBERRORMESSAGE);
            */
            RETURN(-1);

        WHEN OTHERS THEN
            --ROLLBACK;
            ONUERRORCODE    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            OSBERRORMESSAGE := 'INCONVENIENTES AL ASIGNAR LA UNIDAD OPERTAIVA DE SOLICUTD INMEDIATA A LAS ORDENES GENERADAS POR DEFECTO DE REPARACION PERIODICA' ||
                               PKERRORS.FSBGETERRORMESSAGE;
            OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [' || DBMS_UTILITY.FORMAT_ERROR_STACK ||
                               ' - [' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                 TO_NUMBER(SBORDER_ID),
                                                 OSBERRORMESSAGE);

            RETURN(-1);

    END FSBPUNTOATENCION;

    --NC 9999
    /*****************************************************************
    PROPIEDAD INTELECTUAL DE PETI (C).

    UNIDAD         : FSBRPTRAMITES
    DESCRIPCION    : PROCESO QUE PERMITIRA OBTENER
                     LA UNIDAD OPERATIVA DE UNA LISTA.
                     HASTA UTILIZAR TODAS LAS UNIDADES
                     CON EL CONTADOR MAS BAJO.
    AUTOR          : JORGE VALIENTE
    FECHA          : 10/02/2014

    PARAMETROS              DESCRIPCION
    ============         ===================
     ISBIN               VALORES EN UNA CADENA

    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    ******************************************************************/
    FUNCTION FSBRPTRAMITES(SBIN IN VARCHAR2) RETURN VARCHAR2 IS

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

        --CON ESTA ORDEN SE SABE EN EL CICLO QUE DATO VA
        --EN SECUENCIA PARA SABER CUAL DE LOS DATOS UTILIZAR
        ----------------------------------------------------

        ONUERRORCODE    NUMBER;
        OSBERRORMESSAGE VARCHAR2(4000);

        --SEPARA LOS DATOS OBTENIDOS DE LA CADENA DE ENTRADA
        --CON EL SEPARADOR |
        CURSOR CUDATA IS
            SELECT COLUMN_VALUE FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(SBIN, '|'));
        ---FIN CURSOR DATA

        --CURSOR PARA OBTENER EL VALOR DE LA UNIDAD OPERTAIVA
        --DE LA ORDEN ASOCIADA A LA SOLICUTUD DE
        --REVISION PERIODICA INMEDIATA
        CURSOR CUOR_ORDER(NUPACKAGE_ID MO_PACKAGES.PACKAGE_ID%TYPE,
                          NUORDER_ID   OR_ORDER.ORDER_ID%TYPE) IS
            SELECT DISTINCT O.OPERATING_UNIT_ID
            FROM   OPEN.MO_PACKAGES       P,
                   OPEN.OR_ORDER_ACTIVITY OA,
                   OPEN.OR_ORDER          O
            WHERE  P.PACKAGE_ID = NUPACKAGE_ID
            AND    OA.PACKAGE_ID = P.PACKAGE_ID
            AND    P.PACKAGE_TYPE_ID IN
                   (SELECT TO_NUMBER(COLUMN_VALUE)
                     FROM   TABLE(LDC_BOUTILITIES.SPLITSTRINGS(DALD_PARAMETER.fsbGetValue_Chain('COD_SOL_RP_ASI_AUT',
                                                                                                NULL),
                                                               ',')))
            AND    OA.ORDER_ID = O.ORDER_ID
            AND    O.TASK_TYPE_ID IN
                   (SELECT TO_NUMBER(COLUMN_VALUE)
                     FROM   TABLE(LDC_BOUTILITIES.SPLITSTRINGS(DALD_PARAMETER.fsbGetValue_Chain('COD_TT_RP_ASI_AUT',
                                                                                                NULL),
                                                               ',')))
            AND    O.CAUSAL_ID IN (SELECT TO_NUMBER(COLUMN_VALUE)
                                   FROM   TABLE(LDC_BOUTILITIES.SPLITSTRINGS(DALD_PARAMETER.fsbGetValue_Chain('COD_CAU_INC_ASI_AUT',
                                                                                                              NULL),
                                                                             ',')))
            AND    DAOR_ORDER.FNUGETTASK_TYPE_ID(NUORDER_ID, NULL) IN
                   (SELECT TO_NUMBER(COLUMN_VALUE)
                     FROM   TABLE(LDC_BOUTILITIES.SPLITSTRINGS(DALD_PARAMETER.fsbGetValue_Chain('COD_TT_SUSPENSION',
                                                                                                NULL),
                                                               ',')))
            AND    ROWNUM = 1;

        TEMPCUOR_ORDER CUOR_ORDER%ROWTYPE;
        --FIN CURSOR CUDAOR_ORDER

        NUOPERATING_UNIT_ID OR_ORDER.OPERATING_UNIT_ID%TYPE;

        RCORDERTOASSIGN     DAOR_ORDER.STYOR_ORDER;
        RCORDERTOASSIGNNULL DAOR_ORDER.STYOR_ORDER;

        SBDATAIN VARCHAR2(4000);

    BEGIN

        UT_TRACE.TRACE('INICIO LDC_BOASIGAUTO.FSBRPTRAMITES', 10);

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
            END IF;

        END LOOP;

        /*
        LDC_BOASIGAUTO.PRREGSITROASIGAUTO(TO_NUMBER(SBPACKAGE_ID),
                                          TO_NUMBER(SBORDER_ID),
                                          OSBERRORMESSAGE);

        --*/

        NUOPERATING_UNIT_ID := NULL;
        --NUOPERATING_UNIT_ID := -1;

        UPDATE OR_ORDER_ACTIVITY
        SET    ORDER_ID = TO_NUMBER(SBORDER_ID)
        WHERE  PACKAGE_ID = TO_NUMBER(SBPACKAGE_ID)
        AND    ACTIVITY_ID = TO_NUMBER(SBACTIVITY_ID);

        OPEN CUOR_ORDER(TO_NUMBER(SBPACKAGE_ID), TO_NUMBER(SBORDER_ID));
        FETCH CUOR_ORDER
            INTO TEMPCUOR_ORDER;
        IF CUOR_ORDER%FOUND THEN
            NUOPERATING_UNIT_ID := TEMPCUOR_ORDER.OPERATING_UNIT_ID;

            BEGIN

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

            EXCEPTION
                WHEN OTHERS THEN
                    SBDATAIN := 'INCONSISTENCIA TRIGGER TRGAFTERASIGAUTO [' ||
                                DBMS_UTILITY.FORMAT_ERROR_STACK || '] - [' ||
                                DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

                    LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(NULL,
                                                         TO_NUMBER(SBORDER_ID),
                                                         'EL SERVICIO os_assign_order NO PUDO ASIGNAR LA UNIDAD OPERATIVA A LA ORDEN [' ||
                                                         SBDATAIN || ']');
            END;

        ELSE

            NUOPERATING_UNIT_ID := NULL;
            --NUOPERATING_UNIT_ID := -1;
        END IF;

        UT_TRACE.TRACE('FIN LDC_BOASIGAUTO.FSBRPTRAMITES', 10);

        RETURN(NUOPERATING_UNIT_ID);

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            --ROLLBACK;
            ONUERRORCODE    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            OSBERRORMESSAGE := 'INCONVENIENTES AL ASIGNAR LA UNIDAD OPERTAIVA DE SOLICUTD INMEDIATA A LAS ORDENES GENERADAS POR DEFECTO DE REPARACION PERIODICA' ||
                               PKERRORS.FSBGETERRORMESSAGE;

            OSBERRORMESSAGE := OSBERRORMESSAGE || ' - ' || DBMS_UTILITY.FORMAT_ERROR_STACK || ' - ' ||
                               DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                 TO_NUMBER(SBORDER_ID),
                                                 OSBERRORMESSAGE);

            --RETURN(NULL);
            RETURN(-1);

        WHEN OTHERS THEN
            --ROLLBACK;
            ONUERRORCODE    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            OSBERRORMESSAGE := 'INCONVENIENTES AL ASIGNAR LA UNIDAD OPERTAIVA DE SOLICUTD INMEDIATA A LAS ORDENES GENERADAS POR DEFECTO DE REPARACION PERIODICA' ||
                               PKERRORS.FSBGETERRORMESSAGE;
            OSBERRORMESSAGE := OSBERRORMESSAGE || ' - ' || DBMS_UTILITY.FORMAT_ERROR_STACK || ' - ' ||
                               DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                 TO_NUMBER(SBORDER_ID),
                                                 OSBERRORMESSAGE);

            --RETURN(NULL);
            RETURN(-1);

    END FSBRPTRAMITES;
    --NC 9999 FIN DESARROLLO

    --ARANDA 2376
    /*****************************************************************
    PROPIEDAD INTELECTUAL DE PETI (C).

    UNIDAD         : FSBCARRUSEL
    DESCRIPCION    : SERVICIO PARA ASIGNARA UNIDAD OPERATIVA
                     A ORDENES CON CATEGORIA RESIDENCIAL.
    AUTOR          : JORGE VALIENTE
    FECHA          : 17/01/2014

    PARAMETROS              DESCRIPCION
    ============         ===================
     ISBIN               VALORES EN UNA CADENA

    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    ******************************************************************/
    FUNCTION FSBCARRUSEL(SBIN IN VARCHAR2) RETURN VARCHAR2 IS

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

        --CON ESTA ORDEN SE SABE EN EL CICLO QUE DATO VA
        --EN SECUENCIA PARA SABER CUAL DE LOS DATOS UTILIZAR
        ----------------------------------------------------

        ONUERRORCODE    NUMBER;
        OSBERRORMESSAGE VARCHAR2(4000);

        --SEPARA LOS DATOS OBTENIDOS DE LA CADENA DE ENTRADA
        --CON EL SEPARADOR |
        CURSOR CUDATA IS
            SELECT COLUMN_VALUE FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(SBIN, '|'));
        ---FIN CURSOR DATA

        NUOPERATING_UNIT_ID OR_ORDER.OPERATING_UNIT_ID%TYPE;

        RCORDERTOASSIGN     DAOR_ORDER.STYOR_ORDER;
        RCORDERTOASSIGNNULL DAOR_ORDER.STYOR_ORDER;

        SBDATAIN VARCHAR2(4000);

        --CURSOR PARA IDENTIFICAR TODOS LAS UNIDADES OPERATIAS ACTIVAS
        CURSOR CUCARUNIOPE(NUOPERATING_UNIT_ID OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE) IS
            SELECT *
            FROM   LDC_CARUNIOPE LC
            WHERE  LC.OPERATING_UNIT_ID = NUOPERATING_UNIT_ID
            AND    NVL(DAOR_OPERATING_UNIT.FNUGETASSIGN_CAPACITY(LC.OPERATING_UNIT_ID, NULL), 0) >
                   NVL(DAOR_OPERATING_UNIT.FNUGETUSED_ASSIGN_CAP(LC.OPERATING_UNIT_ID, NULL), 0)
            AND    LC.ACTIVO = 'S'
            AND    LC.OPERATING_UNIT_ID NOT IN
                   (SELECT TO_NUMBER(column_value)
                     FROM   TABLE(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('UNI_OPE_COM',
                                                                                                NULL),
                                                               ',')));
        TEMPCUCARUNIOPE CUCARUNIOPE%ROWTYPE;

        --CURSOR PARA IDENTIFICAR TODOS LAS UNIDADES OPERATIAS ACTIVAS
        --CON EL CONTADOR DEL VALOR MINIMO
        CURSOR CUCARUNIOPEMIN(NUOPERATING_UNIT_ID OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE,
                              NUCONTADOR          NUMBER) IS
            SELECT *
            FROM   LDC_CARUNIOPE LC
            --WHERE NVL(CONTADOR, 0) = NUCONTADOR - 1
            WHERE  LC.OPERATING_UNIT_ID = NUOPERATING_UNIT_ID
            AND    NVL(CONTADOR, 0) <> NUCONTADOR
            AND    NVL(DAOR_OPERATING_UNIT.FNUGETASSIGN_CAPACITY(LC.OPERATING_UNIT_ID, NULL), 0) >
                   NVL(DAOR_OPERATING_UNIT.FNUGETUSED_ASSIGN_CAP(LC.OPERATING_UNIT_ID, NULL), 0)
            AND    LC.ACTIVO = 'S'
            AND    LC.OPERATING_UNIT_ID NOT IN
                   (SELECT TO_NUMBER(column_value)
                     FROM   TABLE(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('UNI_OPE_COM',
                                                                                                NULL),
                                                               ',')));
        TEMPCUCARUNIOPEMIN CUCARUNIOPEMIN%ROWTYPE;

        --CURSOR PARA IDENTIFICAR TODOS LAS UNIDADES OPERATIAS ACTIVAS
        --PARA RESIDENCIAL
        CURSOR CUCARUNIOPEALL IS
            SELECT /*+ INDEX (LC PK_LDC_CARUNIOPE)*/
             *
            FROM   LDC_CARUNIOPE LC
            WHERE  LC.ACTIVO = 'S'
            AND    LC.OPERATING_UNIT_ID NOT IN
                   (SELECT TO_NUMBER(column_value)
                     FROM   TABLE(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('UNI_OPE_COM',
                                                                                                NULL),
                                                               ',')))
            ORDER  BY LC.CONTADOR;

        --SELECT * FROM LDC_CARUNIOPE LC WHERE LC.ACTIVO = 'S';
        TEMPCUCARUNIOPEALL CUCARUNIOPEALL%ROWTYPE;

        --CURSOR PARA IDENTIFICAR TODOS LAS UNIDADES OPERATIAS ACTIVAS POR SOLICITUD
        CURSOR CUCARUNIOPESOLICITUD(NUOPERATING_UNIT_ID OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE,
                                    NUPACKAGE_ID        MO_PACKAGES.PACKAGE_ID%TYPE) IS
            SELECT *
            FROM   LDC_CARUNIOPE LC
            WHERE  /*LC.OPERATING_UNIT_ID = NUOPERATING_UNIT_ID
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   AND */
             LC.PACKAGE_ID = NUPACKAGE_ID
             AND    LC.ACTIVO = 'S'
             AND    LC.OPERATING_UNIT_ID NOT IN
             (SELECT TO_NUMBER(column_value)
               FROM   TABLE(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('UNI_OPE_COM',
                                                                                          NULL),
                                                         ',')));
        TEMPCUCARUNIOPESOLICITUD CUCARUNIOPESOLICITUD%ROWTYPE;

        SBTRIGGER VARCHAR2(4000);

        --CURSOR CUGE_SECTOROPE_ZONA(NUOPERATING_UNIT_ID OR_ORDER.OPERATING_UNIT_ID%TYPE) IS
        CURSOR CUGE_SECTOROPE_ZONA(INUOPERATING_SECTOR_ID OR_ORDER.OPERATING_SECTOR_ID%TYPE,
                                   INUOPERATING_ZONE_ID   OR_OPERATING_UNIT.OPERATING_ZONE_ID%TYPE) IS
            SELECT GSZ.*
            FROM   GE_SECTOROPE_ZONA GSZ
            WHERE  GSZ.ID_SECTOR_OPERATIVO = INUOPERATING_SECTOR_ID
            AND    GSZ.ID_ZONA_OPERATIVA = INUOPERATING_ZONE_ID;

        TEMPCUGE_SECTOROPE_ZONA CUGE_SECTOROPE_ZONA%ROWTYPE;
        NUOPERATING_SECTOR_ID   OR_ORDER.OPERATING_SECTOR_ID%TYPE;
        NUOPERATING_ZONE_ID     OR_OPERATING_UNIT.OPERATING_ZONE_ID%TYPE;

        --CURSOR PARA IDENTIFICAR TODOS LAS UNIDADES OPERATIAS ACTIVAS
        --CON EL CONTADOR CON EL VALOR MINIMO
        CURSOR CUCARUNIOPEMAX(NUCONTADOR NUMBER) IS
            SELECT /*+ INDEX (LC PK_LDC_CARUNIOPE)*/
             *
            FROM   LDC_CARUNIOPE LC
            --WHERE NVL(CONTADOR, 0) = NUCONTADOR - 1
            WHERE  NVL(CONTADOR, 0) = NUCONTADOR
            AND    NVL(DAOR_OPERATING_UNIT.FNUGETASSIGN_CAPACITY(LC.OPERATING_UNIT_ID, NULL), 0) >
                   NVL(DAOR_OPERATING_UNIT.FNUGETUSED_ASSIGN_CAP(LC.OPERATING_UNIT_ID, NULL), 0)
            AND    LC.ACTIVO = 'S'
            AND    LC.OPERATING_UNIT_ID NOT IN
                   (SELECT TO_NUMBER(column_value)
                     FROM   TABLE(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('UNI_OPE_COM',
                                                                                                NULL),
                                                               ',')));
        TEMPCUCARUNIOPEMAX CUCARUNIOPEMAX%ROWTYPE;

        --CURSOR PARA VALIDAR EL ROL DE LA UNIDAD OPERATIVA Y
        --LA ACTIVIDAD DE LA ORDEN GENERADA.
        CURSOR CUROL(NUOPERATING_UNIT_ID OR_ORDER.OPERATING_UNIT_ID%TYPE,
                     NUACTIVITY_ID       OR_ORDER_ACTIVITY.ACTIVITY_ID%TYPE) IS
            SELECT OAR.*
            FROM   OR_ACTIVIDADES_ROL OAR,
                   OR_ROL_UNIDAD_TRAB ORUT
            WHERE  OAR.ID_ROL = ORUT.ID_ROL
            AND    ORUT.ID_UNIDAD_OPERATIVA = NUOPERATING_UNIT_ID
            AND    OAR.ID_ACTIVIDAD = NUACTIVITY_ID;

        TEMPCUROL CUROL%ROWTYPE;
        --FIN CURSOR CUROL

        NUHORASDISPONIBLES OR_OPERATING_UNIT.ASSIGN_CAPACITY%TYPE;

    BEGIN

        UT_TRACE.TRACE('INICIO LDC_BOASIGAUTO.FSBCARRUSEL', 10);

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
            ELSIF SBTRIGGER IS NULL THEN
                SBTRIGGER       := TEMPCUDATA.COLUMN_VALUE;
                OSBERRORMESSAGE := OSBERRORMESSAGE || ' - ' || SBTRIGGER;
            END IF;

        END LOOP;

        NUOPERATING_UNIT_ID := NULL;

        /*
        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                             TO_NUMBER(SBORDER_ID),
                                             'PETI ANTES DE INGRESAR A CUCARUNIOPEALL');
        */

        --CICLO PARA VALIDAR LAS UNIDADES OPERATIVAS
        --ACTIVAS EN CARRUSEL
        FOR TEMPCUCARUNIOPEALL IN CUCARUNIOPEALL LOOP

            --SENTENCIA PARA OBTENER EL SECTOR OPERTAVICO
            --NO SE UTILIZO EL PAQUETE DE 1ER NIVEL
            --POR SOLCIITUD DEL ING. CERSAR NAVIA OPEN
            BEGIN
                SELECT OPERATING_SECTOR_ID
                INTO   NUOPERATING_SECTOR_ID
                FROM   OR_ORDER OO
                WHERE  OO.ORDER_ID = TO_NUMBER(SBORDER_ID);
            END;

            --SENTENCIA PARA OBTENER EL SECTOR OPERTAVICO
            --NO SE UTILIZO EL PAQUETE DE 1ER NIVEL
            --POR SOLCIITUD DEL ING. CERSAR NAVIA OPEN
            BEGIN
                SELECT OPERATING_ZONE_ID
                INTO   NUOPERATING_ZONE_ID
                FROM   OR_OPERATING_UNIT OOU
                WHERE  OOU.OPERATING_UNIT_ID = TEMPCUCARUNIOPEALL.OPERATING_UNIT_ID;

            END;
            --
            --VALIDACION DE ROL
            OPEN CUROL(TEMPCUCARUNIOPEALL.OPERATING_UNIT_ID, TO_NUMBER(SBACTIVITY_ID));
            FETCH CUROL
                INTO TEMPCUROL;
            IF CUROL%FOUND THEN
                --VALIDA SECTOR OPERATIVO DE LA ORDEN Y LA UNIDAD DE TRABAJO
                --OPEN CUGE_SECTOROPE_ZONA(TEMPCUUOBYSOL.OPERATING_UNIT_ID);
                OPEN CUGE_SECTOROPE_ZONA(NUOPERATING_SECTOR_ID, NUOPERATING_ZONE_ID);
                ---FIN ARANDA 2767
                FETCH CUGE_SECTOROPE_ZONA
                    INTO TEMPCUGE_SECTOROPE_ZONA;
                IF CUGE_SECTOROPE_ZONA%FOUND THEN

                    IF NVL(DAOR_OPERATING_UNIT.FNUGETASSIGN_CAPACITY(TEMPCUCARUNIOPEALL.OPERATING_UNIT_ID,
                                                                     NULL),
                           0) > NVL(DAOR_OPERATING_UNIT.FNUGETUSED_ASSIGN_CAP(TEMPCUCARUNIOPEALL.OPERATING_UNIT_ID,
                                                                              NULL),
                                    0) THEN

                        NUOPERATING_UNIT_ID := TEMPCUCARUNIOPEALL.OPERATING_UNIT_ID;
                        --ACTUALIZAR EL CONTADOR DE LA UNIDAD OPERATIVA UTILIZADA
                        --Y VALIDAR LA SOLICITUD EXISTE CON MAS DE UNA ORDEN
                        OPEN CUCARUNIOPESOLICITUD(NUOPERATING_UNIT_ID, TO_NUMBER(SBPACKAGE_ID));
                        FETCH CUCARUNIOPESOLICITUD
                            INTO TEMPCUCARUNIOPESOLICITUD;
                        IF CUCARUNIOPESOLICITUD%NOTFOUND THEN

                            --SERVICIO DE ASIGNACION DE UNIDAD OPERATIVA A ORDENES DE TRABAJO
                            os_assign_order(TO_NUMBER(SBORDER_ID),
                                            NUOPERATING_UNIT_ID,
                                            SYSDATE,
                                            SYSDATE,
                                            onuerrorcode,
                                            osberrormessage);
                            IF onuerrorcode = 0 THEN
                                UPDATE LDC_CARUNIOPE
                                SET    CONTADOR       = CONTADOR + 1,
                                       FECHA_CONTADOR = SYSDATE,
                                       PACKAGE_ID     = TO_NUMBER(SBPACKAGE_ID)
                                WHERE  OPERATING_UNIT_ID = NUOPERATING_UNIT_ID;
                                /*
                                LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                                     TO_NUMBER(SBORDER_ID),
                                                                     'CARRUSEL ASIGNACION DE UNIDAD OPERATIVA [' ||
                                                                     NUOPERATING_UNIT_ID ||
                                                                     '] POR CARRUSEL');
                                --*/
                                --PRINTENTOSASIGNACION(TO_NUMBER(SBPACKAGE_ID), TO_NUMBER(SBORDER_ID));

                                UPDATE LDC_ORDER
                                SET    ASIGNADO = 'S'
                                WHERE  NVL(PACKAGE_ID, 0) = NVL(TO_NUMBER(SBPACKAGE_ID), 0)
                                AND    ORDER_ID = TO_NUMBER(SBORDER_ID);

                                EXIT;
                            ELSE
                                LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                                     TO_NUMBER(SBORDER_ID),
                                                                     'CARRUSEL  - ' ||
                                                                     osberrormessage);
                                --PRINTENTOSASIGNACION(TO_NUMBER(SBPACKAGE_ID),TO_NUMBER(SBORDER_ID));
                            END IF;

                        ELSE
                            NUOPERATING_UNIT_ID := TEMPCUCARUNIOPESOLICITUD.OPERATING_UNIT_ID;

                            os_assign_order(TO_NUMBER(SBORDER_ID),
                                            NUOPERATING_UNIT_ID,
                                            SYSDATE,
                                            SYSDATE,
                                            onuerrorcode,
                                            osberrormessage);
                            IF onuerrorcode = 0 THEN
                                UPDATE LDC_CARUNIOPE
                                SET    CONTADOR       = CONTADOR + 1,
                                       FECHA_CONTADOR = SYSDATE,
                                       PACKAGE_ID     = TO_NUMBER(SBPACKAGE_ID)
                                WHERE  OPERATING_UNIT_ID = NUOPERATING_UNIT_ID;
                                /*
                                LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                                     TO_NUMBER(SBORDER_ID),
                                                                     'CARRUSEL ASIGNACION DE UNIDAD OPERATIVA [' ||
                                                                     NUOPERATING_UNIT_ID ||
                                                                     '] POR CARRUSEL');

                                */
                                --PRINTENTOSASIGNACION(TO_NUMBER(SBPACKAGE_ID), TO_NUMBER(SBORDER_ID));

                                UPDATE LDC_ORDER
                                SET    ASIGNADO = 'S'
                                WHERE  NVL(PACKAGE_ID, 0) = NVL(TO_NUMBER(SBPACKAGE_ID), 0)
                                AND    ORDER_ID = TO_NUMBER(SBORDER_ID);

                                EXIT;
                            ELSE
                                LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                                     TO_NUMBER(SBORDER_ID),
                                                                     'CARRUSEL - ' ||
                                                                     osberrormessage);
                                --PRINTENTOSASIGNACION(TO_NUMBER(SBPACKAGE_ID), TO_NUMBER(SBORDER_ID));
                            END IF;

                        END IF;
                        CLOSE CUCARUNIOPESOLICITUD;
                        --FIN ACTUALIZAR EL CONTADOR DE LA UNIDAD OPERATIVA UTILIZADA

                    ELSE
                        UPDATE LDC_CARUNIOPE
                        SET    ACTIVO      = 'N',
                               OBSERVACION = 'LA UNIDAD OPERATIVA FUE DESACTIVADA PARA CARRUSEL YA QUE LA CANTIDAD DE HORAS ASIGNADA [' ||
                                             NVL(DAOR_OPERATING_UNIT.FNUGETASSIGN_CAPACITY(TEMPCUCARUNIOPEALL.OPERATING_UNIT_ID,
                                                                                           NULL),
                                                 0) ||
                                             '] ES INFERIOR O IGUAL A LA CANTIDAD DE HORAS UTILIZADAS [' ||
                                             NVL(DAOR_OPERATING_UNIT.FNUGETUSED_ASSIGN_CAP(TEMPCUCARUNIOPEALL.OPERATING_UNIT_ID,
                                                                                           NULL),
                                                 0) || ']'
                        WHERE  OPERATING_UNIT_ID = TEMPCUCARUNIOPEALL.OPERATING_UNIT_ID;

                    END IF;

                ELSE
                    LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                         TO_NUMBER(SBORDER_ID),
                                                         'CARRUSEL - LA ORDEN [' || SBORDER_ID ||
                                                         '] Y LA UNIDAD OPERATIVA [' ||
                                                         TEMPCUCARUNIOPEALL.OPERATING_UNIT_ID ||
                                                         '] NO ESTAN EN EL MISMO SECTOR OPERATIVO');

                END IF;
                CLOSE CUGE_SECTOROPE_ZONA;
            ELSE
                LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                     TO_NUMBER(SBORDER_ID),
                                                     'CARRUSEL - LA ACTIVIDAD [' || SBACTIVITY_ID ||
                                                     '] Y LA UNIDAD OPERATIVA [' ||
                                                     TEMPCUCARUNIOPEALL.OPERATING_UNIT_ID ||
                                                     '] NO ESTAN EN EL MISMO ROL');

            END IF; --FIN VALIDACION DE ROL
            CLOSE CUROL;
        END LOOP;

        --CICLO PARA MOSTRAR LAS HORAS DISPONIBLES DE
        --LAS UNIDADES OPERATIVAS
        FOR TEMPCUCARUNIOPEALL IN CUCARUNIOPEALL LOOP
            NUHORASDISPONIBLES := NVL(DAOR_OPERATING_UNIT.FNUGETASSIGN_CAPACITY(TEMPCUCARUNIOPEALL.OPERATING_UNIT_ID,
                                                                                NULL),
                                      0) - NVL(DAOR_OPERATING_UNIT.FNUGETUSED_ASSIGN_CAP(TEMPCUCARUNIOPEALL.OPERATING_UNIT_ID,
                                                                                         NULL),
                                               0);

            UPDATE LDC_CARUNIOPE
            SET    OBSERVACION = 'HORAS DISPONIBLES --> ' || NUHORASDISPONIBLES
            WHERE  OPERATING_UNIT_ID = TEMPCUCARUNIOPEALL.OPERATING_UNIT_ID;
        END LOOP;

        UT_TRACE.TRACE('FIN LDC_BOASIGAUTO.FSBCARRUSEL', 10);

        RETURN(NUOPERATING_UNIT_ID);

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            --ROLLBACK;
            ONUERRORCODE    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            OSBERRORMESSAGE := 'INCONVENIENTES AL ASIGNAR LA UNIDAD OPERTAIVA POR CARRUSEL' ||
                               PKERRORS.FSBGETERRORMESSAGE;

            OSBERRORMESSAGE := OSBERRORMESSAGE || ' - ' || DBMS_UTILITY.FORMAT_ERROR_STACK || ' - ' ||
                               DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                 TO_NUMBER(SBORDER_ID),
                                                 OSBERRORMESSAGE);

            --RETURN(NULL);
            RETURN(-1);

        WHEN OTHERS THEN

            OSBERRORMESSAGE := '[' || DBMS_UTILITY.FORMAT_ERROR_STACK || '] - ' ||
                               DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                 TO_NUMBER(SBORDER_ID),
                                                 'ERROR OTHERS FSBCARRUSEL --> ' || OSBERRORMESSAGE);

            RETURN(-1);

    END FSBCARRUSEL;
    --ARANDA 2376 FIN DESARROLLO

    --ARANDA 2920
    /*****************************************************************
    PROPIEDAD INTELECTUAL DE PETI (C).

    UNIDAD         : FSBCARRUSELCOMERCIAL
    DESCRIPCION    : SERVICIO PARA ASIGNAR LA UNIADA OPERATIVA A
                     ORDENES CON TIPO DE CATEGORIA COMERCIAL.
    AUTOR          : JORGE VALIENTE
    FECHA          : 24/02/2014

    PARAMETROS              DESCRIPCION
    ============         ===================
     ISBIN               VALORES EN UNA CADENA

    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    ******************************************************************/
    FUNCTION FSBCARRUSELCOMERCIAL(SBIN IN VARCHAR2) RETURN VARCHAR2 IS

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

        --CON ESTA ORDEN SE SABE EN EL CICLO QUE DATO VA
        --EN SECUENCIA PARA SABER CUAL DE LOS DATOS UTILIZAR
        ----------------------------------------------------

        ONUERRORCODE    NUMBER;
        OSBERRORMESSAGE VARCHAR2(4000);

        --SEPARA LOS DATOS OBTENIDOS DE LA CADENA DE ENTRADA
        --CON EL SEPARADOR |
        CURSOR CUDATA IS
            SELECT COLUMN_VALUE FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(SBIN, '|'));
        ---FIN CURSOR DATA

        NUOPERATING_UNIT_ID OR_ORDER.OPERATING_UNIT_ID%TYPE;

        RCORDERTOASSIGN     DAOR_ORDER.STYOR_ORDER;
        RCORDERTOASSIGNNULL DAOR_ORDER.STYOR_ORDER;

        SBDATAIN VARCHAR2(4000);

        --CURSOR PARA IDENTIFICAR TODOS LAS UNIDADES OPERATIAS ACTIVAS
        CURSOR CUCARUNIOPE(NUOPERATING_UNIT_ID OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE) IS
            SELECT *
            FROM   LDC_CARUNIOPE LC
            WHERE  LC.OPERATING_UNIT_ID = NUOPERATING_UNIT_ID
            AND    NVL(DAOR_OPERATING_UNIT.FNUGETASSIGN_CAPACITY(LC.OPERATING_UNIT_ID, NULL), 0) >
                   NVL(DAOR_OPERATING_UNIT.FNUGETUSED_ASSIGN_CAP(LC.OPERATING_UNIT_ID, NULL), 0)
            AND    LC.ACTIVO = 'S'
            AND    LC.OPERATING_UNIT_ID IN
                   (SELECT TO_NUMBER(column_value)
                     FROM   TABLE(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('UNI_OPE_COM',
                                                                                                NULL),
                                                               ',')));
        TEMPCUCARUNIOPE CUCARUNIOPE%ROWTYPE;

        --CURSOR PARA IDENTIFICAR TODOS LAS UNIDADES OPERATIAS ACTIVAS
        --CON EL CONTADOR CON EL VALOR MINIMO
        CURSOR CUCARUNIOPEMIN(NUOPERATING_UNIT_ID OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE,
                              NUCONTADOR          NUMBER) IS
            SELECT *
            FROM   LDC_CARUNIOPE LC
            --WHERE NVL(CONTADOR, 0) = NUCONTADOR - 1
            WHERE  LC.OPERATING_UNIT_ID = NUOPERATING_UNIT_ID
            AND    NVL(CONTADOR, 0) <> NUCONTADOR
            AND    NVL(DAOR_OPERATING_UNIT.FNUGETASSIGN_CAPACITY(LC.OPERATING_UNIT_ID, NULL), 0) >
                   NVL(DAOR_OPERATING_UNIT.FNUGETUSED_ASSIGN_CAP(LC.OPERATING_UNIT_ID, NULL), 0)
            AND    LC.ACTIVO = 'S'
            AND    LC.OPERATING_UNIT_ID IN
                   (SELECT TO_NUMBER(column_value)
                     FROM   TABLE(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('UNI_OPE_COM',
                                                                                                NULL),
                                                               ',')));
        TEMPCUCARUNIOPEMIN CUCARUNIOPEMIN%ROWTYPE;

        --CURSOR PARA IDENTIFICAR TODOS LAS UNIDADES OPERATIAS ACTIVAS
        CURSOR CUCARUNIOPEALL IS
            SELECT /*+ INDEX (LC PK_LDC_CARUNIOPE)*/
             *
            FROM   LDC_CARUNIOPE LC
            WHERE  LC.ACTIVO = 'S'
            AND    LC.OPERATING_UNIT_ID IN
                   (SELECT TO_NUMBER(column_value)
                     FROM   TABLE(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('UNI_OPE_COM',
                                                                                                NULL),
                                                               ',')));

        TEMPCUCARUNIOPEALL CUCARUNIOPEALL%ROWTYPE;

        --CURSOR PARA IDENTIFICAR TODOS LAS UNIDADES OPERATIAS ACTIVAS
        CURSOR CUCARUNIOPESOLICITUD(NUOPERATING_UNIT_ID OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE,
                                    NUPACKAGE_ID        MO_PACKAGES.PACKAGE_ID%TYPE) IS
            SELECT *
            FROM   LDC_CARUNIOPE LC
            WHERE  LC.OPERATING_UNIT_ID = NUOPERATING_UNIT_ID
            AND    LC.PACKAGE_ID = NUPACKAGE_ID
            AND    LC.ACTIVO = 'S'
            AND    LC.OPERATING_UNIT_ID IN
                   (SELECT TO_NUMBER(column_value)
                     FROM   TABLE(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('UNI_OPE_COM',
                                                                                                NULL),
                                                               ',')));
        TEMPCUCARUNIOPESOLICITUD CUCARUNIOPESOLICITUD%ROWTYPE;

        SBTRIGGER VARCHAR2(4000);

        --CURSOR CUGE_SECTOROPE_ZONA(NUOPERATING_UNIT_ID OR_ORDER.OPERATING_UNIT_ID%TYPE) IS
        CURSOR CUGE_SECTOROPE_ZONA(INUOPERATING_SECTOR_ID OR_ORDER.OPERATING_SECTOR_ID%TYPE,
                                   INUOPERATING_ZONE_ID   OR_OPERATING_UNIT.OPERATING_ZONE_ID%TYPE) IS
            SELECT GSZ.*
            FROM   GE_SECTOROPE_ZONA GSZ
            WHERE  GSZ.ID_SECTOR_OPERATIVO = INUOPERATING_SECTOR_ID
            AND    GSZ.ID_ZONA_OPERATIVA = INUOPERATING_ZONE_ID;

        TEMPCUGE_SECTOROPE_ZONA CUGE_SECTOROPE_ZONA%ROWTYPE;
        NUOPERATING_SECTOR_ID   OR_ORDER.OPERATING_SECTOR_ID%TYPE;
        NUOPERATING_ZONE_ID     OR_OPERATING_UNIT.OPERATING_ZONE_ID%TYPE;

        --CURSOR PARA IDENTIFICAR TODOS LAS UNIDADES OPERATIAS ACTIVAS
        --CON EL CONTADOR CON EL VALOR MINIMO
        CURSOR CUCARUNIOPEMAX(NUCONTADOR NUMBER) IS
            SELECT /*+ INDEX (LC PK_LDC_CARUNIOPE)*/
             *
            FROM   LDC_CARUNIOPE LC
            --WHERE NVL(CONTADOR, 0) = NUCONTADOR - 1
            WHERE  NVL(CONTADOR, 0) = NUCONTADOR
            AND    NVL(DAOR_OPERATING_UNIT.FNUGETASSIGN_CAPACITY(LC.OPERATING_UNIT_ID, NULL), 0) >
                   NVL(DAOR_OPERATING_UNIT.FNUGETUSED_ASSIGN_CAP(LC.OPERATING_UNIT_ID, NULL), 0)
            AND    LC.ACTIVO = 'S'
            AND    LC.OPERATING_UNIT_ID IN
                   (SELECT TO_NUMBER(column_value)
                     FROM   TABLE(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('UNI_OPE_COM',
                                                                                                NULL),
                                                               ',')));
        TEMPCUCARUNIOPEMAX CUCARUNIOPEMAX%ROWTYPE;

        --CURSOR PARA VALIDAR EL ROL DE LA UNIDAD OPERATIVA Y
        --LA ACTIVIDAD DE LA ORDEN GENERADA.
        CURSOR CUROL(NUOPERATING_UNIT_ID OR_ORDER.OPERATING_UNIT_ID%TYPE,
                     NUACTIVITY_ID       OR_ORDER_ACTIVITY.ACTIVITY_ID%TYPE) IS
            SELECT OAR.*
            FROM   OR_ACTIVIDADES_ROL OAR,
                   OR_ROL_UNIDAD_TRAB ORUT
            WHERE  OAR.ID_ROL = ORUT.ID_ROL
            AND    ORUT.ID_UNIDAD_OPERATIVA = NUOPERATING_UNIT_ID
            AND    OAR.ID_ACTIVIDAD = NUACTIVITY_ID;

        TEMPCUROL CUROL%ROWTYPE;
        --FIN CURSOR CUROL

        NUHORASDISPONIBLES OR_OPERATING_UNIT.ASSIGN_CAPACITY%TYPE;

    BEGIN

        UT_TRACE.TRACE('INICIO LDC_BOASIGAUTO.FSBCARRUSELCOMERCIAL', 10);

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
            ELSIF SBTRIGGER IS NULL THEN
                SBTRIGGER       := TEMPCUDATA.COLUMN_VALUE;
                OSBERRORMESSAGE := OSBERRORMESSAGE || ' - ' || SBTRIGGER;
            END IF;

        END LOOP;

        NUOPERATING_UNIT_ID := NULL;

        --CICLO PARA VALIDAR LAS UNIDADES OPERATIVAS
        --ACTIVAS EN CARRUSEL
        FOR TEMPCUCARUNIOPEALL IN CUCARUNIOPEALL LOOP

            --SENTENCIA PARA OBTENER EL SECTOR OPERTAVICO
            --NO SE UTILIZO EL PAQUETE DE 1ER NIVEL
            --POR SOLCIITUD DEL ING. CERSAR NAVIA OPEN
            BEGIN
                SELECT OPERATING_SECTOR_ID
                INTO   NUOPERATING_SECTOR_ID
                FROM   OR_ORDER OO
                WHERE  OO.ORDER_ID = TO_NUMBER(SBORDER_ID);
            END;

            --SENTENCIA PARA OBTENER EL SECTOR OPERTAVICO
            --NO SE UTILIZO EL PAQUETE DE 1ER NIVEL
            --POR SOLCIITUD DEL ING. CERSAR NAVIA OPEN
            BEGIN
                SELECT OPERATING_ZONE_ID
                INTO   NUOPERATING_ZONE_ID
                FROM   OR_OPERATING_UNIT OOU
                WHERE  OOU.OPERATING_UNIT_ID = TEMPCUCARUNIOPEALL.OPERATING_UNIT_ID;

            END;
            --
            --VALIDACION DE ROL
            OPEN CUROL(TEMPCUCARUNIOPEALL.OPERATING_UNIT_ID, TO_NUMBER(SBACTIVITY_ID));
            FETCH CUROL
                INTO TEMPCUROL;
            IF CUROL%FOUND THEN
                --VALIDA SECTOR OPERATIVO DE LA ORDEN Y LA UNIDAD DE TRABAJO
                --OPEN CUGE_SECTOROPE_ZONA(TEMPCUUOBYSOL.OPERATING_UNIT_ID);
                OPEN CUGE_SECTOROPE_ZONA(NUOPERATING_SECTOR_ID, NUOPERATING_ZONE_ID);
                ---FIN ARANDA 2767
                FETCH CUGE_SECTOROPE_ZONA
                    INTO TEMPCUGE_SECTOROPE_ZONA;
                IF CUGE_SECTOROPE_ZONA%FOUND THEN

                    IF NVL(DAOR_OPERATING_UNIT.FNUGETASSIGN_CAPACITY(TEMPCUCARUNIOPEALL.OPERATING_UNIT_ID,
                                                                     NULL),
                           0) > NVL(DAOR_OPERATING_UNIT.FNUGETUSED_ASSIGN_CAP(TEMPCUCARUNIOPEALL.OPERATING_UNIT_ID,
                                                                              NULL),
                                    0) THEN

                        NUOPERATING_UNIT_ID := TEMPCUCARUNIOPEALL.OPERATING_UNIT_ID;
                        --ACTUALIZAR EL CONTADOR DE LA UNIDAD OPERATIVA UTILIZADA
                        --Y VALIDAR LA SOLICITUD EXISTE CON MAS DE UNA ORDEN
                        OPEN CUCARUNIOPESOLICITUD(NUOPERATING_UNIT_ID, TO_NUMBER(SBPACKAGE_ID));
                        FETCH CUCARUNIOPESOLICITUD
                            INTO TEMPCUCARUNIOPESOLICITUD;
                        IF CUCARUNIOPESOLICITUD%NOTFOUND THEN

                            --SERVICIO DE ASIGNACION DE UNIDAD OPERATIVA A ORDENES DE TRABAJO
                            os_assign_order(TO_NUMBER(SBORDER_ID),
                                            NUOPERATING_UNIT_ID,
                                            SYSDATE,
                                            SYSDATE,
                                            onuerrorcode,
                                            osberrormessage);
                            IF onuerrorcode = 0 THEN
                                UPDATE LDC_CARUNIOPE
                                SET    CONTADOR       = CONTADOR + 1,
                                       FECHA_CONTADOR = SYSDATE,
                                       PACKAGE_ID     = TO_NUMBER(SBPACKAGE_ID)
                                WHERE  OPERATING_UNIT_ID = NUOPERATING_UNIT_ID;
                                /*
                                LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                                     TO_NUMBER(SBORDER_ID),
                                                                     'CARRUSEL ASIGNACION DE UNIDAD OPERATIVA [' ||
                                                                     NUOPERATING_UNIT_ID ||
                                                                     '] POR CARRUSEL');
                                --*/
                                --PRINTENTOSASIGNACION(TO_NUMBER(SBPACKAGE_ID),TO_NUMBER(SBORDER_ID));

                                UPDATE LDC_ORDER
                                SET    ASIGNADO = 'S'
                                WHERE  NVL(PACKAGE_ID, 0) = NVL(TO_NUMBER(SBPACKAGE_ID), 0)
                                AND    ORDER_ID = TO_NUMBER(SBORDER_ID);

                                EXIT;
                            ELSE
                                LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                                     TO_NUMBER(SBORDER_ID),
                                                                     'CARRUSEL  - ' ||
                                                                     osberrormessage);
                                --PRINTENTOSASIGNACION(TO_NUMBER(SBPACKAGE_ID),TO_NUMBER(SBORDER_ID));
                            END IF;

                        ELSE
                            NUOPERATING_UNIT_ID := TEMPCUCARUNIOPESOLICITUD.OPERATING_UNIT_ID;

                            os_assign_order(TO_NUMBER(SBORDER_ID),
                                            NUOPERATING_UNIT_ID,
                                            SYSDATE,
                                            SYSDATE,
                                            onuerrorcode,
                                            osberrormessage);
                            IF onuerrorcode = 0 THEN
                                UPDATE LDC_CARUNIOPE
                                SET    CONTADOR       = CONTADOR + 1,
                                       FECHA_CONTADOR = SYSDATE,
                                       PACKAGE_ID     = TO_NUMBER(SBPACKAGE_ID)
                                WHERE  OPERATING_UNIT_ID = NUOPERATING_UNIT_ID;
                                /*
                                LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                                     TO_NUMBER(SBORDER_ID),
                                                                     'CARRUSEL ASIGNACION DE UNIDAD OPERATIVA [' ||
                                                                     NUOPERATING_UNIT_ID ||
                                                                     '] POR CARRUSEL');

                                */
                                --PRINTENTOSASIGNACION(TO_NUMBER(SBPACKAGE_ID),TO_NUMBER(SBORDER_ID));

                                UPDATE LDC_ORDER
                                SET    ASIGNADO = 'S'
                                WHERE  NVL(PACKAGE_ID, 0) = NVL(TO_NUMBER(SBPACKAGE_ID), 0)
                                AND    ORDER_ID = TO_NUMBER(SBORDER_ID);

                                EXIT;
                            ELSE
                                LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                                     TO_NUMBER(SBORDER_ID),
                                                                     'CARRUSEL - ' ||
                                                                     osberrormessage);
                                --PRINTENTOSASIGNACION(TO_NUMBER(SBPACKAGE_ID),TO_NUMBER(SBORDER_ID));
                            END IF;

                        END IF;
                        CLOSE CUCARUNIOPESOLICITUD;
                        --FIN ACTUALIZAR EL CONTADOR DE LA UNIDAD OPERATIVA UTILIZADA

                    ELSE
                        UPDATE LDC_CARUNIOPE
                        SET    ACTIVO      = 'N',
                               OBSERVACION = 'LA UNIDAD OPERATIVA FUE DESACTIVADA PARA CARRUSEL YA QUE LA CANTIDAD DE HORAS ASIGNADA [' ||
                                             NVL(DAOR_OPERATING_UNIT.FNUGETASSIGN_CAPACITY(TEMPCUCARUNIOPEALL.OPERATING_UNIT_ID,
                                                                                           NULL),
                                                 0) ||
                                             '] ES INFERIOR O IGUAL A LA CANTIDAD DE HORAS UTILIZADAS [' ||
                                             NVL(DAOR_OPERATING_UNIT.FNUGETUSED_ASSIGN_CAP(TEMPCUCARUNIOPEALL.OPERATING_UNIT_ID,
                                                                                           NULL),
                                                 0) || ']'
                        WHERE  OPERATING_UNIT_ID = TEMPCUCARUNIOPEALL.OPERATING_UNIT_ID;

                    END IF;

                ELSE
                    LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                         TO_NUMBER(SBORDER_ID),
                                                         'CARRUSEL - LA ORDEN [' || SBORDER_ID ||
                                                         '] Y LA UNIDAD OPERATIVA [' ||
                                                         TEMPCUCARUNIOPEALL.OPERATING_UNIT_ID ||
                                                         '] NO ESTAN EN EL MISMO SECTOR OPERATIVO');

                END IF;
                CLOSE CUGE_SECTOROPE_ZONA;
            ELSE
                LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                     TO_NUMBER(SBORDER_ID),
                                                     'CARRUSEL - LA ACTIVIDAD [' || SBACTIVITY_ID ||
                                                     '] Y LA UNIDAD OPERATIVA [' ||
                                                     TEMPCUCARUNIOPEALL.OPERATING_UNIT_ID ||
                                                     '] NO ESTAN EN EL MISMO ROL');

            END IF; --FIN VALIDACION DE ROL
            CLOSE CUROL;
        END LOOP;

        --CICLO PARA MOSTRAR LAS HORAS DISPONIBLES DE
        --LAS UNIDADES OPERATIVAS
        FOR TEMPCUCARUNIOPEALL IN CUCARUNIOPEALL LOOP
            NUHORASDISPONIBLES := NVL(DAOR_OPERATING_UNIT.FNUGETASSIGN_CAPACITY(TEMPCUCARUNIOPEALL.OPERATING_UNIT_ID,
                                                                                NULL),
                                      0) - NVL(DAOR_OPERATING_UNIT.FNUGETUSED_ASSIGN_CAP(TEMPCUCARUNIOPEALL.OPERATING_UNIT_ID,
                                                                                         NULL),
                                               0);

            UPDATE LDC_CARUNIOPE
            SET    OBSERVACION = 'HORAS DISPONIBLES --> ' || NUHORASDISPONIBLES
            WHERE  OPERATING_UNIT_ID = TEMPCUCARUNIOPEALL.OPERATING_UNIT_ID;
        END LOOP;

        UT_TRACE.TRACE('FIN LDC_BOASIGAUTO.FSBCARRUSELCOMERCIAL', 10);

        RETURN(NUOPERATING_UNIT_ID);

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            --ROLLBACK;
            ONUERRORCODE    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            OSBERRORMESSAGE := 'INCONVENIENTES AL ASIGNAR LA UNIDAD OPERTAIVA POR CARRUSEL' ||
                               PKERRORS.FSBGETERRORMESSAGE;

            OSBERRORMESSAGE := OSBERRORMESSAGE || ' - ' || DBMS_UTILITY.FORMAT_ERROR_STACK || ' - ' ||
                               DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                 TO_NUMBER(SBORDER_ID),
                                                 OSBERRORMESSAGE);

            --RETURN(NULL);
            RETURN(-1);

        WHEN OTHERS THEN

            OSBERRORMESSAGE := '[' || DBMS_UTILITY.FORMAT_ERROR_STACK || '] - ' ||
                               DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                 TO_NUMBER(SBORDER_ID),
                                                 'ERROR OTHERS FSBCARRUSELCOMERCIAL --> ' ||
                                                 OSBERRORMESSAGE);
            RETURN(-1);

    END FSBCARRUSELCOMERCIAL;
    --ARANDA 2920 FIN DESARROLLO

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
    17-08-2016      Sandra Mu?oz        CA200-398. Se modifica agreg?ndole un par?metro para la orden
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

        nuEstadoAsignado ld_parameter.numeric_value%TYPE;

        --CURSOR PARA OBTENER TODAS LAS ORDENES QUE NO HAN SIDO
        --ASIGNADAS A UAN UNIDAD OPERATIVA EN LDC_ORDER
        CURSOR CULDC_ORDER(inuCantidadIntentos NUMBER) IS
            SELECT order_id,
                   package_id,
                   asignacion,
                   asignado,
                   (select oo.Operating_Sector_Id
                      from open.or_order oo
                     where oo.order_id = LO.ORDER_ID
                     and rownum = 1) SECTOR_OPERATIVO_ORDEN
            FROM   OPEN.LDC_ORDER LO
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

        --CURSOR PARA VALIDAR LA CATEGORIA A LA QUE
        --PERTENECE EL SUSCRIPTOR
        /*CASO 200-2067
        --La logica del cursor pasa al cursor principal CUUOBYSOL
        CURSOR CUCATEGORIA(NUPRODUCT_ID OR_ORDER_ACTIVITY.PRODUCT_ID%TYPE,
                           NUADDRESS_ID OR_ORDER_ACTIVITY.ADDRESS_ID%TYPE) IS
            SELECT PP.CATEGORY_ID
            FROM   PR_PRODUCT PP
            WHERE  PP.PRODUCT_ID = DECODE(NUPRODUCT_ID,
                                          NULL,
                                          (SELECT PP.PRODUCT_ID
                                           FROM   PR_PRODUCT PP
                                           WHERE  PP.ADDRESS_ID = NUADDRESS_ID
                                           AND    ROWNUM = 1),
                                          NUPRODUCT_ID)
            AND    PP.PRODUCT_TYPE_ID IN
                   (SELECT TO_NUMBER(column_value)
                     FROM   TABLE(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('COD_TIPO_SOL_ASIG',
                                                                                                NULL),
                                                               ',')))
            AND    ROWNUM = 1;

        TEMPCUCATEGORIA CUCATEGORIA%ROWTYPE;
        --*/

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
            FROM   open.pr_product p
            WHERE  p.product_id = NUPRODUCT_ID
            AND    p.product_type_id = open.dald_parameter.fnuGetNumeric_Value('COD_PRO_GEN', NULL);

        RTCUTIPOPRODUCTO CUTIPOPRODUCTO%ROWTYPE;

        --CURSOR PARA OBTENER LA CATEGROIA DE LA DIRECCION DE LA ORDEN
        --SI EL PRODUCTO ES GENERICO
        CURSOR CUSEGMENTOCATEGORIA(NUADDRESS_ID OR_ORDER_ACTIVITY.ADDRESS_ID%TYPE) IS
            SELECT NVL(S.CATEGORY_, 0) CATEGORIA,
                   S.SUBCATEGORY_ SUBCATEGORIA
            FROM   open.ab_address  aa,
                   OPEN.AB_SEGMENTS S
            WHERE  aa.address_id = NUADDRESS_ID
            AND    AA.SEGMENT_ID = S.SEGMENTS_ID;

        RTCUSEGMENTOCATEGORIA CUSEGMENTOCATEGORIA%ROWTYPE;
        ---Fin NC 2493 desarrollo
        --TICKET 2001377 LJLB -- se consulta sector operatvo de ladireccion del producto
        CURSOR cuSectorOperativo(NUADDRESS_ID OR_ORDER_ACTIVITY.ADDRESS_ID%TYPE) IS
        SELECT OPERATING_SECTOR_ID
        FROM open.ab_address  aa,
             OPEN.AB_SEGMENTS S
        WHERE aa.address_id = NUADDRESS_ID
          AND AA.SEGMENT_ID = S.SEGMENTS_ID ;

       sbFlag VARCHAR2(1) := 'N'; --TICKET 2001377 LJLB -- se almacena flag para activar desarrollo
       nuSectorOperativo  AB_SEGMENTS.OPERATING_SECTOR_ID%TYPE;  --TICKET 2001377 LJLB -- se almacena sector operativo
       sbError    VARCHAR2(4000); --TICKET 2001377 LJLB -- se almacena error del porceso de asigancion
       nuContrato  GE_CONTRATO.ID_CONTRATO%TYPE; --TICKET 2001377 LJLB --  se almacena contrato

        --CURSOR IDENTIFICAR LAS UNIDADES OPERATIVAS
        --DESACTIVADAS EN LDC_CARUNIOPE
        CURSOR CULDC_CARUNIOPE(INUOPERATING_SECTOR_ID OR_ORDER.OPERATING_SECTOR_ID%TYPE) IS
            SELECT *
            FROM   OPEN.LDC_CARUNIOPE
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
		sbPost open.ld_parameter.value_chain%type:=nvl(open.dald_parameter.fsbGetValue_Chain('EJECUTA_PROCESO_POST',null),'N');
    sbCaso272 varchar2(1);

    --678
    sbCaso678     varchar2(1);
    nuestadoOt    open.or_order.order_status_id%type;
    BEGIN

        PROINIT;

        --TICKET 200-1377 LJLB -- se consulta si aplica la entrega en la gasera
        IF BLBSS_FACT_LJLB_2001377 THEN
        --IF fblaplicaentrega('BSS_FACT_LJLB_2001377_1') THEN
           sbFlag := 'S';

           PRRESEINTEOR; --TICKET 200-1377 LJLB -- se setean los intentos de las ordenes que cumplan con el parametro
        END IF;
        -- CA200-398. Buscar el estado "Asignado" del sistema
        nuEstadoAsignado := dald_parameter.fnuGetNumeric_Value('COD_ESTADO_ASIGNADA_OT');
        if fblaplicaentregaxcaso('0000272') then
          sbCaso272 :='S';
        else
          sbCaso272 :='N';
        end if;

        if fblaplicaentregaxcaso('0000678') then
          sbCaso678 := 'S';
        else
          sbCaso678 := 'N';
        end if;
        /*
        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(-1,
                                             -1,
                                             'LDC_BOASIGAUTO.PRASIGNACION, ANTES DE INGRESAR LA CURSOR CULDC_ORDER CON LA VARAIBLE nuCantidadIntentos[' ||
                                             nuCantidadIntentos || ']');
        */

        --CICLO PARA RECORRER LAS ORDENES AUN NO ASIGNADAS
        FOR TEMPCULDC_ORDER IN CULDC_ORDER(nuCantidadIntentos) LOOP
            sbError := null;

            BEGIN   -- CASO 272: Se agrega bloque de control

                NUSOLICITUD := TEMPCULDC_ORDER.PACKAGE_ID;
                NUORDEN     := TEMPCULDC_ORDER.ORDER_ID;

                nuestadoOt := DAOR_ORDER.FNUGETORDER_STATUS_ID(TEMPCULDC_ORDER.ORDER_ID, NULL);
                IF NVL(nuestadoOt, 0) >= 5  AND
                 ((NVL(nuestadoOt, 0) !=20 and sbCaso678='S') OR sbCaso678 ='N') THEN

                    UPDATE LDC_ORDER
                    SET    ASIGNADO = 'S'
                    WHERE  NVL(PACKAGE_ID, 0) = NVL(TEMPCULDC_ORDER.PACKAGE_ID, 0)
                    AND    ORDER_ID = TEMPCULDC_ORDER.ORDER_ID;
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
                              if sbCaso272 = 'S' then
                                ACTUALIZA_SECTOR(TEMPCULDC_ORDER.ORDER_ID, nuSectorOperativo);
                              else
                               UPDATE or_order SET OPERATING_SECTOR_ID = nuSectorOperativo WHERE order_id = TEMPCULDC_ORDER.ORDER_ID;
                              end if;

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

                                /*
                                LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                     TEMPCULDC_ORDER.ORDER_ID,
                                                                     'PETI ANTES DE VALIDAR PROCESO MULTIFAMILIAR ' ||
                                                                     SBDATAIN);
                                */

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

                                /*02/07/2014 LLOZADA: Se debe dejar NUll la variable SBUNIDADOPERATIVA para que
                                para que realice la configuraci?n b?sica de UOBYSOL*/
                                /*
                                LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                     TEMPCULDC_ORDER.ORDER_ID,
                                                                     'LDC_BOASIGAUTO.PRASIGNACION, VALIDA IF SBUNIDADOPERATIVA = -1 THEN SBUNIDADOPERATIVA[' ||
                                                                     SBUNIDADOPERATIVA || ']');
                                */

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

                                    --IF SBUNIDADOPERATIVA = 'CARRUSEL' THEN
                                    --  EXIT;
                                    --END IF;

                                END IF;
                                ---FIN CODIGO SERVICIO PRE



                                ---PROCESO CONFIGURACION UOBYSOL
                                IF SBUNIDADOPERATIVA IS NULL THEN



                                    --CONSULTA PARA OBTENER EL SECTOR OPERATIVO DE LA ORDEN
                                    BEGIN
                                        /*CASO 200-2067 COMENTARIADO PARA ESTABLECER SECTOR OPERTAIVO DESDE EL CURSOR PRINCIPAL
                                        SELECT OPERATING_SECTOR_ID
                                        INTO   NUOPERATING_SECTOR_ID
                                        FROM   OR_ORDER OO
                                        WHERE  OO.ORDER_ID = TEMPCULDC_ORDER.ORDER_ID;
                                        */
                                        NUOPERATING_SECTOR_ID := TEMPCULDC_ORDER.SECTOR_OPERATIVO_ORDEN;
                                    END;


                                    --CONSULTA PARA OBTENER LA ZONA DE LA ORDEN

                                    BEGIN
                                        /*CASO 200-2067 COMENTARIADO PARA ESTABLECER ZONA DESDE EL CURSOR PRINCIPAL
                                        SELECT OPERATING_ZONE_ID
                                        INTO   NUOPERATING_ZONE_ID
                                        FROM   OR_OPERATING_UNIT OOU
                                        WHERE  OOU.OPERATING_UNIT_ID = TEMPCUUOBYSOL.OPERATING_UNIT_ID;
                                        */
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


                                        /*
                                        --VALIDACION DE ROL
                                        OPEN CUROL(TEMPCUUOBYSOL.OPERATING_UNIT_ID);
                                        FETCH CUROL
                                          INTO TEMPCUROL;
                                        IF CUROL%FOUND THEN
                                        */
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
                                            UT_TRACE.TRACE('LA CATEGIRIA DEL PRODUCTO GENERICO ES [' ||
                                                           RTCUSEGMENTOCATEGORIA.CATEGORIA || ']',
                                                           10);

                                            CLOSE CUSEGMENTOCATEGORIA;


                                        END IF;
                                        CLOSE CUTIPOPRODUCTO;
                                        --FIN NC 2493



                                        /*CASO 200-2067
                                        --comentarioado para utiliza valor obtenido del cursor CUUOBYSOL
                                        OPEN CUCATEGORIA(TEMPCUUOBYSOL.PRODUCT_ID,
                                                         TEMPCUUOBYSOL.ADDRESS_ID);
                                        FETCH CUCATEGORIA
                                            INTO TEMPCUCATEGORIA;
                                        */



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
                                                        FROM open.ge_contrato C, open.ge_contratista g
                                                        WHERE C.ID_CONTRATISTA = G.ID_CONTRATISTA AND
                                                              C.status = ct_boconstants.fsbGetOpenStatus AND
                                                             C.ID_CONTRATISTA IN (SELECT contractor_id
                                                                                  FROM open.or_operating_unit ou
                                                                                  WHERE ou.operating_unit_id = TEMPCUUOBYSOL.OPERATING_UNIT_ID) AND
                                                            (SYSDATE BETWEEN C.FECHA_INICIAL AND C.FECHA_FINAL)
                                                            ;
                                                    ELSE
                                                      nuContrato := 1;
                                                    END IF;
                                                    --TICKET 2001377 LJLB -- se valida que exista contrato igente de la unidad qye se va asignar
                                                    IF nuContrato > 0 THEN

                                                       if sbCaso272='S' then
                                                             ASIGNACION(TEMPCULDC_ORDER.Order_Id,
                                                                        TEMPCUUOBYSOL.OPERATING_UNIT_ID,--
                                                                        SYSDATE,
                                                                        SYSDATE,
                                                                        TEMPCULDC_ORDER.PACKAGE_ID,
                                                                        onuerrorcode,
                                                                        osberrormessage);
                                                       else
                                                            os_assign_order(TEMPCULDC_ORDER.Order_Id,
                                                                        TEMPCUUOBYSOL.OPERATING_UNIT_ID,--
                                                                        SYSDATE,
                                                                        SYSDATE,
                                                                        onuerrorcode,
                                                                        osberrormessage);
                                                       end if;

                                                        IF onuerrorcode = 0 THEN


                                                            /*CASO 200-2067
                                                            PRINTENTOSASIGNACION(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                                 TEMPCULDC_ORDER.ORDER_ID);
                                                            */
                                                            --
                                                            if sbCaso272 = 'N' then
                                                              UPDATE LDC_ORDER
                                                              SET    ASIGNADO = 'S'
                                                              WHERE  NVL(PACKAGE_ID, 0) =
                                                                     NVL(TEMPCULDC_ORDER.PACKAGE_ID, 0)
                                                              AND    ORDER_ID = TEMPCULDC_ORDER.ORDER_ID;

                                                              proRegistraLogAsig( TEMPCULDC_ORDER.ORDER_ID,
                                                                                    TEMPCULDC_ORDER.PACKAGE_ID,
                                                                                    null);

                                                            else
                                                              GOTO siguiente;
                                                            end if;
                                                            --EXIT;
                                                        ELSE


                                                            IF sbFlag = 'S' THEN
                                                              --TICKET 2001377 LJLB -- se registra log en la tabla LDC_ORDER
                                                               sbError := substr(sbError||v_salto|| 'ORDEN ['||TEMPCULDC_ORDER.Order_Id||'] UNIDAD OPERATIVA [' ||TEMPCUUOBYSOL.OPERATING_UNIT_ID || '] CODIGO_ERROR [' ||            onuerrorcode || '] DESCRIPCION [' ||   osberrormessage || ']', 1, 3999);

                                                              proRegistraLogAsig( TEMPCULDC_ORDER.ORDER_ID,
                                                                                  TEMPCULDC_ORDER.PACKAGE_ID,
                                                                                  sbError);
                                                            END IF;
                                                            /*CASO 200-2067
                                                            PRINTENTOSASIGNACION(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                                 TEMPCULDC_ORDER.ORDER_ID);
                                                            */
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

                                                        /* CASO 200-2067
                                                        PRINTENTOSASIGNACION(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                             TEMPCULDC_ORDER.Order_Id);
                                                        */

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
                                                /*CASO 200-2067
                                                PRINTENTOSASIGNACION(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                     TEMPCULDC_ORDER.Order_Id);
                                                */

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
                                                if sbCaso272 ='S' then
                                                  ACTUALIZA_MENSAJE(TEMPCULDC_ORDER.ORDER_ID,TEMPCULDC_ORDER.PACKAGE_ID, sbError);
                                                else
                                                  UPDATE LDC_ORDER
                                                  SET    LDC_ORDER.ORDEOBSE =  sbError
                                                  WHERE  ORDER_ID = TEMPCULDC_ORDER.ORDER_ID
                                                  AND NVL(PACKAGE_ID, 0) = NVL(TEMPCULDC_ORDER.PACKAGE_ID, 0);
                                                end if;



                                            END IF;
                                            /*CASO 200-2067
                                            PRINTENTOSASIGNACION(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                 TEMPCULDC_ORDER.Order_Id);
                                            */

                                        END IF;

                                        --CASO 200-2067 comentaiario por no utilizarse
                                        --CLOSE CUCATEGORIA;
                                        /*

                                          ELSE
                                            LDC_BOASIGAUTO.PRREGSITROASIGAUTO(:NEW.PACKAGE_ID,
                                                                              :NEW.Order_Id,
                                                                              'NO ENCONTRO CATEROGIA VALIDA PARA EL CONTRATO ' ||
                                                                              :NEW.SUBSCRIPTION_ID);
                                          END IF; --FIN VALIDACION DE CAPACIDAD
                                          CLOSE CUOR_OPERATING_UNIT;
                                          UT_TRACE.TRACE('FIN CUOR_OPERATING_UNIT', 10);
                                        ELSE
                                          LDC_BOASIGAUTO.PRREGSITROASIGAUTO(:NEW.PACKAGE_ID,
                                                                            :NEW.Order_Id,
                                                                            'LA ACTIVIDAD [' ||
                                                                            :NEW.ACTIVITY_ID ||
                                                                            '] Y LA UNIDAD OPERATIVA [' ||
                                                                            TEMPCUUOBYSOL.OPERATING_UNIT_ID ||
                                                                            '] NO ESTAN EN EL MISMO ROL');

                                        END IF; --FIN VALIDACION DE ROL
                                        CLOSE CUROL;
                                        UT_TRACE.TRACE('FIN CUROL', 10);
                                        */
                                    ELSE


                                        IF sbFlag = 'S' THEN
                                           --TICKET 2001377 LJLB -- se registra log en la tabla LDC_ORDER
                                           sbError := substr(sbError||v_salto|| 'LA ORDEN [' ||TEMPCULDC_ORDER.ORDER_ID ||'] Y LA UNIDAD OPERATIVA [' || TEMPCUUOBYSOL.OPERATING_UNIT_ID ||'] NO ESTAN EN LA MISMA ZONA OPERATIVA. SECTOR ORDEN['||nuSectorOperativo||']  ZONA OPERATIVA  DE LA UNIDAD OPERATIVA ['||NUOPERATING_ZONE_ID||']', 1, 3999);

                                          proRegistraLogAsig( TEMPCULDC_ORDER.ORDER_ID,
                                                            TEMPCULDC_ORDER.PACKAGE_ID,
                                                            sbError);

                                        ELSE
                                           sbError := substr(sbError||v_salto|| 'LA ORDEN [' ||TEMPCULDC_ORDER.ORDER_ID ||'] Y LA UNIDAD OPERATIVA [' || TEMPCUUOBYSOL.OPERATING_UNIT_ID ||'] NO ESTAN EN LA MISMA ZONA OPERATIVA. SECTOR ORDEN['||NUOPERATING_SECTOR_ID||']  ZONA OPERATIVA  DE LA UNIDAD OPERATIVA ['||NUOPERATING_ZONE_ID||']', 1, 3999);
                                           if sbCaso272 ='S' then
                                             ACTUALIZA_MENSAJE(TEMPCULDC_ORDER.ORDER_ID,TEMPCULDC_ORDER.PACKAGE_ID, sbError);
                                           else
                                             UPDATE LDC_ORDER
                                             SET    LDC_ORDER.ORDEOBSE =  sbError
                                             WHERE  ORDER_ID = TEMPCULDC_ORDER.ORDER_ID
                                             AND NVL(PACKAGE_ID, 0) = NVL(TEMPCULDC_ORDER.PACKAGE_ID, 0);
                                           end if;

                                        END IF;

                                        /*CASO 200-2067
                                        PRINTENTOSASIGNACION(TEMPCULDC_ORDER.PACKAGE_ID,
                                                             TEMPCULDC_ORDER.Order_Id);
                                        */
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
                                dbms_output.put_line('error orden'||nuOrden||' CUUOBYSOL: CODE: '||SQLCODE||' ERROR: '||SQLERRM);
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
                        if sbCaso272 ='S' then
						             rollback;
                         UPDATE LDC_ORDER
                            SET ASIGNACION = nuCantidadIntentos + 1,
                                ORDEOBSE = 'La orden no tiene en estos momentos una configuraci¿n en UOBYSOL v¿lida.'
                         WHERE ORDER_ID = nuOrden AND NVL(PACKAGE_ID,0) = NVL(NUSOLICITUD,0);
						             commit;
                        END IF;

                    ELSE
                        --CASO 200-2067
                        --Se crea el ELSE para controlar si existe confgiuracion debe marcar el intento de asignacion
                        if sbCaso272 ='S' then
                           ROLLBACK;
                        END IF;
                        PRINTENTOSASIGNACION(TEMPCULDC_ORDER.PACKAGE_ID, TEMPCULDC_ORDER.Order_Id);
                        if sbCaso272 ='S' then
                           COMMIT;
                        END IF;

                    END IF;

                    <<siguiente>>
                        NULL;
                    ---FIN CODIGO DE ASIGNACION
                END IF;

            EXCEPTION
                WHEN OTHERS THEN
                    Errors.setError;
                    dbms_output.put_line('error orden '||nuOrden||' CULDC_ORDER: CODE: '||SQLCODE||' ERROR: '||SQLERRM);
            END;
            --FIN VALIDACION DE ACTUALIZA EL CAMPO ASIGNADO DE LAS ORDENES EN LDC_ORDER.
        END LOOP; -- Fin loop CULDC_ORDER

        --LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(NUSOLICITUD, NUORDEN, 'PETI ANTES DEL COMMIT');

        COMMIT;

    EXCEPTION

        WHEN OTHERS THEN

            OSBERRORMESSAGE := '[' || DBMS_UTILITY.FORMAT_ERROR_STACK || '] - ' ||
                               DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(NULL,
                                                 NULL,
                                                 'ERROR OTHERS PRASIGNACION --> ' ||
                                                 OSBERRORMESSAGE);
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

    --RNP 404
    /*****************************************************************
    PROPIEDAD INTELECTUAL DE PETI (C).

    UNIDAD         : FSBLDCCAR
    DESCRIPCION    : SERVICIO PARA ASIGNARA UNIDAD OPERATIVA A ORDENES CONFIGURADAS EN
                     CARRUSEL GLOBAL CONFIGURADO EN LA APLICACION LDCCAR.
    AUTOR          : JORGE VALIENTE
    FECHA          : 22/07/2014

    PARAMETROS              DESCRIPCION
    ============         ===================
     ISBIN               VALORES EN UNA CADENA

    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    ******************************************************************/
    FUNCTION FSBLDCCAR(SBIN IN VARCHAR2) RETURN VARCHAR2 IS

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

        --CON ESTA ORDEN SE SABE EN EL CICLO QUE DATO VA
        --EN SECUENCIA PARA SABER CUAL DE LOS DATOS UTILIZAR
        ----------------------------------------------------

        ONUERRORCODE    NUMBER;
        OSBERRORMESSAGE VARCHAR2(4000);

        --SEPARA LOS DATOS OBTENIDOS DE LA CADENA DE ENTRADA
        --CON EL SEPARADOR |
        CURSOR CUDATA IS
            SELECT COLUMN_VALUE FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(SBIN, '|'));
        ---FIN CURSOR DATA

        NUOPERATING_UNIT_ID OR_ORDER.OPERATING_UNIT_ID%TYPE;

        RCORDERTOASSIGN     DAOR_ORDER.STYOR_ORDER;
        RCORDERTOASSIGNNULL DAOR_ORDER.STYOR_ORDER;

        SBDATAIN VARCHAR2(4000);

        --CURSOR PARA IDENTIFICAR TODOS LAS UNIDADES OPERATIAS ACTIVAS EN LA CONFIGURACION DE LDCCAR
        CURSOR CUCARGLOUNIOPE(NUOPERATING_UNIT_ID OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE) IS
            SELECT /*+ INDEX (LC IDX_LDC_CARGLOUNIOPE_02) */
             *
            FROM   LDC_CARGLOUNIOPE LC
            WHERE  LC.OPERATING_UNIT_ID = NUOPERATING_UNIT_ID
            AND    NVL(DAOR_OPERATING_UNIT.FNUGETASSIGN_CAPACITY(LC.OPERATING_UNIT_ID, NULL), 0) >
                   NVL(DAOR_OPERATING_UNIT.FNUGETUSED_ASSIGN_CAP(LC.OPERATING_UNIT_ID, NULL), 0)
            AND    LC.ACTIVO = 'S';

        TEMPCUCARUNIOPE CUCARGLOUNIOPE%ROWTYPE;

        --CURSOR PARA IDENTIFICAR TODOS LAS UNIDADES OPERATIAS ACTIVAS
        --PARA RESIDENCIAL
        CURSOR CUCARGLOUNIOPEALL(NUORDER_ID   NUMBER,
                                 NUPACKAGE_ID NUMBER) IS
            SELECT LC.*
            FROM   LDC_PACKAGE_TYPE_OPER_UNIT LPTOU,
                   LDC_PACKAGE_TYPE_ASSIGN    LPTA,
                   OR_ORDER_ACTIVITY          OOA,
                   LDC_CARGLOUNIOPE           LC
            WHERE  OOA.ORDER_ID = NUORDER_ID
            AND    NVL(OOA.PACKAGE_ID, 0) = NVL(NUPACKAGE_ID, 0)
            AND    LPTOU.ITEMS_ID = OOA.ACTIVITY_ID
            AND    LPTA.PACKAGE_TYPE_ASSIGN_ID = LPTOU.PACKAGE_TYPE_ASSIGN_ID
            AND    LPTA.PACKAGE_TYPE_ID =
                   DECODE(DAMO_PACKAGES.FNUGETPACKAGE_TYPE_ID(OOA.PACKAGE_ID, NULL),
                           NULL,
                           -1,
                           DAMO_PACKAGES.FNUGETPACKAGE_TYPE_ID(OOA.PACKAGE_ID, NULL))
            AND    LPTOU.PACKAGE_TYPE_OPER_UNIT_ID = LC.PACKAGE_TYPE_OPER_UNIT_ID
            AND    LC.ACTIVO = 'S'
            ORDER  BY LC.CONTADOR;

        TEMPCUCARGLOUNIOPEALL CUCARGLOUNIOPEALL%ROWTYPE;

        SBTRIGGER VARCHAR2(4000);

        --CURSOR CUGE_SECTOROPE_ZONA(NUOPERATING_UNIT_ID OR_ORDER.OPERATING_UNIT_ID%TYPE) IS
        CURSOR CUGE_SECTOROPE_ZONA(INUOPERATING_SECTOR_ID OR_ORDER.OPERATING_SECTOR_ID%TYPE,
                                   INUOPERATING_ZONE_ID   OR_OPERATING_UNIT.OPERATING_ZONE_ID%TYPE) IS
            SELECT GSZ.*
            FROM   GE_SECTOROPE_ZONA GSZ
            WHERE  GSZ.ID_SECTOR_OPERATIVO = INUOPERATING_SECTOR_ID
            AND    GSZ.ID_ZONA_OPERATIVA = INUOPERATING_ZONE_ID;

        TEMPCUGE_SECTOROPE_ZONA CUGE_SECTOROPE_ZONA%ROWTYPE;
        NUOPERATING_SECTOR_ID   OR_ORDER.OPERATING_SECTOR_ID%TYPE;
        NUOPERATING_ZONE_ID     OR_OPERATING_UNIT.OPERATING_ZONE_ID%TYPE;

        --CURSOR PARA VALIDAR EL ROL DE LA UNIDAD OPERATIVA Y
        --LA ACTIVIDAD DE LA ORDEN GENERADA.
        CURSOR CUROL(NUOPERATING_UNIT_ID OR_ORDER.OPERATING_UNIT_ID%TYPE,
                     NUACTIVITY_ID       OR_ORDER_ACTIVITY.ACTIVITY_ID%TYPE) IS
            SELECT OAR.*
            FROM   OR_ACTIVIDADES_ROL OAR,
                   OR_ROL_UNIDAD_TRAB ORUT
            WHERE  OAR.ID_ROL = ORUT.ID_ROL
            AND    ORUT.ID_UNIDAD_OPERATIVA = NUOPERATING_UNIT_ID
            AND    OAR.ID_ACTIVIDAD = NUACTIVITY_ID;

        TEMPCUROL CUROL%ROWTYPE;
        --FIN CURSOR CUROL

        NUHORASDISPONIBLES OR_OPERATING_UNIT.ASSIGN_CAPACITY%TYPE;

        --VARIABLES DE CONTROL
        NUCONTROLSECTOROPERTAIVO NUMBER := 0;
        NUCONTROLZONAOPERTAIVO   NUMBER := 0;

    BEGIN

        UT_TRACE.TRACE('INICIO LDC_BOASIGAUTO.FSBLDCCAR', 10);

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
            ELSIF SBTRIGGER IS NULL THEN
                SBTRIGGER       := TEMPCUDATA.COLUMN_VALUE;
                OSBERRORMESSAGE := OSBERRORMESSAGE || ' - ' || SBTRIGGER;
            END IF;

        END LOOP;

        NUOPERATING_UNIT_ID := -1;

        /*
        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                             TO_NUMBER(SBORDER_ID),
                                             'PETI ANTES DE INGRESAR A CUCARUNIOPEALL');
        */
        --CICLO PARA VALIDAR LAS UNIDADES OPERATIVAS ACTIVAS EN LDCCAR
        FOR TEMPCUCARGLOUNIOPEALL IN CUCARGLOUNIOPEALL(TO_NUMBER(SBORDER_ID),
                                                       TO_NUMBER(SBPACKAGE_ID)) LOOP

            --INICIALIZAR VARAIBLES CON CADA REGISTRO NUEVO
            NUCONTROLSECTOROPERTAIVO := 0;
            NUCONTROLZONAOPERTAIVO   := 0;
            --FIN INICIAALIZACION VARIABELS

            --SENTENCIA PARA OBTENER EL SECTOR OPERATIVO DE LA ORDEN
            --NO SE UTILIZO EL PAQUETE DE 1ER NIVEL POR SOLCIITUD DEL ING. CERSAR NAVIA OPEN
            BEGIN
                SELECT OPERATING_SECTOR_ID
                INTO   NUOPERATING_SECTOR_ID
                FROM   OR_ORDER OO
                WHERE  OO.ORDER_ID = TO_NUMBER(SBORDER_ID);
            END;
            --FIN SENTENCIA PARA OBTENER EL SECTOR OPERATIVO DE LA ORDEN

            --SENTENCIA PARA OBTENER LA ZONA OPERATIVA DE LA UNIDAD DE TRABAJO
            --NO SE UTILIZO EL PAQUETE DE 1ER NIVEL POR SOLCIITUD DEL ING. CERSAR NAVIA OPEN
            BEGIN
                SELECT OPERATING_ZONE_ID
                INTO   NUOPERATING_ZONE_ID
                FROM   OR_OPERATING_UNIT OOU
                WHERE  OOU.OPERATING_UNIT_ID = TEMPCUCARGLOUNIOPEALL.OPERATING_UNIT_ID;
            END;
            --FIN SENTENCIA PARA OBTENER LA ZONA OPERATIVA DE LA UNIDAD DE TRABAJO

            --VALIDAR SI EL SECTOR OPERATIVO DE LDCCAR ES EL MISMO DE LA ORDEN
            IF TEMPCUCARGLOUNIOPEALL.OPERATING_SECTOR_ID IS NOT NULL THEN

                IF TEMPCUCARGLOUNIOPEALL.OPERATING_SECTOR_ID <> NUOPERATING_SECTOR_ID THEN
                    NUCONTROLSECTOROPERTAIVO := -1;
                END IF;

            END IF;
            --FIN VALIDAR SI EL SECTOR OPERATIVO DE LDCCAR ES EL MISMO DE LA ORDEN

            --VALIDAR SI EL SECTOR OPERATIVO DE LDCCAR ES EL MISMO DE LA ORDEN
            IF TEMPCUCARGLOUNIOPEALL.OPERATING_ZONE_ID IS NOT NULL THEN

                IF TEMPCUCARGLOUNIOPEALL.OPERATING_ZONE_ID <> NUOPERATING_ZONE_ID THEN
                    NUCONTROLZONAOPERTAIVO := -1;
                END IF;

            END IF;
            --FIN VALIDAR SI EL SECTOR OPERATIVO DE LDCCAR ES EL MISMO DE LA ORDEN

            IF NUCONTROLZONAOPERTAIVO <> -1 THEN
                IF NUCONTROLSECTOROPERTAIVO <> -1 THEN

                    --VALIDACION DE ROL
                    OPEN CUROL(TEMPCUCARGLOUNIOPEALL.OPERATING_UNIT_ID, TO_NUMBER(SBACTIVITY_ID));
                    FETCH CUROL
                        INTO TEMPCUROL;
                    IF CUROL%FOUND THEN
                        --VALIDA SECTOR OPERATIVO DE LA ORDEN ESTE EN LA MISMA ZONA DE LA UNIDAD DE TRABAJO
                        OPEN CUGE_SECTOROPE_ZONA(NUOPERATING_SECTOR_ID, NUOPERATING_ZONE_ID);
                        FETCH CUGE_SECTOROPE_ZONA
                            INTO TEMPCUGE_SECTOROPE_ZONA;
                        IF CUGE_SECTOROPE_ZONA%FOUND THEN

                            IF NVL(DAOR_OPERATING_UNIT.FNUGETASSIGN_CAPACITY(TEMPCUCARGLOUNIOPEALL.OPERATING_UNIT_ID,
                                                                             NULL),
                                   0) > NVL(DAOR_OPERATING_UNIT.FNUGETUSED_ASSIGN_CAP(TEMPCUCARGLOUNIOPEALL.OPERATING_UNIT_ID,
                                                                                      NULL),
                                            0) THEN

                                NUOPERATING_UNIT_ID := TEMPCUCARGLOUNIOPEALL.OPERATING_UNIT_ID;

                                --SERVICIO DE ASIGNACION DE UNIDAD OPERATIVA A ORDENES DE TRABAJO
                                os_assign_order(TO_NUMBER(SBORDER_ID),
                                                NUOPERATING_UNIT_ID,
                                                SYSDATE,
                                                SYSDATE,
                                                onuerrorcode,
                                                osberrormessage);
                                IF onuerrorcode = 0 THEN
                                    UPDATE LDC_CARGLOUNIOPE
                                    SET    CONTADOR = CONTADOR + 1
                                    WHERE  OPERATING_UNIT_ID = NUOPERATING_UNIT_ID;
                                    /*
                                    LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                                         TO_NUMBER(SBORDER_ID),
                                                                         'LDCCAR ASIGNACION DE UNIDAD OPERATIVA [' ||
                                                                         NUOPERATING_UNIT_ID || ']');
                                    --*/
                                    --PRINTENTOSASIGNACION(TO_NUMBER(SBPACKAGE_ID),TO_NUMBER(SBORDER_ID));

                                    UPDATE LDC_ORDER
                                    SET    ASIGNADO = 'S'
                                    WHERE  NVL(PACKAGE_ID, 0) = NVL(TO_NUMBER(SBPACKAGE_ID), 0)
                                    AND    ORDER_ID = TO_NUMBER(SBORDER_ID);

                                    EXIT;
                                ELSE
                                    NUOPERATING_UNIT_ID := -1;
                                    LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                                         TO_NUMBER(SBORDER_ID),
                                                                         'EL SERVICIO os_assign_order NO PUDO ASIGNAR LA UNIDAD DE TRABAJO [' ||
                                                                         TEMPCUCARGLOUNIOPEALL.OPERATING_UNIT_ID ||
                                                                         '] A LA ORDEN [' ||
                                                                         SBORDER_ID || '] - ' ||
                                                                         osberrormessage);
                                    --PRINTENTOSASIGNACION(TO_NUMBER(SBPACKAGE_ID),TO_NUMBER(SBORDER_ID));
                                END IF;

                            ELSE
                                UPDATE LDC_CARGLOUNIOPE
                                SET    ACTIVO = 'N'
                                WHERE  OPERATING_UNIT_ID = TEMPCUCARGLOUNIOPEALL.OPERATING_UNIT_ID;

                                LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                                     TO_NUMBER(SBORDER_ID),
                                                                     'LA UNIDAD OPERATIVA FUE DESACTIVADA PARA LDCCAR YA QUE LA CANTIDAD DE HORAS ASIGNADA [' ||
                                                                     NVL(DAOR_OPERATING_UNIT.FNUGETASSIGN_CAPACITY(TEMPCUCARGLOUNIOPEALL.OPERATING_UNIT_ID,
                                                                                                                   NULL),
                                                                         0) ||
                                                                     '] ES INFERIOR O IGUAL A LA CANTIDAD DE HORAS UTILIZADAS [' ||
                                                                     NVL(DAOR_OPERATING_UNIT.FNUGETUSED_ASSIGN_CAP(TEMPCUCARGLOUNIOPEALL.OPERATING_UNIT_ID,
                                                                                                                   NULL),
                                                                         0) || ']');

                            END IF;

                        ELSE
                            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                                 TO_NUMBER(SBORDER_ID),
                                                                 'LDCCAR - LA ORDEN [' ||
                                                                 SBORDER_ID ||
                                                                 '] Y LA UNIDAD OPERATIVA [' ||
                                                                 TEMPCUCARGLOUNIOPEALL.OPERATING_UNIT_ID ||
                                                                 '] NO ESTAN EN EL MISMO SECTOR OPERATIVO');

                        END IF;
                        CLOSE CUGE_SECTOROPE_ZONA;
                    ELSE
                        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                             TO_NUMBER(SBORDER_ID),
                                                             'LDCCAR - LA ACTIVIDAD [' ||
                                                             SBACTIVITY_ID ||
                                                             '] Y LA UNIDAD OPERATIVA [' ||
                                                             TEMPCUCARGLOUNIOPEALL.OPERATING_UNIT_ID ||
                                                             '] NO ESTAN EN EL MISMO ROL');

                    END IF; --FIN VALIDACION DE ROL
                    CLOSE CUROL;
                ELSE
                    --/*
                    LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                         TO_NUMBER(SBORDER_ID),
                                                         'EL SECTOR OPERATIVO [' ||
                                                         TEMPCUCARGLOUNIOPEALL.OPERATING_SECTOR_ID ||
                                                         '] CONFIGURADO EN LDCCAR NO ES CONSISTENTE CON EL DE LA ORDEN');
                    --*/
                END IF; --FIN DE VALIDAR SECTOR OPERATIVO

            ELSE
                --/*
                LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                     TO_NUMBER(SBORDER_ID),
                                                     'LDCCAR - LA ZONA OPERATIVA [' ||
                                                     NUOPERATING_ZONE_ID || '] NO ESTA CONFIGURADO');
                --*/
            END IF; --FIN DE VALIDAR ZONA OPERATIVO

        END LOOP;

        UT_TRACE.TRACE('FIN LDC_BOASIGAUTO.FSBLDCCAR', 10);

        RETURN(NUOPERATING_UNIT_ID);

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            --ROLLBACK;
            ONUERRORCODE    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            OSBERRORMESSAGE := 'INCONVENIENTES AL ASIGNAR LA UNIDAD OPERTAIVA POR CARRUSEL' ||
                               PKERRORS.FSBGETERRORMESSAGE;

            OSBERRORMESSAGE := OSBERRORMESSAGE || ' - ' || DBMS_UTILITY.FORMAT_ERROR_STACK || ' - ' ||
                               DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                 TO_NUMBER(SBORDER_ID),
                                                 OSBERRORMESSAGE);

            --RETURN(NULL);
            RETURN(-1);

        WHEN OTHERS THEN

            OSBERRORMESSAGE := '[' || DBMS_UTILITY.FORMAT_ERROR_STACK || '] - ' ||
                               DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                 TO_NUMBER(SBORDER_ID),
                                                 'ERROR OTHERS FSBCARRUSEL --> ' || OSBERRORMESSAGE);

            RETURN(-1);

    END FSBLDCCAR;
    --RNP 404 FIN DESARROLLO

    /*****************************************************************
    PROPIEDAD INTELECTUAL DE PETI (C).

    UNIDAD         : FSBVISITAVALIDACION
    DESCRIPCION    : PROCESO QUE PERMITE ASIGNAR A LA ORDENE DE
                     REPARACI?N Y CERTIFICACI?N , CON LA UNIDAD OPERATIVA
                     ASIGNADA A LA ORDEN QUE SE LEGALIZO DE VISITA DE VALIDACI?N DE CERTIFICADO (10446)
                     O VISITA DE VALIDACION DE REPARACIONES (10445).

    AUTOR          : SAYRA OCORO
    FECHA          : 10/08/2014

    PARAMETROS              DESCRIPCION
    ============         ===================
    ISBIN               VALORES EN UNA CADENA

    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    ******************************************************************/
    FUNCTION FSBVISITAVALIDACION(SBIN IN VARCHAR2) RETURN VARCHAR2 IS

        SBORDER_ID      VARCHAR2(4000) := NULL;
        SBPACKAGE_ID    VARCHAR2(4000) := NULL;
        SBACTIVITY_ID   VARCHAR2(4000) := NULL;
        SUBSCRIPTION_ID VARCHAR2(4000) := NULL;

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

        RCORDERTOASSIGN     DAOR_ORDER.STYOR_ORDER;
        RCORDERTOASSIGNNULL DAOR_ORDER.STYOR_ORDER;

        --CUROSR PARA OBTENER LA UNIDAD OPERATIVA CONVEINETE
        --PARA ESA ORDEN DE PUNTO FIJO
        CURSOR CUUNIDADOPERATIVA(NUPACKAGE_ID  MO_PACKAGES.PACKAGE_ID%TYPE,
                                 NUORDER_ID    OR_ORDER.ORDER_ID%TYPE,
                                 inuActivityId ge_items.items_id%TYPE) IS
            SELECT O.ORDER_ID,
                   O.OPERATING_UNIT_ID,
                   OA1.ORDER_ACTIVITY_ID
            FROM   OPEN.OR_ORDER          O,
                   OPEN.OR_ORDER_ACTIVITY OA1,
                   OPEN.MO_PACKAGES       P,
                   OPEN.MO_MOTIVE         M
            WHERE  O.ORDER_ID = OA1.ORDER_ID
            AND    OA1.PACKAGE_ID = NUPACKAGE_ID
            AND    OA1.PACKAGE_ID = P.PACKAGE_ID
            AND    P.PACKAGE_ID = M.PACKAGE_ID
            AND    OA1.ACTIVITY_ID = inuActivityId
            AND    OA1.ACTIVITY_GROUP_ID IS NULL
            AND    ROWNUM = 1;

        TEMPCUUNIDADOPERATIVA CUUNIDADOPERATIVA%ROWTYPE;
        --FIN CUUNIDADOPERATIVA
        nuTaskTypeId or_task_type.task_type_id%TYPE;
        nuActivityId ge_items.items_id%TYPE;

    BEGIN

        UT_TRACE.TRACE('INICIO LDC_BOASIGAUTO.FSBVISITAVALIDACION', 10);

        FOR TEMPCUDATA IN CUDATA LOOP

            UT_TRACE.TRACE(TEMPCUDATA.COLUMN_VALUE, 10);

            IF SBORDER_ID IS NULL THEN
                SBORDER_ID      := TEMPCUDATA.COLUMN_VALUE;
                OSBERRORMESSAGE := '[ORDEN - ' || SBORDER_ID || ']';
            ELSIF SBPACKAGE_ID IS NULL THEN
                SBPACKAGE_ID    := TEMPCUDATA.COLUMN_VALUE;
                OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [SOLICITUD - ' || SBPACKAGE_ID || ']';
            ELSIF SBACTIVITY_ID IS NULL THEN
                SBACTIVITY_ID   := TEMPCUDATA.COLUMN_VALUE;
                OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [ACTIVIDAD - ' || SBACTIVITY_ID || ']';
            ELSIF SUBSCRIPTION_ID IS NULL THEN
                SUBSCRIPTION_ID := TEMPCUDATA.COLUMN_VALUE;
                OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [CONTRATO - ' || SUBSCRIPTION_ID || ']';
            END IF;

        END LOOP;

        NUOPERATING_UNIT_ID := NULL;
        --Validar si son trabajos de reparaci?n
        IF instr(',' || dald_parameter.fsbGetValue_Chain('ACTIVIDADES_REPARACION') || ',',
                 ',' || SBACTIVITY_ID || ',') > 0 THEN
            nuActivityId := 4295654; --VISITA IDENTIFICACI?N DE REPARACIONES
        ELSE
            nuTaskTypeId := daor_order.fnugettask_type_id(TO_NUMBER(SBORDER_ID));
            IF nuTaskTypeId IN (12162, 12163, 12164) THEN
                nuActivityId := 4295655; --VISITA IDENTIFICACI?N DE CERTIFICACION TRABAJOS
            END IF;
        END IF;

        OPEN CUUNIDADOPERATIVA(TO_NUMBER(SBPACKAGE_ID), TO_NUMBER(SBORDER_ID), nuActivityId);
        FETCH CUUNIDADOPERATIVA
            INTO TEMPCUUNIDADOPERATIVA;
        IF CUUNIDADOPERATIVA%FOUND THEN
            NUOPERATING_UNIT_ID := TEMPCUUNIDADOPERATIVA.OPERATING_UNIT_ID;

            BEGIN

                os_assign_order(TO_NUMBER(SBORDER_ID),
                                NUOPERATING_UNIT_ID,
                                SYSDATE,
                                SYSDATE,
                                onuerrorcode,
                                osberrormessage);
                IF onuerrorcode = 0 THEN
                    UPDATE LDC_CARUNIOPE
                    SET    CONTADOR       = CONTADOR + 1,
                           FECHA_CONTADOR = SYSDATE,
                           PACKAGE_ID     = TO_NUMBER(SBPACKAGE_ID)
                    WHERE  OPERATING_UNIT_ID = NUOPERATING_UNIT_ID;

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

            EXCEPTION
                WHEN OTHERS THEN
                    osberrormessage := 'INCONSISTENCIA TRIGGER TRGAFTERASIGAUTO [' ||
                                       DBMS_UTILITY.FORMAT_ERROR_STACK || '] - [' ||
                                       DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

                    LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                         TO_NUMBER(SBORDER_ID),
                                                         'EL SERVICIO os_assign_order NO PUDO ASIGNAR LA UNIDAD OPERATIVA A LA ORDEN [' ||
                                                         osberrormessage || '] Unidad de trabajo [' ||
                                                         NUOPERATING_UNIT_ID || ']');
            END;
            --*/
        ELSE
            --NUOPERATING_UNIT_ID := NULL;
            NUOPERATING_UNIT_ID := -1;
        END IF;
        CLOSE CUUNIDADOPERATIVA;

        UT_TRACE.TRACE('FIN LDC_BOASIGAUTO.FSBVISITAVALIDACION', 10);

        RETURN(NUOPERATING_UNIT_ID);

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            --ROLLBACK;
            ONUERRORCODE    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            OSBERRORMESSAGE := 'INCONVENIENTES AL ASIGNAR LA UNIDAD OPERTAIVA DE SOLICUTD INMEDIATA A LAS ORDENES GENERADAS POR DEFECTO DE REPARACION PERIODICA' ||
                               PKERRORS.FSBGETERRORMESSAGE;
            OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [' || DBMS_UTILITY.FORMAT_ERROR_STACK ||
                               ' - [' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                 TO_NUMBER(SBORDER_ID),
                                                 OSBERRORMESSAGE);

            RETURN(-1);

        WHEN OTHERS THEN
            --ROLLBACK;
            ONUERRORCODE    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            OSBERRORMESSAGE := 'INCONVENIENTES AL ASIGNAR LA UNIDAD OPERTAIVA DE SOLICUTD INMEDIATA A LAS ORDENES GENERADAS POR DEFECTO DE REPARACION PERIODICA' ||
                               PKERRORS.FSBGETERRORMESSAGE;
            OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [' || DBMS_UTILITY.FORMAT_ERROR_STACK ||
                               ' - [' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                 TO_NUMBER(SBORDER_ID),
                                                 OSBERRORMESSAGE);

            RETURN(-1);

    END FSBVISITAVALIDACION;

    --nuevos servicio NC4413 Solicitados por Zandra Prada

    /*****************************************************************
    PROPIEDAD INTELECTUAL DE PETI (C).

    UNIDAD         : FSBUTASIGOTANT
    DESCRIPCION    : Este servicio asigna la orden a la unidad de trabajo
                     de la orden inmediatamente anterior que se gener? en
                     la solicitud, siempre y cuando exista la configuraci?n
                     necesaria para que la ut realice el tipo de trabajo en el sector.

    AUTOR          : Lizeth Sanchez
    FECHA          : 18/12/2014

    PARAMETROS              DESCRIPCION
    ============         ===================
    ISBIN               VALORES EN UNA CADENA

    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    ******************************************************************/

    FUNCTION FSBUTASIGOTANT(SBIN IN VARCHAR2) RETURN VARCHAR2 IS

        SBORDER_ID      VARCHAR2(4000) := NULL;
        SBPACKAGE_ID    VARCHAR2(4000) := NULL;
        SBACTIVITY_ID   VARCHAR2(4000) := NULL;
        SUBSCRIPTION_ID VARCHAR2(4000) := NULL;
        nuORDENANT      NUMBER(20);

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

        RCORDERTOASSIGN     DAOR_ORDER.STYOR_ORDER;
        RCORDERTOASSIGNNULL DAOR_ORDER.STYOR_ORDER;

        --CUROSR PARA OBTENER LA ORDEN ANTERIOR ASOCIADA A LA SOLICITUD

        CURSOR cuULTIMAORDEN(NUPACKAGE_ID MO_PACKAGES.PACKAGE_ID%TYPE) IS
            SELECT MAX(ORDER_ID) ORDEN,
                   PACKAGE_ID
            FROM   OR_ORDER_ACTIVITY
            WHERE  PACKAGE_ID = NUPACKAGE_ID
            AND    OPERATING_UNIT_ID IS NOT NULL
            GROUP  BY PACKAGE_ID;

        --CUROSR PARA OBTENER LA UT DE LA ORDEN ANTERIOR ASOCIADA A LA SOLICITUD

        CURSOR CUUNIDADOPERATIVA(nuORDENANT OR_ORDER_ACTIVITY.ORDER_ID%TYPE) IS
            SELECT OPERATING_UNIT_ID FROM OR_ORDER_ACTIVITY WHERE ORDER_ID = nuORDENANT;

        TEMPCUUNIDADOPERATIVA CUUNIDADOPERATIVA%ROWTYPE;
        TEMPCUULTIMAORDEN     cuULTIMAORDEN%ROWTYPE;

    BEGIN

        UT_TRACE.TRACE('INICIO LDC_BOASIGAUTO.FSBUTASIGNADAOTANTERIOR', 10);

        FOR TEMPCUDATA IN CUDATA LOOP

            UT_TRACE.TRACE(TEMPCUDATA.COLUMN_VALUE, 10);

            IF SBORDER_ID IS NULL THEN
                SBORDER_ID      := TEMPCUDATA.COLUMN_VALUE;
                OSBERRORMESSAGE := '[ORDEN - ' || SBORDER_ID || ']';
            ELSIF SBPACKAGE_ID IS NULL THEN
                SBPACKAGE_ID    := TEMPCUDATA.COLUMN_VALUE;
                OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [SOLICITUD - ' || SBPACKAGE_ID || ']';
            ELSIF SBACTIVITY_ID IS NULL THEN
                SBACTIVITY_ID   := TEMPCUDATA.COLUMN_VALUE;
                OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [ACTIVIDAD - ' || SBACTIVITY_ID || ']';
            ELSIF SUBSCRIPTION_ID IS NULL THEN
                SUBSCRIPTION_ID := TEMPCUDATA.COLUMN_VALUE;
                OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [CONTRATO - ' || SUBSCRIPTION_ID || ']';
            END IF;

        END LOOP;

        NUOPERATING_UNIT_ID := -1;
        UT_TRACE.TRACE('SBPACKAGE_ID ' || SBPACKAGE_ID, 10);
        OPEN cuULTIMAORDEN(TO_NUMBER(SBPACKAGE_ID));
        FETCH cuULTIMAORDEN
            INTO TEMPCUULTIMAORDEN;

        IF cuULTIMAORDEN%FOUND THEN

            nuORDENANT := TEMPCUULTIMAORDEN.ORDEN;
            UT_TRACE.TRACE('nuORDENANT ' || nuORDENANT, 10);
            OPEN CUUNIDADOPERATIVA(nuORDENANT);
            FETCH CUUNIDADOPERATIVA
                INTO TEMPCUUNIDADOPERATIVA;

            IF CUUNIDADOPERATIVA%FOUND THEN

                NUOPERATING_UNIT_ID := TO_NUMBER(TEMPCUUNIDADOPERATIVA.OPERATING_UNIT_ID);
                UT_TRACE.TRACE('NUOPERATING_UNIT_ID ' || NUOPERATING_UNIT_ID, 10);
                BEGIN
                    os_assign_order(TO_NUMBER(SBORDER_ID),
                                    NUOPERATING_UNIT_ID,
                                    SYSDATE,
                                    SYSDATE,
                                    onuerrorcode,
                                    osberrormessage);
                    UT_TRACE.TRACE('os_assign_order - osberrormessage ' || osberrormessage, 10);

                    IF onuerrorcode = 0 THEN
                        /*
                        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                             TO_NUMBER(SBORDER_ID),
                                                             'LA ORDEN FUE ASIGNADA A LA UNIDAD OPERATIVA [' ||
                                                             NUOPERATING_UNIT_ID || ']');

                        */
                        --LDC_BOASIGAUTO.PRINTENTOSASIGNACION(TO_NUMBER(SBPACKAGE_ID),TO_NUMBER(SBORDER_ID));

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
                        --LDC_BOASIGAUTO.PRINTENTOSASIGNACION(TO_NUMBER(SBPACKAGE_ID), TO_NUMBER(SBORDER_ID));

                    END IF;

                EXCEPTION
                    WHEN OTHERS THEN
                        osberrormessage := 'INCONSISTENCIA TRIGGER TRGAFTERASIGAUTO [' ||
                                           DBMS_UTILITY.FORMAT_ERROR_STACK || '] - [' ||
                                           DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

                        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                             TO_NUMBER(SBORDER_ID),
                                                             'INCONVENIENTES AL INSERTAR LA ORDEN EN TEMPORAL OR_ORDER_1 CON LA UNIDAD DE TRABAJO [' ||
                                                             NUOPERATING_UNIT_ID || '] - MENSAJE [' ||
                                                             osberrormessage || ']');
                END;
                --*/
            ELSE
                NUOPERATING_UNIT_ID := -1;

                LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                     TO_NUMBER(SBORDER_ID),
                                                     'LA ORDEN ANTERIOR NO SE ENCUENTRA ASIGNADA [LDC_BOASIGAUTO.FSBUTASIGNADAOTANTERIOR - cuULTIMAORDEN].');

            END IF;
            CLOSE CUUNIDADOPERATIVA;
        ELSE
            NUOPERATING_UNIT_ID := -1;

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                 TO_NUMBER(SBORDER_ID),
                                                 'NO EXISTE UNA ORDEN ANTERIOR EN LA SOLICITUD [LDC_BOASIGAUTO.FSBUTASIGNADAOTANTERIOR - CUUNIDADOPERATIVA].');

        END IF;

        CLOSE cuULTIMAORDEN;

        UT_TRACE.TRACE('FIN LDC_BOASIGAUTO.FSBUTASIGNADAOTANTERIOR', 10);

        RETURN(NUOPERATING_UNIT_ID);

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            --ROLLBACK;
            ONUERRORCODE    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            OSBERRORMESSAGE := 'INCONVENIENTES AL ASIGNAR LA UNIDAD OPERATIVA OBTENIDA DE LA OT ANTERIOR DE LA SOLICITUD' ||
                               PKERRORS.FSBGETERRORMESSAGE;
            OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [' || DBMS_UTILITY.FORMAT_ERROR_STACK ||
                               ' - [' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                 TO_NUMBER(SBORDER_ID),
                                                 OSBERRORMESSAGE);

            RETURN(-1);

        WHEN OTHERS THEN
            --ROLLBACK;
            ONUERRORCODE    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            OSBERRORMESSAGE := 'INCONVENIENTES AL ASIGNAR LA UNIDAD OPERATIVA OBTENIDA DE LA OT ANTERIOR DE LA SOLICITUD' ||
                               PKERRORS.FSBGETERRORMESSAGE;
            OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [' || DBMS_UTILITY.FORMAT_ERROR_STACK ||
                               ' - [' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                 TO_NUMBER(SBORDER_ID),
                                                 OSBERRORMESSAGE);

            RETURN(-1);

    END FSBUTASIGOTANT;

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

    FUNCTION FSBASIGOTACTSECTOR(SBIN IN VARCHAR2) RETURN VARCHAR2 IS

        SBORDER_ID      VARCHAR2(4000) := NULL;
        SBPACKAGE_ID    VARCHAR2(4000) := NULL;
        SBACTIVITY_ID   VARCHAR2(4000) := NULL;
        SUBSCRIPTION_ID VARCHAR2(4000) := NULL;

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

        nuOperating_unit_id OR_ORDER.OPERATING_UNIT_ID%TYPE;
        nuOrder_activity_id or_order_activity.order_activity_id%TYPE;
        rcOrder             daor_order.styOR_order;

        RCORDERTOASSIGN     DAOR_ORDER.STYOR_ORDER;
        RCORDERTOASSIGNNULL DAOR_ORDER.STYOR_ORDER;

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

        UT_TRACE.TRACE('INICIO LDC_BOASIGAUTO.FSBASIGOTACTSECTOR', 10);

        FOR TEMPCUDATA IN CUDATA LOOP

            UT_TRACE.TRACE(TEMPCUDATA.COLUMN_VALUE, 10);

            IF SBORDER_ID IS NULL THEN
                SBORDER_ID      := TEMPCUDATA.COLUMN_VALUE;
                OSBERRORMESSAGE := '[ORDEN - ' || SBORDER_ID || ']';
            ELSIF SBPACKAGE_ID IS NULL THEN
                SBPACKAGE_ID    := TEMPCUDATA.COLUMN_VALUE;
                OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [SOLICITUD - ' || SBPACKAGE_ID || ']';
            ELSIF SBACTIVITY_ID IS NULL THEN
                SBACTIVITY_ID   := TEMPCUDATA.COLUMN_VALUE;
                OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [ACTIVIDAD - ' || SBACTIVITY_ID || ']';
            ELSIF SUBSCRIPTION_ID IS NULL THEN
                SUBSCRIPTION_ID := TEMPCUDATA.COLUMN_VALUE;
                OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [CONTRATO - ' || SUBSCRIPTION_ID || ']';
            END IF;

        END LOOP;

        nuOperating_unit_id := -1;

        UT_TRACE.TRACE('SBPACKAGE_ID ' || SBPACKAGE_ID, 10);
        UT_TRACE.TRACE('SBORDER_ID ' || SBORDER_ID, 10);
        UT_TRACE.TRACE('SBACTIVITY_ID ' || SBACTIVITY_ID, 10);
        UT_TRACE.TRACE('SUBSCRIPTION_ID ' || SUBSCRIPTION_ID, 10);

        OPEN cuObtSector(TO_NUMBER(SBPACKAGE_ID));
        FETCH cuObtSector
            INTO TEMPCUOBTSECTOR;

        IF cuObtSector%FOUND THEN

            UT_TRACE.TRACE('daor_order.frcGetRecord: ' || SBORDER_ID, 10);

            rcOrder := daor_order.frcGetRecord(TO_NUMBER(SBORDER_ID));

            IF rcOrder.operating_sector_Id = 1 THEN

                UT_TRACE.TRACE('Ingresa al if rcOrder.operating_sector_Id=1', 10);

                SELECT order_activity_id
                INTO   nuOrder_activity_id
                FROM   or_order_activity
                WHERE  order_id = rcOrder.order_id;

                BEGIN
                    UT_TRACE.TRACE('daor_order.updoperating_sector_id: ' || rcOrder.order_id || '-' ||
                                   TEMPCUOBTSECTOR.OPERATING_SECTOR_ID,
                                   10);
                    daor_order.updoperating_sector_id(rcOrder.order_id,
                                                      TEMPCUOBTSECTOR.OPERATING_SECTOR_ID,
                                                      0);

                    UT_TRACE.TRACE('Termina actualizacion sector: ', 10);
                    daor_order_activity.updoperating_sector_id(nuOrder_activity_id,
                                                               TEMPCUOBTSECTOR.OPERATING_SECTOR_ID,
                                                               0);

                    COMMIT;

                    rcOrder.operating_sector_Id := TEMPCUOBTSECTOR.OPERATING_SECTOR_ID;
                EXCEPTION
                    WHEN ex.CONTROLLED_ERROR THEN
                        RAISE ex.CONTROLLED_ERROR;
                    WHEN OTHERS THEN
                        Errors.setError;
                        RAISE ex.CONTROLLED_ERROR;
                END;
            END IF;

            --    close   cuObtSector;

            OPEN cuObtUnidOper(TEMPCUOBTSECTOR.OPERATING_SECTOR_ID, to_number(SBACTIVITY_ID));
            FETCH cuObtUnidOper
                INTO TEMPCUUNIDADOPERATIVA;

            IF cuObtUnidOper%FOUND THEN

                nuOperating_unit_id := TO_NUMBER(TEMPCUUNIDADOPERATIVA.OPERATING_UNIT_ID);

                UT_TRACE.TRACE('nuOperating_unit_id: ' || NUOPERATING_UNIT_ID, 10);

                BEGIN
                    os_assign_order(TO_NUMBER(SBORDER_ID),
                                    nuOperating_unit_id,
                                    SYSDATE,
                                    SYSDATE,
                                    onuerrorcode,
                                    osberrormessage);

                    UT_TRACE.TRACE('os_assign_order - osberrormessage ' || osberrormessage, 10);

                    IF onuerrorcode = 0 THEN
                        /*
                        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                             TO_NUMBER(SBORDER_ID),
                                                             'LA ORDEN FUE ASIGNADA A LA UNIDAD OPERATIVA [' ||
                                                             nuOperating_unit_id || ']');
                        */
                        --LDC_BOASIGAUTO.PRINTENTOSASIGNACION(TO_NUMBER(SBPACKAGE_ID), TO_NUMBER(SBORDER_ID));

                        UPDATE LDC_ORDER
                        SET    ASIGNADO = 'S'
                        WHERE  NVL(PACKAGE_ID, 0) = NVL(TO_NUMBER(SBPACKAGE_ID), 0)
                        AND    ORDER_ID = TO_NUMBER(SBORDER_ID);

                    ELSE
                        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                             TO_NUMBER(SBORDER_ID),
                                                             'LA ORDEN NO FUE ASIGNADA A LA UNIDAD OPERATIVA [' ||
                                                             nuOperating_unit_id ||
                                                             '] - MENSAJE DE ERROR PROVENIENTE DE os_assign_order --> ' ||
                                                             osberrormessage);
                        --LDC_BOASIGAUTO.PRINTENTOSASIGNACION(TO_NUMBER(SBPACKAGE_ID), TO_NUMBER(SBORDER_ID));

                    END IF;

                EXCEPTION
                    WHEN OTHERS THEN
                        osberrormessage := 'INCONSISTENCIA TRIGGER TRGAFTERASIGAUTO [' ||
                                           DBMS_UTILITY.FORMAT_ERROR_STACK || '] - [' ||
                                           DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

                        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                             TO_NUMBER(SBORDER_ID),
                                                             'INCONVENIENTES AL INSERTAR LA ORDEN EN TEMPORAL OR_ORDER_1 CON LA UNIDAD DE TRABAJO [' ||
                                                             nuOperating_unit_id || '] - MENSAJE [' ||
                                                             osberrormessage || ']');
                END;
                --*/
            ELSE
                nuOperating_unit_id := -1;

                LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                     TO_NUMBER(SBORDER_ID),
                                                     'No se encontro Unidad Operativa para asignar la orden [LDC_BOASIGAUTO.FSBASIGOTACTSECTOR - cuObtUnidOper].');

            END IF;

            CLOSE cuObtUnidOper;

        ELSE
            nuOperating_unit_id := -1;

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                 TO_NUMBER(SBORDER_ID),
                                                 'No se encontro S.O. en la dir del cliente o el cliente no tiene direccion[LDC_BOASIGAUTO.FSBASIGOTACTSECTOR - CUUNIDADOPERATIVA].');

        END IF;
        CLOSE cuObtSector;

        UT_TRACE.TRACE('FIN LDC_BOASIGAUTO.FSBASIGOTACTSECTOR', 10);

        RETURN(nuOperating_unit_id);

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            --ROLLBACK;
            ONUERRORCODE    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            OSBERRORMESSAGE := 'Inconvenientes en la asignacion de la Unidad Operativa, actualizando el Sector Operativo' ||
                               PKERRORS.FSBGETERRORMESSAGE;
            OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [' || DBMS_UTILITY.FORMAT_ERROR_STACK ||
                               ' - [' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                 TO_NUMBER(SBORDER_ID),
                                                 OSBERRORMESSAGE);

            RETURN(-1);

        WHEN OTHERS THEN
            --ROLLBACK;
            ONUERRORCODE    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            OSBERRORMESSAGE := 'Inconvenientes en la asignacion de la Unidad Operativa, actualizando el Sector Operativo' ||
                               PKERRORS.FSBGETERRORMESSAGE;
            OSBERRORMESSAGE := OSBERRORMESSAGE || ' - [' || DBMS_UTILITY.FORMAT_ERROR_STACK ||
                               ' - [' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                 TO_NUMBER(SBORDER_ID),
                                                 OSBERRORMESSAGE);

            RETURN(-1);

    END FSBASIGOTACTSECTOR;

    --fin nuevos servicio NC4413

    /*****************************************************************
    PROPIEDAD INTELECTUAL DE PETI (C).

    UNIDAD         : fsbASignaRP
    DESCRIPCION    : Este servicio asigna automaticamente la unidad operativa a las ordenes
                     de Revisi?n periodica partiendo desde la asignacion de la OT 10444 del
                     tramite "100237 - Solic. visita identificacion certificado" que se genera
                     desde el OTREV

    AUTOR          : Oscar Parra - Optima
    FECHA          : 12/02/2015

    PARAMETROS              DESCRIPCION
    ============         ===================
    ISBIN               VALORES EN UNA CADENA

    FECHA             AUTOR                   MODIFICACION
    =========       =========                 ====================
    12/02/2015     oparra.Aranda 5753         1.Creacion
    24/05/2016     Oscar Ospino P. (ludycom)  2.(GDC CA200-304)
                                              Se agrega una validaci?n para que las ordenes con
                                              tipos de trabajos 10446 que se encuentren en una
                                              solicitud con tipo de trabajo 100101 y provenga de
                                              una orden con tipo de trabajo 10723, se asigne a la
                                              misma unidad operativa de la ?ltima orden legalizada
                                              con tipo de trabajo 10444 y que se encuentra en una
                                              solicitud con tipo de trabajo 100237
    ******************************************************************/
    FUNCTION fsbAsignaRP(SBIN IN VARCHAR2) RETURN VARCHAR2 IS

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

        --CON ESTA ORDEN SE SABE EN EL CICLO QUE DATO VA
        --EN SECUENCIA PARA SABER CUAL DE LOS DATOS UTILIZAR
        ----------------------------------------------------
        nuTasktype      NUMBER;
        ONUERRORCODE    NUMBER;
        OSBERRORMESSAGE VARCHAR2(4000);

        --SEPARA LOS DATOS OBTENIDOS DE LA CADENA DE ENTRADA
        --CON EL SEPARADOR |
        CURSOR CUDATA IS
            SELECT COLUMN_VALUE FROM TABLE(Ldc_Boutilities.SPLITSTRINGS(SBIN, '|'));
        ---FIN CURSOR DATA

        --CURSOR PARA OBTENER EL VALOR DE LA UNIDAD OPERTAIVA
        --DE LA ORDEN ASOCIADA A LA SOLICUTUD 100237 TT 10444

        CURSOR CUOR_ORDER_TT10444(INUPACKAGE_ID MO_PACKAGES.PACKAGE_ID%TYPE) IS
            SELECT OPERATING_UNIT_ID
            FROM   (SELECT DISTINCT P.PACKAGE_ID        PACKAGE_ID,
                                    O.OPERATING_UNIT_ID OPERATING_UNIT_ID
                    FROM   OPEN.MO_PACKAGES       P,
                           OPEN.MO_MOTIVE         M,
                           OPEN.OR_ORDER_ACTIVITY OA,
                           OPEN.OR_ORDER          O
                    WHERE  M.PACKAGE_ID = P.PACKAGE_ID
                    AND    OA.PACKAGE_ID = P.PACKAGE_ID
                    AND    OA.ORDER_ID = O.ORDER_ID
                    AND    P.PACKAGE_TYPE_ID = 100237 -- Solic. visita identificacion certificado
                    AND    O.TASK_TYPE_ID = 10444
                    AND    O.ORDER_STATUS_ID IN (5, 8) -- ASIGNADA O LEGALIZADA
                          --AND OA.ACTIVITY_ID = 4295653       -- Act. Visita de identificacion de resultado
                    AND    P.REQUEST_DATE <= Damo_Packages.FDTGETREQUEST_DATE(INUPACKAGE_ID)
                    AND    M.PRODUCT_ID = (SELECT DISTINCT M.PRODUCT_ID
                                           FROM   OPEN.MO_PACKAGES P,
                                                  OPEN.MO_MOTIVE   M
                                           WHERE  P.PACKAGE_ID = M.PACKAGE_ID
                                           AND    P.PACKAGE_ID = INUPACKAGE_ID
                                           AND    ROWNUM = 1)
                    ORDER  BY P.PACKAGE_ID DESC)
            WHERE  ROWNUM = 1;

        --CURSOR PARA OBTENER EL VALOR DE LA UNIDAD OPERTAIVA
        --DE LA ORDEN ASOCIADA A LA SOLICUTUD 265/266 TT 12161

        CURSOR CUOR_ORDER_TT12161(INUPACKAGE_ID MO_PACKAGES.PACKAGE_ID%TYPE) IS
            SELECT OPERATING_UNIT_ID
            FROM   (SELECT DISTINCT p.PACKAGE_ID        PACKAGE_ID,
                                    O.OPERATING_UNIT_ID OPERATING_UNIT_ID
                    FROM   OPEN.MO_PACKAGES       P,
                           OPEN.MO_MOTIVE         M,
                           OPEN.OR_ORDER_ACTIVITY OA,
                           OPEN.OR_ORDER          O
                    WHERE  M.PACKAGE_ID = P.PACKAGE_ID
                    AND    OA.PACKAGE_ID = P.PACKAGE_ID
                    AND    OA.ORDER_ID = O.ORDER_ID
                    AND    P.PACKAGE_TYPE_ID IN (265, 266, 100014, 100153, 100270) -- Solic. Revision periodica Interna/Externa
                    AND    O.TASK_TYPE_ID = 12161
                    AND    O.ORDER_STATUS_ID IN (5, 8) -- ASIGNADA O LEGALIZADA
                          --AND OA.ACTIVITY_ID = 4295653       -- Act.
                    AND    P.REQUEST_DATE <= Damo_Packages.FDTGETREQUEST_DATE(INUPACKAGE_ID)
                    AND    M.PRODUCT_ID = (SELECT DISTINCT M.PRODUCT_ID
                                           FROM   OPEN.MO_PACKAGES P,
                                                  OPEN.MO_MOTIVE   M
                                           WHERE  P.PACKAGE_ID = M.PACKAGE_ID
                                           AND    P.PACKAGE_ID = INUPACKAGE_ID
                                           AND    ROWNUM = 1)
                    ORDER  BY p.PACKAGE_ID DESC)
            WHERE  ROWNUM = 1;

        /*****************************************************************
        PROPIEDAD INTELECTUAL DE GASES DEL CARIBE (C).
        FECHA          AUTOR                      MODIFICACION
        24/05/2016     Oscar Ospino P. (ludycom)  1.(GDC CA200-304) Se agrega validacion para ordenes 10446
        */

        sbEntrega VARCHAR2(100) := 'OSS_RP_OOP_200304_1';

        CURSOR cuOTPADRE(nuOrderId or_order.order_id%TYPE) IS --Cargar el tipo de Orden Padre asociada
            SELECT oa.order_id     OrdenPadre,
                   oa.task_type_id TipoOTPadre
            FROM   open.or_order_activity oa
            WHERE  oa.order_activity_id IN (SELECT DISTINCT oa.origin_activity_id
                                            FROM   open.or_order_activity oa,
                                                   open.or_order          o
                                            WHERE  oa.order_id = o.order_id
                                            AND    oa.order_id = nuOrderId);
        CURSOR cuTIPOSOL(nuPackage_Id open.mo_packages.package_id%TYPE) IS --Tipo de solicitud de la Orden
            SELECT mp.package_type_id TipoSolicitud
            FROM   open.mo_packages mp
            WHERE  mp.package_id = nuPackage_Id;

        RCcuOTPADRE cuOTPADRE%ROWTYPE;
        RCcuTIPOSOL cuTIPOSOL%ROWTYPE;
        /*****************************************************************/

        TEMPCUOR_ORDER CUOR_ORDER_TT10444%ROWTYPE;

        NUOPERATING_UNIT_ID OR_ORDER.OPERATING_UNIT_ID%TYPE;
        SBOPERATING_UNIT_ID VARCHAR2(4000);

        RCORDERTOASSIGN     Daor_Order.STYOR_ORDER;
        RCORDERTOASSIGNNULL Daor_Order.STYOR_ORDER;

        SBDATAIN    VARCHAR2(4000);
        SBTRIGGER   VARCHAR2(4000);
        SBCATEGORIA VARCHAR2(4000);
        SBCARRUSEL  VARCHAR2(4000) := NULL;

        NURESIDENIAL NUMBER := Dald_Parameter.fnuGetNumeric_Value('RESIDEN_CATEGORY', NULL);
        NUCOMERCIAL  NUMBER := Dald_Parameter.fnuGetNumeric_Value('COMMERCIAL_CATEGORY', NULL);

    BEGIN

        Ut_Trace.TRACE('INICIO LDC_BOASIGAUTO.fsbAsignaRP', 10);

        --OBTENER DATOS DE LA CADENA OBTENIDA DEL SERVICIO DE ASIGNACION
        FOR TEMPCUDATA IN CUDATA LOOP

            Ut_Trace.TRACE(TEMPCUDATA.COLUMN_VALUE, 10);

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
            ELSIF SBTRIGGER IS NULL THEN
                SBTRIGGER       := TEMPCUDATA.COLUMN_VALUE;
                OSBERRORMESSAGE := OSBERRORMESSAGE || ' - ' || SBTRIGGER;
            ELSIF SBCATEGORIA IS NULL THEN
                SBCATEGORIA     := TEMPCUDATA.COLUMN_VALUE;
                OSBERRORMESSAGE := OSBERRORMESSAGE || ' - ' || SBCATEGORIA;
            END IF;

        END LOOP;

        -- Obtiene el TT de la orden
        IF SBORDER_ID IS NOT NULL THEN
            nuTasktype := Daor_Order.fnugettask_type_id(to_number(SBORDER_ID));
        END IF;

        -- Se obtienen la UT segun el TT

        -- Si el TT de la orden 12161
        IF (nuTasktype = 12161) THEN
            OPEN CUOR_ORDER_TT10444(TO_NUMBER(SBPACKAGE_ID));
            FETCH CUOR_ORDER_TT10444
                INTO TEMPCUOR_ORDER;
            CLOSE CUOR_ORDER_TT10444;

        ELSIF (nuTasktype = 10259) THEN
            OPEN CUOR_ORDER_TT12161(TO_NUMBER(SBPACKAGE_ID));
            FETCH CUOR_ORDER_TT12161
                INTO TEMPCUOR_ORDER;
            CLOSE CUOR_ORDER_TT12161;

        ELSIF (nuTasktype = 10449) THEN
            OPEN CUOR_ORDER_TT10444(TO_NUMBER(SBPACKAGE_ID));
            FETCH CUOR_ORDER_TT10444
                INTO TEMPCUOR_ORDER;
            CLOSE CUOR_ORDER_TT10444;

        ELSIF (nuTasktype = 10445) THEN
            OPEN CUOR_ORDER_TT12161(TO_NUMBER(SBPACKAGE_ID));
            FETCH CUOR_ORDER_TT12161
                INTO TEMPCUOR_ORDER;
            CLOSE CUOR_ORDER_TT12161;

        ELSIF (nuTasktype = 12164) THEN
            OPEN CUOR_ORDER_TT12161(TO_NUMBER(SBPACKAGE_ID));
            FETCH CUOR_ORDER_TT12161
                INTO TEMPCUOR_ORDER;
            CLOSE CUOR_ORDER_TT12161;

        ELSIF (nuTasktype = 10450) THEN
            OPEN CUOR_ORDER_TT10444(TO_NUMBER(SBPACKAGE_ID));
            FETCH CUOR_ORDER_TT10444
                INTO TEMPCUOR_ORDER;
            CLOSE CUOR_ORDER_TT10444;

        ELSIF (nuTasktype = 12457) THEN
            OPEN CUOR_ORDER_TT10444(TO_NUMBER(SBPACKAGE_ID));
            FETCH CUOR_ORDER_TT10444
                INTO TEMPCUOR_ORDER;
            CLOSE CUOR_ORDER_TT10444;
            /*****************************************************************
            PROPIEDAD INTELECTUAL DE GASES DEL CARIBE (C).
            FECHA          AUTOR                      MODIFICACION
            24/05/2016     Oscar Ospino P. (ludycom)  1.(GDC CA200-304) Se agrega validacion para ordenes 10446
            */

        ELSIF (nuTasktype = 10446) THEN
            -- 10446-Visita Validaci?n de certificaci?n trabajos

            Ut_Trace.TRACE('LDC_BOASIGAUTO.fsbAsignaRP | Inicio Validacion TT10446', 10);

            IF fblaplicaentrega('OSS_RP_OOP_200304_1') = TRUE THEN
                --obtengo el tipo de solicitud de la Orden actual
                OPEN cuTIPOSOL(TO_NUMBER(SBPACKAGE_ID));
                FETCH cuTIPOSOL
                    INTO RCcuTIPOSOL;
                CLOSE cuTIPOSOL;

                --obtengo el TT de la Orden Padre
                OPEN cuOTPADRE(TO_NUMBER(SBORDER_ID));
                FETCH cuOTPADRE
                    INTO RCcuOTPADRE;
                CLOSE cuOTPADRE;

                --Si la OT Padre es de tipo 10723, se asigna la UO de la ultima OT legalizada con TT 10444
                --en una solicitud 100237
                IF RCcuTIPOSOL.Tiposolicitud = 100101 AND RCcuOTPADRE.Tipootpadre = 10723 THEN
                    -- Se carga la UO en TEMPCUOR_ORDER.OPERATING_UNIT_ID para que luego
                    -- se asigne a NUOPERATING_UNIT_ID
                    OPEN CUOR_ORDER_TT10444(TO_NUMBER(SBPACKAGE_ID));
                    FETCH CUOR_ORDER_TT10444
                        INTO TEMPCUOR_ORDER;
                    CLOSE CUOR_ORDER_TT10444;

                END IF;
            END IF;
            Ut_Trace.TRACE('LDC_BOASIGAUTO.fsbAsignaRP | Fin Validacion TT10446', 10);

            /* Fin 1.(GDC CA200-304)******************************************/
        END IF;

        IF TEMPCUOR_ORDER.OPERATING_UNIT_ID IS NOT NULL THEN
            NUOPERATING_UNIT_ID := TEMPCUOR_ORDER.OPERATING_UNIT_ID;

            -- inicio Asignar orden
            BEGIN

                Os_Assign_Order(TO_NUMBER(SBORDER_ID),
                                NUOPERATING_UNIT_ID,
                                SYSDATE,
                                SYSDATE,
                                onuerrorcode,
                                osberrormessage);

                IF onuerrorcode = 0 THEN
                    /*
                    Ldc_Boasigauto.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                         TO_NUMBER(SBORDER_ID),
                                                         'LA ORDEN FUE ASIGNADA A LA UNIDAD OPERATIVA [' ||
                                                         NUOPERATING_UNIT_ID || ']');
                    */
                    --Ldc_Boasigauto.PRINTENTOSASIGNACION(TO_NUMBER(SBPACKAGE_ID), TO_NUMBER(SBORDER_ID));

                    --dbms_output.put_line('Registrando intentos de legalizacion...' || chr(13));

                    UPDATE LDC_ORDER
                    SET    ASIGNADO = 'S'
                    WHERE  NVL(PACKAGE_ID, 0) = NVL(TO_NUMBER(SBPACKAGE_ID), 0)
                    AND    ORDER_ID = TO_NUMBER(SBORDER_ID);

                    --dbms_output.put_line('Registrando Orden en LDC_ORDER SBPACKAGE_ID en LDC_ORDER Registrando intentos de legalizacion...' ||chr(13));

                ELSE
                    OSBERRORMESSAGE := 'LA ORDEN DE TRABAJO NO FUE ASIGNADA A LA UNIDAD OPERATIVA [' ||
                                       NUOPERATING_UNIT_ID ||
                                       '] - MENSAJE DE ERROR PROVENIENTE DE os_assign_order --> ' ||
                                       osberrormessage;
                    dbms_output.put_line(OSBERRORMESSAGE);
                    Ldc_Boasigauto.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                         TO_NUMBER(SBORDER_ID),
                                                         osberrormessage);
                    --Ldc_Boasigauto.PRINTENTOSASIGNACION(TO_NUMBER(SBPACKAGE_ID), TO_NUMBER(SBORDER_ID));

                END IF;

            EXCEPTION
                WHEN OTHERS THEN
                    SBDATAIN := 'INCONSISTENCIA EN SERVICIO FSBREVISIONPERIODICA [' ||
                                DBMS_UTILITY.FORMAT_ERROR_STACK || '] - [' ||
                                DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

                    Ldc_Boasigauto.PRREGSITROASIGAUTOLOG(NULL,
                                                         TO_NUMBER(SBORDER_ID),
                                                         'EL SERVICIO os_assign_order NO PUDO ASIGNAR LA UNIDAD OPERATIVA A LA ORDEN [' ||
                                                         SBDATAIN || ']');
                    dbms_output.put_line('EL SERVICIO os_assign_order NO PUDO ASIGNAR LA UNIDAD OPERATIVA A LA ORDEN [' ||
                                         sbdatain || ']');
            END;
            -- Fin Asignar orden

        ELSE
            -- sino obtuvo la UT
            NUOPERATING_UNIT_ID := '-1';
        END IF;

        Ut_Trace.TRACE('FIN LDC_BOASIGAUTO.fsbAsignaRP', 10);

        RETURN(NUOPERATING_UNIT_ID);

    END fsbAsignaRP;

    -----ARANDA 144208
    /*****************************************************************
    PROPIEDAD INTELECTUAL DE PETI (C).

    UNIDAD         : FSBORDENREPARACION
    DESCRIPCION    : PROCESO QUE PERMITIRA OBTENER
                     LA UNIDAD OPERATIVA DE LA OT DE TIPO DE TRABAJO VISITA
                     IDENTIFICACION DE REPARACIONES.
    AUTOR          : JORGE VALIENTE
    FECHA          : 12/03/2015

    PARAMETROS              DESCRIPCION
    ============         ===================
     ISBIN               VALORES EN UNA CADENA

    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    ******************************************************************/
    FUNCTION FSBORDENREPARACION(SBIN IN VARCHAR2) RETURN VARCHAR2 IS

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

        --CON ESTA ORDEN SE SABE EN EL CICLO QUE DATO VA
        --EN SECUENCIA PARA SABER CUAL DE LOS DATOS UTILIZAR
        ----------------------------------------------------

        ONUERRORCODE    NUMBER;
        OSBERRORMESSAGE VARCHAR2(4000);

        --SEPARA LOS DATOS OBTENIDOS DE LA CADENA DE ENTRADA
        --CON EL SEPARADOR |
        CURSOR CUDATA IS
            SELECT COLUMN_VALUE FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(SBIN, '|'));
        ---FIN CURSOR DATA

        --CURSOR PARA OBTENER EL VALOR DE LA UNIDAD OPERTAIVA
        --DE LA ORDEN ASOCIADA A OT PADRE DE REPARACION
        CURSOR CUOR_ORDER(NUPACKAGE_ID MO_PACKAGES.PACKAGE_ID%TYPE) IS
            SELECT DISTINCT O.OPERATING_UNIT_ID,
                            o.task_type_id,
                            oa.PACKAGE_ID,
                            O.ORDER_STATUS_ID,
                            P.PACKAGE_TYPE_ID,
                            o.created_date
            FROM   OPEN.MO_PACKAGES       P,
                   OPEN.OR_ORDER_ACTIVITY OA,
                   OPEN.OR_ORDER          O,
                   OPEN.OR_TASK_TYPE      TT
            WHERE  P.PACKAGE_ID = NUPACKAGE_ID
            AND    OA.PACKAGE_ID = P.PACKAGE_ID
            AND    OA.ORDER_ID = O.ORDER_ID
            AND    TT.TASK_TYPE_ID = O.TASK_TYPE_ID
            AND    P.PACKAGE_TYPE_ID IN
                   (SELECT to_number(column_value)
                     FROM   TABLE(OPEN.ldc_boutilities.splitstrings( --'265,266'
                                                                    OPEN.DALD_PARAMETER.fsbGetValue_Chain('COD_SOL_OT_REP',
                                                                                                          NULL),
                                                                    ','))) --CODIGO DE SOLICITUD
            AND    o.task_type_id IN
                   (SELECT to_number(column_value)
                     FROM   TABLE(OPEN.ldc_boutilities.splitstrings( --'10445'
                                                                    OPEN.DALD_PARAMETER.fsbGetValue_Chain('TT_VIS_REP',
                                                                                                          NULL),
                                                                    ','))) -- TIPO DE TRABAJO VISITA IDENTIFICACION DE REPARACIONES
            AND    O.ORDER_STATUS_ID IN
                   (SELECT to_number(column_value)
                     FROM   TABLE(OPEN.ldc_boutilities.splitstrings( --'8'
                                                                    OPEN.DALD_PARAMETER.fsbGetValue_Chain('EST_OT_TT_VIS_REP',
                                                                                                          NULL),
                                                                    ','))) --        ESTADO DE LA ORDEN
            AND    OA.ACTIVITY_ID IN
                   (SELECT to_number(column_value)
                     FROM   TABLE(OPEN.ldc_boutilities.splitstrings( --'4295654'
                                                                    OPEN.DALD_PARAMETER.fsbGetValue_Chain('ACT_VIS_REP',
                                                                                                          NULL),
                                                                    ','))) --   ACTIVIDAD VISITA IDENTIFICACION DE REPARACIONES
            AND    O.Causal_Id IN
                   (SELECT to_number(column_value)
                     FROM   TABLE(OPEN.ldc_boutilities.splitstrings( --'3295'
                                                                    OPEN.DALD_PARAMETER.fsbGetValue_Chain('CAU_LEG_TT_VIS_REP',
                                                                                                          NULL),
                                                                    ','))) --        ESTADO DE LA ORDEN
            --AND ROWNUM = 1
            ORDER  BY o.created_date DESC;

        TEMPCUOR_ORDER CUOR_ORDER%ROWTYPE;
        --FIN CURSOR CUDAOR_ORDER

        NUOPERATING_UNIT_ID OR_ORDER.OPERATING_UNIT_ID%TYPE;
        SBOPERATING_UNIT_ID VARCHAR2(4000);

        SBDATAIN VARCHAR2(4000);

        SBTRIGGER VARCHAR2(4000);

        SBCATEGORIA VARCHAR2(4000);

    BEGIN

        UT_TRACE.TRACE('INICIO LDC_BOASIGAUTO.FSBORDENREPARACION', 10);

        --OBTENER DATOS DE LA CADENA OBTENIDA DEL SERVICIO DE ASIGNACION
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
            ELSIF SBTRIGGER IS NULL THEN
                SBTRIGGER       := TEMPCUDATA.COLUMN_VALUE;
                OSBERRORMESSAGE := OSBERRORMESSAGE || ' - ' || SBTRIGGER;
            ELSIF SBCATEGORIA IS NULL THEN
                SBCATEGORIA     := TEMPCUDATA.COLUMN_VALUE;
                OSBERRORMESSAGE := OSBERRORMESSAGE || ' - ' || SBCATEGORIA;
            END IF;

        END LOOP;

        /*
        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                             TO_NUMBER(SBORDER_ID),
                                             'INICIO LDC_BOASIGAUTO.FSBORDENREPARACION');

        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                             TO_NUMBER(SBORDER_ID),
                                             'LDC_BOASIGAUTO.FSBORDENREPARACION, INGRESA EL DATO SBIN[' || SBIN || ']');
        */
        NUOPERATING_UNIT_ID := NULL;

        /*
        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                             TO_NUMBER(SBORDER_ID),
                                             'LDC_BOASIGAUTO.FSBORDENREPARACION, INGRESA AL CURSOR CUDEFECTORP');
        */
        OPEN CUOR_ORDER(TO_NUMBER(SBPACKAGE_ID));
        FETCH CUOR_ORDER
            INTO TEMPCUOR_ORDER;
        IF CUOR_ORDER%FOUND THEN
            NUOPERATING_UNIT_ID := TEMPCUOR_ORDER.OPERATING_UNIT_ID;

            BEGIN

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

            EXCEPTION
                WHEN OTHERS THEN
                    SBDATAIN := 'INCONSISTENCIA EN SERVICIO FSBORDENREPARACION [' ||
                                DBMS_UTILITY.FORMAT_ERROR_STACK || '] - [' ||
                                DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || ']';

                    LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(NULL,
                                                         TO_NUMBER(SBORDER_ID),
                                                         'EL SERVICIO os_assign_order NO PUDO ASIGNAR LA UNIDAD OPERATIVA A LA ORDEN [' ||
                                                         SBDATAIN || ']');
            END;

        ELSE
            NUOPERATING_UNIT_ID := -1;
        END IF;

        UT_TRACE.TRACE('FIN LDC_BOASIGAUTO.FSBORDENREPARACION', 10);

        RETURN(NUOPERATING_UNIT_ID);

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            --ROLLBACK;
            ONUERRORCODE    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            OSBERRORMESSAGE := 'INCONVENIENTES AL ASIGNAR LA UNIDAD OPERTAIVA DE SOLICUTD INMEDIATA A LAS ORDENES GENERADAS POR DEFECTO DE REPARACION PERIODICA' ||
                               PKERRORS.FSBGETERRORMESSAGE;

            OSBERRORMESSAGE := OSBERRORMESSAGE || ' - ' || DBMS_UTILITY.FORMAT_ERROR_STACK || ' - ' ||
                               DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                 TO_NUMBER(SBORDER_ID),
                                                 OSBERRORMESSAGE);

            --RETURN(NULL);
            RETURN(-1);

        WHEN OTHERS THEN
            --ROLLBACK;
            ONUERRORCODE    := LD_BOCONSTANS.CNUGENERIC_ERROR;
            OSBERRORMESSAGE := 'INCONVENIENTES AL ASIGNAR LA UNIDAD OPERTAIVA DE SOLICUTD INMEDIATA A LAS ORDENES GENERADAS POR DEFECTO DE REPARACION PERIODICA' ||
                               PKERRORS.FSBGETERRORMESSAGE;
            OSBERRORMESSAGE := OSBERRORMESSAGE || ' - ' || DBMS_UTILITY.FORMAT_ERROR_STACK || ' - ' ||
                               DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TO_NUMBER(SBPACKAGE_ID),
                                                 TO_NUMBER(SBORDER_ID),
                                                 OSBERRORMESSAGE);

            --RETURN(NULL);
            RETURN(-1);

    END FSBORDENREPARACION;
    -----FIN ARANDA 144208

    ---Inicio CASO 200-2067
    /*****************************************************************
    PROPIEDAD INTELECTUAL DE PETI (C).

    UNIDAD         : PRASIGNACIONORIGEN
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
    17-08-2016      Sandra Mu?oz        CA200-398. Se modifica agreg?ndole un par?metro para la orden
                                        de trabajo que se desea asignar autom?ticamente, este
                                        par?metro se debe definir por defecto en null para que no
                                        afecte las funcionalidades ya existentes.
                                        Al cursor CULDC_ORDER se le agrega la validaci?n que filtre
                                        por n?mero de orden si este par?metro viene lleno
    ******************************************************************/
    PROCEDURE PRASIGNACIONORIGEN(inuOrden or_order.order_id%TYPE DEFAULT NULL) IS

        nuEstadoAsignado ld_parameter.numeric_value%TYPE;

        --CURSOR PARA OBTENER TODAS LAS ORDENES QUE NO HAN SIDO
        --ASIGNADAS A UAN UNIDAD OPERATIVA EN LDC_ORDER
        CURSOR CULDC_ORDER(inuCantidadIntentos NUMBER) IS
            SELECT order_id,
                   package_id,
                   asignacion,
                   asignado
            FROM   OPEN.LDC_ORDER LO
            WHERE  LO.ASIGNADO = 'N'
            AND    nvl(asignacion, 0) <= inuCantidadIntentos
                  -- CA200-398. Se agrega esta secci?n para poder reasignar individualmente una orden
            AND    inuOrden IS NULL

            UNION
            SELECT order_id,
                   NULL package_id,
                   NULL asignacion,
                   CASE order_status_id
                       WHEN nuEstadoAsignado THEN
                        'S'
                       ELSE
                        'N'
                   END asignado
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
                   OOA.SUBSCRIPTION_ID
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
            ORDER  BY dbms_random.value;
        --*/

        TEMPCUUOBYSOL CUUOBYSOL%ROWTYPE;

        --CURSOR PARA VALIDAR LA CATEGORIA A LA QUE
        --PERTENECE EL SUSCRIPTOR
        CURSOR CUCATEGORIA(NUPRODUCT_ID OR_ORDER_ACTIVITY.PRODUCT_ID%TYPE,
                           NUADDRESS_ID OR_ORDER_ACTIVITY.ADDRESS_ID%TYPE) IS
            SELECT PP.CATEGORY_ID
            FROM   PR_PRODUCT PP
            WHERE  PP.PRODUCT_ID = DECODE(NUPRODUCT_ID,
                                          NULL,
                                          (SELECT PP.PRODUCT_ID
                                           FROM   PR_PRODUCT PP
                                           WHERE  PP.ADDRESS_ID = NUADDRESS_ID
                                           AND    ROWNUM = 1),
                                          NUPRODUCT_ID)
            AND    PP.PRODUCT_TYPE_ID IN
                   (SELECT TO_NUMBER(column_value)
                     FROM   TABLE(ldc_boutilities.splitstrings(DALD_PARAMETER.fsbGetValue_Chain('COD_TIPO_SOL_ASIG',
                                                                                                NULL),
                                                               ',')))
            AND    ROWNUM = 1;

        TEMPCUCATEGORIA CUCATEGORIA%ROWTYPE;

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
            FROM   open.pr_product p
            WHERE  p.product_id = NUPRODUCT_ID
            AND    p.product_type_id = open.dald_parameter.fnuGetNumeric_Value('COD_PRO_GEN', NULL);

        RTCUTIPOPRODUCTO CUTIPOPRODUCTO%ROWTYPE;

        --CURSOR PARA OBTENER LA CATEGROIA DE LA DIRECCION DE LA ORDEN
        --SI EL PRODUCTO ES GENERICO
        CURSOR CUSEGMENTOCATEGORIA(NUADDRESS_ID OR_ORDER_ACTIVITY.ADDRESS_ID%TYPE) IS
            SELECT NVL(S.CATEGORY_, 0) CATEGORIA,
                   S.SUBCATEGORY_ SUBCATEGORIA
            FROM   open.ab_address  aa,
                   OPEN.AB_SEGMENTS S
            WHERE  aa.address_id = NUADDRESS_ID
            AND    AA.SEGMENT_ID = S.SEGMENTS_ID;

        RTCUSEGMENTOCATEGORIA CUSEGMENTOCATEGORIA%ROWTYPE;
        ---Fin NC 2493 desarrollo
        --TICKET 2001377 LJLB -- se consulta sector operatvo de ladireccion del producto
        CURSOR cuSectorOperativo(NUADDRESS_ID OR_ORDER_ACTIVITY.ADDRESS_ID%TYPE) IS
        SELECT OPERATING_SECTOR_ID
        FROM open.ab_address  aa,
             OPEN.AB_SEGMENTS S
        WHERE aa.address_id = NUADDRESS_ID
          AND AA.SEGMENT_ID = S.SEGMENTS_ID ;

       sbFlag VARCHAR2(1) := 'N'; --TICKET 2001377 LJLB -- se almacena flag para activar desarrollo
       nuSectorOperativo  AB_SEGMENTS.OPERATING_SECTOR_ID%TYPE;  --TICKET 2001377 LJLB -- se almacena sector operativo
       sbError    VARCHAR2(4000); --TICKET 2001377 LJLB -- se almacena error del porceso de asigancion
       nuContrato  GE_CONTRATO.ID_CONTRATO%TYPE; --TICKET 2001377 LJLB --  se almacena contrato

        --CURSOR IDENTIFICAR LAS UNIDADES OPERATIVAS
        --DESACTIVADAS EN LDC_CARUNIOPE
        CURSOR CULDC_CARUNIOPE(INUOPERATING_SECTOR_ID OR_ORDER.OPERATING_SECTOR_ID%TYPE) IS
            SELECT *
            FROM   OPEN.LDC_CARUNIOPE
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
    BEGIN

        --TICKET 200-1377 LJLB -- se consulta si aplica la entrega en la gasera
        IF fblaplicaentrega('BSS_FACT_LJLB_2001377_1') THEN
           sbFlag := 'S';

           PRRESEINTEOR; --TICKET 200-1377 LJLB -- se setean los intentos de las ordenes que cumplan con el parametro
        END IF;
        -- CA200-398. Buscar el estado "Asignado" del sistema
        nuEstadoAsignado := dald_parameter.fnuGetNumeric_Value('COD_ESTADO_ASIGNADA_OT');

        --/*
        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(-1,
                                             -1,
                                             'LDC_BOASIGAUTO.PRASIGNACIONORIGEN, ANTES DE INGRESAR LA CURSOR CULDC_ORDER CON LA VARAIBLE nuCantidadIntentos[' ||
                                             nuCantidadIntentos || ']');

        --*/
        --CICLO PARA RECORRER LAS ORDENES AUN NO ASIGNADAS
        FOR TEMPCULDC_ORDER IN CULDC_ORDER(nuCantidadIntentos) LOOP

            NUSOLICITUD := TEMPCULDC_ORDER.PACKAGE_ID;
            NUORDEN     := TEMPCULDC_ORDER.ORDER_ID;

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                 TEMPCULDC_ORDER.ORDER_ID,
                                                 'PETI PASO CURSOR CULDC_ORDER');

            --ACTUALIZA EL CAMPO ASIGNADO DE LAS ORDENES EN LDC_ORDER
            --PARA LAS ORDENES YA ASIGNADAS A UNA UNIDAD OPERTAIVA.
            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                 TEMPCULDC_ORDER.ORDER_ID,
                                                 'LDC_BOASIGAUTO.PRASIGNACIONORIGEN, VALIDAR ESTADO DE ORDER PARA ACTUALIZAR FLAG DE ASIGNADO ASIGNADO EN LDC_ORDER');

            IF NVL(DAOR_ORDER.FNUGETORDER_STATUS_ID(TEMPCULDC_ORDER.ORDER_ID, NULL), 0) >= 5 THEN
                UPDATE LDC_ORDER
                SET    ASIGNADO = 'S'
                WHERE  NVL(PACKAGE_ID, 0) = NVL(TEMPCULDC_ORDER.PACKAGE_ID, 0)
                AND    ORDER_ID = TEMPCULDC_ORDER.ORDER_ID;

                LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                     TEMPCULDC_ORDER.ORDER_ID,
                                                     'LA ORDEN FUE ASIGNADA POR UN PROCESO DIFERENTE.');

                proRegistraLogAsig( TEMPCULDC_ORDER.ORDER_ID,
                                      TEMPCULDC_ORDER.PACKAGE_ID,
                                      null);

            ELSE

                LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                     TEMPCULDC_ORDER.ORDER_ID,
                                                     'LDC_BOASIGAUTO.PRASIGNACIONORIGEN, LA ORDEN [' ||
                                                     TEMPCULDC_ORDER.ORDER_ID ||
                                                     '] NO ESTA ASIGNADA AUN A NINGUNA UNIDAD DE TRABAJO');

                --CODIGO DE ASIGNACION
                --EXIT;
                LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                     TEMPCULDC_ORDER.ORDER_ID,
                                                     'LDC_BOASIGAUTO.PRASIGNACIONORIGEN, PETI ORDER [' ||
                                                      TEMPCULDC_ORDER
                                                     .ORDER_ID || '] - SOLICITUD [' ||
                                                      TEMPCULDC_ORDER.PACKAGE_ID || ']');

                LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                     TEMPCULDC_ORDER.ORDER_ID,
                                                     'LDC_BOASIGAUTO.PRASIGNACIONORIGEN, ANTES DE INGRESAR AL CURSOR CUUOBYSOL PARA VALIDAR UOBYSOL');

                --CICLO PARA RECORRER LAS UNIDADES OPERATIVAS DE UOBYSOL
                NUCONTROLCICLOUOBYSOL := 0;
                FOR TEMPCUUOBYSOL IN CUUOBYSOL(TEMPCULDC_ORDER.ORDER_ID, TEMPCULDC_ORDER.PACKAGE_ID) LOOP

                    --TICKET 2001377 LJLB -- se actualiza el sector opertaivo a la orden
                   IF sbFlag = 'S' THEN
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
                      UPDATE or_order SET OPERATING_SECTOR_ID = nuSectorOperativo WHERE order_id = TEMPCULDC_ORDER.ORDER_ID;


                   END IF;

                    NUCONTROLCICLOUOBYSOL := 1;

                    LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                         TEMPCULDC_ORDER.ORDER_ID,
                                                         'LDC_BOASIGAUTO.PRASIGNACIONORIGEN, INGRESO AL CURSOR CUUOBYSOL INGRESA AL CURSOR CULDC_CARUNIOPE CON EL DATO TEMPCUUOBYSOL.OPERATING_UNIT_ID[' ||
                                                         TEMPCUUOBYSOL.OPERATING_UNIT_ID || ']');

                    OPEN CULDC_CARUNIOPE(TEMPCUUOBYSOL.OPERATING_UNIT_ID);
                    FETCH CULDC_CARUNIOPE
                        INTO RTCULDC_CARUNIOPE;
                    IF CULDC_CARUNIOPE%NOTFOUND THEN

                        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                             TEMPCULDC_ORDER.ORDER_ID,
                                                             'LDC_BOASIGAUTO.PRASIGNACIONORIGEN, PASO IF CULDC_CARUNIOPE%NOTFOUND THEN');

                        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                             TEMPCULDC_ORDER.ORDER_ID,
                                                             'LDC_BOASIGAUTO.PRASIGNACIONORIGEN, INGRESA AL CURSOR CUCATEGORIA CONN LOS DATOS TEMPCUUOBYSOL.PRODUCT_ID[' ||
                                                             TEMPCUUOBYSOL.PRODUCT_ID ||
                                                             '] - TEMPCUUOBYSOL.ADDRESS_ID[' ||
                                                             TEMPCUUOBYSOL.ADDRESS_ID || ']');

                        OPEN CUCATEGORIA(TEMPCUUOBYSOL.PRODUCT_ID, TEMPCUUOBYSOL.ADDRESS_ID);
                        FETCH CUCATEGORIA
                            INTO TEMPCUCATEGORIA;
                        CLOSE CUCATEGORIA;

                        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                             TEMPCULDC_ORDER.ORDER_ID,
                                                             'PETI UOBYSOL(UNIDAD OPERATIVA [' ||
                                                             TEMPCUUOBYSOL.OPERATING_UNIT_ID ||
                                                             '] - CATEGORIA [' ||
                                                             TEMPCUUOBYSOL.CATECODI ||
                                                             '] - ACTIVIDAD [' ||
                                                             TEMPCUUOBYSOL.ITEMS_ID ||
                                                             ']) - ORDEN X ACTIVIDAD(PRODUCTO [' ||
                                                             TEMPCUUOBYSOL.PRODUCT_ID ||
                                                             '] - DIRECCION [' ||
                                                             TEMPCUUOBYSOL.ADDRESS_ID ||
                                                             '] - ACTIVIDAD [' ||
                                                             TEMPCUCATEGORIA.CATEGORY_ID || '])');

                        --DATOS ENVIADOS A LOS PROCESOS PRE PARA
                        --VALIDAR DATOS DEFINIDOS EN LOS PROCESOS DE
                        --VALIDACION DE CADA UNO
                        SBDATAIN := NVL(TEMPCULDC_ORDER.ORDER_ID, -1) || '|' ||
                                    NVL(TEMPCULDC_ORDER.PACKAGE_ID, -1) || '|' ||
                                    NVL(TEMPCUUOBYSOL.ACTIVITY_ID, -1) || '|' ||
                                    NVL(TEMPCUUOBYSOL.SUBSCRIPTION_ID, -1) || '|' || 'PRASIGNACIONORIGEN' || '|' ||
                                    TEMPCUCATEGORIA.CATEGORY_ID;

                        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                             TEMPCULDC_ORDER.ORDER_ID,
                                                             'PETI ANTES DE VALIDAR PROCESO MULTIFAMILIAR ' ||
                                                             SBDATAIN);

                        SBUNIDADOPERATIVA := NULL;

                        --LLOZADA: Se obtiene el tipo de solicitud
                        nuPackType := damo_packages.fnugetpackage_type_id(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                          NULL);

                        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                             TEMPCULDC_ORDER.ORDER_ID,
                                                             'LDC_BOASIGAUTO.PRASIGNACIONORIGEN, VALIDA EL TIPO DE TRABAJO[' ||
                                                             nuPackType || '] PARA MULTIFAMILIAR');

                        IF nuPackType IS NOT NULL THEN

                            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                 TEMPCULDC_ORDER.ORDER_ID,
                                                                 'LDC_BOASIGAUTO.PRASIGNACIONORIGEN, INGRESA A LA VALIDACION nuPackType is not null, INGRESARA AL CURSOR cuConfMulti CON EL DATO nuPackType[' ||
                                                                 nuPackType || ']');

                            --LLOZADA: Se abre el cursor para obtener el tipo de trabajo configurado
                            OPEN cuConfMulti(nuPackType);
                            FETCH cuConfMulti
                                INTO nuTipoTrabajo;
                            CLOSE cuConfMulti;

                            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                 TEMPCULDC_ORDER.ORDER_ID,
                                                                 'LDC_BOASIGAUTO.PRASIGNACIONORIGEN, RESULTADO DEL CURSOR cuConfMulti CON EL DATO nuTipoTrabajo[' ||
                                                                 nuTipoTrabajo ||
                                                                 '], LUEGO VALIDA if nuTipoTrabajo is not null then');

                            --LLOZADA: Si trae datos es porque existe una configuraci?n
                            --para multifamiliares
                            IF nuTipoTrabajo IS NOT NULL THEN
                                SBDATAIN := SBDATAIN || '|' || nuTipoTrabajo;

                                SBEXECSERVICIO := 'BEGIN :NUUNIDADOPERATIVA:=' ||
                                                  'LDC_BOASIGAUTO.FSBMULTIFAMILIAR' ||
                                                  '(:SBDATAIN); END;';

                                LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                     TEMPCULDC_ORDER.ORDER_ID,
                                                                     'LDC_BOASIGAUTO.PRASIGNACIONORIGEN, SERVICIO A EJECUTAR SBEXECSERVICIO[' ||
                                                                     SBEXECSERVICIO ||
                                                                     '] CON DATO DE ENTRADA SBDATAIN[' ||
                                                                     SBDATAIN || ']');

                                EXECUTE IMMEDIATE SBEXECSERVICIO
                                    USING IN OUT SBUNIDADOPERATIVA, IN SBDATAIN;

                                LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                     TEMPCULDC_ORDER.ORDER_ID,
                                                                     'LDC_BOASIGAUTO.PRASIGNACIONORIGEN, RESULTADO SERVICIO SBEXECSERVICIO SBUNIDADOPERATIVA[' ||
                                                                     SBUNIDADOPERATIVA || ']');

                            END IF;
                        END IF;

                        /*02/07/2014 LLOZADA: Se debe dejar NUll la variable SBUNIDADOPERATIVA para que
                        para que realice la configuraci?n b?sica de UOBYSOL*/
                        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                             TEMPCULDC_ORDER.ORDER_ID,
                                                             'LDC_BOASIGAUTO.PRASIGNACIONORIGEN, VALIDA IF SBUNIDADOPERATIVA = -1 THEN SBUNIDADOPERATIVA[' ||
                                                             SBUNIDADOPERATIVA || ']');

                        IF SBUNIDADOPERATIVA = '-1' THEN
                            SBUNIDADOPERATIVA := NULL;
                        END IF;

                        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                             TEMPCULDC_ORDER.ORDER_ID,
                                                             'LDC_BOASIGAUTO.PRASIGNACIONORIGEN, RESULTADO DE VALIDA IF SBUNIDADOPERATIVA = -1 THEN SBUNIDADOPERATIVA[' ||
                                                             SBUNIDADOPERATIVA || ']');

                        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                             TEMPCULDC_ORDER.ORDER_ID,
                                                             'PETI ANTES DE VALIDAR PROCESO PRE ' ||
                                                             SBUNIDADOPERATIVA || ' - ' ||
                                                             TEMPCUUOBYSOL.PROCESOPRE || ' - ' ||
                                                             SBDATAIN);

                        ---CODIGO PARA SERVICO PRE
                        --Llozada: Se comenta para validar en el IF
                        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                             TEMPCULDC_ORDER.ORDER_ID,
                                                             'LDC_BOASIGAUTO.PRASIGNACIONORIGEN, VALIDA IF TEMPCUUOBYSOL.PROCESOPRE IS NOT NULL AND SBUNIDADOPERATIVA IS NULL THEN');

                        --SBUNIDADOPERATIVA := NULL;
                        IF TEMPCUUOBYSOL.PROCESOPRE IS NOT NULL AND SBUNIDADOPERATIVA IS NULL THEN

                            SBEXECSERVICIO := 'BEGIN :NUUNIDADOPERATIVA:=' ||
                                              TEMPCUUOBYSOL.PROCESOPRE || '(:SBDATAIN); END;';

                            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                 TEMPCULDC_ORDER.ORDER_ID,
                                                                 'LDC_BOASIGAUTO.PRASIGNACIONORIGEN, SERVICIO PRE EJECUTAR SBEXECSERVICIO[' ||
                                                                 SBEXECSERVICIO ||
                                                                 '] CON DATO DE ENTRADA SBDATAIN[' ||
                                                                 SBDATAIN || ']');

                            EXECUTE IMMEDIATE SBEXECSERVICIO
                                USING IN OUT SBUNIDADOPERATIVA, IN SBDATAIN;

                            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                 TEMPCULDC_ORDER.ORDER_ID,
                                                                 'PETI INGRESO PROCESO PRES -->  ' ||
                                                                 SBEXECSERVICIO ||
                                                                 ' RESULTADO --> ' ||
                                                                 SBUNIDADOPERATIVA);

                            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                 TEMPCULDC_ORDER.ORDER_ID,
                                                                 'LDC_BOASIGAUTO.PRASIGNACIONORIGEN, RESULTADO SERVICIO PRE SBUNIDADOPERATIVA[' ||
                                                                 SBUNIDADOPERATIVA || ']');

                            COMMIT;

                            --IF SBUNIDADOPERATIVA = 'CARRUSEL' THEN
                            --  EXIT;
                            --END IF;

                        END IF;
                        ---FIN CODIGO SERVICIO PRE

                        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                             TEMPCULDC_ORDER.ORDER_ID,
                                                             'LDC_BOASIGAUTO.PRASIGNACIONORIGEN, VALIDA IF SBUNIDADOPERATIVA IS NULL THEN');

                        ---PROCESO CONFIGURACION UOBYSOL
                        IF SBUNIDADOPERATIVA IS NULL THEN


                            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                 TEMPCULDC_ORDER.ORDER_ID,
                                                                 'LDC_BOASIGAUTO.PRASIGNACIONORIGEN, INGRESA A IF SBUNIDADOPERATIVA IS NULL THEN');

                            --CONSULTA PARA OBTENER EL SECTOR OPERATIVO DE LA ORDEN
                            BEGIN
                                SELECT OPERATING_SECTOR_ID
                                INTO   NUOPERATING_SECTOR_ID
                                FROM   OR_ORDER OO
                                WHERE  OO.ORDER_ID = TEMPCULDC_ORDER.ORDER_ID;
                            END;

                            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                 TEMPCULDC_ORDER.ORDER_ID,
                                                                 'LDC_BOASIGAUTO.PRASIGNACIONORIGEN, RESULTADO DE SENTENCIA A OPERATING_SECTOR_ID CON LA VARIABLE NUOPERATING_SECTOR_ID[' ||
                                                                 NUOPERATING_SECTOR_ID || ']');

                            --CONSULTA PARA OBTENER LA ZONA DE LA ORDEN
                            BEGIN
                                SELECT OPERATING_ZONE_ID
                                INTO   NUOPERATING_ZONE_ID
                                FROM   OR_OPERATING_UNIT OOU
                                WHERE  OOU.OPERATING_UNIT_ID = TEMPCUUOBYSOL.OPERATING_UNIT_ID;
                            END;

                            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                 TEMPCULDC_ORDER.ORDER_ID,
                                                                 'LDC_BOASIGAUTO.PRASIGNACIONORIGEN, RESULTADO DE SENTENCIA A OPERATING_ZONE_ID CON LA VARIABLE NUOPERATING_ZONE_ID[' ||
                                                                 NUOPERATING_ZONE_ID || ']');

                            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                 TEMPCULDC_ORDER.ORDER_ID,
                                                                 'LDC_BOASIGAUTO.PRASIGNACIONORIGEN, INGRESAR AL CURSOR CUGE_SECTOROPE_ZONA CON EL DATO DE ENTRADA NUOPERATING_SECTOR_ID[' ||
                                                                 NUOPERATING_ZONE_ID ||
                                                                 '] - NUOPERATING_ZONE_ID[' ||
                                                                 NUOPERATING_ZONE_ID || ']');

                            --CURSOR PARA VALIDAR SI EL SECTOR OPERATIVO ESTA
                            --CONFIGURADO DENTRO DE LA ZONA;
                            OPEN CUGE_SECTOROPE_ZONA(NUOPERATING_SECTOR_ID, NUOPERATING_ZONE_ID);
                            FETCH CUGE_SECTOROPE_ZONA
                                INTO TEMPCUGE_SECTOROPE_ZONA;
                            IF CUGE_SECTOROPE_ZONA%FOUND THEN

                                LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                     TEMPCULDC_ORDER.ORDER_ID,
                                                                     'LDC_BOASIGAUTO.PRASIGNACIONORIGEN, INGRESO AL CURSORIF CUGE_SECTOROPE_ZONA%FOUND THEN');

                                /*
                                --VALIDACION DE ROL
                                OPEN CUROL(TEMPCUUOBYSOL.OPERATING_UNIT_ID);
                                FETCH CUROL
                                  INTO TEMPCUROL;
                                IF CUROL%FOUND THEN
                                */
                                --OBTIENE LA CATEGORIA DEL PRODUCTO

                                LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                     TEMPCULDC_ORDER.ORDER_ID,
                                                                     'LDC_BOASIGAUTO.PRASIGNACIONORIGEN, INGRESAR AL CURSOR CUTIPOPRODUCTO CON EL DATO TEMPCUUOBYSOL.PRODUCT_ID[' ||
                                                                     TEMPCUUOBYSOL.PRODUCT_ID || ']');

                                --NC 2493
                                OPEN CUTIPOPRODUCTO(TEMPCUUOBYSOL.PRODUCT_ID);
                                FETCH CUTIPOPRODUCTO
                                    INTO RTCUTIPOPRODUCTO;
                                IF CUTIPOPRODUCTO%FOUND THEN

                                    LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER
                                                                         .PACKAGE_ID,
                                                                         TEMPCULDC_ORDER.ORDER_ID,
                                                                         'LDC_BOASIGAUTO.PRASIGNACIONORIGEN, INGRESO A CUTIPOPRODUCTO');

                                    LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER
                                                                         .PACKAGE_ID,
                                                                         TEMPCULDC_ORDER.ORDER_ID,
                                                                         'LDC_BOASIGAUTO.PRASIGNACIONORIGEN, INGRESAR AL CURSOR CUSEGMENTOCATEGORIA CON EL DATO TEMPCUUOBYSOL.ADDRESS_ID[' ||
                                                                         TEMPCUUOBYSOL.ADDRESS_ID || ']');

                                    OPEN CUSEGMENTOCATEGORIA(TEMPCUUOBYSOL.ADDRESS_ID);
                                    FETCH CUSEGMENTOCATEGORIA
                                        INTO RTCUSEGMENTOCATEGORIA;
                                    UT_TRACE.TRACE('LA CATEGIRIA DEL PRODUCTO GENERICO ES [' ||
                                                   RTCUSEGMENTOCATEGORIA.CATEGORIA || ']',
                                                   10);

                                    CLOSE CUSEGMENTOCATEGORIA;

                                    LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER
                                                                         .PACKAGE_ID,
                                                                         TEMPCULDC_ORDER.ORDER_ID,
                                                                         'LDC_BOASIGAUTO.PRASIGNACIONORIGEN, LA CATEGIRIA DEL PRODUCTO GENERICO ES [' ||
                                                                         RTCUSEGMENTOCATEGORIA.CATEGORIA || ']');

                                END IF;
                                CLOSE CUTIPOPRODUCTO;
                                --FIN NC 2493

                                LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                     TEMPCULDC_ORDER.ORDER_ID,
                                                                     'LDC_BOASIGAUTO.PRASIGNACIONORIGEN, INGRESA AL CURSOR CUCATEGORIA CON LOS DATOS TEMPCUUOBYSOL.PRODUCT_ID[' ||
                                                                     TEMPCUUOBYSOL.PRODUCT_ID ||
                                                                     '] - TEMPCUUOBYSOL.ADDRESS_ID[' ||
                                                                     TEMPCUUOBYSOL.ADDRESS_ID || ']');

                                OPEN CUCATEGORIA(TEMPCUUOBYSOL.PRODUCT_ID,
                                                 TEMPCUUOBYSOL.ADDRESS_ID);
                                FETCH CUCATEGORIA
                                    INTO TEMPCUCATEGORIA;

                                LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                     TEMPCULDC_ORDER.ORDER_ID,
                                                                     'LDC_BOASIGAUTO.PRASIGNACIONORIGEN, IF CUCATEGORIA%FOUND OR TEMPCUUOBYSOL.CATECODI[' ||
                                                                     TEMPCUUOBYSOL.CATECODI ||
                                                                     '] = -1 OR RTCUSEGMENTOCATEGORIA.CATEGORIA[' ||
                                                                     RTCUSEGMENTOCATEGORIA.CATEGORIA ||
                                                                     '] = TEMPCUUOBYSOL.CATECODI[' ||
                                                                     TEMPCUUOBYSOL.CATECODI ||
                                                                     '] THEN');

                                IF CUCATEGORIA%FOUND OR TEMPCUUOBYSOL.CATECODI = -1 OR
                                  --NC 2493
                                   RTCUSEGMENTOCATEGORIA.CATEGORIA = TEMPCUUOBYSOL.CATECODI THEN
                                    --FIN NC 2493

                                    --VALIDA LA CATEGORIA DEL PRODUTO CONFIGURADA
                                    --CON LA CONFIGURADA EN UOBYSOL

                                    LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER
                                                                         .PACKAGE_ID,
                                                                         TEMPCULDC_ORDER.ORDER_ID,
                                                                         'LDC_BOASIGAUTO.PRASIGNACIONORIGEN, IF TEMPCUCATEGORIA.CATEGORY_ID[' ||
                                                                         TEMPCUCATEGORIA.CATEGORY_ID ||
                                                                         '] = TEMPCUUOBYSOL.CATECODI[' ||
                                                                         TEMPCUUOBYSOL.CATECODI ||
                                                                         '] OR TEMPCUUOBYSOL.CATECODI[' ||
                                                                         TEMPCUUOBYSOL.CATECODI ||
                                                                         '] = -1 OR RTCUSEGMENTOCATEGORIA.CATEGORIA[' ||
                                                                         RTCUSEGMENTOCATEGORIA.CATEGORIA ||
                                                                         '] = TEMPCUUOBYSOL.CATECODI[' ||
                                                                         TEMPCUUOBYSOL.CATECODI ||
                                                                         '] THEN');

                                    IF TEMPCUCATEGORIA.CATEGORY_ID = TEMPCUUOBYSOL.CATECODI OR
                                       TEMPCUUOBYSOL.CATECODI = -1 OR
                                      --NC 2493
                                       RTCUSEGMENTOCATEGORIA.CATEGORIA = TEMPCUUOBYSOL.CATECODI THEN
                                        --FIN NC 2493

                                        BEGIN
                                            --/*
                                            IF sbFlag = 'S' THEN
                                               --TICKET 2001377 LJLB -- se consulta contratos vigentes
                                                SELECT COUNT(1) INTO  nuContrato
                                                FROM open.ge_contrato C, open.ge_contratista g
                                                WHERE C.ID_CONTRATISTA = G.ID_CONTRATISTA AND
                                                      C.status = ct_boconstants.fsbGetOpenStatus AND
                                                     C.ID_CONTRATISTA IN (SELECT contractor_id
                                                                          FROM open.or_operating_unit ou
                                                                          WHERE ou.operating_unit_id = TEMPCUUOBYSOL.OPERATING_UNIT_ID) AND
                                                    (SYSDATE BETWEEN C.FECHA_INICIAL AND C.FECHA_FINAL)
                                                    ;
                                            ELSE
                                              nuContrato := 1;
                                            END IF;
                                            --TICKET 2001377 LJLB -- se valida que exista contrato igente de la unidad qye se va asignar
                                            IF nuContrato > 0 THEN
                                                os_assign_order(TEMPCULDC_ORDER.Order_Id,
                                                                TEMPCUUOBYSOL.OPERATING_UNIT_ID,
                                                                SYSDATE,
                                                                SYSDATE,
                                                                onuerrorcode,
                                                                osberrormessage);

                                                IF onuerrorcode = 0 THEN
                                                    LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                                         TEMPCULDC_ORDER.ORDER_ID,
                                                                                         'LA ORDEN FUE ASIGNADA A LA UNIDAD OPERATIVA [' ||
                                                                                         TEMPCUUOBYSOL.OPERATING_UNIT_ID || ']');

                                                    PRINTENTOSASIGNACION(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                         TEMPCULDC_ORDER.ORDER_ID);

                                                    UPDATE LDC_ORDER
                                                    SET    ASIGNADO = 'S'
                                                    WHERE  NVL(PACKAGE_ID, 0) =
                                                           NVL(TEMPCULDC_ORDER.PACKAGE_ID, 0)
                                                    AND    ORDER_ID = TEMPCULDC_ORDER.ORDER_ID;

                                                    proRegistraLogAsig( TEMPCULDC_ORDER.ORDER_ID,
                                                                          TEMPCULDC_ORDER.PACKAGE_ID,
                                                                          null);

                                                    --EXIT;
                                                ELSE
                                                    LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                                         TEMPCULDC_ORDER.Order_Id,
                                                                                         'UNIDAD OPERATIVA [' ||
                                                                                         TEMPCUUOBYSOL.OPERATING_UNIT_ID ||
                                                                                         '] CODIGO [' ||
                                                                                         onuerrorcode ||
                                                                                         '] DESCRIPCION [' ||
                                                                                         osberrormessage || ']');
                                                    IF sbFlag = 'S' THEN
                                                      --TICKET 2001377 LJLB -- se registra log en la tabla LDC_ORDER
                                                       sbError := substr(sbError||v_salto|| 'ORDEN ['||TEMPCULDC_ORDER.Order_Id||'] UNIDAD OPERATIVA [' ||TEMPCUUOBYSOL.OPERATING_UNIT_ID || '] CODIGO_ERROR [' ||            onuerrorcode || '] DESCRIPCION [' ||   osberrormessage || ']', 1, 3999);

                                                      proRegistraLogAsig( TEMPCULDC_ORDER.ORDER_ID,
                                                                          TEMPCULDC_ORDER.PACKAGE_ID,
                                                                          sbError);
                                                    END IF;
                                                    PRINTENTOSASIGNACION(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                         TEMPCULDC_ORDER.ORDER_ID);
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

                                                LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                                     TEMPCULDC_ORDER.Order_Id,
                                                                                     'EL SERVICIO os_assign_order NO PUDO ASIGNAR LA UNIDAD OPERATIVA [' ||
                                                                                     TEMPCUUOBYSOL.OPERATING_UNIT_ID ||
                                                                                     '] A LA ORDEN');
                                                 IF sbFlag = 'S' THEN
                                                      --TICKET 2001377 LJLB -- se registra log en la tabla LDC_ORDER
                                                      sbError := substr(sbError||v_salto||'ORDEN ['||TEMPCULDC_ORDER.Order_Id||'] UNIDAD OPERATIVA [' || TEMPCUUOBYSOL.OPERATING_UNIT_ID ||  '] ERROR [' ||  SQLERRM|| ']', 1, 3999);

                                                      proRegistraLogAsig( TEMPCULDC_ORDER.ORDER_ID,
                                                                          TEMPCULDC_ORDER.PACKAGE_ID,
                                                                          sbError);
                                                END IF;

                                                PRINTENTOSASIGNACION(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                     TEMPCULDC_ORDER.Order_Id);

                                        END;

                                    ELSE
                                        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                             TEMPCULDC_ORDER.Order_Id,
                                                                             'UNIDAD OPERATIVA [' ||  TEMPCUUOBYSOL.OPERATING_UNIT_ID ||'] LA CATEGORIA [' ||  TEMPCUUOBYSOL.CATECODI ||'] CONFIGURADA (UOBYSOL) NO ES IGUAL A LA CATERORIA [' || TEMPCUCATEGORIA.CATEGORY_ID ||'] DEL CONTRATO ' ||TEMPCUUOBYSOL.SUBSCRIPTION_ID);
                                          IF sbFlag = 'S' THEN
                                             --TICKET 2001377 LJLB -- se registra log en la tabla LDC_ORDER
                                             sbError := substr(sbError||v_salto||'ORDEN ['||TEMPCULDC_ORDER.Order_Id||'] UNIDAD OPERATIVA [' || TEMPCUUOBYSOL.OPERATING_UNIT_ID || '] LA CATEGORIA [' || TEMPCUUOBYSOL.CATECODI || '] CONFIGURADA (UOBYSOL) NO ES IGUAL A LA CATERORIA [' || TEMPCUCATEGORIA.CATEGORY_ID ||'] DEL CONTRATO ' ||  TEMPCUUOBYSOL.SUBSCRIPTION_ID, 1, 3999);

                                            proRegistraLogAsig( TEMPCULDC_ORDER.ORDER_ID,
                                                              TEMPCULDC_ORDER.PACKAGE_ID,
                                                              sbError);
                                          END IF;
                                        PRINTENTOSASIGNACION(TEMPCULDC_ORDER.PACKAGE_ID,
                                                             TEMPCULDC_ORDER.Order_Id);

                                    END IF; --FIN VALIDACION DE CATEGORIA
                                ELSE
                                    LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                         TEMPCULDC_ORDER.Order_Id,
                                                                         'UNIDAD OPERATIVA [' ||
                                                                         TEMPCUUOBYSOL.OPERATING_UNIT_ID ||
                                                                         '] ERROR EN EL IDENTIFICACION DE CATEGORIA DEL PRODUCTO [' ||
                                                                         TEMPCUUOBYSOL.PRODUCT_ID ||
                                                                         '] ASOCIADO AL CONTRATO [' ||
                                                                         TEMPCUUOBYSOL.SUBSCRIPTION_ID ||
                                                                         '] - CATEGORIA RTCUSEGMENTOCATEGORIA [' ||
                                                                         RTCUSEGMENTOCATEGORIA.CATEGORIA ||
                                                                         '] -  CATEGORIA UOBYSOL [' ||
                                                                         TEMPCUUOBYSOL.CATECODI || ']');
                                      IF sbFlag = 'S' THEN
                                        --TICKET 2001377 LJLB -- se registra log en la tabla LDC_ORDER
                                         sbError := substr(sbError||v_salto|| 'ORDEN ['||TEMPCULDC_ORDER.Order_Id||'] UNIDAD OPERATIVA [' || TEMPCUUOBYSOL.OPERATING_UNIT_ID ||'] ERROR EN EL IDENTIFICACION DE CATEGORIA DEL PRODUCTO [' || TEMPCUUOBYSOL.PRODUCT_ID ||'] ASOCIADO AL CONTRATO [' ||TEMPCUUOBYSOL.SUBSCRIPTION_ID || '] - CATEGORIA PRODUCTO [' || RTCUSEGMENTOCATEGORIA.CATEGORIA ||
                                                                           '] -  CATEGORIA UOBYSOL [' || TEMPCUUOBYSOL.CATECODI || ']', 1, 3999);

                                        proRegistraLogAsig( TEMPCULDC_ORDER.ORDER_ID,
                                                          TEMPCULDC_ORDER.PACKAGE_ID,
                                                          sbError);
                                    END IF;
                                    PRINTENTOSASIGNACION(TEMPCULDC_ORDER.PACKAGE_ID,
                                                         TEMPCULDC_ORDER.Order_Id);

                                END IF;
                                CLOSE CUCATEGORIA;
                                /*

                                  ELSE
                                    LDC_BOASIGAUTO.PRREGSITROASIGAUTO(:NEW.PACKAGE_ID,
                                                                      :NEW.Order_Id,
                                                                      'NO ENCONTRO CATEROGIA VALIDA PARA EL CONTRATO ' ||
                                                                      :NEW.SUBSCRIPTION_ID);
                                  END IF; --FIN VALIDACION DE CAPACIDAD
                                  CLOSE CUOR_OPERATING_UNIT;
                                  UT_TRACE.TRACE('FIN CUOR_OPERATING_UNIT', 10);
                                ELSE
                                  LDC_BOASIGAUTO.PRREGSITROASIGAUTO(:NEW.PACKAGE_ID,
                                                                    :NEW.Order_Id,
                                                                    'LA ACTIVIDAD [' ||
                                                                    :NEW.ACTIVITY_ID ||
                                                                    '] Y LA UNIDAD OPERATIVA [' ||
                                                                    TEMPCUUOBYSOL.OPERATING_UNIT_ID ||
                                                                    '] NO ESTAN EN EL MISMO ROL');

                                END IF; --FIN VALIDACION DE ROL
                                CLOSE CUROL;
                                UT_TRACE.TRACE('FIN CUROL', 10);
                                */
                            ELSE
                                LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                                     TEMPCULDC_ORDER.Order_Id,
                                                                     'LA ORDEN [' ||
                                                                     TEMPCULDC_ORDER.ORDER_ID ||
                                                                     '] Y LA UNIDAD OPERATIVA [' ||
                                                                     TEMPCUUOBYSOL.OPERATING_UNIT_ID ||
                                                                     '] NO ESTAN EN EL MISMO SECTOR OPERATIVO');
                                IF sbFlag = 'S' THEN
                                   --TICKET 2001377 LJLB -- se registra log en la tabla LDC_ORDER
                                   sbError := substr(sbError||v_salto|| 'LA ORDEN [' ||TEMPCULDC_ORDER.ORDER_ID ||'] Y LA UNIDAD OPERATIVA [' || TEMPCUUOBYSOL.OPERATING_UNIT_ID ||'] NO ESTAN EN LA MISMA ZONA OPERATIVA. SECTOR ORDEN['||nuSectorOperativo||']  ZONA OPERATIVA  DE LA UNIDAD OPERATIVA ['||NUOPERATING_ZONE_ID||']', 1, 3999);

                                  proRegistraLogAsig( TEMPCULDC_ORDER.ORDER_ID,
                                                    TEMPCULDC_ORDER.PACKAGE_ID,
                                                    sbError);
                                END IF;

                                PRINTENTOSASIGNACION(TEMPCULDC_ORDER.PACKAGE_ID,
                                                     TEMPCULDC_ORDER.Order_Id);
                            END IF; --FIN VALIDACION SECTOR OPERATIVO
                            CLOSE CUGE_SECTOROPE_ZONA;
                        END IF; --VALIDACION SBUNIDADOPERATIVA IS NULL
                        --FIN PROCESO CONFIGURACION UOBYSOL

                        --PROCESO POST
                        IF TEMPCUUOBYSOL.PROCESOPOST IS NOT NULL THEN
                            SBEXECSERVICIO := 'BEGIN :NUUNIDADOPERATIVA:=' ||
                                              TEMPCUUOBYSOL.PROCESOPRE || '(:SBDATAIN); END;';

                            EXECUTE IMMEDIATE SBEXECSERVICIO
                                USING IN OUT SBUNIDADOPERATIVA, IN SBDATAIN;
                            COMMIT;
                        END IF;
                        --FIN PROCESO POST
                    ELSE
                        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                             TEMPCULDC_ORDER.ORDER_ID,
                                                             'NO PASO IF CULDC_CARUNIOPE%NOTFOUND THEN');

                    END IF; --VALIDACION DE UNIDADES OPERATIVAS ACTIVAS
                    CLOSE CULDC_CARUNIOPE;
                END LOOP;

                IF NUCONTROLCICLOUOBYSOL = 0 THEN
                    LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(TEMPCULDC_ORDER.PACKAGE_ID,
                                                         TEMPCULDC_ORDER.Order_Id,
                                                         'LA ORDEN NO TIENE CONFIGURACION ADECUADA EN LA FORMA UOBYSOL');
                     IF sbFlag = 'S' THEN
                       --TICKET 2001377 LJLB -- se registra log en la tabla LDC_ORDER
                      sbError := substr(sbError||v_salto|| 'ORDEN ['||TEMPCULDC_ORDER.Order_Id||']  LA ORDEN NO TIENE CONFIGURACION ADECUADA EN LA FORMA UOBYSOL', 1, 3999);

                      proRegistraLogAsig( TEMPCULDC_ORDER.ORDER_ID,
                                         TEMPCULDC_ORDER.PACKAGE_ID,
                                        sbError);
                    END IF;
                    PRINTENTOSASIGNACION(TEMPCULDC_ORDER.PACKAGE_ID, TEMPCULDC_ORDER.Order_Id);
                END IF;

                ---FIN CODIGO DE ASIGNACION
            END IF;
            --FIN VALIDACION DE ACTUALIZA EL CAMPO ASIGNADO DE LAS ORDENES EN LDC_ORDER.
        END LOOP;

        LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(NUSOLICITUD, NUORDEN, 'PETI ANTES DEL COMMIT');

        COMMIT;

    EXCEPTION

        WHEN OTHERS THEN

            OSBERRORMESSAGE := '[' || DBMS_UTILITY.FORMAT_ERROR_STACK || '] - ' ||
                               DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;

            LDC_BOASIGAUTO.PRREGSITROASIGAUTOLOG(NULL,
                                                 NULL,
                                                 'ERROR OTHERS PRASIGNACIONORIGEN --> ' ||
                                                 OSBERRORMESSAGE);
            COMMIT;

    END PRASIGNACIONORIGEN;


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


   /* nuIndTT :=  tTipoTrab.first;
    loop exit when (nuIndTT IS null);
      dbms_output.put_line(nuIndTT || ' - ' || tTipoTrab(nuIndTT).tipotrab || ' - ' ||  tTipoTrab(nuIndTT).tipoprod);
       nuIndTT := tTipoTrab.next(nuIndTT);
    end loop;*/

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
                          dtFechaA   in date,
                          dtFechaC   in date,
                          nuSolici   in open.mo_packages.package_id%type,
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
       os_assign_order(inuOrden,
                       inuUnidad,--
                       dtFechaA,
                       dtFechaC,
                       onuError,
                       osbMensaje);
       IF onuError = 0 THEN
          UPDATE LDC_ORDER
          SET    ASIGNADO = 'S'
          WHERE  NVL(PACKAGE_ID, 0) =
                 NVL(nuSolici, 0)
          AND    ORDER_ID = inuOrden;
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
