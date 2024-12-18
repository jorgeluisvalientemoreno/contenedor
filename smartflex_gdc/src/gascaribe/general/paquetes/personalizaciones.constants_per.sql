create or replace PACKAGE                   personalizaciones.constants_per AS
/*******************************************************************************
    Package:        constants_per
    Descripción:    Paquete con constantes en el esquema personalizado
    Autor:          Lubin Pineda - MVM
    Fecha:          16/02/2023

    Historial de Modificaciones
    =============================
    FECHA           AUTOR               Descripción
    05/02/2024      felipe.valencia     OSF-2306: Se modifica el tamaño de la variable
                                                  TIPO_XML_SOL de 2000 a 32767
    27/09/2023      jsoto               OSF-1662: Se agrega la constante para tipo de identificacion 1:Cedula
                                                  Valores para representar las constantes NO,SI,YES
    15/09/2023      jsoto               OSF-1573: Se adicionan funciones para retornar falso o verdadero
    14/09/2023      jsoto               OSF-1571: Se adiciona varible TIPO_XML_SOL
    05/07/2023      jpinedc             OSF-1299: Se quita CNUGENERIC_ERROR
    12/05/2023      jcatuchemvm         OSF-1299: Adición de nuevas constantes
    16/02/2023      jpinedc             OSF-858	: Creación el paquete
*******************************************************************************/
    TYPE TYREFCURSOR IS REF CURSOR;

    TIPO_XML_SOL VARCHAR2(32767);
    
    /*Valor numérico para ok*/
    OK			        CONSTANT NUMBER := 0;

    /*Valor numérico para nok*/
    NOK			        CONSTANT NUMBER := 1;

    /*Valor numérico para verdad*/
    CNUTRUE		        CONSTANT NUMBER := 1;

    /*Valor numérico para falso*/
    CNUFALSE	        CONSTANT NUMBER := 0;

    /*Valor numérico para éxito*/
    CNUSUCCESS          CONSTANT NUMBER(1) := OK;
    
    /*Valor numérico para tipo de identificacion 1:Cédula ciudadania*/
    CNUTIPOIDENCEDULA   CONSTANT NUMBER := 1;
    
    /*Valor para constante NO*/
    CSBNO               CONSTANT VARCHAR2(1) := 'N';

    /*Valor para constante SI*/
    CSBSI               CONSTANT VARCHAR2(1) := 'S';

    /*Valor para constante YES*/
    CSBYES              CONSTANT VARCHAR2(1) := 'Y';


   FUNCTION GETTRUE
    RETURN BOOLEAN;

   FUNCTION GETFALSE
    RETURN BOOLEAN;


END constants_per;
/
create or replace package body personalizaciones.constants_per AS
/*******************************************************************************
    Package:        constants_per
    Descripción:    Se crea cuerpo del paquete para agregar funciones
    Autor:          Jhon Soto - (Horbath)
    Fecha:          15/09/2023

    Historial de Modificaciones
    =============================
    FECHA           AUTOR               Descripción
    15/09/2023      jsoto               OSF-1573: Se adicionan funciones para retornar falso o verdadero
*******************************************************************************/
   FUNCTION GetTrue
    RETURN BOOLEAN
    IS
    BEGIN
      RETURN TRUE;
   END;
   FUNCTION GetFalse
    RETURN BOOLEAN
    IS
    BEGIN
      RETURN FALSE;
   END;

END;
/
PROMPT Otorgando permisos de ejecución a CONSTANTS_PER
BEGIN
  pkg_utilidades.prAplicarPermisos('CONSTANTS_PER','PERSONALIZACIONES');
END;
/