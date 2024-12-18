column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'DD-MM-YYYY hh:mi:ss p.m.') fecha_inicio from dual;

declare

  cursor cuDuplicadoKiosko is
    select mp.package_id Solicitud
      from open.mo_packages mp
     where mp.package_type_id = 100342
       and mp.motive_status_id = 13
       and mp.package_id in (220742519)
     group by mp.package_id;

  rfDuplicadoKiosko cuDuplicadoKiosko%rowtype;

  dtFechaSistema date := sysdate;

  current_table_namevar MO_PACKAGE_CHNG_LOG.CURRENT_TABLE_NAME%type := 'MO_PACKAGES';
  current_event_idvar   MO_PACKAGE_CHNG_LOG.CURRENT_EVENT_ID%type := ge_boconstants.UPDATE_;
  current_even_descvar  MO_PACKAGE_CHNG_LOG.CURRENT_EVEN_DESC%type := 'UPDATE';
  o_motive_status_idvar MO_PACKAGE_CHNG_LOG.o_motive_status_id%TYPE;
  sbComment CONSTANT VARCHAR2(200) := 'SE ATIENDE SOLICITUD CON EL CASO OSF-3673';
  cust_care_reques_numvar MO_PACKAGE_CHNG_LOG.CUST_CARE_REQUES_NUM%type := null;
  package_type_idvar      MO_PACKAGE_CHNG_LOG.PACKAGE_TYPE_ID%type := null;
  package_idvar           MO_PACKAGE_CHNG_LOG.PACKAGE_ID%type := null;

begin

  for rfDuplicadoKiosko in cuDuplicadoKiosko loop
  
    begin
    
      update open.mo_packages mp
         set mp.motive_status_id = 14, mp.attention_date = dtFechaSistema
       where mp.package_id = rfDuplicadoKiosko.Solicitud
         and mp.motive_status_id = 13;
    
      update open.mo_motive mm
         set mm.motive_status_id   = 11,
             mm.attention_date     = dtFechaSistema,
             mm.status_change_date = dtFechaSistema
       where mm.package_id = rfDuplicadoKiosko.Solicitud
         and mm.motive_status_id = 1;
    
      -- Adiciona log de cambio de estado de la solicitud
      package_idvar           := rfDuplicadoKiosko.Solicitud;
      cust_care_reques_numvar := damo_packages.fsbgetcust_care_reques_num(package_idvar,
                                                                          null);
      package_type_idvar      := damo_packages.fnugetpackage_type_id(package_idvar,
                                                                     null);
      o_motive_status_idvar   := damo_packages.fnugetmotive_status_id(package_idvar,
                                                                      null);
    
      INSERT INTO MO_PACKAGE_CHNG_LOG
        (CURRENT_USER_ID,
         CURRENT_USER_MASK,
         CURRENT_TERMINAL,
         CURRENT_TERM_IP_ADDR,
         CURRENT_DATE,
         CURRENT_TABLE_NAME,
         CURRENT_EXEC_NAME,
         CURRENT_SESSION_ID,
         CURRENT_EVENT_ID,
         CURRENT_EVEN_DESC,
         CURRENT_PROGRAM,
         CURRENT_MODULE,
         CURRENT_CLIENT_INFO,
         CURRENT_ACTION,
         PACKAGE_CHNG_LOG_ID,
         PACKAGE_ID,
         CUST_CARE_REQUES_NUM,
         PACKAGE_TYPE_ID,
         O_MOTIVE_STATUS_ID,
         N_MOTIVE_STATUS_ID)
      VALUES
        (AU_BOSystem.getSystemUserID,
         AU_BOSystem.getSystemUserMask,
         ut_session.getTERMINAL,
         ut_session.getIP,
         ut_date.fdtSysdate,
         current_table_namevar,
         AU_BOSystem.getSystemProcessName,
         ut_session.getSESSIONID,
         current_event_idvar,
         current_even_descvar,
         ut_session.getProgram || '-' || SBCOMMENT,
         ut_session.getModule,
         ut_session.GetClientInfo,
         ut_session.GetAction,
         MO_BOSEQUENCES.fnuGetSeq_MO_PACKAGE_CHNG_LOG,
         package_idvar,
         cust_care_reques_numvar,
         package_type_idvar,
         13,
         14);
    
      commit;
      dbms_output.put_line('Se cambia estado de solicitud y motivo del duplicado Kiosko [' ||
                           rfDuplicadoKiosko.Solicitud || ']');
    exception
      when others then
        rollback;
        dbms_output.put_line('Error. No se cambia esatdo de solicitud y motivo de la venta [' ||
                             rfDuplicadoKiosko.Solicitud || '] - ' ||
                             sqlerrm);
    end;
  
  end loop;

end;
/

select to_char(sysdate,'DD-MM-YYYY hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/