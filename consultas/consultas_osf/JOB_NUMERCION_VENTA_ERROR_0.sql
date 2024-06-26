declare

  nuErrorCode    NUMBER;
  sbErrorMessage VARCHAR2(4000);

  cursor cunumeracionventa271 is
    SELECT lm.package_id,
           lm.action_id,
           p.document_type_id,
           p.document_key,
           el.message Mensaje
      FROM OPEN.MO_WF_PACK_INTERFAC LM,
           OPEN.GE_EXECUTOR_LOG     EL,
           OPEN.MO_PACKAGES         P
     WHERE LM.EXECUTOR_LOG_ID = EL.EXECUTOR_LOG_ID
       AND P.PACKAGE_ID = LM.PACKAGE_ID
       and lm.action_id = 76
       AND LM.STATUS_ACTIVITY_ID = 4
       AND P.PACKAGE_TYPE_ID IN (271)
       and p.document_type_id = 1;

  rfcunumeracionventa271 cunumeracionventa271%rowtype;

  cursor cunumeracionventa100229 is
    SELECT lm.package_id,
           lm.action_id,
           p.document_type_id,
           p.document_key,
           el.message Mensaje
      FROM OPEN.MO_WF_PACK_INTERFAC LM,
           OPEN.GE_EXECUTOR_LOG     EL,
           OPEN.MO_PACKAGES         P
     WHERE LM.EXECUTOR_LOG_ID = EL.EXECUTOR_LOG_ID
       AND P.PACKAGE_ID = LM.PACKAGE_ID
       and lm.action_id = 8150
       AND LM.STATUS_ACTIVITY_ID = 4
       AND P.PACKAGE_TYPE_ID IN (100229)
       and p.document_type_id = 1;

  rfcunumeracionventa100229 cunumeracionventa100229%rowtype;

  cursor cunumeracionventaAnulada is
    SELECT lm.package_id,
           lm.action_id,
           p.document_type_id,
           p.document_key,
           el.message Mensaje
      FROM OPEN.MO_WF_PACK_INTERFAC LM,
           OPEN.GE_EXECUTOR_LOG     EL,
           OPEN.MO_PACKAGES         P
     WHERE LM.EXECUTOR_LOG_ID = EL.EXECUTOR_LOG_ID
       AND P.PACKAGE_ID = LM.PACKAGE_ID
       and lm.action_id = 47
          --AND LM.STATUS_ACTIVITY_ID = 4
       AND P.PACKAGE_TYPE_ID IN (9)
       and p.document_type_id = 1;

  rfcunumeracionventaAnulada cunumeracionventaAnulada%rowtype;

begin

  dbms_output.put_line('Numeracion Formulario Venta 271');
  for rfcunumeracionventa271 in cunumeracionventa271 loop
    begin
      /*update open.fa_histcodi h
         set h.hicdesta = 'P'
       WHERE h.hicdnume = rfcunumeracionventa.document_key
         and h.hicdtico = rfcunumeracionventa.document_type_id
         and h.hicdesta = 'A';
      commit;*/
      dbms_output.put_line('Actualizacion de estado A o L al estado P para la venta ' ||
                           rfcunumeracionventa271.document_key ||
                           ' de tipo ' ||
                           rfcunumeracionventa271.document_type_id ||
                           ' - Mensaje[' || rfcunumeracionventa271.Mensaje || ']');
    exception
      when OTHERS then
        --Errors.setError;
        --Errors.getError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('error onuErrorCode: ' || nuErrorCode);
        dbms_output.put_line('error osbErrorMess: ' || sbErrorMessage ||
                             ' - ' || sqlerrm);
        rollback;
      
    end;
  
  end loop;

  ------------------------------------
  dbms_output.put_line(' ');
  dbms_output.put_line('Numeracion Formulario Venta 100229');
  for rfcunumeracionventa100229 in cunumeracionventa100229 loop
    begin
      /*update open.fa_histcodi h
         set h.hicdesta = 'P'
       WHERE h.hicdnume = rfcunumeracionventa.document_key
         and h.hicdtico = rfcunumeracionventa.document_type_id
         and h.hicdesta = 'A';
      commit;*/
      dbms_output.put_line('Actualizacion de estado A o L al estado P para la venta ' ||
                           rfcunumeracionventa100229.document_key ||
                           ' de tipo ' ||
                           rfcunumeracionventa100229.document_type_id ||
                           ' - Mensaje[' ||
                           rfcunumeracionventa100229.Mensaje || ']');
    exception
      when OTHERS then
        --Errors.setError;
        --Errors.getError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('error onuErrorCode: ' || nuErrorCode);
        dbms_output.put_line('error osbErrorMess: ' || sbErrorMessage ||
                             ' - ' || sqlerrm);
        rollback;
      
    end;
  
  end loop;

  -----------------------------
  dbms_output.put_line(' ');
  dbms_output.put_line('Solicitud Anuladas relacionadas a Numeracion Formulario Venta');
  for rfcunumeracionventaAnulada in cunumeracionventaAnulada loop
    begin
      /*update open.fa_histcodi h
         set h.hicdesta = 'P'
       WHERE h.hicdnume = rfcunumeracionventa.document_key
         and h.hicdtico = rfcunumeracionventa.document_type_id
         and h.hicdesta = 'A';
      commit;*/
      dbms_output.put_line('Actualizacion de estado A al estado P para la venta ' ||
                           rfcunumeracionventaAnulada.document_key ||
                           ' de tipo ' ||
                           rfcunumeracionventaAnulada.document_type_id ||
                           ' - Mensaje[' ||
                           rfcunumeracionventaAnulada.Mensaje || ']');
    exception
      when OTHERS then
        --Errors.setError;
        --Errors.getError(nuErrorCode, sbErrorMessage);
        dbms_output.put_line('error onuErrorCode: ' || nuErrorCode);
        dbms_output.put_line('error osbErrorMess: ' || sbErrorMessage ||
                             ' - ' || sqlerrm);
        rollback;
      
    end;
  
  end loop;

exception
  when others then
    --Errors.setError;
    --Errors.getError(nuErrorCode, sbErrorMessage);
    dbms_output.put_line('error onuErrorCode: ' || nuErrorCode);
    dbms_output.put_line('error osbErrorMess: ' || sbErrorMessage || ' - ' ||
                         sqlerrm);
    rollback;
  
end;
