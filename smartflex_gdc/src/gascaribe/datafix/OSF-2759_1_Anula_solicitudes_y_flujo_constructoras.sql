column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
Declare

 Cursor CuMo_packages is
  select m.package_id from OPEN.mo_packages m
  WHERE package_id in (214339471, 214339685, 214339749)
    AND motive_status_id not in (14, dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA'))
    AND NOT EXISTS (select 1 
                    from open.or_order_activity oa 
                         inner join open.or_order o  ON oa.order_id = o.order_id 
                                                    AND o.order_status_id not in (8, 12)
                         left join open.ge_causal gc ON o.causal_id = gc.causal_id
                    where oa.package_id in (214339471, 214339685, 214339749) 
                      and nvl(gc.class_causal_id,0) <> 1);
 
  --
  sbComment               CONSTANT VARCHAR2(200) := 'SE ANULA ORDEN CON EL CASO OSF-2759';
  nuPackage               NUMBER;
  nuPlanId                wf_instance.instance_id%type;
  nuEstado                NUMBER;
  package_idvar           MO_PACKAGE_CHNG_LOG.PACKAGE_ID%type := null;
  cust_care_reques_numvar MO_PACKAGE_CHNG_LOG.CUST_CARE_REQUES_NUM%type := null;
  package_type_idvar      MO_PACKAGE_CHNG_LOG.PACKAGE_TYPE_ID%type := null;
  o_motive_status_idvar   MO_PACKAGE_CHNG_LOG.o_motive_status_id%TYPE; 
  current_table_namevar   MO_PACKAGE_CHNG_LOG.CURRENT_TABLE_NAME%type := 'MO_PACKAGES';
  current_event_idvar     MO_PACKAGE_CHNG_LOG.CURRENT_EVENT_ID%type := ge_boconstants.UPDATE_;
  current_even_descvar    MO_PACKAGE_CHNG_LOG.CURRENT_EVEN_DESC%type := 'UPDATE';
  exError                 EXCEPTION;

Begin
  
  For reg in CuMo_packages LOOP

    --
    nuPackage := reg.package_id;
    -- Se obtiene el plan de wf
    BEGIN
     nuPlanId := wf_boinstance.fnugetplanid(nuPackage, 17);
    EXCEPTION
     WHEN OTHERS THEN
       dbms_output.put_line('Error wf_boinstance.fnugetplanid : '||to_char(package_idvar)||' - '|| 'Plan_Id no Existe. SQLERRM: '|| SQLERRM );
       null;
    END;
     -- Anula el plan de wf
    IF nuPlanId is not null THEN
      BEGIN
        adm_person.pkgmanejosolicitudes.prcAnulaFlujo(nuPlanId);
      EXCEPTION
       WHEN OTHERS THEN
         dbms_output.put_line('Error mo_boannulment.annulwfplan : '||to_char(nuPlanId)||' - '|| SQLERRM );
         ROLLBACK;
         RAISE exError;
      END;
    END IF;     
    
    -- Cambio estado de la solicitud siempre y cuando no exista ninguna orden pendiente
    nuEstado := null;
    UPDATE OPEN.mo_packages
      SET motive_status_id = dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA'), 
          attention_date = sysdate
    WHERE package_id = nuPackage
      AND motive_status_id not in(14, dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA'))
      AND NOT EXISTS (select 1 
                      from open.or_order_activity oa 
                           inner join open.or_order o  ON oa.order_id = o.order_id 
                                                      AND o.order_status_id not in (8, 12)
                           left join open.ge_causal gc ON o.causal_id = gc.causal_id
                      where oa.package_id = nuPackage
                        and nvl(gc.class_causal_id,0) <> 1)
    returning count(1) INTO nuEstado;

    IF (nvl(nuEstado,0) > 0) THEN
        dbms_output.put_line('Actualiza MO_PACKAGE: '||nuPackage||', estado '||dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA'));
        --nuTotSol := nuTotSol + 1;
        -- Adiciona log de cambio de estado de la solicitud
        package_idvar           := nuPackage;
        cust_care_reques_numvar := damo_packages.fsbgetcust_care_reques_num (nuPackage,null);
        package_type_idvar      := damo_packages.fnugetpackage_type_id (nuPackage, null);
        o_motive_status_idvar   := damo_motive.fnugetmotive_status_id (mo_bcpackages.fnugetmotiveid(nuPackage));

        INSERT INTO MO_PACKAGE_CHNG_LOG
            (
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
                o_motive_status_idvar,
                dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA')
            );     
    END IF; 
    --
    Commit;
    --
  End loop;                    
                      
                      
EXCEPTION
    WHEN exError THEN
        rollback;
        dbms_output.put_line('Error Anulando flujo de la solicitud : '||nuPackage||', '||SQLERRM);
    WHEN OTHERS THEN
        rollback;
        dbms_output.put_line('Error Anulando la solicitud : '||nuPackage||', '||SQLERRM);
End;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/