column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  DECLARE
  /*
      Se anulan solicitud de venta constructora, motivos de solicitud, de ordenes de trabajo (Anuladas), 
      retiro de productos (16-Retirado sin instalación), cambio de estado de corte (110-Retirado sin instalación), 
      retiro de componentes de producto (18-Retirado sin instalación), actualización fecha de retiro. 
      Es contrato padre 67576712.
  */
      -- ID de la solicitud relacionada a los contratos a retirar
      cnuPackage_id   constant number := 0;
      -- Informacion general
      nuInfomrGen     constant open.or_order_comment.comment_type_id%type := 1277;

      -- Cursor para Anular ordenes de contratos definidos del CASO OSF-3355
      CURSOR cuOrderActiv is
        select oa.package_id, oa.subscription_id contrato, product_id PRODUCTO, oa.order_id ORDEN, o.task_type_id, o.order_status_id, o.causal_id CAUSAL, gc.class_causal_id
        from   open.or_order_activity oa 
        inner  join open.or_order o   on o.order_id = oa.order_id
        left   join open.ge_causal gc on gc.causal_id = o.causal_id
        where -- oa.package_id = cnuPackage_id -- cuando es una solicitud especifica
              oa.motive_id in (select motive_id
                                  from open.mo_motive m, open.mo_packages p
                                where m.package_id = p.package_id
                                  and p.package_type_id in (271,323)
                                  and m.subscription_id in (67576712, -- Contrato Padre
                                      --  contratos Hijos
                                      67579963,67579964,67579965,67579961,67579959,67579955,67579973,67580022,67580028,67580031,67580048,67580058,67580052,67580072,67580076,67580090,67580083,67580086,67580089,
                                      67580095,67580096,67580106,67580123,67580124,67580137,67580144,67580149,67580154,67580160,67580169,67580166,67580163,67580172,67580178,67580185,67580193,67580207,67580020,
                                      67579970,67579967,67579952,67579972,67579966,67579951,67579957,67579958,67579962,67579960,67579953,67580034,67579968,67579969,67580043,67580055,67580122,67580139,67580070,
                                      67580088,67580111,67580115,67580128,67580039,67580046,67580146,67580037,67580200,67580133,67579956,67580102,67580143,67579954,67579971,67580108,67580157,67580067,67580116,
                                      67580191,67580025,67580062,67580064,67580181,67580199,67580206,67580175,67580186,67580197,67580210,67580079));

      -- Cursor para anular las solicitudes 
      CURSOR cuMO_Packages is
        select distinct oa.package_id
        from   open.or_order_activity oa 
        inner  join open.or_order o   on o.order_id = oa.order_id
        left   join open.ge_causal gc on gc.causal_id = o.causal_id
        where -- oa.package_id = cnuPackage_id -- cuando es una solicitud especifica
              oa.motive_id in (select motive_id
                                  from open.mo_motive m, open.mo_packages p
                                where m.package_id = p.package_id
                                  and p.package_type_id in (271,323)
                                  and m.subscription_id in (67576712, -- Contrato Padre
                                      --  contratos Hijos
                                      67579963,67579964,67579965,67579961,67579959,67579955,67579973,67580022,67580028,67580031,67580048,67580058,67580052,67580072,67580076,67580090,67580083,67580086,67580089,
                                      67580095,67580096,67580106,67580123,67580124,67580137,67580144,67580149,67580154,67580160,67580169,67580166,67580163,67580172,67580178,67580185,67580193,67580207,67580020,
                                      67579970,67579967,67579952,67579972,67579966,67579951,67579957,67579958,67579962,67579960,67579953,67580034,67579968,67579969,67580043,67580055,67580122,67580139,67580070,
                                      67580088,67580111,67580115,67580128,67580039,67580046,67580146,67580037,67580200,67580133,67579956,67580102,67580143,67579954,67579971,67580108,67580157,67580067,67580116,
                                      67580191,67580025,67580062,67580064,67580181,67580199,67580206,67580175,67580186,67580197,67580210,67580079));

      -- Cursor de Person ID para el comentario
      CURSOR cuLoadData IS
          select person_id
          from ge_person
          where person_id = 13549; -- Pablo

      -- Registro de Comentario de la orden
      rcOR_ORDER_COMMENT  open.daor_order_comment.styor_order_comment;
      nuPersonID          open.ge_person.person_id%type;

      sbComment               VARCHAR2(4000) := 'SE ANULA ORDEN CON EL CASO OSF-3355';
      nuCommentType           number         := 1277;
      sbmensaje               VARCHAR2(4000);
      nuPlanId                wf_instance.instance_id%type;
      PACKAGE_IDvar           MO_PACKAGE_CHNG_LOG.PACKAGE_ID%type :=null;
      CUST_CARE_REQUES_NUMvar MO_PACKAGE_CHNG_LOG.CUST_CARE_REQUES_NUM%type :=null;
      PACKAGE_TYPE_IDvar      MO_PACKAGE_CHNG_LOG.PACKAGE_TYPE_ID%type :=null;
      O_MOTIVE_STATUS_IDVar   MO_PACKAGE_CHNG_LOG.o_motive_status_id%TYPE;
      CURRENT_TABLE_NAMEvar   MO_PACKAGE_CHNG_LOG.CURRENT_TABLE_NAME%type := 'MO_PACKAGES';
      CURRENT_EVENT_IDvar     MO_PACKAGE_CHNG_LOG.CURRENT_EVENT_ID%type := ge_boconstants.UPDATE_;
      CURRENT_EVEN_DESCvar    MO_PACKAGE_CHNG_LOG.CURRENT_EVEN_DESC%type := 'UPDATE';    

      nuErrorCode         number;
      nuCont              number;
      nuTotal             number;
      nuTotalsol          number;    
      nuOrderCommentID    number;
      sbErrorMessage      varchar2(4000);
      exError             EXCEPTION;

  BEGIN

      nuCont  := 0;
      nuTotal := 0;

      -- Carga de Person ID para el comentario
      open cuLoadData;
      fetch cuLoadData into nuPersonID;
      close cuLoadData;

      -- sino existe la persona pone la default de OPEN
      IF nuPersonID is null THEN
          nuPersonID := ge_bopersonal.fnugetpersonid;
      END IF;

      dbms_output.put_line('Codigo Tipo Comentario[' || nuInfomrGen || ']');
      dbms_output.put_line('Fecha sistema         [' || open.pkgeneralservices.fdtgetsystemdate || ']');
      dbms_output.put_line('Person ID             [' || nuPersonID || ']');

      -- Recorrer ordenes del contrato de venta a constructora
      FOR rcOrderActiv in cuOrderActiv LOOP
      
        nuTotal := nuTotal + 1;      
        
        -- Si la Orden no esta legalizada o anulada
        If nvl(rcOrderActiv.order_status_id,0) not in (8,12) then
          
          BEGIN
              dbms_output.put_line(chr(10)||'ANULA ORDEN: [' || rcOrderActiv.ORDEN || ']');

              -- or_boanullorder.anullorderwithoutval(rcOrderActiv.ORDEN,SYSDATE);
              -- Se reemplaza por el nuevo API para anular ordenes - GDGA 20/02/2024
              api_anullorder
              (
                  rcOrderActiv.ORDEN,
                  null,
                  null,
                  nuErrorCode,
                  sbErrorMessage
              );
              IF (nuErrorCode <> 0) THEN
                  dbms_output.put_line('Error en api_anullorder, Orden: '|| rcOrderActiv.ORDEN ||', '|| sbErrorMessage);
                  RAISE exError;
              END IF;

              -- Arma el registro con el comentario
              rcOR_ORDER_COMMENT.ORDER_COMMENT_ID := seq_or_order_comment.nextval;
              rcOR_ORDER_COMMENT.ORDER_COMMENT    := sbComment;
              rcOR_ORDER_COMMENT.ORDER_ID         := rcOrderActiv.ORDEN;
              rcOR_ORDER_COMMENT.COMMENT_TYPE_ID  := nuInfomrGen;
              rcOR_ORDER_COMMENT.REGISTER_DATE    := open.pkgeneralservices.fdtgetsystemdate;
              rcOR_ORDER_COMMENT.LEGALIZE_COMMENT := 'N';
              rcOR_ORDER_COMMENT.PERSON_ID        := nuPersonID;

              -- Inserta el registro en or_order_comment
              daor_order_comment.insrecord(rcOR_ORDER_COMMENT);

              -- Cambia el estado de la orden a Finalizada
              update open.or_order_activity
                set status = 'F'
              where order_id = rcOrderActiv.ORDEN;

              -- Se actualiza la fecha de retiro en el producto y componente - GDGA 15/02/2024
              update open.pr_product
                set product_status_id = 16,  -- Retirado sin instalacion
                    suspen_ord_act_id = null,
                    retire_date = sysdate
              where product_id = rcOrderActiv.PRODUCTO;

              -- Estado de corte
              pktblservsusc.updsesuesco(rcOrderActiv.PRODUCTO, 110); -- Retirado sin instalacion.

              -- Componente del producto
              update open.pr_component
                set component_status_id = 18  -- Retirado sin instalacion
              where product_id = rcOrderActiv.PRODUCTO;

              update open.compsesu
                set cmssescm = 18,   -- Retirado sin instalacion
                    cmssfere = sysdate
              where cmsssesu = rcOrderActiv.PRODUCTO;

              -- Cambia estado del motivo
              update open.mo_motive m
                set m.motive_status_id = 5 -- 
              where m.package_id = rcOrderActiv.package_id
                and m.product_id in rcOrderActiv.PRODUCTO;

              -- Componentes del motivo
              update mo_component m
                set m.motive_status_id = 26  -- Retirado sin Instalacion..
              where m.package_id = rcOrderActiv.package_id
                and m.product_id = rcOrderActiv.PRODUCTO;

              nuCont := nuCont + 1;
              --
              -- Asienta la transaccion
              COMMIT;            

          EXCEPTION
              WHEN OTHERS THEN
                  rollback;
                  dbms_output.put_line('Error Anulando Orden: '|| rcOrderActiv.ORDEN ||', SQLERRM: '|| SQLERRM );
          END;
          
        ELSE
          
          dbms_output.put_line('Orden: '|| rcOrderActiv.ORDEN ||' , Esta legalizada con Exito, no se puede anular.');
        
        END If;

      END LOOP;            
      
      dbms_output.put_line('Fin del Proceso. Ordenes Seleccionadas: '||nuTotal||', Ordenes Anuladas: '||nuCont);    
      
      -- Recorrer las solicitudes de venta constructora que se van a anular
      --         
      nuTotalsol := 0;
      For rcPackages in cuMO_Packages LOOP
        
          nuTotalsol := 1;
        
          Begin
              --Cambio estado de la solicitud
              UPDATE open.mo_packages
                SET motive_status_id = dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA')
              WHERE package_id IN (rcPackages.package_id);
          
              PACKAGE_IDvar           := rcPackages.package_id;
              CUST_CARE_REQUES_NUMvar := damo_packages.fsbgetcust_care_reques_num(rcPackages.package_id,null);
              PACKAGE_TYPE_IDvar      := damo_packages.fnugetpackage_type_id(rcPackages.package_id,null);
              O_MOTIVE_STATUS_IDVar   := DAMO_MOTIVE.FNUGETMOTIVE_STATUS_ID(MO_BCPACKAGES.FNUGETMOTIVEID(rcPackages.package_id));

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
                                                  dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA')
                                              );
              -- Cambio estado del motivo
              UPDATE open.mo_motive
                SET annul_date         = SYSDATE,
                    status_change_date = SYSDATE,
                    annul_causal_id    = ge_boparameter.fnuget('ANNUL_CAUSAL'),
                    motive_status_id   = 5,
                    causal_id          = 287
              WHERE package_id IN (rcPackages.package_id);
              -- Se obtiene el plan de wf
              BEGIN
                nuPlanId := wf_boinstance.fnugetplanid(rcPackages.package_id, 17);
              EXCEPTION
                WHEN OTHERS THEN
                dbms_output.put_line('error wf_boinstance.fnugetplanid : '||to_char(rcPackages.package_id)||' - '|| 'Plan_Id no Existe' || ' - ' || SQLERRM);
                null;
              END;
                -- anula el plan de wf
              IF nuPlanId is not null then
                BEGIN
                  mo_boannulment.annulwfplan(nuPlanId);
                EXCEPTION
                  WHEN OTHERS THEN
                    dbms_output.put_line('Error mo_boannulment.annulwfplan : '|| to_char(nuPlanId)||' - ' ||', SQLERRM: '|| SQLERRM );
              END;
              END if;            

              -- Asienta la transaccion
              COMMIT;

          EXCEPTION
              WHEN OTHERS THEN
                  rollback;
                  dbms_output.put_line('Error Anulando SOlicitud: '|| rcPackages.package_id ||', SQLERRM: '|| SQLERRM );
          END;

      END LOOP;

      dbms_output.put_line('Fin del Proceso. Total solicitudes anuladas: '||nuTotalsol);
      
  EXCEPTION
      WHEN OTHERS THEN
          dbms_output.put_line('Error del proceso. Ordenes Seleccionadas: '||nuTotal||', Ordenes Anuladas: '||nuCont ||', '||SQLERRM );
  END;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/