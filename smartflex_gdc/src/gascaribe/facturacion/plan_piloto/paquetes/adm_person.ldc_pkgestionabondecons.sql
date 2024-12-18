CREATE OR REPLACE PACKAGE adm_person.ldc_pkgestionabondecons IS
/***************************************************************************
   Historia de Modificaciones
   Autor       Fecha        Descripcion.
   Adrianavg   26/06/2024   OSF-2883: Migrar del esquema OPEN al esquema ADM_PERSON
   ***************************************************************************/
     nuIdReporte   reportes.reponume%type;
   nuConsecutivo NUMBER := 0;

    FUNCTION fnuCrReportHeader return number;

    PROCEDURE crReportDetail(inuIdReporte in repoinco.reinrepo%type,
                           inuProduct   in repoinco.reinval1%type,
                           isbError     in repoinco.reinobse%type,
                           isbTipo      in repoinco.reindes1%type);
   PROCEDURE proCreaCuentaCobro( inuProducto   IN   servsusc.sesunuse%type,
                                 inuContrato   IN   servsusc.sesususc%type,
                                 inufactura    IN   factura.factcodi%type,
                                 onuCuenta     OUT  cuencobr.cucocodi%type,
                                 onuError      OUT  NUMBER,
                                 osbError      OUT  VARCHAR2);
   /**************************************************************************
     Proceso     : proCreaCuentaCobro
     Autor       : Luis Javier Lopez Barrios / Horbath
     Fecha       : 2022-11-22
     Ticket      : OSF-688
     Descripcion : generar cuenta de cobro

    Parametros Entrada
     inuProducto   codigo del producto
     inuContrato   codigo del contrato
     inufactura    codigo de la factura
    Parametros de salida
     onuCuenta   cuenta de cobro
     onuerror  codigo de error 0 - exito -1 error
     osbError  mensaje de error
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

   PROCEDURE proCreaFactura( inuContrato   IN   servsusc.sesususc%type,
                             onuFactura    OUT  factura.factcodi%type,
                             onuError      OUT  NUMBER,
                             osbError      OUT  VARCHAR2
                             );
   /**************************************************************************
     Proceso     : proCreaFactura
     Autor       : Luis Javier Lopez Barrios / Horbath
     Fecha       : 2022-11-22
     Ticket      : OSF-688
     Descripcion : generar factura

    Parametros Entrada
     inuContrato   codigo del contrato
    Parametros de salida
     onuFactura   factura
     onuerror  codigo de error 0 - exito -1 error
     osbError  mensaje de error
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  PROCEDURE  prGeneraAbonDiferido (inuContrato   IN   servsusc.sesususc%type,
                                   onuError      OUT  NUMBER,
                                   osbError      OUT  VARCHAR2);
  /**************************************************************************
     Proceso     : prGeneraAbonDiferido
     Autor       : Luis Javier Lopez Barrios / Horbath
     Fecha       : 2022-11-22
     Ticket      : OSF-688
     Descripcion : generar abono a diferido

    Parametros Entrada
     inuContrato   codigo del contrato
    Parametros de salida
     onuerror  codigo de error 0 - exito -1 error
     osbError  mensaje de error
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/



  PROCEDURE prTrasladoDifeCorriente ( inuDiferido   IN diferido.difecodi%type,
                                      inuValorTrasl IN  diferido.DIFEVATD%type,
                                      inucuenta     IN  cargos.cargcuco%type,
                                      inuperifact    IN  cargos.cargpefa%type,
                                      onuError      OUT  NUMBER,
                                      osbError      OUT  VARCHAR2);
   /**************************************************************************
     Proceso     : prTrasladoDifeCorriente
     Autor       : Luis Javier Lopez Barrios / Horbath
     Fecha       : 2022-11-22
     Ticket      : OSF-688
     Descripcion : traslado de diferido a corriente

    Parametros Entrada
     inuDiferido   codigo del diferido
     inuValorTrasl  valor a trasladar
     inucuenta      cuenta de cobro donde se generara los cargos
     inuperifact    periodo de facturacion
    Parametros de salida
     onuerror  codigo de error 0 - exito -1 error
     osbError  mensaje de error
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

END LDC_PKGESTIONABONDECONS;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_PKGESTIONABONDECONS IS

   TYPE tytbNumber  IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;

   PROCEDURE prInicializacionError (onuError      OUT  NUMBER,
                                    osbError      OUT  VARCHAR2) IS
   /**************************************************************************
     Proceso     : prInicializacionError
     Autor       : Luis Javier Lopez Barrios / Horbath
     Fecha       : 2022-11-22
     Ticket      : OSF-688
     Descripcion : inicializacion de error

    Parametros Entrada

    Parametros de salida
     onuerror  codigo de error 0 - exito -1 error
     osbError  mensaje de error
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
   BEGIN
      onuError := 0;
      osbError := null;
   END prInicializacionError;

   FUNCTION fnuCrReportHeader return number IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    -- Variables
    rcRecord Reportes%rowtype;
  BEGIN
    --{
    -- Fill record
    rcRecord.REPOAPLI := 'PLAN_PILO';
    rcRecord.REPOFECH := sysdate;
    rcRecord.REPOUSER := ut_session.getTerminal;
    rcRecord.REPODESC := 'INCONSISTENCIAS PROCESO DE PLAN PILOTO ABONO A DIFERIDO';
    rcRecord.REPOSTEJ := null;
    rcRecord.REPONUME := seq.getnext('SQ_REPORTES');

    -- Insert record
    pktblReportes.insRecord(rcRecord);
    commit;
    return rcRecord.Reponume;
    --}
  END;

  PROCEDURE crReportDetail(inuIdReporte in repoinco.reinrepo%type,
                           inuProduct   in repoinco.reinval1%type,
                           isbError     in repoinco.reinobse%type,
                           isbTipo      in repoinco.reindes1%type) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    -- Variables
    rcRepoinco repoinco%rowtype;
  BEGIN
    --{
    rcRepoinco.reinrepo := inuIdReporte;
    rcRepoinco.reinval1 := inuProduct;
    rcRepoinco.reindes1 := isbTipo;
    rcRepoinco.reinobse := isbError;
    rcRepoinco.reincodi := nuConsecutivo;

    -- Insert record
    pktblRepoinco.insrecord(rcRepoinco);
    COMMIT;
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      null;
    WHEN OTHERS THEN
      Pkg_Error.setError;
      null;
  END;

   PROCEDURE prCreaMoviDife ( inuDiferido           in movidife.modidife%type,
                              inuSubscriptionId     in movidife.modisusc%type,
                              inuProducto           in movidife.modinuse%type,
                              inuCuotaPagar         in movidife.modicuap%type,
                              inuValor              in movidife.modivacu%type,
                              isbSignoDife          in  movidife.modisign%type,
                              isbPrograma           in diferido.difeprog%type,
                              onuError              out number,
                              osberror              out varchar2) IS

      rcMoviDife movidife%rowtype;


    BEGIN
      prInicializacionError(onuError,osbError );

      rcMoviDife.modidife := inuDiferido;
      rcMoviDife.modisusc := inuSubscriptionId;
      rcMoviDife.modisign := isbSignoDife;
      rcMoviDife.modifeca := SYSDATE;
      rcMoviDife.modicuap := inuCuotaPagar;
      rcMoviDife.modivacu := inuValor;
      rcMoviDife.modidoso := 'Ca'||inuDiferido;
      rcMoviDife.modicaca := 20;
      rcMoviDife.modifech := SYSDATE;
      rcMoviDife.modiusua := USER;
      rcMoviDife.moditerm := USERENV('TERMINAL');
      rcMoviDife.modiprog := isbPrograma;
      rcMoviDife.modinuse := inuProducto;
      rcMoviDife.modidiin := pkBillConst.CERO;
      rcMoviDife.modipoin := pkBillConst.CERO;
      rcMoviDife.modivain := pkBillConst.CERO;

      -- Adiciona movimiento diferido
      pktblMoviDife.InsRecord(rcMoviDife);

    EXCEPTION

      when LOGIN_DENIED or pkConstante.exERROR_LEVEL2 or
           pkg_error.CONTROLLED_ERROR then
        raise;

      when OTHERS then
        Pkg_Error.setError;
        raise pkg_error.CONTROLLED_ERROR;        --}
    END prCreaMoviDife;

   PROCEDURE proCreaCuentaCobro( inuProducto   IN   servsusc.sesunuse%type,
                                 inuContrato   IN   servsusc.sesususc%type,
                                 inufactura    IN   factura.factcodi%type,
                                 onuCuenta     OUT  cuencobr.cucocodi%type,
                                 onuError      OUT  NUMBER,
                                 osbError      OUT  VARCHAR2 ) IS
  /**************************************************************************
     Proceso     : proCreaCuentaCobro
     Autor       : Luis Javier Lopez Barrios / Horbath
     Fecha       : 2022-11-22
     Ticket      : OSF-688
     Descripcion : generar cuenta de cobro

    Parametros Entrada
     inuProducto   codigo del producto
     inuContrato   codigo del contrato
     inufactura    codigo de la factura
    Parametros de salida
     onuCuenta   cuenta de cobro
     onuerror  codigo de error 0 - exito -1 error
     osbError  mensaje de error
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
    rcContrato                              suscripc%ROWTYPE;
    rcProducto                              servsusc%ROWTYPE;


  BEGIN
     prInicializacionError(onuError,osbError );

    --Se obtiene el record del contrato
    rcContrato := pktblSuscripc.frcGetRecord(inuContrato);

    -- Se obtiene el consecutivo de la cuenta de cobro
    pkAccountMgr.GetNewAccountNum(onuCuenta);

    -- Se obtienen el record del producto
    rcProducto := pktblservsusc.frcgetrecord(inuProducto);

    -- Crea una nueva cuenta de cobro
    pkAccountMgr.AddNewRecord(inufactura, onuCuenta, rcProducto);

  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_error.geterror(onuError, osberror);
    WHEN OTHERS THEN
        Pkg_Error.setError;
        pkg_error.geterror(onuError, osberror);
  END proCreaCuentaCobro;

   PROCEDURE proCreaFactura( inuContrato   IN   servsusc.sesususc%type,
                             onuFactura    OUT  factura.factcodi%type,
                             onuError      OUT  NUMBER,
                             osbError      OUT  VARCHAR2 ) IS
  /**************************************************************************
     Proceso     : proCreaFactura
     Autor       : Luis Javier Lopez Barrios / Horbath
     Fecha       : 2022-11-22
     Ticket      : OSF-688
     Descripcion : generar factura

    Parametros Entrada
     inuContrato   codigo del contrato
    Parametros de salida
     onuFactura   factura
     onuerror  codigo de error 0 - exito -1 error
     osbError  mensaje de error
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
    rcContrato                              suscripc%ROWTYPE;

    nuCliente      suscripc.suscclie%type; -- se almacena cliente
    nuSistema      NUMBER;

    nuTipoComp     factura.factcons%type;
    nufiscal       FACTURA.factnufi%TYPE;
    nuTipoComprobante NUMBER;

    sbPrefijo       FACTURA.factpref%TYPE;
    nuConsFisca     FACTURA.factconf%TYPE;

    --se consulta tipo de comprobante de la factura
    CURSOR cuTipoComp IS
    SELECT factcons
    FROM factura
    WHERE factcodi = onuFactura;

    -- se obtiene cliente del constrato
    CURSOR cuGetCliente IS
    SELECT suscclie
    FROM suscripc
    WHERE susccodi = inuContrato;

    -- se codigo del sistema
    CURSOR cuGetSistema IS
    SELECT SISTCODI
    FROM sistema;

  BEGIN
     prInicializacionError(onuError,osbError );

    --Se obtiene el record del contrato
    rcContrato := pktblSuscripc.frcGetRecord(inuContrato);

    -- Se obtiene numero de factura
    pkAccountStatusMgr.GetNewAccoStatusNum(onuFactura);

     -- Se crea la nueva factura
    pkAccountStatusMgr.AddNewRecord(onuFactura,
                                    6,
                                    rcContrato,
                                    GE_BOconstants.fnuGetDocTypeCons);
    --se actualiza numero fiscal
    OPEN cuGetCliente;
    FETCH cuGetCliente INTO nuCliente;
    CLOSE cuGetCliente;

    OPEN cuGetSistema;
    FETCH cuGetSistema INTO nuSistema;
    CLOSE cuGetSistema;

    OPEN cuTipoComp;
    FETCH cuTipoComp INTO nuTipoComp;
    CLOSE cuTipoComp;

    pkConsecutiveMgr.GetFiscalNumber(pkConsecutiveMgr.gcsbTOKENFACTURA,
                                     onuFactura,
                                     null,
                                     nuTipoComp,
                                     nuCliente,
                                     nuSistema,
                                     nufiscal,
                                     sbPrefijo,
                                     nuConsFisca,
                                     nuTipoComprobante);
    -- Se actualiza la factura
    pktblFactura.UpFiscalNumber(onuFactura,
                                nufiscal,
                                nuTipoComp,
                                nuConsFisca,
                                sbPrefijo);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_error.geterror(onuError, osberror);
    WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.geterror(onuError, osberror);
  END proCreaFactura;

  PROCEDURE prActualizaDife ( inuDiferido    IN diferido.difecodi%type,
                              inuValorTrasl  IN  diferido.DIFEVATD%type,
                              iblActuaNucupa  IN  BOOLEAN,
                              onuError      OUT  NUMBER,
                              osbError      OUT  VARCHAR2) IS

  BEGIN
      prInicializacionError(onuError,osbError );

      IF iblActuaNucupa THEN
          UPDATE diferido
              set difesape =  difesape -  inuValorTrasl,
                  difecupa = difenucu,
                  difefumo = sysdate
          WHERE difecodi = inuDiferido;
      ELSE
         UPDATE diferido
            set difesape =  difesape -  inuValorTrasl,
                 difefumo = sysdate
         WHERE difecodi = inuDiferido;
      END IF;

  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_error.geterror(onuError, osberror);
    WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.geterror(onuError, osberror);
  END prActualizaDife;
  PROCEDURE prTrasladoDifeCorriente ( inuDiferido   IN diferido.difecodi%type,
                                      inuValorTrasl IN  diferido.DIFEVATD%type,
                                      inucuenta     IN  cargos.cargcuco%type,
                                      inuperifact   IN  cargos.cargpefa%type,
                                      onuError      OUT  NUMBER,
                                      osbError      OUT  VARCHAR2) IS
    /**************************************************************************
     Proceso     : prTrasladoDifeCorriente
     Autor       : Luis Javier Lopez Barrios / Horbath
     Fecha       : 2022-11-22
     Ticket      : OSF-688
     Descripcion : traslado de diferido a corriente

    Parametros Entrada
     inuDiferido   codigo del diferido
     inuValorTrasl  valor a trasladar
     inucuenta      cuenta de cobro donde se generara los cargos
     inuperifact    periodo de facturacion
    Parametros de salida
     onuerror  codigo de error 0 - exito -1 error
     osbError  mensaje de error
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    02/08/2023  diana.montes OSF-1246: se modifica los parametros que retorna el api
    01/08/2023  diana.montes OSF-1246: se modifica llamado a los paquetes del esquema adm_person.
    13/07/2023  diana.montes OSF-1246: Se realiza un ajuste para que se creen los
                             cargos DB y las notas, se elimina el parametro de entrada inuNota.
    25/05/2023  diana.montes OSF-1116: Se realiza un ajuste para que se creen los
                             cargos DB asociados a la nota.
  ***************************************************************************/

     CURSOR cuGetExistePeri IS
     SELECT 'X'
     FROM perifact
     WHERE pefacodi = inuperifact;

      CURSOR cuGetExisteCuenta IS
     SELECT 'X'
     FROM cuencobr
     WHERE cucocodi = inucuenta;

     CURSOR cuExisteDife IS
     SELECT *
     FROM diferido
     WHERE difecodi = inuDiferido;

     regDiferido  cuExisteDife%rowtype;
     blActualNucu   BOOLEAN := FALSE;
     sbexiste VARCHAR2(1);
     rcNota           pkg_bcnotasrecord.tyrcNota;
     tbCargos         pkg_bcnotasrecord.tytbCargos;
     nuNota           notas.notanume%type;

   BEGIN
      ut_trace.Trace('Inicia LDC_PKGESTIONABONDECONS.prTrasladoDifeCorriente',10);
      prInicializacionError(onuError,osbError );
      IF cuExisteDife%ISOPEN THEN
         CLOSE cuExisteDife;
      END IF;

      IF cuGetExistePeri%ISOPEN THEN
         CLOSE cuGetExistePeri;
      END IF;

      IF cuGetExisteCuenta%ISOPEN THEN
         CLOSE cuGetExisteCuenta;
      END IF;


      IF inuValorTrasl <=0 THEN
         onuError := -1;
         osbError := 'El valor ingresado  ['||inuValorTrasl||'] debe ser mayor a cero';
          return;
      END IF;

      OPEN cuExisteDife;
      FETCH cuExisteDife INTO regDiferido;
      IF cuExisteDife%NOTFOUND THEN
         onuError := -1;
         osbError := 'El diferido ['||inuDiferido||'] no existe';
         CLOSE cuExisteDife;
         return;
      END IF;
      CLOSE cuExisteDife;

      IF regDiferido.difesape < inuValorTrasl THEN
         onuError := -1;
         osbError := 'El valor ingresado  ['||inuValorTrasl||'] no puede ser mayor al saldo del diferido ['|| regDiferido.difesape||']';
         return;
      END IF;

      OPEN cuGetExisteCuenta;
      FETCH cuGetExisteCuenta INTO sbexiste;
      IF cuGetExisteCuenta%NOTFOUND THEN
         onuError := -1;
         osbError := 'Cuenta de cobro ['||inucuenta||'] no existe';
         CLOSE cuGetExisteCuenta;
         return;
      END IF;
      CLOSE cuGetExisteCuenta;

      OPEN cuGetExistePeri;
      FETCH cuGetExistePeri INTO sbexiste;
      IF cuGetExistePeri%NOTFOUND THEN
         onuError := -1;
         osbError := 'Periodo de facturacion ['||inuperifact||'] no existe';
         CLOSE cuGetExistePeri;
         return;
      END IF;
      CLOSE cuGetExistePeri;


      IF regDiferido.difesape = inuValorTrasl THEN
         blActualNucu := true;
      END IF;

      prActualizaDife ( inuDiferido,
                        inuValorTrasl,
                        blActualNucu,
                        onuError,
                        osbError );

      IF onuError <> 0 THEN
         RETURN;
      END IF;

      prCreaMoviDife ( inuDiferido,
                       regDiferido.difesusc,
                       regDiferido.difenuse,
                       regDiferido.difecupa + 1,
                       inuValorTrasl,
                       'CR',
                       'CUSTOMER',
                        onuError,
                        osberror );
      IF onuError <> 0 THEN
         RETURN;
      END IF;
      --  CREA NOTA
        rcNota.sbPrograma:='CUSTOMER';
        rcNota.nuProducto :=regDiferido.difenuse;
        rcNota.nuCuencobr:=inucuenta;
        rcNota.nuNotacons:=70;
        rcNota.dtNotafeco:= trunc(SYSDATE);
        rcNota.sbNotaobse:= 'GENERACION DE NOTA POR PROCESO DE ABONO A DEUDA SEGUN CONSUMO';
        rcNota.sbNotaToken:= 'ND-';
        tbCargos(1).nuProducto := regDiferido.difenuse;
        tbCargos(1).nuContrato :=regDiferido.difesusc;
        tbCargos(1).nuCuencobr :=inucuenta;
        tbCargos(1).nuConcepto:=regDiferido.difeconc;
        tbCargos(1).NuCausaCargo:=20;
        tbCargos(1).nuValor:=inuValorTrasl;
        tbCargos(1).nuValorBase:=null;
   	    tbCargos(1).sbSigno :='DB';
        tbCargos(1).sbAjustaCuenta :='Y';
        tbCargos(1).sbCargdoso :='DF-'||inuDiferido;
       	tbCargos(1).sbBalancePostivo:= 'N';
      	tbCargos(1).boApruebaBal :=FALSE;
        ut_trace.Trace('Llamado api_registranotaydetalle',10);
        api_registranotaydetalle(    rcNota,
                            tbCargos,
                            nuNota,
                            onuerror,
                            osberror    ) ;

        ut_trace.Trace('onuerror '||onuerror||' - '||osberror,1);
        ut_trace.Trace('Fin LDC_PKGESTIONABONDECONS.prTrasladoDifeCorriente',10);
       EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(onuError, osberror);
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(onuError, osberror);
   END;

  PROCEDURE  prGeneraAbonDiferido (inuContrato   IN   servsusc.sesususc%type,
                                   onuError      OUT  NUMBER,
                                   osbError      OUT  VARCHAR2) IS
  /**************************************************************************
     Proceso     : prGeneraAbonDiferido
     Autor       : Luis Javier Lopez Barrios / Horbath
     Fecha       : 2022-11-22
     Ticket      : OSF-688
     Descripcion : generar abono a diferido

    Parametros Entrada
     inuContrato   codigo del contrato
    Parametros de salida
     onuerror  codigo de error 0 - exito -1 error
     osbError  mensaje de error
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    13/07/2023  diana.montes OSF-1246: se pasa la creacion de la nota al metodo
                             prTrasladoDifeCorriente.
    25/05/2023  diana.montes OSF-1116: se realiza la creacion de la nota, tan
                             pronto se realiza la creacion de la cuenta de cobro
                             y se envia el numero de la nota en la creacion de
                             cargos realizada en prTrasladoDifeCorriente.
  ***************************************************************************/
   nuPerioActual perifact.pefacodi%type;
   dtFechaFin    perifact.pefaffmo%type;
   nuFactura    factura.factcodi%type;
   nuparano     number;
   nuparmes     number;
   nutsess      number;
   nuCantDif    number := 0;
   sbparuser    varchar2(4000);

   nuValorAmort   NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_VALOR_AMORTIZA', NULL);
   nPorcAmort     NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_PORCENT_AMORTIZA_CONS', NULL);
   nuValorTran    NUMBER := 0;
   nuValorProc    NUMBER  := 0;
   nuProducto     NUMBER;
   nuprodAnte     NUMBER := -1;
   nuGeneraCuenta NUMBER := 0;
   nuciclo        NUMBER;
   nucuentaCobro  NUMBER;
   nuCuentCobr    cuencobr.cucocodi%type:=null;

   tblProduProc tytbNumber;
   tblCuentaProd tytbNumber;


   CURSOR cugetCicloCont IS
   SELECT susccicl
   FROM   suscripc
   WHERE susccodi = inuContrato;


   CURSOR cugetPerioActual IS
   SELECT pefacodi, pefaffmo
   FROM perifact
   WHERE pefacicl = nuciclo
      AND pefaactu = 'S';

    CURSOR cuGetFacturaActual IS
    SELECT factcodi
    FROM factura
    WHERE factpefa = nuPerioActual
     AND factsusc = inuContrato
     AND factprog = 6;


    CURSOR cuCantDiferido IS
    SELECT count(1)
    FROM diferido
    WHERE difesusc = inuContrato
     AND NVL(DIFEENRE,'N') = 'N'
     AND difesape > 0;

     CURSOR cugetDiferido IS
    SELECT difecodi, difesape, difenuse
    FROM diferido
    WHERE difesusc = inuContrato
     AND NVL(DIFEENRE,'N') = 'N'
     AND difesape > 0
    ORDER BY difefein, difecodi ;

    CURSOR getCuentaCobro(inuproducto NUMBER) IS
    SELECT CUCOCODI
    FROM CUENCOBR
    WHERE cuconuse = inuproducto
     AND cucofact = nuFactura;

    CURSOR cugetConsumos IS
    SELECT NVL(SUM(NVL(CONSUMO,0)),0)
    FROM (
          SELECT sum(decode(cargsign, 'DB', cargvalo, -cargvalo)) CONSUMO
          FROM cargos, cuencobr
          WHERE cucofact = nuFactura
             AND cargcuco = cucocodi
             AND cargconc in (31, 196)
             AND cargcaca = 15
             AND cargprog = 5
             AND cargdoso NOT LIKE '%-PR%'
          UNION ALL
          SELECT sum(decode(cargsign, 'DB', cargvalo, -cargvalo))
          FROM cargos, cuencobr
          WHERE cucofact = nuFactura
             AND cargcuco = cucocodi
             AND cargconc in (130, 167)
             AND cargpefa = nuPerioActual
             AND cargpeco = ( SELECT MAX(c1.cargpeco)
                              FROM cargos c1
                              WHERE c1.cargconc = 31
                               AND c1.cargcuco = cucocodi
                               AND C1.cargcaca = 15
                               AND C1.cargprog = 5
                               AND C1.cargdoso NOT LIKE '%-PR%'));



  BEGIN
    ut_trace.Trace('Inicia LDC_PKGESTIONABONDECONS.prGeneraAbonDiferido',10);
     prInicializacionError(onuError,osbError );
      -- Consultamos datos para inicializar el proceso
    SELECT to_number(TO_CHAR(SYSDATE,'YYYY')) ,
      to_number(TO_CHAR(SYSDATE,'MM')) ,
      userenv('SESSIONID') ,
      USER
    INTO nuparano,
      nuparmes,
      nutsess,
      sbparuser
    FROM dual;
    -- Inicializamos el proceso
    ldc_proinsertaestaprog(nuparano,nuparmes,'PRGENERAABONDIFERIDO','En ejecucion',nutsess,sbparuser);
    tblProduProc.DELETE;
    tblCuentaProd.DELETE;


    IF nuValorAmort IS NULL THEN
        onuError := -1;
       osberror := 'Parametro LDC_VALOR_AMORTIZA no esta definido';
       Pkg_Error.SetErrorMessage(2741, osberror);
       raise pkg_error.CONTROLLED_ERROR;
    END IF;

    IF nPorcAmort IS NULL THEN
        onuError := -1;
       osberror := 'Parametro LDC_PORCENT_AMORTIZA_CONS no esta definido';
       Pkg_Error.SetErrorMessage(2741, osberror);
       raise pkg_error.CONTROLLED_ERROR;
    END IF;



    IF cugetPerioActual%ISOPEN THEN
       CLOSE cugetPerioActual;
    END IF;

    IF cuGetFacturaActual%ISOPEN THEN
       CLOSE cuGetFacturaActual;
    END IF;

    IF cuCantDiferido%ISOPEN THEN
       CLOSE cuCantDiferido;
    END IF;

    IF cugetCicloCont%isopen THEN
       CLOSE cugetCicloCont;
    END IF;

    OPEN cugetCicloCont;
    FETCH cugetCicloCont INTO nuciclo;
    IF cugetCicloCont%NOTFOUND THEN
       CLOSE cugetCicloCont;
       onuError := -1;
       osberror := 'Contrato ['||inuContrato||'] no existe, por favor valide.';
       Pkg_Error.SetErrorMessage(2741, osberror);
       raise pkg_error.CONTROLLED_ERROR;
    END IF;
    CLOSE cugetCicloCont;


    OPEN cugetPerioActual;
    FETCH cugetPerioActual INTO nuPerioActual, dtFechaFin;
    IF cugetPerioActual%NOTFOUND THEN
       CLOSE cugetPerioActual;
       onuError := -1;
       osberror := 'Contrato ['||inuContrato||'] no tiene periodo de facturacion actual';
       Pkg_Error.SetErrorMessage(2741, osberror);
       raise pkg_error.CONTROLLED_ERROR;
    END IF;
    CLOSE cugetPerioActual;


    IF dtFechaFin < SYSDATE THEN
       onuError := -1;
       osberror := 'La fecha final de movimiento del periodo ['||nuPerioActual||'] no puede ser menor a la fecha del sistema';
       Pkg_Error.SetErrorMessage(2741, osberror);
       raise pkg_error.CONTROLLED_ERROR;
    END IF;
    OPEN cuCantDiferido;
    FETCH cuCantDiferido INTO nuCantDif;
    CLOSE cuCantDiferido;

    IF nuCantDif > 0 THEN

        OPEN cuGetFacturaActual;
        FETCH cuGetFacturaActual INTO nuFactura;
        CLOSE cuGetFacturaActual;

        IF nuFactura IS NULL THEN
           proCreaFactura( inuContrato,
                           nuFactura,
                           onuError,
                           osbError );
           IF onuError <> 0 THEN
              Pkg_Error.SetErrorMessage(2741, osberror);
              raise pkg_error.CONTROLLED_ERROR;
           END IF;
           nuGeneraCuenta := 1;
           nuValorTran := nuValorAmort;
        ELSE
           IF cugetConsumos%ISOPEN THEN
              CLOSE cugetConsumos;
           END IF;

           OPEN cugetConsumos;
           FETCH cugetConsumos INTO nuValorTran;
           CLOSE cugetConsumos;

           IF nuValorTran = 0 then
              nuValorTran := nuValorAmort;
           ELSE
              nuValorTran := ROUND(nuValorTran * (nPorcAmort/100),0);
           END IF;

        END IF;

        FOR reg IN cugetDiferido LOOP

            nucuentaCobro := NULL;
            onuError :=  0;
            IF getCuentaCobro%ISOPEN THEN
               CLOSE getCuentaCobro;
            END IF;


            IF NVL(nuValorTran, 0 ) > 0 THEN

                IF  NOT tblProduProc.exists(reg.difenuse) THEN
                   OPEN getCuentaCobro(reg.difenuse);
                        FETCH getCuentaCobro INTO  nucuentaCobro;
                   CLOSE getCuentaCobro;

                    nuCuentCobr:=nucuentaCobro;

                   IF nucuentaCobro IS NULL  THEN
                       proCreaCuentaCobro( reg.difenuse,
                                           inuContrato,
                                           nuFactura,
                                           nucuentaCobro,
                                           onuError,
                                           osbError);


                      IF onuError <> 0 THEN
                         EXIT;
                      END IF;

                  END IF;

                  tblCuentaProd(reg.difenuse) := nucuentaCobro;
                  tblProduProc(reg.difenuse) := reg.difenuse;

                ELSE
                   nucuentaCobro := tblCuentaProd(reg.difenuse);
                END IF;


                IF nuValorTran > reg.difesape THEN
                    nuValorTran := nuValorTran - reg.difesape;
                    nuValorProc := reg.difesape;
                ELSE
                    nuValorProc :=nuValorTran;
                    nuValorTran := 0;
                END IF;

                --se realiza proceso de traslado dpmh crea cargo
                 prTrasladoDifeCorriente ( reg.difecodi,
                                           nuValorProc,
                                           nucuentaCobro,
                                           nuPerioActual,
                                           onuError,
                                           osbError);

                IF onuError <> 0 THEN
                   EXIT;
                END IF;
             ELSE
               exit;
             END IF;
        END LOOP;
    ELSE
       onuError := -1;
       osberror := 'Contrato ['||inuContrato||'] no tiene diferidos pendientes';
        Pkg_Error.SetErrorMessage(2741, osberror);
       raise Pkg_Error.CONTROLLED_ERROR;
    END IF;


    ldc_proactualizaestaprog(nutsess,osbError,'PRGENERAABONDIFERIDO','OK');
    ut_trace.Trace('Fin LDC_PKGESTIONABONDECONS.prGeneraAbonDiferido',10);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_error.geterror(onuError, osberror);
        ldc_proactualizaestaprog(nutsess,osbError,'PRGENERAABONDIFERIDO','Error');
    WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.geterror(onuError, osberror);
        ldc_proactualizaestaprog(nutsess,osbError,'PRGENERAABONDIFERIDO','Error');
  END prGeneraAbonDiferido;
END LDC_PKGESTIONABONDECONS;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_PKGESTIONABONDECONS
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKGESTIONABONDECONS', 'ADM_PERSON'); 
END;
/