  CREATE OR REPLACE PACKAGE LDC_BCREGEREVIPERI is

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : LDC_BCRegeReviPeri
  Descripcion    : Se ejecuta en el tramite de 100253 "REGENERACION DE REVISION PERIODICA" atravez de la
                 accion 8215 "Atender solicitud de Regeneracion de Revision Periodica"
         Este objeto busca las ordenes de CITACION, NOTIFICACION Y SUSPENSION por incumplimiento de
         la revision periodica que esten en estado REGISTRADA o ASIGNADA.
         y realiza la siguiente logica :
         1. Si la orden que esta abierta es de CITACION o NOTIFICACION las legaliza con causal que regenera la orden de REVISION PERIODICA.
         2. Si la orden que esta abierta es de SUSPENSION y esta REGISTRADA se legaliza con causal de que regenere la
            REVISION PERIODICA.
         3. Si la orden que esta abierta es de SUSPENSION y esta ASIGNADA se debe grabar sobre esta orden un tipo de observaci?n
            que debe ser leido en el objeto de legalizacion de la orden de suspension obligando que sea legalizada con una causal
          que regenere la REVISION PERIODICA.

  Autor          : EMIRO LEYVA
  Fecha          : 30/09/2013

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============  ===================


  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================
  26/01/2018        Stapias.REQ 2001518 Se modifica metodo <<PROVALISUSPREGERP>>
  ******************************************************************/

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : PrRegeReviPeri
  Descripcion    : Procedimiento para regenera la revision periodica desde la ejecucion de un tramite
                 cuando la solicitud tiene ordenes abiertas de citacion, notificacion o de suspension en estado REGISTRADA o ASIGNADA
  Autor          : Emiro Leyva
  Fecha          : 30/09/2013

  Metodos

  Nombre         :
  Parametros         Descripcion
  ============  ===================
  inuPackage_id      Numero de la solicitud de revision periodica sobre la que se lanzo el tramite

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========         =========         ====================

  ******************************************************************/
  procedure PrRegeReviPeri(inuPackage_id    in mo_packages.package_id%type,
                           inuNewPackage_id in mo_packages.package_id%type);

  /*Funci?n que devuelve la versi?n del pkg*/
  FUNCTION fsbVersion RETURN VARCHAR2;

  procedure PROVALISUSPREGERP;
  procedure PROATIENDESUSPRP_JOB;
  PROCEDURE ProRegistraReconex;
  FUNCTION fnuValidaEntraCNCRN(inuPackage_id in mo_packages.package_id%type)
    RETURN number;

  FUNCTION fsbgetvalorcampostablaUltReg(sbnomtab  IN VARCHAR2,
                                        sbnocall1 IN VARCHAR2,
                                        sbnocade  IN VARCHAR2,
                                        sbvalval1 IN VARCHAR2,
                                        sbnocall2 IN VARCHAR2,
                                        sbvalval2 IN VARCHAR2)
    RETURN VARCHAR2;
  procedure attendpackage(inuPackage_id in mo_packages.package_id%type,
                          inuAccion     in number);
  FUNCTION fsbSuspOrderWithFail(inuPackage_id in mo_packages.package_Id%type)
    RETURN VARCHAR2;

  procedure OBJ_DeteccionbyNotifR;

end LDC_BCRegeReviPeri;
/
CREATE OR REPLACE PACKAGE BODY LDC_BCREGEREVIPERI IS

  /*Variable global*/
  CSBVERSION CONSTANT varchar2(40) := 'ARAN_3554';

  /*****************************************************************
    Propiedad intelectual de PETI (c).

      Unidad         : LDC_BCRegeReviPeri
      Descripcion    : Se ejecuta en el tramite de 100253 "REGENERACION DE REVISION PERIODICA" atravez de la
                     accion 8215 "Atender solicitud de Regeneracion de Revision Periodica"
             Este objeto busca las ordenes de CITACION, NOTIFICACION Y SUSPENSION por incumplimiento de
             la revision periodica que esten en estado REGISTRADA o ASIGNADA.
             y realiza la siguiente logica :
             1. Si la orden que esta abierta es de CITACION o NOTIFICACION las legaliza con causal que regene la orden de REVISION PERIODICA.
             2. Si la orden que esta abierta es de SUSPENSION y esta REGISTRADA se legaliza con causal que regenere la
                REVISION PERIODICA.
             3. Si la orden que esta abierta es de SUSPENSION y esta ASIGNADA se debe grabar sobre esta orden un tipo de observaci?n
                que debe ser leido en el objeto de legalizacion de la orden de suspension obligando que sea legalizada con una causal
              que regenere la REVISION PERIODICA.

    Autor          : Emiro Leyva
    Fecha          : 30/09/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    26/01/2018        Stapias.REQ 2001518 Se modifica metodo <<PROVALISUSPREGERP>>
  ******************************************************************/

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : PrRegeReviPeri
    Descripcion    : Procedimiento para regenera la revision periodica desde la ejecucion de un tramite
                     cuando la solicitud tiene ordenes abiertas de citacion, notificacion o de suspension en estado REGISTRADA o ASIGNADA
    Autor          : Emiro Leyva
    Fecha          : 30/09/2013

    Metodos

    Nombre         :   PrRegeReviPeri
    Parametros         Descripcion
    ============  ===================
    inuPackage_id      Numero de la solicitud de revision periodica sobre la que se lanzo el tramite

    Historia de Modificaciones
    Fecha             Autor                	Modificacion
    =========         =========           	====================
	26/07/2023		  jerazomvm			  	CASO OSF-1359:
											1. Se reemplaza el llamado del API os_legalizeorders
											   por el API api_legalizeorders.
											2. Se reemplaza el manejo de errores ex y errors por Pkg_error.
											3. Se reemplaza la separacion de cadena LDC_BOUTILITIES.SPLITSTRINGS por
											   SELECT to_number(regexp_substr(variable,
																'[^,]+',
																1,
																LEVEL)) AS alias
											   FROM dual
											   CONNECT BY regexp_substr(variable, '[^,]+', 1, LEVEL) IS NOT NULL
											4. Se reemplaza el API OS_RegisterRequestWithXML por el api api_registerRequestByXml
											5. Se reemplaza el API os_addordercomment por el API api_addordercomment.
    22/11/2016      bicm. ca200-889       3. Se modifica para que reersse la ultima actividad de suspension
    19/01/2015      oparra.Team3473       2. Se modifica cursor, para que consulte el listado de los TT
                                          de suspension por CM y acometida por parametro.
    30/09/2013         emirol             1. Creacion

  ******************************************************************/
  procedure PrRegeReviPeri(inuPackage_id    in mo_packages.package_id%type,
                           inuNewPackage_id in mo_packages.package_id%type) is

    nuTipoTrab           ld_parameter.numeric_value%type;
    ISBDATAORDER         varchar2(2000);
    nuCausalId           or_order.causal_id%type;
    nutipoCausal         number;
    nuCausal             number;
    nuMotiveId           MO_MOTIVE.MOTIVE_ID%TYPE;
    nuSUBSCRIBERId       ge_subscriber.SUBSCRIBER_id%type;
    nuPackageId          mo_packages.package_id%type;
    nuTaskTypeId         or_task_type.task_type_id%type;
    isbComment           varchar2(2000) := 'PROCESADA POR EL TRAMITE DE REGENERACION DE REVISION PERIODICA';
    nuTipoComment        OR_ORDER_COMMENT.COMMENT_TYPE_ID%TYPE;
    nuTipoCo             OR_ORDER_COMMENT.COMMENT_TYPE_ID%TYPE := 3;
    onuErrorCode         number;
    osbErrorMessage      varchar2(2000);
    nuClaseCausal        ge_causal.CLASS_CAUSAL_ID%type;
    nuCantActividad      or_order_activity.VALUE_REFERENCE%type;
    INUPERSONID          ge_person.person_id%type;
    nuoperatingunit      or_order.OPERATING_UNIT_ID%type;
    NUORDERPADREID       or_order.order_id%type;
    NUOPER_UNIT_PADRE    or_order.OPERATING_UNIT_ID%type;
    nuMOTIID             MO_MOTIVE.MOTIVE_ID%type;
    nuMOTIID_old         MO_MOTIVE.MOTIVE_ID%type;
    nuSUBSCRIPTIONID     OR_ORDER_ACTIVITY.SUBSCRIPTION_ID%type;
    nuPRODUCTID          OR_ORDER_ACTIVITY.PRODUCT_ID%type;
    nuaddressid          or_order_activity.address_id%TYPE;
    nuinstance_id        OR_ORDER_ACTIVITY.instance_id%type;
    nuorderactivityID    OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE;
    ionuorderid          OR_ORDER.ORDER_ID%TYPE;
    inuMotive            OR_ORDER_ACTIVITY.MOTIVE_ID%TYPE;
    inuComponent         OR_ORDER_ACTIVITY.COMPONENT_ID%TYPE;
    isbObserva           or_order_comment.order_comment%type;
    sbRequestXML1        varchar2(32767);
    nuType_suspension_id ldc_marca_producto.suspension_type_id%type;
    fecha_inicio         date;
    nuSTATUS             PR_PRODUCT.PRODUCT_STATUS_ID%TYPE;
    NUPROD_SUSPEN_ID     PR_PROD_SUSPENSION.PROD_SUSPENSION_ID%type;
    nuPackage_type_id    mo_packages.package_type_id%type;
    nuestadoorden        or_order_status.order_status_id%TYPE;
    sbvarsalida          VARCHAR2(5000);
    sbcadena             varchar2(1000);
	sbLdc_Tt_Susp_CM 	 		ld_parameter.value_chain%type :=	DALD_PARAMETER.fsbGetValue_Chain('LDC_TT_SUSP_CM', NULL);
	sbLdc_Tt_Susp_Acometida		ld_parameter.value_chain%type :=	DALD_PARAMETER.fsbGetValue_Chain('LDC_TT_SUSP_ACOMETIDA', NULL);

    --Cursor para buscar la orden asociada a la solicitud de revision periodica
    -- Team 3473 sengun los TT configurados en los parametros.
    CURSOR cuOrden(inuPackageId mo_packages.package_id%type) IS
      select b.order_id,
             b.task_type_id,
             b.order_status_id,
             a.order_activity_id,
             a.package_id
        from or_order_activity a, or_order b
       where a.order_id = b.order_id
         and (b.task_type_id in
             (SELECT to_number(regexp_substr(sbLdc_Tt_Susp_CM,
											'[^,]+',
											1,
											LEVEL)) AS LDC_TT_SUSP_CM
			  FROM dual
			  CONNECT BY regexp_substr(sbLdc_Tt_Susp_CM, '[^,]+', 1, LEVEL) IS NOT NULL)) or
             b.task_type_id in
             (SELECT to_number(regexp_substr(sbLdc_Tt_Susp_Acometida,
											'[^,]+',
											1,
											LEVEL)) AS LDC_TT_SUSP_ACOMETIDA
			  FROM dual
			  CONNECT BY regexp_substr(sbLdc_Tt_Susp_Acometida, '[^,]+', 1, LEVEL) IS NOT NULL)
         and b.order_status_id in (0, 5, 20)
         and package_id = inuPackageId
         and rownum = 1;

    rgDatos          cuOrden%rowtype;
    csbEntrega200889 varchar2(4000) := 'OSS_REV_BICM_200889_1';
    nuUltActSuspens  pr_product.suspen_ord_act_id%type;

  BEGIN
    ut_trace.trace('Inicio LDC_BCRegeReviPeri.PrRegeReviPeri inuPackage_id: '    || inuPackage_id || chr(10) ||
															'inuNewPackage_id: ' || inuNewPackage_id, 10);
    dbms_output.put_line('Inicio proceso');
    nuTipoTrab := Dald_parameter.fnuGetNumeric_Value('ID_TASKTYPE_SUSP_REVI_RP',
                                                     null);
    if nuTipoTrab is null then
      Pkg_error.SetErrorMessage(Ld_Boconstans.cnuGeneric_Error,
                                       'No existe datos para el parametro "ID_TASKTYPE_SUSP_REVI_RP", definalos por el comando LDPAR separados por coma');
      raise Pkg_error.CONTROLLED_ERROR;
    end if;

    nuTipoTrab := Dald_parameter.fnuGetNumeric_Value('ID_TASKTYPE_ACOM_REVI_RP',
                                                     null);
    if nuTipoTrab is null then
      Pkg_error.SetErrorMessage(Ld_Boconstans.cnuGeneric_Error,
                                       'No existe datos para el parametro "ID_TASKTYPE_ACOM_REVI_RP", definalos por el comando LDPAR separados por coma');
      raise Pkg_error.CONTROLLED_ERROR;
    end if;

    nuTipoComment := Dald_parameter.fnuGetNumeric_Value('ID_TYPE_COMMENT_RP',
                                                        null);
    if nuTipoComment is null then
      Pkg_error.SetErrorMessage(Ld_Boconstans.cnuGeneric_Error,
                                       'No existe datos para el parametro "ID_TYPE_COMMENT_RP", definalos por el comando LDPAR separados por coma');
      raise Pkg_error.CONTROLLED_ERROR;
    end if;
    nuCausalId := Dald_parameter.fnuGetNumeric_Value('ID_CAUSAL_SUSP_REVI_RP',
                                                     null);
    if nuCausalId is null then
      Pkg_error.SetErrorMessage(Ld_Boconstans.cnuGeneric_Error,
                                       'No existe datos para el parametro "ID_CAUSAL_SUSP_REVI_RP", definalos por el comando LDPAR separados por coma');
      raise Pkg_error.CONTROLLED_ERROR;
    end if;
    nuoperatingunit := Dald_parameter.fnuGetNumeric_Value('ID_OPER_UNIT_LEG_OT_RP',
                                                          null);
    if nuoperatingunit is null then
      Pkg_error.SetErrorMessage(Ld_Boconstans.cnuGeneric_Error,
                                       'No existe datos para el parametro "ID_OPER_UNIT_LEG_OT_RP", definalos por el comando LDPAR separados por coma');
      raise Pkg_error.CONTROLLED_ERROR;
    end if;

    nutipoCausal := Dald_parameter.fnuGetNumeric_Value('TIPO_DE_CAUSAL_SUSP_ADMI',
                                                       null);
    if nutipoCausal is null THEN
      Pkg_error.SetErrorMessage(ld_boconstans.cnugeneric_error,
                                       'No existe datos para el parametro TIPO_DE_CAUSAL_SUSP_ADMI, definalos por el comando LDPAR');
      RAISE Pkg_error.controlled_error;
    END IF;
    nuCausal := Dald_parameter.fnuGetNumeric_Value('COD_CAUSA_SUSP_ADM_XML',
                                                   null);

    if nuCausal is null THEN
      Pkg_error.SetErrorMessage(ld_boconstans.cnugeneric_error,
                                       'No existe datos para el parametro COD_CAUSA_SUSP_ADM_XML, definalos por el comando LDPAR');
      RAISE Pkg_error.controlled_error;
    END IF;

    ut_trace.trace('Finalizo validacion de parametros', 10);

    INUPERSONID       := TO_NUMBER(ldc_boutilities.fsbgetvalorcampotabla('OR_OPER_UNIT_PERSONS',
                                                                         'OPERATING_UNIT_ID',
                                                                         'PERSON_ID',
                                                                         nuoperatingunit));
    nuPackage_type_id := damo_packages.fnugetpackage_type_id(inuPackage_id);

    open cuOrden(inuPackage_id);
    fetch cuOrden
      into RgDatos;
    if cuOrden%notfound then
      close cuOrden;
      Pkg_error.SetErrorMessage(Ld_Boconstans.cnuGeneric_Error,
                                       'No existe una orden con las condiciones necesarias para ser procesada');
      raise Pkg_error.CONTROLLED_ERROR;
    end if;
    close cuOrden;

    -- COLOCA EL ID DEL PRODUCTO Y DE LA SUSCRIPCION AL NUEVO MOTIVO QUE SE CREA PARA EL TRAMITE DE REGENERACION DE REVISON PERIODICA
    nuMOTIID_old     := TO_NUMBER(ldc_boutilities.fsbgetvalorcampotabla('MO_MOTIVE',
                                                                        'PACKAGE_ID',
                                                                        'MOTIVE_ID',
                                                                        inuPackage_id));
    nuSUBSCRIPTIONID := TO_NUMBER(ldc_boutilities.fsbgetvalorcampotabla('MO_MOTIVE',
                                                                        'MOTIVE_ID',
                                                                        'SUBSCRIPTION_ID',
                                                                        nuMOTIID_old));
    nuPRODUCTID      := TO_NUMBER(ldc_boutilities.fsbgetvalorcampotabla('MO_MOTIVE',
                                                                        'MOTIVE_ID',
                                                                        'PRODUCT_ID',
                                                                        nuMOTIID_old));
    nuMOTIID         := TO_NUMBER(ldc_boutilities.fsbgetvalorcampotabla('MO_MOTIVE',
                                                                        'PACKAGE_ID',
                                                                        'MOTIVE_ID',
                                                                        inuNewPackage_id));
    DAMO_MOTIVE.UPDSUBSCRIPTION_ID(nuMOTIID, nuSUBSCRIPTIONID);
    DAMO_MOTIVE.UPDPRODUCT_ID(nuMOTIID, nuPRODUCTID);
    -- BUSCA LA OBSERVACION DEL NUEVO TRAMITE
    isbObserva    := ldc_boutilities.fsbgetvalorcampotabla('MO_PACKAGES',
                                                           'PACKAGE_ID',
                                                           'COMMENT_',
                                                           inuNewPackage_id);
    nuestadoorden := RgDatos.ORDER_STATUS_ID;
    if RgDatos.ORDER_STATUS_ID = 5 then

		ut_trace.trace('Ingresa api_addordercomment order_id: '			|| RgDatos.order_id || chr(10) ||
												   'nuTipoComment: '	|| nuTipoComment 	|| chr(10) ||
												   'isbComment: '		|| isbComment, 12);

		  api_addordercomment(RgDatos.order_id,
							  nuTipoComment,
							  isbComment,
							  onuErrorCode,
							  osbErrorMessage
							  );

		ut_trace.trace('Finaliza api_addordercomment onuErrorCode: '	|| onuErrorCode || chr(10) ||
													'osbErrorMessage: '	|| osbErrorMessage, 12);

      if (onuErrorCode <> 0) then
        pkg_error.setErrorMessage(onuErrorCode, osbErrorMessage);
      end if;
      ut_trace.trace('COLOQUE COMENTARIO A LA ORDEN DE SUSPENSION==>' ||
                     RgDatos.order_id,
                     10);
    else
      -- se asigna la orden que
      ut_trace.trace('ASIGNO A LA ORDEN DE SUSPENSION==>' ||
                     RgDatos.order_id,
                     10);
      -- no se usa el algoritmo de asignacion de open ya que es obligatorio para este
      -- proceso que estas ordenes queden asignado a la unidad de trabajo
      -- configurado en el parametro  'ID_OPER_UNIT_LEG_OT_RP'
      UPDATE OR_order
         SET assigned_date     = sysdate,
             ORDER_status_id   = 5,
             operating_unit_id = nuoperatingunit
       WHERE ORDER_id = RgDatos.order_id;

      ut_trace.trace('BUSCO LA CAUSAL PARA LEGALIZAR LA OT DE SUSPENSION==>' ||
                     RgDatos.order_id,
                     10);
      nuTipoTrab := Dald_parameter.fnuGetNumeric_Value('ID_TASKTYPE_SUSP_REVI_RP');
      if RgDatos.task_type_id = nuTipoTrab then
        nuCausalId := Dald_parameter.fnuGetNumeric_Value('ID_CAUSAL_SUSP_REVI_RP');
      else
        nuTipoTrab := Dald_parameter.fnuGetNumeric_Value('ID_TASKTYPE_ACOM_REVI_RP');
        if RgDatos.task_type_id = nuTipoTrab then
          nuCausalId := Dald_parameter.fnuGetNumeric_Value('ID_CAUSAL_SUSP_REVI_RP');
        end if;
      end if;
      nuClaseCausal := dage_causal.fnugetclass_causal_id(nuCausalId);
      if nuClaseCausal = 1 then
        nuCantActividad := 1;
      else
        nuCantActividad := 0;
      end if;

	  ut_trace.trace('Ingresa api_addordercomment order_id: '	|| RgDatos.order_id || chr(10) ||
												 'nuTipoCo: '	|| nuTipoCo 		|| chr(10) ||
												 'isbObserva: '	|| isbObserva, 12);

      api_addordercomment(RgDatos.order_id,
                         nuTipoCo,
                         isbObserva,
                         onuErrorCode,
                         osbErrorMessage
						 );

	  ut_trace.trace('Finaliza api_addordercomment onuErrorCode: '		|| onuErrorCode || chr(10) ||
												  'osbErrorMessage: '	|| osbErrorMessage, 12);

      ISBDATAORDER := RgDatos.order_id || '|' || nuCausalId || '|' ||
                      inuPersonId || '||' || RgDatos.order_activity_id || '>' ||
                      nuCantActividad ||
                      ';READING>>>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|||' ||
                      nuTipoCo || ';' || isbObserva;

	  ut_trace.trace('Ingresa api_legalizeorders isbDataOrder: '	|| ISBDATAORDER   || chr(10) ||
											    'idtInitDate: '		|| sysdate 		  || chr(10) ||
												'idtFinalDate: '	|| sysdate 		  || chr(10) ||
												'idtChangeDate: '	|| sysdate, 10);

	  api_legalizeorders(ISBDATAORDER,
                        sysdate,
                        sysdate,
                        sysdate,
                        onuErrorCode,
                        osbErrorMessage);

	  ut_trace.trace('Sale api_legalizeorders onuErrorCode: '	 || onuErrorCode   || chr(10) ||
											 'osbErrorMessage: ' || osbErrorMessage, 10);


      if (onuErrorCode <> 0) then
		pkg_error.setErrorMessage(onuErrorCode, osbErrorMessage);
      end if;
      IF fsbAplicaEntrega('OSS_CON_JJJ_200_1126_6') = 'S' THEN
        IF nuCantActividad = 0 THEN
          EXECUTE IMMEDIATE 'BEGIN LDC_ATENTESOLOTFINREVPER(' ||
                            nuPackage_type_id || ',' || inuPackage_id ||
                            '); END;';
          or_bolegalizeorder.setcurrentorder(rgdatos.order_id);
          EXECUTE IMMEDIATE 'BEGIN LDCPROCCREATRAMIFLUJOSPRPXML; END;';
        END IF;
      ELSE
        --busco el estado actual del producto
        nuSTATUS        := DAPR_PRODUCT.Fnugetproduct_Status_Id(nuPRODUCTID);
        nuUltActSuspens := dapr_product.fnugetsuspen_ord_act_id(nuPRODUCTID,
                                                                null); --ca 200-889
        --suspendo el producto y actualizo la ultima actividad de suspension en el producto
        update pr_product
           set PRODUCT_STATUS_ID = 2,
               SUSPEN_ORD_ACT_ID = RgDatos.ORDER_ACTIVITY_ID
         WHERE PRODUCT_ID = nuPRODUCTID;
        -- busco el consecutivo de la tabla pr_prod_suspension
        NUPROD_SUSPEN_ID := pr_bosequence.getproductsuspensionid;
        -- inserto un registro en la tabla pr_prod_suspension
        IF daldc_marca_producto.fblExist(nuPRODUCTID) then
          nuType_suspension_id := nvl(daldc_marca_producto.fnuGetSUSPENSION_TYPE_ID(nuPRODUCTID),
                                      101);
        else
          nuType_suspension_id := 101;
        end if;
        INSERT INTO PR_PROD_SUSPENSION
          (prod_suspension_id,
           product_id,
           suspension_type_id,
           register_date,
           Aplication_Date,
           active)
        values
          (NUPROD_SUSPEN_ID,
           nuPRODUCTID,
           nuType_suspension_id,
           sysdate,
           sysdate,
           'Y');
        ut_trace.trace('LEGALIZE LA ORDEN DE SUSPENSION==>' ||
                       RgDatos.order_id,
                       10);
        --  nuType_suspension_id:=daldc_marca_producto.fnuGetSUSPENSION_TYPE_ID(nuPRODUCTID);
        nuSUBSCRIBERId := pktblsuscripc.fnugetsuscclie(nuSUBSCRIPTIONID);
        fecha_inicio   := sysdate + 1 / 24 / 60;
        sbRequestXML1  := '<?xml version="1.0" encoding="ISO-8859-1"?>
            <P_LBC_RECONEXION_POR_SUSPENSION_ADMINISTRATIVA_POR_XML_100153 ID_TIPOPAQUETE="100153">
              <RECEPTION_TYPE_ID>10</RECEPTION_TYPE_ID>
              <CONTACT_ID>' || nuSUBSCRIBERId ||
                          '</CONTACT_ID>
              <ADDRESS_ID></ADDRESS_ID>
              <COMMENT_>' || isbObserva ||
                          '</COMMENT_>
              <PRODUCT>' || nuPRODUCTID ||
                          '</PRODUCT>
              <FECHA_DE_SUSPENSION>' ||
                          fecha_inicio ||
                          '</FECHA_DE_SUSPENSION>
              <TIPO_DE_SUSPENSION>' ||
                          nuType_suspension_id ||
                          '</TIPO_DE_SUSPENSION>
              <TIPO_DE_CAUSAL>' || nutipoCausal ||
                          '</TIPO_DE_CAUSAL>
              <CAUSAL_ID>' || nuCausal ||
                          '</CAUSAL_ID>
              </P_LBC_RECONEXION_POR_SUSPENSION_ADMINISTRATIVA_POR_XML_100153>';

	    ut_trace.trace('Ingresa api_registerRequestByXml ', 12);

        api_registerRequestByXml(sbRequestXML1,
                                 nuPackageId,
                                 nuMotiveId,
                                 onuErrorCode,
                                 osbErrorMessage);

		ut_trace.trace('Finaliza api_registerRequestByXml nuPackageId: '		|| nuPackageId  || chr(10) ||
														 'nuMotiveId: '			|| nuMotiveId 	|| chr(10) ||
														 'onuErrorCode: '		|| onuErrorCode	|| chr(10) ||
														 'osbErrorMessage: '	|| osbErrorMessage, 12);

        if onuErrorCode <> 0 then
		  pkg_error.setErrorMessage(onuErrorCode, osbErrorMessage);
        end if;
        -- actualizo el producto con el estado anterior
        update pr_product
           set PRODUCT_STATUS_ID = nuSTATUS
         WHERE PRODUCT_ID = nuPRODUCTID;
        If fblaplicaentrega(csbEntrega200889) and nuClaseCausal = 2 THEN
          update pr_product
             set SUSPEN_ORD_ACT_ID = nuUltActSuspens
           where product_id = nuPRODUCTID;
        end if;
        -- borro el registro temporal de pr_prod_suspension
        DELETE FROM PR_PROD_SUSPENSION
         WHERE PROD_SUSPENSION_ID = NUPROD_SUSPEN_ID;
      end if;
      ut_trace.trace('Fin LDC_BCRegeReviPeri.PrRegeReviPeri', 10);
    END IF;
  exception
    WHEN Pkg_error.CONTROLLED_ERROR then
      raise Pkg_error.CONTROLLED_ERROR;
    When others then
      sbvarsalida := SQLERRM;
	  pkg_error.setErrorMessage(SQLCODE, SQLERRM);

  END PrRegeReviPeri;

  /*Funci?n que devuelve la versi?n del pkg*/
  FUNCTION fsbVersion RETURN VARCHAR2 IS
  BEGIN
    return CSBVERSION;
  END FSBVERSION;

  procedure PROVALISUSPREGERP is
    /*****************************************************************
    Propiedad intelectual de PETI.

    Unidad         : PROVALISUSPREGERP
    Descripcion    : Valida la legalizacion de la suspension cuando tiene un tipo de observacion especial se debe legalizar con una causal que regenera
                     la revision periodica
    Autor          : Emiro Leyva H.
    Fecha          : 01/10/2013

    Parametros              Descripcion
    ============         ===================
    nuExternalId:


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========           ====================
    01/10/2013        emirol            1. Creacion
    06/02/2015      oparra.Team2732     2. Se modifica validacion, para que realice la suspension
                                           del producto antes de lanzar el tramite de Reconexion
    22/11/2016      bicm. ca200-889     3. Se modifica para que reersse la ultima actividad de suspension
    26/01/2018      Stapias.REQ 200-1518 Se cambia parametro ID_CAUSAL_SUSP_REVI_RP por ID_CAUSALES_SUSP_REVI_RP
	26/07/2023		  jerazomvm			CASO OSF-1359:
										1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
										2. Se reemplaza el API OS_RegisterRequestWithXML por el api api_registerRequestByXml
    ******************************************************************/
    -- Actividad de Orden
    nuOrderId or_order.order_id%type;
    nuCount   number := 0;
    --Cursor para validar si la orden que se est? legalizando tiene tiene un tipo de comentario especial

    cursor cuComment(inuOrderId or_order.order_id%type) is
      select count(*)
        from OR_ORDER_COMMENT
       where order_id = inuOrderId
         and or_order_comment.comment_type_id =
             DALD_parameter.fnuGetNumeric_Value('ID_TYPE_COMMENT_RP');

    --------------------------
    -- REQ. 200-1518 -->
    --------------------------

    -- Variable para almacenar el resultado del cursor.
    nuExistParameter NUMBER := 0;
    --------------------------
    -- REQ. 200-1518 <--
    --------------------------

    onuErrorCode    number;
    osbErrorMessage varchar2(2000);
    nuCausalId      ge_causal.causal_id%type;
    nuClaseCausal   ge_causal.CLASS_CAUSAL_ID%type;
    --REQ 2001518 Se cambia tipo de variable a varchar para obtener valores de un parametro separados por coma.
    nuCausparam          VARCHAR2(2000);
    nuinstance_id        or_order_activity.instance_id%type;
    nuorderactivityID    OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE;
    nuProductId          or_order_activity.product_id%type;
    isbObserva           or_order_comment.order_comment%type := 'USUARIO AUTORIZA INSPECCION Y/O CERTIFICACION';
    nuMotiveId           MO_MOTIVE.MOTIVE_ID%TYPE;
    sbRequestXML1        varchar2(32767);
    nuSUBSCRIBERId       ge_subscriber.SUBSCRIBER_id%type;
    nuSUBSCRIPTIONID     OR_ORDER_ACTIVITY.SUBSCRIPTION_ID%type;
    nuType_suspension_id ldc_marca_producto.suspension_type_id%type;
    fecha_inicio         date;
    nuSTATUS             PR_PRODUCT.PRODUCT_STATUS_ID%TYPE;
    NUPROD_SUSPEN_ID     PR_PROD_SUSPENSION.PROD_SUSPENSION_ID%type;
    nutipoCausal         number;
    nuCausal             number;
    nuMOTIID             MO_MOTIVE.MOTIVE_ID%type;
    nuPackageId          mo_packages.package_id%type;
    sbNombreModulo       varchar2(4000) := null;
    sbNombreAccion       varchar2(4000) := null;
    csbEntrega200889     varchar2(4000) := 'OSS_REV_BICM_200889_1';
    nuUltActSuspens      pr_product.suspen_ord_act_id%type;
  begin

    ut_trace.trace('Inicio LDC_BCRegeReviPeri.PROVALISUSPREGERP', 10);
    --Obtener el identificador de la orden  que se encuentra en la instancia
    nuOrderId         := or_bolegalizeorder.fnuGetCurrentOrder;
    nuorderactivityID := ldc_bcfinanceot.fnuGetActivityId(nuorderid);
    nuPackageId       := daor_order_activity.fnugetpackage_id(nuorderactivityID);
    nuProductId       := daor_order_activity.Fnugetproduct_Id(nuorderactivityID);
    IF daldc_marca_producto.fblExist(nuProductId) then
      nuType_suspension_id := nvl(daldc_marca_producto.fnuGetSUSPENSION_TYPE_ID(nuPRODUCTID),
                                  101);
    ELSE
      nuType_suspension_id := 101;
    END IF;
    nutipoCausal := Dald_parameter.fnuGetNumeric_Value('TIPO_DE_CAUSAL_SUSP_ADMI',
                                                       null);
    if nutipoCausal is null THEN
      Pkg_error.SetErrorMessage(ld_boconstans.cnugeneric_error,
                                       'No existe datos para el parametro TIPO_DE_CAUSAL_SUSP_ADMI, definalos por el comando LDPAR');
      RAISE Pkg_error.controlled_error;
    END IF;
    nuCausal := Dald_parameter.fnuGetNumeric_Value('COD_CAUSA_SUSP_ADM_XML',
                                                   null);

    if nuCausal is null THEN
      Pkg_error.SetErrorMessage(ld_boconstans.cnugeneric_error,
                                       'No existe datos para el parametro COD_CAUSA_SUSP_ADM_XML, definalos por el comando LDPAR');
      RAISE Pkg_error.controlled_error;
    END IF;
    ---------------------------
    -- Stapias.REQ 2001518 -->
    ---------------------------
    --Se cambia parametro individual, por uso de parametro con causales separadas por coma.
    nuCausparam := Dald_parameter.fsbgetvalue_chain('ID_CAUSALES_SUSP_REVI_RP',
                                                    NULL);
    ---------------------------
    -- Stapias.REQ 2001518 <--
    ---------------------------
    if nuCausparam is null then
      Pkg_error.SetErrorMessage(Ld_Boconstans.cnuGeneric_Error,
                                       'No existe datos para el parametro "ID_CAUSALES_SUSP_REVI_RP", definalos por el comando LDPAR separados por coma');
      raise Pkg_error.CONTROLLED_ERROR;
    end if;
    ut_trace.trace('Ejecucion LDC_BCRegeReviPeri.PROVALISUSPREGERP => nuOrderId=>' ||
                   nuOrderId,
                   10);
    --Obtener causal de legalizaci?n
    nuCausalId    := DAOR_ORDER.Fnugetcausal_Id(nuOrderId);
    nuClaseCausal := dage_causal.fnugetclass_causal_id(nuCausalId);
    open cuComment(nuOrderId);
    fetch cuComment
      into nuCount;
    if cuComment%notfound then
      nuCount := 0;
    end if;
    close cuComment;

    -- Obtiene el nombre de la APP que actualmente se est? ejecutando en Smartflex
    ut_session.getmodule(sbNombreModulo, sbNombreAccion);
    IF nuCount = 0 and sbNombreModulo = 'ORCAO' and
       ldc_boutilities.fsbbuscatoken(nuCausparam, to_char(nuCausalId), ',') = 'S' THEN
      Pkg_error.SetErrorMessage(Ld_Boconstans.cnuGeneric_Error,
                                       'Debe usar otra causal de legalizacion, por que el usuario aun no ha solicitado regeneracion revision periodica');
      raise Pkg_error.CONTROLLED_ERROR;
    end if;

    IF nuCount > 0 then
      -- Team 2732 se comenta linea que validaba que la causal fuera de fallo. if nuClaseCausal <> 1 then
      --busco el estado actual del producto
      nuSTATUS        := DAPR_PRODUCT.Fnugetproduct_Status_Id(nuPRODUCTID);
      nuUltActSuspens := dapr_product.fnugetsuspen_ord_act_id(nuPRODUCTID,
                                                              null); --ca 200-889
      ut_trace.trace('LDC_BCRegeReviPeri.PROVALISUSPREGERP.nuUltActSuspens ' ||
                     nuUltActSuspens,
                     10);
      --suspendo el producto y actualizo la ultima actividad de suspension en el producto
      update pr_product
         set PRODUCT_STATUS_ID = 2, SUSPEN_ORD_ACT_ID = nuorderactivityID
       WHERE PRODUCT_ID = nuPRODUCTID;
      -- busco el consecutivo de la tabla pr_prod_suspension
      NUPROD_SUSPEN_ID := pr_bosequence.getproductsuspensionid;
      -- inserto un registro en la tabla pr_prod_suspension

      INSERT INTO PR_PROD_SUSPENSION
        (prod_suspension_id,
         product_id,
         suspension_type_id,
         register_date,
         Aplication_Date,
         active)
      values
        (NUPROD_SUSPEN_ID,
         nuPRODUCTID,
         nuType_suspension_id,
         sysdate,
         sysdate,
         'Y');

      nuMOTIID         := TO_NUMBER(ldc_boutilities.fsbgetvalorcampotabla('MO_MOTIVE',
                                                                          'PACKAGE_ID',
                                                                          'MOTIVE_ID',
                                                                          nuPackageId));
      nuSUBSCRIPTIONID := TO_NUMBER(ldc_boutilities.fsbgetvalorcampotabla('MO_MOTIVE',
                                                                          'MOTIVE_ID',
                                                                          'SUBSCRIPTION_ID',
                                                                          nuMOTIID));
      nuSUBSCRIBERId   := pktblsuscripc.fnugetsuscclie(nuSUBSCRIPTIONID);
      fecha_inicio     := sysdate + 1 / 24 / 60;
      sbRequestXML1    := '<?xml version="1.0" encoding="ISO-8859-1"?>
           <P_LBC_RECONEXION_POR_SUSPENSION_ADMINISTRATIVA_POR_XML_100153 ID_TIPOPAQUETE="100153">
                 <RECEPTION_TYPE_ID>10</RECEPTION_TYPE_ID>
                <CONTACT_ID>' || nuSUBSCRIBERId ||
                          '</CONTACT_ID>
                <ADDRESS_ID></ADDRESS_ID>
                <COMMENT_>' || isbObserva ||
                          '</COMMENT_>
                <PRODUCT>' || nuPRODUCTID ||
                          '</PRODUCT>
                <FECHA_DE_SUSPENSION>' ||
                          fecha_inicio ||
                          '</FECHA_DE_SUSPENSION>
                <TIPO_DE_SUSPENSION>' ||
                          nuType_suspension_id ||
                          '</TIPO_DE_SUSPENSION>
                <TIPO_DE_CAUSAL>' || nutipoCausal ||
                          '</TIPO_DE_CAUSAL>
                <CAUSAL_ID>' || nuCausal ||
                          '</CAUSAL_ID>
                </P_LBC_RECONEXION_POR_SUSPENSION_ADMINISTRATIVA_POR_XML_100153>';

	  ut_trace.trace('Ingresa api_registerRequestByXml ', 12);

      api_registerRequestByXml(sbRequestXML1,
                               nuPackageId,
                               nuMotiveId,
                               onuErrorCode,
                               osbErrorMessage);

	  ut_trace.trace('Finaliza api_registerRequestByXml nuPackageId: '		|| nuPackageId  || chr(10) ||
													   'nuMotiveId: '		|| nuMotiveId 	|| chr(10) ||
													   'onuErrorCode: '		|| onuErrorCode	|| chr(10) ||
													   'osbErrorMessage: '	|| osbErrorMessage, 12);

      if onuErrorCode <> 0 then
        Pkg_error.SetErrorMessage(onuErrorCode, osbErrorMessage);
        raise Pkg_error.CONTROLLED_ERROR;
      end if;

      -- actualizo el producto con el estado anterior
      update pr_product
         set PRODUCT_STATUS_ID = nuSTATUS
       WHERE PRODUCT_ID = nuPRODUCTID;
      --ca 200-889
      If fblaplicaentrega(csbEntrega200889) and nuClaseCausal = 2 THEN
        ut_trace.trace('LDC_BCRegeReviPeri.PROVALISUSPREGERP.csbEntrega200889 ' ||
                       csbEntrega200889,
                       10);
        update pr_product
           set SUSPEN_ORD_ACT_ID = nuUltActSuspens
         where product_id = nuPRODUCTID;
      end if;
      --ca 200-889
      -- borro el registro temporal de pr_prod_suspension
      DELETE FROM PR_PROD_SUSPENSION
       WHERE PROD_SUSPENSION_ID = NUPROD_SUSPEN_ID;

    end if;
    ut_trace.trace('Fin LDC_BCRegeReviPeri.PROVALISUSPREGERP', 10);
  EXCEPTION
    when Pkg_error.CONTROLLED_ERROR then
      raise Pkg_error.CONTROLLED_ERROR;
    when others then
      Pkg_error.setError;
      raise Pkg_error.CONTROLLED_ERROR;
  end PROVALISUSPREGERP;

  PROCEDURE PROATIENDESUSPRP_JOB IS
    /*****************************************************************
    Propiedad intelectual de PETI.

    Unidad         : PROATIENDESUSPRP_JOB
    Descripcion    : SE EJECUTA EN LA SUSPENSION la revision periodica
    Autor          : Emiro Leyva H.
    Fecha          : 01/10/2013

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    01/10/2013       emirol             1. Creacion
    29/01/2014      oparra.Team2732     2. Se adiciona escenario cuando el tipo de suspension
                                           es nulo, para que no genere error y permita legalizar
                                           la OT de suspension
	26/07/2023		  jerazomvm			CASO OSF-1359:
										1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
    ******************************************************************/
    -- Actividad de Orden
    nuOrderActivity    or_order_activity.order_activity_id%type;
    nuProduct          or_order_activity.product_id%type;
    sbSuspensionType   varchar2(4000);
    csbSUSPENSION_TYPE varchar2(100) := 'SUSPENSION_TYPE';
    nuorderid          or_order.order_id%TYPE;
    status_product     pr_product.product_status_id%type;

  BEGIN

    ut_trace.trace('Inicio LDC_BCRegeReviPeri.PROATIENDESUSPRP_JOB', 10);
    --Obtener la actividad que se esta legalizando
    nuOrderActivity := or_bolegalizeactivities.fnugetcurractivity;
    nuorderid       := daor_order_activity.fnugetorder_id(nuOrderActivity);
    -- Obtiene el producto
    nuProduct := or_bolegalizeactivities.fnugetcurrproduct;
    -- Obtiene el tipo de suspension
    sbSuspensionType := or_boinstanceactivities.fsbgetattributevalue(csbSUSPENSION_TYPE,
                                                                     nuOrderActivity);

    -- Team 2732: evitar suspension doble
    -- INICIO Cuando el tipo de suspension sea nulo NO se debe registrar suspension
    IF sbSuspensionType is not null THEN

      -- se cambia el estado pendiente de instalacion a ACTIVO
      status_product := PR_BOSUSPENDCRITERIONS.FNUGETPRODUCTSTATUS(nuproduct);
      ut_trace.trace('emirol codigo del estado producto' || status_product,
                     10);

      if status_product = PR_BOParameter.fnuGetPrPendInst then
        ut_trace.trace('viene de ventas' || status_product, 10);
        dapr_product.Updproduct_Status_Id(nuProduct,
                                          PR_BOParameter.fnuGetPRODACTI);
      end if;

      --ut_trace.trace('viene de ventas'||status_product, 10);
      ut_trace.trace('va a cambiar el estado tipo susp' ||
                     sbSuspensionType,
                     10);
      mo_bosuspension.regadminsuspension(nuOrderActivity, sbSuspensionType);

      if status_product = PR_BOParameter.fnuGetPrPendInst then
        ut_trace.trace('busca componente' || status_product, 10);
        LDCI_PKREVISIONPERIODICAWEB.PROSUSPCOMPONENTE(nuProduct,
                                                      sbSuspensionType);
      end if;
      ut_trace.trace('emirol cambio el estado a suspendido' ||
                     status_product,
                     10);


    END IF;
    -- FIN Cuando el tipo de suspension sea nulo NO se debe registrar suspension

    -- Actualiza la ultima actividad de orden legalizada por suspension de un producto
    dapr_product.updsuspen_ord_act_id(nuProduct, nuOrderActivity);
    ut_trace.trace('actualiza pr_product- dapr_product.updsuspen_ord_act_id' ||
                   nuOrderActivity,
                   10);

    ut_trace.trace('Fin LDC_BCRegeReviPeri.PROATIENDESUSPRP_JOB', 10);

  EXCEPTION
    when Pkg_error.CONTROLLED_ERROR then
      raise Pkg_error.CONTROLLED_ERROR;
    when others then
      Pkg_error.setError;
      raise Pkg_error.CONTROLLED_ERROR;
  END PROATIENDESUSPRP_JOB;

  PROCEDURE ProRegistraReconex IS
    /*****************************************************************
    Propiedad intelectual de PETI.

    Unidad         :  ProRegistraReconex
    Descripcion    :  Objeto que Registra una reconexion (100014), la cual se atienede y
                      activa el producto
    Autor          :  Emiro Leyva
    Fecha          :  30/09/2013

    Parametros              Descripcion
    ============         ===================
    nuExternalId:

    Historia de Modificaciones
    Fecha               Autor            Modificacion
    =========       ============        ====================
    30/09/2013       Emiro               1. creacion
    10/03/2015      oparra.Team 2732     2. Se cambia el objeto mo_bosuspension.RegAdminReconnection
                                            ya que esta dejando el componente de medicion suspendido.
	26/07/2023		  jerazomvm			CASO OSF-1359:
										1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
    ******************************************************************/
    -- Actividad de Orden
    nuOrderActivity  or_order_activity.order_activity_id%type;
    nuProduct        or_order_activity.product_id%type;
    nuSuspensionType NUMBER;

    CURSOR cuTipoSusp(inuProduct or_order_activity.product_id%type) IS
      SELECT /*+ ordered index(MO_MOTIVE IX_MO_SUSPENSION01) index(MO_SUSPENSION PK_MO_SUSPENSION)*/
       mo_suspension.suspension_type_id
        FROM mo_motive, mo_suspension
       WHERE mo_suspension.motive_id = mo_motive.motive_id
         AND (mo_suspension.ending_date IS null OR
             mo_suspension.ending_date > sysdate)
         AND mo_motive.product_id = inuProduct
         AND mo_motive.motive_status_id = 11;
  BEGIN
    UT_Trace.Trace('INICIO: ProRegistraReconex', 5);

    -- Obtiene la actividad que se esta legalizando
    nuOrderActivity := OR_BOLegalizeActivities.fnuGetCurrActivity;

    -- Obtiene el producto
    nuProduct := OR_BOLegalizeActivities.fnuGetCurrProduct;

    open cuTipoSusp(nuProduct);
    fetch cuTipoSusp
      into nuSuspensionType;
    close cuTipoSusp;

    -- Team 2732: Se comenta linea ya que este objeto deja suspendido el componente de medicion
    -- Se cambia por el procedimiento LDC_CAMBIO_ESTADO_PROD
    UT_Trace.Trace('ProRegistraReconex - Activa el producto', 5);
    LDC_CAMBIO_ESTADO_PROD(nuProduct);

    UT_Trace.Trace('FIN: ProRegistraReconex', 5);

  EXCEPTION
    WHEN Pkg_error.CONTROLLED_ERROR THEN
      raise Pkg_error.CONTROLLED_ERROR;
    WHEN others THEN
      Pkg_error.setError;
      raise Pkg_error.CONTROLLED_ERROR;

  END ProRegistraReconex;

  FUNCTION fnuValidaEntraCNCRN(inuPackage_id in mo_packages.package_id%type)
    RETURN NUMBER IS

    /*****************************************************************
    Propiedad intelectual de PETI.

    Unidad         : fnuValidaEntraCNCRN
    Descripcion    : Valida si tiene orden para el proceso y poder visualizar el tramite en el CNCRM

    Autor          : Emiro Leyva H.
    Fecha          : 01/10/2013

    Parametros              Descripcion
    ============         ===================
    nuExternalId:


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    01/10/2013       emirol             1. Creacion
    29/01/2014      oparra.Team2732     2. Se modifica cursor, para que consulte el listado de los TT
                                          de suspension por CM y acometida por parametro.
	01/08/2023		jerazomvm			Caso OSF-1359:
										1. Se reemplaza la separacion de cadena LDC_BOUTILITIES.SPLITSTRINGS por
										   SELECT to_number(regexp_substr(variable,
															'[^,]+',
															1,
															LEVEL)) AS alias
										   FROM dual
										   CONNECT BY regexp_substr(variable, '[^,]+', 1, LEVEL) IS NOT NULL
    ******************************************************************/
    nuCount           			number := 0;
    nuPackage_type_id 			mo_packages.package_type_id%type;
    inuProducto_id    			pr_product.product_id%type;
    nustatus_product  			pr_product.product_status_id%type;
	sbLdc_Tt_Susp_CM			ld_parameter.value_chain%type :=	DALD_PARAMETER.fsbGetValue_Chain('LDC_TT_SUSP_CM', NULL);
	sbLdc_Tt_Susp_Acometida		ld_parameter.value_chain%type :=	DALD_PARAMETER.fsbGetValue_Chain('LDC_TT_SUSP_ACOMETIDA', NULL);

    -- Team 2732.
    -- Cursor para buscar la orden asociada a la solicitud de revision periodica
    -- sengun los TT configurados en los parametros.
    cursor cuOrden(inuPackageId mo_packages.package_id%type) is
      select COUNT(1)
        from or_order_activity a, or_order b
       where a.order_id = b.order_id
         and ((b.task_type_id in
             (SELECT to_number(regexp_substr(sbLdc_Tt_Susp_CM,
							   '[^,]+',
							   1,
							   LEVEL)) AS LDC_TT_SUSP_CM
			  FROM dual
			  CONNECT BY regexp_substr(sbLdc_Tt_Susp_CM, '[^,]+', 1, LEVEL) IS NOT NULL)) or
             b.task_type_id in
             (SELECT to_number(regexp_substr(sbLdc_Tt_Susp_Acometida,
							   '[^,]+',
							   1,
							   LEVEL)) AS LDC_TT_SUSP_ACOMETIDA
			  FROM dual
			  CONNECT BY regexp_substr(sbLdc_Tt_Susp_Acometida, '[^,]+', 1, LEVEL) IS NOT NULL))
         and b.order_status_id in (0, 5)
         and package_id = inuPackageId
         and rownum = 1;

    CURSOR CuProducto(nuPackage_id mo_packages.package_id%type) is
      select distinct product_id
        from or_order_activity
       where or_order_activity.package_id = nuPackage_id;

    cursor cuNotiRepa(nuProduct_id pr_product.product_id%type) is
      select count(1)
        from ldc_plazos_cert
       where id_producto = nuProduct_id
         and is_notif = 'YR';

    cursor cuSusp(nuProduct_id pr_product.product_id%type) is
      select count(1)
        from or_order_activity a, or_order b
       where a.order_id = b.order_id
         and (b.task_type_id =
             DALD_PARAMETER.fnuGetNumeric_Value('ID_TASKTYPE_SUSP_REVI_RP',
                                                 NULL) or
             b.task_type_id =
             DALD_PARAMETER.fnuGetNumeric_Value('ID_TASKTYPE_ACOM_REVI_RP',
                                                 NULL))
         and b.order_status_id in (20)
         and a.product_id = nuProduct_id
         and rownum = 1;
  begin
    ut_trace.trace('Inicio LDC_BCRegeReviPeri.fnuValidaEntraCNCRN', 10);
    nuPackage_type_id := damo_packages.fnugetpackage_type_id(inuPackage_id);

    if nuPackage_type_id = 100246 then
      open CuProducto(inuPackage_id);
      fetch CuProducto
        into inuProducto_id;
      close CuProducto;
      nustatus_product := dapr_product.fnugetproduct_status_id(inuProducto_id);
      if nustatus_product = 2 then
        RETURN(0);
      end if;
      open cuSusp(inuProducto_id);
      fetch cuSusp
        into nuCount;
      if cuSusp%notfound then
        nuCount := 0;
      end if;
      close cuSusp;
      if nuCount = 0 then
        RETURN(0);
      end if;
      open cuNotiRepa(inuProducto_id);
      fetch cuNotiRepa
        into nuCount;
      if cuNotiRepa%notfound then
        nuCount := 0;
      end if;
      close cuNotiRepa;
      if nuCount = 0 then
        RETURN(0);
      end if;
      RETURN(1);
    end if;
    open cuOrden(inuPackage_id);
    fetch cuOrden
      into nuCount;
    if cuOrden%notfound then
      close cuOrden;
      nuCount := 0;
      RETURN(nuCount);
    end if;
    close cuOrden;
    ut_trace.trace('FINALIZO LDC_BCRegeReviPeri.fnuValidaEntraCNCRN', 10);
    RETURN(nuCount);
  EXCEPTION
    when others then
      RETURN(0);
  end fnuValidaEntraCNCRN;
  /*******************************************************************************
  Metodo: fsbgetvalorcampostablaUltReg
  Descripcion:   Consulta el ultimo registro de un campo ingresando los siguientes parametros
                sbnomtab: Nombre de la Entidad de donde se extraera el dato
                sbnocall: Nombre del atributo (normalmente la llave de la tabla) que se utilizara en el where
                sbnocade: Nombre del atributo de donde se extraera el dato.
                sbvalval: Valor del criterio ingresado
  Ejemplo: Consulta el valor del atributo a extraer  de una entidad cuando la llave de la entidad es compuesta (2 campos)
                ('Entidad','Llave1','llave2','Atributo a extraer',Valor1,Valor2)
  Autor: Emiro Leyva
  Fecha: Octubre 16/2013

   Historia de Modificaciones
   Fecha             Autor             Modificacion
   =========       =========           ====================
   18-03-2014      smejia              Aran 94392. Se modifica la consulta a DBA_TAB_COLUMNS
                                       de modo que el tipo de dato del campo, se obtenga haciendo
                                       uso del squema de Smartflex (GE_ENTITY, GE_ENTITY_ATTRIBUTES,...)
  *******************************************************************************/
  FUNCTION fsbgetvalorcampostablaUltReg(sbnomtab  IN VARCHAR2,
                                        sbnocall1 IN VARCHAR2,
                                        sbnocade  IN VARCHAR2,
                                        sbvalval1 IN VARCHAR2,
                                        sbnocall2 IN VARCHAR2,
                                        sbvalval2 IN VARCHAR2

                                        ) RETURN VARCHAR2 IS
    query_str     VARCHAR2(2000);
    sbdescri      VARCHAR2(2000);
    sbtipocolumna VARCHAR2(20);
    sbnocade_n    VARCHAR2(200);

    CURSOR typecolumn IS
      SELECT at.description
        FROM ge_entity en, ge_entity_attributes ea, ge_attributes_type at
       WHERE en.name_ = UPPER(sbnomtab)
         AND ea.entity_id = en.entity_id
         AND ea.technical_name = UPPER(sbnocade)
         AND at.attribute_type_id = ea.attribute_type_id;
  BEGIN
    OPEN typecolumn;

    FETCH typecolumn
      INTO sbtipocolumna;

    CLOSE typecolumn;

    sbnocade_n := sbnocade;

    IF sbtipocolumna = 'NUMBER' THEN
      sbnocade_n := 'to_char(' || sbnocade || ')';
    END IF;

    IF sbtipocolumna = 'DATE' THEN
      sbnocade_n := 'to_char(' || sbnocade || ',''dd-mm-yyyy hh24:mi:ss' ||
                    ''')';

    END IF;

    query_str := 'select max(' || sbnocade_n || ') from ' || sbnomtab ||
                 ' where ' || sbnocall1 || ' = ''' || sbvalval1 || '''' ||
                 ' and ' || sbnocall2 || ' = ''' || sbvalval2 || '''';

    EXECUTE IMMEDIATE query_str
      INTO sbdescri;

    RETURN sbdescri;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      sbdescri := '-1'; ---no existen datos
      RETURN sbdescri;
    WHEN OTHERS THEN
      SBDESCRI := '-2'; ----SQLERRM || '--';   se esta generando un error al ejecutar la funcion

      RETURN sbdescri;
  END fsbgetvalorcampostablaUltReg;
  /*******************************************************************************
  Metodo: attendpackage
  Descripcion:  metodo para atender el tramite de suspension
  Autor: Emiro Leyva
  Fecha: Agosto 07/2014

   Historia de Modificaciones
   Fecha             Autor             Modificacion
   =========       =========           ====================
   26/07/2023		  jerazomvm			CASO OSF-1359:
										1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
   23/Sep/2014     Jorge Valiente      NC3341:Cambiar la logica quemada original
                                              AND b.task_type_id = 10450
                                              por un parametro llamado TIPO_TRABAJO_ATTENDPACKAGE
  *******************************************************************************/

  procedure attendpackage(inuPackage_id in mo_packages.package_id%type,
                          inuAccion     in number) is

  begin
    ut_trace.trace('Inicio LDC_BCRegeReviPeri.attendpackage', 10);
    MO_BOAttention.attendpackage(inuPackage_id, inuAccion, true);
    ut_trace.trace('Fin LDC_BCRegeReviPeri.attendpackage', 10);
  exception
    WHEN Pkg_error.CONTROLLED_ERROR then
      raise Pkg_error.CONTROLLED_ERROR;
    When others then
	  pkg_error.setErrorMessage(SQLCODE, SQLERRM);
  end attendpackage;

  /*******************************************************************************
    Metodo: fsbSuspOrderWithFail
    Descripcion: La funcion permite consultar si las ordenes asociadas a la solicitud
                se legalizan con fallo para evaluar si se suspende o no el producto
                Esta funcion es utilizada en la accion
                No.237 Realiza la atencion de una suspension voluntaria de un producto
    Salida       Y = Orden con fallo N= Orden sin fallo
    Autor:
    Fecha:

    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
	01-08-2023		jerazomvm			Caso OSF-1359:
										1. Se reemplaza la separacion de cadena LDC_BOUTILITIES.SPLITSTRINGS por
										   SELECT to_number(regexp_substr(variable,
															'[^,]+',
															1,
															LEVEL)) AS alias
										   FROM dual
										   CONNECT BY regexp_substr(variable, '[^,]+', 1, LEVEL) IS NOT NULL
    03-02-2014      agordillo           TS.4300
                                        Se cambia la logica del cursor cuDatos, para que cuente
                                        si aunque sea alguna de las ordenes asociadas en la solicitud
                                        y con tipo de trabajo configurado en el parametro TIPO_TRABAJO_ATTENDPACKAGE
                                        tiene una orden con causal de exito.
                                        TIPO_TRABAJO_ATTENDPACKAGE = tipos de trabajo que realizan
                                        suspencion del producto
  *****************************************************************************************/
  FUNCTION fsbSuspOrderWithFail(inuPackage_id in mo_packages.package_Id%type)
    RETURN VARCHAR2 IS
    nuOk 							number;
	sbTipo_trabajo_AttendPackage	ld_parameter.value_chain%type :=	DALD_PARAMETER.fsbGetValue_Chain('TIPO_TRABAJO_ATTENDPACKAGE', NULL);

    cursor cuDatos(nuPackage_id in mo_packages.package_Id%type) is
      SELECT count(1)
        FROM mo_packages       a,
             OR_order_activity b,
             OR_order          c,
             ge_causal              d
       WHERE a.package_id = b.package_id
         AND b.order_id = c.order_id
         AND b.task_type_id = c.task_type_id
         AND c.causal_id = d.causal_id
         AND a.PACKAGE_Id = nuPackage_id
         AND b.task_type_id IN (SELECT to_number(regexp_substr(sbTipo_trabajo_AttendPackage,
								  			    '[^,]+',
											    1,
											    LEVEL)) AS TIPO_TRABAJO_ATTENDPACKAGE
							    FROM dual
							    CONNECT BY regexp_substr(sbTipo_trabajo_AttendPackage, '[^,]+', 1, LEVEL) IS NOT NULL)
         AND c.order_status_id = 8
         AND d.class_causal_id = 1; -- 2;  Team 4300

  BEGIN
    open cuDatos(inuPackage_id);
    FETCH cuDatos
      INTO nuOk;
    if cuDatos%notfound then
      nuOk := 0;
    end if;
    CLOSE cuDatos;

    -- Si encuentra aunque sea una orden con casual de Exito, la variable nuOk es mayor a Cero
    -- Indica que el tipo de trabajo para suspencion no es legalizada con Fallo
    IF nuOk > 0 then
      return('N');
    else
      return('Y');
    end if;

  EXCEPTION
    when no_data_found then
      return('N');
  END fsbSuspOrderWithFail;

  procedure OBJ_DeteccionbyNotifR is
    /*****************************************************************
      Propiedad intelectual de PETI (c).

      Unidad         : OBJ_DeteccionbyNotifR
      Descripcion    : Procedimiento PLUGIN para generar "Detencion de la Suspension Administrativa por Certificacion"
                       cuando se legaliza la "Notificacion x Reparacion" con causal de Exito, para que genere los
                       trabajos. Basado en PrRegeReviPeri
      Autor          : Oscar Parra
      Fecha          : 09/11/2014


      Historia de Modificaciones
      Fecha             Autor             	Modificacion
      =========         =========         	====================
	  26/07/2023		  jerazomvm			CASO OSF-1359:
											1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
											2. Se reemplaza el API OS_RegisterRequestWithXML por el api api_registerRequestByXml
      09/11/2014          oparra          Creacion
    ******************************************************************/

    nuorderid            or_order.order_id%type;
    nucurractivityid     number;
    nuTipoTrab           ld_parameter.numeric_value%type;
    ISBDATAORDER         varchar2(2000);
    nuCausalId           or_order.causal_id%type;
    nutipoCausal         number;
    nuCausal             number;
    nuMotiveId           MO_MOTIVE.MOTIVE_ID%TYPE;
    nuSUBSCRIBERId       ge_subscriber.SUBSCRIBER_id%type;
    nuPackageId          mo_packages.package_id%type;
    nuTaskTypeId         or_task_type.task_type_id%type;
    isbComment           varchar2(2000) := 'PROCESADA POR EL TRAMITE DE REGENERACION DE REVISION PERIODICA';
    nuTipoComment        OR_ORDER_COMMENT.COMMENT_TYPE_ID%TYPE;
    nuTipoCo             OR_ORDER_COMMENT.COMMENT_TYPE_ID%TYPE := 3;
    onuErrorCode         number;
    osbErrorMessage      varchar2(2000);
    nuClaseCausal        ge_causal.CLASS_CAUSAL_ID%type;
    nuCantActividad      or_order_activity.VALUE_REFERENCE%type;
    INUPERSONID          ge_person.person_id%type;
    nuoperatingunit      or_order.OPERATING_UNIT_ID%type;
    NUORDERPADREID       or_order.order_id%type;
    NUOPER_UNIT_PADRE    or_order.OPERATING_UNIT_ID%type;
    nuMOTIID             MO_MOTIVE.MOTIVE_ID%type;
    nuMOTIID_old         MO_MOTIVE.MOTIVE_ID%type;
    nuSUBSCRIPTIONID     OR_ORDER_ACTIVITY.SUBSCRIPTION_ID%type;
    nuPRODUCTID          OR_ORDER_ACTIVITY.PRODUCT_ID%type;
    nuaddressid          or_order_activity.address_id%TYPE;
    nuinstance_id        OR_ORDER_ACTIVITY.instance_id%type;
    nuorderactivityID    OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE;
    ionuorderid          OR_ORDER.ORDER_ID%TYPE;
    inuMotive            OR_ORDER_ACTIVITY.MOTIVE_ID%TYPE;
    inuComponent         OR_ORDER_ACTIVITY.COMPONENT_ID%TYPE;
    isbObserva           or_order_comment.order_comment%type;
    sbRequestXML1        varchar2(32767);
    nuType_suspension_id ldc_marca_producto.suspension_type_id%type;
    fecha_inicio         date;
    nuSTATUS             PR_PRODUCT.PRODUCT_STATUS_ID%TYPE;
    NUPROD_SUSPEN_ID     PR_PROD_SUSPENSION.PROD_SUSPENSION_ID%type;
    nuPackage_type_id    mo_packages.package_type_id%type;
    sw1                  number;

    cursor cuBuscaSoli(nuprodu ldc_marca_producto.id_producto%type) IS
      select 1
        from mo_packages a, ps_motive_status c, mo_motive x
       WHERE a.PACKAGE_TYPE_ID in (100246)
         AND c.MOTIVE_STATUS_ID = a.MOTIVE_STATUS_ID
         AND c.MOTI_STATUS_TYPE_ID = 2
         AND c.MOTIVE_STATUS_ID not in (14, 32, 51)
         and x.PACKAGE_ID = a.PACKAGE_ID
         and x.PRODUCT_ID = nuprodu;

    cursor cuGetProduct(inuOrder or_order.order_id%type) is
      SELECT oa.product_id
        FROM or_order_activity oa, OR_order o
       WHERE o.ORDER_id = oa.ORDER_id
         AND o.ORDER_id = inuOrder
         AND oa.product_id is not null;

    rgDatos cuBuscaSoli%rowtype;

  BEGIN

    ut_trace.trace('Inicio LDC_BCRegeReviPeri.OBJ_DeteccionbyNotifR', 10);
    dbms_output.put_line('Inicio proceso');

    -- obtener orden que se legaliza
    nuorderid := or_bolegalizeorder.fnugetcurrentorder;
    -- Actividad de Orden
    nucurractivityid := ldc_bcfinanceot.fnuGetActivityId(nuorderid);

    -- obtener producto por orden
    open cuGetProduct(nuorderid);
    fetch cuGetProduct
      into nuPRODUCTID;
    if cuGetProduct%notfound then
      nuPRODUCTID := -1;
    end if;
    close cuGetProduct;

    open cuBuscaSoli(nuProductId);
    FETCH cuBuscaSoli
      INTO sw1;
    if cuBuscaSoli%notfound then
      sw1 := 0;
    end if;
    CLOSE cuBuscaSoli;

    if sw1 <> 1 then
      Pkg_error.SetErrorMessage(ld_boconstans.cnugeneric_error,
                                       'Para utilizar esta causal se requiere que el Producto tenga tramite de Notificacion x Suspesion' ||
                                       ' en proceso');
      RAISE Pkg_error.controlled_error;
    END IF;

    isbObserva := 'ACEPTA REPARACION, SE GENERAN LOS TRABAJOS POR MEDIO DEL TRAMITE DE DETENCION ';

    ut_trace.trace('BUSCO LA CAUSAL PARA LEGALIZAR LA OT DE SUSPENSION==>' ||
                   nuorderid,
                   10);

    nutipoCausal := Dald_parameter.fnuGetNumeric_Value('TIPO_DE_CAUSAL_SUSP_ADMI',
                                                       null);
    if nutipoCausal is null THEN
      Pkg_error.SetErrorMessage(ld_boconstans.cnugeneric_error,
                                       'No existe datos para el parametro TIPO_DE_CAUSAL_SUSP_ADMI, definalos por el comando LDPAR');
      RAISE Pkg_error.controlled_error;
    END IF;

    nuCausal := Dald_parameter.fnuGetNumeric_Value('COD_CAUSA_SUSP_ADM_XML',
                                                   null);
    if nuCausal is null THEN
      Pkg_error.SetErrorMessage(ld_boconstans.cnugeneric_error,
                                       'No existe datos para el parametro COD_CAUSA_SUSP_ADM_XML, definalos por el comando LDPAR');
      RAISE Pkg_error.controlled_error;
    END IF;

    ut_trace.trace('Finalizo validacion de parametros', 10);

    /**** busco el estado actual del producto  ****/
    nuSTATUS := DAPR_PRODUCT.Fnugetproduct_Status_Id(nuPRODUCTID);

    --suspendo el producto y actualizo la ultima actividad de suspension en el producto
    update pr_product
       set PRODUCT_STATUS_ID = 2, SUSPEN_ORD_ACT_ID = nucurractivityid
     WHERE PRODUCT_ID = nuPRODUCTID;

    -- busco el consecutivo de la tabla pr_prod_suspension
    NUPROD_SUSPEN_ID := pr_bosequence.getproductsuspensionid;

    -- inserto un registro en la tabla pr_prod_suspension
    IF daldc_marca_producto.fblExist(nuPRODUCTID) then
      nuType_suspension_id := nvl(daldc_marca_producto.fnuGetSUSPENSION_TYPE_ID(nuPRODUCTID),
                                  101);
    else
      nuType_suspension_id := 101;
    end if;

    INSERT INTO PR_PROD_SUSPENSION
      (prod_suspension_id,
       product_id,
       suspension_type_id,
       register_date,
       Aplication_Date,
       active)
    values
      (NUPROD_SUSPEN_ID,
       nuPRODUCTID,
       nuType_suspension_id,
       sysdate,
       sysdate,
       'Y');

    ut_trace.trace('LEGALIZE LA ORDEN DE SUSPENSION==>' || nuorderid, 10);

    fecha_inicio := sysdate + 1 / 24 / 60;
    -- obtener el cliente
    nuSUBSCRIPTIONID := dapr_product.fnugetSUBSCRIPTION_ID(nuPRODUCTID);
    nuSUBSCRIBERId   := pktblsuscripc.fnugetsuscclie(nuSUBSCRIPTIONID);

    sbRequestXML1 := '<?xml version="1.0" encoding="ISO-8859-1"?>
        <P_LBC_RECONEXION_POR_SUSPENSION_ADMINISTRATIVA_POR_XML_100153 ID_TIPOPAQUETE="100153">
          <RECEPTION_TYPE_ID>10</RECEPTION_TYPE_ID>
          <CONTACT_ID>' || nuSUBSCRIBERId ||
                     '</CONTACT_ID>
          <ADDRESS_ID></ADDRESS_ID>
          <COMMENT_>' || isbObserva ||
                     '</COMMENT_>
          <PRODUCT>' || nuPRODUCTID ||
                     '</PRODUCT>
          <FECHA_DE_SUSPENSION>' || fecha_inicio ||
                     '</FECHA_DE_SUSPENSION>
          <TIPO_DE_SUSPENSION>' || nuType_suspension_id ||
                     '</TIPO_DE_SUSPENSION>
          <TIPO_DE_CAUSAL>' || nutipoCausal ||
                     '</TIPO_DE_CAUSAL>
          <CAUSAL_ID>' || nuCausal ||
                     '</CAUSAL_ID>
          </P_LBC_RECONEXION_POR_SUSPENSION_ADMINISTRATIVA_POR_XML_100153>';

	ut_trace.trace('Finaliza api_registerRequestByXml', 12);

    api_registerRequestByXml(sbRequestXML1,
                             nuPackageId,
                             nuMotiveId,
                             onuErrorCode,
                             osbErrorMessage);

	ut_trace.trace('Finaliza api_registerRequestByXml nuPackageId: '		|| nuPackageId  || chr(10) ||
													 'nuMotiveId: '			|| nuMotiveId 	|| chr(10) ||
													 'onuErrorCode: '		|| onuErrorCode	|| chr(10) ||
													 'osbErrorMessage: '	|| osbErrorMessage, 12);

    if onuErrorCode <> 0 then
      Pkg_error.SetErrorMessage(onuErrorCode, osbErrorMessage);
      raise Pkg_error.CONTROLLED_ERROR;
    end if;
    -- actualizo el producto con el estado anterior
    update pr_product
       set PRODUCT_STATUS_ID = nuSTATUS
     WHERE PRODUCT_ID = nuPRODUCTID;

    -- borro el registro temporal de pr_prod_suspension
    DELETE FROM PR_PROD_SUSPENSION
     WHERE PROD_SUSPENSION_ID = NUPROD_SUSPEN_ID;

    ut_trace.trace('Fin LDC_BCRegeReviPeri.PrRegeReviPeri', 10);
  exception
    WHEN Pkg_error.CONTROLLED_ERROR then
      raise Pkg_error.CONTROLLED_ERROR;
    When others then
	  pkg_error.setErrorMessage(SQLCODE, SQLERRM);

  END OBJ_DeteccionbyNotifR;

end LDC_BCRegeReviPeri;
/