create or replace PACKAGE LDC_pkgestionAnulaVenta IS
/*******************************************************************************
    Fuente=Propiedad Intelectual de Gases del Caribe
    Paquete     :   LDC_pkgestionAnulaVenta
    Autor       :   
    Fecha       :   
    Descripcion :   Paquete para la gestión de anulaciones de venta
    Modificaciones  :
    Autor       Fecha       Caso        Descripcion
    jpinedc     23-04-2024  OSF-2580    prNotificar: Se cambia ldc_sendemail por pkg_Correo
*******************************************************************************/

  PROCEDURE prAnulaVentas(inusolicitud IN NUMBER,
                          onuerror OUT NUMBER,
                          osberrror OUT VARCHAR2);
  PROCEDURE prRealizarPago(inusolicitud IN NUMBER,
                           inusoliante IN NUMBER,
                           onuerror OUT NUMBER,
                           osberrror OUT VARCHAR2);

  PROCEDURE LDCPRGENANUVENTA( SBPATHFILE         IN VARCHAR2,
                             SBFILE_NAME        IN VARCHAR2);
/*****************************************************************
  Unidad         : LDCPRGENANUVENTA
  Descripcion    : proceso de anualcion de venta
  Fecha          : 25/07/2022

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  PROCEDURE prProcesapaVenta;
  PROCEDURE prRealizarTraslados( inusolicitud IN NUMBER,
                                 inusoliante IN NUMBER,
                                 nuprodpadre IN  number,
                                 onuerror OUT NUMBER,
                                 osberrror OUT VARCHAR2) ;
   PROCEDURE prJobGeneraTraslaSaldo;
   PROCEDURE prJobGeneraTraSAlProd;

  PROCEDURE prJobAplicaSaldoFav;
  /*****************************************************************
  Propiedad  Intelectual de GDC

  Autor          : Luis Javier Lopez Barrios/horbath
  Unidad         : prJobAplicaSaldoFav
  Descripcion    : proceso que aplica saldo a favor
  Fecha          : 27/09/2022

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
END LDC_pkgestionAnulaVenta;
/

create or replace PACKAGE BODY LDC_pkgestionAnulaVenta IS
  csbProgAnulaPagos      CONSTANT procesos.proccodi%TYPE := 'FGCHC';
  nuConsecutivo  NUMBER:=0;
  PROCEDURE prInicializarerror(onuerror OUT NUMBER,
                               osberrror OUT VARCHAR2) IS

  BEGIN
    onuerror := 0;
    osberrror := NULL;
  END prInicializarerror;
  PROCEDURE PRANULAPAGOVENTA( inuSolicitud IN mo_packages.package_id%type,
                              onuErrorCode OUT NUMBER,
                              osbErrorMessage OUT VARCHAR2 ) is
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: PRANULAPAGOVENTCONESP
    Descripcion:        proceso que se encarga de anular pago a constructora

    Autor    : Luis Javier Lopez barrios
    Fecha    : 25/07/2022

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    ------------------------------------
    ******************************************************************/
     nuContrato NUMBER; --se almacena corato de la solicitud


    nuCupon  CUPON.cuponume%type;
    nuCausalAnu NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_CAUSANULPAGO',NULL);

    CURSOR cuGetContrato IS
    SELECT SUBSCRIPTION_ID
    FROM open.mo_motive
    WHERE package_id = inuSolicitud;

    --se consulta cupon a pagar
    CURSOR cuCuponanular IS
    SELECT cuponume
    FROM CUPON
    WHERE CUPODOCU = TO_CHAR(inuSolicitud)
     AND cuposusc = nuContrato
     AND cupoflpa = 'S'
	   AND CUPOTIPO = 'DE';


  BEGIN
    prInicializarerror(onuErrorCode, osbErrorMessage);

    OPEN cuGetContrato;
    FETCH cuGetContrato INTO nuContrato;
    IF cuGetContrato%NOTFOUND THEN
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
              'Error no se pudo recuperar contrato de la solicitud');
    END IF;
    CLOSE cuGetContrato;

    OPEN cuCuponanular;
    FETCH cuCuponanular INTO nuCupon;
    CLOSE cuCuponanular;

    PKERRORS.SETAPPLICATION(csbProgAnulaPagos);

    IF nuCupon IS NOT NULL THEN
        rc_boannulpayments.collectingannul(inupagocupo => nuCupon,
                         isbpaancaap => nuCausalAnu,
                         isbpaanobse => 'ANULACION DE PAGO: SOLICITUD ['||inuSolicitud||']');

    END IF;


  EXCEPTION
    when ex.CONTROLLED_ERROR then
     	Errors.getError(onuErrorCode, osbErrorMessage);
   when others then
         Errors.setError;
         Errors.getError(onuErrorCode, osbErrorMessage);
  END PRANULAPAGOVENTA;

  PROCEDURE prAnulaOrden( inuOrderId          in  OR_order.order_id%type,
                          inuCausalId         in  ge_causal.causal_id%type,
                          isbComment          in  or_order_comment.order_comment%type default null,
                          inuCommentType      in  ge_comment_type.comment_type_id%type,
                          onuError            out number,
                          osbErrorMessage     out varchar2
                        ) IS
    rcOrder                daor_order.styOr_order;
    nuFailureClass         ge_causal.class_causal_id%type;
    cnuERR_8681            CONSTANT NUMBER := 8681;
    cnuERR_8571            CONSTANT NUMBER := 8571;
    cnuERR_8571            CONSTANT NUMBER := 8571;
    cnuMensOk              CONSTANT NUMBER  := 4427;
    cnuFailureClass        CONSTANT NUMBER := 2;
    cnuRevokeClass         CONSTANT NUMBER := 11;
  BEGIN
    prInicializarerror(onuError, osbErrorMessage);
    /* Obtiene registro de la orden */
    daor_order.getRecord(inuOrderId,rcOrder);
    rcOrder.Causal_id := inuCausalId;

      /* Obtiene la clasificación de la causal */
    nuFailureClass := DAGE_causal.fnugetclass_causal_id(inuCausalId);
    ut_trace.trace('Valida clase de causal: '||nuFailureClass, 15);
    if (nuFailureClass not in(cnuFailureClass,cnuRevokeClass)) then
      onuError := -1;
      osbErrorMessage := 'La clasificación de la causal no es válida para anulación';
      return;
    end if;

    if inuCommentType is null then
      onuError := -1;
      osbErrorMessage := 'El tipo de comentario no puede ser nulo';
      return;
    end if;

    /* Cancela la orden */
    ut_trace.trace('Cambia estado de la orden', 15);
    changeStatus(rcOrder,or_boconstants.cnuORDER_STAT_CANCELED,inuCommentType,nvl(isbComment,'Orden anulada'));

    /* Actualizacion de cantidad legalizada */
    ut_trace.trace('Actualizar Cantidad Legalizada', 15);
    UPDATE or_order_items t
       SET legal_item_amount =  -1,
           t.value = 0
    WHERE order_items_id in (
                              SELECT i.order_items_id
                                FROM or_order_activity a,
                                     OR_order_items    i
                               WHERE i.ORDER_id = rcOrder.order_id
                                 AND i.order_items_id = a.order_item_id
                             );

  EXCEPTION
   when ex.CONTROLLED_ERROR then
       ERRORS.GETERROR(onuError, osbErrorMessage);
   when others then
        ERRORS.SETERROR;
        ERRORS.GETERROR(onuError, osbErrorMessage);
  END prAnulaOrden;


  PROCEDURE prAnulaVentas(inusolicitud IN NUMBER,
                          onuerror OUT NUMBER,
                          osberrror OUT VARCHAR2) IS

     SBCOMMENT                VARCHAR2(4000) := 'SE ANULA POR SOLICITUD OSF-446';
    sbmensaje                VARCHAR2(4000);
    eerrorexception          EXCEPTION;
    onuErrorCode             NUMBER(18);
    osbErrorMessage          VARCHAR2(2000);
    cnuCommentType           CONSTANT NUMBER := 83;
    nuNotas                  NUMBER;
    TYPE t_array_solicitudes IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
    nuPlanId                 wf_instance.instance_id%type;
    v_array_solicitudes      t_array_solicitudes;
    numotiv                  NUMBER;
    nuprodu                  NUMBER;
    numoti2                  NUMBER;
    PACKAGE_IDvar           MO_PACKAGE_CHNG_LOG.PACKAGE_ID%type := null;
    CUST_CARE_REQUES_NUMvar MO_PACKAGE_CHNG_LOG.CUST_CARE_REQUES_NUM%type := null;
    PACKAGE_TYPE_IDvar      MO_PACKAGE_CHNG_LOG.PACKAGE_TYPE_ID%type := null;
    CURRENT_TABLE_NAMEvar   MO_PACKAGE_CHNG_LOG.CURRENT_TABLE_NAME%type := 'MO_PACKAGES';
    CURRENT_EVENT_IDvar     MO_PACKAGE_CHNG_LOG.CURRENT_EVENT_ID%type := ge_boconstants.UPDATE_;
    CURRENT_EVEN_DESCvar    MO_PACKAGE_CHNG_LOG.CURRENT_EVEN_DESC%type := 'UPDATE';
    O_MOTIVE_STATUS_IDVar   MO_PACKAGE_CHNG_LOG.o_motive_status_id%TYPE;
    nucontrato  number;
    nudireccion  NUMBER;
    nuestado  NUMBER;
    nutiposoli number;
    nuOrdeleg number;
    nupermanul number;

    -- Mo_Motive
    Cursor CuMomotive(nusol number) is
    select  m.product_id, m.SUBSCRIPTION_ID, s.ADDRESS_ID, S.MOTIVE_STATUS_ID, s.package_type_id,
            (select count(1)
              from or_order_activity oa, or_order o
              where o.order_id = oa.order_id
              and oa.package_id = s.package_id
              and o.task_type_id in (12162, 11165, 12149 , 10273 , 11144 , 12150 , 10762 )
              and o.order_status_id = 8
              and DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID(o.causal_id, null) = 1) ordeleg,
            (select count(1) from ldc_contanve where contanul = m.SUBSCRIPTION_ID ) permite_anular
    from open.mo_motive m, mo_packages s
    where m.package_id = nusol
     and m.package_id = s.package_id;

    -- Ordenes
    cursor cuOrdenes(nusol number) is
    select o.order_id, order_status_id, o.operating_unit_id
    from open.or_order o, open.or_order_activity A
    where a.order_id = o.order_id
     and a.package_id = nusol
     and o.order_status_id NOT IN (8,12);

    CURSOR cuGetComponentes IS
    select Component_Id
    from Pr_Component
    where Product_Id = nuprodu;

  BEGIN
    prInicializarerror(onuerror, osberrror);


    OPEN CuMomotive(inusolicitud);
    FETCH CuMomotive INTO  nuprodu, nucontrato, nudireccion, nuestado, nutiposoli, nuOrdeleg, nupermanul;
    CLOSE CuMomotive;

    IF nuestado <> 13 THEN
       onuerror := -1;
       osberrror :='Solicitud '||inusolicitud||' No esta registrada';
       return;
    END IF;

     IF nutiposoli <> 271 THEN
       onuerror := -1;
       osberrror :='Solicitud '||inusolicitud||' No es una venta de gas por formulario';
       return;
    END IF;

    if nuOrdeleg > 0 then
        onuerror := -1;
       osberrror :='Solicitud '||inusolicitud||' tiene ordenes legalizadas con exito';
       return;
    end if;

    IF nupermanul <= 0 THEN
       onuerror := -1;
       osberrror :='contrato de la Solicitud '||inusolicitud||' no esta configurada para anulacion por este medio';
       return;
    END IF;

     -- Se anulan las ordenes
     FOR reg in cuOrdenes(inusolicitud) LOOP
        BEGIN
          prAnulaOrden( reg.order_id,
                          3446,
                          SBCOMMENT,
                          cnuCommentType,
                          onuErrorCode,
                          osbErrorMessage
                          );

          IF onuErrorCode <> 0 THEN
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, sbmensaje);
          END IF;

        EXCEPTION
         WHEN OTHERS THEN
          sbmensaje := 'Error ldc_cancel_order : '||to_char(onuErrorCode)||' - '||osbErrorMessage||' - '||sbmensaje;
          ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, sbmensaje);
        END;
     END LOOP;

     --Cambio estado de la solicitud
     UPDATE open.mo_packages
       SET motive_status_id = dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA')
     WHERE package_id = inusolicitud;

     PACKAGE_IDvar            :=  inusolicitud;
     CUST_CARE_REQUES_NUMvar  :=  damo_packages.fsbgetcust_care_reques_num(inusolicitud,null);
     PACKAGE_TYPE_IDvar       :=  damo_packages.fnugetpackage_type_id(inusolicitud,null);
     O_MOTIVE_STATUS_IDVar    :=  DAMO_MOTIVE.FNUGETMOTIVE_STATUS_ID(MO_BCPACKAGES.FNUGETMOTIVEID(inusolicitud));

     INSERT INTO MO_PACKAGE_CHNG_LOG  (
            CURRENT_USER_ID,
            CURRENT_USER_MASK,
            CURRENT_TERMINAL,
            CURRENT_TERM_IP_ADDR,
            CURRENT_DATE,
            CURRENT_TABLE_NAME,
            CURRENT_EXEC_NAME,
            CURRENT_SESSION_ID,
            CURRENT_EVENT_ID,
            CURRENT_EVEN_DESC,
            CURRENT_PROGRAM,
            CURRENT_MODULE,
            CURRENT_CLIENT_INFO,
            CURRENT_ACTION,
            PACKAGE_CHNG_LOG_ID,
            PACKAGE_ID,
            CUST_CARE_REQUES_NUM,
            PACKAGE_TYPE_ID,
            O_MOTIVE_STATUS_ID,
            N_MOTIVE_STATUS_ID
            )
         VALUES
         (
            AU_BOSystem.getSystemUserID,
            AU_BOSystem.getSystemUserMask,
            ut_session.getTERMINAL,
            ut_session.getIP,
            ut_date.fdtSysdate,
            CURRENT_TABLE_NAMEvar,
            AU_BOSystem.getSystemProcessName,
            ut_session.getSESSIONID,
            CURRENT_EVENT_IDvar,
            CURRENT_EVEN_DESCvar,
            ut_session.getProgram||'-'||SBCOMMENT,
            ut_session.getModule,
            ut_session.GetClientInfo,
            ut_session.GetAction,
            MO_BOSEQUENCES.fnuGetSeq_MO_PACKAGE_CHNG_LOG,
            PACKAGE_IDvar,
            CUST_CARE_REQUES_NUMvar,
            PACKAGE_TYPE_IDvar,
            O_MOTIVE_STATUS_IDVar,
            dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA')
        ) ;
    --Cambio estado del motivo
    UPDATE open.mo_motive
       SET annul_date         = SYSDATE,
           status_change_date = SYSDATE,
           annul_causal_id    = ge_boparameter.fnuget('ANNUL_CAUSAL'),
           motive_status_id   = 5,
           causal_id          = 287
     WHERE package_id = inusolicitud;


     --Cambiar el estado de los componentes
     UPDATE mo_component
        set motive_status_id = 26,
            annul_causal_id    = ge_boparameter.fnuget('ANNUL_CAUSAL'),
           annul_date         = SYSDATE,
           status_change_date = SYSDATE
      WHERE package_id= inusolicitud;
     -- Se obtiene el plan de wf
     BEGIN
       nuPlanId := wf_boinstance.fnugetplanid(inusolicitud, 17);
     EXCEPTION
      WHEN OTHERS THEN
       sbmensaje := 'error wf_boinstance.fnugetplanid : '||to_char(inusolicitud)||' - '||SQLERRM;
       ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, sbmensaje);
     END;
      -- anula el plan de wf
     BEGIN
      mo_boannulment.annulwfplan(nuPlanId);
     EXCEPTION
      WHEN OTHERS THEN
       sbmensaje := 'error mo_boannulment.annulwfplan : '||to_char(nuPlanId)||' - '||SQLERRM;
       ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, sbmensaje);
     END;



    IF nuprodu IS NOT NULL THEN
       --se anula producto
       UPDATE PR_PRODUCT SET PRODUCT_STATUS_ID = 16,
                             RETIRE_DATE = SYSDATE
       WHERE PRODUCT_ID = nuprodu;

       --se anulan componentes
       FOR reg IN cuGetComponentes LOOP

          UPDATE Pr_Component SET  LAST_UPD_DATE = SYSDATE, COMPONENT_STATUS_ID = 18
          WHERE COMPONENT_ID = REG.COMPONENT_ID;

          INSERT INTO Pr_Component_Retire (COMPONENT_RETIRE_ID, COMPONENT_ID, RETIRE_TYPE_ID, RETIRE_DATE, REGISTER_DATE, INDIVIDUAL_RETIRE)
            VALUES(SEQ_PR_COMPONENT_RETIRE.NEXTVAL, REG.COMPONENT_ID, 2, to_date('31/12/4732 23:59:59', 'dd/mm/yyyy hh24:mi:ss'), sysdate, 'Y');

       END LOOP;

       update servsusc set SESUFERE = sysdate, SESUESCO = 110
       where sesunuse = nuprodu;

       UPDATE Compsesu SET CMSSESCM = 18
       WHERE CMSSSESU = nuprodu ;

    END IF;

    --anula pago
   -- PRANULAPAGOVENTA(inusolicitud, onuError, osberrror);

    IF onuError = 0 THEN
        INSERT INTO LDC_SOLIANECO(SOLICITUD, PRODUCTO, DIRECCION, FECHA_REGISTRO, USUARIO_REGISTRA,TERMINAL_REGISTRA, contrato)
          VALUES(inusolicitud, nuprodu, nudireccion, SYSDATE, USER, userenv('TERMINAL'), nucontrato);
       COMMIT;
    ELSE
       ROLLBACK;
    END IF;

  EXCEPTION
   when ex.CONTROLLED_ERROR then
       ERRORS.GETERROR(onuError, osberrror);
    WHEN OTHERS THEN
      errors.seterror;
      errors.geterror(onuerror, osberrror);
  END prAnulaVentas;

  PROCEDURE prRealizarPago(inusolicitud IN NUMBER,
                           inusoliante IN NUMBER,
                           onuerror OUT NUMBER,
                           osberrror OUT VARCHAR2) IS
    nuContrato NUMBER; --se almacena corato de la solicitud
    nuCupon  CUPON.cuponume%type;
    nuValor  CUPON.cupovalo%type;
    nuBanco pagos.pagobanc%type;
    nuSucursal  pagos.pagosuba%type;
    sbFormaPago RC_DETATRBA.DETBFOPA%TYPE;
    sbEstado  VARCHAR2(1);
    nuEstadoprod NUMBER;

    isbXmlPayment clob;

    isbXmlReference   clob ;
    osbxmlcoupons     clob;
    onuErrorCode  number;
    osbErrorMessage  varchar2(4000);
    inuRefType  NUMBER:=1;

    --se consulta cupon a pagar
    CURSOR cuCuponaPagar IS
    SELECT cuponume, cupovalo
    FROM CUPON
    WHERE CUPODOCU = TO_CHAR(inuSolicitud)
     AND cuposusc = nuContrato
     AND cupoflpa = 'N'
     AND cupovalo > 0;


    CURSOR cuGetContrato IS
    SELECT m.SUBSCRIPTION_ID, p.product_status_id
    FROM open.mo_motive m, PR_PRODUCT p
    WHERE package_id = inuSolicitud
     AND p.product_id = m.product_id;

   dtFechPago DATE;

   CURSOR cuGetValidaSol IS
   SELECT ESTADO
   from LDC_SOLIANECO
   where SOLICITUD = inusoliante;

   --se obtiene banco del pago de la constructora
    CURSOR cuGetbancoPagoCons IS
    SELECT p.pagotdco, PAGOSUBA, PAGOBANC, pagofepa
    FROM pagos p, cupon c
    WHERE p.PAGOCUPO = c.CUPONUME
      and c.CUPODOCU = to_char(inusoliante)
      and c.cupotipo = 'DE'

      and c.CUPOFLPA = 'S';

    CURSOR cugetConcilia IS
    SELECT CONCCONS
    FROM concilia
    WHERE CONCBANC = nuBanco
     AND TRUNC(CONCFEPA) >= TRUNC(dtFechPago)
     AND CONCCIAU = 'S'
     AND CONCFLPR = 'N';

     nuCuotaInicial NUMBER := 0;
     sbTerminal  VARCHAR2(100);
     nuConcilia number;

     cursor cuTipoSol(nuSol open.mo_packages.package_id%type) is
     select p.package_Type_id
     from open.mo_packages p
     where p.package_id = nuSol;

     nuTipoSol     open.mo_packages.package_type_id%type;

  BEGIN
    prInicializarerror(onuerror, osberrror);

    --Se validan que sean 271
    nuTipoSol := null;
    if cuTipoSol%isopen then
       close cuTipoSol;
    end if;
    open cuTipoSol(inusolicitud);
    fetch cuTipoSol into nuTipoSol;
    close cuTipoSol;
    if nvl(nuTipoSol,-1) != 271 then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'La solicitud '||inusolicitud||' no es una solicitud 271');
    end if;
    nuTipoSol := null;
    if cuTipoSol%isopen then
       close cuTipoSol;
    end if;
    open cuTipoSol(inusoliante);
    fetch cuTipoSol into nuTipoSol;
    close cuTipoSol;
    if nvl(nuTipoSol,-1) != 271 then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'La solicitud '||inusoliante||' no es una solicitud 271');
    end if;

    OPEN cuGetContrato;
    FETCH cuGetContrato INTO nuContrato, nuEstadoprod;
    IF cuGetContrato%NOTFOUND THEN
      CLOSE cuGetContrato;
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
            'Error no se pudo recuperar contrato de la solicitud');
    END IF;
    CLOSE cuGetContrato;

    IF nuEstadoprod <> 15 THEN
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
            'el producto de la solicitud '||inuSolicitud||' no se encuentra en estado pendiente de instalacion');
    END IF;

    OPEN cuGetValidaSol;
    FETCH cuGetValidaSol INTO sbEstado;
    IF cuGetValidaSol%NOTFOUND THEN
       CLOSE cuGetValidaSol;
       ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
            'Error la solicitud '||inusoliante||' no existe o no esta anulada por el proceso LDCPAVEN');
    END IF;
    CLOSE cuGetValidaSol;

    if sbEstado <> 'P' then
       ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
            'Error la solicitud '||inusoliante||' ya fue procesada');
    end if;


    --se carga cupon
    OPEN cuCuponaPagar;
    FETCH cuCuponaPagar INTO nuCupon, nuValor;
    CLOSE cuCuponaPagar;

	--se carga banco del pago del constructor
	open cuGetbancoPagoCons;
	fetch cuGetbancoPagoCons into sbFormaPago, nuSucursal, nuBanco, dtFechPago;
	close cuGetbancoPagoCons;

  OPEN cugetConcilia;
  FETCH cugetConcilia INTO nuConcilia;
  CLOSE cugetConcilia;
	sbTerminal := UT_SESSION.GETTERMINAL();

  IF nuConcilia IS NULL THEN
      isbXmlPayment := '<?xml version="1.0" encoding="utf-8" ?>
                                  <Informacion_Pago>
                                   <Conciliacion>
                                    <Cod_Conciliacion/>
                                    <Entidad_Conciliacion>'||nuBanco||'</Entidad_Conciliacion>
                                    <Fecha_Conciliacion>'||to_char(sysdate)||'</Fecha_Conciliacion>
                                   </Conciliacion>
                                   <Entidad_Recaudo>'||nuBanco||'</Entidad_Recaudo>
                                   <Punto_Pago>'||nuSucursal||'</Punto_Pago>
                                   <Valor_Pagado>'||nuValor||'</Valor_Pagado>
                                   <Fecha_Pago>'||to_char(dtFechPago)||'</Fecha_Pago>
                                   <No_Transaccion/>
                                   <Forma_Pago>'||sbFormaPago||'</Forma_Pago>
                                   <Clase_Documento/>
                                   <No_Documento/>
                                   <Ent_Exp_Documento/>
                                   <No_Autorizacion/>
                                   <No_Meses/>
                                   <No_Cuenta/>
                                   <Programa>OS_PAYMENT</Programa>
                                   <Terminal>'||sbTerminal||'</Terminal>
                                  </Informacion_Pago>';
  ELSE
          isbXmlPayment := '<?xml version="1.0" encoding="utf-8" ?>
                                  <Informacion_Pago>
                                   <Conciliacion>
                                    <Cod_Conciliacion>'||nuConcilia||'</Cod_Conciliacion>
                                    <Entidad_Conciliacion>'||nuBanco||'</Entidad_Conciliacion>
                                    <Fecha_Conciliacion>'||to_char(sysdate)||'</Fecha_Conciliacion>
                                   </Conciliacion>
                                   <Entidad_Recaudo>'||nuBanco||'</Entidad_Recaudo>
                                   <Punto_Pago>'||nuSucursal||'</Punto_Pago>
                                   <Valor_Pagado>'||nuValor||'</Valor_Pagado>
                                   <Fecha_Pago>'||to_char(dtFechPago)||'</Fecha_Pago>
                                   <No_Transaccion/>
                                   <Forma_Pago>'||sbFormaPago||'</Forma_Pago>
                                   <Clase_Documento/>
                                   <No_Documento/>
                                   <Ent_Exp_Documento/>
                                   <No_Autorizacion/>
                                   <No_Meses/>
                                   <No_Cuenta/>
                                   <Programa>OS_PAYMENT</Programa>
                                   <Terminal>'||sbTerminal||'</Terminal>
                                  </Informacion_Pago>';

  END IF;
	 isbXmlReference    := '<?xml version="1.0" encoding="utf-8" ?>
                                <Pago_Cupon>
                                 <Cupon>'||nuCupon||'</Cupon></Pago_Cupon>';

  --se realiza pago
  IF nuCupon is not null THEN
    OS_PAYMENTSREGISTER (inuRefType, isbXMLReference, isbXMLPayment, osbXMLCoupons, onuErrorCode, osbErrorMessagE);

    IF onuErrorCode <> 0 THEN
       ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                      osbErrorMessagE);
    ELSE
      UPDATE LDC_SOLIANECO SET ESTADO = 'T', FECHA_PROCESADO = SYSDATE,
                                USUARIO_PROCESA = USER,
                                TERMINAL_PROCESA = userenv('TERMINAL')
      WHERE SOLICITUD = inusoliante;

    END IF;

  END IF;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
        Errors.getError(onuerror, osberrror);
   when others then
        errors.seterror;
        Errors.getError(onuerror, osberrror);
  END prRealizarPago;

  PROCEDURE proCreaCuentaCobro(inuProducto      IN servsusc.sesunuse%type,
                                 inuContrato    IN servsusc.sesususc%type,
                                 onuCuenta      OUT cuencobr.cucocodi%type,
                                 onuFactura     OUT factura.factcodi%type,
                                 onuerror       OUT NUMBER,
                                 osberror       OUT VARCHAR2)
    IS
        /*****************************************************************
        Propiedad intelectual de Gases del Caribe.

        Nombre del Paquete: proCreaCuentaCobro
        Descripcion:        Metodo para crear una cuenta de cobro

        Autor    : Luis javier lopez barrios
        Fecha    : 22-08-2022

        Historia de Modificaciones

        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------

        ******************************************************************/
        nuNote                                  notas.notanume%type;

        rcContrato                              suscripc%ROWTYPE;
        rcProducto                              servsusc%ROWTYPE;
        nuCliente      suscripc.suscclie%type; -- se almacena cliente
        nuSistema      NUMBER;
        nuTipoComp     factura.factcons%type;
        nufiscal       FACTURA.factnufi%TYPE;
        nuTipoComprobante NUMBER;

        sbPrefijo       FACTURA.factpref%TYPE;
        nuConsFisca     FACTURA.factconf%TYPE;

       -- se obtiene cliente del contrato
        CURSOR cuGetCliente IS
        SELECT suscclie
        FROM suscripc
        WHERE susccodi = inuContrato;

       -- se codigo del sistema
        CURSOR cuGetSistema IS
        SELECT SISTCODI
        FROM sistema;

        --se consulta tipo de comprobante de la factura
        CURSOR cuTipoComp IS
        SELECT factcons
        FROM factura
        WHERE factcodi = onuFactura;


    BEGIN
         onuerror := 0;

         -- Se obtiene numero de factura
        pkAccountStatusMgr.GetNewAccoStatusNum(onuFactura);

        --Se obtiene el record del contrato
        rcContrato := pktblSuscripc.frcGetRecord(inuContrato);

        -- Se crea la nueva factura
        pkAccountStatusMgr.AddNewRecord(onuFactura,
                                        pkGeneralServices.fnuIDProceso,
                                        rcContrato,
                                        GE_BOconstants.fnuGetDocTypeCons);

        -- Se obtiene el consecutivo de la cuenta de cobro
        pkAccountMgr.GetNewAccountNum(onuCuenta);

        -- Se obtienen el record del producto
        rcProducto := pktblservsusc.frcgetrecord(inuProducto);

        -- Crea una nueva cuenta de cobro
        pkAccountMgr.AddNewRecord(onuFactura, onuCuenta, rcProducto);

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
        WHEN ex.CONTROLLED_ERROR THEN
            ERRORS.GETERROR(onuerror, OSBERROR);
        WHEN OTHERS THEN
            Errors.setError;
            ERRORS.GETERROR(onuerror, OSBERROR);
    END proCreaCuentaCobro;

  PROCEDURE prRealizarTraslados( inusolicitud IN NUMBER,
                                 inusoliante IN NUMBER,
                                 nuprodpadre IN  number,
                                 onuerror OUT NUMBER,
                                 osberrror OUT VARCHAR2) IS
    nuError  NUMBER;
    sbErrorMsg VARCHAR2(4000);
    tbServicioOrigen	pkTraslatePositiveBalance.tySesunuseMas;
    dtProceso DATE;
    sbUsuario VARCHAR2(4000);
    sbTerminal VARCHAR2(4000);
    nucontrato NUMBER;
    nucontraorig number;
    nuproduorig NUMBER;
    nuprodudest NUMBER;
    nusaldofavor NUMBER;

    CURSOR cugetSaldo IS
    select sesunuse, sesusafa, sesususc
    from LDC_SOLIANECO, servsusc
    where SOLICITUD = inusoliante
     and PRODUCTO= sesunuse ;

     cursor cuTipoSol(nuSol open.mo_packages.package_id%type) is
     select p.package_Type_id, motive_status_id
     from open.mo_packages p
     where p.package_id = nuSol;

    nuTipoSol     open.mo_packages.package_type_id%type;
    nuEstaSol     open.mo_packages.motive_status_id%type;
    sbEstado  VARCHAR2(1);
    nuEstadoprod NUMBER;
    nuValorTras number := dald_parameter.fnugetnumeric_value('LDC_VATRPROHI', null);
    nusaldorest number;


  CURSOR cuGetValidaSol IS
   SELECT ESTADO
   from LDC_SOLIANECO
   where SOLICITUD = inusoliante;

    CURSOR cuGetContrato IS
    SELECT m.SUBSCRIPTION_ID, p.product_status_id,  p.product_id
    FROM open.mo_motive m, PR_PRODUCT p
    WHERE package_id = inuSolicitud
     AND p.product_id = m.product_id;

     PROCEDURE prTrasladaSaldoFavor ( nuproducto IN NUMBER,
                                      nuvalortras IN NUMBER,
                                      nusaldfavor IN NUMBER,
                                      onuerrorint OUT NUMBER,
                                      osberrrorint OUT VARCHAR2) IS

       CURSOR cuGetFactura IS
       SELECT 'X'
       FROM factura, cuencobr
       WHERE factsusc = nucontrato
        and factcodi = cucofact;

      sbdatos VARCHAR2(1);
      nufactura NUMBER;
      nucuenta NUMBER;
     BEGIN
       nufactura := NULL;
       nucuenta := NULL;
       IF cuGetFactura%ISOPEN THEN
          CLOSE cuGetFactura;
       END IF;

       OPEN cuGetFactura;
       FETCH cuGetFactura INTO sbdatos;
       IF cuGetFactura%NOTFOUND THEN
          proCreaCuentaCobro(nuproducto, nucontrato, nucuenta, nufactura, onuerrorint, osberrrorint );

          IF onuerrorint <> 0 THEN
            RETURN;
          END IF;
       END IF;
       CLOSE cuGetFactura;

       dtProceso         := sysdate;
       sbUsuario         := pkGeneralServices.fsbGetUserName;
       sbTerminal        := pkGeneralServices.fsbGetTerminal;

        -- Setea datos del proceso en API de proceso individual
        pkTraslatePositiveBalance.SetBatchProcessData ( dtProceso,
                                                        sbUsuario,
                                                        sbTerminal
                                                         );

       --inicia traslado a producto destino
        tbServicioOrigen.delete;
        --dbms_output.put_line('nuproduorig '||nuproduorig||' nucontraorig '||nucontraorig||' nusaldfavor '||nusaldfavor||' nuproducto '||nuproducto);
        tbServicioOrigen(1).sesunuse := nuproduorig;
        tbServicioOrigen(1).sesususc := nucontraorig;
        tbServicioOrigen(1).sesusafa := nusaldfavor;

        pkTraslatePositiveBalance.TRANSLATEBYDEPOSIT( tbServicioOrigen,
                                                    nuproducto,
                                                    'TRASLADO DE SALDO A FAVOR POR PROCESO DE VENTA DE ECOPETROL',
                                                    onuerrorint,
                                                    osberrrorint);

     END;
  BEGIN

     prInicializarerror(onuerror, osberrror);

    --Se validan que sean 271
    nuTipoSol := null;
    nuEstaSol:=null;
    nusaldorest := 0;
    nusaldofavor := 0;
    nuproduorig := null;
    nucontrato := null;
    nuprodudest := null;

    if cuTipoSol%isopen then
       close cuTipoSol;
    end if;
    open cuTipoSol(inusolicitud);
    fetch cuTipoSol into nuTipoSol, nuEstaSol;
    close cuTipoSol;

    if nvl(nuTipoSol,-1) != 271 then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'La solicitud '||inusolicitud||' no es una solicitud 271');
    end if;

    IF nuEstaSol != 13 THEN
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'La solicitud '||inusolicitud||' no se encuentra en estado 13');
    END IF;

    nuTipoSol := null;
    nuEstaSol := null;

    if cuTipoSol%isopen then
       close cuTipoSol;
    end if;

    open cuTipoSol(inusoliante);
    fetch cuTipoSol into nuTipoSol, nuEstaSol;
    close cuTipoSol;

    if nvl(nuTipoSol,-1) != 271 then
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'La solicitud '||inusoliante||' no es una solicitud 271');
    end if;

    OPEN cuGetContrato;
    FETCH cuGetContrato INTO nuContrato, nuEstadoprod, nuprodudest;
    IF cuGetContrato%NOTFOUND THEN
      CLOSE cuGetContrato;
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
            'Error no se pudo recuperar contrato de la solicitud');
    END IF;
    CLOSE cuGetContrato;

    IF nuEstadoprod <> 15 THEN
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
            'el producto de la solicitud '||inuSolicitud||' no se encuentra en estado pendiente de instalacion');
    END IF;

    OPEN cuGetValidaSol;
    FETCH cuGetValidaSol INTO sbEstado;
    IF cuGetValidaSol%NOTFOUND THEN
       CLOSE cuGetValidaSol;
       ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
            'Error la solicitud '||inusoliante||' no existe o no esta anulada por el proceso LDCPAVEN');
    END IF;
    CLOSE cuGetValidaSol;

    if sbEstado <> 'P' then
       ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
            'Error la solicitud '||inusoliante||' ya fue procesada');
    end if;


   PKERRORS.SETAPPLICATION('FTMS');

   OPEN cugetSaldo;
   FETCH cugetSaldo INTO nuproduorig, nusaldofavor, nucontraorig;
   CLOSE cugetSaldo;

   IF nusaldofavor <= 0 THEN
     onuerror := -1;
     osberrror := 'Producto origen ['||nuproduorig||'] no tiene saldo a favor';
     return;
   END IF;

    IF nuprodpadre IS NOT NULL THEN
        IF nuValorTras > nusaldofavor THEN
           nuValorTras := nusaldofavor;
        END IF;
        nusaldorest := nusaldofavor - nuValorTras;
    ELSE
       nuValorTras := nusaldofavor;
       nusaldorest := 0;
    END IF;

    prTrasladaSaldoFavor ( nuprodudest,
                          nuValorTras,
                          nuValorTras,
                          onuerror,
                          osberrror);

    IF onuerror <> 0 THEN
       ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                      osberrror);
    ELSE
      IF nusaldorest > 0 THEN
          prTrasladaSaldoFavor ( nuprodpadre,
                                nusaldorest,
                                nusaldorest,
                                onuerror,
                                osberrror);
          IF onuerror <> 0 THEN
             ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                            osberrror);
          END IF;
      END IF;
      UPDATE LDC_SOLIANECO SET ESTADO = 'T', FECHA_PROCESADO = SYSDATE,
                                  USUARIO_PROCESA = USER,
                                  TERMINAL_PROCESA = userenv('TERMINAL')
      WHERE SOLICITUD = inusoliante;
    END IF;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
        Errors.getError(onuerror, osberrror);
   when others then
        errors.seterror;
        Errors.getError(onuerror, osberrror);
  END prRealizarTraslados;

  PROCEDURE prRealizarTrasprodu( inusolicitud IN NUMBER,
                                 inucontpadre IN NUMBER,
                                 nuprodpadre IN  number,
                                 onuerror OUT NUMBER,
                                 osberrror OUT VARCHAR2) IS
    nuError  NUMBER;
    sbErrorMsg VARCHAR2(4000);
    tbServicioOrigen	pkTraslatePositiveBalance.tySesunuseMas;
    dtProceso DATE;
    sbUsuario VARCHAR2(4000);
    sbTerminal VARCHAR2(4000);
    nucontrato NUMBER;
    nucontraorig number;
    nuproduorig NUMBER;
    nuprodudest NUMBER;
    nusaldofavor NUMBER;
    nuvalorNoti  NUMBER := DALD_PARAMETER.FNUGETNUMERIC_VALUE('LDC_VASANOTI',NULL);
    CURSOR cugetSaldo IS
    select sesunuse, sesusafa, sesususc
    from servsusc
    where sesunuse = nuprodpadre;


    nuTipoSol     open.mo_packages.package_type_id%type;
    nuEstaSol     open.mo_packages.motive_status_id%type;
    sbEstado  VARCHAR2(1);
    nuEstadoprod NUMBER;
    nuValorTras number := dald_parameter.fnugetnumeric_value('LDC_VATRPROHI', null);
    nusaldorest number;

    CURSOR cuGetContrato IS
    SELECT m.SUBSCRIPTION_ID, p.product_status_id,  p.product_id
    FROM open.mo_motive m, PR_PRODUCT p
    WHERE package_id = inuSolicitud
     AND p.product_id = m.product_id;

     PROCEDURE prTrasladaSaldoFavor ( nuproducto IN NUMBER,
                                      nuvalortras IN NUMBER,
                                      nusaldfavor IN NUMBER,
                                      onuerrorint OUT NUMBER,
                                      osberrrorint OUT VARCHAR2) IS

       CURSOR cuGetFactura IS
       SELECT 'X'
       FROM factura, cuencobr
       WHERE factsusc = nucontrato
        and factcodi = cucofact;

      sbdatos VARCHAR2(1);
      nufactura NUMBER;
      nucuenta NUMBER;
     BEGIN
       nufactura := NULL;
       nucuenta := NULL;
       IF cuGetFactura%ISOPEN THEN
          CLOSE cuGetFactura;
       END IF;

       OPEN cuGetFactura;
       FETCH cuGetFactura INTO sbdatos;
       IF cuGetFactura%NOTFOUND THEN
          proCreaCuentaCobro(nuproducto, nucontrato, nucuenta, nufactura, onuerrorint, osberrrorint );

          IF onuerrorint <> 0 THEN
            RETURN;
          END IF;
       END IF;
       CLOSE cuGetFactura;

       dtProceso         := sysdate;
       sbUsuario         := pkGeneralServices.fsbGetUserName;
       sbTerminal        := pkGeneralServices.fsbGetTerminal;

        -- Setea datos del proceso en API de proceso individual
        pkTraslatePositiveBalance.SetBatchProcessData ( dtProceso,
                                                        sbUsuario,
                                                        sbTerminal
                                                         );

       --inicia traslado a producto destino
        tbServicioOrigen.delete;
        --dbms_output.put_line('nuproduorig '||nuproduorig||' nucontraorig '||nucontraorig||' nusaldfavor '||nusaldfavor||' nuproducto '||nuproducto);
        tbServicioOrigen(1).sesunuse := nuproduorig;
        tbServicioOrigen(1).sesususc := nucontraorig;
        tbServicioOrigen(1).sesusafa := nusaldfavor;

        pkTraslatePositiveBalance.TRANSLATEBYDEPOSIT( tbServicioOrigen,
                                                    nuproducto,
                                                    'TRASLADO DE SALDO A FAVOR POR PROCESO DE VENTA DE ECOPETROL',
                                                    onuerrorint,
                                                    osberrrorint);
     EXCEPTION
        WHEN OTHERS THEN
          ERRORS.SETERROR;
          ERRORS.GETERROR(onuerrorint, osberrrorint);
     END prTrasladaSaldoFavor;

     PROCEDURE prInsertLog IS
       PRAGMA AUTONOMOUS_TRANSACTION;
     BEGIN
       INSERT INTO LDC_INFOTSPR (CONTPADRE,
                                    SOLIPRHI,
                                    PRODHIJO,
                                    VALOR_SALDO,
                                    FECHA_PROCESADO,
                                    USUARIO_PROCESA,
                                    TERMINAL_PROCESA,
                                    OBSERVACION)
              VALUES( inucontpadre,
                      inusolicitud,
                      nuprodudest,
                      nusaldorest,
                      SYSDATE,
                      USER,
                      USERENV('TERMINAL'),
                      osberrror);

         COMMIT;
     EXCEPTION
       WHEN OTHERS THEN
          ERRORS.SETERROR;
          ROLLBACK;
     END prInsertLog;

     PROCEDURE prNotificar IS
       sbEmail  VARCHAR2(400) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_EMAILNVPC',NULL);
       sbRemitente     ld_parameter.value_chain%TYPE:= pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');
     BEGIN
        pkg_Correo.prcEnviaCorreo
        (
            isbRemitente        => sbRemitente,
            isbDestinatarios    => sbEmail,
            isbAsunto           => 'Notificacion de saldos de contrato Padre (Ecopetrol)',
            isbMensaje          =>'Contrato padre ['||inucontpadre||'] solo le queda ['||nusaldorest||'] de saldo a favor'
        );
        
     EXCEPTION
       WHEN OTHERS THEN
          ERRORS.SETERROR;
     END prNotificar;
  BEGIN

     prInicializarerror(onuerror, osberrror);

    nusaldorest := 0;
    nusaldofavor := 0;
    nuproduorig := null;
    nucontrato := null;
    nuprodudest := null;
    nuEstadoprod := null;

    OPEN cugetSaldo;
   FETCH cugetSaldo INTO nuproduorig, nusaldofavor, nucontraorig;
   CLOSE cugetSaldo;

    OPEN cuGetContrato;
    FETCH cuGetContrato INTO nuContrato, nuEstadoprod, nuprodudest;
    IF cuGetContrato%NOTFOUND THEN
      CLOSE cuGetContrato;
      osberrror := 'Error no se pudo recuperar contrato de la solicitud ['||inuSolicitud||']';
      prInsertLog;
      ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
            osberrror);
    END IF;
    CLOSE cuGetContrato;

    IF nuEstadoprod <> 15 THEN
       osberrror := 'el producto de la solicitud '||inuSolicitud||' no se encuentra en estado pendiente de instalacion';
       prInsertLog;
       ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                                       osberrror );
    END IF;

   PKERRORS.SETAPPLICATION('FTMS');

   IF nusaldofavor <= 0 and nusaldofavor < nuValorTras  THEN
     onuerror := -1;
     osberrror := 'Producto origen ['||nuproduorig||'] solo tiene de saldo a favor, el valor de ['||nusaldofavor||']';
     prInsertLog;
     return;
   END IF;

    IF nuprodpadre IS NOT NULL THEN
        IF nuValorTras > nusaldofavor THEN
           nuValorTras := nusaldofavor;
        END IF;
        nusaldorest := nusaldofavor - nuValorTras;
    ELSE
       onuerror := -1;
       osberrror := 'No existe producto padre, por favor valide';
       prInsertLog;
       return;
    END IF;

    IF nuValorTras > 0 THEN
        prTrasladaSaldoFavor ( nuprodudest,
                              nuValorTras,
                              nuValorTras,
                              onuerror,
                              osberrror);

        prInsertLog;

        IF onuerror <> 0 THEN
           ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                          osberrror);
        ELSE
          IF nusaldorest <= nuvalorNoti THEN
              prNotificar;
          END IF;
        END IF;

    END IF;

  EXCEPTION
    when ex.CONTROLLED_ERROR then
        Errors.getError(onuerror, osberrror);
   when others then
        errors.seterror;
        Errors.getError(onuerror, osberrror);
  END prRealizarTrasprodu;
  PROCEDURE LDCPRGENANUVENTA( SBPATHFILE         IN VARCHAR2,
                             SBFILE_NAME        IN VARCHAR2) IS
/*****************************************************************
  Unidad         : LDCPRGENANUVENTA
  Descripcion    : proceso de anualcion de venta
  Fecha          : 25/07/2022

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  18/08/2022      LJLB                CA OSF-507 se ajusta proceso para validar que solo se anulen ventas
                                      que se encuentren en la tabla ldc_contanve
  ******************************************************************/
  SUBTYPE STYSIZELINE           IS         VARCHAR2(32000);
  FPORDERSDATA        UTL_FILE.FILE_TYPE;
  SBLINE              STYSIZELINE;
  NURECORD            NUMBER;
  FPORDERERRORS       UTL_FILE.FILE_TYPE;
  SBERRORFILE         VARCHAR2(100);
  SBERRORLINE         STYSIZELINE;
  nusolicitud          NUMBER;

  NUERRORCODE         NUMBER;
  SBERRORMESSAGE      VARCHAR2(2000);

  TBSTRING   ut_string.TYTB_STRING;
  sbSeparador VARCHAR2(1) := ';';

  CNUMAXLENGTHTOASSIG         CONSTANT  NUMBER:=32000;
  CSBFILE_SEPARATOR           CONSTANT VARCHAR2(1) := '/';

  nuparano  NUMBER;
  nuparmes  NUMBER;
  nutsess  NUMBER;
  sbparuser VARCHAR2(400);


BEGIN
    -- Consultamos datos para inicializar el proceso
    SELECT to_number(to_char(SYSDATE, 'YYYY')),
           to_number(to_char(SYSDATE, 'MM')),
           userenv('SESSIONID'),
           USER
      INTO nuparano, nuparmes, nutsess, sbparuser
      FROM dual;
    -- Inicializamos el proceso
    ldc_proinsertaestaprog(nuparano,
                           nuparmes,
                           'LDCPRGENANUVENTA',
                           'En ejecucion',
                           nutsess,
                           sbparuser);

  UT_TRACE.TRACE('[LDCPRGENANUVENTA] INICIO',3);
   pkErrors.SetApplication('CUSTOMER');


  GE_BOFILEMANAGER.CHECKFILEISEXISTING (SBPATHFILE||CSBFILE_SEPARATOR||sbFILE_NAME);
  SBERRORFILE := SUBSTR(sbFILE_NAME,1,INSTR(sbFILE_NAME,'.')-1);

  IF SBERRORFILE IS NULL THEN
     SBERRORFILE := sbFILE_NAME;
  END IF;

  SBERRORFILE := SBERRORFILE||'.err';

  GE_BOFILEMANAGER.FILEOPEN (FPORDERSDATA, SBPATHFILE, sbFILE_NAME, GE_BOFILEMANAGER.CSBREAD_OPEN_FILE, CNUMAXLENGTHTOASSIG);
  UT_FILE.FILEOPEN(FPORDERERRORS,SBPATHFILE,SBERRORFILE,'w',CNUMAXLENGTHTOASSIG);
  NURECORD := 0;
    WHILE TRUE LOOP
        GE_BOFILEMANAGER.FILEREAD (FPORDERSDATA, SBLINE);
        EXIT WHEN SBLINE IS NULL;
          nusolicitud := null;

         ut_string.EXTSTRING(SBLINE, sbSeparador , TBSTRING);
         NURECORD := NURECORD + 1;

         IF TBSTRING.COUNT <> 2 THEN
            SBERRORLINE := '['||NURECORD ||'] Error estructura del archivo no es valida';
            UT_FILE.FILEWRITE(FPORDERERRORS,SBERRORLINE);
         ELSE
           BEGIN
                nusolicitud :=  TBSTRING(1);
                prAnulaVentas(nusolicitud, NUERRORCODE, SBERRORLINE);
                if NUERRORCODE = 0 then
                   commit;
                else
                  rollback;
                  SBERRORLINE := '['||NURECORD ||'] '||SBERRORLINE;
                  UT_FILE.FILEWRITE(FPORDERERRORS,SBERRORLINE);
                  SBERRORLINE := NULL;
                  CONTINUE;
                end if;
           EXCEPTION
            WHEN OTHERS THEN
               errors.seterror;
               errors.geterror(NUERRORCODE, SBERRORLINE);
               SBERRORLINE := '['||NURECORD ||'] ERROR'||SBERRORLINE;
               UT_FILE.FILEWRITE(FPORDERERRORS,SBERRORLINE);
               SBERRORLINE := NULL;
               CONTINUE;
           END;
        END IF;
    END LOOP;


    IF UTL_FILE.IS_OPEN (FPORDERSDATA) THEN
        GE_BOFILEMANAGER.FILECLOSE (FPORDERSDATA);
    END IF;

    IF UTL_FILE.IS_OPEN (FPORDERERRORS) THEN
        GE_BOFILEMANAGER.FILECLOSE (FPORDERERRORS);
    END IF;
    COMMIT;
      ldc_proactualizaestaprog(nutsess, SBERRORMESSAGE, 'LDCPRGENANUVENTA', 'Ok');
    UT_TRACE.TRACE('[LDCPRGENANUVENTA] FIN',3);
  EXCEPTION
  WHEN EX.CONTROLLED_ERROR THEN
      ERRORS.GETERROR(NUERRORCODE, SBERRORMESSAGE);
      ROLLBACK;
      ldc_proactualizaestaprog(nutsess, SBERRORMESSAGE, 'LDCPRGENANUVENTA', 'Ok');
      RAISE EX.CONTROLLED_ERROR;

  WHEN OTHERS THEN
     ERRORS.SETERROR;
      ERRORS.GETERROR(NUERRORCODE, SBERRORMESSAGE);
       ROLLBACK;
      ldc_proactualizaestaprog(nutsess, SBERRORMESSAGE, 'LDCPRGENANUVENTA', 'Ok');
      RAISE EX.CONTROLLED_ERROR;
  END;
  PROCEDURE prJobGeneraTraslaSaldo IS
   --variabe para estaproc
    nuparano  NUMBER;
    nuparmes  NUMBER;
    nutsess   NUMBER;
    sbparuser VARCHAR2(400);

    nuerror NUMBER;
    SBERROR VARCHAR2(4000);

    CURSOR cugetVentaTrasl IS
    SELECT /*+ INDEX(M IDX_CON03SOLIANECO) */ SOLICITUD,
            PACKAGE_ID,
            (SELECT sesunuse
              FROM ldc_contanve, SERVSUSC
            WHERE contanul = contrato
             and contpadre = sesususc
             and sesuserv = 6121 ) prodpadr
    FROM LDC_SOLIANECO M, MO_PACKAGES S
    WHERE M.DIRECCION = S.ADDRESS_ID
     AND S.PACKAGE_TYPE_ID = 271
     AND S.MOTIVE_STATUS_ID = 13
     AND M.ESTADO = 'P';

  BEGIN
     -- Consultamos datos para inicializar el proceso
    SELECT to_number(to_char(SYSDATE, 'YYYY')),
           to_number(to_char(SYSDATE, 'MM')),
           userenv('SESSIONID'),
           USER
      INTO nuparano, nuparmes, nutsess, sbparuser
      FROM dual;

       pkErrors.SetApplication('CUSTOMER');
    -- Inicializamos el proceso
    ldc_proinsertaestaprog(nuparano,
                           nuparmes,
                           'PRJOBGENERATRASLASALDO',
                           'En ejecucion',
                           nutsess,
                           sbparuser);
    FOR reg IN cugetVentaTrasl LOOP
        prRealizarTraslados( reg.PACKAGE_ID,
                             reg.SOLICITUD,
                             REG.prodpadr,
                             nuerror,
                             sberror);
        IF nuerror =  0 THEN
           COMMIT;
        ELSE
           ROLLBACK;
           UPDATE LDC_SOLIANECO SET OBSERVACION = sberror
           WHERE SOLICITUD = reg.SOLICITUD;
           COMMIT;
        END IF;
    END LOOP;

    ldc_proactualizaestaprog(nutsess, SBERROR, 'PRJOBGENERATRASLASALDO', 'Ok');

  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ERRORS.geterror(nuerror, SBERROR);
      ldc_proactualizaestaprog(nutsess,
                               SBERROR,
                               'PRJOBGENERATRASLASALDO',
                               'error');

    WHEN OTHERS THEN
      ERRORS.seterror;
      ERRORS.geterror(nuerror, SBERROR);
      ldc_proactualizaestaprog(nutsess,
                               SBERROR,
                               'PRJOBGENERATRASLASALDO',
                               'error');
  END prJobGeneraTraslaSaldo;
  PROCEDURE prProcesapaVenta IS
    sbSoliciActual ge_boInstanceControl.stysbValue;
    sbsoliAnula ge_boInstanceControl.stysbValue;
    nuerror number;
    sberror varchar2(4000);
  BEGIN
     sbSoliciActual := ge_boInstanceControl.fsbGetFieldValue ('MO_MOTIVE', 'PACKAGE_ID');
     sbsoliAnula := ge_boInstanceControl.fsbGetFieldValue ('MO_PACKAGES', 'PACKAGE_ID');

     prRealizarTraslados( to_number(sbSoliciActual),
                     to_number(sbsoliAnula),
                     NULL,
                     nuerror,
                     sberror);
    IF nuerror =  0 THEN
       COMMIT;
    ELSE
       ROLLBACK;
       RAISE EX.CONTROLLED_ERROR;
    END IF;
 EXCEPTION
   WHEN EX.CONTROLLED_ERROR THEN
       RAISE EX.CONTROLLED_ERROR;

   WHEN OTHERS THEN
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;
  END prProcesapaVenta;

    PROCEDURE prJobGeneraTraSAlProd IS
   --variabe para estaproc
    nuparano  NUMBER;
    nuparmes  NUMBER;
    nutsess   NUMBER;
    sbparuser VARCHAR2(400);

    nuerror NUMBER;
    SBERROR VARCHAR2(4000);

    CURSOR cugetVentaTrasl IS
    SELECT /*+ INDEX(M IDX_CON03SOLIANECO) */   PACKAGE_ID,
            CONTPADRE contrato_padre,
            (SELECT sesunuse
              FROM  SERVSUSC
            WHERE CONTPADRE = sesususc
             and sesuserv = 6121 ) prodpadr,
             m.rowid id_reg
    FROM LDC_CONTTSFA M, MO_PACKAGES S
    WHERE M.DIREPRHI = S.ADDRESS_ID
     AND S.PACKAGE_TYPE_ID = 271
     AND S.MOTIVE_STATUS_ID = 13
     AND NVL(M.ESTADO,'N') = 'N';

  BEGIN
     -- Consultamos datos para inicializar el proceso
    SELECT to_number(to_char(SYSDATE, 'YYYY')),
           to_number(to_char(SYSDATE, 'MM')),
           userenv('SESSIONID'),
           USER
      INTO nuparano, nuparmes, nutsess, sbparuser
      FROM dual;

       pkErrors.SetApplication('CUSTOMER');
    -- Inicializamos el proceso
    ldc_proinsertaestaprog(nuparano,
                           nuparmes,
                           'PRJOBGENERATRASALPROD',
                           'En ejecucion',
                           nutsess,
                           sbparuser);
    FOR reg IN cugetVentaTrasl LOOP
        prRealizarTrasprodu( reg.PACKAGE_ID,
                             reg.contrato_padre,
                             REG.prodpadr,
                             nuerror,
                             sberror);
        IF nuerror =  0 THEN
           update LDC_CONTTSFA set ESTADO = 'S' WHERE ROWID = REG.id_reg;
            COMMIT;
        ELSE
           ROLLBACK;
        END IF;
    END LOOP;

    ldc_proactualizaestaprog(nutsess, SBERROR, 'PRJOBGENERATRASALPROD', 'Ok');

  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ERRORS.geterror(nuerror, SBERROR);
       ROLLBACK;
      ldc_proactualizaestaprog(nutsess,
                               SBERROR,
                               'PRJOBGENERATRASALPROD',
                               'error');

    WHEN OTHERS THEN
      ERRORS.seterror;
      ERRORS.geterror(nuerror, SBERROR);
       ROLLBACK;
      ldc_proactualizaestaprog(nutsess,
                               SBERROR,
                               'PRJOBGENERATRASALPROD',
                               'error');
  END prJobGeneraTraSAlProd;

  FUNCTION fnuCrReportHeader
    return number
    IS
        -- Variables
        rcRecord Reportes%rowtype;
    BEGIN
    --{
        -- Fill record
        rcRecord.REPOAPLI := 'DIFEVENT';
        rcRecord.REPOFECH := sysdate;
        rcRecord.REPOUSER := ut_session.getTerminal;
        rcRecord.REPODESC := 'INCONSISTENCIAS TRASLADO DE DIFERIDO DE VENTAS' ;
        rcRecord.REPOSTEJ := null;
        rcRecord.REPONUME :=  seq.getnext('SQ_REPORTES');

        -- Insert record
        pktblReportes.insRecord(rcRecord);

        return rcRecord.Reponume;
    --}
    END;

    PROCEDURE crReportDetail(
        inuIdReporte    in repoinco.reinrepo%type,
        inuProduct      in repoinco.reinval1%type,
        isbError        in repoinco.reinobse%type,
        isbTipo         in repoinco.reindes1%type
    )
    IS
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
        WHEN EX.CONTROLLED_ERROR THEN
            NULL;--RAISE EX.CONTROLLED_ERROR;
            ROLLBACK;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
           NULL;
    --}
    END;

  PROCEDURE prJobAplicaSaldoFav IS
  /*****************************************************************
  Propiedad  Intelectual de GDC

  Autor          : Luis Javier Lopez Barrios/horbath
  Unidad         : prJobAplicaSaldoFav
  Descripcion    : proceso que aplica saldo a favor
  Fecha          : 27/09/2022

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
   --variabe para estaproc
    nuparano  NUMBER;
    nuparmes  NUMBER;
    nutsess   NUMBER;
    sbparuser VARCHAR2(400);

    nuerror NUMBER;
    SBERROR VARCHAR2(4000);
    dtFechaRegistro  DATE;
    sbDocumento VARCHAR2(4000);
    nuSaldo  NUMBER;

    CURSOR cugetVentaTrasl IS
    WITH Direcciones AS
    (SELECT DIREPRHI    
    FROM LDC_CONTTSFA M
    WHERE  NVL(M.ESTADO,'N') = 'S'
    union all
    select DIRECCION
    from LDC_SOLIANECO
    where ESTADO = 'T')
   SELECT /*+ INDEX(M IDX_CON03SOLIANECO) */
           s.PACKAGE_ID,
           f.FINAN_ID,
           mo.product_id,
           sesusafa saldo
    FROM  Direcciones M,
          MO_PACKAGES S,
          CC_SALES_FINANC_COND F,
          mo_motive mO,
          servsusc
    WHERE M.DIREPRHI = S.ADDRESS_ID
     AND S.PACKAGE_TYPE_ID = 271
     AND S.MOTIVE_STATUS_ID = 14
     AND f.package_id = s.package_id
     AND mO.package_id = s.package_id
     AND sesunuse = mO.product_id
     AND sesusafa > 0
     AND EXISTS ( SELECT 1
                  FROM diferido
                  WHERE difecofi = FINAN_ID AND difesape > 0 );

    CURSOR cugetInfodif(inuFinanciacion IN NUMBER) IS
     SELECT d.difenudo,
            SUM(d.difesape),
            MAX(trunc(d.difefein))
      FROM   diferido d
      WHERE  d.difecofi = inuFinanciacion
      GROUP  BY d.difenudo;

      nuIdReporte NUMBER;

  BEGIN

    -- Consultamos datos para inicializar el proceso
    SELECT to_number(to_char(SYSDATE, 'YYYY')),
           to_number(to_char(SYSDATE, 'MM')),
           userenv('SESSIONID'),
           USER
      INTO nuparano, nuparmes, nutsess, sbparuser
      FROM dual;

      nuIdReporte := fnuCrReportHeader;

      pkErrors.SetApplication('CUSTOMER');
      -- Inicializamos el proceso
      ldc_proinsertaestaprog(nuparano,
                             nuparmes,
                             'PRJOBAPLICASALDOFAV',
                             'En ejecucion',
                             nutsess,
                             sbparuser);

      CC_BODEFTOCURTRANSFER.GLOBALINITIALIZE;

      FOR reg IN cugetVentaTrasl LOOP
        nuError := 0;
        sbError := NULL;
        dtFechaRegistro := NULL;
        sbDocumento := NULL;

        IF cugetInfodif%ISOPEN THEN
           CLOSE cugetInfodif;
        END IF;

        OPEN cugetInfodif(reg.FINAN_ID);
        FETCH cugetInfodif INTO sbDocumento, nuSaldo, dtFechaRegistro;
        CLOSE cugetInfodif;

        IF nuSaldo >  REG.saldo THEN
           nuSaldo := REG.saldo;
        END IF;


        CC_BODEFTOCURTRANSFER.ADDDEFERTOCOLLECTFIN(inuproductid    => reg.product_id,
                                                   inufinancingid  => reg.FINAN_ID,
                                                   idtregisterdate => dtFechaRegistro,
                                                   isbdifenudo     => sbDocumento);
        CC_BODEFTOCURTRANSFER.TRANSFERDEBT(
                                           inupayment      => nuSaldo,
                                           idtinsolv       => dtFechaRegistro,
                                           iblabono        => TRUE,
                                           isbprograma     => 'FTDU',
                                           onuerrorcode    => nuError,
                                           osberrormessage => sbError);

        IF (nuError != PKCONSTANTE.EXITO) THEN
            nuConsecutivo := nuConsecutivo +1;
				   crReportDetail(nuIdReporte,
                          nuError,
                           sbError,
                          'S' );
          ROLLBACK;
        ELSE
           COMMIT;
        END IF;
    END LOOP;
  ldc_proactualizaestaprog(nutsess, SBERROR, 'PRJOBAPLICASALDOFAV', 'Ok');

  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ERRORS.geterror(nuerror, SBERROR);
       ROLLBACK;
      ldc_proactualizaestaprog(nutsess,
                               SBERROR,
                               'PRJOBAPLICASALDOFAV',
                               'error');
       nuConsecutivo := nuConsecutivo +1;
       crReportDetail(nuIdReporte,
                          nuError,
                           sbError,
                          'S' );
    WHEN OTHERS THEN
      ERRORS.seterror;
      ERRORS.geterror(nuerror, SBERROR);
       ROLLBACK;
      ldc_proactualizaestaprog(nutsess,
                               SBERROR,
                               'PRJOBAPLICASALDOFAV',
                               'error');
      nuConsecutivo := nuConsecutivo +1;
     crReportDetail(nuIdReporte,
                    nuError,
                     sbError,
                    'S' );
  END prJobAplicaSaldoFav;
END LDC_pkgestionAnulaVenta;
/

