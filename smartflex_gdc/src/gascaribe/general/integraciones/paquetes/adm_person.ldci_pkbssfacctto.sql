CREATE OR REPLACE PACKAGE ADM_PERSON.LDCI_PKBSSFACCTTO AS
/************************************************************************
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

         PAQUETE : LDCI_PKBSSFACCTTO
         AUTOR   : Hector Fabio Dominguez
         FECHA   : 29/01/2013
         RICEF   : I019
   DESCRIPCION   : Paquete de interfaz,tiene como funcion principal
                   el encapsulamiento de APIs proporcionadas por SMRTFLEX
                   para integraci?n de los procesos BSS Facturaci?n

 Parametros de Entrada

    inuSuscCodi         NUMBER(8,0) codigo del suscriptor o contrato

 Parametros de Salida

    onuSaldoPend         out   NUMBER
    onuErrorCode         out   NUMBER
    osbErrorMessage      out   VARCHAR2

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
 HECTORFDV    29/01/2013  Creacion del paquete
 FRESIE       27/02/2019  Se modifica el procedimiento proFechMaxRevision bajo el número de cambio 200-2423
************************************************************************/


  PROCEDURE proCnltaFactPorCttoAux(inuSuscCodi         IN   SUSCRIPC.SUSCCODI%TYPE,
                               odtUltPago          OUT  DATE,
                               onuValorUltPago     OUT  NUMBER,
                               onuSaldoUltFact     OUT  NUMBER,
                               odtLimitePago       OUT  DATE,
                               onuErrorCode        OUT  NUMBER,
                               osbErrorMessage     OUT  VARCHAR2);

  PROCEDURE proCnltaFactPorCtto(inuSuscCodi         IN   SUSCRIPC.SUSCCODI%TYPE,
                                 odtUltPago          OUT  DATE,
                                 onuValorUltPago     OUT  NUMBER,
                                 odtPeriFact         OUT  DATE,
                                 CUCLIENTES          OUT  SYS_REFCURSOR,
                                 CUCONTRATOS         OUT  SYS_REFCURSOR,
                                 CUFACTURAS          OUT  SYS_REFCURSOR,
                                 CUCUENTAS           OUT  SYS_REFCURSOR,
                                 onuErrorCode        OUT  NUMBER,
                                 osbErrorMessage     OUT  VARCHAR2);

  PROCEDURE proFechMaxRevision (  inuSuscCodi         IN   SUSCRIPC.SUSCCODI%TYPE,
                                   odtFechaMax         OUT  DATE,
                                   onuErrorCode        OUT  NUMBER,
                                   osbErrorMessage     OUT  VARCHAR2);

END LDCI_PKBSSFACCTTO;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDCI_PKBSSFACCTTO AS

PROCEDURE proFechMaxRevision (  inuSuscCodi            in   SUSCRIPC.SUSCCODI%TYPE,
                                   odtFechaMax         out  DATE,
                                   onuErrorCode        out  NUMBER,
                                   osbErrorMessage     out  VARCHAR2)
  AS

/************************************************************************
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

 PROCEDIMIENTO : proFechMaxRevision
         AUTOR : Hector Fabio Dominguez
         FECHA : 04/03/2013
         RICEF : I026
 DESCRIPCION : Paquete de inter faz con IVR,tiene como funcion principal
               el encapsulamiento de APIs

 Parametros de Entrada

    inuproductid        in NUMBER,


 Parametros de Salida

       odtFechaMax         out  DATE,
       onuErrorCode        out  NUMBER,
       osbErrorMessage     out  VARCHAR2

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
 HECTORFDV    04/03/2013  Creacion del paquete
 FRESIE       27/02/2019  Se modifica para quitar la consulta de la fecha de revisión del Api de Open y que sea extraido de la tabla LDC_PLAZOS_CERT
************************************************************************/
   inuproductid NUMBER;
   TESTER VARCHAR2(2000);
   odtFechaMax2 DATE;

   CURSOR cuPlazoMax (nuContrato OPEN.SUSCRIPC.SUSCCODI%TYPE)IS
   SELECT *
   FROM OPEN.LDC_PLAZOS_CERT
   WHERE PLAZOS_CERT_ID =
   (SELECT MAX(PLAZOS_CERT_ID)
   FROM OPEN.LDC_PLAZOS_CERT
   WHERE ID_CONTRATO = nuContrato);

   rgPlazoMax cuPlazoMax%ROWTYPE;

BEGIN
    odtFechaMax:=TO_DATE('11/11/1111');
    --SELECT PRODUCT_ID INTO inuproductid FROM PR_PRODUCT p WHERE SUBSCRIPTION_ID=inuSuscCodi
    --AND p.product_type_id = dald_parameter.fnuGetNumeric_Value('COD_SERV_GAS',null)  AND ROWNUM=1;

    OPEN cuPlazoMax(inuSuscCodi);
    FETCH cuPlazoMax INTO rgPlazoMax;

    IF cuPlazoMax%NOTFOUND THEN
      odtFechaMax2 := SYSDATE;
      onuErrorCode := -1;
      osbErrorMessage := 'El contrato ' || inuSuscCodi || ' ingresado no tiene registros en esta consulta';
    ELSE
      odtFechaMax2 := rgPlazoMax.PLAZO_MAXIMO;
      onuErrorCode := 0;
      osbErrorMessage := 'OPERACION EXITOSA';
    END IF;

    CLOSE cuPlazoMax;

	  --OS_GETPERIODREVMAXDATE( inuproductid,odtFechaMax2,onuErrorCode, osbErrorMessage);
    odtFechaMax:=TO_DATE(odtFechaMax2,'DD-MM-YYYY HH24:MI:SS');

EXCEPTION
      WHEN ex.CONTROLLED_ERROR then
         ROLLBACK;
         Errors.geterror (onuErrorCode, osbErrorMessage);
      WHEN OTHERS THEN
        osbErrorMessage := 'Error consultando la fecha maxima de revision: '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
        pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
        Errors.seterror;
        Errors.geterror (onuErrorCode, osbErrorMessage);

END proFechMaxRevision;


 PROCEDURE proCnltaFactPorCttoAux(inuSuscCodi         in   SUSCRIPC.SUSCCODI%TYPE,
                               odtUltPago          out  DATE,
                               onuValorUltPago     out  NUMBER,
                               onuSaldoUltFact     out  NUMBER,
                               odtLimitePago       out  DATE,
                               onuErrorCode        out  NUMBER,
                               osbErrorMessage     out  VARCHAR2) AS
 /************************************************************************
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

 PROCEDIMIENTO : proCnltaFactPorCtto
         AUTOR : Hector Fabio Dominguez
         FECHA : 29/01/2013
         RICEF : I019
   DESCRIPCION : Paquete de interfaz,tiene como funcion principal
               el encapsulamiento de APIs proporcionadas por SMRTFLEX
               para la consulta de facturas por contrato

 Parametros de Entrada

    inuSuscCodi         NUMBER(8,0) c?digo del suscriptor o contrato

 Parametros de Salida

    odtUltPago          DATE           Fecha del ?ltimo pago
    onuValorUltPago     NUMBER(13,2)   Valor del ?ltimo pago
    onuSaldoUltFact     NUMBER(15,2)   Saldo de la ?ltima factura
    odtLimitePago       DATE           Fecha l?mite de pago
    onuErrorCode        NUMBER(18,0)   C?digo de error retornado por Smartflex
    osbErrorMessage     VARCHAR2(2000) Descripci?n del error retornado por SmartFlex

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
 HECTORFDV    29/01/2013  Creacion del paquete
************************************************************************/

  /*
   * Declaracion XML necesario para realizar
   * la consulta de fecha limite de pago y
   * valor del ?ltimo pago API OS_PAYMENTSQUERY
   */
  ICLPARAMXMLPAYMENTS CLOB;
  OCLRESULTXMLPAYMENTS CLOB;

  /*
   * Declaracion XML necesario para realizar
   * la consulta para obtener el saldo de la
   * ?ltima factura y la fecha l?mite de pago
   * as? como la variable de salida donde se
   * conseguiran los datos.
   */
  ICLPARAMBALANCETOPAY     CLOB;
  OCLRESULTXMLBALANCETOPAY CLOB;

BEGIN

 onuErrorCode:=0;

 ICLPARAMXMLPAYMENTS     :='<?xml version="1.0" encoding="utf-8" ?><Pagos_Contrato><Contrato>'||inuSuscCodi||'</Contrato><Cantidad>1</Cantidad></Pagos_Contrato>';

 --ICLPARAMBALANCETOPAY    :='<?xml version="1.0" encoding="utf-8" ?><Saldos_Producto><Num_Servicio>'||inuSuscCodi||'</Num_Servicio></Saldos_Producto>';
   ICLPARAMBALANCETOPAY    :='<?xml version = "1.0" encoding="utf-8"?><Saldos_Contrato><Cod_Contrato>'||inuSuscCodi||'</Cod_Contrato></Saldos_Contrato>';

  /*
   * Se consulta el API de SmartFlex  OS_PAYMENTSQUERY
   * Para obtener  la fecha limite de pago
   * y el valor del ?ltimo pago.
   */
  OS_PAYMENTSQUERY(2,ICLPARAMXMLPAYMENTS, OCLRESULTXMLPAYMENTS, onuErrorCode,osbErrorMessage );

  /*
   * Extraemos la informaci?n necesaria
   * Para retornar al servicio
   * Se verifica para que solo se lean los
   * valores si el resultado de la consulta fu? exitoso
   */

 IF(ONUERRORCODE=0) then

  odtUltPago      := TO_DATE((xmltype(OCLRESULTXMLPAYMENTS).extract('//Resultados/His_Pagos/Pago/Fecha_Pago/text()').getStringVal()),'ddmmyyyy');
  onuValorUltPago := (xmltype(OCLRESULTXMLPAYMENTS).extract('//Resultados/His_Pagos/Pago/Valor_Pagado/text()').getNumberVal());
 END IF;

  /*
   * Se consulta el API de SmartFlex  OS_BALANCETOPAY
   * Para obtener  el saldo de la ?ltima factura
   * fecha l?mite de pago
   */
   OS_BALANCETOPAY(  2, ICLPARAMBALANCETOPAY,  OCLRESULTXMLBALANCETOPAY, ONUERRORCODE, OSBERRORMESSAGE );
  --  proBalancetopay(inuSuscCodi,onuSaldoUltFact,odtLimitePago,onuErrorCode,osbErrorMessage);
  -- DBMS_OUTPUT.PUT_LINE('onuErrorCode = ' || onuErrorCode);
  /*
   * Extraemos la informaci?n necesaria
   * Para retornar al servicio
   * Se verifica para que solo se lean los
   * valores si el resultado de la consulta fu? exitoso
   */

   IF(ONUERRORCODE=0) then


    SELECT deuda,fechaLimite INTO onuSaldoUltFact,odtLimitePago
    FROM(
                      SELECT TO_DATE(FACTURA.Fecha_Limite,'ddmmyyyy') as fechaLimite,to_number(FACTURA.Deuda_Factura) as deuda
                          FROM   XMLTable('//Contratos/Facturas' PASSING XMLTYPE(OCLRESULTXMLBALANCETOPAY)
                                 COLUMNS  row_num for ordinality,
                                 Deuda_Factura    VARCHAR2(10) PATH 'Deuda_Factura',
                                 Fecha_Limite     VARCHAR2(12) PATH 'Fecha_Limite') as FACTURA
                                 ORDER BY Fecha_Limite desc
    ) where ROWNUM <=1;
   --odtLimitePago   := TO_DATE((xmltype(OCLRESULTXMLBALANCETOPAY).extract('//Cliente/Contratos/Facturas/Fecha_Limite/text()').getStringVal()),'ddmmyyyy');
   --onuSaldoUltFact := (xmltype(OCLRESULTXMLBALANCETOPAY).extract('//Cliente/Deuda/text()').getNumberVal());

  END IF;

COMMIT;

 EXCEPTION
      WHEN ex.CONTROLLED_ERROR then
         ROLLBACK;
      WHEN OTHERS THEN
         onuErrorCode := -1;
         osbErrorMessage := 'Error consultando la fecha: '||Sqlerrm;

  END proCnltaFactPorCttoAux;


   /*


   */

  PROCEDURE proCnltaFactPorCtto (inuSuscCodi         IN   SUSCRIPC.SUSCCODI%TYPE,
                                 odtUltPago          OUT  DATE,
                                 onuValorUltPago     OUT  NUMBER,
                                 odtPeriFact         OUT  DATE,
                                 CUCLIENTES          OUT SYS_REFCURSOR,
                                 CUCONTRATOS         OUT SYS_REFCURSOR,
                                 CUFACTURAS          OUT SYS_REFCURSOR,
                                 CUCUENTAS           OUT SYS_REFCURSOR,
                                 onuErrorCode        OUT  NUMBER,
                                 osbErrorMessage     OUT  VARCHAR2) AS
 /************************************************************************
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

 PROCEDIMIENTO : proCnltaFactPorCtto
         AUTOR : Hector Fabio Dominguez
         FECHA : 29/01/2013
         RICEF : I019
   DESCRIPCION : Paquete de interfaz,tiene como funcion principal
               el encapsulamiento de APIs proporcionadas por SMRTFLEX
               para la consulta de facturas por contrato

 Parametros de Entrada

    inuSuscCodi         NUMBER(8,0) c?digo del suscriptor o contrato

 Parametros de Salida

    odtUltPago          DATE           Fecha del ?ltimo pago
    onuValorUltPago     NUMBER(13,2)   Valor del ?ltimo pago
    onuSaldoUltFact     NUMBER(15,2)   Saldo de la ?ltima factura
    odtLimitePago       DATE           Fecha l?mite de pago
    onuErrorCode        NUMBER(18,0)   C?digo de error retornado por Smartflex
    osbErrorMessage     VARCHAR2(2000) Descripci?n del error retornado por SmartFlex

 Historia de Modificaciones

 Autor        Fecha       Descripcion.
 HECTORFDV    29/01/2013  Creacion del paquete
************************************************************************/

  /*
   * Declaracion XML necesario para realizar
   * la consulta de fecha limite de pago y
   * valor del ?ltimo pago API OS_PAYMENTSQUERY
   */
  ICLPARAMXMLPAYMENTS CLOB;
  OCLRESULTXMLPAYMENTS CLOB;

  /*
   * Declaracion XML necesario para realizar
   * la consulta para obtener el saldo de la
   * ?ltima factura y la fecha l?mite de pago
   * as? como la variable de salida donde se
   * conseguiran los datos.
   */
  ICLPARAMBALANCETOPAY     CLOB;
  OCLRESULTXMLBALANCETOPAY CLOB;

BEGIN

 onuErrorCode:=0;

 ICLPARAMXMLPAYMENTS     :='<?xml version="1.0" encoding="utf-8" ?><Pagos_Contrato><Contrato>'||inuSuscCodi||'</Contrato><Cantidad>1</Cantidad></Pagos_Contrato>';

 --ICLPARAMBALANCETOPAY    :='<?xml version="1.0" encoding="utf-8" ?><Saldos_Producto><Num_Servicio>'||inuSuscCodi||'</Num_Servicio></Saldos_Producto>';
   ICLPARAMBALANCETOPAY    :='<?xml version = "1.0" encoding="utf-8"?><Saldos_Contrato><Cod_Contrato>'||inuSuscCodi||'</Cod_Contrato></Saldos_Contrato>';

  /*
   * Se consulta el API de SmartFlex  OS_PAYMENTSQUERY
   * Para obtener  la fecha limite de pago
   * y el valor del ?ltimo pago.
   */
  OS_PAYMENTSQUERY(2,ICLPARAMXMLPAYMENTS, OCLRESULTXMLPAYMENTS, onuErrorCode,osbErrorMessage );

  /*
   * Extraemos la informaci?n necesaria
   * Para retornar al servicio
   * Se verifica para que solo se lean los
   * valores si el resultado de la consulta fu? exitoso
   */

 IF(ONUERRORCODE=0) then

  odtUltPago      := TO_DATE((xmltype(OCLRESULTXMLPAYMENTS).extract('//Resultados/His_Pagos/Pago/Fecha_Pago/text()').getStringVal()),'DD-MM-YYYY');
  onuValorUltPago := (xmltype(OCLRESULTXMLPAYMENTS).extract('//Resultados/His_Pagos/Pago/Valor_Pagado/text()').getNumberVal());
 END IF;

  /*
   * Se consulta el API de SmartFlex  OS_BALANCETOPAY
   * Para obtener  el saldo de la ?ltima factura
   * fecha l?mite de pago
   */
   OS_BALANCETOPAY(  2, ICLPARAMBALANCETOPAY,  OCLRESULTXMLBALANCETOPAY, ONUERRORCODE, OSBERRORMESSAGE );
  --  proBalancetopay(inuSuscCodi,onuSaldoUltFact,odtLimitePago,onuErrorCode,osbErrorMessage);
  -- DBMS_OUTPUT.PUT_LINE('onuErrorCode = ' || onuErrorCode);
  /*
   * Extraemos la informaci?n necesaria
   * Para retornar al servicio
   * Se verifica para que solo se lean los
   * valores si el resultado de la consulta fu? exitoso
   */

   IF(ONUERRORCODE=0) THEN



   SELECT peri.PEFAFEPA INTO odtPeriFact
   FROM PERIFACT peri, suscripc sus
   WHERE sus.SUSCCICL = peri.pefacicl AND
         sus.SUSCCODI=inuSuscCodi     AND
         peri.pefaactu='S'            AND
         ROWNUM=1;
    --odtPeriFact


     /*
    SELECT fechaLimite INTO odtPeriFact
    FROM(
                      SELECT TO_DATE(FACTURA.Fecha_Limite,'ddmmyyyy') as fechaLimite,to_number(FACTURA.Deuda_Factura) as deuda
                          FROM   XMLTable('//Contratos/Facturas' PASSING XMLTYPE(OCLRESULTXMLBALANCETOPAY)
                                 COLUMNS  row_num for ordinality,
                                 Deuda_Factura    VARCHAR2(10) PATH 'Deuda_Factura',
                                 Fecha_Limite     VARCHAR2(12) PATH 'Fecha_Limite') as FACTURA
                                 ORDER BY Fecha_Limite desc
    ) where ROWNUM <=1;
   */

    /*
     * Se referencia e cursor de listado
     * de cuentas
     */
    OPEN CUCUENTAS FOR  SELECT Cod_Cuenta,
                               Cod_Producto,
                               Num_Servicio,
                               Id_Tipo_Producto,
                               Desc_Tipo_Producto,
                               Deuda_Cuenta,
                               (select cucofact from cuencobr where cucocodi=Cod_Cuenta) as factura
    FROM   XMLTable('//Contratos/Facturas/Cuentas' PASSING XMLTYPE(OCLRESULTXMLBALANCETOPAY)
                                 COLUMNS  row_num for ordinality,
                                  Cod_Cuenta  NUMBER PATH 'Cod_Cuenta',
                                  Cod_Producto  NUMBER PATH 'Cod_Producto',
                                  Num_Servicio  NUMBER PATH 'Num_Servicio',
                                  Id_Tipo_Producto  NUMBER PATH 'Id_Tipo_Producto',
                                  Desc_Tipo_Producto  VARCHAR2(1000) PATH 'Desc_Tipo_Producto',
                                  Deuda_Cuenta  NUMBER PATH 'Deuda_Cuenta') as FACTURA;


    /*
     * Se referencia e cursor de listado
     * de facturas
     */
    OPEN CUFACTURAS FOR SELECT   TO_CHAR(TO_DATE(Fecha_Gen,'DD-MM-YYYY'),'DD-MM-YYYY') as Fecha_Gen,
                                 TO_CHAR(TO_DATE(Fecha_Limite,'DD-MM-YYYY'),'DD-MM-YYYY') as Fecha_Limite,
                                 Id_Factura,
                                 Tipo_Comprobante,
                                 Tipo_Documento,
                                 Punto_Emision,
                                 No_Fiscal,
                                 Prefijo,
                                 Empresa,
                                 Deuda_Factura,
                                 Anio_Fact,
                                 Mes_Fact,
                                 Periodo_Fact,
                                 Cod_Autorizacion,
                                 Venc_Numeracion
    FROM   XMLTable('//Contratos/Facturas' PASSING XMLTYPE(OCLRESULTXMLBALANCETOPAY)
                                 COLUMNS  row_num for ordinality,
                                 Fecha_Gen  VARCHAR2(10) PATH 'Fecha_Gen',
                                 Fecha_Limite  VARCHAR2(10) PATH 'Fecha_Limite',
                                 Id_Factura  NUMBER PATH 'Id_Factura',
                                 Tipo_Comprobante  VARCHAR2(1000) PATH 'Tipo_Comprobante',
                                 Tipo_Documento  NUMBER PATH 'Tipo_Documento',
                                 Punto_Emision  VARCHAR2(1000) PATH 'Punto_Emision',
                                 No_Fiscal NUMBER PATH 'No_Fiscal',
                                 Prefijo  VARCHAR2(100) PATH 'Prefijo',
                                 Empresa  NUMBER PATH 'Empresa',
                                 Deuda_Factura  NUMBER PATH 'Deuda_Factura',
                                 Anio_Fact  NUMBER PATH 'Anio_Fact',
                                 Mes_Fact  NUMBER PATH 'Mes_Fact',
                                 Periodo_Fact  NUMBER PATH 'Periodo_Fact',
                                 Cod_Autorizacion  NUMBER PATH 'Cod_Autorizacion',
                                 Venc_Numeracion  NUMBER PATH 'Venc_Numeracion') as FACTURA
                                 ORDER BY Fecha_Limite desc;
  /*
   * Se referencia e cursor de listado
   * de contratos
   */
   OPEN CUCONTRATOS FOR SELECT  *
   FROM   XMLTable('//Contratos' PASSING XMLTYPE(OCLRESULTXMLBALANCETOPAY)
                                  COLUMNS  row_num for ordinality,
                                  Cod_Contrato NUMBER(8,0) PATH 'Cod_Contrato',
                                  Ub_Geografica VARCHAR(500) PATH 'Ub_Geografica',
                                  Barrio  VARCHAR(500) PATH 'Barrio',
                                  Dir_Cobro VARCHAR(500) PATH 'Dir_Cobro',
                                  Tipo_Dir_Cobro  VARCHAR(500) PATH 'Tipo_Dir_Cobro',
                                  Deuda_Contrato  NUMBER(13,2) PATH 'Deuda_Contrato',
                                  Entidad VARCHAR(500) PATH 'Entidad',
                                  Cuenta_Banc  VARCHAR(500) PATH 'Cuenta_Banc',
                                  Facturas_Adeudadas NUMBER(4,0)  PATH 'Facturas_Adeudadas') as CONTRATO;

     /*
     * Se referencia e cursor de listado
     * de clientes

     */
    OPEN CUCLIENTES FOR SELECT  *
    FROM   XMLTable('//Cliente' PASSING XMLTYPE(OCLRESULTXMLBALANCETOPAY)
                                  COLUMNS  row_num for ordinality,
                                  Tipo_Id      NUMBER(15,0)  PATH 'Tipo_Id',
                                  Numero_Id    VARCHAR2(200)  PATH 'Numero_Id',
                                  Nombre       VARCHAR2(100) PATH 'Nombre',
                                  Deuda        NUMBER(13,2)  PATH 'Deuda',
                                  No_Contratos NUMBER(8,0)   PATH 'No_Contratos') as CLIENTE;

  END IF;


  IF NOT CUCLIENTES%ISOPEN THEN
        OPEN CUCLIENTES FOR SELECT * FROM dual where 1=2;
    END IF;
    IF NOT CUCONTRATOS%ISOPEN THEN
        OPEN CUCONTRATOS FOR SELECT * FROM dual where 1=2;
    END IF;
    IF NOT CUFACTURAS%ISOPEN THEN
        OPEN CUFACTURAS FOR SELECT * FROM dual where 1=2;
    END IF;
    IF NOT CUCUENTAS%ISOPEN THEN
        OPEN CUCUENTAS FOR SELECT * FROM dual where 1=2;
    END IF;

   IF onuErrorCode = 900565 THEN
      onuErrorCode:=0;
   END IF;

 EXCEPTION
      WHEN ex.CONTROLLED_ERROR then
         ROLLBACK;
          Errors.geterror (onuErrorCode, osbErrorMessage);
          IF NOT CUCLIENTES%ISOPEN THEN
              OPEN CUCLIENTES FOR SELECT * FROM dual where 1=2;
          END IF;
          IF NOT CUCONTRATOS%ISOPEN THEN
              OPEN CUCONTRATOS FOR SELECT * FROM dual where 1=2;
          END IF;
          IF NOT CUFACTURAS%ISOPEN THEN
              OPEN CUFACTURAS FOR SELECT * FROM dual where 1=2;
          END IF;
          IF NOT CUCUENTAS%ISOPEN THEN
              OPEN CUCUENTAS FOR SELECT * FROM dual where 1=2;
          END IF;

          dbms_output.put_line('Error: '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
      WHEN OTHERS THEN
         onuErrorCode := -1;
         osbErrorMessage := 'Error consultando la informaci?n de la factura: '||Sqlerrm;
         pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
         Errors.seterror;
         Errors.geterror (onuErrorCode, osbErrorMessage);

         dbms_output.put_line('Error: '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);

         IF NOT CUCLIENTES%ISOPEN THEN
              OPEN CUCLIENTES FOR SELECT * FROM dual where 1=2;
          END IF;
          IF NOT CUCONTRATOS%ISOPEN THEN
              OPEN CUCONTRATOS FOR SELECT * FROM dual where 1=2;
          END IF;
          IF NOT CUFACTURAS%ISOPEN THEN
              OPEN CUFACTURAS FOR SELECT * FROM dual where 1=2;
          END IF;
          IF NOT CUCUENTAS%ISOPEN THEN
              OPEN CUCUENTAS FOR SELECT * FROM dual where 1=2;
          END IF;

  END proCnltaFactPorCtto;

 END LDCI_PKBSSFACCTTO;
/

PROMPT Asignación de permisos para el paquete LDCI_PKBSSFACCTTO
begin
  pkg_utilidades.prAplicarPermisos('LDCI_PKBSSFACCTTO', 'ADM_PERSON');
end;
/
GRANT EXECUTE on ADM_PERSON.LDCI_PKBSSFACCTTO to INTEGRACIONES;
GRANT EXECUTE on ADM_PERSON.LDCI_PKBSSFACCTTO to INTEGRADESA;
GRANT EXECUTE on ADM_PERSON.LDCI_PKBSSFACCTTO to REXEINNOVA;
/
