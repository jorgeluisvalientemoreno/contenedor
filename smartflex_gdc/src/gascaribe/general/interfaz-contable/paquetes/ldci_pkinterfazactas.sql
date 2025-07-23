CREATE OR REPLACE PACKAGE ldci_pkinterfazactas
  /*****************************************************************************
  Propiedad intelectual Gases de Occidente .
  Function:     ldci_pkinterfazactas
  Descripcion:  Paquete encargado de reportar al sistema SAP la informacion de actas por la
                interfaz contable.
  Autor:        Heiber Barco
  Fecha:        02-10-2013

  Historia de modificaciones
  Fecha Autor Modificacion

  28/12/2016  cramirez    CA 200-1012
  Se deja parametrizado el IVA para que pueda ser cambiado cada que se necesite

  cgonzalezv 23-11-2014    Se creo la variable Global gvProvRevCosto que utilizMetodo:
                           fnuGeneDocuSapProv para el Texto Encabezado
                           cque identifique si es Provision o Reversion de Costos
  cgonzalezv 16-12-2014    Se modifica el metodo fnuInterCostoSAP para reportar
                           los trabajos de red de terceros.
                           Se crea variable Global ldci_pkinterfazactas.gvaClasifContRedTerc
  Mmejia      03-07-2015   SAO.329776 Modificacion Funcion  <<fnuGetNitRedTerc>> , Funcion <<fnuInterCostoSAP>>
  18-08-2015  cgonzalezv   SAO.327681
                           Modificacion de los metodos <<fnuGenProvCost>> ,
                           <<fnuRevProvCost>> para que soporte el desglose de documentos
                           cuando superan los 999 registros.

  27-08-2015  cgonzalezv  ARA.4212
                          Parametrizacion Items de anticipo y reportar el numero
                          de anticipo en el campo asignacion.

  16-09-2015  cgonzalezv  SAO.338823
                          Modificacion de la funcion fnuFotoProvCost  para obtener
                          la direccion como subconsulta y no afectar el valor
                          total de los costos.
  22-10-2015   heiberb    SAO. 346712
                          Ajuste de la funcion fnuFotoProvCost para obtener la localidad a partir de la orden
                          en un subquery en la segunda consulta de las ordenes sin acta, haciendo un select from select
                          para mejorar el rendimiento al momento de sacar el departamento y el pais.
  11-11-2015  cgonzalez   SAO. 351118
                          Modificacion de las funciones fnuInterMaterSAP y fnuInterMaterSAPRO
                          elimando de los cursores las tablas or_order_activity orac, ab_address ad. Esto
                          con el fin de solucionar las ordenes sin actividad y ordenes con mas de una actividad.
  19-05-2017              CA-200-774
                          Se corrige el llama de la funcion que genera la trama de las actas
                          con el fin de que se genere un registro ?nico por los campos anteriores.
  31-07-2017  edmlar      CA-2001310
                          Se corrige la funcin FnuFotoProvCost, foto de la provision de costos para que en la consulta de
                          ordenes sin acta valide que la causal de legalizacion sea de Exito.
                          Se corrige la funcion fnuInterCostoSAP para validar el item = 102005 Entrega de anticipo
                          para que envie la clave 29 en vez de la 39.
  26-04-2019  Horbath     CA-200-2602, unificado con el CA-200-2593
                          1.- Eliminar para EFIGAS el envio de la clave 70 en la CLASECTA like '243695%'
                          2.- Dejar como antes del CA-200-1301 donde se hacia el cuadre de la interfaz
                              y al final en la funcion FnuActualizaFact cambiar la clave 50 a 70
                              de la CLASECTA like '243695%' y eliminar los registros donde la
                              CLASECTA LIKE '1422020%', esto con el fin de que la interfaz suba cuadrada.
  09-05-2019  Horbath     CA-200-2529
                          1.- Interfaz de actas, Reportar el IVA mayor valor de los activos a la cuenta 51
                          2.- Interfaz de Materiales, Reportar el IVA mayor valor de los activos a la cuenta 51

  08-11-2021 Horbath      CA-0000731
                          Reversar la provision de costos de GDCA de acuerdo a la ultima interfaz generada
                          en el mes inmediatamente anterior al mes de proceso digitado.
                          
  01-04-2024 GDGuevara    OSF-2174
                          fnuInterCostoSAP: Se modifica el cursor cuActas, se cambia la restriccion de la 
                          consulta de la fecha de IC_DECORECO.dcrcfecr por IC_ENCORECO.ecrcfech para poder
                          usar el indice IX_IC_ENCORECO02 que tiene esta tabla por la fecha.

  22/04/2025  EDMLAR      OSF-4197
                          Se obtiene el CEBE de los registros con items de RETEICA a partir de la tabla LDC_PARAMETROS_ICA,
                          esto con el fin de evitar que se dupliquen los registros con cuenta contable, tipos de indicadores e 
                          indicadores iguales pero con CEBE diferente.
                          Se crea el cursor cuCebeIca

  **************************************************************************************************************/
  IS
   gvProvRevCosto           VARCHAR2(100);-- Texto para Idientificar si es Provision o Reversion del Costo
   vaCODPAGO                VARCHAR2(2000);--codigo para la condicion pago
   vaNit                    VARCHAR2(2000);
   gvacebegral              ldcI_centrobenef.cebecodi%TYPE;
   osbErrorMessage          VARCHAR2(2000);
   vaFactura                ldci_incoliqu.reffactr%TYPE;
   vaActa                   ldci_incoliqu.reffactr%TYPE;
   vaCentBen                ldci_centrobenef.cebecodi%TYPE;
   Error                    EXCEPTION;      --Manejo de exception para el paquete
   EnviaProv                VARCHAR2(2);--variable para la validacion del envio interfaz provision
   vaConIva                 VARCHAR2(2);--variable para la validacion del envio consumo IVA
   vaItemIva                VARCHAR2(20);--variable para identificar el item de iva
   vaIva                    VARCHAR2(20);--variable para identificar el valor de iva
   vaAiu                    VARCHAR2(20);--variable para identificar el valor de aiu
   isContratistaRecaudos    VARCHAR2(15) := NULL; --variable para recaudadores
   vaClasiIvaVenta          VARCHAR2(200); --variable para iva de ventas.
   vaClasiIvaL9             VARCHAR2(200);-- variable para Inversion L9
   vaItemsMaterial          VARCHAR2(20); --variable para los items de tipo material y herramientas
   vaCuentaL9               VARCHAR2(20); --variable para la cuenta 8 de las actas L9
   vaCuentaL9cr             VARCHAR2(20); --variable para la cuenta 8 de las actas L9 credito
   vaClasifContrato         VARCHAR2(2); --variable para conocer el clasificador del contrato
   vaTipoActa               VARCHAR(2); --variable para conocer el tipo de acta
   vaCtaCobFac              VARCHAR2(20); --variable para la cuenta por cobrar factura
   vaEnviaInt               VARCHAR2(2); --variable para el control del envio de la interfaz
   vaTipoRelated            VARCHAR2(2000); --variable para los tipos de ordenes related
   --<<
   -- CA-200-2529
   vaNitivarecupera          VARCHAR2(20); -- Nit LDC IVA recuperable
   vaCtaIvarecupera          VARCHAR2(20); -- Cuenta IVA recuperable
   vaIndicarecupera          VARCHAR2(2);  -- Indicador IVA recuperable
   --
   -->>


   --<<
   -- CA-376
   vaCECOFNB                 VARCHAR2(6); -- Centro de Costo FNB
   vaClasiGeneFra            VARCHAR2(4); -- Clasificador Genera Factura
   vaClasiRptoFra            VARCHAR2(4); -- Clasificador Reparto Factura
   vaPorceGeneFra            VARCHAR2(4); -- Porcentaje Genera Factura
   vaPorceRptoFra            VARCHAR2(4); -- Porcentaje Reparto Factura
   --
   -->>
   
   
   --<<
   -- Dcardona
   -- 09/07/2014
   -- Variables
   -->>1
   vaClasiActivos           VARCHAR2(2000); -- Variable para los clasificadores de activos

   --16/12/2014 cgonzalezv, variable clasificador red de terceros
   gvaClasifContRedTerc     VARCHAR2(2000); -- Indentifica un contrato de red de terceros
   gvacuentacontredterc     VARCHAR2(20);   -- variable para la cuenta de los trabajos de red de terceros

   --Aranda 4212 cgonzalezv
   gvaitemanticipo         VARCHAR2(2000);  -- Variable que contiene todos los Items de Anticipos

  -- Public type declarations


  -- Public constant declarations


  -- Public variable declarations


  -- Public function and procedure declarations

 FUNCTION fnuGetNitRedTerc (inuidcontr IN ge_contrato.id_contrato%TYPE)
          RETURN VARCHAR;

  -- Funcion Genera trama Rev-provision de Costos/Gasto
  FUNCTION fnuRevProvCost(  inuAno      IN NUMBER,
                            inuMes      IN NUMBER
                          )
  RETURN NUMBER;

  -- Funcion Genera trama Rev-provision de Costos/Gasto de GDCA
  FUNCTION fnuRevProvCost_GDCA(  inuAno      IN NUMBER,
                                 inuMes      IN NUMBER
                              )
  RETURN NUMBER;

  -- Funcion Genera trama provision de Costos/Gasto
  FUNCTION fnuGenProvCost(  inuAno      IN NUMBER,
                             inuMes      IN NUMBER
                          )
  RETURN NUMBER;



  -- Funcion provision de Costos/Gasto
  FUNCTION fnuFotoProvCost(  idafechaini      IN DATE DEFAULT NULL,
                             idafechafin      IN DATE DEFAULT NULL,
                             idafechaAct      IN DATE DEFAULT NULL
                           )
  RETURN NUMBER;


    FUNCTION fnuInterActaCostoSAP(inuactanume      IN ge_acta.id_acta%TYPE,
                                  ivaiclitido      IN ldci_incoliqu.iclitido%TYPE,
                                  idafechaini      IN DATE,
                                  idafechafin      IN DATE
                                 )
    RETURN NUMBER;

  FUNCTION fnuInterCostoSAP(inuactanume      IN ge_acta.id_acta%TYPE,
                            ivaiclitido      IN ldci_incoliqu.iclitido%TYPE,
                            idafechaini      IN DATE,
                            idafechafin      IN DATE)
  RETURN NUMBER;
  --<<
  --Funcion que obtiene el indicador de retencion
  -->>
   FUNCTION fvaGetIndicadore (inuitemcodi   in LDCI_INTEMINDICA.itemcodi%TYPE,
                              inuitemclco   IN LDCI_INTEMINDICA.itemclco%TYPE,
                              ovaCTCATIRE  OUT LDCI_INTEMINDICA.itemtire%TYPE,
                              ovaCTCAINRE  OUT LDCI_INTEMINDICA.iteminre%TYPE,
                              ovaITEMCATE  OUT LDCI_INTEMINDICA.itemcate%TYPE)
    return VARCHAR;

  --<<
  --Funcion que obtiene el indicador y cuenta IVA
  -->>
   FUNCTION fvaGetIndiva (inuitemcodi   in LDCI_INTEMINDICA.itemcodi%TYPE,
                              ovaCTCAINIV  OUT ldci_itemconta.itemindi%TYPE,
                              ovaITEMCIVA  OUT ldci_itemconta.itemciva%TYPE)
    return VARCHAR;

    --<<
    -- Dcardona:
    -- 29/07/2014
    -- Funcion que obtiene el indicador y cuenta IVA del clasificador
    -->>
    FUNCTION fvaGetIndivaTT(inuTipoTrab  IN  ldci_titrindiva.ttivtitr%TYPE,
                            ivaTipoCuen  IN  VARCHAR2,
                            ovaCtcainiv  OUT ldci_itemconta.itemindi%TYPE,
                            ovaItemciva  OUT ldci_itemconta.itemciva%TYPE)
    RETURN VARCHAR2;

    FUNCTION fvaGetOICos (inudeparta  in ldci_cencoubgtra.ccbgdpto%TYPE,
                          inulocalid  IN ldci_cencoubgtra.ccbgloca%TYPE,
                          inutipotra  IN ldci_cencoubgtra.ccbgtitr%TYPE,
                          inuitem     IN ldci_cencoubgtra.ccbgitem%TYPE,
                          ovacecost   OUT ldci_cencoubgtra.ccbgceco%TYPE,
                          ovaordein   OUT ldci_cencoubgtra.ccbgorin%TYPE)
    return NUMBER;

    FUNCTION fvaGetCuenTipoContrato (inuidtipocontr IN ldci_ctatipcontr.idtipocontr%TYPE)
    RETURN VARCHAR;

    FUNCTION fnuGetTipoContrato (inuidcontr IN ge_contrato.id_contrato%TYPE)
    return NUMBER;

    FUNCTION fnuInsHistAct(inucodacta      IN ldci_actacont.idacta%TYPE,
                          inucodocont    IN ldci_actacont.codocont%TYPE,
                          ivatipdocont    IN ldci_actacont.tipdocont%TYPE,
                          ivausuario       IN ldci_actacont.usuario%TYPE,
                          idtfechcontabil  IN ldci_actacont.fechcontabiliza%TYPE)
    RETURN NUMBER;

    FUNCTION fvaGetAnticipo (inuidcontrato IN ldci_contranticipo.idcontrato%TYPE)
    return VARCHAR;

    FUNCTION fvaGetCuenClasi (inutipotrab IN NUMBER)
    RETURN VARCHAR;

    --<<
    -- Dcardona:
    -- 08/07/2014
    -- Se agrega la funcion encargada de obtener la cuenta costo o gasto del clasificador
    -->>
    FUNCTION fvaGetCuGaCoClasi (nuOrden  or_order.order_id%TYPE)
    RETURN VARCHAR2;

    --<<
    -- Dcardona:
    -- 08/07/2014
    -- Se agrega la funcion encargada de definir si es costo o gasto dependiendo del
    -- cobro de la orden (charge_status)
    -->>
    FUNCTION fvaGetTitrCoGa(nuOrden     or_order.order_id%TYPE)
    RETURN VARCHAR2;

    FUNCTION fvaGetClasifi (inutipotrab IN NUMBER)
    RETURN NUMBER;

  FUNCTION fvaGetCuenClasiMat (inutipotrab IN NUMBER)
    RETURN VARCHAR;

  FUNCTION fvaGetClasifimat (inutipotrab IN NUMBER)
    RETURN NUMBER;

  FUNCTION fnuInterMaterSAP(inuano   IN NUMBER,
                            inumes   IN NUMBER)
  RETURN NUMBER;

  --<<
  -- Dcardona
  -- 31/07/2014
  -->>
  FUNCTION fnuInterMaterSAPRO(inuano IN NUMBER,
                              inumes IN NUMBER)
  RETURN NUMBER;

  FUNCTION fnuInterProviActas(inuano   IN NUMBER,
                            inumes   IN NUMBER)
  RETURN NUMBER;

  FUNCTION fnuInteRevProviActas(inuano   IN NUMBER,
                            inumes   IN NUMBER)
  RETURN NUMBER;

  PROCEDURE validaLDCINTACTAS;
  PROCEDURE validaLDCIENVINT;
  PROCEDURE validaLDCIGINTMES;
  PROCEDURE validaLDCIREPL;

  --<<
  -- Dcardona
  -- 31/07/2014
  -->>
  PROCEDURE validaldcireplRO;

  FUNCTION fvaGetClaveConta (nucuctcodi   in LDCI_CUENTACONTABLE.cuctcodi%TYPE,
                             vaSigno      IN IC_DECORECO.dcrcsign%TYPE)
  return VARCHAR;

  FUNCTION fnuGetIva (inutipotrab IN NUMBER,
                     inuorden IN NUMBER,
                     inucontratista IN NUMBER,
                     inuacta IN NUMBER,
                     inuitem IN NUMBER)
  return NUMBER;
  FUNCTION fnuGetTipoTrab (inuorden IN NUMBER)
  return NUMBER;

  FUNCTION fnuActualizaFact (nuICLINUDO   in LDCI_INCOLIQU.ICLINUDO%type)
  return NUMBER;

  --<<
  --Funcion que obtiene el libro para resolver el IFRS
  -->>
  FUNCTION fvaGetLibro (ivaTipInterfaz IN ldci_tipointerfaz.tipointerfaz%TYPE)
  RETURN VARCHAR;


 vaDiverge                varchar2(1);
 END ldci_pkinterfazactas;
/
CREATE OR REPLACE PACKAGE BODY ldci_pkinterfazactas
  /*****************************************************************************
  Propiedad intelectual Gases de Occidente .
  Function:     ldci_pkinterfazactas
  Descripcion:  Paquete encargado de reportar al sistema SAP la informacion de actas por la
                interfaz contable.
  Autor:        Heiber Barco
  Fecha:        02-10-2013

  Historia de modificaciones
  Fecha       Autor       Modificacion

  28/12/2016  cramirez    CA 200-1012
  Se deja parametrizado el IVA para que pueda ser cambiado cada que se necesite

  22-11-2014  cgonzalezv  Se creo el metodo fnuRevProvCost para reportar
                          la Reversion de la Provision de Costos de los
                          Servicios Asociados.
  03-07-2015  Mmejia      SAO.329776 Modificacion Funcion  <<fnuGetNitRedTerc>> , Funcion <<fnuInterCostoSAP>>
  18-08-2015  cgonzalezv  SAO.327681
                          Modificacion de los metodos <<fnuGenProvCost>> ,
                          <<fnuRevProvCost>> para que soporte el desglose de documentos
                          cuando superan los 999 registros.
  27-08-2015  cgonzalezv  ARA.4212
                          Parametrizacion Items de anticipo y reportar el numero
                          de anticipo en el campo asignacion.
  16-09-2015  cgonzalezv  SAO.338823
                          Modificacion de la funcion fnuFotoProvCost  para obtener
                          la direccion como subconsulta y no afectar el valor
                          total de los costos.
  22-10-2015   heiberb    SAO. 346712
                          Ajuste de la funcion fnuFotoProvCost para obtener la localidad a partir de la orden
                          en un subquery en la segunda consulta de las ordenes sin acta, haciendo un select from select
                          para mejorar el rendimiento al momento de sacar el departamento y el pais.

  11-11-2015  cgonzalez   SAO. 351118
                          Modificacion de las funciones fnuInterMaterSAP y fnuInterMaterSAPRO
                          elimando de los cursores las tablas or_order_activity orac, ab_address ad. Esto
                          con el fin de solucionar las ordenes sin actividad y ordenes con mas de una actividad.

  19-07-2016   edmlar     CA- 100-10632 Se modifica el cursor cuActOTProv, se incluye la nueva consulta para hallar
                          la provision de costos
  09-09-2016   edmlar     CA-200-782 Se pasa como parametro la fecha de cierre de las actas.

  15-11-2016   FCastro    200-86. Se envia correo notificando que se envio la interfaz o si hubo errores en el proceso.

  19-05-2017              CA-200-774
                          Se corrige el llama de la funcion que genera la trama de las actas
                          con el fin de que se genere un registro ?nico por los campos anteriores.
  31-07-2017  edmlar      CA-2001310
                          Se corrige la funcin FnuFotoProvCost, foto de la provision de costos para que en la consulta de
                          ordenes sin acta valide que la causal de legalizacion sea de Exito.
                          Se corrige la funcion fnuInterCostoSAP para validar el item = 102005 Entrega de anticipo
                          para que envie la clave 29 en vez de la 39.
   20-10-2017 Ludycom     CA-200-1300 y CA-200-1301
                          Se corrige la generacion de trama de actas de comision para que a las cuentas de retencion
                          le envie la base, tipo de indicador e indicador de retencion.
   01-06-2018 edmlar      CA-200-1300 Se cambia la clave de las cuentas que cumplan la condicion VaCuenta like '243695%'
                          a 70, lo anterio de acuerdo a lo manifestado por el proveedor de SAP.
                          Se corrige la configuracion para que las cuentas 1422020300 y 1422020400 en % de liquidacion
                          se les coloca 0.00 %. estas cuentas por recoendacion del proveedor no deben enviarse en la
                          trama.
    25/10/2018 Horbart    CA-200-2239 Se habilita el ajute de la interfaz LB y se elimina al final las cuentas 1422020%

    26-04-2019 Horbath    CA-200-2602, unificado con el CA-200-2593
                          1.- Eliminar para EFIGAS el envio de la clave 70 en la CLASECTA like '243695%'
                          2.- Dejar como antes del CA-200-1301 donde se hacia el cuadre de la interfaz
                              y al final en la funcion FnuActualizaFact cambiar la clave 50 a 70
                              de la CLASECTA like '243695%' y eliminar los registros donde la
                              CLASECTA LIKE '1422020%', esto con el fin de que la interfaz suba cuadrada.

    09-05-2019  Horbath   CA-200-2529
                          1.- Interfaz de actas, Reportar el IVA mayor valor de los activos a la cuenta 51
                          2.- Interfaz de Materiales, Reportar el IVA mayor valor de los activos a la cuenta 51

    25/05/2019 EDMLAR     CA-200-2652
                          Se modifica la clave de la cuenta de IVA para las actas LB, debe ser la misma que la del ingreso
                          porque es un mayor valor a la cuenta por cobrar.
    22-05-2019 horbath    CA-200-2592
                          Se actualiza la consulta de la provision de costos de acuerdo a las ultimas modificaciones
                          realizadas y se optimiza la consulta.

    25/02/2021 Horbath    CA-591 se crea parametro para controlar la contabilizacion de actas de comision y Se crea cursor
                          para averiguar  el tipo de acta a contabilizar, si el acta es de comision y el parametro esta en N
                          no debe permiter contabilizar, esto porque se esta haciendo automaticamente con la facturacion 
                          electronica.
                          
    21/06/2021 Horbath    CA-376 Distribucion del costo de generacion de factura y reparto de factura, entre GAS y FNB.
                          Porcentaje Generacion FNB 10%
                          Porcentaje Reparto FNB 14%
                          Se modifica la funcion fnuInterCOstoSAP para tal fin.
                          
    08-11-2021 Horbath    CA-0000731
                          Reversar la provision de costos de GDCA de acuerdo a la ultima interfaz generada
                          en el mes inmediatamente anterior al mes de proceso digitado.                          
                          
  *************************************************************************************************************/
    IS
        type tyLDCI_INCOLIQU IS TABLE OF LDCI_INCOLIQU%ROWTYPE INDEX BY BINARY_INTEGER;
        vtyLDCI_INCOLIQU tyLDCI_INCOLIQU;

        nuIVA   ld_parameter.numeric_value%type := dald_parameter.fnuGetnumeric_value('COD_VALOR_IVA');

  FUNCTION fnuGetNitRedTerc (inuidcontr IN ge_contrato.id_contrato%TYPE)
  /************************************************************************
     PROPIEDAD INTELECTUAL PROYECTO PETI
     FUNCION   : fnuGetNitRedTerc
     AUTOR     : Carlos Humberto Gonzalez
     FECHA     : 16-12-2014
     DESCRIPCION  : Tiquete:
                    funcion que se encarga de obtener el NIT del Contrato
                    de Red de Tercero

    Parametros de Entrada

    Parametros de Salida

    Historia de Modificaciones
    Autor    Fecha       Descripcion
    Mmejia   02-07-2015  SAO.329776 Se modifica la consulta para que obtenga el
                         nit por medio del codigo del contrato correctamente.
  ************************************************************************/
  return VARCHAR
  is
     cursor cuNitRedTerc
     is
     select nitenit
       from ldci_nitredtercero
      where nitecont  = inuidcontr;

      vaNitRedTerc ldci_nitredtercero.nitenit%TYPE;
  begin

     open cuNitRedTerc;
     fetch cuNitRedTerc into vaNitRedTerc;
     close cuNitRedTerc;


     return(vaNitRedTerc);

  exception
  when others then
       ldci_pkInterfazSAP.vaMensError :=  '[fnuGetNitRedTerc] - No se pudo obtener el nit del contrato red de tercero: '||inuidcontr||' '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
       LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,USER,USERENV('TERMINAL'));
       return(-1);
  end fnuGetNitRedTerc;


 ------------------------------------------------------------------------
  -- Funcion Genera trama provision de Costos/Gasto
  FUNCTION fnuRevProvCost(  inuAno      IN NUMBER,
                            inuMes      IN NUMBER
                          )
  RETURN NUMBER IS
  /*****************************************************************************
  Propiedad intelectual PETI - OSF
  Function:     fnuGenProvCost
  Descripcion:  Funcion para reportar  la Reversion de la Provision de
                los Costos/Gastos al sistema SAP.

  Parametros de Entrada:
                inuAno      :Anio de la provision
                inuMes      :Mes de la provision


  Parametros de Salida:
                Ninguno
  Retornos:
                0  No hubo error al ejecutar la funcion.
                -1 Hubo error al ejecutar al funcion.
  Autor:        Carlos Humberto Ginzalez - ARQS
  Fecha:        22-11-2014

  Historia de modificaciones
  Fecha       Autor      Modificacion
  19-08-2015  cgonzalez  Se modifica el metodo para soporte el desglose de documentos
                         cuando superan los 999 registros.
  24-08-2015  cgonzalez  SAO.329776 Modificacion para soportar mas de 999 Registros
                         contables soportados por el sistema contable SAP
  ******************************************************************************/

  -- Variables
  nuRet       NUMBER;      -- Retorno de las funcionnes
  vaNitGene   ldci_banconit.bannnnit%TYPE;       -- NIT
  vaDescNit   ldci_banconit.bannnomb%TYPE;       -- Descripcion del NIT
  vaCuenta    ldci_cuentacontable.cuctcodi%TYPE; -- Obtiene la cuenta del parametro
  vaCtaProv   ldci_cuentacontable.cuctcodi%TYPE; -- Cuenta de Provision
  vaCECO      ldci_centrocosto.cecocodi%TYPE;    -- Centro de Costo
  vaOIEst     ldci_ordeninterna.codi_ordeinterna%TYPE; -- Orden estadistica
  nuCount1    NUMBER := 0;                             -- Contador para validar interfaz enviada
  nuErrorCta  NUMBER := 0;                             -- Error con el calculo de cuentas
  vaEnviaInterfazPA    VARCHAR2(1);                    --Parametro para el control de envio de Interfaces a SAP

  ---------<<
  -- Cursores
  --------->>
  -- Provision: Debitos costos/gastos
  CURSOR cuDataProv
      IS
   SELECT
        coprtitr                                                  TIPOTRAB,
        -----
        'D'                                                       SIGNO,
        SYSDATE                                                   ICLIFECH,
        SYSDATE                                                   ICLIFECR,
        USER                                                      ICLIUSUA,
        SUBSTR(USERENV('TERMINAL'),1,10)                          ICLITERM,
        ldci_pkinterfazactas.fvaGetClaveConta(coprctac,Decode(coprsign,'D','C','D')) CLAVCONT,
        coprctac                                                  CLASECTA,
        null                                                      INDICCME,
        Sum(coprvalo)                                             IMPOMTRX,
        Sum(coprvalo)                                             IMPOMSOC,
        null                                                      INDICIVA,
        null                                                      CONDPAGO,
        sysdate                                                   FECHBASE,
        null                                                      REFFACTR,
        null                                                      BASEIMPT,
        ldci_pkinterfazsap.fvaGetCECO(coprdepa,coprloca,coprtitr) CENTROCO,
        ldci_pkinterfazsap.fvaGetOIEST(coprdepa,coprloca,coprtitr)ORDENINT,
        NULL                                                      CANTIDAD,
        NULL                                                      ASIGNACN,
        NULL                                                      TXTPOSCN,
        ldci_pkinterfazsap.fvaGetCebeNoCat(coprloca)              CENTROBE,
        ldci_pkinterfazsap.fvaGetSegmento(ldci_pkinterfazsap.fvaGetCebeNoCat(coprloca))SEGMENTO,
        NULL                                                      OBJCOSTO,
        NULL                                                      CLAVREF1,
        NULL                                                      CLAVREF2,
        NULL                                                      CLAVREF3,
        NULL                                                      SOCIEDGL,
        NULL                                                      MATERIAL,
        NULL                                                      TIPORETC,
        NULL                                                      INDRETEC,
        NULL                                                      BASERETC,
        NULL                                                      FECHVALOR,
        NULL                                                      CTADIV,
        -1                                                        COD_CLASIFCONTA,
        '-1'                                                      DCRCINAD,
        -1                                                        COMPROBANTE,
        -1                                                        NUSEINSE

   FROM ldci_costprov
  WHERE copranoc = inuAno
    AND coprmesc = inuMes
    AND nvl(coprclco,-1) NOT IN (SELECT clcocodi
                                   FROM ic_clascont
                                  WHERE ',' || (SELECT casevalo
                                                  FROM ldci_carasewe
                                                 WHERE casecodi = 'CLASCONT_FNB') || ',' LIKE '%,' || clcocodi || ',%')
  GROUP BY coprctac,coprsign,
           coprdepa,coprloca,
           coprtitr
  UNION ALL
     -- Cuenta de Provision
     SELECT
        coprtitr                                                  TIPOTRAB,
        -----
        'C'                                                       SIGNO,
        SYSDATE                                                   ICLIFECH,
        SYSDATE                                                   ICLIFECR,
        USER                                                      ICLIUSUA,
        SUBSTR(USERENV('TERMINAL'),1,10)                          ICLITERM,
        ldci_pkinterfazactas.fvaGetClaveConta((SELECT casevalo FROM ldci_carasewe
         WHERE casecodi = 'CTA_PROVISION_COSTO'),decode(coprsign,'D', 'D', 'C') ) CLAVCONT,
        (SELECT casevalo FROM ldci_carasewe
         WHERE casecodi = 'CTA_PROVISION_COSTO')                  CLASECTA,
        null                                                      INDICCME,
        Sum(coprvalo)                                             IMPOMTRX,
        Sum(coprvalo)                                             IMPOMSOC,
        null                                                      INDICIVA,
        null                                                      CONDPAGO,
        sysdate                                                   FECHBASE,
        null                                                      REFFACTR,
        null                                                      BASEIMPT,
        ldci_pkinterfazsap.fvaGetCECO(coprdepa,coprloca,coprtitr) CENTROCO,
        ldci_pkinterfazsap.fvaGetOIEST(coprdepa,coprloca,coprtitr)ORDENINT,
        NULL                                                      CANTIDAD,
        NULL                                                      ASIGNACN,
        NULL                                                      TXTPOSCN,
        ldci_pkinterfazsap.fvaGetCebeNoCat(coprloca)              CENTROBE,
        ldci_pkinterfazsap.fvaGetSegmento(ldci_pkinterfazsap.fvaGetCebeNoCat(coprloca))SEGMENTO,
        NULL                                                      OBJCOSTO,
        NULL                                                      CLAVREF1,
        NULL                                                      CLAVREF2,
        NULL                                                      CLAVREF3,
        NULL                                                      SOCIEDGL,
        NULL                                                      MATERIAL,
        NULL                                                      TIPORETC,
        NULL                                                      INDRETEC,
        NULL                                                      BASERETC,
        NULL                                                      FECHVALOR,
        NULL                                                      CTADIV,
        -1                                                        COD_CLASIFCONTA,
        '-1'                                                      DCRCINAD,
        -1                                                        COMPROBANTE,
        -1                                                        NUSEINSE

   FROM ldci_costprov
  WHERE copranoc = inuAno
    AND coprmesc = inuMes
    AND nvl(coprclco,-1) NOT IN (SELECT clcocodi
                                   FROM ic_clascont
                                  WHERE ',' || (SELECT casevalo
                                                  FROM ldci_carasewe
                                                 WHERE casecodi = 'CLASCONT_FNB') || ',' LIKE '%,' || clcocodi || ',%')
  GROUP BY coprctac,coprsign,
           coprdepa,coprloca,
           coprtitr;

   CURSOR cuValidacion(ivatipo VARCHAR2, nuano NUMBER, numes NUMBER)
   IS
   SELECT Count(*)
     FROM ldci_registrainterfaz
    WHERE ldtipointerfaz = ivatipo
      AND ldanocontabi = nuano
      AND ldmescontab = numes
      AND ldflagcontabi = 'S';


   ----------------------------<<
   -- Variables tipos registros
   ---------------------------->>
   TYPE tyInfoDeta IS TABLE OF cuDataProv%ROWTYPE INDEX BY BINARY_INTEGER;
        vtyInfoDeta tyInfoDeta;

   BEGIN

    --<< Parametros Generales
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'NIT_GENE_PROV_COSTO', vaNitGene, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'SOCIEDAD', ldci_pkinterfazsap.vaSOCIEDAD, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CURRENCY', ldci_pkinterfazsap.vaCURRENCY, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CEBE_GENERAL', ldci_pkinterfazactas.gvacebegral, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CONDIPAGO', ldci_pkinterfazsap.vaCODPAGO, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CTA_PROVISION_COSTO', vaCuenta, osbErrorMessage);
    ldci_pkwebservutils.proCaraServWeb('WS_INTER_CONTABLE', 'ENVIAINTERFAZPA', vaEnviaInterfazPA, osbErrorMessage);

    -- Tipo de Documento LF
    ldci_pkInterfazSAP.vaCODINTINTERFAZ := 'LF';
    ldci_pkinterfazactas.gvProvRevCosto := 'REV-PROVISIONCOST';
    LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkInterfazSAP.vaCODINTINTERFAZ,'Inicia el Procesamiento de la Interfaz de Reversion Provision de Costos',to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));

    --<<
    -- Cantidad de registros
    -->>
    OPEN cuValidacion(ldci_pkInterfazSAP.vaCODINTINTERFAZ, inuano, inumes);
    FETCH cuValidacion INTO nuCount1;
    CLOSE cuValidacion;

    IF nuCount1 > 0 THEN

      LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkInterfazSAP.vaCODINTINTERFAZ,'Interfaz ya Contabilizada en este periodo '||inuano||' - '||inumes,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));

    ELSE

      ldci_pkinterfazsap.vaGRLEDGER := LDCI_PKINTERFAZACTAS.fvaGetLibro(ldci_pkInterfazSAP.vaCODINTINTERFAZ);

      -- Obtiene la descripcion del NIT
      vaDescNit := ldci_pkinterfazsap.fvaGetDescripNit(vaNitGene);


      OPEN cuDataProv;
      FETCH cuDataProv BULK COLLECT INTO vtyInfoDeta;
      CLOSE cuDataProv;


      IF (vtyInfoDeta.count > 0) THEN

          --<<
          -- Obtencion del  numero de documento
          -->>
          ldci_pkInterfazSAP.nuSeqICLINUDO := ldci_pkInterfazSAP.fnuSeq_ldci_incoliqu;

          FOR i IN vtyInfoDeta.First..vtyInfoDeta.Last LOOP

              --<<
              -- Cuenta de Provision para el Credito
              -->>
              vaCECO    := NULL;
              vaOIEst   := NULL;

              IF vtyInfoDeta(i).SIGNO = 'D' THEN

                vaCECO    := vtyInfoDeta(i).CENTROCO;
                vaOIEst   := vtyInfoDeta(i).ORDENINT;

              END IF;

              --<<
              -- Se valida la cuenta
              -->>
              IF (vtyInfoDeta(i).CLASECTA IS NULL) THEN
                 LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkInterfazSAP.vaCODINTINTERFAZ,'La cuenta esta vacia para el trabajo: '||vtyInfoDeta(i).TIPOTRAB,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
                 nuErrorCta := 1;
              END IF;

              nuRet := ldci_pkinterfazsap.fnuLDCI_INCOLIQUPROV(vaICLITIDO  =>  ldci_pkInterfazSAP.vaCODINTINTERFAZ,
                                                               nuICLINUDO  =>  ldci_pkInterfazSAP.nuSeqICLINUDO,
                                                               dtICLIFECH  =>  vtyInfoDeta(i).ICLIFECH,
                                                               vaICLIUSUA  =>  vtyInfoDeta(i).ICLIUSUA,
                                                               vaICLITERM  =>  vtyInfoDeta(i).ICLITERM,
                                                               dtICLIFECR  =>  vtyInfoDeta(i).ICLIFECR,
                                                               vaCLAVCONT  =>  vtyInfoDeta(i).CLAVCONT,
                                                               vaCLASECTA  =>  vtyInfoDeta(i).CLASECTA,
                                                               vaINDICCME  =>  vtyInfoDeta(i).INDICCME,
                                                               nuIMPOMTRX  =>  vtyInfoDeta(i).IMPOMTRX,
                                                               nuIMPOMSOC  =>  vtyInfoDeta(i).IMPOMSOC,
                                                               vaINDICIVA  =>  vtyInfoDeta(i).INDICIVA,
                                                               vaCONDPAGO  =>  vtyInfoDeta(i).CONDPAGO,
                                                               dtFECHBASE  =>  vtyInfoDeta(i).FECHBASE,
                                                               vaREFFACTR  =>  vtyInfoDeta(i).REFFACTR,
                                                               nuBASEIMPT  =>  vtyInfoDeta(i).BASEIMPT,
                                                               vaORDENINT  =>  vaOIEst,
                                                               nuCANTIDAD  =>  vtyInfoDeta(i).CANTIDAD,
                                                               vaASIGNACN  =>  vaNitGene,
                                                               vaTXTPOSCN  =>  vtyInfoDeta(i).TXTPOSCN,
                                                               vaCENTROBE  =>  vtyInfoDeta(i).CENTROBE,
                                                               vaSEGMENTO  =>  vtyInfoDeta(i).SEGMENTO,
                                                               vaOBJCOSTO  =>  vtyInfoDeta(i).OBJCOSTO,
                                                               vaCLAVREF1  =>  vaNitGene,
                                                               vaCLAVREF2  =>  vtyInfoDeta(i).CLAVREF2,
                                                               vaCLAVREF3  =>  vaDescNit,
                                                               vaSOCIEDGL  =>  vtyInfoDeta(i).SOCIEDGL,
                                                               vaMATERIAL  =>  vtyInfoDeta(i).MATERIAL,
                                                               vaTIPORETC  =>  vtyInfoDeta(i).TIPORETC,
                                                               vaINDRETEC  =>  vtyInfoDeta(i).INDRETEC,
                                                               vaBASERETC  =>  vtyInfoDeta(i).BASERETC,
                                                               nuNUSEINSE  =>  vtyInfoDeta(i).NUSEINSE,
                                                               vaCOD_CENTROBENEF   => vtyInfoDeta(i).CENTROBE,
                                                               nuCOD_CLASIFCONTA   => vtyInfoDeta(i).COD_CLASIFCONTA,
                                                               dtFECHVALOR         => vtyInfoDeta(i).FECHVALOR,
                                                               vaCTADIV            => vtyInfoDeta(i).CTADIV,
                                                               vaCENTROCO          => vaCECO,
                                                               nuCOMPROBANTE       => vtyInfoDeta(i).COMPROBANTE,
                                                               vaLEDGERS           => ldci_pkinterfazsap.vaGRLEDGER,
                                                               vatipotrab          => vtyInfoDeta(i).tipotrab);

              END LOOP;

              nuRet := ldci_pkInterfazSAP.fnuINSELDCI_INCOLIQU;
              --<<
              --Genera la informacion de los documentos para SAP de la interfaz de INGRESOS
              -->>
              --<<
              --Se lanza la Exepcion
              -->>
              IF (nuRet <> 0) THEN
                 RAISE ERROR;
              END IF;

              IF (nuErrorCta <> 0) THEN
                LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkInterfazSAP.vaCODINTINTERFAZ,'No se envia la interfaz debido a cuentas nulas',to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
                RETURN(-1);
              END IF;

              nuRet := ldci_pkInterfazSAP.fnuGeneDocuSapProv(ldci_pkInterfazSAP.nuSeqICLINUDO);

              --<<
              --Se lanza la Exepcion
              -->>
            IF (nuRet <> 0) THEN
                LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkInterfazSAP.vaCODINTINTERFAZ||'C',ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
                RAISE ERROR;
            END IF;

        ELSE -- no hay datos a procesar

             LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkInterfazSAP.vaCODINTINTERFAZ,'No hay Datos a Procesar para el Periodo '||inuano||' - '||inumes,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));

        END IF;

        nuRet := ldci_pkinterfazsap.fnuAjusteInterCont(ldci_pkInterfazSAP.nuSeqICLINUDO);

        --<<
        -- Valida si la trama Generada por Documento e Identificador NO supere los 999 Registros.
        -->>
        nuRet := ldci_pkinterfazsap.fnusplitdocclas(nucodtrama => ldci_pkinterfazsap.nuSeqICLINUDO);

        IF (nuRet <> 0) THEN
          Dbms_Output.Put_Line('04');
          LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkInterfazSAP.vaCODINTINTERFAZ,'Error al Dividir la Trama '||ldci_pkInterfazSAP.nuSeqICLINUDO||' de Provision de Costos. Validar Posible Datos Sin CEBE ',to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
          RAISE Error;
        END IF;

        --<<
        -- Confirmacion creacion de la trama
        -->>
        COMMIT;

        --<<
        --Si es satifactorio todo el proceso, se realiza el envio a SAP
        -->>
        IF (vaEnviaInterfazPA = 'S') THEN
           ldci_pkintercontablemesa.proEnviaDocContable(ldci_pkInterfazSAP.nuSeqICLINUDO);
        END IF;

        nuRet := ldci_pkinterfazsap.fnuRegistraInterfazAnioMes(ldci_pkinterfazsap.nuSeqICLINUDO,inuano,inumes,'S',ldci_pkInterfazSAP.vaCODINTINTERFAZ);
        -- Validacion si se inserto historia contable
        IF (nuRet <> 0) THEN
           LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkInterfazSAP.vaCODINTINTERFAZ,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
           RAISE Error;
        END IF;

     END IF;

   LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkInterfazSAP.vaCODINTINTERFAZ,'Finaliza existosamente el procesamiento de la Interfaz de Reversion Provision de Costos trama: '||ldci_pkInterfazSAP.nuSeqICLINUDO,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));

   RETURN 0;

  EXCEPTION
  WHEN OTHERS THEN
       ldci_pkInterfazSAP.vaMensError :=  '[fnuRevProvCost] - No se genero la trama SAP, Reversion Provision de Costos. '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
       LDCI_pkTrazaInterfaces.pRegiMensaje('LF',ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),SYSDATE,USER,USERENV('TERMINAL'));
       RETURN(-1);
  END fnuRevProvCost;


------------------------------------------------------------------------
  -- Funcion Genera trama provision de Costos/Gasto
  FUNCTION fnuRevProvCost_GDCA(  inuAno      IN NUMBER,
                                 inuMes      IN NUMBER
                              )
  RETURN NUMBER IS
  /*****************************************************************************
  Propiedad intelectual PETI - OSF
  Function:     fnuRevProvCost_GDCA
  Descripcion:  Funcion para reportar  la Reversion de la Provision de
                los Costos/Gastos al sistema SAP.

  Parametros de Entrada:
                inuAno      :Anio de la provision a reversar
                inuMes      :Mes de la provision a reversar


  Parametros de Salida:
                Ninguno
  Retornos:
                0  No hubo error al ejecutar la funcion.
                -1 Hubo error al ejecutar al funcion.

  Autor:        HORBTAH TECHNOLOGIES
  Fecha:        08-11-2021

  Historia de modificaciones
  Fecha       Autor      Modificacion

  ******************************************************************************/
  
  Cursor Cu_Ldci_detaintesap(Nudcto number, Nuseq number) Is
    select *
      from open.ldci_detaintesap d
     where d.cod_interfazldc = Nudcto
       and d.num_documentosap = Nuseq;
     
  Cursor Cu_Ldci_encaintesap(Nudcto number) Is
    select *
      from open.ldci_encaintesap d
     where d.cod_interfazldc = Nudcto;     
     
  Cursor Cu_Ldci_registrainterfaz(NuAno number, Numes number) Is
    select r.ldcodinterf
      from open.ldci_registrainterfaz r
     where r.ldanocontabi = NuAno
       and r.ldmescontab  = Numes
       and r.ldtipointerfaz = 'LF' -- Interfaz de provision de Costos
       and r.ldflagcontabi = 'S';  -- Contabilizada
       
  Cursor CU_Ldci_ctacadmi(SbCta ldci_detaintesap.clasecta%type) is
    select * from open.ldci_ctacadmi l
     where l.ctaclco = -1
       and l.ctcacodi = SbCta
       and rownum = 1;
       
   CURSOR cuValidacion(ivatipo VARCHAR2, nuano NUMBER, numes NUMBER)
   IS
   SELECT Count(*)
     FROM ldci_registrainterfaz
    WHERE ldtipointerfaz = 'LF' -- Interfaz de provision de Costos
      AND ldanocontabi = nuano
      AND ldmescontab = numes
      AND ldflagcontabi = 'S';       
  
  NuTramaAnt      number;
  NuTramaNew      number; 
  nuIdentificador number;
  nuRet           number;
  SbClaveNew      ldci_detaintesap.clavcont%type;
  --
  rgcuctacadmi CU_Ldci_ctacadmi%ROWTYPE;
  --
  
  BEGIN
    
   ldci_pkInterfazSAP.vaMensError :=  '[fnuRevProvCost_GDCA] - Inicia la reversion de la provision de costos ' || inuAno || ' - ' || inumes;
   LDCI_pkTrazaInterfaces.pRegiMensaje('LF',ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),SYSDATE,USER,USERENV('TERMINAL'));
    
/*  
    >>
    OPEN cuValidacion(inuano, inumes);
    FETCH cuValidacion INTO nuCount1;
    CLOSE cuValidacion;

    IF nuCount1 > 0 THEN

      LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkInterfazSAP.vaCODINTINTERFAZ,'Interfaz ya Contabilizada en este periodo '||inuano||' - '||inumes,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
      ldci_ProcesosInterfazSap.proGenMailErrorInterfaz('M',ldci_pkInterfazSAP.vaCODINTINTERFAZ,null,null,inuano,inumes,sender,nuErrMail);

    ELSE  
*/
    
      -- Buscamos interfaz a reversar del año y mes indicado
      Open Cu_Ldci_registrainterfaz(inuAno, inumes);
      Fetch Cu_Ldci_registrainterfaz into NuTramaAnt;
      close Cu_Ldci_registrainterfaz;
      
      LDCI_pkTrazaInterfaces.pRegiMensaje('LF','[fnuRevProvCost_GDCA] - Inicia el proceso de la Reversion de Provision de Costos Trama Anterior '|| NuTramaAnt,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),sysdate,USER,USERENV('TERMINAL'));
      
      If NuTramaAnt IS NOT NULL then
        --
        -- Buscamos numero de la nueva trama
        NuTramaNew := ldci_pkinterfazsap.fnuSeq_ldci_incoliqu;
        --
        LDCI_pkTrazaInterfaces.pRegiMensaje('LF','[fnuRevProvCost_GDCA] - Inicia el procesamiento de la Reversion de Provision de Costos Nueva Trama '|| NuTramaNew,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),sysdate,USER,USERENV('TERMINAL'));         
        -- Buscamos el encabezado
        For reg in Cu_Ldci_Encaintesap(NuTramaAnt) Loop
          --
          nuIdentificador := seq_ldci_encaintesap.nextval;

          --<<
          --Insercion de datos en la tabla vtyldci_encaintesap
          -->>
          nuRet := ldci_pkinterfazsap.fnuGeneldci_encaintesap(NuTramaNew,
                                                              reg.num_documentosap,
                                                              null,
                                                              null,
                                                              TO_CHAR(SYSDATE, 'DDMMYYYY'),
                                                              TO_CHAR(SYSDATE, 'DDMMYYYY'),
                                                              reg.grledger,
                                                              NuTramaNew,
                                                              'REVER-'||REG.TXTCABEC||'-'||NuTramaNew,
                                                              reg.CLASEDOC,
                                                              reg.sociedad,
                                                              reg.currency,
                                                              nuIdentificador);

          --<<
          --Se lanza la Exepcion
          -->>

         if (nuRet <> 0) then
              raise Error;
          end if;
          --<<
          -- Saca los detalles de la interfaz de la tabla LDCI_DETAINTESAP
          -->>
          FOR regd IN Cu_Ldci_detaintesap(NuTramaAnt,reg.num_documentosap) LOOP
            -- Si la cuenta divergente es null se buscan las claves del campo clasecta
            If regd.CTADIV is NULL then
              -- se buscan las claves que la cuenta maneja
              Open CU_Ldci_ctacadmi(regd.clasecta);
              fetch CU_Ldci_ctacadmi into rgcuctacadmi;
              close CU_Ldci_ctacadmi;
            else
              -- se buscan las claves que la cuenta divergente
              Open CU_Ldci_ctacadmi(regd.ctadiv);
              fetch CU_Ldci_ctacadmi into rgcuctacadmi;
              close CU_Ldci_ctacadmi;
            end if;
            --
            If rgcuctacadmi.ctcacldb = regd.clavcont Then
              SbClaveNew := rgcuctacadmi.ctcaclcr;
            else
              SbClaveNew := rgcuctacadmi.ctcacldb;
            end if;
            --
                
            --<<
            --Generacion de los detalles de la interfaz en la tabla vtyLDCI_DETAINTESAP
            -->>
            nuRet := ldci_pkinterfazsap.fnuLDCI_DETAINTESAP(NuTramaNew,
                                                            regd.num_documentosap,
                                                            SbClaveNew, --regd.CLAVCONT,
                                                            regd.CLASECTA,
                                                            regd.INDICCME,
                                                            regd.IMPOMTRX,
                                                            regd.IMPOMSOC,
                                                            regd.INDICIVA,
                                                            regd.CONDPAGO,
                                                            regd.FECHBASE,
                                                            regd.REFFACTR,
                                                            regd.BASEIMPT,
                                                            regd.CENTROCO,
                                                            regd.ORDENINT,
                                                            regd.CANTIDAD,
                                                            regd.ASIGNACN,
                                                            'REVER-'||regd.txtposcn||'-'||NuTramaNew,
                                                            regd.CENTROBE,
                                                            regd.SEGMENTO,
                                                            regd.OBJCOSTO,
                                                            regd.CLAVREF1,
                                                            regd.CLAVREF2,
                                                            regd.CLAVREF3,
                                                            regd.SOCIEDGL,
                                                            regd.MATERIAL,
                                                            regd.TIPORETC,
                                                            regd.INDRETEC,
                                                            regd.BASERETC,
                                                            regd.FECHVALOR,
                                                            regd.CTADIV,
                                                            regd.COD_CENTROBENEF,
                                                            -1,
                                                            nuIdentificador);
                                                   
          End loop;
          
          --
        End loop;
        
        nuRet := ldci_pkinterfazsap.fnuINSEINTESAP;
        IF (nuRet <> 0) THEN
           RAISE ERROR;
        END IF;
        Commit;
    
      -- Se realiza la insercion en la tabla que tiene el historico de interfaces enviadas a SAP
       nuRet :=ldci_pkinterfazsap.fnuRegistraInterfaz(NuTramaNew,sysdate,'S','LF');

       IF (nuRet <> 0) THEN
            LDCI_pkTrazaInterfaces.pRegiMensaje('LF','No se puede Registrar la interfaz fnuRegistraInterfaz :['||'LF'||']',to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),'LF',USER,USERENV('TERMINAL'));
            RAISE ERROR;
       END IF;  
    
       ldci_pkInterfazSAP.vaMensError :=  '[fnuRevProvCost_GDCA] - FInaliza la reversion de la provision de costos';
       LDCI_pkTrazaInterfaces.pRegiMensaje('LF',ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),SYSDATE,USER,USERENV('TERMINAL'));
        
    
      End if;
      
--    End if;
  
    RETURN(0);
  
  
  EXCEPTION
    WHEN ERROR THEN
         ldci_pkinterfazsap.vaMensError :=  '[fnuGeneDocuSapProv] - No se pudo generar Encabezado. '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
         LDCI_pkTrazaInterfaces.pRegiMensaje(NuTramaNew,ldci_pkinterfazsap.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),NuTramaNew,USER,USERENV('TERMINAL'));
         dbms_output.put_line('Error fnuGeneDocuSapProv :['||ldci_pkinterfazsap.vaMensError);
         return(-1);    
    WHEN OTHERS THEN
         ldci_pkInterfazSAP.vaMensError :=  '[fnuRevProvCost_GDCA] - No se genero la trama SAP, Reversion Provision de Costos. '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
         LDCI_pkTrazaInterfaces.pRegiMensaje('LF',ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),SYSDATE,USER,USERENV('TERMINAL'));
         RETURN(-1);
  END fnuRevProvCost_GDCA;
  

  -- Funcion Genera trama provision de Costos/Gasto
  FUNCTION fnuGenProvCost(  inuAno      IN NUMBER,
                            inuMes      IN NUMBER
                          )
  RETURN NUMBER IS
  /*****************************************************************************
  Propiedad intelectual PETI - OSF
  Function:     fnuGenProvCost
  Descripcion:  Funcion para reportar los Costos/Gastos al sistema
                SAP.

  Parametros de Entrada:
                inuAno      :Anio de la provision
                inuMes      :Mes de la provision


  Parametros de Salida:
                Ninguno
  Retornos:
                0  No hubo error al ejecutar la funcion.
                -1 Hubo error al ejecutar al funcion.
  Autor:        Carlos Humberto Gonzalez - ARQS
  Fecha:        11-08-2014

  Historia de modificaciones
  Fecha        Autor       Modificacion
  19-08-2015   cgonzalez   Se modifica el metodo para soporte el desglose de documentos
                           cuando superan los 999 registros.
  19-07-2016   edmlar      CA- 100-10632 Se modifica el cursor cuDataProv, para incluir el tercero
                           para la interfaz.

  ******************************************************************************/

  -- Variables
  nuRet       NUMBER;      -- Retorno de las funcionnes
  nuErrMail        number;
  sender   varchar2(2000) := dald_parameter.fsbgetvalue_chain('LDC_SMTP_SENDER');
  vaNitGene   ldci_banconit.bannnnit%TYPE;       -- NIT
  vaDescNit   ldci_banconit.bannnomb%TYPE;       -- Descripcion del NIT
  vaCuenta    ldci_cuentacontable.cuctcodi%TYPE; -- Obtiene la cuenta del parametro
  vaCtaProv   ldci_cuentacontable.cuctcodi%TYPE; -- Cuenta de Provision
  vaCECO      ldci_centrocosto.cecocodi%TYPE;    -- Centro de Costo
  vaOIEst     ldci_ordeninterna.codi_ordeinterna%TYPE; -- Orden estadistica
  nuCount1    NUMBER := 0;                             -- Contador para validar interfaz enviada
  nuErrorCta  NUMBER := 0;                             -- Error con el calculo de cuentas
  vaEnviaInterfazPA    VARCHAR2(1);                    --Parametro para el control de envio de Interfaces a SAP
  --<<
  -- Edmundo E. Lara -- 19/07/2016  CA = 100-10632
  --
  vaNitGral   ldci_banconit.bannnnit%TYPE;       -- NIT
  -->>

  ---------<<
  -- Cursores
  --------->>
  -- Provision: Debitos costos/gastos
  CURSOR cuDataProv
      IS
   SELECT
        coprtitr                                                  TIPOTRAB,
        -----
        'D'                                                       SIGNO,
        SYSDATE                                                   ICLIFECH,
        SYSDATE                                                   ICLIFECR,
        USER                                                      ICLIUSUA,
        SUBSTR(USERENV('TERMINAL'),1,10)                          ICLITERM,
        ldci_pkinterfazactas.fvaGetClaveConta(coprctac,coprsign ) CLAVCONT,
        coprctac                                                  CLASECTA,
        null                                                      INDICCME,
        Sum(coprvalo)                                             IMPOMTRX,
        Sum(coprvalo)                                             IMPOMSOC,
        null                                                      INDICIVA,
        null                                                      CONDPAGO,
        sysdate                                                   FECHBASE,
        null                                                      REFFACTR,
        null                                                      BASEIMPT,
        ldci_pkinterfazsap.fvaGetCECO(coprdepa,coprloca,coprtitr) CENTROCO,
        ldci_pkinterfazsap.fvaGetOIEST(coprdepa,coprloca,coprtitr)ORDENINT,
        NULL                                                      CANTIDAD,
        --<<
        -- Edmundo E. Lara -- 19/07/2016  CA = 100-10632
        --
--        NULL                                                      ASIGNACN,
        coprnit                                                   ASIGNACN,
        -->>
        NULL                                                      TXTPOSCN,
        ldci_pkinterfazsap.fvaGetCebeNoCat(coprloca)              CENTROBE,
        ldci_pkinterfazsap.fvaGetSegmento(ldci_pkinterfazsap.fvaGetCebeNoCat(coprloca))SEGMENTO,
        NULL                                                      OBJCOSTO,
        --<<
        -- Edmundo E. Lara -- 19/07/2016  CA = 100-10632
        --
--        NULL                                                      CLAVREF1,
        coprnit                                                   CLAVREF1,
        -->>
        NULL                                                      CLAVREF2,
        NULL                                                      CLAVREF3,
        NULL                                                      SOCIEDGL,
        NULL                                                      MATERIAL,
        NULL                                                      TIPORETC,
        NULL                                                      INDRETEC,
        NULL                                                      BASERETC,
        NULL                                                      FECHVALOR,
        NULL                                                      CTADIV,
        -1                                                        COD_CLASIFCONTA,
        '-1'                                                      DCRCINAD,
        -1                                                        COMPROBANTE,
        -1                                                        NUSEINSE

   FROM ldci_costprov
  WHERE copranoc = inuAno
    AND coprmesc = inuMes
--<<
-- Edmundo E. Lara -- 19/07/2016  CA = 100-10632
--
--    AND nvl(coprclco,-1) NOT IN (SELECT clcocodi
--                                   FROM ic_clascont
--                                  WHERE ',' || (SELECT casevalo
--                                                  FROM ldci_carasewe
--                                                 WHERE casecodi = 'CLASCONT_FNB') || ',' LIKE '%,' || clcocodi || ',%')
-->>
  GROUP BY coprctac, coprsign,
           coprdepa, coprloca,
           coprtitr, coprnit
  UNION ALL
     -- Cuenta de Provision
     SELECT
        coprtitr                                                  TIPOTRAB,
        -----
        'C'                                                       SIGNO,
        SYSDATE                                                   ICLIFECH,
        SYSDATE                                                   ICLIFECR,
        USER                                                      ICLIUSUA,
        SUBSTR(USERENV('TERMINAL'),1,10)                          ICLITERM,
        ldci_pkinterfazactas.fvaGetClaveConta((SELECT casevalo FROM ldci_carasewe
         WHERE casecodi = 'CTA_PROVISION_COSTO'),decode(coprsign,'D', 'C', 'D') ) CLAVCONT,
        (SELECT casevalo FROM ldci_carasewe
         WHERE casecodi = 'CTA_PROVISION_COSTO')                  CLASECTA,
        null                                                      INDICCME,
        Sum(coprvalo)                                             IMPOMTRX,
        Sum(coprvalo)                                             IMPOMSOC,
        null                                                      INDICIVA,
        null                                                      CONDPAGO,
        sysdate                                                   FECHBASE,
        null                                                      REFFACTR,
        null                                                      BASEIMPT,
        ldci_pkinterfazsap.fvaGetCECO(coprdepa,coprloca,coprtitr) CENTROCO,
        ldci_pkinterfazsap.fvaGetOIEST(coprdepa,coprloca,coprtitr)ORDENINT,
        NULL                                                      CANTIDAD,
        NULL                                                      ASIGNACN,
        NULL                                                      TXTPOSCN,
        ldci_pkinterfazsap.fvaGetCebeNoCat(coprloca)              CENTROBE,
        ldci_pkinterfazsap.fvaGetSegmento(ldci_pkinterfazsap.fvaGetCebeNoCat(coprloca))SEGMENTO,
        NULL                                                      OBJCOSTO,
        NULL                                                      CLAVREF1,
        NULL                                                      CLAVREF2,
        NULL                                                      CLAVREF3,
        NULL                                                      SOCIEDGL,
        NULL                                                      MATERIAL,
        NULL                                                      TIPORETC,
        NULL                                                      INDRETEC,
        NULL                                                      BASERETC,
        NULL                                                      FECHVALOR,
        NULL                                                      CTADIV,
        -1                                                        COD_CLASIFCONTA,
        '-1'                                                      DCRCINAD,
        -1                                                        COMPROBANTE,
        -1                                                        NUSEINSE

   FROM ldci_costprov
  WHERE copranoc = inuAno
    AND coprmesc = inuMes
--<<
-- Edmundo E. Lara -- 19/07/2016  CA = 100-10632
--
--    AND nvl(coprclco,-1) NOT IN (SELECT clcocodi
--                                   FROM ic_clascont
--                                  WHERE ',' || (SELECT casevalo
--                                                  FROM ldci_carasewe
--                                                 WHERE casecodi = 'CLASCONT_FNB') || ',' LIKE '%,' || clcocodi || ',%')
-->>
  GROUP BY coprctac,coprsign,
           coprdepa,coprloca,
           coprtitr;

   CURSOR cuValidacion(ivatipo VARCHAR2, nuano NUMBER, numes NUMBER)
   IS
   SELECT Count(*)
     FROM ldci_registrainterfaz
    WHERE ldtipointerfaz = ivatipo
      AND ldanocontabi = nuano
      AND ldmescontab = numes
      AND ldflagcontabi = 'S';


   ----------------------------<<
   -- Variables tipos registros
   ---------------------------->>
   TYPE tyInfoDeta IS TABLE OF cuDataProv%ROWTYPE INDEX BY BINARY_INTEGER;
        vtyInfoDeta tyInfoDeta;

   BEGIN

    --<< Parametros Generales
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'NIT_GENE_PROV_COSTO', vaNitGene, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'SOCIEDAD', ldci_pkinterfazsap.vaSOCIEDAD, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CURRENCY', ldci_pkinterfazsap.vaCURRENCY, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CEBE_GENERAL', ldci_pkinterfazactas.gvacebegral, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CONDIPAGO', ldci_pkinterfazsap.vaCODPAGO, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CTA_PROVISION_COSTO', vaCuenta, osbErrorMessage);
    ldci_pkwebservutils.proCaraServWeb('WS_INTER_CONTABLE', 'ENVIAINTERFAZPA', vaEnviaInterfazPA, osbErrorMessage);

    -- Tipo de Documento LF
    ldci_pkInterfazSAP.vaCODINTINTERFAZ := 'LF';
    ldci_pkinterfazactas.gvProvRevCosto := 'PROVISIONCOST';
    LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkInterfazSAP.vaCODINTINTERFAZ,'Inicia el procesamiento de la Interfaz de Provision de Costos',to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));

    --<<
    -- Cantidad de registros
    -->>
    OPEN cuValidacion(ldci_pkInterfazSAP.vaCODINTINTERFAZ, inuano, inumes);
    FETCH cuValidacion INTO nuCount1;
    CLOSE cuValidacion;

    IF nuCount1 > 0 THEN

      LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkInterfazSAP.vaCODINTINTERFAZ,'Interfaz ya Contabilizada en este periodo '||inuano||' - '||inumes,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
      ldci_ProcesosInterfazSap.proGenMailErrorInterfaz('M',ldci_pkInterfazSAP.vaCODINTINTERFAZ,null,null,inuano,inumes,sender,nuErrMail);

    ELSE

      --<<
      -- Edmundo E. Lara -- 19/07/2016  CA = 100-10632
      --
      -- Obtiene la descripcion del NIT
      --vaDescNit := ldci_pkinterfazsap.fvaGetDescripNit(vaNitGene);
      -->>

      ldci_pkinterfazsap.vaGRLEDGER := LDCI_PKINTERFAZACTAS.fvaGetLibro(ldci_pkInterfazSAP.vaCODINTINTERFAZ);

      OPEN cuDataProv;
      FETCH cuDataProv BULK COLLECT INTO vtyInfoDeta;
      CLOSE cuDataProv;

      IF (vtyInfoDeta.count > 0) THEN
          --<<
          -- Obtencion del  numero de documento
          -->>
          ldci_pkInterfazSAP.nuSeqICLINUDO := ldci_pkInterfazSAP.fnuSeq_ldci_incoliqu;

          FOR i IN vtyInfoDeta.First..vtyInfoDeta.Last LOOP

              --<<
              -- Cuenta de Provision para el Credito
              -->>
              vaCECO    := NULL;
              vaOIEst   := NULL;

              IF vtyInfoDeta(i).SIGNO = 'D' THEN

                vaCECO    := vtyInfoDeta(i).CENTROCO;
                vaOIEst   := vtyInfoDeta(i).ORDENINT;

              END IF;

              --<<
              -- Edmundo E. Lara -- 19/07/2016  CA = 100-10632
              --
              -- Obtiene la descripcion del NIT
              IF vtyInfoDeta(i).ASIGNACN is null THEN
                 vaNitGral := vaNitGene;
              ELSE
                 vaNitGral := vtyInfoDeta(i).ASIGNACN;
              END IF;

              vaDescNit := ldci_pkinterfazsap.fvaGetDescripNit(vaNitGral);


              -->>

              --<<
              -- Se valida la cuenta
              -->>
              IF (vtyInfoDeta(i).CLASECTA IS NULL) THEN
                 LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkInterfazSAP.vaCODINTINTERFAZ,'La cuenta esta vacia para el trabajo: '||vtyInfoDeta(i).TIPOTRAB,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
                 --Dbms_Output.Put_Line('00');
                 nuErrorCta := 1;
              END IF;

              nuRet := ldci_pkinterfazsap.fnuLDCI_INCOLIQUPROV(vaICLITIDO  =>  ldci_pkInterfazSAP.vaCODINTINTERFAZ,
                                                               nuICLINUDO  =>  ldci_pkInterfazSAP.nuSeqICLINUDO,
                                                               dtICLIFECH  =>  vtyInfoDeta(i).ICLIFECH,
                                                               vaICLIUSUA  =>  vtyInfoDeta(i).ICLIUSUA,
                                                               vaICLITERM  =>  vtyInfoDeta(i).ICLITERM,
                                                               dtICLIFECR  =>  vtyInfoDeta(i).ICLIFECR,
                                                               vaCLAVCONT  =>  vtyInfoDeta(i).CLAVCONT,
                                                               vaCLASECTA  =>  vtyInfoDeta(i).CLASECTA,
                                                               vaINDICCME  =>  vtyInfoDeta(i).INDICCME,
                                                               nuIMPOMTRX  =>  vtyInfoDeta(i).IMPOMTRX,
                                                               nuIMPOMSOC  =>  vtyInfoDeta(i).IMPOMSOC,
                                                               vaINDICIVA  =>  vtyInfoDeta(i).INDICIVA,
                                                               vaCONDPAGO  =>  vtyInfoDeta(i).CONDPAGO,
                                                               dtFECHBASE  =>  vtyInfoDeta(i).FECHBASE,
                                                               vaREFFACTR  =>  vtyInfoDeta(i).REFFACTR,
                                                               nuBASEIMPT  =>  vtyInfoDeta(i).BASEIMPT,
                                                               vaORDENINT  =>  vaOIEst,
                                                               nuCANTIDAD  =>  vtyInfoDeta(i).CANTIDAD,
                                                               --<<
                                                               -- Edmundo E. Lara -- 19/07/2016  CA = 100-10632
                                                               --
                                                               --vaASIGNACN  =>  vaNitGene,
                                                               vaASIGNACN  =>  vaNitGral,
                                                               -->>
                                                               vaTXTPOSCN  =>  vtyInfoDeta(i).TXTPOSCN,
                                                               vaCENTROBE  =>  vtyInfoDeta(i).CENTROBE,
                                                               vaSEGMENTO  =>  vtyInfoDeta(i).SEGMENTO,
                                                               vaOBJCOSTO  =>  vtyInfoDeta(i).OBJCOSTO,
                                                              --<<
                                                               -- Edmundo E. Lara -- 19/07/2016  CA = 100-10632
                                                               --
                                                               --vaCLAVREF1  =>  vaNitGene,
                                                               vaCLAVREF1  =>  vaNitGral,
                                                               -->>
                                                               vaCLAVREF2  =>  vtyInfoDeta(i).CLAVREF2,
                                                              --<<
                                                               -- Edmundo E. Lara -- 19/07/2016  CA = 100-10632
                                                               --
                                                               --vaCLAVREF3  =>  vaDescNit,
                                                               vaCLAVREF3  =>  vaDescNit,
                                                               -->>
                                                               vaSOCIEDGL  =>  vtyInfoDeta(i).SOCIEDGL,
                                                               vaMATERIAL  =>  vtyInfoDeta(i).MATERIAL,
                                                               vaTIPORETC  =>  vtyInfoDeta(i).TIPORETC,
                                                               vaINDRETEC  =>  vtyInfoDeta(i).INDRETEC,
                                                               vaBASERETC  =>  vtyInfoDeta(i).BASERETC,
                                                               nuNUSEINSE  =>  vtyInfoDeta(i).NUSEINSE,
                                                               vaCOD_CENTROBENEF   => vtyInfoDeta(i).CENTROBE,
                                                               nuCOD_CLASIFCONTA   => vtyInfoDeta(i).COD_CLASIFCONTA,
                                                               dtFECHVALOR         => vtyInfoDeta(i).FECHVALOR,
                                                               vaCTADIV            => vtyInfoDeta(i).CTADIV,
                                                               vaCENTROCO          => vaCECO,
                                                               nuCOMPROBANTE       => vtyInfoDeta(i).COMPROBANTE,
                                                               vaLEDGERS           => ldci_pkinterfazsap.vaGRLEDGER,
                                                               vatipotrab          => vtyInfoDeta(i).tipotrab);

              END LOOP;

              nuRet := ldci_pkInterfazSAP.fnuINSELDCI_INCOLIQU;
              --<<
              --Genera la informacion de los documentos para SAP de la interfaz de INGRESOS
              -->>
              --<<
              --Se lanza la Exepcion
              -->>
              IF (nuRet <> 0) THEN
                 --Dbms_Output.Put_Line('01');
                 RAISE ERROR;
              END IF;

              IF (nuErrorCta <> 0) THEN
                LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkInterfazSAP.vaCODINTINTERFAZ,'No se envia la interfaz debido a cuentas nulas',to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
                --Dbms_Output.Put_Line('02');
                ldci_ProcesosInterfazSap.proGenMailErrorInterfaz('M',ldci_pkInterfazSAP.vaCODINTINTERFAZ,null,null,inuano,inumes,sender,nuErrMail);
                RETURN(-1);
              END IF;

              nuRet := ldci_pkInterfazSAP.fnuGeneDocuSapProv(ldci_pkInterfazSAP.nuSeqICLINUDO);

              --<<
              --Se lanza la Exepcion
              -->>
            IF (nuRet <> 0) THEN
                --Dbms_Output.Put_Line('03');
                LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkInterfazSAP.vaCODINTINTERFAZ||'C',ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
                RAISE ERROR;
            END IF;

          -- Validacion si se inserto historia contable
        ELSE
          LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkInterfazSAP.vaCODINTINTERFAZ,'No se encontraron datos a procesar en el periodo '||inuano||' - '||inumes,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
          ldci_ProcesosInterfazSap.proGenMailErrorInterfaz('M',ldci_pkInterfazSAP.vaCODINTINTERFAZ,null,null,inuano,inumes,sender,nuErrMail);

        END IF;

        nuRet := ldci_pkinterfazsap.fnuAjusteInterCont(ldci_pkInterfazSAP.nuSeqICLINUDO);
        IF (nuRet <> 0) THEN
            LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkInterfazSAP.vaCODINTINTERFAZ,'Error al Realizar Porceso de Ajuste (DB/CR) Provision de Costos',to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
            RAISE Error;
        END IF;
        -- Confirmacion de la creacion de la trama
        COMMIT;
        LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkInterfazSAP.vaCODINTINTERFAZ,'Trama '||ldci_pkInterfazSAP.nuSeqICLINUDO||' a Procesar por Provision de Costos',to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));

        --<<
        -- Valida si la trama Generada por Documento e Identificador NO supere los 999 Registros.
        -->>
        nuRet := ldci_pkinterfazsap.fnusplitdocclas(nucodtrama => ldci_pkinterfazsap.nuSeqICLINUDO);

        IF (nuRet <> 0) THEN
          --Dbms_Output.Put_Line('04');
          LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkInterfazSAP.vaCODINTINTERFAZ,'Error al Dividir la Trama '||ldci_pkInterfazSAP.nuSeqICLINUDO||' de Provision de Costos. Validar Posible Datos Sin CEBE ',to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
          RAISE Error;
        END IF;


        --<<
        --Si es satifactorio todo el proceso, se realiza el envio a SAP
        -->>
        IF (vaEnviaInterfazPA = 'S') THEN
           ldci_pkintercontablemesa.proEnviaDocContable(ldci_pkInterfazSAP.nuSeqICLINUDO);
        END IF;

        -- envia correo notificando el envio de la interfaz a SAP
        ldci_ProcesosInterfazSap.proGenMailInterfaz (ldci_pkinterfazsap.nuSeqICLINUDO,ldci_pkInterfazSAP.vaCODINTINTERFAZ,sender,nuErrMail);


        nuRet := ldci_pkinterfazsap.fnuRegistraInterfazAnioMes(ldci_pkinterfazsap.nuSeqICLINUDO,inuano,inumes,'S',ldci_pkInterfazSAP.vaCODINTINTERFAZ);
        -- Validacion si se inserto historia contable
        IF (nuRet <> 0) THEN
           --Dbms_Output.Put_Line('05');
           LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkInterfazSAP.vaCODINTINTERFAZ,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
           RAISE Error;
        END IF;

     END IF;

   LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkInterfazSAP.vaCODINTINTERFAZ,'Finaliza existosamente el procesamiento de la Interfaz de Provision de Costos Trama:'||ldci_pkInterfazSAP.nuSeqICLINUDO,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));

   COMMIT;



   RETURN 0;

  EXCEPTION
  WHEN Error THEN
       ldci_ProcesosInterfazSap.proGenMailErrorInterfaz('M',ldci_pkInterfazSAP.vaCODINTINTERFAZ,null,null,inuano,inumes,sender,nuErrMail);
       RETURN(-1);

  WHEN OTHERS THEN
       ldci_pkInterfazSAP.vaMensError :=  '[fnuGenProvCost] - No se genero lata trama SAP Provision de Costos. '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
       LDCI_pkTrazaInterfaces.pRegiMensaje('LF',ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),SYSDATE,USER,USERENV('TERMINAL'));
       ldci_ProcesosInterfazSap.proGenMailErrorInterfaz('M',ldci_pkInterfazSAP.vaCODINTINTERFAZ,null,null,inuano,inumes,sender,nuErrMail);
       --Dbms_Output.Put_Line('07'||ldci_pkInterfazSAP.vaMensError);
       RETURN(-1);
  END fnuGenProvCost;


  ---
  FUNCTION fnuFotoProvCost(  idafechaini      IN DATE DEFAULT NULL ,
                             idafechafin      IN DATE DEFAULT NULL,
                             --<< EDMLAR CA 200-782
                             idafechaAct      IN DATE DEFAULT NULL
                             -->>
                           )
  /*****************************************************************************
  Propiedad intelectual Gases de Occidente .
  Function:     fnuFotoProvCost
  Descripcion:  Funcion para armar la foto de la provision de costos/gastos

  Parametros de Entrada:
                idafechaini      :Fecha Inicial
                idafechafin      :Fecha final

  Parametros de Salida:
                Ninguno
  Retornos:
                0  No hubo error al ejecutar la funcion.
                -1 Hubo error al ejecutar al funcion.
  Autor:        Carlos Humberto Gonzalezv
  Fecha:        08-08-2014

  Historia de modificaciones
  Fecha       Autor       Modificacion
  16-09-2015  cgonzalezv  SAO.338823
                          Modificacion de la funcion fnuFotoProvCost  para obtener
                          la direccion como subconsulta y no afectar el valor
                          total de los costos.
  22-10-2015   heiberb    SAO. 346712
                          Ajuste de la funcion fnuFotoProvCost para obtener la localidad a partir de la orden
                          en un subquery en la segunda consulta de las ordenes sin acta, haciendo un select from select
                          para mejorar el rendimiento al momento de sacar el departamento y el pais.
  19-07-2016   edmlar     CA- 100-10632 Se modifica el cursor cuActOTProv, se incluye la nueva consulta para hallar
                          la provision de costos
  09-09-2016   edmlar     CA- 200-782 Se pasa como parametro la fecha de cierre de las actas.
  31-07-2017   edmlar     CA-2001310
                          Se corrige la funcin FnuFotoProvCost, foto de la provision de costos para que en la consulta de
                          ordenes sin acta valide que la causal de legalizacion sea de Exito.
                          Se corrige la funcion fnuInterCostoSAP para validar el item = 102005 Entrega de anticipo
                          para que envie la clave 29 en vez de la 39.
  22-05-2019   horbath    CA-200-2592
                          Se actualiza la consulta de la provision de costos de acuerdo a las ultimas modificaciones
                          realizadas y se optimiza la consulta.
  14-08-2020   horbath    426 se modifica para que si la entrega aplica para la gasera se optimice el tiempo de la provision,
                          y se evitan costos dobles para los clasificadores de facturacion

  ******************************************************************************/
  RETURN NUMBER
  IS

    -- Variables
    dtFechI    DATE;     -- Fecha Inicial
    dtFechF    DATE;     -- Fecha Final
    --<< EDMLAR CA 200-782
    dtFechA    DATE;     -- Fecha Final Actas
    -->>
    nuAnoIni   NUMBER;   -- A?o Inicial
    nuMesIni   NUMBER;   -- Mes Inicial
    nuAnoFin   NUMBER;   -- A?o Final
    nuMesFin   NUMBER;   -- Mes Final
    nuCantiReg NUMBER;   -- Cantidad de registros
    vaFechCont DATE;     -- Fecha de contabilizacion

    TYPE t_ldci_costprov IS TABLE OF ldci_costprov%ROWTYPE;
         v_ldci_costprov t_ldci_costprov;


    TYPE t_ldci_costprov_l IS TABLE OF ldci_costprov%ROWTYPE;
         v_ldci_costprov_l t_ldci_costprov_l;

    --<<
    -- Cursores
    -->>
    --Selecciona las actas sin factura y ordenes legalizadas sin acta
    CURSOR cuActOTProv
        IS
/*
    SELECT  CT.id_contratista CONTR,
            (select PAIS.GEO_LOCA_FATHER_ID from ge_geogra_location PAIS WHERE PAIS.GEOGRAP_LOCATION_ID IN (select DPTO.GEO_LOCA_FATHER_ID from ge_geogra_location DPTO WHERE DPTO.GEOGRAP_LOCATION_ID = AD.geograp_location_id)) PAIS,
            (select GEO_LOCA_FATHER_ID from ge_geogra_location WHERE GEOGRAP_LOCATION_ID = AD.geograp_location_id) DPTO,
            AD.geograp_location_id LOCA,
            Decode(ldci_pkinterfazactas.fnuGetTipoTrab(AD.ID_ORDEN),0, OT.task_type_id, ldci_pkinterfazactas.fnuGetTipoTrab(AD.ID_ORDEN)) TT,
            nuAnoFin,
            nuMesFin,
            DECODE(SIGN(Round(Sum(AD.valor_total))),-1,'C','D') SIGNO,
            ABS(Round(Sum(AD.valor_total))) VALOR,
            ldci_pkinterfazactas.fvaGetCuGaCoClasi(AD.id_orden) CTA,
            ldci_pkinterfazactas.fvaGetClasifi(Decode(ldci_pkinterfazactas.fnuGetTipoTrab(AD.ID_ORDEN),0,
                                                      OT.task_type_id, ldci_pkinterfazactas.fnuGetTipoTrab(AD.ID_ORDEN))) CLACONT,
            vaFechCont
      FROM ge_detalle_acta AD ,ge_items IT,
           ge_acta AC,ge_contrato CO,
           ge_subscriber GS,ge_contratista CT,
           or_order OT
     WHERE IT.items_id        = AD.id_items
       AND AD.id_acta         = AC.id_acta
       AND CO.id_contrato     = AC.id_contrato
       AND CT.subscriber_id   = GS.subscriber_id
       AND CO.id_contratista  = CT.id_contratista
       AND OT.order_id        = AD.id_orden
       AND AD.valor_total     <> 0
       AND IT.item_classif_id <> 23 -- Item tipo impuesto
       AND ac.extern_invoice_num IS NULL   -- Sin factura
       AND OT.legalization_date  BETWEEN NVL(dtFechI,OT.legalization_date) AND NVL(dtFechF,OT.legalization_date)
       --AND AD.id_acta            = 5671
     GROUP BY AD.geograp_location_id,
              CT.id_contratista,
              OT.task_type_id,
              ldci_pkinterfazactas.fvaGetCuGaCoClasi(AD.id_orden),
              ldci_pkinterfazactas.fnuGetTipoTrab(AD.id_orden),
              ldci_pkinterfazactas.fvaGetCuGaCoClasi(AD.id_orden)

     UNION ALL
     -- Ordenes Legalizadas sin acta
\*  22-10-2015   heiberb    SAO. 346712
                          Ajuste de la funcion fnuFotoProvCost para obtener la localidad a partir de la orden
                          en un subquery en la segunda consulta de las ordenes sin acta, haciendo un select from select
                          para mejorar el rendimiento al momento de sacar el departamento y el pais.
*\

   select CONTR, (SELECT PAIS.GEO_LOCA_FATHER_ID
               FROM ge_geogra_location PAIS
              WHERE PAIS.GEOGRAP_LOCATION_ID = (SELECT DPTO.GEO_LOCA_FATHER_ID
                                                   from ge_geogra_location DPTO
                                                  WHERE DPTO.GEOGRAP_LOCATION_ID = LOCA)) PAIS,
                                                   (SELECT GEO_LOCA_FATHER_ID from ge_geogra_location WHERE GEOGRAP_LOCATION_ID = LOCA) DPTO,
           LOCA, TT ,nuAnoFin, nuMesFin ,SIGNO, Sum(VALOR), CTA,CLACONT, vaFechCont
           from (
   SELECT CONTR, LOCA, TT ,nuAnoFin, nuMesFin ,SIGNO, Sum(VALOR) VALOR, CTA,CLACONT, vaFechCont
     FROM
     (
       SELECT
             CT.id_contratista  CONTR,
--            (SELECT PAIS.GEO_LOCA_FATHER_ID
--               FROM ge_geogra_location PAIS
--              WHERE PAIS.GEOGRAP_LOCATION_ID IN (SELECT DPTO.GEO_LOCA_FATHER_ID
--                                                   from ge_geogra_location DPTO
--                                                  WHERE DPTO.GEOGRAP_LOCATION_ID IN (SELECT UNIQUE AD.geograp_location_id
--                                                                                       FROM or_order_activity OA,ab_address AD
--                                                                                      WHERE OA.address_id  =   AD.address_id
--                                                                                        AND OA.order_id    =   OT.order_id))) PAIS, --SAO 338823

           --SAO 338823
          (SELECT UNIQUE AD.geograp_location_id
             FROM or_order_activity OA,ab_address AD
            WHERE OA.address_id  =   AD.address_id
              AND OA.order_id    =   OT.order_id) LOCA, --SAO 338823

            Decode(ldci_pkinterfazactas.fnuGetTipoTrab(OT.order_id),0, OT.task_type_id, ldci_pkinterfazactas.fnuGetTipoTrab(OT.order_id)) TT,
            nuAnoFin,
            nuMesFin,
            DECODE(SIGN(Round(Sum(oi.Value))),-1,'C','D') SIGNO,
            to_number(ABS(Round(Sum(oi.Value)))) VALOR,
            ldci_pkinterfazactas.fvaGetCuGaCoClasi(OT.order_id) CTA,
            ldci_pkinterfazactas.fvaGetClasifi(Decode(ldci_pkinterfazactas.fnuGetTipoTrab(OT.order_id),0,
                                                        OT.task_type_id, ldci_pkinterfazactas.fnuGetTipoTrab(OT.order_id))) CLACONT,
            vaFechCont
      FROM or_order OT,
           or_operating_unit OU,
           ge_contratista CT,
           or_order_items OI,
           ge_items IT
     WHERE IT.items_id           = OI.items_id
       AND OU.operating_unit_id  = OT.operating_unit_id
       AND ou.es_externa         = 'Y'  -- cuadrillas externas
       AND OT.order_status_id    = 8  -- legalizada
       AND OU.contractor_id      = CT.id_contratista
       AND OT.is_pending_liq     = 'Y'
       AND IT.item_classif_id NOT IN (8,21) -- Materiales y herramientas
      -- AND OT.order_id           IN (17420911,17679792)
       AND oi.value              <>  0
       AND oi.order_id           =  OT.order_id
       AND OT.legalization_date  BETWEEN NVL(dtFechI,OT.legalization_date) AND NVL(dtFechF,OT.legalization_date)
     GROUP BY CT.id_contratista,
              OT.task_type_id,
              OT.order_id)
     GROUP BY CONTR, LOCA, TT ,nuAnoFin, nuMesFin ,SIGNO,CTA,CLACONT, vaFechCont)
     group by CONTR, LOCA, TT ,nuAnoFin, nuMesFin ,SIGNO,CTA,CLACONT, vaFechCont; */

     --<<
     -- Edmundo E. Lara -- 19/07/2016  CA = 100-10632
     --
     SELECT contratista
            ,PAIS
            ,departamento
            ,localidad
            ,titr
            ,nuAnoFin
            ,nuMesFin
            ,SIGNO
            ,Sum(Valor) Valor
            ,(select lg.cuencosto from open.ldci_cugacoclasi lg where lg.cuenclasifi = clasificador) Cta
            ,clasificador
            ,null coprfeco
            ,orden
            ,acta
            ,sum(Total_iva) Total_iva
            ,(select sb.identification from open.ge_subscriber sb
               where sb.subscriber_id = (select co.subscriber_id from OPEN.GE_CONTRATISTA co
                                          where co.id_contratista = contratista)) NIT
            ,tipo
       FROM (
            SELECT contratista
                  ,1 PAIS
                  ,(SELECT d.geo_loca_father_id FROM open.ge_geogra_location d WHERE d.geograp_location_id = localidad) departamento
                  ,localidad
                  ,titr
                  ,DECODE(SIGN(Round(Sum(total))),-1,'C','D') SIGNO
                  ,ABS(Round(Sum(total))) Valor
                  ,(select lg.cuencosto from open.ldci_cugacoclasi lg where lg.cuenclasifi = clasificador) Cta
                  ,clasificador, (select t.clcodesc from open.ic_clascont t where t.clcocodi = clasificador) desc_clasi
                  ,null coprfeco
                  ,orden
                  ,acta
                  ,ABS(Round(sum(Total_iva))) Total_iva
                  ,(select sb.identification from open.ge_subscriber sb
                     where sb.subscriber_id = (select co.subscriber_id from OPEN.GE_CONTRATISTA co
                                                where co.id_contratista = contratista)) NIT
                  ,tipo
             FROM (
                  -- ACTA SIN FACTURA
                  SELECT  tipo
                         ,acta
                         ,titr
                         ,Total
                         ,Total_iva
                         ,clctclco Clasificador
                         ,contratista
                         ,nombre
                         ,orden
                         ,localidad
                  from (
                        select tipo
                              ,acta
                              ,titr
                              ,sum(decode(Nombre, null, 0, total)) Total
                              ,sum(decode(Nombre, null, 0, total_iva)) Total_iva
                              ,clctclco
                              ,contratista
                              ,nombre
                              ,orden, open.LDC_BOORDENES.FNUGETIDLOCALIDAD(orden) Localidad, factura, fecha
                    from (
                          --
                          --
                          -- UNIFICACION
                          -- ACTAS SIN FACTURAS
                          select tipo, acta, factura, fecha, orden, titr,  sum(total) total,
                                 sum(total_iva) total_iva, contratista, nombre, clctclco
                          from (
                                SELECT 'ACTA_S_F' TIPO,
                                       a.id_acta acta, null  factura, null  fecha,
                                       a.id_orden orden, decode(ro.task_type_id, 10336, ro.real_task_type_id, ro.task_type_id) titr,
                                       sum(decode(it.items_id, 4001293, 0, a.valor_total)) Total,
                                       sum(decode(it.items_id, 4001293, a.valor_total)) Total_IVA,
                                       co.id_contratista contratista, ta.nombre_contratista nombre,
                                       tt.clctclco
                                FROM OPEN.ge_detalle_acta a, open.ge_acta ac, open.or_order ro,
                                     open.or_task_type ot, open.ge_contratista ta, open.ge_contrato co, open.ge_items it, open.ic_clascott tt
                               where ac.id_acta   = a.id_acta
                                 and (ac.extern_pay_date is null or ac.extern_pay_date >= dtFechA)
                                 and a.id_orden   = ro.order_id
                                 and a.valor_total != 0
                                 --<< CA-200-2592
                                 --and ro.task_type_id !=  10336 -- Tipo de Trabajo Ajustes
                                 -->>
                                 and decode(ro.task_type_id, 10336, ro.real_task_type_id, ro.task_type_id) = tt.clcttitr
                                 and ro.legalization_date <= dtFechF
                                 and ro.created_date <= dtFechF
                                 --and oa.task_type_id = ro.task_type_id
                                 --and tt.clctclco not in (311,246,303,252,253,245,314,411,413)
                                 and nvl(tt.clctclco,-1) NOT IN (SELECT clcocodi
                                                                   FROM open.ic_clascont
                                                                  WHERE ',' || (SELECT casevalo
                                                                                  FROM open.ldci_carasewe
                                                                                 WHERE casecodi = 'CLASCONT_FNB') || ',' LIKE '%,' || clcocodi || ',%')
                                 and decode(ro.task_type_id, 10336, ro.real_task_type_id, ro.task_type_id) = ot.task_type_id
                                 and ac.id_contrato = co.id_contrato
                                 and co.id_contratista = ta.id_contratista  and a.id_items = it.items_id
                                 AND (IT.item_classif_id NOT IN (8,21,23) or it.items_id = 4001293)
                                Group by 'ACTA_S_F', a.id_acta, ac.extern_invoice_num, a.id_orden,
                                         decode(ro.task_type_id, 10336, ro.real_task_type_id, ro.task_type_id), co.id_contratista,
                                         ta.nombre_contratista, tt.clctclco
                                --<<
                                -- CA-200-2592
                                -- SE UNIFICA STA CONSULTA CON LA ANTERIOR
                                /*
                                Union  -- Ajustes de ordenes de meses anteriores
                                SELECT 'ACTA_S_F' TIPO,
                                       a.id_acta acta, null factura, null  fecha,
                                       a.id_orden orden, decode(ro.task_type_id, 10336, ro.real_task_type_id, ro.task_type_id) titr,
                                       sum(decode(it.items_id, 4001293, 0, a.valor_total)) Total,
                                       sum(decode(it.items_id, 4001293, a.valor_total)) Total_IVA,
                                       co.id_contratista contratista, ta.nombre_contratista nombre,
                                       tt.clctclco
                                FROM OPEN.ge_detalle_acta a, open.ge_acta ac, open.or_order ro,
                                     open.ic_clascott tt, open.or_task_type ot, open.ge_contratista ta, open.ge_contrato co, open.ge_items it
                                where ac.id_acta   = a.id_acta
                                 and (ac.extern_pay_date is null or ac.extern_pay_date >= dtFechA)
                                 and a.id_orden   = ro.order_id
                                 and a.valor_total != 0
                                 and ro.task_type_id =  10336 -- Tipo de Trabajo Ajustes
                                 and decode(ro.task_type_id, 10336, ro.real_task_type_id, ro.task_type_id) = tt.clcttitr
                                 and ro.legalization_date <= dtFechF
                                 and ro.created_date <= dtFechF
                                 --and tt.clctclco not in (311,246,303,252,253,245,314,411,413)
                                 and nvl(tt.clctclco,-1) NOT IN (SELECT clcocodi
                                                                   FROM open.ic_clascont
                                                                  WHERE ',' || (SELECT casevalo
                                                                                  FROM open.ldci_carasewe
                                                                                 WHERE casecodi = 'CLASCONT_FNB') || ',' LIKE '%,' || clcocodi || ',%')
                                 and decode(ro.task_type_id, 10336, ro.real_task_type_id, ro.task_type_id) = ot.task_type_id
                                 and ac.id_contrato = co.id_contrato
                                 and co.id_contratista = ta.id_contratista  and a.id_items = it.items_id
                                 AND (IT.item_classif_id NOT IN (8,21,23) or it.items_id = 4001293)
                                Group by 'ACTA_S_F', a.id_acta, ac.extern_invoice_num, a.id_orden,
                                         decode(ro.task_type_id, 10336, ro.real_task_type_id, ro.task_type_id), co.id_contratista,
                                       ta.nombre_contratista, tt.clctclco
                                */
                                -- END 200-2592
                                -->>
                               )
                               Group by tipo, acta, factura, fecha, orden, titr, contratista, nombre, clctclco
                          --
                          UNION ALL
                          --
                          -- ORDENES SIN ACTA
                          select tipo, acta, factura, fecha, orden, titr, sum(total) total, sum(total_iva) total_iva,
                                 contratista, nombre, clctclco
                            from (
                          select *
                          from (
                                SELECT /*+ INDEX(OR_ORDER IDX_OR_ORDER_017) */ /*+ INDEX(OR_ORDER_ITEMS IDX_OR_ORDER_ITEMS_03) */
                                       'SIN_ACTA' TIPO, null acta, null factura, null fecha, r.order_id orden,
                                       decode(r.task_type_id, 10336, r.real_task_type_id, r.task_type_id) titr,
                                       sum(decode(it.items_id, 4001293, 0, value)) Total,
                                       sum(decode(it.items_id, 4001293, value)) Total_IVA,
                                       decode(ut.contractor_id, null, ut.operating_unit_id, ut.contractor_id) contratista,
                                       (select co.nombre_contratista from OPEN.GE_CONTRATISTA co
                                         where co.id_contratista =  decode(ut.contractor_id, null, ut.operating_unit_id, ut.contractor_id)) nombre,
                                       tt.clctclco
                                  FROM open.or_order r, open.ic_clascott tt, open.or_order_items oi, open.or_task_type ot, open.ge_items it, OPEN.OR_OPERATING_UNIT ut
                                 where r.legalization_date <= dtFechF
                                   and r.created_date <= dtFechF
                                   and r.is_pending_liq    IN ('E','Y')
                                   and r.order_status_id   =  8
                                   and r.causal_id in (select g.causal_id from open.ge_causal g where g.causal_id = r.causal_id and g.class_causal_id = 1)
                                   and value               != 0
                                   and decode(r.task_type_id, 10336, r.real_task_type_id, r.task_type_id) = tt.clcttitr
                                   --and tt.clctclco not in (311,246,303,252,253,245,314,411,413)
                                   and nvl(tt.clctclco,-1) NOT IN (SELECT clcocodi
                                                                     FROM open.ic_clascont
                                                                    WHERE ',' || (SELECT casevalo
                                                                                    FROM open.ldci_carasewe
                                                                                   WHERE casecodi = 'CLASCONT_FNB') || ',' LIKE '%,' || clcocodi || ',%')
                                   and r.order_id not in (select a.id_orden from OPEN.ge_detalle_Acta a where a.id_orden = r.order_id)
                                   and r.task_type_id = ot.task_type_id
                                   and oi.order_id    =  r.order_id
                                   and oi.items_id    = it.items_id
                                   and (it.item_classif_id NOT IN (8,21,23) or it.items_id = 4001293)
                                   and r.operating_unit_id = ut.operating_unit_id
                                   and ut.es_externa = 'Y'
                                Group by 'SIN_ACTA', null, null, null, r.order_id, decode(r.task_type_id, 10336, r.real_task_type_id, r.task_type_id),
                                         tt.clctclco, ut.contractor_id, ut.operating_unit_id
                                UNION
                                SELECT /*+ INDEX(OA IDX_OR_ORDER_ACTIVITY_05) */ /*+ INDEX(OI IDX_OR_ORDER_ITEMS_03) */
                                       'SIN_ACTA' TIPO, null acta, null factura, null fecha, oa.order_id orden,
                                       decode(oa.task_type_id, 10336, r.real_task_type_id,oa.task_type_id) titr,
                                       sum(nvl(oa.value_reference * cn.liquidation_sign * nvl((select -1 from open.or_related_order where related_order_id=oa.order_id and RELA_ORDER_TYPE_ID=15),1),0)) Total,
                                       nvl(SUM(decode(it.items_id, 4001293, 0)),0) Total_IVA,
                                       decode(ut.contractor_id, null, ut.operating_unit_id, ut.contractor_id) contratista,
                                       (select co.nombre_contratista from OPEN.GE_CONTRATISTA co
                                         where co.id_contratista =  decode(ut.contractor_id, null, ut.operating_unit_id, ut.contractor_id)) nombre,
                                       tt.clctclco
                                  FROM open.or_order_activity oa, open.mo_packages m, open.or_order_items oi, open.or_order r, open.ic_clascott tt,
                                       open.or_task_type ot, open.ge_items it, OPEN.OR_OPERATING_UNIT ut, open.ct_item_novelty cn --, open.or_related_order ro
                                 where r.legalization_date <= dtFechF
                                   and r.created_date <= dtFechF
                                   and r.is_pending_liq    IN ('E','Y')
                                   and r.order_status_id   =  8
                                   and r.causal_id in (select g.causal_id from open.ge_causal g where g.causal_id = r.causal_id and g.class_causal_id = 1)
                                   and r.order_id          =  oa.order_id
                                   and oa.package_id       =  m.package_id(+)
                                   and oi.order_id         =  oa.order_id
                                   and ((oa.order_item_id    =  oi.order_items_id and it.item_classif_id = 2)or
                                       ((oa.order_Activity_id    =  oi.order_activity_id and it.item_classif_id != 2)))
                                   and cn.items_id         = oa.activity_id
                                   and oa.value_reference != 0
                                   and decode(oa.task_type_id, 10336, r.real_task_type_id, oa.task_type_id) = tt.clcttitr
                                   --and tt.clctclco not in (311,246,303,252,253,245,314,411,413)
                                   and nvl(tt.clctclco,-1) NOT IN (SELECT clcocodi
                                                                     FROM open.ic_clascont
                                                                    WHERE ',' || (SELECT casevalo
                                                                                    FROM open.ldci_carasewe
                                                                                   WHERE casecodi = 'CLASCONT_FNB') || ',' LIKE '%,' || clcocodi || ',%')
                                   --and tt.clctclco in (247)
                                   and oa.order_id not in (select a.id_orden from OPEN.ge_detalle_Acta a where a.id_orden = oa.order_id)
                                   and oa.task_type_id = ot.task_type_id
                                   and oi.items_id     = it.items_id
                                   and (it.item_classif_id NOT IN (8,21,23) or it.items_id = 4001293)
                                   and r.operating_unit_id = ut.operating_unit_id
                                   and ut.es_externa = 'Y'
                                Group by 'SIN_ACTA', null, null, null, oa.order_id, decode(oa.task_type_id, 10336, r.real_task_type_id, oa.task_type_id),
                                         tt.clctclco, ut.contractor_id, ut.operating_unit_id
                          )
                          )
                          Group by tipo, acta, factura, fecha, orden, titr, contratista, nombre, clctclco
                    ---
                    --
                    --
                    ),  open.ic_clascont icc
                    where clctclco = icc.clcocodi
                    group by tipo,acta,orden, titr, clctclco, contratista, nombre, factura, fecha
              )
              where total != 0
              )
              Group by tipo,acta,titr,Clasificador,contratista,nombre,orden,localidad
            )
            Group by tipo,pais,acta,titr,Clasificador,contratista,orden,localidad,signo,departamento;
            -- ------------------------------

    --<<
    -- Edmundo E. Lara -- 19/07/2016  CA = 100-10632
    -- PROVISION COSTOS - CLASIFICADORES DE LECTURA
    -- Cursores
    -->>
    --Selecciona las actas sin factura y ordenes legalizadas sin acta
    CURSOR cuActOTProvLec
        IS

     SELECT contratista
            ,PAIS
            ,departamento
            ,localidad
            ,titr
            ,nuAnoFin
            ,nuMesFin
            ,SIGNO
            ,Sum(Valor) Valor
            ,(select lg.cuencosto from open.ldci_cugacoclasi lg where lg.cuenclasifi = clasificador) Cta
            ,clasificador
            ,null coprfeco
            ,orden
            ,acta
            ,sum(Total_iva) Total_iva
            ,(select sb.identification from open.ge_subscriber sb
               where sb.subscriber_id = (select co.subscriber_id from OPEN.GE_CONTRATISTA co
                                          where co.id_contratista = contratista)) NIT
            ,tipo
       FROM (
              SELECT contratista
                    ,1 PAIS
                    ,(SELECT d.geo_loca_father_id FROM open.ge_geogra_location d WHERE d.geograp_location_id = localidad) departamento
                    ,localidad
                    ,titr
                    ,DECODE(SIGN(Round(Sum(total))),-1,'C','D') SIGNO
                    ,ABS(Round(Sum(total))) Valor
                    ,(select lg.cuencosto from open.ldci_cugacoclasi lg where lg.cuenclasifi = clasificador) Cta
                    ,clasificador
                    ,null coprfeco
                    ,orden
                    ,acta
                    ,ABS(Round(sum(Total_iva))) Total_iva
                    ,(select sb.identification from open.ge_subscriber sb
                       where sb.subscriber_id = (select co.subscriber_id from OPEN.GE_CONTRATISTA co
                                                  where co.id_contratista = contratista)) NIT
                    ,tipo
         FROM (
              -- ACTA SIN FACTURA
              SELECT
                      tipo
                     ,acta
                     ,titr
                     ,Total
                     ,Total_iva
                     ,clctclco Clasificador
                     ,contratista
                     ,nombre
                     ,null orden
                     ,localidad
              from (
                  select tipo
                        ,acta
                        ,titr
                        ,sum(decode(Nombre, null, 0, total)) Total
                        ,sum(decode(Nombre, null, 0, total_iva)) Total_iva
                        ,clctclco
                        ,contratista
                        ,nombre
                        ,orden, open.LDC_BOORDENES.FNUGETIDLOCALIDAD(orden) Localidad, factura, fecha
              from (
              select tipo, acta, factura, fecha, orden, titr,  sum(total) total,
                     sum(total_iva) total_iva, contratista, nombre, clctclco
              from (
                    SELECT 'ACTA_S_F' TIPO, null product_id,
                           null acta, null  factura, null  fecha,
                           a.id_orden orden, decode(ro.task_type_id, 10336, ro.real_task_type_id, ro.task_type_id) titr,
                           sum(decode(it.items_id, 4001293, 0, a.valor_total)) Total,
                           sum(decode(it.items_id, 4001293, a.valor_total)) Total_IVA,
                           co.id_contratista contratista, ta.nombre_contratista nombre,
                           tt.clctclco
                      FROM OPEN.ge_detalle_acta a, open.ge_acta ac, open.or_order ro,
                           open.or_task_type ot, open.ge_contratista ta, open.ge_contrato co, open.ge_items it, open.ic_clascott tt
                     where ac.id_acta   = a.id_acta
                       and (ac.extern_pay_date is null or ac.extern_pay_date >= dtFechA)
                       and a.id_orden   = ro.order_id
                       and a.valor_total != 0
                       --<< CA-200-2592
                       --and ro.task_type_id !=  10336 -- Tipo de Trabajo Ajustes
                       -->>
                       and decode(ro.task_type_id, 10336, ro.real_task_type_id, ro.task_type_id) = tt.clcttitr
                       and ro.legalization_date <= dtFechF
                       and ro.created_date <= dtFechF
                       and nvl(tt.clctclco,-1) IN (SELECT clcocodi FROM OPEN.ic_clascont
                                                    WHERE ',' || (SELECT casevalo
                                                                    FROM OPEN.ldci_carasewe
                                                                   WHERE casecodi = 'CLASCONT_LECTURA') || ',' LIKE '%,' || clcocodi || ',%')
                       and decode(ro.task_type_id, 10336, ro.real_task_type_id, ro.task_type_id) = ot.task_type_id
                       and ac.id_contrato = co.id_contrato
                       and co.id_contratista = ta.id_contratista  and a.id_items = it.items_id
                       AND (IT.item_classif_id NOT IN (8,21,23) or it.items_id = 4001293)
                    Group by 'ACTA_S_F', null, null, null, null, a.id_orden,
                             decode(ro.task_type_id, 10336, ro.real_task_type_id, ro.task_type_id), co.id_contratista,
                             ta.nombre_contratista, tt.clctclco
                    --
                    --<<
                    -- CA-200-2592
                    -- SE UNIFICA CON LA CONSULTA ANTERIOR
                    /*
                    UNION ALL  -- Ajustes de ordenes de meses anteriores
                    --
                    SELECT 'ACTA_S_F' TIPO, null  product_id,
                           null acta, null factura, null  fecha,
                           a.id_orden orden, decode(ro.task_type_id, 10336, ro.real_task_type_id, ro.task_type_id) titr,
                           sum(decode(it.items_id, 4001293, 0, a.valor_total)) Total,
                           sum(decode(it.items_id, 4001293, a.valor_total)) Total_IVA,
                           co.id_contratista contratista, ta.nombre_contratista nombre,
                           tt.clctclco
                     FROM OPEN.ge_detalle_acta a, open.ge_acta ac, open.or_order ro,
                          open.ic_clascott tt, open.or_task_type ot, open.ge_contratista ta, open.ge_contrato co, open.ge_items it
                    where ac.id_acta   = a.id_acta
                      and (ac.extern_pay_date is null or ac.extern_pay_date >= dtFechA)
                      and a.id_orden   = ro.order_id
                      and a.valor_total != 0
                      and ro.task_type_id =  10336 -- Tipo de Trabajo Ajustes
                      and decode(ro.task_type_id, 10336, ro.real_task_type_id, ro.task_type_id) = tt.clcttitr
                      and ro.legalization_date <= dtFechF
                      and ro.created_date <= dtFechF
                      and nvl(tt.clctclco,-1) IN (SELECT clcocodi
                                                    FROM OPEN.ic_clascont
                                                   WHERE ',' || (SELECT casevalo
                                                                   FROM OPEN.ldci_carasewe
                                                                  WHERE casecodi = 'CLASCONT_LECTURA') || ',' LIKE '%,' || clcocodi || ',%')
                      and decode(ro.task_type_id, 10336, ro.real_task_type_id, ro.task_type_id) = ot.task_type_id
                      and ac.id_contrato = co.id_contrato
                      and co.id_contratista = ta.id_contratista  and a.id_items = it.items_id
                      AND (IT.item_classif_id NOT IN (8,21,23) or it.items_id = 4001293)
                    Group by 'ACTA_S_F', null, null,  null, null, a.id_orden,
                             decode(ro.task_type_id, 10336, ro.real_task_type_id, ro.task_type_id), co.id_contratista,
                             ta.nombre_contratista, tt.clctclco
                    */
                    -- END 200-2592
                    -->>
              )
              Group by tipo, acta, factura, fecha, orden, titr,  contratista, nombre, clctclco
              --
              UNION ALL
              -- ORDENES SIN ACTA
              select tipo, acta, factura, fecha, orden, titr, sum(total) total, sum(total_iva) total_iva,
                     contratista, nombre, clctclco
                from (
              select *
              from (
                     SELECT /*+ INDEX(OR_ORDER IDX_OR_ORDER_017) */ /*+ INDEX(OR_ORDER_ITEMS IDX_OR_ORDER_ITEMS_03) */
                           'SIN_ACTA' TIPO, null product_id,
                           null acta, null factura, null fecha, r.order_id orden,
                           decode(r.task_type_id, 10336, r.real_task_type_id, r.task_type_id) titr,
                           sum(decode(it.items_id, 4001293, 0, value)) Total,
                           sum(decode(it.items_id, 4001293, value)) Total_IVA,
                           decode(ut.contractor_id, null, ut.operating_unit_id, ut.contractor_id) contratista,
                           (select co.nombre_contratista from OPEN.GE_CONTRATISTA co
                             where co.id_contratista =  decode(ut.contractor_id, null, ut.operating_unit_id, ut.contractor_id)) nombre,
                           tt.clctclco
                      FROM open.or_order r, open.ic_clascott tt, open.or_order_items oi, open.or_task_type ot, open.ge_items it, OPEN.OR_OPERATING_UNIT ut
                     where r.legalization_date <= dtFechF
                       and r.created_date <= dtFechF
                       and r.is_pending_liq    IN ('E','Y')
                       and r.order_status_id   =  8
                       and r.causal_id in (select g.causal_id from open.ge_causal g where g.causal_id = r.causal_id and g.class_causal_id = 1)
                       and value               != 0
                       and decode(r.task_type_id, 10336, r.real_task_type_id, r.task_type_id) = tt.clcttitr
                       and nvl(tt.clctclco,-1) IN (SELECT clcocodi
                                                     FROM OPEN.ic_clascont
                                                    WHERE ',' || (SELECT casevalo
                                                                    FROM OPEN.ldci_carasewe
                                                                   WHERE casecodi = 'CLASCONT_LECTURA') || ',' LIKE '%,' || clcocodi || ',%')
                       and r.order_id not in (select a.id_orden from OPEN.ge_detalle_Acta a where a.id_orden = r.order_id)
                       and r.task_type_id = ot.task_type_id
                       and oi.order_id    =  r.order_id
                       and oi.items_id    = it.items_id
                       and (it.item_classif_id NOT IN (8,21,23) or it.items_id = 4001293)
                       and r.operating_unit_id = ut.operating_unit_id
                       and ut.es_externa = 'Y'
                    Group by 'SIN_ACTA', null, null, null, null, r.order_id, decode(r.task_type_id, 10336, r.real_task_type_id, r.task_type_id),
                             tt.clctclco, ut.contractor_id, ut.operating_unit_id
                    UNION
                    SELECT /*+ INDEX(OA IDX_OR_ORDER_ACTIVITY_05) */ /*+ INDEX(OI IDX_OR_ORDER_ITEMS_03) */
                           'SIN_ACTA' TIPO, null product_id, null acta, null factura, null fecha, oa.order_id orden,
                           decode(oa.task_type_id, 10336, r.real_task_type_id,oa.task_type_id) titr,
                           sum(nvl(oa.value_reference * cn.liquidation_sign * nvl((select -1 from open.or_related_order where related_order_id=oa.order_id and RELA_ORDER_TYPE_ID=15),1),0)) Total,
                           nvl(SUM(decode(it.items_id, 4001293, 0)),0) Total_IVA,
                           decode(ut.contractor_id, null, ut.operating_unit_id, ut.contractor_id) contratista,
                           (select co.nombre_contratista from OPEN.GE_CONTRATISTA co
                             where co.id_contratista =  decode(ut.contractor_id, null, ut.operating_unit_id, ut.contractor_id)) nombre,
                           tt.clctclco
                      FROM open.or_order_activity oa, open.mo_packages m, open.or_order_items oi, open.or_order r, open.ic_clascott tt,
                           open.or_task_type ot, open.ge_items it, OPEN.OR_OPERATING_UNIT ut, open.ct_item_novelty cn --, open.or_related_order ro
                     where r.legalization_date <= dtFechF
                       and r.created_date <= dtFechF
                       and r.is_pending_liq    IN ('E','Y')
                       and r.order_status_id   =  8
                       and r.causal_id         IN (select g.causal_id from open.ge_causal g where g.causal_id = r.causal_id and g.class_causal_id = 1)
                       and r.order_id          =  oa.order_id
                       and oa.package_id       =  m.package_id(+)
                       and oa.value_reference !=  0
                       and oi.order_id         =  oa.order_id
                       and ((oa.order_item_id  =  oi.order_items_id and it.item_classif_id = 2) or
                           ((oa.order_Activity_id  =  oi.order_activity_id and it.item_classif_id != 2)))
                       and cn.items_id         = oa.activity_id
                       and decode(oa.task_type_id, 10336, r.real_task_type_id, oa.task_type_id) = tt.clcttitr
                       and nvl(tt.clctclco,-1) IN (SELECT clcocodi
                                                     FROM OPEN.ic_clascont
                                                    WHERE ',' || (SELECT casevalo
                                                                    FROM OPEN.ldci_carasewe
                                                                   WHERE casecodi = 'CLASCONT_LECTURA') || ',' LIKE '%,' || clcocodi || ',%')
                       and oa.order_id not in (select a.id_orden from OPEN.ge_detalle_Acta a where a.id_orden = oa.order_id)
                       and oa.task_type_id = ot.task_type_id
                       and oi.items_id     = it.items_id
                       and (it.item_classif_id NOT IN (8,21,23) or it.items_id = 4001293)
                       and r.operating_unit_id = ut.operating_unit_id
                       and ut.es_externa = 'Y'
                    Group by 'SIN_ACTA', null, null, null, null, oa.order_id, decode(oa.task_type_id, 10336, r.real_task_type_id, oa.task_type_id),
                             tt.clctclco, ut.contractor_id, ut.operating_unit_id
              )
              )
              Group by tipo, acta, factura, fecha, orden, titr, contratista, nombre,clctclco
              ),  open.ic_clascont icc
              where clctclco = icc.clcocodi
              group by tipo,acta,orden, titr, clctclco,icc.clcodesc, contratista, nombre, factura, fecha
              )
              where total != 0
              )
              Group by tipo,acta,titr,Clasificador,contratista,nombre,orden,localidad
          )
          Group by tipo,acta,titr,Clasificador,contratista,orden,localidad,signo,departamento,pais;


    --<<
    -- Cursor para validar si existe periodo de cierre comercial
    -- creado para el a?o y mes indicado
    -->>
    CURSOR cuCierCome
    IS
    SELECT Count(1)
      FROM ldc_ciercome
     WHERE cicoano = nuAnoFin
       AND cicomes = nuMesFin;

    --<<
    -- Cursor para validar si existe foto de provison generada para el a?o mes
    -->>
    CURSOR cuValiProv
    IS
    SELECT COUNT(1)
      FROM ldci_costprov
     WHERE copranoc = nuAnoFin
       AND coprmesc = nuMesFin;

    --<<
    -- Edmundo Lara -- 19/07/2016  CA = 100-10632
    -- Cursor para obterner el nit de la LDC que ejecuta el proceso.
    --
    CURSOR cuSistema
    IS
    SELECT s.sistnitc
      FROM sistema s;

    vsbnit     sistema.sistnitc%type;
    VsbNitLdc  ldci_carasewe.casevalo%type;

    -->>
    --426
    csbEntrega426 open.ldc_versionentrega.codigo_caso%type:='0000426';
    sbAplica426   varchar2(1):='N';
    cursor cuActOTProv2 is
    with clasexcl as(select casevalo from open.ldci_carasewe where casecodi like 'CLASCONT_FNB' and casedese='WS_COSTOS')
        ,clasificador as( select tt.clctclco , tt.clcttitr  from open.ic_clascott tt, open.ic_clascont cl where (select casevalo from clasexcl) || ',' NOT LIKE '%,' || tt.clctclco || ',%' and cl.clcocodi=tt.clctclco)
        , cuenta as(select distinct cl.cuenclasifi, cl.cuencosto cuctcodi from open.ldci_cugacoclasi cl, clasificador c where c.clctclco=cl.cuenclasifi )
        , localidades as (
        select /*+ index( lo IX_GE_GEOGRA_LOCATION06 ) index(de PK_GE_GEOGRA_LOCATION)*/de.geograp_location_id depa, de.description desc_depa, lo.geograp_location_id loca, lo.description desc_loca
        from open.ge_geogra_location lo
        inner join open.ge_geogra_location de on de.geograp_location_id=lo.geo_loca_father_id
        where lo.geog_loca_area_type=3)
        , ordenes as(
        select o.order_id,
               o.task_type_id,
               o.real_task_type_id,
               u.contractor_id,
               c.certificate_id acta,
               a.extern_pay_date,
               sum(decode(i.items_id,4001293,0,d.valor_total)) valor_total,
               sum(decode(i.items_id,4001293,d.valor_total,0)) valor_iva,
               ct.clctclco,
               o.external_address_id,
               (select ac.address_id from open.or_order_Activity ac where ac.order_id=o.order_id and rownum=1)  address_id,
               o.defined_contract_id
        from open.or_order o
        inner join clasificador ct on ct.clcttitr=decode(o.task_type_id,10336, o.real_task_type_id, o.task_type_id)
        inner join open.or_operating_unit u on u.operating_unit_id=o.operating_unit_id  and u.es_externa = 'Y'
        inner join open.ct_order_certifica c on c.order_id=o.order_id
        inner join open.ge_acta a on a.id_Acta=c.certificate_id and (a.extern_pay_date is null or a.extern_pay_date>dtFechA)
        inner join open.ge_detalle_Acta d on d.id_acta=a.id_acta and d.valor_total!=0 and d.id_orden=o.order_id
        inner join open.ge_items i on i.items_id=d.id_items and (i.item_classif_id!=23 or i.items_id=4001293)
        inner join open.ge_causal c on c.causal_id=o.causal_id
        where o.legalization_Date<=dtFechF
          and o.created_date<=dtFechF
          and o.order_status_id=8
        group by o.order_id,
               o.task_type_id,
               o.real_task_type_id,
               u.contractor_id,
               c.certificate_id,
               a.extern_pay_date,
               ct.clctclco,
               o.external_address_id,
               o.defined_contract_id
        union
        select o.order_id,
               o.task_type_id,
               o.real_task_type_id,
               u.contractor_id,
               null acta,
               null fecha_factura,
               sum(decode(oi.out_,'N',-1,1)*oi.value) valor_total,
               0 valor_iva,
               ct.clctclco,
               o.external_address_id,
               (select ac.address_id from open.or_order_Activity ac where ac.order_id=o.order_id and rownum=1)  address_id,
               o.defined_contract_id
        from open.or_order o
        inner join clasificador ct on ct.clcttitr=decode(o.task_type_id,10336, o.real_task_type_id, o.task_type_id)
        inner join open.or_operating_unit u on u.operating_unit_id=o.operating_unit_id  and u.es_externa = 'Y'
        inner join open.or_order_items oi on oi.order_id=o.order_id and oi.value!=0
        inner join open.ge_items i on i.items_id=oi.items_id and i.item_classif_id not in (3,8,21)
        inner join open.ge_causal c on c.causal_id=o.causal_id and c.class_causal_id=1
        where o.legalization_Date<=dtFechF
          and o.created_date<=dtFechF
          and o.order_status_id=8
          and o.is_pending_liq is not null
          and not exists(select null from open.ct_item_novelty n where n.items_id=oi.items_id)
        group by o.order_id,
               o.task_type_id,
               o.real_task_type_id,
               u.contractor_id,
               ct.clctclco,               
               o.external_address_id,
               o.defined_contract_id
        union
        select o.order_id,
               o.task_type_id,
               o.real_task_type_id,
               u.contractor_id,
               null acta,
               null fecha_factura,
               sum(a.value_reference*liquidation_sign*nvl((select -1 from open.or_related_order r where r.related_order_id=o.order_id and r.rela_order_type_id=15), 1)) valor,
               0 valor_iva,
               ct.clctclco,
               o.external_address_id,
               (select ac.address_id from open.or_order_Activity ac where ac.order_id=o.order_id and rownum=1)  address_id,
               o.defined_contract_id
        from open.or_order o
        inner join clasificador ct on ct.clcttitr=decode(o.task_type_id,10336, o.real_task_type_id, o.task_type_id)
        inner join open.or_operating_unit u on u.operating_unit_id=o.operating_unit_id  and u.es_externa = 'Y'
        inner join open.or_order_activity a on a.order_id=o.order_id and a.task_type_id=o.task_type_id and a.final_date is null
        inner join open.ct_item_novelty n on n.items_id=a.activity_id
        inner join open.ge_causal c on c.causal_id=o.causal_id and c.class_causal_id=1
        where o.legalization_Date<=dtFechF
          and o.created_date<=dtFechF
          and o.order_status_id=8
          and o.is_pending_liq is not null
          and exists(select null from open.ct_item_novelty n where n.items_id=a.activity_id)
        group by o.order_id,
               o.task_type_id,
               o.real_task_type_id,
               u.contractor_id,
               ct.clctclco,
               o.external_address_id,
               o.defined_contract_id)     
        select ot.contractor_id contratista,
             1 pais,
             lo.depa departamento,
             lo.loca localidad,
             decode(ot.task_type_id,10336,ot.real_task_type_id,ot.task_type_id) titr, 
             nuAnoFin,
             nuMesFin,
             DECODE(SIGN(Round(ot.valor_total)),-1,'C','D') SIGNO,
             ABS(Round(ot.valor_total)) Valor,
             c.cuctcodi cuenta,
             ot.clctclco clasificador,
             null coprfeco,
             ot.order_id orden,
             ot.acta,
             ABS(Round(ot.valor_iva))  total_iva,
             (select gs.identification from  open.ge_subscriber gs  where gs.subscriber_id=open.dage_contratista.fnugetsubscriber_id(ot.contractor_id, null)) nit,
             case when ot.acta is not null then 'ACTA_S_F' else 'SIN_ACTA' end tipo
        from ordenes ot
        left join open.ab_address di on di.address_id=nvl(ot.external_address_id,ot.address_id)
        left join localidades lo on lo.loca=di.geograp_location_id
        inner join cuenta c on c.cuenclasifi=ot.clctclco;
        
    --426
  BEGIN

    --<< Edmundo Lara -- 19/07/2016  CA = 100-10632
    ldci_pkwebservutils.proCaraServWeb('WS_COSTOS', 'VAL_NIT_SERV_CUMP_GDCA', VsbNitLdc, osbErrorMessage);
    -->>

    ldci_pkInterfazSAP.vaMensError :=  '[fnuFotoProvCost] - Inicia la captura de la foto para la provision de costos';
    LDCI_pkTrazaInterfaces.pRegiMensaje('LF',ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),SYSDATE,USER,USERENV('TERMINAL'));
    
    --426
    if fblaplicaentregaxcaso(csbEntrega426) then
      sbAplica426 :='S';
    else
      sbAplica426 :='N';
    end if;
    --426
        -- Si hay definidas las fechas
    IF  (idafechaini IS NOT NULL AND idafechafin IS NOT NULL) THEN

        -- Manejo de Fechas
        dtFechI := to_date(to_char(trunc(idafechaini),'DD/MM/YYYY')||' 00:00:00','DD/MM/YYYY HH24:MI:SS');
        dtFechF := to_date(to_char(trunc(idafechafin),'DD/MM/YYYY')||' 23:59:59','DD/MM/YYYY HH24:MI:SS');

        --<< EDMLAR CA 200-782
        dtFechA := to_date(to_char(trunc(idafechaAct),'DD/MM/YYYY')||' 23:59:59','DD/MM/YYYY HH24:MI:SS');
        -->>

        --<<
        -- Se obtienen el a?o y el mes de la fecha inicial y final del rango de fechas
        -->>
        nuAnoIni := to_number(to_char(idafechaini,'YYYY'));
        nuAnoFin := to_number(to_char(idafechafin,'YYYY'));
        nuMesIni := to_number(to_char(idafechaini,'MM'));
        nuMesFin := to_number(to_char(idafechafin,'MM'));

        --<<
        -- Se valida que el a?o y el mes de la fecha inicial y final sean iguales
        -->>
        IF (nuAnoIni <> nuAnoFin OR nuMesIni <> nuMesFin) THEN

          ldci_pkInterfazSAP.vaMensError :=  '[fnuFotoProvCost] - El a?o/mes de la fecha inicial no es igual al de la fecha final del rango';
          LDCI_pkTrazaInterfaces.pRegiMensaje('LF',ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),SYSDATE,USER,USERENV('TERMINAL'));
          RETURN(-1);

        END IF;

    --<<
    -- De lo contrario, si las fechas llegan nulas
    -->>
    ELSIF (idafechaini IS NULL AND idafechafin IS NOT NULL) THEN

        --<<
        -- Se setea la fecha final del rango y el a?o/mes
        -->>
        dtFechF := to_date(to_char(trunc(idafechafin),'DD/MM/YYYY')||' 23:59:59','DD/MM/YYYY HH24:MI:SS');
        nuAnoFin := to_number(to_char(idafechafin,'YYYY'));
        nuMesFin := to_number(to_char(idafechafin,'MM'));

        --<< EDMLAR CA 200-782
        dtFechA := to_date(to_char(trunc(idafechaAct),'DD/MM/YYYY')||' 23:59:59','DD/MM/YYYY HH24:MI:SS');
        -->>

    ELSE

        nuAnoFin := to_number(to_char(SYSDATE,'YYYY'));
        nuMesFin := to_number(to_char(SYSDATE,'MM'));

    END IF;

    ldci_pkInterfazSAP.vaMensError :=  '[fnuFotoProvCost] - A?o: '||nuAnoFin||' - Mes: '||nuMesFin;
    LDCI_pkTrazaInterfaces.pRegiMensaje('LF',ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),SYSDATE,USER,USERENV('TERMINAL'));

    --<<
    -- Se valida que el a?o y mes de la fecha inicial tenga periodo de cierre comercial creado
    -->>
    OPEN cuCierCome;
    FETCH cuCierCome INTO nuCantiReg;
    CLOSE cuCierCome;

    IF (nuCantiReg = 0) THEN

      ldci_pkInterfazSAP.vaMensError :=  '[fnuFotoProvCost] - No existe periodo de cierre para el a?o-mes del rango de fechas.';
      LDCI_pkTrazaInterfaces.pRegiMensaje('LF',ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),SYSDATE,USER,USERENV('TERMINAL'));
      RETURN(-1);

    END IF;

    --<<
    -- Se valida que el a?o y mes de la fecha inicial tenga periodo de cierre comercial creado
    -->>
    OPEN cuValiProv;
    FETCH cuValiProv INTO nuCantiReg;
    CLOSE cuValiProv;

    --<<
    -- Si existen datos para el a?o mes se borran.
    -->>
    IF (nuCantiReg > 0) THEN

      DELETE ldci_costprov WHERE copranoc = nuAnoFin AND coprmesc = nuMesFin;
      --<
      -- Edmundo E. Lara -- 19/07/2016  CA = 100-10632
      Commit;
      -->

    END IF;

    --<<
    -- Se valida si existe fecha final para el rango de fechas
    -->>
    IF (dtFechF IS NOT NULL) THEN

       vaFechCont := Trunc(dtFechF);

    ELSE

       vaFechCont := Trunc(SYSDATE);

    END IF;


    
    if sbAplica426 = 'N' then
        ldci_pkInterfazSAP.vaMensError :=  '[fnuFotoProvCost] - Inicia Proceso para Clasificadores diferentes a Lecturas.';
        LDCI_pkTrazaInterfaces.pRegiMensaje('LF',ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),SYSDATE,USER,USERENV('TERMINAL'));
        --<<
        -- Consulta la informmacion a provisionar
        OPEN cuActOTProv;
        LOOP

        FETCH cuActOTProv BULK COLLECT INTO  v_ldci_costprov LIMIT 100 ;

        FORALL i IN 1 .. v_ldci_costprov.COUNT

            INSERT INTO ldci_costprov
            VALUES v_ldci_costprov(i);

            --<
            -- Edmundo E. Lara -- 19/07/2016  CA = 100-10632
            Commit;
            -->

        EXIT WHEN cuActOTProv%NOTFOUND;

        END LOOP;
        COMMIT;
        CLOSE cuActOTProv;


        --<<
        -- Edmundo E. Lara -- 19/07/2016  CA = 100-10632
        -- Consulta la informacion a provisionar de Lecturas si es GDCA

        ldci_pkInterfazSAP.vaMensError :=  '[fnuFotoProvCost] - Inicia Proceso para Clasificadores de Lecturas.';
        LDCI_pkTrazaInterfaces.pRegiMensaje('LF',ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),SYSDATE,USER,USERENV('TERMINAL'));

        OPEN cuSistema;
        FETCH cuSistema INTO vsbnit;
        CLOSE cuSistema;

        If vsbnit = VsbNitLdc then

              OPEN cuActOTProvLec;
              LOOP

              FETCH cuActOTProvLec BULK COLLECT INTO  v_ldci_costprov_l LIMIT 100 ;

              FORALL i IN 1 .. v_ldci_costprov_l.COUNT

                  INSERT INTO ldci_costprov
                  VALUES v_ldci_costprov_l(i);

                  Commit;

              EXIT WHEN cuActOTProvLec%NOTFOUND;

              END LOOP;
              COMMIT;
              CLOSE cuActOTProvLec;

        end if;
        --
        -->>
    else
       ldci_pkInterfazSAP.vaMensError :=  '[fnuFotoProvCost] - Inicia Proceso para Clasificadores';
        LDCI_pkTrazaInterfaces.pRegiMensaje('LF',ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),SYSDATE,USER,USERENV('TERMINAL'));
       OPEN cuActOTProv2;
        LOOP

        FETCH cuActOTProv2 BULK COLLECT INTO  v_ldci_costprov LIMIT 100 ;

        FORALL i IN 1 .. v_ldci_costprov.COUNT

            INSERT INTO ldci_costprov
            VALUES v_ldci_costprov(i);

            Commit;

        EXIT WHEN cuActOTProv2%NOTFOUND;

        END LOOP;
        COMMIT;
        CLOSE cuActOTProv2;
    end if;

    ldci_pkInterfazSAP.vaMensError :=  '[fnuFotoProvCost] - Finaliza la captura de la foto para la provision de costos';
    LDCI_pkTrazaInterfaces.pRegiMensaje('LF',ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),SYSDATE,USER,USERENV('TERMINAL'));

    RETURN 0;

  EXCEPTION
  WHEN OTHERS THEN
       ldci_pkInterfazSAP.vaMensError :=  '[fnuFotoProvCost] - No se proceso la foto provision de costos. '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
       LDCI_pkTrazaInterfaces.pRegiMensaje('LF',ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),SYSDATE,USER,USERENV('TERMINAL'));
       RETURN(-1);
  END fnuFotoProvCost;

  FUNCTION fnuInterActaCostoSAP(  inuactanume      IN ge_acta.id_acta%TYPE,
                                  ivaiclitido      IN ldci_incoliqu.iclitido%TYPE,
                                  idafechaini      IN DATE,
                                  idafechafin      IN DATE
                                )
  RETURN NUMBER IS
  /*****************************************************************************
  Propiedad intelectual Gases de Occidente .
  Function:     fnuInterActActivoSAP
  Descripcion:  Funcion para reportar los Activos-Inversion reportados en un acta al sistema
                SAP.

  NOTA:         Este proceso de intefaz de costos se tomaron los cursores
                actuales que reportan al sistema contable CGUNO.
                Funcion referencia INTERCONTRATOS85AG5(), y
                se extension con el modelo que soporta el sistema SAP

  Parametros de Entrada:
                inuactanume      :Numero del acta
                ivaCodCuentPago  :Cuenta Credito
                ivaDocActicipo   :Documento anticipo
                inuiclitido      :Tipo de comprobante o documento acta
                ivaFactura       :Numero de factura

  Parametros de Salida:
                Ninguno
  Retornos:
                0  No hubo error al ejecutar la funcion.
                -1 Hubo error al ejecutar al funcion.
  Autor:        Heiber Barco
  Fecha:        03-10-2013

  Historia de modificaciones
  Fecha       Autor       Modificacion
  27-08-2015  cgonzalezv  Parametrizacion Items de anticipo y reportar el numero
                          de anticipo en el campo asignacion.

  ******************************************************************************/

     /*
     Cursor de que obtiene los registros contables del acta
     */
  CURSOR cuActas IS
  SELECT gc.id_contratista contratista, gco.id_contrato contrato, ga.id_acta acta, ga.EXTERN_INVOICE_NUM factura, cod_comprobante
  FROM ge_contratista gc ,ge_subscriber  gs, ge_acta ga, ge_contrato gco,
  (SELECT DISTINCT(ldci_pkinterfazsap.fvaGetData(11, DCRCINAD, '|')) nit, (ldci_pkinterfazsap.fvaGetData(42, DCRCINAD, '|')) factura, cod_comprobante
  FROM ic_encoreco, ic_decoreco, ldci_tipointerfaz
 WHERE ECRCCOCO = cod_comprobante
   AND ECRCCONS = dcrcecrc
   AND tipointerfaz = ivaiclitido
   AND Trunc(dcrcfecr) BETWEEN idafechaini AND idafechafin
   AND dcrccuco NOT IN ('A', 'G')) v_acta
 WHERE gc.SUBSCRIBER_ID = gs.SUBSCRIBER_ID
   AND gs.IDENTIFICATION = v_acta.nit
   AND gco.id_contratista = gc.id_contratista
   AND gco.id_contrato = ga.id_contrato
   AND ga.EXTERN_INVOICE_NUM = v_acta.factura
   AND ga.id_acta = Decode(inuactanume, -1, ga.id_acta, inuactanume)
   AND ga.id_acta NOT IN (SELECT idacta
                            FROM ldci_actacont
                           WHERE actcontabiliza = 'S'
                             AND idacta = Decode(inuactanume, -1, ga.id_acta, inuactanume));

  --<<
  --Cursor para obtener la informacion de los impuestos del acta item 23
  -->>
  CURSOR cuInfoActas(inuacta IN ge_acta.id_acta%TYPE) IS
  SELECT dcrccons, dcrcecrc, dcrccorc, dcrccuco cuenta, dcrcsign signos, dcrcvalo valor,
         dcrcinad, dcrcfecr, dcrcclcr, dcrcusua, dcrcterm, dcrcprog, dcrcsist,
         'ACTA-'||acta acta, NIT, clcrclco clasificador, ldci_pkinterfazsap.fvaGetData(46, DCRCINAD, '|') item, contrato
  FROM ic_compgene, ic_encoreco, ic_decoreco,(SELECT gc.id_contratista contratista, gco.id_contrato contrato, ga.id_acta acta,
         ga.EXTERN_INVOICE_NUM factura, gs.identification NIT
  FROM ge_contratista gc ,ge_subscriber  gs, ge_acta ga, ge_contrato gco
 WHERE gc.SUBSCRIBER_ID = gs.SUBSCRIBER_ID
   AND gco.id_contratista = gc.id_contratista
   AND gco.id_contrato = ga.id_contrato
   AND ga.id_acta = inuacta) v_deco, ic_confreco, ic_clascore, ic_clascont, ldci_tipointerfaz
 WHERE COGECOCO = cod_tipocomp
   AND tipointerfaz = Decode(ivaiclitido, ldci_pkinterfazsap.vaInterInversion, tipointerfaz, ivaiclitido)
   AND ECRCCOGE = cogecons
   AND ECRCCONS = dcrcecrc
   AND CORCCOCO = COGECOCO
   AND clcrcons = dcrcclcr
   AND clcrclco = clcocodi
   and CORCCONS = DCRCCORC
   AND ldci_pkinterfazsap.fvaGetData(11, DCRCINAD, '|') = v_deco.nit
   AND ldci_pkinterfazsap.fvaGetData(42, DCRCINAD, '|') = v_deco.factura
   AND ldci_pkinterfazsap.fvaGetData(40, DCRCINAD, '|') in (SELECT item_classif_id
													FROM ge_item_classif
												 WHERE ',' || ldci_pkinterfazsap.vaClasitem23 || ',' LIKE
															 '%,' || item_classif_id || ',%')
   AND dcrccuco <> '-1'
   AND Round(dcrcvalo) <> 0
   AND ldci_pkinterfazsap.fvaGetData(46, DCRCINAD, '|') <> ldci_pkinterfazactas.vaItemIva
   UNION ALL
    --<<
 --Cursor que obtiene los datos de los costos a nivel de detalle de acta para
 --resolver el tema de los items agrupados en decoreco  sin multas.
 -->>

   SELECT null dcrccons, null dcrcecrc, null dcrccorc, Decode(gc.account_classif_id,To_Number(ldci_pkinterfazactas.vaClasifContrato), ldci_pkinterfazactas.vaCuentaL9, ldci_pkinterfazactas.fvaGetCuenClasi(Decode(ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN),0, ot.task_type_id, ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN)))) cuenta,
 decode(sign(SUM(gd.valor_total)), 1, 'D', 'C') signos, (SUM(gd.valor_total)) valor,
'||||||||||'||gs.identification||'|||||'||(select GEO_LOCA_FATHER_ID from ge_geogra_location WHERE GEOGRAP_LOCATION_ID = gd.geograp_location_id)||'|'||gd.geograp_location_id||'||||||||||||||||'||abs(SUM(gd.valor_total))||'||||||'||Decode(ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN),0, ot.task_type_id, ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN))||'|'||gi.item_classif_id||'||'||ga.extern_invoice_num||'||||'||gd.id_items dcrcinad,
  null dcrcfecr, null dcrcclcr, user dcrcusua, null dcrcterm, null dcrcprog, null dcrcsist,
  'ACTA-'||gd.id_acta acta,
  gs.identification nit,
  ldci_pkinterfazactas.fvaGetClasifi(Decode(ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN),0, ot.task_type_id, ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN))) clasificador,
  To_Char(gd.id_items) item, ga.id_contrato contrato
  FROM ge_detalle_acta gd, ge_items gi, OR_ORDER OT, ge_acta ga, ge_contrato gc, ge_contratista gco, ge_subscriber gs
 WHERE gd.id_acta = (inuacta)
   AND gd.id_items = gi.items_id
   AND OT.order_id = GD.ID_ORDEN
   and gd.id_acta = ga.id_acta
   and ga.id_contrato = gc.id_contrato
   and gc.id_contratista = gco.id_contratista
   and gs.subscriber_id = gco.SUBSCRIBER_ID
   AND gi.item_classif_id not in (SELECT item_classif_id
													FROM ge_item_classif
												 WHERE ',' || ldci_pkinterfazsap.vaClasitem23 || ',' LIKE
															 '%,' || item_classif_id || ',%')
   AND ldci_pkinterfazactas.fvaGetClasifi(ot.task_type_id) NOT IN (SELECT clcocodi
													FROM ic_clascont
												 WHERE ',' || ldci_pkinterfazsap.vaClasiIvaRec || ',' LIKE
															 '%,' || clcocodi || ',%')
   AND gd.VALOR_TOTAL <> 0
  -- and ot.task_type_id = 12688
   GROUP BY Decode(ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN),0, ot.task_type_id, ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN)), gd.id_items, gd.geograp_location_id, ot.geograp_location_id, gs.identification, gi.item_classif_id,
   ga.extern_invoice_num, gd.id_acta, ga.id_contrato, gc.account_classif_id

 UNION ALL
    --<<
 --Cursor que obtiene los datos de los costos a nivel de detalle de acta para
 --resolver el tema de los items agrupados en decoreco  solo multas.
 -->>

    SELECT null dcrccons, null dcrcecrc, null dcrccorc, Decode(gc.account_classif_id,To_Number(ldci_pkinterfazactas.vaClasifContrato), ldci_pkinterfazactas.vaCuentaL9, ldci_pkinterfazactas.fvaGetCuenClasi(ot.task_type_id)) cuenta,
 decode(sign(SUM(gd.valor_total)), 1, 'D', 'C') signos, (SUM(gd.valor_total)) valor,
'||||||||||'||gs.identification||'|||||'||(select GEO_LOCA_FATHER_ID from ge_geogra_location WHERE GEOGRAP_LOCATION_ID = gd.geograp_location_id)||'|'||gd.geograp_location_id||'||||||||||||||||'||abs(SUM(gd.valor_total))||'||||||'||ot.task_type_id||'|'||gi.item_classif_id||'||'||ga.extern_invoice_num||'||||'||gd.id_items dcrcinad,
  null dcrcfecr, null dcrcclcr, user dcrcusua, null dcrcterm, null dcrcprog, null dcrcsist,
  'ACTA-'||gd.id_acta acta,
  gs.identification nit,
  ldci_pkinterfazactas.fvaGetClasifi(ot.task_type_id) clasificador,
  To_Char(gd.id_items) item, ga.id_contrato contrato
  FROM ge_detalle_acta gd, ge_items gi, OR_ORDER OT, ge_acta ga, ge_contrato gc, ge_contratista gco, ge_subscriber gs
 WHERE gd.id_acta = (inuacta)
   AND gd.id_items = gi.items_id
   AND OT.order_id = GD.ID_ORDEN
   and gd.id_acta = ga.id_acta
   and ga.id_contrato = gc.id_contrato
   and gc.id_contratista = gco.id_contratista
   and gs.subscriber_id = gco.SUBSCRIBER_ID
   AND gi.item_classif_id not in (SELECT item_classif_id
													FROM ge_item_classif
												 WHERE ',' || ldci_pkinterfazsap.vaClasitem23 || ',' LIKE
															 '%,' || item_classif_id || ',%')
   AND ldci_pkinterfazactas.fvaGetClasifi(ot.task_type_id) IN (SELECT clcocodi
													FROM ic_clascont
												 WHERE ',' || ldci_pkinterfazsap.vaClasiIvaRec || ',' LIKE
															 '%,' || clcocodi || ',%')
   AND gd.VALOR_TOTAL <> 0
  -- and ot.task_type_id = 12688
   GROUP BY ot.task_type_id, gd.id_items, gd.geograp_location_id, ot.geograp_location_id, gs.identification, gi.item_classif_id,
   ga.extern_invoice_num, gd.id_acta, ga.id_contrato, gc.account_classif_id

 UNION ALL
 --<<
 --Cursor para obtener el IVA pleno
 -->>
 SELECT * FROM (
 SELECT null dcrccons, null dcrcecrc, null dcrccorc, ldci_pkinterfazactas.fvaGetCuenClasi(Decode(ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN),0, ot.task_type_id, ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN))) cuenta,
 decode(sign(SUM(nvl((gd.valor_total)*ldci_pkinterfazsap.vaIva/100, 0))), 1, 'D', 'C') signos,
       (SUM(nvl((gd.valor_total)*ldci_pkinterfazsap.vaIva/100, 0))) VALOR,
'||||||||||'||gs.identification||'|||||'||(select GEO_LOCA_FATHER_ID from ge_geogra_location WHERE GEOGRAP_LOCATION_ID = gd.geograp_location_id)||'|'||gd.geograp_location_id||'||||||||||||||||'||(SUM(gd.valor_total))||'||||||'||Decode(ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN),0, ot.task_type_id, ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN))||'|'||gi.item_classif_id||'||'||ga.extern_invoice_num||'||||'||gd.id_items||'|'||'IVA' dcrcinad,
  null dcrcfecr, null dcrcclcr, user dcrcusua, null dcrcterm, null dcrcprog, null dcrcsist,
  'ACTA-'||gd.id_acta acta,
  gs.identification nit,
  ldci_pkinterfazactas.fvaGetClasifi(Decode(ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN),0, ot.task_type_id, ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN))) clasificador,
  To_Char(gd.id_items) item, ga.id_contrato contrato
  FROM ge_detalle_acta gd, ge_items gi, OR_ORDER OT, ge_acta ga, ge_contrato gc, ge_contratista gco, ge_subscriber gs
 WHERE gd.id_acta = (inuacta)
   AND gd.id_items = gi.items_id
   AND OT.order_id = GD.ID_ORDEN
   and gd.id_acta = ga.id_acta
   and ga.id_contrato = gc.id_contrato
   and gc.id_contratista = gco.id_contratista
   and gs.subscriber_id = gco.SUBSCRIBER_ID
   AND gi.item_classif_id not in (SELECT item_classif_id
													FROM ge_item_classif
												 WHERE ',' || ldci_pkinterfazsap.vaClasitem23 || ',' LIKE
															 '%,' || item_classif_id || ',%')
   AND ldci_pkinterfazactas.fvaGetClasifi(Decode(ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN),0, ot.task_type_id, ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN))) in (SELECT CLCOCODI
                          FROM ic_clascont
                         WHERE ',' || ldci_pkinterfazactas.vaClasiIvaVenta || ',' LIKE
                               '%,' || CLCOCODI || ',%')
   AND ldci_pkinterfazactas.fvaGetClasifi(ot.task_type_id) NOT IN (SELECT clcocodi
													FROM ic_clascont
												 WHERE ',' || ldci_pkinterfazsap.vaClasiIvaRec || ',' LIKE
															 '%,' || clcocodi || ',%')
   AND gd.VALOR_TOTAL <> 0
  AND gd.id_acta IN
   (SELECT gdac.id_acta
      FROM ge_detalle_acta gdac
     WHERE gdac.id_acta = gd.id_acta
       AND gdac.id_items = ldci_pkinterfazactas.vaItemIva
       AND gdac.VALOR_TOTAL <> 0)
   GROUP BY ot.task_type_id, gd.id_items, gd.geograp_location_id, ot.geograp_location_id, gs.identification, gi.item_classif_id,
   ga.extern_invoice_num, gd.id_acta, ga.id_contrato, gd.base_value,gc.valor_aui_util,
   Decode(ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN),0, ot.task_type_id, ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN)))
   WHERE VALOR <> 0
UNION ALL
 --<<
 --Cursor para obtener el IVA con AIU
 -->>
 SELECT * FROM (
 SELECT null dcrccons, null dcrcecrc, null dcrccorc, ldci_pkinterfazactas.fvaGetCuenClasi(Decode(ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN),0, ot.task_type_id, ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN))) cuenta,
 decode(sign(SUM(nvl((gd.valor_total)/100, 0))), 1, 'D', 'C') signos,
       Sum(round(((gd.valor_total/(1+((gc.valor_aui_util+gc.valor_aui_admin+gc.valor_aui_imprev)/100))*(gc.valor_aui_util/100)*(ldci_pkinterfazsap.vaIva/100))),3)) VALOR,
'||||||||||'||gs.identification||'|||||'||(select GEO_LOCA_FATHER_ID from ge_geogra_location WHERE GEOGRAP_LOCATION_ID = gd.geograp_location_id)||'|'||gd.geograp_location_id||'||||||||||||||||'||(SUM(gd.valor_total))||'||||||'||Decode(ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN),0, ot.task_type_id, ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN))||'|'||gi.item_classif_id||'||'||ga.extern_invoice_num||'||||'||gd.id_items||'|'||'IVA' dcrcinad,
  null dcrcfecr, null dcrcclcr, user dcrcusua, null dcrcterm, null dcrcprog, null dcrcsist,
  'ACTA-'||gd.id_acta acta,
  gs.identification nit,
  ldci_pkinterfazactas.fvaGetClasifi(Decode(ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN),0, ot.task_type_id, ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN))) clasificador,
  To_Char(gd.id_items) item, ga.id_contrato contrato
  FROM ge_detalle_acta gd, ge_items gi, OR_ORDER OT, ge_acta ga, ge_contrato gc, ge_contratista gco, ge_subscriber gs
 WHERE gd.id_acta = (inuacta)
   AND gd.id_items = gi.items_id
   AND OT.order_id = GD.ID_ORDEN
   and gd.id_acta = ga.id_acta
   and ga.id_contrato = gc.id_contrato
   and gc.id_contratista = gco.id_contratista
   and gs.subscriber_id = gco.SUBSCRIBER_ID
   AND gi.item_classif_id not in (SELECT item_classif_id
													FROM ge_item_classif
												 WHERE ',' || ldci_pkinterfazsap.vaClasitem23 || ',' LIKE
															 '%,' || item_classif_id || ',%')
   AND ldci_pkinterfazactas.fvaGetClasifi(Decode(ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN),0, ot.task_type_id, ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN))) in (SELECT CLCOCODI
                          FROM ic_clascont
                         WHERE ',' || ldci_pkinterfazactas.vaClasiIvaL9 || ',' LIKE
                               '%,' || CLCOCODI || ',%')
   AND ldci_pkinterfazactas.fvaGetClasifi(ot.task_type_id) NOT IN (SELECT clcocodi
													FROM ic_clascont
												 WHERE ',' || ldci_pkinterfazsap.vaClasiIvaRec || ',' LIKE
															 '%,' || clcocodi || ',%')
   AND gd.VALOR_TOTAL <> 0
  AND gd.id_acta IN
   (SELECT gdac.id_acta
      FROM ge_detalle_acta gdac
     WHERE gdac.id_acta = gd.id_acta
       AND gdac.id_items = ldci_pkinterfazactas.vaItemIva
       AND gdac.VALOR_TOTAL <> 0)
   GROUP BY ot.task_type_id, gd.id_items, gd.geograp_location_id, ot.geograp_location_id, gs.identification, gi.item_classif_id,
   ga.extern_invoice_num, gd.id_acta, ga.id_contrato, gd.base_value,gc.valor_aui_util, gc.valor_aui_admin, gc.valor_aui_imprev,
   Decode(ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN),0, ot.task_type_id, ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN)))
   WHERE VALOR <> 0

UNION all
   --<<
   --Cursor para obtener el total de la cuenta por pagar
   -->>
    SELECT  dcrccons, dcrcecrc, dcrccorc, cuenta, Decode(Sign(sum(valor)), -1, 'C', 1, 'D') signos, Abs(sum(valor)) valor,
            NULL dcrcinad, dcrcfecr, dcrcclcr, dcrcusua, dcrcterm, dcrcprog, dcrcsist,
              acta, NIT, clasificador, item, contrato from
    (SELECT NULL dcrccons, NULL dcrcecrc, NULL dcrccorc, '-1' cuenta, dcrcsign signos, Round(Sum(Decode(dcrcsign, 'D', -dcrcvalo, 'C', dcrcvalo)))  valor,
            NULL dcrcinad, null dcrcfecr, null dcrcclcr, dcrcusua, dcrcterm, dcrcprog, dcrcsist,
            'ACTA-'||acta acta, NIT, null clasificador, NULL item,
            NULL depto,
            NULL locali,
            contrato
      FROM ic_compgene, ic_encoreco, ic_decoreco,(SELECT gc.id_contratista contratista, gco.id_contrato contrato, ga.id_acta acta,
            ga.EXTERN_INVOICE_NUM factura, gs.identification NIT
      FROM ge_contratista gc ,ge_subscriber  gs, ge_acta ga, ge_contrato gco
    WHERE gc.SUBSCRIBER_ID = gs.SUBSCRIBER_ID
      AND gco.id_contratista = gc.id_contratista
      AND gco.id_contrato = ga.id_contrato
      AND ga.id_acta = inuacta) v_deco, ic_confreco, ic_clascore, ic_clascont, ldci_tipointerfaz
    WHERE COGECOCO = cod_tipocomp
      AND tipointerfaz = Decode(ivaiclitido, ldci_pkinterfazsap.vaInterInversion, tipointerfaz, ivaiclitido)
      AND ECRCCOGE = cogecons
      AND ECRCCONS = dcrcecrc
      AND CORCCOCO = COGECOCO
      AND clcrcons = dcrcclcr
      AND clcrclco = clcocodi
      and CORCCONS = DCRCCORC
      AND ldci_pkinterfazsap.fvaGetData(11, DCRCINAD, '|') = v_deco.nit
      AND ldci_pkinterfazsap.fvaGetData(42, DCRCINAD, '|') = v_deco.factura
      AND dcrccuco in ('-1', 'G', 'A')
      GROUP BY dcrcecrc, dcrccorc, dcrccuco ,
            dcrcfecr, dcrcusua, dcrcterm, dcrcprog, dcrcsist,dcrcsign,
            'ACTA-'||acta, NIT, contrato
            ORDER BY CUENTA)
    group by dcrccons, dcrcecrc, dcrccorc, cuenta, dcrcinad, dcrcfecr, dcrcclcr, dcrcusua, dcrcterm, dcrcprog, dcrcsist,
              acta, NIT, clasificador, item, contrato;

 --<<
 --Cursor que obtiene los datos del contrato para resolver acta L9
 -->>
  CURSOR cuContrato (inucontrato NUMBER) IS
    SELECT Nvl(account_classif_id,0)
      FROM ge_contrato
     WHERE id_contrato = inucontrato;

 --<<
 --Cursor que obtiene los datos del contrato para resolver acta L9
 -->>
  CURSOR cuActa (inuacta NUMBER) IS
    SELECT Nvl(id_tipo_acta,0)
      FROM ge_acta
     WHERE id_acta = inuacta;

  --<<
  -- CASO 200-72
  -- EDMUNDO LARA 16-03-2016
  -- Curso para obtener el indicador CME que se debe reportar para la amortizacion de anticipos.
  -->>
   CURSOR culdci_contranticipo (inucontrato NUMBER) is
    SELECT l.indicadorcme
      FROM ldci_contranticipo L
     WHERE L.IDCONTRATO = inucontrato;

  -- Private type declarations


  -- Private constant declarations
    nuCantidad       NUMBER:= 0;

  -- Private variable declarations
  nuCount          NUMBER := 0;
  gnuComodin       NUMBER;
  nuRet NUMBER;
  error            EXCEPTION;  -- Manejo de errores en la inserccion de los datos contables en LDCI_INCOLIQU
  vaClave        LDCI_CLAVECONTA.clavcodi%TYPE;
  iovactcaicme    LDCI_CTACADMI.ctcaicme%TYPE;
  iovactcainiv    LDCI_CTACADMI.ctcainiv%TYPE;
  iovaitemindi    LDCI_ITEMCONTA.itemindi%TYPE;
  iovactcatire    LDCI_INTEMINDICA.itemtire%TYPE;
  iovactcainre    LDCI_INTEMINDICA.iteminre%TYPE;
  iovactcaitem    LDCI_INTEMINDICA.itemcate%TYPE;
  iovacuentaiva   LDCI_ITEMCONTA.itemciva%TYPE;
  iovaitemincm    LDCI_CTACADMI.ctcaicme%TYPE;
  nuContratoClas  GE_CONTRATO.id_contrato%TYPE;
  nuTipoActa      GE_ACTA.id_tipo_acta%TYPE;
  sbFechaGen DATE;
  vaCuenta ldci_cuentacontable.cuctcodi%TYPE;
  vaCuentaDiverg ldci_cuentacontable.cuctcodi%TYPE;
  TYPE tyInfoActas IS TABLE OF cuInfoActas%ROWTYPE INDEX BY BINARY_INTEGER;
    vtyInfoActas tyInfoActas;

 BEGIN

     --<<
    -- Parametros de intrefaz
    --<<
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'GRLEDGER', ldci_pkinterfazsap.vaGRLEDGER, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'SOCIEDAD', ldci_pkinterfazsap.vaSOCIEDAD, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CURRENCY', ldci_pkinterfazsap.vaCURRENCY, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CEBE_GENERAL', ldci_pkinterfazactas.gvacebegral, osbErrorMessage);
    ldci_pkInterfazSAP.vaCODINTINTERFAZ:=ivaiclitido;
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CONDIPAGO', ldci_pkinterfazsap.vaCODPAGO, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CUENTA_PARTICULAR', ldci_pkinterfazsap.vaCuentaParticu, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'NOCLASIFIVA', ldci_pkinterfazsap.vaClasiIva, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CLASITEM23', ldci_pkinterfazsap.vaClasitem23, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'AJUSTAINTER', ldci_pkinterfazsap.vaAjustaInte, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'INTERCATEGOR', ldci_pkinterfazsap.vaCategoria, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'ITEMIVA', ldci_pkinterfazactas.vaItemIva, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'IVA', ldci_pkinterfazsap.vaIva, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'AIU', ldci_pkinterfazsap.vaAiu, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'INVERSION', ldci_pkinterfazsap.vaInterInversion, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'ITEMRETEIVA', ldci_pkinterfazsap.vaItemsReteIva, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CLASIFIVAVENTA', ldci_pkinterfazactas.vaClasiIvaVenta, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CLASIFIVAL9', ldci_pkinterfazactas.vaClasiIvaL9, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'NOCLASIFIVAREC', ldci_pkinterfazsap.vaClasiIvaRec, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'VALORETEIVA', ldci_pkinterfazsap.vaReteIva, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'MULTAS', ldci_pkinterfazsap.vaMultas, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CUENTAL9', ldci_pkinterfazactas.vaCuentaL9, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CUENTAL9CR', ldci_pkinterfazactas.vaCuentaL9cr, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CLASIFLEASING', ldci_pkinterfazactas.vaClasifContrato, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'ACTAFACT', ldci_pkinterfazactas.vaTipoActa, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CTACOBFACT', ldci_pkinterfazactas.vaCtaCobFac, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'ENVIAINT', ldci_pkinterfazactas.vaEnviaInt, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'TIPORELATED', ldci_pkinterfazactas.vaTipoRelated, osbErrorMessage);
    ldci_pkinterfazsap.vaGRLEDGER := ldci_pkinterfazactas.fvaGetLibro(ivaiclitido);

    --<<
    -- Aranda 4212, parametro con el Item de anticipo
    -->>
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'ITEMANTICIPO', ldci_pkinterfazactas.gvaitemanticipo, osbErrorMessage);

    --<<
    -- Documento contable que determina el  tipo de acta(costos,activos fijos,fnb)
    -->>
    ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP := ivaiclitido;

    --<<
    -- Borra los datos en memmoria
    -->>


    --<<
    -- Cantidad de registros
    -->>
  begin
    -- Movimientos financieros de cuentas de costos, valor de iva y ajustes como multas.
    FOR rc_cuActas IN cuActas LOOP
    nuCount := nuCount + 1;
   -- Dbms_Output.Put_Line('el acta es '||rc_cuActas.acta);
    --<<
    --Obtencion del  numero de documento
    -->>
    ldci_pkInterfazSAP.nuSeqICLINUDO := ldci_pkInterfazSAP.fnuSeq_ldci_incoliqu;
    ldci_pkInterfazSAP.vaMensError :=  '[fnuInterActaCostoSAP] Acta Numero '||' - '||ldci_pkinterfazsap.vaInterInversion||' - '||rc_cuActas.acta||' '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
    LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),'00',USER,USERENV('TERMINAL'));


    ldci_pkinterfazsap.vaFactura := rc_cuActas.factura;
    ldci_pkinterfazsap.vaActa    := rc_cuActas.acta;
    --DBMS_OUTPUT.PUT_LINE('Identificador InterfazCostos: '||ldci_pkInterfazSAP.nuSeqICLINUDO);


        OPEN cuInfoActas(rc_cuActas.acta);
        FETCH cuInfoActas BULK COLLECT INTO vtyInfoActas;
        CLOSE cuInfoActas;

      IF (vtyInfoActas.count > 0) THEN

          FOR i IN vtyInfoActas.First..vtyInfoActas.Last LOOP
          vaDiverge := 'N';
          vaClave := NULL;
          vaCuenta := NULL;
          vaCuentaDiverg := NULL;
          iovaitemindi := NULL;
          iovaitemincm := NULL;
          ldci_pkinterfazsap.vaCentBen := NULL;
          ldci_pkinterfazsap.vaNit := NULL;
          ldci_pkinterfazsap.vaNitAnti := NULL;
          ldci_pkinterfazsap.vaSigno := NULL;
          ldci_pkinterfazsap.vaActaFact := NULL;
          iovactcatire := NULL;
          iovactcainre := NULL;
          iovactcaitem := NULL;
          iovacuentaiva := NULL;
        --  Dbms_Output.Put_Line('la cuenta es '||vtyInfoActas(i).cuenta);
         -- Dbms_Output.Put_Line('Valor parametro '||ldci_pkinterfazsap.vaCuentaParticu);

         ldci_pkinterfazsap.vaSigno := vtyInfoActas(i).signos;
         IF vtyInfoActas(i).cuenta NOT LIKE  '%,' ||ldci_pkinterfazsap.vaCuentaParticu|| ',%' THEN
            nuRet := ldci_pkinterfazsap.fnuValidaCuenta(vtyInfoActas(i).cuenta);
          --  Dbms_Output.Put_Line('la cuenta retorna  '||nuRet);

            IF nuRet = -1 THEN
            LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
            RAISE error;
            END IF;
         END IF;

              IF  vtyInfoActas(i).cuenta = 'G' THEN
                  iovaitemincm := 'G';
                  vaCuenta := vtyInfoActas(i).nit;
                  vaClave := '39';
                  ldci_pkinterfazsap.vaCentBen := ldci_pkinterfazactas.gvacebegral;
                  ldci_pkinterfazsap.vaNit := vtyInfoActas(i).nit;

              --27-08-215 cgonzalez aranda 4212
              ELSIF  (','||ldci_pkinterfazactas.gvaitemanticipo||',' LIKE '%,' ||NVL(vtyInfoActas(i).item,0)|| ',%') THEN

                      --<<
                      -- CASO 200-72
                      -- EDMUNDO LARA 16-03-2016
                      --
                      OPEN culdci_contranticipo(vtyInfoActas(i).contrato);
                      FETCH culdci_contranticipo INTO iovaitemincm;
                      CLOSE culdci_contranticipo;
                      --
                      --iovaitemincm := 'A';
                      -- >>

                      vaClave := '39';
                      ldci_pkinterfazsap.vaNit := vtyInfoActas(i).nit;
                      ldci_pkinterfazsap.vaCentBen := ldci_pkinterfazactas.gvacebegral;
                      ldci_pkinterfazsap.vaNitAnti := ldci_pkinterfazactas.fvaGetAnticipo(vtyInfoActas(i).contrato);
                      vaCuenta := ldci_pkinterfazsap.vaNitAnti;
              IF ldci_pkinterfazsap.vaNit = '-1' THEN
              ldci_pkinterfazsap.vaNit := NULL;
              END IF;
              --<<
              --se obtiene el codigo del anticipo xxxxx
              -->>


              ELSIF vtyInfoActas(i).cuenta = '-1' THEN

                OPEN cuContrato (vtyInfoActas(i).contrato);
                FETCH cuContrato INTO nuContratoClas;
                CLOSE cuContrato;

                IF (To_Char(nuContratoClas) = ldci_pkinterfazactas.vaClasifContrato) THEN

                vaCuenta := ldci_pkinterfazactas.vaCuentaL9cr;
                vaClave := ldci_pkInterfazSAP.fvaGetClaveConta(vaCuenta, vtyInfoActas(i).signos,  iovactcaicme, iovactcainiv);
                ldci_pkinterfazsap.vaCentBen := ldci_pkinterfazactas.gvacebegral;
                ldci_pkinterfazsap.vaNit := vtyInfoActas(i).nit;

                ELSE

                vaClave := '31';

                --<<
               --se obtiene la cuenta por pagar
               -->>
               vaCuentaDiverg := ldci_pkinterfazactas.fvaGetCuenTipoContrato(ldci_pkinterfazactas.fnuGetTipoContrato(vtyInfoActas(i).contrato));

               vaClave := ldci_pkInterfazSAP.fvaGetClaveConta(vaCuentaDiverg, vtyInfoActas(i).signos,  iovactcaicme, iovactcainiv);
               vaCuenta := vtyInfoActas(i).nit;
               ldci_pkinterfazsap.vaCentBen := ldci_pkinterfazactas.gvacebegral;
               ldci_pkinterfazsap.vaNit := vtyInfoActas(i).nit;

               END IF;

               OPEN cuActa(rc_cuActas.acta);
               FETCH cuActa INTO ldci_pkinterfazsap.vaActaFact;
               CLOSE cuActa;
               LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),'00',USER,USERENV('TERMINAL'));
               IF ldci_pkinterfazsap.vaActaFact = ldci_pkinterfazactas.vaTipoActa THEN

                vaCuentaDiverg := ldci_pkinterfazactas.vaCtaCobFac;
                vaClave := ldci_pkInterfazSAP.fvaGetClaveConta(vaCuentaDiverg, vtyInfoActas(i).signos,  iovactcaicme, iovactcainiv);
                ldci_pkinterfazsap.vaCentBen := ldci_pkinterfazactas.gvacebegral;
                ldci_pkinterfazsap.vaNit := vtyInfoActas(i).nit;

               END IF;


              ELSE



              ldci_pkinterfazsap.vaNit := vtyInfoActas(i).nit;
              vaCuenta := vtyInfoActas(i).cuenta;
              --<<
              --obtiene la clave contable a partir de la cuenta
              -->>
              vaClave := ldci_pkInterfazSAP.fvaGetClaveConta(vtyInfoActas(i).cuenta, vtyInfoActas(i).signos,  iovactcaicme, iovactcainiv);
              nuRet := ldci_pkinterfazactas.fvaGetIndicadore(vtyInfoActas(i).item, vtyInfoActas(i).clasificador, iovactcatire, iovactcainre, iovactcaitem);
              nuRet := ldci_pkinterfazactas.fvaGetIndiva(vtyInfoActas(i).item, iovaitemindi, iovacuentaiva);

            IF ldci_pkinterfazsap.fvaGetData(47,vtyInfoActas(i).dcrcinad,'|') = 'IVA'  THEN

                  --<<
                  --Asigna la cuenta del iva
                  -->>
                  IF iovacuentaiva IS NOT NULL THEN
                  vaCuenta := iovacuentaiva;
                  END IF;
            END IF;


              IF iovactcaitem = 'G' THEN
              ldci_pkinterfazsap.vaCentBen := ldci_pkinterfazactas.gvacebegral;
              END IF;

              vaDiverge := ldci_pkinterfazsap.fnuCtaDiver(vaClave);




              IF vaDiverge = 'S' THEN

              vaCuenta :=  vtyInfoActas(i).nit;
              vaCuentaDiverg := vtyInfoActas(i).cuenta;

              END IF;


            END IF;

            ldci_pkInterfazSAP.vaMensError :=  '[fnuInterActaCostoSAP] Arma la trama '||' - '||ldci_pkInterfazSAP.nuSeqICLINUDO||' '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
            LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),'00',USER,USERENV('TERMINAL'));

            nuRet := ldci_pkinterfazsap.fnuLDCI_INCOLIQUACTA(ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,
                                                  ldci_pkInterfazSAP.nuSeqICLINUDO,
                                                  sysdate,
                                                  user,
                                                  'SERVER',
                                                  sysdate,
                                                  null,
                                                  vaClave,
                                                  vaCuenta,--cuenta,
                                                  iovaitemincm,--null,
                                                  vtyInfoActas(i).VALOR,
                                                  vtyInfoActas(i).VALOR,
                                                  iovaitemindi,
                                                  null,
                                                  vtyInfoActas(i).acta,
                                                  null,
                                                  null,
                                                  null,
                                                  null,
                                                  iovactcatire,
                                                  iovactcainre,
                                                  null,
                                                  i,
                                                  vaCuentaDiverg,
                                                  vtyInfoActas(i).dcrcinad,
                                                  rc_cuActas.cod_comprobante);

            END LOOP;

            nuRet := ldci_pkInterfazSAP.fnuINSELDCI_INCOLIQU;
            --<<
            --Genera la informacion de los documentos para SAP de la interfaz de INGRESOS
            -->>
            --<<
          --Se lanza la Exepcion
          -->>
          IF (nuRet <> 0) THEN
              RAISE ERROR;
          END IF;
            ldci_pkInterfazSAP.vaMensError :=  '[fnuInterActaCostoSAP] Arma encabezado '||' - '||ldci_pkInterfazSAP.nuSeqICLINUDO||' '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
            LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),'00',USER,USERENV('TERMINAL'));

            nuRet := ldci_pkInterfazSAP.fnuGeneDocuSapActa(ldci_pkInterfazSAP.nuSeqICLINUDO);

            --<<
          --Se lanza la Exepcion
          -->>
          IF (nuRet <> 0) THEN
              LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
              RAISE ERROR;
          END IF;

         --<<
         --Se realiza el ajuste de la intrerfaz en caso que este descuadrada
         -->>

         nuRet := ldci_pkinterfazsap.fnuAjusteInterCont(ldci_pkInterfazSAP.nuSeqICLINUDO);

         --Dbms_Output.Put_Line('valido ajuste '||ldci_pkInterfazSAP.nuSeqICLINUDO);

          --<<
          --Se lanza la Exepcion
          -->>
          IF (nuRet <> 0) THEN
              LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
              RAISE ERROR;
          END IF;

          IF ldci_pkinterfazsap.vaActaFact = ldci_pkinterfazactas.vaTipoActa THEN

          nuRet := ldci_pkinterfazactas.fnuActualizaFact(ldci_pkInterfazSAP.nuSeqICLINUDO);

          --<<
          --Se lanza la Exepcion
          -->>
          IF (nuRet <> 0) THEN
              LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
              RAISE ERROR;
          END IF;

          END IF;

         --<<
         --Si es satifactorio todo el proceso, se realiza el envio a SAP
         -->>
            ldci_pkInterfazSAP.vaMensError :=  '[fnuInterActaCostoSAP] Envio la trama '||' - '||ldci_pkInterfazSAP.nuSeqICLINUDO||' '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
            LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),'00',USER,USERENV('TERMINAL'));


       IF (ldci_pkinterfazactas.vaEnviaInt = 'S') THEN


            ldci_pkintercontablemesa.proEnviaDocContable(ldci_pkInterfazSAP.nuSeqICLINUDO);

            ldci_pkInterfazSAP.vaMensError :=  '[fnuInterActaCostoSAP] registro el actacont '||' - '||ldci_pkInterfazSAP.nuSeqICLINUDO||' '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
            LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),'00',USER,USERENV('TERMINAL'));



         END IF; --no envia la interfaz en caso de estar deshabilitado.

         nuRet := ldci_pkinterfazactas.fnuInsHistAct(inucodacta     => ldci_pkinterfazsap.vaActa,
                                                  inucodocont   => ldci_pkInterfazSAP.nuSeqICLINUDO,
                                                  ivatipdocont   => ldci_pkInterfazSAP.vaCODINTINTERFAZ,
                                                  ivausuario      => USER,
                                                  idtfechcontabil => SYSDATE
                                                );
          -- Validacion si se inserto historia contable
          IF (nuRet <> 0) THEN
              LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
              RAISE Error;
          END IF;

      END IF;
     --<<
     --Inserta los datos en la tabla LDCI_INCOLIQU
     -->>

                 nuCantidad := nuCantidad + 1;

    END LOOP;

   IF nuCount = 0 THEN
   ldci_pkInterfazSAP.vaMensError := 'No hay Actas a Procesar';
   LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,USER,USERENV('TERMINAL'));
   END IF;

   EXCEPTION
   WHEN error THEN ldci_pkInterfazSAP.vaMensError :=  '[fnuInterActaCostoSAP] - No se proceso la interfaz de costos. '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
   LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
   END; --END BEGIN
      if (nuRet <> 0) then
             raise Error;
      end if;
      RETURN 0;

   exception
  when others then
       ldci_pkInterfazSAP.vaMensError :=  '[fnuInterActaCostoSAP] - No se proceso la interfaz de costos. '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
       LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,USER,USERENV('TERMINAL'));
       return(-1);
 END fnuInterActaCostoSAP;

  FUNCTION fnuInterCostoSAP(inuactanume      IN ge_acta.id_acta%TYPE,
                            ivaiclitido      IN ldci_incoliqu.iclitido%TYPE,
                            idafechaini      IN DATE,
                            idafechafin      IN DATE)
  RETURN NUMBER IS
  /*****************************************************************************
  Propiedad intelectual Gases de Occidente .

  FUNCTION:     fnuInterCostoSAP
  AUTOR:        Diego Andres Cardona Garcia
  FECHA:        01-07-2014

  DESCRIPCION:  Copia de la funcion: fnuInterActaCostoSAP

                Funcion para reportar los Activos-Inversion reportados en un acta al sistema
                SAP.

  NOTA:         Este proceso de intefaz de costos se tomaron los cursores
                actuales que reportan al sistema contable CGUNO.
                Funcion referencia INTERCONTRATOS85AG5(), y
                se extension con el modelo que soporta el sistema SAP

  Parametros de Entrada:
                inuactanume      :Numero del acta
                ivaCodCuentPago  :Cuenta Credito
                ivaDocActicipo   :Documento anticipo
                inuiclitido      :Tipo de comprobante o documento acta
                ivaFactura       :Numero de factura

  Parametros de Salida:
                Ninguno
  Retornos:
                0  No hubo error al ejecutar la funcion.
                -1 Hubo error al ejecutar al funcion.

  Historia de modificaciones
  Autor    Fecha       Descripcion
  Mmejia   03-07-2015     SAO.329776 Se modifica la consulta para que obtenga el
                          nit por medio del codigo del contrato correctamente.
  edmlar   31-07-2017     CA-2001310
                          Se corrige la funcin FnuFotoProvCost, foto de la provision de costos para que en la consulta de
                          ordenes sin acta valide que la causal de legalizacion sea de Exito.
                          Se corrige la funcion fnuInterCostoSAP para validar el item = 102005 Entrega de anticipo
                          para que envie la clave 29 en vez de la 39.
  Horbath  26-04-2019     CA-200-2602, unificado con el CA-200-2593
                          1.- Eliminar para EFIGAS el envio de la clave 70 en la CLASECTA like '243695%'
                          2.- Dejar como antes del CA-200-1301 donde se hacia el cuadre de la interfaz
                              y al final en la funcion FnuActualizaFact cambiar la clave 50 a 70
                              de la CLASECTA like '243695%' y eliminar los registros donde la
                              CLASECTA LIKE '1422020%', esto con el fin de que la interfaz suba cuadrada.

  Horbath  09-05-2019     CA-200-2529
                          1.- Interfaz de actas, Reportar el IVA mayor valor de los activos a la cuenta 51
                          2.- Interfaz de Materiales, Reportar el IVA mayor valor de los activos a la cuenta 51

  EDMLAR   25/05/2019     CA-200-2652
                          Se modifica la clave de la cuenta de IVA para las actas LB, debe ser la misma que la del ingreso
                          porque es un mayor valor a la cuenta por cobrar.

  Horbath  21/06/2021     CA-376 Distribucion del costo de generacion de factura y reparto de factura, entre GAS y FNB.
                          Porcentaje Generacion FNB 10%
                          Porcentaje Reparto FNB 14%

  01-04-2024 GDGuevara    OSF-2174
                          fnuInterCostoSAP: Se modifica el cursor cuActas, se cambia la restriccion de la 
                          consulta de la fecha de IC_DECORECO.dcrcfecr por IC_ENCORECO.ecrcfech para poder
                          usar el indice IX_IC_ENCORECO02 que tiene esta tabla por la fecha.

  EDMLAR   22/04/2025     OSF-4197
                          Se obtiene el CEBE de los registros con items de RETEICA a partir de la tabla LDC_PARAMETROS_ICA,
                          esto con el fin de evitar que se dupliquen los registros con cuenta contable, tipos de indicadores e 
                          indicadores iguales pero con CEBE diferente.
                          Se crea el cursor cuCebeIca
  ******************************************************************************/

     /*
     Cursor de que obtiene los registros contables del acta
     */
  CURSOR cuActas IS
  SELECT gc.id_contratista contratista, gco.id_contrato contrato, ga.id_acta acta,
         ga.EXTERN_INVOICE_NUM factura, cod_comprobante, ga.id_tipo_acta, ga.numero_fiscal
  FROM ge_contratista gc ,ge_subscriber  gs, ge_acta ga, ge_contrato gco,
       (SELECT DISTINCT(ldci_pkinterfazsap.fvaGetData(11, DCRCINAD, '|')) nit, 
               ldci_pkinterfazsap.fvaGetData(42, DCRCINAD, '|') factura, 
               cod_comprobante
        FROM ic_encoreco, ic_decoreco, ldci_tipointerfaz
        WHERE ecrccoco = cod_comprobante
          AND ecrcfech BETWEEN idafechaini AND idafechafin
          AND dcrcecrc = ecrccons
          AND dcrccuco NOT IN ('A', 'G') 
          AND tipointerfaz = ivaiclitido
        ) v_acta
 WHERE gc.SUBSCRIBER_ID = gs.SUBSCRIBER_ID
   AND gs.IDENTIFICATION = v_acta.nit
   AND gco.id_contratista = gc.id_contratista
   AND gco.id_contrato = ga.id_contrato
   AND ga.EXTERN_INVOICE_NUM = v_acta.factura
   AND ga.id_acta = Decode(inuactanume, -1, ga.id_acta, inuactanume)
   AND ga.id_acta NOT IN (SELECT idacta
                            FROM ldci_actacont
                           WHERE actcontabiliza = 'S'
                             AND idacta = Decode(inuactanume, -1, ga.id_acta, inuactanume));

  --<<
  --Cursor para obtener la informacion de los impuestos del acta item 23
  -->>
  CURSOR cuInfoActas(inuacta IN ge_acta.id_acta%TYPE) IS
  --<<
  --Cursor 1
  -->>
  SELECT dcrccons, dcrcecrc, dcrccorc, dcrccuco cuenta, dcrcsign signos, dcrcvalo valor,
         dcrcinad, dcrcfecr, dcrcclcr, dcrcusua, dcrcterm, dcrcprog, dcrcsist,
         'ACTA-'||acta acta, NIT, clcrclco clasificador, ldci_pkinterfazsap.fvaGetData(46, DCRCINAD, '|') item, contrato
  FROM ic_compgene, ic_encoreco, ic_decoreco,(SELECT gc.id_contratista contratista, gco.id_contrato contrato, ga.id_acta acta,
         ga.EXTERN_INVOICE_NUM factura, gs.identification NIT
  FROM ge_contratista gc ,ge_subscriber  gs, ge_acta ga, ge_contrato gco
 WHERE gc.SUBSCRIBER_ID = gs.SUBSCRIBER_ID
   AND gco.id_contratista = gc.id_contratista
   AND gco.id_contrato = ga.id_contrato
   AND ga.id_acta = inuacta) v_deco, ic_confreco, ic_clascore, ic_clascont, ldci_tipointerfaz
 WHERE COGECOCO = cod_tipocomp
   AND tipointerfaz = Decode(ivaiclitido, ldci_pkinterfazsap.vaInterInversion, tipointerfaz, ivaiclitido)
   AND ECRCCOGE = cogecons
   AND ECRCCONS = dcrcecrc
   AND CORCCOCO = COGECOCO
   AND clcrcons = dcrcclcr
   AND clcrclco = clcocodi
   and CORCCONS = DCRCCORC
   AND ldci_pkinterfazsap.fvaGetData(11, DCRCINAD, '|') = v_deco.nit
   AND ldci_pkinterfazsap.fvaGetData(42, DCRCINAD, '|') = v_deco.factura
   AND ldci_pkinterfazsap.fvaGetData(40, DCRCINAD, '|') in (SELECT item_classif_id
													FROM ge_item_classif
												 WHERE ',' || ldci_pkinterfazsap.vaClasitem23 || ',' LIKE
															 '%,' || item_classif_id || ',%')
   AND dcrccuco <> '-1'
   AND Round(dcrcvalo) <> 0
  -- AND ldci_pkinterfazsap.fvaGetData(46, DCRCINAD, '|') = 100002262
   AND ldci_pkinterfazsap.fvaGetData(46, DCRCINAD, '|') <> ldci_pkinterfazactas.vaItemIva
   UNION ALL
   --<<
   --Cursor 2
   --Cursor que obtiene los datos de los costos a nivel de detalle de acta para
   --resolver el tema de los items agrupados en decoreco  sin multas.
   -->>
   SELECT NULL dcrccons, NULL dcrcecrc, NULL dcrccorc,
          Decode(gc.account_classif_id, To_Number(ldci_pkinterfazactas.vaClasifContrato),ldci_pkinterfazactas.vaCuentaL9,
                                        To_Number(ldci_pkinterfazactas.gvaClasifContRedTerc),ldci_pkinterfazactas.gvaCuentacontRedTerc,
                                        ldci_pkinterfazactas.fvaGetCuGaCoClasi(GD.ID_ORDEN)) cuenta,
          Decode(sign(SUM(gd.valor_total)), 1, 'D', 'C') signos, (SUM(gd.valor_total)) valor,
          '||||||||||'||gs.identification||'|||||'||(SELECT geo_loca_father_id
                                                       FROM ge_geogra_location
                                                      WHERE geograp_location_id = gd.geograp_location_id)
          ||'|'||gd.geograp_location_id||'||||||||||||||||'||abs(SUM(gd.valor_total))||'||||||'
          ||Decode(ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN),0, ot.task_type_id,
                   ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN))
          ||'|'||gi.item_classif_id||'||'||ga.extern_invoice_num||'||||'||gd.id_items||'||'||
          ldci_pkinterfazactas.fvaGetTitrCoGa(GD.ID_ORDEN)||'|'||GD.ID_ORDEN dcrcinad,
          NULL dcrcfecr, NULL dcrcclcr, USER dcrcusua, NULL dcrcterm, NULL dcrcprog, NULL dcrcsist,
          'ACTA-'||gd.id_acta acta,

          Decode(gc.account_classif_id,To_Number(ldci_pkinterfazactas.gvaClasifContRedTerc),ldci_pkinterfazactas.fnuGetNitRedTerc(ga.id_contrato),
                                       gs.identification) nit,

          ldci_pkinterfazactas.fvaGetClasifi(Decode(ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN), 0,
                                                    ot.task_type_id, ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN))) clasificador,
          To_Char(gd.id_items) item, ga.id_contrato contrato
     FROM ge_detalle_acta gd, ge_items gi, OR_ORDER OT, ge_acta ga, ge_contrato gc, ge_contratista gco, ge_subscriber gs
    WHERE gd.id_acta = (inuacta)
      AND gd.id_items = gi.items_id
      AND OT.order_id = GD.ID_ORDEN
      AND gd.id_acta = ga.id_acta
      AND ga.id_contrato = gc.id_contrato
      AND gc.id_contratista = gco.id_contratista
      AND gs.subscriber_id = gco.SUBSCRIBER_ID
      AND gi.item_classif_id not in (SELECT item_classif_id
                                       FROM ge_item_classif
                                      WHERE ',' || ldci_pkinterfazsap.vaClasitem23 || ',' LIKE
                                             '%,' || item_classif_id || ',%')
      AND ldci_pkinterfazactas.fvaGetClasifi(ot.task_type_id)
          NOT IN (SELECT clcocodi FROM ic_clascont
                   WHERE ',' || ldci_pkinterfazsap.vaClasiIvaRec || ',' LIKE '%,' || clcocodi || ',%')
      AND gd.valor_total <> 0
      -- and ot.task_type_id = 12688
    GROUP BY Decode(ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN), 0, ot.task_type_id,
             ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN)), gd.id_items, gd.geograp_location_id,
             ot.geograp_location_id, gs.identification, gi.item_classif_id, ga.extern_invoice_num,
             gd.id_acta, ga.id_contrato, gc.account_classif_id, ldci_pkinterfazactas.fvaGetCuGaCoClasi(gd.id_orden),
             ldci_pkinterfazactas.fvaGetTitrCoGa(GD.ID_ORDEN), GD.ID_ORDEN

   UNION ALL
   --<<
   --Cursor 3
   --Cursor que obtiene los datos de los costos a nivel de detalle de acta para
   --resolver el tema de los items agrupados en decoreco  solo multas.
   -->>
   SELECT NULL dcrccons, NULL dcrcecrc, NULL dcrccorc,
          --<<
          --Mmejia
          --SAO.329776
          --Se modifica para que las multas tenga la cuenta por medio de la orden
          --Decode(gc.account_classif_id, To_Number(ldci_pkinterfazactas.vaClasifContrato),ldci_pkinterfazactas.vaCuentaL9,
          --                              To_Number(ldci_pkinterfazactas.gvaClasifContRedTerc),ldci_pkinterfazactas.gvaCuentacontRedTerc,
          --                              ldci_pkinterfazactas.fvaGetCuGaCoClasi(gd.id_orden)) cuenta,
          ldci_pkinterfazactas.fvaGetCuGaCoClasi(gd.id_orden) cuenta,
   decode(sign(SUM(gd.valor_total)), 1, 'D', 'C') signos, (SUM(gd.valor_total)) valor,
  '||||||||||'||gs.identification||'|||||'||(SELECT GEO_LOCA_FATHER_ID
                                               FROM ge_geogra_location
                                              WHERE GEOGRAP_LOCATION_ID = gd.geograp_location_id)||'|'||
                                                    gd.geograp_location_id||'||||||||||||||||'||
                                                    abs(SUM(gd.valor_total))||'||||||'||ot.task_type_id||
                                                    '|'||gi.item_classif_id||'||'||ga.extern_invoice_num||
                                                    '||||'||gd.id_items||'||'||ldci_pkinterfazactas.fvaGetTitrCoGa(GD.ID_ORDEN)||
                                                    '|'||GD.ID_ORDEN dcrcinad,
    null dcrcfecr, null dcrcclcr, user dcrcusua, null dcrcterm, null dcrcprog, null dcrcsist,
    'ACTA-'||gd.id_acta acta,

    --<<
    --Mmejia
    --SAO.329776
    --Se modifica para que las multas tenga la identificacino del contratista
    --sin discriminar si el contrato es tipo Red de tercero
    --Decode(gc.account_classif_id,To_Number(ldci_pkinterfazactas.gvaClasifContRedTerc),ldci_pkinterfazactas.fnuGetNitRedTerc(ga.id_contrato),
    --                             gs.identification) nit,
    gs.identification nit,

    ldci_pkinterfazactas.fvaGetClasifi(ot.task_type_id) clasificador,
    To_Char(gd.id_items) item, ga.id_contrato contrato
    FROM ge_detalle_acta gd, ge_items gi, OR_ORDER OT, ge_acta ga, ge_contrato gc, ge_contratista gco, ge_subscriber gs
   WHERE gd.id_acta = (inuacta)
     AND gd.id_items = gi.items_id
     AND OT.order_id = GD.ID_ORDEN
     and gd.id_acta = ga.id_acta
     and ga.id_contrato = gc.id_contrato
     and gc.id_contratista = gco.id_contratista
     and gs.subscriber_id = gco.SUBSCRIBER_ID
     AND gi.item_classif_id not in (SELECT item_classif_id
                            FROM ge_item_classif
                           WHERE ',' || ldci_pkinterfazsap.vaClasitem23 || ',' LIKE
                                 '%,' || item_classif_id || ',%')
     AND ldci_pkinterfazactas.fvaGetClasifi(ot.task_type_id) IN (SELECT clcocodi
                            FROM ic_clascont
                           WHERE ',' || ldci_pkinterfazsap.vaClasiIvaRec || ',' LIKE
                                 '%,' || clcocodi || ',%')
     AND gd.VALOR_TOTAL <> 0
    -- and ot.task_type_id = 12688
     GROUP BY ot.task_type_id, gd.id_items, gd.geograp_location_id, ot.geograp_location_id, gs.identification, gi.item_classif_id,
     ga.extern_invoice_num, gd.id_acta, ga.id_contrato, gc.account_classif_id, gd.id_orden, ldci_pkinterfazactas.fvaGetTitrCoGa(GD.ID_ORDEN)

 UNION ALL
--<<
--Cursor 4
--cursor que obtiene el IVA
-->>
--<<
--heiberb 18-02-2015 se posiciona el cugacoclasi del group by
-->>
 SELECT NULL dcrccons, NULL dcrcecrc, NULL dcrccorc,
        Decode(gc.account_classif_id, To_Number(ldci_pkinterfazactas.vaClasifContrato),ldci_pkinterfazactas.vaCuentaL9,
                                      To_Number(ldci_pkinterfazactas.gvaClasifContRedTerc),ldci_pkinterfazactas.gvaCuentacontRedTerc,
                                      ldci_pkinterfazactas.fvaGetCuGaCoClasi(GD.ID_ORDEN)) cuenta,
        decode(sign(SUM(gd.valor_total)), 1, 'D', 'C') signos, (SUM(gd.valor_total)) valor,
        '||||||||||'||gs.identification||'|||||'||(SELECT geo_loca_father_id FROM ge_geogra_location
                                                    WHERE geograp_location_id = gd.geograp_location_id)
        ||'|'||gd.geograp_location_id||'||||||||||||||||'||abs(SUM(gd.base_value))||'||||||'||
        Decode(ldci_pkinterfazactas.fnuGetTipoTrab(gd.id_orden),0, ot.task_type_id,
               ldci_pkinterfazactas.fnuGetTipoTrab(gd.id_orden))||'|'||gi.item_classif_id
        ||'||'||ga.extern_invoice_num||'||||'||gd.id_items||'|'||'IVA|'||
        ldci_pkinterfazactas.fvaGetTitrCoGa(GD.ID_ORDEN)||'|'||GD.ID_ORDEN dcrcinad,
        null dcrcfecr, null dcrcclcr, user dcrcusua, null dcrcterm, null dcrcprog, null dcrcsist,
        'ACTA-'||gd.id_acta acta,

        Decode(gc.account_classif_id,To_Number(ldci_pkinterfazactas.gvaClasifContRedTerc),ldci_pkinterfazactas.fnuGetNitRedTerc(ga.id_contrato),
                                     gs.identification) nit,

        ldci_pkinterfazactas.fvaGetClasifi(Decode(ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN),0, ot.task_type_id,
                                                  ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN))) clasificador,
        To_Char(gd.id_items) item, ga.id_contrato contrato
   FROM ge_detalle_acta gd, ge_items gi, or_order ot, ge_acta ga, ge_contrato gc, ge_contratista gco, ge_subscriber gs
  WHERE gd.id_acta = (inuacta)
    AND gd.id_items = gi.items_id
    AND ot.order_id = gd.id_orden
    AND gd.id_acta = ga.id_acta
    AND ga.id_contrato = gc.id_contrato
    AND gc.id_contratista = gco.id_contratista
    AND gs.subscriber_id = gco.subscriber_id
    AND gd.id_items = ldci_pkinterfazactas.vaItemIva
    AND gd.valor_total <> 0
  -- and ot.task_type_id = 12688
   GROUP BY Decode(ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN),0, ot.task_type_id, ldci_pkinterfazactas.fnuGetTipoTrab(GD.ID_ORDEN)), gd.id_items, gd.geograp_location_id, GD.ID_ORDEN,
            ot.geograp_location_id, gs.identification, gi.item_classif_id, ga.extern_invoice_num, ot.task_type_id, ldci_pkinterfazactas.fvaGetTitrCoGa(GD.ID_ORDEN),
            gd.id_acta, ga.id_contrato, gc.account_classif_id, ldci_pkinterfazactas.fvaGetCuGaCoClasi(gd.id_orden)

UNION ALL
   --<<
   --Cursor 5
   --Cursor para obtener el total de la cuenta por pagar
   -->>
    SELECT dcrccons, dcrcecrc, dcrccorc, cuenta, Decode(Sign(SUM(valor)), -1, 'C', 1, 'D') signos,
           Abs(SUM(valor)) valor, NULL dcrcinad, dcrcfecr, dcrcclcr, dcrcusua, dcrcterm, dcrcprog,
           dcrcsist, acta, nit, clasificador, item, contrato
      FROM (SELECT NULL dcrccons, NULL dcrcecrc, NULL dcrccorc, '-1' cuenta, dcrcsign signos,
                   Round(Sum(Decode(dcrcsign, 'D', -dcrcvalo, 'C', dcrcvalo)))  valor, NULL dcrcinad,
                   NULL dcrcfecr, NULL dcrcclcr, dcrcusua, dcrcterm, dcrcprog, dcrcsist, 'ACTA-'||acta acta,
                   nit, NULL clasificador, NULL item, NULL depto, NULL locali, contrato
              FROM ic_compgene, ic_encoreco, ic_decoreco,
                   (SELECT gc.id_contratista contratista, gco.id_contrato contrato, ga.id_acta acta,
                           ga.extern_invoice_num factura, gs.identification nit
                      FROM ge_contratista gc ,ge_subscriber  gs, ge_acta ga, ge_contrato gco
                     WHERE gc.subscriber_id = gs.subscriber_id
                       AND gco.id_contratista = gc.id_contratista
                       AND gco.id_contrato = ga.id_contrato
                       AND ga.id_acta = inuacta) v_deco,
                   ic_confreco, ic_clascore, ic_clascont, ldci_tipointerfaz
             WHERE cogecoco = cod_tipocomp
               AND tipointerfaz = Decode(ivaiclitido, ldci_pkinterfazsap.vaInterInversion, tipointerfaz, ivaiclitido)
               AND ecrccoge = cogecons
               AND ecrccons = dcrcecrc
               AND corccoco = cogecoco
               AND clcrcons = dcrcclcr
               AND clcrclco = clcocodi
               AND corccons = dcrccorc
               AND ldci_pkinterfazsap.fvaGetData(11, dcrcinad, '|') = v_deco.nit
               AND ldci_pkinterfazsap.fvaGetData(42, dcrcinad, '|') = v_deco.factura
               AND dcrccuco IN ('-1', 'G', 'A')
             GROUP BY dcrcecrc, dcrccorc, dcrccuco ,
                      dcrcfecr, dcrcusua, dcrcterm, dcrcprog, dcrcsist,dcrcsign,
                      'ACTA-'||acta, NIT, contrato
             ORDER BY cuenta)
     GROUP BY dcrccons, dcrcecrc, dcrccorc, cuenta, dcrcinad, dcrcfecr, dcrcclcr, dcrcusua, dcrcterm,
              dcrcprog, dcrcsist, acta, nit, clasificador, item, contrato;

 --<<
 --Cursor que obtiene los datos del contrato para resolver acta L9
 -->>
  CURSOR cuContrato (inucontrato NUMBER) IS
    SELECT Nvl(account_classif_id,0)
      FROM ge_contrato
     WHERE id_contrato = inucontrato;

 --<<
 --Cursor que obtiene los datos del contrato para resolver acta L9
 -->>
  CURSOR cuActa (inuacta NUMBER) IS
    SELECT Nvl(id_tipo_acta,0)
      FROM ge_acta
     WHERE id_acta = inuacta;


  --<<
  -- CASO 200-72
  -- EDMUNDO LARA 16-03-2016
  -- Curso para obtener el indicador CME que se debe reportar para la amortizacion de anticipos.
  -->>
   CURSOR culdci_contranticipo (inucontrato NUMBER) is
    SELECT l.indicadorcme
      FROM ldci_contranticipo L
     WHERE L.IDCONTRATO = inucontrato;

  --<<
  -- OSF-4197
  -- Curso para obtener el CEBE de los RETEICA a partir del item de RETEICA.
  -->>
  CURSOR cuCebeIca(inuitem ge_items.items_id%TYPE) IS
  Select celocebe
    from open.LDC_PARAMETROS_ICA pi, open.LDCI_CENTBENELOCAL cb, open.ge_items it
   where pi.items_id = inuitem
     and geograp_location_id = celoloca
     and pi.items_id = it.items_id
     and it.item_classif_id in (SELECT gic.item_classif_id
													       FROM ge_item_classif gic
												        WHERE ',' || ldci_pkinterfazsap.vaClasitem23 || ',' LIKE
															        '%,' || gic.item_classif_id || ',%')
     and it.items_id != ldci_pkinterfazactas.vaItemIva
     and rownum = 1;


  -- Private type declarations


  -- Private constant declarations
    nuCantidad       NUMBER:= 0;

  -- Private variable declarations
  nuCount          NUMBER := 0;
  gnuComodin       NUMBER;
  nuRet NUMBER;
  error            EXCEPTION;  -- Manejo de errores en la inserccion de los datos contables en LDCI_INCOLIQU
  vaClave         LDCI_CLAVECONTA.clavcodi%TYPE;
  iovactcaicme    LDCI_CTACADMI.ctcaicme%TYPE;
  iovactcainiv    LDCI_CTACADMI.ctcainiv%TYPE;
  iovaitemindi    LDCI_ITEMCONTA.itemindi%TYPE;
  iovactcatire    LDCI_INTEMINDICA.itemtire%TYPE;
  iovactcainre    LDCI_INTEMINDICA.iteminre%TYPE;
  iovactcaitem    LDCI_INTEMINDICA.itemcate%TYPE;
  iovacuentaiva   LDCI_ITEMCONTA.itemciva%TYPE;
  iovaitemincm    LDCI_CTACADMI.ctcaicme%TYPE;
  vaIndicaCME     LDCI_CTACADMI.ctcaicme%TYPE;
  nuContratoClas  GE_CONTRATO.id_contrato%TYPE;
  nuTipoActa      GE_ACTA.id_tipo_acta%TYPE;
  sbFechaGen DATE;
  vaCuenta ldci_cuentacontable.cuctcodi%TYPE;
  vaCuentaDiverg ldci_cuentacontable.cuctcodi%TYPE;
  TYPE tyInfoActas IS TABLE OF cuInfoActas%ROWTYPE INDEX BY BINARY_INTEGER;
    vtyInfoActas tyInfoActas;

  --<<
  -- CA-376
  csbEntrega376   open.ldc_versionentrega.codigo_caso%type:='0000376';
  sbAplica376     varchar2(1):='N';
  vsbtipoproduct  ldci_carasewe.casevalo%type;
  vsbctapromigas  ldci_carasewe.casevalo%type;
  vsbnitpromigas  ldci_carasewe.casevalo%type;
  vsbtipoprodcur  varchar2(4);
  vnuvalorGAS     ldci_incoliqu.impomtrx%type;
  vnuvalorFNB     ldci_incoliqu.impomtrx%type;
  nuClasiCodi     ic_clascont.clcocodi%type;
  vsbCeco         ldci_incoliqu.centroco%type;
  -- 376
  -->>


  --<<
  -- OSF-4197
  vaCebe          ldci_centbenelocal.celocebe%TYPE;


 BEGIN

    --<<
    -- Parametros de intrefaz
    --<<
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'GRLEDGER', ldci_pkinterfazsap.vaGRLEDGER, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'SOCIEDAD', ldci_pkinterfazsap.vaSOCIEDAD, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CURRENCY', ldci_pkinterfazsap.vaCURRENCY, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CEBE_GENERAL', ldci_pkinterfazactas.gvacebegral, osbErrorMessage);
    ldci_pkInterfazSAP.vaCODINTINTERFAZ:=ivaiclitido;
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CONDIPAGO', ldci_pkinterfazsap.vaCODPAGO, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CUENTA_PARTICULAR', ldci_pkinterfazsap.vaCuentaParticu, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'NOCLASIFIVA', ldci_pkinterfazsap.vaClasiIva, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CLASITEM23', ldci_pkinterfazsap.vaClasitem23, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'AJUSTAINTER', ldci_pkinterfazsap.vaAjustaInte, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'INTERCATEGOR', ldci_pkinterfazsap.vaCategoria, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'ITEMIVA', ldci_pkinterfazactas.vaItemIva, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'IVA', ldci_pkinterfazsap.vaIva, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'AIU', ldci_pkinterfazsap.vaAiu, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'INVERSION', ldci_pkinterfazsap.vaInterInversion, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'ITEMRETEIVA', ldci_pkinterfazsap.vaItemsReteIva, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CLASIFIVAVENTA', ldci_pkinterfazactas.vaClasiIvaVenta, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CLASIFIVAL9', ldci_pkinterfazactas.vaClasiIvaL9, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'NOCLASIFIVAREC', ldci_pkinterfazsap.vaClasiIvaRec, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'VALORETEIVA', ldci_pkinterfazsap.vaReteIva, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'MULTAS', ldci_pkinterfazsap.vaMultas, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CUENTAL9', ldci_pkinterfazactas.vaCuentaL9, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CUENTAL9CR', ldci_pkinterfazactas.vaCuentaL9cr, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CLASIFLEASING', ldci_pkinterfazactas.vaClasifContrato, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'ACTAFACT', ldci_pkinterfazactas.vaTipoActa, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CTACOBFACT', ldci_pkinterfazactas.vaCtaCobFac, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'ENVIAINT', ldci_pkinterfazactas.vaEnviaInt, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'TIPORELATED', ldci_pkinterfazactas.vaTipoRelated, osbErrorMessage);
    ldci_pkinterfazsap.vaGRLEDGER := ldci_pkinterfazactas.fvaGetLibro(ivaiclitido);
    --<<
    -- CA - 200-2529
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'LDC_NIT_IVA_RECUPERABLE', ldci_pkinterfazactas.vaNitivarecupera, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CTA_IVA_DEDUCCION_RENTA', ldci_pkinterfazactas.vaCtaIvarecupera, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'INDICA_IVA_DEDUCCION_RENTA', ldci_pkinterfazactas.vaIndicarecupera, osbErrorMessage);
    --
    -->>


    --<<
    -- Dcardona:
    -- 08/07/2014
    -- Se agrega el nuevo parametro de clasificadores de activos
    -->>
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CLASIACTIVOS', ldci_pkinterfazactas.vaClasiActivos, osbErrorMessage);

    -- 16/12/2014, cgonzalezv, Red de Terceros: Cuenta y tipo de contrato
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CLASCONTREDTERC', ldci_pkinterfazactas.gvaClasifContRedTerc, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CUENTACONTREDTERC', ldci_pkinterfazactas.gvaCuentacontRedTerc, osbErrorMessage);

    --<<
    -- Aranda 4212, parametro con el Item de anticipo
    -->>
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'ITEMANTICIPO', ldci_pkinterfazactas.gvaitemanticipo, osbErrorMessage);

    --<<
    -- CA-376, 
    -- Parametros para distribuir el porcentaje de generacion y reparto de factura entre GAS y FNB
    -->>
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CENTRO_COSTO_BRILLA', ldci_pkinterfazactas.vaCECOFNB, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CLASIFICADOR_GENERA_FACTURA', ldci_pkinterfazactas.vaClasiGeneFra, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CLASIFICADOR_REPARTO_FACTURA', ldci_pkinterfazactas.vaClasiRptoFra, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'PORCENTAJE_ENTREGA_FACTURA_FNB', ldci_pkinterfazactas.vaPorceRptoFra, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'PORCENTAJE_GENERA_FACTURA_FNB', ldci_pkinterfazactas.vaPorceGeneFra, osbErrorMessage);
    --
    -->>

    --<<
    -- Documento contable que determina el  tipo de acta(costos,activos fijos,fnb)
    -->>
    ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP := ivaiclitido;

    --<<
    -- Cantidad de registros
    -->>
  begin
    -- Movimientos financieros de cuentas de costos, valor de iva y ajustes como multas.
    FOR rc_cuActas IN cuActas LOOP
        nuCount := nuCount + 1;
       -- Dbms_Output.Put_Line('el acta es '||rc_cuActas.acta);
        --<<
        --Obtencion del  numero de documento
        -->>
        ldci_pkInterfazSAP.nuSeqICLINUDO := ldci_pkInterfazSAP.fnuSeq_ldci_incoliqu;
        ldci_pkInterfazSAP.vaMensError :=  '[fnuInterCostoSAP] Acta Numero '||' - '||ldci_pkinterfazsap.vaInterInversion||' - '||rc_cuActas.acta||' '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
        LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),'00',USER,USERENV('TERMINAL'));


        ldci_pkinterfazsap.vaFactura := rc_cuActas.factura;
        ldci_pkinterfazsap.vaActa := rc_cuActas.acta;
        --DBMS_OUTPUT.PUT_LINE('Identificador InterfazCostos: '||ldci_pkInterfazSAP.nuSeqICLINUDO);


        OPEN cuInfoActas(rc_cuActas.acta);
        FETCH cuInfoActas BULK COLLECT INTO vtyInfoActas;
        CLOSE cuInfoActas;

        IF (vtyInfoActas.count > 0) THEN

          FOR i IN vtyInfoActas.First..vtyInfoActas.Last LOOP
          vaDiverge := 'N';
          vaClave := NULL;
          vaCuenta := NULL;
          vaCuentaDiverg := NULL;
          iovaitemindi := NULL;
          iovaitemincm := NULL;
          vaIndicaCME  := NULL;
          ldci_pkinterfazsap.vaCentBen := NULL;
          ldci_pkinterfazsap.vaNit := NULL;
          ldci_pkinterfazsap.vaNitAnti := NULL;
          ldci_pkinterfazsap.vaSigno := NULL;
          ldci_pkinterfazsap.vaActaFact := NULL;
          iovactcatire := NULL;
          iovactcainre := NULL;
          iovactcaitem := NULL;
          iovacuentaiva := NULL;
          ldci_pkinterfazsap.vacuentaIvaIFRS := null;
          --<<
          -- OSF-4197
          vaCebe := NULL;

         -- Dbms_Output.Put_Line('la cuenta es '||vtyInfoActas(i).cuenta);
         -- Dbms_Output.Put_Line('Valor parametro '||ldci_pkinterfazsap.vaCuentaParticu);

          --<<
          -- CA-376
          if fblaplicaentregaxcaso(csbEntrega376) then
            sbAplica376 :='S';
          else
            sbAplica376 :='N';
          end if;
          -- 376
          -->>


          --<<
          -- Se setean las variables globales para contrato y factura, de tal forma que se puedan
          -- mostrar en la trama junto con el acta
          -->>
          ldci_pkinterfazsap.nuContrato := vtyInfoActas(i).contrato;

         ldci_pkinterfazsap.vaSigno := vtyInfoActas(i).signos;
         IF vtyInfoActas(i).cuenta NOT LIKE  '%,' ||ldci_pkinterfazsap.vaCuentaParticu|| ',%' THEN
            nuRet := ldci_pkinterfazsap.fnuValidaCuenta(vtyInfoActas(i).cuenta);
          --  Dbms_Output.Put_Line('la cuenta retorna  '||nuRet);

            IF nuRet = -1 THEN
            LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
            --RAISE error;
            END IF;
         END IF;

              IF  vtyInfoActas(i).cuenta = 'G' THEN
                  iovaitemincm := 'G';
                  vaCuenta := vtyInfoActas(i).nit;
                  vaClave := '39';
                  ldci_pkinterfazsap.vaCentBen := ldci_pkinterfazactas.gvacebegral;
                  ldci_pkinterfazsap.vaNit := vtyInfoActas(i).nit;

              --27-08-215 cgonzalez aranda 4212
              ELSIF  (','||ldci_pkinterfazactas.gvaitemanticipo||',' LIKE '%,' ||NVL(vtyInfoActas(i).item,0)|| ',%') THEN

              --<<
              -- CASO 200-72
              -- EDMUNDO LARA 16-03-2016
              --
              OPEN culdci_contranticipo(vtyInfoActas(i).contrato);
              FETCH culdci_contranticipo INTO iovaitemincm;
              CLOSE culdci_contranticipo;
              --
              --iovaitemincm := 'A';
              -->>

              -- <<
              -- CA - 200-1310
              -- Edmundo Lara 31-07-2017
              --
              If vtyInfoActas(i).item = '102005' then
                vaClave := '29';
              Else
                vaClave := '39';
              End  If;
              --
              -- >>
              ldci_pkinterfazsap.vaNit := vtyInfoActas(i).nit;
              ldci_pkinterfazsap.vaCentBen := ldci_pkinterfazactas.gvacebegral;
              ldci_pkinterfazsap.vaNitAnti := ldci_pkinterfazactas.fvaGetAnticipo(vtyInfoActas(i).contrato);
              vaCuenta := ldci_pkinterfazsap.vaNitAnti;
              IF ldci_pkinterfazsap.vaNit = '-1' THEN
              ldci_pkinterfazsap.vaNit := NULL;
              END IF;
              --<<
              --se obtiene el codigo del anticipo xxxxx
              -->>


              ELSIF vtyInfoActas(i).cuenta = '-1' THEN

                OPEN cuContrato (vtyInfoActas(i).contrato);
                FETCH cuContrato INTO nuContratoClas;
                CLOSE cuContrato;

                IF (To_Char(nuContratoClas) = ldci_pkinterfazactas.vaClasifContrato) THEN

                vaCuenta := ldci_pkinterfazactas.vaCuentaL9cr;
                vaClave := ldci_pkInterfazSAP.fvaGetClaveConta(vaCuenta, vtyInfoActas(i).signos,  iovactcaicme, iovactcainiv);
                ldci_pkinterfazsap.vaCentBen := ldci_pkinterfazactas.gvacebegral;
                ldci_pkinterfazsap.vaNit := vtyInfoActas(i).nit;

                ELSE

                vaClave := '31';

               --<<
               --se obtiene la cuenta por pagar
               -->>
               vaCuentaDiverg := ldci_pkinterfazactas.fvaGetCuenTipoContrato(ldci_pkinterfazactas.fnuGetTipoContrato(vtyInfoActas(i).contrato));

               vaClave := ldci_pkInterfazSAP.fvaGetClaveConta(vaCuentaDiverg, vtyInfoActas(i).signos,  iovactcaicme, iovactcainiv);
               vaCuenta := vtyInfoActas(i).nit;
               ldci_pkinterfazsap.vaCentBen := ldci_pkinterfazactas.gvacebegral;
               ldci_pkinterfazsap.vaNit := vtyInfoActas(i).nit;

               END IF;

               OPEN cuActa(rc_cuActas.acta);
               FETCH cuActa INTO ldci_pkinterfazsap.vaActaFact;
               CLOSE cuActa;

               IF ldci_pkinterfazsap.vaActaFact = ldci_pkinterfazactas.vaTipoActa THEN

                vaCuentaDiverg := ldci_pkinterfazactas.vaCtaCobFac;
                vaClave := ldci_pkInterfazSAP.fvaGetClaveConta(vaCuentaDiverg, vtyInfoActas(i).signos,  iovactcaicme, iovactcainiv);
                ldci_pkinterfazsap.vaCentBen := ldci_pkinterfazactas.gvacebegral;
                ldci_pkinterfazsap.vaNit := vtyInfoActas(i).nit;

               END IF;


              ELSE



              ldci_pkinterfazsap.vaNit := vtyInfoActas(i).nit;
              vaCuenta := vtyInfoActas(i).cuenta;
              --<<
              --obtiene la clave contable a partir de la cuenta
              -->>
              vaClave := ldci_pkInterfazSAP.fvaGetClaveConta(vtyInfoActas(i).cuenta, vtyInfoActas(i).signos,  iovactcaicme, iovactcainiv);
              nuRet := ldci_pkinterfazactas.fvaGetIndicadore(vtyInfoActas(i).item, vtyInfoActas(i).clasificador, iovactcatire, iovactcainre, iovactcaitem);
              -- Se debe ajustar para que envie el tipo de trabajo y un parametro de entrada que
              -- me indique si se realizo cobro al suscriptor o no, para de esa forma determinar
              -- si retorna la cuenta de costo o la de gasto.
              nuRet := ldci_pkinterfazactas.fvaGetIndivaTT(ldci_pkinterfazsap.fvaGetData(48,vtyInfoActas(i).dcrcinad,'|'),
                                                           ldci_pkinterfazsap.fvaGetData(49,vtyInfoActas(i).dcrcinad,'|'),
                                                           iovaitemindi, iovacuentaiva);


              --<<
              -- Se ajusta para que no obtenga el indicador a partir del item, sino del clasificador
              -->>
              /*
              -- Dcardona
              -- 29/07/2014
              -- Se comenta debido a que solo se manejara el indicador cuando es IVA
              if Nvl(ldci_pkinterfazsap.fvaGetData(40,vtyInfoActas(i).dcrcinad,'|'),NULL) <> 23 then

              nuRet := ldci_pkinterfazactas.fvaGetIndivaClas(vtyInfoActas(i).clasificador, iovaitemindi, iovacuentaiva);

              end if;
              */

            IF ldci_pkinterfazsap.fvaGetData(47,vtyInfoActas(i).dcrcinad,'|') = 'IVA'  THEN

                  -- Se debe ajustar para que envie el tipo de trabajo y un parametro de entrada que
                  -- me indique si se realizo cobro al suscriptor o no, para de esa forma determinar
                  -- si retorna la cuenta de costo o la de gasto.
                  nuRet := ldci_pkinterfazactas.fvaGetIndivaTT(ldci_pkinterfazsap.fvaGetData(48,vtyInfoActas(i).dcrcinad,'|'),
                                                               ldci_pkinterfazsap.fvaGetData(49,vtyInfoActas(i).dcrcinad,'|'),
                                                               iovaitemindi, iovacuentaiva);

                  OPEN cuActa(rc_cuActas.acta);
                  FETCH cuActa INTO ldci_pkinterfazsap.vaActaFact;
                  CLOSE cuActa;

                  IF ldci_pkinterfazsap.vaActaFact = ldci_pkinterfazactas.vaTipoActa THEN

                    ldci_pkinterfazsap.vaCentBen := ldci_pkinterfazactas.gvacebegral;

                  END IF;
                  --<<
                  --Asigna la cuenta del iva
                  -->>
                  IF iovacuentaiva IS NOT NULL THEN
                    vaCuenta := iovacuentaiva;
                    --<<
                    -- Dcardona
                    -->>
                    ldci_pkinterfazsap.vacuentaIvaIFRS := iovacuentaiva;
                    --<<
                    -- CA-200-2652
                    -- Solo debe buscar la clave para las actas que e pagan a contratistas.
                    IF ldci_pkinterfazsap.vaActaFact != ldci_pkinterfazactas.vaTipoActa THEN
                      -- CA-200-2529 Busca la clave para actass de pago.
                      vaClave := ldci_pkInterfazSAP.fvaGetClaveConta(iovacuentaiva, vtyInfoActas(i).signos,  iovactcaicme, iovactcainiv);
                    END IF;
                    --
                    -->

                  END IF;

            END IF;


              IF iovactcaitem = 'G' THEN
              ldci_pkinterfazsap.vaCentBen := ldci_pkinterfazactas.gvacebegral;
              END IF;

              vaDiverge := ldci_pkinterfazsap.fnuCtaDiver(vaClave);


              IF vaDiverge = 'S' THEN

              vaCuenta :=  vtyInfoActas(i).nit;
              vaCuentaDiverg := vtyInfoActas(i).cuenta;

              END IF;


            END IF;

            ldci_pkInterfazSAP.vaMensError :=  '[fnuInterCostoSAP] Arma la trama '||' - '||ldci_pkInterfazSAP.nuSeqICLINUDO||' '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
            LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),'00',USER,USERENV('TERMINAL'));

            --<<
            -- Dcardona: 20/11/2014
            -- Si el indicador de cuenta es fondo de garantias o amortizacion de anticipo se envia ese
            -- indicadorde cuenta, de lo contrrio se envia el que se obtiene a partir de la cuenta.
            -->>
            IF (iovaitemincm IS NULL) THEN

               vaIndicaCME := iovactcaicme;

            ELSE

               vaIndicaCME := iovaitemincm;

            END IF;
            
            --<<
            -- CA-376
            --
            nuClasiCodi := ldci_pkinterfazactas.fvaGetClasifi(Nvl(ldci_pkinterfazsap.fvaGetData(39,vtyInfoActas(i).dcrcinad,'|'),NULL));

            ldci_pkInterfazSAP.vaMensError :=  'Valida Clasificadores '||' - '||nuClasiCodi||' - vaClasiGeneFra '||vaClasiGeneFra|| ' - vaClasiRptoFra ' ||vaClasiRptoFra||' '|| ' vaCECOFNB ' ||ldci_pkinterfazactas.vaCECOFNB||' '|| DBMS_UTILITY.format_error_backtrace;
            LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),'00',USER,USERENV('TERMINAL'));


            If sbAplica376 = 'S' and nuclasicodi in (vaClasiGeneFra, vaClasiRptoFra) and 
               substr(vaCuenta,1,1) in (5,7) then
               -- Se calcula el valor para FNB dependiento del clasificador
              IF nuclasicodi in (vaClasiGeneFra) Then
                 vnuvalorFNB := trunc((vtyInfoActas(i).VALOR * (vaPorceGeneFra/100)));
              End if;
              --
              If nuclasicodi in (vaClasiRptoFra) Then
                 vnuvalorFNB := trunc((vtyInfoActas(i).VALOR * (vaPorceRptoFra/100)));
              End If;
              -- Se calcula el valor del GAS
              vnuvalorGAS := vtyInfoActas(i).VALOR - vnuvalorFNB;
              vsbCeco     := ldci_pkinterfazactas.vaCECOFNB;
            -- Si no es clasificador de Genracion y Reparto de FACTURA
            Else
              vnuvalorGAS := vtyInfoActas(i).VALOR;
              vnuvalorFNB := 0;
            End if;
            --
            --<< CA-200-2602
            --   Se coloca en comentario esta asignacion para evitar inconvenientes
            --   con las tramas de EFIGAS
            --
            --<< CA 200-1301
            -- Edmundo Lara 12-06-2018
            --
            --IF vaCuenta like '243695%' THEN
            --
            --  vaClave := '70';
            --
            --END IF;
            --
            -->>
            --
            --<< END CA-200-2602


            --<<
            -- OSF-4197
            -->>
            If ldci_pkinterfazsap.vaCentBen is NULL Then
              OPEN cuCebeIca(NVL(vtyInfoActas(i).item,0));
              FETCH cuCebeIca INTO vaCebe;
              CLOSE cuCebeIca;
            Else
              vaCebe := ldci_pkinterfazsap.vaCentBen;
            End if;


            --<<
            -- Dcardona
            -- 01/07/2014
            -- Se cambia le llamado de fnuLDCI_INCOLIQUACTA por la nueva fnuLDCI_INCOLIQUACTACOSTO
            -->>
            nuRet := ldci_pkinterfazsap.fnuLDCI_INCOLIQUACTACOSTO(ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,
                                                                  ldci_pkInterfazSAP.nuSeqICLINUDO,
                                                                  sysdate,
                                                                  user,
                                                                  'SERVER',
                                                                  sysdate,
                                                                  null,
                                                                  vaClave,
                                                                  vaCuenta,--cuenta,
                                                                  vaIndicaCME,--null,
                                                                  --<<
                                                                  -- CA-376
                                                                  --vtyInfoActas(i).VALOR,
                                                                  --vtyInfoActas(i).VALOR,
                                                                  vnuvalorGAS,
                                                                  vnuvalorGAS,                                                                  
                                                                  -->
                                                                  iovaitemindi,
                                                                  null,
                                                                  vtyInfoActas(i).acta,
                                                                  null,
                                                                  null,
                                                                  null,
                                                                  null,
                                                                  iovactcatire,
                                                                  iovactcainre,
                                                                  null,
                                                                  i,
                                                                  vaCuentaDiverg,
                                                                  --<<
                                                                  -- CA_376
                                                                  NULL,
                                                                  -->>
                                                                  vtyInfoActas(i).dcrcinad,
                                                                  rc_cuActas.cod_comprobante,
                                                                  -- OSF-4197
                                                                  vaCebe);
                                                                  
            --<<
            -- CA-376
            If sbAplica376 = 'S' and nuclasicodi in (vaClasiGeneFra, vaClasiRptoFra) and 
               substr(vaCuenta,1,1) in (5,7) then 
                                                                                   
              nuRet := ldci_pkinterfazsap.fnuLDCI_INCOLIQUACTACOSTO(ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,
                                                                    ldci_pkInterfazSAP.nuSeqICLINUDO,
                                                                    sysdate,
                                                                    user,
                                                                    'SERVER',
                                                                    sysdate,
                                                                    NULL,
                                                                    vaClave,
                                                                    vaCuenta,--cuenta,
                                                                    vaIndicaCME,--null,
                                                                    vnuvalorFNB,
                                                                    vnuvalorFNB,                                                                  
                                                                    -->
                                                                    iovaitemindi,
                                                                    null,
                                                                    vtyInfoActas(i).acta,
                                                                    null,
                                                                    null,
                                                                    null,
                                                                    null,
                                                                    iovactcatire,
                                                                    iovactcainre,
                                                                    null,
                                                                    i,
                                                                    vaCuentaDiverg,
                                                                    --<<
                                                                    -- CA_376  
                                                                    vsbCeco,
                                                                    -->>                                                                  
                                                                    vtyInfoActas(i).dcrcinad,
                                                                    rc_cuActas.cod_comprobante,
                                                                    -- OSF-4197
                                                                    vaCebe);   
            End If;                                                               

            END LOOP;

            nuRet := ldci_pkInterfazSAP.fnuINSELDCI_INCOLIQU;
            --<<
            --Genera la informacion de los documentos para SAP de la interfaz de INGRESOS
            -->>
            --<<
          --Se lanza la Exepcion
          -->>
          IF (nuRet <> 0) THEN
              ldci_pkInterfazSAP.vaMensError :=  '[fnuInterCostoSAP] - Error insertando LDCI_INCOLIQU para la interfaz de costos. '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
              LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,USER,USERENV('TERMINAL'));
              --RAISE ERROR;
              CONTINUE;
          END IF;
            ldci_pkInterfazSAP.vaMensError :=  '[fnuInterCostoSAP] Arma encabezado '||' - '||ldci_pkInterfazSAP.nuSeqICLINUDO||' '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
            LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),'00',USER,USERENV('TERMINAL'));

            nuRet := ldci_pkInterfazSAP.fnuGeneDocuSapActaRO(ldci_pkInterfazSAP.nuSeqICLINUDO);

          --<<
          --Se lanza la Exepcion
          -->>
          IF (nuRet <> 0) THEN
              LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
              --RAISE ERROR;
              CONTINUE;
          END IF;
          --<< CA-1300
          --   EDMUNDO LARA
          -- CA-200-2239 Se habilita lo que estaba en comentario por el desarrollo 200-1300
         --<<
         --Se realiza el ajuste de la intrerfaz en caso que este descuadrada
         -->>

         nuRet := ldci_pkinterfazsap.fnuAjusteInterContRO(ldci_pkInterfazSAP.nuSeqICLINUDO);

         --Dbms_Output.Put_Line('valido ajuste '||ldci_pkInterfazSAP.nuSeqICLINUDO);

          --<<
          --Se lanza la Exepcion
          -->>
          IF (nuRet <> 0) THEN
              LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
              --RAISE ERROR;
              CONTINUE;
          END IF;


          IF ldci_pkinterfazsap.vaActaFact = ldci_pkinterfazactas.vaTipoActa THEN

              nuRet := ldci_pkinterfazactas.fnuActualizaFact(ldci_pkInterfazSAP.nuSeqICLINUDO);

              --<<
              --Se lanza la Exepcion
              -->>
              IF (nuRet <> 0) THEN
                  LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
                  --RAISE ERROR;
                  CONTINUE;
              END IF;

          --<< CA-2602
          --   EDMUNDO LARA

          /*
           --<< CA-200-2238 --
             ELSE

             --<<
             --Se realiza el ajuste de la intrerfaz en caso que este descuadrada
             -->>
             nuRet := ldci_pkinterfazsap.fnuAjusteInterContRO(ldci_pkInterfazSAP.nuSeqICLINUDO);

              --<<
              --Se lanza la Exepcion
              -->>
              IF (nuRet <> 0) THEN
                  LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
                  --RAISE ERROR;
                  CONTINUE;
              END IF;
           -->> END CA-200-2239
          */
          --
          -->> CA-2602

          END IF;

         --<<
         --Si es satifactorio todo el proceso, se realiza el envio a SAP
         -->>
            ldci_pkInterfazSAP.vaMensError :=  '[fnuInterCostoSAP] Envio la trama '||' - '||ldci_pkInterfazSAP.nuSeqICLINUDO||' '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
            LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),'00',USER,USERENV('TERMINAL'));


       IF (ldci_pkinterfazactas.vaEnviaInt = 'S') THEN


            ldci_pkintercontablemesa.proEnviaDocContable(ldci_pkInterfazSAP.nuSeqICLINUDO);

            ldci_pkInterfazSAP.vaMensError :=  '[fnuInterCostoSAP] registro el actacont '||' - '||ldci_pkInterfazSAP.nuSeqICLINUDO||' '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
            LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),'00',USER,USERENV('TERMINAL'));



         END IF; --no envia la interfaz en caso de estar deshabilitado.

         nuRet := ldci_pkinterfazactas.fnuInsHistAct(inucodacta     => ldci_pkinterfazsap.vaActa,
                                                  inucodocont   => ldci_pkInterfazSAP.nuSeqICLINUDO,
                                                  ivatipdocont   => ldci_pkInterfazSAP.vaCODINTINTERFAZ,
                                                  ivausuario      => USER,
                                                  idtfechcontabil => SYSDATE
                                                );
          -- Validacion si se inserto historia contable
          IF (nuRet <> 0) THEN
              LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
              --RAISE Error;
              CONTINUE;
          END IF;

       END IF;
      --<<
      --Inserta los datos en la tabla LDCI_INCOLIQU
      -->>
      nuCantidad := nuCantidad + 1;

     END LOOP;

     IF nuCount = 0 THEN
       ldci_pkInterfazSAP.vaMensError := 'No hay Actas a Procesar';
       LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,USER,USERENV('TERMINAL'));
       return (-2);
     END IF;

   EXCEPTION
      WHEN error THEN 
         ldci_pkInterfazSAP.vaMensError :=  '[fnuInterCostoSAP] - No se proceso la interfaz de costos. '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
         LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
   END; --END BEGIN
   
   IF (nuRet <> 0) THEN
       RAISE Error;
   END IF;
   
   RETURN 0;

EXCEPTION
  WHEN OTHERS THEN
       ldci_pkInterfazSAP.vaMensError :=  '[fnuInterCostoSAP] - No se proceso la interfaz de costos. '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
       LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,USER,USERENV('TERMINAL'));
       RETURN(-1);

END fnuInterCostoSAP;


FUNCTION fvaGetIndicadore ( inuitemcodi   in LDCI_INTEMINDICA.itemcodi%TYPE,
                            inuitemclco   IN LDCI_INTEMINDICA.itemclco%TYPE,
                            ovaCTCATIRE  OUT LDCI_INTEMINDICA.itemtire%TYPE,
                            ovaCTCAINRE  OUT LDCI_INTEMINDICA.iteminre%TYPE,
                            ovaITEMCATE  OUT LDCI_INTEMINDICA.itemcate%TYPE)
  return VARCHAR
  is
  /************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION   : fvaGetIndicadore
     AUTOR     : Heiber Barco
     FECHA     : 02-08-2013
     DESCRIPCION  : Tiquete:
                    funcion que se encarga de obtener la clave apartir de la cuenta

    Parametros de Entrada

    Parametros de Salida

    Historia de Modificaciones
    Autor    Fecha       Descripcion
  ************************************************************************/
  CURSOR cuGetIndica IS
    SELECT *
      FROM LDCI_INTEMINDICA
     WHERE itemcodi = inuitemcodi
       AND itemclco = inuitemclco;




   rgcuGetIndica cuGetIndica%ROWTYPE;

  begin

  OPEN cuGetIndica;
  FETCH cuGetIndica INTO rgcuGetIndica;
  CLOSE cuGetIndica;
  ovaCTCATIRE := rgcuGetIndica.itemtire;
  ovaCTCAINRE := rgcuGetIndica.iteminre;
  ovaITEMCATE := rgcuGetIndica.itemcate;



     RETURN 0;
  exception
  when others then
       ldci_pkInterfazSAP.vaMensError :=  '[fvaGetClaveConta] - No se pudo obtener la clave. '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
       return('-1');
  end fvaGetIndicadore;

   FUNCTION fvaGetIndiva (inuitemcodi   in LDCI_INTEMINDICA.itemcodi%TYPE,
                              ovaCTCAINIV  OUT ldci_itemconta.itemindi%TYPE,
                              ovaITEMCIVA  OUT ldci_itemconta.itemciva%TYPE)
  return VARCHAR
  is
  /************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION   : fvaGetIndicadore
     AUTOR     : Heiber Barco
     FECHA     : 02-08-2013
     DESCRIPCION  : Tiquete:
                    funcion que se encarga de obtener el indicador

    Parametros de Entrada

    Parametros de Salida

    Historia de Modificaciones
    Autor    Fecha       Descripcion
  ************************************************************************/
  CURSOR cuGetIndica IS
    SELECT *
      FROM LDCI_ITEMCONTA
     WHERE itemcodi = inuitemcodi;




   rgcuGetIndica cuGetIndica%ROWTYPE;

  begin

  OPEN cuGetIndica;
  FETCH cuGetIndica INTO rgcuGetIndica;
  CLOSE cuGetIndica;

  ovaCTCAINIV := rgcuGetIndica.itemindi;
  ovaITEMCIVA := rgcuGetIndica.itemciva;



     RETURN 0;
  exception
  when others then
       ldci_pkInterfazSAP.vaMensError :=  '[fvaGetClaveConta] - No se pudo obtener el indicador IVA. '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
       return('-1');
  end fvaGetIndiva;

  FUNCTION fvaGetIndivaTT(inuTipoTrab  IN  ldci_titrindiva.ttivtitr%TYPE,
                          ivaTipoCuen  IN  VARCHAR2,
                          ovaCtcainiv  OUT ldci_itemconta.itemindi%TYPE,
                          ovaItemciva  OUT ldci_itemconta.itemciva%TYPE)
  /************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION   : fvaGetIndivaTT
     AUTOR     : Diego Andres Cardona Garcia
     FECHA     : 29-07-2014
     DESCRIPCION  : Funcion que se encarga de obtener el indicador de acuerdo
                    al tipo de trabajo enviado como parametro

    Parametros de Entrada

    Parametros de Salida

    Historia de Modificaciones
    Autor    Fecha       Descripcion
  ************************************************************************/
  RETURN VARCHAR2
  IS

    --<<
    -- Cursor que obtiene el indicador del tipo de trabajo
    -->>
    CURSOR cuGetIndica
    IS
    SELECT *
      FROM ldci_titrindiva
     WHERE ttivtitr = inuTipoTrab;

    rgcuGetIndica cuGetIndica%ROWTYPE;

  BEGIN

    --<<
    -- Se obtienen el indicador y la cuenta IVA
    -->>
    OPEN cuGetIndica;
    FETCH cuGetIndica INTO rgcuGetIndica;
    CLOSE cuGetIndica;

    --<<
    -- Se valida la variable de entrada que indica si la cuenta es de costo o gasto
    -->>
    IF (ivaTipoCuen = 'C') THEN

      --<<
      -- Se asignan el indicador y la cuenta IVA
      -->>
      ovaCtcainiv := rgcuGetIndica.ttivinco;
      ovaItemciva := rgcuGetIndica.ttivcico;

      RETURN 0;

    ELSIF (ivaTipoCuen = 'G') THEN

      --<<
      -- Se asignan el indicador y la cuenta IVA
      -->>
      ovaCtcainiv := rgcuGetIndica.ttivinga;
      ovaItemciva := rgcuGetIndica.ttivciga;

      RETURN 0;

    END IF;

    --<<
    -- Si no es costo ni gasto, retorna -1
    -->>
    RETURN (-1);

  EXCEPTION
  WHEN OTHERS THEN
       ldci_pkInterfazSAP.vaMensError :=  '[fvaGetIndivaTT] - No se pudo obtener el indicador IVA. '||SQLERRM||' '||DBMS_UTILITY.format_error_backtrace;
       RETURN('-1');
  END fvaGetIndivaTT;

  FUNCTION fvaGetOICos (inudeparta  in ldci_cencoubgtra.ccbgdpto%TYPE,
                        inulocalid  IN ldci_cencoubgtra.ccbgloca%TYPE,
                        inutipotra  IN ldci_cencoubgtra.ccbgtitr%TYPE,
                        inuitem     IN ldci_cencoubgtra.ccbgitem%TYPE,
                        ovacecost   OUT ldci_cencoubgtra.ccbgceco%TYPE,
                        ovaordein   OUT ldci_cencoubgtra.ccbgorin%TYPE)
  return NUMBER
  /************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION   : fvaGetOICos
     AUTOR     : Heiber Barco
     FECHA     : 17-10-2013
     DESCRIPCION  : Tiquete:
                    funcion que se encarga de obtener la orden interna y ceco
                    por localidad, item y tipo de trabajo

    Parametros de Entrada

    Parametros de Salida

    Historia de Modificaciones
    Autor    Fecha       Descripcion
  ************************************************************************/

  is
     cursor cuOrdenInterna
     is
     select * from LDCI_CENCOUBGTRA
     where ccbgdpto = inudeparta
       AND ccbgloca = inulocalid
       AND ccbgtitr = inutipotra
       AND ccbgitem = inuitem;

     rgLDCI_CENCOUBGTRA   LDCI_CENCOUBGTRA%rowtype;

  begin

     open cuOrdenInterna;
     fetch cuOrdenInterna into rgLDCI_CENCOUBGTRA;
     close cuOrdenInterna;

     ovacecost := rgLDCI_CENCOUBGTRA.ccbgceco;
     ovaordein := rgLDCI_CENCOUBGTRA.ccbgorin;

     return(0);

  exception
  when others then
       ldci_pkInterfazSAP.vaMensError :=  '[fvaGetOICos] - No se pudo obtener La Orden Interna. '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
       LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,USER,USERENV('TERMINAL'));
       return(-1);
  end fvaGetOICos;


  FUNCTION fvaGetCuenTipoContrato (inuidtipocontr IN ldci_ctatipcontr.idtipocontr%TYPE)
  /************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION   : fvaGetCuenTipoContrato
     AUTOR     : Heiber Barco
     FECHA     : 17-10-2013
     DESCRIPCION  : Tiquete:
                    funcion que se encarga de obtener la cuenta por pagar

    Parametros de Entrada

    Parametros de Salida

    Historia de Modificaciones
    Autor    Fecha       Descripcion
  ************************************************************************/
  return VARCHAR
  is
     cursor cuCuentaPagar
     is
     select * from LDCI_CTATIPCONTR
     where idtipocontr = inuidtipocontr;

     rgcuCuentaPagar   LDCI_CTATIPCONTR%rowtype;
     vaCuenta          LDCI_CTACADMI.ctcacodi%TYPE;
  begin

     open cuCuentaPagar;
     fetch cuCuentaPagar into rgcuCuentaPagar;
     close cuCuentaPagar;

     vaCuenta := rgcuCuentaPagar.ctapagar;

     return(vaCuenta);

  exception
  when others then
       ldci_pkInterfazSAP.vaMensError :=  '[fvaGetCuenTipoContrato] - No se pudo obtener La cuenta por pagar '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
       LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,USER,USERENV('TERMINAL'));
       return('-1');
  end fvaGetCuenTipoContrato;

  FUNCTION fnuGetTipoContrato (inuidcontr IN ge_contrato.id_contrato%TYPE)
  /************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION   : fvaGetTipoContrato
     AUTOR     : Heiber Barco
     FECHA     : 17-10-2013
     DESCRIPCION  : Tiquete:
                    funcion que se encarga de obtener el tipo de contrato

    Parametros de Entrada

    Parametros de Salida

    Historia de Modificaciones
    Autor    Fecha       Descripcion
  ************************************************************************/
  return NUMBER
  is
     cursor cuContrato
     is
     select * from ge_contrato
     where id_contrato = inuidcontr;

     rgcuContrato   ge_contrato%rowtype;
     nuidtipocontrat ge_contrato.id_tipo_contrato%TYPE;
  begin

     open cuContrato;
     fetch cuContrato into rgcuContrato;
     close cuContrato;

     nuidtipocontrat := rgcuContrato.id_tipo_contrato;

     return(nuidtipocontrat);

  exception
  when others then
       ldci_pkInterfazSAP.vaMensError :=  '[fnuGetCuenTipoContrato] - No se pudo obtener La cuenta por pagar '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
       LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,USER,USERENV('TERMINAL'));
       return(-1);
  end fnuGetTipoContrato;

  FUNCTION fnuInsHistAct(inucodacta      IN ldci_actacont.idacta%TYPE,
                         inucodocont    IN ldci_actacont.codocont%TYPE,
                         ivatipdocont    IN ldci_actacont.tipdocont%TYPE,
                         ivausuario       IN ldci_actacont.usuario%TYPE,
                         idtfechcontabil  IN ldci_actacont.fechcontabiliza%TYPE
                       )
  /************************************************************************
   PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
   FUNCION   : fnuInsHistAct
   AUTOR     : Heiber Barco
   FECHA     : 13-07-2011
   DESCRIPCION  : encargada de almacenar la historia de contabilizacion del acta

  Parametros de Entrada


  Parametros de Salida

  Historia de Modificaciones
  Autor    Fecha       Descripcion
  ************************************************************************/
  RETURN NUMBER
  IS
  -- Variables
  --
  nuExiste  NUMBER:= 0; -- Valor referente si el acta esta contablizada
  -- Cursores
  --
  -- Verifica si existe  el acta contabilizada
  CURSOR cuActas IS
  SELECT count(1) EXIST
  FROM  ldci_actacont
  WHERE idacta = inucodacta;

  BEGIN

  FOR rc_cuActas IN cuActas LOOP

      --Si se encuentra contabilizada
      nuExiste := rc_cuActas.EXIST;

  END LOOP;

  -- El acta se encuentra en la historia se actualiza la fecha y el flag
  IF nuExiste = 0 THEN
     --Insrta la historia
     INSERT INTO ldci_actacont (idacta        , codocont,
                               tipdocont       , usuario       , actcontabiliza , fechcontabiliza)
                       VALUES (inucodacta     , inucodocont,
                               ivatipdocont    ,ivausuario     ,'S'              , idtfechcontabil);

  ELSE
      --Actualiza la historia
      UPDATE ldci_actacont SET fechcontabiliza = SYSDATE,
                              actcontabiliza = 'S',
                              codocont      = inucodocont,
                              tipdocont      = ivatipdocont
       WHERE idacta         = inucodacta;
 END IF;

  RETURN(0);
  exception
  when others then
       ldci_pkInterfazSAP.vaMensError :=  '[fnuInsHistAct] - No se pudo insertar el acta contabilizada '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
       LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,USER,USERENV('TERMINAL'));
       return(-1);

 END fnuInsHistAct;

FUNCTION fvaGetAnticipo (inuidcontrato IN ldci_contranticipo.idcontrato%TYPE)
  /************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION   : fvaGetAnticipo
     AUTOR     : Heiber Barco
     FECHA     : 07-11-2013
     DESCRIPCION  : Tiquete:
                    funcion encargada de obtener el codigo del anticipo x contrato

    Parametros de Entrada

    Parametros de Salida

    Historia de Modificaciones
    Autor    Fecha       Descripcion
  ************************************************************************/
  return VARCHAR
  is
     cursor cuAnticipo
     is
     select * from LDCI_CONTRANTICIPO
     where idcontrato = inuidcontrato;

     rgcuAnticipo   LDCI_CONTRANTICIPO%rowtype;

  begin

     open cuAnticipo;
     fetch cuAnticipo into rgcuAnticipo;
     close cuAnticipo;

     return(rgcuAnticipo.codanticipo);

  exception
  when others then
       ldci_pkInterfazSAP.vaMensError :=  '[fvaGetAnticipo] - No se pudo obtener el anticipo '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
       LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,USER,USERENV('TERMINAL'));
       return('-1');
  end fvaGetAnticipo;

  FUNCTION fvaGetCuenClasi (inutipotrab IN NUMBER)
  /************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION   : fvaGetCuenClasi
     AUTOR     : Heiber Barco
     FECHA     : 12-11-2013
     DESCRIPCION  : Tiquete:
                    funcion que se encarga de obtener la cuenta del clasificador

    Parametros de Entrada

    Parametros de Salida

    Historia de Modificaciones
    Autor    Fecha       Descripcion
  ************************************************************************/
  return VARCHAR
  is
     cursor cuCuentaClasif
     is
     select cuencontabl from ic_clascott, ldci_cuenclasifi
     where clcttitr = inutipotrab
       AND cuenclasifi = clctclco;


     vaCuenta          ldci_cuenclasifi.cuencontabl%TYPE;
  begin

     open cuCuentaClasif;
     fetch cuCuentaClasif into vaCuenta;
     close cuCuentaClasif;

     return(vaCuenta);

  exception
  when others then
       ldci_pkInterfazSAP.vaMensError :=  '[fvaGetCuenClasi] - No se pudo obtener La cuenta del costo '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
       LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,USER,USERENV('TERMINAL'));
       return('-1');
  end fvaGetCuenClasi;

  FUNCTION fvaGetCuGaCoClasi (nuOrden     or_order.order_id%TYPE)
  /************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION   : fvaGetCuGaCoClasi
     AUTOR     : Diego Andres Cardona Garcia
     FECHA     : 01-07-2014
     DESCRIPCION  : funcion que se encarga de obtener la cuenta de costo o gasto del clasificador

    Parametros de Entrada

    Parametros de Salida

    Historia de Modificaciones
    Autor    Fecha       Descripcion
    heiberb  18-02-2015  Se excluyen los tipos de trabajo para gestion cartera.
  ************************************************************************/

  RETURN VARCHAR2
  IS

  --<<
  -- Variables
  -->>
  nuTipotrab      or_order.real_task_type_id%TYPE;
  nuCharge_Status or_order.charge_status%TYPE;
  vaCuentaCosto   ldci_cugacoclasi.cuencosto%TYPE;
  vaCuentaGasto   ldci_cugacoclasi.cuengasto%TYPE;
  vaCuentaRet     ldci_cugacoclasi.cuencosto%TYPE;

  --<<
  -- Cursor para obtener la info de la orden padre en caso de existir
  -->>
  CURSOR cuOrdenPadre
  IS
  SELECT (SELECT oren.task_type_id FROM or_order oren WHERE oren.order_id = ory.order_id) tipo_trab,
         (SELECT oren.charge_status FROM or_order oren WHERE oren.order_id = ory.order_id) estado
    FROM or_related_order ory, or_order ore
   WHERE ory.related_order_id = nuOrden
     AND ore.order_id = ory.related_order_id
     AND ore.task_type_id NOT IN (SELECT task_type_id
                                      FROM or_task_type
                                     WHERE ',' || (SELECT casevalo
                                                     FROM ldci_carasewe
                                                    WHERE casecodi = 'OTGESTCART')
                                               || ',' LIKE '%,' || task_type_id || ',%')
     AND ory.rela_order_type_id IN (SELECT transition_type_id
                                      FROM ge_transition_type
                                     WHERE ',' || (SELECT casevalo
                                                     FROM ldci_carasewe
                                                    WHERE casecodi = 'TIPORELATED')
                                               || ',' LIKE '%,' || transition_type_id || ',%');

  --<<
  -- Cursor para obtener la informacion de la orden de trabajo en caso de que no exista una orden padre
  -->>
  CURSOR cuOrdetrab
  IS
  SELECT task_type_id, charge_status
    FROM or_order
   WHERE order_id = nuOrden;

  --<<
  -- Cursor para obtener las cuentas del clasificador de acuerdo al tipo de trabajo
  -->>
  CURSOR cuCuentaClasif(nuTipoTrab   or_order.real_task_type_id%TYPE)
  IS
  SELECT cuencosto, cuengasto
    FROM ic_clascott, ldci_cugacoclasi
   WHERE clcttitr = nuTipoTrab
     AND clctclco = cuenclasifi;

BEGIN

  --<<
  -- Se valida si tiene orden padre
  -->>
  OPEN cuOrdenPadre;
  FETCH cuOrdenPadre INTO nuTipotrab, nuCharge_Status;
  --<<
  -- Si no existe orden padre
  -->>
  IF (cuOrdenPadre%NOTFOUND) THEN
    --<<
    -- Obtiene la informacion de la orden
    -->>
    OPEN cuOrdetrab;
    FETCH cuOrdetrab INTO nuTipotrab, nuCharge_Status;
    CLOSE cuOrdetrab;
  END IF;
  CLOSE cuOrdenPadre;

  --<<
  -- Se obtienen las cuentas de costo y gasto del clasificador de acuerdo
  -- al tipo de trabajo de la orden
  -->>
  OPEN cuCuentaClasif(nuTipotrab);
  FETCH cuCuentaClasif INTO vaCuentaCosto, vaCuentaGasto;
  CLOSE cuCuentaClasif;

  --<<
  -- Si se genero cargo
  -->>
  IF (nuCharge_Status = 3) THEN

     --<<
     -- Retorna la cuenta de costo
     -->>
     RETURN (vaCuentaCosto);

  --<<
  -- Si no genero cargo
  -->>
  ELSE

    --<<
    -- Retorna la cuenta de gasto
    -->>
    RETURN (vaCuentaGasto);

  END IF;

  EXCEPTION
  WHEN OTHERS THEN
       ldci_pkInterfazSAP.vaMensError :=  '[fvaGetCuGaCoClasi] - No se pudo obtener La cuenta del clasificador '||SQLERRM||' '||DBMS_UTILITY.format_error_backtrace;
       LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,USER,USERENV('TERMINAL'));
       RETURN('-1');

  END fvaGetCuGaCoClasi;

  FUNCTION fvaGetTitrCoGa(nuOrden     or_order.order_id%TYPE)
  /************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION   : fvaGetTitrCoGa
     AUTOR     : Diego Andres Cardona Garcia
     FECHA     : 29-07-2014
     DESCRIPCION  : Funcion que se encarga de definir si la orden se tomara
                    como costo o gasto y el tipo de trabajo con que se validara
                    el indicador de IVA

    Parametros de Entrada

    Parametros de Salida

    Historia de Modificaciones
    Autor    Fecha       Descripcion
    heiberb  18-02-2015  Se excluyen los tipos de trabajo para gestion cartera.
    -------- ----------- -------------------------------------------------
  ************************************************************************/
  RETURN VARCHAR2
  IS

  --<<
  -- Variables
  -->>
  nuTipotrab      or_order.real_task_type_id%TYPE;
  nuCharge_Status or_order.charge_status%TYPE;

  --<<
  -- Cursor para obtener la info de la orden padre en caso de existir
  -->>
  CURSOR cuOrdenPadre
  IS
  SELECT (SELECT oren.task_type_id FROM or_order oren WHERE oren.order_id = ory.order_id) tipo_trab,
         (SELECT oren.charge_status FROM or_order oren WHERE oren.order_id = ory.order_id) estado
    FROM or_related_order ory, or_order ore
   WHERE ory.related_order_id = nuOrden
     AND ore.order_id = ory.related_order_id
     AND ore.task_type_id NOT IN (SELECT task_type_id
                                      FROM or_task_type
                                     WHERE ',' || (SELECT casevalo
                                                     FROM ldci_carasewe
                                                    WHERE casecodi = 'OTGESTCART')
                                               || ',' LIKE '%,' || task_type_id || ',%')
     AND ory.rela_order_type_id IN (SELECT transition_type_id
                                      FROM ge_transition_type
                                     WHERE ',' || (SELECT casevalo
                                                     FROM ldci_carasewe
                                                    WHERE casecodi = 'TIPORELATED')
                                               || ',' LIKE '%,' || transition_type_id || ',%');

  --<<
  -- Cursor para obtener la informacion de la orden de trabajo en caso de que no exista una orden padre
  -->>
  CURSOR cuOrdetrab
  IS
  SELECT task_type_id, charge_status
    FROM or_order
   WHERE order_id = nuOrden;

BEGIN

  --<<
  -- Se valida si tiene orden padre
  -->>
  OPEN cuOrdenPadre;
  FETCH cuOrdenPadre INTO nuTipotrab, nuCharge_Status;
  --<<
  -- Si no existe orden padre
  -->>
  IF (cuOrdenPadre%NOTFOUND) THEN
    --<<
    -- Obtiene la informacion de la orden
    -->>
    OPEN cuOrdetrab;
    FETCH cuOrdetrab INTO nuTipotrab, nuCharge_Status;
    CLOSE cuOrdetrab;
  END IF;
  CLOSE cuOrdenPadre;

  --<<
  -- Si se genero cargo
  -->>
  IF (nuCharge_Status = 3) THEN

     --<<
     -- Retorna el trabajo y la letra C de costo
     -->>
     RETURN (nuTipotrab||'|C');

  --<<
  -- Si no genero cargo
  -->>
  ELSE

    --<<
     -- Retorna el trabajo y la letra C de costo
     -->>
     RETURN (nuTipotrab||'|G');

  END IF;

  EXCEPTION
  WHEN OTHERS THEN
       ldci_pkInterfazSAP.vaMensError :=  '[fvaGetTitrCoGa] - No se pudo obtener La cuenta del clasificador '||SQLERRM||' '||DBMS_UTILITY.format_error_backtrace;
       LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,USER,USERENV('TERMINAL'));
       RETURN('-1');

  END fvaGetTitrCoGa;

  FUNCTION fvaGetClasifi (inutipotrab IN NUMBER)
  /************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION   : fvaGetClasifi
     AUTOR     : Heiber Barco
     FECHA     : 12-11-2013
     DESCRIPCION  : Tiquete:
                    funcion que se encarga de obtener el clasificador

    Parametros de Entrada

    Parametros de Salida

    Historia de Modificaciones
    Autor    Fecha       Descripcion
  ************************************************************************/
  return NUMBER
  is
     cursor cuClasifica
     is
     select clctclco from ic_clascott
     where clcttitr = inutipotrab;


     nuclasifi          ldci_cuenclasifi.cuenclasifi%TYPE;
  begin

     open cuClasifica;
     fetch cuClasifica into nuclasifi;
     close cuClasifica;

     return(nuclasifi);

  exception
  when others then
       ldci_pkInterfazSAP.vaMensError :=  '[fvaGetClasifi] - No se pudo obtener el clasificador '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
       LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,USER,USERENV('TERMINAL'));
       return('-1');
  end fvaGetClasifi;

  FUNCTION fnuInterMaterSAP(inuano IN NUMBER,
                            inumes IN NUMBER)
  RETURN NUMBER IS
  /*****************************************************************************
  Propiedad intelectual Gases de Occidente .
  Function:     fnuInterActActivoSAP
  Descripcion:  Funcion para reportar los Activos-Inversion reportados en un acta al sistema
                SAP.

  NOTA:         Este proceso de intefaz de costos se tomaron los cursores
                actuales que reportan al sistema contable CGUNO.
                Funcion referencia INTERCONTRATOS85AG5(), y
                se extension con el modelo que soporta el sistema SAP

  Parametros de Entrada:
                inuactanume      :Numero del acta
                ivaCodCuentPago  :Cuenta Credito
                ivaDocActicipo   :Documento anticipo
                inuiclitido      :Tipo de comprobante o documento acta
                ivaFactura       :Numero de factura

  Parametros de Salida:
                Ninguno
  Retornos:
                0  No hubo error al ejecutar la funcion.
                -1 Hubo error al ejecutar al funcion.
  Autor:        Heiber Barco
  Fecha:        03-10-2013

  Historia de modificaciones
  Fecha      Autor     Modificacion

  28/12/2016  cramirez    CA 200-1012
  Se Parametriza el IVA para que pueda ser cambiado cada que se necesite

  11-11-2015 cgonzalez SAO. 351118
                       Modificacion de las funciones fnuInterMaterSAP y fnuInterMaterSAPRO
                       elimando de los cursores las tablas or_order_activity orac, ab_address ad.
                       Esto con el fin de solucionar las ordenes sin actividad y
                       ordenes con mas de una actividad.

                       Se crea el parametro TIPOTRABAJOCERO para excluir el tipo de trabajo
                       con codigo cero, hasta el momento de la entrega se tiene
                       definido no contabilizar

  ******************************************************************************/

     /*
     Cursor de que obtiene los registros contables del acta
     */
CURSOR cuMateriales (idacicofein ldc_ciercome.cicofein%TYPE, idacicofech ldc_ciercome.cicofech%TYPE) IS
/*Cursor de que obtiene los movimientos Creditos del acta con Cuenta Puente o Cuenta Inventario*/
SELECT  dcrccons,  dcrcecrc,  dcrccorc,cuenta,SIGNOS,VALOR,
       '|||||||||||||||'||(select GEO_LOCA_FATHER_ID from ge_geogra_location WHERE GEOGRAP_LOCATION_ID = LOCA)||'|'||LOCA||'||||||||||||||||||||||'||
        DCRCINAD DCRCINAD,
        dcrcfecr,  dcrcclcr, user dcrcusua,  dcrcterm,  dcrcprog,  dcrcsist,
        clasificador, ITEM, ESTADO, TIPO
FROM(
SELECT  null dcrccons, null dcrcecrc, null dcrccorc,ldci_pkinterfazactas.fvaGetCuenClasiMat(O.task_type_id) cuenta,
        DECODE(SIGN(Sum(OT.Value*-1)), 1, 'D', 'C') SIGNOS,
        Abs(Sum(Decode(o.charge_status, 3, (OT.Value), ((OT.Value)))))VALOR,
        --'|||||||||||||||'||(select GEO_LOCA_FATHER_ID from ge_geogra_location WHERE GEOGRAP_LOCATION_ID = ad.geograp_location_id)||'|'||ad.geograp_location_id||'||||||||||||||||||||||'||
       (SELECT UNIQUE AD.geograp_location_id
             FROM or_order_activity OA,ab_address AD
            WHERE OA.address_id  =   AD.address_id
              AND OA.order_id    =   OT.order_id)LOCA,
       O.task_type_id||'|'||gi.item_classif_id||'|'||'|||||'||ot.items_id DCRCINAD,
       null dcrcfecr, null dcrcclcr, user dcrcusua, null dcrcterm, null dcrcprog, null dcrcsist,
       ldci_pkinterfazactas.fvaGetClasifimat(O.task_type_id) clasificador, ot.items_id ITEM, o.charge_status ESTADO, 'COSTOS' TIPO
  FROM OR_ORDER O, OR_ORDER_ITEMS OT, GE_ITEMS GI, or_operating_unit ou
 WHERE O.IS_PENDING_LIQ = 'Y'
   AND Trunc(O.LEGALIZATION_DATE) BETWEEN (idacicofein) AND (idacicofech)
   AND OT.ORDER_ID = O.ORDER_ID
   AND OT.VALUE <> 0
   AND GI.ITEMS_ID = OT.ITEMS_ID
   AND GI.ITEM_CLASSIF_ID IN (SELECT item_classif_id
													      FROM ge_item_classif
												       WHERE ',' || ldci_pkinterfazactas.vaItemsMaterial || ',' LIKE
															 '%,' || item_classif_id || ',%')
   AND ou.OPERATING_UNIT_ID = o.operating_unit_id
   AND ou.es_externa = 'N'
   AND O.task_type_id NOT IN (SELECT task_type_id
                                FROM or_task_type
                               WHERE ',' || (SELECT casevalo
                                               FROM ldci_carasewe
                                              WHERE casecodi = 'TIPOTRABAJOCERO')
                              || ',' LIKE '%,' || task_type_id || ',%')

   --  AND o.order_id = 3673219
   GROUP BY O.task_type_id,ot.items_id,gi.item_classif_id,
            ldci_pkinterfazactas.fvaGetClasifimat(O.task_type_id), ot.items_id, o.charge_status,
            Ot.ORDER_ID)

UNION ALL
/*consulta del IVA*/
SELECT dcrccons,dcrcecrc,dcrccorc,cuenta,SIGNOS,VALOR,
       '|||||||||||||||'||
       (select GEO_LOCA_FATHER_ID from ge_geogra_location WHERE GEOGRAP_LOCATION_ID = loca)||'|'||loca ||
       DCRCINAD DCRCINAD,
       dcrcfecr,dcrcclcr,dcrcusua,dcrcterm,dcrcprog,dcrcsist,clasificador,
       ITEM,ESTADO,TIPO
   FROM
       (
       SELECT
       null dcrccons, null dcrcecrc, null dcrccorc,ldci_pkinterfazactas.fvaGetCuenClasiMat(O.task_type_id) cuenta,
       DECODE(SIGN(Sum(OT.Value*-1)), 1, 'D', 'C') SIGNOS,
       Abs(Sum(Decode(o.charge_status, 3, 0, (((OT.Value)*(nuIVA/100)))))) VALOR,

      -- '|||||||||||||||'||(select GEO_LOCA_FATHER_ID from ge_geogra_location WHERE GEOGRAP_LOCATION_ID = ad.geograp_location_id)||'|'||ad.geograp_location_id
       (SELECT UNIQUE AD.geograp_location_id
          FROM or_order_activity OA,ab_address AD
         WHERE OA.address_id  =   AD.address_id
           AND OA.order_id    =   OT.order_id) LOCA,
       '||||||||||||||||'||Decode(o.charge_status, 3, 0, Sum(OT.Value))||'||||||'||
       O.task_type_id||'|'||gi.item_classif_id||'|'||'|||||'||ot.items_id||'|'||'IVA' DCRCINAD,
       null dcrcfecr, null dcrcclcr, user dcrcusua, null dcrcterm, null dcrcprog, null dcrcsist,
       ldci_pkinterfazactas.fvaGetClasifimat(O.task_type_id) clasificador, ot.items_id ITEM, o.charge_status ESTADO, 'IVA' TIPO
  FROM OR_ORDER O, OR_ORDER_ITEMS OT, GE_ITEMS GI, or_operating_unit ou
 WHERE O.IS_PENDING_LIQ = 'Y'
   AND Trunc(O.LEGALIZATION_DATE) BETWEEN (idacicofein) AND (idacicofech)
   AND OT.ORDER_ID = O.ORDER_ID
   AND OT.VALUE <> 0
   AND GI.ITEMS_ID = OT.ITEMS_ID
   AND GI.ITEM_CLASSIF_ID IN (SELECT item_classif_id
													FROM ge_item_classif
												 WHERE ',' || ldci_pkinterfazactas.vaItemsMaterial || ',' LIKE
															 '%,' || item_classif_id || ',%')
   AND ou.OPERATING_UNIT_ID = o.operating_unit_id
   AND ou.es_externa = 'N'
   AND O.task_type_id NOT IN (SELECT task_type_id
                                FROM or_task_type
                               WHERE ',' || (SELECT casevalo
                                               FROM ldci_carasewe
                                              WHERE casecodi = 'TIPOTRABAJOCERO')
                              || ',' LIKE '%,' || task_type_id || ',%')

 --  AND o.order_id = 3673219
   AND o.charge_status <> 3
 GROUP BY ldci_pkinterfazactas.fvaGetCuenClasiMat(O.task_type_id),O.task_type_id,gi.item_classif_id,ot.items_id,
          ldci_pkinterfazactas.fvaGetClasifimat(O.task_type_id), ot.items_id, o.charge_status,OT.order_id)

UNION ALL
/*consulta del costo*/
  SELECT dcrccons,dcrcecrc,dcrccorc,cuenta,SIGNOS,VALOR,
         '|||||||||||||||'||(select GEO_LOCA_FATHER_ID from ge_geogra_location WHERE GEOGRAP_LOCATION_ID = loca)||'|'||loca||DCRCINAD DCRCINAD,
         dcrcfecr,dcrcclcr,dcrcusua,dcrcterm,dcrcprog,dcrcsist,clasificador,
         ITEM, ESTADO, TIPO
    FROM
     (
   SELECT null dcrccons, null dcrcecrc, null dcrccorc,Decode(o.charge_status, 3, ltr.ticucost, ltr.ticugast) cuenta,
          DECODE(SIGN(Sum((OT.Value))), 1, 'D', 'C') SIGNOS,
          Abs(Sum(Decode(o.charge_status, 3, (OT.Value), ((OT.Value*(1+(nuIVA/100)))))))VALOR,
          --  '|||||||||||||||'||(select GEO_LOCA_FATHER_ID from ge_geogra_location WHERE GEOGRAP_LOCATION_ID = ad.geograp_location_id)||'|'||ad.geograp_location_id||
          (SELECT UNIQUE AD.geograp_location_id
          FROM or_order_activity OA,ab_address AD
         WHERE OA.address_id  =   AD.address_id
           AND OA.order_id    =   OT.order_id) LOCA,

          '||||||||||||||||||||||'||
          O.task_type_id||'|'||gi.item_classif_id||'|'||'|||||'||ot.items_id DCRCINAD,
          null dcrcfecr, null dcrcclcr, user dcrcusua, null dcrcterm, null dcrcprog, null dcrcsist,
          ldci_pkinterfazactas.fvaGetClasifimat(O.task_type_id) clasificador, ot.items_id ITEM, o.charge_status ESTADO, 'ACTIVO' TIPO
  FROM OR_ORDER O, OR_ORDER_ITEMS OT, GE_ITEMS GI,or_operating_unit ou,ldci_titrcuco ltr
 WHERE O.IS_PENDING_LIQ = 'Y'
   AND Trunc(O.LEGALIZATION_DATE) BETWEEN (idacicofein) AND (idacicofech)
   AND OT.ORDER_ID = O.ORDER_ID
   AND OT.VALUE <> 0
   AND GI.ITEMS_ID = OT.ITEMS_ID
   AND GI.ITEM_CLASSIF_ID IN (SELECT item_classif_id
													FROM ge_item_classif
												 WHERE ',' || ldci_pkinterfazactas.vaItemsMaterial || ',' LIKE
															 '%,' || item_classif_id || ',%')
   AND ou.OPERATING_UNIT_ID = o.operating_unit_id
   AND ou.es_externa = 'N'
   AND O.task_type_id NOT IN (SELECT task_type_id
                                FROM or_task_type
                               WHERE ',' || (SELECT casevalo
                                               FROM ldci_carasewe
                                              WHERE casecodi = 'TIPOTRABAJOCERO')
                              || ',' LIKE '%,' || task_type_id || ',%')

  -- AND o.order_id = 3673219
   AND ltr.ticutitr = O.task_type_id
   GROUP BY ldci_pkinterfazactas.fvaGetCuenClasiMat(O.task_type_id),O.task_type_id,gi.item_classif_id,ot.items_id,
            ot.items_id, o.charge_status, o.charge_status, ltr.ticucost, ltr.ticugast,OT.order_id);


   CURSOR cuFechas (nuano NUMBER, numes NUMBER) IS
     SELECT cicofein, cicofech
       FROM ldc_ciercome
      WHERE cicoano = nuano
        AND cicomes = numes;

   CURSOR cuValidacion(ivatipo VARCHAR2, nuano NUMBER, numes NUMBER) IS
     SELECT Count(*)
       FROM ldci_registrainterfaz
      WHERE ldtipointerfaz = ivatipo
        AND ldanocontabi = nuano
        AND ldmescontab = numes
        AND ldflagcontabi = 'S';

 CURSOR cuLibro (ivatido LDCI_TIPOINTERFAZ.tipointerfaz%TYPE)  IS
   SELECT cod_comprobante
     FROM ldci_tipointerfaz
    WHERE tipointerfaz = ivatido;

  -- Private type declarations


  -- Private constant declarations
    nuCantidad       NUMBER:= 0;

  -- Private variable declarations
  nuCount          NUMBER := 0;
  gnuComodin       NUMBER;
  nuRet NUMBER;
  nuErrMail        number;
  sender   varchar2(2000) := dald_parameter.fsbgetvalue_chain('LDC_SMTP_SENDER');
  error            EXCEPTION;  -- Manejo de errores en la inserccion de los datos contables en LDCI_INCOLIQU
  vaClave        ldci_claveconta.clavcodi%TYPE;
  iovactcaicme    LDCI_CTACADMI.ctcaicme%TYPE;
  iovactcainiv    LDCI_CTACADMI.ctcainiv%TYPE;
  iovaitemincm    LDCI_CTACADMI.ctcaicme%TYPE;
  iovaitemindi    LDCI_ITEMCONTA.itemindi%TYPE;
  iovactcatire    LDCI_INTEMINDICA.itemtire%TYPE;
  iovactcainre    LDCI_INTEMINDICA.iteminre%TYPE;
  iovactcaitem    LDCI_INTEMINDICA.itemcate%TYPE;
  iovacuentaiva   LDCI_ITEMCONTA.itemciva%TYPE;
  sbFechaGen DATE;
  vaCuenta ldci_cuentacontable.cuctcodi%TYPE;
  vaCuentaDiverg ldci_cuentacontable.cuctcodi%TYPE;
  ivaiclitido VARCHAR2(2):= 'LD';
  idafecini ldc_ciercome.cicofein%TYPE;
  idafecfin ldc_ciercome.cicofech%TYPE;
  nuCount1 NUMBER := 0;
  nuComprobante NUMBER := 0;
  vaEnviaInterfazMA    VARCHAR2(1);                    --Parametro para el control de envio de Interfaces a SAP
  nuTipoTrabCero       NUMBER;

  TYPE tyInfoMate IS TABLE OF cuMateriales%ROWTYPE INDEX BY BINARY_INTEGER;
    vtyInfoMate tyInfoMate;

 BEGIN
    LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,'Inicia Interfaz',to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
     --<<
    -- Parametros de intrefaz
    --<<
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'GRLEDGER', ldci_pkinterfazsap.vaGRLEDGER, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'SOCIEDAD', ldci_pkinterfazsap.vaSOCIEDAD, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CURRENCY', ldci_pkinterfazsap.vaCURRENCY, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CEBE_GENERAL', ldci_pkinterfazactas.gvacebegral, osbErrorMessage);
    ldci_pkInterfazSAP.vaCODINTINTERFAZ:=ivaiclitido;
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CONDIPAGO', ldci_pkinterfazsap.vaCODPAGO, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'NIT_TERC_SALIDA_CONS_MATER_SAP', ldci_pkinterfazsap.vaNit_Materiales, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'MATERIAIVA', ldci_pkinterfazactas.vaConIva, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'MATERIHERRA', ldci_pkinterfazactas.vaItemsMaterial, osbErrorMessage);
    ldci_pkinterfazsap.vaGRLEDGER := ldci_pkinterfazactas.fvaGetLibro(ivaiclitido);
    ldci_pkwebservutils.proCaraServWeb('WS_INTER_CONTABLE', 'ENVIAINTERFAZMA', vaEnviaInterfazMA, osbErrorMessage);

    --<<
    -- Documento contable que determina el  tipo de acta(costos,activos fijos,fnb)
    -->>
    ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP := ivaiclitido;

    --<<
    -- Borra los datos en memmoria
    -->>


    --<<
    -- Cantidad de registros
    -->>
     OPEN cuValidacion(ivaiclitido, inuano, inumes);
     FETCH cuValidacion INTO nuCount1;
     CLOSE cuValidacion;

     IF nuCount1 > 0 THEN

     LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,'Interfaz ya Contabilizada en este periodo '||inuano||' - '||inumes,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
     ldci_ProcesosInterfazSap.proGenMailErrorInterfaz('M',ivaiclitido,null,null,inuano,inumes,sender,nuErrMail);

     ELSE

      OPEN cuLibro (ivaiclitido);
      FETCH cuLibro INTO nuComprobante;
      CLOSE cuLibro;

    --DBMS_OUTPUT.PUT_LINE('Identificador InterfazCostos: '||ldci_pkInterfazSAP.nuSeqICLINUDO);
      OPEN  cuFechas (inuano, inumes);
      FETCH cuFechas INTO idafecini, idafecfin;
      CLOSE cuFechas;



        OPEN cuMateriales (idafecini, idafecfin);
        FETCH cuMateriales BULK COLLECT INTO vtyInfoMate;
        CLOSE cuMateriales;




      IF (vtyInfoMate.count > 0) THEN

    --<<
    --Obtencion del  numero de documento
    -->>
    ldci_pkInterfazSAP.nuSeqICLINUDO := ldci_pkInterfazSAP.fnuSeq_ldci_incoliqu;


          FOR i IN vtyInfoMate.First..vtyInfoMate.Last LOOP
          vaDiverge := 'N';
          vaClave := NULL;
          vaCuenta := NULL;
          vaCuentaDiverg := NULL;
          iovaitemindi := NULL;
          iovaitemincm := NULL;
          ldci_pkinterfazsap.vaCentBen := NULL;
          ldci_pkinterfazsap.vaNit := NULL;
          ldci_pkinterfazsap.vaNitAnti := NULL;
          ldci_pkinterfazsap.vaMaterialIva := NULL;
          ldci_pkinterfazsap.vaMaterialAct := NULL;
          iovactcatire := NULL;
          iovactcainre := NULL;
          iovactcaitem := NULL;
          iovacuentaiva := NULL;
        --  Dbms_Output.Put_Line('la cuenta es '||vtyInfoActas(i).cuenta);
         -- Dbms_Output.Put_Line('Valor parametro '||ldci_pkinterfazsap.vaCuentaParticu);

          IF vtyInfoMate(i).TIPO = 'COSTOS' THEN  --valida si es cuenta puente
             ldci_pkinterfazsap.vaCentBen := ldci_pkinterfazactas.gvacebegral;
             ldci_pkinterfazsap.vaMaterialAct := 'COSTOS';
             IF  vtyInfoMate(i).estado = 3 THEN

             iovaitemindi := 'A0';

             iovacuentaiva := vtyInfoMate(i).cuenta;

             ELSE

            -- nuRet := ldci_pkinterfazactas.fvaGetIndicadore(vtyInfoMate(i).item, vtyInfoMate(i).clasificador, iovactcatire, iovactcainre, iovactcaitem);
             nuRet := ldci_pkinterfazactas.fvaGetIndiva(vtyInfoMate(i).item, iovaitemindi, iovacuentaiva);

            -- iovaitemindi := 'F1';
             iovacuentaiva := vtyInfoMate(i).cuenta;

             END IF;

             --<<
             -- Heiberb
             -- 01/08/2014
             -- SE asigna la cuenta del clasificador cuando el indicador no tiene cuenta de IVA
             -->>
             ELSIF (vtyInfoMate(i).TIPO = 'IVA') THEN

              ldci_pkinterfazsap.vaCentBen := ldci_pkinterfazactas.gvacebegral;
              ldci_pkinterfazsap.vaMaterialIva := 'IVA';

              IF  vtyInfoMate(i).estado = 3 THEN

                  nuRet := ldci_pkinterfazactas.fvaGetIndiva(vtyInfoMate(i).item, iovaitemindi, iovacuentaiva);

                  iovaitemindi := 'T0';

                  IF iovacuentaiva IS NULL THEN

                  iovacuentaiva := vtyInfoMate(i).cuenta;

                  END IF;


              ELSE
                 --<<
                  --heiberb se debe cambiar por parametro
                  -->>
                  Dbms_Output.Put_Line('el item iva es '||vtyInfoMate(i).item);
                  nuRet := ldci_pkinterfazactas.fvaGetIndiva(vtyInfoMate(i).item, iovaitemindi, iovacuentaiva);
                  iovaitemindi := 'A3';
                  iovacuentaiva := '2445010000';

              END IF;

           ELSIF (vtyInfoMate(i).TIPO = 'ACTIVO') THEN


              IF  vtyInfoMate(i).estado = 3 THEN

              nuRet := ldci_pkinterfazactas.fvaGetIndiva(vtyInfoMate(i).item, iovaitemindi, iovacuentaiva);

              iovaitemindi := 'T0';

              iovacuentaiva := vtyInfoMate(i).cuenta;

              ELSE

              iovaitemindi := 'F1';
              --nuRet := ldci_pkinterfazactas.fvaGetIndiva(vtyInfoMate(i).item, iovaitemindi, iovacuentaiva);

              iovacuentaiva := vtyInfoMate(i).cuenta;

              END IF;

           END IF;


             -- ldci_pkinterfazsap.vaCentBen := ldci_pkinterfazactas.gvacebegral;
              --<<
              --obtiene la clave contable a partir de la cuenta
              -->>
              vaClave := ldci_pkInterfazSAP.fvaGetClaveConta(iovacuentaiva, vtyInfoMate(i).signos,  iovactcaicme, iovactcainiv);







              vaDiverge := ldci_pkinterfazsap.fnuCtaDiver(vaClave);




              IF vaDiverge = 'S' THEN

              vaCuentaDiverg := iovacuentaiva;

              END IF;


            ldci_pkinterfazSAP.vaNit := ldci_pkinterfazsap.vaNit_Materiales;

         -- Dbms_Output.Put_Line('inserta incoliqu ');
            nuRet := ldci_pkinterfazsap.fnuLDCI_INCOLIQUMAT(ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,
                                                  ldci_pkInterfazSAP.nuSeqICLINUDO,
                                                  sysdate,
                                                  user,
                                                  'SERVER',
                                                  sysdate,
                                                  null,
                                                  vaClave,
                                                  iovacuentaiva,--cuenta,
                                                  iovaitemincm,--null,
                                                  (vtyInfoMate(i).VALOR),
                                                  (vtyInfoMate(i).VALOR),
                                                  iovaitemindi,
                                                  NULL,
                                                  null,
                                                  null,
                                                  null,
                                                  null,
                                                  null,
                                                  iovactcatire,
                                                  iovactcainre,
                                                  null,
                                                  i,
                                                  vaCuentaDiverg,
                                                  vtyInfoMate(i).dcrcinad,
                                                  nuComprobante);

            END LOOP;

            nuRet := ldci_pkInterfazSAP.fnuINSELDCI_INCOLIQU;
            --<<
            --Genera la informacion de los documentos para SAP de la interfaz de INGRESOS
            -->>
            --<<
          --Se lanza la Exepcion
          -->>
          IF (nuRet <> 0) THEN

              RAISE ERROR;
          END IF;

            nuRet := ldci_pkInterfazSAP.fnuGeneDocuSapMat(ldci_pkInterfazSAP.nuSeqICLINUDO);
         -- Dbms_Output.Put_Line('inserta detalles ');

            --<<
          --Se lanza la Exepcion
          -->>
          IF (nuRet <> 0) THEN
              LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
              RAISE ERROR;
          END IF;

        nuRet := ldci_pkinterfazsap.fnuAjusteInterCont(ldci_pkInterfazSAP.nuSeqICLINUDO);
         --<<
         -- Si es satifactorio todo el proceso, se realiza el envio a SAP
         -->>
         IF (vaEnviaInterfazMA = 'S') THEN
            ldci_pkintercontablemesa.proEnviaDocContable(ldci_pkInterfazSAP.nuSeqICLINUDO);
         END IF;

         -- envia correo notificando el envio de la interfaz a SAP
         ldci_ProcesosInterfazSap.proGenMailInterfaz (ldci_pkinterfazsap.nuSeqICLINUDO,ivaiclitido,sender,nuErrMail);


         nuRet := ldci_pkinterfazsap.fnuRegistraInterfazAnioMes(ldci_pkinterfazsap.nuSeqICLINUDO,inuano,inumes,'S',ivaiclitido);
   -- Validacion si se inserto historia contable
       IF (nuRet <> 0) THEN
           LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
           RAISE Error;
       END IF;

      ELSE
        LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,'No se encontraron datos a procesar en el periodo '||inuano||' - '||inumes,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
        ldci_ProcesosInterfazSap.proGenMailErrorInterfaz('M',ivaiclitido,null,null,inuano,inumes,sender,nuErrMail);
      END IF;
   END IF;
     --<<
     --Inserta los datos en la tabla LDCI_INCOLIQU
     -->>

    return 0;
   exception
  when others then
       ldci_pkInterfazSAP.vaMensError :=  '[fnuInterMaterSAP] - No se proceso la interfaz de materiales. '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
       LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,USER,USERENV('TERMINAL'));
       ldci_ProcesosInterfazSap.proGenMailErrorInterfaz('M',ivaiclitido,null,null,inuano,inumes,sender,nuErrMail);
       return(-1);
 END fnuInterMaterSAP;

  FUNCTION fnuInterMaterSAPRO(inuano IN NUMBER,
                              inumes IN NUMBER)
  /*****************************************************************************
  Propiedad intelectual Gases de Occidente .
  Function:     fnuInterMaterSAPRO
  Descripcion:  Copia del metodo fnuInterMaterSAP. Funcion para reportar los
                Activos-Inversion reportados en un acta al sistema SAP.

  NOTA:         Este proceso de intefaz de costos se tomaron los cursores
                actuales que reportan al sistema contable CGUNO.
                Funcion referencia INTERCONTRATOS85AG5(), y se extension con
                el modelo que soporta el sistema SAP

  Parametros de Entrada:
    inuactanume      :Numero del acta
    ivaCodCuentPago  :Cuenta Credito
    ivaDocActicipo   :Documento anticipo
    inuiclitido      :Tipo de comprobante o documento acta
    ivaFactura       :Numero de factura

  Parametros de Salida:
    Ninguno

  Retornos:
    0  No hubo error al ejecutar la funcion.
    -1 Hubo error al ejecutar al funcion.

  Autor:        Diego Andres Cardona Garcia
  Fecha:        31-07-2014

  Historia de modificaciones
  Fecha       Autor      Modificacion

  28/12/2016  cramirez    CA 200-1012
  Se Parametriza el IVA para que pueda ser cambiado cada que se necesite

  29-04-2015  heiberb    Sao 316065 se adiciona criterio a la consulta para que excluya oredenes sin mov en inventario
  11-11-2015 cgonzalez   SAO. 351118
                         Modificacion de las funciones fnuInterMaterSAP y fnuInterMaterSAPRO
                         elimando de los cursores las tablas or_order_activity orac, ab_address ad.
                         Esto con el fin de solucionar las ordenes sin actividad y
                         ordenes con mas de una actividad.

                         Se crea el parametro TIPOTRABAJOCERO para excluir el tipo de trabajo
                         con codigo cero, hasta el momento de la entrega se tiene
                         definido no contabilizar.

  31-05-2016  edmlar     CA- 100-10632 Se modifica el cursor cuMateriales y a la consulta del IVA se
                         le quita la condicion donde el tipo de trabajo es con cargo al usuario, este
                         arreglo se hace en el WHERE y en el valor..

  -------- ---------- ----------------------------------------------------------
  ******************************************************************************/
  RETURN NUMBER
  IS

  /*
  Cursor de que obtiene los registros contables de materiales
  */
  CURSOR cuMateriales (idacicofein ldc_ciercome.cicofein%TYPE, idacicofech ldc_ciercome.cicofech%TYPE)
  IS
  /*Cursor que obtiene los movimientos Creditos del acta con costo*/
SELECT   dcrccons,dcrcecrc,dcrccorc,cuenta,SIGNOS,VALOR,
         '|||||||||||||||'||(select GEO_LOCA_FATHER_ID from ge_geogra_location WHERE GEOGRAP_LOCATION_ID = loca)||'|'||loca||DCRCINAD DCRCINAD,
         dcrcfecr,dcrcclcr,dcrcusua,dcrcterm,dcrcprog,dcrcsist,clasificador,
         ITEM, ESTADO, TIPO
  FROM
      (
  SELECT  null dcrccons, null dcrcecrc, null dcrccorc,ldci_pkinterfazactas.fvaGetCuGaCoClasi(o.order_id) cuenta,
         DECODE(SIGN(Sum(OT.Value)), 1, 'D', 'C') SIGNOS,
         --<<
         -- Edmundo E. Lara -- 31/05/2016  CA = 100-10632
         --
         Abs(sum(OT.Value+(OT.Value*(nuIVA/100))))VALOR,
         --Abs(Sum(Decode(o.charge_status, 3, (OT.Value), ((OT.Value+(OT.Value*0.16))))))VALOR,
         -->>
      --   '|||||||||||||||'||(select GEO_LOCA_FATHER_ID from ge_geogra_location WHERE GEOGRAP_LOCATION_ID = ad.geograp_location_id)||'|'||ad.geograp_location_id
         (SELECT UNIQUE AD.geograp_location_id
          FROM or_order_activity OA,ab_address AD
         WHERE OA.address_id  =   AD.address_id
           AND OA.order_id    =   o.order_id) LOCA,

         '||||||||||||||||||||||'||Decode(ldci_pkinterfazactas.fnuGetTipoTrab(o.order_id),0, O.task_type_id,ldci_pkinterfazactas.fnuGetTipoTrab(o.order_id))||'|'||gi.item_classif_id||'|'||'|||||'||ot.items_id||'||||'||o.order_id DCRCINAD,
         null dcrcfecr, null dcrcclcr, user dcrcusua, null dcrcterm, null dcrcprog, null dcrcsist,
         ldci_pkinterfazactas.fvaGetClasifi(O.task_type_id) clasificador, ot.items_id ITEM, o.charge_status ESTADO, 'COSTOS' TIPO
    FROM OR_ORDER O, OR_ORDER_ITEMS OT, GE_ITEMS GI, or_operating_unit ou, open.ge_causal gc
   WHERE Trunc(O.LEGALIZATION_DATE) BETWEEN (idacicofein) AND (idacicofech)
     AND O.order_status_id    = 8  -- legalizada
     AND O.causal_id         =  gc.causal_id
     AND gc.class_causal_id  =  1
     AND OT.ORDER_ID = O.ORDER_ID
     AND OT.VALUE <> 0
     AND O.TASK_TYPE_ID <> 0
     AND GI.ITEMS_ID = OT.ITEMS_ID
     AND GI.ITEM_CLASSIF_ID IN (SELECT item_classif_id
                            FROM ge_item_classif
                           WHERE ',' || ldci_pkinterfazactas.vaItemsMaterial || ',' LIKE
                                 '%,' || item_classif_id || ',%')
     AND ou.OPERATING_UNIT_ID = o.operating_unit_id
     AND O.task_type_id NOT IN (SELECT task_type_id
                                  FROM or_task_type
                                 WHERE ',' || (SELECT casevalo
                                                 FROM ldci_carasewe
                                                WHERE casecodi = 'TIPOTRABAJOCERO')
                                || ',' LIKE '%,' || task_type_id || ',%')

     --  AND o.order_id = 3673219
     GROUP BY ldci_pkinterfazactas.fvaGetCuGaCoClasi(o.order_id), O.task_type_id,ot.items_id,gi.item_classif_id,
              ldci_pkinterfazactas.fvaGetClasifi(O.task_type_id), ot.items_id, o.charge_status, o.order_id)
  UNION ALL
/*consulta del IVA*/
SELECT dcrccons, dcrcecrc, dcrccorc, cuenta, SIGNOS,VALOR,
       '|||||||||||||||'||(select GEO_LOCA_FATHER_ID from ge_geogra_location WHERE GEOGRAP_LOCATION_ID = loca)||'|'||loca||
       DCRCINAD DCRCINAD,
       dcrcfecr,dcrcclcr,dcrcusua,dcrcterm,dcrcprog,dcrcsist,
       clasificador,ITEM,ESTADO,TIPO
  FROM
  (
  SELECT null dcrccons, null dcrcecrc, null dcrccorc, ldci_pkinterfazactas.fvaGetCuGaCoClasi(o.order_id) cuenta,
         DECODE(SIGN(Sum(OT.Value*-1)), 1, 'D', 'C') SIGNOS,
       --<<
       -- Edmundo E. Lara -- 31/05/2016  CA = 100-10632
       --
       Abs(Sum((((OT.Value)*(nuIVA/100))))) VALOR,
       --Abs(Sum(Decode(o.charge_status, 3, 0, (((OT.Value)*0.16))))) VALOR,
       -->>
        --'|||||||||||||||'||(select GEO_LOCA_FATHER_ID from ge_geogra_location WHERE GEOGRAP_LOCATION_ID = ad.geograp_location_id)||'|'||ad.geograp_location_id
        (SELECT UNIQUE AD.geograp_location_id
          FROM or_order_activity OA,ab_address AD
         WHERE OA.address_id  =   AD.address_id
           AND OA.order_id    =   o.order_id) LOCA,

         '||||||||||||||||'||Decode(o.charge_status, 3, 0, Sum(OT.Value))||'||||||'||
         Decode(ldci_pkinterfazactas.fnuGetTipoTrab(o.order_id),0, O.task_type_id,ldci_pkinterfazactas.fnuGetTipoTrab(o.order_id))||'|'||gi.item_classif_id||'|'||'|||||'||ot.items_id||'||||'||o.order_id DCRCINAD,
         null dcrcfecr, null dcrcclcr, user dcrcusua, null dcrcterm, null dcrcprog, null dcrcsist,
         ldci_pkinterfazactas.fvaGetClasifi(O.task_type_id) clasificador, ot.items_id ITEM, o.charge_status ESTADO, 'IVA' TIPO
    FROM OR_ORDER O, OR_ORDER_ITEMS OT, GE_ITEMS GI, or_operating_unit ou, open.ge_causal gc
   WHERE Trunc(O.LEGALIZATION_DATE) BETWEEN (idacicofein) AND (idacicofech)
     AND O.order_status_id = 8
     AND O.causal_id         =  gc.causal_id
     AND gc.class_causal_id  =  1
     AND OT.ORDER_ID = O.ORDER_ID
     AND OT.VALUE <> 0
     AND O.TASK_TYPE_ID <> 0
     AND GI.ITEMS_ID = OT.ITEMS_ID
     AND GI.ITEM_CLASSIF_ID IN (SELECT item_classif_id
                            FROM ge_item_classif
                           WHERE ',' || ldci_pkinterfazactas.vaItemsMaterial || ',' LIKE
                                 '%,' || item_classif_id || ',%')
     AND ou.OPERATING_UNIT_ID = o.operating_unit_id
     AND O.task_type_id NOT IN (SELECT task_type_id
                                  FROM or_task_type
                                 WHERE ',' || (SELECT casevalo
                                                 FROM ldci_carasewe
                                                WHERE casecodi = 'TIPOTRABAJOCERO')
                                || ',' LIKE '%,' || task_type_id || ',%')

     --  AND o.order_id = 3673219
     --<<
     -- Edmundo E. Lara -- 31/05/2016  CA = 100-10632
     --
     --AND o.charge_status <> 3
     -->>
     GROUP BY ldci_pkinterfazactas.fvaGetCuGaCoClasi(o.order_id),O.task_type_id,
              gi.item_classif_id,ot.items_id, ot.items_id, o.charge_status, o.order_id)

  UNION ALL
  /*consulta del Cuenta Puente o Cuenta Inventario*/
SELECT dcrccons, dcrcecrc, dcrccorc, cuenta, SIGNOS,VALOR,
       '|||||||||||||||'||(select GEO_LOCA_FATHER_ID from ge_geogra_location WHERE GEOGRAP_LOCATION_ID = LOCA)||'|'||LOCA ||
        DCRCINAD DCRCINAD,
       dcrcfecr,dcrcclcr,  dcrcusua, dcrcterm,dcrcprog,
       dcrcsist,clasificador,ITEM,ESTADO,TIPO
  FROM
      (
  SELECT null dcrccons, null dcrcecrc, null dcrccorc, NULL cuenta,
         DECODE(SIGN(Sum((OT.Value*-1))), 1, 'D', 'C') SIGNOS,
         Abs(Sum(Decode(o.charge_status, 3, (OT.Value), ((OT.Value)))))VALOR,
       --  '|||||||||||||||'||(select GEO_LOCA_FATHER_ID from ge_geogra_location WHERE GEOGRAP_LOCATION_ID = ad.geograp_location_id)'|'||ad.geograp_location_id
        (SELECT UNIQUE AD.geograp_location_id
                  FROM or_order_activity OA,ab_address AD
                WHERE OA.address_id  =   AD.address_id
                  AND OA.order_id    =   o.order_id) LOCA,

         '||||||||||||||||||||||'||Decode(ldci_pkinterfazactas.fnuGetTipoTrab(o.order_id),0, O.task_type_id,ldci_pkinterfazactas.fnuGetTipoTrab(o.order_id))||'|'||gi.item_classif_id
         ||'|'||'|||||'||ot.items_id||'||||'||o.order_id DCRCINAD,
         null dcrcfecr, null dcrcclcr, user dcrcusua, null dcrcterm,
         null dcrcprog, null dcrcsist, ldci_pkinterfazactas.fvaGetClasifi(O.task_type_id) clasificador,
         ot.items_id ITEM, o.charge_status ESTADO, 'ACTIVO' TIPO
    FROM OR_ORDER O, OR_ORDER_ITEMS OT, GE_ITEMS GI,or_operating_unit ou, open.ge_causal gc
   WHERE Trunc(O.LEGALIZATION_DATE) BETWEEN (idacicofein) AND (idacicofech)
     AND O.order_status_id    = 8
     AND O.causal_id         =  gc.causal_id
     AND gc.class_causal_id  =  1
     AND OT.ORDER_ID = O.ORDER_ID
     AND OT.VALUE <> 0
     AND O.TASK_TYPE_ID <> 0
     AND GI.ITEMS_ID = OT.ITEMS_ID
     AND GI.ITEM_CLASSIF_ID IN (SELECT item_classif_id
                            FROM ge_item_classif
                           WHERE ',' || ldci_pkinterfazactas.vaItemsMaterial || ',' LIKE
                                 '%,' || item_classif_id || ',%')
     AND ou.OPERATING_UNIT_ID = o.operating_unit_id
     AND O.task_type_id NOT IN (SELECT task_type_id
                                  FROM or_task_type
                                 WHERE ',' || (SELECT casevalo
                                                 FROM ldci_carasewe
                                                WHERE casecodi = 'TIPOTRABAJOCERO')
                                || ',' LIKE '%,' || task_type_id || ',%')

     -- AND o.order_id = 3673219
     GROUP BY O.task_type_id,gi.item_classif_id,ot.items_id,
              ot.items_id, o.charge_status, o.charge_status, o.order_id);



   CURSOR cuFechas (nuano NUMBER, numes NUMBER)
   IS
   SELECT cicofein, cicofech
     FROM ldc_ciercome
    WHERE cicoano = nuano
      AND cicomes = numes;

   CURSOR cuValidacion(ivatipo VARCHAR2, nuano NUMBER, numes NUMBER)
   IS
   SELECT Count(*)
     FROM ldci_registrainterfaz
    WHERE ldtipointerfaz = ivatipo
      AND ldanocontabi = nuano
      AND ldmescontab = numes
      AND ldflagcontabi = 'S';

   CURSOR cuLibro (ivatido LDCI_TIPOINTERFAZ.tipointerfaz%TYPE)
   IS
   SELECT cod_comprobante
     FROM ldci_tipointerfaz
    WHERE tipointerfaz = ivatido;

    --<<
    -- CA - 200-2529
    -- Cursor para obterner el nit de la LDC que ejecuta el proceso.
    --
    CURSOR cuSistema
    IS
    SELECT s.sistnitc
      FROM sistema s;

    vsbnit     sistema.sistnitc%type;
  -- Private type declarations


  -- Private constant declarations
    nuCantidad       NUMBER:= 0;

  -- Private variable declarations
  nuCount          NUMBER := 0;
  gnuComodin       NUMBER;
  nuRet NUMBER;
  error            EXCEPTION;  -- Manejo de errores en la inserccion de los datos contables en LDCI_INCOLIQU
  nuErrMail        number;
  sender   varchar2(2000) := dald_parameter.fsbgetvalue_chain('LDC_SMTP_SENDER');
  vaClave         ldci_claveconta.clavcodi%TYPE;
  iovactcaicme    LDCI_CTACADMI.ctcaicme%TYPE;
  iovactcainiv    LDCI_CTACADMI.ctcainiv%TYPE;
  iovaitemincm    LDCI_CTACADMI.ctcaicme%TYPE;
  iovaitemindi    LDCI_ITEMCONTA.itemindi%TYPE;
  iovactcatire    LDCI_INTEMINDICA.itemtire%TYPE;
  iovactcainre    LDCI_INTEMINDICA.iteminre%TYPE;
  iovactcaitem    LDCI_INTEMINDICA.itemcate%TYPE;
  iovacuentaiva   LDCI_ITEMCONTA.itemciva%TYPE;
  sbFechaGen      DATE;
  vaCuenta        ldci_cuentacontable.cuctcodi%TYPE;
  vaCuentaDiverg  ldci_cuentacontable.cuctcodi%TYPE;
  ivaiclitido     VARCHAR2(2):= 'LD';
  idafecini       ldc_ciercome.cicofein%TYPE;
  idafecfin       ldc_ciercome.cicofech%TYPE;
  nuCount1        NUMBER := 0;
  nuComprobante   NUMBER := 0;
  vaIndActCobSus  LDCI_ITEMCONTA.itemindi%TYPE;        -- Indicador de Activos con cobro al suscriptor
  vaIndIvaSinCob  LDCI_ITEMCONTA.itemindi%TYPE;        -- Indicador de IVA sin cobro al suscriptor
  vaCuentaIva     LDCI_ITEMCONTA.itemciva%TYPE;        -- Cuenta IVA sin cobro al suscriptor
  vaIndCosCobSus  LDCI_ITEMCONTA.itemindi%TYPE;        -- Indicador de Costos con cobro al suscriptor
  vaIndCosSinCob  LDCI_ITEMCONTA.itemindi%TYPE;        -- Indicador de Costos sin cobro al suscriptor
  vaClasiActivos  VARCHAR2(2000);                      -- Clasificadores de activos
  vaClCoCodi      ic_clascont.clcocodi%TYPE;           -- Clasificador de acuerdo al tipo de trabajo
  vaCtaMatAct     ldci_cuentacontable.cuctcodi%TYPE;   -- Cuenta de materiales para activos
  vaCtaMateCG     ldci_cuentacontable.cuctcodi%TYPE;   -- Cuenta de materiales para costo/gasto
  vaEnviaInterfazMA    VARCHAR2(1);                    -- Parametro para el control de envio de Interfaces a SAP

  TYPE tyInfoMate IS TABLE OF cuMateriales%ROWTYPE INDEX BY BINARY_INTEGER;
    vtyInfoMate tyInfoMate;

 BEGIN

    LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,'Inicia Interfaz',to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));

    --<<
    -- Parametros de intrefaz
    --<<
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'GRLEDGER', ldci_pkinterfazsap.vaGRLEDGER, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'SOCIEDAD', ldci_pkinterfazsap.vaSOCIEDAD, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CURRENCY', ldci_pkinterfazsap.vaCURRENCY, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CEBE_GENERAL', ldci_pkinterfazactas.gvacebegral, osbErrorMessage);
    ldci_pkInterfazSAP.vaCODINTINTERFAZ:=ivaiclitido;
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CONDIPAGO', ldci_pkinterfazsap.vaCODPAGO, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'NIT_TERC_SALIDA_CONS_MATER_SAP', ldci_pkinterfazsap.vaNit_Materiales, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'MATERIAIVA', ldci_pkinterfazactas.vaConIva, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'MATERIHERRA', ldci_pkinterfazactas.vaItemsMaterial, osbErrorMessage);
    ldci_pkinterfazsap.vaGRLEDGER := ldci_pkinterfazactas.fvaGetLibro(ivaiclitido);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'INDI_ACTIVO_COBRO_SUSC_MAT', vaIndActCobSus, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'INDI_IVA_SIN_COBRO_SUS_MAT', vaIndIvaSinCob, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CUENTA_IVA_MAT', vaCuentaIva, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'INDI_COSTOS_COBRO_SUSC_MAT', vaIndCosCobSus, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'IND_COSTOS_SIN_COBRO_SUS_MAT', vaIndCosSinCob, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CLASIACTIVOS', vaClasiActivos, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CTA_MATER_ACTIVOS', vaCtaMatAct, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CTA_MATER_COSTOGASTO', vaCtaMateCG, osbErrorMessage);
    ldci_pkwebservutils.proCaraServWeb('WS_INTER_CONTABLE', 'ENVIAINTERFAZMA', vaEnviaInterfazMA, osbErrorMessage);
    --
    --<<
    -- CA - 200-2529
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'LDC_NIT_IVA_RECUPERABLE', ldci_pkinterfazactas.vaNitivarecupera, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CTA_IVA_DEDUCCION_RENTA', ldci_pkinterfazactas.vaCtaIvarecupera, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'INDICA_IVA_DEDUCCION_RENTA', ldci_pkinterfazactas.vaIndicarecupera, osbErrorMessage);
    --
    -->>

    --<<
    -- Documento contable que determina el  tipo de acta(costos,activos fijos,fnb)
    -->>
    ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP := ivaiclitido;

    --<<
    -- Cantidad de registros
    -->>
    OPEN cuValidacion(ivaiclitido, inuano, inumes);
    FETCH cuValidacion INTO nuCount1;
    CLOSE cuValidacion;

    IF nuCount1 > 0 THEN

      LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,'Interfaz ya Contabilizada en este periodo '||inuano||' - '||inumes,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
      ldci_ProcesosInterfazSap.proGenMailErrorInterfaz('M',ivaiclitido,null,null,inuano,inumes,sender,nuErrMail);

    ELSE

      OPEN cuLibro (ivaiclitido);
      FETCH cuLibro INTO nuComprobante;
      CLOSE cuLibro;

      OPEN  cuFechas (inuano, inumes);
      FETCH cuFechas INTO idafecini, idafecfin;
      CLOSE cuFechas;

      OPEN cuMateriales (idafecini, idafecfin);
      FETCH cuMateriales BULK COLLECT INTO vtyInfoMate;
      CLOSE cuMateriales;

      IF (vtyInfoMate.count > 0) THEN

        --<<
        -- Obtencion del  numero de documento
        -->>
        ldci_pkInterfazSAP.nuSeqICLINUDO := ldci_pkInterfazSAP.fnuSeq_ldci_incoliqu;

        FOR i IN vtyInfoMate.First..vtyInfoMate.Last LOOP

          vaDiverge := 'N';
          vaClave := NULL;
          vaCuenta := NULL;
          vaCuentaDiverg := NULL;
          iovaitemindi := NULL;
          iovaitemincm := NULL;
          ldci_pkinterfazsap.vaCentBen := NULL;
          ldci_pkinterfazsap.vaNit := NULL;
          ldci_pkinterfazsap.vaNitAnti := NULL;
          ldci_pkinterfazsap.vaMaterialIva := NULL;
          ldci_pkinterfazsap.vaMaterialAct := NULL;
          iovactcatire := NULL;
          iovactcainre := NULL;
          iovactcaitem := NULL;
          iovacuentaiva := NULL;

          IF vtyInfoMate(i).TIPO = 'ACTIVO' THEN  --valida si es cuenta puente

             --<<
             -- Se obtiene el clasificador a partir del tipo de trabajo
             -->>
             vaClCoCodi := ldci_pkinterfazactas.fvaGetClasifi(Nvl(ldci_pkinterfazsap.fvaGetData(39,vtyInfoMate(i).dcrcinad,'|'),NULL));

             --<<
             -- Se define la cuenta de acuerdo al clasificador, si es de activos o no
             -->>
             IF (','||vaClasiActivos||',' LIKE '%,' ||vaClCoCodi|| ',%') THEN

               vaCuenta := vaCtaMatAct;

             ELSE

               vaCuenta := vaCtaMateCG;

             END IF;


             -- ldci_pkinterfazsap.vaCentBen := ldci_pkinterfazactas.gvacebegral;

             ldci_pkinterfazsap.vaMaterialAct := 'ACTIVO';

             IF  vtyInfoMate(i).estado = 3 THEN

              -->> heiberb - 04-03-2015
             --Se elimina el indicador de la cuenta 1518
             --<<
             --  iovaitemindi := vaIndActCobSus;
               iovacuentaiva := vaCuenta;

             ELSE

               -- nuRet := ldci_pkinterfazactas.fvaGetIndicadore(vtyInfoMate(i).item, vtyInfoMate(i).clasificador, iovactcatire, iovactcainre, iovactcaitem);
               --se debe poner ldci_pkinterfazactas.fvaGetIndivaTT

             -->> heiberb - 04-03-2015
             --Se elimina el indicador de la cuenta 1518
             --<<
              -- nuRet := ldci_pkinterfazactas.fvaGetIndiva(vtyInfoMate(i).item, iovaitemindi, iovacuentaiva);

               -- iovaitemindi := 'F1';
               iovacuentaiva := vaCuenta;

             END IF;



             --<<
             -- Se asigna la cuenta del clasificador cuando el indicador no tiene cuenta de IVA
             -->>
             ELSIF (vtyInfoMate(i).TIPO = 'IVA') THEN

              --ldci_pkinterfazsap.vaCentBen := ldci_pkinterfazactas.gvacebegral;
              ldci_pkinterfazsap.vaMaterialIva := 'IVA';

              --<<
              -- Edmundo E. Lara -- 31/05/2016  CA = 100-10632
              --
/*
              IF  vtyInfoMate(i).estado = 3 THEN
               --se debe poner ldci_pkinterfazactas.fvaGetIndivaTT
                  nuRet := ldci_pkinterfazactas.fvaGetIndiva(vtyInfoMate(i).item, iovaitemindi, iovacuentaiva);
               --iovaitemindi := 'T0';--dcardona se pone parametro

                  IF iovacuentaiva IS NULL THEN
                     iovacuentaiva := vtyInfoMate(i).cuenta;
                  END IF;

              ELSE


                  Dbms_Output.Put_Line('el item iva es '||vtyInfoMate(i).item);
*/
              --
              -->>
  --                nuRet := ldci_pkinterfazactas.fvaGetIndiva(vtyInfoMate(i).item, iovaitemindi, iovacuentaiva);

              --<<
              -- CA-200-2529
              -- Se valida el nit de la LDC para que solo aplique lo DEL IVA RECUPERABLE - EFIGAS
              vaClCoCodi := ldci_pkinterfazactas.fvaGetClasifi(Nvl(ldci_pkinterfazsap.fvaGetData(39,vtyInfoMate(i).dcrcinad,'|'),NULL));

              OPEN cuSistema;
              FETCH cuSistema INTO vsbnit;
              CLOSE cuSistema;

              IF vsbnit = ldci_pkinterfazactas.vaNitivarecupera THEN

                IF vaClCoCodi = vaClasiActivos THEN

                  iovaitemindi := ldci_pkinterfazactas.vaIndicarecupera;
                  iovacuentaiva := ldci_pkinterfazactas.vaCtaIvarecupera;

                ELSE

                  iovaitemindi := vaIndIvaSinCob;
                  iovacuentaiva := vaCuentaIva;

                END IF;

              ELSE -- 200-2529 GDCA

                  iovaitemindi := vaIndIvaSinCob;
                  iovacuentaiva := vaCuentaIva;

              END IF;

               -->>
         /*     END IF;*/

           ELSIF (vtyInfoMate(i).TIPO = 'COSTOS') THEN

              IF  vtyInfoMate(i).estado = 3 THEN

                iovaitemindi := vaIndCosCobSus;
                iovacuentaiva := vtyInfoMate(i).cuenta;

              ELSE

                iovaitemindi := vaIndCosSinCob;
                iovacuentaiva := vtyInfoMate(i).cuenta;

              END IF;

           END IF;

          --<<
          --obtiene la clave contable a partir de la cuenta
          -->>
          vaClave := ldci_pkInterfazSAP.fvaGetClaveConta(iovacuentaiva, vtyInfoMate(i).signos,  iovactcaicme, iovactcainiv);

          IF (vaClave = -1 OR vaClave IS NULL) THEN

             LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,'No hay cofigurada clave contable para la cuenta ['||iovacuentaiva||']',to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));

          END IF;

          vaDiverge := ldci_pkinterfazsap.fnuCtaDiver(vaClave);

          IF vaDiverge = 'S' THEN

             vaCuentaDiverg := iovacuentaiva;

          END IF;


          ldci_pkinterfazSAP.vaNit := ldci_pkinterfazsap.vaNit_Materiales;

       -- Dbms_Output.Put_Line('inserta incoliqu ');
          nuRet := ldci_pkinterfazsap.fnuLDCI_INCOLIQUMATRO(ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,
                                                            ldci_pkInterfazSAP.nuSeqICLINUDO,
                                                            sysdate,
                                                            user,
                                                            'SERVER',
                                                            sysdate,
                                                            null,
                                                            vaClave,
                                                            iovacuentaiva,--cuenta,
                                                            iovaitemincm,--null,
                                                            (vtyInfoMate(i).VALOR),
                                                            (vtyInfoMate(i).VALOR),
                                                            iovaitemindi,
                                                            NULL,
                                                            null,
                                                            null,
                                                            null,
                                                            null,
                                                            null,
                                                            iovactcatire,
                                                            iovactcainre,
                                                            null,
                                                            i,
                                                            vaCuentaDiverg,
                                                            vtyInfoMate(i).dcrcinad,
                                                            nuComprobante);

        END LOOP;

        nuRet := ldci_pkInterfazSAP.fnuINSELDCI_INCOLIQU;
        --<<
        --Genera la informacion de los documentos para SAP de la interfaz de INGRESOS
        -->>
        --<<
        --Se lanza la Exepcion
        -->>
        IF (nuRet <> 0) THEN
            RAISE ERROR;
        END IF;

        nuRet := ldci_pkInterfazSAP.fnuGeneDocuSapMat(ldci_pkInterfazSAP.nuSeqICLINUDO);

        --<<
        --Se lanza la Exepcion
        -->>
        IF (nuRet <> 0) THEN
            LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
            RAISE ERROR;
        END IF;

        nuRet := ldci_pkinterfazsap.fnuAjusteInterCont(ldci_pkInterfazSAP.nuSeqICLINUDO);

        --<<
        --Si es satifactorio todo el proceso, se realiza el envio a SAP
        -->>
        IF (vaEnviaInterfazMA = 'S') THEN
           ldci_pkintercontablemesa.proEnviaDocContable(ldci_pkInterfazSAP.nuSeqICLINUDO);
        END IF;

        -- envia correo notificando el envio de la interfaz a SAP
        ldci_ProcesosInterfazSap.proGenMailInterfaz (ldci_pkinterfazsap.nuSeqICLINUDO,ivaiclitido,sender,nuErrMail);


        nuRet := ldci_pkinterfazsap.fnuRegistraInterfazAnioMes(ldci_pkinterfazsap.nuSeqICLINUDO,inuano,inumes,'S',ivaiclitido);
        -- Validacion si se inserto historia contable
        IF (nuRet <> 0) THEN
           LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
           RAISE Error;
        END IF;

      END IF;
   END IF;

   ldci_pkInterfazSAP.vaMensError :=  '[fnuInterMaterSAPRO] - Finaliza correctamente la interfaz de materiales. ';
   LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,USER,USERENV('TERMINAL'));

   --<<
   --Inserta los datos en la tabla LDCI_INCOLIQU
   -->>
   RETURN 0;

 EXCEPTION
  when others then
       ldci_pkInterfazSAP.vaMensError :=  '[fnuInterMaterSAPRO] - No se proceso la interfaz de materiales. '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
       LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,USER,USERENV('TERMINAL'));
       ldci_ProcesosInterfazSap.proGenMailErrorInterfaz('M',ivaiclitido,null,null,inuano,inumes,sender,nuErrMail);
       return(-1);
 END fnuInterMaterSAPRO;


  FUNCTION fnuInterProviActas(inuano IN NUMBER,
                            inumes IN NUMBER)
  RETURN NUMBER IS
  /*****************************************************************************
  Propiedad intelectual Gases de Occidente .
  Function:     fnuInterProviActas
  Descripcion:  Funcion para reportar los costos provisionados reportados al sistema
                SAP.


  Parametros de Entrada:
                ivaiclitido      :tipo de documento
                inuano           :a?o
                inumes           :mes

  Parametros de Salida:
                Ninguno
  Retornos:
                0  No hubo error al ejecutar la funcion.
                -1 Hubo error al ejecutar al funcion.
  Autor:        Heiber Barco
  Fecha:        03-10-2013

  Historia de modificaciones
  Fecha Autor Modificacion
  ******************************************************************************/

     /*
     Cursor de que obtiene los registros contables
     */
  CURSOR cuMateriales IS
  SELECT dcrccons, dcrcecrc, dcrccorc, dcrccuco cuenta, dcrcsign signos, dcrcvalo valor,
         dcrcinad, dcrcfecr, dcrcclcr, dcrcusua, dcrcterm, dcrcprog, dcrcsist, clcrclco clasificador, ldci_pkinterfazsap.fvaGetData(46, DCRCINAD, '|') item,
         ldci_pkinterfazsap.fvaGetData(11, DCRCINAD, '|') NIT, cod_comprobante
  FROM ic_compgene, ic_encoreco, ic_decoreco,ic_confreco, ic_clascore,
       ic_clascont, ldci_tipointerfaz
 WHERE COGECOCO = cod_tipocomp
   AND tipointerfaz = 'LF'
   AND ECRCCOGE = cogecons
   AND ECRCCONS = dcrcecrc
   AND CORCCOCO = COGECOCO
   AND clcrcons = dcrcclcr
   AND clcrclco = clcocodi
   AND To_Char(COGEFEIN, 'YYYY') = inuano
   AND To_Char(COGEFEIN, 'MM') = inumes;



 --<<
 --Cursor que obtiene los datos de los costos a nivel de detalle de acta para
 --resolver el tema de los items agrupados en decoreco
 -->>

  -- Private type declarations


  -- Private constant declarations
    nuCantidad       NUMBER:= 0;

  -- Private variable declarations
  nuCount          NUMBER := 0;
  gnuComodin       NUMBER;
  nuRet NUMBER;
  error            EXCEPTION;  -- Manejo de errores en la inserccion de los datos contables en LDCI_INCOLIQU
  vaClave        ldci_claveconta.clavcodi%TYPE;
  iovactcaicme    LDCI_CTACADMI.ctcaicme%TYPE;
  iovactcainiv    LDCI_ITEMCONTA.itemciva%TYPE;
  iovaitemincm    LDCI_CTACADMI.ctcaicme%TYPE;
  iovaitemindi    LDCI_ITEMCONTA.itemindi%TYPE;
  iovactcatire    LDCI_INTEMINDICA.itemtire%TYPE;
  iovactcainre    LDCI_INTEMINDICA.iteminre%TYPE;
  iovactcaitem    LDCI_INTEMINDICA.itemcate%TYPE;
  iovacuentaiva   LDCI_ITEMCONTA.itemciva%TYPE;
  sbFechaGen DATE;
  vaCuenta ldci_cuentacontable.cuctcodi%TYPE;
  vaCuentaDiverg ldci_cuentacontable.cuctcodi%TYPE;
  nuAnoAnt        NUMBER(4) := 0;
  nuMesAnt        NUMBER(2) := 0;
  ivaiclitido VARCHAR2(2) := 'LF';
  TYPE tyInfoMate IS TABLE OF cuMateriales%ROWTYPE INDEX BY BINARY_INTEGER;
    vtyInfoMate tyInfoMate;

 BEGIN

     --<<
    -- Parametros de intrefaz
    --<<
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'GRLEDGER', ldci_pkinterfazsap.vaGRLEDGER, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'SOCIEDAD', ldci_pkinterfazsap.vaSOCIEDAD, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CURRENCY', ldci_pkinterfazsap.vaCURRENCY, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CEBE_GENERAL', ldci_pkinterfazactas.gvacebegral, osbErrorMessage);
    ldci_pkInterfazSAP.vaCODINTINTERFAZ:=ivaiclitido;
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CONDIPAGO', ldci_pkinterfazsap.vaCODPAGO, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'VALIDAENVIA', ldci_pkinterfazactas.EnviaProv, osbErrorMessage);

    --<<
    -- Documento contable que determina el  tipo de acta(costos,activos fijos,fnb)
    -->>
    ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP := ivaiclitido;
    ldci_pkinterfazsap.nuanoprovi := inuano;
    ldci_pkinterfazsap.numesprovi := inumes;

    IF ldci_pkinterfazsap.numesprovi = 1 THEN
    nuMesAnt := 12;
    nuAnoAnt := ldci_pkinterfazsap.nuanoprovi - 1;
    ELSE
    nuAnoAnt := ldci_pkinterfazsap.nuanoprovi;
    nuMesAnt := ldci_pkinterfazsap.numesprovi - 1;
    Dbms_Output.Put_Line('mes anterior '||nuMesAnt);
    Dbms_Output.Put_Line('a?o anterior '||nuAnoAnt);
    END IF;
    --<<
    -- Borra los datos en memmoria
    -->>


    --<<
    -- Cantidad de registros
    -->>



    --DBMS_OUTPUT.PUT_LINE('Identificador InterfazCostos: '||ldci_pkInterfazSAP.nuSeqICLINUDO);


        OPEN cuMateriales;
        FETCH cuMateriales BULK COLLECT INTO vtyInfoMate;
        CLOSE cuMateriales;




      IF (vtyInfoMate.count > 0) THEN

       --<<
       --Obtencion del  numero de documento
       -->>
       ldci_pkInterfazSAP.nuSeqICLINUDO := ldci_pkInterfazSAP.fnuSeq_ldci_incoliqu;

       --<<
       --se limpia la tabla para el periodo a contabilizar.
       -->>
     DELETE
       FROM ldci_detaprovcosto
      WHERE ano = inuano
        AND mes = inumes;



          FOR i IN vtyInfoMate.First..vtyInfoMate.Last LOOP
          vaDiverge := 'N';
          vaClave := NULL;
          vaCuenta := NULL;
          vaCuentaDiverg := NULL;
          iovaitemindi := NULL;
          iovaitemincm := NULL;
          ldci_pkinterfazsap.vaCentBen := NULL;
          ldci_pkinterfazsap.vaNit := NULL;
          ldci_pkinterfazsap.vaNitAnti := NULL;
          iovactcatire := NULL;
          iovactcainre := NULL;
          iovactcaitem := NULL;
          iovacuentaiva := NULL;
        --  Dbms_Output.Put_Line('la cuenta es '||vtyInfoActas(i).cuenta);
         -- Dbms_Output.Put_Line('Valor parametro '||ldci_pkinterfazsap.vaCuentaParticu);




            --  ldci_pkinterfazsap.vaCentBen := ldci_pkinterfazactas.gvacebegral;
              --<<
              --obtiene la clave contable a partir de la cuenta
              -->>
              vaClave := ldci_pkInterfazSAP.fvaGetClaveConta(vtyInfoMate(i).cuenta, vtyInfoMate(i).signos,  iovactcaicme, iovactcainiv);
              nuRet := ldci_pkinterfazactas.fvaGetIndicadore(vtyInfoMate(i).item, vtyInfoMate(i).clasificador, iovactcatire, iovactcainre, iovactcaitem);

              IF vtyInfoMate(i).cuenta LIKE '279090%%%%' THEN
          iovactcatire := NULL;
          iovactcainre := NULL;
          iovactcaitem := NULL;
          iovacuentaiva := NULL;

              END IF;




              vaDiverge := ldci_pkinterfazsap.fnuCtaDiver(vaClave);




              IF vaDiverge = 'S' THEN

              vaCuentaDiverg := vtyInfoMate(i).cuenta;

              END IF;


            ldci_pkinterfazSAP.vaNit := vtyInfoMate(i).nit;


            nuRet := ldci_pkinterfazsap.fnuLDCI_INCOLIQUACTA(ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,
                                                  ldci_pkInterfazSAP.nuSeqICLINUDO,
                                                  sysdate,
                                                  user,
                                                  'SERVER',
                                                  sysdate,
                                                  null,
                                                  vaClave,
                                                  vtyInfoMate(i).cuenta,--cuenta,
                                                  iovaitemincm,--null,
                                                  trunc(vtyInfoMate(i).VALOR),
                                                  trunc(vtyInfoMate(i).VALOR),
                                                  iovaitemindi,
                                                  NULL,
                                                  null,
                                                  null,
                                                  null,
                                                  null,
                                                  null,
                                                  iovactcatire,
                                                  iovactcainre,
                                                  null,
                                                  i,
                                                  vaCuentaDiverg,
                                                  vtyInfoMate(i).dcrcinad,
                                                  vtyInfoMate(i).cod_comprobante);

            END LOOP;

            nuRet := ldci_pkInterfazSAP.fnuINSELDCI_INCOLIQU;
            --<<
            --Genera la informacion de los documentos para SAP de la interfaz de INGRESOS
            -->>
            --<<
          --Se lanza la Exepcion
          -->>
          IF (nuRet <> 0) THEN
              RAISE ERROR;
          END IF;

            nuRet := ldci_pkInterfazSAP.fnuGeneDocuSapProv(ldci_pkInterfazSAP.nuSeqICLINUDO);

            --<<
          --Se lanza la Exepcion
          -->>
          IF (nuRet <> 0) THEN
              LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
              RAISE ERROR;
          END IF;

         -- nuRet :=ldci_pkinterfazactas.fnuInteRevProviActas(nuAnoAnt, nuMesAnt);
          IF (nuRet <> 0) THEN
              LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
              RAISE ERROR;
          END IF;

        --<<
        --Si es satifactorio todo el proceso, se realiza el envio a SAP
        -->>
         ldci_pkintercontablemesa.proEnviaDocContable(ldci_pkInterfazSAP.nuSeqICLINUDO);

--         nuRet := ldci_pkinterfazsap.fnuRegistraInterfaz(inucodacta     => inuactanume,
--                                              inucodocont   => ldci_pkInterfazSAP.nuSeqICLINUDO,
--                                              ivatipdocont   => ldci_pkInterfazSAP.vaCODINTINTERFAZ,
--                                              ivausuario      => USER,
--                                              idtfechcontabil => SYSDATE
--                                             );
   -- Validacion si se inserto historia contable
   IF (nuRet <> 0) THEN
       LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
       RAISE Error;
   END IF;

      END IF;

   IF ldci_pkinterfazactas.EnviaProv = 'S' THEN
   --<<
   --valido que se envie la reversion
   -->>

     nuRet :=ldci_pkinterfazactas.fnuInteRevProviActas(nuAnoAnt, nuMesAnt);

   END IF;
          IF (nuRet <> 0) THEN
              LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
              RAISE ERROR;
          END IF;
     --<<
     --Inserta los datos en la tabla LDCI_INCOLIQU
     -->>
    return 0;
   exception
  when others then
       ldci_pkInterfazSAP.vaMensError :=  '[fnuInterProviActas] - No se proceso la interfaz de provision. '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
       LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,USER,USERENV('TERMINAL'));
       return(-1);
 END fnuInterProviActas;

 FUNCTION fnuInteRevProviActas(inuano IN NUMBER,
                            inumes IN NUMBER)
  RETURN NUMBER IS
  /*****************************************************************************
  Propiedad intelectual Gases de Occidente .
  Function:     fnuInteRevProviActas
  Descripcion:  Funcion para reportar los costos provisionados reportados al sistema
                SAP.


  Parametros de Entrada:
                ivaiclitido      :tipo de documento
                inuano           :a?o
                inumes           :mes

  Parametros de Salida:
                Ninguno
  Retornos:
                0  No hubo error al ejecutar la funcion.
                -1 Hubo error al ejecutar al funcion.
  Autor:        Heiber Barco
  Fecha:        03-10-2013

  Historia de modificaciones
  Fecha Autor Modificacion
  ******************************************************************************/

     /*
     Cursor de que obtiene los registros contables
     */
  CURSOR cuRevDeta IS
  SELECT *
  FROM ldci_detaprovcosto
 WHERE ano = inuano
   AND mes = inumes;




 --<<
 --Cursor que obtiene los datos de los costos a nivel de detalle de acta para
 --resolver el tema de los items agrupados en decoreco
 -->>

  -- Private type declarations


  -- Private constant declarations
    nuCantidad       NUMBER:= 0;
    nuIndEnca   number := 0;
    nuRet       number := 0;
    ivaiclitido VARCHAR2(2) := NULL;
    iclinudo    NUMBER := 0;
    nuIdentificador number := 0;
  -- Private variable declarations

  TYPE tyInfoDeta IS TABLE OF cuRevDeta%ROWTYPE INDEX BY BINARY_INTEGER;
    vtyInfoDeta tyInfoDeta;

 BEGIN
    --<<
    -- Parametros de intrefaz
    --<<
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'GRLEDGER', ldci_pkinterfazsap.vaGRLEDGER, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'SOCIEDAD', ldci_pkinterfazsap.vaSOCIEDAD, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CURRENCY', ldci_pkinterfazsap.vaCURRENCY, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CEBE_GENERAL', ldci_pkinterfazactas.gvacebegral, osbErrorMessage);
    LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_COSTOS', 'CONDIPAGO', ldci_pkinterfazsap.vaCODPAGO, osbErrorMessage);

    ivaiclitido := 'LF';


        OPEN cuRevDeta;
        FETCH cuRevDeta BULK COLLECT INTO vtyInfoDeta;
        CLOSE cuRevDeta;




      IF (vtyInfoDeta.count > 0) THEN
       --<<
       --Obtencion del  numero de documento
       -->>
       ldci_pkInterfazSAP.nuSeqICLINUDO := ldci_pkInterfazSAP.fnuSeq_ldci_incoliqu;
       iclinudo := ldci_pkInterfazSAP.nuSeqICLINUDO;
       nuIdentificador := seq_ldci_encaintesap.nextval;
       nuIndEnca := nuIndEnca + 1;
        nuRet := ldci_pkInterfazSAP.fnuGeneLDCI_ENCAINTESAP(iclinudo,
                                        nuIndEnca,
                                        null,
                                        null,
                                        TO_CHAR(SYSDATE, 'DDMMYYYY'),
                                        TO_CHAR(SYSDATE, 'DDMMYYYY'),
                                        ldci_pkInterfazSAP.vaGRLEDGER,
                                        iclinudo,
                                        'REV-PROVISION',
                                        ldci_pkInterfazSAP.vaCODINTINTERFAZ,
                                        ldci_pkInterfazSAP.vaSOCIEDAD,
                                        ldci_pkInterfazSAP.vaCURRENCY,
                                        nuIdentificador);
          if (nuRet <> 0) then
            raise Error;
        end if;

     END IF;

          FOR i IN vtyInfoDeta.First..vtyInfoDeta.Last LOOP



            nuRet := ldci_pkInterfazSAP.fnuLDCI_DETAINTESAP(iclinudo,
                                                    nuIndEnca,
                                                    vtyInfoDeta(i).CLAVCONT,
                                                    vtyInfoDeta(i).CLASECTA,
                                                    vtyInfoDeta(i).INDICCME,
                                                    vtyInfoDeta(i).IMPOMTRX,
                                                    vtyInfoDeta(i).IMPOMSOC,
                                                    vtyInfoDeta(i).INDICIVA,
                                                    vtyInfoDeta(i).CONDPAGO,
                                                    TO_CHAR(SYSDATE, 'DDMMYYYY'),
                                                    vtyInfoDeta(i).REFFACTR,
                                                    vtyInfoDeta(i).BASEIMPT,
                                                    vtyInfoDeta(i).CENTROCO,
                                                    vtyInfoDeta(i).ORDENINT,
                                                    vtyInfoDeta(i).CANTIDAD,
                                                    vtyInfoDeta(i).ASIGNACN,
                                                    'INTERFAZ-'||iclinudo,
                                                    vtyInfoDeta(i).CENTROBE,
                                                    vtyInfoDeta(i).SEGMENTO,
                                                    vtyInfoDeta(i).OBJCOSTO,
                                                    vtyInfoDeta(i).CLAVREF1,
                                                    vtyInfoDeta(i).CLAVREF2,
                                                    vtyInfoDeta(i).CLAVREF3,
                                                    vtyInfoDeta(i).SOCIEDGL,
                                                    vtyInfoDeta(i).MATERIAL,
                                                    vtyInfoDeta(i).TIPORETC,
                                                    vtyInfoDeta(i).INDRETEC,
                                                    vtyInfoDeta(i).BASERETC,
                                                    vtyInfoDeta(i).FECHVALOR,
                                                    vtyInfoDeta(i).CTADIV,
                                                    vtyInfoDeta(i).COD_CENTROBENEF,
                                                    -1,
                                                    nuIdentificador);

          --<<
          --Se lanza la Exepcion
          -->>

          IF (nuRet <> 0) THEN

              RAISE ERROR;
          END IF;

     END LOOP;

   nuRet := ldci_pkInterfazSAP.fnuINSEINTESAP;
    IF (nuRet <> 0) THEN
       RAISE ERROR;
    END IF;

   -- Validacion si se inserto historia contable
   IF (nuRet <> 0) THEN
       LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkInterfazSAP.nuSeqICLINUDO,USER,USERENV('TERMINAL'));
       RAISE Error;
   END IF;

    ldci_pkintercontablemesa.proEnviaDocContable(ldci_pkInterfazSAP.nuSeqICLINUDO);
     --<<
     --Inserta los datos en la tabla LDCI_INCOLIQU
     -->>
     return 0;
   exception
  when others then
       ldci_pkInterfazSAP.vaMensError :=  '[fnuInteRevProviActas] - No se proceso la reversion de provision. '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
       LDCI_pkTrazaInterfaces.pRegiMensaje(ivaiclitido,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,USER,USERENV('TERMINAL'));
       return(-1);
 END fnuInteRevProviActas;


   PROCEDURE validaLDCINTACTAS
   IS
    /*******************************************************************************
     Propiedad intelectual de Gases de Occidenes.

     Nombre         :  validaLDCINTACTAS
     Descripcion    :  Forma para validar generacion Interfaz Contable
     Autor          :  Heiber Barco
     Fecha          :  29 Noviembre de 2013
     Parametros         Descripcion
     ============    ===================


     Historia de Modificaciones
     Fecha             Autor                 Modificacion
     =========       =========          ====================
   /*******************************************************************************/
      cnunull_attribute   CONSTANT NUMBER                             := 2126;
      nuerror                      NUMBER;
      sbpefafimo                   ge_boinstancecontrol.stysbvalue;
      sbpefaffmo                   ge_boinstancecontrol.stysbvalue;
      sbTipoInterfaz               ge_boinstancecontrol.stysbvalue;
      nuNumActa                    ge_boinstancecontrol.stysbvalue;
      nuidprogproc                 open.ge_process_schedule.process_schedule_id%TYPE;
      sbparametros                 open.ge_process_schedule.parameters_%TYPE;
      sbcadconexion                VARCHAR2 (2000);
      sbusuario                    VARCHAR2 (2000);
      sbpass                       VARCHAR2 (2000);
      sbinstancia                  VARCHAR2 (2000);
      sbcadconexencr               VARCHAR2 (2000);
      csbllave            CONSTANT VARCHAR2 (20)          := '10101000101011';
      dtfechaini                   DATE;
      dtfechafin                   DATE;
      nucantidad                   NUMBER;
      nucantidadceor               NUMBER;
      nuActa                       ldci_actacont.idacta%TYPE;


    --<< CA-591
    --
    Cursor CuActa(nuacta ge_acta.id_acta%type) is
      select a.id_tipo_acta from open.ge_acta a
       where a.id_acta = nuacta;
       
    tipoacta           ge_acta.id_tipo_acta%type;
    actacomi           ge_acta.id_tipo_acta%type := 2; -- Actas por facturar
    vscontab           varchar2(1);
    osbErrorMessage    VARCHAR2(2000);
    -->>


   BEGIN
   null;
   
      --<< CA-591
      LDCI_PKWEBSERVUTILS.proCaraServWeb('WS_INTER_CONTABLE', 'PERMITE_CONTABILIZAR_LB', vscontab, osbErrorMessage);
      -->>
      
      
      --<<VAlida los parametros del reporte que no esten en Nullo-->>
      IF (cnunull_attribute IS NULL)
      THEN
         nuerror := 1;
      END IF;

      --<<Se realiza la asignacion de los valores de los campos a las variables definidas>>--
      sbpefafimo :=
                ge_boinstancecontrol.fsbgetfieldvalue ('LDCI_PROCMONI', 'PRMOFEIN');

      sbpefaffmo :=
                ge_boinstancecontrol.fsbgetfieldvalue ('LDCI_PROCMONI', 'PRMOFEFI');
      sbTipoInterfaz :=
                ge_boinstancecontrol.fsbgetfieldvalue  ('LDCI_ACTACONT', 'TIPDOCONT');
      nuActa :=
                ge_boinstancecontrol.fsbgetfieldvalue  ('LDCI_ACTACONT', 'IDACTA');

     --<<VAlida los parametros del reporte que no esten en Nullo-->>
      IF (sbTipoInterfaz IS NULL)
      THEN
         ERRORS.seterror (cnunull_attribute, 'Debe Indicar Tipo Interfaz ');
         RAISE ex.controlled_error;
      END IF;

      --<<VAlida los parametros del reporte que no esten en Nullo-->>
      IF (sbpefafimo IS NULL)
      THEN
         ERRORS.seterror (cnunull_attribute, 'Fecha Inicial Movimientos');
         RAISE ex.controlled_error;
      END IF;

      IF (sbpefaffmo IS NULL)
      THEN
         ERRORS.seterror (cnunull_attribute, 'Fecha Final Movimientos');
         RAISE ex.controlled_error;
      END IF;

      dtfechaini := TRUNC (TO_DATE (sbpefafimo, ut_date.fsbdate_format));
      dtfechafin :=
           TRUNC (TO_DATE (sbpefaffmo, ut_date.fsbdate_format))
         + (1 - (1 / 24 / 60 / 60));

      --<<Se realiza validacion de Fecha Inicial y Fecha Final>>--
      IF (dtfechafin < dtfechaini)
      THEN
         gi_boerrors.seterrorcodeargument
                   (2741,
                    'La fecha Final no puede ser inferior a la fecha Inicial'
                   );
         RAISE ex.controlled_error;
      END IF;
      
      --<< CA-591
      open cuacta(nuActa);
      fetch cuacta into tipoacta;
      close cuacta;
      
      If tipoacta = actacomi AND vscontab = 'N' then      
         ERRORS.seterror (2741, 'Las Actas de Comision no se permiten Contabilizar por esta forma');
         RAISE ex.controlled_error;
      End IF;
      -->>
            
      -- Obtiene la programacion en memoria
      nuidprogproc := ge_boschedule.fnugetscheduleinmemory;
      -- se obtiene parametros
      sbparametros := dage_process_schedule.fsbgetparameters_ (nuidprogproc);
      ge_bodatabaseconnection.getconnectionstring (sbusuario,
                                                   sbpass,
                                                   sbinstancia
                                                  );
/*      sbusuario := 'PEFADESC=' || sbusuario;
      pkcontrolconexion.encripta (sbpass, sbcadconexencr, csbllave, 0);
      sbpass := 'SUSCMAIL=' || sbcadconexencr;
      sbinstancia := 'SUSCDECO=' || sbinstancia;
      sbparametros :=
         sbparametros || sbusuario || '|' || sbpass || '|' || sbinstancia
         || '|';
      dage_process_schedule.updparameters_ (nuidprogproc, sbparametros);
      COMMIT;
      ut_trace.TRACE ('FIN CEO_FWInterfazSCE.ValidarCP_INTSCE', 3);
  */
   END validaLDCINTACTAS;

   PROCEDURE validaLDCIENVINT
   IS
    /*******************************************************************************
     Propiedad intelectual de Gases de Occidenes.

     Nombre         :  validaLDCIENVINT
     Descripcion    :  Forma para validar documento contable
     Autor          :  Heiber Barco
     Fecha          :  29 Noviembre de 2013
     Parametros         Descripcion
     ============    ===================


     Historia de Modificaciones
     Fecha             Autor                 Modificacion
     =========       =========          ====================
   /*******************************************************************************/
      cnunull_attribute   CONSTANT NUMBER                             := 2126;
      nuerror                      NUMBER;
      sbpefafimo                   ge_boinstancecontrol.stysbvalue;
      sbpefaffmo                   ge_boinstancecontrol.stysbvalue;
      sbTipoInterfaz               ge_boinstancecontrol.stysbvalue;
      nuNumActa                    ge_boinstancecontrol.stysbvalue;
      nuIclinudo                   ge_boinstancecontrol.stysbvalue;
      nuidprogproc                 open.ge_process_schedule.process_schedule_id%TYPE;
      sbparametros                 open.ge_process_schedule.parameters_%TYPE;
      sbcadconexion                VARCHAR2 (2000);
      sbusuario                    VARCHAR2 (2000);
      sbpass                       VARCHAR2 (2000);
      sbinstancia                  VARCHAR2 (2000);
      sbcadconexencr               VARCHAR2 (2000);
      csbllave            CONSTANT VARCHAR2 (20)          := '10101000101011';
      dtfechaini                   DATE;
      dtfechafin                   DATE;
      nucantidadceor               NUMBER;
      nuCantidad                   NUMBER := 0;

   CURSOR cuExiste(inuInterfaz ldci_actacont.codocont%TYPE) IS
    SELECT Count(*) FROM (
     SELECT ldcodinterf
       FROM Ldci_registrainterfaz
      WHERE ldcodinterf = inuInterfaz
        AND ldflagcontabi = 'N'
      UNION
      SELECT codocont
       FROM ldci_actacont
      WHERE codocont = inuInterfaz
        AND actcontabiliza = 'N');

   BEGIN
   null;
      --<<VAlida los parametros del reporte que no esten en Nullo-->>
      IF (cnunull_attribute IS NULL)
      THEN
         nuerror := 1;
      END IF;

      --<<Se realiza la asignacion de los valores de los campos a las variables definidas>>--

      nuIclinudo :=
                ge_boinstancecontrol.fsbgetfieldvalue  ('LDCI_ACTACONT', 'CODOCONT');

     --<<VAlida los parametros del reporte que no esten en Nullo-->>
      IF (nuIclinudo IS NULL)
      THEN
         ERRORS.seterror (cnunull_attribute, 'Debe Indicar Codigo Interfaz ');
         RAISE ex.controlled_error;
      END IF;

      OPEN cuExiste(nuIclinudo);
      FETCH cuExiste INTO nuCantidad;
      CLOSE cuExiste;

      IF nuCantidad = 0 THEN
      ERRORS.seterror (cnunull_attribute, 'Documento no Existe o ya se encuentra Contabilizado ');
         RAISE ex.controlled_error;
      END IF;

            -- Obtiene la programacion en memoria
      nuidprogproc := ge_boschedule.fnugetscheduleinmemory;
      -- se obtiene parametros
      sbparametros := dage_process_schedule.fsbgetparameters_ (nuidprogproc);
      ge_bodatabaseconnection.getconnectionstring (sbusuario,
                                                   sbpass,
                                                   sbinstancia
                                                  );
/*      sbusuario := 'PEFADESC=' || sbusuario;
      pkcontrolconexion.encripta (sbpass, sbcadconexencr, csbllave, 0);
      sbpass := 'SUSCMAIL=' || sbcadconexencr;
      sbinstancia := 'SUSCDECO=' || sbinstancia;
      sbparametros :=
         sbparametros || sbusuario || '|' || sbpass || '|' || sbinstancia
         || '|';
      dage_process_schedule.updparameters_ (nuidprogproc, sbparametros);
      COMMIT;
      ut_trace.TRACE ('FIN CEO_FWInterfazSCE.ValidarCP_INTSCE', 3);
  */
   END validaLDCIENVINT;

   PROCEDURE validaLDCIGINTMES
   IS
      cnunull_attribute   CONSTANT NUMBER                             := 2126;
      nuerror                      NUMBER;
      nuAnio                   ge_boinstancecontrol.stysbvalue;
      nuMes                   ge_boinstancecontrol.stysbvalue;
      sbTipoInterfaz               ge_boinstancecontrol.stysbvalue;
      nuNumActa                    ge_boinstancecontrol.stysbvalue;
      nuidprogproc                 open.ge_process_schedule.process_schedule_id%TYPE;
      sbparametros                 open.ge_process_schedule.parameters_%TYPE;
      sbcadconexion                VARCHAR2 (2000);
      sbusuario                    VARCHAR2 (2000);
      sbpass                       VARCHAR2 (2000);
      sbinstancia                  VARCHAR2 (2000);
      sbcadconexencr               VARCHAR2 (2000);
      csbllave            CONSTANT VARCHAR2 (20)          := '10101000101011';
      dtfechaini                   DATE;
      dtfechafin                   DATE;
      nucantidad                   NUMBER;
      nucantidadceor               NUMBER;

   BEGIN
   null;
      --<<VAlida los parametros del reporte que no esten en Nullo-->>
      IF (cnunull_attribute IS NULL)
      THEN
         nuerror := 1;
      END IF;

      --<<Se realiza la asignacion de los valores de los campos a las variables definidas>>--
      nuAnio :=
                ge_boinstancecontrol.fsbgetfieldvalue ('LDC_CIERCOME', 'CICOANO');

      nuMes :=
                ge_boinstancecontrol.fsbgetfieldvalue ('LDC_CIERCOME', 'CICOMES');

      --<<VAlida los parametros del reporte que no esten en Nullo-->>
      IF (nuAnio IS NULL)
      THEN
         ERRORS.seterror (cnunull_attribute, 'A?o');
         RAISE ex.controlled_error;
      END IF;

      IF (nuMes IS NULL)
      THEN
         ERRORS.seterror (cnunull_attribute, 'Mes');
         RAISE ex.controlled_error;
      END IF;

      IF (nuAnio < 1999)
      THEN
         gi_boerrors.seterrorcodeargument
                   (2741,
                    'El A?o es invalido'
                   );
         RAISE ex.controlled_error;
      END IF;

      IF (nuMes < 1 or nuMes>12)
      THEN
         gi_boerrors.seterrorcodeargument
                   (2741,
                    'El Mes es invalido'
                   );
         RAISE ex.controlled_error;
      END IF;

      -- Obtiene la programacion en memoria
      nuidprogproc := ge_boschedule.fnugetscheduleinmemory;
      -- se obtiene parametros
      sbparametros := dage_process_schedule.fsbgetparameters_ (nuidprogproc);
      ge_bodatabaseconnection.getconnectionstring (sbusuario,
                                                   sbpass,
                                                   sbinstancia
                                                  );
/*      sbusuario := 'PEFADESC=' || sbusuario;
      pkcontrolconexion.encripta (sbpass, sbcadconexencr, csbllave, 0);
      sbpass := 'SUSCMAIL=' || sbcadconexencr;
      sbinstancia := 'SUSCDECO=' || sbinstancia;
      sbparametros :=
         sbparametros || sbusuario || '|' || sbpass || '|' || sbinstancia
         || '|';
      dage_process_schedule.updparameters_ (nuidprogproc, sbparametros);
      COMMIT;
      ut_trace.TRACE ('FIN CEO_FWInterfazSCE.ValidarCP_INTSCE', 3);
  */
   END validaLDCIGINTMES;
  FUNCTION fvaGetClaveConta (nucuctcodi   in LDCI_CUENTACONTABLE.cuctcodi%TYPE,
                             vaSigno      IN IC_DECORECO.dcrcsign%TYPE)
  return VARCHAR
  is
  /************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION   : fvaGetClaveConta
     AUTOR     : Heiber Barco
     FECHA     : 02-08-2013
     DESCRIPCION  : Tiquete:
                    funcion que se encarga de obtener la clave apartir de la cuenta

    Parametros de Entrada

    Parametros de Salida

    Historia de Modificaciones
    Autor    Fecha       Descripcion
  ************************************************************************/
  CURSOR cuGetClave IS
    SELECT *
      FROM LDCI_CTACADMI
      WHERE ctcacodi = nucuctcodi;


   ovaClave LDCI_CTACADMI.ctcaclcr%TYPE;

   rgcuGetClave cuGetClave%ROWTYPE;

  begin

  OPEN cuGetClave;
  FETCH cuGetClave INTO rgcuGetClave;
  CLOSE cuGetClave;

     IF vaSigno = 'C' THEN

     ovaClave := rgcuGetClave.CTCACLCR;

     ELSIF vaSigno = 'D' THEN

     ovaClave := rgcuGetClave.CTCACLDB;


     END IF;

     RETURN ovaClave;
  exception
  when others then
       ldci_pkInterfazSAP.vaMensError :=  '[fvaGetClaveConta] - No se pudo obtener la clave. '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
       return('-1');
  end fvaGetClaveConta;

 FUNCTION fnuGetIva (inutipotrab IN NUMBER,
                     inuorden IN NUMBER,
                     inucontratista IN NUMBER,
                     inuacta IN NUMBER,
                     inuitem IN NUMBER)
    /***************************************************************************
    Fecha   Modificacion
    28/12/2016  cramirez    CA 200-1012
    Se Parametriza el IVA para que pueda ser cambiado cada que se necesite

    ***************************************************************************/
return NUMBER
  is


 onuAdmin NUMBER;
 onuImpre NUMBER;
 onuUtili NUMBER;
 onuOrderCost NUMBER;
 nuPorRete NUMBER;
 vaRes VARCHAR2(2000);
 vaRegimen VARCHAR2(1);
 vaContrato VARCHAR2(15);
 nuvalorUtil NUMBER;
 nuValor NUMBER;
 nuOrden NUMBER;
 nuTipotrab NUMBER;
 nuBancocodi banco.banccodi%type;

 CURSOR cucontratista IS
 SELECT COMMON_REG FROM ge_contratista WHERE id_contratista = inucontratista;

 CURSOR cuContrato IS
   SELECT To_Char(id_contrato)
     FROM ge_acta
    WHERE id_acta = inuacta;

    cursor cucontratistabanco(nucontrato ge_contrato.id_contrato%type) is
      SELECT banccodi
        from banco, ge_contrato
       where banco.banccont = ge_contrato.id_contratista
         and ge_contrato.id_contrato = nuContrato;

BEGIN

OPEN cucontratista;
FETCH cucontratista INTO vaRegimen;
CLOSE cucontratista;

OPEN cuContrato;
FETCH cuContrato INTO vaContrato;
CLOSE cuContrato;



  -- DBMS_OUTPUT.DISABLE;

  --obtiene el costo de la orden
  --procostoorden(vaContrato,inuorden,onuOrderCost);
  procostoorden(vaContrato,inuorden,inuitem, onuOrderCost);
    --Dbms_Output.Put_Line('el valor costo es '||onuOrderCost);
  --obtengo el AIU de la orden
  ldc_getaiubyorder(inuorden,onuAdmin,onuImpre,onuUtili);
  --Dbms_Output.Put_Line('el valor util es  '||onuUtili);
  --valido el regimen
  IF vaRegimen = 'Y' THEN

  --obtengo el porcentaje de retencioon
  nuPorRete := LDC_ACTA.FNUVALIDARETENT(inutipotrab, 'RI');
   Dbms_Output.Put_Line('el porc rete es '||nuPorRete);

    --valido el porcentaje mayor a 0
      IF nuPorRete > 0 THEN

      --identifico tipo de item
      vaRes := LDC_ACTA.FsbTipoItem(inutipotrab, nuPorRete,'RI');
        Dbms_Output.Put_Line('el tipo item  es '||vaRes);

      --valido si es obra civil
         IF vaRes = 'O' THEN


         nuvalorUtil := onuOrderCost * (onuUtili/100);
         nuvalorUtil := nuvalorUtil/(((onuAdmin + onuUtili)/100) + 1);
         Dbms_Output.Put_Line('el valor para OC es '||nuvalorUtil);

         ELSE

         nuvalorUtil := onuOrderCost;
         Dbms_Output.Put_Line('el valor para SERV es '||nuvalorUtil);

         END IF;

      nuValor := (nuvalorUtil * nuIVA / 100);
      Dbms_Output.Put_Line('el valor sin IVA es '||nuvalorUtil);
      Dbms_Output.Put_Line('el valor total es '||nuValor);
      END IF;

  END IF;

  RETURN (nuValor);

exception
  when others then
       ldci_pkInterfazSAP.vaMensError :=  '[fnuGetIva] - No se pudo obtener el IVA '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
       LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,USER,USERENV('TERMINAL'));
       return(-1);
  end fnuGetIva;

   PROCEDURE VALIDALDCIREPL
   IS
    /*******************************************************************************
     Propiedad intelectual de Gases de Occidenes.

     Nombre         :  VALIDALDCIREPL
     Descripcion    :  Forma para validar replica de cecos
     Autor          :  Heiber Barco
     Fecha          :  29 Noviembre de 2013
     Parametros         Descripcion
     ============    ===================


     Historia de Modificaciones
     Fecha             Autor                 Modificacion
     =========       =========          ====================
   /*******************************************************************************/
      cnunull_attribute   CONSTANT NUMBER                             := 2126;
      nuerror                      NUMBER;
      nudepto                   ge_boinstancecontrol.stysbvalue;
      nulocal                   ge_boinstancecontrol.stysbvalue;
      nutipotr               ge_boinstancecontrol.stysbvalue;
      nuitem                    ge_boinstancecontrol.stysbvalue;
      nuidprogproc                 open.ge_process_schedule.process_schedule_id%TYPE;
      sbparametros                 open.ge_process_schedule.parameters_%TYPE;
      sbcadconexion                VARCHAR2 (2000);
      sbusuario                    VARCHAR2 (2000);
      sbpass                       VARCHAR2 (2000);
      sbinstancia                  VARCHAR2 (2000);
      sbcadconexencr               VARCHAR2 (2000);
      csbllave            CONSTANT VARCHAR2 (20)          := '10101000101011';
      dtfechaini                   DATE;
      dtfechafin                   DATE;
      nucantidad                   NUMBER;
      nucantidadceor               NUMBER;
      nuActa                       ldci_actacont.idacta%TYPE;

   BEGIN
   null;
      --<<VAlida los parametros del reporte que no esten en Nullo-->>
      IF (cnunull_attribute IS NULL)
      THEN
         nuerror := 1;
      END IF;

      --<<Se realiza la asignacion de los valores de los campos a las variables definidas>>--
      nudepto :=
                ge_boinstancecontrol.fsbgetfieldvalue ('LDCI_CENCOUBGTRA', 'CCBGDPTO');

      nulocal :=
                ge_boinstancecontrol.fsbgetfieldvalue ('LDCI_CENCOUBGTRA', 'CCBGLOCA');
      nutipotr :=
                ge_boinstancecontrol.fsbgetfieldvalue  ('LDCI_CENCOUBGTRA', 'CCBGTITR');
      nuitem :=
                ge_boinstancecontrol.fsbgetfieldvalue  ('LDCI_CENCOUBGTRA', 'CCBGITEM');

     --<<VAlida los parametros del reporte que no esten en Nullo-->>
      IF (nudepto IS NULL)
      THEN
         ERRORS.seterror (cnunull_attribute, 'Debe Indicar Departamento ');
         RAISE ex.controlled_error;
      END IF;

      --<<VAlida los parametros del reporte que no esten en Nullo-->>
      IF (nulocal IS NULL)
      THEN
         ERRORS.seterror (cnunull_attribute, 'Debe Indicar Localidad');
         RAISE ex.controlled_error;
      END IF;

      IF (nutipotr IS NULL)
      THEN
         ERRORS.seterror (cnunull_attribute, 'Debe Indicar Tipo Trabajo');
         RAISE ex.controlled_error;
      END IF;

      IF (nuitem IS NULL)
      THEN
         ERRORS.seterror (cnunull_attribute, 'Debe Indicar Item');
         RAISE ex.controlled_error;
      END IF;

      -- Obtiene la programacion en memoria
      nuidprogproc := ge_boschedule.fnugetscheduleinmemory;
      -- se obtiene parametros
      sbparametros := dage_process_schedule.fsbgetparameters_ (nuidprogproc);
      ge_bodatabaseconnection.getconnectionstring (sbusuario,
                                                   sbpass,
                                                   sbinstancia
                                                  );
/*      sbusuario := 'PEFADESC=' || sbusuario;
      pkcontrolconexion.encripta (sbpass, sbcadconexencr, csbllave, 0);
      sbpass := 'SUSCMAIL=' || sbcadconexencr;
      sbinstancia := 'SUSCDECO=' || sbinstancia;
      sbparametros :=
         sbparametros || sbusuario || '|' || sbpass || '|' || sbinstancia
         || '|';
      dage_process_schedule.updparameters_ (nuidprogproc, sbparametros);
      COMMIT;
      ut_trace.TRACE ('FIN CEO_FWInterfazSCE.ValidarCP_INTSCE', 3);
  */
   END VALIDALDCIREPL;

   PROCEDURE validaldcireplRO
   IS
    /*******************************************************************************
     Propiedad intelectual de Gases de Occidenes.

     Nombre         :  validaldcireplRO
     Descripcion    :  Forma para validar replica de cecos por TT
     Autor          :  Diego Andres Cardona Garcia
     Fecha          :  31 Julio de 2014
     Parametros         Descripcion
     ============    ===================


     Historia de Modificaciones
     Fecha             Autor                 Modificacion
     =========       =========          ====================
   /*******************************************************************************/

      cnunull_attribute   CONSTANT NUMBER                             := 2126;
      nuerror                      NUMBER;
      nudepto                      ge_boinstancecontrol.stysbvalue;
      nulocal                      ge_boinstancecontrol.stysbvalue;
      nutipotr                     ge_boinstancecontrol.stysbvalue;
      nuitem                       ge_boinstancecontrol.stysbvalue;
      nuidprogproc                 open.ge_process_schedule.process_schedule_id%TYPE;
      sbparametros                 open.ge_process_schedule.parameters_%TYPE;
      sbcadconexion                VARCHAR2 (2000);
      sbusuario                    VARCHAR2 (2000);
      sbpass                       VARCHAR2 (2000);
      sbinstancia                  VARCHAR2 (2000);
      sbcadconexencr               VARCHAR2 (2000);
      csbllave            CONSTANT VARCHAR2 (20)          := '10101000101011';
      dtfechaini                   DATE;
      dtfechafin                   DATE;
      nucantidad                   NUMBER;
      nucantidadceor               NUMBER;
      nuActa                       ldci_actacont.idacta%TYPE;

   BEGIN

      --<<VAlida los parametros del reporte que no esten en Nullo-->>
      IF (cnunull_attribute IS NULL)
      THEN
         nuerror := 1;
      END IF;

      --<<Se realiza la asignacion de los valores de los campos a las variables definidas>>--
      nudepto := ge_boinstancecontrol.fsbgetfieldvalue ('LDCI_CECOUBIGETRA', 'CCBGDPTO');
      nulocal := ge_boinstancecontrol.fsbgetfieldvalue ('LDCI_CECOUBIGETRA', 'CCBGLOCA');
      nutipotr := ge_boinstancecontrol.fsbgetfieldvalue ('LDCI_CECOUBIGETRA', 'CCBGTITR');

     --<<VAlida los parametros del reporte que no esten en Nullo-->>
      IF (nudepto IS NULL)
      THEN
         ERRORS.seterror (cnunull_attribute, 'Debe Indicar Departamento ');
         RAISE ex.controlled_error;
      END IF;

      --<<VAlida los parametros del reporte que no esten en Nullo-->>
      IF (nulocal IS NULL)
      THEN
         ERRORS.seterror (cnunull_attribute, 'Debe Indicar Localidad');
         RAISE ex.controlled_error;
      END IF;

      IF (nutipotr IS NULL)
      THEN
         ERRORS.seterror (cnunull_attribute, 'Debe Indicar Tipo Trabajo');
         RAISE ex.controlled_error;
      END IF;

      -- Obtiene la programacion en memoria
      nuidprogproc := ge_boschedule.fnugetscheduleinmemory;
      -- se obtiene parametros
      sbparametros := dage_process_schedule.fsbgetparameters_ (nuidprogproc);
      ge_bodatabaseconnection.getconnectionstring (sbusuario,
                                                   sbpass,
                                                   sbinstancia
                                                  );

   END validaldcireplRO;

  FUNCTION fvaGetClasifimat (inutipotrab IN NUMBER)
  /************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION   : fvaGetClasifimat
     AUTOR     : Heiber Barco
     FECHA     : 20-01-2014
     DESCRIPCION  : Tiquete:
                    funcion que se encarga de obtener el clasificador materiales

    Parametros de Entrada

    Parametros de Salida

    Historia de Modificaciones
    Autor    Fecha       Descripcion
  ************************************************************************/
  return NUMBER
  is
     cursor cuClasifica
     is
     select cltmclco from ldci_clascottmat
     where cltmtitr = inutipotrab;


     nuclasifi          ldci_cuenclasifi.cuenclasifi%TYPE;
  begin

     open cuClasifica;
     fetch cuClasifica into nuclasifi;
     close cuClasifica;

     return(nuclasifi);

  exception
  when others then
       ldci_pkInterfazSAP.vaMensError :=  '[fvaGetClasifimat] - No se pudo obtener el clasificador '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
       LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,USER,USERENV('TERMINAL'));
       return('-1');
  end fvaGetClasifimat;

  FUNCTION fvaGetCuenClasiMat (inutipotrab IN NUMBER)
  /************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION   : fvaGetCuenClasiMat
     AUTOR     : Heiber Barco
     FECHA     : 12-01-2014
     DESCRIPCION  : Tiquete:
                    funcion que se encarga de obtener la cuenta del clasificador materiales

    Parametros de Entrada

    Parametros de Salida

    Historia de Modificaciones
    Autor    Fecha       Descripcion
  ************************************************************************/
  return VARCHAR
  is
     cursor cuCuentaClasif
     is
     select cuencontabl from ldci_clascottmat, ldci_cuenclasifi
     where cltmtitr = inutipotrab
       AND cuenclasifi = cltmclco;


     vaCuenta          ldci_cuenclasifi.cuencontabl%TYPE;
  begin

     open cuCuentaClasif;
     fetch cuCuentaClasif into vaCuenta;
     close cuCuentaClasif;

     return(vaCuenta);

  exception
  when others then
       ldci_pkInterfazSAP.vaMensError :=  '[fvaGetCuenClasiMat] - No se pudo obtener La cuenta del material '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
       LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,USER,USERENV('TERMINAL'));
       return('-1');
  end fvaGetCuenClasiMat;

FUNCTION fnuGetTipoTrab (inuorden IN NUMBER)
return NUMBER
  is
 /************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION   : fnuGetTipoTrab
     AUTOR     : Heiber Barco
     FECHA     : 18-02-2015
     DESCRIPCION  : Tiquete:
                    Funcion que se encarga de obtener el tipo de trabajo real

    Parametros de Entrada

    Parametros de Salida

    Historia de Modificaciones
    Autor    Fecha       Descripcion
    heiberb  18-02-2015  Se excluyen los tipos de trabajo para gestion cartera.
  ************************************************************************/


 nuOrden NUMBER;
 nuTipotrab NUMBER := 0;
 nuTipotrab1 NUMBER := 0;
 vaNit  varchar2(2000);
 vaNitP  varchar2(2000);
 nuTipotrabDef NUMBER := 0;

 CURSOR cuTipotrab IS
   SELECT (SELECT oren.task_type_id FROM or_order oren WHERE oren.order_id = ory.order_id) tipo_trab
     FROM or_related_order ory, or_order ore
    WHERE ory.related_order_id = inuorden
      AND ore.order_id = ory.related_order_id
      AND ory.rela_order_type_id in (SELECT transition_type_id
													FROM ge_transition_type
												 WHERE ',' || (SELECT casevalo FROM ldci_carasewe WHERE casecodi = 'TIPORELATED') || ',' LIKE
															 '%,' || transition_type_id || ',%');

 CURSOR cuTipotrab1 IS
   SELECT (SELECT oren.task_type_id FROM or_order oren WHERE oren.order_id = ory.order_id) tipo_trab
     FROM or_related_order ory, or_order ore
    WHERE ory.related_order_id = inuorden
      AND ore.order_id = ory.related_order_id
      AND ore.task_type_id NOT IN (SELECT task_type_id
                                      FROM or_task_type
                                     WHERE ',' || (SELECT casevalo
                                                     FROM ldci_carasewe
                                                    WHERE casecodi = 'OTGESTCART')
                                               || ',' LIKE '%,' || task_type_id || ',%')
      AND ory.rela_order_type_id in (SELECT transition_type_id
													FROM ge_transition_type
												 WHERE ',' || (SELECT casevalo FROM ldci_carasewe WHERE casecodi = 'TIPORELATED') || ',' LIKE
															 '%,' || transition_type_id || ',%');

  cursor cuSistema is
   select sistnitc from sistema;

BEGIN

ldci_pkwebservutils.proCaraServWeb('WS_COSTOS', 'NITGDOCAR', vaNitP, osbErrorMessage);

  OPEN cuTipotrab;
  FETCH cuTipotrab INTO nuTipotrab;
  CLOSE cuTipotrab;

  OPEN cuTipotrab1;
  FETCH cuTipotrab1 INTO nuTipotrab1;
  CLOSE cuTipotrab1;

  open cuSistema;
  fetch cuSistema into vaNit;
  close cuSistema;

  if vaNitP <> vaNit then

   nuTipotrabDef := nuTipotrab1;

  else

   nuTipotrabDef := nuTipotrab;

  end if;

  RETURN (nuTipotrabDef);

exception
  when others then
       ldci_pkInterfazSAP.vaMensError :=  '[fnuGetTipoTrab] - No se pudo obtener el tipo_trab '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
       LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,USER,USERENV('TERMINAL'));
       return(-1);
  end fnuGetTipoTrab;


FUNCTION fnuActualizaFact (nuICLINUDO   in LDCI_INCOLIQU.ICLINUDO%type)
return NUMBER
  is

      -- Cursor para obterner el nit de la LDC que ejecuta el proceso.
      --
      CURSOR cuSistema
      IS
      SELECT s.sistnitc
        FROM sistema s;

      vsbnit     sistema.sistnitc%type;
      VsbNitLdc  ldci_carasewe.casevalo%type;

BEGIN

  --<< CA = 200-2602
  ldci_pkwebservutils.proCaraServWeb('WS_COSTOS', 'VAL_NIT_SERV_CUMP_GDCA', VsbNitLdc, osbErrorMessage);

  UPDATE ldci_encaintesap
    SET  clasedoc = (SELECT casevalo FROM ldci_carasewe WHERE casecodi = 'DOCACTAFACT')
    WHERE cod_interfazldc = nuICLINUDO;

  --<
  -- CA-200-2602
  -- Se valida el nit de la LDC para que solo aplique lo de la clave 70 para GDCA

  OPEN cuSistema;
  FETCH cuSistema INTO vsbnit;
  CLOSE cuSistema;

  IF vsbnit = VsbNitLdc THEN
    -- Elimina los registros con cuenta contable LIKE '1422020%'
    DELETE LDCI_DETAINTESAP D
     WHERE D.COD_INTERFAZLDC = nuICLINUDO
       AND D.CLASECTA LIKE '1422020%';

    -- Se actualiza con clave 70 cuando la cuenta LIKE  '243695%'
    UPDATE LDCI_DETAINTESAP D
       SET D.CLAVCONT = '70'
     WHERE D.COD_INTERFAZLDC = nuICLINUDO
       AND D.CLASECTA LIKE  '243695%';

  END IF;
  --<< CA-200-2602
  --

  COMMIT;
  RETURN (0);

exception
  when others then
       ldci_pkInterfazSAP.vaMensError :=  '[fnuActualizaFact] - No se pudo actualizar el tipo documento '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
       LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,USER,USERENV('TERMINAL'));
       return(-1);
  end fnuActualizaFact;

  FUNCTION fvaGetLibro (ivaTipInterfaz IN ldci_tipointerfaz.tipointerfaz%TYPE)
  /************************************************************************
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION   : fvaGetLibro
     AUTOR     : Heiber Barco
     FECHA     : 14-03-2014
     DESCRIPCION  : Tiquete:
                    funcion que se encarga de obtener el libro del tipo interfaz.

    Parametros de Entrada

    Parametros de Salida

    Historia de Modificaciones
    Autor    Fecha       Descripcion
  ************************************************************************/
  return VARCHAR
  is
     cursor cuLibros
     is
     select ledgers from ldci_tipointerfaz
     where tipointerfaz = ivaTipInterfaz
     GROUP BY ledgers;


     vaLibro          ldci_tipointerfaz.ledgers%TYPE;
  begin

     open cuLibros;
     fetch cuLibros into vaLibro;
     close cuLibros;

     return(vaLibro);

  exception
  when others then
       ldci_pkInterfazSAP.vaMensError :=  '[fvaGetLibro] - No se pudo obtener el libro '||sqlerrm||' '||DBMS_UTILITY.format_error_backtrace;
       LDCI_pkTrazaInterfaces.pRegiMensaje(ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,ldci_pkInterfazSAP.vaMensError,to_char(SYSTIMESTAMP,'HH24:MI:SS.FF'),ldci_pkinterfazsap.nuCODDOCUINTEINGRSAP,USER,USERENV('TERMINAL'));
       return('-1');
  end fvaGetLibro;

END ldci_pkinterfazactas;
/
