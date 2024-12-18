CREATE OR REPLACE package ADM_PERSON.LDCI_PKREPODATATYPE AS

/*
   PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
   PAQUETE       : LDCI_PKREPODATAtype
   AUTOR         : OLSoftware / Carlos E. Virgen
   FECHA         : 19/03/2013
   RICEF : I000
   DESCRIPCION: Paquete que almacena la definicion de los diferentes tipos de datos de los desarrollos de integracion

  Historia de Modificaciones
  Autor    Fecha      Descripcion
  carlosvl 19-03-2013 Version inicial
*/

/*Nota:
Para definir el nombre del tipo registro debe tener en cuenta que:

Ejemplo: tySuscRecord
Donde:
- [ty]:     Es el prefijo que indica que es un tipo
- [Susc]:   Nombre de la clase del tipo, en esta caso Suscriptor
- [Record]: Es el nombre del tipo usado en esta caso "is record"

Adicional debe de agregar la documentacion del tipo de la siguiente forma
-- type: tySuscRecord
-- Descripcion: Tipo de dato referenciado para obtener los datos del suscriptor
-- API: OS_GETSUBSCRIPTIONDATA
-- Topic ID: apis.aten_cliente.aten_cliente.OS_GetSubscriptionData  <<< Este apartado es extraido de la documentacion de Open


**Los campos definidos en cada tipo deben ser refrenciados a las columnas de las tablas
*/


-- Tipo de dato de cursor referenciado
type tyRefcursor is ref cursor;

-- type: tySuscRecord
-- Descripcion: Tipo de dato referenciado para obtener los datos del suscriptor
-- API: OS_GETSUBSCRIPTIONDATA
-- Topic ID: apis.aten_cliente.aten_cliente.OS_GetSubscriptionData
type tySuscRecord is record (
SUSCCCODI     SUSCRIPC.SUSCCODI%type, -- Codigo del Contrato
SUSCCBANC     SUSCRIPC.SUSCBANC%type, -- Codigo del Banco
SUSCBANC_DESC BANCO.BANCNOMB%type,    -- Nombre del Banco
SUSCSUBA      SUSCRIPC.SUSCSUBA%type, -- Sucursal Bancaria
SUSCTCBA      SUSCRIPC.SUSCTCBA%type, -- Codigo de Tipo de Cuenta Bancaria
SUSCTCBA_DESC TICUBANC.TCBATICU%type, -- Tipo de Cuenta Bancaria
SUSCBAPA      SUSCRIPC.SUSCBAPA%type, -- Codigo del Banco Pagador
SUSCBAPA_DESC BANCO.BANCNOMB%type,    -- Nombre del Banco Pagador
SUSCSBBP      SUSCRIPC.SUSCSBBP%type, -- Sucursal del Banco Pagador
SUSCTCBP      SUSCRIPC.SUSCTCBP%type, -- Codigo del Tipo de Cuenta del Banco Pagador
SUSCTCBP_DESC TICUBANC.TCBATICU%type, -- Tipo de Cuenta del Banco Pagador
SUSCCUBP      SUSCRIPC.SUSCCUBP%type, -- Cuenta del Banco Pagador
SUSCCUCO      SUSCRIPC.SUSCCUCO%type, -- Cuenta para Debito AutomÃ¡tico
SUSCCECO      SUSCRIPC.SUSCCECO%type, -- Centro de Costo
SUSCCEMD      SUSCRIPC.SUSCCEMD%type, -- Codigo de Configuracion de Extraccion y Mezcla de Datos
SUSCCEMD_DESC ED_CONFEXME.COEMDESC%type, -- Descripcion de Configuracion de Extraccion y Mezcla de Datos
SUSCCEMF      SUSCRIPC.SUSCCEMF%type,    -- Codigo de Configuracion de Extraccion y Mezcla de Factura
SUSCCEMF_DESC ED_CONFEXME.COEMDESC%type, -- Descripcion de Configuracion de Extraccion y Mezcla de Factura
SUSCCICL      SUSCRIPC.SUSCCICL%type,    -- Codigo Ciclo de Facturacion
SUSCCICL_DESC CICLO.CICLDESC%type,       -- Descripcion Ciclo de Facturacion
SUSCCLIE      SUSCRIPC.SUSCCLIE%type,    -- Codigo Cliente
SUSCCLIE_DESC VARCHAR2(300),              -- Apellido y Nombre del Cliente
SUSCDECO      SUSCRIPC.SUSCDECO%type,    -- Direccion Electronica de Cobro
SUSCDETA      SUSCRIPC.SUSCDETA%type,    -- Indicador de Resumen Detallado (S/N)
SUSCEFCE      SUSCRIPC.SUSCEFCE%type,    -- Indicador de EnvÃ­o de Factura por Correo Electronico (S/N)
SUSCENCO      SUSCRIPC.SUSCENCO%type,    -- Entidad de Cobro
SUSCENCO_DESC OR_OPERATING_UNIT.NAME%type, -- Nombre de Entidad de Cobro
SUSCTDCO      SUSCRIPC.SUSCTDCO%type,      -- Codigo del Tipo de Direccion de Cobro
SUSCTDCO_DESC SUSCRIPC.SUSCSUBA%type,      -- Tipo de Direccion de Cobro
SUSCIDDI      SUSCRIPC.SUSCIDDI%type,      -- Codigo de Direccion de Cobro
SUSCIDDI_DESC AB_ADDRESS.ADDRESS%type,     -- Direccion de Cobro
SUSCIDTT      SUSCRIPC.SUSCIDTT%type,      -- Codigo del Titular de la Tarjeta
SUSCMAIL      SUSCRIPC.SUSCMAIL%type,      -- Correo Electronico del Contrato
SUSCNUPR      SUSCRIPC.SUSCNUPR%type,      -- NÃºmero del Proceso
SUSCPRCA      SUSCRIPC.SUSCPRCA%type,      -- Codigo de Programa de Cartera
SUSCPRCA_DESC PROGCART.PRCADESC%type,	  -- Programa de Cartera
SUSCSAFA      SUSCRIPC.SUSCSAFA%type,      -- Saldo a Favor
SUSCSIST      SUSCRIPC.SUSCSIST%type,      -- Codigo de la Empresa
SUSCSIST_DESC SISTEMA.SISTEMPR%type,       -- Empresa
SUSCTIMO      SUSCRIPC.SUSCTIMO%type,      -- Codigo del Tipo de Moneda
SUSCTIMO_DESC GST_TIPOMONE.TIMODESC%type,  -- Tipo de Moneda
SUSCTISU      SUSCRIPC.SUSCTISU%type,      -- Codigo del Tipo de Contrato
SUSCTISU_DESC GE_SUBSCRIPTION_type.DESCRIPTION%type, -- Tipo de Contrato
SUSCTTPA      SUSCRIPC.SUSCTTPA%type,                -- Codigo del Tipo de Tarjeta para Pago
SUSCTTPA_DESC CLASDOPA.CLDPDESC%type,                -- Tipo de Tarjeta para Pago
SUSCVETC      SUSCRIPC.SUSCVETC%type);               -- Fecha de Vencimiento de la Tarjeta de Credito

-- type: tySucursalesRecord
-- Descripcion:tipo de dato referenciado para obtener listado de sucursales cercanas a una direccion de pago
-- API: OS_GETBRANCHBYADDRESS
-- Topic ID: apis.banco_dir.OS_GetBranchByAddress
type tySucursalesRecord is record (
SUBABANC  SUCUBANC.SUBABANC%type,-- Identificador del Banco
BANCO     VARCHAR2(200),          -- Nombre del Banco
SUBACODI  SUCUBANC.SUBACODI%type,-- Punto de pago
SUBANOMB  SUCUBANC.SUBANOMB%type,-- Nombre de la sucursal
SUBAADID  SUCUBANC.SUBAADID%type,-- Identificador de la DirecciÃ¿Â³n
ADDRESS   VARCHAR2(200),          -- Direccion Sucursal
SUBACOPO  SUCUBANC.SUBACOPO%type,-- Codigo Postal
SUBATELE  SUCUBANC.SUBATELE%type,-- Telefono Sucursal de la Entidad
SUBASIST  SUCUBANC.SUBASIST%type);-- Empresa

-- type: tyProductDataRecord
-- Descripcion:tipo de dato referenciado para obtener de los productos de un servicio suscrito
-- API: OS_GETPRODUCTDATA
-- Topic ID: apis.aten_cliente.aten_cliente.OS_GetProductData
type tyProductDataRecord is record (
PRODUCT_ID             PR_PRODUCT.PRODUCT_ID%type,                  -- Consecutivo De Producto
SUBSCRIPTION_ID        PR_PRODUCT.SUBSCRIPTION_ID%type,             -- CONSECUTIVO DE SUSCRIPCIÃ¿N AL PRODUCTO
PRODUCT_type_ID        PR_PRODUCT.PRODUCT_type_ID%type,             -- Consecutivo De Tipo De Producto
DISTRIBUT_ADMIN_ID     PR_PRODUCT.DISTRIBUT_ADMIN_ID%type,          -- DistribuciÃ³n Administrativa
IS_PROVISIONAL         PR_PRODUCT.IS_PROVISIONAL%type,              -- Indica Si Es O No Provisional Y:[SI], N:[NO]
PROVISIONAL_END_DATE   PR_PRODUCT.PROVISIONAL_END_DATE%type,        -- Fecha Final De Servicio Provisional
PROVISIONAL_BEG_DATE   PR_PRODUCT.PROVISIONAL_BEG_DATE%type,        -- Fecha Inicial De Servicio Provisional
PRODUCT_STATUS_ID      PR_PRODUCT.PRODUCT_STATUS_ID%type,           -- Estado
SERVICE_NUMBER         PR_PRODUCT.SERVICE_NUMBER%type,              -- NÃºmero De Producto
CREATION_DATE          PR_PRODUCT.CREATION_DATE%type,               -- Fecha De CreaciÃ³n
IS_PRIVATE             PR_PRODUCT.IS_PRIVATE%type,                  -- Flag De Privacidad Yes[Y], No[N]
RETIRE_DATE            PR_PRODUCT.RETIRE_DATE%type,                 -- Fecha de Retiro del Producto
COMMERCIAL_PLAN_ID     PR_PRODUCT.COMMERCIAL_PLAN_ID%type,          -- Plan comercial con el cual fue creado el producto
PERSON_ID              PR_PRODUCT.PERSON_ID%type,                   -- VENDEDOR (IDENTIFICADOR PERSONA)
CLASS_PRODUCT          PR_PRODUCT.CLASS_PRODUCT%type,               -- Clase de Producto. C:[Subsidiado] S:[Patrocinador]
ROLE_WARRANTY          PR_PRODUCT.ROLE_WARRANTY%type,               -- Role que juega el producto en una garantÃ­a. R:[Arrendatario] O:[Propietario]
CREDIT_LIMIT           PR_PRODUCT.CREDIT_LIMIT%type,                -- Valor del lÃ­mite de crÃ©dito
EXPIRATION_OF_PLAN     PR_PRODUCT.EXPIRATION_OF_PLAN%type,          -- Fecha de ExpiraciÃ³n del Plan
INCLUDED_ID            PR_PRODUCT.INCLUDED_ID%type,                 -- IDENTIFICADOR DE INCLUIDO
COMPANY_ID             PR_PRODUCT.COMPANY_ID%type,                  -- CÃ¿DIGO DE LA EMPRESA PRESTADORA DEL SERVICIO.
ORGANIZAT_AREA_ID      PR_PRODUCT.ORGANIZAT_AREA_ID%type,           -- CÃ¿DIGO DEL CANAL DE VENTAS.
ADDRESS_ID             PR_PRODUCT.ADDRESS_ID%type,                  -- ID DIRECCION INSTALACION
PERMANENCE             PR_PRODUCT.PERMANENCE%type,                  -- DÃ?AS DE PERMANENCIA MÃ?NIMA
SUBS_PHONE_ID          PR_PRODUCT.SUBS_PHONE_ID%type,               -- TELÃ¿FONO DE CONTACTO.
CATEGORY_ID            PR_PRODUCT.CATEGORY_ID%type,                 -- CategorÃ­a
SUBCATEGORY_ID         PR_PRODUCT.SUBCATEGORY_ID%type,              -- SubcategorÃ­a
SUSPEN_ORD_ACT_ID      PR_PRODUCT.SUSPEN_ORD_ACT_ID%type,           -- Actividad de Orden de SuspensiÃ³n
COLLECT_DISTRIBUTE     PR_PRODUCT.COLLECT_DISTRIBUTE%type,          -- DistribuciÃ³n de Cobro (I - Partes Iguales, C - Por Coeficiente, N -No Distribuye)
PRODUCT_type_DESC      SERVICIO.SERVDESC%type,                      -- Descripcion del servicio
DISTRIBUT_ADMIN_DESC   GE_DISTRIBUT_ADMIN.DESCRIPTION%type,         -- DescripciÃ³n DistribuciÃ³n Administrativa
PRODUCT_STATUS_DESC    PS_PRODUCT_STATUS.DESCRIPTION%type,          -- DescripciÃ³n Estado Del Producto
COMMERCIAL_PLAN_NAME   CC_COMMERCIAL_PLAN.NAME%type,                -- Nombre del plan comercial
COMPANY_DESC           SISTEMA.SISTEMPR%type,                       -- Descripcion del sistema
ORGANIZAT_AREA_DESC    GE_ORGANIZAT_AREA.name_%type,                -- Descripcion del canal de ventas
ADDRESS                AB_ADDRESS.ADDRESS_PARSED%type,              -- DirecciÃ³n InstalaciÃ³n (Parseada)
CATEGORY_DESC          CATEGORI.CATEDESC%type,                      -- Descripcion de la categoria
SUBCATEGORY_DESC       SUBCATEG.SUCADESC%type);                     -- Descripcion de la subcategoria


-- type: tyCustUsersByProd
-- Descripcion:tipo de dato referenciado para obtener de los productos de un servicio suscrito
-- API: OS_GETCUSTUSERSBYPROD
-- Topic ID: apis.aten_cliente.aten_cliente.OS_GetCustUsersByProd
type tyCustUsersByProdRecord is record (
SUBS_type_PROD_ID PR_SUBS_type_PROD.SUBS_type_PROD_ID%type, -- Tipo de producto id
PRODUCT_ID        PR_SUBS_type_PROD.PRODUCT_ID%type,        -- Codigo de producto
SUBSCRIBER_ID     PR_SUBS_type_PROD.SUBSCRIBER_ID%type,     -- Codigo del Cliente
ROLE_ID           PR_SUBS_type_PROD.ROLE_ID%type,           -- Codigo del Rol
LAST_UPDATE       PR_SUBS_type_PROD.LAST_UPDATE%type,       -- Fecha de ultima actualizacion
ROLE_DESC         CC_ROLE.DESCRIPTION%type);                -- Rol

-- type: tyCustomerDataRecord
-- Descripcion: Retorna los datos del cliente
-- API: OS_GETCUSTOMERDATA
-- Topic ID: apis.aten_cliente.aten_cliente.OS_GetCustomerData
type tyCustomerDataRecord  is record (
SUBSCRIBER_ID  	        NUMBER(15),
PARENT_SUBSCRIBER_ID	NUMBER(15),
IDENT_type_ID	        NUMBER(4),
IDENT_type_DESC	        VARCHAR2(100),
SUBSCRIBER_type_ID	    NUMBER(4),
SUBSCRIBER_type_DESC	VARCHAR2(100),
IDENTIFICATION	        VARCHAR2(20),
SUBSCRIBER_NAME	        VARCHAR2(100),
SUBS_LAST_NAME	        VARCHAR2(100),
SUBS_SECOND_LAST_NAME	VARCHAR2(100),
E_MAIL	                VARCHAR2(100),
URL	                    VARCHAR2(500),
PHONE	                VARCHAR2(50),
ACTIVE	                VARCHAR2(1),
ECONOMIC_ACTIVITY_ID	NUMBER(4),
ECONOMIC_ACTIVITY_DESC	VARCHAR2(100),
EXONERATION_DOCUMENT	VARCHAR2(100),
SUBS_STATUS_ID	        NUMBER(4),
SUBS_STATUS_DESC	    VARCHAR2(100),
MARKETING_SEGMENT_ID	NUMBER(4),
MARKETING_SEGMENT_DESC	VARCHAR2(100),
CONTACT_ID	            NUMBER(15),
COUNTRY_ID	            VARCHAR2(3),
COUNTRY_DESC	        VARCHAR2(30),
ADDRESS_ID	            NUMBER(15),
ADDRESS	                VARCHAR2(100),
DATA_SEND	            VARCHAR2(1),
VINCULATE_DATE	        DATE,
ACCEPT_CALL	            VARCHAR2(1),
TAXPAYER_type	        NUMBER(15),
TAXPAYER_type_DESC	    VARCHAR2(50),
AUTHORIZATION_type	    NUMBER(4),
AUTHORIZATION_type_DESC	VARCHAR2(50),
COLLECT_PROGRAM_ID	    NUMBER(2),
COLLECT_PROGRAM_DESC	VARCHAR2(80),
COLLECT_ENTITY_ID	    NUMBER(6),
COLLECT_ENTITY_DESC	    VARCHAR2(100),
CATEGORY_ID	            NUMBER(2),
CATEGORY_DESC	        VARCHAR2(100),
DOC_DATE_OF_ISSUE	    DATE,
DOC_PLACE_OF_ISSUE	    VARCHAR2(200));


-- type: tyContractDataRecord
-- Descripcion: Retorna datos del contrato
-- API: LDCI_PKCRMPORTALWEB.proContultaSuscriptor
-- Topic ID: N/A
type tyContractDataRecord  is record (
CONTRATO                    SUSCRIPC.SUSCCODI%type,  -- codigo del contrato
NRO_SERVICIO                SERVSUSC.SESUNUSE%type,  -- codigo del servicio suscrito
CODIGO_SERVICIO             SERVSUSC.SESUSERV%type,  -- codigo del servicio
SERVICIO_DESC               SERVICIO.SERVDESC%type,  -- descripcion del servicio
CODIGO_CLIENTE              SUSCRIPC.SUSCCLIE%type,  -- codigo del cliente
CLIENTE                     VARCHAR2(300),           -- nombre y apellido
CODIGO_DIRECCION_COBRO      AB_ADDRESS.ADDRESS_ID%type, -- codigo de la direccion de cobro
DIRECCION_COBRO             AB_ADDRESS.ADDRESS%type,    -- direccion de cobro
CODIGO_DEPTO                GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%type,  -- codigo del depto
DEPTO_DIRECCION_COBRO       GE_GEOGRA_LOCATION.DISPLAY_DESCRIPTION%type,  -- descripcion del depto
CODIGO_LOCALIDAD            GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%type,  -- codigo de la localidad
LOCALIDAD_DIRECCION_COBRO   GE_GEOGRA_LOCATION.DISPLAY_DESCRIPTION%type,  -- descripcion de la localidad
CODIGO_CATEGORIA            CATEGORI.CATECODI%type,  -- codigo de la categoria
CATEGORIA                   CATEGORI.CATEDESC%type,  -- descripcion de la categoria
CODIGO_SUBCATEGORIA         SUBCATEG.SUCACODI%type,  -- codigo de la subcategoria
SUBCATEGORIA                SUBCATEG.SUCADESC%type); -- descripcion de la subcategoria

-- type: tyMoviMaterialRecord
-- Descripcion: Retorna los datos del movimiento de material
-- API: LDCI_PKCRMPORTALWEB.proContultaSuscriptor
-- Topic ID: N/A
/*
type tyMoviMaterialRecord  is record (
MMITCODI LDCI_INTEMMIT.MMITCODI%type, -- Movimiento de material
MMITNUDO LDCI_INTEMMIT.MMITNUDO%type, -- Codigo de solicitud reserva
MMITDSAP LDCI_INTEMMIT.MMITDSAP%type, -- Documento de despacho SAP
MMITTIMO LDCI_INTEMMIT.MMITTIMO%type, -- Tipo de movimiento
MMITDESC LDCI_INTEMMIT.MMITDESC%type, -- Decripcion del tipo de movimiento
MMITNATU LDCI_INTEMMIT.MMITNATU%type, -- Naturaleza
MMITCLIE LDCI_INTEMMIT.MMITCLIE%type, -- Codigo del cliente
MMITFESA LDCI_INTEMMIT.MMITFESA%type, -- Fecha de factua
MMITESTA LDCI_INTEMMIT.MMITESTA%type, -- Estado
MMITINTE LDCI_INTEMMIT.MMITINTE%type, -- Numero de intentos
MMITFECR LDCI_INTEMMIT.MMITFECR%type, -- Fecha de creacion
MMITFEVE LDCI_INTEMMIT.MMITFEVE%type, -- Fecha de vencimiento
MMITMENS LDCI_INTEMMIT.MMITMENS%type);-- Mensaje de procesamiento
*/
-- type: tyTecnicoRecord
-- Descripcion: Retorna datos del tecnico
-- API: LDCI_PKCRMPORTALWEB.proConsultaTecnico
-- Topic ID: N/A
type tyTecnicoRecord  is record (
OPER_UNIT_ID     OR_OPERATING_UNIT.OPERATING_UNIT_ID%type,    --ID UNIDAD OPERATIVA
CEDULA           GE_PERSON.NUMBER_ID%type,                    --DOCUMENTO DE IDENTIDAD
NOMBRE           GE_PERSON.NAME_%type,                        --NOMBRE
ID_PERSON        OR_OPERATING_UNIT.PERSON_IN_CHARGE%type,     --ID PERSONA
ID_ESTADO        OR_OPERATING_UNIT.OPER_UNIT_STATUS_ID%type,  --ID ESTADO UNIDAD OPERATIVA
ESTADO           OR_OPER_UNIT_STATUS.DESCRIPTION%type,        --ESTADO DE LA UNIDAD OPERATIVA
ID_CLASIF        OR_OPERATING_UNIT.OPER_UNIT_CLASSIF_ID%type, --ID CALSIFICACION
CLASIFICACION    OR_OPER_UNIT_CLASSIF.DESCRIPTION%type,       --CLASIFICACION UNIDAD OPERATIVA
ID_TIPO_PERSONAL GE_PERSON.PERSONAL_type%type,                --ID TIPO PERSONA
TIPO_PERSONAL    GE_PERSONAL_type.DESCRIPTION%type,           --TIPO PERSONA
TELEFONO         GE_PERSON.PHONE_NUMBER%type,                 --TELEFONO
BEEPER           GE_PERSON.BEEPER%type,                       --BEEPER
EMAIL            GE_PERSON.E_MAIL%type,                       --CORREO ELECTRONICA
ID_DIRECCION     GE_PERSON.ADDRESS_ID%type,                   --ID DIRECCION
DIRECCION        VARCHAR2(200));                               --DIRECCION



-- type: tyTecnicoRecord
-- Descripcion: Retorna datos del tecnico
-- API: LDCI_OSS_PKGEOGRAPLOCAT.proGetDepartamento
--      LDCI_OSS_PKGEOGRAPLOCAT.proGetLocalidad
-- Topic ID: N/A
type tyGeographicData  is record (
PARENT_LOCATION_ID GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%type, -- codigo
PARENT_DESCRIPTION GE_GEOGRA_LOCATION.DESCRIPTION%type,         -- decripcion
CHILD_LOCATION_ID  GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%type, -- codigo
CHILD_DESCRIPTION  GE_GEOGRA_LOCATION.DESCRIPTION%type          -- decripcion
);

-- type: tyContractCEOGASDataRecord
-- Descripcion: Retorna datos del contrato
-- API: LDCI_PKFACTURACION.proConsultaContrato
-- Topic ID: N/A
type tyContractCEOGASDataRecord  is record (
CONTRATO                    SUSCRIPC.SUSCCODI%type,                       -- codigo del contrato
NRO_SERVICIO                SERVSUSC.SESUNUSE%type,                       -- codigo del servicio suscrito
CODIGO_CLIENTE              SUSCRIPC.SUSCCLIE%type,                       -- codigo del cliente
CLIENTE                     VARCHAR2(300),                                 -- nombre y apellido
IDENTIFICACION              GE_SUBSCRIBER.IDENTIFICATION%type,            -- identificacion
CODIGO_DEPTO                GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%type,  -- codigo del depto
CODIGO_LOCALIDAD            GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%type,  -- codigo de la localidad
CICLO_FACTURACION	   			    SUSCRIPC.SUSCCICL%type,                    	  -- codigo del ciclo de facturacion
CODIGO_CATEGORIA            CATEGORI.CATECODI%type,                       -- codigo de la categoria
CODIGO_SUBCATEGORIA         SUBCATEG.SUCACODI%type,																							-- codigo de la subcategoria
ELEMENTO_MEDICION           ELMESESU.EMSSELME%type,
CODIGO_ELEMENTO           ELMESESU.EMSSCOEM%type);                      -- codigo del elemento de medicion


-- type: tyContractCEOGASDataRecord
-- Descripcion: Retorna datos del ciclo
-- API: LDCI_PKFACTURACION.proConsultaCiclo
-- Topic ID: N/A
type tyCycleRecord  is record (
CODIGO_CICLO     CICLO.CICLCODI%type, -- Codigo del ciclo
DEPARTAMENTO     CICLO.CICLDEPA%type, -- Codigo del departamento
LOCALIDAD        CICLO.CICLLOCA%type, -- Codigo de la localidad
CICLO_DESC       CICLO.CICLDESC%type, -- Descripcion del ciclo
EMPRESA          CICLO.CICLSIST%type, -- Codigo de la empresa
CICLO_DE_CONSUMO CICLO.CICLCICO%type);-- Ciclo de consumo


-- type: tyContractCEOGASDataRecord
-- Descripcion: Retorna datos del ciclo
-- API: LDCI_PKFACTURACION.proConsultaCiclo
-- Topic ID: N/A
type tyCustWorkData  is record (
COMPANY          GE_SUBS_WORK_RELAT.COMPANY%type, -- EMPRESA DONDE LABORA
HIRE_DATE        GE_SUBS_WORK_RELAT.HIRE_DATE%type, -- FECHA DE CONTRATACIÓN
PHONE_OFFICE     GE_SUBS_WORK_RELAT.PHONE_OFFICE%type, -- TELEFONO DE LA OFICINA
TITLE            GE_SUBS_WORK_RELAT.TITLE%type, -- CARGO
PHONE_EXTENSION  GE_SUBS_WORK_RELAT.PHONE_EXTENSION%type); -- NÚMERO DE EXTENSIÓN.


-- type: tyContractCEOGASDataRecord
-- Descripcion: Retorna datos del ciclo
-- API: LDCI_PKFACTURACION.proConsultaCiclo
-- Topic ID: N/A
type tyMensProc  is record (
MESAPROC LDCI_MESAPROC.MESAPROC%type,  -- Código del proceso
MESACODI LDCI_MESAPROC.MESACODI%type,  -- Código del mensaje
MESADESC LDCI_MESAPROC.MESADESC%type,  -- Descripción del mensaje
MESATIPO LDCI_MESAPROC.MESATIPO%type); -- tipo de mensaje E error, I Información, W Advertencia, S Satisfactorio

-- type: tyWSTrabAdic
-- Descripcion: Retorna los datos de respuesta del proceso adicional de gestión móvil
-- API:
-- Topic ID: N/A
type tyWSRespTrabAdicRecord  is record (
PARAMETRO LDCI_MESAINFGESNOTMOVIL.PARAMETRO_ID%type,  -- Código del parámetro
VALOR LDCI_MESAINFGESNOTMOVIL.VALOR%type); -- valor del parámetro

TYPE tytabRespuesta IS TABLE OF tyWSRespTrabAdicRecord INDEX BY BINARY_INTEGER;

END LDCI_PKREPODATATYPE;
/


PROMPT Asignación de permisos para el método LDCI_PKREPODATATYPE
begin
  pkg_utilidades.prAplicarPermisos('LDCI_PKREPODATATYPE', 'ADM_PERSON');
end;
/
GRANT EXECUTE on ADM_PERSON.LDCI_PKREPODATATYPE to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKREPODATATYPE to INTEGRADESA;
GRANT EXECUTE on ADM_PERSON.LDCI_PKREPODATATYPE to REXEINNOVA;
/