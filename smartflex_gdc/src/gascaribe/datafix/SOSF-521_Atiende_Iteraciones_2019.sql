declare
  cursor cugetsolicitud is
  select package_id,request_date  
    from open.mo_packages 
  where package_id in (90243698,
109648163,
109546920,
109546048,
109545380,
109546806,
109540725,
100812883,
100061181,
96230895,
116159046,
106461025,
106203137,
106192495,
105897322,
105764817,
105517237,
105397937,
98921783,
98918223,
97328673,
96983315,
96967663,
96882003,
96780658,
95906488,
95904519,
95874641,
95641998,
93560132,
94050917,
94061210,
94065143,
94291291,
94559102,
94564719,
94660590,
94667162,
94753496,
94866699,
94871330,
94876357,
94967665,
94969569,
95194200,
95202797,
95203294,
95206376,
95213898,
95293681,
95329284,
95337399,
95441650,
124227782
)
   and motive_status_id = 13;
  
  nuPlanId number;
  sbmensaje varchar2(4000);
  nuError  number;
  nuCantFlujos  number;
  CURRENT_TABLE_NAMEvar MO_PACKAGE_CHNG_LOG.CURRENT_TABLE_NAME%type := 'MO_PACKAGES';
  CURRENT_EVENT_IDvar MO_PACKAGE_CHNG_LOG.CURRENT_EVENT_ID%type := ge_boconstants.UPDATE_;
  CURRENT_EVEN_DESCvar MO_PACKAGE_CHNG_LOG.CURRENT_EVEN_DESC%type := 'UPDATE';
  sbComment 		VARCHAR2(4000):='Se cambia estado a atendido por SOSF-521';
  PACKAGE_IDvar MO_PACKAGE_CHNG_LOG.PACKAGE_ID%type :=null;
  CUST_CARE_REQUES_NUMvar MO_PACKAGE_CHNG_LOG.CUST_CARE_REQUES_NUM%type :=null;
  PACKAGE_TYPE_IDvar MO_PACKAGE_CHNG_LOG.PACKAGE_TYPE_ID%type :=null;
  O_MOTIVE_STATUS_IDVar MO_PACKAGE_CHNG_LOG.o_motive_status_id%TYPE;
  
BEGIN
  For reg in cugetsolicitud loop
     
    UPDATE open.mo_packages
       SET motive_status_id = 14,
           attention_date   =  reg.request_date    
     WHERE package_id = reg.package_id;
   
     UPDATE open.mo_motive
       SET  motive_status_id   = 11,
            attention_date  =  reg.request_date       
     WHERE  package_id = reg.package_id;
     
     PACKAGE_IDvar:=reg.package_id;
     CUST_CARE_REQUES_NUMvar:=damo_packages.fsbgetcust_care_reques_num(reg.package_id,null);
     PACKAGE_TYPE_IDvar:= damo_packages.fnugetpackage_type_id(reg.package_id,null);
     O_MOTIVE_STATUS_IDVar :=  DAMO_MOTIVE.FNUGETMOTIVE_STATUS_ID(MO_BCPACKAGES.FNUGETMOTIVEID(reg.package_id));
     
     INSERT INTO MO_PACKAGE_CHNG_LOG  (
              CURRENT_USER_ID,
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
              N_MOTIVE_STATUS_ID
              )
           VALUES
           (
              AU_BOSystem.getSystemUserID,
              AU_BOSystem.getSystemUserMask,
              ut_session.getTERMINAL,
              ut_session.getIP,
              ut_date.fdtSysdate,
              CURRENT_TABLE_NAMEvar,
              AU_BOSystem.getSystemProcessName,
              ut_session.getSESSIONID,
              CURRENT_EVENT_IDvar,
              CURRENT_EVEN_DESCvar,
              ut_session.getProgram||'-'||SBCOMMENT,
              ut_session.getModule,
              ut_session.GetClientInfo,
              ut_session.GetAction,
              MO_BOSEQUENCES.fnuGetSeq_MO_PACKAGE_CHNG_LOG,
              PACKAGE_IDvar,
              CUST_CARE_REQUES_NUMvar,
              PACKAGE_TYPE_IDvar,
              O_MOTIVE_STATUS_IDVar,
              14
            ) ;
  
     -- Se obtiene el plan de wf
     BEGIN
       select plan_id into nuPlanId
         from open.wf_data_external
        where package_id = reg.package_id;
        
     --  nuPlanId := wf_boinstance.fnugetplanid(reg.package_id, 17);
     EXCEPTION
      WHEN OTHERS THEN 
       errors.seterror;
       errors.geterror(nuError, sbMensaje);           
       sbMensaje := 'error wf_boinstance.fnugetplanid : '||to_char(reg.package_id)||' - '||sbMensaje;
       dbms_output.put_line(sbMensaje); 
       rollback;
       continue;
     --  exit;
     END;
      -- anula el plan de wf siempre y cuando exista el flujo sino cambia el estado de este a Atendido
     select count(*) into nuCantFlujos
     from open.wf_data_external d, open.wf_instance i
     where d.package_id = reg.package_id
       and d.plan_id = i.plan_id;
       
     IF nuCantFlujos > 1 then 
      BEGIN
       mo_boannulment.annulwfplan(nuPlanId);
      EXCEPTION
       WHEN OTHERS THEN
        errors.seterror;
        errors.geterror(nuError, sbMensaje);
        sbmensaje := 'error mo_boannulment.annulwfplan : '||to_char(nuPlanId)||' - '||sbMensaje;
        dbms_output.put_line(sbMensaje);
        rollback; 
       -- continue;
       -- exit;
      END;
     ELSE
       update open.wf_instance w 
          set w.status_id = 6
         where w.plan_id = nuPlanId;
         
       update open.WF_EXCEPTION_LOG e
          set e.status = 2
        where e.instance_id = nuPlanId;
         
         
     END IF; 
  commit;
  sbMensaje := 'Iteraccion actualizada :'||reg.package_id;
  dbms_output.put_line(sbMensaje); 
 
 End loop;
 
END;
/