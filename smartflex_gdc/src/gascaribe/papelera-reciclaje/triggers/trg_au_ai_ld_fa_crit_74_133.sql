CREATE OR REPLACE TRIGGER OPEN.TRG_AU_AI_LD_FA_CRIT_74_133 AFTER INSERT OR UPDATE OR DELETE ON OPEN.LD_FA_CRITDESC
  REFERENCING   OLD   AS   OLD   NEW   AS   NEW  
 FOR EACH ROW
DECLARE 
AUDIT_POLICY_IDvar AU_AUDIT_POLICY_LOG.AUDIT_POLICY_ID%type := 74;
AUDIT_LOG_IDvar AU_LOG_POLICY.AUDIT_LOG_ID%type := 133;
AUDIT_POLICY_LOG_IDvar AU_AUDIT_POLICY_LOG.AUDIT_POLICY_LOG_ID%type :=null;
CURRENT_TABLE_NAMEvar AU_AUDIT_POLICY_LOG.CURRENT_TABLE_NAME%type := 'LD_FA_CRITDESC';
CURRENT_EVEN_DESCvar AU_AUDIT_POLICY_LOG.CURRENT_EVEN_DESC%type := 'INSERT OR UPDATE OR DELETE';
XML_LOGvar AU_AUDIT_POLICY_LOG.XML_LOG%type :=null;
CURRENT_FIELD_NAMEvar AU_AUDIT_POLICY_LOG.CURRENT_FIELD_NAME%type :=null;
EXTERNAL_IDvar AU_AUDIT_POLICY_LOG.EXTERNAL_ID%type :=null;
blExistAditiDATA    boolean := FALSE;

type tyrcFIELD IS RECORD
(
    FieldName          varchar2(32767),
    OldValue           varchar2(32767),
    NewValue           varchar2(32767),
    IsMonitored        varchar2(1),
    AttrTypeId         number
);

type tytbFIELDs is table of tyrcFIELD index by binary_integer;
tbFIELD     tytbFIELDs;
nuCampoInd  binary_integer;
--Valida que al menos un campo haya cambiado.
FUNCTION fblValHasChange return boolean
IS
BEGIN
       nuCampoInd := tbFIELD.first;
        LOOP
    exit when nuCampoInd IS null;
      --Si el campo es monitoreado y ha cambiado su valor.
      IF tbFIELD(nuCampoInd).IsMonitored = 1 AND
         ( UPDATING(tbFIELD(nuCampoInd).FieldName)  AND
         ( ( tbFIELD(nuCampoInd).OldValue IS NULL AND tbFIELD(nuCampoInd).NewValue IS NOT NULL)  OR
           ( tbFIELD(nuCampoInd).OldValue IS NOT NULL AND tbFIELD(nuCampoInd).NewValue IS NULL)  OR
           ( tbFIELD(nuCampoInd).OldValue != tbFIELD(nuCampoInd).NewValue)))
      THEN
        return TRUE;
      END if;
    nuCampoInd := tbFIELD.next(nuCampoInd);
  END LOOP;
  return FALSE;
END fblValHasChange;

 
BEGIN 
     -- checks if the audit policy is enabled BY time
       AU_BOAuditPolicy.setid(AUDIT_POLICY_IDvar);
      if NOT AU_BOAuditPolicy.IsAuditPolicyEnabledbyDate(sysdate) then
            return;
      end if;
    -- checks if user is audited BY the Audit Policy
      AU_BOAuditPolicy.setid(AUDIT_POLICY_IDvar);
      if NOT AU_BOAuditPolicy.isAuditPolicyEnabledbyUser(AU_BOSystem.getSystemUserID) then
            return;
      end if;
    -- checks if user the current process is audited BY the Audit Policy
      if NOT AU_BOAuditPolicy.isProcessAuditedbyPolicy(AUDIT_LOG_IDvar, SA_BOSystem.getsystemprocessid) then
            return;
      end if;

      tbFIELD(1).FieldName := 'CRDECODE';
      tbFIELD(1).OldValue := to_char(:OLD.CRDECODE);
      tbFIELD(1).NewValue := to_char(:NEW.CRDECODE);
      tbFIELD(1).IsMonitored := 1;
      tbFIELD(1).AttrTypeId := 1;
      -----------------------
      tbFIELD(2).FieldName := 'CRDEGELO';
      tbFIELD(2).OldValue := to_char(:OLD.CRDEGELO);
      tbFIELD(2).NewValue := to_char(:NEW.CRDEGELO);
      tbFIELD(2).IsMonitored := 1;
      tbFIELD(2).AttrTypeId := 1;
      -----------------------
      tbFIELD(3).FieldName := 'CRDECATE';
      tbFIELD(3).OldValue := to_char(:OLD.CRDECATE);
      tbFIELD(3).NewValue := to_char(:NEW.CRDECATE);
      tbFIELD(3).IsMonitored := 1;
      tbFIELD(3).AttrTypeId := 1;
      -----------------------
      tbFIELD(4).FieldName := 'CRDESUCA';
      tbFIELD(4).OldValue := to_char(:OLD.CRDESUCA);
      tbFIELD(4).NewValue := to_char(:NEW.CRDESUCA);
      tbFIELD(4).IsMonitored := 1;
      tbFIELD(4).AttrTypeId := 1;
      -----------------------
      tbFIELD(5).FieldName := 'CRDETIPR';
      tbFIELD(5).OldValue := to_char(:OLD.CRDETIPR);
      tbFIELD(5).NewValue := to_char(:NEW.CRDETIPR);
      tbFIELD(5).IsMonitored := 1;
      tbFIELD(5).AttrTypeId := 1;
      -----------------------
      tbFIELD(6).FieldName := 'CRDEVADE';
      tbFIELD(6).OldValue := to_char(:OLD.CRDEVADE);
      tbFIELD(6).NewValue := to_char(:NEW.CRDEVADE);
      tbFIELD(6).IsMonitored := 1;
      tbFIELD(6).AttrTypeId := 1;
      -----------------------
      tbFIELD(7).FieldName := 'CRDEUSID';
      tbFIELD(7).OldValue := to_char(:OLD.CRDEUSID);
      tbFIELD(7).NewValue := to_char(:NEW.CRDEUSID);
      tbFIELD(7).IsMonitored := 1;
      tbFIELD(7).AttrTypeId := 1;
      -----------------------
      tbFIELD(8).FieldName := 'CRDEFERE';
      If :OLD.CRDEFERE IS not null then
          tbFIELD(8).OldValue := to_char(:OLD.CRDEFERE, ut_date.fsbDATE_FORMAT);
      End if;
      If :NEW.CRDEFERE IS not null then
          tbFIELD(8).NewValue := to_char(:NEW.CRDEFERE, ut_date.fsbDATE_FORMAT);
      End if;
      tbFIELD(8).IsMonitored := 1;
      tbFIELD(8).AttrTypeId := 3;
      -----------------------
      tbFIELD(9).FieldName := 'CRDECOAP';
      tbFIELD(9).OldValue := to_char(:OLD.CRDECOAP);
      tbFIELD(9).NewValue := to_char(:NEW.CRDECOAP);
      tbFIELD(9).IsMonitored := 1;
      tbFIELD(9).AttrTypeId := 1;
      -----------------------
      tbFIELD(10).FieldName := 'CRDENUDE';
      tbFIELD(10).OldValue := to_char(:OLD.CRDENUDE);
      tbFIELD(10).NewValue := to_char(:NEW.CRDENUDE);
      tbFIELD(10).IsMonitored := 1;
      tbFIELD(10).AttrTypeId := 1;
      -----------------------
      tbFIELD(11).FieldName := 'CRDETISO';
      tbFIELD(11).OldValue := :OLD.CRDETISO;
      tbFIELD(11).NewValue := :NEW.CRDETISO;
      tbFIELD(11).IsMonitored := 1;
      tbFIELD(11).AttrTypeId := 2;
      -----------------------
      tbFIELD(12).FieldName := 'CRDECOBA';
      tbFIELD(12).OldValue := to_char(:OLD.CRDECOBA);
      tbFIELD(12).NewValue := to_char(:NEW.CRDECOBA);
      tbFIELD(12).IsMonitored := 1;
      tbFIELD(12).AttrTypeId := 1;
      -----------------------
      tbFIELD(13).FieldName := 'CRDEFEIN';
      If :OLD.CRDEFEIN IS not null then
          tbFIELD(13).OldValue := to_char(:OLD.CRDEFEIN, ut_date.fsbDATE_FORMAT);
      End if;
      If :NEW.CRDEFEIN IS not null then
          tbFIELD(13).NewValue := to_char(:NEW.CRDEFEIN, ut_date.fsbDATE_FORMAT);
      End if;
      tbFIELD(13).IsMonitored := 1;
      tbFIELD(13).AttrTypeId := 3;
      -----------------------
      tbFIELD(14).FieldName := 'CRDEFEFI';
      If :OLD.CRDEFEFI IS not null then
          tbFIELD(14).OldValue := to_char(:OLD.CRDEFEFI, ut_date.fsbDATE_FORMAT);
      End if;
      If :NEW.CRDEFEFI IS not null then
          tbFIELD(14).NewValue := to_char(:NEW.CRDEFEFI, ut_date.fsbDATE_FORMAT);
      End if;
      tbFIELD(14).IsMonitored := 1;
      tbFIELD(14).AttrTypeId := 3;
      -----------------------
      tbFIELD(15).FieldName := 'CRDEPRDE';
      tbFIELD(15).OldValue := to_char(:OLD.CRDEPRDE);
      tbFIELD(15).NewValue := to_char(:NEW.CRDEPRDE);
      tbFIELD(15).IsMonitored := 1;
      tbFIELD(15).AttrTypeId := 1;
      -----------------------
      tbFIELD(16).FieldName := 'CRDETIDE';
      tbFIELD(16).OldValue := :OLD.CRDETIDE;
      tbFIELD(16).NewValue := :NEW.CRDETIDE;
      tbFIELD(16).IsMonitored := 1;
      tbFIELD(16).AttrTypeId := 2;
      -----------------------

       IF  INSERTING  THEN 
             null; 
            CURRENT_EVEN_DESCvar:='INSERT';
            nuCampoInd := tbFIELD.first;
            loop
                exit when nuCampoInd IS null;
                IF tbFIELD(nuCampoInd).IsMonitored = 0 then
                   tbFIELD(nuCampoInd).OldValue := tbFIELD(nuCampoInd).NewValue;
                end if; 
                nuCampoInd := tbFIELD.next(nuCampoInd);
            END LOOP;

       end if; 
       IF  UPDATING  THEN 
             null; 
            CURRENT_EVEN_DESCvar:='UPDATE';
       end if; 
       IF  DELETING  THEN 
             null; 
            CURRENT_EVEN_DESCvar:='DELETE';
       end if; 

 IF  INSERTING  OR  DELETING  OR fblValHasChange THEN 

      ut_clob.Clear('sbXML_LOG_PREVI_Var');
      ut_clob.Clear('sbXML_LOG_ACTUAL_Var');
      ut_clob.Clear('sbXML_LOG_AditBYSTatement');
      ut_clob.Clear('sbXML_LOG_ADITIONAL');
      ut_clob.Clear('PREVIOUS_VALUESvar');
      ut_clob.Clear('ACTUAL_VALUESvar');
      ut_clob.Clear('VALUES_ADITIONAL');
      ut_clob.Clear('sbCampoAdicionVar');
      ut_clob.Clear('PREVIOUS_TEXTvar');
      ut_clob.Clear('CURRENT_TEXTvar');
      ut_clob.Clear('TEXTVar_ADITIONAL');
      ut_clob.Clear('sbTEXT_LOG_AditBYSTatement');

      -----Variables que contiene los valores actuales y anteriores de la entidad ----------------
      ut_clob.AddVarchar2('sbXML_LOG_PREVI_Var','<MODIFICACIONES>');
      ut_clob.AddVarchar2('sbXML_LOG_ACTUAL_Var','<MODIFICACIONES>');
      ut_clob.AddVarchar2('sbXML_LOG_ADITIONAL','<ADICIONALES>');

      ut_clob.AddVarchar2('PREVIOUS_VALUESvar','<?xml version="1.0" encoding="UTF-8" ?><MODIFICACIONES>');
      ut_clob.AddVarchar2('ACTUAL_VALUESvar','<?xml version="1.0" encoding="UTF-8" ?><MODIFICACIONES>');

      nuCampoInd := tbFIELD.first;
      LOOP 
           exit when nuCampoInd IS null;
           IF tbFIELD(nuCampoInd).IsMonitored = 1 then
               --Llena las variables para el XML_LOG_
               ut_clob.AddVarchar2('sbXML_LOG_PREVI_Var','<'||tbFIELD(nuCampoInd).FieldName||'>'||tbFIELD(nuCampoInd).OldValue||'</'||tbFIELD(nuCampoInd).FieldName||'>');
               ut_clob.AddVarchar2('sbXML_LOG_ACTUAL_Var','<'||tbFIELD(nuCampoInd).FieldName||'>'||tbFIELD(nuCampoInd).NewValue||'</'||tbFIELD(nuCampoInd).FieldName||'>');

               --Llena las variables para el PREVIOUS_VALUE y el ACTUAL_VALUES
               ut_clob.AddVarchar2('PREVIOUS_VALUESvar','<CAMPO><NOMBRE>'||tbFIELD(nuCampoInd).FieldName||'</NOMBRE><VALOR>'||tbFIELD(nuCampoInd).OldValue||'</VALOR></CAMPO>');
               ut_clob.AddVarchar2('ACTUAL_VALUESvar','<CAMPO><NOMBRE>'||tbFIELD(nuCampoInd).FieldName||'</NOMBRE><VALOR>'||tbFIELD(nuCampoInd).NewValue||'</VALOR></CAMPO>');

               IF (tbFIELD(nuCampoInd).AttrTypeId = 2 ) then 
                   --Si es varchar2, debe realizar un reemplazo.
                   ut_clob.AddVarchar2('PREVIOUS_TEXTvar',replace(tbFIELD(nuCampoInd).OldValue, '|',' ')||'|');
                   ut_clob.AddVarchar2('CURRENT_TEXTvar',replace(tbFIELD(nuCampoInd).NewValue, '|',' ')||'|');
               ELSE
                   --De lo contrario simplemente lo concatena.
                   ut_clob.AddVarchar2('PREVIOUS_TEXTvar',tbFIELD(nuCampoInd).OldValue||'|');
                   ut_clob.AddVarchar2('CURRENT_TEXTvar',tbFIELD(nuCampoInd).NewValue||'|');
               END IF;
           ELSE
               --Para los Campos NO Monitoreados, se llena en una variable para al final ajuntarlos a las variables base.
               blExistAditiDATA   := TRUE;
               ut_clob.AddVarchar2('sbXML_LOG_ADITIONAL','<'||tbFIELD(nuCampoInd).FieldName||'>'||tbFIELD(nuCampoInd).OldValue||'</'||tbFIELD(nuCampoInd).FieldName||'>');
               ut_clob.AddVarchar2('VALUES_ADITIONAL','<CAMPO_ADICIONAL><NOMBRE>'||tbFIELD(nuCampoInd).FieldName||'</NOMBRE><VALOR>'||tbFIELD(nuCampoInd).OldValue||'</VALOR></CAMPO_ADICIONAL>');
               IF (tbFIELD(nuCampoInd).AttrTypeId = 2 ) then 
                   --Si es varchar2, debe realizar un reemplazo.
                   ut_clob.AddVarchar2('TEXTVar_ADITIONAL',replace(tbFIELD(nuCampoInd).OldValue, '|',' ')||'|');
               ELSE
                   --De lo contrario simplemente lo concatena
                   ut_clob.AddVarchar2('TEXTVar_ADITIONAL',tbFIELD(nuCampoInd).OldValue||'|');
               END if;
           END if;
           nuCampoInd := tbFIELD.next(nuCampoInd);
      END LOOP;
      --Si existen Dats adicionales entonces los agrega, si no deja vacio
      If (blExistAditiDATA) then
          ut_clob.AddVarchar2('sbXML_LOG_ADITIONAL','</ADICIONALES>');
      else
          ut_clob.Clear('sbXML_LOG_ADITIONAL');
      END if;
      ut_clob.AddClob('sbXML_LOG_PREVI_Var',ut_clob.fsbGetClobData('sbXML_LOG_ADITIONAL'));
      ut_clob.AddVarchar2('sbXML_LOG_PREVI_Var','</MODIFICACIONES>');
      ut_clob.AddVarchar2('sbXML_LOG_ACTUAL_Var','</MODIFICACIONES>');

      ut_clob.AddClob('PREVIOUS_VALUESvar',ut_clob.fsbGetClobData('VALUES_ADITIONAL'));
      ut_clob.AddVarchar2('PREVIOUS_VALUESvar','</MODIFICACIONES>');
      ut_clob.AddVarchar2('ACTUAL_VALUESvar','</MODIFICACIONES>');

      ut_clob.AddClob('PREVIOUS_TEXTvar',ut_clob.fsbGetClobData('TEXTVar_ADITIONAL'));

      BEGIN
            --Se asigna a la variables XML_LOGvar lo obtenido por el xml de previos y actual XML_LOG
            ut_clob.Clear('XMLTYPE_CLOB');

            ut_clob.AddVarchar2('XMLTYPE_CLOB','<AU_LOG><PREVIOUS_VALUES>');
            ut_clob.AddClob('XMLTYPE_CLOB',ut_clob.fsbGetClobData('sbXML_LOG_PREVI_Var'));
            ut_clob.AddVarchar2('XMLTYPE_CLOB','</PREVIOUS_VALUES><ACTUAL_VALUES>');
            ut_clob.AddClob('XMLTYPE_CLOB',ut_clob.fsbGetClobData('sbXML_LOG_ACTUAL_Var'));
            ut_clob.AddVarchar2('XMLTYPE_CLOB','</ACTUAL_VALUES></AU_LOG>');

            XML_LOGvar:=xmltype(ut_clob.fsbGetClobData('XMLTYPE_CLOB'));
      EXCEPTION 
        when OTHERS then 
            --Si ocurre un Error en el XMLTYPE, es porque viene un caracter ' ó &
            --entonces se debe realizar el reemplazo para todos los campos varchar2 que tiene ese registro.
            ut_clob.Clear('sbXML_LOG_PREVI_Var');
            ut_clob.Clear('sbXML_LOG_ACTUAL_Var');
            ut_clob.Clear('sbXML_LOG_AditBYSTatement');
            ut_clob.Clear('sbXML_LOG_ADITIONAL');
            ut_clob.Clear('PREVIOUS_VALUESvar');
            ut_clob.Clear('ACTUAL_VALUESvar');
            ut_clob.Clear('VALUES_ADITIONAL');
            ut_clob.Clear('sbCampoAdicionVar');

            -----Variables que contiene los valores actuales y anteriores de la entidad ----------------
            ut_clob.AddVarchar2('sbXML_LOG_PREVI_Var','<MODIFICACIONES>');
            ut_clob.AddVarchar2('sbXML_LOG_ACTUAL_Var','<MODIFICACIONES>');
            ut_clob.AddVarchar2('sbXML_LOG_ADITIONAL','<ADICIONALES>');

            ut_clob.AddVarchar2('PREVIOUS_VALUESvar','<?xml version="1.0" encoding="UTF-8" ?><MODIFICACIONES>');
            ut_clob.AddVarchar2('ACTUAL_VALUESvar','<?xml version="1.0" encoding="UTF-8" ?><MODIFICACIONES>');

            nuCampoInd := tbFIELD.first;
            LOOP 
                 exit when nuCampoInd IS null;
                 IF tbFIELD(nuCampoInd).IsMonitored = 1 then
                     IF (tbFIELD(nuCampoInd).AttrTypeId = 2 ) then 
                           --Llena las variables para el XML_LOG_
                           ut_clob.AddVarchar2('sbXML_LOG_PREVI_Var','<'||tbFIELD(nuCampoInd).FieldName||'>'||replace(replace(tbFIELD(nuCampoInd).OldValue,'&','&amp;'),'<','&lt;')||'</'||tbFIELD(nuCampoInd).FieldName||'>');
                           ut_clob.AddVarchar2('sbXML_LOG_ACTUAL_Var','<'||tbFIELD(nuCampoInd).FieldName||'>'||replace(replace(tbFIELD(nuCampoInd).NewValue,'&','&amp;'),'<','&lt;')||'</'||tbFIELD(nuCampoInd).FieldName||'>');

                           --Llena las variables para el PREVIOUS_VALUE y el ACTUAL_VALUES
                           ut_clob.AddVarchar2('PREVIOUS_VALUESvar','<CAMPO><NOMBRE>'||tbFIELD(nuCampoInd).FieldName||'</NOMBRE><VALOR>'||replace(replace(tbFIELD(nuCampoInd).OldValue,'&','&amp;'),'<','&lt;')||'</VALOR></CAMPO>');
                           ut_clob.AddVarchar2('ACTUAL_VALUESvar','<CAMPO><NOMBRE>'||tbFIELD(nuCampoInd).FieldName||'</NOMBRE><VALOR>'||replace(replace(tbFIELD(nuCampoInd).NewValue,'&','&amp;'),'<','&lt;')||'</VALOR></CAMPO>');
                     ELSE
                           --Llena las variables para el XML_LOG_
                           ut_clob.AddVarchar2('sbXML_LOG_PREVI_Var','<'||tbFIELD(nuCampoInd).FieldName||'>'||tbFIELD(nuCampoInd).OldValue||'</'||tbFIELD(nuCampoInd).FieldName||'>');
                           ut_clob.AddVarchar2('sbXML_LOG_ACTUAL_Var','<'||tbFIELD(nuCampoInd).FieldName||'>'||tbFIELD(nuCampoInd).NewValue||'</'||tbFIELD(nuCampoInd).FieldName||'>');

                           --Llena las variables para el PREVIOUS_VALUE y el ACTUAL_VALUES
                           ut_clob.AddVarchar2('PREVIOUS_VALUESvar','<CAMPO><NOMBRE>'||tbFIELD(nuCampoInd).FieldName||'</NOMBRE><VALOR>'||tbFIELD(nuCampoInd).OldValue||'</VALOR></CAMPO>');
                           ut_clob.AddVarchar2('ACTUAL_VALUESvar','<CAMPO><NOMBRE>'||tbFIELD(nuCampoInd).FieldName||'</NOMBRE><VALOR>'||tbFIELD(nuCampoInd).NewValue||'</VALOR></CAMPO>');
                     END if;
                 ELSE
                     --Para los Campos NO Monitoreados, se llena en una variable para al final ajuntarlos a las variables base.
                     blExistAditiDATA   := TRUE;
                     IF (tbFIELD(nuCampoInd).AttrTypeId = 2 ) then 
                           ut_clob.AddVarchar2('sbXML_LOG_ADITIONAL','<'||tbFIELD(nuCampoInd).FieldName||'>'||replace(replace(tbFIELD(nuCampoInd).OldValue,'&','&amp;'),'<','&lt;')||'</'||tbFIELD(nuCampoInd).FieldName||'>');
                           ut_clob.AddVarchar2('VALUES_ADITIONAL','<CAMPO_ADICIONAL><NOMBRE>'||tbFIELD(nuCampoInd).FieldName||'</NOMBRE><VALOR>'||replace(replace(tbFIELD(nuCampoInd).OldValue,'&','&amp;'),'<','&lt;')||'</VALOR></CAMPO_ADICIONAL>');
                     ELSE
                           ut_clob.AddVarchar2('sbXML_LOG_ADITIONAL','<'||tbFIELD(nuCampoInd).FieldName||'>'||tbFIELD(nuCampoInd).OldValue||'</'||tbFIELD(nuCampoInd).FieldName||'>');
                           ut_clob.AddVarchar2('VALUES_ADITIONAL','<CAMPO_ADICIONAL><NOMBRE>'||tbFIELD(nuCampoInd).FieldName||'</NOMBRE><VALOR>'||tbFIELD(nuCampoInd).OldValue||'</VALOR></CAMPO_ADICIONAL>');
                     END if;
                 END if;
                 nuCampoInd := tbFIELD.next(nuCampoInd);
            END LOOP;
            --Si existen Dats adicionales entonces los agrega, si no deja vacio
            If (blExistAditiDATA) then
                ut_clob.AddVarchar2('sbXML_LOG_ADITIONAL','</ADICIONALES>');
            else
                ut_clob.Clear('sbXML_LOG_ADITIONAL');
            END if;
            ut_clob.AddClob('sbXML_LOG_PREVI_Var',ut_clob.fsbGetClobData('sbXML_LOG_ADITIONAL'));
            ut_clob.AddVarchar2('sbXML_LOG_PREVI_Var','</MODIFICACIONES>');
            ut_clob.AddVarchar2('sbXML_LOG_ACTUAL_Var','</MODIFICACIONES>');

            ut_clob.AddClob('PREVIOUS_VALUESvar',ut_clob.fsbGetClobData('VALUES_ADITIONAL'));
            ut_clob.AddVarchar2('PREVIOUS_VALUESvar','</MODIFICACIONES>');
            ut_clob.AddVarchar2('ACTUAL_VALUESvar','</MODIFICACIONES>');


            --Se asigna a la variables XML_LOGvar lo obtenido por el xml de previos y actual XML_LOG
            ut_clob.Clear('XMLTYPE_CLOB');

            ut_clob.AddVarchar2('XMLTYPE_CLOB','<AU_LOG><PREVIOUS_VALUES>');
            ut_clob.AddClob('XMLTYPE_CLOB',ut_clob.fsbGetClobData('sbXML_LOG_PREVI_Var'));
            ut_clob.AddVarchar2('XMLTYPE_CLOB','</PREVIOUS_VALUES><ACTUAL_VALUES>');
            ut_clob.AddClob('XMLTYPE_CLOB',ut_clob.fsbGetClobData('sbXML_LOG_ACTUAL_Var'));
            ut_clob.AddVarchar2('XMLTYPE_CLOB','</ACTUAL_VALUES></AU_LOG>');

            XML_LOGvar:=xmltype(ut_clob.fsbGetClobData('XMLTYPE_CLOB'));
      END;

AUDIT_POLICY_LOG_IDvar:=au_bosequence.NextAU_AUDIT_POLICY_LOG;
 INSERT INTO AU_AUDIT_POLICY_LOG  ( 
AUDIT_POLICY_LOG_ID,
      AUDIT_POLICY_ID,
      AUDIT_LOG_ID,
      CURRENT_EXEC_ID,
      CURRENT_EXEC_NAME,
      CURRENT_MENU_NAME,
      CURRENT_SESSION_ID,
      CURRENT_USER_ID,
      CURRENT_USER_MASK,
      CURRENT_TERMINAL,
      CURRENT_TERM_IP_ADDR,
      CURRENT_DATE,
      CURRENT_TABLE_NAME,
      CURRENT_EVEN_DESC,
      CURRENT_PROGRAM,
      CURRENT_ACTION,
      CURRENT_MODULE,
      PREVIOUS_VALUES,
      ACTUAL_VALUES,
      RECORD_ROWID,
      XML_LOG,
      PREVIOUS_TEXT,
      CURRENT_TEXT,
      CURRENT_FIELD_NAME,
      EXTERNAL_ID) 
 VALUES 
 ( 
      AUDIT_POLICY_LOG_IDvar,
      AUDIT_POLICY_IDvar,
      AUDIT_LOG_IDvar,
      AU_BOSystem.getSystemProcessID,
      AU_BOSystem.getSystemProcessName,
      AU_BOSystem.getSystemProcessMenuName,
      AU_BOSystem.getSystemSessionID,
      AU_BOSystem.getSystemUserID,
      AU_BOSystem.getSystemUserMask,
      AU_BOSystem.getSystemUserTerminal,
      AU_BOSystem.getSystemUserIPAddress,
      SYSTIMESTAMP,
      CURRENT_TABLE_NAMEvar,
      CURRENT_EVEN_DESCvar,
      AU_BOSystem.getCurrentProgram,
      AU_BOSystem.GetAction,
      AU_BOSystem.getModule,
      ut_clob.fsbGetClobData('PREVIOUS_VALUESvar'),
      ut_clob.fsbGetClobData('ACTUAL_VALUESvar'),
      :new.rowid,
      XML_LOGvar,
      ut_clob.fsbGetClobData('PREVIOUS_TEXTvar'),
      ut_clob.fsbGetClobData('CURRENT_TEXTvar'),
      CURRENT_FIELD_NAMEvar,
      EXTERNAL_IDvar
) ;

    -- sends e-mail notifications
      AU_BOAdminAuditorias.NotifyByMail(AUDIT_POLICY_LOG_IDvar);

 end if; /* END if conditional*/
EXCEPTION 
      WHEN EX.CONTROLLED_ERROR THEN 
            RAISE EX.CONTROLLED_ERROR; 
      WHEN others THEN 
            errors.seterror; 
            RAISE EX.CONTROLLED_ERROR; 
END;
/
