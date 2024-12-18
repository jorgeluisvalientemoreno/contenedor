CREATE OR REPLACE TRIGGER adm_person.ldctrg_ldcresolsui
  BEFORE INSERT OR UPDATE OR DELETE ON ldc_suia_resolucion
  REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW
  /**************************************************************
  Propiedad intelectual JM GESTIONINFORMATICA S.A.S.

  Trigger  :  LDCTRG_ldcresolsui

  Descripción  : Valida fecha inicial y final de la vigencia de la resolución

  Autor  : John Jairo Jimenez Marimon
  Fecha  : 27-04-2016

  Historia de Modificaciones
  18/10/2024    jpinedc     OSF-3383    Se migra a ADM_PERSON
  **************************************************************/

DECLARE
  nuErrCode    NUMBER;
  sbErrMsg     VARCHAR2(2000);
  eerror       EXCEPTION;
  eerror2      EXCEPTION;
  eerror3      EXCEPTION;
  eerror4      EXCEPTION;
  nuresolucion ldc_suia_resolucion.resolucion%TYPE;
BEGIN
 ut_trace.trace('Inicio ldc_suia_resolucion fin'||trunc(:new.fecha_ini_vige)||' inicio '||trunc(:new.fecha_fin_vige), 11);
 IF inserting OR updating THEN
  IF trunc(:new.fecha_fin_vige)  <= trunc(:new.fecha_ini_vige) THEN
   RAISE eerror;
  END IF;
   -- Validamos que la fecha inicial no este en otro periodo
   nuresolucion := NULL;
   BEGIN
    SELECT l.resolucion INTO nuresolucion
      FROM ldc_suia_resolucion l
     WHERE trunc(:new.fecha_ini_vige) BETWEEN trunc(l.fecha_ini_vige) AND trunc(l.fecha_fin_vige);
   EXCEPTION
    WHEN no_data_found THEN
     NULL;
   END;
   IF nuresolucion IS NOT NULL THEN
    RAISE eerror2;
   END IF;
   -- Validamos que la fecha final no este en otro periodo
   nuresolucion := NULL;
   BEGIN
    SELECT l.resolucion INTO nuresolucion
      FROM ldc_suia_resolucion l
     WHERE trunc(:new.fecha_fin_vige) BETWEEN trunc(l.fecha_ini_vige) AND trunc(l.fecha_fin_vige);
   EXCEPTION
    WHEN no_data_found THEN
     NULL;
   END;
   IF nuresolucion IS NOT NULL THEN
    RAISE eerror3;
   END IF;
ELSIF DELETING THEN
  RAISE eerror4;
END IF;
EXCEPTION
 WHEN eerror THEN
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, ' La fecha final de vigencia no puede ser menor o igual a la fecha inicial de vigencia.');
     ut_trace.trace('ldc_suia_resolucion '||trunc(:new.fecha_fin_vige)||' fin '||trunc(:new.fecha_ini_vige), 11);
 WHEN eerror2 THEN
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'La fecha inicial de vigencia '||:new.fecha_ini_vige||' est¿ contenida en la vigencia de la resolucion : '||nuresolucion);
   ut_trace.trace('Resolucion '||nuresolucion, 11);
 WHEN eerror3 THEN
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'La fecha final de vigencia '||:new.fecha_fin_vige||' est¿ contenida en la vigencia de la resolucion : '||nuresolucion);
   ut_trace.trace('Resolucion '||nuresolucion, 11);
 WHEN eerror4 THEN
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'No es posible borrar el registro. Comuniquese con informatica.');
   ut_trace.trace('Resolucion '||:old.resolucion, 11);
  WHEN OTHERS THEN
    pkErrors.GetErrorVar(nuErrCode, sbErrMsg);
END;
/
