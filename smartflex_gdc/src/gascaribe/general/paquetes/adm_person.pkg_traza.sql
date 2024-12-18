create or replace package adm_person.pkg_traza is

/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : pkg_traza
    Descripcion     : Paquete para la gestión de traza personalizada. 
                      Enmascara los métodos de producto y adiciona a cada 
                      mensaje de traza creado un prefijo para identificar 
                      que se generó desde una funcionalidad personalizada. 
    Autor           : Edilay Peña Osorio
    Fecha           : 26/09/2023
    
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso     Descripción
    epenao      26/09/2023  OSF-1659 Creacion paquete.
***************************************************************************/
   ----------------------------------------------
   --Constantes globales del paquete
   ----------------------------------------------
  csbINICIO            CONSTANT VARCHAR2(4) := 'I';   -- Indica inicio de método
  csbFIN               CONSTANT VARCHAR2(4) := 'F';   -- Indica Fin de método ok
  csbFIN_ERC           CONSTANT VARCHAR2(4) := 'FEC'; -- Indica fin de método con error controlado
  csbFIN_ERR           CONSTANT VARCHAR2(4) := 'FE';  -- Indica fin de método con error no controlado
  
  --Constantes para el nivel de la traza
  cnuNivelTrzDef       CONSTANT NUMBER(2)  := 4;  --nivel defecto para la traza
  cnuNivelTrzApi       CONSTANT NUMBER(2)  := 3;  --nivel de traza para los apis
  cnuNivelTrzFW        CONSTANT NUMBER(2)  := 2;  --nivel de traza para los objetos invocados desde el framework    
  cnuNivelTrzTrg       CONSTANT NUMBER(2)  := 9;  --nivel de traza para los triggers

  SUBTYPE TYMensTraza  is  VARCHAR2(32767);
  SUBTYPE TYMensajetb  is  ge_log_trace.message%type;

  --Retorna el valor que indica a la traza inicio del método
  function fsbINICIO return varchar2;

  --Retorna el valor que indica a la traza fin del método ok
  function fsbFIN return varchar2;

  --Retorna el valor que indica a la traza fin método con error controlado
  function fsbFIN_ERC return varchar2;

  --Retorna el valor que indica a la traza fin de método con error no controlado
  function fsbFIN_ERR return varchar2;

  --Retorna el valor por defecto de la traza
  function fnuNivelTrzDef return number;

  --Retorna el valor de nivel de traza para los apis
  function fnuNivelTrzApi return number;

  --Retorna el valor de nivel de traza para objetos invocados desde el framework
  function fnuNivelTrzFW return number;

  --Retorna el valor de nivel de traza para los triggers
  function fnuNivelTrzTrg return number;

  --establece el nivel de la traza a mostrar
  procedure setlevel
 (
     inuNivelTrz   IN  NUMBER DEFAULT 0
 );

  --Borra la table ge_log_trace para la sesión actual.
  procedure Init;

  --Establece la salida de la traza a través de dbms_ouptut
  procedure traza_dbms_output;

  --Establece la salida de la traza en la tabla ge_log_trace
  procedure traza_tabla;

  --Crea el mensaje de traza
  PROCEDURE trace
  (
     isbMensaje    IN  pkg_traza.TYMensTraza,
     inuNivelTrz   IN  NUMBER DEFAULT '1' ,
     isbMomento    IN  VARCHAR2 DEFAULT NULL
  );

end pkg_traza;
/

create or replace package body adm_person.pkg_traza is

/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : pkg_traza
    Descripcion     : Paquete para la generación de los XMLs de las solicitudes FNB
    Autor           : Edilay Peña Osorio
    Fecha           : 26/09/2023
    Parametros de Entrada

    Parametros de Salida
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso     Descripción
    epenao     26/09/2023   OSF-1659 Creacion paquete.
***************************************************************************/

   csbPrePERSON         CONSTANT VARCHAR2(6)   := '[GDC] ';--Prefijo para mensajes personalizados. 
   cnuLargoMensaje      CONSTANT NUMBER        := 4000; --Longitud máxima del mensaje de traza

    --constante nombre del paquete
    csbNOMPKG            CONSTANT VARCHAR2(32) := $$PLSQL_UNIT||'.';

  function fsbINICIO return varchar2 is
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbINICIO
    Descripcion     : Retorna el valor de la constante: csbINICIO
    Autor           : Edilay Peña Osorio
    Fecha           : 27/09/2023
    Parametros de Entrada:
    Nombre                  Tipo      Descripción
    ===================    =========  =============================

    Parametros de Salida
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso     Descripción
    epenao       27/09/2023 OSF-1659 Creacion método.
***************************************************************************/  
  BEGIN
    RETURN csbINICIO;
  END fsbINICIO;

  function fsbFIN return varchar2 is
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbFIN
    Descripcion     : Retorna el valor de la constante: csbFIN
    Autor           : Edilay Peña Osorio
    Fecha           : 27/09/2023
    Parametros de Entrada:
    Nombre                  Tipo      Descripción
    ===================    =========  =============================

    Parametros de Salida
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso     Descripción
    epenao       27/09/2023 OSF-1659 Creacion método.
***************************************************************************/    
  BEGIN
    RETURN csbFIN;
  END fsbFIN;

  function fsbFIN_ERC return varchar2 is
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbFIN_ERC
    Descripcion     : Retorna el valor de la constante: csbFIN_ERC
    Autor           : Edilay Peña Osorio
    Fecha           : 27/09/2023
    Parametros de Entrada:
    Nombre                  Tipo      Descripción
    ===================    =========  =============================

    Parametros de Salida
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso     Descripción
    epenao       27/09/2023 OSF-1659 Creacion método.
***************************************************************************/      
  BEGIN
    RETURN csbFIN_ERC;
  END fsbFIN_ERC;

  function fsbFIN_ERR return varchar2 is
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbFIN_ERR
    Descripcion     : Retorna el valor de la constante: csbFIN_ERR
    Autor           : Edilay Peña Osorio
    Fecha           : 27/09/2023
    Parametros de Entrada:
    Nombre                  Tipo      Descripción
    ===================    =========  =============================

    Parametros de Salida
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso     Descripción
    epenao       27/09/2023 OSF-1659 Creacion método.
***************************************************************************/   
  BEGIN
    RETURN csbFIN_ERR;
  END fsbFIN_ERR;

  function fnuNivelTrzDef return number is
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuNivelTrzDef
    Descripcion     : Retorna el valor de la constante: cnuNivelTrzDef
                      el cual tiene el valor por defecto para la 
                      generación de traza. 
    Autor           : Edilay Peña Osorio
    Fecha           : 27/09/2023
    Parametros de Entrada:
    Nombre                  Tipo      Descripción
    ===================    =========  =============================

    Parametros de Salida
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso     Descripción
    epenao       27/09/2023 OSF-1659 Creacion método.
***************************************************************************/     
  BEGIN
    RETURN cnuNivelTrzDef;
  END fnuNivelTrzDef;

  function fnuNivelTrzApi return number is
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuNivelTrzApi
    Descripcion     : Retorna el valor de la constante: cnuNivelTrzApi
                      el cual tiene el valor para indicar en la traza 
                      que es un API
    Autor           : Edilay Peña Osorio
    Fecha           : 27/09/2023
    Parametros de Entrada:
    Nombre                  Tipo      Descripción
    ===================    =========  =============================

    Parametros de Salida
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso     Descripción
    epenao       27/09/2023 OSF-1659 Creacion método.
***************************************************************************/     
  BEGIN
    RETURN cnuNivelTrzApi;
  END fnuNivelTrzApi;  


  function fnuNivelTrzFW return number is
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuNivelTrzApi
    Descripcion     : Retorna el valor de la constante: cnuNivelTrzFW
                      el cual tiene el valor para indicar en la traza 
                      que es un método lamado por el FrameWork
    Autor           : Edilay Peña Osorio
    Fecha           : 27/09/2023
    Parametros de Entrada:
    Nombre                  Tipo      Descripción
    ===================    =========  =============================

    Parametros de Salida
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso     Descripción
    epenao       27/09/2023 OSF-1659 Creacion método.
***************************************************************************/     
  BEGIN
    RETURN cnuNivelTrzFW;
  END fnuNivelTrzFW;  

  function fnuNivelTrzTrg return number is
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuNivelTrzApi
    Descripcion     : Retorna el valor de la constante: cnuNivelTrzTrg
                      el cual tiene el valor para indicar en la traza 
                      que es un trigger
    Autor           : Edilay Peña Osorio
    Fecha           : 27/09/2023
    Parametros de Entrada:
    Nombre                  Tipo      Descripción
    ===================    =========  =============================

    Parametros de Salida
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso     Descripción
    epenao       27/09/2023 OSF-1659 Creacion método.
***************************************************************************/     
  BEGIN
    RETURN cnuNivelTrzTrg;
  END fnuNivelTrzTrg;   

 PROCEDURE setlevel
 (
     inuNivelTrz   IN  NUMBER DEFAULT 0
 )
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : setlevel
    Descripcion     : Establece el nivel para la traza a mostrar
    Autor           : Edilay Peña Osorio
    Fecha           : 27/09/2023
    Parametros de Entrada:
    Nombre                  Tipo      Descripción
    ===================    =========  =============================
    inuNivelTrz                NUMBER    Valor por defecto 0    
                                      Nivel de traza a utilizar. 
    Parametros de Salida
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso     Descripción
    epenao       27/09/2023 OSF-1659 Creacion método.
***************************************************************************/      
 IS
     csbNOMBPROC           CONSTANT VARCHAR2(30) := 'setlevel';
 BEGIN
     ut_trace.setlevel(inuNivelTrz);     
 EXCEPTION
    WHEN others THEN
        TRACE(csbNOMPKG||csbNOMBPROC, cnuNivelTrzDef, csbFIN_ERR);                 
        PKG_ERROR.SETERROR;
        raise PKG_ERROR.CONTROLLED_ERROR;
 END setlevel;

 PROCEDURE Init
 IS
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : Init
    Descripcion     : Borra la tabla ge_log_trace para la session actual
    Autor           : Edilay Peña Osorio
    Fecha           : 27/09/2023
    Parametros de Entrada:
    Nombre                  Tipo      Descripción
    ===================    =========  =============================

    Parametros de Salida
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso     Descripción
    epenao       27/09/2023 OSF-1659 Creacion método.
***************************************************************************/      
     csbNOMBPROC           CONSTANT VARCHAR2(30) := 'Init';
 BEGIN
     --borra todos los mensajes de la tabla ge_log_trace para la sesión actual
     ut_trace.Init;
     trace('Id de sesión para la traza: '||SYS_CONTEXT('USERENV','SESSIONID') );

 EXCEPTION
    WHEN others THEN
        TRACE(csbNOMPKG||csbNOMBPROC, cnuNivelTrzDef, csbFIN_ERR);                 
        PKG_ERROR.SETERROR;
        raise PKG_ERROR.CONTROLLED_ERROR;
 END Init;

 procedure traza_dbms_output
 is
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : traza_dbms_output
    Descripcion     : Establece la salida de la traza a través de dbms_ouptut
    Autor           : Edilay Peña Osorio
    Fecha           : 27/09/2023
    Parametros de Entrada:
    Nombre                  Tipo      Descripción
    ===================    =========  =============================

    Parametros de Salida
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso     Descripción
    epenao       27/09/2023 OSF-1659 Creacion método.
***************************************************************************/       
     csbNOMBPROC           CONSTANT VARCHAR2(30) := 'traza_dbms_output';
 BEGIN
     --Establece la salida de la traza a través de dbms_ouptut
     ut_trace.setoutput(ut_trace.CNUTRACE_DBMS_OUTPUT);
 EXCEPTION
    WHEN others THEN
        TRACE(csbNOMPKG||csbNOMBPROC, cnuNivelTrzDef, csbFIN_ERR);                 
        PKG_ERROR.SETERROR;
        raise PKG_ERROR.CONTROLLED_ERROR;
 END traza_dbms_output;

 procedure traza_tabla
 is
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : traza_tabla
    Descripcion     : Establece la salida de la traza en la tabla ge_log_trace
    Autor           : Edilay Peña Osorio
    Fecha           : 27/09/2023
    Parametros de Entrada:
    Nombre                  Tipo      Descripción
    ===================    =========  =============================

    Parametros de Salida
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso     Descripción
    epenao       27/09/2023 OSF-1659 Creacion método. 
***************************************************************************/          
     csbNOMBPROC           CONSTANT VARCHAR2(30) := 'traza_tabla';
 BEGIN
     --Establece la salida de la traza en la tabla ge_log_trace
     ut_trace.setoutput(Ut_trace.CNUTRACE_OUTPUT_DB);

 EXCEPTION 
     WHEN others THEN
        TRACE(csbNOMPKG||csbNOMBPROC, cnuNivelTrzDef, csbFIN_ERR);                 
        PKG_ERROR.SETERROR;
        raise PKG_ERROR.CONTROLLED_ERROR;
 END traza_tabla;

 PROCEDURE Trace_SetLongMsg
 (
     isbMensaje   IN VARCHAR2,
     inuNivelTrz  IN NUMBER DEFAULT 1
 )
 IS
     /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : Trace_SetLongMsg.
        Descripcion     : Toma el mensaje enviado y lo parte cada 3998 carácteres
                          de manera que se inserte correctamente cada parte 
                          como una nueva fila de ge_log_trace.
                          
        Autor           : Edilay Peña Osorio
        Fecha           : 27/09/2023
        Parametros de Entrada:
        Nombre                  Tipo      Descripción
        ===================    =========  =============================
        isbMensaje              IN         Tipo de dato:
                                           pkg_traza.TYMensTraza/VARCHAR2(32767)
                                           Mensaje a desplegar en la traza. 

        inuNivelTrz             IN         Nivel de identación para la generación 
                                           del mensaje de traza, valor por defecto 1.

        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso     Descripción
        epenao      27/09/2023 OSF-1659  Creacion método. 
    ***************************************************************************/      
     nuInicio       NUMBER;
     nuTotMens      NUMBER;
     nuLargMens     NUMBER;
     sbMensInsr     TYMensajetb;
     csbNOMBPROC   CONSTANT VARCHAR2(30) := 'Trace_SetLongMsg';

 BEGIN

     --quita los espacios correspondientes a la identación 4 espacios por cada nivel
     -- y el correspondiente al caracter que indica hay un siguiente mensaje
     nuLargMens := cnuLargoMensaje-(4*inuNivelTrz)-1;

     --determina cuántos mensajes deben insertarse
     nuTotMens := LENGTH(isbMensaje) / nuLargMens;

     IF (nuTotMens > TRUNC(nuTotMens)) THEN
         --si el mensaje sigue siendo mayor que la cantidad de inserts
         --se suma uno  para que imprima la última parte
         nuTotMens := TRUNC(nuTotMens) + 1;
     END IF;

     FOR idx IN 1 .. nuTotMens LOOP
         --obtiene la posición inicial para tomar el mensaje
         nuInicio :=  ((idx-1) * nuLargMens) + 1;
         --corta la parte del mensaje a insertar, si aún falta mensaje por guardar
         --al final de la línea pone '»'         
         sbMensInsr := SUBSTR(isbMensaje, nuInicio, nuLargMens)||
                       CASE WHEN (idx<nuTotMens) THEN  '»'
                        ELSE '' END;
             
         UT_Trace.Trace(sbMensInsr, inuNivelTrz);  
     END LOOP;

 EXCEPTION
     WHEN PKG_ERROR.CONTROLLED_ERROR THEN
         TRACE(csbNOMPKG||csbNOMBPROC, cnuNivelTrzDef, csbFIN_ERC);
         RAISE PKG_ERROR.CONTROLLED_ERROR;
     WHEN OTHERS THEN
         TRACE(csbNOMPKG||csbNOMBPROC, cnuNivelTrzDef, csbFIN_ERR);
         PKG_ERROR.SETERROR;
         RAISE PKG_ERROR.CONTROLLED_ERROR;

 END Trace_SetLongMsg;



 PROCEDURE trace
 (
    isbMensaje    IN  pkg_traza.TYMensTraza,
    inuNivelTrz   IN  NUMBER DEFAULT '1' ,
    isbMomento    IN  VARCHAR2 DEFAULT NULL
 )
 IS     
     /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : trace.
        Descripcion     : inserta el mensaje enviado en la tabla ge_log_trace
                          campo message.
                          Antepone al mensaje el prefijo de mensaje 
                          personalizado y el momento del mensaje, este puede ser:
                            _Inicia   '
                            _Finaliza '
                            *Finaliza con error controlado* '
                            *Finaliza con error* '
                            
                          Si el mensaje es más largo que el permitido por el 
                          campo ge_log_trace.message llama al método Trace_SetLongMsg
                          para que parta el mensaje en varios inserts y así 
                          guardarlo completo. 
                          
        Autor           : Edilay Peña Osorio
        Fecha           : 27/09/2023
        Parametros de Entrada:
        Nombre                  Tipo      Descripción
        ===================    =========  =============================
        isbMensaje              IN         Tipo de dato:
                                           pkg_traza.TYMensTraza/VARCHAR2(32767)
                                           Mensaje a desplegar en la traza. 

        inuNivelTrz             IN         Nivel de identación para la generación 
                                           del mensaje de traza, valor por defecto 1.

        isbMomento              IN         Indicador del tipo mensaje para adición de
                                           prefijo al presentarlo en la traza.     

        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso     Descripción
        epenao      27/09/2023 OSF-1659  Creacion método. 
    ***************************************************************************/     
    
     sbTipoMens              VARCHAR2(40);--Mensaje inicio, fin, error, error controlado o normal.
     sbmensaje               TYMensTraza;--Mensaje completo
     csbNOMBPROC             CONSTANT VARCHAR2(30) := 'trace';

     function fsbTipoMens return VARCHAR2 IS 
     
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : trace.fsbTipoMens
        Descripcion     : De acuerdo con el valor de la variale momento 
                          establece la cadena inicial del mensaje de traza
                          para identificar si inició un método, terminó ok o 
                          terminó con error.                           
                          
        Autor           : Edilay Peña Osorio
        Fecha           : 27/09/2023
        Parametros de Entrada:
        Nombre                  Tipo      Descripción
        ===================    =========  =============================

        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso     Descripción
        epenao      27/09/2023 OSF-1659  Creacion método. 
    ***************************************************************************/         
         sbPref  varchar2(40);
     BEGIN
        -- Se establece el prefijo de acuerdo con el momento del mensaje
        sbPref := CASE isbMomento
                      WHEN (csbINICIO   ) THEN '_Inicia   '
                      WHEN (csbFIN    ) THEN '_Finaliza '
                      WHEN (csbFIN_ERC) THEN '*Finaliza con error controlado* '
                      WHEN (csbFIN_ERR) THEN '*Finaliza con error* '
                      ELSE ' '
                  END;     
        return sbPref;  
     END fsbTipoMens;

     function fsbmensaje return VARCHAR2 IS
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : trace.fsbmensaje
        Descripcion     : Arma el mensaje a insertar en ge_log_trace.message
                          de la siguiente manera:
                          1.Prefijo para indicar que es un método personalizado. 
                          2.Identación/Sangría de acuerdo con el nivel del objeto
                          3.Tipo de mensaje: inicio método, fin método o traza. 
                          4.Mensaje enviado. 
                          
                          
        Autor           : Edilay Peña Osorio
        Fecha           : 27/09/2023
        Parametros de Entrada:
        Nombre                  Tipo      Descripción
        ===================    =========  =============================

        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso     Descripción
        epenao      27/09/2023 OSF-1659  Creacion método. 
    ***************************************************************************/        
     
        sbcadena TYMensTraza;
     begin

         sbTipoMens := fsbTipoMens;--

         --Arma el mensaje completo
         sbcadena := csbPrePERSON||sbTipoMens||isbMensaje;

         return sbcadena;
     end fsbmensaje;

     function fboMsgLargo(isbmensaje in TYMensTraza) return BOOLEAN is
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : trace.fboMsgLargo
        Descripcion     : Retorna verdadero si el largo de mensaje 
                          supera el tamaño a insertar en ge_log_trace.message
                          
                          
        Autor           : Edilay Peña Osorio
        Fecha           : 27/09/2023
        Parametros de Entrada:
        Nombre                  Tipo      Descripción
        ===================    =========  =============================

        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso     Descripción
        epenao      27/09/2023 OSF-1659  Creacion método. 
    ***************************************************************************/             
         nulong  NUMBER;
         bolong  BOOLEAN := FALSE; 
     BEGIN
         --obtiene la longitud del mensaje a guardar en ge_log_trace
         --sumando los espacios de identación que son 4 por cada nivel
         nulong := NVL(LENGTH(isbmensaje),0)+(4*inuNivelTrz);

         --sí el mensaje es más largo que el campo de la tabla
         --retorna verdadero.           
         IF nulong > cnuLargoMensaje THEN
            bolong := TRUE;
         END IF;

        return bolong;
     END fboMsgLargo;


     procedure prLogError is 
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : trace.prLogError
        Descripcion     : Si el mensaje se regitra por inicio, fin,  fin con 
                          error controlado o fin con error no controlado 
                          hace el registro correspondiente en la pila de errores. 
                          
        Autor           : Edilay Peña Osorio
        Fecha           : 27/09/2023
        Parametros de Entrada:
        Nombre                  Tipo      Descripción
        ===================    =========  =============================

        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso     Descripción
        epenao      27/09/2023 OSF-1659  Creacion método. 
    ***************************************************************************/
     begin     
            -- si se trata del push se ingresa en el call stack el método enviado.
            IF (isbMomento = csbINICIO) THEN
                Errors.Push(isbMensaje);
            END IF;

            --Si se trata de fin del método se finaliza su llamado en el call stack. 
            IF (isbMomento IN (csbFIN, csbFIN_ERC, csbFIN_ERR)) THEN
                Errors.Pop;
            END IF;

     end prLogError;

 BEGIN

     IF (inuNivelTrz > UT_Trace.GetLevel) THEN
         RETURN; 
     END IF;

     prLogError;--ingresa o saca el objeto del call stack 
     sbmensaje  := fsbmensaje;--Arma el mensaje de traza

     --Si el mensaje de traza completo mide más que el campo 
     --ge_log_trace.message se parte el mensaje
     IF (fboMsgLargo(sbmensaje)) THEN

         --inserta el mensaje por partes en ge_log_trace
         Trace_SetLongMsg
         (
             sbmensaje,
             inuNivelTrz
         );

     ELSE
         -- Inserta el mensaje
         UT_Trace.Trace
         (   sbmensaje,
             inuNivelTrz
         ); 

     END IF;

 EXCEPTION
     WHEN PKG_ERROR.CONTROLLED_ERROR THEN
         TRACE(csbNOMPKG||csbNOMBPROC, cnuNivelTrzDef, csbFIN_ERC);
         RAISE PKG_ERROR.CONTROLLED_ERROR;
     WHEN OTHERS THEN
         TRACE(csbNOMPKG||csbNOMBPROC, cnuNivelTrzDef, csbFIN_ERR);
         PKG_ERROR.SETERROR;
         RAISE PKG_ERROR.CONTROLLED_ERROR;

 END trace;

end pkg_traza;
/
PROMPT Otorgando permisos de ejecución a adm_person.pkg_traza
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_TRAZA','ADM_PERSON');
END;
/ 
PROMPT Asignación de permisos en PKG_TRAZA para el Usuario USELOPEN
GRANT EXECUTE ON PKG_TRAZA TO USELOPEN;
/