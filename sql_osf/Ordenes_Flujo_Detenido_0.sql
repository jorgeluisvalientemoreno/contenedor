declare
  -- Local variables here
  Cursor cuinrmo Is
    Select h.request_number_origi,
           h.interface_history_id,
           h.last_mess_code_error || ' - ' || h.last_mess_desc_error ultimo_error,
           h.status_id || ' - ' ||
           open.dain_status.fsbgetdescription(h.status_id) estado,
           inserting_date,
           p.package_id
    
      From open.in_interface_history h,
           open.wf_instance          w,
           open.mo_packages          p
     Where h.status_id = '9'
       And h.request_number_origi = w.instance_id
       And w.parent_external_id = p.package_id
       And p.package_type_id In (100237)
    -- And rownum <= 1
     Order By h.inserting_date Desc;

  nupaso          Varchar2(20);
  onuerror        Varchar2(50);
  osberrormessage Varchar2(4000);
  exerror Exception;

begin
  -- Test statements here
  For reginrmo In cuinrmo Loop
    osberrormessage := 761; --Null;
    Begin
      --Se reenvia la actividad al flujo
      "OPEN".IN_BOFW_INRMO_PB.PROCESSHISTORY(reginrmo.interface_history_id,
                                             0,
                                             0,
                                             onuerror,
                                             osberrormessage);
    
      --valido si hay error y lo registro en el LOG correspondiente.
      If osberrormessage Is Not Null Then
        --Inserto el registro en el LOG
      
        dbms_output.put_line(reginrmo.package_id || '|' || osberrormessage);
      
      End If;
    
    Exception
      When Others Then
        dbms_output.put_line(sqlerrm);
    End;
  End Loop;
end;
/
