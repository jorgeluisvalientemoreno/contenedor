CREATE OR REPLACE package ADM_PERSON.LDC_CODEUDORES AS
  /***********************************************************************************
  Propiedad intelectual de PETI.
  Unidad         : ldc_codeudores
  Descripcion    : Paquete que contiene todos los metodos que usa el esquema de codeudores
  Autor          : Llozada
  Fecha          : 29/09/2014

  Historia de Modificaciones
  Fecha             Autor                Modificacion
  =========     ===================      ===============================================
  30-10-2015    KCienfuegos.ARA8825      Se modifica metodo <<blValidQuotaCosigner>>
                                         Se crea metodo <<fsbAplicaEntrega>>
  03-03-2015    KCienfuegos.NC4826       Se modifica metodo <<blValidQuotaCosigner>>
  03-03-2016    Jorval/SampacCSC100-9793 Se modifica metodo <<blValidateCodeudor>>
  ***********************************************************************************/

  /***********************************************************************************
  Propiedad intelectual de PETI.
  Unidad         : fnuCodeudorExist
  Descripcion    : Funcion que retorna el codido de la tabla ldc_codeudores, si ya existe un
                   codeudor asociado a la solicitud.
  Autor          : Llozada
  Fecha          : 29/09/2014

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========     ===================   ===============================================
  29-09-2014    Llozada               Creacion.
  ***********************************************************************************/
  FUNCTION fnuCodeudorExist(inuPackageId mo_packages.package_id%type)
    RETURN number;

  /***********************************************************************************
  Propiedad intelectual de PETI.
  Unidad         : blValidateCodeudor
  Descripcion    : Procedimiento que valida que si el codeudor puede ser usado como
                   codeudor solidario.
  Autor          : Llozada
  Fecha          : 29/09/2014

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========     ===================   ===============================================
  03-10-2014    Llozada               Creacion.
  ***********************************************************************************/
  PROCEDURE blValidateCodeudor(isbIdentification ldc_codeudor.iden_codeudor%type,
                               inuIdentType      ldc_codeudor.iden_type_codeudor%type,
                               oblResult         OUT boolean);

  /***********************************************************************************
  Propiedad intelectual de PETI.
  Unidad         : fnuValidateCodeudor
  Descripcion    : Funcion que valida que si el codeudor puede ser usado como
                   codeudor solidario.
  Autor          : Llozada
  Fecha          : 29/09/2014

  Valores que retorna:      0   Indica que No se puede usar el cliente como codeudor
                            1   Indica que el codeudor es valido.

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========     ===================   ===============================================
  03-10-2014    Llozada               Creacion.
  ***********************************************************************************/
  PROCEDURE blValidateCodeudor(isbIdentification ldc_codeudor.iden_codeudor%type,
                               inuIdentType      ldc_codeudor.iden_type_codeudor%type,
                               isbIdenDeudor     ldc_codeudor.ident_deudor%type,
                               inuIdenTypeDeudor ldc_codeudor.ident_type_deudor%type,
                               isbTrasladoCupo   varchar2,
                               oblResult         OUT boolean,
                               isbholder_bill    ld_promissory.holder_bill%type default 'Z');

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : RegisterDeudorData
  Descripcion    : Registra los datos de un Codeudor y Deudor.

  Autor          : Llozada
  Fecha          : 04/10/2014

  Parametros                Descripcion
  ============              ===================
  inuIdentTypeCodeudor      Tipo de Identificacion del Codeudor
  inuIdentification         Identificacion Codeudor
  isbFlagDeudorSolidario    Flag Deudor Solidario
  inuPackageId              Solicitud de Venta
  inuIdentTypeDeudor        Tipo de Identificacion del Deudor
  inuIdentificationDeudor   Identificacion del Deudor

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========   =========               ====================
    04-10-2014  Llozada RQ 1218         Creacion
    23/02/2016    SAMUEL PACHECO        CA 100-9793: Se adiciono validaion para identificar si el CODEUDOR
                                                   tiene o no cupo de BRILLA ADEMAS SE ADICIONAN CONTROL
                                                   PARA ACTIVAS O NO LAS VALIDACIONES QUE SE TIENEN EN CUENTA
                                                   AL MOMENTO DE IDENTIFICAR EL CODEUDOR. SE ADICIONA CAMPO PARA
                                                   IDENTIFICAR SI ES TITULAR DE LA FACTURA

  ******************************************************************/
  PROCEDURE RegisterCosignerData(inuIdentTypeCodeudor ldc_codeudor.iden_type_codeudor%type,
                                 inuIdentCodeudor     ldc_codeudor.iden_codeudor%type,
                                 isbFlagDeudorSol     ldc_codeudor.codeudor_solidario%type,
                                 inuPackageId         ldc_codeudor.package_id%type,
                                 inuIdentTypeDeudor   ldc_codeudor.ident_type_deudor%type,
                                 inuIdenDeudor        ldc_codeudor.ident_deudor%type);

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : blValidQuotaCosigner
  Descripcion    : Valida si elk codeudor tiene cupo para respaldar la deuda

  Autor          : Llozada
  Fecha          : 05/10/2014

  Parametros                Descripcion
  ============              ===================
  inuIdentTypeCodeudor      Tipo de Identificacion del Codeudor
  inuIdentification         Identificacion Codeudor
  inuTotalVenta             Valor total de la venta
  oblResult                 True si puede respaldar la deuda, False si no.

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========   =========               ====================
    05-10-2014  Llozada RQ 1218         Creacion
  ******************************************************************/
  PROCEDURE blValidQuotaCosigner(inuIdentTypeCodeudor ldc_codeudor.iden_type_codeudor%type,
                                 inuIdentCodeudor     ldc_codeudor.iden_codeudor%type,
                                 inuTotalVenta        number,
                                 oblResult            OUT boolean);

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : blValidNoCosigner
  Descripcion    : Valida si hay una configuracion para codeudor No requerido
                   en LDC_CLISINCODE.

  Autor          : Llozada
  Fecha          : 06/10/2014

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========   =========               ====================
    06-10-2014  Llozada RQ 1218         Creacion
  ******************************************************************/
  PROCEDURE blValidNoCosigner(inuIdentTypeDeudor ldc_codeudor.ident_type_deudor%type,
                              inuIdenDeudor      ldc_codeudor.ident_deudor%type,
                              inuContrato        ldc_codeudor.contrato%type,
                              oblResult          OUT boolean);

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : blQuotaContract
  Descripcion    : Valida si el contrato que llega tiene cupo

  Autor          : Llozada
  Fecha          : 05/11/2014

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========   =========               ====================
    05-11-2014  Llozada RQ 1218         Creacion
  ******************************************************************/
  procedure blQuotaContract(inuSubscriptionId suscripc.susccodi%type,
                            oblResult         OUT boolean);

end LDC_CODEUDORES;
/
CREATE OR REPLACE package body ADM_PERSON.LDC_CODEUDORES AS
  /***********************************************************************************
  Propiedad intelectual de PETI.
  Unidad         : ldc_codeudores
  Descripcion    : Paquete que contiene todos los metodos que usa el esquema de codeudores
  Autor          : Llozada
  Fecha          : 29/09/2014

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========     ===================   ===============================================
  30-10-2015    KCienfuegos.ARA8825   Se modifica metodo <<blValidQuotaCosigner>>
                                      Se crea metodo <<fsbAplicaEntrega>>
  03-03-2015    KCienfuegos.NC4826    Se modifica metodo <<blValidQuotaCosigner>>
  ***********************************************************************************/

  csbContratosCliente   CONSTANT varchar2(100) := 'FNB_CONTRATOS_CLIENTE';
  csbCantidadCliente    CONSTANT varchar2(100) := 'FNB_CANTIDAD_CLIENTES';
  csbEstadosSol         CONSTANT varchar2(100) := 'FNB_ESTADOS_SOL';
  csbEstadoSolAnulacion CONSTANT varchar2(100) := 'FNB_ESTADOSOL_ANULACION';
  csbDuenoPredio        CONSTANT varchar2(100) := 'FNB_DUENO_PREDIO_CODEUDOR';
  csbNombreEntrega8825  CONSTANT varchar2(100) := 'FNB_BR_KCM_ARA_8825';

  /***********************************************************************************
  Propiedad intelectual de PETI.
  Unidad         : fnuCodeudorExist
  Descripcion    : Funcion que retorna el codido de la tabla ldc_codeudores, si ya existe un
                   codeudor asociado a la solicitud.
  Autor          : Llozada
  Fecha          : 29/09/2014

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========     ===================   ===============================================
  29-09-2014    Llozada               Creacion.
  ***********************************************************************************/
  FUNCTION fnuCodeudorExist(inuPackageId mo_packages.package_id%type)
    RETURN number IS
    nuCodigo ldc_codeudor.codigo%type;

    CURSOR cuCodeudorExists IS
      SELECT codigo FROM ldc_codeudor where package_id = inuPackageId;
  BEGIN

    OPEN cuCodeudorExists;
    FETCH cuCodeudorExists
      INTO nuCodigo;
    CLOSE cuCodeudorExists;

    IF nuCodigo IS NOT NULL THEN
      RETURN nuCodigo;
    END IF;

    RETURN 0;
  END fnuCodeudorExist;

  /***********************************************************************************
  Propiedad intelectual de PETI.
  Unidad         : fnuValidateCodeudor
  Descripcion    : Funcion que valida que el cliente pueda ser usado como codeudor
                   de acuerdo a la configuracion de los parametros FNB_CANTIDAD_CLIENTES
                   y FNB_CONTRATOS_CLIENTE
  Autor          : Llozada
  Fecha          : 29/09/2014

  Valores que retorna:      0   Indica que el Cliente ha superado el minimo de contratos
                            1   Indica que el codeudor ha superado el numero de clientes
                            2   Indica que el codeudor es valido

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========     ===================   ===============================================
  29-09-2014    Llozada               Creacion.
  23/02/2016    samuel pacheco        CA 100-9793: Se adiciono validaion para identificar si el CODEUDOR
                                                   tiene o no cupo de BRILLA ADEMAS SE ADICIONAN CONTROL
                                                   PARA ACTIVAS O NO LAS VALIDACIONES QUE SE TIENEN EN CUENTA
                                                   AL MOMENTO DE IDENTIFICAR EL CODEUDOR. SE ADICIONA PARAMETRO
                                                   PARA IDENTIFICAR SI ES TITULAR DE LA FACTUA
  ***********************************************************************************/
  PROCEDURE blValidateCodeudor(isbIdentification ldc_codeudor.iden_codeudor%type,
                               inuIdentType      ldc_codeudor.iden_type_codeudor%type,
                               isbIdenDeudor     ldc_codeudor.ident_deudor%type,
                               inuIdenTypeDeudor ldc_codeudor.ident_type_deudor%type,
                               isbTrasladoCupo   varchar2,
                               oblResult         OUT boolean,
                               isbholder_bill    ld_promissory.holder_bill%type default 'Z') IS
    nuCantClientes  number(10);
    nuCantContratos number(10);
    nuCantCliPara   number(10) := dald_parameter.fnuGetNumeric_Value(csbCantidadCliente);
    nuCantContPara  number(10) := dald_parameter.fnuGetNumeric_Value(csbContratosCliente);
    nuSaldoSol      number(15) := 0;
    nuCliente       ge_subscriber.subscriber_id%type;
    nuEstadoSol     mo_packages.motive_status_id%type;
    nuSolAnulacion  mo_packages.package_id%type;
    sbHashCodeudor  varchar2(1000);
    sbHashDeudor    varchar2(1000);
    sbFlagDeudorSol ldc_codeudor.CODEUDOR_SOLIDARIO%type;
    i               number;
    sbCargdoso      cargos.cargdoso%type;
    blExisteCliente boolean := false;
    sbMismoCliente  varchar2(1);
    ------------
    cnuProdType CONSTANT pr_product.product_type_id%TYPE := Dald_parameter.fnuGetNumeric_Value('COD_TIPO_SERV',
                                                                                               0);
    frfGeSubs    dage_subscriber.tyRefCursor;
    rcrecord     dage_subscriber.styGE_subscriber;
    boExistId    BOOLEAN := FALSE;
    boIsActive   BOOLEAN := FALSE;
    tbResSusc    ld_bcnonbankfinancing.tytbsuscripc;
    nuSuscIndex  PLS_INTEGER;
    nuCumulQuota NUMBER := 0;
    nuQuotaValue ld_quota_by_subsc.quota_value%TYPE;

    nuacudi      NUMBER := 0;
    vextvb       NUMBER := 0;
    -----------

    type rcCodigos IS record(
      codigo ldc_codeudor.codigo%type);
    type tyrcCodigos is table of rcCodigos index by binary_integer;
    tbCodigos tyrcCodigos;

    --Clientes asociados al codeudor
    CURSOR cuClientes IS
      SELECT *
        FROM ldc_codeudor
       WHERE iden_codeudor = isbIdentification
         and iden_type_codeudor = inuIdentType;

    CURSOR cuDeudorSolidario IS
      SELECT ldc_codeudor.codeudor_solidario
        FROM ldc_codeudor
       WHERE iden_codeudor = isbIdentification
         and iden_type_codeudor = inuIdentType;

    -- Cursor que retorna la cantidad de clientes por Codeudor.
    CURSOR cuCantidadClientes IS
      select count(1)
        from (SELECT distinct IDEN_CODEUDOR,
                              iden_type_codeudor,
                              ident_deudor,
                              ident_type_deudor
                FROM ldc_codeudor
               where iden_codeudor = isbIdentification
                 and iden_type_codeudor = inuIdentType);

    --Cursor que retorna la cantidad de contratos por cliente
    CURSOR cuCantidadContratos IS
      SELECT count(1)
        FROM ldc_codeudor
       where ldc_codeudor.iden_codeudor = isbIdentification
         and ldc_codeudor.iden_type_codeudor = inuIdentType
         and ldc_codeudor.ident_deudor = isbIdenDeudor
         and ldc_codeudor.ident_type_deudor = inuIdenTypeDeudor
       group by IDEN_CODEUDOR,
                iden_type_codeudor,
                ident_deudor,
                ident_type_deudor;

    /*Llozada [RQ 1172]: Cursor que trae los estados de la solicitud configurados en FNB_ESTADOS_SOL*/
    CURSOR cuEstadosSolVenta IS
      SELECT column_value
        FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbGetValue_Chain(csbEstadosSol),
                                                ','));

    --Llozada [NC 2253]: Obtiene la solicitud de anulacion
    cursor cuSolAnulacion(nuSol ld_return_item.package_id%type) IS
      select package_id
        from ld_return_item
       where package_sale = nuSol
         and transaction_type = 'A';

    --Obtiene el diferido a partir de la solicitud
    Cursor cuDiferido(inuPackageId or_order_activity.package_id%type) IS
      select d.difecodi
        FROM diferido d, ld_item_work_order wo
       WHERE --d.difesape > 0
       wo.difecodi = d.difecodi
       AND EXISTS
       (SELECT 1
          FROM or_order_activity o
         WHERE o.order_id = wo.order_id
           AND o.order_activity_id = wo.order_activity_id
           AND o.package_id = inuPackageId
           AND o.activity_id =
               dald_parameter.fnuGetNumeric_Value('ACT_TYPE_DEL_FNB'));

    --Cuentas de cobro asociadas al diferido que NO han sido pagadas
    Cursor cuCuentasCobro(sbDife cargos.cargdoso%type) IS
      select cucocodi, cucosacu
        from cargos, cuencobr
       where cargdoso = sbDife
         and cargcuco = cucocodi
       order by cucofeve desc;

    --CA 100-9793
    --Variables
    onuAssignedQuote NUMBER;
    onuUsedQuote     NUMBER;
    onuAvalibleQuote NUMBER;
    nuQuote          NUMBER;
    --

  BEGIN
    /*
    ut_trace.init;
    ut_trace.setlevel(99);
    */

    ut_trace.trace('--PASO 1. ANTES DE VALIDAR LOS CLIENTES QUE YA PAGARON',
                   2);

    sbMismoCliente := 'N';

    sbHashCodeudor := inuIdentType || '-' || isbIdentification;
    sbHashDeudor   := inuIdenTypeDeudor || '-' || isbIdenDeudor;

    --Cuando es traslado de cupo a mismo cliente no valida contra los parametros
    IF sbHashCodeudor = sbHashDeudor then
      if isbTrasladoCupo = 'Y' Then
        sbMismoCliente := 'Y';
      end if;
    end if;

    --Cuando NO sea mismo cliente se valida si puede ser codeudor
    if sbMismoCliente = 'N' then
      --Se identifican que clientes que no se van a tener en cuenta en el conteo
      FOR rc in cuClientes LOOP
        nuSaldoSol  := ld_bcnonbankfinancing.fnugetsesusapebypackage(rc.package_id);
        nuEstadoSol := damo_packages.fnugetmotive_status_id(rc.package_id);

        if nuSaldoSol = 0 then
          --Se traen los diferidos asociados a la solicitud
          for rcDiferidos in cuDiferido(rc.package_id) loop
            sbCargdoso := 'DF-' || rcDiferidos.difecodi;

            --Se traen las cuentas de cobro asociadas al diferido
            for rcCuentas in cuCuentasCobro(sbCargdoso) loop
              if nvl(rcCuentas.cucosacu, 0) > 0 then
                nuSaldoSol := rcCuentas.cucosacu;
                exit;
              end if;
            end loop;

            if nuSaldoSol > 0 then
              exit;
            end if;
          end loop;
        end if;

        /*Se validan el estado de la solicitud con los configurados en el
        parametro FNB_ESTADOS_SOL, el cual tiene los estados en proceso de
        gestion sin diferidos asociados de la solicitud*/
        for rc2 in cuEstadosSolVenta Loop
          if nuEstadoSol = to_number(rc2.column_value) then
            nuSaldoSol := -1;
            exit;
          end if;
        end loop;

        /*se valida que la solicitud haya sido anulada*/
        open cuSolAnulacion(rc.package_id);
        fetch cuSolAnulacion
          into nuSolAnulacion;
        close cuSolAnulacion;

        /*Si la solicitud de venta ha sido anulada y esta anulacion se encuentra atendida,
        no se tiene en cuenta en el conteo*/
        if nuSolAnulacion is not null then
          if damo_packages.fnugetmotive_status_id(nuSolAnulacion) =
             Dald_parameter.fnuGetNumeric_Value(csbEstadoSolAnulacion) then
            nuSaldoSol := 0;
          end if;
        end if;

        /*Si el saldo es CERO, se marca la solicitud para no tenerla en cuenta en el conteo*/
        IF nuSaldoSol = 0 THEN
          tbCodigos(rc.codigo).codigo := rc.codigo;
        END IF;

      --

      END LOOP;

      --CA 100-9793 si tiene activo la validacion de cupo codeudor
      IF (Dald_parameter.fsbGetValue_Chain('ACT_CUPO_CODEUDOR') = 'Y') THEN
        -----------------------------

        if isbholder_bill = 'N' then
          -- Call the function (Obtiene cliente por la identificacion del codeudor)
          frfGeSubs := dage_subscriber.frfGetRecords(' Ident_Type_Id=' ||
                                                     inuIdentType ||
                                                     ' AND identification =' ||
                                                     chr(39) ||
                                                     isbIdentification ||
                                                     chr(39));

          --recorre los cliente
          LOOP
            FETCH frfGeSubs
              INTO rcrecord;
            EXIT WHEN frfGeSubs%NOTFOUND;

            boExistId := TRUE;

            -- Call the function (Obtiene suscripciones activos gas por cliente)
            tbResSusc   := ld_bcnonbankfinancing.fnugetsuscperclientprodtype(rcrecord.subscriber_id,
                                                                             cnuProdType);
            nuSuscIndex := tbResSusc.FIRST;

            WHILE nuSuscIndex IS NOT NULL LOOP
              boIsActive := TRUE;

              --valida si posee diferido con algun servicio brilla
              Select count(*)
                into vextvb
                from diferido
               where difenuse in
                     (select sesunuse
                        from servsusc
                       where sesuserv in
                             (Select numeric_value
                                from ld_parameter
                               where parameter_id in
                                     ('COD_PRODUCT_TYPE_BRILLA',
                                      'COD_PRODUCT_TYPE_BRILLA_PROM')))
                 and difesusc = tbResSusc(nuSuscIndex);
              --contador para identificar numero de diferidos de brilla
              nuacudi := nuacudi + NVL(vextvb, 0);
              --CA 100-9793
              --validar si tiene cupo disponible
              LD_BONONBANKFINANCING.subscriptionQuotaData(tbResSusc(nuSuscIndex),
                                                          onuAssignedQuote,
                                                          onuUsedQuote,
                                                          onuAvalibleQuote);
              if onuAvalibleQuote <= 0 then
                nuQuote := 0;
              else
                nuQuote := onuAvalibleQuote;
              end if;

              --acumula cupo por contrato
              nuCumulQuota := nuCumulQuota + NVL(nuQuote, 0);

              nuSuscIndex := tbResSusc.NEXT(nuSuscIndex);
            END LOOP;
          END LOOP;

          CLOSE frfGeSubs;

          IF NOT boExistId or not boIsActive THEN
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                             'El codeudor no existe en la tabla de suscriptores de productos y servicios');
          END IF;

          IF NVL(nuCumulQuota, 0) = 0 and NVL(nuacudi, 0) = 0 THEN
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                             'El codeudor actualmente no tiene cupo disponible.');
            oblResult := false;
          END IF;

          ut_trace.trace('Fin nuCumulQuota ' || nuCumulQuota, 5);

        end if;
      END IF;
      --

      ut_trace.trace('--PASO 2. DESPUES DE VALIDAR LOS CLIENTES QUE YA PAGARON tbCodigos.count: ' ||
                     tbCodigos.count,
                     2);

      if tbCodigos.count > 0 THEN
        --Se eliminan los clientes que ya pagaron
        --FOR i IN tbCodigos.first .. tbCodigos.last LOOP
        i := tbCodigos.first;
        LOOP
          delete from ldc_codeudor where codigo = tbCodigos(i).codigo;

          ut_trace.trace('--PASO 3.11 tbCodigos(i).codigo: ' ||
                         tbCodigos(i).codigo,
                         2);
          EXIT WHEN i = tbCodigos.LAST();

          i := tbCodigos.next(i);
        END LOOP;
      end if;

      ut_trace.trace('--PASO 3. SE ELIMINAN LOS CLIENTES QUE YA PAGARON',
                     2);
      --CA 100-9793 VALIDA SI ESTA ACTIVO ESTA VALIDACION PARA EL PROCESO
      IF (Dald_parameter.fsbGetValue_Chain('ACT_DEUDOR_SOLIDARIO') = 'Y') THEN
        open cuDeudorSolidario;
        fetch cuDeudorSolidario
          into sbFlagDeudorSol;
        close cuDeudorSolidario;

        IF sbFlagDeudorSol is not null THEN
          if sbFlagDeudorSol = 'Y' Then
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                             'El codeudor actualmente esta siendo utilizado como DEUDOR SOLIDARIO, por ' ||
                                             'lo tanto no puede ser usado para otra financiacion.');
          end if;
        end if;
      END IF;
      --Se cuentan los contratos asociados a ese cliente
      --con el mismo codeudor
      --CA 100-9793 VALIDA SI ESTA ACTIVO ESTA VALIDACION PARA EL PROCESO
      IF (Dald_parameter.fsbGetValue_Chain('ACT_CANT_CONTRATO_FINA') = 'Y') THEN
        OPEN cuCantidadContratos;
        FETCH cuCantidadContratos
          INTO nuCantContratos;
        CLOSE cuCantidadContratos;

        ut_trace.trace('--PASO 4. CANTIDAD CONTRATOS', 2);

        --Si trae contratos, se valida la cantidad de contratos, si supera
        --el parametro, No es valido para ser codeudor retorna CERO.
        IF nuCantContratos IS NOT NULL THEN
          IF nuCantContratos >= nuCantContPara THEN
            --RETURN 0;
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                             'No puede ser codeudor ya que el cliente ha superado el numero de financiaciones permitidas, ' ||
                                             'validar el parametro FNB_CONTRATOS_CLIENTE');
          END IF;

          if nuCantContratos > 0 then
            blExisteCliente := true;
          end if;
        END IF;
      END IF;
      ut_trace.trace('--PASO 5. DESPUES DE VALIDAR LA CANTIDAD DE CONTRATOS',
                     2);

      --Se cuentan los clientes que aun tienen deuda activa
      --CA 100-9793 VALIDA SI ESTA ACTIVO ESTA VALIDACION PARA EL PROCESO
      IF (Dald_parameter.fsbGetValue_Chain('ACT_CANT_CODEUDORES_CLIENTE') = 'Y') THEN
        OPEN cuCantidadClientes;
        fetch cuCantidadClientes
          INTO nuCantClientes;
        CLOSE cuCantidadClientes;

        ut_trace.trace('--PASO 6. DESPUES DE CONTAR LOS CLIENTES', 2);

        --Si trae clientes y esta cantidad supera el parametro,
        --No es valido para ser codeudor retorna CERO.
        IF nuCantClientes IS NOT NULL THEN
          --Si el cliente existe y paso la validacion de contratos, entonces debe dejarlo hacer la venta,
          --pero si el cliene NO existe, entonces entra a validar si ya supero la cantidad de clientes.
          if not blExisteCliente then
            IF nuCantClientes >= nuCantCliPara THEN
              --RETURN 1;
              ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                               'No puede ser codeudor ya que se ha superado el numero de clientes permitidos, ' ||
                                               'validar el parametro FNB_CANTIDAD_CLIENTES');
            END IF;
          end if;
        END IF;
      END IF;
    end if;

    ut_trace.trace('--PASO 7. DESPUES DE VALIDAR LA CANTIDAD DE CLIENTES',
                   2);

    --Si aplica para ser codeudor, retorna TRUE
    oblResult := true;
  END blValidateCodeudor;

  /***********************************************************************************
  Propiedad intelectual de PETI.
  Unidad         : blValidateCodeudor
  Descripcion    : Procedimiento que valida que si el codeudor puede ser usado como
                   codeudor solidario.
  Autor          : Llozada
  Fecha          : 29/09/2014

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========     ===================   ===============================================
  03-10-2014    Llozada               Creacion.
  ***********************************************************************************/
  PROCEDURE blValidateCodeudor(isbIdentification ldc_codeudor.iden_codeudor%type,
                               inuIdentType      ldc_codeudor.iden_type_codeudor%type,
                               oblResult         OUT boolean) IS
    nuSaldoSol     number(15);
    nuEstadoSol    mo_packages.motive_status_id%type;
    nuSolAnulacion mo_packages.package_id%type;
    i              number;
    sbCargdoso     cargos.cargdoso%type;

    type rcCodigos IS record(
      codigo ldc_codeudor.codigo%type);
    type tyrcCodigos is table of rcCodigos index by binary_integer;
    tbCodigos  tyrcCodigos;
    tbEliminar tyrcCodigos;

    --Clientes asociados al codeudor
    CURSOR cuClientes IS
      SELECT *
        FROM ldc_codeudor
       WHERE iden_codeudor = isbIdentification
         and iden_type_codeudor = inuIdentType;

    /*Llozada [RQ 1172]: Cursor que trae los estados de la solicitud configurados en FNB_ESTADOS_SOL*/
    CURSOR cuEstadosSolVenta IS
      SELECT column_value
        FROM TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbGetValue_Chain(csbEstadosSol),
                                                ','));

    --Llozada [NC 1218]: Obtiene la solicitud de anulacion
    cursor cuSolAnulacion(nuSol ld_return_item.package_id%type) IS
      select package_id
        from ld_return_item
       where package_sale = nuSol
         and transaction_type = 'A';

    --Obtiene el diferido a partir de la solicitud
    Cursor cuDiferido(inuPackageId or_order_activity.package_id%type) IS
      select d.difecodi
        FROM diferido d, ld_item_work_order wo
       WHERE --d.difesape > 0
       wo.difecodi = d.difecodi
       AND EXISTS
       (SELECT 1
          FROM or_order_activity o
         WHERE o.order_id = wo.order_id
           AND o.order_activity_id = wo.order_activity_id
           AND o.package_id = inuPackageId
           AND o.activity_id =
               dald_parameter.fnuGetNumeric_Value('ACT_TYPE_DEL_FNB'));

    --Cuentas de cobro asociadas al diferido que NO han sido pagadas
    Cursor cuCuentasCobro(sbDife cargos.cargdoso%type) IS
      select cucocodi, cucosacu
        from cargos, cuencobr
       where cargdoso = sbDife
         and cargcuco = cucocodi
       order by cucofeve desc;

  BEGIN
    --Si aplica para ser codeudor, retorna FALSO
    oblResult := false;

    --Se identifican que clientes No han pagado la financiacion
    FOR rc in cuClientes LOOP

      nuSaldoSol  := ld_bcnonbankfinancing.fnugetsesusapebypackage(rc.package_id);
      nuEstadoSol := damo_packages.fnugetmotive_status_id(rc.package_id);

      if nuSaldoSol = 0 then
        --Se traen los diferidos asociados a la solicitud
        for rcDiferidos in cuDiferido(rc.package_id) loop
          sbCargdoso := 'DF-' || rcDiferidos.difecodi;

          --Se traen las cuentas de cobro asociadas al diferido
          for rcCuentas in cuCuentasCobro(sbCargdoso) loop
            if nvl(rcCuentas.cucosacu, 0) > 0 then
              nuSaldoSol := rcCuentas.cucosacu;
              exit;
            end if;
          end loop;

          if nuSaldoSol > 0 then
            exit;
          end if;
        end loop;
      end if;

      /*Se validan el estado de la solicitud con los configurados en el
      parametro FNB_ESTADOS_SOL, el cual tiene los estados en proceso de
      gestion sin diferidos asociados de la solicitud*/
      for rc2 in cuEstadosSolVenta Loop
        if nuEstadoSol = to_number(rc2.column_value) then
          nuSaldoSol := 1;
          exit;
        end if;
      end loop;

      /*se valida que la solicitud haya sido anulada*/
      open cuSolAnulacion(rc.package_id);
      fetch cuSolAnulacion
        into nuSolAnulacion;
      close cuSolAnulacion;

      /*Si la solicitud de venta ha sido anulada y esta anulacion se encuentra atendida,
      no se tiene en cuenta en el conteo*/
      if nuSolAnulacion is not null then
        if damo_packages.fnugetmotive_status_id(nuSolAnulacion) =
           Dald_parameter.fnuGetNumeric_Value(csbEstadoSolAnulacion) then
          nuSaldoSol := 0;
        end if;
      end if;

      IF nuSaldoSol > 0 THEN
        tbCodigos(rc.codigo).codigo := rc.codigo;
      else
        tbEliminar(rc.codigo).codigo := rc.codigo;
      END IF;
    END LOOP;

    if tbEliminar.count > 0 THEN
      --Se eliminan los clientes que ya pagaron
      --FOR i IN tbCodigos.first .. tbCodigos.last LOOP
      i := tbEliminar.first;
      LOOP
        delete from ldc_codeudor where codigo = tbEliminar(i).codigo;

        EXIT WHEN i = tbEliminar.LAST();

        i := tbEliminar.next(i);
      END LOOP;
    end if;

    IF tbCodigos.count > 0 THEN
      --Si tiene deuda activa retorn VERDADERO
      oblResult := true;
    END IF;

  END blValidateCodeudor;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : RegisterDeudorData
  Descripcion    : Registra los datos de un codeudor y deudor.

  Autor          : Llozada
  Fecha          : 04/10/2014

  Parametros                Descripcion
  ============              ===================
  inuIdentTypeCodeudor      Tipo de Identificacion del Codeudor
  inuIdentification         Identificacion Codeudor
  isbFlagDeudorSolidario    Flag Deudor Solidario
  inuPackageId              Solicitud de Venta
  inuIdentTypeDeudor        Tipo de Identificacion del Deudor
  inuIdentificationDeudor   Identificacion del Deudor

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========   =========               ====================
    04-10-2014  Llozada RQ 1218         Creacion
  ******************************************************************/
  PROCEDURE RegisterCosignerData(inuIdentTypeCodeudor ldc_codeudor.iden_type_codeudor%type,
                                 inuIdentCodeudor     ldc_codeudor.iden_codeudor%type,
                                 isbFlagDeudorSol     ldc_codeudor.codeudor_solidario%type,
                                 inuPackageId         ldc_codeudor.package_id%type,
                                 inuIdentTypeDeudor   ldc_codeudor.ident_type_deudor%type,
                                 inuIdenDeudor        ldc_codeudor.ident_deudor%type) IS
    nuContrato ldc_codeudor.contrato%type;
  BEGIN
    nuContrato := ldc_boutilities.fsbGetValorCampoTabla('MO_MOTIVE',
                                                        'PACKAGE_ID',
                                                        'SUBSCRIPTION_ID',
                                                        inuPackageId);

    INSERT INTO ldc_codeudor
      (CODIGO,
       IDEN_CODEUDOR,
       IDEN_TYPE_CODEUDOR,
       IDENT_DEUDOR,
       IDENT_TYPE_DEUDOR,
       CONTRATO,
       CODEUDOR_SOLIDARIO,
       PACKAGE_ID)
    values
      (seqldc_codeudor.nextval,
       inuIdentCodeudor,
       inuIdentTypeCodeudor,
       inuIdenDeudor,
       inuIdentTypeDeudor,
       nuContrato,
       isbFlagDeudorSol,
       inuPackageId);
  END RegisterCosignerData;

  /***********************************************************************************
  Propiedad intelectual de PETI.
  Unidad         : fsbAplicaEntrega
  Descripcion    : Funcion para validar si el desarrollo aplica para la gasera. Codigo provisto
                   por SandraMu?oz.
  Autor          : KCienfuegos
  Fecha          : 30/10/2015

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========     ===================   ===============================================
  30-10-2015    KCienfuegos.ARA8825   Creacion.
  ***********************************************************************************/
  FUNCTION fsbAplicaEntrega(isbEntrega VARCHAR2) RETURN CHAR IS

    blGDO BOOLEAN := LDC_CONFIGURACIONRQ.aplicaParaGDO(isbEntrega);

    blEFIGAS BOOLEAN := LDC_CONFIGURACIONRQ.aplicaParaEfigas(isbEntrega);

    blSURTIGAS BOOLEAN := LDC_CONFIGURACIONRQ.aplicaParaSurtigas(isbEntrega);

    blGDC BOOLEAN := LDC_CONFIGURACIONRQ.aplicaParaGDC(isbEntrega);

  BEGIN

    -- Valida si la entrega aplica para la gasera
    IF blGDO = TRUE OR blEFIGAS = TRUE OR blSURTIGAS = TRUE OR blGDC = TRUE THEN
      RETURN 'S';
    ELSE
      RETURN 'N';
    END IF;

  END;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : blValidQuotaCosigner
  Descripcion    : Valida si el codeudor tiene cupo para respaldar la deuda

  Autor          : Llozada
  Fecha          : 05/10/2014

  Parametros                Descripcion
  ============              ===================
  inuIdentTypeCodeudor      Tipo de Identificacion del Codeudor
  inuIdentification         Identificacion Codeudor
  inuTotalVenta             Valor total de la venta
  oblResult                 True si puede respaldar la deuda, False si no.

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========   =========               ====================
    30-10-2015  KCienfuegos.ARA8825     Se modifica para que no evalue si el cupo del codeudor cubre el
                                        valor de la venta, para los casos en que este configurado el desarrollo
                                        FNB_BR_KCM_ARA_8825.
    03-03-2015  KCienfuegos.NC4826      Se redondea el valor de la venta.
    05-10-2014  Llozada RQ 1218         Creacion
  ******************************************************************/
  PROCEDURE blValidQuotaCosigner(inuIdentTypeCodeudor ldc_codeudor.iden_type_codeudor%type,
                                 inuIdentCodeudor     ldc_codeudor.iden_codeudor%type,
                                 inuTotalVenta        number,
                                 oblResult            OUT boolean) IS
    cnuProdType CONSTANT pr_product.product_type_id%TYPE := Dald_parameter.fnuGetNumeric_Value('COD_TIPO_SERV',
                                                                                               0);
    frfGeSubs    dage_subscriber.tyRefCursor;
    rcrecord     dage_subscriber.styGE_subscriber;
    boExistId    BOOLEAN := FALSE;
    boIsActive   BOOLEAN := FALSE;
    tbResSusc    ld_bcnonbankfinancing.tytbsuscripc;
    nuSuscIndex  PLS_INTEGER;
    nuCumulQuota NUMBER := 0;
    nuQuotaValue ld_quota_by_subsc.quota_value%TYPE;
  BEGIN
    -- Call the function (Obtiene suscriptores por la identificacion)
    frfGeSubs := dage_subscriber.frfGetRecords(' Ident_Type_Id=' ||
                                               inuIdentTypeCodeudor ||
                                               ' AND identification =' ||
                                               chr(39) || inuIdentCodeudor ||
                                               chr(39));
    LOOP
      FETCH frfGeSubs
        INTO rcrecord;
      EXIT WHEN frfGeSubs%NOTFOUND;

      boExistId := TRUE;

      -- Call the function (Obtiene productos activos gas por cliente)
      tbResSusc   := ld_bcnonbankfinancing.fnugetsuscperclientprodtype(rcrecord.subscriber_id,
                                                                       cnuProdType);
      nuSuscIndex := tbResSusc.FIRST;

      WHILE nuSuscIndex IS NOT NULL LOOP
        boIsActive := TRUE;
        -- Call the function (Obtiene cupo actual de cada contrato)
        nuQuotaValue := ld_bcnonbankfinancing.frcgetquotaregister(tbResSusc(nuSuscIndex))
                       .quota_value; --suscripc.susccodi
        nuCumulQuota := nuCumulQuota + NVL(nuQuotaValue, 0);

        nuSuscIndex := tbResSusc.NEXT(nuSuscIndex);
      END LOOP;
    END LOOP;
    CLOSE frfGeSubs;

    IF NOT boExistId THEN
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'El codeudor no existe en la tabla de suscriptores de productos y servicios');
    END IF;

    IF NVL(nuCumulQuota, 0) = 0 THEN
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'El codeudor no posee cupo');
    END IF;

    ut_trace.trace('Fin nuCumulQuota ' || nuCumulQuota, 5);
    ut_trace.trace('Fin inuTotalVenta ' || trunc(inuTotalVenta), 5);

    IF fsbAplicaEntrega(csbNombreEntrega8825) = 'N' THEN
      IF nuCumulQuota < trunc(inuTotalVenta) THEN
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                         'El codeudor no posee cupo suficiente para respaldar la deuda');
      END IF;

    END IF;
    oblResult := true;

  END blValidQuotaCosigner;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : blValidNoCosigner
  Descripcion    : Valida si hay una configuracion para codeudor No requerido
                   en LDC_CLISINCODE.

  Autor          : Llozada
  Fecha          : 06/10/2014

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========   =========               ====================
    06-10-2014  Llozada RQ 1218         Creacion
  ******************************************************************/
  PROCEDURE blValidNoCosigner(inuIdentTypeDeudor ldc_codeudor.ident_type_deudor%type,
                              inuIdenDeudor      ldc_codeudor.ident_deudor%type,
                              inuContrato        ldc_codeudor.contrato%type,
                              oblResult          OUT boolean) IS
    nuDiasVen number := Dald_parameter.fnuGetNumeric_Value('FNB_DIAS_VEN_NOCODE');
    nuDeudor  number;
    nuCodigo  number;

    CURSOR cuNoCodeContrato(nuDiasVen number) IS
      Select codigo
        from LDC_CLISINCODE
       where tipo_identificacion = inuIdentTypeDeudor
         and identificacion = inuIdenDeudor
         and contrato = inuContrato
         and (sysdate - fecha_registro) <= nuDiasVen;

    CURSOR cuNoCodeudor(nuDiasVen number) IS
      Select codigo
        from LDC_CLISINCODE
       where tipo_identificacion = inuIdentTypeDeudor
         and identificacion = inuIdenDeudor
         and (sysdate - fecha_registro) <= nuDiasVen;
  BEGIN
    /*ut_trace.init;
     ut_trace.setlevel(99);
     ut_trace.trace('--PASO 1. CODEUDORES',2);
     ut_trace.trace('--PASO 1.1. inuIdentTypeDeudor: '||inuIdentTypeDeudor||', inuIdenDeudor: '||inuIdenDeudor,2);
    */
    oblResult := false;

    open cuNoCodeContrato(nuDiasVen);
    fetch cuNoCodeContrato
      into nuCodigo;
    close cuNoCodeContrato;

    --ut_trace.trace('--PASO 2. despues del cuSuscriptor',2);

    if nuCodigo is not null then
      oblResult := true;
    else
      --ut_trace.trace('--PASO 3. EN EL IF nuDeudor',2);
      open cuNoCodeudor(nuDiasVen);
      fetch cuNoCodeudor
        INTO nuDeudor;
      close cuNoCodeudor;

      --ut_trace.trace('--PASO 4. despues del cursor cuNoCodeudor',2);
      if nuDeudor is not null then
        ut_trace.trace('--PASO 5. en el if nuCodigo', 2);
        oblResult := true;
      end if;
    end if;
  END blValidNoCosigner;

  /*****************************************************************
  Propiedad intelectual de PETI.

  Unidad         : blQuotaContract
  Descripcion    : Valida si el contrato que llega tiene cupo

  Autor          : Llozada
  Fecha          : 05/11/2014

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    =========   =========               ====================
    05-11-2014  Llozada RQ 1218         Creacion
  ******************************************************************/
  procedure blQuotaContract(inuSubscriptionId suscripc.susccodi%type,
                            oblResult         OUT boolean) is
    nuQuotaValue ld_quota_by_subsc.quota_value%TYPE;
  begin
    nuQuotaValue := ld_bcnonbankfinancing.frcgetquotaregister(inuSubscriptionId)
                   .quota_value;

    IF NVL(nuQuotaValue, 0) = 0 THEN
      oblResult := false;
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                       'El codeudor no posee cupo');
    END IF;

    oblResult := true;
  end blQuotaContract;

end LDC_CODEUDORES;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_CODEUDORES', 'ADM_PERSON'); 
END;
/
