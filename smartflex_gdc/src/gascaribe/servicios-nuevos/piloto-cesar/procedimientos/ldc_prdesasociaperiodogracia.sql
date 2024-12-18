CREATE OR REPLACE PROCEDURE ldc_prDesAsociaPeriodoGracia(inuPackageId IN open.mo_packages.package_id%TYPE) IS
    /**************************************************************************
    Propiedad Intelectual de Gases del caribe S.A E.S.P

    Nombre      : ldc_prDesAsociaPeriodoGracia
    Caso        : SN-611    
    Descripcion : Procedimiento que quita el periodo de gracia

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
   **************************************************************************/
 CURSOR cuGetPlanDife(nuSolicitud open.mo_packages.package_id%type) is
 select cc_sales_financ_cond.financing_plan_id
 from open.cc_sales_financ_cond
 where cc_sales_financ_cond.package_id=nuSolicitud;

  sbIsMarked        VARCHAR2(1);
  nuFinaPlan        open.cc_sales_financ_cond.financing_plan_id%type;
  nuPeriGracia      open.ld_parameter.numeric_value%type:=open.DALD_PARAMETER.fnuGetNumeric_Value('COD_PERI_GRACIA_PILOTO_SN_CES',NULL);

BEGIN
  
   ut_trace.trace('Inicio ldc_prDesAsociaPeriodoGracia', 99);
   ut_trace.trace('inuPackageId:'||inuPackageId, 99);
   ut_trace.trace('nuPeriGracia:'||nuPeriGracia, 99);

   IF nuPeriGracia IS NULL THEN
    RETURN;
   END IF;   
   
  sbIsMarked := ldc_fsbIsSolMarkedPilotoSN(inuPackageId);
  ut_trace.trace('sbIsMarked:'||sbIsMarked, 99);   
  
  IF sbIsMarked = 'S'  THEN

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
        SET plandife.pldipegr = NULL
    WHERE plandife.pldicodi = nuFinaPlan
      AND plandife.pldipegr = nuPeriGracia;

  END IF;
  ut_trace.trace('Fin ldc_prDesAsociaPeriodoGracia', 99);
EXCEPTION
 WHEN ex.controlled_error THEN
  ut_trace.trace('Error ldc_prDesAsociaPeriodoGracia ex.controlled_error', 10);
  RAISE;
 WHEN OTHERS THEN
  ut_trace.trace('Error ldc_prDesAsociaPeriodoGracia others', 10);
  errors.seterror;
  RAISE ex.controlled_error;
END;
/
GRANT EXECUTE on ldc_prDesAsociaPeriodoGracia to SYSTEM_OBJ_PRIVS_ROLE;
/