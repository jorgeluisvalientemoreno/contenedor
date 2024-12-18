CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_PRACTUALIZAORANPU(inuIdOrder      IN or_order.order_id%TYPE,
                                                    inuCurrent      IN NUMBER,
                                                    inuTotal        IN NUMBER,
                                                    onuErrorCode    OUT NUMBER,
                                                    osbErrorMessage OUT VARCHAR) is
  /*****************************************************************

  Unidad         : LDC_PRACTUALIZAORANPU
  Descripcion    : Procedimiento para legalizar las ordenes de anulacion de pagare unico
  Autor          : Roberto Parra
  Fecha          : 26/02/2018

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor                 Modificacion
  =========       =========              ====================
  ******************************************************************/
  --Variables Generales
  cnuNULL_ATTRIBUTE constant number := 2126;
  sbCAUSAL_TYPE_ID ge_boInstanceControl.stysbValue;
  nuError          number(10);
  sbMessage        varchar(2000);
  rcMoPackage       damo_packages.styMO_packages;


  CURSOR rfCursor IS
    SELECT oa.package_id,
           o.operating_unit_id,
           o.order_id ORDEN,
           oa.package_id SOLICITUD,
           oa.subscription_id CONTRATO
      FROM or_order o, or_order_activity oa
     where o.order_id = oa.order_id
       and o.order_id = inuIdOrder;

BEGIN

  sbCAUSAL_TYPE_ID := ge_boInstanceControl.fsbGetFieldValue('GE_CAUSAL',
                                                            'CAUSAL_TYPE_ID');

  ------------------------------------------------
  -- Required Attributes
  ------------------------------------------------

  if (sbCAUSAL_TYPE_ID is null) then
    Errors.SetError(cnuNULL_ATTRIBUTE, 'Tipo de causal');
    raise ex.CONTROLLED_ERROR;
  end if;
  ------------------------------------------------
  -- User code
  ------------------------------------------------

  for reg in rfCursor loop
    --Se legaliza la orden
    os_legalizeorderallactivities(inuIdOrder,
                                  sbCAUSAL_TYPE_ID,
                                  LD_BOUtilFlow.fnuGetPersonToLegal(reg.operating_unit_id),
                                  sysdate,
                                  sysdate,
                                  'ANULACION DE SOLICITUD DE PAGARE UNICO POR LA FORMA LDORANPU',
                                  null,
                                  nuError,
                                  sbMessage);
    if (nuError <> 0) then

      --Se inserta el error en una tabla
      LDC_PROINSERTAERRPAGAUNI(reg.contrato,
                               reg.orden,
                               reg.solicitud,
                               userenv('SESSIONID'),
                               user,
                               nuError,
                               sbMessage,
                               'LDORANPU');
      rollback;
    else

      if open.DALD_PARAMETER.fnuGetNumeric_Value('COD_IDE_CLA_CAU_EXITO') =
         open.DAGE_CAUSAL.FNUGETCLASS_CAUSAL_ID(sbCAUSAL_TYPE_ID, null) then

             damo_packages.getRecord(reg.package_id, rcMopackage);

        LDC_PKVENTAPAGOUNICO.PROCCAMBESTPAGUNI(rcMopackage.interface_history_id );
      end if;

      --Se atiende la solicitud
      CF_BOActions.AttendRequest(reg.package_id);
      commit;
    end if;
  end loop;

EXCEPTION

  when ex.CONTROLLED_ERROR then
    raise;

  when OTHERS then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;
END;
/
PROMPT Otorgando permisos de ejecucion a LDC_PRACTUALIZAORANPU
BEGIN
  pkg_utilidades.prAplicarPermisos('LDC_PRACTUALIZAORANPU','ADM_PERSON');
END;
/


