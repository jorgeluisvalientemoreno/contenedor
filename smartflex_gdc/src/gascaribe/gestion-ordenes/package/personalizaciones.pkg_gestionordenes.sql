create or replace PACKAGE personalizaciones.pkg_gestionordenes IS

   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : pkg_gestionordenes
        Descripcion     : paquete para gestion de ordenes de trabajo
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 01-06-2023
        Parametros de Entrada
         
        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso     Descripción
		cgonzalez	25/08/2023	OSF-1473 Ajuste a servicio prGetRegiLega
        jsoto       28/09/2023  OSF-1676 Agregar constantes para estados de orden
        jsoto       09/10/2023  OSF-1704 Agregar constantes tipo causal Exito y Fallo
        pacosta     28/03/2025  OSF-4151 Se agregan constantes csbEstadoActRegistrado y csbEstadoActAsignado 
    ***************************************************************************/

   /*cantidad de campos cadena de legalizacion*/
    CSBCANTCAMP_LEGA            CONSTANT NUMBER(1) := 8;

     /*cantidad de campos cadena de legalizacion*/
    CSBCANTCAMPO_LEGA           CONSTANT NUMBER(1) := 9;

    CSBSEPARADOR_PUNTOYCOMA     CONSTANT VARCHAR2(1) := ';';

    CSBSEPARADOR_COMA           CONSTANT VARCHAR2(1) := ',';

    CSBSEPARADOR_IGUAL          CONSTANT VARCHAR2(1) := '=';

    CSBESQUEMA_PERSON           CONSTANT VARCHAR2(100) := 'personalizaciones';

    CSBSEPARADOR_LEGA           CONSTANT VARCHAR2(1) := '|';
    
    /*OSF-1676 Constantes para estados de la orden   */
    
    CNUORDENPENDIENTEREGISTRO   CONSTANT OR_ORDER_STATUS.ORDER_STATUS_ID%TYPE := -1;
    
    CNUORDENREGISTRADA          CONSTANT OR_ORDER_STATUS.ORDER_STATUS_ID%TYPE := 0;
   
    CNUORDENPROGRAMADA          CONSTANT OR_ORDER_STATUS.ORDER_STATUS_ID%TYPE := 1;
    
    CNUORDENASIGNADA            CONSTANT OR_ORDER_STATUS.ORDER_STATUS_ID%TYPE := 5;
    
    CNUORDENENEJECUCION         CONSTANT OR_ORDER_STATUS.ORDER_STATUS_ID%TYPE := 6;

    CNUORDENEJECUTADA           CONSTANT OR_ORDER_STATUS.ORDER_STATUS_ID%TYPE := 7;
    
    CNUORDENCERRADA             CONSTANT OR_ORDER_STATUS.ORDER_STATUS_ID%TYPE := 8;
    
    CNUORDENBLOQUEADA           CONSTANT OR_ORDER_STATUS.ORDER_STATUS_ID%TYPE := 11;
    
    CNUORDENANULADA             CONSTANT OR_ORDER_STATUS.ORDER_STATUS_ID%TYPE := 12;
    
    CNUORDENENESPERA            CONSTANT OR_ORDER_STATUS.ORDER_STATUS_ID%TYPE := 18;
    
    CNUORDENMOVILIZANDO         CONSTANT OR_ORDER_STATUS.ORDER_STATUS_ID%TYPE := 19;
    
    CNUORDENPLANEADA            CONSTANT OR_ORDER_STATUS.ORDER_STATUS_ID%TYPE := 20;

    CNUCAUSALEXITO              CONSTANT NUMBER(4) := 1;
    
    CNUCAUSALFALLO              CONSTANT NUMBER(4) := 2;
    
    csbEstadoActRegistrado      CONSTANT VARCHAR2(1) := 'R';
    
    csbEstadoActAsignado        CONSTANT VARCHAR2(1) := 'A';

   CURSOR cuGetObjetoAccion(inuTipoTrab     IN  OBJETOS_ACCION.TIPOTRABAJO%type,
                            inuactividad    IN  OBJETOS_ACCION.IDACTIVIDAD%type,
                            inuCausal       IN  OBJETOS_ACCION.IDCAUSAL%type,
                            inuAccion       IN  OBJETOS_ACCION.IDACCION%type,
                            isbTipoAccion   IN  OBJETOS_ACCION.TIPOACCION%type,
                            inuUnidadOpera  IN  OBJETOS_ACCION.UNIDADOPERATIVA%type) IS
   SELECT objetos_accion.nombreobjeto
    FROM personalizaciones.objetos_accion
    WHERE (objetos_accion.tipotrabajo               = inuTipoTrab
        OR objetos_accion.tipotrabajo IS NULL )
        AND (objetos_accion.idactividad            = inuactividad
           OR objetos_accion.idactividad IS NULL )
        AND (objetos_accion.idcausal               = inuCausal
           OR objetos_accion.idcausal IS NULL ) 
        AND objetos_accion.idaccion                = inuAccion
        AND objetos_accion.tipoaccion              = isbTipoAccion
        AND (objetos_accion.unidadoperativa        = inuUnidadOpera
            OR objetos_accion.unidadoperativa  IS NULL )
        AND objetos_accion.activo = 'S'
    ORDER BY ordenejecucion;



   TYPE tblObjetosAccion IS TABLE OF cuGetObjetoAccion%ROWTYPE;


   -- registro de estructura de legalizacion
   TYPE tytRegiEstrLega IS RECORD ( nuOrden                             NUMBER,
                                    nuCausal                            NUMBER,
                                    nuPersona                           NUMBER,
                                    sbDatosAdic                         VARCHAR2(4000),
                                    sbActividades                       VARCHAR2(4000),
                                    sbItemsElementos                    VARCHAR2(4000),
                                    sbLecturaElementos                  VARCHAR2(4000),
                                    sbComentariosOrden                  VARCHAR2(4000),
                                    sbFechaEjec                         VARCHAR2(100)
                                    );

   V_tytRegiEstrLega tytRegiEstrLega;
   V_tytRegiEstrLegaVacio tytRegiEstrLega;

    -- registro de estructura de legalizacion
   TYPE tytRegiDatoAdici IS RECORD ( sbNombre  VARCHAR2(100),
                                     sbValor   VARCHAR2(2000) );

   TYPE tytblRegiDatoAdici IS TABLE OF tytRegiDatoAdici INDEX BY VARCHAR2(100);

     -- registro de estructura de legalizacion
   TYPE tytRegiItems IS RECORD (   sbItems    VARCHAR2(20),
                                   nuCantidad NUMBER(15,4),
                                   sbSalida   VARCHAR2(2));

   TYPE tytblRegiItems IS TABLE OF tytRegiItems INDEX BY VARCHAR2(20);


   TYPE tytblRegiActiApoy IS TABLE OF VARCHAR2(20) INDEX BY VARCHAR2(20);

   TYPE tytRegiAtribActi IS RECORD (   sbNombreAtributo    VARCHAR2(200),
                                       sbValorAtributo     VARCHAR2(2000) );

   TYPE tytblRegiAtribActi IS TABLE OF tytRegiAtribActi INDEX BY VARCHAR2(200);

   TYPE tytRegiActivPrinc IS RECORD (  sbIdOrderActi  VARCHAR2(20),
                                       sbCantidad     VARCHAR2(2),
                                       tblActivApoy   tytblRegiActiApoy,
                                       tblAtribActi   tytblRegiAtribActi);

   TYPE tytblRegiActivPrinc IS TABLE OF tytRegiActivPrinc INDEX BY VARCHAR2(20);

 -- registro de informacion de lectura
   TYPE tytRegiInfoLectura IS RECORD ( sbMedidor            VARCHAR2(30),
                                       sbTipoCons           VARCHAR2(8),
                                       sbLectura            VARCHAR2(30),
                                       sbClase              VARCHAR2(4),
                                       sbObservacionUno     VARCHAR2(10),
                                       sbObservacionDos     VARCHAR2(10),
                                       sbObservacionTres    VARCHAR2(10) );

   TYPE tytblRegiInfoLectura IS TABLE OF tytRegiInfoLectura INDEX BY VARCHAR2(30);

   --se mapea objeto de estructura legalizacion a un registro de legalacion
   PROCEDURE prGetRegiLega( ItblStringTable  IN  ldc_bcConsGenerales.tyTblStringTable,
                            orecRegiEstrLega OUT tytRegiEstrLega,
                            onuErrorCode     OUT NUMBER,
                            osbErrorMessage  OUT VARCHAR2);
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prGetRegiLega
        Descripcion     : devolver registro de legalizacion
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 01-06-2023
        Parametros de Entrada
          ItblStringTable    tabla pl de cadena
        Parametros de Salida
          orecRegiEstrLega   registro de estructura de legalizacion
          onuErrorCode       codigo de error
          osbErrorMessage    mensaje de error
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripción
    ***************************************************************************/


    PROCEDURE prGetObjetosEjecutar( inuOrden          IN   NUMBER,
                                   inuCausal          IN   NUMBER,
                                   inuAccion          IN   OBJETOS_ACCION.IDACCION%TYPE ,
                                   isbTipoAccion      IN   OBJETOS_ACCION.TIPOACCION%TYPE ,
                                   otblObjetosAccion  OUT  tblObjetosAccion,
                                   onuErrorCode       OUT  NUMBER,
                                   osbErrorMessage    OUT  VARCHAR2);
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prGetObjetosEjecutar
        Descripcion     : proceso que se encarga de devolver los objetos a ejecutar
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 01-06-2023
        Parametros de Entrada
          inuOrden           codigo de error
          inuCausal          codigo de causal de legalizacion
          inuAccion          accion a ejecutar
          isbTipoAccion      tipo de accion (PRE - POST)
        Parametros de Salida
          otblObjetosAccion   tabla de objetos a procesar
          onuErrorCode       codigo de error
          osbErrorMessage    mensaje de error
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripción
    ***************************************************************************/

   PROCEDURE prGetTblDatosAdic ( isbDatosAdicionales  IN   VARCHAR2,
                                 otblDatosAdicionales OUT  tytblRegiDatoAdici );
   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prGetTblDatosAdic
        Descripcion     : proceso que devuelve tabla con los datos adicionales
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 01-06-2023
        Parametros de Entrada
          isbDatosAdicionales    cadena con estructura de datos adicionales [NOMBRE_DATO=VALOR]
        Parametros de Salida
          otblDatosAdicionales   tabla pl de datos adicionales [sbNombre, sbValor]
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripción
    ***************************************************************************/

   FUNCTION fsbGetValorAtributo(itblDatosAdicionales IN   tytblRegiDatoAdici,
                                isbNombreAtributo    IN   VARCHAR2   ) RETURN VARCHAR2;
   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fsbGetValorAtributo
        Descripcion     : funcion que retorna el valor de un dato adicional,
                          recibiendo el nombre de dato adicional
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 01-06-2023
        Parametros de Entrada
          itblDatosAdicionales   tabla pl de datos adicionales [sbNombre, sbValor]
          isbNombreAtributo      nombre del dato adicional a consultar
        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripción
    ***************************************************************************/
   PROCEDURE prGetTblItems ( isbItems        IN   VARCHAR2,
                             otblItems       OUT  tytblRegiItems  );
   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prGetTblItems
        Descripcion     : proceso que devuelve tabla de items a legalizar
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 01-06-2023
        Parametros de Entrada
          isbItems      listado de items a legalizar [items>cantidad>Y]
        Parametros de Salida
          otblItems     tabla pl de items [sbItems ,  nuCantidad , sbSalida]
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripción
    ***************************************************************************/

   PROCEDURE prGetInformacionItems( itblItems       IN   tytblRegiItems,
                                    isbItems        IN   VARCHAR2,
                                    onuCantidad     OUT  NUMBER,
                                    osbSalida       OUT  VARCHAR2);
   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prGetInformacionItems
        Descripcion     : proceso que devuelve informacion de un items
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 01-06-2023
        Parametros de Entrada
          itblItems     tabla pl de items [sbItems ,  nuCantidad , sbSalida]
          isbItems      codigo del item a consultar
        Parametros de Salida
           onuCantidad  cantidad legalizada
           osbSalida    salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripción
    ***************************************************************************/
   PROCEDURE prGetTblActividades ( isbActividades    IN   VARCHAR2,
                                   otblActividades   OUT  tytblRegiActivPrinc );
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prGetTblActividades
        Descripcion     : proceso que devuelve tabla pl de actividades
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 01-06-2023
        Parametros de Entrada
          isbActividades     listado de actividades [actividad>1 o 0>actividad_apoy1,actividad_apoy2;atributo1;atributo2,atributo3,atributo4]
        Parametros de Salida
          otblActividades    tabla pl de actividades [ sbIdOrderActi ,
                                                       sbCantidad    ,
                                                       tblActivApoy [ cadena ] ,
                                                       tblAtribActi [ sbNombreAtributo ,  sbValorAtributo ] ]
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripción
    ***************************************************************************/
   FUNCTION fblExisteActiviApoy( itblActividades   IN   tytblRegiActivPrinc,
                                 isbActiviApoy     IN   VARCHAR2
                                 ) RETURN BOOLEAN ;
   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fblExisteActiviApoy
        Descripcion     : funcion que valida si existe o no una actividad de apoyo
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 01-06-2023
        Parametros de Entrada
          itblActividades     tabla pl de actividades
          isbActiviApoy       codigo de la actividad de apoyo
        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripción
    ***************************************************************************/
   PROCEDURE prGetValorAtribActividad( itblActividades      IN    tytblRegiActivPrinc,
                                       isbNombreAtributo    IN    VARCHAR2,
                                       osbValor             OUT   VARCHAR2);
   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prGetValorAtribActividad
        Descripcion     : proceso que devuelve valor del atributo de una actividad
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 01-06-2023
        Parametros de Entrada
          itblActividades      tabla pl de actividades
          isbNombreAtributo    nombre de atributo de actividad
        Parametros de Salida
          osbValor             valor del atributo de actividad
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripción
    ***************************************************************************/
   PROCEDURE prGetTblInfoLectura ( isbInfoLectura   IN   VARCHAR2,
                                  otblInfoLectura   OUT  tytblRegiInfoLectura,
                                  osbMedidor        OUT  VARCHAR2,
                                  osbLectura        OUT  VARCHAR2 );
   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prGetTblInfoLectura
        Descripcion     : proceso que devuelve tabla pl de informacion lectura
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 01-06-2023
        Parametros de Entrada
          isbInfoLectura       informacion de lectura
        Parametros de Salida
          otblInfoLectura      tabla con informacion de lectura [ sbMedidor  ,
                                                                  sbTipoCons ,
                                                                  sbLectura  ,
                                                                  sbClase    ,
                                                                  sbObservacionUno ,
                                                                  sbObservacionDos ,
                                                                  sbObservacionTres ]
          osbMedidor            codigo del medidor
          osbLectura            lectura
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripción
    ***************************************************************************/
END pkg_gestionordenes;
/
create or replace PACKAGE body   personalizaciones.pkg_gestionordenes IS

   PROCEDURE prGetRegiLega( ItblStringTable IN ldc_bcConsGenerales.tyTblStringTable,
                            orecRegiEstrLega OUT tytRegiEstrLega,
                            onuErrorCode     OUT NUMBER,
                            osbErrorMessage  OUT VARCHAR2) IS
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prGetRegiLega
        Descripcion     : devolver registro de legalizacion
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 01-06-2023
        Parametros de Entrada
          ItblStringTable    tabla pl de cadena
        Parametros de Salida
          orecRegiEstrLega   registro de estructura de legalizacion
          onuErrorCode       codigo de error
          osbErrorMessage    mensaje de error
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso     Descripción
		cgonzalez	25/08/2023	OSF-1473 Se ajusta para no exigir el comentario de legalizacion
    ***************************************************************************/
   BEGIN
     ldc_bcConsGenerales.prInicializaError(onuErrorCode, osbErrorMessage);

     orecRegiEstrLega := V_tytRegiEstrLegaVacio;
     --se validan datos necesarios para legalizar
     IF ItblStringTable(1) IS NULL THEN
        onuErrorCode := -1;
        osbErrorMessage := 'Codigo de orden es necesaria para el proceso';
     ELSIF ItblStringTable(2) IS NULL THEN
        onuErrorCode := -1;
        osbErrorMessage := 'Codigo de causal es necesaria para el proceso';
    ELSIF ItblStringTable(3) IS NULL THEN
        onuErrorCode := -1;
        osbErrorMessage := 'Codigo de persona es necesaria para el proceso';
     ELSIF ItblStringTable(5) IS NULL THEN
        onuErrorCode := -1;
        osbErrorMessage := 'Actividad a legalizar es necesaria para el proceso';
     END IF;

     IF onuErrorCode <> 0 THEN
        Pkg_Error.setErrorMessage(pkg_Error.CNUGENERIC_MESSAGE, osbErrorMessage);
     END IF;

     orecRegiEstrLega.nuOrden            := ItblStringTable(1);
     orecRegiEstrLega.nuCausal           := ItblStringTable(2);
     orecRegiEstrLega.nuPersona          := ItblStringTable(3);
     orecRegiEstrLega.sbDatosAdic        := ItblStringTable(4);
     orecRegiEstrLega.sbActividades      := ItblStringTable(5);
     orecRegiEstrLega.sbItemsElementos   := ItblStringTable(6);
     orecRegiEstrLega.sbLecturaElementos := ItblStringTable(7);
     orecRegiEstrLega.sbComentariosOrden := ItblStringTable(8);
     IF ItblStringTable.COUNT > 8 THEN
         orecRegiEstrLega.sbFechaEjec := ItblStringTable(9);
     END IF;

   EXCEPTION
     WHEN OTHERS THEN
        Pkg_Error.SETERROR;
        Pkg_Error.GETERROR(onuErrorCode, osbErrorMessage);
   END prGetRegiLega;

   PROCEDURE prGetObjetosEjecutar( inuOrden        IN  NUMBER,
                                   inuCausal       IN  NUMBER,
                                   inuAccion       IN  OBJETOS_ACCION.IDACCION%TYPE ,
                                   isbTipoAccion   IN  OBJETOS_ACCION.TIPOACCION%TYPE ,
                                   otblObjetosAccion OUT tblObjetosAccion,
                                   onuErrorCode    OUT NUMBER,
                                   osbErrorMessage OUT VARCHAR2) IS
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prGetObjetosEjecutar
        Descripcion     : proceso que se encarga de devolver los objetos a ejecutar
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 01-06-2023
        Parametros de Entrada
          inuOrden           codigo de error
          inuCausal          codigo de causal de legalizacion
          inuAccion          accion a ejecutar
          isbTipoAccion      tipo de accion (PRE - POST)
        Parametros de Salida
          otblObjetosAccion   tabla de objetos a procesar
          onuErrorCode       codigo de error
          osbErrorMessage    mensaje de error
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripción
    ***************************************************************************/
    CURSOR cuGetInfoOrden IS
    SELECT OR_ORDER.operating_unit_id,
            OR_ORDER.task_type_id,
          OR_ORDER_ACTIVITY.activity_id
    FROM OPEN.OR_ORDER
        JOIN OPEN.OR_ORDER_ACTIVITY ON OR_ORDER.ORDER_ID = OR_ORDER_ACTIVITY.ORDER_ID
    WHERE OR_ORDER.ORDER_ID =  inuOrden;

    nuTipoTrab     OBJETOS_ACCION.TIPOTRABAJO%TYPE;
    nuUnidadOper   OBJETOS_ACCION.UNIDADOPERATIVA%TYPE;
    nuactividad    OBJETOS_ACCION.IDACTIVIDAD%TYPE;

  BEGIN
     ldc_bcConsGenerales.prInicializaError(onuErrorCode, osbErrorMessage);

     IF cuGetObjetoAccion%ISOPEN THEN
        CLOSE cuGetObjetoAccion;
     END IF;

     IF cuGetInfoOrden%ISOPEN THEN
        CLOSE cuGetInfoOrden;
     END IF;

     OPEN cuGetInfoOrden;
     FETCH cuGetInfoOrden INTO nuUnidadOper, nuTipoTrab, nuactividad;
     CLOSE cuGetInfoOrden;


     OPEN cuGetObjetoAccion(nuTipoTrab,
                            nuactividad,
                            inuCausal,
                            inuAccion,
                            isbTipoAccion,
                            nuUnidadOper) ;
     FETCH cuGetObjetoAccion BULK COLLECT INTO otblObjetosAccion;
     CLOSE cuGetObjetoAccion;

   EXCEPTION
     WHEN OTHERS THEN
        Pkg_Error.SETERROR;
        Pkg_Error.GETERROR(onuErrorCode, osbErrorMessage);
  END prGetObjetosEjecutar;

   PROCEDURE prGetTblDatosAdic ( isbDatosAdicionales IN VARCHAR2,
                                 otblDatosAdicionales OUT  tytblRegiDatoAdici) IS
   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prGetTblDatosAdic
        Descripcion     : proceso que devuelve tabla con los datos adicionales
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 01-06-2023
        Parametros de Entrada
          isbDatosAdicionales    cadena con estructura de datos adicionales [NOMBRE_DATO=VALOR]
        Parametros de Salida
          otblDatosAdicionales   tabla pl de datos adicionales [sbNombre, sbValor]
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripción
    ***************************************************************************/
      v_tStringTable ldc_bcConsGenerales.tyTblStringTable ;

      CURSOR cuGetDatosAdic(isbCadena VARCHAR2) IS
      WITH estructuracadena AS (
            SELECT instr(isbcadena, '=') indice,
                    LENGTH(isbcadena) tamanio
            FROM dual),
     atributos AS (
       SELECT substr(isbcadena,1, indice-1) nombre_atributo,
                substr(isbcadena,indice +1 ,tamanio ) valor_atributo
       FROM estructuracadena )
     SELECT *
     FROM atributos
     WHERE nombre_atributo IS NOT NULL;

       sbNombAtrib VARCHAR2(100);
       sbVAlorAtrib VARCHAR2(400);


   BEGIN

      --se mapean datos de la cadena de legalizacion
     v_tStringTable := ldc_bcConsGenerales.ftbAllSplitString
                    (
                        isbDatosAdicionales,
                        CSBSEPARADOR_PUNTOYCOMA
                    );

     IF v_tStringTable.COUNT > 0 THEN
        FOR idx IN 1..v_tStringTable.COUNT LOOP
            sbNombAtrib  := null;
            sbVAlorAtrib := null;

            IF cuGetDatosAdic%ISOPEN THEN
               CLOSE cuGetDatosAdic;
            END IF;

            OPEN cuGetDatosAdic(v_tStringTable(idx));
            FETCH cuGetDatosAdic INTO  sbNombAtrib, sbVAlorAtrib;
            CLOSE cuGetDatosAdic;

            otblDatosAdicionales(sbNombAtrib).sbNombre := sbNombAtrib;
            otblDatosAdicionales(sbNombAtrib).sbValor := sbVAlorAtrib;

        END LOOP;

     END IF;

   EXCEPTION
     WHEN OTHERS THEN
        Pkg_Error.SETERROR;
        RAISE Pkg_Error.CONTROLLED_ERROR;
   END prGetTblDatosAdic;

  FUNCTION fsbGetValorAtributo( itblDatosAdicionales IN  tytblRegiDatoAdici,
                                isbNombreAtributo IN VARCHAR2 ) RETURN VARCHAR2 IS
 /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fsbGetValorAtributo
        Descripcion     : funcion que retorna el valor de un dato adicional,
                          recibiendo el nombre de dato adicional
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 01-06-2023
        Parametros de Entrada
          itblDatosAdicionales   tabla pl de datos adicionales [sbNombre, sbValor]
          isbNombreAtributo      nombre del dato adicional a consultar
        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripción
    ***************************************************************************/
    sbValorAtributo VARCHAR2(400);
  BEGIN

     IF itblDatosAdicionales.COUNT > 0 THEN
        IF itblDatosAdicionales.EXISTS(isbNombreAtributo) THEN
           sbValorAtributo := itblDatosAdicionales(isbNombreAtributo).sbValor;
        END IF;
     END IF;

     return sbValorAtributo;
  EXCEPTION
    WHEN OTHERS THEN
      Pkg_Error.SETERROR;
      RAISE Pkg_Error.CONTROLLED_ERROR;
      return sbValorAtributo;
  END fsbGetValorAtributo;

  PROCEDURE prGetTblItems ( isbItems         IN VARCHAR2,
                             otblItems       OUT  tytblRegiItems ) IS
  /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prGetTblItems
        Descripcion     : proceso que devuelve tabla de items a legalizar
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 01-06-2023
        Parametros de Entrada
          isbItems      listado de items a legalizar [items>cantidad>Y]
        Parametros de Salida
          otblItems     tabla pl de items [sbItems ,  nuCantidad , sbSalida]
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripción
    ***************************************************************************/
      v_tStringTable ldc_bcConsGenerales.tyTblStringTable ;

      CURSOR cuGetItems(isbCadena VARCHAR2) IS
      WITH estructuracadena AS (
            SELECT instr(isbCadena, '>') indice,
                    LENGTH(isbCadena) tamanio
            FROM dual), itemscadena AS (
      SELECT substr(isbCadena,1, indice-1) items,
                substr(isbCadena,indice +1 ,tamanio ) cadena,
                instr(substr(isbCadena,indice +1 ,tamanio ), '>') indice_nuevo,
                tamanio
      FROM estructuracadena)
      SELECT items,
             substr(cadena,1, indice_nuevo-1) cantidad,
             substr(cadena,indice_nuevo +1 ,tamanio ) salida
      FROM itemscadena
      WHERE items IS NOT NULL;

       sbItems      VARCHAR2(20);
       nuCantidad   NUMBER(15,4);
       sbSalida     VARCHAR2(2);

   BEGIN

      --se mapean datos de la cadena de legalizacion
     v_tStringTable := ldc_bcConsGenerales.ftbAllSplitString
                    (
                        isbItems,
                        CSBSEPARADOR_PUNTOYCOMA
                    );

     IF v_tStringTable.COUNT > 0 THEN
        FOR idx IN 1..v_tStringTable.COUNT LOOP
            sbItems  := null;
            nuCantidad := null;
            sbSalida := null;

            IF cuGetItems%ISOPEN THEN
               CLOSE cuGetItems;
            END IF;

            OPEN cuGetItems(v_tStringTable(idx));
            FETCH cuGetItems INTO  sbItems, nuCantidad, sbSalida;
            CLOSE cuGetItems;

            otblItems(sbItems).sbItems := sbItems;
            otblItems(sbItems).nuCantidad := nuCantidad;
            otblItems(sbItems).sbSalida := sbSalida;

        END LOOP;

     END IF;

   EXCEPTION
     WHEN OTHERS THEN
        Pkg_Error.SETERROR;
        RAISE Pkg_Error.CONTROLLED_ERROR;
   END prGetTblItems;

   PROCEDURE prGetInformacionItems( itblItems       IN   tytblRegiItems,
                                    isbItems        IN   VARCHAR2,
                                    onuCantidad     OUT  NUMBER,
                                    osbSalida       OUT  VARCHAR2  ) IS
   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prGetInformacionItems
        Descripcion     : proceso que devuelve informacion de un items
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 01-06-2023
        Parametros de Entrada
          itblItems     tabla pl de items [sbItems ,  nuCantidad , sbSalida]
          isbItems      codigo del item a consultar
        Parametros de Salida
           onuCantidad  cantidad legalizada
           osbSalida    salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripción
    ***************************************************************************/
  BEGIN

    IF itblItems.COUNT > 0 THEN
       IF itblItems.EXISTS(isbItems) THEN
          onuCantidad := itblItems(isbItems).nuCantidad;
          osbSalida   := itblItems(isbItems).sbSalida;
       END IF;
    END IF;

  EXCEPTION
    WHEN OTHERS THEN
      Pkg_Error.SETERROR;
      RAISE Pkg_Error.CONTROLLED_ERROR;
  END prGetInformacionItems;

  PROCEDURE prGetTblActividades ( isbActividades    IN   VARCHAR2,
                                  otblActividades   OUT  tytblRegiActivPrinc ) IS
  /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prGetTblActividades
        Descripcion     : proceso que devuelve tabla pl de actividades
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 01-06-2023
        Parametros de Entrada
          isbActividades     listado de actividades [actividad>1 o 0>actividad_apoy1,actividad_apoy2;atributo1;atributo2,atributo3,atributo4]
        Parametros de Salida
          otblActividades    tabla pl de actividades [ sbIdOrderActi ,
                                                       sbCantidad    ,
                                                       tblActivApoy [ cadena ] ,
                                                       tblAtribActi [ sbNombreAtributo ,  sbValorAtributo ] ]
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripción
    ***************************************************************************/
      v_tStringTable ldc_bcConsGenerales.tyTblStringTable ;

      CURSOR cuGetActividades(isbCadena VARCHAR2) IS
       WITH estructuracadena AS (
        SELECT instr(isbCadena, '>') indice,
               LENGTH(isbCadena) TAMANIO
        FROM dual),
        actividad_principal AS (
        SELECT substr(isbCadena,1, indice-1) id_order_acti,
            substr(isbCadena,indice +1 , 1 ) cantidad,
             substr(isbCadena,indice + 3 , TAMANIO) actividad_apoyo
        FROM estructuracadena)
        SELECT  ID_ORDER_ACTI, CANTIDAD, ACTIVIDAD_APOYO
        FROM actividad_principal
        WHERE ID_ORDER_ACTI IS NOT NULL;


      CURSOR cuGetValorAtributo(isbCadena VARCHAR2) IS
      WITH estructuracadena AS (
        SELECT instr(isbCadena, '>') indice,
               length(isbCadena) tamanio
        FROM dual), atributo_cadena AS (
        SELECT substr(isbCadena,1, indice-1) atributo,
               substr(isbCadena,indice +1 ,tamanio ) cadena,
               instr(substr(isbCadena,indice +1 ,tamanio ), '>') indice_nuevo,
               tamanio
        FROM estructuracadena)
        SELECT atributo,
              substr(cadena,1, indice_nuevo-1) valor
        FROM atributo_cadena
        WHERE atributo IS NOT NULL;

      sbItems VARCHAR2(20);
      sbCantidad VARCHAR2(20);
      sbCadeActividades  VARCHAR2(4000);
      sbAtributos1       VARCHAR2(4000);
      sbAtributos2       VARCHAR2(4000);
      sbAtributos3       VARCHAR2(4000);
      sbAtributos4       VARCHAR2(4000);

      sbNombreAtributo    VARCHAR2(200);
      sbValorAtributo     VARCHAR2(2000);

      tblRegiActiApoy     tytblRegiActiApoy;
      tblAtribActi        tytblRegiAtribActi ;
   BEGIN
      v_tStringTable.DELETE;
      v_tStringTable := ldc_bcConsGenerales.ftbAllSplitString
                        (
                            isbActividades,
                            CSBSEPARADOR_PUNTOYCOMA
                        );
     IF v_tStringTable.COUNT > 0 THEN
        sbCadeActividades := v_tStringTable(1);


        FOR idx IN 2..v_tStringTable.COUNT LOOP
             IF v_tStringTable(idx) IS NOT NULL THEN
                IF cuGetValorAtributo%ISOPEN THEN
                   CLOSE cuGetValorAtributo;
                END IF;
                sbNombreAtributo := NULL;
                sbValorAtributo  := NULL;

                OPEN cuGetValorAtributo( v_tStringTable(idx));
                FETCH cuGetValorAtributo INTO  sbNombreAtributo, sbValorAtributo;
                CLOSE cuGetValorAtributo;

                tblAtribActi(sbNombreAtributo).sbNombreAtributo := sbNombreAtributo;
                tblAtribActi(sbNombreAtributo).sbValorAtributo  := sbValorAtributo;
             END IF;
        END LOOP;

     END IF;

     FOR reg IN cuGetActividades(sbCadeActividades) LOOP
        tblRegiActiApoy.delete;
        v_tStringTable.delete;

        otblActividades(reg.id_order_acti).sbIdOrderActi := reg.id_order_acti;
        otblActividades(reg.id_order_acti).sbCantidad := reg.cantidad;

        --se mapean datos de la cadena de legalizacion
        v_tStringTable := ldc_bcConsGenerales.ftbAllSplitString
                        (
                            reg.actividad_apoyo,
                            CSBSEPARADOR_COMA
                        );
        IF v_tStringTable.COUNT > 0 THEN
           FOR idx IN 1..v_tStringTable.COUNT LOOP
               tblRegiActiApoy(v_tStringTable(idx)) := v_tStringTable(idx);
           END LOOP;
        END IF;
        otblActividades(reg.id_order_acti).tblActivApoy  := tblRegiActiApoy;
        otblActividades(reg.id_order_acti).tblAtribActi   := tblAtribActi;
     END LOOP;

   EXCEPTION
     WHEN OTHERS THEN
        Pkg_Error.SETERROR;
        RAISE Pkg_Error.CONTROLLED_ERROR;
   END prGetTblActividades;

   PROCEDURE prGetValorAtribActividad( itblActividades      IN    tytblRegiActivPrinc,
                                       isbNombreAtributo    IN    VARCHAR2,
                                       osbValor             OUT   VARCHAR2) IS
  /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prGetValorAtribActividad
        Descripcion     : proceso que devuelve valor del atributo de una actividad
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 01-06-2023
        Parametros de Entrada
          itblActividades      tabla pl de actividades
          isbNombreAtributo    nombre de atributo de actividad
        Parametros de Salida
          osbValor             valor del atributo de actividad
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripción
    ***************************************************************************/
     sbIndex VARCHAR2(4000);
  BEGIN

    IF itblActividades.COUNT > 0 THEN
       sbindex := itblActividades.first;
      LOOP
        EXIT WHEN sbIndex IS NULL;
         IF itblActividades(sbIndex).tblAtribActi.EXISTS(isbNombreAtributo) THEN
            osbValor := itblActividades(sbIndex).tblAtribActi(isbNombreAtributo).sbValorAtributo;
            EXIT;
         END IF;
         sbindex := itblActividades.next(sbindex);
      END LOOP;
    END IF;

  EXCEPTION
    WHEN OTHERS THEN
      Pkg_Error.SETERROR;
      RAISE Pkg_Error.CONTROLLED_ERROR;
  END prGetValorAtribActividad;

  FUNCTION fblExisteActiviApoy( itblActividades  IN  tytblRegiActivPrinc,
                                isbActiviApoy    IN  VARCHAR2 ) RETURN BOOLEAN IS
 /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fblExisteActiviApoy
        Descripcion     : funcion que valida si existe o no una actividad de apoyo
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 01-06-2023
        Parametros de Entrada
          itblActividades     tabla pl de actividades
          isbActiviApoy       codigo de la actividad de apoyo
        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripción
    ***************************************************************************/
     blExiste BOOLEAN :=FALSE;
     sbIndex VARCHAR2(4000);
  BEGIN

    IF itblActividades.COUNT > 0 THEN
       sbindex := itblActividades.first;
      LOOP
        EXIT WHEN sbIndex IS NULL;
         IF itblActividades(sbIndex).tblActivApoy.EXISTS(isbActiviApoy) THEN
            blExiste := TRUE;
            EXIT;
         END IF;
         sbindex := itblActividades.next(sbindex);
      END LOOP;
    END IF;

    RETURN blExiste;
  EXCEPTION
    WHEN OTHERS THEN
      Pkg_Error.SETERROR;
      RAISE Pkg_Error.CONTROLLED_ERROR;
      RETURN blExiste;
  END fblExisteActiviApoy;

  PROCEDURE prGetTblInfoLectura ( isbInfoLectura    IN   VARCHAR2,
                                  otblInfoLectura   OUT  tytblRegiInfoLectura,
                                  osbMedidor        OUT  VARCHAR2,
                                  osbLectura        OUT  VARCHAR2   ) IS
  /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prGetTblInfoLectura
        Descripcion     : proceso que devuelve tabla pl de informacion lectura
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 01-06-2023
        Parametros de Entrada
          isbInfoLectura       informacion de lectura
        Parametros de Salida
          otblInfoLectura      tabla con informacion de lectura [ sbMedidor  ,
                                                                  sbTipoCons ,
                                                                  sbLectura  ,
                                                                  sbClase    ,
                                                                  sbObservacionUno ,
                                                                  sbObservacionDos ,
                                                                  sbObservacionTres ]
          osbMedidor            codigo del medidor
          osbLectura            lectura
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso    Descripción
    ***************************************************************************/
      v_tStringTable ldc_bcConsGenerales.tyTblStringTable ;

      CURSOR cuGetInfoLect IS
      WITH estructuracadena AS (
        SELECT instr(isbInfoLectura, ';') indice,
               instr(isbInfoLectura, '=') indice_final,
               LENGTH(isbInfoLectura) tamanio
        FROM dual),
        medidor AS (
        SELECT substr(isbInfoLectura,1, indice-1) medidor,
                substr(isbInfoLectura,indice +1 ,tamanio ) cadena
        FROM estructuracadena)
        SELECT medidor, cadena
        FROM medidor
        WHERE medidor IS NOT NULL;

      sbItems VARCHAR2(20);
      sbCantidad VARCHAR2(20);


   BEGIN

     FOR reg IN cuGetInfoLect LOOP
        v_tStringTable.delete;

        otblInfoLectura(reg.medidor).sbMedidor := reg.medidor;
        osbMedidor := reg.medidor;
        --se mapean datos de la cadena de legalizacion
        v_tStringTable := ldc_bcConsGenerales.ftbAllSplitString
                        (
                            reg.cadena,
                            CSBSEPARADOR_IGUAL
                        );
        IF v_tStringTable.COUNT > 0 THEN
           otblInfoLectura(reg.medidor).sbTipoCons := v_tStringTable(1);
           otblInfoLectura(reg.medidor).sbLectura :=  v_tStringTable(2);
           osbLectura                             := v_tStringTable(2);
           otblInfoLectura(reg.medidor).sbClase :=  v_tStringTable(3);
           otblInfoLectura(reg.medidor).sbObservacionUno :=  v_tStringTable(4);
           otblInfoLectura(reg.medidor).sbObservacionDos :=  v_tStringTable(5);
           otblInfoLectura(reg.medidor).sbObservacionTres :=  v_tStringTable(6);
        END IF;

     END LOOP;

   EXCEPTION
     WHEN OTHERS THEN
        Pkg_Error.SETERROR;
        RAISE Pkg_Error.CONTROLLED_ERROR;
   END prGetTblInfoLectura;

END pkg_gestionordenes;
/
begin
  pkg_utilidades.prAplicarPermisos('PKG_GESTIONORDENES', 'PERSONALIZACIONES');
end;
/