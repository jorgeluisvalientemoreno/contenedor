create or replace PACKAGE                   personalizaciones.constants_per AS
/*******************************************************************************
    Package:        constants_per
    Descripción:    Paquete con constantes en el esquema personalizado
    Autor:          Lubin Pineda - MVM
    Fecha:          16/02/2023

    Historial de Modificaciones
    =============================
    FECHA           AUTOR               Descripción
    21/03/2025      felipe.valencia     OSF-3846: SE agregan constantes de facturacion
	25/02/2025		jerazomvm			OSF-4046: Se crea la constante COD_SERVICIO_GAS
 	  10/12/2024		jsoto				          OSF-3740; Se agregan constantes de facturacion
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

	/* Valores de constantes para tipo de documento al imprimir cupon*/
	
	CSBTOKEN_FACTURA 		CONSTANT VARCHAR2(2) := 'FA';

	CSBTOKEN_CUENCUAG 		CONSTANT VARCHAR2(2) := 'CA';

	CSBTOKEN_APLICA_FACTURA CONSTANT VARCHAR2(2) := 'AF';

	CSBTOKEN_CUENTA  		CONSTANT VARCHAR2(2) := 'CC'; 

	CSBTOKEN_PAGO_FINANCIACION CONSTANT VARCHAR2(2) := 'FI';

	CSBTOKEN_ABONO_DEUDA_DIF 	CONSTANT VARCHAR2(2) := 'AD';

	CSBTOKEN_ANTICIPO 		CONSTANT VARCHAR2(2) := 'AN';

	CSBTOKEN_SOLICITUD 		CONSTANT VARCHAR2(2) := 'PP';

	CSBTOKEN_NEGOCIACION 	CONSTANT VARCHAR2(2) := 'NG';
	
	CSBTOKEN_DEPOSITO 		CONSTANT VARCHAR(2) := 'DE';

	/*Valores de constantes para flujos de negocio */

	CSBACTESPERAPAGO		CONSTANT NUMBER := 267;
	
	CSBESTADOESPERA			CONSTANT NUMBER := 2;
	
	-- Servicio de gas
	COD_SERVICIO_GAS		CONSTANT NUMBER := 7014;
    
  CSBDEBITO               CONSTANT VARCHAR2(2) := 'DB';
  
  CSBCREDITO              CONSTANT VARCHAR2(2) := 'CR';
  
  CSBPOSTFACTURACION      CONSTANT VARCHAR2(1) := 'P';
  
  CNUSUMA_CARGO           CONSTANT NUMBER :=  1;
  
  CNURESTA_CARGO          CONSTANT NUMBER :=  -1;
  
  CSBTOKEN_DIFERIDO       CONSTANT VARCHAR2(3) := 'DF-';
  
  CSBTOKEN_CUOTA_EXTRA    CONSTANT VARCHAR2(3) := 'CX-';

  CSBCUSTOMERCARE         CONSTANT VARCHAR2( 10 ) := 'CUSTOMER';
  
  CSBTOKENNOTADEBITO      CONSTANT VARCHAR2(3) := 'ND-';
  
  CSBCONSUMO VARCHAR2( 1 ) := 'C';
  
  CSBDOC_CANC_AJUSTE  CONSTANT VARCHAR2(12) := 'CANC.AJUSTE';

  CSBDOC_AJUSTE           CONSTANT VARCHAR2(12) := 'AJUSTE';

  CNUNULLNUM              NUMBER( 2 ) := -1;

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