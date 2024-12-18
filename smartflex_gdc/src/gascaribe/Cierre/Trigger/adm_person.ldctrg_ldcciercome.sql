CREATE OR REPLACE TRIGGER ADM_PERSON.LDCTRG_LDCCIERCOME
  BEFORE INSERT OR UPDATE ON ldc_ciercome
  REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW
  /************************************************************************************************************
  Propiedad intelectual PETI.

  Trigger  :  LDCTRG_certificado_tecnico

  Descripci?n  : Valida fecha inicial y final del periodo contable registrado

  Autor  : John Jairo Jimenez Marimon
  Fecha  : 07-08-2013

  Historia de Modificaciones
             Autor                Fecha        Caso     Descripcion
  John Jairo Jimenez Marimon  07/04/2022   CA - 223  Se valida que la fecha de ejecucion del cierre
                                                     sea mayor a la fecha fin del periodo contable                                   
 ****************************************************************************************************************/

DECLARE
  nuErrCode number;
  sbErrMsg  VARCHAR2(2000);
  sbIssue   VARCHAR2(4000);
  sbMessage VARCHAR2(4000);
  eerror    EXCEPTION;
  eerror2   EXCEPTION;
  eerror3   EXCEPTION;
  eerror4   EXCEPTION;
  eerror5   EXCEPTION;
  eerror6   EXCEPTION;
  eerror7   EXCEPTION;
  eerror8   EXCEPTION;
  eerror9   EXCEPTION;
  eerror10  EXCEPTION;
  nuconta   NUMBER DEFAULT 0;
  nuvano    NUMBER(4);
  nuvmes    NUMBER(4);
BEGIN
 ut_trace.trace('Inicio LDC_ciercome fin'||TRUNC(:NEW.cicofech)||' inicio '||TRUNC(:NEW.cicofein), 11);
  IF TRUNC(:NEW.cicofech)  <= trunc(:new.cicofein) THEN
   RAISE eerror;
  END IF;
  IF TRUNC(:NEW.cicohoej) IS NULL THEN
   RAISE eerror8;
  end IF;
  IF :NEW.cicomes < 1 OR :NEW.cicomes > 12 then
    RAISE eerror9;
  end IF;
  IF LENGTH(:NEW.cicoano) < 4 THEN
      RAISE eerror10;
  END IF;
    -- CA-223 JJJM 
  -- Validamos que la fecha ejecucion del cierre, no sea menor a la fecha fin del periodo contable
  IF TRUNC(:NEW.cicohoej) <= TRUNC(:NEW.cicofech) THEN
   RAISE eerror7;
  END IF;
  -- Cuando inserte
  IF inserting THEN
  -- Validamos que no exista un periodo no procesado
   SELECT COUNT(1) INTO nuconta
    FROM ldc_ciercome l
   WHERE l.cicoesta IN('N','n');
   IF nuconta > 0 THEN
    SELECT cicoano,cicomes INTO nuvano,nuvmes
      FROM ldc_ciercome l
     WHERE l.cicoesta IN('N','n');
     RAISE eerror5;
   END IF;
  -- Validamos que la fecha inicial no este en otro periodo
   SELECT COUNT(1) INTO nuconta
    FROM ldc_ciercome l
   WHERE TRUNC(:NEW.cicofein) BETWEEN TRUNC(l.cicofein) AND TRUNC(l.cicofech);
   IF nuconta > 0 THEN
      SELECT l.cicoano,l.cicomes INTO nuvano,nuvmes
        FROM ldc_ciercome l
       WHERE TRUNC(:NEW.cicofein) BETWEEN TRUNC(l.cicofein) AND TRUNC(l.cicofech);
       RAISE eerror2;
   END IF;
   -- Validamos que la fecha final no este en otro periodo
  SELECT COUNT(1) INTO nuconta
    FROM ldc_ciercome l
   WHERE TRUNC(:NEW.cicofech) BETWEEN TRUNC(l.cicofein) AND TRUNC(l.cicofech);
   IF nuconta > 0 THEN
      SELECT l.cicoano,l.cicomes INTO nuvano,nuvmes
        FROM ldc_ciercome l
       WHERE TRUNC(:NEW.cicofech) BETWEEN TRUNC(l.cicofein) AND TRUNC(l.cicofech);
       RAISE eerror3;
   END IF;
   :NEW.cicoesta := 'N';
  END IF;
IF UPDATING THEN
  IF :old.cicoesta IN('S','s') THEN
   IF :old.cicoano <> :NEW.cicoano OR :old.cicomes <> :NEW.cicomes OR :old.cicoesta <> :NEW.cicoesta OR :old.cicofein <> :NEW.cicofein OR :old.cicofech <> :NEW.cicofech OR :old.cicohoej <> :NEW.cicohoej THEN
   RAISE eerror6;
  END IF;
 END IF;
END IF;
EXCEPTION
 WHEN eerror THEN
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, ' La fecha final del periodo contable no puede ser menor o igual a la fecha inicial del periodo contable.');
     ut_trace.trace('ldc_ciercome '||TRUNC(:NEW.cicofech)||' fin '||TRUNC(:NEW.cicofein), 11);
 WHEN eerror2 THEN
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'La fecha inicial del periodo contable '||:NEW.cicofein||' est? contenida en el periodo contable : '||nuvano||'-'||nuvmes);
   ut_trace.trace('Periodo '||:NEW.cicoano||'-'||:NEW.cicomes, 11);
 WHEN eerror3 THEN
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'La fecha final del periodo contable '||:NEW.cicofech||' est? contenida en el periodo contable : '||nuvano||'-'||nuvmes);
   ut_trace.trace('Periodo '||:NEW.cicoano||'-'||:NEW.cicomes, 11);
 WHEN eerror4 THEN
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El periodo contable : '||:NEW.cicoano||'-'||:NEW.cicomes||' esta procesado, no es posible modIFicar los datos.');
   ut_trace.trace('Periodo '||:NEW.cicoano||'-'||:NEW.cicomes, 11);
 WHEN eerror5 THEN
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El periodo contable : '||nuvano||'-'||nuvmes||' esta no-procesado, no es posible crear otro periodo contable en el mismo estado.');
   ut_trace.trace('Periodo '||:NEW.cicoano||'-'||:NEW.cicomes, 11);
 WHEN eerror6 THEN
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'No es posible modIFicar los datos del periodo contable : '||:NEW.cicoano||' '||:NEW.cicomes||' este periodo se encuentra cerrado.');
   ut_trace.trace('Periodo '||:NEW.cicoano||'-'||:NEW.cicomes, 11);
 WHEN eerror7 THEN
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'La fecha de ejecuci?n no debe ser igual o menor a la fecha final del periodo contable.');
   ut_trace.trace('Periodo '||:NEW.cicoano||'-'||:NEW.cicomes, 11);
WHEN eerror8 THEN
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'La fecha de ejecuci?n no debe estar vac?a.');
   ut_trace.trace('Periodo '||:NEW.cicoano||'-'||:NEW.cicomes, 11);
WHEN eerror9 THEN
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'Los meses deben estar comprendidos entre 1 y 12.');
   ut_trace.trace('Periodo '||:NEW.cicoano||'-'||:NEW.cicomes, 11);
WHEN eerror10 THEN
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error, 'El a?o debe ser de 4 digitos');
   ut_trace.trace('Periodo '||:NEW.cicoano||'-'||:NEW.cicomes, 11);
  WHEN OTHERS THEN
    pkErrors.GetErrorVar(nuErrCode, sbErrMsg);
END LDCTRG_LDCCIERCOME;
/

