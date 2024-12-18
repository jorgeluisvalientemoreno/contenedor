CREATE OR REPLACE PROCEDURE ldc_prAsociaPeriodoGracia(inuPackageId IN open.mo_packages.package_id%TYPE) IS
    /**************************************************************************
    Propiedad Intelectual de Gases del caribe S.A E.S.P

    Nombre      : ldc_prAsociaPeriodoGracia
    Caso        : SN-611       
    Descripcion : Procedimiento que validar si se debe generar periodo de gracia el usuario debe estar marcado
                  en el comentario de la solicitud y no debe tener orden 12162 legalizada con causal 9944

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
   **************************************************************************/

  CURSOR cuValidaCertif(nuSolicitud open.mo_packages.package_id%type) is
  select count(1)
  from or_order
  inner join open.or_order_activity on or_order.order_id=or_order_activity.order_id and or_order_activity.package_id=nuSolicitud
  where or_order.task_type_id=12162
    and or_order.order_status_id=8
    and or_order.causal_id=9944;

 CURSOR cuGetPlanDife(nuSolicitud open.mo_packages.package_id%type) is
 select cc_sales_financ_cond.financing_plan_id
 from open.cc_sales_financ_cond
 where cc_sales_financ_cond.package_id=nuSolicitud;

  sbIsMarked        VARCHAR2(1);
  nuCertificado     NUMBER:=0;
  nuFinaPlan        open.cc_sales_financ_cond.financing_plan_id%type;
  nuPeriGracia      open.ld_parameter.numeric_value%type:=open.DALD_PARAMETER.fnuGetNumeric_Value('COD_PERI_GRACIA_PILOTO_SN_CES',NULL);

BEGIN
  ut_trace.trace('Inicio ldc_prAsociaPeriodoGracia', 99);
  ut_trace.trace('inuPackageId:'||inuPackageId, 99);
  ut_trace.trace('nuPeriGracia:'||nuPeriGracia, 99);


  IF nuPeriGracia IS NULL THEN
    RETURN;
  END IF;
  
  sbIsMarked := ldc_fsbIsSolMarkedPilotoSN(inuPackageId);
  ut_trace.trace('sbIsMarked:'||sbIsMarked, 99);

  OPEN cuValidaCertif(inuPackageId);
  FETCH cuValidaCertif INTO nuCertificado;
  CLOSE cuValidaCertif;
  ut_trace.trace('nuCertificado:'||nuCertificado, 99);

  IF sbIsMarked='S' and nuCertificado=0 THEN

    IF cuGetPlanDife%ISOPEN THEN
      CLOSE cuGetPlanDife;
    END IF;

    OPEN cuGetPlanDife(inuPackageId);
    FETCH cuGetPlanDife INTO nuFinaPlan;
    IF cuGetPlanDife%NOTFOUND THEN

      ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,'No se encontro el plan financiero');
      RAISE ex.controlled_error;

    END IF;
    CLOSE cuGetPlanDife;

    ut_trace.trace('nuFinaPlan:'||nuFinaPlan, 99);

    UPDATE plandife
    SET plandife.pldipegr = nuPeriGracia
    WHERE plandife.pldicodi = nuFinaPlan
    AND plandife.pldipegr IS NULL;
    
  END IF;
  ut_trace.trace('Fin ldc_prAsociaPeriodoGracia', 99);
EXCEPTION
 WHEN ex.controlled_error THEN
  ut_trace.trace('Error ex.controlled_error', 10);
  RAISE;
 WHEN OTHERS THEN
  errors.seterror;
  ut_trace.trace('Error others', 10);  
  RAISE ex.controlled_error;
END;
/
GRANT EXECUTE on ldc_prAsociaPeriodoGracia to SYSTEM_OBJ_PRIVS_ROLE;
/