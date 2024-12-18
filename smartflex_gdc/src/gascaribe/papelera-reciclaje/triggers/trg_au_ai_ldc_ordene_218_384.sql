CREATE OR REPLACE TRIGGER   TRG_AU_AI_LDC_ORDENE_218_384 AFTER INSERT OR UPDATE OR DELETE ON  LDC_ORDENES_OFERTADOS_REDES
  REFERENCING   OLD   AS   OLD   NEW   AS   NEW  
 FOR EACH ROW 
 DECLARE 
AUDIT_POLICY_IDvar AU_AUDIT_POLICY_LOG.AUDIT_POLICY_ID%type := 218;
AUDIT_LOG_IDvar AU_LOG_POLICY.AUDIT_LOG_ID%type := 384;
AUDIT_POLICY_LOG_IDvar AU_AUDIT_POLICY_LOG.AUDIT_POLICY_LOG_ID%type :=null;
CURRENT_TABLE_NAMEvar AU_AUDIT_POLICY_LOG.CURRENT_TABLE_NAME%type := 'LDC_ORDENES_OFERTADOS_REDES';
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

      tbFIELD(1).FieldName := 'ORDEN_NIETA';
      tbFIELD(1).OldValue := to_char(:OLD.ORDEN_NIETA);
      tbFIELD(1).NewValue := to_char(:NEW.ORDEN_NIETA);
      tbFIELD(1).IsMonitored := 1;
      tbFIELD(1).AttrTypeId := 1;
      -----------------------
      tbFIELD(2).FieldName := 'METRO_LINEAL';
      tbFIELD(2).OldValue := to_char(:OLD.METRO_LINEAL);
      tbFIELD(2).NewValue := to_char(:NEW.METRO_LINEAL);
      tbFIELD(2).IsMonitored := 1;
      tbFIELD(2).AttrTypeId := 1;
      -----------------------
      tbFIELD(3).FieldName := 'ORDEN_PADRE';
      tbFIELD(3).OldValue := to_char(:OLD.ORDEN_PADRE);
      tbFIELD(3).NewValue := to_char(:NEW.ORDEN_PADRE);
      tbFIELD(3).IsMonitored := 1;
      tbFIELD(3).AttrTypeId := 1;
      -----------------------
      tbFIELD(4).FieldName := 'ORDEN_HIJA';
      tbFIELD(4).OldValue := to_char(:OLD.ORDEN_HIJA);
      tbFIELD(4).NewValue := to_char(:NEW.ORDEN_HIJA);
      tbFIELD(4).IsMonitored := 1;
      tbFIELD(4).AttrTypeId := 1;
      -----------------------
      tbFIELD(5).FieldName := 'PRESUPUESTO_OBRA';
      tbFIELD(5).OldValue := to_char(:OLD.PRESUPUESTO_OBRA);
      tbFIELD(5).NewValue := to_char(:NEW.PRESUPUESTO_OBRA);
      tbFIELD(5).IsMonitored := 1;
      tbFIELD(5).AttrTypeId := 1;
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
