column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX OSF-2942');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
/*
    OSF-2942: Se solicita la anulación de las solicitud, los motivos de solicitud, ordenes de trabajo (Anuladas), 
    retiro de productos (16-Retirado sin instalación), cambio de estado de corte (110-Retirado sin instalación), 
    retiro de componentes de producto (18-Retirado sin instalación), actualización fecha de retiro, 
    de los 100 contratos y productos anexos que pertenece a la solicitud de venta 215593224 Cliente CONINSA S.A.S 
    contrato 67575809 producto 52876728. se deben anular porque hubo un error en el registro del plan comercial. 
    Esto no se puede anular por la herramienta porque son ventas fuera del módulo de constructoras.
    
    Esta actividad se ha desarrollado en anteriores casos tales como  
    SOSF-2292: ANULACION DE PRODUCTOS CONSTRUCTORA CONTRATO PADRE 67338501
    ANULACION DE PRODUCTOS CONSTRUCTORA CONTRATO PADRE 67338501 y 
    SOSF-2253-SOSF-2315: ANULACION DE PRODUCTOS CONSTRUCTORA CONTRATO PADRE 67308520 los pueden tomar como ejemplo

    Autor:    German Dario Guevara Alzate - GlobaMVM
    Fecha:    12/07/2024
*/
    -- Informacion general
    sbComment       CONSTANT VARCHAR2(200) := 'SE ANULA ORDEN CON EL CASO OSF-2942';
    nuCommentType   CONSTANT NUMBER        := 1277;

    -- Tipo de dato de tabla PL, donde el indice es el contrato y el valor es la solicitud
    TYPE tytbSusc IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
    tbSusc      tytbSusc;

    -- Cursor para traer las ordenes del contrato dado
    CURSOR cuOrderActiv
    (
        inuSusc     NUMBER,
        inuPackage  NUMBER
    )
    IS
        select oa.product_id       PRODUCTO,
               oa.order_id         ORDEN,
               gc.class_causal_id  CLASS_CAUSAL,
               (select sesuserv from open.servsusc where sesunuse = oa.product_id) SESUSERV
        from open.or_order_activity oa
            inner join open.or_order o   ON o.order_id  = oa.order_id
                                        AND o.order_status_id not in (8,12)
            left  join open.ge_causal gc ON o.causal_id = gc.causal_id
        where oa.package_id = inuPackage
          and oa.subscription_id = inuSusc;

    -- Cursor de Person ID para el comentario
    CURSOR cuLoadData IS
        select person_id
        from open.ge_person
        where person_id = 13549; -- Pablo
    
    -- Cursor para anular el flujo de la solicitud
    CURSOR cuErrorFlujo(nuSol number) is
        SELECT 'MOPRP' FORMA,
               P.PACKAGE_ID,
               P.MOTIVE_STATUS_ID,
               P.PACKAGE_TYPE_ID,
               P.REQUEST_DATE,
               EL.MESSAGE,
               NULL,
               EL.date_,
               NULL CODIGO_CAMBIAR
          FROM OPEN.MO_EXECUTOR_LOG_MOT LM,
               OPEN.GE_EXECUTOR_LOG     EL,
               OPEN.MO_PACKAGES         P
         WHERE LM.EXECUTOR_LOG_ID = EL.EXECUTOR_LOG_ID
           AND P.PACKAGE_ID = LM.PACKAGE_ID
           AND LM.STATUS_EXEC_LOG_ID = 4
           AND P.PACKAGE_ID = nuSol
        UNION ALL
        SELECT 'MOPWP' FORMA,
               P.PACKAGE_ID,
               P.MOTIVE_STATUS_ID,
               P.PACKAGE_TYPE_ID,
               P.REQUEST_DATE,
               EL.MESSAGE,
               NULL,
               EL.date_,
               NULL CODIGO_CAMBIAR
          FROM OPEN.MO_WF_PACK_INTERFAC LM,
               OPEN.GE_EXECUTOR_LOG     EL,
               OPEN.MO_PACKAGES         P
         WHERE LM.EXECUTOR_LOG_ID = EL.EXECUTOR_LOG_ID
           AND P.PACKAGE_ID = LM.PACKAGE_ID
           AND LM.STATUS_ACTIVITY_ID = 4
           AND P.PACKAGE_ID = nuSol
        UNION ALL
        SELECT 'MOPWM' FORMA,
               P.PACKAGE_ID,
               P.MOTIVE_STATUS_ID,
               P.PACKAGE_TYPE_ID,
               P.REQUEST_DATE,
               EL.MESSAGE,
               NULL,
               EL.date_,
               NULL CODIGO_CAMBIAR
          FROM OPEN.MO_WF_MOTIV_INTERFAC LM,
               OPEN.GE_EXECUTOR_LOG      EL,
               OPEN.MO_PACKAGES          P,
               OPEN.MO_MOTIVE            M
         WHERE LM.EXECUTOR_LOG_ID = EL.EXECUTOR_LOG_ID
           AND P.PACKAGE_ID = M.PACKAGE_ID
           AND M.MOTIVE_ID = LM.MOTIVE_ID
           AND P.PACKAGE_ID = nuSol
        UNION ALL
        SELECT 'MOPWC' FORMA,
               P.PACKAGE_ID,
               P.MOTIVE_STATUS_ID,
               P.PACKAGE_TYPE_ID,
               P.REQUEST_DATE,
               EL.MESSAGE,
               NULL,
               EL.date_,
               NULL CODIGO_CAMBIAR
          FROM OPEN.MO_WF_COMP_INTERFAC LM,
               OPEN.GE_EXECUTOR_LOG     EL,
               OPEN.MO_PACKAGES         P,
               OPEN.MO_COMPONENT        C
         WHERE LM.EXECUTOR_LOG_ID = EL.EXECUTOR_LOG_ID
           AND P.PACKAGE_ID = C.PACKAGE_ID
           AND C.COMPONENT_ID = LM.COMPONENT_ID
           AND LM.STATUS_ACTIVITY_ID = 4
           AND P.PACKAGE_ID = nuSol
        UNION ALL
        SELECT 'INRMO/WFEWF' FORMA,
               P.PACKAGE_ID,
               P.MOTIVE_STATUS_ID,
               P.PACKAGE_TYPE_ID,
               P.REQUEST_DATE,
               EL.MESSAGE_DESC,
               WF.INSTANCE_ID,
               EL.LOG_DATE,
               NULL CODIGO_CAMBIAR
          FROM OPEN.WF_INSTANCE      WF,
               OPEN.WF_EXCEPTION_LOG EL,
               OPEN.MO_PACKAGES      P,
               OPEN.WF_DATA_EXTERNAL DE
         WHERE WF.INSTANCE_ID = EL.INSTANCE_ID
           AND DE.PLAN_ID = WF.PLAN_ID
           AND DE.PACKAGE_ID = P.PACKAGE_ID
           AND WF.STATUS_ID = 9
           AND EL.STATUS = 1
           AND P.PACKAGE_ID = nuSol
        UNION ALL
        SELECT 'INRMO' FORMA,
               P.PACKAGE_ID,
               P.MOTIVE_STATUS_ID,
               P.PACKAGE_TYPE_ID,
               P.REQUEST_DATE,
               LAST_MESS_DESC_ERROR,
               W.INSTANCE_ID,
               I.INSERTING_DATE,
               I.INTERFACE_HISTORY_ID CODIGO_CAMBIAR
          FROM OPEN.IN_INTERFACE_HISTORY I,
               OPEN.WF_INSTANCE          W,
               OPEN.MO_PACKAGES          P,
               OPEN.WF_DATA_EXTERNAL     DE
         WHERE I.STATUS_ID = 9
           AND I.REQUEST_NUMBER_ORIGI = W.INSTANCE_ID
           AND DE.PLAN_ID = W.PLAN_ID
           AND DE.PACKAGE_ID = P.PACKAGE_ID
           AND P.PACKAGE_ID = nuSol;  

    rgErrorFlujo            cuErrorFlujo%rowtype;           
    rcOR_ORDER_COMMENT      open.daor_order_comment.styor_order_comment;
    nuPersonID              open.ge_person.person_id%type;
    package_idvar           MO_PACKAGE_CHNG_LOG.PACKAGE_ID%type := null;
    cust_care_reques_numvar MO_PACKAGE_CHNG_LOG.CUST_CARE_REQUES_NUM%type := null;
    package_type_idvar      MO_PACKAGE_CHNG_LOG.PACKAGE_TYPE_ID%type := null;
    current_table_namevar   MO_PACKAGE_CHNG_LOG.CURRENT_TABLE_NAME%type := 'MO_PACKAGES';
    current_event_idvar     MO_PACKAGE_CHNG_LOG.CURRENT_EVENT_ID%type := ge_boconstants.UPDATE_;
    current_even_descvar    MO_PACKAGE_CHNG_LOG.CURRENT_EVEN_DESC%type := 'UPDATE';
    o_motive_status_idvar   MO_PACKAGE_CHNG_LOG.o_motive_status_id%TYPE;    
    nuErrorCode             NUMBER;
    nuSusc                  NUMBER;
    nuCont                  NUMBER;
    nuTotal                 NUMBER;
    nuTotOrd                NUMBER;
    nuTotSol                NUMBER;
    nuTotPro                NUMBER;
    nuEstado                NUMBER;
    nuPackage               NUMBER;
    nuOrdenes               NUMBER;
    nuEstaCort              NUMBER;
    nuError                 NUMBER;
    nuPlanId                NUMBER;
    sbErrorMessage          VARCHAR2(4000);
    sbEstado                VARCHAR2(10);
    exError                 EXCEPTION;

BEGIN
    nuCont   := 0;
    nuTotal  := 0;
    nuTotOrd := 0;
    nuTotSol := 0;
    nuTotPro := 0;
    tbSusc.DELETE;

    -- tbSusc(SUSCCODI) := PACKAGE_ID 
    tbSusc(67577885) := 215593224;
    tbSusc(67577884) := 215593224;
    tbSusc(67577871) := 215593224;
    tbSusc(67577883) := 215593224;
    tbSusc(67577835) := 215593224;
    tbSusc(67577879) := 215593224;
    tbSusc(67577881) := 215593224;
    tbSusc(67577882) := 215593224;
    tbSusc(67577880) := 215593224;
    tbSusc(67577875) := 215593224;
    tbSusc(67577878) := 215593224;
    tbSusc(67577877) := 215593224;
    tbSusc(67577876) := 215593224;
    tbSusc(67577868) := 215593224;
    tbSusc(67577870) := 215593224;
    tbSusc(67577857) := 215593224;
    tbSusc(67577866) := 215593224;
    tbSusc(67577872) := 215593224;
    tbSusc(67577874) := 215593224;
    tbSusc(67577873) := 215593224;
    tbSusc(67577865) := 215593224;
    tbSusc(67577869) := 215593224;
    tbSusc(67577834) := 215593224;
    tbSusc(67577861) := 215593224;
    tbSusc(67577859) := 215593224;
    tbSusc(67577867) := 215593224;
    tbSusc(67577863) := 215593224;
    tbSusc(67577823) := 215593224;
    tbSusc(67577844) := 215593224;
    tbSusc(67577864) := 215593224;
    tbSusc(67577862) := 215593224;
    tbSusc(67577858) := 215593224;
    tbSusc(67577860) := 215593224;
    tbSusc(67577850) := 215593224;
    tbSusc(67577856) := 215593224;
    tbSusc(67577829) := 215593224;
    tbSusc(67577830) := 215593224;
    tbSusc(67577855) := 215593224;
    tbSusc(67577846) := 215593224;
    tbSusc(67577831) := 215593224;
    tbSusc(67577833) := 215593224;
    tbSusc(67577854) := 215593224;
    tbSusc(67577849) := 215593224;
    tbSusc(67577853) := 215593224;
    tbSusc(67577852) := 215593224;
    tbSusc(67577851) := 215593224;
    tbSusc(67577848) := 215593224;
    tbSusc(67577847) := 215593224;
    tbSusc(67577828) := 215593224;
    tbSusc(67577836) := 215593224;
    tbSusc(67577845) := 215593224;
    tbSusc(67577815) := 215593224;
    tbSusc(67577843) := 215593224;
    tbSusc(67577841) := 215593224;
    tbSusc(67577842) := 215593224;
    tbSusc(67577840) := 215593224;
    tbSusc(67577827) := 215593224;
    tbSusc(67577826) := 215593224;
    tbSusc(67577839) := 215593224;
    tbSusc(67577838) := 215593224;
    tbSusc(67577816) := 215593224;
    tbSusc(67577837) := 215593224;
    tbSusc(67577819) := 215593224;
    tbSusc(67577832) := 215593224;
    tbSusc(67577824) := 215593224;
    tbSusc(67577822) := 215593224;
    tbSusc(67577825) := 215593224;
    tbSusc(67577821) := 215593224;
    tbSusc(67577798) := 215593224;
    tbSusc(67577806) := 215593224;
    tbSusc(67577813) := 215593224;
    tbSusc(67577820) := 215593224;
    tbSusc(67577789) := 215593224;
    tbSusc(67577818) := 215593224;
    tbSusc(67577803) := 215593224;
    tbSusc(67577788) := 215593224;
    tbSusc(67577817) := 215593224;
    tbSusc(67577814) := 215593224;
    tbSusc(67577801) := 215593224;
    tbSusc(67577790) := 215593224;
    tbSusc(67577812) := 215593224;
    tbSusc(67577811) := 215593224;
    tbSusc(67577805) := 215593224;
    tbSusc(67577793) := 215593224;
    tbSusc(67577791) := 215593224;
    tbSusc(67577810) := 215593224;
    tbSusc(67577809) := 215593224;
    tbSusc(67577807) := 215593224;
    tbSusc(67577808) := 215593224;
    tbSusc(67577800) := 215593224;
    tbSusc(67577804) := 215593224;
    tbSusc(67577797) := 215593224;
    tbSusc(67577802) := 215593224;
    tbSusc(67577799) := 215593224;
    tbSusc(67577794) := 215593224;
    tbSusc(67577796) := 215593224;
    tbSusc(67577795) := 215593224;
    tbSusc(67577786) := 215593224;
    tbSusc(67577792) := 215593224;
    tbSusc(67577787) := 215593224;
    tbSusc(67575809) := 215593224;

    -- Carga de Person ID para el comentario
    open cuLoadData;
    fetch cuLoadData into nuPersonID;
    close cuLoadData;

    -- sino existe la persona pone la default de OPEN
    IF nuPersonID is null THEN
        nuPersonID := ge_bopersonal.fnugetpersonid;
    END IF;

    dbms_output.put_line('Inicia Proceso OSF-2942_Anular_Productos_Constructora');
    dbms_output.put_line('----------------------------------------------------------------------------');
    dbms_output.put_line('Codigo Tipo Comentario [' || nuCommentType || ']');
    dbms_output.put_line('Mensaje del Comentario [' || sbComment || ']');
    dbms_output.put_line('Person ID              [' || nuPersonID || ']');
    dbms_output.put_line('Fecha sistema          [' || open.pkgeneralservices.fdtgetsystemdate || ']');
    dbms_output.put_line('----------------------------------------------------------------------------');

    -- Total de registros de la coleccion
    nuTotal := tbSusc.COUNT;

    -- Primer registro
    nuSusc  := tbSusc.FIRST;

    -- Recorre la coleccion
    LOOP
        EXIT WHEN nuSusc IS NULL;
        nuPackage := tbSusc(nuSusc);
        dbms_output.put_line('Procesando contrato: ['||nuSusc||']');
        --Recorrer ordenes de venta de cada contrato x solicitud
        FOR rcOrderActiv in cuOrderActiv (nuSusc, nuPackage) LOOP
            nuTotOrd := nuTotOrd + 1;
            BEGIN
                dbms_output.put_line(chr(10)||'ANULA ORDEN: ['||rcOrderActiv.ORDEN||'] CONTRATO: ['||nuSusc||']');

                -- Si la Orden no esta legalizada con causal de exito, anula
                IF NVL(rcOrderActiv.CLASS_CAUSAL, 0) = 1 THEN
                    dbms_output.put_line('Contrato: '||nuSusc||', con Orden: '|| rcOrderActiv.ORDEN ||' Esta legalizada con Exito y No se puede Anular');
                    RAISE exError;
                END IF;

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
                    dbms_output.put_line('Error en api_anullorder, Contrato: '||nuSusc||', con Orden: '|| rcOrderActiv.ORDEN ||', '|| sbErrorMessage);
                    RAISE exError;
                END IF;

                -- Arma el registro con el comentario
                rcOR_ORDER_COMMENT.ORDER_COMMENT_ID := seq_or_order_comment.nextval;
                rcOR_ORDER_COMMENT.ORDER_COMMENT    := sbComment;
                rcOR_ORDER_COMMENT.ORDER_ID         := rcOrderActiv.ORDEN;
                rcOR_ORDER_COMMENT.COMMENT_TYPE_ID  := nuCommentType;
                rcOR_ORDER_COMMENT.REGISTER_DATE    := open.pkgeneralservices.fdtgetsystemdate;
                rcOR_ORDER_COMMENT.LEGALIZE_COMMENT := 'N';
                rcOR_ORDER_COMMENT.PERSON_ID        := nuPersonID;

                -- Inserta el registro en or_order_comment
                daor_order_comment.insrecord(rcOR_ORDER_COMMENT);

                -- Cambia el estado de la orden a Finalizada
                nuEstado := null;
                update open.or_order_activity
                  set status     = 'F',
                      final_date = sysdate
                where order_id = rcOrderActiv.ORDEN
                  and status <> 'F'
                returning order_activity_id INTO nuEstado;

                IF (nuEstado is not null) THEN
                    dbms_output.put_line('Actualiza OR_ORDER_ACTIVITY: '||nuEstado||', Estado F-finalizada OK');
                END IF;

                -- Se actualiza la fecha de retiro en el producto y componente
                nuEstado := null;
                update open.pr_product
                  set product_status_id = 16,  -- Retirado sin instalacion
                      suspen_ord_act_id = null,
                      retire_date       = sysdate
                where product_id = rcOrderActiv.PRODUCTO
                  and product_status_id <> 16
                returning product_id INTO nuEstado;

                IF (nuEstado is not null) THEN
                    dbms_output.put_line('Actualiza PR_PRODUCT product_id: '||nuEstado||', Estado del producto 16 Retirado OK');
                    nuTotPro := nuTotPro + 1;
                END IF;

                -- Valida servicio para asignar estado de corte
                -- 95:  Retiro para el tipo de producto 6121
                -- 110: Retirado sin instalacion para el tipo de producto 7014
                nuEstaCort := 110;                
                IF (rcOrderActiv.SESUSERV = 6121) THEN
                    nuEstaCort := 95;
                END IF;
                
                -- Estado de corte
                nuEstado := null;
                update open.servsusc
                  set sesuesco = nuEstaCort,
                      sesufere = sysdate
                where sesunuse = rcOrderActiv.PRODUCTO
                  and sesuesco <> nuEstaCort
                returning sesuesco INTO nuEstado;

                IF (nuEstado is not null) THEN
                    dbms_output.put_line('Actualiza SERVSUSC sesunuse: '||nuEstaCort||', estado de corte '||nuEstaCort);
                END IF;                
                
                dbms_output.put_line('Actualiza SERVSUSC sesunuse: '||rcOrderActiv.PRODUCTO||', estado de corte 110 OK');

                -- componente del producto
                nuEstado := null;
                update open.pr_component
                  set component_status_id = 18, -- Retirado sin instalacion
                      last_upd_date       = sysdate
                where product_id = rcOrderActiv.PRODUCTO
                  and component_status_id <> 18
                returning count(1) INTO nuEstado;

                IF (nvl(nuEstado,0) > 0) THEN
                    dbms_output.put_line('Actualiza PR_COMPONENT total: '||nuEstado||', estado del componente 18 OK');
                END IF;

                -- componente del producto
                nuEstado := null;
                update open.compsesu
                  set cmssescm = 18,            -- Retirado sin instalacion
                      cmssfere = sysdate
                where cmsssesu = rcOrderActiv.PRODUCTO
                  and cmssescm <> 18
                returning count(1) INTO nuEstado;

                IF (nvl(nuEstado,0) > 0) THEN
                    dbms_output.put_line('Actualiza COMPSESU total: '||nuEstado||', estado del componente 18 OK');
                END IF;

                -- Cambia estado del motivo
                nuEstado := null;
                update open.mo_motive m
                  set m.motive_status_id   = 5,
                      m.status_change_date = sysdate,
                      m.annul_date         = sysdate
                where m.package_id = nuPackage
                  and m.product_id in rcOrderActiv.PRODUCTO
                  and motive_status_id <> 5
                returning count(1) INTO nuEstado;

                IF (nvl(nuEstado,0) > 0) THEN
                    dbms_output.put_line('Actualiza MO_MOTIVE total: '||nuEstado||', estado del motivo 5 OK');
                END IF;

                -- Componentes del motivo
                nuEstado := null;
                update open.mo_component m
                  set m.motive_status_id   = 26,
                      m.status_change_date = sysdate,
                      m.annul_date         = sysdate
                where m.package_id = nuPackage
                  and m.product_id = rcOrderActiv.PRODUCTO
                  and motive_status_id <> 26
                returning count(1) INTO nuEstado;

                IF (nvl(nuEstado,0) > 0) THEN
                    dbms_output.put_line('Actualiza MO_COMPONENT total: '||nuEstado||', estado del componente 26 OK');
                END IF;

                nuCont := nuCont + 1;

                -- Asienta la transaccion
                commit;

            EXCEPTION
                WHEN exError THEN
                    rollback;
                WHEN OTHERS THEN
                    rollback;
                    dbms_output.put_line('Error: Contrato '||nuSusc||', con Orden: '|| rcOrderActiv.ORDEN ||', no se pudo Anular. SQLERRM: '|| SQLERRM );
            END;

        END LOOP;
        
        --Cambio estado de la solicitud siempre y cuando no exista ninguna orden pendiente
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
            nuTotSol := nuTotSol + 1;
            -- Adiciona log de cambio de estado de la solicitud
            package_idvar           := nuPackage;
            cust_care_reques_numvar := damo_packages.fsbgetcust_care_reques_num (nuPackage,null);
            package_type_idvar      := damo_packages.fnugetpackage_type_id (nuPackage, null);
            o_motive_status_idvar   := damo_motive.fnugetmotive_status_id (mo_bcpackages.fnugetmotiveid(nuPackage));

            INSERT INTO open.mo_package_chng_log
            (
                current_user_id,
                current_user_mask,
                current_terminal,
                current_term_ip_addr,
                current_date,
                current_table_name,
                current_exec_name,
                current_session_id,
                current_event_id,
                current_even_desc,
                current_program,
                current_module,
                current_client_info,
                current_action,
                package_chng_log_id,
                package_id,
                cust_care_reques_num,
                package_type_id,
                o_motive_status_id,
                n_motive_status_id
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
            COMMIT;
            
            nuError := 0;
            BEGIN
                nuPlanId := wf_boinstance.fnugetplanid(nuPackage, 17);
            EXCEPTION
                WHEN OTHERS THEN
                    rollback;
                    nuError := 1;
                    dbms_output.put_line('Error anulando plan solicitud|' || nuPackage || '|' || sqlerrm);
            END;
            
            -- Anula el plan de WF
            IF (NVL(nuPlanId,0) <> 0) THEN
                BEGIN
                    mo_boannulment.annulwfplan(nuPlanId);
                EXCEPTION
                    WHEN OTHERS THEN
                        rollback;
                        nuError := 0;
                END;
            END IF;
            
            IF nuError = 0 THEN
                IF cuErrorFlujo%isopen THEN
                    CLOSE cuErrorFlujo;
                END IF;
                OPEN cuErrorFlujo(nuPackage);
                FETCH cuErrorFlujo INTO rgErrorFlujo;
                IF cuErrorFlujo%notfound THEN
                    COMMIT;
                    dbms_output.put_line('SOLICITUD ANULADA SIN ERROR DE FLUJO|' ||nuPackage);
                ELSE
                    IF rgErrorFlujo.forma = 'INRMO' THEN
                        UPDATE open.in_interface_history i
                        SET i.status_id = 6
                        WHERE i.interface_history_id = rgErrorFlujo.codigo_cambiar;
                    END IF;
                    COMMIT;
                    dbms_output.put_line('SOLICITUD ANULADA CON ERROR DE FLUJO|' ||nuPackage);
                END IF;
                CLOSE cuErrorFlujo;
            END IF;           
            
        END IF;        

        -- Siguiente registro
        nuSusc := tbSusc.NEXT(nuSusc);
    END LOOP;

    tbSusc.DELETE;
    dbms_output.put_line('----------------------------------------------------------------------------');
    dbms_output.put_line('Fin del Proceso');
    dbms_output.put_line('Total Contratos: '||nuTotal);
    dbms_output.put_line('Ordenes Seleccionadas: '||nuTotOrd||',   Ordenes Anuladas:    '||nuCont);
    dbms_output.put_line('Solicitudes Anuladas:  '||nuTotSol||',   Productos retirados: '||nuTotPro);

EXCEPTION
    WHEN OTHERS THEN
        rollback;
        dbms_output.put_line('Error del proceso. Total Contratos: '||nuTotal||', Ordenes Selecc.: '||nuTotOrd||', Ordenes Anuladas: '||nuCont||', Solicitudes Anuladas: '||nuTotSol||', '||SQLERRM );
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/