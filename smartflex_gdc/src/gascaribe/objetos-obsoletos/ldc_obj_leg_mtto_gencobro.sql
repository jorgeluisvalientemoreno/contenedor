CREATE OR REPLACE PROCEDURE OPEN."LDC_OBJ_LEG_MTTO_GENCOBRO"
IS
   /*****************************************************************
   Propiedad intelectual de PETI.

   Unidad         : LDC_OBJ_LEG_MTTO_GENCOBRO
   Descripcion    : GENERA COBRO A ORDENES AUTONOMAS DE ORDENES DE MANTENIMIENTO
   Autor          : Emiro Leyva H.
   Fecha          : 12/11/2013

   Parametros              Descripcion
   ============         ===================
   nuExternalId:


   Historia de Modificaciones
   Fecha             Autor             Modificacion
   =========       =========           ====================
  22/08/2014      Jorge Valiente   NC 1562: Modificar el ususario fijo 800167643 por el den parametro
                                            COD_USER_SOLICITUDES_INTERNAS
   ******************************************************************/
   onuerrorcode           NUMBER;
   osberrormessage        VARCHAR2 (4000);
   nuorderid              or_order.order_id%TYPE;
   nucurractivityid       or_order_activity.order_activity_id%TYPE;
   inuvalue               or_order.ORDER_VALUE%type;
   inuCuota               diferido.difenucu%type;
   nuConcepto             diferido.DIFECONC%type;
   nuCausalId             ge_causal.causal_id%type;
   sbRequestXML1          varchar2(32767);
   nuPackage_id           mo_packages.package_id%type;
   nuPLan_fina            number;
   nuMotiveId             mo_motive.motive_id%type;
   orcPerifact            perifact%rowtype;
   nuPRODUCT_ID           OR_ORDER_ACTIVITY.PRODUCT_ID%type;
   nuSUBSCRIBER_ID        OR_ORDER_ACTIVITY.SUBSCRIBER_ID%type;
   sbaditionalattribute   or_temp_data_values.data_value%TYPE;
   sbNAME_ATTRIBUTE       ge_attributes.NAME_ATTRIBUTE%TYPE;
   nuAtrriValu_id         ge_attributes.ATTRIBUTE_ID%TYPE;
   nuAtrriCuot_id         ge_attributes.ATTRIBUTE_ID%TYPE;
   NUTASK_TYPE            or_order.task_type_id%type;
   nuCate                 servsusc.sesucate%type;
   nuSuca                 servsusc.sesusuca%type;
   nuPersonId             ge_person.person_id%type;
   nuPtoAtncn             number;
   sbSubscriberId         number;
   error_proceso          EXCEPTION;
   sbComment              VARCHAR2(2000) := 'SE GENERAN TRAMITE PARA GENERAR CARGOS A ORDENES AUTONOMAS';
   dtFecha                date;
   irccc_sales_financ_cond  dacc_sales_financ_cond.stycc_sales_financ_cond;
   ircPlan_financ           plandife%rowtype;
   rcConftain               conftain%rowtype;
   -- busco el plan de financiacion
   cursor cuPlanFina(inuFINANCING_PLAN_ID  cc_sales_financ_cond.FINANCING_PLAN_ID%type)
   is
     select * from plandife
     where PLDICODI=inuFINANCING_PLAN_ID
   and   sysdate between pldifein and pldifefi;

   CURSOR cuPersonId IS
    SELECT  PERSON_ID
    FROM    OPEN.GE_PERSON
    WHERE   IDENT_TYPE_ID = 110
    AND     NUMBER_ID     = open.DALD_PARAMETER.fsbGetValue_Chain('COD_USER_SOLICITUDES_INTERNAS',NULL);--'800167643';

--Cursor que obtiene el punto de atencion del usuario logueado al sistema
CURSOR cuAreaOrganizat (nuPersonId ge_person.person_id%type) IS
    SELECT ORGANIZAT_AREA_ID
    FROM   CC_ORGA_AREA_SELLER
    WHERE  PERSON_ID = nuPersonId
    AND    IS_CURRENT = 'Y';


  CURSOR cuSubscriberId IS
      SELECT SUBSCRIBER_ID
      FROM   OPEN.GE_SUBSCRIBER
      WHERE  IDENTIFICATION = open.DALD_PARAMETER.fsbGetValue_Chain('COD_USER_SOLICITUDES_INTERNAS',NULL) --'800167643' --USUARIO SOLICITUDES INTERNAS
      AND    IDENT_TYPE_ID  = 1;

    --NC 1562 cursor y variables
    sbnumber_id varchar2(20);
    -------------------------

BEGIN
     ---  orden que se legaliza
     nuorderid := or_bolegalizeorder.fnugetcurrentorder;

     -- Actividad de Orden
     nucurractivityid := or_bolegalizeactivities.fnugetcurractivity;
      -- Obtiene la actividad asociada a la actividad de orden
    IF nuorderid IS NULL THEN
       nuorderid := daor_order_activity.fnugetorder_id (nucurractivityid);
    END IF;

  nuTask_type  := daor_order.fnugettask_type_id(nuorderid);

    sbnumber_id := Dald_parameter.fnuGetNumeric_Value('COD_USER_SOLICITUDES_INTERNAS',null);
    if sbnumber_id is null  then
       ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                      'No existe datos para el parametro COD_USER_SOLICITUDES_INTERNAS, definalos por el comando LDPAR');
       raise ex.CONTROLLED_ERROR;
    end if;

    nuAtrriValu_id := Dald_parameter.fnuGetNumeric_Value('ATRR_VALOR_OT_AUTO',null);
    if nuAtrriValu_id is null  then
       ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                      'No existe datos para el parametro ATRR_VALOR_OT_AUTO, definalos por el comando LDPAR');
       raise ex.CONTROLLED_ERROR;
    end if;
    nuAtrriCuot_id := Dald_parameter.fnuGetNumeric_Value('ATRR_CUOTA_OT_AUTO',null);
    if nuAtrriCuot_id is null  then
       ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                      'No existe datos para el parametro ATRR_CUOTA_OT_AUTO, definalos por el comando LDPAR');
       raise ex.CONTROLLED_ERROR;
    end if;
    OPEN cuPersonId;
     FETCH cuPersonId INTO nuPersonId;
         IF cuPersonId%NOTFOUND THEN
          CLOSE cuPersonId;
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                      'No se encontro nuPersonId para la identificacion [' || open.DALD_PARAMETER.fsbGetValue_Chain('COD_USER_SOLICITUDES_INTERNAS',NULL) || ']');
            raise ex.CONTROLLED_ERROR;
         END IF;
    CLOSE cuPersonId;

    --ut_trace.trace('Entro cursor cuAreaOrganizat', 10);

    OPEN cuAreaOrganizat(nuPersonId);
     FETCH cuAreaOrganizat INTO nuPtoAtncn;
         IF cuAreaOrganizat%NOTFOUND THEN
        CLOSE cuAreaOrganizat;
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                      'El cursor cuAreaOrganizat no arrojo datos con el person_id #'||nuPersonId);
            raise ex.CONTROLLED_ERROR;
         END IF;
     CLOSE cuAreaOrganizat;

    OPEN cuSubscriberId;
     FETCH cuSubscriberId INTO sbSubscriberId;
         IF cuSubscriberId%NOTFOUND THEN
       CLOSE cuSubscriberId;
           ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                      'No se encontro susbcriber_id para la identificacion [' || open.DALD_PARAMETER.fsbGetValue_Chain('COD_USER_SOLICITUDES_INTERNAS',NULL) || ']');
            raise ex.CONTROLLED_ERROR;
         END IF;
    CLOSE cuSubscriberId;

    -- busco el nombre del atributo para el campo valor
  select NAME_ATTRIBUTE into sbNAME_ATTRIBUTE from ge_attributes where attribute_id=nuAtrriValu_id;
  -- busco el valor del dato adicional para el valor
  sbaditionalattribute:=LDC_BOORDENES.fsbDatoAdicTmpOrden(nuorderid, nuAtrriValu_id, sbNAME_ATTRIBUTE);
    inuvalue := TO_NUMBER (sbaditionalattribute);
    -- busco el nombre del atributo valor de la cuota
  select NAME_ATTRIBUTE into sbNAME_ATTRIBUTE from ge_attributes where attribute_id=nuAtrriCuot_id;
    -- busco el valor del dato adicional para la cuota
  sbaditionalattribute:=LDC_BOORDENES.fsbDatoAdicTmpOrden(nuorderid, nuAtrriCuot_id, sbNAME_ATTRIBUTE);
    inuCuota := TO_NUMBER (sbaditionalattribute);
    if inuvalue > 0 and inuCuota >= 0 then
       if inuCuota = 0 then
          inuCuota:=1;
       end if;
       --busco el concepto del tipo de trabajo
       nuConcepto := Daor_task_type.Fnugetconcept(nuTask_type);
       if nuConcepto is null  then
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                       'No esta definido el concepto para el tipo de trabajo '||nuTask_type);
            raise ex.CONTROLLED_ERROR;
       end if;
       nuCausalId := Dald_parameter.fnuGetNumeric_Value('CAUSAL_CARGO_OT_AUTO'||nuTask_type,null);
       if nuCausalId is null  then
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                       'No existe datos para el parametro CAUSAL_CARGO_OT_AUTO'||nuTask_type||', definalos por el comando LDPAR');
            raise ex.CONTROLLED_ERROR;
       end if;
    -- busco el parametro del plan de financiacion
       nuPLan_fina := Dald_parameter.fnuGetNumeric_Value('PLAN_FINAN_OT_AUTO',null);
       if nuPLan_fina is null  then
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                       'No existe datos para el parametro PLAN_FINAN_OT_AUTO, definalos por el comando LDPAR');
            raise ex.CONTROLLED_ERROR;
        end if;
        -- busco el plan de financiacion
        OPEN cuPlanFina(nuPLan_fina);
        FETCH cuPlanFina INTO ircPlan_financ;
        IF cuPlanFina%NOTFOUND THEN
        CLOSE cuPlanFina;
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                      'No se encontro el plan de financiacion numero: '||nuPLan_fina);
            raise ex.CONTROLLED_ERROR;
         END IF;
         CLOSE cuPlanFina;
         pkbcconftain.getinterestratebydate(ircPlan_financ.PLDITAIN, sysdate, rcConftain);
         -- BUSCO datos de la orden
        dtFecha       := daor_order.fdtgetcreated_date(nuorderid);
        nuPRODUCT_ID  := daor_order_activity.fnugetproduct_id(nucurractivityid);
        nuSUBSCRIBER_ID := daor_order_activity.fnugetsubscriber_id(nucurractivityid);
        if nuPRODUCT_ID is null then
           ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
              'No se puede generar cargos por que el producto de la orden es nulo');
           raise ex.CONTROLLED_ERROR;
       end if;
       -- BUSCO EL CICLO categoria y subcategoria  DEL PRODUCTO
           nuCate         := pktblservsusc.fnugetcategory(nuPRODUCT_ID);
            nuSuca         := pktblservsusc.fnugetsesusuca(nuPRODUCT_ID);

    -- SE INICIALIZA EL REGISTRO PARA CREAR EL MO_pACKAGES

        sbRequestXML1:=
         '<P_SOLICITUD_OT_AUTONOMAS_100256 ID_TIPOPAQUETE="100256">
         <CUSTOMER>'||nuSUBSCRIBER_ID||'</CUSTOMER>
         <PRODUCT>'||nuPRODUCT_ID||'</PRODUCT>
         <FECHA_DE_SOLICITUD>'||dtFecha||'</FECHA_DE_SOLICITUD>
         <ID>'||nuPersonId||'</ID>
         <POS_OPER_UNIT_ID>'||nuPtoAtncn||'</POS_OPER_UNIT_ID>
         <RECEPTION_TYPE_ID>10</RECEPTION_TYPE_ID>
         <CONTACT_ID>'||sbSubscriberId||'</CONTACT_ID>
         <ADDRESS_ID/>
         <COMMENT_>'||sbComment||'</COMMENT_>
     <M_AUTONOMAS_100252 />
         </P_SOLICITUD_OT_AUTONOMAS_100256> ';
    OS_RegisterRequestWithXML(sbRequestXML1, nuPackage_id,nuMotiveId,onuErrorCode, osbErrorMessage);
     ut_trace.trace('creo el tramite'||'-'||nuPackage_id, 10);
    -- actualiza la solicitud en la orden y el valor a cobrar
        daor_order_activity.updpackage_id(nucurractivityid, nuPackage_id);
    daor_order_activity.updmotive_id(nucurractivityid, nuMotiveId);
  --  daor_order.updORDER_VALUE(nuorderid, inuvalue);--
      -- genera cargos
    -- inicializar el registro para el plan de financiacion por motivo
    irccc_sales_financ_cond.PACKAGE_ID          :=   nuPackage_id;
        irccc_sales_financ_cond.FINANCING_PLAN_ID   :=   nuPLan_fina;
        irccc_sales_financ_cond.COMPUTE_METHOD_ID   :=   ircPlan_financ.PLDIMCCD;
        irccc_sales_financ_cond.INTEREST_RATE_ID    :=   ircPlan_financ.PLDITAIN;
        irccc_sales_financ_cond.FIRST_PAY_DATE      :=   sysdate;
        irccc_sales_financ_cond.PERCENT_TO_FINANCE  :=   100;
        irccc_sales_financ_cond.INTEREST_PERCENT    :=   rcConftain.cotiporc;
        irccc_sales_financ_cond.SPREAD              :=   0;
        irccc_sales_financ_cond.QUOTAS_NUMBER       :=   inuCuota;
        irccc_sales_financ_cond.TAX_FINANCING_ONE   :=   'N';
        irccc_sales_financ_cond.VALUE_TO_FINANCE    :=   inuvalue;
        irccc_sales_financ_cond.DOCUMENT_SUPPORT    :=   'OT-'||nuorderid;
        irccc_sales_financ_cond.INITIAL_PAYMENT     :=   0;
        irccc_sales_financ_cond.AVERAGE_QUOTE_VALUE :=   null;
        irccc_sales_financ_cond.FINAN_ID            :=   null;
                 ut_trace.trace('grabo el registro de financiacion', 10);
        dacc_sales_financ_cond.insrecord(irccc_sales_financ_cond);
        ut_trace.trace('grabo el cargo', 10);
        -- genera el cargo
        OS_CHARGETOBILL(nuPRODUCT_ID, nuConcepto, 0, nuCausalId, inuvalue, 'PP-'||nuPackage_id, null, onuerrorcode, osberrormessage);
         if (onuErrorCode <> 0) then
            gw_boerrors.checkerror(onuErrorCode, osbErrorMessage);
            raise ex.CONTROLLED_ERROR;
        end if;
        --Generar una factura con los cargos a la cuenta de cobro -1 generados por la legalizacion de la orden (estos se identifican
        --porque en la tabla CARGOS, en la tabla CARGDOSO tienen el prefijo "PP" mas el numero de la solicitud), usando el metodo:
        --Donde inuPackageID es un parametro de entrada que hace referencia al numero de la solicitud padre de la orden de trabajo
         CC_BOACCOUNTS.GENERATEACCOUNTBYPACK(nuPackage_id);
         --Realizar la financiacion de la factura mediante el metodo:
         cc_bofinancing.financingorder(nuPackage_id);

        ut_trace.trace('sali bn del cargo', 10);
    END IF;
    ut_trace.trace('final', 10);
EXCEPTION
    when ex.CONTROLLED_ERROR then
        ERRORS.seterror;
         RAISE ex.controlled_error;

   WHEN error_proceso
   THEN
      raise_application_error
                             (-20100,
                                 '[LDC_OBJ_LEG_MTTO_GENCOBRO]:'
                              || CHR (13)
                              || 'Excepcion no se pudo legalizar la orden : '
                              || onuerrorcode
                              || ' | '
                              || osberrormessage
                             );
   WHEN OTHERS
   THEN
      ERRORS.seterror;
      RAISE ex.controlled_error;
END LDC_OBJ_LEG_MTTO_GENCOBRO;
/

