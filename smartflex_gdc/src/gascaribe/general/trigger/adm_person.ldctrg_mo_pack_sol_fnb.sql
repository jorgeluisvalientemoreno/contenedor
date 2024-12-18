CREATE OR REPLACE TRIGGER adm_person.ldctrg_mo_pack_sol_fnb
  BEFORE INSERT ON mo_packages
  REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW
  /**************************************************************
  Propiedad intelectual HORBART S.A.S.

  Trigger  :  ldctrg_mo_pack_sol_fnb

  Descripción  : Valida actualización del medio de recepción.

  Autor  :
  Fecha  : 21-07-2016

  Historia de Modificaciones
  21/10/2024        jpinedc     OSF-3450: Se migra a ADM_PERSON
  **************************************************************/
DECLARE
 nuvarventafnb  ld_parameter.numeric_value%TYPE;
 nuvarvgcot     ld_parameter.numeric_value%TYPE;
 nuvarmedrecep  ge_reception_type.reception_type_id%TYPE;
 nucoderror     NUMBER(10);
 sbmensajeerror VARCHAR2(1000);
 eerror         EXCEPTION;
BEGIN
 nuvarventafnb := dald_parameter.fnuGetNumeric_Value('TIPO_SOL_VENTA_FNB',NULL );
 nuvarvgcot    := dald_parameter.fnuGetNumeric_Value('COD_VENTA_COTIZADA',NULL );
 IF :new.package_type_id = nuvarventafnb THEN
  nuvarmedrecep := ldc_validasoliventafnbmere(:new.subscription_pend_id);
  IF nuvarmedrecep IN(-1,-2) THEN
    NULL;
  ELSE
   :new.reception_type_id := nuvarmedrecep;
  END IF;
 END IF;
 IF :new.package_type_id = nuvarvgcot THEN
   ldc_procvalidafununidoper(:new.pos_oper_unit_id,:new.person_id,nucoderror,sbmensajeerror);
  IF nucoderror <> 0 THEN
   RAISE eerror;
  END IF;
 END IF;
EXCEPTION
 WHEN eerror THEN
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,sbmensajeerror);
   ut_trace.trace('Unit '||:new.pos_oper_unit_id||'-'||:new.person_id, 11);
 WHEN OTHERS THEN
  NULL;
END;
/
