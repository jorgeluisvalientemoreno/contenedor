CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_BOTRABAJOADICIONAL IS

  PROCEDURE PROLEGALIZAOTXML(
                             /**************************************************************************
                                                                                                                                                                                  Autor       : Luis Javier Lopez Barrios / Horbath
                                                                                                                                                                                  Fecha       : 2015-11-03
                                                                                                                                                                                  Descripcion : Registramos informacion de las ordenes con trabajos adicionales provenientes de xml

                                                                                                                                                                                  Parametros Entrada
                                                                                                                                                                                  sxmlotxml clob


                                                                                                                                                                                  Valor de salida
                                                                                                                                                                                    sbmen  mensaje
                                                                                                                                                                                    error  codigo del error

                                                                                                                                                                                 HISTORIA DE MODIFICACIONES
                                                                                                                                                                                   FECHA           AUTOR                       DESCRIPCION

                                                                                                                                                                                   ***************************************************************************/sxmlotxml CLOB,
                             sbmensa   OUT VARCHAR2,
                             error     OUT NUMBER);

END LDCI_BOTRABAJOADICIONAL;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_BOTRABAJOADICIONAL IS

  PROCEDURE PROEJECUTAORDEN(inuOrden  IN or_order.order_id%TYPE,
                            inuCausal IN or_order.causal_id%TYPE,
                            onuOk     OUT NUMBER,
                            osbError  OUT VARCHAR2) IS
    /**************************************************************************
     Autor       : Luis Javier Lopez Barrios / Horbath
     Fecha       : 2018-07-31
     Ticket       : 200-2017
     Descripcion : Proceso que se encarga de ejecutar la orden de trabajo

     Parametros Entrada
     inuOrden numero de orden
     inuCausal causal

     Valor de salida
       osbError  mensaje
       onuOk  codigo del error

    HISTORIA DE MODIFICACIONES
      FECHA           AUTOR                       DESCRIPCION

      ***************************************************************************/

  BEGIN
    Or_BoEjecutarOrden.ExecOrderWithCausal(inuOrden,
                                           inuCausal,
                                           null,
                                           null,
                                           sysdate);
    onuOk := 0;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      ERRORS.GETERROR(onuOk, osbError);
      raise ex.CONTROLLED_ERROR;

    WHEN OTHERS THEN
      ROLLBACK;
      onuOk    := -1;
      osbError := 'Error en el proceso LDCI_BOTRABAJOADICIONAL.PROEJECUTAORDEN ' ||
                  sqlerrm;
  END PROEJECUTAORDEN;

  PROCEDURE PROLEGALIZAOTXML(
                             /**************************************************************************
                                                            Autor       : Luis Javier Lopez Barrios / Horbath
                                                            Fecha       : 2018-07-31
                                                            Ticket       : 200-2017
                                                            Descripcion : Registramos informacion de las ordenes con trabajos adicionales provenientes de xml

                                                            Parametros Entrada
                                                            sxmlotxml clob


                                                            Valor de salida
                                                            sbmen  mensaje
                                                            error  codigo del error

                                                            HISTORIA DE MODIFICACIONES
                                                            FECHA           AUTOR                       DESCRIPCION

                                                            06/09/2018       LJLB                        200-2017 - se valida fecha de inicio y final de ejecucion se arregla tag del xml para fechas de ejecucion
                                                            13/09/2018     dsaltarin                    200-2173 se cambia actualiza la fecha de ejecuci¿n de la orden con la que viene de la integracion.
                                                            22/02/2020      HT                         CA 33 se adiciona logica para insertar datos adicionales
                                                            09/04/2021    DANVAL                     Caso 658_1: Se corrige el proceso de manejo de Datos Adicionales del XML
                                                            07/07/2021    DANVAL                     Caso 658_3: Se corrige problema del manejo de variables extensas al momento de convertirlas
                                                            19/11/2021    DANVAL                     cASO 658_4: Se registra en tabla proceso del XML
                                                            ***************************************************************************/sxmlotxml CLOB,
                             sbmensa   OUT VARCHAR2,
                             error     OUT NUMBER) IS

    nuerror NUMBER(3);

    nuEstaAsig or_order.order_status_id%type := dald_parameter.fnuGetNumeric_Value('ESTADO_ASIGNADO',
                                                                                   NULL); --TICKET 200-2017 LJLB-- se almacena el estado asignada de una orden V1
    -- nuEstaAnul    or_order.order_status_id%type := dald_parameter.fnuGetNumeric_Value('EST_ANU_OT_LEGO', NULL); --TICKET 200-2017 LJLB-- se almacena el estado anulado de una orden V2
    nuEstaOt     or_order.order_status_id%type; --TICKET 200-2017 LJLB-- se almacena el estado legalizado de la orden actual V3
    nuExiOrdlego NUMBER; --TICKET 200-2017 LJLB--  se almacena resultado del cursor CUOTLEGOGETIONADA V4
    nuExiOrdOsf  NUMBER; --TICKET 200-2017 LJLB--  se almacena resultado del cursor CUOTEXISTEOSF V5
    nuorder      or_order.order_id%TYPE; --TICKET 200-2017 LJLB--  se almacena codigo de la orden actual V9
    nuTitr       or_order.task_type_id%TYPE; --TICKET 200-2017 LJLB--  se almacena codigo del tipo del trabajo V10
    nuActiTitr   ge_items.items_id%type; --TICKET 200-2017 LJLB--  se almacena codigo de la actividad del tipo de trabajo V11
    nuItems      ge_items.items_id%type; --TICKET 200-2017 LJLB--  se almacena codigo del items V12

    --TICKET 200-2017 LJLB-- se consulta ordenes de trabajo adicional
    --Caso 658_1: Se bloquea el uso de este cursor para ser reemplazado
    /*CURSOR cotstrabadic(xmlottrabadic clob) IS

    SELECT Enc.Orden_padre,
           Enc.Causal_padre,
           Enc.ini_ejec_padre      ini_ejec_padre,
           Enc.fin_ejec_padre      fin_ejec_padre,
           Enc.observ_padre,
           Enc.tecnico_padre,
           Enc.XMLOrdenesdatosAdpa,
           Det.TipoTrabAdic,
           Det.activAdic,
           Det.Causal_Ot_Adic,
           Det.observaAdic,
           Det.Tecnico_Ot_Adic,
           det.XMLOrdenesDatoHija,
           detitem.itemtrabadi,
           detitem.catntrabadi
      FROM XMLTable('/legalizacionOrden/orden' Passing
                    XMLType(xmlottrabadic) Columns Orden_padre NUMBER Path
                    'idOrden',
                    Causal_padre NUMBER Path 'idCausal',
                    ini_ejec_padre VARCHAR2(30) PATH 'fechaIniEjec',
                    fin_ejec_padre VARCHAR2(30) PATH 'fechaFinEjec',
                    observ_padre VARCHAR2(2000) PATH 'observ_padre',
                    tecnico_padre NUMBER Path 'idTecnico',
                    XMLOrdenesAdicionales XMLType Path 'ordenesAdic',
                    --TICKET 33 HT --se agrega xml datos adicionales
                    XMLOrdenesdatosAdpa XMLType Path 'DatosAdic') As Enc, --
           XMLTable('/ordenesAdic/ordenAdic' Passing
                    Enc.XMLOrdenesAdicionales Columns TipoTrabAdic NUMBER Path
                    'idTipoTrab',
                    activAdic NUMBER Path 'idActividad',
                    Causal_Ot_Adic NUMBER Path 'idCausal',
                    observaAdic VARCHAR2(2000) Path 'observacion',
                    Tecnico_Ot_Adic VARCHAR2(200) Path 'idTecnico',
                    XMLitemsotadic XMLType Path 'items',
                    --TICKET 33 HT --se agrega xml datos adicionales
                    XMLOrdenesDatoHija XMLType Path 'DatosAdic') As Det,
           XMLTable('/items/item' Passing det.XMLitemsotadic Columns
                    itemtrabadi NUMBER Path 'idItem',
                    catntrabadi NUMBER Path 'cantidad') AS Detitem
    UNION
    SELECT Enc.Orden_padre,
           Enc.Causal_padre,
           Enc.ini_ejec_padre      ini_ejec_padre,
           Enc.fin_ejec_padre      fin_ejec_padre,
           Enc.observ_padre,
           Enc.tecnico_padre,
           enc.XMLOrdenesdatosAdpa,
           null                    TipoTrabAdic,
           null                    activAdic,
           null                    Causal_Ot_Adic,
           null                    observaAdic,
           null                    Tecnico_Ot_Adic,
           null                    XMLOrdenesDatoHija,
           null                    itemtrabadi,
           null                    catntrabadi
      FROM XMLTable('/legalizacionOrden/orden' Passing
                    XMLType(xmlottrabadic) Columns Orden_padre NUMBER Path
                    'idOrden',
                    Causal_padre NUMBER Path 'idCausal',
                    ini_ejec_padre VARCHAR2(30) PATH 'fechaIniEjec',
                    fin_ejec_padre VARCHAR2(30) PATH 'fechaFinEjec',
                    observ_padre VARCHAR2(2000) PATH 'observ_padre',
                    tecnico_padre NUMBER Path 'idTecnico',
                    XMLOrdenesAdicionales XMLType Path 'ordenesAdic',
                    --TICKET 33 HT --se agrega xml datos adicionales
                    XMLOrdenesdatosAdpa XMLType Path 'DatosAdic') As Enc
     WHERE existsNode(XMLOrdenesAdicionales, '/ordenesAdic/ordenAdic') = 0;*/

    --658_4 cursores para lectura XML
    CURSOR cursor1(xmlin clob) IS
      SELECT Enc.Orden_padre,
             Enc.Causal_padre,
             Enc.ini_ejec_padre ini_ejec_padre,
             Enc.fin_ejec_padre fin_ejec_padre,
             Enc.observ_padre,
             Enc.tecnico_padre,
             enc.XMLOrdenesdatosAdpa,
             null TipoTrabAdic,
             null activAdic,
             null Causal_Ot_Adic,
             null observaAdic,
             null Tecnico_Ot_Adic,
             enc.XMLOrdenesdatosAdpa XMLOrdenesDatoHija,
             null itemtrabadi,
             null catntrabadi,
             case
               when XMLEXISTS('/DatosAdic/DatoAdic' passing by ref
                              Enc.XMLOrdenesdatosAdpa) THEN
                1
               ELSE
                0
             END AS datoAdicionalPadre,
             0 AS datoAdicionalHija
        FROM XMLTable('/legalizacionOrden/orden' Passing XMLType(xmlin)
                      Columns Orden_padre NUMBER Path 'idOrden',
                      Causal_padre NUMBER Path 'idCausal',
                      ini_ejec_padre VARCHAR2(30) PATH 'fechaIniEjec',
                      fin_ejec_padre VARCHAR2(30) PATH 'fechaFinEjec',
                      observ_padre VARCHAR2(2000) PATH 'observ_padre',
                      tecnico_padre NUMBER Path 'idTecnico',
                      XMLOrdenesdatosAdpa XMLType Path 'DatosAdic') As Enc
       WHERE existsNode(XMLType(xmlin),
                        '/legalizacionOrden/orden/ordenesAdic/ordenAdic') IN (0);

    CURSOR cursor2(xmlin clob) IS
      SELECT Enc.Orden_padre,
             Enc.Causal_padre,
             Enc.ini_ejec_padre ini_ejec_padre,
             Enc.fin_ejec_padre fin_ejec_padre,
             Enc.observ_padre,
             Enc.tecnico_padre,
             Enc.XMLOrdenesdatosAdpa,
             Det.TipoTrabAdic,
             Det.activAdic,
             Det.Causal_Ot_Adic,
             Det.observaAdic,
             Det.Tecnico_Ot_Adic,
             det.XMLOrdenesDatoHija,
             detitem.itemtrabadi,
             detitem.catntrabadi,
             case
               when XMLEXISTS('/DatosAdic/DatoAdic' passing by ref
                              Enc.XMLOrdenesdatosAdpa) then
                1
               else
                0
             end AS datoAdicionalPadre,
             case
               when XMLEXISTS('/DatosAdic/DatoAdic' passing by ref
                              det.XMLOrdenesDatoHija) THEN
                1
               ELSE
                0
             END AS datoAdicionalHija
        FROM XMLTable('/legalizacionOrden/orden' Passing XMLType(xmlin)
                      Columns Orden_padre NUMBER Path 'idOrden',
                      Causal_padre NUMBER Path 'idCausal',
                      ini_ejec_padre VARCHAR2(30) PATH 'fechaIniEjec',
                      fin_ejec_padre VARCHAR2(30) PATH 'fechaFinEjec',
                      observ_padre VARCHAR2(2000) PATH 'observ_padre',
                      tecnico_padre NUMBER Path 'idTecnico',
                      XMLOrdenesAdicionales XMLType Path 'ordenesAdic',
                      XMLOrdenesdatosAdpa XMLType Path 'DatosAdic') As Enc,
             XMLTable('/ordenesAdic/ordenAdic' Passing
                      Enc.XMLOrdenesAdicionales Columns TipoTrabAdic NUMBER Path
                      'idTipoTrab',
                      activAdic NUMBER Path 'idActividad',
                      Causal_Ot_Adic NUMBER Path 'idCausal',
                      observaAdic VARCHAR2(2000) Path 'observacion',
                      Tecnico_Ot_Adic VARCHAR2(200) Path 'idTecnico',
                      XMLitemsotadic XMLType Path 'items',
                      XMLOrdenesDatoHija XMLType Path 'DatosAdic') As Det,
             XMLTable('/items/item' Passing det.XMLitemsotadic Columns
                      itemtrabadi NUMBER Path 'idItem',
                      catntrabadi NUMBER Path 'cantidad') AS Detitem
       WHERE existsNode(XMLType(xmlin),
                        '/legalizacionOrden/orden/ordenesAdic/ordenAdic') NOT IN (0);

    /*vxml_Orden_padre         NUMBER;
    vxml_Causal_padre        NUMBER;
    vxml_ini_ejec_padre      VARCHAR2(30);
    vxml_fin_ejec_padre      VARCHAR2(30);
    vxml_observ_padre        VARCHAR2(2000);
    vxml_tecnico_padre       NUMBER;
    vxml_XMLOrdenesdatosAdpa XMLType;
    vxml_TipoTrabAdic        NUMBER;
    vxml_activAdic           NUMBER;
    vxml_Causal_Ot_Adic      NUMBER;
    vxml_observaAdic         VARCHAR2(2000);
    vxml_Tecnico_Ot_Adic     VARCHAR2(200);
    vxml_XMLOrdenesDatoHija  XMLType;
    vxml_XMLOrdenesDatoHija1 varchar2(100);
    vxml_itemtrabadi         NUMBER;
    vxml_catntrabadi         NUMBER;
    vxml_datoAdicionalPadre  number;
    vxml_datoAdicionalHija   number;*/

    ---

    --TICKET 200-2017 LJLB--Se consultas ordenes de trabajo adicional
    CURSOR GetTrabAdic(xmlottrabadic clob) IS
      SELECT Enc.Orden_padre,
             Enc.Causal_padre,
             Enc.ini_ejec_padre  ini_ejec_padre,
             Enc.fin_ejec_padre  fin_ejec_padre,
             Enc.observ_padre,
             Enc.tecnico_padre,
             Det.TipoTrabAdic,
             Det.activAdic,
             Det.Causal_Ot_Adic,
             Det.observaAdic,
             Det.Tecnico_Ot_Adic,
             detitem.itemtrabadi,
             detitem.catntrabadi
        FROM XMLTable('/legalizacionOrden/orden' Passing
                      XMLType(xmlottrabadic) Columns Orden_padre NUMBER Path
                      'idOrden',
                      Causal_padre NUMBER Path 'idCausal',
                      ini_ejec_padre VARCHAR2(30) PATH 'fechaIniEjec',
                      fin_ejec_padre VARCHAR2(30) PATH 'fechaFinEjec',
                      observ_padre VARCHAR2(2000) PATH 'observ_padre',
                      tecnico_padre NUMBER Path 'idTecnico',
                      XMLOrdenesAdicionales XMLType Path 'ordenesAdic') As Enc,
             XMLTable('/ordenesAdic/ordenAdic' Passing
                      Enc.XMLOrdenesAdicionales Columns TipoTrabAdic NUMBER Path
                      'idTipoTrab',
                      activAdic NUMBER Path 'idActividad',
                      Causal_Ot_Adic NUMBER Path 'idCausal',
                      observaAdic VARCHAR2(2000) Path 'observacion',
                      Tecnico_Ot_Adic VARCHAR2(200) Path 'idTecnico',
                      XMLitemsotadic XMLType Path 'items') As Det,
             XMLTable('/items/item' Passing det.XMLitemsotadic Columns
                      itemtrabadi NUMBER Path 'idItem',
                      catntrabadi NUMBER Path 'cantidad') AS Detitem
      UNION
      SELECT Enc.Orden_padre,
             Enc.Causal_padre,
             Enc.ini_ejec_padre ini_ejec_padre,
             Enc.fin_ejec_padre fin_ejec_padre,
             Enc.observ_padre,
             Enc.tecnico_padre,
             null               TipoTrabAdic,
             null               activAdic,
             null               Causal_Ot_Adic,
             null               observaAdic,
             null               Tecnico_Ot_Adic,
             null               itemtrabadi,
             null               catntrabadi
        FROM XMLTable('/legalizacionOrden/orden' Passing
                      XMLType(xmlottrabadic) Columns Orden_padre NUMBER Path
                      'idOrden',
                      Causal_padre NUMBER Path 'idCausal',
                      ini_ejec_padre VARCHAR2(30) PATH 'fechaIniEjec',
                      fin_ejec_padre VARCHAR2(30) PATH 'fechaFinEjec',
                      observ_padre VARCHAR2(2000) PATH 'observ_padre',
                      tecnico_padre NUMBER Path 'idTecnico',
                      XMLOrdenesAdicionales XMLType Path 'ordenesAdic') As Enc
       WHERE existsNode(XMLOrdenesAdicionales, '/ordenesAdic/ordenAdic') = 0;

    --TICKET 200-2017 LJLB--se consulta estado de la orden
    cursor cuEstaOt(inuorder_id or_order.order_id%type) is
      select order_status_id from or_order where order_id = inuorder_id;

    --TICKET 200-2017 LJLB--se valida si la orden ya existe en LEGO
    CURSOR CUOTLEGOGETIONADA(nuorden or_order.order_id%TYPE) IS
      SELECT COUNT(1) FROM LDC_OTLEGALIZAR WHERE ORDER_ID = nuorden;

    --TICKET 200-2017 LJLB-- se valida si la orden existe en OSF
    CURSOR CUOTEXISTEOSF(nuorden or_order.order_id%TYPE) IS
      SELECT COUNT(1) FROM OR_ORDER WHERE ORDER_ID = nuorden;

    --TICKET 200-2017 LJLB-- se consulta informacion de la orden de OSF
    CURSOR CUOTOSF(nuorden or_order.order_id%TYPE) IS
      SELECT * FROM OR_ORDER WHERE ORDER_ID = nuorden;

    regOrden CUOTOSF%rowtype; --TICKET 200-2017 LJLB-- se crea registro de ordenes V7

    --TICKET 200-2017 LJLB-- se consulta informacion del tecnico de la orden
    CURSOR CUUSUALEGO(nuPerson LDC_USUALEGO.PERSON_ID%TYPE) IS
      SELECT * FROM LDC_USUALEGO WHERE PERSON_ID = nuPerson;

    regTecnico CUUSUALEGO%rowtype; --TICKET 200-2017 LJLB-- se crea registro de tecnico V8}

    --TICKET 200-2017 LJLB-- se valida tecnico de la orden
    CURSOR CUVALIUSUALEGO(nuPerson LDC_USUALEGO.PERSON_ID%TYPE) IS
      SELECT 'X' FROM LDC_USUALEGO WHERE PERSON_ID = nuPerson;

    --TICKET 200-2017 LJLB-- se valida causal asociada al tipo de trabajo
    CURSOR cuValidaCausal(nuTitr   or_order.task_type_id%TYPE,
                          nucausal or_order.causal_id%TYPE) IS
      SELECT 'X'
        FROM or_task_type_causal
       WHERE TASK_TYPE_ID = nuTitr
         AND causal_id = nucausal;

    --TICKET 200-2017 LJLB-- se valida si la unidad y la activdad esta configurada como ofertada
    CURSOR cuUnidadOfertada(nuUnidad ldc_item_uo_lr.unidad_operativa%TYPE) IS
      SELECT 'X'
        FROM OPEN.ldc_const_unoprl liuol
       WHERE liuol.unidad_operativa = nuUnidad;

    --TICKET 200-2017 LJLB-- se valida items no ofertados asociada al tipo de trabajo
    CURSOR cuValidaItemsNoOfer(nuTitr  or_order.task_type_id%TYPE,
                               nuitems or_task_types_items.ITEMS_ID%TYPE) IS
      SELECT 'X'
        FROM LDC_OR_TASK_TYPES_MATERIALES
       WHERE TIPO_TRABAJO = nuTitr
         AND CODIGO_MATERIAL = nuitems
         AND (SELECT count(LIUL.ITEM)
                FROM LDC_ITEM_UO_LR LIUL
               WHERE LIUL.ITEM = CODIGO_MATERIAL) = 0;

    --TICKET 200-2017 LJLB-- se valida items  ofertados asociada al tipo de trabajo
    CURSOR cuValidaItemsOfer(nuTitr      or_order.task_type_id%TYPE,
                             nuitems     or_task_types_items.ITEMS_ID%TYPE,
                             nuactividad LDC_ITEM_UO_LR.ACTIVIDAD%TYPE,
                             nuUnidad    LDC_ITEM_UO_LR.UNIDAD_OPERATIVA%TYPE) IS
      SELECT 'X'
        FROM LDC_OR_TASK_TYPES_MATERIALES it
       WHERE it.TIPO_TRABAJO = nuTitr
         AND it.CODIGO_MATERIAL = nuitems
         AND (SELECT count(LIUL.ITEM)
                FROM LDC_ITEM_UO_LR LIUL
               WHERE LIUL.ITEM = nuitems
                 AND ACTIVIDAD = nuactividad
                 AND UNIDAD_OPERATIVA = nuUnidad) > 0;

    --TICKET 200-2017 LJLB-- se valida que los tipo de trabajo adicionales esten configurados para el titr padre
    CURSOR cuValidaTitrAdic(nuTitr    or_order.task_type_id%TYPE,
                            nuTitrADI or_order.task_type_id%TYPE) IS
      SELECT 'X'
        FROM LDC_TIPOTRABADICLEGO
       WHERE TIPOTRABLEGO_ID = nuTitr
         AND TIPOTRABADICLEGO_ID = nuTitrADI;

    CURSOR cuValidaUnidad(nuUnidad NUMBER, nuPerson NUMBER) IS
      SELECT 'X'
        FROM or_oper_unit_persons
       WHERE OPERATING_UNIT_ID = nuUnidad
         AND PERSON_ID = nuPerson;

    sbDato VARCHAR2(1); --TICKET 200-2017 LJLB-- Se almacena datos

    dtFechaEjeIni DATE; --TICKET 200-2017 LJLB-- Se almacena
    dtFechaEjeFin DATE; --TICKET 200-2017 LJLB--

    --INICIO CA 33
    --se deserializa xml datos adicionales
    CURSOR cuDatoAdiOtPa(XMLDatosAdicionales XmlType) IS
      SELECT *
        FROM XMLTable('/DatosAdic/DatoAdic' Passing XMLDatosAdicionales
                      Columns idDato VARCHAR2(100) Path 'idDato',
                      ValorDato VARCHAR2(4000) Path 'ValorDato') As DatoAord;

    sbAplicaEnt33 VARCHAR2(1) := 'N'; --se almacena si aplica la entrega
    --FIN CA 33

    --Caso 658_1
    nuidorden number;

    TYPE xml_rt IS RECORD(
      Orden_padre         NUMBER,
      Causal_padre        NUMBER,
      ini_ejec_padre      VARCHAR2(30),
      fin_ejec_padre      VARCHAR2(30),
      observ_padre        VARCHAR2(2000),
      tecnico_padre       NUMBER,
      XMLOrdenesdatosAdpa XMLType,
      TipoTrabAdic        NUMBER,
      activAdic           NUMBER,
      Causal_Ot_Adic      NUMBER,
      observaAdic         VARCHAR2(2000),
      Tecnico_Ot_Adic     VARCHAR2(200),
      XMLOrdenesDatoHija  XMLType,
      itemtrabadi         NUMBER,
      catntrabadi         NUMBER,
      datoAdicionalPadre  number,
      datoAdicionalHija   number);

    TYPE xml_aat IS TABLE OF xml_rt INDEX BY PLS_INTEGER;

    i_xml xml_aat;

    --l_cursor SYS_REFCURSOR;
    --
    --Caso 658_3
    --xy XMLTYPE;
    --CA 658_4
    nuOrdenReg number;
    --

  BEGIN
    --TICKET 200-2017 LJLB--  Se inicializan variables de error
    nuerror := -1;
    sbmensa := NULL;
    error   := 0;
    --se valida si aplica entrega 33
    IF FBLAPLICAENTREGAXCASO('0000033') THEN
      sbAplicaEnt33 := 'S';
    END IF;
    -- se carga informacion de las ordenes
    FOR i IN GetTrabAdic(sxmlotxml) LOOP
      nuEstaOt := null;

      IF NVL(nuorder, 0) <> i.orden_padre THEN
        nuorder    := i.orden_padre;
        nuOrdenReg := nuorder;
        --TICKET 200-2017 LJLB--se valida estado de la orden (estado legalizable)
        open cuEstaOt(nuorder);
        fetch cuEstaOt
          into nuEstaOt;
        close cuEstaOt;
        --TICKET 200-2017 LJLB-- se valida que la orden no se encuentre anulada o legalizada
        if INSTR(dald_parameter.fsbGetValue_Chain('LDC_ESTAPERLEGO', NULL),
                 nuEstaOt) = 0 then
          sbmensa := 'La orden[' || to_char(nuorder) ||
                     '] principal no se encuentra en un estado valido para LEGO, validar estados en el parametro LDC_ESTAPERLEGO';
          error   := -1;
          exit;
        end if;
        --TICKET 200-2017 LJLB--  se consulta si existe la orden en LEGO
        OPEN CUOTLEGOGETIONADA(nuorder);
        FETCH CUOTLEGOGETIONADA
          INTO nuExiOrdlego;
        CLOSE CUOTLEGOGETIONADA;

        IF nuExiOrdlego = 1 THEN
          sbmensa := 'La orden[' || to_char(nuorder) ||
                     '] principal ya fue gestionada en LEGO.';
          error   := -1;
          exit;
        END IF;

        --TICKET 200-2017 LJLB--  se consulta si existe la orden en OSF
        OPEN CUOTEXISTEOSF(nuorder);
        FETCH CUOTEXISTEOSF
          INTO nuExiOrdOsf;
        CLOSE CUOTEXISTEOSF;

        IF nuExiOrdOsf = 0 THEN
          sbmensa := 'La orden[' || to_char(nuorder) ||
                     '] principal no existe en el sistema.';
          error   := -1;
          exit;
        END IF;

        --TICKET 200-2017 LJLB-- se carga registro de la orden padre
        OPEN CUOTOSF(i.orden_padre);
        FETCH CUOTOSF
          INTO regOrden;
        CLOSE CUOTOSF;

        --TICKET 200-2017 LJLB--  se valida causal este configurado al tipo de trabajo padre
        OPEN cuValidaCausal(regOrden.task_type_id, i.Causal_padre);
        FETCH cuValidaCausal
          INTO sbDato;
        IF cuValidaCausal%NOTFOUND THEN
          sbmensa := 'orden[' || to_char(nuorder) || '], causal [' ||
                     i.Causal_padre ||
                     '] no esta asociado al tipo de trabajo padre[' ||
                     regOrden.task_type_id || ']';
          error   := -1;
          CLOSE cuValidaCausal;
          exit;
        END IF;
        CLOSE cuValidaCausal;

        --TICKET 200-2017 LJLB--  se consulta informacion del tecnico
        OPEN CUVALIUSUALEGO(I.tecnico_padre);
        FETCH CUVALIUSUALEGO
          INTO sbDato;
        IF CUVALIUSUALEGO%NOTFOUND THEN
          sbmensa := 'El tecnico[' || to_char(i.tecnico_padre) ||
                     '] no existe en el comando LDCLEGO.';
          error   := -1;
          CLOSE CUVALIUSUALEGO;
          exit;
        END IF;
        CLOSE CUVALIUSUALEGO;

        --TICKET 200-2017 LJLB--  se consulta informacion del tecnico
        OPEN cuValidaUnidad(regOrden.OPERATING_UNIT_ID, I.tecnico_padre);
        FETCH cuValidaUnidad
          INTO sbDato;
        IF cuValidaUnidad%NOTFOUND THEN
          sbmensa := 'El tecnico[' || to_char(i.tecnico_padre) ||
                     '] no esta asociado a la unidad [' ||
                     regOrden.OPERATING_UNIT_ID || '-' ||
                     DAOR_OPERATING_UNIT.FSBGETNAME(regOrden.OPERATING_UNIT_ID,
                                                    null) || ']';
          error   := -1;
          CLOSE cuValidaUnidad;
          exit;
        END IF;
        CLOSE cuValidaUnidad;

        --TICKET 200-2017 LJLB-- se valida que las fechas de ejecucion no esten vacias
        IF i.ini_ejec_padre IS NULL OR i.fin_ejec_padre IS NULL THEN
          sbmensa := 'orden[' || to_char(nuorder) ||
                     '] fechas de ejecucion no pueden estar vacias, por favor validar.';
          error   := -1;
          exit;
        END IF;
        --TICKET 200-2017 LJLB-- se valida quwe las fechas traigan el formato adecuado
        BEGIN
          dtFechaEjeIni := TO_DATE(i.ini_ejec_padre,
                                   'DD/MM/YYYY HH24:MI:SS');
          dtFechaEjeFin := TO_DATE(i.fin_ejec_padre,
                                   'DD/MM/YYYY HH24:MI:SS');

          IF dtFechaEjeIni > dtFechaEjeFin THEN
            sbmensa := 'orden[' || to_char(nuorder) ||
                       '] fecha inicial de ejecucion es mayor que la fecha final de ejecucion, por favor validar.';
            error   := -1;
            exit;
          END IF;
        EXCEPTION
          WHEN OTHERS THEN
            sbmensa := 'orden[' || to_char(nuorder) ||
                       '] fechas de ejecucion no tienen el formato dd/mm/yyyy hh24:mi:ss, por favor validar.';
            error   := -1;
            exit;
        END;

      END IF;

      IF i.TipoTrabAdic IS NOT NULL THEN
        --TICKET 200-2017 LJLB--  se valida que el tipo de trabajo adicional este asociado al tipo de trabajo padre
        OPEN cuValidaTitrAdic(regOrden.task_type_id, i.TipoTrabAdic);
        FETCH cuValidaTitrAdic
          INTO sbDato;
        IF cuValidaTitrAdic%NOTFOUND THEN
          sbmensa := sbmensa || '|' || ' orden[' || to_char(nuorder) ||
                     '], tipo de trabajo adicional [' || i.TipoTrabAdic ||
                     '] no esta asociado al tipo de trabajo padre [' ||
                     regOrden.task_type_id || ']';
          error   := -1;
          --  exit;
        END IF;
        CLOSE cuValidaTitrAdic;

        --TICKET 200-2017 LJLB--  se valida causal este configurado al tipo de trabajo adicional
        OPEN cuValidaCausal(i.TipoTrabAdic, i.Causal_Ot_Adic);
        FETCH cuValidaCausal
          INTO sbDato;
        IF cuValidaCausal%NOTFOUND THEN
          sbmensa := sbmensa || '|' || ' orden[' || to_char(nuorder) ||
                     '], causal [' || i.Causal_Ot_Adic ||
                     '] no esta asociado al tipo de trabajo adicional[' ||
                     i.TipoTrabAdic || ']';
          error   := -1;
          --exit;
        END IF;
        CLOSE cuValidaCausal;

        --TICKET 200-2017 LJLB--  se valida si la unidad operativa y actividad adicional este como ofertada
        OPEN cuUnidadOfertada(regOrden.OPERATING_UNIT_ID);
        FETCH cuUnidadOfertada
          INTO sbDato;
        IF cuUnidadOfertada%NOTFOUND THEN
          --TICKET 200-2017 LJLB--  se valida que el items este asociado al tipo de trabajoa dicional y no sea ofertado
          OPEN cuValidaItemsNoOfer(i.TipoTrabAdic, I.itemtrabadi);
          FETCH cuValidaItemsNoOfer
            INTO sbDato;
          IF cuValidaItemsNoOfer%NOTFOUND THEN
            sbmensa := sbmensa || '|' || ' orden[' || to_char(nuorder) ||
                       '], items no ofertado [' || I.itemtrabadi ||
                       '] no esta asociado al tipo de trabajo adicional[' ||
                       i.TipoTrabAdic || ']';
            error   := -1;
            -- exit;
          END IF;
          CLOSE cuValidaItemsNoOfer;
        ELSE
          --TICKET 200-2017 LJLB--  se valida que el items este asociado al tipo de trabajo adicional y sea ofertado
          OPEN cuValidaItemsOfer(i.TipoTrabAdic,
                                 I.itemtrabadi,
                                 i.activAdic,
                                 RegOrden.OPERATING_UNIT_ID);
          FETCH cuValidaItemsOfer
            INTO sbDato;
          IF cuValidaItemsOfer%NOTFOUND THEN
            sbmensa := sbmensa || '|' || ' orden[' || to_char(nuorder) ||
                       '], no existe configuracion de ofertado para el items [' ||
                       I.itemtrabadi || '], actividad [' || i.activAdic ||
                       '] y unidad operativa [' ||
                       RegOrden.OPERATING_UNIT_ID ||
                       '] asociado al tipo de trabajo adicional [' ||
                       i.TipoTrabAdic || ']';
            error   := -1;
            -- exit;
          END IF;
          CLOSE cuValidaItemsOfer;
        END IF;
        CLOSE cuUnidadOfertada;

      END IF;

    END LOOP;
    --TICKET 200-2017 LJLB--  si no hubo error se procede a insertar las ordenes
    IF error = 0 THEN
      --TICKET 200-2017 LJLB--  se recorre ordenes del xml
      nuorder := 0;
      --Caso 658_1: se cambio el origen del cursor
      SELECT existsNode(XMLType(sxmlotxml),
                        '/legalizacionOrden/orden/ordenesAdic/ordenAdic')
        into nuidorden
        FROM dual;

      --Caso 658_3: se asigna el XML
      --xy:= XMLTYPE.CREATEXML(sxmlotxml);
      --

      --Caso 658_3: se cambia la instruccion sxmlotxml por xy.EXTRACT('/').getclobval()
      /*if nuidorden = 0 then
          OPEN l_cursor FOR
         'SELECT Enc.Orden_padre,
                Enc.Causal_padre,
                Enc.ini_ejec_padre ini_ejec_padre,
                Enc.fin_ejec_padre fin_ejec_padre,
                Enc.observ_padre,
                Enc.tecnico_padre,
                enc.XMLOrdenesdatosAdpa,
                null TipoTrabAdic,
                null activAdic,
                null Causal_Ot_Adic,
                null observaAdic,
                null Tecnico_Ot_Adic,
                NULL XMLOrdenesDatoHija,
                null itemtrabadi,
                null catntrabadi,
                case
                  when XMLEXISTS(''/DatosAdic/DatoAdic'' passing by ref
                                 Enc.XMLOrdenesdatosAdpa) THEN
                   1
                  ELSE
                   0
                END AS datoAdicionalPadre,
                0 AS datoAdicionalHija
           FROM XMLTable(''/legalizacionOrden/orden'' Passing
                         XMLType(''' || xy.EXTRACT('/').getclobval() ||
                      ''') Columns Orden_padre NUMBER Path
                         ''idOrden'',
                         Causal_padre NUMBER Path ''idCausal'',
                         ini_ejec_padre VARCHAR2(30) PATH ''fechaIniEjec'',
                         fin_ejec_padre VARCHAR2(30) PATH ''fechaFinEjec'',
                         observ_padre VARCHAR2(2000) PATH ''observ_padre'',
                         tecnico_padre NUMBER Path ''idTecnico'',
                         --XMLOrdenesAdicionales XMLType Path ''ordenesAdic'',
                         XMLOrdenesdatosAdpa XMLType Path ''DatosAdic'') As Enc
                         WHERE existsNode(XMLType(''' ||
                      xy.EXTRACT('/').getclobval() ||
                      '''),
                         ''/legalizacionOrden/orden/ordenesAdic/ordenAdic'') IN (0)';

      FETCH l_cursor BULK COLLECT INTO i_xml;

      CLOSE l_cursor;

         ELSE
            OPEN l_cursor FOR
         'SELECT Enc.Orden_padre,
              Enc.Causal_padre,
              Enc.ini_ejec_padre ini_ejec_padre,
              Enc.fin_ejec_padre fin_ejec_padre,
              Enc.observ_padre,
              Enc.tecnico_padre,
              Enc.XMLOrdenesdatosAdpa,
              Det.TipoTrabAdic,
              Det.activAdic,
              Det.Causal_Ot_Adic,
              Det.observaAdic,
              Det.Tecnico_Ot_Adic,
              det.XMLOrdenesDatoHija,
              detitem.itemtrabadi,
              detitem.catntrabadi,
              case
                when XMLEXISTS(''/DatosAdic/DatoAdic'' passing by ref
                               Enc.XMLOrdenesdatosAdpa) then
                 1
                else
                 0
              end AS datoAdicionalPadre,
              case
                when XMLEXISTS(''/DatosAdic/DatoAdic'' passing by ref
                               det.XMLOrdenesDatoHija) THEN
                 1
                ELSE
                 0
              END AS datoAdicionalHija
         FROM XMLTable(''/legalizacionOrden/orden'' Passing
                       XMLType(''' || xy.EXTRACT('/').getclobval() ||
                      ''') Columns Orden_padre NUMBER Path
                       ''idOrden'',
                       Causal_padre NUMBER Path ''idCausal'',
                       ini_ejec_padre VARCHAR2(30) PATH ''fechaIniEjec'',
                       fin_ejec_padre VARCHAR2(30) PATH ''fechaFinEjec'',
                       observ_padre VARCHAR2(2000) PATH ''observ_padre'',
                       tecnico_padre NUMBER Path ''idTecnico'',
                       XMLOrdenesAdicionales XMLType Path ''ordenesAdic'',
                       XMLOrdenesdatosAdpa XMLType Path ''DatosAdic'') As Enc,
              XMLTable(''/ordenesAdic/ordenAdic'' Passing
                       Enc.XMLOrdenesAdicionales Columns TipoTrabAdic NUMBER Path
                       ''idTipoTrab'',
                       activAdic NUMBER Path ''idActividad'',
                       Causal_Ot_Adic NUMBER Path ''idCausal'',
                       observaAdic VARCHAR2(2000) Path ''observacion'',
                       Tecnico_Ot_Adic VARCHAR2(200) Path ''idTecnico'',
                       XMLitemsotadic XMLType Path ''items'',
                       XMLOrdenesDatoHija XMLType Path ''DatosAdic'') As Det,
              XMLTable(''/items/item'' Passing det.XMLitemsotadic Columns
                       itemtrabadi NUMBER Path ''idItem'',
                       catntrabadi NUMBER Path ''cantidad'') AS Detitem
        WHERE existsNode(XMLType(''' || xy.EXTRACT('/').getclobval() ||
                      '''),
                         ''/legalizacionOrden/orden/ordenesAdic/ordenAdic'') NOT IN (0)';

      FETCH l_cursor BULK COLLECT INTO i_xml;

      CLOSE l_cursor;
         end if;*/
      --658_4 se cambia la logica para usar la nueva tabla de registro de xml
      --delete from tb_xml_rt r where r.orden_padre = nuOrdenReg;
      if nuidorden = 0 then
        /*OPEN cursor1(sxmlotxml);
        LOOP
          FETCH cursor1
            INTO vxml_Orden_padre,
                 vxml_Causal_padre,
                 vxml_ini_ejec_padre,
                 vxml_fin_ejec_padre,
                 vxml_observ_padre,
                 vxml_tecnico_padre,
                 vxml_XMLOrdenesdatosAdpa,
                 vxml_TipoTrabAdic,
                 vxml_activAdic,
                 vxml_Causal_Ot_Adic,
                 vxml_observaAdic,
                 vxml_Tecnico_Ot_Adic,
                 vxml_XMLOrdenesDatoHija1,
                 vxml_itemtrabadi,
                 vxml_catntrabadi,
                 vxml_datoAdicionalPadre,
                 vxml_datoAdicionalHija;
          EXIT WHEN cursor1%NOTFOUND;
          insert into tb_xml_rt
          values
            (vxml_Orden_padre,
             vxml_Causal_padre,
             vxml_ini_ejec_padre,
             vxml_fin_ejec_padre,
             vxml_observ_padre,
             vxml_tecnico_padre,
             vxml_XMLOrdenesdatosAdpa,
             vxml_TipoTrabAdic,
             vxml_activAdic,
             vxml_Causal_Ot_Adic,
             vxml_observaAdic,
             vxml_Tecnico_Ot_Adic,
             vxml_XMLOrdenesDatoHija1,
             vxml_itemtrabadi,
             vxml_catntrabadi,
             vxml_datoAdicionalPadre,
             vxml_datoAdicionalHija);
        END LOOP;*/
        OPEN cursor1(sxmlotxml);
        FETCH cursor1 BULK COLLECT
          INTO i_xml;
        CLOSE cursor1;
      else
        /*OPEN cursor2(sxmlotxml);
        LOOP
          FETCH cursor2
            INTO vxml_Orden_padre,
                 vxml_Causal_padre,
                 vxml_ini_ejec_padre,
                 vxml_fin_ejec_padre,
                 vxml_observ_padre,
                 vxml_tecnico_padre,
                 vxml_XMLOrdenesdatosAdpa,
                 vxml_TipoTrabAdic,
                 vxml_activAdic,
                 vxml_Causal_Ot_Adic,
                 vxml_observaAdic,
                 vxml_Tecnico_Ot_Adic,
                 vxml_XMLOrdenesDatoHija,
                 vxml_itemtrabadi,
                 vxml_catntrabadi,
                 vxml_datoAdicionalPadre,
                 vxml_datoAdicionalHija;
          EXIT WHEN cursor2%NOTFOUND;
          insert into tb_xml_rt
          values
            (vxml_Orden_padre,
             vxml_Causal_padre,
             vxml_ini_ejec_padre,
             vxml_fin_ejec_padre,
             vxml_observ_padre,
             vxml_tecnico_padre,
             vxml_XMLOrdenesdatosAdpa,
             vxml_TipoTrabAdic,
             vxml_activAdic,
             vxml_Causal_Ot_Adic,
             vxml_observaAdic,
             vxml_Tecnico_Ot_Adic,
             vxml_XMLOrdenesDatoHija,
             vxml_itemtrabadi,
             vxml_catntrabadi,
             vxml_datoAdicionalPadre,
             vxml_datoAdicionalHija);
        END LOOP;
        CLOSE cursor2;*/
        --commit;
        OPEN cursor2(sxmlotxml); --l_cursor FOR 'select * from tb_xml_rt r where r.orden_padre = ' || nuOrdenReg;
        /*FETCH l_cursor BULK COLLECT
          INTO i_xml;
        CLOSE l_cursor;*/
        FETCH cursor2 BULK COLLECT
          INTO i_xml;
        CLOSE cursor2;
      end if;
      --commit;
      --OPEN cursor2(sxmlotxml);--l_cursor FOR 'select * from tb_xml_rt r where r.orden_padre = ' || nuOrdenReg;
      /*FETCH l_cursor BULK COLLECT
        INTO i_xml;
      CLOSE l_cursor;*/
      --FETCH cursor2 BULK COLLECT
      --INTO i_xml;
      --CLOSE cursor2;
      --
      --dbms_output.put_line('orden: '||nuorder);

      /*EXECUTE IMMEDIATE sbquery BULK COLLECT
      INTO i_xml;*/

      FOR i IN 1 .. i_xml.COUNT loop
        --cotstrabadic(sxmlotxml)
        --Caso 658_1: Se cambian todas las referencias i por i_xml(i)
        nuerror := -2;

        regOrden   := NULL;
        regTecnico := null;

        --TICKET 200-2017 LJLB-- se carga registro de la orden padre
        OPEN CUOTOSF(i_xml(i).orden_padre); --Caso 658_1
        FETCH CUOTOSF
          INTO regOrden;
        CLOSE CUOTOSF;

        --TICKET 200-2017 LJLB--  se consulta informacion del tecnico
        OPEN CUUSUALEGO(i_xml(i).tecnico_padre); --Caso 658_1
        FETCH CUUSUALEGO
          INTO regTecnico;
        CLOSE CUUSUALEGO;

        nuerror := -3;

        --dbms_output.put_line('orden: '||i_xml(i).orden_padre);
        --dbms_output.put_line('orden orig: '||nuorder);

        --TICKET 200-2017 LJLB--  se valida que las orden a insertar no exista en la tabla LDC_OTLEGALIZAR
        IF NVL(nuorder, 0) <> i_xml(i).orden_padre THEN
          --Caso 658_1
          --TICKET 200-2017 LJLB-- Insertamos la orden padre en LDC_OTLEGALIZAR Y LDC_ANEXOLEGALIZA

          open cuEstaOt(i_xml(i).orden_padre); --Caso 658_1
          fetch cuEstaOt
            into nuEstaOt;
          close cuEstaOt;
          BEGIN
            --se ejecuta orden padre si esta se encuentra asignada
            IF nuEstaOt = nuEstaAsig THEN
              PROEJECUTAORDEN(i_xml  (i).orden_padre, --Caso 658_1
                              i_xml  (i).causal_padre, --Caso 658_1
                              ERROR,
                              sbmensa);

              IF ERROR <> 0 THEN
                EXIT;
              END IF;
            END IF;

            IF dtFechaEjeIni IS NULL THEN
              dtFechaEjeIni := TO_DATE(i_xml(i).ini_ejec_padre, --Caso 658_1
                                       'DD/MM/YYYY HH24:MI:SS');
            END IF;

            IF dtFechaEjeFin IS NULL THEN
              dtFechaEjeFin := TO_DATE(i_xml(i).fin_ejec_padre, --Caso 658_1
                                       'DD/MM/YYYY HH24:MI:SS');
            END IF;
            --200-2173
            UPDATE OR_ORDER
               SET EXEC_INITIAL_DATE    = i_xml(i).ini_ejec_padre, --Caso 658_1
                   EXECUTION_FINAL_DATE = i_xml(i).fin_ejec_padre --Caso 658_1
             WHERE ORDER_ID = i_xml(i).orden_padre; --Caso 658_1
            --200-2173

            --dbms_output.put_line('orden registro: '||i_xml(i).orden_padre);

            INSERT INTO LDC_OTLEGALIZAR
              (ORDER_ID,
               CAUSAL_ID,
               ORDER_COMMENT,
               EXEC_INITIAL_DATE,
               EXEC_FINAL_DATE,
               FECHA_REGISTRO,
               TASK_TYPE_ID)
            VALUES
              (i_xml(i).orden_padre, --Caso 658_1
               i_xml(i).causal_padre, --Caso 658_1
               nvl(regexp_replace(i_xml(i).observ_padre, --Caso 658_1
                                  '( *[[:punct:]])',
                                  ''),
                   regexp_replace(i_xml(i).observaadic, --Caso 658_1
                                  '( *[[:punct:]])',
                                  '')),
               i_xml(i).ini_ejec_padre, --Caso 658_1
               i_xml(i).fin_ejec_padre, --Caso 658_1
               SYSDATE,
               regOrden.TASK_TYPE_ID);

            INSERT INTO LDC_ANEXOLEGALIZA
              (ORDER_ID, AGENTE_ID, TECNICO_UNIDAD)
            VALUES
              (i_xml               (i).orden_padre, --Caso 658_1
               regTecnico.AGENTE_ID,
               i_xml               (i).tecnico_padre); --Caso 658_1

          EXCEPTION
            WHEN OTHERS THEN
              ERROR   := -1;
              sbmensa := 'error al insertar Orden [' || i_xml(i).orden_padre || --Caso 658_1
                         '] en la tabla LDC_OTLEGALIZAR, error: ' ||
                         nuerror || ' ' || sqlerrm;
          END;
          --Caso 658_1: se valida que hallan datos adicionales
          if i_xml(i).datoAdicionalPadre = 1 then
            --Caso 658_1
            --INICIO CA 33
            IF sbAplicaEnt33 = 'S' THEN
              --se insertan datos adicionales
              FOR regDP IN cuDatoAdiOtPa(i_xml(i).XMLOrdenesdatosAdpa) LOOP
                --Caso 658_1
                insert into LDC_OTDALEGALIZAR
                  (ORDER_ID,
                   NAME_ATTRIBUTE,
                   CAUSAL_ID,
                   TASK_TYPE_ID,
                   VALUE)
                values
                  (i_xml                (i).orden_padre, --Caso 658_1
                   regDP.idDato,
                   i_xml                (i).causal_padre, --Caso 658_1
                   regOrden.TASK_TYPE_ID,
                   regDP.ValorDato);
              END LOOP;
            END IF;
            --FIN 33
          end if;
        END IF;
        nuerror := -4;

        IF i_xml(i).tipotrabadic IS NOT NULL THEN
          --Caso 658_1
          --TICKET 200-2017 LJLB--  se valida que el tipo de trabajo adicional no exista en LDC_OTADICIONAL para la misma orden
          IF NVL(nuTitr, 0) <> i_xml(i).tipotrabadic THEN
            --Caso 658_1
            --TICKET 200-2017 LJLB-- Insertamos la orden padre en LDC_OTADICIONAL
            BEGIN
              INSERT INTO LDC_OTADICIONAL
                (ORDER_ID,
                 TASK_TYPE_ID,
                 ACTIVIDAD,
                 MATERIAL,
                 CANTIDAD,
                 CAUSAL_ID)
              VALUES
                (i_xml(i).orden_padre, --Caso 658_1
                 i_xml(i).TipoTrabAdic, --Caso 658_1
                 i_xml(i).activAdic, --Caso 658_1
                 i_xml(i).itemtrabadi, --Caso 658_1
                 i_xml(i).catntrabadi, --Caso 658_1
                 i_xml(i).Causal_Ot_Adic); --Caso 658_1

            EXCEPTION
              WHEN OTHERS THEN
                ERROR   := -1;
                sbmensa := 'error al insertar Orden [' || i_xml(i).orden_padre || --Caso 658_1
                           '] en la tabla LDC_OTADICIONAL, error: ' ||
                           nuerror || ' ' || sqlerrm;
            END;

            --Caso 658_1: se valida que hallan datos adicionales
            if i_xml(i).datoAdicionalHija = 1 then
              --Caso 658_1
              --INICIO CA 33
              IF sbAplicaEnt33 = 'S' THEN
                --se insertan datos adicionales
                FOR regDPH IN cuDatoAdiOtPa(i_xml(i).XMLOrdenesDatoHija) LOOP
                  --Caso 658_1
                  insert into LDC_OTADICIONALDA
                    (ORDER_ID,
                     NAME_ATTRIBUTE,
                     CAUSAL_ID,
                     TASK_TYPE_ID,
                     VALUE,
                     ACTIVIDAD,
                     MATERIAL)
                  values
                    (i_xml           (i).orden_padre, --Caso 658_1
                     regDPH.idDato,
                     i_xml           (i).Causal_Ot_Adic, --Caso 658_1
                     i_xml           (i).TipoTrabAdic, --Caso 658_1
                     regDPH.ValorDato,
                     i_xml           (i).activAdic, --Caso 658_1
                     i_xml           (i).itemtrabadi); --Caso 658_1
                END LOOP;
              END IF;
              --FIN 33
            end if;

          END IF;

          nuerror := -5;
          --TICKET 200-2017 LJLB-- se valida que la actividad no exista en la tabla LDC_OTADICIONAL para la misma orden y tipo de trabajo
          IF NVL(nuTitr, 0) = i_xml(i).tipotrabadic AND --Caso 658_1
             NVL(nuActiTitr, 0) <> i_xml(i).activAdic THEN
            --Caso 658_1
            --Insertamos la orden padre en LDC_OTADICIONAL
            BEGIN
              INSERT INTO LDC_OTADICIONAL
                (ORDER_ID,
                 TASK_TYPE_ID,
                 ACTIVIDAD,
                 MATERIAL,
                 CANTIDAD,
                 CAUSAL_ID)
              VALUES
                (i_xml(i).orden_padre, --Caso 658_1
                 i_xml(i).TipoTrabAdic, --Caso 658_1
                 i_xml(i).activAdic, --Caso 658_1
                 i_xml(i).itemtrabadi, --Caso 658_1
                 i_xml(i).catntrabadi, --Caso 658_1
                 i_xml(i).Causal_Ot_Adic); --Caso 658_1

            EXCEPTION
              WHEN OTHERS THEN
                ERROR   := -1;
                sbmensa := 'error al insertar Orden [' || i_xml(i).orden_padre || --Caso 658_1
                           '] en la tabla LDC_OTADICIONAL, error: ' ||
                           nuerror || ' ' || sqlerrm;
            END;
          END IF;

          nuerror := -6;
          --TICKET 200-2017 LJLB-- se valida que el items no exista en la tabla LDC_OTADICIONAL para la misma orden y tipo de trabajo y actividad
          IF NVL(nuTitr, 0) = i_xml(i).tipotrabadic AND --Caso 658_1
             NVL(nuActiTitr, 0) = i_xml(i).activAdic AND --Caso 658_1
             NVL(nuItems, 0) <> i_xml(i).itemtrabadi THEN
            --Caso 658_1
            --Insertamos la orden padre en LDC_OTADICIONAL
            BEGIN
              INSERT INTO LDC_OTADICIONAL
                (ORDER_ID,
                 TASK_TYPE_ID,
                 ACTIVIDAD,
                 MATERIAL,
                 CANTIDAD,
                 CAUSAL_ID)
              VALUES
                (i_xml(i).orden_padre, --Caso 658_1
                 i_xml(i).TipoTrabAdic, --Caso 658_1
                 i_xml(i).activAdic, --Caso 658_1
                 i_xml(i).itemtrabadi, --Caso 658_1
                 i_xml(i).catntrabadi, --Caso 658_1
                 i_xml(i).Causal_Ot_Adic); --Caso 658_1

            EXCEPTION
              WHEN OTHERS THEN
                ERROR   := -1;
                sbmensa := 'error al insertar Orden [' || i_xml(i).orden_padre || --Caso 658_1
                           '] en la tabla LDC_OTADICIONAL, error: ' ||
                           nuerror || ' ' || sqlerrm;
            END;
          END IF;
        END IF;

        --TICKET 200-2017 LJLB--  se setean variables para validar orden a insertar
        nuorder    := i_xml(i).orden_padre; --Caso 658_1
        nuTitr     := i_xml(i).tipotrabadic; --Caso 658_1
        nuActiTitr := i_xml(i).activAdic; --Caso 658_1
        nuItems    := i_xml(i).itemtrabadi; --Caso 658_1

      END LOOP;
    ELSE
      ROLLBACK;
      sbmensa := sbmensa;
    END IF;
    --TICKET 200-2017 LJLB--  si no hubo error se confirma transaccion
    IF error = 0 and nuorder > 0 THEN
      COMMIT;
      sbmensa := 'Orden [' || nuorder ||
                 '] Registrada Correctamente en el sistema LEGO';
    ELSE
      ROLLBACK;
      IF nuorder = 0 THEN
        sbmensa := sbmensa ||
                   ' XML no cumple con el estandar para el procesamiento';
      ELSE
        Sbmensa := sbmensa;
      END IF;
    END IF;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      ROLLBACK;
      ERRORS.GETERROR(error, Sbmensa);
      raise ex.CONTROLLED_ERROR;

    WHEN OTHERS THEN
      ROLLBACK;
      sbmensa := 'Error no controlado en LDCI_BOTRABAJOADICIONAL.PROLEGALIZAOTXML ' ||
                 ' orden ' || to_char(nuorder) || ' ' || sqlerrm;
      error   := -1;
  END PROLEGALIZAOTXML;

END LDCI_BOTRABAJOADICIONAL;
/

PROMPT Asignación de permisos para el paquete LDCI_BOTRABAJOADICIONAL
begin
  pkg_utilidades.prAplicarPermisos('LDCI_BOTRABAJOADICIONAL', 'ADM_PERSON');
end;
/
GRANT EXECUTE on ADM_PERSON.LDCI_BOTRABAJOADICIONAL to REXEINNOVA;
/
