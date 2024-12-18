CREATE OR REPLACE TRIGGER LDCTRG_certificado_tecnico
  before insert or update on ldc_certificado
  referencing old as old new as new for each row
  /**************************************************************
  Propiedad intelectual PETI.

  Trigger  :  LDCTRG_certificado_tecnico

  Descripci¿n  : Valida fecha inicial y final de vigencia en los certificados

  Autor  : John Jairo Jimenez Marimon
  Fecha  : 07-03-2013

  Historia de Modificaciones
  **************************************************************/

DECLARE
  nuErrCode number;
  sbErrMsg  VARCHAR2(2000);
  sbIssue   VARCHAR2(4000);
  sbMessage VARCHAR2(4000);
  eerror    exception;
  eerror2   exception;
  eerror3   exception;
BEGIN
 ut_trace.trace('Inicio LDC_certificado fin'||trunc(:new.fecha_fin_vig)||' inicio '||trunc(:new.fecha_ini_vig), 11);
  IF trunc(:new.fecha_fin_vig)  <= trunc(:new.fecha_ini_vig) THEN
   raise eerror;
  END IF;
  IF :new.id_norma IS NULL AND (:new.id_titulacion is not null AND :new.id_titulacion <> '-1') then
     :new.tipo_certificado := 'T';
  END IF;
  IF :new.id_titulacion IS NULL THEN
     :new.id_titulacion := '-1';
  END IF;
  IF :new.id_titulacion = '-1' AND (:new.id_norma is not null AND :new.id_norma <> '-1')then
     :new.tipo_certificado := 'N';
  END IF;
  IF (:new.id_norma is not null AND :new.id_norma <> '-1') AND (:new.id_titulacion is not null AND :new.id_titulacion <> '-1') THEN
      RAISE eerror2;
  END IF;
  IF :new.tipo_certificado = 'T' AND (:new.id_titulacion is null OR :new.id_titulacion = '-1') THEN
     RAISE eerror3;
  END IF;
EXCEPTION
 when eerror then
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'Certificado : '||:new.id_certificado||' La fecha final de vigencia no puede ser menor o igual a la inicial.');
     ut_trace.trace('certificado '||trunc(:new.fecha_fin_vig)||' fin '||trunc(:new.fecha_ini_vig), 11);
 when eerror2 then
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El certificado debe generarse por norma.');
   ut_trace.trace('certificado '||:new.id_certificado, 11);
 when eerror3 then
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El certificado debe generarse por titulacion.');
   ut_trace.trace('certificado '||:new.id_certificado, 11);
  WHEN OTHERS THEN
    pkErrors.GetErrorVar(nuErrCode, sbErrMsg);
END LDCTRG_certificado_tecnico;
/
