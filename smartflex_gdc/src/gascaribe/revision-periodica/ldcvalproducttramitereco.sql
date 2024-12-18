CREATE OR REPLACE PROCEDURE LDCVALPRODUCTTRAMITERECO(pProductID PR_PRODUCT.PRODUCT_ID%type) AS
    /**************************************************************************
    Propiedad Intelectual de HORBATH TECHNOLOGIES

    Funcion     :  LDCVALPRODUCTTRAMITERECO
    Descripcion :  Validaciones:
                 :POR CNCRM SOLO SE PUEDE GENERAR RECONEXION SI EL PRODUCTO ESTA SUSPENDIDO POR ACOMETIDA 12457
                O SI EL CERTIFICADO VIGENTE ES DE UN TERCERO.
    Autor       : Josh Brito
    Fecha       : 13-03-2018

    Historia de Modificaciones
      Fecha               Autor                Modificacion
      24/01/2019          elal              caso 200-2231 se coloca parametro TITR_SUS_NO_VALIDO_TRAMITE_RP
    09/12/2020          ljlb                CA 337 se coloca validacion de producto excluido
    07/04/2022          dsaltarin           OSF-213: Se agrega validacion de castigado
    25/06/2022          Jorge Valiente      OSF-369: Realizar el llamado del servicio LDC_FNUCUENTASSALDOSPRODUCTO para que valide el producto del usuario y si
                                                     tiene 2 o mas cuentas de cobro con saldo debe levantar error indicando que ?No se puede generar tramite
                                                     porque el usuario tiene saldo pendiente?.
    09/08/2022          Jorge Valiente      OSF-479: Aplicar nueva logica donde se validen las cuentas de cobro con saldo obtenidas del servicio LDC_FNUCUENTASSALDOSPRODUCTO con el valor 
                                                     del parametro CANT_CTA_SALDO_RESTR_RECON del OSF-369.
    =========           =========          ====================
    **************************************************************************/
    nuProductId         PR_PRODUCT.PRODUCT_ID%type;  -- := 471702;
    nuProductStatus     pr_product.product_status_id%type;
    sbmensamen          VARCHAR2(4000);
    nuMarca101          open.ge_suspension_type.suspension_type_id%type;
    nuMarca102          open.ge_suspension_type.suspension_type_id%type;
    nuMarca103          open.ge_suspension_type.suspension_type_id%type;
    nuMarca104          open.ge_suspension_type.suspension_type_id%type;
    TIPO_SUSPENSION     open.ge_suspension_type.suspension_type_id%type;
    sbTipoSoliSuspe      open.ld_parameter.value_chain%type:=DALD_PARAMETER.fsbGetValue_Chain('TIPO_SOL_CERRAR_SUSPENSION',NULL);
    nuCantOt            number;
    nuTitrSusp          open.or_task_type.task_type_id%type;
    nuOrderActCert      open.or_order_activity.order_activity_id%type;
    nuUltActSuspension  open.or_order_activity.order_activity_id%type;
    nuUnidad            open.or_order.operating_unit_id%type;
    numes               NUMBER(2);



   cursor cuTipoTrabSusp(inuOrderActivId open.or_order_activity.order_activity_id%type) is
     select task_type_id
       from open.or_order_activity
    where order_activity_id=inuOrderActivId;

   cursor cuUnidad(inuOrderActivId open.or_order_activity.order_activity_id%type) is
   select o.operating_unit_id
     from open.or_order_activity a, open.or_order o, open.or_operating_unit u
  where a.order_id=o.order_id
    and a.order_activity_id=inuOrderActivId
    and o.operating_unit_id=u.operating_unit_id
    and u.contractor_id is null
    and o.operating_unit_id != 1;

    sbTipoSusp VARCHAR2(400) := dald_parameter.fsbgetvalue_chain('TITR_SUS_NO_VALIDO_TRAMITE_RP', NULL); --TICKET 200-2231 ELAL -- se coloca parametro que tiene tipo de trabajo dde susp
    ---213
    sbCasgigado VARCHAR2(100);

  --Inicio OSF-479
  nuCANT_CTA_SALDO_RESTR_RECON LDC_PARAREPE.PAREVANU%type := daldc_pararepe.fnuGetPAREVANU('CANT_CTA_SALDO_RESTR_RECON',null);
  --Fin OSF-479
  
begin
    nuProductId := pProductID;
    ut_trace.trace('LDCVALPRODUCTTRAMITERECO-nuProductId -->'||nuProductId, 10);

  --INICIO CA 337
  IF FBLAPLICAENTREGAXCASO('0000337') THEN
    IF LDC_PKGESTPREXCLURP.FUNVALEXCLURP(nuProductId) > 0 THEN
      ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,'Producto ['||nuProductId||'] se encuentra excluido para el proceso de RP');
    END IF;
  END IF;
  --FIN CA 337
    if instr(DALD_PARAMETER.fsbGetValue_Chain('LDC_PAR_INSTANCIA',NULL),ut_session.getmodule)!=0 then

        nuProductStatus := dapr_product.fnugetproduct_status_id(nuProductId, null);
        ut_trace.trace('LDCVALPRODUCTTRAMITERECO-nuProductStatus -->'||nuProductStatus, 10);

        nuUltActSuspension := dapr_product.fnugetsuspen_ord_act_id(nuProductId, null);
        numes := open.DALD_PARAMETER.fnuGetNumeric_Value('LDC_PARNUMMESESVAL');
        ut_trace.trace('ldcprocdeletmarcausercertifi-numes -->'||numes, 10);

        IF OPEN.fblAplicaEntrega('OSS_RPS_JGBA_2001871_1') THEN
          nuMarca101 := open.DALD_PARAMETER.FNUGETNUMERIC_VALUE('MARCA_PRODUCTO_101');
          nuMarca102 := open.DALD_PARAMETER.FNUGETNUMERIC_VALUE('MARCA_PRODUCTO_102');
          nuMarca103 := open.DALD_PARAMETER.FNUGETNUMERIC_VALUE('SUSPENSION_TYPE_CERTI');
          nuMarca104 := open.DALD_PARAMETER.FNUGETNUMERIC_VALUE('MARCA_PRODUCTO_104');
          IF nuProductStatus != 2 THEN
              sbmensamen := 'El estado del producto es diferente de  2-Suspendido';
              ut_trace.trace('LDCVALPRODUCTTRAMITERECO-->'||sbmensamen, 10);
              DBMS_OUTPUT.PUT_LINE(sbmensamen);
              ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensamen);
              RAISE ex.controlled_error;
          END IF;
          IF nuUltActSuspension is null THEN
             sbmensamen := 'El producto no tiene ultima actividad de suspension';
             ut_trace.trace('LDCVALPRODUCTTRAMITERECO-->'||sbmensamen, 10);
             DBMS_OUTPUT.PUT_LINE(sbmensamen);
             ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensamen);
             RAISE ex.controlled_error;
          END IF;

          BEGIN
              SELECT SUSPENSION_TYPE_ID
                INTO TIPO_SUSPENSION
               FROM OPEN.PR_PROD_SUSPENSION
              WHERE PRODUCT_ID = pProductID
                --AND SUSPENSION_TYPE_ID IN (nuMarca101, nuMarca102, nuMarca103, nuMarca104)
                AND ACTIVE = 'Y'
                AND ROWNUM=1;
          EXCEPTION
              WHEN OTHERS THEN
                   TIPO_SUSPENSION := 1;
          END;
          IF TIPO_SUSPENSION not in (nuMarca101, nuMarca102, nuMarca103, nuMarca104) then
             sbmensamen := 'El producto no se encuentra suspendido por Revision Segura';
             ut_trace.trace('LDCVALPRODUCTTRAMITERECO-->'||sbmensamen, 10);
             DBMS_OUTPUT.PUT_LINE(sbmensamen);
             ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensamen);
             RAISE ex.controlled_error;
          End if;

          open cuTipoTrabSusp(nuUltActSuspension);
          fetch cuTipoTrabSusp into nuTitrSusp;
          close cuTipoTrabSusp;

          BEGIN
            SELECT ORDER_ACT_CERTIF_ID--, PACKAGE_ID
                INTO nuOrderActCert
            FROM(SELECT ORDER_ACT_CERTIF_ID, PACKAGE_ID
               FROM PR_CERTIFICATE WHERE PRODUCT_ID = nuProductId
               AND ORDER_ACT_CANCEL_ID IS NULL
               AND ESTIMATED_END_DATE >= ADD_MONTHS(SYSDATE, numes)
               ORDER BY REGISTER_DATE DESC)
            WHERE ROWNUM =1;
          EXCEPTION
              WHEN OTHERS THEN
                nuOrderActCert:=NULL;
          END;
          if nuOrderActCert is not null then
            open cuUnidad(nuOrderActCert);
            fetch cuUnidad into nuUnidad;
            close cuUnidad;
          else
            nuUnidad:=null;
          end if;
         --TICKET 200-2231 ELAL -- se cambio codicion agregando el parametro
          if nuUnidad is null and INSTR(sbTipoSusp,nuTitrSusp) = 0 then
            sbmensamen := 'El producto no se encuentra suspendido con tipo de trabajo '||sbTipoSusp||' SUSPENSION DESDE ACOMETIDA POR NO CERTIFICADO O CERTIFICADO POR TERCERO';
                  ut_trace.trace('LDCVALPRODUCTTRAMITERECO-->'||sbmensamen, 10);
                  DBMS_OUTPUT.PUT_LINE(sbmensamen);
                  ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensamen);
                  RAISE ex.controlled_error;
          end if;
        END IF;
    end if;

    sbCasgigado:=FUNVALUSUARIOCASTGSUSPTO(nuProductId);
    IF ( sbCasgigado = 'SI' ) THEN
       GE_BOERRORS.SETERRORCODEARGUMENT(2741, 'El tr'||chr(225)||'mite no se pude generar porque su estado de corte es igual a [5 - SUSPESI'||chr(211)||'N TOTAL] y/o su estado financiero es igual a CASTIGADO');
    END IF;

    --Inicio OSF-369
    --OSF-479 Se agrega parametro nuCANT_CTA_SALDO_RESTR_RECON
    IF FBLAPLICAENTREGAXCASO('OSF-369') THEN
      if LDC_FNUCUENTASSALDOSPRODUCTO(pProductID) >= nuCANT_CTA_SALDO_RESTR_RECON and instr(DALD_PARAMETER.fsbGetValue_Chain('LDC_PAR_INSTANCIA',NULL),ut_session.getmodule)!=0 then
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,'No se puede generar tramite porque el usuario tiene saldo pendiente');
        RAISE ex.controlled_error;
      end if;
    end if;
    --Fin OSF-369

EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise;
    when others then
      Errors.setError;
      raise ex.CONTROLLED_ERROR;
END ldcvalproducttramitereco;
/
