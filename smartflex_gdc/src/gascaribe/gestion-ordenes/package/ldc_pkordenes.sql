CREATE OR REPLACE PACKAGE LDC_PKORDENES
IS
    /*****************************************************************

      PROPIEDAD INTELECTUAL DE SINCECOMP (C).

      UNIDAD         : LDC_PKORDENES
      DESCRIPCION    : PAQUETE CREADO PARA ADMINISTRACION DE ORDENES.
      AUTOR          : SINCECOMP
      FECHA          : 09/04/2016





      HISTORIA DE MODIFICACIONES
      FECHA             AUTOR             MODIFICACION
      =========         =========         ====================
      10/07/2018        Josh Brito        CASO 200-2021 [OSS_MAN_JGBA_2002021_1] se incluyo un condicional para validar
                                          si la entrega aplica para la gasera y si esta es verdadera actualizara la fecha
                                          de instalacion del producto con la misma fecha de fin de ejecucion de la orden
                                          legalizada de cargo por conexion

      25/11/2018        horbath           caso 200-2179 se modifica procedimiento PROINTERNACXC para que se quiten de la lógica
                                          del procedimiento los llamados a los cursores CUCANTOTCARGO y CUCANTOTINSTALA
      
      21/07/2023        jerazomvm           CASO OSF-1261: Se modifican los métodos JOBLEGORDECARTRP, PROINTERNACXC, PROENCOLAMIENTOCARTRP y LDC_PRGENORDVIS.
      13/06/2026        felipe.valencia     OSF-1549: Se modifica el proceso PROENCOLAMIENTOCARTRP para tomar la persona que legaliza las ordenes de cartera
                                            del parametro PERSONA_LEGALIZA_CARTERA
                                            Adicionales agrega la validación de cursor cerrado antes de arbirlos
                                            Se cambia el api de creación de orden en el procedimiento LDC_PRGENORDVIS por api_createorder

    ******************************************************************/


    /*****************************************************************

    UNIDAD       : PROINTERNACXC
    DESCRIPCION  : SERVICIO ENCARGADO DE PERMITIR LEGLAIZAR LA ORDEN DE CXC
                   SOLO CUANDO LA INTERNA DE LA SOLCIITUD ESTE LEGALIZADA.


    AUTOR          : SINCECOMP
    FECHA          : 09/04/2016


    HISTORIA DE MODIFICACIONES
    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================

    ******************************************************************/

    PROCEDURE PROINTERNACXC;



    --Inicio CASO 100-8157 Encolamiento CARTERA - RP

    /*****************************************************************

    UNIDAD       : PROENCOLAMIENTOCARTRP
    DESCRIPCION  : SERVICIO ENCARGADO DE ESTABLECER CUANDO UAN ORDEN DE RP O CARTERA SE
                   LEGALIZA Y CON BASE A ESTO DETERMINAR LAS ORDENES QUE SERAN LEGALIZADAS
                   * CASO 1 : EN CASO DE SER UAN ORDEN DE RP LA QUE SEA LEGALIZADA POR ESTE SERVICIO.
                              BUSCARA LAS ORDENES DE SUSPENSION DE CARTERA EN ESTADO REGISTRA O ASIGNADA.
                              ESTO CON EL FIN DE NO PERMITIRLE A ESTE TIPO DE ORDENES DE CARTERA NUEVAMENTE
                              SUSPENDER EL PRODCUTO.
                   * CASO 2 : EN CASO DE SER UAN ORDEN DE CARTERA LA QUE SEA LEGALIZADA POR ESTE SERVICIO.
                              BUSCARA LAS ORDENES DE SUSPENSION DE RP EN ESTADO REGISTRA O ASIGNADA.
                              ESTO CON EL FIN DE NO PERMITIRLE A ESTE TIPO DE ORDENES DE RP NUEVAMENTE
                              SUSPENDER EL PRODCUTO.

    AUTOR          : SINCECOMP
    FECHA          : 07/07/2016

    HISTORIA DE MODIFICACIONES
    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    13/06/2026        felipe.valencia     OSF-1549: Se modifica el proceso PROENCOLAMIENTOCARTRP para tomar la persona que legaliza las ordenes de cartera
                                            del parametro PERSONA_LEGALIZA_CARTERA
    ******************************************************************/

    PROCEDURE PROENCOLAMIENTOCARTRP;

    --Fin CASO 100-8157 Encolamiento CARTERA - RP
    --Inicio CASO 200-514 Anulacion de ordenes y solicitudes cuan se anula contrato
    /*****************************************************************
    UNIDAD       : PROCOTSOLTRAANUPRO
    DESCRIPCION  : SERVICIO PARA CERRAR LAS ORDENES Y SOLICITUDES CUANDO SE AUTORIZA EL
                   TRAMITE DE ANULACION DE PRODUCTO.

    AUTOR          : SINCECOMP
    FECHA          : 29/09/2016

    HISTORIA DE MODIFICACIONES
    FECHA             AUTOR             MODIFICACION
    =========       ========            ====================
    ******************************************************************/

    PROCEDURE PROCOTSOLTRAANUPRO;

    --Fin CASO 200-514 Anulacion de ordenes y solicitudes cuan se anula contrato
    --Inicio CASO 200-615

    /*****************************************************************

    UNIDAD       : FNCONSULTAORDENESVISITAS
    DESCRIPCION  : SERVICIO PARA IDENTIFCAR LAS ORDENDES DE VISITAS CANCELADAS DE SOLICITUDES DE VENTAS



    AUTOR          : SINCECOMP
    FECHA          : 04/11/2016


    HISTORIA DE MODIFICACIONES
    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================

    ******************************************************************/

    FUNCTION FNCONSULTAORDENESVISITAS
        RETURN pkConstante.tyRefCursor;


    /*****************************************************************

    Propiedad intelectual de PETI (c).


    Unidad         : LDC_PRGENORDVIS
    Descripcion    : Procedimiento para generar orden de visita
    Autor          : Jorge Valiente
    Fecha          : 02/02/2017



    Parametros              Descripcion
    ============         ===================


    Fecha             Autor                 Modificacion
    =========       =========              ====================

    ******************************************************************/

    PROCEDURE LDC_PRGENORDVIS (isbCodigoIdentificador   IN     VARCHAR2,
                               inuCurrent               IN     NUMBER,
                               inuTotal                 IN     NUMBER,
                               onuErrorCode                OUT NUMBER,
                               osbErrorMessage             OUT VARCHAR);

    --Fin CASO 200-615

    PROCEDURE JOBLEGORDECARTRP;
/*****************************************************************
Propiedad intelectual de gdc (c).


Unidad         : JOBLEGORDECARTRP
Descripcion    : Pjob que legaliza ordenes de suspension encolamiento
Autor          : Olsoftware
Ticket         : 470
Fecha          : 04/11/2020



Parametros              Descripcion
============         ===================



Fecha           Autor           Modificacion
=========       =========       ====================
21/07/2023      jerazomvm       CASO OSF-1261:
                                1. Se reemplaza el llamado del API os_legalizeorders
                                   por el API api_legalizeorders.
                                2. Se reemplaza el manejo de errores ex y errors por Pkg_error.
                                3. Se elimina la funcion fblAplicaEntregaxCaso, para las entregas la cual retorna true.
******************************************************************/

END LDC_PKORDENES;
/

CREATE OR REPLACE PACKAGE BODY LDC_PKORDENES
AS
    /*****************************************************************

      PROPIEDAD INTELECTUAL DE SINCECOMP (C).


      UNIDAD         : LDC_PKORDENES
      DESCRIPCION    : PAQUETE CREADO PARA ADMINISTRACION DE ORDENES.
      AUTOR          : SINCECOMP
      FECHA          : 09/04/2016





      HISTORIA DE MODIFICACIONES
      FECHA             AUTOR             MODIFICACION
      =========         =========         ====================

    ******************************************************************/



    /*****************************************************************

    UNIDAD       : PROINTERNACXC
    DESCRIPCION  : SERVICIO ENCARGADO DE PERMITIR LEGLAIZAR LA ORDEN DE CXC
                   SOLO CUANDO LA INTERNA DE LA SOLCIITUD ESTE LEGALIZADA.



    AUTOR          : SINCECOMP
    FECHA          : 09/04/2016



    HISTORIA DE MODIFICACIONES
    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    10/07/2018   Josh Brito          CASO 200-2021 [OSS_MAN_JGBA_2002021_1] se incluyo un condicional para validar
               si la entrega aplica para la gasera y si esta es verdadera actualizara la fecha
               de instalacion del producto con la misma fecha de fin de ejecucion de la orden
               legalizada de cargo por conexion

    25/11/2018      horbath            caso 200-2179. Se quita de la logica los llamados a los cursores CUCANTOTCARGO y CUCANTOTINSTALA
    21/07/2023      jerazomvm       CASO OSF-1261:
                                    1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
                                    2. Se elimina la función fblaplicaentrega, para las entregas la cual retorna true.
									3. Se reemplaza la separación de cadena LDC_BOUTILITIES.SPLITSTRINGS por 
									   SELECT to_number(regexp_substr(variable,
														'[^,]+',
														1,
														LEVEL)) AS alias
									   FROM dual
									   CONNECT BY regexp_substr(variable, '[^,]+', 1, LEVEL) IS NOT NULL
    ******************************************************************/

    PROCEDURE PROINTERNACXC
    IS
	
		-- Variables
		sbCod_tt_int			ld_parameter.value_chain%type := DALD_PARAMETER.fsbGetValue_Chain('COD_TT_INT', NULL);
		sbCod_TT_CER_BLO		ld_parameter.value_chain%type := DALD_PARAMETER.FSBGETVALUE_CHAIN ('COD_TT_CER_BLO', NULL);
		sbCod_Causal_valida		ld_parameter.value_chain%type := DALD_PARAMETER.FSBGETVALUE_CHAIN('COD_CAUSAL_VALIDA', NULL);
	
        --CANTIDAD DE ORDENES DE CARGO X CONEXION DE UNA SOLICITUD

        CURSOR CUCANTOTCARGO (
            NUSOLIC       OR_ORDER_ACTIVITY.PACKAGE_ID%TYPE,
            NUDIRECCION   OR_ORDER_ACTIVITY.ADDRESS_ID%TYPE)
        IS
            SELECT COUNT (*)
              FROM OR_ORDER_ACTIVITY A, OR_ORDER B
             WHERE     A.ORDER_ID = B.ORDER_ID
                   AND A.TASK_TYPE_ID IN (12150, 12152, 12153)
                   AND A.PACKAGE_ID = NUSOLIC
                   AND A.ADDRESS_ID = NUDIRECCION;



        --CANTIDAD DE ORDENES DE INSTALACION DE UNA SOLICITUD

        CURSOR CUCANTOTINSTALA (
            NUSOLIC       OR_ORDER_ACTIVITY.PACKAGE_ID%TYPE,
            NUDIRECCION   OR_ORDER_ACTIVITY.ADDRESS_ID%TYPE)
        IS
            SELECT COUNT (*)
              FROM OR_ORDER_ACTIVITY  A,
                   OR_ORDER           B,
                   (SELECT MAX (B1.CREATED_DATE)     CREATED_DATE
                      FROM OR_ORDER_ACTIVITY A1, OR_ORDER B1
                     WHERE     A1.ORDER_ID = B1.ORDER_ID
                           AND A1.TASK_TYPE_ID IN
                                   (SELECT to_number(regexp_substr(sbCod_tt_int,
                                                     '[^,]+',
                                                     1,
                                                     LEVEL)) AS COD_TT_INT
									FROM dual
									CONNECT BY regexp_substr(sbCod_tt_int, '[^,]+', 1, LEVEL) IS NOT NULL)
                           AND A1.PACKAGE_ID = NUSOLIC
                           AND A1.ADDRESS_ID = NUDIRECCION) C
             WHERE     A.ORDER_ID = B.ORDER_ID
                   AND A.TASK_TYPE_ID IN
                           (SELECT to_number(regexp_substr(sbCod_tt_int,
                                             '[^,]+',
                                             1,
                                             LEVEL)) AS COD_TT_INT
							FROM dual
							CONNECT BY regexp_substr(sbCod_tt_int, '[^,]+', 1, LEVEL) IS NOT NULL)
                   AND B.ORDER_STATUS_ID = 8
                   AND B.CREATED_DATE = C.CREATED_DATE
                   AND A.PACKAGE_ID = NUSOLIC
                   AND A.ADDRESS_ID = NUDIRECCION;


        --OBTIENE LA SOLICITUD ASOCIADA A LA ORDEN DE INSTANCIA
        CURSOR CUSOLICITUD (NUORDEN OR_ORDER.ORDER_ID%TYPE)
        IS
            SELECT B.PACKAGE_ID, P.PACKAGE_TYPE_ID
              FROM OR_ORDER_ACTIVITY B, MO_PACKAGES P
             WHERE B.PACKAGE_ID = P.PACKAGE_ID AND B.ORDER_ID = NUORDEN;



        --OBTIENE LAS ORDENES DE LA SOLICITUD
        CURSOR CUORDENESSOLICITUD (
            NUPACKAGE       MO_PACKAGES.PACKAGE_ID%TYPE,
            NUTIPOTRABAJO   OR_ORDER.TASK_TYPE_ID%TYPE,
            NUDIRECCION     OR_ORDER_ACTIVITY.ADDRESS_ID%TYPE)
        IS
            SELECT OO.ORDER_ID     ORDEN,
                   OA.ORDER_ACTIVITY_ID,
                   OO.OPERATING_UNIT_ID
              FROM OR_ORDER OO, OR_ORDER_ACTIVITY OA
             WHERE     OA.ORDER_ID = OO.ORDER_ID
                   AND OO.ORDER_STATUS_ID = 5
                   AND OA.PACKAGE_ID = NUPACKAGE
                   AND OO.TASK_TYPE_ID IN
                           (SELECT to_number(regexp_substr(sbCod_TT_CER_BLO,
                                             '[^,]+',
                                             1,
                                             LEVEL)) AS COD_TT_CER_BLO
							FROM dual
							CONNECT BY regexp_substr(sbCod_TT_CER_BLO, '[^,]+', 1, LEVEL) IS NOT NULL)
                   AND OO.TASK_TYPE_ID NOT IN NUTIPOTRABAJO
                   AND OA.ADDRESS_ID = NUDIRECCION;



        CURSOR CUCLASECAUSA (INUCAUSA GE_CAUSAL.CAUSAL_ID%TYPE)
        IS
            SELECT CLASS_CAUSAL_ID
              FROM GE_CAUSAL
             WHERE CAUSAL_ID = INUCAUSA;



        CURSOR CUPERSONAUT (NUUNIDAD OR_ORDER.OPERATING_UNIT_ID%TYPE)
        IS
            SELECT PERSON_ID
              FROM OR_OPER_UNIT_PERSONS
             WHERE OPERATING_UNIT_ID = NUUNIDAD AND ROWNUM = 1;



        --VALIDA QUE LA ORDEN QUE LLEGA SEA DE REPARACION
        CURSOR CUOBTENERDATOSOT (NUORDEN OR_ORDER.ORDER_ID%TYPE)
        IS
            SELECT A.TASK_TYPE_ID,
                   B.CAUSAL_ID,
                   A.ADDRESS_ID,
                   A.PRODUCT_ID
              FROM OR_ORDER_ACTIVITY A, OR_ORDER B
             WHERE A.ORDER_ID = B.ORDER_ID AND A.ORDER_ID = NUORDEN;



        NUORDENINSTANCIA      OR_ORDER.ORDER_ID%TYPE;
        NUTTINSTANCIA         OR_ORDER.TASK_TYPE_ID%TYPE;
        NUTIPOPAQUETE         MO_PACKAGES.PACKAGE_TYPE_ID%TYPE;
        NUSOLICITUD           MO_PACKAGES.PACKAGE_ID%TYPE;
        NUCAUSALID            GE_CAUSAL.CAUSAL_ID%TYPE;
        NUCLASECAUSA          GE_CAUSAL.CLASS_CAUSAL_ID%TYPE;
        NUDIRE                OR_ORDER_ACTIVITY.ADDRESS_ID%TYPE;
        NUPRODUCT_ID          OR_ORDER_ACTIVITY.PRODUCT_ID%TYPE;
        NUORDENLEG            OR_ORDER.ORDER_ID%TYPE;
        NUUNIDOPER            OR_ORDER.OPERATING_UNIT_ID%TYPE;
        NUSESUESCO            SERVSUSC.SESUESCO%TYPE;
        SBCAUSALESINCUMPLE    VARCHAR2 (2000);
        SBTIPOSPAQUETESVTAS   VARCHAR2 (2000);
        NUCANTCARGO           NUMBER;
        NUCANTINSTALA         NUMBER;
        NUCANTOTNUEVA         NUMBER;
        NUCANTEJECUTA         NUMBER;
        NUCANTINCUMPLE        NUMBER;
        NUERRORCODE           NUMBER;
        NUCANTACTIVIDAD       NUMBER;
        SBERRORMESSAGE        VARCHAR2 (4000);
        SBCOMMENT             VARCHAR2 (4000);
        SBDATAORDER           VARCHAR2 (2000);
        NUPERSONID            NUMBER;


        CURSOR CUEXISTE (NUCAUSAL OR_ORDER.CAUSAL_ID%TYPE)
        IS
            SELECT COUNT (1)     CANTIDAD
              FROM DUAL
             WHERE NUCAUSAL IN
                       (SELECT to_number(regexp_substr(sbCod_Causal_valida,
                                         '[^,]+',
                                         1,
                                         LEVEL)) AS COD_CAUSAL_VALIDA
						FROM dual
						CONNECT BY regexp_substr(sbCod_Causal_valida, '[^,]+', 1, LEVEL) IS NOT NULL);

        NUCANTIDAD            NUMBER;
    BEGIN
        UT_TRACE.TRACE ('INICIO LDC_PKORDENES.PROINTERNACXC', 10);


        --ORDEN DE LA INSTANCIA
        NUORDENINSTANCIA := OR_BOLEGALIZEORDER.FNUGETCURRENTORDER;

        IF CUOBTENERDATOSOT%ISOPEN THEN
            CLOSE CUOBTENERDATOSOT;
        END IF;

        --OBTIENE DATOS DE LA ORDEN DE LA INSTANCIA
        OPEN CUOBTENERDATOSOT (NUORDENINSTANCIA);
        FETCH CUOBTENERDATOSOT
            INTO NUTTINSTANCIA,
                 NUCAUSALID,
                 NUDIRE,
                 NUPRODUCT_ID;
        CLOSE CUOBTENERDATOSOT;

        IF CUSOLICITUD%ISOPEN THEN
            CLOSE CUSOLICITUD;
        END IF;

        --OBTIENE LA SOLICITUD ASOCIADA A LA ORDEN DE REPARACION
        OPEN CUSOLICITUD (NUORDENINSTANCIA);
        FETCH CUSOLICITUD INTO NUSOLICITUD, NUTIPOPAQUETE;
        CLOSE CUSOLICITUD;



        UT_TRACE.TRACE ('TIPO DE TRABAJO[' || NUTTINSTANCIA || ']', 10);
        
        UT_TRACE.TRACE ('CAUSAL LEGALIZACION[' || NUCAUSALID || ']', 10);

        UT_TRACE.TRACE ('PRODUCTO[' || NUPRODUCT_ID || ']', 10);

        UT_TRACE.TRACE ('TIPO DE SOLICITUD[' || NUTIPOPAQUETE || ']', 10);



        --VALIDA QUE HAYA SOLICITUD ASOCIADA A LA ORDEN
        IF (NUTIPOPAQUETE IS NOT NULL)
        THEN
            SBTIPOSPAQUETESVTAS :=
                DALD_PARAMETER.FSBGETVALUE_CHAIN ('COD_SOL_VEN_GAS');

            --VALIDA EL TIPO DE PAQUETE

            --
            IF (LDC_BOUTILITIES.FSBBUSCATOKEN (SBTIPOSPAQUETESVTAS,
                                               TO_CHAR (NUTIPOPAQUETE),
                                               ',') =
                'S')
            THEN
                --OBTIENE LAS CAUSALES DE INCUMPLIMIENTO PARA NUEVAS

                -- 200-2179 se quita el llamado a los cursores CUCANTOTCARGO y CUCANTOTINSTALA

                UT_TRACE.TRACE ('DIRECCION[' || NUDIRE || ']', 10);

                UT_TRACE.TRACE ('SOLICITUD[' || NUSOLICITUD || ']', 10);


                UT_TRACE.TRACE (
                    'LA CANTIDAD DE ORDENES DE CXC ES IGUAL A LA CANTIDAD DE ORDENES DE INTERNA LEGALIZADAS POR EL CONTRATISTA',
                    10);

                SELECT S.SESUESCO
                  INTO NUSESUESCO
                  FROM SERVSUSC S
                 WHERE S.SESUNUSE = NUPRODUCT_ID;

                UT_TRACE.TRACE (
                       'ESTADO DE CORTE SEL SERVICIO ['
                    || NUPRODUCT_ID
                    || '] ES ['
                    || NUSESUESCO
                    || '] Y SERA REEMPLAZADO POR 1',
                    10);

                    UPDATE SERVSUSC S
                       SET S.SESUESCO = 1,
                           S.SESUFEIN =
                               DAOR_ORDER.FDTGETEXECUTION_FINAL_DATE (
                                   NUORDENINSTANCIA)
					   WHERE S.SESUNUSE = NUPRODUCT_ID;

                SELECT PP.PRODUCT_STATUS_ID
                  INTO NUSESUESCO
                  FROM PR_PRODUCT PP
                  WHERE PP.PRODUCT_ID = NUPRODUCT_ID;


                UT_TRACE.TRACE (
                       'ESTADO DE PRODUCTO  ['
                    || NUPRODUCT_ID
                    || '] ES ['
                    || NUSESUESCO
                    || '] Y SERA REEMPLAZADO POR 1',
                    10);

                DAPR_PRODUCT.UPDPRODUCT_STATUS_ID (NUPRODUCT_ID, 1);

                UPDATE PR_COMPONENT PC
                   SET PC.COMPONENT_STATUS_ID = 5
                 WHERE PC.PRODUCT_ID = NUPRODUCT_ID;



                UT_TRACE.TRACE (
                    'ACTUALIZACION DE LOS ESTADOS DEL COMPONENTE A [5]',
                    10);

            END IF;                                --VALIDA EL TIPO DE PAQUETE
        END IF;                             --VALIDA Q HAYA SOLICITUD ASOCIADA



        UT_TRACE.TRACE ('FIN LDC_PKORDENES.PROINTERNACXC', 10);

    EXCEPTION
        WHEN PKG_ERROR.CONTROLLED_ERROR
        THEN
            RAISE;
        WHEN OTHERS
        THEN
            Pkg_Error.SetErrorMessage(
                LD_BOCONSTANS.CNUGENERIC_ERROR,
                'ERROR AL EJECUTAR PROCESO PROINCUMPLENUEVAS');

            RAISE;
    END PROINTERNACXC;



    --Inicio CASO 100-8157 Encolamiento CARTERA - RP
    /*****************************************************************
    UNIDAD       : PROENCOLAMIENTOCARTRP
    DESCRIPCION  : SERVICIO ENCARGADO DE ESTABLECER CUANDO UAN ORDEN DE RP O CARTERA SE
                   LEGALIZA Y CON BASE A ESTO DETERMINAR LAS ORDENES QUE SERAN LEGALIZADAS
                   * CASO 1 : EN CASO DE SER UAN ORDEN DE RP LA QUE SEA LEGALIZADA POR ESTE SERVICIO.
                              BUSCARA LAS ORDENES DE SUSPENSION DE CARTERA EN ESTADO REGISTRA O ASIGNADA.
                              ESTO CON EL FIN DE NO PERMITIRLE A ESTE TIPO DE ORDENES DE CARTERA NUEVAMENTE
                              SUSPENDER EL PRODCUTO.
                   * CASO 2 : EN CASO DE SER UAN ORDEN DE CARTERA LA QUE SEA LEGALIZADA POR ESTE SERVICIO.
                              BUSCARA LAS ORDENES DE SUSPENSION DE RP EN ESTADO REGISTRA O ASIGNADA.
                              ESTO CON EL FIN DE NO PERMITIRLE A ESTE TIPO DE ORDENES DE RP NUEVAMENTE
                              SUSPENDER EL PRODCUTO.

    AUTOR          : SINCECOMP
    FECHA          : 07/07/2016

    HISTORIA DE MODIFICACIONES
    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
    09/05/2019      ELAL                CA 200-2440 se comentarea los update de la tabla or_order a estado anulado y se utiliza proceso ldc_cancel_order
    24/10/2019      Cfigueroa        194 - Incluir validaciÿ³n para Desbloquear la orden encaso de estar bloqueada, para posteriormente anularla.
    03/11/2020      olsoftware         ca 470 se coloca nueva funcionalidad para la legalizacion de las ordenes de encolamiento
    15/10/2021      dsaltarin          glpi 263: Se contempla la suspsneison por calidad de la medicion
    21/07/2023      jerazomvm           CASO OSF-1261:
                                        1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
                                        2. Se elimina las funcion fblAplicaEntregaxCaso para las entregas la cual retorna true.
										3. Se reemplaza la separación de cadena LDC_BOUTILITIES.SPLITSTRINGS por 
										   SELECT to_number(regexp_substr(variable,
															'[^,]+',
															1,
															LEVEL)) AS alias
										   FROM dual
										   CONNECT BY regexp_substr(variable, '[^,]+', 1, LEVEL) IS NOT NULL
										4. Se reemplaza el API OS_ASSIGN_ORDER por el API API_ASSIGN_ORDER
										5. Se reemplaza el método OR_BOFWLOCKORDER.UNLOCKORDER por el API api_unlockorder
    13/06/2026        felipe.valencia     OSF-1549: Se modifica el proceso PROENCOLAMIENTOCARTRP para tomar la persona que legaliza las ordenes de cartera
                                            del parametro PERSONA_LEGALIZA_CARTERA
    ******************************************************************/


    PROCEDURE PROENCOLAMIENTOCARTRP
    IS
        NUORDENINSTANCIA            OR_ORDER.ORDER_ID%TYPE;
		sbCod_Tip_Tra_Rp_Sus		ld_parameter.value_chain%type	:=	DALD_PARAMETER.FSBGETVALUE_CHAIN ('COD_TIP_TRA_RP_SUS', NULL);
		sbCod_Est_Ord_Rp_Sus		ld_parameter.value_chain%type	:=	DALD_PARAMETER.FSBGETVALUE_CHAIN('COD_EST_ORD_RP_SUS', NULL);
		sbCod_Tip_Tra_Car_Sus		ld_parameter.value_chain%type	:=	DALD_PARAMETER.FSBGETVALUE_CHAIN('COD_TIP_TRA_CAR_SUS', NULL);
		sbCod_Est_Ord_Car_Sus		ld_parameter.value_chain%type	:=	DALD_PARAMETER.FSBGETVALUE_CHAIN('COD_EST_ORD_CAR_SUS', NULL);
		sbCod_Tip_Tra_Car_Cam_Con	ld_parameter.value_chain%type	:=  DALD_PARAMETER.FSBGETVALUE_CHAIN('COD_TIP_TRA_CAR_CAM_CON', NULL);

        --INICIO CURSOR PARA OBTENER DATOS DE LA OT A LEGALIZAR
        CURSOR CUOBTENERDATOSOT (NUORDEN OR_ORDER.ORDER_ID%TYPE)
        IS
            SELECT A.TASK_TYPE_ID     TT,
                   B.CAUSAL_ID        CAUSAL,
                   A.ADDRESS_ID       DIRECCION,
                   A.PRODUCT_ID       PRODUCTO
              FROM OR_ORDER_ACTIVITY A, OR_ORDER B
             WHERE A.ORDER_ID = B.ORDER_ID AND A.ORDER_ID = NUORDEN;

        RFCUOBTENERDATOSOT          CUOBTENERDATOSOT%ROWTYPE;

        --FIN CURSOR PARA OBTENER DATOS DE LA OT A LEGALIZAR

        --INICIO AREA RP
        --******INICIO CURSOR PARA VALIDAR TIPO DE TRABAJO EXISTE EN PARAMETRO DE RP
        CURSOR CUEXISTERP (
            NUOR_ORDER_ACTIVITY   OR_ORDER_ACTIVITY.TASK_TYPE_ID%TYPE)
        IS
            SELECT COUNT (1)     CANTIDAD
              FROM DUAL
             WHERE NUOR_ORDER_ACTIVITY IN
                       (SELECT to_number(regexp_substr(sbCod_Tip_Tra_Rp_Sus,
                                         '[^,]+',
                                         1,
                                         LEVEL)) AS COD_TIP_TRA_RP_SUS
						FROM dual
						CONNECT BY regexp_substr(sbCod_Tip_Tra_Rp_Sus, '[^,]+', 1, LEVEL) IS NOT NULL);

        NUCANTIDADRP                NUMBER;

        --******FIN CURSOR PARA VALIDAR TIPO DE TRABAJO EXISTE EN PARAMETRO

        --******INICIO CURSOR PARA BUSCAR LA ORDENES DE RP DE SUSPENSION SIN LEGEALIZAREN CUANDO LA ORDEN A LEGALIZAR SEA UAN ORDEN DE CARTERA
        CURSOR CUOTSUS_RP_SIN_LEG (
            nuproduct_idCAR   pr_product.product_id%TYPE)
        IS
            SELECT OO.Order_Id, oo.order_status_id, oo.task_type_id
              FROM OR_ORDER_ACTIVITY OOA, OR_ORDER OO
             WHERE     OO.Task_Type_Id IN
                           (SELECT to_number(regexp_substr(sbCod_Tip_Tra_Rp_Sus,
											 '[^,]+',
											 1,
											 LEVEL)) AS COD_TIP_TRA_RP_SUS
							FROM dual
							CONNECT BY regexp_substr(sbCod_Tip_Tra_Rp_Sus, '[^,]+', 1, LEVEL) IS NOT NULL)
                   AND oo.order_id = ooa.order_id
                   AND oo.order_status_id IN
                           (SELECT to_number(regexp_substr(sbCod_Est_Ord_Rp_Sus,
											 '[^,]+',
											 1,
											 LEVEL)) AS COD_EST_ORD_RP_SUS
							FROM dual
							CONNECT BY regexp_substr(sbCod_Est_Ord_Rp_Sus, '[^,]+', 1, LEVEL) IS NOT NULL)
                   AND ooa.product_id = nuproduct_idCAR;

        RFCUOTSUS_RP_SIN_LEG        CUOTSUS_RP_SIN_LEG%ROWTYPE;

        --******FIN CURSOR PARA BUSCAR LA ORDENES DE RP DE SUSPENSION SIN LEGEALIZAREN CUANDO LA ORDEN A LEGALIZAR SEA UAN ORDEN DE CARTERA

        --FIN AREA RP

        --INICIO AREA CARTERA
        --******INICIO CURSOR PARA VALIDAR TIPO DE TRABAJO EXISTE EN PARAMETRO DE CARTERA
        CURSOR CUEXISTECARTERA (
            NUOR_ORDER_ACTIVITY   OR_ORDER_ACTIVITY.TASK_TYPE_ID%TYPE)
        IS
            SELECT COUNT (1)     CANTIDAD
              FROM DUAL
             WHERE NUOR_ORDER_ACTIVITY IN
                       (SELECT to_number(regexp_substr(sbCod_Tip_Tra_Car_Sus,
										 '[^,]+',
										 1,
										 LEVEL)) AS COD_TIP_TRA_CAR_SUS
						FROM dual
						CONNECT BY regexp_substr(sbCod_Tip_Tra_Car_Sus, '[^,]+', 1, LEVEL) IS NOT NULL);

        NUCANTIDADCARTERA           NUMBER;

        --******FIN CURSOR PARA VALIDAR TIPO DE TRABAJO EXISTE EN PARAMETRO

        --******INICIO CURSOR PARA BUSCAR LA ORDENES DE CARTERA DE SUSPENSION SIN LEGEALIZAREN CUANDO LA ORDEN A LEGALIZAR SEA UAN ORDEN DE RP
        CURSOR CUOTSUS_CARTERA_SIN_LEG (
            nuproduct_id   pr_product.product_id%TYPE)
        IS
            SELECT OO.Order_Id, oo.order_status_id, oo.task_type_id
              FROM OR_ORDER_ACTIVITY OOA, OR_ORDER OO
             WHERE     OO.Task_Type_Id IN
                           (SELECT to_number(regexp_substr(sbCod_Tip_Tra_Car_Sus,
											 '[^,]+',
											 1,
											 LEVEL)) AS COD_TIP_TRA_CAR_SUS
							FROM dual
							CONNECT BY regexp_substr(sbCod_Tip_Tra_Car_Sus, '[^,]+', 1, LEVEL) IS NOT NULL)
                   AND oo.order_id = ooa.order_id
                   AND oo.order_status_id IN
                           (SELECT to_number(regexp_substr(sbCod_Est_Ord_Car_Sus,
											 '[^,]+',
											 1,
											 LEVEL)) AS COD_EST_ORD_CAR_SUS
							FROM dual
							CONNECT BY regexp_substr(sbCod_Est_Ord_Car_Sus, '[^,]+', 1, LEVEL) IS NOT NULL)
                   AND ooa.product_id = nuproduct_id;

        RFCUOTSUS_CARTERA_SIN_LEG   CUOTSUS_CARTERA_SIN_LEG%ROWTYPE;


        --******FIN CURSOR PARA BUSCAR LA ORDENES DE CARTERA DE SUSPENSION SIN LEGEALIZAREN CUANDO LA ORDEN A LEGALIZAR SEA UAN ORDEN DE RP

        --******INICIO CURSOR PARA VALIDAR TIPO DE TRABAJO DE CARTERA QUE PERMITE REALIZAR CAMBIO DE ESTADO DE CORTE
        CURSOR CUEXISTETTCAMBIOEC (
            NUOR_ORDER_ACTIVITY   OR_ORDER_ACTIVITY.TASK_TYPE_ID%TYPE)
        IS
            SELECT COUNT (1)     CANTIDAD
              FROM DUAL
             WHERE NUOR_ORDER_ACTIVITY IN
                       (SELECT to_number(regexp_substr(sbCod_Tip_Tra_Car_Cam_Con,
										 '[^,]+',
										 1,
										 LEVEL)) AS COD_TIP_TRA_CAR_CAM_CON
						FROM dual
						CONNECT BY regexp_substr(sbCod_Tip_Tra_Car_Cam_Con, '[^,]+', 1, LEVEL) IS NOT NULL);

        RFCUEXISTETTCAMBIOEC        CUEXISTETTCAMBIOEC%ROWTYPE;
        --******INICIO CURSOR PARA VALIDAR TIPO DE TRABAJO EXISTE EN PARAMETRO DE CARTERA
        --FIN AREA CARTERA


        --INICIO VARIABLES
        NUOPERATING_UNIT_ID         NUMBER
            := DALD_PARAMETER.fnuGetNumeric_Value (
                   'COD_UNIOPE_SUS_RP_CARTERA',
                   NULL);                                              --1886;
        NUCAULEG                    NUMBER
            := DALD_PARAMETER.fnuGetNumeric_Value (
                   'COD_CAULEG_SUS_RP_CARTERA',
                   NULL);                                              --3264;
        NUCAULEGV                   NUMBER := NUCAULEG;                --3264;
        NUPERSONID                  NUMBER
                                        := ge_bopersonal.fnuGetPersonId; --1;
        onuerrorcode                NUMBER;
        osberrormessage             VARCHAR2 (4000);
        
        --FIN VARIABLES

        --Inicio Variables Errores
        EX_ERROR                    EXCEPTION;
        SBMENSAJE                   VARCHAR2 (2000);
        SBERRORMESSAGE              VARCHAR2 (4000);
		nuerrorcode					ge_message.message_id%type;
        --Fin Variables

        nuCausalAnu                 NUMBER
            := dald_parameter.fnuGetNumeric_Value ('ANNUL_CAUSAL ', NULL); --TICKET 200-2440 ELAL -- se almacena causal de anulacion
        cnuCommentType     CONSTANT NUMBER := 83; --TICKET 200-2440 ELAL -- se almacena tipo de comentario

        nuFlag                      NUMBER;
        inuCommentType              NUMBER (4) := 1296;
        isbComment                  VARCHAR2 (2000)
            := 'DESBLOQUEO - PROENCOLAMIENTOCARTRP';

        nuCodigoError               NUMBER (15);
        sbMensajeError              VARCHAR2 (2000);

        sbEntrega                   VARCHAR2 (2000) := 'OSS_OL_0000194_1';

        --INICIO CA 470
        nuUnidadcartera             NUMBER
            := dald_parameter.fnuGetNumeric_Value (
                   'COD_UNIDA_CARTERA_ENCOLAMIENTO',
                   NULL);
        sbTipoTrabCart              VARCHAR2 (4000)
            := DALD_PARAMETER.FSBGETVALUE_CHAIN (
                   'TIPO_TRAB_SUSPENSION_CARTERA',
                   NULL);
        nuPersoLegaSusp             NUMBER
            := dald_parameter.fnuGetNumeric_Value ('PERID_GEN_CIOR', NULL);
        sbExiste                    VARCHAR2 (1);
        sbestaOrdecart              VARCHAR2 (400)
            := DALD_PARAMETER.FSBGETVALUE_CHAIN ('COD_EST_ORD_CAR_SUS', NULL);


        ---263
        sbCausalXTitr               ld_parameter.value_chain%TYPE
            := DALD_PARAMETER.FSBGETVALUE_CHAIN (
                   'TITR_CAUSAL_ENCOLAMIENTO',
                   NULL);
        nuCausal                    ge_causal.causal_id%TYPE;
        sbTipoTrabCalidad           ld_parameter.value_chain%TYPE
            := DALD_PARAMETER.FSBGETVALUE_CHAIN (
                   'TITR_SUSPENSION_CALIDAD_MEDI',
                   NULL);
        nuUnidadCalidad             ld_parameter.numeric_value%TYPE
            := DALD_PARAMETER.fnuGetNumeric_Value (
                   'COD_UNIDAD_CALIDMED',
                   NULL);
        nuPersona                   ld_parameter.numeric_value%TYPE
            := DALD_PARAMETER.fnuGetNumeric_Value (
                   'COD_PERSONA_CALIDMED',
                   NULL);

        --263

        CURSOR cuValidacausal IS
            SELECT 'X'
              FROM GE_CAUSAL
             WHERE     CAUSAL_TYPE_ID = 18
                   AND CLASS_CAUSAL_ID = 2
                   AND CAUSAL_ID = NUCAULEG;

        CURSOR CUOTSUS_CARTERA_SIN_LEGA (
            nuproduct_id   pr_product.product_id%TYPE)
        IS
            SELECT OO.Order_Id,
                   oo.order_status_id,
                   oo.task_type_id,
                   oo.operating_unit_id
              FROM OR_ORDER_ACTIVITY OOA, OR_ORDER OO
             WHERE     OO.Task_Type_Id IN
                           (    SELECT TO_NUMBER (
                                           REGEXP_SUBSTR (
                                               sbTipoTrabCart,
                                               '[^,]+',
                                               1,
                                               LEVEL))    AS tipotrab
                                  FROM DUAL
                            CONNECT BY REGEXP_SUBSTR (sbTipoTrabCart,
                                                      '[^,]+',
                                                      1,
                                                      LEVEL)
                                           IS NOT NULL)
                   AND oo.order_id = ooa.order_id
                   AND oo.order_status_id IN
                           (    SELECT TO_NUMBER (
                                           REGEXP_SUBSTR (
                                               sbestaOrdecart,
                                               '[^,]+',
                                               1,
                                               LEVEL))    AS estado
                                  FROM DUAL
                            CONNECT BY REGEXP_SUBSTR (sbestaOrdecart,
                                                      '[^,]+',
                                                      1,
                                                      LEVEL)
                                           IS NOT NULL)
                   AND ooa.product_id = nuproduct_id;

        RFCUOTSUS_CARTERA_SIN_LEG   CUOTSUS_CARTERA_SIN_LEGA%ROWTYPE;
        RCORDER                     DAOR_ORDER.STYOR_ORDER; -- se almacena registro de la orden de trabajo
        RCORDERNULL                 DAOR_ORDER.STYOR_ORDER; -- se almacena registro de la orden de trabajo

        regOrden                    DAOR_ORDER.STYOR_ORDER; -- se almacena registro de la orden de trabajo
        nuasignarorden              NUMBER;

        CURSOR cugetpersonalegacart IS
            SELECT person_id
              FROM or_oper_unit_persons
             WHERE operating_unit_id = nuUnidadcartera;

        nuPersonaLega               NUMBER;

        CURSOR CUEXISTEORDCARTERA (
            NUOR_ORDER_ACTIVITY   OR_ORDER_ACTIVITY.TASK_TYPE_ID%TYPE)
        IS
            SELECT COUNT (1)     CANTIDAD
              FROM DUAL
             WHERE NUOR_ORDER_ACTIVITY IN
                       (    SELECT TO_NUMBER (
                                       REGEXP_SUBSTR (
                                           sbTipoTrabCart,
                                           '[^,]+',
                                           1,
                                           LEVEL))    AS tipotrab
                              FROM DUAL
                        CONNECT BY REGEXP_SUBSTR (sbTipoTrabCart,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL)
                                       IS NOT NULL);


        --FIN CA 470

        --263
        CURSOR cuCausalXtitr (nuTitr NUMBER)
        IS
            SELECT TO_NUMBER (
                       SUBSTR (COLUMN_VALUE, INSTR (COLUMN_VALUE, ';') + 1))    causal
              FROM TABLE (LDC_BOUTILITIES.SPLITSTRINGS (sbCausalXTitr, '|'))
             WHERE TO_NUMBER (
                       SUBSTR (COLUMN_VALUE,
                               0,
                               INSTR (COLUMN_VALUE, ';') - 1)) =
                   nuTitr;


        CURSOR CUOTSUS_CALIMED_SIN_LEGA (
            nuproduct_id   pr_product.product_id%TYPE)
        IS
            SELECT OO.Order_Id,
                   oo.order_status_id,
                   oo.task_type_id,
                   oo.operating_unit_id
              FROM OR_ORDER_ACTIVITY OOA, OR_ORDER OO
             WHERE     OO.Task_Type_Id IN
                           (    SELECT TO_NUMBER (
                                           REGEXP_SUBSTR (
                                               sbTipoTrabCalidad,
                                               '[^,]+',
                                               1,
                                               LEVEL))    AS tipotrab
                                  FROM DUAL
                            CONNECT BY REGEXP_SUBSTR (sbTipoTrabCalidad,
                                                      '[^,]+',
                                                      1,
                                                      LEVEL)
                                           IS NOT NULL)
                   AND oo.order_id = ooa.order_id
                   AND oo.order_status_id IN
                           (    SELECT TO_NUMBER (
                                           REGEXP_SUBSTR (
                                               sbestaOrdecart,
                                               '[^,]+',
                                               1,
                                               LEVEL))    AS estado
                                  FROM DUAL
                            CONNECT BY REGEXP_SUBSTR (sbestaOrdecart,
                                                      '[^,]+',
                                                      1,
                                                      LEVEL)
                                           IS NOT NULL)
                   AND ooa.product_id = nuproduct_id;

        CURSOR CUEXISTEORDCALIDAD (
            NUOR_ORDER_ACTIVITY   OR_ORDER_ACTIVITY.TASK_TYPE_ID%TYPE)
        IS
            SELECT COUNT (1)     CANTIDAD
              FROM DUAL
             WHERE NUOR_ORDER_ACTIVITY IN
                       (    SELECT TO_NUMBER (
                                       REGEXP_SUBSTR (
                                           sbTipoTrabCalidad,
                                           '[^,]+',
                                           1,
                                           LEVEL))    AS tipotrab
                              FROM DUAL
                        CONNECT BY REGEXP_SUBSTR (sbTipoTrabCalidad,
                                                  '[^,]+',
                                                  1,
                                                  LEVEL)
                                       IS NOT NULL);
    BEGIN
        UT_TRACE.TRACE ('INICIO LDC_PKORDENES.PROENCOLAMIENTOCARTRP', 10);

        nuPersonaLega := pkg_parametros.fnuGetValorNumerico('PERSONA_LEGALIZA_CARTERA');

        --ORDEN DE LA INSTANCIA
        NUORDENINSTANCIA := OR_BOLEGALIZEORDER.FNUGETCURRENTORDER;
        UT_TRACE.TRACE ('ORDEN A LEGALIZAR[' || NUORDENINSTANCIA || ']', 10);

        IF (CUOBTENERDATOSOT%ISOPEN) THEN
            CLOSE CUOBTENERDATOSOT;
        END IF;

        --OBTIENE DATOS DE LA ORDEN DE LA INSTANCIA
        OPEN CUOBTENERDATOSOT (NUORDENINSTANCIA);
        FETCH CUOBTENERDATOSOT INTO RFCUOBTENERDATOSOT;
        CLOSE CUOBTENERDATOSOT;

        --INICIO IDENTIFICA SI EL TIPO DE TRABAJO DE LA ORDEN A LEGALIZAR ES DE RP
        UT_TRACE.TRACE (
            'TIPO DE TRABAJO ['
        || RFCUOBTENERDATOSOT.TT
        || '] A COMPARAR CON EL PARAMETRO COD_TIP_TRA_RP_SUS Y VALIDAR SI ES DE RP',
        10);

        --INICIO CA 470

        IF (CUEXISTERP%ISOPEN) THEN
            CLOSE CUEXISTERP;
        END IF;

        OPEN CUEXISTERP (RFCUOBTENERDATOSOT.TT);
        FETCH CUEXISTERP INTO NUCANTIDADRP;
        CLOSE CUEXISTERP;

            --VALIDA SI LA CANTIDAD ES MAYOR A 0 INIDCANDO QUE LA ORDEN A LEGALIZAR
            --ES DE UNO DE LOS TIPO DE TRABAJO DE SUSPESION DE RP
            --CONFIGURADOS EN EL PAREMTRO COD_TIP_TRA_RP_SUS.
            IF NUCANTIDADRP > 0 THEN
                --INICIO RP
                --INICIO OBTIENE LAS ORDENES DE CARTERA POR SUSPENSION SIN LEGALIZAR
                FOR RFCUOTSUS_CARTERA_SIN_LEG
                    IN CUOTSUS_CARTERA_SIN_LEGA (RFCUOBTENERDATOSOT.PRODUCTO)
                LOOP
                    RCORDER := RCORDERNULL;
                    nuasignarorden := 0;
                    regOrden := RCORDERNULL;

                        IF (cuCausalXtitr%ISOPEN) THEN
                            CLOSE cuCausalXtitr;
                        END IF;

                        OPEN cuCausalXtitr (
                            RFCUOTSUS_CARTERA_SIN_LEG.task_type_id);
                        FETCH cuCausalXtitr INTO nuCausal;
                        CLOSE cuCausalXtitr;

                        IF nuCausal IS NOT NULL
                        THEN
                            NUCAULEG := nuCausal;
                        ELSE
                            NUCAULEG := NUCAULEGV;
                        END IF;

                        IF cuValidacausal%ISOPEN
                        THEN
                            CLOSE cuValidacausal;
                        END IF;

                        OPEN cuValidacausal;

                        FETCH cuValidacausal INTO sbExiste;

                        IF cuValidacausal%NOTFOUND THEN
                            CLOSE cuValidacausal;

                            Pkg_Error.SetErrorMessage(
                                Ld_Boconstans.cnuGeneric_Error,
                                   'La causal '
                                || NUCAULEG
                                || 'configurada en los parametros COD_CAULEG_SUS_RP_CARTERA,TITR_CAUSAL_ENCOLAMIENTO no es de tipo 18 clase 2');
                        END IF;

                        CLOSE cuValidacausal;

                    --INICIO PROCESO DE ANULACION DE ORDEN CARTERA POR SUSPENSION
                    --se valida si la orden esta bloqueada
                    IF RFCUOTSUS_CARTERA_SIN_LEG.ORDER_STATUS_ID =
                       Or_BOConstants.CNUORDER_STAT_LOCK
                    THEN
                        RCORDER :=
                            DAOR_ORDER.FRCGETRECORD (
                                RFCUOTSUS_CARTERA_SIN_LEG.Order_Id);
                        RCORDER.ARRANGED_HOUR := NULL;

                        --se desasigna orden de trabajo
                        IF RCORDER.OPERATING_UNIT_ID IS NOT NULL
                        THEN
                            OR_BOPROCESSORDER.UNASSIGNORDER (RCORDER,
                                                             inuCommentType,
                                                             NULL,
                                                             NULL,
                                                             SYSDATE);
                        ELSE
						
							ut_trace.trace('Ingresa api_unlockorder inuOrderId: ' 			|| RFCUOTSUS_CARTERA_SIN_LEG.Order_Id || chr(10) ||
																   'inuTipoComentario: '	|| inuCommentType 	|| chr(10) ||
																   'isbComentario: ' 		|| isbComment 		|| chr(10) ||
																   'idtFechaCambio: ' 		|| SYSDATE, 8);
						
                            --  se hace llamado al proceso que desbloquea la orden
                            api_unlockorder(RFCUOTSUS_CARTERA_SIN_LEG.Order_Id,
											inuCommentType,
											isbComment,
											SYSDATE,
											nuerrorcode,
											sberrormessage
											);
											
							ut_trace.trace('Sale api_unlockorder nuerrorcode: ' 	|| nuerrorcode	|| chr(10) ||
																'sberrormessage: '	|| sberrormessage, 8);
											
						    IF nuerrorcode <> 0 THEN
								Pkg_Error.SetErrorMessage(nuerrorcode,
														  sberrormessage
														  );
                            END IF;
							
                        END IF;

                        --se consulta estado de la orden despues de desbloquear
                        regOrden :=
                            DAOR_ORDER.FRCGETRECORD (
                                RFCUOTSUS_CARTERA_SIN_LEG.Order_Id);

                        --si esta asignada a una unidad diferente se reasiugna
                        IF     regOrden.order_status_id =
                               Or_BOConstants.CNUORDER_STAT_ASSIGNED
                           AND regOrden.operating_unit_id <> nuUnidadcartera
                        THEN
                            --se reasigna orden de trabajo
                            OR_BOPROCESSORDER.TOREASSIGN (
                                regOrden,
                                SYSDATE,
                                inuCommentType,
                                'REASIGNACION POR PROCESO PROENCOLAMIENTOCARTRP',
                                nuUnidadcartera);
                        ELSE
                            IF regOrden.order_status_id =
                               Or_BOConstants.CNUORDER_STAT_REGISTERED
                            THEN
                                nuasignarorden := 1;
                            END IF;
                        END IF;
                    ELSIF RFCUOTSUS_CARTERA_SIN_LEG.ORDER_STATUS_ID =
                          Or_BOConstants.CNUORDER_STAT_REGISTERED
                    THEN
                        nuasignarorden := 1;
                    END IF;

                    --se asigna orden de trabajo
                    IF nuasignarorden = 1
                    THEN
					
						ut_trace.trace('ingresa api_assign_order nuOrden: ' || RFCUOTSUS_CARTERA_SIN_LEG.order_id || CHR(10) ||
											'inuOperatingUnit: ' || nuUnidadcartera, 6);
						
                        api_assign_order(RFCUOTSUS_CARTERA_SIN_LEG.order_id,
                                         nuUnidadcartera,
                                         nuCodigoError,
                                         sbMensajeError);
										 
						ut_trace.trace('Finaliza api_assign_order nuerrorcode: ' || nuCodigoError || CHR(10) ||
																	 'sberrormessage: ' || sbMensajeError, 6);

                        IF nuCodigoError <> 0
                        THEN
                            Pkg_Error.SetErrorMessage(
                                Ld_Boconstans.cnuGeneric_Error,
                                sbMensajeError);
                        END IF;
                    END IF;

                    IF nuPersonaLega IS NULL
                    THEN
                        Pkg_Error.SetErrorMessage(
                            Ld_Boconstans.cnuGeneric_Error,
                            'El parametro de la persona para encolamiento de cartera esta vacio');
                    END IF;

                    --se inserta para legalizar en job
                    INSERT INTO LDC_ORDEASIGPROC (ORAPORPA,
                                                  ORAPSOGE,
                                                  ORAOPELE,
                                                  ORAOUNID,
                                                  ORAOCALE,
                                                  ORAOPROC)
                         VALUES (NUORDENINSTANCIA,
                                 RFCUOTSUS_CARTERA_SIN_LEG.order_id,
                                 nuPersonaLega,
                                 nuUnidadcartera,
                                 NUCAULEG,
                                 'ENCOCARTRP');
                END LOOP;

                --FIN RP

                    FOR REGCALI
                        IN CUOTSUS_CALIMED_SIN_LEGA (
                               RFCUOBTENERDATOSOT.PRODUCTO)
                    LOOP
                        RCORDER := RCORDERNULL;
                        nuasignarorden := 0;
                        regOrden := RCORDERNULL;

                            IF (cuCausalXtitr%ISOPEN) THEN
                                CLOSE cuCausalXtitr;
                            END IF;

                            OPEN cuCausalXtitr (REGCALI.task_type_id);
                            FETCH cuCausalXtitr INTO nuCausal;
                            CLOSE cuCausalXtitr;

                            IF nuCausal IS NOT NULL
                            THEN
                                NUCAULEG := nuCausal;
                            ELSE
                                NUCAULEG := NUCAULEGV;
                            END IF;

                            IF cuValidacausal%ISOPEN
                            THEN
                                CLOSE cuValidacausal;
                            END IF;

                            OPEN cuValidacausal;

                            FETCH cuValidacausal INTO sbExiste;

                            IF cuValidacausal%NOTFOUND
                            THEN
                                CLOSE cuValidacausal;

                                Pkg_Error.SetErrorMessage(
                                    Ld_Boconstans.cnuGeneric_Error,
                                       'La causal '
                                    || NUCAULEG
                                    || 'configurada en los parametros COD_CAULEG_SUS_RP_CARTERA,TITR_CAUSAL_ENCOLAMIENTO no es de tipo 18 clase 2');
                            END IF;

                            CLOSE cuValidacausal;

                        --INICIO PROCESO DE ANULACION DE ORDEN CARTERA POR SUSPENSION
                        --se valida si la orden esta bloqueada
                        IF REGCALI.ORDER_STATUS_ID =
                           Or_BOConstants.CNUORDER_STAT_LOCK
                        THEN
                            RCORDER :=
                                DAOR_ORDER.FRCGETRECORD (REGCALI.Order_Id);
                            RCORDER.ARRANGED_HOUR := NULL;

                            --se desasigna orden de trabajo
                            IF RCORDER.OPERATING_UNIT_ID IS NOT NULL
                            THEN
                                OR_BOPROCESSORDER.UNASSIGNORDER (
                                    RCORDER,
                                    inuCommentType,
                                    NULL,
                                    NULL,
                                    SYSDATE);
                            ELSE
							
							ut_trace.trace('Ingresa api_unlockorder inuOrderId: ' 			|| REGCALI.Order_Id || chr(10) ||
																   'inuTipoComentario: '	|| inuCommentType 	|| chr(10) ||
																   'isbComentario: ' 		|| isbComment 		|| chr(10) ||
																   'idtFechaCambio: ' 		|| SYSDATE, 8);
							
                                --  se hace llamado al proceso que desbloquea la orden
                                api_unlockorder(REGCALI.Order_Id,
												inuCommentType,
												isbComment,
												SYSDATE,
												nuerrorcode,
												sberrormessage
												);
												
								ut_trace.trace('Sale api_unlockorder nuerrorcode: ' 	|| nuerrorcode	|| chr(10) ||
																    'sberrormessage: '	|| sberrormessage, 8);
											
								IF nuerrorcode <> 0 THEN
									Pkg_Error.SetErrorMessage(nuerrorcode,
															  sberrormessage
														     );
								END IF;
                            END IF;

                            --se consulta estado de la orden despues de desbloquear
                            regOrden :=
                                DAOR_ORDER.FRCGETRECORD (REGCALI.Order_Id);

                            --si esta asignada a una unidad diferente se reasiugna
                            IF     regOrden.order_status_id =
                                   Or_BOConstants.CNUORDER_STAT_ASSIGNED
                               AND regOrden.operating_unit_id <>
                                   nuUnidadCalidad
                            THEN
                                --se reasigna orden de trabajo
                                OR_BOPROCESSORDER.TOREASSIGN (
                                    regOrden,
                                    SYSDATE,
                                    inuCommentType,
                                    'REASIGNACION POR PROCESO PROENCOLAMIENTOCARTRP',
                                    nuUnidadCalidad);
                            ELSE
                                IF regOrden.order_status_id =
                                   Or_BOConstants.CNUORDER_STAT_REGISTERED
                                THEN
                                    nuasignarorden := 1;
                                END IF;
                            END IF;
                        ELSIF REGCALI.ORDER_STATUS_ID =
                              Or_BOConstants.CNUORDER_STAT_REGISTERED
                        THEN
                            nuasignarorden := 1;
                        END IF;

                        --se asigna orden de trabajo
                        IF nuasignarorden = 1
                        THEN
						
							ut_trace.trace('ingresa  api_assign_order nuOrden: ' || REGCALI.order_id || CHR(10) ||
											'inuOperatingUnit: ' || nuUnidadCalidad, 6);
						
                            api_assign_order(REGCALI.order_id,
                                             nuUnidadCalidad,
                                             nuCodigoError,
                                             sbMensajeError);
											 
							ut_trace.trace('Finaliza api_assign_order nuerrorcode: ' || nuCodigoError || CHR(10) ||
																	 'sberrormessage: ' || sbMensajeError, 6);

                            IF nuCodigoError <> 0
                            THEN
                                Pkg_Error.SetErrorMessage(
                                    Ld_Boconstans.cnuGeneric_Error,
                                    sbMensajeError);
                            END IF;
                        END IF;


                        IF nuPersona IS NULL
                        THEN
                            Pkg_Error.SetErrorMessage(
                                Ld_Boconstans.cnuGeneric_Error,
                                'El parametro de la persona para encolamiento de calidad de la medicion esta vacio');
                        END IF;

                        --se inserta para legalizar en job
                        INSERT INTO LDC_ORDEASIGPROC (ORAPORPA,
                                                      ORAPSOGE,
                                                      ORAOPELE,
                                                      ORAOUNID,
                                                      ORAOCALE,
                                                      ORAOPROC)
                             VALUES (NUORDENINSTANCIA,
                                     REGCALI.order_id,
                                     nuPersona,
                                     nuUnidadcartera,
                                     NUCAULEG,
                                     'ENCOCARTRP');
                    END LOOP;
            --FIN RP
            ELSE

                IF (CUEXISTEORDCARTERA%ISOPEN) THEN
                    CLOSE CUEXISTEORDCARTERA;
                END IF;

                OPEN CUEXISTEORDCARTERA (RFCUOBTENERDATOSOT.TT);
                FETCH CUEXISTEORDCARTERA INTO NUCANTIDADCARTERA;
                CLOSE CUEXISTEORDCARTERA;

                IF NUCANTIDADCARTERA > 0
                THEN
                    FOR rfCUOTSUS_RP_SIN_LEG
                        IN CUOTSUS_RP_SIN_LEG (RFCUOBTENERDATOSOT.PRODUCTO)
                    LOOP
                        RCORDER := RCORDERNULL;
                        nuasignarorden := 0;
                        regOrden := RCORDERNULL;

                            IF (cuCausalXtitr%ISOPEN) THEN
                                CLOSE cuCausalXtitr;
                            END IF;

                            OPEN cuCausalXtitr (
                                rfCUOTSUS_RP_SIN_LEG.task_type_id);

                            FETCH cuCausalXtitr INTO nuCausal;

                            CLOSE cuCausalXtitr;

                            IF nuCausal IS NOT NULL
                            THEN
                                NUCAULEG := nuCausal;
                            ELSE
                                NUCAULEG := NUCAULEGV;
                            END IF;

                            IF cuValidacausal%ISOPEN
                            THEN
                                CLOSE cuValidacausal;
                            END IF;

                            OPEN cuValidacausal;

                            FETCH cuValidacausal INTO sbExiste;

                            IF cuValidacausal%NOTFOUND
                            THEN
                                CLOSE cuValidacausal;

                                Pkg_Error.SetErrorMessage(
                                    Ld_Boconstans.cnuGeneric_Error,
                                       'La causal '
                                    || NUCAULEG
                                    || 'configurada en los parametros COD_CAULEG_SUS_RP_CARTERA,TITR_CAUSAL_ENCOLAMIENTO no es de tipo 18 clase 2');
                            END IF;

                            CLOSE cuValidacausal;

                        --se valida si la orden esta bloqueada
                        IF rfCUOTSUS_RP_SIN_LEG.ORDER_STATUS_ID =
                           Or_BOConstants.CNUORDER_STAT_LOCK
                        THEN
                            RCORDER :=
                                DAOR_ORDER.FRCGETRECORD (
                                    rfCUOTSUS_RP_SIN_LEG.Order_Id);
                            RCORDER.ARRANGED_HOUR := NULL;

                            --se desasigna orden de trabajo
                            IF RCORDER.OPERATING_UNIT_ID IS NOT NULL
                            THEN
                                OR_BOPROCESSORDER.UNASSIGNORDER (
                                    RCORDER,
                                    inuCommentType,
                                    NULL,
                                    NULL,
                                    SYSDATE);
                            ELSE
							
								ut_trace.trace('Ingresa api_unlockorder inuOrderId: ' 		|| rfCUOTSUS_RP_SIN_LEG.Order_Id || chr(10) ||
																   'inuTipoComentario: '	|| inuCommentType 	|| chr(10) ||
																   'isbComentario: ' 		|| isbComment 		|| chr(10) ||
																   'idtFechaCambio: ' 		|| SYSDATE, 8);
							
                                --  se hace llamado al proceso que desbloquea la orden
                                api_unlockorder(rfCUOTSUS_RP_SIN_LEG.Order_Id,
												inuCommentType,
												isbComment,
												SYSDATE,
												nuerrorcode,
												sberrormessage
												);
															  
								ut_trace.trace('Sale api_unlockorder nuerrorcode: ' 	|| nuerrorcode	|| chr(10) ||
																    'sberrormessage: '	|| sberrormessage, 8);
											
								IF nuerrorcode <> 0 THEN
									Pkg_Error.SetErrorMessage(nuerrorcode,
															  sberrormessage
															  );
								END IF;
								
                            END IF;

                            --se consulta estado de la orden despues de desbloquear
                            regOrden :=
                                DAOR_ORDER.FRCGETRECORD (
                                    rfCUOTSUS_RP_SIN_LEG.Order_Id);

                            --si esta asignada a una unidad diferente se reasiugna
                            IF     regOrden.order_status_id =
                                   Or_BOConstants.CNUORDER_STAT_ASSIGNED
                               AND regOrden.operating_unit_id <>
                                   NUOPERATING_UNIT_ID
                            THEN
                                --se reasigna orden de trabajo
                                OR_BOPROCESSORDER.TOREASSIGN (
                                    regOrden,
                                    SYSDATE,
                                    inuCommentType,
                                    'REASIGNACION POR PROCESO PROENCOLAMIENTOCARTRP',
                                    NUOPERATING_UNIT_ID);
                            ELSE
                                IF regOrden.order_status_id =
                                   Or_BOConstants.CNUORDER_STAT_REGISTERED
                                THEN
                                    nuasignarorden := 1;
                                END IF;
                            END IF;
                        ELSIF rfCUOTSUS_RP_SIN_LEG.ORDER_STATUS_ID =
                              Or_BOConstants.CNUORDER_STAT_REGISTERED
                        THEN
                            nuasignarorden := 1;
                        END IF;

                        --se asigna orden de trabajo
                        IF nuasignarorden = 1
                        THEN
						
							ut_trace.trace('ingresa api_assign_order nuOrden: ' || rfCUOTSUS_RP_SIN_LEG.order_id || CHR(10) ||
											'inuOperatingUnit: ' || NUOPERATING_UNIT_ID, 6);
						
                            api_assign_order(rfCUOTSUS_RP_SIN_LEG.order_id,
                                             NUOPERATING_UNIT_ID,
                                             nuCodigoError,
                                             sbMensajeError);
											 
							ut_trace.trace('Finaliza api_assign_order nuerrorcode: ' || nuCodigoError || CHR(10) ||
																	 'sberrormessage: ' || sbMensajeError, 6);

                            IF nuCodigoError <> 0
                            THEN
                                Pkg_Error.SetErrorMessage(
                                    Ld_Boconstans.cnuGeneric_Error,
                                    sbMensajeError);
                            END IF;
                        END IF;

                        --se inserta para legalizar en job
                        INSERT INTO LDC_ORDEASIGPROC (ORAPORPA,
                                                      ORAPSOGE,
                                                      ORAOPELE,
                                                      ORAOUNID,
                                                      ORAOCALE,
                                                      ORAOPROC)
                             VALUES (NUORDENINSTANCIA,
                                     rfCUOTSUS_RP_SIN_LEG.order_id,
                                     nuPersoLegaSusp,
                                     NUOPERATING_UNIT_ID,
                                     NUCAULEG,
                                     'ENCOCARTRP');
                    END LOOP;

                        FOR REGCALI
                            IN CUOTSUS_CALIMED_SIN_LEGA (
                                   RFCUOBTENERDATOSOT.PRODUCTO)
                        LOOP

                                IF (cuCausalXtitr%ISOPEN) THEN
                                    CLOSE cuCausalXtitr;
                                END IF;

                                OPEN cuCausalXtitr (REGCALI.task_type_id);

                                FETCH cuCausalXtitr INTO nuCausal;

                                CLOSE cuCausalXtitr;

                                IF nuCausal IS NOT NULL
                                THEN
                                    NUCAULEG := nuCausal;
                                ELSE
                                    NUCAULEG := NUCAULEGV;
                                END IF;

                                IF cuValidacausal%ISOPEN
                                THEN
                                    CLOSE cuValidacausal;
                                END IF;

                                OPEN cuValidacausal;

                                FETCH cuValidacausal INTO sbExiste;

                                IF cuValidacausal%NOTFOUND
                                THEN
                                    CLOSE cuValidacausal;

                                    Pkg_Error.SetErrorMessage(
                                        Ld_Boconstans.cnuGeneric_Error,
                                           'La causal '
                                        || NUCAULEG
                                        || 'configurada en los parametros COD_CAULEG_SUS_RP_CARTERA,TITR_CAUSAL_ENCOLAMIENTO no es de tipo 18 clase 2');
                                END IF;

                                CLOSE cuValidacausal;

                            RCORDER := RCORDERNULL;
                            nuasignarorden := 0;
                            regOrden := RCORDERNULL;

                            --INICIO PROCESO DE ANULACION DE ORDEN CARTERA POR SUSPENSION
                            --se valida si la orden esta bloqueada
                            IF REGCALI.ORDER_STATUS_ID =
                               Or_BOConstants.CNUORDER_STAT_LOCK
                            THEN
                                RCORDER :=
                                    DAOR_ORDER.FRCGETRECORD (
                                        REGCALI.Order_Id);
                                RCORDER.ARRANGED_HOUR := NULL;

                                --se desasigna orden de trabajo
                                IF RCORDER.OPERATING_UNIT_ID IS NOT NULL
                                THEN
                                    OR_BOPROCESSORDER.UNASSIGNORDER (
                                        RCORDER,
                                        inuCommentType,
                                        NULL,
                                        NULL,
                                        SYSDATE);
                                ELSE
								
									ut_trace.trace('Ingresa api_unlockorder inuOrderId: ' 	|| REGCALI.Order_Id || chr(10) ||
																   'inuTipoComentario: '	|| inuCommentType 	|| chr(10) ||
																   'isbComentario: ' 		|| isbComment 		|| chr(10) ||
																   'idtFechaCambio: ' 		|| SYSDATE, 8);
								
                                    --  se hace llamado al proceso que desbloquea la orden
                                    api_unlockorder(REGCALI.Order_Id,
													inuCommentType,
													isbComment,
													SYSDATE,
													nuerrorcode,
													sberrormessage
													);
													
									ut_trace.trace('Sale api_unlockorder nuerrorcode: ' 	|| nuerrorcode	|| chr(10) ||
																		'sberrormessage: '	|| sberrormessage, 8);
											
									IF nuerrorcode <> 0 THEN
										Pkg_Error.SetErrorMessage(nuerrorcode,
																  sberrormessage
																  );
									END IF;
									
                                END IF;

                                --se consulta estado de la orden despues de desbloquear
                                regOrden :=
                                    DAOR_ORDER.FRCGETRECORD (
                                        REGCALI.Order_Id);

                                --si esta asignada a una unidad diferente se reasiugna
                                IF     regOrden.order_status_id =
                                       Or_BOConstants.CNUORDER_STAT_ASSIGNED
                                   AND regOrden.operating_unit_id <>
                                       nuUnidadCalidad
                                THEN
                                    --se reasigna orden de trabajo
                                    OR_BOPROCESSORDER.TOREASSIGN (
                                        regOrden,
                                        SYSDATE,
                                        inuCommentType,
                                        'REASIGNACION POR PROCESO PROENCOLAMIENTOCARTRP',
                                        nuUnidadCalidad);
                                ELSE
                                    IF regOrden.order_status_id =
                                       Or_BOConstants.CNUORDER_STAT_REGISTERED
                                    THEN
                                        nuasignarorden := 1;
                                    END IF;
                                END IF;
                            ELSIF REGCALI.ORDER_STATUS_ID =
                                  Or_BOConstants.CNUORDER_STAT_REGISTERED
                            THEN
                                nuasignarorden := 1;
                            END IF;

                            --se asigna orden de trabajo
                            IF nuasignarorden = 1
                            THEN
							
								ut_trace.trace('ingresa api_assign_order nuOrden: ' || REGCALI.order_id || CHR(10) ||
																		'inuOperatingUnit: ' || nuUnidadCalidad, 6);
							
                                api_assign_order(REGCALI.order_id,
                                                 nuUnidadCalidad,
                                                 nuCodigoError,
                                                 sbMensajeError);
												 
								ut_trace.trace('Finaliza api_assign_order nuerrorcode: ' || nuCodigoError || CHR(10) ||
																	 'sberrormessage: ' || sbMensajeError, 6);

                                IF nuCodigoError <> 0
                                THEN
                                    Pkg_Error.SetErrorMessage(
                                        Ld_Boconstans.cnuGeneric_Error,
                                        sbMensajeError);
                                END IF;
                            END IF;


                            IF nuPersona IS NULL
                            THEN
                                Pkg_Error.SetErrorMessage(
                                    Ld_Boconstans.cnuGeneric_Error,
                                    'El parametro de la persona para encolamiento de calidad de la medicion esta vacio');
                            END IF;

                            --se inserta para legalizar en job
                            INSERT INTO LDC_ORDEASIGPROC (ORAPORPA,
                                                          ORAPSOGE,
                                                          ORAOPELE,
                                                          ORAOUNID,
                                                          ORAOCALE,
                                                          ORAOPROC)
                                 VALUES (NUORDENINSTANCIA,
                                         REGCALI.order_id,
                                         nuPersona,
                                         nuUnidadcartera,
                                         NUCAULEG,
                                         'ENCOCARTRP');
                        END LOOP;
                ELSE
                        NUCANTIDADCARTERA := 0;

                        IF CUEXISTEORDCALIDAD%ISOPEN
                        THEN
                            CLOSE CUEXISTEORDCALIDAD;
                        END IF;

                        OPEN CUEXISTEORDCALIDAD (RFCUOBTENERDATOSOT.TT);
                        FETCH CUEXISTEORDCALIDAD INTO NUCANTIDADCARTERA;
                        CLOSE CUEXISTEORDCALIDAD;

                        IF NUCANTIDADCARTERA > 0
                        THEN
                            FOR rfCUOTSUS_RP_SIN_LEG
                                IN CUOTSUS_RP_SIN_LEG (
                                       RFCUOBTENERDATOSOT.PRODUCTO)
                            LOOP
                                RCORDER := RCORDERNULL;
                                nuasignarorden := 0;
                                regOrden := RCORDERNULL;


                                    IF cuCausalXtitr%ISOPEN
                                    THEN
                                        CLOSE cuCausalXtitr;
                                    END IF;

                                    OPEN cuCausalXtitr (
                                        rfCUOTSUS_RP_SIN_LEG.task_type_id);

                                    FETCH cuCausalXtitr INTO nuCausal;

                                    CLOSE cuCausalXtitr;

                                    IF nuCausal IS NOT NULL
                                    THEN
                                        NUCAULEG := nuCausal;
                                    ELSE
                                        NUCAULEG := NUCAULEGV;
                                    END IF;

                                    IF cuValidacausal%ISOPEN
                                    THEN
                                        CLOSE cuValidacausal;
                                    END IF;

                                    OPEN cuValidacausal;

                                    FETCH cuValidacausal INTO sbExiste;

                                    IF cuValidacausal%NOTFOUND
                                    THEN
                                        CLOSE cuValidacausal;

                                        Pkg_Error.SetErrorMessage(
                                            Ld_Boconstans.cnuGeneric_Error,
                                               'La causal '
                                            || NUCAULEG
                                            || 'configurada en los parametros COD_CAULEG_SUS_RP_CARTERA,TITR_CAUSAL_ENCOLAMIENTO no es de tipo 18 clase 2');
                                    END IF;

                                    CLOSE cuValidacausal;

                                --se valida si la orden esta bloqueada
                                IF rfCUOTSUS_RP_SIN_LEG.ORDER_STATUS_ID =
                                   Or_BOConstants.CNUORDER_STAT_LOCK
                                THEN
                                    RCORDER :=
                                        DAOR_ORDER.FRCGETRECORD (
                                            rfCUOTSUS_RP_SIN_LEG.Order_Id);
                                    RCORDER.ARRANGED_HOUR := NULL;

                                    --se desasigna orden de trabajo
                                    IF RCORDER.OPERATING_UNIT_ID IS NOT NULL
                                    THEN
                                        OR_BOPROCESSORDER.UNASSIGNORDER (
                                            RCORDER,
                                            inuCommentType,
                                            NULL,
                                            NULL,
                                            SYSDATE);
                                    ELSE
									
										ut_trace.trace('Ingresa api_unlockorder inuOrderId: '	|| rfCUOTSUS_RP_SIN_LEG.Order_Id || chr(10) ||
																   'inuTipoComentario: '	|| inuCommentType 	|| chr(10) ||
																   'isbComentario: ' 		|| isbComment 		|| chr(10) ||
																   'idtFechaCambio: ' 		|| SYSDATE, 8);
																   
                                        --  se hace llamado al proceso que desbloquea la orden
                                        api_unlockorder(rfCUOTSUS_RP_SIN_LEG.Order_Id,
														inuCommentType,
														isbComment,
														SYSDATE,
														nuerrorcode,
														sberrormessage
														);
														
										ut_trace.trace('Sale api_unlockorder nuerrorcode: ' 	|| nuerrorcode	|| chr(10) ||
																			'sberrormessage: '	|| sberrormessage, 8);
											
										IF nuerrorcode <> 0 THEN
											Pkg_Error.SetErrorMessage(nuerrorcode,
																	  sberrormessage
																	  );
										END IF;
										
                                    END IF;

                                    --se consulta estado de la orden despues de desbloquear
                                    regOrden :=
                                        DAOR_ORDER.FRCGETRECORD (
                                            rfCUOTSUS_RP_SIN_LEG.Order_Id);

                                    --si esta asignada a una unidad diferente se reasiugna
                                    IF     regOrden.order_status_id =
                                           Or_BOConstants.CNUORDER_STAT_ASSIGNED
                                       AND regOrden.operating_unit_id <>
                                           NUOPERATING_UNIT_ID
                                    THEN
                                        --se reasigna orden de trabajo
                                        OR_BOPROCESSORDER.TOREASSIGN (
                                            regOrden,
                                            SYSDATE,
                                            inuCommentType,
                                            'REASIGNACION POR PROCESO PROENCOLAMIENTOCARTRP',
                                            NUOPERATING_UNIT_ID);
                                    ELSE
                                        IF regOrden.order_status_id =
                                           Or_BOConstants.CNUORDER_STAT_REGISTERED
                                        THEN
                                            nuasignarorden := 1;
                                        END IF;
                                    END IF;
                                ELSIF rfCUOTSUS_RP_SIN_LEG.ORDER_STATUS_ID =
                                      Or_BOConstants.CNUORDER_STAT_REGISTERED
                                THEN
                                    nuasignarorden := 1;
                                END IF;

                                --se asigna orden de trabajo
                                IF nuasignarorden = 1
                                THEN
								
									ut_trace.trace('ingresa api_assign_order nuOrden: ' || rfCUOTSUS_RP_SIN_LEG.order_id || CHR(10) ||
																			'inuOperatingUnit: ' || NUOPERATING_UNIT_ID, 6);
								
                                    api_assign_order(rfCUOTSUS_RP_SIN_LEG.order_id,
													 NUOPERATING_UNIT_ID,
													 nuCodigoError,
													 sbMensajeError
													 );

									ut_trace.trace('Finaliza api_assign_order nuerrorcode: ' || nuCodigoError || CHR(10) ||
																	 'sberrormessage: ' || sbMensajeError, 6);

                                    IF nuCodigoError <> 0
                                    THEN
                                        Pkg_Error.SetErrorMessage(
                                            Ld_Boconstans.cnuGeneric_Error,
                                            sbMensajeError);
                                    END IF;
                                END IF;

                                --se inserta para legalizar en job
                                INSERT INTO LDC_ORDEASIGPROC (ORAPORPA,
                                                              ORAPSOGE,
                                                              ORAOPELE,
                                                              ORAOUNID,
                                                              ORAOCALE,
                                                              ORAOPROC)
                                     VALUES (NUORDENINSTANCIA,
                                             rfCUOTSUS_RP_SIN_LEG.order_id,
                                             nuPersoLegaSusp,
                                             NUOPERATING_UNIT_ID,
                                             NUCAULEG,
                                             'ENCOCARTRP');
                            END LOOP;

                            --INICIO OBTIENE LAS ORDENES DE CARTERA POR SUSPENSION SIN LEGALIZAR
                            FOR RFCUOTSUS_CARTERA_SIN_LEG
                                IN CUOTSUS_CARTERA_SIN_LEGA (
                                       RFCUOBTENERDATOSOT.PRODUCTO)
                            LOOP
                                RCORDER := RCORDERNULL;
                                nuasignarorden := 0;
                                regOrden := RCORDERNULL;

                                    IF cuCausalXtitr%ISOPEN
                                    THEN
                                        CLOSE cuCausalXtitr;
                                    END IF;

                                    OPEN cuCausalXtitr (
                                        RFCUOTSUS_CARTERA_SIN_LEG.task_type_id);
                                    FETCH cuCausalXtitr INTO nuCausal;
                                    CLOSE cuCausalXtitr;

                                    IF nuCausal IS NOT NULL THEN
                                        NUCAULEG := nuCausal;
                                    ELSE
                                        NUCAULEG := NUCAULEGV;
                                    END IF;

                                    IF cuValidacausal%ISOPEN THEN
                                        CLOSE cuValidacausal;
                                    END IF;

                                    OPEN cuValidacausal;

                                    FETCH cuValidacausal INTO sbExiste;

                                    IF cuValidacausal%NOTFOUND
                                    THEN
                                        CLOSE cuValidacausal;

                                        Pkg_Error.SetErrorMessage(
                                            Ld_Boconstans.cnuGeneric_Error,
                                               'La causal '
                                            || NUCAULEG
                                            || 'configurada en los parametros COD_CAULEG_SUS_RP_CARTERA,TITR_CAUSAL_ENCOLAMIENTO no es de tipo 18 clase 2');
                                    END IF;

                                    CLOSE cuValidacausal;

                                --INICIO PROCESO DE ANULACION DE ORDEN CARTERA POR SUSPENSION
                                --se valida si la orden esta bloqueada
                                IF RFCUOTSUS_CARTERA_SIN_LEG.ORDER_STATUS_ID =
                                   Or_BOConstants.CNUORDER_STAT_LOCK
                                THEN
                                    RCORDER :=
                                        DAOR_ORDER.FRCGETRECORD (
                                            RFCUOTSUS_CARTERA_SIN_LEG.Order_Id);
                                    RCORDER.ARRANGED_HOUR := NULL;

                                    --se desasigna orden de trabajo
                                    IF RCORDER.OPERATING_UNIT_ID IS NOT NULL
                                    THEN
                                        OR_BOPROCESSORDER.UNASSIGNORDER (
                                            RCORDER,
                                            inuCommentType,
                                            NULL,
                                            NULL,
                                            SYSDATE);
                                    ELSE
									
										ut_trace.trace('Ingresa api_unlockorder inuOrderId: '	|| RFCUOTSUS_CARTERA_SIN_LEG.Order_Id || chr(10) ||
																   'inuTipoComentario: '	|| inuCommentType 	|| chr(10) ||
																   'isbComentario: ' 		|| isbComment 		|| chr(10) ||
																   'idtFechaCambio: ' 		|| SYSDATE, 8);
									
                                        --  se hace llamado al proceso que desbloquea la orden
                                        api_unlockorder(RFCUOTSUS_CARTERA_SIN_LEG.Order_Id,
														inuCommentType,
														isbComment,
														SYSDATE,
														nuerrorcode,
														sberrormessage
														);
														
										ut_trace.trace('Sale api_unlockorder nuerrorcode: ' 	|| nuerrorcode	|| chr(10) ||
																'sberrormessage: '	|| sberrormessage, 8);
											
										IF nuCodigoError <> 0 THEN
											Pkg_Error.SetErrorMessage(nuerrorcode,
																	  sberrormessage
																	  );
										END IF;
										
                                    END IF;

                                    --se consulta estado de la orden despues de desbloquear
                                    regOrden :=
                                        DAOR_ORDER.FRCGETRECORD (
                                            RFCUOTSUS_CARTERA_SIN_LEG.Order_Id);

                                    --si esta asignada a una unidad diferente se reasiugna
                                    IF     regOrden.order_status_id =
                                           Or_BOConstants.CNUORDER_STAT_ASSIGNED
                                       AND regOrden.operating_unit_id <>
                                           nuUnidadcartera
                                    THEN
                                        --se reasigna orden de trabajo
                                        OR_BOPROCESSORDER.TOREASSIGN (
                                            regOrden,
                                            SYSDATE,
                                            inuCommentType,
                                            'REASIGNACION POR PROCESO PROENCOLAMIENTOCARTRP',
                                            nuUnidadcartera);
                                    ELSE
                                        IF regOrden.order_status_id =
                                           Or_BOConstants.CNUORDER_STAT_REGISTERED
                                        THEN
                                            nuasignarorden := 1;
                                        END IF;
                                    END IF;
                                ELSIF RFCUOTSUS_CARTERA_SIN_LEG.ORDER_STATUS_ID =
                                      Or_BOConstants.CNUORDER_STAT_REGISTERED
                                THEN
                                    nuasignarorden := 1;
                                END IF;

                                --se asigna orden de trabajo
                                IF nuasignarorden = 1
                                THEN
								
									ut_trace.trace('ingresa api_assign_order nuOrden: ' || RFCUOTSUS_CARTERA_SIN_LEG.order_id || CHR(10) ||
																			'inuOperatingUnit: ' || nuUnidadcartera, 6);
								
                                    api_assign_order(RFCUOTSUS_CARTERA_SIN_LEG.order_id,
													 nuUnidadcartera,
													 nuCodigoError,
													 sbMensajeError
													 );
													 
									ut_trace.trace('Finaliza api_assign_order nuerrorcode: ' || nuCodigoError || CHR(10) ||
																	 'sberrormessage: ' || sbMensajeError, 6);

                                    IF nuCodigoError <> 0
                                    THEN
                                        Pkg_Error.SetErrorMessage(
                                            Ld_Boconstans.cnuGeneric_Error,
                                            sbMensajeError);
                                    END IF;
                                END IF;

                                IF nuPersonaLega IS NULL
                                THEN
                                    Pkg_Error.SetErrorMessage(
                                        Ld_Boconstans.cnuGeneric_Error,
                                        'El parametro de la persona para encolamiento de cartera esta vacio');
                                END IF;

                                --se inserta para legalizar en job
                                INSERT INTO LDC_ORDEASIGPROC (ORAPORPA,
                                                              ORAPSOGE,
                                                              ORAOPELE,
                                                              ORAOUNID,
                                                              ORAOCALE,
                                                              ORAOPROC)
                                         VALUES (
                                                    NUORDENINSTANCIA,
                                                    RFCUOTSUS_CARTERA_SIN_LEG.order_id,
                                                    nuPersonaLega,
                                                    nuUnidadcartera,
                                                    NUCAULEG,
                                                    'ENCOCARTRP');
                            END LOOP;
                        --FIN RP

                        END IF;
                END IF;
            END IF;
        
           

        UT_TRACE.TRACE ('FIN LDC_PKORDENES.PROENCOLAMIENTOCARTRP', 10);

    EXCEPTION
        WHEN PKG_ERROR.CONTROLLED_ERROR
        THEN
            RAISE;
        WHEN EX_ERROR
        THEN
            Pkg_Error.SetErrorMessage(LD_BOCONSTANS.CNUGENERIC_ERROR,
									  SBMENSAJE);
        WHEN OTHERS
        THEN
            Pkg_Error.SetErrorMessage (
                LD_BOCONSTANS.CNUGENERIC_ERROR,
                'ERROR AL EJECUTAR PROCESO PROENCOLAMIENTOCARTRP' || SQLERRM);
            RAISE;
    END PROENCOLAMIENTOCARTRP;

    --Fin CASO 100-8157 Encolamiento CARTERA - RP


    --Inicio CASO 200-514 Anulacion de ordenes y solicitudes cuando se anula producto
    /*****************************************************************

    UNIDAD       : PROCOTSOLTRAANUPRO

    DESCRIPCION  : SERVICIO PARA CERRAR LAS ORDENES Y SOLICITUDES CUANDO SE AUTORIZA EL

                   TRAMITE DE ANULACION DE PRODUCTO.



    AUTOR          : SINCECOMP

    FECHA          : 29/09/2016



    HISTORIA DE MODIFICACIONES

    FECHA             AUTOR             MODIFICACION

    =========       =========           ====================
	31/07/2023		jerazomvm			Caso OSF-1261:
										1. Se reemplaza la separación de cadena LDC_BOUTILITIES.SPLITSTRINGS por 
											SELECT to_number(regexp_substr(variable,
															 '[^,]+',
															 1,
															 LEVEL)) AS alias
											FROM dual
											CONNECT BY regexp_substr(variable, '[^,]+', 1, LEVEL) IS NOT NULL
    ******************************************************************/

    PROCEDURE PROCOTSOLTRAANUPRO
    IS
        NUORDENINSTANCIA          	OR_ORDER.ORDER_ID%TYPE;
		sbCod_Tip_Tra_Rp_Sus		ld_parameter.value_chain%type	:=	DALD_PARAMETER.FSBGETVALUE_CHAIN('COD_TIP_TRA_RP_SUS', NULL);
		sbCod_Est_Pro_Anu_Pro		ld_parameter.value_chain%type	:= 	DALD_PARAMETER.FSBGETVALUE_CHAIN('COD_EST_PRO_ANU_PRO', NULL);
		sbCod_Est_Cor_Pro			ld_parameter.value_chain%type	:= 	DALD_PARAMETER.FSBGETVALUE_CHAIN('COD_EST_COR_PRO', NULL);


        CURSOR CUORDENESABIERTAS (INUORDENINSTANCIA NUMBER)
        IS
            SELECT OOA.*
              FROM OR_ORDER_ACTIVITY OOA
             WHERE OOA.ORDER_ID = INUORDENINSTANCIA;



        RFCUORDENESABIERTAS       CUORDENESABIERTAS%ROWTYPE;



        --******INICIO CURSOR PARA VALIDAR TIPO DE TRABAJO EXISTE EN PARAMETRO DE RP

        CURSOR CUEXISTERP (
            NUOR_ORDER_ACTIVITY   OR_ORDER_ACTIVITY.TASK_TYPE_ID%TYPE)
        IS
            SELECT COUNT (1)     CANTIDAD
              FROM DUAL
             WHERE NUOR_ORDER_ACTIVITY IN
                       (SELECT to_number(regexp_substr(sbCod_Tip_Tra_Rp_Sus,
										 '[^,]+',
										 1,
										 LEVEL)) AS COD_TIP_TRA_RP_SUS
						FROM dual
						CONNECT BY regexp_substr(sbCod_Tip_Tra_Rp_Sus, '[^,]+', 1, LEVEL) IS NOT NULL);



        CURSOR CUESTADOCORTE (INUPRODUCTO NUMBER)
        IS
            SELECT COUNT (1)
              FROM servsusc s, pr_product p
             WHERE     sesunuse = product_id
                   AND p.product_status_id IN
                           (SELECT to_number(regexp_substr(sbCod_Est_Pro_Anu_Pro,
											 '[^,]+',
											 1,
											 LEVEL)) AS COD_EST_PRO_ANU_PRO
							FROM dual
							CONNECT BY regexp_substr(sbCod_Est_Pro_Anu_Pro, '[^,]+', 1, LEVEL) IS NOT NULL)
                   AND sesuesco NOT IN
                           (SELECT to_number(regexp_substr(sbCod_Est_Cor_Pro,
											 '[^,]+',
											 1,
											 LEVEL)) AS COD_EST_COR_PRO
							FROM dual
							CONNECT BY regexp_substr(sbCod_Est_Cor_Pro, '[^,]+', 1, LEVEL) IS NOT NULL)
                   AND sesuserv = 7014
                   AND sesunuse = INUPRODUCTO;



        NUCUESTADOCORTE           NUMBER;

        --INICIO VARIABLES

        NUESTADOCORTE             NUMBER
            := DALD_PARAMETER.fnuGetNumeric_Value (
                   'COD_EST_COR_ANU_PRO',
                   NULL);                                                  --;

        NUPERSONID                NUMBER := ge_bopersonal.fnuGetPersonId; --1;
        onuerrorcode              NUMBER;
        osberrormessage           VARCHAR2 (4000);

        --FIN VARIABLES



        --Inicio Variables Errores

        EX_ERROR                  EXCEPTION;
        SBMENSAJE                 VARCHAR2 (2000);
        SBERRORMESSAGE            VARCHAR2 (4000);

        --Fin Variables



        --

        SBCOD_TT_NO_ANU_SUS_PRO   ld_parameter.value_chain%TYPE
            := DALD_PARAMETER.fsbGetValue_Chain (
                   'COD_TT_NO_ANU_SUS_PRO',
                   NULL);



        CURSOR cusolicitudes (INUPRODUCT_ID NUMBER, INUPACKAGE_ID NUMBER)
        IS
            SELECT mp.package_id
              FROM mo_packages mp
             WHERE     mp.package_id IN
                           (SELECT /*+ leading (mo_motive) use_nl(mo_motive a)

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   index (mo_motive IDX_MO_MOTIVE13) index (a PK_MO_PACKAGES)*/
                                   a.package_id     package_id
                              FROM /*+ cc_boOssProduct.GetPackage */
                                   mo_packages a, mo_motive
                             WHERE     mo_motive.product_id = INUPRODUCT_ID
                                   AND mo_motive.package_id = a.package_id
                                   AND A.PACKAGE_ID <> INUPACKAGE_ID
                                   AND A.MOTIVE_STATUS_ID = 13)
                   AND (SELECT COUNT (ooa.package_id)
                          FROM or_order_activity ooa
                         WHERE     ooa.package_id = mp.package_id           --
                               AND ooa.task_type_id IN
                                       (SELECT to_number(regexp_substr(SBCOD_TT_NO_ANU_SUS_PRO,
														 '[^,]+',
														 1,
														 LEVEL)) AS COD_TT_NO_ANU_SUS_PRO
										FROM dual
										CONNECT BY regexp_substr(SBCOD_TT_NO_ANU_SUS_PRO, '[^,]+', 1, LEVEL) IS NOT NULL)) = 0;



        RFcusolicitudes           cusolicitudes%ROWTYPE;
    BEGIN
        UT_TRACE.TRACE ('INICIO LDC_PKORDENES.PROCOTSOLTRAANUPRO', 10);



        --ORDEN DE LA INSTANCIA
        NUORDENINSTANCIA := OR_BOLEGALIZEORDER.FNUGETCURRENTORDER; -- 30235205;--
        UT_TRACE.TRACE ('ORDEN A LEGALIZAR[' || NUORDENINSTANCIA || ']', 10);


        IF CUORDENESABIERTAS%ISOPEN THEN
            CLOSE CUORDENESABIERTAS;
        END IF;

        --OBTENER LOS DATOS DE LA ORDEN LEGALIZADA
        OPEN CUORDENESABIERTAS (NUORDENINSTANCIA);
        FETCH CUORDENESABIERTAS INTO RFCUORDENESABIERTAS;
        CLOSE CUORDENESABIERTAS;


        IF CUESTADOCORTE%ISOPEN THEN
            CLOSE CUESTADOCORTE;
        END IF;

        --OBTENER LOS DATOS DE LA ORDEN LEGALIZADA
        OPEN CUESTADOCORTE (RFCUORDENESABIERTAS.PRODUCT_ID);
        FETCH CUESTADOCORTE INTO NUCUESTADOCORTE;
        CLOSE CUESTADOCORTE;

        ---INICIO ANULAR TODAS LAS ORDENES Y SOLICITUDES ABIERTAS DEL PRODCUTO A SUSPENDER
        BEGIN
            -- obtener solcitudes sin TT del paremtro SBCOD_TT_NO_ANU_SUS_PRO
            FOR RFcusolicitudes
                IN cusolicitudes (RFCUORDENESABIERTAS.PRODUCT_ID,
                                  RFCUORDENESABIERTAS.PACKAGE_ID)
            LOOP
                UT_TRACE.TRACE (
                    'Solicitud[' || RFcusolicitudes.Package_Id || ']',
                    10);

                DBMS_OUTPUT.put_line (
                    'Solicitud[' || RFcusolicitudes.Package_Id || ']');


                UPDATE mo_packages mp
                   SET mp.motive_status_id = 14, mp.attention_date = SYSDATE
                 WHERE mp.package_id = RFcusolicitudes.Package_Id;


                UPDATE mo_motive mm
                   SET mm.attention_date = SYSDATE, mm.motive_status_id = 11
                 WHERE mm.package_id = RFcusolicitudes.Package_Id;


                UPDATE or_order oo
                   SET oo.assigned_date = SYSDATE,
                       oo.legalization_date = SYSDATE,
                       oo.order_status_id = 12                             --,
                 WHERE     oo.order_id IN
                               (SELECT OOA1.ORDER_ID
                                  FROM OR_ORDER_ACTIVITY OOA1
                                 WHERE     OOA1.PRODUCT_ID =
                                           RFCUORDENESABIERTAS.PRODUCT_ID
                                       AND OOA1.ORDER_ID <> NUORDENINSTANCIA
                                       AND OOA1.PACKAGE_ID =
                                           RFcusolicitudes.Package_Id
                                       AND OOA1.STATUS <> 'F')
                       AND oo.task_type_id NOT IN
                               (SELECT to_number(regexp_substr(SBCOD_TT_NO_ANU_SUS_PRO,
												 '[^,]+',
												 1,
												 LEVEL)) AS COD_TT_NO_ANU_SUS_PRO
								FROM dual
								CONNECT BY regexp_substr(SBCOD_TT_NO_ANU_SUS_PRO, '[^,]+', 1, LEVEL) IS NOT NULL);


                UPDATE or_order_activity ooa
                   SET ooa.status = 'F'
                 WHERE     ooa.product_id = RFCUORDENESABIERTAS.PRODUCT_ID
                       --AND NVL(OOA.PACKAGE_ID, 0) <> RFCUORDENESABIERTAS.PACKAGE_ID
                       AND OOA.ORDER_ID IN
                               (SELECT OOA1.ORDER_ID
                                  FROM OR_ORDER_ACTIVITY OOA1
                                 WHERE     OOA1.PRODUCT_ID =
                                           RFCUORDENESABIERTAS.PRODUCT_ID
                                       AND OOA1.ORDER_ID <> NUORDENINSTANCIA
                                       AND OOA1.PACKAGE_ID =
                                           RFcusolicitudes.Package_Id
                                       AND OOA1.STATUS <> 'F')
                       AND ooa.task_type_id NOT IN
                               (SELECT to_number(regexp_substr(SBCOD_TT_NO_ANU_SUS_PRO,
												 '[^,]+',
												 1,
												 LEVEL)) AS COD_TT_NO_ANU_SUS_PRO
								FROM dual
								CONNECT BY regexp_substr(SBCOD_TT_NO_ANU_SUS_PRO, '[^,]+', 1, LEVEL) IS NOT NULL);


            END LOOP;
        EXCEPTION
            WHEN OTHERS
            THEN
                Pkg_Error.SetErrorMessage (
                    LD_BOCONSTANS.CNUGENERIC_ERROR,
                    'ERROR AL ANULAR LAS ORDENES ASOCIDAS AL PRODUCTO');

                RAISE;
        END;



        IF NUCUESTADOCORTE = 0
        THEN
            --Funcion para actulaizar estado de Corte con Historial

            pktblservsusc.updsesuesco (RFCUORDENESABIERTAS.PRODUCT_ID,
                                       NUESTADOCORTE);
        ---FIN ANULAR TODAS LAS ORDENES Y SOLCITUDES ABIERTAS DEL PRODCUTO

        END IF;



        UT_TRACE.TRACE ('FIN LDC_PKORDENES.PROCOTSOLTRAANUPRO', 10);

    EXCEPTION
        WHEN EX_ERROR
        THEN
            Pkg_Error.SetErrorMessage(LD_BOCONSTANS.CNUGENERIC_ERROR,
									  SBMENSAJE);
        WHEN OTHERS
        THEN
            Pkg_Error.SetErrorMessage (
                LD_BOCONSTANS.CNUGENERIC_ERROR,
                'ERROR AL EJECUTAR PROCESO PROCOTSOLTRAANUPRO');

            RAISE;
    END PROCOTSOLTRAANUPRO;

    --Fin CASO 200-514 Anulacion de ordenes y solicitudes cuan se anula contrato



    --Inicio CASO 200-615

    /*****************************************************************

    UNIDAD       : FNCONSULTAORDENESVISITAS
    DESCRIPCION  : SERVICIO PARA IDENTIFCAR LAS ORDENDES DE VISITAS CANCELADAS DE SOLICITUDES DE VENTAS



    AUTOR          : SINCECOMP
    FECHA          : 04/11/2016



    HISTORIA DE MODIFICACIONES
    FECHA             AUTOR             MODIFICACION
    =========       =========           ====================
	31/07/2023		jerazomvm			Caso OSF-1261:
										1. Se reemplaza la separación de cadena LDC_BOUTILITIES.SPLITSTRINGS por 
											SELECT to_number(regexp_substr(variable,
															 '[^,]+',
															 1,
															 LEVEL)) AS alias
											FROM dual
											CONNECT BY regexp_substr(variable, '[^,]+', 1, LEVEL) IS NOT NULL

    ******************************************************************/

    FUNCTION FNCONSULTAORDENESVISITAS
        RETURN pkConstante.tyRefCursor
    IS
        rfCursor                pkConstante.tyRefCursor;
        sbOPERATING_SECTOR_ID   ge_boInstanceControl.stysbValue;
        sbGEO_LOCA_FATHER_ID    ge_boInstanceControl.stysbValue;
        sbGEOGRAP_LOCATION_ID   ge_boInstanceControl.stysbValue;
        sbPACKAGE_ID            ge_boInstanceControl.stysbValue;
        sbTASK_TYPE_ID          ge_boInstanceControl.stysbValue;
        sbACTIVITY_ID           ge_boInstanceControl.stysbValue;
		sbCod_Est_Ord_LDCGOV		ld_parameter.value_chain%type	:=	dald_parameter.fsbgetvalue_chain('COD_EST_ORD_LDCGOV', NULL);
		sb_Cod_Tipo_Trab_1_LDCGOV	ld_parameter.value_chain%type	:=	dald_parameter.fsbgetvalue_chain('COD_TIPO_TRAB_1_LDCGOV', NULL); 
		sb_Cod_Tipo_Trab_2_LDCGOV	ld_parameter.value_chain%type	:=  dald_parameter.fsbgetvalue_chain('COD_TIPO_TRAB_2_LDCGOV', NULL);
		sb_Cod_Cau_No_leg_LDCGOV	ld_parameter.value_chain%type	:=	dald_parameter.fsbgetvalue_chain('COD_CAU_NO_LEG_LDCGOV', NULL);
    BEGIN
        ut_trace.trace ('Fin LDC_PKORDENES.FNCONSULTAORDENESVISITAS', 10);


        sbOPERATING_SECTOR_ID :=
            ge_boInstanceControl.fsbGetFieldValue ('GE_GEOGRA_LOCATION',
                                                   'OPERATING_SECTOR_ID');

        ut_trace.trace ('Meses[' || sbOPERATING_SECTOR_ID || ']', 10);

        sbGEO_LOCA_FATHER_ID :=
            ge_boInstanceControl.fsbGetFieldValue ('GE_GEOGRA_LOCATION',
                                                   'GEO_LOCA_FATHER_ID');

        ut_trace.trace ('Departamento[' || sbGEO_LOCA_FATHER_ID || ']', 10);

        sbGEOGRAP_LOCATION_ID :=
            ge_boInstanceControl.fsbGetFieldValue ('GE_GEOGRA_LOCATION',
                                                   'GEOGRAP_LOCATION_ID');

        ut_trace.trace ('Localidad[' || sbGEOGRAP_LOCATION_ID || ']', 10);

        sbPACKAGE_ID :=
            ge_boInstanceControl.fsbGetFieldValue ('OR_ORDER_ACTIVITY',
                                                   'PACKAGE_ID');

        ut_trace.trace ('Tipo solicitud[' || sbPACKAGE_ID || ']', 10);

        sbTASK_TYPE_ID :=
            ge_boInstanceControl.fsbGetFieldValue ('OR_ORDER_ACTIVITY',
                                                   'TASK_TYPE_ID');

        ut_trace.trace ('Tipo trabajo[' || sbTASK_TYPE_ID || ']', 10);

        sbACTIVITY_ID :=
            ge_boInstanceControl.fsbGetFieldValue ('OR_ORDER_ACTIVITY',
                                                   'ACTIVITY_ID');

        ut_trace.trace ('Actividad[' || sbACTIVITY_ID || ']', 10);


        OPEN rfCursor FOR
            SELECT    universo.SOLICITUD
                   || '-'
                   || universo.PRODCUTO
                   || '-'
                   || universo.Codigo_direccion    Codigo_Identificador,
                   --universo.DIRECCION CODIGO,

                   universo.Departamento,
                   universo.Localidad,
                   universo.SECTOR_OPERATIVO,
                   universo.PRODCUTO,
                   universo.CONTRATO,
                   universo.NOMBRE_COMPLETO,
                   universo.SOLICITUD,
                   universo.DIRECCION
              FROM (SELECT /*+ index (ggl PK_GE_GEOGRA_LOCATION) index (pp IDX_PR_PRODUCT_09) index (aa PK_AB_ADDRESS) */
                           pp.address_id
                               Codigo_direccion,
                              ggl.geo_loca_father_id
                           || ' - '
                           || dage_geogra_location.fsbgetdescription (
                                  ggl.geo_loca_father_id,
                                  NULL)
                               Departamento,
                              ggl.geograp_location_id
                           || ' - '
                           || dage_geogra_location.fsbgetdescription (
                                  ggl.geograp_location_id,
                                  NULL)
                               Localidad,
                           (SELECT    ase.operating_sector_id
                                   || ' - '
                                   || oos.DESCRIPTION
                              FROM or_operating_sector  oos,
                                   ab_segments          ase
                             WHERE     ase.segments_id = aa.segment_id
                                   AND ase.operating_sector_id =
                                       oos.operating_sector_id
                                   AND ROWNUM = 1)
                               SECTOR_OPERATIVO,
                           pp.product_id
                               PRODCUTO,
                           s.sesususc
                               CONTRATO,
                           (SELECT    gs.subscriber_name
                                   || ' '
                                   || gs.subs_last_name
                              FROM ge_subscriber gs, suscripc sc
                             WHERE     gs.subscriber_id = sc.suscclie
                                   AND sc.susccodi = s.sesususc)
                               NOMBRE_COMPLETO,
                           (SELECT MM.PACKAGE_ID
                              FROM MO_MOTIVE MM
                             WHERE     MM.PACKAGE_ID IN
                                           (SELECT MP.PACKAGE_ID
                                              FROM MO_PACKAGES MP
                                             WHERE     MP.PACKAGE_TYPE_ID =
                                                       TO_NUMBER (
                                                           sbPACKAGE_ID) --PACKAGE_TYPE_ID
                                                   AND MP.MOTIVE_STATUS_ID =
                                                       13)
                                   AND MM.SUBSCRIPTION_ID = S.SESUSUSC)
                               SOLICITUD,
                           aa.address
                               DIRECCION
                      FROM pr_product          pp,
                           ab_address          aa,
                           ge_geogra_location  ggl,
                           servsusc            s
                     WHERE     pp.PRODUCT_STATUS_ID = 15
                           AND pp.product_id = s.sesunuse
                           AND s.sesuserv = 7014
                           AND pp.address_id = aa.address_id
                           AND aa.geograp_location_id =
                               ggl.geograp_location_id
                           --------FILTRO CON PAREMTROS

                           AND ggl.geo_loca_father_id =
                               DECODE (TO_NUMBER (sbGEO_LOCA_FATHER_ID), --NUDEPARTAMENTO,
                                       -1, ggl.geo_loca_father_id,
                                       TO_NUMBER (sbGEO_LOCA_FATHER_ID)) --NUDEPARTAMENTO)
                           AND ggl.geograp_location_id =
                               DECODE (TO_NUMBER (sbGEOGRAP_LOCATION_ID), --NULOCALIDAD,
                                       -1, ggl.geograp_location_id,
                                       TO_NUMBER (sbGEOGRAP_LOCATION_ID)) --NULOCALIDAD)
                           AND (SELECT COUNT (1)
                                  FROM MO_MOTIVE MM
                                 WHERE     MM.PACKAGE_ID IN
                                               (SELECT MP.PACKAGE_ID
                                                  FROM MO_PACKAGES MP
                                                 WHERE     MP.PACKAGE_TYPE_ID =
                                                           TO_NUMBER (
                                                               sbPACKAGE_ID) --PACKAGE_TYPE_ID
                                                       AND MP.MOTIVE_STATUS_ID =
                                                           13
                                                       AND ABS (
                                                               MONTHS_BETWEEN (
                                                                   TRUNC (
                                                                       SYSDATE),
                                                                   TRUNC (
                                                                       mp.request_date))) >
                                                           TO_NUMBER (
                                                               sbOPERATING_SECTOR_ID)) --numeseventa)
                                       AND MM.SUBSCRIPTION_ID = S.SESUSUSC) =
                               1) Universo,
                   or_order_activity  ooa
             WHERE     Universo.SOLICITUD = ooa.package_id
                   AND ooa.task_type_id = TO_NUMBER (sbTASK_TYPE_ID) 
                   AND ooa.activity_id =
                       DECODE (TO_NUMBER (sbACTIVITY_ID),     
                               -1, ooa.activity_id,
                               TO_NUMBER (sbACTIVITY_ID)) 
                   AND daor_order.fnugetorder_status_id (ooa.order_id,
                                                              0) IN
                           (SELECT to_number(regexp_substr(sbCod_Est_Ord_LDCGOV,
											 '[^,]+',
											 1,
											LEVEL)) AS COD_EST_ORD_LDCGOV
							FROM dual
							CONNECT BY regexp_substr(sbCod_Est_Ord_LDCGOV, '[^,]+', 1, LEVEL) IS NOT NULL)
                   AND ooa.product_id = universo.PRODCUTO
                   AND ooa.subscription_id = universo.CONTRATO
                   AND ooa.address_id = universo.Codigo_direccion
                   AND (SELECT COUNT (oo1.causal_id)
                          FROM or_order_activity ooa1, or_order oo1
                         WHERE     ooa1.package_id = universo.SOLICITUD
                               AND ooa1.product_id = universo.PRODCUTO
                               AND ooa1.address_id =
                                   universo.Codigo_direccion
                               AND ooa1.task_type_id IN
                                       (SELECT to_number(regexp_substr(sb_Cod_Tipo_Trab_1_LDCGOV,
														 '[^,]+',
														 1,
														 LEVEL)) AS COD_TIPO_TRAB_1_LDCGOV
										FROM dual
										CONNECT BY regexp_substr(sb_Cod_Tipo_Trab_1_LDCGOV, '[^,]+', 1, LEVEL) IS NOT NULL)
                               AND ooa1.order_id = oo1.order_id
                               AND NVL (
                                       dage_causal.fnugetclass_causal_id (
                                           oo1.causal_id,
                                           NULL),
                                       0) =
                                   1) =
                       0

                   AND (SELECT COUNT (oo2.causal_id)
                          FROM or_order_activity ooa2, or_order oo2
                         WHERE     ooa2.package_id = universo.SOLICITUD
                               AND ooa2.product_id = universo.PRODCUTO
                               AND ooa2.subscription_id = universo.CONTRATO
                               AND ooa2.address_id =
                                   universo.Codigo_direccion
                               AND ooa2.task_type_id IN
                                       (SELECT to_number(regexp_substr(sb_Cod_Tipo_Trab_2_LDCGOV,
														 '[^,]+',
														 1,
														 LEVEL)) AS COD_TIPO_TRAB_2_LDCGOV
										FROM dual
										CONNECT BY regexp_substr(sb_Cod_Tipo_Trab_2_LDCGOV, '[^,]+', 1, LEVEL) IS NOT NULL)
                               AND ooa2.order_id = oo2.order_id
                               AND NVL (oo2.causal_id, 0)            --<> 9347
                                                          IN
                                       (SELECT to_number(regexp_substr(sb_Cod_Cau_No_leg_LDCGOV,
														 '[^,]+',
														 1,
														 LEVEL)) AS COD_CAU_NO_LEG_LDCGOV
										FROM dual
										CONNECT BY regexp_substr(sb_Cod_Cau_No_leg_LDCGOV, '[^,]+', 1, LEVEL) IS NOT NULL)) = 0;

        --*/
        RETURN rfCursor;


        ut_trace.trace ('Fin LDC_PKORDENES.FNCONSULTAORDENESVISITAS', 10);
    END FNCONSULTAORDENESVISITAS;



    /*****************************************************************

    Propiedad intelectual de PETI (c).

    Unidad         : LDC_PRGENORDVIS
    Descripcion    : Procedimiento para generar orden de visita
    Autor          : Jorge Valiente
    Fecha          : 02/02/2017


    Parametros              Descripcion
    ============         ===================


    Fecha             Autor                 Modificacion
    =========       =========              ====================
    21/07/2023      jerazomvm              CASO OSF-1261:
                                            1. Se reemplaza el manejo de errores ex y errors por Pkg_error.

    14/09/2023      felipe.valencia         OSF-1549: Se modifica el api creación de ordenes por api_createorder
    ******************************************************************/

    PROCEDURE LDC_PRGENORDVIS (isbCodigoIdentificador   IN     VARCHAR2,
                               inuCurrent               IN     NUMBER,
                               inuTotal                 IN     NUMBER,
                               onuErrorCode                OUT NUMBER,
                               osbErrorMessage             OUT VARCHAR)
    IS
        sbsolicitud         VARCHAR2 (4000);
        sbprodcuto          VARCHAR2 (4000);
        sbdireccion         VARCHAR2 (4000);
        SBCHARACTER         VARCHAR2 (1) := '-';
        SBFINISHLINE        VARCHAR2 (4000);
        SBSUBLINE           VARCHAR2 (4000);
        NUCOUNT             NUMBER;

        nuCodigoError       NUMBER;
        sbMensajeError      VARCHAR(4000);


        --Variable Generacion de ordenes
        nuOrderId           NUMBER := NULL;
        nuOrderActivityId   NUMBER := NULL;
        nuMotive            NUMBER := NULL;
        product_id          NUMBER := NULL;
        suscription_id      NUMBER := NULL;
        sbcomentario        VARCHAR2 (4000);
        nuActOrdVis         NUMBER;

        -------------------------------------------



        --cursor

        --cursor para validar la existencia de las actividades

        --100002841 - VISITA VERIFICACION DE INSTALACION RESIDENCIAL X TIEMPO CUMPLIDO y

        --100002842 - VISITA VERIFICACION DE INSTALACION NO RESIDENCIALES X TIEMPO CUMPLIDO

        CURSOR cuexitenordvis (inupackages NUMBER)
        IS
            SELECT COUNT (ooa.order_id)     cantidad
              FROM or_order_activity ooa
             WHERE     ooa.package_id = inupackages
                   AND ooa.activity_id IN
                           (dald_parameter.fnuGetNumeric_Value (
                                'ACT_VIS_VER_INS_RES_LDCGOV'),
                            dald_parameter.fnuGetNumeric_Value (
                                'ACT_VIS_VER_INS_NO_RES_LDCGOV'))
                   AND ooa.status <> 'F';



        rfcuexitenordvis    cuexitenordvis%ROWTYPE;
    BEGIN
        ut_trace.trace ('Inicio LDC_PKORDENES.LDC_PRGENORDVIS', 10);

        --validacion de parametros
        IF NVL (
               dald_parameter.fnuGetNumeric_Value (
                   'ACT_VIS_VER_INS_RES_LDCGOV',
                   NULL),
               0) =
           0
        THEN
            osbErrorMessage :=
                'Dato no valido en el parametro ACT_VIS_VER_INS_RES_LDCGOV';

            RAISE PKG_ERROR.CONTROLLED_ERROR;
        END IF;


        IF NVL (
               dald_parameter.fnuGetNumeric_Value (
                   'ACT_VIS_VER_INS_NO_RES_LDCGOV',
                   NULL),
               0) =
           0
        THEN
            osbErrorMessage :=
                'Dato no valido en el parametro ACT_VIS_VER_INS_NO_RES_LDCGOV';

            RAISE PKG_ERROR.CONTROLLED_ERROR;
        END IF;

        ----------------------------



        --decomponer el codigo identificador de la 1ra columan del PB

        --cantidad de palabras del identificador

        NUCOUNT := 0;

        LOOP
            NUCOUNT := NUCOUNT + 1;

            SBFINISHLINE :=
                REGEXP_SUBSTR (isbCodigoIdentificador,
                               '.*?\' || SBCHARACTER,
                               1,
                               NUCOUNT);

            EXIT WHEN SBFINISHLINE IS NULL OR LENGTH (SBFINISHLINE) = 0;
        END LOOP;


        sbsolicitud := NULL;
        sbprodcuto := NULL;
        sbdireccion := NULL;
        SBFINISHLINE := isbCodigoIdentificador;

        FOR NUPOSITION IN 1 .. NUCOUNT
        LOOP
            UT_TRACE.TRACE ('**********LINE [' || SBFINISHLINE || ']', 10);

            SBSUBLINE :=
                SUBSTR (SBFINISHLINE,
                        1,
                          LENGTH (REGEXP_SUBSTR (SBFINISHLINE,
                                                 '.*?\' || SBCHARACTER,
                                                 1,
                                                 1))
                        - 1);



            UT_TRACE.TRACE ('***************SBSUBLINE [' || SBSUBLINE || ']',
                            10);



            IF SBSUBLINE IS NOT NULL
            THEN
                IF sbsolicitud IS NULL
                THEN
                    sbsolicitud := SBSUBLINE;
                ELSIF sbprodcuto IS NULL
                THEN
                    sbprodcuto := SBSUBLINE;
                END IF;



                SBFINISHLINE :=
                    SUBSTR (SBFINISHLINE,
                              LENGTH (REGEXP_SUBSTR (SBFINISHLINE,
                                                     '.*?\' || SBCHARACTER,
                                                     1,
                                                     1))
                            + 1);
            ELSE
                sbdireccion := SBFINISHLINE;
            END IF;
        END LOOP;



        UT_TRACE.TRACE ('sbsolicitud [' || sbsolicitud || ']', 10);

        UT_TRACE.TRACE ('sbprodcuto [' || sbprodcuto || ']', 10);

        UT_TRACE.TRACE ('sbdireccion [' || sbdireccion || ']', 10);

        --------------------------------------------------------------------

        --cursor para validar la exsitencia de orden de visita en las solcitiudes seleccionadas

        IF cuexitenordvis%ISOPEN THEN
            CLOSE cuexitenordvis;
        END IF;

        OPEN cuexitenordvis (TO_NUMBER (sbsolicitud));
        FETCH cuexitenordvis INTO rfcuexitenordvis;
        CLOSE cuexitenordvis;

        IF rfcuexitenordvis.cantidad = 0
        THEN
            --generacion de orden de visita
            --incia proceso de creacion de nueva orden
            nuOrderId := NULL;
            nuOrderActivityId := NULL;
            nuMotive :=
                mo_bopackages.fnuGetInitialMotive (TO_NUMBER (sbsolicitud));
            product_id := mo_bomotive.fnugetproductid (nuMotive);
            suscription_id := mo_bomotive.fnugetsubscription (nuMotive);

            --identificar categoria residencial o no residencial
            sbcomentario := 'La orden fue creada por la forma LDCGOV';

            UT_TRACE.TRACE (
                   'Categoria ['
                || dapr_product.fnugetcategory_id (product_id, NULL)
                || ']',
                10);

            IF NVL (dapr_product.fnugetcategory_id (product_id, NULL), 0) <>
               0
            THEN
                IF dapr_product.fnugetcategory_id (product_id, NULL) = 1
                THEN
                    nuActOrdVis :=
                        dald_parameter.fnuGetNumeric_Value (
                            'ACT_VIS_VER_INS_RES_LDCGOV');
                ELSE
                    nuActOrdVis :=
                        dald_parameter.fnuGetNumeric_Value (
                            'ACT_VIS_VER_INS_NO_RES_LDCGOV');
                END IF;

                UT_TRACE.TRACE ('Actividad [' || nuActOrdVis || ']', 10);

                --/*

                UT_TRACE.TRACE (
                       'Creacion OT [api_createorder('
                    || nuActOrdVis
                    || ',

                                            '
                    || TO_NUMBER (sbsolicitud)
                    || ',

                                            '
                    || nuMotive
                    || ',

                                            null,

                                            null,

                                            '
                    || TO_NUMBER (sbdireccion)
                    || ',

                                            null,

                                            null,

                                            '
                    || suscription_id
                    || ',

                                            '
                    || product_id
                    || ',

                                            null,
                                            null,
                                            null,
                                            null,
                                            '
                    || sbcomentario
                    || ',

                                            null,

                                            null,

                                            '
                    || nuOrderId
                    || ',

                                            '
                    || nuOrderActivityId
                    || ',
                                            null,
                                            null,
                                            null,
                                            null,
                                            null,
                                            null,
                                            null,
                                            null,
                                            null)]',
                    10);

                api_createorder 
                (
                    nuActOrdVis,
                    TO_NUMBER (sbsolicitud),
                    nuMotive,
                    NULL,
                    NULL,
                    TO_NUMBER (sbdireccion),
                    NULL,
                    NULL,
                    suscription_id,
                    product_id,
                    NULL,
                    NULL,
                    NULL,
                    sbcomentario,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    nuOrderId,
                    nuOrderActivityId,
                    nuCodigoError,
                    sbMensajeError
                );

                IF ( nuCodigoError <> 0 ) THEN
                    onuErrorCode := nuCodigoError;
                    osbErrorMessage := sbMensajeError;
                END IF;

                ut_trace.trace (
                       'Se creo la orden['
                    || nuOrderId
                    || '] - Codigo Actiivdad['
                    || nuOrderActivityId
                    || ']',
                    10);
            ELSE
                onuErrorCode := -1;

                osbErrorMessage :=
                       'El prodcuto ['
                    || product_id
                    || '] no tiene definida configurada ninguna categoria ';
            END IF;
        ----------------------------------



        ELSE
            onuErrorCode := -1;

            osbErrorMessage :=
                   'La solciitud ['
                || sbsolicitud
                || '] ya tiene una VISITA VERIFICACION DE INSTALACION';
        END IF;



        ut_trace.trace ('FIN LDC_PKORDENES.LDC_PRGENORDVIS', 10);

        COMMIT;
    --rollback;



    EXCEPTION
        WHEN PKG_ERROR.CONTROLLED_ERROR
        THEN
            ROLLBACK;

            Pkg_Error.SetErrorMessage (Ld_Boconstans.cnuGeneric_Error,
                                              osbErrorMessage);
        WHEN OTHERS
        THEN
            ROLLBACK;

            onuErrorCode := Ld_Boconstans.cnuGeneric_Error;

            osbErrorMessage := SQLERRM;

            RAISE;
    END LDC_PRGENORDVIS;



    --Fin CASO 200-615

    PROCEDURE JOBLEGORDECARTRP
    IS
        /*****************************************************************
        Propiedad intelectual de gdc (c).


        Unidad         : JOBLEGORDECARTRP
        Descripcion    : Pjob que legaliza ordenes de suspension encolamiento
        Autor          : Olsoftware
        Ticket         : 470
        Fecha          : 04/11/2020



        Parametros              Descripcion
        ============         ===================


        Fecha             Autor         Modificacion
        =========       =========       ====================
        21/07/2023      jerazomvm       CASO OSF-1261:
                                        1. Se reemplaza el llamado del API os_legalizeorders
                                           por el API api_legalizeorders.
                                        2. Se reemplaza el manejo de errores ex y errors por Pkg_error.
                                        3. Se elimina la funcion fblAplicaEntregaxCaso para las entregas la cual retorna true.
        ******************************************************************/
        nuError              NUMBER;
        sbError              VARCHAR2 (4000);
        nuparano             NUMBER;
        nuparmes             NUMBER;
        nutsess              NUMBER;
        sbparuser            VARCHAR2 (4000);
        -- PARAMETROS REPORTE
        nuIdReporte          reportes.reponume%TYPE;
        sbEncabezadoDatos    repoinco.REINDES2%TYPE;
        sbValorDatos         repoinco.reinobse%TYPE;
        nuConsecutivo        NUMBER := 0;
        SBDATOSADICIONALES   VARCHAR2 (4000);

        CURSOR cuGetOrdenes IS
            SELECT p.ORAPORPA,                ---------- modificacion caso 647
                   oh.order_id,
                   oh.CREATED_DATE                             fecharegi,
                   oh.task_type_id                             tipotrab,
                   p.ORAOPELE,
                   p.ORAOCALE,
                   oa.order_activity_id                        actividad_id,
                   DECODE (c.CLASS_CAUSAL_ID,  1, 1,  2, 0)    tipo,
                   NVL ( (SELECT package_type_id
                            FROM mo_packages p
                           WHERE p.package_id = oa.package_id),
                        -1)                                    tipo_sol
              FROM LDC_ORDEASIGPROC   p,
                   or_order           oh,
                   ge_causal          c,
                   or_order_activity  oa
             WHERE     oh.order_id = oa.order_id
                   AND oh.order_id = p.ORAPSOGE
                   AND c.CAUSAL_ID = p.ORAOCALE
                   AND oa.status = 'R'
                   AND oh.order_status_id = 5
                   AND p.ORAOPROC = 'ENCOCARTRP';

        CURSOR cugetFecheje (inuorden NUMBER)
        IS
            SELECT o.EXEC_INITIAL_DATE, o.EXECUTION_FINAL_DATE
              FROM or_order o
             WHERE o.order_id = inuorden;

        CURSOR cugetdatosAdicionales (Inutipocausal NUMBER, inuTitr NUMBER)
        IS
            SELECT A.NAME_ATTRIBUTE
              FROM or_tasktype_add_data  d,
                   ge_attrib_set_attrib  s,
                   ge_attributes         A
             WHERE     d.task_type_id = inuTitr
                   AND d.attribute_set_id = s.attribute_set_id
                   AND s.attribute_id = a.attribute_id
                   AND d.active = 'Y'
                   AND (   D.use_ = DECODE (Inutipocausal,  1, 'C',  0, 'I')
                        OR D.use_ = 'B');

        dtFechIni            DATE;
        dtFechFin            DATE;
        --647

        --647


        FUNCTION fnuGetReporteEncabezado
            RETURN NUMBER
        IS
            PRAGMA AUTONOMOUS_TRANSACTION;
            -- Variables
            rcRecord   Reportes%ROWTYPE;
        BEGIN
        
            ut_trace.trace('Inicia LDC_PKORDENES.JOBLEGORDECARTRP.fnuGetReporteEncabezado', 2);
        
            --{
            -- Fill record
            rcRecord.REPOAPLI := 'ENCOCARTRP';
            rcRecord.REPOFECH := SYSDATE;
            rcRecord.REPOUSER := ut_session.getTerminal;
            rcRecord.REPODESC :=
                'INCONSISTENCIAS JOB DE LEGALZIACION DE ORDENES DE ENCOLAMIENTO';
            rcRecord.REPOSTEJ := NULL;
            rcRecord.REPONUME := seq.getnext ('SQ_REPORTES');

            -- Insert record
            pktblReportes.insRecord (rcRecord);
            COMMIT;
            
            ut_trace.trace('Termina LDC_PKORDENES.JOBLEGORDECARTRP.fnuGetReporteEncabezado', 2);
            
            RETURN rcRecord.Reponume;
        --}
        END;

        PROCEDURE prReporteDetalle (inuIdReporte   IN repoinco.reinrepo%TYPE,
                                    inuOrden       IN repoinco.reinval1%TYPE,
                                    isbError       IN repoinco.reinobse%TYPE,
                                    isbTipo        IN repoinco.reindes1%TYPE)
        IS
            PRAGMA AUTONOMOUS_TRANSACTION;
            -- Variables
            rcRepoinco   repoinco%ROWTYPE;
        BEGIN
        
            ut_trace.trace('Inicia LDC_PKORDENES.JOBLEGORDECARTRP.prReporteDetalle inuIdReporte: '  || inuIdReporte || chr(10) ||
                                                                                   'inuOrden: '     || inuOrden || chr(10) ||
                                                                                   'isbError: '     || isbError || chr(10) ||
                                                                                   'isbTipo: '      || isbTipo, 2);   
            
            --{
            rcRepoinco.reinrepo := inuIdReporte;
            rcRepoinco.reinval1 := inuOrden;
            rcRepoinco.reindes1 := isbTipo;
            rcRepoinco.reinobse := isbError;
            rcRepoinco.reincodi := nuConsecutivo;

            -- Insert record
            pktblRepoinco.insrecord (rcRepoinco);
            
            ut_trace.trace('Termina LDC_PKORDENES.JOBLEGORDECARTRP.prReporteDetalle ', 2);   

            COMMIT;
        EXCEPTION
            WHEN PKG_ERROR.CONTROLLED_ERROR
            THEN
                RAISE PKG_ERROR.CONTROLLED_ERROR;
            WHEN OTHERS
            THEN
                Pkg_Error.SETERROR;
                RAISE PKG_ERROR.CONTROLLED_ERROR;
        --}
        END;
    BEGIN
    
        ut_trace.trace('Inicia LDC_PKORDENES.JOBLEGORDECARTRP', 2);
    
        -- Consultamos datos para inicializar el proceso
        SELECT TO_NUMBER (TO_CHAR (SYSDATE, 'YYYY')),
               TO_NUMBER (TO_CHAR (SYSDATE, 'MM')),
               USERENV ('SESSIONID'),
               USER
          INTO nuparano,
               nuparmes,
               nutsess,
               sbparuser
          FROM DUAL;

        -- Inicializamos el proceso
        ldc_proinsertaestaprog (nuparano,
                                nuparmes,
                                'JOBLEGORDECARTRP',
                                'En ejecucion',
                                nutsess,
                                sbparuser);
  

            nuIdReporte := fnuGetReporteEncabezado;

            FOR reg IN cuGetOrdenes
            LOOP
                BEGIN
                    dtFechIni := NULL;
                    dtFechFin := NULL;
                    nuError := 0;
                    sbError := NULL;
                    SBDATOSADICIONALES := NULL;

                    IF (cugetFecheje%ISOPEN)THEN                      ---------- modificacion caso 647
                        CLOSE cugetFecheje;
                    END IF;

                    OPEN cugetFecheje (REG.ORAPORPA);
                    FETCH cugetFecheje INTO dtFechIni, dtFechFin;
                    CLOSE cugetFecheje;

                    --se valida que las fechas de ejecucion de la orden padre no sea menor a la fecha de creacion de la orden a legalizar
                    IF     reg.fecharegi > dtFechIni AND dtFechFin > reg.fecharegi THEN
                        dtFechIni := dtFechFin;
                    ELSIF dtFechFin < reg.fecharegi THEN
                        dtFechIni := SYSDATE;
                        dtFechFin := SYSDATE;
                    END IF;

                    FOR rcdato
                        IN cugetdatosAdicionales (reg.tipo, reg.tipotrab)
                    LOOP
                        IF SBDATOSADICIONALES IS NULL
                        THEN
                            SBDATOSADICIONALES :=
                                RCDATO.NAME_ATTRIBUTE || '=';
                        ELSE
                            SBDATOSADICIONALES :=
                                   SBDATOSADICIONALES
                                || ';'
                                || RCDATO.NAME_ATTRIBUTE
                                || '=';
                        END IF;

                        ut_trace.trace (
                            'Dato adicional[' || rcdato.name_attribute || ']',
                            10);
                    END LOOP;
                    
                    ut_trace.trace('Ingresa api_legalizeorders', 2);    

                    -- se procede a legalizar la orden de trabajo
                    api_legalizeorders (
                           REG.order_id
                        || '|'
                        || REG.ORAOCALE
                        || '|'
                        || REG.ORAOPELE
                        || '|'
                        || SBDATOSADICIONALES
                        || '|'
                        || reg.actividad_id
                        || '>'
                        || reg.tipo
                        || ';;;;|'
                        || '||1277;Legalizado por proceso de Encolamiento ENCOCARTRP. ',
                        dtFechIni,
                        dtFechFin,
                        NULL,
                        nuError,
                        sbError);
                        
                    ut_trace.trace('Sale api_legalizeorders nuError: ' || nuError || CHR(10) ||
                                                           'sbError: ' || sbError, 2);  

                    IF nuError = 0
                    THEN
                        COMMIT;

                        IF     reg.tipo_sol IN (100328, 100156)
                        THEN
                            BEGIN
                                LDC_NOTIFICA_CIERRE_OT (reg.order_id, 'C');
                            EXCEPTION
                                WHEN OTHERS
                                THEN
                                    Pkg_Error.seterror;
                                    Pkg_Error.geterror (nuError, sbError);
                                    nuConsecutivo := nuConsecutivo + 1;
                                    prReporteDetalle (
                                        nuIdReporte,
                                        REG.order_id,
                                        'Error al enviar correo :' || sbError,
                                        'S');
                            END;
                        END IF;
                    ELSE
                        ROLLBACK;
                        nuConsecutivo := nuConsecutivo + 1;
                        prReporteDetalle (nuIdReporte,
                                          REG.order_id,
                                          sbError,
                                          'S');
                    END IF;
                EXCEPTION
                    WHEN PKG_ERROR.CONTROLLED_ERROR
                    THEN
                        ROLLBACK;
                        Pkg_Error.geterror (nuError, sbError);
                        nuConsecutivo := nuConsecutivo + 1;
                        prReporteDetalle (nuIdReporte,
                                          REG.order_id,
                                          sbError,
                                          'S');
                    WHEN OTHERS
                    THEN
                        ROLLBACK;
                        Pkg_Error.setError;
                        Pkg_Error.geterror (nuError, sbError);
                        nuConsecutivo := nuConsecutivo + 1;
                        prReporteDetalle (nuIdReporte,
                                          REG.order_id,
                                          sbError,
                                          'S');
                END;
            END LOOP;

        ldc_proactualizaestaprog (nutsess,
                                  sbError,
                                  'JOBLEGORDECARTRP',
                                  'Ok');
                                  
        ut_trace.trace('Termina LDC_PKORDENES.JOBLEGORDECARTRP', 2);        

    EXCEPTION
        WHEN PKG_ERROR.CONTROLLED_ERROR
        THEN
            Pkg_Error.geterror (nuError, sbError);
            ut_trace.trace('PKG_ERROR.CONTROLLED_ERROR LDC_PKORDENES.JOBLEGORDECARTRP nuError: '  || nuError || chr(10) ||
                                                                                      'sbError: ' || sbError, 2);  
            ldc_proactualizaestaprog (nutsess,
                                      sbError,
                                      'JOBLEGORDECARTRP',
                                      'ERROR');
        WHEN OTHERS
        THEN
            Pkg_Error.setError;
            Pkg_Error.geterror (nuError, sbError);
            ut_trace.trace('PKG_ERROR.CONTROLLED_ERROR LDC_PKORDENES.JOBLEGORDECARTRP nuError: '  || nuError || chr(10) ||
                                                                                      'sbError: ' || sbError, 2);  
            ldc_proactualizaestaprog (nutsess,
                                      sbError,
                                      'JOBLEGORDECARTRP',
                                      'ERROR');
    END JOBLEGORDECARTRP;
END LDC_PKORDENES;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKORDENES','OPEN');
END;
/